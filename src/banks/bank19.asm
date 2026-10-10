SECTION "Bank 19", ROMX[$4000], BANK[$19]
    db $19

; only called from GameMode4_Init (E-0047)
; 1 call site from 1 routine (e.g. GameMode4_Init)
; reads: wCFC5, wDataBank, wC58A, wD20C, wD25A, wD2A8
; writes: wDataBankSave, wCFC5, rRAMG, rRAMB, wD8A1, wD8A2, wD8A3
; points at: wD800, wBattlePhase, wCFD0, wD09D
GameMode4_Init_Sub01::
Func_019_4001:: ; address name
    ld a, [wCFC5]
    push af
    ld hl, wD800
    ld bc, $0303
    xor a, a
    call FillBytes
    ld a, [wDataBank]
    ld [wDataBankSave], a
    ld hl, wBattlePhase
    ld bc, $0008
    xor a, a
    call FillBytes
    ld hl, wCFD0
    ld bc, $0008
    xor a, a
    call FillBytes
    pop af
    ld [wCFC5], a
    call GameMode4_Init_Sub01_Sub01
    ld a, [wC58A]
    or a, a
    jr nz, Jump_019_4069
    ld hl, wD09D
    ld bc, $0200
    xor a, a
    call FillBytes
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    call GameMode4_Init_Sub01_Sub06
    call GameMode4_Init_Sub01_Sub07
    ld a, [wD20C]
    ld [wD8A1], a
    ld a, [wD25A]
    ld [wD8A2], a
    ld a, [wD2A8]
    ld [wD8A3], a
    ld a, $00
    ld [rRAMG], a
    jr Jump_019_4069

Jump_019_4069::
    call GameMode4_Init_Sub01_Sub04
    call GameMode4_Init_Sub01_Sub02
    call GameMode4_Init_Sub01_Sub03
    call GameMode4_Init_Sub01_Sub05
    call GameMode4_Init_Sub01_Sub08
    ret

; only called from GameMode4_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01)
; reads: wCFC5, wC58A, wC6FD, wCFDC, wC835, wC834, wC57F
; writes: wDAD7, wD802, wQueuedActionId, wDAAD, wD892, wC5FC, wC5FD, wC5FE, ...
; points at: wC46B, wDA5B, wDAD8, wBattleSlotOut, wBattleMonsterId, wDA08, wDAD4, wD895, ...
GameMode4_Init_Sub01_Sub01::
Func_019_4079:: ; address name
    ld a, [wCFC5]
    cp a, $04
    jr z, Jump_019_408B
    cp a, $05
    jr z, Jump_019_408B
    cp a, $09
    jr z, Jump_019_408B
    xor a, a
    jr Jump_019_408D

Jump_019_408B::
    ld a, $01

Jump_019_408D::
    ld [wDAD7], a
    ld a, $FF
    ld [wD802], a
    ld [wQueuedActionId], a
    ld [wDAAD], a
    ld [wD892], a
    ld hl, wC46B
    ld bc, $0008
    xor a, a
    call FillBytes
    xor a, a
    ld [wC5FC], a
    ld [wC5FD], a
    ld [wC5FE], a
    ld hl, wDA5B
    ld bc, $0008
    ld a, $FF
    call FillBytes
    ld hl, wDAD8
    ld bc, $0008
    ld a, $80
    call FillBytes
    ld hl, wBattleSlotOut
    ld bc, $0008
    ld a, $FF
    call FillBytes
    ld hl, wBattleMonsterId
    ld bc, $0010
    ld a, $FF
    call FillBytes
    ld a, $FF
    ld hl, wDA08
    ld bc, $0080
    call FillBytes
    ld a, $FF
    ld hl, wDAD4
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, $FF
    ld [wDAAB], a
    ld a, $0A
    ld [wD89F], a
    ld hl, wD895
    ld bc, $000A
    ld a, $FF
    call FillBytes
    xor a, a
    ld [wD891], a
    ld a, $00
    ld [wD092], a
    xor a, a
    ld [wCFD8], a
    ld [wCFD9], a
    ld [wCFDA], a
    ld a, [wC58A]
    or a, a
    jr nz, Jump_019_4140
    ld a, [wC6FD]
    ld [wD88F], a
    ld [wC984], a
    ld a, [wCFDC]
    inc a
    ld [wD890], a
    ld [wC985], a
    ld a, [wC835]
    ld [wCFDB], a
    ld a, [wC834]
    ld [wC964], a
    jr Jump_019_417E

Jump_019_4140::
    ld a, $03
    ld [wC964], a
    ld a, [wC57F]
    bit 1, a
    jr nz, Jump_019_4166
    ld hl, wD0EC
    call GameMode4_Init_Sub01_Sub01_Sub01
    ld [wD88F], a
    ld [wC984], a
    ld hl, wD1D6
    call GameMode4_Init_Sub01_Sub01_Sub01
    ld [wD890], a
    ld [wC985], a
    jr Jump_019_417E

Jump_019_4166::
    ld hl, wD0EC
    call GameMode4_Init_Sub01_Sub01_Sub01
    ld [wD890], a
    ld [wC984], a
    ld hl, wD1D6
    call GameMode4_Init_Sub01_Sub01_Sub01
    ld [wD88F], a
    ld [wC985], a

Jump_019_417E::
    xor a, a
    ld [wD057], a
    ld [wD058], a
    ret

; only called from GameMode4_Init_Sub01_Sub01 (E-0047)
; 4 call sites from 1 routine (e.g. GameMode4_Init_Sub01_Sub01)
GameMode4_Init_Sub01_Sub01_Sub01::
Func_019_4186:: ; address name
    ld de, $004E
    ld c, $01
    add hl, de
    ld a, [hl]
    or a, a
    jr z, Jump_019_4199
    ld c, $02
    add hl, de
    ld a, [hl]
    or a, a
    jr z, Jump_019_4199
    ld c, $03

Jump_019_4199::
    ld a, c
    ret

; only called from GameMode4_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01)
; writes: wC526
GameMode4_Init_Sub01_Sub02::
Func_019_419B:: ; address name
    farcall GameMode4_Init_Sub01_Sub02_Sub02
    farcall ClearAttributesAndScreenBuffer_Bank31
    farcall CopyRectRecordForWD88F_Bank31
    farcall LayoutTileBlocksForWD890Count
    farcall DrawPartySlotStatusPanels
    farcall Func_031_7321
    ld hl, vBGMap0
    call GameMode4_Init_Sub01_Sub02_Sub01
    ld a, $7F
    ld [wC526], a
    ret

; only called from GameMode4_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01)
; reads: wC57F, wD890
; points at: wD1C9, wD0DF, wD217, wD12D, wD265, wD17B
GameMode4_Init_Sub01_Sub03::
Func_019_41CB:: ; address name
    ld de, wD1C9
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_019_41D8
    ld de, wD0DF

Jump_019_41D8::
    ld hl, vTiles2 + $140
    ld c, $01
    call GameMode4_Init_Sub01_Sub03_Sub01
    ld a, [wD890]
    cp a, $01
    jr z, Jump_019_4218
    ld de, wD217
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_019_41F4
    ld de, wD12D

Jump_019_41F4::
    ld hl, vTiles2 + $380
    ld c, $03
    call GameMode4_Init_Sub01_Sub03_Sub01
    ld a, [wD890]
    cp a, $02
    jr z, Jump_019_4218
    ld de, wD265
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_019_4210
    ld de, wD17B

Jump_019_4210::
    ld hl, vTiles2 + $5C0
    ld c, $05
    call GameMode4_Init_Sub01_Sub03_Sub01

Jump_019_4218::
    ret

; only called from GameMode4_Init_Sub01_Sub03 (E-0047)
; 3 call sites from 1 routine (e.g. GameMode4_Init_Sub01_Sub03)
GameMode4_Init_Sub01_Sub03_Sub01::
Func_019_4219:: ; address name
    ld a, [de]
    push af
    inc de
    ld a, [de]
    ld d, a
    pop af
    ld e, a
    call LoadMonsterPicture
    ret

; only called from GameMode4_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01)
; reads: wD88F, wC57F, wD890, wD00B, wD00A
; writes: wSpeciesIdLo, wSpeciesIdHi
; points at: wD8A7, wBattleSlotOut, wBattleMonsterId
GameMode4_Init_Sub01_Sub04::
Func_019_4224:: ; address name
    ld a, [wD88F]
    ld b, a
    ld c, $00
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_019_4235
    ld a, [wD890]
    ld b, a

Jump_019_4235::
    call GameMode4_Init_Sub01_Sub04_Sub01
    inc c
    dec b
    jr nz, Jump_019_4235
    ld a, [wD890]
    ld b, a
    ld c, $04
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_019_424D
    ld a, [wD88F]
    ld b, a

Jump_019_424D::
    call GameMode4_Init_Sub01_Sub04_Sub01
    inc c
    dec b
    jr nz, Jump_019_424D
    call Func_019_43ED
    ld de, wD8A7
    ld bc, $0800

Jump_019_425D::
    push bc
    ld a, c
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_019_4291
    ld a, c
    add a, a
    ld hl, wBattleMonsterId
    add_a_to_hl
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    push de
    farcall LoadSpeciesRecord
    pop de
    ld a, [wD00B]
    ld h, a
    ld a, [wD00A]
    swap a
    or a, h
    ld [de], a

Jump_019_4291::
    pop bc
    inc de
    inc c
    dec b
    jr nz, Jump_019_425D
    ret

; 8 call sites from 8 routines (e.g. Func_019_4CF8, Func_019_4BA8, RecomputeTargetMaxHPAndMP, Func_036_4A38_Case01, ...)
; points at: wDA53, wBattleINT
Func_019_4298::
    push bc
    ld a, c
    ld hl, wDA53
    add_a_to_hl
    push hl
    ld a, c
    ld hl, wBattleINT
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    sub a, $1E
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    jr c, Jump_019_42E8
    ld a, l
    sub a, $46
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    jr c, Jump_019_42E4
    ld a, l
    sub a, $C2
    ld l, a
    ld a, h
    sbc a, $01
    ld h, a
    jr c, Jump_019_42E0
    ld a, l
    sub a, $5E
    ld l, a
    ld a, h
    sbc a, $01
    ld h, a
    jr c, Jump_019_42DC
    ld a, $04
    jr Jump_019_42EA

Jump_019_42DC::
    ld a, $03
    jr Jump_019_42EA

Jump_019_42E0::
    ld a, $02
    jr Jump_019_42EA

Jump_019_42E4::
    ld a, $01
    jr Jump_019_42EA

Jump_019_42E8::
    ld a, $00

Jump_019_42EA::
    pop hl
    ld [hl], a
    pop bc
    ret

; zero-fills the 47 bytes of wSpeciesRecord, where LoadSpeciesRecord writes; BC, HL kept (E-0067) (the same 15 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01_Sub04_Sub01)
; points at: wSpeciesRecord
ClearSpeciesRecordBuffer_Bank19::
Func_019_42EE:: ; address name
    push bc
    push hl
    ld hl, wSpeciesRecord
    ld bc, $002F
    xor a, a
    call FillBytes
    pop hl
    pop bc
    ret

; 1 call site from 1 routine (e.g. Func_019_4CF8)
; reads: wCFC5, wC58A, wC5E7, wC5E8
Func_019_42FD::
    ld a, [wCFC5]
    cp a, $02
    ret z
    cp a, $03
    ret z
    cp a, $05
    ret z
    ld a, [wC58A]
    or a, a
    ret nz
    push bc
    push hl
    ld a, [hl+]
    ld h, [hl]
    ld b, h
    ld l, a
    ld c, a
    call ScaleHLToEightTenths_Bank19
    ld a, c
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    push hl
    push af
    push bc
    push de
    push hl
    call NextTableByte
    pop hl
    pop de
    pop bc
    pop af
    ld a, [wC5E7]
    ld l, a
    ld a, [wC5E8]
    ld h, a

Jump_019_4332::
    call CompareHLToBC
    jr c, Jump_019_433F
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    jr Jump_019_4332

Jump_019_433F::
    pop bc
    add hl, bc
    pop bc
    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    pop bc
    ret

; 4 call sites from 4 routines (e.g. Func_019_4CF8, Func_019_4BA8, RunA04410Or456FBySlotC_Sub01, RunA04410Or456FBySlotC_Sub02)
; reads: wD868, wD86A, wD86B
; writes: wCFED, wRecordBuffer, wD868, wD869, wD86A, wD86B
; points at: wD988, wD989
Func_019_4349::
    ld a, [wD868]
    ld c, a

; 6 call sites from 6 routines (e.g. Func_019_4CF8, Func_019_4BA8, RecomputeTargetMaxHPAndMP, Func_036_4A38_Case01, ...)
; reads: wD868, wD86A, wD86B
; writes: wCFED, wRecordBuffer, wD868, wD869, wD86A, wD86B
; points at: wD988, wD989
Func_019_434D::
    ld hl, wD988
    ld a, c
    swap a
    add_a_to_hl
    ld b, $08

Jump_019_435A::
    ld a, $00
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    dec b
    jr nz, Jump_019_435A
    push bc
    ld a, c
    cp a, $04
    jr c, Jump_019_436B
    dec a
    ld c, a

Jump_019_436B::
    ld a, $4E
    call Multiply8
    pop bc
    ld a, l
    add a, $E3
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ld de, wD989
    ld a, c
    swap a
    add a, e
    ld e, a
    jr nc, Jump_019_4384
    inc d

Jump_019_4384::
    ld b, $08

Jump_019_4386::
    ld a, [hl+]
    ld [de], a
    inc de
    inc de
    ld a, [hl]
    or a, a
    jr z, Jump_019_4395
    cp a, $FF
    jr z, Jump_019_4395
    dec b
    jr nz, Jump_019_4386

Jump_019_4395::
    ld a, c
    ld de, wD989
    swap a
    add a, e
    ld e, a
    jr nc, Jump_019_43A0
    inc d

Jump_019_43A0::
    ld b, $08
    ld a, [wD868]
    push af
    xor a, a
    ld [wCFED], a

Jump_019_43AA::
    ld a, [de]
    cp a, $FF
    jr z, Jump_019_43E4
    push bc
    ld a, [de]
    ld [wRecordBuffer], a
    ld a, $03
    ld [wD868], a
    ld a, $01
    ld [wD869], a
    dec de
    push de
    ld a, e
    ld [wD86A], a
    ld a, d
    ld [wD86B], a
    farcall LoadSkillRecordPart
    ld a, [wD86A]
    ld e, a
    ld a, [wD86B]
    ld d, a
    ld a, [de]
    swap a
    and a, $0F
    ld [de], a
    pop de
    inc de
    inc de
    inc de
    pop bc
    dec b
    jr nz, Jump_019_43AA

Jump_019_43E4::
    pop af
    ld [wD868], a
    or a, a
    call nz, Func_019_43ED
    ret

; 2 call sites from 2 routines (e.g. Func_019_434D, GameMode4_Init_Sub01_Sub04)
; reads: wC58A
; points at: wD8AF, wD9C9, wD989
Func_019_43ED::
    ld bc, $0800
    ld hl, wD8AF

Jump_019_43F3::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_019_43FE
    ld a, [hl]
    or a, a
    call z, Func_019_4440

Jump_019_43FE::
    inc c
    inc hl
    dec b
    jr nz, Jump_019_43F3
    ld a, [wC58A]
    or a, a
    ret nz
    ld bc, $0304
    ld hl, wD9C9

Jump_019_440E::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_019_4430
    ld d, $04

Jump_019_4416::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_019_4430
    cp a, $34
    jr nz, Jump_019_4424
    call StoreTileADAtHL
    jr Jump_019_442B

Jump_019_4424::
    cp a, $35
    jr nz, Jump_019_442B
    call StoreTileAEAtHL

Jump_019_442B::
    inc hl
    inc hl
    dec d
    jr nz, Jump_019_4416

Jump_019_4430::
    inc c
    ld a, c
    swap a
    ld hl, wD989
    add_a_to_hl
    dec b
    jr nz, Jump_019_440E
    ret

; 1 call site from 1 routine (e.g. Func_019_43ED)
; points at: wD989
Func_019_4440::
    push hl
    ld a, c
    ld hl, wD989
    swap a
    add_a_to_hl
    ld d, $08

Jump_019_444E::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_019_4459
    cp a, $8F
    jr nz, Jump_019_445B
    ld [hl], $AA

Jump_019_4459::
    pop hl
    ret

Jump_019_445B::
    inc hl
    inc hl
    dec d
    jr nz, Jump_019_444E
    pop hl
    ret

; [HL] = $AD (E-0114)
; 1 call site from 1 routine (e.g. Func_019_43ED)
StoreTileADAtHL::
Func_019_4462:: ; address name
    ld [hl], $AD
    ret

; [HL] = $AE (E-0114)
; 1 call site from 1 routine (e.g. Func_019_43ED)
StoreTileAEAtHL::
Func_019_4465:: ; address name
    ld [hl], $AE
    ret

; 2 call sites from 2 routines (e.g. Func_019_4CF8, Func_019_4BA8)
; reads: wCFC5
; points at: wBattleSlotOut, wBattleStatus
Func_019_4468::
    push hl
    ld a, c
    ld de, wBattleSlotOut
    add a, e
    ld e, a
    jr nc, Jump_019_4472
    inc d

Jump_019_4472::
    bit 7, [hl]
    jr z, Jump_019_447B
    ld a, $01
    ld [de], a
    jr Jump_019_44A1

Jump_019_447B::
    ld a, $00
    ld [de], a
    ld a, [wCFC5]
    cp a, $04
    jr z, Jump_019_44A1
    ld a, c
    ld de, wBattleStatus
    add a, a
    add a, a
    add a, a
    add a, c
    add a, e
    ld e, a
    jr nc, Jump_019_4492
    inc d

Jump_019_4492::
    bit 0, [hl]
    jr z, Jump_019_4499
    ld a, $20
    ld [de], a

Jump_019_4499::
    bit 2, [hl]
    jr z, Jump_019_44A1
    ld a, [de]
    or a, $01
    ld [de], a

Jump_019_44A1::
    pop hl
    ret

; DE += C; copies the byte at HL to [DE]; HL += 1 (the same 9 bytes appear in 2 banks)
; 10 call sites from 2 routines (e.g. Func_019_4CF8, Func_019_4BA8)
StoreByteAtDEPlusC_Bank19::
Func_019_44A3:: ; address name
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_019_44A9
    inc d

Jump_019_44A9::
    ld a, [hl+]
    ld [de], a
    ret

; DE += 2 * C; copies the word at HL to [DE]; HL += 2, DE ends on the second byte written (the same 13 bytes appear in 2 banks)
; 22 call sites from 2 routines (e.g. Func_019_4CF8, Func_019_4BA8)
StoreWordAtDEPlus2C_Bank19::
Func_019_44AC:: ; address name
    ld a, c
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_019_44B3
    inc d

Jump_019_44B3::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ret

; 7 call sites from 7 routines (e.g. RecomputeTargetMaxHPAndMP, Func_036_4D0C, ActionEffect_Transform_Sub01, ActionEffect_TatsuCall_Sub01, ...)
; reads: wD868, wD869, wD86A, wD86B
Func_019_44B9::
    ld a, [wD868]
    ld l, a
    ld a, [wD869]
    ld h, a
    ld a, [wD86A]
    ld e, a
    ld a, [wD86B]
    ld d, a

; 2 call sites from 2 routines (e.g. Func_019_4CF8, Func_019_4BA8)
Func_019_44C9::
    push hl
    ld a, $1A
    add_a_to_hl
    ld a, [hl]
    and a, $03
    rrc a
    rrc a
    ld c, a
    pop hl
    ld a, [hl+]
    sla a
    sla a
    or a, [hl]
    inc hl
    sla a
    sla a
    or a, [hl]
    inc hl
    or a, c
    ld [de], a
    inc de
    ld b, $05

Jump_019_44EC::
    ld a, [hl+]
    sla a
    sla a
    or a, [hl]
    inc hl
    sla a
    sla a
    or a, [hl]
    inc hl
    sla a
    sla a
    or a, [hl]
    inc hl
    ld [de], a
    inc de
    dec b
    jr nz, Jump_019_44EC
    ld a, [hl+]
    sla a
    sla a
    or a, [hl]
    inc hl
    sla a
    sla a
    or a, [hl]
    sla a
    sla a
    ld [de], a
    ret

; only called from GameMode4_Init_Sub01_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01_Sub02)
; points at: wScreenTileBuffer
GameMode4_Init_Sub01_Sub02_Sub01::
Func_019_4516:: ; address name
    ld de, wScreenTileBuffer
    ld bc, $1412

Jump_019_451C::
    push bc
    push hl

Jump_019_451E::
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_019_451E
    ld a, $0C
    add a, e
    ld e, a
    jr nc, Jump_019_452D
    inc d

Jump_019_452D::
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_019_451C
    ret

; HL = (HL * 8) / 10 with 16-bit arithmetic (the multiply can overflow above 8191); BC and DE kept (E-0118)
; 1 call site from 1 routine (e.g. Func_019_42FD)
ScaleHLToEightTenths_Bank19::
Func_019_4537:: ; address name
    push bc
    push de
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, $0A
    call DivideHLByA
    pop de
    pop bc
    ret

; only called from GameMode4_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01)
; reads: wCFC5
GameMode4_Init_Sub01_Sub05::
Func_019_4544:: ; address name
    ld a, [wCFC5]
    or a, a
    jr z, Jump_019_454D
    dec a
    jr nz, Jump_019_4551

Jump_019_454D::
    ld a, $0F
    jr Jump_019_4553

Jump_019_4551::
    ld a, $13

Jump_019_4553::
    call QueueMusic
    ret

; only called from GameMode4_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01)
; reads: wD88F
; points at: wBattlerRecords
GameMode4_Init_Sub01_Sub06::
Func_019_4557:: ; address name
    ld a, [wD88F]
    ld b, a
    ld c, $00
    ld de, wBattlerRecords

Jump_019_4560::
    push bc
    call GameMode4_Init_Sub01_Sub06_Sub01
    pop bc
    inc c
    dec b
    jr nz, Jump_019_4560
    ret

; only called from GameMode4_Init_Sub01_Sub06 (E-0047)
; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01_Sub06)
GameMode4_Init_Sub01_Sub06_Sub01::
Func_019_456A:: ; address name
    ld a, c
    ld c, $01
    call SRAMRecordAddressMapped
    ld b, $0A

Jump_019_4572::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_019_4572
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, l
    add a, $25
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $08

Jump_019_45A6::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_019_45A6
    ld a, l
    add a, $19
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $15

Jump_019_45CC::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_019_45CC
    ld a, l
    add a, $02
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $04

Jump_019_45DC::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_019_45DC
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $1B

Jump_019_45EC::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_019_45EC
    ld a, l
    add a, $16
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    ld [de], a
    call Func_019_4605
    inc de
    ld a, $FF
    ld [de], a
    inc de
    ret

; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01_Sub06_Sub01)
; writes: hFFC6, hFFC7
Func_019_4605::
    or a, a
    ret z
    cp a, $0D
    ret c
    cp a, $14
    ret nc
    push af
    ld a, e
    ldh [hFFC6], a
    ld a, d
    ldh [hFFC7], a
    pop af
    push de
    sub a, $0D
    swap a
    ld de, Data_019_4641
    add a, e
    ld e, a
    jr nc, Jump_019_4622
    inc d

Jump_019_4622::
    ld a, [de]
    cp a, $80
    jr nz, Jump_019_4629
    pop de
    ret

Jump_019_4629::
    ld l, a
    ld h, $FF
    call IncrementTableByteCappedAt3
    inc de
    jr Jump_019_4622

; increments the byte at HL + the word hFFC6/hFFC7 unless it is already 3 or more (E-0118)
; 1 call site from 1 routine (e.g. Func_019_4605)
; reads: hFFC6, hFFC7
IncrementTableByteCappedAt3::
Func_019_4632:: ; address name
    ldh a, [hFFC6]
    add a, l
    ld l, a
    ldh a, [hFFC7]
    adc a, h
    ld h, a
    ld a, [hl]
    cp a, $03
    ret nc
    inc a
    ld [hl], a
    ret

Data_019_4641:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $064641, $70

; only called from BattleEnd_Step3_Sub06_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3_Sub06_Sub01)
; reads: wDAAB
; points at: wD20D, wD1BF
BattleEnd_Step3_Sub06_Sub01_Sub01::
Func_019_46B1:: ; address name
    ld de, wD20D
    ld a, [wDAAB]
    and a, $03
    ld c, a
    cp a, $01
    jr z, Jump_019_46C1
    ld de, wD1BF

Jump_019_46C1::
    push de
    ld a, e
    add a, $0D
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, [de]
    pop de
    push af
    push de
    call LoadMonsterAndSpeciesForListEntryC
    pop de
    ld a, e
    add a, $0D
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop af
    ld [de], a
    ret

; only called from GameMode4_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01)
; reads: wD890, wCFC5
; points at: wD1BF
GameMode4_Init_Sub01_Sub07::
Func_019_46DD:: ; address name
    ld a, [wD890]
    ld b, a
    ld c, $00
    ld de, wD1BF
    ld a, [wCFC5]
    cp a, $05
    jr z, Jump_019_46F3
    and a, $01
    jr z, Jump_019_46F3
    jr Jump_019_46FD

Jump_019_46F3::
    push bc
    call LoadMonsterAndSpeciesForListEntryC
    pop bc
    inc c
    dec b
    jr nz, Jump_019_46F3
    ret

Jump_019_46FD::
    push bc
    call GameMode4_Init_Sub01_Sub07_Sub01
    pop bc
    inc c
    ld a, e
    add a, $4E
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, Jump_019_46FD
    ret

; loads monster wCFDD[C] (LoadMonsterRecord), runs Func_019_4A9A, loads the species named in wRecordBuffer, then runs Func_019_4B37 (E-0121)
; 2 call sites from 2 routines (e.g. GameMode4_Init_Sub01_Sub07, BattleEnd_Step3_Sub06_Sub01_Sub01)
; reads: wRecordBuffer, wCFED
; writes: wMonsterId, wCFE7, wSpeciesIdLo, wSpeciesIdHi
; points at: wCFDD
LoadMonsterAndSpeciesForListEntryC::
Func_019_470F:: ; address name
    push bc
    ld a, c
    ld hl, wCFDD
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wCFE7], a
    push de
    farcall LoadMonsterRecord
    pop de
    pop bc
    push de
    call LoadMonsterAndSpeciesForListEntryC_Sub01
    pop de
    ld a, [wRecordBuffer]
    ld l, a
    ld a, [wCFED]
    ld h, a
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    push bc
    push de
    farcall LoadSpeciesRecord
    pop de
    pop bc
    call LoadMonsterAndSpeciesForListEntryC_Sub02
    pop bc
    ret

; only called from GameMode4_Init_Sub01_Sub07 (E-0047)
; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01_Sub07)
; reads: wD86A, wD86B, wSpeciesIdLo, wSpeciesIdHi, wSpeciesRecord, wD009, wD010, wD011, ...
; writes: wD86A, wD86B, wD869, hFFC7, wSpeciesIdLo, wSpeciesIdHi, hFFC6, wD868
; points at: wCFE3, wCFDD
GameMode4_Init_Sub01_Sub07_Sub01::
Func_019_4752:: ; address name
    push bc
    ld a, e
    ld [wD86A], a
    ld a, d
    ld [wD86B], a
    ld a, c
    ld [wD869], a
    ld hl, wCFE3
    add_a_to_hl
    ld a, [hl]
    ldh [hFFC7], a
    or a, a
    jr nz, Jump_019_4771
    ld a, $01
    ldh [hFFC7], a

Jump_019_4771::
    ld a, c
    add a, a
    ld hl, wCFDD
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wD86A]
    add a, $0A
    ld l, a
    ld a, [wD86B]
    adc a, $00
    ld h, a
    ld a, [wSpeciesIdLo]
    ld [hl+], a
    ld a, [wSpeciesIdHi]
    ld [hl+], a
    ld a, [wSpeciesRecord]
    ld [hl+], a
    ld a, [wD009]
    ld [hl+], a
    ld a, [wD010]
    ld [hl+], a
    ld a, [wD011]
    ld [hl+], a
    ld a, [wD012]
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ldh a, [hFFC7]
    ld [hl+], a
    ld a, [wD035]
    ld [hl+], a
    ld a, [wD036]
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    push hl
    ld a, [wD014]
    ldh [hFFC6], a
    farcall Func_01A_63A7
    pop hl
    ld a, $01
    ld [wD868], a
    call Func_019_48B1
    call StoreHFFC8WordAtHL_Bank19
    ld a, [wD015]
    ldh [hFFC6], a
    push hl
    farcall Func_01A_63A7
    pop hl
    ld a, $00
    ld [wD868], a
    call Func_019_48B1
    call StoreHFFC8WordAtHL_Bank19
    ld a, $02
    ld [wD868], a
    ld a, [wD016]
    ldh [hFFC6], a
    push hl
    farcall Func_01A_63A7
    pop hl
    call Func_019_48B1
    ld a, $03
    ld [wD868], a
    ld a, [wD017]
    ldh [hFFC6], a
    push hl
    farcall Func_01A_63A7
    pop hl
    call Func_019_48B1
    ld a, $00
    ld [wD868], a
    ld a, [wD018]
    ldh [hFFC6], a
    push hl
    farcall Func_01A_63A7
    pop hl
    call Func_019_48B1
    ld a, [wD019]
    ldh [hFFC6], a
    push hl
    farcall Func_01A_63A7
    pop hl
    call Func_019_48B1
    ld a, $E7
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    call StoreRandomByte80ToFFAtHL
    call StoreRandomByteAtHL_Bank19
    call StoreRandomByteAtHL_Bank19
    call StoreRandomByteAtHL_Bank19
    call CopyWD01ARecordToHL_Bank19
    ld a, $00
    ld [hl+], a
    push hl
    ld a, [wSpeciesIdLo]
    ld l, a
    ld a, [wSpeciesIdHi]
    ld h, a
    ld a, l
    add a, $1C
    ld l, a
    ld a, h
    adc a, $74
    ld h, a
    ld a, [hl]
    pop hl
    ld [hl+], a
    call Func_019_496F
    call Func_019_49B1
    farcall Func_01A_5FA7
    ld a, [wD86A]
    ld e, a
    ld a, [wD86B]
    ld d, a
    pop bc
    ret

; advances the random table (NextTableByte) and stores the new wC5E7 at HL; HL += 1; AF, BC, DE kept apart from A = the byte (E-0067) (the same 16 bytes appear in 2 banks)
; 3 call sites from 1 routine (e.g. GameMode4_Init_Sub01_Sub07_Sub01)
; reads: wC5E7
StoreRandomByteAtHL_Bank19::
Func_019_488D:: ; address name
    push af
    push bc
    push de
    push hl
    call NextTableByte
    pop hl
    pop de
    pop bc
    pop af
    ld a, [wC5E7]
    ld [hl+], a
    ret

; NextTableByte, then stores (wC5E7 & $7F) + $80 at HL; HL += 1 (E-0118)
; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01_Sub07_Sub01)
; reads: wC5E7
StoreRandomByte80ToFFAtHL::
Func_019_489D:: ; address name
    push af
    push bc
    push de
    push hl
    call NextTableByte
    pop hl
    pop de
    pop bc
    pop af
    ld a, [wC5E7]
    and a, $7F
    add a, $80
    ld [hl+], a
    ret

; 6 call sites from 1 routine (e.g. GameMode4_Init_Sub01_Sub07_Sub01)
; reads: hFFC8, hFFC9, wCFC5, wD868, wC96C, wD869, wD00B
; writes: hFFC8, hFFC9
Func_019_48B1::
    push af
    push bc
    push de
    push hl
    ldh a, [hFFC8]
    ld c, a
    ldh a, [hFFC9]
    ld b, a
    ld a, $01
    add a, $64
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    ld a, [wCFC5]
    cp a, $03
    jr nz, Jump_019_48EB
    ld a, [wD868]
    cp a, $01
    jr nz, Jump_019_48EB
    ld a, [wC96C]
    cp a, $01
    ld a, $05
    jr z, Jump_019_493C
    ld a, [wD869]
    cp a, $01
    ld a, $02
    jr nz, Jump_019_493C
    ld a, $05
    jr Jump_019_493C

Jump_019_48EB::
    ld a, [wD868]
    cp a, $02
    jr z, Jump_019_48FB
    cp a, $03
    jr z, Jump_019_490C
    ld bc, $03E7
    jr Jump_019_491F

Jump_019_48FB::
    ld a, [wCFC5]
    cp a, $03
    jr z, Jump_019_4907
    ld bc, $0258
    jr Jump_019_491F

Jump_019_4907::
    ld bc, $02BC
    jr Jump_019_491F

Jump_019_490C::
    ld bc, $02BC
    ld a, [wCFC5]
    cp a, $03
    jr nz, Jump_019_491F
    ld a, [wD00B]
    or a, a
    jr z, Jump_019_491F
    ld bc, $03E7

Jump_019_491F::
    ld a, e
    or a, a
    jr nz, Jump_019_4948
    push bc
    ld a, c
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    bit 7, b
    jr nz, Jump_019_4948
    pop bc
    jr Jump_019_494B

; no direct call (reached through a table, a jump or a vector)
; reads: wD869, hFFC8, hFFC9
; writes: hFFC8, hFFC9
Func_019_4931:: ; heuristic: follows a terminator; C0
    ld a, [wD869]
    cp a, $01
    ld a, $06
    jr nz, Jump_019_493C
    ld a, $0C

Jump_019_493C::
    call Multiply24By8
    ld a, d
    or a, e
    jr z, Jump_019_494B
    ld hl, $2710
    jr Jump_019_494B

Jump_019_4948::
    pop bc
    ld l, c
    ld h, b

Jump_019_494B::
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    pop hl
    pop de
    pop bc
    pop af
    ldh a, [hFFC8]
    ld [hl+], a
    ldh a, [hFFC9]
    ld [hl+], a
    ret

; stores hFFC8 then hFFC9 at HL; HL += 2; clobbers A (E-0065) (the same 7 bytes appear in 2 banks)
; 2 call sites from 1 routine (e.g. GameMode4_Init_Sub01_Sub07_Sub01)
; reads: hFFC8, hFFC9
StoreHFFC8WordAtHL_Bank19::
Func_019_495C:: ; address name
    ldh a, [hFFC8]
    ld [hl+], a
    ldh a, [hFFC9]
    ld [hl+], a
    ret

; copies the 27 ($1B) bytes at wD01A to HL; HL ends past the copy; clobbers A, B, DE (E-0065) (the same 12 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01_Sub07_Sub01)
; points at: wD01A
CopyWD01ARecordToHL_Bank19::
Func_019_4963:: ; address name
    ld de, wD01A
    ld b, $1B

Jump_019_4968::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_019_4968
    ret

; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01_Sub07_Sub01)
; reads: wD86A, wD86B, wC5E7, wD068
Func_019_496F::
    ld a, [wD86A]
    add a, $0D
    ld l, a
    ld a, [wD86B]
    adc a, $00
    ld h, a
    ld a, [hl]
    or a, a
    jr z, Jump_019_49A7
    cp a, $01
    jr z, Jump_019_498B
    cp a, $02
    jr z, Jump_019_498F
    ld b, $E6
    jr Jump_019_4991

Jump_019_498B::
    ld b, $02
    jr Jump_019_4991

Jump_019_498F::
    ld b, $80

Jump_019_4991::
    push af
    push bc
    push de
    push hl
    call NextTableByte
    pop hl
    pop de
    pop bc
    pop af
    ld a, [wC5E7]
    cp a, b
    jr c, Jump_019_49A5
    xor a, a
    jr Jump_019_49A7

Jump_019_49A5::
    ld a, $01

Jump_019_49A7::
    ld [hl], a
    ld a, [wD068]
    or a, a
    ret z
    res 4, a
    ld [hl], a
    ret

; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01_Sub07_Sub01)
; reads: wD86A, wD86B, hFFC7, hFFCD, hFFCE, wCFC5, hFFCF, hFFCA, ...
; writes: hFFCA, hFFCB, hFFCC, hFFCF, hFFCD, hFFCE
Func_019_49B1::
    ld a, [wD86A]
    add a, $18
    ld l, a
    ld a, [wD86B]
    adc a, $00
    ld h, a
    push de
    push hl
    xor a, a
    ldh [hFFCA], a
    ldh [hFFCB], a
    ldh [hFFCC], a
    ldh [hFFCF], a
    deref_hl
    ld a, l
    ldh [hFFCD], a
    ld a, h
    ldh [hFFCE], a
    ldh a, [hFFC7]
    ld b, a
    ld c, $01

Jump_019_49D6::
    push bc
    ldh a, [hFFCD]
    ld l, a
    ldh a, [hFFCE]
    ld h, a
    ld e, $00
    ld a, c
    call Multiply24By8
    ld a, [wCFC5]
    cp a, $03
    jr z, Jump_019_49F5
    ld a, $14
    call Divide24ByA
    ld c, a
    ldh a, [hFFCF]
    add a, c
    ldh [hFFCF], a

Jump_019_49F5::
    ldh a, [hFFCA]
    add a, l
    ldh [hFFCA], a
    ldh a, [hFFCB]
    adc a, h
    ldh [hFFCB], a
    ldh a, [hFFCC]
    adc a, e
    ldh [hFFCC], a
    pop bc
    inc c
    dec b
    jr nz, Jump_019_49D6
    ldh a, [hFFCF]
    ld b, a
    ld a, $14
    call DivideBByA
    ldh a, [hFFCA]
    add a, b
    ldh [hFFCA], a
    ldh a, [hFFCB]
    adc a, $00
    ldh [hFFCB], a
    ldh a, [hFFCC]
    adc a, $00
    ldh [hFFCC], a
    push bc
    push de
    ldh a, [hFFCC]
    ld e, a
    ldh a, [hFFCB]
    ld h, a
    ldh a, [hFFCA]
    ld l, a
    ld a, $03
    call Divide24ByA
    ld a, [wCFC5]
    cp a, $03
    jr nz, Jump_019_4A45
    sra e
    rr h
    rr l
    sra e
    rr h
    rr l

Jump_019_4A45::
    ld a, e
    or a, h
    or a, l
    jr nz, Jump_019_4A4D
    ld hl, $0001

Jump_019_4A4D::
    ld a, e
    ldh [hFFCC], a
    ld a, h
    ldh [hFFCB], a
    ld a, l
    ldh [hFFCA], a
    pop de
    pop bc
    ldh a, [hFFCC]
    ld e, a
    ldh a, [hFFCB]
    ld h, a
    ldh a, [hFFCA]
    ld l, a
    ld a, d
    or a, e
    jr z, Jump_019_4A68
    ld hl, $FFFF

Jump_019_4A68::
    pop bc
    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    inc bc
    ld a, $00
    ld [bc], a
    pop de
    ret

; DEHL = A * EHL (a 24-bit by 8-bit multiply from three Multiply8 calls) (E-0121)
; 2 call sites from 2 routines (e.g. Func_019_49B1, Func_019_4931)
Multiply24By8::
Func_019_4A74:: ; address name
    push af
    push hl
    ld c, e
    call Multiply8
    pop bc
    pop af
    push hl
    push af
    push bc
    ld c, b
    call Multiply8
    pop bc
    pop af
    push hl
    call Multiply8
    pop bc
    ld a, c
    add a, h
    ld h, a
    ld a, b
    adc a, $00
    ld e, a
    pop bc
    ld a, c
    add a, e
    ld e, a
    ld a, b
    adc a, $00
    ld d, a
    ret

; only called from LoadMonsterAndSpeciesForListEntryC (E-0047)
; 1 call site from 1 routine (e.g. LoadMonsterAndSpeciesForListEntryC)
; reads: wRecordBuffer, wCFED, wCFF5, wCFF2, wCFF3, wD002, wD003, wD005, ...
; points at: wRecordBufferData, wCFF6
LoadMonsterAndSpeciesForListEntryC_Sub01::
Func_019_4A9A:: ; address name
    push bc
    ld b, $0A
    ld a, $FF

Jump_019_4A9F::
    ld [de], a
    inc de
    dec b
    jr nz, Jump_019_4A9F
    ld a, [wRecordBuffer]
    ld [de], a
    inc de
    ld a, [wCFED]
    ld [de], a
    inc de
    inc de
    inc de
    ld b, $04
    ld hl, wRecordBufferData

Jump_019_4AB5::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_019_4AB5
    ld a, $FF
    ld b, $04

Jump_019_4ABF::
    ld [de], a
    inc de
    dec b
    jr nz, Jump_019_4ABF
    ld a, $00
    ld [de], a
    inc de
    ld a, [wCFF5]
    ld [de], a
    inc de
    ld a, [wCFF2]
    ld [de], a
    inc de
    ld a, [wCFF3]
    ld [de], a
    inc de
    ld a, $00
    ld [de], a
    inc de
    ld hl, wCFF6
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl-]
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
    ld a, [hl-]
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
    inc de
    ld a, $E7
    ld [de], a
    inc de
    ld a, $03
    ld [de], a
    inc de
    ld a, [wD002]
    ld [de], a
    inc de
    ld a, [wD003]
    ld [de], a
    inc de
    ld a, [wD005]
    ld [de], a
    inc de
    ld a, [wD004]
    ld [de], a
    inc de
    ld a, $1C
    add a, e
    ld e, a
    jr nc, Jump_019_4B31
    inc d

Jump_019_4B31::
    ld a, [wCFF4]
    ld [de], a
    pop bc
    ret

; only called from LoadMonsterAndSpeciesForListEntryC (E-0047)
; 1 call site from 1 routine (e.g. LoadMonsterAndSpeciesForListEntryC)
; reads: wSpeciesRecord, wD009, wC5E7, wD068
; points at: wD01A
LoadMonsterAndSpeciesForListEntryC_Sub02::
Func_019_4B37:: ; address name
    ld a, $0C
    add a, e
    ld e, a
    jr nc, Jump_019_4B3E
    inc d

Jump_019_4B3E::
    ld a, [wSpeciesRecord]
    ld [de], a
    inc de
    ld a, [wD009]
    or a, a
    jr z, Jump_019_4B71
    cp a, $01
    jr z, Jump_019_4B55
    cp a, $02
    jr z, Jump_019_4B59
    ld b, $E6
    jr Jump_019_4B5B

Jump_019_4B55::
    ld b, $02
    jr Jump_019_4B5B

Jump_019_4B59::
    ld b, $80

Jump_019_4B5B::
    push af
    push bc
    push de
    push hl
    call NextTableByte
    pop hl
    pop de
    pop bc
    pop af
    ld a, [wC5E7]
    cp a, b
    jr c, Jump_019_4B6F
    xor a, a
    jr Jump_019_4B71

Jump_019_4B6F::
    ld a, $01

Jump_019_4B71::
    ld [de], a
    ld a, [wD068]
    or a, a
    jr z, Jump_019_4B7B
    res 4, a
    ld [de], a

Jump_019_4B7B::
    ld a, $24
    add a, e
    ld e, a
    jr nc, Jump_019_4B82
    inc d

Jump_019_4B82::
    ld b, $1B
    ld hl, wD01A

Jump_019_4B87::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_019_4B87
    inc de
    inc de
    pop bc
    ret

; only called from GameMode4_Init_Sub01_Sub04 (E-0047)
; 2 call sites from 1 routine (e.g. GameMode4_Init_Sub01_Sub04)
; reads: wC58A, wD868, wD871
; points at: wBattleMonsterId, wD8AF, wDA43, wDA4B, wCFD8, wD8B7, wBattleMaxHP, wBattleMaxMP, ...
GameMode4_Init_Sub01_Sub04_Sub01::
Func_019_4B91:: ; address name
    ld a, [wC58A]
    or a, a
    jr nz, Func_019_4BA8
    ld a, c
    cp a, $04
    jr nc, Jump_019_4BA1
    call Func_019_4BA8
    jr Jump_019_4BA4

Jump_019_4BA1::
    call Func_019_4CF8

Jump_019_4BA4::
    call ClearSpeciesRecordBuffer_Bank19
    ret

; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01_Sub04_Sub01)
; reads: wC58A, wD868, wD871
; points at: wBattleMonsterId, wD8AF, wDA43, wDA4B, wCFD8, wD8B7, wBattleMaxHP, wBattleMaxMP, ...
Func_019_4BA8::
    ld a, c
    push bc
    call BattlerRecordAddress_Bank19
    pop bc
    ld a, c
    add a, a
    ld de, wBattleMonsterId
    add a, e
    ld e, a
    jr nc, Jump_019_4BB8
    inc d

Jump_019_4BB8::
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc hl
    ld a, c
    ld de, wD8AF
    add a, e
    ld e, a
    jr nc, Jump_019_4BCF
    inc d

Jump_019_4BCF::
    ld a, [hl]
    and a, $0F
    ld [de], a
    ld a, [wC58A]
    or a, a
    jr z, Jump_019_4BF5
    ld a, c
    ld de, wDA43
    add a, e
    ld e, a
    jr nc, Jump_019_4BE2
    inc d

Jump_019_4BE2::
    ld a, $00
    ld [de], a
    ld a, c
    ld de, wDA4B
    add a, e
    ld e, a
    jr nc, Jump_019_4BEE
    inc d

Jump_019_4BEE::
    ld a, $00
    ld [de], a
    inc hl
    push af
    jr Jump_019_4C19

Jump_019_4BF5::
    ld a, c
    ld de, wDA43
    add a, e
    ld e, a
    jr nc, Jump_019_4BFE
    inc d

Jump_019_4BFE::
    ld a, [hl+]
    swap a
    and a, $0F
    push af
    and a, $03
    ld [de], a
    pop af
    push af
    push af
    ld a, c
    ld de, wDA4B
    add a, e
    ld e, a
    jr nc, Jump_019_4C13
    inc d

Jump_019_4C13::
    pop af
    rrca
    rrca
    and a, $03
    ld [de], a

Jump_019_4C19::
    ld a, c
    cp a, $04
    jr nc, Jump_019_4C2D
    ld a, c
    ld de, wCFD8
    add a, e
    ld e, a
    jr nc, Jump_019_4C27
    inc d

Jump_019_4C27::
    pop af
    and a, $03
    ld [de], a
    jr Jump_019_4C2E

Jump_019_4C2D::
    pop af

Jump_019_4C2E::
    push hl
    push bc
    ld a, [wD868]
    or a, a
    jr nz, Jump_019_4C3B
    call Func_019_434D
    jr Jump_019_4C3E

Jump_019_4C3B::
    call Func_019_4349

Jump_019_4C3E::
    pop bc
    pop hl
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wD871]
    or a, a
    call z, Func_019_4468
    inc hl
    ld de, wD8B7
    call StoreByteAtDEPlusC_Bank19
    inc hl
    inc hl
    inc hl
    ld a, [wD871]
    or a, a
    jr z, Jump_019_4C71
    inc hl
    inc hl
    ld de, wBattleMaxHP
    call StoreWordAtDEPlus2C_Bank19
    inc hl
    inc hl
    ld de, wBattleMaxMP
    call StoreWordAtDEPlus2C_Bank19
    jr Jump_019_4C89

Jump_019_4C71::
    ld de, wBattleHP
    call StoreWordAtDEPlus2C_Bank19
    ld de, wBattleMaxHP
    call StoreWordAtDEPlus2C_Bank19
    ld de, wBattleMP
    call StoreWordAtDEPlus2C_Bank19
    ld de, wBattleMaxMP
    call StoreWordAtDEPlus2C_Bank19

Jump_019_4C89::
    ld de, wBattleATK
    call StoreWordAtDEPlus2C_Bank19
    ld de, wBattleDEF
    call StoreWordAtDEPlus2C_Bank19
    ld de, wBattleAGL
    call StoreWordAtDEPlus2C_Bank19
    ld de, wBattleINT
    call StoreWordAtDEPlus2C_Bank19
    ld de, wD93F
    call StoreWordAtDEPlus2C_Bank19
    ld a, [wD871]
    or a, a
    jr z, Jump_019_4CCA
    ld a, [wD868]
    push hl
    ld l, a
    add a, a
    add a, a
    add a, a
    add a, l
    ld hl, wD80D
    add_a_to_hl
    ld a, [hl]
    and a, $30
    pop hl
    jr nz, Jump_019_4CCA
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_019_4CE2

Jump_019_4CCA::
    ld de, wSlotPersonalityHi
    call StoreByteAtDEPlusC_Bank19
    ld de, wSlotPersonalityLo
    call StoreByteAtDEPlusC_Bank19
    ld de, wD980
    call StoreByteAtDEPlusC_Bank19
    ld de, wSlotPersonalityMid
    call StoreByteAtDEPlusC_Bank19

Jump_019_4CE2::
    ld a, c
    add a, a
    add a, c
    add a, a
    add a, c
    ld de, wDA72
    add a, e
    ld e, a
    jr nc, Jump_019_4CEF
    inc d

Jump_019_4CEF::
    push bc
    call Func_019_44C9
    pop bc
    call Func_019_4298
    ret

; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01_Sub04_Sub01)
; reads: wD868, wD871
; points at: wBattleMonsterId, wD8AF, wDA43, wD8B7, wBattleMaxHP, wBattleMaxMP, wBattleATK, wBattleDEF, ...
Func_019_4CF8::
    push bc
    call BattlerRecordAddress_Bank19
    pop bc
    ld a, c
    add a, a
    ld de, wBattleMonsterId
    add a, e
    ld e, a
    jr nc, Jump_019_4D07
    inc d

Jump_019_4D07::
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc hl
    ld a, c
    ld de, wD8AF
    add a, e
    ld e, a
    jr nc, Jump_019_4D1E
    inc d

Jump_019_4D1E::
    ld a, [hl+]
    ld [de], a
    ld a, c
    ld de, wDA43
    add a, e
    ld e, a
    jr nc, Jump_019_4D29
    inc d

Jump_019_4D29::
    ld a, $00
    ld [de], a
    push hl
    push bc
    ld a, [wD868]
    or a, a
    jr nz, Jump_019_4D39
    call Func_019_434D
    jr Jump_019_4D3C

Jump_019_4D39::
    call Func_019_4349

Jump_019_4D3C::
    pop bc
    pop hl
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wD871]
    or a, a
    call z, Func_019_4468
    inc hl
    ld de, wD8B7
    call StoreByteAtDEPlusC_Bank19
    inc hl
    inc hl
    inc hl
    ld a, [wD871]
    or a, a
    jr z, Jump_019_4D6F
    inc hl
    inc hl
    ld de, wBattleMaxHP
    call StoreWordAtDEPlus2C_Bank19
    inc hl
    inc hl
    ld de, wBattleMaxMP
    call StoreWordAtDEPlus2C_Bank19
    jr Jump_019_4D96

Jump_019_4D6F::
    ld de, wBattleHP
    call StoreWordAtDEPlus2C_Bank19
    push de
    push hl
    ld a, e
    sub a, $01
    ld l, a
    ld a, d
    sbc a, $00
    ld h, a
    call Func_019_42FD
    pop hl
    pop de
    ld de, wBattleMaxHP
    call StoreWordAtDEPlus2C_Bank19
    ld de, wBattleMP
    call StoreWordAtDEPlus2C_Bank19
    ld de, wBattleMaxMP
    call StoreWordAtDEPlus2C_Bank19

Jump_019_4D96::
    ld de, wBattleATK
    call StoreWordAtDEPlus2C_Bank19
    ld de, wBattleDEF
    call StoreWordAtDEPlus2C_Bank19
    ld de, wBattleAGL
    call StoreWordAtDEPlus2C_Bank19
    ld de, wBattleINT
    call StoreWordAtDEPlus2C_Bank19
    ld de, wD93F
    call StoreWordAtDEPlus2C_Bank19
    ld a, [wD871]
    or a, a
    jr z, Jump_019_4DD7
    ld a, [wD868]
    push hl
    ld l, a
    add a, a
    add a, a
    add a, a
    add a, l
    ld hl, wD80D
    add_a_to_hl
    ld a, [hl]
    and a, $30
    pop hl
    jr nz, Jump_019_4DD7
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_019_4DEF

Jump_019_4DD7::
    ld de, wSlotPersonalityHi
    call StoreByteAtDEPlusC_Bank19
    ld de, wSlotPersonalityLo
    call StoreByteAtDEPlusC_Bank19
    ld de, wD980
    call StoreByteAtDEPlusC_Bank19
    ld de, wSlotPersonalityMid
    call StoreByteAtDEPlusC_Bank19

Jump_019_4DEF::
    ld a, c
    add a, a
    add a, c
    add a, a
    add a, c
    ld de, wDA72
    add a, e
    ld e, a
    jr nc, Jump_019_4DFC
    inc d

Jump_019_4DFC::
    push bc
    call Func_019_44C9
    pop bc
    call Func_019_4298
    ret

; A = battle slot: for slots 3 and 7 returns at once with Z set and HL unchanged; otherwise HL = wBattlerRecords + $4E * A' with A' = A - 1 for slots 4-6 (as BattlerRecordFieldAddress without the field offset) (E-0067) (the same 23 bytes appear in 2 banks)
; 2 call sites from 2 routines (e.g. Func_019_4CF8, Func_019_4BA8)
BattlerRecordAddress_Bank19::
Func_019_4E05:: ; address name
    cp a, $03
    jr c, Jump_019_4E0E
    ret z
    cp a, $07
    ret z
    dec a

Jump_019_4E0E::
    ld c, $4E
    call Multiply8
    ld a, l
    add a, $D5
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ret

; only called from GameMode4_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01)
; reads: wC58A
; points at: wDA5F, wDA5B
GameMode4_Init_Sub01_Sub08::
Func_019_4E1C:: ; address name
    ld a, [wC58A]
    or a, a
    jr nz, Jump_019_4E3E
    ld hl, wDA5F
    ld bc, $0404

Jump_019_4E28::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr z, Jump_019_4E32
    ld [hl], $01
    jr Jump_019_4E34

Jump_019_4E32::
    ld [hl], $FF

Jump_019_4E34::
    inc hl
    inc c
    dec b
    jr nz, Jump_019_4E28
    ld bc, $0400
    jr Jump_019_4E41

Jump_019_4E3E::
    ld bc, $0800

Jump_019_4E41::
    ld hl, wDA5B

Jump_019_4E44::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr z, Jump_019_4E58
    ld a, c
    call CheckSlotStatusBlock
    jr c, Jump_019_4E54
    ld [hl], $00
    jr Jump_019_4E5A

Jump_019_4E54::
    ld [hl], $01
    jr Jump_019_4E5A

Jump_019_4E58::
    ld [hl], $FF

Jump_019_4E5A::
    inc c
    inc hl
    dec b
    jr nz, Jump_019_4E44
    ret
    INCBIN "dwm2-cobi-us.gbc", $064E60, $2520

; copies the 3 bytes at $4E60 + $129 * hFFC6 + 3 * hFFC7 into hFFC8-hFFCA (E-0120)
; 4 call sites from 4 routines (e.g. WithSRAMDraw4ACEAnd4BE8_Sub01, ScriptCommandE8_Run_Case09_Case13_Sub01, Func_031_6D28, Func_0F2_4B05)
; reads: hFFC6, hFFC7
; writes: hFFC8, hFFC9, hFFCA
LoadTable4E60EntryToHFFC8::
Func_019_7380:: ; address name
    ld bc, $0129
    ldh a, [hFFC6]
    call Multiply8By16
    ldh a, [hFFC7]
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    add hl, bc
    ld a, l
    add a, $60
    ld l, a
    ld a, h
    adc a, $4E
    ld h, a
    ld a, [hl+]
    ldh [hFFC8], a
    ld a, [hl+]
    ldh [hFFC9], a
    ld a, [hl]
    ldh [hFFCA], a
    ret

; loads species record [wC991] and copies three bytes of table $4E60 entry (wD00F * $129 + 3 * ([wC9DC] - 1)) to wC9DE (E-0121)
; 2 call sites from 2 routines (e.g. Func_001_6C48, BattleEnd_Step3)
; reads: wC991, wC992, wD00F, wC9DC
; writes: wSpeciesIdLo, wSpeciesIdHi
; points at: wC9DE
LoadTable4E60EntryForWC991ToWC9DE::
Func_019_73A2:: ; address name
    ld a, [wC991]
    ld l, a
    ld a, [wC992]
    ld h, a
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wD00F]
    ld bc, $0129
    call Multiply8By16
    ld a, [wC9DC]
    dec a
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    add hl, bc
    ld a, l
    add a, $60
    ld l, a
    ld a, h
    adc a, $4E
    ld h, a
    ld de, wC9DE
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ret

; loads species record [wCA36] and copies three bytes of table $4E60 entry (wD00F * $129 + 3 * ([wCA81] - 1)) to wCA83 (E-0121)
; 1 call site from 1 routine (e.g. Func_037_5C4E)
; reads: wCA36, wCA37, wD00F, wCA81
; writes: wSpeciesIdLo, wSpeciesIdHi
; points at: wCA83
LoadTable4E60EntryForWCA36ToWCA83::
Func_019_73DF:: ; address name
    ld a, [wCA36]
    ld l, a
    ld a, [wCA37]
    ld h, a
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wD00F]
    ld bc, $0129
    call Multiply8By16
    ld a, [wCA81]
    dec a
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    add hl, bc
    ld a, l
    add a, $60
    ld l, a
    ld a, h
    adc a, $4E
    ld h, a
    ld de, wCA83
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $06741C, $15C
    ds $24, $07
    ds $A64, $00
