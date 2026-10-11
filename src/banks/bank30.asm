SECTION "Bank 30", ROMX[$4000], BANK[$30]
    db $30

; battle fight step 2: returns while a message is being drawn (wC52B); otherwise one of 7 sub-steps by wBattleSubPhase; case 0 loads the slots' personality bytes (wSlotPersonality*), the command menu loop follows
; 1 call site from 1 routine (e.g. BattleFight_Step2)
; reads: wTextFlags, wBattleSubPhase
RunBattleCommandEntry::
Func_030_4001:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wBattleSubPhase]
    rst $00
    dw RunBattleCommandEntry_Case00
    dw RunBattleCommandEntry_Case01
    dw RunBattleCommandEntry_Case02
    dw RunBattleCommandEntry_Case03
    dw RunBattleCommandEntry_Case04
    dw RunBattleCommandEntry_Case05
    dw RunBattleCommandEntry_Case06

; entry 0 of the `rst $00` table in RunBattleCommandEntry
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wBattlePartyCount
; writes: wCommandByteE8
; points at: wBattleSubPhase, wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo, wSlotTrait
RunBattleCommandEntry_Case00::
Jump_030_4018:: ; address name
    ld hl, wBattleSubPhase
    inc [hl]
    ld a, [wLinkMode]
    or a, a
    ret nz
    xor a, a
    ld [wCommandByteE8], a
    ld a, [wBattlePartyCount]
    ld b, a
    ld c, $00
    ld hl, wSlotPersonalityHi
    ld de, $0000
    call RunBattleCommandEntry_Case00_Sub01
    ld a, [wBattlePartyCount]
    ld b, a
    ld c, $00
    ld hl, wSlotPersonalityMid
    push de
    ld de, $0000
    call RunBattleCommandEntry_Case00_Sub01
    pop hl
    ld a, l
    sub a, e
    ld a, h
    sbc a, d
    jr nc, Jump_030_4052
    ld h, d
    ld l, e
    ld a, $01
    ld [wCommandByteE8], a

Jump_030_4052::
    push hl
    ld a, [wBattlePartyCount]
    ld b, a
    ld c, $00
    ld hl, wSlotPersonalityLo
    ld de, $0000
    call RunBattleCommandEntry_Case00_Sub01
    pop hl
    ld a, l
    sub a, e
    ld a, h
    sbc a, d
    jr nc, Jump_030_4070
    ld h, d
    ld l, e
    ld a, $02
    ld [wCommandByteE8], a

Jump_030_4070::
    push hl
    ld a, [wBattlePartyCount]
    ld b, a
    ld c, $00
    ld hl, wSlotTrait
    ld de, $0000
    call RunBattleCommandEntry_Case00_Sub01
    pop hl
    ld a, l
    sub a, e
    ld a, h
    sbc a, d
    jr nc, Jump_030_408C
    ld a, $03
    ld [wCommandByteE8], a

Jump_030_408C::
    ret

; only called from RunBattleCommandEntry_Case00 (E-0047)
; 4 call sites from 1 routine (e.g. RunBattleCommandEntry_Case00)
RunBattleCommandEntry_Case00_Sub01::
Func_030_408D:: ; address name
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_030_409A
    ld a, e
    add a, [hl]
    ld e, a
    ld a, d
    adc a, $00
    ld d, a

Jump_030_409A::
    inc hl
    inc c
    dec b
    jr nz, RunBattleCommandEntry_Case00_Sub01
    ret

; entry 1 of the `rst $00` table in RunBattleCommandEntry
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wBattleActor
; writes: wBattleActor, wBattleResolveStep
; points at: wSlotMarks, wBattleSubPhase
RunBattleCommandEntry_Case01::
Jump_030_40A0:: ; address name
    ld a, [wLinkMode]
    or a, a
    call nz, NextTableByteSecondStream
    ld a, [wBattleActor]
    cp a, $08
    jr z, Jump_030_40D6
    ld e, a
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    cp a, $01
    jr z, Jump_030_40C3

Jump_030_40BC::
    inc e
    ld a, e
    ld [wBattleActor], a
    jr Jump_030_40E2

Jump_030_40C3::
    ld a, e
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_030_40BC
    ld [wBattleActor], a
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleResolveStep], a
    jr Jump_030_40E2

Jump_030_40D6::
    ld hl, wBattleSubPhase
    inc [hl]
    ld hl, wBattleSubPhase
    inc [hl]
    ld hl, wBattleSubPhase
    inc [hl]

Jump_030_40E2::
    ret

; entry 2 of the `rst $00` table in RunBattleCommandEntry
; no direct call (reached through a table, a jump or a vector)
RunBattleCommandEntry_Case02::
Jump_030_40E3:: ; address name
    call RunBattleResolveStep_43C4
    ret

; entry 3 of the `rst $00` table in RunBattleCommandEntry
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wBattleSubPhase
; points at: wSlotMarks, wBattleActor
RunBattleCommandEntry_Case03::
Jump_030_40E7:: ; address name
    call ChooseTargetForActor
    ld a, [wBattleActor]
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, $02
    ld [hl], a
    ld a, $01
    ld [wBattleSubPhase], a
    ld hl, wBattleActor
    inc [hl]
    ret

; uses the preset target when the side is player-controlled, bit 7 of its wDAD8 byte is clear and wBattleTargetChoice is set; otherwise ChooseActionTarget; stores the result (E-0125)
; 5 call sites from 4 routines (e.g. RunBattleCommandEntry_Case03, ActionEffect_Chance, RunBattleActions_Case06, RunMultiHitCounter)
; reads: wLinkMode, wMenuState, wBattleActor
; points at: wSideControl, wBattleTargetChoice, wCommandBytesE9
ChooseTargetForActor::
Func_030_4102:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr z, Jump_030_4112
    cp a, $02
    jr z, Jump_030_4149
    ld a, [wMenuState]
    jr Jump_030_4122

Jump_030_4112::
    ld a, [wBattleActor]
    rrca
    rrca
    and a, $01
    ld hl, wCommandBytesE9
    add_a_to_hl
    ld a, [hl]

Jump_030_4122::
    and a, $03
    cp a, $01
    jr nz, Jump_030_4149
    ld a, [wBattleActor]
    ld hl, wSideControl
    add_a_to_hl
    bit 7, [hl]
    jr nz, Jump_030_4149
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jp nz, Jump_030_4151

Jump_030_4149::
    farcall ChooseActionTarget
    jr Jump_030_4152

Jump_030_4151::
    ld d, a

Jump_030_4152::
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld d, [hl]
    ret

; entry 4 of the `rst $00` table in RunBattleCommandEntry
; no direct call (reached through a table, a jump or a vector)
; reads: wLoadSlot
; writes: wActionQueuePos, wLoadSlot, wBattleTemp7A, wBattleTemp7B
; points at: wActionQueue, wBattleArg0, wBattleTemp7D, wSlotMarks, wBattleTemp7A, wLoadSlot, wBattleSubPhase
RunBattleCommandEntry_Case04::
Jump_030_4160:: ; address name
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

Jump_030_4196::
    ld a, e
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_030_41D2
    ld a, e
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    cp a, $02
    jr nz, Jump_030_41D2
    ld a, e
    call RunBattleCommandEntry_Case04_Sub01
    call RunBattleCommandEntry_Case04_Sub02
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

Jump_030_41D2::
    inc e
    dec d
    jp nz, Jump_030_4196
    call RunBattleCommandEntry_Case04_Sub03
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; only called from RunBattleCommandEntry_Case04 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleCommandEntry_Case04)
; points at: wBattleAGL
RunBattleCommandEntry_Case04_Sub01::
Func_030_41DF:: ; address name
    push de
    call AdvanceRandom
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

; only called from RunBattleCommandEntry_Case04 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleCommandEntry_Case04)
; reads: wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3, wRecordBufferData, wRandomLo
; writes: wRecordBuffer, wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3
; points at: wBattleActionChoice
RunBattleCommandEntry_Case04_Sub02::
Func_030_4203:: ; address name
    push de
    ld a, e
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $62
    jr z, Jump_030_4275
    cp a, $69
    jr z, Jump_030_427F
    cp a, $D8
    jr z, Jump_030_4275
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
    jr nz, Jump_030_427A
    ld hl, $000A
    jr Jump_030_4292

Jump_030_4275::
    ld hl, $0BB8
    jr Jump_030_4292

Jump_030_427A::
    ld hl, $03E8
    jr Jump_030_4292

Jump_030_427F::
    call AdvanceRandom
    ld a, [wRandomLo]
    ld b, a
    ld a, $09
    call DivideBByA
    add a, $01
    ld c, a
    ld b, $00
    jr Jump_030_4295

Jump_030_4292::
    add hl, bc
    ld c, l
    ld b, h

Jump_030_4295::
    pop de
    ret

; only called from RunBattleCommandEntry_Case04 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleCommandEntry_Case04)
; reads: wBattleFlag92, wLoadSlot
; points at: wBattleTemp7A, wBattleArg0
RunBattleCommandEntry_Case04_Sub03::
Func_030_4297:: ; address name
    ld a, [wBattleFlag92]
    cp a, $FF
    ret z
    ld bc, $07DA
    ld hl, wBattleTemp7A
    deref_hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wLoadSlot]
    ld hl, wBattleArg0
    add_a_to_hl
    ld [hl], $10
    ret

; entry 5 of the `rst $00` table in RunBattleCommandEntry
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTemp7A, wBattleTemp7B, wBattleDamageLo, wBattleDamageHi, wTargetEstimates, wActionQueuePos
; writes: wBattleTemp7A, wBattleTemp7B, wBattleDamageLo, wBattleDamageHi, wTargetEstimates, wActionQueuePos
; points at: wBattleTemp7D, wBattleTemp7F, wBattleArg0, wBattleTemp7A, wActionQueue, wBattleSubPhase
RunBattleCommandEntry_Case05::
Jump_030_42B7:: ; address name
    ld d, $08

Jump_030_42B9::
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

Jump_030_42CF::
    call CompareHLToBC
    jr c, Jump_030_4309
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

Jump_030_4309::
    inc e
    ld a, e
    cp a, d
    jr z, Jump_030_4322
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
    jr Jump_030_42CF

Jump_030_4322::
    dec d
    jr nz, Jump_030_42B9
    ld a, [wActionQueuePos]
    ld de, wActionQueue
    add a, e
    ld e, a
    jr nc, Jump_030_4330
    inc d

Jump_030_4330::
    ld a, [wActionQueuePos]
    ld hl, wBattleArg0
    ld b, $09

Jump_030_4338::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_030_4342
    ld [de], a
    inc de
    dec b
    jr nz, Jump_030_4338

Jump_030_4342::
    ld a, $00
    ld [wActionQueuePos], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunBattleCommandEntry
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleCommandArgs, wBattleSubPhase
; points at: wBattleHP, wBattleMaxHP, wBattleStep, wBattleResolveStep
RunBattleCommandEntry_Case06::
Jump_030_434C:: ; address name
    ld hl, wBattleHP
    ld bc, $0000
    call AddWordAtHLToBC_Bank30
    call AddWordAtHLToBC_Bank30
    call AddWordAtHLToBC_Bank30
    ld a, c
    ld [wBattleCommandArgs], a
    ld a, b
    ld [wBattleCommandArgs + $1], a
    ld hl, wBattleMaxHP
    ld bc, $0000
    call AddWordAtHLToBC_Bank30
    call AddWordAtHLToBC_Bank30
    call AddWordAtHLToBC_Bank30
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
    call RunBattleCommandEntry_Case06_Sub01
    ret

; BC += the word at [HL]; HL += 2; clobbers A (the same 7 bytes appear in 2 banks)
; 6 call sites from 1 routine (e.g. RunBattleCommandEntry_Case06)
AddWordAtHLToBC_Bank30::
Func_030_4396:: ; address name
    ld a, [hl+]
    add a, c
    ld c, a
    ld a, [hl+]
    adc a, b
    ld b, a
    ret

; only called from RunBattleCommandEntry_Case06 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleCommandEntry_Case06)
; points at: wBattleActionChoice, wBattleStatus6
RunBattleCommandEntry_Case06_Sub01::
Func_030_439D:: ; address name
    ld c, $00
    ld b, $08

Jump_030_43A1::
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_030_43BF
    ld a, c
    add a, a
    ld hl, wBattleActionChoice
    add_a_to_hl
    ld a, [hl]
    cp a, $6E
    jr nz, Jump_030_43BF
    ld a, c
    ld hl, wBattleStatus6
    call AddAx9ToHL
    set 2, [hl]

Jump_030_43BF::
    inc c
    dec b
    jr nz, Jump_030_43A1
    ret

; runs the routine for wBattleResolveStep (jump table of four) (E-0122)
; 2 call sites from 2 routines (e.g. RunBattleCommandEntry_Case02, RunBattleCommandEntry_BankA1_Case02)
; reads: wBattleResolveStep
RunBattleResolveStep_43C4::
Func_030_43C4:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw RunBattleResolveStep_43C4_Case00
    dw RunBattleResolveStep_43C4_Case01
    dw AIChooseActionResolveStep
    dw RunBattleResolveStep_43C4_Case03

; entry 0 of the `rst $00` table in RunBattleResolveStep_43C4
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wLinkMode, wMenuState, wCommandBytesE9
; writes: wPersonalityIndex
; points at: wCommandBytesE9, wBattleResolveStep
RunBattleResolveStep_43C4_Case00::
Jump_030_43D0:: ; address name
    ld a, [wBattleActor]
    call PersonalityIndexOfSlot_Bank30
    ld [wPersonalityIndex], a
    call ForcedActionForActorStatus
    jr nz, Jump_030_4414
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_030_440B
    cp a, $02
    jr z, Jump_030_43FA
    ld a, [wBattleActor]
    rrca
    rrca
    and a, $01
    ld hl, wCommandBytesE9
    add_a_to_hl
    ld a, [hl]
    jr Jump_030_440E

Jump_030_43FA::
    ld a, [wBattleActor]
    cp a, $01
    jr z, Jump_030_4406
    ld a, [wMenuState]
    jr Jump_030_440E

Jump_030_4406::
    ld a, [wCommandBytesE9]
    jr Jump_030_440E

Jump_030_440B::
    ld a, [wMenuState]

Jump_030_440E::
    and a, $03
    cp a, $01
    jr z, Jump_030_4418

Jump_030_4414::
    ld hl, wBattleResolveStep
    inc [hl]

Jump_030_4418::
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunBattleResolveStep_43C4
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wBattleActor, wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3
; writes: wBattleStatResultLo, wBattleResolveStep
; points at: wBattleResolveStep, wBattleArg0, wBattleStatus, wResolveBytesE0, wBattleActionChoice, wSideControl
RunBattleResolveStep_43C4_Case01::
Jump_030_441D:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleStatResultLo], a
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_030_4431
    cp a, $02
    jr z, Jump_030_4431
    jr Jump_030_4438

Jump_030_4431::
    ld a, [wBattleActor]
    cp a, $04
    jr nc, Jump_030_4480

Jump_030_4438::
    ld a, $01
    ld [wBattleStatResultLo], a
    ld hl, wBattleArg0
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 6, [hl]
    jr nz, Jump_030_4480
    call ActorBattleWordArray3FBand
    or a, a
    jr z, Jump_030_4480
    cp a, $01
    jr z, Jump_030_4497
    call RunBattleResolveStep_43C4_Case01_Sub01
    call RunBattleResolveStep_43C4_Case01_Sub02
    call AddPersonalityWeightToBattleArg0
    call AddActorBattleWordArray3FDiv16ToBattleArg2
    call AddRandom0To63ToBattleArg2
    ld a, [wBattleArg0]
    ld l, a
    ld a, [wBattleArg1]
    ld h, a
    ld a, [wBattleArg2]
    ld c, a
    ld a, [wBattleArg3]
    ld b, a
    call CompareHLToBC
    jr c, Jump_030_4497

Jump_030_4480::
    call GetActorSlotTacticLow2
    res 6, [hl]
    ld a, [wBattleActor]
    ld hl, wResolveBytesE0
    add_a_to_hl
    ld [hl], $00
    call RunBattleResolveStep_43C4_Case01_Sub04
    jr Jump_030_44DF

Jump_030_4497::
    call GetActorSlotTacticLow2
    set 6, [hl]
    ld a, [wBattleActor]
    ld hl, wResolveBytesE0
    add_a_to_hl
    ld [hl], $01
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    call AddDoubleAToHL_Bank30
    ld a, $FF
    ld [hl+], a
    ld [hl], a
    ld a, [wBattleActor]
    ld hl, wSideControl
    add_a_to_hl
    set 7, [hl]
    call RunBattleResolveStep_43C4_Case01_Sub04
    call RunBattleResolveStep_43C4_Case01_Sub03
    ld a, $03
    ld [wBattleResolveStep], a
    ld a, [wBattleActor]
    and a, $03
    cp a, $03
    jr z, Jump_030_44DF
    ld d, $28
    farcall ShowBattleTextCategory0

Jump_030_44DF::
    ret

; A = 0 when the actor's wD93F word is below $33, 2 when below $3B6, otherwise 3 (E-0122)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_43C4_Case01)
; reads: wBattleActor
; points at: wBattleWordArray3F
ActorBattleWordArray3FBand::
Func_030_44E0:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleWordArray3F
    add a, a
    add_a_to_hl
    deref_hl
    ld bc, $0033
    call CompareHLToBC
    ld a, $00
    jr c, Jump_030_4505
    ld bc, $03B6
    call CompareHLToBC
    ld a, $02
    jr c, Jump_030_4505
    ld a, $03

Jump_030_4505::
    ret

; only called from RunBattleResolveStep_43C4_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_43C4_Case01)
; reads: wBattleActor
; points at: wSlotTrait, wBattleArg0
RunBattleResolveStep_43C4_Case01_Sub01::
Func_030_4506:: ; address name
    ld hl, wSlotTrait
    jr Jump_030_451F

; only called from RunBattleResolveStep_43C4_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_43C4_Case01)
; reads: wBattleActor
; points at: wBattleArg0
RunBattleResolveStep_43C4_Case01_Sub02::
Func_030_450B:: ; address name
    call GetActorSlotTacticLow2
    cp a, $03
    ret z
    ld hl, Data_030_4519
    call ReadBattleWordFromArray_Bank30
    jr Jump_030_451F

; address loaded by RunBattleResolveStep_43C4_Case01_Sub02
Data_030_4519:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $68, $D9, $70, $D9, $78, $D9

Jump_030_451F::
    ld a, [wBattleActor]
    add_a_to_hl
    ld a, [hl]
    srl a
    srl a
    ld hl, wBattleArg0
    add a, [hl]
    ld [hl+], a
    ld a, $00
    adc a, [hl]
    ld [hl], a
    ret

; the word wD868 += Data_030_5587[wPersonalityIndex * 4 + (wDA43[actor] & 3)] (E-0120)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_43C4_Case01)
; reads: wPersonalityIndex
; points at: wBattleArg0
AddPersonalityWeightToBattleArg0::
Func_030_4536:: ; address name
    ld a, [wPersonalityIndex]
    add a, a
    add a, a
    ld hl, Data_030_5587
    add_a_to_hl
    push hl
    call GetActorSlotTacticLow2
    pop hl
    add_a_to_hl
    ld a, [hl]
    ld hl, wBattleArg0
    add a, [hl]
    ld [hl+], a
    ld a, $00
    adc a, [hl]
    ld [hl], a
    ret

; adds the actor's wD93F word / 16 to the word wD86A (E-0122)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_43C4_Case01)
; reads: wBattleActor, wBattleArg2, wBattleArg3
; writes: wBattleArg2, wBattleArg3
; points at: wBattleWordArray3F
AddActorBattleWordArray3FDiv16ToBattleArg2::
Func_030_4558:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleWordArray3F
    add a, a
    add_a_to_hl
    deref_hl
    srl h
    rr l
    srl h
    rr l
    srl h
    rr l
    srl h
    rr l
    jr Jump_030_4586

; adds a random value 0-63 (wC5E7 & $3F) to the word wD86A (E-0122)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_43C4_Case01)
; reads: wRandomLo, wBattleArg2, wBattleArg3
; writes: wBattleArg2, wBattleArg3
AddRandom0To63ToBattleArg2::
Func_030_4579:: ; address name
    call AdvanceRandom
    ld a, [wRandomLo]
    and a, $3F
    ld l, a
    ld h, $00
    jr Jump_030_4586

Jump_030_4586::
    ld a, [wBattleArg2]
    add a, l
    ld [wBattleArg2], a
    ld a, [wBattleArg3]
    adc a, h
    ld [wBattleArg3], a
    ret

; when the actor has no forced action and bit 7 of its wDAD8 byte is set, initialises the AI weights and runs the routine for its AI mode; a forced action is stored directly; then wBattleResolveStep += 1 (E-0124)
; 2 call sites from 1 routine (e.g. RunDebugState_E0_Case0D_Case01_Sub01)
; reads: wBattleActor
; writes: wAIFlag
; points at: wSideControl, wSlotAIMode, wBattleResolveStep
AIChooseActionResolveStep::
Func_030_4595:: ; address name
    call ForcedActionForActorStatus
    jr nz, Jump_030_45C7
    ld a, [wBattleActor]
    ld hl, wSideControl
    add_a_to_hl
    bit 7, [hl]
    jr z, Jump_030_45CB
    call InitAIWeightsForActor
    xor a, a
    ld [wAIFlag], a
    ld a, [wBattleActor]
    ld hl, wSlotAIMode
    add_a_to_hl
    ld a, [hl]
    ld hl, Data_030_45D0
    call ReadBattleWordFromArray_Bank30
    call JumpToHL
    jr Jump_030_45CB

Jump_030_45C7::
    call ActorActionChoiceAddress
    ld [hl], b

Jump_030_45CB::
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; address loaded by AIChooseActionResolveStep, AIChooseActionForActor
Data_030_45D0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $46, $49
    dw ScoreActionsWithAIScoreTableA
    dw ScoreActionsWithAIScoreTableA
    dw ScoreActionsWithAIScoreTableA
    dw UseAIScoreTableB

; clears wD2AD ($14 bytes), sets wDA3C-wDA42 = 0, 0, 0, 1, 2, 3, 3, then adds personality, HP and other weights (Func_030_4617, 46BA, 47B9, 483F); wD871 = 0 (E-0124)
; 1 call site from 1 routine (e.g. AIChooseActionResolveStep)
; writes: wAIChoiceWeights, wAIChoiceOrder, wAIChoiceIndex, wLoadSlot
; points at: wAIWeights
InitAIWeightsForActor::
Func_030_45DA:: ; address name
    ld hl, wAIWeights
    ld bc, $0014
    xor a, a
    call FillBytes
    xor a, a
    ld [wAIChoiceWeights], a
    ld [wAIChoiceWeights + $1], a
    ld [wAIChoiceWeights + $2], a
    ld a, $01
    ld [wAIChoiceOrder], a
    ld a, $02
    ld [wAIChoiceOrder + $1], a
    ld a, $03
    ld [wAIChoiceOrder + $2], a
    ld a, $03
    ld [wAIChoiceIndex], a
    call AddCommandWeightToAIChoiceWeights
    call AddActorPersonalityTensToAIChoiceWeights
    call AddStatusAndHPWeightsToAI
    call AddRandomPersonalityWeights
    call SortThreeAIWeightsRandomTies
    ld a, $00
    ld [wLoadSlot], a
    ret

; for player-side actors: with battle command 1 adds $2D to wDA3C[actor's wDA43 mode] (unless 3), otherwise $14 to wDA3C[wDA4B & 3] (E-0127)
; 2 call sites from 2 routines (e.g. InitAIWeightsForActor, AIChooseActionForActor_Sub01)
; reads: wLinkMode, wBattleActor, wMenuState, wCommandBytesE9
; points at: wAIChoiceWeights, wSlotLastTactic, wCommandBytesE9
AddCommandWeightToAIChoiceWeights::
Func_030_4617:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_030_4646
    cp a, $02
    jr nz, Jump_030_4634
    ld a, [wBattleActor]
    cp a, $04
    jr nc, Jump_030_4687
    cp a, $00
    ld a, [wMenuState]
    jr z, Jump_030_4650
    ld a, [wCommandBytesE9]
    jr Jump_030_4650

Jump_030_4634::
    ld a, [wBattleActor]
    rrca
    rrca
    and a, $01
    ld hl, wCommandBytesE9
    add_a_to_hl
    ld a, [hl]
    jr Jump_030_4650

Jump_030_4646::
    ld a, [wBattleActor]
    cp a, $04
    jr nc, Jump_030_4687
    ld a, [wMenuState]

Jump_030_4650::
    and a, $03
    cp a, $01
    jr nz, Jump_030_466C
    call GetActorSlotTacticLow2
    cp a, $03
    jr z, Jump_030_4687
    ld hl, wAIChoiceWeights
    add_a_to_hl
    ld e, $2D
    call AddSignedEToByteAtHLClamped
    jr Jump_030_4687

Jump_030_466C::
    ld a, [wBattleActor]
    ld hl, wSlotLastTactic
    add_a_to_hl
    ld a, [hl]
    and a, $03
    ld hl, wAIChoiceWeights
    add_a_to_hl
    ld e, $14
    call AddSignedEToByteAtHLClamped

Jump_030_4687::
    ret

; for the actor's three personality bytes (Hi, Mid, Lo) adds value / 10 to wDA3C + 0, 1, 2 (Func_030_5428) (E-0122)
; 2 call sites from 2 routines (e.g. InitAIWeightsForActor, AIChooseActionForActor_Sub01)
; reads: wBattleActor
; points at: wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo, wAIChoiceWeights
AddActorPersonalityTensToAIChoiceWeights::
Func_030_4688:: ; address name
    ld hl, wSlotPersonalityHi
    ld a, $00
    call AddActorPersonalityTensForIndexA
    ld hl, wSlotPersonalityMid
    ld a, $01
    call AddActorPersonalityTensForIndexA
    ld hl, wSlotPersonalityLo
    ld a, $02

; B = [HL + actor] / 10, then Func_030_5428 on wDA3C + A with E = B (E-0122)
; 2 call sites from 1 routine (e.g. AddActorPersonalityTensToAIChoiceWeights)
; reads: wBattleActor
; points at: wAIChoiceWeights
AddActorPersonalityTensForIndexA::
Func_030_469D:: ; address name
    push af
    ld a, [wBattleActor]
    add_a_to_hl
    ld b, [hl]
    ld a, $0A
    call DivideBByA
    pop af
    ld hl, wAIChoiceWeights
    add_a_to_hl
    ld e, b
    call AddSignedEToByteAtHLClamped
    ret

; adds AI weights for the actor's status (wD80D bits) and command mode, and for allies below a sixth of max HP in AI modes 3 and 4 (E-0130)
; 2 call sites from 2 routines (e.g. InitAIWeightsForActor, AIChooseActionForActor_Sub01)
; reads: wBattleActor, wLinkMode, wMenuState, wCommandBytesE9, wBattleTurn
; points at: wBattleStatus1, wAIChoiceWeights, wSlotAIMode, wBattleSkills, wCommandBytesE9
AddStatusAndHPWeightsToAI::
Func_030_46BA:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    ld a, [hl+]
    and a, $08
    jr nz, Jump_030_46CF
    inc hl
    inc hl
    ld a, [hl]
    and a, $33
    jr z, Jump_030_470B

Jump_030_46CF::
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_030_46FA
    cp a, $02
    jr nz, Jump_030_46E8
    ld a, [wBattleActor]
    cp a, $00
    ld a, [wMenuState]
    jr z, Jump_030_46FD
    ld a, [wCommandBytesE9]
    jr Jump_030_46FD

Jump_030_46E8::
    ld a, [wBattleActor]
    rrca
    rrca
    and a, $01
    ld hl, wCommandBytesE9
    add_a_to_hl
    ld a, [hl]
    jr Jump_030_46FD

Jump_030_46FA::
    ld a, [wMenuState]

Jump_030_46FD::
    and a, $03
    cp a, $01
    jr z, Jump_030_470B
    ld hl, wAIChoiceWeights
    ld e, $1E
    call AddSignedEToByteAtHLClamped

Jump_030_470B::
    call AnyAllyHPBelowSixthOfMax
    jr z, Jump_030_4768
    ld a, [wBattleActor]
    ld hl, wSlotAIMode
    add_a_to_hl
    ld a, [hl]
    cp a, $04
    jr z, Jump_030_4726
    cp a, $03
    jr z, Jump_030_4726
    jr Jump_030_4768

Jump_030_4726::
    ld a, [wBattleActor]
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld b, $08

Jump_030_4735::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_030_4768
    cp a, $16
    jr c, Jump_030_4752
    cp a, $21
    jr c, Jump_030_4759
    cp a, $7B
    jr z, Jump_030_4759
    cp a, $7C
    jr z, Jump_030_4759
    cp a, $9F
    jr c, Jump_030_4752
    cp a, $A2
    jr c, Jump_030_4759

Jump_030_4752::
    inc hl
    inc hl
    dec b
    jr nz, Jump_030_4735
    jr Jump_030_4768

Jump_030_4759::
    call GetActorSlotTacticLow2
    cp a, $03
    jr z, Jump_030_4768
    ld hl, wAIChoiceWeights + $2
    ld e, $1E
    call AddSignedEToByteAtHLClamped

Jump_030_4768::
    ld a, [wBattleTurn]
    or a, a
    jr nz, Jump_030_478A
    ld a, [wBattleActor]
    cp a, $04
    jr nc, Jump_030_478A
    ld a, [wLinkMode]
    or a, a
    jr nz, Jump_030_478A
    ld a, [wMenuState]
    and a, $01
    jr nz, Jump_030_478A
    ld hl, wAIChoiceWeights + $2
    ld e, $E2
    call AddSignedEToByteAtHLClamped

Jump_030_478A::
    ret

; A = 1 and NZ when an occupied ally has HP below a sixth of its max; otherwise returns with the last comparison flags (E-0124)
; 1 call site from 1 routine (e.g. AddStatusAndHPWeightsToAI)
; reads: wBattleActor
AnyAllyHPBelowSixthOfMax::
Func_030_478B:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03

Jump_030_4793::
    push bc
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_030_47AE
    ld a, c
    call ReadBattleMaxHPOfSlot_Bank30
    ld a, $06
    call DivideHLByA
    push hl
    ld a, c
    call ReadBattleHPOfSlot_Bank30
    pop bc
    call CompareHLToBC
    jr c, Jump_030_47B4

Jump_030_47AE::
    pop bc
    inc c
    dec b
    jr nz, Jump_030_4793
    ret

Jump_030_47B4::
    pop bc
    ld a, $01
    or a, a
    ret

; for player-controlled slots adds random 0-15 to wDA3C-wDA3E; for AI slots adds weights by personality band (AddRandomWeightByValueBand) (E-0125)
; 2 call sites from 2 routines (e.g. InitAIWeightsForActor, AIChooseActionForActor_Sub01)
; reads: wLinkMode, wBattleActor, wRandomLo
; points at: wAIChoiceWeights, wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo
AddRandomPersonalityWeights::
Func_030_47B9:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_030_47E6
    cp a, $02
    jr nz, Jump_030_47CA
    ld a, [wBattleActor]
    cp a, $04
    jr c, Jump_030_47E6

Jump_030_47CA::
    call GetActorSlotTacticLow2
    cp a, $03
    ret z
    ld hl, wAIChoiceWeights
    ld b, $03

Jump_030_47D5::
    call AdvanceRandom
    ld a, [wRandomLo]
    and a, $0F
    ld e, a
    call AddSignedEToByteAtHLClamped
    inc hl
    dec b
    jr nz, Jump_030_47D5
    ret

Jump_030_47E6::
    ld a, [wBattleActor]
    cp a, $04
    jr c, Jump_030_47CA
    ld a, [wBattleActor]
    ld hl, wSlotPersonalityHi
    ld de, wAIChoiceWeights
    call AddRandomWeightByValueBand
    ld a, [wBattleActor]
    ld hl, wSlotPersonalityMid
    ld de, wAIChoiceWeights + $1
    call AddRandomWeightByValueBand
    ld a, [wBattleActor]
    ld hl, wSlotPersonalityLo
    ld de, wAIChoiceWeights + $2

; adds RandomInRange(0, 30/25/20/15/10) to [DE] (Func_030_5428), the bound chosen by [HL + A] (< 50, 100, 150, 200, or more) (E-0124)
; 2 call sites from 1 routine (e.g. AddRandomPersonalityWeights)
AddRandomWeightByValueBand::
Func_030_480E:: ; address name
    push de
    add_a_to_hl
    ld a, [hl]
    ld bc, $001E
    cp a, $32
    jr c, Jump_030_4834
    ld bc, $0019
    cp a, $64
    jr c, Jump_030_4834
    ld bc, $0014
    cp a, $96
    jr c, Jump_030_4834
    ld bc, $000F
    cp a, $C8
    jr c, Jump_030_4834
    ld bc, $000A

Jump_030_4834::
    ld hl, $0000
    call RandomInRange
    pop hl
    call AddSignedEToByteAtHLClamped
    ret

; sorts wDA3C-wDA3E in descending order (ties broken by the random bits in wC5E7/8), swapping the matching wDA3F-wDA41 entries (E-0128)
; 2 call sites from 2 routines (e.g. InitAIWeightsForActor, AIChooseActionForActor_Sub01)
; reads: wRandomLo, wRandomHi, wAIChoiceOrder, wAIChoiceWeights, wBattleActor
; writes: wAIChoiceOrder
; points at: wAIChoiceWeights, wBattleSkillsPrefix, wAIWeights
SortThreeAIWeightsRandomTies::
Func_030_483F:: ; address name
    ld a, [wRandomLo]
    ld c, a
    ld a, [wRandomHi]
    ld b, a
    ld hl, wAIChoiceWeights
    ld a, [hl+]
    cp a, [hl]
    ccf
    jr c, Jump_030_4868
    jr nz, Jump_030_4855
    bit 0, b
    jr nz, Jump_030_4868

Jump_030_4855::
    push af
    ld a, [hl-]
    ld [hl+], a
    pop af
    ld [hl], a
    ld a, [wAIChoiceOrder]
    push af
    ld a, [wAIChoiceOrder + $1]
    ld [wAIChoiceOrder], a
    pop af
    ld [wAIChoiceOrder + $1], a

Jump_030_4868::
    ld a, [hl+]
    cp a, [hl]
    ccf
    jr c, Jump_030_4886
    jr nz, Jump_030_4873
    bit 0, c
    jr nz, Jump_030_4886

Jump_030_4873::
    push af
    ld a, [hl-]
    ld [hl+], a
    pop af
    ld [hl], a
    ld a, [wAIChoiceOrder + $1]
    push af
    ld a, [wAIChoiceOrder + $2]
    ld [wAIChoiceOrder + $1], a
    pop af
    ld [wAIChoiceOrder + $2], a

Jump_030_4886::
    dec hl
    ld a, [wAIChoiceWeights]
    cp a, [hl]
    ccf
    jr c, Jump_030_48A7
    jr nz, Jump_030_4894
    bit 1, b
    jr nz, Jump_030_48A7

Jump_030_4894::
    push af
    ld a, [hl-]
    ld [hl+], a
    pop af
    ld [hl], a
    ld a, [wAIChoiceOrder]
    push af
    ld a, [wAIChoiceOrder + $1]
    ld [wAIChoiceOrder], a
    pop af
    ld [wAIChoiceOrder + $1], a

Jump_030_48A7::
    ld a, [wAIChoiceOrder]
    ld d, a
    ld e, $32
    call AddWeightsForSkillD
    ld a, [wAIChoiceOrder + $1]
    ld d, a
    ld e, $19

; for each of the actor's skills equal to D adds weight through Func_030_48F3 to wD2AD[index]; for D other than 2 also to wD2BD[D - 1] (E-0125)
; 1 call site from 1 routine (e.g. SortThreeAIWeightsRandomTies)
; reads: wBattleActor
; points at: wBattleSkillsPrefix, wAIWeights
AddWeightsForSkillD::
Func_030_48B6:: ; address name
    ld bc, $0800
    ld hl, wBattleSkillsPrefix
    ld a, [wBattleActor]
    swap a
    add a, l
    ld l, a
    jr nc, Jump_030_48C6
    inc h

Jump_030_48C6::
    push bc
    ld a, [hl]
    cp a, d
    jr nz, Jump_030_48DA
    push hl
    ld a, c
    ld hl, wAIWeights
    add a, a
    add_a_to_hl
    call AddWeightsForSkillD_Sub01
    pop hl

Jump_030_48DA::
    pop bc
    inc hl
    inc hl
    inc c
    dec b
    jr nz, Jump_030_48C6
    ld a, d
    cp a, $02
    jr z, Jump_030_48F2
    dec a
    ld hl, wAIWeights + $10
    add_a_to_hl
    call AddWeightsForSkillD_Sub01

Jump_030_48F2::
    ret

; only called from AddWeightsForSkillD (E-0047)
; 2 call sites from 1 routine (e.g. AddWeightsForSkillD)
; reads: wLinkMode, wBattleActor, wMenuState, wCommandBytesE9
; points at: wCommandBytesE9
AddWeightsForSkillD_Sub01::
Func_030_48F3:: ; address name
    push de
    push hl
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_030_4920
    cp a, $01
    jr z, Jump_030_490E
    ld a, [wBattleActor]
    cp a, $00
    ld a, [wMenuState]
    jr z, Jump_030_4923
    ld a, [wCommandBytesE9]
    jr Jump_030_4923

Jump_030_490E::
    ld a, [wBattleActor]
    rrca
    rrca
    and a, $01
    ld hl, wCommandBytesE9
    add_a_to_hl
    ld a, [hl]
    jr Jump_030_4923

Jump_030_4920::
    ld a, [wMenuState]

Jump_030_4923::
    and a, $03
    cp a, $01
    jr z, Jump_030_492F
    and a, $01
    jr z, Jump_030_493A
    jr Jump_030_493C

Jump_030_492F::
    call GetActorSlotTacticLow2
    cp a, $03
    jr z, Jump_030_493A
    sla e
    jr Jump_030_493C

Jump_030_493A::
    ld e, $00

Jump_030_493C::
    pop hl
    ld a, e
    add a, [hl]
    ld [hl+], a
    ld a, $00
    adc a, [hl]
    ld [hl], a
    pop de
    ret

; for player-controlled actors in manual mode chooses action 0; otherwise runs the AI routine for the next wDA3C entry (Data_030_4998) and advances wDA42 (E-0125)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wLinkMode, wAIChoiceIndex, wLoadSlot
; points at: wAIChoiceWeights, wAIChoiceIndex
AIRunNextChoice:: ; heuristic: follows a terminator; C0
Func_030_4946:: ; address name
    ld a, [wBattleActor]
    and a, $03
    cp a, $03
    jr z, Jump_030_496E
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_030_4959
    cp a, $02
    jr nz, Jump_030_4960

Jump_030_4959::
    ld a, [wBattleActor]
    cp a, $04
    jr nc, Jump_030_496E

Jump_030_4960::
    call GetActorSlotTacticLow2
    cp a, $03
    jr nz, Jump_030_496E

Jump_030_4967::
    ld b, $00
    call ActorActionChoiceAddress
    ld [hl], b
    ret

Jump_030_496E::
    ld a, [wAIChoiceIndex]
    cp a, $06
    jr nc, Jump_030_4967
    ld hl, wAIChoiceWeights
    add_a_to_hl
    ld a, [hl]
    ld hl, Data_030_4998
    dec a
    call ReadBattleWordFromArray_Bank30
    call JumpToHL
    call ActorActionChoiceAddress
    ld b, [hl]
    ld a, [wLoadSlot]
    cp a, $FF
    ret z
    ld hl, wAIChoiceIndex
    inc [hl]
    jr AIRunNextChoice

; address loaded by AIRunNextChoice
Data_030_4998:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0C0998, $12E

; wDA6B/wDA6C = AIScoreRoutineTableB, then continues with the scoring loop (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wLinkMode, wAIChoiceOrder
; writes: wBattleExpAward
; points at: wBattleSkillsPrefix, wAIWeights
UseAIScoreTableB:: ; heuristic: target of a pointer table; C0
Func_030_4AC6:: ; address name
    ld hl, AIScoreRoutineTableB
    ld a, l
    ld [wBattleExpAward], a
    ld a, h
    ld [wBattleExpAward + $1], a
    jr Jump_030_4ADE

; sets wDA6B/C to AIScoreRoutineTableA; for AI-controlled actors estimates damage, scores the eight skills, attack (0) and $AC into wD2AD, and doubles the weight of the preferred kind (E-0129)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wLinkMode, wAIChoiceOrder
; writes: wBattleExpAward
; points at: wBattleSkillsPrefix, wAIWeights
ScoreActionsWithAIScoreTableA:: ; heuristic: target of a pointer table; C0
Func_030_4AD3:: ; address name
    ld hl, AIScoreRoutineTableA
    ld a, l
    ld [wBattleExpAward], a
    ld a, h
    ld [wBattleExpAward + $1], a

Jump_030_4ADE::
    ld a, [wBattleActor]
    and a, $03
    cp a, $03
    jr z, Jump_030_4B06
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_030_4AF1
    cp a, $02
    jr nz, Jump_030_4AF8

Jump_030_4AF1::
    ld a, [wBattleActor]
    cp a, $04
    jr nc, Jump_030_4B06

Jump_030_4AF8::
    call GetActorSlotTacticLow2
    cp a, $03
    jr nz, Jump_030_4B06
    ld b, $00
    call ActorActionChoiceAddress
    ld [hl], b
    ret

Jump_030_4B06::
    call EstimateDamageVsEachFoeToAIDamageEstimates
    ld a, [wBattleActor]
    ld hl, wBattleSkillsPrefix
    swap a
    add_a_to_hl
    ld de, wAIWeights
    ld b, $08

Jump_030_4B1B::
    push bc
    push hl
    push de
    inc hl
    call ScoreSkillAtHLForAI
    pop de
    pop hl
    ld a, [wAIChoiceOrder]
    cp a, [hl]
    call z, DoubleWordAtDEUnlessBit15
    inc hl
    inc hl
    inc de
    inc de
    pop bc
    dec b
    jr nz, Jump_030_4B1B
    ld a, $00
    push de
    call ScoreSkillForAI
    pop de
    ld a, [wAIChoiceOrder]
    cp a, $01
    call z, DoubleWordAtDEUnlessBit15
    inc de
    inc de
    ld a, $AC
    push de
    call ScoreSkillForAI
    pop de
    ld a, [wBattleActor]
    and a, $03
    cp a, $03
    jr z, Jump_030_4B6F
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_030_4B5E
    cp a, $02
    jr nz, Jump_030_4B65

Jump_030_4B5E::
    ld a, [wBattleActor]
    cp a, $04
    jr nc, Jump_030_4B6F

Jump_030_4B65::
    ld a, [wAIChoiceOrder]
    cp a, $03
    call z, DoubleWordAtDEUnlessBit15
    jr Jump_030_4B72

Jump_030_4B6F::
    call QuarterWordAtDEUnlessBit15

Jump_030_4B72::
    call ChooseHighestWeightedAction
    ret

; doubles the word at DE unless its bit 15 is already set (E-0122)
; 3 call sites from 1 routine (e.g. ScoreActionsWithAIScoreTableA)
DoubleWordAtDEUnlessBit15::
Func_030_4B76:: ; address name
    push de
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    bit 7, a
    jr nz, Jump_030_4B86
    sla c
    rla
    ld [de], a
    dec de
    ld a, c
    ld [de], a

Jump_030_4B86::
    pop de
    ret

; divides the word at DE by 4 unless its bit 15 is set (E-0124)
; 1 call site from 1 routine (e.g. ScoreActionsWithAIScoreTableA)
QuarterWordAtDEUnlessBit15::
Func_030_4B88:: ; address name
    push de
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    bit 7, a
    jr nz, Jump_030_4B9D
    srl a
    rr c
    srl a
    rr c
    ld [de], a
    dec de
    ld a, c
    ld [de], a

Jump_030_4B9D::
    pop de
    ret

; A = [HL], then falls into ScoreSkillForAI (E-0126)
; 1 call site from 1 routine (e.g. ScoreActionsWithAIScoreTableA)
; reads: wRecordBufferData, wBattleExpAward, wAISkillScore, wAISkillScore2
; writes: wAISkillScore, wAISkillScore2
ScoreSkillAtHLForAI::
Func_030_4B9F:: ; address name
    ld a, [hl]

; A = skill number ($FF skips): AddSkillBaseWeightAndLoadSkill; when wCFF1 bit 0 (in the skill record) is set, clears wDA6E-wDA71 and far-calls the skill's AI scoring routine from the table in wDA6B/wDA6C (AIScoreRoutineTableA or B), then folds the accumulated weights into the word at DE (the rest is not fully read) (E-0083)
; 2 call sites from 1 routine (e.g. ScoreActionsWithAIScoreTableA)
; reads: wRecordBufferData, wBattleExpAward, wAISkillScore, wAISkillScore2
; writes: wAISkillScore, wAISkillScore2
ScoreSkillForAI::
Func_030_4BA0:: ; address name
    push de
    cp a, $FF
    jr z, Jump_030_4BFA
    call AddSkillBaseWeightAndLoadSkill
    ld e, a
    ld d, $00
    ld a, [wRecordBufferData + $3]
    bit 0, a
    jr z, Jump_030_4BFA
    ld a, [wBattleExpAward]
    ld l, a
    ld a, [wBattleExpAward + $1]
    ld h, a
    add hl, de
    add hl, de
    add hl, de
    ld e, [hl]
    inc hl
    ld a, [hl+]
    ld b, [hl]
    ld h, a
    ld l, e
    xor a, a
    ld [wAISkillScore], a
    ld [wAISkillScore + $1], a
    ld [wAISkillScore2], a
    ld [wAISkillScore2 + $1], a
    rst $10
    ld a, [wAISkillScore]
    ld c, a
    ld a, [wAISkillScore + $1]
    ld b, a
    ld a, [wAISkillScore2]
    ld l, a
    ld a, [wAISkillScore2 + $1]
    ld h, a
    ld a, h
    and a, l
    cp a, $FF
    jr z, Jump_030_4BFA
    ld a, c
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    pop hl
    ld a, [hl]
    add a, c
    ld [hl+], a
    ld a, [hl]
    adc a, b
    ld [hl], a
    bit 7, a
    jr z, Jump_030_4BFF
    dec hl
    push hl

Jump_030_4BFA::
    pop hl
    ld a, $FF
    ld [hl+], a
    ld [hl], a

Jump_030_4BFF::
    ret

; picks the largest of the ten wD2AD weights (ties at random); index 8 chooses action 0, 9 chooses $AC, others the actor's skill in that slot (E-0127)
; 1 call site from 1 routine (e.g. ScoreActionsWithAIScoreTableA)
; reads: wRandomLo, wBattleActor, hTemp0
; writes: hTemp0
; points at: wAIWeights, wBattleSkills
ChooseHighestWeightedAction::
Func_030_4C00:: ; address name
    xor a, a
    ldh [hTemp0], a
    ld hl, $0000
    ld de, $0A00

Jump_030_4C09::
    ld a, e
    push hl
    ld hl, wAIWeights
    add a, a
    add_a_to_hl
    ld c, [hl]
    inc hl
    ld b, [hl]
    pop hl
    ld a, b
    and a, c
    cp a, $FF
    jr z, Jump_030_4C34
    call CompareHLToBC
    jr c, Jump_030_4C2F
    jr nz, Jump_030_4C34
    call AdvanceRandom
    ld a, [wRandomLo]
    bit 0, a
    jr z, Jump_030_4C34

Jump_030_4C2F::
    ld h, b
    ld l, c
    ld a, e
    ldh [hTemp0], a

Jump_030_4C34::
    inc e
    dec d
    jr nz, Jump_030_4C09
    ld a, [wBattleActor]
    swap a
    ld hl, wBattleSkills
    add_a_to_hl
    ldh a, [hTemp0]
    cp a, $08
    jr z, Jump_030_4C58
    cp a, $09
    jr z, Jump_030_4C5C
    add a, a
    add_a_to_hl
    ld b, [hl]
    jr Jump_030_4C5E

Jump_030_4C58::
    ld b, $00
    jr Jump_030_4C5E

Jump_030_4C5C::
    ld b, $AC

Jump_030_4C5E::
    call ActorActionChoiceAddress
    ld [hl], b
    ret

; for each foe stores (actor ATK - foe DEF / 2) / 2, floored at 0, in wD2C1[foe & 3] (0 for empty slots) (E-0125)
; 1 call site from 1 routine (e.g. ScoreActionsWithAIScoreTableA)
; reads: wBattleActor
; points at: wAIDamageEstimates
EstimateDamageVsEachFoeToAIDamageEstimates::
Func_030_4C63:: ; address name
    ld a, [wBattleActor]
    call ReadBattleATKOfSlot_Bank30
    ld d, h
    ld e, l
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_030_4C75::
    push de
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_030_4C8D
    call ReadBattleDEFOfSlot_Bank30
    srl h
    rr l
    ld a, e
    sub a, l
    ld e, a
    ld a, d
    sbc a, h
    ld d, a
    bit 7, a
    jr z, Jump_030_4C92

Jump_030_4C8D::
    ld de, $0000
    jr Jump_030_4C96

Jump_030_4C92::
    srl d
    rr e

Jump_030_4C96::
    ld a, c
    and a, $03
    ld hl, wAIDamageEstimates
    add a, a
    add_a_to_hl
    ld [hl], e
    inc hl
    ld [hl], d
    pop de
    inc c
    dec b
    jr nz, Jump_030_4C75
    ret

; A = skill number: when the word at $55F3 + 2 * A (a per-skill weight table in this bank) is non-zero it is added to the word at DE and Func_030_4CDB adds a random adjustment; then the skill record is loaded (wRecordBuffer = A, wCFED = 0, LoadSkillRecord); A and DE kept (E-0083)
; 1 call site from 1 routine (e.g. ScoreSkillForAI)
; writes: wRecordBuffer
AddSkillBaseWeightAndLoadSkill::
Func_030_4CAB:: ; address name
    push de
    push af
    ld l, a
    ld h, $00
    add hl, hl
    ld a, l
    add a, $F3
    ld l, a
    ld a, h
    adc a, $55
    ld h, a
    ld a, [hl+]
    or a, [hl]
    jr z, Jump_030_4CC9
    dec hl
    ld a, [de]
    add a, [hl]
    ld [de], a
    inc hl
    inc de
    ld a, [de]
    adc a, [hl]
    ld [de], a
    call AddSkillBaseWeightAndLoadSkill_Sub01

Jump_030_4CC9::
    pop af
    push af
    ld [wRecordBuffer], a
    xor a, a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    pop af
    pop de
    ret

; only called from AddSkillBaseWeightAndLoadSkill (E-0047)
; 1 call site from 1 routine (e.g. AddSkillBaseWeightAndLoadSkill)
; reads: wRandomLo
AddSkillBaseWeightAndLoadSkill_Sub01::
Func_030_4CDB:: ; address name
    push af
    dec de
    call AdvanceRandom
    ld a, [wRandomLo]
    and a, $3F
    ld b, a
    ld a, [de]
    add a, b
    ld [de], a
    inc de
    ld a, [de]
    adc a, $00
    ld [de], a
    pop af
    ret

; entry 3 of the `rst $00` table in RunBattleResolveStep_43C4
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep
; points at: wBattleSubPhase
RunBattleResolveStep_43C4_Case03::
Jump_030_4CF0:: ; address name
    call RunActorActionHandlersForAISlots
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleResolveStep], a
    ret

; for AI-controlled slots (foes, or both sides outside normal battles, never slot 3/7) runs the handlers for the set bits of the actor's action data word (E-0124)
; 2 call sites from 2 routines (e.g. RunBattleResolveStep_43C4_Case03, AIChooseActionForActor)
; reads: wLinkMode, wBattleActor
RunActorActionHandlersForAISlots::
Func_030_4CFC:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_030_4D06
    cp a, $02
    jr nz, Jump_030_4D0F

Jump_030_4D06::
    ld a, [wBattleActor]
    cp a, $03
    jr nc, Jump_030_4D24
    jr Jump_030_4D18

Jump_030_4D0F::
    ld a, [wBattleActor]
    and a, $03
    cp a, $03
    jr z, Jump_030_4D24

Jump_030_4D18::
    call ActorActionDataWord
    ld a, c
    and a, b
    cp a, $FF
    jr z, Jump_030_4D24
    call RunHandlersForSetBitsInBC

Jump_030_4D24::
    ret

; BC = the word at Data_030_4D34 + 2 * the actor's chosen action (ActorActionChoiceAddress) (E-0118)
; 1 call site from 1 routine (e.g. RunActorActionHandlersForAISlots)
ActorActionDataWord::
Func_030_4D25:: ; address name
    call ActorActionChoiceAddress
    ld c, [hl]
    ld b, $00
    ld hl, Data_030_4D34
    add hl, bc
    add hl, bc
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ret

; address loaded by ActorActionDataWord
Data_030_4D34:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0C0D34, $6A
    ds $10, $FF
    INCBIN "dwm2-cobi-us.gbc", $0C0DAE, $56
    ds $12, $FF
    db $04, $00, $04, $00, $04, $00, $04, $00, $04, $00, $04, $00, $04, $00, $04, $00
    db $04, $00, $04, $00, $FF, $FF, $10, $00, $80, $00, $04, $00, $04, $00, $04, $00
    db $10, $00
    ds $12, $FF
    db $04, $00, $04, $00, $04, $00, $04, $00, $04, $00, $04, $00, $04, $00, $04, $00
    db $04, $00, $02, $00, $20, $00, $0A, $00
    ds $10, $FF
    db $10, $00, $10, $00
    ds $12, $FF
    db $02, $00
    ds $8A, $FF

; for bit numbers 0-15 in turn (BitMaskWords16): when the bit is set in BC (C for 0-7, B for 8-15), calls handler E through CallFlagBitHandlerE; stops early when a handler returns carry (E-0102)
; 1 call site from 1 routine (e.g. RunActorActionHandlersForAISlots)
RunHandlersForSetBitsInBC::
Func_030_4F14:: ; address name
    ld e, $00
    ld d, $10
    ld hl, BitMaskWords16

Jump_030_4F1B::
    push hl
    push bc
    push de
    ld a, c
    and a, [hl]
    jr z, Jump_030_4F27
    call CallFlagBitHandlerE
    jr Jump_030_4F2F

Jump_030_4F27::
    inc hl
    ld a, b
    and a, [hl]
    jr z, Jump_030_4F2F
    call CallFlagBitHandlerE

Jump_030_4F2F::
    pop de
    pop bc
    pop hl
    jr c, Jump_030_4F3A
    inc hl
    inc hl
    inc e
    dec d
    jr nz, Jump_030_4F1B

Jump_030_4F3A::
    ret

; E = bit number: jumps through the 16-word handler table at $4F66 (JumpToWordAtHL) (E-0102)
; 2 call sites from 1 routine (e.g. RunHandlersForSetBitsInBC)
CallFlagBitHandlerE::
Func_030_4F3B:: ; address name
    ld d, $00
    ld hl, $4F66
    add hl, de
    add hl, de
    call JumpToWordAtHL
    ret

; 16 words $0001, $0002, ... $8000, one bit each (E-0102)
; address loaded by RunHandlersForSetBitsInBC
BitMaskWords16:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_030_4F46:: ; address name
    db $01, $00, $02, $00, $04, $00, $08, $00, $10, $00, $20, $00, $40, $00, $80, $00
    db $00, $01, $00, $02, $00, $04, $00, $08, $00, $10, $00, $20, $00, $40, $00, $80
    dw RollPersonalityHiHighFlag01
    dw RollPersonalityHiLowFlag02
    dw RollPersonalityMidHighFlag04
    dw RollPersonalityMidLowFlag08
    dw RollPersonalityLoHighFlag10
    dw RollPersonalityLoLowFlag20
    dw RollSlotTraitHighFlag40
    dw RollSlotTraitLowFlag80
    db $C6, $4F, $C6, $4F, $C6, $4F, $C6, $4F, $C6, $4F, $C6, $4F, $C6, $4F, $C6, $4F

; AI trait roll with mask DE = $01: when the actor's value is at least $80 rolls a chance that grows with its distance from $80 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wBattleActor
; points at: wSlotPersonalityHi, wSlotFlags854
RollPersonalityHiHighFlag01:: ; heuristic: target of a pointer table; C0
Func_030_4F86:: ; address name
    ld hl, wSlotPersonalityHi
    ld de, $0001
    jr Jump_030_4FC8

; AI trait roll with mask DE = $02: when the actor's value is below $80 rolls a chance that grows with its distance from $80 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wBattleActor
; points at: wSlotPersonalityHi, wSlotFlags854
RollPersonalityHiLowFlag02:: ; heuristic: target of a pointer table; C0
Func_030_4F8E:: ; address name
    ld hl, wSlotPersonalityHi
    ld de, $0002
    jr Jump_030_4FE9

; AI trait roll with mask DE = $04: when the actor's value is at least $80 rolls a chance that grows with its distance from $80 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wBattleActor
; points at: wSlotPersonalityMid, wSlotFlags854
RollPersonalityMidHighFlag04:: ; heuristic: target of a pointer table; C0
Func_030_4F96:: ; address name
    ld hl, wSlotPersonalityMid
    ld de, $0004
    jr Jump_030_4FC8

; AI trait roll with mask DE = $08: when the actor's value is below $80 rolls a chance that grows with its distance from $80 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wBattleActor
; points at: wSlotPersonalityMid, wSlotFlags854
RollPersonalityMidLowFlag08:: ; heuristic: target of a pointer table; C0
Func_030_4F9E:: ; address name
    ld hl, wSlotPersonalityMid
    ld de, $0008
    jr Jump_030_4FE9

; AI trait roll with mask DE = $10: when the actor's value is at least $80 rolls a chance that grows with its distance from $80 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wBattleActor
; points at: wSlotPersonalityLo, wSlotFlags854
RollPersonalityLoHighFlag10:: ; heuristic: target of a pointer table; C0
Func_030_4FA6:: ; address name
    ld hl, wSlotPersonalityLo
    ld de, $0010
    jr Jump_030_4FC8

; AI trait roll with mask DE = $20: when the actor's value is below $80 rolls a chance that grows with its distance from $80 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wBattleActor
; points at: wSlotPersonalityLo, wSlotFlags854
RollPersonalityLoLowFlag20:: ; heuristic: target of a pointer table; C0
Func_030_4FAE:: ; address name
    ld hl, wSlotPersonalityLo
    ld de, $0020
    jr Jump_030_4FE9

; AI trait roll with mask DE = $40: when the actor's value is at least $80 rolls a chance that grows with its distance from $80 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wBattleActor
; points at: wSlotTrait, wSlotFlags854
RollSlotTraitHighFlag40:: ; heuristic: target of a pointer table; C0
Func_030_4FB6:: ; address name
    ld hl, wSlotTrait
    ld de, $0040
    jr Jump_030_4FC8

; AI trait roll with mask DE = $80: when the actor's wD980 value is below $80 rolls a chance that grows with its distance from $80 (E-0125)
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wBattleActor
; points at: wSlotTrait, wSlotFlags854
RollSlotTraitLowFlag80:: ; heuristic: target of a pointer table; C0
Func_030_4FBE:: ; address name
    ld hl, wSlotTrait
    ld de, $0080
    jr Jump_030_4FE9
    db $AF, $C9

Jump_030_4FC8::
    call AdvanceRandom
    ld a, [wRandomLo]
    ld b, a
    ld a, [wBattleActor]
    add_a_to_hl
    ld a, [hl]
    cp a, $80
    ret c
    cp a, $A2
    jr c, Jump_030_500C
    cp a, $C3
    jr c, Jump_030_5010
    cp a, $E4
    jr c, Jump_030_5014
    jr Jump_030_5008

Jump_030_4FE9::
    call AdvanceRandom
    ld a, [wRandomLo]
    ld b, a
    ld a, [wBattleActor]
    add_a_to_hl
    ld a, [hl]
    cp a, $80
    ret nc
    cp a, $60
    jr nc, Jump_030_500C
    cp a, $3F
    jr nc, Jump_030_5010
    cp a, $1E
    jr nc, Jump_030_5014

Jump_030_5008::
    ld c, $08
    jr Jump_030_5016

Jump_030_500C::
    ld c, $01
    jr Jump_030_5016

Jump_030_5010::
    ld c, $02
    jr Jump_030_5016

Jump_030_5014::
    ld c, $04

Jump_030_5016::
    ld a, b
    cp a, c
    ret nc
    ld a, [wBattleActor]
    ld hl, wSlotFlags854
    add a, a
    add_a_to_hl
    ld a, [hl]
    or a, e
    ld [hl+], a
    ld a, [hl]
    or a, d
    ld [hl], a
    scf
    ret

; only called from RunBattleResolveStep_43C4_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_43C4_Case01)
; reads: wBattleActor, wTemp0, wPauseMenuStep
; points at: wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo, wTemp0
RunBattleResolveStep_43C4_Case01_Sub03::
Func_030_502D:: ; address name
    ld b, $00
    ld hl, wSlotPersonalityHi
    call IncBIfActorEntryBelow40
    ld hl, wSlotPersonalityMid
    call IncBIfActorEntryBelow40
    ld hl, wSlotPersonalityLo
    call IncBIfActorEntryBelow40
    ld a, b
    cp a, $03
    jr z, Jump_030_509A
    ld b, $00
    ld hl, wSlotPersonalityMid
    call CountIfActorPersonalityHiAtLeastHLEntry
    ld hl, wSlotPersonalityLo
    call CountIfActorPersonalityHiAtLeastHLEntry
    ld a, b
    cp a, $02
    jr nz, Jump_030_50A0
    ld hl, wTemp0
    ld bc, $0008
    ld a, $FF
    call FillBytes
    call RunBattleResolveStep_43C4_Case01_Sub03_Sub01
    ld a, [wBattleActor]
    ld hl, wSlotPersonalityHi
    add_a_to_hl
    ld a, [hl]
    cp a, $40
    jr c, Jump_030_507E
    ld a, [wTemp0]
    cp a, $FF
    jr z, Jump_030_50A6

Jump_030_507E::
    call FilterSkillListByMP
    ld a, [wPauseMenuStep]
    cp a, $FF
    jr z, Jump_030_50A6
    call RunBattleResolveStep_43C4_Case01_Sub03_Sub02
    ld a, [wTemp0]
    cp a, $FF
    jr z, Jump_030_50A6
    call RunBattleResolveStep_43C4_Case01_Sub03_Sub03
    call ActorActionChoiceAddress
    ld [hl], c
    ret

Jump_030_509A::
    call ActorActionChoiceAddress
    ld [hl], $AB
    ret

Jump_030_50A0::
    call ActorActionChoiceAddress
    ld [hl], $AC
    ret

Jump_030_50A6::
    call ActorActionChoiceAddress
    ld [hl], $00
    ret

; B += 1 when the byte at HL + wBattleActor is below $40 (E-0115)
; 3 call sites from 1 routine (e.g. RunBattleResolveStep_43C4_Case01_Sub03)
; reads: wBattleActor
IncBIfActorEntryBelow40::
Func_030_50AC:: ; address name
    ld a, [wBattleActor]
    add_a_to_hl
    ld a, [hl]
    cp a, $40
    ret nc
    inc b
    ret

; B += 1 when wSlotPersonalityHi[actor] >= [HL + actor] (E-0122)
; 2 call sites from 1 routine (e.g. RunBattleResolveStep_43C4_Case01_Sub03)
; reads: wBattleActor
; points at: wSlotPersonalityHi
CountIfActorPersonalityHiAtLeastHLEntry::
Func_030_50BA:: ; address name
    ld a, [wBattleActor]
    add_a_to_hl
    ld a, [wBattleActor]
    ld de, wSlotPersonalityHi
    add a, e
    ld e, a
    jr nc, Jump_030_50CD
    inc d

Jump_030_50CD::
    ld a, [de]
    cp a, [hl]
    ret c
    inc b
    ret

; only called from RunBattleResolveStep_43C4_Case01_Sub03 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_43C4_Case01_Sub03)
; reads: wBattleActor, wRecordBufferData
; writes: wRecordBuffer, wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3
; points at: wBattleSkills, wTemp0
RunBattleResolveStep_43C4_Case01_Sub03_Sub01::
Func_030_50D2:: ; address name
    ld a, [wBattleActor]
    swap a
    ld hl, wBattleSkills
    add_a_to_hl
    ld b, $08
    ld c, $00

Jump_030_50E3::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_030_5123
    push hl
    push bc
    ld [wRecordBuffer], a
    ld a, $03
    ld [wBattleArg0], a
    xor a, a
    ld [wRecordBuffer + $1], a
    ld a, $01
    ld [wBattleArg1], a
    ld hl, wRecordBufferData + $3
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    farcall LoadSkillRecordPart
    ld a, [wRecordBufferData + $3]
    and a, $03
    cp a, $02
    pop bc
    pop hl
    jr z, Jump_030_5123
    ld a, c
    ld de, wTemp0
    add a, e
    ld e, a
    jr nc, Jump_030_5120
    inc d

Jump_030_5120::
    ld a, [hl]
    ld [de], a
    inc c

Jump_030_5123::
    inc hl
    inc hl
    dec b
    jr nz, Jump_030_50E3
    ret

; wBattleActor selects the actor; its MP word is at wD8DF + 2 * actor. For each of the 8 skill numbers in wC0A0 it loads the record (LoadSkillRecordPart) and keeps the number only when byte 0 of the record is below that MP word; otherwise it writes $FF to that slot. The comparison is strict: a skill whose cost equals the MP is dropped. Executed on the emulator for MP 0-40 against the ROM's costs (E-0048)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_43C4_Case01_Sub03)
; reads: wBattleActor, wRecordBufferData
; writes: wRecordBuffer, wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3
; points at: wBattleMP, wTemp0, wRecordBufferData, wPauseMenuStep
FilterSkillListByMP::
Func_030_5129:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleMP
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld hl, wTemp0
    ld e, $08
    ld d, $00

Jump_030_513F::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_030_5187
    push hl
    push bc
    push de
    ld [wRecordBuffer], a
    ld a, $00
    ld [wBattleArg0], a
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
    pop de
    pop bc
    ld a, [wRecordBufferData]
    ld l, a
    ld h, $00
    call CompareHLToBC
    jr c, Jump_030_5181
    ld a, d
    ld hl, wTemp0
    add_a_to_hl
    ld [hl], $FF

Jump_030_5181::
    inc d
    pop hl
    inc hl
    dec e
    jr nz, Jump_030_513F

Jump_030_5187::
    ld hl, wPauseMenuStep
    ld bc, $0008
    ld a, $FF
    call FillBytes
    ld hl, wTemp0
    ld de, wPauseMenuStep
    jr Jump_030_51CD

; only called from RunBattleResolveStep_43C4_Case01_Sub03 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_43C4_Case01_Sub03)
; points at: wPauseMenuStep, wTemp0
RunBattleResolveStep_43C4_Case01_Sub03_Sub02::
Func_030_519A:: ; address name
    ld hl, wPauseMenuStep
    ld b, $08
    ld c, $00

Jump_030_51A1::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_030_51BC
    call RunBattleResolveStep_43C4_Case01_Sub03_Sub02_Sub01
    jr c, Jump_030_51B7
    ld a, c
    ld de, wPauseMenuStep
    add a, e
    ld e, a
    jr nc, Jump_030_51B4
    inc d

Jump_030_51B4::
    ld a, $FF
    ld [de], a

Jump_030_51B7::
    inc c
    inc hl
    dec b
    jr nz, Jump_030_51A1

Jump_030_51BC::
    ld hl, wTemp0
    ld bc, $0008
    ld a, $FF
    call FillBytes
    ld hl, wPauseMenuStep
    ld de, wTemp0

Jump_030_51CD::
    ld b, $08

Jump_030_51CF::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_030_51D7
    ld a, [hl]
    ld [de], a
    inc de

Jump_030_51D7::
    inc hl
    dec b
    jr nz, Jump_030_51CF
    ret

; only called from RunBattleResolveStep_43C4_Case01_Sub03_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_43C4_Case01_Sub03_Sub02)
RunBattleResolveStep_43C4_Case01_Sub03_Sub02_Sub01::
Func_030_51DC:: ; address name
    cp a, $01
    jr c, Jump_030_5204
    cp a, $16
    jr c, Jump_030_5207
    cp a, $3D
    jr c, Jump_030_5204
    cp a, $68
    jr c, Jump_030_5207
    cp a, $6B
    jr z, Jump_030_5207
    cp a, $6C
    jr z, Jump_030_5207
    cp a, $6D
    jr z, Jump_030_5207
    cp a, $6E
    jr z, Jump_030_5207
    cp a, $6F
    jr z, Jump_030_5207
    cp a, $70
    jr z, Jump_030_5207

Jump_030_5204::
    scf
    ccf
    ret

Jump_030_5207::
    scf
    ret

; only called from RunBattleResolveStep_43C4_Case01_Sub03 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_43C4_Case01_Sub03)
; reads: wTemp0, wRecordBufferData
; writes: wRecordBuffer, wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3
; points at: wRecordBufferData, wTemp1, wTemp0
RunBattleResolveStep_43C4_Case01_Sub03_Sub03::
Func_030_5209:: ; address name
    ld a, [wTemp0]
    ld [wRecordBuffer], a
    ld a, $00
    ld [wBattleArg0], a
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
    ld c, a
    ld b, $00
    ld hl, wTemp1
    ld de, $0700

Jump_030_523A::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_030_527C
    push hl
    push de
    push bc
    ld [wRecordBuffer], a
    ld a, $00
    ld [wBattleArg0], a
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
    pop bc
    pop de
    call CompareHLToBC
    jr c, Jump_030_5277
    ld c, l
    ld b, h
    ld a, $08
    sub a, d
    ld e, a

Jump_030_5277::
    pop hl
    inc hl
    dec d
    jr nz, Jump_030_523A

Jump_030_527C::
    ld a, e
    ld hl, wTemp0
    add_a_to_hl
    ld c, [hl]
    ret

; B = forced action $CD, $CC, $CE or $CF by the actor's status bits (wD80F byte 0 bit 6, byte 1 bit 2, byte 2 bit 4, byte 5 bit 0); Z when none (E-0124)
; 2 call sites from 2 routines (e.g. AIChooseActionResolveStep, RunBattleResolveStep_43C4_Case00)
; reads: wBattleActor
; points at: wBattleStatus3
ForcedActionForActorStatus::
Func_030_5287:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl+]
    and a, $40
    jr z, Jump_030_5299
    ld b, $CD
    jr Jump_030_52B4

Jump_030_5299::
    ld a, [hl+]
    and a, $04
    jr z, Jump_030_52A2
    ld b, $CC
    jr Jump_030_52B4

Jump_030_52A2::
    ld a, [hl+]
    and a, $10
    jr z, Jump_030_52AB
    ld b, $CE
    jr Jump_030_52B4

Jump_030_52AB::
    inc hl
    inc hl
    ld a, [hl]
    and a, $01
    jr z, Jump_030_52B4
    ld b, $CF

Jump_030_52B4::
    ret

; only called from RunBattleResolveStep_43C4_Case01 (E-0047)
; 2 call sites from 1 routine (e.g. RunBattleResolveStep_43C4_Case01)
; reads: wLinkMode, wBattleActor
; writes: hTemp0, hTemp1, hTemp2, hTemp3
; points at: wBattleLevel, wSlotTrait
RunBattleResolveStep_43C4_Case01_Sub04::
Func_030_52B5:: ; address name
    ld a, [wLinkMode]
    or a, a
    ret nz
    ld a, [wBattleActor]
    cp a, $03
    ret nc
    xor a, a
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ld bc, $0000
    ld a, [wBattleActor]
    ld hl, wBattleLevel
    add_a_to_hl
    ld a, [hl]
    cp a, $0A
    jr c, Jump_030_52E8
    cp a, $14
    jr c, Jump_030_52EC
    cp a, $1E
    jr c, Jump_030_52F0
    ld c, $0C
    jr Jump_030_52F2

Jump_030_52E8::
    ld c, $00
    jr Jump_030_52F2

Jump_030_52EC::
    ld c, $04
    jr Jump_030_52F2

Jump_030_52F0::
    ld c, $08

Jump_030_52F2::
    ld de, $0000
    ld a, [wBattleActor]
    ld hl, wSlotTrait
    add_a_to_hl
    ld a, [hl]
    cp a, $97
    jr c, Jump_030_5307
    ld e, $10

Jump_030_5307::
    call GetActorSlotTacticLow2
    ld hl, Data_030_5384
    call ReadBattleWordFromArray_Bank30
    add hl, de
    add hl, bc
    call CopyFourBytesNegatedByActorSlotTactic
    call RunBattleResolveStep_43C4_Case01_Sub04_Sub01
    ret

; copies four bytes from HL to hFFC6, negating each when bit 6 of the actor's wDA43 byte is set (CopyByteNegateIfCBit6) (E-0122)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_43C4_Case01_Sub04)
; points at: hTemp0
CopyFourBytesNegatedByActorSlotTactic::
Func_030_5319:: ; address name
    push hl
    call GetActorSlotTacticLow2
    ld c, [hl]
    pop hl
    ld de, hTemp0
    call CopyByteNegateIfCBit6
    inc hl
    inc de
    call CopyByteNegateIfCBit6
    inc hl
    inc de
    call CopyByteNegateIfCBit6
    inc hl
    inc de
    call CopyByteNegateIfCBit6
    ret

; [DE] = [HL], negated (two's complement) when bit 6 of C is set (E-0115)
; 4 call sites from 1 routine (e.g. CopyFourBytesNegatedByActorSlotTactic)
CopyByteNegateIfCBit6::
Func_030_5335:: ; address name
    ld a, [hl]
    ld [de], a
    bit 6, c
    ret z
    cpl
    inc a
    ld [de], a
    ret

; only called from RunBattleResolveStep_43C4_Case01_Sub04 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_43C4_Case01_Sub04)
; reads: wCommandByteE8, hTemp0, hTemp1, hTemp2, hTemp3, wBattleActor
; points at: hTemp0, wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo, wSlotTrait
RunBattleResolveStep_43C4_Case01_Sub04_Sub01::
Func_030_533E:: ; address name
    ld a, [wCommandByteE8]
    ld c, a
    ld b, $00
    ld hl, hTemp0
    add hl, bc
    ld e, [hl]
    push hl
    call GetActorSlotTacticLow2
    bit 6, [hl]
    pop hl
    jr z, Jump_030_5357
    ld a, e
    cpl
    inc a
    ld e, a
    ld [hl], e

Jump_030_5357::
    ldh a, [hTemp0]
    ld e, a
    ld hl, wSlotPersonalityHi
    call Func5428ForActorEntryOfHL
    ldh a, [hTemp1]
    ld e, a
    ld hl, wSlotPersonalityMid
    call Func5428ForActorEntryOfHL
    ldh a, [hTemp2]
    ld e, a
    ld hl, wSlotPersonalityLo
    call Func5428ForActorEntryOfHL
    ldh a, [hTemp3]
    ld e, a
    ld hl, wSlotTrait

; HL += actor, then Func_030_5428 (E-0122)
; 3 call sites from 1 routine (e.g. RunBattleResolveStep_43C4_Case01_Sub04_Sub01)
; reads: wBattleActor
Func5428ForActorEntryOfHL::
Func_030_5378:: ; address name
    ld a, [wBattleActor]
    add_a_to_hl
    call AddSignedEToByteAtHLClamped
    ret

; address loaded by RunBattleResolveStep_43C4_Case01_Sub04
Data_030_5384:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0C1384, $88

; A = wDA43[wBattleActor] & 3 (E-0072)
; 13 call sites from 12 routines (e.g. AddWeightsForSkillD_Sub01, AddRandomPersonalityWeights, AddStatusAndHPWeightsToAI, AddCommandWeightToAIChoiceWeights, ...)
; reads: wBattleActor
; points at: wSlotTactic
GetActorSlotTacticLow2::
Func_030_540C:: ; address name
    ld a, [wBattleActor]
    ld hl, wSlotTactic
    add_a_to_hl
    ld a, [hl]
    and a, $03
    ret

; HL = wBattleActionChoice + 2 * wBattleActor (the actor's action byte; the target follows) (E-0072)
; 12 call sites from 8 routines (e.g. ActorActionDataWord, AIChooseActionResolveStep, RunBattleResolveStep_43C4_Case01_Sub03, AIChooseActionForActor, ...)
; reads: wBattleActor
; points at: wBattleActionChoice
ActorActionChoiceAddress::
Func_030_541B:: ; address name
    ld a, [wBattleActor]
    add a, a
    ld hl, wBattleActionChoice
    add_a_to_hl
    ret

; [HL] += E as a signed value, clamped to 0-$FF (E-0124)
; 9 call sites from 6 routines (e.g. AddRandomPersonalityWeights, AddRandomWeightByValueBand, AddStatusAndHPWeightsToAI, AddActorPersonalityTensForIndexA, ...)
AddSignedEToByteAtHLClamped::
Func_030_5428:: ; address name
    bit 7, e
    jr z, Jump_030_5438
    ld a, e
    cpl
    inc a
    ld e, a
    ld a, [hl]
    sub a, e
    jr nc, Jump_030_543E
    ld a, $00
    jr Jump_030_543E

Jump_030_5438::
    ld a, e
    add a, [hl]
    jr nc, Jump_030_543E
    ld a, $FF

Jump_030_543E::
    ld [hl], a
    ret

; wPersonalityIndex = PersonalityIndexOfSlot_Bank30(actor); resets the AI workspace (Func_030_5472); with wD2CC = 1 runs the routine for the actor's AI mode (Data_030_45D0 indexed by wDA53[actor], JumpToHL) and stores its result B as the actor's chosen action; runs Func_030_4CFC; wD2CC = 0 (E-0120)
; 3 call sites from 2 routines (e.g. Func_032_4ADC_Case01_Case00, RunDebugState_E0_Case0D_Case05_Sub01)
; reads: wBattleActor
; writes: wPersonalityIndex, wAIFlag
; points at: wSlotAIMode
AIChooseActionForActor::
Func_030_5440:: ; address name
    ld a, [wBattleActor]
    call PersonalityIndexOfSlot_Bank30
    ld [wPersonalityIndex], a
    call AIChooseActionForActor_Sub01
    ld a, $01
    ld [wAIFlag], a
    ld a, [wBattleActor]
    ld hl, wSlotAIMode
    add_a_to_hl
    ld a, [hl]
    ld hl, Data_030_45D0
    call ReadBattleWordFromArray_Bank30
    call JumpToHL
    call ActorActionChoiceAddress
    ld [hl], b
    call RunActorActionHandlersForAISlots
    xor a, a
    ld [wAIFlag], a
    ret

; only called from AIChooseActionForActor (E-0047)
; 1 call site from 1 routine (e.g. AIChooseActionForActor)
; writes: wAIChoiceWeights, wAIChoiceOrder, wAIChoiceIndex, wLoadSlot
; points at: wAIWeights
AIChooseActionForActor_Sub01::
Func_030_5472:: ; address name
    ld hl, wAIWeights
    ld bc, $0014
    xor a, a
    call FillBytes
    xor a, a
    ld [wAIChoiceWeights], a
    ld [wAIChoiceWeights + $1], a
    ld [wAIChoiceWeights + $2], a
    ld a, $01
    ld [wAIChoiceOrder], a
    ld a, $02
    ld [wAIChoiceOrder + $1], a
    ld a, $03
    ld [wAIChoiceOrder + $2], a
    ld a, $03
    ld [wAIChoiceIndex], a
    call AIChooseActionForActor_Sub01_Sub01
    call AddCommandWeightToAIChoiceWeights
    call AddActorPersonalityTensToAIChoiceWeights
    call AddStatusAndHPWeightsToAI
    call AIChooseActionForActor_Sub01_Sub02
    call AddRandomPersonalityWeights
    call SortThreeAIWeightsRandomTies
    ld a, $00
    ld [wLoadSlot], a
    ret

; only called from AIChooseActionForActor_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. AIChooseActionForActor_Sub01)
; reads: wRecordBufferData
; points at: wAIChoiceWeights
AIChooseActionForActor_Sub01_Sub01::
Func_030_54B5:: ; address name
    ld a, [wRecordBufferData + $3]
    and a, $F0
    cp a, $10
    jr z, Jump_030_54C8
    cp a, $20
    jr z, Jump_030_54CD
    cp a, $30
    jr z, Jump_030_54D2
    jr Jump_030_54D9

Jump_030_54C8::
    ld hl, wAIChoiceWeights
    jr Jump_030_54D5

Jump_030_54CD::
    ld hl, wAIChoiceWeights + $1
    jr Jump_030_54D5

Jump_030_54D2::
    ld hl, wAIChoiceWeights + $2

Jump_030_54D5::
    ld a, [hl]
    add a, $0A
    ld [hl], a

Jump_030_54D9::
    ret

; only called from AIChooseActionForActor_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. AIChooseActionForActor_Sub01)
; reads: wBattleActor, wAIChoiceWeights
; writes: wAIChoiceWeights
; points at: wBattleCommandArgs, wBattleHP
AIChooseActionForActor_Sub01_Sub02::
Func_030_54DA:: ; address name
    ld a, [wBattleActor]
    rrca
    and a, $02
    xor a, $02
    ld hl, wBattleCommandArgs
    add_a_to_hl
    deref_hl
    push hl
    ld a, [wBattleActor]
    rrca
    and a, $02
    ld hl, wBattleCommandArgs
    add_a_to_hl
    deref_hl
    push hl
    ld a, [wBattleActor]
    rlca
    and a, $08
    ld hl, wBattleHP
    add_a_to_hl
    ld bc, $0000
    ld a, [hl+]
    add a, c
    ld c, a
    ld a, [hl+]
    adc a, b
    ld b, a
    ld a, [hl+]
    add a, c
    ld c, a
    ld a, [hl+]
    adc a, b
    ld b, a
    ld a, [hl+]
    add a, c
    ld c, a
    ld a, [hl+]
    adc a, b
    ld b, a
    ld h, b
    ld l, c
    add hl, bc
    pop bc
    call CompareHLToBC
    jr nc, Jump_030_5534
    ld a, [wAIChoiceWeights + $2]
    add a, $14
    ld [wAIChoiceWeights + $2], a

Jump_030_5534::
    ld a, [wBattleActor]
    rlca
    and a, $08
    xor a, $08
    ld hl, wBattleHP
    add_a_to_hl
    ld bc, $0000
    ld a, [hl+]
    add a, c
    ld c, a
    ld a, [hl+]
    adc a, b
    ld b, a
    ld a, [hl+]
    add a, c
    ld c, a
    ld a, [hl+]
    adc a, b
    ld b, a
    ld a, [hl+]
    add a, c
    ld c, a
    ld a, [hl+]
    adc a, b
    ld b, a
    ld h, b
    ld l, c
    add hl, bc
    add hl, bc
    pop bc
    call CompareHLToBC
    jr nc, Jump_030_556B
    ld a, [wAIChoiceWeights]
    add a, $14
    ld [wAIChoiceWeights], a

Jump_030_556B::
    ret

; advances the random seed; when wC5F8 is set and the random value is below wC5FA, stores wC5F9 as the actor's action choice (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wDebugCursor, wDebugValue1, wRandomLo, wDebugValue0
MaybeOverrideActorActionWithDebugValue0:: ; heuristic: follows a terminator; C0
Func_030_556C:: ; address name
    call AdvanceRandom
    call ActorActionChoiceAddress
    ld a, [wDebugCursor]
    or a, a
    jr z, Jump_030_5586
    ld a, [wDebugValue1]
    ld b, a
    ld a, [wRandomLo]
    cp a, b
    jr nc, Jump_030_5586
    ld a, [wDebugValue0]
    ld [hl], a

Jump_030_5586::
    ret

; E-0173 (C1: AddPersonalityWeightToBattleArg0 adds the byte $5587 + 4 * wPersonalityIndex + (the actor's wSlotTactic & 3) to the word wBattleArg0; 27 personality rows).
; record: weight added for tactic 0, 1, 2, 3
PersonalityTacticWeights::
Data_030_5587:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $14, $14, $14, $00 ; id 0
    db $14, $14, $0F, $00 ; id 1
    db $14, $14, $05, $00 ; id 2
    db $14, $0F, $14, $00 ; id 3
    db $14, $0F, $0F, $00 ; id 4
    db $14, $0F, $05, $0A ; id 5
    db $14, $05, $14, $00 ; id 6
    db $14, $05, $0F, $00 ; id 7
    db $14, $05, $05, $00 ; id 8
    db $0F, $14, $14, $00 ; id 9
    db $0F, $14, $0F, $00 ; id 10
    db $0F, $14, $05, $00 ; id 11
    db $0F, $0F, $14, $00 ; id 12
    db $0F, $0F, $0F, $00 ; id 13
    db $0F, $0F, $05, $00 ; id 14
    db $0F, $05, $14, $00 ; id 15
    db $0F, $05, $0F, $00 ; id 16
    db $0F, $05, $05, $00 ; id 17
    db $05, $14, $14, $00 ; id 18
    db $05, $14, $0F, $00 ; id 19
    db $05, $14, $05, $00 ; id 20
    db $05, $0F, $14, $00 ; id 21
    db $05, $0F, $0F, $00 ; id 22
    db $05, $0F, $05, $00 ; id 23
    db $05, $05, $14, $00 ; id 24
    db $05, $05, $0F, $00 ; id 25
    db $05, $05, $05, $00 ; id 26
    INCBIN "dwm2-cobi-us.gbc", $0C15F3, $143
    ds $11, $00
    db $50, $00, $00, $00, $50, $00, $5A, $00, $3C
    ds $33, $00
    db $64, $00

; E-0174 (C1: ScoreActionsWithAIScoreTableA stores this table's address in wBattleExpAward / +1 (the AI's routine-table pointer) and ScoreSkillForAI far-calls entry 3 * skill; all 131 entries point at named AIScore_* routines).
; record: AI scoring routine for this skill number; its ROM bank
AIScoreRoutineTableA::
Data_030_5785:: ; address name
    dfar AIScore_Skill00 ; id 0
    dfar AIScore_Blaze ; id 1
    dfar AIScore_Blaze ; id 2
    dfar AIScore_Blaze ; id 3
    dfar AIScore_Firebal ; id 4
    dfar AIScore_Firebal ; id 5
    dfar AIScore_Firebal ; id 6
    dfar AIScore_Firebal ; id 7
    dfar AIScore_Firebal ; id 8
    dfar AIScore_Firebal ; id 9
    dfar AIScore_Firebal ; id 10
    dfar AIScore_Firebal ; id 11
    dfar AIScore_Firebal ; id 12
    dfar AIScore_Firebal ; id 13
    dfar AIScore_Firebal ; id 14
    dfar AIScore_Firebal ; id 15
    dfar AIScore_Firebal ; id 16
    dfar AIScore_Firebal ; id 17
    dfar AIScore_Firebal ; id 18
    dfar AIScore_Beat ; id 19
    dfar AIScore_Beat ; id 20
    dfar AIScore_Sacrifice ; id 21
    dfar AIScore_Heal ; id 22
    dfar AIScore_Heal ; id 23
    dfar AIScore_Heal ; id 24
    dfar AIScore_HealUs ; id 25
    dfar AIScore_HealUs ; id 26
    dfar AIScore_MPass ; id 27
    dfar AIScore_MPass ; id 28
    dfar AIScore_MPass ; id 29
    dfar AIScore_Vivify ; id 30
    dfar AIScore_Vivify ; id 31
    dfar AIScore_Farewell ; id 32
    dfar AIScore_Antidote ; id 33
    dfar AIScore_DeChaos ; id 34
    dfar AIScore_NumbOff ; id 35
    dfar AIScore_CurseOff ; id 36
    dfar AIScore_Upper ; id 37
    dfar AIScore_Upper ; id 38
    dfar AIScore_Sap ; id 39
    dfar AIScore_Sap ; id 40
    dfar AIScore_Speed ; id 41
    dfar AIScore_Speed ; id 42
    dfar AIScore_Slow ; id 43
    dfar AIScore_Slow ; id 44
    dfar AIScore_TwinHits ; id 45
    dfar AIScore_Surround ; id 46
    dfar AIScore_Sleep ; id 47
    dfar AIScore_Sleep ; id 48
    dfar AIScore_TakeMagic ; id 49
    dfar AIScore_RobMagic ; id 50
    dfar AIScore_StopSpell ; id 51
    dfar AIScore_PanicAll ; id 52
    dfar AIScore_Ironize ; id 53
    dfar AIScore_MagicBack ; id 54
    dfar AIScore_MagicBack ; id 55
    dfar AIScore_Barrier ; id 56
    dfar AIScore_MagicWall ; id 57
    dfar AIScore_Transform ; id 58
    dfar AIScore_BeDragon ; id 59
    dfar AIScore_Chance ; id 60
    dfar AIScore_MegaMagic ; id 61
    dfar AIScore_BigBang ; id 62
    dfar AIScore_BigBang ; id 63
    dfar AIScore_FireAir ; id 64
    dfar AIScore_FireAir ; id 65
    dfar AIScore_FireAir ; id 66
    dfar AIScore_FireAir ; id 67
    dfar AIScore_FireAir ; id 68
    dfar AIScore_FireAir ; id 69
    dfar AIScore_FireAir ; id 70
    dfar AIScore_FireAir ; id 71
    dfar AIScore_WindBeast ; id 72
    dfar AIScore_Vacuum ; id 73
    dfar AIScore_Vacuum ; id 74
    dfar AIScore_RockThrow ; id 75
    dfar AIScore_Watershot ; id 76
    dfar AIScore_Tidalwave ; id 77
    dfar AIScore_CallHelp ; id 78
    dfar AIScore_CallHelp ; id 79
    dfar AIScore_FireSlash ; id 80
    dfar AIScore_FireSlash ; id 81
    dfar AIScore_FireSlash ; id 82
    dfar AIScore_FireSlash ; id 83
    dfar AIScore_SlimeBlow ; id 84
    dfar AIScore_DrakSlash ; id 85
    dfar AIScore_BeastCut ; id 86
    dfar AIScore_BirdBlow ; id 87
    dfar AIScore_BugBlow ; id 88
    dfar AIScore_Shears ; id 89
    dfar AIScore_DevilCut ; id 90
    dfar AIScore_ZombieCut ; id 91
    dfar AIScore_CleanCut ; id 92
    dfar AIScore_AquaCut ; id 93
    dfar AIScore_MetalCut ; id 94
    dfar AIScore_PoisonHit ; id 95
    dfar AIScore_Paralyze ; id 96
    dfar AIScore_NapAttack ; id 97
    dfar AIScore_SquallHit ; id 98
    dfar AIScore_BiAttack ; id 99
    dfar AIScore_BiAttack ; id 100
    dfar AIScore_RainSlash ; id 101
    dfar AIScore_MultiCut ; id 102
    dfar AIScore_GigaSlash ; id 103
    dfar AIScore_ChargeUp ; id 104
    dfar AIScore_PsycheUp ; id 105
    dfar AIScore_HighJump ; id 106
    dfar AIScore_EvilSlash ; id 107
    dfar AIScore_Massacre ; id 108
    dfar AIScore_TwinSlash ; id 109
    dfar AIScore_Berserker ; id 110
    dfar AIScore_Ramming ; id 111
    dfar AIScore_Kamikaze ; id 112
    dfar AIScore_SleepAir ; id 113
    dfar AIScore_PalsyAir ; id 114
    dfar AIScore_PoisonGas ; id 115
    dfar AIScore_PoisonAir ; id 116
    dfar AIScore_Curse ; id 117
    dfar AIScore_OddDance ; id 118
    dfar AIScore_OddDance ; id 119
    dfar AIScore_PaniDance ; id 120
    dfar AIScore_KODance ; id 121
    dfar AIScore_LureDance ; id 122
    dfar AIScore_LifeDance ; id 123
    dfar AIScore_Hustle ; id 124
    dfar AIScore_SideStep ; id 125
    dfar AIScore_SandStorm ; id 126
    dfar AIScore_Radiant ; id 127
    dfar AIScore_EerieLite ; id 128
    dfar AIScore_Surge ; id 129
    dfar AIScore_UltraDown ; id 130
    dw Data_030_5D83
    db $E2
    dw Data_030_5DBC
    db $E2
    dw Data_030_5DED
    db $E2
    dw Data_030_5DED
    db $E2
    dw Data_030_5DED
    db $E2
    dw Data_030_5DED
    db $E2
    dw Data_030_5E46
    db $E2
    dw Data_030_5E83
    db $E2
    dw Data_030_5EC0
    db $E2
    dw Data_030_5F0A
    db $E2
    dw Data_030_5F94
    db $E2
    dw Data_030_5F94
    db $E2
    dw Data_030_5FE8
    db $E2
    dw Data_030_5FE8
    db $E2
    dw Data_030_6044
    db $E2
    dw Data_030_6089
    db $E2
    dw Data_030_60A6
    db $E2
    dw Data_030_60D7
    db $E2
    dw Data_030_6112
    db $E2
    dw Data_030_6139
    db $E2
    dw Data_030_6160
    db $E2
    dw Data_030_6160
    db $E2
    dw Data_030_618D
    db $E2
    dw Data_030_61C2
    db $E2
    dw Data_030_61CD
    db $E2
    dw Data_030_61E0
    db $E2
    dw Data_030_6249
    db $E2
    dw Data_030_62A4
    db $E2
    dw Data_030_6303
    db $E2
    dw Data_030_6350
    db $E2
    dw Data_030_6387
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_6401
    db $E2
    dw Data_030_641E
    db $E2
    dw Data_030_6425
    db $E2
    dw Data_030_6473
    db $E2
    dw Data_030_648D
    db $E2
    dw Data_030_64BF
    db $E2
    dw Data_030_64BF
    db $E2
    dw Data_030_64BF
    db $E2, $FA, $63, $E2, $FA, $63, $E2, $BF, $64, $E2, $BF, $64, $E2, $FA, $63, $E2
    db $FA, $63, $E2, $BF, $64, $E2, $BF, $64, $E2, $01, $64, $E2, $1E, $64, $E2, $BF
    db $64, $E2, $BF, $64, $E2
    dw Data_030_648D
    db $E2
    dw Data_030_64BF
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C1
    db $E2

; E-0174 (C1: UseAIScoreTableB stores this table's address in wBattleExpAward / +1 (the AI's routine-table pointer) and ScoreSkillForAI far-calls entry 3 * skill; all 131 entries point at named AIScore_* routines).
; record: AI scoring routine for this skill number; its ROM bank
AIScoreRoutineTableB::
Data_030_59E0:: ; address name
    dfar AIScore_Skill00 ; id 0
    dfar AIScore_Blaze ; id 1
    dfar AIScore_Blaze ; id 2
    dfar AIScore_Blaze ; id 3
    dfar AIScore_Firebal ; id 4
    dfar AIScore_Firebal ; id 5
    dfar AIScore_Firebal ; id 6
    dfar AIScore_Firebal ; id 7
    dfar AIScore_Firebal ; id 8
    dfar AIScore_Firebal ; id 9
    dfar AIScore_Firebal ; id 10
    dfar AIScore_Firebal ; id 11
    dfar AIScore_Firebal ; id 12
    dfar AIScore_Firebal ; id 13
    dfar AIScore_Firebal ; id 14
    dfar AIScore_Firebal ; id 15
    dfar AIScore_Firebal ; id 16
    dfar AIScore_Firebal ; id 17
    dfar AIScore_Firebal ; id 18
    dfar AIScore_Beat ; id 19
    dfar AIScore_Beat ; id 20
    dfar AIScore_Sacrifice ; id 21
    dfar AIScore_Heal ; id 22
    dfar AIScore_Heal ; id 23
    dfar AIScore_Heal ; id 24
    dfar AIScore_HealUs ; id 25
    dfar AIScore_HealUs ; id 26
    dfar AIScore_MPass ; id 27
    dfar AIScore_MPass ; id 28
    dfar AIScore_MPass ; id 29
    dfar AIScore_Vivify ; id 30
    dfar AIScore_Vivify ; id 31
    dfar AIScore_Farewell ; id 32
    dfar AIScore_Antidote ; id 33
    dfar AIScore_DeChaos ; id 34
    dfar AIScore_NumbOff ; id 35
    dfar AIScore_CurseOff ; id 36
    dfar AIScore_Upper ; id 37
    dfar AIScore_Upper ; id 38
    dfar AIScore_Sap ; id 39
    dfar AIScore_Sap ; id 40
    dfar AIScore_Speed ; id 41
    dfar AIScore_Speed ; id 42
    dfar AIScore_Slow ; id 43
    dfar AIScore_Slow ; id 44
    dfar AIScore_TwinHits ; id 45
    dfar AIScore_Surround ; id 46
    dfar AIScore_Sleep ; id 47
    dfar AIScore_Sleep ; id 48
    dfar AIScore_TakeMagic ; id 49
    dfar AIScore_RobMagic ; id 50
    dfar AIScore_StopSpell ; id 51
    dfar AIScore_PanicAll ; id 52
    dfar AIScore_Ironize ; id 53
    dfar AIScore_MagicBack ; id 54
    dfar AIScore_MagicBack ; id 55
    dfar AIScore_Barrier ; id 56
    dfar AIScore_MagicWall ; id 57
    dfar AIScore_Transform ; id 58
    dfar AIScore_BeDragon ; id 59
    dfar AIScore_Chance ; id 60
    dfar AIScore_MegaMagic ; id 61
    dfar AIScore_BigBang ; id 62
    dfar AIScore_BigBang ; id 63
    dfar AIScore_FireAir ; id 64
    dfar AIScore_FireAir ; id 65
    dfar AIScore_FireAir ; id 66
    dfar AIScore_FireAir ; id 67
    dfar AIScore_FireAir ; id 68
    dfar AIScore_FireAir ; id 69
    dfar AIScore_FireAir ; id 70
    dfar AIScore_FireAir ; id 71
    dfar AIScore_WindBeast ; id 72
    dfar AIScore_Vacuum ; id 73
    dfar AIScore_Vacuum ; id 74
    dfar AIScore_RockThrow ; id 75
    dfar AIScore_Watershot ; id 76
    dfar AIScore_Tidalwave ; id 77
    dfar AIScore_CallHelp ; id 78
    dfar AIScore_CallHelp ; id 79
    dfar AIScore_FireSlash ; id 80
    dfar AIScore_FireSlash ; id 81
    dfar AIScore_FireSlash ; id 82
    dfar AIScore_FireSlash ; id 83
    dfar AIScore_SlimeBlow ; id 84
    dfar AIScore_DrakSlash ; id 85
    dfar AIScore_BeastCut ; id 86
    dfar AIScore_BirdBlow ; id 87
    dfar AIScore_BugBlow ; id 88
    dfar AIScore_Shears ; id 89
    dfar AIScore_DevilCut ; id 90
    dfar AIScore_ZombieCut ; id 91
    dfar AIScore_CleanCut ; id 92
    dfar AIScore_AquaCut ; id 93
    dfar AIScore_MetalCut ; id 94
    dfar AIScore_PoisonHit ; id 95
    dfar AIScore_Paralyze ; id 96
    dfar AIScore_NapAttack ; id 97
    dfar AIScore_SquallHit ; id 98
    dfar AIScore_BiAttack ; id 99
    dfar AIScore_BiAttack ; id 100
    dfar AIScore_RainSlash ; id 101
    dfar AIScore_MultiCut ; id 102
    dfar AIScore_GigaSlash ; id 103
    dfar AIScore_ChargeUp ; id 104
    dfar AIScore_PsycheUp ; id 105
    dfar AIScore_HighJump ; id 106
    dfar AIScore_EvilSlash ; id 107
    dfar AIScore_Massacre ; id 108
    dfar AIScore_TwinSlash ; id 109
    dfar AIScore_Berserker ; id 110
    dfar AIScore_Ramming ; id 111
    dfar AIScore_Kamikaze ; id 112
    dfar AIScore_SleepAir ; id 113
    dfar AIScore_PalsyAir ; id 114
    dfar AIScore_PoisonGas ; id 115
    dfar AIScore_PoisonAir ; id 116
    dfar AIScore_Curse ; id 117
    dfar AIScore_OddDance ; id 118
    dfar AIScore_OddDance ; id 119
    dfar AIScore_PaniDance ; id 120
    dfar AIScore_KODance ; id 121
    dfar AIScore_LureDance ; id 122
    dfar AIScore_LifeDance ; id 123
    dfar AIScore_Hustle ; id 124
    dfar AIScore_SideStep ; id 125
    dfar AIScore_SandStorm ; id 126
    dfar AIScore_Radiant ; id 127
    dfar AIScore_EerieLite ; id 128
    dfar AIScore_Surge ; id 129
    dfar AIScore_UltraDown ; id 130
    dw Data_030_5D83
    db $E2
    dw Data_030_5DBC
    db $E2
    dw Data_030_5DED
    db $E2
    dw Data_030_5DED
    db $E2
    dw Data_030_5DED
    db $E2
    dw Data_030_5DED
    db $E2
    dw Data_030_5E46
    db $E2
    dw Data_030_5E83
    db $E2
    dw Data_030_5EC0
    db $E2
    dw Data_030_5F0A
    db $E2
    dw Data_030_5F94
    db $E2
    dw Data_030_5F94
    db $E2
    dw Data_030_5FE8
    db $E2
    dw Data_030_5FE8
    db $E2
    dw Data_030_6044
    db $E2
    dw Data_030_6089
    db $E2
    dw Data_030_60A6
    db $E2
    dw Data_030_60D7
    db $E2
    dw Data_030_6112
    db $E2
    dw Data_030_6139
    db $E2
    dw Data_030_6160
    db $E2
    dw Data_030_6160
    db $E2
    dw Data_030_618D
    db $E2
    dw Data_030_61C2
    db $E2
    dw Data_030_61CD
    db $E2
    dw Data_030_61E0
    db $E2
    dw Data_030_6249
    db $E2
    dw Data_030_62A4
    db $E2
    dw Data_030_6303
    db $E2
    dw Data_030_6350
    db $E2
    dw Data_030_6387
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_6401
    db $E2
    dw Data_030_641E
    db $E2
    dw Data_030_6425
    db $E2
    dw Data_030_6473
    db $E2
    dw Data_030_648D
    db $E2
    dw Data_030_64BF
    db $E2
    dw Data_030_64BF
    db $E2
    dw Data_030_64BF
    db $E2, $FA, $63, $E2, $FA, $63, $E2, $BF, $64, $E2, $BF, $64, $E2, $FA, $63, $E2
    db $FA, $63, $E2, $BF, $64, $E2, $BF, $64, $E2, $01, $64, $E2, $1E, $64, $E2, $BF
    db $64, $E2, $BF, $64, $E2
    dw Data_030_648D
    db $E2
    dw Data_030_64BF
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C1
    db $E2

; HL = wBattleATK, then ReadBattleWordFromArray_Bank30 (E-0122)
; 1 call site from 1 routine (e.g. EstimateDamageVsEachFoeToAIDamageEstimates)
; points at: wBattleATK
ReadBattleATKOfSlot_Bank30::
Func_030_5C3B:: ; address name
    ld hl, wBattleATK
    jr ReadBattleWordFromArray_Bank30

; HL = wBattleDEF, then ReadBattleWordFromArray_Bank30 (E-0122)
; 1 call site from 1 routine (e.g. EstimateDamageVsEachFoeToAIDamageEstimates)
; points at: wBattleDEF
ReadBattleDEFOfSlot_Bank30::
Func_030_5C40:: ; address name
    ld hl, wBattleDEF
    jr ReadBattleWordFromArray_Bank30

; HL = wBattleMaxHP, then ReadBattleWordFromArray_Bank30 (E-0122)
; 1 call site from 1 routine (e.g. AnyAllyHPBelowSixthOfMax)
; points at: wBattleMaxHP
ReadBattleMaxHPOfSlot_Bank30::
Func_030_5C45:: ; address name
    ld hl, wBattleMaxHP
    jr ReadBattleWordFromArray_Bank30
    db $21, $EF, $D8, $18, $19

; HL = wBattleHP, then ReadBattleWordFromArray_Bank30 (E-0122)
; 1 call site from 1 routine (e.g. AnyAllyHPBelowSixthOfMax)
; points at: wBattleHP
ReadBattleHPOfSlot_Bank30::
Func_030_5C4F:: ; address name
    ld hl, wBattleHP
    jr ReadBattleWordFromArray_Bank30
    db $21, $DF, $D8, $18, $0F, $21, $1F, $D9, $18, $0A, $21, $53, $DA, $85, $6F, $30
    db $01, $24, $7E, $C9

; the same 10 bytes as ReadBattleWordFromArray (36:7E5B)
; 5 call sites from 5 routines (e.g. AIChooseActionResolveStep, RunBattleResolveStep_43C4_Case01_Sub04, RunBattleResolveStep_43C4_Case01_Sub02, AIChooseActionForActor, ...)
ReadBattleWordFromArray_Bank30::
Func_030_5C68:: ; address name
    add a, a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes appear in 10 banks)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_43C4_Case01)
AddDoubleAToHL_Bank30::
Func_030_5C72:: ; address name
    add a, a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the reversal, not checked (E-0064) (the same 27 bytes appear in 10 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole, wBattleActor
ActorOnLocalSide_Bank30:: ; heuristic: follows a terminator; C0
Func_030_5C79:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr nz, Jump_030_5C8E
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_030_5C8E
    ld a, [wBattleActor]
    cp a, $04
    ccf
    ret

Jump_030_5C8E::
    ld a, [wBattleActor]
    cp a, $04
    ret

; carry set when wBattleTarget < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleTarget >= 4) (E-0064) (the same 27 bytes appear in 10 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole, wBattleTarget
TargetOnLocalSide_Bank30:: ; heuristic: follows a terminator; C0
Func_030_5C94:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr nz, Jump_030_5CA9
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_030_5CA9
    ld a, [wBattleTarget]
    cp a, $04
    ccf
    ret

Jump_030_5CA9::
    ld a, [wBattleTarget]
    cp a, $04
    ret
    INCBIN "dwm2-cobi-us.gbc", $0C1CAF, $43

; A = slot 0-7: returns A = 9 * g(wD968[A]) + 3 * g(wD970[A]) + g(wD978[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes appear in 7 banks)
; 2 call sites from 2 routines (e.g. RunBattleResolveStep_43C4_Case00, AIChooseActionForActor)
; points at: wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo
PersonalityIndexOfSlot_Bank30::
Func_030_5CF2:: ; address name
    push hl
    push bc
    ld c, a
    ld b, $00
    ld hl, wSlotPersonalityHi
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_030_5D0E
    ld l, $09
    cp a, $40
    jr nc, Jump_030_5D0E
    ld l, $12

Jump_030_5D0E::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityMid
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_030_5D29
    ld l, $03
    cp a, $40
    jr nc, Jump_030_5D29
    ld l, $06

Jump_030_5D29::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityLo
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_030_5D44
    ld l, $01
    cp a, $40
    jr nc, Jump_030_5D44
    ld l, $02

Jump_030_5D44::
    ld a, l
    add a, b
    pop bc
    pop hl
    ret

; A = slot: carry set when CheckSlotStatusBlock sets it, or when status byte 3 & $C0 or byte 4 & $0C is set (wD80F + 9 * A); otherwise carry clear; A, BC, HL kept (E-0067) (the same 31 bytes appear in 7 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleStatus3
CheckSlotStatusBlockWide_Bank30:: ; heuristic: follows a terminator; C0
Func_030_5D49:: ; address name
    call CheckSlotStatusBlock
    ret c
    push hl
    push bc
    ld c, a
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_030_5D63
    ld a, [hl]
    and a, $0C
    jr nz, Jump_030_5D63
    xor a, a
    jr Jump_030_5D64

Jump_030_5D63::
    scf

Jump_030_5D64::
    ld a, c
    pop bc
    pop hl
    ret

; A = slot: with HL = wD80F + 9 * A (status byte 3 of wBattleStatus), A = byte 3 & $C0, or byte 4 & $0C when that is zero; Z set when both are clear; HL kept (E-0067) (the same 17 bytes appear in 8 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleStatus3
SlotHasStatus3Or4Bits_Bank30:: ; heuristic: follows a terminator; C0
Func_030_5D68:: ; address name
    push hl
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_030_5D77
    ld a, [hl]
    and a, $0C

Jump_030_5D77::
    pop hl
    ret
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_030_5D83:: ; heuristic: target of a monotone pointer table; C0
    ds $39, $00

Data_030_5DBC:: ; heuristic: target of a monotone pointer table; C0
    ds $31, $00

Data_030_5DED:: ; heuristic: target of a monotone pointer table; C0
    ds $59, $00

Data_030_5E46:: ; heuristic: target of a monotone pointer table; C0
    ds $3D, $00

Data_030_5E83:: ; heuristic: target of a monotone pointer table; C0
    ds $3D, $00

Data_030_5EC0:: ; heuristic: target of a monotone pointer table; C0
    ds $4A, $00

Data_030_5F0A:: ; heuristic: target of a monotone pointer table; C0
    ds $8A, $00

Data_030_5F94:: ; heuristic: target of a monotone pointer table; C0
    ds $54, $00

Data_030_5FE8:: ; heuristic: target of a monotone pointer table; C0
    ds $5C, $00

Data_030_6044:: ; heuristic: target of a monotone pointer table; C0
    ds $45, $00

Data_030_6089:: ; heuristic: target of a monotone pointer table; C0
    ds $1D, $00

Data_030_60A6:: ; heuristic: target of a monotone pointer table; C0
    ds $31, $00

Data_030_60D7:: ; heuristic: target of a monotone pointer table; C0
    ds $3B, $00

Data_030_6112:: ; heuristic: target of a monotone pointer table; C0
    ds $27, $00

Data_030_6139:: ; heuristic: target of a monotone pointer table; C0
    ds $27, $00

Data_030_6160:: ; heuristic: target of a monotone pointer table; C0
    ds $2D, $00

Data_030_618D:: ; heuristic: target of a monotone pointer table; C0
    ds $35, $00

Data_030_61C2:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_030_61CD:: ; heuristic: target of a monotone pointer table; C0
    ds $13, $00

Data_030_61E0:: ; heuristic: target of a monotone pointer table; C0
    ds $69, $00

Data_030_6249:: ; heuristic: target of a monotone pointer table; C0
    ds $5B, $00

Data_030_62A4:: ; heuristic: target of a monotone pointer table; C0
    ds $5F, $00

Data_030_6303:: ; heuristic: target of a monotone pointer table; C0
    ds $4D, $00

Data_030_6350:: ; heuristic: target of a monotone pointer table; C0
    ds $37, $00

Data_030_6387:: ; heuristic: target of a monotone pointer table; C0
    ds $73, $00

Data_030_63FA:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $00

Data_030_6401:: ; heuristic: target of a monotone pointer table; C0
    ds $1D, $00

Data_030_641E:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $00

Data_030_6425:: ; heuristic: target of a monotone pointer table; C0
    ds $4E, $00

Data_030_6473:: ; heuristic: target of a monotone pointer table; C0
    ds $1A, $00

Data_030_648D:: ; heuristic: target of a monotone pointer table; C0
    ds $32, $00

Data_030_64BF:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_030_64C0:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_030_64C1:: ; heuristic: target of a monotone pointer table; C0
    ds $1B3F, $00
