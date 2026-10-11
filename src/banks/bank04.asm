SECTION "Bank 04", ROMX[$4000], BANK[$04]
    db $04

; runs Func_004_4BB0 and Func_004_44CE; shared by the field mode states (E-0122)
; 7 call sites from 7 routines (e.g. FieldModeStateDispatch_Case00, FieldModeStateDispatch_Case01, FieldModeStateDispatch_Case02, FieldModeStateDispatch_Case03, ...)
FieldStateCommonUpdate::
Func_004_4001:: ; address name
    call AdvanceHFF99AndRunHFF8BMode
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
    ld hl, $5327
    add_a_to_hl
    call SetupKeyWorldObjectsForMapType_Sub01
    ld a, [wKeyWorldObjFlag]
    or a, a
    ret z
    call PlaceObjectCB86ForWCD0B
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
    ld hl, $5327
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
    ld hl, $5327
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
    ld hl, $5327
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
    ld hl, $423D
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
    call DecompressGraphicsHFFC6ToHFFCA
    pop de
    pop hl
    pop bc
    dec b
    jp nz, Jump_004_416D
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $01023D, $90

; on map screen (0, 0) or (1, 0) sets wCB8A/wCB8B and wCB86 for wCD0B values 1, 7, 8 or 9 (E-0125)
; 1 call site from 1 routine (e.g. SetupKeyWorldObjectsForMapType)
; reads: hMapScreenY, hMapScreenX, wKeyWorldGoalKind
; writes: wSpriteSlots
PlaceObjectCB86ForWCD0B::
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
; 25 call sites from 15 routines (e.g. LoadPlayerSpriteGraphics, LoadPlayerAndFollowerSpriteGraphics, SetupKeyWorldObjectsForMapType_Sub01, ScriptCommand41_Run_Case09, ...)
; reads: hTemp2, hTemp0, hTemp1, hTemp4, hTemp5, wIsCGB, hTemp3
; points at: wOBJPaletteBuffer
DecompressGraphicsHFFC6ToHFFCA::
Func_004_431F:: ; address name
    ldh a, [hTemp2]
    or a, a
    jr nz, Jump_004_433C
    ld de, $4EAA
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
    ld de, $43AC
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
    ld de, $4A46
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

; E-0143 (C1: DecompressGraphicsHFFC6ToHFFCA with hFFC8 non-zero reads the word $43AC + 2 * hFFC6/7 in bank $04 and decompresses it from bank $7D, or $7E for numbers $50 and up; all 98 entries decode).
; record: compressed sprite graphics in bank $7D
FieldSpriteGraphicsTable::
Data_004_43AC:: ; heuristic: start of a structured table; C0
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

; E-0143 (C1: DecompressGraphicsHFFC6ToHFFCA with hFFC8 non-zero reads the word $43AC + 2 * hFFC6/7 in bank $04 and decompresses it from bank $7D, or $7E for numbers $50 and up; all 98 entries decode); numbers $50-$61.
; record: compressed sprite graphics in bank $7E
FieldSpriteGraphicsTable50::
Data_004_444C:: ; heuristic: start of a structured table; C0
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
; 15 call sites from 15 routines (e.g. FieldModeStateDispatch_Case02_Sub01, RunWD06BSubState_60E9_Case02_Case00_Case02, ScriptCommandF7_Run_Case1A_Sub01, ScriptCommandF7_Run_Shared03, ...)
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
; 5 call sites from 5 routines (e.g. FieldStateCommonUpdate, RunWCFA8StateWhenNotFading_Shared01, GameMode6_Update_Shared06, GameMode5_Update_Case07_Sub01_Sub03, ...)
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
    dw UpdateSpriteSlots_Case01
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
UpdateSpriteSlots_Case01::
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
    call RunWC935Type0AOrOther
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
    call RunWC935Type0AOrOther
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
    call RunWC935Type0AOrOther
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
    call RunWC935Type0AOrOther
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
RunWC935Type0AOrOther::
Func_004_4852:: ; address name
    ld a, [wPendingFieldEvent]
    and a, $0F
    cp a, $0A
    jr z, Jump_004_485F
    call IsTileUnderCellBlocking
    ret

Jump_004_485F::
    call RunWC935Type0AOrOther_Sub01
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
; 3 call sites from 2 routines (e.g. RunWC935Type0AOrOther, UpdateSpriteSlots_Case02)
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

; only called from RunWC935Type0AOrOther (E-0047)
; 1 call site from 1 routine (e.g. RunWC935Type0AOrOther)
; reads: wMapTallTileMin
; points at: wScreenTileBuffer, wTilesUnderPoint
RunWC935Type0AOrOther_Sub01::
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

; E-0143 (C1: on CGB, with hFFC8 non-zero, DecompressGraphicsHFFC6ToHFFCA reads the byte $4A46 + hFFC6 in bank $04 and copies the 8 bytes at 7E:$4B15 + 8 * it to the OBJ palette hFFC9; values 0-20).
; record: palette number in FieldSpritePalettes
FieldSpritePaletteIndex::
Data_004_4A46:: ; heuristic: start of a structured table; C0
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
; 32 call sites from 32 routines (e.g. InitFieldScreen, RunWC8C7Phase_Case02, ResetLeadRecordFields55And5B, ScriptCommandF6_Run_Case06, ...)
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
    call DecompressGraphicsHFFC6ToHFFCA
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
    call DecompressGraphicsHFFC6ToHFFCA
    ret

Jump_004_4B23::
    call LoadPlayerSpriteGraphics
    call LoadPlayerAndFollowerSpriteGraphics_Sub01
    call LoadAltObjectGraphicsIfHFF8CBit3
    ret

; decompresses the player sprite graphics to vTiles0: variant 0 or 1 by story flag 0, or the stream named by hFF94/hFF95 when bit 7 of hFF93 is set (E-0127)
; 5 call sites from 3 routines (e.g. LoadPlayerAndFollowerSpriteGraphics, ScriptCommandA0_Run_Case04, ScriptCommandA1_Run_Case02)
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
    call DecompressGraphicsHFFC6ToHFFCA
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
    call DecompressGraphicsHFFC6ToHFFCA
    ret

; when hFF8C bit 3 is set: decompresses Data_07E_58FF (bank $7E) to vTiles0 + $700 and copies an 8-byte palette from bank $7E into OBJ palette 7 of wOBJPaletteBuffer (wC527 = $7F) (E-0120)
; 1 call site from 1 routine (e.g. LoadPlayerAndFollowerSpriteGraphics)
; reads: hPlayerStateFlags
; writes: wOBJPaletteUploadRequest
; points at: wOBJPaletteBuffer
LoadAltObjectGraphicsIfHFF8CBit3::
Func_004_4B7E:: ; address name
    ldh a, [hPlayerStateFlags]
    bit 3, a
    ret z
    ld de, Data_07E_58FF
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
AdvanceHFF99AndRunHFF8BMode::
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
    dw AdvanceHFF99AndRunHFF8BMode_Case00
    dw AdvanceHFF99AndRunHFF8BMode_Case01
    dw AdvanceHFF99AndRunHFF8BMode_Case02

; entry 0 of the `rst $00` table in AdvanceHFF99AndRunHFF8BMode
; no direct call (reached through a table, a jump or a vector)
AdvanceHFF99AndRunHFF8BMode_Case00::
Jump_004_4BCF:: ; address name
    call AdvanceHFF99AndRunHFF8BMode_Shared01
    call AdvanceHFF99AndRunHFF8BMode_Case00_Sub01
    ret

; entry 1 of the `rst $00` table in AdvanceHFF99AndRunHFF8BMode
; no direct call (reached through a table, a jump or a vector)
AdvanceHFF99AndRunHFF8BMode_Case01::
Jump_004_4BD6:: ; address name
    call AdvanceHFF99AndRunHFF8BMode_Shared01
    call AdvanceHFF99AndRunHFF8BMode_Case01_Sub01
    ret

; entry 2 of the `rst $00` table in AdvanceHFF99AndRunHFF8BMode
; no direct call (reached through a table, a jump or a vector)
AdvanceHFF99AndRunHFF8BMode_Case02::
Jump_004_4BDD:: ; address name
    call AdvanceHFF99AndRunHFF8BMode_Shared01
    call AdvanceHFF99AndRunHFF8BMode_Case02_Sub01
    ret

; only called from AdvanceHFF99AndRunHFF8BMode_Case02 (E-0047)
; 1 call site from 1 routine (e.g. AdvanceHFF99AndRunHFF8BMode_Case02)
; reads: hSpriteOriginY, hSpriteOriginYHi, hSpriteAttrXor, hPlayerStateFlags
; writes: hSpriteOriginY, hSpriteOriginYHi, hSpriteTileOffset, hSpriteAttrXor, hSpriteSetIndex, hSpriteSubIndex
AdvanceHFF99AndRunHFF8BMode_Case02_Sub01::
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

; only called from AdvanceHFF99AndRunHFF8BMode_Case01 (E-0047)
; 1 call site from 1 routine (e.g. AdvanceHFF99AndRunHFF8BMode_Case01)
; reads: hFieldDrawFlags, hPlayerSpriteVariant, wFollowerRecords, hPlayerAnimCounter, hScrollX, hScrollXHi, hScrollY, hScrollYHi
; writes: hSpriteSetIndex, hSpriteAttrXor, hSpriteSubIndex, hSpriteTileOffset, hSpriteOriginX, hSpriteOriginXHi, hSpriteOriginY, hSpriteOriginYHi
AdvanceHFF99AndRunHFF8BMode_Case01_Sub01::
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
    call AdvanceHFF99AndRunHFF8BMode_Shared02
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

; only called from routines of AdvanceHFF99AndRunHFF8BMode (E-0098)
; 3 call sites from 3 routines (e.g. AdvanceHFF99AndRunHFF8BMode_Case02, AdvanceHFF99AndRunHFF8BMode_Case01, AdvanceHFF99AndRunHFF8BMode_Case00)
; reads: hFieldDrawFlags, hPlayerSpriteVariant, hPlayerX, hPlayerY, hPlayerAnimCounter, hScrollX, hScrollXHi, hScrollY, ...
; writes: hSpriteSetIndex, hSpriteAttrXor, hSpriteSubIndex, hSpriteTileOffset, hSpriteOriginX, hSpriteOriginXHi, hSpriteOriginY, hSpriteOriginYHi
AdvanceHFF99AndRunHFF8BMode_Shared01::
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
    call AdvanceHFF99AndRunHFF8BMode_Shared02
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

; only called from AdvanceHFF99AndRunHFF8BMode_Case00 (E-0047)
; 1 call site from 1 routine (e.g. AdvanceHFF99AndRunHFF8BMode_Case00)
; reads: wPartyCount, hTemp9, hFieldDrawFlags, hPlayerAnimCounter, hTemp0, hScrollX, hScrollXHi, hScrollY, ...
; writes: hTemp9, hTemp0, hSpriteAttrXor, hSpriteSubIndex, hSpriteTileOffset, hSpriteOriginX, hSpriteOriginXHi, hSpriteOriginY, ...
; points at: wFollowerRecords
AdvanceHFF99AndRunHFF8BMode_Case00_Sub01::
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
    call AdvanceHFF99AndRunHFF8BMode_Shared02
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

; only called from routines of AdvanceHFF99AndRunHFF8BMode (E-0098)
; 3 call sites from 3 routines (e.g. AdvanceHFF99AndRunHFF8BMode_Shared01, AdvanceHFF99AndRunHFF8BMode_Case01_Sub01, AdvanceHFF99AndRunHFF8BMode_Case00_Sub01)
; reads: wFadeState, hMapId, hMapScreenX, hMapScreenY, hPlayerY
AdvanceHFF99AndRunHFF8BMode_Shared02::
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
Data_004_4EAA:: ; heuristic: argument of a bank-switching copy helper; C0
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
    dfar MonsterSprite_PomPomBom ; id 271 PomPomBom
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
    dw $5347 ; id 383 ?
    db $8C
    INCBIN "dwm2-cobi-us.gbc", $01132A, $291

; starts a message through script command $09 (message word HL, shown by the same group dispatch as ShowMessageHL when wD7F0 = 0): HL is stored in wScriptParam0 (low) and wScriptParam1 (high); then wC5DC = 1, wC920 = 9, wC91F = 1, wC923 = 0 and wC919 = 0 (an earlier store of $80 to wC919 is overwritten)
; 316 call sites from 163 routines (e.g. Func_004_7B29_Case06, Func_004_7B29_Case05, Func_004_7B29_Case04, Func_004_6A35_Case1B, ...)
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

; starts a message through script command $0A: DE is stored in wMessageIndex (low) and wMessageGroup (high); then wC5DC = 1, wC920 = $0A, wC91F = 1, wC923 = 0 and wC919 = 0 (an earlier store of $80 is overwritten)
; 99 call sites from 99 routines (e.g. Func_004_6A35_Case1A, Func_004_6A35_Case19, Func_004_6A35_Case18, Func_004_6A35_Case15, ...)
; writes: wMessageIndex, wMessageGroup, wScriptStartRequest, wModeState, wScriptCommandType, wScriptRunning, wScriptStep
StartMessageScriptDE_B04::
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
; 177 call sites from 122 routines (e.g. Func_004_5616_Case02, Func_004_5616_Case01, Func_004_5616_Case00, Func_004_7B29_Case08, ...)
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
    dw Func_004_5616_Case00
    dw Func_004_5616_Case01
    dw Func_004_5616_Case02
    db $00, $00
    dw StartScript4F73AndSetFlag5
    dw StartScript4F7CAndSetFlag06
    dw IfFlag000AStartScript4F9D
    dw Talk0046_ThanksForComingBy
    dw Data_004_5731
    dw Data_004_5738
    dw Data_004_573F
    dw Data_004_57A4
    dw Data_004_57AB
    dw Data_004_57B2
    dw Data_004_57B9
    dw Data_004_57C0
    dw Data_004_57C7
    dw Data_004_57CE
    dw Data_004_57D5
    dw Data_004_57DC
    dw Data_004_57E3
    dw Data_004_57EA
    dw Data_004_57F1
    dw Data_004_57F8
    dw Data_004_580E
    dw Data_004_5815
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
Func_004_5616_Case00::
Jump_004_5660:: ; address name
    ld de, $0001
    call TestFlagBit
    jr nc, Jump_004_566F
    ld hl, $5063
    call StartScriptAtHL_B04
    ret

Jump_004_566F::
    ld hl, $509F
    call StartScriptAtHL_B04
    ret

; entry 1 of the `rst $00` table in Func_004_5616
; no direct call (reached through a table, a jump or a vector)
Func_004_5616_Case01::
Jump_004_5676:: ; address name
    ld hl, $4F54
    call StartScriptAtHL_B04
    ret

; entry 2 of the `rst $00` table in Func_004_5616
; no direct call (reached through a table, a jump or a vector)
Func_004_5616_Case02::
Jump_004_567D:: ; address name
    ld hl, $5111
    call StartScriptAtHL_B04
    ret
    db $21, $44, $00, $CD, $BB, $55, $C9

; StartScriptAtHL_B04 with HL = $4F73, then sets story flag 5 (E-0119)
; no direct call (reached through a table, a jump or a vector)
StartScript4F73AndSetFlag5:: ; heuristic: target of a pointer table; C0
Func_004_568B:: ; address name
    ld hl, $4F73
    call StartScriptAtHL_B04
    ld de, $0005
    call SetFlagBit
    ret

; map event: starts script $4F7C, runs Func_012_6B98 with hFFC6 = 0 and sets story flag 6 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
StartScript4F7CAndSetFlag06:: ; heuristic: target of a pointer table; C0
Func_004_5698:: ; address name
    ld hl, $4F7C
    call StartScriptAtHL_B04
    ld a, $00
    ldh [hTemp0], a
    farcall RunFieldCommandHFFC6
    ld de, $0006
    call SetFlagBit
    ret

; when story flag $0A is set, StartScriptAtHL_B04 with HL = $4F9D (E-0119)
; no direct call (reached through a table, a jump or a vector)
IfFlag000AStartScript4F9D:: ; heuristic: target of a pointer table; C0
Func_004_56AF:: ; address name
    ld de, $000A
    call TestFlagBit
    ret nc
    ld hl, $4F9D
    call StartScriptAtHL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 2 constant message(s) depending on story flags and state; the first one in the code is $0046, whose string begins 'Thanks for coming by. I'll always'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wDataBank
Talk0046_ThanksForComingBy:: ; heuristic: target of a pointer table; C0
Func_004_56BD:: ; address name
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
    farcall RunFieldCommandHFFC6
    ld hl, $4F88
    call StartScriptAtHL_B04
    ld de, $0007
    call SetFlagBit
    ret

Jump_004_56F4::
    ld hl, $0046
    call StartMessageCommand09HL_B04
    ret

Jump_004_56FB::
    ld hl, $0079
    call StartMessageCommand09HL_B04
    ret

Jump_004_5702::
    ld a, $10
    ld [wDataBank], a
    ld de, $0103
    call TestFlagBit
    jr c, Jump_004_5716
    ld hl, Data_010_5353
    call StartScriptAtHL_B04
    ret

Jump_004_5716::
    ld hl, $535D
    call StartScriptAtHL_B04
    ret

Jump_004_571D::
    ld a, $10
    ld [wDataBank], a
    ld de, $0127
    call TestFlagBit
    jr c, Jump_004_5716
    ld hl, Data_010_5364
    call StartScriptAtHL_B04
    ret

Data_004_5731:: ; heuristic: target of a monotone pointer table; C0
    db $21, $47, $00, $CD, $BB, $55, $C9

Data_004_5738:: ; heuristic: target of a monotone pointer table; C0
    db $21, $41, $54, $CD, $03, $56, $C9

Data_004_573F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $01173F, $65

Data_004_57A4:: ; heuristic: target of a monotone pointer table; C0
    db $21, $33, $02, $CD, $BB, $55, $C9

Data_004_57AB:: ; heuristic: target of a monotone pointer table; C0
    db $21, $34, $02, $CD, $BB, $55, $C9

Data_004_57B2:: ; heuristic: target of a monotone pointer table; C0
    db $21, $35, $02, $CD, $BB, $55, $C9

Data_004_57B9:: ; heuristic: target of a monotone pointer table; C0
    db $21, $36, $02, $CD, $BB, $55, $C9

Data_004_57C0:: ; heuristic: target of a monotone pointer table; C0
    db $21, $37, $02, $CD, $BB, $55, $C9

Data_004_57C7:: ; heuristic: target of a monotone pointer table; C0
    db $21, $38, $02, $CD, $BB, $55, $C9

Data_004_57CE:: ; heuristic: target of a monotone pointer table; C0
    db $21, $39, $02, $CD, $BB, $55, $C9

Data_004_57D5:: ; heuristic: target of a monotone pointer table; C0
    db $21, $3A, $02, $CD, $BB, $55, $C9

Data_004_57DC:: ; heuristic: target of a monotone pointer table; C0
    db $21, $3B, $02, $CD, $BB, $55, $C9

Data_004_57E3:: ; heuristic: target of a monotone pointer table; C0
    db $21, $3C, $02, $CD, $BB, $55, $C9

Data_004_57EA:: ; heuristic: target of a monotone pointer table; C0
    db $21, $3D, $02, $CD, $BB, $55, $C9

Data_004_57F1:: ; heuristic: target of a monotone pointer table; C0
    db $21, $3E, $02, $CD, $BB, $55, $C9

Data_004_57F8:: ; heuristic: target of a monotone pointer table; C0
    db $11, $25, $00, $CD, $1B, $18, $38, $07, $11, $24, $00, $CD, $1B, $18, $D8, $21
    db $42, $00, $CD, $BB, $55, $C9

Data_004_580E:: ; heuristic: target of a monotone pointer table; C0
    db $21, $10, $00, $CD, $BB, $55, $C9

Data_004_5815:: ; heuristic: target of a monotone pointer table; C0
    db $21, $0F, $00, $CD, $BB, $55, $C9

; with story flag $1A set: counts keys twice (Func_012_6955 with hFFC7 = 1 and 2), sets bit 7 of wC836 and starts script $5039 (E-0124)
; no direct call (reached through a table, a jump or a vector)
; reads: wGameFlags836
; writes: hTemp1, wGameFlags836
MapEventCountKeysAndStartScript5039:: ; heuristic: target of a pointer table; C0
Func_004_581C:: ; address name
    ld de, $001A
    call TestFlagBit
    ret nc
    farcall CountKeysOrFull
    ld a, $01
    ldh [hTemp1], a
    farcall WriteKeyEntryHFFC6
    farcall CountKeysOrFull
    ld a, $02
    ldh [hTemp1], a
    farcall WriteKeyEntryHFFC6
    ld a, [wGameFlags836]
    set 7, a
    ld [wGameFlags836], a
    ld hl, $5039
    call StartScriptAtHL_B04
    ret

; when story flag $00D1 is set (TestFlagBit), starts message $0D33 through StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'You saved us all by yourself.' (E-0082)
; no direct call (reached through a table, a jump or a vector)
IfFlag00D1Msg0D33_YouSavedUsAll:: ; heuristic: target of a pointer table; C0
Func_004_5852:: ; address name
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld hl, $0D33
    call StartMessageCommand09HL_B04
    ret

; when story flag $00D1 is set (TestFlagBit), starts message $0D34 through StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'Please, eat up, eat up! Don't' (E-0082)
; no direct call (reached through a table, a jump or a vector)
IfFlag00D1Msg0D34_PleaseEatUpEat:: ; heuristic: target of a pointer table; C0
Func_004_5860:: ; address name
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld hl, $0D34
    call StartMessageCommand09HL_B04
    ret

; when story flag $00D1 is set (TestFlagBit), starts message $0D35 through StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'Hm? I saw your family. They' (E-0082)
; no direct call (reached through a table, a jump or a vector)
IfFlag00D1Msg0D35_HmISawYour:: ; heuristic: target of a pointer table; C0
Func_004_586E:: ; address name
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld hl, $0D35
    call StartMessageCommand09HL_B04
    ret

; when story flag $00D1 is set (TestFlagBit), starts message $0D36 through StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'The Kingdom is rejoicing!' (E-0082)
; no direct call (reached through a table, a jump or a vector)
IfFlag00D1Msg0D36_TheKingdomIsRejoicing:: ; heuristic: target of a pointer table; C0
Func_004_587C:: ; address name
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld hl, $0D36
    call StartMessageCommand09HL_B04
    ret

; when story flag $00D1 is set (TestFlagBit), starts message $0D37 through StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'Instead of standing around, you should' (E-0082)
; no direct call (reached through a table, a jump or a vector)
IfFlag00D1Msg0D37_InsteadOfStandingAround:: ; heuristic: target of a pointer table; C0
Func_004_588A:: ; address name
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld hl, $0D37
    call StartMessageCommand09HL_B04
    ret

; when story flag $00D1 is set (TestFlagBit), starts message $0D38 through StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'Just imagine if you weren't here.' (E-0082)
; no direct call (reached through a table, a jump or a vector)
IfFlag00D1Msg0D38_JustImagineIfYou:: ; heuristic: target of a pointer table; C0
Func_004_5898:: ; address name
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld hl, $0D38
    call StartMessageCommand09HL_B04
    ret

; when story flag $00D1 is set (TestFlagBit), starts message $0D39 through StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'Ah, GreatLog's mighty hero! I hope' (E-0082)
; no direct call (reached through a table, a jump or a vector)
IfFlag00D1Msg0D39_AhGreatLogsMightyHero:: ; heuristic: target of a pointer table; C0
Func_004_58A6:: ; address name
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld hl, $0D39
    call StartMessageCommand09HL_B04
    ret

; when story flag $00D1 is set (TestFlagBit), starts message $0D3A through StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'To be honest, I was getting' (E-0082)
; no direct call (reached through a table, a jump or a vector)
IfFlag00D1Msg0D3A_ToBeHonestI:: ; heuristic: target of a pointer table; C0
Func_004_58B4:: ; address name
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld hl, $0D3A
    call StartMessageCommand09HL_B04
    ret

; only called from DispatchTalkEvent_Case03 (E-0047)
; 1 call site from 1 routine (e.g. DispatchTalkEvent_Case03)
; reads: wTalkEventGroup
DispatchTalkEvent_Case03_Sub01::
Func_004_58C2:: ; address name
    ld a, [wTalkEventGroup]
    rst $00
    dw Func_004_58C2_Case00
    dw Func_004_58C2_Case01
    dw Func_004_58C2_Case02
    dw Func_004_58C2_Case03
    dw Func_004_58C2_Case04
    dw Func_004_58C2_Case05
    dw Func_004_58C2_Case06
    dw Func_004_58C2_Case07
    dw Func_004_58C2_Case08
    dw Func_004_58C2_Case09
    dw Func_004_58C2_Case0A
    dw Func_004_58C2_Case0B
    dw Func_004_58C2_Case0C
    dw Func_004_58C2_Case0D
    dw Func_004_58C2_Case0E
    dw Func_004_58C2_Case0F
    dw Func_004_58C2_Case10
    dw Func_004_58C2_Case11
    dw Func_004_58C2_Case12
    dw Func_004_58C2_Case13
    dw Func_004_58C2_Case14
    dw Func_004_58C2_Case15
    dw Func_004_58C2_Case16
    dw Func_004_58C2_Case17
    dw Func_004_58C2_Case18
    dw Func_004_58C2_Case19
    dw Func_004_58C2_Case1A
    dw Func_004_58C2_Case1B
    dw Func_004_58C2_Case1C
    dw Func_004_58C2_Case1D
    dw Func_004_58C2_Case1E
    dw Func_004_58C2_Case1F
    dw Func_004_58C2_Case20
    dw Func_004_58C2_Case21
    dw Func_004_58C2_Case22
    dw Func_004_58C2_Case23
    dw Func_004_58C2_Case24
    dw Func_004_58C2_Case25
    dw Func_004_58C2_Case26
    dw Func_004_58C2_Case27
    dw Func_004_58C2_Case28
    dw Func_004_58C2_Case29
    dw Func_004_58C2_Case2A
    dw Func_004_58C2_Case2B
    dw Func_004_58C2_Case2C
    dw Func_004_58C2_Case2D
    dw Func_004_58C2_Case2E
    dw Func_004_58C2_Case2F
    dw Func_004_58C2_Case30
    dw Func_004_58C2_Case31
    dw Func_004_58C2_Case32
    dw Func_004_58C2_Case33
    dw Func_004_58C2_Case34
    dw Func_004_58C2_Case35
    dw Func_004_58C2_Case36
    dw Func_004_58C2_Case37
    dw Func_004_58C2_Case38
    dw Func_004_58C2_Case39
    dw Func_004_58C2_Case3A
    dw Func_004_58C2_Case3B
    dw Func_004_58C2_Case3C
    dw Func_004_58C2_Case3D
    dw Func_004_58C2_Case3E
    dw Func_004_58C2_Case3F
    dw Func_004_58C2_Case40
    dw Func_004_58C2_Case41
    dw Func_004_58C2_Case42
    dw Func_004_58C2_Case43
    dw Func_004_58C2_Case44
    dw Func_004_58C2_Case45
    dw Func_004_58C2_Case46
    dw Func_004_58C2_Case47
    dw Func_004_58C2_Case48
    dw Func_004_58C2_Case49
    dw Func_004_58C2_Case4A
    dw Func_004_58C2_Case4B
    dw Func_004_58C2_Case4C
    dw Func_004_58C2_Case4D
    dw Func_004_58C2_Case4E
    dw Func_004_58C2_Case4F
    dw Func_004_58C2_Case50
    dw Func_004_58C2_Case51
    dw Func_004_58C2_Case52
    dw Func_004_58C2_Case53
    dw Func_004_58C2_Case54
    dw Func_004_58C2_Case55
    dw Func_004_58C2_Case56
    dw Func_004_58C2_Case57
    dw Func_004_58C2_Case58
    dw Func_004_58C2_Case59
    dw Func_004_58C2_Case5A
    dw Func_004_58C2_Case5B
    dw Func_004_58C2_Case5C
    dw Func_004_58C2_Case5D
    dw Func_004_58C2_Case5E
    dw Func_004_58C2_Case5F
    dw Func_004_58C2_Case60
    dw Func_004_58C2_Case61
    dw Func_004_58C2_Case62
    dw Func_004_58C2_Case63
    dw Func_004_58C2_Case64
    dw Func_004_58C2_Case65
    dw Func_004_58C2_Case66
    dw Func_004_58C2_Case67
    dw Func_004_58C2_Case68
    dw Func_004_58C2_Case69
    dw Func_004_58C2_Case6A
    dw Func_004_58C2_Case6B
    dw Func_004_58C2_Case6C
    dw Func_004_58C2_Case6D

; entry 0 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case00::
Jump_004_59A2:: ; address name
    ld hl, $0800
    call StartMessageCommand09HL_B04
    ret

; entry 1 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case01::
Jump_004_59A9:: ; address name
    ld hl, $0801
    call StartMessageCommand09HL_B04
    ret

; entry 2 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case02::
Jump_004_59B0:: ; address name
    ld hl, $0802
    call StartMessageCommand09HL_B04
    ret

; entry 3 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case03::
Jump_004_59B7:: ; address name
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_59C6
    ld hl, $0803
    call StartMessageCommand09HL_B04
    ret

Jump_004_59C6::
    ld hl, $0874
    call StartMessageCommand09HL_B04
    ret

; entry 4 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case04::
Jump_004_59CD:: ; address name
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_59DC
    ld hl, $0804
    call StartMessageCommand09HL_B04
    ret

Jump_004_59DC::
    ld hl, $0875
    call StartMessageCommand09HL_B04
    ret

; entry 5 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case05::
Jump_004_59E3:: ; address name
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_59F2
    ld hl, $0805
    call StartMessageCommand09HL_B04
    ret

Jump_004_59F2::
    ld hl, $0876
    call StartMessageCommand09HL_B04
    ret

; entry 6 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case06::
Jump_004_59F9:: ; address name
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_5A1D
    ld de, $0060
    call TestFlagBit
    jr c, Jump_004_5A16
    ld hl, $5B84
    call StartScriptAtHL_B04
    ld de, $0060
    call SetFlagBit
    ret

Jump_004_5A16::
    ld hl, $0808
    call StartMessageCommand09HL_B04
    ret

Jump_004_5A1D::
    ld hl, $0877
    call StartMessageCommand09HL_B04
    ret

; entry 7 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenTableIndex, wDataBank
Func_004_58C2_Case07::
Jump_004_5A24:: ; address name
    ld a, $04
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_5B8C
    call StartScriptAtHL_B04
    ret

; entry 8 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case08::
Jump_004_5A35:: ; address name
    ld hl, $080A
    call StartMessageCommand09HL_B04
    ret

; entry 9 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case09::
Jump_004_5A3C:: ; address name
    ld hl, $080B
    call StartMessageCommand09HL_B04
    ret

; entry 10 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_58C2_Case0A::
Jump_004_5A43:: ; address name
    ld a, $02
    ld [wScriptParam0], a
    ld a, $2C
    ld [wScriptParam1], a
    ld de, $0061
    call StartMessageScriptDE_B04
    ret

; entry 11 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_58C2_Case0B::
Jump_004_5A54:: ; address name
    ld a, $02
    ld [wScriptParam0], a
    ld a, $28
    ld [wScriptParam1], a
    ld de, $0062
    call StartMessageScriptDE_B04
    ret

; entry 12 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case0C::
Jump_004_5A65:: ; address name
    ld hl, $088A
    call StartMessageCommand09HL_B04
    ret

; entry 13 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case0D::
Jump_004_5A6C:: ; address name
    ld hl, $0889
    call StartMessageCommand09HL_B04
    ret

; entry 14 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case0E::
Jump_004_5A73:: ; address name
    ld hl, $0037
    call StartMessageCommand09HL_B04
    ret

; entry 15 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case0F::
Jump_004_5A7A:: ; address name
    ld hl, $080C
    call StartMessageCommand09HL_B04
    ret

; entry 16 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case10::
Jump_004_5A81:: ; address name
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_5A90
    ld hl, $080D
    call StartMessageCommand09HL_B04
    ret

Jump_004_5A90::
    ld hl, $0878
    call StartMessageCommand09HL_B04
    ret

; entry 17 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case11::
Jump_004_5A97:: ; address name
    ld hl, $080E
    call StartMessageCommand09HL_B04
    ret

; entry 18 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case12::
Jump_004_5A9E:: ; address name
    ld hl, $080F
    call StartMessageCommand09HL_B04
    ret

; entry 19 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp1, wStepArrived, hTemp2
; writes: rRAMG
; points at: wPartyList, wNameGlyphBuf
Func_004_58C2_Case13::
Jump_004_5AA5:: ; address name
    ld de, $006F
    call TestFlagBit
    jr c, Jump_004_5B16
    farcall FindPartyMemberWithSkill76To7DOr92
    ldh a, [hTemp1]
    bit 7, a
    jr z, Jump_004_5AC0
    ld hl, $5C2F
    call StartScriptAtHL_B04
    ret

Jump_004_5AC0::
    farcall SetWStepArrivedIfPartyHasField55Bit7
    ld a, [wStepArrived]
    or a, a
    jr z, Jump_004_5AD3
    ld hl, $5C5C
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
    call CopyRecordNameToWC8CF
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
    ld hl, $5C40
    call StartScriptAtHL_B04
    ret

Jump_004_5B0F::
    ld hl, $5C4E
    call StartScriptAtHL_B04
    ret

Jump_004_5B16::
    ld hl, $084A
    call StartMessageCommand09HL_B04
    ret

; entry 20 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
Func_004_58C2_Case14::
Jump_004_5B1D:: ; address name
    ld hl, $5B94
    call StartScriptAtHL_B04
    ld a, $10
    ld [wDataBank], a
    ret

; entry 21 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case15::
Jump_004_5B29:: ; address name
    ld hl, $5B9B
    call StartScriptAtHL_B04
    ret

; entry 22 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case16::
Jump_004_5B30:: ; address name
    ld hl, $081B
    call StartMessageCommand09HL_B04
    ret

; entry 23 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case17::
Jump_004_5B37:: ; address name
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_5B46
    ld hl, $081C
    call StartMessageCommand09HL_B04
    ret

Jump_004_5B46::
    ld hl, $0879
    call StartMessageCommand09HL_B04
    ret

; entry 24 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case18::
Jump_004_5B4D:: ; address name
    ld hl, $088B
    call StartMessageCommand09HL_B04
    ret

; entry 25 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case19::
Jump_004_5B54:: ; address name
    ld hl, $0889
    call StartMessageCommand09HL_B04
    ret

; entry 26 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case1A::
Jump_004_5B5B:: ; address name
    ld hl, $081D
    call StartMessageCommand09HL_B04
    ret

; entry 27 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case1B::
Jump_004_5B62:: ; address name
    ld de, $007A
    call TestFlagBit
    jr c, Jump_004_5B71
    ld hl, $081E
    call StartMessageCommand09HL_B04
    ret

Jump_004_5B71::
    ld hl, $087A
    call StartMessageCommand09HL_B04
    ret

; entry 28 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case1C::
Jump_004_5B78:: ; address name
    ld hl, $081F
    call StartMessageCommand09HL_B04
    ret

; entry 29 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
Func_004_58C2_Case1D::
Jump_004_5B7F:: ; address name
    ld a, $1F
    ld [wDataBank], a
    ld hl, Data_01F_5BA8
    call StartScriptAtHL_B04
    ret

; entry 30 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case1E::
Jump_004_5B8B:: ; address name
    ld hl, $0821
    call StartMessageCommand09HL_B04
    ret

; entry 31 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case1F::
Jump_004_5B92:: ; address name
    ld hl, $0822
    call StartMessageCommand09HL_B04
    ret

; entry 32 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenTableIndex, wDataBank
Func_004_58C2_Case20::
Jump_004_5B99:: ; address name
    ld a, $06
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_5BAF
    call StartScriptAtHL_B04
    ret

; entry 33 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case21::
Jump_004_5BAA:: ; address name
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_5BB9
    ld hl, $0824
    call StartMessageCommand09HL_B04
    ret

Jump_004_5BB9::
    ld hl, $0D13
    call StartMessageCommand09HL_B04
    ret

; entry 34 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case22::
Jump_004_5BC0:: ; address name
    ld hl, $0825
    call StartMessageCommand09HL_B04
    ret

; entry 35 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case23::
Jump_004_5BC7:: ; address name
    ld hl, $0826
    call StartMessageCommand09HL_B04
    ret

; entry 36 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case24::
Jump_004_5BCE:: ; address name
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_5BDD
    ld hl, $0827
    call StartMessageCommand09HL_B04
    ret

Jump_004_5BDD::
    ld hl, $087B
    call StartMessageCommand09HL_B04
    ret

; entry 37 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case25::
Jump_004_5BE4:: ; address name
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_5BF3
    ld hl, $0829
    call StartMessageCommand09HL_B04
    ret

Jump_004_5BF3::
    ld hl, $087C
    call StartMessageCommand09HL_B04
    ret

; entry 38 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case26::
Jump_004_5BFA:: ; address name
    ld de, $007A
    call TestFlagBit
    jr c, Jump_004_5C09
    ld hl, $082A
    call StartMessageCommand09HL_B04
    ret

Jump_004_5C09::
    ld hl, $087D
    call StartMessageCommand09HL_B04
    ret

; entry 39 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case27::
Jump_004_5C10:: ; address name
    ld hl, $082B
    call StartMessageCommand09HL_B04
    ret

; entry 40 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case28::
Jump_004_5C17:: ; address name
    ld hl, $088D
    call StartMessageCommand09HL_B04
    ret

; entry 41 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case29::
Jump_004_5C1E:: ; address name
    ld hl, $5BB6
    call StartScriptAtHL_B04
    ret

; entry 42 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case2A::
Jump_004_5C25:: ; address name
    ld hl, $082E
    call StartMessageCommand09HL_B04
    ret

; entry 43 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_58C2_Case2B::
Jump_004_5C2C:: ; address name
    ld a, $02
    ld [wScriptParam0], a
    ld a, $2C
    ld [wScriptParam1], a
    ld de, $0063
    call StartMessageScriptDE_B04
    ret

; entry 44 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
Func_004_58C2_Case2C::
Jump_004_5C3D:: ; address name
    ld hl, $5BBD
    call StartScriptAtHL_B04
    ld a, $10
    ld [wDataBank], a
    ret

; entry 45 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case2D::
Jump_004_5C49:: ; address name
    ld de, $007A
    call TestFlagBit
    jr c, Jump_004_5C58
    ld hl, $082F
    call StartMessageCommand09HL_B04
    ret

Jump_004_5C58::
    ld hl, $087E
    call StartMessageCommand09HL_B04
    ret

; entry 46 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case2E::
Jump_004_5C5F:: ; address name
    ld hl, $0830
    call StartMessageCommand09HL_B04
    ret

; entry 47 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case2F::
Jump_004_5C66:: ; address name
    ld hl, $5BC4
    call StartScriptAtHL_B04
    ret

; entry 48 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case30::
Jump_004_5C6D:: ; address name
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_5C8B
    ld de, $006D
    call TestFlagBit
    jr c, Jump_004_5C84
    ld hl, $0834
    call StartMessageCommand09HL_B04
    ret

Jump_004_5C84::
    ld hl, $0842
    call StartMessageCommand09HL_B04
    ret

Jump_004_5C8B::
    ld hl, $0D14
    call StartMessageCommand09HL_B04
    ret

; entry 49 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case31::
Jump_004_5C92:: ; address name
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_5CB0
    ld de, $007A
    call TestFlagBit
    jr c, Jump_004_5CA9
    ld hl, $0835
    call StartMessageCommand09HL_B04
    ret

Jump_004_5CA9::
    ld hl, $0DC3
    call StartMessageCommand09HL_B04
    ret

Jump_004_5CB0::
    ld hl, $087F
    call StartMessageCommand09HL_B04
    ret

; entry 50 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case32::
Jump_004_5CB7:: ; address name
    ld hl, $0836
    call StartMessageCommand09HL_B04
    ret

; entry 51 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wObject3
Func_004_58C2_Case33::
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
    ld hl, $0837
    call StartMessageCommand09HL_B04
    ret

Jump_004_5CE7::
    ld hl, $5BFE
    call StartScriptAtHL_B04
    ret

Jump_004_5CEE::
    ld hl, $5C19
    call StartScriptAtHL_B04
    ret

Jump_004_5CF5::
    call PartyHasSpeciesLo3CTo5BWithHiSet
    jr c, Jump_004_5D06
    ld a, $01
    ld [wObject3 + $7], a
    ld hl, $0837
    call StartMessageCommand09HL_B04
    ret

Jump_004_5D06::
    ld hl, $5C26
    call StartScriptAtHL_B04
    ret

Jump_004_5D0D::
    ld hl, $0880
    call StartMessageCommand09HL_B04
    ret

; carry when a party record has a species word with a non-zero high byte and low byte $3C-$5B (E-0124)
; 2 call sites from 1 routine (e.g. Func_004_58C2_Case33)
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
Func_004_58C2_Case34::
Jump_004_5D44:: ; address name
    ld de, $0066
    call TestFlagBit
    jr c, Jump_004_5D68
    ld de, $0065
    call TestFlagBit
    jr c, Jump_004_5D61
    ld hl, $5BE8
    call StartScriptAtHL_B04
    ld de, $0065
    call SetFlagBit
    ret

Jump_004_5D61::
    ld hl, $5BF2
    call StartScriptAtHL_B04
    ret

Jump_004_5D68::
    ld hl, $5BFC
    call StartScriptAtHL_B04
    ret

; entry 53 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_58C2_Case35::
Jump_004_5D6F:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $1B
    ld [wScriptParam1], a
    ld de, $0067
    call StartMessageScriptDE_B04
    ret

; entry 54 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_58C2_Case36::
Jump_004_5D80:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $02
    ld [wScriptParam1], a
    ld de, $0068
    call StartMessageScriptDE_B04
    ret

; entry 55 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_58C2_Case37::
Jump_004_5D91:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $02
    ld [wScriptParam1], a
    ld de, $0069
    call StartMessageScriptDE_B04
    ret

; entry 56 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_58C2_Case38::
Jump_004_5DA2:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2A
    ld [wScriptParam1], a
    ld de, $006A
    call StartMessageScriptDE_B04
    ret

; entry 57 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_58C2_Case39::
Jump_004_5DB3:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $46
    ld [wScriptParam1], a
    ld de, $006B
    call StartMessageScriptDE_B04
    ret

; entry 58 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_58C2_Case3A::
Jump_004_5DC4:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $28
    ld [wScriptParam1], a
    ld de, $006C
    call StartMessageScriptDE_B04
    ret

; entry 59 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case3B::
Jump_004_5DD5:: ; address name
    ld hl, $0843
    call StartMessageCommand09HL_B04
    ret

; entry 60 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case3C::
Jump_004_5DDC:: ; address name
    ld hl, $0844
    call StartMessageCommand09HL_B04
    ret

; entry 61 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case3D::
Jump_004_5DE3:: ; address name
    ld de, $006F
    call TestFlagBit
    ret nc
    ld hl, $5C69
    call StartScriptAtHL_B04
    ret

; entry 62 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case3E::
Jump_004_5DF1:: ; address name
    ld de, $00F1
    call TestFlagBit
    jr c, Jump_004_5E06
    ld hl, $084E
    call StartMessageCommand09HL_B04
    ld de, $00F1
    call SetFlagBit
    ret

Jump_004_5E06::
    ld hl, $5D36
    call StartScriptAtHL_B04
    ret

; entry 63 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case3F::
Jump_004_5E0D:: ; address name
    ld de, $0076
    call TestFlagBit
    jr c, Jump_004_5E1C
    ld hl, $084F
    call StartMessageCommand09HL_B04
    ret

Jump_004_5E1C::
    ld hl, $0881
    call StartMessageCommand09HL_B04
    ret

; entry 64 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case40::
Jump_004_5E23:: ; address name
    ld de, $0076
    call TestFlagBit
    jr c, Jump_004_5E32
    ld hl, $0850
    call StartMessageCommand09HL_B04
    ret

Jump_004_5E32::
    ld hl, $0882
    call StartMessageCommand09HL_B04
    ret

; entry 65 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case41::
Jump_004_5E39:: ; address name
    ld hl, $0851
    call StartMessageCommand09HL_B04
    ret

; entry 66 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case42::
Jump_004_5E40:: ; address name
    ld hl, $0852
    call StartMessageCommand09HL_B04
    ret

; entry 67 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case43::
Jump_004_5E47:: ; address name
    ld de, $0076
    call TestFlagBit
    jr c, Jump_004_5E56
    ld hl, $0853
    call StartMessageCommand09HL_B04
    ret

Jump_004_5E56::
    ld hl, $0883
    call StartMessageCommand09HL_B04
    ret

; entry 68 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case44::
Jump_004_5E5D:: ; address name
    ld de, $0076
    call TestFlagBit
    jr c, Jump_004_5E6C
    ld hl, $0854
    call StartMessageCommand09HL_B04
    ret

Jump_004_5E6C::
    ld hl, $0884
    call StartMessageCommand09HL_B04
    ret

; entry 69 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; reads: wGameFlags836
; writes: wGameFlags836
Func_004_58C2_Case45::
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
    ld hl, $5C77
    call StartScriptAtHL_B04
    ret

Jump_004_5E92::
    ld hl, $0858
    call StartMessageCommand09HL_B04
    ret

Jump_004_5E99::
    call InventoryHasFreeSlotCheck
    jr c, Jump_004_5EA5
    ld hl, $0DC7
    call StartMessageCommand09HL_B04
    ret

Jump_004_5EA5::
    ld [hl], $5F
    ld a, [wGameFlags836]
    set 6, a
    ld [wGameFlags836], a
    ld hl, $5C7E
    call StartScriptAtHL_B04
    ret

Jump_004_5EB6::
    ld hl, $0885
    call StartMessageCommand09HL_B04
    ret

; entry 70 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case46::
Jump_004_5EBD:: ; address name
    ld hl, $5C88
    call StartScriptAtHL_B04
    ret

; entry 71 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case47::
Jump_004_5EC4:: ; address name
    ld hl, $5C8A
    call StartScriptAtHL_B04
    ret

; entry 72 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case48::
Jump_004_5ECB:: ; address name
    ld hl, $5C94
    call StartScriptAtHL_B04
    ret

; entry 73 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case49::
Jump_004_5ED2:: ; address name
    ld hl, $5C9E
    call StartScriptAtHL_B04
    ret

; entry 74 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case4A::
Jump_004_5ED9:: ; address name
    ld de, $0074
    call TestFlagBit
    jr c, Jump_004_5EEE
    ld hl, $5CA8
    call StartScriptAtHL_B04
    ld de, $0074
    call SetFlagBit
    ret

Jump_004_5EEE::
    ld hl, $5CB5
    call StartScriptAtHL_B04
    ret

; entry 75 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; reads: wGameFlags836
; writes: wGameFlags836
Func_004_58C2_Case4B::
Jump_004_5EF5:: ; address name
    call InventoryHasFreeSlotCheck
    jr c, Jump_004_5F01
    ld hl, $0888
    call StartMessageCommand09HL_B04
    ret

Jump_004_5F01::
    ld [hl], $31
    ld a, [wGameFlags836]
    set 6, a
    ld [wGameFlags836], a
    ld hl, $5CC2
    call StartScriptAtHL_B04
    ret

; entry 76 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case4C::
Jump_004_5F12:: ; address name
    ld hl, $5CCA
    call StartScriptAtHL_B04
    ld de, $0077
    call SetFlagBit
    ret

; entry 77 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlots
Func_004_58C2_Case4D::
Jump_004_5F1F:: ; address name
    xor a, a
    ld [wSpriteSlots + $7], a
    ret

; entry 78 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_58C2_Case4E::
Jump_004_5F24:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2E
    ld [wScriptParam1], a
    ld de, $0079
    call StartMessageScriptDE_B04
    ret

; entry 79 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp0
Func_004_58C2_Case4F::
Jump_004_5F35:: ; address name
    ld de, $007A
    call TestFlagBit
    jr c, Jump_004_5F53
    ld a, $31
    ldh [hTemp0], a
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    ret z
    ld hl, $0865
    call StartMessageCommand09HL_B04
    ret

Jump_004_5F53::
    ld hl, $0867
    call StartMessageCommand09HL_B04
    ret

; entry 80 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, hPlayerX
; writes: wSpriteSlots, wObject1, wObject2
Func_004_58C2_Case50::
Jump_004_5F5A:: ; address name
    ldh a, [hPlayerY]
    cp a, $30
    ret nz
    ld de, $007B
    call SetFlagBit
    ld hl, $5CD1
    call StartScriptAtHL_B04
    ldh a, [hPlayerX]
    cp a, $50
    ret nz
    ld a, $40
    ld [wSpriteSlots + $B], a
    ld [wObject1 + $B], a
    ld [wObject2 + $B], a
    ret

; entry 81 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case51::
Jump_004_5F7C:: ; address name
    ld hl, $5CDD
    call StartScriptAtHL_B04
    ret

; entry 82 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case52::
Jump_004_5F83:: ; address name
    ld hl, $5D1C
    call StartScriptAtHL_B04
    ret

; entry 83 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case53::
Jump_004_5F8A:: ; address name
    ld hl, $5D2F
    call StartScriptAtHL_B04
    ret

; entry 84 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_58C2_Case54::
Jump_004_5F91:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $20
    ld [wScriptParam1], a
    ld de, $00E0
    call StartMessageScriptDE_B04
    ret

; entry 85 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_58C2_Case55::
Jump_004_5FA2:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $28
    ld [wScriptParam1], a
    ld de, $00E1
    call StartMessageScriptDE_B04
    ret

; entry 86 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_58C2_Case56::
Jump_004_5FB3:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $0C
    ld [wScriptParam1], a
    ld de, $00E2
    call StartMessageScriptDE_B04
    ret

; entry 87 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_58C2_Case57::
Jump_004_5FC4:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $11
    ld [wScriptParam1], a
    ld de, $00E3
    call StartMessageScriptDE_B04
    ret

; entry 88 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_58C2_Case58::
Jump_004_5FD5:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $0E
    ld [wScriptParam1], a
    ld de, $00E4
    call StartMessageScriptDE_B04
    ret

; entry 89 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case59::
Jump_004_5FE6:: ; address name
    ld hl, $088C
    call StartMessageCommand09HL_B04
    ret

; entry 90 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_58C2_Case5A::
Jump_004_5FED:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $03
    ld [wScriptParam1], a
    ld de, $00E5
    call StartMessageScriptDE_B04
    ret

; entry 91 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_58C2_Case5B::
Jump_004_5FFE:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5C
    ld [wScriptParam1], a
    ld de, $00E6
    call StartMessageScriptDE_B04
    ret

; entry 92 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_58C2_Case5C::
Jump_004_600F:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $06
    ld [wScriptParam1], a
    ld de, $00E7
    call StartMessageScriptDE_B04
    ret

; entry 93 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_58C2_Case5D::
Jump_004_6020:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $02
    ld [wScriptParam1], a
    ld de, $00E8
    call StartMessageScriptDE_B04
    ret

; entry 94 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_58C2_Case5E::
Jump_004_6031:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $28
    ld [wScriptParam1], a
    ld de, $00F2
    call StartMessageScriptDE_B04
    ret

; entry 95 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case5F::
Jump_004_6042:: ; address name
    ld hl, $0861
    call StartMessageCommand09HL_B04
    ret

; entry 96 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_58C2_Case60::
Jump_004_6049:: ; address name
    ld a, $02
    ld [wScriptParam0], a
    ld a, $1D
    ld [wScriptParam1], a
    ld de, $00E9
    call StartMessageScriptDE_B04
    ret

; entry 97 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_58C2_Case61::
Jump_004_605A:: ; address name
    ld a, $02
    ld [wScriptParam0], a
    ld a, $1A
    ld [wScriptParam1], a
    ld de, $00EA
    call StartMessageScriptDE_B04
    ret

; entry 98 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_58C2_Case62::
Jump_004_606B:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $51
    ld [wScriptParam1], a
    ld de, $00EB
    call StartMessageScriptDE_B04
    ret

; entry 99 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_58C2_Case63::
Jump_004_607C:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $20
    ld [wScriptParam1], a
    ld de, $00EC
    call StartMessageScriptDE_B04
    ret

; entry 100 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_58C2_Case64::
Jump_004_608D:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $0C
    ld [wScriptParam1], a
    ld de, $00ED
    call StartMessageScriptDE_B04
    ret

; entry 101 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_58C2_Case65::
Jump_004_609E:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $0F
    ld [wScriptParam1], a
    ld de, $00EE
    call StartMessageScriptDE_B04
    ret

; entry 102 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_58C2_Case66::
Jump_004_60AF:: ; address name
    ld a, $02
    ld [wScriptParam0], a
    ld a, $04
    ld [wScriptParam1], a
    ld de, $00EF
    call StartMessageScriptDE_B04
    ret

; entry 103 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_58C2_Case67::
Jump_004_60C0:: ; address name
    ld a, $02
    ld [wScriptParam0], a
    ld a, $10
    ld [wScriptParam1], a
    ld de, $00F0
    call StartMessageScriptDE_B04
    ret

; entry 104 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case68::
Jump_004_60D1:: ; address name
    ld hl, $0862
    call StartMessageCommand09HL_B04
    ret

; entry 105 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case69::
Jump_004_60D8:: ; address name
    ld hl, $0864
    call StartMessageCommand09HL_B04
    ret

; entry 106 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
Func_004_58C2_Case6A::
Jump_004_60DF:: ; address name
    ld hl, $5CCF
    call StartScriptAtHL_B04
    ld a, $31
    ldh [hTemp0], a
    farcall FindHFFC6InWC61DList
    farcall RemoveInventorySlotShiftDown
    ld de, $007A
    call SetFlagBit
    ret

; entry 107 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case6B::
Jump_004_60FC:: ; address name
    ld hl, $00FF
    call StartMessageCommand09HL_B04
    ret

; entry 108 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
Func_004_58C2_Case6C::
Jump_004_6103:: ; address name
    ld hl, $5D44
    call StartScriptAtHL_B04
    ret

; entry 109 of the `rst $00` table in Func_004_58C2
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
Func_004_58C2_Case6D::
Jump_004_610A:: ; address name
    ld a, $1F
    ld [wDataBank], a
    ld de, $0202
    call TestFlagBit
    jr c, Jump_004_6124
    ld hl, $5D4D
    call StartScriptAtHL_B04
    ld de, $0202
    call SetFlagBit
    ret

Jump_004_6124::
    ld hl, $5D54
    call StartScriptAtHL_B04
    ret

; only called from DispatchTalkEvent_Case02 (E-0047)
; 1 call site from 1 routine (e.g. DispatchTalkEvent_Case02)
; reads: wTalkEventGroup
DispatchTalkEvent_Case02_Sub01::
Func_004_612B:: ; address name
    ld a, [wTalkEventGroup]
    rst $00
    dw Func_004_612B_Case00
    dw Func_004_612B_Case01
    dw Func_004_612B_Case02
    dw Func_004_612B_Case03
    dw Func_004_612B_Case04
    dw Func_004_612B_Case05
    dw Func_004_612B_Case06
    dw Func_004_612B_Case07
    dw Func_004_612B_Case08
    dw Func_004_612B_Case09
    dw Func_004_612B_Case0A
    dw Func_004_612B_Case0B
    dw Func_004_612B_Case0C
    dw Func_004_612B_Case0D
    dw Func_004_612B_Case0E
    dw Func_004_612B_Case0F
    dw Func_004_612B_Case10
    dw Func_004_612B_Case11
    dw Func_004_612B_Case12
    dw Func_004_612B_Case13
    dw Func_004_612B_Case14
    dw Func_004_612B_Case15
    dw Func_004_612B_Case16
    dw Func_004_612B_Case17
    dw Func_004_612B_Case18
    dw Func_004_612B_Case19
    dw Func_004_612B_Case1A
    dw Func_004_612B_Case1B
    dw Func_004_612B_Case1C
    dw Func_004_612B_Case1D
    dw Func_004_612B_Case1E
    dw Func_004_612B_Case1F
    dw Func_004_612B_Case20
    dw Func_004_612B_Case21
    dw Func_004_612B_Case22
    dw Func_004_612B_Case23
    dw Func_004_612B_Case24
    dw Func_004_612B_Case25
    dw Func_004_612B_Case26
    dw Func_004_612B_Case27
    dw Func_004_612B_Case28
    dw Func_004_612B_Case29
    dw Func_004_612B_Case2A
    dw Func_004_612B_Case2B
    dw Func_004_612B_Case2C
    dw Func_004_612B_Case2D
    dw Func_004_612B_Case2E
    dw Func_004_612B_Case2F
    dw Func_004_612B_Case30
    dw Func_004_612B_Case31
    dw Func_004_612B_Case32
    dw Func_004_612B_Case33
    dw Func_004_612B_Case34
    dw Func_004_612B_Case35
    dw Func_004_612B_Case36
    dw Func_004_612B_Case37
    dw Func_004_612B_Case38
    dw Func_004_612B_Case39
    dw Func_004_612B_Case3A
    dw Func_004_612B_Case3B
    dw Func_004_612B_Case3C
    dw Func_004_612B_Case3D
    dw Func_004_612B_Case3E
    dw Func_004_612B_Case3F
    dw Func_004_612B_Case40
    dw Func_004_612B_Case41
    dw Func_004_612B_Case42
    dw Func_004_612B_Case43
    dw Func_004_612B_Case44
    dw Func_004_612B_Case45

; entry 0 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case00::
Jump_004_61BB:: ; address name
    ld hl, $0130
    call StartMessageCommand09HL_B04
    ret

; entry 1 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case01::
Jump_004_61C2:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_61D1
    ld hl, $0131
    call StartMessageCommand09HL_B04
    ret

Jump_004_61D1::
    ld hl, $01A3
    call StartMessageCommand09HL_B04
    ret

; entry 2 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case02::
Jump_004_61D8:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_61E7
    ld hl, $0132
    call StartMessageCommand09HL_B04
    ret

Jump_004_61E7::
    ld hl, $01A4
    call StartMessageCommand09HL_B04
    ret

; entry 3 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case03::
Jump_004_61EE:: ; address name
    ld hl, $0133
    call StartMessageCommand09HL_B04
    ret

; entry 4 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case04::
Jump_004_61F5:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_6204
    ld hl, $0134
    call StartMessageCommand09HL_B04
    ret

Jump_004_6204::
    ld hl, $01A5
    call StartMessageCommand09HL_B04
    ret

; entry 5 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case05::
Jump_004_620B:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_621A
    ld hl, $0135
    call StartMessageCommand09HL_B04
    ret

Jump_004_621A::
    ld hl, $5B64
    call StartScriptAtHL_B04
    ret

; entry 6 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case06::
Jump_004_6221:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_6230
    ld hl, $0136
    call StartMessageCommand09HL_B04
    ret

Jump_004_6230::
    ld hl, $0D07
    call StartMessageCommand09HL_B04
    ret

; entry 7 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case07::
Jump_004_6237:: ; address name
    ld hl, $0137
    call StartMessageCommand09HL_B04
    ret

; entry 8 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_612B_Case08::
Jump_004_623E:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $0046
    call StartMessageScriptDE_B04
    ret

; entry 9 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case09::
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
    ld hl, $0138
    call StartMessageCommand09HL_B04
    ret

Jump_004_626E::
    ld hl, $0173
    call StartMessageCommand09HL_B04
    ret

Jump_004_6275::
    ld hl, $017A
    call StartMessageCommand09HL_B04
    ret

Jump_004_627C::
    ld hl, $0D08
    call StartMessageCommand09HL_B04
    ret

; entry 10 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX
; writes: wSpriteSlots, wDataBank
Func_004_612B_Case0A::
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
    ld hl, $59BA
    call StartScriptAtHL_B04
    ld a, $10
    ld [wDataBank], a
    ret

; entry 11 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case0B::
Jump_004_629F:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_62AE
    ld hl, $0139
    call StartMessageCommand09HL_B04
    ret

Jump_004_62AE::
    ld hl, $01A6
    call StartMessageCommand09HL_B04
    ret

; entry 12 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case0C::
Jump_004_62B5:: ; address name
    ld hl, $013A
    call StartMessageCommand09HL_B04
    ret

; entry 13 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case0D::
Jump_004_62BC:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_62CB
    ld hl, $013B
    call StartMessageCommand09HL_B04
    ret

Jump_004_62CB::
    ld hl, $0D0B
    call StartMessageCommand09HL_B04
    ret

; entry 14 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case0E::
Jump_004_62D2:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_62E1
    ld hl, $013C
    call StartMessageCommand09HL_B04
    ret

Jump_004_62E1::
    ld hl, $0D0A
    call StartMessageCommand09HL_B04
    ret

; entry 15 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case0F::
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
    ld hl, $013D
    call StartMessageCommand09HL_B04
    ret

Jump_004_630F::
    ld hl, $0168
    call StartMessageCommand09HL_B04
    ld de, $0048
    call SetFlagBit
    ret

Jump_004_631C::
    ld hl, $0168
    call StartMessageCommand09HL_B04
    ret

Jump_004_6323::
    ld hl, $017B
    call StartMessageCommand09HL_B04
    ret

Jump_004_632A::
    ld hl, $0D09
    call StartMessageCommand09HL_B04
    ret

; entry 16 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case10::
Jump_004_6331:: ; address name
    ld hl, $013E
    call StartMessageCommand09HL_B04
    ret

; entry 17 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case11::
Jump_004_6338:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_6347
    ld hl, $013F
    call StartMessageCommand09HL_B04
    ret

Jump_004_6347::
    ld hl, $01A7
    call StartMessageCommand09HL_B04
    ret

; entry 18 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenTableIndex, wDataBank
Func_004_612B_Case12::
Jump_004_634E:: ; address name
    ld a, $03
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld de, $0040
    call TestFlagBit
    jr c, Jump_004_636D
    ld hl, Data_010_59C1
    call StartScriptAtHL_B04
    ld de, $0040
    call SetFlagBit
    ret

Jump_004_636D::
    ld hl, $59C8
    call StartScriptAtHL_B04
    ret

; entry 19 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case13::
Jump_004_6374:: ; address name
    ld de, $0043
    call TestFlagBit
    jr c, Jump_004_6383
    ld hl, $0140
    call StartMessageCommand09HL_B04
    ret

Jump_004_6383::
    ld hl, $016A
    call StartMessageCommand09HL_B04
    ret

; entry 20 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case14::
Jump_004_638A:: ; address name
    ld de, $0053
    call TestFlagBit
    jr c, Jump_004_63A8
    ld de, $0043
    call TestFlagBit
    jr c, Jump_004_63A1
    ld hl, $0141
    call StartMessageCommand09HL_B04
    ret

Jump_004_63A1::
    ld hl, $016B
    call StartMessageCommand09HL_B04
    ret

Jump_004_63A8::
    ld hl, $017C
    call StartMessageCommand09HL_B04
    ret

; entry 21 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case15::
Jump_004_63AF:: ; address name
    ld de, $0053
    call TestFlagBit
    jr c, Jump_004_63BE
    ld hl, $0142
    call StartMessageCommand09HL_B04
    ret

Jump_004_63BE::
    ld hl, $017D
    call StartMessageCommand09HL_B04
    ret

; entry 22 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case16::
Jump_004_63C5:: ; address name
    ld hl, $0143
    call StartMessageCommand09HL_B04
    ret

; entry 23 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
Func_004_612B_Case17::
Jump_004_63CC:: ; address name
    ld a, $1F
    ld [wDataBank], a
    ld de, $0041
    call TestFlagBit
    jr c, Jump_004_63E6
    ld hl, Data_01F_59CF
    call StartScriptAtHL_B04
    ld de, $0041
    call SetFlagBit
    ret

Jump_004_63E6::
    ld hl, $59D6
    call StartScriptAtHL_B04
    ret

; entry 24 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount, wStepArrived
Func_004_612B_Case18::
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
    ld hl, $59DD
    call StartScriptAtHL_B04
    ret

Jump_004_640F::
    ld hl, $59F7
    call StartScriptAtHL_B04
    ret

Jump_004_6416::
    ld hl, $5A07
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
    ld hl, $5A17
    call StartScriptAtHL_B04
    ret

Jump_004_6437::
    ld hl, $014E
    call StartMessageCommand09HL_B04
    ret

; entry 25 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case19::
Jump_004_643E:: ; address name
    ld hl, $014F
    call StartMessageCommand09HL_B04
    ret

; entry 26 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_612B_Case1A::
Jump_004_6445:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $06
    ld [wScriptParam1], a
    ld de, $0047
    call StartMessageScriptDE_B04
    ret

; entry 27 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case1B::
Jump_004_6456:: ; address name
    ld hl, $0137
    call StartMessageCommand09HL_B04
    ret

; entry 28 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case1C::
Jump_004_645D:: ; address name
    ld de, $0056
    call TestFlagBit
    ret nc
    ld hl, $018F
    call StartMessageCommand09HL_B04
    ret

; entry 29 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case1D::
Jump_004_646B:: ; address name
    ld hl, $01BE
    call StartMessageCommand09HL_B04
    ret

; entry 30 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case1E::
Jump_004_6472:: ; address name
    ld hl, $0037
    call StartMessageCommand09HL_B04
    ret

; entry 31 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
Func_004_612B_Case1F::
Jump_004_6479:: ; address name
    ld hl, $5A25
    call StartScriptAtHL_B04
    ld a, $10
    ld [wDataBank], a
    ret

; entry 32 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case20::
Jump_004_6485:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_6494
    ld hl, $0150
    call StartMessageCommand09HL_B04
    ret

Jump_004_6494::
    ld hl, $01A8
    call StartMessageCommand09HL_B04
    ret

; entry 33 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case21::
Jump_004_649B:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_64AA
    ld hl, $0154
    call StartMessageCommand09HL_B04
    ret

Jump_004_64AA::
    ld hl, $01A9
    call StartMessageCommand09HL_B04
    ret

; entry 34 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case22::
Jump_004_64B1:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_64C0
    ld hl, $0155
    call StartMessageCommand09HL_B04
    ret

Jump_004_64C0::
    ld hl, $01AA
    call StartMessageCommand09HL_B04
    ret

; entry 35 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case23::
Jump_004_64C7:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_64D6
    ld hl, $0156
    call StartMessageCommand09HL_B04
    ret

Jump_004_64D6::
    ld hl, $01AB
    call StartMessageCommand09HL_B04
    ret

; entry 36 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case24::
Jump_004_64DD:: ; address name
    ld hl, $0157
    call StartMessageCommand09HL_B04
    ret

; entry 37 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case25::
Jump_004_64E4:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_6502
    ld de, $0056
    call TestFlagBit
    jr c, Jump_004_64FB
    ld hl, $0158
    call StartMessageCommand09HL_B04
    ret

Jump_004_64FB::
    ld hl, $0192
    call StartMessageCommand09HL_B04
    ret

Jump_004_6502::
    ld hl, $01AC
    call StartMessageCommand09HL_B04
    ret

; entry 38 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case26::
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
    ld hl, $0159
    call StartMessageCommand09HL_B04
    ret

Jump_004_6528::
    ld hl, $017E
    call StartMessageCommand09HL_B04
    ret

Jump_004_652F::
    ld hl, $0191
    call StartMessageCommand09HL_B04
    ret

Jump_004_6536::
    ld hl, $01AD
    call StartMessageCommand09HL_B04
    ret

; entry 39 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case27::
Jump_004_653D:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_655B
    ld de, $0053
    call TestFlagBit
    jr c, Jump_004_6554
    ld hl, $5B57
    call StartScriptAtHL_B04
    ret

Jump_004_6554::
    ld hl, $017F
    call StartMessageCommand09HL_B04
    ret

Jump_004_655B::
    ld hl, $01AE
    call StartMessageCommand09HL_B04
    ret

; entry 40 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case28::
Jump_004_6562:: ; address name
    ld de, $0053
    call TestFlagBit
    jr c, Jump_004_6580
    ld de, $0049
    call TestFlagBit
    jr c, Jump_004_6579
    ld hl, $015A
    call StartMessageCommand09HL_B04
    ret

Jump_004_6579::
    ld hl, $0170
    call StartMessageCommand09HL_B04
    ret

Jump_004_6580::
    ld hl, $0180
    call StartMessageCommand09HL_B04
    ret

; entry 41 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags
Func_004_612B_Case29::
Jump_004_6587:: ; address name
    ld a, [wStoryFlags + $61]
    bit 3, a
    ret nz
    ld hl, $5B71
    call StartScriptAtHL_B04
    ret

; entry 42 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case2A::
Jump_004_6594:: ; address name
    ld hl, $015F
    call StartMessageCommand09HL_B04
    ret

; entry 43 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case2B::
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
    ld hl, $5A2C
    call StartScriptAtHL_B04
    ret

Jump_004_65DA::
    ld hl, $5A4C
    call StartScriptAtHL_B04
    ret

Jump_004_65E1::
    ld hl, $0164
    call StartMessageCommand09HL_B04
    ret

Jump_004_65E8::
    ld hl, $5A5C
    call StartScriptAtHL_B04
    ret

Jump_004_65EF::
    ld hl, $0174
    call StartMessageCommand09HL_B04
    ret

Jump_004_65F6::
    ld hl, $5AD6
    call StartScriptAtHL_B04
    ret

Jump_004_65FD::
    ld hl, $0190
    call StartMessageCommand09HL_B04
    ret

Jump_004_6604::
    ld hl, $01B0
    call StartMessageCommand09HL_B04
    ret

; entry 44 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case2C::
Jump_004_660B:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_661A
    ld hl, $0166
    call StartMessageCommand09HL_B04
    ret

Jump_004_661A::
    ld hl, $01B1
    call StartMessageCommand09HL_B04
    ret

; entry 45 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case2D::
Jump_004_6621:: ; address name
    ld de, $0056
    call TestFlagBit
    jr c, Jump_004_6630
    ld hl, $0167
    call StartMessageCommand09HL_B04
    ret

Jump_004_6630::
    ld hl, $0193
    call StartMessageCommand09HL_B04
    ret

; entry 46 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case2E::
Jump_004_6637:: ; address name
    ld de, $0049
    call TestFlagBit
    ret nc
    ld hl, $5A95
    call StartScriptAtHL_B04
    ld de, $004A
    call SetFlagBit
    ret

; entry 47 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_612B_Case2F::
Jump_004_664B:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $004B
    call StartMessageScriptDE_B04
    ret

; entry 48 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_612B_Case30::
Jump_004_665C:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $1A
    ld [wScriptParam1], a
    ld de, $004C
    call StartMessageScriptDE_B04
    ret

; entry 49 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_612B_Case31::
Jump_004_666D:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2C
    ld [wScriptParam1], a
    ld de, $004D
    call StartMessageScriptDE_B04
    ret

; entry 50 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_612B_Case32::
Jump_004_667E:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2B
    ld [wScriptParam1], a
    ld de, $004E
    call StartMessageScriptDE_B04
    ret

; entry 51 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_612B_Case33::
Jump_004_668F:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2A
    ld [wScriptParam1], a
    ld de, $004F
    call StartMessageScriptDE_B04
    ret

; entry 52 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_612B_Case34::
Jump_004_66A0:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $24
    ld [wScriptParam1], a
    ld de, $0050
    call StartMessageScriptDE_B04
    ret

; entry 53 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_612B_Case35::
Jump_004_66B1:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $29
    ld [wScriptParam1], a
    ld de, $0051
    call StartMessageScriptDE_B04
    ret

; entry 54 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_612B_Case36::
Jump_004_66C2:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $48
    ld [wScriptParam1], a
    ld de, $0052
    call StartMessageScriptDE_B04
    ret

; entry 55 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case37::
Jump_004_66D3:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_66E2
    ld hl, $5AAB
    call StartScriptAtHL_B04
    ret

Jump_004_66E2::
    ld hl, $5AD2
    call StartScriptAtHL_B04
    ret

; entry 56 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp0
Func_004_612B_Case38::
Jump_004_66E9:: ; address name
    ld de, $0056
    call TestFlagBit
    ret nc
    ld de, $0057
    call TestFlagBit
    jr c, Jump_004_6746
    ld a, $19
    ldh [hTemp0], a
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_004_673F
    ld a, $1A
    ldh [hTemp0], a
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_004_673F
    ld a, $1B
    ldh [hTemp0], a
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_004_673F
    ld a, $1C
    ldh [hTemp0], a
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_004_673F
    ld hl, $5B0D
    call StartScriptAtHL_B04
    ret

Jump_004_673F::
    ld hl, $5B1D
    call StartScriptAtHL_B04
    ret

Jump_004_6746::
    ld hl, $018E
    call StartMessageCommand09HL_B04
    ret

; entry 57 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags
; writes: wStoryFlags, hTemp0
Func_004_612B_Case39::
Jump_004_674D:: ; address name
    ld a, [wStoryFlags + $61]
    set 4, a
    ld [wStoryFlags + $61], a
    ld hl, $5B37
    call StartScriptAtHL_B04
    ld a, $30
    ldh [hTemp0], a
    farcall FindHFFC6InWC61DList
    farcall RemoveInventorySlotShiftDown
    ret

; entry 58 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case3A::
Jump_004_676C:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_677B
    ld hl, $0194
    call StartMessageCommand09HL_B04
    ret

Jump_004_677B::
    ld hl, $01B2
    call StartMessageCommand09HL_B04
    ret

; entry 59 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case3B::
Jump_004_6782:: ; address name
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_6791
    ld hl, $0195
    call StartMessageCommand09HL_B04
    ret

Jump_004_6791::
    ld hl, $01B4
    call StartMessageCommand09HL_B04
    ret

; entry 60 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
Func_004_612B_Case3C::
Jump_004_6798:: ; address name
    ld a, $03
    ldh [hTemp0], a
    farcall RunFieldCommandHFFC6
    ld de, $0059
    call TestFlagBit
    jr c, Jump_004_67B1
    ld hl, $5B3C
    call StartScriptAtHL_B04
    ret

Jump_004_67B1::
    ld hl, $5B49
    call StartScriptAtHL_B04
    ret

; entry 61 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case3D::
Jump_004_67B8:: ; address name
    ld hl, $01B5
    call StartMessageCommand09HL_B04
    ret

; entry 62 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case3E::
Jump_004_67BF:: ; address name
    ld hl, $01BC
    call StartMessageCommand09HL_B04
    ret

; entry 63 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case3F::
Jump_004_67C6:: ; address name
    ld hl, $01BD
    call StartMessageCommand09HL_B04
    ret

; entry 64 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case40::
Jump_004_67CD:: ; address name
    ld hl, $01C0
    call StartMessageCommand09HL_B04
    ret

; entry 65 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case41::
Jump_004_67D4:: ; address name
    ld hl, $01BF
    call StartMessageCommand09HL_B04
    ret

; entry 66 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_612B_Case42::
Jump_004_67DB:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $19
    ld [wScriptParam1], a
    ld de, $005B
    call StartMessageScriptDE_B04
    ret

; entry 67 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
Func_004_612B_Case43::
Jump_004_67EC:: ; address name
    ld de, $0058
    call TestFlagBit
    ret nc
    ld hl, $5B53
    call StartScriptAtHL_B04
    ret

; entry 68 of the `rst $00` table in Func_004_612B
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags
; writes: wStoryFlags
Func_004_612B_Case44::
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
Func_004_612B_Case45::
Jump_004_6806:: ; address name
    ld a, $1F
    ld [wDataBank], a
    ld de, $005D
    call TestFlagBit
    jr c, Jump_004_6820
    ld hl, Data_01F_5B76
    call StartScriptAtHL_B04
    ld de, $005D
    call SetFlagBit
    ret

Jump_004_6820::
    ld hl, $5B7D
    call StartScriptAtHL_B04
    ret

; only called from DispatchTalkEvent_Case06 (E-0047)
; 1 call site from 1 routine (e.g. DispatchTalkEvent_Case06)
; reads: wTalkEventGroup
DispatchTalkEvent_Case06_Sub01::
Func_004_6827:: ; address name
    ld a, [wTalkEventGroup]
    rst $00
    dw Func_004_6827_Case00
    dw Func_004_6827_Case01

; entry 0 of the `rst $00` table in Func_004_6827
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp0
Func_004_6827_Case00::
Jump_004_682F:: ; address name
    ld de, $00D2
    call TestFlagBit
    jr c, Jump_004_6875
    ld a, $36
    ldh [hTemp0], a
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_004_686E
    ld a, $37
    ldh [hTemp0], a
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_004_686E
    ld a, $38
    ldh [hTemp0], a
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_004_686E
    ld hl, $61AA
    call StartScriptAtHL_B04
    ret

Jump_004_686E::
    ld hl, $619D
    call StartScriptAtHL_B04
    ret

Jump_004_6875::
    ld hl, $61DC
    call StartScriptAtHL_B04
    ret

; entry 1 of the `rst $00` table in Func_004_6827
; no direct call (reached through a table, a jump or a vector)
Func_004_6827_Case01::
Jump_004_687C:: ; address name
    ld de, $00D0
    call TestFlagBit
    jr c, Jump_004_688B
    ld hl, $61E9
    call StartScriptAtHL_B04
    ret

Jump_004_688B::
    ld hl, $61F6
    call StartScriptAtHL_B04
    ret

; only called from DispatchTalkEvent_Case00 (E-0047)
; 1 call site from 1 routine (e.g. DispatchTalkEvent_Case00)
; reads: wTalkEventGroup
DispatchTalkEvent_Case00_Sub01::
Func_004_6892:: ; address name
    ld a, [wTalkEventGroup]
    rst $00
    dw Func_004_6892_Case00
    dw Func_004_6892_Case01
    dw Func_004_6892_Case02
    dw Func_004_6892_Case00
    dw Func_004_6892_Case04
    dw Func_004_6892_Case05
    dw Func_004_6892_Case06
    dw Func_004_6892_Case07
    dw Func_004_6892_Case08
    dw Func_004_6892_Case09
    dw Func_004_6892_Case0A
    dw Func_004_6892_Case0B
    dw Func_004_6892_Case0B
    dw Func_004_6892_Case0B
    dw Func_004_6892_Case0E
    dw Func_004_6892_Case0F
    dw Func_004_6892_Case10
    dw Func_004_6892_Case11
    dw Func_004_6892_Case12
    dw Func_004_6892_Case13
    dw Func_004_6892_Case14
    dw Func_004_6892_Case15
    dw Func_004_6892_Case16
    dw Func_004_6892_Case17
    dw Func_004_6892_Case18
    dw Func_004_6892_Case19
    dw Func_004_6892_Case1A
    dw Func_004_6892_Case1B
    dw Func_004_6892_Case1C
    dw Func_004_6892_Case1D
    dw Func_004_6892_Case1E
    dw Func_004_6892_Case1F
    dw Func_004_6892_Case20
    dw Func_004_6892_Case21
    dw Func_004_6892_Case22
    dw Func_004_6892_Case23
    dw Func_004_6892_Case24
    dw Func_004_6892_Case25
    dw Func_004_6892_Case26
    dw Func_004_6892_Case00

; entry 30 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case1E::
Jump_004_68E6:: ; address name
    ld hl, $5173
    call StartScriptAtHL_B04
    ret

; entry 29 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case1D::
Jump_004_68ED:: ; address name
    ld hl, $5171
    call StartScriptAtHL_B04
    ret

; entry 28 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case1C::
Jump_004_68F4:: ; address name
    ld de, $0024
    call TestFlagBit
    jr c, Jump_004_68FD
    ret

Jump_004_68FD::
    ld hl, $516F
    call StartScriptAtHL_B04
    ret

; entry 27 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case1B::
Jump_004_6904:: ; address name
    ld de, $0024
    call TestFlagBit
    jr c, Jump_004_690D
    ret

Jump_004_690D::
    ld hl, $516D
    call StartScriptAtHL_B04
    ret

; entry 26 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case1A::
Jump_004_6914:: ; address name
    ld hl, $516B
    call StartScriptAtHL_B04
    ret

; entry 25 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case19::
Jump_004_691B:: ; address name
    ld hl, $5169
    call StartScriptAtHL_B04
    ret

; entry 24 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case18::
Jump_004_6922:: ; address name
    ld hl, $515F
    call StartScriptAtHL_B04
    ret

; entry 31 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case1F::
Jump_004_6929:: ; address name
    ld hl, $5164
    call StartScriptAtHL_B04
    ret

; entry 21 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case15::
Jump_004_6930:: ; address name
    ld hl, $5155
    call StartScriptAtHL_B04
    ret

; entry 22 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case16::
Jump_004_6937:: ; address name
    ld hl, $5157
    call StartScriptAtHL_B04
    ret

; entry 23 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case17::
Jump_004_693E:: ; address name
    ld hl, $5159
    call StartScriptAtHL_B04
    ret

; entry 32 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case20::
Jump_004_6945:: ; address name
    ld hl, $515B
    call StartScriptAtHL_B04
    ret

; entry 33 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case21::
Jump_004_694C:: ; address name
    ld hl, $515D
    call StartScriptAtHL_B04
    ret

; entry 34 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerDelay, hPlayerFacing
; writes: wFollowerRecords, wScriptParam1
Func_004_6892_Case22::
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
    ld hl, $57E1
    call StartScriptAtHL_B04
    ret

; entry 35 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerDelay, wPartyCount, hPlayerFacing
; writes: wFollowerRecords, wScriptParam1
Func_004_6892_Case23::
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
    ld hl, $57E1
    call StartScriptAtHL_B04
    ret

; entry 36 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerDelay, wPartyCount, hPlayerFacing
; writes: wFollowerRecords, wScriptParam1
Func_004_6892_Case24::
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
    ld hl, $57E1
    call StartScriptAtHL_B04
    ret

; entry 37 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerDelay
Func_004_6892_Case25::
Jump_004_69AC:: ; address name
    ld a, [wFollowerDelay]
    or a, a
    ret nz
    ld hl, $57DC
    call StartScriptAtHL_B04
    ret

; entry 38 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
; writes: wFollowerDelay
Func_004_6892_Case26::
Jump_004_69B8:: ; address name
    xor a, a
    ld [wFollowerDelay], a
    ret

; entry 16 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case10::
Jump_004_69BD:: ; address name
    ld hl, $514B
    call StartScriptAtHL_B04
    ret

; entry 17 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case11::
Jump_004_69C4:: ; address name
    ld hl, $514D
    call StartScriptAtHL_B04
    ret

; entry 18 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case12::
Jump_004_69CB:: ; address name
    ld hl, $514F
    call StartScriptAtHL_B04
    ret

; entry 19 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case13::
Jump_004_69D2:: ; address name
    ld hl, $5151
    call StartScriptAtHL_B04
    ret

; entry 20 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case14::
Jump_004_69D9:: ; address name
    ld hl, $5153
    call StartScriptAtHL_B04
    ret

; entry 0 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case00::
Jump_004_69E0:: ; address name
    ret

; entry 1 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case01::
Jump_004_69E1:: ; address name
    ld hl, $512F
    call StartScriptAtHL_B04
    ret

; entry 2 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case02::
Jump_004_69E8:: ; address name
    ld hl, $5131
    call StartScriptAtHL_B04
    ret

; entry 4 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case04::
Jump_004_69EF:: ; address name
    ld hl, $5137
    call StartScriptAtHL_B04
    ret

; entry 5 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case05::
Jump_004_69F6:: ; address name
    ld hl, $5139
    call StartScriptAtHL_B04
    ret

; entry 6 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case06::
Jump_004_69FD:: ; address name
    ld hl, $513B
    call StartScriptAtHL_B04
    ret

; entry 7 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case07::
Jump_004_6A04:: ; address name
    ld hl, $513D
    call StartScriptAtHL_B04
    ret

; entry 8 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case08::
Jump_004_6A0B:: ; address name
    ld hl, $513F
    call StartScriptAtHL_B04
    ret

; entry 9 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case09::
Jump_004_6A12:: ; address name
    ld hl, $5141
    call StartScriptAtHL_B04
    ret

; entry 10 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case0A::
Jump_004_6A19:: ; address name
    ld hl, $5143
    call StartScriptAtHL_B04
    ret

; entry 11 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case0B::
Jump_004_6A20:: ; address name
    ld hl, $5145
    call StartScriptAtHL_B04
    ret

; entry 14 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case0E::
Jump_004_6A27:: ; address name
    ld hl, $5147
    call StartScriptAtHL_B04
    ret

; entry 15 of the `rst $00` table in Func_004_6892
; no direct call (reached through a table, a jump or a vector)
Func_004_6892_Case0F::
Jump_004_6A2E:: ; address name
    ld hl, $5149
    call StartScriptAtHL_B04
    ret

; only called from DispatchTalkEvent_Case07 (E-0047)
; 1 call site from 1 routine (e.g. DispatchTalkEvent_Case07)
; reads: wTalkEventGroup
DispatchTalkEvent_Case07_Sub01::
Func_004_6A35:: ; address name
    ld a, [wTalkEventGroup]
    rst $00
    dw Func_004_6A35_Case00
    dw Func_004_6A35_Case01
    dw Func_004_6A35_Case02
    dw Func_004_6A35_Case03
    dw Func_004_6A35_Case04
    dw Func_004_6A35_Case05
    dw Func_004_6A35_Case06
    dw Func_004_6A35_Case07
    dw Func_004_6A35_Case08
    dw Func_004_6A35_Case09
    dw Func_004_6A35_Case0A
    dw Func_004_6A35_Case0B
    dw Func_004_6A35_Case0C
    dw Func_004_6A35_Case0D
    dw Func_004_6A35_Case0E
    dw Func_004_6A35_Case0F
    dw Func_004_6A35_Case10
    dw Func_004_6A35_Case11
    dw Func_004_6A35_Case12
    dw Func_004_6A35_Case13
    dw Func_004_6A35_Case14
    dw Func_004_6A35_Case15
    dw Func_004_6A35_Case16
    dw Func_004_6A35_Case17
    dw Func_004_6A35_Case18
    dw Func_004_6A35_Case19
    dw Func_004_6A35_Case1A
    dw Func_004_6A35_Case1B
    db $00, $00, $00, $00, $00, $00, $00, $00, $9A, $6F, $6A, $70
    dw Data_004_7093
    dw Data_004_709A
    dw Data_004_70A1
    dw Data_004_70B2
    dw Data_004_70B9
    dw Data_004_70C0
    dw Data_004_70C7
    dw Data_004_70CE
    dw Data_004_70DF
    dw Talk0768_HeroPeeredIntoThe
    dw Talk0768_HeroPeeredIntoThe_70FC
    dw Talk078E_RobosterStoppedMovingEntirely
    dw Talk077B_HeroPeeredIntoThe
    db $A5, $71
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
    db $97, $74
    dw TalkMsg07AA_ThatDealerHowExpensive
    dw Talk07C1_WhatMonstersAttackedYou
    dw TalkMsg07AE_ThatDealersWaresCould
    dw Talk07AF_HowDoesThisOrnament
    dw TalkMsg07B8_WhoAreYouYou
    dw StartScript6496Or64A6ByFlag1BA
    dw Talk07BF_HeroFoundThePretty
    dw StartScript6509Or652CByFlag1C2
    dw Msg01C8_ThisIsAGreat
    dw Msg01C9_ThisIsAGreat
    db $8F, $76, $96, $76, $9D, $76, $A4, $76, $B5, $76
    dw Msg01CB_ThisIsAGreat
    dw TalkMsg0CFE
    dw Msg01CC_ThisIsAGreat
    dw Msg01CD_ThisIsAGreat
    dw Msg01CE_ThisIsAGreat
    db $16, $77
    ds $14, $00
    db $1D, $77, $24, $77, $2B, $77, $47, $77, $47, $77, $47, $77, $47, $77
    dw Talk0C17
    dw Msg01D5
    dw Msg01D6
    dw Msg01D8
    dw Msg01DA
    dw Msg01DB
    dw Msg01DC
    dw Msg01DE
    dw Msg01DF
    dw Msg0169_WereWorriedAboutThe
    dw Msg016B_TheKingIsSo
    dw Msg016C_SoHaveYouDiscovered
    dw Msg016D_KingTheCanalIs
    dw Msg016F_KingWhatNeverMind
    dw Msg0170_IFeelBadlyFor
    dw Msg0171_WhatOpenTheCanal
    dw Msg0172_KingArrghIKnow
    db $74, $78, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $7B, $78, $82, $78, $89, $78, $A5, $78, $A5, $78, $A5, $78, $A5, $78
    dw Talk0C2F
    dw Msg0175_ImMakingANew
    dw Msg0176_GaahYoureTooStrong
    dw Msg0177_KingWhatSoThats
    dw Msg0179_KingThisShouldSolve
    dw Msg017A_OhYouSayThat
    dw Msg017B_TheWellHasAmple
    dw Msg017D_HiDidYouHear
    dw Msg017E_TheKingSolvedOur
    dw Msg017F_OurKingWorkedTo
    dw Msg00D6_IllShowYouHow
    dw Msg00D7_HmMyRivalIs
    dw Msg00D8_FinallySomeoneToIgnite
    dw Msg00DA_YouHaveRaisedYour
    dw Msg00DB_WhatHowDidYou
    dw Msg00DC_AllThoseWhoStood
    dw Msg00DD_LetMeShowYou
    ds $10, $00
    db $D2, $79, $D9, $79, $E0, $79, $FC, $79, $FC, $79, $FC, $79, $FC, $79
    dw Talk0C47
    dw Msg00F5_ItIsAnItem
    dw Msg00F6_HelloWhatCanI
    dw Msg00F7_HelloWhatCanI
    dw Msg00F9_HelloWhatCanI
    dw Msg00FA_HelloWhatCanI
    dw Msg00FB_THEEND
    dw Msg00FD_HeyThatsMine0
    dw Msg00FE_TerryHereJustTake
    dw Msg00FF_Composing
    dw Msg01F3
    dw Msg01F4
    dw Msg01F5
    dw Msg01F7
    dw Msg01F8
    dw Msg01F9
    dw Msg01FA
    ds $10, $00

; entry 0 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
Func_004_6A35_Case00::
Jump_004_6BB9:: ; address name
    ld de, $0140
    call TestFlagBit
    jr c, Jump_004_6BC8
    ld hl, $6200
    call StartScriptAtHL_B04
    ret

Jump_004_6BC8::
    ld de, $0148
    call TestFlagBit
    ret c
    ld de, $0147
    call TestFlagBit
    ret nc
    ld hl, $624B
    call StartScriptAtHL_B04
    ret

; entry 1 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
Func_004_6A35_Case01::
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
    ld hl, $0701
    call StartMessageCommand09HL_B04
    ld de, $0141
    call SetFlagBit
    ret

Jump_004_6C1A::
    ld de, $0142
    call TestFlagBit
    jr c, Jump_004_6C29
    ld hl, $0702
    call StartMessageCommand09HL_B04
    ret

Jump_004_6C29::
    ld hl, $620C
    call StartScriptAtHL_B04
    ret

Jump_004_6C30::
    ld hl, $0706
    call StartMessageCommand09HL_B04
    ld de, $0145
    call SetFlagBit
    ret

Jump_004_6C3D::
    ld hl, $0715
    call StartMessageCommand09HL_B04
    ret

Jump_004_6C44::
    ld hl, $62AD
    call StartScriptAtHL_B04
    ret

Jump_004_6C4B::
    ld hl, $0738
    call StartMessageCommand09HL_B04
    ret

Jump_004_6C52::
    ld hl, $0746
    call StartMessageCommand09HL_B04
    ret

; entry 2 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
Func_004_6A35_Case02::
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
    ld hl, $6382
    call StartScriptAtHL_B04
    ret

Jump_004_6C80::
    ld hl, $0707
    call StartMessageCommand09HL_B04
    ld de, $0145
    call SetFlagBit
    ret

Jump_004_6C8D::
    ld hl, $6240
    call StartScriptAtHL_B04
    ret

Jump_004_6C94::
    ld hl, $0747
    call StartMessageCommand09HL_B04
    ld de, $0152
    call SetFlagBit
    ret

Jump_004_6CA1::
    ld hl, $0748
    call StartMessageCommand09HL_B04
    ret

; entry 3 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
Func_004_6A35_Case03::
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
    ld hl, $0708
    call StartMessageCommand09HL_B04
    ret

Jump_004_6CC7::
    ld hl, $0717
    call StartMessageCommand09HL_B04
    ret

Jump_004_6CCE::
    ld hl, $0755
    call StartMessageCommand09HL_B04
    ret

Jump_004_6CD5::
    ld hl, $0749
    call StartMessageCommand09HL_B04
    ret

; entry 4 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
Func_004_6A35_Case04::
Jump_004_6CDC:: ; address name
    ld de, $0151
    call TestFlagBit
    jr c, Jump_004_6CFA
    ld de, $0147
    call TestFlagBit
    jr c, Jump_004_6CF3
    ld hl, $0709
    call StartMessageCommand09HL_B04
    ret

Jump_004_6CF3::
    ld hl, $0718
    call StartMessageCommand09HL_B04
    ret

Jump_004_6CFA::
    ld hl, $074A
    call StartMessageCommand09HL_B04
    ret

; entry 5 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
Func_004_6A35_Case05::
Jump_004_6D01:: ; address name
    ld de, $0151
    call TestFlagBit
    jr c, Jump_004_6D10
    ld hl, $070A
    call StartMessageCommand09HL_B04
    ret

Jump_004_6D10::
    ld hl, $074B
    call StartMessageCommand09HL_B04
    ret

; entry 6 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
Func_004_6A35_Case06::
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
    ld hl, $070B
    call StartMessageCommand09HL_B04
    ret

Jump_004_6D36::
    ld hl, $071A
    call StartMessageCommand09HL_B04
    ret

Jump_004_6D3D::
    ld hl, $072C
    call StartMessageCommand09HL_B04
    ret

Jump_004_6D44::
    ld hl, $074C
    call StartMessageCommand09HL_B04
    ret

; entry 7 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
Func_004_6A35_Case07::
Jump_004_6D4B:: ; address name
    ld de, $0151
    call TestFlagBit
    jr c, Jump_004_6D5A
    ld hl, $070C
    call StartMessageCommand09HL_B04
    ret

Jump_004_6D5A::
    ld hl, $074D
    call StartMessageCommand09HL_B04
    ret

; entry 8 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
Func_004_6A35_Case08::
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
    ld hl, $070D
    call StartMessageCommand09HL_B04
    ret

Jump_004_6D80::
    ld hl, $071B
    call StartMessageCommand09HL_B04
    ret

Jump_004_6D87::
    ld hl, $072D
    call StartMessageCommand09HL_B04
    ret

Jump_004_6D8E::
    ld hl, $074E
    call StartMessageCommand09HL_B04
    ret

; entry 9 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
Func_004_6A35_Case09::
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
    ld hl, $0752
    call StartMessageCommand09HL_B04
    ret

Jump_004_6DB4::
    ld hl, $071C
    call StartMessageCommand09HL_B04
    ret

Jump_004_6DBB::
    ld hl, $072E
    call StartMessageCommand09HL_B04
    ret

Jump_004_6DC2::
    ld hl, $074F
    call StartMessageCommand09HL_B04
    ret

; entry 10 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenTableIndex, wDataBank
Func_004_6A35_Case0A::
Jump_004_6DC9:: ; address name
    ld a, $10
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_637B
    call StartScriptAtHL_B04
    ret

; entry 11 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
Func_004_6A35_Case0B::
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
    ld hl, $070F
    call StartMessageCommand09HL_B04
    ld de, $0144
    call SetFlagBit
    ret

Jump_004_6E17::
    ld hl, $6218
    call StartScriptAtHL_B04
    ret

Jump_004_6E1E::
    ld de, $0145
    call TestFlagBit
    jr c, Jump_004_6E2D
    ld hl, $0753
    call StartMessageCommand09HL_B04
    ret

Jump_004_6E2D::
    ld hl, $622C
    call StartScriptAtHL_B04
    ret

Jump_004_6E34::
    ld hl, $0714
    call StartMessageCommand09HL_B04
    ret

Jump_004_6E3B::
    ld hl, $072A
    call StartMessageCommand09HL_B04
    ld de, $014D
    call SetFlagBit
    ret

Jump_004_6E48::
    ld hl, $072B
    call StartMessageCommand09HL_B04
    ret

Jump_004_6E4F::
    ld hl, $0744
    call StartMessageCommand09HL_B04
    ret

; entry 12 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
Func_004_6A35_Case0C::
Jump_004_6E56:: ; address name
    ld de, $0148
    call TestFlagBit
    ret nc
    ld hl, $626A
    call StartScriptAtHL_B04
    ret

; entry 13 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
Func_004_6A35_Case0D::
Jump_004_6E64:: ; address name
    ld de, $014A
    call TestFlagBit
    jr c, Jump_004_6E73
    ld hl, $0723
    call StartMessageCommand09HL_B04
    ret

Jump_004_6E73::
    ld hl, $0726
    call StartMessageCommand09HL_B04
    ret

; entry 14 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
Func_004_6A35_Case0E::
Jump_004_6E7A:: ; address name
    ld de, $014A
    call TestFlagBit
    jr c, Jump_004_6E89
    ld hl, $6290
    call StartScriptAtHL_B04
    ret

Jump_004_6E89::
    ld hl, $62A0
    call StartScriptAtHL_B04
    ret

; entry 15 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
Func_004_6A35_Case0F::
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
    ld hl, $072F
    call StartMessageCommand09HL_B04
    ret

Jump_004_6EAF::
    ld hl, $0731
    call StartMessageCommand09HL_B04
    ld de, $014E
    call SetFlagBit
    ret

Jump_004_6EBC::
    ld hl, $0732
    call StartMessageCommand09HL_B04
    ret

Jump_004_6EC3::
    ld hl, $0750
    call StartMessageCommand09HL_B04
    ret

; entry 16 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
Func_004_6A35_Case10::
Jump_004_6ECA:: ; address name
    ld de, $0151
    call TestFlagBit
    jr c, Jump_004_6EE8
    ld de, $014C
    call TestFlagBit
    jr c, Jump_004_6EE1
    ld hl, $0730
    call StartMessageCommand09HL_B04
    ret

Jump_004_6EE1::
    ld hl, $0733
    call StartMessageCommand09HL_B04
    ret

Jump_004_6EE8::
    ld hl, $0751
    call StartMessageCommand09HL_B04
    ret

; entry 17 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
Func_004_6A35_Case11::
Jump_004_6EEF:: ; address name
    ld de, $0150
    call TestFlagBit
    jr c, Jump_004_6F04
    ld hl, $62BD
    call StartScriptAtHL_B04
    ld de, $0150
    call SetFlagBit
    ret

Jump_004_6F04::
    ld hl, $6313
    call StartScriptAtHL_B04
    ret

; entry 18 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
Func_004_6A35_Case12::
Jump_004_6F0B:: ; address name
    ld de, $014C
    call TestFlagBit
    ret nc
    ld hl, $6369
    call StartScriptAtHL_B04
    ld de, $0149
    call SetFlagBit
    ret

; entry 19 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_6A35_Case13::
Jump_004_6F1F:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2C
    ld [wScriptParam1], a
    ld de, $0153
    call StartMessageScriptDE_B04
    ret

; entry 20 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_6A35_Case14::
Jump_004_6F30:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $10
    ld [wScriptParam1], a
    ld de, $0154
    call StartMessageScriptDE_B04
    ret

; entry 21 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_6A35_Case15::
Jump_004_6F41:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $04
    ld [wScriptParam1], a
    ld de, $0155
    call StartMessageScriptDE_B04
    ret

; entry 22 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
Func_004_6A35_Case16::
Jump_004_6F52:: ; address name
    ld hl, $0756
    call StartMessageCommand09HL_B04
    ret

; entry 23 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
Func_004_6A35_Case17::
Jump_004_6F59:: ; address name
    ld hl, $0758
    call StartMessageCommand09HL_B04
    ret

; entry 24 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_6A35_Case18::
Jump_004_6F60:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $03
    ld [wScriptParam1], a
    ld de, $0156
    call StartMessageScriptDE_B04
    ret

; entry 25 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_6A35_Case19::
Jump_004_6F71:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2A
    ld [wScriptParam1], a
    ld de, $0157
    call StartMessageScriptDE_B04
    ret

; entry 26 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Func_004_6A35_Case1A::
Jump_004_6F82:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $12
    ld [wScriptParam1], a
    ld de, $0158
    call StartMessageScriptDE_B04
    ret

; entry 27 of the `rst $00` table in Func_004_6A35
; no direct call (reached through a table, a jump or a vector)
Func_004_6A35_Case1B::
Jump_004_6F93:: ; address name
    ld hl, $0757
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 7 constant message(s) depending on story flags and state; the first one in the code is $075F, whose string begins 'Kiral Fetch me my treasure from'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, wGameFlags836
; writes: hTemp0, wGameFlags836
Talk075F_KiralFetchMeMy:: ; heuristic: follows a terminator; C0
Func_004_6F9A:: ; address name
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
    ld hl, $6398
    call StartScriptAtHL_B04
    ret

Jump_004_6FDB::
    ld hl, $63BC
    call StartScriptAtHL_B04
    ret

Jump_004_6FE2::
    ld hl, $075F
    call StartMessageCommand09HL_B04
    ret

Jump_004_6FE9::
    ld hl, $6409
    call StartScriptAtHL_B04
    ret

Jump_004_6FF0::
    ld hl, $0778
    call StartMessageCommand09HL_B04
    ret

Jump_004_6FF7::
    ld a, $3C
    ldh [hTemp0], a
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_004_702B
    farcall RemoveInventorySlotShiftDown
    call InventoryHasFreeSlotCheck
    ld [hl], $17
    ld a, [wGameFlags836]
    set 6, a
    ld [wGameFlags836], a
    ld hl, $641B
    call StartScriptAtHL_B04
    ld a, $08
    ldh [hTemp0], a
    farcall MarkKeyEntryKindHFFC6Bit6
    ret

Jump_004_702B::
    ld hl, $077D
    call StartMessageCommand09HL_B04
    ret

Jump_004_7032::
    ld de, $0166
    call TestFlagBit
    jr c, Jump_004_7047
    ld hl, $0786
    call StartMessageCommand09HL_B04
    ld de, $0166
    call SetFlagBit
    ret

Jump_004_7047::
    ld hl, $0787
    call StartMessageCommand09HL_B04
    ret

Jump_004_704E::
    ld de, $0168
    call TestFlagBit
    jr c, Jump_004_7063
    ld hl, $0789
    call StartMessageCommand09HL_B04
    ld de, $0168
    call SetFlagBit
    ret

Jump_004_7063::
    ld hl, $078A
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 3 constant message(s) depending on story flags and state; the first one in the code is $075A, whose string begins 'Pii Ggzz Piiiiii'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; writes: wObject1
Talk075A_PiiGgzzPiiiiii:: ; heuristic: follows a terminator; C0
Func_004_706A:: ; address name
    ld de, $0167
    call TestFlagBit
    jr c, Jump_004_708C
    ld de, $0165
    call TestFlagBit
    jr c, Jump_004_7085
    xor a, a
    ld [wObject1 + $7], a
    ld hl, $075A
    call StartMessageCommand09HL_B04
    ret

Jump_004_7085::
    ld hl, $0788
    call StartMessageCommand09HL_B04
    ret

Jump_004_708C::
    ld hl, $078B
    call StartMessageCommand09HL_B04
    ret

Data_004_7093:: ; heuristic: target of a monotone pointer table; C0
    db $21, $60, $07, $CD, $BB, $55, $C9

Data_004_709A:: ; heuristic: target of a monotone pointer table; C0
    db $21, $61, $07, $CD, $BB, $55, $C9

Data_004_70A1:: ; heuristic: target of a monotone pointer table; C0
    db $3E, $01, $EA, $21, $C9, $3E, $2C, $EA, $22, $C9, $11, $5B, $01, $CD, $DF, $55
    db $C9

Data_004_70B2:: ; heuristic: target of a monotone pointer table; C0
    db $21, $62, $07, $CD, $BB, $55, $C9

Data_004_70B9:: ; heuristic: target of a monotone pointer table; C0
    db $21, $63, $07, $CD, $BB, $55, $C9

Data_004_70C0:: ; heuristic: target of a monotone pointer table; C0
    db $21, $64, $07, $CD, $BB, $55, $C9

Data_004_70C7:: ; heuristic: target of a monotone pointer table; C0
    db $21, $65, $07, $CD, $BB, $55, $C9

Data_004_70CE:: ; heuristic: target of a monotone pointer table; C0
    db $3E, $02, $EA, $21, $C9, $3E, $03, $EA, $22, $C9, $11, $5C, $01, $CD, $DF, $55
    db $C9

Data_004_70DF:: ; heuristic: target of a monotone pointer table; C0
    db $21, $66, $07, $CD, $BB, $55, $C9

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1 constant message(s) depending on story flags and state; the first one in the code is $0768, whose string begins '0 peered into the barrel. There'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
Talk0768_HeroPeeredIntoThe:: ; heuristic: target of a pointer table; C0
Func_004_70E6:: ; address name
    ld de, $015D
    call TestFlagBit
    jr c, Jump_004_70F5
    ld hl, $63DB
    call StartScriptAtHL_B04
    ret

Jump_004_70F5::
    ld hl, $0768
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1 constant message(s) depending on story flags and state; the first one in the code is $0768, whose string begins '0 peered into the barrel. There'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
Talk0768_HeroPeeredIntoThe_70FC:: ; heuristic: target of a pointer table; C0
Func_004_70FC:: ; address name
    ld de, $015E
    call TestFlagBit
    jr c, Jump_004_710B
    ld hl, $63E4
    call StartScriptAtHL_B04
    ret

Jump_004_710B::
    ld hl, $0768
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 2 constant message(s) depending on story flags and state; the first one in the code is $078E, whose string begins 'Roboster stopped moving entirely'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
Talk078E_RobosterStoppedMovingEntirely:: ; heuristic: target of a pointer table; C0
Func_004_7112:: ; address name
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
    ld hl, $63ED
    call StartScriptAtHL_B04
    ret

Jump_004_7141::
    ld hl, $63F4
    call StartScriptAtHL_B04
    ret

Jump_004_7148::
    ld hl, $63FB
    call StartScriptAtHL_B04
    ret

Jump_004_714F::
    ld hl, $6402
    call StartScriptAtHL_B04
    ret

Jump_004_7156::
    ld hl, $078E
    call StartMessageCommand09HL_B04
    ret

Jump_004_715D::
    ld hl, $078C
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 3 constant message(s) depending on story flags and state; the first one in the code is $077B, whose string begins '0 peered into the barrel. There'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: wGameFlags836
; writes: wGameFlags836
Talk077B_HeroPeeredIntoThe:: ; heuristic: target of a pointer table; C0
Func_004_7164:: ; address name
    ld de, $0164
    call TestFlagBit
    jr c, Jump_004_719E
    ld de, $0163
    call TestFlagBit
    jr c, Jump_004_717B
    ld hl, $6416
    call StartScriptAtHL_B04
    ret

Jump_004_717B::
    call InventoryHasFreeSlotCheck
    jr c, Jump_004_7187
    ld hl, $077B
    call StartMessageCommand09HL_B04
    ret

Jump_004_7187::
    ld [hl], $3C
    ld a, [wGameFlags836]
    set 6, a
    ld [wGameFlags836], a
    ld hl, $077A
    call StartMessageCommand09HL_B04
    ld de, $0164
    call SetFlagBit
    ret

Jump_004_719E::
    ld hl, $077C
    call StartMessageCommand09HL_B04
    ret
    db $21, $B7, $07, $CD, $BB, $55, $C9

; tests story flags in turn (flag $01C3 set: jr to Jump_004_71BB); when none of them branches, starts message $078F through StartMessageCommand09HL_B04 (script command $09); that string begins 'This is the town of Miagen.' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg078F_ThisIsTheTown:: ; heuristic: target of a pointer table; C0
Func_004_71AC:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_71BB
    ld hl, $078F
    call StartMessageCommand09HL_B04
    ret

Jump_004_71BB::
    ld hl, $0CE2
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to Jump_004_71E0; flag $01BC set: jr to Jump_004_71D9); when none of them branches, starts message $0790 through StartMessageCommand09HL_B04 (script command $09); that string begins 'Are you friends with monsters? You're' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0790_AreYouFriendsWith:: ; heuristic: target of a pointer table; C0
Func_004_71C2:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_71E0
    ld de, $01BC
    call TestFlagBit
    jr c, Jump_004_71D9
    ld hl, $0790
    call StartMessageCommand09HL_B04
    ret

Jump_004_71D9::
    ld hl, $07C6
    call StartMessageCommand09HL_B04
    ret

Jump_004_71E0::
    ld hl, $0CE3
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to Jump_004_71F6); when none of them branches, starts message $0791 through StartMessageCommand09HL_B04 (script command $09); that string begins 'Wow! You have monsters! Neat! Are' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0791_WowYouHaveMonsters:: ; heuristic: target of a pointer table; C0
Func_004_71E7:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_71F6
    ld hl, $0791
    call StartMessageCommand09HL_B04
    ret

Jump_004_71F6::
    ld hl, $0CE4
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to Jump_004_720C); when none of them branches, starts message $0792 through StartMessageCommand09HL_B04 (script command $09); that string begins 'Are your monsters good? I don't' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0792_AreYourMonstersGood:: ; heuristic: target of a pointer table; C0
Func_004_71FD:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_720C
    ld hl, $0792
    call StartMessageCommand09HL_B04
    ret

Jump_004_720C::
    ld hl, $0CE5
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to Jump_004_7231; flag $01BC set: jr to Jump_004_722A); when none of them branches, starts message $0793 through StartMessageCommand09HL_B04 (script command $09); that string begins 'Monsters can be good or bad.' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0793_MonstersCanBeGood:: ; heuristic: target of a pointer table; C0
Func_004_7213:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_7231
    ld de, $01BC
    call TestFlagBit
    jr c, Jump_004_722A
    ld hl, $0793
    call StartMessageCommand09HL_B04
    ret

Jump_004_722A::
    ld hl, $07C7
    call StartMessageCommand09HL_B04
    ret

Jump_004_7231::
    ld hl, $0CE6
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to Jump_004_7247); when none of them branches, starts message $0794 through StartMessageCommand09HL_B04 (script command $09); that string begins 'You appear to have the power' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0794_YouAppearToHave:: ; heuristic: target of a pointer table; C0
Func_004_7238:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_7247
    ld hl, $0794
    call StartMessageCommand09HL_B04
    ret

Jump_004_7247::
    ld hl, $0CE7
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 4 constant message(s) depending on story flags and state; the first one in the code is $07A4, whose string begins 'Could you humor this old man'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp0
Talk07A4_CouldYouHumorThis:: ; heuristic: target of a pointer table; C0
Func_004_724E:: ; address name
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
    ld hl, $6430
    call StartScriptAtHL_B04
    ret

Jump_004_7275::
    ld de, $01B2
    call TestFlagBit
    jr c, Jump_004_728A
    ld hl, $07A4
    call StartMessageCommand09HL_B04
    ld de, $01B2
    call SetFlagBit
    ret

Jump_004_728A::
    ld hl, $07A5
    call StartMessageCommand09HL_B04
    ret

Jump_004_7291::
    ld a, $3D
    ldh [hTemp0], a
    farcall FindHFFC6InWC61DList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_004_728A
    farcall RemoveInventorySlotShiftDown
    ld hl, $64CA
    call StartScriptAtHL_B04
    ret

Jump_004_72AE::
    ld hl, $07CE
    call StartMessageCommand09HL_B04
    ret

Jump_004_72B5::
    ld hl, $0CE8
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 3 constant message(s) depending on story flags and state; the first one in the code is $07A6, whose string begins 'Our daughter's only memento was taken'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: wGameFlags836
; writes: wGameFlags836
Talk07A6_OurDaughtersOnlyMemento:: ; heuristic: target of a pointer table; C0
Func_004_72BC:: ; address name
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
    ld hl, $6437
    call StartScriptAtHL_B04
    ret

Jump_004_72E3::
    ld hl, $07A6
    call StartMessageCommand09HL_B04
    ret

Jump_004_72EA::
    call InventoryHasFreeSlotCheck
    jr c, Jump_004_72F6
    ld hl, $64DC
    call StartScriptAtHL_B04
    ret

Jump_004_72F6::
    ld [hl], $0B
    ld a, [wGameFlags836]
    set 6, a
    ld [wGameFlags836], a
    ld hl, $64E3
    call StartScriptAtHL_B04
    ret

Jump_004_7307::
    ld hl, $07D3
    call StartMessageCommand09HL_B04
    ret

Jump_004_730E::
    ld hl, $0CE9
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to Jump_004_7342; flag $01BE set: jr to Jump_004_733B; flag $01B1 set: jr to Jump_004_7334); when none of them branches, starts message $0799 through StartMessageCommand09HL_B04 (script command $09); that string begins 'Monsters raided this house within the' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0799_MonstersRaidedThisHouse:: ; heuristic: target of a pointer table; C0
Func_004_7315:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_7342
    ld de, $01BE
    call TestFlagBit
    jr c, Jump_004_733B
    ld de, $01B1
    call TestFlagBit
    jr c, Jump_004_7334
    ld hl, $0799
    call StartMessageCommand09HL_B04
    ret

Jump_004_7334::
    ld hl, $07A7
    call StartMessageCommand09HL_B04
    ret

Jump_004_733B::
    ld hl, $07D4
    call StartMessageCommand09HL_B04
    ret

Jump_004_7342::
    ld hl, $0CEA
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to Jump_004_7376; flag $01BE set: jr to Jump_004_736F; flag $01B1 set: jr to Jump_004_7368); when none of them branches, starts message $079A through StartMessageCommand09HL_B04 (script command $09); that string begins 'The old people across the way' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg079A_TheOldPeopleAcross:: ; heuristic: target of a pointer table; C0
Func_004_7349:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_7376
    ld de, $01BE
    call TestFlagBit
    jr c, Jump_004_736F
    ld de, $01B1
    call TestFlagBit
    jr c, Jump_004_7368
    ld hl, $079A
    call StartMessageCommand09HL_B04
    ret

Jump_004_7368::
    ld hl, $07A8
    call StartMessageCommand09HL_B04
    ret

Jump_004_736F::
    ld hl, $07D5
    call StartMessageCommand09HL_B04
    ret

Jump_004_7376::
    ld hl, $0CEB
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to Jump_004_739B; flag $01BC set: jr to Jump_004_7394); when none of them branches, starts message $079B through StartMessageCommand09HL_B04 (script command $09); that string begins 'Monsters have taken to attacking the' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg079B_MonstersHaveTakenTo:: ; heuristic: target of a pointer table; C0
Func_004_737D:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_739B
    ld de, $01BC
    call TestFlagBit
    jr c, Jump_004_7394
    ld hl, $079B
    call StartMessageCommand09HL_B04
    ret

Jump_004_7394::
    ld hl, $07C8
    call StartMessageCommand09HL_B04
    ret

Jump_004_739B::
    ld hl, $0CEC
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to Jump_004_73C0; flag $01BC set: jr to Jump_004_73B9); when none of them branches, starts message $079C through StartMessageCommand09HL_B04 (script command $09); that string begins 'Grrrr! I'm so angry! Monsters stole' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg079C_GrrrrImSoAngry:: ; heuristic: target of a pointer table; C0
Func_004_73A2:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_73C0
    ld de, $01BC
    call TestFlagBit
    jr c, Jump_004_73B9
    ld hl, $079C
    call StartMessageCommand09HL_B04
    ret

Jump_004_73B9::
    ld hl, $07C9
    call StartMessageCommand09HL_B04
    ret

Jump_004_73C0::
    ld hl, $0CED
    call StartMessageCommand09HL_B04
    ret

; wD7FB = $11, wDataBank = $10, then StartScriptAtHL_B04 with HL = Data_010_643E (E-0119)
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenTableIndex, wDataBank
StartScript643EInBank10:: ; heuristic: target of a pointer table; C0
Func_004_73C7:: ; address name
    ld a, $11
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_643E
    call StartScriptAtHL_B04
    ret

; map event: wCB86 = 0 if hPlayerX = $30 else 1, starts script $6445 and sets wDataBank = $10 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX
; writes: wSpriteSlots, wDataBank
StartScript6445ByPlayerX30:: ; heuristic: target of a pointer table; C0
Func_004_73D8:: ; address name
    xor a, a
    ld [wSpriteSlots + $7], a
    ldh a, [hPlayerX]
    cp a, $30
    jr z, Jump_004_73E7
    ld a, $01
    ld [wSpriteSlots + $7], a

Jump_004_73E7::
    ld hl, $6445
    call StartScriptAtHL_B04
    ld a, $10
    ld [wDataBank], a
    ret

; tests story flags in turn (flag $01C3 set: jr to Jump_004_7411; flag $01BE set: jr to Jump_004_740A); when none of them branches, starts message $079F through StartMessageCommand09HL_B04 (script command $09); that string begins 'If you travel west along the' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg079F_IfYouTravelWest:: ; heuristic: target of a pointer table; C0
Func_004_73F3:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_7411
    ld de, $01BE
    call TestFlagBit
    jr c, Jump_004_740A
    ld hl, $079F
    call StartMessageCommand09HL_B04
    ret

Jump_004_740A::
    ld hl, $07D6
    call StartMessageCommand09HL_B04
    ret

Jump_004_7411::
    ld hl, $0CEE
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 3 constant message(s) depending on story flags and state; the first one in the code is $07D7, whose string begins 'Milayou I e been checking around,'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
Talk07D7_MilayouIEBeen:: ; heuristic: target of a pointer table; C0
Func_004_7418:: ; address name
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
    ld hl, $644C
    call StartScriptAtHL_B04
    ret

Jump_004_7457::
    ld hl, $6469
    call StartScriptAtHL_B04
    ret

Jump_004_745E::
    ld hl, $07D7
    call StartMessageCommand09HL_B04
    ret

Jump_004_7465::
    ld hl, $6501
    call StartScriptAtHL_B04
    ret

Jump_004_746C::
    ld hl, $07DD
    call StartMessageCommand09HL_B04
    ret

Jump_004_7473::
    ld hl, $654C
    call StartScriptAtHL_B04
    ret

Jump_004_747A::
    ld hl, $0CF1
    call StartMessageCommand09HL_B04
    ret

Jump_004_7481::
    ld de, $01C6
    call TestFlagBit
    jr c, Jump_004_7490
    ld hl, $6558
    call StartScriptAtHL_B04
    ret

Jump_004_7490::
    ld hl, $6578
    call StartScriptAtHL_B04
    ret
    db $21, $A9, $07, $CD, $BB, $55, $C9

; tests story flags in turn (flag $01C3 set: jr to Jump_004_74CB; flag $01BE set: jr to Jump_004_74C4; flag $01BB set: jr to Jump_004_74BD); when none of them branches, starts message $07AA through StartMessageCommand09HL_B04 (script command $09); that string begins 'That dealer, how expensive! Nobody can' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg07AA_ThatDealerHowExpensive:: ; heuristic: target of a pointer table; C0
Func_004_749E:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_74CB
    ld de, $01BE
    call TestFlagBit
    jr c, Jump_004_74C4
    ld de, $01BB
    call TestFlagBit
    jr c, Jump_004_74BD
    ld hl, $07AA
    call StartMessageCommand09HL_B04
    ret

Jump_004_74BD::
    ld hl, $07C0
    call StartMessageCommand09HL_B04
    ret

Jump_004_74C4::
    ld hl, $07D8
    call StartMessageCommand09HL_B04
    ret

Jump_004_74CB::
    ld hl, $0CF2
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 3 constant message(s) depending on story flags and state; the first one in the code is $07C1, whose string begins 'What? Monsters attacked you in the'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
Talk07C1_WhatMonstersAttackedYou:: ; heuristic: target of a pointer table; C0
Func_004_74D2:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_74FF
    ld de, $01BE
    call TestFlagBit
    jr c, Jump_004_74F8
    ld de, $01BB
    call TestFlagBit
    jr c, Jump_004_74F1
    ld hl, $6481
    call StartScriptAtHL_B04
    ret

Jump_004_74F1::
    ld hl, $07C1
    call StartMessageCommand09HL_B04
    ret

Jump_004_74F8::
    ld hl, $07D9
    call StartMessageCommand09HL_B04
    ret

Jump_004_74FF::
    ld hl, $0CF3
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to Jump_004_7533; flag $01C0 set: jr to Jump_004_752C; flag $01BB set: jr to Jump_004_7525); when none of them branches, starts message $07AE through StartMessageCommand09HL_B04 (script command $09); that string begins 'That dealer's wares Could he sell' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg07AE_ThatDealersWaresCould:: ; heuristic: target of a pointer table; C0
Func_004_7506:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_7533
    ld de, $01C0
    call TestFlagBit
    jr c, Jump_004_752C
    ld de, $01BB
    call TestFlagBit
    jr c, Jump_004_7525
    ld hl, $07AE
    call StartMessageCommand09HL_B04
    ret

Jump_004_7525::
    ld hl, $07C2
    call StartMessageCommand09HL_B04
    ret

Jump_004_752C::
    ld hl, $07DB
    call StartMessageCommand09HL_B04
    ret

Jump_004_7533::
    ld hl, $0CF4
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 8 constant message(s) depending on story flags and state; the first one in the code is $07AF, whose string begins 'How does this ornament look? Take'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags
; writes: wStoryFlags
Talk07AF_HowDoesThisOrnament:: ; heuristic: target of a pointer table; C0
Func_004_753A:: ; address name
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
    ld hl, $07AF
    call StartMessageCommand09HL_B04
    ld de, $01B3
    call SetFlagBit
    ret

Jump_004_7572::
    ld de, $01B4
    call TestFlagBit
    jr c, Jump_004_7587
    ld hl, $07B0
    call StartMessageCommand09HL_B04
    ld de, $01B4
    call SetFlagBit
    ret

Jump_004_7587::
    ld de, $01B5
    call TestFlagBit
    jr c, Jump_004_759C
    ld hl, $07B1
    call StartMessageCommand09HL_B04
    ld de, $01B5
    call SetFlagBit
    ret

Jump_004_759C::
    ld hl, $07B2
    call StartMessageCommand09HL_B04
    ret

Jump_004_75A3::
    ld de, $01B6
    call TestFlagBit
    jr c, Jump_004_75B8
    ld hl, $07B3
    call StartMessageCommand09HL_B04
    ld de, $01B6
    call SetFlagBit
    ret

Jump_004_75B8::
    ld de, $01B7
    call TestFlagBit
    jr c, Jump_004_75CD
    ld hl, $07B4
    call StartMessageCommand09HL_B04
    ld de, $01B7
    call SetFlagBit
    ret

Jump_004_75CD::
    ld de, $01B8
    call TestFlagBit
    jr c, Jump_004_75E2
    ld hl, $07B5
    call StartMessageCommand09HL_B04
    ld de, $01B8
    call SetFlagBit
    ret

Jump_004_75E2::
    ld de, $01B9
    call TestFlagBit
    jr c, Jump_004_759C
    ld hl, $648E
    call StartScriptAtHL_B04
    ret

Jump_004_75F1::
    ld hl, $64BE
    call StartScriptAtHL_B04
    ret

Jump_004_75F8::
    ld hl, $07C5
    call StartMessageCommand09HL_B04
    ret

Jump_004_75FF::
    ld hl, $64ED
    call StartScriptAtHL_B04
    ld a, [wStoryFlags + $68]
    set 0, a
    ld [wStoryFlags + $68], a
    ret

; tests story flags in turn (flag $01BA set: jr to Jump_004_761D); when none of them branches, starts message $07B8 through StartMessageCommand09HL_B04 (script command $09); that string begins 'Who are you? You shouldn't be' (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg07B8_WhoAreYouYou:: ; heuristic: target of a pointer table; C0
Func_004_760E:: ; address name
    ld de, $01BA
    call TestFlagBit
    jr c, Jump_004_761D
    ld hl, $07B8
    call StartMessageCommand09HL_B04
    ret

Jump_004_761D::
    ld hl, $07BA
    call StartMessageCommand09HL_B04
    ret

; map event: starts script $64A6 if story flag $1BA is set, else $6496 (E-0122)
; no direct call (reached through a table, a jump or a vector)
StartScript6496Or64A6ByFlag1BA:: ; heuristic: target of a pointer table; C0
Func_004_7624:: ; address name
    ld de, $01BA
    call TestFlagBit
    jr c, Jump_004_7633
    ld hl, $6496
    call StartScriptAtHL_B04
    ret

Jump_004_7633::
    ld hl, $64A6
    call StartScriptAtHL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1 constant message(s) depending on story flags and state; the first one in the code is $07BF, whose string begins '0 found the Pretty Ring. But'; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
; reads: wGameFlags836
; writes: wGameFlags836
Talk07BF_HeroFoundThePretty:: ; heuristic: target of a pointer table; C0
Func_004_763A:: ; address name
    call InventoryHasFreeSlotCheck
    jr c, Jump_004_7646
    ld hl, $07BF
    call StartMessageCommand09HL_B04
    ret

Jump_004_7646::
    ld [hl], $3D
    ld a, [wGameFlags836]
    set 6, a
    ld [wGameFlags836], a
    ld hl, $64B3
    call StartScriptAtHL_B04
    ret

; map event: starts script $652C if story flag $1C2 is set, else $6509 (E-0122)
; no direct call (reached through a table, a jump or a vector)
StartScript6509Or652CByFlag1C2:: ; heuristic: target of a pointer table; C0
Func_004_7657:: ; address name
    ld de, $01C2
    call TestFlagBit
    jr c, Jump_004_7666
    ld hl, $6509
    call StartScriptAtHL_B04
    ret

Jump_004_7666::
    ld hl, $652C
    call StartScriptAtHL_B04
    ret

; wScriptParam0 = 01, wScriptParam1 = 0E, then StartMessageScriptDE_B04 with DE = $01C8: starts message group 1, string $C8; on the normal ShowMessageHL path the string begins 'This is a great spot to' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01C8_ThisIsAGreat:: ; heuristic: target of a pointer table; C0
Func_004_766D:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $0E
    ld [wScriptParam1], a
    ld de, $01C8
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 01, wScriptParam1 = 2C, then StartMessageScriptDE_B04 with DE = $01C9: starts message group 1, string $C9; on the normal ShowMessageHL path the string begins 'This is a great spot to' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01C9_ThisIsAGreat:: ; heuristic: target of a pointer table; C0
Func_004_767E:: ; address name
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2C
    ld [wScriptParam1], a
    ld de, $01C9
    call StartMessageScriptDE_B04
    ret
    db $21, $FB, $0C, $CD, $BB, $55, $C9, $21, $FA, $0C, $CD, $BB, $55, $C9, $21, $FC
    db $0C, $CD, $BB, $55, $C9, $3E, $01, $EA, $21, $C9, $3E, $04, $EA, $22, $C9, $11
    db $CA, $01, $CD, $DF, $55, $C9, $21, $FD, $0C, $CD, $BB, $55, $C9

; wScriptParam0 = 00, wScriptParam1 = 08, then StartMessageScriptDE_B04 with DE = $01CB: starts message group 1, string $CB; on the normal ShowMessageHL path the string begins 'This is a great spot to' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01CB_ThisIsAGreat:: ; heuristic: target of a pointer table; C0
Func_004_76BC:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $08
    ld [wScriptParam1], a
    ld de, $01CB
    call StartMessageScriptDE_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to Jump_004_76DC); when none of them branches, starts message $0CFE through StartMessageCommand09HL_B04 (script command $09); that string is empty (E-0082)
; no direct call (reached through a table, a jump or a vector)
TalkMsg0CFE:: ; heuristic: target of a pointer table; C0
Func_004_76CD:: ; address name
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_76DC
    ld hl, $0CFE
    call StartMessageCommand09HL_B04
    ret

Jump_004_76DC::
    ld hl, $00A1
    call StartMessageCommand09HL_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 2A, then StartMessageScriptDE_B04 with DE = $01CC: starts message group 1, string $CC; on the normal ShowMessageHL path the string begins 'This is a great spot to' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01CC_ThisIsAGreat:: ; heuristic: target of a pointer table; C0
Func_004_76E3:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2A
    ld [wScriptParam1], a
    ld de, $01CC
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 2C, then StartMessageScriptDE_B04 with DE = $01CD: starts message group 1, string $CD; on the normal ShowMessageHL path the string begins 'This is a great spot to' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01CD_ThisIsAGreat:: ; heuristic: target of a pointer table; C0
Func_004_76F4:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2C
    ld [wScriptParam1], a
    ld de, $01CD
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 23, then StartMessageScriptDE_B04 with DE = $01CE: starts message group 1, string $CE; on the normal ShowMessageHL path the string begins 'This is a great spot to' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01CE_ThisIsAGreat:: ; heuristic: target of a pointer table; C0
Func_004_7705:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $23
    ld [wScriptParam1], a
    ld de, $01CE
    call StartMessageScriptDE_B04
    ret
    db $21, $95, $65, $CD, $03, $56, $C9, $21, $03, $0C, $CD, $BB, $55, $C9, $21, $02
    db $0C, $CD, $BB, $55, $C9, $11, $D3, $01, $CD, $1B, $18, $38, $0D, $21, $00, $0C
    db $CD, $BB, $55, $11, $D3, $01, $CD, $45, $18, $C9, $21, $01, $0C, $CD, $BB, $55
    db $C9, $21, $9C, $65, $CD, $03, $56, $C9

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1 constant message(s) depending on story flags and state; the first one in the code is $0C17, an empty string on the normal path; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
Talk0C17:: ; heuristic: target of a pointer table; C0
Func_004_774E:: ; address name
    ld de, $016E
    call TestFlagBit
    jr c, Jump_004_775D
    ld hl, $659C
    call StartScriptAtHL_B04
    ret

Jump_004_775D::
    ld hl, $0C17
    call StartMessageCommand09HL_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 2C, then StartMessageScriptDE_B04 with DE = $01D5: starts message group 1, string $D5; on the normal ShowMessageHL path the string is empty (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01D5:: ; heuristic: target of a pointer table; C0
Func_004_7764:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2C
    ld [wScriptParam1], a
    ld de, $01D5
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 48, then StartMessageScriptDE_B04 with DE = $01D6: starts message group 1, string $D6; on the normal ShowMessageHL path the string is empty (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01D6:: ; heuristic: target of a pointer table; C0
Func_004_7775:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $48
    ld [wScriptParam1], a
    ld de, $01D6
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 0A, then StartMessageScriptDE_B04 with DE = $01D8: starts message group 1, string $D8; on the normal ShowMessageHL path the string is empty (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01D8:: ; heuristic: target of a pointer table; C0
Func_004_7786:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $0A
    ld [wScriptParam1], a
    ld de, $01D8
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 01, then StartMessageScriptDE_B04 with DE = $01DA: starts message group 1, string $DA; on the normal ShowMessageHL path the string is empty (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01DA:: ; heuristic: target of a pointer table; C0
Func_004_7797:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $01DA
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 51, then StartMessageScriptDE_B04 with DE = $01DB: starts message group 1, string $DB; on the normal ShowMessageHL path the string is empty (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01DB:: ; heuristic: target of a pointer table; C0
Func_004_77A8:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $51
    ld [wScriptParam1], a
    ld de, $01DB
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 02, then StartMessageScriptDE_B04 with DE = $01DC: starts message group 1, string $DC; on the normal ShowMessageHL path the string is empty (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01DC:: ; heuristic: target of a pointer table; C0
Func_004_77B9:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $02
    ld [wScriptParam1], a
    ld de, $01DC
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 02, then StartMessageScriptDE_B04 with DE = $01DE: starts message group 1, string $DE; on the normal ShowMessageHL path the string is empty (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01DE:: ; heuristic: target of a pointer table; C0
Func_004_77CA:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $02
    ld [wScriptParam1], a
    ld de, $01DE
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 44, then StartMessageScriptDE_B04 with DE = $01DF: starts message group 1, string $DF; on the normal ShowMessageHL path the string is empty (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01DF:: ; heuristic: target of a pointer table; C0
Func_004_77DB:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $44
    ld [wScriptParam1], a
    ld de, $01DF
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 01, then StartMessageScriptDE_B04 with DE = $0169: starts message group 1, string $69; on the normal ShowMessageHL path the string begins 'We're worried about the well. The' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg0169_WereWorriedAboutThe:: ; heuristic: target of a pointer table; C0
Func_004_77EC:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $0169
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 02, then StartMessageScriptDE_B04 with DE = $016B: starts message group 1, string $6B; on the normal ShowMessageHL path the string begins 'The King is so frivolous. A' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg016B_TheKingIsSo:: ; heuristic: target of a pointer table; C0
Func_004_77FD:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $02
    ld [wScriptParam1], a
    ld de, $016B
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 5F, then StartMessageScriptDE_B04 with DE = $016C: starts message group 1, string $6C; on the normal ShowMessageHL path the string begins 'So, have you discovered what concerns' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg016C_SoHaveYouDiscovered:: ; heuristic: target of a pointer table; C0
Func_004_780E:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5F
    ld [wScriptParam1], a
    ld de, $016C
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 4E, then StartMessageScriptDE_B04 with DE = $016D: starts message group 1, string $6D; on the normal ShowMessageHL path the string begins 'King The canal is managed by' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg016D_KingTheCanalIs:: ; heuristic: target of a pointer table; C0
Func_004_781F:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $4E
    ld [wScriptParam1], a
    ld de, $016D
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 4C, then StartMessageScriptDE_B04 with DE = $016F: starts message group 1, string $6F; on the normal ShowMessageHL path the string begins 'King What? Never mind, then! I'll' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg016F_KingWhatNeverMind:: ; heuristic: target of a pointer table; C0
Func_004_7830:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $4C
    ld [wScriptParam1], a
    ld de, $016F
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 4D, then StartMessageScriptDE_B04 with DE = $0170: starts message group 1, string $70; on the normal ShowMessageHL path the string begins 'I feel badly for his Majesty,' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg0170_IFeelBadlyFor:: ; heuristic: target of a pointer table; C0
Func_004_7841:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $4D
    ld [wScriptParam1], a
    ld de, $0170
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 01, then StartMessageScriptDE_B04 with DE = $0171: starts message group 1, string $71; on the normal ShowMessageHL path the string begins 'What? Open the Canal Gate more?' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg0171_WhatOpenTheCanal:: ; heuristic: target of a pointer table; C0
Func_004_7852:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $0171
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 2C, then StartMessageScriptDE_B04 with DE = $0172: starts message group 1, string $72; on the normal ShowMessageHL path the string begins 'King Arrgh! I know that! I' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg0172_KingArrghIKnow:: ; heuristic: target of a pointer table; C0
Func_004_7863:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2C
    ld [wScriptParam1], a
    ld de, $0172
    call StartMessageScriptDE_B04
    ret
    db $21, $9E, $65, $CD, $03, $56, $C9, $21, $1B, $0C, $CD, $BB, $55, $C9, $21, $1A
    db $0C, $CD, $BB, $55, $C9, $11, $73, $01, $CD, $1B, $18, $38, $0D, $21, $18, $0C
    db $CD, $BB, $55, $11, $73, $01, $CD, $45, $18, $C9, $21, $19, $0C, $CD, $BB, $55
    db $C9, $21, $9C, $65, $CD, $03, $56, $C9

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1 constant message(s) depending on story flags and state; the first one in the code is $0C2F, an empty string on the normal path; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
Talk0C2F:: ; heuristic: target of a pointer table; C0
Func_004_78AC:: ; address name
    ld de, $00D9
    call TestFlagBit
    jr c, Jump_004_78BB
    ld hl, $659C
    call StartScriptAtHL_B04
    ret

Jump_004_78BB::
    ld hl, $0C2F
    call StartMessageCommand09HL_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 0A, then StartMessageScriptDE_B04 with DE = $0175: starts message group 1, string $75; on the normal ShowMessageHL path the string begins 'I'm making a new home for' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg0175_ImMakingANew:: ; heuristic: target of a pointer table; C0
Func_004_78C2:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $0A
    ld [wScriptParam1], a
    ld de, $0175
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 4A, then StartMessageScriptDE_B04 with DE = $0176: starts message group 1, string $76; on the normal ShowMessageHL path the string begins 'Gaah! You're too strong! You win!' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg0176_GaahYoureTooStrong:: ; heuristic: target of a pointer table; C0
Func_004_78D3:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $4A
    ld [wScriptParam1], a
    ld de, $0176
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 2A, then StartMessageScriptDE_B04 with DE = $0177: starts message group 1, string $77; on the normal ShowMessageHL path the string begins 'King What? So that's the truth?' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg0177_KingWhatSoThats:: ; heuristic: target of a pointer table; C0
Func_004_78E4:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2A
    ld [wScriptParam1], a
    ld de, $0177
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 01, then StartMessageScriptDE_B04 with DE = $0179: starts message group 1, string $79; on the normal ShowMessageHL path the string begins 'King This should solve the water' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg0179_KingThisShouldSolve:: ; heuristic: target of a pointer table; C0
Func_004_78F5:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $0179
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 09, then StartMessageScriptDE_B04 with DE = $017A: starts message group 1, string $7A; on the normal ShowMessageHL path the string begins 'Oh? You say that a monster' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg017A_OhYouSayThat:: ; heuristic: target of a pointer table; C0
Func_004_7906:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $09
    ld [wScriptParam1], a
    ld de, $017A
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 61, then StartMessageScriptDE_B04 with DE = $017B: starts message group 1, string $7B; on the normal ShowMessageHL path the string begins 'The well has ample water again.' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg017B_TheWellHasAmple:: ; heuristic: target of a pointer table; C0
Func_004_7917:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $61
    ld [wScriptParam1], a
    ld de, $017B
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 2A, then StartMessageScriptDE_B04 with DE = $017D: starts message group 1, string $7D; on the normal ShowMessageHL path the string begins 'Hi! Did you hear the news?' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg017D_HiDidYouHear:: ; heuristic: target of a pointer table; C0
Func_004_7928:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2A
    ld [wScriptParam1], a
    ld de, $017D
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 52, then StartMessageScriptDE_B04 with DE = $017E: starts message group 1, string $7E; on the normal ShowMessageHL path the string begins 'The King solved our water shortage' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg017E_TheKingSolvedOur:: ; heuristic: target of a pointer table; C0
Func_004_7939:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $52
    ld [wScriptParam1], a
    ld de, $017E
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 07, then StartMessageScriptDE_B04 with DE = $017F: starts message group 1, string $7F; on the normal ShowMessageHL path the string begins 'Our King worked to save all' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg017F_OurKingWorkedTo:: ; heuristic: target of a pointer table; C0
Func_004_794A:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $07
    ld [wScriptParam1], a
    ld de, $017F
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 46, then StartMessageScriptDE_B04 with DE = $00D6: starts message group 0, string $D6; on the normal ShowMessageHL path the string begins 'I'll show you how small you' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg00D6_IllShowYouHow:: ; heuristic: target of a pointer table; C0
Func_004_795B:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $46
    ld [wScriptParam1], a
    ld de, $00D6
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 02, then StartMessageScriptDE_B04 with DE = $00D7: starts message group 0, string $D7; on the normal ShowMessageHL path the string begins 'Hm? My rival is here? Come' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg00D7_HmMyRivalIs:: ; heuristic: target of a pointer table; C0
Func_004_796C:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $02
    ld [wScriptParam1], a
    ld de, $00D7
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 60, then StartMessageScriptDE_B04 with DE = $00D8: starts message group 0, string $D8; on the normal ShowMessageHL path the string begins 'Finally, someone to ignite my soul!' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg00D8_FinallySomeoneToIgnite:: ; heuristic: target of a pointer table; C0
Func_004_797D:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $60
    ld [wScriptParam1], a
    ld de, $00D8
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 01, then StartMessageScriptDE_B04 with DE = $00DA: starts message group 0, string $DA; on the normal ShowMessageHL path the string begins 'You have raised your charges well.' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg00DA_YouHaveRaisedYour:: ; heuristic: target of a pointer table; C0
Func_004_798E:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $00DA
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 4F, then StartMessageScriptDE_B04 with DE = $00DB: starts message group 0, string $DB; on the normal ShowMessageHL path the string begins 'What? How did you get here?' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg00DB_WhatHowDidYou:: ; heuristic: target of a pointer table; C0
Func_004_799F:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $4F
    ld [wScriptParam1], a
    ld de, $00DB
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 5D, then StartMessageScriptDE_B04 with DE = $00DC: starts message group 0, string $DC; on the normal ShowMessageHL path the string begins 'All those who stood before me' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg00DC_AllThoseWhoStood:: ; heuristic: target of a pointer table; C0
Func_004_79B0:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5D
    ld [wScriptParam1], a
    ld de, $00DC
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 06, then StartMessageScriptDE_B04 with DE = $00DD: starts message group 0, string $DD; on the normal ShowMessageHL path the string begins 'Let me show you why your' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg00DD_LetMeShowYou:: ; heuristic: target of a pointer table; C0
Func_004_79C1:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $06
    ld [wScriptParam1], a
    ld de, $00DD
    call StartMessageScriptDE_B04
    ret
    db $21, $33, $0C, $CD, $BB, $55, $C9, $21, $32, $0C, $CD, $BB, $55, $C9, $11, $DE
    db $00, $CD, $1B, $18, $38, $0D, $21, $30, $0C, $CD, $BB, $55, $11, $DE, $00, $CD
    db $45, $18, $C9, $21, $31, $0C, $CD, $BB, $55, $C9, $21, $9C, $65, $CD, $03, $56
    db $C9

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1 constant message(s) depending on story flags and state; the first one in the code is $0C47, an empty string on the normal path; the branching is not interpreted (E-0097)
; no direct call (reached through a table, a jump or a vector)
Talk0C47:: ; heuristic: target of a pointer table; C0
Func_004_7A03:: ; address name
    ld de, $01F6
    call TestFlagBit
    jr c, Jump_004_7A12
    ld hl, $659C
    call StartScriptAtHL_B04
    ret

Jump_004_7A12::
    ld hl, $0C47
    call StartMessageCommand09HL_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 2A, then StartMessageScriptDE_B04 with DE = $00F5: starts message group 0, string $F5; on the normal ShowMessageHL path the string begins 'It is an item with a' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg00F5_ItIsAnItem:: ; heuristic: target of a pointer table; C0
Func_004_7A19:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2A
    ld [wScriptParam1], a
    ld de, $00F5
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 5C, then StartMessageScriptDE_B04 with DE = $00F6: starts message group 0, string $F6; on the normal ShowMessageHL path the string begins 'Hello! What can I do for' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg00F6_HelloWhatCanI:: ; heuristic: target of a pointer table; C0
Func_004_7A2A:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5C
    ld [wScriptParam1], a
    ld de, $00F6
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 03, then StartMessageScriptDE_B04 with DE = $00F7: starts message group 0, string $F7; on the normal ShowMessageHL path the string begins 'Hello! What can I do for' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg00F7_HelloWhatCanI:: ; heuristic: target of a pointer table; C0
Func_004_7A3B:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $03
    ld [wScriptParam1], a
    ld de, $00F7
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 2C, then StartMessageScriptDE_B04 with DE = $00F9: starts message group 0, string $F9; on the normal ShowMessageHL path the string begins 'Hello! What can I do for' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg00F9_HelloWhatCanI:: ; heuristic: target of a pointer table; C0
Func_004_7A4C:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2C
    ld [wScriptParam1], a
    ld de, $00F9
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 45, then StartMessageScriptDE_B04 with DE = $00FA: starts message group 0, string $FA; on the normal ShowMessageHL path the string begins 'Hello! What can I do for' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg00FA_HelloWhatCanI:: ; heuristic: target of a pointer table; C0
Func_004_7A5D:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $45
    ld [wScriptParam1], a
    ld de, $00FA
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 47, then StartMessageScriptDE_B04 with DE = $00FB: starts message group 0, string $FB; on the normal ShowMessageHL path the string begins 'THE END' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg00FB_THEEND:: ; heuristic: target of a pointer table; C0
Func_004_7A6E:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $47
    ld [wScriptParam1], a
    ld de, $00FB
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 5A, then StartMessageScriptDE_B04 with DE = $00FD: starts message group 0, string $FD; on the normal ShowMessageHL path the string begins 'Hey, that's mine! 0 obtained a' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg00FD_HeyThatsMine0:: ; heuristic: target of a pointer table; C0
Func_004_7A7F:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5A
    ld [wScriptParam1], a
    ld de, $00FD
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 5B, then StartMessageScriptDE_B04 with DE = $00FE: starts message group 0, string $FE; on the normal ShowMessageHL path the string begins 'Terry Here, just take this. 0' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg00FE_TerryHereJustTake:: ; heuristic: target of a pointer table; C0
Func_004_7A90:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5B
    ld [wScriptParam1], a
    ld de, $00FE
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 01, then StartMessageScriptDE_B04 with DE = $00FF: starts message group 0, string $FF; on the normal ShowMessageHL path the string begins 'Composing' (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg00FF_Composing:: ; heuristic: target of a pointer table; C0
Func_004_7AA1:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $00FF
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 50, then StartMessageScriptDE_B04 with DE = $01F3: starts message group 1, string $F3; on the normal ShowMessageHL path the string is empty (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01F3:: ; heuristic: target of a pointer table; C0
Func_004_7AB2:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $50
    ld [wScriptParam1], a
    ld de, $01F3
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 4B, then StartMessageScriptDE_B04 with DE = $01F4: starts message group 1, string $F4; on the normal ShowMessageHL path the string is empty (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01F4:: ; heuristic: target of a pointer table; C0
Func_004_7AC3:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $4B
    ld [wScriptParam1], a
    ld de, $01F4
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 2A, then StartMessageScriptDE_B04 with DE = $01F5: starts message group 1, string $F5; on the normal ShowMessageHL path the string is empty (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01F5:: ; heuristic: target of a pointer table; C0
Func_004_7AD4:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2A
    ld [wScriptParam1], a
    ld de, $01F5
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 01, then StartMessageScriptDE_B04 with DE = $01F7: starts message group 1, string $F7; on the normal ShowMessageHL path the string is empty (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01F7:: ; heuristic: target of a pointer table; C0
Func_004_7AE5:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $01F7
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 5E, then StartMessageScriptDE_B04 with DE = $01F8: starts message group 1, string $F8; on the normal ShowMessageHL path the string is empty (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01F8:: ; heuristic: target of a pointer table; C0
Func_004_7AF6:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5E
    ld [wScriptParam1], a
    ld de, $01F8
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 49, then StartMessageScriptDE_B04 with DE = $01F9: starts message group 1, string $F9; on the normal ShowMessageHL path the string is empty (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01F9:: ; heuristic: target of a pointer table; C0
Func_004_7B07:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $49
    ld [wScriptParam1], a
    ld de, $01F9
    call StartMessageScriptDE_B04
    ret

; wScriptParam0 = 00, wScriptParam1 = 02, then StartMessageScriptDE_B04 with DE = $01FA: starts message group 1, string $FA; on the normal ShowMessageHL path the string is empty (E-0081)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptParam1
Msg01FA:: ; heuristic: target of a pointer table; C0
Func_004_7B18:: ; address name
    ld a, $00
    ld [wScriptParam0], a
    ld a, $02
    ld [wScriptParam1], a
    ld de, $01FA
    call StartMessageScriptDE_B04
    ret

; only called from DispatchTalkEvent_Case09 (E-0047)
; 1 call site from 1 routine (e.g. DispatchTalkEvent_Case09)
; reads: wTalkEventGroup
DispatchTalkEvent_Case09_Sub01::
Func_004_7B29:: ; address name
    ld a, [wTalkEventGroup]
    rst $00
    dw Func_004_7B29_Case00
    dw Func_004_7B29_Case01
    dw Func_004_7B29_Case02
    dw Func_004_7B29_Case03
    dw Func_004_7B29_Case04
    dw Func_004_7B29_Case05
    dw Func_004_7B29_Case06
    dw Func_004_7B29_Case07
    dw Func_004_7B29_Case08

; entry 0 of the `rst $00` table in Func_004_7B29
; no direct call (reached through a table, a jump or a vector)
Func_004_7B29_Case00::
Jump_004_7B3F:: ; address name
    ld hl, $5133
    call StartScriptAtHL_B04
    ret

; entry 1 of the `rst $00` table in Func_004_7B29
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldFloor
; writes: wDataBank, wScreenTableIndex
; points at: wKeyWorldFloorState
Func_004_7B29_Case01::
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
    ld hl, $65A3
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
    ld hl, $65A3
    call StartScriptAtHL_B04
    ret

; entry 2 of the `rst $00` table in Func_004_7B29
; no direct call (reached through a table, a jump or a vector)
; reads: wMapType, hPlayerFacing
; writes: wSpriteSlots, wDataBank
Func_004_7B29_Case02::
Jump_004_7B82:: ; address name
    ld a, [wMapType]
    cp a, $84
    jr nz, Jump_004_7B91
    ld hl, $65AA
    call StartScriptAtHL_B04
    jr Jump_004_7B9C

Jump_004_7B91::
    call IsPlayerAtWCD0BTriggerColumn
    or a, a
    ret z
    ld hl, $65B1
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
; 1 call site from 1 routine (e.g. Func_004_7B29_Case02)
; reads: wKeyWorldGoalKind, hMapScreenX, hPlayerX
IsPlayerAtWCD0BTriggerColumn::
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

; entry 3 of the `rst $00` table in Func_004_7B29
; no direct call (reached through a table, a jump or a vector)
Func_004_7B29_Case03::
Jump_004_7BF7:: ; address name
    ld hl, $5135
    call StartScriptAtHL_B04
    ret

; entry 4 of the `rst $00` table in Func_004_7B29
; no direct call (reached through a table, a jump or a vector)
Func_004_7B29_Case04::
Jump_004_7BFE:: ; address name
    ld hl, $0120
    call StartMessageCommand09HL_B04
    ret

; entry 5 of the `rst $00` table in Func_004_7B29
; no direct call (reached through a table, a jump or a vector)
Func_004_7B29_Case05::
Jump_004_7C05:: ; address name
    ld hl, $0122
    call StartMessageCommand09HL_B04
    ret

; entry 6 of the `rst $00` table in Func_004_7B29
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldGoalKind
Func_004_7B29_Case06::
Jump_004_7C0C:: ; address name
    ld a, [wKeyWorldGoalKind]
    cp a, $05
    ret z
    cp a, $07
    ret z
    cp a, $08
    ret z
    ld hl, $0121
    call StartMessageCommand09HL_B04
    ret

; entry 7 of the `rst $00` table in Func_004_7B29
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
Func_004_7B29_Case07::
Jump_004_7C1F:: ; address name
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_65AA
    call StartScriptAtHL_B04
    ret

; entry 8 of the `rst $00` table in Func_004_7B29
; no direct call (reached through a table, a jump or a vector)
; writes: wDataBank
Func_004_7B29_Case08::
Jump_004_7C2B:: ; address name
    ld a, $1F
    ld [wDataBank], a
    ld hl, Data_01F_65B8
    call StartScriptAtHL_B04
    ret

; A = 0 unless wC634 is $FF or 0; then scans wInventory for an empty slot ($FF or 0) and returns carry (E-0124)
; 6 call sites from 6 routines (e.g. Func_004_58C2_Case4B, Func_004_58C2_Case45, Talk075F_KiralFetchMeMy, Talk07BF_HeroFoundThePretty, ...)
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
