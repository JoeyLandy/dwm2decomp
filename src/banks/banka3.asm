SECTION "Bank A3", ROMX[$4000], BANK[$A3]
    db $A3

; A = battle slot: HL = the word for that slot at wBattleATK; A = its low byte (E-0064)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleATK
GetBattleATK_BankA3:: ; heuristic: follows a terminator; C0
Func_0A3_4001:: ; address name
    ld hl, wBattleATK
    jr Jump_0A3_402E

; no direct call (reached through a table, a jump or a vector)
; points at: wBattleDEF
GetBattleDEF_BankA3:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:4006; C0
Func_0A3_4006:: ; address name
    ld hl, wBattleDEF
    jr Jump_0A3_402E

; no direct call (reached through a table, a jump or a vector)
; points at: wBattleMaxHP
GetBattleMaxHP_BankA3:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:400B; C0
Func_0A3_400B:: ; address name
    ld hl, wBattleMaxHP
    jr Jump_0A3_402E

; no direct call (reached through a table, a jump or a vector)
; points at: wBattleMaxMP
GetBattleMaxMP_BankA3:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:4010; C0
Func_0A3_4010:: ; address name
    ld hl, wBattleMaxMP
    jr Jump_0A3_402E

; no direct call (reached through a table, a jump or a vector)
; points at: wBattleHP
GetBattleHP_BankA3:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:4015; C0
Func_0A3_4015:: ; address name
    ld hl, wBattleHP
    jr Jump_0A3_402E

; no direct call (reached through a table, a jump or a vector)
; points at: wBattleMP
GetBattleMP_BankA3:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:401A; C0
Func_0A3_401A:: ; address name
    ld hl, wBattleMP
    jr Jump_0A3_402E
    db $21, $1F, $D9, $18, $0A, $21, $53, $DA, $85, $6F, $30, $01, $24, $7E, $C9

Jump_0A3_402E::
    add a, a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
AddDoubleAToHL_BankA3:: ; heuristic: follows a terminator; C0
Func_0A3_4038:: ; address name
    add a, a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the reversal, not checked (E-0064) (the same 27 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole, wBattleActor
ActorOnLocalSide_BankA3:: ; heuristic: follows a terminator; C0
Func_0A3_403F:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr nz, Jump_0A3_4054
    ld a, [wLinkRole]
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

; carry set when wBattleTarget < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleTarget >= 4) (E-0064) (the same 27 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole, wBattleTarget
TargetOnLocalSide_BankA3:: ; heuristic: follows a terminator; C0
Func_0A3_405A:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr nz, Jump_0A3_406F
    ld a, [wLinkRole]
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

; wBattleStatus + 9 * E &= ClearBitMaskTable_BankA3[D] (AddAx9ToHL); not reached from traced code (E-0205)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleStatus
ClearBattleStatusBitsWithMaskD_BankA3:: ; configured code entry (E-0205); C0
Func_0A3_4075:: ; address name
    ld a, d
    ld hl, ClearBitMaskTable_BankA3
    add_a_to_hl
    ld d, [hl]
    ld a, e
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, d
    and a, [hl]
    ld [hl], a
    ret

; E-0205 (C1: the routine at $4075 reads the byte at $408A + D and ANDs it into the byte at wBattleStatus + 9 * E (AddAx9ToHL); the same 202-byte block of routines and this table sit at $4075-$413F in banks $05, $A1 and $A3).
; record: AND mask
ClearBitMaskTable_BankA3::
Data_0A3_408A:: ; address name
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
SetBit0OfLevelUpGainsIndexed_BankA3:: ; configured code entry (E-0205); C0
Func_0A3_4091:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; Sets bit 1 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wLevelUpGains
SetBit1OfLevelUpGainsIndexed_BankA3:: ; configured code entry (E-0205); C0
Func_0A3_409E:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; Sets bit 2 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wLevelUpGains
SetBit2OfLevelUpGainsIndexed_BankA3:: ; configured code entry (E-0205); C0
Func_0A3_40AB:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 2, [hl]
    pop hl
    ret

; A = slot 0-7: returns A = 9 * g(wD968[A]) + 3 * g(wD970[A]) + g(wD978[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes appear in 13 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo
PersonalityIndexOfSlot_BankA3:: ; configured code entry (E-0205); C0
Func_0A3_40B8:: ; address name
    push hl
    push bc
    ld c, a
    ld b, $00
    ld hl, wSlotPersonalityHi
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_0A3_40D4
    ld l, $09
    cp a, $40
    jr nc, Jump_0A3_40D4
    ld l, $12

Jump_0A3_40D4::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityMid
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_0A3_40EF
    ld l, $03
    cp a, $40
    jr nc, Jump_0A3_40EF
    ld l, $06

Jump_0A3_40EF::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityLo
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_0A3_410A
    ld l, $01
    cp a, $40
    jr nc, Jump_0A3_410A
    ld l, $02

Jump_0A3_410A::
    ld a, l
    add a, b
    pop bc
    pop hl
    ret

; A = slot: carry set when CheckSlotStatusBlock sets it, or when status byte 3 & $C0 or byte 4 & $0C is set (wD80F + 9 * A); otherwise carry clear; A, BC, HL kept (E-0067) (the same 31 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleStatus3
CheckSlotStatusBlockWide_BankA3:: ; configured code entry (E-0205); C0
Func_0A3_410F:: ; address name
    call CheckSlotStatusBlock
    ret c
    push hl
    push bc
    ld c, a
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_0A3_4129
    ld a, [hl]
    and a, $0C
    jr nz, Jump_0A3_4129
    xor a, a
    jr Jump_0A3_412A

Jump_0A3_4129::
    scf

Jump_0A3_412A::
    ld a, c
    pop bc
    pop hl
    ret

; A = slot: with HL = wD80F + 9 * A (status byte 3 of wBattleStatus), A = byte 3 & $C0, or byte 4 & $0C when that is zero; Z set when both are clear; HL kept (E-0067) (the same 17 bytes appear in 13 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleStatus3
SlotHasStatus3Or4Bits_BankA3:: ; configured code entry (E-0205); C0
Func_0A3_412E:: ; address name
    push hl
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_0A3_413D
    ld a, [hl]
    and a, $0C

Jump_0A3_413D::
    pop hl
    ret

; runs Func_0A3_414F, then wDA5B[hFFC6] = 3 (E-0122)
; 22 call sites from 21 routines (e.g. ApplyActionResultAndMarkFormation, SetSubPhase2AndRestartResolve, ActionEffect_ActionD0, ActionEffect_ActionD1, ...)
; reads: hTemp0
; points at: wSlotMarks
RunA3414FAndMarkWDA5B3::
Func_0A3_413F:: ; address name
    call ActorFormationSlotToTemp0
    ldh a, [hTemp0]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $03
    ret

; hFFC6 = the slot for the actor through its side's wC953 formation (Data_0A3_4181), $FF when none (E-0124)
; 17 call sites from 14 routines (e.g. RunA3414FAndMarkWDA5B3, ApplyActionResultAndMarkFormation, CheckFormationPartnersCanAct, PayActorMPCost, ...)
; reads: wBattleActor
; writes: hTemp0
; points at: wFormationSlot0
ActorFormationSlotToTemp0::
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
    ld hl, wFormationSlot0
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_0A3_417D
    sla a
    ld hl, ActorFormationSlotToTemp0_Data
    add_a_to_hl
    ld a, [hl+]
    cp a, c
    jr nz, Jump_0A3_417C
    ld a, [hl]

Jump_0A3_417C::
    add a, b

Jump_0A3_417D::
    ldh [hTemp0], a
    pop bc
    ret

; address loaded by ActorFormationSlotToTemp0
ActorFormationSlotToTemp0_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0A3_4181:: ; address name
    db $00, $01, $00, $02, $01, $02

; copies 16 bytes of wBattleActionChoice to wDA2C, clears wC953/4, and outside link battles sets the formation for each side from Func_0A3_41CF and Func_0A3_4917 (E-0125)
; 2 call sites from 2 routines (e.g. RunBattleCommandEntry_AddWordAtHLToBC_Bank30, RunBattleCommandEntry_BankA1_AddWordAtHLToBC_BankA1)
; reads: wLinkMode
; writes: wFormationSlot0, wFormationSlot1
; points at: wBattleActionChoice, wSavedActionChoices
SaveActionChoicesAndPickFormations::
Func_0A3_4187:: ; address name
    ld b, $10
    ld hl, wBattleActionChoice
    ld de, wSavedActionChoices

Jump_0A3_418F::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_0A3_418F
    ld a, $FF
    ld [wFormationSlot0], a
    ld [wFormationSlot1], a
    ld a, [wLinkMode]
    cp a, $01
    ret z
    ld de, wBattleActionChoice
    call FindFormationForSide
    or a, a
    jr z, Jump_0A3_41B5
    ld de, wBattleActionChoice
    call SaveActionChoicesAndPickFormations_DivideBByA
    ld [wFormationSlot0], a

Jump_0A3_41B5::
    ld a, [wLinkMode]
    or a, a
    ret z
    cp a, $02
    ret z
    ld de, wBattleActionChoice + $8
    call FindFormationForSide
    or a, a
    ret z
    ld de, wBattleActionChoice + $8
    call SaveActionChoicesAndPickFormations_DivideBByA
    ld [wFormationSlot1], a
    ret

; walks FormationTable for the actor's side (wBattleActor & 4): the first record whose three actions match the side's chosen actions (DE) with every required slot able to act gives A = 1 and hFFC6 = its combined action, after FormationCompatibilityRoll when its flag is 1 or in link mode 2; A = 0 when none applies (E-0172)
; 2 call sites from 1 routine (e.g. SaveActionChoicesAndPickFormations)
; reads: wBattleActor, hTemp0, wLinkMode
; writes: hTemp0
FindFormationForSide::
Func_0A3_41CF:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ldh [hTemp0], a
    ld b, $00
    ld hl, FormationTable

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
    ldh a, [hTemp0]
    call CheckSlotStatusBlock
    jr c, Jump_0A3_4257
    ldh a, [hTemp0]
    call SlotHasStatus3Or4Bits_BankA3_4278
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
    ldh a, [hTemp0]
    inc a
    call CheckSlotStatusBlock
    jr c, Jump_0A3_4257
    ldh a, [hTemp0]
    inc a
    call SlotHasStatus3Or4Bits_BankA3_4278
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
    ldh a, [hTemp0]
    inc a
    inc a
    call CheckSlotStatusBlock
    jr c, Jump_0A3_4257
    ldh a, [hTemp0]
    inc a
    inc a
    call SlotHasStatus3Or4Bits_BankA3_4278
    jr nz, Jump_0A3_4257

Jump_0A3_4239::
    pop de
    ld a, [wLinkMode]
    cp a, $02
    jr z, Jump_0A3_4264
    inc hl
    ld a, [hl]
    cp a, $01
    jr nz, Jump_0A3_41E0
    inc hl
    push bc
    push hl
    call FormationCompatibilityRoll
    pop hl
    pop bc
    or a, a
    jr z, Jump_0A3_41E0
    ld a, [hl]
    ldh [hTemp0], a
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
    call FormationCompatibilityRoll
    pop hl
    pop bc
    or a, a
    jp z, Jump_0A3_41E0
    ld a, [hl]
    ldh [hTemp0], a

Jump_0A3_4274::
    pop hl
    ld a, $01
    ret

; A = slot: with HL = wD80F + 9 * A (status byte 3 of wBattleStatus), A = byte 3 & $C0, or byte 4 & $0C when that is zero; Z set when both are clear; HL kept (E-0067) (the same 17 bytes appear in 13 banks)
; 3 call sites from 1 routine (e.g. FindFormationForSide)
; points at: wBattleStatus3
SlotHasStatus3Or4Bits_BankA3_4278::
Func_0A3_4278:: ; address name
    push hl
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_0A3_4287
    ld a, [hl]
    and a, $0C

Jump_0A3_4287::
    pop hl
    ret

; E-0172 (C1: SaveActionChoicesAndPickFormations_Sub01 walks these 5-byte records until a 0 byte; a record applies when each slot of the side chose the given action and can act (CheckSlotStatusBlock, SlotHasStatus3Or4Bits_BankA3); it then returns the combined action, after the compatibility roll when byte 3 is 1 or in link mode 2).
; record: action each of the three slots must have chosen ($FF = any); 1 = roll FormationCompatibilityRoll (always rolled in link mode 2); combined action id ($D0-$E3)
FormationTable::
Data_0A3_4289:: ; address name
    db $0F, $0F, $FF, $01, $D0 ; id 0
    db $0F, $FF, $0F, $01, $D0 ; id 1
    db $FF, $0F, $0F, $01, $D0 ; id 2
    db $03, $12, $FF, $01, $D1 ; id 3
    db $03, $FF, $12, $01, $D1 ; id 4
    db $FF, $03, $12, $01, $D1 ; id 5
    db $12, $03, $FF, $01, $D1 ; id 6
    db $12, $FF, $03, $01, $D1 ; id 7
    db $FF, $12, $03, $01, $D1 ; id 8
    db $4D, $67, $FF, $01, $D2 ; id 9
    db $4D, $FF, $67, $01, $D2 ; id 10
    db $FF, $4D, $67, $01, $D2 ; id 11
    db $67, $4D, $FF, $01, $D2 ; id 12
    db $67, $FF, $4D, $01, $D2 ; id 13
    db $FF, $67, $4D, $01, $D2 ; id 14
    db $49, $67, $FF, $01, $D3 ; id 15
    db $49, $FF, $67, $01, $D3 ; id 16
    db $FF, $49, $67, $01, $D3 ; id 17
    db $67, $49, $FF, $01, $D3 ; id 18
    db $67, $FF, $49, $01, $D3 ; id 19
    db $FF, $67, $49, $01, $D3 ; id 20
    db $4B, $67, $FF, $01, $D4 ; id 21
    db $4B, $FF, $67, $01, $D4 ; id 22
    db $FF, $4B, $67, $01, $D4 ; id 23
    db $67, $4B, $FF, $01, $D4 ; id 24
    db $67, $FF, $4B, $01, $D4 ; id 25
    db $FF, $67, $4B, $01, $D4 ; id 26
    db $67, $67, $FF, $01, $D5 ; id 27
    db $67, $FF, $67, $01, $D5 ; id 28
    db $FF, $67, $67, $01, $D5 ; id 29
    db $70, $15, $FF, $01, $D6 ; id 30
    db $70, $FF, $15, $01, $D6 ; id 31
    db $FF, $70, $15, $01, $D6 ; id 32
    db $15, $70, $FF, $01, $D6 ; id 33
    db $15, $FF, $70, $01, $D6 ; id 34
    db $FF, $15, $70, $01, $D6 ; id 35
    db $91, $6A, $FF, $01, $D7 ; id 36
    db $91, $FF, $6A, $01, $D7 ; id 37
    db $FF, $91, $6A, $01, $D7 ; id 38
    db $6A, $91, $FF, $01, $D7 ; id 39
    db $6A, $FF, $91, $01, $D7 ; id 40
    db $FF, $6A, $91, $01, $D7 ; id 41
    db $2A, $62, $FF, $01, $D8 ; id 42
    db $2A, $FF, $62, $01, $D8 ; id 43
    db $FF, $2A, $62, $01, $D8 ; id 44
    db $62, $2A, $FF, $01, $D8 ; id 45
    db $62, $FF, $2A, $01, $D8 ; id 46
    db $FF, $62, $2A, $01, $D8 ; id 47
    db $1D, $3D, $FF, $01, $D9 ; id 48
    db $1D, $FF, $3D, $01, $D9 ; id 49
    db $FF, $1D, $3D, $01, $D9 ; id 50
    db $3D, $1D, $FF, $01, $D9 ; id 51
    db $3D, $FF, $1D, $01, $D9 ; id 52
    db $FF, $3D, $1D, $01, $D9 ; id 53
    db $A0, $7C, $FF, $00, $DA ; id 54
    db $A0, $FF, $7C, $00, $DA ; id 55
    db $FF, $A0, $7C, $00, $DA ; id 56
    db $7C, $A0, $FF, $00, $DA ; id 57
    db $7C, $FF, $A0, $00, $DA ; id 58
    db $FF, $7C, $A0, $00, $DA ; id 59
    db $75, $79, $FF, $00, $DB ; id 60
    db $75, $FF, $79, $00, $DB ; id 61
    db $FF, $75, $79, $00, $DB ; id 62
    db $79, $75, $FF, $00, $DB ; id 63
    db $79, $FF, $75, $00, $DB ; id 64
    db $FF, $79, $75, $00, $DB ; id 65
    db $3A, $3C, $FF, $00, $DC ; id 66
    db $3A, $FF, $3C, $00, $DC ; id 67
    db $FF, $3A, $3C, $00, $DC ; id 68
    db $3C, $3A, $FF, $00, $DC ; id 69
    db $3C, $FF, $3A, $00, $DC ; id 70
    db $FF, $3C, $3A, $00, $DC ; id 71
    db $81, $82, $FF, $00, $DD ; id 72
    db $81, $FF, $82, $00, $DD ; id 73
    db $FF, $81, $82, $00, $DD ; id 74
    db $82, $81, $FF, $00, $DD ; id 75
    db $82, $FF, $81, $00, $DD ; id 76
    db $FF, $82, $81, $00, $DD ; id 77
    db $9C, $92, $FF, $00, $DE ; id 78
    db $9C, $FF, $92, $00, $DE ; id 79
    db $FF, $9C, $92, $00, $DE ; id 80
    db $92, $9C, $FF, $00, $DE ; id 81
    db $92, $FF, $9C, $00, $DE ; id 82
    db $FF, $92, $9C, $00, $DE ; id 83
    db $32, $77, $FF, $00, $DF ; id 84
    db $32, $FF, $77, $00, $DF ; id 85
    db $FF, $32, $77, $00, $DF ; id 86
    db $77, $32, $FF, $00, $DF ; id 87
    db $77, $FF, $32, $00, $DF ; id 88
    db $FF, $77, $32, $00, $DF ; id 89
    db $95, $96, $FF, $00, $E0 ; id 90
    db $95, $FF, $96, $00, $E0 ; id 91
    db $FF, $95, $96, $00, $E0 ; id 92
    db $96, $95, $FF, $00, $E0 ; id 93
    db $96, $FF, $95, $00, $E0 ; id 94
    db $FF, $96, $95, $00, $E0 ; id 95
    db $34, $78, $FF, $00, $E1 ; id 96
    db $34, $FF, $78, $00, $E1 ; id 97
    db $FF, $34, $78, $00, $E1 ; id 98
    db $78, $34, $FF, $00, $E1 ; id 99
    db $78, $FF, $34, $00, $E1 ; id 100
    db $FF, $78, $34, $00, $E1 ; id 101
    db $98, $94, $FF, $00, $E2 ; id 102
    db $98, $FF, $94, $00, $E2 ; id 103
    db $FF, $98, $94, $00, $E2 ; id 104
    db $94, $98, $FF, $00, $E2 ; id 105
    db $94, $FF, $98, $00, $E2 ; id 106
    db $FF, $94, $98, $00, $E2 ; id 107
    db $8A, $9F, $FF, $00, $E3 ; id 108
    db $8A, $FF, $9F, $00, $E3 ; id 109
    db $FF, $8A, $9F, $00, $E3 ; id 110
    db $9F, $8A, $FF, $00, $E3 ; id 111
    db $9F, $FF, $8A, $00, $E3 ; id 112
    db $FF, $9F, $8A, $00, $E3 ; id 113
    db $00 ; end

; picks the slot pair by B / 3, reads PersonalityCompatibility[personality of the second][personality of the first] + 1, multiplies it by the pair's wSlotTrait sum and by FormationChanceFactors[action - $D0], divides by 10 (capped at 255) and returns A = 1 when a random 0-99 is below that (E-0172)
; 2 call sites from 1 routine (e.g. FindFormationForSide)
; reads: wSlotTrait, hTemp0, wRandomLo
; writes: hTemp0
FormationCompatibilityRoll::
Func_0A3_44C4:: ; address name
    push hl
    ld a, $03
    call DivideBByA
    or a, a
    jr z, Jump_0A3_4505
    dec a
    jr z, Jump_0A3_453A
    ld a, $01
    call PersonalityIndexOfSlot_BankA3_497E
    push af
    ld a, $02
    call PersonalityIndexOfSlot_BankA3_497E
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
    ldh [hTemp0], a
    ld a, [wSlotTrait + $1]
    ld c, a
    ld b, $00
    ld a, [wSlotTrait + $2]
    add a, c
    ld c, a
    jr nc, Jump_0A3_4503
    inc b

Jump_0A3_4503::
    jr Jump_0A3_456D

Jump_0A3_4505::
    ld a, $00
    call PersonalityIndexOfSlot_BankA3_497E
    push af
    ld a, $01
    call PersonalityIndexOfSlot_BankA3_497E
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
    ldh [hTemp0], a
    ld a, [wSlotTrait]
    ld c, a
    ld b, $00
    ld a, [wSlotTrait + $1]
    add a, c
    ld c, a
    jr nc, Jump_0A3_4538
    inc b

Jump_0A3_4538::
    jr Jump_0A3_456D

Jump_0A3_453A::
    ld a, $00
    call PersonalityIndexOfSlot_BankA3_497E
    push af
    ld a, $02
    call PersonalityIndexOfSlot_BankA3_497E
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
    ldh [hTemp0], a
    ld a, [wSlotTrait]
    ld c, a
    ld b, $00
    ld a, [wSlotTrait + $2]
    add a, c
    ld c, a
    jr nc, Jump_0A3_456D
    inc b

Jump_0A3_456D::
    ldh a, [hTemp0]
    call Multiply8By16
    ld c, h
    ld b, e
    pop hl
    ld a, [hl]
    sub a, $D0
    ld hl, FormationChanceFactors
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
    ld a, [wRandomLo]
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

; E-0172 (C1: the roll multiplies (matrix value + 1) * (the two slots' wSlotTrait sum) by FormationChanceFactors[action - $D0], divides by 10 and succeeds when a random 0-99 is below it).
; record: factor of this combined action in the roll
FormationChanceFactors::
Data_0A3_45A3:: ; address name
    db $0A ; id 208
    db $14 ; id 209
    db $32 ; id 210
    db $32 ; id 211
    db $32 ; id 212
    db $1E ; id 213
    db $14 ; id 214
    db $64 ; id 215
    db $64 ; id 216
    db $0A ; id 217
    db $50 ; id 218
    db $50 ; id 219
    db $32 ; id 220
    db $3C ; id 221
    db $3C ; id 222
    db $28 ; id 223
    db $64 ; id 224
    db $50 ; id 225
    db $64 ; id 226
    db $0A ; id 227

; E-0172 (C1: the roll reads $45B7 + 32 * (second slot's PersonalityIndexOfSlot) + (first slot's index) for the two slots of the pair chosen by B / 3; 27 rows fill the slice up to $4917).
; record: value for the first slot's personality index 0-31 (27 used)
PersonalityCompatibility::
Data_0A3_45B7:: ; address name
    db $08, $09, $02, $07, $06, $05, $02, $06, $07, $08, $07, $04, $06, $07, $07, $06, $06, $04, $07, $06, $09, $07, $08, $02, $08, $03, $04, $00, $00, $00, $00, $00 ; id 0
    db $09, $08, $03, $07, $07, $03, $06, $07, $07, $08, $08, $05, $07, $09, $08, $07, $08, $05, $08, $03, $02, $08, $08, $03, $08, $05, $09, $00, $00, $00, $00, $00 ; id 1
    db $02, $03, $05, $07, $06, $02, $07, $06, $06, $06, $03, $02, $07, $08, $02, $09, $02, $01, $08, $07, $01, $08, $07, $02, $08, $08, $03, $00, $00, $00, $00, $00 ; id 2
    db $07, $07, $07, $08, $08, $07, $08, $08, $08, $09, $08, $07, $08, $08, $08, $08, $03, $04, $07, $02, $01, $04, $07, $02, $08, $02, $03, $00, $00, $00, $00, $00 ; id 3
    db $06, $07, $06, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $02, $01, $07, $05, $09, $03, $02, $09, $08, $02, $06, $02, $05, $00, $00, $00, $00, $00 ; id 4
    db $05, $03, $02, $07, $08, $05, $01, $02, $07, $02, $08, $07, $02, $08, $07, $05, $08, $07, $01, $07, $07, $02, $03, $09, $08, $08, $04, $00, $00, $00, $00, $00 ; id 5
    db $02, $06, $07, $08, $08, $01, $05, $09, $08, $07, $09, $08, $02, $07, $02, $01, $07, $08, $02, $08, $07, $02, $02, $01, $08, $08, $05, $00, $00, $00, $00, $00 ; id 6
    db $06, $07, $06, $08, $08, $02, $09, $08, $08, $09, $02, $02, $07, $07, $08, $08, $08, $02, $01, $07, $02, $04, $05, $01, $07, $02, $05, $00, $00, $00, $00, $00 ; id 7
    db $07, $07, $06, $08, $08, $07, $08, $08, $08, $08, $02, $07, $02, $04, $08, $02, $08, $08, $02, $01, $07, $01, $09, $09, $08, $07, $04, $00, $00, $00, $00, $00 ; id 8
    db $08, $08, $06, $09, $08, $02, $07, $09, $08, $08, $07, $05, $08, $08, $02, $01, $02, $01, $08, $07, $07, $07, $08, $02, $08, $08, $05, $00, $00, $00, $00, $00 ; id 9
    db $07, $08, $04, $08, $08, $08, $09, $02, $02, $07, $08, $04, $08, $08, $02, $07, $02, $02, $08, $09, $01, $07, $08, $07, $08, $08, $05, $00, $00, $00, $00, $00 ; id 10
    db $04, $05, $03, $07, $08, $07, $08, $02, $07, $05, $04, $05, $04, $04, $07, $02, $08, $07, $08, $07, $07, $09, $02, $01, $05, $07, $04, $00, $00, $00, $00, $00 ; id 11
    db $06, $07, $07, $08, $08, $02, $02, $07, $02, $08, $08, $04, $07, $09, $07, $07, $07, $08, $07, $02, $01, $07, $08, $07, $07, $08, $05, $00, $00, $00, $00, $00 ; id 12
    db $07, $09, $08, $08, $08, $08, $07, $07, $04, $08, $08, $04, $09, $08, $07, $08, $07, $08, $07, $07, $07, $08, $08, $08, $08, $08, $09, $00, $00, $00, $00, $00 ; id 13
    db $07, $08, $02, $08, $02, $07, $02, $08, $08, $02, $02, $07, $07, $07, $08, $05, $05, $04, $02, $02, $01, $06, $07, $03, $09, $07, $05, $00, $00, $00, $00, $00 ; id 14
    db $06, $07, $09, $08, $01, $06, $01, $08, $02, $01, $07, $02, $07, $08, $05, $05, $02, $02, $07, $01, $02, $02, $02, $07, $08, $02, $04, $00, $00, $00, $00, $00 ; id 15
    db $06, $08, $02, $03, $07, $08, $07, $08, $08, $02, $02, $08, $07, $07, $05, $02, $08, $02, $08, $07, $07, $08, $09, $07, $08, $07, $04, $00, $00, $00, $00, $00 ; id 16
    db $05, $05, $01, $04, $05, $07, $08, $02, $08, $01, $02, $07, $08, $08, $04, $02, $02, $05, $07, $08, $02, $08, $09, $01, $07, $07, $05, $00, $00, $00, $00, $00 ; id 17
    db $07, $08, $08, $07, $09, $01, $02, $01, $02, $08, $08, $08, $07, $07, $02, $07, $08, $07, $08, $07, $07, $07, $07, $07, $07, $09, $05, $00, $00, $00, $00, $00 ; id 18
    db $06, $03, $07, $02, $03, $07, $08, $07, $01, $07, $09, $07, $02, $07, $02, $01, $07, $08, $07, $05, $08, $07, $07, $08, $08, $08, $06, $00, $00, $00, $00, $00 ; id 19
    db $09, $02, $01, $01, $02, $07, $07, $02, $07, $07, $01, $07, $01, $07, $01, $02, $07, $02, $07, $08, $08, $07, $05, $04, $04, $02, $05, $00, $00, $00, $00, $00 ; id 20
    db $07, $08, $08, $04, $09, $02, $02, $04, $01, $07, $07, $09, $07, $08, $06, $02, $08, $08, $07, $07, $07, $08, $08, $08, $08, $02, $04, $00, $00, $00, $00, $00 ; id 21
    db $08, $08, $07, $07, $08, $03, $02, $05, $09, $08, $08, $02, $08, $08, $07, $02, $09, $09, $07, $07, $05, $08, $08, $08, $08, $08, $09, $00, $00, $00, $00, $00 ; id 22
    db $02, $03, $02, $02, $02, $09, $01, $01, $09, $02, $07, $01, $07, $08, $03, $07, $01, $01, $07, $08, $04, $08, $08, $05, $07, $07, $04, $00, $00, $00, $00, $00 ; id 23
    db $08, $08, $08, $08, $06, $08, $08, $07, $08, $08, $08, $05, $07, $08, $09, $08, $07, $07, $07, $08, $04, $08, $08, $07, $07, $08, $09, $00, $00, $00, $00, $00 ; id 24
    db $03, $05, $08, $02, $02, $08, $08, $02, $07, $08, $08, $07, $08, $08, $07, $02, $07, $07, $09, $08, $02, $02, $08, $07, $08, $08, $09, $00, $00, $00, $00, $00 ; id 25
    db $04, $09, $03, $03, $05, $04, $05, $05, $04, $05, $05, $04, $05, $09, $05, $04, $05, $05, $05, $06, $05, $04, $09, $04, $09, $09, $05, $00, $00, $00, $00, $00 ; id 26

; only called from SaveActionChoicesAndPickFormations (E-0047)
; 2 call sites from 1 routine (e.g. SaveActionChoicesAndPickFormations)
; reads: hTemp0
SaveActionChoicesAndPickFormations_DivideBByA::
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
    ldh a, [hTemp0]
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
    ldh a, [hTemp0]
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
    ldh a, [hTemp0]
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

; hFFC6 = 1 when the actor's chosen action is $D0-$E3, else 0 (E-0126)
; 1 call site from 1 routine (e.g. RunBattleActions_Case00_Sub01_Case01_ActorActionIsD0ToE3)
; reads: wBattleActor
; writes: hTemp0
; points at: wBattleActionChoice
ActorActionIsD0ToE3::
Func_0A3_4960:: ; address name
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
    ldh [hTemp0], a
    ret

Jump_0A3_497A::
    xor a, a
    ldh [hTemp0], a
    ret

; A = slot 0-7: returns A = 9 * g(wD968[A]) + 3 * g(wD970[A]) + g(wD978[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes appear in 13 banks)
; 6 call sites from 1 routine (e.g. FormationCompatibilityRoll)
; points at: wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo
PersonalityIndexOfSlot_BankA3_497E::
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

; only called from RollRandomLoBelowChance (E-0047)
; 1 call site from 1 routine (e.g. RollRandomLoBelowChance)
; reads: wLinkMode, wBattleActor
; writes: hTemp0
; points at: wBattleMonsterId
RollRandomLoBelowChance_WriteTemp0::
Func_0A3_49D5:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_0A3_49DF
    cp a, $02
    jr nz, Jump_0A3_49EB

Jump_0A3_49DF::
    ld a, [wBattleActor]
    cp a, $04
    jr c, Jump_0A3_49EB
    ld de, MonsterResolveChanceTable_Foes
    jr Jump_0A3_49EE

Jump_0A3_49EB::
    ld de, MonsterResolveChanceTable

Jump_0A3_49EE::
    ld a, [wBattleActor]
    add a, a
    ld hl, wBattleMonsterId
    add_a_to_hl
    deref_hl
    add hl, de
    ld a, [hl]
    ldh [hTemp0], a
    ret

; unless the target's chosen action is 0, $AC or $CC-$CF: actions below $D0 are replaced by 0 with target $FF; others set wDA5B[target] = 3 (E-0124)
; 1 call site from 1 routine (e.g. ResolveStepDamageMessage_Sub04_ShowHeroTurnedBackTo)
; reads: wBattleTarget
; points at: wBattleActionChoice, wSlotMarks
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
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $03
    ret

; removes the first byte equal to C from the 8-byte queue at wD895, shifting later bytes down and filling with $FF (E-0124)
; no direct call (reached through a table, a jump or a vector)
; points at: wActionQueue
RemoveCFromActionQueue_A3:: ; heuristic: follows a terminator; C0
Func_0A3_4A39:: ; address name
    push de
    ld hl, wActionQueue
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
; points at: wSlotChoices
ResolveStepBegin_AdvanceRandom::
Func_0A3_4A5F:: ; address name
    call AdvanceRandom
    ld a, $FF
    ld hl, wSlotChoices
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
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_0A3_4A8E
    cp a, d
    jr z, Jump_0A3_4A7A
    ld a, e
    ld hl, wSlotChoices
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
    ld hl, wSlotChoices
    add_a_to_hl
    ld a, [hl]
    ld c, a
    ret

; only called from ActionEffect_Chance (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Chance)
; reads: wRandomLo, wLinkMode, wBattleKind, wBattleActor
ActionEffect_Chance_AdvanceRandom::
Func_0A3_4AAF:: ; address name
    call AdvanceRandom
    ld a, [wRandomLo]
    ld b, a
    ld a, $0E
    call DivideBByA
    ld hl, ActionEffect_Chance_AdvanceRandom_Data
    add_a_to_hl
    ld a, [hl]
    ld c, a
    ld a, [wLinkMode]
    or a, a
    jr nz, Jump_0A3_4AF3
    ld a, [wBattleKind]
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
    jr z, ActionEffect_Chance_AdvanceRandom
    cp a, $B4
    jr z, ActionEffect_Chance_AdvanceRandom
    cp a, $B6
    jr z, ActionEffect_Chance_AdvanceRandom
    cp a, $BD
    jr z, ActionEffect_Chance_AdvanceRandom

Jump_0A3_4AF3::
    ld a, c
    cp a, $B0
    jr z, ActionEffect_Chance_AdvanceRandom
    cp a, $B2
    jr z, ActionEffect_Chance_AdvanceRandom
    ret

; address loaded by ActionEffect_Chance_AdvanceRandom
ActionEffect_Chance_AdvanceRandom_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0A3_4AFD:: ; address name
    db $B0, $B1, $B2, $B3, $B4, $B5, $B6, $B7, $B8, $B9, $BA, $BB, $BC, $BD

; only called from BattleEnd_Step7_Case02 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step7_StartPaletteFade)
; reads: wPartyCount
; writes: rRAMG
; points at: wPartyList, wBattleBuffer72
BattleEnd_Step7_Case02_SRAMRecordAddress::
Func_0A3_4B0B:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList
    ld de, wBattleBuffer72

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
    farcall ClampPartyHPAndMPToMax
    xor a, a
    ld [rRAMG], a
    ret

; E-0204 (C1: RollRandomLoBelowChance_Sub01 reads the byte at $4B57 + the actor's wBattleMonsterId for the party's monsters, and every battler in link modes other than 0 and 2; RollRandomLoBelowChance (ResolveStepChanceRoll) treats 3 as 4 and returns carry when wRandomLo is below it, a chance of 0-4 in 256; 384 bytes, one per monster id).
; record: chance class 0-3
MonsterResolveChanceTable::
Data_0A3_4B57:: ; address name
    db $00 ; id 0
    db $02 ; id 1 DrakSlime
    db $02 ; id 2 SpotSlime
    db $02 ; id 3 WingSlime
    db $02 ; id 4 TreeSlime
    db $02 ; id 5 Snaily
    db $03 ; id 6 SlimeNite
    db $02 ; id 7 Babble
    db $02 ; id 8 BoxSlime
    db $02 ; id 9 PearlGel
    db $03 ; id 10 Slime
    db $02 ; id 11 Healer
    db $03 ; id 12 FangSlime
    db $02 ; id 13 RockSlime
    db $03 ; id 14 SlimeBorg
    db $02 ; id 15 Slabbit
    db $02 ; id 16 KingSlime
    db $02 ; id 17 Metaly
    db $02 ; id 18 Metabble
    db $02 ; id 19 SpotKing
    db $02 ; id 20 TropicGel
    db $02 ; id 21 MimeSlime
    db $02 ; id 22 HaloSlime
    db $01 ; id 23 MetalKing
    db $01 ; id 24 GoldSlime
    db $02 ; id 25 GranSlime
    db $01 ; id 26 WonderEgg
    db $00 ; id 27 Butch
    db $00 ; id 28 ?
    db $00 ; id 29 ?
    db $00 ; id 30 ?
    db $00 ; id 31 ?
    db $00 ; id 32 ?
    db $00 ; id 33 ?
    db $00 ; id 34 ?
    db $00 ; id 35 ?
    db $01 ; id 36 DragonKid
    db $02 ; id 37 Tortragon
    db $01 ; id 38 Pteranod
    db $01 ; id 39 Gasgon
    db $01 ; id 40 FairyDrak
    db $02 ; id 41 LizardMan
    db $01 ; id 42 Poisongon
    db $02 ; id 43 Swordgon
    db $02 ; id 44 Drygon
    db $02 ; id 45 Dragon
    db $02 ; id 46 MiniDrak
    db $00 ; id 47 MadDragon
    db $01 ; id 48 Rayburn
    db $01 ; id 49 Chamelgon
    db $01 ; id 50 LizardFly
    db $02 ; id 51 Andreal
    db $01 ; id 52 KingCobra
    db $01 ; id 53 Vampirus
    db $01 ; id 54 SnakeBat
    db $02 ; id 55 Spikerous
    db $01 ; id 56 GreatDrak
    db $02 ; id 57 Crestpent
    db $02 ; id 58 WingSnake
    db $01 ; id 59 Coatol
    db $01 ; id 60 Orochi
    db $02 ; id 61 BattleRex
    db $01 ; id 62 SkyDragon
    db $02 ; id 63 Serpentia
    db $01 ; id 64 Divinegon
    db $01 ; id 65 Orligon
    db $01 ; id 66 GigaDraco
    db $00 ; id 67 ?
    db $00 ; id 68 ?
    db $00 ; id 69 ?
    db $00 ; id 70 ?
    db $01 ; id 71 Tonguella
    db $02 ; id 72 Almiraj
    db $01 ; id 73 CatFly
    db $02 ; id 74 PillowRat
    db $02 ; id 75 Saccer
    db $02 ; id 76 GulpBeast
    db $02 ; id 77 Skullroo
    db $01 ; id 78 WindBeast
    db $01 ; id 79 Beavern
    db $01 ; id 80 Antbear
    db $01 ; id 81 SuperTen
    db $01 ; id 82 IronTurt
    db $01 ; id 83 Mommonja
    db $03 ; id 84 HammerMan
    db $01 ; id 85 Grizzly
    db $01 ; id 86 Yeti
    db $01 ; id 87 ArrowDog
    db $01 ; id 88 NoctoKing
    db $02 ; id 89 BeastNite
    db $01 ; id 90 MadGopher
    db $01 ; id 91 FairyRat
    db $01 ; id 92 Unicorn
    db $01 ; id 93 Goategon
    db $01 ; id 94 WildApe
    db $01 ; id 95 Trumpeter
    db $00 ; id 96 KingLeo
    db $02 ; id 97 DarkHorn
    db $01 ; id 98 MadCat
    db $00 ; id 99 BigEye
    db $01 ; id 100 Gorago
    db $00 ; id 101 CatMage
    db $02 ; id 102 Dumbira
    db $00 ; id 103 ?
    db $00 ; id 104 ?
    db $00 ; id 105 ?
    db $02 ; id 106 Picky
    db $02 ; id 107 Wyvern
    db $03 ; id 108 BullBird
    db $02 ; id 109 Florajay
    db $02 ; id 110 DuckKite
    db $02 ; id 111 MadPecker
    db $02 ; id 112 MadRaven
    db $02 ; id 113 MistyWing
    db $01 ; id 114 AquaHawk
    db $03 ; id 115 Dracky
    db $01 ; id 116 KiteHawk
    db $02 ; id 117 BigRoost
    db $02 ; id 118 StubBird
    db $02 ; id 119 LandOwl
    db $02 ; id 120 MadGoose
    db $02 ; id 121 MadCondor
    db $01 ; id 122 Emyu
    db $02 ; id 123 Blizzardy
    db $02 ; id 124 Phoenix
    db $02 ; id 125 ZapBird
    db $01 ; id 126 Garudian
    db $01 ; id 127 WhipBird
    db $02 ; id 128 FunkyBird
    db $01 ; id 129 RainHawk
    db $01 ; id 130 Azurile
    db $01 ; id 131 Shantak
    db $01 ; id 132 CragDevil
    db $00 ; id 133 ?
    db $00 ; id 134 ?
    db $00 ; id 135 ?
    db $00 ; id 136 ?
    db $00 ; id 137 ?
    db $00 ; id 138 ?
    db $00 ; id 139 ?
    db $00 ; id 140 ?
    db $02 ; id 141 MadPlant
    db $01 ; id 142 FireWeed
    db $02 ; id 143 FloraMan
    db $02 ; id 144 WingTree
    db $03 ; id 145 CactiBall
    db $03 ; id 146 Gulpple
    db $01 ; id 147 Toadstool
    db $02 ; id 148 AmberWeed
    db $01 ; id 149 Slurperon
    db $02 ; id 150 Stubsuck
    db $02 ; id 151 Oniono
    db $03 ; id 152 DanceVegi
    db $02 ; id 153 TreeBoy
    db $02 ; id 154 Devipine
    db $02 ; id 155 FaceTree
    db $02 ; id 156 HerbMan
    db $03 ; id 157 BeanMan
    db $02 ; id 158 EvilSeed
    db $02 ; id 159 ManEater
    db $01 ; id 160 Snapper
    db $01 ; id 161 GhosTree
    db $02 ; id 162 Rosevine
    db $02 ; id 163 Egdracil
    db $03 ; id 164 Warubou
    db $03 ; id 165 Watabou
    db $01 ; id 166 Eggplaton
    db $02 ; id 167 FooHero
    db $00 ; id 168 ?
    db $00 ; id 169 ?
    db $00 ; id 170 ?
    db $00 ; id 171 ?
    db $00 ; id 172 ?
    db $00 ; id 173 ?
    db $00 ; id 174 ?
    db $00 ; id 175 ?
    db $02 ; id 176 GiantSlug
    db $01 ; id 177 Catapila
    db $02 ; id 178 Gophecada
    db $02 ; id 179 Butterfly
    db $02 ; id 180 WeedBug
    db $02 ; id 181 GiantWorm
    db $01 ; id 182 Lipsy
    db $01 ; id 183 StagBug
    db $01 ; id 184 Pyuro
    db $02 ; id 185 ArmyAnt
    db $03 ; id 186 GoHopper
    db $02 ; id 187 TailEater
    db $01 ; id 188 ArmorPede
    db $01 ; id 189 Eyeder
    db $01 ; id 190 GiantMoth
    db $02 ; id 191 Droll
    db $02 ; id 192 ArmyCrab
    db $01 ; id 193 MadHornet
    db $03 ; id 194 Belzebub
    db $01 ; id 195 WarMantis
    db $01 ; id 196 HornBeet
    db $01 ; id 197 Sickler
    db $01 ; id 198 Armorpion
    db $01 ; id 199 Digster
    db $01 ; id 200 Skularach
    db $01 ; id 201 MultiEyes
    db $00 ; id 202 ?
    db $00 ; id 203 ?
    db $00 ; id 204 ?
    db $00 ; id 205 ?
    db $00 ; id 206 ?
    db $00 ; id 207 ?
    db $00 ; id 208 ?
    db $00 ; id 209 ?
    db $00 ; id 210 ?
    db $01 ; id 211 Pixy
    db $01 ; id 212 MedusaEye
    db $01 ; id 213 AgDevil
    db $01 ; id 214 Demonite
    db $01 ; id 215 DarkEye
    db $01 ; id 216 EyeBall
    db $01 ; id 217 SkulRider
    db $01 ; id 218 EvilBeast
    db $01 ; id 219 Bubblemon
    db $01 ; id 220 1EyeClown
    db $01 ; id 221 Gremlin
    db $01 ; id 222 ArcDemon
    db $01 ; id 223 Lionex
    db $02 ; id 224 GoatHorn
    db $01 ; id 225 Orc
    db $02 ; id 226 Ogre
    db $01 ; id 227 GateGuard
    db $01 ; id 228 ChopClown
    db $03 ; id 229 BossTroll
    db $02 ; id 230 Grendal
    db $01 ; id 231 Akubar
    db $02 ; id 232 MadKnight
    db $01 ; id 233 EvilWell
    db $03 ; id 234 Gigantes
    db $02 ; id 235 Centasaur
    db $01 ; id 236 EvilArmor
    db $02 ; id 237 Jamirus
    db $00 ; id 238 Durran
    db $01 ; id 239 Titanis
    db $01 ; id 240 LampGenie
    db $00 ; id 241 ?
    db $00 ; id 242 ?
    db $00 ; id 243 ?
    db $00 ; id 244 ?
    db $00 ; id 245 ?
    db $02 ; id 246 Spooky
    db $01 ; id 247 Skullgon
    db $02 ; id 248 PutrePup
    db $02 ; id 249 RotRaven
    db $02 ; id 250 Mummy
    db $01 ; id 251 DarkCrab
    db $01 ; id 252 DeadNite
    db $02 ; id 253 Shadow
    db $01 ; id 254 Skulpent
    db $02 ; id 255 Hork
    db $02 ; id 256 Mudron
    db $02 ; id 257 NiteWhip
    db $01 ; id 258 WindMerge
    db $01 ; id 259 Reaper
    db $01 ; id 260 Inverzon
    db $01 ; id 261 FoxFire
    db $01 ; id 262 CaptDead
    db $01 ; id 263 DeadNoble
    db $01 ; id 264 WhiteKing
    db $02 ; id 265 BoneSlave
    db $01 ; id 266 Skeletor
    db $00 ; id 267 Servant
    db $01 ; id 268 Lazamanus
    db $02 ; id 269 Copycat
    db $02 ; id 270 MadSpirit
    db $00 ; id 271 PomPomBom
    db $02 ; id 272 Niterich
    db $00 ; id 273 ?
    db $00 ; id 274 ?
    db $00 ; id 275 ?
    db $00 ; id 276 ?
    db $00 ; id 277 ?
    db $00 ; id 278 ?
    db $00 ; id 279 ?
    db $00 ; id 280 ?
    db $02 ; id 281 JewelBag
    db $01 ; id 282 EvilWand
    db $02 ; id 283 MadCandle
    db $02 ; id 284 CoilBird
    db $02 ; id 285 Facer
    db $02 ; id 286 SpikyBoy
    db $02 ; id 287 MadMirror
    db $01 ; id 288 RogueNite
    db $01 ; id 289 Puppetor
    db $02 ; id 290 Goopi
    db $02 ; id 291 Voodoll
    db $01 ; id 292 MetalDrak
    db $01 ; id 293 Balzak
    db $02 ; id 294 SabreMan
    db $02 ; id 295 CurseLamp
    db $01 ; id 296 Brushead
    db $01 ; id 297 Roboster
    db $02 ; id 298 Roboster2
    db $02 ; id 299 EvilPot
    db $02 ; id 300 Gismo
    db $01 ; id 301 LavaMan
    db $01 ; id 302 IceMan
    db $03 ; id 303 Mimic
    db $01 ; id 304 Exaucers
    db $02 ; id 305 MudDoll
    db $01 ; id 306 Golem
    db $01 ; id 307 StoneMan
    db $02 ; id 308 BombCrag
    db $00 ; id 309 GoldGolem
    db $01 ; id 310 DarkMate
    db $02 ; id 311 ProtoMech
    db $01 ; id 312 CloudKing
    db $00 ; id 313 ?
    db $00 ; id 314 ?
    db $00 ; id 315 ?
    db $01 ; id 316 Petiteel
    db $01 ; id 317 Moray
    db $03 ; id 318 WalrusMan
    db $01 ; id 319 RayGigas
    db $01 ; id 320 Anemon
    db $01 ; id 321 Aquarella
    db $01 ; id 322 Merman
    db $01 ; id 323 Octokid
    db $00 ; id 324 PutreFish
    db $02 ; id 325 Octoreach
    db $02 ; id 326 Angleron
    db $01 ; id 327 FishRider
    db $03 ; id 328 RushFish
    db $01 ; id 329 Gamanian
    db $02 ; id 330 Clawster
    db $02 ; id 331 CancerMan
    db $01 ; id 332 RogueWave
    db $01 ; id 333 Scallopa
    db $01 ; id 334 SeaHorse
    db $02 ; id 335 HoodSquid
    db $01 ; id 336 MerTiger
    db $02 ; id 337 AxeShark
    db $02 ; id 338 Octogon
    db $02 ; id 339 KingSquid
    db $01 ; id 340 Digong
    db $01 ; id 341 WhaleMage
    db $01 ; id 342 Aquadon
    db $01 ; id 343 Octoraid
    db $01 ; id 344 Grakos
    db $01 ; id 345 Poseidon
    db $01 ; id 346 Pumpoise
    db $00 ; id 347 Starfish
    db $00 ; id 348 ?
    db $00 ; id 349 ?
    db $00 ; id 350 ?
    db $01 ; id 351 DracoLord
    db $01 ; id 352 DracoLord
    db $00 ; id 353 LordDraco
    db $01 ; id 354 Hargon
    db $00 ; id 355 Sidoh
    db $00 ; id 356 Genosidoh
    db $01 ; id 357 Baramos
    db $00 ; id 358 Zoma
    db $00 ; id 359 AsuraZoma
    db $01 ; id 360 Pizzaro
    db $00 ; id 361 PsychoPiz
    db $01 ; id 362 Esterk
    db $01 ; id 363 Mirudraas
    db $00 ; id 364 Mirudraas
    db $01 ; id 365 Mudou
    db $01 ; id 366 DeathMore
    db $00 ; id 367 DeathMore
    db $00 ; id 368 DeathMore
    db $00 ; id 369 Darkdrium
    db $02 ; id 370 Orgodemir
    db $01 ; id 371 Orgodemir
    db $00 ; id 372 Darck
    db $02 ; id 373 Tatsu
    db $02 ; id 374 Diago
    db $01 ; id 375 Samsi
    db $01 ; id 376 Bazoo
    db $02 ; id 377 ?
    db $00 ; id 378 ?
    db $00 ; id 379 ?
    db $00 ; id 380 Lamia
    db $00 ; id 381 Dimensaur
    db $03 ; id 382 Kagebou
    db $00 ; id 383 ?

; E-0204 (C1: RollRandomLoBelowChance_Sub01 reads the byte at $4CD7 + the actor's wBattleMonsterId for battlers 4 and up (the foes) outside link play (wLinkMode 0 or 2); RollRandomLoBelowChance (ResolveStepChanceRoll) treats 3 as 4 and returns carry when wRandomLo is below it, a chance of 0-4 in 256; 384 bytes, one per monster id).
; record: chance class 0-3
MonsterResolveChanceTable_Foes::
Data_0A3_4CD7:: ; address name
    db $00 ; id 0
    db $00 ; id 1 DrakSlime
    db $00 ; id 2 SpotSlime
    db $01 ; id 3 WingSlime
    db $00 ; id 4 TreeSlime
    db $00 ; id 5 Snaily
    db $01 ; id 6 SlimeNite
    db $00 ; id 7 Babble
    db $00 ; id 8 BoxSlime
    db $00 ; id 9 PearlGel
    db $00 ; id 10 Slime
    db $00 ; id 11 Healer
    db $00 ; id 12 FangSlime
    db $00 ; id 13 RockSlime
    db $00 ; id 14 SlimeBorg
    db $01 ; id 15 Slabbit
    db $01 ; id 16 KingSlime
    db $00 ; id 17 Metaly
    db $00 ; id 18 Metabble
    db $01 ; id 19 SpotKing
    db $00 ; id 20 TropicGel
    db $00 ; id 21 MimeSlime
    db $00 ; id 22 HaloSlime
    db $00 ; id 23 MetalKing
    db $00 ; id 24 GoldSlime
    db $00 ; id 25 GranSlime
    db $00 ; id 26 WonderEgg
    db $00 ; id 27 Butch
    db $00 ; id 28 ?
    db $00 ; id 29 ?
    db $00 ; id 30 ?
    db $00 ; id 31 ?
    db $00 ; id 32 ?
    db $00 ; id 33 ?
    db $00 ; id 34 ?
    db $00 ; id 35 ?
    db $00 ; id 36 DragonKid
    db $01 ; id 37 Tortragon
    db $01 ; id 38 Pteranod
    db $01 ; id 39 Gasgon
    db $00 ; id 40 FairyDrak
    db $01 ; id 41 LizardMan
    db $01 ; id 42 Poisongon
    db $01 ; id 43 Swordgon
    db $01 ; id 44 Drygon
    db $00 ; id 45 Dragon
    db $00 ; id 46 MiniDrak
    db $00 ; id 47 MadDragon
    db $01 ; id 48 Rayburn
    db $01 ; id 49 Chamelgon
    db $01 ; id 50 LizardFly
    db $01 ; id 51 Andreal
    db $01 ; id 52 KingCobra
    db $01 ; id 53 Vampirus
    db $01 ; id 54 SnakeBat
    db $01 ; id 55 Spikerous
    db $01 ; id 56 GreatDrak
    db $00 ; id 57 Crestpent
    db $00 ; id 58 WingSnake
    db $01 ; id 59 Coatol
    db $00 ; id 60 Orochi
    db $01 ; id 61 BattleRex
    db $00 ; id 62 SkyDragon
    db $01 ; id 63 Serpentia
    db $00 ; id 64 Divinegon
    db $00 ; id 65 Orligon
    db $01 ; id 66 GigaDraco
    db $00 ; id 67 ?
    db $00 ; id 68 ?
    db $00 ; id 69 ?
    db $00 ; id 70 ?
    db $00 ; id 71 Tonguella
    db $00 ; id 72 Almiraj
    db $01 ; id 73 CatFly
    db $00 ; id 74 PillowRat
    db $00 ; id 75 Saccer
    db $01 ; id 76 GulpBeast
    db $00 ; id 77 Skullroo
    db $01 ; id 78 WindBeast
    db $01 ; id 79 Beavern
    db $00 ; id 80 Antbear
    db $01 ; id 81 SuperTen
    db $01 ; id 82 IronTurt
    db $01 ; id 83 Mommonja
    db $01 ; id 84 HammerMan
    db $01 ; id 85 Grizzly
    db $01 ; id 86 Yeti
    db $00 ; id 87 ArrowDog
    db $01 ; id 88 NoctoKing
    db $02 ; id 89 BeastNite
    db $01 ; id 90 MadGopher
    db $00 ; id 91 FairyRat
    db $00 ; id 92 Unicorn
    db $01 ; id 93 Goategon
    db $00 ; id 94 WildApe
    db $01 ; id 95 Trumpeter
    db $02 ; id 96 KingLeo
    db $01 ; id 97 DarkHorn
    db $00 ; id 98 MadCat
    db $00 ; id 99 BigEye
    db $01 ; id 100 Gorago
    db $00 ; id 101 CatMage
    db $02 ; id 102 Dumbira
    db $00 ; id 103 ?
    db $00 ; id 104 ?
    db $00 ; id 105 ?
    db $00 ; id 106 Picky
    db $01 ; id 107 Wyvern
    db $01 ; id 108 BullBird
    db $00 ; id 109 Florajay
    db $00 ; id 110 DuckKite
    db $00 ; id 111 MadPecker
    db $01 ; id 112 MadRaven
    db $01 ; id 113 MistyWing
    db $00 ; id 114 AquaHawk
    db $01 ; id 115 Dracky
    db $00 ; id 116 KiteHawk
    db $00 ; id 117 BigRoost
    db $00 ; id 118 StubBird
    db $00 ; id 119 LandOwl
    db $01 ; id 120 MadGoose
    db $01 ; id 121 MadCondor
    db $01 ; id 122 Emyu
    db $01 ; id 123 Blizzardy
    db $01 ; id 124 Phoenix
    db $01 ; id 125 ZapBird
    db $01 ; id 126 Garudian
    db $00 ; id 127 WhipBird
    db $00 ; id 128 FunkyBird
    db $01 ; id 129 RainHawk
    db $01 ; id 130 Azurile
    db $01 ; id 131 Shantak
    db $00 ; id 132 CragDevil
    db $00 ; id 133 ?
    db $00 ; id 134 ?
    db $00 ; id 135 ?
    db $00 ; id 136 ?
    db $00 ; id 137 ?
    db $00 ; id 138 ?
    db $00 ; id 139 ?
    db $00 ; id 140 ?
    db $01 ; id 141 MadPlant
    db $00 ; id 142 FireWeed
    db $00 ; id 143 FloraMan
    db $00 ; id 144 WingTree
    db $01 ; id 145 CactiBall
    db $01 ; id 146 Gulpple
    db $00 ; id 147 Toadstool
    db $00 ; id 148 AmberWeed
    db $01 ; id 149 Slurperon
    db $00 ; id 150 Stubsuck
    db $00 ; id 151 Oniono
    db $00 ; id 152 DanceVegi
    db $01 ; id 153 TreeBoy
    db $01 ; id 154 Devipine
    db $00 ; id 155 FaceTree
    db $00 ; id 156 HerbMan
    db $00 ; id 157 BeanMan
    db $00 ; id 158 EvilSeed
    db $01 ; id 159 ManEater
    db $01 ; id 160 Snapper
    db $01 ; id 161 GhosTree
    db $01 ; id 162 Rosevine
    db $01 ; id 163 Egdracil
    db $02 ; id 164 Warubou
    db $02 ; id 165 Watabou
    db $00 ; id 166 Eggplaton
    db $01 ; id 167 FooHero
    db $00 ; id 168 ?
    db $00 ; id 169 ?
    db $00 ; id 170 ?
    db $00 ; id 171 ?
    db $00 ; id 172 ?
    db $00 ; id 173 ?
    db $00 ; id 174 ?
    db $00 ; id 175 ?
    db $00 ; id 176 GiantSlug
    db $00 ; id 177 Catapila
    db $00 ; id 178 Gophecada
    db $00 ; id 179 Butterfly
    db $00 ; id 180 WeedBug
    db $00 ; id 181 GiantWorm
    db $00 ; id 182 Lipsy
    db $00 ; id 183 StagBug
    db $00 ; id 184 Pyuro
    db $01 ; id 185 ArmyAnt
    db $00 ; id 186 GoHopper
    db $01 ; id 187 TailEater
    db $01 ; id 188 ArmorPede
    db $01 ; id 189 Eyeder
    db $01 ; id 190 GiantMoth
    db $01 ; id 191 Droll
    db $01 ; id 192 ArmyCrab
    db $01 ; id 193 MadHornet
    db $00 ; id 194 Belzebub
    db $00 ; id 195 WarMantis
    db $01 ; id 196 HornBeet
    db $01 ; id 197 Sickler
    db $01 ; id 198 Armorpion
    db $00 ; id 199 Digster
    db $00 ; id 200 Skularach
    db $01 ; id 201 MultiEyes
    db $00 ; id 202 ?
    db $00 ; id 203 ?
    db $00 ; id 204 ?
    db $00 ; id 205 ?
    db $00 ; id 206 ?
    db $00 ; id 207 ?
    db $00 ; id 208 ?
    db $00 ; id 209 ?
    db $00 ; id 210 ?
    db $00 ; id 211 Pixy
    db $00 ; id 212 MedusaEye
    db $01 ; id 213 AgDevil
    db $01 ; id 214 Demonite
    db $01 ; id 215 DarkEye
    db $00 ; id 216 EyeBall
    db $01 ; id 217 SkulRider
    db $01 ; id 218 EvilBeast
    db $01 ; id 219 Bubblemon
    db $00 ; id 220 1EyeClown
    db $00 ; id 221 Gremlin
    db $01 ; id 222 ArcDemon
    db $00 ; id 223 Lionex
    db $01 ; id 224 GoatHorn
    db $00 ; id 225 Orc
    db $01 ; id 226 Ogre
    db $01 ; id 227 GateGuard
    db $01 ; id 228 ChopClown
    db $03 ; id 229 BossTroll
    db $01 ; id 230 Grendal
    db $00 ; id 231 Akubar
    db $01 ; id 232 MadKnight
    db $00 ; id 233 EvilWell
    db $02 ; id 234 Gigantes
    db $00 ; id 235 Centasaur
    db $00 ; id 236 EvilArmor
    db $00 ; id 237 Jamirus
    db $00 ; id 238 Durran
    db $00 ; id 239 Titanis
    db $01 ; id 240 LampGenie
    db $00 ; id 241 ?
    db $00 ; id 242 ?
    db $00 ; id 243 ?
    db $00 ; id 244 ?
    db $00 ; id 245 ?
    db $00 ; id 246 Spooky
    db $01 ; id 247 Skullgon
    db $01 ; id 248 PutrePup
    db $01 ; id 249 RotRaven
    db $01 ; id 250 Mummy
    db $01 ; id 251 DarkCrab
    db $01 ; id 252 DeadNite
    db $01 ; id 253 Shadow
    db $00 ; id 254 Skulpent
    db $00 ; id 255 Hork
    db $00 ; id 256 Mudron
    db $00 ; id 257 NiteWhip
    db $00 ; id 258 WindMerge
    db $01 ; id 259 Reaper
    db $00 ; id 260 Inverzon
    db $00 ; id 261 FoxFire
    db $00 ; id 262 CaptDead
    db $01 ; id 263 DeadNoble
    db $01 ; id 264 WhiteKing
    db $01 ; id 265 BoneSlave
    db $01 ; id 266 Skeletor
    db $00 ; id 267 Servant
    db $01 ; id 268 Lazamanus
    db $00 ; id 269 Copycat
    db $00 ; id 270 MadSpirit
    db $00 ; id 271 PomPomBom
    db $00 ; id 272 Niterich
    db $00 ; id 273 ?
    db $00 ; id 274 ?
    db $00 ; id 275 ?
    db $00 ; id 276 ?
    db $00 ; id 277 ?
    db $00 ; id 278 ?
    db $00 ; id 279 ?
    db $00 ; id 280 ?
    db $00 ; id 281 JewelBag
    db $01 ; id 282 EvilWand
    db $00 ; id 283 MadCandle
    db $00 ; id 284 CoilBird
    db $01 ; id 285 Facer
    db $01 ; id 286 SpikyBoy
    db $00 ; id 287 MadMirror
    db $01 ; id 288 RogueNite
    db $00 ; id 289 Puppetor
    db $00 ; id 290 Goopi
    db $01 ; id 291 Voodoll
    db $00 ; id 292 MetalDrak
    db $01 ; id 293 Balzak
    db $00 ; id 294 SabreMan
    db $01 ; id 295 CurseLamp
    db $00 ; id 296 Brushead
    db $00 ; id 297 Roboster
    db $01 ; id 298 Roboster2
    db $00 ; id 299 EvilPot
    db $00 ; id 300 Gismo
    db $01 ; id 301 LavaMan
    db $01 ; id 302 IceMan
    db $01 ; id 303 Mimic
    db $00 ; id 304 Exaucers
    db $00 ; id 305 MudDoll
    db $00 ; id 306 Golem
    db $01 ; id 307 StoneMan
    db $03 ; id 308 BombCrag
    db $00 ; id 309 GoldGolem
    db $00 ; id 310 DarkMate
    db $01 ; id 311 ProtoMech
    db $00 ; id 312 CloudKing
    db $00 ; id 313 ?
    db $00 ; id 314 ?
    db $00 ; id 315 ?
    db $00 ; id 316 Petiteel
    db $00 ; id 317 Moray
    db $00 ; id 318 WalrusMan
    db $01 ; id 319 RayGigas
    db $00 ; id 320 Anemon
    db $00 ; id 321 Aquarella
    db $00 ; id 322 Merman
    db $00 ; id 323 Octokid
    db $00 ; id 324 PutreFish
    db $01 ; id 325 Octoreach
    db $00 ; id 326 Angleron
    db $01 ; id 327 FishRider
    db $00 ; id 328 RushFish
    db $00 ; id 329 Gamanian
    db $01 ; id 330 Clawster
    db $01 ; id 331 CancerMan
    db $00 ; id 332 RogueWave
    db $00 ; id 333 Scallopa
    db $00 ; id 334 SeaHorse
    db $00 ; id 335 HoodSquid
    db $00 ; id 336 MerTiger
    db $01 ; id 337 AxeShark
    db $01 ; id 338 Octogon
    db $01 ; id 339 KingSquid
    db $01 ; id 340 Digong
    db $00 ; id 341 WhaleMage
    db $00 ; id 342 Aquadon
    db $01 ; id 343 Octoraid
    db $00 ; id 344 Grakos
    db $00 ; id 345 Poseidon
    db $01 ; id 346 Pumpoise
    db $00 ; id 347 Starfish
    db $00 ; id 348 ?
    db $00 ; id 349 ?
    db $00 ; id 350 ?
    db $00 ; id 351 DracoLord
    db $00 ; id 352 DracoLord
    db $00 ; id 353 LordDraco
    db $00 ; id 354 Hargon
    db $00 ; id 355 Sidoh
    db $00 ; id 356 Genosidoh
    db $00 ; id 357 Baramos
    db $00 ; id 358 Zoma
    db $00 ; id 359 AsuraZoma
    db $00 ; id 360 Pizzaro
    db $00 ; id 361 PsychoPiz
    db $00 ; id 362 Esterk
    db $00 ; id 363 Mirudraas
    db $00 ; id 364 Mirudraas
    db $00 ; id 365 Mudou
    db $00 ; id 366 DeathMore
    db $00 ; id 367 DeathMore
    db $00 ; id 368 DeathMore
    db $00 ; id 369 Darkdrium
    db $01 ; id 370 Orgodemir
    db $01 ; id 371 Orgodemir
    db $00 ; id 372 Darck
    db $00 ; id 373 Tatsu
    db $00 ; id 374 Diago
    db $00 ; id 375 Samsi
    db $00 ; id 376 Bazoo
    db $00 ; id 377 ?
    db $00 ; id 378 ?
    db $00 ; id 379 ?
    db $00 ; id 380 Lamia
    db $00 ; id 381 Dimensaur
    db $03 ; id 382 Kagebou
    db $00 ; id 383 ?
    ds $31A9, $00
