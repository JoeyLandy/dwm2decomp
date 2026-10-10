SECTION "Bank 30", ROMX[$4000], BANK[$30]
    db $30

; battle fight step 2: returns while a message is being drawn (wC52B); otherwise one of 7 sub-steps by wBattleSubPhase; case 0 loads the slots' personality bytes (wSlotPersonality*), the command menu loop follows
; 1 call site from 1 routine (e.g. BattleFight_Step2)
; reads: wC52B, wBattleSubPhase
RunBattleCommandEntry::
Func_030_4001:: ; address name
    ld a, [wC52B]
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
; reads: wC58A, wD88F
; writes: wDAE8
; points at: wBattleSubPhase, wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo, wD980
RunBattleCommandEntry_Case00::
Jump_030_4018:: ; address name
    ld hl, wBattleSubPhase
    inc [hl]
    ld a, [wC58A]
    or a, a
    ret nz
    xor a, a
    ld [wDAE8], a
    ld a, [wD88F]
    ld b, a
    ld c, $00
    ld hl, wSlotPersonalityHi
    ld de, $0000
    call RunBattleCommandEntry_Case00_Sub01
    ld a, [wD88F]
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
    ld [wDAE8], a

Jump_030_4052::
    push hl
    ld a, [wD88F]
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
    ld [wDAE8], a

Jump_030_4070::
    push hl
    ld a, [wD88F]
    ld b, a
    ld c, $00
    ld hl, wD980
    ld de, $0000
    call RunBattleCommandEntry_Case00_Sub01
    pop hl
    ld a, l
    sub a, e
    ld a, h
    sbc a, d
    jr nc, Jump_030_408C
    ld a, $03
    ld [wDAE8], a

Jump_030_408C::
    ret

; only called from RunBattleCommandEntry_Case00 (E-0047)
; 4 call sites from 1 routine (e.g. RunBattleCommandEntry_Case00)
RunBattleCommandEntry_Case00_Sub01::
Func_030_408D:: ; address name
    ld a, c
    call CarryUnlessWDA63SlotEmpty
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
; reads: wC58A, wBattleActor
; writes: wBattleActor, wBattleResolveStep
; points at: wDA5B, wBattleSubPhase
RunBattleCommandEntry_Case01::
Jump_030_40A0:: ; address name
    ld a, [wC58A]
    or a, a
    call nz, NextTableByteSecondStream
    ld a, [wBattleActor]
    cp a, $08
    jr z, Jump_030_40D6
    ld e, a
    ld hl, wDA5B
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
    call CarryUnlessWDA63SlotEmpty
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
; points at: wDA5B, wBattleActor
RunBattleCommandEntry_Case03::
Jump_030_40E7:: ; address name
    call ChooseTargetForActor
    ld a, [wBattleActor]
    ld hl, wDA5B
    add_a_to_hl
    ld a, $02
    ld [hl], a
    ld a, $01
    ld [wBattleSubPhase], a
    ld hl, wBattleActor
    inc [hl]
    ret

; uses the preset target when the side is player-controlled, bit 7 of its wDAD8 byte is clear and wBattleTargetChoice is set; otherwise ChooseActionTarget; stores the result (E-0125)
; 5 call sites from 4 routines (e.g. RunBattleCommandEntry_Case03, ActionEffect_Chance, RunBattleActions_Case06, Func_03A_6846)
; reads: wC58A, wC46B, wBattleActor
; points at: wDAD8, wBattleTargetChoice, wDAE9
ChooseTargetForActor::
Func_030_4102:: ; address name
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_030_4112
    cp a, $02
    jr z, Jump_030_4149
    ld a, [wC46B]
    jr Jump_030_4122

Jump_030_4112::
    ld a, [wBattleActor]
    rrca
    rrca
    and a, $01
    ld hl, wDAE9
    add_a_to_hl
    ld a, [hl]

Jump_030_4122::
    and a, $03
    cp a, $01
    jr nz, Jump_030_4149
    ld a, [wBattleActor]
    ld hl, wDAD8
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
; reads: wD871
; writes: wD89E, wD871, wD87A, wD87B
; points at: wD895, wD868, wD87D, wDA5B, wD87A, wD871, wBattleSubPhase
RunBattleCommandEntry_Case04::
Jump_030_4160:: ; address name
    ld hl, wD895
    ld bc, $0009
    ld a, $FF
    call FillBytes
    ld hl, wD868
    ld bc, $0009
    ld a, $FF
    call FillBytes
    ld hl, wD87D
    ld bc, $0012
    ld a, $00
    call FillBytes
    xor a, a
    ld [wD89E], a
    ld [wD871], a
    ld hl, wD87D
    ld a, l
    ld [wD87A], a
    ld a, h
    ld [wD87B], a
    ld de, $0800

Jump_030_4196::
    ld a, e
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_030_41D2
    ld a, e
    ld hl, wDA5B
    add_a_to_hl
    ld a, [hl]
    cp a, $02
    jr nz, Jump_030_41D2
    ld a, e
    call RunBattleCommandEntry_Case04_Sub01
    call RunBattleCommandEntry_Case04_Sub02
    ld hl, wD87A
    deref_hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wD871]
    ld hl, wD868
    add_a_to_hl
    ld [hl], e
    ld hl, wD871
    inc [hl]
    ld hl, wD87A
    inc [hl]
    ld hl, wD87A
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
; reads: wD868, wD869, wD86A, wD86B, wCFF3, wC5E7
; writes: wRecordBuffer, wCFED, wD868, wD869, wD86A, wD86B
; points at: wBattleActionChoice, wCFF3
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
    ld [wCFED], a
    ld a, [wD868]
    ld l, a
    ld a, [wD869]
    ld h, a
    push hl
    ld a, [wD86A]
    ld l, a
    ld a, [wD86B]
    ld h, a
    push hl
    ld a, $05
    ld [wD868], a
    ld a, $01
    ld [wD869], a
    ld hl, wCFF3
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    farcall LoadSkillRecordPart
    pop hl
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    pop hl
    ld a, l
    ld [wD868], a
    ld a, h
    ld [wD869], a
    pop hl
    pop de
    pop bc
    pop af
    ld a, [wCFF3]
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
    ld a, [wC5E7]
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
; reads: wD892, wD871
; points at: wD87A, wD868
RunBattleCommandEntry_Case04_Sub03::
Func_030_4297:: ; address name
    ld a, [wD892]
    cp a, $FF
    ret z
    ld bc, $07DA
    ld hl, wD87A
    deref_hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wD871]
    ld hl, wD868
    add_a_to_hl
    ld [hl], $10
    ret

; entry 5 of the `rst $00` table in RunBattleCommandEntry
; no direct call (reached through a table, a jump or a vector)
; reads: wD87A, wD87B, wBattleDamageLo, wD873, wD874, wD875, wD89E
; writes: wD87A, wD87B, wBattleDamageLo, wD873, wD874, wD875, wD89E
; points at: wD87D, wD87F, wD868, wD87A, wD895, wBattleSubPhase
RunBattleCommandEntry_Case05::
Jump_030_42B7:: ; address name
    ld d, $08

Jump_030_42B9::
    ld hl, wD87D
    ld a, l
    ld [wD87A], a
    ld a, h
    ld [wD87B], a
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld hl, wD87F
    deref_hl
    ld e, $00

Jump_030_42CF::
    call CompareHLToBC
    jr c, Jump_030_4309
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ld a, c
    ld [wD874], a
    ld a, b
    ld [wD875], a
    ld a, [wD87A]
    ld l, a
    ld a, [wD87B]
    ld h, a
    ld a, [wBattleDamageLo]
    ld [hl+], a
    ld a, [wD873]
    ld [hl+], a
    ld a, [wD874]
    ld [hl+], a
    ld a, [wD875]
    ld [hl], a
    ld a, e
    ld hl, wD868
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
    ld hl, wD87A
    inc [hl]
    ld hl, wD87A
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
    ld a, [wD89E]
    ld de, wD895
    add a, e
    ld e, a
    jr nc, Jump_030_4330
    inc d

Jump_030_4330::
    ld a, [wD89E]
    ld hl, wD868
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
    ld [wD89E], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunBattleCommandEntry
; no direct call (reached through a table, a jump or a vector)
; writes: wD2C8, wD2C9, wD2CA, wD2CB, wBattleSubPhase
; points at: wBattleHP, wBattleMaxHP, wBattleStep, wBattleResolveStep
RunBattleCommandEntry_Case06::
Jump_030_434C:: ; address name
    ld hl, wBattleHP
    ld bc, $0000
    call AddWordAtHLToBC_Bank30
    call AddWordAtHLToBC_Bank30
    call AddWordAtHLToBC_Bank30
    ld a, c
    ld [wD2C8], a
    ld a, b
    ld [wD2C9], a
    ld hl, wBattleMaxHP
    ld bc, $0000
    call AddWordAtHLToBC_Bank30
    call AddWordAtHLToBC_Bank30
    call AddWordAtHLToBC_Bank30
    ld a, c
    ld [wD2CA], a
    ld a, b
    ld [wD2CB], a
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
; points at: wBattleActionChoice, wD812
RunBattleCommandEntry_Case06_Sub01::
Func_030_439D:: ; address name
    ld c, $00
    ld b, $08

Jump_030_43A1::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_030_43BF
    ld a, c
    add a, a
    ld hl, wBattleActionChoice
    add_a_to_hl
    ld a, [hl]
    cp a, $6E
    jr nz, Jump_030_43BF
    ld a, c
    ld hl, wD812
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
; reads: wBattleActor, wC58A, wC46B, wDAE9
; writes: wPersonalityIndex
; points at: wDAE9, wBattleResolveStep
RunBattleResolveStep_43C4_Case00::
Jump_030_43D0:: ; address name
    ld a, [wBattleActor]
    call PersonalityIndexOfSlot_Bank30
    ld [wPersonalityIndex], a
    call ForcedActionForActorStatus
    jr nz, Jump_030_4414
    ld a, [wC58A]
    or a, a
    jr z, Jump_030_440B
    cp a, $02
    jr z, Jump_030_43FA
    ld a, [wBattleActor]
    rrca
    rrca
    and a, $01
    ld hl, wDAE9
    add_a_to_hl
    ld a, [hl]
    jr Jump_030_440E

Jump_030_43FA::
    ld a, [wBattleActor]
    cp a, $01
    jr z, Jump_030_4406
    ld a, [wC46B]
    jr Jump_030_440E

Jump_030_4406::
    ld a, [wDAE9]
    jr Jump_030_440E

Jump_030_440B::
    ld a, [wC46B]

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
; reads: wC58A, wBattleActor, wD868, wD869, wD86A, wD86B
; writes: wBattleStatResultLo, wBattleResolveStep
; points at: wBattleResolveStep, wD868, wBattleStatus, wDAE0, wBattleActionChoice, wDAD8
RunBattleResolveStep_43C4_Case01::
Jump_030_441D:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleStatResultLo], a
    ld a, [wC58A]
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
    ld hl, wD868
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
    call ActorWD93FBand
    or a, a
    jr z, Jump_030_4480
    cp a, $01
    jr z, Jump_030_4497
    call RunBattleResolveStep_43C4_Case01_Sub01
    call RunBattleResolveStep_43C4_Case01_Sub02
    call AddPersonalityWeightToWD868
    call AddActorWD93FDiv16ToWD86A
    call AddRandom0To63ToWD86A
    ld a, [wD868]
    ld l, a
    ld a, [wD869]
    ld h, a
    ld a, [wD86A]
    ld c, a
    ld a, [wD86B]
    ld b, a
    call CompareHLToBC
    jr c, Jump_030_4497

Jump_030_4480::
    call GetActorWDA43Low2
    res 6, [hl]
    ld a, [wBattleActor]
    ld hl, wDAE0
    add_a_to_hl
    ld [hl], $00
    call RunBattleResolveStep_43C4_Case01_Sub04
    jr Jump_030_44DF

Jump_030_4497::
    call GetActorWDA43Low2
    set 6, [hl]
    ld a, [wBattleActor]
    ld hl, wDAE0
    add_a_to_hl
    ld [hl], $01
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    call AddDoubleAToHL_Bank30
    ld a, $FF
    ld [hl+], a
    ld [hl], a
    ld a, [wBattleActor]
    ld hl, wDAD8
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
; points at: wD93F
ActorWD93FBand::
Func_030_44E0:: ; address name
    ld a, [wBattleActor]
    ld hl, wD93F
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
; points at: wD980, wD868
RunBattleResolveStep_43C4_Case01_Sub01::
Func_030_4506:: ; address name
    ld hl, wD980
    jr Jump_030_451F

; only called from RunBattleResolveStep_43C4_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_43C4_Case01)
; reads: wBattleActor
; points at: wD868
RunBattleResolveStep_43C4_Case01_Sub02::
Func_030_450B:: ; address name
    call GetActorWDA43Low2
    cp a, $03
    ret z
    ld hl, Data_030_4519
    call ReadBattleWordFromArray_Bank30
    jr Jump_030_451F

Data_030_4519:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $68, $D9, $70, $D9, $78, $D9

Jump_030_451F::
    ld a, [wBattleActor]
    add_a_to_hl
    ld a, [hl]
    srl a
    srl a
    ld hl, wD868
    add a, [hl]
    ld [hl+], a
    ld a, $00
    adc a, [hl]
    ld [hl], a
    ret

; the word wD868 += Data_030_5587[wPersonalityIndex * 4 + (wDA43[actor] & 3)] (E-0120)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_43C4_Case01)
; reads: wPersonalityIndex
; points at: wD868
AddPersonalityWeightToWD868::
Func_030_4536:: ; address name
    ld a, [wPersonalityIndex]
    add a, a
    add a, a
    ld hl, Data_030_5587
    add_a_to_hl
    push hl
    call GetActorWDA43Low2
    pop hl
    add_a_to_hl
    ld a, [hl]
    ld hl, wD868
    add a, [hl]
    ld [hl+], a
    ld a, $00
    adc a, [hl]
    ld [hl], a
    ret

; adds the actor's wD93F word / 16 to the word wD86A (E-0122)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_43C4_Case01)
; reads: wBattleActor, wD86A, wD86B
; writes: wD86A, wD86B
; points at: wD93F
AddActorWD93FDiv16ToWD86A::
Func_030_4558:: ; address name
    ld a, [wBattleActor]
    ld hl, wD93F
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
; reads: wC5E7, wD86A, wD86B
; writes: wD86A, wD86B
AddRandom0To63ToWD86A::
Func_030_4579:: ; address name
    call AdvanceRandom
    ld a, [wC5E7]
    and a, $3F
    ld l, a
    ld h, $00
    jr Jump_030_4586

Jump_030_4586::
    ld a, [wD86A]
    add a, l
    ld [wD86A], a
    ld a, [wD86B]
    adc a, h
    ld [wD86B], a
    ret

; when the actor has no forced action and bit 7 of its wDAD8 byte is set, initialises the AI weights and runs the routine for its AI mode; a forced action is stored directly; then wBattleResolveStep += 1 (E-0124)
; 2 call sites from 1 routine (e.g. RunWC5FDState_E0_Case0D_Case01_Sub01)
; reads: wBattleActor
; writes: wD2CC
; points at: wDAD8, wDA53, wBattleResolveStep
AIChooseActionResolveStep::
Func_030_4595:: ; address name
    call ForcedActionForActorStatus
    jr nz, Jump_030_45C7
    ld a, [wBattleActor]
    ld hl, wDAD8
    add_a_to_hl
    bit 7, [hl]
    jr z, Jump_030_45CB
    call InitAIWeightsForActor
    xor a, a
    ld [wD2CC], a
    ld a, [wBattleActor]
    ld hl, wDA53
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

Data_030_45D0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $46, $49
    dw Func_030_4AD3
    dw Func_030_4AD3
    dw Func_030_4AD3
    dw UseAIScoreTableB

; clears wD2AD ($14 bytes), sets wDA3C-wDA42 = 0, 0, 0, 1, 2, 3, 3, then adds personality, HP and other weights (Func_030_4617, 46BA, 47B9, 483F); wD871 = 0 (E-0124)
; 1 call site from 1 routine (e.g. AIChooseActionResolveStep)
; writes: wDA3C, wDA3D, wDA3E, wDA3F, wDA40, wDA41, wDA42, wD871
; points at: wD2AD
InitAIWeightsForActor::
Func_030_45DA:: ; address name
    ld hl, wD2AD
    ld bc, $0014
    xor a, a
    call FillBytes
    xor a, a
    ld [wDA3C], a
    ld [wDA3D], a
    ld [wDA3E], a
    ld a, $01
    ld [wDA3F], a
    ld a, $02
    ld [wDA40], a
    ld a, $03
    ld [wDA41], a
    ld a, $03
    ld [wDA42], a
    call Func_030_4617
    call AddActorPersonalityTensToWDA3C
    call Func_030_46BA
    call AddRandomPersonalityWeights
    call Func_030_483F
    ld a, $00
    ld [wD871], a
    ret

; 2 call sites from 2 routines (e.g. InitAIWeightsForActor, AIChooseActionForActor_Sub01)
; reads: wC58A, wBattleActor, wC46B, wDAE9
; points at: wDA3C, wDA4B, wDAE9
Func_030_4617::
    ld a, [wC58A]
    or a, a
    jr z, Jump_030_4646
    cp a, $02
    jr nz, Jump_030_4634
    ld a, [wBattleActor]
    cp a, $04
    jr nc, Jump_030_4687
    cp a, $00
    ld a, [wC46B]
    jr z, Jump_030_4650
    ld a, [wDAE9]
    jr Jump_030_4650

Jump_030_4634::
    ld a, [wBattleActor]
    rrca
    rrca
    and a, $01
    ld hl, wDAE9
    add_a_to_hl
    ld a, [hl]
    jr Jump_030_4650

Jump_030_4646::
    ld a, [wBattleActor]
    cp a, $04
    jr nc, Jump_030_4687
    ld a, [wC46B]

Jump_030_4650::
    and a, $03
    cp a, $01
    jr nz, Jump_030_466C
    call GetActorWDA43Low2
    cp a, $03
    jr z, Jump_030_4687
    ld hl, wDA3C
    add_a_to_hl
    ld e, $2D
    call AddSignedEToByteAtHLClamped
    jr Jump_030_4687

Jump_030_466C::
    ld a, [wBattleActor]
    ld hl, wDA4B
    add_a_to_hl
    ld a, [hl]
    and a, $03
    ld hl, wDA3C
    add_a_to_hl
    ld e, $14
    call AddSignedEToByteAtHLClamped

Jump_030_4687::
    ret

; for the actor's three personality bytes (Hi, Mid, Lo) adds value / 10 to wDA3C + 0, 1, 2 (Func_030_5428) (E-0122)
; 2 call sites from 2 routines (e.g. InitAIWeightsForActor, AIChooseActionForActor_Sub01)
; reads: wBattleActor
; points at: wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo, wDA3C
AddActorPersonalityTensToWDA3C::
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
; 2 call sites from 1 routine (e.g. AddActorPersonalityTensToWDA3C)
; reads: wBattleActor
; points at: wDA3C
AddActorPersonalityTensForIndexA::
Func_030_469D:: ; address name
    push af
    ld a, [wBattleActor]
    add_a_to_hl
    ld b, [hl]
    ld a, $0A
    call DivideBByA
    pop af
    ld hl, wDA3C
    add_a_to_hl
    ld e, b
    call AddSignedEToByteAtHLClamped
    ret

; 2 call sites from 2 routines (e.g. InitAIWeightsForActor, AIChooseActionForActor_Sub01)
; reads: wBattleActor, wC58A, wC46B, wDAE9, wD891
; points at: wD80D, wDA3C, wDA53, wDA3E, wD989, wDAE9
Func_030_46BA::
    ld a, [wBattleActor]
    ld hl, wD80D
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
    ld a, [wC58A]
    or a, a
    jr z, Jump_030_46FA
    cp a, $02
    jr nz, Jump_030_46E8
    ld a, [wBattleActor]
    cp a, $00
    ld a, [wC46B]
    jr z, Jump_030_46FD
    ld a, [wDAE9]
    jr Jump_030_46FD

Jump_030_46E8::
    ld a, [wBattleActor]
    rrca
    rrca
    and a, $01
    ld hl, wDAE9
    add_a_to_hl
    ld a, [hl]
    jr Jump_030_46FD

Jump_030_46FA::
    ld a, [wC46B]

Jump_030_46FD::
    and a, $03
    cp a, $01
    jr z, Jump_030_470B
    ld hl, wDA3C
    ld e, $1E
    call AddSignedEToByteAtHLClamped

Jump_030_470B::
    call AnyAllyHPBelowSixthOfMax
    jr z, Jump_030_4768
    ld a, [wBattleActor]
    ld hl, wDA53
    add_a_to_hl
    ld a, [hl]
    cp a, $04
    jr z, Jump_030_4726
    cp a, $03
    jr z, Jump_030_4726
    jr Jump_030_4768

Jump_030_4726::
    ld a, [wBattleActor]
    ld hl, wD989
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
    call GetActorWDA43Low2
    cp a, $03
    jr z, Jump_030_4768
    ld hl, wDA3E
    ld e, $1E
    call AddSignedEToByteAtHLClamped

Jump_030_4768::
    ld a, [wD891]
    or a, a
    jr nz, Jump_030_478A
    ld a, [wBattleActor]
    cp a, $04
    jr nc, Jump_030_478A
    ld a, [wC58A]
    or a, a
    jr nz, Jump_030_478A
    ld a, [wC46B]
    and a, $01
    jr nz, Jump_030_478A
    ld hl, wDA3E
    ld e, $E2
    call AddSignedEToByteAtHLClamped

Jump_030_478A::
    ret

; A = 1 and NZ when an occupied ally has HP below a sixth of its max; otherwise returns with the last comparison flags (E-0124)
; 1 call site from 1 routine (e.g. Func_030_46BA)
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
    call CarryUnlessWDA63SlotEmpty
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
; reads: wC58A, wBattleActor, wC5E7
; points at: wDA3C, wSlotPersonalityHi, wSlotPersonalityMid, wDA3D, wSlotPersonalityLo, wDA3E
AddRandomPersonalityWeights::
Func_030_47B9:: ; address name
    ld a, [wC58A]
    or a, a
    jr z, Jump_030_47E6
    cp a, $02
    jr nz, Jump_030_47CA
    ld a, [wBattleActor]
    cp a, $04
    jr c, Jump_030_47E6

Jump_030_47CA::
    call GetActorWDA43Low2
    cp a, $03
    ret z
    ld hl, wDA3C
    ld b, $03

Jump_030_47D5::
    call AdvanceRandom
    ld a, [wC5E7]
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
    ld de, wDA3C
    call AddRandomWeightByValueBand
    ld a, [wBattleActor]
    ld hl, wSlotPersonalityMid
    ld de, wDA3D
    call AddRandomWeightByValueBand
    ld a, [wBattleActor]
    ld hl, wSlotPersonalityLo
    ld de, wDA3E

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

; 2 call sites from 2 routines (e.g. InitAIWeightsForActor, AIChooseActionForActor_Sub01)
; reads: wC5E7, wC5E8, wDA3F, wDA40, wDA41, wDA3C, wBattleActor
; writes: wDA3F, wDA40, wDA41
; points at: wDA3C, wD988, wD2AD, wD2BD
Func_030_483F::
    ld a, [wC5E7]
    ld c, a
    ld a, [wC5E8]
    ld b, a
    ld hl, wDA3C
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
    ld a, [wDA3F]
    push af
    ld a, [wDA40]
    ld [wDA3F], a
    pop af
    ld [wDA40], a

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
    ld a, [wDA40]
    push af
    ld a, [wDA41]
    ld [wDA40], a
    pop af
    ld [wDA41], a

Jump_030_4886::
    dec hl
    ld a, [wDA3C]
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
    ld a, [wDA3F]
    push af
    ld a, [wDA40]
    ld [wDA3F], a
    pop af
    ld [wDA40], a

Jump_030_48A7::
    ld a, [wDA3F]
    ld d, a
    ld e, $32
    call AddWeightsForSkillD
    ld a, [wDA40]
    ld d, a
    ld e, $19

; for each of the actor's skills equal to D adds weight through Func_030_48F3 to wD2AD[index]; for D other than 2 also to wD2BD[D - 1] (E-0125)
; 1 call site from 1 routine (e.g. Func_030_483F)
; reads: wBattleActor
; points at: wD988, wD2AD, wD2BD
AddWeightsForSkillD::
Func_030_48B6:: ; address name
    ld bc, $0800
    ld hl, wD988
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
    ld hl, wD2AD
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
    ld hl, wD2BD
    add_a_to_hl
    call AddWeightsForSkillD_Sub01

Jump_030_48F2::
    ret

; only called from AddWeightsForSkillD (E-0047)
; 2 call sites from 1 routine (e.g. AddWeightsForSkillD)
; reads: wC58A, wBattleActor, wC46B, wDAE9
; points at: wDAE9
AddWeightsForSkillD_Sub01::
Func_030_48F3:: ; address name
    push de
    push hl
    ld a, [wC58A]
    or a, a
    jr z, Jump_030_4920
    cp a, $01
    jr z, Jump_030_490E
    ld a, [wBattleActor]
    cp a, $00
    ld a, [wC46B]
    jr z, Jump_030_4923
    ld a, [wDAE9]
    jr Jump_030_4923

Jump_030_490E::
    ld a, [wBattleActor]
    rrca
    rrca
    and a, $01
    ld hl, wDAE9
    add_a_to_hl
    ld a, [hl]
    jr Jump_030_4923

Jump_030_4920::
    ld a, [wC46B]

Jump_030_4923::
    and a, $03
    cp a, $01
    jr z, Jump_030_492F
    and a, $01
    jr z, Jump_030_493A
    jr Jump_030_493C

Jump_030_492F::
    call GetActorWDA43Low2
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
; reads: wBattleActor, wC58A, wDA42, wD871
; points at: wDA3C, wDA42
AIRunNextChoice:: ; heuristic: follows a terminator; C0
Func_030_4946:: ; address name
    ld a, [wBattleActor]
    and a, $03
    cp a, $03
    jr z, Jump_030_496E
    ld a, [wC58A]
    or a, a
    jr z, Jump_030_4959
    cp a, $02
    jr nz, Jump_030_4960

Jump_030_4959::
    ld a, [wBattleActor]
    cp a, $04
    jr nc, Jump_030_496E

Jump_030_4960::
    call GetActorWDA43Low2
    cp a, $03
    jr nz, Jump_030_496E

Jump_030_4967::
    ld b, $00
    call ActorActionChoiceAddress
    ld [hl], b
    ret

Jump_030_496E::
    ld a, [wDA42]
    cp a, $06
    jr nc, Jump_030_4967
    ld hl, wDA3C
    add_a_to_hl
    ld a, [hl]
    ld hl, Data_030_4998
    dec a
    call ReadBattleWordFromArray_Bank30
    call JumpToHL
    call ActorActionChoiceAddress
    ld b, [hl]
    ld a, [wD871]
    cp a, $FF
    ret z
    ld hl, wDA42
    inc [hl]
    jr AIRunNextChoice

Data_030_4998:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0C0998, $12E

; wDA6B/wDA6C = AIScoreRoutineTableB, then continues with the scoring loop (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wC58A, wDA3F
; writes: wDA6B, wDA6C
; points at: wD988, wD2AD
UseAIScoreTableB:: ; heuristic: target of a pointer table; C0
Func_030_4AC6:: ; address name
    ld hl, AIScoreRoutineTableB
    ld a, l
    ld [wDA6B], a
    ld a, h
    ld [wDA6C], a
    jr Jump_030_4ADE

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wC58A, wDA3F
; writes: wDA6B, wDA6C
; points at: wD988, wD2AD
Func_030_4AD3:: ; heuristic: target of a pointer table; C0
    ld hl, AIScoreRoutineTableA
    ld a, l
    ld [wDA6B], a
    ld a, h
    ld [wDA6C], a

Jump_030_4ADE::
    ld a, [wBattleActor]
    and a, $03
    cp a, $03
    jr z, Jump_030_4B06
    ld a, [wC58A]
    or a, a
    jr z, Jump_030_4AF1
    cp a, $02
    jr nz, Jump_030_4AF8

Jump_030_4AF1::
    ld a, [wBattleActor]
    cp a, $04
    jr nc, Jump_030_4B06

Jump_030_4AF8::
    call GetActorWDA43Low2
    cp a, $03
    jr nz, Jump_030_4B06
    ld b, $00
    call ActorActionChoiceAddress
    ld [hl], b
    ret

Jump_030_4B06::
    call EstimateDamageVsEachFoeToWD2C1
    ld a, [wBattleActor]
    ld hl, wD988
    swap a
    add_a_to_hl
    ld de, wD2AD
    ld b, $08

Jump_030_4B1B::
    push bc
    push hl
    push de
    inc hl
    call ScoreSkillAtHLForAI
    pop de
    pop hl
    ld a, [wDA3F]
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
    ld a, [wDA3F]
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
    ld a, [wC58A]
    or a, a
    jr z, Jump_030_4B5E
    cp a, $02
    jr nz, Jump_030_4B65

Jump_030_4B5E::
    ld a, [wBattleActor]
    cp a, $04
    jr nc, Jump_030_4B6F

Jump_030_4B65::
    ld a, [wDA3F]
    cp a, $03
    call z, DoubleWordAtDEUnlessBit15
    jr Jump_030_4B72

Jump_030_4B6F::
    call QuarterWordAtDEUnlessBit15

Jump_030_4B72::
    call Func_030_4C00
    ret

; doubles the word at DE unless its bit 15 is already set (E-0122)
; 3 call sites from 1 routine (e.g. Func_030_4AD3)
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
; 1 call site from 1 routine (e.g. Func_030_4AD3)
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
; 1 call site from 1 routine (e.g. Func_030_4AD3)
; reads: wCFF1, wDA6B, wDA6C, wDA6E, wDA6F, wDA70, wDA71
; writes: wDA6E, wDA6F, wDA70, wDA71
ScoreSkillAtHLForAI::
Func_030_4B9F:: ; address name
    ld a, [hl]

; A = skill number ($FF skips): AddSkillBaseWeightAndLoadSkill; when wCFF1 bit 0 (in the skill record) is set, clears wDA6E-wDA71 and far-calls the skill's AI scoring routine from the table in wDA6B/wDA6C (AIScoreRoutineTableA or B), then folds the accumulated weights into the word at DE (the rest is not fully read) (E-0083)
; 2 call sites from 1 routine (e.g. Func_030_4AD3)
; reads: wCFF1, wDA6B, wDA6C, wDA6E, wDA6F, wDA70, wDA71
; writes: wDA6E, wDA6F, wDA70, wDA71
ScoreSkillForAI::
Func_030_4BA0:: ; address name
    push de
    cp a, $FF
    jr z, Jump_030_4BFA
    call AddSkillBaseWeightAndLoadSkill
    ld e, a
    ld d, $00
    ld a, [wCFF1]
    bit 0, a
    jr z, Jump_030_4BFA
    ld a, [wDA6B]
    ld l, a
    ld a, [wDA6C]
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
    ld [wDA6E], a
    ld [wDA6F], a
    ld [wDA70], a
    ld [wDA71], a
    rst $10
    ld a, [wDA6E]
    ld c, a
    ld a, [wDA6F]
    ld b, a
    ld a, [wDA70]
    ld l, a
    ld a, [wDA71]
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

; 1 call site from 1 routine (e.g. Func_030_4AD3)
; reads: wC5E7, wBattleActor, hFFC6
; writes: hFFC6
; points at: wD2AD, wD989
Func_030_4C00::
    xor a, a
    ldh [hFFC6], a
    ld hl, $0000
    ld de, $0A00

Jump_030_4C09::
    ld a, e
    push hl
    ld hl, wD2AD
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
    ld a, [wC5E7]
    bit 0, a
    jr z, Jump_030_4C34

Jump_030_4C2F::
    ld h, b
    ld l, c
    ld a, e
    ldh [hFFC6], a

Jump_030_4C34::
    inc e
    dec d
    jr nz, Jump_030_4C09
    ld a, [wBattleActor]
    swap a
    ld hl, wD989
    add_a_to_hl
    ldh a, [hFFC6]
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
; 1 call site from 1 routine (e.g. Func_030_4AD3)
; reads: wBattleActor
; points at: wD2C1
EstimateDamageVsEachFoeToWD2C1::
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
    call CarryUnlessWDA63SlotEmpty
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
    ld hl, wD2C1
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
; writes: wRecordBuffer, wCFED
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
    ld [wCFED], a
    farcall LoadSkillRecord
    pop af
    pop de
    ret

; only called from AddSkillBaseWeightAndLoadSkill (E-0047)
; 1 call site from 1 routine (e.g. AddSkillBaseWeightAndLoadSkill)
; reads: wC5E7
AddSkillBaseWeightAndLoadSkill_Sub01::
Func_030_4CDB:: ; address name
    push af
    dec de
    call AdvanceRandom
    ld a, [wC5E7]
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
; reads: wC58A, wBattleActor
RunActorActionHandlersForAISlots::
Func_030_4CFC:: ; address name
    ld a, [wC58A]
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
    dw RollWD980HighFlag40
    dw RollWD980LowFlag80
    db $C6, $4F, $C6, $4F, $C6, $4F, $C6, $4F, $C6, $4F, $C6, $4F, $C6, $4F, $C6, $4F

; AI trait roll with mask DE = $01: when the actor's value is at least $80 rolls a chance that grows with its distance from $80 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wC5E7, wBattleActor
; points at: wSlotPersonalityHi, wD854
RollPersonalityHiHighFlag01:: ; heuristic: target of a pointer table; C0
Func_030_4F86:: ; address name
    ld hl, wSlotPersonalityHi
    ld de, $0001
    jr Jump_030_4FC8

; AI trait roll with mask DE = $02: when the actor's value is below $80 rolls a chance that grows with its distance from $80 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wC5E7, wBattleActor
; points at: wSlotPersonalityHi, wD854
RollPersonalityHiLowFlag02:: ; heuristic: target of a pointer table; C0
Func_030_4F8E:: ; address name
    ld hl, wSlotPersonalityHi
    ld de, $0002
    jr Jump_030_4FE9

; AI trait roll with mask DE = $04: when the actor's value is at least $80 rolls a chance that grows with its distance from $80 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wC5E7, wBattleActor
; points at: wSlotPersonalityMid, wD854
RollPersonalityMidHighFlag04:: ; heuristic: target of a pointer table; C0
Func_030_4F96:: ; address name
    ld hl, wSlotPersonalityMid
    ld de, $0004
    jr Jump_030_4FC8

; AI trait roll with mask DE = $08: when the actor's value is below $80 rolls a chance that grows with its distance from $80 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wC5E7, wBattleActor
; points at: wSlotPersonalityMid, wD854
RollPersonalityMidLowFlag08:: ; heuristic: target of a pointer table; C0
Func_030_4F9E:: ; address name
    ld hl, wSlotPersonalityMid
    ld de, $0008
    jr Jump_030_4FE9

; AI trait roll with mask DE = $10: when the actor's value is at least $80 rolls a chance that grows with its distance from $80 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wC5E7, wBattleActor
; points at: wSlotPersonalityLo, wD854
RollPersonalityLoHighFlag10:: ; heuristic: target of a pointer table; C0
Func_030_4FA6:: ; address name
    ld hl, wSlotPersonalityLo
    ld de, $0010
    jr Jump_030_4FC8

; AI trait roll with mask DE = $20: when the actor's value is below $80 rolls a chance that grows with its distance from $80 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wC5E7, wBattleActor
; points at: wSlotPersonalityLo, wD854
RollPersonalityLoLowFlag20:: ; heuristic: target of a pointer table; C0
Func_030_4FAE:: ; address name
    ld hl, wSlotPersonalityLo
    ld de, $0020
    jr Jump_030_4FE9

; AI trait roll with mask DE = $40: when the actor's value is at least $80 rolls a chance that grows with its distance from $80 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wC5E7, wBattleActor
; points at: wD980, wD854
RollWD980HighFlag40:: ; heuristic: target of a pointer table; C0
Func_030_4FB6:: ; address name
    ld hl, wD980
    ld de, $0040
    jr Jump_030_4FC8

; AI trait roll with mask DE = $80: when the actor's wD980 value is below $80 rolls a chance that grows with its distance from $80 (E-0125)
; no direct call (reached through a table, a jump or a vector)
; reads: wC5E7, wBattleActor
; points at: wD980, wD854
RollWD980LowFlag80:: ; heuristic: target of a pointer table; C0
Func_030_4FBE:: ; address name
    ld hl, wD980
    ld de, $0080
    jr Jump_030_4FE9
    db $AF, $C9

Jump_030_4FC8::
    call AdvanceRandom
    ld a, [wC5E7]
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
    ld a, [wC5E7]
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
    ld hl, wD854
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
; reads: wBattleActor, wC0A0, wC0A8
; points at: wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo, wC0A0
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
    ld hl, wC0A0
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
    ld a, [wC0A0]
    cp a, $FF
    jr z, Jump_030_50A6

Jump_030_507E::
    call FilterSkillListByMP
    ld a, [wC0A8]
    cp a, $FF
    jr z, Jump_030_50A6
    call RunBattleResolveStep_43C4_Case01_Sub03_Sub02
    ld a, [wC0A0]
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
; reads: wBattleActor, wCFF1
; writes: wRecordBuffer, wD868, wCFED, wD869, wD86A, wD86B
; points at: wD989, wCFF1, wC0A0
RunBattleResolveStep_43C4_Case01_Sub03_Sub01::
Func_030_50D2:: ; address name
    ld a, [wBattleActor]
    swap a
    ld hl, wD989
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
    ld [wD868], a
    xor a, a
    ld [wCFED], a
    ld a, $01
    ld [wD869], a
    ld hl, wCFF1
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    farcall LoadSkillRecordPart
    ld a, [wCFF1]
    and a, $03
    cp a, $02
    pop bc
    pop hl
    jr z, Jump_030_5123
    ld a, c
    ld de, wC0A0
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
; writes: wRecordBuffer, wD868, wCFED, wD869, wD86A, wD86B
; points at: wBattleMP, wC0A0, wRecordBufferData, wC0A8
FilterSkillListByMP::
Func_030_5129:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleMP
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld hl, wC0A0
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
    ld [wD868], a
    xor a, a
    ld [wCFED], a
    ld a, $01
    ld [wD869], a
    ld hl, wRecordBufferData
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    farcall LoadSkillRecordPart
    pop de
    pop bc
    ld a, [wRecordBufferData]
    ld l, a
    ld h, $00
    call CompareHLToBC
    jr c, Jump_030_5181
    ld a, d
    ld hl, wC0A0
    add_a_to_hl
    ld [hl], $FF

Jump_030_5181::
    inc d
    pop hl
    inc hl
    dec e
    jr nz, Jump_030_513F

Jump_030_5187::
    ld hl, wC0A8
    ld bc, $0008
    ld a, $FF
    call FillBytes
    ld hl, wC0A0
    ld de, wC0A8
    jr Jump_030_51CD

; only called from RunBattleResolveStep_43C4_Case01_Sub03 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_43C4_Case01_Sub03)
; points at: wC0A8, wC0A0
RunBattleResolveStep_43C4_Case01_Sub03_Sub02::
Func_030_519A:: ; address name
    ld hl, wC0A8
    ld b, $08
    ld c, $00

Jump_030_51A1::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_030_51BC
    call RunBattleResolveStep_43C4_Case01_Sub03_Sub02_Sub01
    jr c, Jump_030_51B7
    ld a, c
    ld de, wC0A8
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
    ld hl, wC0A0
    ld bc, $0008
    ld a, $FF
    call FillBytes
    ld hl, wC0A8
    ld de, wC0A0

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
; reads: wC0A0, wRecordBufferData
; writes: wRecordBuffer, wD868, wCFED, wD869, wD86A, wD86B
; points at: wRecordBufferData, wC0A1, wC0A0
RunBattleResolveStep_43C4_Case01_Sub03_Sub03::
Func_030_5209:: ; address name
    ld a, [wC0A0]
    ld [wRecordBuffer], a
    ld a, $00
    ld [wD868], a
    xor a, a
    ld [wCFED], a
    ld a, $01
    ld [wD869], a
    ld hl, wRecordBufferData
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    farcall LoadSkillRecordPart
    ld a, [wRecordBufferData]
    ld c, a
    ld b, $00
    ld hl, wC0A1
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
    ld [wD868], a
    xor a, a
    ld [wCFED], a
    ld a, $01
    ld [wD869], a
    ld hl, wRecordBufferData
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
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
    ld hl, wC0A0
    add_a_to_hl
    ld c, [hl]
    ret

; B = forced action $CD, $CC, $CE or $CF by the actor's status bits (wD80F byte 0 bit 6, byte 1 bit 2, byte 2 bit 4, byte 5 bit 0); Z when none (E-0124)
; 2 call sites from 2 routines (e.g. AIChooseActionResolveStep, RunBattleResolveStep_43C4_Case00)
; reads: wBattleActor
; points at: wD80F
ForcedActionForActorStatus::
Func_030_5287:: ; address name
    ld a, [wBattleActor]
    ld hl, wD80F
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
; reads: wC58A, wBattleActor
; writes: hFFC6, hFFC7, hFFC8, hFFC9
; points at: wD8B7, wD980
RunBattleResolveStep_43C4_Case01_Sub04::
Func_030_52B5:: ; address name
    ld a, [wC58A]
    or a, a
    ret nz
    ld a, [wBattleActor]
    cp a, $03
    ret nc
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a
    ld bc, $0000
    ld a, [wBattleActor]
    ld hl, wD8B7
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
    ld hl, wD980
    add_a_to_hl
    ld a, [hl]
    cp a, $97
    jr c, Jump_030_5307
    ld e, $10

Jump_030_5307::
    call GetActorWDA43Low2
    ld hl, Data_030_5384
    call ReadBattleWordFromArray_Bank30
    add hl, de
    add hl, bc
    call CopyFourBytesNegatedByActorWDA43
    call RunBattleResolveStep_43C4_Case01_Sub04_Sub01
    ret

; copies four bytes from HL to hFFC6, negating each when bit 6 of the actor's wDA43 byte is set (CopyByteNegateIfCBit6) (E-0122)
; 1 call site from 1 routine (e.g. RunBattleResolveStep_43C4_Case01_Sub04)
; points at: hFFC6
CopyFourBytesNegatedByActorWDA43::
Func_030_5319:: ; address name
    push hl
    call GetActorWDA43Low2
    ld c, [hl]
    pop hl
    ld de, hFFC6
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
; 4 call sites from 1 routine (e.g. CopyFourBytesNegatedByActorWDA43)
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
; reads: wDAE8, hFFC6, hFFC7, hFFC8, hFFC9, wBattleActor
; points at: hFFC6, wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo, wD980
RunBattleResolveStep_43C4_Case01_Sub04_Sub01::
Func_030_533E:: ; address name
    ld a, [wDAE8]
    ld c, a
    ld b, $00
    ld hl, hFFC6
    add hl, bc
    ld e, [hl]
    push hl
    call GetActorWDA43Low2
    bit 6, [hl]
    pop hl
    jr z, Jump_030_5357
    ld a, e
    cpl
    inc a
    ld e, a
    ld [hl], e

Jump_030_5357::
    ldh a, [hFFC6]
    ld e, a
    ld hl, wSlotPersonalityHi
    call Func5428ForActorEntryOfHL
    ldh a, [hFFC7]
    ld e, a
    ld hl, wSlotPersonalityMid
    call Func5428ForActorEntryOfHL
    ldh a, [hFFC8]
    ld e, a
    ld hl, wSlotPersonalityLo
    call Func5428ForActorEntryOfHL
    ldh a, [hFFC9]
    ld e, a
    ld hl, wD980

; HL += actor, then Func_030_5428 (E-0122)
; 3 call sites from 1 routine (e.g. RunBattleResolveStep_43C4_Case01_Sub04_Sub01)
; reads: wBattleActor
Func5428ForActorEntryOfHL::
Func_030_5378:: ; address name
    ld a, [wBattleActor]
    add_a_to_hl
    call AddSignedEToByteAtHLClamped
    ret

Data_030_5384:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0C1384, $88

; A = wDA43[wBattleActor] & 3 (E-0072)
; 13 call sites from 12 routines (e.g. AddWeightsForSkillD_Sub01, AddRandomPersonalityWeights, Func_030_46BA, Func_030_4617, ...)
; reads: wBattleActor
; points at: wDA43
GetActorWDA43Low2::
Func_030_540C:: ; address name
    ld a, [wBattleActor]
    ld hl, wDA43
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
; 9 call sites from 6 routines (e.g. AddRandomPersonalityWeights, AddRandomWeightByValueBand, Func_030_46BA, AddActorPersonalityTensForIndexA, ...)
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
; 3 call sites from 2 routines (e.g. Func_032_4ADC_Case01_Case00, RunWC5FDState_E0_Case0D_Case05_Sub01)
; reads: wBattleActor
; writes: wPersonalityIndex, wD2CC
; points at: wDA53
AIChooseActionForActor::
Func_030_5440:: ; address name
    ld a, [wBattleActor]
    call PersonalityIndexOfSlot_Bank30
    ld [wPersonalityIndex], a
    call AIChooseActionForActor_Sub01
    ld a, $01
    ld [wD2CC], a
    ld a, [wBattleActor]
    ld hl, wDA53
    add_a_to_hl
    ld a, [hl]
    ld hl, Data_030_45D0
    call ReadBattleWordFromArray_Bank30
    call JumpToHL
    call ActorActionChoiceAddress
    ld [hl], b
    call RunActorActionHandlersForAISlots
    xor a, a
    ld [wD2CC], a
    ret

; only called from AIChooseActionForActor (E-0047)
; 1 call site from 1 routine (e.g. AIChooseActionForActor)
; writes: wDA3C, wDA3D, wDA3E, wDA3F, wDA40, wDA41, wDA42, wD871
; points at: wD2AD
AIChooseActionForActor_Sub01::
Func_030_5472:: ; address name
    ld hl, wD2AD
    ld bc, $0014
    xor a, a
    call FillBytes
    xor a, a
    ld [wDA3C], a
    ld [wDA3D], a
    ld [wDA3E], a
    ld a, $01
    ld [wDA3F], a
    ld a, $02
    ld [wDA40], a
    ld a, $03
    ld [wDA41], a
    ld a, $03
    ld [wDA42], a
    call AIChooseActionForActor_Sub01_Sub01
    call Func_030_4617
    call AddActorPersonalityTensToWDA3C
    call Func_030_46BA
    call AIChooseActionForActor_Sub01_Sub02
    call AddRandomPersonalityWeights
    call Func_030_483F
    ld a, $00
    ld [wD871], a
    ret

; only called from AIChooseActionForActor_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. AIChooseActionForActor_Sub01)
; reads: wCFF1
; points at: wDA3E, wDA3D, wDA3C
AIChooseActionForActor_Sub01_Sub01::
Func_030_54B5:: ; address name
    ld a, [wCFF1]
    and a, $F0
    cp a, $10
    jr z, Jump_030_54C8
    cp a, $20
    jr z, Jump_030_54CD
    cp a, $30
    jr z, Jump_030_54D2
    jr Jump_030_54D9

Jump_030_54C8::
    ld hl, wDA3C
    jr Jump_030_54D5

Jump_030_54CD::
    ld hl, wDA3D
    jr Jump_030_54D5

Jump_030_54D2::
    ld hl, wDA3E

Jump_030_54D5::
    ld a, [hl]
    add a, $0A
    ld [hl], a

Jump_030_54D9::
    ret

; only called from AIChooseActionForActor_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. AIChooseActionForActor_Sub01)
; reads: wBattleActor, wDA3E, wDA3C
; writes: wDA3E, wDA3C
; points at: wD2C8, wBattleHP
AIChooseActionForActor_Sub01_Sub02::
Func_030_54DA:: ; address name
    ld a, [wBattleActor]
    rrca
    and a, $02
    xor a, $02
    ld hl, wD2C8
    add_a_to_hl
    deref_hl
    push hl
    ld a, [wBattleActor]
    rrca
    and a, $02
    ld hl, wD2C8
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
    ld a, [wDA3E]
    add a, $14
    ld [wDA3E], a

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
    ld a, [wDA3C]
    add a, $14
    ld [wDA3C], a

Jump_030_556B::
    ret

; advances the random seed; when wC5F8 is set and the random value is below wC5FA, stores wC5F9 as the actor's action choice (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wC5F8, wC5FA, wC5E7, wC5F9
MaybeOverrideActorActionWithWC5F9:: ; heuristic: follows a terminator; C0
Func_030_556C:: ; address name
    call AdvanceRandom
    call ActorActionChoiceAddress
    ld a, [wC5F8]
    or a, a
    jr z, Jump_030_5586
    ld a, [wC5FA]
    ld b, a
    ld a, [wC5E7]
    cp a, b
    jr nc, Jump_030_5586
    ld a, [wC5F9]
    ld [hl], a

Jump_030_5586::
    ret

Data_030_5587:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0C1587, $1AF
    ds $11, $00
    db $50, $00, $00, $00, $50, $00, $5A, $00, $3C
    ds $33, $00
    db $64, $00

; 201 three-byte far pointers (address, bank $E2) indexed by skill number: the AI scoring routine for each skill, called by Func_030_4BA0 with wDA6E-wDA71 cleared (E-0083)
AIScoreRoutineTableA:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_030_5785:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0C1785, $189
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

; a second copy of AIScoreRoutineTableA (all 201 entries equal), selected by Func_030_4AC6 instead of Func_030_4AD3 (E-0083)
AIScoreRoutineTableB:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_030_59E0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0C19E0, $189
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
; 1 call site from 1 routine (e.g. EstimateDamageVsEachFoeToWD2C1)
; points at: wBattleATK
ReadBattleATKOfSlot_Bank30::
Func_030_5C3B:: ; address name
    ld hl, wBattleATK
    jr ReadBattleWordFromArray_Bank30

; HL = wBattleDEF, then ReadBattleWordFromArray_Bank30 (E-0122)
; 1 call site from 1 routine (e.g. EstimateDamageVsEachFoeToWD2C1)
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
; reads: wC58A, wC57F, wBattleActor
ActorOnLocalSide_Bank30:: ; heuristic: follows a terminator; C0
Func_030_5C79:: ; address name
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_030_5C8E
    ld a, [wC57F]
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
; reads: wC58A, wC57F, wBattleTarget
TargetOnLocalSide_Bank30:: ; heuristic: follows a terminator; C0
Func_030_5C94:: ; address name
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_030_5CA9
    ld a, [wC57F]
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
; points at: wD80F
CheckSlotStatusBlockWide_Bank30:: ; heuristic: follows a terminator; C0
Func_030_5D49:: ; address name
    call CheckSlotStatusBlock
    ret c
    push hl
    push bc
    ld c, a
    ld hl, wD80F
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
; points at: wD80F
SlotHasStatus3Or4Bits_Bank30:: ; heuristic: follows a terminator; C0
Func_030_5D68:: ; address name
    push hl
    ld hl, wD80F
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
