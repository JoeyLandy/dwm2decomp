; ROM bank $0A: random encounters: encounter groups and grids, battle intro
; The annotated listing of this bank is build/listing/bank0a.asm.

SECTION "Bank 0A", ROMX[$4000], BANK[$0A]
    db $0a

FieldState_StepChecks_WriteMenuStateAndRAMGEtc::
    call FieldState_StepChecks_Sub01_QueueSoundEffect
    ld a, [wMenuState]
    inc a
    ld [wMenuState], a
    cp $05
    ret nz
    ld a, $0a
    ld [rRAMG], a
    ld a, [wMenuSubState]
    or a
    jr nz, .call_field_state_step_checks_sub01_load_sram
    call FieldState_StepChecks_Sub01_LoadSRAMRecordByte
    call FieldState_StepChecks_Sub01_LoadSRAMRecordByte_Sub01
    jr .check_status_field_step

.call_field_state_step_checks_sub01_load_sram:
    call FieldState_StepChecks_Sub01_LoadSRAMRecordByte_Sub02
    call FieldState_StepChecks_Sub01_LoadSRAMRecordByte_Sub01

.check_status_field_step:
    xor a
    ld [rRAMG], a
    ld a, [wStatusFieldStep]
    and $07
    jr z, .check_map_type
    ld a, $04
    ld [wTalkEventGroup], a
    xor a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ret

.check_map_type:
    ld a, [wMapType]
    bit 7, a
    jr nz, .set_mode_state_to_05
    ld a, $00
    ld [wModeState], a
    ret

.set_mode_state_to_05:
    ld a, $05
    ld [wModeState], a
    ret

FieldState_StepChecks_Sub01_LoadSRAMRecordByte_Sub01::
    ld a, [wStatusStepFlags]
    and $01
    ret z
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList

.loop:
    push bc
    ld a, [hl]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    bit 7, a
    jr nz, .next
    bit 0, a
    jr z, .next
    ld a, [hl]
    ld c, MON_MP
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, e
    or d
    jr z, .next
    ld a, e
    sub $01
    ld e, a
    ld a, d
    sbc $00
    ld d, a
    push hl
    ld a, [hl]
    ld c, MON_MP
    call SRAMRecordAddress
    ld a, e
    ld [hli], a
    ld a, d
    ld [hl], a
    pop hl

.next:
    inc hl
    pop bc
    dec b
    jr nz, .loop
    ret

; sets bit 7 of wFieldStepFlags (E-0114)
SetFieldStepFlagsBit7::
    ld a, [wFieldStepFlags]
    set 7, a
    ld [wFieldStepFlags], a
    ret

FieldState_StepChecks_Sub01_LoadSRAMRecordByte_Sub02::
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList

.loop:
    push bc
    ld a, [hl]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    bit 7, a
    jr nz, .next
    bit 2, a
    jr z, .next
    ld a, [hl]
    ld c, MON_HP
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, e
    sub $01
    ld e, a
    ld a, d
    sbc $00
    ld d, a
    bit 7, a
    jr nz, .call_set_field_step_flags_bit7
    or e
    jr nz, .skip

.call_set_field_step_flags_bit7:
    ld c, $01
    call SetFieldStepFlagsBit7
    ld a, [wPartyCount]
    sub b
    jr z, .check_status_field_step
    ld b, a

.loop2:
    sla c
    dec b
    jr nz, .loop2

.check_status_field_step:
    ld a, [wStatusFieldStep]
    or c
    ld [wStatusFieldStep], a
    push hl
    ld a, [hl]
    ld c, MON_STATUS
    call SRAMRecordAddress
    ld a, [hl]
    and $f3
    or $80
    ld [hl], a
    pop hl
    ld de, $0000

.skip:
    push hl
    ld a, [hl]
    ld c, MON_HP
    call SRAMRecordAddress
    ld a, e
    ld [hli], a
    ld a, d
    ld [hl], a
    pop hl

.next:
    inc hl
    pop bc
    dec b
    jr nz, .loop
    ret

FieldState_StepChecks_Sub01_LoadSRAMRecordByte::
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList

.loop:
    push bc
    ld a, [hl]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    bit 7, a
    jr nz, .next
    ld a, [hl]
    ld c, MON_HP
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, [wStatusFieldStep]
    bit 7, a
    jr nz, .check_map_type
    ld c, $0a
    ld a, $40
    ld [wFieldStepFlags], a
    jr .skip

.check_map_type:
    ld c, $02
    ld a, [wMapType]
    bit 7, a
    jr nz, .skip
    ldh a, [hMapId]
    cp $3a
    jr nz, .skip
    ld c, $05

.skip:
    ld a, e
    sub c
    ld e, a
    ld a, d
    sbc $00
    ld d, a
    bit 7, a
    jr nz, .call_set_field_step_flags_bit7
    or e
    jr nz, .skip2

.call_set_field_step_flags_bit7:
    ld c, $01
    call SetFieldStepFlagsBit7
    ld a, [wPartyCount]
    sub b
    jr z, .check_status_field_step
    ld b, a

.loop2:
    sla c
    dec b
    jr nz, .loop2

.check_status_field_step:
    ld a, [wStatusFieldStep]
    or c
    ld [wStatusFieldStep], a
    push hl
    ld a, [hl]
    ld c, MON_STATUS
    call SRAMRecordAddress
    ld a, [hl]
    or $80
    ld [hl], a
    pop hl
    ld de, $0000

.skip2:
    push hl
    ld a, [hl]
    ld c, MON_HP
    call SRAMRecordAddress
    ld a, e
    ld [hli], a
    ld a, d
    ld [hl], a
    pop hl

.next:
    inc hl
    pop bc
    dec b
    jr nz, .loop
    ret

FieldState_StepChecks_Sub01_QueueSoundEffect::
    ld a, [wMenuState]
    or a
    jr nz, .read_menu_state
    ld a, $66
    call QueueSoundEffect
    ld hl, wDMGPaletteBGP
    ld a, $d2
    ld [hli], a
    ld a, $d2
    ld [hli], a
    ld a, $e2
    ld [hl], a
    ld a, [wIsCGB]
    or a
    jr z, .return
    ld hl, wBGPaletteBuffer
    ld de, wBGPaletteCopy
    ld bc, $0040
    call CopyBytes
    jr .set_bg_palette_upload_request_to_7F

.read_menu_state:
    ld a, [wMenuState]
    srl a
    srl a
    and $01
    jr z, .skip
    ld hl, wDMGPaletteBGP
    ld a, $d2
    ld [hli], a
    ld a, $d2
    ld [hli], a
    ld a, $e2
    ld [hl], a
    ld a, [wIsCGB]
    or a
    jr z, .return
    ld hl, wBGPaletteCopy
    ld de, wBGPaletteBuffer
    ld bc, $0040
    call CopyBytes
    jr .set_bg_palette_upload_request_to_7F

.skip:
    ld hl, wDMGPaletteBGP
    ld a, $2d
    ld [hli], a
    ld a, $2d
    ld [hli], a
    ld a, $1d
    ld [hl], a
    ld a, [wIsCGB]
    or a
    jr z, .return
    ld b, $40
    ld hl, wBGPaletteCopy
    ld de, wBGPaletteBuffer

.loop:
    ld a, [hli]
    xor $ff
    ld [de], a
    inc de
    dec b
    jr nz, .loop

.set_bg_palette_upload_request_to_7F:
    ld a, $7f
    ld [wBGPaletteUploadRequest], a

.return:
    ret

; runs the movement routine for wMapMoveType (jump table of eight) (E-0122)
RunPlayerMoveTypeMapMoveType::
    ld a, [wMapMoveType]
    jumptable
    dw RunPlayerMoveTypeMapMoveType_Return
    dw RunPlayerMoveTypeMapMoveType_WriteTemp1AndStatusFieldStepEtc
    dw RunPlayerMoveTypeMapMoveType_WriteTemp1AndStatusFieldStepEtc_Case02
    dw RunPlayerMoveTypeMapMoveType_WriteTemp1AndStatusFieldStepEtc_Case03
    dw RunPlayerMoveTypeMapMoveType_WriteTemp1AndStatusFieldStepEtc_Case04
    dw RunPlayerMoveTypeMapMoveType_ReadTileBuffer2x2AtPixel_Bank0A
    dw RunPlayerMoveTypeMapMoveType_WriteTemp1AndStatusFieldStepEtc_Case06
    dw RunPlayerMoveTypeMapMoveType_WriteTemp1AndStatusFieldStepEtc_Case07

RunPlayerMoveTypeMapMoveType_Return::
    ret

RunPlayerMoveTypeMapMoveType_WriteTemp1AndStatusFieldStepEtc_Case06::
    ld a, $50
    ldh [hTemp1], a
    ld a, $80
    ld [wStatusFieldStep], a
    ld a, $40
    ld [wFieldStepFlags], a
    jr RunPlayerMoveTypeMapMoveType_ReadTileBuffer2x2AtPixel_Bank0A_CheckFadeState

RunPlayerMoveTypeMapMoveType_WriteTemp1AndStatusFieldStepEtc_Case07::
    ld a, $52
    ldh [hTemp1], a
    xor a
    ld [wStatusFieldStep], a
    jr RunPlayerMoveTypeMapMoveType_ReadTileBuffer2x2AtPixel_Bank0A_CheckFadeState

RunPlayerMoveTypeMapMoveType_WriteTemp1AndStatusFieldStepEtc::
    ld a, $44
    ldh [hTemp1], a
    xor a
    ld [wStatusFieldStep], a
    jr RunPlayerMoveTypeMapMoveType_ReadTileBuffer2x2AtPixel_Bank0A_CheckFadeState

RunPlayerMoveTypeMapMoveType_WriteTemp1AndStatusFieldStepEtc_Case02::
    ld a, $56
    ldh [hTemp1], a
    xor a
    ld [wStatusFieldStep], a
    jr RunPlayerMoveTypeMapMoveType_ReadTileBuffer2x2AtPixel_Bank0A_CheckFadeState

RunPlayerMoveTypeMapMoveType_WriteTemp1AndStatusFieldStepEtc_Case03::
    ld a, $44
    ldh [hTemp1], a
    xor a
    ld [wStatusFieldStep], a
    jr RunPlayerMoveTypeMapMoveType_ReadTileBuffer2x2AtPixel_Bank0A_CheckFadeState

RunPlayerMoveTypeMapMoveType_WriteTemp1AndStatusFieldStepEtc_Case04::
    ld a, $44
    ldh [hTemp1], a
    ld a, $80
    ld [wStatusFieldStep], a
    ld a, $40
    ld [wFieldStepFlags], a
    jr RunPlayerMoveTypeMapMoveType_ReadTileBuffer2x2AtPixel_Bank0A_CheckFadeState

RunPlayerMoveTypeMapMoveType_ReadTileBuffer2x2AtPixel_Bank0A::
    ld a, $44
    ldh [hTemp1], a
    xor a
    ld [wStatusFieldStep], a
    jr RunPlayerMoveTypeMapMoveType_ReadTileBuffer2x2AtPixel_Bank0A_CheckFadeState

RunPlayerMoveTypeMapMoveType_ReadTileBuffer2x2AtPixel_Bank0A_CheckFadeState::
    ld a, [wFadeState]
    or a
    ret nz
    ld a, [wScriptRunning]
    or a
    ret nz
    ld a, [wTalkCountdown]
    or a
    ret nz
    ldh a, [hPlayerX]
    ld b, a
    ldh a, [hPlayerY]
    ld c, a
    call ReadTileBuffer2x2AtPixel_Bank0A
    ldh a, [hTemp1]
    ld c, a
    ld a, [wTilesUnderPoint]
    cp c
    jr z, .set_mode_state_to_07
    ld a, [wTilesUnderPoint + $1]
    cp c
    jr z, .set_mode_state_to_07
    ld a, [wTilesUnderPoint + $2]
    cp c
    jr z, .set_mode_state_to_07
    ld a, [wTilesUnderPoint + $3]
    cp c
    jr z, .set_mode_state_to_07
    ret

.set_mode_state_to_07:
    ld a, $07
    ld [wModeState], a
    xor a
    ld [wMenuState], a
    ld [wMenuSubState], a
    ret

; in the field (story flag 2, not in mode states 1 or 7, outside listed maps): when a party member
; has status bit 2 or 0 of field $55, switches to mode state 7 and toggles wStatusStepFlags (E-0129)
EnterStatusEffectFieldState::
    ldh a, [hPlayerStateFlags]
    bit 7, a
    ret nz
    bit 5, a
    ret nz
    ld de, EVENT_SCENE_LONG_FACES
    call TestFlagBit
    ret nc
    ld a, [wModeState]
    and $0f
    dec a
    ret z
    ld a, [wModeState]
    cp $07
    ret z
    ld a, [wMapType]
    bit 7, a
    jr nz, .cp_82
    ldh a, [hMapId]
    cp $20
    ret c
    ld c, a
    ld hl, EnterStatusEffectFieldState_Data

.skip:
    ld a, [hli]
    cp $ff
    jr z, .read_party_count
    cp c
    ret z
    jr .skip

.cp_82:
    cp $82
    ret z
    cp $83
    ret z
    cp $84
    ret z
    cp $87
    ret z

.read_party_count:
    ld a, $0a
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList

.loop:
    push bc
    ld a, [hl]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    bit 7, a
    jr nz, .restore
    bit 2, a
    jr nz, .call_toggle_status_step_flags_low_bit_once
    bit 0, a
    jr nz, .call_toggle_status_step_flags_low_bit_once2
    jr .restore

.call_toggle_status_step_flags_low_bit_once:
    call ToggleStatusStepFlagsLowBitOnce

.loop2:
    pop bc
    ld a, [wModeState]
    cp $03
    jr nz, .set_mode_state_to_07
    xor a
    ld [wEncounterCountdown], a

.set_mode_state_to_07:
    ld a, $07
    ld [wModeState], a
    xor a
    ld [wMenuState], a
    ld a, $01
    ld [wMenuSubState], a
    xor a
    ld [wStatusFieldStep], a
    ld a, [wStatusStepFlags]
    and $7f
    ld [wStatusStepFlags], a
    jr .check_status_step_flags

.call_toggle_status_step_flags_low_bit_once2:
    call ToggleStatusStepFlagsLowBitOnce
    and $01
    jr nz, .loop2

.restore:
    pop bc
    inc hl
    dec b
    jr nz, .loop

.check_status_step_flags:
    ld a, [wStatusStepFlags]
    and $7f
    ld [wStatusStepFlags], a
    xor a
    ld [rRAMG], a
    ret

; when wStatusStepFlags bit 7 is clear: wStatusStepFlags = ((wStatusStepFlags + 1) & 1) | $80
; (E-0119)
ToggleStatusStepFlagsLowBitOnce::
    ld a, [wStatusStepFlags]
    bit 7, a
    ret nz
    ld a, [wStatusStepFlags]
    inc a
    and $01
    or $80
    ld [wStatusStepFlags], a
    ret

EnterStatusEffectFieldState_Data::
    db $21, $22, $23, $24, $25, $26, $29, $2a, $2b, $2d, $2e, $31, $32, $33, $34, $3c
    db $3d, $41, $45, $49, $4a, $4b, $4c, $4d, $4f
    dw RunBattleIntroKindCase_Case00_WriteEncounterKindAndTemp0Etc_Data2
    dw $5852
    dw $5a59
    dw PointerRun_0A_438D_Entry03
    dw PointerRun_0A_438D_Entry04
    dw $605f
    dw PointerRun_0A_438D_Entry06
    dw PointerRun_0A_438D_Entry07
    dw PointerRun_0A_438D_Entry08
    dw PointerRun_0A_438D_Entry09
    dw PointerRun_0A_438D_Entry0A
    db $89, $92, $9d, $a4, $a9, $ab, $af, $b2, $b1, $b6, $b9, $ba, $bc, $c5, $d0, $d9
    db $e2, $ff

; when nothing else runs and wEncounterRate & $7F is set, counts wTalkCountdown down; at zero sets
; wTalkEventGroup = 30 and far-calls DispatchTalkEvent (or retries next frame if a script runs)
; (E-0124)
CountDownTalkCountdownThenDispatchTalkEvent::
    ld a, [wFadeState]
    or a
    ret nz
    ld a, [wScriptRunning]
    or a
    ret nz
    ld a, [wEncounterRate]
    and $7f
    ret z
    ld a, [wTalkCountdown]
    or a
    ret z
    dec a
    ld [wTalkCountdown], a
    or a
    ret nz
    ld a, [wScriptRunning]
    or a
    jr z, .set_talk_event_group_to_1E
    ld a, $01
    ld [wTalkCountdown], a
    ret

.set_talk_event_group_to_1E:
    ld a, $1e
    ld [wTalkEventGroup], a
    xor a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ret

; in the field when nothing blocks it: counts down the encounter or talk timers (wEncounterRate,
; wEncounterDelay) and starts a battle or talk event when they expire (E-0131)
TickRandomEncounterCounter::
    ld a, [wFadeState]
    or a
    ret nz
    ld a, [wScriptRunning]
    or a
    ret nz
    ldh a, [hPlayerStateFlags]
    bit 7, a
    ret nz
    bit 5, a
    ret nz
    ld a, [wModeState]
    cp $04
    ret z
    cp $01
    ret z
    ld a, [wEncounterRate]
    bit 7, a
    jr z, .check_encounter_rate
    and $7f
    ld [wEncounterRate], a
    ret

.check_encounter_rate:
    ld a, [wEncounterRate]
    or a
    ret z
    ld a, [wEncounterDelay]
    or a
    jr z, .read_encounter_rate
    dec a
    ld [wEncounterDelay], a
    or a
    ret nz
    ld a, [wModeState]
    cp $01
    jr nz, .set_talk_event_group_to_1D
    ld a, $01
    ld [wEncounterDelay], a
    ret

.set_talk_event_group_to_1D:
    ld a, $1d
    ld [wTalkEventGroup], a
    xor a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ret

.read_encounter_rate:
    ld a, [wEncounterRate]
    push af
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr z, .restore
    pop af
    ld b, $02
    jr .skip

.restore:
    pop af
    ld l, a
    ld h, $00
    sla l
    rl h
    sla l
    rl h
    sla l
    rl h
    ld a, l
    add $fe
    ld l, a
    ld a, h
    adc $44
    ld h, a
    ld a, [hli]
    or a
    jr nz, .read_encounter_countdown
    push hl
    ldh a, [hPlayerX]
    ld b, a
    ldh a, [hPlayerY]
    ld c, a
    call ReadTileBuffer2x2AtPixel_Bank0A
    pop hl
    ld b, $02

.loop:
    ld a, [hli]
    cp $ff
    jr z, .next
    ld c, a
    ld a, [wTilesUnderPoint]
    cp c
    jr z, .skip
    ld a, [wTilesUnderPoint + $1]
    cp c
    jr z, .skip
    ld a, [wTilesUnderPoint + $2]
    cp c
    jr z, .skip
    ld a, [wTilesUnderPoint + $3]
    cp c
    jr z, .skip

.next:
    inc b
    ld a, b
    cp $09
    jr nz, .loop
    ld b, $02

.skip:
    ld a, b
    srl a
    ld b, a
    ld a, [wEncounterCountdown]
    sub b
    ld [wEncounterCountdown], a
    jr .skip2

.read_encounter_countdown:
    ld a, [hl]
    ld c, a
    ld a, [wEncounterCountdown]
    sub c
    ld [wEncounterCountdown], a

.skip2:
    jr c, .clear_battle_intro_kind
    ld a, [wEncounterCountdown]
    or a
    jr z, .clear_battle_intro_kind
    cp $e0
    jr nc, .clear_battle_intro_kind
    ret

.clear_battle_intro_kind:
    xor a
    ld [wBattleIntroKind], a
    ld a, [wMapType]
    bit 7, a
    jr z, .call_redraw_screen_buffer_if_party_window
    ld a, $01
    ld [wBattleIntroKind], a

.call_redraw_screen_buffer_if_party_window:
    farcall RedrawScreenBufferIfPartyWindowFlagsBit7
    ld a, $03
    ld [wModeState], a
    xor a
    ld [wBattleTransitionStep], a
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and $01
    sla a
    ld [wBattleTransitionSubStep], a
    ld a, $02
    ld [wFieldReturnPhase], a
    farcall SaveScreenBufferToBGMap1
    call PickRandomEncounterCountdownFromTable478F
    ret

; TickRandomEncounterCounter.restore reads the record at $44FE + 8 * wEncounterRate; with byte 0 = 0
; it compares bytes 1-7 (until $FF) with the four tiles of wTilesUnderPoint and subtracts (2 + slot)
; / 2 from wEncounterCountdown, else 1; with a non-zero byte 0 it subtracts byte 1; when bit 3 of
; hPlayerStateFlags is set the decrement is 1; 36 records end at the code at $461E (E-0202, C1)
; record: mode (0 = by tile); then tile numbers, slot k taking (k + 2) / 2 off wEncounterCountdown
; when a tile under the player matches (otherwise 1), or with a non-zero mode the decrement itself
EncounterRateTable::
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; id 0
    db $00, $ff, $ff, $40, $ff, $42, $ff, $44 ; id 1
    db $01, $04, $ff, $ff, $ff, $ff, $ff, $ff ; id 2
    db $00, $ff, $ff, $40, $42, $44, $ff, $ff ; id 3
    db $01, $02, $ff, $ff, $ff, $ff, $ff, $ff ; id 4
    db $01, $03, $ff, $ff, $ff, $ff, $ff, $ff ; id 5
    db $01, $03, $ff, $ff, $ff, $ff, $ff, $ff ; id 6
    db $01, $03, $ff, $ff, $ff, $ff, $ff, $ff ; id 7
    db $01, $04, $ff, $ff, $ff, $ff, $ff, $ff ; id 8
    db $01, $01, $ff, $ff, $ff, $ff, $ff, $ff ; id 9
    db $01, $02, $ff, $ff, $ff, $ff, $ff, $ff ; id 10
    db $01, $02, $ff, $ff, $ff, $ff, $ff, $ff ; id 11
    db $01, $02, $ff, $ff, $ff, $ff, $ff, $ff ; id 12
    db $01, $02, $ff, $ff, $ff, $ff, $ff, $ff ; id 13
    db $01, $03, $ff, $ff, $ff, $ff, $ff, $ff ; id 14
    db $01, $03, $ff, $ff, $ff, $ff, $ff, $ff ; id 15
    db $00, $ff, $ff, $40, $42, $44, $ff, $ff ; id 16
    db $01, $03, $ff, $ff, $ff, $ff, $ff, $ff ; id 17
    db $01, $03, $ff, $ff, $ff, $ff, $ff, $ff ; id 18
    db $01, $03, $ff, $ff, $ff, $ff, $ff, $ff ; id 19
    db $01, $03, $ff, $ff, $ff, $ff, $ff, $ff ; id 20
    db $01, $03, $ff, $ff, $ff, $ff, $ff, $ff ; id 21
    db $00, $ff, $ff, $40, $ff, $42, $44, $ff ; id 22
    db $01, $04, $ff, $ff, $ff, $ff, $ff, $ff ; id 23
    db $00, $ff, $ff, $40, $ff, $42, $ff, $44 ; id 24
    db $01, $05, $ff, $ff, $ff, $ff, $ff, $ff ; id 25
    db $00, $ff, $ff, $40, $ff, $42, $ff, $44 ; id 26
    db $01, $05, $ff, $ff, $ff, $ff, $ff, $ff ; id 27
    db $00, $ff, $ff, $40, $ff, $42, $ff, $44 ; id 28
    db $01, $05, $ff, $ff, $ff, $ff, $ff, $ff ; id 29
    db $01, $05, $ff, $ff, $ff, $ff, $ff, $ff ; id 30
    db $01, $05, $ff, $ff, $ff, $ff, $ff, $ff ; id 31
    db $01, $05, $ff, $ff, $ff, $ff, $ff, $ff ; id 32
    db $01, $02, $ff, $ff, $ff, $ff, $ff, $ff ; id 33
    db $00, $ff, $ff, $40, $42, $44, $ff, $ff ; id 34
    db $01, $03, $ff, $ff, $ff, $ff, $ff, $ff ; id 35

; B = X pixel, C = Y pixel: HL = wScreenTileBuffer + 20 * (C / 8) + B / 8 (rows of 20 entries);
; copies the 2 x 2 entries there to wTilesUnderPoint, wTilesUnderPoint + $1 (top row) and
; wTilesUnderPoint + $2, wTilesUnderPoint + $3 (bottom row); HL ends on the bottom-right entry
; (E-0064) (the same 63 bytes appear in 3 banks)
ReadTileBuffer2x2AtPixel_Bank0A::
    ld a, c
    srl a
    srl a
    srl a
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add_a_to_hl
    add hl, hl
    add hl, hl
    ld a, b
    srl a
    srl a
    srl a
    add_a_to_hl
    ld a, l
    add $98
    ld l, a
    ld a, h
    adc $c1
    ld h, a
    ld a, [hli]
    ld [wTilesUnderPoint], a
    ld a, [hld]
    ld [wTilesUnderPoint + $1], a
    ld a, $14
    add_a_to_hl
    ld a, [hli]
    ld [wTilesUnderPoint + $2], a
    ld a, [hl]
    ld [wTilesUnderPoint + $3], a
    ret

; clears wBattleIntroFlag and runs the routine for wBattleIntroKind & 7 (jump table of eight)
; (E-0122)
RunBattleIntroKindCase::
    xor a
    ld [wBattleIntroFlag], a
    ld a, [wBattleIntroKind]
    and $07
    jumptable
    dw RunBattleIntroKindCase_ReadMapIdAndPlayerStateFlags
    dw RunBattleIntroKindCase_NextTableByte
    dw RunBattleIntroKindCase_SetBattleKindTo02
    dw RunBattleIntroKindCase_WriteBattleIntroFlagAndBattleKind
    dw RunBattleIntroKindCase_SetBattleKindTo04
    dw RunBattleIntroKindCase_ComputePartyStrengthLevelPartyStrength
    dw RunBattleIntroKindCase_ComputePartyStrengthForKey
    dw RunBattleIntroKindCase_SetBattleKindTo05

RunBattleIntroKindCase_ComputePartyStrengthForKey::
    ld a, [wPendingFieldEvent]
    and $0f
    cp $0c
    jr nc, .skip2
    farcall ComputePartyStrengthForKey
    ld a, [wPartyStrength]
    ld b, a
    ld a, $05
    call DivideBByA
    ld a, b
    add a
    ld de, RunBattleIntroKindCase_ComputePartyStrengthForKey_Data1
    add e
    ld e, a
    jr nc, .set_temp0
    inc d

.set_temp0:
    ld a, [de]
    ldh [hTemp0], a
    inc de
    ld a, [de]
    ldh [hTemp1], a
    ld hl, wEncounterMonsters
    ld b, $03

.loop:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $0f
    cp $0a
    jr nc, .loop
    push af
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    pop af
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, e
    ld [hli], a
    ld a, d
    ld [hli], a
    dec b
    jr nz, .loop

.set_encounter_kind_to_02:
    ld a, $02
    ld [wEncounterKind], a
    ld a, $06
    ld [wBattleKind], a
    ret

.skip2:
    sub $0c
    ld c, a
    add a
    add c
    add a
    ld de, RunBattleIntroKindCase_ComputePartyStrengthForKey_Data2
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld hl, wEncounterMonsters
    ld b, $03

.loop2:
    ld a, [de]
    inc de
    ld [hli], a
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, .loop2
    jr .set_encounter_kind_to_02

RunBattleIntroKindCase_ComputePartyStrengthForKey_Data1::
    db $ac, $00, $bc, $00, $cc, $00, $dc, $00, $ec, $00, $fc, $00, $0c, $01, $1c, $01
    db $2c, $01, $3c, $01, $1e, $02, $23, $02, $28, $02, $2d, $02, $32, $02, $37, $02
    db $3c, $02, $41, $02, $46, $02, $48, $02

RunBattleIntroKindCase_ComputePartyStrengthForKey_Data2::
    db $0b, $02, $0c, $02, $0d, $02, $0e, $02, $0f, $02, $0e, $02, $10, $02, $11, $02
    db $12, $02, $13, $02, $14, $02, $15, $02

RunBattleIntroKindCase_ComputePartyStrengthLevelPartyStrength::
    farcall ComputePartyStrengthLevelPartyStrength
    ld c, $76
    ld a, [wPartyStrength]
    cp $05
    jr c, .set_encounter_monsters
    inc c
    cp $0a
    jr c, .set_encounter_monsters
    inc c
    cp $0f
    jr c, .set_encounter_monsters
    inc c
    cp $14
    jr c, .set_encounter_monsters
    inc c
    cp $19
    jr c, .set_encounter_monsters
    inc c
    cp $1e
    jr c, .set_encounter_monsters
    inc c
    cp $23
    jr c, .set_encounter_monsters
    inc c

.set_encounter_monsters:
    ld a, c
    ld [wEncounterMonsters], a
    xor a
    ld [wEncounterMonsters + $1], a
    xor a
    ld [wEncounterKind], a
    ld a, $02
    ld [wBattleKind], a
    ret

; draws random values until wKeyRandomHi & $3F is below 100, then wEncounterCountdown = 2 *
; PickRandomEncounterCountdownFromTable478F_Data[value / 5] (E-0122)
PickRandomEncounterCountdownFromTable478F::
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $3f
    cp $64
    jr nc, PickRandomEncounterCountdownFromTable478F
    ld b, a
    ld a, $05
    call DivideBByA
    ld a, b
    ld hl, PickRandomEncounterCountdownFromTable478F_Data
    add_a_to_hl
    ld a, [hl]
    add a
    ld [wEncounterCountdown], a
    ret

PickRandomEncounterCountdownFromTable478F_Data::
    db $0a, $14, $19, $1e, $23, $28, $2a, $2c, $2d, $2e, $30, $32, $34, $36, $38, $3a
    db $3c, $41, $46, $50, $50

; loads encounter entry $481C + 8 * hTemp0 into wEncounterKind-wEncounterMonsters + $5, sets the
; battle intro (wBattleIntroKind = 2, or 7 for entries $14, $15, $2F-$31), mode state 3 and the
; battle transition (E-0128)
StartScriptedEncounterTemp0::
    push hl
    ldh a, [hTemp0]
    ld l, a
    ld h, $00
    sla l
    rl h
    sla l
    rl h
    sla l
    rl h
    ld a, l
    add $1c
    ld l, a
    ld a, h
    adc $48
    ld h, a
    ld a, [hli]
    ld [wEncounterKind], a
    inc hl
    ld a, [hli]
    ld [wEncounterMonsters], a
    ld a, [hli]
    ld [wEncounterMonsters + $1], a
    ld a, [hli]
    ld [wEncounterMonsters + $2], a
    ld a, [hli]
    ld [wEncounterMonsters + $3], a
    ld a, [hli]
    ld [wEncounterMonsters + $4], a
    ld a, [hl]
    ld [wEncounterMonsters + $5], a
    ld a, $02
    ld [wBattleIntroKind], a
    ldh a, [hTemp0]
    cp $14
    jr z, .set_battle_intro_kind_to_07
    cp $15
    jr z, .set_battle_intro_kind_to_07
    cp $2f
    jr z, .set_battle_intro_kind_to_07
    cp $30
    jr z, .set_battle_intro_kind_to_07
    cp $31
    jr nz, .set_mode_state_to_03

.set_battle_intro_kind_to_07:
    ld a, $07
    ld [wBattleIntroKind], a

.set_mode_state_to_03:
    ld a, $03
    ld [wModeState], a
    xor a
    ld [wBattleTransitionStep], a
    ld a, $01
    ld [wBattleTransitionSubStep], a
    ld a, $02
    ld [wFieldReturnPhase], a
    farcall SaveScreenBufferToBGMap1
    farcall PickRandomEncounterCountdownFromTable478F
    pop hl
    ret

; StartScriptedEncounterTemp0 (14 callers, script commands among them) reads the record at $481C + 8
; * hTemp0: byte 0 to wEncounterKind, bytes 2-7 to wEncounterMonsters; records $14, $15 and $2F-$31
; use battle intro 7, the rest intro 2; 51 records end at RunBattleIntroKindCase_Case00 ($49B4)
; (E-0202, C1)
; record: wEncounterKind; unread byte; three encounter words (wEncounterMonsters)
ScriptedEncounterTable::
    db $00, $00 ; id 0
    dw $0007 ; MonsterTable $007: CurseLamp
    dw $0001 ; MonsterTable $001: Slime
    dw $0001 ; MonsterTable $001: Slime
    db $00, $00 ; id 1
    dw $001a ; MonsterTable $01A: HoodSquid
    dw $0001 ; MonsterTable $001: Slime
    dw $0001 ; MonsterTable $001: Slime
    db $02, $00 ; id 2
    dw $018f ; MonsterTable $18F: BoneSlave
    dw $001c ; MonsterTable $01C: CaptDead
    dw $018f ; MonsterTable $18F: BoneSlave
    db $00, $00 ; id 3
    dw $0032 ; MonsterTable $032: BombCrag
    dw $0001 ; MonsterTable $001: Slime
    dw $0001 ; MonsterTable $001: Slime
    db $00, $00 ; id 4
    dw $0044 ; MonsterTable $044: GoatHorn
    dw $0001 ; MonsterTable $001: Slime
    dw $0001 ; MonsterTable $001: Slime
    db $00, $00 ; id 5
    dw $01ab ; MonsterTable $1AB: MadCondor
    dw $0001 ; MonsterTable $001: Slime
    dw $0001 ; MonsterTable $001: Slime
    db $00, $00 ; id 6
    dw $01a6 ; MonsterTable $1A6: Metabble
    dw $0001 ; MonsterTable $001: Slime
    dw $0001 ; MonsterTable $001: Slime
    db $00, $00 ; id 7
    dw $006d ; MonsterTable $06D: Skeletor
    dw $0001 ; MonsterTable $001: Slime
    dw $0001 ; MonsterTable $001: Slime
    db $00, $00 ; id 8
    dw $0064 ; MonsterTable $064: Niterich
    dw $0001 ; MonsterTable $001: Slime
    dw $0001 ; MonsterTable $001: Slime
    db $01, $00 ; id 9
    dw $01df ; MonsterTable $1DF: ArrowDog
    dw $01df ; MonsterTable $1DF: ArrowDog
    dw $0001 ; MonsterTable $001: Slime
    db $00, $00 ; id 10
    dw $0179 ; MonsterTable $179: Darck
    dw $0001 ; MonsterTable $001: Slime
    dw $0001 ; MonsterTable $001: Slime
    db $00, $00 ; id 11
    dw $01e2 ; MonsterTable $1E2: AgDevil
    dw $0001 ; MonsterTable $001: Slime
    dw $0001 ; MonsterTable $001: Slime
    db $00, $00 ; id 12
    dw $0199 ; MonsterTable $199: AgDevil
    dw $0001 ; MonsterTable $001: Slime
    dw $0001 ; MonsterTable $001: Slime
    db $00, $00 ; id 13
    dw $01e9 ; MonsterTable $1E9: Roboster
    dw $0001 ; MonsterTable $001: Slime
    dw $0001 ; MonsterTable $001: Slime
    db $00, $00 ; id 14
    dw $01ea ; MonsterTable $1EA: Roboster
    dw $0001 ; MonsterTable $001: Slime
    dw $0001 ; MonsterTable $001: Slime
    db $00, $00 ; id 15
    dw $01eb ; MonsterTable $1EB: Roboster
    dw $0001 ; MonsterTable $001: Slime
    dw $0001 ; MonsterTable $001: Slime
    db $00, $00 ; id 16
    dw $01ec ; MonsterTable $1EC: Roboster
    dw $0001 ; MonsterTable $001: Slime
    dw $0001 ; MonsterTable $001: Slime
    db $01, $00 ; id 17
    dw $01f8 ; MonsterTable $1F8: Pixy
    dw $01f8 ; MonsterTable $1F8: Pixy
    dw $0001 ; MonsterTable $001: Slime
    db $02, $00 ; id 18
    dw $01f9 ; MonsterTable $1F9: Copycat
    dw $01fa ; MonsterTable $1FA: StoneMan
    dw $01fb ; MonsterTable $1FB: WhipBird
    db $02, $00 ; id 19
    dw $021b ; MonsterTable $21B: MetalKing
    dw $021c ; MonsterTable $21C: RainHawk
    dw $021d ; MonsterTable $21D: Coatol
    db $02, $00 ; id 20
    dw $0208 ; MonsterTable $208: GreatDrak
    dw $0209 ; MonsterTable $209: Watabou
    dw $020a ; MonsterTable $20A: Durran
    db $02, $00 ; id 21
    dw $025f ; MonsterTable $25F: Drygon
    dw $0260 ; MonsterTable $260: Butch
    dw $0261 ; MonsterTable $261: Pumpoise
    db $00, $00 ; id 22
    dw $0182 ; MonsterTable $182: Beavern
    dw $0001 ; MonsterTable $001: Slime
    dw $0001 ; MonsterTable $001: Slime
    db $00, $00 ; id 23
    dw $018f ; MonsterTable $18F: BoneSlave
    dw $0001 ; MonsterTable $001: Slime
    dw $0001 ; MonsterTable $001: Slime
    db $00, $00 ; id 24
    dw $019a ; MonsterTable $19A: Puppetor
    dw $0001 ; MonsterTable $001: Slime
    dw $0001 ; MonsterTable $001: Slime
    db $02, $00 ; id 25
    dw $019b ; MonsterTable $19B: ArcDemon
    dw $019c ; MonsterTable $19C: GoatHorn
    dw $019b ; MonsterTable $19B: ArcDemon
    db $02, $00 ; id 26
    dw $02ac ; MonsterTable $2AC: Slime
    dw $02ac ; MonsterTable $2AC: Slime
    dw $02ac ; MonsterTable $2AC: Slime
    db $01, $00 ; id 27
    dw $006c ; MonsterTable $06C: EvilArmor
    dw $006c ; MonsterTable $06C: EvilArmor
    dw $0001 ; MonsterTable $001: Slime
    db $00, $00 ; id 28
    dw $006b ; MonsterTable $06B: Mudou
    dw $0001 ; MonsterTable $001: Slime
    dw $0001 ; MonsterTable $001: Slime
    db $02, $00 ; id 29
    dw $0073 ; MonsterTable $073: Centasaur
    dw $0074 ; MonsterTable $074: GigaDraco
    dw $0075 ; MonsterTable $075: Garudian
    db $00, $00 ; id 30
    dw $0190 ; MonsterTable $190: KingSquid
    dw $0001 ; MonsterTable $001: Slime
    dw $0001 ; MonsterTable $001: Slime
    db $00, $00 ; id 31
    dw $0219 ; MonsterTable $219: Shadow
    dw $0001 ; MonsterTable $001: Slime
    dw $0001 ; MonsterTable $001: Slime
    db $01, $00 ; id 32
    dw $01b0 ; MonsterTable $1B0: WindBeast
    dw $01b1 ; MonsterTable $1B1: MadGoose
    dw $0001 ; MonsterTable $001: Slime
    db $02, $00 ; id 33
    dw $01b2 ; MonsterTable $1B2: WhaleMage
    dw $01b3 ; MonsterTable $1B3: SeaHorse
    dw $01b4 ; MonsterTable $1B4: Octoreach
    db $02, $00 ; id 34
    dw $01b5 ; MonsterTable $1B5: IceMan
    dw $01b6 ; MonsterTable $1B6: Shadow
    dw $01b7 ; MonsterTable $1B7: BigEye
    db $01, $00 ; id 35
    dw $01b8 ; MonsterTable $1B8: Balzak
    dw $01b9 ; MonsterTable $1B9: RotRaven
    dw $0001 ; MonsterTable $001: Slime
    db $02, $00 ; id 36
    dw $01ba ; MonsterTable $1BA: Jamirus
    dw $01bb ; MonsterTable $1BB: SkyDragon
    dw $01bc ; MonsterTable $1BC: Gremlin
    db $01, $00 ; id 37
    dw $01bd ; MonsterTable $1BD: Crestpent
    dw $01be ; MonsterTable $1BE: SpotKing
    dw $0001 ; MonsterTable $001: Slime
    db $02, $00 ; id 38
    dw $01bf ; MonsterTable $1BF: Gulpple
    dw $01c0 ; MonsterTable $1C0: FairyDrak
    dw $01c1 ; MonsterTable $1C1: DuckKite
    db $02, $00 ; id 39
    dw $01c2 ; MonsterTable $1C2: FunkyBird
    dw $01c3 ; MonsterTable $1C3: DanceVegi
    dw $01c4 ; MonsterTable $1C4: Slurperon
    db $02, $00 ; id 40
    dw $01c5 ; MonsterTable $1C5: MadPlant
    dw $01c6 ; MonsterTable $1C6: Orc
    dw $01c7 ; MonsterTable $1C7: PutrePup
    db $02, $00 ; id 41
    dw $01c8 ; MonsterTable $1C8: Devipine
    dw $01c9 ; MonsterTable $1C9: Anemon
    dw $01ca ; MonsterTable $1CA: HerbMan
    db $01, $00 ; id 42
    dw $01cb ; MonsterTable $1CB: KingSlime
    dw $01cc ; MonsterTable $1CC: Coatol
    dw $0001 ; MonsterTable $001: Slime
    db $02, $00 ; id 43
    dw $01cd ; MonsterTable $1CD: FangSlime
    dw $01ce ; MonsterTable $1CE: Grizzly
    dw $01cf ; MonsterTable $1CF: BeastNite
    db $02, $00 ; id 44
    dw $01d0 ; MonsterTable $1D0: SlimeBorg
    dw $01d1 ; MonsterTable $1D1: Unicorn
    dw $01d2 ; MonsterTable $1D2: SuperTen
    db $02, $00 ; id 45
    dw $01d3 ; MonsterTable $1D3: Slime
    dw $01d4 ; MonsterTable $1D4: RockSlime
    dw $01d5 ; MonsterTable $1D5: Metabble
    db $00, $00 ; id 46
    dw $01d6 ; MonsterTable $1D6: Gorago
    dw $0001 ; MonsterTable $001: Slime
    dw $0001 ; MonsterTable $001: Slime
    db $02, $00 ; id 47
    dw $01fc ; MonsterTable $1FC: MimeSlime
    dw $01fd ; MonsterTable $1FD: Tonguella
    dw $01fe ; MonsterTable $1FE: Golem
    db $02, $00 ; id 48
    dw $0205 ; MonsterTable $205: MetalKing
    dw $0206 ; MonsterTable $206: KingLeo
    dw $0207 ; MonsterTable $207: GoldGolem
    db $00, $00 ; id 49
    dw $0001 ; MonsterTable $001: Slime
    dw $0001 ; MonsterTable $001: Slime
    dw $0001 ; MonsterTable $001: Slime
    db $00, $00 ; id 50
    dw $007d ; MonsterTable $07D: Mimic
    dw $0001 ; MonsterTable $001: Slime
    dw $0001 ; MonsterTable $001: Slime

RunBattleIntroKindCase_ReadMapIdAndPlayerStateFlags::
    ldh a, [hMapId]
    cp $20
    jp z, .call_read_map_cell_word_for_screen_xy
    cp $2b
    jp z, .check_player_state_flags
    cp $30
    jp z, .check_player_state_flags2
    cp $35
    jp z, .call_read_map_cell_word_for_screen_xy2
    cp $38
    jp z, .call_read_map_cell_word_for_screen_xy3
    cp $39
    jp z, .call_read_map_cell_word_for_screen_xy4
    cp $3a
    jp z, .call_read_map_cell_word_for_screen_xy5
    cp $3e
    jp z, .call_read_map_cell_word_for_screen_xy6
    cp $3f
    jp z, .call_read_map_cell_word_for_screen_xy7
    cp $37
    jp z, .call_read_map_cell_word_for_screen_xy8
    cp $42
    jp z, .call_read_map_cell_word_for_screen_xy9
    cp $43
    jp z, .call_read_map_cell_word_for_screen_xy10
    cp $48
    jp z, .check_player_state_flags3
    cp $53
    jp z, .call_read_map_cell_word_for_screen_xy11
    cp $54
    jp z, .call_run_battle_intro_kind_case_case00_write4
    cp $55
    jp z, .call_run_battle_intro_kind_case_case00_write4
    cp $56
    jp z, .call_run_battle_intro_kind_case_case00_write4
    cp $5d
    jp z, .call_read_map_cell_word_for_screen_xy12
    cp $62
    jp z, .call_read_map_cell_word_for_screen_xy13
    cp $63
    jp z, .call_read_map_cell_word_for_screen_xy14
    cp $64
    jp z, .call_read_map_cell_word_for_screen_xy15
    cp $65
    jp z, .call_read_map_cell_word_for_screen_xy16
    cp $66
    jp z, .call_read_map_cell_word_for_screen_xy17
    cp $67
    jp z, .call_read_map_cell_word_for_screen_xy18
    cp $70
    jp z, .call_read_map_cell_word_for_screen_xy19
    cp $73
    jp z, .call_read_map_cell_word_for_screen_xy20
    cp $74
    jp z, .call_read_map_cell_word_for_screen_xy21
    cp $75
    jp z, .call_read_map_cell_word_for_screen_xy22
    cp $76
    jp z, .call_read_map_cell_word_for_screen_xy23
    cp $81
    jp z, .call_read_map_cell_word_for_screen_xy24
    cp $82
    jp z, .call_read_map_cell_word_for_screen_xy25
    cp $83
    jp z, .call_read_map_cell_word_for_screen_xy26
    cp $85
    jp z, .call_read_map_cell_word_for_screen_xy27
    cp $86
    jp z, .call_read_map_cell_word_for_screen_xy28
    cp $87
    jp z, .call_read_map_cell_word_for_screen_xy29
    cp $88
    jp z, .call_read_map_cell_word_for_screen_xy30
    cp $8b
    jp z, .call_read_map_cell_word_for_screen_xy31
    cp $8c
    jp z, .call_read_map_cell_word_for_screen_xy32
    cp $8e
    jp z, .call_read_map_cell_word_for_screen_xy33
    cp $90
    jp z, .call_read_map_cell_word_for_screen_xy34
    cp $a0
    jp z, .call_read_map_cell_word_for_screen_xy35
    cp $a2
    jp z, .call_read_map_cell_word_for_screen_xy36
    cp $a8
    jp z, .call_read_map_cell_word_for_screen_xy37
    cp $ad
    jp z, .call_read_map_cell_word_for_screen_xy38
    cp $ae
    jp z, .call_read_map_cell_word_for_screen_xy38
    cp $b0
    jp z, .call_read_map_cell_word_for_screen_xy39
    cp $b3
    jp z, .call_read_map_cell_word_for_screen_xy40
    cp $b4
    jp z, .call_read_map_cell_word_for_screen_xy40
    cp $b5
    jp z, .call_read_map_cell_word_for_screen_xy40
    cp $b8
    jp z, .check_player_state_flags4
    cp $be
    jp z, .call_read_map_cell_word_for_screen_xy41
    cp $bf
    jp z, .call_read_map_cell_word_for_screen_xy42
    cp $c0
    jp z, .call_read_map_cell_word_for_screen_xy43
    cp $c1
    jp z, .call_read_map_cell_word_for_screen_xy43
    cp $c2
    jp z, .call_read_map_cell_word_for_screen_xy44
    cp $c3
    jp z, .call_read_map_cell_word_for_screen_xy44
    ret

.call_read_map_cell_word_for_screen_xy:
    ld de, EncounterGrid_5773
    ld a, $08
    call ReadMapCellWordForScreenXY
    ret

.check_player_state_flags:
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, .call_run_battle_intro_kind_case_case00_write
    ld de, EncounterGrid_5856
    ld a, $04
    call ReadMapCellWordForScreenXY
    ret

.call_run_battle_intro_kind_case_case00_write:
    ld de, EncounterGroup_588E
    call RunBattleIntroKindCase_Case00_WriteEncounterKindAndTemp0Etc
    ret

.check_player_state_flags2:
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, .call_run_battle_intro_kind_case_case00_write2
    ld de, EncounterGrid_589B
    ld a, $08
    call ReadMapCellWordForScreenXY
    ret

.call_run_battle_intro_kind_case_case00_write2:
    ld de, EncounterGroup_5A3B
    call RunBattleIntroKindCase_Case00_WriteEncounterKindAndTemp0Etc
    ret

.call_read_map_cell_word_for_screen_xy2:
    ld de, EncounterGrid_5A4C
    ld a, $04
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy3:
    ld de, EncounterGrid_5A8A
    ld a, $04
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy4:
    ld de, EncounterGrid_5AB7
    ld a, $04
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy5:
    ld de, EncounterGrid_5ADE
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy6:
    ld de, EncounterGrid_5AFF
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy7:
    ld de, EncounterGrid_5B14
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy8:
    ld de, EncounterGrid_5B29
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy9:
    ld de, EncounterGrid_5B45
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy10:
    ld de, EncounterGrid_5B58
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

.check_player_state_flags3:
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, .call_run_battle_intro_kind_case_case00_write3
    ld de, EncounterGrid_5B6B
    ld a, $0c
    call ReadMapCellWordForScreenXY
    ret

.call_run_battle_intro_kind_case_case00_write3:
    ld de, EncounterGroup_5D4E
    call RunBattleIntroKindCase_Case00_WriteEncounterKindAndTemp0Etc
    ret

.call_read_map_cell_word_for_screen_xy11:
    ld de, EncounterGrid_5D5D
    ld a, $04
    call ReadMapCellWordForScreenXY
    ret

.call_run_battle_intro_kind_case_case00_write4:
    ld de, EncounterGroup_5D8C
    call RunBattleIntroKindCase_Case00_WriteEncounterKindAndTemp0Etc
    ret

.call_read_map_cell_word_for_screen_xy12:
    ld de, EncounterGrid_5D9B
    ld a, $04
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy13:
    ld de, EncounterGrid_5DCA
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy14:
    ld de, EncounterGrid_5DE7
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy15:
    ld de, EncounterGrid_5DEF
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy16:
    ld de, EncounterGrid_5DF7
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy17:
    ld de, EncounterGrid_5E0C
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy18:
    ld de, EncounterGrid_5E14
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy19:
    ld de, EncounterGrid_5E2B
    ld a, $0c
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy20:
    ld de, EncounterGrid_6028
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy21:
    ld de, EncounterGrid_603D
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy22:
    ld de, EncounterGrid_6052
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy23:
    ld de, EncounterGrid_606B
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy24:
    ld de, EncounterGrid_6084
    ld a, $01
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy25:
    ld de, EncounterGrid_6097
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy26:
    ld de, EncounterGrid_60BA
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy27:
    ld de, EncounterGrid_60DD
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy28:
    ld de, EncounterGrid_60F2
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy29:
    ld de, EncounterGrid_6107
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy30:
    ld de, EncounterGrid_6120
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy31:
    ld de, EncounterGrid_6139
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy32:
    ld de, EncounterGrid_6160
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy33:
    ld de, EncounterGrid_6181
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy34:
    ld de, EncounterGrid_61A2
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy35:
    ld de, EncounterGrid_61BD
    ld a, $04
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy36:
    ld de, EncounterGrid_61FB
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy37:
    ld de, EncounterGrid_6220
    ld a, $06
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy38:
    ld de, EncounterGrid_62AB
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy39:
    ld de, EncounterGrid_62D2
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy40:
    ld de, EncounterGrid_62EB
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.check_player_state_flags4:
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, .call_run_battle_intro_kind_case_case00_write5
    ld de, EncounterGrid_6300
    ld a, $05
    call ReadMapCellWordForScreenXY
    ret

.call_run_battle_intro_kind_case_case00_write5:
    ld de, EncounterGroup_6375
    call RunBattleIntroKindCase_Case00_WriteEncounterKindAndTemp0Etc
    ret

.call_read_map_cell_word_for_screen_xy41:
    ld de, EncounterGrid_6382
    ld a, $01
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy42:
    ld de, EncounterGrid_6393
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy43:
    ld de, EncounterGrid_63AA
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy44:
    ld de, EncounterGrid_63BF
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

; DE = the word at DE + 2 * A * (hMapScreenY & $0F) + 2 * (hMapScreenX & $0F); falls through
; (E-0122)
ReadMapCellWordForScreenXY::
    sla a
    ld c, a
    ldh a, [hMapScreenY]
    and $0f
    call Multiply8
    ldh a, [hMapScreenX]
    and $0f
    sla a
    add_a_to_hl
    add hl, de
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a

RunBattleIntroKindCase_Case00_WriteEncounterKindAndTemp0Etc::
    ld a, [de]
    inc de
    dec a
    ld [wEncounterKind], a
    ld a, [de]
    inc de
    ldh [hTemp0], a
    ld a, [de]
    inc de
    ldh [hTemp1], a
    ld a, [de]
    inc de
    ldh [hTemp2], a
    ld a, [de]
    inc de
    ldh [hTemp3], a
    ld a, [de]
    inc de
    ldh [hTemp4], a
    ld a, [de]
    inc de
    ldh [hTemp5], a
    ld hl, wEncounterMonsters
    ld b, $03

.loop:
    call NextTableByte
    ld a, [wRandomLo]
    and $7f
    ld c, a
    ldh a, [hTemp0]
    cp c
    jr c, .loop
    push hl
    push de
    ldh a, [hTemp1]
    cp c
    jr nc, .skip
    inc de
    inc de
    ldh a, [hTemp2]
    cp c
    jr nc, .skip
    inc de
    inc de
    ldh a, [hTemp3]
    cp c
    jr nc, .skip
    inc de
    inc de
    ldh a, [hTemp4]
    cp c
    jr nc, .skip
    inc de
    inc de
    ldh a, [hTemp5]
    cp c
    jr nc, .skip

.restore:
    pop de
    pop hl
    inc hl
    inc hl
    dec b
    jr nz, .loop
    jr .clear_battle_kind

.skip:
    ld a, [de]
    inc de
    ld [hli], a
    ld a, [de]
    ld [hl], a
    jr .restore

.clear_battle_kind:
    xor a
    ld [wBattleKind], a
    ld a, [wEncounterKind]
    or a
    ret z
    dec a
    jr nz, .call_next_table_byte
    ld hl, RunBattleIntroKindCase_Case00_WriteEncounterKindAndTemp0Etc_Data2
    jr .call_next_table_byte2

.call_next_table_byte:
    ld hl, RunBattleIntroKindCase_Case00_WriteEncounterKindAndTemp0Etc_Data1

.call_next_table_byte2:
    call NextTableByte
    ld a, [wRandomLo]
    and $03
    add_a_to_hl
    ld a, [hl]
    ld [wEncounterKind], a
    ret

CollectUniqueEncounterIdsToWD09F_ReadMapIdAndPlayerStateFlags::
    ldh a, [hMapId]
    cp $20
    jp z, .call_read_map_cell_word_for_screen_xy_5057
    cp $2b
    jp z, .check_player_state_flags
    cp $30
    jp z, .check_player_state_flags2
    cp $35
    jp z, .call_read_map_cell_word_for_screen_xy_50572
    cp $38
    jp z, .call_read_map_cell_word_for_screen_xy_50573
    cp $39
    jp z, .call_read_map_cell_word_for_screen_xy_50574
    cp $3a
    jp z, .call_read_map_cell_word_for_screen_xy_50575
    cp $3e
    jp z, .call_read_map_cell_word_for_screen_xy_50576
    cp $3f
    jp z, .call_read_map_cell_word_for_screen_xy_50577
    cp $37
    jp z, .call_read_map_cell_word_for_screen_xy_50578
    cp $42
    jp z, .call_read_map_cell_word_for_screen_xy_50579
    cp $43
    jp z, .call_read_map_cell_word_for_screen_xy_505710
    cp $48
    jp z, .check_player_state_flags3
    cp $53
    jp z, .call_read_map_cell_word_for_screen_xy_505711
    cp $54
    jp z, .call_load_encounter_monster_ids_to_work_buf4
    cp $55
    jp z, .call_load_encounter_monster_ids_to_work_buf4
    cp $56
    jp z, .call_load_encounter_monster_ids_to_work_buf4
    cp $5d
    jp z, .call_read_map_cell_word_for_screen_xy_505712
    cp $62
    jp z, .call_read_map_cell_word_for_screen_xy_505713
    cp $63
    jp z, .call_read_map_cell_word_for_screen_xy_505714
    cp $64
    jp z, .call_read_map_cell_word_for_screen_xy_505715
    cp $65
    jp z, .call_read_map_cell_word_for_screen_xy_505716
    cp $66
    jp z, .call_read_map_cell_word_for_screen_xy_505717
    cp $67
    jp z, .call_read_map_cell_word_for_screen_xy_505718
    cp $70
    jp z, .call_read_map_cell_word_for_screen_xy_505719
    cp $73
    jp z, .call_read_map_cell_word_for_screen_xy_505720
    cp $74
    jp z, .call_read_map_cell_word_for_screen_xy_505721
    cp $75
    jp z, .call_read_map_cell_word_for_screen_xy_505722
    cp $76
    jp z, .call_read_map_cell_word_for_screen_xy_505723
    cp $81
    jp z, .call_read_map_cell_word_for_screen_xy_505724
    cp $82
    jp z, .call_read_map_cell_word_for_screen_xy_505725
    cp $83
    jp z, .call_read_map_cell_word_for_screen_xy_505726
    cp $85
    jp z, .call_read_map_cell_word_for_screen_xy_505727
    cp $86
    jp z, .call_read_map_cell_word_for_screen_xy_505728
    cp $87
    jp z, .call_read_map_cell_word_for_screen_xy_505729
    cp $88
    jp z, .call_read_map_cell_word_for_screen_xy_505730
    cp $8b
    jp z, .call_read_map_cell_word_for_screen_xy_505731
    cp $8c
    jp z, .call_read_map_cell_word_for_screen_xy_505732
    cp $8e
    jp z, .call_read_map_cell_word_for_screen_xy_505733
    cp $90
    jp z, .call_read_map_cell_word_for_screen_xy_505734
    cp $a0
    jp z, .call_read_map_cell_word_for_screen_xy_505735
    cp $a2
    jp z, .call_read_map_cell_word_for_screen_xy_505736
    cp $a8
    jp z, .call_read_map_cell_word_for_screen_xy_505737
    cp $ad
    jp z, .call_read_map_cell_word_for_screen_xy_505738
    cp $ae
    jp z, .call_read_map_cell_word_for_screen_xy_505738
    cp $b0
    jp z, .call_read_map_cell_word_for_screen_xy_505739
    cp $b3
    jp z, .call_read_map_cell_word_for_screen_xy_505740
    cp $b4
    jp z, .call_read_map_cell_word_for_screen_xy_505740
    cp $b5
    jp z, .call_read_map_cell_word_for_screen_xy_505740
    cp $b8
    jp z, .call_read_map_cell_word_for_screen_xy_505741
    cp $be
    jp z, .call_read_map_cell_word_for_screen_xy_505742
    cp $bf
    jp z, .call_read_map_cell_word_for_screen_xy_505743
    cp $c0
    jp z, .call_read_map_cell_word_for_screen_xy_505744
    cp $c1
    jp z, .call_read_map_cell_word_for_screen_xy_505744
    cp $c2
    jp z, .call_read_map_cell_word_for_screen_xy_505745
    cp $c3
    jp z, .call_read_map_cell_word_for_screen_xy_505745
    ret

.call_read_map_cell_word_for_screen_xy_5057:
    ld de, EncounterGrid_5773
    ld a, $08
    call ReadMapCellWordForScreenXY_5057
    ret

.check_player_state_flags:
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, .call_load_encounter_monster_ids_to_work_buf
    ld de, EncounterGrid_5856
    ld a, $04
    call ReadMapCellWordForScreenXY_5057
    ret

.call_load_encounter_monster_ids_to_work_buf:
    ld de, EncounterGroup_588E
    call LoadEncounterMonsterIdsToWorkBuf
    ret

.check_player_state_flags2:
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, .call_load_encounter_monster_ids_to_work_buf2
    ld de, EncounterGrid_589B
    ld a, $08
    call ReadMapCellWordForScreenXY_5057
    ret

.call_load_encounter_monster_ids_to_work_buf2:
    ld de, EncounterGroup_5A3B
    call LoadEncounterMonsterIdsToWorkBuf
    ret

.call_read_map_cell_word_for_screen_xy_50572:
    ld de, EncounterGrid_5A4C
    ld a, $04
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_50573:
    ld de, EncounterGrid_5A8A
    ld a, $04
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_50574:
    ld de, EncounterGrid_5AB7
    ld a, $04
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_50575:
    ld de, EncounterGrid_5ADE
    ld a, $03
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_50576:
    ld de, EncounterGrid_5AFF
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_50577:
    ld de, EncounterGrid_5B14
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_50578:
    ld de, EncounterGrid_5B29
    ld a, $03
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_50579:
    ld de, EncounterGrid_5B45
    ld a, $03
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505710:
    ld de, EncounterGrid_5B58
    ld a, $03
    call ReadMapCellWordForScreenXY_5057
    ret

.check_player_state_flags3:
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, .call_load_encounter_monster_ids_to_work_buf3
    ld de, EncounterGrid_5B6B
    ld a, $0c
    call ReadMapCellWordForScreenXY_5057
    ret

.call_load_encounter_monster_ids_to_work_buf3:
    ld de, EncounterGroup_5D4E
    call LoadEncounterMonsterIdsToWorkBuf
    ret

.call_read_map_cell_word_for_screen_xy_505711:
    ld de, EncounterGrid_5D5D
    ld a, $04
    call ReadMapCellWordForScreenXY_5057
    ret

.call_load_encounter_monster_ids_to_work_buf4:
    ld de, EncounterGroup_5D8C
    call LoadEncounterMonsterIdsToWorkBuf
    ret

.call_read_map_cell_word_for_screen_xy_505712:
    ld de, EncounterGrid_5D9B
    ld a, $04
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505713:
    ld de, EncounterGrid_5DCA
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505714:
    ld de, EncounterGrid_5DE7
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505715:
    ld de, EncounterGrid_5DEF
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505716:
    ld de, EncounterGrid_5DF7
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505717:
    ld de, EncounterGrid_5E0C
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505718:
    ld de, EncounterGrid_5E14
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505719:
    ld de, EncounterGrid_5E2B
    ld a, $0c
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505720:
    ld de, EncounterGrid_6028
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505721:
    ld de, EncounterGrid_603D
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505722:
    ld de, EncounterGrid_6052
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505723:
    ld de, EncounterGrid_606B
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505724:
    ld de, EncounterGrid_6084
    ld a, $01
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505725:
    ld de, EncounterGrid_6097
    ld a, $03
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505726:
    ld de, EncounterGrid_60BA
    ld a, $03
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505727:
    ld de, EncounterGrid_60DD
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505728:
    ld de, EncounterGrid_60F2
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505729:
    ld de, EncounterGrid_6107
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505730:
    ld de, EncounterGrid_6120
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505731:
    ld de, EncounterGrid_6139
    ld a, $03
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505732:
    ld de, EncounterGrid_6160
    ld a, $03
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505733:
    ld de, EncounterGrid_6181
    ld a, $03
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505734:
    ld de, EncounterGrid_61A2
    ld a, $03
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505735:
    ld de, EncounterGrid_61BD
    ld a, $04
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505736:
    ld de, EncounterGrid_61FB
    ld a, $03
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505737:
    ld de, EncounterGrid_6220
    ld a, $06
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505738:
    ld de, EncounterGrid_62AB
    ld a, $03
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505739:
    ld de, EncounterGrid_62D2
    ld a, $03
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505740:
    ld de, EncounterGrid_62EB
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505741:
    ld de, EncounterGrid_6300
    ld a, $05
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505742:
    ld de, EncounterGrid_6382
    ld a, $01
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505743:
    ld de, EncounterGrid_6393
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505744:
    ld de, EncounterGrid_63AA
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

.call_read_map_cell_word_for_screen_xy_505745:
    ld de, EncounterGrid_63BF
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

; DE = the word at DE + 2 * A * (hMapScreenY & $0F) + 2 * (hMapScreenX & $0F); falls through
; (E-0122)
ReadMapCellWordForScreenXY_5057::
    sla a
    ld c, a
    ldh a, [hMapScreenY]
    and $0f
    call Multiply8
    ldh a, [hMapScreenX]
    and $0f
    sla a
    add_a_to_hl
    add hl, de
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a

; DE += 2; wWorkBuf = the number of non-zero entries (up to 5); copies their monster ids to wWorkBuf
; + $2 and replaces each with two bytes of its monster table entry (E-0127)
LoadEncounterMonsterIdsToWorkBuf::
    inc de
    inc de
    push de
    ld b, $00

.skip:
    ld a, [de]
    inc de
    or a
    jr z, .restore
    inc b
    ld a, b
    cp $05
    jr z, .restore
    jr .skip

.restore:
    pop de
    ld a, $05
    add e
    ld e, a
    jr nc, .set_work_buf
    inc d

.set_work_buf:
    ld a, b
    ld [wWorkBuf], a
    xor a
    ld [wWorkBuf + $1], a
    ld hl, wWorkBuf + $2

.loop:
    ld a, [de]
    inc de
    ld [hli], a
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, .loop
    ld a, [wWorkBuf]
    ld b, a
    ld hl, wWorkBuf + $2

.loop2:
    push bc
    ld a, [hli]
    ld [wMonsterId], a
    ld a, [hld]
    ld [wMonsterId + $1], a
    push hl
    ld a, $02
    ldh [hTemp0], a
    ld de, hTemp0
    ld c, $00
    farcall CopyMonsterTableBytesFromMonsterTable
    pop hl
    ldh a, [hTemp0]
    ld [hli], a
    ldh a, [hTemp1]
    ld [hli], a
    pop bc
    dec b
    jr nz, .loop2
    ret

RunBattleIntroKindCase_SetBattleKindTo02::
    ld a, $02
    ld [wBattleKind], a
    ret

RunBattleIntroKindCase_NextTableByte::
    call NextTableByte
    ld a, [wRandomLo]
    and $03
    ld hl, RunBattleIntroKindCase_Case00_WriteEncounterKindAndTemp0Etc_Data1
    add_a_to_hl
    ld a, [hl]
    ld [wEncounterKind], a
    ld a, [wMapType]
    and $07
    cp $01
    jr z, .read_map_screen_y
    or a
    jr nz, .read_key_world_floor

.read_map_screen_y:
    ldh a, [hMapScreenY]
    srl a
    and $fe
    ld c, a
    ldh a, [hMapScreenX]
    srl a
    srl a
    add c
    ld hl, wKeyWorldAreas
    add_a_to_hl
    ld a, [hl]
    ld c, a
    add a
    add a
    add c
    ld c, a
    call RunBattleIntroKindCase_Case01_NextRandomSeed
    ld a, $01
    ld [wBattleKind], a
    ret

.read_key_world_floor:
    ld a, [wKeyWorldFloor]
    add a
    add a
    ld hl, wKeyWorldFloorInfo
    add_a_to_hl
    ld a, [hl]
    push af
    and $0f
    srl a
    and $fe
    ld c, a
    pop af
    swap a
    and $0f
    srl a
    srl a
    add c
    ld hl, wKeyWorldAreas
    add_a_to_hl
    ld a, [hl]
    add a
    add a
    add a
    ld c, a
    call RunBattleIntroKindCase_Case01_NextRandomSeed
    ld a, $01
    ld [wBattleKind], a
    ret

RunBattleIntroKindCase_Case00_WriteEncounterKindAndTemp0Etc_Data1::
    db $00, $02, $01, $02

RunBattleIntroKindCase_Case00_WriteEncounterKindAndTemp0Etc_Data2::
    db $00, $01, $00, $01

RunBattleIntroKindCase_Case01_NextRandomSeed::
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, .skip2
    ld b, $03
    ld de, wEncounterMonsters

.loop:
    push bc
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and $07
    add c
    cp $20
    jr c, .skip
    ld a, $1f

.skip:
    add a
    ld hl, wKeyWorldMonsters
    add_a_to_hl
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hl]
    and $01
    ld [de], a
    inc de
    push de
    ld a, e
    sub $df
    ld e, a
    ld a, d
    sbc $cf
    ld d, a
    sra d
    rr e
    ld a, e
    add $e3
    ld e, a
    ld a, d
    adc $cf
    ld d, a
    ld a, [hl]
    srl a
    ld [de], a
    pop de
    pop bc
    dec b
    jr nz, .loop
    ret

.skip2:
    ld b, $03
    ld de, wEncounterMonsters

.loop2:
    push bc
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and $07
    add $20
    add a
    ld hl, wKeyWorldMonsters
    add_a_to_hl
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hl]
    and $01
    ld [de], a
    inc de
    push de
    ld a, e
    sub $df
    ld e, a
    ld a, d
    sbc $cf
    ld d, a
    sra d
    rr e
    ld a, e
    add $e3
    ld e, a
    ld a, d
    adc $cf
    ld d, a
    ld a, [hl]
    srl a
    ld [de], a
    pop de
    pop bc
    dec b
    jr nz, .loop2
    ret

RunBattleIntroKindCase_WriteBattleIntroFlagAndBattleKind::
    ld a, [wMapType]
    cp $82
    jr nz, .set_battle_kind_to_03
    ld a, $01
    ld [wBattleIntroFlag], a

.set_battle_kind_to_03:
    ld a, $03
    ld [wBattleKind], a
    ret

RunBattleIntroKindCase_SetBattleKindTo04::
    ld a, $04
    ld [wBattleKind], a
    ret

RunBattleIntroKindCase_SetBattleKindTo05::
    ld a, $05
    ld [wBattleKind], a
    ret

; runs the routine for wBattleTransitionStep (jump table of three); field mode state 3 (E-0122)
RunBattleTransitionStep::
    ld a, [wBattleTransitionStep]
    jumptable
    dw RunBattleTransitionStep_QueueMusic
    dw RunBattleTransitionStep_StagedSteps
    dw RunBattleTransitionStep_WriteGameModeAndModeStateEtc

RunBattleTransitionStep_QueueMusic::
    ld a, [wCurrentMusic]
    ld [wTransitionByteCD], a
    ld a, [wBattleTransitionSubStep]
    and $01
    sla a
    add $44
    call QueueMusic
    ld a, $03
    ldh [hSpriteWindowClipMode], a
    ldh a, [hScrollY]
    and $f8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add $00
    ld e, a
    ld a, d
    adc $98
    ld d, a
    ld a, d
    and $9b
    ld d, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add e
    ld e, a
    jr nc, .set_transition_bg_ptr_lo
    inc d

.set_transition_bg_ptr_lo:
    ld a, e
    ld [wTransitionBGPtrLo], a
    ld a, d
    ld [wTransitionBGPtrHi], a
    xor a
    ld [wTransitionCounter], a
    ld [wTransitionStage], a
    ld [wTransitionByte08], a
    ld hl, wBattleTransitionStep
    inc [hl]
    ret

RunBattleTransitionStep_WriteGameModeAndModeStateEtc::
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
    call RunBattleIntroKindCase
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wGameMode], a
    xor a
    ld [wModeState], a
    ld [wWorldMapState], a
    ld [wGameMode2Arg], a
    ld hl, wModeChangeRequest
    inc [hl]
    ld hl, wBGFillFlag
    inc [hl]
    ret

; by its sub-step: CheckStage, the transition counter, SetCounts
RunBattleTransitionStep_StagedSteps::
    ld a, [wBattleTransitionSubStep]
    jumptable
    dw RunBattleTransitionStep_Case01_CheckStage
    dw RunBattleTransitionStep_StagedSteps_ReadTransitionCounter
    dw RunBattleTransitionStep_Case01_SetCounts

; reads the transition stage, then advances the step
RunBattleTransitionStep_Case01_CheckStage::
    ld a, [wTransitionCounter]
    jumptable
    dw RunBattleTransitionStep_Case01_CheckStage_ReadTransitionStage
    dw RunBattleTransitionStep_Case01_CheckStage_AdvanceBattleTransitionStep

RunBattleTransitionStep_Case01_CheckStage_ReadTransitionStage::
    ld a, [wTransitionStage]
    cp $14
    jr nz, .read_transition_stage
    ld hl, wTransitionCounter
    inc [hl]
    ret

.read_transition_stage:
    ld a, [wTransitionStage]
    ld hl, $0000
    add_a_to_hl
    ld b, $09

.loop:
    push hl
    push bc
    call WriteTileC4AtTransitionBGPtrLoAndClearAttr
    pop bc
    pop hl
    ld a, l
    add $40
    ld l, a
    ld a, h
    adc $00
    ld h, a
    dec b
    jr nz, .loop
    ld a, [wTransitionStage]
    ld b, a
    ld a, $13
    sub b
    ld hl, $0020
    add_a_to_hl
    ld b, $09

.loop2:
    push hl
    push bc
    call WriteTileC4AtTransitionBGPtrLoAndClearAttr
    pop bc
    pop hl
    ld a, l
    add $40
    ld l, a
    ld a, h
    adc $00
    ld h, a
    dec b
    jr nz, .loop2
    ld hl, wTransitionStage
    inc [hl]
    ret

RunBattleTransitionStep_Case01_CheckStage_AdvanceBattleTransitionStep::
    ld hl, wBattleTransitionStep
    inc [hl]
    ret

; writes tile $C4 at the BG map address from
; WriteTileC4AtTransitionBGPtrLoAndClearAttr_AddHLToTransitionBGPtrLoInBGMap and, on CGB, attribute
; 0 in VRAM bank 1 (E-0122)
WriteTileC4AtTransitionBGPtrLoAndClearAttr::
    call WriteTileC4AtTransitionBGPtrLoAndClearAttr_AddHLToTransitionBGPtrLoInBGMap
    ld a, $c4
    call WriteVRAMByte
    ld a, [wIsCGB]
    or a
    ret z
    ld a, $01
    ldh [rVBK], a
    xor a
    call WriteVRAMByte
    ld a, $00
    ldh [rVBK], a
    ret

WriteTileC4AtTransitionBGPtrLoAndClearAttr_AddHLToTransitionBGPtrLoInBGMap::
    push bc
    ld b, l
    ld a, l
    and $e0
    ld l, a
    call AddHLToTransitionBGPtrLoInBGMap
    ld a, b
    and $1f
    jr z, .done
    ld b, a

.loop:
    call NextBGMapColumn_Bank0A
    dec b
    jr nz, .loop

.done:
    pop bc
    ret

; L = (L & $E0) | ((L + 1) & $1F): moves HL one entry right inside its 32-entry BG map row, wrapping
; at the row end; keeps AF (the same 15 bytes appear in 2 banks)
NextBGMapColumn_Bank0A::
    push af
    ld a, l
    and $e0
    push af
    ld a, l
    inc a
    and $1f
    ld l, a
    pop af
    or l
    ld l, a
    pop af
    ret

; HL = wTransitionBGPtrLo/wTransitionBGPtrHi + HL, the high byte's low 2 bits wrapped and its upper
; 6 bits kept from wTransitionBGPtrHi (stays inside one 1 KB BG map) (E-0117)
AddHLToTransitionBGPtrLoInBGMap::
    ld a, [wTransitionBGPtrLo]
    add l
    ld l, a
    ld a, [wTransitionBGPtrHi]
    adc h
    and $03
    ld h, a
    ld a, [wTransitionBGPtrHi]
    and $fc
    or h
    ld h, a
    ret

RunBattleTransitionStep_StagedSteps_ReadTransitionCounter::
    ld b, $06

RunBattleTransitionStep_StagedSteps_ReadTransitionCounter_ReadTransitionCounter::
    ld a, [wTransitionCounter]
    jumptable
    dw AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc
    dw AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01
    dw AddHLToTransitionBGPtrLoInBGMap_AdvanceBattleTransitionStep

AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc::
    push bc
    ld a, [wTransitionStage]
    cp $11
    jp c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_Skip
    cp $23
    jp c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_Skip2
    cp $33
    jp c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_ReadTransitionCountA
    cp $43
    jp c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_ReadTransitionCountA2
    cp $51
    jp c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_Skip
    cp $5f
    jp c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_Skip2
    cp $6b
    jp c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_ReadTransitionCountA
    cp $77
    jp c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_ReadTransitionCountA2
    cp $81
    jr c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_Skip
    cp $8b
    jp c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_Skip2
    cp $93
    jp c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_ReadTransitionCountA
    cp $9b
    jp c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_ReadTransitionCountA2
    cp $a1
    jr c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_Skip
    cp $a7
    jp c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_Skip2
    cp $ab
    jp c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_ReadTransitionCountA
    cp $af
    jp c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_ReadTransitionCountA2
    cp $b1
    jr c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_Skip
    jr AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_Skip2

AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01::
    push bc
    ld a, [wTransitionStage]
    cp $02
    jr c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_Skip2
    cp $04
    jr c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_Skip
    cp $08
    jp c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_ReadTransitionCountA2
    cp $0c
    jp c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_ReadTransitionCountA
    cp $12
    jr c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_Skip2
    cp $18
    jr c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_Skip
    cp $20
    jp c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_ReadTransitionCountA2
    cp $28
    jr c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_ReadTransitionCountA
    cp $32
    jr c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_Skip2
    cp $3c
    jr c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_Skip
    cp $48
    jr c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_ReadTransitionCountA2
    cp $54
    jr c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_ReadTransitionCountA
    cp $62
    jr c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_Skip2
    cp $70
    jr c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_Skip
    cp $80
    jr c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_ReadTransitionCountA2
    cp $90
    jr c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_ReadTransitionCountA
    cp $a2
    jr c, AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_Skip2
    jr AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_Skip

AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_Skip::
    or a
    jr nz, .read_transition_count_a
    ld hl, $0233
    ld a, l
    ld [wTransitionCountA], a
    ld a, h
    ld [wTransitionCountB], a

.read_transition_count_a:
    ld a, [wTransitionCountA]
    ld l, a
    ld a, [wTransitionCountB]
    ld h, a
    push hl
    call WriteTileC4AtTransitionBGPtrLoAndClearAttr
    pop hl
    ld a, l
    sub $20
    ld l, a
    ld a, h
    sbc $00
    ld h, a
    jr AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_SetTransitionCountA

AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_Skip2::
    or a
    jr nz, .read_transition_count_a
    ld hl, $012a
    ld a, l
    ld [wTransitionCountA], a
    ld a, h
    ld [wTransitionCountB], a

.read_transition_count_a:
    ld a, [wTransitionCountA]
    ld l, a
    ld a, [wTransitionCountB]
    ld h, a
    push hl
    call WriteTileC4AtTransitionBGPtrLoAndClearAttr
    pop hl
    ld a, l
    sub $01
    ld l, a
    ld a, h
    sbc $00
    ld h, a
    jr AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_SetTransitionCountA

AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_ReadTransitionCountA::
    ld a, [wTransitionCountA]
    ld l, a
    ld a, [wTransitionCountB]
    ld h, a
    push hl
    call WriteTileC4AtTransitionBGPtrLoAndClearAttr
    pop hl
    ld a, l
    add $20
    ld l, a
    ld a, h
    adc $00
    ld h, a
    jr AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_SetTransitionCountA

AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_ReadTransitionCountA2::
    ld a, [wTransitionCountA]
    ld l, a
    ld a, [wTransitionCountB]
    ld h, a
    push hl
    call WriteTileC4AtTransitionBGPtrLoAndClearAttr
    pop hl
    ld a, l
    add $01
    ld l, a
    ld a, h
    adc $00
    ld h, a

AddHLToTransitionBGPtrLoInBGMap_WriteTransitionCountAAndTransitionCountBEtc_Case01_SetTransitionCountA::
    ld a, l
    ld [wTransitionCountA], a
    ld a, h
    ld [wTransitionCountB], a
    ld hl, wTransitionStage
    inc [hl]
    ld a, [wTransitionStage]
    cp $b4
    jr nz, .restore
    ld hl, wTransitionCounter
    inc [hl]
    xor a
    ld [wTransitionStage], a

.restore:
    pop bc
    dec b
    jp nz, RunBattleTransitionStep_StagedSteps_ReadTransitionCounter_ReadTransitionCounter
    ret

AddHLToTransitionBGPtrLoInBGMap_AdvanceBattleTransitionStep::
    ld hl, wBattleTransitionStep
    inc [hl]
    ret

; sets the transition counts from the stage record, then advances
RunBattleTransitionStep_Case01_SetCounts::
    ld a, [wTransitionCounter]
    jumptable
    dw RunBattleTransitionStep_Case01_SetCounts_CheckTransitionStage
    dw RunBattleTransitionStep_Case01_SetCounts_ReturnAfterSetup
    dw RunBattleTransitionStep_Case01_SetCounts_AdvanceBattleTransitionStep

RunBattleTransitionStep_Case01_SetCounts_CheckTransitionStage::
    ld a, [wTransitionStage]
    or a
    jr nz, .read_transition_stage
    ld hl, $0000
    ld a, l
    ld [wTransitionCountA], a
    ld a, h
    ld [wTransitionCountB], a

.read_transition_stage:
    ld hl, RunBattleTransitionStep_Case01_SetCounts_CheckTransitionStage_Data1
    ld a, [wTransitionStage]
    add_a_to_hl
    ld b, [hl]
    ld hl, TransitionRowStepTable
    ld a, [wTransitionStage]
    add a
    add_a_to_hl
    ld a, [wTransitionCountA]
    ld e, a
    ld a, [wTransitionCountB]
    ld d, a
    call JumpToWordAtHL_Bank0A

.loop:
    push hl
    push bc
    call WriteTileC4AtTransitionBGPtrLoAndClearAttr
    pop bc
    pop hl
    inc hl
    dec b
    jr nz, .loop
    ld hl, RunBattleTransitionStep_Case01_SetCounts_CheckTransitionStage_Data1
    ld a, [wTransitionStage]
    add_a_to_hl
    ld b, [hl]
    ld a, [wTransitionCountA]
    ld l, a
    ld a, [wTransitionCountB]
    ld h, a

.loop2:
    push hl
    push bc
    call WriteTileC4AtTransitionBGPtrLoAndClearAttr
    pop bc
    pop hl
    inc hl
    dec b
    jr nz, .loop2
    push hl
    ld hl, RunBattleTransitionStep_Case01_SetCounts_CheckTransitionStage_Data2
    ld a, [wTransitionStage]
    add_a_to_hl
    ld b, [hl]
    pop hl
    dec hl

.loop3:
    push hl
    push bc
    call WriteTileC4AtTransitionBGPtrLoAndClearAttr
    pop bc
    pop hl
    ld a, l
    add $20
    ld l, a
    ld a, h
    adc $00
    ld h, a
    dec b
    jr nz, .loop3
    ld hl, RunBattleTransitionStep_Case01_SetCounts_CheckTransitionStage_Data2
    ld a, [wTransitionStage]
    add_a_to_hl
    ld b, [hl]
    ld a, [wTransitionCountA]
    ld l, a
    ld a, [wTransitionCountB]
    ld h, a

.loop4:
    push hl
    push bc
    call WriteTileC4AtTransitionBGPtrLoAndClearAttr
    pop bc
    pop hl
    ld a, l
    add $20
    ld l, a
    ld a, h
    adc $00
    ld h, a
    dec b
    jr nz, .loop4
    ld a, [wTransitionCountA]
    ld l, a
    ld a, [wTransitionCountB]
    ld h, a
    ld a, l
    add $21
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, l
    ld [wTransitionCountA], a
    ld a, h
    ld [wTransitionCountB], a
    ld hl, wTransitionStage
    inc [hl]
    ld hl, wTransitionCounter
    inc [hl]
    ld a, [wTransitionStage]
    cp $09
    ret nz
    ld hl, wTransitionCounter
    inc [hl]
    ret

RunBattleTransitionStep_Case01_SetCounts_ReturnAfterSetup::
    ld hl, wTransitionCounter
    dec [hl]
    ret

RunBattleTransitionStep_Case01_SetCounts_AdvanceBattleTransitionStep::
    ld hl, wBattleTransitionStep
    inc [hl]
    ret

; HL = the word at HL, then jp hl (E-0114)
JumpToWordAtHL_Bank0A::
    deref_hl
    jp hl

; handler 00 (entry 0 of TransitionRowStepTable)
TransitionRowStep00::
    ld a, e
    add $20
    ld e, a
    ld a, d
    adc $02
    ld d, a
    ld l, e
    ld h, d
    ret

; handler 01 (entry 1 of TransitionRowStepTable)
TransitionRowStep01::
    ld a, e
    add $e0
    ld e, a
    ld a, d
    adc $01
    ld d, a
    ld l, e
    ld h, d
    ret

; handler 02 (entry 2 of TransitionRowStepTable)
TransitionRowStep02::
    ld a, e
    add $a0
    ld e, a
    ld a, d
    adc $01
    ld d, a
    ld l, e
    ld h, d
    ret

; handler 03 (entry 3 of TransitionRowStepTable)
TransitionRowStep03::
    ld a, e
    add $60
    ld e, a
    ld a, d
    adc $01
    ld d, a
    ld l, e
    ld h, d
    ret

; handler 04 (entry 4 of TransitionRowStepTable)
TransitionRowStep04::
    ld a, e
    add $20
    ld e, a
    ld a, d
    adc $01
    ld d, a
    ld l, e
    ld h, d
    ret

; handler 05 (entry 5 of TransitionRowStepTable)
TransitionRowStep05::
    ld a, e
    add $e0
    ld e, a
    ld a, d
    adc $00
    ld d, a
    ld l, e
    ld h, d
    ret

; handler 06 (entry 6 of TransitionRowStepTable)
TransitionRowStep06::
    ld a, e
    add $a0
    ld e, a
    ld a, d
    adc $00
    ld d, a
    ld l, e
    ld h, d
    ret

; handler 07 (entry 7 of TransitionRowStepTable)
TransitionRowStep07::
    ld a, e
    add $60
    ld e, a
    ld a, d
    adc $00
    ld d, a
    ld l, e
    ld h, d
    ret

; handler 08 (entry 8 of TransitionRowStepTable)
TransitionRowStep08::
    ld a, e
    add $20
    ld e, a
    ld a, d
    adc $00
    ld d, a
    ld l, e
    ld h, d
    ret

RunBattleTransitionStep_Case01_SetCounts_CheckTransitionStage_Data1::
    db $14, $12, $10, $0e, $0c, $0a, $08, $06, $04

RunBattleTransitionStep_Case01_SetCounts_CheckTransitionStage_Data2::
    db $12, $10, $0e, $0c, $0a, $08, $06, $04, $02

; RunBattleTransitionStep_Case01_Case02_Case00 calls JumpToWordAtHL_Bank0A with HL = $560C + 2 *
; wTransitionStage and DE = wTransitionCountA/B; each target adds a constant ($220, $1E0, $1A0, ...)
; to DE and returns it in HL; the nine targets were the INCBIN slice at $5597 (E-0202, C1)
; record: routine adding this stage's step to DE
TransitionRowStepTable::
    dw TransitionRowStep00 ; id 0
    dw TransitionRowStep01 ; id 1
    dw TransitionRowStep02 ; id 2
    dw TransitionRowStep03 ; id 3
    dw TransitionRowStep04 ; id 4
    dw TransitionRowStep05 ; id 5
    dw TransitionRowStep06 ; id 6
    dw TransitionRowStep07 ; id 7
    dw TransitionRowStep08 ; id 8

; counts steps in wStepCounterLo (wrapping at 1000); every 100 steps and at 1000 updates the stored
; SRAM records by their state byte and field $6E (E-0130)
AdvanceStepCounterAndUpdateStoredRecords::
    ld a, [wScriptRunning]
    or a
    ret nz
    ld a, [wEncounterRate]
    and $7f
    ret z
    xor a
    ldh [hTemp0], a
    ld a, [wStepCounterLo]
    ld l, a
    ld a, [wStepCounterHi]
    ld h, a
    inc hl
    push hl
    ld a, $64
    call DivideHLByA
    or a
    jr nz, .restore
    ld a, $01
    ldh [hTemp0], a

.restore:
    pop hl
    ld a, l
    cp $e8
    jr nz, .set_step_counter_lo
    ld a, h
    cp $03
    jr nz, .set_step_counter_lo
    ldh a, [hTemp0]
    or $02
    ldh [hTemp0], a
    ld hl, $0000

.set_step_counter_lo:
    ld a, l
    ld [wStepCounterLo], a
    ld a, h
    ld [wStepCounterHi], a
    ldh a, [hTemp0]
    or a
    ret z
    ld a, $0a
    ld [rRAMG], a
    ld hl, sRecords
    ld a, $6b
    add_a_to_hl
    ld de, sRecords
    ld b, $1e

.loop:
    ld a, [de]
    or a
    jr z, .skip2
    dec a
    jr nz, .skip
    ldh a, [hTemp0]
    bit 1, a
    jr z, .skip2
    push de
    ld a, e
    add $6e
    ld e, a
    ld a, d
    adc $00
    ld d, a
    ld a, [de]
    pop de
    or a
    jr nz, .skip2
    push de
    ld a, [hli]
    ld e, a
    ld a, [hld]
    ld d, a
    cp $03
    jr nz, .next
    ld a, e
    cp $e7
    jr z, .restore2

.next:
    inc de
    ld a, e
    ld [hli], a
    ld a, d
    ld [hld], a

.restore2:
    pop de
    jr .skip2

.skip:
    push de
    ld a, [hli]
    ld e, a
    ld a, [hld]
    ld d, a
    cp e
    jr nz, .next2
    or a
    jr z, .restore3

.next2:
    dec de
    ld a, e
    ld [hli], a
    ld a, d
    ld [hld], a

.restore3:
    pop de

.skip2:
    ld a, e
    add $a5
    ld e, a
    ld a, d
    adc $00
    ld d, a
    ld a, l
    add $a5
    ld l, a
    ld a, h
    adc $00
    ld h, a
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG], a
    ret

UpdatePlayerMovement_Sub01_TestFlagBit::
    ld a, [wEncounterRate]
    and $7f
    ret z
    ld a, [wScriptRunning]
    or a
    ret nz
    ld de, EVENT_SCENE_LONG_FACES
    call TestFlagBit
    ret nc
    ld a, [wPartyCount]
    or a
    ret z
    ld b, a
    ld hl, wPartyList
    ld a, $0a
    ld [rRAMG], a

.loop:
    push bc
    ld a, [hl]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    bit 7, a
    jr nz, .restore
    ld a, [hl]
    ld c, MON_ITEM
    call LoadSRAMRecordByte
    cp $1b
    jr nz, .cp_1C
    ld c, $5d
    jr .call_load_sram_record_word

.cp_1C:
    cp $1c
    jr nz, .restore
    ld c, $61

.call_load_sram_record_word:
    push bc
    ld a, [hl]
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    pop bc
    dec c
    dec c
    push bc
    ld a, [hl]
    call LoadSRAMRecordWord
    pop bc
    ldh a, [hTemp0]
    cp e
    jr nz, .read_temp0
    ldh a, [hTemp1]
    cp d
    jr z, .restore

.read_temp0:
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    inc de
    push hl
    ld a, [hl]
    call SRAMRecordAddress
    ld a, e
    ld [hli], a
    ld a, d
    ld [hl], a
    pop hl

.restore:
    pop bc
    inc hl
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG], a
    ret

UpdatePlayerMovement_Sub01_WaitPlayerSpriteOverride::
    ldh a, [hPlayerSpriteOverride]
    bit 7, a
    ret z
    ld a, [wScriptRunning]
    or a
    ret nz
    ldh a, [hPlayerSpriteTimerLo]
    ld l, a
    ldh a, [hPlayerSpriteTimerHi]
    ld h, a
    dec hl
    ld a, l
    ldh [hPlayerSpriteTimerLo], a
    ld a, h
    ldh [hPlayerSpriteTimerHi], a
    ld a, h
    bit 7, a
    ret z
    ld a, $0a
    ld [wTalkEventGroup], a
    xor a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ret

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 8
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 64 words, up to its first group (E-0202, C1)
; record: one screen, row by row (8 per row): its encounter group
EncounterGrid_5773::
    dw EncounterGroup_57F3 ; id 0
    dw EncounterGroup_57F3 ; id 1
    dw EncounterGroup_57F3 ; id 2
    dw EncounterGroup_57F3 ; id 3
    dw EncounterGroup_57FE ; id 4
    dw EncounterGroup_5827 ; id 5
    dw EncounterGroup_5827 ; id 6
    dw EncounterGroup_5845 ; id 7
    dw EncounterGroup_57F3 ; id 8
    dw EncounterGroup_57F3 ; id 9
    dw EncounterGroup_57F3 ; id 10
    dw EncounterGroup_57F3 ; id 11
    dw EncounterGroup_57FE ; id 12
    dw EncounterGroup_57FE ; id 13
    dw EncounterGroup_5827 ; id 14
    dw EncounterGroup_5827 ; id 15
    dw EncounterGroup_57F3 ; id 16
    dw EncounterGroup_57F3 ; id 17
    dw EncounterGroup_57F3 ; id 18
    dw EncounterGroup_57FE ; id 19
    dw EncounterGroup_57FE ; id 20
    dw EncounterGroup_57FE ; id 21
    dw EncounterGroup_57FE ; id 22
    dw EncounterGroup_5827 ; id 23
    dw EncounterGroup_57F3 ; id 24
    dw EncounterGroup_57F3 ; id 25
    dw EncounterGroup_57F3 ; id 26
    dw EncounterGroup_57FE ; id 27
    dw EncounterGroup_57FE ; id 28
    dw EncounterGroup_57FE ; id 29
    dw EncounterGroup_5818 ; id 30
    dw EncounterGroup_5827 ; id 31
    dw EncounterGroup_57F3 ; id 32
    dw EncounterGroup_57F3 ; id 33
    dw EncounterGroup_57F3 ; id 34
    dw EncounterGroup_57F3 ; id 35
    dw EncounterGroup_5818 ; id 36
    dw EncounterGroup_5836 ; id 37
    dw EncounterGroup_5845 ; id 38
    dw EncounterGroup_5845 ; id 39
    dw EncounterGroup_580B ; id 40
    dw EncounterGroup_57F3 ; id 41
    dw EncounterGroup_57F3 ; id 42
    dw EncounterGroup_57F3 ; id 43
    dw EncounterGroup_5818 ; id 44
    dw EncounterGroup_5836 ; id 45
    dw EncounterGroup_5845 ; id 46
    dw EncounterGroup_5845 ; id 47
    dw EncounterGroup_580B ; id 48
    dw EncounterGroup_580B ; id 49
    dw EncounterGroup_580B ; id 50
    dw EncounterGroup_580B ; id 51
    dw EncounterGroup_5818 ; id 52
    dw EncounterGroup_5836 ; id 53
    dw EncounterGroup_5845 ; id 54
    dw EncounterGroup_5845 ; id 55
    dw EncounterGroup_57F3 ; id 56
    dw EncounterGroup_57F3 ; id 57
    dw EncounterGroup_580B ; id 58
    dw EncounterGroup_5818 ; id 59
    dw EncounterGroup_5818 ; id 60
    dw EncounterGroup_5836 ; id 61
    dw EncounterGroup_5845 ; id 62
    dw EncounterGroup_5845 ; id 63

; named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127
; below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 2 encounter word(s)
EncounterGroup_57F3::
    db $01 ; entry 0: wEncounterKind + 1
    db $07, $03, $07, $00, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0002 ; MonsterTable $002: SpotSlime
    dw $0003 ; MonsterTable $003: CactiBall

; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_57FE::
    db $01 ; entry 0: wEncounterKind + 1
    db $0b, $04, $08, $0b, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0002 ; MonsterTable $002: SpotSlime
    dw $0003 ; MonsterTable $003: CactiBall
    dw $0005 ; MonsterTable $005: Crestpent

EncounterGroup_580B::
    db $01 ; entry 0: wEncounterKind + 1
    db $0c, $05, $0a, $0c, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0002 ; MonsterTable $002: SpotSlime
    dw $0003 ; MonsterTable $003: CactiBall
    dw $0004 ; MonsterTable $004: TailEater

; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5818::
    db $01 ; entry 0: wEncounterKind + 1
    db $10, $05, $0a, $0c, $10, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0002 ; MonsterTable $002: SpotSlime
    dw $0003 ; MonsterTable $003: CactiBall
    dw $0004 ; MonsterTable $004: TailEater
    dw $0005 ; MonsterTable $005: Crestpent

EncounterGroup_5827::
    db $02 ; entry 0: wEncounterKind + 1
    db $0d, $02, $04, $09, $0d, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0002 ; MonsterTable $002: SpotSlime
    dw $0003 ; MonsterTable $003: CactiBall
    dw $0005 ; MonsterTable $005: Crestpent
    dw $0006 ; MonsterTable $006: KingCobra

EncounterGroup_5836::
    db $02 ; entry 0: wEncounterKind + 1
    db $0e, $02, $04, $09, $0e, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0002 ; MonsterTable $002: SpotSlime
    dw $0003 ; MonsterTable $003: CactiBall
    dw $0005 ; MonsterTable $005: Crestpent
    dw $0004 ; MonsterTable $004: TailEater

; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_5845::
    db $02 ; entry 0: wEncounterKind + 1
    db $14, $02, $04, $09, $0e, $14 ; limit for the random 0-127, then rising slot thresholds
    dw $0002 ; MonsterTable $002: SpotSlime
    dw $0003 ; MonsterTable $003: CactiBall
    dw $0005 ; MonsterTable $005: Crestpent
    dw $0004 ; MonsterTable $004: TailEater
    dw $0006 ; MonsterTable $006: KingCobra

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 4
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 16 words, up to its first group (E-0202, C1)
; record: one screen, row by row (4 per row): its encounter group
EncounterGrid_5856::
    dw EncounterGroup_5881 ; id 0
    dw EncounterGroup_5881 ; id 1
    dw EncounterGroup_5881 ; id 2
    dw EncounterGroup_5881 ; id 3
    dw EncounterGroup_5881 ; id 4
    dw EncounterGroup_5881 ; id 5
    dw EncounterGroup_5881 ; id 6
    dw EncounterGroup_5881 ; id 7
    dw EncounterGroup_5881 ; id 8
    dw EncounterGroup_5881 ; id 9
    dw EncounterGroup_5881 ; id 10
    dw EncounterGroup_5881 ; id 11
    dw EncounterGroup_5881 ; id 12
    dw EncounterGroup_5876 ; id 13
    dw EncounterGroup_5876 ; id 14
    dw EncounterGroup_5876 ; id 15

; named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127
; below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 2 encounter word(s)
EncounterGroup_5876::
    db $02 ; entry 0: wEncounterKind + 1
    db $08, $04, $08, $00, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0180 ; MonsterTable $180: GiantWorm
    dw $0181 ; MonsterTable $181: Spooky

; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_5881::
    db $02 ; entry 0: wEncounterKind + 1
    db $0b, $03, $06, $0b, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0180 ; MonsterTable $180: GiantWorm
    dw $0181 ; MonsterTable $181: Spooky
    dw $0184 ; MonsterTable $184: MadCandle

; passed directly in DE to RunBattleIntroKindCase_Case00_Sub01; RunBattleIntroKindCase_Case00_Sub01
; draws three times a random 0-127 below byte 1 and stores the word of the first slot whose
; threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero
; threshold (E-0202, C1)
EncounterGroup_588E::
    db $02 ; entry 0: wEncounterKind + 1
    db $0c, $05, $0a, $0c, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0180 ; MonsterTable $180: GiantWorm
    dw $0181 ; MonsterTable $181: Spooky
    dw $0186 ; MonsterTable $186: Anemon

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 8
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 64 words, up to its first group (E-0202, C1)
; record: one screen, row by row (8 per row): its encounter group
EncounterGrid_589B::
    dw EncounterGroup_591B ; id 0
    dw EncounterGroup_59BD ; id 1
    dw EncounterGroup_59BD ; id 2
    dw EncounterGroup_595B ; id 3
    dw EncounterGroup_596A ; id 4
    dw EncounterGroup_597B ; id 5
    dw EncounterGroup_597B ; id 6
    dw EncounterGroup_598A ; id 7
    dw EncounterGroup_591B ; id 8
    dw EncounterGroup_59BD ; id 9
    dw EncounterGroup_595B ; id 10
    dw EncounterGroup_596A ; id 11
    dw EncounterGroup_597B ; id 12
    dw EncounterGroup_597B ; id 13
    dw EncounterGroup_597B ; id 14
    dw EncounterGroup_591B ; id 15
    dw EncounterGroup_591B ; id 16
    dw EncounterGroup_59BD ; id 17
    dw EncounterGroup_595B ; id 18
    dw EncounterGroup_5939 ; id 19
    dw EncounterGroup_595B ; id 20
    dw EncounterGroup_599B ; id 21
    dw EncounterGroup_599B ; id 22
    dw EncounterGroup_591B ; id 23
    dw EncounterGroup_594A ; id 24
    dw EncounterGroup_5939 ; id 25
    dw EncounterGroup_5939 ; id 26
    dw EncounterGroup_59E6 ; id 27
    dw EncounterGroup_594A ; id 28
    dw EncounterGroup_59AC ; id 29
    dw EncounterGroup_59AC ; id 30
    dw EncounterGroup_591B ; id 31
    dw EncounterGroup_594A ; id 32
    dw EncounterGroup_594A ; id 33
    dw EncounterGroup_59F7 ; id 34
    dw EncounterGroup_5A08 ; id 35
    dw EncounterGroup_591B ; id 36
    dw EncounterGroup_59AC ; id 37
    dw EncounterGroup_59AC ; id 38
    dw EncounterGroup_591B ; id 39
    dw EncounterGroup_5939 ; id 40
    dw EncounterGroup_5939 ; id 41
    dw EncounterGroup_5A19 ; id 42
    dw EncounterGroup_5A2A ; id 43
    dw EncounterGroup_5928 ; id 44
    dw EncounterGroup_591B ; id 45
    dw EncounterGroup_591B ; id 46
    dw EncounterGroup_591B ; id 47
    dw EncounterGroup_59CA ; id 48
    dw EncounterGroup_59CA ; id 49
    dw EncounterGroup_59D7 ; id 50
    dw EncounterGroup_5928 ; id 51
    dw EncounterGroup_5928 ; id 52
    dw EncounterGroup_5928 ; id 53
    dw EncounterGroup_591B ; id 54
    dw EncounterGroup_591B ; id 55
    dw EncounterGroup_591B ; id 56
    dw EncounterGroup_591B ; id 57
    dw EncounterGroup_59D7 ; id 58
    dw EncounterGroup_59D7 ; id 59
    dw EncounterGroup_5928 ; id 60
    dw EncounterGroup_5928 ; id 61
    dw EncounterGroup_591B ; id 62
    dw EncounterGroup_591B ; id 63

; named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127
; below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_591B::
    db $03 ; entry 0: wEncounterKind + 1
    db $0c, $04, $08, $0c, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0009 ; MonsterTable $009: Slime
    dw $000a ; MonsterTable $00A: Antbear
    dw $000c ; MonsterTable $00C: Eggplaton

; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_5928::
    db $03 ; entry 0: wEncounterKind + 1
    db $12, $03, $07, $0b, $0f, $12 ; limit for the random 0-127, then rising slot thresholds
    dw $0009 ; MonsterTable $009: Slime
    dw $000a ; MonsterTable $00A: Antbear
    dw $000b ; MonsterTable $00B: Dracky
    dw $000c ; MonsterTable $00C: Eggplaton
    dw $0010 ; MonsterTable $010: ArmyAnt

EncounterGroup_5939::
    db $03 ; entry 0: wEncounterKind + 1
    db $12, $03, $07, $0b, $10, $12 ; limit for the random 0-127, then rising slot thresholds
    dw $0009 ; MonsterTable $009: Slime
    dw $000b ; MonsterTable $00B: Dracky
    dw $000c ; MonsterTable $00C: Eggplaton
    dw $0010 ; MonsterTable $010: ArmyAnt
    dw $0011 ; MonsterTable $011: MadGopher

EncounterGroup_594A::
    db $03 ; entry 0: wEncounterKind + 1
    db $17, $05, $0a, $0d, $12, $17 ; limit for the random 0-127, then rising slot thresholds
    dw $0277 ; MonsterTable $277: Healer
    dw $000b ; MonsterTable $00B: Dracky
    dw $000c ; MonsterTable $00C: Eggplaton
    dw $0010 ; MonsterTable $010: ArmyAnt
    dw $0011 ; MonsterTable $011: MadGopher

; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_595B::
    db $03 ; entry 0: wEncounterKind + 1
    db $0f, $03, $06, $0a, $0f, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $018b ; MonsterTable $18B: MiniDrak
    dw $000c ; MonsterTable $00C: Eggplaton
    dw $0010 ; MonsterTable $010: ArmyAnt
    dw $0011 ; MonsterTable $011: MadGopher

EncounterGroup_596A::
    db $03 ; entry 0: wEncounterKind + 1
    db $15, $05, $08, $0d, $12, $15 ; limit for the random 0-127, then rising slot thresholds
    dw $018b ; MonsterTable $18B: MiniDrak
    dw $0014 ; MonsterTable $014: Poisongon
    dw $0010 ; MonsterTable $010: ArmyAnt
    dw $0011 ; MonsterTable $011: MadGopher
    dw $0012 ; MonsterTable $012: 1EyeClown

EncounterGroup_597B::
    db $03 ; entry 0: wEncounterKind + 1
    db $10, $03, $07, $0c, $10, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0014 ; MonsterTable $014: Poisongon
    dw $0187 ; MonsterTable $187: ArrowDog
    dw $0188 ; MonsterTable $188: Pyuro
    dw $0012 ; MonsterTable $012: 1EyeClown

EncounterGroup_598A::
    db $03 ; entry 0: wEncounterKind + 1
    db $16, $05, $0a, $0c, $11, $16 ; limit for the random 0-127, then rising slot thresholds
    dw $0014 ; MonsterTable $014: Poisongon
    dw $0187 ; MonsterTable $187: ArrowDog
    dw $000f ; MonsterTable $00F: Wyvern
    dw $0188 ; MonsterTable $188: Pyuro
    dw $0012 ; MonsterTable $012: 1EyeClown

EncounterGroup_599B::
    db $03 ; entry 0: wEncounterKind + 1
    db $17, $03, $08, $0d, $12, $17 ; limit for the random 0-127, then rising slot thresholds
    dw $0013 ; MonsterTable $013: Snaily
    dw $0014 ; MonsterTable $014: Poisongon
    dw $0187 ; MonsterTable $187: ArrowDog
    dw $0188 ; MonsterTable $188: Pyuro
    dw $0012 ; MonsterTable $012: 1EyeClown

EncounterGroup_59AC::
    db $03 ; entry 0: wEncounterKind + 1
    db $14, $03, $07, $0c, $0f, $14 ; limit for the random 0-127, then rising slot thresholds
    dw $018d ; MonsterTable $18D: DragonKid
    dw $0187 ; MonsterTable $187: ArrowDog
    dw $0189 ; MonsterTable $189: DanceVegi
    dw $0188 ; MonsterTable $188: Pyuro
    dw $018a ; MonsterTable $18A: Brushead

EncounterGroup_59BD::
    db $03 ; entry 0: wEncounterKind + 1
    db $0e, $04, $09, $0e, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $018b ; MonsterTable $18B: MiniDrak
    dw $0189 ; MonsterTable $189: DanceVegi
    dw $018a ; MonsterTable $18A: Brushead

EncounterGroup_59CA::
    db $03 ; entry 0: wEncounterKind + 1
    db $0e, $04, $09, $0e, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $018d ; MonsterTable $18D: DragonKid
    dw $018c ; MonsterTable $18C: Pteranod
    dw $018e ; MonsterTable $18E: CatFly

EncounterGroup_59D7::
    db $03 ; entry 0: wEncounterKind + 1
    db $0e, $05, $0a, $0c, $0e, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0009 ; MonsterTable $009: Slime
    dw $000b ; MonsterTable $00B: Dracky
    dw $0189 ; MonsterTable $189: DanceVegi
    dw $018a ; MonsterTable $18A: Brushead

EncounterGroup_59E6::
    db $03 ; entry 0: wEncounterKind + 1
    db $10, $01, $03, $04, $0a, $10 ; limit for the random 0-127, then rising slot thresholds
    dw $0277 ; MonsterTable $277: Healer
    dw $000b ; MonsterTable $00B: Dracky
    dw $000c ; MonsterTable $00C: Eggplaton
    dw $0010 ; MonsterTable $010: ArmyAnt
    dw $0011 ; MonsterTable $011: MadGopher

EncounterGroup_59F7::
    db $03 ; entry 0: wEncounterKind + 1
    db $13, $02, $03, $04, $0c, $13 ; limit for the random 0-127, then rising slot thresholds
    dw $0009 ; MonsterTable $009: Slime
    dw $000b ; MonsterTable $00B: Dracky
    dw $000c ; MonsterTable $00C: Eggplaton
    dw $0010 ; MonsterTable $010: ArmyAnt
    dw $0011 ; MonsterTable $011: MadGopher

EncounterGroup_5A08::
    db $03 ; entry 0: wEncounterKind + 1
    db $13, $01, $03, $04, $0b, $13 ; limit for the random 0-127, then rising slot thresholds
    dw $0009 ; MonsterTable $009: Slime
    dw $000b ; MonsterTable $00B: Dracky
    dw $000c ; MonsterTable $00C: Eggplaton
    dw $0010 ; MonsterTable $010: ArmyAnt
    dw $0011 ; MonsterTable $011: MadGopher

EncounterGroup_5A19::
    db $03 ; entry 0: wEncounterKind + 1
    db $13, $01, $03, $05, $0a, $13 ; limit for the random 0-127, then rising slot thresholds
    dw $0009 ; MonsterTable $009: Slime
    dw $000b ; MonsterTable $00B: Dracky
    dw $000c ; MonsterTable $00C: Eggplaton
    dw $0010 ; MonsterTable $010: ArmyAnt
    dw $0011 ; MonsterTable $011: MadGopher

EncounterGroup_5A2A::
    db $03 ; entry 0: wEncounterKind + 1
    db $10, $01, $03, $05, $07, $10 ; limit for the random 0-127, then rising slot thresholds
    dw $0009 ; MonsterTable $009: Slime
    dw $000b ; MonsterTable $00B: Dracky
    dw $000c ; MonsterTable $00C: Eggplaton
    dw $0010 ; MonsterTable $010: ArmyAnt
    dw $0011 ; MonsterTable $011: MadGopher

; passed directly in DE to RunBattleIntroKindCase_Case00_Sub01; RunBattleIntroKindCase_Case00_Sub01
; draws three times a random 0-127 below byte 1 and stores the word of the first slot whose
; threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero
; threshold (E-0202, C1)
EncounterGroup_5A3B::
    db $03 ; entry 0: wEncounterKind + 1
    db $12, $04, $08, $0b, $0e, $12 ; limit for the random 0-127, then rising slot thresholds
    dw $001d ; MonsterTable $01D: Petiteel
    dw $001f ; MonsterTable $01F: Merman
    dw $0018 ; MonsterTable $018: Gamanian
    dw $0020 ; MonsterTable $020: Octokid
    dw $0021 ; MonsterTable $021: RogueWave

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 4
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 16 words, up to its first group (E-0202, C1)
; record: one screen, row by row (4 per row): its encounter group
EncounterGrid_5A4C::
    dw EncounterGroup_5A6C ; id 0
    dw EncounterGroup_5A6C ; id 1
    dw EncounterGroup_5A6C ; id 2
    dw EncounterGroup_5A6C ; id 3
    dw EncounterGroup_5A6C ; id 4
    dw EncounterGroup_5A6C ; id 5
    dw EncounterGroup_5A6C ; id 6
    dw EncounterGroup_5A6C ; id 7
    dw EncounterGroup_5A6C ; id 8
    dw EncounterGroup_5A6C ; id 9
    dw EncounterGroup_5A6C ; id 10
    dw EncounterGroup_5A6C ; id 11
    dw EncounterGroup_5A6C ; id 12
    dw EncounterGroup_5A6C ; id 13
    dw EncounterGroup_5A6C ; id 14
    dw EncounterGroup_5A6C ; id 15

; named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127
; below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5A6C::
    db $03 ; entry 0: wEncounterKind + 1
    db $0f, $03, $05, $0a, $0f, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0022 ; MonsterTable $022: PearlGel
    dw $0015 ; MonsterTable $015: Moray
    dw $0017 ; MonsterTable $017: PutreFish
    dw $0018 ; MonsterTable $018: Gamanian

; no reference found; it follows the group before it; RunBattleIntroKindCase_Case00_Sub01 draws
; three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold
; (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold
; (E-0202, C1)
EncounterGroup_5A7B::
    db $02 ; entry 0: wEncounterKind + 1
    db $0f, $03, $05, $0a, $0f, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0022 ; MonsterTable $022: PearlGel
    dw $0015 ; MonsterTable $015: Moray
    dw $0017 ; MonsterTable $017: PutreFish
    dw $0018 ; MonsterTable $018: Gamanian

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 4
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 16 words, up to its first group (E-0202, C1)
; record: one screen, row by row (4 per row): its encounter group
EncounterGrid_5A8A::
    dw EncounterGroup_5AAA ; id 0
    dw EncounterGroup_5AAA ; id 1
    dw EncounterGroup_5AAA ; id 2
    dw EncounterGroup_5AAA ; id 3
    dw EncounterGroup_5AAA ; id 4
    dw EncounterGroup_5AAA ; id 5
    dw EncounterGroup_5AAA ; id 6
    dw EncounterGroup_5AAA ; id 7
    dw EncounterGroup_5AAA ; id 8
    dw EncounterGroup_5AAA ; id 9
    dw EncounterGroup_5AAA ; id 10
    dw EncounterGroup_5AAA ; id 11
    dw EncounterGroup_5AAA ; id 12
    dw EncounterGroup_5AAA ; id 13
    dw EncounterGroup_5AAA ; id 14
    dw EncounterGroup_5AAA ; id 15

; named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127
; below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_5AAA::
    db $03 ; entry 0: wEncounterKind + 1
    db $0c, $04, $08, $0c, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0024 ; MonsterTable $024: AquaHawk
    dw $0025 ; MonsterTable $025: DarkEye
    dw $0027 ; MonsterTable $027: EvilWand

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 4
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 12 words, up to its first group (E-0202, C1)
EncounterGrid_5AB7::
    dw EncounterGroup_5ACF ; id 0
    dw EncounterGroup_5ACF ; id 1
    dw EncounterGroup_5ACF ; id 2
    dw EncounterGroup_5ACF ; id 3
    dw EncounterGroup_5ACF ; id 4
    dw EncounterGroup_5ACF ; id 5
    dw EncounterGroup_5ACF ; id 6
    dw EncounterGroup_5ACF ; id 7
    dw EncounterGroup_5ACF ; id 8
    dw EncounterGroup_5ACF ; id 9
    dw EncounterGroup_5ACF ; id 10
    dw EncounterGroup_5ACF ; id 11

; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5ACF::
    db $03 ; entry 0: wEncounterKind + 1
    db $12, $03, $08, $0d, $12, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0023 ; MonsterTable $023: Tortragon
    dw $0024 ; MonsterTable $024: AquaHawk
    dw $0025 ; MonsterTable $025: DarkEye
    dw $0027 ; MonsterTable $027: EvilWand

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 3
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 9 words, up to its first group (E-0202, C1)
; record: one screen, row by row (3 per row): its encounter group
EncounterGrid_5ADE::
    dw EncounterGroup_5AF0 ; id 0
    dw EncounterGroup_5AF0 ; id 1
    dw EncounterGroup_5AF0 ; id 2
    dw EncounterGroup_5AF0 ; id 3
    dw EncounterGroup_5AF0 ; id 4
    dw EncounterGroup_5AF0 ; id 5
    dw EncounterGroup_5AF0 ; id 6
    dw EncounterGroup_5AF0 ; id 7
    dw EncounterGroup_5AF0 ; id 8

; named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127
; below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
EncounterGroup_5AF0::
    db $03 ; entry 0: wEncounterKind + 1
    db $0f, $03, $05, $0a, $0f, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $018d ; MonsterTable $18D: DragonKid
    dw $0023 ; MonsterTable $023: Tortragon
    dw $0019 ; MonsterTable $019: SpikyBoy
    dw $001e ; MonsterTable $01E: RotRaven

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 2
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 4 words, up to its first group (E-0202, C1)
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_5AFF::
    dw EncounterGroup_5B07 ; id 0
    dw EncounterGroup_5B07 ; id 1
    dw EncounterGroup_5B07 ; id 2
    dw EncounterGroup_5B07 ; id 3

; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_5B07::
    db $03 ; entry 0: wEncounterKind + 1
    db $0c, $04, $08, $0c, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0013 ; MonsterTable $013: Snaily
    dw $0026 ; MonsterTable $026: RayGigas
    dw $0016 ; MonsterTable $016: Eyeder

EncounterGrid_5B14::
    dw EncounterGroup_5B1C ; id 0
    dw EncounterGroup_5B1C ; id 1
    dw EncounterGroup_5B1C ; id 2
    dw EncounterGroup_5B1C ; id 3

EncounterGroup_5B1C::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $02, $06, $0a, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $000f ; MonsterTable $00F: Wyvern
    dw $0012 ; MonsterTable $012: 1EyeClown
    dw $0016 ; MonsterTable $016: Eyeder

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 3
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 3 words, up to its first group (E-0202, C1)
; record: one screen, row by row (3 per row): its encounter group
EncounterGrid_5B29::
    dw EncounterGroup_5B2F ; id 0
    dw EncounterGroup_5B2F ; id 1
    dw EncounterGroup_5B2F ; id 2

; named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127
; below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 2 encounter word(s)
EncounterGroup_5B2F::
    db $02 ; entry 0: wEncounterKind + 1
    db $08, $04, $08, $00, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0026 ; MonsterTable $026: RayGigas
    dw $000e ; MonsterTable $00E: Hork

; no reference found; it follows the group before it; RunBattleIntroKindCase_Case00_Sub01 draws
; three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold
; (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold
; (E-0202, C1)
EncounterGroup_5B3A::
    db $02 ; entry 0: wEncounterKind + 1
    db $08, $04, $08, $00, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0026 ; MonsterTable $026: RayGigas
    dw $000e ; MonsterTable $00E: Hork

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 3
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 3 words, up to its first group (E-0202, C1)
; record: one screen, row by row (3 per row): its encounter group
EncounterGrid_5B45::
    dw EncounterGroup_5B4B ; id 0
    dw EncounterGroup_5B4B ; id 1
    dw EncounterGroup_5B4B ; id 2

; named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127
; below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_5B4B::
    db $02 ; entry 0: wEncounterKind + 1
    db $0b, $04, $08, $0b, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0026 ; MonsterTable $026: RayGigas
    dw $000e ; MonsterTable $00E: Hork
    dw $000d ; MonsterTable $00D: JewelBag

EncounterGrid_5B58::
    dw EncounterGroup_5B5E ; id 0
    dw EncounterGroup_5B5E ; id 1
    dw EncounterGroup_5B5E ; id 2

EncounterGroup_5B5E::
    db $03 ; entry 0: wEncounterKind + 1
    db $0b, $04, $08, $0b, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0026 ; MonsterTable $026: RayGigas
    dw $000e ; MonsterTable $00E: Hork
    dw $000d ; MonsterTable $00D: JewelBag

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 12
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 144 words, up to its first group (E-0202, C1)
; record: one screen, row by row (12 per row): its encounter group
EncounterGrid_5B6B::
    dw EncounterGroup_5C8B ; id 0
    dw EncounterGroup_5C8B ; id 1
    dw EncounterGroup_5C8B ; id 2
    dw EncounterGroup_5C8B ; id 3
    dw EncounterGroup_5CA3 ; id 4
    dw EncounterGroup_5CA3 ; id 5
    dw EncounterGroup_5C8B ; id 6
    dw EncounterGroup_5C8B ; id 7
    dw EncounterGroup_5C8B ; id 8
    dw EncounterGroup_5C8B ; id 9
    dw EncounterGroup_5C8B ; id 10
    dw EncounterGroup_5C8B ; id 11
    dw EncounterGroup_5C8B ; id 12
    dw EncounterGroup_5C8B ; id 13
    dw EncounterGroup_5C8B ; id 14
    dw EncounterGroup_5C8B ; id 15
    dw EncounterGroup_5CA3 ; id 16
    dw EncounterGroup_5CA3 ; id 17
    dw EncounterGroup_5CA3 ; id 18
    dw EncounterGroup_5CA3 ; id 19
    dw EncounterGroup_5C8B ; id 20
    dw EncounterGroup_5C8B ; id 21
    dw EncounterGroup_5C8B ; id 22
    dw EncounterGroup_5C8B ; id 23
    dw EncounterGroup_5C8B ; id 24
    dw EncounterGroup_5C8B ; id 25
    dw EncounterGroup_5C8B ; id 26
    dw EncounterGroup_5C8B ; id 27
    dw EncounterGroup_5CA3 ; id 28
    dw EncounterGroup_5CA3 ; id 29
    dw EncounterGroup_5CA3 ; id 30
    dw EncounterGroup_5C96 ; id 31
    dw EncounterGroup_5C96 ; id 32
    dw EncounterGroup_5C96 ; id 33
    dw EncounterGroup_5C96 ; id 34
    dw EncounterGroup_5C8B ; id 35
    dw EncounterGroup_5C8B ; id 36
    dw EncounterGroup_5C8B ; id 37
    dw EncounterGroup_5C8B ; id 38
    dw EncounterGroup_5C8B ; id 39
    dw EncounterGroup_5C8B ; id 40
    dw EncounterGroup_5CB4 ; id 41
    dw EncounterGroup_5CB4 ; id 42
    dw EncounterGroup_5CB4 ; id 43
    dw EncounterGroup_5CC3 ; id 44
    dw EncounterGroup_5C96 ; id 45
    dw EncounterGroup_5C96 ; id 46
    dw EncounterGroup_5C96 ; id 47
    dw EncounterGroup_5C8B ; id 48
    dw EncounterGroup_5C8B ; id 49
    dw EncounterGroup_5C8B ; id 50
    dw EncounterGroup_5C8B ; id 51
    dw EncounterGroup_5C8B ; id 52
    dw EncounterGroup_5CB4 ; id 53
    dw EncounterGroup_5CB4 ; id 54
    dw EncounterGroup_5CB4 ; id 55
    dw EncounterGroup_5CC3 ; id 56
    dw EncounterGroup_5CD2 ; id 57
    dw EncounterGroup_5C96 ; id 58
    dw EncounterGroup_5C96 ; id 59
    dw EncounterGroup_5C8B ; id 60
    dw EncounterGroup_5C8B ; id 61
    dw EncounterGroup_5C8B ; id 62
    dw EncounterGroup_5C8B ; id 63
    dw EncounterGroup_5CDF ; id 64
    dw EncounterGroup_5CB4 ; id 65
    dw EncounterGroup_5CB4 ; id 66
    dw EncounterGroup_5CB4 ; id 67
    dw EncounterGroup_5CD2 ; id 68
    dw EncounterGroup_5CD2 ; id 69
    dw EncounterGroup_5C96 ; id 70
    dw EncounterGroup_5C96 ; id 71
    dw EncounterGroup_5C8B ; id 72
    dw EncounterGroup_5CDF ; id 73
    dw EncounterGroup_5CDF ; id 74
    dw EncounterGroup_5CDF ; id 75
    dw EncounterGroup_5CDF ; id 76
    dw EncounterGroup_5CDF ; id 77
    dw EncounterGroup_5CDF ; id 78
    dw EncounterGroup_5C8B ; id 79
    dw EncounterGroup_5C8B ; id 80
    dw EncounterGroup_5D2E ; id 81
    dw EncounterGroup_5D2E ; id 82
    dw EncounterGroup_5D2E ; id 83
    dw EncounterGroup_5C8B ; id 84
    dw EncounterGroup_5CEE ; id 85
    dw EncounterGroup_5CEE ; id 86
    dw EncounterGroup_5CEE ; id 87
    dw EncounterGroup_5CDF ; id 88
    dw EncounterGroup_5CDF ; id 89
    dw EncounterGroup_5CDF ; id 90
    dw EncounterGroup_5C8B ; id 91
    dw EncounterGroup_5D3D ; id 92
    dw EncounterGroup_5D2E ; id 93
    dw EncounterGroup_5D2E ; id 94
    dw EncounterGroup_5C8B ; id 95
    dw EncounterGroup_5C8B ; id 96
    dw EncounterGroup_5C8B ; id 97
    dw EncounterGroup_5CEE ; id 98
    dw EncounterGroup_5CEE ; id 99
    dw EncounterGroup_5CEE ; id 100
    dw EncounterGroup_5C8B ; id 101
    dw EncounterGroup_5C8B ; id 102
    dw EncounterGroup_5D0E ; id 103
    dw EncounterGroup_5D1D ; id 104
    dw EncounterGroup_5D1D ; id 105
    dw EncounterGroup_5D1D ; id 106
    dw EncounterGroup_5C8B ; id 107
    dw EncounterGroup_5C8B ; id 108
    dw EncounterGroup_5CEE ; id 109
    dw EncounterGroup_5CEE ; id 110
    dw EncounterGroup_5CEE ; id 111
    dw EncounterGroup_5D0E ; id 112
    dw EncounterGroup_5D0E ; id 113
    dw EncounterGroup_5D0E ; id 114
    dw EncounterGroup_5D0E ; id 115
    dw EncounterGroup_5D1D ; id 116
    dw EncounterGroup_5D1D ; id 117
    dw EncounterGroup_5D1D ; id 118
    dw EncounterGroup_5D1D ; id 119
PointerRun_0A_438D_Entry03::
    dw EncounterGroup_5CEE ; id 120
    dw EncounterGroup_5CFD ; id 121
    dw EncounterGroup_5CEE ; id 122
    dw EncounterGroup_5CEE ; id 123
    dw EncounterGroup_5D0E ; id 124
    dw EncounterGroup_5D0E ; id 125
    dw EncounterGroup_5D0E ; id 126
    dw EncounterGroup_5C8B ; id 127
    dw EncounterGroup_5D1D ; id 128
    dw EncounterGroup_5D1D ; id 129
    dw EncounterGroup_5D1D ; id 130
    dw EncounterGroup_5D1D ; id 131
    dw EncounterGroup_5CEE ; id 132
    dw EncounterGroup_5CEE ; id 133
    dw EncounterGroup_5CEE ; id 134
    dw EncounterGroup_5C8B ; id 135
    dw EncounterGroup_5C8B ; id 136
    dw EncounterGroup_5C8B ; id 137
    dw EncounterGroup_5C8B ; id 138
    dw EncounterGroup_5C8B ; id 139
    dw EncounterGroup_5C8B ; id 140
    dw EncounterGroup_5D1D ; id 141
    dw EncounterGroup_5D1D ; id 142
    dw EncounterGroup_5D1D ; id 143

; record: wEncounterKind + 1; random limit and five slot thresholds; 2 encounter word(s)
EncounterGroup_5C8B::
    db $01 ; entry 0: wEncounterKind + 1
    db $07, $03, $07, $00, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0002 ; MonsterTable $002: SpotSlime
    dw $0003 ; MonsterTable $003: CactiBall

; named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127
; below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_5C96::
    db $03 ; entry 0: wEncounterKind + 1
    db $0e, $04, $09, $0e, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0036 ; MonsterTable $036: Gulpple
    dw $003c ; MonsterTable $03C: WingSlime
    dw $0191 ; MonsterTable $191: BeastNite

; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_5CA3::
    db $03 ; entry 0: wEncounterKind + 1
    db $15, $04, $09, $0e, $11, $15 ; limit for the random 0-127, then rising slot thresholds
    dw $0038 ; MonsterTable $038: Almiraj
    dw $002b ; MonsterTable $02B: Yeti
    dw $003b ; MonsterTable $03B: Saccer
    dw $0036 ; MonsterTable $036: Gulpple
    dw $003c ; MonsterTable $03C: WingSlime

; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5CB4::
    db $03 ; entry 0: wEncounterKind + 1
    db $12, $05, $09, $0d, $12, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $002a ; MonsterTable $02A: HammerMan
    dw $002b ; MonsterTable $02B: Yeti
    dw $003b ; MonsterTable $03B: Saccer
    dw $0036 ; MonsterTable $036: Gulpple

EncounterGroup_5CC3::
    db $03 ; entry 0: wEncounterKind + 1
    db $12, $04, $08, $0d, $12, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $002b ; MonsterTable $02B: Yeti
    dw $003b ; MonsterTable $03B: Saccer
    dw $0036 ; MonsterTable $036: Gulpple
    dw $0191 ; MonsterTable $191: BeastNite

EncounterGroup_5CD2::
    db $03 ; entry 0: wEncounterKind + 1
    db $0c, $02, $07, $0c, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0040 ; MonsterTable $040: SeaHorse
    dw $0036 ; MonsterTable $036: Gulpple
    dw $0191 ; MonsterTable $191: BeastNite

EncounterGroup_5CDF::
    db $03 ; entry 0: wEncounterKind + 1
    db $10, $04, $09, $0d, $10, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $002a ; MonsterTable $02A: HammerMan
    dw $002d ; MonsterTable $02D: Gismo
    dw $0036 ; MonsterTable $036: Gulpple
    dw $0034 ; MonsterTable $034: Grizzly

EncounterGroup_5CEE::
    db $03 ; entry 0: wEncounterKind + 1
    db $12, $04, $09, $0e, $12, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0028 ; MonsterTable $028: SlimeNite
    dw $002d ; MonsterTable $02D: Gismo
    dw $0034 ; MonsterTable $034: Grizzly
    dw $003e ; MonsterTable $03E: CragDevil

EncounterGroup_5CFD::
    db $03 ; entry 0: wEncounterKind + 1
    db $15, $03, $07, $0d, $11, $15 ; limit for the random 0-127, then rising slot thresholds
    dw $0028 ; MonsterTable $028: SlimeNite
    dw $002d ; MonsterTable $02D: Gismo
    dw $0038 ; MonsterTable $038: Almiraj
    dw $003b ; MonsterTable $03B: Saccer
    dw $003e ; MonsterTable $03E: CragDevil

EncounterGroup_5D0E::
    db $03 ; entry 0: wEncounterKind + 1
    db $12, $05, $0a, $0e, $12, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $002c ; MonsterTable $02C: Orc
    dw $0037 ; MonsterTable $037: FoxFire
    dw $0034 ; MonsterTable $034: Grizzly
    dw $003e ; MonsterTable $03E: CragDevil

EncounterGroup_5D1D::
    db $03 ; entry 0: wEncounterKind + 1
    db $15, $04, $07, $0b, $10, $15 ; limit for the random 0-127, then rising slot thresholds
    dw $0029 ; MonsterTable $029: LizardMan
    dw $0033 ; MonsterTable $033: RogueNite
    dw $0037 ; MonsterTable $037: FoxFire
    dw $0039 ; MonsterTable $039: LandOwl
    dw $0192 ; MonsterTable $192: Drygon

EncounterGroup_5D2E::
    db $03 ; entry 0: wEncounterKind + 1
    db $11, $03, $08, $0d, $11, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0033 ; MonsterTable $033: RogueNite
    dw $003a ; MonsterTable $03A: Goategon
    dw $003d ; MonsterTable $03D: BullBird
    dw $0192 ; MonsterTable $192: Drygon

EncounterGroup_5D3D::
    db $03 ; entry 0: wEncounterKind + 1
    db $15, $05, $0a, $0e, $12, $15 ; limit for the random 0-127, then rising slot thresholds
    dw $003f ; MonsterTable $03F: Starfish
    dw $0040 ; MonsterTable $040: SeaHorse
    dw $0037 ; MonsterTable $037: FoxFire
    dw $0029 ; MonsterTable $029: LizardMan
    dw $0033 ; MonsterTable $033: RogueNite

; passed directly in DE to RunBattleIntroKindCase_Case00_Sub01; RunBattleIntroKindCase_Case00_Sub01
; draws three times a random 0-127 below byte 1 and stores the word of the first slot whose
; threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero
; threshold (E-0202, C1)
EncounterGroup_5D4E::
    db $03 ; entry 0: wEncounterKind + 1
    db $12, $05, $0a, $0f, $12, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0040 ; MonsterTable $040: SeaHorse
    dw $0193 ; MonsterTable $193: Pumpoise
    dw $0194 ; MonsterTable $194: FishRider
    dw $0195 ; MonsterTable $195: WalrusMan

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 4
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 16 words, up to its first group (E-0202, C1)
; record: one screen, row by row (4 per row): its encounter group
EncounterGrid_5D5D::
    dw EncounterGroup_5D7D ; id 0
    dw EncounterGroup_5D7D ; id 1
    dw EncounterGroup_5D7D ; id 2
    dw EncounterGroup_5D7D ; id 3
    dw EncounterGroup_5D7D ; id 4
    dw EncounterGroup_5D7D ; id 5
    dw EncounterGroup_5D7D ; id 6
    dw EncounterGroup_5D7D ; id 7
    dw EncounterGroup_5D7D ; id 8
    dw EncounterGroup_5D7D ; id 9
    dw EncounterGroup_5D7D ; id 10
    dw EncounterGroup_5D7D ; id 11
    dw EncounterGroup_5D7D ; id 12
    dw EncounterGroup_5D7D ; id 13
    dw EncounterGroup_5D7D ; id 14
    dw EncounterGroup_5D7D ; id 15

; named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127
; below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5D7D::
    db $03 ; entry 0: wEncounterKind + 1
    db $13, $04, $09, $0e, $13, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $002e ; MonsterTable $02E: Droll
    dw $002f ; MonsterTable $02F: Goopi
    dw $0030 ; MonsterTable $030: Mummy
    dw $0031 ; MonsterTable $031: TreeBoy

; passed directly in DE to RunBattleIntroKindCase_Case00_Sub01; RunBattleIntroKindCase_Case00_Sub01
; draws three times a random 0-127 below byte 1 and stores the word of the first slot whose
; threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero
; threshold (E-0202, C1)
EncounterGroup_5D8C::
    db $03 ; entry 0: wEncounterKind + 1
    db $13, $04, $09, $0e, $13, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $002e ; MonsterTable $02E: Droll
    dw $002f ; MonsterTable $02F: Goopi
    dw $0030 ; MonsterTable $030: Mummy
    dw $0031 ; MonsterTable $031: TreeBoy

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 4
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 16 words, up to its first group (E-0202, C1)
; record: one screen, row by row (4 per row): its encounter group
EncounterGrid_5D9B::
    dw EncounterGroup_5DBB ; id 0
    dw EncounterGroup_5DBB ; id 1
    dw EncounterGroup_5DBB ; id 2
    dw EncounterGroup_5DBB ; id 3
    dw EncounterGroup_5DBB ; id 4
    dw EncounterGroup_5DBB ; id 5
    dw EncounterGroup_5DBB ; id 6
    dw EncounterGroup_5DBB ; id 7
    dw EncounterGroup_5DBB ; id 8
    dw EncounterGroup_5DBB ; id 9
    dw EncounterGroup_5DBB ; id 10
    dw EncounterGroup_5DBB ; id 11
    dw EncounterGroup_5DBB ; id 12
    dw EncounterGroup_5DBB ; id 13
    dw EncounterGroup_5DBB ; id 14
    dw EncounterGroup_5DBB ; id 15

; named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127
; below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5DBB::
    db $03 ; entry 0: wEncounterKind + 1
    db $10, $04, $08, $0c, $10, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0041 ; MonsterTable $041: ManEater
    dw $0196 ; MonsterTable $196: Stubsuck
    dw $0197 ; MonsterTable $197: Shadow
    dw $0035 ; MonsterTable $035: Demonite

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 2
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 8 words, up to its first group (E-0202, C1)
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_5DCA::
    dw EncounterGroup_5DDA ; id 0
    dw EncounterGroup_5DDA ; id 1
    dw EncounterGroup_5DDA ; id 2
    dw EncounterGroup_5DDA ; id 3
    dw EncounterGroup_5DDA ; id 4
    dw EncounterGroup_5DDA ; id 5
    dw EncounterGroup_5DDA ; id 6
    dw EncounterGroup_5DDA ; id 7

; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_5DDA::
    db $03 ; entry 0: wEncounterKind + 1
    db $0c, $04, $08, $0c, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0042 ; MonsterTable $042: StubBird
    dw $0043 ; MonsterTable $043: GiantMoth
    dw $0198 ; MonsterTable $198: WingTree

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 2
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 4 words, up to its first group (E-0202, C1)
EncounterGrid_5DE7::
    dw EncounterGroup_5DFF ; id 0
    dw EncounterGroup_5DFF ; id 1
    dw EncounterGroup_5DFF ; id 2
    dw EncounterGroup_5DFF ; id 3

EncounterGrid_5DEF::
    dw EncounterGroup_5DFF ; id 0
    dw EncounterGroup_5DFF ; id 1
    dw EncounterGroup_5DFF ; id 2
    dw EncounterGroup_5DFF ; id 3

EncounterGrid_5DF7::
    dw EncounterGroup_5DFF ; id 0
    dw EncounterGroup_5DFF ; id 1
    dw EncounterGroup_5DFF ; id 2
    dw EncounterGroup_5DFF ; id 3

; named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127
; below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
EncounterGroup_5DFF::
    db $03 ; entry 0: wEncounterKind + 1
    db $0c, $04, $09, $0c, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $019e ; MonsterTable $19E: AgDevil
    dw $019f ; MonsterTable $19F: Puppetor
    dw $01a0 ; MonsterTable $1A0: Golem

EncounterGrid_5E0C::
    dw EncounterGroup_5E1C ; id 0
    dw EncounterGroup_5E1C ; id 1
    dw EncounterGroup_5E1C ; id 2
    dw EncounterGroup_5E1C ; id 3

EncounterGrid_5E14::
    dw EncounterGroup_5E1C ; id 0
    dw EncounterGroup_5E1C ; id 1
    dw EncounterGroup_5E1C ; id 2
    dw EncounterGroup_5E1C ; id 3

; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5E1C::
    db $03 ; entry 0: wEncounterKind + 1
    db $0e, $01, $05, $0a, $0e, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $019d ; MonsterTable $19D: MetalDrak
    dw $019e ; MonsterTable $19E: AgDevil
    dw $019f ; MonsterTable $19F: Puppetor
    dw $01a0 ; MonsterTable $1A0: Golem

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 12
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 144 words, up to its first group (E-0202, C1)
; record: one screen, row by row (12 per row): its encounter group
EncounterGrid_5E2B::
    dw EncounterGroup_5F4B ; id 0
    dw EncounterGroup_600A ; id 1
    dw EncounterGroup_600A ; id 2
    dw EncounterGroup_5FFB ; id 3
    dw EncounterGroup_5FFB ; id 4
    dw EncounterGroup_5FFB ; id 5
    dw EncounterGroup_5F4B ; id 6
    dw EncounterGroup_5F4B ; id 7
    dw EncounterGroup_5F4B ; id 8
    dw EncounterGroup_5F4B ; id 9
    dw EncounterGroup_5F4B ; id 10
    dw EncounterGroup_5F4B ; id 11
    dw EncounterGroup_5F4B ; id 12
    dw EncounterGroup_600A ; id 13
    dw EncounterGroup_600A ; id 14
    dw EncounterGroup_5F4B ; id 15
    dw EncounterGroup_5FFB ; id 16
    dw EncounterGroup_5FFB ; id 17
    dw EncounterGroup_5FFB ; id 18
    dw EncounterGroup_5F4B ; id 19
    dw EncounterGroup_5F4B ; id 20
    dw EncounterGroup_5F4B ; id 21
    dw EncounterGroup_5F56 ; id 22
    dw EncounterGroup_5F56 ; id 23
    dw EncounterGroup_5F4B ; id 24
PointerRun_0A_438D_Entry04::
    dw EncounterGroup_6019 ; id 25
    dw EncounterGroup_5F4B ; id 26
    dw EncounterGroup_5F4B ; id 27
    dw EncounterGroup_5FFB ; id 28
    dw EncounterGroup_5FFB ; id 29
    dw EncounterGroup_5FFB ; id 30
    dw EncounterGroup_5FFB ; id 31
    dw EncounterGroup_5F4B ; id 32
    dw EncounterGroup_5F4B ; id 33
    dw EncounterGroup_5F56 ; id 34
    dw EncounterGroup_5F56 ; id 35
    dw EncounterGroup_5F4B ; id 36
    dw EncounterGroup_5F4B ; id 37
    dw EncounterGroup_5F92 ; id 38
    dw EncounterGroup_5F92 ; id 39
    dw EncounterGroup_5F4B ; id 40
    dw EncounterGroup_5FFB ; id 41
    dw EncounterGroup_5F63 ; id 42
    dw EncounterGroup_5F63 ; id 43
    dw EncounterGroup_5F63 ; id 44
    dw EncounterGroup_5F63 ; id 45
    dw EncounterGroup_5F56 ; id 46
    dw EncounterGroup_5F56 ; id 47
    dw EncounterGroup_5F92 ; id 48
    dw EncounterGroup_5F92 ; id 49
    dw EncounterGroup_5F92 ; id 50
    dw EncounterGroup_5F92 ; id 51
    dw EncounterGroup_5F92 ; id 52
    dw EncounterGroup_5F4B ; id 53
    dw EncounterGroup_5F63 ; id 54
    dw EncounterGroup_5F4B ; id 55
    dw EncounterGroup_5F63 ; id 56
    dw EncounterGroup_5F63 ; id 57
    dw EncounterGroup_5F56 ; id 58
    dw EncounterGroup_5F56 ; id 59
    dw EncounterGroup_5F92 ; id 60
    dw EncounterGroup_5F92 ; id 61
    dw EncounterGroup_5F92 ; id 62
    dw EncounterGroup_5F92 ; id 63
    dw EncounterGroup_5F92 ; id 64
    dw EncounterGroup_5F4B ; id 65
    dw EncounterGroup_5F63 ; id 66
    dw EncounterGroup_5F63 ; id 67
    dw EncounterGroup_5F63 ; id 68
    dw EncounterGroup_5F63 ; id 69
    dw EncounterGroup_5F4B ; id 70
    dw EncounterGroup_5F4B ; id 71
    dw EncounterGroup_5F4B ; id 72
    dw EncounterGroup_5FA1 ; id 73
    dw EncounterGroup_5FA1 ; id 74
    dw EncounterGroup_5F92 ; id 75
    dw EncounterGroup_5F83 ; id 76
    dw EncounterGroup_5F63 ; id 77
    dw EncounterGroup_5F63 ; id 78
    dw EncounterGroup_5F63 ; id 79
    dw EncounterGroup_5F72 ; id 80
    dw EncounterGroup_5F72 ; id 81
    dw EncounterGroup_5F4B ; id 82
    dw EncounterGroup_5F4B ; id 83
    dw EncounterGroup_5F4B ; id 84
    dw EncounterGroup_5FA1 ; id 85
    dw EncounterGroup_5FA1 ; id 86
    dw EncounterGroup_5FA1 ; id 87
    dw EncounterGroup_5F83 ; id 88
    dw EncounterGroup_5F83 ; id 89
    dw EncounterGroup_5F63 ; id 90
    dw EncounterGroup_5F4B ; id 91
    dw EncounterGroup_5FCE ; id 92
    dw EncounterGroup_5FCE ; id 93
    dw EncounterGroup_5F4B ; id 94
    dw EncounterGroup_5F4B ; id 95
    dw EncounterGroup_5FEE ; id 96
    dw EncounterGroup_5FEE ; id 97
    dw EncounterGroup_5F4B ; id 98
    dw EncounterGroup_5FA1 ; id 99
    dw EncounterGroup_5FBF ; id 100
    dw EncounterGroup_5FBF ; id 101
    dw EncounterGroup_5FBF ; id 102
    dw EncounterGroup_5FCE ; id 103
    dw EncounterGroup_5FCE ; id 104
    dw EncounterGroup_5FCE ; id 105
    dw EncounterGroup_5F4B ; id 106
    dw EncounterGroup_5F4B ; id 107
    dw EncounterGroup_5FEE ; id 108
    dw EncounterGroup_5FEE ; id 109
    dw EncounterGroup_5F4B ; id 110
    dw EncounterGroup_5F4B ; id 111
    dw EncounterGroup_5FBF ; id 112
    dw EncounterGroup_5FBF ; id 113
    dw EncounterGroup_5FBF ; id 114
    dw EncounterGroup_5FBF ; id 115
    dw EncounterGroup_5FBF ; id 116
    dw EncounterGroup_5FDF ; id 117
    dw EncounterGroup_5FDF ; id 118
    dw EncounterGroup_5FDF ; id 119
    dw EncounterGroup_5FEE ; id 120
    dw EncounterGroup_5FEE ; id 121
    dw EncounterGroup_5FEE ; id 122
    dw EncounterGroup_5FEE ; id 123
    dw EncounterGroup_5FB0 ; id 124
    dw EncounterGroup_5FB0 ; id 125
    dw EncounterGroup_5FBF ; id 126
    dw EncounterGroup_5F4B ; id 127
    dw EncounterGroup_5F4B ; id 128
    dw EncounterGroup_5FDF ; id 129
    dw EncounterGroup_5FDF ; id 130
    dw EncounterGroup_5FDF ; id 131
    dw EncounterGroup_5FEE ; id 132
    dw EncounterGroup_5FEE ; id 133
    dw EncounterGroup_5FEE ; id 134
    dw EncounterGroup_5FEE ; id 135
    dw EncounterGroup_5FB0 ; id 136
    dw EncounterGroup_5FB0 ; id 137
    dw EncounterGroup_5FBF ; id 138
    dw EncounterGroup_5F4B ; id 139
    dw EncounterGroup_5F4B ; id 140
    dw EncounterGroup_5F4B ; id 141
    dw EncounterGroup_5FDF ; id 142
    dw EncounterGroup_5FDF ; id 143

; record: wEncounterKind + 1; random limit and five slot thresholds; 2 encounter word(s)
EncounterGroup_5F4B::
    db $01 ; entry 0: wEncounterKind + 1
    db $07, $03, $07, $00, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0002 ; MonsterTable $002: SpotSlime
    dw $0003 ; MonsterTable $003: CactiBall

; named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127
; below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_5F56::
    db $03 ; entry 0: wEncounterKind + 1
    db $0c, $04, $08, $0c, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0048 ; MonsterTable $048: Emyu
    dw $0049 ; MonsterTable $049: FloraMan
    dw $0045 ; MonsterTable $045: FangSlime

; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5F63::
    db $03 ; entry 0: wEncounterKind + 1
    db $10, $04, $08, $0c, $10, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0056 ; MonsterTable $056: Dumbira
    dw $01a7 ; MonsterTable $1A7: FairyRat
    dw $004a ; MonsterTable $04A: Slurperon
    dw $0047 ; MonsterTable $047: MadRaven

; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_5F72::
    db $03 ; entry 0: wEncounterKind + 1
    db $17, $05, $0a, $0f, $14, $17 ; limit for the random 0-127, then rising slot thresholds
    dw $0056 ; MonsterTable $056: Dumbira
    dw $01a7 ; MonsterTable $1A7: FairyRat
    dw $004a ; MonsterTable $04A: Slurperon
    dw $0047 ; MonsterTable $047: MadRaven
    dw $0055 ; MonsterTable $055: WildApe

EncounterGroup_5F83::
    db $03 ; entry 0: wEncounterKind + 1
    db $13, $06, $0c, $12, $13, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0056 ; MonsterTable $056: Dumbira
    dw $004a ; MonsterTable $04A: Slurperon
    dw $0052 ; MonsterTable $052: WarMantis
    dw $0058 ; MonsterTable $058: Metaly

EncounterGroup_5F92::
    db $03 ; entry 0: wEncounterKind + 1
    db $14, $06, $0c, $12, $14, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $005e ; MonsterTable $05E: Gigantes
    dw $01a9 ; MonsterTable $1A9: Mommonja
    dw $0052 ; MonsterTable $052: WarMantis
    dw $0058 ; MonsterTable $058: Metaly

EncounterGroup_5FA1::
    db $02 ; entry 0: wEncounterKind + 1
    db $10, $03, $06, $0b, $10, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $005e ; MonsterTable $05E: Gigantes
    dw $01a9 ; MonsterTable $1A9: Mommonja
    dw $01a8 ; MonsterTable $1A8: Swordgon
    dw $004d ; MonsterTable $04D: Dragon

EncounterGroup_5FB0::
    db $02 ; entry 0: wEncounterKind + 1
    db $13, $06, $0c, $12, $13, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01a8 ; MonsterTable $1A8: Swordgon
    dw $005c ; MonsterTable $05C: MadGoose
    dw $004d ; MonsterTable $04D: Dragon
    dw $0053 ; MonsterTable $053: Phoenix

EncounterGroup_5FBF::
    db $02 ; entry 0: wEncounterKind + 1
    db $14, $06, $0c, $12, $14, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01a8 ; MonsterTable $1A8: Swordgon
    dw $005c ; MonsterTable $05C: MadGoose
    dw $004d ; MonsterTable $04D: Dragon
    dw $0058 ; MonsterTable $058: Metaly

EncounterGroup_5FCE::
    db $03 ; entry 0: wEncounterKind + 1
    db $16, $04, $09, $0e, $13, $16 ; limit for the random 0-127, then rising slot thresholds
    dw $0055 ; MonsterTable $055: WildApe
    dw $005d ; MonsterTable $05D: Bubblemon
    dw $004d ; MonsterTable $04D: Dragon
    dw $005c ; MonsterTable $05C: MadGoose
    dw $01a8 ; MonsterTable $1A8: Swordgon

EncounterGroup_5FDF::
    db $03 ; entry 0: wEncounterKind + 1
    db $12, $05, $0a, $0e, $12, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01aa ; MonsterTable $1AA: KiteHawk
    dw $006f ; MonsterTable $06F: Florajay
    dw $0059 ; MonsterTable $059: GhosTree
    dw $0062 ; MonsterTable $062: MadSpirit

EncounterGroup_5FEE::
    db $02 ; entry 0: wEncounterKind + 1
    db $0c, $04, $08, $0c, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $006e ; MonsterTable $06E: Vampirus
    dw $004c ; MonsterTable $04C: MadDragon
    dw $0068 ; MonsterTable $068: CoilBird

EncounterGroup_5FFB::
    db $03 ; entry 0: wEncounterKind + 1
    db $14, $06, $09, $0e, $14, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $005b ; MonsterTable $05B: Lionex
    dw $0065 ; MonsterTable $065: Andreal
    dw $0054 ; MonsterTable $054: FireWeed
    dw $0046 ; MonsterTable $046: RockSlime

EncounterGroup_600A::
    db $03 ; entry 0: wEncounterKind + 1
    db $0f, $03, $08, $0d, $0f, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0065 ; MonsterTable $065: Andreal
    dw $0046 ; MonsterTable $046: RockSlime
    dw $0054 ; MonsterTable $054: FireWeed
    dw $0058 ; MonsterTable $058: Metaly

EncounterGroup_6019::
    db $02 ; entry 0: wEncounterKind + 1
    db $0d, $02, $03, $0a, $0d, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0058 ; MonsterTable $058: Metaly
    dw $004b ; MonsterTable $04B: Roboster
    dw $0051 ; MonsterTable $051: EvilBeast
    dw $01ad ; MonsterTable $1AD: WingSnake

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 2
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 4 words, up to its first group (E-0202, C1)
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_6028::
    dw EncounterGroup_6030 ; id 0
    dw EncounterGroup_6030 ; id 1
    dw EncounterGroup_6030 ; id 2
    dw EncounterGroup_6030 ; id 3

; named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127
; below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_6030::
    db $03 ; entry 0: wEncounterKind + 1
    db $0c, $04, $08, $0c, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $004e ; MonsterTable $04E: IronTurt
    dw $004f ; MonsterTable $04F: MadMirror
    dw $0050 ; MonsterTable $050: SabreMan

EncounterGrid_603D::
    dw EncounterGroup_6045 ; id 0
    dw EncounterGroup_6045 ; id 1
    dw EncounterGroup_6045 ; id 2
    dw EncounterGroup_6045 ; id 3

EncounterGroup_6045::
    db $03 ; entry 0: wEncounterKind + 1
    db $0c, $04, $08, $0c, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $004e ; MonsterTable $04E: IronTurt
    dw $004f ; MonsterTable $04F: MadMirror
    dw $0050 ; MonsterTable $050: SabreMan

EncounterGrid_6052::
    dw EncounterGroup_605A ; id 0
    dw EncounterGroup_605A ; id 1
    dw EncounterGroup_605A ; id 2
    dw EncounterGroup_605A ; id 3

; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_605A::
    db $03 ; entry 0: wEncounterKind + 1
    db $16, $04, $08, $0c, $11, $16 ; limit for the random 0-127, then rising slot thresholds
    dw $004e ; MonsterTable $04E: IronTurt
    dw $004f ; MonsterTable $04F: MadMirror
    dw $0050 ; MonsterTable $050: SabreMan
    dw $0057 ; MonsterTable $057: Belzebub
    dw $0066 ; MonsterTable $066: MadKnight

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 2
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 4 words, up to its first group (E-0202, C1)
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_606B::
    dw EncounterGroup_6073 ; id 0
    dw EncounterGroup_6073 ; id 1
    dw EncounterGroup_6073 ; id 2
    dw EncounterGroup_6073 ; id 3

; named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127
; below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
EncounterGroup_6073::
    db $03 ; entry 0: wEncounterKind + 1
    db $16, $04, $08, $0c, $11, $16 ; limit for the random 0-127, then rising slot thresholds
    dw $004e ; MonsterTable $04E: IronTurt
    dw $004f ; MonsterTable $04F: MadMirror
    dw $0050 ; MonsterTable $050: SabreMan
    dw $0051 ; MonsterTable $051: EvilBeast
    dw $0057 ; MonsterTable $057: Belzebub

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 1
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 1 words, up to its first group (E-0202, C1)
; record: one screen, row by row (1 per row): its encounter group
EncounterGrid_6084::
    dw EncounterGroup_6086 ; id 0

; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_6086::
    db $03 ; entry 0: wEncounterKind + 1
    db $14, $04, $08, $0c, $10, $14 ; limit for the random 0-127, then rising slot thresholds
    dw $01a1 ; MonsterTable $1A1: EvilSeed
    dw $01a2 ; MonsterTable $1A2: EyeBall
    dw $01a3 ; MonsterTable $1A3: Chamelgon
    dw $01a4 ; MonsterTable $1A4: FooHero
    dw $01a5 ; MonsterTable $1A5: BoxSlime

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 3
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 9 words, up to its first group (E-0202, C1)
; record: one screen, row by row (3 per row): its encounter group
EncounterGrid_6097::
    dw EncounterGroup_60A9 ; id 0
    dw EncounterGroup_60A9 ; id 1
    dw EncounterGroup_60A9 ; id 2
    dw EncounterGroup_60A9 ; id 3
    dw EncounterGroup_60A9 ; id 4
    dw EncounterGroup_60A9 ; id 5
    dw EncounterGroup_60A9 ; id 6
    dw EncounterGroup_60A9 ; id 7
    dw EncounterGroup_60A9 ; id 8

; named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127
; below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
EncounterGroup_60A9::
    db $03 ; entry 0: wEncounterKind + 1
    db $14, $04, $08, $0c, $10, $14 ; limit for the random 0-127, then rising slot thresholds
    dw $01a1 ; MonsterTable $1A1: EvilSeed
    dw $01a2 ; MonsterTable $1A2: EyeBall
    dw $01a3 ; MonsterTable $1A3: Chamelgon
    dw $01a4 ; MonsterTable $1A4: FooHero
    dw $01a5 ; MonsterTable $1A5: BoxSlime

EncounterGrid_60BA::
    dw EncounterGroup_60CC ; id 0
    dw EncounterGroup_60CC ; id 1
    dw EncounterGroup_60CC ; id 2
    dw EncounterGroup_60CC ; id 3
    dw EncounterGroup_60CC ; id 4
    dw EncounterGroup_60CC ; id 5
    dw EncounterGroup_60CC ; id 6
    dw EncounterGroup_60CC ; id 7
    dw EncounterGroup_60CC ; id 8

EncounterGroup_60CC::
    db $03 ; entry 0: wEncounterKind + 1
    db $14, $04, $08, $0c, $10, $14 ; limit for the random 0-127, then rising slot thresholds
    dw $01a1 ; MonsterTable $1A1: EvilSeed
    dw $01a2 ; MonsterTable $1A2: EyeBall
    dw $01a3 ; MonsterTable $1A3: Chamelgon
    dw $01a4 ; MonsterTable $1A4: FooHero
    dw $01a5 ; MonsterTable $1A5: BoxSlime

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 2
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 4 words, up to its first group (E-0202, C1)
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_60DD::
    dw EncounterGroup_60E5 ; id 0
    dw EncounterGroup_60E5 ; id 1
    dw EncounterGroup_60E5 ; id 2
    dw EncounterGroup_60E5 ; id 3

; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_60E5::
    db $03 ; entry 0: wEncounterKind + 1
    db $0e, $05, $09, $0e, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $005f ; MonsterTable $05F: Exaucers
    dw $0068 ; MonsterTable $068: CoilBird
    dw $0069 ; MonsterTable $069: ArmorPede

EncounterGrid_60F2::
    dw EncounterGroup_60FA ; id 0
    dw EncounterGroup_60FA ; id 1
    dw EncounterGroup_60FA ; id 2
    dw EncounterGroup_60FA ; id 3

EncounterGroup_60FA::
    db $03 ; entry 0: wEncounterKind + 1
    db $0e, $05, $09, $0e, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $005f ; MonsterTable $05F: Exaucers
    dw $0068 ; MonsterTable $068: CoilBird
    dw $0069 ; MonsterTable $069: ArmorPede

EncounterGrid_6107::
    dw EncounterGroup_610F ; id 0
    dw EncounterGroup_610F ; id 1
    dw EncounterGroup_610F ; id 2
    dw EncounterGroup_610F ; id 3

; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_610F::
    db $03 ; entry 0: wEncounterKind + 1
    db $17, $04, $09, $0d, $12, $17 ; limit for the random 0-127, then rising slot thresholds
    dw $005f ; MonsterTable $05F: Exaucers
    dw $0067 ; MonsterTable $067: SkyDragon
    dw $0068 ; MonsterTable $068: CoilBird
    dw $0069 ; MonsterTable $069: ArmorPede
    dw $006a ; MonsterTable $06A: MadHornet

EncounterGrid_6120::
    dw EncounterGroup_6128 ; id 0
    dw EncounterGroup_6128 ; id 1
    dw EncounterGroup_6128 ; id 2
    dw EncounterGroup_6128 ; id 3

; named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127
; below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
EncounterGroup_6128::
    db $03 ; entry 0: wEncounterKind + 1
    db $17, $04, $09, $0d, $12, $17 ; limit for the random 0-127, then rising slot thresholds
    dw $005f ; MonsterTable $05F: Exaucers
    dw $0067 ; MonsterTable $067: SkyDragon
    dw $0068 ; MonsterTable $068: CoilBird
    dw $0069 ; MonsterTable $069: ArmorPede
    dw $006a ; MonsterTable $06A: MadHornet

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 3
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 12 words, up to its first group (E-0202, C1)
; record: one screen, row by row (3 per row): its encounter group
EncounterGrid_6139::
    dw EncounterGroup_6151 ; id 0
    dw EncounterGroup_6151 ; id 1
    dw EncounterGroup_6151 ; id 2
    dw EncounterGroup_6151 ; id 3
    dw EncounterGroup_6151 ; id 4
    dw EncounterGroup_6151 ; id 5
    dw EncounterGroup_6151 ; id 6
    dw EncounterGroup_6151 ; id 7
    dw EncounterGroup_6151 ; id 8
    dw EncounterGroup_6151 ; id 9
    dw EncounterGroup_6151 ; id 10
    dw EncounterGroup_6151 ; id 11

; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_6151::
    db $03 ; entry 0: wEncounterKind + 1
    db $12, $05, $09, $0e, $12, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0059 ; MonsterTable $059: GhosTree
    dw $005a ; MonsterTable $05A: Babble
    dw $0060 ; MonsterTable $060: DeadNite
    dw $0062 ; MonsterTable $062: MadSpirit

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 3
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 9 words, up to its first group (E-0202, C1)
EncounterGrid_6160::
    dw EncounterGroup_6172 ; id 0
    dw EncounterGroup_6172 ; id 1
    dw EncounterGroup_6172 ; id 2
    dw EncounterGroup_6172 ; id 3
    dw EncounterGroup_6172 ; id 4
    dw EncounterGroup_6172 ; id 5
    dw EncounterGroup_6172 ; id 6
    dw EncounterGroup_6172 ; id 7
    dw EncounterGroup_6172 ; id 8

; named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127
; below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
EncounterGroup_6172::
    db $03 ; entry 0: wEncounterKind + 1
    db $11, $04, $09, $0e, $11, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $005a ; MonsterTable $05A: Babble
    dw $0060 ; MonsterTable $060: DeadNite
    dw $0061 ; MonsterTable $061: GateGuard
    dw $0063 ; MonsterTable $063: Copycat

EncounterGrid_6181::
    dw EncounterGroup_6193 ; id 0
    dw EncounterGroup_6193 ; id 1
    dw EncounterGroup_6193 ; id 2
    dw EncounterGroup_6193 ; id 3
    dw EncounterGroup_6193 ; id 4
    dw EncounterGroup_6193 ; id 5
    dw EncounterGroup_6193 ; id 6
    dw EncounterGroup_6193 ; id 7
    dw EncounterGroup_6193 ; id 8

EncounterGroup_6193::
    db $03 ; entry 0: wEncounterKind + 1
    db $12, $05, $09, $0e, $12, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0057 ; MonsterTable $057: Belzebub
    dw $0059 ; MonsterTable $059: GhosTree
    dw $0060 ; MonsterTable $060: DeadNite
    dw $0062 ; MonsterTable $062: MadSpirit

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 3
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 6 words, up to its first group (E-0202, C1)
; record: one screen, row by row (3 per row): its encounter group
EncounterGrid_61A2::
    dw EncounterGroup_61AE ; id 0
    dw EncounterGroup_61AE ; id 1
    dw EncounterGroup_61AE ; id 2
    dw EncounterGroup_61AE ; id 3
    dw EncounterGroup_61AE ; id 4
    dw EncounterGroup_61AE ; id 5

; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_61AE::
    db $03 ; entry 0: wEncounterKind + 1
    db $11, $04, $09, $0e, $11, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $005a ; MonsterTable $05A: Babble
    dw $0060 ; MonsterTable $060: DeadNite
    dw $0061 ; MonsterTable $061: GateGuard
    dw $0063 ; MonsterTable $063: Copycat

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 4
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 16 words, up to its first group (E-0202, C1)
; record: one screen, row by row (4 per row): its encounter group
EncounterGrid_61BD::
    dw EncounterGroup_61EC ; id 0
    dw EncounterGroup_61EC ; id 1
    dw EncounterGroup_61DD ; id 2
    dw EncounterGroup_61DD ; id 3
    dw EncounterGroup_61EC ; id 4
    dw EncounterGroup_61EC ; id 5
    dw EncounterGroup_61EC ; id 6
    dw EncounterGroup_61DD ; id 7
    dw EncounterGroup_61EC ; id 8
    dw EncounterGroup_61EC ; id 9
    dw EncounterGroup_61EC ; id 10
    dw EncounterGroup_61DD ; id 11
    dw EncounterGroup_61DD ; id 12
    dw EncounterGroup_61DD ; id 13
    dw EncounterGroup_61DD ; id 14
    dw EncounterGroup_61DD ; id 15

; named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127
; below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
EncounterGroup_61DD::
    db $03 ; entry 0: wEncounterKind + 1
    db $0e, $04, $07, $0b, $0e, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0070 ; MonsterTable $070: BossTroll
    dw $0071 ; MonsterTable $071: ChopClown
    dw $0072 ; MonsterTable $072: MistyWing
    dw $01ae ; MonsterTable $1AE: GreatDrak

EncounterGroup_61EC::
    db $03 ; entry 0: wEncounterKind + 1
    db $0e, $04, $07, $0b, $0e, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0070 ; MonsterTable $070: BossTroll
    dw $0071 ; MonsterTable $071: ChopClown
    dw $0072 ; MonsterTable $072: MistyWing
    dw $01ae ; MonsterTable $1AE: GreatDrak

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 3
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 12 words, up to its first group (E-0202, C1)
; record: one screen, row by row (3 per row): its encounter group
EncounterGrid_61FB::
    dw EncounterGroup_6213 ; id 0
    dw EncounterGroup_6213 ; id 1
    dw EncounterGroup_6213 ; id 2
    dw EncounterGroup_6213 ; id 3
    dw EncounterGroup_6213 ; id 4
    dw EncounterGroup_6213 ; id 5
    dw EncounterGroup_6213 ; id 6
    dw EncounterGroup_6213 ; id 7
    dw EncounterGroup_6213 ; id 8
    dw EncounterGroup_6213 ; id 9
    dw EncounterGroup_6213 ; id 10
    dw EncounterGroup_6213 ; id 11

; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_6213::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $04, $08, $0a, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0070 ; MonsterTable $070: BossTroll
    dw $0071 ; MonsterTable $071: ChopClown
    dw $0265 ; MonsterTable $265: StoneMan

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 6
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 36 words, up to its first group (E-0202, C1)
; record: one screen, row by row (6 per row): its encounter group
EncounterGrid_6220::
    dw EncounterGroup_6268 ; id 0
    dw EncounterGroup_6268 ; id 1
    dw EncounterGroup_6275 ; id 2
    dw EncounterGroup_6275 ; id 3
    dw EncounterGroup_6275 ; id 4
    dw EncounterGroup_6268 ; id 5
    dw EncounterGroup_6268 ; id 6
    dw EncounterGroup_6268 ; id 7
    dw EncounterGroup_6275 ; id 8
    dw EncounterGroup_6275 ; id 9
    dw EncounterGroup_6284 ; id 10
    dw EncounterGroup_6284 ; id 11
    dw EncounterGroup_6275 ; id 12
    dw EncounterGroup_6268 ; id 13
    dw EncounterGroup_6275 ; id 14
    dw EncounterGroup_6284 ; id 15
    dw EncounterGroup_6284 ; id 16
    dw EncounterGroup_6293 ; id 17
    dw EncounterGroup_6275 ; id 18
    dw EncounterGroup_6275 ; id 19
    dw EncounterGroup_6268 ; id 20
    dw EncounterGroup_6268 ; id 21
    dw EncounterGroup_6284 ; id 22
    dw EncounterGroup_6284 ; id 23
    dw EncounterGroup_6275 ; id 24
    dw EncounterGroup_6275 ; id 25
    dw EncounterGroup_6268 ; id 26
    dw EncounterGroup_6268 ; id 27
    dw EncounterGroup_6275 ; id 28
    dw EncounterGroup_6284 ; id 29
    dw EncounterGroup_6268 ; id 30
    dw EncounterGroup_6268 ; id 31
    dw EncounterGroup_6268 ; id 32
    dw EncounterGroup_6268 ; id 33
    dw EncounterGroup_62A0 ; id 34
    dw EncounterGroup_62A0 ; id 35

; named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127
; below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
EncounterGroup_6268::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $04, $07, $0a, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01d7 ; MonsterTable $1D7: Slabbit
    dw $01d9 ; MonsterTable $1D9: FairyRat
    dw $01db ; MonsterTable $1DB: MadPlant

; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_6275::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $03, $05, $08, $0a, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01d7 ; MonsterTable $1D7: Slabbit
    dw $01d8 ; MonsterTable $1D8: MultiEyes
    dw $01d9 ; MonsterTable $1D9: FairyRat
    dw $01db ; MonsterTable $1DB: MadPlant

EncounterGroup_6284::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $03, $05, $07, $0a, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01d8 ; MonsterTable $1D8: MultiEyes
    dw $01db ; MonsterTable $1DB: MadPlant
    dw $01dd ; MonsterTable $1DD: Grendal
    dw $01de ; MonsterTable $1DE: GoHopper

; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_6293::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $03, $07, $0a, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01db ; MonsterTable $1DB: MadPlant
    dw $01dc ; MonsterTable $1DC: Snapper
    dw $01dd ; MonsterTable $1DD: Grendal

; record: wEncounterKind + 1; random limit and five slot thresholds; 2 encounter word(s)
EncounterGroup_62A0::
    db $02 ; entry 0: wEncounterKind + 1
    db $0a, $04, $0a, $00, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01d8 ; MonsterTable $1D8: MultiEyes
    dw $01dd ; MonsterTable $1DD: Grendal

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 3
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 12 words, up to its first group (E-0202, C1)
; record: one screen, row by row (3 per row): its encounter group
EncounterGrid_62AB::
    dw EncounterGroup_62C3 ; id 0
    dw EncounterGroup_62C3 ; id 1
    dw EncounterGroup_62C3 ; id 2
    dw EncounterGroup_62C3 ; id 3
    dw EncounterGroup_62C3 ; id 4
    dw EncounterGroup_62C3 ; id 5
    dw EncounterGroup_62C3 ; id 6
    dw EncounterGroup_62C3 ; id 7
    dw EncounterGroup_62C3 ; id 8
    dw EncounterGroup_62C3 ; id 9
    dw EncounterGroup_62C3 ; id 10
    dw EncounterGroup_62C3 ; id 11

; named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127
; below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_62C3::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $03, $05, $07, $0a, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01dc ; MonsterTable $1DC: Snapper
    dw $01dd ; MonsterTable $1DD: Grendal
    dw $01e0 ; MonsterTable $1E0: StagBug
    dw $01e1 ; MonsterTable $1E1: FireWeed

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 3
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 6 words, up to its first group (E-0202, C1)
EncounterGrid_62D2::
    dw EncounterGroup_62DE ; id 0
    dw EncounterGroup_62DE ; id 1
    dw EncounterGroup_62DE ; id 2
    dw EncounterGroup_62DE ; id 3
    dw EncounterGroup_62DE ; id 4
    dw EncounterGroup_62DE ; id 5

; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_62DE::
    db $02 ; entry 0: wEncounterKind + 1
    db $0a, $04, $07, $0a, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01e3 ; MonsterTable $1E3: Grizzly
    dw $01e4 ; MonsterTable $1E4: SkulRider
    dw $01e5 ; MonsterTable $1E5: WalrusMan

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 2
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 4 words, up to its first group (E-0202, C1)
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_62EB::
    dw EncounterGroup_62F3 ; id 0
    dw EncounterGroup_62F3 ; id 1
    dw EncounterGroup_62F3 ; id 2
    dw EncounterGroup_62F3 ; id 3

; named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127
; below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
EncounterGroup_62F3::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $06, $08, $0a, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01e6 ; MonsterTable $1E6: MadCandle
    dw $01e7 ; MonsterTable $1E7: Reaper
    dw $01e8 ; MonsterTable $1E8: ProtoMech

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 5
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 25 words, up to its first group (E-0202, C1)
; record: one screen, row by row (5 per row): its encounter group
EncounterGrid_6300::
    dw EncounterGroup_633F ; id 0
    dw EncounterGroup_633F ; id 1
    dw EncounterGroup_633F ; id 2
    dw EncounterGroup_633F ; id 3
    dw EncounterGroup_633F ; id 4
    dw EncounterGroup_6332 ; id 5
    dw EncounterGroup_6332 ; id 6
    dw EncounterGroup_633F ; id 7
    dw EncounterGroup_633F ; id 8
    dw EncounterGroup_633F ; id 9
    dw EncounterGroup_634E ; id 10
    dw EncounterGroup_634E ; id 11
    dw EncounterGroup_634E ; id 12
    dw EncounterGroup_634E ; id 13
    dw EncounterGroup_635D ; id 14
    dw EncounterGroup_635D ; id 15
    dw EncounterGroup_635D ; id 16
    dw EncounterGroup_635D ; id 17
    dw EncounterGroup_635D ; id 18
    dw EncounterGroup_635D ; id 19
    dw EncounterGroup_636A ; id 20
    dw EncounterGroup_636A ; id 21
    dw EncounterGroup_635D ; id 22
    dw EncounterGroup_635D ; id 23
    dw EncounterGroup_635D ; id 24

; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_6332::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $03, $07, $0a, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01ef ; MonsterTable $1EF: Ogre
    dw $01f2 ; MonsterTable $1F2: Lipsy
    dw $01f7 ; MonsterTable $1F7: Butterfly

; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_633F::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $03, $06, $08, $0a, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01ef ; MonsterTable $1EF: Ogre
    dw $01f2 ; MonsterTable $1F2: Lipsy
    dw $01f4 ; MonsterTable $1F4: Spikerous
    dw $01f7 ; MonsterTable $1F7: Butterfly

; named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127
; below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
EncounterGroup_634E::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $03, $06, $08, $0a, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01ed ; MonsterTable $1ED: CatMage
    dw $01ee ; MonsterTable $1EE: FaceTree
    dw $01ef ; MonsterTable $1EF: Ogre
    dw $01f7 ; MonsterTable $1F7: Butterfly

EncounterGroup_635D::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $04, $07, $0a, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01ed ; MonsterTable $1ED: CatMage
    dw $01ee ; MonsterTable $1EE: FaceTree
    dw $01f7 ; MonsterTable $1F7: Butterfly

; record: wEncounterKind + 1; random limit and five slot thresholds; 2 encounter word(s)
EncounterGroup_636A::
    db $02 ; entry 0: wEncounterKind + 1
    db $0a, $06, $0a, $00, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01f1 ; MonsterTable $1F1: Anemon
    dw $01f2 ; MonsterTable $1F2: Lipsy

; passed directly in DE to RunBattleIntroKindCase_Case00_Sub01; RunBattleIntroKindCase_Case00_Sub01
; draws three times a random 0-127 below byte 1 and stores the word of the first slot whose
; threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero
; threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_6375::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $04, $06, $0a, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0216 ; MonsterTable $216: Scallopa
    dw $0217 ; MonsterTable $217: Snaily
    dw $0218 ; MonsterTable $218: Clawster

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 1
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 1 words, up to its first group (E-0202, C1)
; record: one screen, row by row (1 per row): its encounter group
EncounterGrid_6382::
    dw EncounterGroup_6384 ; id 0

; named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127
; below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_6384::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $02, $04, $08, $0a, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01f0 ; MonsterTable $1F0: CurseLamp
    dw $01f2 ; MonsterTable $1F2: Lipsy
    dw $01f4 ; MonsterTable $1F4: Spikerous
    dw $01f7 ; MonsterTable $1F7: Butterfly

; RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 2
; to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)); 4 words, up to its first group (E-0202, C1)
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_6393::
    dw EncounterGroup_639B ; id 0
    dw EncounterGroup_639B ; id 1
    dw EncounterGroup_639B ; id 2
    dw EncounterGroup_639B ; id 3

EncounterGroup_639B::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $03, $05, $08, $0a, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01f0 ; MonsterTable $1F0: CurseLamp
    dw $01f4 ; MonsterTable $1F4: Spikerous
    dw $01f6 ; MonsterTable $1F6: Skulpent
    dw $01f7 ; MonsterTable $1F7: Butterfly

EncounterGrid_63AA::
    dw EncounterGroup_63B2 ; id 0
    dw EncounterGroup_63B2 ; id 1
    dw EncounterGroup_63B2 ; id 2
    dw EncounterGroup_63B2 ; id 3

; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_63B2::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $04, $07, $0a, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01f0 ; MonsterTable $1F0: CurseLamp
    dw $01f5 ; MonsterTable $1F5: Skullgon
    dw $01f6 ; MonsterTable $1F6: Skulpent

EncounterGrid_63BF::
    dw EncounterGroup_63C7 ; id 0
    dw EncounterGroup_63C7 ; id 1
    dw EncounterGroup_63C7 ; id 2
    dw EncounterGroup_63C7 ; id 3

; named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127
; below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
EncounterGroup_63C7::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $03, $07, $0a, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01ef ; MonsterTable $1EF: Ogre
    dw $01f5 ; MonsterTable $1F5: Skullgon
    dw $01f6 ; MonsterTable $1F6: Skulpent
    ds $48d, $00

PointerRun_0A_438D_Entry06::
    ds $a10, $00

PointerRun_0A_438D_Entry07::
    ds $707, $00

PointerRun_0A_438D_Entry08::
    ds $404, $00

PointerRun_0A_438D_Entry09::
    ds $202, $00

PointerRun_0A_438D_Entry0A::
    ds $82, $00
