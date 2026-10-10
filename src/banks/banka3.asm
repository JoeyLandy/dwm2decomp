SECTION "Bank A3", ROMX[$4000], BANK[$A3]
    db $A3

; A = battle slot: HL = the word for that slot at wBattleATK; A = its low byte (E-0064)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleATK
GetBattleATK_BankA3:: ; heuristic: follows a terminator; C0
Func_0A3_4001:: ; address name
    ld hl, wBattleATK
    jr Jump_0A3_402E
    db $21, $0F, $D9, $18, $23, $21, $CF, $D8, $18, $1E, $21, $EF, $D8, $18, $19, $21
    db $BF, $D8, $18, $14, $21, $DF, $D8, $18, $0F, $21, $1F, $D9, $18, $0A, $21, $53
    db $DA, $85, $6F, $30, $01, $24, $7E, $C9

Jump_0A3_402E::
    add a, a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes appear in 10 banks)
; no direct call (reached through a table, a jump or a vector)
AddDoubleAToHL_BankA3:: ; heuristic: follows a terminator; C0
Func_0A3_4038:: ; address name
    add a, a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the reversal, not checked (E-0064) (the same 27 bytes appear in 10 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wC57F, wBattleActor
ActorOnLocalSide_BankA3:: ; heuristic: follows a terminator; C0
Func_0A3_403F:: ; address name
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_0A3_4054
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_0A3_4054
    ld a, [wBattleActor]
    cp a, $04
    ccf
    ret

Jump_0A3_4054::
    ld a, [wBattleActor]
    cp a, $04
    ret

; carry set when wBattleTarget < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleTarget >= 4) (E-0064) (the same 27 bytes appear in 10 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wC57F, wBattleTarget
TargetOnLocalSide_BankA3:: ; heuristic: follows a terminator; C0
Func_0A3_405A:: ; address name
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_0A3_406F
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_0A3_406F
    ld a, [wBattleTarget]
    cp a, $04
    ccf
    ret

Jump_0A3_406F::
    ld a, [wBattleTarget]
    cp a, $04
    ret
    INCBIN "dwm2-cobi-us.gbc", $28C075, $CA

; runs Func_0A3_414F, then wDA5B[hFFC6] = 3 (E-0122)
; 21 call sites from 20 routines (e.g. Func_032_4F0A, SetSubPhase2AndRestartResolve, ActionEffect_ActionD0, ActionEffect_ActionD1, ...)
; reads: hFFC6
; points at: wDA5B
RunA3414FAndMarkWDA5B3::
Func_0A3_413F:: ; address name
    call ActorFormationSlotToHFFC6
    ldh a, [hFFC6]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $03
    ret

; hFFC6 = the slot for the actor through its side's wC953 formation (Data_0A3_4181), $FF when none (E-0124)
; 16 call sites from 13 routines (e.g. RunA3414FAndMarkWDA5B3, Func_032_4F0A, Func_032_514C, Func_032_5397, ...)
; reads: wBattleActor
; writes: hFFC6
; points at: wC953
ActorFormationSlotToHFFC6::
Func_0A3_414F:: ; address name
    push bc
    ld a, [wBattleActor]
    and a, $03
    ld c, a
    ld a, [wBattleActor]
    and a, $04
    ld b, a
    sra a
    sra a
    ld hl, wC953
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_0A3_417D
    sla a
    ld hl, Data_0A3_4181
    add_a_to_hl
    ld a, [hl+]
    cp a, c
    jr nz, Jump_0A3_417C
    ld a, [hl]

Jump_0A3_417C::
    add a, b

Jump_0A3_417D::
    ldh [hFFC6], a
    pop bc
    ret

Data_0A3_4181:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $00, $02, $01, $02

; copies 16 bytes of wBattleActionChoice to wDA2C, clears wC953/4, and outside link battles sets the formation for each side from Func_0A3_41CF and Func_0A3_4917 (E-0125)
; 2 call sites from 2 routines (e.g. RunBattleCommandEntry_Case06, RunBattleCommandEntry_BankA1_Case06)
; reads: wC58A
; writes: wC953, wC954
; points at: wBattleActionChoice, wDA2C, wDA24
SaveActionChoicesAndPickFormations::
Func_0A3_4187:: ; address name
    ld b, $10
    ld hl, wBattleActionChoice
    ld de, wDA2C

Jump_0A3_418F::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_0A3_418F
    ld a, $FF
    ld [wC953], a
    ld [wC954], a
    ld a, [wC58A]
    cp a, $01
    ret z
    ld de, wBattleActionChoice
    call SaveActionChoicesAndPickFormations_Sub01
    or a, a
    jr z, Jump_0A3_41B5
    ld de, wBattleActionChoice
    call SaveActionChoicesAndPickFormations_Sub02
    ld [wC953], a

Jump_0A3_41B5::
    ld a, [wC58A]
    or a, a
    ret z
    cp a, $02
    ret z
    ld de, wDA24
    call SaveActionChoicesAndPickFormations_Sub01
    or a, a
    ret z
    ld de, wDA24
    call SaveActionChoicesAndPickFormations_Sub02
    ld [wC954], a
    ret

; only called from SaveActionChoicesAndPickFormations (E-0047)
; 2 call sites from 1 routine (e.g. SaveActionChoicesAndPickFormations)
; reads: wBattleActor, hFFC6, wC58A
; writes: hFFC6
SaveActionChoicesAndPickFormations_Sub01::
Func_0A3_41CF:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ldh [hFFC6], a
    ld b, $00
    ld hl, Data_0A3_4289

Jump_0A3_41DB::
    push hl
    ld a, [hl]
    or a, a
    jr nz, Jump_0A3_41E4

Jump_0A3_41E0::
    pop hl
    ld a, $00
    ret

Jump_0A3_41E4::
    push de
    ld a, [hl]
    cp a, $FF
    jr z, Jump_0A3_41FD
    ld c, a
    ld a, [de]
    cp a, c
    jr nz, Jump_0A3_4257
    ldh a, [hFFC6]
    call CheckSlotStatusBlock
    jr c, Jump_0A3_4257
    ldh a, [hFFC6]
    call SlotHasStatus3Or4Bits_BankA3
    jr nz, Jump_0A3_4257

Jump_0A3_41FD::
    inc de
    inc de
    inc hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_0A3_421A
    ld c, a
    ld a, [de]
    cp a, c
    jr nz, Jump_0A3_4257
    ldh a, [hFFC6]
    inc a
    call CheckSlotStatusBlock
    jr c, Jump_0A3_4257
    ldh a, [hFFC6]
    inc a
    call SlotHasStatus3Or4Bits_BankA3
    jr nz, Jump_0A3_4257

Jump_0A3_421A::
    inc de
    inc de
    inc hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_0A3_4239
    ld c, a
    ld a, [de]
    cp a, c
    jr nz, Jump_0A3_4257
    ldh a, [hFFC6]
    inc a
    inc a
    call CheckSlotStatusBlock
    jr c, Jump_0A3_4257
    ldh a, [hFFC6]
    inc a
    inc a
    call SlotHasStatus3Or4Bits_BankA3
    jr nz, Jump_0A3_4257

Jump_0A3_4239::
    pop de
    ld a, [wC58A]
    cp a, $02
    jr z, Jump_0A3_4264
    inc hl
    ld a, [hl]
    cp a, $01
    jr nz, Jump_0A3_41E0
    inc hl
    push bc
    push hl
    call SaveActionChoicesAndPickFormations_Sub01_Sub01
    pop hl
    pop bc
    or a, a
    jr z, Jump_0A3_41E0
    ld a, [hl]
    ldh [hFFC6], a
    jr Jump_0A3_4274

Jump_0A3_4257::
    pop de
    pop hl
    ld a, $05
    add_a_to_hl
    inc b
    jp Jump_0A3_41DB

Jump_0A3_4264::
    inc hl
    inc hl
    push bc
    push hl
    call SaveActionChoicesAndPickFormations_Sub01_Sub01
    pop hl
    pop bc
    or a, a
    jp z, Jump_0A3_41E0
    ld a, [hl]
    ldh [hFFC6], a

Jump_0A3_4274::
    pop hl
    ld a, $01
    ret

; A = slot: with HL = wD80F + 9 * A (status byte 3 of wBattleStatus), A = byte 3 & $C0, or byte 4 & $0C when that is zero; Z set when both are clear; HL kept (E-0067) (the same 17 bytes appear in 8 banks)
; 3 call sites from 1 routine (e.g. SaveActionChoicesAndPickFormations_Sub01)
; points at: wD80F
SlotHasStatus3Or4Bits_BankA3::
Func_0A3_4278:: ; address name
    push hl
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_0A3_4287
    ld a, [hl]
    and a, $0C

Jump_0A3_4287::
    pop hl
    ret

Data_0A3_4289:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $28C289, $23B

; only called from SaveActionChoicesAndPickFormations_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. SaveActionChoicesAndPickFormations_Sub01)
; reads: wD981, wD982, hFFC6, wC5E7, wD980
; writes: hFFC6
SaveActionChoicesAndPickFormations_Sub01_Sub01::
Func_0A3_44C4:: ; address name
    push hl
    ld a, $03
    call DivideBByA
    or a, a
    jr z, Jump_0A3_4505
    dec a
    jr z, Jump_0A3_453A
    ld a, $01
    call PersonalityIndexOfSlot_BankA3
    push af
    ld a, $02
    call PersonalityIndexOfSlot_BankA3
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    pop af
    add_a_to_hl
    ld a, l
    add a, $B7
    ld l, a
    ld a, h
    adc a, $45
    ld h, a
    ld a, [hl]
    inc a
    ldh [hFFC6], a
    ld a, [wD981]
    ld c, a
    ld b, $00
    ld a, [wD982]
    add a, c
    ld c, a
    jr nc, Jump_0A3_4503
    inc b

Jump_0A3_4503::
    jr Jump_0A3_456D

Jump_0A3_4505::
    ld a, $00
    call PersonalityIndexOfSlot_BankA3
    push af
    ld a, $01
    call PersonalityIndexOfSlot_BankA3
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    pop af
    add_a_to_hl
    ld a, l
    add a, $B7
    ld l, a
    ld a, h
    adc a, $45
    ld h, a
    ld a, [hl]
    inc a
    ldh [hFFC6], a
    ld a, [wD980]
    ld c, a
    ld b, $00
    ld a, [wD981]
    add a, c
    ld c, a
    jr nc, Jump_0A3_4538
    inc b

Jump_0A3_4538::
    jr Jump_0A3_456D

Jump_0A3_453A::
    ld a, $00
    call PersonalityIndexOfSlot_BankA3
    push af
    ld a, $02
    call PersonalityIndexOfSlot_BankA3
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    pop af
    add_a_to_hl
    ld a, l
    add a, $B7
    ld l, a
    ld a, h
    adc a, $45
    ld h, a
    ld a, [hl]
    inc a
    ldh [hFFC6], a
    ld a, [wD980]
    ld c, a
    ld b, $00
    ld a, [wD982]
    add a, c
    ld c, a
    jr nc, Jump_0A3_456D
    inc b

Jump_0A3_456D::
    ldh a, [hFFC6]
    call Multiply8By16
    ld c, h
    ld b, e
    pop hl
    ld a, [hl]
    sub a, $D0
    ld hl, Data_0A3_45A3
    add_a_to_hl
    ld a, [hl]
    call Multiply8By16
    ld a, $0A
    call DivideHLByA
    ld a, h
    or a, a
    jr z, Jump_0A3_458F
    ld l, $FF

Jump_0A3_458F::
    call AdvanceRandom
    ld a, [wC5E7]
    and a, $7F
    cp a, $64
    jr nc, Jump_0A3_458F
    cp a, l
    jr c, Jump_0A3_45A0
    xor a, a
    ret

Jump_0A3_45A0::
    ld a, $01
    ret

Data_0A3_45A3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $28C5A3, $374

; only called from SaveActionChoicesAndPickFormations (E-0047)
; 2 call sites from 1 routine (e.g. SaveActionChoicesAndPickFormations)
; reads: hFFC6
SaveActionChoicesAndPickFormations_Sub02::
Func_0A3_4917:: ; address name
    push bc
    push de
    ld a, $03
    call DivideBByA
    pop de
    pop bc
    or a, a
    jr z, Jump_0A3_4928
    dec a
    jr z, Jump_0A3_4938
    jr Jump_0A3_494E

Jump_0A3_4928::
    ldh a, [hFFC6]
    ld [de], a
    inc de
    inc de
    ld [de], a
    dec de
    ld a, $FF
    ld [de], a
    inc de
    inc de
    ld [de], a
    ld a, $00
    ret

Jump_0A3_4938::
    ldh a, [hFFC6]
    ld [de], a
    inc de
    inc de
    inc de
    inc de
    ld [de], a
    dec de
    dec de
    dec de
    ld a, $FF
    ld [de], a
    inc de
    inc de
    inc de
    inc de
    ld [de], a
    ld a, $01
    ret

Jump_0A3_494E::
    inc de
    inc de
    ldh a, [hFFC6]
    ld [de], a
    inc de
    inc de
    ld [de], a
    dec de
    ld a, $FF
    ld [de], a
    inc de
    inc de
    ld [de], a
    ld a, $02
    ret

; 1 call site from 1 routine (e.g. Func_032_4ADC_Case01_Case00)
; reads: wBattleActor
; writes: hFFC6
; points at: wBattleActionChoice
Func_0A3_4960::
    ld a, [wBattleActor]
    add a, a
    ld hl, wBattleActionChoice
    add_a_to_hl
    ld a, [hl]
    cp a, $D0
    jr c, Jump_0A3_497A
    cp a, $E4
    jr nc, Jump_0A3_497A
    ld a, $01
    ldh [hFFC6], a
    ret

Jump_0A3_497A::
    xor a, a
    ldh [hFFC6], a
    ret

; A = slot 0-7: returns A = 9 * g(wD968[A]) + 3 * g(wD970[A]) + g(wD978[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes appear in 7 banks)
; 6 call sites from 1 routine (e.g. SaveActionChoicesAndPickFormations_Sub01_Sub01)
; points at: wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo
PersonalityIndexOfSlot_BankA3::
Func_0A3_497E:: ; address name
    push hl
    push bc
    ld c, a
    ld b, $00
    ld hl, wSlotPersonalityHi
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_0A3_499A
    ld l, $09
    cp a, $40
    jr nc, Jump_0A3_499A
    ld l, $12

Jump_0A3_499A::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityMid
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_0A3_49B5
    ld l, $03
    cp a, $40
    jr nc, Jump_0A3_49B5
    ld l, $06

Jump_0A3_49B5::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityLo
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_0A3_49D0
    ld l, $01
    cp a, $40
    jr nc, Jump_0A3_49D0
    ld l, $02

Jump_0A3_49D0::
    ld a, l
    add a, b
    pop bc
    pop hl
    ret

; only called from RollWC5E7BelowChance (E-0047)
; 1 call site from 1 routine (e.g. RollWC5E7BelowChance)
; reads: wC58A, wBattleActor
; writes: hFFC6
; points at: wBattleMonsterId
RollWC5E7BelowChance_Sub01::
Func_0A3_49D5:: ; address name
    ld a, [wC58A]
    or a, a
    jr z, Jump_0A3_49DF
    cp a, $02
    jr nz, Jump_0A3_49EB

Jump_0A3_49DF::
    ld a, [wBattleActor]
    cp a, $04
    jr c, Jump_0A3_49EB
    ld de, Data_0A3_4CD7
    jr Jump_0A3_49EE

Jump_0A3_49EB::
    ld de, Data_0A3_4B57

Jump_0A3_49EE::
    ld a, [wBattleActor]
    add a, a
    ld hl, wBattleMonsterId
    add_a_to_hl
    deref_hl
    add hl, de
    ld a, [hl]
    ldh [hFFC6], a
    ret

; unless the target's chosen action is 0, $AC or $CC-$CF: actions below $D0 are replaced by 0 with target $FF; others set wDA5B[target] = 3 (E-0124)
; 1 call site from 1 routine (e.g. Func_036_4A38_Case01)
; reads: wBattleTarget
; points at: wBattleActionChoice, wDA5B
CancelTargetActionUnlessSpecial::
Func_0A3_4A02:: ; address name
    ld a, [wBattleTarget]
    add a, a
    ld hl, wBattleActionChoice
    add_a_to_hl
    ld a, [hl]
    cp a, $00
    ret z
    cp a, $AC
    ret z
    cp a, $CC
    ret z
    cp a, $CD
    ret z
    cp a, $CE
    ret z
    cp a, $CF
    ret z
    cp a, $D0
    jr nc, Jump_0A3_4A2B
    ld [hl], $00
    inc hl
    ld [hl], $FF
    ret

Jump_0A3_4A2B::
    ld a, [wBattleTarget]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $03
    ret

; removes the first byte equal to C from the 8-byte queue at wD895, shifting later bytes down and filling with $FF (E-0124)
; no direct call (reached through a table, a jump or a vector)
; points at: wD895
RemoveCFromWD895Queue_A3:: ; heuristic: follows a terminator; C0
Func_0A3_4A39:: ; address name
    push de
    ld hl, wD895
    ld b, $08
    ld d, $00

Jump_0A3_4A41::
    bit 0, d
    jr nz, Jump_0A3_4A4B
    ld a, [hl]
    cp a, c
    jr nz, Jump_0A3_4A59
    ld d, $01

Jump_0A3_4A4B::
    inc hl
    ld a, [hl]
    ld [hl], $FF
    dec hl
    ld [hl], a
    inc hl
    dec b
    jr nz, Jump_0A3_4A41
    ld [hl], $FF
    pop de
    ret

Jump_0A3_4A59::
    inc hl
    dec b
    jr nz, Jump_0A3_4A41
    pop de
    ret

; only called from ResolveStepBegin (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepBegin)
; reads: wBattleTarget
; points at: wD86D
ResolveStepBegin_Sub01::
Func_0A3_4A5F:: ; address name
    call AdvanceRandom
    ld a, $FF
    ld hl, wD86D
    ld bc, $0003
    call FillBytes
    ld a, [wBattleTarget]
    ld d, a
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00

Jump_0A3_4A7A::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_0A3_4A8E
    cp a, d
    jr z, Jump_0A3_4A7A
    ld a, e
    ld hl, wD86D
    add_a_to_hl
    ld [hl], c
    inc e

Jump_0A3_4A8E::
    inc c
    dec b
    jr nz, Jump_0A3_4A7A
    ld a, e
    or a, a
    jr nz, Jump_0A3_4A99
    ld c, $FF
    ret

Jump_0A3_4A99::
    ld hl, $0000
    ld b, $00
    dec e
    ld c, e
    call RandomInRange
    ld a, e
    ld hl, wD86D
    add_a_to_hl
    ld a, [hl]
    ld c, a
    ret

; only called from ActionEffect_Chance (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Chance)
; reads: wC5E7, wC58A, wCFC5, wBattleActor
ActionEffect_Chance_Sub01:: ; heuristic: follows a terminator; C0
Func_0A3_4AAF:: ; address name
    call AdvanceRandom
    ld a, [wC5E7]
    ld b, a
    ld a, $0E
    call DivideBByA
    ld hl, Data_0A3_4AFD
    add_a_to_hl
    ld a, [hl]
    ld c, a
    ld a, [wC58A]
    or a, a
    jr nz, Jump_0A3_4AF3
    ld a, [wCFC5]
    cp a, $02
    jr z, Jump_0A3_4AE2
    cp a, $03
    jr z, Jump_0A3_4AE2
    cp a, $05
    jr z, Jump_0A3_4AE2
    ld a, [wBattleActor]
    bit 2, a
    ret z
    jr Jump_0A3_4AF3

Jump_0A3_4AE2::
    ld a, c
    cp a, $B3
    jr z, ActionEffect_Chance_Sub01
    cp a, $B4
    jr z, ActionEffect_Chance_Sub01
    cp a, $B6
    jr z, ActionEffect_Chance_Sub01
    cp a, $BD
    jr z, ActionEffect_Chance_Sub01

Jump_0A3_4AF3::
    ld a, c
    cp a, $B0
    jr z, ActionEffect_Chance_Sub01
    cp a, $B2
    jr z, ActionEffect_Chance_Sub01
    ret

Data_0A3_4AFD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B2, $B3, $B4, $B5, $B6, $B7, $B8, $B9, $BA, $BB, $BC, $BD

; only called from BattleEnd_Step7_Case02 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step7_Case02)
; reads: wC6FD
; writes: rRAMG
; points at: wC6FE, wC972
BattleEnd_Step7_Case02_Sub01::
Func_0A3_4B0B:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE
    ld de, wC972

Jump_0A3_4B1A::
    inc de
    ld a, [de]
    cp a, $FF
    jr z, Jump_0A3_4B4C
    dec de
    push hl
    ld a, [hl]
    ld c, $5B
    call SRAMRecordAddress
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl], a
    pop hl
    push hl
    ld a, [hl]
    ld c, $5F
    call SRAMRecordAddress
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl], a
    pop hl
    push hl
    ld a, [hl]
    ld c, $55
    call SRAMRecordAddress
    ld a, [de]
    inc de
    ld [hl+], a
    pop hl
    inc hl
    dec b
    jr nz, Jump_0A3_4B1A

Jump_0A3_4B4C::
    farcall Func_0F2_65E6
    xor a, a
    ld [rRAMG], a
    ret

Data_0A3_4B57:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $28CB57, $180

Data_0A3_4CD7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $01
    db $01, $00, $00, $01
    ds $11, $00
    INCBIN "dwm2-cobi-us.gbc", $28CCFC, $83
    ds $11, $00
    INCBIN "dwm2-cobi-us.gbc", $28CD90, $A2
    ds $17, $00
    db $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $03
    ds $31AA, $00
