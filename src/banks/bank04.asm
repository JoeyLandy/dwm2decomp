SECTION "Bank 04", ROMX[$4000], BANK[$04]
    db $04

; runs Func_004_4BB0 and Func_004_44CE; shared by the field mode states (E-0122)
; 7 call sites from 7 routines (e.g. FieldModeStateDispatch_Case00, FieldModeStateDispatch_Case01, FieldModeStateDispatch_Case02, FieldModeStateDispatch_Case03, ...)
FieldStateCommonUpdate::
Func_004_4001:: ; address name
    call AdvancePlayerAnimCounterAndRunPlayerSpriteMode
    call UpdateAndDrawSpriteSlots
    ret

; when wC88D bit 7 is set: clears wC88D, wSpriteSlotCount = wC83A and the $50 bytes at wC83B go back to wSpriteSlots (undoes SnapshotSpritesForSave) (E-0117)
; 2 call sites from 1 routine (e.g. LoadMapObjectsForScreen)
; reads: wSaveStateFlag, wSpriteSnapshotCount
; writes: wSaveStateFlag, wSpriteSlotCount
; points at: wSpriteSnapshot, wSpriteSlots
RestoreSpriteSnapshot::
Func_004_4008:: ; address name
    ld a, [wSaveStateFlag]
    bit 7, a
    ret z
    xor a, a
    ld [wSaveStateFlag], a
    ld a, [wSpriteSnapshotCount]
    ld [wSpriteSlotCount], a
    ld hl, wSpriteSnapshot
    ld de, wSpriteSlots
    ld bc, $0050
    call CopyBytes
    ret

; for key-world map types 2, 3, 4 and 6 places the area objects (stairs, chests, monsters) from the wCD89/wCDAC entries (E-0130)
; 1 call site from 1 routine (e.g. LoadMapObjectsForScreen)
; reads: wMapType, wKeyWorldFloor, wKeyWorldByte06, wKeyWorldFlags, wKeyWorldGoalKind, wKeyWorldObjFlag
; writes: wKeyWorldObjFlag, hTemp9, wSpriteSlotCount
; points at: wKeyWorldFloorState
SetupKeyWorldObjectsForMapType::
Func_004_4025:: ; address name
    xor a, a
    ld [wKeyWorldObjFlag], a
    ld a, [wMapType]
    and a, $07
    cp a, $03
    jr z, Jump_004_4041
    cp a, $04
    jr z, Jump_004_40A9
    cp a, $06
    jp z, Jump_004_40C4
    cp a, $02
    jp z, Jump_004_40F8
    ret

Jump_004_4041::
    ld a, [wKeyWorldFloor]
    add a, a
    add a, a
    ld hl, wKeyWorldFloorInfo + $1
    add_a_to_hl
    xor a, a
    ldh [hTemp9], a
    ld a, [hl]
    cp a, $06
    jr z, Jump_004_4082
    cp a, $02
    jr c, Jump_004_4093
    cp a, $04
    jr nc, Jump_004_4093
    push af
    cp a, $02
    jr nz, Jump_004_4068
    ld a, $01
    ld [wKeyWorldObjFlag], a

Jump_004_4068::
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState
    add_a_to_hl
    ld a, [hl]
    bit 7, a
    jr nz, Jump_004_407D
    pop af
    jr Jump_004_4093

Jump_004_407D::
    pop af
    add a, $08
    jr Jump_004_4093

Jump_004_4082::
    ld a, [wKeyWorldFlags]
    bit 7, a
    jr z, Jump_004_408E
    xor a, a
    ld [wSpriteSlotCount], a
    ret

Jump_004_408E::
    ld a, $01
    ldh [hTemp9], a
    ld a, [hl]

Jump_004_4093::
    dec a
    add a, a
    ld hl, KeyWorldObjectGridTable
    add_a_to_hl
    call SetupKeyWorldObjectsForMapType_Sub01
    ld a, [wKeyWorldObjFlag]
    or a, a
    ret z
    call PlaceObjectCB86ForKeyWorldGoalKind
    ret

Jump_004_40A9::
    xor a, a
    ldh [hTemp9], a
    ld c, $06
    ld a, [wKeyWorldGoalKind]
    cp a, $07
    jr nz, Jump_004_40B7
    ld c, $0E

Jump_004_40B7::
    ld a, c
    ld hl, KeyWorldObjectGridTable
    add_a_to_hl
    call SetupKeyWorldObjectsForMapType_Sub01
    ret

Jump_004_40C4::
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState + $3
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_004_40DA
    and a, $01
    jr z, Jump_004_40DF

Jump_004_40DA::
    xor a, a
    ld [wSpriteSlotCount], a
    ret

Jump_004_40DF::
    ld a, [wKeyWorldFlags]
    bit 7, a
    jr nz, Jump_004_40DA
    ld a, $01
    ldh [hTemp9], a
    ld a, $08
    ld hl, KeyWorldObjectGridTable
    add_a_to_hl
    call SetupKeyWorldObjectsForMapType_Sub01
    ret

Jump_004_40F8::
    xor a, a
    ldh [hTemp9], a
    ld a, [wKeyWorldFloor]
    add a, a
    add a, a
    ld hl, wKeyWorldEncounterTable + $3
    add_a_to_hl
    ld a, [hl]
    or a, a
    jr nz, Jump_004_4112
    ld a, [wKeyWorldByte06]
    or a, a
    jr z, Jump_004_4117

Jump_004_4112::
    xor a, a
    ld [wSpriteSlotCount], a
    ret

Jump_004_4117::
    ld a, $02
    ldh [hTemp9], a
    ld a, $0C
    ld hl, KeyWorldObjectGridTable
    add_a_to_hl
    call SetupKeyWorldObjectsForMapType_Sub01
    ret

; only called from SetupKeyWorldObjectsForMapType (E-0047)
; 4 call sites from 1 routine (e.g. SetupKeyWorldObjectsForMapType)
; reads: wMapWidthScreens, hMapScreenY, hMapScreenX, hTemp9, hTemp2, hTemp0, wKeyWorldGoalKind, hTempA, ...
; writes: wSpriteSlotCount, hTempA, hTemp4, hTemp5, hTemp2, hTemp0, hTemp1, hTemp3, ...
; points at: wSpriteSlots, wKeyWorldEncounterTable
SetupKeyWorldObjectsForMapType_Sub01::
Func_004_4129:: ; address name
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, [wMapWidthScreens]
    add a, a
    ld c, a
    ldh a, [hMapScreenY]
    call Multiply8
    ldh a, [hMapScreenX]
    add a, a
    add_a_to_hl
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    or a, e
    ret z
    ld a, [hl]
    ld d, a
    ld l, e
    ld h, d
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    cp a, $FF
    jr nz, Jump_004_415F
    ld a, e
    cp a, $FF
    jr nz, Jump_004_415B
    xor a, a
    ld [wSpriteSlotCount], a
    ret

Jump_004_415B::
    cp a, $FE
    jr z, Jump_004_415F

Jump_004_415F::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld l, e
    ld h, d
    ld a, [hl+]
    ld [wSpriteSlotCount], a
    ld b, a
    ld de, wSpriteSlots

Jump_004_416D::
    push bc
    ld a, b
    ldh [hTempA], a
    xor a, a
    ldh [hTemp4], a
    ld a, [hl+]
    ldh [hTemp5], a
    ld a, [hl+]
    ldh [hTemp2], a
    inc de
    ld [de], a
    inc de
    ldh a, [hTemp9]
    or a, a
    jr nz, Jump_004_418E
    ld a, [hl+]
    ldh [hTemp0], a
    ld [de], a
    inc de
    ld a, [hl+]
    ldh [hTemp1], a
    ld [de], a
    inc de
    jr Jump_004_41C0

Jump_004_418E::
    dec a
    jr nz, Jump_004_41A3
    inc hl
    inc hl
    ld a, [wKeyWorldEncounter]
    ldh [hTemp0], a
    ld [de], a
    inc de
    ld a, [wKeyWorldEncounter + $1]
    ldh [hTemp1], a
    ld [de], a
    inc de
    jr Jump_004_41C0

Jump_004_41A3::
    inc hl
    inc hl
    push hl
    ld a, [wKeyWorldFloor]
    and a, $0F
    add a, a
    add a, a
    ld hl, wKeyWorldEncounterTable
    add_a_to_hl
    ld a, [hl+]
    ldh [hTemp0], a
    ld [de], a
    inc de
    ld a, [hl]
    ldh [hTemp1], a
    ld [de], a
    inc de
    pop hl

Jump_004_41C0::
    ldh a, [hTemp2]
    or a, a
    jr z, Jump_004_41E7
    ldh a, [hTemp0]
    cp a, $09
    jr nc, Jump_004_41E7
    push hl
    swap a
    ld hl, KeyWorldGoalGraphicsTable
    add_a_to_hl
    ld a, [wKeyWorldGoalKind]
    add_a_to_hl
    ld a, [hl]
    ldh [hTemp0], a
    dec de
    dec de
    ld [de], a
    inc de
    inc de
    pop hl

Jump_004_41E7::
    push de
    ld a, e
    sub a, $04
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    ld a, [hl+]
    ld [de], a
    pop de
    ld a, [hl]
    ld [de], a
    push de
    ld a, $07
    add a, e
    ld e, a
    jr nc, Jump_004_41FD
    inc d

Jump_004_41FD::
    ld a, [hl+]
    ld [de], a
    pop de
    inc de
    ld a, [hl]
    ld [de], a
    push de
    ld a, $07
    add a, e
    ld e, a
    jr nc, Jump_004_420B
    inc d

Jump_004_420B::
    ld a, [hl+]
    ld [de], a
    pop de
    inc de
    ld a, [hl+]
    ldh [hTemp3], a
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ldh a, [hTempA]
    and a, $03
    ld [de], a
    xor a, a
    inc de
    ld [de], a
    inc de
    inc de
    inc de
    ld [de], a
    inc de
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    push hl
    push de
    call DecompressGraphicsTemp0ToTemp4
    pop de
    pop hl
    pop bc
    dec b
    jp nz, Jump_004_416D
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ret

; E-0221 (C1: SetupKeyWorldObjectsForMapType_Sub01, for an object whose graphics number (hTemp0) is below 9 and whose hTemp2 is non-zero, replaces it with the byte at $423D + 16 * hTemp0 + wKeyWorldGoalKind; 9 rows end at the code at $42CD).
; record: replacement graphics number for each goal kind 0-9, then six zero bytes
KeyWorldGoalGraphicsTable::
Data_004_423D:: ; address name
    db $0E, $0E, $0E, $0E, $0E, $0E, $0E, $44, $0E, $0E, $00, $00, $00, $00, $00, $00 ; id 0
    db $10, $52, $52, $4D, $10, $10, $10, $44, $10, $10, $00, $00, $00, $00, $00, $00 ; id 1
    db $08, $08, $2E, $24, $08, $08, $37, $44, $3C, $33, $00, $00, $00, $00, $00, $00 ; id 2
    db $09, $09, $2F, $25, $09, $09, $38, $44, $1B, $34, $00, $00, $00, $00, $00, $00 ; id 3
    db $0C, $0C, $30, $26, $0C, $0C, $39, $44, $1E, $35, $00, $00, $00, $00, $00, $00 ; id 4
    db $06, $06, $2D, $23, $06, $06, $36, $44, $18, $31, $00, $00, $00, $00, $00, $00 ; id 5
    db $12, $12, $12, $12, $12, $12, $12, $44, $12, $12, $00, $00, $00, $00, $00, $00 ; id 6
    db $15, $15, $15, $15, $15, $15, $15, $44, $15, $15, $00, $00, $00, $00, $00, $00 ; id 7
    db $00, $16, $00, $00, $00, $00, $00, $44, $16, $33, $00, $00, $00, $00, $00, $00 ; id 8

; on map screen (0, 0) or (1, 0) sets wCB8A/wCB8B and wCB86 for wCD0B values 1, 7, 8 or 9 (E-0125)
; 1 call site from 1 routine (e.g. SetupKeyWorldObjectsForMapType)
; reads: hMapScreenY, hMapScreenX, wKeyWorldGoalKind
; writes: wSpriteSlots
PlaceObjectCB86ForKeyWorldGoalKind::
Func_004_42CD:: ; address name
    ldh a, [hMapScreenY]
    or a, a
    ret nz
    ldh a, [hMapScreenX]
    or a, a
    jr nz, Jump_004_4309
    ld a, $20
    ld [wSpriteSlots + $C], a
    ld a, [wKeyWorldGoalKind]
    cp a, $01
    jr nz, Jump_004_42ED
    ld a, $20
    ld [wSpriteSlots + $B], a
    ld a, $01
    ld [wSpriteSlots + $7], a
    ret

Jump_004_42ED::
    cp a, $07
    jr nz, Jump_004_42FC
    ld a, $20
    ld [wSpriteSlots + $B], a
    ld a, $01
    ld [wSpriteSlots + $7], a
    ret

Jump_004_42FC::
    cp a, $08
    ret nz
    ld a, $30
    ld [wSpriteSlots + $B], a
    xor a, a
    ld [wSpriteSlots + $7], a
    ret

Jump_004_4309::
    ld a, [wKeyWorldGoalKind]
    cp a, $09
    ret nz
    ld a, $70
    ld [wSpriteSlots + $B], a
    ld a, $10
    ld [wSpriteSlots + $C], a
    ld a, $03
    ld [wSpriteSlots + $7], a
    ret

; hFFC6/hFFC7 = graphics number, hFFCA/hFFCB = VRAM destination: with hFFC8 = 0 the source and bank come from a 3-byte-per-entry table at $4EAA; otherwise from the word table at $43AC with bank $7D ($7E for numbers $50 and up); then DecompressToVRAM; on CGB it goes on to the palette (not read) (E-0093)
; 25 call sites from 15 routines (e.g. LoadPlayerSpriteGraphics, LoadPlayerAndFollowerSpriteGraphics, SetupKeyWorldObjectsForMapType_Sub01, SceneExplosion_Case09, ...)
; reads: hTemp2, hTemp0, hTemp1, hTemp4, hTemp5, wIsCGB, hTemp3
; points at: wOBJPaletteBuffer
DecompressGraphicsTemp0ToTemp4::
Func_004_431F:: ; address name
    ldh a, [hTemp2]
    or a, a
    jr nz, Jump_004_433C
    ld de, MonsterSpriteTable
    push de
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld l, e
    ld h, d
    add hl, hl
    add hl, de
    pop de
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    ld b, a
    jr Jump_004_4354

Jump_004_433C::
    ld de, FieldSpriteGraphicsTable
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    add hl, hl
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld b, $7D
    ldh a, [hTemp0]
    cp a, $50
    jr c, Jump_004_4354
    inc b

Jump_004_4354::
    ldh a, [hTemp4]
    ld l, a
    ldh a, [hTemp5]
    ld h, a
    call DecompressToVRAM
    ld a, [wIsCGB]
    or a, a
    ret z
    ldh a, [hTemp2]
    or a, a
    jr nz, Jump_004_437E
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, l
    add a, $28
    ld l, a
    ld a, h
    adc a, $73
    ld h, a
    ld e, l
    ld d, h
    ld b, $27
    jr Jump_004_4396

Jump_004_437E::
    ldh a, [hTemp0]
    ld de, FieldSpritePaletteIndex
    add a, e
    ld e, a
    jr nc, Jump_004_4388
    inc d

Jump_004_4388::
    ld a, [de]
    add a, a
    add a, a
    add a, a
    ld de, $4B15
    add a, e
    ld e, a
    jr nc, Jump_004_4394
    inc d

Jump_004_4394::
    ld b, $7E

Jump_004_4396::
    ldh a, [hTemp3]
    sla a
    sla a
    sla a
    ld hl, wOBJPaletteBuffer
    add_a_to_hl
    ld c, $08
    call CopyFromBank
    ret

; E-0143 (C1: DecompressGraphicsTemp0ToTemp4 with hFFC8 non-zero reads the word $43AC + 2 * hFFC6/7 in bank $04 and decompresses it from bank $7D, or $7E for numbers $50 and up; all 98 entries decode).
; record: compressed sprite graphics in bank $7D
FieldSpriteGraphicsTable::
Data_004_43AC:: ; address name
    dw FieldSpriteGfx00 ; id 0
    dw FieldSpriteGfx01 ; id 1
    dw FieldSpriteGfx02 ; id 2
    dw FieldSpriteGfx03 ; id 3
    dw FieldSpriteGfx04 ; id 4
    dw FieldSpriteGfx05 ; id 5
    dw FieldSpriteGfx06 ; id 6
    dw FieldSpriteGfx07 ; id 7
    dw FieldSpriteGfx08 ; id 8
    dw FieldSpriteGfx09 ; id 9
    dw FieldSpriteGfx0A ; id 10
    dw FieldSpriteGfx0B ; id 11
    dw FieldSpriteGfx0C ; id 12
    dw FieldSpriteGfx0D ; id 13
    dw FieldSpriteGfx0E ; id 14
    dw FieldSpriteGfx0F ; id 15
    dw FieldSpriteGfx10 ; id 16
    dw FieldSpriteGfx11 ; id 17
    dw FieldSpriteGfx12 ; id 18
    dw FieldSpriteGfx13 ; id 19
    dw FieldSpriteGfx14 ; id 20
    dw FieldSpriteGfx15 ; id 21
    dw FieldSpriteGfx16 ; id 22
    dw FieldSpriteGfx17 ; id 23
    dw FieldSpriteGfx18 ; id 24
    dw FieldSpriteGfx19 ; id 25
    dw FieldSpriteGfx1A ; id 26
    dw FieldSpriteGfx1B ; id 27
    dw FieldSpriteGfx1C ; id 28
    dw FieldSpriteGfx1D ; id 29
    dw FieldSpriteGfx1E ; id 30
    dw FieldSpriteGfx1F ; id 31
    dw FieldSpriteGfx20 ; id 32
    dw FieldSpriteGfx21 ; id 33
    dw FieldSpriteGfx22 ; id 34
    dw FieldSpriteGfx23 ; id 35
    dw FieldSpriteGfx24 ; id 36
    dw FieldSpriteGfx25 ; id 37
    dw FieldSpriteGfx26 ; id 38
    dw FieldSpriteGfx27 ; id 39
    dw FieldSpriteGfx28 ; id 40
    dw FieldSpriteGfx29 ; id 41
    dw FieldSpriteGfx2A ; id 42
    dw FieldSpriteGfx2B ; id 43
    dw FieldSpriteGfx2C ; id 44
    dw FieldSpriteGfx2D ; id 45
    dw FieldSpriteGfx2E ; id 46
    dw FieldSpriteGfx2F ; id 47
    dw FieldSpriteGfx30 ; id 48
    dw FieldSpriteGfx31 ; id 49
    dw FieldSpriteGfx32 ; id 50
    dw FieldSpriteGfx33 ; id 51
    dw FieldSpriteGfx34 ; id 52
    dw FieldSpriteGfx35 ; id 53
    dw FieldSpriteGfx36 ; id 54
    dw FieldSpriteGfx37 ; id 55
    dw FieldSpriteGfx38 ; id 56
    dw FieldSpriteGfx39 ; id 57
    dw FieldSpriteGfx3A ; id 58
    dw FieldSpriteGfx3B ; id 59
    dw FieldSpriteGfx3C ; id 60
    dw FieldSpriteGfx3D ; id 61
    dw FieldSpriteGfx3E ; id 62
    dw FieldSpriteGfx3F ; id 63
    dw FieldSpriteGfx40 ; id 64
    dw FieldSpriteGfx41 ; id 65
    dw FieldSpriteGfx42 ; id 66
    dw FieldSpriteGfx43 ; id 67
    dw FieldSpriteGfx44 ; id 68
    dw FieldSpriteGfx45 ; id 69
    dw FieldSpriteGfx46 ; id 70
    dw FieldSpriteGfx47 ; id 71
    dw FieldSpriteGfx48 ; id 72
    dw FieldSpriteGfx49 ; id 73
    dw FieldSpriteGfx4A ; id 74
    dw FieldSpriteGfx4B ; id 75
    dw FieldSpriteGfx4C ; id 76
    dw FieldSpriteGfx4D ; id 77
    dw FieldSpriteGfx4E ; id 78
    dw FieldSpriteGfx4F ; id 79

; E-0143 (C1: DecompressGraphicsTemp0ToTemp4 with hFFC8 non-zero reads the word $43AC + 2 * hFFC6/7 in bank $04 and decompresses it from bank $7D, or $7E for numbers $50 and up; all 98 entries decode); numbers $50-$61.
; record: compressed sprite graphics in bank $7E
FieldSpriteGraphicsTable50::
Data_004_444C:: ; address name
    dw FieldSpriteGfx50 ; id 80
    dw FieldSpriteGfx51 ; id 81
    dw FieldSpriteGfx52 ; id 82
    dw FieldSpriteGfx53 ; id 83
    dw FieldSpriteGfx54 ; id 84
    dw FieldSpriteGfx55 ; id 85
    dw FieldSpriteGfx56 ; id 86
    dw FieldSpriteGfx57 ; id 87
    dw FieldSpriteGfx58 ; id 88
    dw FieldSpriteGfx59 ; id 89
    dw FieldSpriteGfx5A ; id 90
    dw FieldSpriteGfx5B ; id 91
    dw FieldSpriteGfx5C ; id 92
    dw FieldSpriteGfx5D ; id 93
    dw FieldSpriteGfx5E ; id 94
    dw FieldSpriteGfx5F ; id 95
    dw FieldSpriteGfx60 ; id 96
    dw FieldSpriteGfx61 ; id 97

; sets bit 1 of hFF8C and of the flag byte (wCB8C + 16 * n) of object entries 0-4 (the counterpart of ClearBit1OfPlayerAndObjectFlags; RunMessageBox calls them around a message) (E-0120)
; 11 call sites from 11 routines (e.g. OpenFieldMenuOnA, ScriptCommand09_Case00, RunMessageBox_Bank12_Case00, RunMessageBoxStateIfActive_Bank12_Case00, ...)
; reads: hPlayerStateFlags, wSpriteSlots, wObject1, wObject2, wObject3, wObject4
; writes: hPlayerStateFlags, wSpriteSlots, wObject1, wObject2, wObject3, wObject4
SetBit1OfPlayerAndObjectFlags::
Func_004_4470:: ; address name
    ldh a, [hPlayerStateFlags]
    or a, $02
    ldh [hPlayerStateFlags], a
    ld a, [wSpriteSlots + $D]
    or a, $02
    ld [wSpriteSlots + $D], a
    ld a, [wObject1 + $D]
    or a, $02
    ld [wObject1 + $D], a
    ld a, [wObject2 + $D]
    or a, $02
    ld [wObject2 + $D], a
    ld a, [wObject3 + $D]
    or a, $02
    ld [wObject3 + $D], a
    ld a, [wObject4 + $D]
    or a, $02
    ld [wObject4 + $D], a
    ret

; clears bit 1 of hFF8C and of the flag byte (wCB8C + 16 * n) of object entries 0-4 (E-0072)
; 15 call sites from 15 routines (e.g. FieldModeStateDispatch_Case02_Sub01, RunGameMode5Case01SubStates_Case02_Case00_Case02, ArenaMenu_Case1A_Sub01, ArenaMenu_Shared03, ...)
; reads: hPlayerStateFlags, wSpriteSlots, wObject1, wObject2, wObject3, wObject4
; writes: hPlayerStateFlags, wSpriteSlots, wObject1, wObject2, wObject3, wObject4
ClearBit1OfPlayerAndObjectFlags::
Func_004_449F:: ; address name
    ldh a, [hPlayerStateFlags]
    and a, $FD
    ldh [hPlayerStateFlags], a
    ld a, [wSpriteSlots + $D]
    and a, $FD
    ld [wSpriteSlots + $D], a
    ld a, [wObject1 + $D]
    and a, $FD
    ld [wObject1 + $D], a
    ld a, [wObject2 + $D]
    and a, $FD
    ld [wObject2 + $D], a
    ld a, [wObject3 + $D]
    and a, $FD
    ld [wObject3 + $D], a
    ld a, [wObject4 + $D]
    and a, $FD
    ld [wObject4 + $D], a
    ret

; unless bit 7 of wC468 is set: updates the sprite slots, then draws each slot's metasprite at its position relative to the scroll (E-0129)
; 5 call sites from 5 routines (e.g. FieldStateCommonUpdate, RunNameEntryStateWhenNotFading_Shared01, GameMode6_Update_Shared06, GameMode5_Update_Case07_Sub01_Sub03, ...)
; reads: wFieldActionRequest, wSpriteSlotCount, hScrollX, hScrollXHi, hScrollY, hScrollYHi, hSpriteAttrXor, hTemp0
; writes: hTemp0, hSpriteAttrXor, hSpriteTileOffset, hSpriteOriginX, hSpriteOriginXHi, hSpriteOriginY, hSpriteOriginYHi, hSpriteSubIndex, ...
; points at: wSpriteSlots
UpdateAndDrawSpriteSlots::
Func_004_44CE:: ; address name
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ld a, [wSpriteSlotCount]
    or a, a
    ret z
    call UpdateSpriteSlots
    ld a, [wSpriteSlotCount]
    ld b, a
    ld hl, wSpriteSlots

Jump_004_44E3::
    push hl
    inc hl
    ld a, [hl+]
    ldh [hTemp0], a
    push hl
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl+]
    and a, $07
    ldh [hSpriteAttrXor], a
    inc hl
    ld a, [hl+]
    ldh [hSpriteTileOffset], a
    inc hl
    inc hl
    ld a, [hl+]
    add a, $08
    ld d, a
    ldh a, [hScrollX]
    add a, d
    ldh [hSpriteOriginX], a
    ldh a, [hScrollXHi]
    adc a, $00
    ldh [hSpriteOriginXHi], a
    ld a, [hl+]
    add a, $10
    ld d, a
    ldh a, [hScrollY]
    add a, d
    ldh [hSpriteOriginY], a
    ldh a, [hScrollYHi]
    adc a, $00
    ldh [hSpriteOriginYHi], a
    inc hl
    ld a, [hl]
    bit 7, a
    jr z, Jump_004_4526
    push af
    ldh a, [hSpriteAttrXor]
    or a, $20
    ldh [hSpriteAttrXor], a
    pop af
    and a, $7F

Jump_004_4526::
    ldh [hSpriteSubIndex], a
    pop hl
    push bc
    ldh a, [hTemp0]
    or a, a
    jr nz, Jump_004_4555
    ld a, [hl+]
    and a, $7F
    ldh [hSpriteSetIndex], a
    ld a, [hl-]
    or a, a
    jr nz, Jump_004_454D
    ld a, [hl]
    bit 7, a
    jr nz, Jump_004_4545
    farcall DrawMetaSpriteSet_Bank25
    jr Jump_004_455F

Jump_004_4545::
    farcall DrawMetaSpriteSet_Bank26
    jr Jump_004_455F

Jump_004_454D::
    farcall DrawMetaSpriteSet_Bank27
    jr Jump_004_455F

Jump_004_4555::
    ld a, [hl+]
    inc hl
    ldh [hSpriteSetIndex], a
    farcall DrawMetaSprite4008

Jump_004_455F::
    pop bc
    pop hl
    ld a, $10
    add_a_to_hl
    dec b
    jp nz, Jump_004_44E3
    ret

; for each of wSpriteSlotCount 16-byte slots at wSpriteSlots runs the routine for its type byte (jump table of six) (E-0124)
; 1 call site from 1 routine (e.g. UpdateAndDrawSpriteSlots)
; reads: wSpriteSlotCount
; points at: wSpriteSlots
UpdateSpriteSlots::
Func_004_456D:: ; address name
    ld a, [wSpriteSlotCount]
    ld b, a
    ld hl, wSpriteSlots

Jump_004_4574::
    push bc
    push hl
    push hl
    ld a, [hl]
    rst $00
    dw UpdateSpriteSlots_Case00
    dw UpdateSpriteSlots_Return
    dw UpdateSpriteSlots_Case02
    dw UpdateSpriteSlots_Case03
    dw UpdateSpriteSlots_Case04
    dw UpdateSpriteSlots_Case05

Jump_004_4585::
    pop hl
    pop bc
    ld a, $10
    add_a_to_hl
    dec b
    jr nz, Jump_004_4574
    ret

; entry 0 of the `rst $00` table in UpdateSpriteSlots
; no direct call (reached through a table, a jump or a vector)
UpdateSpriteSlots_Case00::
Jump_004_4592:: ; address name
    pop hl
    ld a, $0D
    add_a_to_hl
    ld a, [hl]
    dec hl
    dec hl
    dec hl
    dec hl
    bit 1, a
    jr nz, Jump_004_45A6
    ld a, [hl]
    inc a
    ld [hl], a

Jump_004_45A6::
    ld a, [hl]

Jump_004_45A7::
    ld c, a
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 2, a
    jr z, Jump_004_45BD
    ld a, c
    srl a
    srl a
    srl a
    and a, $01
    ld c, a
    jr Jump_004_45C5

Jump_004_45BD::
    ld a, c
    swap a
    srl a
    and a, $01
    ld c, a

Jump_004_45C5::
    ld a, l
    sub a, $06
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, [hl]
    cp a, $03
    jr nz, Jump_004_45EC
    ld a, $82
    add a, c
    push af
    ld a, $07
    add_a_to_hl
    pop af
    ld [hl], a
    pop hl
    pop bc
    ld a, $10
    add_a_to_hl
    dec b
    jr nz, Jump_004_4574
    ret

Jump_004_45EC::
    add a, a
    add a, c
    push af
    ld a, $07
    add_a_to_hl
    pop af
    ld [hl], a
    pop hl
    pop bc
    ld a, $10
    add_a_to_hl
    dec b
    jp nz, Jump_004_4574
    ret

; entry 2 of the `rst $00` table in UpdateSpriteSlots
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptRunning, wRandomLo
UpdateSpriteSlots_Case02::
Jump_004_4606:: ; address name
    pop hl
    push hl
    ld a, $0D
    add_a_to_hl
    ld a, [hl]
    dec hl
    dec hl
    dec hl
    dec hl
    bit 1, a
    jr z, Jump_004_461B
    inc hl
    jr Jump_004_461F

Jump_004_461B::
    ld a, [hl]
    inc a
    ld [hl+], a
    ld a, [hl]

Jump_004_461F::
    ld a, [hl]
    bit 7, a
    jr z, Jump_004_465C
    inc hl
    bit 6, a
    jr nz, Jump_004_4638
    ld a, [hl]
    dec a
    ld [hl], a
    ld a, l
    sub a, $04
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld [hl], $03
    jr Jump_004_4645

Jump_004_4638::
    ld a, [hl]
    inc a
    ld [hl], a
    ld a, l
    sub a, $04
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld [hl], $01

Jump_004_4645::
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    and a, $0F
    jp nz, Jump_004_46F8
    xor a, a
    ld [hl], a
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $FB
    ld [hl], a
    jp Jump_004_46F8

Jump_004_465C::
    ld a, [wScriptRunning]
    or a, a
    jp nz, Jump_004_46F8
    dec hl
    ld a, [hl]
    cp a, $70
    jp nz, Jump_004_46F8
    xor a, a
    ld [hl+], a
    call NextTableByte
    ld a, [wRandomLo]
    and a, $03
    cp a, $03
    jr z, Jump_004_46B9
    and a, $01
    jr z, Jump_004_46F8
    push hl
    inc hl
    ld a, [hl]
    or a, a
    jr z, Jump_004_46F7
    ld a, l
    sub a, $07
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, [hl]
    ld c, a
    ld a, $07
    add_a_to_hl
    ld a, [hl]
    sub a, c
    cp a, $E0
    jr z, Jump_004_46F7
    ld a, [hl+]
    sub a, $10
    ld b, a
    ld a, [hl]
    ld c, a
    call IsTileUnderCellBlocking
    cp a, $01
    jr z, Jump_004_46F7
    call UpdateSpriteSlots_Shared01
    or a, a
    jr nz, Jump_004_46F7
    pop hl
    ld [hl], $80
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    or a, $04
    ld [hl], a
    jr Jump_004_46F8

Jump_004_46B9::
    push hl
    inc hl
    ld a, [hl]
    cp a, $90
    jr z, Jump_004_46F7
    ld a, l
    sub a, $07
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, [hl]
    ld c, a
    ld a, $07
    add_a_to_hl
    ld a, [hl]
    sub a, c
    cp a, $20
    jr z, Jump_004_46F7
    ld a, [hl+]
    add a, $11
    ld b, a
    ld a, [hl]
    ld c, a
    call IsTileUnderCellBlocking
    cp a, $01
    jr z, Jump_004_46F7
    call UpdateSpriteSlots_Shared01
    or a, a
    jr nz, Jump_004_46F7
    pop hl
    ld [hl], $C0
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    or a, $04
    ld [hl], a
    jr Jump_004_46F8

Jump_004_46F7::
    pop hl

Jump_004_46F8::
    pop hl
    ld a, $09
    add_a_to_hl
    ld a, [hl]
    jp Jump_004_45A7

; entry 1 of the `rst $00` table in UpdateSpriteSlots
; no direct call (reached through a table, a jump or a vector)
UpdateSpriteSlots_Return::
Jump_004_4704:: ; address name
    ret

; entry 3 of the `rst $00` table in UpdateSpriteSlots
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptRunning, wRandomLo
UpdateSpriteSlots_Case03::
Jump_004_4705:: ; address name
    pop hl
    push hl
    ld a, $0D
    add_a_to_hl
    ld a, [hl]
    dec hl
    dec hl
    dec hl
    dec hl
    bit 1, a
    jr z, Jump_004_471A
    inc hl
    jr Jump_004_471E

Jump_004_471A::
    ld a, [hl]
    inc a
    ld [hl+], a
    ld a, [hl]

Jump_004_471E::
    ld a, [hl]
    bit 7, a
    jr z, Jump_004_4784
    push hl
    inc hl
    swap a
    srl a
    and a, $03
    jr z, Jump_004_4761
    dec a
    jr z, Jump_004_4742
    dec a
    jr z, Jump_004_4751
    ld a, [hl]
    dec a
    ld [hl], a
    ld a, l
    sub a, $04
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld [hl], $03
    jr Jump_004_476F

Jump_004_4742::
    ld a, [hl]
    inc a
    ld [hl], a
    ld a, l
    sub a, $04
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld [hl], $01
    jr Jump_004_476F

Jump_004_4751::
    inc hl
    ld a, [hl]
    dec a
    ld [hl], a
    ld a, l
    sub a, $05
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld [hl], $02
    jr Jump_004_476F

Jump_004_4761::
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    ld a, l
    sub a, $05
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld [hl], $00

Jump_004_476F::
    pop hl
    ld a, [hl]
    inc a
    ld [hl], a
    and a, $0F
    jp nz, Jump_004_4846
    xor a, a
    ld [hl], a
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $FB
    ld [hl], a
    jp Jump_004_4846

Jump_004_4784::
    ld a, [wScriptRunning]
    or a, a
    jp nz, Jump_004_4846
    dec hl
    ld a, [hl]
    cp a, $E0
    jp nz, Jump_004_4846
    xor a, a
    ld [hl+], a
    call NextTableByte
    ld a, [wRandomLo]
    and a, $03
    jr z, Jump_004_481C
    dec a
    jr z, Jump_004_47CD
    dec a
    jr z, Jump_004_47F4
    push hl
    inc hl
    ld a, [hl]
    or a, a
    jp z, Jump_004_4845
    ld a, [hl+]
    sub a, $10
    ld b, a
    ld a, [hl]
    ld c, a
    call RunPendingFieldEventType0AOrOther
    cp a, $01
    jp z, Jump_004_4845
    call UpdateSpriteSlots_Shared01
    or a, a
    jp nz, Jump_004_4845
    pop hl
    ld [hl], $E0
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    or a, $04
    ld [hl], a
    jr Jump_004_4846

Jump_004_47CD::
    push hl
    inc hl
    ld a, [hl]
    cp a, $90
    jr z, Jump_004_4845
    ld a, [hl+]
    add a, $11
    ld b, a
    ld a, [hl]
    ld c, a
    call RunPendingFieldEventType0AOrOther
    cp a, $01
    jr z, Jump_004_4845
    call UpdateSpriteSlots_Shared01
    or a, a
    jr nz, Jump_004_4845
    pop hl
    ld [hl], $A0
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    or a, $04
    ld [hl], a
    jr Jump_004_4846

Jump_004_47F4::
    push hl
    inc hl
    inc hl
    ld a, [hl]
    or a, a
    jr z, Jump_004_4845
    dec hl
    ld a, [hl+]
    ld b, a
    ld a, [hl]
    sub a, $10
    ld c, a
    call RunPendingFieldEventType0AOrOther
    cp a, $01
    jr z, Jump_004_4845
    call UpdateSpriteSlots_Shared01
    or a, a
    jr nz, Jump_004_4845
    pop hl
    ld [hl], $C0
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    or a, $04
    ld [hl], a
    jr Jump_004_4846

Jump_004_481C::
    push hl
    inc hl
    inc hl
    ld a, [hl]
    cp a, $80
    jr z, Jump_004_4845
    dec hl
    ld a, [hl+]
    ld b, a
    ld a, [hl]
    add a, $11
    ld c, a
    call RunPendingFieldEventType0AOrOther
    cp a, $01
    jr z, Jump_004_4845
    call UpdateSpriteSlots_Shared01
    or a, a
    jr nz, Jump_004_4845
    pop hl
    ld [hl], $80
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    or a, $04
    ld [hl], a
    jr Jump_004_4846

Jump_004_4845::
    pop hl

Jump_004_4846::
    pop hl
    ld a, $09
    add_a_to_hl
    ld a, [hl]
    jp Jump_004_45A7

; runs Func_004_495A when wC935 & $0F = $0A, else Func_004_4904 (E-0122)
; 4 call sites from 1 routine (e.g. UpdateSpriteSlots_Case03)
; reads: wPendingFieldEvent
RunPendingFieldEventType0AOrOther::
Func_004_4852:: ; address name
    ld a, [wPendingFieldEvent]
    and a, $0F
    cp a, $0A
    jr z, Jump_004_485F
    call IsTileUnderCellBlocking
    ret

Jump_004_485F::
    call RunPendingFieldEventType0AOrOther_Sub01
    ret

; entry 4 of the `rst $00` table in UpdateSpriteSlots
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, hTemp1
; writes: hTemp0, hTemp1
UpdateSpriteSlots_Case04::
Jump_004_4863:: ; address name
    ld hl, $48D6
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    jr Jump_004_4877

; entry 5 of the `rst $00` table in UpdateSpriteSlots
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, hTemp1
; writes: hTemp0, hTemp1
UpdateSpriteSlots_Case05::
Jump_004_486E:: ; address name
    ld hl, $48FA
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a

Jump_004_4877::
    pop hl
    ld a, $0D
    add_a_to_hl
    ld a, [hl]
    dec hl
    dec hl
    dec hl
    dec hl
    push hl
    bit 1, a
    jr nz, Jump_004_48BD
    ld a, [hl]
    inc a
    ld [hl], a
    ld c, a
    inc hl
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    inc de
    ld a, [hl]
    sla a
    add a, e
    ld e, a
    jr nc, Jump_004_489D
    inc d

Jump_004_489D::
    ld a, [de]
    cp a, c
    jr nz, Jump_004_48BD
    dec hl
    ld [hl], $00
    inc hl
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    inc de
    ld a, [hl]
    inc a
    ld [hl], a
    sla a
    add a, e
    ld e, a
    jr nc, Jump_004_48B6
    inc d

Jump_004_48B6::
    ld a, [de]
    cp a, $FF
    jr nz, Jump_004_48BD
    ld [hl], $00

Jump_004_48BD::
    pop hl
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    inc hl
    ld a, [hl]
    sla a
    add a, e
    ld e, a
    jr nc, Jump_004_48CD
    inc d

Jump_004_48CD::
    ld a, [de]
    inc hl
    inc hl
    inc hl
    inc hl
    ld [hl], a
    jp Jump_004_4585
    db $00, $0E, $03, $0A, $04, $0E, $05, $0A, $00, $0E, $03, $0A, $04, $0E, $05, $0A
    db $00, $10, $01, $0E, $02, $0E, $01, $0E, $02, $0E, $00, $20, $06, $0E, $07, $20
    db $06, $0E, $FF, $FF, $00, $0E, $01, $0E, $02, $0E, $01, $0E, $FF, $FF

; reads the 2 x 2 screen-buffer tiles at pixel (B, C) into wC910-wC913; A = 1 when any is at or below wMaxBlockingTile, else 0 (E-0127)
; 3 call sites from 2 routines (e.g. RunPendingFieldEventType0AOrOther, UpdateSpriteSlots_Case02)
; reads: wMaxBlockingTile
; points at: wScreenTileBuffer, wTilesUnderPoint
IsTileUnderCellBlocking::
Func_004_4904:: ; address name
    push bc
    push de
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
    ld de, wScreenTileBuffer
    add hl, de
    ld de, wTilesUnderPoint
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ld a, $13
    inc de
    add_a_to_hl
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    dec de
    dec de
    dec de
    ld b, $04

Jump_004_4943::
    ld a, [de]
    inc de
    ld c, a
    ld a, [wMaxBlockingTile]
    cp a, c
    jr c, Jump_004_494E
    jr Jump_004_4955

Jump_004_494E::
    dec b
    jr nz, Jump_004_4943
    xor a, a
    pop de
    pop bc
    ret

Jump_004_4955::
    ld a, $01
    pop de
    pop bc
    ret

; only called from RunPendingFieldEventType0AOrOther (E-0047)
; 1 call site from 1 routine (e.g. RunPendingFieldEventType0AOrOther)
; reads: wMapTallTileMin
; points at: wScreenTileBuffer, wTilesUnderPoint
RunPendingFieldEventType0AOrOther_Sub01::
Func_004_495A:: ; address name
    push bc
    push de
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
    ld de, wScreenTileBuffer
    add hl, de
    ld de, wTilesUnderPoint
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ld a, $13
    inc de
    add_a_to_hl
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    dec de
    dec de
    dec de
    ld b, $04

Jump_004_4999::
    ld a, [de]
    inc de
    ld c, a
    ld a, [wMapTallTileMin]
    cp a, c
    jr c, Jump_004_49A4
    jr Jump_004_49AC

Jump_004_49A4::
    dec b
    jr nz, Jump_004_4999
    ld a, $01
    pop de
    pop bc
    ret

Jump_004_49AC::
    xor a, a
    pop de
    pop bc
    ret

; only called from routines of UpdateSpriteSlots (E-0098)
; 6 call sites from 2 routines (e.g. UpdateSpriteSlots_Case03, UpdateSpriteSlots_Case02)
; reads: hPlayerX, hTemp1, hPlayerY, hTemp0, wPartyCount
; writes: hTemp0, hTemp1
UpdateSpriteSlots_Shared01::
Func_004_49B0:: ; address name
    push bc
    ld a, c
    swap a
    and a, $0F
    ldh [hTemp0], a
    ld a, b
    swap a
    and a, $0F
    ldh [hTemp1], a
    ldh a, [hPlayerX]
    swap a
    and a, $0F
    ld c, a
    ldh a, [hTemp1]
    cp a, c
    jr z, Jump_004_49D9
    ldh a, [hPlayerX]
    add a, $0F
    swap a
    and a, $0F
    ld c, a
    ldh a, [hTemp1]
    cp a, c
    jr nz, Jump_004_49F7

Jump_004_49D9::
    ldh a, [hPlayerY]
    swap a
    and a, $0F
    ld c, a
    ldh a, [hTemp0]
    cp a, c
    jr z, Jump_004_49F3
    ldh a, [hPlayerY]
    add a, $0F
    swap a
    and a, $0F
    ld c, a
    ldh a, [hTemp0]
    cp a, c
    jr nz, Jump_004_49F7

Jump_004_49F3::
    ld a, $01
    pop bc
    ret

Jump_004_49F7::
    ld a, [wPartyCount]
    or a, a
    jr z, Jump_004_4A43
    ld b, a
    ld hl, wFollowerRecords + $1

Jump_004_4A01::
    push hl
    ld a, [hl]
    swap a
    and a, $0F
    ld c, a
    ldh a, [hTemp1]
    cp a, c
    jr z, Jump_004_4A1A
    ld a, [hl]
    add a, $0F
    swap a
    and a, $0F
    ld c, a
    ldh a, [hTemp1]
    cp a, c
    jr nz, Jump_004_4A38

Jump_004_4A1A::
    inc hl
    ld a, [hl]
    swap a
    and a, $0F
    ld c, a
    ldh a, [hTemp0]
    cp a, c
    jr z, Jump_004_4A33
    ld a, [hl]
    add a, $0F
    swap a
    and a, $0F
    ld c, a
    ldh a, [hTemp0]
    cp a, c
    jr nz, Jump_004_4A38

Jump_004_4A33::
    pop hl
    ld a, $01
    pop bc
    ret

Jump_004_4A38::
    pop hl
    ld a, $05
    add_a_to_hl
    dec b
    jr nz, Jump_004_4A01

Jump_004_4A43::
    xor a, a
    pop bc
    ret

; E-0143 (C1: on CGB, with hFFC8 non-zero, DecompressGraphicsTemp0ToTemp4 reads the byte $4A46 + hFFC6 in bank $04 and copies the 8 bytes at 7E:$4B15 + 8 * it to the OBJ palette hFFC9; values 0-20).
; record: palette number in FieldSpritePalettes
FieldSpritePaletteIndex::
Data_004_4A46:: ; address name
    db $12 ; id 0
    db $13 ; id 1
    db $06 ; id 2
    db $07 ; id 3
    db $02 ; id 4
    db $01 ; id 5
    db $04 ; id 6
    db $07 ; id 7
    db $03 ; id 8
    db $06 ; id 9
    db $03 ; id 10
    db $01 ; id 11
    db $05 ; id 12
    db $07 ; id 13
    db $01 ; id 14
    db $00 ; id 15
    db $01 ; id 16
    db $07 ; id 17
    db $03 ; id 18
    db $04 ; id 19
    db $06 ; id 20
    db $04 ; id 21
    db $01 ; id 22
    db $03 ; id 23
    db $03 ; id 24
    db $07 ; id 25
    db $04 ; id 26
    db $07 ; id 27
    db $02 ; id 28
    db $07 ; id 29
    db $07 ; id 30
    db $06 ; id 31
    db $03 ; id 32
    db $06 ; id 33
    db $02 ; id 34
    db $02 ; id 35
    db $02 ; id 36
    db $02 ; id 37
    db $02 ; id 38
    db $02 ; id 39
    db $01 ; id 40
    db $03 ; id 41
    db $06 ; id 42
    db $03 ; id 43
    db $01 ; id 44
    db $08 ; id 45
    db $08 ; id 46
    db $08 ; id 47
    db $08 ; id 48
    db $04 ; id 49
    db $00 ; id 50
    db $03 ; id 51
    db $07 ; id 52
    db $04 ; id 53
    db $01 ; id 54
    db $02 ; id 55
    db $07 ; id 56
    db $06 ; id 57
    db $07 ; id 58
    db $07 ; id 59
    db $03 ; id 60
    db $02 ; id 61
    db $01 ; id 62
    db $07 ; id 63
    db $00 ; id 64
    db $06 ; id 65
    db $02 ; id 66
    db $07 ; id 67
    db $05 ; id 68
    db $07 ; id 69
    db $11 ; id 70
    db $0A ; id 71
    db $0B ; id 72
    db $06 ; id 73
    db $05 ; id 74
    db $01 ; id 75
    db $04 ; id 76
    db $02 ; id 77
    db $01 ; id 78
    db $06 ; id 79
    db $06 ; id 80
    db $02 ; id 81
    db $03 ; id 82
    db $06 ; id 83
    db $0C ; id 84
    db $0D ; id 85
    db $0E ; id 86
    db $02 ; id 87
    db $09 ; id 88
    db $04 ; id 89
    db $0F ; id 90
    db $10 ; id 91
    db $02 ; id 92
    db $00 ; id 93
    db $02 ; id 94
    db $03 ; id 95
    db $00 ; id 96
    db $14 ; id 97

; hFF8B = sprite mode from story flags $19F, $25 and 2 and bit 3 of hFF8C, then loads the matching player and follower sprite graphics (E-0128)
; 34 call sites from 34 routines (e.g. InitFieldScreen, RunFieldReturnPhase_Case02, ResetLeadRecordFields55And5B, LibraryMenu_Case06, ...)
; reads: hPlayerStateFlags, hPlayerSpriteMode
; writes: hPlayerSpriteMode, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, hTemp5
LoadPlayerAndFollowerSpriteGraphics::
Func_004_4AA8:: ; address name
    ld a, $00
    ldh [hPlayerSpriteMode], a
    ld de, $019F
    call TestFlagBit
    jr nc, Jump_004_4ABC
    ld de, $0025
    call TestFlagBit
    jr nc, Jump_004_4AC4

Jump_004_4ABC::
    ld de, $0002
    call TestFlagBit
    jr c, Jump_004_4AC8

Jump_004_4AC4::
    ld a, $01
    ldh [hPlayerSpriteMode], a

Jump_004_4AC8::
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr z, Jump_004_4AD2
    ld a, $02
    ldh [hPlayerSpriteMode], a

Jump_004_4AD2::
    ldh a, [hPlayerSpriteMode]
    or a, a
    jr nz, Jump_004_4ADE
    call LoadPlayerSpriteGraphics
    call LoadPlayerAndFollowerSpriteGraphics_Sub01
    ret

Jump_004_4ADE::
    dec a
    jr nz, Jump_004_4B23
    call LoadPlayerSpriteGraphics
    ld de, $0000
    call TestFlagBit
    jr c, Jump_004_4AF0
    ld a, $01
    jr Jump_004_4AF1

Jump_004_4AF0::
    xor a, a

Jump_004_4AF1::
    ldh [hTemp0], a
    xor a, a
    ldh [hTemp1], a
    inc a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ld hl, vTiles0 + $100
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    call DecompressGraphicsTemp0ToTemp4
    ld a, $04
    ldh [hTemp0], a
    xor a, a
    ldh [hTemp1], a
    ld a, $01
    ldh [hTemp2], a
    ld a, $02
    ldh [hTemp3], a
    ld hl, vTiles0 + $200
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    call DecompressGraphicsTemp0ToTemp4
    ret

Jump_004_4B23::
    call LoadPlayerSpriteGraphics
    call LoadPlayerAndFollowerSpriteGraphics_Sub01
    call LoadAltObjectGraphicsIfPlayerStateFlagsBit3
    ret

; decompresses the player sprite graphics to vTiles0: variant 0 or 1 by story flag 0, or the stream named by hFF94/hFF95 when bit 7 of hFF93 is set (E-0127)
; 5 call sites from 3 routines (e.g. LoadPlayerAndFollowerSpriteGraphics, Talk00Event09_Case04, Talk00Event0A_Case02)
; reads: hPlayerSpriteOverride, hPlayerSpriteStreamLo, hPlayerSpriteStreamHi
; writes: hTemp0, hPlayerSpriteVariant, hTemp1, hTemp3, hTemp2, hTemp4, hTemp5
LoadPlayerSpriteGraphics::
Func_004_4B2D:: ; address name
    ldh a, [hPlayerSpriteOverride]
    bit 7, a
    jr nz, Jump_004_4B5E
    ld de, $0000
    call TestFlagBit
    jr c, Jump_004_4B42
    xor a, a
    ldh [hTemp0], a
    ldh [hPlayerSpriteVariant], a
    jr Jump_004_4B48

Jump_004_4B42::
    ld a, $01
    ldh [hTemp0], a
    ldh [hPlayerSpriteVariant], a

Jump_004_4B48::
    xor a, a
    ldh [hTemp1], a
    ldh [hTemp3], a
    ld a, $01
    ldh [hTemp2], a
    ld hl, vTiles0
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    call DecompressGraphicsTemp0ToTemp4
    ret

Jump_004_4B5E::
    and a, $01
    ldh [hTemp2], a
    ldh a, [hPlayerSpriteStreamLo]
    ld l, a
    ldh a, [hPlayerSpriteStreamHi]
    ld h, a
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    xor a, a
    ldh [hTemp3], a
    ld hl, vTiles0
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    call DecompressGraphicsTemp0ToTemp4
    ret

; when hFF8C bit 3 is set: decompresses Data_07E_58FF (bank $7E) to vTiles0 + $700 and copies an 8-byte palette from bank $7E into OBJ palette 7 of wOBJPaletteBuffer (wC527 = $7F) (E-0120)
; 1 call site from 1 routine (e.g. LoadPlayerAndFollowerSpriteGraphics)
; reads: hPlayerStateFlags
; writes: wOBJPaletteUploadRequest
; points at: wOBJPaletteBuffer
LoadAltObjectGraphicsIfPlayerStateFlagsBit3::
Func_004_4B7E:: ; address name
    ldh a, [hPlayerStateFlags]
    bit 3, a
    ret z
    ld de, Tiles0Plus700Gfx_7E_58FF
    ld b, $7E
    ld hl, vTiles0 + $700
    call DecompressToVRAM
    ld de, $4BBD
    ld a, e
    add a, $08
    ld e, a
    ld a, d
    adc a, $01
    ld d, a
    ld b, $7E
    ld a, $38
    ld hl, wOBJPaletteBuffer
    add_a_to_hl
    ld c, $08
    call CopyFromBank
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ret

; unless bit 1 of hFF8C is set, hFF99 += 1 (+3 more with bit 2); then runs the routine for hFF8B (jump table of three) (E-0124)
; 2 call sites from 2 routines (e.g. FieldStateCommonUpdate, FieldModeStateDispatch_Case04)
; reads: hPlayerStateFlags, hPlayerAnimCounter, hPlayerSpriteMode
; writes: hPlayerAnimCounter
; points at: hPlayerAnimCounter
AdvancePlayerAnimCounterAndRunPlayerSpriteMode::
Func_004_4BB0:: ; address name
    ldh a, [hPlayerStateFlags]
    bit 1, a
    jr nz, Jump_004_4BC6
    ld hl, hPlayerAnimCounter
    inc [hl]
    ldh a, [hPlayerStateFlags]
    bit 2, a
    jr z, Jump_004_4BC6
    ldh a, [hPlayerAnimCounter]
    add a, $03
    ldh [hPlayerAnimCounter], a

Jump_004_4BC6::
    ldh a, [hPlayerSpriteMode]
    rst $00
    dw AdvancePlayerAnimCounterAndRunPlayerSpriteMode_Case00
    dw AdvancePlayerAnimCounterAndRunPlayerSpriteMode_Case01
    dw AdvancePlayerAnimCounterAndRunPlayerSpriteMode_Case02

; entry 0 of the `rst $00` table in AdvancePlayerAnimCounterAndRunPlayerSpriteMode
; no direct call (reached through a table, a jump or a vector)
AdvancePlayerAnimCounterAndRunPlayerSpriteMode_Case00::
Jump_004_4BCF:: ; address name
    call AdvancePlayerAnimCounterAndRunPlayerSpriteMode_Shared01
    call DrawPartyFollowerSprites
    ret

; entry 1 of the `rst $00` table in AdvancePlayerAnimCounterAndRunPlayerSpriteMode
; no direct call (reached through a table, a jump or a vector)
AdvancePlayerAnimCounterAndRunPlayerSpriteMode_Case01::
Jump_004_4BD6:: ; address name
    call AdvancePlayerAnimCounterAndRunPlayerSpriteMode_Shared01
    call DrawFollowerSpriteIfFlag1B
    ret

; entry 2 of the `rst $00` table in AdvancePlayerAnimCounterAndRunPlayerSpriteMode
; no direct call (reached through a table, a jump or a vector)
AdvancePlayerAnimCounterAndRunPlayerSpriteMode_Case02::
Jump_004_4BDD:: ; address name
    call AdvancePlayerAnimCounterAndRunPlayerSpriteMode_Shared01
    call DrawPlayerOverlaySprite21Or22
    ret

; moves the sprite origin down 8, sets tile offset $70 and palette 7, then draws meta-sprite set $21 (hPlayerStateFlags bit 3 set) or $22 with DrawMetaSprite (E-0175)
; 1 call site from 1 routine (e.g. AdvancePlayerAnimCounterAndRunPlayerSpriteMode_Case02)
; reads: hSpriteOriginY, hSpriteOriginYHi, hSpriteAttrXor, hPlayerStateFlags
; writes: hSpriteOriginY, hSpriteOriginYHi, hSpriteTileOffset, hSpriteAttrXor, hSpriteSetIndex, hSpriteSubIndex
DrawPlayerOverlaySprite21Or22::
Func_004_4BE4:: ; address name
    ldh a, [hSpriteOriginY]
    ld l, a
    ldh a, [hSpriteOriginYHi]
    ld h, a
    ld a, $08
    add_a_to_hl
    ld a, l
    ldh [hSpriteOriginY], a
    ld a, h
    ldh [hSpriteOriginYHi], a
    ld a, $70
    ldh [hSpriteTileOffset], a
    ldh a, [hSpriteAttrXor]
    and a, $F8
    or a, $07
    ldh [hSpriteAttrXor], a
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr z, Jump_004_4C17
    ld a, $21
    ldh [hSpriteSetIndex], a
    xor a, a
    ldh [hSpriteSubIndex], a
    farcall DrawMetaSprite
    ret

Jump_004_4C17::
    ld a, $22
    ldh [hSpriteSetIndex], a
    xor a, a
    ldh [hSpriteSubIndex], a
    farcall DrawMetaSprite
    ret

; unless hFieldDrawFlags bit 1 is set, and only when story flag $1B is set: draws the follower sprite from wFollowerRecords bytes 1-2 (set from hPlayerSpriteVariant, with a different frame when IsFadingAtMap5AScreen00Y80) (E-0175)
; 1 call site from 1 routine (e.g. AdvancePlayerAnimCounterAndRunPlayerSpriteMode_Case01)
; reads: hFieldDrawFlags, hPlayerSpriteVariant, wFollowerRecords, hPlayerAnimCounter, hScrollX, hScrollXHi, hScrollY, hScrollYHi
; writes: hSpriteSetIndex, hSpriteAttrXor, hSpriteSubIndex, hSpriteTileOffset, hSpriteOriginX, hSpriteOriginXHi, hSpriteOriginY, hSpriteOriginYHi
DrawFollowerSpriteIfFlag1B::
Func_004_4C25:: ; address name
    ldh a, [hFieldDrawFlags]
    bit 1, a
    ret nz
    ld de, $001B
    call TestFlagBit
    ret nc
    ldh a, [hPlayerSpriteVariant]
    inc a
    and a, $01
    ldh [hSpriteSetIndex], a
    ld a, $01
    ldh [hSpriteAttrXor], a
    ld a, [wFollowerRecords + $1]
    ld b, a
    ld a, [wFollowerRecords + $2]
    ld c, a
    call IsFadingAtMap5AScreen00Y80
    or a, a
    jr z, Jump_004_4C4E
    ld a, $02
    jr Jump_004_4C5B

Jump_004_4C4E::
    ld a, [wFollowerRecords]
    cp a, $03
    jr nz, Jump_004_4C5B
    ld a, $21
    ldh [hSpriteAttrXor], a
    ld a, $01

Jump_004_4C5B::
    sla a
    ld c, a
    ldh a, [hPlayerAnimCounter]
    swap a
    srl a
    and a, $01
    add a, c
    ldh [hSpriteSubIndex], a
    ld a, $10
    ldh [hSpriteTileOffset], a
    ld a, [wFollowerRecords + $1]
    add a, $08
    ld l, a
    ldh a, [hScrollX]
    add a, l
    ldh [hSpriteOriginX], a
    ldh a, [hScrollXHi]
    adc a, $00
    ldh [hSpriteOriginXHi], a
    ld a, [wFollowerRecords + $2]
    add a, $10
    ld l, a
    ldh a, [hScrollY]
    add a, l
    ldh [hSpriteOriginY], a
    ldh a, [hScrollYHi]
    adc a, $00
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite4008
    ret

; only called from routines of AdvancePlayerAnimCounterAndRunPlayerSpriteMode (E-0098)
; 3 call sites from 3 routines (e.g. AdvancePlayerAnimCounterAndRunPlayerSpriteMode_Case02, AdvancePlayerAnimCounterAndRunPlayerSpriteMode_Case01, AdvancePlayerAnimCounterAndRunPlayerSpriteMode_Case00)
; reads: hFieldDrawFlags, hPlayerSpriteVariant, hPlayerX, hPlayerY, hPlayerAnimCounter, hScrollX, hScrollXHi, hScrollY, ...
; writes: hSpriteSetIndex, hSpriteAttrXor, hSpriteSubIndex, hSpriteTileOffset, hSpriteOriginX, hSpriteOriginXHi, hSpriteOriginY, hSpriteOriginYHi
AdvancePlayerAnimCounterAndRunPlayerSpriteMode_Shared01::
Func_004_4C96:: ; address name
    ldh a, [hFieldDrawFlags]
    bit 0, a
    ret nz
    ldh a, [hPlayerSpriteVariant]
    ldh [hSpriteSetIndex], a
    ld a, $00
    ldh [hSpriteAttrXor], a
    ldh a, [hPlayerX]
    ld b, a
    ldh a, [hPlayerY]
    ld c, a
    call IsFadingAtMap5AScreen00Y80
    or a, a
    jr z, Jump_004_4CB3
    ld a, $02
    jr Jump_004_4CBF

Jump_004_4CB3::
    ldh a, [hPlayerFacing]
    cp a, $03
    jr nz, Jump_004_4CBF
    ld a, $20
    ldh [hSpriteAttrXor], a
    ld a, $01

Jump_004_4CBF::
    add a, a
    ld c, a
    ldh a, [hPlayerAnimCounter]
    swap a
    srl a
    and a, $01
    add a, c
    ldh [hSpriteSubIndex], a
    ld a, $00
    ldh [hSpriteTileOffset], a
    ldh a, [hPlayerX]
    add a, $08
    ld l, a
    ldh a, [hScrollX]
    add a, l
    ldh [hSpriteOriginX], a
    ldh a, [hScrollXHi]
    adc a, $00
    ldh [hSpriteOriginXHi], a
    ldh a, [hPlayerY]
    add a, $10
    ld l, a
    ldh a, [hScrollY]
    add a, l
    ldh [hSpriteOriginY], a
    ld l, a
    ldh a, [hScrollYHi]
    adc a, $00
    ldh [hSpriteOriginYHi], a
    ld h, a
    ldh a, [hPlayerSpriteMode]
    cp a, $02
    jr nz, Jump_004_4D06
    ld a, l
    sub a, $08
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, l
    ldh [hSpriteOriginY], a
    ld a, h
    ldh [hSpriteOriginYHi], a

Jump_004_4D06::
    ldh a, [hPlayerSpriteOverride]
    bit 7, a
    jr nz, Jump_004_4D13

Jump_004_4D0C::
    farcall DrawMetaSprite4008
    ret

Jump_004_4D13::
    and a, $01
    jr z, Jump_004_4D1D
    ldh a, [hPlayerSpriteStreamLo]
    ldh [hSpriteSetIndex], a
    jr Jump_004_4D0C

Jump_004_4D1D::
    ldh a, [hPlayerSpriteStreamLo]
    and a, $7F
    ldh [hSpriteSetIndex], a
    ldh a, [hPlayerSpriteStreamHi]
    or a, a
    jr nz, Jump_004_4D3C
    ldh a, [hPlayerSpriteStreamLo]
    bit 7, a
    jr nz, Jump_004_4D35
    farcall DrawMetaSpriteSet_Bank25
    ret

Jump_004_4D35::
    farcall DrawMetaSpriteSet_Bank26
    ret

Jump_004_4D3C::
    farcall DrawMetaSpriteSet_Bank27
    ret

; for each party member (wPartyCount) walks wFollowerRecords and wPartyList and draws its follower sprite unless the matching hFieldDrawFlags bit is set (E-0175)
; 1 call site from 1 routine (e.g. AdvancePlayerAnimCounterAndRunPlayerSpriteMode_Case00)
; reads: wPartyCount, hTemp9, hFieldDrawFlags, hPlayerAnimCounter, hTemp0, hScrollX, hScrollXHi, hScrollY, ...
; writes: hTemp9, hTemp0, hSpriteAttrXor, hSpriteSubIndex, hSpriteTileOffset, hSpriteOriginX, hSpriteOriginXHi, hSpriteOriginY, ...
; points at: wFollowerRecords
DrawPartyFollowerSprites::
Func_004_4D43:: ; address name
    ld a, $02
    ldh [hTemp9], a
    ld a, [wPartyCount]
    or a, a
    ret z
    ld b, a
    ld hl, wFollowerRecords
    ld de, wPartyList + $3
    ld a, $10
    ldh [hTemp0], a

Jump_004_4D57::
    push bc
    push de
    push hl
    ldh a, [hTemp9]
    ld c, a
    ldh a, [hFieldDrawFlags]
    and a, c
    jp nz, Jump_004_4DF3
    ld a, $03
    sub a, b
    inc a
    ldh [hSpriteAttrXor], a
    push bc
    inc hl
    ld a, [hl+]
    ld b, a
    ld a, [hl-]
    ld c, a
    dec hl
    call IsFadingAtMap5AScreen00Y80
    pop bc
    or a, a
    jr z, Jump_004_4D7C
    ld a, $02
    inc hl
    jr Jump_004_4D89

Jump_004_4D7C::
    ld a, [hl+]
    cp a, $03
    jr nz, Jump_004_4D89
    ldh a, [hSpriteAttrXor]
    or a, $20
    ldh [hSpriteAttrXor], a
    ld a, $01

Jump_004_4D89::
    add a, a
    ld c, a
    ldh a, [hPlayerAnimCounter]
    swap a
    srl a
    and a, $01
    add a, c
    ldh [hSpriteSubIndex], a
    ldh a, [hTemp0]
    ldh [hSpriteTileOffset], a
    ld a, [hl+]
    add a, $08
    ld c, a
    ldh a, [hScrollX]
    add a, c
    ldh [hSpriteOriginX], a
    ldh a, [hScrollXHi]
    adc a, $00
    ldh [hSpriteOriginXHi], a
    ld a, [hl+]
    add a, $10
    ld c, a
    ldh a, [hScrollY]
    add a, c
    ldh [hSpriteOriginY], a
    ldh a, [hScrollYHi]
    adc a, $00
    ldh [hSpriteOriginYHi], a
    inc de
    ld a, [de]
    dec de
    cp a, $FF
    jr nz, Jump_004_4DCB
    ld a, $19
    ldh [hSpriteSetIndex], a
    farcall DrawMetaSprite
    jr Jump_004_4DF3

Jump_004_4DCB::
    ld a, [de]
    and a, $7F
    ldh [hSpriteSetIndex], a
    inc de
    ld a, [de]
    or a, a
    jr nz, Jump_004_4DED
    dec de
    ld a, [de]
    bit 7, a
    jr nz, Jump_004_4DE4
    farcall DrawMetaSpriteSet_Bank25
    jp Jump_004_4DF3

Jump_004_4DE4::
    farcall DrawMetaSpriteSet_Bank26
    jp Jump_004_4DF3

Jump_004_4DED::
    farcall DrawMetaSpriteSet_Bank27

Jump_004_4DF3::
    ldh a, [hTemp0]
    add a, $10
    ldh [hTemp0], a
    ldh a, [hTemp9]
    rlca
    ldh [hTemp9], a
    pop hl
    ld a, $05
    add_a_to_hl
    pop de
    inc de
    inc de
    pop bc
    dec b
    jp nz, Jump_004_4D57
    ret

; A = 1 while a fade runs on map $5A, screen (0, 0), with hPlayerY = $80; otherwise A = 0 (E-0175)
; 3 call sites from 3 routines (e.g. AdvancePlayerAnimCounterAndRunPlayerSpriteMode_Shared01, DrawFollowerSpriteIfFlag1B, DrawPartyFollowerSprites)
; reads: wFadeState, hMapId, hMapScreenX, hMapScreenY, hPlayerY
IsFadingAtMap5AScreen00Y80::
Func_004_4E0F:: ; address name
    ld a, [wFadeState]
    or a, a
    jr z, Jump_004_4E30
    ldh a, [hMapId]
    cp a, $5A
    jr nz, Jump_004_4E2E
    ldh a, [hMapScreenX]
    or a, a
    jr nz, Jump_004_4E2E
    ldh a, [hMapScreenY]
    or a, a
    jr nz, Jump_004_4E2E
    ldh a, [hPlayerY]
    cp a, $80
    jr nz, Jump_004_4E2E
    ld a, $01
    ret

Jump_004_4E2E::
    xor a, a
    ret

Jump_004_4E30::
    push hl
    push de
    ld hl, $4E73

Jump_004_4E35::
    push hl
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_004_4E40
    pop hl
    pop de
    pop hl
    xor a, a
    ret

Jump_004_4E40::
    ldh a, [hMapId]
    ld e, a
    ld a, [hl+]
    cp a, e
    jr nz, Jump_004_4E69
    ldh a, [hMapScreenX]
    ld e, a
    ld a, [hl+]
    cp a, e
    jr nz, Jump_004_4E69
    ldh a, [hMapScreenY]
    ld e, a
    ld a, [hl+]
    cp a, e
    jr nz, Jump_004_4E69
    ld a, [hl+]
    cp a, b
    jr nz, Jump_004_4E69
    ld a, [hl+]
    cp a, c
    jr z, Jump_004_4E5F
    jr nc, Jump_004_4E69

Jump_004_4E5F::
    ld a, [hl]
    cp a, c
    jr c, Jump_004_4E69
    pop hl
    pop de
    pop hl
    ld a, $01
    ret

Jump_004_4E69::
    pop hl
    ld a, $06
    add_a_to_hl
    jr Jump_004_4E35
    db $05, $02, $00, $50, $00, $28, $2B, $03, $03, $20, $00, $18, $5A, $00, $00, $40
    db $10, $48, $5A, $00, $00, $70, $30, $48, $5C, $00, $01, $30, $78, $90, $7A, $00
    db $00, $40, $58, $80, $7A, $00, $01, $40, $00, $28, $7A, $00, $01, $50, $10, $28
    db $7A, $00, $01, $30, $38, $48, $FF

; E-0041 (C1: the debug monster viewer's second pane decompresses the stream for its id to vTiles0 + $200; all 384 entries parse). Far pointers: address, bank.
; record: compressed small-sprite stream (32 or 256 bytes); ROM bank of that data
MonsterSpriteTable::
Data_004_4EAA:: ; address name
    dfar MonsterSprite_DrakSlime ; id 0
    dfar MonsterSprite_DrakSlime ; id 1 DrakSlime
    dfar MonsterSprite_SpotSlime ; id 2 SpotSlime
    dfar MonsterSprite_WingSlime ; id 3 WingSlime
    dfar MonsterSprite_TreeSlime ; id 4 TreeSlime
    dfar MonsterSprite_Snaily ; id 5 Snaily
    dfar MonsterSprite_SlimeNite ; id 6 SlimeNite
    dfar MonsterSprite_Babble ; id 7 Babble
    dfar MonsterSprite_BoxSlime ; id 8 BoxSlime
    dfar MonsterSprite_PearlGel ; id 9 PearlGel
    dfar MonsterSprite_Slime ; id 10 Slime
    dfar MonsterSprite_Healer ; id 11 Healer
    dfar MonsterSprite_FangSlime ; id 12 FangSlime
    dfar MonsterSprite_RockSlime ; id 13 RockSlime
    dfar MonsterSprite_SlimeBorg ; id 14 SlimeBorg
    dfar MonsterSprite_Slabbit ; id 15 Slabbit
    dfar MonsterSprite_KingSlime ; id 16 KingSlime
    dfar MonsterSprite_Metaly ; id 17 Metaly
    dfar MonsterSprite_Metabble ; id 18 Metabble
    dfar MonsterSprite_SpotKing ; id 19 SpotKing
    dfar MonsterSprite_TropicGel ; id 20 TropicGel
    dfar MonsterSprite_MimeSlime ; id 21 MimeSlime
    dfar MonsterSprite_HaloSlime ; id 22 HaloSlime
    dfar MonsterSprite_MetalKing ; id 23 MetalKing
    dfar MonsterSprite_GoldSlime ; id 24 GoldSlime
    dfar MonsterSprite_GranSlime ; id 25 GranSlime
    dfar MonsterSprite_WonderEgg ; id 26 WonderEgg
    dfar MonsterSprite_DrakSlime ; id 27 Butch
    dfar MonsterSprite_DrakSlime ; id 28 ?
    dfar MonsterSprite_DrakSlime ; id 29 ?
    dfar MonsterSprite_DrakSlime ; id 30 ?
    dfar MonsterSprite_DrakSlime ; id 31 ?
    dfar MonsterSprite_DrakSlime ; id 32 ?
    dfar MonsterSprite_DrakSlime ; id 33 ?
    dfar MonsterSprite_DrakSlime ; id 34 ?
    dfar MonsterSprite_DrakSlime ; id 35 ?
    dfar MonsterSprite_DragonKid ; id 36 DragonKid
    dfar MonsterSprite_Tortragon ; id 37 Tortragon
    dfar MonsterSprite_Pteranod ; id 38 Pteranod
    dfar MonsterSprite_Gasgon ; id 39 Gasgon
    dfar MonsterSprite_FairyDrak ; id 40 FairyDrak
    dfar MonsterSprite_LizardMan ; id 41 LizardMan
    dfar MonsterSprite_Poisongon ; id 42 Poisongon
    dfar MonsterSprite_Swordgon ; id 43 Swordgon
    dfar MonsterSprite_Drygon ; id 44 Drygon
    dfar MonsterSprite_Dragon ; id 45 Dragon
    dfar MonsterSprite_MiniDrak ; id 46 MiniDrak
    dfar MonsterSprite_MadDragon ; id 47 MadDragon
    dfar MonsterSprite_Rayburn ; id 48 Rayburn
    dfar MonsterSprite_Chamelgon ; id 49 Chamelgon
    dfar MonsterSprite_LizardFly ; id 50 LizardFly
    dfar MonsterSprite_Andreal ; id 51 Andreal
    dfar MonsterSprite_KingCobra ; id 52 KingCobra
    dfar MonsterSprite_Vampirus ; id 53 Vampirus
    dfar MonsterSprite_SnakeBat ; id 54 SnakeBat
    dfar MonsterSprite_Spikerous ; id 55 Spikerous
    dfar MonsterSprite_GreatDrak ; id 56 GreatDrak
    dfar MonsterSprite_Crestpent ; id 57 Crestpent
    dfar MonsterSprite_WingSnake ; id 58 WingSnake
    dfar MonsterSprite_Coatol ; id 59 Coatol
    dfar MonsterSprite_Orochi ; id 60 Orochi
    dfar MonsterSprite_BattleRex ; id 61 BattleRex
    dfar MonsterSprite_SkyDragon ; id 62 SkyDragon
    dfar MonsterSprite_Serpentia ; id 63 Serpentia
    dfar MonsterSprite_Divinegon ; id 64 Divinegon
    dfar MonsterSprite_Orligon ; id 65 Orligon
    dfar MonsterSprite_GigaDraco ; id 66 GigaDraco
    dfar MonsterSprite_DrakSlime ; id 67 ?
    dfar MonsterSprite_DrakSlime ; id 68 ?
    dfar MonsterSprite_DrakSlime ; id 69 ?
    dfar MonsterSprite_DrakSlime ; id 70 ?
    dfar MonsterSprite_Tonguella ; id 71 Tonguella
    dfar MonsterSprite_Almiraj ; id 72 Almiraj
    dfar MonsterSprite_CatFly ; id 73 CatFly
    dfar MonsterSprite_PillowRat ; id 74 PillowRat
    dfar MonsterSprite_Saccer ; id 75 Saccer
    dfar MonsterSprite_GulpBeast ; id 76 GulpBeast
    dfar MonsterSprite_Skullroo ; id 77 Skullroo
    dfar MonsterSprite_WindBeast ; id 78 WindBeast
    dfar MonsterSprite_Beavern ; id 79 Beavern
    dfar MonsterSprite_Antbear ; id 80 Antbear
    dfar MonsterSprite_SuperTen ; id 81 SuperTen
    dfar MonsterSprite_IronTurt ; id 82 IronTurt
    dfar MonsterSprite_Mommonja ; id 83 Mommonja
    dfar MonsterSprite_HammerMan ; id 84 HammerMan
    dfar MonsterSprite_Grizzly ; id 85 Grizzly
    dfar MonsterSprite_Yeti ; id 86 Yeti
    dfar MonsterSprite_ArrowDog ; id 87 ArrowDog
    dfar MonsterSprite_NoctoKing ; id 88 NoctoKing
    dfar MonsterSprite_BeastNite ; id 89 BeastNite
    dfar MonsterSprite_MadGopher ; id 90 MadGopher
    dfar MonsterSprite_FairyRat ; id 91 FairyRat
    dfar MonsterSprite_Unicorn ; id 92 Unicorn
    dfar MonsterSprite_Goategon ; id 93 Goategon
    dfar MonsterSprite_WildApe ; id 94 WildApe
    dfar MonsterSprite_Trumpeter ; id 95 Trumpeter
    dfar MonsterSprite_KingLeo ; id 96 KingLeo
    dfar MonsterSprite_DarkHorn ; id 97 DarkHorn
    dfar MonsterSprite_MadCat ; id 98 MadCat
    dfar MonsterSprite_BigEye ; id 99 BigEye
    dfar MonsterSprite_Gorago ; id 100 Gorago
    dfar MonsterSprite_CatMage ; id 101 CatMage
    dfar MonsterSprite_Dumbira ; id 102 Dumbira
    dfar MonsterSprite_DrakSlime ; id 103 ?
    dfar MonsterSprite_DrakSlime ; id 104 ?
    dfar MonsterSprite_DrakSlime ; id 105 ?
    dfar MonsterSprite_Picky ; id 106 Picky
    dfar MonsterSprite_Wyvern ; id 107 Wyvern
    dfar MonsterSprite_BullBird ; id 108 BullBird
    dfar MonsterSprite_Florajay ; id 109 Florajay
    dfar MonsterSprite_DuckKite ; id 110 DuckKite
    dfar MonsterSprite_MadPecker ; id 111 MadPecker
    dfar MonsterSprite_MadRaven ; id 112 MadRaven
    dfar MonsterSprite_MistyWing ; id 113 MistyWing
    dfar MonsterSprite_AquaHawk ; id 114 AquaHawk
    dfar MonsterSprite_Dracky ; id 115 Dracky
    dfar MonsterSprite_KiteHawk ; id 116 KiteHawk
    dfar MonsterSprite_BigRoost ; id 117 BigRoost
    dfar MonsterSprite_StubBird ; id 118 StubBird
    dfar MonsterSprite_LandOwl ; id 119 LandOwl
    dfar MonsterSprite_MadGoose ; id 120 MadGoose
    dfar MonsterSprite_MadCondor ; id 121 MadCondor
    dfar MonsterSprite_Emyu ; id 122 Emyu
    dfar MonsterSprite_Blizzardy ; id 123 Blizzardy
    dfar MonsterSprite_Phoenix ; id 124 Phoenix
    dfar MonsterSprite_ZapBird ; id 125 ZapBird
    dfar MonsterSprite_Garudian ; id 126 Garudian
    dfar MonsterSprite_WhipBird ; id 127 WhipBird
    dfar MonsterSprite_FunkyBird ; id 128 FunkyBird
    dfar MonsterSprite_RainHawk ; id 129 RainHawk
    dfar MonsterSprite_Azurile ; id 130 Azurile
    dfar MonsterSprite_Shantak ; id 131 Shantak
    dfar MonsterSprite_CragDevil ; id 132 CragDevil
    dfar MonsterSprite_DrakSlime ; id 133 ?
    dfar MonsterSprite_DrakSlime ; id 134 ?
    dfar MonsterSprite_DrakSlime ; id 135 ?
    dfar MonsterSprite_DrakSlime ; id 136 ?
    dfar MonsterSprite_DrakSlime ; id 137 ?
    dfar MonsterSprite_DrakSlime ; id 138 ?
    dfar MonsterSprite_DrakSlime ; id 139 ?
    dfar MonsterSprite_DrakSlime ; id 140 ?
    dfar MonsterSprite_MadPlant ; id 141 MadPlant
    dfar MonsterSprite_FireWeed ; id 142 FireWeed
    dfar MonsterSprite_FloraMan ; id 143 FloraMan
    dfar MonsterSprite_WingTree ; id 144 WingTree
    dfar MonsterSprite_CactiBall ; id 145 CactiBall
    dfar MonsterSprite_Gulpple ; id 146 Gulpple
    dfar MonsterSprite_Toadstool ; id 147 Toadstool
    dfar MonsterSprite_AmberWeed ; id 148 AmberWeed
    dfar MonsterSprite_Slurperon ; id 149 Slurperon
    dfar MonsterSprite_Stubsuck ; id 150 Stubsuck
    dfar MonsterSprite_Oniono ; id 151 Oniono
    dfar MonsterSprite_DanceVegi ; id 152 DanceVegi
    dfar MonsterSprite_TreeBoy ; id 153 TreeBoy
    dfar MonsterSprite_Devipine ; id 154 Devipine
    dfar MonsterSprite_FaceTree ; id 155 FaceTree
    dfar MonsterSprite_HerbMan ; id 156 HerbMan
    dfar MonsterSprite_BeanMan ; id 157 BeanMan
    dfar MonsterSprite_EvilSeed ; id 158 EvilSeed
    dfar MonsterSprite_ManEater ; id 159 ManEater
    dfar MonsterSprite_Snapper ; id 160 Snapper
    dfar MonsterSprite_GhosTree ; id 161 GhosTree
    dfar MonsterSprite_Rosevine ; id 162 Rosevine
    dfar MonsterSprite_Egdracil ; id 163 Egdracil
    dfar MonsterSprite_Warubou ; id 164 Warubou
    dfar MonsterSprite_Watabou ; id 165 Watabou
    dfar MonsterSprite_Eggplaton ; id 166 Eggplaton
    dfar MonsterSprite_FooHero ; id 167 FooHero
    dfar MonsterSprite_DrakSlime ; id 168 ?
    dfar MonsterSprite_DrakSlime ; id 169 ?
    dfar MonsterSprite_DrakSlime ; id 170 ?
    dfar MonsterSprite_DrakSlime ; id 171 ?
    dfar MonsterSprite_DrakSlime ; id 172 ?
    dfar MonsterSprite_DrakSlime ; id 173 ?
    dfar MonsterSprite_DrakSlime ; id 174 ?
    dfar MonsterSprite_DrakSlime ; id 175 ?
    dfar MonsterSprite_GiantSlug ; id 176 GiantSlug
    dfar MonsterSprite_Catapila ; id 177 Catapila
    dfar MonsterSprite_Gophecada ; id 178 Gophecada
    dfar MonsterSprite_Butterfly ; id 179 Butterfly
    dfar MonsterSprite_WeedBug ; id 180 WeedBug
    dfar MonsterSprite_GiantWorm ; id 181 GiantWorm
    dfar MonsterSprite_Lipsy ; id 182 Lipsy
    dfar MonsterSprite_StagBug ; id 183 StagBug
    dfar MonsterSprite_Pyuro ; id 184 Pyuro
    dfar MonsterSprite_ArmyAnt ; id 185 ArmyAnt
    dfar MonsterSprite_GoHopper ; id 186 GoHopper
    dfar MonsterSprite_TailEater ; id 187 TailEater
    dfar MonsterSprite_ArmorPede ; id 188 ArmorPede
    dfar MonsterSprite_Eyeder ; id 189 Eyeder
    dfar MonsterSprite_GiantMoth ; id 190 GiantMoth
    dfar MonsterSprite_Droll ; id 191 Droll
    dfar MonsterSprite_ArmyCrab ; id 192 ArmyCrab
    dfar MonsterSprite_MadHornet ; id 193 MadHornet
    dfar MonsterSprite_Belzebub ; id 194 Belzebub
    dfar MonsterSprite_WarMantis ; id 195 WarMantis
    dfar MonsterSprite_HornBeet ; id 196 HornBeet
    dfar MonsterSprite_Sickler ; id 197 Sickler
    dfar MonsterSprite_Armorpion ; id 198 Armorpion
    dfar MonsterSprite_Digster ; id 199 Digster
    dfar MonsterSprite_Skularach ; id 200 Skularach
    dfar MonsterSprite_MultiEyes ; id 201 MultiEyes
    dfar MonsterSprite_DrakSlime ; id 202 ?
    dfar MonsterSprite_DrakSlime ; id 203 ?
    dfar MonsterSprite_DrakSlime ; id 204 ?
    dfar MonsterSprite_DrakSlime ; id 205 ?
    dfar MonsterSprite_DrakSlime ; id 206 ?
    dfar MonsterSprite_DrakSlime ; id 207 ?
    dfar MonsterSprite_DrakSlime ; id 208 ?
    dfar MonsterSprite_DrakSlime ; id 209 ?
    dfar MonsterSprite_DrakSlime ; id 210 ?
    dfar MonsterSprite_Pixy ; id 211 Pixy
    dfar MonsterSprite_MedusaEye ; id 212 MedusaEye
    dfar MonsterSprite_AgDevil ; id 213 AgDevil
    dfar MonsterSprite_Demonite ; id 214 Demonite
    dfar MonsterSprite_DarkEye ; id 215 DarkEye
    dfar MonsterSprite_EyeBall ; id 216 EyeBall
    dfar MonsterSprite_SkulRider ; id 217 SkulRider
    dfar MonsterSprite_EvilBeast ; id 218 EvilBeast
    dfar MonsterSprite_Bubblemon ; id 219 Bubblemon
    dfar MonsterSprite_1EyeClown ; id 220 1EyeClown
    dfar MonsterSprite_Gremlin ; id 221 Gremlin
    dfar MonsterSprite_ArcDemon ; id 222 ArcDemon
    dfar MonsterSprite_Lionex ; id 223 Lionex
    dfar MonsterSprite_GoatHorn ; id 224 GoatHorn
    dfar MonsterSprite_Orc ; id 225 Orc
    dfar MonsterSprite_Ogre ; id 226 Ogre
    dfar MonsterSprite_GateGuard ; id 227 GateGuard
    dfar MonsterSprite_ChopClown ; id 228 ChopClown
    dfar MonsterSprite_BossTroll ; id 229 BossTroll
    dfar MonsterSprite_Grendal ; id 230 Grendal
    dfar MonsterSprite_Akubar ; id 231 Akubar
    dfar MonsterSprite_MadKnight ; id 232 MadKnight
    dfar MonsterSprite_EvilWell ; id 233 EvilWell
    dfar MonsterSprite_Gigantes ; id 234 Gigantes
    dfar MonsterSprite_Centasaur ; id 235 Centasaur
    dfar MonsterSprite_EvilArmor ; id 236 EvilArmor
    dfar MonsterSprite_Jamirus ; id 237 Jamirus
    dfar MonsterSprite_Durran ; id 238 Durran
    dfar MonsterSprite_Titanis ; id 239 Titanis
    dfar MonsterSprite_LampGenie ; id 240 LampGenie
    dfar MonsterSprite_DrakSlime ; id 241 ?
    dfar MonsterSprite_DrakSlime ; id 242 ?
    dfar MonsterSprite_DrakSlime ; id 243 ?
    dfar MonsterSprite_DrakSlime ; id 244 ?
    dfar MonsterSprite_DrakSlime ; id 245 ?
    dfar MonsterSprite_Spooky ; id 246 Spooky
    dfar MonsterSprite_Skullgon ; id 247 Skullgon
    dfar MonsterSprite_PutrePup ; id 248 PutrePup
    dfar MonsterSprite_RotRaven ; id 249 RotRaven
    dfar MonsterSprite_Mummy ; id 250 Mummy
    dfar MonsterSprite_DarkCrab ; id 251 DarkCrab
    dfar MonsterSprite_DeadNite ; id 252 DeadNite
    dfar MonsterSprite_Shadow ; id 253 Shadow
    dfar MonsterSprite_Skulpent ; id 254 Skulpent
    dfar MonsterSprite_Hork ; id 255 Hork
    dfar MonsterSprite_Mudron ; id 256 Mudron
    dfar MonsterSprite_NiteWhip ; id 257 NiteWhip
    dfar MonsterSprite_WindMerge ; id 258 WindMerge
    dfar MonsterSprite_Reaper ; id 259 Reaper
    dfar MonsterSprite_Inverzon ; id 260 Inverzon
    dfar MonsterSprite_FoxFire ; id 261 FoxFire
    dfar MonsterSprite_CaptDead ; id 262 CaptDead
    dfar MonsterSprite_DeadNoble ; id 263 DeadNoble
    dfar MonsterSprite_WhiteKing ; id 264 WhiteKing
    dfar MonsterSprite_BoneSlave ; id 265 BoneSlave
    dfar MonsterSprite_Skeletor ; id 266 Skeletor
    dfar MonsterSprite_Servant ; id 267 Servant
    dfar MonsterSprite_Lazamanus ; id 268 Lazamanus
    dfar MonsterSprite_Copycat ; id 269 Copycat
    dfar MonsterSprite_MadSpirit ; id 270 MadSpirit
    dfar MonsterSprite_PomBom ; id 271 PomPomBom
    dfar MonsterSprite_Niterich ; id 272 Niterich
    dfar MonsterSprite_DrakSlime ; id 273 ?
    dfar MonsterSprite_DrakSlime ; id 274 ?
    dfar MonsterSprite_DrakSlime ; id 275 ?
    dfar MonsterSprite_DrakSlime ; id 276 ?
    dfar MonsterSprite_DrakSlime ; id 277 ?
    dfar MonsterSprite_DrakSlime ; id 278 ?
    dfar MonsterSprite_DrakSlime ; id 279 ?
    dfar MonsterSprite_DrakSlime ; id 280 ?
    dfar MonsterSprite_JewelBag ; id 281 JewelBag
    dfar MonsterSprite_EvilWand ; id 282 EvilWand
    dfar MonsterSprite_MadCandle ; id 283 MadCandle
    dfar MonsterSprite_CoilBird ; id 284 CoilBird
    dfar MonsterSprite_Facer ; id 285 Facer
    dfar MonsterSprite_SpikyBoy ; id 286 SpikyBoy
    dfar MonsterSprite_MadMirror ; id 287 MadMirror
    dfar MonsterSprite_RogueNite ; id 288 RogueNite
    dfar MonsterSprite_Puppetor ; id 289 Puppetor
    dfar MonsterSprite_Goopi ; id 290 Goopi
    dfar MonsterSprite_Voodoll ; id 291 Voodoll
    dfar MonsterSprite_MetalDrak ; id 292 MetalDrak
    dfar MonsterSprite_Balzak ; id 293 Balzak
    dfar MonsterSprite_SabreMan ; id 294 SabreMan
    dfar MonsterSprite_CurseLamp ; id 295 CurseLamp
    dfar MonsterSprite_Brushead ; id 296 Brushead
    dfar MonsterSprite_Roboster ; id 297 Roboster
    dfar MonsterSprite_Roboster2 ; id 298 Roboster2
    dfar MonsterSprite_EvilPot ; id 299 EvilPot
    dfar MonsterSprite_Gismo ; id 300 Gismo
    dfar MonsterSprite_LavaMan ; id 301 LavaMan
    dfar MonsterSprite_IceMan ; id 302 IceMan
    dfar MonsterSprite_Mimic ; id 303 Mimic
    dfar MonsterSprite_Exaucers ; id 304 Exaucers
    dfar MonsterSprite_MudDoll ; id 305 MudDoll
    dfar MonsterSprite_Golem ; id 306 Golem
    dfar MonsterSprite_StoneMan ; id 307 StoneMan
    dfar MonsterSprite_BombCrag ; id 308 BombCrag
    dfar MonsterSprite_GoldGolem ; id 309 GoldGolem
    dfar MonsterSprite_DarkMate ; id 310 DarkMate
    dfar MonsterSprite_ProtoMech ; id 311 ProtoMech
    dfar MonsterSprite_CloudKing ; id 312 CloudKing
    dfar MonsterSprite_DrakSlime ; id 313 ?
    dfar MonsterSprite_DrakSlime ; id 314 ?
    dfar MonsterSprite_DrakSlime ; id 315 ?
    dfar MonsterSprite_Petiteel ; id 316 Petiteel
    dfar MonsterSprite_Moray ; id 317 Moray
    dfar MonsterSprite_WalrusMan ; id 318 WalrusMan
    dfar MonsterSprite_RayGigas ; id 319 RayGigas
    dfar MonsterSprite_Anemon ; id 320 Anemon
    dfar MonsterSprite_Aquarella ; id 321 Aquarella
    dfar MonsterSprite_Merman ; id 322 Merman
    dfar MonsterSprite_Octokid ; id 323 Octokid
    dfar MonsterSprite_PutreFish ; id 324 PutreFish
    dfar MonsterSprite_Octoreach ; id 325 Octoreach
    dfar MonsterSprite_Angleron ; id 326 Angleron
    dfar MonsterSprite_FishRider ; id 327 FishRider
    dfar MonsterSprite_RushFish ; id 328 RushFish
    dfar MonsterSprite_Gamanian ; id 329 Gamanian
    dfar MonsterSprite_Clawster ; id 330 Clawster
    dfar MonsterSprite_CancerMan ; id 331 CancerMan
    dfar MonsterSprite_RogueWave ; id 332 RogueWave
    dfar MonsterSprite_Scallopa ; id 333 Scallopa
    dfar MonsterSprite_SeaHorse ; id 334 SeaHorse
    dfar MonsterSprite_HoodSquid ; id 335 HoodSquid
    dfar MonsterSprite_MerTiger ; id 336 MerTiger
    dfar MonsterSprite_AxeShark ; id 337 AxeShark
    dfar MonsterSprite_Octogon ; id 338 Octogon
    dfar MonsterSprite_KingSquid ; id 339 KingSquid
    dfar MonsterSprite_Digong ; id 340 Digong
    dfar MonsterSprite_WhaleMage ; id 341 WhaleMage
    dfar MonsterSprite_Aquadon ; id 342 Aquadon
    dfar MonsterSprite_Octoraid ; id 343 Octoraid
    dfar MonsterSprite_Grakos ; id 344 Grakos
    dfar MonsterSprite_Poseidon ; id 345 Poseidon
    dfar MonsterSprite_Pumpoise ; id 346 Pumpoise
    dfar MonsterSprite_Starfish ; id 347 Starfish
    dfar MonsterSprite_DrakSlime ; id 348 ?
    dfar MonsterSprite_DrakSlime ; id 349 ?
    dfar MonsterSprite_DrakSlime ; id 350 ?
    dfar MonsterSprite_DracoLord ; id 351 DracoLord
    dfar MonsterSprite_DracoLord_160 ; id 352 DracoLord
    dfar MonsterSprite_LordDraco ; id 353 LordDraco
    dfar MonsterSprite_Hargon ; id 354 Hargon
    dfar MonsterSprite_Sidoh ; id 355 Sidoh
    dfar MonsterSprite_Genosidoh ; id 356 Genosidoh
    dfar MonsterSprite_Baramos ; id 357 Baramos
    dfar MonsterSprite_Zoma ; id 358 Zoma
    dfar MonsterSprite_AsuraZoma ; id 359 AsuraZoma
    dfar MonsterSprite_Pizzaro ; id 360 Pizzaro
    dfar MonsterSprite_PsychoPiz ; id 361 PsychoPiz
    dfar MonsterSprite_Esterk ; id 362 Esterk
    dfar MonsterSprite_Mirudraas ; id 363 Mirudraas
    dfar MonsterSprite_Mirudraas_16C ; id 364 Mirudraas
    dfar MonsterSprite_Mudou ; id 365 Mudou
    dfar MonsterSprite_DeathMore ; id 366 DeathMore
    dfar MonsterSprite_DeathMore_16F ; id 367 DeathMore
    dfar MonsterSprite_DeathMore_170 ; id 368 DeathMore
    dfar MonsterSprite_Darkdrium ; id 369 Darkdrium
    dfar MonsterSprite_Orgodemir ; id 370 Orgodemir
    dfar MonsterSprite_Orgodemir_173 ; id 371 Orgodemir
    dfar MonsterSprite_Darck ; id 372 Darck
    dfar MonsterSprite_DrakSlime ; id 373 Tatsu
    dfar MonsterSprite_DrakSlime ; id 374 Diago
    dfar MonsterSprite_DrakSlime ; id 375 Samsi
    dfar MonsterSprite_DrakSlime ; id 376 Bazoo
    dfar MonsterSprite_DrakSlime ; id 377 ?
    dfar MonsterSprite_DrakSlime ; id 378 ?
    dfar MonsterSprite_DrakSlime ; id 379 ?
    dfar MonsterSprite_Lamia ; id 380 Lamia
    dfar MonsterSprite_Dimensaur ; id 381 Dimensaur
    dfar MonsterSprite_Kagebou ; id 382 Kagebou

; E-0196 (C1: SetupKeyWorldObjectsForMapType passes $5327 + 2 * (kind - 1), or + 6 / + $E (goal kind 7) for the goal room, to SetupKeyWorldObjectsForMapType_Sub01; it follows MonsterSpriteTable, which therefore has 383 entries, not 384).
; record: object grid for this map kind
KeyWorldObjectGridTable::
Data_004_5327:: ; address name
    dw KeyWorldObjectGrid_5347 ; id 0
    dw KeyWorldObjectGrid_538C ; id 1
    dw KeyWorldObjectGrid_54C1 ; id 2
    dw KeyWorldObjectGrid_5561 ; id 3
    dw KeyWorldObjectGrid_5585 ; id 4
    dw KeyWorldObjectGrid_5597 ; id 5
    dw KeyWorldObjectGrid_55A9 ; id 6
    dw KeyWorldObjectGrid_5573 ; id 7
    dw KeyWorldObjectGrid_5347 ; id 8
    dw KeyWorldObjectGrid_5421 ; id 9
    dw KeyWorldObjectGrid_5511 ; id 10
    dw KeyWorldObjectGrid_5561 ; id 11
    dw KeyWorldObjectGrid_5585 ; id 12
    dw KeyWorldObjectGrid_5597 ; id 13
    dw KeyWorldObjectGrid_55A9 ; id 14
    dw KeyWorldObjectGrid_5573 ; id 15

; E-0196 (C1: SetupKeyWorldObjectsForMapType_Sub01 reads the word at the grid + 2 * (hMapScreenY * wMapWidthScreens + hMapScreenX); 2 screens, up to the next structure).
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_5347::
Data_004_5347:: ; address name
    dw KeyWorldScreenObjects_534B ; id 0
    dw KeyWorldScreenObjects_5366 ; id 1

; E-0196 (C1: a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list).
; record: marker word; pointer to the object list
KeyWorldScreenObjects_534B::
Data_004_534B:: ; address name
    dw $FFFE ; entry 0
    dw KeyWorldObjectList_534F

; E-0196 (C1: the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world encounter when hTemp9 is set).
; record: count 2, then 2 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_534F::
Data_004_534F:: ; address name
    db $02 ; entry 0: object count
    db $85, $01, $00, $00, $00, $40, $20, $05, $00, $50, $00 ; object 0
    db $86, $01, $01, $00, $00, $60, $50, $06, $03, $60, $01 ; object 1

; E-0196 (C1: a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list).
; record: marker word; pointer to the object list
KeyWorldScreenObjects_5366::
Data_004_5366:: ; address name
    dw $FFFE ; entry 0
    dw KeyWorldObjectList_536A

; E-0196 (C1: the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world encounter when hTemp9 is set).
; record: count 3, then 3 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_536A::
Data_004_536A:: ; address name
    db $03 ; entry 0: object count
    db $85, $01, $01, $00, $00, $30, $20, $05, $00, $50, $02 ; object 0
    db $86, $01, $01, $00, $00, $60, $60, $06, $00, $60, $03 ; object 1
    db $87, $01, $06, $00, $00, $70, $10, $07, $00, $70, $FA ; object 2

; E-0196 (C1: SetupKeyWorldObjectsForMapType_Sub01 reads the word at the grid + 2 * (hMapScreenY * wMapWidthScreens + hMapScreenX); 4 screens, up to the next structure).
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_538C::
Data_004_538C:: ; address name
    dw KeyWorldScreenObjects_5394 ; id 0
    dw KeyWorldScreenObjects_53AF ; id 1
    dw KeyWorldScreenObjects_53E0 ; id 2
    dw KeyWorldScreenObjects_53F0 ; id 3

; E-0196 (C1: a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list).
; record: marker word; pointer to the object list
KeyWorldScreenObjects_5394::
Data_004_5394:: ; address name
    dw $FFFE ; entry 0
    dw KeyWorldObjectList_5398

; E-0196 (C1: the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world encounter when hTemp9 is set).
; record: count 2, then 2 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_5398::
Data_004_5398:: ; address name
    db $02 ; entry 0: object count
    db $85, $01, $08, $00, $00, $E0, $E0, $05, $00, $50, $FC ; object 0
    db $86, $01, $02, $00, $00, $20, $40, $06, $00, $60, $00 ; object 1

; E-0196 (C1: a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list).
; record: marker word; pointer to the object list
KeyWorldScreenObjects_53AF::
Data_004_53AF:: ; address name
    dw $FFFE ; entry 0
    dw KeyWorldObjectList_53B3

; E-0196 (C1: the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world encounter when hTemp9 is set).
; record: count 4, then 4 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_53B3::
Data_004_53B3:: ; address name
    db $04 ; entry 0: object count
    db $85, $01, $02, $00, $00, $E0, $E0, $05, $00, $50, $FC ; object 0
    db $86, $01, $03, $00, $02, $40, $20, $06, $01, $60, $01 ; object 1
    db $87, $01, $04, $00, $00, $60, $50, $07, $00, $70, $02 ; object 2
    db $84, $01, $05, $00, $00, $20, $60, $04, $01, $40, $03 ; object 3

; E-0196 (C1: a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list).
; record: marker word; pointer to the object list
KeyWorldScreenObjects_53E0::
Data_004_53E0:: ; address name
    dw $FFFE ; entry 0
    dw KeyWorldObjectList_53E4

; E-0196 (C1: the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world encounter when hTemp9 is set).
; record: count 1, then 1 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_53E4::
Data_004_53E4:: ; address name
    db $01 ; entry 0
    db $85, $01, $04, $00, $00, $70, $50, $05, $00, $50, $04

; E-0196 (C1: a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list).
; record: marker word; pointer to the object list
KeyWorldScreenObjects_53F0::
Data_004_53F0:: ; address name
    dw $FFFE ; entry 0
    dw KeyWorldObjectList_53F4

; E-0196 (C1: the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world encounter when hTemp9 is set).
; record: count 4, then 4 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_53F4::
Data_004_53F4:: ; address name
    db $04 ; entry 0: object count
    db $85, $01, $03, $00, $00, $20, $40, $05, $03, $50, $05 ; object 0
    db $86, $01, $05, $00, $02, $40, $70, $06, $01, $60, $06 ; object 1
    db $87, $01, $02, $00, $00, $50, $30, $07, $00, $70, $07 ; object 2
    db $84, $01, $06, $00, $00, $60, $10, $04, $00, $40, $FA ; object 3

; E-0196 (C1: SetupKeyWorldObjectsForMapType_Sub01 reads the word at the grid + 2 * (hMapScreenY * wMapWidthScreens + hMapScreenX); 4 screens, up to the next structure).
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_5421::
Data_004_5421:: ; address name
    dw KeyWorldScreenObjects_5429 ; id 0
    dw KeyWorldScreenObjects_5444 ; id 1
    dw KeyWorldScreenObjects_5475 ; id 2
    dw KeyWorldScreenObjects_5490 ; id 3

; E-0196 (C1: a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list).
; record: marker word; pointer to the object list
KeyWorldScreenObjects_5429::
Data_004_5429:: ; address name
    dw $FFFE ; entry 0
    dw KeyWorldObjectList_542D

; E-0196 (C1: the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world encounter when hTemp9 is set).
; record: count 2, then 2 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_542D::
Data_004_542D:: ; address name
    db $02 ; entry 0: object count
    db $85, $01, $08, $00, $00, $E0, $E0, $05, $00, $50, $FC ; object 0
    db $86, $01, $04, $00, $00, $20, $40, $06, $00, $60, $04 ; object 1

; E-0196 (C1: a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list).
; record: marker word; pointer to the object list
KeyWorldScreenObjects_5444::
Data_004_5444:: ; address name
    dw $FFFE ; entry 0
    dw KeyWorldObjectList_5448

; E-0196 (C1: the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world encounter when hTemp9 is set).
; record: count 4, then 4 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_5448::
Data_004_5448:: ; address name
    db $04 ; entry 0: object count
    db $85, $01, $02, $00, $00, $E0, $E0, $05, $00, $50, $FC ; object 0
    db $86, $01, $03, $00, $00, $70, $50, $06, $01, $60, $05 ; object 1
    db $87, $01, $02, $00, $02, $30, $60, $07, $01, $70, $07 ; object 2
    db $84, $01, $07, $00, $00, $40, $20, $04, $00, $40, $FD ; object 3

; E-0196 (C1: a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list).
; record: marker word; pointer to the object list
KeyWorldScreenObjects_5475::
Data_004_5475:: ; address name
    dw $FFFE ; entry 0
    dw KeyWorldObjectList_5479

; E-0196 (C1: the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world encounter when hTemp9 is set).
; record: count 2, then 2 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_5479::
Data_004_5479:: ; address name
    db $02 ; entry 0: object count
    db $85, $01, $03, $00, $00, $70, $50, $05, $01, $50, $01 ; object 0
    db $86, $01, $05, $00, $02, $30, $60, $06, $01, $60, $06 ; object 1

; E-0196 (C1: a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list).
; record: marker word; pointer to the object list
KeyWorldScreenObjects_5490::
Data_004_5490:: ; address name
    dw $FFFE ; entry 0
    dw KeyWorldObjectList_5494

; E-0196 (C1: the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world encounter when hTemp9 is set).
; record: count 4, then 4 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_5494::
Data_004_5494:: ; address name
    db $04 ; entry 0: object count
    db $85, $01, $02, $00, $00, $70, $30, $05, $00, $50, $00 ; object 0
    db $86, $01, $04, $00, $00, $40, $70, $06, $02, $60, $02 ; object 1
    db $87, $01, $05, $00, $02, $40, $40, $07, $01, $70, $03 ; object 2
    db $84, $01, $06, $00, $00, $60, $10, $04, $00, $40, $FA ; object 3

; E-0196 (C1: SetupKeyWorldObjectsForMapType_Sub01 reads the word at the grid + 2 * (hMapScreenY * wMapWidthScreens + hMapScreenX); 2 screens, up to the next structure).
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_54C1::
Data_004_54C1:: ; address name
    dw KeyWorldScreenObjects_54C5 ; id 0
    dw KeyWorldScreenObjects_54E0 ; id 1

; E-0196 (C1: a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list).
; record: marker word; pointer to the object list
KeyWorldScreenObjects_54C5::
Data_004_54C5:: ; address name
    dw $FFFE ; entry 0
    dw KeyWorldObjectList_54C9

; E-0196 (C1: the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world encounter when hTemp9 is set).
; record: count 2, then 2 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_54C9::
Data_004_54C9:: ; address name
    db $02 ; entry 0: object count
    db $85, $01, $02, $00, $00, $50, $30, $05, $00, $50, $FD ; object 0
    db $86, $01, $04, $00, $00, $60, $70, $06, $03, $60, $00 ; object 1

; E-0196 (C1: a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list).
; record: marker word; pointer to the object list
KeyWorldScreenObjects_54E0::
Data_004_54E0:: ; address name
    dw $FFFE ; entry 0
    dw KeyWorldObjectList_54E4

; E-0196 (C1: the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world encounter when hTemp9 is set).
; record: count 4, then 4 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_54E4::
Data_004_54E4:: ; address name
    db $04 ; entry 0: object count
    db $85, $01, $03, $00, $00, $60, $30, $05, $03, $50, $01 ; object 0
    db $86, $01, $02, $00, $00, $20, $60, $06, $02, $60, $02 ; object 1
    db $87, $01, $05, $00, $02, $40, $70, $07, $01, $70, $03 ; object 2
    db $84, $01, $06, $00, $00, $20, $20, $04, $00, $40, $FA ; object 3

; E-0196 (C1: SetupKeyWorldObjectsForMapType_Sub01 reads the word at the grid + 2 * (hMapScreenY * wMapWidthScreens + hMapScreenX); 2 screens, up to the next structure).
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_5511::
Data_004_5511:: ; address name
    dw KeyWorldScreenObjects_5515 ; id 0
    dw KeyWorldScreenObjects_553B ; id 1

; E-0196 (C1: a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list).
; record: marker word; pointer to the object list
KeyWorldScreenObjects_5515::
Data_004_5515:: ; address name
    dw $FFFE ; entry 0
    dw KeyWorldObjectList_5519

; E-0196 (C1: the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world encounter when hTemp9 is set).
; record: count 3, then 3 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_5519::
Data_004_5519:: ; address name
    db $03 ; entry 0: object count
    db $85, $01, $02, $00, $00, $50, $30, $05, $00, $50, $FD ; object 0
    db $86, $01, $02, $00, $00, $30, $60, $06, $00, $60, $02 ; object 1
    db $87, $01, $05, $00, $00, $60, $70, $07, $00, $70, $03 ; object 2

; E-0196 (C1: a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list).
; record: marker word; pointer to the object list
KeyWorldScreenObjects_553B::
Data_004_553B:: ; address name
    dw $FFFE ; entry 0
    dw KeyWorldObjectList_553F

; E-0196 (C1: the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world encounter when hTemp9 is set).
; record: count 3, then 3 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_553F::
Data_004_553F:: ; address name
    db $03 ; entry 0: object count
    db $85, $01, $03, $00, $02, $60, $60, $05, $01, $50, $01 ; object 0
    db $86, $01, $04, $00, $00, $60, $30, $06, $00, $60, $00 ; object 1
    db $87, $01, $06, $00, $00, $20, $20, $07, $00, $70, $FA ; object 2

; E-0196 (C1: SetupKeyWorldObjectsForMapType_Sub01 reads the word at the grid + 2 * (hMapScreenY * wMapWidthScreens + hMapScreenX); 1 screens, up to the next structure).
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_5561::
Data_004_5561:: ; address name
    dw KeyWorldScreenObjects_5563 ; id 0

; E-0196 (C1: a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list).
; record: marker word; pointer to the object list
KeyWorldScreenObjects_5563::
Data_004_5563:: ; address name
    dw $FFFE ; entry 0
    dw KeyWorldObjectList_5567

; E-0196 (C1: the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world encounter when hTemp9 is set).
; record: count 1, then 1 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_5567::
Data_004_5567:: ; address name
    db $01 ; entry 0
    db $85, $01, $15, $00, $00, $30, $20, $05, $00, $50, $FC

; E-0196 (C1: SetupKeyWorldObjectsForMapType_Sub01 reads the word at the grid + 2 * (hMapScreenY * wMapWidthScreens + hMapScreenX); 1 screens, up to the next structure).
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_5573::
Data_004_5573:: ; address name
    dw KeyWorldScreenObjects_5575 ; id 0

; E-0196 (C1: a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list).
; record: marker word; pointer to the object list
KeyWorldScreenObjects_5575::
Data_004_5575:: ; address name
    dw $FFFE ; entry 0
    dw KeyWorldObjectList_5579

; E-0196 (C1: the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world encounter when hTemp9 is set).
; record: count 1, then 1 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_5579::
Data_004_5579:: ; address name
    db $01 ; entry 0
    db $85, $01, $44, $00, $00, $30, $20, $05, $00, $50, $FC

; E-0196 (C1: SetupKeyWorldObjectsForMapType_Sub01 reads the word at the grid + 2 * (hMapScreenY * wMapWidthScreens + hMapScreenX); 1 screens, up to the next structure).
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_5585::
Data_004_5585:: ; address name
    dw KeyWorldScreenObjects_5587 ; id 0

; E-0196 (C1: a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list).
; record: marker word; pointer to the object list
KeyWorldScreenObjects_5587::
Data_004_5587:: ; address name
    dw $FFFE ; entry 0
    dw KeyWorldObjectList_558B

; E-0196 (C1: the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world encounter when hTemp9 is set).
; record: count 1, then 1 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_558B::
Data_004_558B:: ; address name
    db $01 ; entry 0
    db $85, $00, $28, $00, $00, $50, $10, $05, $00, $50, $FE

; E-0196 (C1: SetupKeyWorldObjectsForMapType_Sub01 reads the word at the grid + 2 * (hMapScreenY * wMapWidthScreens + hMapScreenX); 1 screens, up to the next structure).
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_5597::
Data_004_5597:: ; address name
    dw KeyWorldScreenObjects_5599 ; id 0

; E-0196 (C1: a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list).
; record: marker word; pointer to the object list
KeyWorldScreenObjects_5599::
Data_004_5599:: ; address name
    dw $FFFE ; entry 0
    dw KeyWorldObjectList_559D

; E-0196 (C1: the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world encounter when hTemp9 is set).
; record: count 1, then 1 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_559D::
Data_004_559D:: ; address name
    db $01 ; entry 0
    db $85, $00, $28, $00, $00, $50, $10, $05, $00, $50, $FE

; E-0196 (C1: SetupKeyWorldObjectsForMapType_Sub01 reads the word at the grid + 2 * (hMapScreenY * wMapWidthScreens + hMapScreenX); 1 screens, up to the next structure).
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_55A9::
Data_004_55A9:: ; address name
    dw KeyWorldScreenObjects_55AB ; id 0

; E-0196 (C1: a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list).
; record: marker word; pointer to the object list
KeyWorldScreenObjects_55AB::
Data_004_55AB:: ; address name
    dw $FFFE ; entry 0
    dw KeyWorldObjectList_55AF

; E-0196 (C1: the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world encounter when hTemp9 is set).
; record: count 1, then 1 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_55AF::
Data_004_55AF:: ; address name
    db $01 ; entry 0
    db $85, $00, $28, $00, $00, $40, $50, $05, $00, $50, $FB

; starts a message through script command $09 (message word HL, shown by the same group dispatch as ShowMessageHL when wD7F0 = 0): HL is stored in wScriptParam0 (low) and wScriptParam1 (high); then wC5DC = 1, wC920 = 9, wC91F = 1, wC923 = 0 and wC919 = 0 (an earlier store of $80 to wC919 is overwritten)
; 357 call sites from 201 routines (e.g. IfFlag00D1Msg0D3A_ToBeHonestI, IfFlag00D1Msg0D39_AhGreatLogsMightyHero, IfFlag00D1Msg0D38_JustImagineIfYou, IfFlag00D1Msg0D37_InsteadOfStandingAround, ...)
; writes: wScriptParam0, wScriptParam1, wScriptStartRequest, wModeState, wScriptCommandType, wScriptRunning, wScriptStep
StartMessageCommand09HL_B04::
Func_004_55BB:: ; address name
    ld a, l
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, $01
    ld [wModeState], a
    ld a, $09
    ld [wScriptCommandType], a
    ld a, $01
    ld [wScriptRunning], a
    xor a, a
    ld [wScriptStartRequest], a
    ld [wScriptStep], a
    ret

; starts script command $0A (RunOneTimeTreasure) with DE = the treasure's story flag, stored in wMessageIndex/wMessageGroup (which that command passes to TestFlagBit and SetFlagBit; it is not a message word, correcting E-0081); then wScriptCommandType = $0A, wScriptRunning = 1, wScriptStep = 0 (E-0269)
; 102 call sites from 102 routines (e.g. ChestItem_LoveWater_Flag01FA, ChestItem_Starry, ChestItem_Fight, ChestItem_Herb_Flag01F7, ...)
; writes: wMessageIndex, wMessageGroup, wScriptStartRequest, wModeState, wScriptCommandType, wScriptRunning, wScriptStep
StartTreasureFlagDE_B04::
Func_004_55DF:: ; address name
    ld a, e
    ld [wMessageIndex], a
    ld a, d
    ld [wMessageGroup], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, $01
    ld [wModeState], a
    ld a, $0A
    ld [wScriptCommandType], a
    ld a, $01
    ld [wScriptRunning], a
    xor a, a
    ld [wScriptStartRequest], a
    ld [wScriptStep], a
    ret

; HL is stored in wScriptPointerLo/Hi; then wScriptStartRequest = $80 and wModeState = 1, so the script engine starts fetching at HL (E-0082)
; 187 call sites from 129 routines (e.g. MapEventCountKeysAndStartScript5039, DispatchTalkEvent_Case0A_Sub01_Case0A, TalkScript5441_HeroCheckedThePedestalIts, Talk0046_ThanksForComingBy, ...)
; writes: wScriptPointerLo, wScriptPointerHi, wScriptStartRequest, wModeState
StartScriptAtHL_B04::
Func_004_5603:: ; address name
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, $01
    ld [wModeState], a
    ret

; only called from DispatchTalkEvent_Case0A (E-0047)
; 1 call site from 1 routine (e.g. DispatchTalkEvent_Case0A)
; reads: wTalkEventGroup
DispatchTalkEvent_Case0A_Sub01::
Func_004_5616:: ; address name
    ld a, [wTalkEventGroup]
    rst $00
    dw DispatchTalkEvent_Case0A_Sub01_Case00
    dw TalkScript4F54_HehSoTheseAreTheNewcomers
    dw TalkScript5111_ListenYouTwoQuitYourHorsing
    dw $0000 ; unused index (E-0207)
    dw StartScript4F73AndSetFlag5
    dw StartScript4F7CAndSetFlag06
    dw IfFlag000AStartScript4F9D
    dw Talk0046_ThanksForComingBy
    dw TalkMsg0047_HeroReadTheNoticeWeGuarantee
    dw TalkScript5441_HeroCheckedThePedestalIts
    dw DispatchTalkEvent_Case0A_Sub01_Case0A
    dw TalkMsg0233_HeroCheckedTheBookshelfMonster
    dw TalkMsg0234_HeroCheckedTheBookshelfMonster
    dw TalkMsg0235_HeroCheckedTheBookshelfPersonalities
    dw TalkMsg0236_HeroCheckedTheBookshelfNuts
    dw TalkMsg0237_HeroCheckedTheBookshelfWorldLeaf
    dw TalkMsg0238_HeroCheckedTheBookshelfMagic
    dw TalkMsg0239_HeroCheckedTheBookshelfMagic
    dw TalkMsg023A_HeroCheckedTheBookshelfStarry
    dw TalkMsg023B_HeroCheckedTheBookshelfEgg
    dw TalkMsg023C_HeroCheckedTheBookshelfAccessory
    dw TalkMsg023D_HeroCheckedTheBookshelfHidden
    dw TalkMsg023E_HeroReadTheNoticePleaseReturn
    dw DispatchTalkEvent_Case0A_Sub01_Case17
    dw TalkMsg0010_HeroPeeredIntoTheVaseFreshly
    dw TalkMsg000F_HeroPeeredIntoTheBarrelIt
    dw MapEventCountKeysAndStartScript5039
    dw IfFlag00D1Msg0D33_YouSavedUsAll
    dw IfFlag00D1Msg0D34_PleaseEatUpEat
    dw IfFlag00D1Msg0D35_HmISawYour
    dw IfFlag00D1Msg0D36_TheKingdomIsRejoicing
    dw IfFlag00D1Msg0D37_InsteadOfStandingAround
    dw IfFlag00D1Msg0D38_JustImagineIfYou
    dw IfFlag00D1Msg0D39_AhGreatLogsMightyHero
    dw IfFlag00D1Msg0D3A_ToBeHonestI

; entry 0 of the `rst $00` table in Func_004_5616
; no direct call (reached through a table, a jump or a vector)
; starts Script_5063: 'In the middle of the sea'
DispatchTalkEvent_Case0A_Sub01_Case00::
Jump_004_5660:: ; address name
    ld de, $0001
    call TestFlagBit
    jr nc, Jump_004_566F
    ld hl, Script_5063
    call StartScriptAtHL_B04
    ret

Jump_004_566F::
    ld hl, Script_509F
    call StartScriptAtHL_B04
    ret

; starts Script_4F54 (StartScriptAtHL); its first message begins 'Heh, so these are the newcomers?' (E-0271; was DispatchTalkEvent_Case0A_Sub01_Case01)
; no direct call (reached through a table, a jump or a vector)
; starts Script_4F54: 'Heh, so these are the newcomers?'
TalkScript4F54_HehSoTheseAreTheNewcomers::
Jump_004_5676:: ; address name
    ld hl, Script_4F54
    call StartScriptAtHL_B04
    ret

; starts Script_5111 (StartScriptAtHL); its first message begins 'Listen you two! Quit your horsing' (E-0271; was DispatchTalkEvent_Case0A_Sub01_Case02)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5111: 'Listen you two! Quit your horsing'
TalkScript5111_ListenYouTwoQuitYourHorsing::
Jump_004_567D:: ; address name
    ld hl, Script_5111
    call StartScriptAtHL_B04
    ret
    db $21, $44, $00, $CD, $BB, $55, $C9

; StartScriptAtHL_B04 with HL = $4F73, then sets story flag 5 (E-0119)
; no direct call (reached through a table, a jump or a vector)
; starts Script_4F73: 'Oh It's all spinning around That'
StartScript4F73AndSetFlag5::
Jump_004_568B:: ; address name
    ld hl, Script_4F73
    call StartScriptAtHL_B04
    ld de, $0005
    call SetFlagBit
    ret

; map event: starts script $4F7C, runs Func_012_6B98 with hFFC6 = 0 and sets story flag 6 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
; starts Script_4F7C
StartScript4F7CAndSetFlag06::
Jump_004_5698:: ; address name
    ld hl, Script_4F7C
    call StartScriptAtHL_B04
    ld a, $00
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld de, $0006
    call SetFlagBit
    ret

; when story flag $0A is set, StartScriptAtHL_B04 with HL = $4F9D (E-0119)
; no direct call (reached through a table, a jump or a vector)
; starts Script_4F9D: 'Warubou Calm down and listen! What'
IfFlag000AStartScript4F9D::
Jump_004_56AF:: ; address name
    ld de, $000A
    call TestFlagBit
    ret nc
    ld hl, Script_4F9D
    call StartScriptAtHL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 2 constant message(s) depending on story flags and state; the first one in the code is $0046, whose string begins 'Thanks for coming by. I'll always'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wDataBank
Talk0046_ThanksForComingBy::
Jump_004_56BD:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_004_571D
    ld de, $0002
    call TestFlagBit
    jr c, Jump_004_5702
    ld de, $000C
    call TestFlagBit
    jr c, Jump_004_56FB
    ld de, $0007
    call TestFlagBit
    jr c, Jump_004_56F4
    ld a, $01
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld hl, Script_4F88
    call StartScriptAtHL_B04
    ld de, $0007
    call SetFlagBit
    ret

Jump_004_56F4::
    ld hl, $0046 ; 'Thanks for coming by. I'll always'
    call StartMessageCommand09HL_B04
    ret

Jump_004_56FB::
    ld hl, $0079 ; 'You say the island will sink?'
    call StartMessageCommand09HL_B04
    ret

Jump_004_5702::
    ld a, $10
    ld [wDataBank], a
    ld de, $0103
    call TestFlagBit
    jr c, Jump_004_5716
    ld hl, Script_5353
    call StartScriptAtHL_B04
    ret

Jump_004_5716::
    ld hl, Script_535D
    call StartScriptAtHL_B04
    ret

Jump_004_571D::
    ld a, $10
    ld [wDataBank], a
    ld de, $0127
    call TestFlagBit
    jr c, Jump_004_5716
    ld hl, Script_5364
    call StartScriptAtHL_B04
    ret

; starts message $0047 through StartMessageCommand09HL (script command $09); that string begins '0 read the notice. We guarantee the' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case0A_Sub01_Case08)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5441: '0 checked the pedestal. It's the'
TalkMsg0047_HeroReadTheNoticeWeGuarantee::
Jump_004_5731:: ; address name
    ld hl, $0047 ; '0 read the notice. We guarantee'
    call StartMessageCommand09HL_B04
    ret

; starts Script_5441 (StartScriptAtHL); its first message begins '0 checked the pedestal. It's the' (E-0271; was DispatchTalkEvent_Case0A_Sub01_Case09)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5441: '0 checked the pedestal. It's the'
TalkScript5441_HeroCheckedThePedestalIts::
Jump_004_5738:: ; address name
    ld hl, Script_5441
    call StartScriptAtHL_B04
    ret

; entry 10 of the `rst $00` table in Func_004_5616
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, hTemp1, hTemp0
; writes: wSpriteSlots, wDataBank
DispatchTalkEvent_Case0A_Sub01_Case0A::
Jump_004_573F:: ; address name
    ldh a, [hPlayerX]
    cp a, $40
    jr z, Jump_004_574C
    ld a, $03
    ld [wSpriteSlots + $7], a
    jr Jump_004_5750

Jump_004_574C::
    xor a, a
    ld [wSpriteSlots + $7], a

Jump_004_5750::
    ld a, $1F
    ld [wDataBank], a
    ld de, $0025
    call TestFlagBit
    jr c, Jump_004_5773
    ld de, $0108
    call TestFlagBit
    jr c, Jump_004_576C
    ld hl, Script_544E
    call StartScriptAtHL_B04
    ret

Jump_004_576C::
    ld hl, Script_5458
    call StartScriptAtHL_B04
    ret

Jump_004_5773::
    farcall TotalSpeciesFlaggedOrListed
    ldh a, [hTemp1]
    or a, a
    jr z, Jump_004_5786
    ldh a, [hTemp0]
    cp a, $38
    jr c, Jump_004_5786
    jr Jump_004_5795

Jump_004_5786::
    ld de, $002D
    call TestFlagBit
    jr c, Jump_004_576C
    ld hl, Script_545F
    call StartScriptAtHL_B04
    ret

Jump_004_5795::
    ld de, $019E
    call TestFlagBit
    jr c, Jump_004_5786
    ld hl, Script_5469
    call StartScriptAtHL_B04
    ret

; starts message $0233 through StartMessageCommand09HL (script command $09); that string begins '0 checked the bookshelf. Monster Skills Every' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case0A_Sub01_Case0B)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0233_HeroCheckedTheBookshelfMonster::
Jump_004_57A4:: ; address name
    ld hl, $0233 ; '0 checked the bookshelf. Monster Skills'
    call StartMessageCommand09HL_B04
    ret

; starts message $0234 through StartMessageCommand09HL (script command $09); that string begins '0 checked the bookshelf. Monster Growth By' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case0A_Sub01_Case0C)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0234_HeroCheckedTheBookshelfMonster::
Jump_004_57AB:: ; address name
    ld hl, $0234 ; '0 checked the bookshelf. Monster Growth'
    call StartMessageCommand09HL_B04
    ret

; starts message $0235 through StartMessageCommand09HL (script command $09); that string begins '0 checked the bookshelf. Personalities of Monsters' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case0A_Sub01_Case0D)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0235_HeroCheckedTheBookshelfPersonalities::
Jump_004_57B2:: ; address name
    ld hl, $0235 ; '0 checked the bookshelf. Personalities of'
    call StartMessageCommand09HL_B04
    ret

; starts message $0236 through StartMessageCommand09HL (script command $09); that string begins '0 checked the bookshelf. Nuts and Seeds' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case0A_Sub01_Case0E)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0236_HeroCheckedTheBookshelfNuts::
Jump_004_57B9:: ; address name
    ld hl, $0236 ; '0 checked the bookshelf. Nuts and'
    call StartMessageCommand09HL_B04
    ret

; starts message $0237 through StartMessageCommand09HL (script command $09); that string begins '0 checked the bookshelf. WorldLeaf An indispensable' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case0A_Sub01_Case0F)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0237_HeroCheckedTheBookshelfWorldLeaf::
Jump_004_57C0:: ; address name
    ld hl, $0237 ; '0 checked the bookshelf. WorldLeaf An'
    call StartMessageCommand09HL_B04
    ret

; starts message $0238 through StartMessageCommand09HL (script command $09); that string begins '0 checked the bookshelf. Magic Key Guide' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case0A_Sub01_Case10)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0238_HeroCheckedTheBookshelfMagic::
Jump_004_57C7:: ; address name
    ld hl, $0238 ; '0 checked the bookshelf. Magic Key'
    call StartMessageCommand09HL_B04
    ret

; starts message $0239 through StartMessageCommand09HL (script command $09); that string begins '0 checked the bookshelf. Magic Key Guide' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case0A_Sub01_Case11)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0239_HeroCheckedTheBookshelfMagic::
Jump_004_57CE:: ; address name
    ld hl, $0239 ; '0 checked the bookshelf. Magic Key'
    call StartMessageCommand09HL_B04
    ret

; starts message $023A through StartMessageCommand09HL (script command $09); that string begins '0 checked the bookshelf. Starry Shrine A' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case0A_Sub01_Case12)
; no direct call (reached through a table, a jump or a vector)
TalkMsg023A_HeroCheckedTheBookshelfStarry::
Jump_004_57D5:: ; address name
    ld hl, $023A ; '0 checked the bookshelf. Starry Shrine'
    call StartMessageCommand09HL_B04
    ret

; starts message $023B through StartMessageCommand09HL (script command $09); that string begins '0 checked the bookshelf. Egg Evaluators Those' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case0A_Sub01_Case13)
; no direct call (reached through a table, a jump or a vector)
TalkMsg023B_HeroCheckedTheBookshelfEgg::
Jump_004_57DC:: ; address name
    ld hl, $023B ; '0 checked the bookshelf. Egg Evaluators'
    call StartMessageCommand09HL_B04
    ret

; starts message $023C through StartMessageCommand09HL (script command $09); that string begins '0 checked the bookshelf. Accessory Guide A' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case0A_Sub01_Case14)
; no direct call (reached through a table, a jump or a vector)
TalkMsg023C_HeroCheckedTheBookshelfAccessory::
Jump_004_57E3:: ; address name
    ld hl, $023C ; '0 checked the bookshelf. Accessory Guide'
    call StartMessageCommand09HL_B04
    ret

; starts message $023D through StartMessageCommand09HL (script command $09); that string begins '0 checked the bookshelf. Hidden Abilities Monsters' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case0A_Sub01_Case15)
; no direct call (reached through a table, a jump or a vector)
TalkMsg023D_HeroCheckedTheBookshelfHidden::
Jump_004_57EA:: ; address name
    ld hl, $023D ; '0 checked the bookshelf. Hidden Abilities'
    call StartMessageCommand09HL_B04
    ret

; starts message $023E through StartMessageCommand09HL (script command $09); that string begins '0 read the notice. Please return books' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case0A_Sub01_Case16)
; no direct call (reached through a table, a jump or a vector)
TalkMsg023E_HeroReadTheNoticePleaseReturn::
Jump_004_57F1:: ; address name
    ld hl, $023E ; '0 read the notice. Please return'
    call StartMessageCommand09HL_B04
    ret

; entry 23 of the `rst $00` table in Func_004_5616
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case0A_Sub01_Case17::
Jump_004_57F8:: ; address name
    ld de, $0025
    call TestFlagBit
    jr c, Jump_004_5807
    ld de, $0024
    call TestFlagBit
    ret c

Jump_004_5807::
    ld hl, $0042 ; '0 read the sign. Danger! Stay'
    call StartMessageCommand09HL_B04
    ret

; starts message $0010 through StartMessageCommand09HL (script command $09); that string begins '0 peered into the vase. Freshly caught' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case0A_Sub01_Case18)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0010_HeroPeeredIntoTheVaseFreshly::
Jump_004_580E:: ; address name
    ld hl, $0010 ; '0 peered into the vase. Freshly'
    call StartMessageCommand09HL_B04
    ret

; starts message $000F through StartMessageCommand09HL (script command $09); that string begins '0 peered into the barrel. It was' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case0A_Sub01_Case19)
; no direct call (reached through a table, a jump or a vector)
TalkMsg000F_HeroPeeredIntoTheBarrelIt::
Jump_004_5815:: ; address name
    ld hl, $000F ; '0 peered into the barrel. It'
    call StartMessageCommand09HL_B04
    ret

; with story flag $1A set: counts keys twice (Func_012_6955 with hFFC7 = 1 and 2), sets bit 7 of wC836 and starts script $5039 (E-0124)
; no direct call (reached through a table, a jump or a vector)
; reads: wGameFlags836
; writes: hTemp1, wGameFlags836
MapEventCountKeysAndStartScript5039::
Jump_004_581C:: ; address name
    ld de, $001A
    call TestFlagBit
    ret nc
    farcall CountKeysOrFull
    ld a, $01
    ldh [hTemp1], a
    farcall WriteKeyEntryTemp0
    farcall CountKeysOrFull
    ld a, $02
    ldh [hTemp1], a
    farcall WriteKeyEntryTemp0
    ld a, [wGameFlags836]
    set 7, a
    ld [wGameFlags836], a
    ld hl, Script_5039
    call StartScriptAtHL_B04
    ret

; when story flag $00D1 is set (TestFlagBit), starts message $0D33 through StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'You saved us all by yourself.' (E-0082)
; no direct call (reached through a table, a jump or a vector)
IfFlag00D1Msg0D33_YouSavedUsAll::
Jump_004_5852:: ; address name
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld hl, $0D33 ; 'You saved us all by yourself.'
    call StartMessageCommand09HL_B04
    ret

; when story flag $00D1 is set (TestFlagBit), starts message $0D34 through StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'Please, eat up, eat up! Don't' (E-0082)
; no direct call (reached through a table, a jump or a vector)
IfFlag00D1Msg0D34_PleaseEatUpEat::
Jump_004_5860:: ; address name
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld hl, $0D34 ; 'Please, eat up, eat up! Don't'
    call StartMessageCommand09HL_B04
    ret

; when story flag $00D1 is set (TestFlagBit), starts message $0D35 through StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'Hm? I saw your family. They' (E-0082)
; no direct call (reached through a table, a jump or a vector)
IfFlag00D1Msg0D35_HmISawYour::
Jump_004_586E:: ; address name
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld hl, $0D35 ; 'Hm? I saw your family. They'
    call StartMessageCommand09HL_B04
    ret

; when story flag $00D1 is set (TestFlagBit), starts message $0D36 through StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'The Kingdom is rejoicing!' (E-0082)
; no direct call (reached through a table, a jump or a vector)
IfFlag00D1Msg0D36_TheKingdomIsRejoicing::
Jump_004_587C:: ; address name
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld hl, $0D36 ; 'The Kingdom is rejoicing!'
    call StartMessageCommand09HL_B04
    ret

; when story flag $00D1 is set (TestFlagBit), starts message $0D37 through StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'Instead of standing around, you should' (E-0082)
; no direct call (reached through a table, a jump or a vector)
IfFlag00D1Msg0D37_InsteadOfStandingAround::
Jump_004_588A:: ; address name
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld hl, $0D37 ; 'Instead of standing around, you should'
    call StartMessageCommand09HL_B04
    ret

; when story flag $00D1 is set (TestFlagBit), starts message $0D38 through StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'Just imagine if you weren't here.' (E-0082)
; no direct call (reached through a table, a jump or a vector)
IfFlag00D1Msg0D38_JustImagineIfYou::
Jump_004_5898:: ; address name
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld hl, $0D38 ; 'Just imagine if you weren't here.'
    call StartMessageCommand09HL_B04
    ret

; when story flag $00D1 is set (TestFlagBit), starts message $0D39 through StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'Ah, GreatLog's mighty hero! I hope' (E-0082)
; no direct call (reached through a table, a jump or a vector)
IfFlag00D1Msg0D39_AhGreatLogsMightyHero::
Jump_004_58A6:: ; address name
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld hl, $0D39 ; 'Ah, GreatLog's mighty hero! I hope'
    call StartMessageCommand09HL_B04
    ret

; when story flag $00D1 is set (TestFlagBit), starts message $0D3A through StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'To be honest, I was getting' (E-0082)
; no direct call (reached through a table, a jump or a vector)
IfFlag00D1Msg0D3A_ToBeHonestI::
Jump_004_58B4:: ; address name
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld hl, $0D3A ; 'To be honest, I was getting'
    call StartMessageCommand09HL_B04
    ret

; only called from DispatchTalkEvent_Case03 (E-0047)
; 1 call site from 1 routine (e.g. DispatchTalkEvent_Case03)
; reads: wTalkEventGroup
DispatchTalkEvent_Case03_Sub01::
Func_004_58C2:: ; address name
    ld a, [wTalkEventGroup]
    rst $00
    dw TalkMsg0800_ThisIsTheVillageOfYold
    dw TalkMsg0801_InTheNorthwestIsAVillage
    dw TalkMsg0802_AroundThesePartsItsFaster
    dw TalkMsg0803_ISawAHauntedShipIn
    dw TalkMsg0804_TheVolcanicIslandOffTheCoast
    dw TalkMsg0805_MermaidsLivedInTheSeaIn
    dw DispatchTalkEvent_Case03_Sub01_Case06
    dw DispatchTalkEvent_Case03_Sub01_Case07
    dw TalkMsg080A_HeroPeeredIntoTheBarrelA
    dw TalkMsg080B_HeroPeeredIntoTheBarrelIt
    dw BarrelItem_TinyMedal
    dw BarrelItem_Warp
    dw TalkMsg088A_HeroPeeredIntoTheVaseIt
    dw TalkMsg0889_HeroPeeredIntoTheOvenIt
    dw TalkMsg0037_HeroTriedToOpenTheChest
    dw TalkMsg080C_WelcomeToPolonaItsATourist
    dw TalkMsg080D_YouCouldMeetMermaidsHere
    dw TalkMsg080E_ImFromThePortInThe
    dw TalkMsg080F_YoureNotSupposedToGoNear
    dw DispatchTalkEvent_Case03_Sub01_Case13
    dw DispatchTalkEvent_Case03_Sub01_Case14
    dw TalkScript5B9B_HaveYouHeardTheLegendAbout
    dw TalkMsg081B_AhhThisIsHeavenlyItMakes
    dw TalkMsg081C_ICameFromFarAwayTo
    dw TalkMsg088B_HeroReadTheSignWelcomeTo
    dw TalkMsg0889_HeroPeeredIntoTheOvenIt_045B54
    dw TalkMsg081D_ThisIsPortRitzWhereShips
    dw TalkMsg081E_ThePiratesWereSwallowedBy
    dw TalkMsg081F_TheresThisOldSailorManIn
    dw TalkScript5BA8_HowMayOurChurchServeYou
    dw TalkMsg0821_AllSortsOfPeopleComeHere
    dw TalkMsg0822_IWentToPolonaAWhile
    dw DispatchTalkEvent_Case03_Sub01_Case20
    dw TalkMsg0824_ThereIsALighthouseToThe
    dw TalkMsg0825_MyShipSankInTheEastern
    dw TalkMsg0826_TheOldManInTheTaverns
    dw TalkMsg0827_ThisPortUsedToBeLively
    dw TalkMsg0829_TheLighthouseHadTheMoonRock
    dw TalkMsg082A_TheSeasLevelHasGoneDown
    dw TalkMsg082B_ListenDidYouKnowMermaids
    dw TalkMsg088D_HeroPeeredIntoTheOvenTwo
    dw TalkScript5BB6_HeroTriedToCheckTheChest
    dw TalkMsg082E_HeroPeeredIntoTheBarrelIt
    dw BarrelItem_TinyMedal_Flag0063
    dw DispatchTalkEvent_Case03_Sub01_Case2C
    dw TalkMsg082F_ThisAreaWasALotMore
    dw TalkMsg0830_WhenYoureOutAtSeaYou
    dw TalkScript5BC4
    dw TalkMsg0834_WhenThatOldManGetsGrogged
    dw TalkMsg0835_TheOldFellowThereTheInstant
    dw TalkMsg0836_TheVolcanicIslandOffTheCoast
    dw DispatchTalkEvent_Case03_Sub01_Case33
    dw DispatchTalkEvent_Case03_Sub01_Case34
    dw ChestItem_Rib
    dw ChestItem_LoveWater
    dw ChestItem_LoveWater_Flag0069
    dw ChestItem_ExitBell
    dw ChestItem_MermScale
    dw ChestItem_Warp
    dw TalkMsg0843_ISawAChildCrossThe
    dw TalkMsg0844_WatchMeDanceAndYoullWant
    dw DispatchTalkEvent_Case03_Sub01_Case3D
    dw DispatchTalkEvent_Case03_Sub01_Case3E
    dw TalkMsg084F_IKnowNotAllHumansAre
    dw TalkMsg0850_ThePiratesCaughtUsInNets
    dw TalkMsg0851_TheHarMirrorWasExquisite
    dw TalkMsg0852_TheMoonRockFellFromTheSky
    dw TalkMsg0853_ThePiratesSankWithTheirShip
    dw TalkMsg0854_WeMermaidsArePeacefulBeings
    dw DispatchTalkEvent_Case03_Sub01_Case45
    dw TalkScript5C88
    dw TalkScript5C8A_HowCouldWeDieBeforeEnjoying
    dw TalkScript5C94_TheTreasuresAreOursNoOne
    dw TalkScript5C9E_ItNagsAndNagsThatWe
    dw DispatchTalkEvent_Case03_Sub01_Case4A
    dw DispatchTalkEvent_Case03_Sub01_Case4B
    dw DispatchTalkEvent_Case03_Sub01_Case4C
    dw DispatchTalkEvent_Case03_Sub01_Case4D
    dw ChestItem_LogTwig
    dw DispatchTalkEvent_Case03_Sub01_Case4F
    dw DispatchTalkEvent_Case03_Sub01_Case50
    dw TalkScript5CDD_KamehaUrkHowYouCatchUp
    dw TalkScript5D1C_KamehaArrrrhClearTheWayIm
    dw TalkScript5D2F
    dw ChestItem_Repellent
    dw ChestItem_Warp_Flag00E1
    dw ChestItem_WorldLeaf
    dw ChestItem_LifeAcorn
    dw ChestItem_DEFseed
    dw TalkMsg088C_HeroPeeredIntoTheVaseThere
    dw ChestItem_WorldDew
    dw ChestItem_War
    dw VaseItem_Antidote
    dw VaseItem_LoveWater
    dw VaseItem_Warp
    dw TalkMsg0861_HeroPeeredIntoTheBarrelA
    dw BarrelItem_BadMeat
    dw BarrelItem_PorkChop
    dw ChestItem_OrcaCape
    dw ChestItem_Repellent_Flag00EC
    dw ChestItem_WorldLeaf_Flag00ED
    dw ChestItem_AGLseed
    dw BarrelItem_Potion
    dw BarrelItem_INTseed
    dw TalkMsg0862_HeroPeeredIntoTheBarrelThere
    dw TalkMsg0864_HeroCheckedTheLedgerVoyage
    dw DispatchTalkEvent_Case03_Sub01_Case6A
    dw TalkMsg00FF_Composing
    dw TalkScript5D44_ThickSuctionCuppedTentacles
    dw DispatchTalkEvent_Case03_Sub01_Case6D

; starts message $0800 through StartMessageCommand09HL (script command $09); that string begins 'This is the village of Yold. We're' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case00)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0800_ThisIsTheVillageOfYold::
Jump_004_59A2:: ; address name
    ld hl, $0800 ; 'This is the village of Yold.'
    call StartMessageCommand09HL_B04
    ret

; starts message $0801 through StartMessageCommand09HL (script command $09); that string begins 'In the northwest is a village that' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case01)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0801_InTheNorthwestIsAVillage::
Jump_004_59A9:: ; address name
    ld hl, $0801 ; 'In the northwest is a village'
    call StartMessageCommand09HL_B04
    ret

; starts message $0802 through StartMessageCommand09HL (script command $09); that string begins 'Around these parts it's faster to travel' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case02)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0802_AroundThesePartsItsFaster::
Jump_004_59B0:: ; address name
    ld hl, $0802 ; 'Around these parts it's faster to'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005F then jr c, Jump_004_59C6); starts message $0803 through StartMessageCommand09HL (script command $09); that string begins 'I saw a haunted ship in the' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case03)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0803_ISawAHauntedShipIn::
Jump_004_59B7:: ; address name
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_59C6
    ld hl, $0803 ; 'I saw a haunted ship in'
    call StartMessageCommand09HL_B04
    ret

Jump_004_59C6::
    ld hl, $0874 ; 'I haven't seen the ghost ship'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005F then jr c, Jump_004_59DC); starts message $0804 through StartMessageCommand09HL (script command $09); that string begins 'The volcanic island off the coast appears' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case04)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0804_TheVolcanicIslandOffTheCoast::
Jump_004_59CD:: ; address name
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_59DC
    ld hl, $0804 ; 'The volcanic island off the coast'
    call StartMessageCommand09HL_B04
    ret

Jump_004_59DC::
    ld hl, $0875 ; 'The volcanic island appears to have'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005F then jr c, Jump_004_59F2); starts message $0805 through StartMessageCommand09HL (script command $09); that string begins 'Mermaids lived in the sea in the' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case05)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0805_MermaidsLivedInTheSeaIn::
Jump_004_59E3:: ; address name
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_59F2
    ld hl, $0805 ; 'Mermaids lived in the sea in'
    call StartMessageCommand09HL_B04
    ret

Jump_004_59F2::
    ld hl, $0876 ; 'Sigh Will the HarMirror make me'
    call StartMessageCommand09HL_B04
    ret

; entry 6 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case03_Sub01_Case06::
Jump_004_59F9:: ; address name
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_5A1D
    ld de, $0060
    call TestFlagBit
    jr c, Jump_004_5A16
    ld hl, Script_5B84
    call StartScriptAtHL_B04
    ld de, $0060
    call SetFlagBit
    ret

Jump_004_5A16::
    ld hl, $0808 ; 'I hope the volcanic island off'
    call StartMessageCommand09HL_B04
    ret

Jump_004_5A1D::
    ld hl, $0877 ; 'My grandson just shivers now He's'
    call StartMessageCommand09HL_B04
    ret

; entry 7 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenTableIndex, wDataBank
DispatchTalkEvent_Case03_Sub01_Case07::
Jump_004_5A24:: ; address name
    ld a, $04
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_5B8C
    call StartScriptAtHL_B04
    ret

; starts message $080A through StartMessageCommand09HL (script command $09); that string begins '0 peered into the barrel. A folded' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case08)
; no direct call (reached through a table, a jump or a vector)
TalkMsg080A_HeroPeeredIntoTheBarrelA::
Jump_004_5A35:: ; address name
    ld hl, $080A ; '0 peered into the barrel. A'
    call StartMessageCommand09HL_B04
    ret

; starts message $080B through StartMessageCommand09HL (script command $09); that string begins '0 peered into the barrel. It was' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case09)
; no direct call (reached through a table, a jump or a vector)
TalkMsg080B_HeroPeeredIntoTheBarrelIt::
Jump_004_5A3C:: ; address name
    ld hl, $080B ; '0 peered into the barrel. It'
    call StartMessageCommand09HL_B04
    ret

; a one-time barrel: script command $0A with wScriptParam0 = 2 (kind) and wScriptParam1 = $2C, story flag $0061 in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the flag (message $A6 of group 0; $A7 when the flag is already set, $A8 when there is no room) (E-0269; was DispatchTalkEvent_Case03_Sub01_Case0A)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
BarrelItem_TinyMedal::
Jump_004_5A43:: ; address name
    ld a, $02
    ld [wScriptParam0], a
    ld a, $2C
    ld [wScriptParam1], a
    ld de, $0061
    call StartTreasureFlagDE_B04
    ret

; a one-time barrel: script command $0A with wScriptParam0 = 2 (kind) and wScriptParam1 = $28, story flag $0062 in DE: when the flag is clear it gives item $28 (Warp) and sets the flag (message $A6 of group 0; $A7 when the flag is already set, $A8 when there is no room) (E-0269; was DispatchTalkEvent_Case03_Sub01_Case0B)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
BarrelItem_Warp::
Jump_004_5A54:: ; address name
    ld a, $02
    ld [wScriptParam0], a
    ld a, $28
    ld [wScriptParam1], a
    ld de, $0062
    call StartTreasureFlagDE_B04
    ret

; starts message $088A through StartMessageCommand09HL (script command $09); that string begins '0 peered into the vase. It was' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case0C)
; no direct call (reached through a table, a jump or a vector)
TalkMsg088A_HeroPeeredIntoTheVaseIt::
Jump_004_5A65:: ; address name
    ld hl, $088A ; '0 peered into the vase. It'
    call StartMessageCommand09HL_B04
    ret

; starts message $0889 through StartMessageCommand09HL (script command $09); that string begins '0 peered into the oven. It smelled' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case0D)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0889_HeroPeeredIntoTheOvenIt::
Jump_004_5A6C:: ; address name
    ld hl, $0889 ; '0 peered into the oven. It'
    call StartMessageCommand09HL_B04
    ret

; starts message $0037 through StartMessageCommand09HL (script command $09); that string begins '0 tried to open the chest. But' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case0E)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0037_HeroTriedToOpenTheChest::
Jump_004_5A73:: ; address name
    ld hl, $0037 ; '0 tried to open the chest.'
    call StartMessageCommand09HL_B04
    ret

; starts message $080C through StartMessageCommand09HL (script command $09); that string begins 'Welcome to Polona. It's a tourist resort' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case0F)
; no direct call (reached through a table, a jump or a vector)
TalkMsg080C_WelcomeToPolonaItsATourist::
Jump_004_5A7A:: ; address name
    ld hl, $080C ; 'Welcome to Polona. It's a tourist'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005F then jr c, Jump_004_5A90); starts message $080D through StartMessageCommand09HL (script command $09); that string begins 'You could meet mermaids here in the' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case10)
; no direct call (reached through a table, a jump or a vector)
TalkMsg080D_YouCouldMeetMermaidsHere::
Jump_004_5A81:: ; address name
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_5A90
    ld hl, $080D ; 'You could meet mermaids here in'
    call StartMessageCommand09HL_B04
    ret

Jump_004_5A90::
    ld hl, $0878 ; 'The mermaids came back.'
    call StartMessageCommand09HL_B04
    ret

; starts message $080E through StartMessageCommand09HL (script command $09); that string begins 'I'm from the port in the northeast.' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case11)
; no direct call (reached through a table, a jump or a vector)
TalkMsg080E_ImFromThePortInThe::
Jump_004_5A97:: ; address name
    ld hl, $080E ; 'I'm from the port in the'
    call StartMessageCommand09HL_B04
    ret

; starts message $080F through StartMessageCommand09HL (script command $09); that string begins 'You're not supposed to go near the' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case12)
; no direct call (reached through a table, a jump or a vector)
TalkMsg080F_YoureNotSupposedToGoNear::
Jump_004_5A9E:: ; address name
    ld hl, $080F ; 'You're not supposed to go near'
    call StartMessageCommand09HL_B04
    ret

; entry 19 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp1, wStepArrived, hTemp2
; writes: rRAMG
; points at: wPartyList, wNameGlyphBuf
DispatchTalkEvent_Case03_Sub01_Case13::
Jump_004_5AA5:: ; address name
    ld de, $006F
    call TestFlagBit
    jr c, Jump_004_5B16
    farcall FindPartyMemberWithSkill76To7DOr92
    ldh a, [hTemp1]
    bit 7, a
    jr z, Jump_004_5AC0
    ld hl, Script_5C2F
    call StartScriptAtHL_B04
    ret

Jump_004_5AC0::
    farcall SetWStepArrivedIfPartyHasField55Bit7
    ld a, [wStepArrived]
    or a, a
    jr z, Jump_004_5AD3
    ld hl, Script_5C5C
    call StartScriptAtHL_B04
    ret

Jump_004_5AD3::
    ld a, $0A
    ld [rRAMG], a
    ldh a, [hTemp1]
    ld hl, wPartyList
    add_a_to_hl
    ld a, [hl]
    ld c, $01
    call CopyRecordNameToNameGlyphBuf
    xor a, a
    ld [rRAMG], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf1 + $7
    ld bc, $000B
    call CopyBytes
    ldh a, [hTemp2]
    ld de, wTextBuf2 + $2
    call ReadBank08Table4558WordForA
    ld de, $006D
    call TestFlagBit
    jr c, Jump_004_5B0F
    ld hl, Script_5C40
    call StartScriptAtHL_B04
    ret

Jump_004_5B0F::
    ld hl, Script_5C4E
    call StartScriptAtHL_B04
    ret

Jump_004_5B16::
    ld hl, $084A ; 'I'm astonished. Mermaids exist.'
    call StartMessageCommand09HL_B04
    ret

; entry 20 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
; starts Script_5B94: 'Welcome to our inn!'
DispatchTalkEvent_Case03_Sub01_Case14::
Jump_004_5B1D:: ; address name
    ld hl, Script_5B94
    call StartScriptAtHL_B04
    ld a, $10
    ld [wDataBank], a
    ret

; starts Script_5B9B (StartScriptAtHL); its first message begins 'Have you heard the legend about' (E-0271; was DispatchTalkEvent_Case03_Sub01_Case15)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5B9B: 'Have you heard the legend about'
TalkScript5B9B_HaveYouHeardTheLegendAbout::
Jump_004_5B29:: ; address name
    ld hl, Script_5B9B
    call StartScriptAtHL_B04
    ret

; starts message $081B through StartMessageCommand09HL (script command $09); that string begins 'Ahh This is heavenly! It makes me' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case16)
; no direct call (reached through a table, a jump or a vector)
TalkMsg081B_AhhThisIsHeavenlyItMakes::
Jump_004_5B30:: ; address name
    ld hl, $081B ; 'Ahh This is heavenly! It makes'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005F then jr c, Jump_004_5B46); starts message $081C through StartMessageCommand09HL (script command $09); that string begins 'I came from far away to see' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case17)
; no direct call (reached through a table, a jump or a vector)
TalkMsg081C_ICameFromFarAwayTo::
Jump_004_5B37:: ; address name
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_5B46
    ld hl, $081C ; 'I came from far away to'
    call StartMessageCommand09HL_B04
    ret

Jump_004_5B46::
    ld hl, $0879 ; 'I e seen mermaids too. I'
    call StartMessageCommand09HL_B04
    ret

; starts message $088B through StartMessageCommand09HL (script command $09); that string begins '0 read the sign. Welcome to the' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case18)
; no direct call (reached through a table, a jump or a vector)
TalkMsg088B_HeroReadTheSignWelcomeTo::
Jump_004_5B4D:: ; address name
    ld hl, $088B ; '0 read the sign. Welcome to'
    call StartMessageCommand09HL_B04
    ret

; starts message $0889 through StartMessageCommand09HL (script command $09); that string begins '0 peered into the oven. It smelled' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case19)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0889_HeroPeeredIntoTheOvenIt_045B54::
Jump_004_5B54:: ; address name
    ld hl, $0889 ; '0 peered into the oven. It'
    call StartMessageCommand09HL_B04
    ret

; starts message $081D through StartMessageCommand09HL (script command $09); that string begins 'This is Port Ritz, where ships gather' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case1A)
; no direct call (reached through a table, a jump or a vector)
TalkMsg081D_ThisIsPortRitzWhereShips::
Jump_004_5B5B:: ; address name
    ld hl, $081D ; 'This is Port Ritz, where ships'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 007A then jr c, Jump_004_5B71); starts message $081E through StartMessageCommand09HL (script command $09); that string begins 'The pirates were swallowed by the sea' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case1B)
; no direct call (reached through a table, a jump or a vector)
TalkMsg081E_ThePiratesWereSwallowedBy::
Jump_004_5B62:: ; address name
    ld de, $007A
    call TestFlagBit
    jr c, Jump_004_5B71
    ld hl, $081E ; 'The pirates were swallowed by the'
    call StartMessageCommand09HL_B04
    ret

Jump_004_5B71::
    ld hl, $087A ; 'The pirates hid their loot on'
    call StartMessageCommand09HL_B04
    ret

; starts message $081F through StartMessageCommand09HL (script command $09); that string begins 'There's this old sailor man in the' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case1C)
; no direct call (reached through a table, a jump or a vector)
TalkMsg081F_TheresThisOldSailorManIn::
Jump_004_5B78:: ; address name
    ld hl, $081F ; 'There's this old sailor man in'
    call StartMessageCommand09HL_B04
    ret

; sets wDataBank = $1F, then starts Script_5BA8 (StartScriptAtHL); its first message begins 'How may our church serve you?' (E-0271; was DispatchTalkEvent_Case03_Sub01_Case1D)
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
; starts Script_5BA8: 'How may our church serve you?'
TalkScript5BA8_HowMayOurChurchServeYou::
Jump_004_5B7F:: ; address name
    ld a, $1F
    ld [wDataBank], a
    ld hl, Script_5BA8
    call StartScriptAtHL_B04
    ret

; starts message $0821 through StartMessageCommand09HL (script command $09); that string begins 'All sorts of people come here from' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case1E)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0821_AllSortsOfPeopleComeHere::
Jump_004_5B8B:: ; address name
    ld hl, $0821 ; 'All sorts of people come here'
    call StartMessageCommand09HL_B04
    ret

; starts message $0822 through StartMessageCommand09HL (script command $09); that string begins 'I went to Polona a while back' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case1F)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0822_IWentToPolonaAWhile::
Jump_004_5B92:: ; address name
    ld hl, $0822 ; 'I went to Polona a while'
    call StartMessageCommand09HL_B04
    ret

; entry 32 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenTableIndex, wDataBank
DispatchTalkEvent_Case03_Sub01_Case20::
Jump_004_5B99:: ; address name
    ld a, $06
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_5BAF
    call StartScriptAtHL_B04
    ret

; tests story flags (flag 005F then jr c, Jump_004_5BB9); starts message $0824 through StartMessageCommand09HL (script command $09); that string begins 'There is a lighthouse to the east,' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case21)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0824_ThereIsALighthouseToThe::
Jump_004_5BAA:: ; address name
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_5BB9
    ld hl, $0824 ; 'There is a lighthouse to the'
    call StartMessageCommand09HL_B04
    ret

Jump_004_5BB9::
    ld hl, $0D13 ; 'The lighthouse is out east. Stay'
    call StartMessageCommand09HL_B04
    ret

; starts message $0825 through StartMessageCommand09HL (script command $09); that string begins 'My ship sank in the eastern sea.' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case22)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0825_MyShipSankInTheEastern::
Jump_004_5BC0:: ; address name
    ld hl, $0825 ; 'My ship sank in the eastern'
    call StartMessageCommand09HL_B04
    ret

; starts message $0826 through StartMessageCommand09HL (script command $09); that string begins 'The old man in the tavern's neat!' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case23)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0826_TheOldManInTheTaverns::
Jump_004_5BC7:: ; address name
    ld hl, $0826 ; 'The old man in the tavern's'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005F then jr c, Jump_004_5BDD); starts message $0827 through StartMessageCommand09HL (script command $09); that string begins 'This port used to be lively in' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case24)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0827_ThisPortUsedToBeLively::
Jump_004_5BCE:: ; address name
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_5BDD
    ld hl, $0827 ; 'This port used to be lively'
    call StartMessageCommand09HL_B04
    ret

Jump_004_5BDD::
    ld hl, $087B ; 'The sea around here is safe'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005F then jr c, Jump_004_5BF3); starts message $0829 through StartMessageCommand09HL (script command $09); that string begins 'The lighthouse had the MoonRock installed at' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case25)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0829_TheLighthouseHadTheMoonRock::
Jump_004_5BE4:: ; address name
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_5BF3
    ld hl, $0829 ; 'The lighthouse had the MoonRock installed'
    call StartMessageCommand09HL_B04
    ret

Jump_004_5BF3::
    ld hl, $087C ; 'The MoonRock glows at night from'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 007A then jr c, Jump_004_5C09); starts message $082A through StartMessageCommand09HL (script command $09); that string begins 'The sea's level has gone down. Many' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case26)
; no direct call (reached through a table, a jump or a vector)
TalkMsg082A_TheSeasLevelHasGoneDown::
Jump_004_5BFA:: ; address name
    ld de, $007A
    call TestFlagBit
    jr c, Jump_004_5C09
    ld hl, $082A ; 'The sea's level has gone down.'
    call StartMessageCommand09HL_B04
    ret

Jump_004_5C09::
    ld hl, $087D ; 'The sea's level has risen. No'
    call StartMessageCommand09HL_B04
    ret

; starts message $082B through StartMessageCommand09HL (script command $09); that string begins 'Listen, did you know? Mermaids appear to' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case27)
; no direct call (reached through a table, a jump or a vector)
TalkMsg082B_ListenDidYouKnowMermaids::
Jump_004_5C10:: ; address name
    ld hl, $082B ; 'Listen, did you know? Mermaids appear'
    call StartMessageCommand09HL_B04
    ret

; starts message $088D through StartMessageCommand09HL (script command $09); that string begins '0 peered into the oven. Two shiny' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case28)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5BB6: '0 tried to check the chest.'
TalkMsg088D_HeroPeeredIntoTheOvenTwo::
Jump_004_5C17:: ; address name
    ld hl, $088D ; '0 peered into the oven. Two'
    call StartMessageCommand09HL_B04
    ret

; starts Script_5BB6 (StartScriptAtHL); its first message begins '0 tried to check the chest.' (E-0271; was DispatchTalkEvent_Case03_Sub01_Case29)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5BB6: '0 tried to check the chest.'
TalkScript5BB6_HeroTriedToCheckTheChest::
Jump_004_5C1E:: ; address name
    ld hl, Script_5BB6
    call StartScriptAtHL_B04
    ret

; starts message $082E through StartMessageCommand09HL (script command $09); that string begins '0 peered into the barrel. It was' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case2A)
; no direct call (reached through a table, a jump or a vector)
TalkMsg082E_HeroPeeredIntoTheBarrelIt::
Jump_004_5C25:: ; address name
    ld hl, $082E ; '0 peered into the barrel. It'
    call StartMessageCommand09HL_B04
    ret

; a one-time barrel: script command $0A with wScriptParam0 = 2 (kind) and wScriptParam1 = $2C, story flag $0063 in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the flag (message $A6 of group 0; $A7 when the flag is already set, $A8 when there is no room) (E-0269; was DispatchTalkEvent_Case03_Sub01_Case2B)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
BarrelItem_TinyMedal_Flag0063::
Jump_004_5C2C:: ; address name
    ld a, $02
    ld [wScriptParam0], a
    ld a, $2C
    ld [wScriptParam1], a
    ld de, $0063
    call StartTreasureFlagDE_B04
    ret

; entry 44 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
; starts Script_5BBD: 'Welcome to our inn!'
DispatchTalkEvent_Case03_Sub01_Case2C::
Jump_004_5C3D:: ; address name
    ld hl, Script_5BBD
    call StartScriptAtHL_B04
    ld a, $10
    ld [wDataBank], a
    ret

; tests story flags (flag 007A then jr c, Jump_004_5C58); starts message $082F through StartMessageCommand09HL (script command $09); that string begins 'This area was a lot more lively' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case2D)
; no direct call (reached through a table, a jump or a vector)
TalkMsg082F_ThisAreaWasALotMore::
Jump_004_5C49:: ; address name
    ld de, $007A
    call TestFlagBit
    jr c, Jump_004_5C58
    ld hl, $082F ; 'This area was a lot more'
    call StartMessageCommand09HL_B04
    ret

Jump_004_5C58::
    ld hl, $087E ; 'For some reason, the shoals sank'
    call StartMessageCommand09HL_B04
    ret

; starts message $0830 through StartMessageCommand09HL (script command $09); that string begins 'When you're out at sea, you get' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case2E)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5BC4
TalkMsg0830_WhenYoureOutAtSeaYou::
Jump_004_5C5F:: ; address name
    ld hl, $0830 ; 'When you're out at sea, you'
    call StartMessageCommand09HL_B04
    ret

; starts Script_5BC4 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case03_Sub01_Case2F)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5BC4
TalkScript5BC4::
Jump_004_5C66:: ; address name
    ld hl, Script_5BC4
    call StartScriptAtHL_B04
    ret

; tests story flags (flag 005F then jr c, Jump_004_5C8B; flag 006D then jr c, Jump_004_5C84); starts message $0834 through StartMessageCommand09HL (script command $09); that string begins 'When that old man gets grogged You' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case30)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0834_WhenThatOldManGetsGrogged::
Jump_004_5C6D:: ; address name
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_5C8B
    ld de, $006D
    call TestFlagBit
    jr c, Jump_004_5C84
    ld hl, $0834 ; 'When that old man gets grogged'
    call StartMessageCommand09HL_B04
    ret

Jump_004_5C84::
    ld hl, $0842 ; 'I'm tired of the geezer's tales.'
    call StartMessageCommand09HL_B04
    ret

Jump_004_5C8B::
    ld hl, $0D14 ; 'Another master was here with two'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005F then jr c, Jump_004_5CB0; flag 007A then jr c, Jump_004_5CA9); starts message $0835 through StartMessageCommand09HL (script command $09); that string begins 'The old fellow there, the instant he' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case31)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0835_TheOldFellowThereTheInstant::
Jump_004_5C92:: ; address name
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_5CB0
    ld de, $007A
    call TestFlagBit
    jr c, Jump_004_5CA9
    ld hl, $0835 ; 'The old fellow there, the instant'
    call StartMessageCommand09HL_B04
    ret

Jump_004_5CA9::
    ld hl, $0DC3 ; 'The shoals that ringed the volcano'
    call StartMessageCommand09HL_B04
    ret

Jump_004_5CB0::
    ld hl, $087F ; 'Did you hear? Pirates hid their'
    call StartMessageCommand09HL_B04
    ret

; starts message $0836 through StartMessageCommand09HL (script command $09); that string begins 'The volcanic island off the coast is' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case32)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0836_TheVolcanicIslandOffTheCoast::
Jump_004_5CB7:: ; address name
    ld hl, $0836 ; 'The volcanic island off the coast'
    call StartMessageCommand09HL_B04
    ret

; entry 51 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wObject3
DispatchTalkEvent_Case03_Sub01_Case33::
Jump_004_5CBE:: ; address name
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_5D0D
    ld de, $007A
    call TestFlagBit
    jr c, Jump_004_5CF5
    ld de, $006D
    call TestFlagBit
    jr c, Jump_004_5CEE
    call PartyHasSpeciesLo3CTo5BWithHiSet
    jr c, Jump_004_5CE7
    ld a, $01
    ld [wObject3 + $7], a
    ld hl, $0837 ; 'Hnnnr Hic Gnn Zzz Gfffff'
    call StartMessageCommand09HL_B04
    ret

Jump_004_5CE7::
    ld hl, Script_5BFE
    call StartScriptAtHL_B04
    ret

Jump_004_5CEE::
    ld hl, Script_5C19
    call StartScriptAtHL_B04
    ret

Jump_004_5CF5::
    call PartyHasSpeciesLo3CTo5BWithHiSet
    jr c, Jump_004_5D06
    ld a, $01
    ld [wObject3 + $7], a
    ld hl, $0837 ; 'Hnnnr Hic Gnn Zzz Gfffff'
    call StartMessageCommand09HL_B04
    ret

Jump_004_5D06::
    ld hl, Script_5C26
    call StartScriptAtHL_B04
    ret

Jump_004_5D0D::
    ld hl, $0880 ; 'What? You again? Back to hear'
    call StartMessageCommand09HL_B04
    ret

; carry when a party record has a species word with a non-zero high byte and low byte $3C-$5B (E-0124)
; 2 call sites from 1 routine (e.g. DispatchTalkEvent_Case03_Sub01_Case33)
; reads: wPartyCount, hTemp1, hTemp0
; writes: rRAMG
; points at: wPartyList
PartyHasSpeciesLo3CTo5BWithHiSet::
Func_004_5D14:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList

Jump_004_5D20::
    ld a, [hl+]
    ld c, $0B
    call LoadSRAMRecordWord
    ldh a, [hTemp1]
    or a, a
    jr z, Jump_004_5D35
    ldh a, [hTemp0]
    cp a, $3C
    jr c, Jump_004_5D35
    cp a, $5C
    jr c, Jump_004_5D3E

Jump_004_5D35::
    dec b
    jr nz, Jump_004_5D20
    xor a, a
    ld [rRAMG], a
    sub a, a
    ret

Jump_004_5D3E::
    xor a, a
    ld [rRAMG], a
    scf
    ret

; entry 52 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case03_Sub01_Case34::
Jump_004_5D44:: ; address name
    ld de, $0066
    call TestFlagBit
    jr c, Jump_004_5D68
    ld de, $0065
    call TestFlagBit
    jr c, Jump_004_5D61
    ld hl, Script_5BE8
    call StartScriptAtHL_B04
    ld de, $0065
    call SetFlagBit
    ret

Jump_004_5D61::
    ld hl, Script_5BF2
    call StartScriptAtHL_B04
    ret

Jump_004_5D68::
    ld hl, Script_5BFC
    call StartScriptAtHL_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $1B, story flag $0067 in DE: when the flag is clear it gives item $1B (Rib) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was DispatchTalkEvent_Case03_Sub01_Case35)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_Rib::
Jump_004_5D6F:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $1B
    ld [wScriptParam1], a
    ld de, $0067
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $02, story flag $0068 in DE: when the flag is clear it gives item $02 (LoveWater) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was DispatchTalkEvent_Case03_Sub01_Case36)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_LoveWater::
Jump_004_5D80:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $02
    ld [wScriptParam1], a
    ld de, $0068
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $02, story flag $0069 in DE: when the flag is clear it gives item $02 (LoveWater) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was DispatchTalkEvent_Case03_Sub01_Case37)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_LoveWater_Flag0069::
Jump_004_5D91:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $02
    ld [wScriptParam1], a
    ld de, $0069
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $2A, story flag $006A in DE: when the flag is clear it gives item $2A (ExitBell) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was DispatchTalkEvent_Case03_Sub01_Case38)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_ExitBell::
Jump_004_5DA2:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2A
    ld [wScriptParam1], a
    ld de, $006A
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $46, story flag $006B in DE: when the flag is clear it gives item $46 (MermScale) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was DispatchTalkEvent_Case03_Sub01_Case39)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_MermScale::
Jump_004_5DB3:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $46
    ld [wScriptParam1], a
    ld de, $006B
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $28, story flag $006C in DE: when the flag is clear it gives item $28 (Warp) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was DispatchTalkEvent_Case03_Sub01_Case3A)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_Warp::
Jump_004_5DC4:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $28
    ld [wScriptParam1], a
    ld de, $006C
    call StartTreasureFlagDE_B04
    ret

; starts message $0843 through StartMessageCommand09HL (script command $09); that string begins 'I saw a child cross the sea' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case3B)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0843_ISawAChildCrossThe::
Jump_004_5DD5:: ; address name
    ld hl, $0843 ; 'I saw a child cross the'
    call StartMessageCommand09HL_B04
    ret

; starts message $0844 through StartMessageCommand09HL (script command $09); that string begins 'Watch me dance, and you'll want to' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case3C)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0844_WatchMeDanceAndYoullWant::
Jump_004_5DDC:: ; address name
    ld hl, $0844 ; 'Watch me dance, and you'll want'
    call StartMessageCommand09HL_B04
    ret

; entry 61 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; starts Script_5C69: 'Do you want to go to'
DispatchTalkEvent_Case03_Sub01_Case3D::
Jump_004_5DE3:: ; address name
    ld de, $006F
    call TestFlagBit
    ret nc
    ld hl, Script_5C69
    call StartScriptAtHL_B04
    ret

; entry 62 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case03_Sub01_Case3E::
Jump_004_5DF1:: ; address name
    ld de, $00F1
    call TestFlagBit
    jr c, Jump_004_5E06
    ld hl, $084E ; 'This is the mermaid kingdom. It'
    call StartMessageCommand09HL_B04
    ld de, $00F1
    call SetFlagBit
    ret

Jump_004_5E06::
    ld hl, Script_5D36
    call StartScriptAtHL_B04
    ret

; tests story flags (flag 0076 then jr c, Jump_004_5E1C); starts message $084F through StartMessageCommand09HL (script command $09); that string begins 'I know not all humans are bad' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case3F)
; no direct call (reached through a table, a jump or a vector)
TalkMsg084F_IKnowNotAllHumansAre::
Jump_004_5E0D:: ; address name
    ld de, $0076
    call TestFlagBit
    jr c, Jump_004_5E1C
    ld hl, $084F ; 'I know not all humans are'
    call StartMessageCommand09HL_B04
    ret

Jump_004_5E1C::
    ld hl, $0881 ; 'Our words of thanks could never'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0076 then jr c, Jump_004_5E32); starts message $0850 through StartMessageCommand09HL (script command $09); that string begins 'The pirates caught us in nets and' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case40)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0850_ThePiratesCaughtUsInNets::
Jump_004_5E23:: ; address name
    ld de, $0076
    call TestFlagBit
    jr c, Jump_004_5E32
    ld hl, $0850 ; 'The pirates caught us in nets'
    call StartMessageCommand09HL_B04
    ret

Jump_004_5E32::
    ld hl, $0882 ; 'Mermaids and humans can live side'
    call StartMessageCommand09HL_B04
    ret

; starts message $0851 through StartMessageCommand09HL (script command $09); that string begins 'The HarMirror was exquisite. It was so' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case41)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0851_TheHarMirrorWasExquisite::
Jump_004_5E39:: ; address name
    ld hl, $0851 ; 'The HarMirror was exquisite. It was'
    call StartMessageCommand09HL_B04
    ret

; starts message $0852 through StartMessageCommand09HL (script command $09); that string begins 'The MoonRock fell from the sky. It' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case42)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0852_TheMoonRockFellFromTheSky::
Jump_004_5E40:: ; address name
    ld hl, $0852 ; 'The MoonRock fell from the sky.'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0076 then jr c, Jump_004_5E56); starts message $0853 through StartMessageCommand09HL (script command $09); that string begins 'The pirates sank with their ship. However,' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case43)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0853_ThePiratesSankWithTheirShip::
Jump_004_5E47:: ; address name
    ld de, $0076
    call TestFlagBit
    jr c, Jump_004_5E56
    ld hl, $0853 ; 'The pirates sank with their ship.'
    call StartMessageCommand09HL_B04
    ret

Jump_004_5E56::
    ld hl, $0883 ; 'Thanks to you, the spectral ship'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0076 then jr c, Jump_004_5E6C); starts message $0854 through StartMessageCommand09HL (script command $09); that string begins 'We mermaids are peaceful beings. We shy' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case44)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0854_WeMermaidsArePeacefulBeings::
Jump_004_5E5D:: ; address name
    ld de, $0076
    call TestFlagBit
    jr c, Jump_004_5E6C
    ld hl, $0854 ; 'We mermaids are peaceful beings. We'
    call StartMessageCommand09HL_B04
    ret

Jump_004_5E6C::
    ld hl, $0884 ; 'That wandering ghost ship's gone! My'
    call StartMessageCommand09HL_B04
    ret

; entry 69 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; reads: wGameFlags836
; writes: wGameFlags836
DispatchTalkEvent_Case03_Sub01_Case45::
Jump_004_5E73:: ; address name
    ld de, $005E
    call TestFlagBit
    jr c, Jump_004_5EB6
    ld de, $0076
    call TestFlagBit
    jr c, Jump_004_5E99
    ld de, $0070
    call TestFlagBit
    jr c, Jump_004_5E92
    ld hl, Script_5C77
    call StartScriptAtHL_B04
    ret

Jump_004_5E92::
    ld hl, $0858 ; 'The MoonRock is on the ghost'
    call StartMessageCommand09HL_B04
    ret

Jump_004_5E99::
    call InventoryHasFreeSlotCheck
    jr c, Jump_004_5EA5
    ld hl, $0DC7 ; 'Welcome, my young hero! No words'
    call StartMessageCommand09HL_B04
    ret

Jump_004_5EA5::
    ld [hl], $5F
    ld a, [wGameFlags836]
    set 6, a
    ld [wGameFlags836], a
    ld hl, Script_5C7E
    call StartScriptAtHL_B04
    ret

Jump_004_5EB6::
    ld hl, $0885 ; 'Welcome, young hero! No words could'
    call StartMessageCommand09HL_B04
    ret

; starts Script_5C88 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case03_Sub01_Case46)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5C88
TalkScript5C88::
Jump_004_5EBD:: ; address name
    ld hl, Script_5C88
    call StartScriptAtHL_B04
    ret

; starts Script_5C8A (StartScriptAtHL); its first message begins 'How could we die before enjoying' (E-0271; was DispatchTalkEvent_Case03_Sub01_Case47)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5C8A: 'How could we die before enjoying'
TalkScript5C8A_HowCouldWeDieBeforeEnjoying::
Jump_004_5EC4:: ; address name
    ld hl, Script_5C8A
    call StartScriptAtHL_B04
    ret

; starts Script_5C94 (StartScriptAtHL); its first message begins 'The treasures are ours No one' (E-0271; was DispatchTalkEvent_Case03_Sub01_Case48)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5C94: 'The treasures are ours No one'
TalkScript5C94_TheTreasuresAreOursNoOne::
Jump_004_5ECB:: ; address name
    ld hl, Script_5C94
    call StartScriptAtHL_B04
    ret

; starts Script_5C9E (StartScriptAtHL); its first message begins 'It nags and nags that we' (E-0271; was DispatchTalkEvent_Case03_Sub01_Case49)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5C9E: 'It nags and nags that we'
TalkScript5C9E_ItNagsAndNagsThatWe::
Jump_004_5ED2:: ; address name
    ld hl, Script_5C9E
    call StartScriptAtHL_B04
    ret

; entry 74 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; starts Script_5CA8: 'Who disturbs us in our sleep'
DispatchTalkEvent_Case03_Sub01_Case4A::
Jump_004_5ED9:: ; address name
    ld de, $0074
    call TestFlagBit
    jr c, Jump_004_5EEE
    ld hl, Script_5CA8
    call StartScriptAtHL_B04
    ld de, $0074
    call SetFlagBit
    ret

Jump_004_5EEE::
    ld hl, Script_5CB5
    call StartScriptAtHL_B04
    ret

; entry 75 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; reads: wGameFlags836
; writes: wGameFlags836
DispatchTalkEvent_Case03_Sub01_Case4B::
Jump_004_5EF5:: ; address name
    call InventoryHasFreeSlotCheck
    jr c, Jump_004_5F01
    ld hl, $0888 ; '0 checked the treasure chest. There'
    call StartMessageCommand09HL_B04
    ret

Jump_004_5F01::
    ld [hl], $31
    ld a, [wGameFlags836]
    set 6, a
    ld [wGameFlags836], a
    ld hl, Script_5CC2
    call StartScriptAtHL_B04
    ret

; entry 76 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; starts Script_5CCA: '0 checked the crate. There was'
DispatchTalkEvent_Case03_Sub01_Case4C::
Jump_004_5F12:: ; address name
    ld hl, Script_5CCA
    call StartScriptAtHL_B04
    ld de, $0077
    call SetFlagBit
    ret

; entry 77 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlots
DispatchTalkEvent_Case03_Sub01_Case4D::
Jump_004_5F1F:: ; address name
    xor a, a
    ld [wSpriteSlots + $7], a
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $2E, story flag $0079 in DE: when the flag is clear it gives item $2E (LogTwig) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was DispatchTalkEvent_Case03_Sub01_Case4E)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_LogTwig::
Jump_004_5F24:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2E
    ld [wScriptParam1], a
    ld de, $0079
    call StartTreasureFlagDE_B04
    ret

; entry 79 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp0
DispatchTalkEvent_Case03_Sub01_Case4F::
Jump_004_5F35:: ; address name
    ld de, $007A
    call TestFlagBit
    jr c, Jump_004_5F53
    ld a, $31
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    ret z
    ld hl, $0865 ; '0 checked the pedestal. It has'
    call StartMessageCommand09HL_B04
    ret

Jump_004_5F53::
    ld hl, $0867 ; '0 checked the pedestal. The MoonRock'
    call StartMessageCommand09HL_B04
    ret

; entry 80 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, hPlayerX
; writes: wSpriteSlots, wObject1, wObject2
DispatchTalkEvent_Case03_Sub01_Case50::
Jump_004_5F5A:: ; address name
    ldh a, [hPlayerY]
    cp a, $30
    ret nz
    ld de, $007B
    call SetFlagBit
    ld hl, Script_5CD1
    call StartScriptAtHL_B04
    ldh a, [hPlayerX]
    cp a, $50
    ret nz
    ld a, $40
    ld [wSpriteSlots + $B], a
    ld [wObject1 + $B], a
    ld [wObject2 + $B], a
    ret

; starts Script_5CDD (StartScriptAtHL); its first message begins 'Kameha Urk! How you catch up?' (E-0271; was DispatchTalkEvent_Case03_Sub01_Case51)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5CDD: 'Kameha Urk! How you catch up?'
TalkScript5CDD_KamehaUrkHowYouCatchUp::
Jump_004_5F7C:: ; address name
    ld hl, Script_5CDD
    call StartScriptAtHL_B04
    ret

; starts Script_5D1C (StartScriptAtHL); its first message begins 'Kameha Arrrrh, clear the way! I'm' (E-0271; was DispatchTalkEvent_Case03_Sub01_Case52)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5D1C: 'Kameha Arrrrh, clear the way! I'm'
TalkScript5D1C_KamehaArrrrhClearTheWayIm::
Jump_004_5F83:: ; address name
    ld hl, Script_5D1C
    call StartScriptAtHL_B04
    ret

; starts Script_5D2F (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case03_Sub01_Case53)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5D2F
TalkScript5D2F::
Jump_004_5F8A:: ; address name
    ld hl, Script_5D2F
    call StartScriptAtHL_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $20, story flag $00E0 in DE: when the flag is clear it gives item $20 (Repellent) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was DispatchTalkEvent_Case03_Sub01_Case54)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_Repellent::
Jump_004_5F91:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $20
    ld [wScriptParam1], a
    ld de, $00E0
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $28, story flag $00E1 in DE: when the flag is clear it gives item $28 (Warp) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was DispatchTalkEvent_Case03_Sub01_Case55)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_Warp_Flag00E1::
Jump_004_5FA2:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $28
    ld [wScriptParam1], a
    ld de, $00E1
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $0C, story flag $00E2 in DE: when the flag is clear it gives item $0C (WorldLeaf) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was DispatchTalkEvent_Case03_Sub01_Case56)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_WorldLeaf::
Jump_004_5FB3:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $0C
    ld [wScriptParam1], a
    ld de, $00E2
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $11, story flag $00E3 in DE: when the flag is clear it gives item $11 (LifeAcorn) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was DispatchTalkEvent_Case03_Sub01_Case57)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_LifeAcorn::
Jump_004_5FC4:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $11
    ld [wScriptParam1], a
    ld de, $00E3
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $0E, story flag $00E4 in DE: when the flag is clear it gives item $0E (DEFseed) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was DispatchTalkEvent_Case03_Sub01_Case58)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_DEFseed::
Jump_004_5FD5:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $0E
    ld [wScriptParam1], a
    ld de, $00E4
    call StartTreasureFlagDE_B04
    ret

; starts message $088C through StartMessageCommand09HL (script command $09); that string begins '0 peered into the vase. There were' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case59)
; no direct call (reached through a table, a jump or a vector)
TalkMsg088C_HeroPeeredIntoTheVaseThere::
Jump_004_5FE6:: ; address name
    ld hl, $088C ; '0 peered into the vase. There'
    call StartMessageCommand09HL_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $03, story flag $00E5 in DE: when the flag is clear it gives item $03 (WorldDew) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was DispatchTalkEvent_Case03_Sub01_Case5A)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_WorldDew::
Jump_004_5FED:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $03
    ld [wScriptParam1], a
    ld de, $00E5
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $5C, story flag $00E6 in DE: when the flag is clear it gives item $5C (War) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was DispatchTalkEvent_Case03_Sub01_Case5B)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_War::
Jump_004_5FFE:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5C
    ld [wScriptParam1], a
    ld de, $00E6
    call StartTreasureFlagDE_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $06, story flag $00E7 in DE: when the flag is clear it gives item $06 (Antidote) and sets the flag (message $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was DispatchTalkEvent_Case03_Sub01_Case5C)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
VaseItem_Antidote::
Jump_004_600F:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $06
    ld [wScriptParam1], a
    ld de, $00E7
    call StartTreasureFlagDE_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $02, story flag $00E8 in DE: when the flag is clear it gives item $02 (LoveWater) and sets the flag (message $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was DispatchTalkEvent_Case03_Sub01_Case5D)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
VaseItem_LoveWater::
Jump_004_6020:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $02
    ld [wScriptParam1], a
    ld de, $00E8
    call StartTreasureFlagDE_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $28, story flag $00F2 in DE: when the flag is clear it gives item $28 (Warp) and sets the flag (message $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was DispatchTalkEvent_Case03_Sub01_Case5E)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
VaseItem_Warp::
Jump_004_6031:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $28
    ld [wScriptParam1], a
    ld de, $00F2
    call StartTreasureFlagDE_B04
    ret

; starts message $0861 through StartMessageCommand09HL (script command $09); that string begins '0 peered into the barrel. A mummified' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case5F)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0861_HeroPeeredIntoTheBarrelA::
Jump_004_6042:: ; address name
    ld hl, $0861 ; '0 peered into the barrel. A'
    call StartMessageCommand09HL_B04
    ret

; a one-time barrel: script command $0A with wScriptParam0 = 2 (kind) and wScriptParam1 = $1D, story flag $00E9 in DE: when the flag is clear it gives item $1D (BadMeat) and sets the flag (message $A6 of group 0; $A7 when the flag is already set, $A8 when there is no room) (E-0269; was DispatchTalkEvent_Case03_Sub01_Case60)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
BarrelItem_BadMeat::
Jump_004_6049:: ; address name
    ld a, $02
    ld [wScriptParam0], a
    ld a, $1D
    ld [wScriptParam1], a
    ld de, $00E9
    call StartTreasureFlagDE_B04
    ret

; a one-time barrel: script command $0A with wScriptParam0 = 2 (kind) and wScriptParam1 = $1A, story flag $00EA in DE: when the flag is clear it gives item $1A (PorkChop) and sets the flag (message $A6 of group 0; $A7 when the flag is already set, $A8 when there is no room) (E-0269; was DispatchTalkEvent_Case03_Sub01_Case61)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
BarrelItem_PorkChop::
Jump_004_605A:: ; address name
    ld a, $02
    ld [wScriptParam0], a
    ld a, $1A
    ld [wScriptParam1], a
    ld de, $00EA
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $51, story flag $00EB in DE: when the flag is clear it gives item $51 (OrcaCape) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was DispatchTalkEvent_Case03_Sub01_Case62)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_OrcaCape::
Jump_004_606B:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $51
    ld [wScriptParam1], a
    ld de, $00EB
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $20, story flag $00EC in DE: when the flag is clear it gives item $20 (Repellent) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was DispatchTalkEvent_Case03_Sub01_Case63)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_Repellent_Flag00EC::
Jump_004_607C:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $20
    ld [wScriptParam1], a
    ld de, $00EC
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $0C, story flag $00ED in DE: when the flag is clear it gives item $0C (WorldLeaf) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was DispatchTalkEvent_Case03_Sub01_Case64)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_WorldLeaf_Flag00ED::
Jump_004_608D:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $0C
    ld [wScriptParam1], a
    ld de, $00ED
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $0F, story flag $00EE in DE: when the flag is clear it gives item $0F (AGLseed) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was DispatchTalkEvent_Case03_Sub01_Case65)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_AGLseed::
Jump_004_609E:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $0F
    ld [wScriptParam1], a
    ld de, $00EE
    call StartTreasureFlagDE_B04
    ret

; a one-time barrel: script command $0A with wScriptParam0 = 2 (kind) and wScriptParam1 = $04, story flag $00EF in DE: when the flag is clear it gives item $04 (Potion) and sets the flag (message $A6 of group 0; $A7 when the flag is already set, $A8 when there is no room) (E-0269; was DispatchTalkEvent_Case03_Sub01_Case66)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
BarrelItem_Potion::
Jump_004_60AF:: ; address name
    ld a, $02
    ld [wScriptParam0], a
    ld a, $04
    ld [wScriptParam1], a
    ld de, $00EF
    call StartTreasureFlagDE_B04
    ret

; a one-time barrel: script command $0A with wScriptParam0 = 2 (kind) and wScriptParam1 = $10, story flag $00F0 in DE: when the flag is clear it gives item $10 (INTseed) and sets the flag (message $A6 of group 0; $A7 when the flag is already set, $A8 when there is no room) (E-0269; was DispatchTalkEvent_Case03_Sub01_Case67)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
BarrelItem_INTseed::
Jump_004_60C0:: ; address name
    ld a, $02
    ld [wScriptParam0], a
    ld a, $10
    ld [wScriptParam1], a
    ld de, $00F0
    call StartTreasureFlagDE_B04
    ret

; starts message $0862 through StartMessageCommand09HL (script command $09); that string begins '0 peered into the barrel. There were' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case68)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0862_HeroPeeredIntoTheBarrelThere::
Jump_004_60D1:: ; address name
    ld hl, $0862 ; '0 peered into the barrel. There'
    call StartMessageCommand09HL_B04
    ret

; starts message $0864 through StartMessageCommand09HL (script command $09); that string begins '0 checked the ledger. Voyage Log Sunrise' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case69)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5CCF
TalkMsg0864_HeroCheckedTheLedgerVoyage::
Jump_004_60D8:: ; address name
    ld hl, $0864 ; '0 checked the ledger. Voyage Log'
    call StartMessageCommand09HL_B04
    ret

; entry 106 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
; starts Script_5CCF
DispatchTalkEvent_Case03_Sub01_Case6A::
Jump_004_60DF:: ; address name
    ld hl, Script_5CCF
    call StartScriptAtHL_B04
    ld a, $31
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    farcall RemoveInventorySlotShiftDown
    ld de, $007A
    call SetFlagBit
    ret

; starts message $00FF through StartMessageCommand09HL (script command $09); that string begins 'Composing' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case6B)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5D44: 'Thick, suction- cupped tentacles snaked out'
TalkMsg00FF_Composing::
Jump_004_60FC:: ; address name
    ld hl, $00FF ; 'Composing'
    call StartMessageCommand09HL_B04
    ret

; starts Script_5D44 (StartScriptAtHL); its first message begins 'Thick, suction- cupped tentacles snaked out' (E-0271; was DispatchTalkEvent_Case03_Sub01_Case6C)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5D44: 'Thick, suction- cupped tentacles snaked out'
TalkScript5D44_ThickSuctionCuppedTentacles::
Jump_004_6103:: ; address name
    ld hl, Script_5D44
    call StartScriptAtHL_B04
    ret

; entry 109 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
DispatchTalkEvent_Case03_Sub01_Case6D::
Jump_004_610A:: ; address name
    ld a, $1F
    ld [wDataBank], a
    ld de, $0202
    call TestFlagBit
    jr c, Jump_004_6124
    ld hl, Script_5D4D
    call StartScriptAtHL_B04
    ld de, $0202
    call SetFlagBit
    ret

Jump_004_6124::
    ld hl, Script_5D54
    call StartScriptAtHL_B04
    ret

; only called from DispatchTalkEvent_Case02 (E-0047)
; 1 call site from 1 routine (e.g. DispatchTalkEvent_Case02)
; reads: wTalkEventGroup
DispatchTalkEvent_Case02_Sub01::
Func_004_612B:: ; address name
    ld a, [wTalkEventGroup]
    rst $00
    dw TalkMsg0130_ThisIsKalkaAnOasisVillage
    dw TalkMsg0131_AThievingBandRunsAmokHere
    dw TalkMsg0132_PardonAPlugForANavel
    dw TalkMsg0133_TheOasisWaterTravelsThrough
    dw TalkMsg0134_TheLeaderOfTheThievesIs
    dw TalkMsg0135_TheLogsNavelWhatIsThat
    dw TalkMsg0136_TheLogsNavelLetMeThink
    dw TalkMsg0137_HeroCheckedTheOvenASharp
    dw VaseItem_Herb
    dw TalkMsg0138_TheUndergroundCanalIsAhead
    dw DispatchTalkEvent_Case02_Sub01_Case0A
    dw TalkMsg0139_TheKingCalledACircusTroupe
    dw TalkMsg013A_ThisIsAsiyaTheDesertFlower
    dw TalkMsg013B_OurKingCameIntoAnEnormous
    dw TalkMsg013C_ISawALakeLikeA
    dw TalkMsg013D_StrongMonstersAreInTheWell
    dw TalkMsg013E_OurKingHasBeenAFan
    dw TalkMsg013F_TheCircusMasterWasTrying
    dw DispatchTalkEvent_Case02_Sub01_Case12
    dw TalkMsg0140_NoOneEntersTheCastleWithout
    dw TalkMsg0141_IfYouWantToGetIn
    dw TalkMsg0142_DidYouWantSomethingHoney
    dw TalkMsg0143_WhenWeGetAHotSpell
    dw DispatchTalkEvent_Case02_Sub01_Case17
    dw DispatchTalkEvent_Case02_Sub01_Case18
    dw TalkMsg014F_HeroPeeredIntoTheVaseIt
    dw VaseItem_Antidote_Flag0047
    dw TalkMsg0137_HeroCheckedTheOvenASharp_046456
    dw IfFlag056Msg018F_WeDidntHelpTheThievesOne
    dw TalkMsg01BE_HeroCheckedTheDresserThere
    dw TalkMsg0037_HeroTriedToOpenTheChest_046472
    dw DispatchTalkEvent_Case02_Sub01_Case1F
    dw TalkMsg0150_IHeardThatTheThievesDisappear
    dw TalkMsg0154_SeveralOfOurMembersCameBack
    dw TalkMsg0155_WhenTheThievesRaidedUsWe
    dw TalkMsg0156_IWonderIfTheOthersAre
    dw TalkMsg0157_HehDidYouSeeTheLooks
    dw TalkMsg0158_ThisIsTheKingsTreasuryNo
    dw TalkMsg0159_WhatSeeHisMajestysTreasure
    dw DispatchTalkEvent_Case02_Sub01_Case27
    dw TalkMsg015A_HisMajestyIsHonestAndMost
    dw DispatchTalkEvent_Case02_Sub01_Case29
    dw TalkMsg015F_HeroCheckedTheDresserThere
    dw DispatchTalkEvent_Case02_Sub01_Case2B
    dw TalkMsg0166_ThatFoolIsATerribleSwindler
    dw TalkMsg0167_HumphAMirageLakeHeSays
    dw DispatchTalkEvent_Case02_Sub01_Case2E
    dw VaseItem_Herb_Flag004B
    dw VaseItem_PorkChop
    dw VaseItem_TinyMedal
    dw VaseItem_Bookmark
    dw ChestItem_ExitBell_Flag004F
    dw ChestItem_Wind
    dw ChestItem_WarpWing
    dw ChestItem_AGL
    dw DispatchTalkEvent_Case02_Sub01_Case37
    dw DispatchTalkEvent_Case02_Sub01_Case38
    dw DispatchTalkEvent_Case02_Sub01_Case39
    dw TalkMsg0194_ThievesDroveUsFromOurHomes
    dw TalkMsg0195_TheLeaderOfTheThievesIs
    dw DispatchTalkEvent_Case02_Sub01_Case3C
    dw TalkMsg01B5_KyoohSwimmingInADesertThis
    dw TalkMsg01BC_HeroCheckedTheTreasureChest
    dw TalkMsg01BD_HeroPeeredIntoTheVaseIt
    dw TalkMsg01C0_HeroCheckedTheTreasureChest
    dw TalkMsg01BF_HeroPeeredIntoTheVaseThe
    dw VaseItem_BeefJerky
    dw DispatchTalkEvent_Case02_Sub01_Case43
    dw DispatchTalkEvent_Case02_Sub01_Case44
    dw DispatchTalkEvent_Case02_Sub01_Case45

; starts message $0130 through StartMessageCommand09HL (script command $09); that string begins 'This is Kalka, an oasis village.' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case00)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0130_ThisIsKalkaAnOasisVillage::
Jump_004_61BB:: ; address name
    ld hl, $0130 ; 'This is Kalka, an oasis village.'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c, Jump_004_61D1); starts message $0131 through StartMessageCommand09HL (script command $09); that string begins 'A thieving band runs amok here. It's' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case01)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0131_AThievingBandRunsAmokHere::
Jump_004_61C2:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_61D1
    ld hl, $0131 ; 'A thieving band runs amok here.'
    call StartMessageCommand09HL_B04
    ret

Jump_004_61D1::
    ld hl, $01A3 ; 'The King caught the thieves!'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c, Jump_004_61E7); starts message $0132 through StartMessageCommand09HL (script command $09); that string begins 'Pardon? A plug for a navel? Sorry,' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case02)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0132_PardonAPlugForANavel::
Jump_004_61D8:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_61E7
    ld hl, $0132 ; 'Pardon? A plug for a navel?'
    call StartMessageCommand09HL_B04
    ret

Jump_004_61E7::
    ld hl, $01A4 ; 'The last king was a great'
    call StartMessageCommand09HL_B04
    ret

; starts message $0133 through StartMessageCommand09HL (script command $09); that string begins 'The oasis water travels through an underground' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case03)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0133_TheOasisWaterTravelsThrough::
Jump_004_61EE:: ; address name
    ld hl, $0133 ; 'The oasis water travels through an'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c, Jump_004_6204); starts message $0134 through StartMessageCommand09HL (script command $09); that string begins 'The leader of the thieves is a' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case04)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0134_TheLeaderOfTheThievesIs::
Jump_004_61F5:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_6204
    ld hl, $0134 ; 'The leader of the thieves is'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6204::
    ld hl, $01A5 ; 'We recovered everything that was taken'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c, Jump_004_621A); starts message $0135 through StartMessageCommand09HL (script command $09); that string begins 'The Log's Navel? What is that? I' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case05)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0135_TheLogsNavelWhatIsThat::
Jump_004_620B:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_621A
    ld hl, $0135 ; 'The Log's Navel? What is that?'
    call StartMessageCommand09HL_B04
    ret

Jump_004_621A::
    ld hl, Script_5B64
    call StartScriptAtHL_B04
    ret

; tests story flags (flag 005A then jr c, Jump_004_6230); starts message $0136 through StartMessageCommand09HL (script command $09); that string begins 'The Log's Navel? Let me think Perhaps' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case06)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0136_TheLogsNavelLetMeThink::
Jump_004_6221:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_6230
    ld hl, $0136 ; 'The Log's Navel? Let me think'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6230::
    ld hl, $0D07 ; 'The shortage of water has been'
    call StartMessageCommand09HL_B04
    ret

; starts message $0137 through StartMessageCommand09HL (script command $09); that string begins '0 checked the oven. A sharp, spicy' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case07)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0137_HeroCheckedTheOvenASharp::
Jump_004_6237:: ; address name
    ld hl, $0137 ; '0 checked the oven. A sharp,'
    call StartMessageCommand09HL_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $01, story flag $0046 in DE: when the flag is clear it gives item $01 (Herb) and sets the flag (message $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was DispatchTalkEvent_Case02_Sub01_Case08)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
VaseItem_Herb::
Jump_004_623E:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $0046
    call StartTreasureFlagDE_B04
    ret

; tests story flags (flag 005A then jr c, Jump_004_627C; flag 0053 then jr c, Jump_004_6275; flag 004A then jr c, Jump_004_626E); starts message $0138 through StartMessageCommand09HL (script command $09); that string begins 'The underground canal is ahead. The last' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case09)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0138_TheUndergroundCanalIsAhead::
Jump_004_624F:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_627C
    ld de, $0053
    call TestFlagBit
    jr c, Jump_004_6275
    ld de, $004A
    call TestFlagBit
    jr c, Jump_004_626E
    ld hl, $0138 ; 'The underground canal is ahead. The'
    call StartMessageCommand09HL_B04
    ret

Jump_004_626E::
    ld hl, $0173 ; 'My, our King has no patience'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6275::
    ld hl, $017A ; 'Oh? You say that a monster'
    call StartMessageCommand09HL_B04
    ret

Jump_004_627C::
    ld hl, $0D08 ; 'Oh, it's you lot. We haven't'
    call StartMessageCommand09HL_B04
    ret

; entry 10 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX
; writes: wSpriteSlots, wDataBank
DispatchTalkEvent_Case02_Sub01_Case0A::
Jump_004_6283:: ; address name
    ldh a, [hPlayerX]
    cp a, $30
    jr nz, Jump_004_628E
    ld a, $02
    jp Jump_004_6290

Jump_004_628E::
    ld a, $01

Jump_004_6290::
    ld [wSpriteSlots + $7], a
    ld hl, Script_59BA
    call StartScriptAtHL_B04
    ld a, $10
    ld [wDataBank], a
    ret

; tests story flags (flag 005A then jr c, Jump_004_62AE); starts message $0139 through StartMessageCommand09HL (script command $09); that string begins 'The King called a circus troupe to' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case0B)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0139_TheKingCalledACircusTroupe::
Jump_004_629F:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_62AE
    ld hl, $0139 ; 'The King called a circus troupe'
    call StartMessageCommand09HL_B04
    ret

Jump_004_62AE::
    ld hl, $01A6 ; 'The circus has moved onto the'
    call StartMessageCommand09HL_B04
    ret

; starts message $013A through StartMessageCommand09HL (script command $09); that string begins 'This is Asiya, the desert flower.' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case0C)
; no direct call (reached through a table, a jump or a vector)
TalkMsg013A_ThisIsAsiyaTheDesertFlower::
Jump_004_62B5:: ; address name
    ld hl, $013A ; 'This is Asiya, the desert flower.'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c, Jump_004_62CB); starts message $013B through StartMessageCommand09HL (script command $09); that string begins 'Our King came into an enormous inheritance.' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case0D)
; no direct call (reached through a table, a jump or a vector)
TalkMsg013B_OurKingCameIntoAnEnormous::
Jump_004_62BC:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_62CB
    ld hl, $013B ; 'Our King came into an enormous'
    call StartMessageCommand09HL_B04
    ret

Jump_004_62CB::
    ld hl, $0D0B ; 'The King gave away his prized'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c, Jump_004_62E1); starts message $013C through StartMessageCommand09HL (script command $09); that string begins 'I saw a lake like a mirage.' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case0E)
; no direct call (reached through a table, a jump or a vector)
TalkMsg013C_ISawALakeLikeA::
Jump_004_62D2:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_62E1
    ld hl, $013C ; 'I saw a lake like a'
    call StartMessageCommand09HL_B04
    ret

Jump_004_62E1::
    ld hl, $0D0A ; 'The band of thieves made their'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c, Jump_004_632A; flag 0053 then jr c, Jump_004_6323; flag 0048 then jr c, Jump_004_631C; flag 0045 then jr c, Jump_004_630F); starts message $013D through StartMessageCommand09HL (script command $09); that string begins 'Strong monsters are in the well. You' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case0F)
; no direct call (reached through a table, a jump or a vector)
TalkMsg013D_StrongMonstersAreInTheWell::
Jump_004_62E8:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_632A
    ld de, $0053
    call TestFlagBit
    jr c, Jump_004_6323
    ld de, $0048
    call TestFlagBit
    jr c, Jump_004_631C
    ld de, $0045
    call TestFlagBit
    jr c, Jump_004_630F
    ld hl, $013D ; 'Strong monsters are in the well.'
    call StartMessageCommand09HL_B04
    ret

Jump_004_630F::
    ld hl, $0168 ; 'Do I have any concerns? You'll'
    call StartMessageCommand09HL_B04
    ld de, $0048
    call SetFlagBit
    ret

Jump_004_631C::
    ld hl, $0168 ; 'Do I have any concerns? You'll'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6323::
    ld hl, $017B ; 'The well has ample water again.'
    call StartMessageCommand09HL_B04
    ret

Jump_004_632A::
    ld hl, $0D09 ; 'The well filled up with water'
    call StartMessageCommand09HL_B04
    ret

; starts message $013E through StartMessageCommand09HL (script command $09); that string begins 'Our King has been a fan of' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case10)
; no direct call (reached through a table, a jump or a vector)
TalkMsg013E_OurKingHasBeenAFan::
Jump_004_6331:: ; address name
    ld hl, $013E ; 'Our King has been a fan'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c, Jump_004_6347); starts message $013F through StartMessageCommand09HL (script command $09); that string begins 'The circus master was trying to recruit' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case11)
; no direct call (reached through a table, a jump or a vector)
TalkMsg013F_TheCircusMasterWasTrying::
Jump_004_6338:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_6347
    ld hl, $013F ; 'The circus master was trying to'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6347::
    ld hl, $01A7 ; 'His Majesty's popularity has been growing'
    call StartMessageCommand09HL_B04
    ret

; entry 18 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenTableIndex, wDataBank
DispatchTalkEvent_Case02_Sub01_Case12::
Jump_004_634E:: ; address name
    ld a, $03
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld de, $0040
    call TestFlagBit
    jr c, Jump_004_636D
    ld hl, Script_59C1
    call StartScriptAtHL_B04
    ld de, $0040
    call SetFlagBit
    ret

Jump_004_636D::
    ld hl, Script_59C8
    call StartScriptAtHL_B04
    ret

; tests story flags (flag 0043 then jr c, Jump_004_6383); starts message $0140 through StartMessageCommand09HL (script command $09); that string begins 'No one enters the castle without a' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case13)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0140_NoOneEntersTheCastleWithout::
Jump_004_6374:: ; address name
    ld de, $0043
    call TestFlagBit
    jr c, Jump_004_6383
    ld hl, $0140 ; 'No one enters the castle without'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6383::
    ld hl, $016A ; 'The King has given permission for'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0053 then jr c, Jump_004_63A8; flag 0043 then jr c, Jump_004_63A1); starts message $0141 through StartMessageCommand09HL (script command $09); that string begins 'If you want to get in that' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case14)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0141_IfYouWantToGetIn::
Jump_004_638A:: ; address name
    ld de, $0053
    call TestFlagBit
    jr c, Jump_004_63A8
    ld de, $0043
    call TestFlagBit
    jr c, Jump_004_63A1
    ld hl, $0141 ; 'If you want to get in'
    call StartMessageCommand09HL_B04
    ret

Jump_004_63A1::
    ld hl, $016B ; 'The King is so frivolous. A'
    call StartMessageCommand09HL_B04
    ret

Jump_004_63A8::
    ld hl, $017C ; 'We have heard from his Majesty.'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0053 then jr c, Jump_004_63BE); starts message $0142 through StartMessageCommand09HL (script command $09); that string begins 'Did you want something, honey? A plug' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case15)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0142_DidYouWantSomethingHoney::
Jump_004_63AF:: ; address name
    ld de, $0053
    call TestFlagBit
    jr c, Jump_004_63BE
    ld hl, $0142 ; 'Did you want something, honey? A'
    call StartMessageCommand09HL_B04
    ret

Jump_004_63BE::
    ld hl, $017D ; 'Hi! Did you hear the news?'
    call StartMessageCommand09HL_B04
    ret

; starts message $0143 through StartMessageCommand09HL (script command $09); that string begins 'When we get a hot spell, I' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case16)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0143_WhenWeGetAHotSpell::
Jump_004_63C5:: ; address name
    ld hl, $0143 ; 'When we get a hot spell,'
    call StartMessageCommand09HL_B04
    ret

; entry 23 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
DispatchTalkEvent_Case02_Sub01_Case17::
Jump_004_63CC:: ; address name
    ld a, $1F
    ld [wDataBank], a
    ld de, $0041
    call TestFlagBit
    jr c, Jump_004_63E6
    ld hl, Script_59CF
    call StartScriptAtHL_B04
    ld de, $0041
    call SetFlagBit
    ret

Jump_004_63E6::
    ld hl, Script_59D6
    call StartScriptAtHL_B04
    ret

; entry 24 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount, wStepArrived
DispatchTalkEvent_Case02_Sub01_Case18::
Jump_004_63ED:: ; address name
    ld de, $0042
    call TestFlagBit
    jr c, Jump_004_641D
    ld a, [wPartyCount]
    cp a, $03
    jr nz, Jump_004_640F
    farcall SetWStepArrivedIfPartyHasField55Bit7
    ld a, [wStepArrived]
    or a, a
    jr nz, Jump_004_6416
    ld hl, Script_59DD
    call StartScriptAtHL_B04
    ret

Jump_004_640F::
    ld hl, Script_59F7
    call StartScriptAtHL_B04
    ret

Jump_004_6416::
    ld hl, Script_5A07
    call StartScriptAtHL_B04
    ret

Jump_004_641D::
    ld a, [wPartyCount]
    cp a, $03
    jr nz, Jump_004_6437
    farcall SetWStepArrivedIfPartyHasField55Bit7
    ld a, [wStepArrived]
    or a, a
    jr nz, Jump_004_6437
    ld hl, Script_5A17
    call StartScriptAtHL_B04
    ret

Jump_004_6437::
    ld hl, $014E ; 'Oh, you need a trio of'
    call StartMessageCommand09HL_B04
    ret

; starts message $014F through StartMessageCommand09HL (script command $09); that string begins '0 peered into the vase. It was' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case19)
; no direct call (reached through a table, a jump or a vector)
TalkMsg014F_HeroPeeredIntoTheVaseIt::
Jump_004_643E:: ; address name
    ld hl, $014F ; '0 peered into the vase. It'
    call StartMessageCommand09HL_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $06, story flag $0047 in DE: when the flag is clear it gives item $06 (Antidote) and sets the flag (message $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was DispatchTalkEvent_Case02_Sub01_Case1A)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
VaseItem_Antidote_Flag0047::
Jump_004_6445:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $06
    ld [wScriptParam1], a
    ld de, $0047
    call StartTreasureFlagDE_B04
    ret

; starts message $0137 through StartMessageCommand09HL (script command $09); that string begins '0 checked the oven. A sharp, spicy' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case1B)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0137_HeroCheckedTheOvenASharp_046456::
Jump_004_6456:: ; address name
    ld hl, $0137 ; '0 checked the oven. A sharp,'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0056 then ret nc); starts message $018F through StartMessageCommand09HL (script command $09); that string begins 'We didn't help the thieves! One of' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case1C)
; no direct call (reached through a table, a jump or a vector)
IfFlag056Msg018F_WeDidntHelpTheThievesOne::
Jump_004_645D:: ; address name
    ld de, $0056
    call TestFlagBit
    ret nc
    ld hl, $018F ; 'We didn't help the thieves! One'
    call StartMessageCommand09HL_B04
    ret

; starts message $01BE through StartMessageCommand09HL (script command $09); that string begins '0 checked the dresser. There was a' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case1D)
; no direct call (reached through a table, a jump or a vector)
TalkMsg01BE_HeroCheckedTheDresserThere::
Jump_004_646B:: ; address name
    ld hl, $01BE ; '0 checked the dresser. There was'
    call StartMessageCommand09HL_B04
    ret

; starts message $0037 through StartMessageCommand09HL (script command $09); that string begins '0 tried to open the chest. But' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case1E)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5A25: 'Welcome to our inn!'
TalkMsg0037_HeroTriedToOpenTheChest_046472::
Jump_004_6472:: ; address name
    ld hl, $0037 ; '0 tried to open the chest.'
    call StartMessageCommand09HL_B04
    ret

; entry 31 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
; starts Script_5A25: 'Welcome to our inn!'
DispatchTalkEvent_Case02_Sub01_Case1F::
Jump_004_6479:: ; address name
    ld hl, Script_5A25
    call StartScriptAtHL_B04
    ld a, $10
    ld [wDataBank], a
    ret

; tests story flags (flag 005A then jr c, Jump_004_6494); starts message $0150 through StartMessageCommand09HL (script command $09); that string begins 'I heard that the thieves disappear as' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case20)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0150_IHeardThatTheThievesDisappear::
Jump_004_6485:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_6494
    ld hl, $0150 ; 'I heard that the thieves disappear'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6494::
    ld hl, $01A8 ; 'Making a hideout in Mirage Lake'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c, Jump_004_64AA); starts message $0154 through StartMessageCommand09HL (script command $09); that string begins 'Several of our members came back. We' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case21)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0154_SeveralOfOurMembersCameBack::
Jump_004_649B:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_64AA
    ld hl, $0154 ; 'Several of our members came back.'
    call StartMessageCommand09HL_B04
    ret

Jump_004_64AA::
    ld hl, $01A9 ; 'They let us out when they'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c, Jump_004_64C0); starts message $0155 through StartMessageCommand09HL (script command $09); that string begins 'When the thieves raided us, we ran.' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case22)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0155_WhenTheThievesRaidedUsWe::
Jump_004_64B1:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_64C0
    ld hl, $0155 ; 'When the thieves raided us, we'
    call StartMessageCommand09HL_B04
    ret

Jump_004_64C0::
    ld hl, $01AA ; 'Come back and join the troupe!'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c, Jump_004_64D6); starts message $0156 through StartMessageCommand09HL (script command $09); that string begins 'I wonder if the others are safe' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case23)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0156_IWonderIfTheOthersAre::
Jump_004_64C7:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_64D6
    ld hl, $0156 ; 'I wonder if the others are'
    call StartMessageCommand09HL_B04
    ret

Jump_004_64D6::
    ld hl, $01AB ; 'The troupe'll reform! We'll recruit new'
    call StartMessageCommand09HL_B04
    ret

; starts message $0157 through StartMessageCommand09HL (script command $09); that string begins 'Heh, did you see the looks I' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case24)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0157_HehDidYouSeeTheLooks::
Jump_004_64DD:: ; address name
    ld hl, $0157 ; 'Heh, did you see the looks'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c, Jump_004_6502; flag 0056 then jr c, Jump_004_64FB); starts message $0158 through StartMessageCommand09HL (script command $09); that string begins 'This is the King's treasury! No one,' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case25)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0158_ThisIsTheKingsTreasuryNo::
Jump_004_64E4:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_6502
    ld de, $0056
    call TestFlagBit
    jr c, Jump_004_64FB
    ld hl, $0158 ; 'This is the King's treasury! No'
    call StartMessageCommand09HL_B04
    ret

Jump_004_64FB::
    ld hl, $0192 ; 'The prisoner in the dungeon said'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6502::
    ld hl, $01AC ; 'We're more vigilant now! No thieves'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c, Jump_004_6536; flag 0056 then jr c, Jump_004_652F; flag 0053 then jr c, Jump_004_6528); starts message $0159 through StartMessageCommand09HL (script command $09); that string begins 'What? See his Majesty's treasure? What foolishness!' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case26)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0159_WhatSeeHisMajestysTreasure::
Jump_004_6509:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_6536
    ld de, $0056
    call TestFlagBit
    jr c, Jump_004_652F
    ld de, $0053
    call TestFlagBit
    jr c, Jump_004_6528
    ld hl, $0159 ; 'What? See his Majesty's treasure? What'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6528::
    ld hl, $017E ; 'The King solved our water shortage'
    call StartMessageCommand09HL_B04
    ret

Jump_004_652F::
    ld hl, $0191 ; 'We can see the hideout plainly,'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6536::
    ld hl, $01AD ; 'I will do my best to'
    call StartMessageCommand09HL_B04
    ret

; entry 39 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case02_Sub01_Case27::
Jump_004_653D:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_655B
    ld de, $0053
    call TestFlagBit
    jr c, Jump_004_6554
    ld hl, Script_5B57
    call StartScriptAtHL_B04
    ret

Jump_004_6554::
    ld hl, $017F ; 'Our King worked to save all'
    call StartMessageCommand09HL_B04
    ret

Jump_004_655B::
    ld hl, $01AE ; 'Welcome, our honored guests! The King'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0053 then jr c, Jump_004_6580; flag 0049 then jr c, Jump_004_6579); starts message $015A through StartMessageCommand09HL (script command $09); that string begins 'His Majesty is honest and most certainly' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case28)
; no direct call (reached through a table, a jump or a vector)
TalkMsg015A_HisMajestyIsHonestAndMost::
Jump_004_6562:: ; address name
    ld de, $0053
    call TestFlagBit
    jr c, Jump_004_6580
    ld de, $0049
    call TestFlagBit
    jr c, Jump_004_6579
    ld hl, $015A ; 'His Majesty is honest and most'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6579::
    ld hl, $0170 ; 'I feel badly for his Majesty,'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6580::
    ld hl, $0180 ; 'The King appears to have turned'
    call StartMessageCommand09HL_B04
    ret

; entry 41 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags
; starts Script_5B71
DispatchTalkEvent_Case02_Sub01_Case29::
Jump_004_6587:: ; address name
    ld a, [wStoryFlags + $61]
    bit 3, a
    ret nz
    ld hl, Script_5B71
    call StartScriptAtHL_B04
    ret

; starts message $015F through StartMessageCommand09HL (script command $09); that string begins '0 checked the dresser. There were neatly' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case2A)
; no direct call (reached through a table, a jump or a vector)
TalkMsg015F_HeroCheckedTheDresserThere::
Jump_004_6594:: ; address name
    ld hl, $015F ; '0 checked the dresser. There were'
    call StartMessageCommand09HL_B04
    ret

; entry 43 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case02_Sub01_Case2B::
Jump_004_659B:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_6604
    ld de, $0056
    call TestFlagBit
    jr c, Jump_004_65FD
    ld de, $0054
    call TestFlagBit
    jr c, Jump_004_65F6
    ld de, $0049
    call TestFlagBit
    jr c, Jump_004_65EF
    ld de, $0048
    call TestFlagBit
    jr c, Jump_004_65E8
    ld de, $0045
    call TestFlagBit
    jr c, Jump_004_65E1
    ld de, $0044
    call TestFlagBit
    jr c, Jump_004_65DA
    ld hl, Script_5A2C
    call StartScriptAtHL_B04
    ret

Jump_004_65DA::
    ld hl, Script_5A4C
    call StartScriptAtHL_B04
    ret

Jump_004_65E1::
    ld hl, $0164 ; 'King Investigate what concerns my people'
    call StartMessageCommand09HL_B04
    ret

Jump_004_65E8::
    ld hl, Script_5A5C
    call StartScriptAtHL_B04
    ret

Jump_004_65EF::
    ld hl, $0174 ; 'I discovered why the water is'
    call StartMessageCommand09HL_B04
    ret

Jump_004_65F6::
    ld hl, Script_5AD6
    call StartScriptAtHL_B04
    ret

Jump_004_65FD::
    ld hl, $0190 ; 'King The lake was in sight,'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6604::
    ld hl, $01B0 ; 'King Ah, good of you to'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c, Jump_004_661A); starts message $0166 through StartMessageCommand09HL (script command $09); that string begins 'That fool is a terrible swindler. I' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case2C)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0166_ThatFoolIsATerribleSwindler::
Jump_004_660B:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_661A
    ld hl, $0166 ; 'That fool is a terrible swindler.'
    call StartMessageCommand09HL_B04
    ret

Jump_004_661A::
    ld hl, $01B1 ; 'The dungeon is full of thieves!'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0056 then jr c, Jump_004_6630); starts message $0167 through StartMessageCommand09HL (script command $09); that string begins 'Humph! A mirage lake, he says! No' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case2D)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0167_HumphAMirageLakeHeSays::
Jump_004_6621:: ; address name
    ld de, $0056
    call TestFlagBit
    jr c, Jump_004_6630
    ld hl, $0167 ; 'Humph! A mirage lake, he says!'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6630::
    ld hl, $0193 ; 'How can we reach the hideout?'
    call StartMessageCommand09HL_B04
    ret

; entry 46 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; starts Script_5A95: 'What? Open the Canal Gate more?'
DispatchTalkEvent_Case02_Sub01_Case2E::
Jump_004_6637:: ; address name
    ld de, $0049
    call TestFlagBit
    ret nc
    ld hl, Script_5A95
    call StartScriptAtHL_B04
    ld de, $004A
    call SetFlagBit
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $01, story flag $004B in DE: when the flag is clear it gives item $01 (Herb) and sets the flag (message $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was DispatchTalkEvent_Case02_Sub01_Case2F)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
VaseItem_Herb_Flag004B::
Jump_004_664B:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $004B
    call StartTreasureFlagDE_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $1A, story flag $004C in DE: when the flag is clear it gives item $1A (PorkChop) and sets the flag (message $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was DispatchTalkEvent_Case02_Sub01_Case30)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
VaseItem_PorkChop::
Jump_004_665C:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $1A
    ld [wScriptParam1], a
    ld de, $004C
    call StartTreasureFlagDE_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $2C, story flag $004D in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the flag (message $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was DispatchTalkEvent_Case02_Sub01_Case31)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
VaseItem_TinyMedal::
Jump_004_666D:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2C
    ld [wScriptParam1], a
    ld de, $004D
    call StartTreasureFlagDE_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $2B, story flag $004E in DE: when the flag is clear it gives item $2B (Bookmark) and sets the flag (message $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was DispatchTalkEvent_Case02_Sub01_Case32)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
VaseItem_Bookmark::
Jump_004_667E:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2B
    ld [wScriptParam1], a
    ld de, $004E
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $2A, story flag $004F in DE: when the flag is clear it gives item $2A (ExitBell) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was DispatchTalkEvent_Case02_Sub01_Case33)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_ExitBell_Flag004F::
Jump_004_668F:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2A
    ld [wScriptParam1], a
    ld de, $004F
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $24, story flag $0050 in DE: when the flag is clear it gives item $24 (Wind) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was DispatchTalkEvent_Case02_Sub01_Case34)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_Wind::
Jump_004_66A0:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $24
    ld [wScriptParam1], a
    ld de, $0050
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $29, story flag $0051 in DE: when the flag is clear it gives item $29 (WarpWing) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was DispatchTalkEvent_Case02_Sub01_Case35)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_WarpWing::
Jump_004_66B1:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $29
    ld [wScriptParam1], a
    ld de, $0051
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $48, story flag $0052 in DE: when the flag is clear it gives item $48 (AGL) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was DispatchTalkEvent_Case02_Sub01_Case36)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_AGL::
Jump_004_66C2:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $48
    ld [wScriptParam1], a
    ld de, $0052
    call StartTreasureFlagDE_B04
    ret

; entry 55 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; starts Script_5AAB: 'I'm making a new home for'
DispatchTalkEvent_Case02_Sub01_Case37::
Jump_004_66D3:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_66E2
    ld hl, Script_5AAB
    call StartScriptAtHL_B04
    ret

Jump_004_66E2::
    ld hl, Script_5AD2
    call StartScriptAtHL_B04
    ret

; entry 56 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp0
DispatchTalkEvent_Case02_Sub01_Case38::
Jump_004_66E9:: ; address name
    ld de, $0056
    call TestFlagBit
    ret nc
    ld de, $0057
    call TestFlagBit
    jr c, Jump_004_6746
    ld a, $19
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_004_673F
    ld a, $1A
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_004_673F
    ld a, $1B
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_004_673F
    ld a, $1C
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_004_673F
    ld hl, Script_5B0D
    call StartScriptAtHL_B04
    ret

Jump_004_673F::
    ld hl, Script_5B1D
    call StartScriptAtHL_B04
    ret

Jump_004_6746::
    ld hl, $018E ; 'Don't chase what runs from you.'
    call StartMessageCommand09HL_B04
    ret

; entry 57 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags
; writes: wStoryFlags, hTemp0
; starts Script_5B37
DispatchTalkEvent_Case02_Sub01_Case39::
Jump_004_674D:: ; address name
    ld a, [wStoryFlags + $61]
    set 4, a
    ld [wStoryFlags + $61], a
    ld hl, Script_5B37
    call StartScriptAtHL_B04
    ld a, $30
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    farcall RemoveInventorySlotShiftDown
    ret

; tests story flags (flag 005A then jr c, Jump_004_677B); starts message $0194 through StartMessageCommand09HL (script command $09); that string begins 'Thieves drove us from our homes!' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case3A)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0194_ThievesDroveUsFromOurHomes::
Jump_004_676C:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_677B
    ld hl, $0194 ; 'Thieves drove us from our homes!'
    call StartMessageCommand09HL_B04
    ret

Jump_004_677B::
    ld hl, $01B2 ; 'Cooh, our home come back to'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c, Jump_004_6791); starts message $0195 through StartMessageCommand09HL (script command $09); that string begins 'The leader of the thieves is a' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case3B)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0195_TheLeaderOfTheThievesIs::
Jump_004_6782:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_6791
    ld hl, $0195 ; 'The leader of the thieves is'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6791::
    ld hl, $01B4 ; 'Cooh! This bed perfect for sleep!'
    call StartMessageCommand09HL_B04
    ret

; entry 60 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
DispatchTalkEvent_Case02_Sub01_Case3C::
Jump_004_6798:: ; address name
    ld a, $03
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld de, $0059
    call TestFlagBit
    jr c, Jump_004_67B1
    ld hl, Script_5B3C
    call StartScriptAtHL_B04
    ret

Jump_004_67B1::
    ld hl, Script_5B49
    call StartScriptAtHL_B04
    ret

; starts message $01B5 through StartMessageCommand09HL (script command $09); that string begins 'Kyooh! Swimming in a desert This is' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case3D)
; no direct call (reached through a table, a jump or a vector)
TalkMsg01B5_KyoohSwimmingInADesertThis::
Jump_004_67B8:: ; address name
    ld hl, $01B5 ; 'Kyooh! Swimming in a desert This'
    call StartMessageCommand09HL_B04
    ret

; starts message $01BC through StartMessageCommand09HL (script command $09); that string begins '0 checked the treasure chest. Thieves have' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case3E)
; no direct call (reached through a table, a jump or a vector)
TalkMsg01BC_HeroCheckedTheTreasureChest::
Jump_004_67BF:: ; address name
    ld hl, $01BC ; '0 checked the treasure chest. Thieves'
    call StartMessageCommand09HL_B04
    ret

; starts message $01BD through StartMessageCommand09HL (script command $09); that string begins '0 peered into the vase. It was' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case3F)
; no direct call (reached through a table, a jump or a vector)
TalkMsg01BD_HeroPeeredIntoTheVaseIt::
Jump_004_67C6:: ; address name
    ld hl, $01BD ; '0 peered into the vase. It'
    call StartMessageCommand09HL_B04
    ret

; starts message $01C0 through StartMessageCommand09HL (script command $09); that string begins '0 checked the treasure chest. But it' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case40)
; no direct call (reached through a table, a jump or a vector)
TalkMsg01C0_HeroCheckedTheTreasureChest::
Jump_004_67CD:: ; address name
    ld hl, $01C0 ; '0 checked the treasure chest. But'
    call StartMessageCommand09HL_B04
    ret

; starts message $01BF through StartMessageCommand09HL (script command $09); that string begins '0 peered into the vase. The prisoners' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case41)
; no direct call (reached through a table, a jump or a vector)
TalkMsg01BF_HeroPeeredIntoTheVaseThe::
Jump_004_67D4:: ; address name
    ld hl, $01BF ; '0 peered into the vase. The'
    call StartMessageCommand09HL_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $19, story flag $005B in DE: when the flag is clear it gives item $19 (BeefJerky) and sets the flag (message $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was DispatchTalkEvent_Case02_Sub01_Case42)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
VaseItem_BeefJerky::
Jump_004_67DB:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $19
    ld [wScriptParam1], a
    ld de, $005B
    call StartTreasureFlagDE_B04
    ret

; entry 67 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; starts Script_5B53
DispatchTalkEvent_Case02_Sub01_Case43::
Jump_004_67EC:: ; address name
    ld de, $0058
    call TestFlagBit
    ret nc
    ld hl, Script_5B53
    call StartScriptAtHL_B04
    ret

; entry 68 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags
; writes: wStoryFlags
DispatchTalkEvent_Case02_Sub01_Case44::
Jump_004_67FA:: ; address name
    ld a, [wStoryFlags + $61]
    bit 4, a
    ret nz
    and a, $F7
    ld [wStoryFlags + $61], a
    ret

; entry 69 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
DispatchTalkEvent_Case02_Sub01_Case45::
Jump_004_6806:: ; address name
    ld a, $1F
    ld [wDataBank], a
    ld de, $005D
    call TestFlagBit
    jr c, Jump_004_6820
    ld hl, Script_5B76
    call StartScriptAtHL_B04
    ld de, $005D
    call SetFlagBit
    ret

Jump_004_6820::
    ld hl, Script_5B7D
    call StartScriptAtHL_B04
    ret

; only called from DispatchTalkEvent_Case06 (E-0047)
; 1 call site from 1 routine (e.g. DispatchTalkEvent_Case06)
; reads: wTalkEventGroup
DispatchTalkEvent_Case06_Sub01::
Func_004_6827:: ; address name
    ld a, [wTalkEventGroup]
    rst $00
    dw DispatchTalkEvent_Case06_Sub01_Case00
    dw DispatchTalkEvent_Case06_Sub01_Case01

; entry 0 of the `rst $00` table in Func_004_6827
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp0
DispatchTalkEvent_Case06_Sub01_Case00::
Jump_004_682F:: ; address name
    ld de, $00D2
    call TestFlagBit
    jr c, Jump_004_6875
    ld a, $36
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_004_686E
    ld a, $37
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_004_686E
    ld a, $38
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_004_686E
    ld hl, Script_61AA
    call StartScriptAtHL_B04
    ret

Jump_004_686E::
    ld hl, Script_619D
    call StartScriptAtHL_B04
    ret

Jump_004_6875::
    ld hl, Script_61DC
    call StartScriptAtHL_B04
    ret

; entry 1 of the `rst $00` table in Func_004_6827
; no direct call (reached through a table, a jump or a vector)
; starts Script_61E9: 'Darck Fawahahah! You chased your treasures'
DispatchTalkEvent_Case06_Sub01_Case01::
Jump_004_687C:: ; address name
    ld de, $00D0
    call TestFlagBit
    jr c, Jump_004_688B
    ld hl, Script_61E9
    call StartScriptAtHL_B04
    ret

Jump_004_688B::
    ld hl, Script_61F6
    call StartScriptAtHL_B04
    ret

; only called from DispatchTalkEvent_Case00 (E-0047)
; 1 call site from 1 routine (e.g. DispatchTalkEvent_Case00)
; reads: wTalkEventGroup
DispatchTalkEvent_Case00_Sub01::
Func_004_6892:: ; address name
    ld a, [wTalkEventGroup]
    rst $00
    dw DispatchTalkEvent_Case00_Sub01_Return
    dw TalkScript512F
    dw TalkScript5131
    dw DispatchTalkEvent_Case00_Sub01_Return
    dw TalkScript5137
    dw TalkScript5139
    dw TalkScript513B
    dw TalkScript513D
    dw TalkScript513F
    dw TalkScript5141
    dw TalkScript5143
    dw TalkScript5145
    dw TalkScript5145
    dw TalkScript5145
    dw TalkScript5147
    dw TalkScript5149
    dw TalkScript514B
    dw TalkScript514D
    dw TalkScript514F
    dw TalkScript5151
    dw TalkScript5153
    dw TalkScript5155
    dw TalkScript5157
    dw TalkScript5159
    dw TalkScript515F
    dw TalkScript5169
    dw TalkScript516B
    dw DispatchTalkEvent_Case00_Sub01_Case1B
    dw DispatchTalkEvent_Case00_Sub01_Case1C
    dw TalkScript5171
    dw TalkScript5173
    dw TalkScript5164
    dw TalkScript515B
    dw TalkScript515D
    dw DispatchTalkEvent_Case00_Sub01_Case22
    dw DispatchTalkEvent_Case00_Sub01_Case23
    dw DispatchTalkEvent_Case00_Sub01_Case24
    dw DispatchTalkEvent_Case00_Sub01_Case25
    dw DispatchTalkEvent_Case00_Sub01_Case26
    dw DispatchTalkEvent_Case00_Sub01_Return

; starts Script_5173 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case1E)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5173
TalkScript5173::
Jump_004_68E6:: ; address name
    ld hl, Script_5173
    call StartScriptAtHL_B04
    ret

; starts Script_5171 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case1D)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5171
TalkScript5171::
Jump_004_68ED:: ; address name
    ld hl, Script_5171
    call StartScriptAtHL_B04
    ret

; entry 28 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case00_Sub01_Case1C::
Jump_004_68F4:: ; address name
    ld de, $0024
    call TestFlagBit
    jr c, Jump_004_68FD
    ret

Jump_004_68FD::
    ld hl, Script_516F
    call StartScriptAtHL_B04
    ret

; entry 27 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case00_Sub01_Case1B::
Jump_004_6904:: ; address name
    ld de, $0024
    call TestFlagBit
    jr c, Jump_004_690D
    ret

Jump_004_690D::
    ld hl, Script_516D
    call StartScriptAtHL_B04
    ret

; starts Script_516B (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case1A)
; no direct call (reached through a table, a jump or a vector)
; starts Script_516B
TalkScript516B::
Jump_004_6914:: ; address name
    ld hl, Script_516B
    call StartScriptAtHL_B04
    ret

; starts Script_5169 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case19)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5169
TalkScript5169::
Jump_004_691B:: ; address name
    ld hl, Script_5169
    call StartScriptAtHL_B04
    ret

; starts Script_515F (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case18)
; no direct call (reached through a table, a jump or a vector)
; starts Script_515F
TalkScript515F::
Jump_004_6922:: ; address name
    ld hl, Script_515F
    call StartScriptAtHL_B04
    ret

; starts Script_5164 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case1F)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5164
TalkScript5164::
Jump_004_6929:: ; address name
    ld hl, Script_5164
    call StartScriptAtHL_B04
    ret

; starts Script_5155 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case15)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5155
TalkScript5155::
Jump_004_6930:: ; address name
    ld hl, Script_5155
    call StartScriptAtHL_B04
    ret

; starts Script_5157 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case16)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5157
TalkScript5157::
Jump_004_6937:: ; address name
    ld hl, Script_5157
    call StartScriptAtHL_B04
    ret

; starts Script_5159 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case17)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5159
TalkScript5159::
Jump_004_693E:: ; address name
    ld hl, Script_5159
    call StartScriptAtHL_B04
    ret

; starts Script_515B (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case20)
; no direct call (reached through a table, a jump or a vector)
; starts Script_515B
TalkScript515B::
Jump_004_6945:: ; address name
    ld hl, Script_515B
    call StartScriptAtHL_B04
    ret

; starts Script_515D (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case21)
; no direct call (reached through a table, a jump or a vector)
; starts Script_515D
TalkScript515D::
Jump_004_694C:: ; address name
    ld hl, Script_515D
    call StartScriptAtHL_B04
    ret

; entry 34 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerDelay, hPlayerFacing
; writes: wFollowerRecords, wScriptParam1
DispatchTalkEvent_Case00_Sub01_Case22::
Jump_004_6953:: ; address name
    ld a, [wFollowerDelay]
    or a, a
    ret z
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and a, $03
    ld [wFollowerRecords], a
    xor a, a
    ld [wScriptParam1], a
    ld hl, Script_57E1
    call StartScriptAtHL_B04
    ret

; entry 35 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerDelay, wPartyCount, hPlayerFacing
; writes: wFollowerRecords, wScriptParam1
DispatchTalkEvent_Case00_Sub01_Case23::
Jump_004_696C:: ; address name
    ld a, [wFollowerDelay]
    or a, a
    ret z
    ld a, [wPartyCount]
    dec a
    ret z
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and a, $03
    ld [wFollowerRecords + $5], a
    ld a, $01
    ld [wScriptParam1], a
    ld hl, Script_57E1
    call StartScriptAtHL_B04
    ret

; entry 36 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerDelay, wPartyCount, hPlayerFacing
; writes: wFollowerRecords, wScriptParam1
DispatchTalkEvent_Case00_Sub01_Case24::
Jump_004_698B:: ; address name
    ld a, [wFollowerDelay]
    or a, a
    ret z
    ld a, [wPartyCount]
    dec a
    ret z
    dec a
    ret z
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and a, $03
    ld [wFollowerRecords + $A], a
    ld a, $02
    ld [wScriptParam1], a
    ld hl, Script_57E1
    call StartScriptAtHL_B04
    ret

; entry 37 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerDelay
; starts Script_57DC
DispatchTalkEvent_Case00_Sub01_Case25::
Jump_004_69AC:: ; address name
    ld a, [wFollowerDelay]
    or a, a
    ret nz
    ld hl, Script_57DC
    call StartScriptAtHL_B04
    ret

; entry 38 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
; writes: wFollowerDelay
; starts Script_514B
DispatchTalkEvent_Case00_Sub01_Case26::
Jump_004_69B8:: ; address name
    xor a, a
    ld [wFollowerDelay], a
    ret

; starts Script_514B (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case10)
; no direct call (reached through a table, a jump or a vector)
; starts Script_514B
TalkScript514B::
Jump_004_69BD:: ; address name
    ld hl, Script_514B
    call StartScriptAtHL_B04
    ret

; starts Script_514D (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case11)
; no direct call (reached through a table, a jump or a vector)
; starts Script_514D
TalkScript514D::
Jump_004_69C4:: ; address name
    ld hl, Script_514D
    call StartScriptAtHL_B04
    ret

; starts Script_514F (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case12)
; no direct call (reached through a table, a jump or a vector)
; starts Script_514F
TalkScript514F::
Jump_004_69CB:: ; address name
    ld hl, Script_514F
    call StartScriptAtHL_B04
    ret

; starts Script_5151 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case13)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5151
TalkScript5151::
Jump_004_69D2:: ; address name
    ld hl, Script_5151
    call StartScriptAtHL_B04
    ret

; starts Script_5153 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case14)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5153
TalkScript5153::
Jump_004_69D9:: ; address name
    ld hl, Script_5153
    call StartScriptAtHL_B04
    ret

; entry 0 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
; starts Script_512F
DispatchTalkEvent_Case00_Sub01_Return::
Jump_004_69E0:: ; address name
    ret

; starts Script_512F (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case01)
; no direct call (reached through a table, a jump or a vector)
; starts Script_512F
TalkScript512F::
Jump_004_69E1:: ; address name
    ld hl, Script_512F
    call StartScriptAtHL_B04
    ret

; starts Script_5131 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case02)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5131
TalkScript5131::
Jump_004_69E8:: ; address name
    ld hl, Script_5131
    call StartScriptAtHL_B04
    ret

; starts Script_5137 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case04)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5137
TalkScript5137::
Jump_004_69EF:: ; address name
    ld hl, Script_5137
    call StartScriptAtHL_B04
    ret

; starts Script_5139 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case05)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5139
TalkScript5139::
Jump_004_69F6:: ; address name
    ld hl, Script_5139
    call StartScriptAtHL_B04
    ret

; starts Script_513B (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case06)
; no direct call (reached through a table, a jump or a vector)
; starts Script_513B
TalkScript513B::
Jump_004_69FD:: ; address name
    ld hl, Script_513B
    call StartScriptAtHL_B04
    ret

; starts Script_513D (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case07)
; no direct call (reached through a table, a jump or a vector)
; starts Script_513D
TalkScript513D::
Jump_004_6A04:: ; address name
    ld hl, Script_513D
    call StartScriptAtHL_B04
    ret

; starts Script_513F (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case08)
; no direct call (reached through a table, a jump or a vector)
; starts Script_513F
TalkScript513F::
Jump_004_6A0B:: ; address name
    ld hl, Script_513F
    call StartScriptAtHL_B04
    ret

; starts Script_5141 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case09)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5141
TalkScript5141::
Jump_004_6A12:: ; address name
    ld hl, Script_5141
    call StartScriptAtHL_B04
    ret

; starts Script_5143 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case0A)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5143
TalkScript5143::
Jump_004_6A19:: ; address name
    ld hl, Script_5143
    call StartScriptAtHL_B04
    ret

; starts Script_5145 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case0B)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5145
TalkScript5145::
Jump_004_6A20:: ; address name
    ld hl, Script_5145
    call StartScriptAtHL_B04
    ret

; starts Script_5147 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case0E)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5147
TalkScript5147::
Jump_004_6A27:: ; address name
    ld hl, Script_5147
    call StartScriptAtHL_B04
    ret

; starts Script_5149 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case0F)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5149
TalkScript5149::
Jump_004_6A2E:: ; address name
    ld hl, Script_5149
    call StartScriptAtHL_B04
    ret

; only called from DispatchTalkEvent_Case07 (E-0047)
; 1 call site from 1 routine (e.g. DispatchTalkEvent_Case07)
; reads: wTalkEventGroup
DispatchTalkEvent_Case07_Sub01::
Func_004_6A35:: ; address name
    ld a, [wTalkEventGroup]
    rst $00
    dw DispatchTalkEvent_Case07_Sub01_Case00
    dw DispatchTalkEvent_Case07_Sub01_Case01
    dw DispatchTalkEvent_Case07_Sub01_Case02
    dw TalkMsg0708_HelloMunchkinEnjoyYourStay
    dw TalkMsg0709_AHumanHereItsBeenSeveral
    dw TalkMsg070A_YoureNotLikeUsYouScare
    dw TalkMsg070B_HeyThereImATalkingHorse
    dw TalkMsg070C_ThisHorseWasHereBeforeUs
    dw TalkMsg070D_ThisIsElvenVillageYoureA
    dw TalkMsg0752_IEHeardThatHumansAre
    dw DispatchTalkEvent_Case07_Sub01_Case0A
    dw DispatchTalkEvent_Case07_Sub01_Case0B
    dw DispatchTalkEvent_Case07_Sub01_Case0C
    dw TalkMsg0723_TchWeHaveToEatThe
    dw DispatchTalkEvent_Case07_Sub01_Case0E
    dw TalkMsg072F_ThisIsElvensLookoutPostWe
    dw TalkMsg0730_HorridMonstersThatAttack
    dw DispatchTalkEvent_Case07_Sub01_Case11
    dw DispatchTalkEvent_Case07_Sub01_Case12
    dw VaseItem_TinyMedal_Flag0153
    dw VaseItem_INTseed
    dw VaseItem_Potion
    dw TalkMsg0756_HeroPeeredIntoTheVaseIt
    dw TalkMsg0758_HeroCheckedTheOvenStewSimmered
    dw ChestItem_WorldDew_Flag0156
    dw ChestItem_ExitBell_Flag0157
    dw ChestItem_MysticNut
    dw TalkMsg0757_HeroCheckedTheOvenASharp
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw Talk075F_KiralFetchMeMy
    dw Talk075A_PiiGgzzPiiiiii
    dw TalkMsg0760_HeroCheckedTheBookshelfA
    dw TalkMsg0761_HeroCheckedTheBookshelfA
    dw VaseItem_TinyMedal_Flag015B
    dw TalkMsg0762_HeroPeeredIntoTheVaseRolled
    dw TalkMsg0763_HeroPeeredIntoTheBarrelIt
    dw TalkMsg0764_HeroPeeredIntoTheBarrelThere
    dw TalkMsg0765_HeroPeeredIntoTheBarrelThere
    dw BarrelItem_WorldDew
    dw TalkMsg0766_HeroPeeredIntoTheBarrelA
    dw Talk0768_HeroPeeredIntoThe
    dw Talk0768_HeroPeeredIntoThe_70FC
    dw Talk078E_RobosterStoppedMovingEntirely
    dw Talk077B_HeroPeeredIntoThe
    dw TalkMsg07B7_TheTowersEntryIsSealedTight
    dw TalkMsg078F_ThisIsTheTown
    dw TalkMsg0790_AreYouFriendsWith
    dw TalkMsg0791_WowYouHaveMonsters
    dw TalkMsg0792_AreYourMonstersGood
    dw TalkMsg0793_MonstersCanBeGood
    dw TalkMsg0794_YouAppearToHave
    dw Talk07A4_CouldYouHumorThis
    dw Talk07A6_OurDaughtersOnlyMemento
    dw TalkMsg0799_MonstersRaidedThisHouse
    dw TalkMsg079A_TheOldPeopleAcross
    dw TalkMsg079B_MonstersHaveTakenTo
    dw TalkMsg079C_GrrrrImSoAngry
    dw StartScript643EInBank10
    dw StartScript6445ByPlayerX30
    dw TalkMsg079F_IfYouTravelWest
    dw Talk07D7_MilayouIEBeen
    dw TalkMsg07A9_ThisIsTheTravelersHutStay
    dw TalkMsg07AA_ThatDealerHowExpensive
    dw Talk07C1_WhatMonstersAttackedYou
    dw TalkMsg07AE_ThatDealersWaresCould
    dw Talk07AF_HowDoesThisOrnament
    dw TalkMsg07B8_WhoAreYou
    dw StartScript6496Or64A6ByFlag1BA
    dw Talk07BF_HeroFoundThePretty
    dw StartScript6509Or652CByFlag1C2
    dw VaseItem_DEFseed
    dw VaseItem_TinyMedal_Flag01C9
    dw TalkMsg0CFB_HeroTriedToOpenTheChest
    dw TalkMsg0CFA_HeroPeeredIntoTheOvenA
    dw TalkMsg0CFC_HeroPeeredIntoTheVaseCold
    dw VaseItem_Potion_Flag01CA
    dw TalkMsg0CFD_HeroPeeredIntoTheOvenMeat
    dw ChestItem_Laurel
    dw TalkMsg0CFE
    dw ChestItem_ExitBell_Flag01CC
    dw ChestItem_TinyMedal
    dw ChestItem_Friend
    dw TalkScript6595_HeroCheckedTheTreasureChest
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw TalkMsg0C03_TheTowersManyTreasuresAre
    dw TalkMsg0C02_OnlyAHandfulOfMastersHave
    dw DispatchTalkEvent_Case07_Sub01_Case62
    dw TalkScript659C
    dw TalkScript659C
    dw TalkScript659C
    dw TalkScript659C
    dw Talk0C17
    dw ChestItem_TinyMedal_Flag01D5
    dw ChestItem_AGL_Flag01D6
    dw ChestItem_SkyBell
    dw ChestItem_Herb
    dw ChestItem_OrcaCape_Flag01DB
    dw ChestItem_LoveWater_Flag01DC
    dw ChestItem_LoveWater_Flag01DE
    dw ChestItem_StoneFang
    dw ChestItem_Herb_Flag0169
    dw ChestItem_LoveWater_Flag016B
    dw ChestItem_Sailor
    dw ChestItem_SilvrCape
    dw ChestItem_MagicCape
    dw ChestItem_DracoCape
    dw ChestItem_Herb_Flag0171
    dw ChestItem_TinyMedal_Flag0172
    dw TalkScript659E_HeroCheckedTheTreasureChest
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw TalkMsg0C1B_ItsNotThatEasyToWin
    dw TalkMsg0C1A_InThisTowerYourOpponents
    dw DispatchTalkEvent_Case07_Sub01_Case82
    dw TalkScript659C_0478A5
    dw TalkScript659C_0478A5
    dw TalkScript659C_0478A5
    dw TalkScript659C_0478A5
    dw Talk0C2F
    dw ChestItem_SkyBell_Flag0175
    dw ChestItem_Smart
    dw ChestItem_ExitBell_Flag0177
    dw ChestItem_Herb_Flag0179
    dw ChestItem_AwakeSand
    dw ChestItem_Cleric
    dw ChestItem_ExitBell_Flag017D
    dw ChestItem_BraveCape
    dw ChestItem_MoonHerb
    dw ChestItem_MermScale_Flag00D6
    dw ChestItem_LoveWater_Flag00D7
    dw ChestItem_Thief
    dw ChestItem_Herb_Flag00DA
    dw ChestItem_GoldCape
    dw ChestItem_Mage
    dw ChestItem_Antidote
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw TalkMsg0C33_ItsBrutalUpAheadIWouldnt
    dw TalkMsg0C32_TheMonstersHereAreAwfulIm
    dw DispatchTalkEvent_Case07_Sub01_CaseA2
    dw TalkScript659C_0479FC
    dw TalkScript659C_0479FC
    dw TalkScript659C_0479FC
    dw TalkScript659C_0479FC
    dw Talk0C47
    dw ChestItem_ExitBell_Flag00F5
    dw ChestItem_War_Flag00F6
    dw ChestItem_WorldDew_Flag00F7
    dw ChestItem_TinyMedal_Flag00F9
    dw ChestItem_SteelFang
    dw ChestItem_DrakScale
    dw ChestItem_Life
    dw ChestItem_Divine
    dw ChestItem_Herb_Flag00FF
    dw ChestItem_PltnmCape
    dw ChestItem_Wise
    dw ChestItem_ExitBell_Flag01F5
    dw ChestItem_Herb_Flag01F7
    dw ChestItem_Fight
    dw ChestItem_Starry
    dw ChestItem_LoveWater_Flag01FA
    ds $10, $00

; entry 0 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
; starts Script_6200
DispatchTalkEvent_Case07_Sub01_Case00::
Jump_004_6BB9:: ; address name
    ld de, $0140
    call TestFlagBit
    jr c, Jump_004_6BC8
    ld hl, Script_6200
    call StartScriptAtHL_B04
    ret

Jump_004_6BC8::
    ld de, $0148
    call TestFlagBit
    ret c
    ld de, $0147
    call TestFlagBit
    ret nc
    ld hl, Script_624B
    call StartScriptAtHL_B04
    ret

; entry 1 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case07_Sub01_Case01::
Jump_004_6BDD:: ; address name
    ld de, $0151
    call TestFlagBit
    jr c, Jump_004_6C52
    ld de, $014F
    call TestFlagBit
    jr c, Jump_004_6C4B
    ld de, $014B
    call TestFlagBit
    jr c, Jump_004_6C44
    ld de, $0146
    call TestFlagBit
    jr c, Jump_004_6C3D
    ld de, $0143
    call TestFlagBit
    jr c, Jump_004_6C30
    ld de, $0141
    call TestFlagBit
    jr c, Jump_004_6C1A
    ld hl, $0701 ; 'You're a human. How did you'
    call StartMessageCommand09HL_B04
    ld de, $0141
    call SetFlagBit
    ret

Jump_004_6C1A::
    ld de, $0142
    call TestFlagBit
    jr c, Jump_004_6C29
    ld hl, $0702 ; 'Even worse, you have monsters. Get'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6C29::
    ld hl, Script_620C
    call StartScriptAtHL_B04
    ret

Jump_004_6C30::
    ld hl, $0706 ; 'Rolt Go south in the plains,'
    call StartMessageCommand09HL_B04
    ld de, $0145
    call SetFlagBit
    ret

Jump_004_6C3D::
    ld hl, $0715 ; 'Rolt 0, I can see that'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6C44::
    ld hl, Script_62AD
    call StartScriptAtHL_B04
    ret

Jump_004_6C4B::
    ld hl, $0738 ; 'Rolt Urrrgh 0 Please Please save'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6C52::
    ld hl, $0746 ; 'Rolt I'm going to get strong'
    call StartMessageCommand09HL_B04
    ret

; entry 2 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case07_Sub01_Case02::
Jump_004_6C59:: ; address name
    ld de, $0152
    call TestFlagBit
    jr c, Jump_004_6CA1
    ld de, $0151
    call TestFlagBit
    jr c, Jump_004_6C94
    ld de, $0146
    call TestFlagBit
    jr c, Jump_004_6C8D
    ld de, $0143
    call TestFlagBit
    jr c, Jump_004_6C80
    ld hl, Script_6382
    call StartScriptAtHL_B04
    ret

Jump_004_6C80::
    ld hl, $0707 ; 'Cyal We're going back home now.'
    call StartMessageCommand09HL_B04
    ld de, $0145
    call SetFlagBit
    ret

Jump_004_6C8D::
    ld hl, Script_6240
    call StartScriptAtHL_B04
    ret

Jump_004_6C94::
    ld hl, $0747 ; 'Cyal I hope you'll stay my'
    call StartMessageCommand09HL_B04
    ld de, $0152
    call SetFlagBit
    ret

Jump_004_6CA1::
    ld hl, $0748 ; 'Cyal I ought to become a'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0151 then jr c, Jump_004_6CD5; flag 014C then jr c, Jump_004_6CCE; flag 0147 then jr c, Jump_004_6CC7); starts message $0708 through StartMessageCommand09HL (script command $09); that string begins 'Hello, munchkin. Enjoy your stay!' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case03)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0708_HelloMunchkinEnjoyYourStay::
Jump_004_6CA8:: ; address name
    ld de, $0151
    call TestFlagBit
    jr c, Jump_004_6CD5
    ld de, $014C
    call TestFlagBit
    jr c, Jump_004_6CCE
    ld de, $0147
    call TestFlagBit
    jr c, Jump_004_6CC7
    ld hl, $0708 ; 'Hello, munchkin. Enjoy your stay!'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6CC7::
    ld hl, $0717 ; 'Cyal grew up as an orphan.'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6CCE::
    ld hl, $0755 ; 'Not only their parents, but Cyal'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6CD5::
    ld hl, $0749 ; 'We owe you a big thanks.'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0151 then jr c, Jump_004_6CFA; flag 0147 then jr c, Jump_004_6CF3); starts message $0709 through StartMessageCommand09HL (script command $09); that string begins 'A human here? It's been several centuries' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case04)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0709_AHumanHereItsBeenSeveral::
Jump_004_6CDC:: ; address name
    ld de, $0151
    call TestFlagBit
    jr c, Jump_004_6CFA
    ld de, $0147
    call TestFlagBit
    jr c, Jump_004_6CF3
    ld hl, $0709 ; 'A human here? It's been several'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6CF3::
    ld hl, $0718 ; 'Cyal and Rolt have no family'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6CFA::
    ld hl, $074A ; 'Thanks to you, we can live'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0151 then jr c, Jump_004_6D10); starts message $070A through StartMessageCommand09HL (script command $09); that string begins 'You're not like us. You scare me' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case05)
; no direct call (reached through a table, a jump or a vector)
TalkMsg070A_YoureNotLikeUsYouScare::
Jump_004_6D01:: ; address name
    ld de, $0151
    call TestFlagBit
    jr c, Jump_004_6D10
    ld hl, $070A ; 'You're not like us. You scare'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6D10::
    ld hl, $074B ; 'You look kind and caring. I'm'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0151 then jr c, Jump_004_6D44; flag 014C then jr c, Jump_004_6D3D; flag 0147 then jr c, Jump_004_6D36); starts message $070B through StartMessageCommand09HL (script command $09); that string begins 'Hey there! I'm a talking horse. Glad' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case06)
; no direct call (reached through a table, a jump or a vector)
TalkMsg070B_HeyThereImATalkingHorse::
Jump_004_6D17:: ; address name
    ld de, $0151
    call TestFlagBit
    jr c, Jump_004_6D44
    ld de, $014C
    call TestFlagBit
    jr c, Jump_004_6D3D
    ld de, $0147
    call TestFlagBit
    jr c, Jump_004_6D36
    ld hl, $070B ; 'Hey there! I'm a talking horse.'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6D36::
    ld hl, $071A ; 'Cyal's parents were attacked by horrible'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6D3D::
    ld hl, $072C ; 'AgDevil is a total terror. We'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6D44::
    ld hl, $074C ; 'Brave human, hear this. The King'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0151 then jr c, Jump_004_6D5A); starts message $070C through StartMessageCommand09HL (script command $09); that string begins 'This horse was here before us.' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case07)
; no direct call (reached through a table, a jump or a vector)
TalkMsg070C_ThisHorseWasHereBeforeUs::
Jump_004_6D4B:: ; address name
    ld de, $0151
    call TestFlagBit
    jr c, Jump_004_6D5A
    ld hl, $070C ; 'This horse was here before us.'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6D5A::
    ld hl, $074D ; 'The talking horse came from somewhere'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0151 then jr c, Jump_004_6D8E; flag 014C then jr c, Jump_004_6D87; flag 0147 then jr c, Jump_004_6D80); starts message $070D through StartMessageCommand09HL (script command $09); that string begins 'This is Elven village. You're a human,' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case08)
; no direct call (reached through a table, a jump or a vector)
TalkMsg070D_ThisIsElvenVillageYoureA::
Jump_004_6D61:: ; address name
    ld de, $0151
    call TestFlagBit
    jr c, Jump_004_6D8E
    ld de, $014C
    call TestFlagBit
    jr c, Jump_004_6D87
    ld de, $0147
    call TestFlagBit
    jr c, Jump_004_6D80
    ld hl, $070D ; 'This is Elven village. You're a'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6D80::
    ld hl, $071B ; 'I think Cyal's looking forward to'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6D87::
    ld hl, $072D ; 'Cyal was taken away by monsters?'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6D8E::
    ld hl, $074E ; 'You put down that fiend? You're'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0151 then jr c, Jump_004_6DC2; flag 014C then jr c, Jump_004_6DBB; flag 0147 then jr c, Jump_004_6DB4); starts message $0752 through StartMessageCommand09HL (script command $09); that string begins 'I e heard that humans are wild' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case09)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0752_IEHeardThatHumansAre::
Jump_004_6D95:: ; address name
    ld de, $0151
    call TestFlagBit
    jr c, Jump_004_6DC2
    ld de, $014C
    call TestFlagBit
    jr c, Jump_004_6DBB
    ld de, $0147
    call TestFlagBit
    jr c, Jump_004_6DB4
    ld hl, $0752 ; 'I e heard that humans are'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6DB4::
    ld hl, $071C ; 'Humans can't be trusted, but Please'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6DBB::
    ld hl, $072E ; 'Didn't I ask you to protect'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6DC2::
    ld hl, $074F ; 'You You're a savage but I'
    call StartMessageCommand09HL_B04
    ret

; entry 10 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenTableIndex, wDataBank
DispatchTalkEvent_Case07_Sub01_Case0A::
Jump_004_6DC9:: ; address name
    ld a, $10
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_637B
    call StartScriptAtHL_B04
    ret

; entry 11 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case07_Sub01_Case0B::
Jump_004_6DDA:: ; address name
    ld de, $0151
    call TestFlagBit
    jr c, Jump_004_6E4F
    ld de, $014D
    call TestFlagBit
    jr c, Jump_004_6E48
    ld de, $014C
    call TestFlagBit
    jr c, Jump_004_6E3B
    ld de, $0146
    call TestFlagBit
    jr c, Jump_004_6E34
    ld de, $0144
    call TestFlagBit
    jr c, Jump_004_6E1E
    ld de, $0145
    call TestFlagBit
    jr c, Jump_004_6E17
    ld hl, $070F ; 'Well, well It is a rare'
    call StartMessageCommand09HL_B04
    ld de, $0144
    call SetFlagBit
    ret

Jump_004_6E17::
    ld hl, Script_6218
    call StartScriptAtHL_B04
    ret

Jump_004_6E1E::
    ld de, $0145
    call TestFlagBit
    jr c, Jump_004_6E2D
    ld hl, $0753 ; 'I'm the Village Elder. By the'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6E2D::
    ld hl, Script_622C
    call StartScriptAtHL_B04
    ret

Jump_004_6E34::
    ld hl, $0714 ; 'Tamed monsters, have you? That's impressive'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6E3B::
    ld hl, $072A ; 'AgDevil killed Rolt's parents. Rolt must'
    call StartMessageCommand09HL_B04
    ld de, $014D
    call SetFlagBit
    ret

Jump_004_6E48::
    ld hl, $072B ; 'AgDevil appears to come from deep'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6E4F::
    ld hl, $0744 ; 'Our gratitude is as plentiful as'
    call StartMessageCommand09HL_B04
    ret

; entry 12 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
; starts Script_626A: 'Master AgDevil, a human, ruff!'
DispatchTalkEvent_Case07_Sub01_Case0C::
Jump_004_6E56:: ; address name
    ld de, $0148
    call TestFlagBit
    ret nc
    ld hl, Script_626A
    call StartScriptAtHL_B04
    ret

; tests story flags (flag 014A then jr c, Jump_004_6E73); starts message $0723 through StartMessageCommand09HL (script command $09); that string begins 'Tch, we have to eat the lousy' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case0D)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0723_TchWeHaveToEatThe::
Jump_004_6E64:: ; address name
    ld de, $014A
    call TestFlagBit
    jr c, Jump_004_6E73
    ld hl, $0723 ; 'Tch, we have to eat the'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6E73::
    ld hl, $0726 ; 'Huh? It's here again, ruff! It's'
    call StartMessageCommand09HL_B04
    ret

; entry 14 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
; starts Script_6290: 'That's what we'll do, kid. You're'
DispatchTalkEvent_Case07_Sub01_Case0E::
Jump_004_6E7A:: ; address name
    ld de, $014A
    call TestFlagBit
    jr c, Jump_004_6E89
    ld hl, Script_6290
    call StartScriptAtHL_B04
    ret

Jump_004_6E89::
    ld hl, Script_62A0
    call StartScriptAtHL_B04
    ret

; tests story flags (flag 0151 then jr c, Jump_004_6EC3; flag 014E then jr c, Jump_004_6EBC; flag 014C then jr c, Jump_004_6EAF); starts message $072F through StartMessageCommand09HL (script command $09); that string begins 'This is Elven's lookout post. We stand' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case0F)
; no direct call (reached through a table, a jump or a vector)
TalkMsg072F_ThisIsElvensLookoutPostWe::
Jump_004_6E90:: ; address name
    ld de, $0151
    call TestFlagBit
    jr c, Jump_004_6EC3
    ld de, $014E
    call TestFlagBit
    jr c, Jump_004_6EBC
    ld de, $014C
    call TestFlagBit
    jr c, Jump_004_6EAF
    ld hl, $072F ; 'This is Elven's lookout post. We'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6EAF::
    ld hl, $0731 ; 'This is the lookout post. Rolt'
    call StartMessageCommand09HL_B04
    ld de, $014E
    call SetFlagBit
    ret

Jump_004_6EBC::
    ld hl, $0732 ; 'That AgDevil is from the mountains'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6EC3::
    ld hl, $0750 ; 'This is Elven's lookout post. We'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0151 then jr c, Jump_004_6EE8; flag 014C then jr c, Jump_004_6EE1); starts message $0730 through StartMessageCommand09HL (script command $09); that string begins 'Horrid monsters that attack elves appear often' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case10)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0730_HorridMonstersThatAttack::
Jump_004_6ECA:: ; address name
    ld de, $0151
    call TestFlagBit
    jr c, Jump_004_6EE8
    ld de, $014C
    call TestFlagBit
    jr c, Jump_004_6EE1
    ld hl, $0730 ; 'Horrid monsters that attack elves appear'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6EE1::
    ld hl, $0733 ; 'You're not going to the northern'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6EE8::
    ld hl, $0751 ; 'Beating AgDevil That's incredible! But now'
    call StartMessageCommand09HL_B04
    ret

; entry 17 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
; starts Script_62BD: 'The human in the forest again?'
DispatchTalkEvent_Case07_Sub01_Case11::
Jump_004_6EEF:: ; address name
    ld de, $0150
    call TestFlagBit
    jr c, Jump_004_6F04
    ld hl, Script_62BD
    call StartScriptAtHL_B04
    ld de, $0150
    call SetFlagBit
    ret

Jump_004_6F04::
    ld hl, Script_6313
    call StartScriptAtHL_B04
    ret

; entry 18 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
; starts Script_6369: 'Rolt I e found you at'
DispatchTalkEvent_Case07_Sub01_Case12::
Jump_004_6F0B:: ; address name
    ld de, $014C
    call TestFlagBit
    ret nc
    ld hl, Script_6369
    call StartScriptAtHL_B04
    ld de, $0149
    call SetFlagBit
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $2C, story flag $0153 in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the flag (message $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was DispatchTalkEvent_Case07_Sub01_Case13)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
VaseItem_TinyMedal_Flag0153::
Jump_004_6F1F:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2C
    ld [wScriptParam1], a
    ld de, $0153
    call StartTreasureFlagDE_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $10, story flag $0154 in DE: when the flag is clear it gives item $10 (INTseed) and sets the flag (message $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was DispatchTalkEvent_Case07_Sub01_Case14)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
VaseItem_INTseed::
Jump_004_6F30:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $10
    ld [wScriptParam1], a
    ld de, $0154
    call StartTreasureFlagDE_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $04, story flag $0155 in DE: when the flag is clear it gives item $04 (Potion) and sets the flag (message $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was DispatchTalkEvent_Case07_Sub01_Case15)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
VaseItem_Potion::
Jump_004_6F41:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $04
    ld [wScriptParam1], a
    ld de, $0155
    call StartTreasureFlagDE_B04
    ret

; starts message $0756 through StartMessageCommand09HL (script command $09); that string begins '0 peered into the vase. It was' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case16)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0756_HeroPeeredIntoTheVaseIt::
Jump_004_6F52:: ; address name
    ld hl, $0756 ; '0 peered into the vase. It'
    call StartMessageCommand09HL_B04
    ret

; starts message $0758 through StartMessageCommand09HL (script command $09); that string begins '0 checked the oven. Stew simmered and' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case17)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0758_HeroCheckedTheOvenStewSimmered::
Jump_004_6F59:: ; address name
    ld hl, $0758 ; '0 checked the oven. Stew simmered'
    call StartMessageCommand09HL_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $03, story flag $0156 in DE: when the flag is clear it gives item $03 (WorldDew) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was DispatchTalkEvent_Case07_Sub01_Case18)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_WorldDew_Flag0156::
Jump_004_6F60:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $03
    ld [wScriptParam1], a
    ld de, $0156
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $2A, story flag $0157 in DE: when the flag is clear it gives item $2A (ExitBell) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was DispatchTalkEvent_Case07_Sub01_Case19)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_ExitBell_Flag0157::
Jump_004_6F71:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2A
    ld [wScriptParam1], a
    ld de, $0157
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $12, story flag $0158 in DE: when the flag is clear it gives item $12 (MysticNut) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was DispatchTalkEvent_Case07_Sub01_Case1A)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_MysticNut::
Jump_004_6F82:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $12
    ld [wScriptParam1], a
    ld de, $0158
    call StartTreasureFlagDE_B04
    ret

; starts message $0757 through StartMessageCommand09HL (script command $09); that string begins '0 checked the oven. A sharp aroma' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case1B)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0757_HeroCheckedTheOvenASharp::
Jump_004_6F93:: ; address name
    ld hl, $0757 ; '0 checked the oven. A sharp'
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 7 constant message(s) depending on story flags and state; the first one in the code is $075F, whose string begins 'Kiral Fetch me my treasure from'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, wGameFlags836
; writes: hTemp0, wGameFlags836
Talk075F_KiralFetchMeMy::
Jump_004_6F9A:: ; address name
    ld de, $0167
    call TestFlagBit
    jp c, Jump_004_704E
    ld de, $0165
    call TestFlagBit
    jp c, Jump_004_7032
    ld de, $0163
    call TestFlagBit
    jr c, Jump_004_6FF7
    ld de, $0162
    call TestFlagBit
    jr c, Jump_004_6FF0
    ld de, $015F
    call TestFlagBit
    jr c, Jump_004_6FE9
    ld de, $015A
    call TestFlagBit
    jr c, Jump_004_6FE2
    ld de, $0159
    call TestFlagBit
    jr c, Jump_004_6FDB
    ld hl, Script_6398
    call StartScriptAtHL_B04
    ret

Jump_004_6FDB::
    ld hl, Script_63BC
    call StartScriptAtHL_B04
    ret

Jump_004_6FE2::
    ld hl, $075F ; 'Kiral Fetch me my treasure from'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6FE9::
    ld hl, Script_6409
    call StartScriptAtHL_B04
    ret

Jump_004_6FF0::
    ld hl, $0778 ; 'Kiral Please Go stop him. You'
    call StartMessageCommand09HL_B04
    ret

Jump_004_6FF7::
    ld a, $3C
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_004_702B
    farcall RemoveInventorySlotShiftDown
    call InventoryHasFreeSlotCheck
    ld [hl], $17
    ld a, [wGameFlags836]
    set 6, a
    ld [wGameFlags836], a
    ld hl, Script_641B
    call StartScriptAtHL_B04
    ld a, $08
    ldh [hTemp0], a
    farcall MarkKeyEntryKindTemp0Bit6
    ret

Jump_004_702B::
    ld hl, $077D ; 'Kiral Ah! Back! Is Rob-N Did'
    call StartMessageCommand09HL_B04
    ret

Jump_004_7032::
    ld de, $0166
    call TestFlagBit
    jr c, Jump_004_7047
    ld hl, $0786 ; 'Kiral You e been a great'
    call StartMessageCommand09HL_B04
    ld de, $0166
    call SetFlagBit
    ret

Jump_004_7047::
    ld hl, $0787 ; 'Kiral Visit me when you're free.'
    call StartMessageCommand09HL_B04
    ret

Jump_004_704E::
    ld de, $0168
    call TestFlagBit
    jr c, Jump_004_7063
    ld hl, $0789 ; 'Kiral Hohoh! I e got good'
    call StartMessageCommand09HL_B04
    ld de, $0168
    call SetFlagBit
    ret

Jump_004_7063::
    ld hl, $078A ; 'Kiral Roboster2's skills are simply exceptional.'
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 3 constant message(s) depending on story flags and state; the first one in the code is $075A, whose string begins 'Pii Ggzz Piiiiii'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; writes: wObject1
Talk075A_PiiGgzzPiiiiii::
Jump_004_706A:: ; address name
    ld de, $0167
    call TestFlagBit
    jr c, Jump_004_708C
    ld de, $0165
    call TestFlagBit
    jr c, Jump_004_7085
    xor a, a
    ld [wObject1 + $7], a
    ld hl, $075A ; 'Pii Ggzz Piiiiii'
    call StartMessageCommand09HL_B04
    ret

Jump_004_7085::
    ld hl, $0788 ; 'I AM THE LATEST ROBOSTER. ROBOSTER2'
    call StartMessageCommand09HL_B04
    ret

Jump_004_708C::
    ld hl, $078B ; 'MY NAME IS LEO. THE PROFESSOR'
    call StartMessageCommand09HL_B04
    ret

; starts message $0760 through StartMessageCommand09HL (script command $09); that string begins '0 checked the bookshelf. A recent diary' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case22)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0760_HeroCheckedTheBookshelfA::
Jump_004_7093:: ; address name
    ld hl, $0760 ; '0 checked the bookshelf. A recent'
    call StartMessageCommand09HL_B04
    ret

; starts message $0761 through StartMessageCommand09HL (script command $09); that string begins '0 checked the bookshelf. A very old' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case23)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0761_HeroCheckedTheBookshelfA::
Jump_004_709A:: ; address name
    ld hl, $0761 ; '0 checked the bookshelf. A very'
    call StartMessageCommand09HL_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $2C, story flag $015B in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the flag (message $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was DispatchTalkEvent_Case07_Sub01_Case24)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
VaseItem_TinyMedal_Flag015B::
Jump_004_70A1:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2C
    ld [wScriptParam1], a
    ld de, $015B
    call StartTreasureFlagDE_B04
    ret

; starts message $0762 through StartMessageCommand09HL (script command $09); that string begins '0 peered into the vase. Rolled blueprints' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case25)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0762_HeroPeeredIntoTheVaseRolled::
Jump_004_70B2:: ; address name
    ld hl, $0762 ; '0 peered into the vase. Rolled'
    call StartMessageCommand09HL_B04
    ret

; starts message $0763 through StartMessageCommand09HL (script command $09); that string begins '0 peered into the barrel. It faintly' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case26)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0763_HeroPeeredIntoTheBarrelIt::
Jump_004_70B9:: ; address name
    ld hl, $0763 ; '0 peered into the barrel. It'
    call StartMessageCommand09HL_B04
    ret

; starts message $0764 through StartMessageCommand09HL (script command $09); that string begins '0 peered into the barrel. There were' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case27)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0764_HeroPeeredIntoTheBarrelThere::
Jump_004_70C0:: ; address name
    ld hl, $0764 ; '0 peered into the barrel. There'
    call StartMessageCommand09HL_B04
    ret

; starts message $0765 through StartMessageCommand09HL (script command $09); that string begins '0 peered into the barrel. There was' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case28)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0765_HeroPeeredIntoTheBarrelThere::
Jump_004_70C7:: ; address name
    ld hl, $0765 ; '0 peered into the barrel. There'
    call StartMessageCommand09HL_B04
    ret

; a one-time barrel: script command $0A with wScriptParam0 = 2 (kind) and wScriptParam1 = $03, story flag $015C in DE: when the flag is clear it gives item $03 (WorldDew) and sets the flag (message $A6 of group 0; $A7 when the flag is already set, $A8 when there is no room) (E-0269; was DispatchTalkEvent_Case07_Sub01_Case29)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
BarrelItem_WorldDew::
Jump_004_70CE:: ; address name
    ld a, $02
    ld [wScriptParam0], a
    ld a, $03
    ld [wScriptParam1], a
    ld de, $015C
    call StartTreasureFlagDE_B04
    ret

; starts message $0766 through StartMessageCommand09HL (script command $09); that string begins '0 peered into the barrel. A quite' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case2A)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0766_HeroPeeredIntoTheBarrelA::
Jump_004_70DF:: ; address name
    ld hl, $0766 ; '0 peered into the barrel. A'
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1 constant message(s) depending on story flags and state; the first one in the code is $0768, whose string begins '0 peered into the barrel. There'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; starts Script_63DB: '0 peered into the barrel. A'
Talk0768_HeroPeeredIntoThe::
Jump_004_70E6:: ; address name
    ld de, $015D
    call TestFlagBit
    jr c, Jump_004_70F5
    ld hl, Script_63DB
    call StartScriptAtHL_B04
    ret

Jump_004_70F5::
    ld hl, $0768 ; '0 peered into the barrel. There'
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1 constant message(s) depending on story flags and state; the first one in the code is $0768, whose string begins '0 peered into the barrel. There'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; starts Script_63E4: '0 peered into the barrel. A'
Talk0768_HeroPeeredIntoThe_70FC::
Jump_004_70FC:: ; address name
    ld de, $015E
    call TestFlagBit
    jr c, Jump_004_710B
    ld hl, Script_63E4
    call StartScriptAtHL_B04
    ret

Jump_004_710B::
    ld hl, $0768 ; '0 peered into the barrel. There'
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 2 constant message(s) depending on story flags and state; the first one in the code is $078E, whose string begins 'Roboster stopped moving entirely'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
Talk078E_RobosterStoppedMovingEntirely::
Jump_004_7112:: ; address name
    ld de, $0167
    call TestFlagBit
    jr c, Jump_004_715D
    ld de, $0163
    call TestFlagBit
    jr c, Jump_004_7156
    ld de, $0161
    call TestFlagBit
    jr c, Jump_004_714F
    ld de, $0160
    call TestFlagBit
    jr c, Jump_004_7148
    ld de, $015F
    call TestFlagBit
    jr c, Jump_004_7141
    ld hl, Script_63ED
    call StartScriptAtHL_B04
    ret

Jump_004_7141::
    ld hl, Script_63F4
    call StartScriptAtHL_B04
    ret

Jump_004_7148::
    ld hl, Script_63FB
    call StartScriptAtHL_B04
    ret

Jump_004_714F::
    ld hl, Script_6402
    call StartScriptAtHL_B04
    ret

Jump_004_7156::
    ld hl, $078E ; 'Roboster stopped moving entirely'
    call StartMessageCommand09HL_B04
    ret

Jump_004_715D::
    ld hl, $078C ; 'WELCOME. I AM ROB-N. I SERVE'
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 3 constant message(s) depending on story flags and state; the first one in the code is $077B, whose string begins '0 peered into the barrel. There'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: wGameFlags836
; writes: wGameFlags836
Talk077B_HeroPeeredIntoThe::
Jump_004_7164:: ; address name
    ld de, $0164
    call TestFlagBit
    jr c, Jump_004_719E
    ld de, $0163
    call TestFlagBit
    jr c, Jump_004_717B
    ld hl, Script_6416
    call StartScriptAtHL_B04
    ret

Jump_004_717B::
    call InventoryHasFreeSlotCheck
    jr c, Jump_004_7187
    ld hl, $077B ; '0 peered into the barrel. There'
    call StartMessageCommand09HL_B04
    ret

Jump_004_7187::
    ld [hl], $3C
    ld a, [wGameFlags836]
    set 6, a
    ld [wGameFlags836], a
    ld hl, $077A ; '0 peered into the barrel. There'
    call StartMessageCommand09HL_B04
    ld de, $0164
    call SetFlagBit
    ret

Jump_004_719E::
    ld hl, $077C ; '0 peered into the barrel. There'
    call StartMessageCommand09HL_B04
    ret

; starts message $07B7 through StartMessageCommand09HL (script command $09); that string begins 'The tower's entry is sealed tight.' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case2F)
; no direct call (reached through a table, a jump or a vector)
TalkMsg07B7_TheTowersEntryIsSealedTight::
Jump_004_71A5:: ; address name
    ld hl, $07B7 ; 'The tower's entry is sealed tight.'
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to Jump_004_71BB); when none of them branches, starts message $078F through StartMessageCommand09HL_B04 (script command $09); that string begins 'This is the town of Miagen.' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg078F_ThisIsTheTown::
Jump_004_71AC:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_71BB
    ld hl, $078F ; 'This is the town of Miagen.'
    call StartMessageCommand09HL_B04
    ret

Jump_004_71BB::
    ld hl, $0CE2 ; 'Welcome to the town of Miagen.'
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to Jump_004_71E0; flag $01BC set: jr to Jump_004_71D9); when none of them branches, starts message $0790 through StartMessageCommand09HL_B04 (script command $09); that string begins 'Are you friends with monsters? You're' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0790_AreYouFriendsWith::
Jump_004_71C2:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_71E0
    ld de, $01BC
    call TestFlagBit
    jr c, Jump_004_71D9
    ld hl, $0790 ; 'Are you friends with monsters? You're'
    call StartMessageCommand09HL_B04
    ret

Jump_004_71D9::
    ld hl, $07C6 ; 'Are you Milayou's friend? The little'
    call StartMessageCommand09HL_B04
    ret

Jump_004_71E0::
    ld hl, $0CE3 ; 'So you defeated the evildoer?'
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to Jump_004_71F6); when none of them branches, starts message $0791 through StartMessageCommand09HL_B04 (script command $09); that string begins 'Wow! You have monsters! Neat! Are' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0791_WowYouHaveMonsters::
Jump_004_71E7:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_71F6
    ld hl, $0791 ; 'Wow! You have monsters! Neat! Are'
    call StartMessageCommand09HL_B04
    ret

Jump_004_71F6::
    ld hl, $0CE4 ; 'Wow, you have monsters! Wicked! They'
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to Jump_004_720C); when none of them branches, starts message $0792 through StartMessageCommand09HL_B04 (script command $09); that string begins 'Are your monsters good? I don't' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0792_AreYourMonstersGood::
Jump_004_71FD:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_720C
    ld hl, $0792 ; 'Are your monsters good? I don't'
    call StartMessageCommand09HL_B04
    ret

Jump_004_720C::
    ld hl, $0CE5 ; 'Your monsters are good, it's plain'
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to Jump_004_7231; flag $01BC set: jr to Jump_004_722A); when none of them branches, starts message $0793 through StartMessageCommand09HL_B04 (script command $09); that string begins 'Monsters can be good or bad.' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0793_MonstersCanBeGood::
Jump_004_7213:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_7231
    ld de, $01BC
    call TestFlagBit
    jr c, Jump_004_722A
    ld hl, $0793 ; 'Monsters can be good or bad.'
    call StartMessageCommand09HL_B04
    ret

Jump_004_722A::
    ld hl, $07C7 ; 'If a monster could be good'
    call StartMessageCommand09HL_B04
    ret

Jump_004_7231::
    ld hl, $0CE6 ; 'So there are evil masters Oh,'
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to Jump_004_7247); when none of them branches, starts message $0794 through StartMessageCommand09HL_B04 (script command $09); that string begins 'You appear to have the power' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0794_YouAppearToHave::
Jump_004_7238:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_7247
    ld hl, $0794 ; 'You appear to have the power'
    call StartMessageCommand09HL_B04
    ret

Jump_004_7247::
    ld hl, $0CE7 ; 'Controlling monsters is no easy feat,'
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 4 constant message(s) depending on story flags and state; the first one in the code is $07A4, whose string begins 'Could you humor this old man'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp0
Talk07A4_CouldYouHumorThis::
Jump_004_724E:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_72B5
    ld de, $01BE
    call TestFlagBit
    jr c, Jump_004_72AE
    ld de, $01BC
    call TestFlagBit
    jr c, Jump_004_7291
    ld de, $01B1
    call TestFlagBit
    jr c, Jump_004_7275
    ld hl, Script_6430
    call StartScriptAtHL_B04
    ret

Jump_004_7275::
    ld de, $01B2
    call TestFlagBit
    jr c, Jump_004_728A
    ld hl, $07A4 ; 'Could you humor this old man'
    call StartMessageCommand09HL_B04
    ld de, $01B2
    call SetFlagBit
    ret

Jump_004_728A::
    ld hl, $07A5 ; 'My daughter wedded a man from'
    call StartMessageCommand09HL_B04
    ret

Jump_004_7291::
    ld a, $3D
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_004_728A
    farcall RemoveInventorySlotShiftDown
    ld hl, Script_64CA
    call StartScriptAtHL_B04
    ret

Jump_004_72AE::
    ld hl, $07CE ; 'Things haven't been good for us.'
    call StartMessageCommand09HL_B04
    ret

Jump_004_72B5::
    ld hl, $0CE8 ; 'I thank you in all sincerity!'
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 3 constant message(s) depending on story flags and state; the first one in the code is $07A6, whose string begins 'Our daughter's only memento was taken'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: wGameFlags836
; writes: wGameFlags836
Talk07A6_OurDaughtersOnlyMemento::
Jump_004_72BC:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_730E
    ld de, $01BF
    call TestFlagBit
    jr c, Jump_004_7307
    ld de, $01BE
    call TestFlagBit
    jr c, Jump_004_72EA
    ld de, $01B1
    call TestFlagBit
    jr c, Jump_004_72E3
    ld hl, Script_6437
    call StartScriptAtHL_B04
    ret

Jump_004_72E3::
    ld hl, $07A6 ; 'Our daughter's only memento was taken'
    call StartMessageCommand09HL_B04
    ret

Jump_004_72EA::
    call InventoryHasFreeSlotCheck
    jr c, Jump_004_72F6
    ld hl, Script_64DC
    call StartScriptAtHL_B04
    ret

Jump_004_72F6::
    ld [hl], $0B
    ld a, [wGameFlags836]
    set 6, a
    ld [wGameFlags836], a
    ld hl, Script_64E3
    call StartScriptAtHL_B04
    ret

Jump_004_7307::
    ld hl, $07D3 ; 'We are grateful that you recovered'
    call StartMessageCommand09HL_B04
    ret

Jump_004_730E::
    ld hl, $0CE9 ; 'The atmosphere has cheered up, thanks'
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to Jump_004_7342; flag $01BE set: jr to Jump_004_733B; flag $01B1 set: jr to Jump_004_7334); when none of them branches, starts message $0799 through StartMessageCommand09HL_B04 (script command $09); that string begins 'Monsters raided this house within the' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0799_MonstersRaidedThisHouse::
Jump_004_7315:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_7342
    ld de, $01BE
    call TestFlagBit
    jr c, Jump_004_733B
    ld de, $01B1
    call TestFlagBit
    jr c, Jump_004_7334
    ld hl, $0799 ; 'Monsters raided this house within the'
    call StartMessageCommand09HL_B04
    ret

Jump_004_7334::
    ld hl, $07A7 ; 'It doesn't look like the monsters'
    call StartMessageCommand09HL_B04
    ret

Jump_004_733B::
    ld hl, $07D4 ; 'The old couple look happy after'
    call StartMessageCommand09HL_B04
    ret

Jump_004_7342::
    ld hl, $0CEA ; 'I long to have a family'
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to Jump_004_7376; flag $01BE set: jr to Jump_004_736F; flag $01B1 set: jr to Jump_004_7368); when none of them branches, starts message $079A through StartMessageCommand09HL_B04 (script command $09); that string begins 'The old people across the way' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg079A_TheOldPeopleAcross::
Jump_004_7349:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_7376
    ld de, $01BE
    call TestFlagBit
    jr c, Jump_004_736F
    ld de, $01B1
    call TestFlagBit
    jr c, Jump_004_7368
    ld hl, $079A ; 'The old people across the way'
    call StartMessageCommand09HL_B04
    ret

Jump_004_7368::
    ld hl, $07A8 ; 'The old couple across the way'
    call StartMessageCommand09HL_B04
    ret

Jump_004_736F::
    ld hl, $07D5 ; 'I'm so glad the people across'
    call StartMessageCommand09HL_B04
    ret

Jump_004_7376::
    ld hl, $0CEB ; 'Old people say that a cheerful'
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to Jump_004_739B; flag $01BC set: jr to Jump_004_7394); when none of them branches, starts message $079B through StartMessageCommand09HL_B04 (script command $09); that string begins 'Monsters have taken to attacking the' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg079B_MonstersHaveTakenTo::
Jump_004_737D:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_739B
    ld de, $01BC
    call TestFlagBit
    jr c, Jump_004_7394
    ld hl, $079B ; 'Monsters have taken to attacking the'
    call StartMessageCommand09HL_B04
    ret

Jump_004_7394::
    ld hl, $07C8 ; 'Don't you think it's odd that'
    call StartMessageCommand09HL_B04
    ret

Jump_004_739B::
    ld hl, $0CEC ; 'Monsters can be good or evil'
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to Jump_004_73C0; flag $01BC set: jr to Jump_004_73B9); when none of them branches, starts message $079C through StartMessageCommand09HL_B04 (script command $09); that string begins 'Grrrr! I'm so angry! Monsters stole' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg079C_GrrrrImSoAngry::
Jump_004_73A2:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_73C0
    ld de, $01BC
    call TestFlagBit
    jr c, Jump_004_73B9
    ld hl, $079C ; 'Grrrr! I'm so angry! Monsters stole'
    call StartMessageCommand09HL_B04
    ret

Jump_004_73B9::
    ld hl, $07C9 ; 'Arrrgh! This is so infuriating! The'
    call StartMessageCommand09HL_B04
    ret

Jump_004_73C0::
    ld hl, $0CED ; 'The thief was selling what he'
    call StartMessageCommand09HL_B04
    ret

; wD7FB = $11, wDataBank = $10, then StartScriptAtHL_B04 with HL = Data_010_643E (E-0119)
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenTableIndex, wDataBank
StartScript643EInBank10::
Jump_004_73C7:: ; address name
    ld a, $11
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_643E
    call StartScriptAtHL_B04
    ret

; map event: wCB86 = 0 if hPlayerX = $30 else 1, starts script $6445 and sets wDataBank = $10 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX
; writes: wSpriteSlots, wDataBank
StartScript6445ByPlayerX30::
Jump_004_73D8:: ; address name
    xor a, a
    ld [wSpriteSlots + $7], a
    ldh a, [hPlayerX]
    cp a, $30
    jr z, Jump_004_73E7
    ld a, $01
    ld [wSpriteSlots + $7], a

Jump_004_73E7::
    ld hl, Script_6445
    call StartScriptAtHL_B04
    ld a, $10
    ld [wDataBank], a
    ret

; tests story flags in turn (flag $01C3 set: jr to Jump_004_7411; flag $01BE set: jr to Jump_004_740A); when none of them branches, starts message $079F through StartMessageCommand09HL_B04 (script command $09); that string begins 'If you travel west along the' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg079F_IfYouTravelWest::
Jump_004_73F3:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_7411
    ld de, $01BE
    call TestFlagBit
    jr c, Jump_004_740A
    ld hl, $079F ; 'If you travel west along the'
    call StartMessageCommand09HL_B04
    ret

Jump_004_740A::
    ld hl, $07D6 ; 'What do those monsters do with'
    call StartMessageCommand09HL_B04
    ret

Jump_004_7411::
    ld hl, $0CEE ; 'It sure was a thrilling time'
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 3 constant message(s) depending on story flags and state; the first one in the code is $07D7, whose string begins 'Milayou I e been checking around,'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
Talk07D7_MilayouIEBeen::
Jump_004_7418:: ; address name
    ld de, $01C5
    call TestFlagBit
    jr c, Jump_004_7481
    ld de, $01C4
    call TestFlagBit
    jr c, Jump_004_747A
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_7473
    ld de, $01C1
    call TestFlagBit
    jr c, Jump_004_746C
    ld de, $01C0
    call TestFlagBit
    jr c, Jump_004_7465
    ld de, $01BE
    call TestFlagBit
    jr c, Jump_004_745E
    ld de, $01B0
    call TestFlagBit
    jr c, Jump_004_7457
    ld hl, Script_644C
    call StartScriptAtHL_B04
    ret

Jump_004_7457::
    ld hl, Script_6469
    call StartScriptAtHL_B04
    ret

Jump_004_745E::
    ld hl, $07D7 ; 'Milayou I e been checking around,'
    call StartMessageCommand09HL_B04
    ret

Jump_004_7465::
    ld hl, Script_6501
    call StartScriptAtHL_B04
    ret

Jump_004_746C::
    ld hl, $07DD ; 'Milayou Please defeat the dark master'
    call StartMessageCommand09HL_B04
    ret

Jump_004_7473::
    ld hl, Script_654C
    call StartScriptAtHL_B04
    ret

Jump_004_747A::
    ld hl, $0CF1 ; 'Milayou You e inspired me to'
    call StartMessageCommand09HL_B04
    ret

Jump_004_7481::
    ld de, $01C6
    call TestFlagBit
    jr c, Jump_004_7490
    ld hl, Script_6558
    call StartScriptAtHL_B04
    ret

Jump_004_7490::
    ld hl, Script_6578
    call StartScriptAtHL_B04
    ret

; starts message $07A9 through StartMessageCommand09HL (script command $09); that string begins 'This is the traveler's hut. Stay and' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case40)
; no direct call (reached through a table, a jump or a vector)
TalkMsg07A9_ThisIsTheTravelersHutStay::
Jump_004_7497:: ; address name
    ld hl, $07A9 ; 'This is the traveler's hut. Stay'
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to Jump_004_74CB; flag $01BE set: jr to Jump_004_74C4; flag $01BB set: jr to Jump_004_74BD); when none of them branches, starts message $07AA through StartMessageCommand09HL_B04 (script command $09); that string begins 'That dealer, how expensive! Nobody can' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg07AA_ThatDealerHowExpensive::
Jump_004_749E:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_74CB
    ld de, $01BE
    call TestFlagBit
    jr c, Jump_004_74C4
    ld de, $01BB
    call TestFlagBit
    jr c, Jump_004_74BD
    ld hl, $07AA ; 'That dealer, how expensive! Nobody can'
    call StartMessageCommand09HL_B04
    ret

Jump_004_74BD::
    ld hl, $07C0 ; 'I dug deep in my purse'
    call StartMessageCommand09HL_B04
    ret

Jump_004_74C4::
    ld hl, $07D8 ; 'I dug deep in my purse'
    call StartMessageCommand09HL_B04
    ret

Jump_004_74CB::
    ld hl, $0CF2 ; 'That merchant, he was a thief.'
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 3 constant message(s) depending on story flags and state; the first one in the code is $07C1, whose string begins 'What? Monsters attacked you in the'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
Talk07C1_WhatMonstersAttackedYou::
Jump_004_74D2:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_74FF
    ld de, $01BE
    call TestFlagBit
    jr c, Jump_004_74F8
    ld de, $01BB
    call TestFlagBit
    jr c, Jump_004_74F1
    ld hl, Script_6481
    call StartScriptAtHL_B04
    ret

Jump_004_74F1::
    ld hl, $07C1 ; 'What? Monsters attacked you in the'
    call StartMessageCommand09HL_B04
    ret

Jump_004_74F8::
    ld hl, $07D9 ; 'The thieving monsters had a boss,'
    call StartMessageCommand09HL_B04
    ret

Jump_004_74FF::
    ld hl, $0CF3 ; 'People say you can't judge people'
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to Jump_004_7533; flag $01C0 set: jr to Jump_004_752C; flag $01BB set: jr to Jump_004_7525); when none of them branches, starts message $07AE through StartMessageCommand09HL_B04 (script command $09); that string begins 'That dealer's wares Could he sell' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg07AE_ThatDealersWaresCould::
Jump_004_7506:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_7533
    ld de, $01C0
    call TestFlagBit
    jr c, Jump_004_752C
    ld de, $01BB
    call TestFlagBit
    jr c, Jump_004_7525
    ld hl, $07AE ; 'That dealer's wares Could he sell'
    call StartMessageCommand09HL_B04
    ret

Jump_004_7525::
    ld hl, $07C2 ; 'That dealer is a greedy hound!'
    call StartMessageCommand09HL_B04
    ret

Jump_004_752C::
    ld hl, $07DB ; 'That greedhound dealer scuttled off in'
    call StartMessageCommand09HL_B04
    ret

Jump_004_7533::
    ld hl, $0CF4 ; 'That greedy hound of a dealer'
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 8 constant message(s) depending on story flags and state; the first one in the code is $07AF, whose string begins 'How does this ornament look? Take'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags
; writes: wStoryFlags
Talk07AF_HowDoesThisOrnament::
Jump_004_753A:: ; address name
    ld de, $01BE
    call TestFlagBit
    jp c, Jump_004_75FF
    ld de, $01BD
    call TestFlagBit
    jp c, Jump_004_75F8
    ld de, $01BB
    call TestFlagBit
    jp c, Jump_004_75F1
    ld de, $01B1
    call TestFlagBit
    jr c, Jump_004_75A3
    ld de, $01B3
    call TestFlagBit
    jr c, Jump_004_7572
    ld hl, $07AF ; 'How does this ornament look? Take'
    call StartMessageCommand09HL_B04
    ld de, $01B3
    call SetFlagBit
    ret

Jump_004_7572::
    ld de, $01B4
    call TestFlagBit
    jr c, Jump_004_7587
    ld hl, $07B0 ; 'How does this jewelry look? It's'
    call StartMessageCommand09HL_B04
    ld de, $01B4
    call SetFlagBit
    ret

Jump_004_7587::
    ld de, $01B5
    call TestFlagBit
    jr c, Jump_004_759C
    ld hl, $07B1 ; 'How does this grand vase look?'
    call StartMessageCommand09HL_B04
    ld de, $01B5
    call SetFlagBit
    ret

Jump_004_759C::
    ld hl, $07B2 ; 'I e no use for the'
    call StartMessageCommand09HL_B04
    ret

Jump_004_75A3::
    ld de, $01B6
    call TestFlagBit
    jr c, Jump_004_75B8
    ld hl, $07B3 ; 'How does this ornament look? Take'
    call StartMessageCommand09HL_B04
    ld de, $01B6
    call SetFlagBit
    ret

Jump_004_75B8::
    ld de, $01B7
    call TestFlagBit
    jr c, Jump_004_75CD
    ld hl, $07B4 ; 'How does this jewelry look? It's'
    call StartMessageCommand09HL_B04
    ld de, $01B7
    call SetFlagBit
    ret

Jump_004_75CD::
    ld de, $01B8
    call TestFlagBit
    jr c, Jump_004_75E2
    ld hl, $07B5 ; 'How does this grand vase look?'
    call StartMessageCommand09HL_B04
    ld de, $01B8
    call SetFlagBit
    ret

Jump_004_75E2::
    ld de, $01B9
    call TestFlagBit
    jr c, Jump_004_759C
    ld hl, Script_648E
    call StartScriptAtHL_B04
    ret

Jump_004_75F1::
    ld hl, Script_64BE
    call StartScriptAtHL_B04
    ret

Jump_004_75F8::
    ld hl, $07C5 ; 'You defeated the monsters You're not'
    call StartMessageCommand09HL_B04
    ret

Jump_004_75FF::
    ld hl, Script_64ED
    call StartScriptAtHL_B04
    ld a, [wStoryFlags + $68]
    set 0, a
    ld [wStoryFlags + $68], a
    ret

; tests story flags in turn (flag $01BA set: jr to Jump_004_761D); when none of them branches, starts message $07B8 through StartMessageCommand09HL_B04 (script command $09); that string begins 'Who are you? You shouldn't be' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg07B8_WhoAreYou::
Jump_004_760E:: ; address name
    ld de, $01BA
    call TestFlagBit
    jr c, Jump_004_761D
    ld hl, $07B8 ; 'Who are you? You shouldn't be'
    call StartMessageCommand09HL_B04
    ret

Jump_004_761D::
    ld hl, $07BA ; 'What, not you again!'
    call StartMessageCommand09HL_B04
    ret

; map event: starts script $64A6 if story flag $1BA is set, else $6496 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; starts Script_6496: 'You're going to regret seeing us.'
StartScript6496Or64A6ByFlag1BA::
Jump_004_7624:: ; address name
    ld de, $01BA
    call TestFlagBit
    jr c, Jump_004_7633
    ld hl, Script_6496
    call StartScriptAtHL_B04
    ret

Jump_004_7633::
    ld hl, Script_64A6
    call StartScriptAtHL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1 constant message(s) depending on story flags and state; the first one in the code is $07BF, whose string begins '0 found the Pretty Ring. But'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: wGameFlags836
; writes: wGameFlags836
Talk07BF_HeroFoundThePretty::
Jump_004_763A:: ; address name
    call InventoryHasFreeSlotCheck
    jr c, Jump_004_7646
    ld hl, $07BF ; '0 found the Pretty Ring. But'
    call StartMessageCommand09HL_B04
    ret

Jump_004_7646::
    ld [hl], $3D
    ld a, [wGameFlags836]
    set 6, a
    ld [wGameFlags836], a
    ld hl, Script_64B3
    call StartScriptAtHL_B04
    ret

; map event: starts script $652C if story flag $1C2 is set, else $6509 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; starts Script_6509: 'What is it, you little brat?'
StartScript6509Or652CByFlag1C2::
Jump_004_7657:: ; address name
    ld de, $01C2
    call TestFlagBit
    jr c, Jump_004_7666
    ld hl, Script_6509
    call StartScriptAtHL_B04
    ret

Jump_004_7666::
    ld hl, Script_652C
    call StartScriptAtHL_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $0E, story flag $01C8 in DE: when the flag is clear it gives item $0E (DEFseed) and sets the flag (message $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was Msg01C8_ThisIsAGreat)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
VaseItem_DEFseed::
Jump_004_766D:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $0E
    ld [wScriptParam1], a
    ld de, $01C8
    call StartTreasureFlagDE_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $2C, story flag $01C9 in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the flag (message $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was Msg01C9_ThisIsAGreat)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
VaseItem_TinyMedal_Flag01C9::
Jump_004_767E:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2C
    ld [wScriptParam1], a
    ld de, $01C9
    call StartTreasureFlagDE_B04
    ret

; starts message $0CFB through StartMessageCommand09HL (script command $09); that string begins '0 tried to open the chest. But' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case4B)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0CFB_HeroTriedToOpenTheChest::
Jump_004_768F:: ; address name
    ld hl, $0CFB ; '0 tried to open the chest.'
    call StartMessageCommand09HL_B04
    ret

; starts message $0CFA through StartMessageCommand09HL (script command $09); that string begins '0 peered into the oven. A tantalizing' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case4C)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0CFA_HeroPeeredIntoTheOvenA::
Jump_004_7696:: ; address name
    ld hl, $0CFA ; '0 peered into the oven. A'
    call StartMessageCommand09HL_B04
    ret

; starts message $0CFC through StartMessageCommand09HL (script command $09); that string begins '0 peered into the vase. Cold water' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case4D)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0CFC_HeroPeeredIntoTheVaseCold::
Jump_004_769D:: ; address name
    ld hl, $0CFC ; '0 peered into the vase. Cold'
    call StartMessageCommand09HL_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $04, story flag $01CA in DE: when the flag is clear it gives item $04 (Potion) and sets the flag (message $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was DispatchTalkEvent_Case07_Sub01_Case4E)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
VaseItem_Potion_Flag01CA::
Jump_004_76A4:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $04
    ld [wScriptParam1], a
    ld de, $01CA
    call StartTreasureFlagDE_B04
    ret

; starts message $0CFD through StartMessageCommand09HL (script command $09); that string begins '0 peered into the oven. Meat sizzled' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case4F)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0CFD_HeroPeeredIntoTheOvenMeat::
Jump_004_76B5:: ; address name
    ld hl, $0CFD ; '0 peered into the oven. Meat'
    call StartMessageCommand09HL_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $08, story flag $01CB in DE: when the flag is clear it gives item $08 (Laurel) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg01CB_ThisIsAGreat)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_Laurel::
Jump_004_76BC:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $08
    ld [wScriptParam1], a
    ld de, $01CB
    call StartTreasureFlagDE_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to Jump_004_76DC); when none of them branches, starts message $0CFE through StartMessageCommand09HL_B04 (script command $09); that string is empty (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0CFE::
Jump_004_76CD:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_76DC
    ld hl, $0CFE ; '0 opened the treasure chest. It'
    call StartMessageCommand09HL_B04
    ret

Jump_004_76DC::
    ld hl, $00A1 ; '0 checked the treasure chest. But'
    call StartMessageCommand09HL_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $2A, story flag $01CC in DE: when the flag is clear it gives item $2A (ExitBell) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg01CC_ThisIsAGreat)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_ExitBell_Flag01CC::
Jump_004_76E3:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2A
    ld [wScriptParam1], a
    ld de, $01CC
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $2C, story flag $01CD in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg01CD_ThisIsAGreat)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_TinyMedal::
Jump_004_76F4:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2C
    ld [wScriptParam1], a
    ld de, $01CD
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $23, story flag $01CE in DE: when the flag is clear it gives item $23 (Friend) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg01CE_ThisIsAGreat)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_Friend::
Jump_004_7705:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $23
    ld [wScriptParam1], a
    ld de, $01CE
    call StartTreasureFlagDE_B04
    ret

; starts Script_6595 (StartScriptAtHL); its first message begins '0 checked the treasure chest. The' (E-0271; was DispatchTalkEvent_Case07_Sub01_Case55)
; no direct call (reached through a table, a jump or a vector)
; starts Script_6595: '0 checked the treasure chest. The'
TalkScript6595_HeroCheckedTheTreasureChest::
Jump_004_7716:: ; address name
    ld hl, Script_6595
    call StartScriptAtHL_B04
    ret

; starts message $0C03 through StartMessageCommand09HL (script command $09); that string begins 'The Tower's many treasures are heavily guarded' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case60)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0C03_TheTowersManyTreasuresAre::
Jump_004_771D:: ; address name
    ld hl, $0C03 ; 'The Tower's many treasures are heavily'
    call StartMessageCommand09HL_B04
    ret

; starts message $0C02 through StartMessageCommand09HL (script command $09); that string begins 'Only a handful of masters have made' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case61)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0C02_OnlyAHandfulOfMastersHave::
Jump_004_7724:: ; address name
    ld hl, $0C02 ; 'Only a handful of masters have'
    call StartMessageCommand09HL_B04
    ret

; entry 98 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case07_Sub01_Case62::
Jump_004_772B:: ; address name
    ld de, $01D3
    call TestFlagBit
    jr c, Jump_004_7740
    ld hl, $0C00 ; 'This is the Power Tower. Are'
    call StartMessageCommand09HL_B04
    ld de, $01D3
    call SetFlagBit
    ret

Jump_004_7740::
    ld hl, $0C01 ; 'If you win, you'll earn many'
    call StartMessageCommand09HL_B04
    ret

; starts Script_659C (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case07_Sub01_Case63)
; no direct call (reached through a table, a jump or a vector)
; starts Script_659C
TalkScript659C::
Jump_004_7747:: ; address name
    ld hl, Script_659C
    call StartScriptAtHL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1 constant message(s) depending on story flags and state; the first one in the code is $0C17, an empty string on the normal path; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; starts Script_659C
Talk0C17::
Jump_004_774E:: ; address name
    ld de, $016E
    call TestFlagBit
    jr c, Jump_004_775D
    ld hl, Script_659C
    call StartScriptAtHL_B04
    ret

Jump_004_775D::
    ld hl, $0C17 ; 'You e conquered the Power Tower.'
    call StartMessageCommand09HL_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $2C, story flag $01D5 in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg01D5)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_TinyMedal_Flag01D5::
Jump_004_7764:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2C
    ld [wScriptParam1], a
    ld de, $01D5
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $48, story flag $01D6 in DE: when the flag is clear it gives item $48 (AGL) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg01D6)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_AGL_Flag01D6::
Jump_004_7775:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $48
    ld [wScriptParam1], a
    ld de, $01D6
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $0A, story flag $01D8 in DE: when the flag is clear it gives item $0A (SkyBell) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg01D8)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_SkyBell::
Jump_004_7786:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $0A
    ld [wScriptParam1], a
    ld de, $01D8
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $01, story flag $01DA in DE: when the flag is clear it gives item $01 (Herb) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg01DA)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_Herb::
Jump_004_7797:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $01DA
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $51, story flag $01DB in DE: when the flag is clear it gives item $51 (OrcaCape) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg01DB)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_OrcaCape_Flag01DB::
Jump_004_77A8:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $51
    ld [wScriptParam1], a
    ld de, $01DB
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $02, story flag $01DC in DE: when the flag is clear it gives item $02 (LoveWater) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg01DC)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_LoveWater_Flag01DC::
Jump_004_77B9:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $02
    ld [wScriptParam1], a
    ld de, $01DC
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $02, story flag $01DE in DE: when the flag is clear it gives item $02 (LoveWater) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg01DE)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_LoveWater_Flag01DE::
Jump_004_77CA:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $02
    ld [wScriptParam1], a
    ld de, $01DE
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $44, story flag $01DF in DE: when the flag is clear it gives item $44 (StoneFang) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg01DF)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_StoneFang::
Jump_004_77DB:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $44
    ld [wScriptParam1], a
    ld de, $01DF
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $01, story flag $0169 in DE: when the flag is clear it gives item $01 (Herb) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg0169_WereWorriedAboutThe)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_Herb_Flag0169::
Jump_004_77EC:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $0169
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $02, story flag $016B in DE: when the flag is clear it gives item $02 (LoveWater) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg016B_TheKingIsSo)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_LoveWater_Flag016B::
Jump_004_77FD:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $02
    ld [wScriptParam1], a
    ld de, $016B
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $5F, story flag $016C in DE: when the flag is clear it gives item $5F (Sailor) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg016C_SoHaveYouDiscovered)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_Sailor::
Jump_004_780E:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5F
    ld [wScriptParam1], a
    ld de, $016C
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $4E, story flag $016D in DE: when the flag is clear it gives item $4E (SilvrCape) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg016D_KingTheCanalIs)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_SilvrCape::
Jump_004_781F:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $4E
    ld [wScriptParam1], a
    ld de, $016D
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $4C, story flag $016F in DE: when the flag is clear it gives item $4C (MagicCape) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg016F_KingWhatNeverMind)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_MagicCape::
Jump_004_7830:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $4C
    ld [wScriptParam1], a
    ld de, $016F
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $4D, story flag $0170 in DE: when the flag is clear it gives item $4D (DracoCape) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg0170_IFeelBadlyFor)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_DracoCape::
Jump_004_7841:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $4D
    ld [wScriptParam1], a
    ld de, $0170
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $01, story flag $0171 in DE: when the flag is clear it gives item $01 (Herb) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg0171_WhatOpenTheCanal)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_Herb_Flag0171::
Jump_004_7852:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $0171
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $2C, story flag $0172 in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg0172_KingArrghIKnow)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_TinyMedal_Flag0172::
Jump_004_7863:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2C
    ld [wScriptParam1], a
    ld de, $0172
    call StartTreasureFlagDE_B04
    ret

; starts Script_659E (StartScriptAtHL); its first message begins '0 checked the treasure chest. It' (E-0271; was DispatchTalkEvent_Case07_Sub01_Case78)
; no direct call (reached through a table, a jump or a vector)
; starts Script_659E: '0 checked the treasure chest. It'
TalkScript659E_HeroCheckedTheTreasureChest::
Jump_004_7874:: ; address name
    ld hl, Script_659E
    call StartScriptAtHL_B04
    ret

; starts message $0C1B through StartMessageCommand09HL (script command $09); that string begins 'It's not that easy to win here' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case80)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0C1B_ItsNotThatEasyToWin::
Jump_004_787B:: ; address name
    ld hl, $0C1B ; 'It's not that easy to win'
    call StartMessageCommand09HL_B04
    ret

; starts message $0C1A through StartMessageCommand09HL (script command $09); that string begins 'In this Tower, your opponents come at' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case81)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0C1A_InThisTowerYourOpponents::
Jump_004_7882:: ; address name
    ld hl, $0C1A ; 'In this Tower, your opponents come'
    call StartMessageCommand09HL_B04
    ret

; entry 130 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case07_Sub01_Case82::
Jump_004_7889:: ; address name
    ld de, $0173
    call TestFlagBit
    jr c, Jump_004_789E
    ld hl, $0C18 ; 'This is the Baffle Tower. Are'
    call StartMessageCommand09HL_B04
    ld de, $0173
    call SetFlagBit
    ret

Jump_004_789E::
    ld hl, $0C19 ; 'If you win, you'll earn many'
    call StartMessageCommand09HL_B04
    ret

; starts Script_659C (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case07_Sub01_Case83)
; no direct call (reached through a table, a jump or a vector)
; starts Script_659C
TalkScript659C_0478A5::
Jump_004_78A5:: ; address name
    ld hl, Script_659C
    call StartScriptAtHL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1 constant message(s) depending on story flags and state; the first one in the code is $0C2F, an empty string on the normal path; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; starts Script_659C
Talk0C2F::
Jump_004_78AC:: ; address name
    ld de, $00D9
    call TestFlagBit
    jr c, Jump_004_78BB
    ld hl, Script_659C
    call StartScriptAtHL_B04
    ret

Jump_004_78BB::
    ld hl, $0C2F ; 'You e conquered the Baffle Tower.'
    call StartMessageCommand09HL_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $0A, story flag $0175 in DE: when the flag is clear it gives item $0A (SkyBell) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg0175_ImMakingANew)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_SkyBell_Flag0175::
Jump_004_78C2:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $0A
    ld [wScriptParam1], a
    ld de, $0175
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $4A, story flag $0176 in DE: when the flag is clear it gives item $4A (Smart) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg0176_GaahYoureTooStrong)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_Smart::
Jump_004_78D3:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $4A
    ld [wScriptParam1], a
    ld de, $0176
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $2A, story flag $0177 in DE: when the flag is clear it gives item $2A (ExitBell) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg0177_KingWhatSoThats)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_ExitBell_Flag0177::
Jump_004_78E4:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2A
    ld [wScriptParam1], a
    ld de, $0177
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $01, story flag $0179 in DE: when the flag is clear it gives item $01 (Herb) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg0179_KingThisShouldSolve)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_Herb_Flag0179::
Jump_004_78F5:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $0179
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $09, story flag $017A in DE: when the flag is clear it gives item $09 (AwakeSand) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg017A_OhYouSayThat)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_AwakeSand::
Jump_004_7906:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $09
    ld [wScriptParam1], a
    ld de, $017A
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $61, story flag $017B in DE: when the flag is clear it gives item $61 (Cleric) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg017B_TheWellHasAmple)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_Cleric::
Jump_004_7917:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $61
    ld [wScriptParam1], a
    ld de, $017B
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $2A, story flag $017D in DE: when the flag is clear it gives item $2A (ExitBell) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg017D_HiDidYouHear)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_ExitBell_Flag017D::
Jump_004_7928:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2A
    ld [wScriptParam1], a
    ld de, $017D
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $52, story flag $017E in DE: when the flag is clear it gives item $52 (BraveCape) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg017E_TheKingSolvedOur)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_BraveCape::
Jump_004_7939:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $52
    ld [wScriptParam1], a
    ld de, $017E
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $07, story flag $017F in DE: when the flag is clear it gives item $07 (MoonHerb) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg017F_OurKingWorkedTo)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_MoonHerb::
Jump_004_794A:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $07
    ld [wScriptParam1], a
    ld de, $017F
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $46, story flag $00D6 in DE: when the flag is clear it gives item $46 (MermScale) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg00D6_IllShowYouHow)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_MermScale_Flag00D6::
Jump_004_795B:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $46
    ld [wScriptParam1], a
    ld de, $00D6
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $02, story flag $00D7 in DE: when the flag is clear it gives item $02 (LoveWater) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg00D7_HmMyRivalIs)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_LoveWater_Flag00D7::
Jump_004_796C:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $02
    ld [wScriptParam1], a
    ld de, $00D7
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $60, story flag $00D8 in DE: when the flag is clear it gives item $60 (Thief) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg00D8_FinallySomeoneToIgnite)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_Thief::
Jump_004_797D:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $60
    ld [wScriptParam1], a
    ld de, $00D8
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $01, story flag $00DA in DE: when the flag is clear it gives item $01 (Herb) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg00DA_YouHaveRaisedYour)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_Herb_Flag00DA::
Jump_004_798E:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $00DA
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $4F, story flag $00DB in DE: when the flag is clear it gives item $4F (GoldCape) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg00DB_WhatHowDidYou)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_GoldCape::
Jump_004_799F:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $4F
    ld [wScriptParam1], a
    ld de, $00DB
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $5D, story flag $00DC in DE: when the flag is clear it gives item $5D (Mage) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg00DC_AllThoseWhoStood)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_Mage::
Jump_004_79B0:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5D
    ld [wScriptParam1], a
    ld de, $00DC
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $06, story flag $00DD in DE: when the flag is clear it gives item $06 (Antidote) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg00DD_LetMeShowYou)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_Antidote::
Jump_004_79C1:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $06
    ld [wScriptParam1], a
    ld de, $00DD
    call StartTreasureFlagDE_B04
    ret

; starts message $0C33 through StartMessageCommand09HL (script command $09); that string begins 'It's brutal up ahead. I wouldn't push' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_CaseA0)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0C33_ItsBrutalUpAheadIWouldnt::
Jump_004_79D2:: ; address name
    ld hl, $0C33 ; 'It's brutal up ahead. I wouldn't'
    call StartMessageCommand09HL_B04
    ret

; starts message $0C32 through StartMessageCommand09HL (script command $09); that string begins 'The monsters here are awful. I'm losing' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_CaseA1)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0C32_TheMonstersHereAreAwfulIm::
Jump_004_79D9:: ; address name
    ld hl, $0C32 ; 'The monsters here are awful. I'm'
    call StartMessageCommand09HL_B04
    ret

; entry 162 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
DispatchTalkEvent_Case07_Sub01_CaseA2::
Jump_004_79E0:: ; address name
    ld de, $00DE
    call TestFlagBit
    jr c, Jump_004_79F5
    ld hl, $0C30 ; 'If you e made it to'
    call StartMessageCommand09HL_B04
    ld de, $00DE
    call SetFlagBit
    ret

Jump_004_79F5::
    ld hl, $0C31 ; 'This Tower is terribly tough. I'
    call StartMessageCommand09HL_B04
    ret

; starts Script_659C (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case07_Sub01_CaseA3)
; no direct call (reached through a table, a jump or a vector)
; starts Script_659C
TalkScript659C_0479FC::
Jump_004_79FC:: ; address name
    ld hl, Script_659C
    call StartScriptAtHL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1 constant message(s) depending on story flags and state; the first one in the code is $0C47, an empty string on the normal path; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; starts Script_659C
Talk0C47::
Jump_004_7A03:: ; address name
    ld de, $01F6
    call TestFlagBit
    jr c, Jump_004_7A12
    ld hl, Script_659C
    call StartScriptAtHL_B04
    ret

Jump_004_7A12::
    ld hl, $0C47 ; 'You e conquered the Soul Tower.'
    call StartMessageCommand09HL_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $2A, story flag $00F5 in DE: when the flag is clear it gives item $2A (ExitBell) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg00F5_ItIsAnItem)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_ExitBell_Flag00F5::
Jump_004_7A19:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2A
    ld [wScriptParam1], a
    ld de, $00F5
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $5C, story flag $00F6 in DE: when the flag is clear it gives item $5C (War) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg00F6_HelloWhatCanI)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_War_Flag00F6::
Jump_004_7A2A:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5C
    ld [wScriptParam1], a
    ld de, $00F6
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $03, story flag $00F7 in DE: when the flag is clear it gives item $03 (WorldDew) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg00F7_HelloWhatCanI)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_WorldDew_Flag00F7::
Jump_004_7A3B:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $03
    ld [wScriptParam1], a
    ld de, $00F7
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $2C, story flag $00F9 in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg00F9_HelloWhatCanI)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_TinyMedal_Flag00F9::
Jump_004_7A4C:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2C
    ld [wScriptParam1], a
    ld de, $00F9
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $45, story flag $00FA in DE: when the flag is clear it gives item $45 (SteelFang) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg00FA_HelloWhatCanI)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_SteelFang::
Jump_004_7A5D:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $45
    ld [wScriptParam1], a
    ld de, $00FA
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $47, story flag $00FB in DE: when the flag is clear it gives item $47 (DrakScale) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg00FB_THEEND)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_DrakScale::
Jump_004_7A6E:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $47
    ld [wScriptParam1], a
    ld de, $00FB
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $5A, story flag $00FD in DE: when the flag is clear it gives item $5A (Life) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg00FD_HeyThatsMine0)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_Life::
Jump_004_7A7F:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5A
    ld [wScriptParam1], a
    ld de, $00FD
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $5B, story flag $00FE in DE: when the flag is clear it gives item $5B (Divine) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg00FE_TerryHereJustTake)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_Divine::
Jump_004_7A90:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5B
    ld [wScriptParam1], a
    ld de, $00FE
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $01, story flag $00FF in DE: when the flag is clear it gives item $01 (Herb) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg00FF_Composing)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_Herb_Flag00FF::
Jump_004_7AA1:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $00FF
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $50, story flag $01F3 in DE: when the flag is clear it gives item $50 (PltnmCape) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg01F3)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_PltnmCape::
Jump_004_7AB2:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $50
    ld [wScriptParam1], a
    ld de, $01F3
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $4B, story flag $01F4 in DE: when the flag is clear it gives item $4B (Wise) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg01F4)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_Wise::
Jump_004_7AC3:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $4B
    ld [wScriptParam1], a
    ld de, $01F4
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $2A, story flag $01F5 in DE: when the flag is clear it gives item $2A (ExitBell) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg01F5)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_ExitBell_Flag01F5::
Jump_004_7AD4:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2A
    ld [wScriptParam1], a
    ld de, $01F5
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $01, story flag $01F7 in DE: when the flag is clear it gives item $01 (Herb) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg01F7)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_Herb_Flag01F7::
Jump_004_7AE5:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $01F7
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $5E, story flag $01F8 in DE: when the flag is clear it gives item $5E (Fight) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg01F8)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_Fight::
Jump_004_7AF6:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5E
    ld [wScriptParam1], a
    ld de, $01F8
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $49, story flag $01F9 in DE: when the flag is clear it gives item $49 (Starry) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg01F9)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_Starry::
Jump_004_7B07:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $49
    ld [wScriptParam1], a
    ld de, $01F9
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 = $02, story flag $01FA in DE: when the flag is clear it gives item $02 (LoveWater) and sets the flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was Msg01FA)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
ChestItem_LoveWater_Flag01FA::
Jump_004_7B18:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $02
    ld [wScriptParam1], a
    ld de, $01FA
    call StartTreasureFlagDE_B04
    ret

; only called from DispatchTalkEvent_Case09 (E-0047)
; 1 call site from 1 routine (e.g. DispatchTalkEvent_Case09)
; reads: wTalkEventGroup
DispatchTalkEvent_Case09_Sub01::
Func_004_7B29:: ; address name
    ld a, [wTalkEventGroup]
    rst $00
    dw TalkScript5133
    dw DispatchTalkEvent_Case09_Sub01_Case01
    dw DispatchTalkEvent_Case09_Sub01_Case02
    dw TalkScript5135
    dw TalkMsg0120_WarubouQuitDawdlingWarooh
    dw TalkMsg0122_WarubouWaheyYouDidItHero
    dw DispatchTalkEvent_Case09_Sub01_Case06
    dw TalkScript65AA_WarubouWaheyYouDidItHero
    dw TalkScript65B8_WarubouWaheySoThisIsIt

; starts Script_5133 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case09_Sub01_Case00)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5133
TalkScript5133::
Jump_004_7B3F:: ; address name
    ld hl, Script_5133
    call StartScriptAtHL_B04
    ret

; entry 1 of the `rst $00` table in Func_004_7B29
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldFloor
; writes: wDataBank, wScreenTableIndex
; points at: wKeyWorldFloorState
DispatchTalkEvent_Case09_Sub01_Case01::
Jump_004_7B46:: ; address name
    ld a, $10
    ld [wDataBank], a
    ld a, [wKeyWorldFloor]
    add a, a
    add a, a
    push af
    ld hl, wKeyWorldFloorInfo + $1
    add_a_to_hl
    ld a, [hl]
    cp a, $03
    jr nz, Jump_004_7B6B
    pop af
    ld a, $0F
    ld [wScreenTableIndex], a
    ld hl, Script_65A3
    call StartScriptAtHL_B04
    ret

Jump_004_7B6B::
    pop af
    add a, a
    ld hl, wKeyWorldFloorState
    ld a, $12
    bit 7, [hl]
    jr z, Jump_004_7B78
    ld a, $13

Jump_004_7B78::
    ld [wScreenTableIndex], a
    ld hl, Script_65A3
    call StartScriptAtHL_B04
    ret

; entry 2 of the `rst $00` table in Func_004_7B29
; no direct call (reached through a table, a jump or a vector)
; reads: wMapType, hPlayerFacing
; writes: wSpriteSlots, wDataBank
; starts Script_65AA: 'Warubou Wa-hey! You did it, 0!'
DispatchTalkEvent_Case09_Sub01_Case02::
Jump_004_7B82:: ; address name
    ld a, [wMapType]
    cp a, $84
    jr nz, Jump_004_7B91
    ld hl, Script_65AA
    call StartScriptAtHL_B04
    jr Jump_004_7B9C

Jump_004_7B91::
    call IsPlayerAtKeyWorldGoalKindTriggerColumn
    or a, a
    ret z
    ld hl, Script_65B1
    call StartScriptAtHL_B04

Jump_004_7B9C::
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and a, $03
    ld [wSpriteSlots + $7], a
    ld a, $10
    ld [wDataBank], a
    ret

; A = 1 when the player stands on one of the trigger columns for wCD0B (1, 7, 8 or 9) on the matching map screen, else 0 (E-0127)
; 1 call site from 1 routine (e.g. DispatchTalkEvent_Case09_Sub01_Case02)
; reads: wKeyWorldGoalKind, hMapScreenX, hPlayerX
IsPlayerAtKeyWorldGoalKindTriggerColumn::
Func_004_7BAB:: ; address name
    ld a, [wKeyWorldGoalKind]
    cp a, $01
    jr nz, Jump_004_7BC3
    ldh a, [hMapScreenX]
    or a, a
    jr nz, Jump_004_7BF5
    ldh a, [hPlayerX]
    cp a, $40
    jr z, Jump_004_7BF2
    cp a, $20
    jr z, Jump_004_7BF2
    jr Jump_004_7BF5

Jump_004_7BC3::
    cp a, $07
    jr nz, Jump_004_7BD4
    ldh a, [hMapScreenX]
    or a, a
    jr nz, Jump_004_7BF5
    ldh a, [hPlayerX]
    cp a, $40
    jr z, Jump_004_7BF2
    jr Jump_004_7BF5

Jump_004_7BD4::
    cp a, $08
    jr nz, Jump_004_7BE9
    ldh a, [hMapScreenX]
    or a, a
    jr nz, Jump_004_7BF5
    ldh a, [hPlayerX]
    cp a, $10
    jr z, Jump_004_7BF2
    cp a, $30
    jr z, Jump_004_7BF2
    jr Jump_004_7BF5

Jump_004_7BE9::
    cp a, $09
    jr nz, Jump_004_7BF5
    ldh a, [hMapScreenX]
    or a, a
    jr z, Jump_004_7BF5

Jump_004_7BF2::
    ld a, $01
    ret

Jump_004_7BF5::
    xor a, a
    ret

; starts Script_5135 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case09_Sub01_Case03)
; no direct call (reached through a table, a jump or a vector)
; starts Script_5135
TalkScript5135::
Jump_004_7BF7:: ; address name
    ld hl, Script_5135
    call StartScriptAtHL_B04
    ret

; starts message $0120 through StartMessageCommand09HL (script command $09); that string begins 'Warubou Quit dawdling, warooh!' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case09_Sub01_Case04)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0120_WarubouQuitDawdlingWarooh::
Jump_004_7BFE:: ; address name
    ld hl, $0120 ; 'Warubou Quit dawdling, warooh!'
    call StartMessageCommand09HL_B04
    ret

; starts message $0122 through StartMessageCommand09HL (script command $09); that string begins 'Warubou Wa-hey! You did it, 0! I'll' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case09_Sub01_Case05)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0122_WarubouWaheyYouDidItHero::
Jump_004_7C05:: ; address name
    ld hl, $0122 ; 'Warubou Wa-hey! You did it, 0!'
    call StartMessageCommand09HL_B04
    ret

; entry 6 of the `rst $00` table in Func_004_7B29
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldGoalKind
DispatchTalkEvent_Case09_Sub01_Case06::
Jump_004_7C0C:: ; address name
    ld a, [wKeyWorldGoalKind]
    cp a, $05
    ret z
    cp a, $07
    ret z
    cp a, $08
    ret z
    ld hl, $0121 ; 'Warubou Use a Magic Key and'
    call StartMessageCommand09HL_B04
    ret

; sets wDataBank = $10, then starts Script_65AA (StartScriptAtHL); its first message begins 'Warubou Wa-hey! You did it, 0!' (E-0271; was DispatchTalkEvent_Case09_Sub01_Case07)
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
; starts Script_65AA: 'Warubou Wa-hey! You did it, 0!'
TalkScript65AA_WarubouWaheyYouDidItHero::
Jump_004_7C1F:: ; address name
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_65AA
    call StartScriptAtHL_B04
    ret

; sets wDataBank = $1F, then starts Script_65B8 (StartScriptAtHL); its first message begins 'Warubou Wa-hey! So, this is it?' (E-0271; was DispatchTalkEvent_Case09_Sub01_Case08)
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
; starts Script_65B8: 'Warubou Wa-hey! So, this is it?'
TalkScript65B8_WarubouWaheySoThisIsIt::
Jump_004_7C2B:: ; address name
    ld a, $1F
    ld [wDataBank], a
    ld hl, Script_65B8
    call StartScriptAtHL_B04
    ret

; A = 0 unless wC634 is $FF or 0; then scans wInventory for an empty slot ($FF or 0) and returns carry (E-0124)
; 6 call sites from 6 routines (e.g. Talk07BF_HeroFoundThePretty, Talk07A6_OurDaughtersOnlyMemento, Talk077B_HeroPeeredIntoThe, Talk075F_KiralFetchMeMy, ...)
; reads: wInventory
; points at: wInventory
InventoryHasFreeSlotCheck::
Func_004_7C37:: ; address name
    ld a, [wInventory + $17]
    cp a, $FF
    jr z, Jump_004_7C43
    or a, a
    jr z, Jump_004_7C43
    sub a, a
    ret

Jump_004_7C43::
    ld hl, wInventory

Jump_004_7C46::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_004_7C51
    or a, a
    jr z, Jump_004_7C51
    inc hl
    jr Jump_004_7C46

Jump_004_7C51::
    scf
    ret
    ds $3AD, $00
