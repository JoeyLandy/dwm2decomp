SECTION "Bank 0A", ROMX[$4000], BANK[$0A]
    db $0A

; only called from FieldModeStateDispatch_Case07 (E-0047)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case07)
; reads: wMenuState, wMenuSubState, wStatusFieldStep, wMapType
; writes: wMenuState, rRAMG, wTalkEventGroup, wTalkEventIndex, wModeState
FieldModeStateDispatch_Case07_Sub01::
Func_00A_4001:: ; address name
    call FieldModeStateDispatch_Case07_Sub01_Sub04
    ld a, [wMenuState]
    inc a
    ld [wMenuState], a
    cp a, $05
    ret nz
    ld a, $0A
    ld [rRAMG], a
    ld a, [wMenuSubState]
    or a, a
    jr nz, Jump_00A_4021
    call FieldModeStateDispatch_Case07_Sub01_Sub03
    call FieldModeStateDispatch_Case07_Sub01_Sub01
    jr Jump_00A_4027

Jump_00A_4021::
    call FieldModeStateDispatch_Case07_Sub01_Sub02
    call FieldModeStateDispatch_Case07_Sub01_Sub01

Jump_00A_4027::
    xor a, a
    ld [rRAMG], a
    ld a, [wStatusFieldStep]
    and a, $07
    jr z, Jump_00A_4042
    ld a, $04
    ld [wTalkEventGroup], a
    xor a, a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ret

Jump_00A_4042::
    ld a, [wMapType]
    bit 7, a
    jr nz, Jump_00A_404F
    ld a, $00
    ld [wModeState], a
    ret

Jump_00A_404F::
    ld a, $05
    ld [wModeState], a
    ret

; only called from FieldModeStateDispatch_Case07_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. FieldModeStateDispatch_Case07_Sub01)
; reads: wStatusStepFlags, wPartyCount, hTemp0, hTemp1
; points at: wPartyList
FieldModeStateDispatch_Case07_Sub01_Sub01::
Func_00A_4055:: ; address name
    ld a, [wStatusStepFlags]
    and a, $01
    ret z
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList

Jump_00A_4062::
    push bc
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    bit 7, a
    jr nz, Jump_00A_4095
    bit 0, a
    jr z, Jump_00A_4095
    ld a, [hl]
    ld c, $5F
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, e
    or a, d
    jr z, Jump_00A_4095
    ld a, e
    sub a, $01
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    push hl
    ld a, [hl]
    ld c, $5F
    call SRAMRecordAddress
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl], a
    pop hl

Jump_00A_4095::
    inc hl
    pop bc
    dec b
    jr nz, Jump_00A_4062
    ret

; sets bit 7 of wC8BF (E-0114)
; 2 call sites from 2 routines (e.g. FieldModeStateDispatch_Case07_Sub01_Sub03, FieldModeStateDispatch_Case07_Sub01_Sub02)
; reads: wFieldStepFlags
; writes: wFieldStepFlags
SetFieldStepFlagsBit7::
Func_00A_409B:: ; address name
    ld a, [wFieldStepFlags]
    set 7, a
    ld [wFieldStepFlags], a
    ret

; only called from FieldModeStateDispatch_Case07_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case07_Sub01)
; reads: wPartyCount, hTemp0, hTemp1, wStatusFieldStep
; writes: wStatusFieldStep
; points at: wPartyList
FieldModeStateDispatch_Case07_Sub01_Sub02::
Func_00A_40A4:: ; address name
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList

Jump_00A_40AB::
    push bc
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    bit 7, a
    jr nz, Jump_00A_410A
    bit 2, a
    jr z, Jump_00A_410A
    ld a, [hl]
    ld c, $5B
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, e
    sub a, $01
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    bit 7, a
    jr nz, Jump_00A_40D5
    or a, e
    jr nz, Jump_00A_40FE

Jump_00A_40D5::
    ld c, $01
    call SetFieldStepFlagsBit7
    ld a, [wPartyCount]
    sub a, b
    jr z, Jump_00A_40E6
    ld b, a

Jump_00A_40E1::
    sla c
    dec b
    jr nz, Jump_00A_40E1

Jump_00A_40E6::
    ld a, [wStatusFieldStep]
    or a, c
    ld [wStatusFieldStep], a
    push hl
    ld a, [hl]
    ld c, $55
    call SRAMRecordAddress
    ld a, [hl]
    and a, $F3
    or a, $80
    ld [hl], a
    pop hl
    ld de, $0000

Jump_00A_40FE::
    push hl
    ld a, [hl]
    ld c, $5B
    call SRAMRecordAddress
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl], a
    pop hl

Jump_00A_410A::
    inc hl
    pop bc
    dec b
    jr nz, Jump_00A_40AB
    ret

; only called from FieldModeStateDispatch_Case07_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case07_Sub01)
; reads: wPartyCount, hTemp0, hTemp1, wStatusFieldStep, wMapType, hMapId
; writes: wFieldStepFlags, wStatusFieldStep
; points at: wPartyList
FieldModeStateDispatch_Case07_Sub01_Sub03::
Func_00A_4110:: ; address name
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList

Jump_00A_4117::
    push bc
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    bit 7, a
    jr nz, Jump_00A_4190
    ld a, [hl]
    ld c, $5B
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, [wStatusFieldStep]
    bit 7, a
    jr nz, Jump_00A_413E
    ld c, $0A
    ld a, $40
    ld [wFieldStepFlags], a
    jr Jump_00A_414F

Jump_00A_413E::
    ld c, $02
    ld a, [wMapType]
    bit 7, a
    jr nz, Jump_00A_414F
    ldh a, [hMapId]
    cp a, $3A
    jr nz, Jump_00A_414F
    ld c, $05

Jump_00A_414F::
    ld a, e
    sub a, c
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    bit 7, a
    jr nz, Jump_00A_415D
    or a, e
    jr nz, Jump_00A_4184

Jump_00A_415D::
    ld c, $01
    call SetFieldStepFlagsBit7
    ld a, [wPartyCount]
    sub a, b
    jr z, Jump_00A_416E
    ld b, a

Jump_00A_4169::
    sla c
    dec b
    jr nz, Jump_00A_4169

Jump_00A_416E::
    ld a, [wStatusFieldStep]
    or a, c
    ld [wStatusFieldStep], a
    push hl
    ld a, [hl]
    ld c, $55
    call SRAMRecordAddress
    ld a, [hl]
    or a, $80
    ld [hl], a
    pop hl
    ld de, $0000

Jump_00A_4184::
    push hl
    ld a, [hl]
    ld c, $5B
    call SRAMRecordAddress
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl], a
    pop hl

Jump_00A_4190::
    inc hl
    pop bc
    dec b
    jr nz, Jump_00A_4117
    ret

; only called from FieldModeStateDispatch_Case07_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case07_Sub01)
; reads: wMenuState, wIsCGB
; writes: wBGPaletteUploadRequest
; points at: wDMGPaletteBGP, wBGPaletteBuffer, wBGPaletteCopy
FieldModeStateDispatch_Case07_Sub01_Sub04::
Func_00A_4196:: ; address name
    ld a, [wMenuState]
    or a, a
    jr nz, Jump_00A_41C1
    ld a, $66
    call QueueSoundEffect
    ld hl, wDMGPaletteBGP
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_00A_4213
    ld hl, wBGPaletteBuffer
    ld de, wBGPaletteCopy
    ld bc, $0040
    call CopyBytes
    jr Jump_00A_420E

Jump_00A_41C1::
    ld a, [wMenuState]
    srl a
    srl a
    and a, $01
    jr z, Jump_00A_41EC
    ld hl, wDMGPaletteBGP
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_00A_4213
    ld hl, wBGPaletteCopy
    ld de, wBGPaletteBuffer
    ld bc, $0040
    call CopyBytes
    jr Jump_00A_420E

Jump_00A_41EC::
    ld hl, wDMGPaletteBGP
    ld a, $2D
    ld [hl+], a
    ld a, $2D
    ld [hl+], a
    ld a, $1D
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_00A_4213
    ld b, $40
    ld hl, wBGPaletteCopy
    ld de, wBGPaletteBuffer

Jump_00A_4206::
    ld a, [hl+]
    xor a, $FF
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00A_4206

Jump_00A_420E::
    ld a, $7F
    ld [wBGPaletteUploadRequest], a

Jump_00A_4213::
    ret

; runs the movement routine for wC194 (jump table of eight) (E-0122)
; 2 call sites from 2 routines (e.g. UpdatePlayerMovement_Sub01, RunFieldActionRequestActionIfBit7_Case03)
; reads: wMapMoveType
RunPlayerMoveTypeMapMoveType::
Func_00A_4214:: ; address name
    ld a, [wMapMoveType]
    rst $00
    dw RunPlayerMoveTypeMapMoveType_Case00
    dw RunPlayerMoveTypeMapMoveType_Case01
    dw RunPlayerMoveTypeMapMoveType_Case02
    dw RunPlayerMoveTypeMapMoveType_Case03
    dw RunPlayerMoveTypeMapMoveType_Case04
    dw RunPlayerMoveTypeMapMoveType_Case05
    dw RunPlayerMoveTypeMapMoveType_Case06
    dw RunPlayerMoveTypeMapMoveType_Case07

; entry 0 of the `rst $00` table in RunPlayerMoveTypeMapMoveType
; no direct call (reached through a table, a jump or a vector)
RunPlayerMoveTypeMapMoveType_Case00::
Jump_00A_4228:: ; address name
    ret

; entry 6 of the `rst $00` table in RunPlayerMoveTypeMapMoveType
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wScriptRunning, wTalkCountdown, hPlayerX, hPlayerY, hTemp1, wTilesUnderPoint
; writes: hTemp1, wStatusFieldStep, wFieldStepFlags, wModeState, wMenuState, wMenuSubState
RunPlayerMoveTypeMapMoveType_Case06::
Jump_00A_4229:: ; address name
    ld a, $50
    ldh [hTemp1], a
    ld a, $80
    ld [wStatusFieldStep], a
    ld a, $40
    ld [wFieldStepFlags], a
    jr Jump_00A_427B

; entry 7 of the `rst $00` table in RunPlayerMoveTypeMapMoveType
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wScriptRunning, wTalkCountdown, hPlayerX, hPlayerY, hTemp1, wTilesUnderPoint
; writes: hTemp1, wStatusFieldStep, wModeState, wMenuState, wMenuSubState
RunPlayerMoveTypeMapMoveType_Case07::
Jump_00A_4239:: ; address name
    ld a, $52
    ldh [hTemp1], a
    xor a, a
    ld [wStatusFieldStep], a
    jr Jump_00A_427B

; entry 1 of the `rst $00` table in RunPlayerMoveTypeMapMoveType
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wScriptRunning, wTalkCountdown, hPlayerX, hPlayerY, hTemp1, wTilesUnderPoint
; writes: hTemp1, wStatusFieldStep, wModeState, wMenuState, wMenuSubState
RunPlayerMoveTypeMapMoveType_Case01::
Jump_00A_4243:: ; address name
    ld a, $44
    ldh [hTemp1], a
    xor a, a
    ld [wStatusFieldStep], a
    jr Jump_00A_427B

; entry 2 of the `rst $00` table in RunPlayerMoveTypeMapMoveType
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wScriptRunning, wTalkCountdown, hPlayerX, hPlayerY, hTemp1, wTilesUnderPoint
; writes: hTemp1, wStatusFieldStep, wModeState, wMenuState, wMenuSubState
RunPlayerMoveTypeMapMoveType_Case02::
Jump_00A_424D:: ; address name
    ld a, $56
    ldh [hTemp1], a
    xor a, a
    ld [wStatusFieldStep], a
    jr Jump_00A_427B

; entry 3 of the `rst $00` table in RunPlayerMoveTypeMapMoveType
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wScriptRunning, wTalkCountdown, hPlayerX, hPlayerY, hTemp1, wTilesUnderPoint
; writes: hTemp1, wStatusFieldStep, wModeState, wMenuState, wMenuSubState
RunPlayerMoveTypeMapMoveType_Case03::
Jump_00A_4257:: ; address name
    ld a, $44
    ldh [hTemp1], a
    xor a, a
    ld [wStatusFieldStep], a
    jr Jump_00A_427B

; entry 4 of the `rst $00` table in RunPlayerMoveTypeMapMoveType
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wScriptRunning, wTalkCountdown, hPlayerX, hPlayerY, hTemp1, wTilesUnderPoint
; writes: hTemp1, wStatusFieldStep, wFieldStepFlags, wModeState, wMenuState, wMenuSubState
RunPlayerMoveTypeMapMoveType_Case04::
Jump_00A_4261:: ; address name
    ld a, $44
    ldh [hTemp1], a
    ld a, $80
    ld [wStatusFieldStep], a
    ld a, $40
    ld [wFieldStepFlags], a
    jr Jump_00A_427B

; entry 5 of the `rst $00` table in RunPlayerMoveTypeMapMoveType
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wScriptRunning, wTalkCountdown, hPlayerX, hPlayerY, hTemp1, wTilesUnderPoint
; writes: hTemp1, wStatusFieldStep, wModeState, wMenuState, wMenuSubState
RunPlayerMoveTypeMapMoveType_Case05::
Jump_00A_4271:: ; address name
    ld a, $44
    ldh [hTemp1], a
    xor a, a
    ld [wStatusFieldStep], a
    jr Jump_00A_427B

Jump_00A_427B::
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wScriptRunning]
    or a, a
    ret nz
    ld a, [wTalkCountdown]
    or a, a
    ret nz
    ldh a, [hPlayerX]
    ld b, a
    ldh a, [hPlayerY]
    ld c, a
    call ReadTileBuffer2x2AtPixel_Bank0A
    ldh a, [hTemp1]
    ld c, a
    ld a, [wTilesUnderPoint]
    cp a, c
    jr z, Jump_00A_42AF
    ld a, [wTilesUnderPoint + $1]
    cp a, c
    jr z, Jump_00A_42AF
    ld a, [wTilesUnderPoint + $2]
    cp a, c
    jr z, Jump_00A_42AF
    ld a, [wTilesUnderPoint + $3]
    cp a, c
    jr z, Jump_00A_42AF
    ret

Jump_00A_42AF::
    ld a, $07
    ld [wModeState], a
    xor a, a
    ld [wMenuState], a
    ld [wMenuSubState], a
    ret

; in the field (story flag 2, not in mode states 1 or 7, outside listed maps): when a party member has status bit 2 or 0 of field $55, switches to mode state 7 and toggles wC88C (E-0129)
; 2 call sites from 2 routines (e.g. UpdatePlayerMovement_Sub01, RunFieldActionRequestActionIfBit7_Case03)
; reads: hPlayerStateFlags, wModeState, wMapType, hMapId, wPartyCount, wStatusStepFlags
; writes: rRAMG, wStatusStepFlags, wEncounterCountdown, wModeState, wMenuState, wMenuSubState, wStatusFieldStep
; points at: wPartyList
EnterStatusEffectFieldState::
Func_00A_42BC:: ; address name
    ldh a, [hPlayerStateFlags]
    bit 7, a
    ret nz
    bit 5, a
    ret nz
    ld de, $0002
    call TestFlagBit
    ret nc
    ld a, [wModeState]
    and a, $0F
    dec a
    ret z
    ld a, [wModeState]
    cp a, $07
    ret z
    ld a, [wMapType]
    bit 7, a
    jr nz, Jump_00A_42F1
    ldh a, [hMapId]
    cp a, $20
    ret c
    ld c, a
    ld hl, Data_00A_4374

Jump_00A_42E8::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_00A_42FD
    cp a, c
    ret z
    jr Jump_00A_42E8

Jump_00A_42F1::
    cp a, $82
    ret z
    cp a, $83
    ret z
    cp a, $84
    ret z
    cp a, $87
    ret z

Jump_00A_42FD::
    ld a, $0A
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList

Jump_00A_4309::
    push bc
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    bit 7, a
    jr nz, Jump_00A_4350
    bit 2, a
    jr nz, Jump_00A_431E
    bit 0, a
    jr nz, Jump_00A_4349
    jr Jump_00A_4350

Jump_00A_431E::
    call ToggleStatusStepFlagsLowBitOnce

Jump_00A_4321::
    pop bc
    ld a, [wModeState]
    cp a, $03
    jr nz, Jump_00A_432D
    xor a, a
    ld [wEncounterCountdown], a

Jump_00A_432D::
    ld a, $07
    ld [wModeState], a
    xor a, a
    ld [wMenuState], a
    ld a, $01
    ld [wMenuSubState], a
    xor a, a
    ld [wStatusFieldStep], a
    ld a, [wStatusStepFlags]
    and a, $7F
    ld [wStatusStepFlags], a
    jr Jump_00A_4355

Jump_00A_4349::
    call ToggleStatusStepFlagsLowBitOnce
    and a, $01
    jr nz, Jump_00A_4321

Jump_00A_4350::
    pop bc
    inc hl
    dec b
    jr nz, Jump_00A_4309

Jump_00A_4355::
    ld a, [wStatusStepFlags]
    and a, $7F
    ld [wStatusStepFlags], a
    xor a, a
    ld [rRAMG], a
    ret

; when wC88C bit 7 is clear: wC88C = ((wC88C + 1) & 1) | $80 (E-0119)
; 2 call sites from 1 routine (e.g. EnterStatusEffectFieldState)
; reads: wStatusStepFlags
; writes: wStatusStepFlags
ToggleStatusStepFlagsLowBitOnce::
Func_00A_4362:: ; address name
    ld a, [wStatusStepFlags]
    bit 7, a
    ret nz
    ld a, [wStatusStepFlags]
    inc a
    and a, $01
    or a, $80
    ld [wStatusStepFlags], a
    ret

; address loaded by EnterStatusEffectFieldState
Data_00A_4374:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $22, $23, $24, $25, $26, $29, $2A, $2B, $2D, $2E, $31, $32, $33, $34, $3C
    db $3D, $41, $45, $49, $4A, $4B, $4C, $4D, $4F
    dw Data_00A_5150
    dw $5852
    dw $5A59
    dw Data_00A_5C5B
    dw Data_00A_5E5D
    dw $605F
    dw Data_00A_6861
    dw Data_00A_7271
    dw Data_00A_7978
    dw Data_00A_7D7C
    dw Data_00A_7F7E
    db $89, $92, $9D, $A4, $A9, $AB, $AF, $B2, $B1, $B6, $B9, $BA, $BC, $C5, $D0, $D9
    db $E2, $FF

; when nothing else runs and wC901 & $7F is set, counts wD069 down; at zero sets wC916 = 30 and far-calls DispatchTalkEvent (or retries next frame if a script runs) (E-0124)
; 2 call sites from 2 routines (e.g. UpdatePlayerMovement_Sub01, RunFieldActionRequestActionIfBit7_Case03)
; reads: wFadeState, wScriptRunning, wEncounterRate, wTalkCountdown
; writes: wTalkCountdown, wTalkEventGroup, wTalkEventIndex
CountDownTalkCountdownThenDispatchTalkEvent::
Func_00A_43B5:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wScriptRunning]
    or a, a
    ret nz
    ld a, [wEncounterRate]
    and a, $7F
    ret z
    ld a, [wTalkCountdown]
    or a, a
    ret z
    dec a
    ld [wTalkCountdown], a
    or a, a
    ret nz
    ld a, [wScriptRunning]
    or a, a
    jr z, Jump_00A_43DC
    ld a, $01
    ld [wTalkCountdown], a
    ret

Jump_00A_43DC::
    ld a, $1E
    ld [wTalkEventGroup], a
    xor a, a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ret

; in the field when nothing blocks it: counts down the encounter or talk timers (wC901, wD091) and starts a battle or talk event when they expire (E-0131)
; 3 call sites from 3 routines (e.g. FieldModeStateDispatch_Case07, UpdatePlayerMovement_Sub01, RunFieldActionRequestActionIfBit7_Case03)
; reads: wFadeState, wScriptRunning, hPlayerStateFlags, wModeState, wEncounterRate, wEncounterDelay, wEncounterCountdown, wMapType, ...
; writes: wEncounterRate, wEncounterDelay, wTalkEventGroup, wTalkEventIndex, wEncounterCountdown, wBattleIntroKind, wModeState, wBattleTransitionStep, ...
TickRandomEncounterCounter::
Func_00A_43EC:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wScriptRunning]
    or a, a
    ret nz
    ldh a, [hPlayerStateFlags]
    bit 7, a
    ret nz
    bit 5, a
    ret nz
    ld a, [wModeState]
    cp a, $04
    ret z
    cp a, $01
    ret z
    ld a, [wEncounterRate]
    bit 7, a
    jr z, Jump_00A_4414
    and a, $7F
    ld [wEncounterRate], a
    ret

Jump_00A_4414::
    ld a, [wEncounterRate]
    or a, a
    ret z
    ld a, [wEncounterDelay]
    or a, a
    jr z, Jump_00A_4442
    dec a
    ld [wEncounterDelay], a
    or a, a
    ret nz
    ld a, [wModeState]
    cp a, $01
    jr nz, Jump_00A_4432
    ld a, $01
    ld [wEncounterDelay], a
    ret

Jump_00A_4432::
    ld a, $1D
    ld [wTalkEventGroup], a
    xor a, a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ret

Jump_00A_4442::
    ld a, [wEncounterRate]
    push af
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr z, Jump_00A_4451
    pop af
    ld b, $02
    jr Jump_00A_44A0

Jump_00A_4451::
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
    add a, $FE
    ld l, a
    ld a, h
    adc a, $44
    ld h, a
    ld a, [hl+]
    or a, a
    jr nz, Jump_00A_44AD
    push hl
    ldh a, [hPlayerX]
    ld b, a
    ldh a, [hPlayerY]
    ld c, a
    call ReadTileBuffer2x2AtPixel_Bank0A
    pop hl
    ld b, $02

Jump_00A_447A::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_00A_4498
    ld c, a
    ld a, [wTilesUnderPoint]
    cp a, c
    jr z, Jump_00A_44A0
    ld a, [wTilesUnderPoint + $1]
    cp a, c
    jr z, Jump_00A_44A0
    ld a, [wTilesUnderPoint + $2]
    cp a, c
    jr z, Jump_00A_44A0
    ld a, [wTilesUnderPoint + $3]
    cp a, c
    jr z, Jump_00A_44A0

Jump_00A_4498::
    inc b
    ld a, b
    cp a, $09
    jr nz, Jump_00A_447A
    ld b, $02

Jump_00A_44A0::
    ld a, b
    srl a
    ld b, a
    ld a, [wEncounterCountdown]
    sub a, b
    ld [wEncounterCountdown], a
    jr Jump_00A_44B6

Jump_00A_44AD::
    ld a, [hl]
    ld c, a
    ld a, [wEncounterCountdown]
    sub a, c
    ld [wEncounterCountdown], a

Jump_00A_44B6::
    jr c, Jump_00A_44C3
    ld a, [wEncounterCountdown]
    or a, a
    jr z, Jump_00A_44C3
    cp a, $E0
    jr nc, Jump_00A_44C3
    ret

Jump_00A_44C3::
    xor a, a
    ld [wBattleIntroKind], a
    ld a, [wMapType]
    bit 7, a
    jr z, Jump_00A_44D3
    ld a, $01
    ld [wBattleIntroKind], a

Jump_00A_44D3::
    farcall RedrawScreenBufferIfPartyWindowFlagsBit7
    ld a, $03
    ld [wModeState], a
    xor a, a
    ld [wBattleTransitionStep], a
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and a, $01
    sla a
    ld [wBattleTransitionSubStep], a
    ld a, $02
    ld [wFieldReturnPhase], a
    farcall SaveScreenBufferToBGMap1
    call PickRandomEncounterCountdownFromTable478F
    ret

; E-0202 (C1: Jump_00A_4451 reads the record at $44FE + 8 * wEncounterRate; with byte 0 = 0 it compares bytes 1-7 (until $FF) with the four tiles of wTilesUnderPoint and subtracts (2 + slot) / 2 from wEncounterCountdown, else 1; with a non-zero byte 0 it subtracts byte 1; when bit 3 of hPlayerStateFlags is set the decrement is 1; 36 records end at the code at $461E).
; record: mode (0 = by tile); then tile numbers, slot k taking (k + 2) / 2 off wEncounterCountdown when a tile under the player matches (otherwise 1), or with a non-zero mode the decrement itself
EncounterRateTable::
Data_00A_44FE:: ; address name
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; id 0
    db $00, $FF, $FF, $40, $FF, $42, $FF, $44 ; id 1
    db $01, $04, $FF, $FF, $FF, $FF, $FF, $FF ; id 2
    db $00, $FF, $FF, $40, $42, $44, $FF, $FF ; id 3
    db $01, $02, $FF, $FF, $FF, $FF, $FF, $FF ; id 4
    db $01, $03, $FF, $FF, $FF, $FF, $FF, $FF ; id 5
    db $01, $03, $FF, $FF, $FF, $FF, $FF, $FF ; id 6
    db $01, $03, $FF, $FF, $FF, $FF, $FF, $FF ; id 7
    db $01, $04, $FF, $FF, $FF, $FF, $FF, $FF ; id 8
    db $01, $01, $FF, $FF, $FF, $FF, $FF, $FF ; id 9
    db $01, $02, $FF, $FF, $FF, $FF, $FF, $FF ; id 10
    db $01, $02, $FF, $FF, $FF, $FF, $FF, $FF ; id 11
    db $01, $02, $FF, $FF, $FF, $FF, $FF, $FF ; id 12
    db $01, $02, $FF, $FF, $FF, $FF, $FF, $FF ; id 13
    db $01, $03, $FF, $FF, $FF, $FF, $FF, $FF ; id 14
    db $01, $03, $FF, $FF, $FF, $FF, $FF, $FF ; id 15
    db $00, $FF, $FF, $40, $42, $44, $FF, $FF ; id 16
    db $01, $03, $FF, $FF, $FF, $FF, $FF, $FF ; id 17
    db $01, $03, $FF, $FF, $FF, $FF, $FF, $FF ; id 18
    db $01, $03, $FF, $FF, $FF, $FF, $FF, $FF ; id 19
    db $01, $03, $FF, $FF, $FF, $FF, $FF, $FF ; id 20
    db $01, $03, $FF, $FF, $FF, $FF, $FF, $FF ; id 21
    db $00, $FF, $FF, $40, $FF, $42, $44, $FF ; id 22
    db $01, $04, $FF, $FF, $FF, $FF, $FF, $FF ; id 23
    db $00, $FF, $FF, $40, $FF, $42, $FF, $44 ; id 24
    db $01, $05, $FF, $FF, $FF, $FF, $FF, $FF ; id 25
    db $00, $FF, $FF, $40, $FF, $42, $FF, $44 ; id 26
    db $01, $05, $FF, $FF, $FF, $FF, $FF, $FF ; id 27
    db $00, $FF, $FF, $40, $FF, $42, $FF, $44 ; id 28
    db $01, $05, $FF, $FF, $FF, $FF, $FF, $FF ; id 29
    db $01, $05, $FF, $FF, $FF, $FF, $FF, $FF ; id 30
    db $01, $05, $FF, $FF, $FF, $FF, $FF, $FF ; id 31
    db $01, $05, $FF, $FF, $FF, $FF, $FF, $FF ; id 32
    db $01, $02, $FF, $FF, $FF, $FF, $FF, $FF ; id 33
    db $00, $FF, $FF, $40, $42, $44, $FF, $FF ; id 34
    db $01, $03, $FF, $FF, $FF, $FF, $FF, $FF ; id 35

; B = X pixel, C = Y pixel: HL = wScreenTileBuffer + 20 * (C / 8) + B / 8 (rows of 20 entries); copies the 2 x 2 entries there to wC910, wC911 (top row) and wC912, wC913 (bottom row); HL ends on the bottom-right entry (E-0064) (the same 63 bytes appear in 3 banks)
; 2 call sites from 2 routines (e.g. TickRandomEncounterCounter, RunPlayerMoveTypeMapMoveType_Case05)
; writes: wTilesUnderPoint
ReadTileBuffer2x2AtPixel_Bank0A::
Func_00A_461E:: ; address name
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
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    ld a, [hl+]
    ld [wTilesUnderPoint], a
    ld a, [hl-]
    ld [wTilesUnderPoint + $1], a
    ld a, $14
    add_a_to_hl
    ld a, [hl+]
    ld [wTilesUnderPoint + $2], a
    ld a, [hl]
    ld [wTilesUnderPoint + $3], a
    ret

; clears wC96C and runs the routine for wC903 & 7 (jump table of eight) (E-0122)
; 1 call site from 1 routine (e.g. RunBattleTransitionStep_Case02)
; reads: wBattleIntroKind
; writes: wBattleIntroFlag
RunBattleIntroKindCase::
Func_00A_465D:: ; address name
    xor a, a
    ld [wBattleIntroFlag], a
    ld a, [wBattleIntroKind]
    and a, $07
    rst $00
    dw RunBattleIntroKindCase_Case00
    dw RunBattleIntroKindCase_Case01
    dw RunBattleIntroKindCase_Case02
    dw RunBattleIntroKindCase_Case03
    dw RunBattleIntroKindCase_Case04
    dw RunBattleIntroKindCase_Case05
    dw RunBattleIntroKindCase_Case06
    dw RunBattleIntroKindCase_Case07

; entry 6 of the `rst $00` table in RunBattleIntroKindCase
; no direct call (reached through a table, a jump or a vector)
; reads: wPendingFieldEvent, wPartyStrength, wKeyRandomHi, hTemp0, hTemp1
; writes: hTemp0, hTemp1, wEncounterKind, wBattleKind
; points at: wEncounterMonsters
RunBattleIntroKindCase_Case06::
Jump_00A_4677:: ; address name
    ld a, [wPendingFieldEvent]
    and a, $0F
    cp a, $0C
    jr nc, Jump_00A_46D0
    farcall ComputePartyStrengthForKey
    ld a, [wPartyStrength]
    ld b, a
    ld a, $05
    call DivideBByA
    ld a, b
    add a, a
    ld de, Data_00A_46EE
    add a, e
    ld e, a
    jr nc, Jump_00A_4699
    inc d

Jump_00A_4699::
    ld a, [de]
    ldh [hTemp0], a
    inc de
    ld a, [de]
    ldh [hTemp1], a
    ld hl, wEncounterMonsters
    ld b, $03

Jump_00A_46A5::
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $0F
    cp a, $0A
    jr nc, Jump_00A_46A5
    push af
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    pop af
    add a, e
    ld e, a
    jr nc, Jump_00A_46BE
    inc d

Jump_00A_46BE::
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    dec b
    jr nz, Jump_00A_46A5

Jump_00A_46C5::
    ld a, $02
    ld [wEncounterKind], a
    ld a, $06
    ld [wBattleKind], a
    ret

Jump_00A_46D0::
    sub a, $0C
    ld c, a
    add a, a
    add a, c
    add a, a
    ld de, Data_00A_4716
    add a, e
    ld e, a
    jr nc, Jump_00A_46DE
    inc d

Jump_00A_46DE::
    ld hl, wEncounterMonsters
    ld b, $03

Jump_00A_46E3::
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_00A_46E3
    jr Jump_00A_46C5

; address loaded by RunBattleIntroKindCase_Case06
Data_00A_46EE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $AC, $00, $BC, $00, $CC, $00, $DC, $00, $EC, $00, $FC, $00, $0C, $01, $1C, $01
    db $2C, $01, $3C, $01, $1E, $02, $23, $02, $28, $02, $2D, $02, $32, $02, $37, $02
    db $3C, $02, $41, $02, $46, $02, $48, $02

; address loaded by RunBattleIntroKindCase_Case06
Data_00A_4716:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0B, $02, $0C, $02, $0D, $02, $0E, $02, $0F, $02, $0E, $02, $10, $02, $11, $02
    db $12, $02, $13, $02, $14, $02, $15, $02

; entry 5 of the `rst $00` table in RunBattleIntroKindCase
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyStrength
; writes: wEncounterMonsters, wEncounterKind, wBattleKind
RunBattleIntroKindCase_Case05::
Jump_00A_472E:: ; address name
    farcall ComputePartyStrengthLevelPartyStrength
    ld c, $76
    ld a, [wPartyStrength]
    cp a, $05
    jr c, Jump_00A_475C
    inc c
    cp a, $0A
    jr c, Jump_00A_475C
    inc c
    cp a, $0F
    jr c, Jump_00A_475C
    inc c
    cp a, $14
    jr c, Jump_00A_475C
    inc c
    cp a, $19
    jr c, Jump_00A_475C
    inc c
    cp a, $1E
    jr c, Jump_00A_475C
    inc c
    cp a, $23
    jr c, Jump_00A_475C
    inc c

Jump_00A_475C::
    ld a, c
    ld [wEncounterMonsters], a
    xor a, a
    ld [wEncounterMonsters + $1], a
    xor a, a
    ld [wEncounterKind], a
    ld a, $02
    ld [wBattleKind], a
    ret

; draws random values until wCD04 & $3F is below 100, then wC902 = 2 * Data_00A_478F[value / 5] (E-0122)
; 5 call sites from 5 routines (e.g. TickRandomEncounterCounter, RunLinkScreenSubStateSubState_60E9_Case02_Case00_Case02, StartScriptedEncounterTemp0, SetModeState3AndSaveScreen, ...)
; reads: wKeyRandomHi
; writes: wEncounterCountdown
PickRandomEncounterCountdownFromTable478F::
Func_00A_476E:: ; address name
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $3F
    cp a, $64
    jr nc, PickRandomEncounterCountdownFromTable478F
    ld b, a
    ld a, $05
    call DivideBByA
    ld a, b
    ld hl, Data_00A_478F
    add_a_to_hl
    ld a, [hl]
    add a, a
    ld [wEncounterCountdown], a
    ret

; address loaded by PickRandomEncounterCountdownFromTable478F
Data_00A_478F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0A, $14, $19, $1E, $23, $28, $2A, $2C, $2D, $2E, $30, $32, $34, $36, $38, $3A
    db $3C, $41, $46, $50, $50

; loads encounter entry $481C + 8 * hFFC6 into wCFDC-wCFE2, sets the battle intro (wC903 = 2, or 7 for entries $14, $15, $2F-$31), mode state 3 and the battle transition (E-0128)
; 14 call sites from 14 routines (e.g. ScriptCommand4A_Run_Case05, ScriptCommand66_Run_Case05, ScriptCommand48_Run_Case06, ScriptCommand41_Run_Case03, ...)
; reads: hTemp0
; writes: wEncounterKind, wEncounterMonsters, wBattleIntroKind, wModeState, wBattleTransitionStep, wBattleTransitionSubStep, wFieldReturnPhase
StartScriptedEncounterTemp0::
Func_00A_47A4:: ; address name
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
    add a, $1C
    ld l, a
    ld a, h
    adc a, $48
    ld h, a
    ld a, [hl+]
    ld [wEncounterKind], a
    inc hl
    ld a, [hl+]
    ld [wEncounterMonsters], a
    ld a, [hl+]
    ld [wEncounterMonsters + $1], a
    ld a, [hl+]
    ld [wEncounterMonsters + $2], a
    ld a, [hl+]
    ld [wEncounterMonsters + $3], a
    ld a, [hl+]
    ld [wEncounterMonsters + $4], a
    ld a, [hl]
    ld [wEncounterMonsters + $5], a
    ld a, $02
    ld [wBattleIntroKind], a
    ldh a, [hTemp0]
    cp a, $14
    jr z, Jump_00A_47F6
    cp a, $15
    jr z, Jump_00A_47F6
    cp a, $2F
    jr z, Jump_00A_47F6
    cp a, $30
    jr z, Jump_00A_47F6
    cp a, $31
    jr nz, Jump_00A_47FB

Jump_00A_47F6::
    ld a, $07
    ld [wBattleIntroKind], a

Jump_00A_47FB::
    ld a, $03
    ld [wModeState], a
    xor a, a
    ld [wBattleTransitionStep], a
    ld a, $01
    ld [wBattleTransitionSubStep], a
    ld a, $02
    ld [wFieldReturnPhase], a
    farcall SaveScreenBufferToBGMap1
    farcall PickRandomEncounterCountdownFromTable478F
    pop hl
    ret

; E-0202 (C1: StartScriptedEncounterTemp0 (14 callers, script commands among them) reads the record at $481C + 8 * hTemp0: byte 0 to wEncounterKind, bytes 2-7 to wEncounterMonsters; records $14, $15 and $2F-$31 use battle intro 7, the rest intro 2; 51 records end at RunBattleIntroKindCase_Case00 ($49B4)).
; record: wEncounterKind; unread byte; three encounter words (wEncounterMonsters)
ScriptedEncounterTable::
Data_00A_481C:: ; address name
    db $00, $00 ; id 0
    dw $0007, $0001, $0001
    db $00, $00 ; id 1
    dw $001A, $0001, $0001
    db $02, $00 ; id 2
    dw $018F, $001C, $018F
    db $00, $00 ; id 3
    dw $0032, $0001, $0001
    db $00, $00 ; id 4
    dw $0044, $0001, $0001
    db $00, $00 ; id 5
    dw $01AB, $0001, $0001
    db $00, $00 ; id 6
    dw $01A6, $0001, $0001
    db $00, $00 ; id 7
    dw $006D, $0001, $0001
    db $00, $00 ; id 8
    dw $0064, $0001, $0001
    db $01, $00 ; id 9
    dw $01DF, $01DF, $0001
    db $00, $00 ; id 10
    dw $0179, $0001, $0001
    db $00, $00 ; id 11
    dw $01E2, $0001, $0001
    db $00, $00 ; id 12
    dw $0199, $0001, $0001
    db $00, $00 ; id 13
    dw $01E9, $0001, $0001
    db $00, $00 ; id 14
    dw $01EA, $0001, $0001
    db $00, $00 ; id 15
    dw $01EB, $0001, $0001
    db $00, $00 ; id 16
    dw $01EC, $0001, $0001
    db $01, $00 ; id 17
    dw $01F8, $01F8, $0001
    db $02, $00 ; id 18
    dw $01F9, $01FA, $01FB
    db $02, $00 ; id 19
    dw $021B, $021C, $021D
    db $02, $00 ; id 20
    dw $0208, $0209, $020A
    db $02, $00 ; id 21
    dw $025F, $0260, $0261
    db $00, $00 ; id 22
    dw $0182, $0001, $0001
    db $00, $00 ; id 23
    dw $018F, $0001, $0001
    db $00, $00 ; id 24
    dw $019A, $0001, $0001
    db $02, $00 ; id 25
    dw $019B, $019C, $019B
    db $02, $00 ; id 26
    dw $02AC, $02AC, $02AC
    db $01, $00 ; id 27
    dw $006C, $006C, $0001
    db $00, $00 ; id 28
    dw $006B, $0001, $0001
    db $02, $00 ; id 29
    dw $0073, $0074, $0075
    db $00, $00 ; id 30
    dw $0190, $0001, $0001
    db $00, $00 ; id 31
    dw $0219, $0001, $0001
    db $01, $00 ; id 32
    dw $01B0, $01B1, $0001
    db $02, $00 ; id 33
    dw $01B2, $01B3, $01B4
    db $02, $00 ; id 34
    dw $01B5, $01B6, $01B7
    db $01, $00 ; id 35
    dw $01B8, $01B9, $0001
    db $02, $00 ; id 36
    dw $01BA, $01BB, $01BC
    db $01, $00 ; id 37
    dw $01BD, $01BE, $0001
    db $02, $00 ; id 38
    dw $01BF, $01C0, $01C1
    db $02, $00 ; id 39
    dw $01C2, $01C3, $01C4
    db $02, $00 ; id 40
    dw $01C5, $01C6, $01C7
    db $02, $00 ; id 41
    dw $01C8, $01C9, $01CA
    db $01, $00 ; id 42
    dw $01CB, $01CC, $0001
    db $02, $00 ; id 43
    dw $01CD, $01CE, $01CF
    db $02, $00 ; id 44
    dw $01D0, $01D1, $01D2
    db $02, $00 ; id 45
    dw $01D3, $01D4, $01D5
    db $00, $00 ; id 46
    dw $01D6, $0001, $0001
    db $02, $00 ; id 47
    dw $01FC, $01FD, $01FE
    db $02, $00 ; id 48
    dw $0205, $0206, $0207
    db $00, $00 ; id 49
    dw $0001, $0001, $0001
    db $00, $00 ; id 50
    dw $007D, $0001, $0001

; entry 0 of the `rst $00` table in RunBattleIntroKindCase
; no direct call (reached through a table, a jump or a vector)
; reads: hMapId, hPlayerStateFlags
RunBattleIntroKindCase_Case00::
Jump_00A_49B4:: ; address name
    ldh a, [hMapId]
    cp a, $20
    jp z, Jump_00A_4ACF
    cp a, $2B
    jp z, Jump_00A_4AD8
    cp a, $30
    jp z, Jump_00A_4AEE
    cp a, $35
    jp z, Jump_00A_4B04
    cp a, $38
    jp z, Jump_00A_4B0D
    cp a, $39
    jp z, Jump_00A_4B16
    cp a, $3A
    jp z, Jump_00A_4B1F
    cp a, $3E
    jp z, Jump_00A_4B28
    cp a, $3F
    jp z, Jump_00A_4B31
    cp a, $37
    jp z, Jump_00A_4B3A
    cp a, $42
    jp z, Jump_00A_4B43
    cp a, $43
    jp z, Jump_00A_4B4C
    cp a, $48
    jp z, Jump_00A_4B55
    cp a, $53
    jp z, Jump_00A_4B6B
    cp a, $54
    jp z, Jump_00A_4B74
    cp a, $55
    jp z, Jump_00A_4B74
    cp a, $56
    jp z, Jump_00A_4B74
    cp a, $5D
    jp z, Jump_00A_4B7B
    cp a, $62
    jp z, Jump_00A_4B84
    cp a, $63
    jp z, Jump_00A_4B8D
    cp a, $64
    jp z, Jump_00A_4B96
    cp a, $65
    jp z, Jump_00A_4B9F
    cp a, $66
    jp z, Jump_00A_4BA8
    cp a, $67
    jp z, Jump_00A_4BB1
    cp a, $70
    jp z, Jump_00A_4BBA
    cp a, $73
    jp z, Jump_00A_4BC3
    cp a, $74
    jp z, Jump_00A_4BCC
    cp a, $75
    jp z, Jump_00A_4BD5
    cp a, $76
    jp z, Jump_00A_4BDE
    cp a, $81
    jp z, Jump_00A_4BE7
    cp a, $82
    jp z, Jump_00A_4BF0
    cp a, $83
    jp z, Jump_00A_4BF9
    cp a, $85
    jp z, Jump_00A_4C02
    cp a, $86
    jp z, Jump_00A_4C0B
    cp a, $87
    jp z, Jump_00A_4C14
    cp a, $88
    jp z, Jump_00A_4C1D
    cp a, $8B
    jp z, Jump_00A_4C26
    cp a, $8C
    jp z, Jump_00A_4C2F
    cp a, $8E
    jp z, Jump_00A_4C38
    cp a, $90
    jp z, Jump_00A_4C41
    cp a, $A0
    jp z, Jump_00A_4C4A
    cp a, $A2
    jp z, Jump_00A_4C53
    cp a, $A8
    jp z, Jump_00A_4C5C
    cp a, $AD
    jp z, Jump_00A_4C65
    cp a, $AE
    jp z, Jump_00A_4C65
    cp a, $B0
    jp z, Jump_00A_4C6E
    cp a, $B3
    jp z, Jump_00A_4C77
    cp a, $B4
    jp z, Jump_00A_4C77
    cp a, $B5
    jp z, Jump_00A_4C77
    cp a, $B8
    jp z, Jump_00A_4C80
    cp a, $BE
    jp z, Jump_00A_4C96
    cp a, $BF
    jp z, Jump_00A_4C9F
    cp a, $C0
    jp z, Jump_00A_4CA8
    cp a, $C1
    jp z, Jump_00A_4CA8
    cp a, $C2
    jp z, Jump_00A_4CB1
    cp a, $C3
    jp z, Jump_00A_4CB1
    ret

Jump_00A_4ACF::
    ld de, EncounterGrid_5773
    ld a, $08
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4AD8::
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, Jump_00A_4AE7
    ld de, EncounterGrid_5856
    ld a, $04
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4AE7::
    ld de, EncounterGroup_588E
    call RunBattleIntroKindCase_Case00_Sub01
    ret

Jump_00A_4AEE::
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, Jump_00A_4AFD
    ld de, EncounterGrid_589B
    ld a, $08
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4AFD::
    ld de, EncounterGroup_5A3B
    call RunBattleIntroKindCase_Case00_Sub01
    ret

Jump_00A_4B04::
    ld de, EncounterGrid_5A4C
    ld a, $04
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4B0D::
    ld de, EncounterGrid_5A8A
    ld a, $04
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4B16::
    ld de, EncounterGrid_5AB7
    ld a, $04
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4B1F::
    ld de, EncounterGrid_5ADE
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4B28::
    ld de, EncounterGrid_5AFF
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4B31::
    ld de, EncounterGrid_5B14
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4B3A::
    ld de, EncounterGrid_5B29
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4B43::
    ld de, EncounterGrid_5B45
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4B4C::
    ld de, EncounterGrid_5B58
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4B55::
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, Jump_00A_4B64
    ld de, EncounterGrid_5B6B
    ld a, $0C
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4B64::
    ld de, EncounterGroup_5D4E
    call RunBattleIntroKindCase_Case00_Sub01
    ret

Jump_00A_4B6B::
    ld de, EncounterGrid_5D5D
    ld a, $04
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4B74::
    ld de, EncounterGroup_5D8C
    call RunBattleIntroKindCase_Case00_Sub01
    ret

Jump_00A_4B7B::
    ld de, EncounterGrid_5D9B
    ld a, $04
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4B84::
    ld de, EncounterGrid_5DCA
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4B8D::
    ld de, EncounterGrid_5DE7
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4B96::
    ld de, EncounterGrid_5DEF
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4B9F::
    ld de, EncounterGrid_5DF7
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4BA8::
    ld de, EncounterGrid_5E0C
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4BB1::
    ld de, EncounterGrid_5E14
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4BBA::
    ld de, EncounterGrid_5E2B
    ld a, $0C
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4BC3::
    ld de, EncounterGrid_6028
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4BCC::
    ld de, EncounterGrid_603D
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4BD5::
    ld de, EncounterGrid_6052
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4BDE::
    ld de, EncounterGrid_606B
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4BE7::
    ld de, EncounterGrid_6084
    ld a, $01
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4BF0::
    ld de, EncounterGrid_6097
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4BF9::
    ld de, EncounterGrid_60BA
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4C02::
    ld de, EncounterGrid_60DD
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4C0B::
    ld de, EncounterGrid_60F2
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4C14::
    ld de, EncounterGrid_6107
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4C1D::
    ld de, EncounterGrid_6120
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4C26::
    ld de, EncounterGrid_6139
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4C2F::
    ld de, EncounterGrid_6160
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4C38::
    ld de, EncounterGrid_6181
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4C41::
    ld de, EncounterGrid_61A2
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4C4A::
    ld de, EncounterGrid_61BD
    ld a, $04
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4C53::
    ld de, EncounterGrid_61FB
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4C5C::
    ld de, EncounterGrid_6220
    ld a, $06
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4C65::
    ld de, EncounterGrid_62AB
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4C6E::
    ld de, EncounterGrid_62D2
    ld a, $03
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4C77::
    ld de, EncounterGrid_62EB
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4C80::
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, Jump_00A_4C8F
    ld de, EncounterGrid_6300
    ld a, $05
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4C8F::
    ld de, EncounterGroup_6375
    call RunBattleIntroKindCase_Case00_Sub01
    ret

Jump_00A_4C96::
    ld de, EncounterGrid_6382
    ld a, $01
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4C9F::
    ld de, EncounterGrid_6393
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4CA8::
    ld de, EncounterGrid_63AA
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

Jump_00A_4CB1::
    ld de, EncounterGrid_63BF
    ld a, $02
    call ReadMapCellWordForScreenXY
    ret

; DE = the word at DE + 2 * A * (hMapScreenY & $0F) + 2 * (hMapScreenX & $0F); falls through (E-0122)
; 48 call sites from 1 routine (e.g. RunBattleIntroKindCase_Case00)
; reads: hMapScreenY, hMapScreenX, wRandomLo, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, ...
; writes: wEncounterKind, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, hTemp5, wBattleKind
; points at: wEncounterMonsters
ReadMapCellWordForScreenXY::
Func_00A_4CBA:: ; address name
    sla a
    ld c, a
    ldh a, [hMapScreenY]
    and a, $0F
    call Multiply8
    ldh a, [hMapScreenX]
    and a, $0F
    sla a
    add_a_to_hl
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a

; only called from RunBattleIntroKindCase_Case00 (E-0047)
; 5 call sites from 1 routine (e.g. RunBattleIntroKindCase_Case00)
; reads: wRandomLo, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, hTemp5, wEncounterKind
; writes: wEncounterKind, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, hTemp5, wBattleKind
; points at: wEncounterMonsters
RunBattleIntroKindCase_Case00_Sub01::
Func_00A_4CD4:: ; address name
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

Jump_00A_4CF7::
    call NextTableByte
    ld a, [wRandomLo]
    and a, $7F
    ld c, a
    ldh a, [hTemp0]
    cp a, c
    jr c, Jump_00A_4CF7
    push hl
    push de
    ldh a, [hTemp1]
    cp a, c
    jr nc, Jump_00A_4D31
    inc de
    inc de
    ldh a, [hTemp2]
    cp a, c
    jr nc, Jump_00A_4D31
    inc de
    inc de
    ldh a, [hTemp3]
    cp a, c
    jr nc, Jump_00A_4D31
    inc de
    inc de
    ldh a, [hTemp4]
    cp a, c
    jr nc, Jump_00A_4D31
    inc de
    inc de
    ldh a, [hTemp5]
    cp a, c
    jr nc, Jump_00A_4D31

Jump_00A_4D28::
    pop de
    pop hl
    inc hl
    inc hl
    dec b
    jr nz, Jump_00A_4CF7
    jr Jump_00A_4D38

Jump_00A_4D31::
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    ld [hl], a
    jr Jump_00A_4D28

Jump_00A_4D38::
    xor a, a
    ld [wBattleKind], a
    ld a, [wEncounterKind]
    or a, a
    ret z
    dec a
    jr nz, Jump_00A_4D49
    ld hl, Data_00A_5150
    jr Jump_00A_4D4C

Jump_00A_4D49::
    ld hl, Data_00A_514C

Jump_00A_4D4C::
    call NextTableByte
    ld a, [wRandomLo]
    and a, $03
    add_a_to_hl
    ld a, [hl]
    ld [wEncounterKind], a
    ret

; only called from CollectUniqueEncounterIdsToWD09F (E-0047)
; 1 call site from 1 routine (e.g. CollectUniqueEncounterIdsToWD09F)
; reads: hMapId, hPlayerStateFlags
CollectUniqueEncounterIdsToWD09F_Sub01::
Func_00A_4D5E:: ; address name
    ldh a, [hMapId]
    cp a, $20
    jp z, Jump_00A_4E79
    cp a, $2B
    jp z, Jump_00A_4E82
    cp a, $30
    jp z, Jump_00A_4E98
    cp a, $35
    jp z, Jump_00A_4EAE
    cp a, $38
    jp z, Jump_00A_4EB7
    cp a, $39
    jp z, Jump_00A_4EC0
    cp a, $3A
    jp z, Jump_00A_4EC9
    cp a, $3E
    jp z, Jump_00A_4ED2
    cp a, $3F
    jp z, Jump_00A_4EDB
    cp a, $37
    jp z, Jump_00A_4EE4
    cp a, $42
    jp z, Jump_00A_4EED
    cp a, $43
    jp z, Jump_00A_4EF6
    cp a, $48
    jp z, Jump_00A_4EFF
    cp a, $53
    jp z, Jump_00A_4F15
    cp a, $54
    jp z, Jump_00A_4F1E
    cp a, $55
    jp z, Jump_00A_4F1E
    cp a, $56
    jp z, Jump_00A_4F1E
    cp a, $5D
    jp z, Jump_00A_4F25
    cp a, $62
    jp z, Jump_00A_4F2E
    cp a, $63
    jp z, Jump_00A_4F37
    cp a, $64
    jp z, Jump_00A_4F40
    cp a, $65
    jp z, Jump_00A_4F49
    cp a, $66
    jp z, Jump_00A_4F52
    cp a, $67
    jp z, Jump_00A_4F5B
    cp a, $70
    jp z, Jump_00A_4F64
    cp a, $73
    jp z, Jump_00A_4F6D
    cp a, $74
    jp z, Jump_00A_4F76
    cp a, $75
    jp z, Jump_00A_4F7F
    cp a, $76
    jp z, Jump_00A_4F88
    cp a, $81
    jp z, Jump_00A_4F91
    cp a, $82
    jp z, Jump_00A_4F9A
    cp a, $83
    jp z, Jump_00A_4FA3
    cp a, $85
    jp z, Jump_00A_4FAC
    cp a, $86
    jp z, Jump_00A_4FB5
    cp a, $87
    jp z, Jump_00A_4FBE
    cp a, $88
    jp z, Jump_00A_4FC7
    cp a, $8B
    jp z, Jump_00A_4FD0
    cp a, $8C
    jp z, Jump_00A_4FD9
    cp a, $8E
    jp z, Jump_00A_4FE2
    cp a, $90
    jp z, Jump_00A_4FEB
    cp a, $A0
    jp z, Jump_00A_4FF4
    cp a, $A2
    jp z, Jump_00A_4FFD
    cp a, $A8
    jp z, Jump_00A_5006
    cp a, $AD
    jp z, Jump_00A_500F
    cp a, $AE
    jp z, Jump_00A_500F
    cp a, $B0
    jp z, Jump_00A_5018
    cp a, $B3
    jp z, Jump_00A_5021
    cp a, $B4
    jp z, Jump_00A_5021
    cp a, $B5
    jp z, Jump_00A_5021
    cp a, $B8
    jp z, Jump_00A_502A
    cp a, $BE
    jp z, Jump_00A_5033
    cp a, $BF
    jp z, Jump_00A_503C
    cp a, $C0
    jp z, Jump_00A_5045
    cp a, $C1
    jp z, Jump_00A_5045
    cp a, $C2
    jp z, Jump_00A_504E
    cp a, $C3
    jp z, Jump_00A_504E
    ret

Jump_00A_4E79::
    ld de, EncounterGrid_5773
    ld a, $08
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4E82::
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, Jump_00A_4E91
    ld de, EncounterGrid_5856
    ld a, $04
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4E91::
    ld de, EncounterGroup_588E
    call LoadEncounterMonsterIdsToWorkBuf
    ret

Jump_00A_4E98::
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, Jump_00A_4EA7
    ld de, EncounterGrid_589B
    ld a, $08
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4EA7::
    ld de, EncounterGroup_5A3B
    call LoadEncounterMonsterIdsToWorkBuf
    ret

Jump_00A_4EAE::
    ld de, EncounterGrid_5A4C
    ld a, $04
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4EB7::
    ld de, EncounterGrid_5A8A
    ld a, $04
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4EC0::
    ld de, EncounterGrid_5AB7
    ld a, $04
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4EC9::
    ld de, EncounterGrid_5ADE
    ld a, $03
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4ED2::
    ld de, EncounterGrid_5AFF
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4EDB::
    ld de, EncounterGrid_5B14
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4EE4::
    ld de, EncounterGrid_5B29
    ld a, $03
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4EED::
    ld de, EncounterGrid_5B45
    ld a, $03
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4EF6::
    ld de, EncounterGrid_5B58
    ld a, $03
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4EFF::
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, Jump_00A_4F0E
    ld de, EncounterGrid_5B6B
    ld a, $0C
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4F0E::
    ld de, EncounterGroup_5D4E
    call LoadEncounterMonsterIdsToWorkBuf
    ret

Jump_00A_4F15::
    ld de, EncounterGrid_5D5D
    ld a, $04
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4F1E::
    ld de, EncounterGroup_5D8C
    call LoadEncounterMonsterIdsToWorkBuf
    ret

Jump_00A_4F25::
    ld de, EncounterGrid_5D9B
    ld a, $04
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4F2E::
    ld de, EncounterGrid_5DCA
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4F37::
    ld de, EncounterGrid_5DE7
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4F40::
    ld de, EncounterGrid_5DEF
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4F49::
    ld de, EncounterGrid_5DF7
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4F52::
    ld de, EncounterGrid_5E0C
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4F5B::
    ld de, EncounterGrid_5E14
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4F64::
    ld de, EncounterGrid_5E2B
    ld a, $0C
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4F6D::
    ld de, EncounterGrid_6028
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4F76::
    ld de, EncounterGrid_603D
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4F7F::
    ld de, EncounterGrid_6052
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4F88::
    ld de, EncounterGrid_606B
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4F91::
    ld de, EncounterGrid_6084
    ld a, $01
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4F9A::
    ld de, EncounterGrid_6097
    ld a, $03
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4FA3::
    ld de, EncounterGrid_60BA
    ld a, $03
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4FAC::
    ld de, EncounterGrid_60DD
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4FB5::
    ld de, EncounterGrid_60F2
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4FBE::
    ld de, EncounterGrid_6107
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4FC7::
    ld de, EncounterGrid_6120
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4FD0::
    ld de, EncounterGrid_6139
    ld a, $03
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4FD9::
    ld de, EncounterGrid_6160
    ld a, $03
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4FE2::
    ld de, EncounterGrid_6181
    ld a, $03
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4FEB::
    ld de, EncounterGrid_61A2
    ld a, $03
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4FF4::
    ld de, EncounterGrid_61BD
    ld a, $04
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_4FFD::
    ld de, EncounterGrid_61FB
    ld a, $03
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_5006::
    ld de, EncounterGrid_6220
    ld a, $06
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_500F::
    ld de, EncounterGrid_62AB
    ld a, $03
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_5018::
    ld de, EncounterGrid_62D2
    ld a, $03
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_5021::
    ld de, EncounterGrid_62EB
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_502A::
    ld de, EncounterGrid_6300
    ld a, $05
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_5033::
    ld de, EncounterGrid_6382
    ld a, $01
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_503C::
    ld de, EncounterGrid_6393
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_5045::
    ld de, EncounterGrid_63AA
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

Jump_00A_504E::
    ld de, EncounterGrid_63BF
    ld a, $02
    call ReadMapCellWordForScreenXY_5057
    ret

; DE = the word at DE + 2 * A * (hMapScreenY & $0F) + 2 * (hMapScreenX & $0F); falls through (E-0122)
; 48 call sites from 1 routine (e.g. CollectUniqueEncounterIdsToWD09F_Sub01)
; reads: hMapScreenY, hMapScreenX, wWorkBuf, hTemp0, hTemp1
; writes: wWorkBuf, wMonsterId, hTemp0
; points at: hTemp0
ReadMapCellWordForScreenXY_5057::
Func_00A_5057:: ; address name
    sla a
    ld c, a
    ldh a, [hMapScreenY]
    and a, $0F
    call Multiply8
    ldh a, [hMapScreenX]
    and a, $0F
    sla a
    add_a_to_hl
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a

; DE += 2; wD09D = the number of non-zero entries (up to 5); copies their monster ids to wD09F and replaces each with two bytes of its monster table entry (E-0127)
; 4 call sites from 1 routine (e.g. CollectUniqueEncounterIdsToWD09F_Sub01)
; reads: wWorkBuf, hTemp0, hTemp1
; writes: wWorkBuf, wMonsterId, hTemp0
; points at: hTemp0
LoadEncounterMonsterIdsToWorkBuf::
Func_00A_5071:: ; address name
    inc de
    inc de
    push de
    ld b, $00

Jump_00A_5076::
    ld a, [de]
    inc de
    or a, a
    jr z, Jump_00A_5083
    inc b
    ld a, b
    cp a, $05
    jr z, Jump_00A_5083
    jr Jump_00A_5076

Jump_00A_5083::
    pop de
    ld a, $05
    add a, e
    ld e, a
    jr nc, Jump_00A_508B
    inc d

Jump_00A_508B::
    ld a, b
    ld [wWorkBuf], a
    xor a, a
    ld [wWorkBuf + $1], a
    ld hl, wWorkBuf + $2

Jump_00A_5096::
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_00A_5096
    ld a, [wWorkBuf]
    ld b, a
    ld hl, wWorkBuf + $2

Jump_00A_50A6::
    push bc
    ld a, [hl+]
    ld [wMonsterId], a
    ld a, [hl-]
    ld [wMonsterId + $1], a
    push hl
    ld a, $02
    ldh [hTemp0], a
    ld de, hTemp0
    ld c, $00
    farcall CopyMonsterTableBytesFrom4075
    pop hl
    ldh a, [hTemp0]
    ld [hl+], a
    ldh a, [hTemp1]
    ld [hl+], a
    pop bc
    dec b
    jr nz, Jump_00A_50A6
    ret

; entry 2 of the `rst $00` table in RunBattleIntroKindCase
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleKind
RunBattleIntroKindCase_Case02::
Jump_00A_50CB:: ; address name
    ld a, $02
    ld [wBattleKind], a
    ret

; entry 1 of the `rst $00` table in RunBattleIntroKindCase
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wMapType, hMapScreenY, hMapScreenX, wKeyWorldFloor
; writes: wEncounterKind, wBattleKind
; points at: wKeyWorldAreas, wKeyWorldFloorInfo
RunBattleIntroKindCase_Case01::
Jump_00A_50D1:: ; address name
    call NextTableByte
    ld a, [wRandomLo]
    and a, $03
    ld hl, Data_00A_514C
    add_a_to_hl
    ld a, [hl]
    ld [wEncounterKind], a
    ld a, [wMapType]
    and a, $07
    cp a, $01
    jr z, Jump_00A_50F1
    or a, a
    jr nz, Jump_00A_5116

Jump_00A_50F1::
    ldh a, [hMapScreenY]
    srl a
    and a, $FE
    ld c, a
    ldh a, [hMapScreenX]
    srl a
    srl a
    add a, c
    ld hl, wKeyWorldAreas
    add_a_to_hl
    ld a, [hl]
    ld c, a
    add a, a
    add a, a
    add a, c
    ld c, a
    call RunBattleIntroKindCase_Case01_Sub01
    ld a, $01
    ld [wBattleKind], a
    ret

Jump_00A_5116::
    ld a, [wKeyWorldFloor]
    add a, a
    add a, a
    ld hl, wKeyWorldFloorInfo
    add_a_to_hl
    ld a, [hl]
    push af
    and a, $0F
    srl a
    and a, $FE
    ld c, a
    pop af
    swap a
    and a, $0F
    srl a
    srl a
    add a, c
    ld hl, wKeyWorldAreas
    add_a_to_hl
    ld a, [hl]
    add a, a
    add a, a
    add a, a
    ld c, a
    call RunBattleIntroKindCase_Case01_Sub01
    ld a, $01
    ld [wBattleKind], a
    ret

; address loaded by RunBattleIntroKindCase_Case00_Sub01, RunBattleIntroKindCase_Case01
Data_00A_514C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $02, $01, $02

; address loaded by RunBattleIntroKindCase_Case00_Sub01
Data_00A_5150:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $00, $01

; only called from RunBattleIntroKindCase_Case01 (E-0047)
; 2 call sites from 1 routine (e.g. RunBattleIntroKindCase_Case01)
; reads: hPlayerStateFlags, wKeyRandomLo
; points at: wEncounterMonsters, wKeyWorldMonsters
RunBattleIntroKindCase_Case01_Sub01::
Func_00A_5154:: ; address name
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, Jump_00A_519F
    ld b, $03
    ld de, wEncounterMonsters

Jump_00A_515F::
    push bc
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and a, $07
    add a, c
    cp a, $20
    jr c, Jump_00A_516F
    ld a, $1F

Jump_00A_516F::
    add a, a
    ld hl, wKeyWorldMonsters
    add_a_to_hl
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    and a, $01
    ld [de], a
    inc de
    push de
    ld a, e
    sub a, $DF
    ld e, a
    ld a, d
    sbc a, $CF
    ld d, a
    sra d
    rr e
    ld a, e
    add a, $E3
    ld e, a
    ld a, d
    adc a, $CF
    ld d, a
    ld a, [hl]
    srl a
    ld [de], a
    pop de
    pop bc
    dec b
    jr nz, Jump_00A_515F
    ret

Jump_00A_519F::
    ld b, $03
    ld de, wEncounterMonsters

Jump_00A_51A4::
    push bc
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and a, $07
    add a, $20
    add a, a
    ld hl, wKeyWorldMonsters
    add_a_to_hl
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    and a, $01
    ld [de], a
    inc de
    push de
    ld a, e
    sub a, $DF
    ld e, a
    ld a, d
    sbc a, $CF
    ld d, a
    sra d
    rr e
    ld a, e
    add a, $E3
    ld e, a
    ld a, d
    adc a, $CF
    ld d, a
    ld a, [hl]
    srl a
    ld [de], a
    pop de
    pop bc
    dec b
    jr nz, Jump_00A_51A4
    ret

; entry 3 of the `rst $00` table in RunBattleIntroKindCase
; no direct call (reached through a table, a jump or a vector)
; reads: wMapType
; writes: wBattleIntroFlag, wBattleKind
RunBattleIntroKindCase_Case03::
Jump_00A_51DF:: ; address name
    ld a, [wMapType]
    cp a, $82
    jr nz, Jump_00A_51EB
    ld a, $01
    ld [wBattleIntroFlag], a

Jump_00A_51EB::
    ld a, $03
    ld [wBattleKind], a
    ret

; entry 4 of the `rst $00` table in RunBattleIntroKindCase
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleKind
RunBattleIntroKindCase_Case04::
Jump_00A_51F1:: ; address name
    ld a, $04
    ld [wBattleKind], a
    ret

; entry 7 of the `rst $00` table in RunBattleIntroKindCase
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleKind
RunBattleIntroKindCase_Case07::
Jump_00A_51F7:: ; address name
    ld a, $05
    ld [wBattleKind], a
    ret

; runs the routine for wC904 (jump table of three); field mode state 3 (E-0122)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case03)
; reads: wBattleTransitionStep
RunBattleTransitionStep::
Func_00A_51FD:: ; address name
    ld a, [wBattleTransitionStep]
    rst $00
    dw RunBattleTransitionStep_Case00
    dw RunBattleTransitionStep_Case01
    dw RunBattleTransitionStep_Case02

; entry 0 of the `rst $00` table in RunBattleTransitionStep
; no direct call (reached through a table, a jump or a vector)
; reads: wCurrentMusic, wBattleTransitionSubStep, hScrollY, hScrollX
; writes: wTransitionByteCD, hSpriteWindowClipMode, wTransitionBGPtrLo, wTransitionBGPtrHi, wTransitionCounter, wTransitionStage, wTransitionByte08
; points at: wBattleTransitionStep
RunBattleTransitionStep_Case00::
Jump_00A_5207:: ; address name
    ld a, [wCurrentMusic]
    ld [wTransitionByteCD], a
    ld a, [wBattleTransitionSubStep]
    and a, $01
    sla a
    add a, $44
    call QueueMusic
    ld a, $03
    ldh [hSpriteWindowClipMode], a
    ldh a, [hScrollY]
    and a, $F8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $00
    ld e, a
    ld a, d
    adc a, $98
    ld d, a
    ld a, d
    and a, $9B
    ld d, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add a, e
    ld e, a
    jr nc, Jump_00A_5245
    inc d

Jump_00A_5245::
    ld a, e
    ld [wTransitionBGPtrLo], a
    ld a, d
    ld [wTransitionBGPtrHi], a
    xor a, a
    ld [wTransitionCounter], a
    ld [wTransitionStage], a
    ld [wTransitionByte08], a
    ld hl, wBattleTransitionStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunBattleTransitionStep
; no direct call (reached through a table, a jump or a vector)
; reads: wSoundChannelSlots
; writes: wGameMode, wModeState, wGameMode2State, wGameMode2Arg
; points at: wSoundChannel1, wSoundChannel2, wSoundChannel3, wSoundChannel4, wSoundChannel5, wModeChangeRequest, wBGFillFlag
RunBattleTransitionStep_Case02::
Jump_00A_525C:: ; address name
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
    call RunBattleIntroKindCase
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wGameMode], a
    xor a, a
    ld [wModeState], a
    ld [wGameMode2State], a
    ld [wGameMode2Arg], a
    ld hl, wModeChangeRequest
    inc [hl]
    ld hl, wBGFillFlag
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunBattleTransitionStep
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTransitionSubStep
RunBattleTransitionStep_Case01::
Jump_00A_52A4:: ; address name
    ld a, [wBattleTransitionSubStep]
    rst $00
    dw RunBattleTransitionStep_Case01_Case00
    dw RunBattleTransitionStep_Case01_Case01
    dw RunBattleTransitionStep_Case01_Case02

; entry 0 of the `rst $00` table in RunBattleTransitionStep_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTransitionCounter
RunBattleTransitionStep_Case01_Case00::
Jump_00A_52AE:: ; address name
    ld a, [wTransitionCounter]
    rst $00
    dw RunBattleTransitionStep_Case01_Case00_Case00
    dw RunBattleTransitionStep_Case01_Case00_Case01

; entry 0 of the `rst $00` table in RunBattleTransitionStep_Case01_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wTransitionStage
; points at: wTransitionCounter, wTransitionStage
RunBattleTransitionStep_Case01_Case00_Case00::
Jump_00A_52B6:: ; address name
    ld a, [wTransitionStage]
    cp a, $14
    jr nz, Jump_00A_52C2
    ld hl, wTransitionCounter
    inc [hl]
    ret

Jump_00A_52C2::
    ld a, [wTransitionStage]
    ld hl, $0000
    add_a_to_hl
    ld b, $09

Jump_00A_52CF::
    push hl
    push bc
    call WriteTileC4AtTransitionBGPtrLoAndClearAttr
    pop bc
    pop hl
    ld a, l
    add a, $40
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, Jump_00A_52CF
    ld a, [wTransitionStage]
    ld b, a
    ld a, $13
    sub a, b
    ld hl, $0020
    add_a_to_hl
    ld b, $09

Jump_00A_52F2::
    push hl
    push bc
    call WriteTileC4AtTransitionBGPtrLoAndClearAttr
    pop bc
    pop hl
    ld a, l
    add a, $40
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, Jump_00A_52F2
    ld hl, wTransitionStage
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunBattleTransitionStep_Case01_Case00
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleTransitionStep
RunBattleTransitionStep_Case01_Case00_Case01::
Jump_00A_5309:: ; address name
    ld hl, wBattleTransitionStep
    inc [hl]
    ret

; writes tile $C4 at the BG map address from Func_00A_5328 and, on CGB, attribute 0 in VRAM bank 1 (E-0122)
; 10 call sites from 3 routines (e.g. RunBattleTransitionStep_Case01_Case00_Case00, AddHLToTransitionBGPtrLoInBGMap_Case01, RunBattleTransitionStep_Case01_Case02_Case00)
; reads: wIsCGB
; writes: rVBK
WriteTileC4AtTransitionBGPtrLoAndClearAttr::
Func_00A_530E:: ; address name
    call WriteTileC4AtTransitionBGPtrLoAndClearAttr_Sub01
    ld a, $C4
    call WriteVRAMByte
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, $01
    ldh [rVBK], a
    xor a, a
    call WriteVRAMByte
    ld a, $00
    ldh [rVBK], a
    ret

; only called from WriteTileC4AtTransitionBGPtrLoAndClearAttr (E-0047)
; 1 call site from 1 routine (e.g. WriteTileC4AtTransitionBGPtrLoAndClearAttr)
WriteTileC4AtTransitionBGPtrLoAndClearAttr_Sub01::
Func_00A_5328:: ; address name
    push bc
    ld b, l
    ld a, l
    and a, $E0
    ld l, a
    call AddHLToTransitionBGPtrLoInBGMap
    ld a, b
    and a, $1F
    jr z, Jump_00A_533D
    ld b, a

Jump_00A_5337::
    call NextBGMapColumn_Bank0A
    dec b
    jr nz, Jump_00A_5337

Jump_00A_533D::
    pop bc
    ret

; L = (L & $E0) | ((L + 1) & $1F): moves HL one entry right inside its 32-entry BG map row, wrapping at the row end; keeps AF (the same 15 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. WriteTileC4AtTransitionBGPtrLoAndClearAttr_Sub01)
NextBGMapColumn_Bank0A::
Func_00A_533F:: ; address name
    push af
    ld a, l
    and a, $E0
    push af
    ld a, l
    inc a
    and a, $1F
    ld l, a
    pop af
    or a, l
    ld l, a
    pop af
    ret

; HL = wC909/wC90A + HL, the high byte's low 2 bits wrapped and its upper 6 bits kept from wC90A (stays inside one 1 KB BG map) (E-0117)
; 1 call site from 1 routine (e.g. WriteTileC4AtTransitionBGPtrLoAndClearAttr_Sub01)
; reads: wTransitionBGPtrLo, wTransitionBGPtrHi
AddHLToTransitionBGPtrLoInBGMap::
Func_00A_534E:: ; address name
    ld a, [wTransitionBGPtrLo]
    add a, l
    ld l, a
    ld a, [wTransitionBGPtrHi]
    adc a, h
    and a, $03
    ld h, a
    ld a, [wTransitionBGPtrHi]
    and a, $FC
    or a, h
    ld h, a
    ret

; entry 1 of the `rst $00` table in RunBattleTransitionStep_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTransitionCounter
RunBattleTransitionStep_Case01_Case01::
Jump_00A_5362:: ; address name
    ld b, $06

Jump_00A_5364::
    ld a, [wTransitionCounter]
    rst $00
    dw AddHLToTransitionBGPtrLoInBGMap_Case00
    dw AddHLToTransitionBGPtrLoInBGMap_Case01
    dw AddHLToTransitionBGPtrLoInBGMap_Case02

; entry 0 of the `rst $00` table in AddHLToTransitionBGPtrLoInBGMap
; no direct call (reached through a table, a jump or a vector)
; reads: wTransitionStage, wTransitionCountA, wTransitionCountB, wTransitionCounter
; writes: wTransitionCountA, wTransitionCountB, wTransitionStage
; points at: wTransitionStage, wTransitionCounter
AddHLToTransitionBGPtrLoInBGMap_Case00::
Jump_00A_536E:: ; address name
    push bc
    ld a, [wTransitionStage]
    cp a, $11
    jp c, Jump_00A_5413
    cp a, $23
    jp c, Jump_00A_5438
    cp a, $33
    jp c, Jump_00A_545D
    cp a, $43
    jp c, Jump_00A_5474
    cp a, $51
    jp c, Jump_00A_5413
    cp a, $5F
    jp c, Jump_00A_5438
    cp a, $6B
    jp c, Jump_00A_545D
    cp a, $77
    jp c, Jump_00A_5474
    cp a, $81
    jr c, Jump_00A_5413
    cp a, $8B
    jp c, Jump_00A_5438
    cp a, $93
    jp c, Jump_00A_545D
    cp a, $9B
    jp c, Jump_00A_5474
    cp a, $A1
    jr c, Jump_00A_5413
    cp a, $A7
    jp c, Jump_00A_5438
    cp a, $AB
    jp c, Jump_00A_545D
    cp a, $AF
    jp c, Jump_00A_5474
    cp a, $B1
    jr c, Jump_00A_5413
    jr Jump_00A_5438

; entry 1 of the `rst $00` table in AddHLToTransitionBGPtrLoInBGMap
; no direct call (reached through a table, a jump or a vector)
; reads: wTransitionStage, wTransitionCountA, wTransitionCountB, wTransitionCounter
; writes: wTransitionCountA, wTransitionCountB, wTransitionStage
; points at: wTransitionStage, wTransitionCounter
AddHLToTransitionBGPtrLoInBGMap_Case01::
Jump_00A_53C6:: ; address name
    push bc
    ld a, [wTransitionStage]
    cp a, $02
    jr c, Jump_00A_5438
    cp a, $04
    jr c, Jump_00A_5413
    cp a, $08
    jp c, Jump_00A_5474
    cp a, $0C
    jp c, Jump_00A_545D
    cp a, $12
    jr c, Jump_00A_5438
    cp a, $18
    jr c, Jump_00A_5413
    cp a, $20
    jp c, Jump_00A_5474
    cp a, $28
    jr c, Jump_00A_545D
    cp a, $32
    jr c, Jump_00A_5438
    cp a, $3C
    jr c, Jump_00A_5413
    cp a, $48
    jr c, Jump_00A_5474
    cp a, $54
    jr c, Jump_00A_545D
    cp a, $62
    jr c, Jump_00A_5438
    cp a, $70
    jr c, Jump_00A_5413
    cp a, $80
    jr c, Jump_00A_5474
    cp a, $90
    jr c, Jump_00A_545D
    cp a, $A2
    jr c, Jump_00A_5438
    jr Jump_00A_5413

Jump_00A_5413::
    or a, a
    jr nz, Jump_00A_5421
    ld hl, $0233
    ld a, l
    ld [wTransitionCountA], a
    ld a, h
    ld [wTransitionCountB], a

Jump_00A_5421::
    ld a, [wTransitionCountA]
    ld l, a
    ld a, [wTransitionCountB]
    ld h, a
    push hl
    call WriteTileC4AtTransitionBGPtrLoAndClearAttr
    pop hl
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    jr Jump_00A_5489

Jump_00A_5438::
    or a, a
    jr nz, Jump_00A_5446
    ld hl, $012A
    ld a, l
    ld [wTransitionCountA], a
    ld a, h
    ld [wTransitionCountB], a

Jump_00A_5446::
    ld a, [wTransitionCountA]
    ld l, a
    ld a, [wTransitionCountB]
    ld h, a
    push hl
    call WriteTileC4AtTransitionBGPtrLoAndClearAttr
    pop hl
    ld a, l
    sub a, $01
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    jr Jump_00A_5489

Jump_00A_545D::
    ld a, [wTransitionCountA]
    ld l, a
    ld a, [wTransitionCountB]
    ld h, a
    push hl
    call WriteTileC4AtTransitionBGPtrLoAndClearAttr
    pop hl
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    jr Jump_00A_5489

Jump_00A_5474::
    ld a, [wTransitionCountA]
    ld l, a
    ld a, [wTransitionCountB]
    ld h, a
    push hl
    call WriteTileC4AtTransitionBGPtrLoAndClearAttr
    pop hl
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a

Jump_00A_5489::
    ld a, l
    ld [wTransitionCountA], a
    ld a, h
    ld [wTransitionCountB], a
    ld hl, wTransitionStage
    inc [hl]
    ld a, [wTransitionStage]
    cp a, $B4
    jr nz, Jump_00A_54A4
    ld hl, wTransitionCounter
    inc [hl]
    xor a, a
    ld [wTransitionStage], a

Jump_00A_54A4::
    pop bc
    dec b
    jp nz, Jump_00A_5364
    ret

; entry 2 of the `rst $00` table in AddHLToTransitionBGPtrLoInBGMap
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleTransitionStep
AddHLToTransitionBGPtrLoInBGMap_Case02::
Jump_00A_54AA:: ; address name
    ld hl, wBattleTransitionStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunBattleTransitionStep_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTransitionCounter
RunBattleTransitionStep_Case01_Case02::
Jump_00A_54AF:: ; address name
    ld a, [wTransitionCounter]
    rst $00
    dw RunBattleTransitionStep_Case01_Case02_Case00
    dw RunBattleTransitionStep_Case01_Case02_Case01
    dw RunBattleTransitionStep_Case01_Case02_Case02

; entry 0 of the `rst $00` table in RunBattleTransitionStep_Case01_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTransitionStage, wTransitionCountA, wTransitionCountB
; writes: wTransitionCountA, wTransitionCountB
; points at: wTransitionStage, wTransitionCounter
RunBattleTransitionStep_Case01_Case02_Case00::
Jump_00A_54B9:: ; address name
    ld a, [wTransitionStage]
    or a, a
    jr nz, Jump_00A_54CA
    ld hl, $0000
    ld a, l
    ld [wTransitionCountA], a
    ld a, h
    ld [wTransitionCountB], a

Jump_00A_54CA::
    ld hl, Data_00A_55FA
    ld a, [wTransitionStage]
    add_a_to_hl
    ld b, [hl]
    ld hl, TransitionRowStepTable
    ld a, [wTransitionStage]
    add a, a
    add_a_to_hl
    ld a, [wTransitionCountA]
    ld e, a
    ld a, [wTransitionCountB]
    ld d, a
    call JumpToWordAtHL_Bank0A

Jump_00A_54ED::
    push hl
    push bc
    call WriteTileC4AtTransitionBGPtrLoAndClearAttr
    pop bc
    pop hl
    inc hl
    dec b
    jr nz, Jump_00A_54ED
    ld hl, Data_00A_55FA
    ld a, [wTransitionStage]
    add_a_to_hl
    ld b, [hl]
    ld a, [wTransitionCountA]
    ld l, a
    ld a, [wTransitionCountB]
    ld h, a

Jump_00A_550C::
    push hl
    push bc
    call WriteTileC4AtTransitionBGPtrLoAndClearAttr
    pop bc
    pop hl
    inc hl
    dec b
    jr nz, Jump_00A_550C
    push hl
    ld hl, Data_00A_5603
    ld a, [wTransitionStage]
    add_a_to_hl
    ld b, [hl]
    pop hl
    dec hl

Jump_00A_5526::
    push hl
    push bc
    call WriteTileC4AtTransitionBGPtrLoAndClearAttr
    pop bc
    pop hl
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, Jump_00A_5526
    ld hl, Data_00A_5603
    ld a, [wTransitionStage]
    add_a_to_hl
    ld b, [hl]
    ld a, [wTransitionCountA]
    ld l, a
    ld a, [wTransitionCountB]
    ld h, a

Jump_00A_554C::
    push hl
    push bc
    call WriteTileC4AtTransitionBGPtrLoAndClearAttr
    pop bc
    pop hl
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, Jump_00A_554C
    ld a, [wTransitionCountA]
    ld l, a
    ld a, [wTransitionCountB]
    ld h, a
    ld a, l
    add a, $21
    ld l, a
    ld a, h
    adc a, $00
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
    cp a, $09
    ret nz
    ld hl, wTransitionCounter
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunBattleTransitionStep_Case01_Case02
; no direct call (reached through a table, a jump or a vector)
; points at: wTransitionCounter
RunBattleTransitionStep_Case01_Case02_Case01::
Jump_00A_5589:: ; address name
    ld hl, wTransitionCounter
    dec [hl]
    ret

; entry 2 of the `rst $00` table in RunBattleTransitionStep_Case01_Case02
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleTransitionStep
RunBattleTransitionStep_Case01_Case02_Case02::
Jump_00A_558E:: ; address name
    ld hl, wBattleTransitionStep
    inc [hl]
    ret

; HL = the word at HL, then jp hl (E-0114)
; 1 call site from 1 routine (e.g. RunBattleTransitionStep_Case01_Case02_Case00)
JumpToWordAtHL_Bank0A::
Func_00A_5593:: ; address name
    deref_hl
    jp hl

; handler 00 (entry 0 of TransitionRowStepTable)
; no direct call (reached through a table, a jump or a vector)
TransitionRowStep00:: ; code pointer of the table TransitionRowStepTable; C0
Func_00A_5597:: ; address name
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $02
    ld d, a
    ld l, e
    ld h, d
    ret

; handler 01 (entry 1 of TransitionRowStepTable)
; no direct call (reached through a table, a jump or a vector)
TransitionRowStep01:: ; code pointer of the table TransitionRowStepTable; C0
Func_00A_55A2:: ; address name
    ld a, e
    add a, $E0
    ld e, a
    ld a, d
    adc a, $01
    ld d, a
    ld l, e
    ld h, d
    ret

; handler 02 (entry 2 of TransitionRowStepTable)
; no direct call (reached through a table, a jump or a vector)
TransitionRowStep02:: ; code pointer of the table TransitionRowStepTable; C0
Func_00A_55AD:: ; address name
    ld a, e
    add a, $A0
    ld e, a
    ld a, d
    adc a, $01
    ld d, a
    ld l, e
    ld h, d
    ret

; handler 03 (entry 3 of TransitionRowStepTable)
; no direct call (reached through a table, a jump or a vector)
TransitionRowStep03:: ; code pointer of the table TransitionRowStepTable; C0
Func_00A_55B8:: ; address name
    ld a, e
    add a, $60
    ld e, a
    ld a, d
    adc a, $01
    ld d, a
    ld l, e
    ld h, d
    ret

; handler 04 (entry 4 of TransitionRowStepTable)
; no direct call (reached through a table, a jump or a vector)
TransitionRowStep04:: ; code pointer of the table TransitionRowStepTable; C0
Func_00A_55C3:: ; address name
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $01
    ld d, a
    ld l, e
    ld h, d
    ret

; handler 05 (entry 5 of TransitionRowStepTable)
; no direct call (reached through a table, a jump or a vector)
TransitionRowStep05:: ; code pointer of the table TransitionRowStepTable; C0
Func_00A_55CE:: ; address name
    ld a, e
    add a, $E0
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld l, e
    ld h, d
    ret

; handler 06 (entry 6 of TransitionRowStepTable)
; no direct call (reached through a table, a jump or a vector)
TransitionRowStep06:: ; code pointer of the table TransitionRowStepTable; C0
Func_00A_55D9:: ; address name
    ld a, e
    add a, $A0
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld l, e
    ld h, d
    ret

; handler 07 (entry 7 of TransitionRowStepTable)
; no direct call (reached through a table, a jump or a vector)
TransitionRowStep07:: ; code pointer of the table TransitionRowStepTable; C0
Func_00A_55E4:: ; address name
    ld a, e
    add a, $60
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld l, e
    ld h, d
    ret

; handler 08 (entry 8 of TransitionRowStepTable)
; no direct call (reached through a table, a jump or a vector)
TransitionRowStep08:: ; code pointer of the table TransitionRowStepTable; C0
Func_00A_55EF:: ; address name
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld l, e
    ld h, d
    ret

; address loaded by RunBattleTransitionStep_Case01_Case02_Case00
Data_00A_55FA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $14, $12, $10, $0E, $0C, $0A, $08, $06, $04

; address loaded by RunBattleTransitionStep_Case01_Case02_Case00
Data_00A_5603:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $12, $10, $0E, $0C, $0A, $08, $06, $04, $02

; E-0202 (C1: RunBattleTransitionStep_Case01_Case02_Case00 calls JumpToWordAtHL_Bank0A with HL = $560C + 2 * wTransitionStage and DE = wTransitionCountA/B; each target adds a constant ($220, $1E0, $1A0, ...) to DE and returns it in HL; the nine targets were the INCBIN slice at $5597).
; record: routine adding this stage's step to DE
TransitionRowStepTable::
Data_00A_560C:: ; address name
    dw TransitionRowStep00 ; id 0
    dw TransitionRowStep01 ; id 1
    dw TransitionRowStep02 ; id 2
    dw TransitionRowStep03 ; id 3
    dw TransitionRowStep04 ; id 4
    dw TransitionRowStep05 ; id 5
    dw TransitionRowStep06 ; id 6
    dw TransitionRowStep07 ; id 7
    dw TransitionRowStep08 ; id 8

; counts steps in wC7C9 (wrapping at 1000); every 100 steps and at 1000 updates the stored SRAM records by their state byte and field $6E (E-0130)
; 2 call sites from 2 routines (e.g. UpdatePlayerMovement_Sub01, RunFieldActionRequestActionIfBit7_Case03)
; reads: wScriptRunning, wEncounterRate, wStepCounterLo, wStepCounterHi, hTemp0
; writes: hTemp0, wStepCounterLo, wStepCounterHi, rRAMG
; points at: sRecords
AdvanceStepCounterAndUpdateStoredRecords::
Func_00A_561E:: ; address name
    ld a, [wScriptRunning]
    or a, a
    ret nz
    ld a, [wEncounterRate]
    and a, $7F
    ret z
    xor a, a
    ldh [hTemp0], a
    ld a, [wStepCounterLo]
    ld l, a
    ld a, [wStepCounterHi]
    ld h, a
    inc hl
    push hl
    ld a, $64
    call DivideHLByA
    or a, a
    jr nz, Jump_00A_5642
    ld a, $01
    ldh [hTemp0], a

Jump_00A_5642::
    pop hl
    ld a, l
    cp a, $E8
    jr nz, Jump_00A_5656
    ld a, h
    cp a, $03
    jr nz, Jump_00A_5656
    ldh a, [hTemp0]
    or a, $02
    ldh [hTemp0], a
    ld hl, $0000

Jump_00A_5656::
    ld a, l
    ld [wStepCounterLo], a
    ld a, h
    ld [wStepCounterHi], a
    ldh a, [hTemp0]
    or a, a
    ret z
    ld a, $0A
    ld [rRAMG], a
    ld hl, sRecords
    ld a, $6B
    add_a_to_hl
    ld de, sRecords
    ld b, $1E

Jump_00A_5676::
    ld a, [de]
    or a, a
    jr z, Jump_00A_56B8
    dec a
    jr nz, Jump_00A_56A7
    ldh a, [hTemp0]
    bit 1, a
    jr z, Jump_00A_56B8
    push de
    ld a, e
    add a, $6E
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, [de]
    pop de
    or a, a
    jr nz, Jump_00A_56B8
    push de
    ld a, [hl+]
    ld e, a
    ld a, [hl-]
    ld d, a
    cp a, $03
    jr nz, Jump_00A_569F
    ld a, e
    cp a, $E7
    jr z, Jump_00A_56A4

Jump_00A_569F::
    inc de
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl-], a

Jump_00A_56A4::
    pop de
    jr Jump_00A_56B8

Jump_00A_56A7::
    push de
    ld a, [hl+]
    ld e, a
    ld a, [hl-]
    ld d, a
    cp a, e
    jr nz, Jump_00A_56B2
    or a, a
    jr z, Jump_00A_56B7

Jump_00A_56B2::
    dec de
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl-], a

Jump_00A_56B7::
    pop de

Jump_00A_56B8::
    ld a, e
    add a, $A5
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, l
    add a, $A5
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, Jump_00A_5676
    xor a, a
    ld [rRAMG], a
    ret

; only called from UpdatePlayerMovement_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. UpdatePlayerMovement_Sub01)
; reads: wEncounterRate, wScriptRunning, wPartyCount, hTemp0, hTemp1
; writes: rRAMG
; points at: wPartyList
UpdatePlayerMovement_Sub01_Sub02::
Func_00A_56D0:: ; address name
    ld a, [wEncounterRate]
    and a, $7F
    ret z
    ld a, [wScriptRunning]
    or a, a
    ret nz
    ld de, $0002
    call TestFlagBit
    ret nc
    ld a, [wPartyCount]
    or a, a
    ret z
    ld b, a
    ld hl, wPartyList
    ld a, $0A
    ld [rRAMG], a

Jump_00A_56F0::
    push bc
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    bit 7, a
    jr nz, Jump_00A_573E
    ld a, [hl]
    ld c, $A4
    call LoadSRAMRecordByte
    cp a, $1B
    jr nz, Jump_00A_5709
    ld c, $5D
    jr Jump_00A_570F

Jump_00A_5709::
    cp a, $1C
    jr nz, Jump_00A_573E
    ld c, $61

Jump_00A_570F::
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
    cp a, e
    jr nz, Jump_00A_572D
    ldh a, [hTemp1]
    cp a, d
    jr z, Jump_00A_573E

Jump_00A_572D::
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    inc de
    push hl
    ld a, [hl]
    call SRAMRecordAddress
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl], a
    pop hl

Jump_00A_573E::
    pop bc
    inc hl
    dec b
    jr nz, Jump_00A_56F0
    xor a, a
    ld [rRAMG], a
    ret

; only called from UpdatePlayerMovement_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. UpdatePlayerMovement_Sub01)
; reads: hPlayerSpriteOverride, wScriptRunning, hPlayerSpriteTimerLo, hPlayerSpriteTimerHi
; writes: hPlayerSpriteTimerLo, hPlayerSpriteTimerHi, wTalkEventGroup, wTalkEventIndex
UpdatePlayerMovement_Sub01_Sub03::
Func_00A_5748:: ; address name
    ldh a, [hPlayerSpriteOverride]
    bit 7, a
    ret z
    ld a, [wScriptRunning]
    or a, a
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
    ld a, $0A
    ld [wTalkEventGroup], a
    xor a, a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ret

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 8 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 64 words, up to its first group).
; record: one screen, row by row (8 per row): its encounter group
EncounterGrid_5773::
Data_00A_5773:: ; address name
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

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 2 encounter word(s)
EncounterGroup_57F3::
Data_00A_57F3:: ; address name
    db $01 ; entry 0
    db $07, $03, $07, $00, $00, $00
    dw $0002, $0003

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_57FE::
Data_00A_57FE:: ; address name
    db $01 ; entry 0
    db $0B, $04, $08, $0B, $00, $00
    dw $0002, $0003, $0005

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_580B::
Data_00A_580B:: ; address name
    db $01 ; entry 0
    db $0C, $05, $0A, $0C, $00, $00
    dw $0002, $0003, $0004

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5818::
Data_00A_5818:: ; address name
    db $01 ; entry 0
    db $10, $05, $0A, $0C, $10, $00
    dw $0002, $0003, $0004, $0005

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5827::
Data_00A_5827:: ; address name
    db $02 ; entry 0
    db $0D, $02, $04, $09, $0D, $00
    dw $0002, $0003, $0005, $0006

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5836::
Data_00A_5836:: ; address name
    db $02 ; entry 0
    db $0E, $02, $04, $09, $0E, $00
    dw $0002, $0003, $0005, $0004

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_5845::
Data_00A_5845:: ; address name
    db $02 ; entry 0
    db $14, $02, $04, $09, $0E, $14
    dw $0002, $0003, $0005, $0004, $0006

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 4 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 16 words, up to its first group).
; record: one screen, row by row (4 per row): its encounter group
EncounterGrid_5856::
Data_00A_5856:: ; address name
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

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 2 encounter word(s)
EncounterGroup_5876::
Data_00A_5876:: ; address name
    db $02 ; entry 0
    db $08, $04, $08, $00, $00, $00
    dw $0180, $0181

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_5881::
Data_00A_5881:: ; address name
    db $02 ; entry 0
    db $0B, $03, $06, $0B, $00, $00
    dw $0180, $0181, $0184

; E-0202 (C1: passed directly in DE to RunBattleIntroKindCase_Case00_Sub01; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_588E::
Data_00A_588E:: ; address name
    db $02 ; entry 0
    db $0C, $05, $0A, $0C, $00, $00
    dw $0180, $0181, $0186

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 8 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 64 words, up to its first group).
; record: one screen, row by row (8 per row): its encounter group
EncounterGrid_589B::
Data_00A_589B:: ; address name
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

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_591B::
Data_00A_591B:: ; address name
    db $03 ; entry 0
    db $0C, $04, $08, $0C, $00, $00
    dw $0009, $000A, $000C

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_5928::
Data_00A_5928:: ; address name
    db $03 ; entry 0
    db $12, $03, $07, $0B, $0F, $12
    dw $0009, $000A, $000B, $000C, $0010

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_5939::
Data_00A_5939:: ; address name
    db $03 ; entry 0
    db $12, $03, $07, $0B, $10, $12
    dw $0009, $000B, $000C, $0010, $0011

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_594A::
Data_00A_594A:: ; address name
    db $03 ; entry 0
    db $17, $05, $0A, $0D, $12, $17
    dw $0277, $000B, $000C, $0010, $0011

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_595B::
Data_00A_595B:: ; address name
    db $03 ; entry 0
    db $0F, $03, $06, $0A, $0F, $00
    dw $018B, $000C, $0010, $0011

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_596A::
Data_00A_596A:: ; address name
    db $03 ; entry 0
    db $15, $05, $08, $0D, $12, $15
    dw $018B, $0014, $0010, $0011, $0012

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_597B::
Data_00A_597B:: ; address name
    db $03 ; entry 0
    db $10, $03, $07, $0C, $10, $00
    dw $0014, $0187, $0188, $0012

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_598A::
Data_00A_598A:: ; address name
    db $03 ; entry 0
    db $16, $05, $0A, $0C, $11, $16
    dw $0014, $0187, $000F, $0188, $0012

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_599B::
Data_00A_599B:: ; address name
    db $03 ; entry 0
    db $17, $03, $08, $0D, $12, $17
    dw $0013, $0014, $0187, $0188, $0012

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_59AC::
Data_00A_59AC:: ; address name
    db $03 ; entry 0
    db $14, $03, $07, $0C, $0F, $14
    dw $018D, $0187, $0189, $0188, $018A

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_59BD::
Data_00A_59BD:: ; address name
    db $03 ; entry 0
    db $0E, $04, $09, $0E, $00, $00
    dw $018B, $0189, $018A

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_59CA::
Data_00A_59CA:: ; address name
    db $03 ; entry 0
    db $0E, $04, $09, $0E, $00, $00
    dw $018D, $018C, $018E

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_59D7::
Data_00A_59D7:: ; address name
    db $03 ; entry 0
    db $0E, $05, $0A, $0C, $0E, $00
    dw $0009, $000B, $0189, $018A

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_59E6::
Data_00A_59E6:: ; address name
    db $03 ; entry 0
    db $10, $01, $03, $04, $0A, $10
    dw $0277, $000B, $000C, $0010, $0011

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_59F7::
Data_00A_59F7:: ; address name
    db $03 ; entry 0
    db $13, $02, $03, $04, $0C, $13
    dw $0009, $000B, $000C, $0010, $0011

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_5A08::
Data_00A_5A08:: ; address name
    db $03 ; entry 0
    db $13, $01, $03, $04, $0B, $13
    dw $0009, $000B, $000C, $0010, $0011

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_5A19::
Data_00A_5A19:: ; address name
    db $03 ; entry 0
    db $13, $01, $03, $05, $0A, $13
    dw $0009, $000B, $000C, $0010, $0011

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_5A2A::
Data_00A_5A2A:: ; address name
    db $03 ; entry 0
    db $10, $01, $03, $05, $07, $10
    dw $0009, $000B, $000C, $0010, $0011

; E-0202 (C1: passed directly in DE to RunBattleIntroKindCase_Case00_Sub01; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_5A3B::
Data_00A_5A3B:: ; address name
    db $03 ; entry 0
    db $12, $04, $08, $0B, $0E, $12
    dw $001D, $001F, $0018, $0020, $0021

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 4 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 16 words, up to its first group).
; record: one screen, row by row (4 per row): its encounter group
EncounterGrid_5A4C::
Data_00A_5A4C:: ; address name
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

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5A6C::
Data_00A_5A6C:: ; address name
    db $03 ; entry 0
    db $0F, $03, $05, $0A, $0F, $00
    dw $0022, $0015, $0017, $0018

; E-0202 (C1: no reference found; it follows the group before it; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5A7B::
Data_00A_5A7B:: ; address name
    db $02 ; entry 0
    db $0F, $03, $05, $0A, $0F, $00
    dw $0022, $0015, $0017, $0018

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 4 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 16 words, up to its first group).
; record: one screen, row by row (4 per row): its encounter group
EncounterGrid_5A8A::
Data_00A_5A8A:: ; address name
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

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_5AAA::
Data_00A_5AAA:: ; address name
    db $03 ; entry 0
    db $0C, $04, $08, $0C, $00, $00
    dw $0024, $0025, $0027

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 4 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 12 words, up to its first group).
; record: one screen, row by row (4 per row): its encounter group
EncounterGrid_5AB7::
Data_00A_5AB7:: ; address name
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

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5ACF::
Data_00A_5ACF:: ; address name
    db $03 ; entry 0
    db $12, $03, $08, $0D, $12, $00
    dw $0023, $0024, $0025, $0027

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 3 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 9 words, up to its first group).
; record: one screen, row by row (3 per row): its encounter group
EncounterGrid_5ADE::
Data_00A_5ADE:: ; address name
    dw EncounterGroup_5AF0 ; id 0
    dw EncounterGroup_5AF0 ; id 1
    dw EncounterGroup_5AF0 ; id 2
    dw EncounterGroup_5AF0 ; id 3
    dw EncounterGroup_5AF0 ; id 4
    dw EncounterGroup_5AF0 ; id 5
    dw EncounterGroup_5AF0 ; id 6
    dw EncounterGroup_5AF0 ; id 7
    dw EncounterGroup_5AF0 ; id 8

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5AF0::
Data_00A_5AF0:: ; address name
    db $03 ; entry 0
    db $0F, $03, $05, $0A, $0F, $00
    dw $018D, $0023, $0019, $001E

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 2 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 4 words, up to its first group).
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_5AFF::
Data_00A_5AFF:: ; address name
    dw EncounterGroup_5B07 ; id 0
    dw EncounterGroup_5B07 ; id 1
    dw EncounterGroup_5B07 ; id 2
    dw EncounterGroup_5B07 ; id 3

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_5B07::
Data_00A_5B07:: ; address name
    db $03 ; entry 0
    db $0C, $04, $08, $0C, $00, $00
    dw $0013, $0026, $0016

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 2 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 4 words, up to its first group).
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_5B14::
Data_00A_5B14:: ; address name
    dw EncounterGroup_5B1C ; id 0
    dw EncounterGroup_5B1C ; id 1
    dw EncounterGroup_5B1C ; id 2
    dw EncounterGroup_5B1C ; id 3

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_5B1C::
Data_00A_5B1C:: ; address name
    db $03 ; entry 0
    db $0A, $02, $06, $0A, $00, $00
    dw $000F, $0012, $0016

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 3 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 3 words, up to its first group).
; record: one screen, row by row (3 per row): its encounter group
EncounterGrid_5B29::
Data_00A_5B29:: ; address name
    dw EncounterGroup_5B2F ; id 0
    dw EncounterGroup_5B2F ; id 1
    dw EncounterGroup_5B2F ; id 2

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 2 encounter word(s)
EncounterGroup_5B2F::
Data_00A_5B2F:: ; address name
    db $02 ; entry 0
    db $08, $04, $08, $00, $00, $00
    dw $0026, $000E

; E-0202 (C1: no reference found; it follows the group before it; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 2 encounter word(s)
EncounterGroup_5B3A::
Data_00A_5B3A:: ; address name
    db $02 ; entry 0
    db $08, $04, $08, $00, $00, $00
    dw $0026, $000E

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 3 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 3 words, up to its first group).
; record: one screen, row by row (3 per row): its encounter group
EncounterGrid_5B45::
Data_00A_5B45:: ; address name
    dw EncounterGroup_5B4B ; id 0
    dw EncounterGroup_5B4B ; id 1
    dw EncounterGroup_5B4B ; id 2

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_5B4B::
Data_00A_5B4B:: ; address name
    db $02 ; entry 0
    db $0B, $04, $08, $0B, $00, $00
    dw $0026, $000E, $000D

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 3 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 3 words, up to its first group).
; record: one screen, row by row (3 per row): its encounter group
EncounterGrid_5B58::
Data_00A_5B58:: ; address name
    dw EncounterGroup_5B5E ; id 0
    dw EncounterGroup_5B5E ; id 1
    dw EncounterGroup_5B5E ; id 2

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_5B5E::
Data_00A_5B5E:: ; address name
    db $03 ; entry 0
    db $0B, $04, $08, $0B, $00, $00
    dw $0026, $000E, $000D

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 12 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 144 words, up to its first group).
; record: one screen, row by row (12 per row): its encounter group
EncounterGrid_5B6B::
Data_00A_5B6B:: ; address name
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
Data_00A_5C5B:: ; heuristic: label inside a table; C0
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

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 2 encounter word(s)
EncounterGroup_5C8B::
Data_00A_5C8B:: ; address name
    db $01 ; entry 0
    db $07, $03, $07, $00, $00, $00
    dw $0002, $0003

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_5C96::
Data_00A_5C96:: ; address name
    db $03 ; entry 0
    db $0E, $04, $09, $0E, $00, $00
    dw $0036, $003C, $0191

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_5CA3::
Data_00A_5CA3:: ; address name
    db $03 ; entry 0
    db $15, $04, $09, $0E, $11, $15
    dw $0038, $002B, $003B, $0036, $003C

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5CB4::
Data_00A_5CB4:: ; address name
    db $03 ; entry 0
    db $12, $05, $09, $0D, $12, $00
    dw $002A, $002B, $003B, $0036

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5CC3::
Data_00A_5CC3:: ; address name
    db $03 ; entry 0
    db $12, $04, $08, $0D, $12, $00
    dw $002B, $003B, $0036, $0191

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_5CD2::
Data_00A_5CD2:: ; address name
    db $03 ; entry 0
    db $0C, $02, $07, $0C, $00, $00
    dw $0040, $0036, $0191

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5CDF::
Data_00A_5CDF:: ; address name
    db $03 ; entry 0
    db $10, $04, $09, $0D, $10, $00
    dw $002A, $002D, $0036, $0034

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5CEE::
Data_00A_5CEE:: ; address name
    db $03 ; entry 0
    db $12, $04, $09, $0E, $12, $00
    dw $0028, $002D, $0034, $003E

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_5CFD::
Data_00A_5CFD:: ; address name
    db $03 ; entry 0
    db $15, $03, $07, $0D, $11, $15
    dw $0028, $002D, $0038, $003B, $003E

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5D0E::
Data_00A_5D0E:: ; address name
    db $03 ; entry 0
    db $12, $05, $0A, $0E, $12, $00
    dw $002C, $0037, $0034, $003E

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_5D1D::
Data_00A_5D1D:: ; address name
    db $03 ; entry 0
    db $15, $04, $07, $0B, $10, $15
    dw $0029, $0033, $0037, $0039, $0192

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5D2E::
Data_00A_5D2E:: ; address name
    db $03 ; entry 0
    db $11, $03, $08, $0D, $11, $00
    dw $0033, $003A, $003D, $0192

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_5D3D::
Data_00A_5D3D:: ; address name
    db $03 ; entry 0
    db $15, $05, $0A, $0E, $12, $15
    dw $003F, $0040, $0037, $0029, $0033

; E-0202 (C1: passed directly in DE to RunBattleIntroKindCase_Case00_Sub01; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5D4E::
Data_00A_5D4E:: ; address name
    db $03 ; entry 0
    db $12, $05, $0A, $0F, $12, $00
    dw $0040, $0193, $0194, $0195

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 4 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 16 words, up to its first group).
; record: one screen, row by row (4 per row): its encounter group
EncounterGrid_5D5D::
Data_00A_5D5D:: ; address name
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

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5D7D::
Data_00A_5D7D:: ; address name
    db $03 ; entry 0
    db $13, $04, $09, $0E, $13, $00
    dw $002E, $002F, $0030, $0031

; E-0202 (C1: passed directly in DE to RunBattleIntroKindCase_Case00_Sub01; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5D8C::
Data_00A_5D8C:: ; address name
    db $03 ; entry 0
    db $13, $04, $09, $0E, $13, $00
    dw $002E, $002F, $0030, $0031

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 4 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 16 words, up to its first group).
; record: one screen, row by row (4 per row): its encounter group
EncounterGrid_5D9B::
Data_00A_5D9B:: ; address name
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

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5DBB::
Data_00A_5DBB:: ; address name
    db $03 ; entry 0
    db $10, $04, $08, $0C, $10, $00
    dw $0041, $0196, $0197, $0035

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 2 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 8 words, up to its first group).
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_5DCA::
Data_00A_5DCA:: ; address name
    dw EncounterGroup_5DDA ; id 0
    dw EncounterGroup_5DDA ; id 1
    dw EncounterGroup_5DDA ; id 2
    dw EncounterGroup_5DDA ; id 3
    dw EncounterGroup_5DDA ; id 4
    dw EncounterGroup_5DDA ; id 5
    dw EncounterGroup_5DDA ; id 6
    dw EncounterGroup_5DDA ; id 7

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_5DDA::
Data_00A_5DDA:: ; address name
    db $03 ; entry 0
    db $0C, $04, $08, $0C, $00, $00
    dw $0042, $0043, $0198

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 2 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 4 words, up to its first group).
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_5DE7::
Data_00A_5DE7:: ; address name
    dw EncounterGroup_5DFF ; id 0
    dw EncounterGroup_5DFF ; id 1
    dw EncounterGroup_5DFF ; id 2
    dw EncounterGroup_5DFF ; id 3

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 2 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 4 words, up to its first group).
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_5DEF::
Data_00A_5DEF:: ; address name
    dw EncounterGroup_5DFF ; id 0
    dw EncounterGroup_5DFF ; id 1
    dw EncounterGroup_5DFF ; id 2
    dw EncounterGroup_5DFF ; id 3

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 2 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 4 words, up to its first group).
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_5DF7::
Data_00A_5DF7:: ; address name
    dw EncounterGroup_5DFF ; id 0
    dw EncounterGroup_5DFF ; id 1
    dw EncounterGroup_5DFF ; id 2
    dw EncounterGroup_5DFF ; id 3

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_5DFF::
Data_00A_5DFF:: ; address name
    db $03 ; entry 0
    db $0C, $04, $09, $0C, $00, $00
    dw $019E, $019F, $01A0

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 2 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 4 words, up to its first group).
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_5E0C::
Data_00A_5E0C:: ; address name
    dw EncounterGroup_5E1C ; id 0
    dw EncounterGroup_5E1C ; id 1
    dw EncounterGroup_5E1C ; id 2
    dw EncounterGroup_5E1C ; id 3

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 2 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 4 words, up to its first group).
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_5E14::
Data_00A_5E14:: ; address name
    dw EncounterGroup_5E1C ; id 0
    dw EncounterGroup_5E1C ; id 1
    dw EncounterGroup_5E1C ; id 2
    dw EncounterGroup_5E1C ; id 3

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5E1C::
Data_00A_5E1C:: ; address name
    db $03 ; entry 0
    db $0E, $01, $05, $0A, $0E, $00
    dw $019D, $019E, $019F, $01A0

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 12 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 144 words, up to its first group).
; record: one screen, row by row (12 per row): its encounter group
EncounterGrid_5E2B::
Data_00A_5E2B:: ; address name
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
Data_00A_5E5D:: ; heuristic: label inside a table; C0
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

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 2 encounter word(s)
EncounterGroup_5F4B::
Data_00A_5F4B:: ; address name
    db $01 ; entry 0
    db $07, $03, $07, $00, $00, $00
    dw $0002, $0003

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_5F56::
Data_00A_5F56:: ; address name
    db $03 ; entry 0
    db $0C, $04, $08, $0C, $00, $00
    dw $0048, $0049, $0045

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5F63::
Data_00A_5F63:: ; address name
    db $03 ; entry 0
    db $10, $04, $08, $0C, $10, $00
    dw $0056, $01A7, $004A, $0047

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_5F72::
Data_00A_5F72:: ; address name
    db $03 ; entry 0
    db $17, $05, $0A, $0F, $14, $17
    dw $0056, $01A7, $004A, $0047, $0055

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5F83::
Data_00A_5F83:: ; address name
    db $03 ; entry 0
    db $13, $06, $0C, $12, $13, $00
    dw $0056, $004A, $0052, $0058

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5F92::
Data_00A_5F92:: ; address name
    db $03 ; entry 0
    db $14, $06, $0C, $12, $14, $00
    dw $005E, $01A9, $0052, $0058

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5FA1::
Data_00A_5FA1:: ; address name
    db $02 ; entry 0
    db $10, $03, $06, $0B, $10, $00
    dw $005E, $01A9, $01A8, $004D

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5FB0::
Data_00A_5FB0:: ; address name
    db $02 ; entry 0
    db $13, $06, $0C, $12, $13, $00
    dw $01A8, $005C, $004D, $0053

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5FBF::
Data_00A_5FBF:: ; address name
    db $02 ; entry 0
    db $14, $06, $0C, $12, $14, $00
    dw $01A8, $005C, $004D, $0058

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_5FCE::
Data_00A_5FCE:: ; address name
    db $03 ; entry 0
    db $16, $04, $09, $0E, $13, $16
    dw $0055, $005D, $004D, $005C, $01A8

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5FDF::
Data_00A_5FDF:: ; address name
    db $03 ; entry 0
    db $12, $05, $0A, $0E, $12, $00
    dw $01AA, $006F, $0059, $0062

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_5FEE::
Data_00A_5FEE:: ; address name
    db $02 ; entry 0
    db $0C, $04, $08, $0C, $00, $00
    dw $006E, $004C, $0068

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_5FFB::
Data_00A_5FFB:: ; address name
    db $03 ; entry 0
    db $14, $06, $09, $0E, $14, $00
    dw $005B, $0065, $0054, $0046

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_600A::
Data_00A_600A:: ; address name
    db $03 ; entry 0
    db $0F, $03, $08, $0D, $0F, $00
    dw $0065, $0046, $0054, $0058

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_6019::
Data_00A_6019:: ; address name
    db $02 ; entry 0
    db $0D, $02, $03, $0A, $0D, $00
    dw $0058, $004B, $0051, $01AD

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 2 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 4 words, up to its first group).
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_6028::
Data_00A_6028:: ; address name
    dw EncounterGroup_6030 ; id 0
    dw EncounterGroup_6030 ; id 1
    dw EncounterGroup_6030 ; id 2
    dw EncounterGroup_6030 ; id 3

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_6030::
Data_00A_6030:: ; address name
    db $03 ; entry 0
    db $0C, $04, $08, $0C, $00, $00
    dw $004E, $004F, $0050

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 2 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 4 words, up to its first group).
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_603D::
Data_00A_603D:: ; address name
    dw EncounterGroup_6045 ; id 0
    dw EncounterGroup_6045 ; id 1
    dw EncounterGroup_6045 ; id 2
    dw EncounterGroup_6045 ; id 3

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_6045::
Data_00A_6045:: ; address name
    db $03 ; entry 0
    db $0C, $04, $08, $0C, $00, $00
    dw $004E, $004F, $0050

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 2 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 4 words, up to its first group).
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_6052::
Data_00A_6052:: ; address name
    dw EncounterGroup_605A ; id 0
    dw EncounterGroup_605A ; id 1
    dw EncounterGroup_605A ; id 2
    dw EncounterGroup_605A ; id 3

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_605A::
Data_00A_605A:: ; address name
    db $03 ; entry 0
    db $16, $04, $08, $0C, $11, $16
    dw $004E, $004F, $0050, $0057, $0066

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 2 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 4 words, up to its first group).
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_606B::
Data_00A_606B:: ; address name
    dw EncounterGroup_6073 ; id 0
    dw EncounterGroup_6073 ; id 1
    dw EncounterGroup_6073 ; id 2
    dw EncounterGroup_6073 ; id 3

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_6073::
Data_00A_6073:: ; address name
    db $03 ; entry 0
    db $16, $04, $08, $0C, $11, $16
    dw $004E, $004F, $0050, $0051, $0057

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 1 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 1 words, up to its first group).
; record: one screen, row by row (1 per row): its encounter group
EncounterGrid_6084::
Data_00A_6084:: ; address name
    dw EncounterGroup_6086 ; id 0

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_6086::
Data_00A_6086:: ; address name
    db $03 ; entry 0
    db $14, $04, $08, $0C, $10, $14
    dw $01A1, $01A2, $01A3, $01A4, $01A5

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 3 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 9 words, up to its first group).
; record: one screen, row by row (3 per row): its encounter group
EncounterGrid_6097::
Data_00A_6097:: ; address name
    dw EncounterGroup_60A9 ; id 0
    dw EncounterGroup_60A9 ; id 1
    dw EncounterGroup_60A9 ; id 2
    dw EncounterGroup_60A9 ; id 3
    dw EncounterGroup_60A9 ; id 4
    dw EncounterGroup_60A9 ; id 5
    dw EncounterGroup_60A9 ; id 6
    dw EncounterGroup_60A9 ; id 7
    dw EncounterGroup_60A9 ; id 8

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_60A9::
Data_00A_60A9:: ; address name
    db $03 ; entry 0
    db $14, $04, $08, $0C, $10, $14
    dw $01A1, $01A2, $01A3, $01A4, $01A5

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 3 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 9 words, up to its first group).
; record: one screen, row by row (3 per row): its encounter group
EncounterGrid_60BA::
Data_00A_60BA:: ; address name
    dw EncounterGroup_60CC ; id 0
    dw EncounterGroup_60CC ; id 1
    dw EncounterGroup_60CC ; id 2
    dw EncounterGroup_60CC ; id 3
    dw EncounterGroup_60CC ; id 4
    dw EncounterGroup_60CC ; id 5
    dw EncounterGroup_60CC ; id 6
    dw EncounterGroup_60CC ; id 7
    dw EncounterGroup_60CC ; id 8

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_60CC::
Data_00A_60CC:: ; address name
    db $03 ; entry 0
    db $14, $04, $08, $0C, $10, $14
    dw $01A1, $01A2, $01A3, $01A4, $01A5

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 2 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 4 words, up to its first group).
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_60DD::
Data_00A_60DD:: ; address name
    dw EncounterGroup_60E5 ; id 0
    dw EncounterGroup_60E5 ; id 1
    dw EncounterGroup_60E5 ; id 2
    dw EncounterGroup_60E5 ; id 3

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_60E5::
Data_00A_60E5:: ; address name
    db $03 ; entry 0
    db $0E, $05, $09, $0E, $00, $00
    dw $005F, $0068, $0069

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 2 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 4 words, up to its first group).
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_60F2::
Data_00A_60F2:: ; address name
    dw EncounterGroup_60FA ; id 0
    dw EncounterGroup_60FA ; id 1
    dw EncounterGroup_60FA ; id 2
    dw EncounterGroup_60FA ; id 3

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_60FA::
Data_00A_60FA:: ; address name
    db $03 ; entry 0
    db $0E, $05, $09, $0E, $00, $00
    dw $005F, $0068, $0069

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 2 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 4 words, up to its first group).
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_6107::
Data_00A_6107:: ; address name
    dw EncounterGroup_610F ; id 0
    dw EncounterGroup_610F ; id 1
    dw EncounterGroup_610F ; id 2
    dw EncounterGroup_610F ; id 3

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_610F::
Data_00A_610F:: ; address name
    db $03 ; entry 0
    db $17, $04, $09, $0D, $12, $17
    dw $005F, $0067, $0068, $0069, $006A

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 2 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 4 words, up to its first group).
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_6120::
Data_00A_6120:: ; address name
    dw EncounterGroup_6128 ; id 0
    dw EncounterGroup_6128 ; id 1
    dw EncounterGroup_6128 ; id 2
    dw EncounterGroup_6128 ; id 3

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 5 encounter word(s)
EncounterGroup_6128::
Data_00A_6128:: ; address name
    db $03 ; entry 0
    db $17, $04, $09, $0D, $12, $17
    dw $005F, $0067, $0068, $0069, $006A

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 3 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 12 words, up to its first group).
; record: one screen, row by row (3 per row): its encounter group
EncounterGrid_6139::
Data_00A_6139:: ; address name
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

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_6151::
Data_00A_6151:: ; address name
    db $03 ; entry 0
    db $12, $05, $09, $0E, $12, $00
    dw $0059, $005A, $0060, $0062

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 3 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 9 words, up to its first group).
; record: one screen, row by row (3 per row): its encounter group
EncounterGrid_6160::
Data_00A_6160:: ; address name
    dw EncounterGroup_6172 ; id 0
    dw EncounterGroup_6172 ; id 1
    dw EncounterGroup_6172 ; id 2
    dw EncounterGroup_6172 ; id 3
    dw EncounterGroup_6172 ; id 4
    dw EncounterGroup_6172 ; id 5
    dw EncounterGroup_6172 ; id 6
    dw EncounterGroup_6172 ; id 7
    dw EncounterGroup_6172 ; id 8

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_6172::
Data_00A_6172:: ; address name
    db $03 ; entry 0
    db $11, $04, $09, $0E, $11, $00
    dw $005A, $0060, $0061, $0063

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 3 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 9 words, up to its first group).
; record: one screen, row by row (3 per row): its encounter group
EncounterGrid_6181::
Data_00A_6181:: ; address name
    dw EncounterGroup_6193 ; id 0
    dw EncounterGroup_6193 ; id 1
    dw EncounterGroup_6193 ; id 2
    dw EncounterGroup_6193 ; id 3
    dw EncounterGroup_6193 ; id 4
    dw EncounterGroup_6193 ; id 5
    dw EncounterGroup_6193 ; id 6
    dw EncounterGroup_6193 ; id 7
    dw EncounterGroup_6193 ; id 8

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_6193::
Data_00A_6193:: ; address name
    db $03 ; entry 0
    db $12, $05, $09, $0E, $12, $00
    dw $0057, $0059, $0060, $0062

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 3 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 6 words, up to its first group).
; record: one screen, row by row (3 per row): its encounter group
EncounterGrid_61A2::
Data_00A_61A2:: ; address name
    dw EncounterGroup_61AE ; id 0
    dw EncounterGroup_61AE ; id 1
    dw EncounterGroup_61AE ; id 2
    dw EncounterGroup_61AE ; id 3
    dw EncounterGroup_61AE ; id 4
    dw EncounterGroup_61AE ; id 5

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_61AE::
Data_00A_61AE:: ; address name
    db $03 ; entry 0
    db $11, $04, $09, $0E, $11, $00
    dw $005A, $0060, $0061, $0063

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 4 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 16 words, up to its first group).
; record: one screen, row by row (4 per row): its encounter group
EncounterGrid_61BD::
Data_00A_61BD:: ; address name
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

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_61DD::
Data_00A_61DD:: ; address name
    db $03 ; entry 0
    db $0E, $04, $07, $0B, $0E, $00
    dw $0070, $0071, $0072, $01AE

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_61EC::
Data_00A_61EC:: ; address name
    db $03 ; entry 0
    db $0E, $04, $07, $0B, $0E, $00
    dw $0070, $0071, $0072, $01AE

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 3 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 12 words, up to its first group).
; record: one screen, row by row (3 per row): its encounter group
EncounterGrid_61FB::
Data_00A_61FB:: ; address name
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

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_6213::
Data_00A_6213:: ; address name
    db $03 ; entry 0
    db $0A, $04, $08, $0A, $00, $00
    dw $0070, $0071, $0265

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 6 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 36 words, up to its first group).
; record: one screen, row by row (6 per row): its encounter group
EncounterGrid_6220::
Data_00A_6220:: ; address name
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

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_6268::
Data_00A_6268:: ; address name
    db $03 ; entry 0
    db $0A, $04, $07, $0A, $00, $00
    dw $01D7, $01D9, $01DB

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_6275::
Data_00A_6275:: ; address name
    db $03 ; entry 0
    db $0A, $03, $05, $08, $0A, $00
    dw $01D7, $01D8, $01D9, $01DB

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_6284::
Data_00A_6284:: ; address name
    db $03 ; entry 0
    db $0A, $03, $05, $07, $0A, $00
    dw $01D8, $01DB, $01DD, $01DE

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_6293::
Data_00A_6293:: ; address name
    db $03 ; entry 0
    db $0A, $03, $07, $0A, $00, $00
    dw $01DB, $01DC, $01DD

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 2 encounter word(s)
EncounterGroup_62A0::
Data_00A_62A0:: ; address name
    db $02 ; entry 0
    db $0A, $04, $0A, $00, $00, $00
    dw $01D8, $01DD

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 3 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 12 words, up to its first group).
; record: one screen, row by row (3 per row): its encounter group
EncounterGrid_62AB::
Data_00A_62AB:: ; address name
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

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_62C3::
Data_00A_62C3:: ; address name
    db $03 ; entry 0
    db $0A, $03, $05, $07, $0A, $00
    dw $01DC, $01DD, $01E0, $01E1

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 3 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 6 words, up to its first group).
; record: one screen, row by row (3 per row): its encounter group
EncounterGrid_62D2::
Data_00A_62D2:: ; address name
    dw EncounterGroup_62DE ; id 0
    dw EncounterGroup_62DE ; id 1
    dw EncounterGroup_62DE ; id 2
    dw EncounterGroup_62DE ; id 3
    dw EncounterGroup_62DE ; id 4
    dw EncounterGroup_62DE ; id 5

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_62DE::
Data_00A_62DE:: ; address name
    db $02 ; entry 0
    db $0A, $04, $07, $0A, $00, $00
    dw $01E3, $01E4, $01E5

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 2 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 4 words, up to its first group).
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_62EB::
Data_00A_62EB:: ; address name
    dw EncounterGroup_62F3 ; id 0
    dw EncounterGroup_62F3 ; id 1
    dw EncounterGroup_62F3 ; id 2
    dw EncounterGroup_62F3 ; id 3

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_62F3::
Data_00A_62F3:: ; address name
    db $03 ; entry 0
    db $0A, $06, $08, $0A, $00, $00
    dw $01E6, $01E7, $01E8

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 5 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 25 words, up to its first group).
; record: one screen, row by row (5 per row): its encounter group
EncounterGrid_6300::
Data_00A_6300:: ; address name
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

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_6332::
Data_00A_6332:: ; address name
    db $03 ; entry 0
    db $0A, $03, $07, $0A, $00, $00
    dw $01EF, $01F2, $01F7

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_633F::
Data_00A_633F:: ; address name
    db $03 ; entry 0
    db $0A, $03, $06, $08, $0A, $00
    dw $01EF, $01F2, $01F4, $01F7

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_634E::
Data_00A_634E:: ; address name
    db $03 ; entry 0
    db $0A, $03, $06, $08, $0A, $00
    dw $01ED, $01EE, $01EF, $01F7

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_635D::
Data_00A_635D:: ; address name
    db $03 ; entry 0
    db $0A, $04, $07, $0A, $00, $00
    dw $01ED, $01EE, $01F7

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 2 encounter word(s)
EncounterGroup_636A::
Data_00A_636A:: ; address name
    db $02 ; entry 0
    db $0A, $06, $0A, $00, $00, $00
    dw $01F1, $01F2

; E-0202 (C1: passed directly in DE to RunBattleIntroKindCase_Case00_Sub01; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_6375::
Data_00A_6375:: ; address name
    db $03 ; entry 0
    db $0A, $04, $06, $0A, $00, $00
    dw $0216, $0217, $0218

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 1 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 1 words, up to its first group).
; record: one screen, row by row (1 per row): its encounter group
EncounterGrid_6382::
Data_00A_6382:: ; address name
    dw EncounterGroup_6384 ; id 0

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_6384::
Data_00A_6384:: ; address name
    db $03 ; entry 0
    db $0A, $02, $04, $08, $0A, $00
    dw $01F0, $01F2, $01F4, $01F7

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 2 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 4 words, up to its first group).
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_6393::
Data_00A_6393:: ; address name
    dw EncounterGroup_639B ; id 0
    dw EncounterGroup_639B ; id 1
    dw EncounterGroup_639B ; id 2
    dw EncounterGroup_639B ; id 3

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 4 encounter word(s)
EncounterGroup_639B::
Data_00A_639B:: ; address name
    db $03 ; entry 0
    db $0A, $03, $05, $08, $0A, $00
    dw $01F0, $01F4, $01F6, $01F7

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 2 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 4 words, up to its first group).
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_63AA::
Data_00A_63AA:: ; address name
    dw EncounterGroup_63B2 ; id 0
    dw EncounterGroup_63B2 ; id 1
    dw EncounterGroup_63B2 ; id 2
    dw EncounterGroup_63B2 ; id 3

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_63B2::
Data_00A_63B2:: ; address name
    db $03 ; entry 0
    db $0A, $04, $07, $0A, $00, $00
    dw $01F0, $01F5, $01F6

; E-0202 (C1: RunBattleIntroKindCase_Case00 and CollectUniqueEncounterIdsToWD09F_Sub01 pass it in DE with A = 2 to ReadMapCellWordForScreenXY, which reads the word at DE + 2 * (A * (hMapScreenY & $0F) + (hMapScreenX & $0F)); 4 words, up to its first group).
; record: one screen, row by row (2 per row): its encounter group
EncounterGrid_63BF::
Data_00A_63BF:: ; address name
    dw EncounterGroup_63C7 ; id 0
    dw EncounterGroup_63C7 ; id 1
    dw EncounterGroup_63C7 ; id 2
    dw EncounterGroup_63C7 ; id 3

; E-0202 (C1: named by an encounter grid; RunBattleIntroKindCase_Case00_Sub01 draws three times a random 0-127 below byte 1 and stores the word of the first slot whose threshold (bytes 2-6) is not below it in wEncounterMonsters; the record has one word per non-zero threshold).
; record: wEncounterKind + 1; random limit and five slot thresholds; 3 encounter word(s)
EncounterGroup_63C7::
Data_00A_63C7:: ; address name
    db $03 ; entry 0
    db $0A, $03, $07, $0A, $00, $00
    dw $01EF, $01F5, $01F6
    ds $48D, $00

Data_00A_6861:: ; heuristic: target of a monotone pointer table; C0
    ds $A10, $00

Data_00A_7271:: ; heuristic: target of a monotone pointer table; C0
    ds $707, $00

Data_00A_7978:: ; heuristic: target of a monotone pointer table; C0
    ds $404, $00

Data_00A_7D7C:: ; heuristic: target of a monotone pointer table; C0
    ds $202, $00

Data_00A_7F7E:: ; heuristic: target of a monotone pointer table; C0
    ds $82, $00
