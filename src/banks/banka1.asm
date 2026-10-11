SECTION "Bank A1", ROMX[$4000], BANK[$A1]
    db $A1

; A = battle slot: HL = the word for that slot at wBattleATK; A = its low byte (E-0064)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleATK
GetBattleATK_BankA1:: ; heuristic: follows a terminator; C0
Func_0A1_4001:: ; address name
    ld hl, wBattleATK
    jr Jump_0A1_402E
    db $21, $0F, $D9, $18, $23, $21, $CF, $D8, $18, $1E, $21, $EF, $D8, $18, $19, $21
    db $BF, $D8, $18, $14, $21, $DF, $D8, $18, $0F, $21, $1F, $D9, $18, $0A, $21, $53
    db $DA, $85, $6F, $30, $01, $24, $7E, $C9

Jump_0A1_402E::
    add a, a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes appear in 10 banks)
; no direct call (reached through a table, a jump or a vector)
AddDoubleAToHL_BankA1:: ; heuristic: follows a terminator; C0
Func_0A1_4038:: ; address name
    add a, a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the reversal, not checked (E-0064) (the same 27 bytes appear in 10 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole, wBattleActor
ActorOnLocalSide_BankA1:: ; heuristic: follows a terminator; C0
Func_0A1_403F:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr nz, Jump_0A1_4054
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_0A1_4054
    ld a, [wBattleActor]
    cp a, $04
    ccf
    ret

Jump_0A1_4054::
    ld a, [wBattleActor]
    cp a, $04
    ret

; carry set when wBattleTarget < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleTarget >= 4) (E-0064) (the same 27 bytes appear in 10 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole, wBattleTarget
TargetOnLocalSide_BankA1:: ; heuristic: follows a terminator; C0
Func_0A1_405A:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr nz, Jump_0A1_406F
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_0A1_406F
    ld a, [wBattleTarget]
    cp a, $04
    ccf
    ret

Jump_0A1_406F::
    ld a, [wBattleTarget]
    cp a, $04
    ret
    INCBIN "dwm2-cobi-us.gbc", $284075, $CA

; the same instruction sequence as RunBattleCommandEntry (bank $30) apart from label operands, which refer to this bank's own routines and tables; the twin's note describes the shape (E-0107)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_Case01_Case02)
; reads: wTextFlags, wBattleSubPhase
RunBattleCommandEntry_BankA1::
Func_0A1_413F:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wBattleSubPhase]
    rst $00
    dw RunBattleCommandEntry_BankA1_Case00
    dw RunBattleCommandEntry_BankA1_Case01
    dw RunBattleCommandEntry_BankA1_Case02
    dw RunBattleCommandEntry_BankA1_Case03
    dw RunBattleCommandEntry_BankA1_Case04
    dw RunBattleCommandEntry_BankA1_Case05
    dw RunBattleCommandEntry_BankA1_Case06

; entry 0 of the `rst $00` table in RunBattleCommandEntry_BankA1
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte, wBattleActor
; points at: wBattleSubPhase
RunBattleCommandEntry_BankA1_Case00::
Jump_0A1_4156:: ; address name
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wBattleActor], a
    ld bc, $0304
    ld hl, wSlotMarks + $4

Jump_0A1_4164::
    ld a, [hl]
    ld e, $FF
    cp a, $FF
    jr z, Jump_0A1_417F
    ld e, $03
    cp a, $FE
    jr z, Jump_0A1_417F
    cp a, $FD
    jr z, Jump_0A1_417F
    ld e, $03
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_0A1_417F
    ld e, $01

Jump_0A1_417F::
    ld [hl], e
    inc hl
    inc c
    dec b
    jr nz, Jump_0A1_4164
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunBattleCommandEntry_BankA1
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wBattleActor, wBattleResolveStep
; points at: wSlotMarks, wBattleSubPhase
RunBattleCommandEntry_BankA1_Case01::
Jump_0A1_418A:: ; address name
    call NextTableByteSecondStream
    ld a, [wBattleActor]
    cp a, $08
    jr z, Jump_0A1_41BC
    ld e, a
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    cp a, $01
    jr z, Jump_0A1_41A9

Jump_0A1_41A2::
    inc e
    ld a, e
    ld [wBattleActor], a
    jr Jump_0A1_41C2

Jump_0A1_41A9::
    ld a, e
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_0A1_41A2
    ld [wBattleActor], a
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleResolveStep], a
    jr Jump_0A1_41C2

Jump_0A1_41BC::
    ld hl, wBattleSubPhase
    inc [hl]
    inc [hl]
    inc [hl]

Jump_0A1_41C2::
    ret

; entry 2 of the `rst $00` table in RunBattleCommandEntry_BankA1
; no direct call (reached through a table, a jump or a vector)
RunBattleCommandEntry_BankA1_Case02::
Jump_0A1_41C3:: ; address name
    farcall RunBattleResolveStep_43C4
    ret

; entry 3 of the `rst $00` table in RunBattleCommandEntry_BankA1
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wBattleSubPhase
; points at: wBattleTargetChoice, wSlotMarks, wBattleActor
RunBattleCommandEntry_BankA1_Case03::
Jump_0A1_41CA:: ; address name
    farcall ChooseActionTarget
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld d, [hl]
    ld a, [wBattleActor]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $02
    ld a, $01
    ld [wBattleSubPhase], a
    ld hl, wBattleActor
    inc [hl]
    ret

; entry 4 of the `rst $00` table in RunBattleCommandEntry_BankA1
; no direct call (reached through a table, a jump or a vector)
; reads: wLoadSlot
; writes: wActionQueuePos, wLoadSlot, wBattleTemp7A, wBattleTemp7B
; points at: wActionQueue, wBattleArg0, wBattleTemp7D, wSlotMarks, wBattleTemp7A, wLoadSlot, wBattleSubPhase
RunBattleCommandEntry_BankA1_Case04::
Jump_0A1_41F4:: ; address name
    ld hl, wActionQueue
    ld bc, $0009
    ld a, $FF
    call FillBytes
    ld hl, wBattleArg0
    ld bc, $0009
    ld a, $FF
    call FillBytes
    ld hl, wBattleTemp7D
    ld bc, $0012
    ld a, $00
    call FillBytes
    xor a, a
    ld [wActionQueuePos], a
    ld [wLoadSlot], a
    ld hl, wBattleTemp7D
    ld a, l
    ld [wBattleTemp7A], a
    ld a, h
    ld [wBattleTemp7B], a
    ld de, $0800

Jump_0A1_422A::
    ld a, e
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_0A1_4266
    ld a, e
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    cp a, $02
    jr nz, Jump_0A1_4266
    ld a, e
    call RunBattleCommandEntry_BankA1_Case04_Sub01
    call RunBattleCommandEntry_BankA1_Case04_Sub02
    ld hl, wBattleTemp7A
    deref_hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wLoadSlot]
    ld hl, wBattleArg0
    add_a_to_hl
    ld [hl], e
    ld hl, wLoadSlot
    inc [hl]
    ld hl, wBattleTemp7A
    inc [hl]
    ld hl, wBattleTemp7A
    inc [hl]

Jump_0A1_4266::
    inc e
    dec d
    jp nz, Jump_0A1_422A
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunBattleCommandEntry_BankA1
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTemp7A, wBattleTemp7B, wBattleDamageLo, wBattleDamageHi, wTargetEstimates, wActionQueuePos
; writes: wBattleTemp7A, wBattleTemp7B, wBattleDamageLo, wBattleDamageHi, wTargetEstimates, wActionQueuePos
; points at: wBattleTemp7D, wBattleTemp7F, wBattleArg0, wBattleTemp7A, wActionQueue, wBattleSubPhase
RunBattleCommandEntry_BankA1_Case05::
Jump_0A1_4270:: ; address name
    ld d, $08

Jump_0A1_4272::
    ld hl, wBattleTemp7D
    ld a, l
    ld [wBattleTemp7A], a
    ld a, h
    ld [wBattleTemp7B], a
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld hl, wBattleTemp7F
    deref_hl
    ld e, $00

Jump_0A1_4288::
    call CompareHLToBC
    jr c, Jump_0A1_42C2
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ld a, c
    ld [wTargetEstimates], a
    ld a, b
    ld [wTargetEstimates + $1], a
    ld a, [wBattleTemp7A]
    ld l, a
    ld a, [wBattleTemp7B]
    ld h, a
    ld a, [wBattleDamageLo]
    ld [hl+], a
    ld a, [wBattleDamageHi]
    ld [hl+], a
    ld a, [wTargetEstimates]
    ld [hl+], a
    ld a, [wTargetEstimates + $1]
    ld [hl], a
    ld a, e
    ld hl, wBattleArg0
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld [hl-], a
    ld [hl], b

Jump_0A1_42C2::
    inc e
    ld a, e
    cp a, d
    jr z, Jump_0A1_42DB
    ld hl, wBattleTemp7A
    inc [hl]
    ld hl, wBattleTemp7A
    inc [hl]
    deref_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    inc hl
    deref_hl
    jr Jump_0A1_4288

Jump_0A1_42DB::
    dec d
    jr nz, Jump_0A1_4272
    ld a, [wActionQueuePos]
    ld de, wActionQueue
    add a, e
    ld e, a
    jr nc, Jump_0A1_42E9
    inc d

Jump_0A1_42E9::
    ld a, [wActionQueuePos]
    ld hl, wBattleArg0
    ld b, $09

Jump_0A1_42F1::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_0A1_42FB
    ld [de], a
    inc de
    dec b
    jr nz, Jump_0A1_42F1

Jump_0A1_42FB::
    ld a, $00
    ld [wActionQueuePos], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunBattleCommandEntry_BankA1
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleCommandArgs, wBattleSubPhase
; points at: wBattleHP, wBattleMaxHP, wBattleStep, wBattleResolveStep
RunBattleCommandEntry_BankA1_Case06::
Jump_0A1_4305:: ; address name
    ld hl, wBattleHP
    ld bc, $0000
    call AddWordAtHLToBC_BankA1
    call AddWordAtHLToBC_BankA1
    call AddWordAtHLToBC_BankA1
    ld a, c
    ld [wBattleCommandArgs], a
    ld a, b
    ld [wBattleCommandArgs + $1], a
    ld hl, wBattleMaxHP
    ld bc, $0000
    call AddWordAtHLToBC_BankA1
    call AddWordAtHLToBC_BankA1
    call AddWordAtHLToBC_BankA1
    ld a, c
    ld [wBattleCommandArgs + $2], a
    ld a, b
    ld [wBattleCommandArgs + $3], a
    ld hl, wBattleStep
    inc [hl]
    xor a, a
    ld [wBattleSubPhase], a
    xor a, a
    ld hl, wBattleResolveStep
    ld bc, $0005
    call FillBytes
    farcall SaveActionChoicesAndPickFormations
    call RunBattleCommandEntry_BankA1_Case06_Sub01
    ret

; BC += the word at [HL]; HL += 2; clobbers A (the same 7 bytes appear in 2 banks)
; 6 call sites from 1 routine (e.g. RunBattleCommandEntry_BankA1_Case06)
AddWordAtHLToBC_BankA1::
Func_0A1_434F:: ; address name
    ld a, [hl+]
    add a, c
    ld c, a
    ld a, [hl+]
    adc a, b
    ld b, a
    ret

; only called from RunBattleCommandEntry_BankA1_Case06 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleCommandEntry_BankA1_Case06)
; points at: wBattleActionChoice, wBattleStatus6
RunBattleCommandEntry_BankA1_Case06_Sub01::
Func_0A1_4356:: ; address name
    ld c, $00
    ld b, $08

Jump_0A1_435A::
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_0A1_4378
    ld a, c
    add a, a
    ld hl, wBattleActionChoice
    add_a_to_hl
    ld a, [hl]
    cp a, $6E
    jr nz, Jump_0A1_4378
    ld a, c
    ld hl, wBattleStatus6
    call AddAx9ToHL
    set 2, [hl]

Jump_0A1_4378::
    inc c
    dec b
    jr nz, Jump_0A1_435A
    ret

; only called from RunBattleCommandEntry_BankA1_Case04 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleCommandEntry_BankA1_Case04)
; points at: wBattleAGL
RunBattleCommandEntry_BankA1_Case04_Sub01::
Func_0A1_437D:: ; address name
    push de
    call NextTableByteSecondStream
    ld a, e
    ld hl, wBattleAGL
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    push bc
    ld a, $03
    call Multiply8By16
    ld a, $0A
    call Divide24ByA
    pop bc
    call RandomInRange
    ld c, e
    ld b, d
    pop de
    ret

; only called from RunBattleCommandEntry_BankA1_Case04 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleCommandEntry_BankA1_Case04)
; reads: wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3, wRecordBufferData, wRandomLo
; writes: wRecordBuffer, wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3
; points at: wBattleActionChoice
RunBattleCommandEntry_BankA1_Case04_Sub02::
Func_0A1_43A1:: ; address name
    push de
    ld a, e
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $62
    jr z, Jump_0A1_4413
    cp a, $69
    jr z, Jump_0A1_441D
    cp a, $D8
    jr z, Jump_0A1_4413
    push af
    push bc
    push de
    push hl
    ld [wRecordBuffer], a
    xor a, a
    ld [wRecordBuffer + $1], a
    ld a, [wBattleArg0]
    ld l, a
    ld a, [wBattleArg1]
    ld h, a
    push hl
    ld a, [wBattleArg2]
    ld l, a
    ld a, [wBattleArg3]
    ld h, a
    push hl
    ld a, $05
    ld [wBattleArg0], a
    ld a, $01
    ld [wBattleArg1], a
    ld hl, wRecordBufferData + $5
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    farcall LoadSkillRecordPart
    pop hl
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    pop hl
    ld a, l
    ld [wBattleArg0], a
    ld a, h
    ld [wBattleArg1], a
    pop hl
    pop de
    pop bc
    pop af
    ld a, [wRecordBufferData + $5]
    bit 2, a
    jr nz, Jump_0A1_4418
    ld hl, $000A
    jr Jump_0A1_4430

Jump_0A1_4413::
    ld hl, $0BB8
    jr Jump_0A1_4430

Jump_0A1_4418::
    ld hl, $07D0
    jr Jump_0A1_4430

Jump_0A1_441D::
    call NextTableByteSecondStream
    ld a, [wRandomLo]
    ld b, a
    ld a, $09
    call DivideBByA
    add a, $01
    ld c, a
    ld b, $00
    jr Jump_0A1_4433

Jump_0A1_4430::
    add hl, bc
    ld c, l
    ld b, h

Jump_0A1_4433::
    pop de
    ret

; on map type $80 sets the bit for the current map screen in the visited-screen bitmap wCE93 (E-0125)
; 6 call sites from 3 routines (e.g. MarkVisitedScreens5x5AroundPlayer, RunFieldActionRequestActionIfBit7_Case01, RunMenuStateMenuState_Case05)
; reads: wMapType, hMapScreenY, hMapScreenX
; points at: wVisitedScreens
MarkVisitedMapScreenInVisitedScreens::
Func_0A1_4435:: ; address name
    ld a, [wMapType]
    bit 7, a
    ret z
    cp a, $80
    ret nz
    ldh a, [hMapScreenY]
    and a, $FC
    ld hl, wVisitedScreens
    add_a_to_hl
    ldh a, [hMapScreenX]
    srl a
    and a, $FE
    add_a_to_hl
    ldh a, [hMapScreenY]
    bit 1, a
    jr z, Jump_0A1_445C
    inc hl

Jump_0A1_445C::
    ld c, $01
    bit 0, a
    jr z, Jump_0A1_4464
    ld c, $10

Jump_0A1_4464::
    ldh a, [hMapScreenX]
    and a, $03
    jr z, Jump_0A1_4470
    ld b, a

Jump_0A1_446B::
    sla c
    dec b
    jr nz, Jump_0A1_446B

Jump_0A1_4470::
    ld a, [hl]
    or a, c
    ld [hl], a
    ret

; only called from RunMenuStateMenuState_Case05 (E-0047)
; 1 call site from 1 routine (e.g. RunMenuStateMenuState_Case05)
; reads: wKeyWorldFloor
; points at: wKeyWorldAreaExits, wVisitedScreens
RunMenuStateMenuState_Case05_Sub02::
Func_0A1_4474:: ; address name
    ld hl, wKeyWorldAreaExits
    ld a, [wKeyWorldFloor]
    bit 7, a
    jr z, Jump_0A1_447F
    inc hl

Jump_0A1_447F::
    and a, $0F
    add a, a
    add a, a
    add_a_to_hl
    ld a, [hl]
    push af
    and a, $0F
    and a, $FC
    ld hl, wVisitedScreens
    add_a_to_hl
    pop af
    push af
    swap a
    and a, $0F
    srl a
    and a, $FE
    add_a_to_hl
    pop af
    push af
    and a, $0F
    bit 1, a
    jr z, Jump_0A1_44AE
    inc hl

Jump_0A1_44AE::
    ld c, $01
    bit 0, a
    jr z, Jump_0A1_44B6
    ld c, $10

Jump_0A1_44B6::
    pop af
    swap a
    and a, $0F
    and a, $03
    jr z, Jump_0A1_44C5
    ld b, a

Jump_0A1_44C0::
    sla c
    dec b
    jr nz, Jump_0A1_44C0

Jump_0A1_44C5::
    ld a, [hl]
    or a, c
    ld [hl], a
    ret

; marks the 5 x 5 map screens around the current one (within wCD0D x wCD0E) as visited (E-0127)
; 1 call site from 1 routine (e.g. Func_016_53E6_Case13)
; reads: hMapScreenX, hMapScreenY, wKeyWorldHeight, wKeyWorldWidth, hTemp0, hTemp1
; writes: hTemp0, hMapScreenX, hTemp1, hMapScreenY
; points at: hMapScreenX, hMapScreenY
MarkVisitedScreens5x5AroundPlayer::
Func_0A1_44C9:: ; address name
    ldh a, [hMapScreenX]
    ldh [hTemp0], a
    dec a
    dec a
    ldh [hMapScreenX], a
    ldh a, [hMapScreenY]
    ldh [hTemp1], a
    dec a
    dec a
    ldh [hMapScreenY], a
    ld c, $05

Jump_0A1_44DB::
    ld b, $05

Jump_0A1_44DD::
    ld a, [wKeyWorldHeight]
    ld d, a
    ldh a, [hMapScreenY]
    bit 7, a
    jr nz, Jump_0A1_4503
    cp a, d
    jr nc, Jump_0A1_4503
    ld a, [wKeyWorldWidth]
    ld d, a
    ldh a, [hMapScreenX]
    bit 7, a
    jr nz, Jump_0A1_44FC
    cp a, d
    jr nc, Jump_0A1_44FC
    push bc
    call MarkVisitedMapScreenInVisitedScreens
    pop bc

Jump_0A1_44FC::
    ld hl, hMapScreenX
    inc [hl]
    dec b
    jr nz, Jump_0A1_44DD

Jump_0A1_4503::
    ldh a, [hTemp0]
    sub a, $02
    ldh [hMapScreenX], a
    ld hl, hMapScreenY
    inc [hl]
    dec c
    jr nz, Jump_0A1_44DB
    ldh a, [hTemp0]
    ldh [hMapScreenX], a
    ldh a, [hTemp1]
    ldh [hMapScreenY], a
    ret

; runs the routine for wC5DD & 7 (field mode state 8; jump table, 3 reuses 0) (E-0122)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case08)
; reads: wGameMode2State
RunGameMode2State::
Func_0A1_4519:: ; address name
    ld a, [wGameMode2State]
    and a, $07
    rst $00
    dw RunGameMode2State_Case00
    dw RunGameMode2State_Case01
    dw RunGameMode2State_Case02
    dw RunGameMode2State_Case00
    dw RunGameMode2State_Case04
    dw RunGameMode2State_Case05
    dw RunGameMode2State_Case06

; entry 4 of the `rst $00` table in RunGameMode2State
; no direct call (reached through a table, a jump or a vector)
; reads: wMapType, wIsCGB
; writes: hScrollX, hScrollY, wOBJPaletteUploadRequest, wBGPaletteUploadRequest
; points at: wDMGPaletteBGP, wOBJPaletteBuffer, wBGPaletteBuffer, wGameMode2State
RunGameMode2State_Case04::
Jump_0A1_452D:: ; address name
    xor a, a
    ldh [hScrollX], a
    ldh [hScrollY], a
    call CopyScrollToHardware
    ld de, Data_07E_4EB3
    ld b, $7E
    ld hl, vTiles0
    call DecompressToVRAM
    ld de, Data_07E_5B27
    ld b, $7E
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld de, Data_07E_5B46
    ld b, $7E
    ld hl, vTiles0 + $200
    call DecompressToVRAM
    ld de, Data_05D_43AE
    ld b, $5D
    ld hl, vTiles2
    call DecompressToVRAM
    call FillBGMap0With57
    call RunGameMode2State_Case04_Sub03
    ld a, [wMapType]
    bit 7, a
    jr nz, Jump_0A1_4573
    call RunGameMode2State_Case04_Sub02
    jr Jump_0A1_4576

Jump_0A1_4573::
    call RunGameMode2State_Case04_Sub01

Jump_0A1_4576::
    ld hl, wDMGPaletteBGP
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_0A1_45C0
    ld a, $40
    ld de, Data_07E_4BBD
    add a, e
    ld e, a
    jr nc, Jump_0A1_4592
    inc d

Jump_0A1_4592::
    ld b, $7E
    ld hl, wOBJPaletteBuffer
    ld c, $08
    call CopyFromBank
    ld de, Palettes_7E_5AF6
    ld b, $7E
    ld hl, wOBJPaletteBuffer + $8
    ld c, $10
    call CopyFromBank
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ld de, Palettes_5D_4565
    ld b, $5D
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBank
    ld a, $7F
    ld [wBGPaletteUploadRequest], a

Jump_0A1_45C0::
    ld hl, wGameMode2State
    inc [hl]
    ret

; only called from RunGameMode2State_Case04 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case04)
; reads: hTemp5, hTemp7, hTempA, hTemp3, hTemp8, hTemp4, hTemp9, hTemp6
; writes: hTemp9, hTempA, hTemp8, hTemp6
RunGameMode2State_Case04_Sub01::
Func_0A1_45C5:: ; address name
    call RunGameMode2State_Case04_Sub01_Sub02
    call StoreTemp5ValuesToCursorCellX
    ld hl, vBGMap0
    ld c, $12

Jump_0A1_45D0::
    push hl
    ldh a, [hTemp5]
    ldh [hTemp9], a
    ldh a, [hTemp7]
    ldh [hTempA], a
    ld b, $14

Jump_0A1_45DB::
    push bc
    push hl
    ldh a, [hTempA]
    bit 7, a
    jr nz, Jump_0A1_4610
    ld c, a
    ldh a, [hTemp3]
    dec a
    cp a, c
    jr c, Jump_0A1_4610
    ldh a, [hTemp8]
    bit 7, a
    jr nz, Jump_0A1_4610
    ld c, a
    ldh a, [hTemp4]
    dec a
    cp a, c
    jr c, Jump_0A1_4610
    push bc
    ldh a, [hTempA]
    and a, $0F
    swap a
    ld c, a
    ldh a, [hTemp8]
    and a, $0F
    or a, c
    pop bc
    push de
    call IsMapScreenAVisited
    pop de
    or a, a
    jr z, Jump_0A1_4610
    call RunGameMode2State_Case04_Sub01_Sub01

Jump_0A1_4610::
    ldh a, [hTemp9]
    inc a
    cp a, $05
    jr nz, Jump_0A1_461D
    ldh a, [hTempA]
    inc a
    ldh [hTempA], a
    xor a, a

Jump_0A1_461D::
    ldh [hTemp9], a
    pop hl
    inc hl
    pop bc
    dec b
    jr nz, Jump_0A1_45DB
    ldh a, [hTemp6]
    inc a
    cp a, $05
    jr nz, Jump_0A1_4632
    ldh a, [hTemp8]
    inc a
    ldh [hTemp8], a
    xor a, a

Jump_0A1_4632::
    ldh [hTemp6], a
    pop hl
    ld a, $20
    add_a_to_hl
    dec c
    jr nz, Jump_0A1_45D0
    ret

; only called from RunGameMode2State_Case04_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case04_Sub01)
; reads: hTemp8, hTempA, hTemp6, hTemp9
; writes: hTemp0, hTemp1
RunGameMode2State_Case04_Sub01_Sub01::
Func_0A1_4640:: ; address name
    push hl
    ldh a, [hTemp8]
    and a, $FC
    add a, a
    ld l, a
    ld h, $00
    ldh a, [hTempA]
    and a, $FC
    add_a_to_hl
    ld a, l
    add a, $60
    ld l, a
    ld a, h
    adc a, $CD
    ld h, a
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld b, a
    push bc
    ld a, [hl]
    ld c, $60
    call Multiply8
    add hl, de
    pop bc
    ldh a, [hTemp8]
    and a, $03
    ld c, a
    sla a
    add a, c
    sla a
    sla a
    add_a_to_hl
    ldh a, [hTempA]
    and a, $03
    ld c, a
    sla a
    add a, c
    add_a_to_hl
    ld e, l
    ld d, h
    call ReadByteInBank
    ld l, c
    inc de
    call ReadByteInBank
    ld h, c
    inc de
    call ReadByteInBank
    ld b, c
    ld e, l
    ld d, h
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    call ReadByteInBank
    ld l, c
    inc de
    call ReadByteInBank
    ld h, c
    dec hl
    ld c, l
    ld b, h
    ld a, $19
    call Multiply8By16
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ldh a, [hTemp6]
    ld c, a
    sla a
    sla a
    add a, c
    add_a_to_hl
    ldh a, [hTemp9]
    add_a_to_hl
    ld a, l
    add a, $A0
    ld l, a
    ld a, h
    adc a, $43
    ld h, a
    ld e, l
    ld d, h
    ld b, $5E
    call ReadByteInBank
    pop hl
    ld a, c
    call WriteVRAMByte
    ret

; only called from RunGameMode2State_Case04_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case04_Sub01)
; reads: hPlayerX, hMapScreenX, hPlayerY, hMapScreenY, wKeyWorldWidth, wKeyWorldHeight
; writes: hTemp3, hTemp4, hTemp7, hTemp8, hTemp5, hTemp6, hPlayerY, hMapScreenY, ...
; points at: hTemp7, hTemp8
RunGameMode2State_Case04_Sub01_Sub02::
Func_0A1_46DF:: ; address name
    ldh a, [hPlayerX]
    ld l, a
    ldh a, [hMapScreenX]
    ld h, a
    push hl
    ldh a, [hPlayerY]
    ld l, a
    ldh a, [hMapScreenY]
    ld h, a
    push hl
    call RunMapType_A1_4744
    ld a, [wKeyWorldWidth]
    ldh [hTemp3], a
    ld a, [wKeyWorldHeight]
    ldh [hTemp4], a
    ldh a, [hMapScreenX]
    dec a
    dec a
    ldh [hTemp7], a
    ldh a, [hMapScreenY]
    dec a
    dec a
    ldh [hTemp8], a
    ldh a, [hPlayerX]
    swap a
    and a, $0F
    srl a
    inc a
    cp a, $05
    jr c, Jump_0A1_471B
    sub a, $05
    push af
    ld hl, hTemp7
    inc [hl]
    pop af

Jump_0A1_471B::
    ldh [hTemp5], a
    ldh a, [hPlayerY]
    swap a
    and a, $0F
    srl a
    inc a
    inc a
    cp a, $05
    jr c, Jump_0A1_4733
    sub a, $05
    push af
    ld hl, hTemp8
    inc [hl]
    pop af

Jump_0A1_4733::
    ldh [hTemp6], a
    pop hl
    ld a, l
    ldh [hPlayerY], a
    ld a, h
    ldh [hMapScreenY], a
    pop hl
    ld a, l
    ldh [hPlayerX], a
    ld a, h
    ldh [hMapScreenX], a
    ret

; runs the routine for wCC44 & 7 (jump table) (E-0122)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case04_Sub01_Sub02)
; reads: wMapType
RunMapType_A1_4744::
Func_0A1_4744:: ; address name
    ld a, [wMapType]
    and a, $07
    rst $00
    dw RunMapType_A1_4744_Case00
    dw RunMapType_A1_4744_Case01
    dw RunMapType_A1_4744_Case01
    dw RunMapType_A1_4744_Case03
    dw RunMapType_A1_4744_Case03
    dw RunMapType_A1_4744_Case03
    dw RunMapType_A1_4744_Case03
    dw RunMapType_A1_4744_Case07

; entry 0 of the `rst $00` table in RunMapType_A1_4744
; no direct call (reached through a table, a jump or a vector)
RunMapType_A1_4744_Case00::
Jump_0A1_475A:: ; address name
    ret

; entry 1 of the `rst $00` table in RunMapType_A1_4744
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldFloor
; writes: hMapScreenX, hMapScreenY, hPlayerX, hPlayerY
; points at: wKeyWorldAreaExits
RunMapType_A1_4744_Case01::
Jump_0A1_475B:: ; address name
    ld a, [wKeyWorldFloor]
    and a, $07
    add a, a
    add a, a
    ld hl, wKeyWorldAreaExits
    add_a_to_hl
    ld a, [wKeyWorldFloor]
    bit 7, a
    jr z, Jump_0A1_4772
    inc hl

Jump_0A1_4772::
    ld a, [hl]
    jr SetMapScreenFromAAndCenterPlayer

; entry 3 of the `rst $00` table in RunMapType_A1_4744
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldFloor
; writes: hMapScreenX, hMapScreenY, hPlayerX, hPlayerY
; points at: wKeyWorldFloorInfo
RunMapType_A1_4744_Case03::
Jump_0A1_4775:: ; address name
    ld a, [wKeyWorldFloor]
    and a, $07
    add a, a
    add a, a
    ld hl, wKeyWorldFloorInfo
    add_a_to_hl
    ld a, [hl]
    jr SetMapScreenFromAAndCenterPlayer

; entry 7 of the `rst $00` table in RunMapType_A1_4744
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldActive, wKeyWorldKey, wKeyWorldSlot, wKeyWorldGoalCell, wKeyWorldGoal, wKeyWorldGoalScreen, wKeyWorldGoalPos, wKeyWorldGoalPos2
; writes: hPlayerX, hPlayerY
RunMapType_A1_4744_Case07::
Jump_0A1_4787:: ; address name
    ld a, [wKeyWorldActive]
    or a, a
    jr z, Jump_0A1_47B4
    ld a, [wKeyWorldKey]
    bit 7, a
    jr z, Jump_0A1_47B4
    and a, $7F
    ld c, a
    ld a, [wKeyWorldSlot]
    cp a, c
    jr nz, Jump_0A1_47B4
    ld a, [wKeyWorldGoalCell]
    call SetMapScreenFromAAndCenterPlayer
    ld a, [wKeyWorldGoal]
    and a, $F0
    ldh [hPlayerX], a
    ld a, [wKeyWorldGoal]
    and a, $0F
    swap a
    ldh [hPlayerY], a
    ret

Jump_0A1_47B4::
    ld a, [wKeyWorldGoalScreen]
    call SetMapScreenFromAAndCenterPlayer
    ld a, [wKeyWorldGoalPos]
    ldh [hPlayerX], a
    ld a, [wKeyWorldGoalPos2]
    ldh [hPlayerY], a
    ret

; hMapScreenX = A >> 4, hMapScreenY = A & $0F, hPlayerX = hPlayerY = $40 (E-0118)
; 2 call sites from 1 routine (e.g. RunMapType_A1_4744_Case07)
; writes: hMapScreenX, hMapScreenY, hPlayerX, hPlayerY
SetMapScreenFromAAndCenterPlayer::
Func_0A1_47C5:: ; address name
    push af
    swap a
    and a, $0F
    ldh [hMapScreenX], a
    pop af
    and a, $0F
    ldh [hMapScreenY], a
    ld a, $40
    ldh [hPlayerX], a
    ldh [hPlayerY], a
    ret

; only called from RunGameMode2State_Case04 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case04)
; reads: hTemp0, hTemp1, hTemp5, hTemp7, hTempA, hTemp3, hTemp8, hTemp4, ...
; writes: hTemp9, hTempA, hTemp8, hTemp6
RunGameMode2State_Case04_Sub02::
Func_0A1_47D8:: ; address name
    call RunGameMode2State_Case04_Sub02_Sub01
    call StoreTemp5ValuesToCursorCellX
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld hl, vBGMap0
    ld c, $12

Jump_0A1_47E9::
    push hl
    push de
    ldh a, [hTemp5]
    ldh [hTemp9], a
    ldh a, [hTemp7]
    ldh [hTempA], a
    ld b, $14

Jump_0A1_47F5::
    push bc
    push hl
    ldh a, [hTempA]
    bit 7, a
    jr nz, Jump_0A1_481B
    ld c, a
    ldh a, [hTemp3]
    dec a
    cp a, c
    jr c, Jump_0A1_481B
    ldh a, [hTemp8]
    bit 7, a
    jr nz, Jump_0A1_481B
    ld c, a
    ldh a, [hTemp4]
    dec a
    cp a, c
    jr c, Jump_0A1_481B
    ldh a, [hTemp2]
    ld b, a
    call ReadByteInBank
    ld a, c
    call WriteVRAMByte

Jump_0A1_481B::
    inc de
    ldh a, [hTemp9]
    inc a
    cp a, $05
    jr nz, Jump_0A1_4831
    ldh a, [hTempA]
    inc a
    ldh [hTempA], a
    ld a, e
    add a, $14
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    xor a, a

Jump_0A1_4831::
    ldh [hTemp9], a
    pop hl
    inc hl
    pop bc
    dec b
    jr nz, Jump_0A1_47F5
    pop de
    ld a, $05
    add a, e
    ld e, a
    jr nc, Jump_0A1_4841
    inc d

Jump_0A1_4841::
    ldh a, [hTemp6]
    inc a
    cp a, $05
    jr nz, Jump_0A1_4865
    ldh a, [hTemp8]
    inc a
    ldh [hTemp8], a
    push bc
    ldh a, [hTemp3]
    ld c, a
    ld a, $19
    push de
    call Multiply8
    pop de
    add hl, de
    ld e, l
    ld d, h
    ld a, e
    sub a, $19
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    pop bc
    xor a, a

Jump_0A1_4865::
    ldh [hTemp6], a
    pop hl
    ld a, $20
    add_a_to_hl
    dec c
    jp nz, Jump_0A1_47E9
    ret

; only called from RunGameMode2State_Case04_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case04_Sub02)
; reads: hPlayerX, hMapScreenX, hPlayerY, hMapScreenY, wGameMode2Byte44, hMapId, hTemp0, hTemp1, ...
; writes: hTemp3, hTemp4, hTemp0, hTemp1, hTemp2, hTemp7, hTemp8, hTemp5, ...
; points at: hTemp7, hTemp8
RunGameMode2State_Case04_Sub02_Sub01::
Func_0A1_4874:: ; address name
    ldh a, [hPlayerX]
    ld l, a
    ldh a, [hMapScreenX]
    ld h, a
    push hl
    ldh a, [hPlayerY]
    ld l, a
    ldh a, [hMapScreenY]
    ld h, a
    push hl
    call RunGameMode2State_Case04_Sub02_Sub01_Sub01
    ld a, [wGameMode2Byte44]
    add a, a
    add a, a
    ld hl, WorldMapScreenCellTable
    add_a_to_hl
    ld a, [hl]
    swap a
    and a, $0F
    ldh [hTemp3], a
    ld a, [hl+]
    and a, $0F
    ldh [hTemp4], a
    ld a, [hl+]
    ldh [hTemp0], a
    ld a, [hl+]
    ldh [hTemp1], a
    ld a, [hl]
    ldh [hTemp2], a
    ldh a, [hMapScreenX]
    ld c, a
    ldh a, [hMapId]
    ld b, a
    ld b, $00
    dec bc
    dec bc
    ld a, c
    ldh [hTemp7], a
    ld a, $19
    call Multiply8By16
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    add hl, de
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ldh a, [hMapScreenY]
    ld c, a
    ldh a, [hPlayerSpriteOverride]
    ld b, a
    ld b, $00
    dec bc
    dec bc
    ld a, c
    ldh [hTemp8], a
    ldh a, [hTemp3]
    call Multiply8By16
    ld c, l
    ld b, h
    ld a, $19
    call Multiply8By16
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    add hl, de
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ldh a, [hPlayerX]
    swap a
    and a, $0F
    srl a
    inc a
    cp a, $05
    jr c, Jump_0A1_4915
    sub a, $05
    push af
    ld hl, hTemp7
    inc [hl]
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, l
    add a, $19
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    pop af

Jump_0A1_4915::
    ldh [hTemp5], a
    push af
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    pop af
    add_a_to_hl
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ldh a, [hPlayerY]
    swap a
    and a, $0F
    srl a
    inc a
    inc a
    cp a, $05
    jr c, Jump_0A1_4954
    sub a, $05
    push af
    ld hl, hTemp8
    inc [hl]
    ldh a, [hTemp3]
    ld c, $19
    call Multiply8
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    add hl, de
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    pop af

Jump_0A1_4954::
    ldh [hTemp6], a
    ld c, a
    add a, a
    add a, a
    add a, c
    push af
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    pop af
    add_a_to_hl
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    pop hl
    ld a, l
    ldh [hPlayerY], a
    ld a, h
    ldh [hMapScreenY], a
    pop hl
    ld a, l
    ldh [hPlayerX], a
    ld a, h
    ldh [hMapScreenX], a
    ret

; E-0185 (C1: RunGameMode2State_Case04_Sub02_Sub01 reads the record at $497C + 4 * wGameMode2Byte44: width and height from the nibbles of byte 0, then a 24-bit pointer; it adds (hMapScreenX - 2) * 25 and (hMapScreenY - 2) * width * 25, then steps 5 cells per row; each grid is exactly width * height * 25 bytes and the 11 grids fill bank $5D from $45A5 to $7692).
; record: size nibbles (width, height in screens); pointer and bank of the 25-byte-per-screen cell grid
WorldMapScreenCellTable::
Data_0A1_497C:: ; address name
    db $88 ; id 0
    dfar WorldMapScreenCells0
    db $88 ; id 1
    dfar WorldMapScreenCells1
    db $CC ; id 2
    dfar WorldMapScreenCells2
    db $CC ; id 3
    dfar WorldMapScreenCells3
    db $43 ; id 4
    dfar WorldMapScreenCells4
    db $66 ; id 5
    dfar WorldMapScreenCells5
    db $32 ; id 6
    dfar WorldMapScreenCells6
    db $55 ; id 7
    dfar WorldMapScreenCells7
    db $12 ; id 8
    dfar WorldMapScreenCells8
    db $12 ; id 9
    dfar WorldMapScreenCells9
    db $21 ; id 10
    dfar WorldMapScreenCells10

; only called from RunGameMode2State_Case04_Sub02_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case04_Sub02_Sub01)
; reads: hMapId, wLastWarpIndex, wGameMode2Byte44, wKeyWorldActive, wKeyWorldKey, wKeyWorldGoalCell, wKeyWorldGoal
; writes: hMapScreenX, hMapScreenY, hPlayerX, hPlayerY
RunGameMode2State_Case04_Sub02_Sub01_Sub01::
Func_0A1_49A8:: ; address name
    ldh a, [hMapId]
    ld c, $01
    cp a, $29
    jp z, Jump_0A1_4A31
    ld c, $02
    cp a, $45
    jp z, Jump_0A1_4A31
    ld c, $03
    cp a, $68
    jp z, Jump_0A1_4A31
    ld c, $04
    cp a, $9D
    jp z, Jump_0A1_4A31
    ld c, $05
    cp a, $A4
    jp z, Jump_0A1_4A31
    ld c, $06
    cp a, $AF
    jp z, Jump_0A1_4A31
    ld c, $07
    cp a, $B2
    jp z, Jump_0A1_4A31
    ld c, $08
    cp a, $C5
    jr z, Jump_0A1_4A31
    ld c, $09
    cp a, $D0
    jr z, Jump_0A1_4A31
    ld c, $0A
    cp a, $D9
    jr z, Jump_0A1_4A31
    ld c, $0B
    cp a, $E2
    jr z, Jump_0A1_4A31
    cp a, $20
    ret z
    cp a, $30
    ret z
    cp a, $48
    ret z
    cp a, $70
    ret z
    cp a, $A0
    ret z
    cp a, $A8
    ret z
    cp a, $B0
    ret z
    cp a, $B8
    ret z
    cp a, $C8
    ret z
    cp a, $D1
    ret z
    cp a, $DA
    ret z
    ld c, a
    ld hl, $5D80

Jump_0A1_4A18::
    ld a, [hl]
    cp a, c
    jr z, Jump_0A1_4A23
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_0A1_4A18

Jump_0A1_4A23::
    ld a, [wLastWarpIndex]
    dec a
    dec a
    jr nz, Jump_0A1_4A2C
    inc hl
    inc hl

Jump_0A1_4A2C::
    inc hl
    call LoadMapPositionFromHL
    ret

Jump_0A1_4A31::
    ld a, [wGameMode2Byte44]
    inc a
    ld c, a
    ld a, [wKeyWorldActive]
    or a, a
    jr z, Jump_0A1_4A67
    ld a, [wKeyWorldKey]
    bit 7, a
    jr nz, Jump_0A1_4A67
    cp a, c
    jr nz, Jump_0A1_4A67
    ld a, [wKeyWorldGoalCell]
    swap a
    and a, $0F
    ldh [hMapScreenX], a
    ld a, [wKeyWorldGoalCell]
    and a, $0F
    ldh [hMapScreenY], a
    ld a, [wKeyWorldGoal]
    and a, $F0
    ldh [hPlayerX], a
    ld a, [wKeyWorldGoal]
    and a, $0F
    swap a
    ldh [hPlayerY], a
    ret

Jump_0A1_4A67::
    ld a, c
    dec a
    add a, a
    add a, a
    ld hl, $59D6
    add_a_to_hl
    call LoadMapPositionFromHL
    ret

; hMapScreenX/Y = the nibbles of [HL]; hPlayerX = [HL + 1] & $F0, hPlayerY = ([HL + 1] & $0F) << 4 (E-0118)
; 2 call sites from 1 routine (e.g. RunGameMode2State_Case04_Sub02_Sub01_Sub01)
; writes: hMapScreenX, hMapScreenY, hPlayerX, hPlayerY
LoadMapPositionFromHL::
Func_0A1_4A77:: ; address name
    ld a, [hl]
    swap a
    and a, $0F
    ldh [hMapScreenX], a
    ld a, [hl]
    and a, $0F
    ldh [hMapScreenY], a
    inc hl
    ld a, [hl]
    and a, $F0
    ldh [hPlayerX], a
    ld a, [hl]
    and a, $0F
    swap a
    ldh [hPlayerY], a
    ret

; wC945 = hFFCB, wC946 = hFFCD, wC947 = hFFCC, wC948 = hFFCE (E-0118)
; 2 call sites from 2 routines (e.g. RunGameMode2State_Case04_Sub02, RunGameMode2State_Case04_Sub01)
; reads: hTemp5, hTemp7, hTemp6, hTemp8
; writes: wCursorCellX, wCursorCellY, wCursorCellW, wCursorCellH
StoreTemp5ValuesToCursorCellX::
Func_0A1_4A91:: ; address name
    ldh a, [hTemp5]
    ld [wCursorCellX], a
    ldh a, [hTemp7]
    ld [wCursorCellY], a
    ldh a, [hTemp6]
    ld [wCursorCellW], a
    ldh a, [hTemp8]
    ld [wCursorCellH], a
    ret

; entry 5 of the `rst $00` table in RunGameMode2State
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wIsCGB
; writes: wBGPaletteUploadRequest, wOBJPaletteUploadRequest
; points at: wDMGPaletteBGP, wBGPaletteBuffer, wGameMode2State
RunGameMode2State_Case05::
Jump_0A1_4AA6:: ; address name
    ld a, [wJoypadPressed]
    bit 1, a
    jr nz, RunGameMode2State_Case02_Sub01
    bit 2, a
    jr z, Jump_0A1_4ADC

; only called from RunGameMode2State_Case02 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case02)
; reads: wIsCGB
; writes: wBGPaletteUploadRequest, wOBJPaletteUploadRequest
; points at: wDMGPaletteBGP, wBGPaletteBuffer, wGameMode2State
RunGameMode2State_Case02_Sub01::
Func_0A1_4AB1:: ; address name
    ld hl, wDMGPaletteBGP
    ld a, $00
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_0A1_4AD7
    ld hl, wBGPaletteBuffer
    ld bc, $0050
    ld a, $FF
    call FillBytes
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    call UploadBGPalettes

Jump_0A1_4AD7::
    ld hl, wGameMode2State
    inc [hl]
    ret

Jump_0A1_4ADC::
    call DrawBlinkingMetaSprite8
    call RunGameMode2State_Case02_Sub01_Sub03
    call RunGameMode2State_Case02_Sub01_Sub04
    call RunGameMode2State_Case02_Sub01_Sub02
    call RunGameMode2State_Case02_Sub01_Sub01
    ret

; only called from RunGameMode2State_Case02_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case02_Sub01)
; reads: wMapType, hMapId, wKeyWorldActive, wKeyWorldKey, wKeyWorldGoalCell, wKeyWorldGoal, wKeyWorldSlot, wKeyWorldGoalScreen, ...
; writes: hTemp1, hTemp2
RunGameMode2State_Case02_Sub01_Sub01::
Func_0A1_4AEC:: ; address name
    ld a, [wMapType]
    bit 7, a
    jp nz, Jump_0A1_4B64
    ldh a, [hMapId]
    ld c, $01
    cp a, $30
    jr c, Jump_0A1_4B34
    ld c, $02
    cp a, $48
    jr c, Jump_0A1_4B34
    ld c, $03
    cp a, $70
    jr c, Jump_0A1_4B34
    ld c, $04
    cp a, $A0
    jr c, Jump_0A1_4B34
    ld c, $05
    cp a, $A8
    jr c, Jump_0A1_4B34
    ld c, $06
    cp a, $B0
    jr c, Jump_0A1_4B34
    ld c, $07
    cp a, $B8
    jr c, Jump_0A1_4B34
    ld c, $08
    cp a, $C8
    jr c, Jump_0A1_4B34
    ld c, $09
    cp a, $D1
    jr c, Jump_0A1_4B34
    ld c, $0A
    cp a, $DA
    jr c, Jump_0A1_4B34
    ld c, $0B

Jump_0A1_4B34::
    ld a, [wKeyWorldActive]
    or a, a
    jr z, Jump_0A1_4B4E
    ld a, [wKeyWorldKey]
    cp a, c
    jr nz, Jump_0A1_4B4E
    ld a, [wKeyWorldGoalCell]
    ldh [hTemp1], a
    ld a, [wKeyWorldGoal]
    ldh [hTemp2], a
    call RunGameMode2State_Case02_Sub01_Sub01_Sub01
    ret

Jump_0A1_4B4E::
    ld a, c
    dec a
    add a, a
    add a, a
    ld hl, $59D6
    add_a_to_hl
    ld a, [hl+]
    ldh [hTemp1], a
    ld a, [hl]
    ldh [hTemp2], a
    call RunGameMode2State_Case02_Sub01_Sub01_Sub01
    ret

Jump_0A1_4B64::
    ld a, [wKeyWorldActive]
    or a, a
    jr z, Jump_0A1_4B88
    ld a, [wKeyWorldKey]
    bit 7, a
    jr z, Jump_0A1_4B88
    and a, $7F
    ld c, a
    ld a, [wKeyWorldSlot]
    cp a, c
    jr nz, Jump_0A1_4B88
    ld a, [wKeyWorldGoalCell]
    ldh [hTemp1], a
    ld a, [wKeyWorldGoal]
    ldh [hTemp2], a
    call RunGameMode2State_Case02_Sub01_Sub01_Sub01
    ret

Jump_0A1_4B88::
    ld a, [wKeyWorldGoalScreen]
    ldh [hTemp1], a
    ld a, [wKeyWorldGoalPos]
    and a, $F0
    ld c, a
    ld a, [wKeyWorldGoalPos2]
    and a, $F0
    swap a
    or a, c
    ldh [hTemp2], a
    call RunGameMode2State_Case02_Sub01_Sub01_Sub01
    ret

; only called from RunGameMode2State_Case02_Sub01_Sub01 (E-0047)
; 4 call sites from 1 routine (e.g. RunGameMode2State_Case02_Sub01_Sub01)
; reads: wCursorCellY, hTemp1, wCursorCellH, wCursorCellX, hTemp2, hSpriteOriginX, wCursorCellW, hSpriteOriginY
; writes: hSpriteOriginX, hSpriteOriginY, hSpriteTileOffset, hSpriteAttrXor, hSpriteSetIndex, hSpriteSubIndex, hSpriteOriginXHi, hSpriteOriginYHi
RunGameMode2State_Case02_Sub01_Sub01_Sub01::
Func_0A1_4BA1:: ; address name
    ld a, [wCursorCellY]
    ld c, a
    ldh a, [hTemp1]
    swap a
    and a, $0F
    sub a, c
    bit 7, a
    jp nz, Jump_0A1_4C2D
    cp a, $05
    jp nc, Jump_0A1_4C2D
    ld c, $28
    call Multiply8
    ld a, l
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellH]
    ld c, a
    ldh a, [hTemp1]
    and a, $0F
    sub a, c
    bit 7, a
    jr nz, Jump_0A1_4C2D
    cp a, $05
    jr nc, Jump_0A1_4C2D
    ld c, $28
    call Multiply8
    ld a, l
    ldh [hSpriteOriginY], a
    ld a, [wCursorCellX]
    sla a
    sla a
    sla a
    ld c, a
    ldh a, [hTemp2]
    swap a
    and a, $0F
    srl a
    sla a
    sla a
    sla a
    sub a, c
    ld c, a
    ldh a, [hSpriteOriginX]
    add a, c
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellW]
    sla a
    sla a
    sla a
    ld c, a
    ldh a, [hTemp2]
    and a, $0F
    srl a
    sla a
    sla a
    sla a
    sub a, c
    ld c, a
    ldh a, [hSpriteOriginY]
    add a, c
    ldh [hSpriteOriginY], a
    ld a, $20
    ldh [hSpriteTileOffset], a
    ld a, $01
    ldh [hSpriteAttrXor], a
    ld a, $28
    ldh [hSpriteSetIndex], a
    xor a, a
    ldh [hSpriteSubIndex], a
    xor a, a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite

Jump_0A1_4C2D::
    ret

; only called from RunGameMode2State_Case02_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case02_Sub01)
; reads: wGameMode2Byte50, wMapType, wMapObjectCount, wCursorCellY, wCursorCellH, wCursorCellX, hSpriteOriginX, wCursorCellW, ...
; writes: hSpriteOriginX, hSpriteOriginY, hSpriteTileOffset, hSpriteAttrXor, hSpriteSetIndex, hSpriteSubIndex, hSpriteOriginXHi, hSpriteOriginYHi
; points at: wMapObjects
RunGameMode2State_Case02_Sub01_Sub02::
Func_0A1_4C2E:: ; address name
    ld a, [wGameMode2Byte50]
    or a, a
    ret z
    ld a, [wMapType]
    bit 7, a
    jp nz, Jump_0A1_4CDD
    ld a, [wMapObjectCount]
    ld b, a
    ld de, wMapObjects

Jump_0A1_4C42::
    push bc
    push de
    ld a, [de]
    bit 7, a
    jp nz, Jump_0A1_4CCF
    inc de
    inc de
    inc de
    inc de
    ld a, [wCursorCellY]
    ld c, a
    ld a, [de]
    swap a
    and a, $0F
    sub a, c
    bit 7, a
    jp nz, Jump_0A1_4CCF
    cp a, $05
    jp nc, Jump_0A1_4CCF
    ld c, $28
    push de
    call Multiply8
    pop de
    ld a, l
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellH]
    ld c, a
    ld a, [de]
    and a, $0F
    sub a, c
    bit 7, a
    jr nz, Jump_0A1_4CCF
    cp a, $05
    jr nc, Jump_0A1_4CCF
    ld c, $28
    push de
    call Multiply8
    pop de
    ld a, l
    ldh [hSpriteOriginY], a
    ld a, [wCursorCellX]
    add a, a
    add a, a
    add a, a
    ld c, a
    inc de
    ld a, [de]
    swap a
    and a, $0F
    srl a
    add a, a
    add a, a
    add a, a
    sub a, c
    ld c, a
    ldh a, [hSpriteOriginX]
    add a, c
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellW]
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, [de]
    and a, $0F
    srl a
    add a, a
    add a, a
    add a, a
    sub a, c
    ld c, a
    ldh a, [hSpriteOriginY]
    add a, c
    ldh [hSpriteOriginY], a
    ld a, $10
    ldh [hSpriteTileOffset], a
    ld a, $02
    ldh [hSpriteAttrXor], a
    ld a, $27
    ldh [hSpriteSetIndex], a
    xor a, a
    ldh [hSpriteSubIndex], a
    xor a, a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite

Jump_0A1_4CCF::
    pop de
    ld a, $08
    add a, e
    ld e, a
    jr nc, Jump_0A1_4CD7
    inc d

Jump_0A1_4CD7::
    pop bc
    dec b
    jp nz, Jump_0A1_4C42
    ret

Jump_0A1_4CDD::
    ld a, [wMapObjectCount]
    ld b, a
    ld de, wMapObjects

Jump_0A1_4CE4::
    push bc
    push de
    ld a, [de]
    bit 7, a
    jp nz, Jump_0A1_4D86
    inc de
    inc de
    inc de
    inc de
    ld a, [wCursorCellY]
    ld c, a
    ld a, [de]
    swap a
    and a, $0F
    sub a, c
    bit 7, a
    jp nz, Jump_0A1_4D86
    cp a, $05
    jp nc, Jump_0A1_4D86
    ld c, $28
    push de
    call Multiply8
    pop de
    ld a, l
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellH]
    ld c, a
    ld a, [de]
    and a, $0F
    sub a, c
    bit 7, a
    jr nz, Jump_0A1_4D86
    cp a, $05
    jr nc, Jump_0A1_4D86
    ld c, $28
    push de
    call Multiply8
    pop de
    ld a, l
    ldh [hSpriteOriginY], a
    inc de
    ld a, [de]
    ld hl, $4D94
    add_a_to_hl
    ld a, [wCursorCellX]
    sla a
    sla a
    sla a
    ld c, a
    ld a, [hl]
    swap a
    and a, $0F
    srl a
    sla a
    sla a
    sla a
    sub a, c
    ld c, a
    ldh a, [hSpriteOriginX]
    add a, c
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellW]
    sla a
    sla a
    sla a
    ld c, a
    ld a, [hl]
    and a, $0F
    srl a
    sla a
    sla a
    sla a
    sub a, c
    ld c, a
    ldh a, [hSpriteOriginY]
    add a, c
    ldh [hSpriteOriginY], a
    ld a, $10
    ldh [hSpriteTileOffset], a
    ld a, $02
    ldh [hSpriteAttrXor], a
    ld a, $27
    ldh [hSpriteSetIndex], a
    xor a, a
    ldh [hSpriteSubIndex], a
    xor a, a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite

Jump_0A1_4D86::
    pop de
    ld a, $08
    add a, e
    ld e, a
    jr nc, Jump_0A1_4D8E
    inc d

Jump_0A1_4D8E::
    pop bc
    dec b
    jp nz, Jump_0A1_4CE4
    ret
    db $12, $17, $21, $24, $26, $33, $45, $47, $51, $53, $65, $72, $74, $77, $81, $86

; only called from RunGameMode2State_Case02_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case02_Sub01)
; reads: wMapType, wGameMode2Byte44, wCursorCellY, wCursorCellH, wCursorCellX, hSpriteOriginX, wCursorCellW, hSpriteOriginY, ...
; writes: hSpriteOriginX, hSpriteOriginY, hSpriteTileOffset, hSpriteAttrXor, hSpriteSetIndex, hSpriteSubIndex, hSpriteOriginXHi, hSpriteOriginYHi
RunGameMode2State_Case02_Sub01_Sub03::
Func_0A1_4DA4:: ; address name
    ld a, [wMapType]
    bit 7, a
    jp nz, Jump_0A1_4E4D
    ld a, [wGameMode2Byte44]
    add a, a
    ld hl, $5A49
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, [de]
    or a, a
    ret z
    inc de
    ld b, a

Jump_0A1_4DC1::
    push bc
    push de
    ld a, [wCursorCellY]
    ld c, a
    ld a, [de]
    swap a
    and a, $0F
    sub a, c
    bit 7, a
    jp nz, Jump_0A1_4E44
    cp a, $05
    jp nc, Jump_0A1_4E44
    ld c, $28
    push de
    call Multiply8
    pop de
    ld a, l
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellH]
    ld c, a
    ld a, [de]
    and a, $0F
    sub a, c
    bit 7, a
    jr nz, Jump_0A1_4E44
    cp a, $05
    jr nc, Jump_0A1_4E44
    ld c, $28
    push de
    call Multiply8
    pop de
    ld a, l
    ldh [hSpriteOriginY], a
    ld a, [wCursorCellX]
    add a, a
    add a, a
    add a, a
    ld c, a
    inc de
    ld a, [de]
    swap a
    and a, $0F
    srl a
    add a, a
    add a, a
    add a, a
    sub a, c
    ld c, a
    ldh a, [hSpriteOriginX]
    add a, c
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellW]
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, [de]
    and a, $0F
    srl a
    add a, a
    add a, a
    add a, a
    sub a, c
    ld c, a
    ldh a, [hSpriteOriginY]
    add a, c
    ldh [hSpriteOriginY], a
    ld a, $20
    ldh [hSpriteTileOffset], a
    ld a, $01
    ldh [hSpriteAttrXor], a
    ld a, $28
    ldh [hSpriteSetIndex], a
    xor a, a
    ldh [hSpriteSubIndex], a
    xor a, a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite

Jump_0A1_4E44::
    pop de
    inc de
    inc de
    pop bc
    dec b
    jp nz, Jump_0A1_4DC1
    ret

Jump_0A1_4E4D::
    ld de, wKeyWorldFloorInfo + $3

Jump_0A1_4E50::
    push de
    ld a, [de]
    cp a, $FF
    jr nz, Jump_0A1_4E58
    pop de
    ret

Jump_0A1_4E58::
    dec de
    dec de
    dec de
    ld a, [wCursorCellY]
    ld c, a
    ld a, [de]
    swap a
    and a, $0F
    sub a, c
    bit 7, a
    jp nz, Jump_0A1_4EDF
    cp a, $05
    jr nc, Jump_0A1_4EDF
    ld c, $28
    push de
    call Multiply8
    pop de
    ld a, l
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellH]
    ld c, a
    ld a, [de]
    and a, $0F
    sub a, c
    bit 7, a
    jr nz, Jump_0A1_4EDF
    cp a, $05
    jr nc, Jump_0A1_4EDF
    ld c, $28
    push de
    call Multiply8
    pop de
    ld a, l
    ldh [hSpriteOriginY], a
    ld a, [wGameMode2Byte50]
    or a, a
    jr nz, Jump_0A1_4E9F
    ld a, [de]
    call IsMapScreenAVisited
    or a, a
    jr z, Jump_0A1_4EDF

Jump_0A1_4E9F::
    ld a, [wCursorCellX]
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, $02
    add a, a
    add a, a
    add a, a
    sub a, c
    ld c, a
    ldh a, [hSpriteOriginX]
    add a, c
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellW]
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, $02
    add a, a
    add a, a
    add a, a
    sub a, c
    ld c, a
    ldh a, [hSpriteOriginY]
    add a, c
    ldh [hSpriteOriginY], a
    ld a, $20
    ldh [hSpriteTileOffset], a
    ld a, $01
    ldh [hSpriteAttrXor], a
    ld a, $28
    ldh [hSpriteSetIndex], a
    xor a, a
    ldh [hSpriteSubIndex], a
    xor a, a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite

Jump_0A1_4EDF::
    pop de
    inc de
    inc de
    inc de
    inc de
    jp Jump_0A1_4E50

; only called from RunGameMode2State_Case02_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case02_Sub01)
; reads: wMapType
; points at: wKeyWorldObjects
RunGameMode2State_Case02_Sub01_Sub04::
Func_0A1_4EE7:: ; address name
    ld a, [wMapType]
    bit 7, a
    ret z
    ld de, wKeyWorldObjects

Jump_0A1_4EF0::
    push de
    ld a, [de]
    cp a, $FF
    jr nz, Jump_0A1_4EF8
    pop de
    ret

Jump_0A1_4EF8::
    dec de
    dec de
    dec de
    call RunGameMode2State_Case02_Sub01_Sub04_Sub01
    inc de
    call RunGameMode2State_Case02_Sub01_Sub04_Sub01
    pop de
    inc de
    inc de
    inc de
    inc de
    jp Jump_0A1_4EF0

; only called from RunGameMode2State_Case02_Sub01_Sub04 (E-0047)
; 2 call sites from 1 routine (e.g. RunGameMode2State_Case02_Sub01_Sub04)
; reads: wCursorCellY, wCursorCellH, wGameMode2Byte50, wCursorCellX, hSpriteOriginX, wCursorCellW, hSpriteOriginY
; writes: hSpriteOriginX, hSpriteOriginY, hSpriteTileOffset, hSpriteAttrXor, hSpriteSetIndex, hSpriteSubIndex, hSpriteOriginXHi, hSpriteOriginYHi
RunGameMode2State_Case02_Sub01_Sub04_Sub01::
Func_0A1_4F0A:: ; address name
    ld a, [wCursorCellY]
    ld c, a
    ld a, [de]
    swap a
    and a, $0F
    sub a, c
    bit 7, a
    ret nz
    cp a, $05
    ret nc
    ld c, $28
    push de
    call Multiply8
    pop de
    ld a, l
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellH]
    ld c, a
    ld a, [de]
    and a, $0F
    sub a, c
    bit 7, a
    ret nz
    cp a, $05
    ret nc
    ld c, $28
    push de
    call Multiply8
    pop de
    ld a, l
    ldh [hSpriteOriginY], a
    ld a, [wGameMode2Byte50]
    or a, a
    jr nz, Jump_0A1_4F48
    ld a, [de]
    call IsMapScreenAVisited
    or a, a
    ret z

Jump_0A1_4F48::
    ld a, [wCursorCellX]
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, $02
    add a, a
    add a, a
    add a, a
    sub a, c
    ld c, a
    ldh a, [hSpriteOriginX]
    add a, c
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellW]
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, $02
    add a, a
    add a, a
    add a, a
    sub a, c
    ld c, a
    ldh a, [hSpriteOriginY]
    add a, c
    ldh [hSpriteOriginY], a
    ld a, $20
    ldh [hSpriteTileOffset], a
    ld a, $01
    ldh [hSpriteAttrXor], a
    ld a, $28
    ldh [hSpriteSetIndex], a
    xor a, a
    ldh [hSpriteSubIndex], a
    xor a, a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    push de
    farcall DrawMetaSprite
    pop de
    ret

; while bit 5 of wFrameCounterLo is set, draws metasprite set 8 at ($4E, $46) (E-0121)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case02_Sub01)
; reads: wFrameCounterLo
; writes: hSpriteOriginX, hSpriteOriginY, hSpriteTileOffset, hSpriteAttrXor, hSpriteSetIndex, hSpriteSubIndex, hSpriteOriginXHi, hSpriteOriginYHi
DrawBlinkingMetaSprite8::
Func_0A1_4F8B:: ; address name
    ld a, [wFrameCounterLo]
    bit 5, a
    ret z
    ld a, $50
    dec a
    dec a
    ldh [hSpriteOriginX], a
    ld a, $48
    dec a
    dec a
    ldh [hSpriteOriginY], a
    ld a, $00
    ldh [hSpriteTileOffset], a
    ld a, $00
    ldh [hSpriteAttrXor], a
    ld a, $08
    ldh [hSpriteSetIndex], a
    xor a, a
    ldh [hSpriteSubIndex], a
    xor a, a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite
    ret

; entry 0 of the `rst $00` table in RunGameMode2State
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: wSpriteSlotCount, wBGPaletteUploadRequest
; points at: wDMGPaletteBGP, wBGPaletteBuffer, wGameMode2State
RunGameMode2State_Case00::
Jump_0A1_4FB8:: ; address name
    xor a, a
    ld [wSpriteSlotCount], a
    ld hl, wDMGPaletteBGP
    ld a, $00
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_0A1_4FDD
    ld hl, wBGPaletteBuffer
    ld bc, $0040
    ld a, $FF
    call FillBytes
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes

Jump_0A1_4FDD::
    ld hl, wGameMode2State
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunGameMode2State
; no direct call (reached through a table, a jump or a vector)
; reads: wMapType, wIsCGB
; writes: hScrollX, hScrollY, wOBJPaletteUploadRequest, wBGPaletteUploadRequest
; points at: wDMGPaletteBGP, wOBJPaletteBuffer, wBGPaletteBuffer, wGameMode2State
RunGameMode2State_Case01::
Jump_0A1_4FE2:: ; address name
    xor a, a
    ldh [hScrollX], a
    ldh [hScrollY], a
    call CopyScrollToHardware
    ld de, Data_07E_4EB3
    ld b, $7E
    ld hl, vTiles0
    call DecompressToVRAM
    ld de, Data_07E_5B0E
    ld b, $7E
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld de, Data_05D_4001
    ld b, $5D
    ld hl, vTiles2
    call DecompressToVRAM
    ld de, Data_05E_4001
    ld b, $5E
    ld hl, vTiles2 + $500
    call DecompressToVRAM
    ld de, $4238
    ld a, $5E
    ld bc, $1412
    ld hl, vBGMap0
    call CopyRectFromBankToVRAM
    call DrawRect12x12FromBankA1
    call RunGameMode2State_Case01_Sub03
    ld a, [wMapType]
    bit 7, a
    jr nz, Jump_0A1_5036
    call RunGameMode2State_Case01_Sub02
    jr Jump_0A1_5039

Jump_0A1_5036::
    call RunGameMode2State_Case01_Sub01

Jump_0A1_5039::
    ld hl, wDMGPaletteBGP
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_0A1_5090
    ld a, $40
    ld de, Data_07E_4BBD
    add a, e
    ld e, a
    jr nc, Jump_0A1_5055
    inc d

Jump_0A1_5055::
    ld b, $7E
    ld hl, wOBJPaletteBuffer
    ld c, $08
    call CopyFromBank
    ld de, Palettes_7E_5AF6
    ld b, $7E
    ld hl, wOBJPaletteBuffer + $8
    ld c, $08
    call CopyFromBank
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ld de, Palettes_5D_4139
    ld b, $5D
    ld hl, wBGPaletteBuffer
    ld c, $08
    call CopyFromBank
    ld de, Palettes_5E_422F
    ld b, $5E
    ld hl, wBGPaletteBuffer + $8
    ld c, $08
    call CopyFromBank
    ld a, $7F
    ld [wBGPaletteUploadRequest], a

Jump_0A1_5090::
    ld hl, wGameMode2State
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunGameMode2State
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed
; writes: wGameMode2State
; points at: wGameMode2State
RunGameMode2State_Case02::
Jump_0A1_5095:: ; address name
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, Jump_0A1_50A5
    call RunGameMode2State_Case02_Sub01
    ld a, $06
    ld [wGameMode2State], a
    ret

Jump_0A1_50A5::
    bit 2, a
    jr z, Jump_0A1_50AE
    ld hl, wGameMode2State
    inc [hl]
    ret

Jump_0A1_50AE::
    call RunGameMode2State_Case02_Sub03
    call RunGameMode2State_Case02_Sub04
    call RunGameMode2State_Case02_Sub05
    call RunGameMode2State_Case02_Sub02
    ret

; entry 6 of the `rst $00` table in RunGameMode2State
; no direct call (reached through a table, a jump or a vector)
RunGameMode2State_Case06::
Jump_0A1_50BB:: ; address name
    call EnterGameMode1WithDefaultPalettes
    ret

; only called from RunGameMode2State_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case01)
; reads: wKeyWorldHeight, wKeyWorldWidth, hTemp4, hTemp5, hTemp0, hTemp1, hTemp2, hTemp3, ...
; writes: hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, hTemp5, hTemp6, hTemp7
; points at: wVisitedScreens, wKeyWorldChunks, wNameGlyphBuf
RunGameMode2State_Case01_Sub01::
Func_0A1_50BF:: ; address name
    ld a, [wKeyWorldHeight]
    ld c, a
    ld a, [wKeyWorldWidth]
    ld b, a
    call CenteredBGMapOriginForSizeBC
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    ld hl, wVisitedScreens
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    ld a, l
    ldh [hTemp6], a
    ld a, h
    ldh [hTemp7], a
    ld a, [wKeyWorldHeight]
    srl a
    srl a
    ld c, a
    ld a, [wKeyWorldWidth]
    srl a
    srl a
    ld b, a
    ld hl, wKeyWorldChunks

Jump_0A1_50F8::
    push bc
    push hl

Jump_0A1_50FA::
    push bc
    push hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld b, a
    push bc
    ld a, [hl]
    ld c, $60
    call Multiply8
    add hl, de
    pop bc
    ldh a, [hTemp4]
    ld e, a
    ldh a, [hTemp5]
    ld d, a
    ld a, [de]
    call RunGameMode2State_Case01_Sub01_Sub01
    call RunGameMode2State_Case01_Sub01_Sub01
    call RunGameMode2State_Case01_Sub01_Sub01
    call RunGameMode2State_Case01_Sub01_Sub01
    push af
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, $1C
    add a, e
    ld e, a
    jr nc, Jump_0A1_512C
    inc d

Jump_0A1_512C::
    ld a, e
    ldh [hTemp0], a
    ld a, d
    ldh [hTemp1], a
    pop af
    call RunGameMode2State_Case01_Sub01_Sub01
    call RunGameMode2State_Case01_Sub01_Sub01
    call RunGameMode2State_Case01_Sub01_Sub01
    call RunGameMode2State_Case01_Sub01_Sub01
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, $1C
    add a, e
    ld e, a
    jr nc, Jump_0A1_514C
    inc d

Jump_0A1_514C::
    ld a, e
    ldh [hTemp0], a
    ld a, d
    ldh [hTemp1], a
    ldh a, [hTemp4]
    ld e, a
    ldh a, [hTemp5]
    ld d, a
    inc de
    ld a, e
    ldh [hTemp4], a
    ld a, d
    ldh [hTemp5], a
    ld a, [de]
    call RunGameMode2State_Case01_Sub01_Sub01
    call RunGameMode2State_Case01_Sub01_Sub01
    call RunGameMode2State_Case01_Sub01_Sub01
    call RunGameMode2State_Case01_Sub01_Sub01
    push af
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, $1C
    add a, e
    ld e, a
    jr nc, Jump_0A1_517A
    inc d

Jump_0A1_517A::
    ld a, e
    ldh [hTemp0], a
    ld a, d
    ldh [hTemp1], a
    pop af
    call RunGameMode2State_Case01_Sub01_Sub01
    call RunGameMode2State_Case01_Sub01_Sub01
    call RunGameMode2State_Case01_Sub01_Sub01
    call RunGameMode2State_Case01_Sub01_Sub01
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, $1C
    add a, e
    ld e, a
    jr nc, Jump_0A1_519A
    inc d

Jump_0A1_519A::
    ld a, e
    ldh [hTemp0], a
    ld a, d
    ldh [hTemp1], a
    ldh a, [hTemp4]
    ld e, a
    ldh a, [hTemp5]
    ld d, a
    inc de
    ld a, e
    ldh [hTemp4], a
    ld a, d
    ldh [hTemp5], a
    ld a, [de]
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, e
    sub a, $7C
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    ld a, e
    ldh [hTemp0], a
    ld a, d
    ldh [hTemp1], a
    pop hl
    ld a, $04
    add_a_to_hl
    pop bc
    dec b
    jp nz, Jump_0A1_50FA
    ldh a, [hTemp2]
    ld e, a
    ldh a, [hTemp3]
    ld d, a
    ld a, $80
    add a, e
    ld e, a
    jr nc, Jump_0A1_51DC
    inc d

Jump_0A1_51DC::
    ld a, e
    ldh [hTemp2], a
    ld a, d
    ldh [hTemp3], a
    ld a, e
    ldh [hTemp0], a
    ld a, d
    ldh [hTemp1], a
    ldh a, [hTemp6]
    ld e, a
    ldh a, [hTemp7]
    ld d, a
    ld a, e
    add a, $04
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, e
    ldh [hTemp4], a
    ld a, d
    ldh [hTemp5], a
    ld a, e
    ldh [hTemp6], a
    ld a, d
    ldh [hTemp7], a
    pop hl
    ld a, $08
    add_a_to_hl
    pop bc
    dec c
    jp nz, Jump_0A1_50F8
    ld hl, vTiles1
    ld b, $58

Jump_0A1_5214::
    ld a, $FF
    call WriteVRAMByteInc
    xor a, a
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_0A1_5214
    ld de, wNameGlyphBuf
    ld a, [wCurrentKeyIndex]
    call WriteKeyNameToDE
    call RunGameMode2State_Shared01
    ld de, vTiles1
    call CopyGlyphTilesToVRAM
    ld e, $80
    ld hl, vBGMap0 + $204
    ld b, $0B

Jump_0A1_5239::
    ld a, e
    call WriteVRAMByteInc
    inc e
    dec b
    jr nz, Jump_0A1_5239
    ret

; only called from RunGameMode2State_Case01_Sub01 (E-0047)
; 16 call sites from 1 routine (e.g. RunGameMode2State_Case01_Sub01)
; reads: hTemp0, hTemp1
; writes: hTemp0
RunGameMode2State_Case01_Sub01_Sub01::
Func_0A1_5242:: ; address name
    sra a
    push af
    jr c, Jump_0A1_5255
    ld a, $03
    add_a_to_hl
    ldh a, [hTemp0]
    inc a
    ldh [hTemp0], a
    pop af
    ret

Jump_0A1_5255::
    push bc
    push hl
    ld e, l
    ld d, h
    call ReadByteInBank
    ld l, c
    inc de
    call ReadByteInBank
    ld h, c
    inc de
    call ReadByteInBank
    ld b, c
    ld e, l
    ld d, h
    inc de
    inc de
    inc de
    inc de
    inc de
    call ReadByteInBank
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, c
    call WriteVRAMByte
    pop hl
    ld a, $03
    add_a_to_hl
    ldh a, [hTemp0]
    inc a
    ldh [hTemp0], a
    pop bc
    pop af
    ret

; only called from routines of RunGameMode2State (E-0098)
; 2 call sites from 2 routines (e.g. RunGameMode2State_Case01_Sub02, RunGameMode2State_Case01_Sub01)
; points at: wNameGlyphBuf
RunGameMode2State_Shared01::
Func_0A1_528B:: ; address name
    push hl
    push de
    ld hl, wNameGlyphBuf
    ld bc, $0000

Jump_0A1_5293::
    inc b
    ld a, [hl+]
    cp a, $8D
    jr z, Jump_0A1_5293
    cp a, $8E
    jr z, Jump_0A1_5293
    inc c
    cp a, $F0
    jr z, Jump_0A1_52A4
    jr Jump_0A1_5293

Jump_0A1_52A4::
    ld a, $0D
    sub a, c
    srl a
    jr z, Jump_0A1_52D1
    ld c, b
    ld b, a
    ld a, c
    add a, b
    ld de, wNameGlyphBuf
    add a, e
    ld e, a
    jr nc, Jump_0A1_52B7
    inc d

Jump_0A1_52B7::
    ld a, c
    ld hl, wNameGlyphBuf
    add_a_to_hl
    inc c

Jump_0A1_52C1::
    ld a, [hl]
    ld [de], a
    dec hl
    dec de
    dec c
    jr nz, Jump_0A1_52C1
    ld hl, wNameGlyphBuf

Jump_0A1_52CB::
    ld [hl], $90
    inc hl
    dec b
    jr nz, Jump_0A1_52CB

Jump_0A1_52D1::
    pop de
    pop hl
    ret

; only called from RunGameMode2State_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case01)
; reads: wGameMode2Byte44, hMapId
; writes: wStringIndex, wStringCategory, wStringDestLo, wStringDestHi
; points at: wNameGlyphBuf
RunGameMode2State_Case01_Sub02::
Func_0A1_52D4:: ; address name
    ld a, [wGameMode2Byte44]
    add a, a
    add a, a
    add a, a
    ld hl, WorldMapViewTable
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    push hl
    push de
    call CenteredBGMapOriginForSizeBC
    pop de
    ld a, $5D
    call CopyRectFromBankToVRAM
    pop hl
    ld hl, vTiles1
    ld b, $58

Jump_0A1_52FB::
    ld a, $FF
    call WriteVRAMByteInc
    xor a, a
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_0A1_52FB
    ldh a, [hMapId]
    add a, $0A
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    ld de, wNameGlyphBuf
    ld a, e
    ld [wStringDestLo], a
    ld a, d
    ld [wStringDestHi], a
    farcall CopyStringToBuffer_Bank08
    call RunGameMode2State_Shared01
    ld de, vTiles1
    call CopyGlyphTilesToVRAM
    ld e, $80
    ld hl, vBGMap0 + $204
    ld b, $0B

Jump_0A1_5333::
    ld a, e
    call WriteVRAMByteInc
    inc e
    dec b
    jr nz, Jump_0A1_5333
    ret

; E-0167 (C1: RunGameMode2State_Case01_Sub02 takes entry 8 * wGameMode2Byte44, centres a rectangle of these rows and width (CenteredBGMapOriginForSizeBC) and copies it from bank $5D with CopyRectFromBankToVRAM; 11 entries whose rectangles are contiguous from $41B9 to $43AE).
; record: tile rectangle in bank $5D; rows, width; a map number ($20, $30, $48 ...) and three zero bytes; not read here
WorldMapViewTable::
Data_0A1_533C:: ; address name
    dw WorldMapView0 ; id 0
    db $08, $08, $20, $00, $00, $00
    dw WorldMapView1 ; id 1
    db $08, $08, $30, $00, $00, $00
    dw WorldMapView2 ; id 2
    db $0C, $0C, $48, $00, $00, $00
    dw WorldMapView3 ; id 3
    db $0C, $0C, $70, $00, $00, $00
    dw WorldMapView4 ; id 4
    db $03, $04, $A0, $00, $00, $00
    dw WorldMapView5 ; id 5
    db $06, $06, $A8, $00, $00, $00
    dw WorldMapView6 ; id 6
    db $02, $03, $B0, $00, $00, $00
    dw WorldMapView7 ; id 7
    db $05, $05, $B8, $00, $00, $00
    dw WorldMapView8 ; id 8
    db $02, $01, $C8, $00, $00, $00
    dw WorldMapView9 ; id 9
    db $02, $01, $D1, $00, $00, $00
    dw WorldMapView10 ; id 10
    db $01, $02, $DA, $00, $00, $00

; only called from RunGameMode2State_Case02 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case02)
; reads: wMapType, hMapId, wKeyWorldActive, wKeyWorldKey, wKeyWorldGoalCell, wKeyWorldSlot, wKeyWorldGoalScreen
; writes: hTemp1
RunGameMode2State_Case02_Sub02::
Func_0A1_5394:: ; address name
    ld a, [wMapType]
    bit 7, a
    jp nz, Jump_0A1_5406
    ldh a, [hMapId]
    ld c, $01
    cp a, $30
    jr c, Jump_0A1_53DC
    ld c, $02
    cp a, $48
    jr c, Jump_0A1_53DC
    ld c, $03
    cp a, $70
    jr c, Jump_0A1_53DC
    ld c, $04
    cp a, $A0
    jr c, Jump_0A1_53DC
    ld c, $05
    cp a, $A8
    jr c, Jump_0A1_53DC
    ld c, $06
    cp a, $B0
    jr c, Jump_0A1_53DC
    ld c, $07
    cp a, $B8
    jr c, Jump_0A1_53DC
    ld c, $08
    cp a, $C8
    jr c, Jump_0A1_53DC
    ld c, $09
    cp a, $D1
    jr c, Jump_0A1_53DC
    ld c, $0A
    cp a, $DA
    jr c, Jump_0A1_53DC
    ld c, $0B

Jump_0A1_53DC::
    ld a, [wKeyWorldActive]
    or a, a
    jr z, Jump_0A1_53F1
    ld a, [wKeyWorldKey]
    cp a, c
    jr nz, Jump_0A1_53F1
    ld a, [wKeyWorldGoalCell]
    ldh [hTemp1], a
    call DrawCursorSpriteAtTemp1Cell
    ret

Jump_0A1_53F1::
    ld a, c
    dec a
    sla a
    sla a
    ld hl, $59D6
    add_a_to_hl
    ld a, [hl]
    ldh [hTemp1], a
    call DrawCursorSpriteAtTemp1Cell
    ret

Jump_0A1_5406::
    ld a, [wKeyWorldActive]
    or a, a
    jr z, Jump_0A1_5425
    ld a, [wKeyWorldKey]
    bit 7, a
    jr z, Jump_0A1_5425
    and a, $7F
    ld c, a
    ld a, [wKeyWorldSlot]
    cp a, c
    jr nz, Jump_0A1_5425
    ld a, [wKeyWorldGoalCell]
    ldh [hTemp1], a
    call DrawCursorSpriteAtTemp1Cell
    ret

Jump_0A1_5425::
    ld a, [wKeyWorldGoalScreen]
    ldh [hTemp1], a
    call DrawCursorSpriteAtTemp1Cell
    ret

; draws metasprite set $26 at X = 8 * (wC945 + 8 * high nibble of hFFC7), Y = 8 * (wC946 + 8 * low nibble) (E-0121)
; 4 call sites from 1 routine (e.g. RunGameMode2State_Case02_Sub02)
; reads: hTemp1, wCursorCellX, wCursorCellY
; writes: hSpriteOriginX, hSpriteOriginY, hSpriteTileOffset, hSpriteAttrXor, hSpriteSetIndex, hSpriteSubIndex, hSpriteOriginXHi, hSpriteOriginYHi
DrawCursorSpriteAtTemp1Cell::
Func_0A1_542E:: ; address name
    ldh a, [hTemp1]
    and a, $F0
    swap a
    sla a
    sla a
    sla a
    ld c, a
    ld a, [wCursorCellX]
    sla a
    sla a
    sla a
    add a, c
    ldh [hSpriteOriginX], a
    ldh a, [hTemp1]
    and a, $0F
    sla a
    sla a
    sla a
    ld c, a
    ld a, [wCursorCellY]
    sla a
    sla a
    sla a
    add a, c
    ldh [hSpriteOriginY], a
    ld a, $10
    ldh [hSpriteTileOffset], a
    ld a, $01
    ldh [hSpriteAttrXor], a
    ld a, $26
    ldh [hSpriteSetIndex], a
    xor a, a
    ldh [hSpriteSubIndex], a
    xor a, a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite
    ret

; only called from RunGameMode2State_Case02 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case02)
; reads: wFrameCounterLo, wMapType, hMapId, wLastWarpIndex, hMapScreenX, hMapScreenY, wKeyWorldActive, wKeyWorldKey, ...
RunGameMode2State_Case02_Sub03::
Func_0A1_5479:: ; address name
    ld a, [wFrameCounterLo]
    bit 5, a
    ret z
    ld a, [wMapType]
    bit 7, a
    jp nz, Jump_0A1_55A1
    ldh a, [hMapId]
    ld c, $01
    cp a, $29
    jp z, Jump_0A1_553D
    ld c, $02
    cp a, $45
    jp z, Jump_0A1_553D
    ld c, $03
    cp a, $68
    jp z, Jump_0A1_553D
    ld c, $04
    cp a, $9D
    jp z, Jump_0A1_553D
    ld c, $05
    cp a, $A4
    jp z, Jump_0A1_553D
    ld c, $06
    cp a, $AF
    jp z, Jump_0A1_553D
    ld c, $07
    cp a, $B2
    jp z, Jump_0A1_553D
    ld c, $08
    cp a, $C5
    jr z, Jump_0A1_553D
    ld c, $09
    cp a, $D0
    jr z, Jump_0A1_553D
    ld c, $0A
    cp a, $D9
    jr z, Jump_0A1_553D
    ld c, $0B
    cp a, $E2
    jr z, Jump_0A1_553D
    cp a, $20
    jr z, SetSpriteYFromCursorCellY_Case00
    cp a, $30
    jr z, SetSpriteYFromCursorCellY_Case00
    cp a, $48
    jr z, SetSpriteYFromCursorCellY_Case00
    cp a, $70
    jr z, SetSpriteYFromCursorCellY_Case00
    cp a, $A0
    jr z, SetSpriteYFromCursorCellY_Case00
    cp a, $A8
    jr z, SetSpriteYFromCursorCellY_Case00
    cp a, $B0
    jr z, SetSpriteYFromCursorCellY_Case00
    cp a, $B8
    jr z, SetSpriteYFromCursorCellY_Case00
    cp a, $C8
    jr z, SetSpriteYFromCursorCellY_Case00
    cp a, $D1
    jr z, SetSpriteYFromCursorCellY_Case00
    cp a, $DA
    jr z, SetSpriteYFromCursorCellY_Case00
    ld c, a
    ld hl, $5A92

Jump_0A1_5502::
    ld a, [hl]
    cp a, c
    jr z, Jump_0A1_550D
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_0A1_5502

Jump_0A1_550D::
    ld a, [wLastWarpIndex]
    dec a
    dec a
    jr nz, Jump_0A1_5516
    inc hl
    inc hl

Jump_0A1_5516::
    inc hl
    ld a, [hl+]
    call SetSpriteXFromCursorCellX
    ld a, [hl]
    call SetSpriteYFromCursorCellY
    call DrawMetaSpriteSet08
    ret

; entry 0 of the `rst $00` table in SetSpriteYFromCursorCellY
; no direct call (reached through a table, a jump or a vector)
; reads: hMapScreenX, hMapScreenY
SetSpriteYFromCursorCellY_Case00::
Jump_0A1_5523:: ; address name
    ldh a, [hMapScreenX]
    sla a
    sla a
    sla a
    call SetSpriteXFromCursorCellX
    ldh a, [hMapScreenY]
    sla a
    sla a
    sla a
    call SetSpriteYFromCursorCellY
    call DrawMetaSpriteSet08
    ret

Jump_0A1_553D::
    ld a, [wKeyWorldActive]
    or a, a
    jr z, Jump_0A1_5565
    ld a, [wKeyWorldKey]
    cp a, c
    jr nz, Jump_0A1_5565
    ld a, [wKeyWorldGoalCell]
    and a, $F0
    swap a
    add a, a
    add a, a
    add a, a
    call SetSpriteXFromCursorCellX
    ld a, [wKeyWorldGoalCell]
    and a, $0F
    add a, a
    add a, a
    add a, a
    call SetSpriteYFromCursorCellY
    call DrawMetaSpriteSet08
    ret

Jump_0A1_5565::
    ld a, [wKeyWorldGoalScreen]
    and a, $F0
    swap a
    add a, a
    add a, a
    add a, a
    call SetSpriteXFromCursorCellX
    ld a, [wKeyWorldGoalScreen]
    and a, $0F
    add a, a
    add a, a
    add a, a
    call SetSpriteYFromCursorCellY
    call DrawMetaSpriteSet08
    ret

; hSpriteOriginX = 8 * wC945 + A + 6 (E-0122)
; 4 call sites from 2 routines (e.g. RunGameMode2State_Case02_Sub03, SetSpriteYFromCursorCellY_Case00)
; reads: wCursorCellX
; writes: hSpriteOriginX
SetSpriteXFromCursorCellX::
Func_0A1_5581:: ; address name
    ld c, a
    ld a, [wCursorCellX]
    sla a
    sla a
    sla a
    add a, c
    add a, $06
    ldh [hSpriteOriginX], a
    ret

; hSpriteOriginY = 8 * wC946 + A + 6; the next entry dispatches on wCC44 & 7 (E-0124)
; 4 call sites from 2 routines (e.g. RunGameMode2State_Case02_Sub03, SetSpriteYFromCursorCellY_Case00)
; reads: wCursorCellY
; writes: hSpriteOriginY
SetSpriteYFromCursorCellY::
Func_0A1_5591:: ; address name
    ld c, a
    ld a, [wCursorCellY]
    sla a
    sla a
    sla a
    add a, c
    add a, $06
    ldh [hSpriteOriginY], a
    ret

Jump_0A1_55A1::
    ld a, [wMapType]
    and a, $07
    rst $00
    dw SetSpriteYFromCursorCellY_Case00
    dw SetSpriteYFromCursorCellY_Case01
    dw SetSpriteYFromCursorCellY_Case01
    dw SetSpriteYFromCursorCellY_Case03
    dw SetSpriteYFromCursorCellY_Case03
    dw SetSpriteYFromCursorCellY_Case03
    dw SetSpriteYFromCursorCellY_Case03
    dw SetSpriteYFromCursorCellY_Case07

; entry 1 of the `rst $00` table in SetSpriteYFromCursorCellY
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldFloor
; points at: wKeyWorldAreaExits
SetSpriteYFromCursorCellY_Case01::
Jump_0A1_55B7:: ; address name
    ld a, [wKeyWorldFloor]
    and a, $07
    sla a
    sla a
    ld hl, wKeyWorldAreaExits
    add_a_to_hl
    ld a, [wKeyWorldFloor]
    bit 7, a
    jr z, Jump_0A1_55D0
    inc hl

Jump_0A1_55D0::
    ld a, [hl]
    call SetSpriteXYFromCellA
    ret

; entry 3 of the `rst $00` table in SetSpriteYFromCursorCellY
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldFloor
; points at: wKeyWorldFloorInfo
SetSpriteYFromCursorCellY_Case03::
Jump_0A1_55D5:: ; address name
    ld a, [wKeyWorldFloor]
    and a, $07
    add a, a
    add a, a
    ld hl, wKeyWorldFloorInfo
    add_a_to_hl
    ld a, [hl]
    call SetSpriteXYFromCellA
    ret

; entry 7 of the `rst $00` table in SetSpriteYFromCursorCellY
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldActive, wKeyWorldKey, wKeyWorldSlot, wKeyWorldGoalCell, wKeyWorldGoalScreen
SetSpriteYFromCursorCellY_Case07::
Jump_0A1_55E9:: ; address name
    ld a, [wKeyWorldActive]
    or a, a
    jr z, Jump_0A1_5606
    ld a, [wKeyWorldKey]
    bit 7, a
    jr z, Jump_0A1_5606
    and a, $7F
    ld c, a
    ld a, [wKeyWorldSlot]
    cp a, c
    jr nz, Jump_0A1_5606
    ld a, [wKeyWorldGoalCell]
    call SetSpriteXYFromCellA
    ret

Jump_0A1_5606::
    ld a, [wKeyWorldGoalScreen]
    call SetSpriteXYFromCellA
    ret

; hSpriteOriginX = 8 * wC945 + (A >> 4) * 8 + 6 and hSpriteOriginY = 8 * wC946 + (A & $0F) * 8 + 6 (E-0124)
; 4 call sites from 3 routines (e.g. SetSpriteYFromCursorCellY_Case07, SetSpriteYFromCursorCellY_Case03, SetSpriteYFromCursorCellY_Case01)
; reads: wCursorCellX, wCursorCellY
; writes: hSpriteOriginX, hSpriteOriginY, hSpriteTileOffset, hSpriteAttrXor, hSpriteSetIndex, hSpriteSubIndex, hSpriteOriginXHi, hSpriteOriginYHi
SetSpriteXYFromCellA::
Func_0A1_560D:: ; address name
    push af
    and a, $F0
    srl a
    ld c, a
    ld a, [wCursorCellX]
    sla a
    sla a
    sla a
    add a, c
    add a, $06
    ldh [hSpriteOriginX], a
    pop af
    and a, $0F
    sla a
    sla a
    sla a
    ld c, a
    ld a, [wCursorCellY]
    sla a
    sla a
    sla a
    add a, c
    add a, $06
    ldh [hSpriteOriginY], a

; DrawMetaSprite with set $08, sub-index 0, no tile offset or attribute change (origin high bytes 0) (E-0118)
; 4 call sites from 2 routines (e.g. RunGameMode2State_Case02_Sub03, SetSpriteYFromCursorCellY_Case00)
; writes: hSpriteTileOffset, hSpriteAttrXor, hSpriteSetIndex, hSpriteSubIndex, hSpriteOriginXHi, hSpriteOriginYHi
DrawMetaSpriteSet08::
Func_0A1_5639:: ; address name
    ld a, $00
    ldh [hSpriteTileOffset], a
    ld a, $00
    ldh [hSpriteAttrXor], a
    ld a, $08
    ldh [hSpriteSetIndex], a
    xor a, a
    ldh [hSpriteSubIndex], a
    xor a, a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite
    ret

; only called from RunGameMode2State_Case02 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case02)
; reads: wMapType, wGameMode2Byte44, wCursorCellX, wCursorCellY, wGameMode2Byte50
; writes: hSpriteOriginX, hSpriteOriginY
RunGameMode2State_Case02_Sub04::
Func_0A1_5654:: ; address name
    ld a, [wMapType]
    bit 7, a
    jr nz, Jump_0A1_5694
    ld a, [wGameMode2Byte44]
    add a, a
    ld hl, $5A00
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, [de]
    or a, a
    ret z
    inc de
    ld b, a

Jump_0A1_5670::
    push bc
    push de
    ld a, [de]
    ld c, a
    ld a, [wCursorCellX]
    add a, a
    add a, a
    add a, a
    add a, c
    ldh [hSpriteOriginX], a
    inc de
    ld a, [de]
    ld c, a
    ld a, [wCursorCellY]
    add a, a
    add a, a
    add a, a
    add a, c
    ldh [hSpriteOriginY], a
    call DrawMetaSpriteSet26
    pop de
    inc de
    inc de
    pop bc
    dec b
    jr nz, Jump_0A1_5670
    ret

Jump_0A1_5694::
    ld de, wKeyWorldFloorInfo + $3

Jump_0A1_5697::
    ld a, [de]
    cp a, $FF
    ret z
    push de
    dec de
    dec de
    dec de
    ld a, [de]
    ld a, [wGameMode2Byte50]
    or a, a
    jr nz, Jump_0A1_56AD
    ld a, [de]
    call IsMapScreenAVisited
    or a, a
    jr z, Jump_0A1_56D2

Jump_0A1_56AD::
    ld a, [de]
    swap a
    and a, $0F
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, [wCursorCellX]
    add a, a
    add a, a
    add a, a
    add a, c
    ldh [hSpriteOriginX], a
    ld a, [de]
    and a, $0F
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, [wCursorCellY]
    add a, a
    add a, a
    add a, a
    add a, c
    ldh [hSpriteOriginY], a
    call DrawMetaSpriteSet26

Jump_0A1_56D2::
    pop de
    ld a, $04
    add a, e
    ld e, a
    jr nc, Jump_0A1_56DA
    inc d

Jump_0A1_56DA::
    jr Jump_0A1_5697

; DrawMetaSprite with set $26, sub-index 0, tile offset $10, attribute XOR $01 (origin high bytes 0) (E-0118)
; 2 call sites from 1 routine (e.g. RunGameMode2State_Case02_Sub04)
; writes: hSpriteTileOffset, hSpriteAttrXor, hSpriteSetIndex, hSpriteSubIndex, hSpriteOriginXHi, hSpriteOriginYHi
DrawMetaSpriteSet26::
Func_0A1_56DC:: ; address name
    ld a, $10
    ldh [hSpriteTileOffset], a
    ld a, $01
    ldh [hSpriteAttrXor], a
    ld a, $26
    ldh [hSpriteSetIndex], a
    xor a, a
    ldh [hSpriteSubIndex], a
    xor a, a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite
    ret

; only called from RunGameMode2State_Case02 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case02)
; reads: wMapType
; points at: wKeyWorldObjects
RunGameMode2State_Case02_Sub05::
Func_0A1_56F7:: ; address name
    ld a, [wMapType]
    bit 7, a
    ret z
    ld de, wKeyWorldObjects

Jump_0A1_5700::
    ld a, [de]
    cp a, $FF
    ret z
    push de
    dec de
    dec de
    dec de
    call RunGameMode2State_Case02_Sub05_Sub01
    inc de
    call RunGameMode2State_Case02_Sub05_Sub01
    pop de
    ld a, $04
    add a, e
    ld e, a
    jr nc, Jump_0A1_5717
    inc d

Jump_0A1_5717::
    jr Jump_0A1_5700

; only called from RunGameMode2State_Case02_Sub05 (E-0047)
; 2 call sites from 1 routine (e.g. RunGameMode2State_Case02_Sub05)
; reads: wGameMode2Byte50, wCursorCellX, wCursorCellY
; writes: hSpriteOriginX, hSpriteOriginY, hSpriteTileOffset, hSpriteAttrXor, hSpriteSetIndex, hSpriteSubIndex, hSpriteOriginXHi, hSpriteOriginYHi
RunGameMode2State_Case02_Sub05_Sub01::
Func_0A1_5719:: ; address name
    ld a, [wGameMode2Byte50]
    or a, a
    jr nz, Jump_0A1_5725
    ld a, [de]
    call IsMapScreenAVisited
    or a, a
    ret z

Jump_0A1_5725::
    ld a, [de]
    swap a
    and a, $0F
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, [wCursorCellX]
    add a, a
    add a, a
    add a, a
    add a, c
    ldh [hSpriteOriginX], a
    ld a, [de]
    and a, $0F
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, [wCursorCellY]
    add a, a
    add a, a
    add a, a
    add a, c
    ldh [hSpriteOriginY], a
    ld a, $10
    ldh [hSpriteTileOffset], a
    ld a, $01
    ldh [hSpriteAttrXor], a
    ld a, $26
    ldh [hSpriteSetIndex], a
    xor a, a
    ldh [hSpriteSubIndex], a
    xor a, a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    push de
    farcall DrawMetaSprite
    pop de
    ret

; row = 9 - C/2 (wC946), column = 10 - B/2 (wC945); HL = vBGMap0 + 32 * row + column (E-0121)
; 2 call sites from 2 routines (e.g. RunGameMode2State_Case01_Sub02, RunGameMode2State_Case01_Sub01)
; writes: wCursorCellY, wCursorCellX
CenteredBGMapOriginForSizeBC::
Func_0A1_5764:: ; address name
    ld a, c
    srl a
    ld l, a
    ld a, $09
    sub a, l
    ld [wCursorCellY], a
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $98
    ld h, a
    ld a, b
    srl a
    ld e, a
    ld a, $0A
    sub a, e
    ld [wCursorCellX], a
    add_a_to_hl
    ret

; fills the $400 bytes of vBGMap0 with tile $57 (E-0122)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case04)
FillBGMap0With57::
Func_0A1_578E:: ; address name
    ld hl, vBGMap0
    ld bc, $0400

Jump_0A1_5794::
    ld a, $57
    call WriteVRAMByteInc
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0A1_5794
    ret

; only called from RunGameMode2State_Case04 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case04)
; reads: wIsCGB
RunGameMode2State_Case04_Sub03::
Func_0A1_579F:: ; address name
    ld a, [wIsCGB]
    or a, a
    ret z
    ld c, $4F
    ld a, $01
    ldh [c], a
    ld hl, vBGMap0
    ld bc, $0400

Jump_0A1_57AF::
    xor a, a
    call WriteVRAMByteInc
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0A1_57AF
    ld c, $4F
    ld a, $00
    ldh [c], a
    ret

; only called from RunGameMode2State_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case01)
; reads: wIsCGB
RunGameMode2State_Case01_Sub03::
Func_0A1_57BE:: ; address name
    ld a, [wIsCGB]
    or a, a
    ret z
    ld c, $4F
    ld a, $01
    ldh [c], a
    ld hl, vBGMap0
    ld bc, $0400

Jump_0A1_57CE::
    ld a, $01
    call WriteVRAMByteInc
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0A1_57CE
    ld hl, vBGMap0 + $64
    ld c, $0C

Jump_0A1_57DD::
    push hl
    ld b, $0C

Jump_0A1_57E0::
    xor a, a
    call WriteVRAMByte
    inc hl
    dec b
    jr nz, Jump_0A1_57E0
    pop hl
    ld a, $20
    add_a_to_hl
    dec c
    jr nz, Jump_0A1_57DD
    ld c, $4F
    ld a, $00
    ldh [c], a
    ret

; copies a 12 x 12 tile rectangle from A1:$5808 to vBGMap0 + $64 (CopyRectFromBankToVRAM) (E-0116)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case01)
DrawRect12x12FromBankA1::
Func_0A1_57F9:: ; address name
    ld de, $5808
    ld bc, $0C0C
    ld hl, vBGMap0 + $64
    ld a, $A1
    call CopyRectFromBankToVRAM
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 12 x 12 tiles, one row per line
TileRect_A1_5808::
Data_0A1_5808:: ; address name
    db $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34 ; id 0
    db $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34 ; id 1
    db $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34 ; id 2
    db $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34 ; id 3
    db $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34 ; id 4
    db $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34 ; id 5
    db $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34 ; id 6
    db $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34 ; id 7
    db $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34 ; id 8
    db $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34 ; id 9
    db $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34 ; id 10
    db $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34 ; id 11

; wC5E0 = 3, wDataBankSave = $40, far-calls Func_002_4628, sets the default DMG palette bytes ($D2, $D2, $E2) and wGameMode = 1 (E-0118)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case06)
; writes: wFieldInitStage, wDataBankSave, wGameMode
; points at: wDMGPaletteBGP
EnterGameMode1WithDefaultPalettes::
Func_0A1_5898:: ; address name
    ld a, $03
    ld [wFieldInitStage], a
    ld a, $40
    ld [wDataBankSave], a
    farcall InitFieldScreen
    ld hl, wDMGPaletteBGP
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld a, $01
    ld [wGameMode], a
    ret

; A = 1 when the bit for screen A (high nibble x, low nibble y) is set in wCE93, else 0 (E-0125)
; 5 call sites from 5 routines (e.g. RunGameMode2State_Case02_Sub01_Sub04_Sub01, RunGameMode2State_Case02_Sub01_Sub03, RunGameMode2State_Case04_Sub01, RunGameMode2State_Case02_Sub05_Sub01, ...)
; reads: hTemp0
; writes: hTemp0
; points at: wVisitedScreens
IsMapScreenAVisited::
Func_0A1_58BA:: ; address name
    push bc
    push hl
    ldh [hTemp0], a
    and a, $0F
    and a, $FC
    ld hl, wVisitedScreens
    add_a_to_hl
    ldh a, [hTemp0]
    swap a
    and a, $0F
    srl a
    and a, $FE
    add_a_to_hl
    ldh a, [hTemp0]
    bit 1, a
    jr z, Jump_0A1_58E0
    inc hl

Jump_0A1_58E0::
    ld c, $01
    bit 0, a
    jr z, Jump_0A1_58E8
    ld c, $10

Jump_0A1_58E8::
    ldh a, [hTemp0]
    swap a
    and a, $03
    jr z, Jump_0A1_58F6
    ld b, a

Jump_0A1_58F1::
    sla c
    dec b
    jr nz, Jump_0A1_58F1

Jump_0A1_58F6::
    ld a, [hl]
    and a, c
    jr nz, Jump_0A1_58FE
    xor a, a
    pop hl
    pop bc
    ret

Jump_0A1_58FE::
    ld a, $01
    pop hl
    pop bc
    ret

; only called from routines of FieldModeStateDispatch (E-0098)
; 2 call sites from 2 routines (e.g. FieldModeStateDispatch_Case00, FieldModeStateDispatch_Case05)
; reads: wFadeState, wTextWindowState, wFieldActionRequest, hPlayerStateFlags, wMapType, hMapId
; writes: hTemp0, wGameMode2Byte44, wFieldReturnPhase, wModeState, wGameMode2State
FieldModeStateDispatch_Shared04::
Func_0A1_5903:: ; address name
    xor a, a
    ldh [hTemp0], a
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wTextWindowState]
    and a, $03
    ret nz
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ldh a, [hPlayerStateFlags]
    bit 0, a
    ret nz
    ld a, [wMapType]
    bit 7, a
    jp nz, Jump_0A1_59AE
    ldh a, [hMapId]
    cp a, $20
    ret c
    ld c, $00
    cp a, $30
    jr c, Jump_0A1_595D
    inc c
    cp a, $48
    jr c, Jump_0A1_595D
    inc c
    cp a, $70
    jr c, Jump_0A1_595D
    inc c
    cp a, $A0
    jr c, Jump_0A1_595D
    inc c
    cp a, $A8
    jr c, Jump_0A1_595D
    inc c
    cp a, $B0
    jr c, Jump_0A1_595D
    inc c
    cp a, $B8
    jr c, Jump_0A1_595D
    inc c
    cp a, $C8
    jr c, Jump_0A1_595D
    inc c
    cp a, $D1
    jr c, Jump_0A1_595D
    inc c
    cp a, $DA
    jr c, Jump_0A1_595D
    inc c

Jump_0A1_595D::
    ld a, c
    ld [wGameMode2Byte44], a
    ld a, $01
    ldh [hTemp0], a
    ld a, $01
    ld [wFieldReturnPhase], a
    farcall SaveScreenBufferToBGMap1
    ld a, $08
    ld [wModeState], a
    ldh a, [hMapId]
    cp a, $20
    jr z, Jump_0A1_59A9
    cp a, $30
    jr z, Jump_0A1_59A9
    cp a, $48
    jr z, Jump_0A1_59A9
    cp a, $70
    jr z, Jump_0A1_59A9
    cp a, $A0
    jr z, Jump_0A1_59A9
    cp a, $A8
    jr z, Jump_0A1_59A9
    cp a, $B0
    jr z, Jump_0A1_59A9
    cp a, $B8
    jr z, Jump_0A1_59A9
    cp a, $C8
    jr z, Jump_0A1_59A9
    cp a, $D1
    jr z, Jump_0A1_59A9
    cp a, $DA
    jr z, Jump_0A1_59A9
    ld a, $03
    ld [wGameMode2State], a
    ret

Jump_0A1_59A9::
    xor a, a
    ld [wGameMode2State], a
    ret

Jump_0A1_59AE::
    ld a, $01
    ldh [hTemp0], a
    ld a, $01
    ld [wFieldReturnPhase], a
    farcall SaveScreenBufferToBGMap1
    ld a, $08
    ld [wModeState], a
    ld a, [wMapType]
    and a, $7F
    jr nz, Jump_0A1_59CE
    xor a, a
    ld [wGameMode2State], a
    ret

Jump_0A1_59CE::
    ld a, $03
    ld [wGameMode2State], a
    ret
    db $01, $01, $00, $44, $39, $31, $76, $44, $59, $21, $B4, $44, $59, $21, $B4, $44
    db $09, $01, $10, $44, $01, $01, $00, $44, $01, $09, $01, $44, $21, $21, $44, $44
    db $01, $09, $01, $44, $01, $01, $00, $44, $01, $01, $00, $44
    dw Data_0A1_5A16
    dw Data_0A1_5A1B
    dw Data_0A1_5A22
    dw Data_0A1_5A2D
    dw Data_0A1_5A34
    dw Data_0A1_5A35
    dw Data_0A1_5A38
    dw Data_0A1_5A3B
    dw Data_0A1_5A40
    dw Data_0A1_5A43
    dw Data_0A1_5A46

Data_0A1_5A16:: ; heuristic: target of a monotone pointer table; C0
    db $02, $11, $09, $11, $29

Data_0A1_5A1B:: ; heuristic: target of a monotone pointer table; C0
    db $03, $29, $31, $21, $11, $11, $21

Data_0A1_5A22:: ; heuristic: target of a monotone pointer table; C0
    db $05, $41, $11, $39, $29, $21, $41, $11, $49, $49, $49

Data_0A1_5A2D:: ; heuristic: target of a monotone pointer table; C0
    db $03, $59, $09, $29, $31, $29, $49

Data_0A1_5A34:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_0A1_5A35:: ; heuristic: target of a monotone pointer table; C0
    db $01, $11, $21

Data_0A1_5A38:: ; heuristic: target of a monotone pointer table; C0
    db $01, $09, $01

Data_0A1_5A3B:: ; heuristic: target of a monotone pointer table; C0
    db $02, $21, $19, $09, $09

Data_0A1_5A40:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $01

Data_0A1_5A43:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $09

Data_0A1_5A46:: ; heuristic: target of a monotone pointer table; C0
    db $01, $09, $01
    dw Data_0A1_5A5F
    dw Data_0A1_5A64
    dw Data_0A1_5A6B
    dw Data_0A1_5A76
    dw Data_0A1_5A7D
    dw Data_0A1_5A7E
    dw Data_0A1_5A81
    dw Data_0A1_5A84
    dw Data_0A1_5A89
    dw Data_0A1_5A8C
    dw Data_0A1_5A8F

Data_0A1_5A5F:: ; heuristic: target of a monotone pointer table; C0
    db $02, $21, $44, $25, $44

Data_0A1_5A64:: ; heuristic: target of a monotone pointer table; C0
    db $03, $56, $44, $42, $44, $24, $44

Data_0A1_5A6B:: ; heuristic: target of a monotone pointer table; C0
    db $05, $82, $44, $75, $44, $48, $44, $29, $44, $99, $44

Data_0A1_5A76:: ; heuristic: target of a monotone pointer table; C0
    db $03, $B1, $44, $56, $64, $59, $44

Data_0A1_5A7D:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_0A1_5A7E:: ; heuristic: target of a monotone pointer table; C0
    db $01, $24, $44

Data_0A1_5A81:: ; heuristic: target of a monotone pointer table; C0
    db $01, $10, $44

Data_0A1_5A84:: ; heuristic: target of a monotone pointer table; C0
    db $02, $43, $44, $11, $35

Data_0A1_5A89:: ; heuristic: target of a monotone pointer table; C0
    db $01, $00, $44

Data_0A1_5A8C:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $44

Data_0A1_5A8F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $285A8F, $101
    dw Data_0A1_5C00
    db $11, $49, $00
    dw Data_0A1_5D00
    db $28, $51, $00
    dw Data_0A1_5E00
    db $49, $49, $00
    dw Data_0A1_5F00
    db $49, $49, $00
    dw Data_0A1_6000
    db $49, $49, $00
    dw Data_0A1_6100
    db $49, $49, $00
    dw Data_0A1_6200
    db $51, $29, $00
    dw Data_0A1_6300
    db $41, $39, $00
    dw Data_0A1_6400
    db $41, $39, $00
    dw Data_0A1_6500
    db $41, $39, $00
    dw Data_0A1_6600
    db $41, $39, $00
    dw Data_0A1_6700
    db $41, $39, $00
    dw Data_0A1_7100
    db $59, $09, $00
    dw Data_0A1_7200
    db $59, $09, $00
    dw Data_0A1_7300
    db $59, $09, $00
    dw Data_0A1_7400
    db $59, $09, $00
    dw Data_0A1_7500
    db $59, $09, $00
    dw Data_0A1_7600
    db $59, $09, $00
    dw Data_0A1_7700
    db $51, $21, $49
    dw Data_0A1_7821
    db $29, $31, $00
    dw Data_0A1_7900
    db $29, $31, $00
    dw Data_0A1_7A00
    db $01, $21, $00
    dw Data_0A1_7B00

Data_0A1_5C00:: ; heuristic: target of a monotone pointer table; C0
    db $19, $31, $19
    dw Data_0A1_7C39
    db $29, $49, $00
    dw Data_0A1_7D00
    db $29, $49, $00
    dw Data_0A1_7E00
    db $29, $49, $00
    dw Data_0A1_7F00
    INCBIN "dwm2-cobi-us.gbc", $285C14, $EC

Data_0A1_5D00:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $285D00, $45

Data_0A1_5D45:: ; heuristic: target of a monotone pointer table; C0
    db $01, $09, $00, $00, $D3, $01

Data_0A1_5D4B:: ; heuristic: target of a monotone pointer table; C0
    db $09, $00, $00, $D4, $01, $09, $00

Data_0A1_5D52:: ; heuristic: target of a monotone pointer table; C0
    db $00, $D5, $01, $09, $00, $00, $D6, $01, $09, $00, $00, $D7, $01, $09

Data_0A1_5D60:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $DB, $09, $01, $00, $00, $DC, $09, $01, $00, $00, $DD, $09

Data_0A1_5D6E:: ; heuristic: target of a monotone pointer table; C0
    db $01

Data_0A1_5D6F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $DE

Data_0A1_5D72:: ; heuristic: target of a monotone pointer table; C0
    db $09

Data_0A1_5D73:: ; heuristic: target of a monotone pointer table; C0
    db $01, $00

Data_0A1_5D75:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_0A1_5D76:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $285D76, $8A

Data_0A1_5E00:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $285E00, $8D
    dw Data_0A1_5F00
    db $99, $44, $00
    dw Data_0A1_6000
    db $99, $44, $00
    dw Data_0A1_6100
    db $99, $44, $00
    dw Data_0A1_6200
    db $A5, $44, $00
    dw Data_0A1_6300
    db $87, $44, $00
    dw Data_0A1_6400
    db $87, $44, $00
    dw Data_0A1_6500
    db $87, $44, $00
    dw Data_0A1_6600
    db $87, $44, $00
    dw Data_0A1_6700
    db $87, $44, $00
    dw Data_0A1_7100
    db $B1, $44, $00
    dw Data_0A1_7200
    db $B1, $44, $00
    dw Data_0A1_7300
    db $B1, $44, $00
    dw Data_0A1_7400
    db $B1, $44, $00
    dw Data_0A1_7500
    db $B1, $44, $00
    dw Data_0A1_7600
    db $B1, $44, $00
    dw Data_0A1_7700
    db $A4, $44, $94
    dw Data_0A1_7844
    db $56, $44, $00
    dw Data_0A1_7900
    db $56, $44, $00
    dw Data_0A1_7A00
    db $04, $44, $00
    dw Data_0A1_7B00
    db $36, $44, $37
    dw Data_0A1_7C44
    db $59, $44, $00
    dw Data_0A1_7D00
    db $59, $44, $00
    dw Data_0A1_7E00
    db $59, $44, $00

Data_0A1_5F00:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0A1_7F00
    INCBIN "dwm2-cobi-us.gbc", $285F02, $FE

Data_0A1_6000:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $286000, $6C
    ds $94, $00

Data_0A1_6100:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_6200:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_6300:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_6400:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_6500:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_6600:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_6700:: ; heuristic: target of a monotone pointer table; C0
    ds $A00, $00

Data_0A1_7100:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_7200:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_7300:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_7400:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_7500:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_7600:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_7700:: ; heuristic: target of a monotone pointer table; C0
    ds $121, $00

Data_0A1_7821:: ; heuristic: target of a monotone pointer table; C0
    ds $23, $00

Data_0A1_7844:: ; heuristic: target of a monotone pointer table; C0
    ds $BC, $00

Data_0A1_7900:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_7A00:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_7B00:: ; heuristic: target of a monotone pointer table; C0
    ds $139, $00

Data_0A1_7C39:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_0A1_7C44:: ; heuristic: target of a monotone pointer table; C0
    ds $BC, $00

Data_0A1_7D00:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_7E00:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_7F00:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00
