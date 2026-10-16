; ROM bank $0A: random encounters: encounter groups and grids, battle intro
; The annotated listing of this bank is build/listing/bank0a.asm.

SECTION "Bank 0A", ROMX[$4000], BANK[$0A]
    db $0a

; Field state 7, a harmful floor: flashes the screen for five frames
; (FieldState_StepChecks_HarmfulFloor_Flash), then hurts the party: on a floor of the first kind
; (wMenuSubState 0) it subtracts the floor's HP damage
; (FieldState_StepChecks_HarmfulFloor_FloorDamage), on the other kind the poison damage
; (FieldState_StepChecks_HarmfulFloor_PoisonDamage), and in both cases the MP drain. If a member
; fell (wStatusFieldStep low bits) it starts talk event group 4; otherwise it returns to field state
; 0 (5 in a key world). (C1, E-0357)
FieldState_StepChecks_HarmfulFloor::
    call FieldState_StepChecks_HarmfulFloor_Flash
    ld a, [wMenuState]
    inc a
    ld [wMenuState], a
    cp $05
    ret nz
    ld a, $0a
    ld [rRAMG], a
    ld a, [wMenuSubState]
    or a
    jr nz, .call_field_state_step_checks_harmful_floor
    call FieldState_StepChecks_HarmfulFloor_FloorDamage
    call FieldState_StepChecks_HarmfulFloor_DrainMP
    jr .check_status_field_step

.call_field_state_step_checks_harmful_floor:
    call FieldState_StepChecks_HarmfulFloor_PoisonDamage
    call FieldState_StepChecks_HarmfulFloor_DrainMP

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

; The MP loss of a harmful floor (when wStatusStepFlags bit 0 is set): each standing party member
; with status bit 0 set and MP left loses 1 MP. (C2, E-0357; probed E-0375)
FieldState_StepChecks_HarmfulFloor_DrainMP::
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

; Sets bit 7 of wFieldStepFlags (A = the new value). FieldState_StepChecks_HarmfulFloor_PoisonDamage
; and FieldState_StepChecks_HarmfulFloor_FloorDamage call it when a party member falls. (C2, E-0375)
; sets bit 7 of wFieldStepFlags (E-0114)
SetFieldStepFlagsBit7::
    ld a, [wFieldStepFlags]
    set 7, a
    ld [wFieldStepFlags], a
    ret

; The poison damage of a step: each standing party member (MON_STATUS bit 7 clear) with status bit 2
; loses 1 HP; one that reaches 0 or below falls: SetFieldStepFlagsBit7, its bit (party position) set
; in wStatusFieldStep, its status bits 2 and 3 cleared and bit 7 set, and its HP written as 0. (C2,
; E-0369; probed E-0375)
FieldState_StepChecks_HarmfulFloor_PoisonDamage::
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

; The damage of a harmful floor: each standing party member loses 10 HP (also setting
; wFieldStepFlags to $40) unless wStatusFieldStep bit 7 is set, in which case it loses 2 HP, or 5 on
; map $3A outside key worlds; a member that reaches 0 falls (status bit 7, its bit in
; wStatusFieldStep). (C2, E-0357; probed E-0375)
FieldState_StepChecks_HarmfulFloor_FloorDamage::
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

; The flash of a harmful floor or status step, by wMenuState (which
; FieldState_StepChecks_HarmfulFloor counts 0-4): at 0 plays sound $66, sets the DMG palettes
; $D2/$D2/$E2 and on CGB saves wBGPaletteBuffer to wBGPaletteCopy; at 1-3 (bit 2 clear) shows the
; flash, DMG $2D/$2D/$1D and on CGB the saved colours inverted into wBGPaletteBuffer; at 4 restores
; $D2/$D2/$E2 and the saved colours. On CGB each change sets wBGPaletteUploadRequest to $7F. (C2,
; E-0369; probed E-0375)
FieldState_StepChecks_HarmfulFloor_Flash::
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

; Field step check, far-called from the field step code of bank $02 after
; CheckWarpsAtPlayerPosition: jumps by wMapMoveType (a map header byte) to
; RunPlayerMoveTypeMapMoveType_None (0) or a harmful floor check:
; RunPlayerMoveTypeMapMoveType_HurtFloor1 (1, tile $44), RunPlayerMoveTypeMapMoveType_HurtFloor2 (2,
; $56), RunPlayerMoveTypeMapMoveType_HurtFloor3 (3, $44),
; RunPlayerMoveTypeMapMoveType_LightHurtFloor4 (4, $44), RunPlayerMoveTypeMapMoveType_HurtFloor (5,
; $44), RunPlayerMoveTypeMapMoveType_LightHurtFloor (6, $50) and
; RunPlayerMoveTypeMapMoveType_HurtFloor7 (7, $52). Each puts its tile in hTemp1 and sets
; wStatusFieldStep (0, or $80 with wFieldStepFlags $40 for the light kinds 4 and 6), then
; RunPlayerMoveTypeMapMoveType_CheckHurtTile switches to field state 7 when the player stands on
; that tile. (C2, E-0375)
; runs the movement routine for wMapMoveType (jump table of eight) (E-0122)
RunPlayerMoveTypeMapMoveType::
    ld a, [wMapMoveType]
    jumptable
    dw RunPlayerMoveTypeMapMoveType_None
    dw RunPlayerMoveTypeMapMoveType_HurtFloor1
    dw RunPlayerMoveTypeMapMoveType_HurtFloor2
    dw RunPlayerMoveTypeMapMoveType_HurtFloor3
    dw RunPlayerMoveTypeMapMoveType_LightHurtFloor4
    dw RunPlayerMoveTypeMapMoveType_HurtFloor
    dw RunPlayerMoveTypeMapMoveType_LightHurtFloor
    dw RunPlayerMoveTypeMapMoveType_HurtFloor7

; Map movement type 0: no harmful floor. (C2, E-0357; probed E-0375)
RunPlayerMoveTypeMapMoveType_None::
    ret

; Map movement type 6: floor tile $50 hurts, the lighter kind: hTemp1 = $50, wStatusFieldStep = $80
; (so FieldState_StepChecks_HarmfulFloor_FloorDamage takes 2 HP, or 5 on map $3A outside key worlds,
; instead of 10) and wFieldStepFlags = $40; continues in RunPlayerMoveTypeMapMoveType_CheckHurtTile.
; (C2, E-0375)
RunPlayerMoveTypeMapMoveType_LightHurtFloor::
    ld a, $50
    ldh [hTemp1], a
    ld a, $80
    ld [wStatusFieldStep], a
    ld a, $40
    ld [wFieldStepFlags], a
    jr RunPlayerMoveTypeMapMoveType_CheckHurtTile

; Map movement type 7: floor tile $52 hurts. (C2, E-0357; probed E-0375)
RunPlayerMoveTypeMapMoveType_HurtFloor7::
    ld a, $52
    ldh [hTemp1], a
    xor a
    ld [wStatusFieldStep], a
    jr RunPlayerMoveTypeMapMoveType_CheckHurtTile

; Map movement type 1: floor tile $44 hurts. (C2, E-0357; probed E-0375)
RunPlayerMoveTypeMapMoveType_HurtFloor1::
    ld a, $44
    ldh [hTemp1], a
    xor a
    ld [wStatusFieldStep], a
    jr RunPlayerMoveTypeMapMoveType_CheckHurtTile

; Map movement type 2: floor tile $56 hurts. (C2, E-0357; probed E-0375)
RunPlayerMoveTypeMapMoveType_HurtFloor2::
    ld a, $56
    ldh [hTemp1], a
    xor a
    ld [wStatusFieldStep], a
    jr RunPlayerMoveTypeMapMoveType_CheckHurtTile

; Map movement type 3: floor tile $44 hurts. (C2, E-0357; probed E-0375)
RunPlayerMoveTypeMapMoveType_HurtFloor3::
    ld a, $44
    ldh [hTemp1], a
    xor a
    ld [wStatusFieldStep], a
    jr RunPlayerMoveTypeMapMoveType_CheckHurtTile

; Map movement type 4: floor tile $44 hurts, the lighter kind (wStatusFieldStep $80, wFieldStepFlags
; $40). (C2, E-0357; probed E-0375)
RunPlayerMoveTypeMapMoveType_LightHurtFloor4::
    ld a, $44
    ldh [hTemp1], a
    ld a, $80
    ld [wStatusFieldStep], a
    ld a, $40
    ld [wFieldStepFlags], a
    jr RunPlayerMoveTypeMapMoveType_CheckHurtTile

; Map movement type 5: floor tile $44 hurts. (C2, E-0357; probed E-0375)
RunPlayerMoveTypeMapMoveType_HurtFloor::
    ld a, $44
    ldh [hTemp1], a
    xor a
    ld [wStatusFieldStep], a
    jr RunPlayerMoveTypeMapMoveType_CheckHurtTile

; When no fade, script or talk countdown is running and one of the four tiles under the player is
; the harmful tile in hTemp1, switches to field state 7 (the floor damage). (C2, E-0357; probed
; E-0375)
RunPlayerMoveTypeMapMoveType_CheckHurtTile::
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

; Field step check for the poison and MP-drain statuses, far-called after
; RunPlayerMoveTypeMapMoveType. It does nothing when hPlayerStateFlags bit 7 or 5 is set,
; EVENT_SCENE_LONG_FACES_002 is clear, the field state (wModeState low nibble) is 1, wModeState is
; 7, or the map is excluded: in key worlds (wMapType bit 7) the special maps $82, $83, $84 and $87,
; elsewhere maps below $20 and the 64 maps listed in EnterStatusEffectFieldState_Data. Otherwise,
; with SRAM enabled, it scans the standing party members (MON_STATUS bit 7 clear). Status bit 2
; (poison) toggles wStatusStepFlags bit 0 (ToggleStatusStepFlagsLowBitOnce, once per call) and
; switches to field state 7 with wMenuState 0, wMenuSubState 1 and wStatusFieldStep 0 (the poison
; damage and MP drain of FieldState_StepChecks_HarmfulFloor), also clearing wEncounterCountdown when
; coming from field state 3. Status bit 0 does the same toggle but switches only when bit 0 ends up
; set, so on every other step. At the end it clears wStatusStepFlags bit 7 and disables SRAM. (C2,
; E-0375)
; in the field (story flag 2, not in mode states 1 or 7, outside listed maps): when a party member
; has status bit 2 or 0 of field $55, switches to mode state 7 and toggles wStatusStepFlags (E-0129)
EnterStatusEffectFieldState::
    ldh a, [hPlayerStateFlags]
    bit 7, a
    ret nz
    bit 5, a
    ret nz
    ld de, EVENT_SCENE_LONG_FACES_002
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

; When wStatusStepFlags bit 7 is clear: wStatusStepFlags = ((wStatusStepFlags + 1) & 1) | $80,
; flipping bit 0 and setting bit 7 so that later calls in the same scan change nothing. Returns A =
; wStatusStepFlags either way. EnterStatusEffectFieldState clears bit 7 again when it finishes. (C2,
; E-0375)
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

; A list of 64 map ids in ascending order apart from $B2, $B1, then an $FF end marker: $21-$26,
; $29-$2B, $2D, $2E, $31-$34, $3C, $3D, $41, $45, $49-$4D, $4F-$52, $58-$61, $68, $71, $72, $78,
; $79, $7C-$7F, $89, $92, $9D, $A4, $A9, $AB, $AF, $B2, $B1, $B6, $B9, $BA, $BC, $C5, $D0, $D9, $E2.
; EnterStatusEffectFieldState compares hMapId with each byte (outside key worlds, on maps $20 and
; above) and returns at once on a match, so none of the poison and MP-drain field steps run on those
; maps. (C1, E-0381)
EnterStatusEffectFieldState_Data::
    db $21, $22, $23, $24, $25, $26, $29, $2a, $2b, $2d, $2e, $31, $32, $33, $34, $3c
    db $3d, $41, $45, $49, $4a, $4b, $4c, $4d, $4f
    dw FillEncounterFromEntry_Data2
    dw $5852
    dw $5a59
    dw PointerRun_Entry03
    dw PointerRun_Entry04
    dw $605f
    dw PointerRun_Entry06
    dw PointerRun_Entry07
    dw PointerRun_Entry08
    dw PointerRun_Entry09
    dw PointerRun_Entry0A
    db $89, $92, $9d, $a4, $a9, $ab, $af, $b2, $b1, $b6, $b9, $ba, $bc, $c5, $d0, $d9
    db $e2, $ff

; Field step check, far-called last after EnterStatusEffectFieldState: returns while a fade or
; script runs, when wEncounterRate & $7F is 0, or when wTalkCountdown is 0. Otherwise it decrements
; wTalkCountdown and, when that reaches 0, sets wTalkEventGroup = $1E and wTalkEventIndex = 0 and
; far-calls DispatchTalkEvent (a second wScriptRunning check would instead set wTalkCountdown back
; to 1, but scripts were already excluded). Field skill 14 sets wTalkCountdown = 200. (C1, E-0375)
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

; Field step check for random encounters, far-called from the field step code of bank $02. Returns
; while a fade or script runs, with hPlayerStateFlags bit 7 or 5 set, or in field state 1 or 4. If
; wEncounterRate bit 7 is set it only clears that bit (one step skipped); wEncounterRate 0 means no
; encounters. While wEncounterDelay is non-zero it counts that down instead and, on reaching 0,
; starts talk event group $1D (DispatchTalkEvent). Otherwise it subtracts from wEncounterCountdown:
; 1 with hPlayerStateFlags bit 3 set; else by EncounterRateTable record wEncounterRate: a non-zero
; byte 0 subtracts byte 1; byte 0 = 0 compares bytes 1-7 with the four tiles under the player
; (ReadTileBuffer2x2AtPixel_Bank0A) and subtracts 1, 1, 2, 2, 3, 3 or 4 for the first match, 1
; without one. When the count borrows, reaches 0 or is $E0 or more a battle starts: wBattleIntroKind
; 0 (1 in a key world), RedrawScreenBufferIfPartyWindowFlagsBit7, field state 3 with
; wBattleTransitionStep 0 and wBattleTransitionSubStep 0 or 2 (NextRandomSeed), wFieldReturnPhase 2,
; SaveScreenBufferToBGMap1 and a new count (PickRandomEncounterCountdownFromTable). (C1, E-0375)
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
    add LOW(EncounterRateTable)
    ld l, a
    ld a, h
    adc HIGH(EncounterRateTable)
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
    call PickRandomEncounterCountdownFromTable
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

; B = X pixel, C = Y pixel: HL = wScreenTileBuffer + 20 * (C / 8) + B / 8 (rows of 20 entries, as
; field mode uses the buffer); copies the 2 x 2 entries there to wTilesUnderPoint and
; wTilesUnderPoint + 1 (top row) and wTilesUnderPoint + 2 and + 3 (bottom row); HL ends on the
; bottom-right entry. TickRandomEncounterCounter and RunPlayerMoveTypeMapMoveType_CheckHurtTile read
; the tiles under the player with it. (C2, E-0375)
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

; Decides the foes and the battle kind as a battle starts (RunBattleTransitionStep_StartBattle):
; clears wBattleIntroFlag and jumps by wBattleIntroKind & 7 to 0
; RunBattleIntroKindCase_RandomEncounter (the map encounter tables), 1
; RunBattleIntroKindCase_KeyWorldEncounter, 2 RunBattleIntroKindCase_SetBattleKindTo02, 3
; RunBattleIntroKindCase_Kind3, 4 RunBattleIntroKindCase_SetBattleKindTo04, 5
; RunBattleIntroKindCase_StrengthSingleFoe, 6 RunBattleIntroKindCase_KeyWorldStrength or 7
; RunBattleIntroKindCase_SetBattleKindTo05. StartScriptedEncounterTemp0 sets intro kind 2 or 7 after
; filling the foes itself; the arena and field object code of banks $0C and $12 set others. (C2,
; E-0375)
; clears wBattleIntroFlag and runs the routine for wBattleIntroKind & 7 (jump table of eight)
; (E-0122)
RunBattleIntroKindCase::
    xor a
    ld [wBattleIntroFlag], a
    ld a, [wBattleIntroKind]
    and $07
    jumptable
    dw RunBattleIntroKindCase_RandomEncounter
    dw RunBattleIntroKindCase_KeyWorldEncounter
    dw RunBattleIntroKindCase_SetBattleKindTo02
    dw RunBattleIntroKindCase_Kind3
    dw RunBattleIntroKindCase_SetBattleKindTo04
    dw RunBattleIntroKindCase_StrengthSingleFoe
    dw RunBattleIntroKindCase_KeyWorldStrength
    dw RunBattleIntroKindCase_SetBattleKindTo05

; Battle intro kind 6, a key-world encounter by party strength. For field events (wPendingFieldEvent
; & $0F) below $0C it computes wPartyStrength (ComputePartyStrengthForKey; 0 without a party) and
; takes the word at RunBattleIntroKindCase_KeyWorldStrength_Data1 + 2 * (strength / 5) as a base
; monster id; each of the three foes is that id plus a random 0-9 (NextRandomSeed until wKeyRandomHi
; & $0F is below 10). For events $0C-$0F it copies the three fixed monster words of that event from
; RunBattleIntroKindCase_KeyWorldStrength_Data2. Encounter kind 2, battle kind 6. (C2, E-0375)
RunBattleIntroKindCase_KeyWorldStrength::
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
    ld de, RunBattleIntroKindCase_KeyWorldStrength_Data1
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
    ld de, RunBattleIntroKindCase_KeyWorldStrength_Data2
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

; Twenty little-endian words, indexed by party strength / 5 (wPartyStrength, quotient from
; DivideBByA): base monster numbers $00AC, $00BC, $00CC, $00DC, $00EC, $00FC, $010C, $011C, $012C,
; $013C, then $021E, $0223, $0228, $022D, $0232, $0237, $023C, $0241, $0246, $0248.
; RunBattleIntroKindCase_KeyWorldStrength stores the word in hTemp0/hTemp1 and gives each of the
; three foes in wEncounterMonsters that number plus a random 0-9. (C1, E-0381)
RunBattleIntroKindCase_KeyWorldStrength_Data1::
    db $ac, $00, $bc, $00, $cc, $00, $dc, $00, $ec, $00, $fc, $00, $0c, $01, $1c, $01
    db $2c, $01, $3c, $01, $1e, $02, $23, $02, $28, $02, $2d, $02, $32, $02, $37, $02
    db $3c, $02, $41, $02, $46, $02, $48, $02

; Twelve little-endian monster numbers in four groups of three, one group per field event $0C-$0F:
; $020B, $020C, $020D; $020E, $020F, $020E; $0210, $0211, $0212; $0213, $0214, $0215.
; RunBattleIntroKindCase_KeyWorldStrength copies the group 6 * (wPendingFieldEvent & $0F - $0C)
; bytes in to wEncounterMonsters as the three fixed foes of that event. (C1, E-0381)
RunBattleIntroKindCase_KeyWorldStrength_Data2::
    db $0b, $02, $0c, $02, $0d, $02, $0e, $02, $0f, $02, $0e, $02, $10, $02, $11, $02
    db $12, $02, $13, $02, $14, $02, $15, $02

; Battle intro kind 5: picks one monster id $76-$7D by party strength (one step per 5 points up to
; 35) as a single foe; encounter kind 0, battle kind 2. (C2, E-0357; probed E-0375)
RunBattleIntroKindCase_StrengthSingleFoe::
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

; Sets wEncounterCountdown = 2 * PickRandomEncounterCountdownFromTable_Data[v / 5], with v =
; wKeyRandomHi & $3F after NextRandomSeed. Its loop redraws when v is 100 or more, which never
; happens (v is at most 63), so only the first 13 of the 21 table bytes are used (counts 20 to 104).
; Called when a battle starts (TickRandomEncounterCounter, StartScriptedEncounterTemp0), when a save
; is continued (TitleMenu_Continue_LoadSave) and from scenes in banks $5F and $73. (C2, E-0375)
; draws random values until wKeyRandomHi & $3F is below 100, then wEncounterCountdown = 2 *
; PickRandomEncounterCountdownFromTable_Data[value / 5] (E-0122) (E-0344: the address in its name
; dropped or read as the label there; was PickRandomEncounterCountdownFromTable)
PickRandomEncounterCountdownFromTable::
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $3f
    cp $64
    jr nc, PickRandomEncounterCountdownFromTable
    ld b, a
    ld a, $05
    call DivideBByA
    ld a, b
    ld hl, PickRandomEncounterCountdownFromTable_Data
    add_a_to_hl
    ld a, [hl]
    add a
    ld [wEncounterCountdown], a
    ret

; Twenty-one counts in ascending order: $0A, $14, $19, $1E, $23, $28, $2A, $2C, $2D, $2E, $30, $32,
; $34, $36, $38, $3A, $3C, $41, $46, $50, $50. PickRandomEncounterCountdownFromTable indexes it by
; (wKeyRandomHi & $3F) / 5, which is at most 12, and stores twice the entry in wEncounterCountdown,
; so only the first 13 entries are reached. (C1, E-0381)
PickRandomEncounterCountdownFromTable_Data::
    db $0a, $14, $19, $1e, $23, $28, $2a, $2c, $2d, $2e, $30, $32, $34, $36, $38, $3a
    db $3c, $41, $46, $50, $50

; hTemp0 = encounter id: copies record hTemp0 of ScriptedEncounterTable (8 bytes each) into
; wEncounterKind (byte 0) and wEncounterMonsters (bytes 2-7, three monster words); sets
; wBattleIntroKind 2 (7 for records $14, $15 and $2F-$31), field state 3 with wBattleTransitionStep
; 0 and wBattleTransitionSubStep 1 (the spiral transition and battle music $46), wFieldReturnPhase
; 2; saves the screen (SaveScreenBufferToBGMap1) and picks a new encounter count
; (PickRandomEncounterCountdownFromTable). HL is kept. Scenes in banks $0F, $5F, $73 and $85
; far-call it for their set battles. (C1, E-0375)
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
    add LOW(ScriptedEncounterTable)
    ld l, a
    ld a, h
    adc HIGH(ScriptedEncounterTable)
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
    farcall PickRandomEncounterCountdownFromTable
    pop hl
    ret

; StartScriptedEncounterTemp0 (14 callers, script commands among them) reads the record at $481C + 8
; * hTemp0: byte 0 to wEncounterKind, bytes 2-7 to wEncounterMonsters; records $14, $15 and $2F-$31
; use battle intro 7, the rest intro 2; 51 records end at RunBattleIntroKindCase_RandomEncounter
; ($49B4) (E-0202, C1)
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

; Battle intro kind 0, a normal random encounter: picks the encounter table for the current map
; (and, on some maps, the screen or the player's state flags), then fills the three foes from it
; (FillEncounterFromEntry). (C2, E-0357; probed E-0375)
RunBattleIntroKindCase_RandomEncounter::
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
    jp z, .call_fill_encounter_from_entry4
    cp $55
    jp z, .call_fill_encounter_from_entry4
    cp $56
    jp z, .call_fill_encounter_from_entry4
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
    ld de, EncounterGrid_1
    ld a, $08
    call ReadMapCellWordForScreenXY
    ret

.check_player_state_flags:
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, .call_fill_encounter_from_entry
    ld de, EncounterGrid_2
    ld a, $04
    call ReadMapCellWordForScreenXY
    ret

.call_fill_encounter_from_entry:
    ld de, EncounterGroup_Direct1
    call FillEncounterFromEntry
    ret

.check_player_state_flags2:
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, .call_fill_encounter_from_entry2
    ld de, EncounterGrid_3
    ld a, $08
    call ReadMapCellWordForScreenXY
    ret

.call_fill_encounter_from_entry2:
    ld de, EncounterGroup_Direct2
    call FillEncounterFromEntry
    ret

.call_read_map_cell_word_for_screen_xy2:
    ld de, EncounterGrid_4
    ld a, $04
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy3:
    ld de, EncounterGrid_5
    ld a, $04
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy4:
    ld de, EncounterGrid_6
    ld a, $04
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy5:
    ld de, EncounterGrid_7
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy6:
    ld de, EncounterGrid_8
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy7:
    ld de, EncounterGrid_9
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy8:
    ld de, EncounterGrid_10
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy9:
    ld de, EncounterGrid_11
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy10:
    ld de, EncounterGrid_12
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

.check_player_state_flags3:
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, .call_fill_encounter_from_entry3
    ld de, EncounterGrid_13
    ld a, $0c
    call ReadMapCellWordForScreenXY
    ret

.call_fill_encounter_from_entry3:
    ld de, EncounterGroup_Direct3
    call FillEncounterFromEntry
    ret

.call_read_map_cell_word_for_screen_xy11:
    ld de, EncounterGrid_14
    ld a, $04
    call ReadMapCellWordForScreenXY
    ret

.call_fill_encounter_from_entry4:
    ld de, EncounterGroup_Direct4
    call FillEncounterFromEntry
    ret

.call_read_map_cell_word_for_screen_xy12:
    ld de, EncounterGrid_15
    ld a, $04
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy13:
    ld de, EncounterGrid_16
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy14:
    ld de, EncounterGrid_17
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy15:
    ld de, EncounterGrid_18
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy16:
    ld de, EncounterGrid_19
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy17:
    ld de, EncounterGrid_20
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy18:
    ld de, EncounterGrid_21
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy19:
    ld de, EncounterGrid_22
    ld a, $0c
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy20:
    ld de, EncounterGrid_23
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy21:
    ld de, EncounterGrid_24
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy22:
    ld de, EncounterGrid_25
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy23:
    ld de, EncounterGrid_26
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy24:
    ld de, EncounterGrid_27
    ld a, $01
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy25:
    ld de, EncounterGrid_28
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy26:
    ld de, EncounterGrid_29
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy27:
    ld de, EncounterGrid_30
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy28:
    ld de, EncounterGrid_31
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy29:
    ld de, EncounterGrid_32
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy30:
    ld de, EncounterGrid_33
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy31:
    ld de, EncounterGrid_34
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy32:
    ld de, EncounterGrid_35
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy33:
    ld de, EncounterGrid_36
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy34:
    ld de, EncounterGrid_37
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy35:
    ld de, EncounterGrid_38
    ld a, $04
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy36:
    ld de, EncounterGrid_39
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy37:
    ld de, EncounterGrid_40
    ld a, $06
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy38:
    ld de, EncounterGrid_41
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy39:
    ld de, EncounterGrid_42
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy40:
    ld de, EncounterGrid_43
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.check_player_state_flags4:
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, .call_fill_encounter_from_entry5
    ld de, EncounterGrid_44
    ld a, $05
    call ReadMapCellWordForScreenXY
    ret

.call_fill_encounter_from_entry5:
    ld de, EncounterGroup_Direct5
    call FillEncounterFromEntry
    ret

.call_read_map_cell_word_for_screen_xy41:
    ld de, EncounterGrid_45
    ld a, $01
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy42:
    ld de, EncounterGrid_46
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy43:
    ld de, EncounterGrid_47
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

.call_read_map_cell_word_for_screen_xy44:
    ld de, EncounterGrid_48
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

; A = cells per row, DE = encounter grid: DE = the word at DE + 2 * (A * (hMapScreenY & $0F) +
; (hMapScreenX & $0F)), the encounter entry of the current map screen, then falls into
; FillEncounterFromEntry. RunBattleIntroKindCase_RandomEncounter uses it for the maps that have a
; grid table (EncounterGrid_1 and the others). (C2, E-0375)
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

; DE = encounter entry (17 bytes): byte 0 = encounter kind + 1, byte 1 = a cap, bytes 2-6 = five
; rising thresholds, then five monster words. For each of the three foes it draws r = wRandomLo &
; $7F (NextTableByte), drawing again while r is above the cap, and stores in wEncounterMonsters the
; word of the first threshold that is r or more (the slot is left unchanged when none is). Then
; wBattleKind = 0 and wEncounterKind = byte 0 - 1, except that kind 1 is replaced by
; FillEncounterFromEntry_Data2[random & 3] (0 or 1) and kinds 2 and above by
; FillEncounterFromEntry_Data1[random & 3] (0, 1 or 2). ReadMapCellWordForScreenXY falls into it.
; (C2, E-0375)
FillEncounterFromEntry::
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
    ld hl, FillEncounterFromEntry_Data2
    jr .call_next_table_byte2

.call_next_table_byte:
    ld hl, FillEncounterFromEntry_Data1

.call_next_table_byte2:
    call NextTableByte
    ld a, [wRandomLo]
    and $03
    add_a_to_hl
    ld a, [hl]
    ld [wEncounterKind], a
    ret

; The map dispatch of CollectUniqueEncounterIdsToWorkBuf2 for maps outside key worlds: by hMapId
; (and on some maps the screen position or hPlayerStateFlags bit 3) it picks the same encounter
; entry as RunBattleIntroKindCase_RandomEncounter (except that map $B8 ignores hPlayerStateFlags bit
; 3) and lists it with LoadEncounterMonsterIdsToWorkBuf, directly or through
; LoadEncounterIdsForScreenCell: wWorkBuf = the count, then from wWorkBuf + 2 the picture numbers of
; the entry monsters. It does not remove duplicates; an unlisted map leaves wWorkBuf unchanged. (C2,
; E-0375)
CollectUniqueEncounterIdsToWorkBuf2_FindTable::
    ldh a, [hMapId]
    cp $20
    jp z, .call_load_encounter_ids_for_screen_cell
    cp $2b
    jp z, .check_player_state_flags
    cp $30
    jp z, .check_player_state_flags2
    cp $35
    jp z, .call_load_encounter_ids_for_screen_cell2
    cp $38
    jp z, .call_load_encounter_ids_for_screen_cell3
    cp $39
    jp z, .call_load_encounter_ids_for_screen_cell4
    cp $3a
    jp z, .call_load_encounter_ids_for_screen_cell5
    cp $3e
    jp z, .call_load_encounter_ids_for_screen_cell6
    cp $3f
    jp z, .call_load_encounter_ids_for_screen_cell7
    cp $37
    jp z, .call_load_encounter_ids_for_screen_cell8
    cp $42
    jp z, .call_load_encounter_ids_for_screen_cell9
    cp $43
    jp z, .call_load_encounter_ids_for_screen_cell10
    cp $48
    jp z, .check_player_state_flags3
    cp $53
    jp z, .call_load_encounter_ids_for_screen_cell11
    cp $54
    jp z, .call_load_encounter_monster_ids_to_work_buf4
    cp $55
    jp z, .call_load_encounter_monster_ids_to_work_buf4
    cp $56
    jp z, .call_load_encounter_monster_ids_to_work_buf4
    cp $5d
    jp z, .call_load_encounter_ids_for_screen_cell12
    cp $62
    jp z, .call_load_encounter_ids_for_screen_cell13
    cp $63
    jp z, .call_load_encounter_ids_for_screen_cell14
    cp $64
    jp z, .call_load_encounter_ids_for_screen_cell15
    cp $65
    jp z, .call_load_encounter_ids_for_screen_cell16
    cp $66
    jp z, .call_load_encounter_ids_for_screen_cell17
    cp $67
    jp z, .call_load_encounter_ids_for_screen_cell18
    cp $70
    jp z, .call_load_encounter_ids_for_screen_cell19
    cp $73
    jp z, .call_load_encounter_ids_for_screen_cell20
    cp $74
    jp z, .call_load_encounter_ids_for_screen_cell21
    cp $75
    jp z, .call_load_encounter_ids_for_screen_cell22
    cp $76
    jp z, .call_load_encounter_ids_for_screen_cell23
    cp $81
    jp z, .call_load_encounter_ids_for_screen_cell24
    cp $82
    jp z, .call_load_encounter_ids_for_screen_cell25
    cp $83
    jp z, .call_load_encounter_ids_for_screen_cell26
    cp $85
    jp z, .call_load_encounter_ids_for_screen_cell27
    cp $86
    jp z, .call_load_encounter_ids_for_screen_cell28
    cp $87
    jp z, .call_load_encounter_ids_for_screen_cell29
    cp $88
    jp z, .call_load_encounter_ids_for_screen_cell30
    cp $8b
    jp z, .call_load_encounter_ids_for_screen_cell31
    cp $8c
    jp z, .call_load_encounter_ids_for_screen_cell32
    cp $8e
    jp z, .call_load_encounter_ids_for_screen_cell33
    cp $90
    jp z, .call_load_encounter_ids_for_screen_cell34
    cp $a0
    jp z, .call_load_encounter_ids_for_screen_cell35
    cp $a2
    jp z, .call_load_encounter_ids_for_screen_cell36
    cp $a8
    jp z, .call_load_encounter_ids_for_screen_cell37
    cp $ad
    jp z, .call_load_encounter_ids_for_screen_cell38
    cp $ae
    jp z, .call_load_encounter_ids_for_screen_cell38
    cp $b0
    jp z, .call_load_encounter_ids_for_screen_cell39
    cp $b3
    jp z, .call_load_encounter_ids_for_screen_cell40
    cp $b4
    jp z, .call_load_encounter_ids_for_screen_cell40
    cp $b5
    jp z, .call_load_encounter_ids_for_screen_cell40
    cp $b8
    jp z, .call_load_encounter_ids_for_screen_cell41
    cp $be
    jp z, .call_load_encounter_ids_for_screen_cell42
    cp $bf
    jp z, .call_load_encounter_ids_for_screen_cell43
    cp $c0
    jp z, .call_load_encounter_ids_for_screen_cell44
    cp $c1
    jp z, .call_load_encounter_ids_for_screen_cell44
    cp $c2
    jp z, .call_load_encounter_ids_for_screen_cell45
    cp $c3
    jp z, .call_load_encounter_ids_for_screen_cell45
    ret

.call_load_encounter_ids_for_screen_cell:
    ld de, EncounterGrid_1
    ld a, $08
    call LoadEncounterIdsForScreenCell
    ret

.check_player_state_flags:
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, .call_load_encounter_monster_ids_to_work_buf
    ld de, EncounterGrid_2
    ld a, $04
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_monster_ids_to_work_buf:
    ld de, EncounterGroup_Direct1
    call LoadEncounterMonsterIdsToWorkBuf
    ret

.check_player_state_flags2:
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, .call_load_encounter_monster_ids_to_work_buf2
    ld de, EncounterGrid_3
    ld a, $08
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_monster_ids_to_work_buf2:
    ld de, EncounterGroup_Direct2
    call LoadEncounterMonsterIdsToWorkBuf
    ret

.call_load_encounter_ids_for_screen_cell2:
    ld de, EncounterGrid_4
    ld a, $04
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell3:
    ld de, EncounterGrid_5
    ld a, $04
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell4:
    ld de, EncounterGrid_6
    ld a, $04
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell5:
    ld de, EncounterGrid_7
    ld a, $03
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell6:
    ld de, EncounterGrid_8
    ld a, $02
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell7:
    ld de, EncounterGrid_9
    ld a, $02
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell8:
    ld de, EncounterGrid_10
    ld a, $03
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell9:
    ld de, EncounterGrid_11
    ld a, $03
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell10:
    ld de, EncounterGrid_12
    ld a, $03
    call LoadEncounterIdsForScreenCell
    ret

.check_player_state_flags3:
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, .call_load_encounter_monster_ids_to_work_buf3
    ld de, EncounterGrid_13
    ld a, $0c
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_monster_ids_to_work_buf3:
    ld de, EncounterGroup_Direct3
    call LoadEncounterMonsterIdsToWorkBuf
    ret

.call_load_encounter_ids_for_screen_cell11:
    ld de, EncounterGrid_14
    ld a, $04
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_monster_ids_to_work_buf4:
    ld de, EncounterGroup_Direct4
    call LoadEncounterMonsterIdsToWorkBuf
    ret

.call_load_encounter_ids_for_screen_cell12:
    ld de, EncounterGrid_15
    ld a, $04
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell13:
    ld de, EncounterGrid_16
    ld a, $02
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell14:
    ld de, EncounterGrid_17
    ld a, $02
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell15:
    ld de, EncounterGrid_18
    ld a, $02
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell16:
    ld de, EncounterGrid_19
    ld a, $02
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell17:
    ld de, EncounterGrid_20
    ld a, $02
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell18:
    ld de, EncounterGrid_21
    ld a, $02
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell19:
    ld de, EncounterGrid_22
    ld a, $0c
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell20:
    ld de, EncounterGrid_23
    ld a, $02
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell21:
    ld de, EncounterGrid_24
    ld a, $02
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell22:
    ld de, EncounterGrid_25
    ld a, $02
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell23:
    ld de, EncounterGrid_26
    ld a, $02
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell24:
    ld de, EncounterGrid_27
    ld a, $01
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell25:
    ld de, EncounterGrid_28
    ld a, $03
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell26:
    ld de, EncounterGrid_29
    ld a, $03
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell27:
    ld de, EncounterGrid_30
    ld a, $02
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell28:
    ld de, EncounterGrid_31
    ld a, $02
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell29:
    ld de, EncounterGrid_32
    ld a, $02
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell30:
    ld de, EncounterGrid_33
    ld a, $02
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell31:
    ld de, EncounterGrid_34
    ld a, $03
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell32:
    ld de, EncounterGrid_35
    ld a, $03
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell33:
    ld de, EncounterGrid_36
    ld a, $03
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell34:
    ld de, EncounterGrid_37
    ld a, $03
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell35:
    ld de, EncounterGrid_38
    ld a, $04
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell36:
    ld de, EncounterGrid_39
    ld a, $03
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell37:
    ld de, EncounterGrid_40
    ld a, $06
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell38:
    ld de, EncounterGrid_41
    ld a, $03
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell39:
    ld de, EncounterGrid_42
    ld a, $03
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell40:
    ld de, EncounterGrid_43
    ld a, $02
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell41:
    ld de, EncounterGrid_44
    ld a, $05
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell42:
    ld de, EncounterGrid_45
    ld a, $01
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell43:
    ld de, EncounterGrid_46
    ld a, $02
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell44:
    ld de, EncounterGrid_47
    ld a, $02
    call LoadEncounterIdsForScreenCell
    ret

.call_load_encounter_ids_for_screen_cell45:
    ld de, EncounterGrid_48
    ld a, $02
    call LoadEncounterIdsForScreenCell
    ret

; The grid look-up of ReadMapCellWordForScreenXY (A = cells per row, DE = grid: DE = the entry word
; for hMapScreenY & $0F and hMapScreenX & $0F), falling into LoadEncounterMonsterIdsToWorkBuf
; instead of FillEncounterFromEntry. CollectUniqueEncounterIdsToWorkBuf2_FindTable uses it for the
; maps with a grid table (EncounterGrid_1 and the others). (C2, E-0375)
; DE = the word at DE + 2 * A * (hMapScreenY & $0F) + 2 * (hMapScreenX & $0F); falls through
; (E-0122) (E-0344: the address in its name dropped or read as the label there; was
; LoadEncounterIdsForScreenCell)
LoadEncounterIdsForScreenCell::
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

; DE = encounter entry (the FillEncounterFromEntry layout): wWorkBuf = the number of leading
; non-zero thresholds (entry bytes 2-6, at most 5), wWorkBuf + 1 = 0, and from wWorkBuf + 2 that
; many monster words, each replaced by the first word of its MonsterTable entry, the picture number
; (CopyMonsterTableBytesFromMonsterTable with hTemp0 = 2, C = 0). A count of 0 is not handled: the
; copy loops would run 256 times. (C2, E-0375)
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

; Battle intro kind 2: battle kind 2. (C2, E-0357; probed E-0375)
RunBattleIntroKindCase_SetBattleKindTo02::
    ld a, $02
    ld [wBattleKind], a
    ret

; Battle intro kind 1, a key-world encounter: picks a random encounter kind (one of four) and the
; area's monster group from wKeyWorldAreas (or the floor's entry in wKeyWorldFloorInfo), draws the
; foes (RunBattleIntroKindCase_KeyWorldEncounter_RollFoes) and sets battle kind 1. (C2, E-0357;
; probed E-0375)
RunBattleIntroKindCase_KeyWorldEncounter::
    call NextTableByte
    ld a, [wRandomLo]
    and $03
    ld hl, FillEncounterFromEntry_Data1
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
    call RunBattleIntroKindCase_KeyWorldEncounter_RollFoes
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
    call RunBattleIntroKindCase_KeyWorldEncounter_RollFoes
    ld a, $01
    ld [wBattleKind], a
    ret

; Four encounter kind values, 0, 2, 1, 2, indexed by wRandomLo & 3 after NextTableByte.
; FillEncounterFromEntry replaces an encounter kind of 2 or more with the entry, and
; RunBattleIntroKindCase_KeyWorldEncounter picks wEncounterKind from it at random (kind 2 twice as
; often as 0 or 1). (C1, E-0381)
FillEncounterFromEntry_Data1::
    db $00, $02, $01, $02

; Four encounter kind values, 0, 1, 0, 1, indexed by wRandomLo & 3 after NextTableByte.
; FillEncounterFromEntry replaces an encounter kind of exactly 1 with the entry, so such an entry
; becomes kind 0 or 1 at random. (C1, E-0381)
FillEncounterFromEntry_Data2::
    db $00, $01, $00, $01

; Fills the three foes of a key-world encounter from wKeyWorldMonsters (id byte, then level * 2 with
; the id's high bit in bit 0). Normally each foe is entry C + (wKeyRandomLo & 7) after
; NextRandomSeed, capped at entry $1F, where C is the group the caller computed; with
; hPlayerStateFlags bit 3 set each is entry $20 + (wKeyRandomLo & 7) instead, past the 32 rolled
; entries, and C is ignored. The id word goes to wEncounterMonsters and the level (byte / 2) to
; wWildLevel + foe index. (C2, E-0369; probed E-0375)
RunBattleIntroKindCase_KeyWorldEncounter_RollFoes::
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

; Battle intro kind 3: battle kind 3, with the intro flag set on map type $82. (C2, E-0357; probed
; E-0375)
RunBattleIntroKindCase_Kind3::
    ld a, [wMapType]
    cp $82
    jr nz, .set_battle_kind_to_03
    ld a, $01
    ld [wBattleIntroFlag], a

.set_battle_kind_to_03:
    ld a, $03
    ld [wBattleKind], a
    ret

; Battle intro kind 4: battle kind 4. (C2, E-0357; probed E-0375)
RunBattleIntroKindCase_SetBattleKindTo04::
    ld a, $04
    ld [wBattleKind], a
    ret

; Battle intro kind 7: battle kind 5. (C2, E-0357; probed E-0375)
RunBattleIntroKindCase_SetBattleKindTo05::
    ld a, $05
    ld [wBattleKind], a
    ret

; Field state 3 (FieldState_BattleTransition) step: jumps by wBattleTransitionStep to 0
; RunBattleTransitionStep_PlayBattleMusic (battle music and the start position of the effect), 1
; RunBattleTransitionStep_StagedSteps (the screen effect chosen by wBattleTransitionSubStep) or 2
; RunBattleTransitionStep_StartBattle (when the music has stopped: RunBattleIntroKindCase, fade,
; game mode 4). (C1, E-0375)
; runs the routine for wBattleTransitionStep (jump table of three); field mode state 3 (E-0122)
RunBattleTransitionStep::
    ld a, [wBattleTransitionStep]
    jumptable
    dw RunBattleTransitionStep_PlayBattleMusic
    dw RunBattleTransitionStep_StagedSteps
    dw RunBattleTransitionStep_StartBattle

; Battle transition, step 0: remembers the current music, plays battle music $44 or $46, sets the
; sprite clipping and the starting BG map position for the effect. (C2, E-0357; probed E-0375)
RunBattleTransitionStep_PlayBattleMusic::
    ld a, [wCurrentMusic]
    ld [wTransitionMusic], a
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
    ld [wTransitionWork], a
    ld hl, wBattleTransitionStep
    inc [hl]
    ret

; Battle transition, step 2: when the music has stopped on every channel, decides the battle
; (RunBattleIntroKindCase), fades out and switches to game mode 4 (the battle). (C1, E-0357)
RunBattleTransitionStep_StartBattle::
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

; Battle transition step 1, the screen effect, by wBattleTransitionSubStep (set as the battle
; starts: 0 or 2 at random by TickRandomEncounterCounter, 1 by StartScriptedEncounterTemp0): 0
; RunBattleTransitionStep_CheckStage (columns closing from both sides), 1
; RunBattleTransitionStep_StagedSteps_Spiral (the spiral) and 2
; RunBattleTransitionStep_StagedSteps_Stripes. (C1, E-0375)
; by its sub-step: CheckStage, the transition counter, SetCounts
RunBattleTransitionStep_StagedSteps::
    ld a, [wBattleTransitionSubStep]
    jumptable
    dw RunBattleTransitionStep_CheckStage
    dw RunBattleTransitionStep_StagedSteps_Spiral
    dw RunBattleTransitionStep_StagedSteps_Stripes

; The closing-columns transition (sub-step 0 of RunBattleTransitionStep_StagedSteps), by
; wTransitionCounter: 0 RunBattleTransitionStep_CheckStage_CloseColumns (20 stages, one column
; blanked from each side per stage) and 1 RunBattleTransitionStep_CheckStage_End (moves
; wBattleTransitionStep on to the battle start). (C1, E-0375)
; (E-0345: was RunBattleTransitionStep_CheckStage) reads the transition stage, then advances the
; step
RunBattleTransitionStep_CheckStage::
    ld a, [wTransitionCounter]
    jumptable
    dw RunBattleTransitionStep_CheckStage_CloseColumns
    dw RunBattleTransitionStep_CheckStage_End

; Battle transition, closing columns (entry 0 of RunBattleTransitionStep_CheckStage): for stage
; wTransitionStage (0-19) blanks with tile $C4 (WriteTileC4AtTransitionBGPtrLoAndClearAttr) column
; wTransitionStage on rows 0, 2, ... 16 and column 19 - wTransitionStage on rows 1, 3, ... 17 of the
; transition area, then counts the stage; at stage 20 it moves wTransitionCounter to the next entry.
; (C1, E-0369)
RunBattleTransitionStep_CheckStage_CloseColumns::
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

; Ends the closing transition: next transition step. (C2, E-0357; probed E-0375)
RunBattleTransitionStep_CheckStage_End::
    ld hl, wBattleTransitionStep
    inc [hl]
    ret

; Blanks one tile of a battle transition. HL = the offset from the transition origin (row in the
; high bits, column in L & $1F); WriteTileC4AtTransitionBGPtrLoAndClearAttr_Locate turns it into the
; BG map address, WriteVRAMByte writes tile $C4 there and, when wIsCGB is non-zero, attribute 0 at
; the same address in VRAM bank 1 (rVBK 1, then back to 0). Returns HL = that BG map address; BC
; kept. Every closing-columns, spiral and stripe transition stage calls it per tile. (C1, E-0376)
; writes tile $C4 at the BG map address from WriteTileC4AtTransitionBGPtrLoAndClearAttr_Locate and,
; on CGB, attribute 0 in VRAM bank 1 (E-0122)
WriteTileC4AtTransitionBGPtrLoAndClearAttr::
    call WriteTileC4AtTransitionBGPtrLoAndClearAttr_Locate
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

; Moves HL to the BG map position of offset L from the transition origin: row by the high bits, then
; L & $1F columns to the right with wrapping. (C2, E-0357; probed E-0376)
WriteTileC4AtTransitionBGPtrLoAndClearAttr_Locate::
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

; HL = the next BG map entry to the right inside the same 32-entry row: L = (L & $E0) | ((L + 1) &
; $1F), so the last column wraps to column 0 of that row; H is unchanged and AF is kept.
; WriteTileC4AtTransitionBGPtrLoAndClearAttr_Locate calls it once per column. (C2, E-0376)
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

; HL = wTransitionBGPtrLo/wTransitionBGPtrHi + HL, with the sum high byte cut to its low 2 bits and
; the upper 6 bits taken from wTransitionBGPtrHi, so the result wraps inside the 1 KB BG map the
; pointer is in. Used by WriteTileC4AtTransitionBGPtrLoAndClearAttr_Locate for the row part of a
; transition offset. (C2, E-0376)
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

; The spiral transition: six tiles per frame. (C1, E-0357)
RunBattleTransitionStep_StagedSteps_Spiral::
    ld b, $06

; Runs the spiral transition's current pass (wTransitionCounter): pass 0, pass 1, or the end. (C1,
; E-0357)
RunBattleTransitionStep_StagedSteps_SpiralPass::
    ld a, [wTransitionCounter]
    jumptable
    dw SpiralTransition_Pass0
    dw SpiralTransition_Pass1
    dw SpiralTransition_End

; Spiral pass 0: picks the direction of the next tile from the stage (right, down, left or up along
; shrinking rings) and blanks it. (C1, E-0357)
SpiralTransition_Pass0::
    push bc
    ld a, [wTransitionStage]
    cp $11
    jp c, SpiralTransition_BlankMoveUp
    cp $23
    jp c, SpiralTransition_BlankMoveLeft
    cp $33
    jp c, SpiralTransition_BlankMoveDown
    cp $43
    jp c, SpiralTransition_BlankMoveRight
    cp $51
    jp c, SpiralTransition_BlankMoveUp
    cp $5f
    jp c, SpiralTransition_BlankMoveLeft
    cp $6b
    jp c, SpiralTransition_BlankMoveDown
    cp $77
    jp c, SpiralTransition_BlankMoveRight
    cp $81
    jr c, SpiralTransition_BlankMoveUp
    cp $8b
    jp c, SpiralTransition_BlankMoveLeft
    cp $93
    jp c, SpiralTransition_BlankMoveDown
    cp $9b
    jp c, SpiralTransition_BlankMoveRight
    cp $a1
    jr c, SpiralTransition_BlankMoveUp
    cp $a7
    jp c, SpiralTransition_BlankMoveLeft
    cp $ab
    jp c, SpiralTransition_BlankMoveDown
    cp $af
    jp c, SpiralTransition_BlankMoveRight
    cp $b1
    jr c, SpiralTransition_BlankMoveUp
    jr SpiralTransition_BlankMoveLeft

; Spiral pass 1: the reverse spiral, the direction from the stage by a second table of ring
; boundaries. (C1, E-0357)
SpiralTransition_Pass1::
    push bc
    ld a, [wTransitionStage]
    cp $02
    jr c, SpiralTransition_BlankMoveLeft
    cp $04
    jr c, SpiralTransition_BlankMoveUp
    cp $08
    jp c, SpiralTransition_BlankMoveRight
    cp $0c
    jp c, SpiralTransition_BlankMoveDown
    cp $12
    jr c, SpiralTransition_BlankMoveLeft
    cp $18
    jr c, SpiralTransition_BlankMoveUp
    cp $20
    jp c, SpiralTransition_BlankMoveRight
    cp $28
    jr c, SpiralTransition_BlankMoveDown
    cp $32
    jr c, SpiralTransition_BlankMoveLeft
    cp $3c
    jr c, SpiralTransition_BlankMoveUp
    cp $48
    jr c, SpiralTransition_BlankMoveRight
    cp $54
    jr c, SpiralTransition_BlankMoveDown
    cp $62
    jr c, SpiralTransition_BlankMoveLeft
    cp $70
    jr c, SpiralTransition_BlankMoveUp
    cp $80
    jr c, SpiralTransition_BlankMoveRight
    cp $90
    jr c, SpiralTransition_BlankMoveDown
    cp $a2
    jr c, SpiralTransition_BlankMoveLeft
    jr SpiralTransition_BlankMoveUp

; Blanks the tile at the spiral position and moves up a row (starting at offset $233 on the first
; stage). (C1, E-0357)
SpiralTransition_BlankMoveUp::
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
    jr SpiralTransition_NextStage

; Blanks the tile at the spiral position and moves left a column (starting at offset $12A on the
; first stage). (C1, E-0357)
SpiralTransition_BlankMoveLeft::
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
    jr SpiralTransition_NextStage

; Blanks the tile at the spiral position and moves down a row. (C1, E-0357)
SpiralTransition_BlankMoveDown::
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
    jr SpiralTransition_NextStage

; Blanks the tile at the spiral position and moves right a column. (C1, E-0357)
SpiralTransition_BlankMoveRight::
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

; Stores the spiral position and counts the stage; after $B4 stages the pass ends. Repeats for the
; frame's tile count. (C1, E-0357)
SpiralTransition_NextStage::
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
    jp nz, RunBattleTransitionStep_StagedSteps_SpiralPass
    ret

; Ends the spiral transition: next transition step. (C2, E-0357; probed E-0376)
SpiralTransition_End::
    ld hl, wBattleTransitionStep
    inc [hl]
    ret

; The stripe transition (sub-step 2 of RunBattleTransitionStep_StagedSteps), by wTransitionCounter:
; 0 StripeTransition_BlankStripes (blanks one rectangular ring of tiles per stage, outermost first,
; nine stages, and moves wTransitionCounter on), 1 StripeTransition_IdleFrame (moves
; wTransitionCounter back to 0, so a ring is drawn every other frame) and 2 StripeTransition_End
; (after the ninth ring: moves wBattleTransitionStep on). The old reading 'sets the transition
; counts from the stage record' was wrong. (C1, E-0376)
; (E-0345: was RunBattleTransitionStep_StagedSteps_Stripes) sets the transition counts from the
; stage record, then advances
RunBattleTransitionStep_StagedSteps_Stripes::
    ld a, [wTransitionCounter]
    jumptable
    dw StripeTransition_BlankStripes
    dw StripeTransition_IdleFrame
    dw StripeTransition_End

; The stripe transition: blanks the rows or columns listed for the stage (row steps from
; TransitionRowStepTable, counts from RunBattleTransitionStep_SetCounts_Data1). (C1, E-0357)
StripeTransition_BlankStripes::
    ld a, [wTransitionStage]
    or a
    jr nz, .read_transition_stage
    ld hl, $0000
    ld a, l
    ld [wTransitionCountA], a
    ld a, h
    ld [wTransitionCountB], a

.read_transition_stage:
    ld hl, StripeTransition_BlankStripes_Data1
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
    ld hl, StripeTransition_BlankStripes_Data1
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
    ld hl, StripeTransition_BlankStripes_Data2
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
    ld hl, StripeTransition_BlankStripes_Data2
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

; The stripe transition's wait step: goes back one pass. (C2, E-0357; probed E-0376)
StripeTransition_IdleFrame::
    ld hl, wTransitionCounter
    dec [hl]
    ret

; Ends the stripe transition: next transition step. (C2, E-0357; probed E-0376)
StripeTransition_End::
    ld hl, wBattleTransitionStep
    inc [hl]
    ret

; Jumps to the address stored at HL (HL = the word at HL, then jp hl); the target returns to the
; caller of this routine. StripeTransition_BlankStripes calls it with HL at the stage entry of
; TransitionRowStepTable. (C1, E-0376)
; HL = the word at HL, then jp hl (E-0114)
JumpToWordAtHL_Bank0A::
    deref_hl
    jp hl

; Entry 0 of TransitionRowStepTable, run by StripeTransition_BlankStripes for stage 0: DE += $0220
; (17 BG map rows) and HL = the new DE, the offset of the bottom row of that stage ring (DE = the
; ring top-left offset, wTransitionCountA/B); A = the new D. (C2, E-0376)
; handler 00 (entry 0 of TransitionRowStepTable) (E-0202)
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

; Entry 1 of TransitionRowStepTable, run by StripeTransition_BlankStripes for stage 1: DE += $01E0
; (15 BG map rows) and HL = the new DE, the offset of the bottom row of that stage ring (DE = the
; ring top-left offset, wTransitionCountA/B); A = the new D. (C2, E-0376)
; handler 01 (entry 1 of TransitionRowStepTable) (E-0202)
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

; Entry 2 of TransitionRowStepTable, run by StripeTransition_BlankStripes for stage 2: DE += $01A0
; (13 BG map rows) and HL = the new DE, the offset of the bottom row of that stage ring (DE = the
; ring top-left offset, wTransitionCountA/B); A = the new D. (C2, E-0376)
; handler 02 (entry 2 of TransitionRowStepTable) (E-0202)
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

; Entry 3 of TransitionRowStepTable, run by StripeTransition_BlankStripes for stage 3: DE += $0160
; (11 BG map rows) and HL = the new DE, the offset of the bottom row of that stage ring (DE = the
; ring top-left offset, wTransitionCountA/B); A = the new D. (C2, E-0376)
; handler 03 (entry 3 of TransitionRowStepTable) (E-0202)
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

; Entry 4 of TransitionRowStepTable, run by StripeTransition_BlankStripes for stage 4: DE += $0120
; (9 BG map rows) and HL = the new DE, the offset of the bottom row of that stage ring (DE = the
; ring top-left offset, wTransitionCountA/B); A = the new D. (C2, E-0376)
; handler 04 (entry 4 of TransitionRowStepTable) (E-0202)
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

; Entry 5 of TransitionRowStepTable, run by StripeTransition_BlankStripes for stage 5: DE += $00E0
; (7 BG map rows) and HL = the new DE, the offset of the bottom row of that stage ring (DE = the
; ring top-left offset, wTransitionCountA/B); A = the new D. (C2, E-0376)
; handler 05 (entry 5 of TransitionRowStepTable) (E-0202)
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

; Entry 6 of TransitionRowStepTable, run by StripeTransition_BlankStripes for stage 6: DE += $00A0
; (5 BG map rows) and HL = the new DE, the offset of the bottom row of that stage ring (DE = the
; ring top-left offset, wTransitionCountA/B); A = the new D. (C2, E-0376)
; handler 06 (entry 6 of TransitionRowStepTable) (E-0202)
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

; Entry 7 of TransitionRowStepTable, run by StripeTransition_BlankStripes for stage 7: DE += $0060
; (3 BG map rows) and HL = the new DE, the offset of the bottom row of that stage ring (DE = the
; ring top-left offset, wTransitionCountA/B); A = the new D. (C2, E-0376)
; handler 07 (entry 7 of TransitionRowStepTable) (E-0202)
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

; Entry 8 of TransitionRowStepTable, run by StripeTransition_BlankStripes for stage 8: DE += $0020
; (1 BG map rows) and HL = the new DE, the offset of the bottom row of that stage ring (DE = the
; ring top-left offset, wTransitionCountA/B); A = the new D. (C2, E-0376)
; handler 08 (entry 8 of TransitionRowStepTable) (E-0202)
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

; Nine widths in tiles, 20, 18, 16, 14, 12, 10, 8, 6, 4, indexed by the stage wTransitionStage
; (0-8). StripeTransition_BlankStripes blanks one rectangular ring of tiles per stage, outermost
; first, with this width for the top and bottom edges (StripeTransition_BlankStripes_Data2 gives the
; height); the first ring is the whole 20 tile wide screen. (C1, E-0381)
StripeTransition_BlankStripes_Data1::
    db $14, $12, $10, $0e, $0c, $0a, $08, $06, $04

; Nine heights in tiles, 18, 16, 14, 12, 10, 8, 6, 4, 2, indexed by the stage wTransitionStage
; (0-8). StripeTransition_BlankStripes blanks the left and right edges of the ring of that stage
; with this height, in steps of one BG map row ($20); with StripeTransition_BlankStripes_Data1 the
; rings shrink by 2 tiles in each direction per stage. (C1, E-0381)
StripeTransition_BlankStripes_Data2::
    db $12, $10, $0e, $0c, $0a, $08, $06, $04, $02

; StripeTransition_BlankStripes calls JumpToWordAtHL_Bank0A with HL = $560C + 2 * wTransitionStage
; and DE = wTransitionCountA/B; each target adds a constant ($220, $1E0, $1A0, ...) to DE and
; returns it in HL; the nine targets were the INCBIN slice at $5597 (E-0202, C1)
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

; Counts one field step (bank $02 calls it after each step), unless wScriptRunning is non-zero or
; wEncounterRate & $7F is 0: wStepCounterLo/Hi += 1, wrapping from 1000 to 0. Every 100th step it
; enables SRAM and walks the 30 records at sRecords: a record in MON_STATE 1 (kept) that is not an
; egg (MON_EGG 0) gains 1 MON_WLD on the 1000th step only, up to 999; a record in any other non-zero
; state (2, in the party) loses 1 MON_WLD down to 0. SRAM is disabled again; hTemp0 is clobbered
; (bit 0 the 100-step tick, bit 1 the 1000-step tick). (C2, E-0376)
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

; Each step after the long-faces scene (EVENT_SCENE_LONG_FACES_002), outside scripts and with
; encounters on: a standing party member holding item $1B regains 1 HP, one holding item $1C regains
; 1 MP, up to the maximum. (C2, E-0357; probed E-0376)
UpdatePlayerMovement_HeldItemRegen::
    ld a, [wEncounterRate]
    and $7f
    ret z
    ld a, [wScriptRunning]
    or a
    ret nz
    ld de, EVENT_SCENE_LONG_FACES_002
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

; Return unless override bit 7 is set and wScriptRunning is zero. Otherwise decrement the
; little-endian timer modulo 65536 and test updated high-byte bit 7. If clear, return; if set,
; select talk group $0A index 0 and far-call DispatchTalkEvent. From timer 100, dispatch occurs on
; call 101 at $FFFF, not when it first reaches zero. The body does not clear the override or reset
; the timer; the resulting script restores graphics later. (C1, E-0362)
UpdatePlayerMovement_WaitPlayerSpriteOverride::
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

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 8 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 64 words, up to its first group (E-0202, C1)
; record: one screen, row by row (8 per row): its encounter group
EncounterGrid_1::
    dw EncounterGroup_Grid1_0 ; id 0
    dw EncounterGroup_Grid1_0 ; id 1
    dw EncounterGroup_Grid1_0 ; id 2
    dw EncounterGroup_Grid1_0 ; id 3
    dw EncounterGroup_Grid1_4 ; id 4
    dw EncounterGroup_Grid1_5 ; id 5
    dw EncounterGroup_Grid1_5 ; id 6
    dw EncounterGroup_Grid1_7 ; id 7
    dw EncounterGroup_Grid1_0 ; id 8
    dw EncounterGroup_Grid1_0 ; id 9
    dw EncounterGroup_Grid1_0 ; id 10
    dw EncounterGroup_Grid1_0 ; id 11
    dw EncounterGroup_Grid1_4 ; id 12
    dw EncounterGroup_Grid1_4 ; id 13
    dw EncounterGroup_Grid1_5 ; id 14
    dw EncounterGroup_Grid1_5 ; id 15
    dw EncounterGroup_Grid1_0 ; id 16
    dw EncounterGroup_Grid1_0 ; id 17
    dw EncounterGroup_Grid1_0 ; id 18
    dw EncounterGroup_Grid1_4 ; id 19
    dw EncounterGroup_Grid1_4 ; id 20
    dw EncounterGroup_Grid1_4 ; id 21
    dw EncounterGroup_Grid1_4 ; id 22
    dw EncounterGroup_Grid1_5 ; id 23
    dw EncounterGroup_Grid1_0 ; id 24
    dw EncounterGroup_Grid1_0 ; id 25
    dw EncounterGroup_Grid1_0 ; id 26
    dw EncounterGroup_Grid1_4 ; id 27
    dw EncounterGroup_Grid1_4 ; id 28
    dw EncounterGroup_Grid1_4 ; id 29
    dw EncounterGroup_Grid1_30 ; id 30
    dw EncounterGroup_Grid1_5 ; id 31
    dw EncounterGroup_Grid1_0 ; id 32
    dw EncounterGroup_Grid1_0 ; id 33
    dw EncounterGroup_Grid1_0 ; id 34
    dw EncounterGroup_Grid1_0 ; id 35
    dw EncounterGroup_Grid1_30 ; id 36
    dw EncounterGroup_Grid1_37 ; id 37
    dw EncounterGroup_Grid1_7 ; id 38
    dw EncounterGroup_Grid1_7 ; id 39
    dw EncounterGroup_Grid1_40 ; id 40
    dw EncounterGroup_Grid1_0 ; id 41
    dw EncounterGroup_Grid1_0 ; id 42
    dw EncounterGroup_Grid1_0 ; id 43
    dw EncounterGroup_Grid1_30 ; id 44
    dw EncounterGroup_Grid1_37 ; id 45
    dw EncounterGroup_Grid1_7 ; id 46
    dw EncounterGroup_Grid1_7 ; id 47
    dw EncounterGroup_Grid1_40 ; id 48
    dw EncounterGroup_Grid1_40 ; id 49
    dw EncounterGroup_Grid1_40 ; id 50
    dw EncounterGroup_Grid1_40 ; id 51
    dw EncounterGroup_Grid1_30 ; id 52
    dw EncounterGroup_Grid1_37 ; id 53
    dw EncounterGroup_Grid1_7 ; id 54
    dw EncounterGroup_Grid1_7 ; id 55
    dw EncounterGroup_Grid1_0 ; id 56
    dw EncounterGroup_Grid1_0 ; id 57
    dw EncounterGroup_Grid1_40 ; id 58
    dw EncounterGroup_Grid1_30 ; id 59
    dw EncounterGroup_Grid1_30 ; id 60
    dw EncounterGroup_Grid1_37 ; id 61
    dw EncounterGroup_Grid1_7 ; id 62
    dw EncounterGroup_Grid1_7 ; id 63

; named by an encounter grid; FillEncounterFromEntry draws three times a random 0-127 below byte 1
; and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 2 encounter word(s)
EncounterGroup_Grid1_0::
    db $01 ; entry 0: wEncounterKind + 1
    db $07, $03, $07, $00, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0002 ; MonsterTable $002: SpotSlime
    dw $0003 ; MonsterTable $003: CactiBall

; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_Grid1_4::
    db $01 ; entry 0: wEncounterKind + 1
    db $0b, $04, $08, $0b, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0002 ; MonsterTable $002: SpotSlime
    dw $0003 ; MonsterTable $003: CactiBall
    dw $0005 ; MonsterTable $005: Crestpent

EncounterGroup_Grid1_40::
    db $01 ; entry 0: wEncounterKind + 1
    db $0c, $05, $0a, $0c, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0002 ; MonsterTable $002: SpotSlime
    dw $0003 ; MonsterTable $003: CactiBall
    dw $0004 ; MonsterTable $004: TailEater

; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_Grid1_30::
    db $01 ; entry 0: wEncounterKind + 1
    db $10, $05, $0a, $0c, $10, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0002 ; MonsterTable $002: SpotSlime
    dw $0003 ; MonsterTable $003: CactiBall
    dw $0004 ; MonsterTable $004: TailEater
    dw $0005 ; MonsterTable $005: Crestpent

EncounterGroup_Grid1_5::
    db $02 ; entry 0: wEncounterKind + 1
    db $0d, $02, $04, $09, $0d, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0002 ; MonsterTable $002: SpotSlime
    dw $0003 ; MonsterTable $003: CactiBall
    dw $0005 ; MonsterTable $005: Crestpent
    dw $0006 ; MonsterTable $006: KingCobra

EncounterGroup_Grid1_37::
    db $02 ; entry 0: wEncounterKind + 1
    db $0e, $02, $04, $09, $0e, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0002 ; MonsterTable $002: SpotSlime
    dw $0003 ; MonsterTable $003: CactiBall
    dw $0005 ; MonsterTable $005: Crestpent
    dw $0004 ; MonsterTable $004: TailEater

; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_Grid1_7::
    db $02 ; entry 0: wEncounterKind + 1
    db $14, $02, $04, $09, $0e, $14 ; limit for the random 0-127, then rising slot thresholds
    dw $0002 ; MonsterTable $002: SpotSlime
    dw $0003 ; MonsterTable $003: CactiBall
    dw $0005 ; MonsterTable $005: Crestpent
    dw $0004 ; MonsterTable $004: TailEater
    dw $0006 ; MonsterTable $006: KingCobra

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 4 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 16 words, up to its first group (E-0202, C1)
; record: one screen, row by row (4 per row): its encounter group
EncounterGrid_2::
    dw EncounterGroup_Grid2_0 ; id 0
    dw EncounterGroup_Grid2_0 ; id 1
    dw EncounterGroup_Grid2_0 ; id 2
    dw EncounterGroup_Grid2_0 ; id 3
    dw EncounterGroup_Grid2_0 ; id 4
    dw EncounterGroup_Grid2_0 ; id 5
    dw EncounterGroup_Grid2_0 ; id 6
    dw EncounterGroup_Grid2_0 ; id 7
    dw EncounterGroup_Grid2_0 ; id 8
    dw EncounterGroup_Grid2_0 ; id 9
    dw EncounterGroup_Grid2_0 ; id 10
    dw EncounterGroup_Grid2_0 ; id 11
    dw EncounterGroup_Grid2_0 ; id 12
    dw EncounterGroup_Grid2_13 ; id 13
    dw EncounterGroup_Grid2_13 ; id 14
    dw EncounterGroup_Grid2_13 ; id 15

; named by an encounter grid; FillEncounterFromEntry draws three times a random 0-127 below byte 1
; and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 2 encounter word(s)
EncounterGroup_Grid2_13::
    db $02 ; entry 0: wEncounterKind + 1
    db $08, $04, $08, $00, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0180 ; MonsterTable $180: GiantWorm
    dw $0181 ; MonsterTable $181: Spooky

; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_Grid2_0::
    db $02 ; entry 0: wEncounterKind + 1
    db $0b, $03, $06, $0b, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0180 ; MonsterTable $180: GiantWorm
    dw $0181 ; MonsterTable $181: Spooky
    dw $0184 ; MonsterTable $184: MadCandle

; passed directly in DE to FillEncounterFromEntry; FillEncounterFromEntry draws three times a random
; 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below
; it in wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
EncounterGroup_Direct1::
    db $02 ; entry 0: wEncounterKind + 1
    db $0c, $05, $0a, $0c, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0180 ; MonsterTable $180: GiantWorm
    dw $0181 ; MonsterTable $181: Spooky
    dw $0186 ; MonsterTable $186: Anemon

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 8 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 64 words, up to its first group (E-0202, C1)
; record: one screen, row by row (8 per row): its encounter group
EncounterGrid_3::
    dw EncounterGroup_Grid3_0 ; id 0
    dw EncounterGroup_Grid3_1 ; id 1
    dw EncounterGroup_Grid3_1 ; id 2
    dw EncounterGroup_Grid3_3 ; id 3
    dw EncounterGroup_Grid3_4 ; id 4
    dw EncounterGroup_Grid3_5 ; id 5
    dw EncounterGroup_Grid3_5 ; id 6
    dw EncounterGroup_Grid3_7 ; id 7
    dw EncounterGroup_Grid3_0 ; id 8
    dw EncounterGroup_Grid3_1 ; id 9
    dw EncounterGroup_Grid3_3 ; id 10
    dw EncounterGroup_Grid3_4 ; id 11
    dw EncounterGroup_Grid3_5 ; id 12
    dw EncounterGroup_Grid3_5 ; id 13
    dw EncounterGroup_Grid3_5 ; id 14
    dw EncounterGroup_Grid3_0 ; id 15
    dw EncounterGroup_Grid3_0 ; id 16
    dw EncounterGroup_Grid3_1 ; id 17
    dw EncounterGroup_Grid3_3 ; id 18
    dw EncounterGroup_Grid3_19 ; id 19
    dw EncounterGroup_Grid3_3 ; id 20
    dw EncounterGroup_Grid3_21 ; id 21
    dw EncounterGroup_Grid3_21 ; id 22
    dw EncounterGroup_Grid3_0 ; id 23
    dw EncounterGroup_Grid3_24 ; id 24
    dw EncounterGroup_Grid3_19 ; id 25
    dw EncounterGroup_Grid3_19 ; id 26
    dw EncounterGroup_Grid3_27 ; id 27
    dw EncounterGroup_Grid3_24 ; id 28
    dw EncounterGroup_Grid3_29 ; id 29
    dw EncounterGroup_Grid3_29 ; id 30
    dw EncounterGroup_Grid3_0 ; id 31
    dw EncounterGroup_Grid3_24 ; id 32
    dw EncounterGroup_Grid3_24 ; id 33
    dw EncounterGroup_Grid3_34 ; id 34
    dw EncounterGroup_Grid3_35 ; id 35
    dw EncounterGroup_Grid3_0 ; id 36
    dw EncounterGroup_Grid3_29 ; id 37
    dw EncounterGroup_Grid3_29 ; id 38
    dw EncounterGroup_Grid3_0 ; id 39
    dw EncounterGroup_Grid3_19 ; id 40
    dw EncounterGroup_Grid3_19 ; id 41
    dw EncounterGroup_Grid3_42 ; id 42
    dw EncounterGroup_Grid3_43 ; id 43
    dw EncounterGroup_Grid3_44 ; id 44
    dw EncounterGroup_Grid3_0 ; id 45
    dw EncounterGroup_Grid3_0 ; id 46
    dw EncounterGroup_Grid3_0 ; id 47
    dw EncounterGroup_Grid3_48 ; id 48
    dw EncounterGroup_Grid3_48 ; id 49
    dw EncounterGroup_Grid3_50 ; id 50
    dw EncounterGroup_Grid3_44 ; id 51
    dw EncounterGroup_Grid3_44 ; id 52
    dw EncounterGroup_Grid3_44 ; id 53
    dw EncounterGroup_Grid3_0 ; id 54
    dw EncounterGroup_Grid3_0 ; id 55
    dw EncounterGroup_Grid3_0 ; id 56
    dw EncounterGroup_Grid3_0 ; id 57
    dw EncounterGroup_Grid3_50 ; id 58
    dw EncounterGroup_Grid3_50 ; id 59
    dw EncounterGroup_Grid3_44 ; id 60
    dw EncounterGroup_Grid3_44 ; id 61
    dw EncounterGroup_Grid3_0 ; id 62
    dw EncounterGroup_Grid3_0 ; id 63

; named by an encounter grid; FillEncounterFromEntry draws three times a random 0-127 below byte 1
; and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_Grid3_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $0c, $04, $08, $0c, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0009 ; MonsterTable $009: Slime
    dw $000a ; MonsterTable $00A: Antbear
    dw $000c ; MonsterTable $00C: Eggplaton

; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_Grid3_44::
    db $03 ; entry 0: wEncounterKind + 1
    db $12, $03, $07, $0b, $0f, $12 ; limit for the random 0-127, then rising slot thresholds
    dw $0009 ; MonsterTable $009: Slime
    dw $000a ; MonsterTable $00A: Antbear
    dw $000b ; MonsterTable $00B: Dracky
    dw $000c ; MonsterTable $00C: Eggplaton
    dw $0010 ; MonsterTable $010: ArmyAnt

EncounterGroup_Grid3_19::
    db $03 ; entry 0: wEncounterKind + 1
    db $12, $03, $07, $0b, $10, $12 ; limit for the random 0-127, then rising slot thresholds
    dw $0009 ; MonsterTable $009: Slime
    dw $000b ; MonsterTable $00B: Dracky
    dw $000c ; MonsterTable $00C: Eggplaton
    dw $0010 ; MonsterTable $010: ArmyAnt
    dw $0011 ; MonsterTable $011: MadGopher

EncounterGroup_Grid3_24::
    db $03 ; entry 0: wEncounterKind + 1
    db $17, $05, $0a, $0d, $12, $17 ; limit for the random 0-127, then rising slot thresholds
    dw $0277 ; MonsterTable $277: Healer
    dw $000b ; MonsterTable $00B: Dracky
    dw $000c ; MonsterTable $00C: Eggplaton
    dw $0010 ; MonsterTable $010: ArmyAnt
    dw $0011 ; MonsterTable $011: MadGopher

; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_Grid3_3::
    db $03 ; entry 0: wEncounterKind + 1
    db $0f, $03, $06, $0a, $0f, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $018b ; MonsterTable $18B: MiniDrak
    dw $000c ; MonsterTable $00C: Eggplaton
    dw $0010 ; MonsterTable $010: ArmyAnt
    dw $0011 ; MonsterTable $011: MadGopher

EncounterGroup_Grid3_4::
    db $03 ; entry 0: wEncounterKind + 1
    db $15, $05, $08, $0d, $12, $15 ; limit for the random 0-127, then rising slot thresholds
    dw $018b ; MonsterTable $18B: MiniDrak
    dw $0014 ; MonsterTable $014: Poisongon
    dw $0010 ; MonsterTable $010: ArmyAnt
    dw $0011 ; MonsterTable $011: MadGopher
    dw $0012 ; MonsterTable $012: 1EyeClown

EncounterGroup_Grid3_5::
    db $03 ; entry 0: wEncounterKind + 1
    db $10, $03, $07, $0c, $10, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0014 ; MonsterTable $014: Poisongon
    dw $0187 ; MonsterTable $187: ArrowDog
    dw $0188 ; MonsterTable $188: Pyuro
    dw $0012 ; MonsterTable $012: 1EyeClown

EncounterGroup_Grid3_7::
    db $03 ; entry 0: wEncounterKind + 1
    db $16, $05, $0a, $0c, $11, $16 ; limit for the random 0-127, then rising slot thresholds
    dw $0014 ; MonsterTable $014: Poisongon
    dw $0187 ; MonsterTable $187: ArrowDog
    dw $000f ; MonsterTable $00F: Wyvern
    dw $0188 ; MonsterTable $188: Pyuro
    dw $0012 ; MonsterTable $012: 1EyeClown

EncounterGroup_Grid3_21::
    db $03 ; entry 0: wEncounterKind + 1
    db $17, $03, $08, $0d, $12, $17 ; limit for the random 0-127, then rising slot thresholds
    dw $0013 ; MonsterTable $013: Snaily
    dw $0014 ; MonsterTable $014: Poisongon
    dw $0187 ; MonsterTable $187: ArrowDog
    dw $0188 ; MonsterTable $188: Pyuro
    dw $0012 ; MonsterTable $012: 1EyeClown

EncounterGroup_Grid3_29::
    db $03 ; entry 0: wEncounterKind + 1
    db $14, $03, $07, $0c, $0f, $14 ; limit for the random 0-127, then rising slot thresholds
    dw $018d ; MonsterTable $18D: DragonKid
    dw $0187 ; MonsterTable $187: ArrowDog
    dw $0189 ; MonsterTable $189: DanceVegi
    dw $0188 ; MonsterTable $188: Pyuro
    dw $018a ; MonsterTable $18A: Brushead

EncounterGroup_Grid3_1::
    db $03 ; entry 0: wEncounterKind + 1
    db $0e, $04, $09, $0e, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $018b ; MonsterTable $18B: MiniDrak
    dw $0189 ; MonsterTable $189: DanceVegi
    dw $018a ; MonsterTable $18A: Brushead

EncounterGroup_Grid3_48::
    db $03 ; entry 0: wEncounterKind + 1
    db $0e, $04, $09, $0e, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $018d ; MonsterTable $18D: DragonKid
    dw $018c ; MonsterTable $18C: Pteranod
    dw $018e ; MonsterTable $18E: CatFly

EncounterGroup_Grid3_50::
    db $03 ; entry 0: wEncounterKind + 1
    db $0e, $05, $0a, $0c, $0e, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0009 ; MonsterTable $009: Slime
    dw $000b ; MonsterTable $00B: Dracky
    dw $0189 ; MonsterTable $189: DanceVegi
    dw $018a ; MonsterTable $18A: Brushead

EncounterGroup_Grid3_27::
    db $03 ; entry 0: wEncounterKind + 1
    db $10, $01, $03, $04, $0a, $10 ; limit for the random 0-127, then rising slot thresholds
    dw $0277 ; MonsterTable $277: Healer
    dw $000b ; MonsterTable $00B: Dracky
    dw $000c ; MonsterTable $00C: Eggplaton
    dw $0010 ; MonsterTable $010: ArmyAnt
    dw $0011 ; MonsterTable $011: MadGopher

EncounterGroup_Grid3_34::
    db $03 ; entry 0: wEncounterKind + 1
    db $13, $02, $03, $04, $0c, $13 ; limit for the random 0-127, then rising slot thresholds
    dw $0009 ; MonsterTable $009: Slime
    dw $000b ; MonsterTable $00B: Dracky
    dw $000c ; MonsterTable $00C: Eggplaton
    dw $0010 ; MonsterTable $010: ArmyAnt
    dw $0011 ; MonsterTable $011: MadGopher

EncounterGroup_Grid3_35::
    db $03 ; entry 0: wEncounterKind + 1
    db $13, $01, $03, $04, $0b, $13 ; limit for the random 0-127, then rising slot thresholds
    dw $0009 ; MonsterTable $009: Slime
    dw $000b ; MonsterTable $00B: Dracky
    dw $000c ; MonsterTable $00C: Eggplaton
    dw $0010 ; MonsterTable $010: ArmyAnt
    dw $0011 ; MonsterTable $011: MadGopher

EncounterGroup_Grid3_42::
    db $03 ; entry 0: wEncounterKind + 1
    db $13, $01, $03, $05, $0a, $13 ; limit for the random 0-127, then rising slot thresholds
    dw $0009 ; MonsterTable $009: Slime
    dw $000b ; MonsterTable $00B: Dracky
    dw $000c ; MonsterTable $00C: Eggplaton
    dw $0010 ; MonsterTable $010: ArmyAnt
    dw $0011 ; MonsterTable $011: MadGopher

EncounterGroup_Grid3_43::
    db $03 ; entry 0: wEncounterKind + 1
    db $10, $01, $03, $05, $07, $10 ; limit for the random 0-127, then rising slot thresholds
    dw $0009 ; MonsterTable $009: Slime
    dw $000b ; MonsterTable $00B: Dracky
    dw $000c ; MonsterTable $00C: Eggplaton
    dw $0010 ; MonsterTable $010: ArmyAnt
    dw $0011 ; MonsterTable $011: MadGopher

; passed directly in DE to FillEncounterFromEntry; FillEncounterFromEntry draws three times a random
; 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below
; it in wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
EncounterGroup_Direct2::
    db $03 ; entry 0: wEncounterKind + 1
    db $12, $04, $08, $0b, $0e, $12 ; limit for the random 0-127, then rising slot thresholds
    dw $001d ; MonsterTable $01D: Petiteel
    dw $001f ; MonsterTable $01F: Merman
    dw $0018 ; MonsterTable $018: Gamanian
    dw $0020 ; MonsterTable $020: Octokid
    dw $0021 ; MonsterTable $021: RogueWave

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 4 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 16 words, up to its first group (E-0202, C1)
; record: one screen, row by row (4 per row): its encounter group
EncounterGrid_4::
    dw EncounterGroup_Grid4_0 ; id 0
    dw EncounterGroup_Grid4_0 ; id 1
    dw EncounterGroup_Grid4_0 ; id 2
    dw EncounterGroup_Grid4_0 ; id 3
    dw EncounterGroup_Grid4_0 ; id 4
    dw EncounterGroup_Grid4_0 ; id 5
    dw EncounterGroup_Grid4_0 ; id 6
    dw EncounterGroup_Grid4_0 ; id 7
    dw EncounterGroup_Grid4_0 ; id 8
    dw EncounterGroup_Grid4_0 ; id 9
    dw EncounterGroup_Grid4_0 ; id 10
    dw EncounterGroup_Grid4_0 ; id 11
    dw EncounterGroup_Grid4_0 ; id 12
    dw EncounterGroup_Grid4_0 ; id 13
    dw EncounterGroup_Grid4_0 ; id 14
    dw EncounterGroup_Grid4_0 ; id 15

; named by an encounter grid; FillEncounterFromEntry draws three times a random 0-127 below byte 1
; and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_Grid4_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $0f, $03, $05, $0a, $0f, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0022 ; MonsterTable $022: PearlGel
    dw $0015 ; MonsterTable $015: Moray
    dw $0017 ; MonsterTable $017: PutreFish
    dw $0018 ; MonsterTable $018: Gamanian

; no reference found; it follows the group before it; FillEncounterFromEntry draws three times a
; random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not
; below it in wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
EncounterGroup_1::
    db $02 ; entry 0: wEncounterKind + 1
    db $0f, $03, $05, $0a, $0f, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0022 ; MonsterTable $022: PearlGel
    dw $0015 ; MonsterTable $015: Moray
    dw $0017 ; MonsterTable $017: PutreFish
    dw $0018 ; MonsterTable $018: Gamanian

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 4 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 16 words, up to its first group (E-0202, C1)
; record: one screen, row by row (4 per row): its encounter group
EncounterGrid_5::
    dw EncounterGroup_Grid5_0 ; id 0
    dw EncounterGroup_Grid5_0 ; id 1
    dw EncounterGroup_Grid5_0 ; id 2
    dw EncounterGroup_Grid5_0 ; id 3
    dw EncounterGroup_Grid5_0 ; id 4
    dw EncounterGroup_Grid5_0 ; id 5
    dw EncounterGroup_Grid5_0 ; id 6
    dw EncounterGroup_Grid5_0 ; id 7
    dw EncounterGroup_Grid5_0 ; id 8
    dw EncounterGroup_Grid5_0 ; id 9
    dw EncounterGroup_Grid5_0 ; id 10
    dw EncounterGroup_Grid5_0 ; id 11
    dw EncounterGroup_Grid5_0 ; id 12
    dw EncounterGroup_Grid5_0 ; id 13
    dw EncounterGroup_Grid5_0 ; id 14
    dw EncounterGroup_Grid5_0 ; id 15

; named by an encounter grid; FillEncounterFromEntry draws three times a random 0-127 below byte 1
; and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_Grid5_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $0c, $04, $08, $0c, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0024 ; MonsterTable $024: AquaHawk
    dw $0025 ; MonsterTable $025: DarkEye
    dw $0027 ; MonsterTable $027: EvilWand

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 4 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 12 words, up to its first group (E-0202, C1)
EncounterGrid_6::
    dw EncounterGroup_Grid6_0 ; id 0
    dw EncounterGroup_Grid6_0 ; id 1
    dw EncounterGroup_Grid6_0 ; id 2
    dw EncounterGroup_Grid6_0 ; id 3
    dw EncounterGroup_Grid6_0 ; id 4
    dw EncounterGroup_Grid6_0 ; id 5
    dw EncounterGroup_Grid6_0 ; id 6
    dw EncounterGroup_Grid6_0 ; id 7
    dw EncounterGroup_Grid6_0 ; id 8
    dw EncounterGroup_Grid6_0 ; id 9
    dw EncounterGroup_Grid6_0 ; id 10
    dw EncounterGroup_Grid6_0 ; id 11

; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_Grid6_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $12, $03, $08, $0d, $12, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0023 ; MonsterTable $023: Tortragon
    dw $0024 ; MonsterTable $024: AquaHawk
    dw $0025 ; MonsterTable $025: DarkEye
    dw $0027 ; MonsterTable $027: EvilWand

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 3 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 9 words, up to its first group (E-0202, C1)
; record: one screen, row by row (3 per row): its encounter group
EncounterGrid_7::
    dw EncounterGroup_Grid7_0 ; id 0
    dw EncounterGroup_Grid7_0 ; id 1
    dw EncounterGroup_Grid7_0 ; id 2
    dw EncounterGroup_Grid7_0 ; id 3
    dw EncounterGroup_Grid7_0 ; id 4
    dw EncounterGroup_Grid7_0 ; id 5
    dw EncounterGroup_Grid7_0 ; id 6
    dw EncounterGroup_Grid7_0 ; id 7
    dw EncounterGroup_Grid7_0 ; id 8

; named by an encounter grid; FillEncounterFromEntry draws three times a random 0-127 below byte 1
; and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
EncounterGroup_Grid7_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $0f, $03, $05, $0a, $0f, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $018d ; MonsterTable $18D: DragonKid
    dw $0023 ; MonsterTable $023: Tortragon
    dw $0019 ; MonsterTable $019: SpikyBoy
    dw $001e ; MonsterTable $01E: RotRaven

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 2 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 4 words, up to its first group (E-0202, C1)
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_8::
    dw EncounterGroup_Grid8_0 ; id 0
    dw EncounterGroup_Grid8_0 ; id 1
    dw EncounterGroup_Grid8_0 ; id 2
    dw EncounterGroup_Grid8_0 ; id 3

; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_Grid8_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $0c, $04, $08, $0c, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0013 ; MonsterTable $013: Snaily
    dw $0026 ; MonsterTable $026: RayGigas
    dw $0016 ; MonsterTable $016: Eyeder

EncounterGrid_9::
    dw EncounterGroup_Grid9_0 ; id 0
    dw EncounterGroup_Grid9_0 ; id 1
    dw EncounterGroup_Grid9_0 ; id 2
    dw EncounterGroup_Grid9_0 ; id 3

EncounterGroup_Grid9_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $02, $06, $0a, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $000f ; MonsterTable $00F: Wyvern
    dw $0012 ; MonsterTable $012: 1EyeClown
    dw $0016 ; MonsterTable $016: Eyeder

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 3 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 3 words, up to its first group (E-0202, C1)
; record: one screen, row by row (3 per row): its encounter group
EncounterGrid_10::
    dw EncounterGroup_Grid10_0 ; id 0
    dw EncounterGroup_Grid10_0 ; id 1
    dw EncounterGroup_Grid10_0 ; id 2

; named by an encounter grid; FillEncounterFromEntry draws three times a random 0-127 below byte 1
; and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 2 encounter word(s)
EncounterGroup_Grid10_0::
    db $02 ; entry 0: wEncounterKind + 1
    db $08, $04, $08, $00, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0026 ; MonsterTable $026: RayGigas
    dw $000e ; MonsterTable $00E: Hork

; no reference found; it follows the group before it; FillEncounterFromEntry draws three times a
; random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not
; below it in wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
EncounterGroup_2::
    db $02 ; entry 0: wEncounterKind + 1
    db $08, $04, $08, $00, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0026 ; MonsterTable $026: RayGigas
    dw $000e ; MonsterTable $00E: Hork

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 3 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 3 words, up to its first group (E-0202, C1)
; record: one screen, row by row (3 per row): its encounter group
EncounterGrid_11::
    dw EncounterGroup_Grid11_0 ; id 0
    dw EncounterGroup_Grid11_0 ; id 1
    dw EncounterGroup_Grid11_0 ; id 2

; named by an encounter grid; FillEncounterFromEntry draws three times a random 0-127 below byte 1
; and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_Grid11_0::
    db $02 ; entry 0: wEncounterKind + 1
    db $0b, $04, $08, $0b, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0026 ; MonsterTable $026: RayGigas
    dw $000e ; MonsterTable $00E: Hork
    dw $000d ; MonsterTable $00D: JewelBag

EncounterGrid_12::
    dw EncounterGroup_Grid12_0 ; id 0
    dw EncounterGroup_Grid12_0 ; id 1
    dw EncounterGroup_Grid12_0 ; id 2

EncounterGroup_Grid12_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $0b, $04, $08, $0b, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0026 ; MonsterTable $026: RayGigas
    dw $000e ; MonsterTable $00E: Hork
    dw $000d ; MonsterTable $00D: JewelBag

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 12 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A *
; (hMapScreenY & $0F) + (hMapScreenX & $0F)); 144 words, up to its first group (E-0202, C1)
; record: one screen, row by row (12 per row): its encounter group
EncounterGrid_13::
    dw EncounterGroup_Grid13_0 ; id 0
    dw EncounterGroup_Grid13_0 ; id 1
    dw EncounterGroup_Grid13_0 ; id 2
    dw EncounterGroup_Grid13_0 ; id 3
    dw EncounterGroup_Grid13_4 ; id 4
    dw EncounterGroup_Grid13_4 ; id 5
    dw EncounterGroup_Grid13_0 ; id 6
    dw EncounterGroup_Grid13_0 ; id 7
    dw EncounterGroup_Grid13_0 ; id 8
    dw EncounterGroup_Grid13_0 ; id 9
    dw EncounterGroup_Grid13_0 ; id 10
    dw EncounterGroup_Grid13_0 ; id 11
    dw EncounterGroup_Grid13_0 ; id 12
    dw EncounterGroup_Grid13_0 ; id 13
    dw EncounterGroup_Grid13_0 ; id 14
    dw EncounterGroup_Grid13_0 ; id 15
    dw EncounterGroup_Grid13_4 ; id 16
    dw EncounterGroup_Grid13_4 ; id 17
    dw EncounterGroup_Grid13_4 ; id 18
    dw EncounterGroup_Grid13_4 ; id 19
    dw EncounterGroup_Grid13_0 ; id 20
    dw EncounterGroup_Grid13_0 ; id 21
    dw EncounterGroup_Grid13_0 ; id 22
    dw EncounterGroup_Grid13_0 ; id 23
    dw EncounterGroup_Grid13_0 ; id 24
    dw EncounterGroup_Grid13_0 ; id 25
    dw EncounterGroup_Grid13_0 ; id 26
    dw EncounterGroup_Grid13_0 ; id 27
    dw EncounterGroup_Grid13_4 ; id 28
    dw EncounterGroup_Grid13_4 ; id 29
    dw EncounterGroup_Grid13_4 ; id 30
    dw EncounterGroup_Grid13_31 ; id 31
    dw EncounterGroup_Grid13_31 ; id 32
    dw EncounterGroup_Grid13_31 ; id 33
    dw EncounterGroup_Grid13_31 ; id 34
    dw EncounterGroup_Grid13_0 ; id 35
    dw EncounterGroup_Grid13_0 ; id 36
    dw EncounterGroup_Grid13_0 ; id 37
    dw EncounterGroup_Grid13_0 ; id 38
    dw EncounterGroup_Grid13_0 ; id 39
    dw EncounterGroup_Grid13_0 ; id 40
    dw EncounterGroup_Grid13_41 ; id 41
    dw EncounterGroup_Grid13_41 ; id 42
    dw EncounterGroup_Grid13_41 ; id 43
    dw EncounterGroup_Grid13_44 ; id 44
    dw EncounterGroup_Grid13_31 ; id 45
    dw EncounterGroup_Grid13_31 ; id 46
    dw EncounterGroup_Grid13_31 ; id 47
    dw EncounterGroup_Grid13_0 ; id 48
    dw EncounterGroup_Grid13_0 ; id 49
    dw EncounterGroup_Grid13_0 ; id 50
    dw EncounterGroup_Grid13_0 ; id 51
    dw EncounterGroup_Grid13_0 ; id 52
    dw EncounterGroup_Grid13_41 ; id 53
    dw EncounterGroup_Grid13_41 ; id 54
    dw EncounterGroup_Grid13_41 ; id 55
    dw EncounterGroup_Grid13_44 ; id 56
    dw EncounterGroup_Grid13_57 ; id 57
    dw EncounterGroup_Grid13_31 ; id 58
    dw EncounterGroup_Grid13_31 ; id 59
    dw EncounterGroup_Grid13_0 ; id 60
    dw EncounterGroup_Grid13_0 ; id 61
    dw EncounterGroup_Grid13_0 ; id 62
    dw EncounterGroup_Grid13_0 ; id 63
    dw EncounterGroup_Grid13_64 ; id 64
    dw EncounterGroup_Grid13_41 ; id 65
    dw EncounterGroup_Grid13_41 ; id 66
    dw EncounterGroup_Grid13_41 ; id 67
    dw EncounterGroup_Grid13_57 ; id 68
    dw EncounterGroup_Grid13_57 ; id 69
    dw EncounterGroup_Grid13_31 ; id 70
    dw EncounterGroup_Grid13_31 ; id 71
    dw EncounterGroup_Grid13_0 ; id 72
    dw EncounterGroup_Grid13_64 ; id 73
    dw EncounterGroup_Grid13_64 ; id 74
    dw EncounterGroup_Grid13_64 ; id 75
    dw EncounterGroup_Grid13_64 ; id 76
    dw EncounterGroup_Grid13_64 ; id 77
    dw EncounterGroup_Grid13_64 ; id 78
    dw EncounterGroup_Grid13_0 ; id 79
    dw EncounterGroup_Grid13_0 ; id 80
    dw EncounterGroup_Grid13_81 ; id 81
    dw EncounterGroup_Grid13_81 ; id 82
    dw EncounterGroup_Grid13_81 ; id 83
    dw EncounterGroup_Grid13_0 ; id 84
    dw EncounterGroup_Grid13_85 ; id 85
    dw EncounterGroup_Grid13_85 ; id 86
    dw EncounterGroup_Grid13_85 ; id 87
    dw EncounterGroup_Grid13_64 ; id 88
    dw EncounterGroup_Grid13_64 ; id 89
    dw EncounterGroup_Grid13_64 ; id 90
    dw EncounterGroup_Grid13_0 ; id 91
    dw EncounterGroup_Grid13_92 ; id 92
    dw EncounterGroup_Grid13_81 ; id 93
    dw EncounterGroup_Grid13_81 ; id 94
    dw EncounterGroup_Grid13_0 ; id 95
    dw EncounterGroup_Grid13_0 ; id 96
    dw EncounterGroup_Grid13_0 ; id 97
    dw EncounterGroup_Grid13_85 ; id 98
    dw EncounterGroup_Grid13_85 ; id 99
    dw EncounterGroup_Grid13_85 ; id 100
    dw EncounterGroup_Grid13_0 ; id 101
    dw EncounterGroup_Grid13_0 ; id 102
    dw EncounterGroup_Grid13_103 ; id 103
    dw EncounterGroup_Grid13_104 ; id 104
    dw EncounterGroup_Grid13_104 ; id 105
    dw EncounterGroup_Grid13_104 ; id 106
    dw EncounterGroup_Grid13_0 ; id 107
    dw EncounterGroup_Grid13_0 ; id 108
    dw EncounterGroup_Grid13_85 ; id 109
    dw EncounterGroup_Grid13_85 ; id 110
    dw EncounterGroup_Grid13_85 ; id 111
    dw EncounterGroup_Grid13_103 ; id 112
    dw EncounterGroup_Grid13_103 ; id 113
    dw EncounterGroup_Grid13_103 ; id 114
    dw EncounterGroup_Grid13_103 ; id 115
    dw EncounterGroup_Grid13_104 ; id 116
    dw EncounterGroup_Grid13_104 ; id 117
    dw EncounterGroup_Grid13_104 ; id 118
    dw EncounterGroup_Grid13_104 ; id 119
PointerRun_Entry03::
    dw EncounterGroup_Grid13_85 ; id 120
    dw EncounterGroup_Entry03_121 ; id 121
    dw EncounterGroup_Grid13_85 ; id 122
    dw EncounterGroup_Grid13_85 ; id 123
    dw EncounterGroup_Grid13_103 ; id 124
    dw EncounterGroup_Grid13_103 ; id 125
    dw EncounterGroup_Grid13_103 ; id 126
    dw EncounterGroup_Grid13_0 ; id 127
    dw EncounterGroup_Grid13_104 ; id 128
    dw EncounterGroup_Grid13_104 ; id 129
    dw EncounterGroup_Grid13_104 ; id 130
    dw EncounterGroup_Grid13_104 ; id 131
    dw EncounterGroup_Grid13_85 ; id 132
    dw EncounterGroup_Grid13_85 ; id 133
    dw EncounterGroup_Grid13_85 ; id 134
    dw EncounterGroup_Grid13_0 ; id 135
    dw EncounterGroup_Grid13_0 ; id 136
    dw EncounterGroup_Grid13_0 ; id 137
    dw EncounterGroup_Grid13_0 ; id 138
    dw EncounterGroup_Grid13_0 ; id 139
    dw EncounterGroup_Grid13_0 ; id 140
    dw EncounterGroup_Grid13_104 ; id 141
    dw EncounterGroup_Grid13_104 ; id 142
    dw EncounterGroup_Grid13_104 ; id 143

; record: wEncounterKind + 1; random limit and five slot thresholds; 2 encounter word(s)
EncounterGroup_Grid13_0::
    db $01 ; entry 0: wEncounterKind + 1
    db $07, $03, $07, $00, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0002 ; MonsterTable $002: SpotSlime
    dw $0003 ; MonsterTable $003: CactiBall

; named by an encounter grid; FillEncounterFromEntry draws three times a random 0-127 below byte 1
; and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_Grid13_31::
    db $03 ; entry 0: wEncounterKind + 1
    db $0e, $04, $09, $0e, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0036 ; MonsterTable $036: Gulpple
    dw $003c ; MonsterTable $03C: WingSlime
    dw $0191 ; MonsterTable $191: BeastNite

; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_Grid13_4::
    db $03 ; entry 0: wEncounterKind + 1
    db $15, $04, $09, $0e, $11, $15 ; limit for the random 0-127, then rising slot thresholds
    dw $0038 ; MonsterTable $038: Almiraj
    dw $002b ; MonsterTable $02B: Yeti
    dw $003b ; MonsterTable $03B: Saccer
    dw $0036 ; MonsterTable $036: Gulpple
    dw $003c ; MonsterTable $03C: WingSlime

; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_Grid13_41::
    db $03 ; entry 0: wEncounterKind + 1
    db $12, $05, $09, $0d, $12, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $002a ; MonsterTable $02A: HammerMan
    dw $002b ; MonsterTable $02B: Yeti
    dw $003b ; MonsterTable $03B: Saccer
    dw $0036 ; MonsterTable $036: Gulpple

EncounterGroup_Grid13_44::
    db $03 ; entry 0: wEncounterKind + 1
    db $12, $04, $08, $0d, $12, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $002b ; MonsterTable $02B: Yeti
    dw $003b ; MonsterTable $03B: Saccer
    dw $0036 ; MonsterTable $036: Gulpple
    dw $0191 ; MonsterTable $191: BeastNite

EncounterGroup_Grid13_57::
    db $03 ; entry 0: wEncounterKind + 1
    db $0c, $02, $07, $0c, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0040 ; MonsterTable $040: SeaHorse
    dw $0036 ; MonsterTable $036: Gulpple
    dw $0191 ; MonsterTable $191: BeastNite

EncounterGroup_Grid13_64::
    db $03 ; entry 0: wEncounterKind + 1
    db $10, $04, $09, $0d, $10, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $002a ; MonsterTable $02A: HammerMan
    dw $002d ; MonsterTable $02D: Gismo
    dw $0036 ; MonsterTable $036: Gulpple
    dw $0034 ; MonsterTable $034: Grizzly

EncounterGroup_Grid13_85::
    db $03 ; entry 0: wEncounterKind + 1
    db $12, $04, $09, $0e, $12, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0028 ; MonsterTable $028: SlimeNite
    dw $002d ; MonsterTable $02D: Gismo
    dw $0034 ; MonsterTable $034: Grizzly
    dw $003e ; MonsterTable $03E: CragDevil

EncounterGroup_Entry03_121::
    db $03 ; entry 0: wEncounterKind + 1
    db $15, $03, $07, $0d, $11, $15 ; limit for the random 0-127, then rising slot thresholds
    dw $0028 ; MonsterTable $028: SlimeNite
    dw $002d ; MonsterTable $02D: Gismo
    dw $0038 ; MonsterTable $038: Almiraj
    dw $003b ; MonsterTable $03B: Saccer
    dw $003e ; MonsterTable $03E: CragDevil

EncounterGroup_Grid13_103::
    db $03 ; entry 0: wEncounterKind + 1
    db $12, $05, $0a, $0e, $12, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $002c ; MonsterTable $02C: Orc
    dw $0037 ; MonsterTable $037: FoxFire
    dw $0034 ; MonsterTable $034: Grizzly
    dw $003e ; MonsterTable $03E: CragDevil

EncounterGroup_Grid13_104::
    db $03 ; entry 0: wEncounterKind + 1
    db $15, $04, $07, $0b, $10, $15 ; limit for the random 0-127, then rising slot thresholds
    dw $0029 ; MonsterTable $029: LizardMan
    dw $0033 ; MonsterTable $033: RogueNite
    dw $0037 ; MonsterTable $037: FoxFire
    dw $0039 ; MonsterTable $039: LandOwl
    dw $0192 ; MonsterTable $192: Drygon

EncounterGroup_Grid13_81::
    db $03 ; entry 0: wEncounterKind + 1
    db $11, $03, $08, $0d, $11, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0033 ; MonsterTable $033: RogueNite
    dw $003a ; MonsterTable $03A: Goategon
    dw $003d ; MonsterTable $03D: BullBird
    dw $0192 ; MonsterTable $192: Drygon

EncounterGroup_Grid13_92::
    db $03 ; entry 0: wEncounterKind + 1
    db $15, $05, $0a, $0e, $12, $15 ; limit for the random 0-127, then rising slot thresholds
    dw $003f ; MonsterTable $03F: Starfish
    dw $0040 ; MonsterTable $040: SeaHorse
    dw $0037 ; MonsterTable $037: FoxFire
    dw $0029 ; MonsterTable $029: LizardMan
    dw $0033 ; MonsterTable $033: RogueNite

; passed directly in DE to FillEncounterFromEntry; FillEncounterFromEntry draws three times a random
; 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below
; it in wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
EncounterGroup_Direct3::
    db $03 ; entry 0: wEncounterKind + 1
    db $12, $05, $0a, $0f, $12, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0040 ; MonsterTable $040: SeaHorse
    dw $0193 ; MonsterTable $193: Pumpoise
    dw $0194 ; MonsterTable $194: FishRider
    dw $0195 ; MonsterTable $195: WalrusMan

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 4 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 16 words, up to its first group (E-0202, C1)
; record: one screen, row by row (4 per row): its encounter group
EncounterGrid_14::
    dw EncounterGroup_Grid14_0 ; id 0
    dw EncounterGroup_Grid14_0 ; id 1
    dw EncounterGroup_Grid14_0 ; id 2
    dw EncounterGroup_Grid14_0 ; id 3
    dw EncounterGroup_Grid14_0 ; id 4
    dw EncounterGroup_Grid14_0 ; id 5
    dw EncounterGroup_Grid14_0 ; id 6
    dw EncounterGroup_Grid14_0 ; id 7
    dw EncounterGroup_Grid14_0 ; id 8
    dw EncounterGroup_Grid14_0 ; id 9
    dw EncounterGroup_Grid14_0 ; id 10
    dw EncounterGroup_Grid14_0 ; id 11
    dw EncounterGroup_Grid14_0 ; id 12
    dw EncounterGroup_Grid14_0 ; id 13
    dw EncounterGroup_Grid14_0 ; id 14
    dw EncounterGroup_Grid14_0 ; id 15

; named by an encounter grid; FillEncounterFromEntry draws three times a random 0-127 below byte 1
; and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_Grid14_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $13, $04, $09, $0e, $13, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $002e ; MonsterTable $02E: Droll
    dw $002f ; MonsterTable $02F: Goopi
    dw $0030 ; MonsterTable $030: Mummy
    dw $0031 ; MonsterTable $031: TreeBoy

; passed directly in DE to FillEncounterFromEntry; FillEncounterFromEntry draws three times a random
; 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below
; it in wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
EncounterGroup_Direct4::
    db $03 ; entry 0: wEncounterKind + 1
    db $13, $04, $09, $0e, $13, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $002e ; MonsterTable $02E: Droll
    dw $002f ; MonsterTable $02F: Goopi
    dw $0030 ; MonsterTable $030: Mummy
    dw $0031 ; MonsterTable $031: TreeBoy

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 4 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 16 words, up to its first group (E-0202, C1)
; record: one screen, row by row (4 per row): its encounter group
EncounterGrid_15::
    dw EncounterGroup_Grid15_0 ; id 0
    dw EncounterGroup_Grid15_0 ; id 1
    dw EncounterGroup_Grid15_0 ; id 2
    dw EncounterGroup_Grid15_0 ; id 3
    dw EncounterGroup_Grid15_0 ; id 4
    dw EncounterGroup_Grid15_0 ; id 5
    dw EncounterGroup_Grid15_0 ; id 6
    dw EncounterGroup_Grid15_0 ; id 7
    dw EncounterGroup_Grid15_0 ; id 8
    dw EncounterGroup_Grid15_0 ; id 9
    dw EncounterGroup_Grid15_0 ; id 10
    dw EncounterGroup_Grid15_0 ; id 11
    dw EncounterGroup_Grid15_0 ; id 12
    dw EncounterGroup_Grid15_0 ; id 13
    dw EncounterGroup_Grid15_0 ; id 14
    dw EncounterGroup_Grid15_0 ; id 15

; named by an encounter grid; FillEncounterFromEntry draws three times a random 0-127 below byte 1
; and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_Grid15_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $10, $04, $08, $0c, $10, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0041 ; MonsterTable $041: ManEater
    dw $0196 ; MonsterTable $196: Stubsuck
    dw $0197 ; MonsterTable $197: Shadow
    dw $0035 ; MonsterTable $035: Demonite

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 2 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 8 words, up to its first group (E-0202, C1)
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_16::
    dw EncounterGroup_Grid16_0 ; id 0
    dw EncounterGroup_Grid16_0 ; id 1
    dw EncounterGroup_Grid16_0 ; id 2
    dw EncounterGroup_Grid16_0 ; id 3
    dw EncounterGroup_Grid16_0 ; id 4
    dw EncounterGroup_Grid16_0 ; id 5
    dw EncounterGroup_Grid16_0 ; id 6
    dw EncounterGroup_Grid16_0 ; id 7

; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_Grid16_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $0c, $04, $08, $0c, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0042 ; MonsterTable $042: StubBird
    dw $0043 ; MonsterTable $043: GiantMoth
    dw $0198 ; MonsterTable $198: WingTree

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 2 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 4 words, up to its first group (E-0202, C1)
EncounterGrid_17::
    dw EncounterGroup_Grid17_0 ; id 0
    dw EncounterGroup_Grid17_0 ; id 1
    dw EncounterGroup_Grid17_0 ; id 2
    dw EncounterGroup_Grid17_0 ; id 3

EncounterGrid_18::
    dw EncounterGroup_Grid17_0 ; id 0
    dw EncounterGroup_Grid17_0 ; id 1
    dw EncounterGroup_Grid17_0 ; id 2
    dw EncounterGroup_Grid17_0 ; id 3

EncounterGrid_19::
    dw EncounterGroup_Grid17_0 ; id 0
    dw EncounterGroup_Grid17_0 ; id 1
    dw EncounterGroup_Grid17_0 ; id 2
    dw EncounterGroup_Grid17_0 ; id 3

; named by an encounter grid; FillEncounterFromEntry draws three times a random 0-127 below byte 1
; and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
EncounterGroup_Grid17_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $0c, $04, $09, $0c, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $019e ; MonsterTable $19E: AgDevil
    dw $019f ; MonsterTable $19F: Puppetor
    dw $01a0 ; MonsterTable $1A0: Golem

EncounterGrid_20::
    dw EncounterGroup_Grid20_0 ; id 0
    dw EncounterGroup_Grid20_0 ; id 1
    dw EncounterGroup_Grid20_0 ; id 2
    dw EncounterGroup_Grid20_0 ; id 3

EncounterGrid_21::
    dw EncounterGroup_Grid20_0 ; id 0
    dw EncounterGroup_Grid20_0 ; id 1
    dw EncounterGroup_Grid20_0 ; id 2
    dw EncounterGroup_Grid20_0 ; id 3

; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_Grid20_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $0e, $01, $05, $0a, $0e, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $019d ; MonsterTable $19D: MetalDrak
    dw $019e ; MonsterTable $19E: AgDevil
    dw $019f ; MonsterTable $19F: Puppetor
    dw $01a0 ; MonsterTable $1A0: Golem

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 12 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A *
; (hMapScreenY & $0F) + (hMapScreenX & $0F)); 144 words, up to its first group (E-0202, C1)
; record: one screen, row by row (12 per row): its encounter group
EncounterGrid_22::
    dw EncounterGroup_Grid22_0 ; id 0
    dw EncounterGroup_Grid22_1 ; id 1
    dw EncounterGroup_Grid22_1 ; id 2
    dw EncounterGroup_Grid22_3 ; id 3
    dw EncounterGroup_Grid22_3 ; id 4
    dw EncounterGroup_Grid22_3 ; id 5
    dw EncounterGroup_Grid22_0 ; id 6
    dw EncounterGroup_Grid22_0 ; id 7
    dw EncounterGroup_Grid22_0 ; id 8
    dw EncounterGroup_Grid22_0 ; id 9
    dw EncounterGroup_Grid22_0 ; id 10
    dw EncounterGroup_Grid22_0 ; id 11
    dw EncounterGroup_Grid22_0 ; id 12
    dw EncounterGroup_Grid22_1 ; id 13
    dw EncounterGroup_Grid22_1 ; id 14
    dw EncounterGroup_Grid22_0 ; id 15
    dw EncounterGroup_Grid22_3 ; id 16
    dw EncounterGroup_Grid22_3 ; id 17
    dw EncounterGroup_Grid22_3 ; id 18
    dw EncounterGroup_Grid22_0 ; id 19
    dw EncounterGroup_Grid22_0 ; id 20
    dw EncounterGroup_Grid22_0 ; id 21
    dw EncounterGroup_Grid22_22 ; id 22
    dw EncounterGroup_Grid22_22 ; id 23
    dw EncounterGroup_Grid22_0 ; id 24
PointerRun_Entry04::
    dw EncounterGroup_Entry04_25 ; id 25
    dw EncounterGroup_Grid22_0 ; id 26
    dw EncounterGroup_Grid22_0 ; id 27
    dw EncounterGroup_Grid22_3 ; id 28
    dw EncounterGroup_Grid22_3 ; id 29
    dw EncounterGroup_Grid22_3 ; id 30
    dw EncounterGroup_Grid22_3 ; id 31
    dw EncounterGroup_Grid22_0 ; id 32
    dw EncounterGroup_Grid22_0 ; id 33
    dw EncounterGroup_Grid22_22 ; id 34
    dw EncounterGroup_Grid22_22 ; id 35
    dw EncounterGroup_Grid22_0 ; id 36
    dw EncounterGroup_Grid22_0 ; id 37
    dw EncounterGroup_Entry04_38 ; id 38
    dw EncounterGroup_Entry04_38 ; id 39
    dw EncounterGroup_Grid22_0 ; id 40
    dw EncounterGroup_Grid22_3 ; id 41
    dw EncounterGroup_Entry04_42 ; id 42
    dw EncounterGroup_Entry04_42 ; id 43
    dw EncounterGroup_Entry04_42 ; id 44
    dw EncounterGroup_Entry04_42 ; id 45
    dw EncounterGroup_Grid22_22 ; id 46
    dw EncounterGroup_Grid22_22 ; id 47
    dw EncounterGroup_Entry04_38 ; id 48
    dw EncounterGroup_Entry04_38 ; id 49
    dw EncounterGroup_Entry04_38 ; id 50
    dw EncounterGroup_Entry04_38 ; id 51
    dw EncounterGroup_Entry04_38 ; id 52
    dw EncounterGroup_Grid22_0 ; id 53
    dw EncounterGroup_Entry04_42 ; id 54
    dw EncounterGroup_Grid22_0 ; id 55
    dw EncounterGroup_Entry04_42 ; id 56
    dw EncounterGroup_Entry04_42 ; id 57
    dw EncounterGroup_Grid22_22 ; id 58
    dw EncounterGroup_Grid22_22 ; id 59
    dw EncounterGroup_Entry04_38 ; id 60
    dw EncounterGroup_Entry04_38 ; id 61
    dw EncounterGroup_Entry04_38 ; id 62
    dw EncounterGroup_Entry04_38 ; id 63
    dw EncounterGroup_Entry04_38 ; id 64
    dw EncounterGroup_Grid22_0 ; id 65
    dw EncounterGroup_Entry04_42 ; id 66
    dw EncounterGroup_Entry04_42 ; id 67
    dw EncounterGroup_Entry04_42 ; id 68
    dw EncounterGroup_Entry04_42 ; id 69
    dw EncounterGroup_Grid22_0 ; id 70
    dw EncounterGroup_Grid22_0 ; id 71
    dw EncounterGroup_Grid22_0 ; id 72
    dw EncounterGroup_Entry04_73 ; id 73
    dw EncounterGroup_Entry04_73 ; id 74
    dw EncounterGroup_Entry04_38 ; id 75
    dw EncounterGroup_Entry04_76 ; id 76
    dw EncounterGroup_Entry04_42 ; id 77
    dw EncounterGroup_Entry04_42 ; id 78
    dw EncounterGroup_Entry04_42 ; id 79
    dw EncounterGroup_Entry04_80 ; id 80
    dw EncounterGroup_Entry04_80 ; id 81
    dw EncounterGroup_Grid22_0 ; id 82
    dw EncounterGroup_Grid22_0 ; id 83
    dw EncounterGroup_Grid22_0 ; id 84
    dw EncounterGroup_Entry04_73 ; id 85
    dw EncounterGroup_Entry04_73 ; id 86
    dw EncounterGroup_Entry04_73 ; id 87
    dw EncounterGroup_Entry04_76 ; id 88
    dw EncounterGroup_Entry04_76 ; id 89
    dw EncounterGroup_Entry04_42 ; id 90
    dw EncounterGroup_Grid22_0 ; id 91
    dw EncounterGroup_Entry04_92 ; id 92
    dw EncounterGroup_Entry04_92 ; id 93
    dw EncounterGroup_Grid22_0 ; id 94
    dw EncounterGroup_Grid22_0 ; id 95
    dw EncounterGroup_Entry04_96 ; id 96
    dw EncounterGroup_Entry04_96 ; id 97
    dw EncounterGroup_Grid22_0 ; id 98
    dw EncounterGroup_Entry04_73 ; id 99
    dw EncounterGroup_Entry04_100 ; id 100
    dw EncounterGroup_Entry04_100 ; id 101
    dw EncounterGroup_Entry04_100 ; id 102
    dw EncounterGroup_Entry04_92 ; id 103
    dw EncounterGroup_Entry04_92 ; id 104
    dw EncounterGroup_Entry04_92 ; id 105
    dw EncounterGroup_Grid22_0 ; id 106
    dw EncounterGroup_Grid22_0 ; id 107
    dw EncounterGroup_Entry04_96 ; id 108
    dw EncounterGroup_Entry04_96 ; id 109
    dw EncounterGroup_Grid22_0 ; id 110
    dw EncounterGroup_Grid22_0 ; id 111
    dw EncounterGroup_Entry04_100 ; id 112
    dw EncounterGroup_Entry04_100 ; id 113
    dw EncounterGroup_Entry04_100 ; id 114
    dw EncounterGroup_Entry04_100 ; id 115
    dw EncounterGroup_Entry04_100 ; id 116
    dw EncounterGroup_Entry04_117 ; id 117
    dw EncounterGroup_Entry04_117 ; id 118
    dw EncounterGroup_Entry04_117 ; id 119
    dw EncounterGroup_Entry04_96 ; id 120
    dw EncounterGroup_Entry04_96 ; id 121
    dw EncounterGroup_Entry04_96 ; id 122
    dw EncounterGroup_Entry04_96 ; id 123
    dw EncounterGroup_Entry04_124 ; id 124
    dw EncounterGroup_Entry04_124 ; id 125
    dw EncounterGroup_Entry04_100 ; id 126
    dw EncounterGroup_Grid22_0 ; id 127
    dw EncounterGroup_Grid22_0 ; id 128
    dw EncounterGroup_Entry04_117 ; id 129
    dw EncounterGroup_Entry04_117 ; id 130
    dw EncounterGroup_Entry04_117 ; id 131
    dw EncounterGroup_Entry04_96 ; id 132
    dw EncounterGroup_Entry04_96 ; id 133
    dw EncounterGroup_Entry04_96 ; id 134
    dw EncounterGroup_Entry04_96 ; id 135
    dw EncounterGroup_Entry04_124 ; id 136
    dw EncounterGroup_Entry04_124 ; id 137
    dw EncounterGroup_Entry04_100 ; id 138
    dw EncounterGroup_Grid22_0 ; id 139
    dw EncounterGroup_Grid22_0 ; id 140
    dw EncounterGroup_Grid22_0 ; id 141
    dw EncounterGroup_Entry04_117 ; id 142
    dw EncounterGroup_Entry04_117 ; id 143

; record: wEncounterKind + 1; random limit and five slot thresholds; 2 encounter word(s)
EncounterGroup_Grid22_0::
    db $01 ; entry 0: wEncounterKind + 1
    db $07, $03, $07, $00, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0002 ; MonsterTable $002: SpotSlime
    dw $0003 ; MonsterTable $003: CactiBall

; named by an encounter grid; FillEncounterFromEntry draws three times a random 0-127 below byte 1
; and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_Grid22_22::
    db $03 ; entry 0: wEncounterKind + 1
    db $0c, $04, $08, $0c, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0048 ; MonsterTable $048: Emyu
    dw $0049 ; MonsterTable $049: FloraMan
    dw $0045 ; MonsterTable $045: FangSlime

; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_Entry04_42::
    db $03 ; entry 0: wEncounterKind + 1
    db $10, $04, $08, $0c, $10, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0056 ; MonsterTable $056: Dumbira
    dw $01a7 ; MonsterTable $1A7: FairyRat
    dw $004a ; MonsterTable $04A: Slurperon
    dw $0047 ; MonsterTable $047: MadRaven

; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_Entry04_80::
    db $03 ; entry 0: wEncounterKind + 1
    db $17, $05, $0a, $0f, $14, $17 ; limit for the random 0-127, then rising slot thresholds
    dw $0056 ; MonsterTable $056: Dumbira
    dw $01a7 ; MonsterTable $1A7: FairyRat
    dw $004a ; MonsterTable $04A: Slurperon
    dw $0047 ; MonsterTable $047: MadRaven
    dw $0055 ; MonsterTable $055: WildApe

EncounterGroup_Entry04_76::
    db $03 ; entry 0: wEncounterKind + 1
    db $13, $06, $0c, $12, $13, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0056 ; MonsterTable $056: Dumbira
    dw $004a ; MonsterTable $04A: Slurperon
    dw $0052 ; MonsterTable $052: WarMantis
    dw $0058 ; MonsterTable $058: Metaly

EncounterGroup_Entry04_38::
    db $03 ; entry 0: wEncounterKind + 1
    db $14, $06, $0c, $12, $14, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $005e ; MonsterTable $05E: Gigantes
    dw $01a9 ; MonsterTable $1A9: Mommonja
    dw $0052 ; MonsterTable $052: WarMantis
    dw $0058 ; MonsterTable $058: Metaly

EncounterGroup_Entry04_73::
    db $02 ; entry 0: wEncounterKind + 1
    db $10, $03, $06, $0b, $10, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $005e ; MonsterTable $05E: Gigantes
    dw $01a9 ; MonsterTable $1A9: Mommonja
    dw $01a8 ; MonsterTable $1A8: Swordgon
    dw $004d ; MonsterTable $04D: Dragon

EncounterGroup_Entry04_124::
    db $02 ; entry 0: wEncounterKind + 1
    db $13, $06, $0c, $12, $13, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01a8 ; MonsterTable $1A8: Swordgon
    dw $005c ; MonsterTable $05C: MadGoose
    dw $004d ; MonsterTable $04D: Dragon
    dw $0053 ; MonsterTable $053: Phoenix

EncounterGroup_Entry04_100::
    db $02 ; entry 0: wEncounterKind + 1
    db $14, $06, $0c, $12, $14, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01a8 ; MonsterTable $1A8: Swordgon
    dw $005c ; MonsterTable $05C: MadGoose
    dw $004d ; MonsterTable $04D: Dragon
    dw $0058 ; MonsterTable $058: Metaly

EncounterGroup_Entry04_92::
    db $03 ; entry 0: wEncounterKind + 1
    db $16, $04, $09, $0e, $13, $16 ; limit for the random 0-127, then rising slot thresholds
    dw $0055 ; MonsterTable $055: WildApe
    dw $005d ; MonsterTable $05D: Bubblemon
    dw $004d ; MonsterTable $04D: Dragon
    dw $005c ; MonsterTable $05C: MadGoose
    dw $01a8 ; MonsterTable $1A8: Swordgon

EncounterGroup_Entry04_117::
    db $03 ; entry 0: wEncounterKind + 1
    db $12, $05, $0a, $0e, $12, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01aa ; MonsterTable $1AA: KiteHawk
    dw $006f ; MonsterTable $06F: Florajay
    dw $0059 ; MonsterTable $059: GhosTree
    dw $0062 ; MonsterTable $062: MadSpirit

EncounterGroup_Entry04_96::
    db $02 ; entry 0: wEncounterKind + 1
    db $0c, $04, $08, $0c, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $006e ; MonsterTable $06E: Vampirus
    dw $004c ; MonsterTable $04C: MadDragon
    dw $0068 ; MonsterTable $068: CoilBird

EncounterGroup_Grid22_3::
    db $03 ; entry 0: wEncounterKind + 1
    db $14, $06, $09, $0e, $14, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $005b ; MonsterTable $05B: Lionex
    dw $0065 ; MonsterTable $065: Andreal
    dw $0054 ; MonsterTable $054: FireWeed
    dw $0046 ; MonsterTable $046: RockSlime

EncounterGroup_Grid22_1::
    db $03 ; entry 0: wEncounterKind + 1
    db $0f, $03, $08, $0d, $0f, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0065 ; MonsterTable $065: Andreal
    dw $0046 ; MonsterTable $046: RockSlime
    dw $0054 ; MonsterTable $054: FireWeed
    dw $0058 ; MonsterTable $058: Metaly

EncounterGroup_Entry04_25::
    db $02 ; entry 0: wEncounterKind + 1
    db $0d, $02, $03, $0a, $0d, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0058 ; MonsterTable $058: Metaly
    dw $004b ; MonsterTable $04B: Roboster
    dw $0051 ; MonsterTable $051: EvilBeast
    dw $01ad ; MonsterTable $1AD: WingSnake

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 2 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 4 words, up to its first group (E-0202, C1)
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_23::
    dw EncounterGroup_Grid23_0 ; id 0
    dw EncounterGroup_Grid23_0 ; id 1
    dw EncounterGroup_Grid23_0 ; id 2
    dw EncounterGroup_Grid23_0 ; id 3

; named by an encounter grid; FillEncounterFromEntry draws three times a random 0-127 below byte 1
; and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_Grid23_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $0c, $04, $08, $0c, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $004e ; MonsterTable $04E: IronTurt
    dw $004f ; MonsterTable $04F: MadMirror
    dw $0050 ; MonsterTable $050: SabreMan

EncounterGrid_24::
    dw EncounterGroup_Grid24_0 ; id 0
    dw EncounterGroup_Grid24_0 ; id 1
    dw EncounterGroup_Grid24_0 ; id 2
    dw EncounterGroup_Grid24_0 ; id 3

EncounterGroup_Grid24_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $0c, $04, $08, $0c, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $004e ; MonsterTable $04E: IronTurt
    dw $004f ; MonsterTable $04F: MadMirror
    dw $0050 ; MonsterTable $050: SabreMan

EncounterGrid_25::
    dw EncounterGroup_Grid25_0 ; id 0
    dw EncounterGroup_Grid25_0 ; id 1
    dw EncounterGroup_Grid25_0 ; id 2
    dw EncounterGroup_Grid25_0 ; id 3

; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_Grid25_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $16, $04, $08, $0c, $11, $16 ; limit for the random 0-127, then rising slot thresholds
    dw $004e ; MonsterTable $04E: IronTurt
    dw $004f ; MonsterTable $04F: MadMirror
    dw $0050 ; MonsterTable $050: SabreMan
    dw $0057 ; MonsterTable $057: Belzebub
    dw $0066 ; MonsterTable $066: MadKnight

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 2 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 4 words, up to its first group (E-0202, C1)
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_26::
    dw EncounterGroup_Grid26_0 ; id 0
    dw EncounterGroup_Grid26_0 ; id 1
    dw EncounterGroup_Grid26_0 ; id 2
    dw EncounterGroup_Grid26_0 ; id 3

; named by an encounter grid; FillEncounterFromEntry draws three times a random 0-127 below byte 1
; and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
EncounterGroup_Grid26_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $16, $04, $08, $0c, $11, $16 ; limit for the random 0-127, then rising slot thresholds
    dw $004e ; MonsterTable $04E: IronTurt
    dw $004f ; MonsterTable $04F: MadMirror
    dw $0050 ; MonsterTable $050: SabreMan
    dw $0051 ; MonsterTable $051: EvilBeast
    dw $0057 ; MonsterTable $057: Belzebub

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 1 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 1 words, up to its first group (E-0202, C1)
; record: one screen, row by row (1 per row): its encounter group
EncounterGrid_27::
    dw EncounterGroup_Grid27_0 ; id 0

; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_Grid27_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $14, $04, $08, $0c, $10, $14 ; limit for the random 0-127, then rising slot thresholds
    dw $01a1 ; MonsterTable $1A1: EvilSeed
    dw $01a2 ; MonsterTable $1A2: EyeBall
    dw $01a3 ; MonsterTable $1A3: Chamelgon
    dw $01a4 ; MonsterTable $1A4: FooHero
    dw $01a5 ; MonsterTable $1A5: BoxSlime

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 3 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 9 words, up to its first group (E-0202, C1)
; record: one screen, row by row (3 per row): its encounter group
EncounterGrid_28::
    dw EncounterGroup_Grid28_0 ; id 0
    dw EncounterGroup_Grid28_0 ; id 1
    dw EncounterGroup_Grid28_0 ; id 2
    dw EncounterGroup_Grid28_0 ; id 3
    dw EncounterGroup_Grid28_0 ; id 4
    dw EncounterGroup_Grid28_0 ; id 5
    dw EncounterGroup_Grid28_0 ; id 6
    dw EncounterGroup_Grid28_0 ; id 7
    dw EncounterGroup_Grid28_0 ; id 8

; named by an encounter grid; FillEncounterFromEntry draws three times a random 0-127 below byte 1
; and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
EncounterGroup_Grid28_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $14, $04, $08, $0c, $10, $14 ; limit for the random 0-127, then rising slot thresholds
    dw $01a1 ; MonsterTable $1A1: EvilSeed
    dw $01a2 ; MonsterTable $1A2: EyeBall
    dw $01a3 ; MonsterTable $1A3: Chamelgon
    dw $01a4 ; MonsterTable $1A4: FooHero
    dw $01a5 ; MonsterTable $1A5: BoxSlime

EncounterGrid_29::
    dw EncounterGroup_Grid29_0 ; id 0
    dw EncounterGroup_Grid29_0 ; id 1
    dw EncounterGroup_Grid29_0 ; id 2
    dw EncounterGroup_Grid29_0 ; id 3
    dw EncounterGroup_Grid29_0 ; id 4
    dw EncounterGroup_Grid29_0 ; id 5
    dw EncounterGroup_Grid29_0 ; id 6
    dw EncounterGroup_Grid29_0 ; id 7
    dw EncounterGroup_Grid29_0 ; id 8

EncounterGroup_Grid29_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $14, $04, $08, $0c, $10, $14 ; limit for the random 0-127, then rising slot thresholds
    dw $01a1 ; MonsterTable $1A1: EvilSeed
    dw $01a2 ; MonsterTable $1A2: EyeBall
    dw $01a3 ; MonsterTable $1A3: Chamelgon
    dw $01a4 ; MonsterTable $1A4: FooHero
    dw $01a5 ; MonsterTable $1A5: BoxSlime

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 2 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 4 words, up to its first group (E-0202, C1)
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_30::
    dw EncounterGroup_Grid30_0 ; id 0
    dw EncounterGroup_Grid30_0 ; id 1
    dw EncounterGroup_Grid30_0 ; id 2
    dw EncounterGroup_Grid30_0 ; id 3

; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_Grid30_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $0e, $05, $09, $0e, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $005f ; MonsterTable $05F: Exaucers
    dw $0068 ; MonsterTable $068: CoilBird
    dw $0069 ; MonsterTable $069: ArmorPede

EncounterGrid_31::
    dw EncounterGroup_Grid31_0 ; id 0
    dw EncounterGroup_Grid31_0 ; id 1
    dw EncounterGroup_Grid31_0 ; id 2
    dw EncounterGroup_Grid31_0 ; id 3

EncounterGroup_Grid31_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $0e, $05, $09, $0e, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $005f ; MonsterTable $05F: Exaucers
    dw $0068 ; MonsterTable $068: CoilBird
    dw $0069 ; MonsterTable $069: ArmorPede

EncounterGrid_32::
    dw EncounterGroup_Grid32_0 ; id 0
    dw EncounterGroup_Grid32_0 ; id 1
    dw EncounterGroup_Grid32_0 ; id 2
    dw EncounterGroup_Grid32_0 ; id 3

; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_Grid32_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $17, $04, $09, $0d, $12, $17 ; limit for the random 0-127, then rising slot thresholds
    dw $005f ; MonsterTable $05F: Exaucers
    dw $0067 ; MonsterTable $067: SkyDragon
    dw $0068 ; MonsterTable $068: CoilBird
    dw $0069 ; MonsterTable $069: ArmorPede
    dw $006a ; MonsterTable $06A: MadHornet

EncounterGrid_33::
    dw EncounterGroup_Grid33_0 ; id 0
    dw EncounterGroup_Grid33_0 ; id 1
    dw EncounterGroup_Grid33_0 ; id 2
    dw EncounterGroup_Grid33_0 ; id 3

; named by an encounter grid; FillEncounterFromEntry draws three times a random 0-127 below byte 1
; and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
EncounterGroup_Grid33_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $17, $04, $09, $0d, $12, $17 ; limit for the random 0-127, then rising slot thresholds
    dw $005f ; MonsterTable $05F: Exaucers
    dw $0067 ; MonsterTable $067: SkyDragon
    dw $0068 ; MonsterTable $068: CoilBird
    dw $0069 ; MonsterTable $069: ArmorPede
    dw $006a ; MonsterTable $06A: MadHornet

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 3 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 12 words, up to its first group (E-0202, C1)
; record: one screen, row by row (3 per row): its encounter group
EncounterGrid_34::
    dw EncounterGroup_Grid34_0 ; id 0
    dw EncounterGroup_Grid34_0 ; id 1
    dw EncounterGroup_Grid34_0 ; id 2
    dw EncounterGroup_Grid34_0 ; id 3
    dw EncounterGroup_Grid34_0 ; id 4
    dw EncounterGroup_Grid34_0 ; id 5
    dw EncounterGroup_Grid34_0 ; id 6
    dw EncounterGroup_Grid34_0 ; id 7
    dw EncounterGroup_Grid34_0 ; id 8
    dw EncounterGroup_Grid34_0 ; id 9
    dw EncounterGroup_Grid34_0 ; id 10
    dw EncounterGroup_Grid34_0 ; id 11

; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_Grid34_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $12, $05, $09, $0e, $12, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0059 ; MonsterTable $059: GhosTree
    dw $005a ; MonsterTable $05A: Babble
    dw $0060 ; MonsterTable $060: DeadNite
    dw $0062 ; MonsterTable $062: MadSpirit

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 3 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 9 words, up to its first group (E-0202, C1)
EncounterGrid_35::
    dw EncounterGroup_Grid35_0 ; id 0
    dw EncounterGroup_Grid35_0 ; id 1
    dw EncounterGroup_Grid35_0 ; id 2
    dw EncounterGroup_Grid35_0 ; id 3
    dw EncounterGroup_Grid35_0 ; id 4
    dw EncounterGroup_Grid35_0 ; id 5
    dw EncounterGroup_Grid35_0 ; id 6
    dw EncounterGroup_Grid35_0 ; id 7
    dw EncounterGroup_Grid35_0 ; id 8

; named by an encounter grid; FillEncounterFromEntry draws three times a random 0-127 below byte 1
; and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
EncounterGroup_Grid35_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $11, $04, $09, $0e, $11, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $005a ; MonsterTable $05A: Babble
    dw $0060 ; MonsterTable $060: DeadNite
    dw $0061 ; MonsterTable $061: GateGuard
    dw $0063 ; MonsterTable $063: Copycat

EncounterGrid_36::
    dw EncounterGroup_Grid36_0 ; id 0
    dw EncounterGroup_Grid36_0 ; id 1
    dw EncounterGroup_Grid36_0 ; id 2
    dw EncounterGroup_Grid36_0 ; id 3
    dw EncounterGroup_Grid36_0 ; id 4
    dw EncounterGroup_Grid36_0 ; id 5
    dw EncounterGroup_Grid36_0 ; id 6
    dw EncounterGroup_Grid36_0 ; id 7
    dw EncounterGroup_Grid36_0 ; id 8

EncounterGroup_Grid36_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $12, $05, $09, $0e, $12, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0057 ; MonsterTable $057: Belzebub
    dw $0059 ; MonsterTable $059: GhosTree
    dw $0060 ; MonsterTable $060: DeadNite
    dw $0062 ; MonsterTable $062: MadSpirit

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 3 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 6 words, up to its first group (E-0202, C1)
; record: one screen, row by row (3 per row): its encounter group
EncounterGrid_37::
    dw EncounterGroup_Grid37_0 ; id 0
    dw EncounterGroup_Grid37_0 ; id 1
    dw EncounterGroup_Grid37_0 ; id 2
    dw EncounterGroup_Grid37_0 ; id 3
    dw EncounterGroup_Grid37_0 ; id 4
    dw EncounterGroup_Grid37_0 ; id 5

; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_Grid37_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $11, $04, $09, $0e, $11, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $005a ; MonsterTable $05A: Babble
    dw $0060 ; MonsterTable $060: DeadNite
    dw $0061 ; MonsterTable $061: GateGuard
    dw $0063 ; MonsterTable $063: Copycat

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 4 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 16 words, up to its first group (E-0202, C1)
; record: one screen, row by row (4 per row): its encounter group
EncounterGrid_38::
    dw EncounterGroup_Grid38_0 ; id 0
    dw EncounterGroup_Grid38_0 ; id 1
    dw EncounterGroup_Grid38_2 ; id 2
    dw EncounterGroup_Grid38_2 ; id 3
    dw EncounterGroup_Grid38_0 ; id 4
    dw EncounterGroup_Grid38_0 ; id 5
    dw EncounterGroup_Grid38_0 ; id 6
    dw EncounterGroup_Grid38_2 ; id 7
    dw EncounterGroup_Grid38_0 ; id 8
    dw EncounterGroup_Grid38_0 ; id 9
    dw EncounterGroup_Grid38_0 ; id 10
    dw EncounterGroup_Grid38_2 ; id 11
    dw EncounterGroup_Grid38_2 ; id 12
    dw EncounterGroup_Grid38_2 ; id 13
    dw EncounterGroup_Grid38_2 ; id 14
    dw EncounterGroup_Grid38_2 ; id 15

; named by an encounter grid; FillEncounterFromEntry draws three times a random 0-127 below byte 1
; and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
EncounterGroup_Grid38_2::
    db $03 ; entry 0: wEncounterKind + 1
    db $0e, $04, $07, $0b, $0e, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0070 ; MonsterTable $070: BossTroll
    dw $0071 ; MonsterTable $071: ChopClown
    dw $0072 ; MonsterTable $072: MistyWing
    dw $01ae ; MonsterTable $1AE: GreatDrak

EncounterGroup_Grid38_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $0e, $04, $07, $0b, $0e, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0070 ; MonsterTable $070: BossTroll
    dw $0071 ; MonsterTable $071: ChopClown
    dw $0072 ; MonsterTable $072: MistyWing
    dw $01ae ; MonsterTable $1AE: GreatDrak

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 3 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 12 words, up to its first group (E-0202, C1)
; record: one screen, row by row (3 per row): its encounter group
EncounterGrid_39::
    dw EncounterGroup_Grid39_0 ; id 0
    dw EncounterGroup_Grid39_0 ; id 1
    dw EncounterGroup_Grid39_0 ; id 2
    dw EncounterGroup_Grid39_0 ; id 3
    dw EncounterGroup_Grid39_0 ; id 4
    dw EncounterGroup_Grid39_0 ; id 5
    dw EncounterGroup_Grid39_0 ; id 6
    dw EncounterGroup_Grid39_0 ; id 7
    dw EncounterGroup_Grid39_0 ; id 8
    dw EncounterGroup_Grid39_0 ; id 9
    dw EncounterGroup_Grid39_0 ; id 10
    dw EncounterGroup_Grid39_0 ; id 11

; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_Grid39_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $04, $08, $0a, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0070 ; MonsterTable $070: BossTroll
    dw $0071 ; MonsterTable $071: ChopClown
    dw $0265 ; MonsterTable $265: StoneMan

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 6 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 36 words, up to its first group (E-0202, C1)
; record: one screen, row by row (6 per row): its encounter group
EncounterGrid_40::
    dw EncounterGroup_Grid40_0 ; id 0
    dw EncounterGroup_Grid40_0 ; id 1
    dw EncounterGroup_Grid40_2 ; id 2
    dw EncounterGroup_Grid40_2 ; id 3
    dw EncounterGroup_Grid40_2 ; id 4
    dw EncounterGroup_Grid40_0 ; id 5
    dw EncounterGroup_Grid40_0 ; id 6
    dw EncounterGroup_Grid40_0 ; id 7
    dw EncounterGroup_Grid40_2 ; id 8
    dw EncounterGroup_Grid40_2 ; id 9
    dw EncounterGroup_Grid40_10 ; id 10
    dw EncounterGroup_Grid40_10 ; id 11
    dw EncounterGroup_Grid40_2 ; id 12
    dw EncounterGroup_Grid40_0 ; id 13
    dw EncounterGroup_Grid40_2 ; id 14
    dw EncounterGroup_Grid40_10 ; id 15
    dw EncounterGroup_Grid40_10 ; id 16
    dw EncounterGroup_Grid40_17 ; id 17
    dw EncounterGroup_Grid40_2 ; id 18
    dw EncounterGroup_Grid40_2 ; id 19
    dw EncounterGroup_Grid40_0 ; id 20
    dw EncounterGroup_Grid40_0 ; id 21
    dw EncounterGroup_Grid40_10 ; id 22
    dw EncounterGroup_Grid40_10 ; id 23
    dw EncounterGroup_Grid40_2 ; id 24
    dw EncounterGroup_Grid40_2 ; id 25
    dw EncounterGroup_Grid40_0 ; id 26
    dw EncounterGroup_Grid40_0 ; id 27
    dw EncounterGroup_Grid40_2 ; id 28
    dw EncounterGroup_Grid40_10 ; id 29
    dw EncounterGroup_Grid40_0 ; id 30
    dw EncounterGroup_Grid40_0 ; id 31
    dw EncounterGroup_Grid40_0 ; id 32
    dw EncounterGroup_Grid40_0 ; id 33
    dw EncounterGroup_Grid40_34 ; id 34
    dw EncounterGroup_Grid40_34 ; id 35

; named by an encounter grid; FillEncounterFromEntry draws three times a random 0-127 below byte 1
; and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
EncounterGroup_Grid40_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $04, $07, $0a, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01d7 ; MonsterTable $1D7: Slabbit
    dw $01d9 ; MonsterTable $1D9: FairyRat
    dw $01db ; MonsterTable $1DB: MadPlant

; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_Grid40_2::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $03, $05, $08, $0a, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01d7 ; MonsterTable $1D7: Slabbit
    dw $01d8 ; MonsterTable $1D8: MultiEyes
    dw $01d9 ; MonsterTable $1D9: FairyRat
    dw $01db ; MonsterTable $1DB: MadPlant

EncounterGroup_Grid40_10::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $03, $05, $07, $0a, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01d8 ; MonsterTable $1D8: MultiEyes
    dw $01db ; MonsterTable $1DB: MadPlant
    dw $01dd ; MonsterTable $1DD: Grendal
    dw $01de ; MonsterTable $1DE: GoHopper

; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_Grid40_17::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $03, $07, $0a, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01db ; MonsterTable $1DB: MadPlant
    dw $01dc ; MonsterTable $1DC: Snapper
    dw $01dd ; MonsterTable $1DD: Grendal

; record: wEncounterKind + 1; random limit and five slot thresholds; 2 encounter word(s)
EncounterGroup_Grid40_34::
    db $02 ; entry 0: wEncounterKind + 1
    db $0a, $04, $0a, $00, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01d8 ; MonsterTable $1D8: MultiEyes
    dw $01dd ; MonsterTable $1DD: Grendal

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 3 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 12 words, up to its first group (E-0202, C1)
; record: one screen, row by row (3 per row): its encounter group
EncounterGrid_41::
    dw EncounterGroup_Grid41_0 ; id 0
    dw EncounterGroup_Grid41_0 ; id 1
    dw EncounterGroup_Grid41_0 ; id 2
    dw EncounterGroup_Grid41_0 ; id 3
    dw EncounterGroup_Grid41_0 ; id 4
    dw EncounterGroup_Grid41_0 ; id 5
    dw EncounterGroup_Grid41_0 ; id 6
    dw EncounterGroup_Grid41_0 ; id 7
    dw EncounterGroup_Grid41_0 ; id 8
    dw EncounterGroup_Grid41_0 ; id 9
    dw EncounterGroup_Grid41_0 ; id 10
    dw EncounterGroup_Grid41_0 ; id 11

; named by an encounter grid; FillEncounterFromEntry draws three times a random 0-127 below byte 1
; and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_Grid41_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $03, $05, $07, $0a, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01dc ; MonsterTable $1DC: Snapper
    dw $01dd ; MonsterTable $1DD: Grendal
    dw $01e0 ; MonsterTable $1E0: StagBug
    dw $01e1 ; MonsterTable $1E1: FireWeed

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 3 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 6 words, up to its first group (E-0202, C1)
EncounterGrid_42::
    dw EncounterGroup_Grid42_0 ; id 0
    dw EncounterGroup_Grid42_0 ; id 1
    dw EncounterGroup_Grid42_0 ; id 2
    dw EncounterGroup_Grid42_0 ; id 3
    dw EncounterGroup_Grid42_0 ; id 4
    dw EncounterGroup_Grid42_0 ; id 5

; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_Grid42_0::
    db $02 ; entry 0: wEncounterKind + 1
    db $0a, $04, $07, $0a, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01e3 ; MonsterTable $1E3: Grizzly
    dw $01e4 ; MonsterTable $1E4: SkulRider
    dw $01e5 ; MonsterTable $1E5: WalrusMan

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 2 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 4 words, up to its first group (E-0202, C1)
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_43::
    dw EncounterGroup_Grid43_0 ; id 0
    dw EncounterGroup_Grid43_0 ; id 1
    dw EncounterGroup_Grid43_0 ; id 2
    dw EncounterGroup_Grid43_0 ; id 3

; named by an encounter grid; FillEncounterFromEntry draws three times a random 0-127 below byte 1
; and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
EncounterGroup_Grid43_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $06, $08, $0a, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01e6 ; MonsterTable $1E6: MadCandle
    dw $01e7 ; MonsterTable $1E7: Reaper
    dw $01e8 ; MonsterTable $1E8: ProtoMech

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 5 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 25 words, up to its first group (E-0202, C1)
; record: one screen, row by row (5 per row): its encounter group
EncounterGrid_44::
    dw EncounterGroup_Grid44_0 ; id 0
    dw EncounterGroup_Grid44_0 ; id 1
    dw EncounterGroup_Grid44_0 ; id 2
    dw EncounterGroup_Grid44_0 ; id 3
    dw EncounterGroup_Grid44_0 ; id 4
    dw EncounterGroup_Grid44_5 ; id 5
    dw EncounterGroup_Grid44_5 ; id 6
    dw EncounterGroup_Grid44_0 ; id 7
    dw EncounterGroup_Grid44_0 ; id 8
    dw EncounterGroup_Grid44_0 ; id 9
    dw EncounterGroup_Grid44_10 ; id 10
    dw EncounterGroup_Grid44_10 ; id 11
    dw EncounterGroup_Grid44_10 ; id 12
    dw EncounterGroup_Grid44_10 ; id 13
    dw EncounterGroup_Grid44_14 ; id 14
    dw EncounterGroup_Grid44_14 ; id 15
    dw EncounterGroup_Grid44_14 ; id 16
    dw EncounterGroup_Grid44_14 ; id 17
    dw EncounterGroup_Grid44_14 ; id 18
    dw EncounterGroup_Grid44_14 ; id 19
    dw EncounterGroup_Grid44_20 ; id 20
    dw EncounterGroup_Grid44_20 ; id 21
    dw EncounterGroup_Grid44_14 ; id 22
    dw EncounterGroup_Grid44_14 ; id 23
    dw EncounterGroup_Grid44_14 ; id 24

; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_Grid44_5::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $03, $07, $0a, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01ef ; MonsterTable $1EF: Ogre
    dw $01f2 ; MonsterTable $1F2: Lipsy
    dw $01f7 ; MonsterTable $1F7: Butterfly

; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_Grid44_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $03, $06, $08, $0a, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01ef ; MonsterTable $1EF: Ogre
    dw $01f2 ; MonsterTable $1F2: Lipsy
    dw $01f4 ; MonsterTable $1F4: Spikerous
    dw $01f7 ; MonsterTable $1F7: Butterfly

; named by an encounter grid; FillEncounterFromEntry draws three times a random 0-127 below byte 1
; and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
EncounterGroup_Grid44_10::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $03, $06, $08, $0a, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01ed ; MonsterTable $1ED: CatMage
    dw $01ee ; MonsterTable $1EE: FaceTree
    dw $01ef ; MonsterTable $1EF: Ogre
    dw $01f7 ; MonsterTable $1F7: Butterfly

EncounterGroup_Grid44_14::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $04, $07, $0a, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01ed ; MonsterTable $1ED: CatMage
    dw $01ee ; MonsterTable $1EE: FaceTree
    dw $01f7 ; MonsterTable $1F7: Butterfly

; record: wEncounterKind + 1; random limit and five slot thresholds; 2 encounter word(s)
EncounterGroup_Grid44_20::
    db $02 ; entry 0: wEncounterKind + 1
    db $0a, $06, $0a, $00, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01f1 ; MonsterTable $1F1: Anemon
    dw $01f2 ; MonsterTable $1F2: Lipsy

; passed directly in DE to FillEncounterFromEntry; FillEncounterFromEntry draws three times a random
; 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below
; it in wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_Direct5::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $04, $06, $0a, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $0216 ; MonsterTable $216: Scallopa
    dw $0217 ; MonsterTable $217: Snaily
    dw $0218 ; MonsterTable $218: Clawster

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 1 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 1 words, up to its first group (E-0202, C1)
; record: one screen, row by row (1 per row): its encounter group
EncounterGrid_45::
    dw EncounterGroup_Grid45_0 ; id 0

; named by an encounter grid; FillEncounterFromEntry draws three times a random 0-127 below byte 1
; and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_Grid45_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $02, $04, $08, $0a, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01f0 ; MonsterTable $1F0: CurseLamp
    dw $01f2 ; MonsterTable $1F2: Lipsy
    dw $01f4 ; MonsterTable $1F4: Spikerous
    dw $01f7 ; MonsterTable $1F7: Butterfly

; RunBattleIntroKindCase_RandomEncounter and CollectUniqueEncounterIdsToWorkBuf2_FindTable pass it
; in DE with A = 2 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY
; & $0F) + (hMapScreenX & $0F)); 4 words, up to its first group (E-0202, C1)
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_46::
    dw EncounterGroup_Grid46_0 ; id 0
    dw EncounterGroup_Grid46_0 ; id 1
    dw EncounterGroup_Grid46_0 ; id 2
    dw EncounterGroup_Grid46_0 ; id 3

EncounterGroup_Grid46_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $03, $05, $08, $0a, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01f0 ; MonsterTable $1F0: CurseLamp
    dw $01f4 ; MonsterTable $1F4: Spikerous
    dw $01f6 ; MonsterTable $1F6: Skulpent
    dw $01f7 ; MonsterTable $1F7: Butterfly

EncounterGrid_47::
    dw EncounterGroup_Grid47_0 ; id 0
    dw EncounterGroup_Grid47_0 ; id 1
    dw EncounterGroup_Grid47_0 ; id 2
    dw EncounterGroup_Grid47_0 ; id 3

; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_Grid47_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $04, $07, $0a, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01f0 ; MonsterTable $1F0: CurseLamp
    dw $01f5 ; MonsterTable $1F5: Skullgon
    dw $01f6 ; MonsterTable $1F6: Skulpent

EncounterGrid_48::
    dw EncounterGroup_Grid48_0 ; id 0
    dw EncounterGroup_Grid48_0 ; id 1
    dw EncounterGroup_Grid48_0 ; id 2
    dw EncounterGroup_Grid48_0 ; id 3

; named by an encounter grid; FillEncounterFromEntry draws three times a random 0-127 below byte 1
; and stores the word of the first slot whose threshold (bytes 2-6) is not below it in
; wEncounterMonsters; the record has one word per non-zero threshold (E-0202, C1)
EncounterGroup_Grid48_0::
    db $03 ; entry 0: wEncounterKind + 1
    db $0a, $03, $07, $0a, $00, $00 ; limit for the random 0-127, then rising slot thresholds
    dw $01ef ; MonsterTable $1EF: Ogre
    dw $01f5 ; MonsterTable $1F5: Skullgon
    dw $01f6 ; MonsterTable $1F6: Skulpent
    ds $48d, $00

PointerRun_Entry06::
    ds $a10, $00

PointerRun_Entry07::
    ds $707, $00

PointerRun_Entry08::
    ds $404, $00

PointerRun_Entry09::
    ds $202, $00

PointerRun_Entry0A::
    ds $82, $00
