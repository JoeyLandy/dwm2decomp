SECTION "Bank 60", ROMX[$4000], BANK[$60]
    db $60

; only called from RunWC46BMenuState_Case05 (E-0047)
; 1 call site from 1 routine (e.g. RunWC46BMenuState_Case05)
; reads: wC833, hFFC6
; writes: wCC42, wCD03, wCD04
; points at: wC787
RunWC46BMenuState_Case05_Sub01::
Func_060_4001:: ; address name
    ld a, [wC833]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    push hl
    call FindSRAMSlotMarkerIndex
    pop hl
    ldh a, [hFFC6]
    cp a, $FF
    ret z
    ld [wCC42], a
    or a, $80
    ld [hl], a
    ld a, [wC833]
    add a, a
    ld hl, wC787
    add_a_to_hl
    ld a, [hl+]
    ld [wCD03], a
    ld a, [hl]
    ld [wCD04], a

; only called from DebugAutomap_Update_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01)
; reads: wC833
DebugAutomap_Update_Sub01_Sub01::
Func_060_4035:: ; address name
    call DebugAutomap_Update_Sub01_Sub01_Sub02
    call DebugAutomap_Update_Sub01_Sub01_Sub03
    call DebugAutomap_Update_Sub01_Sub01_Sub05
    call DebugAutomap_Update_Sub01_Sub01_Sub04
    call DebugAutomap_Update_Sub01_Sub01_Sub06
    call DebugAutomap_Update_Sub01_Sub01_Sub07
    call DebugAutomap_Update_Sub01_Sub01_Sub09
    or a, a
    jr nz, DebugAutomap_Update_Sub01_Sub01
    farcall DebugAutomap_Update_Sub01_Sub01_Sub0C
    call DebugAutomap_Update_Sub01_Sub01_Sub08
    call DebugAutomap_Update_Sub01_Sub01_Sub0A
    call DebugAutomap_Update_Sub01_Sub01_Sub01
    call DebugAutomap_Update_Sub01_Sub01_Sub0B
    ld a, [wC833]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [hl]
    and a, $BF
    or a, $80
    ld [hl], a
    ret

; only called from DebugAutomap_Update_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01)
DebugAutomap_Update_Sub01_Sub01_Sub01::
Func_060_4076:: ; address name
    call LoadWC969TripleForWCD05
    call LoadKeyWorldParamsForWC833
    call Func_060_408F
    call FillWCD11LevelsForWCD05
    call Func_060_4274
    call FillWCD51LevelsSlope
    call RollKeyWorldMonsterIds
    call RollKeyWorldEncounterTable
    ret

; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_Sub01)
; reads: wCD02, wCD04, hFFC6, hFFC7
; writes: hFFC6, hFFC7
; points at: wCD10, wCCF7
Func_060_408F::
    ld b, $20
    ld de, wCD10
    ld a, e
    ldh [hFFC6], a
    ld a, d
    ldh [hFFC7], a

Jump_060_409A::
    ld hl, wCCF7

Jump_060_409D::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_060_409A
    push hl
    push af
    ld a, [wCD02]
    cp a, $10
    jr c, Jump_060_40AD
    ld a, $10

Jump_060_40AD::
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $23
    ld e, a
    ld a, d
    adc a, $41
    ld d, a
    call NextRandomSeed
    ld a, [wCD04]
    and a, $0F
    add a, e
    ld e, a
    jr nc, Jump_060_40D5
    inc d

Jump_060_40D5::
    ld a, [de]
    add a, a
    ld c, a
    pop af
    swap a
    ld de, Data_060_6D6D
    add a, e
    ld e, a
    jr nc, Jump_060_40E3
    inc d

Jump_060_40E3::
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_060_40E9
    inc d

Jump_060_40E9::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [hl+]
    or a, a
    jr nz, Jump_060_40F5
    pop hl
    jr Jump_060_409D

Jump_060_40F5::
    dec a
    jr z, Jump_060_4105
    inc a
    ld c, a

Jump_060_40FA::
    call NextRandomSeed
    ld a, [wCD04]
    and a, $07
    cp a, c
    jr nc, Jump_060_40FA

Jump_060_4105::
    add a, a
    add_a_to_hl
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    inc de
    ld a, e
    ldh [hFFC6], a
    ld a, d
    ldh [hFFC7], a
    pop hl
    dec b
    jp nz, Jump_060_409D
    ret

Data_060_4123:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $21, $00
    INCBIN "dwm2-cobi-us.gbc", $180144, $EF

; for 32 entries from wCD11 ORs 2 * min(wC969 + (32 - n) * (wCD05 + 10) / 150 / 2, 99) into every other byte (E-0125)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_Sub01)
; reads: wC969, wCD05
; points at: wCD11
FillWCD11LevelsForWCD05::
Func_060_4233:: ; address name
    ld b, $20
    ld de, wCD11
    ld a, [wC969]
    ld c, a

Jump_060_423C::
    push bc
    push bc
    push de
    ld a, $20
    sub a, b
    ld c, a
    ld a, [wCD05]
    add a, $0A
    call Multiply8
    ld a, $96
    call DivideHLByA
    sra h
    rr l
    pop de
    pop bc
    ld a, c
    add_a_to_hl
    ld a, h
    or a, a
    jr nz, Jump_060_4265
    ld a, l
    cp a, $64
    jr c, Jump_060_4267

Jump_060_4265::
    ld l, $63

Jump_060_4267::
    ld c, l
    sla c
    ld a, [de]
    or a, c
    ld [de], a
    inc de
    inc de
    pop bc
    dec b
    jr nz, Jump_060_423C
    ret

; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_Sub01)
; reads: wCD04, wCD02, hFFC6, hFFC7
; writes: hFFC6, hFFC7
; points at: wCD10
Func_060_4274::
    ld b, $08
    ld a, $40
    ld de, wCD10
    add a, e
    ld e, a
    jr nc, Jump_060_4280
    inc d

Jump_060_4280::
    ld a, e
    ldh [hFFC6], a
    ld a, d
    ldh [hFFC7], a

Jump_060_4286::
    ld a, $09
    swap a
    ld de, Data_060_6D6D
    add a, e
    ld e, a
    jr nc, Jump_060_4292
    inc d

Jump_060_4292::
    push de
    call NextRandomSeed
    ld a, [wCD04]
    and a, $07
    ld de, Data_060_4123
    add a, e
    ld e, a
    jr nc, Jump_060_42A3
    inc d

Jump_060_42A3::
    ld a, [wCD02]
    sla a
    sla a
    sla a
    add a, e
    ld e, a
    jr nc, Jump_060_42B1
    inc d

Jump_060_42B1::
    ld a, [de]
    add a, a
    pop de
    add a, e
    ld e, a
    jr nc, Jump_060_42B9
    inc d

Jump_060_42B9::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [hl+]
    or a, a
    jr nz, Jump_060_42C4
    jr Jump_060_4286

Jump_060_42C4::
    dec a
    jr z, Jump_060_42D4
    inc a
    ld c, a

Jump_060_42C9::
    call NextRandomSeed
    ld a, [wCD04]
    and a, $07
    cp a, c
    jr nc, Jump_060_42C9

Jump_060_42D4::
    sla a
    add_a_to_hl
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    inc de
    ld a, e
    ldh [hFFC6], a
    ld a, d
    ldh [hFFC7], a
    dec b
    jp nz, Jump_060_4286
    ret

; for 8 entries from wCD51 ORs 2 * min(wC969 + 15 * (wCD05 + 10) / 150 / 2, 99) into every other byte (E-0127)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_Sub01)
; reads: wC969, wCD05
; points at: wCD11
FillWCD51LevelsSlope::
Func_060_42F2:: ; address name
    ld b, $08
    ld a, $40
    ld de, wCD11
    add a, e
    ld e, a
    jr nc, Jump_060_42FE
    inc d

Jump_060_42FE::
    ld a, [wC969]
    ld c, a

Jump_060_4302::
    push bc
    push bc
    push de
    ld c, $0F
    ld a, [wCD05]
    add a, $0A
    call Multiply8
    ld a, $96
    call DivideHLByA
    sra h
    rr l
    pop de
    pop bc
    ld a, c
    add_a_to_hl
    ld a, h
    or a, a
    jr nz, Jump_060_4329
    ld a, l
    cp a, $64
    jr c, Jump_060_432B

Jump_060_4329::
    ld l, $63

Jump_060_432B::
    ld c, l
    sla c
    ld a, [de]
    or a, c
    ld [de], a
    inc de
    inc de
    pop bc
    dec b
    jr nz, Jump_060_4302
    ret

; for 8 entries from wCD51 ORs 2 * min(wCD05 + 3 * (wCD05 / 10), 99) into every other byte (E-0125)
; no direct call (reached through a table, a jump or a vector)
; reads: wCD05
; points at: wCD11
FillWCD51LevelsForWCD05:: ; heuristic: follows a terminator; C0
Func_060_4338:: ; address name
    ld a, [wCD05]
    ld b, a
    ld a, $0A
    call DivideBByA
    ld a, b
    add a, a
    add a, b
    ld c, a
    ld a, [wCD05]
    add a, c
    ld c, a
    ld b, $08
    ld a, $40
    ld de, wCD11
    add a, e
    ld e, a
    jr nc, Jump_060_4356
    inc d

Jump_060_4356::
    ld a, c
    cp a, $64
    jr c, Jump_060_435E
    ld a, $63
    ld c, a

Jump_060_435E::
    push bc
    sla c
    ld a, [de]
    or a, c
    ld [de], a
    inc de
    inc de
    pop bc
    dec b
    jr nz, Jump_060_4356
    ret

; from the wC708 entry wC833: wCD02 = Data_060_43C7[byte 0] plus a row adjustment, and copies the $FF-terminated list of Data_060_43D7 row byte 1 to wCCF7 (E-0127)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_Sub01)
; reads: wC833, wCD02
; writes: wCD02
; points at: wCCF7
LoadKeyWorldParamsForWC833::
Func_060_436B:: ; address name
    ld a, [wC833]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [hl]
    ld de, wCCF7
    push hl
    ld hl, Data_060_43C7
    add_a_to_hl
    ld a, [hl]
    ld [wCD02], a
    pop hl
    inc hl
    ld a, [hl]
    ld l, a
    ld h, $00
    sla l
    rl h
    sla l
    rl h
    sla l
    rl h
    ld de, Data_060_43D7
    add hl, de
    ld de, wCCF7
    push hl

Jump_060_43A6::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_060_43AF
    ld [de], a
    inc de
    jr Jump_060_43A6

Jump_060_43AF::
    ld [de], a
    pop hl
    ld a, $06
    add_a_to_hl
    ld a, [wCD02]
    ld c, a
    ld a, [hl]
    add a, c
    bit 7, a
    jr z, Jump_060_43C3
    xor a, a

Jump_060_43C3::
    ld [wCD02], a
    ret

Data_060_43C7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FE, $FF, $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D

Data_060_43D7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $1803D7, $1C0

; clears wCE7B ($10 bytes) and fills a 4-byte entry per map area (from wCD7B) with a random monster id and level from the band lists (E-0128)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_Sub01)
; reads: wCD05, wC96A, hFFC8
; writes: hFFC6, hFFC8
; points at: wCE7B, wCD7B, wCD74
RollKeyWorldEncounterTable::
Func_060_4597:: ; address name
    ld b, $10
    ld hl, wCE7B
    xor a, a

Jump_060_459D::
    ld [hl+], a
    dec b
    jr nz, Jump_060_459D
    ld a, [wCD05]
    call BandForA_4773
    dec a
    dec a
    bit 7, a
    jr z, Jump_060_45AE
    xor a, a

Jump_060_45AE::
    ldh [hFFC6], a
    ld hl, wCD7B
    ld de, wCE7B

Jump_060_45B6::
    ld a, [hl]
    cp a, $FF
    ret z
    push hl
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    and a, $F0
    swap a
    srl a
    srl a
    ld c, a
    ld a, [hl]
    and a, $0F
    srl a
    srl a
    add a, a
    add a, c
    ld hl, wCD74
    add_a_to_hl
    ld a, [hl]
    and a, $F0
    swap a
    add a, a
    ld c, a
    ld a, [wC96A]
    add a, c
    ldh [hFFC8], a
    push de

Jump_060_45E7::
    call PickRandomWCCF7Entry
    call PickRandomMonsterFromBandList
    jr nc, Jump_060_45E7
    ld l, e
    ld h, d
    pop de
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    inc de
    ldh a, [hFFC8]
    ld [de], a
    inc de
    xor a, a
    ld [de], a
    inc de
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jp Jump_060_45B6

; no direct call (reached through a table, a jump or a vector)
; reads: wCD05, hFFC8
; writes: hFFC6, hFFC8
; points at: wCE7B, wCD7B, wCD74
Func_060_4607:: ; heuristic: follows a terminator; C0
    ld b, $10
    ld hl, wCE7B
    xor a, a

Jump_060_460D::
    ld [hl+], a
    dec b
    jr nz, Jump_060_460D
    ld a, [wCD05]
    call BandForA_4773
    dec a
    dec a
    bit 7, a
    jr z, Jump_060_461E
    xor a, a

Jump_060_461E::
    ldh [hFFC6], a
    ld hl, wCD7B
    ld de, wCE7B

Jump_060_4626::
    ld a, [hl]
    cp a, $FF
    ret z
    push hl
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    and a, $F0
    swap a
    srl a
    srl a
    ld c, a
    ld a, [hl]
    and a, $0F
    srl a
    srl a
    add a, a
    add a, c
    ld hl, wCD74
    add_a_to_hl
    ld a, [hl]
    and a, $F0
    swap a
    add a, a
    push hl
    push de
    push af
    ld a, [wCD05]
    ld b, a
    ld a, $05
    call DivideBByA
    ld a, b
    ld c, $07
    call Multiply8
    pop af
    add_a_to_hl
    ld a, h
    or a, a
    jr nz, Jump_060_4670
    ld a, l
    cp a, $64
    jr c, Jump_060_4672

Jump_060_4670::
    ld l, $63

Jump_060_4672::
    ld a, l
    pop de
    pop hl
    ldh [hFFC8], a
    push de

Jump_060_4678::
    call PickRandomWCCF7Entry
    call PickRandomMonsterFromBandList
    jr nc, Jump_060_4678
    ld l, e
    ld h, d
    pop de
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    inc de
    ldh a, [hFFC8]
    ld [de], a
    inc de
    xor a, a
    ld [de], a
    inc de
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jp Jump_060_4626

; picks random monster ids for the key world from the wCCF7 lists by band (Func_060_4724) into wCE72-wCE79, and wCE74/wCE77/wCE7A from wC96B (E-0127)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_Sub01)
; reads: wCD05, wCD03, wC96B, hFFC6
; writes: hFFC6, wCE72, wCE73, wCE75, wCE76, wCE78, wCE79, wCE74, ...
RollKeyWorldMonsterIds::
Func_060_4698:: ; address name
    ld a, [wCD05]
    call BandForA_4773
    ldh [hFFC6], a

Jump_060_46A0::
    call PickRandomWCCF7Entry
    call PickRandomMonsterFromBandList
    jr nc, Jump_060_46A0
    ld a, e
    ld [wCE72], a
    ld a, d
    ld [wCE73], a
    call NextRandomSeed
    ld a, [wCD03]
    and a, $07
    jr nz, Jump_060_46CF
    ld hl, $0000
    ld a, l
    ld [wCE75], a
    ld a, h
    ld [wCE76], a
    ld a, l
    ld [wCE78], a
    ld a, h
    ld [wCE79], a
    jr Jump_060_46F2

Jump_060_46CF::
    ldh a, [hFFC6]
    dec a
    dec a
    bit 7, a
    jr z, Jump_060_46D8
    xor a, a

Jump_060_46D8::
    ldh [hFFC6], a
    call PickRandomWCCF7Entry
    call PickRandomMonsterFromBandList
    jr nc, Jump_060_46A0
    ld a, e
    ld [wCE75], a
    ld a, d
    ld [wCE76], a
    ld a, e
    ld [wCE78], a
    ld a, d
    ld [wCE79], a

Jump_060_46F2::
    ld a, [wC96B]
    ld [wCE74], a
    cp a, $05
    jr nc, Jump_060_46FE
    ld a, $05

Jump_060_46FE::
    dec a
    dec a
    dec a
    dec a
    ld [wCE77], a
    ld [wCE7A], a
    ret

; hFFC7 = wCCF7[random & 1], stepping back over $FF entries (E-0124)
; 4 call sites from 3 routines (e.g. RollKeyWorldEncounterTable, RollKeyWorldMonsterIds, Func_060_4607)
; reads: wCD03
; writes: hFFC7
; points at: wCCF7
PickRandomWCCF7Entry::
Func_060_4709:: ; address name
    call NextRandomSeed
    ld a, [wCD03]
    and a, $01
    ld hl, wCCF7
    add a, l
    ld l, a
    jr nc, Jump_060_4719
    inc h

Jump_060_4719::
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_060_4721
    dec hl
    jr Jump_060_4719

Jump_060_4721::
    ldh [hFFC7], a
    ret

; DE = a random entry of the list Data_060_6D6D[16 * hFFC7 + 2 * hFFC6]; carry when valid, no carry for an empty list or ids $A4, $A5 and $174 (E-0127)
; 4 call sites from 3 routines (e.g. RollKeyWorldEncounterTable, RollKeyWorldMonsterIds, Func_060_4607)
; reads: hFFC7, hFFC6, wCD04
PickRandomMonsterFromBandList::
Func_060_4724:: ; address name
    ldh a, [hFFC7]
    swap a
    ld de, Data_060_6D6D
    add a, e
    ld e, a
    jr nc, Jump_060_4730
    inc d

Jump_060_4730::
    ldh a, [hFFC6]
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_060_4738
    inc d

Jump_060_4738::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [hl+]
    or a, a
    jr nz, Jump_060_4743

Jump_060_4741::
    sub a, a
    ret

Jump_060_4743::
    dec a
    jr z, Jump_060_4753
    inc a
    ld c, a

Jump_060_4748::
    call NextRandomSeed
    ld a, [wCD04]
    and a, $07
    cp a, c
    jr nc, Jump_060_4748

Jump_060_4753::
    sla a
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    or a, a
    jr nz, Jump_060_476C
    ld a, e
    cp a, $A4
    jr z, Jump_060_4741
    cp a, $A5
    jr z, Jump_060_4741
    scf
    ret

Jump_060_476C::
    ld a, e
    cp a, $74
    jr z, Jump_060_4741
    scf
    ret

; A = 2-7 by thresholds 20, 40, 60, 70, 80, 90, 95 (E-0125)
; 3 call sites from 3 routines (e.g. RollKeyWorldEncounterTable, RollKeyWorldMonsterIds, Func_060_4607)
BandForA_4773::
Func_060_4773:: ; address name
    cp a, $14
    jr nc, Jump_060_477A
    ld a, $02
    ret

Jump_060_477A::
    cp a, $28
    jr nc, Jump_060_4781
    ld a, $03
    ret

Jump_060_4781::
    cp a, $3C
    jr nc, Jump_060_4788
    ld a, $04
    ret

Jump_060_4788::
    cp a, $46
    jr nc, Jump_060_478F
    ld a, $05
    ret

Jump_060_478F::
    cp a, $50
    jr nc, Jump_060_4796
    ld a, $05
    ret

Jump_060_4796::
    cp a, $5A
    jr nc, Jump_060_479D
    ld a, $06
    ret

Jump_060_479D::
    cp a, $5F
    jr nc, Jump_060_47A4
    ld a, $06
    ret

Jump_060_47A4::
    ld a, $07
    ret

; copies three bytes of entry wCD05 of the 8-byte table at $47C5 to wC969-wC96B (E-0121)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_Sub01)
; reads: wCD05
; writes: wC969, wC96A, wC96B
LoadWC969TripleForWCD05::
Func_060_47A7:: ; address name
    ld a, [wCD05]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, l
    add a, $C5
    ld l, a
    ld a, h
    adc a, $47
    ld h, a
    ld a, [hl+]
    ld [wC969], a
    ld a, [hl+]
    ld [wC96A], a
    ld a, [hl+]
    ld [wC96B], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $1807C5, $320

; only called from DebugAutomap_Update_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01)
; reads: wCD05, wCD04, wCD0D, wCD0E, hFFCE, hFFCF
; writes: wCD07, wCD0D, wMapWidthScreens, wCD0E, wMapHeightScreens, hFFCE, hFFCF, wCD0C
; points at: wCE93, wCD63, wCD70
DebugAutomap_Update_Sub01_Sub01_Sub02::
Func_060_4AE5:: ; address name
    xor a, a
    ld [wCD07], a
    call ClearWC88EWhenWC891MatchesWCC42
    xor a, a
    ld hl, wCE93
    ld b, $08

Jump_060_4AF2::
    ld [hl+], a
    dec b
    jr nz, Jump_060_4AF2
    call PickRandomNonzeroFromTable4CC1
    ld a, [wCD05]
    ld l, a
    ld h, $00
    ld a, $0A
    call DivideHLByA
    ld c, a
    ld a, [wCD05]
    sub a, c
    ld l, a
    ld h, $00

Jump_060_4B0C::
    call NextRandomSeed
    ld a, [wCD04]
    and a, $0F
    cp a, $0A
    jr nc, Jump_060_4B0C
    add_a_to_hl
    ld a, l
    add a, $F4
    ld l, a
    ld a, h
    adc a, $4B
    ld h, a
    ld a, [hl]
    swap a
    and a, $0F
    jr nz, Jump_060_4B2E
    ld a, $0A

Jump_060_4B2E::
    ld [wCD0D], a
    ld [wMapWidthScreens], a
    ld a, [hl]
    and a, $0F
    jr nz, Jump_060_4B3B
    ld a, $0A

Jump_060_4B3B::
    ld [wCD0E], a
    ld [wMapHeightScreens], a
    ld a, [wCD0D]
    srl a
    srl a
    ldh [hFFCE], a
    ld a, [wCD0E]
    srl a
    srl a
    ldh [hFFCF], a
    ld a, [wCD05]
    ld b, a
    ld a, $0A
    call DivideBByA
    ld a, b
    add a, a
    ld hl, Data_060_4C58
    add_a_to_hl
    ld a, [hl+]
    ld b, a
    ld a, [hl]
    ld c, a
    call NextRandomSeed
    ld a, [wCD04]
    and a, c
    add a, b
    ld [wCD0C], a
    ld hl, wCD63
    ld de, wCD70
    ld b, $04

Jump_060_4B7D::
    ld a, $FF
    ld [hl], a
    ld a, $04
    add_a_to_hl
    ld a, $FF
    ld [de], a
    inc de
    dec b
    jr nz, Jump_060_4B7D
    ld hl, wCD63
    ld de, wCD70
    ldh a, [hFFCE]
    or a, a
    jr z, Jump_060_4BC3
    ld c, a
    ld b, $00

Jump_060_4B9C::
    push hl
    push de
    ld a, b
    cp a, c
    jr c, Jump_060_4BB3
    ld [hl], $FE
    ld a, $08
    add_a_to_hl
    ld [hl], $FE
    ld a, $FE
    ld [de], a
    inc de
    inc de
    ld [de], a

Jump_060_4BB3::
    pop de
    inc de
    pop hl
    ld a, $04
    add_a_to_hl
    inc b
    ld a, b
    cp a, $02
    jr nz, Jump_060_4B9C

Jump_060_4BC3::
    ld hl, wCD63
    ld de, wCD70
    ldh a, [hFFCF]
    or a, a
    jr z, Jump_060_4BF3
    ld c, a
    ld b, $00

Jump_060_4BD1::
    push hl
    push de
    ld a, b
    cp a, c
    jr c, Jump_060_4BE2
    ld a, $FE
    ld [hl], a
    inc hl
    inc hl
    inc hl
    inc hl
    ld [hl], a
    ld [de], a
    inc de
    ld [de], a

Jump_060_4BE2::
    pop de
    inc de
    inc de
    pop hl
    ld a, $08
    add_a_to_hl
    inc b
    ld a, b
    cp a, $02
    jr nz, Jump_060_4BD1

Jump_060_4BF3::
    ret
    db $44, $44, $44, $44, $44, $44, $44, $44, $44, $44
    ds $5A, $88

Data_060_4C58:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $0F, $08, $0F, $08, $0F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F

; when wC88E is set and wC891 has bit 7 with low bits equal to wCC42, clears wC88E (E-0122)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_Sub02)
; reads: wC88E, wC891, wCC42
; writes: wC88E
ClearWC88EWhenWC891MatchesWCC42::
Func_060_4C6C:: ; address name
    ld a, [wC88E]
    or a, a
    ret z
    ld a, [wC891]
    bit 7, a
    ret z
    and a, $7F
    ld c, a
    ld a, [wCC42]
    cp a, c
    ret nz
    ld a, $00
    ld [wC88E], a
    ret

; repeatedly picks entry (wCD03 & 3) of the 4-byte row of Data_060_4CC1 selected by the second byte of the wC708 entry wC833 until it is non-zero; wCD0B = entry - 1 (E-0121)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_Sub02)
; reads: wCD03, wC833
; writes: wCD0B
PickRandomNonzeroFromTable4CC1::
Func_060_4C85:: ; address name
    call NextRandomSeed
    ld a, [wCD03]
    and a, $07
    push af
    ld a, [wC833]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $08
    ld e, a
    ld a, d
    adc a, $C7
    ld d, a
    inc de
    ld hl, Data_060_4CC1
    ld a, [de]
    add a, a
    add a, a
    add_a_to_hl
    pop af
    and a, $03
    add_a_to_hl
    ld a, [hl]
    or a, a
    jr z, PickRandomNonzeroFromTable4CC1
    dec a
    ld [wCD0B], a
    ret

Data_060_4CC1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $180CC1, $E0

; only called from DebugAutomap_Update_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01)
; reads: hFFC6, hFFC7, hFFCB, hFFCC
; writes: hFFC6, hFFC7, hFFCB, hFFCC, hFFCD
; points at: wCD63, wCD70, hFFCD
DebugAutomap_Update_Sub01_Sub01_Sub03::
Func_060_4DA1:: ; address name
    ld b, $00
    ld hl, wCD63
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    ld de, wCD70
    ld a, e
    ldh [hFFCB], a
    ld a, d
    ldh [hFFCC], a
    xor a, a
    ldh [hFFCD], a

Jump_060_4DB8::
    push bc
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_060_4DCE

Jump_060_4DC4::
    call RunRandomPatternCase
    or a, a
    jr z, Jump_060_4DC4
    ld hl, hFFCD
    inc [hl]

Jump_060_4DCE::
    ldh a, [hFFCB]
    ld e, a
    ldh a, [hFFCC]
    ld d, a
    inc de
    ld a, e
    ldh [hFFCB], a
    ld a, d
    ldh [hFFCC], a
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld a, $04
    add_a_to_hl
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    pop bc
    inc b
    ld a, b
    cp a, $04
    jr nz, Jump_060_4DB8
    ret

; only called from DebugAutomap_Update_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01)
; points at: wCD70, wCD74
DebugAutomap_Update_Sub01_Sub01_Sub04::
Func_060_4DF6:: ; address name
    ld b, $04
    ld hl, wCD70
    ld de, wCD74

Jump_060_4DFE::
    ld a, [hl+]
    and a, $0F
    ld c, a
    ld a, [de]
    or a, c
    ld [de], a
    inc de
    dec b
    jr nz, Jump_060_4DFE
    ret

; only called from DebugAutomap_Update_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01)
; reads: hFFCD, wCD04, hFFC6, hFFC7
; writes: hFFC6, hFFC7
; points at: wCD70, wCD74
DebugAutomap_Update_Sub01_Sub01_Sub05::
Func_060_4E0A:: ; address name
    ldh a, [hFFCD]
    cp a, $01
    jp z, Jump_060_4F4B
    ld c, a
    ld b, a

Jump_060_4E13::
    push bc

Jump_060_4E14::
    call NextRandomSeed
    ld a, [wCD04]
    and a, $03
    cp a, c
    jr nc, Jump_060_4E14
    ldh [hFFC6], a

Jump_060_4E21::
    call NextRandomSeed
    ld a, [wCD04]
    and a, $03
    cp a, c
    jr nc, Jump_060_4E21
    ld c, a
    ldh a, [hFFC6]
    cp a, c
    jr z, Jump_060_4E6C
    ld a, c
    ldh [hFFC7], a
    ld hl, wCD70
    ld b, $04

Jump_060_4E3A::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_060_4E68
    cp a, $FE
    jr z, Jump_060_4E68
    swap a
    and a, $0F
    ld c, a
    ldh a, [hFFC6]
    cp a, c
    jr nz, Jump_060_4E59
    ldh a, [hFFC7]
    swap a
    ld c, a
    ld a, [hl]
    and a, $0F
    or a, c
    ld [hl], a
    jr Jump_060_4E68

Jump_060_4E59::
    ldh a, [hFFC7]
    cp a, c
    jr nz, Jump_060_4E68
    ldh a, [hFFC6]
    swap a
    ld c, a
    ld a, [hl]
    and a, $0F
    or a, c
    ld [hl], a

Jump_060_4E68::
    inc hl
    dec b
    jr nz, Jump_060_4E3A

Jump_060_4E6C::
    pop bc
    dec b
    jr nz, Jump_060_4E13
    ld b, $00

Jump_060_4E72::
    push bc
    ld hl, wCD70
    ld e, $00
    ld c, $00

Jump_060_4E7A::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_060_4E94
    cp a, $FE
    jr z, Jump_060_4E94
    swap a
    and a, $0F
    cp a, b
    jr nz, Jump_060_4E94
    ld a, [hl]
    and a, $0F
    cp a, e
    jr c, Jump_060_4E94
    ld e, a
    ld a, c
    ldh [hFFC6], a

Jump_060_4E94::
    inc hl
    inc c
    ld a, c
    cp a, $04
    jr nz, Jump_060_4E7A
    ldh a, [hFFC6]
    and a, $0C
    jr z, Jump_060_4EC2
    ldh a, [hFFC6]
    dec a
    dec a
    ld de, wCD70
    add a, e
    ld e, a
    jr nc, Jump_060_4EAD
    inc d

Jump_060_4EAD::
    ld a, [de]
    swap a
    and a, $0F
    dec a
    cp a, b
    jr nz, Jump_060_4EC2
    ld a, [de]
    and a, $0F
    jp z, Jump_060_4F42
    call SwapDEByteWithMatchingWCD70
    jp Jump_060_4F42

Jump_060_4EC2::
    ldh a, [hFFC6]
    and a, $01
    jr z, Jump_060_4EE6
    ldh a, [hFFC6]
    dec a
    ld de, wCD70
    add a, e
    ld e, a
    jr nc, Jump_060_4ED3
    inc d

Jump_060_4ED3::
    ld a, [de]
    swap a
    and a, $0F
    dec a
    cp a, b
    jr nz, Jump_060_4EE6
    ld a, [de]
    and a, $0F
    jr z, Jump_060_4F42
    call SwapDEByteWithMatchingWCD70
    jr Jump_060_4F42

Jump_060_4EE6::
    ldh a, [hFFC6]
    and a, $02
    cp a, $02
    jr z, Jump_060_4F16
    ldh a, [hFFC6]
    inc a
    inc a
    ld de, wCD70
    add a, e
    ld e, a
    jr nc, Jump_060_4EFA
    inc d

Jump_060_4EFA::
    ld a, [de]
    cp a, $FF
    jr z, Jump_060_4F16
    cp a, $FE
    jr z, Jump_060_4F16
    ld a, [de]
    swap a
    and a, $0F
    dec a
    cp a, b
    jr nz, Jump_060_4F16
    ld a, [de]
    and a, $0F
    jr z, Jump_060_4F42
    call SwapDEByteWithMatchingWCD70
    jr Jump_060_4F42

Jump_060_4F16::
    ldh a, [hFFC6]
    and a, $01
    cp a, $01
    jr z, Jump_060_4F42
    ldh a, [hFFC6]
    inc a
    ld de, wCD70
    add a, e
    ld e, a
    jr nc, Jump_060_4F29
    inc d

Jump_060_4F29::
    cp a, $FF
    jr z, Jump_060_4F42
    cp a, $FE
    jr z, Jump_060_4F42
    ld a, [de]
    swap a
    and a, $0F
    dec a
    cp a, b
    jr nz, Jump_060_4F42
    ld a, [de]
    and a, $0F
    jr z, Jump_060_4F42
    call SwapDEByteWithMatchingWCD70

Jump_060_4F42::
    pop bc
    inc b
    ldh a, [hFFCD]
    dec a
    cp a, b
    jp nz, Jump_060_4E72

Jump_060_4F4B::
    ld b, $04
    ld hl, wCD70
    ld de, wCD74

Jump_060_4F53::
    ld a, [hl+]
    and a, $F0
    ld [de], a
    inc de
    dec b
    jr nz, Jump_060_4F53
    ret

; swaps [DE] with the first of the four wCD70 bytes whose high nibble matches [DE]'s (E-0124)
; 4 call sites from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_Sub05)
; reads: hFFC7
; writes: hFFC7
; points at: wCD70
SwapDEByteWithMatchingWCD70::
Func_060_4F5C:: ; address name
    ld a, [de]
    and a, $F0
    ldh [hFFC7], a
    ld c, $04
    ld hl, wCD70

Jump_060_4F66::
    push bc
    ld a, [hl]
    ld c, a
    ldh a, [hFFC7]
    cp a, c
    jr nz, Jump_060_4F76
    pop bc
    ld a, [hl]
    ld c, a
    ld a, [de]
    ld [hl], a
    ld a, c
    ld [de], a
    ret

Jump_060_4F76::
    inc hl
    pop bc
    dec c
    jr nz, Jump_060_4F66
    ret

; only called from DebugAutomap_Update_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01)
; reads: hFFCD, hFFC6
; writes: hFFC6, hFFC7, hFFC8
; points at: wCD7A, wCD78, wCD70
DebugAutomap_Update_Sub01_Sub01_Sub06::
Func_060_4F7C:: ; address name
    ld hl, wCD7A
    ld b, $05

Jump_060_4F81::
    push hl
    xor a, a
    ld [hl+], a
    ld [hl], a
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    dec b
    jr nz, Jump_060_4F81
    ld hl, wCD78
    ldh a, [hFFCD]
    dec a
    jr z, Jump_060_4FE4
    ld b, a
    ld c, $00

Jump_060_4F98::
    push bc
    push hl
    ld de, wCD70
    ld b, $00
    xor a, a
    ldh [hFFC6], a

Jump_060_4FA2::
    push bc
    ld a, [de]
    cp a, $FF
    jr z, Jump_060_4FCF
    cp a, $FE
    jr z, Jump_060_4FCF
    swap a
    and a, $0F
    cp a, c
    jr nz, Jump_060_4FC3
    ldh a, [hFFC6]
    ld c, a
    ld a, [de]
    and a, $0F
    cp a, c
    jr c, Jump_060_4FCF
    ldh [hFFC6], a
    ld a, b
    ldh [hFFC7], a
    jr Jump_060_4FCF

Jump_060_4FC3::
    dec a
    cp a, c
    jr nz, Jump_060_4FCF
    ld a, [de]
    and a, $0F
    jr nz, Jump_060_4FCF
    ld a, b
    ldh [hFFC8], a

Jump_060_4FCF::
    inc de
    pop bc
    inc b
    ld a, b
    cp a, $04
    jr nz, Jump_060_4FA2
    call Func_060_4FEA
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    pop bc
    inc c
    dec b
    jr nz, Jump_060_4F98

Jump_060_4FE4::
    inc hl
    inc hl
    inc hl
    ld [hl], $FF
    ret

; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_Sub06)
; reads: hFFC7, wCD04, hFFCA, hFFC9, hFFC8
; writes: hFFCA, hFFC9
Func_060_4FEA::
    ldh a, [hFFC7]
    and a, $FE
    add a, a
    ldh [hFFCA], a
    call NextRandomSeed
    ld a, [wCD04]
    and a, $03
    ld c, a
    ldh a, [hFFCA]
    or a, c
    ldh [hFFCA], a
    ldh a, [hFFC7]
    and a, $01
    add a, a
    add a, a
    ldh [hFFC9], a
    call NextRandomSeed
    ld a, [wCD04]
    and a, $03
    ld c, a
    ldh a, [hFFC9]
    or a, c
    ldh [hFFC9], a
    call ReadKeyWorldCellIsSolid
    or a, a
    jr z, Func_060_4FEA
    ldh a, [hFFC9]
    and a, $0F
    swap a
    ld c, a
    ldh a, [hFFCA]
    and a, $0F
    or a, c
    ld [hl], a
    ld c, a
    push hl
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    cp a, c
    jr nz, Jump_060_5034
    pop hl
    jr Func_060_4FEA

Jump_060_5034::
    pop hl
    inc hl

Jump_060_5036::
    ldh a, [hFFC8]
    and a, $FE
    add a, a
    ldh [hFFCA], a
    call NextRandomSeed
    ld a, [wCD04]
    and a, $03
    ld c, a
    ldh a, [hFFCA]
    or a, c
    ldh [hFFCA], a
    ldh a, [hFFC8]
    and a, $01
    add a, a
    add a, a
    ldh [hFFC9], a
    call NextRandomSeed
    ld a, [wCD04]
    and a, $03
    ld c, a
    ldh a, [hFFC9]
    or a, c
    ldh [hFFC9], a
    call ReadKeyWorldCellIsSolid
    or a, a
    jr z, Jump_060_5036
    ldh a, [hFFC9]
    and a, $0F
    swap a
    ld c, a
    ldh a, [hFFCA]
    and a, $0F
    or a, c
    ld [hl+], a
    ret

; reads the cell at (hFFC9, hFFCA) from the area map chunk in wCD60; A = 1 when its byte is not $FF, else 0 (E-0128)
; 3 call sites from 2 routines (e.g. Func_060_528B, Func_060_4FEA)
; reads: hFFCA, hFFC9
ReadKeyWorldCellIsSolid::
Func_060_5075:: ; address name
    push hl
    ldh a, [hFFCA]
    and a, $FC
    add a, a
    ld l, a
    ld h, $00
    ldh a, [hFFC9]
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
    ldh a, [hFFCA]
    and a, $03
    ld c, a
    sla a
    add a, c
    sla a
    sla a
    add_a_to_hl
    ldh a, [hFFC9]
    and a, $03
    ld c, a
    sla a
    add a, c
    add_a_to_hl
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    call ReadByteInBank
    ld a, c
    ld l, a
    inc de
    call ReadByteInBank
    ld a, c
    ld h, a
    inc de
    call ReadByteInBank
    ld a, c
    ld b, a
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    call ReadByteInBank
    ld a, c
    cp a, $FF
    jr nz, Jump_060_50E0
    xor a, a
    pop hl
    ret

Jump_060_50E0::
    ld a, $01
    pop hl
    ret

; only called from DebugAutomap_Update_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01)
DebugAutomap_Update_Sub01_Sub01_Sub07::
Func_060_50E4:: ; address name
    ret

; only called from DebugAutomap_Update_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01)
; reads: hFFC6, hFFC7, wCD04, wCD03
; writes: hFFC6, hFFC7
; points at: wCE8B, wCD8B, wCDAF
DebugAutomap_Update_Sub01_Sub01_Sub08::
Func_060_50E5:: ; address name
    ld hl, wCE8B
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    ld hl, wCD8B
    ld de, wCDAF

Jump_060_50F4::
    ld a, [hl]
    cp a, $FF
    ret z
    push hl
    dec hl
    dec hl
    ld a, [hl]
    cp a, $04
    jr z, Jump_060_5106
    cp a, $05
    jr z, Jump_060_5106
    jr Jump_060_5159

Jump_060_5106::
    ld a, [de]
    dec a
    jr z, Jump_060_5147
    dec a
    jr z, Jump_060_5159

Jump_060_510D::
    call NextRandomSeed
    ld a, [wCD04]
    and a, $7F
    cp a, $64
    jr nc, Jump_060_510D
    cp a, $05
    jr nc, Jump_060_5122
    ld a, $03
    ld [de], a
    jr Jump_060_5151

Jump_060_5122::
    cp a, $1E
    jr nc, Jump_060_512B
    ld a, $01
    ld [de], a
    jr Jump_060_5147

Jump_060_512B::
    call NextRandomSeed
    ld a, [wCD03]
    and a, $3F
    ld hl, Data_060_5177
    add_a_to_hl
    ld a, [hl]
    push af
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    pop af
    ld [hl], a
    jr Jump_060_5159

Jump_060_5147::
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld [hl], $80
    jr Jump_060_5159

Jump_060_5151::
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld [hl], $81

Jump_060_5159::
    ldh a, [hFFC6]
    add a, $01
    ldh [hFFC6], a
    ldh a, [hFFC7]
    adc a, $00
    ldh [hFFC7], a
    pop hl
    ld a, $04
    add_a_to_hl
    ld a, $10
    add a, e
    ld e, a
    jr nc, Jump_060_5174
    inc d

Jump_060_5174::
    jp Jump_060_50F4

Data_060_5177:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F
    db $50, $51, $52, $53, $5A, $5B, $5C, $5D, $5E, $5F, $60, $61, $40, $41, $42, $43
    db $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F, $50, $51, $52, $53
    db $5A, $5B, $5C, $5D, $5E, $5F, $60, $61, $40, $41, $42, $43, $44, $45, $46, $47

; only called from DebugAutomap_Update_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01)
; reads: hFFCD, hFFC6, hFFC7, wCD0C, wCD0E, wCD0D, hFFCB, hFFC8, ...
; writes: hFFC6, hFFC7, hFFCB, hFFC8, hFFC9, hFFCE, hFFCF
; points at: wCD70, wCD88
DebugAutomap_Update_Sub01_Sub01_Sub09::
Func_060_51B7:: ; address name
    ldh a, [hFFCD]
    cp a, $01
    jr z, Jump_060_51F9
    ld e, a
    ld b, $00
    xor a, a
    ldh [hFFC6], a

Jump_060_51C3::
    xor a, a
    ldh [hFFC7], a
    ld hl, wCD70
    ld c, $04

Jump_060_51CB::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_060_51E8
    cp a, $FE
    jr z, Jump_060_51E8
    swap a
    and a, $0F
    cp a, b
    jr nz, Jump_060_51E8
    ldh a, [hFFC6]
    ld d, a
    ld a, [hl]
    and a, $0F
    add a, d
    ld [hl], a
    ldh a, [hFFC7]
    inc a
    ldh [hFFC7], a

Jump_060_51E8::
    inc hl
    dec c
    jr nz, Jump_060_51CB
    ldh a, [hFFC6]
    ld c, a
    ldh a, [hFFC7]
    add a, c
    ldh [hFFC6], a
    inc b
    ld a, b
    cp a, e
    jr nz, Jump_060_51C3

Jump_060_51F9::
    ld a, [wCD0C]
    sla a
    ld hl, Data_060_6D0D
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    push bc
    ld b, $84
    call ReadByteInBank
    ld a, c
    ldh [hFFCB], a
    pop bc
    ld c, $00
    ld a, [wCD0E]
    dec a
    srl a
    srl a
    inc a
    ld b, a

Jump_060_5220::
    ld a, [wCD0D]
    dec a
    srl a
    srl a
    inc a
    add a, c
    ld c, a
    dec b
    jr nz, Jump_060_5220
    ldh a, [hFFCB]
    ld h, a
    ld l, $00
    ld a, c
    call DivideHLByA
    inc hl
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    ld hl, $0000
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    ld hl, wCD88
    ld a, l
    ldh [hFFCE], a
    ld a, h
    ldh [hFFCF], a
    inc hl
    inc hl
    inc hl
    ld [hl], $FF
    ld b, $00
    ld c, $00

Jump_060_5259::
    ldh a, [hFFC8]
    ld l, a
    ldh a, [hFFC9]
    ld h, a
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    add hl, de

Jump_060_5266::
    ld a, h
    or a, a
    jr nz, Jump_060_5273
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    inc c
    jr Jump_060_5259

Jump_060_5273::
    push hl
    push bc
    call Func_060_528B
    or a, a
    jr nz, Jump_060_5288
    pop bc
    pop hl
    inc b
    ldh a, [hFFCB]
    cp a, b
    jr z, Jump_060_5286
    dec h
    jr Jump_060_5266

Jump_060_5286::
    xor a, a
    ret

Jump_060_5288::
    pop bc
    pop hl
    ret

; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_Sub09)
; reads: hFFC9, wCD04, hFFCA, hFFD0, hFFCE, hFFCF, wCD0C, hFFCC
; writes: hFFD0, hFFCC, hFFCA, hFFC9, hFFCE, hFFCF
; points at: wCD70, wCD7B, wCD8B
Func_060_528B::
    push bc
    xor a, a
    ldh [hFFD0], a
    ld hl, wCD70
    ld b, $00

Jump_060_5294::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_060_52A0
    cp a, $FE
    jr z, Jump_060_52A0
    cp a, c
    jr z, Jump_060_52A9

Jump_060_52A0::
    inc b
    ld a, b
    cp a, $04
    jr nz, Jump_060_5294
    pop bc
    xor a, a
    ret

Jump_060_52A9::
    ldh a, [hFFC9]
    ldh [hFFCC], a

Jump_060_52AD::
    ld a, b
    srl a
    add a, a
    add a, a
    ld c, a
    call NextRandomSeed
    ld a, [wCD04]
    and a, $03
    add a, c
    ldh [hFFCA], a
    ld a, b
    and a, $01
    add a, a
    add a, a
    ld c, a
    call NextRandomSeed
    ld a, [wCD04]
    and a, $03
    add a, c
    ldh [hFFC9], a
    ldh a, [hFFC9]
    and a, $0F
    swap a
    ld c, a
    ldh a, [hFFCA]
    and a, $0F
    or a, c
    ld c, a
    ld hl, wCD7B

Jump_060_52DF::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_060_52F8
    dec hl
    dec hl
    ld a, [hl]
    cp a, c
    jr z, Jump_060_5365
    dec hl
    ld a, [hl]
    cp a, c
    jr z, Jump_060_5365
    ld a, $07
    add_a_to_hl
    jr Jump_060_52DF

Jump_060_52F8::
    ld hl, wCD8B

Jump_060_52FB::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_060_5310
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    cp a, c
    jr z, Jump_060_5365
    ld a, $07
    add_a_to_hl
    jr Jump_060_52FB

Jump_060_5310::
    push bc
    call ReadKeyWorldCellIsSolid
    pop bc
    or a, a
    jr z, Jump_060_5365
    ldh a, [hFFCE]
    ld l, a
    ldh a, [hFFCF]
    ld h, a
    ldh a, [hFFC9]
    and a, $0F
    swap a
    ld c, a
    ldh a, [hFFCA]
    and a, $0F
    or a, c
    ld [hl+], a
    pop bc
    push hl
    ld a, [wCD0C]
    sla a
    ld hl, Data_060_6D0D
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    inc de
    pop hl
    ld a, b
    swap a
    add a, e
    ld e, a
    jr nc, Jump_060_5348
    inc d

Jump_060_5348::
    push bc
    ld b, $84
    call ReadByteInBank
    ld a, c
    ld [hl+], a
    pop bc
    inc hl
    xor a, a
    ld [hl+], a
    ld a, l
    ldh [hFFCE], a
    ld a, h
    ldh [hFFCF], a
    inc hl
    inc hl
    inc hl
    ld [hl], $FF
    ldh a, [hFFCC]
    ldh [hFFC9], a
    xor a, a
    ret

Jump_060_5365::
    ldh a, [hFFD0]
    inc a
    ldh [hFFD0], a
    cp a, $64
    jp nz, Jump_060_52AD
    pop bc
    ld a, $01
    ret

; only called from DebugAutomap_Update_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01)
; reads: wCD05, wCC47
; writes: wCD0F, wCC47, hFFC6
; points at: wCC48
DebugAutomap_Update_Sub01_Sub01_Sub0A::
Func_060_5373:: ; address name
    ld a, [wCD05]
    call SetWCD0FBandForA

Jump_060_5379::
    ld [wCD0F], a
    ld hl, Data_060_53B3
    add_a_to_hl
    ld a, [hl]
    ld [wCC47], a
    ld b, a
    ld de, wCC48

Jump_060_538C::
    push de
    push bc
    ld a, b
    ldh [hFFC6], a
    call Func_060_54BB
    call Func_060_53E5
    or a, a
    jr nz, Jump_060_53A7
    pop bc
    pop de
    ld a, $08
    add a, e
    ld e, a
    jr nc, Jump_060_53A3
    inc d

Jump_060_53A3::
    dec b
    jr nz, Jump_060_538C
    ret

Jump_060_53A7::
    pop bc
    pop de
    ld a, [wCC47]
    sub a, b
    ld [wCC47], a
    jr z, Jump_060_5379
    ret

Data_060_53B3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0F, $0F, $0F, $0F, $14, $14, $14, $14

; wCD0F = 0 for A < $0B, $0F for A >= $50, otherwise (A - $0A) / 5 + 1 (E-0124)
; 3 call sites from 3 routines (e.g. Func_060_62F9, FieldModeStateDispatch_Case04_Sub02_Sub01, DebugAutomap_Update_Sub01_Sub01_Sub0A)
; writes: wCD0F
SetWCD0FBandForA::
Func_060_53C3:: ; address name
    cp a, $0B
    jr nc, Jump_060_53CB
    ld a, $00
    jr Jump_060_53DF

Jump_060_53CB::
    cp a, $50
    jr c, Jump_060_53D3
    ld a, $0F
    jr Jump_060_53DF

Jump_060_53D3::
    sub a, $0A
    ld l, a
    ld h, $00
    ld a, $05
    call DivideHLByA
    ld a, l
    inc a

Jump_060_53DF::
    and a, $0F
    ld [wCD0F], a
    ret

; 2 call sites from 2 routines (e.g. Func_060_62F9, DebugAutomap_Update_Sub01_Sub01_Sub0A)
; reads: wCD0D, wCD04, wCD0E, hFFC9, hFFCA, hFFC6, wCC47, hFFCB, ...
; writes: wC94F, hFFC9, hFFCA, hFFCB
; points at: wCC4C
Func_060_53E5::
    xor a, a
    ld [wC94F], a
    push de

Jump_060_53EA::
    ld a, [wCD0D]
    ld c, a

Jump_060_53EE::
    call NextRandomSeed
    ld a, [wCD04]
    and a, $0F
    cp a, c
    jr nc, Jump_060_53EE
    ldh [hFFC9], a
    ld a, [wCD0E]
    ld c, a

Jump_060_53FF::
    call NextRandomSeed
    ld a, [wCD04]
    and a, $0F
    cp a, c
    jr nc, Jump_060_53FF
    ldh [hFFCA], a
    ldh a, [hFFC9]
    swap a
    ld c, a
    ldh a, [hFFCA]
    or a, c
    ldh [hFFCB], a
    ld c, a
    ldh a, [hFFC6]
    ld b, a
    ld a, [wCC47]
    sub a, b
    jr z, Jump_060_5433
    ld b, a
    ld hl, wCC4C

Jump_060_5424::
    ld a, [hl]
    cp a, c
    jp z, Jump_060_54AB
    ld a, $08
    add_a_to_hl
    dec b
    jr nz, Jump_060_5424

Jump_060_5433::
    ldh a, [hFFCA]
    and a, $FC
    add a, a
    ld l, a
    ld h, $00
    ldh a, [hFFC9]
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
    ldh a, [hFFCA]
    and a, $03
    ld c, a
    add a, a
    add a, c
    add a, a
    add a, a
    add_a_to_hl
    ldh a, [hFFC9]
    and a, $03
    ld c, a
    add a, a
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
    call NextRandomSeed
    ld a, [wCD04]
    and a, $03
    inc a
    add_a_to_hl
    ld e, l
    ld d, h
    call ReadByteInBank
    ld a, c
    cp a, $FF
    jr z, Jump_060_54AB
    pop de
    inc de
    inc de
    inc de
    inc de
    inc de
    ld [de], a
    dec de
    ldh a, [hFFCB]
    ld [de], a
    ld a, $00
    ret

Jump_060_54AB::
    ld a, [wC94F]
    inc a
    ld [wC94F], a
    cp a, $64
    jp nz, Jump_060_53EA
    pop de
    ld a, $01
    ret

; 3 call sites from 3 routines (e.g. Func_060_62F9, RemoveWCC48EntryMatching, DebugAutomap_Update_Sub01_Sub01_Sub0A)
; reads: wCD0F, wCD04, hFFC6, hFFC7
; writes: hFFC6, hFFC7
Func_060_54BB::
    ld a, [wCD0F]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, l
    add a, $6F
    ld l, a
    ld a, h
    adc a, $55
    ld h, a

Jump_060_54CF::
    call NextRandomSeed
    ld a, [wCD04]
    and a, $7F
    cp a, $64
    jr nc, Jump_060_54CF
    ld c, a
    ld b, $00

Jump_060_54DE::
    ld a, [hl+]
    or a, a
    jr z, Jump_060_54E5
    cp a, c
    jr nc, Jump_060_54E8

Jump_060_54E5::
    inc b
    jr Jump_060_54DE

Jump_060_54E8::
    ld a, b
    or a, a
    jr z, Jump_060_5514
    dec a
    jr z, Jump_060_555B
    inc de
    ld a, b
    dec a
    dec a
    ld [de], a
    dec de

Jump_060_54F5::
    call NextRandomSeed
    ld a, [wCD04]
    and a, $7F
    cp a, $64
    jr nc, Jump_060_54F5
    ld c, a
    ld a, [wCD0F]
    ld hl, Data_060_555F
    add_a_to_hl
    xor a, a
    ld [de], a
    ret
    db $3E, $02, $12, $C9

Jump_060_5514::
    ld a, $01
    ld [de], a
    ld a, [wCD0F]
    ld c, a

Jump_060_551B::
    call NextRandomSeed
    ld a, [wCD04]
    and a, $7F
    cp a, $64
    jr nc, Jump_060_551B
    call Multiply8
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    ld a, [wCD0F]
    ld c, a

Jump_060_5534::
    call NextRandomSeed
    ld a, [wCD04]
    and a, $0F
    cp a, $0A
    jr nc, Jump_060_5534
    call Multiply8
    ldh a, [hFFC6]
    ld c, a
    ldh a, [hFFC7]
    ld b, a
    add hl, bc
    push de
    ld a, $0A
    call DivideHLByA
    pop de
    ld a, l
    or a, a
    jr nz, Jump_060_5557
    ld a, $01

Jump_060_5557::
    inc de
    ld [de], a
    dec de
    ret

Jump_060_555B::
    ld a, $03
    ld [de], a
    ret

Data_060_555F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $13, $00
    db $5E
    ds $21, $00
    db $5F, $00, $00, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $14, $00, $00, $45, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $46, $47, $00, $00, $00, $00, $00, $00, $00, $00, $5B, $5E, $00, $00, $00
    db $00, $00, $00, $00, $00, $5F, $00, $00, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $14, $00, $00, $45, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $46, $47, $00, $00, $00, $00, $00, $00, $00, $00, $56, $5B, $5E, $00, $00
    db $00, $00, $00, $00, $00, $5F, $00, $00, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $14, $00, $00, $39, $3D, $00, $00, $00, $3E, $3F, $40, $41, $42, $00, $43, $44
    db $45, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $4A, $54, $5C, $00, $00
    db $00, $00, $00, $00, $00, $5F, $00, $00, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $14, $00, $00, $2F, $39, $00, $3D, $00, $3E, $3F, $40, $41, $42, $00, $43, $44
    db $45, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $4A, $54, $5C, $00, $00
    db $00, $00, $00, $00, $00, $5F, $00, $00, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $14, $00, $00, $25, $34, $00, $3D, $00, $3E, $3F, $40, $41, $42, $00, $43, $00
    db $00, $00, $00, $44, $45, $00, $00, $00, $00, $00, $00, $46, $4E, $58, $59, $5A
    db $00, $00, $00, $00, $5B, $5E, $5F, $00, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $14, $00, $00, $1B, $2F, $00, $3D, $00, $3E, $3F, $40, $41, $42, $00, $43, $00
    db $00, $00, $00, $44, $45, $00, $00, $00, $00, $00, $00, $00, $4A, $58, $59, $5A
    db $00, $00, $00, $00, $5B, $5E, $5F, $00, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $14, $00, $00, $16, $2F, $00, $39, $3D, $3E, $3F, $40, $41, $42, $00, $43, $44
    db $45, $46, $47, $48, $49, $00, $00, $00, $00, $00, $00, $00, $00, $57, $58, $59
    db $00, $00, $00, $00, $5A, $5D, $5E, $5F, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $13, $00, $00, $00, $29, $2E, $38, $3C, $3D, $3E, $3F, $40, $41, $00, $42, $43
    db $44, $45, $46, $47, $48, $00, $00, $00, $00, $00, $00, $00, $00, $56, $57, $58
    db $00, $00, $59, $00, $5A, $5D, $5E, $5F, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $13, $00, $00, $00, $29, $2E, $32, $3C, $3D, $3E, $3F, $40, $41, $00, $42, $43
    db $44, $45, $46, $47, $48, $00, $00, $00, $00, $00, $00, $00, $00, $52, $57, $58
    db $00, $00, $59, $00, $5A, $5D, $5E, $5F, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $13, $00, $00, $00, $29, $2E, $32, $3C, $3D, $3E, $3F, $40, $41, $00, $42, $43
    db $44, $45, $46, $47, $48, $00, $00, $00, $00, $00, $00, $00, $00, $52, $57, $58
    db $00, $00, $59, $00, $5A, $5D, $00, $5F, $60, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $13, $00, $00, $00, $29, $2E, $32, $3C, $3D, $3E, $3F, $40, $41, $00, $42, $43
    db $44, $45, $46, $47, $48, $00, $00, $00, $00, $00, $00, $00, $00, $52, $57, $58
    db $00, $00, $59, $00, $5A, $5D, $00, $00, $5E, $5F, $61, $62, $63, $00, $64
    ds $11, $00
    db $13, $00, $00, $00, $29, $2E, $32, $3C, $3D, $3E, $3F, $40, $41, $00, $42, $43
    db $44, $45, $46, $47, $48, $00, $00, $00, $00, $00, $00, $00, $00, $52, $57, $58
    db $00, $00, $59, $00, $5A, $5D, $00, $00, $5E, $5F, $61, $62, $63, $00, $64
    ds $11, $00
    db $13, $00, $00, $00, $29, $2E, $32, $3C, $3D, $3E, $3F, $40, $41, $00, $42, $43
    db $44, $45, $46, $47, $48, $00, $00, $00, $00, $00, $00, $00, $00, $52, $57, $58
    db $00, $00, $59, $00, $5A, $5D, $00, $00, $5E, $5F, $61, $62, $63, $00, $64
    ds $11, $00
    db $13, $00, $00, $00, $29, $2E, $32, $3C, $3D, $3E, $3F, $40, $41, $00, $42, $43
    db $44, $45, $46, $47, $48, $00, $00, $00, $00, $00, $00, $00, $00, $52, $57, $58
    db $00, $00, $59, $00, $5A, $5D, $00, $00, $5E, $5F, $61, $62, $63, $00, $64
    ds $11, $00
    db $13, $00, $00, $00, $29, $2E, $32, $3C, $3D, $3E, $3F, $40, $41, $00, $42, $43
    db $44, $45, $46, $47, $48, $00, $00, $00, $00, $00, $00, $00, $00, $52, $57, $58
    db $00, $00, $59, $00, $5A, $5D, $00, $00, $5E, $5F, $61, $62, $63, $00, $64
    ds $11, $00

; only called from routines of FieldModeStateDispatch (E-0098)
; 2 call sites from 2 routines (e.g. FieldModeStateDispatch_Case04_Sub02_Sub01, FieldModeStateDispatch_Case04_Sub02)
; reads: wCD0F, wCD04, hFFC6, hFFC7
; writes: hFFC6, hFFC7
FieldModeStateDispatch_Shared05::
Func_060_596F:: ; address name
    ld a, [wCD0F]
    and a, $0F
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, l
    add a, $29
    ld l, a
    ld a, h
    adc a, $5A
    ld h, a

Jump_060_5985::
    call NextRandomSeed
    ld a, [wCD04]
    and a, $7F
    cp a, $64
    jr nc, Jump_060_5985
    ld c, a
    ld b, $00

Jump_060_5994::
    ld a, [hl+]
    or a, a
    jr z, Jump_060_599B
    cp a, c
    jr nc, Jump_060_599E

Jump_060_599B::
    inc b
    jr Jump_060_5994

Jump_060_599E::
    ld a, b
    or a, a
    jr z, Jump_060_59CE
    dec a
    jr z, Jump_060_5A15
    inc de
    ld a, b
    dec a
    dec a
    ld [de], a
    dec de

Jump_060_59AB::
    call NextRandomSeed
    ld a, [wCD04]
    and a, $7F
    cp a, $64
    jr nc, Jump_060_59AB
    ld c, a
    ld a, [wCD0F]
    ld hl, Data_060_5A19
    add_a_to_hl
    ld a, [hl]
    cp a, c
    jr nc, Jump_060_59CA
    xor a, a
    ld [de], a
    ret

Jump_060_59CA::
    ld a, $02
    ld [de], a
    ret

Jump_060_59CE::
    ld a, $01
    ld [de], a
    ld a, [wCD0F]
    ld c, a

Jump_060_59D5::
    call NextRandomSeed
    ld a, [wCD04]
    and a, $7F
    cp a, $64
    jr nc, Jump_060_59D5
    call Multiply8
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    ld a, [wCD0F]
    ld c, a

Jump_060_59EE::
    call NextRandomSeed
    ld a, [wCD04]
    and a, $0F
    cp a, $0A
    jr nc, Jump_060_59EE
    call Multiply8
    ldh a, [hFFC6]
    ld c, a
    ldh a, [hFFC7]
    ld b, a
    add hl, bc
    push de
    ld a, $0A
    call DivideHLByA
    pop de
    ld a, l
    or a, a
    jr nz, Jump_060_5A11
    ld a, $01

Jump_060_5A11::
    inc de
    ld [de], a
    dec de
    ret

Jump_060_5A15::
    ld a, $03
    ld [de], a
    ret

Data_060_5A19:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $13, $00
    db $55
    ds $26, $00
    db $56, $57, $64
    ds $13, $00
    db $14, $19, $00, $41
    ds $17, $00
    db $50, $55, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $56
    db $57, $64
    ds $13, $00
    db $14, $19, $00, $41
    ds $17, $00
    db $4B, $50, $55, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $56
    db $57, $64
    ds $13, $00
    db $14, $19, $00, $37, $3C, $00, $00, $00, $3D, $3E, $3F, $40, $41, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $46, $50, $55, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $56, $57, $64
    ds $13, $00
    db $14, $19, $00, $2D, $37, $00, $3C, $00, $3D, $3E, $3F, $40, $41, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $46, $4B, $55, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $56, $57, $64
    ds $13, $00
    db $14, $19, $00, $23, $32, $00, $3C, $00, $3D, $3E, $3F, $40, $41, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $46, $50, $00, $55
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $56, $57, $64
    ds $13, $00
    db $14, $19, $00, $23, $32, $00, $3C, $00, $3D, $3E, $3F, $40, $41, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $46, $50, $00, $55
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $56, $57, $64
    ds $13, $00
    db $14, $19, $00, $23, $32, $00, $3C, $00, $3D, $3E, $3F, $40, $41, $00, $00, $00
    db $00, $49, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $50, $00, $55
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $56, $57, $64
    ds $13, $00
    db $0F, $19, $00, $1E, $2D, $32, $3C, $00, $3D, $3E, $3F, $40, $41
    ds $10, $00
    db $50, $55, $5A, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $5B, $5C, $64
    ds $13, $00
    db $0F, $19, $00, $1E, $2D, $32, $3C, $00, $3D, $3E, $3F, $40, $41
    ds $10, $00
    db $50, $55, $5A, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $5B, $5C, $64
    ds $13, $00
    db $0F, $19, $00, $1E, $2D, $32, $3C, $00, $3D, $3E, $3F, $40, $41
    ds $10, $00
    db $50, $55, $5A, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $5B, $5C, $64
    ds $13, $00
    db $0F, $19, $00, $1E, $2D, $32, $3C, $00, $3D, $3E, $3F, $40, $41
    ds $10, $00
    db $50, $55, $5A, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $5B, $5C, $64
    ds $13, $00
    db $0F, $19, $00, $1E, $2D, $32, $3C, $00, $3D, $3E, $3F, $40, $41
    ds $10, $00
    db $50, $55, $5A, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $5B, $5C, $64
    ds $13, $00
    db $0F, $19, $00, $1E, $2D, $32, $3C, $00, $3D, $3E, $3F, $40, $41
    ds $10, $00
    db $50, $55, $5A, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $5B, $5C, $64
    ds $13, $00
    db $0F, $19, $00, $1E, $2D, $32, $3C, $00, $3D, $3E, $3F, $40, $41
    ds $10, $00
    db $50, $55, $5A, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $5B, $5C, $64
    ds $13, $00
    db $0F, $19, $00, $1E, $2D, $32, $3C, $00, $3D, $3E, $3F, $40, $41
    ds $10, $00
    db $50, $55, $5A, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $5B, $5C, $64
    ds $13, $00
    db $06, $08, $0E, $34, $1E, $00, $F5, $CD, $80, $1F, $F0, $C6, $FE, $FF, $28, $07
    db $F1, $0C, $1C, $05, $20, $F0, $C9, $F1, $C9

; only called from DebugAutomap_Update_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01)
; reads: wCD88, hFFCA, hFFC9
; writes: wCD08, hFFC9, hFFCA, wCD09, wCD0A
DebugAutomap_Update_Sub01_Sub01_Sub0B::
Func_060_5E42:: ; address name
    ld a, [wCD88]
    ld [wCD08], a
    swap a
    and a, $0F
    ldh [hFFC9], a
    ld a, [wCD88]
    and a, $0F
    ldh [hFFCA], a
    ldh a, [hFFCA]
    and a, $FC
    add a, a
    ld l, a
    ld h, $00
    ldh a, [hFFC9]
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
    ldh a, [hFFCA]
    and a, $03
    ld c, a
    sla a
    add a, c
    sla a
    sla a
    add_a_to_hl
    ldh a, [hFFC9]
    and a, $03
    ld c, a
    sla a
    add a, c
    add_a_to_hl
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    call ReadByteInBank
    ld a, c
    ld l, a
    inc de
    call ReadByteInBank
    ld a, c
    ld h, a
    inc de
    call ReadByteInBank
    ld a, c
    ld b, a
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    call ReadByteInBank
    ld a, c
    cp a, $FF
    jr nz, Jump_060_5EBE

Jump_060_5EBC::
    jr Jump_060_5EBC

Jump_060_5EBE::
    sla a
    ld hl, Data_060_5ED1
    add_a_to_hl
    ld a, [hl+]
    ld [wCD09], a
    ld a, [hl]
    ld [wCD0A], a
    ret

Data_060_5ED1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $10, $10, $10, $60, $40, $20, $40, $60, $50, $20, $50, $60, $70, $30, $80, $70

; runs one of four routines chosen by random & $0F through a 16-entry table (E-0124)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_Sub03)
; reads: wCD04
RunRandomPatternCase::
Func_060_5EE1:: ; address name
    call NextRandomSeed
    ld a, [wCD04]
    and a, $0F
    rst $00
    dw RunRandomPatternCase_Case00
    dw RunRandomPatternCase_Case01
    dw RunRandomPatternCase_Case02
    dw RunRandomPatternCase_Case03
    dw RunRandomPatternCase_Case02
    dw RunRandomPatternCase_Case01
    dw RunRandomPatternCase_Case00
    dw RunRandomPatternCase_Case01
    dw RunRandomPatternCase_Case02
    dw RunRandomPatternCase_Case03
    dw RunRandomPatternCase_Case02
    dw RunRandomPatternCase_Case01
    dw RunRandomPatternCase_Case00
    dw RunRandomPatternCase_Case01
    dw RunRandomPatternCase_Case02
    dw RunRandomPatternCase_Case03
    db $C9, $C9

; entry 3 of the `rst $00` table in RunRandomPatternCase
; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6, hFFC7, wCD04, hFFCD, hFFC8, hFFC9, hFFCA, hFFCB, ...
; writes: hFFD0
RunRandomPatternCase_Case03::
Jump_060_5F0C:: ; address name
    ld a, b
    and a, $01
    cp a, $01
    jr nz, Jump_060_5F15

Jump_060_5F13::
    xor a, a
    ret

Jump_060_5F15::
    ld a, b
    cp a, $02
    jr c, Jump_060_5F1C
    xor a, a
    ret

Jump_060_5F1C::
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld a, $04
    add_a_to_hl
    ld a, [hl]
    cp a, $FE
    jr z, Jump_060_5F13
    cp a, $FF
    jr nz, Jump_060_5F13
    ld a, $08
    add_a_to_hl
    ld a, [hl]
    cp a, $FE
    jr z, Jump_060_5F13
    ld a, l
    sub a, $04
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, [hl]
    cp a, $FE
    jr z, Jump_060_5F13
    call NextRandomSeed
    ld a, [wCD04]
    and a, $1F
    ld c, a
    add a, a
    add a, c
    ld de, Data_060_6245
    add a, e
    ld e, a
    jr nc, Jump_060_5F5E
    inc d

Jump_060_5F5E::
    call StoreThreeBytesBeforeHFFC6Pointer
    ld [hl], $00
    ld hl, $0004
    call StoreHFFC8To3BytesBeforeHLPlusHFFC6
    ld [hl], $01
    ld hl, $0008
    call StoreHFFC8To3BytesBeforeHLPlusHFFC6
    ld [hl], $02
    ld hl, $000C
    call StoreHFFC8To3BytesBeforeHLPlusHFFC6
    ld [hl], $03
    ldh a, [hFFCD]
    swap a
    and a, $F0
    ldh [hFFD0], a
    ldh a, [hFFC8]
    ld e, a
    ldh a, [hFFC9]
    ld d, a
    ld a, e
    add a, $80
    ld e, a
    ld a, d
    adc a, $01
    ld d, a
    ldh a, [hFFCA]
    ld b, a
    call ReadByteInBank
    ldh a, [hFFCB]
    ld l, a
    ldh a, [hFFCC]
    ld h, a
    ldh a, [hFFD0]
    or a, c
    ld [hl], a
    inc de
    call ReadByteInBank
    inc hl
    ldh a, [hFFD0]
    or a, c
    ld [hl], a
    inc de
    call ReadByteInBank
    inc hl
    ldh a, [hFFD0]
    or a, c
    ld [hl], a
    inc de
    call ReadByteInBank
    inc hl
    ldh a, [hFFD0]
    or a, c
    ld [hl], a
    ld a, $01
    ret

; entry 2 of the `rst $00` table in RunRandomPatternCase
; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6, hFFC7, wCD04, hFFCD, hFFC8, hFFC9, hFFCA, hFFCB, ...
; writes: hFFD0
RunRandomPatternCase_Case02::
Jump_060_5FBF:: ; address name
    ld a, b
    and a, $01
    cp a, $01
    jr nz, Jump_060_5FC8

Jump_060_5FC6::
    xor a, a
    ret

Jump_060_5FC8::
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld a, $04
    add_a_to_hl
    ld a, [hl]
    cp a, $FE
    jr z, Jump_060_5FC6
    cp a, $FF
    jr nz, Jump_060_5FC6
    call NextRandomSeed
    ld a, [wCD04]
    and a, $1F
    ld c, a
    sla a
    add a, c
    ld de, Data_060_61E5
    add a, e
    ld e, a
    jr nc, Jump_060_5FF2
    inc d

Jump_060_5FF2::
    call StoreThreeBytesBeforeHFFC6Pointer
    ld [hl], $00
    ld hl, $0004
    call StoreHFFC8To3BytesBeforeHLPlusHFFC6
    ld [hl], $01
    ldh a, [hFFCD]
    swap a
    and a, $F0
    ldh [hFFD0], a
    ldh a, [hFFC8]
    ld e, a
    ldh a, [hFFC9]
    ld d, a
    ld a, e
    add a, $C0
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ldh a, [hFFCA]
    ld b, a
    call ReadByteInBank
    ldh a, [hFFCB]
    ld l, a
    ldh a, [hFFCC]
    ld h, a
    ldh a, [hFFD0]
    or a, c
    ld [hl], a
    inc de
    call ReadByteInBank
    inc hl
    ldh a, [hFFD0]
    or a, c
    ld [hl], a
    ld a, $01
    ret

; entry 1 of the `rst $00` table in RunRandomPatternCase
; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6, hFFC7, wCD04, hFFCD, hFFC8, hFFC9, hFFCA, hFFCB, ...
; writes: hFFD0
RunRandomPatternCase_Case01::
Jump_060_6031:: ; address name
    ld a, b
    cp a, $02
    jr c, Jump_060_6038

Jump_060_6036::
    xor a, a
    ret

Jump_060_6038::
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld a, $08
    add_a_to_hl
    ld a, [hl]
    cp a, $FE
    jr z, Jump_060_6036
    call NextRandomSeed
    ld a, [wCD04]
    and a, $1F
    ld c, a
    sla a
    add a, c
    ld de, Data_060_616D
    add a, e
    ld e, a
    jr nc, Jump_060_605E
    inc d

Jump_060_605E::
    call StoreThreeBytesBeforeHFFC6Pointer
    ld [hl], $00
    ld hl, $0008
    call StoreHFFC8To3BytesBeforeHLPlusHFFC6
    ld [hl], $01
    ldh a, [hFFCD]
    swap a
    and a, $F0
    ldh [hFFD0], a
    ldh a, [hFFC8]
    ld e, a
    ldh a, [hFFC9]
    ld d, a
    ld a, e
    add a, $C0
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ldh a, [hFFCA]
    ld b, a
    call ReadByteInBank
    ldh a, [hFFCB]
    ld l, a
    ldh a, [hFFCC]
    ld h, a
    ldh a, [hFFD0]
    or a, c
    ld [hl], a
    inc de
    call ReadByteInBank
    inc hl
    inc hl
    ldh a, [hFFD0]
    or a, c
    ld [hl], a
    ld a, $01
    ret

; entry 0 of the `rst $00` table in RunRandomPatternCase
; no direct call (reached through a table, a jump or a vector)
; reads: wCD03, hFFCD, hFFC8, hFFC9, hFFCA, hFFCB, hFFCC, hFFD0
; writes: hFFD0
RunRandomPatternCase_Case00::
Jump_060_609E:: ; address name
    call NextRandomSeed
    ld a, [wCD03]
    and a, $1F
    ld c, a
    sla a
    add a, c
    ld de, Data_060_610D
    add a, e
    ld e, a
    jr nc, Jump_060_60B2
    inc d

Jump_060_60B2::
    call StoreThreeBytesBeforeHFFC6Pointer
    ld [hl], $00
    ldh a, [hFFCD]
    swap a
    and a, $F0
    ldh [hFFD0], a
    ldh a, [hFFC8]
    ld e, a
    ldh a, [hFFC9]
    ld d, a
    ld a, e
    add a, $60
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ldh a, [hFFCA]
    ld b, a
    call ReadByteInBank
    ldh a, [hFFCB]
    ld l, a
    ldh a, [hFFCC]
    ld h, a
    ldh a, [hFFD0]
    or a, c
    ld [hl], a
    ld a, $01
    ret

; copies three bytes at DE to the address in hFFC6/hFFC7 minus 3 and to hFFC8-hFFCA (E-0121)
; 4 call sites from 4 routines (e.g. RunRandomPatternCase_Case03, RunRandomPatternCase_Case02, RunRandomPatternCase_Case01, RunRandomPatternCase_Case00)
; reads: hFFC6, hFFC7
; writes: hFFC8, hFFC9, hFFCA
StoreThreeBytesBeforeHFFC6Pointer::
Func_060_60E0:: ; address name
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    dec hl
    dec hl
    dec hl
    ld a, [de]
    inc de
    ld [hl+], a
    ldh [hFFC8], a
    ld a, [de]
    inc de
    ld [hl+], a
    ldh [hFFC9], a
    ld a, [de]
    ld [hl+], a
    ldh [hFFCA], a
    ret

; HL += the word hFFC6/hFFC7, then stores hFFC8, hFFC9, hFFCA at HL - 3 onward (E-0119)
; 5 call sites from 3 routines (e.g. RunRandomPatternCase_Case03, RunRandomPatternCase_Case02, RunRandomPatternCase_Case01)
; reads: hFFC6, hFFC7, hFFC8, hFFC9, hFFCA
StoreHFFC8To3BytesBeforeHLPlusHFFC6::
Func_060_60F8:: ; address name
    ldh a, [hFFC6]
    add a, l
    ld l, a
    ldh a, [hFFC7]
    adc a, h
    ld h, a
    dec hl
    dec hl
    dec hl
    ldh a, [hFFC8]
    ld [hl+], a
    ldh a, [hFFC9]
    ld [hl+], a
    ldh a, [hFFCA]
    ld [hl+], a
    ret

Data_060_610D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01
    dw Data_060_6740
    db $62
    dw Data_060_6740
    db $C3
    dw Data_060_6740
    db $24
    dw Data_060_6741
    db $85
    dw Data_060_6741
    db $E6
    dw Data_060_6741
    db $47
    dw Data_060_6742
    db $A8
    dw Data_060_6742
    db $09
    dw Data_060_6743
    db $6A
    dw Data_060_6743
    db $CB
    dw Data_060_6743
    db $2C
    dw Data_060_6744
    db $8D
    dw Data_060_6744
    db $EE
    dw Data_060_6744
    db $4F
    dw Data_060_6745
    db $B0
    dw Data_060_6745
    db $B0
    dw Data_060_6745
    db $4F
    dw Data_060_6745
    db $EE, $44, $67, $8D, $44, $67, $2C, $44, $67, $CB, $43, $67, $6A, $43, $67, $09
    db $43, $67, $A8, $42, $67, $47, $42, $67, $E6, $41, $67, $85, $41, $67, $24, $41
    db $67, $C3
    dw Data_060_6740
    db $62
    dw Data_060_6740
    db $01
    dw Data_060_6740

Data_060_616D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $11
    dw Data_060_6746
    db $D3
    dw Data_060_6746
    db $95
    dw Data_060_6747
    db $57
    dw Data_060_6748
    db $19
    dw Data_060_6749
    db $DB
    dw Data_060_6749
    db $9D
    dw Data_060_674A
    db $5F
    dw Data_060_674B
    db $21
    dw Data_060_674C
    db $E3
    dw Data_060_674C
    db $A5
    dw Data_060_674D
    db $67
    dw Data_060_674E
    db $29
    dw Data_060_674F
    db $EB
    dw Data_060_674F
    db $AD
    dw Data_060_6750
    db $6F
    dw Data_060_6751
    db $6F
    dw Data_060_6751
    db $AD, $50, $67, $EB, $4F, $67, $29, $4F, $67, $67, $4E, $67, $A5, $4D, $67, $E3
    db $4C, $67, $21, $4C, $67, $5F, $4B, $67, $9D, $4A, $67, $DB, $49, $67, $19, $49
    db $67, $57, $48, $67, $95, $47, $67, $D3
    dw Data_060_6746
    db $11
    dw Data_060_6746
    db $31
    dw Data_060_6752
    db $31
    dw Data_060_6752
    db $31
    dw Data_060_6752
    db $31
    dw Data_060_6752
    db $31
    dw Data_060_6752
    db $31
    dw Data_060_6752
    db $31
    dw Data_060_6752
    db $31
    dw Data_060_6752

Data_060_61E5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $31
    dw Data_060_6752
    db $F3
    dw Data_060_6752
    db $B5
    dw Data_060_6753
    db $77
    dw Data_060_6754
    db $39
    dw Data_060_6755
    db $FB
    dw Data_060_6755
    db $BD
    dw Data_060_6756
    db $7F
    dw Data_060_6757
    db $41
    dw Data_060_6758
    db $03
    dw Data_060_6759
    db $C5
    dw Data_060_6759
    db $87
    dw Data_060_675A
    db $49
    dw Data_060_675B
    db $0B
    dw Data_060_675C
    db $CD
    dw Data_060_675C
    db $8F
    dw Data_060_675D
    db $8F
    dw Data_060_675D
    db $CD, $5C, $67, $0B, $5C, $67, $49, $5B, $67, $87, $5A, $67, $C5, $59, $67, $03
    db $59, $67, $41, $58, $67, $7F, $57, $67, $BD, $56, $67, $FB, $55, $67, $39, $55
    db $67, $77, $54, $67, $B5, $53, $67, $F3
    dw Data_060_6752
    db $31
    dw Data_060_6752

Data_060_6245:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $51
    dw Data_060_675E
    db $D5
    dw Data_060_675F
    db $59
    dw Data_060_6761
    db $DD
    dw Data_060_6762
    db $61
    dw Data_060_6764
    db $E5
    dw Data_060_6765
    db $69
    dw Data_060_6767
    db $ED
    dw Data_060_6768
    db $71
    dw Data_060_676A
    db $F5
    dw Data_060_676B
    db $79
    dw Data_060_676D
    db $FD
    dw Data_060_676E
    db $81
    dw Data_060_6770
    db $05
    dw Data_060_6772
    db $89
    dw Data_060_6773
    db $0D
    dw Data_060_6775
    db $0D
    dw Data_060_6775
    db $89, $73, $67, $05, $72, $67, $81, $70, $67, $FD, $6E, $67, $79, $6D, $67, $F5
    db $6B, $67, $71, $6A, $67, $ED, $68, $67, $69, $67, $67, $E5, $65, $67, $61, $64
    db $67, $DD, $62, $67, $59, $61, $67, $D5
    dw Data_060_675F
    db $51, $5E, $67, $91
    dw Data_060_6776
    db $D7, $78, $67, $1D
    dw Data_060_677B
    db $63, $7D, $67, $01
    dw Data_060_6840
    db $47, $42, $68, $8D
    dw Data_060_6844
    db $D3, $46, $68, $19
    dw Data_060_6849
    db $19, $49, $68, $19
    dw Data_060_6849
    db $19, $49, $68, $19
    dw Data_060_6849
    db $3C, $4A, $68, $5F
    dw Data_060_684B
    db $82, $4C, $68, $A5
    dw Data_060_684D
    db $EB, $4F, $68, $31
    dw Data_060_6852
    db $77, $54, $68, $BD
    dw Data_060_6856
    db $03, $59, $68, $49
    dw Data_060_685B
    db $8F, $5D, $68, $D5
    dw Data_060_685F
    db $3E, $63, $68, $A7
    dw Data_060_6866
    db $10, $6A, $68

; 2 call sites from 2 routines (e.g. Func_002_4628, ScriptCommandE0_Run_Case07)
; reads: wCC44, wC893, wC833, wCD0F, wCC47, wC88E, wC891, wCC42, ...
; writes: wC893, wCC47, hFFC6
; points at: wCC48, wCC4C
Func_060_62F9::
    ld a, [wCC44]
    cp a, $80
    ret nz
    ld a, [wC893]
    bit 7, a
    ret z
    and a, $7F
    ld [wC893], a
    ld a, [wC833]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [hl]
    call SetWCD0FBandForA
    ld a, [wCD0F]
    and a, $0F
    ld hl, Data_060_638D
    add_a_to_hl
    ld a, [hl]
    ld [wCC47], a
    ld b, a
    ld de, wCC48

Jump_060_6333::
    push de
    push bc
    ld a, b
    ldh [hFFC6], a
    call Func_060_54BB
    call Func_060_53E5
    or a, a
    jr nz, Jump_060_634E
    pop bc
    pop de
    ld a, $08
    add a, e
    ld e, a
    jr nc, Jump_060_634A
    inc d

Jump_060_634A::
    dec b
    jr nz, Jump_060_6333
    ret

Jump_060_634E::
    pop bc
    pop de
    ld a, [wCC47]
    sub a, b
    ld [wCC47], a
    jr z, Func_060_62F9
    ld a, [wC88E]
    or a, a
    ret z
    ld a, [wC891]
    bit 7, a
    ret z
    and a, $7F
    ld c, a
    ld a, [wCC42]
    cp a, c
    ret nz
    ld a, [wC890]
    ld c, a
    ld hl, wCC4C
    ld a, [wCC47]
    ld b, a

Jump_060_6377::
    ld a, [hl]
    cp a, c
    jr nz, Jump_060_6382
    dec hl
    dec hl
    dec hl
    dec hl
    set 7, [hl]
    ret

Jump_060_6382::
    ld a, $08
    add_a_to_hl
    dec b
    jr nz, Jump_060_6377
    ret

Data_060_638D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0F, $0F, $0F, $0F, $14, $14, $14, $14

; 2 call sites from 2 routines (e.g. Func_002_4628, ScriptCommandE0_Run_Case07)
; reads: wCC44, wC893, hMapId
; writes: wCC47, wCD0F, hFFC6
Func_060_639D::
    ld a, [wCC44]
    bit 7, a
    ret nz
    ld a, [wC893]
    bit 7, a
    ret z
    ldh a, [hMapId]
    cp a, $20
    jr z, Jump_060_63E0
    cp a, $30
    jr z, Jump_060_63F8
    cp a, $48
    jr z, Jump_060_6410
    cp a, $70
    jr z, Jump_060_6428
    cp a, $A8
    jp z, Jump_060_6440
    cp a, $B0
    jp z, Jump_060_6458
    cp a, $B8
    jp z, Jump_060_6470
    cp a, $A0
    jr z, Jump_060_63DB
    cp a, $C8
    jr z, Jump_060_63DB
    cp a, $D1
    jr z, Jump_060_63DB
    cp a, $DA
    jr z, Jump_060_63DB
    ret

Jump_060_63DB::
    xor a, a
    ld [wCC47], a
    ret

Jump_060_63E0::
    ld a, $0A
    ld [wCC47], a
    ld a, $00
    ld [wCD0F], a
    ld hl, Data_060_6705
    call RemoveWCC48EntryMatching
    ld a, $01
    ldh [hFFC6], a
    call MarkWCC48EntryForWC890
    ret

Jump_060_63F8::
    ld a, $0A
    ld [wCC47], a
    ld a, $03
    ld [wCD0F], a
    ld hl, $6905
    call RemoveWCC48EntryMatching
    ld a, $02
    ldh [hFFC6], a
    call MarkWCC48EntryForWC890
    ret

Jump_060_6410::
    ld a, $0F
    ld [wCC47], a
    ld a, $06
    ld [wCD0F], a
    ld hl, Data_060_6B05
    call RemoveWCC48EntryMatching
    ld a, $03
    ldh [hFFC6], a
    call MarkWCC48EntryForWC890
    ret

Jump_060_6428::
    ld a, $0F
    ld [wCC47], a
    ld a, $09
    ld [wCD0F], a
    ld hl, Data_060_6F85
    call RemoveWCC48EntryMatching
    ld a, $04
    ldh [hFFC6], a
    call MarkWCC48EntryForWC890
    ret

Jump_060_6440::
    ld a, $0A
    ld [wCC47], a
    ld a, $0B
    ld [wCD0F], a
    ld hl, Data_060_7405
    call RemoveWCC48EntryMatching
    ld a, $05
    ldh [hFFC6], a
    call MarkWCC48EntryForWC890
    ret

Jump_060_6458::
    ld a, $02
    ld [wCC47], a
    ld a, $0B
    ld [wCD0F], a
    ld hl, Data_060_7525
    call RemoveWCC48EntryMatching
    ld a, $06
    ldh [hFFC6], a
    call MarkWCC48EntryForWC890
    ret

Jump_060_6470::
    ld a, $08
    ld [wCC47], a
    ld a, $0D
    ld [wCD0F], a
    ld hl, Data_060_7555
    call RemoveWCC48EntryMatching
    ld a, $07
    ldh [hFFC6], a
    call MarkWCC48EntryForWC890
    ret

; clears bit 7 of wC893; walks the wCC47 8-byte entries at wCC48 and drops the count at the first entry for which Func_060_64F3 returns 0 (E-0125)
; 7 call sites from 1 routine (e.g. Func_060_639D)
; reads: wC893, wCC47
; writes: hFFCC, hFFCD, wC893, hFFC6, wCC47
; points at: wCC48
RemoveWCC48EntryMatching::
Func_060_6488:: ; address name
    ld a, l
    ldh [hFFCC], a
    ld a, h
    ldh [hFFCD], a
    ld a, [wC893]
    and a, $7F
    ld [wC893], a
    ld a, [wCC47]
    ld b, a
    ld de, wCC48

Jump_060_649D::
    push de
    push bc
    ld a, b
    ldh [hFFC6], a
    call Func_060_54BB
    call RemoveWCC48EntryMatching_Sub01
    or a, a
    jr z, Jump_060_64B8
    pop bc
    pop de
    ld a, $08
    add a, e
    ld e, a
    jr nc, Jump_060_64B4
    inc d

Jump_060_64B4::
    dec b
    jr nz, Jump_060_649D
    ret

Jump_060_64B8::
    pop bc
    pop de
    ld a, [wCC47]
    sub a, b
    ld [wCC47], a
    ret

; when wC88E is set and wC891 equals hFFC6, sets bit 7 of the entry whose byte 4 equals wC890 (E-0125)
; 7 call sites from 1 routine (e.g. Func_060_639D)
; reads: wC88E, wC891, hFFC6, wC890, wCC47
; points at: wCC4C
MarkWCC48EntryForWC890::
Func_060_64C2:: ; address name
    ld a, [wC88E]
    or a, a
    ret z
    ld a, [wC891]
    bit 7, a
    ret nz
    ld c, a
    ldh a, [hFFC6]
    cp a, c
    ret nz
    ld a, [wC890]
    ld c, a
    ld hl, wCC4C
    ld a, [wCC47]
    ld b, a

Jump_060_64DD::
    ld a, [hl]
    cp a, c
    jr nz, Jump_060_64E8
    dec hl
    dec hl
    dec hl
    dec hl
    set 7, [hl]
    ret

Jump_060_64E8::
    ld a, $08
    add_a_to_hl
    dec b
    jr nz, Jump_060_64DD
    ret

; only called from RemoveWCC48EntryMatching (E-0047)
; 1 call site from 1 routine (e.g. RemoveWCC48EntryMatching)
; reads: wMapWidthScreens, wCD04, wMapHeightScreens, hFFC9, hFFCA, hFFC6, wCC47, hFFD0, ...
; writes: hFFD0, hFFC9, hFFCA, hFFCB
; points at: wCC4C
RemoveWCC48EntryMatching_Sub01::
Func_060_64F3:: ; address name
    push de
    xor a, a
    ldh [hFFD0], a

Jump_060_64F7::
    ld a, [wMapWidthScreens]
    ld c, a

Jump_060_64FB::
    call NextRandomSeed
    ld a, [wCD04]
    and a, $0F
    cp a, c
    jr nc, Jump_060_64FB
    ldh [hFFC9], a
    ld a, [wMapHeightScreens]
    ld c, a

Jump_060_650C::
    call NextRandomSeed
    ld a, [wCD04]
    and a, $0F
    cp a, c
    jr nc, Jump_060_650C
    ldh [hFFCA], a
    ldh a, [hFFC9]
    swap a
    ld c, a
    ldh a, [hFFCA]
    or a, c
    ldh [hFFCB], a
    ld c, a
    ldh a, [hFFC6]
    ld b, a
    ld a, [wCC47]
    sub a, b
    jr z, Jump_060_654B
    ld b, a
    ld hl, wCC4C

Jump_060_6531::
    ld a, [hl]
    cp a, c
    jr nz, Jump_060_6541
    ldh a, [hFFD0]
    inc a
    ldh [hFFD0], a
    cp a, $64
    jr nz, Jump_060_64F7
    pop de
    xor a, a
    ret

Jump_060_6541::
    ld a, $08
    add_a_to_hl
    dec b
    jr nz, Jump_060_6531

Jump_060_654B::
    ld a, [wMapWidthScreens]
    add a, a
    add a, a
    add a, a
    ld c, a
    ldh a, [hFFCA]
    call Multiply8
    ldh a, [hFFC9]
    add a, a
    add a, a
    add a, a
    add_a_to_hl
    ld e, l
    ld d, h
    ldh a, [hFFCC]
    ld l, a
    ldh a, [hFFCD]
    ld h, a
    add hl, de

Jump_060_656A::
    push hl
    call NextRandomSeed
    ld a, [wCD04]
    and a, $03
    add a, a
    add_a_to_hl
    ld e, l
    ld d, h
    ld b, $61
    call ReadByteInBank
    ld a, c
    cp a, $FE
    jr nz, Jump_060_6589
    pop hl
    jp Jump_060_64F7

Jump_060_6589::
    cp a, $FF
    jr nz, Jump_060_6590
    pop hl
    jr Jump_060_656A

Jump_060_6590::
    pop hl
    swap a
    ld c, a
    push bc
    inc de
    call ReadByteInBank
    ld a, c
    pop bc
    or a, c
    pop de
    inc de
    inc de
    inc de
    inc de
    inc de
    ld [de], a
    dec de
    ldh a, [hFFCB]
    ld [de], a
    ld a, $01
    ret

; only called from FieldModeStateDispatch_Case04 (E-0047)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case04)
; reads: wCC44, hMapId, hMapScreenX, hMapScreenY, wCCEA, wCD04
; writes: wCCE9, wCCEA, wCD0F, hFFC8, hFFC9
; points at: wCCEB, hFFC9
FieldModeStateDispatch_Case04_Sub02::
Func_060_65AA:: ; address name
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_060_65B5
    call FieldModeStateDispatch_Case04_Sub02_Sub01
    ret

Jump_060_65B5::
    ldh a, [hMapId]
    cp a, $39
    jr nz, Jump_060_65C6
    ldh a, [hMapScreenX]
    cp a, $01
    jr nz, Jump_060_65C6
    ldh a, [hMapScreenY]
    cp a, $01
    ret z

Jump_060_65C6::
    ldh a, [hMapId]
    cp a, $2B
    jr nz, Jump_060_65D7
    ldh a, [hMapScreenX]
    cp a, $01
    jr nz, Jump_060_65D7
    ldh a, [hMapScreenY]
    cp a, $02
    ret z

Jump_060_65D7::
    ldh a, [hMapId]
    ld c, a
    ld hl, Data_060_663F
    ld b, $00

Jump_060_65DF::
    ld a, [hl+]
    cp a, $FF
    jr nz, Jump_060_65E9

Jump_060_65E4::
    xor a, a
    ld [wCCE9], a
    ret

Jump_060_65E9::
    cp a, c
    jr z, Jump_060_65EF
    inc b
    jr Jump_060_65DF

Jump_060_65EF::
    ld a, [wCCEA]
    or a, a
    jr z, Jump_060_65E4
    xor a, a
    ld [wCCEA], a
    ld a, b
    push af
    ld hl, Data_060_6634
    add_a_to_hl
    ld a, [hl]
    ld [wCD0F], a
    pop af
    ldh [hFFC8], a
    ld a, $03
    ld [wCCE9], a
    call NextRandomSeed
    ld a, [wCD04]
    and a, $1F
    ldh [hFFC9], a
    ld b, $03
    ld de, wCCEB

Jump_060_661E::
    push de
    push bc
    call FieldModeStateDispatch_Shared05
    call WriteTable669CWordForHFFC8HFFC9
    ld hl, hFFC9
    inc [hl]
    pop bc
    pop de
    inc de
    inc de
    inc de
    inc de
    dec b
    jr nz, Jump_060_661E
    ret

Data_060_6634:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $03, $03, $03, $03, $06, $06, $09, $09, $0C, $0C

Data_060_663F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2B, $38, $39, $3A, $53, $5D, $82, $83, $AD, $AE, $FF

; DE += 2; writes the word at $669C + 16 * hFFC8 + 2 * Data_060_6677[hFFC9] at DE (E-0121)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case04_Sub02)
; reads: hFFC8, hFFC9
WriteTable669CWordForHFFC8HFFC9::
Func_060_664A:: ; address name
    inc de
    inc de
    ldh a, [hFFC8]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, l
    add a, $9C
    ld l, a
    ld a, h
    adc a, $66
    ld h, a
    push hl
    ldh a, [hFFC9]
    ld hl, Data_060_6677
    add_a_to_hl
    ld a, [hl]
    pop hl
    sla a
    add_a_to_hl
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ret

Data_060_6677:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $182677, $8E

Data_060_6705:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $44, $11, $22, $21, $15, $10, $54, $00, $26, $10, $32, $11, $54, $12, $34, $02
    db $44, $02, $44, $02, $44, $02, $44, $10, $42, $22, $44, $21, $76, $12, $74, $11
    db $44, $03, $62, $02, $86, $23, $53, $13, $56, $03, $73, $12, $54, $22, $55, $21
    db $86, $01, $73, $20, $72, $00, $44, $00, $00, $00, $00

Data_060_6740:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_6741:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_6742:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_6743:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_6744:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_6745:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_6746:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_6747:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_6748:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_6749:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_674A:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_674B:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_674C:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_674D:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_674E:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_674F:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_6750:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_6751:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_6752:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_6753:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_6754:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_6755:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_6756:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_6757:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_6758:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_6759:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_675A:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_675B:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_675C:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_675D:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_675E:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_675F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_060_6761:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_6762:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_060_6764:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_6765:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_060_6767:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_6768:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_060_676A:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_676B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_060_676D:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_676E:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_060_6770:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_060_6772:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_6773:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_060_6775:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_060_6776:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00

Data_060_677B:: ; heuristic: target of a monotone pointer table; C0
    ds $C5, $00

Data_060_6840:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00

Data_060_6844:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00

Data_060_6849:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_060_684B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_060_684D:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00

Data_060_6852:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00

Data_060_6856:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00

Data_060_685B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00

Data_060_685F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $00

Data_060_6866:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00

; only called from FieldModeStateDispatch_Case04_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case04_Sub02)
; reads: wCC44, wCC43, wCC45, wCCEA, wC833, wCCED, wCCF1, wCCEE, ...
; writes: wCCE9, wCCEA
; points at: wCDB0, wCCEB
FieldModeStateDispatch_Case04_Sub02_Sub01::
Func_060_686C:: ; address name
    ld a, [wCC44]
    and a, $07
    cp a, $05
    jr z, Jump_060_687A

Jump_060_6875::
    xor a, a
    ld [wCCE9], a
    ret

Jump_060_687A::
    ld a, [wCC43]
    or a, a
    jr z, Jump_060_6875
    ld c, a
    ld a, [wCC45]
    swap a
    ld hl, wCDB0
    add_a_to_hl
    ld a, [hl]
    cp a, c
    jr z, Jump_060_6875
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    cp a, c
    jr z, Jump_060_6875
    ld a, [wCCEA]
    or a, a
    jr z, Jump_060_6875
    xor a, a
    ld [wCCEA], a
    ld a, [wC833]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [hl]
    call SetWCD0FBandForA
    ld a, $02
    ld [wCCE9], a
    ld b, $02
    ld de, wCCEB

Jump_060_68C2::
    push de
    push bc
    call FieldModeStateDispatch_Shared05
    call WriteRandomEntryFromTable690E
    pop bc
    pop de
    inc de
    inc de
    inc de
    inc de
    dec b
    jr nz, Jump_060_68C2
    ld a, [wCCED]
    ld c, a
    ld a, [wCCF1]
    cp a, c
    ret nz
    ld a, [wCCEE]
    ld c, a
    ld a, [wCCF2]
    cp a, c
    ret nz
    ld a, $01
    ld [wCCE9], a
    ret

; DE += 2; advances the random seed; hFFC6 = wCD04 & 7; writes Data_060_690E[hFFC6] at DE, calls Func_061_4706, then writes hFFC6 at the next byte (E-0121)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case04_Sub02_Sub01)
; reads: wCD04, hFFC6
; writes: hFFC6
WriteRandomEntryFromTable690E::
Func_060_68EB:: ; address name
    inc de
    inc de
    call NextRandomSeed
    ld a, [wCD04]
    and a, $07
    ldh [hFFC6], a
    ld hl, Data_060_690E
    add_a_to_hl
    ld a, [hl]
    ld [de], a
    inc de
    push de
    farcall LookupTable4818NibblePairForHFFC6
    pop de
    ldh a, [hFFC6]
    ld [de], a
    ret

Data_060_690E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $10, $12, $13, $20, $21, $23, $32

; hFFC9 = hFFC6; picks hFFC7 from the chance row Data_060_6969[level / 10] and hFFC8 from row Data_060_6A09 + $3C * (level / 10) (E-0125)
; 2 call sites from 2 routines (e.g. DebugAutomap_Update_Sub01, WriteKeyEntryHFFC6)
; reads: hFFC6
; writes: hFFC9, hFFC7, hFFC8
RollKeyContentsForLevelHFFC6::
Func_060_6916:: ; address name
    ldh a, [hFFC6]
    ldh [hFFC9], a
    ld l, a
    ld h, $00
    ld a, $0A
    call DivideHLByA
    ld a, l
    push af
    swap a
    ld hl, Data_060_6969
    add_a_to_hl
    call RandomBelow100
    ld c, a
    ld b, $00

Jump_060_6934::
    ld a, [hl+]
    or a, a
    jr z, Jump_060_693B
    cp a, c
    jr nc, Jump_060_693E

Jump_060_693B::
    inc b
    jr Jump_060_6934

Jump_060_693E::
    ld a, b
    ldh [hFFC7], a
    pop af
    ld c, $3C
    call Multiply8
    ld de, Data_060_6A09
    add hl, de
    call RandomBelow100
    ld c, a
    ld b, $00

Jump_060_6951::
    ld a, [hl+]
    cp a, c
    jr nc, Jump_060_6958
    inc b
    jr Jump_060_6951

Jump_060_6958::
    ld a, b
    ldh [hFFC8], a
    ret

; repeats NextRandomSeed until wCD04 & $7F is below 100; returns A = that value (E-0116)
; 2 call sites from 1 routine (e.g. RollKeyContentsForLevelHFFC6)
; reads: wCD04
RandomBelow100::
Func_060_695C:: ; address name
    call NextRandomSeed
    ld a, [wCD04]
    and a, $7F
    cp a, $64
    jr nc, RandomBelow100
    ret

Data_060_6969:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $182969, $A0

Data_060_6A09:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $182A09, $FC

Data_060_6B05:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $182B05, $15C

; hFFC6 = the index of the first of 20 SRAM-bank-2 slots ($195 bytes apart) whose marker is not $50 + index, or $FF when all match (E-0125)
; 3 call sites from 3 routines (e.g. RunWC46BMenuState_Case05_Sub01, DebugAutomap_Update_Sub01, RunWD780StateWhenNotFading_1B_Case01_Case21)
; reads: hFFC6
; writes: rRAMB, rRAMG, hFFC6
; points at: sA000
FindSRAMSlotMarkerIndex::
Func_060_6C61:: ; address name
    ld a, $02
    ld [rRAMB], a
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ldh [hFFC6], a
    ld hl, sA000
    ld b, $14
    ld c, $50

Jump_060_6C75::
    ld a, [hl]
    cp a, c
    jr nz, Jump_060_6C8E
    ld a, l
    add a, $95
    ld l, a
    ld a, h
    adc a, $01
    ld h, a
    ldh a, [hFFC6]
    inc a
    ldh [hFFC6], a
    inc c
    dec b
    jr nz, Jump_060_6C75
    ld a, $FF
    ldh [hFFC6], a

Jump_060_6C8E::
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ret

; when wCC42 < 20, writes wCC42 + $50 and the $194 bytes at wCD07 to SRAM bank 2 at $A000 + $195 * wCC42 (E-0121)
; 7 call sites from 6 routines (e.g. DebugAutomap_Update_Sub01, RunWC8C7Phase_Case02, Func_002_4F4C_Case07, RunWC46BMenuState_Case05, ...)
; reads: wCC42
; writes: rRAMB, rRAMG
; points at: wCD07
SaveWCD07RecordToSRAMSlotWCC42::
Func_060_6C96:: ; address name
    ld a, [wCC42]
    cp a, $14
    ret nc
    ld a, $02
    ld [rRAMB], a
    ld a, [wCC42]
    ld bc, $0195
    call Multiply8By16
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $A0
    ld h, a
    ld e, l
    ld d, h
    ld hl, wCD07
    ld a, $0A
    ld [rRAMG], a
    ld a, [wCC42]
    add a, $50
    ld [de], a
    inc de
    ld bc, $0194
    call CopyBytes
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ret

; when wCC42 < 20 and SRAM bank 2 slot wCC42 is marked wCC42 + $50, copies its $194 bytes to wCD07; counterpart of SaveWCD07RecordToSRAMSlotWCC42 (E-0124)
; 8 call sites from 8 routines (e.g. DebugAutomap_Update, RunWC46BMenuState_Case05, GameMode5_Init_Case02, GameMode5_Init_Case03, ...)
; reads: wCC42
; writes: rRAMB, rRAMG
; points at: wCD07
LoadWCD07RecordFromSRAMSlotWCC42::
Func_060_6CD1:: ; address name
    ld a, [wCC42]
    cp a, $14
    ret nc
    ld a, $02
    ld [rRAMB], a
    ld a, [wCC42]
    ld bc, $0195
    call Multiply8By16
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $A0
    ld h, a
    ld de, wCD07
    ld a, $0A
    ld [rRAMG], a
    ld a, [wCC42]
    add a, $50
    ld c, a
    ld a, [hl+]
    cp a, c
    jr nz, Jump_060_6D05
    ld bc, $0194
    call CopyBytes

Jump_060_6D05::
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ret

Data_060_6D0D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $182D0D, $60

Data_060_6D6D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_060_6E1D
    dw Data_060_6E24
    dw Data_060_6E2D
    dw Data_060_6E36
    dw Data_060_6E41
    dw Data_060_6E4A
    dw Data_060_6E51
    dw Data_060_6E54
    dw Data_060_6E59
    dw Data_060_6E60
    dw Data_060_6E6B
    dw Data_060_6E76
    dw Data_060_6E7F
    dw Data_060_6E8C
    dw Data_060_6E95
    dw Data_060_6E9C
    dw Data_060_6E9F
    dw Data_060_6EAC
    dw Data_060_6EB9
    dw Data_060_6EC6
    dw Data_060_6ED3
    dw Data_060_6EDC
    dw Data_060_6EE1
    dw Data_060_6EE4
    dw Data_060_6EE7
    dw Data_060_6EEC
    dw Data_060_6EF5
    dw Data_060_6F02
    dw Data_060_6F0F
    dw Data_060_6F18
    dw Data_060_6F1D
    dw Data_060_6F22
    dw Data_060_6F25
    dw Data_060_6F2E
    dw Data_060_6F35
    dw Data_060_6F40
    dw Data_060_6F4F
    dw Data_060_6F54
    dw Data_060_6F59
    dw Data_060_6F5C
    dw Data_060_6F63
    dw Data_060_6F6C
    dw Data_060_6F73
    dw Data_060_6F7E
    dw Data_060_6F8D
    dw Data_060_6F92
    dw Data_060_6F99
    dw Data_060_6F9C
    dw Data_060_6F9F
    dw Data_060_6FA4
    dw Data_060_6FA9
    dw Data_060_6FB0
    dw Data_060_6FB9
    dw Data_060_6FC6
    dw Data_060_6FD7
    dw Data_060_6FE0
    dw Data_060_6FE3
    dw Data_060_6FE6
    dw Data_060_6FEF
    dw Data_060_7000
    dw Data_060_700D
    dw Data_060_7010
    dw Data_060_7015
    dw Data_060_701E
    dw Data_060_7021
    dw Data_060_702C
    dw Data_060_7035
    dw Data_060_703C
    dw Data_060_704D
    dw Data_060_705A
    dw Data_060_7063
    dw Data_060_7066
    dw Data_060_7069
    dw Data_060_7070
    dw Data_060_7079
    dw Data_060_7084
    dw Data_060_7091
    dw Data_060_709C
    dw Data_060_70A7
    dw Data_060_70AE
    dw Data_060_70B1
    dw Data_060_70BE
    dw Data_060_70CB
    dw Data_060_70D8
    dw Data_060_70E5
    dw Data_060_70F2
    dw Data_060_7100
    dw Data_060_710D

Data_060_6E1D:: ; heuristic: target of a monotone pointer table; C0
    db $03, $02, $00, $05, $00, $0F, $00

Data_060_6E24:: ; heuristic: target of a monotone pointer table; C0
    db $04, $04, $00, $07, $00, $0A, $00, $14, $00

Data_060_6E2D:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $00, $08, $00, $09, $00, $0B, $00

Data_060_6E36:: ; heuristic: target of a monotone pointer table; C0
    db $05, $01, $00, $06, $00, $0C, $00, $0D, $00, $0E, $00

Data_060_6E41:: ; heuristic: target of a monotone pointer table; C0
    db $04, $11, $00, $13, $00, $15, $00, $16, $00

Data_060_6E4A:: ; heuristic: target of a monotone pointer table; C0
    db $03, $10, $00, $12, $00, $17, $00

Data_060_6E51:: ; heuristic: target of a monotone pointer table; C0
    db $01, $18, $00

Data_060_6E54:: ; heuristic: target of a monotone pointer table; C0
    db $02, $19, $00, $1A, $00

Data_060_6E59:: ; heuristic: target of a monotone pointer table; C0
    db $03, $28, $00, $31, $00, $32, $00

Data_060_6E60:: ; heuristic: target of a monotone pointer table; C0
    db $05, $2A, $00, $2E, $00, $34, $00, $36, $00, $39, $00

Data_060_6E6B:: ; heuristic: target of a monotone pointer table; C0
    db $05, $24, $00, $25, $00, $26, $00, $27, $00, $3A, $00

Data_060_6E76:: ; heuristic: target of a monotone pointer table; C0
    db $04, $2B, $00, $2C, $00, $30, $00, $35, $00

Data_060_6E7F:: ; heuristic: target of a monotone pointer table; C0
    db $06, $29, $00, $2D, $00, $2F, $00, $33, $00, $37, $00, $3B, $00

Data_060_6E8C:: ; heuristic: target of a monotone pointer table; C0
    db $04, $38, $00, $3D, $00, $3E, $00, $3F, $00

Data_060_6E95:: ; heuristic: target of a monotone pointer table; C0
    db $03, $3C, $00, $40, $00, $42, $00

Data_060_6E9C:: ; heuristic: target of a monotone pointer table; C0
    db $01, $41, $00

Data_060_6E9F:: ; heuristic: target of a monotone pointer table; C0
    db $06, $48, $00, $49, $00, $4A, $00, $4B, $00, $50, $00, $5B, $00

Data_060_6EAC:: ; heuristic: target of a monotone pointer table; C0
    db $06, $4D, $00, $4E, $00, $53, $00, $54, $00, $57, $00, $5A, $00

Data_060_6EB9:: ; heuristic: target of a monotone pointer table; C0
    db $06, $47, $00, $4F, $00, $51, $00, $52, $00, $58, $00, $59, $00

Data_060_6EC6:: ; heuristic: target of a monotone pointer table; C0
    db $06, $55, $00, $56, $00, $5D, $00, $5E, $00, $65, $00, $66, $00

Data_060_6ED3:: ; heuristic: target of a monotone pointer table; C0
    db $04, $4C, $00, $5F, $00, $62, $00, $63, $00

Data_060_6EDC:: ; heuristic: target of a monotone pointer table; C0
    db $02, $5C, $00, $61, $00

Data_060_6EE1:: ; heuristic: target of a monotone pointer table; C0
    db $01, $60, $00

Data_060_6EE4:: ; heuristic: target of a monotone pointer table; C0
    db $01, $64, $00

Data_060_6EE7:: ; heuristic: target of a monotone pointer table; C0
    db $02, $6A, $00, $73, $00

Data_060_6EEC:: ; heuristic: target of a monotone pointer table; C0
    db $04, $6D, $00, $70, $00, $74, $00, $75, $00

Data_060_6EF5:: ; heuristic: target of a monotone pointer table; C0
    db $06, $6C, $00, $71, $00, $72, $00, $76, $00, $77, $00, $84, $00

Data_060_6F02:: ; heuristic: target of a monotone pointer table; C0
    db $06, $6B, $00, $6E, $00, $6F, $00, $78, $00, $79, $00, $7A, $00

Data_060_6F0F:: ; heuristic: target of a monotone pointer table; C0
    db $04, $7B, $00, $7C, $00, $7D, $00, $80, $00

Data_060_6F18:: ; heuristic: target of a monotone pointer table; C0
    db $02, $7E, $00, $7F, $00

Data_060_6F1D:: ; heuristic: target of a monotone pointer table; C0
    db $02, $81, $00, $83, $00

Data_060_6F22:: ; heuristic: target of a monotone pointer table; C0
    db $01, $82, $00

Data_060_6F25:: ; heuristic: target of a monotone pointer table; C0
    db $04, $91, $00, $93, $00, $95, $00, $A6, $00

Data_060_6F2E:: ; heuristic: target of a monotone pointer table; C0
    db $03, $8D, $00, $90, $00, $97, $00

Data_060_6F35:: ; heuristic: target of a monotone pointer table; C0
    db $05, $8E, $00, $8F, $00, $92, $00, $96, $00, $98, $00

Data_060_6F40:: ; heuristic: target of a monotone pointer table; C0
    db $07, $94, $00, $99, $00, $9A, $00, $9D, $00, $9E, $00, $9F, $00, $A7, $00

Data_060_6F4F:: ; heuristic: target of a monotone pointer table; C0
    db $02, $A0, $00, $A1, $00

Data_060_6F54:: ; heuristic: target of a monotone pointer table; C0
    db $02, $9B, $00, $9C, $00

Data_060_6F59:: ; heuristic: target of a monotone pointer table; C0
    db $01, $A2, $00

Data_060_6F5C:: ; heuristic: target of a monotone pointer table; C0
    db $03, $A3, $00, $A4, $00, $A5, $00

Data_060_6F63:: ; heuristic: target of a monotone pointer table; C0
    db $04, $B0, $00, $B5, $00, $B9, $00, $BB, $00

Data_060_6F6C:: ; heuristic: target of a monotone pointer table; C0
    db $03, $B2, $00, $B3, $00, $BA, $00

Data_060_6F73:: ; heuristic: target of a monotone pointer table; C0
    db $05, $B6, $00, $B7, $00, $B8, $00, $BD, $00, $C2, $00

Data_060_6F7E:: ; heuristic: target of a monotone pointer table; C0
    db $07, $B1, $00, $B4, $00, $BC, $00

Data_060_6F85:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $BE, $00, $BF, $00, $C1, $00, $C9, $00

Data_060_6F8D:: ; heuristic: target of a monotone pointer table; C0
    db $02, $C0, $00, $C5, $00

Data_060_6F92:: ; heuristic: target of a monotone pointer table; C0
    db $03, $C3, $00, $C4, $00, $C7, $00

Data_060_6F99:: ; heuristic: target of a monotone pointer table; C0
    db $01, $C6, $00

Data_060_6F9C:: ; heuristic: target of a monotone pointer table; C0
    db $01, $C8, $00

Data_060_6F9F:: ; heuristic: target of a monotone pointer table; C0
    db $02, $D3, $00, $D6, $00

Data_060_6FA4:: ; heuristic: target of a monotone pointer table; C0
    db $02, $DC, $00, $DD, $00

Data_060_6FA9:: ; heuristic: target of a monotone pointer table; C0
    db $03, $D4, $00, $D8, $00, $E1, $00

Data_060_6FB0:: ; heuristic: target of a monotone pointer table; C0
    db $04, $D7, $00, $D9, $00, $EA, $00, $EC, $00

Data_060_6FB9:: ; heuristic: target of a monotone pointer table; C0
    db $06, $D5, $00, $DA, $00, $DB, $00, $DF, $00, $E2, $00, $E8, $00

Data_060_6FC6:: ; heuristic: target of a monotone pointer table; C0
    db $08, $DE, $00, $E0, $00, $E3, $00, $E4, $00, $E5, $00, $E6, $00, $E9, $00, $EB
    db $00

Data_060_6FD7:: ; heuristic: target of a monotone pointer table; C0
    db $04, $E7, $00, $ED, $00, $EE, $00, $F0, $00

Data_060_6FE0:: ; heuristic: target of a monotone pointer table; C0
    db $01, $EF, $00

Data_060_6FE3:: ; heuristic: target of a monotone pointer table; C0
    db $01, $F6, $00

Data_060_6FE6:: ; heuristic: target of a monotone pointer table; C0
    db $04, $F9, $00, $00, $01, $04, $01, $05, $01

Data_060_6FEF:: ; heuristic: target of a monotone pointer table; C0
    db $08, $F8, $00, $FA, $00, $FD, $00, $FE, $00, $FF, $00, $01, $01, $02, $01, $0F
    db $01

Data_060_7000:: ; heuristic: target of a monotone pointer table; C0
    db $06, $FB, $00, $FC, $00, $03, $01, $06, $01, $09, $01, $0E, $01

Data_060_700D:: ; heuristic: target of a monotone pointer table; C0
    db $01, $0A, $01

Data_060_7010:: ; heuristic: target of a monotone pointer table; C0
    db $02, $F7, $00, $0B, $01

Data_060_7015:: ; heuristic: target of a monotone pointer table; C0
    db $04, $07, $01, $08, $01, $0D, $01, $10, $01

Data_060_701E:: ; heuristic: target of a monotone pointer table; C0
    db $01, $0C, $01

Data_060_7021:: ; heuristic: target of a monotone pointer table; C0
    db $05, $1B, $01, $1D, $01, $1E, $01, $22, $01, $31, $01

Data_060_702C:: ; heuristic: target of a monotone pointer table; C0
    db $04, $19, $01, $1C, $01, $28, $01, $37, $01

Data_060_7035:: ; heuristic: target of a monotone pointer table; C0
    db $03, $1A, $01, $21, $01, $27, $01

Data_060_703C:: ; heuristic: target of a monotone pointer table; C0
    db $08, $1F, $01, $20, $01, $23, $01, $26, $01, $2B, $01, $2C, $01, $30, $01, $38
    db $01

Data_060_704D:: ; heuristic: target of a monotone pointer table; C0
    db $06, $24, $01, $29, $01, $2F, $01, $32, $01, $33, $01, $34, $01

Data_060_705A:: ; heuristic: target of a monotone pointer table; C0
    db $04, $25, $01, $2A, $01, $2D, $01, $2E, $01

Data_060_7063:: ; heuristic: target of a monotone pointer table; C0
    db $01, $35, $01

Data_060_7066:: ; heuristic: target of a monotone pointer table; C0
    db $01, $36, $01

Data_060_7069:: ; heuristic: target of a monotone pointer table; C0
    db $03, $3C, $01, $3D, $01, $44, $01

Data_060_7070:: ; heuristic: target of a monotone pointer table; C0
    db $04, $43, $01, $49, $01, $4D, $01, $5B, $01

Data_060_7079:: ; heuristic: target of a monotone pointer table; C0
    db $05, $40, $01, $41, $01, $45, $01, $4C, $01, $5A, $01

Data_060_7084:: ; heuristic: target of a monotone pointer table; C0
    db $06, $3E, $01, $3F, $01, $42, $01, $46, $01, $47, $01, $4A, $01

Data_060_7091:: ; heuristic: target of a monotone pointer table; C0
    db $05, $48, $01, $4B, $01, $4E, $01, $4F, $01, $50, $01

Data_060_709C:: ; heuristic: target of a monotone pointer table; C0
    db $05, $51, $01, $52, $01, $54, $01, $55, $01, $57, $01

Data_060_70A7:: ; heuristic: target of a monotone pointer table; C0
    db $03, $53, $01, $56, $01, $58, $01

Data_060_70AE:: ; heuristic: target of a monotone pointer table; C0
    db $01, $59, $01

Data_060_70B1:: ; heuristic: target of a monotone pointer table; C0
    db $06, $5F, $01, $62, $01, $65, $01, $6A, $01, $6B, $01, $6D, $01

Data_060_70BE:: ; heuristic: target of a monotone pointer table; C0
    db $06, $5F, $01, $62, $01, $65, $01, $6A, $01, $6B, $01, $6D, $01

Data_060_70CB:: ; heuristic: target of a monotone pointer table; C0
    db $06, $5F, $01, $62, $01, $65, $01, $6A, $01, $6B, $01, $6D, $01

Data_060_70D8:: ; heuristic: target of a monotone pointer table; C0
    db $06, $5F, $01, $62, $01, $65, $01, $6A, $01, $6B, $01, $6D, $01

Data_060_70E5:: ; heuristic: target of a monotone pointer table; C0
    db $06, $5F, $01, $62, $01, $65, $01, $6A, $01, $6B, $01, $6D, $01

Data_060_70F2:: ; heuristic: target of a monotone pointer table; C0
    db $06, $5F, $01, $62, $01, $65, $01, $6A, $01, $6B, $01, $6D, $01, $06

Data_060_7100:: ; heuristic: target of a monotone pointer table; C0
    db $06, $5F, $01, $62, $01, $65, $01, $6A, $01, $6B, $01, $6D, $01

Data_060_710D:: ; heuristic: target of a monotone pointer table; C0
    db $10, $60, $01, $61, $01, $63, $01, $64, $01, $66, $01, $67, $01, $68, $01, $69
    db $01, $6C, $01, $6E, $01, $6F, $01, $70, $01, $71, $01, $72, $01, $73, $01, $74
    db $01
    ds $2D7, $00

Data_060_7405:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $120, $00

Data_060_7525:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $30, $00

Data_060_7555:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $AAB, $00
