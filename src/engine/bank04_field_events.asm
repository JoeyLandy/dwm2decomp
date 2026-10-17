; ROM bank $04: field events: chests, vases and barrels, key-world events, Yold talk
; The annotated listing of this bank is build/listing/bank04.asm.

SECTION "Bank 04", ROMX
    db $04

; The sprite work shared by the field states: AdvancePlayerAnimCounterAndRunPlayerSpriteMode (the
; player animation counter, then the player and follower sprites for hPlayerSpriteMode) and
; UpdateAndDrawSpriteSlots (moves and draws the map objects). Far-called seven times from bank $02,
; among them FieldState_WalkATalks, FieldState_RunScript and FieldState_Still. (C1, E-0374)
; runs AdvancePlayerAnimCounterAndRunPlayerSpriteMode and UpdateAndDrawSpriteSlots; shared by the
; field mode states (E-0122)
FieldStateCommonUpdate:: ; configured code entry (E-0395 (FieldStateCommonUpdate: found only by the $4001 fall-through guess, which a new entry later in the bank can change; listed so it stays traced)); C0
    call AdvancePlayerAnimCounterAndRunPlayerSpriteMode
    call UpdateAndDrawSpriteSlots
    ret

SECTION "Bank 04 RestoreSpriteSnapshot", ROMX

; When wSaveStateFlag bit 7 is set: clears wSaveStateFlag, sets wSpriteSlotCount =
; wSpriteSnapshotCount and copies the $50 bytes at wSpriteSnapshot to wSpriteSlots (the first five
; 16-byte slots), undoing SnapshotSpritesForSave; otherwise does nothing. LoadMapObjectsForScreen
; calls it after SetupKeyWorldObjectsForMapType on a special map, and again at line 275 of bank $69.
; (C2, E-0374)
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

SECTION "Bank 04 SetupKeyWorldObjectsForMapType", ROMX

; Called by LoadMapObjectsForScreen on a special map (wMapType bit 7). Clears wKeyWorldObjFlag and,
; by wMapType & 7, picks an entry of KeyWorldObjectGridTable and the source of the object graphics
; in hTemp9 (0 the list, 1 wKeyWorldEncounter, 2 the floor entry of wKeyWorldEncounterTable) for
; SetupKeyWorldObjectsForMapType_LoadObjects. Type 3: the floor byte wKeyWorldFloorInfo + 1 + 4 *
; wKeyWorldFloor picks entry byte - 1 (byte 2 or 3 moves to entry 9 or 10 when the floor state byte
; has bit 7 set, and byte 2 sets wKeyWorldObjFlag, which then runs
; SetupKeyWorldObjectsForMapType_PlaceFirstSlot); byte 6 uses entry 5 with hTemp9 = 1, or clears
; wSpriteSlotCount when wKeyWorldFlags bit 7 is set. Type 4: entry 3, or 7 for goal kind 7. Type 6:
; entry 4 with hTemp9 = 1 unless floor state byte 3 is $FF or odd or wKeyWorldFlags bit 7 is set
; (then no objects). Type 2: entry 6 with hTemp9 = 2 only when the floor encounter byte 3 and
; wKeyWorldSetting are 0, else no objects. Other types return. (C1, E-0374)
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
    call SetupKeyWorldObjectsForMapType_LoadObjects
    ld a, [wKeyWorldObjFlag]
    or a
    ret z
    call SetupKeyWorldObjectsForMapType_PlaceFirstSlot
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
    call SetupKeyWorldObjectsForMapType_LoadObjects
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
    call SetupKeyWorldObjectsForMapType_LoadObjects
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
    ld a, [wKeyWorldSetting]
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
    call SetupKeyWorldObjectsForMapType_LoadObjects
    ret

SECTION "Bank 04 SetupKeyWorldObjectsForMapType_LoadObjects", ROMX

; Loads the objects of the current key-world screen into the sprite slots: from the floor's table of
; per-screen pointers (indexed by hMapScreenY * width + hMapScreenX), the screen's object list gives
; the slot count and, per object, its type, position and graphics; monster objects take their
; species from the key world's encounter (wKeyWorldEncounter, or the floor's entry in
; wKeyWorldEncounterTable), and goal objects their graphics from KeyWorldGoalGraphicsTable by
; wKeyWorldGoalKind. A screen with no list ($0000) keeps its objects; an $FFFF list clears them.
; (C1, E-0357)
SetupKeyWorldObjectsForMapType_LoadObjects::
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

SECTION "Bank 04 KeyWorldGoalGraphicsTable", ROMX

; SetupKeyWorldObjectsForMapType_LoadObjects, for an object whose graphics number (hTemp0) is below
; 9 and whose hTemp2 is non-zero, replaces it with the byte at $423D + 16 * hTemp0 +
; wKeyWorldGoalKind; 9 rows end at the code at $42CD (E-0221, C1)
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

; Positions sprite slot 0 for the goal kind (wKeyWorldGoalKind) on the top screen row: returns
; unless hMapScreenY is 0. On screen (0, 0) sets OBJ_Y = $20 and, for kind 1 or 7, OBJ_X = $20 and
; OBJ_STATE = 1, for kind 8 OBJ_X = $30 and OBJ_STATE = 0. On any other screen of row 0 and kind 9
; sets OBJ_X = $70, OBJ_Y = $10, OBJ_STATE = 3. SetupKeyWorldObjectsForMapType calls it after
; loading the objects when wKeyWorldObjFlag is set (map type 3, floor byte 2). (C2, E-0374)
; on map screen (0, 0) or (1, 0) sets wSpriteSlots + $B/wSpriteSlots + $C and wSpriteSlots + $7 for
; wKeyWorldGoalKind values 1, 7, 8 or 9 (E-0125)
SetupKeyWorldObjectsForMapType_PlaceFirstSlot::
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

SECTION "Bank 04 DecompressGraphicsTemp0ToTemp4", ROMX

; hTemp0/1 is a little-endian graphics id, hTemp4/5 the VRAM destination and hTemp3 the object
; palette slot. With hTemp2=0, index the three-byte MonsterSpriteTable by 3*id for pointer/bank;
; otherwise index FieldSpriteGraphicsTable by 2*id and use bank $7D when the low id byte is below
; $50, else $7E. Decompress the selected stream. On CGB, monster palette address is $27:$7328 + 8*id
; with 16-bit wrap; field palette uses FieldSpritePaletteIndex indexed only by the low id byte and
; an eight-bit 8*palette-index offset into FieldSpritePalettes. Copy eight bytes to slot offset
; (8*hTemp3 modulo 256). No id/slot bounds check or upload request is made here. (C1, E-0362)
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
    add LOW(MonsterSpritePalettes)
    ld l, a
    ld a, h
    adc HIGH(MonsterSpritePalettes)
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
    ld de, FieldSpritePalettes
    ASSERT BANK(FieldSpritePalettes) == $7E, "FieldSpritePalettes is read with bank $7E mapped"
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

SECTION "Bank 04 FieldSpriteGraphicsTable", ROMX

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

; Sets bit 1 of hPlayerStateFlags and of OBJ_FLAGS of sprite slots 0-4 (wSpriteSlots and
; wObject1-wObject4), keeping their other bits. Bit 1 stops the player animation counter
; (AdvancePlayerAnimCounterAndRunPlayerSpriteMode) and the slot timers and moves of
; UpdateSpriteSlots, so the field stands still; scenes, shops and field menus in eleven places
; far-call it, and ResumeFieldAnimation undoes it. (C2, E-0374)
; sets bit 1 of hPlayerStateFlags and of the flag byte (wSpriteSlots + $D + 16 * n) of object
; entries 0-4 (the counterpart of ResumeFieldAnimation; RunMessageBox calls them around a message)
; (E-0120)
FreezeFieldAnimation::
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

SECTION "Bank 04 ResumeFieldAnimation", ROMX

; Clears bit 1 of hPlayerStateFlags and of OBJ_FLAGS of sprite slots 0-4 (wSpriteSlots and
; wObject1-wObject4), keeping their other bits, so the player animation counter and the object
; timers run again; the counterpart of FreezeFieldAnimation, far-called by fifteen scenes and menus.
; (C2, E-0374)
; clears bit 1 of hPlayerStateFlags and of the flag byte (wSpriteSlots + $D + 16 * n) of object
; entries 0-4 (E-0072)
ResumeFieldAnimation::
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

SECTION "Bank 04 UpdateAndDrawSpriteSlots", ROMX

; Returns at once when wFieldActionRequest bit 7 is set or wSpriteSlotCount is 0. Otherwise runs
; UpdateSpriteSlots, then draws each of the wSpriteSlotCount 16-byte slots: hSpriteAttrXor =
; OBJ_ATTR & 7, hSpriteTileOffset = OBJ_TILE_OFFSET, origin X = OBJ_X + 8 + hScrollX and Y = OBJ_Y +
; 16 + hScrollY (16-bit with the high bytes), hSpriteSubIndex = OBJ_SUBINDEX with bit 7 turned into
; the flip bit $20. With OBJ_SET_MODE 0 the set is OBJ_SPRITE_ID & $7F drawn by
; DrawMetaSpriteSet_Bank27 (high byte non-zero), DrawMetaSpriteSet_Bank26 (low bit 7) or
; DrawMetaSpriteSet_Bank25; otherwise the set is the OBJ_SPRITE_ID low byte drawn by
; DrawMetaSprite_Sets98. Called by FieldStateCommonUpdate and four screens in banks $14, $24, $F1
; and $F2. (C1, E-0374)
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
    farcall DrawMetaSprite_Sets98

.restore:
    pop bc
    pop hl
    ld a, $10
    add_a_to_hl
    dec b
    jp nz, .loop
    ret

SECTION "Bank 04 UpdateSpriteSlots", ROMX

; Runs the update of each of the wSpriteSlotCount 16-byte slots from wSpriteSlots: B = count, HL =
; wSpriteSlots, then falls into UpdateSpriteSlots_RunSlot, which dispatches on slot byte 0 (0 still,
; 1 no handler, 2 wander left and right, 3 wander in four directions, 4 and 5 frame sequences). A
; count of 0 is not checked here (it would run 256 slots); its caller UpdateAndDrawSpriteSlots
; returns first in that case. (C2, E-0374)
; for each of wSpriteSlotCount 16-byte slots at wSpriteSlots runs the routine for its type byte
; (jump table of six) (E-0124)
UpdateSpriteSlots::
    ld a, [wSpriteSlotCount]
    ld b, a
    ld hl, wSpriteSlots

; The loop over the sprite slots: runs the routine for each 16-byte slot's type byte (types 0-5).
; (C2, E-0357; probed E-0374)
UpdateSpriteSlots_RunSlot::
    push bc
    push hl
    push hl
    ld a, [hl]
    jumptable
    dw UpdateSpriteSlots_Still
    dw UpdateSpriteSlots_NoHandler
    dw UpdateSpriteSlots_Wander
    dw UpdateSpriteSlots_WanderFourWays
    dw UpdateSpriteSlots_FrameLoopType4
    dw UpdateSpriteSlots_FrameLoopType5

; Moves to the next sprite slot (16 bytes on) and continues the loop. (C2, E-0357; probed E-0374)
UpdateSpriteSlots_NextSlot::
    pop hl
    pop bc
    ld a, $10
    add_a_to_hl
    dec b
    jr nz, UpdateSpriteSlots_RunSlot
    ret

SECTION "Bank 04 UpdateSpriteSlots_Still", ROMX

; Sprite slot type 0, a still object: unless its flags (slot byte $0D) have bit 1 set, counts its
; animation timer up; then picks its animation frame. (C2, E-0357; probed E-0374)
UpdateSpriteSlots_Still::
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

; A = the slot's timer (slot byte 9), HL = slot + 9: picks the animation frame bit, bit 3 of the
; timer when flag bit 2 (slot byte $0D) is set, otherwise bit 5; stores slot byte $0E = $82 + that
; bit when slot byte 7 is 3, otherwise byte 7 * 2 + that bit. Then moves to the next slot (pops the
; loop's HL and BC, HL += $10) and continues UpdateSpriteSlots_RunSlot. Types 0 (by fallthrough), 2
; and 3 end here. (C2, E-0369; probed E-0374)
UpdateSpriteSlots_PickFrame::
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
    jr nz, UpdateSpriteSlots_RunSlot
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
    jp nz, UpdateSpriteSlots_RunSlot
    ret

SECTION "Bank 04 UpdateSpriteSlots_Wander", ROMX

; Sprite slot type 2, an object that wanders left and right. Unless OBJ_FLAGS bit 1 is set it counts
; its timer (slot byte 9). While a move runs (move byte $A bit 7) it steps one pixel, left (OBJ_X -
; 1, OBJ_STATE 3) or right with bit 6 (OBJ_X + 1, OBJ_STATE 1); after 16 steps the move byte is 0
; and OBJ_FLAGS bit 2 is cleared. Otherwise, when no script runs (wScriptRunning) and the timer is
; $70, it resets the timer and takes NextTableByte: wRandomLo & 3 = 3 tries right (move byte $C0;
; not at OBJ_X $90 or $20 right of its home X, slot byte 4), 1 tries left ($80; not at 0 or $20 left
; of home), 0 and 2 wait; the target must not be blocking (IsTileUnderCellBlocking) or taken by the
; party (IsCellOccupiedByParty). Then UpdateSpriteSlots_PickFrame. The OR 4 meant for the flags
; lands on slot byte $E, which UpdateSpriteSlots_PickFrame overwrites. (C2, E-0374)
UpdateSpriteSlots_Wander::
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
    call IsCellOccupiedByParty
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
    call IsCellOccupiedByParty
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
    jp UpdateSpriteSlots_PickFrame

SECTION "Bank 04 UpdateSpriteSlots_NoHandler", ROMX

; Sprite slot type 1: a bare ret. UpdateSpriteSlots_RunSlot pushes BC and the slot pointer twice
; before the jump table (rst $00 consumes its own return address), so this ret would jump to the
; slot's own address in wSpriteSlots instead of returning to the loop. (C2, E-0369; probed E-0375)
UpdateSpriteSlots_NoHandler::
    ret

SECTION "Bank 04 UpdateSpriteSlots_WanderFourWays", ROMX

; Sprite slot type 3, an object that wanders in four directions. Unless OBJ_FLAGS bit 1 is set it
; counts its timer (slot byte 9). While a move runs (move byte $A bit 7) it steps one pixel in the
; direction in bits 5-6: 0 down (OBJ_Y + 1), 1 right (OBJ_X + 1), 2 up (OBJ_Y - 1), 3 left (OBJ_X -
; 1), with OBJ_STATE = that direction; after 16 steps the move byte is 0 and OBJ_FLAGS bit 2 is
; cleared. Otherwise, when no script runs and the timer is $E0, it resets the timer and picks the
; direction from NextTableByte (wRandomLo & 3), refusing at OBJ_Y $80 (down), OBJ_X $90 (right),
; OBJ_Y 0 (up) or OBJ_X 0 (left), on a blocked cell (IsCellBlockedByFieldEventKind) or one taken by
; the party (IsCellOccupiedByParty); a move byte $80, $A0, $C0 or $E0 starts it. Then
; UpdateSpriteSlots_PickFrame. (C2, E-0374)
UpdateSpriteSlots_WanderFourWays::
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
    call IsCellBlockedByFieldEventKind
    cp $01
    jp z, .restore2
    call IsCellOccupiedByParty
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
    call IsCellBlockedByFieldEventKind
    cp $01
    jr z, .restore2
    call IsCellOccupiedByParty
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
    call IsCellBlockedByFieldEventKind
    cp $01
    jr z, .restore2
    call IsCellOccupiedByParty
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
    call IsCellBlockedByFieldEventKind
    cp $01
    jr z, .restore2
    call IsCellOccupiedByParty
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
    jp UpdateSpriteSlots_PickFrame

SECTION "Bank 04 IsCellBlockedByFieldEventKind", ROMX

; B = pixel X, C = pixel Y: the blocked-cell test of the four-way wandering objects
; (UpdateSpriteSlots_WanderFourWays). While the pending field event kind (wPendingFieldEvent & $0F)
; is $0A it returns IsCellBlockedByFieldEventKind_IsCellTall (A = 1 when all four tiles under the
; cell are above wMapTallTileMin), otherwise IsTileUnderCellBlocking (A = 1 when any tile is at or
; below wMaxBlockingTile); the caller treats A = 1 as blocked. It runs no event. (C2, E-0374)
; runs IsCellBlockedByFieldEventKind_IsCellTall when wPendingFieldEvent & $0F = $0A, else
; IsTileUnderCellBlocking (E-0122)
IsCellBlockedByFieldEventKind::
    ld a, [wPendingFieldEvent]
    and $0f
    cp $0a
    jr z, .call_is_cell_blocked_by_field_event_kind_is
    call IsTileUnderCellBlocking
    ret

.call_is_cell_blocked_by_field_event_kind_is:
    call IsCellBlockedByFieldEventKind_IsCellTall
    ret

SECTION "Bank 04 UpdateSpriteSlots_FrameLoopType4", ROMX

; Sprite slot type 4: hTemp0/hTemp1 = UpdateSpriteSlots_FrameLoopType4_Data and on to
; UpdateSpriteSlots_StepFrameLoop, which plays it as a looping list of (frame, frames to hold) pairs
; into OBJ_SUBINDEX: frames 0, 3, 4, 5 twice ($E or $A frames each), then 0, 1, 2, 1, 2, 0, 6, 7, 6.
; The object does not move. (C2, E-0374)
UpdateSpriteSlots_FrameLoopType4::
    ld hl, UpdateSpriteSlots_FrameLoopType4_Data
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    jr UpdateSpriteSlots_StepFrameLoop

SECTION "Bank 04 UpdateSpriteSlots_FrameLoopType5", ROMX

; Sprite slot type 5: hTemp0/hTemp1 = UpdateSpriteSlots_FrameLoopType5_Data, then falls into
; UpdateSpriteSlots_StepFrameLoop, which plays it as a looping list of (frame, frames to hold) pairs
; into OBJ_SUBINDEX: frames 0, 1, 2, 1, $E frames each. The object does not move. (C2, E-0374)
UpdateSpriteSlots_FrameLoopType5::
    ld hl, UpdateSpriteSlots_FrameLoopType5_Data
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a

; hTemp0/hTemp1 = a list of (frame, count) pairs ending in $FF: steps a frame-sequence slot. Unless
; OBJ_FLAGS bit 1 is set, the timer (slot byte 9) counts up and, when it equals the count of the
; current pair (index in slot byte $A), the timer is reset and the index advanced, wrapping to 0 at
; the $FF end. Then OBJ_SUBINDEX = the frame of the current pair. The position is not changed.
; Continues with UpdateSpriteSlots_NextSlot. (C2, E-0374)
UpdateSpriteSlots_StepFrameLoop::
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
    jp UpdateSpriteSlots_NextSlot

SECTION "Bank 04 UpdateSpriteSlots_FrameLoopType4_Data", ROMX

; Seventeen (frame, hold count) byte pairs and an $FF, $FF end marker: frames 0, 3, 4, 5 held $0E,
; $0A, $0E, $0A frames, repeated once; then frames 0, 1, 2, 1, 2, 0, 6, 7, 6 held $10, $0E, $0E,
; $0E, $0E, $20, $0E, $20, $0E frames. UpdateSpriteSlots_StepFrameLoop plays the list in a loop for
; a type 4 sprite slot, storing the current frame in OBJ_SUBINDEX; the object does not move. (C1,
; E-0381)
UpdateSpriteSlots_FrameLoopType4_Data::
    db $00, $0e, $03, $0a, $04, $0e, $05, $0a, $00, $0e, $03, $0a, $04, $0e, $05, $0a
    db $00, $10, $01, $0e, $02, $0e, $01, $0e, $02, $0e, $00, $20, $06, $0e, $07, $20
    db $06, $0e, $ff, $ff

; Four (frame, hold count) byte pairs and an $FF, $FF end marker: frames 0, 1, 2, 1, each held $0E
; frames. UpdateSpriteSlots_StepFrameLoop plays the list in a loop for a type 5 sprite slot, storing
; the current frame in OBJ_SUBINDEX; the object does not move. (C1, E-0381)
UpdateSpriteSlots_FrameLoopType5_Data::
    db $00, $0e, $01, $0e, $02, $0e, $01, $0e, $ff, $ff

; B = pixel X, C = pixel Y: copies the 2 x 2 tiles of wScreenTileBuffer at row C / 8, column B / 8
; (indexed as 20-byte rows) to wTilesUnderPoint and returns A = 1 when any of them is at or below
; wMaxBlockingTile, A = 0 otherwise; BC and DE kept, HL changed. The wandering objects check their
; target cell with it (UpdateSpriteSlots_Wander directly, UpdateSpriteSlots_WanderFourWays through
; IsCellBlockedByFieldEventKind). (C2, E-0374)
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

SECTION "Bank 04 IsCellBlockedByFieldEventKind_IsCellTall", ROMX

; B = pixel X, C = pixel Y: copies the 2 x 2 tiles of wScreenTileBuffer under that cell to
; wTilesUnderPoint (as IsTileUnderCellBlocking does) and returns A = 1 when all four tile ids are
; above wMapTallTileMin, A = 0 when any is at or below it; BC and DE kept.
; IsCellBlockedByFieldEventKind uses it in place of IsTileUnderCellBlocking while the pending field
; event kind (wPendingFieldEvent low nibble) is $0A, and its caller UpdateSpriteSlots_WanderFourWays
; treats A = 1 as a blocked cell. (C2, E-0369; probed E-0374)
IsCellBlockedByFieldEventKind_IsCellTall::
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

SECTION "Bank 04 IsCellOccupiedByParty", ROMX

; Returns A = 1 when the metatile cell at pixel (B, C) is occupied by the player or by any party
; follower (each checked at its position and the position 15 pixels on), otherwise 0. Used before an
; object moves into a cell. (C2, E-0357; probed E-0374)
IsCellOccupiedByParty::
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

SECTION "Bank 04 FieldSpritePaletteIndex", ROMX

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

; Picks hPlayerSpriteMode and loads the field sprite graphics for it. Mode 1 when
; EVENT_SCENE_LONG_FACES_002 is clear or when EVENT_STAFF_ROLL_PARTY_SAVED is set without
; EVENT_THANKS_FOR_COMING_BY_025, otherwise 0; mode 2 overrides both when hPlayerStateFlags bit 3 is
; set. Mode 0: LoadPlayerSpriteGraphics and LoadPlayerAndFollowerSpriteGraphics_Followers. Mode 1:
; LoadPlayerSpriteGraphics, then field graphics 1 (0 if EVENT_NEVER_SET were set) at vTiles0 + $100
; with palette slot 1 and field graphics 4 at vTiles0 + $200 with palette slot 2
; (DecompressGraphicsTemp0ToTemp4). Mode 2: as mode 0, then
; LoadAltObjectGraphicsIfPlayerStateFlagsBit3. Called from map loads, scenes and menus in many banks
; (34 call sites). (C1, E-0374)
; hPlayerSpriteMode = sprite mode from story flags $19F, $25 and 2 and bit 3 of hPlayerStateFlags,
; then loads the matching player and follower sprite graphics (E-0128)
LoadPlayerAndFollowerSpriteGraphics::
    ld a, $00
    ldh [hPlayerSpriteMode], a
    ld de, EVENT_STAFF_ROLL_PARTY_SAVED
    call TestFlagBit
    jr nc, .call_test_flag_bit
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr nc, .set_player_sprite_mode_to_01

.call_test_flag_bit:
    ld de, EVENT_SCENE_LONG_FACES_002
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
    call LoadPlayerAndFollowerSpriteGraphics_Followers
    ret

.skip:
    dec a
    jr nz, .call_load_player_sprite_graphics
    call LoadPlayerSpriteGraphics
    ld de, EVENT_NEVER_SET
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
    call LoadPlayerAndFollowerSpriteGraphics_Followers
    call LoadAltObjectGraphicsIfPlayerStateFlagsBit3
    ret

SECTION "Bank 04 LoadPlayerSpriteGraphics", ROMX

; Load player graphics at VRAM $8000 with object palette slot 0. Without override bit 7, story flag
; 0 selects field graphics id 0/1 and writes the player variant; with override bit 7, copy the full
; hPlayerSpriteGfxId word to hTemp0/1 and use override bit 0 as hTemp2 (0 monster, 1 field). Clear
; hTemp3 and call DecompressGraphicsTemp0ToTemp4. The override id is a table index, not a
; compressed-stream address. Override loads preserve the previous player-variant byte; this loader
; does not request palette upload itself. (C1, E-0362)
LoadPlayerSpriteGraphics::
    ldh a, [hPlayerSpriteOverride]
    bit 7, a
    jr nz, .set_temp2
    ld de, EVENT_NEVER_SET
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
    ldh a, [hPlayerSpriteGfxIdLo]
    ld l, a
    ldh a, [hPlayerSpriteGfxIdHi]
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

SECTION "Bank 04 LoadAltObjectGraphicsIfPlayerStateFlagsBit3", ROMX

; When hPlayerStateFlags bit 3 is set: decompresses ScallopShellSpriteTiles from bank $7E to vTiles0
; + $700 (DecompressToVRAM) and copies 8 bytes from bank $7E at SharedOBJPalettes + $108 into OBJ
; palette 7 of wOBJPaletteBuffer (+ $38), then sets wOBJPaletteUploadRequest = $7F. Only
; LoadPlayerAndFollowerSpriteGraphics calls it, in sprite mode 2; DrawPlayerOverlaySprite21Or22 then
; draws with tile offset $70 and palette 7. (C1, E-0374)
; when hPlayerStateFlags bit 3 is set: decompresses ScallopShellSpriteTiles (bank $7E) to vTiles0 +
; $700 and copies an 8-byte palette from bank $7E into OBJ palette 7 of wOBJPaletteBuffer
; (wOBJPaletteUploadRequest = $7F) (E-0120)
LoadAltObjectGraphicsIfPlayerStateFlagsBit3::
    ldh a, [hPlayerStateFlags]
    bit 3, a
    ret z
    ld de, ScallopShellSpriteTiles
    ld b, BANK(ScallopShellSpriteTiles)
    ld hl, vTiles0 + $700
    call DecompressToVRAM
    ld de, SharedOBJPalettes
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

SECTION "Bank 04 AdvancePlayerAnimCounterAndRunPlayerSpriteMode", ROMX

; Unless hPlayerStateFlags bit 1 is set, adds 1 to hPlayerAnimCounter, and 3 more when bit 2
; (moving) is set. Then dispatches on hPlayerSpriteMode: 0 DrawPlayerAndFollowers, 1
; DrawPlayerAndFlagFollower, 2 DrawPlayerWithOverlay. Called by FieldStateCommonUpdate and once more
; from bank $02 (line 1787). (C1, E-0374)
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
    dw DrawPlayerAndFollowers
    dw DrawPlayerAndFlagFollower
    dw DrawPlayerWithOverlay

; Player sprite mode 0 (entry 0 of AdvancePlayerAnimCounterAndRunPlayerSpriteMode by
; hPlayerSpriteMode): draws the player (DrawPlayerSprite) and then the party followers
; (DrawPartyFollowerSprites). (C1, E-0372)
DrawPlayerAndFollowers::
    call DrawPlayerSprite
    call DrawPartyFollowerSprites
    ret

SECTION "Bank 04 DrawPlayerAndFlagFollower", ROMX

; Player sprite mode 1 (entry 1 of AdvancePlayerAnimCounterAndRunPlayerSpriteMode by
; hPlayerSpriteMode): draws the player (DrawPlayerSprite) and the single follower that
; DrawFollowerSpriteAfterLandHo shows when EVENT_SCENE_LAND_HO (flag $1B) is set and hFieldDrawFlags
; bit 1 is clear. (C1, E-0372)
DrawPlayerAndFlagFollower::
    call DrawPlayerSprite
    call DrawFollowerSpriteAfterLandHo
    ret

SECTION "Bank 04 DrawPlayerWithOverlay", ROMX

; Player sprite mode 2 (entry 2 of AdvancePlayerAnimCounterAndRunPlayerSpriteMode by
; hPlayerSpriteMode): draws the player (DrawPlayerSprite) and then the overlay meta-sprite set $21
; (hPlayerStateFlags bit 3 set) or $22, 8 pixels lower with tile offset $70 and palette 7
; (DrawPlayerOverlaySprite21Or22). (C1, E-0372)
DrawPlayerWithOverlay::
    call DrawPlayerSprite
    call DrawPlayerOverlaySprite21Or22
    ret

SECTION "Bank 04 DrawPlayerOverlaySprite21Or22", ROMX

; Draws the overlay of sprite mode 2 after DrawPlayerSprite: adds 8 to the 16-bit origin Y it left
; (hSpriteOriginY/Hi), sets hSpriteTileOffset = $70 and palette 7 (hSpriteAttrXor low 3 bits), and
; draws meta-sprite set $21 when hPlayerStateFlags bit 3 is set, otherwise $22, sub-index 0, with
; DrawMetaSprite. Only DrawPlayerWithOverlay calls it. (C1, E-0374)
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

SECTION "Bank 04 DrawFollowerSpriteAfterLandHo", ROMX

; The single follower of sprite mode 1. Returns when hFieldDrawFlags bit 1 is set or
; EVENT_SCENE_LAND_HO is clear. Otherwise draws the follower in wFollowerRecords: set
; (hPlayerSpriteVariant + 1) & 1, palette 1, tile offset $10, origin follower X + 8 + hScrollX and Y
; + 16 + hScrollY; the frame pair is 2 when UseSpecialSpritePoseAtPosition matches its position,
; else its direction byte, with direction 3 drawn as pair 1 flipped (attribute $21); the frame is
; pair * 2 + bit 5 of hPlayerAnimCounter. Drawn with DrawMetaSprite_Sets98. Only
; DrawPlayerAndFlagFollower calls it. (C1, E-0374)
; unless hFieldDrawFlags bit 1 is set, and only when story flag $1B is set: draws the follower
; sprite from wFollowerRecords bytes 1-2 (set from hPlayerSpriteVariant, with a different frame when
; UseSpecialSpritePoseAtPosition) (E-0175)
DrawFollowerSpriteAfterLandHo::
    ldh a, [hFieldDrawFlags]
    bit 1, a
    ret nz
    ld de, EVENT_SCENE_LAND_HO
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
    call UseSpecialSpritePoseAtPosition
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
    farcall DrawMetaSprite_Sets98
    ret

SECTION "Bank 04 DrawPlayerSprite", ROMX

; Return if field draw-mask bit 0 hides the player. Set the frame from facing (3 uses side frame 1
; mirrored with attribute $20), or selector 2 when UseSpecialSpritePoseAtPosition returns 1, plus
; animation-counter bit 5. Sprite origin adds wrapped player X+8/Y+16 to the stored scroll words;
; carry from the initial byte bias is discarded, while carry from adding scroll low propagates high.
; Mode 2 subtracts eight from the 16-bit Y origin. Without override draw the default field set; with
; bit 7, bit 0 selects field set from graphics-id low byte or monster set low & $7F in bank
; $25/$26/$27 chosen by id high/nonzero and low bit 7. Tile offset is 0. This corrects the older
; minus-scroll wording. (C1, E-0362)
DrawPlayerSprite::
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
    call UseSpecialSpritePoseAtPosition
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

.call_draw_meta_sprite_sets98:
    farcall DrawMetaSprite_Sets98
    ret

.skip:
    and $01
    jr z, .check_player_sprite_gfx_id_lo
    ldh a, [hPlayerSpriteGfxIdLo]
    ldh [hSpriteSetIndex], a
    jr .call_draw_meta_sprite_sets98

.check_player_sprite_gfx_id_lo:
    ldh a, [hPlayerSpriteGfxIdLo]
    and $7f
    ldh [hSpriteSetIndex], a
    ldh a, [hPlayerSpriteGfxIdHi]
    or a
    jr nz, .call_draw_meta_sprite_set_bank27
    ldh a, [hPlayerSpriteGfxIdLo]
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

SECTION "Bank 04 DrawPartyFollowerSprites", ROMX

; Sprite mode 0 followers: for each of wPartyCount members draws the follower from its 5-byte
; wFollowerRecords entry, skipped while its hFieldDrawFlags bit is set (bit 1, 2, 3 for members
; 1-3). Palette = 4 - members left to draw, tile offset $10, $20, $30; the frame pair is 2 at a
; special pose position (UseSpecialSpritePoseAtPosition), else the direction, direction 3 as pair 1
; flipped; frame = pair * 2 + bit 5 of hPlayerAnimCounter. The sprite is the word at wPartyList + 3
; + 2 * member: a high byte of $FF draws set $19 with DrawMetaSprite, otherwise set low & $7F with
; DrawMetaSpriteSet_Bank27 (high non-zero), DrawMetaSpriteSet_Bank26 (low bit 7) or
; DrawMetaSpriteSet_Bank25. Only DrawPlayerAndFollowers calls it. (C1, E-0374)
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
    call UseSpecialSpritePoseAtPosition
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

SECTION "Bank 04 UseSpecialSpritePoseAtPosition", ROMX

; Return A=1 during a nonzero fade only when map=$5A, screen=(0,0) and player Y=$80; B/C are ignored
; in that path. Without a fade, search the nine six-byte SpecialSpritePoseRegions records: match map
; and screen, require B=pixel X and minimum Y <= C <= maximum Y with unsigned inclusive comparisons.
; Return A=1 on a match, else 0 at the $FF sentinel. Preserve HL/DE in the table path and do not
; mutate coordinates. This extends the older fade-only interpretation: ordinary positions in the
; table also select the special pose. (C2, E-0362; probed E-0374)
UseSpecialSpritePoseAtPosition::
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
    ld hl, SpecialSpritePoseRegions

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

SECTION "Bank 04 SpecialSpritePoseRegions", ROMX

; Nine six-byte regions and $FF sentinel, searched only while no fade runs by
; UseSpecialSpritePoseAtPosition. Match map/screen, B=X and minimum <= C=Y <= maximum to return A=1.
; The fade branch ignores this table. All nine region boundaries are probed. (C1, E-0362; earlier
; fade-only E-0175 was incomplete)
; record: map/screen, exact pixel X and inclusive pixel Y range
SpecialSpritePoseRegions::
    db $05, $02, $00 ; id 0: map, screen X, screen Y
    db $50 ; pixel X (exact)
    db $00, $28 ; inclusive pixel Y minimum, maximum
    db $2b, $03, $03 ; id 1: map, screen X, screen Y
    db $20 ; pixel X (exact)
    db $00, $18 ; inclusive pixel Y minimum, maximum
    db $5a, $00, $00 ; id 2: map, screen X, screen Y
    db $40 ; pixel X (exact)
    db $10, $48 ; inclusive pixel Y minimum, maximum
    db $5a, $00, $00 ; id 3: map, screen X, screen Y
    db $70 ; pixel X (exact)
    db $30, $48 ; inclusive pixel Y minimum, maximum
    db $5c, $00, $01 ; id 4: map, screen X, screen Y
    db $30 ; pixel X (exact)
    db $78, $90 ; inclusive pixel Y minimum, maximum
    db $7a, $00, $00 ; id 5: map, screen X, screen Y
    db $40 ; pixel X (exact)
    db $58, $80 ; inclusive pixel Y minimum, maximum
    db $7a, $00, $01 ; id 6: map, screen X, screen Y
    db $40 ; pixel X (exact)
    db $00, $28 ; inclusive pixel Y minimum, maximum
    db $7a, $00, $01 ; id 7: map, screen X, screen Y
    db $50 ; pixel X (exact)
    db $10, $28 ; inclusive pixel Y minimum, maximum
    db $7a, $00, $01 ; id 8: map, screen X, screen Y
    db $30 ; pixel X (exact)
    db $38, $48 ; inclusive pixel Y minimum, maximum
    db $ff ; end

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
; goal room, to SetupKeyWorldObjectsForMapType_LoadObjects; it follows MonsterSpriteTable, which
; therefore has 383 entries, not 384 (E-0196, C1)
; record: object grid for this map kind
KeyWorldObjectGridTable::
    dw KeyWorldObjectGrid_0 ; id 0
    dw KeyWorldObjectGrid_1 ; id 1
    dw KeyWorldObjectGrid_2 ; id 2
    dw KeyWorldObjectGrid_3 ; id 3
    dw KeyWorldObjectGrid_4 ; id 4
    dw KeyWorldObjectGrid_5 ; id 5
    dw KeyWorldObjectGrid_6 ; id 6
    dw KeyWorldObjectGrid_7 ; id 7
    dw KeyWorldObjectGrid_0 ; id 8
    dw KeyWorldObjectGrid_9 ; id 9
    dw KeyWorldObjectGrid_10 ; id 10
    dw KeyWorldObjectGrid_3 ; id 11
    dw KeyWorldObjectGrid_4 ; id 12
    dw KeyWorldObjectGrid_5 ; id 13
    dw KeyWorldObjectGrid_6 ; id 14
    dw KeyWorldObjectGrid_7 ; id 15

; SetupKeyWorldObjectsForMapType_LoadObjects reads the word at the grid + 2 * (hMapScreenY *
; wMapWidthScreens + hMapScreenX); 2 screens, up to the next structure (E-0196, C1)
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_0::
    dw KeyWorldScreenObjects_0_0 ; id 0
    dw KeyWorldScreenObjects_0_1 ; id 1

; a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list (E-0196, C1)
; record: marker word; pointer to the object list
KeyWorldScreenObjects_0_0::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_0_0_1

; the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object
; record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world
; encounter when hTemp9 is set (E-0196, C1)
; record: count 2, then 2 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_0_0_1::
    db $02 ; entry 0: object count
    db $85, $01, $00, $00, $00, $40, $20, $05, $00, $50, $00 ; object 0
    db $86, $01, $01, $00, $00, $60, $50, $06, $03, $60, $01 ; object 1

KeyWorldScreenObjects_0_1::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_0_1_1

; record: count 3, then 3 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_0_1_1::
    db $03 ; entry 0: object count
    db $85, $01, $01, $00, $00, $30, $20, $05, $00, $50, $02 ; object 0
    db $86, $01, $01, $00, $00, $60, $60, $06, $00, $60, $03 ; object 1
    db $87, $01, $06, $00, $00, $70, $10, $07, $00, $70, $fa ; object 2

; SetupKeyWorldObjectsForMapType_LoadObjects reads the word at the grid + 2 * (hMapScreenY *
; wMapWidthScreens + hMapScreenX); 4 screens, up to the next structure (E-0196, C1)
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_1::
    dw KeyWorldScreenObjects_1_0 ; id 0
    dw KeyWorldScreenObjects_1_1 ; id 1
    dw KeyWorldScreenObjects_1_2 ; id 2
    dw KeyWorldScreenObjects_1_3 ; id 3

; a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list (E-0196, C1)
; record: marker word; pointer to the object list
KeyWorldScreenObjects_1_0::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_1_0_1

; the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object
; record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world
; encounter when hTemp9 is set (E-0196, C1)
; record: count 2, then 2 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_1_0_1::
    db $02 ; entry 0: object count
    db $85, $01, $08, $00, $00, $e0, $e0, $05, $00, $50, $fc ; object 0
    db $86, $01, $02, $00, $00, $20, $40, $06, $00, $60, $00 ; object 1

KeyWorldScreenObjects_1_1::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_1_1_1

; record: count 4, then 4 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_1_1_1::
    db $04 ; entry 0: object count
    db $85, $01, $02, $00, $00, $e0, $e0, $05, $00, $50, $fc ; object 0
    db $86, $01, $03, $00, $02, $40, $20, $06, $01, $60, $01 ; object 1
    db $87, $01, $04, $00, $00, $60, $50, $07, $00, $70, $02 ; object 2
    db $84, $01, $05, $00, $00, $20, $60, $04, $01, $40, $03 ; object 3

; a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list (E-0196, C1)
; record: marker word; pointer to the object list
KeyWorldScreenObjects_1_2::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_1_2_1

; the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object
; record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world
; encounter when hTemp9 is set (E-0196, C1)
; record: count 1, then 1 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_1_2_1::
    db $01 ; entry 0
    db $85, $01, $04, $00, $00, $70, $50, $05, $00, $50, $04

KeyWorldScreenObjects_1_3::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_1_3_1

; record: count 4, then 4 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_1_3_1::
    db $04 ; entry 0: object count
    db $85, $01, $03, $00, $00, $20, $40, $05, $03, $50, $05 ; object 0
    db $86, $01, $05, $00, $02, $40, $70, $06, $01, $60, $06 ; object 1
    db $87, $01, $02, $00, $00, $50, $30, $07, $00, $70, $07 ; object 2
    db $84, $01, $06, $00, $00, $60, $10, $04, $00, $40, $fa ; object 3

; SetupKeyWorldObjectsForMapType_LoadObjects reads the word at the grid + 2 * (hMapScreenY *
; wMapWidthScreens + hMapScreenX); 4 screens, up to the next structure (E-0196, C1)
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_9::
    dw KeyWorldScreenObjects_9_0 ; id 0
    dw KeyWorldScreenObjects_9_1 ; id 1
    dw KeyWorldScreenObjects_9_2 ; id 2
    dw KeyWorldScreenObjects_9_3 ; id 3

; a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list (E-0196, C1)
; record: marker word; pointer to the object list
KeyWorldScreenObjects_9_0::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_9_0_1

; the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object
; record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world
; encounter when hTemp9 is set (E-0196, C1)
; record: count 2, then 2 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_9_0_1::
    db $02 ; entry 0: object count
    db $85, $01, $08, $00, $00, $e0, $e0, $05, $00, $50, $fc ; object 0
    db $86, $01, $04, $00, $00, $20, $40, $06, $00, $60, $04 ; object 1

KeyWorldScreenObjects_9_1::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_9_1_1

; record: count 4, then 4 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_9_1_1::
    db $04 ; entry 0: object count
    db $85, $01, $02, $00, $00, $e0, $e0, $05, $00, $50, $fc ; object 0
    db $86, $01, $03, $00, $00, $70, $50, $06, $01, $60, $05 ; object 1
    db $87, $01, $02, $00, $02, $30, $60, $07, $01, $70, $07 ; object 2
    db $84, $01, $07, $00, $00, $40, $20, $04, $00, $40, $fd ; object 3

; a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list (E-0196, C1)
; record: marker word; pointer to the object list
KeyWorldScreenObjects_9_2::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_9_2_1

; the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object
; record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world
; encounter when hTemp9 is set (E-0196, C1)
; record: count 2, then 2 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_9_2_1::
    db $02 ; entry 0: object count
    db $85, $01, $03, $00, $00, $70, $50, $05, $01, $50, $01 ; object 0
    db $86, $01, $05, $00, $02, $30, $60, $06, $01, $60, $06 ; object 1

KeyWorldScreenObjects_9_3::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_9_3_1

; record: count 4, then 4 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_9_3_1::
    db $04 ; entry 0: object count
    db $85, $01, $02, $00, $00, $70, $30, $05, $00, $50, $00 ; object 0
    db $86, $01, $04, $00, $00, $40, $70, $06, $02, $60, $02 ; object 1
    db $87, $01, $05, $00, $02, $40, $40, $07, $01, $70, $03 ; object 2
    db $84, $01, $06, $00, $00, $60, $10, $04, $00, $40, $fa ; object 3

; SetupKeyWorldObjectsForMapType_LoadObjects reads the word at the grid + 2 * (hMapScreenY *
; wMapWidthScreens + hMapScreenX); 2 screens, up to the next structure (E-0196, C1)
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_2::
    dw KeyWorldScreenObjects_2_0 ; id 0
    dw KeyWorldScreenObjects_2_1 ; id 1

; a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list (E-0196, C1)
; record: marker word; pointer to the object list
KeyWorldScreenObjects_2_0::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_2_0_1

; the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object
; record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world
; encounter when hTemp9 is set (E-0196, C1)
; record: count 2, then 2 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_2_0_1::
    db $02 ; entry 0: object count
    db $85, $01, $02, $00, $00, $50, $30, $05, $00, $50, $fd ; object 0
    db $86, $01, $04, $00, $00, $60, $70, $06, $03, $60, $00 ; object 1

KeyWorldScreenObjects_2_1::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_2_1_1

; record: count 4, then 4 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_2_1_1::
    db $04 ; entry 0: object count
    db $85, $01, $03, $00, $00, $60, $30, $05, $03, $50, $01 ; object 0
    db $86, $01, $02, $00, $00, $20, $60, $06, $02, $60, $02 ; object 1
    db $87, $01, $05, $00, $02, $40, $70, $07, $01, $70, $03 ; object 2
    db $84, $01, $06, $00, $00, $20, $20, $04, $00, $40, $fa ; object 3

; SetupKeyWorldObjectsForMapType_LoadObjects reads the word at the grid + 2 * (hMapScreenY *
; wMapWidthScreens + hMapScreenX); 2 screens, up to the next structure (E-0196, C1)
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_10::
    dw KeyWorldScreenObjects_10_0 ; id 0
    dw KeyWorldScreenObjects_10_1 ; id 1

; a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list (E-0196, C1)
; record: marker word; pointer to the object list
KeyWorldScreenObjects_10_0::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_10_0_1

; the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object
; record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world
; encounter when hTemp9 is set (E-0196, C1)
; record: count 3, then 3 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_10_0_1::
    db $03 ; entry 0: object count
    db $85, $01, $02, $00, $00, $50, $30, $05, $00, $50, $fd ; object 0
    db $86, $01, $02, $00, $00, $30, $60, $06, $00, $60, $02 ; object 1
    db $87, $01, $05, $00, $00, $60, $70, $07, $00, $70, $03 ; object 2

KeyWorldScreenObjects_10_1::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_10_1_1

KeyWorldObjectList_10_1_1::
    db $03 ; entry 0: object count
    db $85, $01, $03, $00, $02, $60, $60, $05, $01, $50, $01 ; object 0
    db $86, $01, $04, $00, $00, $60, $30, $06, $00, $60, $00 ; object 1
    db $87, $01, $06, $00, $00, $20, $20, $07, $00, $70, $fa ; object 2

; SetupKeyWorldObjectsForMapType_LoadObjects reads the word at the grid + 2 * (hMapScreenY *
; wMapWidthScreens + hMapScreenX); 1 screens, up to the next structure (E-0196, C1)
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_3::
    dw KeyWorldScreenObjects_3_0 ; id 0

; a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list (E-0196, C1)
; record: marker word; pointer to the object list
KeyWorldScreenObjects_3_0::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_3_0_1

; the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object
; record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world
; encounter when hTemp9 is set (E-0196, C1)
; record: count 1, then 1 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_3_0_1::
    db $01 ; entry 0
    db $85, $01, $15, $00, $00, $30, $20, $05, $00, $50, $fc

; SetupKeyWorldObjectsForMapType_LoadObjects reads the word at the grid + 2 * (hMapScreenY *
; wMapWidthScreens + hMapScreenX); 1 screens, up to the next structure (E-0196, C1)
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_7::
    dw KeyWorldScreenObjects_7_0 ; id 0

; a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list (E-0196, C1)
; record: marker word; pointer to the object list
KeyWorldScreenObjects_7_0::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_7_0_1

; the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object
; record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world
; encounter when hTemp9 is set (E-0196, C1)
; record: count 1, then 1 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_7_0_1::
    db $01 ; entry 0
    db $85, $01, $44, $00, $00, $30, $20, $05, $00, $50, $fc

; SetupKeyWorldObjectsForMapType_LoadObjects reads the word at the grid + 2 * (hMapScreenY *
; wMapWidthScreens + hMapScreenX); 1 screens, up to the next structure (E-0196, C1)
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_4::
    dw KeyWorldScreenObjects_4_0 ; id 0

; a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list (E-0196, C1)
; record: marker word; pointer to the object list
KeyWorldScreenObjects_4_0::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_4_0_1

; the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object
; record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world
; encounter when hTemp9 is set (E-0196, C1)
; record: count 1, then 1 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_4_0_1::
    db $01 ; entry 0
    db $85, $00, $28, $00, $00, $50, $10, $05, $00, $50, $fe

; SetupKeyWorldObjectsForMapType_LoadObjects reads the word at the grid + 2 * (hMapScreenY *
; wMapWidthScreens + hMapScreenX); 1 screens, up to the next structure (E-0196, C1)
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_5::
    dw KeyWorldScreenObjects_5_0 ; id 0

; a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list (E-0196, C1)
; record: marker word; pointer to the object list
KeyWorldScreenObjects_5_0::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_5_0_1

; the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object
; record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world
; encounter when hTemp9 is set (E-0196, C1)
; record: count 1, then 1 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_5_0_1::
    db $01 ; entry 0
    db $85, $00, $28, $00, $00, $50, $10, $05, $00, $50, $fe

; SetupKeyWorldObjectsForMapType_LoadObjects reads the word at the grid + 2 * (hMapScreenY *
; wMapWidthScreens + hMapScreenX); 1 screens, up to the next structure (E-0196, C1)
; record: one screen, row by row (wMapWidthScreens per row): its object entry or 0
KeyWorldObjectGrid_6::
    dw KeyWorldScreenObjects_6_0 ; id 0

; a marker of $FFFF clears wSpriteSlotCount; otherwise the next word points at the list (E-0196, C1)
; record: marker word; pointer to the object list
KeyWorldScreenObjects_6_0::
    dw $fffe ; entry 0
    dw KeyWorldObjectList_6_0_1

; the count goes to wSpriteSlotCount; each record fills a sprite slot like a bank-$69 map object
; record: bytes 0-1 to hTemp5/hTemp2, bytes 2-3 the graphics number, replaced by the key-world
; encounter when hTemp9 is set (E-0196, C1)
; record: count 1, then 1 object records of 11 bytes (the map object layout of E-0176)
KeyWorldObjectList_6_0_1::
    db $01 ; entry 0
    db $85, $00, $28, $00, $00, $40, $50, $05, $00, $50, $fb

; HL = message word: starts script command 9 (the message box) with HL in wScriptParam0 (low) and
; wScriptParam1 (high); sets wModeState = 1, wScriptCommandType = 9, wScriptRunning = 1, wScriptStep
; = 0 and wScriptStartRequest = 0 (its earlier store of $80 is overwritten). The talk handlers of
; this bank call it for their one-message replies (over 350 call sites). (C2, E-0374)
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

SECTION "Bank 04 StartTreasureFlagDE_B04", ROMX

; DE = story flag of a treasure: starts script command $0A (RunOneTimeTreasure) with DE in
; wMessageIndex (low) and wMessageGroup (high), which that command tests and sets as a flag; sets
; wModeState = 1, wScriptCommandType = $0A, wScriptRunning = 1, wScriptStep = 0 and
; wScriptStartRequest = 0. The chest, vase and barrel handlers of this bank call it (about 100 call
; sites). (C2, E-0374)
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

SECTION "Bank 04 StartScriptAtHL_B04", ROMX

; HL = script address: stores it in wScriptPointerLo/Hi, sets wScriptStartRequest = $80 (the script
; engine starts fetching at HL) and wModeState = 1. wScriptRunning is not touched here. The talk and
; map event handlers of this bank use it to start their scripts (over 180 call sites). (C2, E-0374)
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

SECTION "Bank 04 ReadableTalkEvents", ROMX

; Talk category $0A (DispatchTalkEvent_Readable): dispatches on wTalkEventGroup through 35 entries:
; scene starters (0-2, 4-6), the Vault keeper (7), notices (8, $16, $17), the pedestal (9), the
; library desk ($0A), the bookshelves ($0B-$15), a vase ($18), a barrel ($19), the key count
; (ReadableTalkEvents_GreatLogKey, $1A) and eight replies after flag $D1 ($1B-$22). Entry 3 is $0000
; and would crash; the unreached bytes after Talk_ListenYouTwoQuitYourHorsing look like its handler.
; (C1, E-0374)
; talk category $0A: notices and bookshelves ("Hero read the notice", "Hero checked the bookshelf")
ReadableTalkEvents::
    ld a, [wTalkEventGroup]
    jumptable
    dw ReadableTalkEvents_AtSeaScene
    dw Talk_HehSoTheseAreTheNewcomers
    dw Talk_ListenYouTwoQuitYourHorsing
    dw $0000 ; unused index (E-0207)
    dw Talk_OhItsAllSpinningAround
    dw Talk_SceneSpinning
    dw Talk_WarubouCalmDownAndListen
    dw Talk0046_ThanksForComingBy
    dw TalkMsg0047_HeroReadTheNoticeWeGuarantee
    dw Talk_HeroCheckedThePedestalIts
    dw ReadableTalkEvents_LibraryDesk
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
    dw ReadableTalkEvents_Notice
    dw TalkMsg0010_HeroPeeredIntoTheVaseFreshly
    dw TalkMsg000F_HeroPeeredIntoTheBarrelIt
    dw ReadableTalkEvents_GreatLogKey
    dw IfFlag00D1Msg0D33_YouSavedUsAll
    dw IfFlag00D1Msg0D34_PleaseEatUpEat
    dw IfFlag00D1Msg0D35_HmISawYour
    dw IfFlag00D1Msg0D36_TheKingdomIsRejoicing
    dw IfFlag00D1Msg0D37_InsteadOfStandingAround
    dw IfFlag00D1Msg0D38_JustImagineIfYou
    dw IfFlag00D1Msg0D39_AhGreatLogsMightyHero
    dw IfFlag00D1Msg0D3A_ToBeHonestI

; Readable talk 0: starts the 'In the middle of the sea' scene, Script_InTheMiddleOf (its second
; message 'Tara: There you are, big brother!') when EVENT_IN_THE_MIDDLE_OF_THE is set, otherwise
; Script_InTheMiddleOf_2 (second message 'Papa's calling'); both scripts set EVENT_SCENE_AT_SEA.
; (C2, E-0369; probed E-0374)
; starts Script_InTheMiddleOf: 'In the middle of the sea' (E-0248)
ReadableTalkEvents_AtSeaScene::
    ld de, EVENT_IN_THE_MIDDLE_OF_THE
    call TestFlagBit
    jr nc, .call_start_script_at_hl_b04
    ld hl, Script_InTheMiddleOf ; script 'In the middle of the sea'
    ASSERT BANK(Script_InTheMiddleOf) == $10, "Script_InTheMiddleOf is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_InTheMiddleOf_2 ; script 'In the middle of the sea'
    ASSERT BANK(Script_InTheMiddleOf_2) == $10, "Script_InTheMiddleOf_2 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_HehSoTheseAreTheNewcomers", ROMX

; Readable talk 1 (wTalkEventGroup = 1 in ReadableTalkEvents): starts Script_HehSoTheseAre
; (StartScriptAtHL_B04), whose first message begins 'Heh, so these are the newcomers?'. (C2, E-0374)
; starts Script_HehSoTheseAre (StartScriptAtHL_B04); its first message begins 'Heh, so these are the
; newcomers?' (E-0271; was Talk_HehSoTheseAreTheNewcomers) (E-0344: the address in its name dropped
; or read as the label there; was Talk_HehSoTheseAreTheNewcomers; shortened from
; TalkScript_HehSoTheseAreTheNewcomers)
; starts Script_HehSoTheseAre: '*: Heh, so these are the' (E-0248)
Talk_HehSoTheseAreTheNewcomers::
    ld hl, Script_HehSoTheseAre ; script '*: Heh, so these are the'
    ASSERT BANK(Script_HehSoTheseAre) == $10, "Script_HehSoTheseAre is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_ListenYouTwoQuitYourHorsing", ROMX

; Readable talk 2: starts Script_ListenYouTwoQuit (StartScriptAtHL_B04), whose first message begins
; 'Listen you two! Quit your horsing'. The seven bytes after its ret are never reached: they decode
; as ld hl, $0044 / call StartMessageCommand09HL_B04 / ret, the shape of a handler for message $0044
; ('checked the peculiar door. It has an oddly shaped keyhole'), probably the missing entry 3 of
; ReadableTalkEvents, which is $0000. (C2, E-0374)
; starts Script_ListenYouTwoQuit (StartScriptAtHL_B04); its first message begins 'Listen you two!
; Quit your horsing' (E-0271; was Talk_ListenYouTwoQuitYourHorsing) (E-0344: the address in its name
; dropped or read as the label there; was Talk_ListenYouTwoQuitYourHorsing; shortened from
; TalkScript_ListenYouTwoQuitYourHorsing)
; starts Script_ListenYouTwoQuit: '*: Listen you two! Quit your' (E-0248)
Talk_ListenYouTwoQuitYourHorsing::
    ld hl, Script_ListenYouTwoQuit ; script '*: Listen you two! Quit your'
    ASSERT BANK(Script_ListenYouTwoQuit) == $10, "Script_ListenYouTwoQuit is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_CheckedThePeculiarDoor", ROMX

; Shows message $0044 ('... checked the peculiar door. It ...') through StartMessageCommand09HL_B04,
; like the talk handlers around it. No traced code, jump table or pointer reaches it (E-0395: it
; decodes as a routine but is unreached in the static listing). (C2, E-0395; probed E-0395)
; starts Script_OhIt: '*: Oh… It's… all spinning around…' (E-0248)
Talk_CheckedThePeculiarDoor:: ; configured code entry (E-0395); C0
    ld hl, $0044 ; '0 checked the peculiar door. It'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 Talk_OhItsAllSpinningAround", ROMX

; Readable talk 4: starts Script_OhIt ('Oh... It is all spinning around', StartScriptAtHL_B04) and
; sets EVENT_OH_ITS_ALL_SPINNING_AROUND (flag 5) at once, so the scene does not repeat. (C2, E-0374)
; StartScriptAtHL_B04 with HL = $4F73, then sets story flag 5 (E-0119) (E-0344: the address in its
; name dropped or read as the label there; was Talk_OhItsAllSpinningAround)
; starts Script_OhIt: '*: Oh… It's… all spinning around…' (E-0248)
Talk_OhItsAllSpinningAround::
    ld hl, Script_OhIt ; script '*: Oh… It's… all spinning around…'
    ASSERT BANK(Script_OhIt) == $10, "Script_OhIt is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ld de, EVENT_OH_ITS_ALL_SPINNING_AROUND
    call SetFlagBit
    ret

SECTION "Bank 04 Talk_SceneSpinning", ROMX

; Readable talk 5: starts Script_SceneSpinning (StartScriptAtHL_B04), runs field command 0
; (RunFieldCommandTemp0 with hTemp0 = 0) and sets EVENT_MAP_00_OBJECT_REMOVED (flag 6). (C1, E-0374)
; map event: starts script $4F7C, runs RunFieldCommandTemp0 with hTemp0 = 0 and sets story flag 6
; (E-0122) (E-0344: the address in its name dropped or read as the label there; was
; Talk_SceneSpinning)
; starts Script_SceneSpinning (E-0248)
Talk_SceneSpinning::
    ld hl, Script_SceneSpinning
    ASSERT BANK(Script_SceneSpinning) == $10, "Script_SceneSpinning is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ld a, $00
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld de, EVENT_SCENE_SPINNING
    call SetFlagBit
    ret

SECTION "Bank 04 Talk_WarubouCalmDownAndListen", ROMX

; Readable talk 6: only when EVENT_SCENE_WARUBOU_SMELLS (flag $0A) is set, starts
; Script_WarubouCalmDownAnd ('Warubou: Calm down and listen!'); otherwise nothing happens. (C2,
; E-0374)
; when story flag $0A is set, StartScriptAtHL_B04 with HL = $4F9D (E-0119) (E-0344: the address in
; its name dropped or read as the label there; was Talk_WarubouCalmDownAndListen)
; starts Script_WarubouCalmDownAnd: 'Warubou: Calm down and listen! What' (E-0248)
Talk_WarubouCalmDownAndListen::
    ld de, EVENT_SCENE_WARUBOU_SMELLS
    call TestFlagBit
    ret nc
    ld hl, Script_WarubouCalmDownAnd ; script 'Warubou: Calm down and listen! What'
    ASSERT BANK(Script_WarubouCalmDownAnd) == $10, "Script_WarubouCalmDownAnd is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk0046_ThanksForComingBy", ROMX

; Talk (the Vault keeper): the first time runs field command 1 and the 'You must be the farm...'
; script (setting EVENT_THANKS_FOR_COMING_BY), then 'Thanks for coming by...' ($0046); after the
; Warubou food scene 'You say the island will...' ($0079); after the long-faces scene the 'Oh, hi!
; Good to see' script, and after EVENT_THANKS_FOR_COMING_BY_025 the 'Hello, GreatLog's hero!'
; script, each once before the 'How may the Vault serve' script (wDataBank $10). (C1, E-0357)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 2
; constant message(s) depending on story flags and state; the first one in the code is $0046, whose
; string begins 'Thanks for coming by. I'll always' (E-0097)
Talk0046_ThanksForComingBy::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .set_data_bank_to_102
    ld de, EVENT_SCENE_LONG_FACES_002
    call TestFlagBit
    jr c, .set_data_bank_to_10
    ld de, EVENT_SCENE_WARUBOU_FOOD2_00C
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_THANKS_FOR_COMING_BY
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld a, $01
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld hl, Script_YouMustBeThe ; script '*: You must be the farm'
    call StartScriptAtHL_B04
    ld de, EVENT_THANKS_FOR_COMING_BY
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
    ld de, EVENT_OH_HI_GOOD_TO
    call TestFlagBit
    jr c, .loop
    ld hl, Script_OhHiGoodTo ; script '*: Oh, hi! Good to see'
    ASSERT BANK(Script_OhHiGoodTo) == $10, "Script_OhHiGoodTo is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.loop:
    ld hl, Script_HowMayTheVault ; script '*: How may the Vault serve'
    ASSERT BANK(Script_HowMayTheVault) == $10, "Script_HowMayTheVault is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.set_data_bank_to_102:
    ld a, $10
    ld [wDataBank], a
    ld de, EVENT_HELLO_GREAT_LOG
    call TestFlagBit
    jr c, .loop
    ld hl, Script_HelloGreatLog ; script '*: Hello, GreatLog's hero! Do you'
    ASSERT BANK(Script_HelloGreatLog) == $10, "Script_HelloGreatLog is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 TalkMsg0047_HeroReadTheNoticeWeGuarantee", ROMX

; Readable talk 8, a notice: starts message $0047 through StartMessageCommand09HL_B04, '<BUF0> read
; the notice.' followed by the notice text beginning We guarantee the safekeeping of. (C2, E-0374)
; starts message $0047 through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 read the notice. We guarantee the' (E-0268, the E-0082 shape; was
; TalkMsg0047_HeroReadTheNoticeWeGuarantee)
; starts Script_HeroCheckedThePedestal: '0 checked the pedestal. It's the' (E-0248)
TalkMsg0047_HeroReadTheNoticeWeGuarantee::
    ld hl, $0047 ; '0 read the notice. 'We guarantee'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 Talk_HeroCheckedThePedestalIts", ROMX

; Readable talk 9: starts Script_HeroCheckedThePedestal (StartScriptAtHL_B04), whose first message
; begins '<BUF0> checked the pedestal.'. (C2, E-0374)
; starts Script_HeroCheckedThePedestal (StartScriptAtHL_B04); its first message begins '0 checked
; the pedestal. It's the' (E-0271; was Talk_HeroCheckedThePedestalIts) (E-0344: the address in its
; name dropped or read as the label there; was Talk_HeroCheckedThePedestalIts; shortened from
; TalkScript_HeroCheckedThePedestalIts)
; starts Script_HeroCheckedThePedestal: '0 checked the pedestal. It's the' (E-0248)
Talk_HeroCheckedThePedestalIts::
    ld hl, Script_HeroCheckedThePedestal ; script '0 checked the pedestal. It's the'
    ASSERT BANK(Script_HeroCheckedThePedestal) == $10, "Script_HeroCheckedThePedestal is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 ReadableTalkEvents_LibraryDesk", ROMX

; Readable talk $0A, the library front desk: turns sprite slot 0 (OBJ_STATE 0 when hPlayerX is $40,
; else 3), sets wDataBank = $1F and starts a script. Before EVENT_THANKS_FOR_COMING_BY_025:
; Script_WelcomeToTheLibrary until EVENT_WELCOME_TO_THE_LIBRARY, then Script_WelcomeToTheLibrary_2.
; After it, TotalSpeciesFlaggedOrListed: only when its high byte (hTemp1) is non-zero and its low
; byte (hTemp0) at least $38, that is a total of at least 312 ($138), Script_WelcomeToTheLibrary_3
; once (until EVENT_WELCOME_TO_THE_LIBRARY_19E); otherwise Script_HelloOurYoungSavior until
; EVENT_HELLO_OUR_YOUNG_SAVIOR, then Script_WelcomeToTheLibrary_2. (C2, E-0374)
ReadableTalkEvents_LibraryDesk::
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
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_total_species_flagged_or_listed
    ld de, EVENT_WELCOME_TO_THE_LIBRARY
    call TestFlagBit
    jr c, .loop
    ld hl, Script_WelcomeToTheLibrary ; script '*: Welcome to the Library. You'
    ASSERT BANK(Script_WelcomeToTheLibrary) == $10, "Script_WelcomeToTheLibrary is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.loop:
    ld hl, Script_WelcomeToTheLibrary_2 ; script '*: Welcome to the Library. Which'
    ASSERT BANK(Script_WelcomeToTheLibrary_2) == $10, "Script_WelcomeToTheLibrary_2 is read with bank $10 mapped"
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
    ld de, EVENT_HELLO_OUR_YOUNG_SAVIOR
    call TestFlagBit
    jr c, .loop
    ld hl, Script_HelloOurYoungSavior ; script '*: Hello, our young savior! Have'
    ASSERT BANK(Script_HelloOurYoungSavior) == $10, "Script_HelloOurYoungSavior is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_test_flag_bit:
    ld de, EVENT_WELCOME_TO_THE_LIBRARY_19E
    call TestFlagBit
    jr c, .loop2
    ld hl, Script_WelcomeToTheLibrary_3 ; script '*: Welcome to the Library! Your'
    ASSERT BANK(Script_WelcomeToTheLibrary_3) == $10, "Script_WelcomeToTheLibrary_3 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 TalkMsg0233_HeroCheckedTheBookshelfMonster", ROMX

; Readable talk $0B, a library bookshelf: starts message $0233 through StartMessageCommand09HL_B04
; (script command 9): '<BUF0> checked the bookshelf.' and then the book Monster Skills. (C2, E-0374)
; starts message $0233 through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 checked the bookshelf. Monster Skills Every' (E-0268, the E-0082 shape; was
; TalkMsg0233_HeroCheckedTheBookshelfMonster)
TalkMsg0233_HeroCheckedTheBookshelfMonster::
    ld hl, $0233 ; '0 checked the bookshelf. 'Monster Skills…'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0234_HeroCheckedTheBookshelfMonster", ROMX

; Readable talk $0C, a library bookshelf: starts message $0234 through StartMessageCommand09HL_B04
; (script command 9): '<BUF0> checked the bookshelf.' and then the book Monster Growth. (C2, E-0374)
; starts message $0234 through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 checked the bookshelf. Monster Growth By' (E-0268, the E-0082 shape; was
; TalkMsg0234_HeroCheckedTheBookshelfMonster)
TalkMsg0234_HeroCheckedTheBookshelfMonster::
    ld hl, $0234 ; '0 checked the bookshelf. 'Monster Growth…'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0235_HeroCheckedTheBookshelfPersonalities", ROMX

; Readable talk $0D, a library bookshelf: starts message $0235 through StartMessageCommand09HL_B04
; (script command 9): '<BUF0> checked the bookshelf.' and then the book Personalities of Monsters.
; (C2, E-0374)
; starts message $0235 through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 checked the bookshelf. Personalities of Monsters' (E-0268, the E-0082 shape; was
; TalkMsg0235_HeroCheckedTheBookshelfPersonalities)
TalkMsg0235_HeroCheckedTheBookshelfPersonalities::
    ld hl, $0235 ; '0 checked the bookshelf. 'Personalities of'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0236_HeroCheckedTheBookshelfNuts", ROMX

; Readable talk $0E, a library bookshelf: starts message $0236 through StartMessageCommand09HL_B04
; (script command 9): '<BUF0> checked the bookshelf.' and then the book Nuts and Seeds. (C2, E-0374)
; starts message $0236 through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 checked the bookshelf. Nuts and Seeds' (E-0268, the E-0082 shape; was
; TalkMsg0236_HeroCheckedTheBookshelfNuts)
TalkMsg0236_HeroCheckedTheBookshelfNuts::
    ld hl, $0236 ; '0 checked the bookshelf. 'Nuts and'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0237_HeroCheckedTheBookshelfWorldLeaf", ROMX

; Readable talk $0F, a library bookshelf: starts message $0237 through StartMessageCommand09HL_B04
; (script command 9): '<BUF0> checked the bookshelf.' and then the book WorldLeaf. (C2, E-0374)
; starts message $0237 through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 checked the bookshelf. WorldLeaf An indispensable' (E-0268, the E-0082 shape; was
; TalkMsg0237_HeroCheckedTheBookshelfWorldLeaf)
TalkMsg0237_HeroCheckedTheBookshelfWorldLeaf::
    ld hl, $0237 ; '0 checked the bookshelf. 'WorldLeaf… An'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0238_HeroCheckedTheBookshelfMagic", ROMX

; Readable talk $10, a library bookshelf: starts message $0238 through StartMessageCommand09HL_B04
; (script command 9): '<BUF0> checked the bookshelf.' and then the book Magic Key Guide. (C2,
; E-0374)
; starts message $0238 through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 checked the bookshelf. Magic Key Guide' (E-0268, the E-0082 shape; was
; TalkMsg0238_HeroCheckedTheBookshelfMagic)
TalkMsg0238_HeroCheckedTheBookshelfMagic::
    ld hl, $0238 ; '0 checked the bookshelf. 'Magic Key'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0239_HeroCheckedTheBookshelfMagic", ROMX

; Readable talk $11, a library bookshelf: starts message $0239 through StartMessageCommand09HL_B04
; (script command 9): '<BUF0> checked the bookshelf.' and then the book Magic Key Guide. (C2,
; E-0374)
; starts message $0239 through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 checked the bookshelf. Magic Key Guide' (E-0268, the E-0082 shape; was
; TalkMsg0239_HeroCheckedTheBookshelfMagic)
TalkMsg0239_HeroCheckedTheBookshelfMagic::
    ld hl, $0239 ; '0 checked the bookshelf. 'Magic Key'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg023A_HeroCheckedTheBookshelfStarry", ROMX

; Readable talk $12, a library bookshelf: starts message $023A through StartMessageCommand09HL_B04
; (script command 9): '<BUF0> checked the bookshelf.' and then the book Starry Shrine. (C2, E-0374)
; starts message $023A through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 checked the bookshelf. Starry Shrine A' (E-0268, the E-0082 shape; was
; TalkMsg023A_HeroCheckedTheBookshelfStarry)
TalkMsg023A_HeroCheckedTheBookshelfStarry::
    ld hl, $023a ; '0 checked the bookshelf. 'Starry Shrine…'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg023B_HeroCheckedTheBookshelfEgg", ROMX

; Readable talk $13, a library bookshelf: starts message $023B through StartMessageCommand09HL_B04
; (script command 9): '<BUF0> checked the bookshelf.' and then the book Egg Evaluators. (C2, E-0374)
; starts message $023B through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 checked the bookshelf. Egg Evaluators Those' (E-0268, the E-0082 shape; was
; TalkMsg023B_HeroCheckedTheBookshelfEgg)
TalkMsg023B_HeroCheckedTheBookshelfEgg::
    ld hl, $023b ; '0 checked the bookshelf. 'Egg Evaluators…'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg023C_HeroCheckedTheBookshelfAccessory", ROMX

; Readable talk $14, a library bookshelf: starts message $023C through StartMessageCommand09HL_B04
; (script command 9): '<BUF0> checked the bookshelf.' and then the book Accessory Guide. (C2,
; E-0374)
; starts message $023C through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 checked the bookshelf. Accessory Guide A' (E-0268, the E-0082 shape; was
; TalkMsg023C_HeroCheckedTheBookshelfAccessory)
TalkMsg023C_HeroCheckedTheBookshelfAccessory::
    ld hl, $023c ; '0 checked the bookshelf. 'Accessory Guide…'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg023D_HeroCheckedTheBookshelfHidden", ROMX

; Readable talk 21 (ReadableTalkEvents): starts message $023D through StartMessageCommand09HL_B04
; (script command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning =
; 1, wModeState = 1); the hero checks the bookshelf and reads 'Hidden Abilities', which begins
; 'Monsters remain mysterious in many'. (C2, E-0374)
; starts message $023D through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 checked the bookshelf. Hidden Abilities Monsters' (E-0268, the E-0082 shape; was
; TalkMsg023D_HeroCheckedTheBookshelfHidden)
TalkMsg023D_HeroCheckedTheBookshelfHidden::
    ld hl, $023d ; '0 checked the bookshelf. 'Hidden Abilities…'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg023E_HeroReadTheNoticePleaseReturn", ROMX

; Readable talk 22 (ReadableTalkEvents): starts message $023E through StartMessageCommand09HL_B04
; (script command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning =
; 1, wModeState = 1); the hero reads the notice 'Please return books to their proper places!'. (C2,
; E-0374)
; starts message $023E through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 read the notice. Please return books' (E-0268, the E-0082 shape; was
; TalkMsg023E_HeroReadTheNoticePleaseReturn)
TalkMsg023E_HeroReadTheNoticePleaseReturn::
    ld hl, $023e ; '0 read the notice. 'Please return'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 ReadableTalkEvents_Notice", ROMX

; Talk event $0A step 23: a notice (message $0042) shown before the three-item scene and again after
; the game's end. (C2, E-0357; probed E-0374)
ReadableTalkEvents_Notice::
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    ret c

.call_start_message_command09_hl_b04:
    ld hl, $0042 ; '0 read the sign. 'Danger! Stay'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0010_HeroPeeredIntoTheVaseFreshly", ROMX

; Readable talk 24 (ReadableTalkEvents): starts message $0010 through StartMessageCommand09HL_B04
; (script command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning =
; 1, wModeState = 1); the hero peers into the vase: 'Freshly caught fish were inside.'. (C2, E-0374)
; starts message $0010 through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 peered into the vase. Freshly caught' (E-0268, the E-0082 shape; was
; TalkMsg0010_HeroPeeredIntoTheVaseFreshly)
TalkMsg0010_HeroPeeredIntoTheVaseFreshly::
    ld hl, $0010 ; '0 peered into the vase. Freshly'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg000F_HeroPeeredIntoTheBarrelIt", ROMX

; Readable talk 25 (ReadableTalkEvents): starts message $000F through StartMessageCommand09HL_B04
; (script command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning =
; 1, wModeState = 1); the hero peers into the barrel: 'It was filled with clean water.'. (C2,
; E-0374)
; starts message $000F through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 peered into the barrel. It was' (E-0268, the E-0082 shape; was
; TalkMsg000F_HeroPeeredIntoTheBarrelIt)
TalkMsg000F_HeroPeeredIntoTheBarrelIt::
    ld hl, $000f ; '0 peered into the barrel. It'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 ReadableTalkEvents_GreatLogKey", ROMX

; Readable talk 26 (ReadableTalkEvents): returns at once unless EVENT_SCENE_OASIS_KEY is set. Then
; it appends two key entries to wKeyList: twice CountKeysOrFull (hTemp0 = the first free entry) and
; WriteKeyEntryTemp0 with hTemp1 = 1 and then 2, so the new entries get byte 0 = 1 and 2 and byte 3
; = $80, bytes 1-2 left as they were. It sets bit 7 of wInventorySortFlags and starts
; Script_HeroReceivedTheGreatLog through StartScriptAtHL_B04 ('received the GreatLog Key.'). With
; all 32 entries in use CountKeysOrFull returns $80 and the entry written lies past the list. (C2,
; E-0374)
; with story flag $1A set: counts keys twice (WriteKeyEntryTemp0 with hTemp1 = 1 and 2), sets bit 7
; of wInventorySortFlags and starts script $5039 (E-0124) (E-0344: the address in its name dropped
; or read as the label there; was ReadableTalkEvents_GreatLogKey)
ReadableTalkEvents_GreatLogKey::
    ld de, EVENT_SCENE_OASIS_KEY
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
    ld a, [wInventorySortFlags]
    set 7, a
    ld [wInventorySortFlags], a
    ld hl, Script_HeroReceivedTheGreatLog ; script '0 received the GreatLog Key.'
    ASSERT BANK(Script_HeroReceivedTheGreatLog) == $10, "Script_HeroReceivedTheGreatLog is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 IfFlag00D1Msg0D33_YouSavedUsAll", ROMX

; Readable talk 27 (ReadableTalkEvents): when EVENT_SCENE_DARCK_DEFEATED is set starts message $0D33
; ('You saved us all by yourself.') through StartMessageCommand09HL_B04 (script command $09:
; wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1);
; otherwise returns without changing anything. (C2, E-0374)
; when story flag $00D1 is set (TestFlagBit), starts message $0D33 through
; StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'You saved
; us all by yourself.' (E-0082)
IfFlag00D1Msg0D33_YouSavedUsAll::
    ld de, EVENT_SCENE_DARCK_DEFEATED
    call TestFlagBit
    ret nc
    ld hl, $0d33 ; '*: You saved us all by'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 IfFlag00D1Msg0D34_PleaseEatUpEat", ROMX

; Readable talk 28 (ReadableTalkEvents): when EVENT_SCENE_DARCK_DEFEATED is set starts message $0D34
; ('Please, eat up, eat up!') through StartMessageCommand09HL_B04 (script command $09:
; wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1);
; otherwise returns without changing anything. (C2, E-0374)
; when story flag $00D1 is set (TestFlagBit), starts message $0D34 through
; StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'Please,
; eat up, eat up! Don't' (E-0082)
IfFlag00D1Msg0D34_PleaseEatUpEat::
    ld de, EVENT_SCENE_DARCK_DEFEATED
    call TestFlagBit
    ret nc
    ld hl, $0d34 ; '*: Please, eat up, eat up!'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 IfFlag00D1Msg0D35_HmISawYour", ROMX

; Readable talk 29 (ReadableTalkEvents): when EVENT_SCENE_DARCK_DEFEATED is set starts message $0D35
; ('Hm? I saw your family.') through StartMessageCommand09HL_B04 (script command $09:
; wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1);
; otherwise returns without changing anything. (C2, E-0374)
; when story flag $00D1 is set (TestFlagBit), starts message $0D35 through
; StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'Hm? I saw
; your family. They' (E-0082)
IfFlag00D1Msg0D35_HmISawYour::
    ld de, EVENT_SCENE_DARCK_DEFEATED
    call TestFlagBit
    ret nc
    ld hl, $0d35 ; '*: Hm? I saw your family.'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 IfFlag00D1Msg0D36_TheKingdomIsRejoicing", ROMX

; Readable talk 30 (ReadableTalkEvents): when EVENT_SCENE_DARCK_DEFEATED is set starts message $0D36
; ('The Kingdom is rejoicing!') through StartMessageCommand09HL_B04 (script command $09:
; wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1);
; otherwise returns without changing anything. (C2, E-0374)
; when story flag $00D1 is set (TestFlagBit), starts message $0D36 through
; StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'The
; Kingdom is rejoicing!' (E-0082)
IfFlag00D1Msg0D36_TheKingdomIsRejoicing::
    ld de, EVENT_SCENE_DARCK_DEFEATED
    call TestFlagBit
    ret nc
    ld hl, $0d36 ; '*: The Kingdom is rejoicing!'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 IfFlag00D1Msg0D37_InsteadOfStandingAround", ROMX

; Readable talk 31 (ReadableTalkEvents): when EVENT_SCENE_DARCK_DEFEATED is set starts message $0D37
; ('Instead of standing around, you should go and enjoy yourselves.') through
; StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the message word,
; wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1); otherwise returns without changing
; anything. (C2, E-0374)
; when story flag $00D1 is set (TestFlagBit), starts message $0D37 through
; StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'Instead
; of standing around, you should' (E-0082)
IfFlag00D1Msg0D37_InsteadOfStandingAround::
    ld de, EVENT_SCENE_DARCK_DEFEATED
    call TestFlagBit
    ret nc
    ld hl, $0d37 ; '*: Instead of standing around, you'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 IfFlag00D1Msg0D38_JustImagineIfYou", ROMX

; Readable talk 32 (ReadableTalkEvents): when EVENT_SCENE_DARCK_DEFEATED is set starts message $0D38
; ('Just imagine if' the hero were not here) through StartMessageCommand09HL_B04 (script command
; $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1, wModeState =
; 1); otherwise returns without changing anything. (C2, E-0374)
; when story flag $00D1 is set (TestFlagBit), starts message $0D38 through
; StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'Just
; imagine if you weren't here.' (E-0082)
IfFlag00D1Msg0D38_JustImagineIfYou::
    ld de, EVENT_SCENE_DARCK_DEFEATED
    call TestFlagBit
    ret nc
    ld hl, $0d38 ; '*: Just imagine if you weren't'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 IfFlag00D1Msg0D39_AhGreatLogsMightyHero", ROMX

; Readable talk 33 (ReadableTalkEvents): when EVENT_SCENE_DARCK_DEFEATED is set starts message $0D39
; (GreatLog 'mighty hero!') through StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1
; = the message word, wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1); otherwise returns
; without changing anything. (C2, E-0374)
; when story flag $00D1 is set (TestFlagBit), starts message $0D39 through
; StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'Ah,
; GreatLog's mighty hero! I hope' (E-0082)
IfFlag00D1Msg0D39_AhGreatLogsMightyHero::
    ld de, EVENT_SCENE_DARCK_DEFEATED
    call TestFlagBit
    ret nc
    ld hl, $0d39 ; '*: Ah, GreatLog's mighty hero! I'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 IfFlag00D1Msg0D3A_ToBeHonestI", ROMX

; Readable talk 34 (ReadableTalkEvents): when EVENT_SCENE_DARCK_DEFEATED is set starts message $0D3A
; ('To be honest, I was getting ready to clear out.') through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); otherwise returns without changing anything. (C2, E-0374)
; when story flag $00D1 is set (TestFlagBit), starts message $0D3A through
; StartMessageCommand09HL_B04 (script command $09); otherwise returns; that string begins 'To be
; honest, I was getting' (E-0082)
IfFlag00D1Msg0D3A_ToBeHonestI::
    ld de, EVENT_SCENE_DARCK_DEFEATED
    call TestFlagBit
    ret nc
    ld hl, $0d3a ; '*: To be honest, I was'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 YoldTalkEvents", ROMX

; Talk category 3 (DispatchTalkEvent_Yold far-calls it): jumps through its table of 110 handlers by
; wTalkEventGroup, with no range check. The handlers cover the people, signs, barrels, vases, ovens
; and chests of Yold, Polona and Port Ritz and the mermaid and pirate-ship scenes (messages mostly
; $0800-$088F, plus some $0Dxx). (C2, E-0374)
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
    dw YoldTalkEvents_NoisyBirds
    dw YoldTalkEvents_Shop
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
    dw YoldTalkEvents_MermaidPast
    dw YoldTalkEvents_Inn
    dw Talk_HaveYouHeardTheLegendAbout
    dw TalkMsg081B_AhhThisIsHeavenlyItMakes
    dw TalkMsg081C_ICameFromFarAwayTo
    dw TalkMsg088B_HeroReadTheSignWelcomeTo
    dw TalkMsg0889_HeroPeeredIntoTheOvenIt_04
    dw TalkMsg081D_ThisIsPortRitzWhereShips
    dw TalkMsg081E_ThePiratesWereSwallowedBy
    dw TalkMsg081F_TheresThisOldSailorManIn
    dw Talk_HowMayOurChurchServeYou
    dw TalkMsg0821_AllSortsOfPeopleComeHere
    dw TalkMsg0822_IWentToPolonaAWhile
    dw YoldTalkEvents_Shop2
    dw TalkMsg0824_ThereIsALighthouseToThe
    dw TalkMsg0825_MyShipSankInTheEastern
    dw TalkMsg0826_TheOldManInTheTaverns
    dw TalkMsg0827_ThisPortUsedToBeLively
    dw TalkMsg0829_TheLighthouseHadTheMoonRock
    dw TalkMsg082A_TheSeasLevelHasGoneDown
    dw TalkMsg082B_ListenDidYouKnowMermaids
    dw TalkMsg088D_HeroPeeredIntoTheOvenTwo
    dw Talk_HeroTriedToCheckTheChest
    dw TalkMsg082E_HeroPeeredIntoTheBarrelIt
    dw BarrelItem_TinyMedal_Flag0063
    dw YoldTalkEvents_SecondInn
    dw TalkMsg082F_ThisAreaWasALotMore
    dw TalkMsg0830_WhenYoureOutAtSeaYou
    dw Talk_SceneWhoAreYou
    dw TalkMsg0834_WhenThatOldManGetsGrogged
    dw TalkMsg0835_TheOldFellowThereTheInstant
    dw TalkMsg0836_TheVolcanicIslandOffTheCoast
    dw YoldTalkEvents_ShowHnnnrHicGnnZzz
    dw YoldTalkEvents_WhoAreYou
    dw ChestItem_Rib
    dw ChestItem_LoveWater
    dw ChestItem_LoveWater_Flag0069
    dw ChestItem_ExitBell
    dw ChestItem_MermScale
    dw ChestItem_Warp
    dw TalkMsg0843_ISawAChildCrossThe
    dw TalkMsg0844_WatchMeDanceAndYoullWant
    dw YoldTalkEvents_OfferMap41Warp
    dw YoldTalkEvents_ShowThisIsTheMermaid
    dw TalkMsg084F_IKnowNotAllHumansAre
    dw TalkMsg0850_ThePiratesCaughtUsInNets
    dw TalkMsg0851_TheHarMirrorWasExquisite
    dw TalkMsg0852_TheMoonRockFellFromTheSky
    dw TalkMsg0853_ThePiratesSankWithTheirShip
    dw TalkMsg0854_WeMermaidsArePeacefulBeings
    dw YoldTalkEvents_SailorRingGiver
    dw Talk_SceneSailorRing
    dw Talk_HowCouldWeDieBeforeEnjoying
    dw Talk_TheTreasuresAreOursNoOne
    dw Talk_ItNagsAndNagsThatWe
    dw YoldTalkEvents_WhoDisturbsUs
    dw YoldTalkEvents_ShowHeroCheckedTheTreasure
    dw YoldTalkEvents_CheckCrate
    dw YoldTalkEvents_ResetFirstSlotState
    dw ChestItem_LogTwig
    dw YoldTalkEvents_ShowHeroCheckedThePedestal
    dw YoldTalkEvents_KamehaThanks
    dw Talk_KamehaUrkHowYouCatchUp
    dw Talk_KamehaArrrrhClearTheWayIm
    dw Talk_SceneMermaidKingdom
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
    dw YoldTalkEvents_KamehaEscape
    dw TalkMsg00FF_Composing
    dw Talk_ThickSuctionCuppedTentacles
    dw YoldTalkEvents_Church

; Yold talk 0 (YoldTalkEvents): starts message $0800 through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); 'This is the village of Yold.'. (C2, E-0374)
; starts message $0800 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'This is the village of Yold. We're' (E-0268, the E-0082 shape; was
; TalkMsg0800_ThisIsTheVillageOfYold)
TalkMsg0800_ThisIsTheVillageOfYold::
    ld hl, $0800 ; '*: This is the village of'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0801_InTheNorthwestIsAVillage", ROMX

; Yold talk 1 (YoldTalkEvents): starts message $0801 through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); 'In the northwest is a village that is famous for mermaids.'. (C2, E-0374)
; starts message $0801 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'In the northwest is a village that' (E-0268, the E-0082 shape; was
; TalkMsg0801_InTheNorthwestIsAVillage)
TalkMsg0801_InTheNorthwestIsAVillage::
    ld hl, $0801 ; '*: In the northwest is a'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0802_AroundThesePartsItsFaster", ROMX

; Yold talk 2 (YoldTalkEvents): starts message $0802 through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); about travel 'by boat than walking'. (C2, E-0374)
; starts message $0802 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'Around these parts it's faster to travel' (E-0268, the E-0082 shape; was
; TalkMsg0802_AroundThesePartsItsFaster)
TalkMsg0802_AroundThesePartsItsFaster::
    ld hl, $0802 ; '*: Around these parts it's faster'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0803_ISawAHauntedShipIn", ROMX

; Yold talk 3 (YoldTalkEvents): when EVENT_SCENE_MERMAID_KINGDOM_05F is set starts message $0874
; (the speaker has not seen 'the ghost ship in some time now' but is still afraid at night),
; otherwise message $0803 ('I saw a haunted ship in the north.'), through
; StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the message word,
; wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1). (C2, E-0374)
; tests story flags (flag 005F then jr c,
; TalkMsg0803_ISawAHauntedShipIn.call_start_message_command09_hl_b04); starts message $0803 through
; StartMessageCommand09HL_B04 (script command $09); that string begins 'I saw a haunted ship in the'
; (E-0268, the E-0082 shape; was TalkMsg0803_ISawAHauntedShipIn)
TalkMsg0803_ISawAHauntedShipIn::
    ld de, EVENT_SCENE_MERMAID_KINGDOM_05F
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0803 ; '*: I saw a haunted ship'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0874 ; '*: I haven't seen the ghost'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0804_TheVolcanicIslandOffTheCoast", ROMX

; Yold talk 4 (YoldTalkEvents): when EVENT_SCENE_MERMAID_KINGDOM_05F is set starts message $0875
; (the island 'appears to have calmed down again.'), otherwise message $0804 (the volcanic island
; 'appears to be in a bad mood.'), through StartMessageCommand09HL_B04 (script command $09:
; wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1).
; (C2, E-0374)
; tests story flags (flag 005F then jr c,
; TalkMsg0804_TheVolcanicIslandOffTheCoast.call_start_message_command09_hl_b04); starts message
; $0804 through StartMessageCommand09HL_B04 (script command $09); that string begins 'The volcanic
; island off the coast appears' (E-0268, the E-0082 shape; was
; TalkMsg0804_TheVolcanicIslandOffTheCoast)
TalkMsg0804_TheVolcanicIslandOffTheCoast::
    ld de, EVENT_SCENE_MERMAID_KINGDOM_05F
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0804 ; '*: The volcanic island off the'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0875 ; '*: The volcanic island appears to'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0805_MermaidsLivedInTheSeaIn", ROMX

; Yold talk 5 (YoldTalkEvents): when EVENT_SCENE_MERMAID_KINGDOM_05F is set starts message $0876
; ('Will the HarMirror make me appear beautiful'), otherwise message $0805 ('Mermaids lived in the
; sea in the northwest.'), through StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1
; = the message word, wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1). (C2, E-0374)
; tests story flags (flag 005F then jr c,
; TalkMsg0805_MermaidsLivedInTheSeaIn.call_start_message_command09_hl_b04); starts message $0805
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'Mermaids lived in
; the sea in the' (E-0268, the E-0082 shape; was TalkMsg0805_MermaidsLivedInTheSeaIn)
TalkMsg0805_MermaidsLivedInTheSeaIn::
    ld de, EVENT_SCENE_MERMAID_KINGDOM_05F
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0805 ; '*: Mermaids lived in the sea'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0876 ; '*: Sigh… Will the HarMirror make'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 YoldTalkEvents_NoisyBirds", ROMX

; Yold talk 6: 'The birds are noisy' the first time (setting its flag), message $0808 afterwards,
; message $0877 after the mermaid kingdom scene (EVENT_SCENE_MERMAID_KINGDOM_05F). (C2, E-0357;
; probed E-0374)
YoldTalkEvents_NoisyBirds::
    ld de, EVENT_SCENE_MERMAID_KINGDOM_05F
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_THE_BIRDS_ARE_NOISY_ITS
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, Script_TheBirdsAreNoisy ; script '*: …The birds are noisy… It's'
    ASSERT BANK(Script_TheBirdsAreNoisy) == $10, "Script_TheBirdsAreNoisy is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ld de, EVENT_THE_BIRDS_ARE_NOISY_ITS
    call SetFlagBit
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0808 ; '*: I hope the volcanic island'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $0877 ; '*: My grandson just shivers now…'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 YoldTalkEvents_Shop", ROMX

; Yold talk 7: a shop: screen table 4, script data in bank $10, script Script_IDon. (C2, E-0357;
; probed E-0374)
YoldTalkEvents_Shop::
    ld a, $04
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_IDon ; script '*: I don't have much but…'
    ASSERT BANK(Script_IDon) == $10, "Script_IDon is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 TalkMsg080A_HeroPeeredIntoTheBarrelA", ROMX

; Yold talk 8 (YoldTalkEvents): starts message $080A through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); the hero peers into the barrel: 'A folded fishnet was tucked inside.'. (C2,
; E-0374)
; starts message $080A through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 peered into the barrel. A folded' (E-0268, the E-0082 shape; was
; TalkMsg080A_HeroPeeredIntoTheBarrelA)
TalkMsg080A_HeroPeeredIntoTheBarrelA::
    ld hl, $080a ; '0 peered into the barrel. A'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg080B_HeroPeeredIntoTheBarrelIt", ROMX

; Yold talk 9 (YoldTalkEvents): starts message $080B through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); the hero peers into the barrel: 'It was filled with colorful fruits.'. (C2,
; E-0374)
; starts message $080B through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 peered into the barrel. It was' (E-0268, the E-0082 shape; was
; TalkMsg080B_HeroPeeredIntoTheBarrelIt)
TalkMsg080B_HeroPeeredIntoTheBarrelIt::
    ld hl, $080b ; '0 peered into the barrel. It'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 BarrelItem_TinyMedal", ROMX

; Yold talk 10 (YoldTalkEvents), a one-time barrel: StartTreasureFlagDE_B04 starts script command
; $0A (RunOneTimeTreasure) with wScriptParam0 = 2 (barrel), wScriptParam1 = ITEM_TINYMEDAL and story
; flag $0061 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1).
; That command gives the item and sets the flag when the flag is clear (group-0 message $A6), shows
; $A7 when the flag is already set and $A8 when the bag is full. (C2, E-0374)
; a one-time barrel: script command $0A with wScriptParam0 = 2 (kind) and wScriptParam1 = $2C, story
; flag $0061 in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the flag (message
; $A6 of group 0; $A7 when the flag is already set, $A8 when there is no room) (E-0269; was
; BarrelItem_TinyMedal)
BarrelItem_TinyMedal::
    ld a, $02
    ld [wScriptParam0], a
    ld a, $2c
    ld [wScriptParam1], a
    ld de, $0061
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 BarrelItem_Warp", ROMX

; Yold talk 11 (YoldTalkEvents), a one-time barrel: StartTreasureFlagDE_B04 starts script command
; $0A (RunOneTimeTreasure) with wScriptParam0 = 2 (barrel), wScriptParam1 = ITEM_WARP and story flag
; $0062 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1). That
; command gives the item and sets the flag when the flag is clear (group-0 message $A6), shows $A7
; when the flag is already set and $A8 when the bag is full. (C2, E-0374)
; a one-time barrel: script command $0A with wScriptParam0 = 2 (kind) and wScriptParam1 = $28, story
; flag $0062 in DE: when the flag is clear it gives item $28 (Warp) and sets the flag (message $A6
; of group 0; $A7 when the flag is already set, $A8 when there is no room) (E-0269; was
; BarrelItem_Warp)
BarrelItem_Warp::
    ld a, $02
    ld [wScriptParam0], a
    ld a, $28
    ld [wScriptParam1], a
    ld de, $0062
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 TalkMsg088A_HeroPeeredIntoTheVaseIt", ROMX

; Yold talk 12 (YoldTalkEvents): starts message $088A through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); the hero peers into the vase ('It was ...'). (C2, E-0374)
; starts message $088A through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 peered into the vase. It was' (E-0268, the E-0082 shape; was
; TalkMsg088A_HeroPeeredIntoTheVaseIt)
TalkMsg088A_HeroPeeredIntoTheVaseIt::
    ld hl, $088a ; '0 peered into the vase. It'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0889_HeroPeeredIntoTheOvenIt", ROMX

; Yold talk 13 (YoldTalkEvents): starts message $0889 through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); the hero peers into the oven ('It smelled ...'); entry 25,
; TalkMsg0889_HeroPeeredIntoTheOvenIt_04, is an identical copy. (C2, E-0374)
; starts message $0889 through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 peered into the oven. It smelled' (E-0268, the E-0082 shape; was
; TalkMsg0889_HeroPeeredIntoTheOvenIt)
TalkMsg0889_HeroPeeredIntoTheOvenIt::
    ld hl, $0889 ; '0 peered into the oven. It'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0037_HeroTriedToOpenTheChest", ROMX

; Yold talk 14 (YoldTalkEvents): starts message $0037 through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); the hero tries to open the chest: 'But the chest was locked tight.'. (C2, E-0374)
; starts message $0037 through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 tried to open the chest. But' (E-0268, the E-0082 shape; was
; TalkMsg0037_HeroTriedToOpenTheChest)
TalkMsg0037_HeroTriedToOpenTheChest::
    ld hl, $0037 ; '0 tried to open the chest.'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg080C_WelcomeToPolonaItsATourist", ROMX

; Yold talk 15 (YoldTalkEvents): starts message $080C through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); 'Welcome to Polona.', a resort known for its mermaids. (C2, E-0374)
; starts message $080C through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'Welcome to Polona. It's a tourist resort' (E-0268, the E-0082 shape; was
; TalkMsg080C_WelcomeToPolonaItsATourist)
TalkMsg080C_WelcomeToPolonaItsATourist::
    ld hl, $080c ; '*: Welcome to Polona. It's a'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg080D_YouCouldMeetMermaidsHere", ROMX

; Yold talk 16 (YoldTalkEvents): when EVENT_SCENE_MERMAID_KINGDOM_05F is set starts message $0878
; ('The mermaids came back.'), otherwise message $080D ('You could meet mermaids here in the past,
; but not anymore.'), through StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the
; message word, wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1). (C2, E-0374)
; tests story flags (flag 005F then jr c,
; TalkMsg080D_YouCouldMeetMermaidsHere.call_start_message_command09_hl_b04); starts message $080D
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'You could meet
; mermaids here in the' (E-0268, the E-0082 shape; was TalkMsg080D_YouCouldMeetMermaidsHere)
TalkMsg080D_YouCouldMeetMermaidsHere::
    ld de, EVENT_SCENE_MERMAID_KINGDOM_05F
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $080d ; '*: You could meet mermaids here'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0878 ; '*: The mermaids came back.'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg080E_ImFromThePortInThe", ROMX

; Yold talk 17 (YoldTalkEvents): starts message $080E through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); the speaker is 'from the port in the northeast'. (C2, E-0374)
; starts message $080E through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'I'm from the port in the northeast.' (E-0268, the E-0082 shape; was
; TalkMsg080E_ImFromThePortInThe)
TalkMsg080E_ImFromThePortInThe::
    ld hl, $080e ; '*: I'm from the port in'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg080F_YoureNotSupposedToGoNear", ROMX

; Yold talk 18 (YoldTalkEvents): starts message $080F through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); a warning about going 'near the cave in the west.'. (C2, E-0374)
; starts message $080F through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'You're not supposed to go near the' (E-0268, the E-0082 shape; was
; TalkMsg080F_YoureNotSupposedToGoNear)
TalkMsg080F_YoureNotSupposedToGoNear::
    ld hl, $080f ; '*: You're not supposed to go'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 YoldTalkEvents_MermaidPast", ROMX

; Yold talk 19, the mermaid past: after EVENT_IN_THE_PAST_MERMAIDS_ARE message $084A ('Mermaids
; exist.'). Otherwise FindPartyMemberWithSkill76To7DOr92 looks for a party member knowing
; SKILL_ODDDANCE through SKILL_SIDESTEP ($76-$7D) or SKILL_DANCESHUT; with none (hTemp1 = $80) it
; starts Script_InThePastMermaids (the yes answer gets the SCRIPT_SCENE_DANCING scene). With one,
; when any party record has MON_STATUS bit 7 set (SetWStepArrivedIfPartyHasField55Bit7) it starts
; Script_InThePastMermaids_4 ('Your monsters appear dispirited'); otherwise it copies that member
; name (11 bytes of wNameGlyphBuf) to wTextBuf1 + 7 and the skill name to wTextBuf2 + 2 and starts
; Script_InThePastMermaids_3 when EVENT_THE_PIRATES is set, else Script_InThePastMermaids_2
; (SCRIPT_SCENE_MERMAID_SONG_2 and SCRIPT_SCENE_MERMAID_SONG on yes). All four scripts start with
; the yes/no question $4810. (C2, E-0374)
YoldTalkEvents_MermaidPast::
    ld de, EVENT_IN_THE_PAST_MERMAIDS_ARE
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    farcall FindPartyMemberWithSkill76To7DOr92
    ldh a, [hTemp1]
    bit 7, a
    jr z, .call_set_w_step_arrived_if_party_has_field55
    ld hl, Script_InThePastMermaids ; script '*: In the past, mermaids are'
    ASSERT BANK(Script_InThePastMermaids) == $10, "Script_InThePastMermaids is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_set_w_step_arrived_if_party_has_field55:
    farcall SetWStepArrivedIfPartyHasField55Bit7
    ld a, [wStepArrived]
    or a
    jr z, .read_temp1
    ld hl, Script_InThePastMermaids_4 ; script '*: In the past, mermaids are'
    ASSERT BANK(Script_InThePastMermaids_4) == $10, "Script_InThePastMermaids_4 is read with bank $10 mapped"
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
    call CopySkillNameToDE
    ld de, EVENT_THE_PIRATES
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_InThePastMermaids_2 ; script '*: In the past, mermaids are'
    ASSERT BANK(Script_InThePastMermaids_2) == $10, "Script_InThePastMermaids_2 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_InThePastMermaids_3 ; script '*: In the past, mermaids are'
    ASSERT BANK(Script_InThePastMermaids_3) == $10, "Script_InThePastMermaids_3 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $084a ; '*: I'm astonished. Mermaids exist.'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 YoldTalkEvents_Inn", ROMX

; Yold talk 20, an inn: starts Script_WelcomeToOurInn_3 ('Welcome to our inn!', then a jump to the
; inn script Script_It_3 in the data bank) and sets wDataBank = $10 for that jump. (C2, E-0369;
; probed E-0374)
; starts Script_WelcomeToOurInn_3: '*: Welcome to our inn!' (E-0248)
YoldTalkEvents_Inn::
    ld hl, Script_WelcomeToOurInn_3 ; script '*: Welcome to our inn!'
    ASSERT BANK(Script_WelcomeToOurInn_3) == $10, "Script_WelcomeToOurInn_3 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ld a, $10
    ld [wDataBank], a
    ret

SECTION "Bank 04 Talk_HaveYouHeardTheLegendAbout", ROMX

; Yold talk 21 (YoldTalkEvents): starts Script_HaveYouHeardThe through StartScriptAtHL_B04
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1); its question $4818
; 'Have you heard the legend' leads to message $8819 on yes and $881A ('Long ago, a deft craftsman')
; on no. (C2, E-0374)
; starts Script_HaveYouHeardThe (StartScriptAtHL_B04); its first message begins 'Have you heard the
; legend about' (E-0271; was Talk_HaveYouHeardTheLegendAbout) (E-0344: the address in its name
; dropped or read as the label there; was Talk_HaveYouHeardTheLegendAbout; shortened from
; TalkScript_HaveYouHeardTheLegendAbout)
; starts Script_HaveYouHeardThe: '*: Have you heard the legend' (E-0248)
Talk_HaveYouHeardTheLegendAbout::
    ld hl, Script_HaveYouHeardThe ; script '*: Have you heard the legend'
    ASSERT BANK(Script_HaveYouHeardThe) == $10, "Script_HaveYouHeardThe is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 TalkMsg081B_AhhThisIsHeavenlyItMakes", ROMX

; Yold talk 22 (YoldTalkEvents): starts message $081B through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); 'This is heavenly! It makes me feel alive again!'. (C2, E-0374)
; starts message $081B through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'Ahh This is heavenly! It makes me' (E-0268, the E-0082 shape; was
; TalkMsg081B_AhhThisIsHeavenlyItMakes)
TalkMsg081B_AhhThisIsHeavenlyItMakes::
    ld hl, $081b ; '*: Ahh… This is heavenly! It'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg081C_ICameFromFarAwayTo", ROMX

; Yold talk 23 (YoldTalkEvents): when EVENT_SCENE_MERMAID_KINGDOM_05F is set starts message $0879
; (the speaker has now seen 'mermaids too.'), otherwise message $081C ('I came from far away to see
; some mermaids'), through StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the
; message word, wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1). (C2, E-0374)
; tests story flags (flag 005F then jr c,
; TalkMsg081C_ICameFromFarAwayTo.call_start_message_command09_hl_b04); starts message $081C through
; StartMessageCommand09HL_B04 (script command $09); that string begins 'I came from far away to see'
; (E-0268, the E-0082 shape; was TalkMsg081C_ICameFromFarAwayTo)
TalkMsg081C_ICameFromFarAwayTo::
    ld de, EVENT_SCENE_MERMAID_KINGDOM_05F
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $081c ; '*: I came from far away'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0879 ; '*: I've seen mermaids too. I'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg088B_HeroReadTheSignWelcomeTo", ROMX

; Yold talk 24 (YoldTalkEvents): starts message $088B through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); the hero reads the sign ('Welcome to ...'). (C2, E-0374)
; starts message $088B through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 read the sign. Welcome to the' (E-0268, the E-0082 shape; was
; TalkMsg088B_HeroReadTheSignWelcomeTo)
TalkMsg088B_HeroReadTheSignWelcomeTo::
    ld hl, $088b ; '0 read the sign. 'Welcome to'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0889_HeroPeeredIntoTheOvenIt_04", ROMX

; Yold talk 25 (YoldTalkEvents): starts message $0889 through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); the hero peers into the oven ('It smelled ...'); an identical copy of entry 13,
; TalkMsg0889_HeroPeeredIntoTheOvenIt. (C2, E-0374)
; starts message $0889 through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 peered into the oven. It smelled' (E-0268, the E-0082 shape; was
; TalkMsg0889_HeroPeeredIntoTheOvenIt_04) (E-0344: the address in its name dropped or read as the
; label there; was TalkMsg0889_HeroPeeredIntoTheOvenIt_04)
TalkMsg0889_HeroPeeredIntoTheOvenIt_04::
    ld hl, $0889 ; '0 peered into the oven. It'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg081D_ThisIsPortRitzWhereShips", ROMX

; Yold talk 26 (YoldTalkEvents): starts message $081D through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); 'This is Port Ritz, where ships gather from all over the world.'. (C2, E-0374)
; starts message $081D through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'This is Port Ritz, where ships gather' (E-0268, the E-0082 shape; was
; TalkMsg081D_ThisIsPortRitzWhereShips)
TalkMsg081D_ThisIsPortRitzWhereShips::
    ld hl, $081d ; '*: This is Port Ritz, where'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg081E_ThePiratesWereSwallowedBy", ROMX

; Yold talk 27 (YoldTalkEvents): when EVENT_THE_PIRATES_WERE_SWALLOWED_BY is set starts message
; $087A ('The pirates hid their loot on the volcanic island'), otherwise message $081E ('The pirates
; were swallowed by the sea after monsters overwhelmed them.'), through StartMessageCommand09HL_B04
; (script command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning =
; 1, wModeState = 1). (C2, E-0374)
; tests story flags (flag 007A then jr c,
; TalkMsg081E_ThePiratesWereSwallowedBy.call_start_message_command09_hl_b04); starts message $081E
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'The pirates were
; swallowed by the sea' (E-0268, the E-0082 shape; was TalkMsg081E_ThePiratesWereSwallowedBy)
TalkMsg081E_ThePiratesWereSwallowedBy::
    ld de, EVENT_THE_PIRATES_WERE_SWALLOWED_BY
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $081e ; '*: The pirates were swallowed by'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $087a ; '*: The pirates hid their loot'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg081F_TheresThisOldSailorManIn", ROMX

; Yold talk 28 (YoldTalkEvents): starts message $081F through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); about an old 'sailor man in the tavern who likes his grog too much.'. (C2,
; E-0374)
; starts message $081F through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'There's this old sailor man in the' (E-0268, the E-0082 shape; was
; TalkMsg081F_TheresThisOldSailorManIn)
TalkMsg081F_TheresThisOldSailorManIn::
    ld hl, $081f ; '*: There's this old sailor man'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 Talk_HowMayOurChurchServeYou", ROMX

; Yold talk 29 (YoldTalkEvents): sets wDataBank = $1F, then starts Script_HowMayOurChurch through
; StartScriptAtHL_B04 (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1);
; its message 'How may our church serve' is followed by a jump to Script_Priest in the data bank.
; (C2, E-0374)
; sets wDataBank = $1F, then starts Script_HowMayOurChurch (StartScriptAtHL_B04); its first message
; begins 'How may our church serve you?' (E-0271; was Talk_HowMayOurChurchServeYou) (E-0344: the
; address in its name dropped or read as the label there; was Talk_HowMayOurChurchServeYou;
; shortened from TalkScript_HowMayOurChurchServeYou)
; starts Script_HowMayOurChurch: '*: How may our church serve' (E-0248)
Talk_HowMayOurChurchServeYou::
    ld a, $1f
    ld [wDataBank], a
    ld hl, Script_HowMayOurChurch ; script '*: How may our church serve'
    ASSERT BANK(Script_HowMayOurChurch) == $10, "Script_HowMayOurChurch is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 TalkMsg0821_AllSortsOfPeopleComeHere", ROMX

; Yold talk 30 (YoldTalkEvents): starts message $0821 through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); 'All sorts of people come here from around the world.'. (C2, E-0374)
; starts message $0821 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'All sorts of people come here from' (E-0268, the E-0082 shape; was
; TalkMsg0821_AllSortsOfPeopleComeHere)
TalkMsg0821_AllSortsOfPeopleComeHere::
    ld hl, $0821 ; '*: All sorts of people come'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0822_IWentToPolonaAWhile", ROMX

; Yold talk 31 (YoldTalkEvents): starts message $0822 through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); 'I went to Polona a while back'. (C2, E-0374)
; starts message $0822 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'I went to Polona a while back' (E-0268, the E-0082 shape; was TalkMsg0822_IWentToPolonaAWhile)
TalkMsg0822_IWentToPolonaAWhile::
    ld hl, $0822 ; '*: I went to Polona a'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 YoldTalkEvents_Shop2", ROMX

; Yold talk 32: a shop: screen table 6, script data in bank $10, 'I offer quality merchandise'. (C2,
; E-0357; probed E-0374)
YoldTalkEvents_Shop2::
    ld a, $06
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_IOfferQualityMerchandise ; script '*: I offer quality merchandise. Would'
    ASSERT BANK(Script_IOfferQualityMerchandise) == $10, "Script_IOfferQualityMerchandise is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 TalkMsg0824_ThereIsALighthouseToThe", ROMX

; Yold talk 33 (YoldTalkEvents): when EVENT_SCENE_MERMAID_KINGDOM_05F is set starts message $0D13
; ('The lighthouse is out east.', still roamed by monsters though the MoonRock is back), otherwise
; message $0824 ('There is a lighthouse to the east'), through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1). (C2, E-0374)
; tests story flags (flag 005F then jr c,
; TalkMsg0824_ThereIsALighthouseToThe.call_start_message_command09_hl_b04); starts message $0824
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'There is a
; lighthouse to the east,' (E-0268, the E-0082 shape; was TalkMsg0824_ThereIsALighthouseToThe)
TalkMsg0824_ThereIsALighthouseToThe::
    ld de, EVENT_SCENE_MERMAID_KINGDOM_05F
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0824 ; '*: There is a lighthouse to'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0d13 ; '*: The lighthouse is out east.'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0825_MyShipSankInTheEastern", ROMX

; Yold talk 34 (YoldTalkEvents): starts message $0825 through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); 'My ship sank in the eastern sea.'. (C2, E-0374)
; starts message $0825 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'My ship sank in the eastern sea.' (E-0268, the E-0082 shape; was
; TalkMsg0825_MyShipSankInTheEastern)
TalkMsg0825_MyShipSankInTheEastern::
    ld hl, $0825 ; '*: My ship sank in the'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0826_TheOldManInTheTaverns", ROMX

; Yold talk 35 (YoldTalkEvents): starts message $0826 through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); about the old man in the tavern: 'He tells me all sorts of things.'. (C2, E-0374)
; starts message $0826 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'The old man in the tavern's neat!' (E-0268, the E-0082 shape; was
; TalkMsg0826_TheOldManInTheTaverns)
TalkMsg0826_TheOldManInTheTaverns::
    ld hl, $0826 ; '*: The old man in the'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0827_ThisPortUsedToBeLively", ROMX

; Yold talk 36 (YoldTalkEvents): when EVENT_SCENE_MERMAID_KINGDOM_05F is set starts message $087B
; ('The sea around here is safe now.'), otherwise message $0827 ('This port used to be lively in the
; past'), through StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the message
; word, wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1). (C2, E-0374)
; tests story flags (flag 005F then jr c,
; TalkMsg0827_ThisPortUsedToBeLively.call_start_message_command09_hl_b04); starts message $0827
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'This port used to be
; lively in' (E-0268, the E-0082 shape; was TalkMsg0827_ThisPortUsedToBeLively)
TalkMsg0827_ThisPortUsedToBeLively::
    ld de, EVENT_SCENE_MERMAID_KINGDOM_05F
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0827 ; '*: This port used to be'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $087b ; '*: The sea around here is'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0829_TheLighthouseHadTheMoonRock", ROMX

; Yold talk 37 (YoldTalkEvents): when EVENT_SCENE_MERMAID_KINGDOM_05F is set starts message $087C
; ('The MoonRock glows at night from atop the lighthouse again.'), otherwise message $0829 ('The
; lighthouse had the MoonRock'), through StartMessageCommand09HL_B04 (script command $09:
; wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1).
; (C2, E-0374)
; tests story flags (flag 005F then jr c,
; TalkMsg0829_TheLighthouseHadTheMoonRock.call_start_message_command09_hl_b04); starts message $0829
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'The lighthouse had
; the MoonRock installed at' (E-0268, the E-0082 shape; was TalkMsg0829_TheLighthouseHadTheMoonRock)
TalkMsg0829_TheLighthouseHadTheMoonRock::
    ld de, EVENT_SCENE_MERMAID_KINGDOM_05F
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0829 ; '*: The lighthouse had the MoonRock'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $087c ; '*: The MoonRock glows at night'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg082A_TheSeasLevelHasGoneDown", ROMX

; Yold talk 38 (YoldTalkEvents): when EVENT_THE_PIRATES_WERE_SWALLOWED_BY is set starts message
; $087D (the sea level 'has risen.'), otherwise message $082A (the sea level 'has gone down.'),
; through StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the message word,
; wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1). (C2, E-0374)
; tests story flags (flag 007A then jr c,
; TalkMsg082A_TheSeasLevelHasGoneDown.call_start_message_command09_hl_b04); starts message $082A
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'The sea's level has
; gone down. Many' (E-0268, the E-0082 shape; was TalkMsg082A_TheSeasLevelHasGoneDown)
TalkMsg082A_TheSeasLevelHasGoneDown::
    ld de, EVENT_THE_PIRATES_WERE_SWALLOWED_BY
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $082a ; '*: The sea's level has gone'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $087d ; '*: The sea's level has risen.'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg082B_ListenDidYouKnowMermaids", ROMX

; Yold talk 39 (YoldTalkEvents): starts message $082B through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); 'Mermaids appear to love dancing.'. (C2, E-0374)
; starts message $082B through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'Listen, did you know? Mermaids appear to' (E-0268, the E-0082 shape; was
; TalkMsg082B_ListenDidYouKnowMermaids)
TalkMsg082B_ListenDidYouKnowMermaids::
    ld hl, $082b ; '*: Listen, did you know? Mermaids'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg088D_HeroPeeredIntoTheOvenTwo", ROMX

; Yold talk 40 (YoldTalkEvents): starts message $088D through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); the hero peers into the oven ('Two shiny ...'). (C2, E-0374)
; starts message $088D through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 peered into the oven. Two shiny' (E-0268, the E-0082 shape; was
; TalkMsg088D_HeroPeeredIntoTheOvenTwo)
; starts Script_HeroTriedToCheck: '0 tried to check the chest.' (E-0248)
TalkMsg088D_HeroPeeredIntoTheOvenTwo::
    ld hl, $088d ; '0 peered into the oven. Two'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 Talk_HeroTriedToCheckTheChest", ROMX

; Yold talk 41 (YoldTalkEvents): starts Script_HeroTriedToCheck through StartScriptAtHL_B04
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1); that script shows
; message $082C (the hero 'tried to check the chest.') and then $082D 'Whoa! Hands off my
; merchandise!'. (C2, E-0374)
; starts Script_HeroTriedToCheck (StartScriptAtHL_B04); its first message begins '0 tried to check
; the chest.' (E-0271; was Talk_HeroTriedToCheckTheChest) (E-0344: the address in its name dropped
; or read as the label there; was Talk_HeroTriedToCheckTheChest; shortened from
; TalkScript_HeroTriedToCheckTheChest)
; starts Script_HeroTriedToCheck: '0 tried to check the chest.' (E-0248)
Talk_HeroTriedToCheckTheChest::
    ld hl, Script_HeroTriedToCheck ; script '0 tried to check the chest.'
    ASSERT BANK(Script_HeroTriedToCheck) == $10, "Script_HeroTriedToCheck is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 TalkMsg082E_HeroPeeredIntoTheBarrelIt", ROMX

; Yold talk 42 (YoldTalkEvents): starts message $082E through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); the hero peers into the barrel: 'It was filled with gigantic beans.'. (C2,
; E-0374)
; starts message $082E through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 peered into the barrel. It was' (E-0268, the E-0082 shape; was
; TalkMsg082E_HeroPeeredIntoTheBarrelIt)
TalkMsg082E_HeroPeeredIntoTheBarrelIt::
    ld hl, $082e ; '0 peered into the barrel. It'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 BarrelItem_TinyMedal_Flag0063", ROMX

; Yold talk 43 (YoldTalkEvents), a one-time barrel: StartTreasureFlagDE_B04 starts script command
; $0A (RunOneTimeTreasure) with wScriptParam0 = 2 (barrel), wScriptParam1 = ITEM_TINYMEDAL and story
; flag $0063 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1).
; That command gives the item and sets the flag when the flag is clear (group-0 message $A6), shows
; $A7 when the flag is already set and $A8 when the bag is full. (C2, E-0374)
; a one-time barrel: script command $0A with wScriptParam0 = 2 (kind) and wScriptParam1 = $2C, story
; flag $0063 in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the flag (message
; $A6 of group 0; $A7 when the flag is already set, $A8 when there is no room) (E-0269; was
; BarrelItem_TinyMedal_Flag0063)
BarrelItem_TinyMedal_Flag0063::
    ld a, $02
    ld [wScriptParam0], a
    ld a, $2c
    ld [wScriptParam1], a
    ld de, $0063
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 YoldTalkEvents_SecondInn", ROMX

; Yold talk 44, a second inn with the same code as YoldTalkEvents_Inn (talk 20): starts
; Script_WelcomeToOurInn_4 ('Welcome to our inn!', then the inn script Script_It_3 in the data bank)
; and sets wDataBank = $10. (C2, E-0369; probed E-0374)
; starts Script_WelcomeToOurInn_4: '*: Welcome to our inn!' (E-0248)
YoldTalkEvents_SecondInn::
    ld hl, Script_WelcomeToOurInn_4 ; script '*: Welcome to our inn!'
    ASSERT BANK(Script_WelcomeToOurInn_4) == $10, "Script_WelcomeToOurInn_4 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ld a, $10
    ld [wDataBank], a
    ret

SECTION "Bank 04 TalkMsg082F_ThisAreaWasALotMore", ROMX

; Yold talk 45 (YoldTalkEvents): when EVENT_THE_PIRATES_WERE_SWALLOWED_BY is set starts message
; $087E ('the shoals sank almost instantly.'), otherwise message $082F ('This area was a lot more
; lively in the old days'), through StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1
; = the message word, wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1). (C2, E-0374)
; tests story flags (flag 007A then jr c,
; TalkMsg082F_ThisAreaWasALotMore.call_start_message_command09_hl_b04); starts message $082F through
; StartMessageCommand09HL_B04 (script command $09); that string begins 'This area was a lot more
; lively' (E-0268, the E-0082 shape; was TalkMsg082F_ThisAreaWasALotMore)
TalkMsg082F_ThisAreaWasALotMore::
    ld de, EVENT_THE_PIRATES_WERE_SWALLOWED_BY
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $082f ; '*: This area was a lot'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $087e ; '*: For some reason, the shoals'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0830_WhenYoureOutAtSeaYou", ROMX

; Yold talk 46 (YoldTalkEvents): starts message $0830 through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); about seeing 'some peculiar sights.' at sea, among them a ghost ship. (C2,
; E-0374)
; starts message $0830 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'When you're out at sea, you get' (E-0268, the E-0082 shape; was TalkMsg0830_WhenYoureOutAtSeaYou)
; starts Script_SceneWhoAreYou (E-0248)
TalkMsg0830_WhenYoureOutAtSeaYou::
    ld hl, $0830 ; '*: When you're out at sea,'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 Talk_SceneWhoAreYou", ROMX

; Yold talk 47 (YoldTalkEvents): starts Script_SceneWhoAreYou through StartScriptAtHL_B04
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1); that script plays
; sound $28, waits 140 frames, runs SCRIPT_SCENE_WHO_ARE_YOU and walks objects 0-2. (C2, E-0374)
; starts Script_SceneWhoAreYou (StartScriptAtHL_B04) (E-0271; was Talk_SceneWhoAreYou) (E-0344: the
; address in its name dropped or read as the label there; was Talk_SceneWhoAreYou)
; starts Script_SceneWhoAreYou (E-0248)
Talk_SceneWhoAreYou::
    ld hl, Script_SceneWhoAreYou
    ASSERT BANK(Script_SceneWhoAreYou) == $10, "Script_SceneWhoAreYou is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 TalkMsg0834_WhenThatOldManGetsGrogged", ROMX

; Yold talk 48 (YoldTalkEvents): after EVENT_SCENE_MERMAID_KINGDOM_05F message $0D14 ('Another
; master was here with two monsters', naming Kameha); otherwise after EVENT_THE_PIRATES message
; $0842 (tired of the tales of the old man); otherwise message $0834 'When that old man gets
; grogged'. Each goes through StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the
; message word, wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1). (C2, E-0374)
; tests story flags (flag 005F then jr c,
; TalkMsg0834_WhenThatOldManGetsGrogged.call_start_message_command09_hl_b042; flag 006D then jr c,
; TalkMsg0834_WhenThatOldManGetsGrogged.call_start_message_command09_hl_b04); starts message $0834
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'When that old man
; gets grogged You' (E-0268, the E-0082 shape; was TalkMsg0834_WhenThatOldManGetsGrogged)
TalkMsg0834_WhenThatOldManGetsGrogged::
    ld de, EVENT_SCENE_MERMAID_KINGDOM_05F
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_THE_PIRATES
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

SECTION "Bank 04 TalkMsg0835_TheOldFellowThereTheInstant", ROMX

; Yold talk 49 (YoldTalkEvents): after EVENT_SCENE_MERMAID_KINGDOM_05F message $087F ('Did you hear?
; Pirates hid their treasure on the volcanic island.'); otherwise after
; EVENT_THE_PIRATES_WERE_SWALLOWED_BY message $0DC3 ('The shoals that ringed the volcano have
; suddenly disappeared.'); otherwise message $0835 ('The old fellow there, the instant he smells a
; sea monster', wakes up). Each goes through StartMessageCommand09HL_B04 (script command $09:
; wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1).
; (C2, E-0374)
; tests story flags (flag 005F then jr c,
; TalkMsg0835_TheOldFellowThereTheInstant.call_start_message_command09_hl_b042; flag 007A then jr c,
; TalkMsg0835_TheOldFellowThereTheInstant.call_start_message_command09_hl_b04); starts message $0835
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'The old fellow
; there, the instant he' (E-0268, the E-0082 shape; was TalkMsg0835_TheOldFellowThereTheInstant)
TalkMsg0835_TheOldFellowThereTheInstant::
    ld de, EVENT_SCENE_MERMAID_KINGDOM_05F
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_THE_PIRATES_WERE_SWALLOWED_BY
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

SECTION "Bank 04 TalkMsg0836_TheVolcanicIslandOffTheCoast", ROMX

; Yold talk 50 (YoldTalkEvents): starts message $0836 through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); 'The volcanic island off the coast is vicious to ships.'. (C2, E-0374)
; starts message $0836 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'The volcanic island off the coast is' (E-0268, the E-0082 shape; was
; TalkMsg0836_TheVolcanicIslandOffTheCoast)
TalkMsg0836_TheVolcanicIslandOffTheCoast::
    ld hl, $0836 ; '*: The volcanic island off the'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 YoldTalkEvents_ShowHnnnrHicGnnZzz", ROMX

; Yold talk 51, a sleeper: before the pirates' story it wakes only for a party monster of species
; $3C-$5B with a high byte (PartyHasSpeciesLo3CTo5BWithHiSet), otherwise mutters (message $0837,
; object 3 state 1); after EVENT_THE_PIRATES 'What are you here ...'; after the pirates were
; swallowed the species check picks between the mutter and a second waking script; after the mermaid
; kingdom scene message $0880. (C2, E-0357; probed E-0374)
YoldTalkEvents_ShowHnnnrHicGnnZzz::
    ld de, EVENT_SCENE_MERMAID_KINGDOM_05F
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld de, EVENT_THE_PIRATES_WERE_SWALLOWED_BY
    call TestFlagBit
    jr c, .call_party_has_species_lo3_c_to5_b_with_hi
    ld de, EVENT_THE_PIRATES
    call TestFlagBit
    jr c, .call_start_script_at_hl_b042
    call PartyHasSpeciesLo3CTo5BWithHiSet
    jr c, .call_start_script_at_hl_b04
    ld a, $01
    ld [wObject3 + OBJ_STATE], a
    ld hl, $0837 ; '*: Hnnnr… Hic… Gnn… Zzz… Gfffff…'
    call StartMessageCommand09HL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_ZzzZzzHuhWatch ; script '*: Zzz… Zzz… Huh! Watch out!'
    ASSERT BANK(Script_ZzzZzzHuhWatch) == $10, "Script_ZzzZzzHuhWatch is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b042:
    ld hl, Script_WhatAreYouHere ; script '*: What? Are you here for'
    ASSERT BANK(Script_WhatAreYouHere) == $10, "Script_WhatAreYouHere is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_party_has_species_lo3_c_to5_b_with_hi:
    call PartyHasSpeciesLo3CTo5BWithHiSet
    jr c, .call_start_script_at_hl_b043
    ld a, $01
    ld [wObject3 + OBJ_STATE], a
    ld hl, $0837 ; '*: Hnnnr… Hic… Gnn… Zzz… Gfffff…'
    call StartMessageCommand09HL_B04
    ret

.call_start_script_at_hl_b043:
    ld hl, Script_ZzzZzzHuhWatch_2 ; script '*: Zzz… Zzz… Huh! Watch out!'
    ASSERT BANK(Script_ZzzZzzHuhWatch_2) == $10, "Script_ZzzZzzHuhWatch_2 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0880 ; '*: What? You again? Back to'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 PartyHasSpeciesLo3CTo5BWithHiSet", ROMX

; Carry set when some party record (wPartyCount entries of wPartyList, read with LoadSRAMRecordWord
; with SRAM enabled) has a MON_SPECIES word whose high byte is non-zero and low byte is $3C-$5B (for
; ids up to $17F this is MONSTER_PETITEEL through MONSTER_STARFISH); A = 0 either way, carry clear
; and Z set when none does. SRAM is disabled on return. Its only caller is the sleeper of
; YoldTalkEvents_ShowHnnnrHicGnnZzz (twice). With wPartyCount = 0 the loop runs 256 times. (C2,
; E-0374)
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

SECTION "Bank 04 YoldTalkEvents_WhoAreYou", ROMX

; Yold talk 52: 'Who are you? This is ...' the first time (setting its flag), then 'You can keep
; trying'; after EVENT_SCENE_WATCH_OUT the watch-out scene script. (C2, E-0357; probed E-0374)
YoldTalkEvents_WhoAreYou::
    ld de, EVENT_SCENE_WATCH_OUT
    call TestFlagBit
    jr c, .call_start_script_at_hl_b042
    ld de, EVENT_WHO_ARE_YOU_THIS_IS
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_WhoAreYouThis ; script '*: Who are you? This is'
    ASSERT BANK(Script_WhoAreYouThis) == $10, "Script_WhoAreYouThis is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ld de, EVENT_WHO_ARE_YOU_THIS_IS
    call SetFlagBit
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_YouCanKeepTrying ; script '*: You can keep trying, but'
    ASSERT BANK(Script_YouCanKeepTrying) == $10, "Script_YouCanKeepTrying is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b042:
    ld hl, Script_SceneWatchOut
    ASSERT BANK(Script_SceneWatchOut) == $10, "Script_SceneWatchOut is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 ChestItem_Rib", ROMX

; Yold talk 53 (YoldTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_RIB and story flag $0067
; in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1). That command
; gives the item and sets the flag when the flag is clear (group-0 message $A0), shows $A1 when the
; flag is already set and $A2 when the bag is full. (C2, E-0374)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $1B, story flag $0067 in DE: when the flag is clear it gives item $1B (Rib) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_Rib)
ChestItem_Rib::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $1b
    ld [wScriptParam1], a
    ld de, $0067
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_LoveWater", ROMX

; Yold talk 54 (YoldTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_LOVEWATER and story flag
; $0068 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1). That
; command gives the item and sets the flag when the flag is clear (group-0 message $A0), shows $A1
; when the flag is already set and $A2 when the bag is full. (C2, E-0374)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $02, story flag $0068 in DE: when the flag is clear it gives item $02 (LoveWater) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was ChestItem_LoveWater)
ChestItem_LoveWater::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $02
    ld [wScriptParam1], a
    ld de, $0068
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_LoveWater_Flag0069", ROMX

; Yold talk 55 (YoldTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_LOVEWATER and story flag
; $0069 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1). That
; command gives the item and sets the flag when the flag is clear (group-0 message $A0), shows $A1
; when the flag is already set and $A2 when the bag is full. (C2, E-0374)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $02, story flag $0069 in DE: when the flag is clear it gives item $02 (LoveWater) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was ChestItem_LoveWater_Flag0069)
ChestItem_LoveWater_Flag0069::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $02
    ld [wScriptParam1], a
    ld de, $0069
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_ExitBell", ROMX

; Yold talk 56 (YoldTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_EXITBELL and story flag
; $006A in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1). That
; command gives the item and sets the flag when the flag is clear (group-0 message $A0), shows $A1
; when the flag is already set and $A2 when the bag is full. (C2, E-0374)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $2A, story flag $006A in DE: when the flag is clear it gives item $2A (ExitBell) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_ExitBell)
ChestItem_ExitBell::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2a
    ld [wScriptParam1], a
    ld de, $006a
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_MermScale", ROMX

; Yold talk 57 (YoldTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_MERMSCALE and story flag
; $006B in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1). That
; command gives the item and sets the flag when the flag is clear (group-0 message $A0), shows $A1
; when the flag is already set and $A2 when the bag is full. (C2, E-0374)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $46, story flag $006B in DE: when the flag is clear it gives item $46 (MermScale) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was ChestItem_MermScale)
ChestItem_MermScale::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $46
    ld [wScriptParam1], a
    ld de, $006b
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_Warp", ROMX

; Yold talk 58 (YoldTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_WARP and story flag
; $006C in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1). That
; command gives the item and sets the flag when the flag is clear (group-0 message $A0), shows $A1
; when the flag is already set and $A2 when the bag is full. (C2, E-0374)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $28, story flag $006C in DE: when the flag is clear it gives item $28 (Warp) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_Warp)
ChestItem_Warp::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $28
    ld [wScriptParam1], a
    ld de, $006c
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 TalkMsg0843_ISawAChildCrossThe", ROMX

; Yold talk 59 (YoldTalkEvents): starts message $0843 through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); 'I saw a child cross the sea on a giant clam.'. (C2, E-0374)
; starts message $0843 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'I saw a child cross the sea' (E-0268, the E-0082 shape; was TalkMsg0843_ISawAChildCrossThe)
TalkMsg0843_ISawAChildCrossThe::
    ld hl, $0843 ; '*: I saw a child cross'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0844_WatchMeDanceAndYoullWant", ROMX

; Yold talk 60 (YoldTalkEvents): starts message $0844 through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); 'Watch me dance,' the speaker says. (C2, E-0374)
; starts message $0844 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'Watch me dance, and you'll want to' (E-0268, the E-0082 shape; was
; TalkMsg0844_WatchMeDanceAndYoullWant)
TalkMsg0844_WatchMeDanceAndYoullWant::
    ld hl, $0844 ; '*: Watch me dance, and you'll'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 YoldTalkEvents_OfferMap41Warp", ROMX

; Yold talk 61: does nothing until EVENT_IN_THE_PAST_MERMAIDS_ARE is set (WarpToMap41 sets it); then
; starts Script_DoYouWantTo_2, which asks 'Do you want to go ...' and on yes says 'Close your eyes a
; little ...' and warps to map $41 (SCRIPT_WARP_MAP41), on no 'Come back for a visit'. (C2, E-0369;
; probed E-0374)
; starts Script_DoYouWantTo_2: '*: Do you want to go' (E-0248)
YoldTalkEvents_OfferMap41Warp::
    ld de, EVENT_IN_THE_PAST_MERMAIDS_ARE
    call TestFlagBit
    ret nc
    ld hl, Script_DoYouWantTo_2 ; script '*: Do you want to go'
    ASSERT BANK(Script_DoYouWantTo_2) == $10, "Script_DoYouWantTo_2 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 YoldTalkEvents_ShowThisIsTheMermaid", ROMX

; Yold talk 62: message $084E the first time (setting EVENT_THIS_IS_THE_MERMAID), then the mermaid
; script. (C2, E-0357; probed E-0374)
YoldTalkEvents_ShowThisIsTheMermaid::
    ld de, EVENT_THIS_IS_THE_MERMAID
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, $084e ; '*: This is the mermaid kingdom.'
    call StartMessageCommand09HL_B04
    ld de, EVENT_THIS_IS_THE_MERMAID
    call SetFlagBit
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_ThisIsTheMermaid ; script '*: This is the mermaid kingdom.'
    ASSERT BANK(Script_ThisIsTheMermaid) == $10, "Script_ThisIsTheMermaid is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 TalkMsg084F_IKnowNotAllHumansAre", ROMX

; Yold talk 63 (YoldTalkEvents): when EVENT_SCENE_CRATE is set starts message $0881 ('Our words of
; thanks could never do justice'), otherwise message $084F ('I know not all humans are bad'),
; through StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the message word,
; wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1). (C2, E-0374)
; tests story flags (flag 0076 then jr c,
; TalkMsg084F_IKnowNotAllHumansAre.call_start_message_command09_hl_b04); starts message $084F
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'I know not all
; humans are bad' (E-0268, the E-0082 shape; was TalkMsg084F_IKnowNotAllHumansAre)
TalkMsg084F_IKnowNotAllHumansAre::
    ld de, EVENT_SCENE_CRATE
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $084f ; '*: I know not all humans'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0881 ; '*: Our words of thanks could'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0850_ThePiratesCaughtUsInNets", ROMX

; Yold talk 64 (YoldTalkEvents): when EVENT_SCENE_CRATE is set starts message $0882 ('Mermaids and
; humans can live side by side in harmony again!'), otherwise message $0850 ('The pirates caught us
; in nets'), through StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the message
; word, wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1). (C2, E-0374)
; tests story flags (flag 0076 then jr c,
; TalkMsg0850_ThePiratesCaughtUsInNets.call_start_message_command09_hl_b04); starts message $0850
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'The pirates caught
; us in nets and' (E-0268, the E-0082 shape; was TalkMsg0850_ThePiratesCaughtUsInNets)
TalkMsg0850_ThePiratesCaughtUsInNets::
    ld de, EVENT_SCENE_CRATE
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0850 ; '*: The pirates caught us in'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0882 ; '*: Mermaids and humans can live'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0851_TheHarMirrorWasExquisite", ROMX

; Yold talk 65 (YoldTalkEvents): starts message $0851 through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); 'The HarMirror was exquisite.'. (C2, E-0374)
; starts message $0851 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'The HarMirror was exquisite. It was so' (E-0268, the E-0082 shape; was
; TalkMsg0851_TheHarMirrorWasExquisite)
TalkMsg0851_TheHarMirrorWasExquisite::
    ld hl, $0851 ; '*: The HarMirror was exquisite. It'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0852_TheMoonRockFellFromTheSky", ROMX

; Yold talk 66 (YoldTalkEvents): starts message $0852 through StartMessageCommand09HL_B04 (script
; command $09: wScriptParam0/1 = the message word, wScriptCommandType = 9, wScriptRunning = 1,
; wModeState = 1); 'The MoonRock fell from the sky.'. (C2, E-0374)
; starts message $0852 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'The MoonRock fell from the sky. It' (E-0268, the E-0082 shape; was
; TalkMsg0852_TheMoonRockFellFromTheSky)
TalkMsg0852_TheMoonRockFellFromTheSky::
    ld hl, $0852 ; '*: The MoonRock fell from the'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0853_ThePiratesSankWithTheirShip", ROMX

; Yold talk 67 (YoldTalkEvents): when EVENT_SCENE_CRATE is set starts message $0883 ('Thanks to you,
; the spectral ship sank again'), otherwise message $0853 ('The pirates sank with their ship.'),
; through StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the message word,
; wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1). (C2, E-0374)
; tests story flags (flag 0076 then jr c,
; TalkMsg0853_ThePiratesSankWithTheirShip.call_start_message_command09_hl_b04); starts message $0853
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'The pirates sank
; with their ship. However,' (E-0268, the E-0082 shape; was TalkMsg0853_ThePiratesSankWithTheirShip)
TalkMsg0853_ThePiratesSankWithTheirShip::
    ld de, EVENT_SCENE_CRATE
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0853 ; '*: The pirates sank with their'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0883 ; '*: Thanks to you, the spectral'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0854_WeMermaidsArePeacefulBeings", ROMX

; Yold talk 68 (YoldTalkEvents): when EVENT_SCENE_CRATE is set starts message $0884 ('That wandering
; ghost ship' is gone), otherwise message $0854 ('We mermaids are peaceful beings.'), through
; StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the message word,
; wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1). (C2, E-0374)
; tests story flags (flag 0076 then jr c,
; TalkMsg0854_WeMermaidsArePeacefulBeings.call_start_message_command09_hl_b04); starts message $0854
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'We mermaids are
; peaceful beings. We shy' (E-0268, the E-0082 shape; was TalkMsg0854_WeMermaidsArePeacefulBeings)
TalkMsg0854_WeMermaidsArePeacefulBeings::
    ld de, EVENT_SCENE_CRATE
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0854 ; '*: We mermaids are peaceful beings.'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0884 ; '*: That wandering ghost ship's gone!'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 YoldTalkEvents_SailorRingGiver", ROMX

; Yold talk 69: the sailor ring giver. Before the crate scene 'Welcome, young human' once, then
; message $0858; after EVENT_SCENE_CRATE it gives item $5F when the inventory has room (marking
; wInventorySortFlags bit 6) with its script, or message $0DC7 when it is full; after
; EVENT_HERO_RECEIVED_THE_SAILOR_RING message $0885. (C2, E-0357; probed E-0374)
YoldTalkEvents_SailorRingGiver::
    ld de, EVENT_HERO_RECEIVED_THE_SAILOR_RING
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_SCENE_CRATE
    call TestFlagBit
    jr c, .call_inventory_has_free_slot_check
    ld de, EVENT_WELCOME_YOUNG_HUMAN_I_HEARD
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, Script_WelcomeYoungHumanI ; script '*: Welcome, young human. I heard'
    ASSERT BANK(Script_WelcomeYoungHumanI) == $10, "Script_WelcomeYoungHumanI is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0858 ; '*: The MoonRock is on the'
    call StartMessageCommand09HL_B04
    ret

.call_inventory_has_free_slot_check:
    call InventoryHasFreeSlotCheck
    jr c, .read_inventory_sort_flags
    ld hl, $0dc7 ; '*: Welcome, my young hero! No'
    call StartMessageCommand09HL_B04
    ret

.read_inventory_sort_flags:
    ld [hl], $5f
    ld a, [wInventorySortFlags]
    set 6, a
    ld [wInventorySortFlags], a
    ld hl, Script_WelcomeMyYoungHero ; script '*: Welcome, my young hero! No'
    ASSERT BANK(Script_WelcomeMyYoungHero) == $10, "Script_WelcomeMyYoungHero is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $0885 ; '*: Welcome, young hero! No words'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 Talk_SceneSailorRing", ROMX

; Yold talk 70 (YoldTalkEvents): starts Script_SceneSailorRing through StartScriptAtHL_B04
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1); that script runs
; only the scene command SCRIPT_SCENE_SAILOR_RING. (C2, E-0374)
; starts Script_SceneSailorRing (StartScriptAtHL_B04) (E-0271; was Talk_SceneSailorRing) (E-0344:
; the address in its name dropped or read as the label there; was Talk_SceneSailorRing; named after
; the script it starts, Script_SceneSailorRing)
; starts Script_SceneSailorRing (E-0248)
Talk_SceneSailorRing::
    ld hl, Script_SceneSailorRing
    ASSERT BANK(Script_SceneSailorRing) == $10, "Script_SceneSailorRing is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_HowCouldWeDieBeforeEnjoying", ROMX

; Yold talk 71 (YoldTalkEvents): starts Script_HowCouldWeDie through StartScriptAtHL_B04
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1); that script shows
; 'How could we die before enjoying all the loot we amassed', runs encounter $17, sets
; EVENT_HOW_COULD_WE_DIE_BEFORE and runs SCRIPT_SCENE_PIRATE_GHOSTS. (C2, E-0374)
; starts Script_HowCouldWeDie (StartScriptAtHL_B04); its first message begins 'How could we die
; before enjoying' (E-0271; was Talk_HowCouldWeDieBeforeEnjoying) (E-0344: the address in its name
; dropped or read as the label there; was Talk_HowCouldWeDieBeforeEnjoying; shortened from
; TalkScript_HowCouldWeDieBeforeEnjoying)
; starts Script_HowCouldWeDie: '*: How could we die before' (E-0248)
Talk_HowCouldWeDieBeforeEnjoying::
    ld hl, Script_HowCouldWeDie ; script '*: How could we die before'
    ASSERT BANK(Script_HowCouldWeDie) == $10, "Script_HowCouldWeDie is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_TheTreasuresAreOursNoOne", ROMX

; Yold talk 72 (YoldTalkEvents): starts Script_TheTreasuresAreOurs through StartScriptAtHL_B04
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1); that script shows
; message $085A ('The treasures are ours'), runs encounter $17, sets EVENT_THE_TREASURES_ARE_OURS_NO
; and runs SCRIPT_SCENE_PIRATE_GHOSTS. (C2, E-0374)
; starts Script_TheTreasuresAreOurs (StartScriptAtHL_B04); its first message begins 'The treasures
; are ours No one' (E-0271; was Talk_TheTreasuresAreOursNoOne) (E-0344: the address in its name
; dropped or read as the label there; was Talk_TheTreasuresAreOursNoOne; shortened from
; TalkScript_TheTreasuresAreOursNoOne)
; starts Script_TheTreasuresAreOurs: '*: The treasures are ours… No' (E-0248)
Talk_TheTreasuresAreOursNoOne::
    ld hl, Script_TheTreasuresAreOurs ; script '*: The treasures are ours… No'
    ASSERT BANK(Script_TheTreasuresAreOurs) == $10, "Script_TheTreasuresAreOurs is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_ItNagsAndNagsThatWe", ROMX

; Yold talk 73 (YoldTalkEvents): starts Script_ItNagsAndNags through StartScriptAtHL_B04
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1); that script shows
; message $085C ('It nags and nags that we'), runs encounter $17, sets EVENT_IT_NAGS_AND_NAGS_THAT
; and runs SCRIPT_SCENE_PIRATE_GHOSTS. (C2, E-0374)
; starts Script_ItNagsAndNags (StartScriptAtHL_B04); its first message begins 'It nags and nags that
; we' (E-0271; was Talk_ItNagsAndNagsThatWe) (E-0344: the address in its name dropped or read as the
; label there; was Talk_ItNagsAndNagsThatWe; shortened from TalkScript_ItNagsAndNagsThatWe)
; starts Script_ItNagsAndNags: '*: It nags and nags that' (E-0248)
Talk_ItNagsAndNagsThatWe::
    ld hl, Script_ItNagsAndNags ; script '*: It nags and nags that'
    ASSERT BANK(Script_ItNagsAndNags) == $10, "Script_ItNagsAndNags is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 YoldTalkEvents_WhoDisturbsUs", ROMX

; Yold talk 74: the first time starts Script_WhoDisturbsUsIn ('Who disturbs us in our ...') and sets
; EVENT_WHO_DISTURBS_US_IN_OUR; afterwards Script_YouSeemToNot ('...You seem to not understand...').
; Both scripts run encounter $02, give an item (SCRIPT_GIVE_ITEM_BLINK) and set
; EVENT_GIVE_ITEM_BLINK. (C2, E-0369; probed E-0375)
; starts Script_WhoDisturbsUsIn: '*: Who disturbs us in our' (E-0248)
YoldTalkEvents_WhoDisturbsUs::
    ld de, EVENT_WHO_DISTURBS_US_IN_OUR
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_WhoDisturbsUsIn ; script '*: Who disturbs us in our'
    ASSERT BANK(Script_WhoDisturbsUsIn) == $10, "Script_WhoDisturbsUsIn is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ld de, EVENT_WHO_DISTURBS_US_IN_OUR
    call SetFlagBit
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_YouSeemToNot ; script '*: …You seem to not understand…'
    ASSERT BANK(Script_YouSeemToNot) == $10, "Script_YouSeemToNot is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 YoldTalkEvents_ShowHeroCheckedTheTreasure", ROMX

; Yold talk 75, a treasure: with room in the inventory it puts item $31 in the free slot (marking
; wInventorySortFlags bit 6) and starts 'Hero checked the treasure'; with a full inventory message
; $0888. (C2, E-0357; probed E-0375)
YoldTalkEvents_ShowHeroCheckedTheTreasure::
    call InventoryHasFreeSlotCheck
    jr c, .read_inventory_sort_flags
    ld hl, $0888 ; '0 checked the treasure chest. There'
    call StartMessageCommand09HL_B04
    ret

.read_inventory_sort_flags:
    ld [hl], $31
    ld a, [wInventorySortFlags]
    set 6, a
    ld [wInventorySortFlags], a
    ld hl, Script_HeroCheckedTheTreasure ; script '0 checked the treasure chest. 0'
    ASSERT BANK(Script_HeroCheckedTheTreasure) == $10, "Script_HeroCheckedTheTreasure is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 YoldTalkEvents_CheckCrate", ROMX

; Yold talk 76, a crate: starts Script_HeroCheckedTheCrate ('<PLAYER> checked the crate. There was
; ...', then SCRIPT_SET_TILES_FLAG_310, which redraws a 2 x 2 tile block and sets story flag $310)
; and sets EVENT_HERO_CHECKED_THE_CRATE_THERE. (C2, E-0369; probed E-0375)
; starts Script_HeroCheckedTheCrate: '0 checked the crate. There was' (E-0248)
YoldTalkEvents_CheckCrate::
    ld hl, Script_HeroCheckedTheCrate ; script '0 checked the crate. There was'
    ASSERT BANK(Script_HeroCheckedTheCrate) == $10, "Script_HeroCheckedTheCrate is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ld de, EVENT_HERO_CHECKED_THE_CRATE_THERE
    call SetFlagBit
    ret

SECTION "Bank 04 YoldTalkEvents_ResetFirstSlotState", ROMX

; Yold talk 77: clears byte 7 of the first sprite slot. (C2, E-0357; probed E-0375)
YoldTalkEvents_ResetFirstSlotState::
    xor a
    ld [wSpriteSlots + $7], a
    ret

SECTION "Bank 04 ChestItem_LogTwig", ROMX

; Yold talk 78 (YoldTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_LOGTWIG and story flag
; $0079 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1). That
; command gives the item and sets the flag when the flag is clear (group-0 message $A0), shows $A1
; when the flag is already set and $A2 when the bag is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $2E, story flag $0079 in DE: when the flag is clear it gives item $2E (LogTwig) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_LogTwig)
ChestItem_LogTwig::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2e
    ld [wScriptParam1], a
    ld de, $0079
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 YoldTalkEvents_ShowHeroCheckedThePedestal", ROMX

; Yold talk 79, a pedestal: after EVENT_THE_PIRATES_WERE_SWALLOWED_BY message $0867 ('The MoonRock
; sat on the pedestal'); before it, message $0865 ('It has a hole to accept an item') only when
; ITEM_MOONROCK ($31) is NOT in the inventory (FindTemp0InInventoryList leaves hTemp0 = $FF); when
; the inventory holds it the routine returns without a message (hTemp0 = its slot). Messages go
; through StartMessageCommand09HL_B04. (C2, E-0375)
YoldTalkEvents_ShowHeroCheckedThePedestal::
    ld de, EVENT_THE_PIRATES_WERE_SWALLOWED_BY
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

SECTION "Bank 04 YoldTalkEvents_KamehaThanks", ROMX

; Yold talk 80: at Y $30, sets EVENT_KAMEHA_WAHAHAHAH_THANKS_FOR_GUIDING and starts Kameha's thanks;
; at X $50 also moves the first slot and objects 1 and 2 to X $40. (C2, E-0357; probed E-0375)
YoldTalkEvents_KamehaThanks::
    ldh a, [hPlayerY]
    cp $30
    ret nz
    ld de, EVENT_KAMEHA_WAHAHAHAH_THANKS_FOR_GUIDING
    call SetFlagBit
    ld hl, Script_KamehaWahahahahThanksFor ; script 'Kameha: Wahahahah! Thanks for guiding me'
    ASSERT BANK(Script_KamehaWahahahahThanksFor) == $10, "Script_KamehaWahahahahThanksFor is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ldh a, [hPlayerX]
    cp $50
    ret nz
    ld a, $40
    ld [wSpriteSlots + $b], a
    ld [wObject1 + OBJ_X], a
    ld [wObject2 + OBJ_X], a
    ret

SECTION "Bank 04 Talk_KamehaUrkHowYouCatchUp", ROMX

; Yold talk 81 (YoldTalkEvents): starts Script_KamehaUrkHowYou (message $0869 ('Kameha: Urk! How you
; catch up?'), the crew walks, message $086A, then SCRIPT_SCENE_CREW_FOLLOWS) through
; StartScriptAtHL_B04 (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1).
; (C2, E-0375)
; starts Script_KamehaUrkHowYou (StartScriptAtHL_B04); its first message begins 'Kameha Urk! How you
; catch up?' (E-0271; was Talk_KamehaUrkHowYouCatchUp) (E-0344: the address in its name dropped or
; read as the label there; was Talk_KamehaUrkHowYouCatchUp; shortened from
; TalkScript_KamehaUrkHowYouCatchUp)
; starts Script_KamehaUrkHowYou: 'Kameha: Urk! How you catch up?' (E-0248)
Talk_KamehaUrkHowYouCatchUp::
    ld hl, Script_KamehaUrkHowYou ; script 'Kameha: Urk! How you catch up?'
    ASSERT BANK(Script_KamehaUrkHowYou) == $10, "Script_KamehaUrkHowYou is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_KamehaArrrrhClearTheWayIm", ROMX

; Yold talk 82 (YoldTalkEvents): starts Script_KamehaArrrrhClearThe (message $086B ('Kameha: Arrrrh,
; clear the way!'), SCRIPT_SCENE_KAMEHA_FLEES, then message $0891 ('Kameha: Aiyeeeeeh...')) through
; StartScriptAtHL_B04 (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1).
; (C2, E-0375)
; starts Script_KamehaArrrrhClearThe (StartScriptAtHL_B04); its first message begins 'Kameha Arrrrh,
; clear the way! I'm' (E-0271; was Talk_KamehaArrrrhClearTheWayIm) (E-0344: the address in its name
; dropped or read as the label there; was Talk_KamehaArrrrhClearTheWayIm; shortened from
; TalkScript_KamehaArrrrhClearTheWayIm)
; starts Script_KamehaArrrrhClearThe: 'Kameha: Arrrrh, clear the way! I'm' (E-0248)
Talk_KamehaArrrrhClearTheWayIm::
    ld hl, Script_KamehaArrrrhClearThe ; script 'Kameha: Arrrrh, clear the way! I'm'
    ASSERT BANK(Script_KamehaArrrrhClearThe) == $10, "Script_KamehaArrrrhClearThe is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_SceneMermaidKingdom", ROMX

; Yold talk 83 (YoldTalkEvents): starts Script_SceneMermaidKingdom (a 140-frame wait, then
; SCRIPT_SCENE_MERMAID_KINGDOM) through StartScriptAtHL_B04 (wScriptPointerLo/Hi = the script,
; wScriptStartRequest = $80, wModeState = 1). (C2, E-0375)
; starts Script_SceneMermaidKingdom (StartScriptAtHL_B04) (E-0271; was Talk_SceneMermaidKingdom)
; (E-0344: the address in its name dropped or read as the label there; was Talk_SceneMermaidKingdom;
; named after the script it starts, Script_SceneMermaidKingdom)
; starts Script_SceneMermaidKingdom (E-0248)
Talk_SceneMermaidKingdom::
    ld hl, Script_SceneMermaidKingdom
    ASSERT BANK(Script_SceneMermaidKingdom) == $10, "Script_SceneMermaidKingdom is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 ChestItem_Repellent", ROMX

; Yold talk 84 (YoldTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_REPELLENT and story flag
; $00E0 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1). That
; command gives the item and sets the flag when the flag is clear (group-0 message $A0), shows $A1
; when the flag is already set and $A2 when the bag is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $20, story flag $00E0 in DE: when the flag is clear it gives item $20 (Repellent) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was ChestItem_Repellent)
ChestItem_Repellent::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $20
    ld [wScriptParam1], a
    ld de, $00e0
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_Warp_Flag00E1", ROMX

; Yold talk 85 (YoldTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_WARP and story flag
; $00E1 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1). That
; command gives the item and sets the flag when the flag is clear (group-0 message $A0), shows $A1
; when the flag is already set and $A2 when the bag is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $28, story flag $00E1 in DE: when the flag is clear it gives item $28 (Warp) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_Warp_Flag00E1)
ChestItem_Warp_Flag00E1::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $28
    ld [wScriptParam1], a
    ld de, $00e1
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_WorldLeaf", ROMX

; Yold talk 86 (YoldTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_WORLDLEAF and story flag
; $00E2 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1). That
; command gives the item and sets the flag when the flag is clear (group-0 message $A0), shows $A1
; when the flag is already set and $A2 when the bag is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $0C, story flag $00E2 in DE: when the flag is clear it gives item $0C (WorldLeaf) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was ChestItem_WorldLeaf)
ChestItem_WorldLeaf::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $0c
    ld [wScriptParam1], a
    ld de, $00e2
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_LifeAcorn", ROMX

; Yold talk 87 (YoldTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_LIFEACORN and story flag
; $00E3 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1). That
; command gives the item and sets the flag when the flag is clear (group-0 message $A0), shows $A1
; when the flag is already set and $A2 when the bag is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $11, story flag $00E3 in DE: when the flag is clear it gives item $11 (LifeAcorn) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was ChestItem_LifeAcorn)
ChestItem_LifeAcorn::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $11
    ld [wScriptParam1], a
    ld de, $00e3
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_DEFseed", ROMX

; Yold talk 88 (YoldTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_DEFSEED and story flag
; $00E4 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1). That
; command gives the item and sets the flag when the flag is clear (group-0 message $A0), shows $A1
; when the flag is already set and $A2 when the bag is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $0E, story flag $00E4 in DE: when the flag is clear it gives item $0E (DEFseed) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_DEFseed)
ChestItem_DEFseed::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $0e
    ld [wScriptParam1], a
    ld de, $00e4
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 TalkMsg088C_HeroPeeredIntoTheVaseThere", ROMX

; Yold talk 89 (YoldTalkEvents): starts message $088C ('<BUF0> peered into the vase. There') through
; StartMessageCommand09HL_B04 (script command 9 with the word in wScriptParam0/wScriptParam1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0375)
; starts message $088C through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 peered into the vase. There were' (E-0268, the E-0082 shape; was
; TalkMsg088C_HeroPeeredIntoTheVaseThere)
TalkMsg088C_HeroPeeredIntoTheVaseThere::
    ld hl, $088c ; '0 peered into the vase. There'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 ChestItem_WorldDew", ROMX

; Yold talk 90 (YoldTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_WORLDDEW and story flag
; $00E5 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1). That
; command gives the item and sets the flag when the flag is clear (group-0 message $A0), shows $A1
; when the flag is already set and $A2 when the bag is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $03, story flag $00E5 in DE: when the flag is clear it gives item $03 (WorldDew) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_WorldDew)
ChestItem_WorldDew::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $03
    ld [wScriptParam1], a
    ld de, $00e5
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_War", ROMX

; Yold talk 91 (YoldTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_WAR and story flag $00E6
; in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1). That command
; gives the item and sets the flag when the flag is clear (group-0 message $A0), shows $A1 when the
; flag is already set and $A2 when the bag is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $5C, story flag $00E6 in DE: when the flag is clear it gives item $5C (War) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_War)
ChestItem_War::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5c
    ld [wScriptParam1], a
    ld de, $00e6
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 VaseItem_Antidote", ROMX

; Yold talk 92 (YoldTalkEvents), a one-time vase: StartTreasureFlagDE_B04 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 1 (vase), wScriptParam1 = ITEM_ANTIDOTE and story flag
; $00E7 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1). That
; command gives the item and sets the flag when the flag is clear (group-0 message $A3), shows $A4
; when the flag is already set and $A5 when the bag is full. (C2, E-0375)
; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $06, story
; flag $00E7 in DE: when the flag is clear it gives item $06 (Antidote) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; VaseItem_Antidote)
VaseItem_Antidote::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $06
    ld [wScriptParam1], a
    ld de, $00e7
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 VaseItem_LoveWater", ROMX

; Yold talk 93 (YoldTalkEvents), a one-time vase: StartTreasureFlagDE_B04 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 1 (vase), wScriptParam1 = ITEM_LOVEWATER and story flag
; $00E8 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1). That
; command gives the item and sets the flag when the flag is clear (group-0 message $A3), shows $A4
; when the flag is already set and $A5 when the bag is full. (C2, E-0375)
; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $02, story
; flag $00E8 in DE: when the flag is clear it gives item $02 (LoveWater) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; VaseItem_LoveWater)
VaseItem_LoveWater::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $02
    ld [wScriptParam1], a
    ld de, $00e8
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 VaseItem_Warp", ROMX

; Yold talk 94 (YoldTalkEvents), a one-time vase: StartTreasureFlagDE_B04 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 1 (vase), wScriptParam1 = ITEM_WARP and story flag $00F2
; in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1). That command
; gives the item and sets the flag when the flag is clear (group-0 message $A3), shows $A4 when the
; flag is already set and $A5 when the bag is full. (C2, E-0375)
; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $28, story
; flag $00F2 in DE: when the flag is clear it gives item $28 (Warp) and sets the flag (message $A3
; of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; VaseItem_Warp)
VaseItem_Warp::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $28
    ld [wScriptParam1], a
    ld de, $00f2
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 TalkMsg0861_HeroPeeredIntoTheBarrelA", ROMX

; Yold talk 95 (YoldTalkEvents): starts message $0861 ('<BUF0> peered into the barrel. A') through
; StartMessageCommand09HL_B04 (script command 9 with the word in wScriptParam0/wScriptParam1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0375)
; starts message $0861 through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 peered into the barrel. A mummified' (E-0268, the E-0082 shape; was
; TalkMsg0861_HeroPeeredIntoTheBarrelA)
TalkMsg0861_HeroPeeredIntoTheBarrelA::
    ld hl, $0861 ; '0 peered into the barrel. A'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 BarrelItem_BadMeat", ROMX

; Yold talk 96 (YoldTalkEvents), a one-time barrel: StartTreasureFlagDE_B04 starts script command
; $0A (RunOneTimeTreasure) with wScriptParam0 = 2 (barrel), wScriptParam1 = ITEM_BADMEAT and story
; flag $00E9 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1).
; That command gives the item and sets the flag when the flag is clear (group-0 message $A6), shows
; $A7 when the flag is already set and $A8 when the bag is full. (C2, E-0375)
; a one-time barrel: script command $0A with wScriptParam0 = 2 (kind) and wScriptParam1 = $1D, story
; flag $00E9 in DE: when the flag is clear it gives item $1D (BadMeat) and sets the flag (message
; $A6 of group 0; $A7 when the flag is already set, $A8 when there is no room) (E-0269; was
; BarrelItem_BadMeat)
BarrelItem_BadMeat::
    ld a, $02
    ld [wScriptParam0], a
    ld a, $1d
    ld [wScriptParam1], a
    ld de, $00e9
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 BarrelItem_PorkChop", ROMX

; Yold talk 97 (YoldTalkEvents), a one-time barrel: StartTreasureFlagDE_B04 starts script command
; $0A (RunOneTimeTreasure) with wScriptParam0 = 2 (barrel), wScriptParam1 = ITEM_PORKCHOP and story
; flag $00EA in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1).
; That command gives the item and sets the flag when the flag is clear (group-0 message $A6), shows
; $A7 when the flag is already set and $A8 when the bag is full. (C2, E-0375)
; a one-time barrel: script command $0A with wScriptParam0 = 2 (kind) and wScriptParam1 = $1A, story
; flag $00EA in DE: when the flag is clear it gives item $1A (PorkChop) and sets the flag (message
; $A6 of group 0; $A7 when the flag is already set, $A8 when there is no room) (E-0269; was
; BarrelItem_PorkChop)
BarrelItem_PorkChop::
    ld a, $02
    ld [wScriptParam0], a
    ld a, $1a
    ld [wScriptParam1], a
    ld de, $00ea
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_OrcaCape", ROMX

; Yold talk 98 (YoldTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_ORCACAPE and story flag
; $00EB in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1). That
; command gives the item and sets the flag when the flag is clear (group-0 message $A0), shows $A1
; when the flag is already set and $A2 when the bag is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $51, story flag $00EB in DE: when the flag is clear it gives item $51 (OrcaCape) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_OrcaCape)
ChestItem_OrcaCape::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $51
    ld [wScriptParam1], a
    ld de, $00eb
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_Repellent_Flag00EC", ROMX

; Yold talk 99 (YoldTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_REPELLENT and story flag
; $00EC in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1). That
; command gives the item and sets the flag when the flag is clear (group-0 message $A0), shows $A1
; when the flag is already set and $A2 when the bag is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $20, story flag $00EC in DE: when the flag is clear it gives item $20 (Repellent) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was ChestItem_Repellent_Flag00EC)
ChestItem_Repellent_Flag00EC::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $20
    ld [wScriptParam1], a
    ld de, $00ec
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_WorldLeaf_Flag00ED", ROMX

; Yold talk 100 (YoldTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts script command
; $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_WORLDLEAF and story
; flag $00ED in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1).
; That command gives the item and sets the flag when the flag is clear (group-0 message $A0), shows
; $A1 when the flag is already set and $A2 when the bag is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $0C, story flag $00ED in DE: when the flag is clear it gives item $0C (WorldLeaf) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was ChestItem_WorldLeaf_Flag00ED)
ChestItem_WorldLeaf_Flag00ED::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $0c
    ld [wScriptParam1], a
    ld de, $00ed
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_AGLseed", ROMX

; Yold talk 101 (YoldTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts script command
; $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_AGLSEED and story
; flag $00EE in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1).
; That command gives the item and sets the flag when the flag is clear (group-0 message $A0), shows
; $A1 when the flag is already set and $A2 when the bag is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $0F, story flag $00EE in DE: when the flag is clear it gives item $0F (AGLseed) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_AGLseed)
ChestItem_AGLseed::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $0f
    ld [wScriptParam1], a
    ld de, $00ee
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 BarrelItem_Potion", ROMX

; Yold talk 102 (YoldTalkEvents), a one-time barrel: StartTreasureFlagDE_B04 starts script command
; $0A (RunOneTimeTreasure) with wScriptParam0 = 2 (barrel), wScriptParam1 = ITEM_POTION and story
; flag $00EF in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1).
; That command gives the item and sets the flag when the flag is clear (group-0 message $A6), shows
; $A7 when the flag is already set and $A8 when the bag is full. (C2, E-0375)
; a one-time barrel: script command $0A with wScriptParam0 = 2 (kind) and wScriptParam1 = $04, story
; flag $00EF in DE: when the flag is clear it gives item $04 (Potion) and sets the flag (message $A6
; of group 0; $A7 when the flag is already set, $A8 when there is no room) (E-0269; was
; BarrelItem_Potion)
BarrelItem_Potion::
    ld a, $02
    ld [wScriptParam0], a
    ld a, $04
    ld [wScriptParam1], a
    ld de, $00ef
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 BarrelItem_INTseed", ROMX

; Yold talk 103 (YoldTalkEvents), a one-time barrel: StartTreasureFlagDE_B04 starts script command
; $0A (RunOneTimeTreasure) with wScriptParam0 = 2 (barrel), wScriptParam1 = ITEM_INTSEED and story
; flag $00F0 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1).
; That command gives the item and sets the flag when the flag is clear (group-0 message $A6), shows
; $A7 when the flag is already set and $A8 when the bag is full. (C2, E-0375)
; a one-time barrel: script command $0A with wScriptParam0 = 2 (kind) and wScriptParam1 = $10, story
; flag $00F0 in DE: when the flag is clear it gives item $10 (INTseed) and sets the flag (message
; $A6 of group 0; $A7 when the flag is already set, $A8 when there is no room) (E-0269; was
; BarrelItem_INTseed)
BarrelItem_INTseed::
    ld a, $02
    ld [wScriptParam0], a
    ld a, $10
    ld [wScriptParam1], a
    ld de, $00f0
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 TalkMsg0862_HeroPeeredIntoTheBarrelThere", ROMX

; Yold talk 104 (YoldTalkEvents): starts message $0862 ('<BUF0> peered into the barrel. There')
; through StartMessageCommand09HL_B04 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0375)
; starts message $0862 through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 peered into the barrel. There were' (E-0268, the E-0082 shape; was
; TalkMsg0862_HeroPeeredIntoTheBarrelThere)
TalkMsg0862_HeroPeeredIntoTheBarrelThere::
    ld hl, $0862 ; '0 peered into the barrel. There'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0864_HeroCheckedTheLedgerVoyage", ROMX

; Yold talk 105 (YoldTalkEvents): starts message $0864 ('<BUF0> checked the ledger.') through
; StartMessageCommand09HL_B04 (script command 9 with the word in wScriptParam0/wScriptParam1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0375)
; starts message $0864 through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 checked the ledger. Voyage Log Sunrise' (E-0268, the E-0082 shape; was
; TalkMsg0864_HeroCheckedTheLedgerVoyage)
; starts Script_SceneKamehaEscape (E-0248)
TalkMsg0864_HeroCheckedTheLedgerVoyage::
    ld hl, $0864 ; '0 checked the ledger. 'Voyage Log…'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 YoldTalkEvents_KamehaEscape", ROMX

; Yold talk 106: starts Script_SceneKamehaEscape (SCRIPT_SCENE_KAMEHA_ESCAPE), removes ITEM_MOONROCK
; ($31) from the inventory (FindTemp0InInventoryList, then RemoveInventorySlotShiftDown on the slot
; found) and sets EVENT_THE_PIRATES_WERE_SWALLOWED_BY. The slot is not checked: with no
; ITEM_MOONROCK, hTemp0 is $FF when RemoveInventorySlotShiftDown runs. (C2, E-0369; probed E-0375)
; starts Script_SceneKamehaEscape (E-0248)
YoldTalkEvents_KamehaEscape::
    ld hl, Script_SceneKamehaEscape
    ASSERT BANK(Script_SceneKamehaEscape) == $10, "Script_SceneKamehaEscape is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ld a, $31
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    farcall RemoveInventorySlotShiftDown
    ld de, EVENT_THE_PIRATES_WERE_SWALLOWED_BY
    call SetFlagBit
    ret

SECTION "Bank 04 TalkMsg00FF_Composing", ROMX

; Yold talk 107 (YoldTalkEvents): starts message $00FF (word $00FF: group 0, string $FF; the
; generated comment reads it as 'Composing') through StartMessageCommand09HL_B04 (script command 9
; with the word in wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0375)
; starts message $00FF through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'Composing' (E-0268, the E-0082 shape; was TalkMsg00FF_Composing)
; starts Script_ThickSuctionCuppedTentacles: 'Thick, suction- cupped tentacles snaked out' (E-0248)
TalkMsg00FF_Composing::
    ld hl, $00ff ; 'Composing'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 Talk_ThickSuctionCuppedTentacles", ROMX

; Yold talk 108 (YoldTalkEvents): starts Script_ThickSuctionCuppedTentacles (message $0893 ('Thick,
; suction- cupped tentacles snaked out'), encounter $1E, then sets
; EVENT_THICK_SUCTION_CUPPED_TENTACLES_SNAKED) through StartScriptAtHL_B04 (wScriptPointerLo/Hi =
; the script, wScriptStartRequest = $80, wModeState = 1). (C2, E-0375)
; starts Script_ThickSuctionCuppedTentacles (StartScriptAtHL_B04); its first message begins 'Thick,
; suction- cupped tentacles snaked out' (E-0271; was Talk_ThickSuctionCuppedTentacles) (E-0344: the
; address in its name dropped or read as the label there; was Talk_ThickSuctionCuppedTentacles;
; shortened from TalkScript_ThickSuctionCuppedTentacles)
; starts Script_ThickSuctionCuppedTentacles: 'Thick, suction- cupped tentacles snaked out' (E-0248)
Talk_ThickSuctionCuppedTentacles::
    ld hl, Script_ThickSuctionCuppedTentacles ; script 'Thick, suction- cupped tentacles snaked out'
    ASSERT BANK(Script_ThickSuctionCuppedTentacles) == $10, "Script_ThickSuctionCuppedTentacles is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 YoldTalkEvents_Church", ROMX

; Yold talk 109, the church: 'Our church is impoverished' the first time (setting its flag), then 'I
; am a servant'; script data in bank $1F. (C2, E-0357; probed E-0375)
YoldTalkEvents_Church::
    ld a, $1f
    ld [wDataBank], a
    ld de, EVENT_OUR_CHURCH_IS_IMPOVERISHED_SO_202
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_OurChurchIsImpoverished_2 ; script '*: Our church is impoverished, so'
    ASSERT BANK(Script_OurChurchIsImpoverished_2) == $10, "Script_OurChurchIsImpoverished_2 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ld de, EVENT_OUR_CHURCH_IS_IMPOVERISHED_SO_202
    call SetFlagBit
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_IAmAServant_3 ; script '*: I am a servant to'
    ASSERT BANK(Script_IAmAServant_3) == $10, "Script_IAmAServant_3 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 KalkaTalkEvents", ROMX

; Talk category 2 (DispatchTalkEvent_Kalka far-calls it): jumps through its table of 70 handlers by
; wTalkEventGroup, with no range check. The handlers cover the people, inns, item shop, churches,
; ovens, dressers, vases and chests of Kalka and Asiya, the King and his castle, and the thieves
; scenes (messages mostly $0130-$01C0, plus $0D07-$0D0B and $0037). (C1, E-0375)
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
    dw KalkaTalkEvents_Inn
    dw TalkMsg0139_TheKingCalledACircusTroupe
    dw TalkMsg013A_ThisIsAsiyaTheDesertFlower
    dw TalkMsg013B_OurKingCameIntoAnEnormous
    dw TalkMsg013C_ISawALakeLikeA
    dw TalkMsg013D_StrongMonstersAreInTheWell
    dw TalkMsg013E_OurKingHasBeenAFan
    dw TalkMsg013F_TheCircusMasterWasTrying
    dw KalkaTalkEvents_ItemShop
    dw TalkMsg0140_NoOneEntersTheCastleWithout
    dw TalkMsg0141_IfYouWantToGetIn
    dw TalkMsg0142_DidYouWantSomethingHoney
    dw TalkMsg0143_WhenWeGetAHotSpell
    dw KalkaTalkEvents_Church
    dw KalkaTalkEvents_Leader
    dw TalkMsg014F_HeroPeeredIntoTheVaseIt
    dw VaseItem_Antidote_Flag0047
    dw TalkMsg0137_HeroCheckedTheOvenASharp_04
    dw IfFlag056Msg018F_WeDidntHelpTheThievesOne
    dw TalkMsg01BE_HeroCheckedTheDresserThere
    dw TalkMsg0037_HeroTriedToOpenTheChest_04
    dw KalkaTalkEvents_SecondInn
    dw TalkMsg0150_IHeardThatTheThievesDisappear
    dw TalkMsg0154_SeveralOfOurMembersCameBack
    dw TalkMsg0155_WhenTheThievesRaidedUsWe
    dw TalkMsg0156_IWonderIfTheOthersAre
    dw TalkMsg0157_HehDidYouSeeTheLooks
    dw TalkMsg0158_ThisIsTheKingsTreasuryNo
    dw TalkMsg0159_WhatSeeHisMajestysTreasure
    dw KalkaTalkEvents_Snooping
    dw TalkMsg015A_HisMajestyIsHonestAndMost
    dw KalkaTalkEvents_PoorChurchScene
    dw TalkMsg015F_HeroCheckedTheDresserThere
    dw KalkaTalkEvents_King
    dw TalkMsg0166_ThatFoolIsATerribleSwindler
    dw TalkMsg0167_HumphAMirageLakeHeSays
    dw KalkaTalkEvents_CanalGate
    dw VaseItem_Herb_Flag004B
    dw VaseItem_PorkChop
    dw VaseItem_TinyMedal
    dw VaseItem_Bookmark
    dw ChestItem_ExitBell_Flag004F
    dw ChestItem_Wind
    dw ChestItem_WarpWing
    dw ChestItem_AGL
    dw KalkaTalkEvents_MakingANewHome
    dw KalkaTalkEvents_WhereIsEverybody
    dw KalkaTalkEvents_MonstersInTow
    dw TalkMsg0194_ThievesDroveUsFromOurHomes
    dw TalkMsg0195_TheLeaderOfTheThievesIs
    dw KalkaTalkEvents_MonsterFan
    dw TalkMsg01B5_KyoohSwimmingInADesertThis
    dw TalkMsg01BC_HeroCheckedTheTreasureChest
    dw TalkMsg01BD_HeroPeeredIntoTheVaseIt
    dw TalkMsg01C0_HeroCheckedTheTreasureChest
    dw TalkMsg01BF_HeroPeeredIntoTheVaseThe
    dw VaseItem_BeefJerky
    dw KalkaTalkEvents_RivalFade
    dw KalkaTalkEvents_WaitStoryFlagsPlus61
    dw KalkaTalkEvents_Church2

; Kalka talk 0 (KalkaTalkEvents): starts message $0130 ('This is Kalka, an oasis') through
; StartMessageCommand09HL_B04 (script command 9 with the word in wScriptParam0/wScriptParam1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0375)
; starts message $0130 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'This is Kalka, an oasis village.' (E-0268, the E-0082 shape; was
; TalkMsg0130_ThisIsKalkaAnOasisVillage)
TalkMsg0130_ThisIsKalkaAnOasisVillage::
    ld hl, $0130 ; '*: This is Kalka, an oasis'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0131_AThievingBandRunsAmokHere", ROMX

; Kalka talk 1 (KalkaTalkEvents): message $01A3 ('The King caught the thieves!') once
; EVENT_SCENE_RIVAL_DEFEATED_05A is set, otherwise message $0131 ('A thieving band runs amok').
; Messages go through StartMessageCommand09HL_B04 (script command 9, wModeState = 1). (C2, E-0375)
; tests story flags (flag 005A then jr c,
; TalkMsg0131_AThievingBandRunsAmokHere.call_start_message_command09_hl_b04); starts message $0131
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'A thieving band runs
; amok here. It's' (E-0268, the E-0082 shape; was TalkMsg0131_AThievingBandRunsAmokHere)
TalkMsg0131_AThievingBandRunsAmokHere::
    ld de, EVENT_SCENE_RIVAL_DEFEATED_05A
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0131 ; '*: A thieving band runs amok'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $01a3 ; '*: The King caught the thieves!'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0132_PardonAPlugForANavel", ROMX

; Kalka talk 2 (KalkaTalkEvents): message $01A4 ('The last king was a') once
; EVENT_SCENE_RIVAL_DEFEATED_05A is set, otherwise message $0132 ('Pardon? A plug for a'). Messages
; go through StartMessageCommand09HL_B04 (script command 9, wModeState = 1). (C2, E-0375)
; tests story flags (flag 005A then jr c,
; TalkMsg0132_PardonAPlugForANavel.call_start_message_command09_hl_b04); starts message $0132
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'Pardon? A plug for a
; navel? Sorry,' (E-0268, the E-0082 shape; was TalkMsg0132_PardonAPlugForANavel)
TalkMsg0132_PardonAPlugForANavel::
    ld de, EVENT_SCENE_RIVAL_DEFEATED_05A
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0132 ; '*: Pardon? A plug for a'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $01a4 ; '*: The last king was a'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0133_TheOasisWaterTravelsThrough", ROMX

; Kalka talk 3 (KalkaTalkEvents): starts message $0133 (on the oasis water travelling through an
; underground canal) through StartMessageCommand09HL_B04 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0375)
; starts message $0133 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'The oasis water travels through an underground' (E-0268, the E-0082 shape; was
; TalkMsg0133_TheOasisWaterTravelsThrough)
TalkMsg0133_TheOasisWaterTravelsThrough::
    ld hl, $0133 ; '*: The oasis' water travels through'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0134_TheLeaderOfTheThievesIs", ROMX

; Kalka talk 4 (KalkaTalkEvents): message $01A5 ('We recovered everything that was') once
; EVENT_SCENE_RIVAL_DEFEATED_05A is set, otherwise message $0134 ('The leader of the thieves').
; Messages go through StartMessageCommand09HL_B04 (script command 9, wModeState = 1). (C2, E-0375)
; tests story flags (flag 005A then jr c,
; TalkMsg0134_TheLeaderOfTheThievesIs.call_start_message_command09_hl_b04); starts message $0134
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'The leader of the
; thieves is a' (E-0268, the E-0082 shape; was TalkMsg0134_TheLeaderOfTheThievesIs)
TalkMsg0134_TheLeaderOfTheThievesIs::
    ld de, EVENT_SCENE_RIVAL_DEFEATED_05A
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0134 ; '*: The leader of the thieves'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $01a5 ; '*: We recovered everything that was'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0135_TheLogsNavelWhatIsThat", ROMX

; Kalka talk 5 (KalkaTalkEvents): once EVENT_SCENE_RIVAL_DEFEATED_05A is set starts
; Script_HelloHaveYouFound ('Hello, have you found a', then a script_skip_if_no to Script_OhThat and
; message $8D06) through StartScriptAtHL_B04 (wScriptPointerLo/Hi = the script, wScriptStartRequest
; = $80, wModeState = 1); otherwise message $0135 (the Log Navel question) through
; StartMessageCommand09HL_B04 (script command 9, wModeState = 1). (C2, E-0375)
; tests story flags (flag 005A then jr c,
; TalkMsg0135_TheLogsNavelWhatIsThat.call_start_script_at_hl_b04); starts message $0135 through
; StartMessageCommand09HL_B04 (script command $09); that string begins 'The Log's Navel? What is
; that? I' (E-0268, the E-0082 shape; was TalkMsg0135_TheLogsNavelWhatIsThat)
TalkMsg0135_TheLogsNavelWhatIsThat::
    ld de, EVENT_SCENE_RIVAL_DEFEATED_05A
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, $0135 ; '*: The Log's Navel? What is'
    call StartMessageCommand09HL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_HelloHaveYouFound ; script '*: Hello, have you found a'
    ASSERT BANK(Script_HelloHaveYouFound) == $10, "Script_HelloHaveYouFound is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 TalkMsg0136_TheLogsNavelLetMeThink", ROMX

; Kalka talk 6 (KalkaTalkEvents): message $0D07 ('The shortage of water has') once
; EVENT_SCENE_RIVAL_DEFEATED_05A is set, otherwise message $0136 (an answer about the Log Navel).
; Messages go through StartMessageCommand09HL_B04 (script command 9, wModeState = 1). (C2, E-0375)
; tests story flags (flag 005A then jr c,
; TalkMsg0136_TheLogsNavelLetMeThink.call_start_message_command09_hl_b04); starts message $0136
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'The Log's Navel? Let
; me think Perhaps' (E-0268, the E-0082 shape; was TalkMsg0136_TheLogsNavelLetMeThink)
TalkMsg0136_TheLogsNavelLetMeThink::
    ld de, EVENT_SCENE_RIVAL_DEFEATED_05A
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0136 ; '*: The Log's Navel? Let me'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0d07 ; '*: The shortage of water has'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0137_HeroCheckedTheOvenASharp", ROMX

; Kalka talk 7 (KalkaTalkEvents): starts message $0137 ('<BUF0> checked the oven. A sharp') through
; StartMessageCommand09HL_B04 (script command 9 with the word in wScriptParam0/wScriptParam1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0375)
; starts message $0137 through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 checked the oven. A sharp, spicy' (E-0268, the E-0082 shape; was
; TalkMsg0137_HeroCheckedTheOvenASharp)
TalkMsg0137_HeroCheckedTheOvenASharp::
    ld hl, $0137 ; '0 checked the oven. A sharp,'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 VaseItem_Herb", ROMX

; Kalka talk 8 (KalkaTalkEvents), a one-time vase: StartTreasureFlagDE_B04 starts script command $0A
; (RunOneTimeTreasure) with wScriptParam0 = 1 (vase), wScriptParam1 = ITEM_HERB and story flag $0046
; in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1). That command
; gives the item and sets the flag when the flag is clear (group-0 message $A3), shows $A4 when the
; flag is already set and $A5 when the bag is full. (C2, E-0375)
; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $01, story
; flag $0046 in DE: when the flag is clear it gives item $01 (Herb) and sets the flag (message $A3
; of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; VaseItem_Herb)
VaseItem_Herb::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $0046
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 TalkMsg0138_TheUndergroundCanalIsAhead", ROMX

; Kalka talk 9 (KalkaTalkEvents): tests EVENT_SCENE_RIVAL_DEFEATED_05A, EVENT_YOU_WILL_SO_WE_CAN and
; EVENT_WHAT_OPEN_THE_CANAL_GATE in that order and acts on the first one set: message $0D08, $017A
; ('Oh? You say that a') or $0173 ('...My, our King has no'); with none set message $0138 ('The
; underground canal is ahead.'). Messages go through StartMessageCommand09HL_B04 (script command 9,
; wModeState = 1). (C2, E-0375)
; tests story flags (flag 005A then jr c,
; TalkMsg0138_TheUndergroundCanalIsAhead.call_start_message_command09_hl_b043; flag 0053 then jr c,
; TalkMsg0138_TheUndergroundCanalIsAhead.call_start_message_command09_hl_b042; flag 004A then jr c,
; TalkMsg0138_TheUndergroundCanalIsAhead.call_start_message_command09_hl_b04); starts message $0138
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'The underground
; canal is ahead. The last' (E-0268, the E-0082 shape; was TalkMsg0138_TheUndergroundCanalIsAhead)
TalkMsg0138_TheUndergroundCanalIsAhead::
    ld de, EVENT_SCENE_RIVAL_DEFEATED_05A
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, EVENT_YOU_WILL_SO_WE_CAN
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_WHAT_OPEN_THE_CANAL_GATE
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0138 ; '*: The underground canal is ahead.'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0173 ; '*: …My, our King has no'
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

SECTION "Bank 04 KalkaTalkEvents_Inn", ROMX

; Kalka talk 10, the inn: turns the innkeeper toward the player (slot byte 7 = 2 at X $30, else 1)
; and starts 'Welcome to our inn' with script data in bank $10. (C2, E-0357; probed E-0375)
KalkaTalkEvents_Inn::
    ldh a, [hPlayerX]
    cp $30
    jr nz, .set_sprite_slots_to_01
    ld a, $02
    jp .set_sprite_slots

.set_sprite_slots_to_01:
    ld a, $01

.set_sprite_slots:
    ld [wSpriteSlots + $7], a
    ld hl, Script_WelcomeToOurInn ; script '*: Welcome to our inn!'
    ASSERT BANK(Script_WelcomeToOurInn) == $10, "Script_WelcomeToOurInn is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ld a, $10
    ld [wDataBank], a
    ret

SECTION "Bank 04 TalkMsg0139_TheKingCalledACircusTroupe", ROMX

; Kalka talk 11 (KalkaTalkEvents): message $01A6 ('The circus has moved onto') once
; EVENT_SCENE_RIVAL_DEFEATED_05A is set, otherwise message $0139 ('The King called a circus').
; Messages go through StartMessageCommand09HL_B04 (script command 9, wModeState = 1). (C2, E-0375)
; tests story flags (flag 005A then jr c,
; TalkMsg0139_TheKingCalledACircusTroupe.call_start_message_command09_hl_b04); starts message $0139
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'The King called a
; circus troupe to' (E-0268, the E-0082 shape; was TalkMsg0139_TheKingCalledACircusTroupe)
TalkMsg0139_TheKingCalledACircusTroupe::
    ld de, EVENT_SCENE_RIVAL_DEFEATED_05A
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0139 ; '*: The King called a circus'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $01a6 ; '*: The circus has moved onto'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg013A_ThisIsAsiyaTheDesertFlower", ROMX

; Kalka talk 12 (KalkaTalkEvents): starts message $013A ('This is Asiya, the desert') through
; StartMessageCommand09HL_B04 (script command 9 with the word in wScriptParam0/wScriptParam1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0375)
; starts message $013A through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'This is Asiya, the desert flower.' (E-0268, the E-0082 shape; was
; TalkMsg013A_ThisIsAsiyaTheDesertFlower)
TalkMsg013A_ThisIsAsiyaTheDesertFlower::
    ld hl, $013a ; '*: This is Asiya, the desert'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg013B_OurKingCameIntoAnEnormous", ROMX

; Kalka talk 13 (KalkaTalkEvents): message $0D0B ('The King gave away his') once
; EVENT_SCENE_RIVAL_DEFEATED_05A is set, otherwise message $013B ('Our King came into an'). Messages
; go through StartMessageCommand09HL_B04 (script command 9, wModeState = 1). (C2, E-0375)
; tests story flags (flag 005A then jr c,
; TalkMsg013B_OurKingCameIntoAnEnormous.call_start_message_command09_hl_b04); starts message $013B
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'Our King came into
; an enormous inheritance.' (E-0268, the E-0082 shape; was TalkMsg013B_OurKingCameIntoAnEnormous)
TalkMsg013B_OurKingCameIntoAnEnormous::
    ld de, EVENT_SCENE_RIVAL_DEFEATED_05A
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $013b ; '*: Our King came into an'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0d0b ; '*: The King gave away his'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg013C_ISawALakeLikeA", ROMX

; Kalka talk 14 (KalkaTalkEvents): message $0D0A ('The band of thieves made') once
; EVENT_SCENE_RIVAL_DEFEATED_05A is set, otherwise message $013C ('I saw a lake like'). Messages go
; through StartMessageCommand09HL_B04 (script command 9, wModeState = 1). (C2, E-0375)
; tests story flags (flag 005A then jr c,
; TalkMsg013C_ISawALakeLikeA.call_start_message_command09_hl_b04); starts message $013C through
; StartMessageCommand09HL_B04 (script command $09); that string begins 'I saw a lake like a mirage.'
; (E-0268, the E-0082 shape; was TalkMsg013C_ISawALakeLikeA)
TalkMsg013C_ISawALakeLikeA::
    ld de, EVENT_SCENE_RIVAL_DEFEATED_05A
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $013c ; '*: I saw a lake like'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0d0a ; '*: The band of thieves made'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg013D_StrongMonstersAreInTheWell", ROMX

; Kalka talk 15 (KalkaTalkEvents): tests EVENT_SCENE_RIVAL_DEFEATED_05A, EVENT_YOU_WILL_SO_WE_CAN,
; EVENT_STRONG_MONSTERS_ARE_IN_THE and EVENT_KING_THEN_MAKE_WAY_TO in that order and acts on the
; first one set: message $0D09 ('The well filled up with'), $017B ('The well has ample water'),
; $0168 ('Do I have any concerns?'), or $0168 and then sets EVENT_STRONG_MONSTERS_ARE_IN_THE; with
; none set message $013D ('Strong monsters are in the'). Messages go through
; StartMessageCommand09HL_B04 (script command 9, wModeState = 1). (C2, E-0375)
; tests story flags (flag 005A then jr c,
; TalkMsg013D_StrongMonstersAreInTheWell.call_start_message_command09_hl_b044; flag 0053 then jr c,
; TalkMsg013D_StrongMonstersAreInTheWell.call_start_message_command09_hl_b043; flag 0048 then jr c,
; TalkMsg013D_StrongMonstersAreInTheWell.call_start_message_command09_hl_b042; flag 0045 then jr c,
; TalkMsg013D_StrongMonstersAreInTheWell.call_start_message_command09_hl_b04); starts message $013D
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'Strong monsters are
; in the well. You' (E-0268, the E-0082 shape; was TalkMsg013D_StrongMonstersAreInTheWell)
TalkMsg013D_StrongMonstersAreInTheWell::
    ld de, EVENT_SCENE_RIVAL_DEFEATED_05A
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b044
    ld de, EVENT_YOU_WILL_SO_WE_CAN
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, EVENT_STRONG_MONSTERS_ARE_IN_THE
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_KING_THEN_MAKE_WAY_TO
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $013d ; '*: Strong monsters are in the'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0168 ; '*: Do I have any concerns?'
    call StartMessageCommand09HL_B04
    ld de, EVENT_STRONG_MONSTERS_ARE_IN_THE
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

SECTION "Bank 04 TalkMsg013E_OurKingHasBeenAFan", ROMX

; Kalka talk 16 (KalkaTalkEvents): starts message $013E ('Our King has been a') through
; StartMessageCommand09HL_B04 (script command 9 with the word in wScriptParam0/wScriptParam1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0375)
; starts message $013E through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'Our King has been a fan of' (E-0268, the E-0082 shape; was TalkMsg013E_OurKingHasBeenAFan)
TalkMsg013E_OurKingHasBeenAFan::
    ld hl, $013e ; '*: Our King has been a'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg013F_TheCircusMasterWasTrying", ROMX

; Kalka talk 17 (KalkaTalkEvents): message $01A7 (on the popularity of His Majesty) once
; EVENT_SCENE_RIVAL_DEFEATED_05A is set, otherwise message $013F ('The circus master was trying').
; Messages go through StartMessageCommand09HL_B04 (script command 9, wModeState = 1). (C2, E-0375)
; tests story flags (flag 005A then jr c,
; TalkMsg013F_TheCircusMasterWasTrying.call_start_message_command09_hl_b04); starts message $013F
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'The circus master
; was trying to recruit' (E-0268, the E-0082 shape; was TalkMsg013F_TheCircusMasterWasTrying)
TalkMsg013F_TheCircusMasterWasTrying::
    ld de, EVENT_SCENE_RIVAL_DEFEATED_05A
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $013f ; '*: The circus master was trying'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $01a7 ; '*: His Majesty's popularity has been'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 KalkaTalkEvents_ItemShop", ROMX

; Kalka talk 18, the item shop: screen table 3; 'Welcome to my item shop' the first time (setting
; its flag), then 'Hello, how may I ...'. (C2, E-0357; probed E-0375)
KalkaTalkEvents_ItemShop::
    ld a, $03
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld de, EVENT_WELCOME_TO_MY_ITEM_SHOP
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_WelcomeToMyItem ; script '*: Welcome to my item shop!'
    ASSERT BANK(Script_WelcomeToMyItem) == $10, "Script_WelcomeToMyItem is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ld de, EVENT_WELCOME_TO_MY_ITEM_SHOP
    call SetFlagBit
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_HelloHowMayI_2 ; script '*: Hello! How may I serve'
    ASSERT BANK(Script_HelloHowMayI_2) == $10, "Script_HelloHowMayI_2 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 TalkMsg0140_NoOneEntersTheCastleWithout", ROMX

; Kalka talk 19 (KalkaTalkEvents): message $016A ('The King has given permission') once
; EVENT_SCENE_MONSTER_INSPECTION is set, otherwise message $0140 ('No one enters the castle').
; Messages go through StartMessageCommand09HL_B04 (script command 9, wModeState = 1). (C2, E-0375)
; tests story flags (flag 0043 then jr c,
; TalkMsg0140_NoOneEntersTheCastleWithout.call_start_message_command09_hl_b04); starts message $0140
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'No one enters the
; castle without a' (E-0268, the E-0082 shape; was TalkMsg0140_NoOneEntersTheCastleWithout)
TalkMsg0140_NoOneEntersTheCastleWithout::
    ld de, EVENT_SCENE_MONSTER_INSPECTION
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0140 ; '*: No one enters the castle'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $016a ; '*: The King has given permission'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0141_IfYouWantToGetIn", ROMX

; Kalka talk 20 (KalkaTalkEvents): tests EVENT_YOU_WILL_SO_WE_CAN and EVENT_SCENE_MONSTER_INSPECTION
; in that order and acts on the first one set; EVENT_YOU_WILL_SO_WE_CAN set: message $017C ('We have
; heard from his'); EVENT_SCENE_MONSTER_INSPECTION set: message $016B ('The King is so frivolous.');
; none set: message $0141 ('If you want to get'). Messages go through StartMessageCommand09HL_B04
; (script command 9, wModeState = 1). (C2, E-0375)
; tests story flags (flag 0053 then jr c,
; TalkMsg0141_IfYouWantToGetIn.call_start_message_command09_hl_b042; flag 0043 then jr c,
; TalkMsg0141_IfYouWantToGetIn.call_start_message_command09_hl_b04); starts message $0141 through
; StartMessageCommand09HL_B04 (script command $09); that string begins 'If you want to get in that'
; (E-0268, the E-0082 shape; was TalkMsg0141_IfYouWantToGetIn)
TalkMsg0141_IfYouWantToGetIn::
    ld de, EVENT_YOU_WILL_SO_WE_CAN
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_SCENE_MONSTER_INSPECTION
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

SECTION "Bank 04 TalkMsg0142_DidYouWantSomethingHoney", ROMX

; Kalka talk 21 (KalkaTalkEvents): message $017D ('Hi! Did you hear the') once
; EVENT_YOU_WILL_SO_WE_CAN is set, otherwise message $0142 ('Did you want something, honey?').
; Messages go through StartMessageCommand09HL_B04 (script command 9, wModeState = 1). (C2, E-0375)
; tests story flags (flag 0053 then jr c,
; TalkMsg0142_DidYouWantSomethingHoney.call_start_message_command09_hl_b04); starts message $0142
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'Did you want
; something, honey? A plug' (E-0268, the E-0082 shape; was TalkMsg0142_DidYouWantSomethingHoney)
TalkMsg0142_DidYouWantSomethingHoney::
    ld de, EVENT_YOU_WILL_SO_WE_CAN
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0142 ; '*: Did you want something, honey?'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $017d ; '*: Hi! Did you hear the'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0143_WhenWeGetAHotSpell", ROMX

; Kalka talk 22 (KalkaTalkEvents): starts message $0143 ('When we get a hot') through
; StartMessageCommand09HL_B04 (script command 9 with the word in wScriptParam0/wScriptParam1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0375)
; starts message $0143 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'When we get a hot spell, I' (E-0268, the E-0082 shape; was TalkMsg0143_WhenWeGetAHotSpell)
TalkMsg0143_WhenWeGetAHotSpell::
    ld hl, $0143 ; '*: When we get a hot'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 KalkaTalkEvents_Church", ROMX

; Kalka talk 23, the church: 'The church welcomes you' the first time (setting its flag), then 'I am
; a servant'; script data in bank $1F. (C2, E-0357; probed E-0375)
KalkaTalkEvents_Church::
    ld a, $1f
    ld [wDataBank], a
    ld de, EVENT_THE_CHURCH_WELCOMES_YOU_WE
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_TheChurchWelcomesYou ; script '*: The church welcomes you. We'
    ASSERT BANK(Script_TheChurchWelcomesYou) == $10, "Script_TheChurchWelcomesYou is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ld de, EVENT_THE_CHURCH_WELCOMES_YOU_WE
    call SetFlagBit
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_IAmAServant ; script '*: I am a servant to'
    ASSERT BANK(Script_IAmAServant) == $10, "Script_IAmAServant is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 KalkaTalkEvents_Leader", ROMX

; Kalka talk 24, the leader: before EVENT_DID_YOU_SAY_YES_YES, one of three scripts by whether the
; party has three members and whether one is marked in record byte $55 bit 7; afterwards, with three
; unmarked members, 'Ah, three healthy monsters', otherwise message $014E. (C2, E-0357; probed
; E-0375)
KalkaTalkEvents_Leader::
    ld de, EVENT_DID_YOU_SAY_YES_YES
    call TestFlagBit
    jr c, .check_party_count
    ld a, [wPartyCount]
    cp $03
    jr nz, .call_start_script_at_hl_b04
    farcall SetWStepArrivedIfPartyHasField55Bit7
    ld a, [wStepArrived]
    or a
    jr nz, .call_start_script_at_hl_b042
    ld hl, Script_IAmTheLeader ; script '*: I am the leader of'
    ASSERT BANK(Script_IAmTheLeader) == $10, "Script_IAmTheLeader is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_IAmTheLeader_2 ; script '*: I am the leader of'
    ASSERT BANK(Script_IAmTheLeader_2) == $10, "Script_IAmTheLeader_2 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b042:
    ld hl, Script_IAmTheLeader_3 ; script '*: I am the leader of'
    ASSERT BANK(Script_IAmTheLeader_3) == $10, "Script_IAmTheLeader_3 is read with bank $10 mapped"
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
    ld hl, Script_AhThreeHealthyMonsters ; script '*: Ah, three healthy monsters! Very'
    ASSERT BANK(Script_AhThreeHealthyMonsters) == $10, "Script_AhThreeHealthyMonsters is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $014e ; '*: Oh, you need a trio'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg014F_HeroPeeredIntoTheVaseIt", ROMX

; Kalka talk 25 (KalkaTalkEvents): starts message $014F ('<BUF0> peered into the vase. It') through
; StartMessageCommand09HL_B04 (script command 9 with the word in wScriptParam0/wScriptParam1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0375)
; starts message $014F through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 peered into the vase. It was' (E-0268, the E-0082 shape; was
; TalkMsg014F_HeroPeeredIntoTheVaseIt)
TalkMsg014F_HeroPeeredIntoTheVaseIt::
    ld hl, $014f ; '0 peered into the vase. It'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 VaseItem_Antidote_Flag0047", ROMX

; Kalka talk 26 (KalkaTalkEvents), a one-time vase: StartTreasureFlagDE_B04 starts script command
; $0A (RunOneTimeTreasure) with wScriptParam0 = 1 (vase), wScriptParam1 = ITEM_ANTIDOTE and story
; flag $0047 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1).
; That command gives the item and sets the flag when the flag is clear (group-0 message $A3), shows
; $A4 when the flag is already set and $A5 when the bag is full. (C2, E-0375)
; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $06, story
; flag $0047 in DE: when the flag is clear it gives item $06 (Antidote) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; VaseItem_Antidote_Flag0047)
VaseItem_Antidote_Flag0047::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $06
    ld [wScriptParam1], a
    ld de, $0047
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 TalkMsg0137_HeroCheckedTheOvenASharp_04", ROMX

; Kalka talk 27 (KalkaTalkEvents): starts message $0137 ('<BUF0> checked the oven. A sharp'), the
; same reply as Kalka talk 7 (TalkMsg0137_HeroCheckedTheOvenASharp), through
; StartMessageCommand09HL_B04 (script command 9 with the word in wScriptParam0/wScriptParam1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0375)
; starts message $0137 through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 checked the oven. A sharp, spicy' (E-0268, the E-0082 shape; was
; TalkMsg0137_HeroCheckedTheOvenASharp_04) (E-0344: the address in its name dropped or read as the
; label there; was TalkMsg0137_HeroCheckedTheOvenASharp_04)
TalkMsg0137_HeroCheckedTheOvenASharp_04::
    ld hl, $0137 ; '0 checked the oven. A sharp,'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 IfFlag056Msg018F_WeDidntHelpTheThievesOne", ROMX

; Kalka talk 28 (KalkaTalkEvents): does nothing until EVENT_SCENE_TREASURE_THEFT is set; then starts
; message $018F (a denial of helping the thieves) through StartMessageCommand09HL_B04 (script
; command 9 with the word in wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2,
; E-0375)
; tests story flags (flag 0056 then ret nc); starts message $018F through
; StartMessageCommand09HL_B04 (script command $09); that string begins 'We didn't help the thieves!
; One of' (E-0268, the E-0082 shape; was IfFlag056Msg018F_WeDidntHelpTheThievesOne)
IfFlag056Msg018F_WeDidntHelpTheThievesOne::
    ld de, EVENT_SCENE_TREASURE_THEFT
    call TestFlagBit
    ret nc
    ld hl, $018f ; '*: We didn't help the thieves!'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg01BE_HeroCheckedTheDresserThere", ROMX

; Kalka talk 29 (KalkaTalkEvents): starts message $01BE ('<BUF0> checked the dresser. There was')
; through StartMessageCommand09HL_B04 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0375)
; starts message $01BE through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 checked the dresser. There was a' (E-0268, the E-0082 shape; was
; TalkMsg01BE_HeroCheckedTheDresserThere)
TalkMsg01BE_HeroCheckedTheDresserThere::
    ld hl, $01be ; '0 checked the dresser. There was'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0037_HeroTriedToOpenTheChest_04", ROMX

; Kalka talk 30 (KalkaTalkEvents): starts message $0037 ('<BUF0> tried to open the chest.'), the
; reply Yold talk 14 also uses (TalkMsg0037_HeroTriedToOpenTheChest), through
; StartMessageCommand09HL_B04 (script command 9 with the word in wScriptParam0/wScriptParam1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0375)
; starts message $0037 through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 tried to open the chest. But' (E-0268, the E-0082 shape; was
; TalkMsg0037_HeroTriedToOpenTheChest_04) (E-0344: the address in its name dropped or read as the
; label there; was TalkMsg0037_HeroTriedToOpenTheChest_04)
; starts Script_WelcomeToOurInn_2: '*: Welcome to our inn!' (E-0248)
TalkMsg0037_HeroTriedToOpenTheChest_04::
    ld hl, $0037 ; '0 tried to open the chest.'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 KalkaTalkEvents_SecondInn", ROMX

; Kalka talk 31, a second inn (the first is KalkaTalkEvents_Inn): starts Script_WelcomeToOurInn_2
; ('Welcome to our inn!', then the inn script Script_It_3 in the data bank) and sets wDataBank =
; $10; unlike KalkaTalkEvents_Inn it does not turn the innkeeper. (C2, E-0369; probed E-0375)
; starts Script_WelcomeToOurInn_2: '*: Welcome to our inn!' (E-0248)
KalkaTalkEvents_SecondInn::
    ld hl, Script_WelcomeToOurInn_2 ; script '*: Welcome to our inn!'
    ASSERT BANK(Script_WelcomeToOurInn_2) == $10, "Script_WelcomeToOurInn_2 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ld a, $10
    ld [wDataBank], a
    ret

SECTION "Bank 04 TalkMsg0150_IHeardThatTheThievesDisappear", ROMX

; Kalka talk 32 (KalkaTalkEvents): message $01A8 ('Making a hideout in Mirage') once
; EVENT_SCENE_RIVAL_DEFEATED_05A is set, otherwise message $0150 ('I heard that the thieves').
; Messages go through StartMessageCommand09HL_B04 (script command 9, wModeState = 1). (C2, E-0375)
; tests story flags (flag 005A then jr c,
; TalkMsg0150_IHeardThatTheThievesDisappear.call_start_message_command09_hl_b04); starts message
; $0150 through StartMessageCommand09HL_B04 (script command $09); that string begins 'I heard that
; the thieves disappear as' (E-0268, the E-0082 shape; was
; TalkMsg0150_IHeardThatTheThievesDisappear)
TalkMsg0150_IHeardThatTheThievesDisappear::
    ld de, EVENT_SCENE_RIVAL_DEFEATED_05A
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0150 ; '*: I heard that the thieves'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $01a8 ; '*: Making a hideout in Mirage'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0154_SeveralOfOurMembersCameBack", ROMX

; Kalka talk 33 (KalkaTalkEvents): message $01A9 ('They let us out when') once
; EVENT_SCENE_RIVAL_DEFEATED_05A is set, otherwise message $0154 ('Several of our members came').
; Messages go through StartMessageCommand09HL_B04 (script command 9, wModeState = 1). (C2, E-0375)
; tests story flags (flag 005A then jr c,
; TalkMsg0154_SeveralOfOurMembersCameBack.call_start_message_command09_hl_b04); starts message $0154
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'Several of our
; members came back. We' (E-0268, the E-0082 shape; was TalkMsg0154_SeveralOfOurMembersCameBack)
TalkMsg0154_SeveralOfOurMembersCameBack::
    ld de, EVENT_SCENE_RIVAL_DEFEATED_05A
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0154 ; '*: Several of our members came'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $01a9 ; '*: They let us out when'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0155_WhenTheThievesRaidedUsWe", ROMX

; Kalka talk 34 (KalkaTalkEvents): message $01AA ('Come back and join the') once
; EVENT_SCENE_RIVAL_DEFEATED_05A is set, otherwise message $0155 ('When the thieves raided us').
; Messages go through StartMessageCommand09HL_B04 (script command 9, wModeState = 1). (C2, E-0375)
; tests story flags (flag 005A then jr c,
; TalkMsg0155_WhenTheThievesRaidedUsWe.call_start_message_command09_hl_b04); starts message $0155
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'When the thieves
; raided us, we ran.' (E-0268, the E-0082 shape; was TalkMsg0155_WhenTheThievesRaidedUsWe)
TalkMsg0155_WhenTheThievesRaidedUsWe::
    ld de, EVENT_SCENE_RIVAL_DEFEATED_05A
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0155 ; '*: When the thieves raided us,'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $01aa ; '*: Come back and join the'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0156_IWonderIfTheOthersAre", ROMX

; Kalka talk 35 (KalkaTalkEvents): message $01AB (the troupe reforming) once
; EVENT_SCENE_RIVAL_DEFEATED_05A is set, otherwise message $0156 ('I wonder if the others').
; Messages go through StartMessageCommand09HL_B04 (script command 9, wModeState = 1). (C2, E-0375)
; tests story flags (flag 005A then jr c,
; TalkMsg0156_IWonderIfTheOthersAre.call_start_message_command09_hl_b04); starts message $0156
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'I wonder if the
; others are safe' (E-0268, the E-0082 shape; was TalkMsg0156_IWonderIfTheOthersAre)
TalkMsg0156_IWonderIfTheOthersAre::
    ld de, EVENT_SCENE_RIVAL_DEFEATED_05A
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0156 ; '*: I wonder if the others'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $01ab ; '*: The troupe'll reform! We'll recruit'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0157_HehDidYouSeeTheLooks", ROMX

; Kalka talk 36 (KalkaTalkEvents): starts message $0157 ('Heh, did you see the') through
; StartMessageCommand09HL_B04 (script command 9 with the word in wScriptParam0/wScriptParam1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0375)
; starts message $0157 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'Heh, did you see the looks I' (E-0268, the E-0082 shape; was TalkMsg0157_HehDidYouSeeTheLooks)
TalkMsg0157_HehDidYouSeeTheLooks::
    ld hl, $0157 ; '*: Heh, did you see the'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0158_ThisIsTheKingsTreasuryNo", ROMX

; Kalka talk 37 (KalkaTalkEvents): message $01AC once EVENT_SCENE_RIVAL_DEFEATED_05A is set;
; otherwise $0192 ('The prisoner in the dungeon') once EVENT_SCENE_TREASURE_THEFT is set; otherwise
; $0158 (on the treasury of the King). Messages go through StartMessageCommand09HL_B04 (script
; command 9, wModeState = 1). (C2, E-0375)
; tests story flags (flag 005A then jr c,
; TalkMsg0158_ThisIsTheKingsTreasuryNo.call_start_message_command09_hl_b042; flag 0056 then jr c,
; TalkMsg0158_ThisIsTheKingsTreasuryNo.call_start_message_command09_hl_b04); starts message $0158
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'This is the King's
; treasury! No one,' (E-0268, the E-0082 shape; was TalkMsg0158_ThisIsTheKingsTreasuryNo)
TalkMsg0158_ThisIsTheKingsTreasuryNo::
    ld de, EVENT_SCENE_RIVAL_DEFEATED_05A
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_SCENE_TREASURE_THEFT
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

SECTION "Bank 04 TalkMsg0159_WhatSeeHisMajestysTreasure", ROMX

; Kalka talk 38 (KalkaTalkEvents): tests EVENT_SCENE_RIVAL_DEFEATED_05A, EVENT_SCENE_TREASURE_THEFT
; and EVENT_YOU_WILL_SO_WE_CAN in that order and acts on the first one set: message $01AD ('I will
; do my best'), $0191 ('We can see the hideout') or $017E ('The King solved our water'); with none
; set message $0159 ('What? See his'). Messages go through StartMessageCommand09HL_B04 (script
; command 9, wModeState = 1). (C2, E-0375)
; tests story flags (flag 005A then jr c,
; TalkMsg0159_WhatSeeHisMajestysTreasure.call_start_message_command09_hl_b043; flag 0056 then jr c,
; TalkMsg0159_WhatSeeHisMajestysTreasure.call_start_message_command09_hl_b042; flag 0053 then jr c,
; TalkMsg0159_WhatSeeHisMajestysTreasure.call_start_message_command09_hl_b04); starts message $0159
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'What? See his
; Majesty's treasure? What foolishness!' (E-0268, the E-0082 shape; was
; TalkMsg0159_WhatSeeHisMajestysTreasure)
TalkMsg0159_WhatSeeHisMajestysTreasure::
    ld de, EVENT_SCENE_RIVAL_DEFEATED_05A
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, EVENT_SCENE_TREASURE_THEFT
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_YOU_WILL_SO_WE_CAN
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

SECTION "Bank 04 KalkaTalkEvents_Snooping", ROMX

; Kalka talk 39: 'Why are you snooping?' until EVENT_YOU_WILL_SO_WE_CAN, then message $017F; after
; the rival is defeated (EVENT_SCENE_RIVAL_DEFEATED_05A) message $01AE. (C2, E-0357; probed E-0375)
KalkaTalkEvents_Snooping::
    ld de, EVENT_SCENE_RIVAL_DEFEATED_05A
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_YOU_WILL_SO_WE_CAN
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, Script_WhyAreYouSnooping ; script '*: Why are you snooping around?'
    ASSERT BANK(Script_WhyAreYouSnooping) == $10, "Script_WhyAreYouSnooping is read with bank $10 mapped"
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

SECTION "Bank 04 TalkMsg015A_HisMajestyIsHonestAndMost", ROMX

; Kalka talk 40 (KalkaTalkEvents): tests EVENT_YOU_WILL_SO_WE_CAN and
; EVENT_KING_WHAT_NEVER_MIND_THEN in that order and acts on the first one set;
; EVENT_YOU_WILL_SO_WE_CAN set: message $0180 ('The King appears to have');
; EVENT_KING_WHAT_NEVER_MIND_THEN set: message $0170 ('I feel badly for his'); none set: message
; $015A ('His Majesty is honest and'). Messages go through StartMessageCommand09HL_B04 (script
; command 9, wModeState = 1). (C2, E-0375)
; tests story flags (flag 0053 then jr c,
; TalkMsg015A_HisMajestyIsHonestAndMost.call_start_message_command09_hl_b042; flag 0049 then jr c,
; TalkMsg015A_HisMajestyIsHonestAndMost.call_start_message_command09_hl_b04); starts message $015A
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'His Majesty is
; honest and most certainly' (E-0268, the E-0082 shape; was TalkMsg015A_HisMajestyIsHonestAndMost)
TalkMsg015A_HisMajestyIsHonestAndMost::
    ld de, EVENT_YOU_WILL_SO_WE_CAN
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_KING_WHAT_NEVER_MIND_THEN
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

SECTION "Bank 04 KalkaTalkEvents_PoorChurchScene", ROMX

; Kalka talk 41: unless bit 3 of story byte $61 (wStoryFlags + $61) is set, starts
; Script_ScenePoorChurch (a 20-frame wait, then SCRIPT_SCENE_POOR_CHURCH).
; KalkaTalkEvents_WaitStoryFlagsPlus61 clears that bit again unless bit 4 is set. (C2, E-0369;
; probed E-0375)
; starts Script_ScenePoorChurch (E-0248)
KalkaTalkEvents_PoorChurchScene::
    ld a, [wStoryFlags + $61]
    bit 3, a
    ret nz
    ld hl, Script_ScenePoorChurch
    ASSERT BANK(Script_ScenePoorChurch) == $10, "Script_ScenePoorChurch is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 TalkMsg015F_HeroCheckedTheDresserThere", ROMX

; Kalka talk 42 (KalkaTalkEvents): starts message $015F ('<BUF0> checked the dresser. There were')
; through StartMessageCommand09HL_B04 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0375)
; starts message $015F through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 checked the dresser. There were neatly' (E-0268, the E-0082 shape; was
; TalkMsg015F_HeroCheckedTheDresserThere)
TalkMsg015F_HeroCheckedTheDresserThere::
    ld hl, $015f ; '0 checked the dresser. There were'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 KalkaTalkEvents_King", ROMX

; Kalka talk 43, the king: picks the script or message from the story so far: the first audience,
; then 'So have you ...', the way-making and 'Strong monsters are in the ...' stages, the water
; solved, the treasure theft and the rival defeated (seven story flags tested from the latest). (C2,
; E-0357; probed E-0375)
KalkaTalkEvents_King::
    ld de, EVENT_SCENE_RIVAL_DEFEATED_05A
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b044
    ld de, EVENT_SCENE_TREASURE_THEFT
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, EVENT_SCENE_WATER_SOLVED
    call TestFlagBit
    jr c, .call_start_script_at_hl_b043
    ld de, EVENT_KING_WHAT_NEVER_MIND_THEN
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_STRONG_MONSTERS_ARE_IN_THE
    call TestFlagBit
    jr c, .call_start_script_at_hl_b042
    ld de, EVENT_KING_THEN_MAKE_WAY_TO
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld de, EVENT_KING_YOU_WISH_TO
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_KingAhYou_5 ; script 'King: Ah, you're the monster tamer'
    ASSERT BANK(Script_KingAhYou_5) == $10, "Script_KingAhYou_5 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_KingSoHaveYou ; script 'King: So? Have you decided to'
    ASSERT BANK(Script_KingSoHaveYou) == $10, "Script_KingSoHaveYou is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0164 ; 'King: Investigate what concerns my people'
    call StartMessageCommand09HL_B04
    ret

.call_start_script_at_hl_b042:
    ld hl, Script_SoHaveYouDiscovered ; script '*: So, have you discovered what'
    ASSERT BANK(Script_SoHaveYouDiscovered) == $10, "Script_SoHaveYouDiscovered is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $0174 ; '*: I discovered why the water'
    call StartMessageCommand09HL_B04
    ret

.call_start_script_at_hl_b043:
    ld hl, Script_KingTheTown ; script 'King: The town's water shortage seems'
    ASSERT BANK(Script_KingTheTown) == $10, "Script_KingTheTown is read with bank $10 mapped"
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

SECTION "Bank 04 TalkMsg0166_ThatFoolIsATerribleSwindler", ROMX

; Kalka talk 44 (KalkaTalkEvents): message $01B1 ('The dungeon is full of') once
; EVENT_SCENE_RIVAL_DEFEATED_05A is set, otherwise message $0166 ('That fool is a terrible').
; Messages go through StartMessageCommand09HL_B04 (script command 9, wModeState = 1). (C2, E-0375)
; tests story flags (flag 005A then jr c,
; TalkMsg0166_ThatFoolIsATerribleSwindler.call_start_message_command09_hl_b04); starts message $0166
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'That fool is a
; terrible swindler. I' (E-0268, the E-0082 shape; was TalkMsg0166_ThatFoolIsATerribleSwindler)
TalkMsg0166_ThatFoolIsATerribleSwindler::
    ld de, EVENT_SCENE_RIVAL_DEFEATED_05A
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0166 ; '*: That fool is a terrible'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $01b1 ; '*: The dungeon is full of'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0167_HumphAMirageLakeHeSays", ROMX

; Kalka talk 45 (KalkaTalkEvents): message $0193 ('How can we reach the') once
; EVENT_SCENE_TREASURE_THEFT is set, otherwise message $0167 ('Humph! A mirage lake, he'). Messages
; go through StartMessageCommand09HL_B04 (script command 9, wModeState = 1). (C2, E-0375)
; tests story flags (flag 0056 then jr c,
; TalkMsg0167_HumphAMirageLakeHeSays.call_start_message_command09_hl_b04); starts message $0167
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'Humph! A mirage
; lake, he says! No' (E-0268, the E-0082 shape; was TalkMsg0167_HumphAMirageLakeHeSays)
TalkMsg0167_HumphAMirageLakeHeSays::
    ld de, EVENT_SCENE_TREASURE_THEFT
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0167 ; '*: Humph! A mirage lake, he'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0193 ; '*: How can we reach the'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 KalkaTalkEvents_CanalGate", ROMX

; Kalka talk 46: does nothing until EVENT_KING_WHAT_NEVER_MIND_THEN is set; then starts
; Script_WhatOpenTheCanal ('What? Open the Canal Gate ...', SCRIPT_SCENE_CANAL_GATE, the speaker
; walks off and is hidden) and sets EVENT_WHAT_OPEN_THE_CANAL_GATE. (C2, E-0369; probed E-0375)
; starts Script_WhatOpenTheCanal: '*: What? Open the Canal Gate' (E-0248)
KalkaTalkEvents_CanalGate::
    ld de, EVENT_KING_WHAT_NEVER_MIND_THEN
    call TestFlagBit
    ret nc
    ld hl, Script_WhatOpenTheCanal ; script '*: What? Open the Canal Gate'
    ASSERT BANK(Script_WhatOpenTheCanal) == $10, "Script_WhatOpenTheCanal is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ld de, EVENT_WHAT_OPEN_THE_CANAL_GATE
    call SetFlagBit
    ret

SECTION "Bank 04 VaseItem_Herb_Flag004B", ROMX

; Kalka talk 47 (KalkaTalkEvents), a one-time vase: StartTreasureFlagDE_B04 starts script command
; $0A (RunOneTimeTreasure) with wScriptParam0 = 1 (vase), wScriptParam1 = ITEM_HERB and story flag
; $004B in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1). That
; command gives the item and sets the flag when the flag is clear (group-0 message $A3), shows $A4
; when the flag is already set and $A5 when the bag is full. (C2, E-0375)
; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $01, story
; flag $004B in DE: when the flag is clear it gives item $01 (Herb) and sets the flag (message $A3
; of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; VaseItem_Herb_Flag004B)
VaseItem_Herb_Flag004B::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $004b
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 VaseItem_PorkChop", ROMX

; Kalka talk 48 (KalkaTalkEvents), a one-time vase: StartTreasureFlagDE_B04 starts script command
; $0A (RunOneTimeTreasure) with wScriptParam0 = 1 (vase), wScriptParam1 = ITEM_PORKCHOP and story
; flag $004C in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1).
; That command gives the item and sets the flag when the flag is clear (group-0 message $A3), shows
; $A4 when the flag is already set and $A5 when the bag is full. (C2, E-0375)
; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $1A, story
; flag $004C in DE: when the flag is clear it gives item $1A (PorkChop) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; VaseItem_PorkChop)
VaseItem_PorkChop::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $1a
    ld [wScriptParam1], a
    ld de, $004c
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 VaseItem_TinyMedal", ROMX

; Kalka talk 49 (KalkaTalkEvents), a one-time vase: StartTreasureFlagDE_B04 starts script command
; $0A (RunOneTimeTreasure) with wScriptParam0 = 1 (vase), wScriptParam1 = ITEM_TINYMEDAL and story
; flag $004D in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1).
; That command gives the item and sets the flag when the flag is clear (group-0 message $A3), shows
; $A4 when the flag is already set and $A5 when the bag is full. (C2, E-0375)
; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $2C, story
; flag $004D in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; VaseItem_TinyMedal)
VaseItem_TinyMedal::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2c
    ld [wScriptParam1], a
    ld de, $004d
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 VaseItem_Bookmark", ROMX

; Kalka talk 50 (KalkaTalkEvents), a one-time vase: StartTreasureFlagDE_B04 starts script command
; $0A (RunOneTimeTreasure) with wScriptParam0 = 1 (vase), wScriptParam1 = ITEM_BOOKMARK and story
; flag $004E in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1).
; That command gives the item and sets the flag when the flag is clear (group-0 message $A3), shows
; $A4 when the flag is already set and $A5 when the bag is full. (C2, E-0375)
; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $2B, story
; flag $004E in DE: when the flag is clear it gives item $2B (Bookmark) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; VaseItem_Bookmark)
VaseItem_Bookmark::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2b
    ld [wScriptParam1], a
    ld de, $004e
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_ExitBell_Flag004F", ROMX

; Kalka talk 51 (KalkaTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts script command
; $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_EXITBELL and story
; flag $004F in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1).
; That command gives the item and sets the flag when the flag is clear (group-0 message $A0), shows
; $A1 when the flag is already set and $A2 when the bag is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $2A, story flag $004F in DE: when the flag is clear it gives item $2A (ExitBell) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_ExitBell_Flag004F)
ChestItem_ExitBell_Flag004F::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2a
    ld [wScriptParam1], a
    ld de, $004f
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_Wind", ROMX

; Kalka talk 52 (KalkaTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts script command
; $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_WIND and story flag
; $0050 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1). That
; command gives the item and sets the flag when the flag is clear (group-0 message $A0), shows $A1
; when the flag is already set and $A2 when the bag is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $24, story flag $0050 in DE: when the flag is clear it gives item $24 (Wind) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_Wind)
ChestItem_Wind::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $24
    ld [wScriptParam1], a
    ld de, $0050
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_WarpWing", ROMX

; Kalka talk 53 (KalkaTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts script command
; $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_WARPWING and story
; flag $0051 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1).
; That command gives the item and sets the flag when the flag is clear (group-0 message $A0), shows
; $A1 when the flag is already set and $A2 when the bag is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $29, story flag $0051 in DE: when the flag is clear it gives item $29 (WarpWing) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_WarpWing)
ChestItem_WarpWing::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $29
    ld [wScriptParam1], a
    ld de, $0051
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_AGL", ROMX

; Kalka talk 54 (KalkaTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts script command
; $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_AGL and story flag
; $0052 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1). That
; command gives the item and sets the flag when the flag is clear (group-0 message $A0), shows $A1
; when the flag is already set and $A2 when the bag is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $48, story flag $0052 in DE: when the flag is clear it gives item $48 (AGL) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_AGL)
ChestItem_AGL::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $48
    ld [wScriptParam1], a
    ld de, $0052
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 KalkaTalkEvents_MakingANewHome", ROMX

; Kalka talk 55: before EVENT_SCENE_RIVAL_DEFEATED_05A starts Script_I_13 ('I'm making a new home',
; encounter $16, 'Gaah! You're too strong!', lines from the King, then hides the speaker and sets
; EVENT_YOU_WILL_SO_WE_CAN); afterwards Script_SceneWaterReward (SCRIPT_SCENE_WATER_REWARD). (C2,
; E-0369; probed E-0375)
; starts Script_I_13: '*: I'm making a new home' (E-0248)
KalkaTalkEvents_MakingANewHome::
    ld de, EVENT_SCENE_RIVAL_DEFEATED_05A
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_I_13 ; script '*: I'm making a new home'
    ASSERT BANK(Script_I_13) == $10, "Script_I_13 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_SceneWaterReward
    ASSERT BANK(Script_SceneWaterReward) == $10, "Script_SceneWaterReward is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 KalkaTalkEvents_WhereIsEverybody", ROMX

; Kalka talk 56: after the treasure theft, 'Wh-where is everybody?' when the inventory holds none of
; items $19-$1C, the second version when it holds any of them, message $018E after EVENT_CHECK_ITEM.
; (C2, E-0357; probed E-0375)
KalkaTalkEvents_WhereIsEverybody::
    ld de, EVENT_SCENE_TREASURE_THEFT
    call TestFlagBit
    ret nc
    ld de, EVENT_CHECK_ITEM
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
    ld hl, Script_WhWhereIsEverybody ; script '*: Wh-where is everybody? I haven't'
    ASSERT BANK(Script_WhWhereIsEverybody) == $10, "Script_WhWhereIsEverybody is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_WhWhereIsEverybody_2 ; script '*: Wh-where is everybody? I haven't'
    ASSERT BANK(Script_WhWhereIsEverybody_2) == $10, "Script_WhWhereIsEverybody_2 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $018e ; '*: Don't chase what runs from'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 KalkaTalkEvents_MonstersInTow", ROMX

; Kalka talk 57: sets bit 4 of story byte $61 (wStoryFlags + $61), starts Script_SceneMonstersInTow
; (sets EVENT_SCENE_MONSTERS_IN_TOW and runs SCRIPT_SCENE_MONSTERS_IN_TOW) and removes
; ITEM_WATERCALL ($30) from the inventory (FindTemp0InInventoryList, then
; RemoveInventorySlotShiftDown on the slot found, unchecked). (C2, E-0369; probed E-0375)
; starts Script_SceneMonstersInTow (E-0248)
KalkaTalkEvents_MonstersInTow::
    ld a, [wStoryFlags + $61]
    set 4, a
    ld [wStoryFlags + $61], a
    ld hl, Script_SceneMonstersInTow
    ASSERT BANK(Script_SceneMonstersInTow) == $10, "Script_SceneMonstersInTow is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ld a, $30
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    farcall RemoveInventorySlotShiftDown
    ret

SECTION "Bank 04 TalkMsg0194_ThievesDroveUsFromOurHomes", ROMX

; Kalka talk 58 (KalkaTalkEvents): message $01B2 ('Cooh, our home come back') once
; EVENT_SCENE_RIVAL_DEFEATED_05A is set, otherwise message $0194 ('Thieves drove us from our').
; Messages go through StartMessageCommand09HL_B04 (script command 9, wModeState = 1). (C2, E-0375)
; tests story flags (flag 005A then jr c,
; TalkMsg0194_ThievesDroveUsFromOurHomes.call_start_message_command09_hl_b04); starts message $0194
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'Thieves drove us
; from our homes!' (E-0268, the E-0082 shape; was TalkMsg0194_ThievesDroveUsFromOurHomes)
TalkMsg0194_ThievesDroveUsFromOurHomes::
    ld de, EVENT_SCENE_RIVAL_DEFEATED_05A
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0194 ; '*: Thieves drove us from our'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $01b2 ; '*: Cooh, our home come back'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0195_TheLeaderOfTheThievesIs", ROMX

; Kalka talk 59 (KalkaTalkEvents): message $01B4 ('Cooh! This bed perfect for') once
; EVENT_SCENE_RIVAL_DEFEATED_05A is set, otherwise message $0195 ('The leader of the thieves').
; Messages go through StartMessageCommand09HL_B04 (script command 9, wModeState = 1). (C2, E-0375)
; tests story flags (flag 005A then jr c,
; TalkMsg0195_TheLeaderOfTheThievesIs.call_start_message_command09_hl_b04); starts message $0195
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'The leader of the
; thieves is a' (E-0268, the E-0082 shape; was TalkMsg0195_TheLeaderOfTheThievesIs)
TalkMsg0195_TheLeaderOfTheThievesIs::
    ld de, EVENT_SCENE_RIVAL_DEFEATED_05A
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0195 ; '*: The leader of the thieves'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $01b4 ; '*: Cooh! This bed perfect for'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 KalkaTalkEvents_MonsterFan", ROMX

; Kalka talk 60: runs field command 3, then 'Heh, you have monsters in ...' the first time and 'You
; again? You ...' after its flag. (C1, E-0357)
KalkaTalkEvents_MonsterFan::
    ld a, $03
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld de, EVENT_HEH_YOU_HAVE_MONSTERS_IN
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_HehYouHaveMonsters ; script '*: Heh, you have monsters in'
    ASSERT BANK(Script_HehYouHaveMonsters) == $10, "Script_HehYouHaveMonsters is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_YouAgainYou ; script '*: You again! You're determined! But'
    ASSERT BANK(Script_YouAgainYou) == $10, "Script_YouAgainYou is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 TalkMsg01B5_KyoohSwimmingInADesertThis", ROMX

; Kalka talk 61 (KalkaTalkEvents): starts message $01B5 ('Kyooh! Swimming in a desert...') through
; StartMessageCommand09HL_B04 (script command 9 with the word in wScriptParam0/wScriptParam1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0375)
; starts message $01B5 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'Kyooh! Swimming in a desert This is' (E-0268, the E-0082 shape; was
; TalkMsg01B5_KyoohSwimmingInADesertThis)
TalkMsg01B5_KyoohSwimmingInADesertThis::
    ld hl, $01b5 ; '*: Kyooh! Swimming in a desert…'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg01BC_HeroCheckedTheTreasureChest", ROMX

; Kalka talk 62 (KalkaTalkEvents): starts message $01BC ('<BUF0> checked the treasure chest.
; Thieves') through StartMessageCommand09HL_B04 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0375)
; starts message $01BC through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 checked the treasure chest. Thieves have' (E-0268, the E-0082 shape; was
; TalkMsg01BC_HeroCheckedTheTreasureChest)
TalkMsg01BC_HeroCheckedTheTreasureChest::
    ld hl, $01bc ; '0 checked the treasure chest. Thieves'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg01BD_HeroPeeredIntoTheVaseIt", ROMX

; Kalka talk 63 (KalkaTalkEvents): starts message $01BD ('<BUF0> peered into the vase. It') through
; StartMessageCommand09HL_B04 (script command 9 with the word in wScriptParam0/wScriptParam1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0375)
; starts message $01BD through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 peered into the vase. It was' (E-0268, the E-0082 shape; was
; TalkMsg01BD_HeroPeeredIntoTheVaseIt)
TalkMsg01BD_HeroPeeredIntoTheVaseIt::
    ld hl, $01bd ; '0 peered into the vase. It'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg01C0_HeroCheckedTheTreasureChest", ROMX

; Kalka talk 64 (KalkaTalkEvents): starts message $01C0 ('<BUF0> checked the treasure chest. But')
; through StartMessageCommand09HL_B04 (script command 9 with the word in
; wScriptParam0/wScriptParam1, wScriptRunning = 1, wModeState = 1). (C2, E-0375)
; starts message $01C0 through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 checked the treasure chest. But it' (E-0268, the E-0082 shape; was
; TalkMsg01C0_HeroCheckedTheTreasureChest)
TalkMsg01C0_HeroCheckedTheTreasureChest::
    ld hl, $01c0 ; '0 checked the treasure chest. But'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg01BF_HeroPeeredIntoTheVaseThe", ROMX

; Kalka talk 65 (KalkaTalkEvents): starts message $01BF ('<BUF0> peered into the vase. The') through
; StartMessageCommand09HL_B04 (script command 9 with the word in wScriptParam0/wScriptParam1,
; wScriptRunning = 1, wModeState = 1). (C2, E-0375)
; starts message $01BF through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 peered into the vase. The prisoners' (E-0268, the E-0082 shape; was
; TalkMsg01BF_HeroPeeredIntoTheVaseThe)
TalkMsg01BF_HeroPeeredIntoTheVaseThe::
    ld hl, $01bf ; '0 peered into the vase. The'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 VaseItem_BeefJerky", ROMX

; Kalka talk 66 (KalkaTalkEvents), a one-time vase: StartTreasureFlagDE_B04 starts script command
; $0A (RunOneTimeTreasure) with wScriptParam0 = 1 (vase), wScriptParam1 = ITEM_BEEFJERKY and story
; flag $005B in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0, wModeState = 1).
; That command gives the item and sets the flag when the flag is clear (group-0 message $A3), shows
; $A4 when the flag is already set and $A5 when the bag is full. (C2, E-0375)
; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $19, story
; flag $005B in DE: when the flag is clear it gives item $19 (BeefJerky) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; VaseItem_BeefJerky)
VaseItem_BeefJerky::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $19
    ld [wScriptParam1], a
    ld de, $005b
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 KalkaTalkEvents_RivalFade", ROMX

; Kalka talk 67: does nothing until EVENT_SCENE_MONSTERS_IN_TOW is set; then starts
; Script_SceneRivalFade (sound $60 and SCRIPT_SCENE_RIVAL_FADE). (C2, E-0369; probed E-0375)
; starts Script_SceneRivalFade (E-0248)
KalkaTalkEvents_RivalFade::
    ld de, EVENT_SCENE_MONSTERS_IN_TOW
    call TestFlagBit
    ret nc
    ld hl, Script_SceneRivalFade
    ASSERT BANK(Script_SceneRivalFade) == $10, "Script_SceneRivalFade is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 KalkaTalkEvents_WaitStoryFlagsPlus61", ROMX

; Kalka talk 68: unless bit 4 of story byte $61 is set, clears its bit 3. (C2, E-0357; probed
; E-0375)
KalkaTalkEvents_WaitStoryFlagsPlus61::
    ld a, [wStoryFlags + $61]
    bit 4, a
    ret nz
    and $f7
    ld [wStoryFlags + $61], a
    ret

SECTION "Bank 04 KalkaTalkEvents_Church2", ROMX

; Kalka talk 69, a second church: 'Our church is impoverished' the first time, then 'I am a
; servant'. (C2, E-0357; probed E-0375)
KalkaTalkEvents_Church2::
    ld a, $1f
    ld [wDataBank], a
    ld de, EVENT_OUR_CHURCH_IS_IMPOVERISHED_SO
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_OurChurchIsImpoverished ; script '*: Our church is impoverished, so'
    ASSERT BANK(Script_OurChurchIsImpoverished) == $10, "Script_OurChurchIsImpoverished is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ld de, EVENT_OUR_CHURCH_IS_IMPOVERISHED_SO
    call SetFlagBit
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_IAmAServant_2 ; script '*: I am a servant to'
    ASSERT BANK(Script_IAmAServant_2) == $10, "Script_IAmAServant_2 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 DarckTalkEvents", ROMX

; Talk category 6 (DispatchTalkEvent_Darck far-calls it): jumps by wTalkEventGroup through two
; entries, with no range check: 0 DarckTalkEvents_HeardFromLord, 1 DarckTalkEvents_FightDarck. (C2,
; E-0375)
; talk category 6: two flag-tested handlers that start Darck's scripts ("Darck Fawahahah! You chased
; your treasures")
DarckTalkEvents::
    ld a, [wTalkEventGroup]
    jumptable
    dw DarckTalkEvents_HeardFromLord
    dw DarckTalkEvents_FightDarck

; Darck talk 0: after EVENT_TAKE_ITEM starts Script_YouSeemToStill ('You seem to still not'); before
; it, Script_IHeardFromLord_2 when the inventory holds all three of ITEM_TIDALBELL, ITEM_HARMIRROR
; and ITEM_SKY ($36-$38), and Script_IHeardFromLord as soon as one of them is missing
; (FindTemp0InInventoryList returns hTemp0 with bit 7 set). Both open with 'I heard from Lord
; Darck,'; their script_skip_if_no targets differ (Script_SurprisinglyObedientAreYou for _2,
; Script_HowDareYouCome for the other). (C2, E-0375)
DarckTalkEvents_HeardFromLord::
    ld de, EVENT_TAKE_ITEM
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
    ld hl, Script_IHeardFromLord_2 ; script '*: I heard from Lord Darck,'
    ASSERT BANK(Script_IHeardFromLord_2) == $10, "Script_IHeardFromLord_2 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_IHeardFromLord ; script '*: I heard from Lord Darck,'
    ASSERT BANK(Script_IHeardFromLord) == $10, "Script_IHeardFromLord is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b042:
    ld hl, Script_YouSeemToStill ; script '*: You seem to still not'
    ASSERT BANK(Script_YouSeemToStill) == $10, "Script_YouSeemToStill is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 DarckTalkEvents_FightDarck", ROMX

; Darck talk 1: the first time starts Script_DarckFawahahahYouChased ('Darck: Fawahahah! You chased
; your treasures', which sets EVENT_DARCK_FAWAHAHAH_YOU_CHASED_YOUR), afterwards
; Script_DarckFwahahahahBravoSplendid ('Darck: Fwahahahah! Bravo! Splendid! ...'); both run
; encounter $0A and then SCRIPT_SCENE_DARCK_DEFEATED. (C2, E-0369; probed E-0375)
; starts Script_DarckFawahahahYouChased: 'Darck: Fawahahah! You chased your treasures' (E-0248)
DarckTalkEvents_FightDarck::
    ld de, EVENT_DARCK_FAWAHAHAH_YOU_CHASED_YOUR
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_DarckFawahahahYouChased ; script 'Darck: Fawahahah! You chased your treasures'
    ASSERT BANK(Script_DarckFawahahahYouChased) == $10, "Script_DarckFawahahahYouChased is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_DarckFwahahahahBravoSplendid ; script 'Darck: Fwahahahah! Bravo! Splendid! You've come'
    ASSERT BANK(Script_DarckFwahahahahBravoSplendid) == $10, "Script_DarckFwahahahahBravoSplendid is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 FieldTalkEvents", ROMX

; Talk category 0 (DispatchTalkEvent_Field far-calls it): jumps by wTalkEventGroup through 40
; entries, with no range check. Entries 0, 3 and 39 do nothing (FieldTalkEvents_NoEvent); 1-2, 4-26
; and 29-33 each start a short field script through a Talk_* handler (Talk_ReturnWarp,
; Talk_BreedFade, Talk_ArenaRounds, ...), entries 11-13 all using Talk_KeyWorldDoorItem; 27-28 start
; the object paths after the three-item scene, and 34-38 are the follower talks. (C2, E-0375)
; talk category 0: jumps by wTalkEventGroup to the field events (the one-command scripts $80-$A1,
; E-0286)
FieldTalkEvents::
    ld a, [wTalkEventGroup]
    jumptable
    dw FieldTalkEvents_NoEvent
    dw Talk_FieldScene01
    dw Talk_RandomGoldOrItem
    dw FieldTalkEvents_NoEvent
    dw Talk_PartyDefeatedReturn
    dw Talk_ReturnMessage
    dw Talk_ReturnWarp
    dw Talk_MapExitWarp
    dw Talk_MapLinkWarp
    dw Talk_PlayerSpriteFlash
    dw Talk_PlayerSpriteMessage
    dw Talk_KeyWorldDoorItem
    dw Talk_KeyWorldDoorItem
    dw Talk_KeyWorldDoorItem
    dw Talk_AreaItem
    dw Talk_StepTriggerReward
    dw Talk_FollowersStep10
    dw Talk_FollowersStep11
    dw Talk_PlayerAndFollowersStep
    dw Talk_WarpWithFollowers
    dw Talk_FollowersStep14
    dw Talk_BreedFade
    dw Talk_BreedChildSprite
    dw Talk_BreedChildScene
    dw Talk_ArenaGridBattle
    dw Talk_RandomBattle
    dw Talk_HealParty
    dw FieldTalkEvents_ObjectPathAfterThreeItems
    dw FieldTalkEvents_ObjectPathAfterThreeItems2
    dw Talk_EncounterMessage
    dw Talk_CountdownMessage
    dw Talk_ArenaRounds
    dw Talk_NpcBreedWarp
    dw Talk_LinkMessage
    dw FieldTalkEvents_TalkToFollower
    dw FieldTalkEvents_TalkToSecondFollower
    dw FieldTalkEvents_TalkToThirdFollower
    dw FieldTalkEvents_KamehaStoleScene
    dw FieldTalkEvents_ResumeFollowers
    dw FieldTalkEvents_NoEvent

; Field talk 30 (FieldTalkEvents): starts Script_CountdownMessage (the single command
; SCRIPT_COUNTDOWN_MESSAGE ($9D), then script_end) through StartScriptAtHL_B04 (wScriptPointerLo/Hi
; = the script, wScriptStartRequest = $80, wModeState = 1). (C2, E-0375)
; starts Script_CountdownMessage (StartScriptAtHL_B04) (E-0271; was Talk_CountdownMessage) (E-0344:
; the address in its name dropped or read as the label there; was Talk_CountdownMessage; named after
; the script it starts, Script_CountdownMessage)
; starts Script_CountdownMessage (E-0248)
Talk_CountdownMessage::
    ld hl, Script_CountdownMessage
    ASSERT BANK(Script_CountdownMessage) == $10, "Script_CountdownMessage is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_EncounterMessage", ROMX

; Field talk 29 (FieldTalkEvents): starts Script_EncounterMessage (the single command
; SCRIPT_ENCOUNTER_MESSAGE ($9C), then script_end) through StartScriptAtHL_B04 (wScriptPointerLo/Hi
; = the script, wScriptStartRequest = $80, wModeState = 1). (C2, E-0375)
; starts Script_EncounterMessage (StartScriptAtHL_B04) (E-0271; was Talk_EncounterMessage) (E-0344:
; the address in its name dropped or read as the label there; was Talk_EncounterMessage; named after
; the script it starts, Script_EncounterMessage)
; starts Script_EncounterMessage (E-0248)
Talk_EncounterMessage::
    ld hl, Script_EncounterMessage
    ASSERT BANK(Script_EncounterMessage) == $10, "Script_EncounterMessage is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 FieldTalkEvents_ObjectPathAfterThreeItems2", ROMX

; Field talk 28: after the three-item scene starts the object path script $1C. (C2, E-0357; probed
; E-0375)
FieldTalkEvents_ObjectPathAfterThreeItems2::
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_ObjectPath1c
    ASSERT BANK(Script_ObjectPath1c) == $10, "Script_ObjectPath1c is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 FieldTalkEvents_ObjectPathAfterThreeItems", ROMX

; Field talk 27: after the three-item scene starts the object path script $1B. (C2, E-0357; probed
; E-0375)
FieldTalkEvents_ObjectPathAfterThreeItems::
    ld de, EVENT_SCENE_THREE_ITEMS
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_ObjectPath1b
    ASSERT BANK(Script_ObjectPath1b) == $10, "Script_ObjectPath1b is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_HealParty", ROMX

; Field talk 26 (FieldTalkEvents): starts Script_HealParty (the single command SCRIPT_HEAL_PARTY
; ($9B), then script_end) through StartScriptAtHL_B04 (wScriptPointerLo/Hi = the script,
; wScriptStartRequest = $80, wModeState = 1). (C2, E-0375)
; starts Script_HealParty (StartScriptAtHL_B04) (E-0271; was Talk_HealParty) (E-0344: the address in
; its name dropped or read as the label there; was Talk_HealParty; named after the script it starts,
; Script_HealParty)
; starts Script_HealParty (E-0248)
Talk_HealParty::
    ld hl, Script_HealParty
    ASSERT BANK(Script_HealParty) == $10, "Script_HealParty is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_RandomBattle", ROMX

; Field talk 25 (FieldTalkEvents): starts Script_RandomBattle (the single command
; SCRIPT_RANDOM_BATTLE ($9A), then script_end) through StartScriptAtHL_B04 (wScriptPointerLo/Hi =
; the script, wScriptStartRequest = $80, wModeState = 1). (C2, E-0375)
; starts Script_RandomBattle (StartScriptAtHL_B04) (E-0271; was Talk_RandomBattle) (E-0344: the
; address in its name dropped or read as the label there; was Talk_RandomBattle; named after the
; script it starts, Script_RandomBattle)
; starts Script_RandomBattle (E-0248)
Talk_RandomBattle::
    ld hl, Script_RandomBattle
    ASSERT BANK(Script_RandomBattle) == $10, "Script_RandomBattle is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_ArenaGridBattle", ROMX

; Field talk 24 (FieldTalkEvents): starts Script_ArenaGridBattle (script_hold_dpad $00, 5, then
; SCRIPT_ARENA_GRID_BATTLE ($95)) through StartScriptAtHL_B04 (wScriptPointerLo/Hi = the script,
; wScriptStartRequest = $80, wModeState = 1). (C2, E-0375)
; starts Script_ArenaGridBattle (StartScriptAtHL_B04) (E-0271; was Talk_ArenaGridBattle) (E-0344:
; the address in its name dropped or read as the label there; was Talk_ArenaGridBattle; named after
; the script it starts, Script_ArenaGridBattle)
; starts Script_ArenaGridBattle (E-0248)
Talk_ArenaGridBattle::
    ld hl, Script_ArenaGridBattle
    ASSERT BANK(Script_ArenaGridBattle) == $10, "Script_ArenaGridBattle is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_ArenaRounds", ROMX

; Field talk 31 (FieldTalkEvents): starts Script_ArenaRounds (script_hold_dpad $00, 5, then
; SCRIPT_ARENA_ROUNDS ($96)) through StartScriptAtHL_B04 (wScriptPointerLo/Hi = the script,
; wScriptStartRequest = $80, wModeState = 1). (C2, E-0375)
; starts Script_ArenaRounds (StartScriptAtHL_B04) (E-0271; was Talk_ArenaRounds) (E-0344: the
; address in its name dropped or read as the label there; was Talk_ArenaRounds; named after the
; script it starts, Script_ArenaRounds)
; starts Script_ArenaRounds (E-0248)
Talk_ArenaRounds::
    ld hl, Script_ArenaRounds
    ASSERT BANK(Script_ArenaRounds) == $10, "Script_ArenaRounds is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_BreedFade", ROMX

; Field talk 21 (FieldTalkEvents): starts Script_BreedFade (the single command SCRIPT_BREED_FADE
; ($8B), then script_end) through StartScriptAtHL_B04 (wScriptPointerLo/Hi = the script,
; wScriptStartRequest = $80, wModeState = 1). (C2, E-0375)
; starts Script_BreedFade (StartScriptAtHL_B04) (E-0271; was Talk_BreedFade) (E-0344: the address in
; its name dropped or read as the label there; was Talk_BreedFade; named after the script it starts,
; Script_BreedFade)
; starts Script_BreedFade (E-0248)
Talk_BreedFade::
    ld hl, Script_BreedFade
    ASSERT BANK(Script_BreedFade) == $10, "Script_BreedFade is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_BreedChildSprite", ROMX

; Field talk 22 (FieldTalkEvents): starts Script_BreedChildSprite (the single command
; SCRIPT_BREED_CHILD_SPRITE ($8C), then script_end) through StartScriptAtHL_B04 (wScriptPointerLo/Hi
; = the script, wScriptStartRequest = $80, wModeState = 1). (C2, E-0375)
; starts Script_BreedChildSprite (StartScriptAtHL_B04) (E-0271; was Talk_BreedChildSprite) (E-0344:
; the address in its name dropped or read as the label there; was Talk_BreedChildSprite; named after
; the script it starts, Script_BreedChildSprite)
; starts Script_BreedChildSprite (E-0248)
Talk_BreedChildSprite::
    ld hl, Script_BreedChildSprite
    ASSERT BANK(Script_BreedChildSprite) == $10, "Script_BreedChildSprite is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_BreedChildScene", ROMX

; Field talk 23 (FieldTalkEvents): starts Script_BreedChildScene (the single command
; SCRIPT_BREED_CHILD_SCENE ($8D), then script_end) through StartScriptAtHL_B04 (wScriptPointerLo/Hi
; = the script, wScriptStartRequest = $80, wModeState = 1). (C2, E-0375)
; starts Script_BreedChildScene (StartScriptAtHL_B04) (E-0271; was Talk_BreedChildScene) (E-0344:
; the address in its name dropped or read as the label there; was Talk_BreedChildScene; named after
; the script it starts, Script_BreedChildScene)
; starts Script_BreedChildScene (E-0248)
Talk_BreedChildScene::
    ld hl, Script_BreedChildScene
    ASSERT BANK(Script_BreedChildScene) == $10, "Script_BreedChildScene is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_NpcBreedWarp", ROMX

; Field talk 32 (FieldTalkEvents): starts Script_NpcBreedWarp (the single command
; SCRIPT_NPC_BREED_WARP ($8F), then script_end) through StartScriptAtHL_B04 (wScriptPointerLo/Hi =
; the script, wScriptStartRequest = $80, wModeState = 1). (C2, E-0375)
; starts Script_NpcBreedWarp (StartScriptAtHL_B04) (E-0271; was Talk_NpcBreedWarp) (E-0344: the
; address in its name dropped or read as the label there; was Talk_NpcBreedWarp; named after the
; script it starts, Script_NpcBreedWarp)
; starts Script_NpcBreedWarp (E-0248)
Talk_NpcBreedWarp::
    ld hl, Script_NpcBreedWarp
    ASSERT BANK(Script_NpcBreedWarp) == $10, "Script_NpcBreedWarp is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_LinkMessage", ROMX

; Field talk 33 (FieldTalkEvents): starts Script_LinkMessage (the single command SCRIPT_LINK_MESSAGE
; ($9F), then script_end) through StartScriptAtHL_B04 (wScriptPointerLo/Hi = the script,
; wScriptStartRequest = $80, wModeState = 1). (C2, E-0375)
; starts Script_LinkMessage (StartScriptAtHL_B04) (E-0271; was Talk_LinkMessage) (E-0344: the
; address in its name dropped or read as the label there; was Talk_LinkMessage; named after the
; script it starts, Script_LinkMessage)
; starts Script_LinkMessage (E-0248)
Talk_LinkMessage::
    ld hl, Script_LinkMessage
    ASSERT BANK(Script_LinkMessage) == $10, "Script_LinkMessage is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 FieldTalkEvents_TalkToFollower", ROMX

; Field talk 34, talking to the first follower: while the followers trail the player, turns follower
; 0 to face the player and starts its personality message (wScriptParam1 = 0). (C2, E-0357; probed
; E-0375)
FieldTalkEvents_TalkToFollower::
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
    ld hl, Script_PersonalityMessage
    ASSERT BANK(Script_PersonalityMessage) == $10, "Script_PersonalityMessage is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 FieldTalkEvents_TalkToSecondFollower", ROMX

; Field talk 35, the second follower: as talk 34 for follower 1 when the party has at least two
; members. (C2, E-0357; probed E-0375)
FieldTalkEvents_TalkToSecondFollower::
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
    ld hl, Script_PersonalityMessage
    ASSERT BANK(Script_PersonalityMessage) == $10, "Script_PersonalityMessage is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 FieldTalkEvents_TalkToThirdFollower", ROMX

; Field talk 36, the third follower: as talk 34 for follower 2 when the party has three members.
; (C2, E-0357; probed E-0375)
FieldTalkEvents_TalkToThirdFollower::
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
    ld hl, Script_PersonalityMessage
    ASSERT BANK(Script_PersonalityMessage) == $10, "Script_PersonalityMessage is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 FieldTalkEvents_KamehaStoleScene", ROMX

; Field talk 37: when wFollowerDelay is 0, starts Script_SceneKamehaStole (a facing command, then
; SCRIPT_SCENE_KAMEHA_STOLE); otherwise does nothing. (C2, E-0369; probed E-0375)
; starts Script_SceneKamehaStole (E-0248)
FieldTalkEvents_KamehaStoleScene::
    ld a, [wFollowerDelay]
    or a
    ret nz
    ld hl, Script_SceneKamehaStole
    ASSERT BANK(Script_SceneKamehaStole) == $10, "Script_SceneKamehaStole is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 FieldTalkEvents_ResumeFollowers", ROMX

; Field talk 38: clears wFollowerDelay, so StepFollowersTowardTargets moves the followers again and
; UpdatePlayerMovement_AdvanceStep_SnapFollowers stops holding them on the player
; (SceneKamehaStole_DrawBlocks in bank $73 sets it to 1; the follower talks 34-36 only read it). It
; starts no script. (C2, E-0375)
; starts Script_FollowersStep10 (E-0248)
FieldTalkEvents_ResumeFollowers::
    xor a
    ld [wFollowerDelay], a
    ret

SECTION "Bank 04 Talk_FollowersStep10", ROMX

; Field talk 16 (FieldTalkEvents): starts Script_FollowersStep10 (the single command
; SCRIPT_FOLLOWERS_STEP_10 ($90), then script_end) through StartScriptAtHL_B04 (wScriptPointerLo/Hi
; = the script, wScriptStartRequest = $80, wModeState = 1). (C2, E-0375)
; starts Script_FollowersStep10 (StartScriptAtHL_B04) (E-0271; was Talk_FollowersStep10) (E-0344:
; the address in its name dropped or read as the label there; was Talk_FollowersStep10; named after
; the script it starts, Script_FollowersStep10)
; starts Script_FollowersStep10 (E-0248)
Talk_FollowersStep10::
    ld hl, Script_FollowersStep10
    ASSERT BANK(Script_FollowersStep10) == $10, "Script_FollowersStep10 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_FollowersStep11", ROMX

; Field talk 17 (FieldTalkEvents): starts Script_FollowersStep11 (the single command
; SCRIPT_FOLLOWERS_STEP_11 ($91), then script_end) through StartScriptAtHL_B04 (wScriptPointerLo/Hi
; = the script, wScriptStartRequest = $80, wModeState = 1). (C2, E-0375)
; starts Script_FollowersStep11 (StartScriptAtHL_B04) (E-0271; was Talk_FollowersStep11) (E-0344:
; the address in its name dropped or read as the label there; was Talk_FollowersStep11; named after
; the script it starts, Script_FollowersStep11)
; starts Script_FollowersStep11 (E-0248)
Talk_FollowersStep11::
    ld hl, Script_FollowersStep11
    ASSERT BANK(Script_FollowersStep11) == $10, "Script_FollowersStep11 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_PlayerAndFollowersStep", ROMX

; Field talk 18 (FieldTalkEvents): starts Script_PlayerAndFollowersStep (the single command
; SCRIPT_PLAYER_AND_FOLLOWERS_STEP ($92), then script_end) through StartScriptAtHL_B04
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1). (C2, E-0375)
; starts Script_PlayerAndFollowersStep (StartScriptAtHL_B04) (E-0271; was
; Talk_PlayerAndFollowersStep) (E-0344: the address in its name dropped or read as the label there;
; was Talk_PlayerAndFollowersStep; named after the script it starts, Script_PlayerAndFollowersStep)
; starts Script_PlayerAndFollowersStep (E-0248)
Talk_PlayerAndFollowersStep::
    ld hl, Script_PlayerAndFollowersStep
    ASSERT BANK(Script_PlayerAndFollowersStep) == $10, "Script_PlayerAndFollowersStep is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_WarpWithFollowers", ROMX

; Field talk 19 (FieldTalkEvents): starts Script_WarpWithFollowers (the single command
; SCRIPT_WARP_WITH_FOLLOWERS ($93), then script_end) through StartScriptAtHL_B04
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1). (C2, E-0375)
; starts Script_WarpWithFollowers (StartScriptAtHL_B04) (E-0271; was Talk_WarpWithFollowers)
; (E-0344: the address in its name dropped or read as the label there; was Talk_WarpWithFollowers;
; named after the script it starts, Script_WarpWithFollowers)
; starts Script_WarpWithFollowers (E-0248)
Talk_WarpWithFollowers::
    ld hl, Script_WarpWithFollowers
    ASSERT BANK(Script_WarpWithFollowers) == $10, "Script_WarpWithFollowers is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_FollowersStep14", ROMX

; Field talk 20 (FieldTalkEvents): starts Script_FollowersStep14 (the single command
; SCRIPT_FOLLOWERS_STEP_14 ($94), then script_end) through StartScriptAtHL_B04 (wScriptPointerLo/Hi
; = the script, wScriptStartRequest = $80, wModeState = 1). (C2, E-0375)
; starts Script_FollowersStep14 (StartScriptAtHL_B04) (E-0271; was Talk_FollowersStep14) (E-0344:
; the address in its name dropped or read as the label there; was Talk_FollowersStep14; named after
; the script it starts, Script_FollowersStep14)
; starts Script_FollowersStep14 (E-0248)
Talk_FollowersStep14::
    ld hl, Script_FollowersStep14
    ASSERT BANK(Script_FollowersStep14) == $10, "Script_FollowersStep14 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 FieldTalkEvents_NoEvent", ROMX

; Field talk 0, 3 and 39: returns at once; these entries start nothing. (C2, E-0369; probed E-0375)
; starts Script_FieldScene01 (E-0248)
FieldTalkEvents_NoEvent::
    ret

SECTION "Bank 04 Talk_FieldScene01", ROMX

; Field talk 1 (FieldTalkEvents): starts Script_FieldScene01 through StartScriptAtHL_B04
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1); that script is the
; one command SCRIPT_FIELD_SCENE_01, run by FieldScene01: draws script meta-sprite 21, moves objects
; and changes the music. (C2, E-0375)
; starts Script_FieldScene01 (StartScriptAtHL_B04) (E-0271; was Talk_FieldScene01) (E-0344: the
; address in its name dropped or read as the label there; was Talk_FieldScene01; named after the
; script it starts, Script_FieldScene01)
; starts Script_FieldScene01 (E-0248)
Talk_FieldScene01::
    ld hl, Script_FieldScene01
    ASSERT BANK(Script_FieldScene01) == $10, "Script_FieldScene01 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_RandomGoldOrItem", ROMX

; Field talk 2 (FieldTalkEvents): starts Script_RandomGoldOrItem through StartScriptAtHL_B04
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1); that script is the
; one command SCRIPT_RANDOM_GOLD_OR_ITEM, run by RandomGoldOrItem: random gold (AddGoldCapped) or an
; item (AppendItemStepPtrLoToInventory). (C2, E-0375)
; starts Script_RandomGoldOrItem (StartScriptAtHL_B04) (E-0271; was Talk_RandomGoldOrItem) (E-0344:
; the address in its name dropped or read as the label there; was Talk_RandomGoldOrItem; named after
; the script it starts, Script_RandomGoldOrItem)
; starts Script_RandomGoldOrItem (E-0248)
Talk_RandomGoldOrItem::
    ld hl, Script_RandomGoldOrItem
    ASSERT BANK(Script_RandomGoldOrItem) == $10, "Script_RandomGoldOrItem is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_PartyDefeatedReturn", ROMX

; Field talk 4 (FieldTalkEvents): starts Script_PartyDefeatedReturn through StartScriptAtHL_B04
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1); that script is the
; one command SCRIPT_PARTY_DEFEATED_RETURN, run by PartyDefeatedReturn: moves incapacitated party
; members back (MoveIncapacitatedPartyMembersBack) and starts the return warp
; (StartReturnWarpByFlag25). (C2, E-0375)
; starts Script_PartyDefeatedReturn (StartScriptAtHL_B04) (E-0271; was Talk_PartyDefeatedReturn)
; (E-0344: the address in its name dropped or read as the label there; was Talk_PartyDefeatedReturn;
; named after the script it starts, Script_PartyDefeatedReturn)
; starts Script_PartyDefeatedReturn (E-0248)
Talk_PartyDefeatedReturn::
    ld hl, Script_PartyDefeatedReturn
    ASSERT BANK(Script_PartyDefeatedReturn) == $10, "Script_PartyDefeatedReturn is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_ReturnMessage", ROMX

; Field talk 5 (FieldTalkEvents): starts Script_ReturnMessage through StartScriptAtHL_B04
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1); that script is the
; one command SCRIPT_RETURN_MESSAGE, run by ReturnMessage: a message chosen by a story flag. (C2,
; E-0375)
; starts Script_ReturnMessage (StartScriptAtHL_B04) (E-0271; was Talk_ReturnMessage) (E-0344: the
; address in its name dropped or read as the label there; was Talk_ReturnMessage; named after the
; script it starts, Script_ReturnMessage)
; starts Script_ReturnMessage (E-0248)
Talk_ReturnMessage::
    ld hl, Script_ReturnMessage
    ASSERT BANK(Script_ReturnMessage) == $10, "Script_ReturnMessage is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_ReturnWarp", ROMX

; Field talk 6 (FieldTalkEvents): starts Script_ReturnWarp through StartScriptAtHL_B04
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1); that script is the
; one command SCRIPT_RETURN_WARP, run by ReturnWarp: the return warp through
; StartReturnWarpByFlag25. (C2, E-0375)
; starts Script_ReturnWarp (StartScriptAtHL_B04) (E-0271; was Talk_ReturnWarp) (E-0344: the address
; in its name dropped or read as the label there; was Talk_ReturnWarp; named after the script it
; starts, Script_ReturnWarp)
; starts Script_ReturnWarp (E-0248)
Talk_ReturnWarp::
    ld hl, Script_ReturnWarp
    ASSERT BANK(Script_ReturnWarp) == $10, "Script_ReturnWarp is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_MapExitWarp", ROMX

; Field talk 7 (FieldTalkEvents): starts Script_MapExitWarp through StartScriptAtHL_B04
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1); that script is the
; one command SCRIPT_MAP_EXIT_WARP, run by MapExitWarp: a fade, then the warp destination from the
; map exit records. (C2, E-0375)
; starts Script_MapExitWarp (StartScriptAtHL_B04) (E-0271; was Talk_MapExitWarp) (E-0344: the
; address in its name dropped or read as the label there; was Talk_MapExitWarp; named after the
; script it starts, Script_MapExitWarp)
; starts Script_MapExitWarp (E-0248)
Talk_MapExitWarp::
    ld hl, Script_MapExitWarp
    ASSERT BANK(Script_MapExitWarp) == $10, "Script_MapExitWarp is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_MapLinkWarp", ROMX

; Field talk 8 (FieldTalkEvents): starts Script_MapLinkWarp through StartScriptAtHL_B04
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1); that script is the
; one command SCRIPT_MAP_LINK_WARP, run by MapLinkWarp: the timed player and follower lift, then the
; destination from the map link records or the key-world path. (C2, E-0375)
; starts Script_MapLinkWarp (StartScriptAtHL_B04) (E-0271; was Talk_MapLinkWarp) (E-0344: the
; address in its name dropped or read as the label there; was Talk_MapLinkWarp; named after the
; script it starts, Script_MapLinkWarp)
; starts Script_MapLinkWarp (E-0248)
Talk_MapLinkWarp::
    ld hl, Script_MapLinkWarp
    ASSERT BANK(Script_MapLinkWarp) == $10, "Script_MapLinkWarp is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_PlayerSpriteFlash", ROMX

; Field talk 9 (FieldTalkEvents): starts Script_PlayerSpriteFlash through StartScriptAtHL_B04
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1); that script is the
; one command SCRIPT_PLAYER_SPRITE_FLASH, run by PlayerSpriteFlash: a screen flash and turns while
; the player sprite takes an override graphics id. (C2, E-0375)
; starts Script_PlayerSpriteFlash (StartScriptAtHL_B04) (E-0271; was Talk_PlayerSpriteFlash)
; (E-0344: the address in its name dropped or read as the label there; was Talk_PlayerSpriteFlash;
; named after the script it starts, Script_PlayerSpriteFlash)
; starts Script_PlayerSpriteFlash (E-0248)
Talk_PlayerSpriteFlash::
    ld hl, Script_PlayerSpriteFlash
    ASSERT BANK(Script_PlayerSpriteFlash) == $10, "Script_PlayerSpriteFlash is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_PlayerSpriteMessage", ROMX

; Field talk 10 (FieldTalkEvents): starts Script_PlayerSpriteMessage through StartScriptAtHL_B04
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1); that script is the
; one command SCRIPT_PLAYER_SPRITE_MESSAGE, run by PlayerSpriteMessage: message $12 of the current
; group, then clears the player sprite override and reloads the default graphics. (C2, E-0375)
; starts Script_PlayerSpriteMessage (StartScriptAtHL_B04) (E-0271; was Talk_PlayerSpriteMessage)
; (E-0344: the address in its name dropped or read as the label there; was Talk_PlayerSpriteMessage;
; named after the script it starts, Script_PlayerSpriteMessage)
; starts Script_PlayerSpriteMessage (E-0248)
Talk_PlayerSpriteMessage::
    ld hl, Script_PlayerSpriteMessage
    ASSERT BANK(Script_PlayerSpriteMessage) == $10, "Script_PlayerSpriteMessage is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_KeyWorldDoorItem", ROMX

; Field talks 11, 12 and 13 (FieldTalkEvents): starts Script_KeyWorldDoorItem through
; StartScriptAtHL_B04 (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1);
; that script is the one command SCRIPT_KEY_WORLD_DOOR_ITEM, run by KeyWorldDoorItem: a random item
; or key entry (GenerateNewKeyEntry) and door tiles for the key-world floor
; (DrawDoorTilesForKeyWorldFloor). (C2, E-0375)
; starts Script_KeyWorldDoorItem (StartScriptAtHL_B04) (E-0271; was Talk_KeyWorldDoorItem) (E-0344:
; the address in its name dropped or read as the label there; was Talk_KeyWorldDoorItem; named after
; the script it starts, Script_KeyWorldDoorItem)
; starts Script_KeyWorldDoorItem (E-0248)
Talk_KeyWorldDoorItem::
    ld hl, Script_KeyWorldDoorItem
    ASSERT BANK(Script_KeyWorldDoorItem) == $10, "Script_KeyWorldDoorItem is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_AreaItem", ROMX

; Field talk 14 (FieldTalkEvents): starts Script_AreaItem through StartScriptAtHL_B04
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1); that script is the
; one command SCRIPT_AREA_ITEM, run by AreaItemEvent: gives an item (AppendItemStepPtrLoToInventory)
; and redraws the screen. (C2, E-0375)
; starts Script_AreaItem (StartScriptAtHL_B04) (E-0271; was Talk_AreaItem) (E-0344: the address in
; its name dropped or read as the label there; was Talk_AreaItem; named after the script it starts,
; Script_AreaItem)
; starts Script_AreaItem (E-0248)
Talk_AreaItem::
    ld hl, Script_AreaItem
    ASSERT BANK(Script_AreaItem) == $10, "Script_AreaItem is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_StepTriggerReward", ROMX

; Field talk 15 (FieldTalkEvents): starts Script_StepTriggerReward through StartScriptAtHL_B04
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1); that script is the
; one command SCRIPT_STEP_TRIGGER_REWARD, run by StepTriggerReward: gold (AddGoldCapped), an item or
; a battle. (C2, E-0375)
; starts Script_StepTriggerReward (StartScriptAtHL_B04) (E-0271; was Talk_StepTriggerReward)
; (E-0344: the address in its name dropped or read as the label there; was Talk_StepTriggerReward;
; named after the script it starts, Script_StepTriggerReward)
; starts Script_StepTriggerReward (E-0248)
Talk_StepTriggerReward::
    ld hl, Script_StepTriggerReward
    ASSERT BANK(Script_StepTriggerReward) == $10, "Script_StepTriggerReward is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 ElvenVillageTalkEvents", ROMX

; Talk category 7 (DispatchTalkEvent_ElvenVillage far-calls it): jumps through its table of 184
; handlers by wTalkEventGroup, with no range check. The handlers cover the people, vases, barrels,
; ovens, bookshelves and chests of the Elven village world: Cyal, Rolt and the elves, the lookout
; post, Kiral and the robots, the town of Miagen, the traveler hut, and the Power and Baffle Tower
; floors (messages $0700-$07DD, $0C00-$0C2F and $0CE2-$0CFE). Entries 28-31, 86-95, 121-127 and
; 152-159 are $0000, which would jump to address 0. (C2, E-0375)
; talk category 7: jumps by wTalkEventGroup to the talk handlers of the Elven village world
; (messages $0700-$07BF, $0C00-$0CFF)
ElvenVillageTalkEvents::
    ld a, [wTalkEventGroup]
    jumptable
    dw ElvenVillageTalkEvents_CyalScenes
    dw ElvenVillageTalkEvents_ShowYoureAHumanHow
    dw ElvenVillageTalkEvents_Cyal
    dw TalkMsg0708_HelloMunchkinEnjoyYourStay
    dw TalkMsg0709_AHumanHereItsBeenSeveral
    dw TalkMsg070A_YoureNotLikeUsYouScare
    dw TalkMsg070B_HeyThereImATalkingHorse
    dw TalkMsg070C_ThisHorseWasHereBeforeUs
    dw TalkMsg070D_ThisIsElvenVillageYoureA
    dw TalkMsg0752_IveHeardThatHumansAre
    dw ElvenVillageTalkEvents_Shop
    dw ElvenVillageTalkEvents_ShowWellWellItIs
    dw ElvenVillageTalkEvents_MasterAgDevil
    dw TalkMsg0723_TchWeHaveToEatThe
    dw ElvenVillageTalkEvents_ThatsWhatWellDo
    dw TalkMsg072F_ThisIsElvensLookoutPostWe
    dw TalkMsg0730_HorridMonstersThatAttack
    dw ElvenVillageTalkEvents_KeyBossBattle
    dw ElvenVillageTalkEvents_RoltFoundYou
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
    dw Talk0768_HeroPeeredIntoThe_2
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
    dw ElvenVillageTalkEvents_ShopHelloWhatMayI
    dw ElvenVillageTalkEvents_TravelersInn
    dw TalkMsg079F_IfYouTravelWest
    dw Talk07D7_MilayouIEBeen
    dw TalkMsg07A9_ThisIsTheTravelersHutStay
    dw TalkMsg07AA_ThatDealerHowExpensive
    dw Talk07C1_WhatMonstersAttackedYou
    dw TalkMsg07AE_ThatDealersWaresCould
    dw Talk07AF_HowDoesThisOrnament
    dw TalkMsg07B8_WhoAreYou
    dw ElvenVillageTalkEvents_SceneMercyBattle
    dw Talk07BF_HeroFoundThePretty
    dw ElvenVillageTalkEvents_SecondKeyBossBattle
    dw VaseItem_DEFseed
    dw VaseItem_TinyMedal_Flag01C9
    dw TalkMsg0CFB_HeroTriedToOpenTheChest
    dw TalkMsg0CFA_HeroPeeredIntoTheOvenA
    dw TalkMsg0CFC_HeroPeeredIntoTheVaseCold
    dw VaseItem_Potion_Flag01CA
    dw TalkMsg0CFD_HeroPeeredIntoTheOvenMeat
    dw ChestItem_Laurel
    dw ElvenVillageTalkEvents_LootChest
    dw ChestItem_ExitBell_Flag01CC
    dw ChestItem_TinyMedal
    dw ChestItem_Friend
    dw Talk_HeroCheckedTheTreasureChest
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
    dw Talk_SceneChestBattle
    dw Talk_SceneChestBattle
    dw Talk_SceneChestBattle
    dw Talk_SceneChestBattle
    dw ElvenVillageTalkEvents_PowerTowerChestBattle
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
    dw Talk_HeroCheckedTheTreasureChest_2
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
    dw Talk_SceneChestBattle_2
    dw Talk_SceneChestBattle_2
    dw Talk_SceneChestBattle_2
    dw Talk_SceneChestBattle_2
    dw ElvenVillageTalkEvents_BaffleTowerChestBattle
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
    dw Talk_SoulTowerChestBattle
    dw Talk_SoulTowerChestBattle
    dw Talk_SoulTowerChestBattle
    dw Talk_SoulTowerChestBattle
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

; Elven village talk 0: before EVENT_SCENE_CYAL_SHINE starts Script_SceneCyalShine (which sets it);
; afterwards, once EVENT_CYAL_LISTEN_HERO_WE_SHOULD is set and while EVENT_CYAL_EEEK_HERO_HELP_ME is
; clear, starts Script_CyalOhHeroI ('Cyal: Oh! <PLAYER>! I'm over here!' ... 'Cyal: Eeek, <PLAYER>!
; Help me!', which sets EVENT_CYAL_EEEK_HERO_HELP_ME); otherwise nothing. (C2, E-0369; probed
; E-0375)
; starts Script_SceneCyalShine (E-0248)
ElvenVillageTalkEvents_CyalScenes::
    ld de, EVENT_SCENE_CYAL_SHINE
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld hl, Script_SceneCyalShine
    ASSERT BANK(Script_SceneCyalShine) == $10, "Script_SceneCyalShine is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_test_flag_bit:
    ld de, EVENT_CYAL_EEEK_HERO_HELP_ME
    call TestFlagBit
    ret c
    ld de, EVENT_CYAL_LISTEN_HERO_WE_SHOULD
    call TestFlagBit
    ret nc
    ld hl, Script_CyalOhHeroI ; script 'Cyal: Oh! 0! I'm over here!'
    ASSERT BANK(Script_CyalOhHeroI) == $10, "Script_CyalOhHeroI is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 ElvenVillageTalkEvents_ShowYoureAHumanHow", ROMX

; Elven village talk 1: messages $0701, $0702, $0706 and others and two scripts, chosen by the
; village story from the first meeting with a human to the key boss beaten (EVENT_KEY_BOSS_BEATEN);
; some set their own flags. (C2, E-0357; probed E-0375)
ElvenVillageTalkEvents_ShowYoureAHumanHow::
    ld de, EVENT_KEY_BOSS_BEATEN
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b044
    ld de, EVENT_SCENE_GIVE_BACK_CYAL
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, EVENT_SCENE_TOO_STRONG
    call TestFlagBit
    jr c, .call_start_script_at_hl_b042
    ld de, EVENT_SCENE_ROLT_ELDER
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_CYAL_YAY_YOU
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld de, EVENT_YOURE_AHUMAN_HOW
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld hl, $0701 ; '*: You're a human. How did'
    call StartMessageCommand09HL_B04
    ld de, EVENT_YOURE_AHUMAN_HOW
    call SetFlagBit
    ret

.call_test_flag_bit:
    ld de, EVENT_ARE_YOU_MAYBE_A
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, $0702 ; '*: Even worse, you have monsters.'
    call StartMessageCommand09HL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_SoCyalTookA ; script '*: So Cyal took a shine'
    ASSERT BANK(Script_SoCyalTookA) == $10, "Script_SoCyalTookA is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0706 ; 'Rolt: Go south in the plains,'
    call StartMessageCommand09HL_B04
    ld de, EVENT_YOURE_AHUMAN_HOW_145
    call SetFlagBit
    ret

.call_start_message_command09_hl_b042:
    ld hl, $0715 ; 'Rolt: 0, I can see that'
    call StartMessageCommand09HL_B04
    ret

.call_start_script_at_hl_b042:
    ld hl, Script_RoltWhatCyalWas ; script 'Rolt: What? Cyal was abducted? Who'
    ASSERT BANK(Script_RoltWhatCyalWas) == $10, "Script_RoltWhatCyalWas is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b043:
    ld hl, $0738 ; 'Rolt: Urrrgh… 0… Please… Please save'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b044:
    ld hl, $0746 ; 'Rolt: I'm going to get strong'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 ElvenVillageTalkEvents_Cyal", ROMX

; Elven village talk 2, Cyal: 'Are you maybe a ...' at first, message $0707 after Cyal's 'Yay, you',
; Cyal's 'Listen, hero' script after the elder's scene, message $0747 then $0748 after the key boss
; is beaten. (C2, E-0357; probed E-0375)
ElvenVillageTalkEvents_Cyal::
    ld de, EVENT_CYAL_I_HOPE_YOULL_STAY
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, EVENT_KEY_BOSS_BEATEN
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_SCENE_ROLT_ELDER
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld de, EVENT_CYAL_YAY_YOU
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, Script_AreYouMaybeA ; script '*: Are you maybe a human?'
    ASSERT BANK(Script_AreYouMaybeA) == $10, "Script_AreYouMaybeA is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0707 ; 'Cyal: We're going back home now.'
    call StartMessageCommand09HL_B04
    ld de, EVENT_YOURE_AHUMAN_HOW_145
    call SetFlagBit
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_CyalListenHeroWe ; script 'Cyal: Listen, 0. We should go'
    ASSERT BANK(Script_CyalListenHeroWe) == $10, "Script_CyalListenHeroWe is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $0747 ; 'Cyal: I hope you'll stay my'
    call StartMessageCommand09HL_B04
    ld de, EVENT_CYAL_I_HOPE_YOULL_STAY
    call SetFlagBit
    ret

.call_start_message_command09_hl_b043:
    ld hl, $0748 ; 'Cyal: I ought to become a'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0708_HelloMunchkinEnjoyYourStay", ROMX

; Elven village talk 3 (ElvenVillageTalkEvents): picks one message by story flags, tested in this
; order: EVENT_KEY_BOSS_BEATEN set gives $0749 'We owe you a big thanks.'; else
; EVENT_ROLT_WAIT_GONE_ALREADY set gives $0755 'Not only their parents, but Cyal was taken too?';
; else EVENT_CYAL_LISTEN_HERO_WE_SHOULD set gives $0717 'Cyal grew up as an orphan.'; otherwise
; $0708 'Hello, munchkin. Enjoy your stay!'. Each starts through StartMessageCommand09HL_B04 (script
; command $09). (C2, E-0375)
; tests story flags (flag 0151 then jr c,
; TalkMsg0708_HelloMunchkinEnjoyYourStay.call_start_message_command09_hl_b043; flag 014C then jr c,
; TalkMsg0708_HelloMunchkinEnjoyYourStay.call_start_message_command09_hl_b042; flag 0147 then jr c,
; TalkMsg0708_HelloMunchkinEnjoyYourStay.call_start_message_command09_hl_b04); starts message $0708
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'Hello, munchkin.
; Enjoy your stay!' (E-0268, the E-0082 shape; was TalkMsg0708_HelloMunchkinEnjoyYourStay)
TalkMsg0708_HelloMunchkinEnjoyYourStay::
    ld de, EVENT_KEY_BOSS_BEATEN
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, EVENT_ROLT_WAIT_GONE_ALREADY
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_CYAL_LISTEN_HERO_WE_SHOULD
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

SECTION "Bank 04 TalkMsg0709_AHumanHereItsBeenSeveral", ROMX

; Elven village talk 4 (ElvenVillageTalkEvents): picks one message by story flags, tested in this
; order: EVENT_KEY_BOSS_BEATEN set gives $074A 'Thanks to you, we can live in peace, free of fear.';
; else EVENT_CYAL_LISTEN_HERO_WE_SHOULD set gives $0718 'Cyal and Rolt have no family except each
; other.'; otherwise $0709 'A human here?'. Each starts through StartMessageCommand09HL_B04 (script
; command $09). (C2, E-0375)
; tests story flags (flag 0151 then jr c,
; TalkMsg0709_AHumanHereItsBeenSeveral.call_start_message_command09_hl_b042; flag 0147 then jr c,
; TalkMsg0709_AHumanHereItsBeenSeveral.call_start_message_command09_hl_b04); starts message $0709
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'A human here? It's
; been several centuries' (E-0268, the E-0082 shape; was TalkMsg0709_AHumanHereItsBeenSeveral)
TalkMsg0709_AHumanHereItsBeenSeveral::
    ld de, EVENT_KEY_BOSS_BEATEN
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_CYAL_LISTEN_HERO_WE_SHOULD
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

SECTION "Bank 04 TalkMsg070A_YoureNotLikeUsYouScare", ROMX

; Elven village talk 5 (ElvenVillageTalkEvents): starts message $074B 'You look kind and caring.'
; when EVENT_KEY_BOSS_BEATEN is set, otherwise $070A ('... You scare me...'), through
; StartMessageCommand09HL_B04 (script command $09). (C2, E-0375)
; tests story flags (flag 0151 then jr c,
; TalkMsg070A_YoureNotLikeUsYouScare.call_start_message_command09_hl_b04); starts message $070A
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'You're not like us.
; You scare me' (E-0268, the E-0082 shape; was TalkMsg070A_YoureNotLikeUsYouScare)
TalkMsg070A_YoureNotLikeUsYouScare::
    ld de, EVENT_KEY_BOSS_BEATEN
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $070a ; '*: You're not like us. You'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $074b ; '*: You look kind and caring.'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg070B_HeyThereImATalkingHorse", ROMX

; Elven village talk 6 (ElvenVillageTalkEvents), the talking horse: picks one message by story
; flags, tested in this order: EVENT_KEY_BOSS_BEATEN set gives $074C 'Brave human, hear this.'; else
; EVENT_ROLT_WAIT_GONE_ALREADY set gives $072C 'AgDevil is a total terror.'; else
; EVENT_CYAL_LISTEN_HERO_WE_SHOULD set gives $071A ('... They come and raid our village every so
; often.'); otherwise $070B 'Hey there!'. Each starts through StartMessageCommand09HL_B04 (script
; command $09). (C2, E-0375)
; tests story flags (flag 0151 then jr c,
; TalkMsg070B_HeyThereImATalkingHorse.call_start_message_command09_hl_b043; flag 014C then jr c,
; TalkMsg070B_HeyThereImATalkingHorse.call_start_message_command09_hl_b042; flag 0147 then jr c,
; TalkMsg070B_HeyThereImATalkingHorse.call_start_message_command09_hl_b04); starts message $070B
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'Hey there! I'm a
; talking horse. Glad' (E-0268, the E-0082 shape; was TalkMsg070B_HeyThereImATalkingHorse)
TalkMsg070B_HeyThereImATalkingHorse::
    ld de, EVENT_KEY_BOSS_BEATEN
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, EVENT_ROLT_WAIT_GONE_ALREADY
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_CYAL_LISTEN_HERO_WE_SHOULD
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

SECTION "Bank 04 TalkMsg070C_ThisHorseWasHereBeforeUs", ROMX

; Elven village talk 7 (ElvenVillageTalkEvents): starts message $074D 'The talking horse came from
; somewhere outside this world.' when EVENT_KEY_BOSS_BEATEN is set, otherwise $070C 'This horse was
; here before us.', through StartMessageCommand09HL_B04 (script command $09). (C2, E-0375)
; tests story flags (flag 0151 then jr c,
; TalkMsg070C_ThisHorseWasHereBeforeUs.call_start_message_command09_hl_b04); starts message $070C
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'This horse was here
; before us.' (E-0268, the E-0082 shape; was TalkMsg070C_ThisHorseWasHereBeforeUs)
TalkMsg070C_ThisHorseWasHereBeforeUs::
    ld de, EVENT_KEY_BOSS_BEATEN
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $070c ; '*: This horse was here before'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $074d ; '*: The talking horse came from'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg070D_ThisIsElvenVillageYoureA", ROMX

; Elven village talk 8 (ElvenVillageTalkEvents): picks one message by story flags, tested in this
; order: EVENT_KEY_BOSS_BEATEN set gives $074E 'You put down that fiend?'; else
; EVENT_ROLT_WAIT_GONE_ALREADY set gives $072D 'Cyal was taken away by monsters?'; else
; EVENT_CYAL_LISTEN_HERO_WE_SHOULD set gives $071B ('... looking forward to playing with you a
; lot.'); otherwise $070D 'This is Elven village.'. Each starts through StartMessageCommand09HL_B04
; (script command $09). (C2, E-0375)
; tests story flags (flag 0151 then jr c,
; TalkMsg070D_ThisIsElvenVillageYoureA.call_start_message_command09_hl_b043; flag 014C then jr c,
; TalkMsg070D_ThisIsElvenVillageYoureA.call_start_message_command09_hl_b042; flag 0147 then jr c,
; TalkMsg070D_ThisIsElvenVillageYoureA.call_start_message_command09_hl_b04); starts message $070D
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'This is Elven
; village. You're a human,' (E-0268, the E-0082 shape; was TalkMsg070D_ThisIsElvenVillageYoureA)
TalkMsg070D_ThisIsElvenVillageYoureA::
    ld de, EVENT_KEY_BOSS_BEATEN
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, EVENT_ROLT_WAIT_GONE_ALREADY
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_CYAL_LISTEN_HERO_WE_SHOULD
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

SECTION "Bank 04 TalkMsg0752_IveHeardThatHumansAre", ROMX

; Elven village talk 9 (ElvenVillageTalkEvents): picks one message by story flags, tested in this
; order: EVENT_KEY_BOSS_BEATEN set gives $074F ('... a savage but I must thank you as a courtesy.');
; else EVENT_ROLT_WAIT_GONE_ALREADY set gives $072E ('... ask you to protect Cyal?'); else
; EVENT_CYAL_LISTEN_HERO_WE_SHOULD set gives $071C ('... Please watch over Cyal.'); otherwise $0752
; ('... that humans are wild savages.'). Each starts through StartMessageCommand09HL_B04 (script
; command $09). (C2, E-0375)
; tests story flags (flag 0151 then jr c,
; TalkMsg0752_IveHeardThatHumansAre.call_start_message_command09_hl_b043; flag 014C then jr c,
; TalkMsg0752_IveHeardThatHumansAre.call_start_message_command09_hl_b042; flag 0147 then jr c,
; TalkMsg0752_IveHeardThatHumansAre.call_start_message_command09_hl_b04); starts message $0752
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'I've heard that
; humans are wild' (E-0268, the E-0082 shape; was TalkMsg0752_IveHeardThatHumansAre) (E-0324: was
; TalkMsg0752_IveHeardThatHumansAre; read before $42 was known as 'v)
TalkMsg0752_IveHeardThatHumansAre::
    ld de, EVENT_KEY_BOSS_BEATEN
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, EVENT_ROLT_WAIT_GONE_ALREADY
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_CYAL_LISTEN_HERO_WE_SHOULD
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0752 ; '*: I've heard that humans are'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $071c ; '*: Humans can't be trusted, but…'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $072e ; '*: Didn't I ask you to'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b043:
    ld hl, $074f ; '*: You… You're a savage but'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 ElvenVillageTalkEvents_Shop", ROMX

; Elven village talk 10: a shop: screen table $10, 'Welcome, how may I ...'. (C2, E-0357; probed
; E-0375)
ElvenVillageTalkEvents_Shop::
    ld a, $10
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_WelcomeHowMayI_5 ; script '*: Welcome! How may I help'
    ASSERT BANK(Script_WelcomeHowMayI_5) == $10, "Script_WelcomeHowMayI_5 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 ElvenVillageTalkEvents_ShowWellWellItIs", ROMX

; Elven village talk 11: 'Well, well, it is ...' messages and scripts by the village story (the
; elder's scene, Rolt's departure, the key boss beaten), setting its flags on first hearing. (C2,
; E-0357; probed E-0375)
ElvenVillageTalkEvents_ShowWellWellItIs::
    ld de, EVENT_KEY_BOSS_BEATEN
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b044
    ld de, EVENT_WELL_WELL_IT_IS_14D
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, EVENT_ROLT_WAIT_GONE_ALREADY
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_SCENE_ROLT_ELDER
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld de, EVENT_WELL_WELL_IT_IS
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld de, EVENT_YOURE_AHUMAN_HOW_145
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, $070f ; '*: Well, well… It is a'
    call StartMessageCommand09HL_B04
    ld de, EVENT_WELL_WELL_IT_IS
    call SetFlagBit
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_WellWellAHuman ; script '*: Well, well, a human here'
    ASSERT BANK(Script_WellWellAHuman) == $10, "Script_WellWellAHuman is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_test_flag_bit:
    ld de, EVENT_YOURE_AHUMAN_HOW_145
    call TestFlagBit
    jr c, .call_start_script_at_hl_b042
    ld hl, $0753 ; 'I'm the Village Elder. By the'
    call StartMessageCommand09HL_B04
    ret

.call_start_script_at_hl_b042:
    ld hl, Script_I_18 ; script '*: I'm the village's elder. What's'
    ASSERT BANK(Script_I_18) == $10, "Script_I_18 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0714 ; '*: Tamed monsters, have you? That's'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $072a ; '*: AgDevil killed Rolt's parents. Rolt'
    call StartMessageCommand09HL_B04
    ld de, EVENT_WELL_WELL_IT_IS_14D
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

SECTION "Bank 04 ElvenVillageTalkEvents_MasterAgDevil", ROMX

; Elven village talk 12: does nothing until EVENT_CYAL_EEEK_HERO_HELP_ME is set; then starts
; Script_MasterAgDevilAHuman ('Master ..., a human, ruff!', 'What shall we do, ruff?' ...). (C2,
; E-0369; probed E-0375)
; starts Script_MasterAgDevilAHuman: '*: Master AgDevil, a human, ruff!' (E-0248)
ElvenVillageTalkEvents_MasterAgDevil::
    ld de, EVENT_CYAL_EEEK_HERO_HELP_ME
    call TestFlagBit
    ret nc
    ld hl, Script_MasterAgDevilAHuman ; script '*: Master AgDevil, a human, ruff!'
    ASSERT BANK(Script_MasterAgDevilAHuman) == $10, "Script_MasterAgDevilAHuman is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 TalkMsg0723_TchWeHaveToEatThe", ROMX

; Elven village talk 13 (ElvenVillageTalkEvents): starts message $0726 ('... Say your prayers,
; ruff!') when EVENT_THAT is set, otherwise $0723 'Tch, we have to eat the lousy food like we always
; do, ruff!', through StartMessageCommand09HL_B04 (script command $09). (C2, E-0375)
; tests story flags (flag 014A then jr c,
; TalkMsg0723_TchWeHaveToEatThe.call_start_message_command09_hl_b04); starts message $0723 through
; StartMessageCommand09HL_B04 (script command $09); that string begins 'Tch, we have to eat the
; lousy' (E-0268, the E-0082 shape; was TalkMsg0723_TchWeHaveToEatThe)
TalkMsg0723_TchWeHaveToEatThe::
    ld de, EVENT_THAT
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0723 ; '*: Tch, we have to eat'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0726 ; '*: Huh? It's here again, ruff!'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 ElvenVillageTalkEvents_ThatsWhatWellDo", ROMX

; Elven village talk 14: the first time starts Script_That_3 ('That's what we'll do, kid.', setting
; EVENT_THAT), afterwards Script_You_11 ('You've come back again, ruff?'); both run encounter $09,
; then '...Too strong... Arroooh!', SCRIPT_SCENE_TOO_STRONG and set EVENT_SCENE_TOO_STRONG. (C2,
; E-0369; probed E-0375)
; starts Script_That_3: '*: That's what we'll do, kid.' (E-0248)
ElvenVillageTalkEvents_ThatsWhatWellDo::
    ld de, EVENT_THAT
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_That_3 ; script '*: That's what we'll do, kid.'
    ASSERT BANK(Script_That_3) == $10, "Script_That_3 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_You_11 ; script '*: You've come back again, ruff?'
    ASSERT BANK(Script_You_11) == $10, "Script_You_11 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 TalkMsg072F_ThisIsElvensLookoutPostWe", ROMX

; Elven village talk 15 (ElvenVillageTalkEvents), the lookout post: picks one message by story
; flags, tested in this order: EVENT_KEY_BOSS_BEATEN set gives $0750 ('... We stand guard against
; monsters.'); else EVENT_THIS_IS_ELVENS_LOOKOUT_POST set gives $0732 'That AgDevil is from the
; mountains in the north, I think.'; else EVENT_ROLT_WAIT_GONE_ALREADY set gives $0731 'This is the
; lookout post.' and sets EVENT_THIS_IS_ELVENS_LOOKOUT_POST; otherwise $072F ('... We stand guard to
; prevent monsters from attacking the village.'). Each starts through StartMessageCommand09HL_B04
; (script command $09). (C2, E-0375)
; tests story flags (flag 0151 then jr c,
; TalkMsg072F_ThisIsElvensLookoutPostWe.call_start_message_command09_hl_b043; flag 014E then jr c,
; TalkMsg072F_ThisIsElvensLookoutPostWe.call_start_message_command09_hl_b042; flag 014C then jr c,
; TalkMsg072F_ThisIsElvensLookoutPostWe.call_start_message_command09_hl_b04); starts message $072F
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'This is Elven's
; lookout post. We stand' (E-0268, the E-0082 shape; was TalkMsg072F_ThisIsElvensLookoutPostWe)
TalkMsg072F_ThisIsElvensLookoutPostWe::
    ld de, EVENT_KEY_BOSS_BEATEN
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, EVENT_THIS_IS_ELVENS_LOOKOUT_POST
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_ROLT_WAIT_GONE_ALREADY
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $072f ; '*: This is Elven's lookout post.'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0731 ; '*: This is the lookout post.'
    call StartMessageCommand09HL_B04
    ld de, EVENT_THIS_IS_ELVENS_LOOKOUT_POST
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

SECTION "Bank 04 TalkMsg0730_HorridMonstersThatAttack", ROMX

; Elven village talk 16 (ElvenVillageTalkEvents): picks one message by story flags, tested in this
; order: EVENT_KEY_BOSS_BEATEN set gives $0751 'Beating AgDevil...'; else
; EVENT_ROLT_WAIT_GONE_ALREADY set gives $0733 ('... They have no pity, not even for small
; children!'); otherwise $0730 'Horrid monsters that attack elves appear often in these parts.'.
; Each starts through StartMessageCommand09HL_B04 (script command $09). (C2, E-0375)
; tests story flags (flag 0151 then jr c,
; TalkMsg0730_HorridMonstersThatAttack.call_start_message_command09_hl_b042; flag 014C then jr c,
; TalkMsg0730_HorridMonstersThatAttack.call_start_message_command09_hl_b04); starts message $0730
; through StartMessageCommand09HL_B04 (script command $09); that string begins 'Horrid monsters that
; attack elves appear often' (E-0268, the E-0082 shape; was TalkMsg0730_HorridMonstersThatAttack)
TalkMsg0730_HorridMonstersThatAttack::
    ld de, EVENT_KEY_BOSS_BEATEN
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_ROLT_WAIT_GONE_ALREADY
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
    ld hl, $0751 ; '*: Beating AgDevil… That's incredible! But'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 ElvenVillageTalkEvents_KeyBossBattle", ROMX

; Elven village talk 17: the first time starts Script_TheHumanInThe ('The human in the forest ...')
; and sets EVENT_THE_HUMAN_IN_THE_FOREST; afterwards Script_WhatYouAgainRude ('What, you again?
; Rude, rude, ...'). Both run encounter $0B, then SCRIPT_KEY_BOSS_BEATEN and 'Rolt: Wow... <PLAYER>,
; you're tough.' (C2, E-0369; probed E-0375)
; starts Script_TheHumanInThe: '*: The human in the forest' (E-0248)
ElvenVillageTalkEvents_KeyBossBattle::
    ld de, EVENT_THE_HUMAN_IN_THE_FOREST
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_TheHumanInThe ; script '*: The human in the forest'
    ASSERT BANK(Script_TheHumanInThe) == $10, "Script_TheHumanInThe is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ld de, EVENT_THE_HUMAN_IN_THE_FOREST
    call SetFlagBit
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_WhatYouAgainRude ; script '*: What, you again? Rude, rude,'
    ASSERT BANK(Script_WhatYouAgainRude) == $10, "Script_WhatYouAgainRude is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 ElvenVillageTalkEvents_RoltFoundYou", ROMX

; Elven village talk 18: does nothing until EVENT_ROLT_WAIT_GONE_ALREADY is set; then starts
; Script_RoltI ('Rolt: I've found you at last!' ... 'Rolt: Shut up! Give back Cyal!',
; SCRIPT_SCENE_GIVE_BACK_CYAL) and sets EVENT_ROLT_IVE_FOUND_YOU_AT. (C2, E-0369; probed E-0375)
; starts Script_RoltI: 'Rolt: I've found you at last!' (E-0248)
ElvenVillageTalkEvents_RoltFoundYou::
    ld de, EVENT_ROLT_WAIT_GONE_ALREADY
    call TestFlagBit
    ret nc
    ld hl, Script_RoltI ; script 'Rolt: I've found you at last!'
    ASSERT BANK(Script_RoltI) == $10, "Script_RoltI is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ld de, EVENT_ROLT_IVE_FOUND_YOU_AT
    call SetFlagBit
    ret

SECTION "Bank 04 VaseItem_TinyMedal_Flag0153", ROMX

; Elven village talk 19 (ElvenVillageTalkEvents), a one-time vase: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 1 (vase), wScriptParam1 =
; ITEM_TINYMEDAL and story flag $0153 in wMessageIndex/wMessageGroup (wScriptRunning = 1,
; wScriptStep = 0, wModeState = 1). That command gives the item and sets the flag when the flag is
; clear (group-0 message $A3), shows $A4 when the flag is already set and $A5 when the bag is full.
; (C2, E-0375)
; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $2C, story
; flag $0153 in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; VaseItem_TinyMedal_Flag0153)
VaseItem_TinyMedal_Flag0153::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2c
    ld [wScriptParam1], a
    ld de, $0153
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 VaseItem_INTseed", ROMX

; Elven village talk 20 (ElvenVillageTalkEvents), a one-time vase: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 1 (vase), wScriptParam1 =
; ITEM_INTSEED and story flag $0154 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep
; = 0, wModeState = 1). That command gives the item and sets the flag when the flag is clear
; (group-0 message $A3), shows $A4 when the flag is already set and $A5 when the bag is full. (C2,
; E-0375)
; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $10, story
; flag $0154 in DE: when the flag is clear it gives item $10 (INTseed) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; VaseItem_INTseed)
VaseItem_INTseed::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $10
    ld [wScriptParam1], a
    ld de, $0154
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 VaseItem_Potion", ROMX

; Elven village talk 21 (ElvenVillageTalkEvents), a one-time vase: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 1 (vase), wScriptParam1 = ITEM_POTION
; and story flag $0155 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0,
; wModeState = 1). That command gives the item and sets the flag when the flag is clear (group-0
; message $A3), shows $A4 when the flag is already set and $A5 when the bag is full. (C2, E-0375)
; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $04, story
; flag $0155 in DE: when the flag is clear it gives item $04 (Potion) and sets the flag (message $A3
; of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; VaseItem_Potion)
VaseItem_Potion::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $04
    ld [wScriptParam1], a
    ld de, $0155
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 TalkMsg0756_HeroPeeredIntoTheVaseIt", ROMX

; Elven village talk 22 (ElvenVillageTalkEvents): starts message $0756 through
; StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the message word,
; wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1); the hero peers into the vase: 'It was
; filled with Herbs for sale.'. (C2, E-0375)
; starts message $0756 through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 peered into the vase. It was' (E-0268, the E-0082 shape; was
; TalkMsg0756_HeroPeeredIntoTheVaseIt)
TalkMsg0756_HeroPeeredIntoTheVaseIt::
    ld hl, $0756 ; '0 peered into the vase. It'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0758_HeroCheckedTheOvenStewSimmered", ROMX

; Elven village talk 23 (ElvenVillageTalkEvents): starts message $0758 through
; StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the message word,
; wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1); the hero checks the oven: 'Stew
; simmered and bubbled in a pot.'. (C2, E-0375)
; starts message $0758 through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 checked the oven. Stew simmered and' (E-0268, the E-0082 shape; was
; TalkMsg0758_HeroCheckedTheOvenStewSimmered)
TalkMsg0758_HeroCheckedTheOvenStewSimmered::
    ld hl, $0758 ; '0 checked the oven. Stew simmered'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 ChestItem_WorldDew_Flag0156", ROMX

; Elven village talk 24 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_WORLDDEW and story flag $0156 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep
; = 0, wModeState = 1). That command gives the item and sets the flag when the flag is clear
; (group-0 message $A0), shows $A1 when the flag is already set and $A2 when the bag is full. (C2,
; E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $03, story flag $0156 in DE: when the flag is clear it gives item $03 (WorldDew) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_WorldDew_Flag0156)
ChestItem_WorldDew_Flag0156::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $03
    ld [wScriptParam1], a
    ld de, $0156
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_ExitBell_Flag0157", ROMX

; Elven village talk 25 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_EXITBELL and story flag $0157 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep
; = 0, wModeState = 1). That command gives the item and sets the flag when the flag is clear
; (group-0 message $A0), shows $A1 when the flag is already set and $A2 when the bag is full. (C2,
; E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $2A, story flag $0157 in DE: when the flag is clear it gives item $2A (ExitBell) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_ExitBell_Flag0157)
ChestItem_ExitBell_Flag0157::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2a
    ld [wScriptParam1], a
    ld de, $0157
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_MysticNut", ROMX

; Elven village talk 26 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_MYSTICNUT and story flag $0158 in wMessageIndex/wMessageGroup (wScriptRunning = 1,
; wScriptStep = 0, wModeState = 1). That command gives the item and sets the flag when the flag is
; clear (group-0 message $A0), shows $A1 when the flag is already set and $A2 when the bag is full.
; (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $12, story flag $0158 in DE: when the flag is clear it gives item $12 (MysticNut) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was ChestItem_MysticNut)
ChestItem_MysticNut::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $12
    ld [wScriptParam1], a
    ld de, $0158
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 TalkMsg0757_HeroCheckedTheOvenASharp", ROMX

; Elven village talk 27 (ElvenVillageTalkEvents): starts message $0757 through
; StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the message word,
; wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1); the hero checks the oven: 'A sharp
; aroma of medicine wafted...'. (C2, E-0375)
; starts message $0757 through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 checked the oven. A sharp aroma' (E-0268, the E-0082 shape; was
; TalkMsg0757_HeroCheckedTheOvenASharp)
TalkMsg0757_HeroCheckedTheOvenASharp::
    ld hl, $0757 ; '0 checked the oven. A sharp'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 Talk075F_KiralFetchMeMy", ROMX

; Kiral: before anything 'Hoh? Ah, excuse my incivility.'; then by progress 'I need help with
; my...', 'Fetch me my treasure from...' ($075F), the 'Ah! Back! The treasure? What?' script,
; 'Please... Go stop him...' ($0778); after the barrel scene, with the WizStone in the bag, swaps it
; for a SmartBook ($17, asking for a bag sort), runs 'Ah! Back! Is... Rob-N...' and marks key kind 8
; used, else the same text as a message ($077D); after the WizStone scene 'You've been a great
; help.' once (EVENT_KIRAL_FETCH_ME_MY_166), then 'Visit me when you're free.'; after
; EVENT_KIRAL_FETCH_ME_MY_167 'Hohoh! I've got good news!' once (_168), then 'Roboster2's skills are
; simply exceptional...'. (C2, E-0357; probed E-0375)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 7
; constant message(s) depending on story flags and state; the first one in the code is $075F, whose
; string begins 'Kiral Fetch me my treasure from' (E-0097)
Talk075F_KiralFetchMeMy::
    ld de, EVENT_KIRAL_FETCH_ME_MY_167
    call TestFlagBit
    jp c, .call_test_flag_bit2
    ld de, EVENT_SCENE_WIZSTONE
    call TestFlagBit
    jp c, .call_test_flag_bit
    ld de, EVENT_SCENE_BARREL
    call TestFlagBit
    jr c, .set_temp0_to_3C
    ld de, EVENT_KIRAL_PLEASE_GO_STOP_HIM
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_KIRAL_FETCH_ME_MY
    call TestFlagBit
    jr c, .call_start_script_at_hl_b042
    ld de, EVENT_KIRAL_OH_FOOLISH_OF_ME
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld de, EVENT_KIRAL_NO_HOW_DISAPPOINTING_YOUR
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_HohAhExcuseMy ; script '*: Hoh? Ah, excuse my incivility.'
    ASSERT BANK(Script_HohAhExcuseMy) == $10, "Script_HohAhExcuseMy is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_KiralINeedHelp ; script 'Kiral: I need help with my'
    ASSERT BANK(Script_KiralINeedHelp) == $10, "Script_KiralINeedHelp is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $075f ; 'Kiral: Fetch me my treasure from'
    call StartMessageCommand09HL_B04
    ret

.call_start_script_at_hl_b042:
    ld hl, Script_KiralAhBackThe ; script 'Kiral: Ah! Back! The treasure? What?'
    ASSERT BANK(Script_KiralAhBackThe) == $10, "Script_KiralAhBackThe is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $0778 ; 'Kiral: Please… Go stop him. You'
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
    ld a, [wInventorySortFlags]
    set 6, a
    ld [wInventorySortFlags], a
    ld hl, Script_KiralAhBackIs ; script 'Kiral: Ah! Back! Is… Rob-N… Did'
    ASSERT BANK(Script_KiralAhBackIs) == $10, "Script_KiralAhBackIs is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ld a, $08
    ldh [hTemp0], a
    farcall MarkKeyEntryKindTemp0Bit6
    ret

.call_start_message_command09_hl_b043:
    ld hl, $077d ; 'Kiral: Ah! Back! Is… Rob-N… Did'
    call StartMessageCommand09HL_B04
    ret

.call_test_flag_bit:
    ld de, EVENT_KIRAL_FETCH_ME_MY_166
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b044
    ld hl, $0786 ; 'Kiral: You've been a great help.'
    call StartMessageCommand09HL_B04
    ld de, EVENT_KIRAL_FETCH_ME_MY_166
    call SetFlagBit
    ret

.call_start_message_command09_hl_b044:
    ld hl, $0787 ; 'Kiral: Visit me when you're free.'
    call StartMessageCommand09HL_B04
    ret

.call_test_flag_bit2:
    ld de, EVENT_KIRAL_FETCH_ME_MY_168
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b045
    ld hl, $0789 ; 'Kiral: Hohoh! I've got good news!'
    call StartMessageCommand09HL_B04
    ld de, EVENT_KIRAL_FETCH_ME_MY_168
    call SetFlagBit
    ret

.call_start_message_command09_hl_b045:
    ld hl, $078a ; 'Kiral: Roboster2's skills are simply exceptional.'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 Talk075A_PiiGgzzPiiiiii", ROMX

; The robot: 'Pii... Ggzz... Piiiiii...' ($075A, clearing object 1's state) at first; after the
; WizStone scene 'I AM THE LATEST ROBOSTER.' ($0788); after EVENT_KIRAL_FETCH_ME_MY_167 'MY NAME IS
; LEO...' ($078B). (C2, E-0357; probed E-0375)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 3
; constant message(s) depending on story flags and state; the first one in the code is $075A, whose
; string begins 'Pii Ggzz Piiiiii' (E-0097)
Talk075A_PiiGgzzPiiiiii::
    ld de, EVENT_KIRAL_FETCH_ME_MY_167
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_SCENE_WIZSTONE
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    xor a
    ld [wObject1 + OBJ_STATE], a
    ld hl, $075a ; '*: Pii… Ggzz… Piiiiii…'
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

SECTION "Bank 04 TalkMsg0760_HeroCheckedTheBookshelfA", ROMX

; Elven village talk 34 (ElvenVillageTalkEvents): starts message $0760 through
; StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the message word,
; wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1); the hero checks the bookshelf: 'A
; recent diary was found.'. (C2, E-0375)
; starts message $0760 through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 checked the bookshelf. A recent diary' (E-0268, the E-0082 shape; was
; TalkMsg0760_HeroCheckedTheBookshelfA)
TalkMsg0760_HeroCheckedTheBookshelfA::
    ld hl, $0760 ; '0 checked the bookshelf. A recent'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0761_HeroCheckedTheBookshelfA", ROMX

; Elven village talk 35 (ElvenVillageTalkEvents): starts message $0761 through
; StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the message word,
; wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1); the hero checks the bookshelf: 'A
; very old diary was found.'. (C2, E-0375)
; starts message $0761 through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 checked the bookshelf. A very old' (E-0268, the E-0082 shape; was
; TalkMsg0761_HeroCheckedTheBookshelfA)
TalkMsg0761_HeroCheckedTheBookshelfA::
    ld hl, $0761 ; '0 checked the bookshelf. A very'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 VaseItem_TinyMedal_Flag015B", ROMX

; Elven village talk 36 (ElvenVillageTalkEvents), a one-time vase: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 1 (vase), wScriptParam1 =
; ITEM_TINYMEDAL and story flag $015B in wMessageIndex/wMessageGroup (wScriptRunning = 1,
; wScriptStep = 0, wModeState = 1). That command gives the item and sets the flag when the flag is
; clear (group-0 message $A3), shows $A4 when the flag is already set and $A5 when the bag is full.
; (C2, E-0375)
; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $2C, story
; flag $015B in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; VaseItem_TinyMedal_Flag015B)
VaseItem_TinyMedal_Flag015B::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2c
    ld [wScriptParam1], a
    ld de, $015b
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 TalkMsg0762_HeroPeeredIntoTheVaseRolled", ROMX

; Elven village talk 37 (ElvenVillageTalkEvents): starts message $0762 through
; StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the message word,
; wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1); the hero peers into the vase: 'Rolled
; blueprints were in a bundle.'. (C2, E-0375)
; starts message $0762 through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 peered into the vase. Rolled blueprints' (E-0268, the E-0082 shape; was
; TalkMsg0762_HeroPeeredIntoTheVaseRolled)
TalkMsg0762_HeroPeeredIntoTheVaseRolled::
    ld hl, $0762 ; '0 peered into the vase. Rolled'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0763_HeroPeeredIntoTheBarrelIt", ROMX

; Elven village talk 38 (ElvenVillageTalkEvents): starts message $0763 through
; StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the message word,
; wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1); the hero peers into the barrel: 'It
; faintly smelled of mold...'. (C2, E-0375)
; starts message $0763 through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 peered into the barrel. It faintly' (E-0268, the E-0082 shape; was
; TalkMsg0763_HeroPeeredIntoTheBarrelIt)
TalkMsg0763_HeroPeeredIntoTheBarrelIt::
    ld hl, $0763 ; '0 peered into the barrel. It'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0764_HeroPeeredIntoTheBarrelThere", ROMX

; Elven village talk 39 (ElvenVillageTalkEvents): starts message $0764 through
; StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the message word,
; wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1); the hero peers into the barrel:
; 'There were things squirming inside.'. (C2, E-0375)
; starts message $0764 through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 peered into the barrel. There were' (E-0268, the E-0082 shape; was
; TalkMsg0764_HeroPeeredIntoTheBarrelThere)
TalkMsg0764_HeroPeeredIntoTheBarrelThere::
    ld hl, $0764 ; '0 peered into the barrel. There'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0765_HeroPeeredIntoTheBarrelThere", ROMX

; Elven village talk 40 (ElvenVillageTalkEvents): starts message $0765 through
; StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the message word,
; wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1); the hero peers into the barrel:
; 'There was a note at the bottom.'. (C2, E-0375)
; starts message $0765 through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 peered into the barrel. There was' (E-0268, the E-0082 shape; was
; TalkMsg0765_HeroPeeredIntoTheBarrelThere)
TalkMsg0765_HeroPeeredIntoTheBarrelThere::
    ld hl, $0765 ; '0 peered into the barrel. There'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 BarrelItem_WorldDew", ROMX

; Elven village talk 41 (ElvenVillageTalkEvents), a one-time barrel: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 2 (barrel), wScriptParam1 =
; ITEM_WORLDDEW and story flag $015C in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep
; = 0, wModeState = 1). That command gives the item and sets the flag when the flag is clear
; (group-0 message $A6), shows $A7 when the flag is already set and $A8 when the bag is full. (C2,
; E-0375)
; a one-time barrel: script command $0A with wScriptParam0 = 2 (kind) and wScriptParam1 = $03, story
; flag $015C in DE: when the flag is clear it gives item $03 (WorldDew) and sets the flag (message
; $A6 of group 0; $A7 when the flag is already set, $A8 when there is no room) (E-0269; was
; BarrelItem_WorldDew)
BarrelItem_WorldDew::
    ld a, $02
    ld [wScriptParam0], a
    ld a, $03
    ld [wScriptParam1], a
    ld de, $015c
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 TalkMsg0766_HeroPeeredIntoTheBarrelA", ROMX

; Elven village talk 42 (ElvenVillageTalkEvents): starts message $0766 through
; StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the message word,
; wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1); the hero peers into the barrel: 'A
; quite old diary was found.'. (C2, E-0375)
; starts message $0766 through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 peered into the barrel. A quite' (E-0268, the E-0082 shape; was
; TalkMsg0766_HeroPeeredIntoTheBarrelA)
TalkMsg0766_HeroPeeredIntoTheBarrelA::
    ld hl, $0766 ; '0 peered into the barrel. A'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 Talk0768_HeroPeeredIntoThe", ROMX

; A barrel: its 'peered into the barrel. A...' script until EVENT_HERO_PEERED_INTO_THE_BARREL, then
; '0 peered into the barrel. There...' ($0768). (C2, E-0357; probed E-0375)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1
; constant message(s) depending on story flags and state; the first one in the code is $0768, whose
; string begins '0 peered into the barrel. There' (E-0097)
; starts Script_HeroPeeredIntoThe_2: '0 peered into the barrel. A' (E-0248)
Talk0768_HeroPeeredIntoThe::
    ld de, EVENT_HERO_PEERED_INTO_THE_BARREL
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, Script_HeroPeeredIntoThe_2 ; script '0 peered into the barrel. A'
    ASSERT BANK(Script_HeroPeeredIntoThe_2) == $10, "Script_HeroPeeredIntoThe_2 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0768 ; '0 peered into the barrel. There'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 Talk0768_HeroPeeredIntoThe_2", ROMX

; Another barrel: as Talk0768_HeroPeeredIntoThe with EVENT_HERO_PEERED_INTO_THE_BARREL_15E and
; Script_HeroPeeredIntoThe_3. (C2, E-0357; probed E-0375)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1
; constant message(s) depending on story flags and state; the first one in the code is $0768, whose
; string begins '0 peered into the barrel. There' (E-0097) (E-0344: the address in its name dropped
; or read as the label there; was Talk0768_HeroPeeredIntoThe_2)
; starts Script_HeroPeeredIntoThe_3: '0 peered into the barrel. A' (E-0248)
Talk0768_HeroPeeredIntoThe_2::
    ld de, EVENT_HERO_PEERED_INTO_THE_BARREL_15E
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, Script_HeroPeeredIntoThe_3 ; script '0 peered into the barrel. A'
    ASSERT BANK(Script_HeroPeeredIntoThe_3) == $10, "Script_HeroPeeredIntoThe_3 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0768 ; '0 peered into the barrel. There'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 Talk078E_RobosterStoppedMovingEntirely", ROMX

; Rob-N the guard robot: by progress 'PROFESSOR... SAY GUARD... TREASURE... NEVER...', 'PRO...
; SOR... AY... GGGGUARD...' (after EVENT_KIRAL_FETCH_ME_MY), 'PIPIPI... GGGGGGAGAGAGA...' and 'PI...
; PI...' scripts; after the barrel scene 'Roboster stopped moving entirely...' ($078E); after
; EVENT_KIRAL_FETCH_ME_MY_167 'WELCOME. I AM ROB-N...' ($078C). (C2, E-0357; probed E-0375)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 2
; constant message(s) depending on story flags and state; the first one in the code is $078E, whose
; string begins 'Roboster stopped moving entirely' (E-0097)
Talk078E_RobosterStoppedMovingEntirely::
    ld de, EVENT_KIRAL_FETCH_ME_MY_167
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_SCENE_BARREL
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld de, EVENT_ROBOSTER_STOPPED_MOVING_ENTIRELY_161
    call TestFlagBit
    jr c, .call_start_script_at_hl_b043
    ld de, EVENT_ROBOSTER_STOPPED_MOVING_ENTIRELY
    call TestFlagBit
    jr c, .call_start_script_at_hl_b042
    ld de, EVENT_KIRAL_FETCH_ME_MY
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_PROFESSORSAYGUARDTREASURE ; script '*: PROFESSOR… SAY GUARD… TREASURE… NEVER…'
    ASSERT BANK(Script_PROFESSORSAYGUARDTREASURE) == $10, "Script_PROFESSORSAYGUARDTREASURE is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_PROSORAYGGGGUARD ; script '*: PRO… SOR… AY… GGGGUARD… TREZZZT…'
    ASSERT BANK(Script_PROSORAYGGGGUARD) == $10, "Script_PROSORAYGGGGUARD is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b042:
    ld hl, Script_PIPIPIGGGGGGAGAGAGA ; script '*: PIPIPI… GGGGGGAGAGAGA…'
    ASSERT BANK(Script_PIPIPIGGGGGGAGAGAGA) == $10, "Script_PIPIPIGGGGGGAGAGAGA is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b043:
    ld hl, Script_PIPI ; script '*: PI… PI…'
    ASSERT BANK(Script_PIPI) == $10, "Script_PIPI is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $078e ; 'Roboster stopped moving entirely…'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $078c ; '*: WELCOME. I AM ROB-N. I'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 Talk077B_HeroPeeredIntoThe", ROMX

; The WizStone barrel: before the barrel scene its script; after it, with room in the bag, adds the
; WizStone ($3C, asking for a bag sort) with '...There...' ($077A) and sets
; EVENT_HERO_PEERED_INTO_THE, else $077B; once taken, $077C. (C2, E-0357; probed E-0375)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 3
; constant message(s) depending on story flags and state; the first one in the code is $077B, whose
; string begins '0 peered into the barrel. There' (E-0097)
Talk077B_HeroPeeredIntoThe::
    ld de, EVENT_HERO_PEERED_INTO_THE
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld de, EVENT_SCENE_BARREL
    call TestFlagBit
    jr c, .call_inventory_has_free_slot_check
    ld hl, Script_HeroPeeredIntoThe_4 ; script '0 peered into the barrel. There'
    ASSERT BANK(Script_HeroPeeredIntoThe_4) == $10, "Script_HeroPeeredIntoThe_4 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_inventory_has_free_slot_check:
    call InventoryHasFreeSlotCheck
    jr c, .read_inventory_sort_flags
    ld hl, $077b ; '0 peered into the barrel. There'
    call StartMessageCommand09HL_B04
    ret

.read_inventory_sort_flags:
    ld [hl], $3c
    ld a, [wInventorySortFlags]
    set 6, a
    ld [wInventorySortFlags], a
    ld hl, $077a ; '0 peered into the barrel. There'
    call StartMessageCommand09HL_B04
    ld de, EVENT_HERO_PEERED_INTO_THE
    call SetFlagBit
    ret

.call_start_message_command09_hl_b04:
    ld hl, $077c ; '0 peered into the barrel. There'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg07B7_TheTowersEntryIsSealedTight", ROMX

; Elven village talk 47 (ElvenVillageTalkEvents): starts message $07B7 through
; StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the message word,
; wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1); the message reads '... entry is
; sealed tight.'. (C2, E-0375)
; starts message $07B7 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'The tower's entry is sealed tight.' (E-0268, the E-0082 shape; was
; TalkMsg07B7_TheTowersEntryIsSealedTight)
TalkMsg07B7_TheTowersEntryIsSealedTight::
    ld hl, $07b7 ; 'The tower's entry is sealed tight.'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg078F_ThisIsTheTown", ROMX

; Elven village talk 48 (ElvenVillageTalkEvents): starts message $0CE2 'Welcome to the town of
; Miagen.' when EVENT_KEY_BOSS_BEATEN_2 is set, otherwise $078F 'This is the town of Miagen.',
; through StartMessageCommand09HL_B04 (script command $09). (C2, E-0375)
; tests story flags in turn (flag $01C3 set: jr to
; TalkMsg078F_ThisIsTheTown.call_start_message_command09_hl_b04); when none of them branches, starts
; message $078F through StartMessageCommand09HL_B04 (script command $09); that string begins 'This
; is the town of Miagen.' (E-0082)
TalkMsg078F_ThisIsTheTown::
    ld de, EVENT_KEY_BOSS_BEATEN_2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $078f ; '*: This is the town of'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0ce2 ; '*: Welcome to the town of'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0790_AreYouFriendsWith", ROMX

; Elven village talk 49 (ElvenVillageTalkEvents): picks one message by story flags, tested in this
; order: EVENT_KEY_BOSS_BEATEN_2 set gives $0CE3 'So you defeated the evildoer?'; else
; EVENT_HERO_OPENED_THE_TREASURE_CHEST set gives $07C6 ('... The little monster master?'); otherwise
; $0790 'Are you friends with monsters?'. Each starts through StartMessageCommand09HL_B04 (script
; command $09). (C2, E-0375)
; tests story flags in turn (flag $01C3 set: jr to
; TalkMsg0790_AreYouFriendsWith.call_start_message_command09_hl_b042; flag $01BC set: jr to
; TalkMsg0790_AreYouFriendsWith.call_start_message_command09_hl_b04); when none of them branches,
; starts message $0790 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'Are you friends with monsters? You're' (E-0082)
TalkMsg0790_AreYouFriendsWith::
    ld de, EVENT_KEY_BOSS_BEATEN_2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_HERO_OPENED_THE_TREASURE_CHEST
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

SECTION "Bank 04 TalkMsg0791_WowYouHaveMonsters", ROMX

; Elven village talk 50 (ElvenVillageTalkEvents): starts message $0CE4 'Wow, you have monsters!
; Wicked!' when EVENT_KEY_BOSS_BEATEN_2 is set, otherwise $0791 'Wow! You have monsters! Neat!',
; through StartMessageCommand09HL_B04 (script command $09). (C2, E-0375)
; tests story flags in turn (flag $01C3 set: jr to
; TalkMsg0791_WowYouHaveMonsters.call_start_message_command09_hl_b04); when none of them branches,
; starts message $0791 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'Wow! You have monsters! Neat! Are' (E-0082)
TalkMsg0791_WowYouHaveMonsters::
    ld de, EVENT_KEY_BOSS_BEATEN_2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0791 ; '*: Wow! You have monsters! Neat!'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0ce4 ; '*: Wow, you have monsters! Wicked!'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0792_AreYourMonstersGood", ROMX

; Elven village talk 51 (ElvenVillageTalkEvents): starts message $0CE5 ('... I like them!') when
; EVENT_KEY_BOSS_BEATEN_2 is set, otherwise $0792 'Are your monsters good?', through
; StartMessageCommand09HL_B04 (script command $09). (C2, E-0375)
; tests story flags in turn (flag $01C3 set: jr to
; TalkMsg0792_AreYourMonstersGood.call_start_message_command09_hl_b04); when none of them branches,
; starts message $0792 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'Are your monsters good? I don't' (E-0082)
TalkMsg0792_AreYourMonstersGood::
    ld de, EVENT_KEY_BOSS_BEATEN_2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0792 ; '*: Are your monsters good? I'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0ce5 ; '*: Your monsters are good, it's'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0793_MonstersCanBeGood", ROMX

; Elven village talk 52 (ElvenVillageTalkEvents): picks one message by story flags, tested in this
; order: EVENT_KEY_BOSS_BEATEN_2 set gives $0CE6 'So there are evil masters...'; else
; EVENT_HERO_OPENED_THE_TREASURE_CHEST set gives $07C7 'If a monster could be good or bad, does that
; mean there are both good masters and bad ones?'; otherwise $0793 'Monsters can be good or bad.'.
; Each starts through StartMessageCommand09HL_B04 (script command $09). (C2, E-0375)
; tests story flags in turn (flag $01C3 set: jr to
; TalkMsg0793_MonstersCanBeGood.call_start_message_command09_hl_b042; flag $01BC set: jr to
; TalkMsg0793_MonstersCanBeGood.call_start_message_command09_hl_b04); when none of them branches,
; starts message $0793 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'Monsters can be good or bad.' (E-0082)
TalkMsg0793_MonstersCanBeGood::
    ld de, EVENT_KEY_BOSS_BEATEN_2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_HERO_OPENED_THE_TREASURE_CHEST
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
    ld hl, $0ce6 ; '*: So there are evil masters…'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0794_YouAppearToHave", ROMX

; Elven village talk 53 (ElvenVillageTalkEvents): starts message $0CE7 'Controlling monsters is no
; easy feat, is it?' when EVENT_KEY_BOSS_BEATEN_2 is set, otherwise $0794 'You appear to have the
; power to control monsters.', through StartMessageCommand09HL_B04 (script command $09). (C2,
; E-0375)
; tests story flags in turn (flag $01C3 set: jr to
; TalkMsg0794_YouAppearToHave.call_start_message_command09_hl_b04); when none of them branches,
; starts message $0794 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'You appear to have the power' (E-0082)
TalkMsg0794_YouAppearToHave::
    ld de, EVENT_KEY_BOSS_BEATEN_2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0794 ; '*: You appear to have the'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0ce7 ; '*: Controlling monsters is no easy'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 Talk07A4_CouldYouHumorThis", ROMX

; The old man: after the second key boss 'I thank you in all...' ($0CE8); after
; EVENT_THANK_YOU_FOR_GETTING_THE 'Things haven't been good for...' ($07CE); after the treasure
; chest was opened, takes the Pretty ring from the bag for the '0 showed the Pretty Ring.' script
; (without it, 'My daughter wedded a man...'); after EVENT_THANK_YOU_I_KNEW_YOU 'Could you humor
; this old...' once (EVENT_COULD_YOU_HUMOR_THIS), then 'My daughter wedded a man...' ($07A5); at
; first the 'Sigh...' script. (C2, E-0357; probed E-0375)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 4
; constant message(s) depending on story flags and state; the first one in the code is $07A4, whose
; string begins 'Could you humor this old man' (E-0097)
Talk07A4_CouldYouHumorThis::
    ld de, EVENT_KEY_BOSS_BEATEN_2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_THANK_YOU_FOR_GETTING_THE
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld de, EVENT_HERO_OPENED_THE_TREASURE_CHEST
    call TestFlagBit
    jr c, .set_temp0_to_3D
    ld de, EVENT_THANK_YOU_I_KNEW_YOU
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld hl, Script_Sigh ; script '*: Sigh…'
    ASSERT BANK(Script_Sigh) == $10, "Script_Sigh is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_test_flag_bit:
    ld de, EVENT_COULD_YOU_HUMOR_THIS
    call TestFlagBit
    jr c, .loop
    ld hl, $07a4 ; '*: Could you humor this old'
    call StartMessageCommand09HL_B04
    ld de, EVENT_COULD_YOU_HUMOR_THIS
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
    ld hl, Script_HeroShowedThePretty ; script '0 showed the Pretty Ring.'
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

SECTION "Bank 04 Talk07A6_OurDaughtersOnlyMemento", ROMX

; The old woman: after the second key boss 'The atmosphere has cheered up,...' ($0CE9); after
; EVENT_HERO_RECEIVED_A_SAGE_ROCK 'We are grateful that you...' ($07D3); after
; EVENT_THANK_YOU_FOR_GETTING_THE the 'Thank you for recovering our...' script, the version that
; adds item $0B to the bag (asking for a bag sort) when there is room; after
; EVENT_THANK_YOU_I_KNEW_YOU 'Our daughter's only memento was...' ($07A6); at first the 'Sigh...'
; script. (C2, E-0357; probed E-0375)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 3
; constant message(s) depending on story flags and state; the first one in the code is $07A6, whose
; string begins 'Our daughter's only memento was taken' (E-0097)
Talk07A6_OurDaughtersOnlyMemento::
    ld de, EVENT_KEY_BOSS_BEATEN_2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, EVENT_HERO_RECEIVED_A_SAGE_ROCK
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_THANK_YOU_FOR_GETTING_THE
    call TestFlagBit
    jr c, .call_inventory_has_free_slot_check
    ld de, EVENT_THANK_YOU_I_KNEW_YOU
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, Script_Sigh_2 ; script '*: Sigh…'
    ASSERT BANK(Script_Sigh_2) == $10, "Script_Sigh_2 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $07a6 ; '*: Our daughter's only memento was'
    call StartMessageCommand09HL_B04
    ret

.call_inventory_has_free_slot_check:
    call InventoryHasFreeSlotCheck
    jr c, .read_inventory_sort_flags
    ld hl, Script_ThankYouForRecovering ; script '*: Thank you for recovering our'
    ASSERT BANK(Script_ThankYouForRecovering) == $10, "Script_ThankYouForRecovering is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.read_inventory_sort_flags:
    ld [hl], $0b
    ld a, [wInventorySortFlags]
    set 6, a
    ld [wInventorySortFlags], a
    ld hl, Script_ThankYouForRecovering_2 ; script '*: Thank you for recovering our'
    ASSERT BANK(Script_ThankYouForRecovering_2) == $10, "Script_ThankYouForRecovering_2 is read with bank $10 mapped"
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

SECTION "Bank 04 TalkMsg0799_MonstersRaidedThisHouse", ROMX

; Elven village talk 56 (ElvenVillageTalkEvents): picks one message by story flags, tested in this
; order: EVENT_KEY_BOSS_BEATEN_2 set gives $0CEA 'I long to have a family of my own.'; else
; EVENT_THANK_YOU_FOR_GETTING_THE set gives $07D4 'The old couple look happy after they got their
; treasure back.'; else EVENT_THANK_YOU_I_KNEW_YOU set gives $07A7 ('... You ought to pay a visit to
; the hut by the spring in the west.'); otherwise $0799 'Monsters raided this house within the last
; while.'. Each starts through StartMessageCommand09HL_B04 (script command $09). (C2, E-0375)
; tests story flags in turn (flag $01C3 set: jr to
; TalkMsg0799_MonstersRaidedThisHouse.call_start_message_command09_hl_b043; flag $01BE set: jr to
; TalkMsg0799_MonstersRaidedThisHouse.call_start_message_command09_hl_b042; flag $01B1 set: jr to
; TalkMsg0799_MonstersRaidedThisHouse.call_start_message_command09_hl_b04); when none of them
; branches, starts message $0799 through StartMessageCommand09HL_B04 (script command $09); that
; string begins 'Monsters raided this house within the' (E-0082)
TalkMsg0799_MonstersRaidedThisHouse::
    ld de, EVENT_KEY_BOSS_BEATEN_2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, EVENT_THANK_YOU_FOR_GETTING_THE
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_THANK_YOU_I_KNEW_YOU
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

SECTION "Bank 04 TalkMsg079A_TheOldPeopleAcross", ROMX

; Elven village talk 57 (ElvenVillageTalkEvents): picks one message by story flags, tested in this
; order: EVENT_KEY_BOSS_BEATEN_2 set gives $0CEB 'Old people say that a cheerful town is a good
; town.'; else EVENT_THANK_YOU_FOR_GETTING_THE set gives $07D5 ('... so glad the people across the
; way got back their stolen treasure.'); else EVENT_THANK_YOU_I_KNEW_YOU set gives $07A8 'The old
; couple across the way were robbed of a precious item.'; otherwise $079A 'The old people across the
; way look very sad recently.'. Each starts through StartMessageCommand09HL_B04 (script command
; $09). (C2, E-0375)
; tests story flags in turn (flag $01C3 set: jr to
; TalkMsg079A_TheOldPeopleAcross.call_start_message_command09_hl_b043; flag $01BE set: jr to
; TalkMsg079A_TheOldPeopleAcross.call_start_message_command09_hl_b042; flag $01B1 set: jr to
; TalkMsg079A_TheOldPeopleAcross.call_start_message_command09_hl_b04); when none of them branches,
; starts message $079A through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'The old people across the way' (E-0082)
TalkMsg079A_TheOldPeopleAcross::
    ld de, EVENT_KEY_BOSS_BEATEN_2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, EVENT_THANK_YOU_FOR_GETTING_THE
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_THANK_YOU_I_KNEW_YOU
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

SECTION "Bank 04 TalkMsg079B_MonstersHaveTakenTo", ROMX

; Elven village talk 58 (ElvenVillageTalkEvents): picks one message by story flags, tested in this
; order: EVENT_KEY_BOSS_BEATEN_2 set gives $0CEC 'Monsters can be good or evil on the whims of their
; masters, I guess.'; else EVENT_HERO_OPENED_THE_TREASURE_CHEST set gives $07C8 ('... I can
; understand if they went for food, but...'); otherwise $079B 'Monsters have taken to attacking the
; town recently.'. Each starts through StartMessageCommand09HL_B04 (script command $09). (C2,
; E-0375)
; tests story flags in turn (flag $01C3 set: jr to
; TalkMsg079B_MonstersHaveTakenTo.call_start_message_command09_hl_b042; flag $01BC set: jr to
; TalkMsg079B_MonstersHaveTakenTo.call_start_message_command09_hl_b04); when none of them branches,
; starts message $079B through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'Monsters have taken to attacking the' (E-0082)
TalkMsg079B_MonstersHaveTakenTo::
    ld de, EVENT_KEY_BOSS_BEATEN_2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_HERO_OPENED_THE_TREASURE_CHEST
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

SECTION "Bank 04 TalkMsg079C_GrrrrImSoAngry", ROMX

; Elven village talk 59 (ElvenVillageTalkEvents): picks one message by story flags, tested in this
; order: EVENT_KEY_BOSS_BEATEN_2 set gives $0CED 'The thief was selling what he stole from us for a
; lot of gold.'; else EVENT_HERO_OPENED_THE_TREASURE_CHEST set gives $07C9 ('... This is so
; infuriating!'); otherwise $079C ('... Monsters stole my lingerie!'). Each starts through
; StartMessageCommand09HL_B04 (script command $09). (C2, E-0375)
; tests story flags in turn (flag $01C3 set: jr to
; TalkMsg079C_GrrrrImSoAngry.call_start_message_command09_hl_b042; flag $01BC set: jr to
; TalkMsg079C_GrrrrImSoAngry.call_start_message_command09_hl_b04); when none of them branches,
; starts message $079C through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'Grrrr! I'm so angry! Monsters stole' (E-0082)
TalkMsg079C_GrrrrImSoAngry::
    ld de, EVENT_KEY_BOSS_BEATEN_2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_HERO_OPENED_THE_TREASURE_CHEST
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

SECTION "Bank 04 ElvenVillageTalkEvents_ShopHelloWhatMayI", ROMX

; Elven village talk 60 (ElvenVillageTalkEvents): a shop, like ElvenVillageTalkEvents_Shop with
; screen table $11: sets wScreenTableIndex = $11 and wDataBank = $10, then starts
; Script_HelloWhatMayI_2 through StartScriptAtHL_B04 (wScriptPointerLo/Hi = the script,
; wScriptStartRequest = $80, wModeState = 1); that script shows 'Hello! What may I do ...' and jumps
; to Script_Shop_5 (SCRIPT_SHOP). (C2, E-0375)
; wScreenTableIndex = $11, wDataBank = $10, then StartScriptAtHL_B04 with HL =
; Script_HelloWhatMayI_2 (E-0119) (E-0344: the address in its name dropped or read as the label
; there; was ElvenVillageTalkEvents_ShopHelloWhatMayI)
ElvenVillageTalkEvents_ShopHelloWhatMayI::
    ld a, $11
    ld [wScreenTableIndex], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_HelloWhatMayI_2 ; script '*: Hello! What may I do'
    ASSERT BANK(Script_HelloWhatMayI_2) == $10, "Script_HelloWhatMayI_2 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 ElvenVillageTalkEvents_TravelersInn", ROMX

; Elven village talk 61 (ElvenVillageTalkEvents), the traveler inn: sets wSpriteSlots + 7 (slot 0,
; OBJ_STATE) to 0 when hPlayerX is $30 and to 1 otherwise, starts Script_WelcomeToOurTraveler
; through StartScriptAtHL_B04 (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80,
; wModeState = 1) and sets wDataBank = $10; that script shows 'Welcome to our traveler ...' and
; jumps to Script_It_3 (SCRIPT_INN). (C2, E-0375)
; map event: wSpriteSlots + $7 = 0 if hPlayerX = $30 else 1, starts script $6445 and sets wDataBank
; = $10 (E-0122) (E-0344: the address in its name dropped or read as the label there; was
; ElvenVillageTalkEvents_TravelersInn)
ElvenVillageTalkEvents_TravelersInn::
    xor a
    ld [wSpriteSlots + $7], a
    ldh a, [hPlayerX]
    cp $30
    jr z, .call_start_script_at_hl_b04
    ld a, $01
    ld [wSpriteSlots + $7], a

.call_start_script_at_hl_b04:
    ld hl, Script_WelcomeToOurTraveler ; script '*: Welcome to our traveler's inn.'
    ASSERT BANK(Script_WelcomeToOurTraveler) == $10, "Script_WelcomeToOurTraveler is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ld a, $10
    ld [wDataBank], a
    ret

SECTION "Bank 04 TalkMsg079F_IfYouTravelWest", ROMX

; Elven village talk 62 (ElvenVillageTalkEvents): picks one message by story flags, tested in this
; order: EVENT_KEY_BOSS_BEATEN_2 set gives $0CEE 'It sure was a thrilling time when the thief was
; roving around.'; else EVENT_THANK_YOU_FOR_GETTING_THE set gives $07D6 'What do those monsters do
; with the things that they steal?'; otherwise $079F 'If you travel west along the plains, there is
; a hut.'. Each starts through StartMessageCommand09HL_B04 (script command $09). (C2, E-0375)
; tests story flags in turn (flag $01C3 set: jr to
; TalkMsg079F_IfYouTravelWest.call_start_message_command09_hl_b042; flag $01BE set: jr to
; TalkMsg079F_IfYouTravelWest.call_start_message_command09_hl_b04); when none of them branches,
; starts message $079F through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'If you travel west along the' (E-0082)
TalkMsg079F_IfYouTravelWest::
    ld de, EVENT_KEY_BOSS_BEATEN_2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_THANK_YOU_FOR_GETTING_THE
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

SECTION "Bank 04 Talk07D7_MilayouIEBeen", ROMX

; Milayou: by progress the 'Excuse me, are you a...' script, 'Have you changed your mind?'
; (EVENT_I_CAN), 'I've been checking around, and...' ($07D7), the forest script (pendant-seller
; scene), 'Please defeat the dark master...' ($07DD, forest scene), 'I asked for your support...'
; (second key boss), 'You've inspired me to try...' ($0CF1); after EVENT_MILAYOU_IEBEEN the 'I knew
; you come back!' script once, then 'Want to spar with me?'. (C2, E-0357; probed E-0375)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 3
; constant message(s) depending on story flags and state; the first one in the code is $07D7, whose
; string begins 'Milayou I've been checking around,' (E-0097)
Talk07D7_MilayouIEBeen::
    ld de, EVENT_MILAYOU_IEBEEN
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld de, EVENT_MILAYOU_HOW_DO_I_KNOW
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, EVENT_KEY_BOSS_BEATEN_2
    call TestFlagBit
    jr c, .call_start_script_at_hl_b043
    ld de, EVENT_SCENE_MILAYOU_FOREST
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_SCENE_PENDANT_SELLER_1C0
    call TestFlagBit
    jr c, .call_start_script_at_hl_b042
    ld de, EVENT_THANK_YOU_FOR_GETTING_THE
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld de, EVENT_I_CAN
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_ExcuseMeAreYou ; script '*: Excuse me, are you a'
    ASSERT BANK(Script_ExcuseMeAreYou) == $10, "Script_ExcuseMeAreYou is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_HaveYouChangedYour ; script '*: Have you changed your mind?'
    ASSERT BANK(Script_HaveYouChangedYour) == $10, "Script_HaveYouChangedYour is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $07d7 ; 'Milayou: I've been checking around, and'
    call StartMessageCommand09HL_B04
    ret

.call_start_script_at_hl_b042:
    ld hl, Script_MilayouIThoughtThis ; script 'Milayou: I thought this forest looked'
    ASSERT BANK(Script_MilayouIThoughtThis) == $10, "Script_MilayouIThoughtThis is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b042:
    ld hl, $07dd ; 'Milayou: Please defeat the dark master'
    call StartMessageCommand09HL_B04
    ret

.call_start_script_at_hl_b043:
    ld hl, Script_MilayouIAskedFor ; script 'Milayou: I asked for your support'
    ASSERT BANK(Script_MilayouIAskedFor) == $10, "Script_MilayouIAskedFor is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b043:
    ld hl, $0cf1 ; 'Milayou: You've inspired me to try'
    call StartMessageCommand09HL_B04
    ret

.call_test_flag_bit:
    ld de, EVENT_MILAYOU_IKNEW_YOU
    call TestFlagBit
    jr c, .call_start_script_at_hl_b044
    ld hl, Script_MilayouIKnewYou ; script 'Milayou: I knew you come back!'
    ASSERT BANK(Script_MilayouIKnewYou) == $10, "Script_MilayouIKnewYou is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b044:
    ld hl, Script_MilayouWantToSpar ; script 'Milayou: Want to spar with me?'
    ASSERT BANK(Script_MilayouWantToSpar) == $10, "Script_MilayouWantToSpar is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 TalkMsg07A9_ThisIsTheTravelersHutStay", ROMX

; Elven village talk 64 (ElvenVillageTalkEvents): starts message $07A9 through
; StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the message word,
; wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1); the message reads '... Stay and rest
; your feet a while.'. (C2, E-0375)
; starts message $07A9 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'This is the traveler's hut. Stay and' (E-0268, the E-0082 shape; was
; TalkMsg07A9_ThisIsTheTravelersHutStay)
TalkMsg07A9_ThisIsTheTravelersHutStay::
    ld hl, $07a9 ; '*: This is the traveler's hut.'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg07AA_ThatDealerHowExpensive", ROMX

; Elven village talk 65 (ElvenVillageTalkEvents): picks one message by story flags, tested in this
; order: EVENT_KEY_BOSS_BEATEN_2 set gives $0CF2 'That merchant, he was a thief.'; else
; EVENT_THANK_YOU_FOR_GETTING_THE set gives $07D8 ('I dug deep in my purse to buy from that dealer,
; but that ornament, it was the one stolen from my neighbor.'); else EVENT_SCENE_MERCY set gives
; $07C0 ('I dug deep in my purse to buy from that dealer, but it feel very odd.'); otherwise $07AA
; 'That dealer, how expensive!'. Each starts through StartMessageCommand09HL_B04 (script command
; $09). (C2, E-0375)
; tests story flags in turn (flag $01C3 set: jr to
; TalkMsg07AA_ThatDealerHowExpensive.call_start_message_command09_hl_b043; flag $01BE set: jr to
; TalkMsg07AA_ThatDealerHowExpensive.call_start_message_command09_hl_b042; flag $01BB set: jr to
; TalkMsg07AA_ThatDealerHowExpensive.call_start_message_command09_hl_b04); when none of them
; branches, starts message $07AA through StartMessageCommand09HL_B04 (script command $09); that
; string begins 'That dealer, how expensive! Nobody can' (E-0082)
TalkMsg07AA_ThatDealerHowExpensive::
    ld de, EVENT_KEY_BOSS_BEATEN_2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, EVENT_THANK_YOU_FOR_GETTING_THE
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_SCENE_MERCY
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

SECTION "Bank 04 Talk07C1_WhatMonstersAttackedYou", ROMX

; Talk: at first the 'Lately, the town of Miagen...' script; after the mercy scene 'What? Monsters
; attacked you in...' ($07C1); after EVENT_THANK_YOU_FOR_GETTING_THE 'The thieving monsters had
; a...' ($07D9); after the second key boss 'People say you can't judge...' ($0CF3). (C2, E-0357;
; probed E-0375)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 3
; constant message(s) depending on story flags and state; the first one in the code is $07C1, whose
; string begins 'What? Monsters attacked you in the' (E-0097)
Talk07C1_WhatMonstersAttackedYou::
    ld de, EVENT_KEY_BOSS_BEATEN_2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, EVENT_THANK_YOU_FOR_GETTING_THE
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_SCENE_MERCY
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, Script_LatelyTheTownOf ; script '*: Lately, the town of Miagen'
    ASSERT BANK(Script_LatelyTheTownOf) == $10, "Script_LatelyTheTownOf is read with bank $10 mapped"
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

SECTION "Bank 04 TalkMsg07AE_ThatDealersWaresCould", ROMX

; Elven village talk 67 (ElvenVillageTalkEvents): picks one message by story flags, tested in this
; order: EVENT_KEY_BOSS_BEATEN_2 set gives $0CF4 'That greedy hound of a dealer was behind those
; monsters...'; else EVENT_SCENE_PENDANT_SELLER_1C0 set gives $07DB 'That greedhound dealer scuttled
; off in an awful hurry.'; else EVENT_SCENE_MERCY set gives $07C2 'That dealer is a greedy hound!';
; otherwise $07AE ('... Could he sell any at those prices?'). Each starts through
; StartMessageCommand09HL_B04 (script command $09). (C2, E-0375)
; tests story flags in turn (flag $01C3 set: jr to
; TalkMsg07AE_ThatDealersWaresCould.call_start_message_command09_hl_b043; flag $01C0 set: jr to
; TalkMsg07AE_ThatDealersWaresCould.call_start_message_command09_hl_b042; flag $01BB set: jr to
; TalkMsg07AE_ThatDealersWaresCould.call_start_message_command09_hl_b04); when none of them
; branches, starts message $07AE through StartMessageCommand09HL_B04 (script command $09); that
; string begins 'That dealer's wares Could he sell' (E-0082)
TalkMsg07AE_ThatDealersWaresCould::
    ld de, EVENT_KEY_BOSS_BEATEN_2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b043
    ld de, EVENT_SCENE_PENDANT_SELLER_1C0
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b042
    ld de, EVENT_SCENE_MERCY
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $07ae ; '*: That dealer's wares… Could he'
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

SECTION "Bank 04 Talk07AF_HowDoesThisOrnament", ROMX

; The pendant seller: shows ornament, jewelry and vase in turn ($07AF-$07B1, then 'I've no use for
; the...'), the second round $07B3-$07B5 after EVENT_THANK_YOU_I_KNEW_YOU, each setting its flag,
; then the 'This pendant is yours for...' script until the pendant-seller scene; after the mercy
; scene the 'For 47,000G this earring...' script; after EVENT_YOU_DEFEATED_THE_MONSTERS_YOU 'You
; defeated the monsters...' ($07C5); after EVENT_THANK_YOU_FOR_GETTING_THE the 'What? Where I get
; my...' script, setting story flag byte $68 bit 0. (C2, E-0357; probed E-0375)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 8
; constant message(s) depending on story flags and state; the first one in the code is $07AF, whose
; string begins 'How does this ornament look? Take' (E-0097)
Talk07AF_HowDoesThisOrnament::
    ld de, EVENT_THANK_YOU_FOR_GETTING_THE
    call TestFlagBit
    jp c, .call_start_script_at_hl_b042
    ld de, EVENT_YOU_DEFEATED_THE_MONSTERS_YOU
    call TestFlagBit
    jp c, .call_start_message_command09_hl_b04
    ld de, EVENT_SCENE_MERCY
    call TestFlagBit
    jp c, .call_start_script_at_hl_b04
    ld de, EVENT_THANK_YOU_I_KNEW_YOU
    call TestFlagBit
    jr c, .call_test_flag_bit3
    ld de, EVENT_HOW_DOES_THIS_ORNAMENT
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld hl, $07af ; '*: How does this ornament look?'
    call StartMessageCommand09HL_B04
    ld de, EVENT_HOW_DOES_THIS_ORNAMENT
    call SetFlagBit
    ret

.call_test_flag_bit:
    ld de, EVENT_HOW_DOES_THIS_ORNAMENT_1B4
    call TestFlagBit
    jr c, .call_test_flag_bit2
    ld hl, $07b0 ; '*: How does this jewelry look?'
    call StartMessageCommand09HL_B04
    ld de, EVENT_HOW_DOES_THIS_ORNAMENT_1B4
    call SetFlagBit
    ret

.call_test_flag_bit2:
    ld de, EVENT_HOW_DOES_THIS_ORNAMENT_1B5
    call TestFlagBit
    jr c, .loop
    ld hl, $07b1 ; '*: How does this grand vase'
    call StartMessageCommand09HL_B04
    ld de, EVENT_HOW_DOES_THIS_ORNAMENT_1B5
    call SetFlagBit
    ret

.loop:
    ld hl, $07b2 ; '*: I've no use for the'
    call StartMessageCommand09HL_B04
    ret

.call_test_flag_bit3:
    ld de, EVENT_HOW_DOES_THIS_ORNAMENT_1B6
    call TestFlagBit
    jr c, .call_test_flag_bit4
    ld hl, $07b3 ; '*: How does this ornament look?'
    call StartMessageCommand09HL_B04
    ld de, EVENT_HOW_DOES_THIS_ORNAMENT_1B6
    call SetFlagBit
    ret

.call_test_flag_bit4:
    ld de, EVENT_HOW_DOES_THIS_ORNAMENT_1B7
    call TestFlagBit
    jr c, .call_test_flag_bit5
    ld hl, $07b4 ; '*: How does this jewelry look?'
    call StartMessageCommand09HL_B04
    ld de, EVENT_HOW_DOES_THIS_ORNAMENT_1B7
    call SetFlagBit
    ret

.call_test_flag_bit5:
    ld de, EVENT_HOW_DOES_THIS_ORNAMENT_1B8
    call TestFlagBit
    jr c, .call_test_flag_bit6
    ld hl, $07b5 ; '*: How does this grand vase'
    call StartMessageCommand09HL_B04
    ld de, EVENT_HOW_DOES_THIS_ORNAMENT_1B8
    call SetFlagBit
    ret

.call_test_flag_bit6:
    ld de, EVENT_SCENE_PENDANT_SELLER
    call TestFlagBit
    jr c, .loop
    ld hl, Script_ThisPendantIsYours ; script '*: This pendant is yours for'
    ASSERT BANK(Script_ThisPendantIsYours) == $10, "Script_ThisPendantIsYours is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_For47HeroHero ; script '*: For 47,000G this earring… What?'
    ASSERT BANK(Script_For47HeroHero) == $10, "Script_For47HeroHero is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $07c5 ; '*: You defeated the monsters… …You're'
    call StartMessageCommand09HL_B04
    ret

.call_start_script_at_hl_b042:
    ld hl, Script_WhatWhereIGet ; script '*: What? Where I get my'
    ASSERT BANK(Script_WhatWhereIGet) == $10, "Script_WhatWhereIGet is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ld a, [wStoryFlags + $68]
    set 0, a
    ld [wStoryFlags + $68], a
    ret

SECTION "Bank 04 TalkMsg07B8_WhoAreYou", ROMX

; Elven village talk 69 (ElvenVillageTalkEvents): starts message $07BA 'What, not you again!' when
; EVENT_YOU_1BA is set, otherwise $07B8 'Who are you?', through StartMessageCommand09HL_B04 (script
; command $09). It sets no flag; EVENT_YOU_1BA is set by Script_You_12, which talk 70 starts. (C2,
; E-0375)
; tests story flags in turn (flag $01BA set: jr to
; TalkMsg07B8_WhoAreYou.call_start_message_command09_hl_b04); when none of them branches, starts
; message $07B8 through StartMessageCommand09HL_B04 (script command $09); that string begins 'Who
; are you? You shouldn't be' (E-0082)
TalkMsg07B8_WhoAreYou::
    ld de, EVENT_YOU_1BA
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $07b8 ; '*: Who are you? You shouldn't'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $07ba ; '*: What, not you again!'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 ElvenVillageTalkEvents_SceneMercyBattle", ROMX

; Elven village talk 70 (ElvenVillageTalkEvents): starts Script_We when EVENT_YOU_1BA is set,
; otherwise Script_You_12 (which sets EVENT_YOU_1BA), through StartScriptAtHL_B04
; (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1). Both scripts run
; encounter $11, then 'Please! Mercy! Spare us!', SCRIPT_SCENE_MERCY and set EVENT_SCENE_MERCY. (C2,
; E-0375)
; map event: starts script $64A6 if story flag $1BA is set, else $6496 (E-0122) (E-0344: the address
; in its name dropped or read as the label there; was ElvenVillageTalkEvents_SceneMercyBattle)
; starts Script_You_12: '*: You're going to regret seeing' (E-0248)
ElvenVillageTalkEvents_SceneMercyBattle::
    ld de, EVENT_YOU_1BA
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_You_12 ; script '*: You're going to regret seeing'
    ASSERT BANK(Script_You_12) == $10, "Script_You_12 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_We ; script '*: We'll smash you as often'
    ASSERT BANK(Script_We) == $10, "Script_We is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk07BF_HeroFoundThePretty", ROMX

; The treasure chest: with room in the bag adds the Pretty ring ($3D, asking for a bag sort) and
; runs '0 opened the treasure chest...'; otherwise '0 found the Pretty Ring. But...' ($07BF). (C2,
; E-0357; probed E-0375)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1
; constant message(s) depending on story flags and state; the first one in the code is $07BF, whose
; string begins '0 found the Pretty Ring. But' (E-0097)
Talk07BF_HeroFoundThePretty::
    call InventoryHasFreeSlotCheck
    jr c, .read_inventory_sort_flags
    ld hl, $07bf ; '0 found the Pretty Ring. But'
    call StartMessageCommand09HL_B04
    ret

.read_inventory_sort_flags:
    ld [hl], $3d
    ld a, [wInventorySortFlags]
    set 6, a
    ld [wInventorySortFlags], a
    ld hl, Script_HeroOpenedTheTreasure ; script '0 opened the treasure chest. 0'
    ASSERT BANK(Script_HeroOpenedTheTreasure) == $10, "Script_HeroOpenedTheTreasure is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 ElvenVillageTalkEvents_SecondKeyBossBattle", ROMX

; Elven village talk 72 (ElvenVillageTalkEvents): starts Script_WhatIsItYou_2 when
; EVENT_WHAT_IS_IT_YOU is set, otherwise Script_WhatIsItYou (which sets EVENT_WHAT_IS_IT_YOU),
; through StartScriptAtHL_B04 (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80,
; wModeState = 1). Both scripts run encounter $12 and SCRIPT_KEY_BOSS_BEATEN_2, then set
; EVENT_KEY_BOSS_BEATEN_2 and EVENT_KEY_BOSS_BEATEN_2_205. (C2, E-0375)
; map event: starts script $652C if story flag $1C2 is set, else $6509 (E-0122) (E-0344: the address
; in its name dropped or read as the label there; was ElvenVillageTalkEvents_SecondKeyBossBattle)
; starts Script_WhatIsItYou: '*: What is it, you little' (E-0248)
ElvenVillageTalkEvents_SecondKeyBossBattle::
    ld de, EVENT_WHAT_IS_IT_YOU
    call TestFlagBit
    jr c, .call_start_script_at_hl_b04
    ld hl, Script_WhatIsItYou ; script '*: What is it, you little'
    ASSERT BANK(Script_WhatIsItYou) == $10, "Script_WhatIsItYou is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_script_at_hl_b04:
    ld hl, Script_WhatIsItYou_2 ; script '*: What is it, you little'
    ASSERT BANK(Script_WhatIsItYou_2) == $10, "Script_WhatIsItYou_2 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 VaseItem_DEFseed", ROMX

; Elven village talk 73 (ElvenVillageTalkEvents), a one-time vase: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 1 (vase), wScriptParam1 =
; ITEM_DEFSEED and story flag $01C8 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep
; = 0, wModeState = 1). That command gives the item and sets the flag when the flag is clear
; (group-0 message $A3), shows $A4 when the flag is already set and $A5 when the bag is full. (C2,
; E-0375)
; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $0E, story
; flag $01C8 in DE: when the flag is clear it gives item $0E (DEFseed) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; VaseItem_DEFseed)
VaseItem_DEFseed::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $0e
    ld [wScriptParam1], a
    ld de, $01c8
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 VaseItem_TinyMedal_Flag01C9", ROMX

; Elven village talk 74 (ElvenVillageTalkEvents), a one-time vase: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 1 (vase), wScriptParam1 =
; ITEM_TINYMEDAL and story flag $01C9 in wMessageIndex/wMessageGroup (wScriptRunning = 1,
; wScriptStep = 0, wModeState = 1). That command gives the item and sets the flag when the flag is
; clear (group-0 message $A3), shows $A4 when the flag is already set and $A5 when the bag is full.
; (C2, E-0375)
; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $2C, story
; flag $01C9 in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the flag (message
; $A3 of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; VaseItem_TinyMedal_Flag01C9)
VaseItem_TinyMedal_Flag01C9::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $2c
    ld [wScriptParam1], a
    ld de, $01c9
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 TalkMsg0CFB_HeroTriedToOpenTheChest", ROMX

; Elven village talk 75 (ElvenVillageTalkEvents): starts message $0CFB through
; StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the message word,
; wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1); the hero tries to open the chest:
; 'But it was locked.'. (C2, E-0375)
; starts message $0CFB through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 tried to open the chest. But' (E-0268, the E-0082 shape; was
; TalkMsg0CFB_HeroTriedToOpenTheChest)
TalkMsg0CFB_HeroTriedToOpenTheChest::
    ld hl, $0cfb ; '0 tried to open the chest.'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0CFA_HeroPeeredIntoTheOvenA", ROMX

; Elven village talk 76 (ElvenVillageTalkEvents): starts message $0CFA through
; StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the message word,
; wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1); the hero peers into the oven: 'A
; tantalizing aroma wafted out...'. (C2, E-0375)
; starts message $0CFA through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 peered into the oven. A tantalizing' (E-0268, the E-0082 shape; was
; TalkMsg0CFA_HeroPeeredIntoTheOvenA)
TalkMsg0CFA_HeroPeeredIntoTheOvenA::
    ld hl, $0cfa ; '0 peered into the oven. A'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0CFC_HeroPeeredIntoTheVaseCold", ROMX

; Elven village talk 77 (ElvenVillageTalkEvents): starts message $0CFC through
; StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the message word,
; wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1); the hero peers into the vase: 'Cold
; water lapped and rippled.'. (C2, E-0375)
; starts message $0CFC through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 peered into the vase. Cold water' (E-0268, the E-0082 shape; was
; TalkMsg0CFC_HeroPeeredIntoTheVaseCold)
TalkMsg0CFC_HeroPeeredIntoTheVaseCold::
    ld hl, $0cfc ; '0 peered into the vase. Cold'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 VaseItem_Potion_Flag01CA", ROMX

; Elven village talk 78 (ElvenVillageTalkEvents), a one-time vase: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 1 (vase), wScriptParam1 = ITEM_POTION
; and story flag $01CA in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0,
; wModeState = 1). That command gives the item and sets the flag when the flag is clear (group-0
; message $A3), shows $A4 when the flag is already set and $A5 when the bag is full. (C2, E-0375)
; a one-time vase: script command $0A with wScriptParam0 = 1 (kind) and wScriptParam1 = $04, story
; flag $01CA in DE: when the flag is clear it gives item $04 (Potion) and sets the flag (message $A3
; of group 0; $A4 when the flag is already set, $A5 when there is no room) (E-0269; was
; VaseItem_Potion_Flag01CA)
VaseItem_Potion_Flag01CA::
    ld a, $01
    ld [wScriptParam0], a
    ld a, $04
    ld [wScriptParam1], a
    ld de, $01ca
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 TalkMsg0CFD_HeroPeeredIntoTheOvenMeat", ROMX

; Elven village talk 79 (ElvenVillageTalkEvents): starts message $0CFD through
; StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the message word,
; wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1); the hero peers into the oven: 'Meat
; sizzled on a skewer.'. (C2, E-0375)
; starts message $0CFD through StartMessageCommand09HL_B04 (script command $09); that string begins
; '0 peered into the oven. Meat sizzled' (E-0268, the E-0082 shape; was
; TalkMsg0CFD_HeroPeeredIntoTheOvenMeat)
TalkMsg0CFD_HeroPeeredIntoTheOvenMeat::
    ld hl, $0cfd ; '0 peered into the oven. Meat'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 ChestItem_Laurel", ROMX

; Elven village talk 80 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_LAUREL and story flag $01CB in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep =
; 0, wModeState = 1). That command gives the item and sets the flag when the flag is clear (group-0
; message $A0), shows $A1 when the flag is already set and $A2 when the bag is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $08, story flag $01CB in DE: when the flag is clear it gives item $08 (Laurel) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_Laurel)
ChestItem_Laurel::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $08
    ld [wScriptParam1], a
    ld de, $01cb
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ElvenVillageTalkEvents_LootChest", ROMX

; Elven village talk 81 (ElvenVillageTalkEvents), a chest of loot: starts group-0 message $00A1 (the
; hero checks the treasure chest: 'But it was empty...') when EVENT_KEY_BOSS_BEATEN_2 is set,
; otherwise $0CFE (the hero opens the treasure chest: 'It was crammed with treasures.'), through
; StartMessageCommand09HL_B04 (script command $09). It gives no item and sets no flag. (C2, E-0375)
; tests story flags in turn (flag $01C3 set: jr to
; ElvenVillageTalkEvents_LootChest.call_start_message_command09_hl_b04); when none of them branches,
; starts message $0CFE through StartMessageCommand09HL_B04 (script command $09); that string is
; empty (E-0082)
ElvenVillageTalkEvents_LootChest::
    ld de, EVENT_KEY_BOSS_BEATEN_2
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0cfe ; '0 opened the treasure chest. It'
    call StartMessageCommand09HL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $00a1 ; '0 checked the treasure chest. But'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 ChestItem_ExitBell_Flag01CC", ROMX

; Elven village talk 82 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_EXITBELL and story flag $01CC in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep
; = 0, wModeState = 1). That command gives the item and sets the flag when the flag is clear
; (group-0 message $A0), shows $A1 when the flag is already set and $A2 when the bag is full. (C2,
; E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $2A, story flag $01CC in DE: when the flag is clear it gives item $2A (ExitBell) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_ExitBell_Flag01CC)
ChestItem_ExitBell_Flag01CC::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2a
    ld [wScriptParam1], a
    ld de, $01cc
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_TinyMedal", ROMX

; Elven village talk 83 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_TINYMEDAL and story flag $01CD in wMessageIndex/wMessageGroup (wScriptRunning = 1,
; wScriptStep = 0, wModeState = 1). That command gives the item and sets the flag when the flag is
; clear (group-0 message $A0), shows $A1 when the flag is already set and $A2 when the bag is full.
; (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $2C, story flag $01CD in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was ChestItem_TinyMedal)
ChestItem_TinyMedal::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2c
    ld [wScriptParam1], a
    ld de, $01cd
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_Friend", ROMX

; Elven village talk 84 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_FRIEND and story flag $01CE in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep =
; 0, wModeState = 1). That command gives the item and sets the flag when the flag is clear (group-0
; message $A0), shows $A1 when the flag is already set and $A2 when the bag is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $23, story flag $01CE in DE: when the flag is clear it gives item $23 (Friend) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_Friend)
ChestItem_Friend::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $23
    ld [wScriptParam1], a
    ld de, $01ce
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 Talk_HeroCheckedTheTreasureChest", ROMX

; Elven village talk 85 (ElvenVillageTalkEvents): starts Script_HeroCheckedTheTreasure_3 through
; StartScriptAtHL_B04 (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1);
; that script shows message $0C48 (the hero checks the treasure chest), runs encounter $32 and then
; SCRIPT_SET_FLAG_REDRAW. (C2, E-0375)
; starts Script_HeroCheckedTheTreasure_3 (StartScriptAtHL_B04); its first message begins '0 checked
; the treasure chest. The' (E-0271; was Talk_HeroCheckedTheTreasureChest) (E-0344: the address in
; its name dropped or read as the label there; was Talk_HeroCheckedTheTreasureChest; shortened from
; TalkScript_HeroCheckedTheTreasureChest)
; starts Script_HeroCheckedTheTreasure_3: '0 checked the treasure chest. The' (E-0248)
Talk_HeroCheckedTheTreasureChest::
    ld hl, Script_HeroCheckedTheTreasure_3 ; script '0 checked the treasure chest. The'
    ASSERT BANK(Script_HeroCheckedTheTreasure_3) == $10, "Script_HeroCheckedTheTreasure_3 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 TalkMsg0C03_TheTowersManyTreasuresAre", ROMX

; Elven village talk 96 (ElvenVillageTalkEvents): starts message $0C03 through
; StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the message word,
; wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1); the message reads '... heavily
; guarded by monsters, slurp.'. (C2, E-0375)
; starts message $0C03 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'The Tower's many treasures are heavily guarded' (E-0268, the E-0082 shape; was
; TalkMsg0C03_TheTowersManyTreasuresAre)
TalkMsg0C03_TheTowersManyTreasuresAre::
    ld hl, $0c03 ; '*: The Tower's many treasures are'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0C02_OnlyAHandfulOfMastersHave", ROMX

; Elven village talk 97 (ElvenVillageTalkEvents): starts message $0C02 through
; StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the message word,
; wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1); the message reads 'Only a handful of
; masters have made it to the top of the Tower.'. (C2, E-0375)
; starts message $0C02 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'Only a handful of masters have made' (E-0268, the E-0082 shape; was
; TalkMsg0C02_OnlyAHandfulOfMastersHave)
TalkMsg0C02_OnlyAHandfulOfMastersHave::
    ld hl, $0c02 ; '*: Only a handful of masters'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 ElvenVillageTalkEvents_ShowThisIsThePower", ROMX

; Elven village talk 98: message $0C00 the first time (setting EVENT_THIS_IS_THE_POWER), then $0C01.
; (C2, E-0357; probed E-0375)
ElvenVillageTalkEvents_ShowThisIsThePower::
    ld de, EVENT_THIS_IS_THE_POWER
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0c00 ; '*: This is the Power Tower.'
    call StartMessageCommand09HL_B04
    ld de, EVENT_THIS_IS_THE_POWER
    call SetFlagBit
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0c01 ; '*: If you win, you'll earn'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 Talk_SceneChestBattle", ROMX

; Elven village talks 99, 100, 101 and 102 (ElvenVillageTalkEvents): starts Script_SceneChestBattle
; through StartScriptAtHL_B04 (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80,
; wModeState = 1); that script is the one command SCRIPT_SCENE_CHEST_BATTLE.
; ElvenVillageTalkEvents_PowerTowerChestBattle (talk 103) starts the same script until
; EVENT_MAP_CE_OBJECT_REMOVED is set. (C2, E-0375)
; starts Script_SceneChestBattle (StartScriptAtHL_B04) (E-0271; was Talk_SceneChestBattle) (E-0344:
; the address in its name dropped or read as the label there; was Talk_SceneChestBattle; named after
; the script it starts, Script_SceneChestBattle)
; starts Script_SceneChestBattle (E-0248)
Talk_SceneChestBattle::
    ld hl, Script_SceneChestBattle
    ASSERT BANK(Script_SceneChestBattle) == $10, "Script_SceneChestBattle is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 ElvenVillageTalkEvents_PowerTowerChestBattle", ROMX

; Power Tower's top: the chest battle script (Script_SceneChestBattle) until map $CE's object is
; removed, then 'You've conquered the Power Tower.' ($0C17). (C2, E-0357; probed E-0375)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1
; constant message(s) depending on story flags and state; the first one in the code is $0C17, an
; empty string on the normal path (E-0097)
; starts Script_SceneChestBattle (E-0248)
ElvenVillageTalkEvents_PowerTowerChestBattle::
    ld de, EVENT_MAP_CE_OBJECT_REMOVED
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, Script_SceneChestBattle
    ASSERT BANK(Script_SceneChestBattle) == $10, "Script_SceneChestBattle is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0c17 ; '*: You've conquered the Power Tower.'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 ChestItem_TinyMedal_Flag01D5", ROMX

; Elven village talk 104 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_TINYMEDAL and story flag $01D5 in wMessageIndex/wMessageGroup (wScriptRunning = 1,
; wScriptStep = 0, wModeState = 1). That command gives the item and sets the flag when the flag is
; clear (group-0 message $A0), shows $A1 when the flag is already set and $A2 when the bag is full.
; (C2, E-0375)
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

SECTION "Bank 04 ChestItem_AGL_Flag01D6", ROMX

; Elven village talk 105 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_AGL
; and story flag $01D6 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0,
; wModeState = 1). That command gives the item and sets the flag when the flag is clear (group-0
; message $A0), shows $A1 when the flag is already set and $A2 when the bag is full. (C2, E-0375)
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

SECTION "Bank 04 ChestItem_SkyBell", ROMX

; Elven village talk 106 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_SKYBELL and story flag $01D8 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep
; = 0, wModeState = 1). That command gives the item and sets the flag when the flag is clear
; (group-0 message $A0), shows $A1 when the flag is already set and $A2 when the bag is full. (C2,
; E-0375)
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

SECTION "Bank 04 ChestItem_Herb", ROMX

; Elven village talk 107 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_HERB
; and story flag $01DA in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0,
; wModeState = 1). That command gives the item and sets the flag when the flag is clear (group-0
; message $A0), shows $A1 when the flag is already set and $A2 when the bag is full. (C2, E-0375)
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

SECTION "Bank 04 ChestItem_OrcaCape_Flag01DB", ROMX

; Elven village talk 108 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_ORCACAPE and story flag $01DB in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep
; = 0, wModeState = 1). That command gives the item and sets the flag when the flag is clear
; (group-0 message $A0), shows $A1 when the flag is already set and $A2 when the bag is full. (C2,
; E-0375)
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

SECTION "Bank 04 ChestItem_LoveWater_Flag01DC", ROMX

; Elven village talk 109 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_LOVEWATER and story flag $01DC in wMessageIndex/wMessageGroup (wScriptRunning = 1,
; wScriptStep = 0, wModeState = 1). That command gives the item and sets the flag when the flag is
; clear (group-0 message $A0), shows $A1 when the flag is already set and $A2 when the bag is full.
; (C2, E-0375)
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

SECTION "Bank 04 ChestItem_LoveWater_Flag01DE", ROMX

; Elven village talk 110 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_LOVEWATER and story flag $01DE in wMessageIndex/wMessageGroup (wScriptRunning = 1,
; wScriptStep = 0, wModeState = 1). That command gives the item and sets the flag when the flag is
; clear (group-0 message $A0), shows $A1 when the flag is already set and $A2 when the bag is full.
; (C2, E-0375)
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

SECTION "Bank 04 ChestItem_StoneFang", ROMX

; Elven village talk 111 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_STONEFANG and story flag $01DF in wMessageIndex/wMessageGroup (wScriptRunning = 1,
; wScriptStep = 0, wModeState = 1). That command gives the item and sets the flag when the flag is
; clear (group-0 message $A0), shows $A1 when the flag is already set and $A2 when the bag is full.
; (C2, E-0375)
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

SECTION "Bank 04 ChestItem_Herb_Flag0169", ROMX

; Elven village talk 112 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_HERB
; and story flag $0169 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0,
; wModeState = 1). That command gives the item and sets the flag when the flag is clear (group-0
; message $A0), shows $A1 when the flag is already set and $A2 when the bag is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $01, story flag $0169 in DE: when the flag is clear it gives item $01 (Herb) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_Herb_Flag0169)
ChestItem_Herb_Flag0169::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $0169
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_LoveWater_Flag016B", ROMX

; Elven village talk 113 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_LOVEWATER and story flag $016B in wMessageIndex/wMessageGroup (wScriptRunning = 1,
; wScriptStep = 0, wModeState = 1). That command gives the item and sets the flag when the flag is
; clear (group-0 message $A0), shows $A1 when the flag is already set and $A2 when the bag is full.
; (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $02, story flag $016B in DE: when the flag is clear it gives item $02 (LoveWater) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was ChestItem_LoveWater_Flag016B)
ChestItem_LoveWater_Flag016B::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $02
    ld [wScriptParam1], a
    ld de, $016b
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_Sailor", ROMX

; Elven village talk 114 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_SAILOR and story flag $016C in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep =
; 0, wModeState = 1). That command gives the item and sets the flag when the flag is clear (group-0
; message $A0), shows $A1 when the flag is already set and $A2 when the bag is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $5F, story flag $016C in DE: when the flag is clear it gives item $5F (Sailor) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_Sailor)
ChestItem_Sailor::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5f
    ld [wScriptParam1], a
    ld de, $016c
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_SilvrCape", ROMX

; Elven village talk 115 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_SILVRCAPE and story flag $016D in wMessageIndex/wMessageGroup (wScriptRunning = 1,
; wScriptStep = 0, wModeState = 1). That command gives the item and sets the flag when the flag is
; clear (group-0 message $A0), shows $A1 when the flag is already set and $A2 when the bag is full.
; (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $4E, story flag $016D in DE: when the flag is clear it gives item $4E (SilvrCape) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was ChestItem_SilvrCape)
ChestItem_SilvrCape::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $4e
    ld [wScriptParam1], a
    ld de, $016d
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_MagicCape", ROMX

; Elven village talk 116 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_MAGICCAPE and story flag $016F in wMessageIndex/wMessageGroup (wScriptRunning = 1,
; wScriptStep = 0, wModeState = 1). That command gives the item and sets the flag when the flag is
; clear (group-0 message $A0), shows $A1 when the flag is already set and $A2 when the bag is full.
; (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $4C, story flag $016F in DE: when the flag is clear it gives item $4C (MagicCape) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was ChestItem_MagicCape)
ChestItem_MagicCape::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $4c
    ld [wScriptParam1], a
    ld de, $016f
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_DracoCape", ROMX

; Elven village talk 117 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_DRACOCAPE and story flag $0170 in wMessageIndex/wMessageGroup (wScriptRunning = 1,
; wScriptStep = 0, wModeState = 1). That command gives the item and sets the flag when the flag is
; clear (group-0 message $A0), shows $A1 when the flag is already set and $A2 when the bag is full.
; (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $4D, story flag $0170 in DE: when the flag is clear it gives item $4D (DracoCape) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was ChestItem_DracoCape)
ChestItem_DracoCape::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $4d
    ld [wScriptParam1], a
    ld de, $0170
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_Herb_Flag0171", ROMX

; Elven village talk 118 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_HERB
; and story flag $0171 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0,
; wModeState = 1). That command gives the item and sets the flag when the flag is clear (group-0
; message $A0), shows $A1 when the flag is already set and $A2 when the bag is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $01, story flag $0171 in DE: when the flag is clear it gives item $01 (Herb) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_Herb_Flag0171)
ChestItem_Herb_Flag0171::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $0171
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_TinyMedal_Flag0172", ROMX

; Elven village talk 119 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_TINYMEDAL and story flag $0172 in wMessageIndex/wMessageGroup (wScriptRunning = 1,
; wScriptStep = 0, wModeState = 1). That command gives the item and sets the flag when the flag is
; clear (group-0 message $A0), shows $A1 when the flag is already set and $A2 when the bag is full.
; (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $2C, story flag $0172 in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was ChestItem_TinyMedal_Flag0172)
ChestItem_TinyMedal_Flag0172::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2c
    ld [wScriptParam1], a
    ld de, $0172
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 Talk_HeroCheckedTheTreasureChest_2", ROMX

; Elven village talk 120 (ElvenVillageTalkEvents): starts Script_HeroCheckedTheTreasure_4 through
; StartScriptAtHL_B04 (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80, wModeState = 1);
; that script shows message $0C49 (the hero checks the treasure chest) and then runs
; SCRIPT_SCENE_YOU_DID_IT. (C2, E-0375)
; starts Script_HeroCheckedTheTreasure_4 (StartScriptAtHL_B04); its first message begins '0 checked
; the treasure chest. It' (E-0271; was Talk_HeroCheckedTheTreasureChest_2) (E-0344: the address in
; its name dropped or read as the label there; was Talk_HeroCheckedTheTreasureChest_2; shortened
; from TalkScript_HeroCheckedTheTreasureChest_2)
; starts Script_HeroCheckedTheTreasure_4: '0 checked the treasure chest. It' (E-0248)
Talk_HeroCheckedTheTreasureChest_2::
    ld hl, Script_HeroCheckedTheTreasure_4 ; script '0 checked the treasure chest. It'
    ASSERT BANK(Script_HeroCheckedTheTreasure_4) == $10, "Script_HeroCheckedTheTreasure_4 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 TalkMsg0C1B_ItsNotThatEasyToWin", ROMX

; Elven village talk 128 (ElvenVillageTalkEvents): starts message $0C1B through
; StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the message word,
; wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1); the message reads '... You have to
; use your noggin to mix and match skills for best effect.'. (C2, E-0375)
; starts message $0C1B through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'It's not that easy to win here' (E-0268, the E-0082 shape; was TalkMsg0C1B_ItsNotThatEasyToWin)
TalkMsg0C1B_ItsNotThatEasyToWin::
    ld hl, $0c1b ; '*: It's not that easy to'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0C1A_InThisTowerYourOpponents", ROMX

; Elven village talk 129 (ElvenVillageTalkEvents): starts message $0C1A through
; StartMessageCommand09HL_B04 (script command $09: wScriptParam0/1 = the message word,
; wScriptCommandType = 9, wScriptRunning = 1, wModeState = 1); the message reads 'In this Tower,
; your opponents come at you with support skills ...'. (C2, E-0375)
; starts message $0C1A through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'In this Tower, your opponents come at' (E-0268, the E-0082 shape; was
; TalkMsg0C1A_InThisTowerYourOpponents)
TalkMsg0C1A_InThisTowerYourOpponents::
    ld hl, $0c1a ; '*: In this Tower, your opponents'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 ElvenVillageTalkEvents_ShowThisIsTheBaffle", ROMX

; Elven village talk 130: message $0C18 the first time (setting EVENT_THIS_IS_THE_BAFFLE), then
; $0C19. (C2, E-0357; probed E-0375)
ElvenVillageTalkEvents_ShowThisIsTheBaffle::
    ld de, EVENT_THIS_IS_THE_BAFFLE
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0c18 ; '*: This is the Baffle Tower.'
    call StartMessageCommand09HL_B04
    ld de, EVENT_THIS_IS_THE_BAFFLE
    call SetFlagBit
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0c19 ; '*: If you win, you'll earn'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 Talk_SceneChestBattle_2", ROMX

; Elven village talks 131, 132, 133 and 134 (ElvenVillageTalkEvents): starts Script_SceneChestBattle
; through StartScriptAtHL_B04 (wScriptPointerLo/Hi = the script, wScriptStartRequest = $80,
; wModeState = 1), the same as Talk_SceneChestBattle; that script is the one command
; SCRIPT_SCENE_CHEST_BATTLE. (C2, E-0375)
; starts Script_SceneChestBattle (StartScriptAtHL_B04) (E-0271; was Talk_SceneChestBattle_2)
; (E-0344: the address in its name dropped or read as the label there; was Talk_SceneChestBattle_2;
; named after the script it starts, Script_SceneChestBattle)
; starts Script_SceneChestBattle (E-0248)
Talk_SceneChestBattle_2::
    ld hl, Script_SceneChestBattle
    ASSERT BANK(Script_SceneChestBattle) == $10, "Script_SceneChestBattle is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 ElvenVillageTalkEvents_BaffleTowerChestBattle", ROMX

; Baffle Tower's top: the chest battle script until map $D7's object is removed, then 'You've
; conquered the Baffle Tower.' ($0C2F). (C2, E-0357; probed E-0375)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1
; constant message(s) depending on story flags and state; the first one in the code is $0C2F, an
; empty string on the normal path (E-0097)
; starts Script_SceneChestBattle (E-0248)
ElvenVillageTalkEvents_BaffleTowerChestBattle::
    ld de, EVENT_MAP_D7_OBJECT_REMOVED
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, Script_SceneChestBattle
    ASSERT BANK(Script_SceneChestBattle) == $10, "Script_SceneChestBattle is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0c2f ; '*: You've conquered the Baffle Tower.'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 ChestItem_SkyBell_Flag0175", ROMX

; Elven village talk 136 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_SKYBELL and story flag $0175 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep
; = 0, wModeState = 1). That command gives the item and sets the flag when the flag is clear
; (group-0 message $A0), shows $A1 when the flag is already set and $A2 when the bag is full. (C2,
; E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $0A, story flag $0175 in DE: when the flag is clear it gives item $0A (SkyBell) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_SkyBell_Flag0175)
ChestItem_SkyBell_Flag0175::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $0a
    ld [wScriptParam1], a
    ld de, $0175
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_Smart", ROMX

; Elven village talk 137 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_SMART_4A and story flag $0176 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep
; = 0, wModeState = 1). That command gives the item and sets the flag when the flag is clear
; (group-0 message $A0), shows $A1 when the flag is already set and $A2 when the bag is full. (C2,
; E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $4A, story flag $0176 in DE: when the flag is clear it gives item $4A (Smart) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_Smart)
ChestItem_Smart::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $4a
    ld [wScriptParam1], a
    ld de, $0176
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_ExitBell_Flag0177", ROMX

; Elven village talk 138 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_EXITBELL and story flag $0177 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep
; = 0, wModeState = 1). That command gives the item and sets the flag when the flag is clear
; (group-0 message $A0), shows $A1 when the flag is already set and $A2 when the bag is full. (C2,
; E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $2A, story flag $0177 in DE: when the flag is clear it gives item $2A (ExitBell) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_ExitBell_Flag0177)
ChestItem_ExitBell_Flag0177::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2a
    ld [wScriptParam1], a
    ld de, $0177
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_Herb_Flag0179", ROMX

; Elven village talk 139 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_HERB
; and story flag $0179 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0,
; wModeState = 1). That command gives the item and sets the flag when the flag is clear (group-0
; message $A0), shows $A1 when the flag is already set and $A2 when the bag is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $01, story flag $0179 in DE: when the flag is clear it gives item $01 (Herb) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_Herb_Flag0179)
ChestItem_Herb_Flag0179::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $0179
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_AwakeSand", ROMX

; Elven village talk 140 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_AWAKESAND and story flag $017A in wMessageIndex/wMessageGroup (wScriptRunning = 1,
; wScriptStep = 0, wModeState = 1). That command gives the item and sets the flag when the flag is
; clear (group-0 message $A0), shows $A1 when the flag is already set and $A2 when the bag is full.
; (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $09, story flag $017A in DE: when the flag is clear it gives item $09 (AwakeSand) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was ChestItem_AwakeSand)
ChestItem_AwakeSand::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $09
    ld [wScriptParam1], a
    ld de, $017a
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_Cleric", ROMX

; Elven village talk 141 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_CLERIC and story flag $017B in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep =
; 0, wModeState = 1). That command gives the item and sets the flag when the flag is clear (group-0
; message $A0), shows $A1 when the flag is already set and $A2 when the bag is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $61, story flag $017B in DE: when the flag is clear it gives item $61 (Cleric) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_Cleric)
ChestItem_Cleric::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $61
    ld [wScriptParam1], a
    ld de, $017b
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_ExitBell_Flag017D", ROMX

; Elven village talk 142 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_EXITBELL and story flag $017D in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep
; = 0, wModeState = 1). That command gives the item and sets the flag when the flag is clear
; (group-0 message $A0), shows $A1 when the flag is already set and $A2 when the bag is full. (C2,
; E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $2A, story flag $017D in DE: when the flag is clear it gives item $2A (ExitBell) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_ExitBell_Flag017D)
ChestItem_ExitBell_Flag017D::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2a
    ld [wScriptParam1], a
    ld de, $017d
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_BraveCape", ROMX

; Elven village talk 143 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_BRAVECAPE and story flag $017E in wMessageIndex/wMessageGroup (wScriptRunning = 1,
; wScriptStep = 0, wModeState = 1). That command gives the item and sets the flag when the flag is
; clear (group-0 message $A0), shows $A1 when the flag is already set and $A2 when the bag is full.
; (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $52, story flag $017E in DE: when the flag is clear it gives item $52 (BraveCape) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was ChestItem_BraveCape)
ChestItem_BraveCape::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $52
    ld [wScriptParam1], a
    ld de, $017e
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_MoonHerb", ROMX

; Elven village talk 144 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_MOONHERB and story flag $017F in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep
; = 0, wModeState = 1). That command gives the item and sets the flag when the flag is clear
; (group-0 message $A0), shows $A1 when the flag is already set and $A2 when the bag is full. (C2,
; E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $07, story flag $017F in DE: when the flag is clear it gives item $07 (MoonHerb) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_MoonHerb)
ChestItem_MoonHerb::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $07
    ld [wScriptParam1], a
    ld de, $017f
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_MermScale_Flag00D6", ROMX

; Elven village talk 145 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_MERMSCALE and story flag $00D6 in wMessageIndex/wMessageGroup (wScriptRunning = 1,
; wScriptStep = 0, wModeState = 1). That command gives the item and sets the flag when the flag is
; clear (group-0 message $A0), shows $A1 when the flag is already set and $A2 when the bag is full.
; (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $46, story flag $00D6 in DE: when the flag is clear it gives item $46 (MermScale) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was ChestItem_MermScale_Flag00D6)
ChestItem_MermScale_Flag00D6::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $46
    ld [wScriptParam1], a
    ld de, $00d6
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_LoveWater_Flag00D7", ROMX

; Elven village talk 146 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_LOVEWATER and story flag $00D7 in wMessageIndex/wMessageGroup (wScriptRunning = 1,
; wScriptStep = 0, wModeState = 1). That command gives the item and sets the flag when the flag is
; clear (group-0 message $A0), shows $A1 when the flag is already set and $A2 when the bag is full.
; (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $02, story flag $00D7 in DE: when the flag is clear it gives item $02 (LoveWater) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was ChestItem_LoveWater_Flag00D7)
ChestItem_LoveWater_Flag00D7::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $02
    ld [wScriptParam1], a
    ld de, $00d7
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_Thief", ROMX

; Elven village talk 147 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_THIEF
; and story flag $00D8 in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0,
; wModeState = 1). That command gives the item and sets the flag when the flag is clear (group-0
; message $A0), shows $A1 when the flag is already set and $A2 when the bag is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $60, story flag $00D8 in DE: when the flag is clear it gives item $60 (Thief) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_Thief)
ChestItem_Thief::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $60
    ld [wScriptParam1], a
    ld de, $00d8
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_Herb_Flag00DA", ROMX

; Elven village talk 148 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_HERB
; and story flag $00DA in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0,
; wModeState = 1). That command gives the item and sets the flag when the flag is clear (group-0
; message $A0), shows $A1 when the flag is already set and $A2 when the bag is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $01, story flag $00DA in DE: when the flag is clear it gives item $01 (Herb) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_Herb_Flag00DA)
ChestItem_Herb_Flag00DA::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $00da
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_GoldCape", ROMX

; Elven village talk 149 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_GOLDCAPE and story flag $00DB in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep
; = 0, wModeState = 1). That command gives the item and sets the flag when the flag is clear
; (group-0 message $A0), shows $A1 when the flag is already set and $A2 when the bag is full. (C2,
; E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $4F, story flag $00DB in DE: when the flag is clear it gives item $4F (GoldCape) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_GoldCape)
ChestItem_GoldCape::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $4f
    ld [wScriptParam1], a
    ld de, $00db
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_Mage", ROMX

; Elven village talk 150 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 = ITEM_MAGE
; and story flag $00DC in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep = 0,
; wModeState = 1). That command gives the item and sets the flag when the flag is clear (group-0
; message $A0), shows $A1 when the flag is already set and $A2 when the bag is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $5D, story flag $00DC in DE: when the flag is clear it gives item $5D (Mage) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_Mage)
ChestItem_Mage::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5d
    ld [wScriptParam1], a
    ld de, $00dc
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_Antidote", ROMX

; Elven village talk 151 (ElvenVillageTalkEvents), a one-time chest: StartTreasureFlagDE_B04 starts
; script command $0A (RunOneTimeTreasure) with wScriptParam0 = 0 (chest), wScriptParam1 =
; ITEM_ANTIDOTE and story flag $00DD in wMessageIndex/wMessageGroup (wScriptRunning = 1, wScriptStep
; = 0, wModeState = 1). That command gives the item and sets the flag when the flag is clear
; (group-0 message $A0), shows $A1 when the flag is already set and $A2 when the bag is full. (C2,
; E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $06, story flag $00DD in DE: when the flag is clear it gives item $06 (Antidote) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_Antidote)
ChestItem_Antidote::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $06
    ld [wScriptParam1], a
    ld de, $00dd
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 TalkMsg0C33_ItsBrutalUpAheadIWouldnt", ROMX

; Elven village talk 160 ($A0): starts message $0C33 through StartMessageCommand09HL_B04 (script
; command $09, wModeState = 1); the line warns that it is 'brutal up ahead'. (C2, E-0375)
; starts message $0C33 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'It's brutal up ahead. I wouldn't push' (E-0268, the E-0082 shape; was
; TalkMsg0C33_ItsBrutalUpAheadIWouldnt)
TalkMsg0C33_ItsBrutalUpAheadIWouldnt::
    ld hl, $0c33 ; '*: It's brutal up ahead. I'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0C32_TheMonstersHereAreAwfulIm", ROMX

; Elven village talk 161 ($A1): starts message $0C32 ('The monsters here are awful.' ...) through
; StartMessageCommand09HL_B04 (script command $09, wModeState = 1). (C2, E-0375)
; starts message $0C32 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'The monsters here are awful. I'm losing' (E-0268, the E-0082 shape; was
; TalkMsg0C32_TheMonstersHereAreAwfulIm)
TalkMsg0C32_TheMonstersHereAreAwfulIm::
    ld hl, $0c32 ; '*: The monsters here are awful.'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 ElvenVillageTalkEvents_ShowIfYouveMadeIt", ROMX

; Elven village talk 162: message $0C30 the first time (setting EVENT_IF_YOUVE_MADE_IT), then $0C31.
; (C2, E-0357; probed E-0375)
ElvenVillageTalkEvents_ShowIfYouveMadeIt::
    ld de, EVENT_IF_YOUVE_MADE_IT
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, $0c30 ; '*: If you've made it to'
    call StartMessageCommand09HL_B04
    ld de, EVENT_IF_YOUVE_MADE_IT
    call SetFlagBit
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0c31 ; '*: This Tower is terribly tough.'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 Talk_SoulTowerChestBattle", ROMX

; Elven village talks 163-166 ($A3-$A6), the Soul Tower group (Talk0C47 follows them): starts
; Script_SceneChestBattle (StartScriptAtHL_B04: wScriptPointerLo/Hi, wScriptStartRequest = $80,
; wModeState = 1), the script that runs SCRIPT_SCENE_CHEST_BATTLE. Talk_SceneChestBattle and
; Talk_SceneChestBattle_2 are the same code for the two earlier tower groups. (C2, E-0375)
; starts Script_SceneChestBattle (StartScriptAtHL_B04) (E-0271; was Talk_SoulTowerChestBattle)
; (E-0344: the address in its name dropped or read as the label there; was
; Talk_SoulTowerChestBattle; shortened from TalkScript_0C)
; starts Script_SceneChestBattle (E-0248)
Talk_SoulTowerChestBattle::
    ld hl, Script_SceneChestBattle
    ASSERT BANK(Script_SceneChestBattle) == $10, "Script_SceneChestBattle is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk0C47", ROMX

; Soul Tower's top: the chest battle script until map $E0's object is removed, then 'You've
; conquered the Soul Tower.' ($0C47). (C2, E-0357; probed E-0375)
; talk handler (bank-$04/$13 event code, reached from the DispatchTalkEvent groups): starts 1
; constant message(s) depending on story flags and state; the first one in the code is $0C47, an
; empty string on the normal path (E-0097)
; starts Script_SceneChestBattle (E-0248)
Talk0C47::
    ld de, EVENT_MAP_E0_OBJECT_REMOVED
    call TestFlagBit
    jr c, .call_start_message_command09_hl_b04
    ld hl, Script_SceneChestBattle
    ASSERT BANK(Script_SceneChestBattle) == $10, "Script_SceneChestBattle is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

.call_start_message_command09_hl_b04:
    ld hl, $0c47 ; '*: You've conquered the Soul Tower.'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 ChestItem_ExitBell_Flag00F5", ROMX

; Elven village talk 168 ($A8), a treasure chest: starts script command $0A (RunOneTimeTreasure)
; through StartTreasureFlagDE_B04 with kind 0 (a chest) in wScriptParam0, ITEM_EXITBELL in
; wScriptParam1 and story flag $00F5 in wMessageIndex/wMessageGroup. That command gives the item and
; sets the flag the first time (message $A0 of group 0), shows the empty message $A1 once the flag
; is set, and $A2 when the inventory is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $2A, story flag $00F5 in DE: when the flag is clear it gives item $2A (ExitBell) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_ExitBell_Flag00F5)
ChestItem_ExitBell_Flag00F5::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2a
    ld [wScriptParam1], a
    ld de, $00f5
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_War_Flag00F6", ROMX

; Elven village talk 169 ($A9), a treasure chest: starts script command $0A (RunOneTimeTreasure)
; through StartTreasureFlagDE_B04 with kind 0 (a chest) in wScriptParam0, ITEM_WAR in wScriptParam1
; and story flag $00F6 in wMessageIndex/wMessageGroup. That command gives the item and sets the flag
; the first time (message $A0 of group 0), shows the empty message $A1 once the flag is set, and $A2
; when the inventory is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $5C, story flag $00F6 in DE: when the flag is clear it gives item $5C (War) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_War_Flag00F6)
ChestItem_War_Flag00F6::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5c
    ld [wScriptParam1], a
    ld de, $00f6
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_WorldDew_Flag00F7", ROMX

; Elven village talk 170 ($AA), a treasure chest: starts script command $0A (RunOneTimeTreasure)
; through StartTreasureFlagDE_B04 with kind 0 (a chest) in wScriptParam0, ITEM_WORLDDEW in
; wScriptParam1 and story flag $00F7 in wMessageIndex/wMessageGroup. That command gives the item and
; sets the flag the first time (message $A0 of group 0), shows the empty message $A1 once the flag
; is set, and $A2 when the inventory is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $03, story flag $00F7 in DE: when the flag is clear it gives item $03 (WorldDew) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_WorldDew_Flag00F7)
ChestItem_WorldDew_Flag00F7::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $03
    ld [wScriptParam1], a
    ld de, $00f7
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_TinyMedal_Flag00F9", ROMX

; Elven village talk 171 ($AB), a treasure chest: starts script command $0A (RunOneTimeTreasure)
; through StartTreasureFlagDE_B04 with kind 0 (a chest) in wScriptParam0, ITEM_TINYMEDAL in
; wScriptParam1 and story flag $00F9 in wMessageIndex/wMessageGroup. That command gives the item and
; sets the flag the first time (message $A0 of group 0), shows the empty message $A1 once the flag
; is set, and $A2 when the inventory is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $2C, story flag $00F9 in DE: when the flag is clear it gives item $2C (TinyMedal) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was ChestItem_TinyMedal_Flag00F9)
ChestItem_TinyMedal_Flag00F9::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $2c
    ld [wScriptParam1], a
    ld de, $00f9
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_SteelFang", ROMX

; Elven village talk 172 ($AC), a treasure chest: starts script command $0A (RunOneTimeTreasure)
; through StartTreasureFlagDE_B04 with kind 0 (a chest) in wScriptParam0, ITEM_STEELFANG in
; wScriptParam1 and story flag $00FA in wMessageIndex/wMessageGroup. That command gives the item and
; sets the flag the first time (message $A0 of group 0), shows the empty message $A1 once the flag
; is set, and $A2 when the inventory is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $45, story flag $00FA in DE: when the flag is clear it gives item $45 (SteelFang) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was ChestItem_SteelFang)
ChestItem_SteelFang::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $45
    ld [wScriptParam1], a
    ld de, $00fa
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_DrakScale", ROMX

; Elven village talk 173 ($AD), a treasure chest: starts script command $0A (RunOneTimeTreasure)
; through StartTreasureFlagDE_B04 with kind 0 (a chest) in wScriptParam0, ITEM_DRAKSCALE in
; wScriptParam1 and story flag $00FB in wMessageIndex/wMessageGroup. That command gives the item and
; sets the flag the first time (message $A0 of group 0), shows the empty message $A1 once the flag
; is set, and $A2 when the inventory is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $47, story flag $00FB in DE: when the flag is clear it gives item $47 (DrakScale) and sets the
; flag (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room)
; (E-0269; was ChestItem_DrakScale)
ChestItem_DrakScale::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $47
    ld [wScriptParam1], a
    ld de, $00fb
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_Life", ROMX

; Elven village talk 174 ($AE), a treasure chest: starts script command $0A (RunOneTimeTreasure)
; through StartTreasureFlagDE_B04 with kind 0 (a chest) in wScriptParam0, ITEM_LIFE in wScriptParam1
; and story flag $00FD in wMessageIndex/wMessageGroup. That command gives the item and sets the flag
; the first time (message $A0 of group 0), shows the empty message $A1 once the flag is set, and $A2
; when the inventory is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $5A, story flag $00FD in DE: when the flag is clear it gives item $5A (Life) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_Life)
ChestItem_Life::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5a
    ld [wScriptParam1], a
    ld de, $00fd
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_Divine", ROMX

; Elven village talk 175 ($AF), a treasure chest: starts script command $0A (RunOneTimeTreasure)
; through StartTreasureFlagDE_B04 with kind 0 (a chest) in wScriptParam0, ITEM_DIVINE in
; wScriptParam1 and story flag $00FE in wMessageIndex/wMessageGroup. That command gives the item and
; sets the flag the first time (message $A0 of group 0), shows the empty message $A1 once the flag
; is set, and $A2 when the inventory is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $5B, story flag $00FE in DE: when the flag is clear it gives item $5B (Divine) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_Divine)
ChestItem_Divine::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $5b
    ld [wScriptParam1], a
    ld de, $00fe
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_Herb_Flag00FF", ROMX

; Elven village talk 176 ($B0), a treasure chest: starts script command $0A (RunOneTimeTreasure)
; through StartTreasureFlagDE_B04 with kind 0 (a chest) in wScriptParam0, ITEM_HERB in wScriptParam1
; and story flag $00FF in wMessageIndex/wMessageGroup. That command gives the item and sets the flag
; the first time (message $A0 of group 0), shows the empty message $A1 once the flag is set, and $A2
; when the inventory is full. (C2, E-0375)
; a one-time treasure chest: script command $0A with wScriptParam0 = 0 (kind) and wScriptParam1 =
; $01, story flag $00FF in DE: when the flag is clear it gives item $01 (Herb) and sets the flag
; (message $A0 of group 0; $A1 when the flag is already set, $A2 when there is no room) (E-0269; was
; ChestItem_Herb_Flag00FF)
ChestItem_Herb_Flag00FF::
    ld a, $00
    ld [wScriptParam0], a
    ld a, $01
    ld [wScriptParam1], a
    ld de, $00ff
    call StartTreasureFlagDE_B04
    ret

SECTION "Bank 04 ChestItem_PltnmCape", ROMX

; Elven village talk 177 ($B1), a treasure chest: starts script command $0A (RunOneTimeTreasure)
; through StartTreasureFlagDE_B04 with kind 0 (a chest) in wScriptParam0, ITEM_PLTNMCAPE in
; wScriptParam1 and story flag $01F3 in wMessageIndex/wMessageGroup. That command gives the item and
; sets the flag the first time (message $A0 of group 0), shows the empty message $A1 once the flag
; is set, and $A2 when the inventory is full. (C2, E-0375)
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

SECTION "Bank 04 ChestItem_Wise", ROMX

; Elven village talk 178 ($B2), a treasure chest: starts script command $0A (RunOneTimeTreasure)
; through StartTreasureFlagDE_B04 with kind 0 (a chest) in wScriptParam0, ITEM_WISE in wScriptParam1
; and story flag $01F4 in wMessageIndex/wMessageGroup. That command gives the item and sets the flag
; the first time (message $A0 of group 0), shows the empty message $A1 once the flag is set, and $A2
; when the inventory is full. (C2, E-0375)
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

SECTION "Bank 04 ChestItem_ExitBell_Flag01F5", ROMX

; Elven village talk 179 ($B3), a treasure chest: starts script command $0A (RunOneTimeTreasure)
; through StartTreasureFlagDE_B04 with kind 0 (a chest) in wScriptParam0, ITEM_EXITBELL in
; wScriptParam1 and story flag $01F5 in wMessageIndex/wMessageGroup. That command gives the item and
; sets the flag the first time (message $A0 of group 0), shows the empty message $A1 once the flag
; is set, and $A2 when the inventory is full. (C2, E-0375)
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

SECTION "Bank 04 ChestItem_Herb_Flag01F7", ROMX

; Elven village talk 180 ($B4), a treasure chest: starts script command $0A (RunOneTimeTreasure)
; through StartTreasureFlagDE_B04 with kind 0 (a chest) in wScriptParam0, ITEM_HERB in wScriptParam1
; and story flag $01F7 in wMessageIndex/wMessageGroup. That command gives the item and sets the flag
; the first time (message $A0 of group 0), shows the empty message $A1 once the flag is set, and $A2
; when the inventory is full. (C2, E-0375)
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

SECTION "Bank 04 ChestItem_Fight", ROMX

; Elven village talk 181 ($B5), a treasure chest: starts script command $0A (RunOneTimeTreasure)
; through StartTreasureFlagDE_B04 with kind 0 (a chest) in wScriptParam0, ITEM_FIGHT in
; wScriptParam1 and story flag $01F8 in wMessageIndex/wMessageGroup. That command gives the item and
; sets the flag the first time (message $A0 of group 0), shows the empty message $A1 once the flag
; is set, and $A2 when the inventory is full. (C2, E-0375)
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

SECTION "Bank 04 ChestItem_Starry", ROMX

; Elven village talk 182 ($B6), a treasure chest: starts script command $0A (RunOneTimeTreasure)
; through StartTreasureFlagDE_B04 with kind 0 (a chest) in wScriptParam0, ITEM_STARRY in
; wScriptParam1 and story flag $01F9 in wMessageIndex/wMessageGroup. That command gives the item and
; sets the flag the first time (message $A0 of group 0), shows the empty message $A1 once the flag
; is set, and $A2 when the inventory is full. (C2, E-0375)
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

SECTION "Bank 04 ChestItem_LoveWater_Flag01FA", ROMX

; Elven village talk 183 ($B7), a treasure chest: starts script command $0A (RunOneTimeTreasure)
; through StartTreasureFlagDE_B04 with kind 0 (a chest) in wScriptParam0, ITEM_LOVEWATER in
; wScriptParam1 and story flag $01FA in wMessageIndex/wMessageGroup. That command gives the item and
; sets the flag the first time (message $A0 of group 0), shows the empty message $A1 once the flag
; is set, and $A2 when the inventory is full. (C2, E-0375)
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

SECTION "Bank 04 KeyWorldTalkEvents", ROMX

; Talk category 9, the key worlds (DispatchTalkEvent_KeyWorld in bank $13 reaches it by farcall):
; jumps on wTalkEventGroup through nine handlers: 0 Talk_KeyWorldBossBattle, 1
; KeyWorldTalkEvents_Warubou, 2 KeyWorldTalkEvents_WarubouInn, 3 Talk_KeyWorldFloorBattle, 4 and 5
; the Warubou messages $0120 and $0122, 6 KeyWorldTalkEvents_ShowWarubouUseAMagic, 7
; Talk_WarubouWaheyYouDidItHero and 8 Talk_WarubouWaheySoThisIsIt. There is no range check on the
; group. (C2, E-0375)
; talk category 9: the key-world events (Warubou's messages, KeyWorldBossBattle,
; KeyWorldFloorBattle; E-0286)
KeyWorldTalkEvents::
    ld a, [wTalkEventGroup]
    jumptable
    dw Talk_KeyWorldBossBattle
    dw KeyWorldTalkEvents_Warubou
    dw KeyWorldTalkEvents_WarubouInn
    dw Talk_KeyWorldFloorBattle
    dw TalkMsg0120_WarubouQuitDawdlingWarooh
    dw TalkMsg0122_WarubouWaheyYouDidItHero
    dw KeyWorldTalkEvents_ShowWarubouUseAMagic
    dw Talk_WarubouWaheyYouDidItHero
    dw Talk_WarubouWaheySoThisIsIt

; Key world talk 0: starts Script_KeyWorldBossBattle (StartScriptAtHL_B04: wScriptPointerLo/Hi,
; wScriptStartRequest = $80, wModeState = 1), the bank-$10 script that runs
; SCRIPT_KEY_WORLD_BOSS_BATTLE. (C2, E-0375)
; starts Script_KeyWorldBossBattle (StartScriptAtHL_B04) (E-0271; was Talk_KeyWorldBossBattle)
; (E-0344: the address in its name dropped or read as the label there; was Talk_KeyWorldBossBattle;
; named after the script it starts, Script_KeyWorldBossBattle)
; starts Script_KeyWorldBossBattle (E-0248)
Talk_KeyWorldBossBattle::
    ld hl, Script_KeyWorldBossBattle
    ASSERT BANK(Script_KeyWorldBossBattle) == $10, "Script_KeyWorldBossBattle is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 KeyWorldTalkEvents_Warubou", ROMX

; Key world talk 1, Warubou: starts his script with screen table $0F on a floor of kind 3, otherwise
; $12 or $13 by bit 7 of wKeyWorldFloorState. (C2, E-0357; probed E-0375)
KeyWorldTalkEvents_Warubou::
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
    ld hl, Script_WarubouWaHeyYou_2 ; script 'Warubou: Wa-hey! You did it, 0!'
    ASSERT BANK(Script_WarubouWaHeyYou_2) == $10, "Script_WarubouWaHeyYou_2 is read with bank $10 mapped"
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
    ld hl, Script_WarubouWaHeyYou_2 ; script 'Warubou: Wa-hey! You did it, 0!'
    ASSERT BANK(Script_WarubouWaHeyYou_2) == $10, "Script_WarubouWaHeyYou_2 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 KeyWorldTalkEvents_WarubouInn", ROMX

; Key world talk 2: on map type $84 (wMapType) starts Script_WarubouWaHeyYou_3 ('Warubou: Wa-hey!
; You did it, <PLAYER>!'); otherwise only when IsPlayerAtKeyWorldGoalKindTriggerColumn gives A = 1
; starts Script_WarubouWaHeyThat ('Warubou: Wa-hey! That ...'), else returns. Then turns the first
; object to face the player (wSpriteSlots + OBJ_STATE = hPlayerFacing + 2, low 2 bits) and sets
; wDataBank = $10; both scripts jump on to the inn script Script_It_3. (C2, E-0369; probed E-0375)
; starts Script_WarubouWaHeyYou_3: 'Warubou: Wa-hey! You did it, 0!' (E-0248)
KeyWorldTalkEvents_WarubouInn::
    ld a, [wMapType]
    cp $84
    jr nz, .call_is_player_at_key_world_goal_kind_trigger
    ld hl, Script_WarubouWaHeyYou_3 ; script 'Warubou: Wa-hey! You did it, 0!'
    ASSERT BANK(Script_WarubouWaHeyYou_3) == $10, "Script_WarubouWaHeyYou_3 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    jr .check_player_facing

.call_is_player_at_key_world_goal_kind_trigger:
    call IsPlayerAtKeyWorldGoalKindTriggerColumn
    or a
    ret z
    ld hl, Script_WarubouWaHeyThat ; script 'Warubou: Wa-hey! That's it! GreatLog is'
    ASSERT BANK(Script_WarubouWaHeyThat) == $10, "Script_WarubouWaHeyThat is read with bank $10 mapped"
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

SECTION "Bank 04 IsPlayerAtKeyWorldGoalKindTriggerColumn", ROMX

; Returns A = 1 when the player stands where wKeyWorldGoalKind wants: kind 1 on map screen column 0
; (hMapScreenX = 0) with hPlayerX $20 or $40; kind 7 on column 0 with hPlayerX $40; kind 8 on column
; 0 with hPlayerX $10 or $30; kind 9 on any screen column but 0, whatever hPlayerX. Every other case
; returns A = 0 (Z set). Only KeyWorldTalkEvents_WarubouInn calls it, to decide whether Warubou
; starts Script_WarubouWaHeyThat. (C2, E-0375)
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

SECTION "Bank 04 Talk_KeyWorldFloorBattle", ROMX

; Key world talk 3: starts Script_KeyWorldFloorBattle (StartScriptAtHL_B04: wScriptPointerLo/Hi,
; wScriptStartRequest = $80, wModeState = 1), the bank-$10 script that runs
; SCRIPT_KEY_WORLD_FLOOR_BATTLE. (C2, E-0375)
; starts Script_KeyWorldFloorBattle (StartScriptAtHL_B04) (E-0271; was Talk_KeyWorldFloorBattle)
; (E-0344: the address in its name dropped or read as the label there; was Talk_KeyWorldFloorBattle;
; named after the script it starts, Script_KeyWorldFloorBattle)
; starts Script_KeyWorldFloorBattle (E-0248)
Talk_KeyWorldFloorBattle::
    ld hl, Script_KeyWorldFloorBattle
    ASSERT BANK(Script_KeyWorldFloorBattle) == $10, "Script_KeyWorldFloorBattle is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 TalkMsg0120_WarubouQuitDawdlingWarooh", ROMX

; Key world talk 4: starts message $0120, 'Warubou: Quit dawdling, warooh!', through
; StartMessageCommand09HL_B04 (script command $09, wModeState = 1). (C2, E-0375)
; starts message $0120 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'Warubou Quit dawdling, warooh!' (E-0268, the E-0082 shape; was
; TalkMsg0120_WarubouQuitDawdlingWarooh)
TalkMsg0120_WarubouQuitDawdlingWarooh::
    ld hl, $0120 ; 'Warubou: Quit dawdling, warooh!'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 TalkMsg0122_WarubouWaheyYouDidItHero", ROMX

; Key world talk 5: starts message $0122, 'Warubou: Wa-hey! You did it, <PLAYER>!', through
; StartMessageCommand09HL_B04 (script command $09, wModeState = 1). (C2, E-0375)
; starts message $0122 through StartMessageCommand09HL_B04 (script command $09); that string begins
; 'Warubou Wa-hey! You did it, 0! I'll' (E-0268, the E-0082 shape; was
; TalkMsg0122_WarubouWaheyYouDidItHero)
TalkMsg0122_WarubouWaheyYouDidItHero::
    ld hl, $0122 ; 'Warubou: Wa-hey! You did it, 0!'
    call StartMessageCommand09HL_B04
    ret

SECTION "Bank 04 KeyWorldTalkEvents_ShowWarubouUseAMagic", ROMX

; Key world talk 6: Warubou's 'Use a magic ...' hint (message $0121), except for goal kinds 5, 7 and
; 8. (C2, E-0357; probed E-0375)
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

SECTION "Bank 04 Talk_WarubouWaheyYouDidItHero", ROMX

; Key world talk 7: sets wDataBank = $10 and starts Script_WarubouWaHeyYou_3 (StartScriptAtHL_B04),
; whose message is 'Warubou: Wa-hey! You did it, <PLAYER>!' and which jumps on to Script_It_3 in the
; data bank. (C2, E-0375)
; sets wDataBank = $10, then starts Script_WarubouWaHeyYou_3 (StartScriptAtHL_B04); its first
; message begins 'Warubou Wa-hey! You did it, 0!' (E-0271; was Talk_WarubouWaheyYouDidItHero)
; (E-0344: the address in its name dropped or read as the label there; was
; Talk_WarubouWaheyYouDidItHero; shortened from TalkScript_WarubouWaheyYouDidItHero)
; starts Script_WarubouWaHeyYou_3: 'Warubou: Wa-hey! You did it, 0!' (E-0248)
Talk_WarubouWaheyYouDidItHero::
    ld a, $10
    ld [wDataBank], a
    ld hl, Script_WarubouWaHeyYou_3 ; script 'Warubou: Wa-hey! You did it, 0!'
    ASSERT BANK(Script_WarubouWaHeyYou_3) == $10, "Script_WarubouWaHeyYou_3 is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 Talk_WarubouWaheySoThisIsIt", ROMX

; Key world talk 8: sets wDataBank = $1F and starts Script_WarubouWaHeySo (StartScriptAtHL_B04),
; whose first message is 'Warubou: Wa-hey! So, this is it?'. (C2, E-0375)
; sets wDataBank = $1F, then starts Script_WarubouWaHeySo (StartScriptAtHL_B04); its first message
; begins 'Warubou Wa-hey! So, this is it?' (E-0271; was Talk_WarubouWaheySoThisIsIt) (E-0344: the
; address in its name dropped or read as the label there; was Talk_WarubouWaheySoThisIsIt; shortened
; from TalkScript_WarubouWaheySoThisIsIt)
; starts Script_WarubouWaHeySo: 'Warubou: Wa-hey! So, this is it?' (E-0248)
Talk_WarubouWaheySoThisIsIt::
    ld a, $1f
    ld [wDataBank], a
    ld hl, Script_WarubouWaHeySo ; script 'Warubou: Wa-hey! So, this is it?'
    ASSERT BANK(Script_WarubouWaHeySo) == $10, "Script_WarubouWaHeySo is read with bank $10 mapped"
    call StartScriptAtHL_B04
    ret

SECTION "Bank 04 InventoryHasFreeSlotCheck", ROMX

; Looks for a free inventory slot: when the last slot (wInventory + $17) holds an item (neither $FF
; nor 0) it returns A = 0 with carry clear (the inventory is full). Otherwise it scans wInventory
; from the start and returns carry set with HL = the first slot holding $FF or 0 (A = that byte).
; Six item givers of this bank call it and store their item at HL when carry is set (the Yold
; treasure YoldTalkEvents_ShowHeroCheckedTheTreasure and Talk07BF_HeroFoundThePretty among them).
; (C2, E-0375)
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
