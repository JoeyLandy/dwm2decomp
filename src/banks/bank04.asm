SECTION "Bank 04", ROMX[$4000], BANK[$04]
    db $04

; runs AdvancePlayerAnimCounterAndRunPlayerSpriteMode and UpdateAndDrawSpriteSlots; shared by the
; field mode states (E-0122)
FieldStateCommonUpdate::
    call AdvancePlayerAnimCounterAndRunPlayerSpriteMode
    call UpdateAndDrawSpriteSlots
    ret

; when wSaveStateFlag bit 7 is set: clears wSaveStateFlag, wSpriteSlotCount = wSpriteSnapshotCount
; and the $50 bytes at wSpriteSnapshot go back to wSpriteSlots (undoes SnapshotSpritesForSave)
; (E-0117)
RestoreSpriteSnapshot::
    ld a, [wSaveStateFlag]
    bit 7, a
    ret z
    xor a
    ld [wSaveStateFlag], a
    ld a, [wSpriteSnapshotCount]
    ld [wSpriteSlotCount], a
    ld hl, wSpriteSnapshot
    ld de, wSpriteSlots
    ld bc, $0050
    call CopyBytes
    ret

; for key-world map types 2, 3, 4 and 6 places the area objects (stairs, chests, monsters) from the
; wKeyWorldFloorInfo + $1/wKeyWorldFloorState entries (E-0130)
SetupKeyWorldObjectsForMapType::
    xor a
    ld [wKeyWorldObjFlag], a
    ld a, [wMapType]
    and $07
    cp $03
    jr z, .read_key_world_floor
    cp $04
    jr z, .clear_temp9
    cp $06
    jp z, .read_key_world_floor3
    cp $02
    jp z, .clear_temp92
    ret

.read_key_world_floor:
    ld a, [wKeyWorldFloor]
    add a
    add a
    ld hl, wKeyWorldFloorInfo + $1
    add_a_to_hl
    xor a
    ldh [hTemp9], a
    ld a, [hl]
    cp $06
    jr z, .check_key_world_flags
    cp $02
    jr c, .skip
    cp $04
    jr nc, .skip
    push af
    cp $02
    jr nz, .read_key_world_floor2
    ld a, $01
    ld [wKeyWorldObjFlag], a

.read_key_world_floor2:
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState
    add_a_to_hl
    ld a, [hl]
    bit 7, a
    jr nz, .restore
    pop af
    jr .skip

.restore:
    pop af
    add $08
    jr .skip

.check_key_world_flags:
    ld a, [wKeyWorldFlags]
    bit 7, a
    jr z, .set_temp9_to_01
    xor a
    ld [wSpriteSlotCount], a
    ret

.set_temp9_to_01:
    ld a, $01
    ldh [hTemp9], a
    ld a, [hl]

.skip:
    dec a
    add a
    ld hl, KeyWorldObjectGridTable
    add_a_to_hl
    call SetupKeyWorldObjectsForMapType_Multiply8
    ld a, [wKeyWorldObjFlag]
    or a
    ret z
    call PlaceObjectCB86ForKeyWorldGoalKind
    ret

.clear_temp9:
    xor a
    ldh [hTemp9], a
    ld c, $06
    ld a, [wKeyWorldGoalKind]
    cp $07
    jr nz, .skip2
    ld c, $0e

.skip2:
    ld a, c
    ld hl, KeyWorldObjectGridTable
    add_a_to_hl
    call SetupKeyWorldObjectsForMapType_Multiply8
    ret

.read_key_world_floor3:
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState + $3
    add_a_to_hl
    ld a, [hl]
    cp $ff
    jr z, .loop
    and $01
    jr z, .check_key_world_flags2

.loop:
    xor a
    ld [wSpriteSlotCount], a
    ret

.check_key_world_flags2:
    ld a, [wKeyWorldFlags]
    bit 7, a
    jr nz, .loop
    ld a, $01
    ldh [hTemp9], a
    ld a, $08
    ld hl, KeyWorldObjectGridTable
    add_a_to_hl
    call SetupKeyWorldObjectsForMapType_Multiply8
    ret

.clear_temp92:
    xor a
    ldh [hTemp9], a
    ld a, [wKeyWorldFloor]
    add a
    add a
    ld hl, wKeyWorldEncounterTable + $3
    add_a_to_hl
    ld a, [hl]
    or a
    jr nz, .clear_sprite_slot_count
    ld a, [wKeyWorldByte06]
    or a
    jr z, .set_temp9_to_02

.clear_sprite_slot_count:
    xor a
    ld [wSpriteSlotCount], a
    ret

.set_temp9_to_02:
    ld a, $02
    ldh [hTemp9], a
    ld a, $0c
    ld hl, KeyWorldObjectGridTable
    add_a_to_hl
    call SetupKeyWorldObjectsForMapType_Multiply8
    ret

SetupKeyWorldObjectsForMapType_Multiply8::
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, [wMapWidthScreens]
    add a
    ld c, a
    ldh a, [hMapScreenY]
    call Multiply8
    ldh a, [hMapScreenX]
    add a
    add_a_to_hl
    add hl, de
    ld a, [hli]
    ld e, a
    ld a, [hl]
    or e
    ret z
    ld a, [hl]
    ld d, a
    ld l, e
    ld h, d
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    cp $ff
    jr nz, .skip
    ld a, e
    cp $ff
    jr nz, .cp_FE
    xor a
    ld [wSpriteSlotCount], a
    ret

.cp_FE:
    cp $fe
    jr z, .skip

.skip:
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    ld l, e
    ld h, d
    ld a, [hli]
    ld [wSpriteSlotCount], a
    ld b, a
    ld de, wSpriteSlots

.loop:
    push bc
    ld a, b
    ldh [hTempA], a
    xor a
    ldh [hTemp4], a
    ld a, [hli]
    ldh [hTemp5], a
    ld a, [hli]
    ldh [hTemp2], a
    inc de
    ld [de], a
    inc de
    ldh a, [hTemp9]
    or a
    jr nz, .skip2
    ld a, [hli]
    ldh [hTemp0], a
    ld [de], a
    inc de
    ld a, [hli]
    ldh [hTemp1], a
    ld [de], a
    inc de
    jr .check_temp2

.skip2:
    dec a
    jr nz, .next
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
    jr .check_temp2

.next:
    inc hl
    inc hl
    push hl
    ld a, [wKeyWorldFloor]
    and $0f
    add a
    add a
    ld hl, wKeyWorldEncounterTable
    add_a_to_hl
    ld a, [hli]
    ldh [hTemp0], a
    ld [de], a
    inc de
    ld a, [hl]
    ldh [hTemp1], a
    ld [de], a
    inc de
    pop hl

.check_temp2:
    ldh a, [hTemp2]
    or a
    jr z, .skip3
    ldh a, [hTemp0]
    cp $09
    jr nc, .skip3
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

.skip3:
    push de
    ld a, e
    sub $04
    ld e, a
    ld a, d
    sbc $00
    ld d, a
    ld a, [hli]
    ld [de], a
    pop de
    ld a, [hl]
    ld [de], a
    push de
    ld a, $07
    add e
    ld e, a
    jr nc, .skip4
    inc d

.skip4:
    ld a, [hli]
    ld [de], a
    pop de
    inc de
    ld a, [hl]
    ld [de], a
    push de
    ld a, $07
    add e
    ld e, a
    jr nc, .skip5
    inc d

.skip5:
    ld a, [hli]
    ld [de], a
    pop de
    inc de
    ld a, [hli]
    ldh [hTemp3], a
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ldh a, [hTempA]
    and $03
    ld [de], a
    xor a
    inc de
    ld [de], a
    inc de
    inc de
    inc de
    ld [de], a
    inc de
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    push hl
    push de
    call DecompressGraphicsTemp0ToTemp4
    pop de
    pop hl
    pop bc
    dec b
    jp nz, .loop
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ret

; SetupKeyWorldObjectsForMapType_Sub01, for an object whose graphics number (hTemp0) is below 9 and
; whose hTemp2 is non-zero, replaces it with the byte at $423D + 16 * hTemp0 + wKeyWorldGoalKind; 9
; rows end at the code at $42CD (E-0221, C1)
; record: replacement graphics number for each goal kind 0-9, then six zero bytes
KeyWorldGoalGraphicsTable::
    db $0e, $0e, $0e, $0e, $0e, $0e, $0e, $44, $0e, $0e, $00, $00, $00, $00, $00, $00 ; id 0
    db $10, $52, $52, $4d, $10, $10, $10, $44, $10, $10, $00, $00, $00, $00, $00, $00 ; id 1
    db $08, $08, $2e, $24, $08, $08, $37, $44, $3c, $33, $00, $00, $00, $00, $00, $00 ; id 2
    db $09, $09, $2f, $25, $09, $09, $38, $44, $1b, $34, $00, $00, $00, $00, $00, $00 ; id 3
    db $0c, $0c, $30, $26, $0c, $0c, $39, $44, $1e, $35, $00, $00, $00, $00, $00, $00 ; id 4
    db $06, $06, $2d, $23, $06, $06, $36, $44, $18, $31, $00, $00, $00, $00, $00, $00 ; id 5
    db $12, $12, $12, $12, $12, $12, $12, $44, $12, $12, $00, $00, $00, $00, $00, $00 ; id 6
    db $15, $15, $15, $15, $15, $15, $15, $44, $15, $15, $00, $00, $00, $00, $00, $00 ; id 7
    db $00, $16, $00, $00, $00, $00, $00, $44, $16, $33, $00, $00, $00, $00, $00, $00 ; id 8

; on map screen (0, 0) or (1, 0) sets wSpriteSlots + $B/wSpriteSlots + $C and wSpriteSlots + $7 for
; wKeyWorldGoalKind values 1, 7, 8 or 9 (E-0125)
PlaceObjectCB86ForKeyWorldGoalKind::
    ldh a, [hMapScreenY]
    or a
    ret nz
    ldh a, [hMapScreenX]
    or a
    jr nz, .check_key_world_goal_kind
    ld a, $20
    ld [wSpriteSlots + $c], a
    ld a, [wKeyWorldGoalKind]
    cp $01
    jr nz, .cp_07
    ld a, $20
    ld [wSpriteSlots + $b], a
    ld a, $01
    ld [wSpriteSlots + $7], a
    ret

.cp_07:
    cp $07
    jr nz, .cp_08
    ld a, $20
    ld [wSpriteSlots + $b], a
    ld a, $01
    ld [wSpriteSlots + $7], a
    ret

.cp_08:
    cp $08
    ret nz
    ld a, $30
    ld [wSpriteSlots + $b], a
    xor a
    ld [wSpriteSlots + $7], a
    ret

.check_key_world_goal_kind:
    ld a, [wKeyWorldGoalKind]
    cp $09
    ret nz
    ld a, $70
    ld [wSpriteSlots + $b], a
    ld a, $10
    ld [wSpriteSlots + $c], a
    ld a, $03
    ld [wSpriteSlots + $7], a
    ret

; hTemp0/hTemp1 = graphics number, hTemp4/hTemp5 = VRAM destination: with hTemp2 = 0 the source and
; bank come from a 3-byte-per-entry table at $4EAA; otherwise from the word table at $43AC with bank
; $7D ($7E for numbers $50 and up); then DecompressToVRAM; on CGB it goes on to the palette (not
; read) (E-0093)
DecompressGraphicsTemp0ToTemp4::
    ldh a, [hTemp2]
    or a
    jr nz, .read_temp0
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
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [hl]
    ld b, a
    jr .read_temp4

.read_temp0:
    ld de, FieldSpriteGraphicsTable
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    add hl, hl
    add hl, de
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld b, $7d
    ldh a, [hTemp0]
    cp $50
    jr c, .read_temp4
    inc b

.read_temp4:
    ldh a, [hTemp4]
    ld l, a
    ldh a, [hTemp5]
    ld h, a
    call DecompressToVRAM
    ld a, [wIsCGB]
    or a
    ret z
    ldh a, [hTemp2]
    or a
    jr nz, .read_temp02
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, l
    add $28
    ld l, a
    ld a, h
    adc $73
    ld h, a
    ld e, l
    ld d, h
    ld b, $27
    jr .read_temp32

.read_temp02:
    ldh a, [hTemp0]
    ld de, FieldSpritePaletteIndex
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    add a
    add a
    add a
    ld de, $4b15
    add e
    ld e, a
    jr nc, .read_temp3
    inc d

.read_temp3:
    ld b, $7e

.read_temp32:
    ldh a, [hTemp3]
    sla a
    sla a
    sla a
    ld hl, wOBJPaletteBuffer
    add_a_to_hl
    ld c, $08
    call CopyFromBank
    ret

; DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero reads the word $43AC + 2 * hTemp0/7 in bank
; $04 and decompresses it from bank $7D, or $7E for numbers $50 and up; all 98 entries decode
; (E-0143, C1)
; record: compressed sprite graphics in bank $7D
FieldSpriteGraphicsTable::
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

; E-0143 (C1: DecompressGraphicsTemp0ToTemp4 with hTemp2 non-zero reads the word $43AC + 2 *
; hTemp0/7 in bank $04 and decompresses it from bank $7D, or $7E for numbers $50 and up; all 98
; entries decode); numbers $50-$61.
; record: compressed sprite graphics in bank $7E
FieldSpriteGraphicsTable50::
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

; sets bit 1 of hPlayerStateFlags and of the flag byte (wSpriteSlots + $D + 16 * n) of object
; entries 0-4 (the counterpart of ClearBit1OfPlayerAndObjectFlags; RunMessageBox calls them around a
; message) (E-0120)
SetBit1OfPlayerAndObjectFlags::
    ldh a, [hPlayerStateFlags]
    or $02
    ldh [hPlayerStateFlags], a
    ld a, [wSpriteSlots + $d]
    or $02
    ld [wSpriteSlots + $d], a
    ld a, [wObject1 + OBJ_FLAGS]
    or $02
    ld [wObject1 + OBJ_FLAGS], a
    ld a, [wObject2 + OBJ_FLAGS]
    or $02
    ld [wObject2 + OBJ_FLAGS], a
    ld a, [wObject3 + OBJ_FLAGS]
    or $02
    ld [wObject3 + OBJ_FLAGS], a
    ld a, [wObject4 + OBJ_FLAGS]
    or $02
    ld [wObject4 + OBJ_FLAGS], a
    ret

; clears bit 1 of hPlayerStateFlags and of the flag byte (wSpriteSlots + $D + 16 * n) of object
; entries 0-4 (E-0072)
ClearBit1OfPlayerAndObjectFlags::
    ldh a, [hPlayerStateFlags]
    and $fd
    ldh [hPlayerStateFlags], a
    ld a, [wSpriteSlots + $d]
    and $fd
    ld [wSpriteSlots + $d], a
    ld a, [wObject1 + OBJ_FLAGS]
    and $fd
    ld [wObject1 + OBJ_FLAGS], a
    ld a, [wObject2 + OBJ_FLAGS]
    and $fd
    ld [wObject2 + OBJ_FLAGS], a
    ld a, [wObject3 + OBJ_FLAGS]
    and $fd
    ld [wObject3 + OBJ_FLAGS], a
    ld a, [wObject4 + OBJ_FLAGS]
    and $fd
    ld [wObject4 + OBJ_FLAGS], a
    ret

; unless bit 7 of wFieldActionRequest is set: updates the sprite slots, then draws each slot's
; metasprite at its position relative to the scroll (E-0129)
UpdateAndDrawSpriteSlots::
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ld a, [wSpriteSlotCount]
    or a
    ret z
    call UpdateSpriteSlots
    ld a, [wSpriteSlotCount]
    ld b, a
    ld hl, wSpriteSlots

.loop:
    push hl
    inc hl
    ld a, [hli]
    ldh [hTemp0], a
    push hl
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hli]
    and $07
    ldh [hSpriteAttrXor], a
    inc hl
    ld a, [hli]
    ldh [hSpriteTileOffset], a
    inc hl
    inc hl
    ld a, [hli]
    add $08
    ld d, a
    ldh a, [hScrollX]
    add d
    ldh [hSpriteOriginX], a
    ldh a, [hScrollXHi]
    adc $00
    ldh [hSpriteOriginXHi], a
    ld a, [hli]
    add $10
    ld d, a
    ldh a, [hScrollY]
    add d
    ldh [hSpriteOriginY], a
    ldh a, [hScrollYHi]
    adc $00
    ldh [hSpriteOriginYHi], a
    inc hl
    ld a, [hl]
    bit 7, a
    jr z, .set_sprite_sub_index
    push af
    ldh a, [hSpriteAttrXor]
    or $20
    ldh [hSpriteAttrXor], a
    pop af
    and $7f

.set_sprite_sub_index:
    ldh [hSpriteSubIndex], a
    pop hl
    push bc
    ldh a, [hTemp0]
    or a
    jr nz, .set_sprite_set_index
    ld a, [hli]
    and $7f
    ldh [hSpriteSetIndex], a
    ld a, [hld]
    or a
    jr nz, .call_draw_meta_sprite_set_bank27
    ld a, [hl]
    bit 7, a
    jr nz, .call_draw_meta_sprite_set_bank26
    farcall DrawMetaSpriteSet_Bank25
    jr .restore

.call_draw_meta_sprite_set_bank26:
    farcall DrawMetaSpriteSet_Bank26
    jr .restore

.call_draw_meta_sprite_set_bank27:
    farcall DrawMetaSpriteSet_Bank27
    jr .restore

.set_sprite_set_index:
    ld a, [hli]
    inc hl
    ldh [hSpriteSetIndex], a
    farcall DrawMetaSprite4008

.restore:
    pop bc
    pop hl
    ld a, $10
    add_a_to_hl
    dec b
    jp nz, .loop
    ret

; for each of wSpriteSlotCount 16-byte slots at wSpriteSlots runs the routine for its type byte
; (jump table of six) (E-0124)
UpdateSpriteSlots::
    ld a, [wSpriteSlotCount]
    ld b, a
    ld hl, wSpriteSlots

UpdateSpriteSlots_Loop::
    push bc
    push hl
    push hl
    ld a, [hl]
    jumptable
    dw UpdateSpriteSlots_RestoreRegisters
    dw UpdateSpriteSlots_Return
    dw UpdateSpriteSlots_ReadScriptRunningAndRandomLo
    dw UpdateSpriteSlots_ReadScriptRunningAndRandomLo_Case03
    dw UpdateSpriteSlots_WriteTemp0AndTemp1
    dw UpdateSpriteSlots_WriteTemp0AndTemp1_Case05

UpdateSpriteSlots_Restore::
    pop hl
    pop bc
    ld a, $10
    add_a_to_hl
    dec b
    jr nz, UpdateSpriteSlots_Loop
    ret

UpdateSpriteSlots_RestoreRegisters::
    pop hl
    ld a, $0d
    add_a_to_hl
    ld a, [hl]
    dec hl
    dec hl
    dec hl
    dec hl
    bit 1, a
    jr nz, .skip
    ld a, [hl]
    inc a
    ld [hl], a

.skip:
    ld a, [hl]

UpdateSpriteSlots_RestoreRegisters_Skip::
    ld c, a
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 2, a
    jr z, .skip
    ld a, c
    srl a
    srl a
    srl a
    and $01
    ld c, a
    jr .skip2

.skip:
    ld a, c
    swap a
    srl a
    and $01
    ld c, a

.skip2:
    ld a, l
    sub $06
    ld l, a
    ld a, h
    sbc $00
    ld h, a
    ld a, [hl]
    cp $03
    jr nz, .skip3
    ld a, $82
    add c
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
    jr nz, UpdateSpriteSlots_Loop
    ret

.skip3:
    add a
    add c
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
    jp nz, UpdateSpriteSlots_Loop
    ret

UpdateSpriteSlots_ReadScriptRunningAndRandomLo::
    pop hl
    push hl
    ld a, $0d
    add_a_to_hl
    ld a, [hl]
    dec hl
    dec hl
    dec hl
    dec hl
    bit 1, a
    jr z, .skip
    inc hl
    jr .skip2

.skip:
    ld a, [hl]
    inc a
    ld [hli], a
    ld a, [hl]

.skip2:
    ld a, [hl]
    bit 7, a
    jr z, .check_script_running
    inc hl
    bit 6, a
    jr nz, .skip3
    ld a, [hl]
    dec a
    ld [hl], a
    ld a, l
    sub $04
    ld l, a
    ld a, h
    sbc $00
    ld h, a
    ld [hl], $03
    jr .next

.skip3:
    ld a, [hl]
    inc a
    ld [hl], a
    ld a, l
    sub $04
    ld l, a
    ld a, h
    sbc $00
    ld h, a
    ld [hl], $01

.next:
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    and $0f
    jp nz, .restore2
    xor a
    ld [hl], a
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and $fb
    ld [hl], a
    jp .restore2

.check_script_running:
    ld a, [wScriptRunning]
    or a
    jp nz, .restore2
    dec hl
    ld a, [hl]
    cp $70
    jp nz, .restore2
    xor a
    ld [hli], a
    call NextTableByte
    ld a, [wRandomLo]
    and $03
    cp $03
    jr z, .skip4
    and $01
    jr z, .restore2
    push hl
    inc hl
    ld a, [hl]
    or a
    jr z, .restore
    ld a, l
    sub $07
    ld l, a
    ld a, h
    sbc $00
    ld h, a
    ld a, [hl]
    ld c, a
    ld a, $07
    add_a_to_hl
    ld a, [hl]
    sub c
    cp $e0
    jr z, .restore
    ld a, [hli]
    sub $10
    ld b, a
    ld a, [hl]
    ld c, a
    call IsTileUnderCellBlocking
    cp $01
    jr z, .restore
    call UpdateSpriteSlots_WriteTemp0AndTemp1_Shared01
    or a
    jr nz, .restore
    pop hl
    ld [hl], $80
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    or $04
    ld [hl], a
    jr .restore2

.skip4:
    push hl
    inc hl
    ld a, [hl]
    cp $90
    jr z, .restore
    ld a, l
    sub $07
    ld l, a
    ld a, h
    sbc $00
    ld h, a
    ld a, [hl]
    ld c, a
    ld a, $07
    add_a_to_hl
    ld a, [hl]
    sub c
    cp $20
    jr z, .restore
    ld a, [hli]
    add $11
    ld b, a
    ld a, [hl]
    ld c, a
    call IsTileUnderCellBlocking
    cp $01
    jr z, .restore
    call UpdateSpriteSlots_WriteTemp0AndTemp1_Shared01
    or a
    jr nz, .restore
    pop hl
    ld [hl], $c0
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    or $04
    ld [hl], a
    jr .restore2

.restore:
    pop hl

.restore2:
    pop hl
    ld a, $09
    add_a_to_hl
    ld a, [hl]
    jp UpdateSpriteSlots_RestoreRegisters_Skip

UpdateSpriteSlots_Return::
    ret

UpdateSpriteSlots_ReadScriptRunningAndRandomLo_Case03::
    pop hl
    push hl
    ld a, $0d
    add_a_to_hl
    ld a, [hl]
    dec hl
    dec hl
    dec hl
    dec hl
    bit 1, a
    jr z, .skip
    inc hl
    jr .skip2

.skip:
    ld a, [hl]
    inc a
    ld [hli], a
    ld a, [hl]

.skip2:
    ld a, [hl]
    bit 7, a
    jr z, .check_script_running
    push hl
    inc hl
    swap a
    srl a
    and $03
    jr z, .next2
    dec a
    jr z, .skip3
    dec a
    jr z, .next
    ld a, [hl]
    dec a
    ld [hl], a
    ld a, l
    sub $04
    ld l, a
    ld a, h
    sbc $00
    ld h, a
    ld [hl], $03
    jr .restore

.skip3:
    ld a, [hl]
    inc a
    ld [hl], a
    ld a, l
    sub $04
    ld l, a
    ld a, h
    sbc $00
    ld h, a
    ld [hl], $01
    jr .restore

.next:
    inc hl
    ld a, [hl]
    dec a
    ld [hl], a
    ld a, l
    sub $05
    ld l, a
    ld a, h
    sbc $00
    ld h, a
    ld [hl], $02
    jr .restore

.next2:
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    ld a, l
    sub $05
    ld l, a
    ld a, h
    sbc $00
    ld h, a
    ld [hl], $00

.restore:
    pop hl
    ld a, [hl]
    inc a
    ld [hl], a
    and $0f
    jp nz, .restore3
    xor a
    ld [hl], a
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and $fb
    ld [hl], a
    jp .restore3

.check_script_running:
    ld a, [wScriptRunning]
    or a
    jp nz, .restore3
    dec hl
    ld a, [hl]
    cp $e0
    jp nz, .restore3
    xor a
    ld [hli], a
    call NextTableByte
    ld a, [wRandomLo]
    and $03
    jr z, .skip6
    dec a
    jr z, .skip4
    dec a
    jr z, .skip5
    push hl
    inc hl
    ld a, [hl]
    or a
    jp z, .restore2
    ld a, [hli]
    sub $10
    ld b, a
    ld a, [hl]
    ld c, a
    call RunPendingFieldEventType0AOrOther
    cp $01
    jp z, .restore2
    call UpdateSpriteSlots_WriteTemp0AndTemp1_Shared01
    or a
    jp nz, .restore2
    pop hl
    ld [hl], $e0
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    or $04
    ld [hl], a
    jr .restore3

.skip4:
    push hl
    inc hl
    ld a, [hl]
    cp $90
    jr z, .restore2
    ld a, [hli]
    add $11
    ld b, a
    ld a, [hl]
    ld c, a
    call RunPendingFieldEventType0AOrOther
    cp $01
    jr z, .restore2
    call UpdateSpriteSlots_WriteTemp0AndTemp1_Shared01
    or a
    jr nz, .restore2
    pop hl
    ld [hl], $a0
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    or $04
    ld [hl], a
    jr .restore3

.skip5:
    push hl
    inc hl
    inc hl
    ld a, [hl]
    or a
    jr z, .restore2
    dec hl
    ld a, [hli]
    ld b, a
    ld a, [hl]
    sub $10
    ld c, a
    call RunPendingFieldEventType0AOrOther
    cp $01
    jr z, .restore2
    call UpdateSpriteSlots_WriteTemp0AndTemp1_Shared01
    or a
    jr nz, .restore2
    pop hl
    ld [hl], $c0
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    or $04
    ld [hl], a
    jr .restore3

.skip6:
    push hl
    inc hl
    inc hl
    ld a, [hl]
    cp $80
    jr z, .restore2
    dec hl
    ld a, [hli]
    ld b, a
    ld a, [hl]
    add $11
    ld c, a
    call RunPendingFieldEventType0AOrOther
    cp $01
    jr z, .restore2
    call UpdateSpriteSlots_WriteTemp0AndTemp1_Shared01
    or a
    jr nz, .restore2
    pop hl
    ld [hl], $80
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    or $04
    ld [hl], a
    jr .restore3

.restore2:
    pop hl

.restore3:
    pop hl
    ld a, $09
    add_a_to_hl
    ld a, [hl]
    jp UpdateSpriteSlots_RestoreRegisters_Skip

; runs RunPendingFieldEventType0AOrOther_ReadMapTallTileMin when wPendingFieldEvent & $0F = $0A,
; else IsTileUnderCellBlocking (E-0122)
RunPendingFieldEventType0AOrOther::
    ld a, [wPendingFieldEvent]
    and $0f
    cp $0a
    jr z, .call_run_pending_field_event_type0_a_or_other
    call IsTileUnderCellBlocking
    ret

.call_run_pending_field_event_type0_a_or_other:
    call RunPendingFieldEventType0AOrOther_ReadMapTallTileMin
    ret

UpdateSpriteSlots_WriteTemp0AndTemp1::
    ld hl, $48d6
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    jr UpdateSpriteSlots_WriteTemp0AndTemp1_Case05_Restore

UpdateSpriteSlots_WriteTemp0AndTemp1_Case05::
    ld hl, $48fa
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a

UpdateSpriteSlots_WriteTemp0AndTemp1_Case05_Restore::
    pop hl
    ld a, $0d
    add_a_to_hl
    ld a, [hl]
    dec hl
    dec hl
    dec hl
    dec hl
    push hl
    bit 1, a
    jr nz, .read_temp0
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
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    cp c
    jr nz, .read_temp0
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
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    cp $ff
    jr nz, .read_temp0
    ld [hl], $00

.read_temp0:
    pop hl
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    inc hl
    ld a, [hl]
    sla a
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, [de]
    inc hl
    inc hl
    inc hl
    inc hl
    ld [hl], a
    jp UpdateSpriteSlots_Restore
    db $00, $0e, $03, $0a, $04, $0e, $05, $0a, $00, $0e, $03, $0a, $04, $0e, $05, $0a
    db $00, $10, $01, $0e, $02, $0e, $01, $0e, $02, $0e, $00, $20, $06, $0e, $07, $20
    db $06, $0e, $ff, $ff, $00, $0e, $01, $0e, $02, $0e, $01, $0e, $ff, $ff

; reads the 2 x 2 screen-buffer tiles at pixel (B, C) into wTilesUnderPoint-wTilesUnderPoint + $3; A
; = 1 when any is at or below wMaxBlockingTile, else 0 (E-0127)
IsTileUnderCellBlocking::
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
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ld a, $13
    inc de
    add_a_to_hl
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    dec de
    dec de
    dec de
    ld b, $04

.loop:
    ld a, [de]
    inc de
    ld c, a
    ld a, [wMaxBlockingTile]
    cp c
    jr c, .next
    jr .skip

.next:
    dec b
    jr nz, .loop
    xor a
    pop de
    pop bc
    ret

.skip:
    ld a, $01
    pop de
    pop bc
    ret

RunPendingFieldEventType0AOrOther_ReadMapTallTileMin::
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
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ld a, $13
    inc de
    add_a_to_hl
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    dec de
    dec de
    dec de
    ld b, $04

.loop:
    ld a, [de]
    inc de
    ld c, a
    ld a, [wMapTallTileMin]
    cp c
    jr c, .next
    jr .skip

.next:
    dec b
    jr nz, .loop
    ld a, $01
    pop de
    pop bc
    ret

.skip:
    xor a
    pop de
    pop bc
    ret

UpdateSpriteSlots_WriteTemp0AndTemp1_Shared01::
    push bc
    ld a, c
    swap a
    and $0f
    ldh [hTemp0], a
    ld a, b
    swap a
    and $0f
    ldh [hTemp1], a
    ldh a, [hPlayerX]
    swap a
    and $0f
    ld c, a
    ldh a, [hTemp1]
    cp c
    jr z, .read_player_y
    ldh a, [hPlayerX]
    add $0f
    swap a
    and $0f
    ld c, a
    ldh a, [hTemp1]
    cp c
    jr nz, .check_party_count

.read_player_y:
    ldh a, [hPlayerY]
    swap a
    and $0f
    ld c, a
    ldh a, [hTemp0]
    cp c
    jr z, .done
    ldh a, [hPlayerY]
    add $0f
    swap a
    and $0f
    ld c, a
    ldh a, [hTemp0]
    cp c
    jr nz, .check_party_count

.done:
    ld a, $01
    pop bc
    ret

.check_party_count:
    ld a, [wPartyCount]
    or a
    jr z, .done2
    ld b, a
    ld hl, wFollowerRecords + $1

.loop:
    push hl
    ld a, [hl]
    swap a
    and $0f
    ld c, a
    ldh a, [hTemp1]
    cp c
    jr z, .next
    ld a, [hl]
    add $0f
    swap a
    and $0f
    ld c, a
    ldh a, [hTemp1]
    cp c
    jr nz, .restore2

.next:
    inc hl
    ld a, [hl]
    swap a
    and $0f
    ld c, a
    ldh a, [hTemp0]
    cp c
    jr z, .restore
    ld a, [hl]
    add $0f
    swap a
    and $0f
    ld c, a
    ldh a, [hTemp0]
    cp c
    jr nz, .restore2

.restore:
    pop hl
    ld a, $01
    pop bc
    ret

.restore2:
    pop hl
    ld a, $05
    add_a_to_hl
    dec b
    jr nz, .loop

.done2:
    xor a
    pop bc
    ret

; on CGB, with hTemp2 non-zero, DecompressGraphicsTemp0ToTemp4 reads the byte $4A46 + hTemp0 in bank
; $04 and copies the 8 bytes at 7E:$4B15 + 8 * it to the OBJ palette hTemp3; values 0-20 (E-0143,
; C1)
; record: palette number in FieldSpritePalettes
FieldSpritePaletteIndex::
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
    db $0a ; id 71
    db $0b ; id 72
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
    db $0c ; id 84
    db $0d ; id 85
    db $0e ; id 86
    db $02 ; id 87
    db $09 ; id 88
    db $04 ; id 89
    db $0f ; id 90
    db $10 ; id 91
    db $02 ; id 92
    db $00 ; id 93
    db $02 ; id 94
    db $03 ; id 95
    db $00 ; id 96
    db $14 ; id 97

; hPlayerSpriteMode = sprite mode from story flags $19F, $25 and 2 and bit 3 of hPlayerStateFlags,
; then loads the matching player and follower sprite graphics (E-0128)
LoadPlayerAndFollowerSpriteGraphics::
    ld a, $00
    ldh [hPlayerSpriteMode], a
    ld de, $019f
    call TestFlagBit
    jr nc, .call_test_flag_bit
    ld de, $0025
    call TestFlagBit
    jr nc, .set_player_sprite_mode_to_01

.call_test_flag_bit:
    ld de, $0002
    call TestFlagBit
    jr c, .check_player_state_flags

.set_player_sprite_mode_to_01:
    ld a, $01
    ldh [hPlayerSpriteMode], a

.check_player_state_flags:
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr z, .check_player_sprite_mode
    ld a, $02
    ldh [hPlayerSpriteMode], a

.check_player_sprite_mode:
    ldh a, [hPlayerSpriteMode]
    or a
    jr nz, .skip
    call LoadPlayerSpriteGraphics
    call LoadPlayerAndFollowerSpriteGraphics_LoadSRAMRecordByte
    ret

.skip:
    dec a
    jr nz, .call_load_player_sprite_graphics
    call LoadPlayerSpriteGraphics
    ld de, $0000
    call TestFlagBit
    jr c, .clear_temp0
    ld a, $01
    jr .set_temp0

.clear_temp0:
    xor a

.set_temp0:
    ldh [hTemp0], a
    xor a
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
    xor a
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

.call_load_player_sprite_graphics:
    call LoadPlayerSpriteGraphics
    call LoadPlayerAndFollowerSpriteGraphics_LoadSRAMRecordByte
    call LoadAltObjectGraphicsIfPlayerStateFlagsBit3
    ret

; decompresses the player sprite graphics to vTiles0: variant 0 or 1 by story flag 0, or the stream
; named by hPlayerSpriteStreamLo/hPlayerSpriteStreamHi when bit 7 of hPlayerSpriteOverride is set
; (E-0127)
LoadPlayerSpriteGraphics::
    ldh a, [hPlayerSpriteOverride]
    bit 7, a
    jr nz, .set_temp2
    ld de, $0000
    call TestFlagBit
    jr c, .set_temp0_to_01
    xor a
    ldh [hTemp0], a
    ldh [hPlayerSpriteVariant], a
    jr .clear_temp1

.set_temp0_to_01:
    ld a, $01
    ldh [hTemp0], a
    ldh [hPlayerSpriteVariant], a

.clear_temp1:
    xor a
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

.set_temp2:
    and $01
    ldh [hTemp2], a
    ldh a, [hPlayerSpriteStreamLo]
    ld l, a
    ldh a, [hPlayerSpriteStreamHi]
    ld h, a
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    xor a
    ldh [hTemp3], a
    ld hl, vTiles0
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    call DecompressGraphicsTemp0ToTemp4
    ret

; when hPlayerStateFlags bit 3 is set: decompresses Tiles0Plus700Gfx_7E_58FF (bank $7E) to vTiles0 +
; $700 and copies an 8-byte palette from bank $7E into OBJ palette 7 of wOBJPaletteBuffer
; (wOBJPaletteUploadRequest = $7F) (E-0120)
LoadAltObjectGraphicsIfPlayerStateFlagsBit3::
    ldh a, [hPlayerStateFlags]
    bit 3, a
    ret z
    ld de, Tiles0Plus700Gfx_7E_58FF
    ld b, $7e
    ld hl, vTiles0 + $700
    call DecompressToVRAM
    ld de, $4bbd
    ld a, e
    add $08
    ld e, a
    ld a, d
    adc $01
    ld d, a
    ld b, $7e
    ld a, $38
    ld hl, wOBJPaletteBuffer
    add_a_to_hl
    ld c, $08
    call CopyFromBank
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ret

; unless bit 1 of hPlayerStateFlags is set, hPlayerAnimCounter += 1 (+3 more with bit 2); then runs
; the routine for hPlayerSpriteMode (jump table of three) (E-0124)
AdvancePlayerAnimCounterAndRunPlayerSpriteMode::
    ldh a, [hPlayerStateFlags]
    bit 1, a
    jr nz, .read_player_sprite_mode
    ld hl, hPlayerAnimCounter
    inc [hl]
    ldh a, [hPlayerStateFlags]
    bit 2, a
    jr z, .read_player_sprite_mode
    ldh a, [hPlayerAnimCounter]
    add $03
    ldh [hPlayerAnimCounter], a

.read_player_sprite_mode:
    ldh a, [hPlayerSpriteMode]
    jumptable
    dw AdvancePlayerAnimCounterAndRunPlayerSpriteMode_DrawPartyFollowerSprites
    dw AdvancePlayerAnimCounterAndRunPlayerSpriteMode_DrawFollowerSpriteIfFlag1B
    dw AdvancePlayerAnimCounterAndRunPlayerSpriteMode_DrawPlayerOverlaySprite21Or22

AdvancePlayerAnimCounterAndRunPlayerSpriteMode_DrawPartyFollowerSprites::
    call AdvancePlayerAnimCounterAndRunPlayerSpriteMode_IsFadingAtMap5AScreen00Y80
    call DrawPartyFollowerSprites
    ret

AdvancePlayerAnimCounterAndRunPlayerSpriteMode_DrawFollowerSpriteIfFlag1B::
    call AdvancePlayerAnimCounterAndRunPlayerSpriteMode_IsFadingAtMap5AScreen00Y80
    call DrawFollowerSpriteIfFlag1B
    ret

AdvancePlayerAnimCounterAndRunPlayerSpriteMode_DrawPlayerOverlaySprite21Or22::
    call AdvancePlayerAnimCounterAndRunPlayerSpriteMode_IsFadingAtMap5AScreen00Y80
    call DrawPlayerOverlaySprite21Or22
    ret

; moves the sprite origin down 8, sets tile offset $70 and palette 7, then draws meta-sprite set $21
; (hPlayerStateFlags bit 3 set) or $22 with DrawMetaSprite (E-0175)
DrawPlayerOverlaySprite21Or22::
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
    and $f8
    or $07
    ldh [hSpriteAttrXor], a
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr z, .set_sprite_set_index_to_22
    ld a, $21
    ldh [hSpriteSetIndex], a
    xor a
    ldh [hSpriteSubIndex], a
    farcall DrawMetaSprite
    ret

.set_sprite_set_index_to_22:
    ld a, $22
    ldh [hSpriteSetIndex], a
    xor a
    ldh [hSpriteSubIndex], a
    farcall DrawMetaSprite
    ret

; unless hFieldDrawFlags bit 1 is set, and only when story flag $1B is set: draws the follower
; sprite from wFollowerRecords bytes 1-2 (set from hPlayerSpriteVariant, with a different frame when
; IsFadingAtMap5AScreen00Y80) (E-0175)
DrawFollowerSpriteIfFlag1B::
    ldh a, [hFieldDrawFlags]
    bit 1, a
    ret nz
    ld de, $001b
    call TestFlagBit
    ret nc
    ldh a, [hPlayerSpriteVariant]
    inc a
    and $01
    ldh [hSpriteSetIndex], a
    ld a, $01
    ldh [hSpriteAttrXor], a
    ld a, [wFollowerRecords + $1]
    ld b, a
    ld a, [wFollowerRecords + $2]
    ld c, a
    call IsFadingAtMap5AScreen00Y80
    or a
    jr z, .check_follower_records
    ld a, $02
    jr .read_player_anim_counter

.check_follower_records:
    ld a, [wFollowerRecords]
    cp $03
    jr nz, .read_player_anim_counter
    ld a, $21
    ldh [hSpriteAttrXor], a
    ld a, $01

.read_player_anim_counter:
    sla a
    ld c, a
    ldh a, [hPlayerAnimCounter]
    swap a
    srl a
    and $01
    add c
    ldh [hSpriteSubIndex], a
    ld a, $10
    ldh [hSpriteTileOffset], a
    ld a, [wFollowerRecords + $1]
    add $08
    ld l, a
    ldh a, [hScrollX]
    add l
    ldh [hSpriteOriginX], a
    ldh a, [hScrollXHi]
    adc $00
    ldh [hSpriteOriginXHi], a
    ld a, [wFollowerRecords + $2]
    add $10
    ld l, a
    ldh a, [hScrollY]
    add l
    ldh [hSpriteOriginY], a
    ldh a, [hScrollYHi]
    adc $00
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite4008
    ret

AdvancePlayerAnimCounterAndRunPlayerSpriteMode_IsFadingAtMap5AScreen00Y80::
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
    or a
    jr z, .check_player_facing
    ld a, $02
    jr .read_player_anim_counter

.check_player_facing:
    ldh a, [hPlayerFacing]
    cp $03
    jr nz, .read_player_anim_counter
    ld a, $20
    ldh [hSpriteAttrXor], a
    ld a, $01

.read_player_anim_counter:
    add a
    ld c, a
    ldh a, [hPlayerAnimCounter]
    swap a
    srl a
    and $01
    add c
    ldh [hSpriteSubIndex], a
    ld a, $00
    ldh [hSpriteTileOffset], a
    ldh a, [hPlayerX]
    add $08
    ld l, a
    ldh a, [hScrollX]
    add l
    ldh [hSpriteOriginX], a
    ldh a, [hScrollXHi]
    adc $00
    ldh [hSpriteOriginXHi], a
    ldh a, [hPlayerY]
    add $10
    ld l, a
    ldh a, [hScrollY]
    add l
    ldh [hSpriteOriginY], a
    ld l, a
    ldh a, [hScrollYHi]
    adc $00
    ldh [hSpriteOriginYHi], a
    ld h, a
    ldh a, [hPlayerSpriteMode]
    cp $02
    jr nz, .check_player_sprite_override
    ld a, l
    sub $08
    ld l, a
    ld a, h
    sbc $00
    ld h, a
    ld a, l
    ldh [hSpriteOriginY], a
    ld a, h
    ldh [hSpriteOriginYHi], a

.check_player_sprite_override:
    ldh a, [hPlayerSpriteOverride]
    bit 7, a
    jr nz, .skip

.call_draw_meta_sprite4008:
    farcall DrawMetaSprite4008
    ret

.skip:
    and $01
    jr z, .check_player_sprite_stream_lo
    ldh a, [hPlayerSpriteStreamLo]
    ldh [hSpriteSetIndex], a
    jr .call_draw_meta_sprite4008

.check_player_sprite_stream_lo:
    ldh a, [hPlayerSpriteStreamLo]
    and $7f
    ldh [hSpriteSetIndex], a
    ldh a, [hPlayerSpriteStreamHi]
    or a
    jr nz, .call_draw_meta_sprite_set_bank27
    ldh a, [hPlayerSpriteStreamLo]
    bit 7, a
    jr nz, .call_draw_meta_sprite_set_bank26
    farcall DrawMetaSpriteSet_Bank25
    ret

.call_draw_meta_sprite_set_bank26:
    farcall DrawMetaSpriteSet_Bank26
    ret

.call_draw_meta_sprite_set_bank27:
    farcall DrawMetaSpriteSet_Bank27
    ret

; for each party member (wPartyCount) walks wFollowerRecords and wPartyList and draws its follower
; sprite unless the matching hFieldDrawFlags bit is set (E-0175)
DrawPartyFollowerSprites::
    ld a, $02
    ldh [hTemp9], a
    ld a, [wPartyCount]
    or a
    ret z
    ld b, a
    ld hl, wFollowerRecords
    ld de, wPartyList + $3
    ld a, $10
    ldh [hTemp0], a

.loop:
    push bc
    push de
    push hl
    ldh a, [hTemp9]
    ld c, a
    ldh a, [hFieldDrawFlags]
    and c
    jp nz, .read_temp0
    ld a, $03
    sub b
    inc a
    ldh [hSpriteAttrXor], a
    push bc
    inc hl
    ld a, [hli]
    ld b, a
    ld a, [hld]
    ld c, a
    dec hl
    call IsFadingAtMap5AScreen00Y80
    pop bc
    or a
    jr z, .skip
    ld a, $02
    inc hl
    jr .read_player_anim_counter

.skip:
    ld a, [hli]
    cp $03
    jr nz, .read_player_anim_counter
    ldh a, [hSpriteAttrXor]
    or $20
    ldh [hSpriteAttrXor], a
    ld a, $01

.read_player_anim_counter:
    add a
    ld c, a
    ldh a, [hPlayerAnimCounter]
    swap a
    srl a
    and $01
    add c
    ldh [hSpriteSubIndex], a
    ldh a, [hTemp0]
    ldh [hSpriteTileOffset], a
    ld a, [hli]
    add $08
    ld c, a
    ldh a, [hScrollX]
    add c
    ldh [hSpriteOriginX], a
    ldh a, [hScrollXHi]
    adc $00
    ldh [hSpriteOriginXHi], a
    ld a, [hli]
    add $10
    ld c, a
    ldh a, [hScrollY]
    add c
    ldh [hSpriteOriginY], a
    ldh a, [hScrollYHi]
    adc $00
    ldh [hSpriteOriginYHi], a
    inc de
    ld a, [de]
    dec de
    cp $ff
    jr nz, .set_sprite_set_index
    ld a, $19
    ldh [hSpriteSetIndex], a
    farcall DrawMetaSprite
    jr .read_temp0

.set_sprite_set_index:
    ld a, [de]
    and $7f
    ldh [hSpriteSetIndex], a
    inc de
    ld a, [de]
    or a
    jr nz, .call_draw_meta_sprite_set_bank27
    dec de
    ld a, [de]
    bit 7, a
    jr nz, .call_draw_meta_sprite_set_bank26
    farcall DrawMetaSpriteSet_Bank25
    jp .read_temp0

.call_draw_meta_sprite_set_bank26:
    farcall DrawMetaSpriteSet_Bank26
    jp .read_temp0

.call_draw_meta_sprite_set_bank27:
    farcall DrawMetaSpriteSet_Bank27

.read_temp0:
    ldh a, [hTemp0]
    add $10
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
    jp nz, .loop
    ret

; A = 1 while a fade runs on map $5A, screen (0, 0), with hPlayerY = $80; otherwise A = 0 (E-0175)
IsFadingAtMap5AScreen00Y80::
    ld a, [wFadeState]
    or a
    jr z, .skip
    ldh a, [hMapId]
    cp $5a
    jr nz, .return_0
    ldh a, [hMapScreenX]
    or a
    jr nz, .return_0
    ldh a, [hMapScreenY]
    or a
    jr nz, .return_0
    ldh a, [hPlayerY]
    cp $80
    jr nz, .return_0
    ld a, $01
    ret

.return_0:
    xor a
    ret

.skip:
    push hl
    push de
    ld hl, $4e73

.skip2:
    push hl
    ld a, [hl]
    cp $ff
    jr nz, .read_map_id
    pop hl
    pop de
    pop hl
    xor a
    ret

.read_map_id:
    ldh a, [hMapId]
    ld e, a
    ld a, [hli]
    cp e
    jr nz, .restore
    ldh a, [hMapScreenX]
    ld e, a
    ld a, [hli]
    cp e
    jr nz, .restore
    ldh a, [hMapScreenY]
    ld e, a
    ld a, [hli]
    cp e
    jr nz, .restore
    ld a, [hli]
    cp b
    jr nz, .restore
    ld a, [hli]
    cp c
    jr z, .skip3
    jr nc, .restore

.skip3:
    ld a, [hl]
    cp c
    jr c, .restore
    pop hl
    pop de
    pop hl
    ld a, $01
    ret

.restore:
    pop hl
    ld a, $06
    add_a_to_hl
    jr .skip2
    db $05, $02, $00, $50, $00, $28, $2b, $03, $03, $20, $00, $18, $5a, $00, $00, $40
    db $10, $48, $5a, $00, $00, $70, $30, $48, $5c, $00, $01, $30, $78, $90, $7a, $00
    db $00, $40, $58, $80, $7a, $00, $01, $40, $00, $28, $7a, $00, $01, $50, $10, $28
    db $7a, $00, $01, $30, $38, $48, $ff

; E-0041 (C1: the debug monster viewer's second pane decompresses the stream for its id to vTiles0 +
; $200; all 384 entries parse). Far pointers: address, bank.
; record: compressed small-sprite stream (32 or 256 bytes); ROM bank of that data
MonsterSpriteTable::
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

; SetupKeyWorldObjectsForMapType passes $5327 + 2 * (kind - 1), or + 6 / + $E (goal kind 7) for the
; goal room, to SetupKeyWorldObjectsForMapType_Sub01; it follows MonsterSpriteTable, which therefore
; has 383 entries, not 384 (E-0196, C1)
; record: object grid for this map kind
KeyWorldObjectGridTable::
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

; SetupKeyWorldObjectsForMapType_Sub01 reads the word at the grid + 2 * (hMapScreenY *
; wMapWidthScreens + hMapScreenX); 2 screens, up to the next structure (E-0196, C1)
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_5347::
    dw KeyWorldScreenObjects_534B ; id 0
    dw KeyWorldScreenObjects_5366 ; id 1

; a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list (E-0196, C1)
; record: marker word; pointer to the object list
KeyWorldScreenObjects_534B::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_534F

; the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object
; record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world
; encounter when hTemp9 is set (E-0196, C1)
; record: count 2, then 2 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_534F::
    db $02 ; entry 0: object count
    db $85, $01, $00, $00, $00, $40, $20, $05, $00, $50, $00 ; object 0
    db $86, $01, $01, $00, $00, $60, $50, $06, $03, $60, $01 ; object 1

KeyWorldScreenObjects_5366::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_536A

; record: count 3, then 3 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_536A::
    db $03 ; entry 0: object count
    db $85, $01, $01, $00, $00, $30, $20, $05, $00, $50, $02 ; object 0
    db $86, $01, $01, $00, $00, $60, $60, $06, $00, $60, $03 ; object 1
    db $87, $01, $06, $00, $00, $70, $10, $07, $00, $70, $fa ; object 2

; SetupKeyWorldObjectsForMapType_Sub01 reads the word at the grid + 2 * (hMapScreenY *
; wMapWidthScreens + hMapScreenX); 4 screens, up to the next structure (E-0196, C1)
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_538C::
    dw KeyWorldScreenObjects_5394 ; id 0
    dw KeyWorldScreenObjects_53AF ; id 1
    dw KeyWorldScreenObjects_53E0 ; id 2
    dw KeyWorldScreenObjects_53F0 ; id 3

; a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list (E-0196, C1)
; record: marker word; pointer to the object list
KeyWorldScreenObjects_5394::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_5398

; the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object
; record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world
; encounter when hTemp9 is set (E-0196, C1)
; record: count 2, then 2 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_5398::
    db $02 ; entry 0: object count
    db $85, $01, $08, $00, $00, $e0, $e0, $05, $00, $50, $fc ; object 0
    db $86, $01, $02, $00, $00, $20, $40, $06, $00, $60, $00 ; object 1

KeyWorldScreenObjects_53AF::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_53B3

; record: count 4, then 4 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_53B3::
    db $04 ; entry 0: object count
    db $85, $01, $02, $00, $00, $e0, $e0, $05, $00, $50, $fc ; object 0
    db $86, $01, $03, $00, $02, $40, $20, $06, $01, $60, $01 ; object 1
    db $87, $01, $04, $00, $00, $60, $50, $07, $00, $70, $02 ; object 2
    db $84, $01, $05, $00, $00, $20, $60, $04, $01, $40, $03 ; object 3

; a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list (E-0196, C1)
; record: marker word; pointer to the object list
KeyWorldScreenObjects_53E0::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_53E4

; the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object
; record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world
; encounter when hTemp9 is set (E-0196, C1)
; record: count 1, then 1 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_53E4::
    db $01 ; entry 0
    db $85, $01, $04, $00, $00, $70, $50, $05, $00, $50, $04

KeyWorldScreenObjects_53F0::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_53F4

; record: count 4, then 4 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_53F4::
    db $04 ; entry 0: object count
    db $85, $01, $03, $00, $00, $20, $40, $05, $03, $50, $05 ; object 0
    db $86, $01, $05, $00, $02, $40, $70, $06, $01, $60, $06 ; object 1
    db $87, $01, $02, $00, $00, $50, $30, $07, $00, $70, $07 ; object 2
    db $84, $01, $06, $00, $00, $60, $10, $04, $00, $40, $fa ; object 3

; SetupKeyWorldObjectsForMapType_Sub01 reads the word at the grid + 2 * (hMapScreenY *
; wMapWidthScreens + hMapScreenX); 4 screens, up to the next structure (E-0196, C1)
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_5421::
    dw KeyWorldScreenObjects_5429 ; id 0
    dw KeyWorldScreenObjects_5444 ; id 1
    dw KeyWorldScreenObjects_5475 ; id 2
    dw KeyWorldScreenObjects_5490 ; id 3

; a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list (E-0196, C1)
; record: marker word; pointer to the object list
KeyWorldScreenObjects_5429::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_542D

; the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object
; record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world
; encounter when hTemp9 is set (E-0196, C1)
; record: count 2, then 2 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_542D::
    db $02 ; entry 0: object count
    db $85, $01, $08, $00, $00, $e0, $e0, $05, $00, $50, $fc ; object 0
    db $86, $01, $04, $00, $00, $20, $40, $06, $00, $60, $04 ; object 1

KeyWorldScreenObjects_5444::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_5448

; record: count 4, then 4 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_5448::
    db $04 ; entry 0: object count
    db $85, $01, $02, $00, $00, $e0, $e0, $05, $00, $50, $fc ; object 0
    db $86, $01, $03, $00, $00, $70, $50, $06, $01, $60, $05 ; object 1
    db $87, $01, $02, $00, $02, $30, $60, $07, $01, $70, $07 ; object 2
    db $84, $01, $07, $00, $00, $40, $20, $04, $00, $40, $fd ; object 3

; a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list (E-0196, C1)
; record: marker word; pointer to the object list
KeyWorldScreenObjects_5475::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_5479

; the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object
; record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world
; encounter when hTemp9 is set (E-0196, C1)
; record: count 2, then 2 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_5479::
    db $02 ; entry 0: object count
    db $85, $01, $03, $00, $00, $70, $50, $05, $01, $50, $01 ; object 0
    db $86, $01, $05, $00, $02, $30, $60, $06, $01, $60, $06 ; object 1

KeyWorldScreenObjects_5490::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_5494

; record: count 4, then 4 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_5494::
    db $04 ; entry 0: object count
    db $85, $01, $02, $00, $00, $70, $30, $05, $00, $50, $00 ; object 0
    db $86, $01, $04, $00, $00, $40, $70, $06, $02, $60, $02 ; object 1
    db $87, $01, $05, $00, $02, $40, $40, $07, $01, $70, $03 ; object 2
    db $84, $01, $06, $00, $00, $60, $10, $04, $00, $40, $fa ; object 3

; SetupKeyWorldObjectsForMapType_Sub01 reads the word at the grid + 2 * (hMapScreenY *
; wMapWidthScreens + hMapScreenX); 2 screens, up to the next structure (E-0196, C1)
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_54C1::
    dw KeyWorldScreenObjects_54C5 ; id 0
    dw KeyWorldScreenObjects_54E0 ; id 1

; a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list (E-0196, C1)
; record: marker word; pointer to the object list
KeyWorldScreenObjects_54C5::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_54C9

; the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object
; record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world
; encounter when hTemp9 is set (E-0196, C1)
; record: count 2, then 2 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_54C9::
    db $02 ; entry 0: object count
    db $85, $01, $02, $00, $00, $50, $30, $05, $00, $50, $fd ; object 0
    db $86, $01, $04, $00, $00, $60, $70, $06, $03, $60, $00 ; object 1

KeyWorldScreenObjects_54E0::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_54E4

; record: count 4, then 4 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_54E4::
    db $04 ; entry 0: object count
    db $85, $01, $03, $00, $00, $60, $30, $05, $03, $50, $01 ; object 0
    db $86, $01, $02, $00, $00, $20, $60, $06, $02, $60, $02 ; object 1
    db $87, $01, $05, $00, $02, $40, $70, $07, $01, $70, $03 ; object 2
    db $84, $01, $06, $00, $00, $20, $20, $04, $00, $40, $fa ; object 3

; SetupKeyWorldObjectsForMapType_Sub01 reads the word at the grid + 2 * (hMapScreenY *
; wMapWidthScreens + hMapScreenX); 2 screens, up to the next structure (E-0196, C1)
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_5511::
    dw KeyWorldScreenObjects_5515 ; id 0
    dw KeyWorldScreenObjects_553B ; id 1

; a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list (E-0196, C1)
; record: marker word; pointer to the object list
KeyWorldScreenObjects_5515::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_5519

; the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object
; record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world
; encounter when hTemp9 is set (E-0196, C1)
; record: count 3, then 3 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_5519::
    db $03 ; entry 0: object count
    db $85, $01, $02, $00, $00, $50, $30, $05, $00, $50, $fd ; object 0
    db $86, $01, $02, $00, $00, $30, $60, $06, $00, $60, $02 ; object 1
    db $87, $01, $05, $00, $00, $60, $70, $07, $00, $70, $03 ; object 2

KeyWorldScreenObjects_553B::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_553F

KeyWorldObjectList_553F::
    db $03 ; entry 0: object count
    db $85, $01, $03, $00, $02, $60, $60, $05, $01, $50, $01 ; object 0
    db $86, $01, $04, $00, $00, $60, $30, $06, $00, $60, $00 ; object 1
    db $87, $01, $06, $00, $00, $20, $20, $07, $00, $70, $fa ; object 2

; SetupKeyWorldObjectsForMapType_Sub01 reads the word at the grid + 2 * (hMapScreenY *
; wMapWidthScreens + hMapScreenX); 1 screens, up to the next structure (E-0196, C1)
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_5561::
    dw KeyWorldScreenObjects_5563 ; id 0

; a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list (E-0196, C1)
; record: marker word; pointer to the object list
KeyWorldScreenObjects_5563::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_5567

; the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object
; record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world
; encounter when hTemp9 is set (E-0196, C1)
; record: count 1, then 1 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_5567::
    db $01 ; entry 0
    db $85, $01, $15, $00, $00, $30, $20, $05, $00, $50, $fc

; SetupKeyWorldObjectsForMapType_Sub01 reads the word at the grid + 2 * (hMapScreenY *
; wMapWidthScreens + hMapScreenX); 1 screens, up to the next structure (E-0196, C1)
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_5573::
    dw KeyWorldScreenObjects_5575 ; id 0

; a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list (E-0196, C1)
; record: marker word; pointer to the object list
KeyWorldScreenObjects_5575::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_5579

; the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object
; record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world
; encounter when hTemp9 is set (E-0196, C1)
; record: count 1, then 1 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_5579::
    db $01 ; entry 0
    db $85, $01, $44, $00, $00, $30, $20, $05, $00, $50, $fc

; SetupKeyWorldObjectsForMapType_Sub01 reads the word at the grid + 2 * (hMapScreenY *
; wMapWidthScreens + hMapScreenX); 1 screens, up to the next structure (E-0196, C1)
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_5585::
    dw KeyWorldScreenObjects_5587 ; id 0

; a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list (E-0196, C1)
; record: marker word; pointer to the object list
KeyWorldScreenObjects_5587::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_558B

; the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object
; record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world
; encounter when hTemp9 is set (E-0196, C1)
; record: count 1, then 1 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_558B::
    db $01 ; entry 0
    db $85, $00, $28, $00, $00, $50, $10, $05, $00, $50, $fe

; SetupKeyWorldObjectsForMapType_Sub01 reads the word at the grid + 2 * (hMapScreenY *
; wMapWidthScreens + hMapScreenX); 1 screens, up to the next structure (E-0196, C1)
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_5597::
    dw KeyWorldScreenObjects_5599 ; id 0

; a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list (E-0196, C1)
; record: marker word; pointer to the object list
KeyWorldScreenObjects_5599::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_559D

; the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object
; record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world
; encounter when hTemp9 is set (E-0196, C1)
; record: count 1, then 1 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_559D::
    db $01 ; entry 0
    db $85, $00, $28, $00, $00, $50, $10, $05, $00, $50, $fe

; SetupKeyWorldObjectsForMapType_Sub01 reads the word at the grid + 2 * (hMapScreenY *
; wMapWidthScreens + hMapScreenX); 1 screens, up to the next structure (E-0196, C1)
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_55A9::
    dw KeyWorldScreenObjects_55AB ; id 0

; a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list (E-0196, C1)
; record: marker word; pointer to the object list
KeyWorldScreenObjects_55AB::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_55AF

; the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object
; record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world
; encounter when hTemp9 is set (E-0196, C1)
; record: count 1, then 1 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_55AF::
    db $01 ; entry 0
    db $85, $00, $28, $00, $00, $40, $50, $05, $00, $50, $fb

; starts a message through script command $09 (message word HL, shown by the same group dispatch as
; ShowMessageHL when wMessageMode = 0): HL is stored in wScriptParam0 (low) and wScriptParam1
; (high); then wModeState = 1, wScriptCommandType = 9, wScriptRunning = 1, wScriptStep = 0 and
; wScriptStartRequest = 0 (an earlier store of $80 to wScriptStartRequest is overwritten)
StartMessageCommand09HL_B04::
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
    xor a
    ld [wScriptStartRequest], a
    ld [wScriptStep], a
    ret

; starts script command $0A (RunOneTimeTreasure) with DE = the treasure's story flag, stored in
; wMessageIndex/wMessageGroup (which that command passes to TestFlagBit and SetFlagBit; it is not a
; message word, correcting E-0081); then wScriptCommandType = $0A, wScriptRunning = 1, wScriptStep =
; 0 (E-0269)
StartTreasureFlagDE_B04::
    ld a, e
    ld [wMessageIndex], a
    ld a, d
    ld [wMessageGroup], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, $01
    ld [wModeState], a
    ld a, $0a
    ld [wScriptCommandType], a
    ld a, $01
    ld [wScriptRunning], a
    xor a
    ld [wScriptStartRequest], a
    ld [wScriptStep], a
    ret

; HL is stored in wScriptPointerLo/Hi; then wScriptStartRequest = $80 and wModeState = 1, so the
; script engine starts fetching at HL (E-0082)
StartScriptAtHL_B04::
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, $01
    ld [wModeState], a
    ret

; talk category $0A: notices and bookshelves ("Hero read the notice", "Hero checked the bookshelf")
ReadableTalkEvents::
    ld a, [wTalkEventGroup]
    jumptable
    dw ReadableTalkEvents_TestFlagBit
    dw TalkScript4F54_HehSoTheseAreTheNewcomers
    dw TalkScript5111_ListenYouTwoQuitYourHorsing
    dw $0000 ; unused index (E-0207)
    dw StartScript4F73AndSetFlag5
    dw StartScript4F7CAndSetFlag06
    dw IfFlag000AStartScript4F9D
    dw Talk0046_ThanksForComingBy
    dw TalkMsg0047_HeroReadTheNoticeWeGuarantee
    dw TalkScript5441_HeroCheckedThePedestalIts
    dw ReadableTalkEvents_TestFlagBit_Case0A
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
    dw ReadableTalkEvents_TestFlagBit_Case17
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

; starts Script_5063: 'In the middle of the sea'
ReadableTalkEvents_TestFlagBit::
    ld de, $0001
    call TestFlagBit
    jr nc, .call_start_script_at_hl_b04
    ld hl, Script_5063
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_509F
    call StartScriptAtHL_B04
    ret

; starts Script_4F54 (StartScriptAtHL); its first message begins 'Heh, so these are the newcomers?'
; (E-0271; was DispatchTalkEvent_Case0A_Sub01_Case01)
; starts Script_4F54: '*: Heh, so these are the'
TalkScript4F54_HehSoTheseAreTheNewcomers::
    ld hl, Script_4F54
    call StartScriptAtHL_B04
    ret

; starts Script_5111 (StartScriptAtHL); its first message begins 'Listen you two! Quit your horsing'
; (E-0271; was DispatchTalkEvent_Case0A_Sub01_Case02)
; starts Script_5111: '*: Listen you two! Quit your'
TalkScript5111_ListenYouTwoQuitYourHorsing::
    ld hl, Script_5111
    call StartScriptAtHL_B04
    ret
    db $21, $44, $00, $cd, $bb, $55, $c9

; StartScriptAtHL_B04 with HL = $4F73, then sets story flag 5 (E-0119)
; starts Script_4F73: '*: Oh It's all spinning around'
StartScript4F73AndSetFlag5::
    ld hl, Script_4F73
    call StartScriptAtHL_B04
    ld de, $0005
    call SetFlagBit
    ret

; map event: starts script $4F7C, runs RunFieldCommandTemp0 with hTemp0 = 0 and sets story flag 6
; (E-0122)
; starts Script_4F7C
StartScript4F7CAndSetFlag06::
    ld hl, Script_4F7C
    call StartScriptAtHL_B04
    ld a, $00
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld de, $0006
    call SetFlagBit
    ret

; when story flag $0A is set, StartScriptAtHL_B04 with HL = $4F9D (E-0119)
; starts Script_4F9D: 'Warubou: Calm down and listen! What'
IfFlag000AStartScript4F9D::
    ld de, $000a
    call TestFlagBit
    ret nc
    ld hl, Script_4F9D
    call StartScriptAtHL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 2
; constant message(s) depending on story flags and state; the first one in the code is $0046, whose
; string begins 'Thanks for coming by. I'll always'; the branching is not interpreted (E-0097)
Talk0046_ThanksForComingBy::
    ld de, $0025
    call TestFlagBit
    jr c, .set_data_bank_to_102
    ld de, $0002
    call TestFlagBit
    jr c, .set_data_bank_to_10
    ld de, $000c
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $0007
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld a, $01
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld hl, Script_4F88
    call StartScriptAtHL_B04
    ld de, $0007
    call SetFlagBit
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0046 ; '*: Thanks for coming by. I'll'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $0079 ; '*: You say the island will'
    call StartMessageCommand09HL_B04
    ret

.set_data_bank_to_10:
    ld a, $10
    ld [wDataBank], a
    ld de, $0103
    call TestFlagBit
    jr c, .loop
    ld hl, Script_5353
    call StartScriptAtHL_B04
    ret

.loop:
    ld hl, Script_535D
    call StartScriptAtHL_B04
    ret

.set_data_bank_to_102:
    ld a, $10
    ld [wDataBank], a
    ld de, $0127
    call TestFlagBit
    jr c, .loop
    ld hl, Script_5364
    call StartScriptAtHL_B04
    ret

; starts message $0047 through StartMessageCommand09HL (script command $09); that string begins '0
; read the notice. We guarantee the' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case0A_Sub01_Case08)
; starts Script_5441: '0 checked the pedestal. It's the'
TalkMsg0047_HeroReadTheNoticeWeGuarantee::
    ld hl, $0047 ; '0 read the notice. 'We guarantee'
    call StartMessageCommand09HL_B04
    ret

; starts Script_5441 (StartScriptAtHL); its first message begins '0 checked the pedestal. It's the'
; (E-0271; was DispatchTalkEvent_Case0A_Sub01_Case09)
; starts Script_5441: '0 checked the pedestal. It's the'
TalkScript5441_HeroCheckedThePedestalIts::
    ld hl, Script_5441
    call StartScriptAtHL_B04
    ret

ReadableTalkEvents_TestFlagBit_Case0A::
    ldh a, [hPlayerX]
    cp $40
    jr z, .clear_sprite_slots
    ld a, $03
    ld [wSpriteSlots + $7], a
    jr .set_data_bank_to_1F

.clear_sprite_slots:
    xor a
    ld [wSpriteSlots + $7], a

.set_data_bank_to_1F:
    ld a, $1f
    ld [wDataBank], a
    ld de, $0025
    call TestFlagBit
    jr c, .call_total_species_flagged_or_listed
    ld de, $0108
    call TestFlagBit
    jr c, .loop
    ld hl, Script_544E
    call StartScriptAtHL_B04
    ret

.loop:
    ld hl, Script_5458
    call StartScriptAtHL_B04
    ret

.call_total_species_flagged_or_listed:
    farcall TotalSpeciesFlaggedOrListed
    ldh a, [hTemp1]
    or a
    jr z, .loop2
    ldh a, [hTemp0]
    cp $38
    jr c, .loop2
    jr .call_test_flag_bit

.loop2:
    ld de, $002d
    call TestFlagBit
    jr c, .loop
    ld hl, Script_545F
    call StartScriptAtHL_B04
    ret

.call_test_flag_bit:
    ld de, $019e
    call TestFlagBit
    jr c, .loop2
    ld hl, Script_5469
    call StartScriptAtHL_B04
    ret

; starts message $0233 through StartMessageCommand09HL (script command $09); that string begins '0
; checked the bookshelf. Monster Skills Every' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case0A_Sub01_Case0B)
TalkMsg0233_HeroCheckedTheBookshelfMonster::
    ld hl, $0233 ; '0 checked the bookshelf. 'Monster Skills'
    call StartMessageCommand09HL_B04
    ret

; starts message $0234 through StartMessageCommand09HL (script command $09); that string begins '0
; checked the bookshelf. Monster Growth By' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case0A_Sub01_Case0C)
TalkMsg0234_HeroCheckedTheBookshelfMonster::
    ld hl, $0234 ; '0 checked the bookshelf. 'Monster Growth'
    call StartMessageCommand09HL_B04
    ret

; starts message $0235 through StartMessageCommand09HL (script command $09); that string begins '0
; checked the bookshelf. Personalities of Monsters' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case0A_Sub01_Case0D)
TalkMsg0235_HeroCheckedTheBookshelfPersonalities::
    ld hl, $0235 ; '0 checked the bookshelf. 'Personalities of'
    call StartMessageCommand09HL_B04
    ret

; starts message $0236 through StartMessageCommand09HL (script command $09); that string begins '0
; checked the bookshelf. Nuts and Seeds' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case0A_Sub01_Case0E)
TalkMsg0236_HeroCheckedTheBookshelfNuts::
    ld hl, $0236 ; '0 checked the bookshelf. 'Nuts and'
    call StartMessageCommand09HL_B04
    ret

; starts message $0237 through StartMessageCommand09HL (script command $09); that string begins '0
; checked the bookshelf. WorldLeaf An indispensable' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case0A_Sub01_Case0F)
TalkMsg0237_HeroCheckedTheBookshelfWorldLeaf::
    ld hl, $0237 ; '0 checked the bookshelf. 'WorldLeaf An'
    call StartMessageCommand09HL_B04
    ret

; starts message $0238 through StartMessageCommand09HL (script command $09); that string begins '0
; checked the bookshelf. Magic Key Guide' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case0A_Sub01_Case10)
TalkMsg0238_HeroCheckedTheBookshelfMagic::
    ld hl, $0238 ; '0 checked the bookshelf. 'Magic Key'
    call StartMessageCommand09HL_B04
    ret

; starts message $0239 through StartMessageCommand09HL (script command $09); that string begins '0
; checked the bookshelf. Magic Key Guide' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case0A_Sub01_Case11)
TalkMsg0239_HeroCheckedTheBookshelfMagic::
    ld hl, $0239 ; '0 checked the bookshelf. 'Magic Key'
    call StartMessageCommand09HL_B04
    ret

; starts message $023A through StartMessageCommand09HL (script command $09); that string begins '0
; checked the bookshelf. Starry Shrine A' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case0A_Sub01_Case12)
TalkMsg023A_HeroCheckedTheBookshelfStarry::
    ld hl, $023a ; '0 checked the bookshelf. 'Starry Shrine'
    call StartMessageCommand09HL_B04
    ret

; starts message $023B through StartMessageCommand09HL (script command $09); that string begins '0
; checked the bookshelf. Egg Evaluators Those' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case0A_Sub01_Case13)
TalkMsg023B_HeroCheckedTheBookshelfEgg::
    ld hl, $023b ; '0 checked the bookshelf. 'Egg Evaluators'
    call StartMessageCommand09HL_B04
    ret

; starts message $023C through StartMessageCommand09HL (script command $09); that string begins '0
; checked the bookshelf. Accessory Guide A' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case0A_Sub01_Case14)
TalkMsg023C_HeroCheckedTheBookshelfAccessory::
    ld hl, $023c ; '0 checked the bookshelf. 'Accessory Guide'
    call StartMessageCommand09HL_B04
    ret

; starts message $023D through StartMessageCommand09HL (script command $09); that string begins '0
; checked the bookshelf. Hidden Abilities Monsters' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case0A_Sub01_Case15)
TalkMsg023D_HeroCheckedTheBookshelfHidden::
    ld hl, $023d ; '0 checked the bookshelf. 'Hidden Abilities'
    call StartMessageCommand09HL_B04
    ret

; starts message $023E through StartMessageCommand09HL (script command $09); that string begins '0
; read the notice. Please return books' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case0A_Sub01_Case16)
TalkMsg023E_HeroReadTheNoticePleaseReturn::
    ld hl, $023e ; '0 read the notice. 'Please return'
    call StartMessageCommand09HL_B04
    ret

ReadableTalkEvents_TestFlagBit_Case17::
    ld de, $0025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld de, $0024
    call TestFlagBit
    ret c

.call_start_message_command09_hl_b04:
    ld hl, $0042 ; '0 read the sign. 'Danger! Stay'
    call StartMessageCommand09HL_B04
    ret

; starts message $0010 through StartMessageCommand09HL (script command $09); that string begins '0
; peered into the vase. Freshly caught' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case0A_Sub01_Case18)
TalkMsg0010_HeroPeeredIntoTheVaseFreshly::
    ld hl, $0010 ; '0 peered into the vase. Freshly'
    call StartMessageCommand09HL_B04
    ret

; starts message $000F through StartMessageCommand09HL (script command $09); that string begins '0
; peered into the barrel. It was' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case0A_Sub01_Case19)
TalkMsg000F_HeroPeeredIntoTheBarrelIt::
    ld hl, $000f ; '0 peered into the barrel. It'
    call StartMessageCommand09HL_B04
    ret

; with story flag $1A set: counts keys twice (WriteKeyEntryTemp0 with hTemp1 = 1 and 2), sets bit 7
; of wGameFlags836 and starts script $5039 (E-0124)
MapEventCountKeysAndStartScript5039::
    ld de, $001a
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

; when story flag $00D1 is set (TestFlagBit), starts message $0D33 through
; StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'You saved
; us all by yourself.' (E-0082)
IfFlag00D1Msg0D33_YouSavedUsAll::
    ld de, $00d1
    call TestFlagBit
    ret nc
    ld hl, $0d33 ; '*: You saved us all by'
    call StartMessageCommand09HL_B04
    ret

; when story flag $00D1 is set (TestFlagBit), starts message $0D34 through
; StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'Please,
; eat up, eat up! Don't' (E-0082)
IfFlag00D1Msg0D34_PleaseEatUpEat::
    ld de, $00d1
    call TestFlagBit
    ret nc
    ld hl, $0d34 ; '*: Please, eat up, eat up!'
    call StartMessageCommand09HL_B04
    ret

; when story flag $00D1 is set (TestFlagBit), starts message $0D35 through
; StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'Hm? I saw
; your family. They' (E-0082)
IfFlag00D1Msg0D35_HmISawYour::
    ld de, $00d1
    call TestFlagBit
    ret nc
    ld hl, $0d35 ; '*: Hm? I saw your family.'
    call StartMessageCommand09HL_B04
    ret

; when story flag $00D1 is set (TestFlagBit), starts message $0D36 through
; StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'The
; Kingdom is rejoicing!' (E-0082)
IfFlag00D1Msg0D36_TheKingdomIsRejoicing::
    ld de, $00d1
    call TestFlagBit
    ret nc
    ld hl, $0d36 ; '*: The Kingdom is rejoicing!'
    call StartMessageCommand09HL_B04
    ret

; when story flag $00D1 is set (TestFlagBit), starts message $0D37 through
; StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'Instead
; of standing around, you should' (E-0082)
IfFlag00D1Msg0D37_InsteadOfStandingAround::
    ld de, $00d1
    call TestFlagBit
    ret nc
    ld hl, $0d37 ; '*: Instead of standing around, you'
    call StartMessageCommand09HL_B04
    ret

; when story flag $00D1 is set (TestFlagBit), starts message $0D38 through
; StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'Just
; imagine if you weren't here.' (E-0082)
IfFlag00D1Msg0D38_JustImagineIfYou::
    ld de, $00d1
    call TestFlagBit
    ret nc
    ld hl, $0d38 ; '*: Just imagine if you weren't'
    call StartMessageCommand09HL_B04
    ret

; when story flag $00D1 is set (TestFlagBit), starts message $0D39 through
; StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'Ah,
; GreatLog's mighty hero! I hope' (E-0082)
IfFlag00D1Msg0D39_AhGreatLogsMightyHero::
    ld de, $00d1
    call TestFlagBit
    ret nc
    ld hl, $0d39 ; '*: Ah, GreatLog's mighty hero! I'
    call StartMessageCommand09HL_B04
    ret

; when story flag $00D1 is set (TestFlagBit), starts message $0D3A through
; StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'To be
; honest, I was getting' (E-0082)
IfFlag00D1Msg0D3A_ToBeHonestI::
    ld de, $00d1
    call TestFlagBit
    ret nc
    ld hl, $0d3a ; '*: To be honest, I was'
    call StartMessageCommand09HL_B04
    ret

; talk category 3: jumps by wTalkEventGroup to the talk handlers of Yold, Polona and Port Ritz
; (messages $0800-$088F)
YoldTalkEvents::
    ld a, [wTalkEventGroup]
    jumptable
    dw TalkMsg0800_ThisIsTheVillageOfYold
    dw TalkMsg0801_InTheNorthwestIsAVillage
    dw TalkMsg0802_AroundThesePartsItsFaster
    dw TalkMsg0803_ISawAHauntedShipIn
    dw TalkMsg0804_TheVolcanicIslandOffTheCoast
    dw TalkMsg0805_MermaidsLivedInTheSeaIn
    dw YoldTalkEvents_TestFlagBit
    dw YoldTalkEvents_StartScriptAtHL_B04
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
    dw YoldTalkEvents_TestFlagBit_Case13
    dw YoldTalkEvents_StartScriptAtHL_B04_Case14
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
    dw YoldTalkEvents_StartScriptAtHL_B04_Case20
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
    dw YoldTalkEvents_StartScriptAtHL_B04_Case2C
    dw TalkMsg082F_ThisAreaWasALotMore
    dw TalkMsg0830_WhenYoureOutAtSeaYou
    dw TalkScript5BC4
    dw TalkMsg0834_WhenThatOldManGetsGrogged
    dw TalkMsg0835_TheOldFellowThereTheInstant
    dw TalkMsg0836_TheVolcanicIslandOffTheCoast
    dw YoldTalkEvents_ShowHnnnrHicGnnZzz
    dw YoldTalkEvents_TestFlagBit_Case34
    dw ChestItem_Rib
    dw ChestItem_LoveWater
    dw ChestItem_LoveWater_Flag0069
    dw ChestItem_ExitBell
    dw ChestItem_MermScale
    dw ChestItem_Warp
    dw TalkMsg0843_ISawAChildCrossThe
    dw TalkMsg0844_WatchMeDanceAndYoullWant
    dw YoldTalkEvents_TestFlagBit_Case3D
    dw YoldTalkEvents_ShowThisIsTheMermaid
    dw TalkMsg084F_IKnowNotAllHumansAre
    dw TalkMsg0850_ThePiratesCaughtUsInNets
    dw TalkMsg0851_TheHarMirrorWasExquisite
    dw TalkMsg0852_TheMoonRockFellFromTheSky
    dw TalkMsg0853_ThePiratesSankWithTheirShip
    dw TalkMsg0854_WeMermaidsArePeacefulBeings
    dw YoldTalkEvents_TestFlagBit_Case45
    dw TalkScript5C88
    dw TalkScript5C8A_HowCouldWeDieBeforeEnjoying
    dw TalkScript5C94_TheTreasuresAreOursNoOne
    dw TalkScript5C9E_ItNagsAndNagsThatWe
    dw YoldTalkEvents_TestFlagBit_Case4A
    dw YoldTalkEvents_ShowHeroCheckedTheTreasure
    dw YoldTalkEvents_StartScriptAtHL_B04_Case4C
    dw YoldTalkEvents_SetSpriteSlotsPlus7
    dw ChestItem_LogTwig
    dw YoldTalkEvents_ShowHeroCheckedThePedestal
    dw YoldTalkEvents_SetFlagBit
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
    dw YoldTalkEvents_StartScriptAtHL_B04_Case6A
    dw TalkMsg00FF_Composing
    dw TalkScript5D44_ThickSuctionCuppedTentacles
    dw YoldTalkEvents_TestFlagBit_Case6D

; starts message $0800 through StartMessageCommand09HL (script command $09); that string begins
; 'This is the village of Yold. We're' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case00)
TalkMsg0800_ThisIsTheVillageOfYold::
    ld hl, $0800 ; '*: This is the village of'
    call StartMessageCommand09HL_B04
    ret

; starts message $0801 through StartMessageCommand09HL (script command $09); that string begins 'In
; the northwest is a village that' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case01)
TalkMsg0801_InTheNorthwestIsAVillage::
    ld hl, $0801 ; '*: In the northwest is a'
    call StartMessageCommand09HL_B04
    ret

; starts message $0802 through StartMessageCommand09HL (script command $09); that string begins
; 'Around these parts it's faster to travel' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case02)
TalkMsg0802_AroundThesePartsItsFaster::
    ld hl, $0802 ; '*: Around these parts it's faster'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005F then jr c,
; TalkMsg0803_ISawAHauntedShipIn.call_start_message_command09_hl_b04); starts message $0803 through
; StartMessageCommand09HL (script command $09); that string begins 'I saw a haunted ship in the'
; (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case03)
TalkMsg0803_ISawAHauntedShipIn::
    ld de, $005f
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0803 ; '*: I saw a haunted ship'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0874 ; '*: I haven't seen the ghost'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005F then jr c,
; TalkMsg0804_TheVolcanicIslandOffTheCoast.call_start_message_command09_hl_b04); starts message
; $0804 through StartMessageCommand09HL (script command $09); that string begins 'The volcanic
; island off the coast appears' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case04)
TalkMsg0804_TheVolcanicIslandOffTheCoast::
    ld de, $005f
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0804 ; '*: The volcanic island off the'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0875 ; '*: The volcanic island appears to'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005F then jr c,
; TalkMsg0805_MermaidsLivedInTheSeaIn.call_start_message_command09_hl_b04); starts message $0805
; through StartMessageCommand09HL (script command $09); that string begins 'Mermaids lived in the
; sea in the' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case05)
TalkMsg0805_MermaidsLivedInTheSeaIn::
    ld de, $005f
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0805 ; '*: Mermaids lived in the sea'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0876 ; '*: Sigh Will the HarMirror make'
    call StartMessageCommand09HL_B04
    ret

YoldTalkEvents_TestFlagBit::
    ld de, $005f
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $0060
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, Script_5B84
    call StartScriptAtHL_B04
    ld de, $0060
    call SetFlagBit
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0808 ; '*: I hope the volcanic island'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $0877 ; '*: My grandson just shivers now'
    call StartMessageCommand09HL_B04
    ret

YoldTalkEvents_StartScriptAtHL_B04::
    ld a, $04
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_5B8C
    call StartScriptAtHL_B04
    ret

; starts message $080A through StartMessageCommand09HL (script command $09); that string begins '0
; peered into the barrel. A folded' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case08)
TalkMsg080A_HeroPeeredIntoTheBarrelA::
    ld hl, $080a ; '0 peered into the barrel. A'
    call StartMessageCommand09HL_B04
    ret

; starts message $080B through StartMessageCommand09HL (script command $09); that string begins '0
; peered into the barrel. It was' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case09)
TalkMsg080B_HeroPeeredIntoTheBarrelIt::
    ld hl, $080b ; '0 peered into the barrel. It'
    call StartMessageCommand09HL_B04
    ret

; a one-time barrel: script command $0A with wScriptParam0 = 2 (kind) and wScriptParam1 = $2C, story
; flag $0061 in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the flag (message
; $A6 of group 0; $A7 when the flag is already set, $A8 when there is no room) (E-0269; was
; DispatchTalkEvent_Case03_Sub01_Case0A)
BarrelItem_TinyMedal::
    ld a, $02
    ld [wScriptParam0], a
    ld a, $2c
    ld [wScriptParam1], a
    ld de, $0061
    call StartTreasureFlagDE_B04
    ret

; a one-time barrel: script command $0A with wScriptParam0 = 2 (kind) and wScriptParam1 = $28, story
; flag $0062 in DE: when the flag is clear it gives item $28 (Warp) and sets the flag (message $A6
; of group 0; $A7 when the flag is already set, $A8 when there is no room) (E-0269; was
; DispatchTalkEvent_Case03_Sub01_Case0B)
BarrelItem_Warp::
    ld a, $02
    ld [wScriptParam0], a
    ld a, $28
    ld [wScriptParam1], a
    ld de, $0062
    call StartTreasureFlagDE_B04
    ret

; starts message $088A through StartMessageCommand09HL (script command $09); that string begins '0
; peered into the vase. It was' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case0C)
TalkMsg088A_HeroPeeredIntoTheVaseIt::
    ld hl, $088a ; '0 peered into the vase. It'
    call StartMessageCommand09HL_B04
    ret

; starts message $0889 through StartMessageCommand09HL (script command $09); that string begins '0
; peered into the oven. It smelled' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case0D)
TalkMsg0889_HeroPeeredIntoTheOvenIt::
    ld hl, $0889 ; '0 peered into the oven. It'
    call StartMessageCommand09HL_B04
    ret

; starts message $0037 through StartMessageCommand09HL (script command $09); that string begins '0
; tried to open the chest. But' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case0E)
TalkMsg0037_HeroTriedToOpenTheChest::
    ld hl, $0037 ; '0 tried to open the chest.'
    call StartMessageCommand09HL_B04
    ret

; starts message $080C through StartMessageCommand09HL (script command $09); that string begins
; 'Welcome to Polona. It's a tourist resort' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case0F)
TalkMsg080C_WelcomeToPolonaItsATourist::
    ld hl, $080c ; '*: Welcome to Polona. It's a'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005F then jr c,
; TalkMsg080D_YouCouldMeetMermaidsHere.call_start_message_command09_hl_b04); starts message $080D
; through StartMessageCommand09HL (script command $09); that string begins 'You could meet mermaids
; here in the' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case10)
TalkMsg080D_YouCouldMeetMermaidsHere::
    ld de, $005f
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $080d ; '*: You could meet mermaids here'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0878 ; '*: The mermaids came back.'
    call StartMessageCommand09HL_B04
    ret

; starts message $080E through StartMessageCommand09HL (script command $09); that string begins 'I'm
; from the port in the northeast.' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case11)
TalkMsg080E_ImFromThePortInThe::
    ld hl, $080e ; '*: I'm from the port in'
    call StartMessageCommand09HL_B04
    ret

; starts message $080F through StartMessageCommand09HL (script command $09); that string begins
; 'You're not supposed to go near the' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case12)
TalkMsg080F_YoureNotSupposedToGoNear::
    ld hl, $080f ; '*: You're not supposed to go'
    call StartMessageCommand09HL_B04
    ret

YoldTalkEvents_TestFlagBit_Case13::
    ld de, $006f
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    farcall FindPartyMemberWithSkill76To7DOr92
    ldh a, [hTemp1]
    bit 7, a
    jr z, .call_set_w_step_arrived_if_party_has_field55
    ld hl, Script_5C2F
    call StartScriptAtHL_B04
    ret

.call_set_w_step_arrived_if_party_has_field55:
    farcall SetWStepArrivedIfPartyHasField55Bit7
    ld a, [wStepArrived]
    or a
    jr z, .read_temp1
    ld hl, Script_5C5C
    call StartScriptAtHL_B04
    ret

.read_temp1:
    ld a, $0a
    ld [rRAMG], a
    ldh a, [hTemp1]
    ld hl, wPartyList
    add_a_to_hl
    ld a, [hl]
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    xor a
    ld [rRAMG], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf1 + $7
    ld bc, $000b
    call CopyBytes
    ldh a, [hTemp2]
    ld de, wTextBuf2 + $2
    call ReadBank08Table4558WordForA
    ld de, $006d
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_5C40
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_5C4E
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $084a ; '*: I'm astonished. Mermaids exist.'
    call StartMessageCommand09HL_B04
    ret

; starts Script_5B94: '*: Welcome to our inn!'
YoldTalkEvents_StartScriptAtHL_B04_Case14::
    ld hl, Script_5B94
    call StartScriptAtHL_B04
    ld a, $10
    ld [wDataBank], a
    ret

; starts Script_5B9B (StartScriptAtHL); its first message begins 'Have you heard the legend about'
; (E-0271; was DispatchTalkEvent_Case03_Sub01_Case15)
; starts Script_5B9B: '*: Have you heard the legend'
TalkScript5B9B_HaveYouHeardTheLegendAbout::
    ld hl, Script_5B9B
    call StartScriptAtHL_B04
    ret

; starts message $081B through StartMessageCommand09HL (script command $09); that string begins 'Ahh
; This is heavenly! It makes me' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case16)
TalkMsg081B_AhhThisIsHeavenlyItMakes::
    ld hl, $081b ; '*: Ahh This is heavenly! It'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005F then jr c,
; TalkMsg081C_ICameFromFarAwayTo.call_start_message_command09_hl_b04); starts message $081C through
; StartMessageCommand09HL (script command $09); that string begins 'I came from far away to see'
; (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case17)
TalkMsg081C_ICameFromFarAwayTo::
    ld de, $005f
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $081c ; '*: I came from far away'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0879 ; '*: I've seen mermaids too. I'
    call StartMessageCommand09HL_B04
    ret

; starts message $088B through StartMessageCommand09HL (script command $09); that string begins '0
; read the sign. Welcome to the' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case18)
TalkMsg088B_HeroReadTheSignWelcomeTo::
    ld hl, $088b ; '0 read the sign. 'Welcome to'
    call StartMessageCommand09HL_B04
    ret

; starts message $0889 through StartMessageCommand09HL (script command $09); that string begins '0
; peered into the oven. It smelled' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case19)
TalkMsg0889_HeroPeeredIntoTheOvenIt_045B54::
    ld hl, $0889 ; '0 peered into the oven. It'
    call StartMessageCommand09HL_B04
    ret

; starts message $081D through StartMessageCommand09HL (script command $09); that string begins
; 'This is Port Ritz, where ships gather' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case1A)
TalkMsg081D_ThisIsPortRitzWhereShips::
    ld hl, $081d ; '*: This is Port Ritz, where'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 007A then jr c,
; TalkMsg081E_ThePiratesWereSwallowedBy.call_start_message_command09_hl_b04); starts message $081E
; through StartMessageCommand09HL (script command $09); that string begins 'The pirates were
; swallowed by the sea' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case1B)
TalkMsg081E_ThePiratesWereSwallowedBy::
    ld de, $007a
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $081e ; '*: The pirates were swallowed by'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $087a ; '*: The pirates hid their loot'
    call StartMessageCommand09HL_B04
    ret

; starts message $081F through StartMessageCommand09HL (script command $09); that string begins
; 'There's this old sailor man in the' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case1C)
TalkMsg081F_TheresThisOldSailorManIn::
    ld hl, $081f ; '*: There's this old sailor man'
    call StartMessageCommand09HL_B04
    ret

; sets wDataBank = $1F, then starts Script_5BA8 (StartScriptAtHL); its first message begins 'How may
; our church serve you?' (E-0271; was DispatchTalkEvent_Case03_Sub01_Case1D)
; starts Script_5BA8: '*: How may our church serve'
TalkScript5BA8_HowMayOurChurchServeYou::
    ld a, $1f
    ld [wDataBank], a
    ld hl, Script_5BA8
    call StartScriptAtHL_B04
    ret

; starts message $0821 through StartMessageCommand09HL (script command $09); that string begins 'All
; sorts of people come here from' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case1E)
TalkMsg0821_AllSortsOfPeopleComeHere::
    ld hl, $0821 ; '*: All sorts of people come'
    call StartMessageCommand09HL_B04
    ret

; starts message $0822 through StartMessageCommand09HL (script command $09); that string begins 'I
; went to Polona a while back' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case1F)
TalkMsg0822_IWentToPolonaAWhile::
    ld hl, $0822 ; '*: I went to Polona a'
    call StartMessageCommand09HL_B04
    ret

YoldTalkEvents_StartScriptAtHL_B04_Case20::
    ld a, $06
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_5BAF
    call StartScriptAtHL_B04
    ret

; tests story flags (flag 005F then jr c,
; TalkMsg0824_ThereIsALighthouseToThe.call_start_message_command09_hl_b04); starts message $0824
; through StartMessageCommand09HL (script command $09); that string begins 'There is a lighthouse to
; the east,' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case21)
TalkMsg0824_ThereIsALighthouseToThe::
    ld de, $005f
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0824 ; '*: There is a lighthouse to'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0d13 ; '*: The lighthouse is out east.'
    call StartMessageCommand09HL_B04
    ret

; starts message $0825 through StartMessageCommand09HL (script command $09); that string begins 'My
; ship sank in the eastern sea.' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case22)
TalkMsg0825_MyShipSankInTheEastern::
    ld hl, $0825 ; '*: My ship sank in the'
    call StartMessageCommand09HL_B04
    ret

; starts message $0826 through StartMessageCommand09HL (script command $09); that string begins 'The
; old man in the tavern's neat!' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case23)
TalkMsg0826_TheOldManInTheTaverns::
    ld hl, $0826 ; '*: The old man in the'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005F then jr c,
; TalkMsg0827_ThisPortUsedToBeLively.call_start_message_command09_hl_b04); starts message $0827
; through StartMessageCommand09HL (script command $09); that string begins 'This port used to be
; lively in' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case24)
TalkMsg0827_ThisPortUsedToBeLively::
    ld de, $005f
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0827 ; '*: This port used to be'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $087b ; '*: The sea around here is'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005F then jr c,
; TalkMsg0829_TheLighthouseHadTheMoonRock.call_start_message_command09_hl_b04); starts message $0829
; through StartMessageCommand09HL (script command $09); that string begins 'The lighthouse had the
; MoonRock installed at' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case25)
TalkMsg0829_TheLighthouseHadTheMoonRock::
    ld de, $005f
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0829 ; '*: The lighthouse had the MoonRock'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $087c ; '*: The MoonRock glows at night'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 007A then jr c,
; TalkMsg082A_TheSeasLevelHasGoneDown.call_start_message_command09_hl_b04); starts message $082A
; through StartMessageCommand09HL (script command $09); that string begins 'The sea's level has gone
; down. Many' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case26)
TalkMsg082A_TheSeasLevelHasGoneDown::
    ld de, $007a
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $082a ; '*: The sea's level has gone'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $087d ; '*: The sea's level has risen.'
    call StartMessageCommand09HL_B04
    ret

; starts message $082B through StartMessageCommand09HL (script command $09); that string begins
; 'Listen, did you know? Mermaids appear to' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case27)
TalkMsg082B_ListenDidYouKnowMermaids::
    ld hl, $082b ; '*: Listen, did you know? Mermaids'
    call StartMessageCommand09HL_B04
    ret

; starts message $088D through StartMessageCommand09HL (script command $09); that string begins '0
; peered into the oven. Two shiny' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case28)
; starts Script_5BB6: '0 tried to check the chest.'
TalkMsg088D_HeroPeeredIntoTheOvenTwo::
    ld hl, $088d ; '0 peered into the oven. Two'
    call StartMessageCommand09HL_B04
    ret

; starts Script_5BB6 (StartScriptAtHL); its first message begins '0 tried to check the chest.'
; (E-0271; was DispatchTalkEvent_Case03_Sub01_Case29)
; starts Script_5BB6: '0 tried to check the chest.'
TalkScript5BB6_HeroTriedToCheckTheChest::
    ld hl, Script_5BB6
    call StartScriptAtHL_B04
    ret

; starts message $082E through StartMessageCommand09HL (script command $09); that string begins '0
; peered into the barrel. It was' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case2A)
TalkMsg082E_HeroPeeredIntoTheBarrelIt::
    ld hl, $082e ; '0 peered into the barrel. It'
    call StartMessageCommand09HL_B04
    ret

; a one-time barrel: script command $0A with wScriptParam0 = 2 (kind) and wScriptParam1 = $2C, story
; flag $0063 in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the flag (message
; $A6 of group 0; $A7 when the flag is already set, $A8 when there is no room) (E-0269; was
; DispatchTalkEvent_Case03_Sub01_Case2B)
BarrelItem_TinyMedal_Flag0063::
    ld a, $02
    ld [wScriptParam0], a
    ld a, $2c
    ld [wScriptParam1], a
    ld de, $0063
    call StartTreasureFlagDE_B04
    ret

; starts Script_5BBD: '*: Welcome to our inn!'
YoldTalkEvents_StartScriptAtHL_B04_Case2C::
    ld hl, Script_5BBD
    call StartScriptAtHL_B04
    ld a, $10
    ld [wDataBank], a
    ret

; tests story flags (flag 007A then jr c,
; TalkMsg082F_ThisAreaWasALotMore.call_start_message_command09_hl_b04); starts message $082F through
; StartMessageCommand09HL (script command $09); that string begins 'This area was a lot more lively'
; (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case2D)
TalkMsg082F_ThisAreaWasALotMore::
    ld de, $007a
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $082f ; '*: This area was a lot'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $087e ; '*: For some reason, the shoals'
    call StartMessageCommand09HL_B04
    ret

; starts message $0830 through StartMessageCommand09HL (script command $09); that string begins
; 'When you're out at sea, you get' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case2E)
; starts Script_5BC4
TalkMsg0830_WhenYoureOutAtSeaYou::
    ld hl, $0830 ; '*: When you're out at sea,'
    call StartMessageCommand09HL_B04
    ret

; starts Script_5BC4 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case03_Sub01_Case2F)
; starts Script_5BC4
TalkScript5BC4::
    ld hl, Script_5BC4
    call StartScriptAtHL_B04
    ret

; tests story flags (flag 005F then jr c,
; TalkMsg0834_WhenThatOldManGetsGrogged.call_start_message_command09_hl_b042; flag 006D then jr c,
; TalkMsg0834_WhenThatOldManGetsGrogged.call_start_message_command09_hl_b04); starts message $0834
; through StartMessageCommand09HL (script command $09); that string begins 'When that old man gets
; grogged You' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case30)
TalkMsg0834_WhenThatOldManGetsGrogged::
    ld de, $005f
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $006d
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0834 ; '*: When that old man gets'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0842 ; '*: I'm tired of the geezer's'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $0d14 ; '*: Another master was here with'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005F then jr c,
; TalkMsg0835_TheOldFellowThereTheInstant.call_start_message_command09_hl_b042; flag 007A then jr c,
; TalkMsg0835_TheOldFellowThereTheInstant.call_start_message_command09_hl_b04); starts message $0835
; through StartMessageCommand09HL (script command $09); that string begins 'The old fellow there,
; the instant he' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case31)
TalkMsg0835_TheOldFellowThereTheInstant::
    ld de, $005f
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $007a
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0835 ; '*: The old fellow there, the'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0dc3 ; '*: The shoals that ringed the'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $087f ; '*: Did you hear? Pirates hid'
    call StartMessageCommand09HL_B04
    ret

; starts message $0836 through StartMessageCommand09HL (script command $09); that string begins 'The
; volcanic island off the coast is' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case32)
TalkMsg0836_TheVolcanicIslandOffTheCoast::
    ld hl, $0836 ; '*: The volcanic island off the'
    call StartMessageCommand09HL_B04
    ret

YoldTalkEvents_ShowHnnnrHicGnnZzz::
    ld de, $005f
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld de, $007a
    call TestFlagBit
    jr c, .call_party_has_species_lo3_c_to5_b_with_hi
    ld de, $006d
    call TestFlagBit
    jr c, .call_start_script_at_hl_b042
    call PartyHasSpeciesLo3CTo5BWithHiSet
    jr c, .call_start_script_at_hl_b04
    ld a, $01
    ld [wObject3 + OBJ_STATE], a
    ld hl, $0837 ; '*: Hnnnr Hic Gnn Zzz Gfffff'
    call StartMessageCommand09HL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_5BFE
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b042:
    ld hl, Script_5C19
    call StartScriptAtHL_B04
    ret

.call_party_has_species_lo3_c_to5_b_with_hi:
    call PartyHasSpeciesLo3CTo5BWithHiSet
    jr c, .call_start_script_at_hl_b043
    ld a, $01
    ld [wObject3 + OBJ_STATE], a
    ld hl, $0837 ; '*: Hnnnr Hic Gnn Zzz Gfffff'
    call StartMessageCommand09HL_B04
    ret

.call_start_script_at_hl_b043:
    ld hl, Script_5C26
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0880 ; '*: What? You again? Back to'
    call StartMessageCommand09HL_B04
    ret

; carry when a party record has a species word with a non-zero high byte and low byte $3C-$5B
; (E-0124)
PartyHasSpeciesLo3CTo5BWithHiSet::
    ld a, $0a
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList

.loop:
    ld a, [hli]
    ld c, MON_SPECIES
    call LoadSRAMRecordWord
    ldh a, [hTemp1]
    or a
    jr z, .next
    ldh a, [hTemp0]
    cp $3c
    jr c, .next
    cp $5c
    jr c, .skip

.next:
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG], a
    sub a
    ret

.skip:
    xor a
    ld [rRAMG], a
    scf
    ret

YoldTalkEvents_TestFlagBit_Case34::
    ld de, $0066
    call TestFlagBit
    jr c, .call_start_script_at_hl_b042
    ld de, $0065
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_5BE8
    call StartScriptAtHL_B04
    ld de, $0065
    call SetFlagBit
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_5BF2
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b042:
    ld hl, Script_5BFC
    call StartScriptAtHL_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $1B, story flag $0067 in DE: when the flag is clear it gives item $1B (Rib) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; DispatchTalkEvent_Case03_Sub01_Case35)
ChestItem_Rib::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $1b
    ld [wScriptParam1], a
    ld de, $0067
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $02, story flag $0068 in DE: when the flag is clear it gives item $02 (LoveWater) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was DispatchTalkEvent_Case03_Sub01_Case36)
ChestItem_LoveWater::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $02
    ld [wScriptParam1], a
    ld de, $0068
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $02, story flag $0069 in DE: when the flag is clear it gives item $02 (LoveWater) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was DispatchTalkEvent_Case03_Sub01_Case37)
ChestItem_LoveWater_Flag0069::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $02
    ld [wScriptParam1], a
    ld de, $0069
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $2A, story flag $006A in DE: when the flag is clear it gives item $2A (ExitBell) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; DispatchTalkEvent_Case03_Sub01_Case38)
ChestItem_ExitBell::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2a
    ld [wScriptParam1], a
    ld de, $006a
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $46, story flag $006B in DE: when the flag is clear it gives item $46 (MermScale) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was DispatchTalkEvent_Case03_Sub01_Case39)
ChestItem_MermScale::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $46
    ld [wScriptParam1], a
    ld de, $006b
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $28, story flag $006C in DE: when the flag is clear it gives item $28 (Warp) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; DispatchTalkEvent_Case03_Sub01_Case3A)
ChestItem_Warp::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $28
    ld [wScriptParam1], a
    ld de, $006c
    call StartTreasureFlagDE_B04
    ret

; starts message $0843 through StartMessageCommand09HL (script command $09); that string begins 'I
; saw a child cross the sea' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case3B)
TalkMsg0843_ISawAChildCrossThe::
    ld hl, $0843 ; '*: I saw a child cross'
    call StartMessageCommand09HL_B04
    ret

; starts message $0844 through StartMessageCommand09HL (script command $09); that string begins
; 'Watch me dance, and you'll want to' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case3C)
TalkMsg0844_WatchMeDanceAndYoullWant::
    ld hl, $0844 ; '*: Watch me dance, and you'll'
    call StartMessageCommand09HL_B04
    ret

; starts Script_5C69: '*: Do you want to go'
YoldTalkEvents_TestFlagBit_Case3D::
    ld de, $006f
    call TestFlagBit
    ret nc
    ld hl, Script_5C69
    call StartScriptAtHL_B04
    ret

YoldTalkEvents_ShowThisIsTheMermaid::
    ld de, $00f1
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, $084e ; '*: This is the mermaid kingdom.'
    call StartMessageCommand09HL_B04
    ld de, $00f1
    call SetFlagBit
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_5D36
    call StartScriptAtHL_B04
    ret

; tests story flags (flag 0076 then jr c,
; TalkMsg084F_IKnowNotAllHumansAre.call_start_message_command09_hl_b04); starts message $084F
; through StartMessageCommand09HL (script command $09); that string begins 'I know not all humans
; are bad' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case3F)
TalkMsg084F_IKnowNotAllHumansAre::
    ld de, $0076
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $084f ; '*: I know not all humans'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0881 ; '*: Our words of thanks could'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0076 then jr c,
; TalkMsg0850_ThePiratesCaughtUsInNets.call_start_message_command09_hl_b04); starts message $0850
; through StartMessageCommand09HL (script command $09); that string begins 'The pirates caught us in
; nets and' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case40)
TalkMsg0850_ThePiratesCaughtUsInNets::
    ld de, $0076
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0850 ; '*: The pirates caught us in'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0882 ; '*: Mermaids and humans can live'
    call StartMessageCommand09HL_B04
    ret

; starts message $0851 through StartMessageCommand09HL (script command $09); that string begins 'The
; HarMirror was exquisite. It was so' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case41)
TalkMsg0851_TheHarMirrorWasExquisite::
    ld hl, $0851 ; '*: The HarMirror was exquisite. It'
    call StartMessageCommand09HL_B04
    ret

; starts message $0852 through StartMessageCommand09HL (script command $09); that string begins 'The
; MoonRock fell from the sky. It' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case42)
TalkMsg0852_TheMoonRockFellFromTheSky::
    ld hl, $0852 ; '*: The MoonRock fell from the'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0076 then jr c,
; TalkMsg0853_ThePiratesSankWithTheirShip.call_start_message_command09_hl_b04); starts message $0853
; through StartMessageCommand09HL (script command $09); that string begins 'The pirates sank with
; their ship. However,' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case43)
TalkMsg0853_ThePiratesSankWithTheirShip::
    ld de, $0076
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0853 ; '*: The pirates sank with their'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0883 ; '*: Thanks to you, the spectral'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0076 then jr c,
; TalkMsg0854_WeMermaidsArePeacefulBeings.call_start_message_command09_hl_b04); starts message $0854
; through StartMessageCommand09HL (script command $09); that string begins 'We mermaids are peaceful
; beings. We shy' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case44)
TalkMsg0854_WeMermaidsArePeacefulBeings::
    ld de, $0076
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0854 ; '*: We mermaids are peaceful beings.'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0884 ; '*: That wandering ghost ship's gone!'
    call StartMessageCommand09HL_B04
    ret

YoldTalkEvents_TestFlagBit_Case45::
    ld de, $005e
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $0076
    call TestFlagBit
    jr c, .call_inventory_has_free_slot_check
    ld de, $0070
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, Script_5C77
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0858 ; '*: The MoonRock is on the'
    call StartMessageCommand09HL_B04
    ret

.call_inventory_has_free_slot_check:
    call InventoryHasFreeSlotCheck
    jr c, .read_game_flags836
    ld hl, $0dc7 ; '*: Welcome, my young hero! No'
    call StartMessageCommand09HL_B04
    ret

.read_game_flags836:
    ld [hl], $5f
    ld a, [wGameFlags836]
    set 6, a
    ld [wGameFlags836], a
    ld hl, Script_5C7E
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $0885 ; '*: Welcome, young hero! No words'
    call StartMessageCommand09HL_B04
    ret

; starts Script_5C88 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case03_Sub01_Case46)
; starts Script_5C88
TalkScript5C88::
    ld hl, Script_5C88
    call StartScriptAtHL_B04
    ret

; starts Script_5C8A (StartScriptAtHL); its first message begins 'How could we die before enjoying'
; (E-0271; was DispatchTalkEvent_Case03_Sub01_Case47)
; starts Script_5C8A: '*: How could we die before'
TalkScript5C8A_HowCouldWeDieBeforeEnjoying::
    ld hl, Script_5C8A
    call StartScriptAtHL_B04
    ret

; starts Script_5C94 (StartScriptAtHL); its first message begins 'The treasures are ours No one'
; (E-0271; was DispatchTalkEvent_Case03_Sub01_Case48)
; starts Script_5C94: '*: The treasures are ours No'
TalkScript5C94_TheTreasuresAreOursNoOne::
    ld hl, Script_5C94
    call StartScriptAtHL_B04
    ret

; starts Script_5C9E (StartScriptAtHL); its first message begins 'It nags and nags that we' (E-0271;
; was DispatchTalkEvent_Case03_Sub01_Case49)
; starts Script_5C9E: '*: It nags and nags that'
TalkScript5C9E_ItNagsAndNagsThatWe::
    ld hl, Script_5C9E
    call StartScriptAtHL_B04
    ret

; starts Script_5CA8: '*: Who disturbs us in our'
YoldTalkEvents_TestFlagBit_Case4A::
    ld de, $0074
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_5CA8
    call StartScriptAtHL_B04
    ld de, $0074
    call SetFlagBit
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_5CB5
    call StartScriptAtHL_B04
    ret

YoldTalkEvents_ShowHeroCheckedTheTreasure::
    call InventoryHasFreeSlotCheck
    jr c, .read_game_flags836
    ld hl, $0888 ; '0 checked the treasure chest. There'
    call StartMessageCommand09HL_B04
    ret

.read_game_flags836:
    ld [hl], $31
    ld a, [wGameFlags836]
    set 6, a
    ld [wGameFlags836], a
    ld hl, Script_5CC2
    call StartScriptAtHL_B04
    ret

; starts Script_5CCA: '0 checked the crate. There was'
YoldTalkEvents_StartScriptAtHL_B04_Case4C::
    ld hl, Script_5CCA
    call StartScriptAtHL_B04
    ld de, $0077
    call SetFlagBit
    ret

YoldTalkEvents_SetSpriteSlotsPlus7::
    xor a
    ld [wSpriteSlots + $7], a
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $2E, story flag $0079 in DE: when the flag is clear it gives item $2E (LogTwig) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; DispatchTalkEvent_Case03_Sub01_Case4E)
ChestItem_LogTwig::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2e
    ld [wScriptParam1], a
    ld de, $0079
    call StartTreasureFlagDE_B04
    ret

YoldTalkEvents_ShowHeroCheckedThePedestal::
    ld de, $007a
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld a, $31
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    ret z
    ld hl, $0865 ; '0 checked the pedestal. It has'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0867 ; '0 checked the pedestal. The MoonRock'
    call StartMessageCommand09HL_B04
    ret

YoldTalkEvents_SetFlagBit::
    ldh a, [hPlayerY]
    cp $30
    ret nz
    ld de, $007b
    call SetFlagBit
    ld hl, Script_5CD1
    call StartScriptAtHL_B04
    ldh a, [hPlayerX]
    cp $50
    ret nz
    ld a, $40
    ld [wSpriteSlots + $b], a
    ld [wObject1 + OBJ_X], a
    ld [wObject2 + OBJ_X], a
    ret

; starts Script_5CDD (StartScriptAtHL); its first message begins 'Kameha Urk! How you catch up?'
; (E-0271; was DispatchTalkEvent_Case03_Sub01_Case51)
; starts Script_5CDD: 'Kameha: Urk! How you catch up?'
TalkScript5CDD_KamehaUrkHowYouCatchUp::
    ld hl, Script_5CDD
    call StartScriptAtHL_B04
    ret

; starts Script_5D1C (StartScriptAtHL); its first message begins 'Kameha Arrrrh, clear the way! I'm'
; (E-0271; was DispatchTalkEvent_Case03_Sub01_Case52)
; starts Script_5D1C: 'Kameha: Arrrrh, clear the way! I'm'
TalkScript5D1C_KamehaArrrrhClearTheWayIm::
    ld hl, Script_5D1C
    call StartScriptAtHL_B04
    ret

; starts Script_5D2F (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case03_Sub01_Case53)
; starts Script_5D2F
TalkScript5D2F::
    ld hl, Script_5D2F
    call StartScriptAtHL_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $20, story flag $00E0 in DE: when the flag is clear it gives item $20 (Repellent) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was DispatchTalkEvent_Case03_Sub01_Case54)
ChestItem_Repellent::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $20
    ld [wScriptParam1], a
    ld de, $00e0
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $28, story flag $00E1 in DE: when the flag is clear it gives item $28 (Warp) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; DispatchTalkEvent_Case03_Sub01_Case55)
ChestItem_Warp_Flag00E1::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $28
    ld [wScriptParam1], a
    ld de, $00e1
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $0C, story flag $00E2 in DE: when the flag is clear it gives item $0C (WorldLeaf) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was DispatchTalkEvent_Case03_Sub01_Case56)
ChestItem_WorldLeaf::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $0c
    ld [wScriptParam1], a
    ld de, $00e2
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $11, story flag $00E3 in DE: when the flag is clear it gives item $11 (LifeAcorn) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was DispatchTalkEvent_Case03_Sub01_Case57)
ChestItem_LifeAcorn::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $11
    ld [wScriptParam1], a
    ld de, $00e3
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $0E, story flag $00E4 in DE: when the flag is clear it gives item $0E (DEFseed) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; DispatchTalkEvent_Case03_Sub01_Case58)
ChestItem_DEFseed::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $0e
    ld [wScriptParam1], a
    ld de, $00e4
    call StartTreasureFlagDE_B04
    ret

; starts message $088C through StartMessageCommand09HL (script command $09); that string begins '0
; peered into the vase. There were' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case59)
TalkMsg088C_HeroPeeredIntoTheVaseThere::
    ld hl, $088c ; '0 peered into the vase. There'
    call StartMessageCommand09HL_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $03, story flag $00E5 in DE: when the flag is clear it gives item $03 (WorldDew) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; DispatchTalkEvent_Case03_Sub01_Case5A)
ChestItem_WorldDew::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $03
    ld [wScriptParam1], a
    ld de, $00e5
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $5C, story flag $00E6 in DE: when the flag is clear it gives item $5C (War) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; DispatchTalkEvent_Case03_Sub01_Case5B)
ChestItem_War::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5c
    ld [wScriptParam1], a
    ld de, $00e6
    call StartTreasureFlagDE_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $06, story
; flag $00E7 in DE: when the flag is clear it gives item $06 (Antidote) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; DispatchTalkEvent_Case03_Sub01_Case5C)
VaseItem_Antidote::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $06
    ld [wScriptParam1], a
    ld de, $00e7
    call StartTreasureFlagDE_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $02, story
; flag $00E8 in DE: when the flag is clear it gives item $02 (LoveWater) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; DispatchTalkEvent_Case03_Sub01_Case5D)
VaseItem_LoveWater::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $02
    ld [wScriptParam1], a
    ld de, $00e8
    call StartTreasureFlagDE_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $28, story
; flag $00F2 in DE: when the flag is clear it gives item $28 (Warp) and sets the flag (message $A3
; of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; DispatchTalkEvent_Case03_Sub01_Case5E)
VaseItem_Warp::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $28
    ld [wScriptParam1], a
    ld de, $00f2
    call StartTreasureFlagDE_B04
    ret

; starts message $0861 through StartMessageCommand09HL (script command $09); that string begins '0
; peered into the barrel. A mummified' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case5F)
TalkMsg0861_HeroPeeredIntoTheBarrelA::
    ld hl, $0861 ; '0 peered into the barrel. A'
    call StartMessageCommand09HL_B04
    ret

; a one-time barrel: script command $0A with wScriptParam0 = 2 (kind) and wScriptParam1 = $1D, story
; flag $00E9 in DE: when the flag is clear it gives item $1D (BadMeat) and sets the flag (message
; $A6 of group 0; $A7 when the flag is already set, $A8 when there is no room) (E-0269; was
; DispatchTalkEvent_Case03_Sub01_Case60)
BarrelItem_BadMeat::
    ld a, $02
    ld [wScriptParam0], a
    ld a, $1d
    ld [wScriptParam1], a
    ld de, $00e9
    call StartTreasureFlagDE_B04
    ret

; a one-time barrel: script command $0A with wScriptParam0 = 2 (kind) and wScriptParam1 = $1A, story
; flag $00EA in DE: when the flag is clear it gives item $1A (PorkChop) and sets the flag (message
; $A6 of group 0; $A7 when the flag is already set, $A8 when there is no room) (E-0269; was
; DispatchTalkEvent_Case03_Sub01_Case61)
BarrelItem_PorkChop::
    ld a, $02
    ld [wScriptParam0], a
    ld a, $1a
    ld [wScriptParam1], a
    ld de, $00ea
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $51, story flag $00EB in DE: when the flag is clear it gives item $51 (OrcaCape) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; DispatchTalkEvent_Case03_Sub01_Case62)
ChestItem_OrcaCape::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $51
    ld [wScriptParam1], a
    ld de, $00eb
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $20, story flag $00EC in DE: when the flag is clear it gives item $20 (Repellent) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was DispatchTalkEvent_Case03_Sub01_Case63)
ChestItem_Repellent_Flag00EC::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $20
    ld [wScriptParam1], a
    ld de, $00ec
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $0C, story flag $00ED in DE: when the flag is clear it gives item $0C (WorldLeaf) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was DispatchTalkEvent_Case03_Sub01_Case64)
ChestItem_WorldLeaf_Flag00ED::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $0c
    ld [wScriptParam1], a
    ld de, $00ed
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $0F, story flag $00EE in DE: when the flag is clear it gives item $0F (AGLseed) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; DispatchTalkEvent_Case03_Sub01_Case65)
ChestItem_AGLseed::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $0f
    ld [wScriptParam1], a
    ld de, $00ee
    call StartTreasureFlagDE_B04
    ret

; a one-time barrel: script command $0A with wScriptParam0 = 2 (kind) and wScriptParam1 = $04, story
; flag $00EF in DE: when the flag is clear it gives item $04 (Potion) and sets the flag (message $A6
; of group 0; $A7 when the flag is already set, $A8 when there is no room) (E-0269; was
; DispatchTalkEvent_Case03_Sub01_Case66)
BarrelItem_Potion::
    ld a, $02
    ld [wScriptParam0], a
    ld a, $04
    ld [wScriptParam1], a
    ld de, $00ef
    call StartTreasureFlagDE_B04
    ret

; a one-time barrel: script command $0A with wScriptParam0 = 2 (kind) and wScriptParam1 = $10, story
; flag $00F0 in DE: when the flag is clear it gives item $10 (INTseed) and sets the flag (message
; $A6 of group 0; $A7 when the flag is already set, $A8 when there is no room) (E-0269; was
; DispatchTalkEvent_Case03_Sub01_Case67)
BarrelItem_INTseed::
    ld a, $02
    ld [wScriptParam0], a
    ld a, $10
    ld [wScriptParam1], a
    ld de, $00f0
    call StartTreasureFlagDE_B04
    ret

; starts message $0862 through StartMessageCommand09HL (script command $09); that string begins '0
; peered into the barrel. There were' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case68)
TalkMsg0862_HeroPeeredIntoTheBarrelThere::
    ld hl, $0862 ; '0 peered into the barrel. There'
    call StartMessageCommand09HL_B04
    ret

; starts message $0864 through StartMessageCommand09HL (script command $09); that string begins '0
; checked the ledger. Voyage Log Sunrise' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case03_Sub01_Case69)
; starts Script_5CCF
TalkMsg0864_HeroCheckedTheLedgerVoyage::
    ld hl, $0864 ; '0 checked the ledger. 'Voyage Log'
    call StartMessageCommand09HL_B04
    ret

; starts Script_5CCF
YoldTalkEvents_StartScriptAtHL_B04_Case6A::
    ld hl, Script_5CCF
    call StartScriptAtHL_B04
    ld a, $31
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    farcall RemoveInventorySlotShiftDown
    ld de, $007a
    call SetFlagBit
    ret

; starts message $00FF through StartMessageCommand09HL (script command $09); that string begins
; 'Composing' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case03_Sub01_Case6B)
; starts Script_5D44: 'Thick, suction- cupped tentacles snaked out'
TalkMsg00FF_Composing::
    ld hl, $00ff ; 'Composing'
    call StartMessageCommand09HL_B04
    ret

; starts Script_5D44 (StartScriptAtHL); its first message begins 'Thick, suction- cupped tentacles
; snaked out' (E-0271; was DispatchTalkEvent_Case03_Sub01_Case6C)
; starts Script_5D44: 'Thick, suction- cupped tentacles snaked out'
TalkScript5D44_ThickSuctionCuppedTentacles::
    ld hl, Script_5D44
    call StartScriptAtHL_B04
    ret

YoldTalkEvents_TestFlagBit_Case6D::
    ld a, $1f
    ld [wDataBank], a
    ld de, $0202
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_5D4D
    call StartScriptAtHL_B04
    ld de, $0202
    call SetFlagBit
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_5D54
    call StartScriptAtHL_B04
    ret

; talk category 2: jumps by wTalkEventGroup to the talk handlers of the Kalka oasis world (messages
; $0130-$01CF)
KalkaTalkEvents::
    ld a, [wTalkEventGroup]
    jumptable
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
    dw KalkaTalkEvents_WriteSpriteSlotsAndDataBank
    dw TalkMsg0139_TheKingCalledACircusTroupe
    dw TalkMsg013A_ThisIsAsiyaTheDesertFlower
    dw TalkMsg013B_OurKingCameIntoAnEnormous
    dw TalkMsg013C_ISawALakeLikeA
    dw TalkMsg013D_StrongMonstersAreInTheWell
    dw TalkMsg013E_OurKingHasBeenAFan
    dw TalkMsg013F_TheCircusMasterWasTrying
    dw KalkaTalkEvents_TestFlagBit
    dw TalkMsg0140_NoOneEntersTheCastleWithout
    dw TalkMsg0141_IfYouWantToGetIn
    dw TalkMsg0142_DidYouWantSomethingHoney
    dw TalkMsg0143_WhenWeGetAHotSpell
    dw KalkaTalkEvents_TestFlagBit_Case17
    dw KalkaTalkEvents_TestFlagBit_Case18
    dw TalkMsg014F_HeroPeeredIntoTheVaseIt
    dw VaseItem_Antidote_Flag0047
    dw TalkMsg0137_HeroCheckedTheOvenASharp_046456
    dw IfFlag056Msg018F_WeDidntHelpTheThievesOne
    dw TalkMsg01BE_HeroCheckedTheDresserThere
    dw TalkMsg0037_HeroTriedToOpenTheChest_046472
    dw KalkaTalkEvents_StartScriptAtHL_B04
    dw TalkMsg0150_IHeardThatTheThievesDisappear
    dw TalkMsg0154_SeveralOfOurMembersCameBack
    dw TalkMsg0155_WhenTheThievesRaidedUsWe
    dw TalkMsg0156_IWonderIfTheOthersAre
    dw TalkMsg0157_HehDidYouSeeTheLooks
    dw TalkMsg0158_ThisIsTheKingsTreasuryNo
    dw TalkMsg0159_WhatSeeHisMajestysTreasure
    dw KalkaTalkEvents_TestFlagBit_Case27
    dw TalkMsg015A_HisMajestyIsHonestAndMost
    dw KalkaTalkEvents_StartScriptAtHL_B04_Case29
    dw TalkMsg015F_HeroCheckedTheDresserThere
    dw KalkaTalkEvents_TestFlagBit_Case2B
    dw TalkMsg0166_ThatFoolIsATerribleSwindler
    dw TalkMsg0167_HumphAMirageLakeHeSays
    dw KalkaTalkEvents_TestFlagBit_Case2E
    dw VaseItem_Herb_Flag004B
    dw VaseItem_PorkChop
    dw VaseItem_TinyMedal
    dw VaseItem_Bookmark
    dw ChestItem_ExitBell_Flag004F
    dw ChestItem_Wind
    dw ChestItem_WarpWing
    dw ChestItem_AGL
    dw KalkaTalkEvents_TestFlagBit_Case37
    dw KalkaTalkEvents_TestFlagBit_Case38
    dw KalkaTalkEvents_StartScriptAtHL_B04_Case39
    dw TalkMsg0194_ThievesDroveUsFromOurHomes
    dw TalkMsg0195_TheLeaderOfTheThievesIs
    dw KalkaTalkEvents_RunFieldCommandTemp0
    dw TalkMsg01B5_KyoohSwimmingInADesertThis
    dw TalkMsg01BC_HeroCheckedTheTreasureChest
    dw TalkMsg01BD_HeroPeeredIntoTheVaseIt
    dw TalkMsg01C0_HeroCheckedTheTreasureChest
    dw TalkMsg01BF_HeroPeeredIntoTheVaseThe
    dw VaseItem_BeefJerky
    dw KalkaTalkEvents_TestFlagBit_Case43
    dw KalkaTalkEvents_WaitStoryFlagsPlus61
    dw KalkaTalkEvents_TestFlagBit_Case45

; starts message $0130 through StartMessageCommand09HL (script command $09); that string begins
; 'This is Kalka, an oasis village.' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case02_Sub01_Case00)
TalkMsg0130_ThisIsKalkaAnOasisVillage::
    ld hl, $0130 ; '*: This is Kalka, an oasis'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c,
; TalkMsg0131_AThievingBandRunsAmokHere.call_start_message_command09_hl_b04); starts message $0131
; through StartMessageCommand09HL (script command $09); that string begins 'A thieving band runs
; amok here. It's' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case01)
TalkMsg0131_AThievingBandRunsAmokHere::
    ld de, $005a
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0131 ; '*: A thieving band runs amok'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $01a3 ; '*: The King caught the thieves!'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c,
; TalkMsg0132_PardonAPlugForANavel.call_start_message_command09_hl_b04); starts message $0132
; through StartMessageCommand09HL (script command $09); that string begins 'Pardon? A plug for a
; navel? Sorry,' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case02)
TalkMsg0132_PardonAPlugForANavel::
    ld de, $005a
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0132 ; '*: Pardon? A plug for a'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $01a4 ; '*: The last king was a'
    call StartMessageCommand09HL_B04
    ret

; starts message $0133 through StartMessageCommand09HL (script command $09); that string begins 'The
; oasis water travels through an underground' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case02_Sub01_Case03)
TalkMsg0133_TheOasisWaterTravelsThrough::
    ld hl, $0133 ; '*: The oasis' water travels through'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c,
; TalkMsg0134_TheLeaderOfTheThievesIs.call_start_message_command09_hl_b04); starts message $0134
; through StartMessageCommand09HL (script command $09); that string begins 'The leader of the
; thieves is a' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case04)
TalkMsg0134_TheLeaderOfTheThievesIs::
    ld de, $005a
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0134 ; '*: The leader of the thieves'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $01a5 ; '*: We recovered everything that was'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c,
; TalkMsg0135_TheLogsNavelWhatIsThat.call_start_script_at_hl_b04); starts message $0135 through
; StartMessageCommand09HL (script command $09); that string begins 'The Log's Navel? What is that?
; I' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case05)
TalkMsg0135_TheLogsNavelWhatIsThat::
    ld de, $005a
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, $0135 ; '*: The Log's Navel? What is'
    call StartMessageCommand09HL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_5B64
    call StartScriptAtHL_B04
    ret

; tests story flags (flag 005A then jr c,
; TalkMsg0136_TheLogsNavelLetMeThink.call_start_message_command09_hl_b04); starts message $0136
; through StartMessageCommand09HL (script command $09); that string begins 'The Log's Navel? Let me
; think Perhaps' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case06)
TalkMsg0136_TheLogsNavelLetMeThink::
    ld de, $005a
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0136 ; '*: The Log's Navel? Let me'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0d07 ; '*: The shortage of water has'
    call StartMessageCommand09HL_B04
    ret

; starts message $0137 through StartMessageCommand09HL (script command $09); that string begins '0
; checked the oven. A sharp, spicy' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case02_Sub01_Case07)
TalkMsg0137_HeroCheckedTheOvenASharp::
    ld hl, $0137 ; '0 checked the oven. A sharp,'
    call StartMessageCommand09HL_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $01, story
; flag $0046 in DE: when the flag is clear it gives item $01 (Herb) and sets the flag (message $A3
; of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; DispatchTalkEvent_Case02_Sub01_Case08)
VaseItem_Herb::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $0046
    call StartTreasureFlagDE_B04
    ret

; tests story flags (flag 005A then jr c,
; TalkMsg0138_TheUndergroundCanalIsAhead.call_start_message_command09_hl_b043; flag 0053 then jr c,
; TalkMsg0138_TheUndergroundCanalIsAhead.call_start_message_command09_hl_b042; flag 004A then jr c,
; TalkMsg0138_TheUndergroundCanalIsAhead.call_start_message_command09_hl_b04); starts message $0138
; through StartMessageCommand09HL (script command $09); that string begins 'The underground canal is
; ahead. The last' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case09)
TalkMsg0138_TheUndergroundCanalIsAhead::
    ld de, $005a
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, $0053
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $004a
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0138 ; '*: The underground canal is ahead.'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0173 ; '*: My, our King has no'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $017a ; '*: Oh? You say that a'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b043:
    ld hl, $0d08 ; '*: Oh, it's you lot. We'
    call StartMessageCommand09HL_B04
    ret

KalkaTalkEvents_WriteSpriteSlotsAndDataBank::
    ldh a, [hPlayerX]
    cp $30
    jr nz, .set_sprite_slots_to_01
    ld a, $02
    jp .set_sprite_slots

.set_sprite_slots_to_01:
    ld a, $01

.set_sprite_slots:
    ld [wSpriteSlots + $7], a
    ld hl, Script_59BA
    call StartScriptAtHL_B04
    ld a, $10
    ld [wDataBank], a
    ret

; tests story flags (flag 005A then jr c,
; TalkMsg0139_TheKingCalledACircusTroupe.call_start_message_command09_hl_b04); starts message $0139
; through StartMessageCommand09HL (script command $09); that string begins 'The King called a circus
; troupe to' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case0B)
TalkMsg0139_TheKingCalledACircusTroupe::
    ld de, $005a
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0139 ; '*: The King called a circus'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $01a6 ; '*: The circus has moved onto'
    call StartMessageCommand09HL_B04
    ret

; starts message $013A through StartMessageCommand09HL (script command $09); that string begins
; 'This is Asiya, the desert flower.' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case02_Sub01_Case0C)
TalkMsg013A_ThisIsAsiyaTheDesertFlower::
    ld hl, $013a ; '*: This is Asiya, the desert'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c,
; TalkMsg013B_OurKingCameIntoAnEnormous.call_start_message_command09_hl_b04); starts message $013B
; through StartMessageCommand09HL (script command $09); that string begins 'Our King came into an
; enormous inheritance.' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case0D)
TalkMsg013B_OurKingCameIntoAnEnormous::
    ld de, $005a
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $013b ; '*: Our King came into an'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0d0b ; '*: The King gave away his'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c,
; TalkMsg013C_ISawALakeLikeA.call_start_message_command09_hl_b04); starts message $013C through
; StartMessageCommand09HL (script command $09); that string begins 'I saw a lake like a mirage.'
; (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case0E)
TalkMsg013C_ISawALakeLikeA::
    ld de, $005a
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $013c ; '*: I saw a lake like'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0d0a ; '*: The band of thieves made'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c,
; TalkMsg013D_StrongMonstersAreInTheWell.call_start_message_command09_hl_b044; flag 0053 then jr c,
; TalkMsg013D_StrongMonstersAreInTheWell.call_start_message_command09_hl_b043; flag 0048 then jr c,
; TalkMsg013D_StrongMonstersAreInTheWell.call_start_message_command09_hl_b042; flag 0045 then jr c,
; TalkMsg013D_StrongMonstersAreInTheWell.call_start_message_command09_hl_b04); starts message $013D
; through StartMessageCommand09HL (script command $09); that string begins 'Strong monsters are in
; the well. You' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case0F)
TalkMsg013D_StrongMonstersAreInTheWell::
    ld de, $005a
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b044
    ld de, $0053
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, $0048
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $0045
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $013d ; '*: Strong monsters are in the'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0168 ; '*: Do I have any concerns?'
    call StartMessageCommand09HL_B04
    ld de, $0048
    call SetFlagBit
    ret

.call_start_message_command09_hl_b042:
    ld hl, $0168 ; '*: Do I have any concerns?'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b043:
    ld hl, $017b ; '*: The well has ample water'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b044:
    ld hl, $0d09 ; '*: The well filled up with'
    call StartMessageCommand09HL_B04
    ret

; starts message $013E through StartMessageCommand09HL (script command $09); that string begins 'Our
; King has been a fan of' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case10)
TalkMsg013E_OurKingHasBeenAFan::
    ld hl, $013e ; '*: Our King has been a'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c,
; TalkMsg013F_TheCircusMasterWasTrying.call_start_message_command09_hl_b04); starts message $013F
; through StartMessageCommand09HL (script command $09); that string begins 'The circus master was
; trying to recruit' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case11)
TalkMsg013F_TheCircusMasterWasTrying::
    ld de, $005a
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $013f ; '*: The circus master was trying'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $01a7 ; '*: His Majesty's popularity has been'
    call StartMessageCommand09HL_B04
    ret

KalkaTalkEvents_TestFlagBit::
    ld a, $03
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld de, $0040
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_59C1
    call StartScriptAtHL_B04
    ld de, $0040
    call SetFlagBit
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_59C8
    call StartScriptAtHL_B04
    ret

; tests story flags (flag 0043 then jr c,
; TalkMsg0140_NoOneEntersTheCastleWithout.call_start_message_command09_hl_b04); starts message $0140
; through StartMessageCommand09HL (script command $09); that string begins 'No one enters the castle
; without a' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case13)
TalkMsg0140_NoOneEntersTheCastleWithout::
    ld de, $0043
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0140 ; '*: No one enters the castle'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $016a ; '*: The King has given permission'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0053 then jr c,
; TalkMsg0141_IfYouWantToGetIn.call_start_message_command09_hl_b042; flag 0043 then jr c,
; TalkMsg0141_IfYouWantToGetIn.call_start_message_command09_hl_b04); starts message $0141 through
; StartMessageCommand09HL (script command $09); that string begins 'If you want to get in that'
; (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case14)
TalkMsg0141_IfYouWantToGetIn::
    ld de, $0053
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $0043
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0141 ; '*: If you want to get'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $016b ; '*: The King is so frivolous.'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $017c ; '*: We have heard from his'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0053 then jr c,
; TalkMsg0142_DidYouWantSomethingHoney.call_start_message_command09_hl_b04); starts message $0142
; through StartMessageCommand09HL (script command $09); that string begins 'Did you want something,
; honey? A plug' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case15)
TalkMsg0142_DidYouWantSomethingHoney::
    ld de, $0053
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0142 ; '*: Did you want something, honey?'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $017d ; '*: Hi! Did you hear the'
    call StartMessageCommand09HL_B04
    ret

; starts message $0143 through StartMessageCommand09HL (script command $09); that string begins
; 'When we get a hot spell, I' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case16)
TalkMsg0143_WhenWeGetAHotSpell::
    ld hl, $0143 ; '*: When we get a hot'
    call StartMessageCommand09HL_B04
    ret

KalkaTalkEvents_TestFlagBit_Case17::
    ld a, $1f
    ld [wDataBank], a
    ld de, $0041
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_59CF
    call StartScriptAtHL_B04
    ld de, $0041
    call SetFlagBit
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_59D6
    call StartScriptAtHL_B04
    ret

KalkaTalkEvents_TestFlagBit_Case18::
    ld de, $0042
    call TestFlagBit
    jr c, .check_party_count
    ld a, [wPartyCount]
    cp $03
    jr nz, .call_start_script_at_hl_b04
    farcall SetWStepArrivedIfPartyHasField55Bit7
    ld a, [wStepArrived]
    or a
    jr nz, .call_start_script_at_hl_b042
    ld hl, Script_59DD
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_59F7
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b042:
    ld hl, Script_5A07
    call StartScriptAtHL_B04
    ret

.check_party_count:
    ld a, [wPartyCount]
    cp $03
    jr nz, .call_start_message_command09_hl_b04
    farcall SetWStepArrivedIfPartyHasField55Bit7
    ld a, [wStepArrived]
    or a
    jr nz, .call_start_message_command09_hl_b04
    ld hl, Script_5A17
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $014e ; '*: Oh, you need a trio'
    call StartMessageCommand09HL_B04
    ret

; starts message $014F through StartMessageCommand09HL (script command $09); that string begins '0
; peered into the vase. It was' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case02_Sub01_Case19)
TalkMsg014F_HeroPeeredIntoTheVaseIt::
    ld hl, $014f ; '0 peered into the vase. It'
    call StartMessageCommand09HL_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $06, story
; flag $0047 in DE: when the flag is clear it gives item $06 (Antidote) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; DispatchTalkEvent_Case02_Sub01_Case1A)
VaseItem_Antidote_Flag0047::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $06
    ld [wScriptParam1], a
    ld de, $0047
    call StartTreasureFlagDE_B04
    ret

; starts message $0137 through StartMessageCommand09HL (script command $09); that string begins '0
; checked the oven. A sharp, spicy' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case02_Sub01_Case1B)
TalkMsg0137_HeroCheckedTheOvenASharp_046456::
    ld hl, $0137 ; '0 checked the oven. A sharp,'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0056 then ret nc); starts message $018F through StartMessageCommand09HL
; (script command $09); that string begins 'We didn't help the thieves! One of' (E-0268, the E-0082
; shape; was DispatchTalkEvent_Case02_Sub01_Case1C)
IfFlag056Msg018F_WeDidntHelpTheThievesOne::
    ld de, $0056
    call TestFlagBit
    ret nc
    ld hl, $018f ; '*: We didn't help the thieves!'
    call StartMessageCommand09HL_B04
    ret

; starts message $01BE through StartMessageCommand09HL (script command $09); that string begins '0
; checked the dresser. There was a' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case02_Sub01_Case1D)
TalkMsg01BE_HeroCheckedTheDresserThere::
    ld hl, $01be ; '0 checked the dresser. There was'
    call StartMessageCommand09HL_B04
    ret

; starts message $0037 through StartMessageCommand09HL (script command $09); that string begins '0
; tried to open the chest. But' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case02_Sub01_Case1E)
; starts Script_5A25: '*: Welcome to our inn!'
TalkMsg0037_HeroTriedToOpenTheChest_046472::
    ld hl, $0037 ; '0 tried to open the chest.'
    call StartMessageCommand09HL_B04
    ret

; starts Script_5A25: '*: Welcome to our inn!'
KalkaTalkEvents_StartScriptAtHL_B04::
    ld hl, Script_5A25
    call StartScriptAtHL_B04
    ld a, $10
    ld [wDataBank], a
    ret

; tests story flags (flag 005A then jr c,
; TalkMsg0150_IHeardThatTheThievesDisappear.call_start_message_command09_hl_b04); starts message
; $0150 through StartMessageCommand09HL (script command $09); that string begins 'I heard that the
; thieves disappear as' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case20)
TalkMsg0150_IHeardThatTheThievesDisappear::
    ld de, $005a
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0150 ; '*: I heard that the thieves'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $01a8 ; '*: Making a hideout in Mirage'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c,
; TalkMsg0154_SeveralOfOurMembersCameBack.call_start_message_command09_hl_b04); starts message $0154
; through StartMessageCommand09HL (script command $09); that string begins 'Several of our members
; came back. We' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case21)
TalkMsg0154_SeveralOfOurMembersCameBack::
    ld de, $005a
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0154 ; '*: Several of our members came'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $01a9 ; '*: They let us out when'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c,
; TalkMsg0155_WhenTheThievesRaidedUsWe.call_start_message_command09_hl_b04); starts message $0155
; through StartMessageCommand09HL (script command $09); that string begins 'When the thieves raided
; us, we ran.' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case22)
TalkMsg0155_WhenTheThievesRaidedUsWe::
    ld de, $005a
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0155 ; '*: When the thieves raided us,'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $01aa ; '*: Come back and join the'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c,
; TalkMsg0156_IWonderIfTheOthersAre.call_start_message_command09_hl_b04); starts message $0156
; through StartMessageCommand09HL (script command $09); that string begins 'I wonder if the others
; are safe' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case23)
TalkMsg0156_IWonderIfTheOthersAre::
    ld de, $005a
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0156 ; '*: I wonder if the others'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $01ab ; '*: The troupe'll reform! We'll recruit'
    call StartMessageCommand09HL_B04
    ret

; starts message $0157 through StartMessageCommand09HL (script command $09); that string begins
; 'Heh, did you see the looks I' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case02_Sub01_Case24)
TalkMsg0157_HehDidYouSeeTheLooks::
    ld hl, $0157 ; '*: Heh, did you see the'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c,
; TalkMsg0158_ThisIsTheKingsTreasuryNo.call_start_message_command09_hl_b042; flag 0056 then jr c,
; TalkMsg0158_ThisIsTheKingsTreasuryNo.call_start_message_command09_hl_b04); starts message $0158
; through StartMessageCommand09HL (script command $09); that string begins 'This is the King's
; treasury! No one,' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case25)
TalkMsg0158_ThisIsTheKingsTreasuryNo::
    ld de, $005a
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $0056
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0158 ; '*: This is the King's treasury!'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0192 ; '*: The prisoner in the dungeon'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $01ac ; '*: We're more vigilant now! No'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c,
; TalkMsg0159_WhatSeeHisMajestysTreasure.call_start_message_command09_hl_b043; flag 0056 then jr c,
; TalkMsg0159_WhatSeeHisMajestysTreasure.call_start_message_command09_hl_b042; flag 0053 then jr c,
; TalkMsg0159_WhatSeeHisMajestysTreasure.call_start_message_command09_hl_b04); starts message $0159
; through StartMessageCommand09HL (script command $09); that string begins 'What? See his Majesty's
; treasure? What foolishness!' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case26)
TalkMsg0159_WhatSeeHisMajestysTreasure::
    ld de, $005a
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, $0056
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $0053
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0159 ; '*: What? See his Majesty's treasure?'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $017e ; '*: The King solved our water'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $0191 ; '*: We can see the hideout'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b043:
    ld hl, $01ad ; '*: I will do my best'
    call StartMessageCommand09HL_B04
    ret

KalkaTalkEvents_TestFlagBit_Case27::
    ld de, $005a
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $0053
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, Script_5B57
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $017f ; '*: Our King worked to save'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $01ae ; '*: Welcome, our honored guests! The'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0053 then jr c,
; TalkMsg015A_HisMajestyIsHonestAndMost.call_start_message_command09_hl_b042; flag 0049 then jr c,
; TalkMsg015A_HisMajestyIsHonestAndMost.call_start_message_command09_hl_b04); starts message $015A
; through StartMessageCommand09HL (script command $09); that string begins 'His Majesty is honest
; and most certainly' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case28)
TalkMsg015A_HisMajestyIsHonestAndMost::
    ld de, $0053
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $0049
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $015a ; '*: His Majesty is honest and'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0170 ; '*: I feel badly for his'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $0180 ; '*: The King appears to have'
    call StartMessageCommand09HL_B04
    ret

; starts Script_5B71
KalkaTalkEvents_StartScriptAtHL_B04_Case29::
    ld a, [wStoryFlags + $61]
    bit 3, a
    ret nz
    ld hl, Script_5B71
    call StartScriptAtHL_B04
    ret

; starts message $015F through StartMessageCommand09HL (script command $09); that string begins '0
; checked the dresser. There were neatly' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case02_Sub01_Case2A)
TalkMsg015F_HeroCheckedTheDresserThere::
    ld hl, $015f ; '0 checked the dresser. There were'
    call StartMessageCommand09HL_B04
    ret

KalkaTalkEvents_TestFlagBit_Case2B::
    ld de, $005a
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b044
    ld de, $0056
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, $0054
    call TestFlagBit
    jr c, .call_start_script_at_hl_b043
    ld de, $0049
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $0048
    call TestFlagBit
    jr c, .call_start_script_at_hl_b042
    ld de, $0045
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld de, $0044
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_5A2C
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_5A4C
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0164 ; 'King: Investigate what concerns my people'
    call StartMessageCommand09HL_B04
    ret

.call_start_script_at_hl_b042:
    ld hl, Script_5A5C
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $0174 ; '*: I discovered why the water'
    call StartMessageCommand09HL_B04
    ret

.call_start_script_at_hl_b043:
    ld hl, Script_5AD6
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b043:
    ld hl, $0190 ; 'King: The lake was in sight,'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b044:
    ld hl, $01b0 ; 'King: Ah, good of you to'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c,
; TalkMsg0166_ThatFoolIsATerribleSwindler.call_start_message_command09_hl_b04); starts message $0166
; through StartMessageCommand09HL (script command $09); that string begins 'That fool is a terrible
; swindler. I' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case2C)
TalkMsg0166_ThatFoolIsATerribleSwindler::
    ld de, $005a
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0166 ; '*: That fool is a terrible'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $01b1 ; '*: The dungeon is full of'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0056 then jr c,
; TalkMsg0167_HumphAMirageLakeHeSays.call_start_message_command09_hl_b04); starts message $0167
; through StartMessageCommand09HL (script command $09); that string begins 'Humph! A mirage lake, he
; says! No' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case2D)
TalkMsg0167_HumphAMirageLakeHeSays::
    ld de, $0056
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0167 ; '*: Humph! A mirage lake, he'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0193 ; '*: How can we reach the'
    call StartMessageCommand09HL_B04
    ret

; starts Script_5A95: '*: What? Open the Canal Gate'
KalkaTalkEvents_TestFlagBit_Case2E::
    ld de, $0049
    call TestFlagBit
    ret nc
    ld hl, Script_5A95
    call StartScriptAtHL_B04
    ld de, $004a
    call SetFlagBit
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $01, story
; flag $004B in DE: when the flag is clear it gives item $01 (Herb) and sets the flag (message $A3
; of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; DispatchTalkEvent_Case02_Sub01_Case2F)
VaseItem_Herb_Flag004B::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $004b
    call StartTreasureFlagDE_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $1A, story
; flag $004C in DE: when the flag is clear it gives item $1A (PorkChop) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; DispatchTalkEvent_Case02_Sub01_Case30)
VaseItem_PorkChop::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $1a
    ld [wScriptParam1], a
    ld de, $004c
    call StartTreasureFlagDE_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $2C, story
; flag $004D in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; DispatchTalkEvent_Case02_Sub01_Case31)
VaseItem_TinyMedal::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2c
    ld [wScriptParam1], a
    ld de, $004d
    call StartTreasureFlagDE_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $2B, story
; flag $004E in DE: when the flag is clear it gives item $2B (Bookmark) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; DispatchTalkEvent_Case02_Sub01_Case32)
VaseItem_Bookmark::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2b
    ld [wScriptParam1], a
    ld de, $004e
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $2A, story flag $004F in DE: when the flag is clear it gives item $2A (ExitBell) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; DispatchTalkEvent_Case02_Sub01_Case33)
ChestItem_ExitBell_Flag004F::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2a
    ld [wScriptParam1], a
    ld de, $004f
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $24, story flag $0050 in DE: when the flag is clear it gives item $24 (Wind) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; DispatchTalkEvent_Case02_Sub01_Case34)
ChestItem_Wind::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $24
    ld [wScriptParam1], a
    ld de, $0050
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $29, story flag $0051 in DE: when the flag is clear it gives item $29 (WarpWing) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; DispatchTalkEvent_Case02_Sub01_Case35)
ChestItem_WarpWing::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $29
    ld [wScriptParam1], a
    ld de, $0051
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $48, story flag $0052 in DE: when the flag is clear it gives item $48 (AGL) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; DispatchTalkEvent_Case02_Sub01_Case36)
ChestItem_AGL::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $48
    ld [wScriptParam1], a
    ld de, $0052
    call StartTreasureFlagDE_B04
    ret

; starts Script_5AAB: '*: I'm making a new home'
KalkaTalkEvents_TestFlagBit_Case37::
    ld de, $005a
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_5AAB
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_5AD2
    call StartScriptAtHL_B04
    ret

KalkaTalkEvents_TestFlagBit_Case38::
    ld de, $0056
    call TestFlagBit
    ret nc
    ld de, $0057
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld a, $19
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr z, .call_start_script_at_hl_b04
    ld a, $1a
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr z, .call_start_script_at_hl_b04
    ld a, $1b
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr z, .call_start_script_at_hl_b04
    ld a, $1c
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr z, .call_start_script_at_hl_b04
    ld hl, Script_5B0D
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_5B1D
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $018e ; '*: Don't chase what runs from'
    call StartMessageCommand09HL_B04
    ret

; starts Script_5B37
KalkaTalkEvents_StartScriptAtHL_B04_Case39::
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

; tests story flags (flag 005A then jr c,
; TalkMsg0194_ThievesDroveUsFromOurHomes.call_start_message_command09_hl_b04); starts message $0194
; through StartMessageCommand09HL (script command $09); that string begins 'Thieves drove us from
; our homes!' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case3A)
TalkMsg0194_ThievesDroveUsFromOurHomes::
    ld de, $005a
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0194 ; '*: Thieves drove us from our'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $01b2 ; '*: Cooh, our home come back'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 005A then jr c,
; TalkMsg0195_TheLeaderOfTheThievesIs.call_start_message_command09_hl_b04); starts message $0195
; through StartMessageCommand09HL (script command $09); that string begins 'The leader of the
; thieves is a' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case02_Sub01_Case3B)
TalkMsg0195_TheLeaderOfTheThievesIs::
    ld de, $005a
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0195 ; '*: The leader of the thieves'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $01b4 ; '*: Cooh! This bed perfect for'
    call StartMessageCommand09HL_B04
    ret

KalkaTalkEvents_RunFieldCommandTemp0::
    ld a, $03
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld de, $0059
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_5B3C
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_5B49
    call StartScriptAtHL_B04
    ret

; starts message $01B5 through StartMessageCommand09HL (script command $09); that string begins
; 'Kyooh! Swimming in a desert This is' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case02_Sub01_Case3D)
TalkMsg01B5_KyoohSwimmingInADesertThis::
    ld hl, $01b5 ; '*: Kyooh! Swimming in a desert'
    call StartMessageCommand09HL_B04
    ret

; starts message $01BC through StartMessageCommand09HL (script command $09); that string begins '0
; checked the treasure chest. Thieves have' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case02_Sub01_Case3E)
TalkMsg01BC_HeroCheckedTheTreasureChest::
    ld hl, $01bc ; '0 checked the treasure chest. Thieves'
    call StartMessageCommand09HL_B04
    ret

; starts message $01BD through StartMessageCommand09HL (script command $09); that string begins '0
; peered into the vase. It was' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case02_Sub01_Case3F)
TalkMsg01BD_HeroPeeredIntoTheVaseIt::
    ld hl, $01bd ; '0 peered into the vase. It'
    call StartMessageCommand09HL_B04
    ret

; starts message $01C0 through StartMessageCommand09HL (script command $09); that string begins '0
; checked the treasure chest. But it' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case02_Sub01_Case40)
TalkMsg01C0_HeroCheckedTheTreasureChest::
    ld hl, $01c0 ; '0 checked the treasure chest. But'
    call StartMessageCommand09HL_B04
    ret

; starts message $01BF through StartMessageCommand09HL (script command $09); that string begins '0
; peered into the vase. The prisoners' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case02_Sub01_Case41)
TalkMsg01BF_HeroPeeredIntoTheVaseThe::
    ld hl, $01bf ; '0 peered into the vase. The'
    call StartMessageCommand09HL_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $19, story
; flag $005B in DE: when the flag is clear it gives item $19 (BeefJerky) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; DispatchTalkEvent_Case02_Sub01_Case42)
VaseItem_BeefJerky::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $19
    ld [wScriptParam1], a
    ld de, $005b
    call StartTreasureFlagDE_B04
    ret

; starts Script_5B53
KalkaTalkEvents_TestFlagBit_Case43::
    ld de, $0058
    call TestFlagBit
    ret nc
    ld hl, Script_5B53
    call StartScriptAtHL_B04
    ret

KalkaTalkEvents_WaitStoryFlagsPlus61::
    ld a, [wStoryFlags + $61]
    bit 4, a
    ret nz
    and $f7
    ld [wStoryFlags + $61], a
    ret

KalkaTalkEvents_TestFlagBit_Case45::
    ld a, $1f
    ld [wDataBank], a
    ld de, $005d
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_5B76
    call StartScriptAtHL_B04
    ld de, $005d
    call SetFlagBit
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_5B7D
    call StartScriptAtHL_B04
    ret

; talk category 6: two flag-tested handlers that start Darck's scripts ("Darck Fawahahah! You chased
; your treasures")
DarckTalkEvents::
    ld a, [wTalkEventGroup]
    jumptable
    dw DarckTalkEvents_TestFlagBit
    dw DarckTalkEvents_TestFlagBit_Case01

DarckTalkEvents_TestFlagBit::
    ld de, $00d2
    call TestFlagBit
    jr c, .call_start_script_at_hl_b042
    ld a, $36
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .call_start_script_at_hl_b04
    ld a, $37
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .call_start_script_at_hl_b04
    ld a, $38
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .call_start_script_at_hl_b04
    ld hl, Script_61AA
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_619D
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b042:
    ld hl, Script_61DC
    call StartScriptAtHL_B04
    ret

; starts Script_61E9: 'Darck: Fawahahah! You chased your treasures'
DarckTalkEvents_TestFlagBit_Case01::
    ld de, $00d0
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_61E9
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_61F6
    call StartScriptAtHL_B04
    ret

; talk category 0: jumps by wTalkEventGroup to the field events (the one-command scripts $80-$A1,
; E-0286)
FieldTalkEvents::
    ld a, [wTalkEventGroup]
    jumptable
    dw FieldTalkEvents_Return
    dw TalkScript512F
    dw TalkScript5131
    dw FieldTalkEvents_Return
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
    dw FieldTalkEvents_TestFlagBit
    dw FieldTalkEvents_TestFlagBit_Case1C
    dw TalkScript5171
    dw TalkScript5173
    dw TalkScript5164
    dw TalkScript515B
    dw TalkScript515D
    dw FieldTalkEvents_StartScriptAtHL_B04
    dw FieldTalkEvents_StartScriptAtHL_B04_Case23
    dw FieldTalkEvents_StartScriptAtHL_B04_Case24
    dw FieldTalkEvents_StartScriptAtHL_B04_Case25
    dw FieldTalkEvents_SetFollowerDelay
    dw FieldTalkEvents_Return

; starts Script_5173 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case1E)
; starts Script_5173
TalkScript5173::
    ld hl, Script_5173
    call StartScriptAtHL_B04
    ret

; starts Script_5171 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case1D)
; starts Script_5171
TalkScript5171::
    ld hl, Script_5171
    call StartScriptAtHL_B04
    ret

FieldTalkEvents_TestFlagBit_Case1C::
    ld de, $0024
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_516F
    call StartScriptAtHL_B04
    ret

FieldTalkEvents_TestFlagBit::
    ld de, $0024
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_516D
    call StartScriptAtHL_B04
    ret

; starts Script_516B (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case1A)
; starts Script_516B
TalkScript516B::
    ld hl, Script_516B
    call StartScriptAtHL_B04
    ret

; starts Script_5169 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case19)
; starts Script_5169
TalkScript5169::
    ld hl, Script_5169
    call StartScriptAtHL_B04
    ret

; starts Script_515F (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case18)
; starts Script_515F
TalkScript515F::
    ld hl, Script_515F
    call StartScriptAtHL_B04
    ret

; starts Script_5164 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case1F)
; starts Script_5164
TalkScript5164::
    ld hl, Script_5164
    call StartScriptAtHL_B04
    ret

; starts Script_5155 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case15)
; starts Script_5155
TalkScript5155::
    ld hl, Script_5155
    call StartScriptAtHL_B04
    ret

; starts Script_5157 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case16)
; starts Script_5157
TalkScript5157::
    ld hl, Script_5157
    call StartScriptAtHL_B04
    ret

; starts Script_5159 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case17)
; starts Script_5159
TalkScript5159::
    ld hl, Script_5159
    call StartScriptAtHL_B04
    ret

; starts Script_515B (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case20)
; starts Script_515B
TalkScript515B::
    ld hl, Script_515B
    call StartScriptAtHL_B04
    ret

; starts Script_515D (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case21)
; starts Script_515D
TalkScript515D::
    ld hl, Script_515D
    call StartScriptAtHL_B04
    ret

FieldTalkEvents_StartScriptAtHL_B04::
    ld a, [wFollowerDelay]
    or a
    ret z
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and $03
    ld [wFollowerRecords], a
    xor a
    ld [wScriptParam1], a
    ld hl, Script_57E1
    call StartScriptAtHL_B04
    ret

FieldTalkEvents_StartScriptAtHL_B04_Case23::
    ld a, [wFollowerDelay]
    or a
    ret z
    ld a, [wPartyCount]
    dec a
    ret z
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and $03
    ld [wFollowerRecords + $5], a
    ld a, $01
    ld [wScriptParam1], a
    ld hl, Script_57E1
    call StartScriptAtHL_B04
    ret

FieldTalkEvents_StartScriptAtHL_B04_Case24::
    ld a, [wFollowerDelay]
    or a
    ret z
    ld a, [wPartyCount]
    dec a
    ret z
    dec a
    ret z
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and $03
    ld [wFollowerRecords + $a], a
    ld a, $02
    ld [wScriptParam1], a
    ld hl, Script_57E1
    call StartScriptAtHL_B04
    ret

; starts Script_57DC
FieldTalkEvents_StartScriptAtHL_B04_Case25::
    ld a, [wFollowerDelay]
    or a
    ret nz
    ld hl, Script_57DC
    call StartScriptAtHL_B04
    ret

; starts Script_514B
FieldTalkEvents_SetFollowerDelay::
    xor a
    ld [wFollowerDelay], a
    ret

; starts Script_514B (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case10)
; starts Script_514B
TalkScript514B::
    ld hl, Script_514B
    call StartScriptAtHL_B04
    ret

; starts Script_514D (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case11)
; starts Script_514D
TalkScript514D::
    ld hl, Script_514D
    call StartScriptAtHL_B04
    ret

; starts Script_514F (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case12)
; starts Script_514F
TalkScript514F::
    ld hl, Script_514F
    call StartScriptAtHL_B04
    ret

; starts Script_5151 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case13)
; starts Script_5151
TalkScript5151::
    ld hl, Script_5151
    call StartScriptAtHL_B04
    ret

; starts Script_5153 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case14)
; starts Script_5153
TalkScript5153::
    ld hl, Script_5153
    call StartScriptAtHL_B04
    ret

; starts Script_512F
FieldTalkEvents_Return::
    ret

; starts Script_512F (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case01)
; starts Script_512F
TalkScript512F::
    ld hl, Script_512F
    call StartScriptAtHL_B04
    ret

; starts Script_5131 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case02)
; starts Script_5131
TalkScript5131::
    ld hl, Script_5131
    call StartScriptAtHL_B04
    ret

; starts Script_5137 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case04)
; starts Script_5137
TalkScript5137::
    ld hl, Script_5137
    call StartScriptAtHL_B04
    ret

; starts Script_5139 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case05)
; starts Script_5139
TalkScript5139::
    ld hl, Script_5139
    call StartScriptAtHL_B04
    ret

; starts Script_513B (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case06)
; starts Script_513B
TalkScript513B::
    ld hl, Script_513B
    call StartScriptAtHL_B04
    ret

; starts Script_513D (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case07)
; starts Script_513D
TalkScript513D::
    ld hl, Script_513D
    call StartScriptAtHL_B04
    ret

; starts Script_513F (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case08)
; starts Script_513F
TalkScript513F::
    ld hl, Script_513F
    call StartScriptAtHL_B04
    ret

; starts Script_5141 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case09)
; starts Script_5141
TalkScript5141::
    ld hl, Script_5141
    call StartScriptAtHL_B04
    ret

; starts Script_5143 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case0A)
; starts Script_5143
TalkScript5143::
    ld hl, Script_5143
    call StartScriptAtHL_B04
    ret

; starts Script_5145 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case0B)
; starts Script_5145
TalkScript5145::
    ld hl, Script_5145
    call StartScriptAtHL_B04
    ret

; starts Script_5147 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case0E)
; starts Script_5147
TalkScript5147::
    ld hl, Script_5147
    call StartScriptAtHL_B04
    ret

; starts Script_5149 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case00_Sub01_Case0F)
; starts Script_5149
TalkScript5149::
    ld hl, Script_5149
    call StartScriptAtHL_B04
    ret

; talk category 7: jumps by wTalkEventGroup to the talk handlers of the Elven village world
; (messages $0700-$07BF, $0C00-$0CFF)
ElvenVillageTalkEvents::
    ld a, [wTalkEventGroup]
    jumptable
    dw ElvenVillageTalkEvents_TestFlagBit
    dw ElvenVillageTalkEvents_ShowYoureAHumanHow
    dw ElvenVillageTalkEvents_TestFlagBit_Case02
    dw TalkMsg0708_HelloMunchkinEnjoyYourStay
    dw TalkMsg0709_AHumanHereItsBeenSeveral
    dw TalkMsg070A_YoureNotLikeUsYouScare
    dw TalkMsg070B_HeyThereImATalkingHorse
    dw TalkMsg070C_ThisHorseWasHereBeforeUs
    dw TalkMsg070D_ThisIsElvenVillageYoureA
    dw TalkMsg0752_IveHeardThatHumansAre
    dw ElvenVillageTalkEvents_StartScriptAtHL_B04
    dw ElvenVillageTalkEvents_ShowWellWellItIs
    dw ElvenVillageTalkEvents_TestFlagBit_Case0C
    dw TalkMsg0723_TchWeHaveToEatThe
    dw ElvenVillageTalkEvents_TestFlagBit_Case0E
    dw TalkMsg072F_ThisIsElvensLookoutPostWe
    dw TalkMsg0730_HorridMonstersThatAttack
    dw ElvenVillageTalkEvents_TestFlagBit_Case11
    dw ElvenVillageTalkEvents_TestFlagBit_Case12
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
    dw ElvenVillageTalkEvents_ShowThisIsThePower
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
    dw ElvenVillageTalkEvents_ShowThisIsTheBaffle
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
    dw ElvenVillageTalkEvents_ShowIfYouveMadeIt
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

; starts Script_6200
ElvenVillageTalkEvents_TestFlagBit::
    ld de, $0140
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld hl, Script_6200
    call StartScriptAtHL_B04
    ret

.call_test_flag_bit:
    ld de, $0148
    call TestFlagBit
    ret c
    ld de, $0147
    call TestFlagBit
    ret nc
    ld hl, Script_624B
    call StartScriptAtHL_B04
    ret

ElvenVillageTalkEvents_ShowYoureAHumanHow::
    ld de, $0151
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b044
    ld de, $014f
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, $014b
    call TestFlagBit
    jr c, .call_start_script_at_hl_b042
    ld de, $0146
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $0143
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld de, $0141
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld hl, $0701 ; '*: You're a human. How did'
    call StartMessageCommand09HL_B04
    ld de, $0141
    call SetFlagBit
    ret

.call_test_flag_bit:
    ld de, $0142
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, $0702 ; '*: Even worse, you have monsters.'
    call StartMessageCommand09HL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_620C
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0706 ; 'Rolt: Go south in the plains,'
    call StartMessageCommand09HL_B04
    ld de, $0145
    call SetFlagBit
    ret

.call_start_message_command09_hl_b042:
    ld hl, $0715 ; 'Rolt: 0, I can see that'
    call StartMessageCommand09HL_B04
    ret

.call_start_script_at_hl_b042:
    ld hl, Script_62AD
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b043:
    ld hl, $0738 ; 'Rolt: Urrrgh 0 Please Please save'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b044:
    ld hl, $0746 ; 'Rolt: I'm going to get strong'
    call StartMessageCommand09HL_B04
    ret

ElvenVillageTalkEvents_TestFlagBit_Case02::
    ld de, $0152
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, $0151
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $0146
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld de, $0143
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, Script_6382
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0707 ; 'Cyal: We're going back home now.'
    call StartMessageCommand09HL_B04
    ld de, $0145
    call SetFlagBit
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_6240
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $0747 ; 'Cyal: I hope you'll stay my'
    call StartMessageCommand09HL_B04
    ld de, $0152
    call SetFlagBit
    ret

.call_start_message_command09_hl_b043:
    ld hl, $0748 ; 'Cyal: I ought to become a'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0151 then jr c,
; TalkMsg0708_HelloMunchkinEnjoyYourStay.call_start_message_command09_hl_b043; flag 014C then jr c,
; TalkMsg0708_HelloMunchkinEnjoyYourStay.call_start_message_command09_hl_b042; flag 0147 then jr c,
; TalkMsg0708_HelloMunchkinEnjoyYourStay.call_start_message_command09_hl_b04); starts message $0708
; through StartMessageCommand09HL (script command $09); that string begins 'Hello, munchkin. Enjoy
; your stay!' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case03)
TalkMsg0708_HelloMunchkinEnjoyYourStay::
    ld de, $0151
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, $014c
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $0147
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0708 ; '*: Hello, munchkin. Enjoy your stay!'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0717 ; '*: Cyal grew up as an'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $0755 ; '*: Not only their parents, but'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b043:
    ld hl, $0749 ; '*: We owe you a big'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0151 then jr c,
; TalkMsg0709_AHumanHereItsBeenSeveral.call_start_message_command09_hl_b042; flag 0147 then jr c,
; TalkMsg0709_AHumanHereItsBeenSeveral.call_start_message_command09_hl_b04); starts message $0709
; through StartMessageCommand09HL (script command $09); that string begins 'A human here? It's been
; several centuries' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case04)
TalkMsg0709_AHumanHereItsBeenSeveral::
    ld de, $0151
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $0147
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0709 ; '*: A human here? It's been'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0718 ; '*: Cyal and Rolt have no'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $074a ; '*: Thanks to you, we can'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0151 then jr c,
; TalkMsg070A_YoureNotLikeUsYouScare.call_start_message_command09_hl_b04); starts message $070A
; through StartMessageCommand09HL (script command $09); that string begins 'You're not like us. You
; scare me' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case05)
TalkMsg070A_YoureNotLikeUsYouScare::
    ld de, $0151
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $070a ; '*: You're not like us. You'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $074b ; '*: You look kind and caring.'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0151 then jr c,
; TalkMsg070B_HeyThereImATalkingHorse.call_start_message_command09_hl_b043; flag 014C then jr c,
; TalkMsg070B_HeyThereImATalkingHorse.call_start_message_command09_hl_b042; flag 0147 then jr c,
; TalkMsg070B_HeyThereImATalkingHorse.call_start_message_command09_hl_b04); starts message $070B
; through StartMessageCommand09HL (script command $09); that string begins 'Hey there! I'm a talking
; horse. Glad' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case06)
TalkMsg070B_HeyThereImATalkingHorse::
    ld de, $0151
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, $014c
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $0147
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $070b ; '*: Hey there! I'm a talking'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $071a ; '*: Cyal's parents were attacked by'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $072c ; '*: AgDevil is a total terror.'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b043:
    ld hl, $074c ; '*: Brave human, hear this. The'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0151 then jr c,
; TalkMsg070C_ThisHorseWasHereBeforeUs.call_start_message_command09_hl_b04); starts message $070C
; through StartMessageCommand09HL (script command $09); that string begins 'This horse was here
; before us.' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case07)
TalkMsg070C_ThisHorseWasHereBeforeUs::
    ld de, $0151
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $070c ; '*: This horse was here before'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $074d ; '*: The talking horse came from'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0151 then jr c,
; TalkMsg070D_ThisIsElvenVillageYoureA.call_start_message_command09_hl_b043; flag 014C then jr c,
; TalkMsg070D_ThisIsElvenVillageYoureA.call_start_message_command09_hl_b042; flag 0147 then jr c,
; TalkMsg070D_ThisIsElvenVillageYoureA.call_start_message_command09_hl_b04); starts message $070D
; through StartMessageCommand09HL (script command $09); that string begins 'This is Elven village.
; You're a human,' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case08)
TalkMsg070D_ThisIsElvenVillageYoureA::
    ld de, $0151
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, $014c
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $0147
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $070d ; '*: This is Elven village. You're'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $071b ; '*: I think Cyal's looking forward'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $072d ; '*: Cyal was taken away by'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b043:
    ld hl, $074e ; '*: You put down that fiend?'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0151 then jr c,
; TalkMsg0752_IveHeardThatHumansAre.call_start_message_command09_hl_b043; flag 014C then jr c,
; TalkMsg0752_IveHeardThatHumansAre.call_start_message_command09_hl_b042; flag 0147 then jr c,
; TalkMsg0752_IveHeardThatHumansAre.call_start_message_command09_hl_b04); starts message $0752
; through StartMessageCommand09HL (script command $09); that string begins 'I've heard that humans
; are wild' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case09) (E-0324: was
; TalkMsg0752_IEHeardThatHumansAre; read before $42 was known as 'v)
TalkMsg0752_IveHeardThatHumansAre::
    ld de, $0151
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, $014c
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $0147
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0752 ; '*: I've heard that humans are'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $071c ; '*: Humans can't be trusted, but'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $072e ; '*: Didn't I ask you to'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b043:
    ld hl, $074f ; '*: You You're a savage but'
    call StartMessageCommand09HL_B04
    ret

ElvenVillageTalkEvents_StartScriptAtHL_B04::
    ld a, $10
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_637B
    call StartScriptAtHL_B04
    ret

ElvenVillageTalkEvents_ShowWellWellItIs::
    ld de, $0151
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b044
    ld de, $014d
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, $014c
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $0146
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld de, $0144
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld de, $0145
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, $070f ; '*: Well, well It is a'
    call StartMessageCommand09HL_B04
    ld de, $0144
    call SetFlagBit
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_6218
    call StartScriptAtHL_B04
    ret

.call_test_flag_bit:
    ld de, $0145
    call TestFlagBit
    jr c, .call_start_script_at_hl_b042
    ld hl, $0753 ; 'I'm the Village Elder. By the'
    call StartMessageCommand09HL_B04
    ret

.call_start_script_at_hl_b042:
    ld hl, Script_622C
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0714 ; '*: Tamed monsters, have you? That's'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $072a ; '*: AgDevil killed Rolt's parents. Rolt'
    call StartMessageCommand09HL_B04
    ld de, $014d
    call SetFlagBit
    ret

.call_start_message_command09_hl_b043:
    ld hl, $072b ; '*: AgDevil appears to come from'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b044:
    ld hl, $0744 ; '*: Our gratitude is as plentiful'
    call StartMessageCommand09HL_B04
    ret

; starts Script_626A: '*: Master AgDevil, a human, ruff!'
ElvenVillageTalkEvents_TestFlagBit_Case0C::
    ld de, $0148
    call TestFlagBit
    ret nc
    ld hl, Script_626A
    call StartScriptAtHL_B04
    ret

; tests story flags (flag 014A then jr c,
; TalkMsg0723_TchWeHaveToEatThe.call_start_message_command09_hl_b04); starts message $0723 through
; StartMessageCommand09HL (script command $09); that string begins 'Tch, we have to eat the lousy'
; (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case0D)
TalkMsg0723_TchWeHaveToEatThe::
    ld de, $014a
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0723 ; '*: Tch, we have to eat'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0726 ; '*: Huh? It's here again, ruff!'
    call StartMessageCommand09HL_B04
    ret

; starts Script_6290: '*: That's what we'll do, kid.'
ElvenVillageTalkEvents_TestFlagBit_Case0E::
    ld de, $014a
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_6290
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_62A0
    call StartScriptAtHL_B04
    ret

; tests story flags (flag 0151 then jr c,
; TalkMsg072F_ThisIsElvensLookoutPostWe.call_start_message_command09_hl_b043; flag 014E then jr c,
; TalkMsg072F_ThisIsElvensLookoutPostWe.call_start_message_command09_hl_b042; flag 014C then jr c,
; TalkMsg072F_ThisIsElvensLookoutPostWe.call_start_message_command09_hl_b04); starts message $072F
; through StartMessageCommand09HL (script command $09); that string begins 'This is Elven's lookout
; post. We stand' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case0F)
TalkMsg072F_ThisIsElvensLookoutPostWe::
    ld de, $0151
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, $014e
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $014c
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $072f ; '*: This is Elven's lookout post.'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0731 ; '*: This is the lookout post.'
    call StartMessageCommand09HL_B04
    ld de, $014e
    call SetFlagBit
    ret

.call_start_message_command09_hl_b042:
    ld hl, $0732 ; '*: That AgDevil is from the'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b043:
    ld hl, $0750 ; '*: This is Elven's lookout post.'
    call StartMessageCommand09HL_B04
    ret

; tests story flags (flag 0151 then jr c,
; TalkMsg0730_HorridMonstersThatAttack.call_start_message_command09_hl_b042; flag 014C then jr c,
; TalkMsg0730_HorridMonstersThatAttack.call_start_message_command09_hl_b04); starts message $0730
; through StartMessageCommand09HL (script command $09); that string begins 'Horrid monsters that
; attack elves appear often' (E-0268, the E-0082 shape; was DispatchTalkEvent_Case07_Sub01_Case10)
TalkMsg0730_HorridMonstersThatAttack::
    ld de, $0151
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $014c
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0730 ; '*: Horrid monsters that attack elves'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0733 ; '*: You're not going to the'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $0751 ; '*: Beating AgDevil That's incredible! But'
    call StartMessageCommand09HL_B04
    ret

; starts Script_62BD: '*: The human in the forest'
ElvenVillageTalkEvents_TestFlagBit_Case11::
    ld de, $0150
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_62BD
    call StartScriptAtHL_B04
    ld de, $0150
    call SetFlagBit
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_6313
    call StartScriptAtHL_B04
    ret

; starts Script_6369: 'Rolt: I've found you at last!'
ElvenVillageTalkEvents_TestFlagBit_Case12::
    ld de, $014c
    call TestFlagBit
    ret nc
    ld hl, Script_6369
    call StartScriptAtHL_B04
    ld de, $0149
    call SetFlagBit
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $2C, story
; flag $0153 in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; DispatchTalkEvent_Case07_Sub01_Case13)
VaseItem_TinyMedal_Flag0153::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2c
    ld [wScriptParam1], a
    ld de, $0153
    call StartTreasureFlagDE_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $10, story
; flag $0154 in DE: when the flag is clear it gives item $10 (INTseed) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; DispatchTalkEvent_Case07_Sub01_Case14)
VaseItem_INTseed::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $10
    ld [wScriptParam1], a
    ld de, $0154
    call StartTreasureFlagDE_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $04, story
; flag $0155 in DE: when the flag is clear it gives item $04 (Potion) and sets the flag (message $A3
; of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; DispatchTalkEvent_Case07_Sub01_Case15)
VaseItem_Potion::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $04
    ld [wScriptParam1], a
    ld de, $0155
    call StartTreasureFlagDE_B04
    ret

; starts message $0756 through StartMessageCommand09HL (script command $09); that string begins '0
; peered into the vase. It was' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case07_Sub01_Case16)
TalkMsg0756_HeroPeeredIntoTheVaseIt::
    ld hl, $0756 ; '0 peered into the vase. It'
    call StartMessageCommand09HL_B04
    ret

; starts message $0758 through StartMessageCommand09HL (script command $09); that string begins '0
; checked the oven. Stew simmered and' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case07_Sub01_Case17)
TalkMsg0758_HeroCheckedTheOvenStewSimmered::
    ld hl, $0758 ; '0 checked the oven. Stew simmered'
    call StartMessageCommand09HL_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $03, story flag $0156 in DE: when the flag is clear it gives item $03 (WorldDew) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; DispatchTalkEvent_Case07_Sub01_Case18)
ChestItem_WorldDew_Flag0156::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $03
    ld [wScriptParam1], a
    ld de, $0156
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $2A, story flag $0157 in DE: when the flag is clear it gives item $2A (ExitBell) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; DispatchTalkEvent_Case07_Sub01_Case19)
ChestItem_ExitBell_Flag0157::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2a
    ld [wScriptParam1], a
    ld de, $0157
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $12, story flag $0158 in DE: when the flag is clear it gives item $12 (MysticNut) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was DispatchTalkEvent_Case07_Sub01_Case1A)
ChestItem_MysticNut::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $12
    ld [wScriptParam1], a
    ld de, $0158
    call StartTreasureFlagDE_B04
    ret

; starts message $0757 through StartMessageCommand09HL (script command $09); that string begins '0
; checked the oven. A sharp aroma' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case07_Sub01_Case1B)
TalkMsg0757_HeroCheckedTheOvenASharp::
    ld hl, $0757 ; '0 checked the oven. A sharp'
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 7
; constant message(s) depending on story flags and state; the first one in the code is $075F, whose
; string begins 'Kiral Fetch me my treasure from'; the branching is not interpreted (E-0097)
Talk075F_KiralFetchMeMy::
    ld de, $0167
    call TestFlagBit
    jp c, .call_test_flag_bit2
    ld de, $0165
    call TestFlagBit
    jp c, .call_test_flag_bit
    ld de, $0163
    call TestFlagBit
    jr c, .set_temp0_to_3C
    ld de, $0162
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $015f
    call TestFlagBit
    jr c, .call_start_script_at_hl_b042
    ld de, $015a
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld de, $0159
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_6398
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_63BC
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $075f ; 'Kiral: Fetch me my treasure from'
    call StartMessageCommand09HL_B04
    ret

.call_start_script_at_hl_b042:
    ld hl, Script_6409
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $0778 ; 'Kiral: Please Go stop him. You'
    call StartMessageCommand09HL_B04
    ret

.set_temp0_to_3C:
    ld a, $3c
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .call_start_message_command09_hl_b043
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

.call_start_message_command09_hl_b043:
    ld hl, $077d ; 'Kiral: Ah! Back! Is Rob-N Did'
    call StartMessageCommand09HL_B04
    ret

.call_test_flag_bit:
    ld de, $0166
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b044
    ld hl, $0786 ; 'Kiral: You've been a great help.'
    call StartMessageCommand09HL_B04
    ld de, $0166
    call SetFlagBit
    ret

.call_start_message_command09_hl_b044:
    ld hl, $0787 ; 'Kiral: Visit me when you're free.'
    call StartMessageCommand09HL_B04
    ret

.call_test_flag_bit2:
    ld de, $0168
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b045
    ld hl, $0789 ; 'Kiral: Hohoh! I've got good news!'
    call StartMessageCommand09HL_B04
    ld de, $0168
    call SetFlagBit
    ret

.call_start_message_command09_hl_b045:
    ld hl, $078a ; 'Kiral: Roboster2's skills are simply exceptional.'
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 3
; constant message(s) depending on story flags and state; the first one in the code is $075A, whose
; string begins 'Pii Ggzz Piiiiii'; the branching is not interpreted (E-0097)
Talk075A_PiiGgzzPiiiiii::
    ld de, $0167
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $0165
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    xor a
    ld [wObject1 + OBJ_STATE], a
    ld hl, $075a ; '*: Pii Ggzz Piiiiii'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0788 ; '*: I AM THE LATEST ROBOSTER.'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $078b ; '*: MY NAME IS LEO. THE'
    call StartMessageCommand09HL_B04
    ret

; starts message $0760 through StartMessageCommand09HL (script command $09); that string begins '0
; checked the bookshelf. A recent diary' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case07_Sub01_Case22)
TalkMsg0760_HeroCheckedTheBookshelfA::
    ld hl, $0760 ; '0 checked the bookshelf. A recent'
    call StartMessageCommand09HL_B04
    ret

; starts message $0761 through StartMessageCommand09HL (script command $09); that string begins '0
; checked the bookshelf. A very old' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case07_Sub01_Case23)
TalkMsg0761_HeroCheckedTheBookshelfA::
    ld hl, $0761 ; '0 checked the bookshelf. A very'
    call StartMessageCommand09HL_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $2C, story
; flag $015B in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; DispatchTalkEvent_Case07_Sub01_Case24)
VaseItem_TinyMedal_Flag015B::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2c
    ld [wScriptParam1], a
    ld de, $015b
    call StartTreasureFlagDE_B04
    ret

; starts message $0762 through StartMessageCommand09HL (script command $09); that string begins '0
; peered into the vase. Rolled blueprints' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case07_Sub01_Case25)
TalkMsg0762_HeroPeeredIntoTheVaseRolled::
    ld hl, $0762 ; '0 peered into the vase. Rolled'
    call StartMessageCommand09HL_B04
    ret

; starts message $0763 through StartMessageCommand09HL (script command $09); that string begins '0
; peered into the barrel. It faintly' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case07_Sub01_Case26)
TalkMsg0763_HeroPeeredIntoTheBarrelIt::
    ld hl, $0763 ; '0 peered into the barrel. It'
    call StartMessageCommand09HL_B04
    ret

; starts message $0764 through StartMessageCommand09HL (script command $09); that string begins '0
; peered into the barrel. There were' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case07_Sub01_Case27)
TalkMsg0764_HeroPeeredIntoTheBarrelThere::
    ld hl, $0764 ; '0 peered into the barrel. There'
    call StartMessageCommand09HL_B04
    ret

; starts message $0765 through StartMessageCommand09HL (script command $09); that string begins '0
; peered into the barrel. There was' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case07_Sub01_Case28)
TalkMsg0765_HeroPeeredIntoTheBarrelThere::
    ld hl, $0765 ; '0 peered into the barrel. There'
    call StartMessageCommand09HL_B04
    ret

; a one-time barrel: script command $0A with wScriptParam0 = 2 (kind) and wScriptParam1 = $03, story
; flag $015C in DE: when the flag is clear it gives item $03 (WorldDew) and sets the flag (message
; $A6 of group 0; $A7 when the flag is already set, $A8 when there is no room) (E-0269; was
; DispatchTalkEvent_Case07_Sub01_Case29)
BarrelItem_WorldDew::
    ld a, $02
    ld [wScriptParam0], a
    ld a, $03
    ld [wScriptParam1], a
    ld de, $015c
    call StartTreasureFlagDE_B04
    ret

; starts message $0766 through StartMessageCommand09HL (script command $09); that string begins '0
; peered into the barrel. A quite' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case07_Sub01_Case2A)
TalkMsg0766_HeroPeeredIntoTheBarrelA::
    ld hl, $0766 ; '0 peered into the barrel. A'
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1
; constant message(s) depending on story flags and state; the first one in the code is $0768, whose
; string begins '0 peered into the barrel. There'; the branching is not interpreted (E-0097)
; starts Script_63DB: '0 peered into the barrel. A'
Talk0768_HeroPeeredIntoThe::
    ld de, $015d
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, Script_63DB
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0768 ; '0 peered into the barrel. There'
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1
; constant message(s) depending on story flags and state; the first one in the code is $0768, whose
; string begins '0 peered into the barrel. There'; the branching is not interpreted (E-0097)
; starts Script_63E4: '0 peered into the barrel. A'
Talk0768_HeroPeeredIntoThe_70FC::
    ld de, $015e
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, Script_63E4
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0768 ; '0 peered into the barrel. There'
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 2
; constant message(s) depending on story flags and state; the first one in the code is $078E, whose
; string begins 'Roboster stopped moving entirely'; the branching is not interpreted (E-0097)
Talk078E_RobosterStoppedMovingEntirely::
    ld de, $0167
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $0163
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld de, $0161
    call TestFlagBit
    jr c, .call_start_script_at_hl_b043
    ld de, $0160
    call TestFlagBit
    jr c, .call_start_script_at_hl_b042
    ld de, $015f
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_63ED
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_63F4
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b042:
    ld hl, Script_63FB
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b043:
    ld hl, Script_6402
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $078e ; 'Roboster stopped moving entirely'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $078c ; '*: WELCOME. I AM ROB-N. I'
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 3
; constant message(s) depending on story flags and state; the first one in the code is $077B, whose
; string begins '0 peered into the barrel. There'; the branching is not interpreted (E-0097)
Talk077B_HeroPeeredIntoThe::
    ld de, $0164
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld de, $0163
    call TestFlagBit
    jr c, .call_inventory_has_free_slot_check
    ld hl, Script_6416
    call StartScriptAtHL_B04
    ret

.call_inventory_has_free_slot_check:
    call InventoryHasFreeSlotCheck
    jr c, .read_game_flags836
    ld hl, $077b ; '0 peered into the barrel. There'
    call StartMessageCommand09HL_B04
    ret

.read_game_flags836:
    ld [hl], $3c
    ld a, [wGameFlags836]
    set 6, a
    ld [wGameFlags836], a
    ld hl, $077a ; '0 peered into the barrel. There'
    call StartMessageCommand09HL_B04
    ld de, $0164
    call SetFlagBit
    ret

.call_start_message_command09_hl_b04:
    ld hl, $077c ; '0 peered into the barrel. There'
    call StartMessageCommand09HL_B04
    ret

; starts message $07B7 through StartMessageCommand09HL (script command $09); that string begins 'The
; tower's entry is sealed tight.' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case07_Sub01_Case2F)
TalkMsg07B7_TheTowersEntryIsSealedTight::
    ld hl, $07b7 ; 'The tower's entry is sealed tight.'
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to
; TalkMsg078F_ThisIsTheTown.call_start_message_command09_hl_b04); when none of them branches, starts
; message $078F through StartMessageCommand09HL_B04 (script command $09); that string begins 'This
; is the town of Miagen.' (E-0082)
TalkMsg078F_ThisIsTheTown::
    ld de, $01c3
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $078f ; '*: This is the town of'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0ce2 ; '*: Welcome to the town of'
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to
; TalkMsg0790_AreYouFriendsWith.call_start_message_command09_hl_b042; flag $01BC set: jr to
; TalkMsg0790_AreYouFriendsWith.call_start_message_command09_hl_b04); when none of them branches,
; starts message $0790 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'Are you friends with monsters? You're' (E-0082)
TalkMsg0790_AreYouFriendsWith::
    ld de, $01c3
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $01bc
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0790 ; '*: Are you friends with monsters?'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $07c6 ; '*: Are you Milayou's friend? The'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $0ce3 ; '*: So you defeated the evildoer?'
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to
; TalkMsg0791_WowYouHaveMonsters.call_start_message_command09_hl_b04); when none of them branches,
; starts message $0791 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'Wow! You have monsters! Neat! Are' (E-0082)
TalkMsg0791_WowYouHaveMonsters::
    ld de, $01c3
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0791 ; '*: Wow! You have monsters! Neat!'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0ce4 ; '*: Wow, you have monsters! Wicked!'
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to
; TalkMsg0792_AreYourMonstersGood.call_start_message_command09_hl_b04); when none of them branches,
; starts message $0792 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'Are your monsters good? I don't' (E-0082)
TalkMsg0792_AreYourMonstersGood::
    ld de, $01c3
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0792 ; '*: Are your monsters good? I'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0ce5 ; '*: Your monsters are good, it's'
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to
; TalkMsg0793_MonstersCanBeGood.call_start_message_command09_hl_b042; flag $01BC set: jr to
; TalkMsg0793_MonstersCanBeGood.call_start_message_command09_hl_b04); when none of them branches,
; starts message $0793 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'Monsters can be good or bad.' (E-0082)
TalkMsg0793_MonstersCanBeGood::
    ld de, $01c3
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $01bc
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0793 ; '*: Monsters can be good or'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $07c7 ; '*: If a monster could be'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $0ce6 ; '*: So there are evil masters'
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to
; TalkMsg0794_YouAppearToHave.call_start_message_command09_hl_b04); when none of them branches,
; starts message $0794 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'You appear to have the power' (E-0082)
TalkMsg0794_YouAppearToHave::
    ld de, $01c3
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0794 ; '*: You appear to have the'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0ce7 ; '*: Controlling monsters is no easy'
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 4
; constant message(s) depending on story flags and state; the first one in the code is $07A4, whose
; string begins 'Could you humor this old man'; the branching is not interpreted (E-0097)
Talk07A4_CouldYouHumorThis::
    ld de, $01c3
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $01be
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld de, $01bc
    call TestFlagBit
    jr c, .set_temp0_to_3D
    ld de, $01b1
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld hl, Script_6430
    call StartScriptAtHL_B04
    ret

.call_test_flag_bit:
    ld de, $01b2
    call TestFlagBit
    jr c, .loop
    ld hl, $07a4 ; '*: Could you humor this old'
    call StartMessageCommand09HL_B04
    ld de, $01b2
    call SetFlagBit
    ret

.loop:
    ld hl, $07a5 ; '*: My daughter wedded a man'
    call StartMessageCommand09HL_B04
    ret

.set_temp0_to_3D:
    ld a, $3d
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .loop
    farcall RemoveInventorySlotShiftDown
    ld hl, Script_64CA
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $07ce ; '*: Things haven't been good for'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $0ce8 ; '*: I thank you in all'
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 3
; constant message(s) depending on story flags and state; the first one in the code is $07A6, whose
; string begins 'Our daughter's only memento was taken'; the branching is not interpreted (E-0097)
Talk07A6_OurDaughtersOnlyMemento::
    ld de, $01c3
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, $01bf
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $01be
    call TestFlagBit
    jr c, .call_inventory_has_free_slot_check
    ld de, $01b1
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, Script_6437
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $07a6 ; '*: Our daughter's only memento was'
    call StartMessageCommand09HL_B04
    ret

.call_inventory_has_free_slot_check:
    call InventoryHasFreeSlotCheck
    jr c, .read_game_flags836
    ld hl, Script_64DC
    call StartScriptAtHL_B04
    ret

.read_game_flags836:
    ld [hl], $0b
    ld a, [wGameFlags836]
    set 6, a
    ld [wGameFlags836], a
    ld hl, Script_64E3
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $07d3 ; '*: We are grateful that you'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b043:
    ld hl, $0ce9 ; '*: The atmosphere has cheered up,'
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to
; TalkMsg0799_MonstersRaidedThisHouse.call_start_message_command09_hl_b043; flag $01BE set: jr to
; TalkMsg0799_MonstersRaidedThisHouse.call_start_message_command09_hl_b042; flag $01B1 set: jr to
; TalkMsg0799_MonstersRaidedThisHouse.call_start_message_command09_hl_b04); when none of them
; branches, starts message $0799 through StartMessageCommand09HL_B04 (script command $09); that
; string begins 'Monsters raided this house within the' (E-0082)
TalkMsg0799_MonstersRaidedThisHouse::
    ld de, $01c3
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, $01be
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $01b1
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0799 ; '*: Monsters raided this house within'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $07a7 ; '*: It doesn't look like the'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $07d4 ; '*: The old couple look happy'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b043:
    ld hl, $0cea ; '*: I long to have a'
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to
; TalkMsg079A_TheOldPeopleAcross.call_start_message_command09_hl_b043; flag $01BE set: jr to
; TalkMsg079A_TheOldPeopleAcross.call_start_message_command09_hl_b042; flag $01B1 set: jr to
; TalkMsg079A_TheOldPeopleAcross.call_start_message_command09_hl_b04); when none of them branches,
; starts message $079A through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'The old people across the way' (E-0082)
TalkMsg079A_TheOldPeopleAcross::
    ld de, $01c3
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, $01be
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $01b1
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $079a ; '*: The old people across the'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $07a8 ; '*: The old couple across the'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $07d5 ; '*: I'm so glad the people'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b043:
    ld hl, $0ceb ; '*: Old people say that a'
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to
; TalkMsg079B_MonstersHaveTakenTo.call_start_message_command09_hl_b042; flag $01BC set: jr to
; TalkMsg079B_MonstersHaveTakenTo.call_start_message_command09_hl_b04); when none of them branches,
; starts message $079B through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'Monsters have taken to attacking the' (E-0082)
TalkMsg079B_MonstersHaveTakenTo::
    ld de, $01c3
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $01bc
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $079b ; '*: Monsters have taken to attacking'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $07c8 ; '*: Don't you think it's odd'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $0cec ; '*: Monsters can be good or'
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to
; TalkMsg079C_GrrrrImSoAngry.call_start_message_command09_hl_b042; flag $01BC set: jr to
; TalkMsg079C_GrrrrImSoAngry.call_start_message_command09_hl_b04); when none of them branches,
; starts message $079C through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'Grrrr! I'm so angry! Monsters stole' (E-0082)
TalkMsg079C_GrrrrImSoAngry::
    ld de, $01c3
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $01bc
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $079c ; '*: Grrrr! I'm so angry! Monsters'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $07c9 ; '*: Arrrgh! This is so infuriating!'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $0ced ; '*: The thief was selling what'
    call StartMessageCommand09HL_B04
    ret

; wScreenTableIndex = $11, wDataBank = $10, then StartScriptAtHL_B04 with HL = Script_643E (E-0119)
StartScript643EInBank10::
    ld a, $11
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_643E
    call StartScriptAtHL_B04
    ret

; map event: wSpriteSlots + $7 = 0 if hPlayerX = $30 else 1, starts script $6445 and sets wDataBank
; = $10 (E-0122)
StartScript6445ByPlayerX30::
    xor a
    ld [wSpriteSlots + $7], a
    ldh a, [hPlayerX]
    cp $30
    jr z, .call_start_script_at_hl_b04
    ld a, $01
    ld [wSpriteSlots + $7], a

.call_start_script_at_hl_b04:
    ld hl, Script_6445
    call StartScriptAtHL_B04
    ld a, $10
    ld [wDataBank], a
    ret

; tests story flags in turn (flag $01C3 set: jr to
; TalkMsg079F_IfYouTravelWest.call_start_message_command09_hl_b042; flag $01BE set: jr to
; TalkMsg079F_IfYouTravelWest.call_start_message_command09_hl_b04); when none of them branches,
; starts message $079F through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'If you travel west along the' (E-0082)
TalkMsg079F_IfYouTravelWest::
    ld de, $01c3
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $01be
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $079f ; '*: If you travel west along'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $07d6 ; '*: What do those monsters do'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $0cee ; '*: It sure was a thrilling'
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 3
; constant message(s) depending on story flags and state; the first one in the code is $07D7, whose
; string begins 'Milayou I've been checking around,'; the branching is not interpreted (E-0097)
Talk07D7_MilayouIEBeen::
    ld de, $01c5
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld de, $01c4
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, $01c3
    call TestFlagBit
    jr c, .call_start_script_at_hl_b043
    ld de, $01c1
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $01c0
    call TestFlagBit
    jr c, .call_start_script_at_hl_b042
    ld de, $01be
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld de, $01b0
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_644C
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_6469
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $07d7 ; 'Milayou: I've been checking around, and'
    call StartMessageCommand09HL_B04
    ret

.call_start_script_at_hl_b042:
    ld hl, Script_6501
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $07dd ; 'Milayou: Please defeat the dark master'
    call StartMessageCommand09HL_B04
    ret

.call_start_script_at_hl_b043:
    ld hl, Script_654C
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b043:
    ld hl, $0cf1 ; 'Milayou: You've inspired me to try'
    call StartMessageCommand09HL_B04
    ret

.call_test_flag_bit:
    ld de, $01c6
    call TestFlagBit
    jr c, .call_start_script_at_hl_b044
    ld hl, Script_6558
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b044:
    ld hl, Script_6578
    call StartScriptAtHL_B04
    ret

; starts message $07A9 through StartMessageCommand09HL (script command $09); that string begins
; 'This is the traveler's hut. Stay and' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case07_Sub01_Case40)
TalkMsg07A9_ThisIsTheTravelersHutStay::
    ld hl, $07a9 ; '*: This is the traveler's hut.'
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to
; TalkMsg07AA_ThatDealerHowExpensive.call_start_message_command09_hl_b043; flag $01BE set: jr to
; TalkMsg07AA_ThatDealerHowExpensive.call_start_message_command09_hl_b042; flag $01BB set: jr to
; TalkMsg07AA_ThatDealerHowExpensive.call_start_message_command09_hl_b04); when none of them
; branches, starts message $07AA through StartMessageCommand09HL_B04 (script command $09); that
; string begins 'That dealer, how expensive! Nobody can' (E-0082)
TalkMsg07AA_ThatDealerHowExpensive::
    ld de, $01c3
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, $01be
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $01bb
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $07aa ; '*: That dealer, how expensive! Nobody'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $07c0 ; '*: I dug deep in my'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $07d8 ; '*: I dug deep in my'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b043:
    ld hl, $0cf2 ; '*: That merchant, he was a'
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 3
; constant message(s) depending on story flags and state; the first one in the code is $07C1, whose
; string begins 'What? Monsters attacked you in the'; the branching is not interpreted (E-0097)
Talk07C1_WhatMonstersAttackedYou::
    ld de, $01c3
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, $01be
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $01bb
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, Script_6481
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $07c1 ; '*: What? Monsters attacked you in'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $07d9 ; '*: The thieving monsters had a'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b043:
    ld hl, $0cf3 ; '*: People say you can't judge'
    call StartMessageCommand09HL_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to
; TalkMsg07AE_ThatDealersWaresCould.call_start_message_command09_hl_b043; flag $01C0 set: jr to
; TalkMsg07AE_ThatDealersWaresCould.call_start_message_command09_hl_b042; flag $01BB set: jr to
; TalkMsg07AE_ThatDealersWaresCould.call_start_message_command09_hl_b04); when none of them
; branches, starts message $07AE through StartMessageCommand09HL_B04 (script command $09); that
; string begins 'That dealer's wares Could he sell' (E-0082)
TalkMsg07AE_ThatDealersWaresCould::
    ld de, $01c3
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, $01c0
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, $01bb
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $07ae ; '*: That dealer's wares Could he'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $07c2 ; '*: That dealer is a greedy'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $07db ; '*: That greedhound dealer scuttled off'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b043:
    ld hl, $0cf4 ; '*: That greedy hound of a'
    call StartMessageCommand09HL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 8
; constant message(s) depending on story flags and state; the first one in the code is $07AF, whose
; string begins 'How does this ornament look? Take'; the branching is not interpreted (E-0097)
Talk07AF_HowDoesThisOrnament::
    ld de, $01be
    call TestFlagBit
    jp c, .call_start_script_at_hl_b042
    ld de, $01bd
    call TestFlagBit
    jp c, .call_start_message_command09_hl_b04
    ld de, $01bb
    call TestFlagBit
    jp c, .call_start_script_at_hl_b04
    ld de, $01b1
    call TestFlagBit
    jr c, .call_test_flag_bit3
    ld de, $01b3
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld hl, $07af ; '*: How does this ornament look?'
    call StartMessageCommand09HL_B04
    ld de, $01b3
    call SetFlagBit
    ret

.call_test_flag_bit:
    ld de, $01b4
    call TestFlagBit
    jr c, .call_test_flag_bit2
    ld hl, $07b0 ; '*: How does this jewelry look?'
    call StartMessageCommand09HL_B04
    ld de, $01b4
    call SetFlagBit
    ret

.call_test_flag_bit2:
    ld de, $01b5
    call TestFlagBit
    jr c, .loop
    ld hl, $07b1 ; '*: How does this grand vase'
    call StartMessageCommand09HL_B04
    ld de, $01b5
    call SetFlagBit
    ret

.loop:
    ld hl, $07b2 ; '*: I've no use for the'
    call StartMessageCommand09HL_B04
    ret

.call_test_flag_bit3:
    ld de, $01b6
    call TestFlagBit
    jr c, .call_test_flag_bit4
    ld hl, $07b3 ; '*: How does this ornament look?'
    call StartMessageCommand09HL_B04
    ld de, $01b6
    call SetFlagBit
    ret

.call_test_flag_bit4:
    ld de, $01b7
    call TestFlagBit
    jr c, .call_test_flag_bit5
    ld hl, $07b4 ; '*: How does this jewelry look?'
    call StartMessageCommand09HL_B04
    ld de, $01b7
    call SetFlagBit
    ret

.call_test_flag_bit5:
    ld de, $01b8
    call TestFlagBit
    jr c, .call_test_flag_bit6
    ld hl, $07b5 ; '*: How does this grand vase'
    call StartMessageCommand09HL_B04
    ld de, $01b8
    call SetFlagBit
    ret

.call_test_flag_bit6:
    ld de, $01b9
    call TestFlagBit
    jr c, .loop
    ld hl, Script_648E
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_64BE
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $07c5 ; '*: You defeated the monsters You're'
    call StartMessageCommand09HL_B04
    ret

.call_start_script_at_hl_b042:
    ld hl, Script_64ED
    call StartScriptAtHL_B04
    ld a, [wStoryFlags + $68]
    set 0, a
    ld [wStoryFlags + $68], a
    ret

; tests story flags in turn (flag $01BA set: jr to
; TalkMsg07B8_WhoAreYou.call_start_message_command09_hl_b04); when none of them branches, starts
; message $07B8 through StartMessageCommand09HL_B04 (script command $09); that string begins 'Who
; are you? You shouldn't be' (E-0082)
TalkMsg07B8_WhoAreYou::
    ld de, $01ba
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $07b8 ; '*: Who are you? You shouldn't'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $07ba ; '*: What, not you again!'
    call StartMessageCommand09HL_B04
    ret

; map event: starts script $64A6 if story flag $1BA is set, else $6496 (E-0122)
; starts Script_6496: '*: You're going to regret seeing'
StartScript6496Or64A6ByFlag1BA::
    ld de, $01ba
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_6496
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_64A6
    call StartScriptAtHL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1
; constant message(s) depending on story flags and state; the first one in the code is $07BF, whose
; string begins '0 found the Pretty Ring. But'; the branching is not interpreted (E-0097)
Talk07BF_HeroFoundThePretty::
    call InventoryHasFreeSlotCheck
    jr c, .read_game_flags836
    ld hl, $07bf ; '0 found the Pretty Ring. But'
    call StartMessageCommand09HL_B04
    ret

.read_game_flags836:
    ld [hl], $3d
    ld a, [wGameFlags836]
    set 6, a
    ld [wGameFlags836], a
    ld hl, Script_64B3
    call StartScriptAtHL_B04
    ret

; map event: starts script $652C if story flag $1C2 is set, else $6509 (E-0122)
; starts Script_6509: '*: What is it, you little'
StartScript6509Or652CByFlag1C2::
    ld de, $01c2
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_6509
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_652C
    call StartScriptAtHL_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $0E, story
; flag $01C8 in DE: when the flag is clear it gives item $0E (DEFseed) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; Msg01C8_ThisIsAGreat)
VaseItem_DEFseed::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $0e
    ld [wScriptParam1], a
    ld de, $01c8
    call StartTreasureFlagDE_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $2C, story
; flag $01C9 in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; Msg01C9_ThisIsAGreat)
VaseItem_TinyMedal_Flag01C9::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2c
    ld [wScriptParam1], a
    ld de, $01c9
    call StartTreasureFlagDE_B04
    ret

; starts message $0CFB through StartMessageCommand09HL (script command $09); that string begins '0
; tried to open the chest. But' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case07_Sub01_Case4B)
TalkMsg0CFB_HeroTriedToOpenTheChest::
    ld hl, $0cfb ; '0 tried to open the chest.'
    call StartMessageCommand09HL_B04
    ret

; starts message $0CFA through StartMessageCommand09HL (script command $09); that string begins '0
; peered into the oven. A tantalizing' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case07_Sub01_Case4C)
TalkMsg0CFA_HeroPeeredIntoTheOvenA::
    ld hl, $0cfa ; '0 peered into the oven. A'
    call StartMessageCommand09HL_B04
    ret

; starts message $0CFC through StartMessageCommand09HL (script command $09); that string begins '0
; peered into the vase. Cold water' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case07_Sub01_Case4D)
TalkMsg0CFC_HeroPeeredIntoTheVaseCold::
    ld hl, $0cfc ; '0 peered into the vase. Cold'
    call StartMessageCommand09HL_B04
    ret

; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $04, story
; flag $01CA in DE: when the flag is clear it gives item $04 (Potion) and sets the flag (message $A3
; of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; DispatchTalkEvent_Case07_Sub01_Case4E)
VaseItem_Potion_Flag01CA::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $04
    ld [wScriptParam1], a
    ld de, $01ca
    call StartTreasureFlagDE_B04
    ret

; starts message $0CFD through StartMessageCommand09HL (script command $09); that string begins '0
; peered into the oven. Meat sizzled' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case07_Sub01_Case4F)
TalkMsg0CFD_HeroPeeredIntoTheOvenMeat::
    ld hl, $0cfd ; '0 peered into the oven. Meat'
    call StartMessageCommand09HL_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $08, story flag $01CB in DE: when the flag is clear it gives item $08 (Laurel) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg01CB_ThisIsAGreat)
ChestItem_Laurel::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $08
    ld [wScriptParam1], a
    ld de, $01cb
    call StartTreasureFlagDE_B04
    ret

; tests story flags in turn (flag $01C3 set: jr to TalkMsg0CFE.call_start_message_command09_hl_b04);
; when none of them branches, starts message $0CFE through StartMessageCommand09HL_B04 (script
; command $09); that string is empty (E-0082)
TalkMsg0CFE::
    ld de, $01c3
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0cfe ; '0 opened the treasure chest. It'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $00a1 ; '0 checked the treasure chest. But'
    call StartMessageCommand09HL_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $2A, story flag $01CC in DE: when the flag is clear it gives item $2A (ExitBell) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg01CC_ThisIsAGreat)
ChestItem_ExitBell_Flag01CC::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2a
    ld [wScriptParam1], a
    ld de, $01cc
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $2C, story flag $01CD in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was Msg01CD_ThisIsAGreat)
ChestItem_TinyMedal::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2c
    ld [wScriptParam1], a
    ld de, $01cd
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $23, story flag $01CE in DE: when the flag is clear it gives item $23 (Friend) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg01CE_ThisIsAGreat)
ChestItem_Friend::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $23
    ld [wScriptParam1], a
    ld de, $01ce
    call StartTreasureFlagDE_B04
    ret

; starts Script_6595 (StartScriptAtHL); its first message begins '0 checked the treasure chest. The'
; (E-0271; was DispatchTalkEvent_Case07_Sub01_Case55)
; starts Script_6595: '0 checked the treasure chest. The'
TalkScript6595_HeroCheckedTheTreasureChest::
    ld hl, Script_6595
    call StartScriptAtHL_B04
    ret

; starts message $0C03 through StartMessageCommand09HL (script command $09); that string begins 'The
; Tower's many treasures are heavily guarded' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case07_Sub01_Case60)
TalkMsg0C03_TheTowersManyTreasuresAre::
    ld hl, $0c03 ; '*: The Tower's many treasures are'
    call StartMessageCommand09HL_B04
    ret

; starts message $0C02 through StartMessageCommand09HL (script command $09); that string begins
; 'Only a handful of masters have made' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case07_Sub01_Case61)
TalkMsg0C02_OnlyAHandfulOfMastersHave::
    ld hl, $0c02 ; '*: Only a handful of masters'
    call StartMessageCommand09HL_B04
    ret

ElvenVillageTalkEvents_ShowThisIsThePower::
    ld de, $01d3
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0c00 ; '*: This is the Power Tower.'
    call StartMessageCommand09HL_B04
    ld de, $01d3
    call SetFlagBit
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0c01 ; '*: If you win, you'll earn'
    call StartMessageCommand09HL_B04
    ret

; starts Script_659C (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case07_Sub01_Case63)
; starts Script_659C
TalkScript659C::
    ld hl, Script_659C
    call StartScriptAtHL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1
; constant message(s) depending on story flags and state; the first one in the code is $0C17, an
; empty string on the normal path; the branching is not interpreted (E-0097)
; starts Script_659C
Talk0C17::
    ld de, $016e
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, Script_659C
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0c17 ; '*: You've conquered the Power Tower.'
    call StartMessageCommand09HL_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $2C, story flag $01D5 in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was Msg01D5)
ChestItem_TinyMedal_Flag01D5::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2c
    ld [wScriptParam1], a
    ld de, $01d5
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $48, story flag $01D6 in DE: when the flag is clear it gives item $48 (AGL) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg01D6)
ChestItem_AGL_Flag01D6::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $48
    ld [wScriptParam1], a
    ld de, $01d6
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $0A, story flag $01D8 in DE: when the flag is clear it gives item $0A (SkyBell) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg01D8)
ChestItem_SkyBell::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $0a
    ld [wScriptParam1], a
    ld de, $01d8
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $01, story flag $01DA in DE: when the flag is clear it gives item $01 (Herb) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg01DA)
ChestItem_Herb::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $01da
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $51, story flag $01DB in DE: when the flag is clear it gives item $51 (OrcaCape) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg01DB)
ChestItem_OrcaCape_Flag01DB::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $51
    ld [wScriptParam1], a
    ld de, $01db
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $02, story flag $01DC in DE: when the flag is clear it gives item $02 (LoveWater) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was Msg01DC)
ChestItem_LoveWater_Flag01DC::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $02
    ld [wScriptParam1], a
    ld de, $01dc
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $02, story flag $01DE in DE: when the flag is clear it gives item $02 (LoveWater) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was Msg01DE)
ChestItem_LoveWater_Flag01DE::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $02
    ld [wScriptParam1], a
    ld de, $01de
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $44, story flag $01DF in DE: when the flag is clear it gives item $44 (StoneFang) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was Msg01DF)
ChestItem_StoneFang::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $44
    ld [wScriptParam1], a
    ld de, $01df
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $01, story flag $0169 in DE: when the flag is clear it gives item $01 (Herb) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg0169_WereWorriedAboutThe)
ChestItem_Herb_Flag0169::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $0169
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $02, story flag $016B in DE: when the flag is clear it gives item $02 (LoveWater) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was Msg016B_TheKingIsSo)
ChestItem_LoveWater_Flag016B::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $02
    ld [wScriptParam1], a
    ld de, $016b
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $5F, story flag $016C in DE: when the flag is clear it gives item $5F (Sailor) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg016C_SoHaveYouDiscovered)
ChestItem_Sailor::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5f
    ld [wScriptParam1], a
    ld de, $016c
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $4E, story flag $016D in DE: when the flag is clear it gives item $4E (SilvrCape) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was Msg016D_KingTheCanalIs)
ChestItem_SilvrCape::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $4e
    ld [wScriptParam1], a
    ld de, $016d
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $4C, story flag $016F in DE: when the flag is clear it gives item $4C (MagicCape) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was Msg016F_KingWhatNeverMind)
ChestItem_MagicCape::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $4c
    ld [wScriptParam1], a
    ld de, $016f
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $4D, story flag $0170 in DE: when the flag is clear it gives item $4D (DracoCape) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was Msg0170_IFeelBadlyFor)
ChestItem_DracoCape::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $4d
    ld [wScriptParam1], a
    ld de, $0170
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $01, story flag $0171 in DE: when the flag is clear it gives item $01 (Herb) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg0171_WhatOpenTheCanal)
ChestItem_Herb_Flag0171::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $0171
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $2C, story flag $0172 in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was Msg0172_KingArrghIKnow)
ChestItem_TinyMedal_Flag0172::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2c
    ld [wScriptParam1], a
    ld de, $0172
    call StartTreasureFlagDE_B04
    ret

; starts Script_659E (StartScriptAtHL); its first message begins '0 checked the treasure chest. It'
; (E-0271; was DispatchTalkEvent_Case07_Sub01_Case78)
; starts Script_659E: '0 checked the treasure chest. It'
TalkScript659E_HeroCheckedTheTreasureChest::
    ld hl, Script_659E
    call StartScriptAtHL_B04
    ret

; starts message $0C1B through StartMessageCommand09HL (script command $09); that string begins
; 'It's not that easy to win here' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case07_Sub01_Case80)
TalkMsg0C1B_ItsNotThatEasyToWin::
    ld hl, $0c1b ; '*: It's not that easy to'
    call StartMessageCommand09HL_B04
    ret

; starts message $0C1A through StartMessageCommand09HL (script command $09); that string begins 'In
; this Tower, your opponents come at' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case07_Sub01_Case81)
TalkMsg0C1A_InThisTowerYourOpponents::
    ld hl, $0c1a ; '*: In this Tower, your opponents'
    call StartMessageCommand09HL_B04
    ret

ElvenVillageTalkEvents_ShowThisIsTheBaffle::
    ld de, $0173
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0c18 ; '*: This is the Baffle Tower.'
    call StartMessageCommand09HL_B04
    ld de, $0173
    call SetFlagBit
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0c19 ; '*: If you win, you'll earn'
    call StartMessageCommand09HL_B04
    ret

; starts Script_659C (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case07_Sub01_Case83)
; starts Script_659C
TalkScript659C_0478A5::
    ld hl, Script_659C
    call StartScriptAtHL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1
; constant message(s) depending on story flags and state; the first one in the code is $0C2F, an
; empty string on the normal path; the branching is not interpreted (E-0097)
; starts Script_659C
Talk0C2F::
    ld de, $00d9
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, Script_659C
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0c2f ; '*: You've conquered the Baffle Tower.'
    call StartMessageCommand09HL_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $0A, story flag $0175 in DE: when the flag is clear it gives item $0A (SkyBell) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg0175_ImMakingANew)
ChestItem_SkyBell_Flag0175::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $0a
    ld [wScriptParam1], a
    ld de, $0175
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $4A, story flag $0176 in DE: when the flag is clear it gives item $4A (Smart) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg0176_GaahYoureTooStrong)
ChestItem_Smart::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $4a
    ld [wScriptParam1], a
    ld de, $0176
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $2A, story flag $0177 in DE: when the flag is clear it gives item $2A (ExitBell) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg0177_KingWhatSoThats)
ChestItem_ExitBell_Flag0177::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2a
    ld [wScriptParam1], a
    ld de, $0177
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $01, story flag $0179 in DE: when the flag is clear it gives item $01 (Herb) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg0179_KingThisShouldSolve)
ChestItem_Herb_Flag0179::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $0179
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $09, story flag $017A in DE: when the flag is clear it gives item $09 (AwakeSand) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was Msg017A_OhYouSayThat)
ChestItem_AwakeSand::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $09
    ld [wScriptParam1], a
    ld de, $017a
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $61, story flag $017B in DE: when the flag is clear it gives item $61 (Cleric) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg017B_TheWellHasAmple)
ChestItem_Cleric::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $61
    ld [wScriptParam1], a
    ld de, $017b
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $2A, story flag $017D in DE: when the flag is clear it gives item $2A (ExitBell) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg017D_HiDidYouHear)
ChestItem_ExitBell_Flag017D::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2a
    ld [wScriptParam1], a
    ld de, $017d
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $52, story flag $017E in DE: when the flag is clear it gives item $52 (BraveCape) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was Msg017E_TheKingSolvedOur)
ChestItem_BraveCape::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $52
    ld [wScriptParam1], a
    ld de, $017e
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $07, story flag $017F in DE: when the flag is clear it gives item $07 (MoonHerb) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg017F_OurKingWorkedTo)
ChestItem_MoonHerb::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $07
    ld [wScriptParam1], a
    ld de, $017f
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $46, story flag $00D6 in DE: when the flag is clear it gives item $46 (MermScale) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was Msg00D6_IllShowYouHow)
ChestItem_MermScale_Flag00D6::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $46
    ld [wScriptParam1], a
    ld de, $00d6
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $02, story flag $00D7 in DE: when the flag is clear it gives item $02 (LoveWater) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was Msg00D7_HmMyRivalIs)
ChestItem_LoveWater_Flag00D7::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $02
    ld [wScriptParam1], a
    ld de, $00d7
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $60, story flag $00D8 in DE: when the flag is clear it gives item $60 (Thief) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg00D8_FinallySomeoneToIgnite)
ChestItem_Thief::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $60
    ld [wScriptParam1], a
    ld de, $00d8
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $01, story flag $00DA in DE: when the flag is clear it gives item $01 (Herb) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg00DA_YouHaveRaisedYour)
ChestItem_Herb_Flag00DA::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $00da
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $4F, story flag $00DB in DE: when the flag is clear it gives item $4F (GoldCape) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg00DB_WhatHowDidYou)
ChestItem_GoldCape::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $4f
    ld [wScriptParam1], a
    ld de, $00db
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $5D, story flag $00DC in DE: when the flag is clear it gives item $5D (Mage) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg00DC_AllThoseWhoStood)
ChestItem_Mage::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5d
    ld [wScriptParam1], a
    ld de, $00dc
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $06, story flag $00DD in DE: when the flag is clear it gives item $06 (Antidote) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg00DD_LetMeShowYou)
ChestItem_Antidote::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $06
    ld [wScriptParam1], a
    ld de, $00dd
    call StartTreasureFlagDE_B04
    ret

; starts message $0C33 through StartMessageCommand09HL (script command $09); that string begins
; 'It's brutal up ahead. I wouldn't push' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case07_Sub01_CaseA0)
TalkMsg0C33_ItsBrutalUpAheadIWouldnt::
    ld hl, $0c33 ; '*: It's brutal up ahead. I'
    call StartMessageCommand09HL_B04
    ret

; starts message $0C32 through StartMessageCommand09HL (script command $09); that string begins 'The
; monsters here are awful. I'm losing' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case07_Sub01_CaseA1)
TalkMsg0C32_TheMonstersHereAreAwfulIm::
    ld hl, $0c32 ; '*: The monsters here are awful.'
    call StartMessageCommand09HL_B04
    ret

ElvenVillageTalkEvents_ShowIfYouveMadeIt::
    ld de, $00de
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0c30 ; '*: If you've made it to'
    call StartMessageCommand09HL_B04
    ld de, $00de
    call SetFlagBit
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0c31 ; '*: This Tower is terribly tough.'
    call StartMessageCommand09HL_B04
    ret

; starts Script_659C (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case07_Sub01_CaseA3)
; starts Script_659C
TalkScript659C_0479FC::
    ld hl, Script_659C
    call StartScriptAtHL_B04
    ret

; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1
; constant message(s) depending on story flags and state; the first one in the code is $0C47, an
; empty string on the normal path; the branching is not interpreted (E-0097)
; starts Script_659C
Talk0C47::
    ld de, $01f6
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, Script_659C
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0c47 ; '*: You've conquered the Soul Tower.'
    call StartMessageCommand09HL_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $2A, story flag $00F5 in DE: when the flag is clear it gives item $2A (ExitBell) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg00F5_ItIsAnItem)
ChestItem_ExitBell_Flag00F5::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2a
    ld [wScriptParam1], a
    ld de, $00f5
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $5C, story flag $00F6 in DE: when the flag is clear it gives item $5C (War) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg00F6_HelloWhatCanI)
ChestItem_War_Flag00F6::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5c
    ld [wScriptParam1], a
    ld de, $00f6
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $03, story flag $00F7 in DE: when the flag is clear it gives item $03 (WorldDew) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg00F7_HelloWhatCanI)
ChestItem_WorldDew_Flag00F7::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $03
    ld [wScriptParam1], a
    ld de, $00f7
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $2C, story flag $00F9 in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was Msg00F9_HelloWhatCanI)
ChestItem_TinyMedal_Flag00F9::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2c
    ld [wScriptParam1], a
    ld de, $00f9
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $45, story flag $00FA in DE: when the flag is clear it gives item $45 (SteelFang) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was Msg00FA_HelloWhatCanI)
ChestItem_SteelFang::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $45
    ld [wScriptParam1], a
    ld de, $00fa
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $47, story flag $00FB in DE: when the flag is clear it gives item $47 (DrakScale) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was Msg00FB_THEEND)
ChestItem_DrakScale::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $47
    ld [wScriptParam1], a
    ld de, $00fb
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $5A, story flag $00FD in DE: when the flag is clear it gives item $5A (Life) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg00FD_HeyThatsMine0)
ChestItem_Life::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5a
    ld [wScriptParam1], a
    ld de, $00fd
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $5B, story flag $00FE in DE: when the flag is clear it gives item $5B (Divine) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg00FE_TerryHereJustTake)
ChestItem_Divine::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5b
    ld [wScriptParam1], a
    ld de, $00fe
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $01, story flag $00FF in DE: when the flag is clear it gives item $01 (Herb) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg00FF_Composing)
ChestItem_Herb_Flag00FF::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $00ff
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $50, story flag $01F3 in DE: when the flag is clear it gives item $50 (PltnmCape) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was Msg01F3)
ChestItem_PltnmCape::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $50
    ld [wScriptParam1], a
    ld de, $01f3
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $4B, story flag $01F4 in DE: when the flag is clear it gives item $4B (Wise) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg01F4)
ChestItem_Wise::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $4b
    ld [wScriptParam1], a
    ld de, $01f4
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $2A, story flag $01F5 in DE: when the flag is clear it gives item $2A (ExitBell) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg01F5)
ChestItem_ExitBell_Flag01F5::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2a
    ld [wScriptParam1], a
    ld de, $01f5
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $01, story flag $01F7 in DE: when the flag is clear it gives item $01 (Herb) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg01F7)
ChestItem_Herb_Flag01F7::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $01f7
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $5E, story flag $01F8 in DE: when the flag is clear it gives item $5E (Fight) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg01F8)
ChestItem_Fight::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5e
    ld [wScriptParam1], a
    ld de, $01f8
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $49, story flag $01F9 in DE: when the flag is clear it gives item $49 (Starry) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; Msg01F9)
ChestItem_Starry::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $49
    ld [wScriptParam1], a
    ld de, $01f9
    call StartTreasureFlagDE_B04
    ret

; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $02, story flag $01FA in DE: when the flag is clear it gives item $02 (LoveWater) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was Msg01FA)
ChestItem_LoveWater_Flag01FA::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $02
    ld [wScriptParam1], a
    ld de, $01fa
    call StartTreasureFlagDE_B04
    ret

; talk category 9: the key-world events (Warubou's messages, KeyWorldBossBattle,
; KeyWorldFloorBattle; E-0286)
KeyWorldTalkEvents::
    ld a, [wTalkEventGroup]
    jumptable
    dw TalkScript5133
    dw KeyWorldTalkEvents_StartScriptAtHL_B04
    dw KeyWorldTalkEvents_StartScriptAtHL_B04_Case02
    dw TalkScript5135
    dw TalkMsg0120_WarubouQuitDawdlingWarooh
    dw TalkMsg0122_WarubouWaheyYouDidItHero
    dw KeyWorldTalkEvents_ShowWarubouUseAMagic
    dw TalkScript65AA_WarubouWaheyYouDidItHero
    dw TalkScript65B8_WarubouWaheySoThisIsIt

; starts Script_5133 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case09_Sub01_Case00)
; starts Script_5133
TalkScript5133::
    ld hl, Script_5133
    call StartScriptAtHL_B04
    ret

KeyWorldTalkEvents_StartScriptAtHL_B04::
    ld a, $10
    ld [wDataBank], a
    ld a, [wKeyWorldFloor]
    add a
    add a
    push af
    ld hl, wKeyWorldFloorInfo + $1
    add_a_to_hl
    ld a, [hl]
    cp $03
    jr nz, .restore
    pop af
    ld a, $0f
    ld [wScreenTableIndex], a
    ld hl, Script_65A3
    call StartScriptAtHL_B04
    ret

.restore:
    pop af
    add a
    ld hl, wKeyWorldFloorState
    ld a, $12
    bit 7, [hl]
    jr z, .set_screen_table_index
    ld a, $13

.set_screen_table_index:
    ld [wScreenTableIndex], a
    ld hl, Script_65A3
    call StartScriptAtHL_B04
    ret

; starts Script_65AA: 'Warubou: Wa-hey! You did it, 0!'
KeyWorldTalkEvents_StartScriptAtHL_B04_Case02::
    ld a, [wMapType]
    cp $84
    jr nz, .call_is_player_at_key_world_goal_kind_trigger
    ld hl, Script_65AA
    call StartScriptAtHL_B04
    jr .check_player_facing

.call_is_player_at_key_world_goal_kind_trigger:
    call IsPlayerAtKeyWorldGoalKindTriggerColumn
    or a
    ret z
    ld hl, Script_65B1
    call StartScriptAtHL_B04

.check_player_facing:
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and $03
    ld [wSpriteSlots + $7], a
    ld a, $10
    ld [wDataBank], a
    ret

; A = 1 when the player stands on one of the trigger columns for wKeyWorldGoalKind (1, 7, 8 or 9) on
; the matching map screen, else 0 (E-0127)
IsPlayerAtKeyWorldGoalKindTriggerColumn::
    ld a, [wKeyWorldGoalKind]
    cp $01
    jr nz, .cp_07
    ldh a, [hMapScreenX]
    or a
    jr nz, .return_0
    ldh a, [hPlayerX]
    cp $40
    jr z, .return_01
    cp $20
    jr z, .return_01
    jr .return_0

.cp_07:
    cp $07
    jr nz, .cp_08
    ldh a, [hMapScreenX]
    or a
    jr nz, .return_0
    ldh a, [hPlayerX]
    cp $40
    jr z, .return_01
    jr .return_0

.cp_08:
    cp $08
    jr nz, .cp_09
    ldh a, [hMapScreenX]
    or a
    jr nz, .return_0
    ldh a, [hPlayerX]
    cp $10
    jr z, .return_01
    cp $30
    jr z, .return_01
    jr .return_0

.cp_09:
    cp $09
    jr nz, .return_0
    ldh a, [hMapScreenX]
    or a
    jr z, .return_0

.return_01:
    ld a, $01
    ret

.return_0:
    xor a
    ret

; starts Script_5135 (StartScriptAtHL) (E-0271; was DispatchTalkEvent_Case09_Sub01_Case03)
; starts Script_5135
TalkScript5135::
    ld hl, Script_5135
    call StartScriptAtHL_B04
    ret

; starts message $0120 through StartMessageCommand09HL (script command $09); that string begins
; 'Warubou Quit dawdling, warooh!' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case09_Sub01_Case04)
TalkMsg0120_WarubouQuitDawdlingWarooh::
    ld hl, $0120 ; 'Warubou: Quit dawdling, warooh!'
    call StartMessageCommand09HL_B04
    ret

; starts message $0122 through StartMessageCommand09HL (script command $09); that string begins
; 'Warubou Wa-hey! You did it, 0! I'll' (E-0268, the E-0082 shape; was
; DispatchTalkEvent_Case09_Sub01_Case05)
TalkMsg0122_WarubouWaheyYouDidItHero::
    ld hl, $0122 ; 'Warubou: Wa-hey! You did it, 0!'
    call StartMessageCommand09HL_B04
    ret

KeyWorldTalkEvents_ShowWarubouUseAMagic::
    ld a, [wKeyWorldGoalKind]
    cp $05
    ret z
    cp $07
    ret z
    cp $08
    ret z
    ld hl, $0121 ; 'Warubou: Use a Magic Key and'
    call StartMessageCommand09HL_B04
    ret

; sets wDataBank = $10, then starts Script_65AA (StartScriptAtHL); its first message begins 'Warubou
; Wa-hey! You did it, 0!' (E-0271; was DispatchTalkEvent_Case09_Sub01_Case07)
; starts Script_65AA: 'Warubou: Wa-hey! You did it, 0!'
TalkScript65AA_WarubouWaheyYouDidItHero::
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_65AA
    call StartScriptAtHL_B04
    ret

; sets wDataBank = $1F, then starts Script_65B8 (StartScriptAtHL); its first message begins 'Warubou
; Wa-hey! So, this is it?' (E-0271; was DispatchTalkEvent_Case09_Sub01_Case08)
; starts Script_65B8: 'Warubou: Wa-hey! So, this is it?'
TalkScript65B8_WarubouWaheySoThisIsIt::
    ld a, $1f
    ld [wDataBank], a
    ld hl, Script_65B8
    call StartScriptAtHL_B04
    ret

; A = 0 unless wInventory + $17 is $FF or 0; then scans wInventory for an empty slot ($FF or 0) and
; returns carry (E-0124)
InventoryHasFreeSlotCheck::
    ld a, [wInventory + $17]
    cp $ff
    jr z, .skip
    or a
    jr z, .skip
    sub a
    ret

.skip:
    ld hl, wInventory

.skip2:
    ld a, [hl]
    cp $ff
    jr z, .return_carry
    or a
    jr z, .return_carry
    inc hl
    jr .skip2

.return_carry:
    scf
    ret
    ds $3ad, $00
