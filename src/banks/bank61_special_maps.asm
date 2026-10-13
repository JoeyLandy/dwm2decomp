; ROM bank $61: special maps, warps and map loading
; The annotated listing of this bank is build/listing/bank61.asm.

SECTION "Bank 61", ROMX[$4000], BANK[$61]
    db $61

; wPartyStrength = a strength value from the party's stats (AGL and INT halved, ATK, DEF, max HP), 0
; without a party (E-0130)
ComputePartyStrengthLevelPartyStrength::
    ld a, [wPartyCount]
    or a
    jr nz, .skip
    xor a
    ld [wPartyStrength], a
    ret

.skip:
    ld b, a
    ld hl, $0000
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    ld hl, wPartyList
    ld a, $0a
    ld [rRAMG], a

.loop:
    push bc
    push hl
    ld a, [hl]
    push af
    ld c, MON_AGL
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    pop af
    push af
    ld c, MON_INT
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    add hl, de
    sra h
    rr l
    pop af
    push af
    ld c, MON_ATK
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    add hl, de
    pop af
    push af
    ld c, MON_DEF
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    add hl, de
    pop af
    push af
    ld c, MON_MAX_HP
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    add hl, de
    pop af
    push af
    ld c, MON_MAX_MP
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    add hl, de
    pop af
    ld a, $19
    call DivideHLByA
    ldh a, [hTemp4]
    ld e, a
    ldh a, [hTemp5]
    ld d, a
    add hl, de
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    pop hl
    inc hl
    pop bc
    dec b
    jp nz, .loop
    xor a
    ld [rRAMG], a
    ldh a, [hTemp4]
    ld l, a
    ldh a, [hTemp5]
    ld h, a
    ld a, [wPartyCount]
    call DivideHLByA
    ld a, h
    or a
    jr nz, .set_party_strength_to_63
    ld a, l
    cp $63
    jr c, .set_party_strength

.set_party_strength_to_63:
    ld a, $63
    ld [wPartyStrength], a
    ret

.set_party_strength:
    ld [wPartyStrength], a
    ret

; computes the party strength from AGL + INT, ATK, DEF and max HP of each member into hTemp4-hTemp7
; and wPartyStrength for key generation (E-0131)
ComputePartyStrengthForKey::
    ld a, [wPartyCount]
    or a
    jr nz, .skip
    xor a
    ld [wPartyStrength], a
    ret

.skip:
    ld b, a
    ld hl, $0000
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    ld a, l
    ldh [hTemp6], a
    ld a, h
    ldh [hTemp7], a
    ld hl, wPartyList
    ld a, $0a
    ld [rRAMG], a

.loop:
    push bc
    push hl
    ld a, [hl]
    push af
    ld c, MON_AGL
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    pop af
    push af
    ld c, MON_INT
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    add hl, de
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    sra h
    rr l
    pop af
    push af
    ld c, MON_ATK
    call LoadSRAMRecordWord
    push hl
    ldh a, [hTemp2]
    ld l, a
    ldh a, [hTemp3]
    ld h, a
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    add hl, de
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    pop hl
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    add hl, de
    pop af
    push af
    ld c, MON_DEF
    call LoadSRAMRecordWord
    push hl
    ldh a, [hTemp2]
    ld l, a
    ldh a, [hTemp3]
    ld h, a
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    add hl, de
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    pop hl
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    add hl, de
    pop af
    push af
    ld c, MON_MAX_HP
    call LoadSRAMRecordWord
    push hl
    ldh a, [hTemp2]
    ld l, a
    ldh a, [hTemp3]
    ld h, a
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    add hl, de
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    pop hl
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    add hl, de
    pop af
    push af
    ld c, MON_MAX_MP
    call LoadSRAMRecordWord
    push hl
    ldh a, [hTemp2]
    ld l, a
    ldh a, [hTemp3]
    ld h, a
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    add hl, de
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    pop hl
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    add hl, de
    ld a, $32
    call DivideHLByA
    ldh a, [hTemp4]
    ld e, a
    ldh a, [hTemp5]
    ld d, a
    add hl, de
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    pop af
    push af
    ld c, MON_LEVEL
    call LoadSRAMRecordByte
    push bc
    ldh a, [hTemp0]
    ld c, $18
    call Multiply8
    ld e, l
    ld d, h
    pop bc
    ldh a, [hTemp2]
    ld l, a
    ldh a, [hTemp3]
    ld h, a
    ld a, l
    sub e
    ld l, a
    ld a, h
    sbc d
    ld h, a
    ld a, h
    bit 7, a
    jr z, .call_divide_hl_by_a
    ld hl, $0000
    jr .read_temp6

.call_divide_hl_by_a:
    ld a, $32
    call DivideHLByA

.read_temp6:
    ldh a, [hTemp6]
    ld e, a
    ldh a, [hTemp7]
    ld d, a
    add hl, de
    ld a, l
    ldh [hTemp6], a
    ld a, h
    ldh [hTemp7], a
    pop af
    pop hl
    inc hl
    pop bc
    dec b
    jp nz, .loop
    xor a
    ld [rRAMG], a
    ldh a, [hTemp4]
    ld l, a
    ldh a, [hTemp5]
    ld h, a
    ldh a, [hTemp6]
    ld e, a
    ldh a, [hTemp7]
    ld d, a
    add hl, de
    bit 7, h
    jr z, .read_party_count
    xor a
    ld [wPartyStrength], a
    ret

.read_party_count:
    ld a, [wPartyCount]
    call DivideHLByA
    ld a, l
    cp $63
    jr c, .set_party_strength
    ld a, $63
    ld [wPartyStrength], a
    ret

.set_party_strength:
    ld [wPartyStrength], a
    ret

; runs the routine for wMapType & 7 (jump table; 4 reuses 3) (E-0122)
LoadMapHeaderByMapType::
    ld a, [wMapType]
    and $07
    jumptable
    dw LoadKeyWorldTilesetAndHeader
    dw LoadMapHeaderByMapType_DecompressToVRAM
    dw LoadMapHeaderByMapType_LoadSpecialMapHeader_Case02
    dw LoadMapHeaderByMapType_LoadSpecialMapHeader_Case03
    dw LoadMapHeaderByMapType_LoadSpecialMapHeader_Case03
    dw LoadMapType5TilesetAndHeader
    dw LoadMapHeaderByMapType_WriteTemp0
    dw LoadMapHeaderByMapType_LoadSpecialMapHeader

LoadMapHeaderByMapType_LoadSpecialMapHeader::
    ld a, $66
    ldh [hTemp0], a
    call LoadSpecialMapHeader
    ret

LoadMapHeaderByMapType_WriteTemp0::
    ld a, [wKeyWorldFloor]
    sla a
    sla a
    push af
    ld hl, wKeyWorldFloorInfo + $1
    add_a_to_hl
    ld a, [hl]
    dec a
    dec a
    dec a
    inc a
    and $01
    ldh [hTemp0], a
    pop af
    ld hl, wKeyWorldFloorState + $3
    ld a, [wKeyWorldFloor]
    swap a
    add_a_to_hl
    ld a, [hl]
    and $01
    add a
    ld c, a
    ldh a, [hTemp0]
    add $50
    ldh [hTemp0], a
    call LoadSpecialMapHeader
    ret

; map type 5 (wMapType & 7 = 5): takes byte 2 of the floor's wKeyWorldFloorState entry as the index
; into MapType5TilesetTable (MapType5TilesetTable, 6 bytes each), decompresses its tiles to vTiles2,
; on CGB copies its $40-byte palettes to wBGPaletteBuffer and requests the upload, then sets a 4 x
; 4-screen map, wMaxBlockingTile = $3F and other map-header bytes (E-0140)
LoadMapType5TilesetAndHeader::
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState + $2
    add_a_to_hl
    ld a, [hl]
    push af
    ld c, a
    sla a
    add c
    sla a
    ld hl, MapType5TilesetTable
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [hli]
    ld b, a
    push hl
    ld hl, vTiles2
    call DecompressToVRAM
    pop hl
    ld a, [wIsCGB]
    or a
    jr z, .set_map_width_screens_to_04
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [hli]
    ld b, a
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBank
    ld a, $7f
    ld [wBGPaletteUploadRequest], a

.set_map_width_screens_to_04:
    ld a, $04
    ld [wMapWidthScreens], a
    ld [wMapHeightScreens], a
    ld a, $3f
    ld [wMaxBlockingTile], a
    xor a
    ld [wFieldEventKind], a
    ld a, $10
    ld [wMapSpriteKind], a
    ld a, $2a
    ld [wMapHeaderByte11], a
    xor a
    ld [wMapTallTileMin], a
    ld a, $a3
    ld [wEncounterRate], a
    pop af
    cp $07
    jr z, .set_map_move_type_to_05
    cp $09
    jr z, .set_map_move_type_to_05
    xor a
    ld [wMapMoveType], a
    ret

.set_map_move_type_to_05:
    ld a, $05
    ld [wMapMoveType], a
    ret

; LoadMapType5TilesetAndHeader indexes it with 6 * byte 2 of the floor's wKeyWorldFloorState entry,
; decompresses the first far pointer to vTiles2 and, on CGB, copies $40 bytes from the second to
; wBGPaletteBuffer; entries 0-11 decode to 2048-byte tile sets with 15-bit palettes, entry 12 onward
; is not a valid record (E-0140, C1)
; record: compressed BG tiles decompressed to vTiles2 (128 tiles); ROM bank of the tiles; $40-byte
; CGB BG palette set copied to wBGPaletteBuffer; ROM bank of the palettes
MapType5TilesetTable::
    dfar MapType5Tiles0 ; id 0: compressed BG tiles decompressed to vTiles2 (128 tiles)
    dfar MapType5Palettes0 ; $40-byte CGB BG palette set copied to wBGPaletteBuffer
    dfar MapType5Tiles1 ; id 1: compressed BG tiles decompressed to vTiles2 (128 tiles)
    dfar MapType5Palettes1 ; $40-byte CGB BG palette set copied to wBGPaletteBuffer
    dfar MapType5Tiles2 ; id 2: compressed BG tiles decompressed to vTiles2 (128 tiles)
    dfar MapType5Palettes2 ; $40-byte CGB BG palette set copied to wBGPaletteBuffer
    dfar MapType5Tiles3 ; id 3: compressed BG tiles decompressed to vTiles2 (128 tiles)
    dfar MapType5Palettes3 ; $40-byte CGB BG palette set copied to wBGPaletteBuffer
    dfar MapType5Tiles4 ; id 4: compressed BG tiles decompressed to vTiles2 (128 tiles)
    dfar MapType5Palettes4 ; $40-byte CGB BG palette set copied to wBGPaletteBuffer
    dfar MapType5Tiles5 ; id 5: compressed BG tiles decompressed to vTiles2 (128 tiles)
    dfar MapType5Palettes5 ; $40-byte CGB BG palette set copied to wBGPaletteBuffer
    dfar MapType5Tiles6 ; id 6: compressed BG tiles decompressed to vTiles2 (128 tiles)
    dfar MapType5Palettes6 ; $40-byte CGB BG palette set copied to wBGPaletteBuffer
    dfar MapType5Tiles7 ; id 7: compressed BG tiles decompressed to vTiles2 (128 tiles)
    dfar MapType5Palettes7 ; $40-byte CGB BG palette set copied to wBGPaletteBuffer
    dfar MapType5Tiles8 ; id 8: compressed BG tiles decompressed to vTiles2 (128 tiles)
    dfar MapType5Palettes8 ; $40-byte CGB BG palette set copied to wBGPaletteBuffer
    dfar MapType5Tiles9 ; id 9: compressed BG tiles decompressed to vTiles2 (128 tiles)
    dfar MapType5Palettes9 ; $40-byte CGB BG palette set copied to wBGPaletteBuffer
    dfar MapType5Tiles10 ; id 10: compressed BG tiles decompressed to vTiles2 (128 tiles)
    dfar MapType5Palettes10 ; $40-byte CGB BG palette set copied to wBGPaletteBuffer
    dfar MapType5Tiles11 ; id 11: compressed BG tiles decompressed to vTiles2 (128 tiles)
    dfar MapType5Palettes11 ; $40-byte CGB BG palette set copied to wBGPaletteBuffer

LoadMapHeaderByMapType_DecompressToVRAM::
    ld de, MapType5Tiles5
    ld b, $6e
    ld hl, vTiles2
    call DecompressToVRAM
    ld a, [wIsCGB]
    or a
    jr z, .set_max_blocking_tile_to_3F
    ld de, BGPaletteBufferData_6E_77E0
    ld b, $6e
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBank
    ld a, $7f
    ld [wBGPaletteUploadRequest], a

.set_max_blocking_tile_to_3F:
    ld a, $3f
    ld [wMaxBlockingTile], a
    xor a
    ld [wFieldEventKind], a
    ld [wMapSpriteKind], a
    ld [wMapTallTileMin], a
    ld hl, wKeyWorldObjects
    ld a, [wKeyWorldFloor]
    sla a
    sla a
    add_a_to_hl
    ld a, [hl]
    and $0f
    dec a
    sla a
    sla a
    sla a
    ld e, a
    ld d, $00
    ld a, [hl]
    swap a
    and $0f
    dec a
    sla a
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, e
    add $05
    ld e, a
    ld a, d
    adc $67
    ld d, a
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [hli]
    ld [wMapWidthScreens], a
    ld a, [hl]
    ld [wMapHeightScreens], a
    ld a, $a3
    ld [wEncounterRate], a
    xor a
    ld [wMapMoveType], a
    ret

LoadMapHeaderByMapType_LoadSpecialMapHeader_Case02::
    ld a, $61
    ldh [hTemp0], a
    ld a, [wKeyWorldFloor]
    bit 7, a
    jr z, .read_temp0
    ld hl, hTemp0
    inc [hl]

.read_temp0:
    ldh a, [hTemp0]
    sub $61
    ld [wKeyWorldByte06], a
    call LoadSpecialMapHeader
    ret

LoadMapHeaderByMapType_LoadSpecialMapHeader_Case03::
    ld hl, wKeyWorldFloorState
    ld a, [wKeyWorldFloor]
    swap a
    add_a_to_hl
    ld a, [hl]
    and $7f
    ldh [hTemp0], a
    call LoadSpecialMapHeader
    ret

; map type 0 (wMapType & 7 = 0): decompresses entry wKeyWorldGoalKind of KeyWorldTilesetTable
; (KeyWorldTilesetTable, 6 bytes each) to vTiles2, on CGB copies its $40-byte palette set to
; wBGPaletteBuffer and requests the upload, then sets wMaxBlockingTile = $3D, wFieldEventKind,
; wEncounterRate and other map-header bytes (E-0139)
LoadKeyWorldTilesetAndHeader::
    ld a, [wKeyWorldGoalKind]
    ld c, a
    sla a
    add c
    sla a
    ld l, a
    ld h, $00
    ld a, l
    add $28
    ld l, a
    ld a, h
    adc $57
    ld h, a
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [hli]
    ld b, a
    push hl
    ld hl, vTiles2
    call DecompressToVRAM
    pop hl
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [hli]
    ld b, a
    ld a, [wIsCGB]
    or a
    jr z, .set_max_blocking_tile_to_3D
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBank
    ld a, $7f
    ld [wBGPaletteUploadRequest], a

.set_max_blocking_tile_to_3D:
    ld a, $3d
    ld [wMaxBlockingTile], a
    ld a, [wKeyWorldGoalKind]
    cp $04
    jr z, .clear_field_event_kind
    ld a, $02
    ld [wFieldEventKind], a
    jr .set_encounter_rate_to_A2

.clear_field_event_kind:
    xor a
    ld [wFieldEventKind], a

.set_encounter_rate_to_A2:
    ld a, $a2
    ld [wEncounterRate], a
    ld a, [wKeyWorldGoalKind]
    cp $01
    jr z, .set_map_move_type_to_04
    cp $07
    jr z, .set_map_move_type_to_04
    xor a
    ld [wMapMoveType], a
    jr .clear_map_tall_tile_min

.set_map_move_type_to_04:
    ld a, $04
    ld [wMapMoveType], a

.clear_map_tall_tile_min:
    xor a
    ld [wMapTallTileMin], a
    ld [wMapHeaderByte11], a
    ld a, [wKeyWorldGoalKind]
    ld hl, LoadKeyWorldTilesetAndHeader_Data
    add_a_to_hl
    ld a, [hl]
    ld [wMapSpriteKind], a
    and $0f
    jr z, .check_map_sprite_kind
    ld a, $29
    ld [wMapTallTileMin], a

.check_map_sprite_kind:
    ld a, [wMapSpriteKind]
    and $f0
    jr z, .return
    ld a, $2c
    ld [wMapHeaderByte11], a

.return:
    ret

LoadKeyWorldTilesetAndHeader_Data::
    db $11, $11, $21, $11, $12, $12, $11, $11, $11, $31

LoadMapScreen_ReadMapType::
    ld a, [wMapType]
    and $07
    jumptable
    dw LoadMapScreen_Sub03_WriteSVBK
    dw LoadMapScreen_Sub03_Return
    dw LoadMapScreen_Sub03_LoadMapScreenFromChunk_Case02
    dw LoadMapScreen_Sub03_LoadMapScreenFromChunk_Case03
    dw LoadMapScreen_Sub03_LoadMapScreenFromChunk_Case03
    dw LoadMapScreen_Sub03_WriteTemp0AndSVBK
    dw LoadMapScreen_Sub03_WriteTemp0
    dw LoadMapScreen_Sub03_LoadMapScreenFromChunk

LoadMapScreen_Sub03_LoadMapScreenFromChunk::
    ld a, $66
    ldh [hTemp0], a
    call LoadMapScreenFromChunk
    ret

LoadMapScreen_Sub03_WriteTemp0::
    ld a, [wKeyWorldFloor]
    sla a
    sla a
    push af
    ld hl, wKeyWorldFloorInfo + $1
    add_a_to_hl
    ld a, [hl]
    dec a
    dec a
    dec a
    dec a
    and $01
    ldh [hTemp0], a
    pop af
    ld hl, wKeyWorldFloorState + $3
    ld a, [wKeyWorldFloor]
    swap a
    add_a_to_hl
    ld a, [hl]
    push hl
    cp $ff
    jr nz, .skip
    ld a, $00

.skip:
    dec a
    and $01
    sla a
    ld c, a
    ldh a, [hTemp0]
    add $50
    ldh [hTemp0], a
    call LoadMapScreenFromChunk
    pop hl
    ld a, [hl]
    cp $ff
    jr z, .call_draw_door_tiles_for_key_world_floor
    and $01
    ret z

.call_draw_door_tiles_for_key_world_floor:
    call DrawDoorTilesForKeyWorldFloor
    ret

; writes a 2 x 2 tile block ($1A or $1C by the wKeyWorldFloorState + $3 entry, then $1E) at
; wScreenTileBuffer + $AC, with CGB attribute 5 (E-0127)
DrawDoorTilesForKeyWorldFloor::
    ld a, [wKeyWorldFloor]
    swap a
    ld de, wKeyWorldFloorState + $3
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld c, $1a
    ld a, [de]
    cp $ff
    jr nz, .skip2
    ld c, $1c

.skip2:
    ld hl, wScreenTileBuffer + $ac
    push hl
    ld a, c
    ld [hli], a
    inc a
    ld [hld], a
    ld a, $14
    add_a_to_hl
    ld a, $1e
    ld [hli], a
    inc a
    ld [hl], a
    pop hl
    ld a, [wIsCGB]
    or a
    ret z
    ld a, $02
    ldh [rSVBK], a
    ld a, l
    sub $98
    ld l, a
    ld a, h
    sbc $c1
    ld h, a
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $d0
    ld h, a
    ld a, $05
    ld [hli], a
    ld [hld], a
    ld a, $14
    add_a_to_hl
    ld a, $05
    ld [hli], a
    ld [hl], a
    ld a, $00
    ldh [rSVBK], a
    ret

LoadMapScreen_Sub03_WriteTemp0AndSVBK::
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState + $1
    add_a_to_hl
    ld a, [hl]
    add a
    ld e, a
    ld d, $00
    ld a, [wKeyWorldArea]
    add a
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, e
    add $2c
    ld e, a
    ld a, d
    adc $ce
    ld d, a
    ld a, [de]
    ldh [hTemp0], a
    ld e, a
    ld d, $00
    sla e
    rl d
    ld a, e
    add $01
    ld e, a
    ld a, d
    adc $40
    ld d, a
    ld b, $72
    call ReadByteInBank
    ld l, c
    inc de
    call ReadByteInBank
    ld h, c
    inc hl
    inc hl
    inc hl
    ldh a, [hMapScreenY]
    ld c, a
    sla a
    add c
    sla a
    sla a
    add_a_to_hl
    ldh a, [hMapScreenX]
    ld c, a
    sla a
    add c
    add_a_to_hl
    push hl
    push bc
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
    ld e, l
    ld d, h
    ld hl, wScreenTileBuffer
    call DecompressToVRAM
    pop bc
    pop hl
    ld a, [wIsCGB]
    or a
    jr z, .call_draw_key_world_exit_tile
    ld a, l
    add $30
    ld l, a
    ld a, h
    adc $00
    ld h, a
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
    ld a, $02
    ldh [rSVBK], a
    ld hl, wScreenAttrBuffer
    call DecompressToVRAM
    ld a, $00
    ldh [rSVBK], a

.call_draw_key_world_exit_tile:
    call DrawKeyWorldExitTile
    call CheckTwoWCDB0EntriesForKeyWorldArea
    ret

; for the two wKeyWorldFloorState + $4 entries of wKeyWorldFloor matching wKeyWorldArea runs
; CheckTwoWCDB0EntriesForKeyWorldArea_WriteSVBK with C = $80 or the stored value (E-0127)
CheckTwoWCDB0EntriesForKeyWorldArea::
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState + $4
    add_a_to_hl
    push hl
    ld a, [hl]
    ld b, a
    ld a, [wKeyWorldArea]
    cp b
    jr nz, .restore
    inc hl
    inc hl
    ld a, [hli]
    ld b, a
    ld a, [hl]
    or a
    jr z, .next
    ld c, $80
    jr .call_check_two_wcdb0_entries_for_key_world

.next:
    dec hl
    dec hl
    ld a, [hl]
    ld c, a

.call_check_two_wcdb0_entries_for_key_world:
    push hl
    call CheckTwoWCDB0EntriesForKeyWorldArea_WriteSVBK
    pop hl

.restore:
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    ld b, a
    ld a, [wKeyWorldArea]
    cp b
    ret nz
    inc hl
    inc hl
    ld a, [hli]
    ld b, a
    ld a, [hl]
    or a
    jr z, .next2
    ld c, $80
    jr CheckTwoWCDB0EntriesForKeyWorldArea_WriteSVBK

.next2:
    dec hl
    dec hl
    ld a, [hl]
    ld c, a

CheckTwoWCDB0EntriesForKeyWorldArea_WriteSVBK::
    ld a, b
    ld hl, KeyWorldEntryScreenXY
    add_a_to_hl
    ld a, [hl]
    ld e, a
    ldh a, [hMapScreenX]
    swap a
    ld d, a
    ldh a, [hMapScreenY]
    or d
    cp e
    ret nz
    bit 7, c
    jr nz, .read_key_world_floor
    ld a, $2c
    jr .read_key_world_floor2

.read_key_world_floor:
    ld a, $2e

.read_key_world_floor2:
    push af
    ld a, [wKeyWorldFloor]
    swap a
    ld de, wKeyWorldFloorState + $1
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    add a
    ld e, a
    ld d, $00
    ld a, [wKeyWorldArea]
    add a
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, e
    add $2c
    ld e, a
    ld a, d
    adc $ce
    ld d, a
    ld a, [de]
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
    ld a, b
    sla a
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, e
    add $19
    ld e, a
    ld a, d
    adc $48
    ld d, a
    ld a, [de]
    push de
    ld l, a
    ld h, $00
    ld e, l
    ld d, h
    add hl, hl
    add hl, hl
    add hl, de
    add hl, hl
    add hl, hl
    add hl, hl
    pop de
    dec de
    ld a, [de]
    sla a
    add_a_to_hl
    ld a, l
    add $98
    ld l, a
    ld a, h
    adc $c1
    ld h, a
    pop af
    push hl
    ld [hli], a
    inc a
    ld [hld], a
    push af
    ld a, $14
    add_a_to_hl
    pop af
    add $0f
    ld [hli], a
    inc a
    ld [hl], a
    pop hl
    ld a, [wIsCGB]
    or a
    ret z
    ld a, $02
    ldh [rSVBK], a
    ld a, l
    sub $98
    ld l, a
    ld a, h
    sbc $c1
    ld h, a
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $d0
    ld h, a
    ld a, [hl]
    and $f8
    or $06
    ld [hli], a
    ld a, [hl]
    and $f8
    or $06
    ld [hld], a
    ld a, $14
    add_a_to_hl
    ld a, [hl]
    and $f8
    or $06
    ld [hli], a
    ld a, [hl]
    and $f8
    or $06
    ld [hld], a
    ld a, $00
    ldh [rSVBK], a
    ret

; hTemp0 = the two nibbles at $4818 + 16 * [$CE2C + 2 * wKeyWorldFloorState + $1[16 *
; wKeyWorldFloor] + 2 * wKeyWorldArea] + 2 * hTemp0, packed into one byte (E-0121)
LookupKeyWorldScreenSpotRecordsNibblePairForTemp0::
    push hl
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState + $1
    add_a_to_hl
    ld a, [hl]
    add a
    ld l, a
    ld h, $00
    ld a, [wKeyWorldArea]
    add a
    add_a_to_hl
    ld a, l
    add $2c
    ld l, a
    ld a, h
    adc $ce
    ld h, a
    ld a, [hl]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ldh a, [hTemp0]
    add a
    add_a_to_hl
    ld a, l
    add $18
    ld l, a
    ld a, h
    adc $48
    ld h, a
    ld a, [hli]
    swap a
    ld c, a
    ld a, [hl]
    or c
    ldh [hTemp0], a
    pop hl
    ret

; draws the exit or stairs tile block for the current screen when it matches the area entry in
; wKeyWorldRoomTable + $1 (E-0130)
DrawKeyWorldExitTile::
    ld a, [wKeyWorldFloor]
    add a
    add a
    push af
    ld hl, wKeyWorldFloorInfo + $1
    add_a_to_hl
    ld a, [hl]
    ldh [hTemp0], a
    pop af
    add a
    add a
    ld hl, wKeyWorldFloorState + $1
    add_a_to_hl
    ld a, [hl]
    add a
    ld hl, wKeyWorldRoomTable + $1
    add_a_to_hl
    ld a, [wKeyWorldArea]
    add a
    add_a_to_hl
    ldh a, [hMapScreenX]
    and $0f
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    and $0f
    or c
    ld c, a
    ld a, [hl]
    and $0f
    cp $0f
    jr z, .skip2
    ld de, DrawKeyWorldExitTile_Data
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    cp c
    jr z, .check_temp0

.skip2:
    ld a, [hl]
    swap a
    and $0f
    ld de, DrawKeyWorldExitTile_Data
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, [de]
    cp c
    jr z, .check_temp02
    ret

.check_temp0:
    ldh a, [hTemp0]
    dec a
    dec a
    dec a
    dec a
    sla a
    add $46
    jr .skip4

.check_temp02:
    ldh a, [hTemp0]
    dec a
    dec a
    dec a
    dec a
    sla a
    ld c, a
    ld a, $48
    sub c

.skip4:
    ld hl, wScreenTileBuffer + $a8
    ld [hli], a
    inc a
    ld [hld], a
    push af
    ld a, l
    add $14
    ld l, a
    ld a, h
    adc $00
    ld h, a
    pop af
    add $0f
    ld [hli], a
    inc a
    ld [hld], a
    ld a, [wIsCGB]
    or a
    ret z
    ld a, $02
    ldh [rSVBK], a
    ld hl, wWorkBuf + $b
    ld a, [hl]
    and $f8
    or $04
    ld [hli], a
    ld a, [hl]
    and $f8
    or $04
    ld [hld], a
    ld a, $14
    add_a_to_hl
    ld a, [hl]
    and $f8
    or $04
    ld [hli], a
    ld a, [hl]
    and $f8
    or $04
    ld [hld], a
    ld a, $00
    ldh [rSVBK], a
    ret

DrawKeyWorldExitTile_Data::
    db $00, $30, $11, $22, $03, $33

; CheckTwoWCDB0EntriesForKeyWorldArea_Sub01 reads the byte at $4810 + B (B from the floor state
; entry) and continues only when it equals hMapScreenX/Y packed as nibbles (E-0195, C1)
; record: screen X (high nibble) / Y (low nibble)
KeyWorldEntryScreenXY::
    db $01 ; id 0
    db $10 ; id 1
    db $12 ; id 2
    db $13 ; id 3
    db $20 ; id 4
    db $21 ; id 5
    db $23 ; id 6
    db $32 ; id 7

; LookupKeyWorldScreenSpotRecordsNibblePairForTemp0 reads the pair at $4818 + 16 * [$CE2C + 2 *
; floor state byte 1 + 2 * wKeyWorldArea] + 2 * hTemp0 and packs it into one byte of nibbles;
; CheckTwoWCDB0EntriesForKeyWorldArea_WriteSVBK reads byte $4819 + 16 * n + 2 * B the same way; 192
; records end at the code at $5418 (E-0195, C1)
; record: eight spots as (X, Y) byte pairs; all-zero records are unused
KeyWorldScreenSpotRecords::
    db $04, $04, $05, $01, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 0
    db $04, $04, $05, $01, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 1
    db $04, $02, $08, $03, $04, $04, $05, $04, $04, $05, $01, $02, $02, $02, $02, $01 ; id 2
    db $04, $04, $05, $01, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 3
    db $04, $04, $05, $01, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 4
    db $02, $05, $04, $05, $04, $02, $06, $05, $05, $05, $04, $04, $02, $02, $06, $05 ; id 5
    db $04, $04, $04, $04, $05, $04, $02, $03, $04, $04, $04, $03, $04, $04, $03, $02 ; id 6
    db $04, $04, $05, $01, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 7
    db $04, $04, $03, $05, $04, $04, $06, $04, $04, $03, $05, $06, $04, $02, $07, $05 ; id 8
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 9
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 10
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 11
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 12
    db $03, $03, $03, $02, $02, $06, $07, $02, $03, $02, $02, $03, $06, $06, $05, $05 ; id 13
    db $01, $04, $04, $04, $04, $04, $04, $07, $04, $04, $07, $03, $04, $04, $04, $04 ; id 14
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 15
    db $05, $03, $05, $04, $04, $03, $06, $06, $02, $03, $03, $05, $05, $04, $04, $02 ; id 16
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $01, $04, $04, $04, $04, $04, $04 ; id 17
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $01, $04, $04, $04, $04, $04, $04 ; id 18
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $01, $04, $04, $04, $04, $04, $04 ; id 19
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $01, $04, $04, $04, $04, $04, $04 ; id 20
    db $02, $07, $07, $03, $06, $02, $07, $04, $02, $06, $02, $06, $06, $07, $05, $02 ; id 21
    db $04, $04, $04, $04, $01, $04, $01, $05, $06, $05, $04, $04, $04, $04, $04, $04 ; id 22
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $01, $04, $04, $04, $04, $04, $04 ; id 23
    db $02, $06, $06, $02, $04, $04, $04, $03, $07, $05, $04, $04, $04, $04, $07, $05 ; id 24
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $07, $05 ; id 25
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $07, $05 ; id 26
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $07, $05 ; id 27
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $07, $05 ; id 28
    db $04, $05, $05, $05, $04, $05, $03, $04, $07, $06, $02, $02, $08, $03, $06, $03 ; id 29
    db $04, $04, $05, $03, $06, $07, $04, $04, $04, $04, $04, $07, $04, $04, $04, $04 ; id 30
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $07, $05 ; id 31
    db $05, $07, $04, $03, $03, $03, $04, $04, $06, $02, $04, $03, $06, $04, $01, $03 ; id 32
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 33
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 34
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 35
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 36
    db $07, $06, $05, $02, $06, $03, $04, $02, $08, $02, $03, $03, $01, $02, $07, $04 ; id 37
    db $04, $04, $04, $04, $08, $02, $04, $04, $04, $04, $02, $07, $04, $04, $04, $04 ; id 38
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 39
    db $08, $05, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 40
    db $02, $05, $03, $05, $02, $02, $05, $06, $07, $03, $07, $04, $04, $03, $03, $02 ; id 41
    db $08, $05, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 42
    db $08, $05, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 43
    db $08, $05, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 44
    db $04, $07, $01, $03, $08, $06, $01, $05, $07, $03, $06, $02, $04, $04, $04, $06 ; id 45
    db $04, $04, $04, $07, $04, $04, $04, $04, $05, $04, $06, $03, $04, $04, $05, $07 ; id 46
    db $08, $05, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 47
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 48
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 49
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 50
    db $01, $06, $07, $06, $07, $02, $01, $05, $05, $06, $01, $07, $01, $03, $07, $06 ; id 51
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 52
    db $05, $01, $03, $03, $04, $02, $08, $03, $06, $02, $05, $07, $03, $05, $03, $03 ; id 53
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $06, $06, $04, $04, $04, $04 ; id 54
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 55
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 56
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 57
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 58
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 59
    db $07, $03, $07, $02, $03, $05, $04, $04, $05, $04, $05, $05, $04, $03, $01, $06 ; id 60
    db $07, $06, $02, $04, $05, $06, $07, $02, $01, $02, $07, $03, $08, $03, $05, $03 ; id 61
    db $04, $04, $04, $04, $04, $04, $04, $04, $02, $04, $04, $04, $04, $04, $03, $03 ; id 62
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 63
    db $07, $05, $04, $05, $04, $06, $06, $07, $02, $05, $05, $05, $05, $04, $04, $05 ; id 64
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $07, $03 ; id 65
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $07, $03 ; id 66
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $07, $03 ; id 67
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $07, $03 ; id 68
    db $01, $07, $05, $05, $03, $03, $05, $06, $07, $07, $02, $05, $03, $07, $05, $02 ; id 69
    db $04, $04, $03, $01, $05, $05, $06, $04, $03, $03, $01, $07, $04, $07, $04, $04 ; id 70
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $07, $03 ; id 71
    db $04, $04, $04, $02, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 72
    db $01, $05, $02, $07, $01, $02, $08, $04, $06, $07, $04, $02, $05, $03, $02, $03 ; id 73
    db $04, $04, $04, $02, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 74
    db $04, $04, $04, $02, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 75
    db $04, $04, $04, $02, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 76
    db $01, $06, $07, $04, $03, $07, $03, $07, $05, $07, $02, $04, $03, $05, $05, $05 ; id 77
    db $04, $04, $08, $01, $06, $06, $04, $04, $04, $04, $04, $04, $04, $04, $06, $04 ; id 78
    db $04, $04, $04, $02, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 79
    db $04, $07, $04, $04, $06, $03, $04, $04, $01, $06, $05, $06, $07, $04, $05, $06 ; id 80
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $05, $06, $03, $04, $04, $04, $04 ; id 81
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $05, $06, $03, $04, $04, $04, $04 ; id 82
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $05, $06, $03, $04, $04, $04, $04 ; id 83
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $05, $06, $03, $04, $04, $04, $04 ; id 84
    db $04, $04, $05, $06, $03, $04, $07, $03, $02, $03, $06, $04, $03, $03, $06, $07 ; id 85
    db $04, $04, $04, $04, $03, $04, $04, $04, $04, $04, $04, $03, $04, $04, $04, $04 ; id 86
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $05, $06, $03, $04, $04, $04, $04 ; id 87
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $05, $08, $03, $04, $04, $04, $04 ; id 88
    db $08, $02, $05, $06, $03, $05, $07, $04, $08, $03, $06, $03, $06, $04, $07, $04 ; id 89
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $05, $08, $03, $04, $04, $04, $04 ; id 90
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $05, $08, $03, $04, $04, $04, $04 ; id 91
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $05, $08, $03, $04, $04, $04, $04 ; id 92
    db $03, $04, $08, $02, $07, $07, $05, $05, $03, $03, $07, $02, $06, $04, $05, $03 ; id 93
    db $05, $07, $07, $03, $05, $03, $04, $04, $04, $04, $04, $05, $04, $04, $04, $04 ; id 94
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $05, $08, $03, $04, $04, $04, $04 ; id 95
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 96
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 97
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 98
    db $07, $05, $02, $05, $05, $06, $05, $02, $07, $06, $01, $05, $05, $03, $02, $03 ; id 99
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 100
    db $06, $03, $06, $03, $06, $03, $02, $06, $02, $05, $01, $07, $02, $02, $04, $06 ; id 101
    db $04, $04, $05, $03, $04, $04, $01, $06, $04, $04, $06, $02, $04, $04, $08, $06 ; id 102
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 103
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 104
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 105
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 106
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 107
    db $07, $06, $02, $02, $07, $03, $04, $02, $06, $06, $03, $04, $07, $04, $04, $06 ; id 108
    db $03, $03, $01, $06, $07, $05, $01, $03, $04, $02, $01, $02, $07, $03, $03, $05 ; id 109
    db $03, $02, $04, $04, $06, $05, $04, $04, $02, $06, $06, $03, $07, $02, $04, $04 ; id 110
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 111
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $05, $02, $04, $04, $08, $05 ; id 112
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $05, $02, $04, $04, $08, $05 ; id 113
    db $06, $03, $07, $04, $04, $03, $05, $04, $03, $07, $04, $03, $02, $03, $01, $02 ; id 114
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $05, $02, $04, $04, $08, $05 ; id 115
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $05, $02, $04, $04, $08, $05 ; id 116
    db $07, $03, $05, $02, $06, $02, $02, $03, $05, $02, $01, $03, $07, $05, $01, $04 ; id 117
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $07, $07, $06, $02, $04, $04 ; id 118
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $05, $02, $04, $04, $08, $05 ; id 119
    db $03, $04, $06, $04, $04, $04, $06, $03, $07, $03, $07, $02, $02, $04, $04, $04 ; id 120
    db $04, $04, $04, $04, $04, $04, $06, $02, $04, $04, $05, $02, $04, $03, $04, $04 ; id 121
    db $04, $04, $04, $04, $04, $04, $06, $02, $04, $04, $05, $02, $04, $03, $04, $04 ; id 122
    db $04, $04, $04, $04, $04, $04, $06, $02, $04, $04, $05, $02, $04, $03, $04, $04 ; id 123
    db $04, $04, $04, $04, $04, $04, $06, $02, $04, $04, $05, $02, $04, $03, $04, $04 ; id 124
    db $07, $05, $06, $05, $07, $03, $06, $03, $05, $02, $05, $06, $05, $07, $04, $06 ; id 125
    db $04, $04, $04, $04, $07, $04, $02, $06, $04, $04, $04, $04, $07, $02, $04, $04 ; id 126
    db $04, $04, $04, $04, $04, $04, $06, $02, $04, $04, $05, $02, $04, $03, $04, $04 ; id 127
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 128
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 129
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 130
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 131
    db $05, $04, $03, $07, $01, $02, $05, $06, $02, $02, $02, $06, $01, $04, $01, $07 ; id 132
    db $04, $07, $03, $06, $07, $07, $06, $04, $07, $04, $02, $05, $01, $03, $07, $05 ; id 133
    db $01, $04, $06, $02, $05, $05, $04, $04, $08, $05, $04, $04, $04, $04, $04, $04 ; id 134
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 135
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 136
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 137
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 138
    db $05, $02, $05, $04, $01, $02, $08, $02, $05, $02, $05, $06, $07, $02, $07, $03 ; id 139
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 140
    db $04, $04, $03, $04, $01, $03, $02, $05, $03, $04, $04, $04, $04, $04, $05, $01 ; id 141
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $08, $03, $04, $06 ; id 142
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 143
    db $04, $01, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $07, $05 ; id 144
    db $02, $04, $03, $03, $03, $04, $08, $03, $03, $05, $05, $02, $06, $05, $02, $03 ; id 145
    db $04, $01, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $07, $05 ; id 146
    db $04, $01, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $07, $05 ; id 147
    db $04, $01, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $07, $05 ; id 148
    db $06, $06, $04, $03, $03, $05, $08, $04, $02, $05, $02, $06, $04, $04, $05, $02 ; id 149
    db $04, $04, $04, $04, $02, $07, $04, $04, $04, $04, $04, $04, $04, $04, $06, $05 ; id 150
    db $04, $01, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $07, $05 ; id 151
    db $04, $04, $04, $04, $07, $07, $07, $03, $04, $04, $04, $04, $05, $06, $06, $04 ; id 152
    db $04, $04, $04, $04, $07, $07, $07, $03, $04, $04, $04, $04, $05, $06, $06, $04 ; id 153
    db $04, $04, $04, $04, $07, $07, $07, $03, $04, $04, $04, $04, $05, $06, $06, $04 ; id 154
    db $06, $03, $01, $05, $07, $05, $05, $07, $02, $04, $08, $02, $01, $06, $04, $05 ; id 155
    db $04, $04, $04, $04, $07, $07, $07, $03, $04, $04, $04, $04, $05, $06, $06, $04 ; id 156
    db $01, $05, $04, $06, $08, $03, $03, $03, $08, $03, $06, $02, $01, $06, $04, $06 ; id 157
    db $08, $07, $04, $04, $05, $04, $05, $05, $04, $04, $04, $04, $07, $04, $07, $04 ; id 158
    db $04, $04, $04, $04, $07, $07, $07, $03, $04, $04, $04, $04, $05, $06, $06, $04 ; id 159
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 160
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 161
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 162
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 163
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 164
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 165
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 166
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 167
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 168
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 169
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 170
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 171
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 172
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 173
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 174
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 175
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 176
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 177
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 178
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 179
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 180
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 181
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 182
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 183
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 184
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 185
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 186
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 187
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04 ; id 188
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 189
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 190
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 191

LoadMapScreen_Sub03_Return::
    ret
    db $c9

LoadMapScreen_Sub03_LoadMapScreenFromChunk_Case02::
    ld a, $61
    ldh [hTemp0], a
    ld a, [wKeyWorldFloor]
    bit 7, a
    jr z, .call_load_map_screen_from_chunk
    ld hl, hTemp0
    inc [hl]

.call_load_map_screen_from_chunk:
    call LoadMapScreenFromChunk
    ret

LoadMapScreen_Sub03_LoadMapScreenFromChunk_Case03::
    ld hl, wKeyWorldFloorState
    ld a, [wKeyWorldFloor]
    swap a
    add_a_to_hl
    ld a, [hl]
    and $7f
    ldh [hTemp0], a
    call LoadMapScreenFromChunk
    ret

LoadMapScreen_Sub03_WriteSVBK::
    ldh a, [hMapScreenY]
    and $fc
    add a
    ld l, a
    ld h, $00
    ldh a, [hMapScreenX]
    and $fc
    add_a_to_hl
    ld a, l
    add $60
    ld l, a
    ld a, h
    adc $cd
    ld h, a
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [hli]
    ld b, a
    push bc
    ld a, [hl]
    ld c, $60
    call Multiply8
    add hl, de
    pop bc
    ldh a, [hMapScreenY]
    and $03
    ld c, a
    sla a
    add c
    sla a
    sla a
    add_a_to_hl
    ldh a, [hMapScreenX]
    and $03
    ld c, a
    sla a
    add c
    add_a_to_hl
    push hl
    ld e, l
    ld d, h
    call ReadByteInBank
    ld l, c
    inc de
    call ReadByteInBank
    ld h, c
    push bc
    inc de
    call ReadByteInBank
    ld b, c
    ld e, l
    ld d, h
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    ld hl, wScreenTileBuffer
    call DecompressToVRAM
    pop bc
    pop hl
    ld a, [wIsCGB]
    or a
    jr z, .call_draw_key_world_objects_entry_tiles_for
    ld a, l
    add $30
    ld l, a
    ld a, h
    adc $00
    ld h, a
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
    ld a, $02
    ldh [rSVBK], a
    ld hl, wScreenAttrBuffer
    call DecompressToVRAM
    ld a, $00
    ldh [rSVBK], a

.call_draw_key_world_objects_entry_tiles_for:
    call DrawKeyWorldObjectsEntryTilesForScreen
    call DrawWCD8BObjectTilesForScreen
    call DrawKeyWorldGoalAtScreen
    ret

; on key-world maps draws the goal object for the current screen (from wKeyWorldGoal when the
; wKeyWorldKey key matches, else from wKeyWorldGoalPos2) (E-0130)
DrawKeyWorldGoalAtScreen::
    ld a, [wMapType]
    cp $80
    ret nz
    ld a, [wKeyWorldActive]
    or a
    jr z, .read_map_screen_x
    ld a, [wKeyWorldKey]
    bit 7, a
    jr z, .read_map_screen_x
    and $7f
    ld c, a
    ld a, [wKeyWorldSlot]
    cp c
    jr nz, .read_map_screen_x
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or c
    ld c, a
    ld a, [wKeyWorldGoalCell]
    cp c
    ret nz
    ld a, [wKeyWorldGoal]
    and $0f
    ld c, a
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, c
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld a, [wKeyWorldGoal]
    swap a
    and $0f
    add a
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    jr .skip4

.read_map_screen_x:
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or c
    ld c, a
    ld a, [wKeyWorldGoalScreen]
    cp c
    ret nz
    ld a, [wKeyWorldGoalPos2]
    swap a
    ld c, a
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, c
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld a, [wKeyWorldGoalPos]
    swap a
    sla a
    add e
    ld e, a
    jr nc, .skip4
    inc d

.skip4:
    push de
    ld a, e
    add $98
    ld e, a
    ld a, d
    adc $c1
    ld d, a
    ld a, $46
    call Write2x2TileBlockAtDE
    pop de
    ld a, [wIsCGB]
    or a
    ret z
    ld a, e
    add $00
    ld e, a
    ld a, d
    adc $d0
    ld d, a
    ld a, $02
    ldh [rSVBK], a
    ld a, $05
    call Write2x2SameTileAtDE
    ld a, $00
    ldh [rSVBK], a
    ret

; for the wKeyWorldObjects entry on the current screen writes its 2 x 2 tile block ($46, or $70-$73)
; at wScreenTileBuffer + $A8 with CGB attribute 5 (E-0129)
DrawKeyWorldObjectsEntryTilesForScreen::
    ld hl, wKeyWorldObjects

.skip:
    ld a, [hl]
    cp $ff
    jr z, .return
    push hl
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    swap a
    and $0f
    ld b, a
    ld a, [hl]
    and $0f
    ld c, a
    ldh a, [hMapScreenX]
    cp b
    jr nz, .next
    ldh a, [hMapScreenY]
    cp c
    jr nz, .next
    ldh a, [hMapScreenY]

.restore:
    pop hl
    ld de, wScreenTileBuffer + $a8
    dec hl
    ld a, [hl]
    or a
    jr nz, .skip2
    ld a, $46
    call Write2x2TileBlockAtDE
    jr .check_is_cgb

.skip2:
    ld a, $70
    ld [de], a
    inc de
    inc a
    ld [de], a
    inc a
    push af
    ld a, e
    add $13
    ld e, a
    ld a, d
    adc $00
    ld d, a
    pop af
    ld [de], a
    inc de
    inc a
    ld [de], a

.check_is_cgb:
    ld a, [wIsCGB]
    or a
    jr z, .return
    ld de, wWorkBuf + $b
    ld a, $02
    ldh [rSVBK], a
    ld a, $05
    call Write2x2SameTileAtDE
    ld a, $00
    ldh [rSVBK], a
    jr .return

.next:
    inc hl
    ld a, [hl]
    swap a
    and $0f
    ld b, a
    ld a, [hl]
    and $0f
    ld c, a
    ldh a, [hMapScreenX]
    cp b
    jr nz, .restore2
    ldh a, [hMapScreenY]
    cp c
    jr nz, .restore2
    ldh a, [hMapScreenY]
    jr .restore

.restore2:
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr .skip

.return:
    ret

; for the wKeyWorldFloorInfo + $3 object on the current screen draws its 4 x 2 or 2 x 2 tile blocks
; by kind (E-0130)
DrawWCD8BObjectTilesForScreen::
    ld hl, wKeyWorldFloorInfo + $3

.skip:
    ld a, [hl]
    cp $ff
    ret z
    push hl
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    swap a
    and $0f
    ld b, a
    ld a, [hl]
    and $0f
    ld c, a
    ldh a, [hMapScreenX]
    cp b
    jp nz, .restore
    ldh a, [hMapScreenY]
    cp c
    jp nz, .restore
    pop hl
    ld de, wScreenTileBuffer + $a8
    dec hl
    dec hl
    ld a, [hl]
    or a
    jr nz, .skip2
    ret

.skip2:
    dec a
    jr nz, .skip3

.call_write4x2_tile_block_at_de:
    ld a, $68
    call Write4x2TileBlockAtDE
    ld c, $01
    jr .check_is_cgb

.skip3:
    dec a
    jr nz, .skip4
    ld a, $4c
    call Write2x2TileBlockAtDE
    ld a, e
    sub $13
    ld e, a
    ld a, d
    sbc $00
    ld d, a
    ld a, $4e
    call Write2x2TileBlockAtDE
    ld c, $01
    jr .check_is_cgb

.skip4:
    dec a
    jr nz, .skip5
    ld a, $60
    call Write4x2TileBlockAtDE
    ld c, $01
    jr .check_is_cgb

.skip5:
    dec a
    jr nz, .skip6
    ld a, $4a
    call Write2x2TileBlockAtDE
    ld c, $00
    jr .check_is_cgb

.skip6:
    dec a
    jr nz, .skip7
    ld a, $48
    call Write2x2TileBlockAtDE
    ld c, $00
    jr .check_is_cgb

.skip7:
    jr .call_write4x2_tile_block_at_de

.check_is_cgb:
    ld a, [wIsCGB]
    or a
    jr z, .return
    ld de, wWorkBuf + $b
    ld a, $02
    ldh [rSVBK], a
    bit 0, c
    jr nz, .call_write2x2_same_tile_at_de
    ld a, $05
    call Write2x2SameTileAtDE
    ld a, $00
    ldh [rSVBK], a
    jr .return

.call_write2x2_same_tile_at_de:
    ld a, $06
    call Write2x2SameTileAtDE
    ld a, e
    sub $13
    ld e, a
    ld a, d
    sbc $00
    ld d, a
    ld a, $06
    call Write2x2SameTileAtDE
    ld a, $00
    ldh [rSVBK], a
    jr .return

.restore:
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jp .skip

.return:
    ret

; writes tiles A, A+1 at DE and A+$10, A+$11 one 20-tile row below (E-0121)
Write2x2TileBlockAtDE::
    ld [de], a
    inc de
    inc a
    ld [de], a
    add $0f
    push af
    ld a, e
    add $13
    ld e, a
    ld a, d
    adc $00
    ld d, a
    pop af
    ld [de], a
    inc de
    inc a
    ld [de], a
    ret

; writes tiles A..A+3 at DE and the next four one 20-tile row below (E-0121)
Write4x2TileBlockAtDE::
    ld [de], a
    inc a
    inc de
    ld [de], a
    inc a
    inc de
    ld [de], a
    inc a
    inc de
    ld [de], a
    inc a
    push af
    ld a, e
    add $11
    ld e, a
    ld a, d
    adc $00
    ld d, a
    pop af
    ld [de], a
    inc de
    inc a
    ld [de], a
    inc de
    inc a
    ld [de], a
    inc de
    inc a
    ld [de], a
    ret

; writes tile A to two cells at DE and two cells one 20-tile row below (E-0125)
Write2x2SameTileAtDE::
    ld [de], a
    inc de
    ld [de], a
    push af
    ld a, $13
    add e
    ld e, a
    jr nc, .restore
    inc d

.restore:
    pop af
    ld [de], a
    inc de
    ld [de], a
    ret

; RunWCC44Type_420D_Case00 indexes it with 6 * wKeyWorldGoalKind, decompresses the first far pointer
; to vTiles2 and, on CGB, copies $40 bytes from the second to wBGPaletteBuffer; all 10 tile streams
; decode to 2048 bytes and all 10 palettes are 15-bit colours (E-0139, C1)
; record: compressed BG tiles decompressed to vTiles2 (128 tiles); ROM bank of the tiles; $40-byte
; CGB BG palette set copied to wBGPaletteBuffer; ROM bank of the palettes
KeyWorldTilesetTable::
    dfar KeyWorldTiles0 ; id 0: compressed BG tiles decompressed to vTiles2 (128 tiles)
    dfar KeyWorldPalettes0 ; $40-byte CGB BG palette set copied to wBGPaletteBuffer
    dfar KeyWorldTiles1 ; id 1: compressed BG tiles decompressed to vTiles2 (128 tiles)
    dfar KeyWorldPalettes1 ; $40-byte CGB BG palette set copied to wBGPaletteBuffer
    dfar KeyWorldTiles2 ; id 2: compressed BG tiles decompressed to vTiles2 (128 tiles)
    dfar KeyWorldPalettes2 ; $40-byte CGB BG palette set copied to wBGPaletteBuffer
    dfar KeyWorldTiles3 ; id 3: compressed BG tiles decompressed to vTiles2 (128 tiles)
    dfar KeyWorldPalettes3 ; $40-byte CGB BG palette set copied to wBGPaletteBuffer
    dfar KeyWorldTiles4 ; id 4: compressed BG tiles decompressed to vTiles2 (128 tiles)
    dfar KeyWorldPalettes4 ; $40-byte CGB BG palette set copied to wBGPaletteBuffer
    dfar KeyWorldTiles5 ; id 5: compressed BG tiles decompressed to vTiles2 (128 tiles)
    dfar KeyWorldPalettes5 ; $40-byte CGB BG palette set copied to wBGPaletteBuffer
    dfar KeyWorldTiles6 ; id 6: compressed BG tiles decompressed to vTiles2 (128 tiles)
    dfar KeyWorldPalettes6 ; $40-byte CGB BG palette set copied to wBGPaletteBuffer
    dfar KeyWorldTiles7 ; id 7: compressed BG tiles decompressed to vTiles2 (128 tiles)
    dfar KeyWorldPalettes7 ; $40-byte CGB BG palette set copied to wBGPaletteBuffer
    dfar KeyWorldTiles8 ; id 8: compressed BG tiles decompressed to vTiles2 (128 tiles)
    dfar KeyWorldPalettes8 ; $40-byte CGB BG palette set copied to wBGPaletteBuffer
    dfar KeyWorldTiles9 ; id 9: compressed BG tiles decompressed to vTiles2 (128 tiles)
    dfar KeyWorldPalettes9 ; $40-byte CGB BG palette set copied to wBGPaletteBuffer

CheckWarpAtPlayer_ReadMapType::
    ld a, [wMapType]
    and $07
    jumptable
    dw CheckWarpAtPlayer_Sub01_ReturnAfterSetup
    dw CheckWarpAtPlayer_Sub01_ReturnAfterSetup_Case01
    dw CheckWarpAtPlayer_Sub01_ToWarpByKeyWorldAreaExitsEntryAtScreenRow1
    dw CheckWarpAtPlayer_Sub01_ToCheckKeyWorldWarpTable
    dw CheckWarpAtPlayer_Sub01_ToWarpToScreen01Event83
    dw CheckWarpAtPlayer_Sub01_ToWarpByWCD89EntryAtScreen14
    dw CheckWarpAtPlayer_Sub01_ReturnAfterSetup
    dw CheckWarpAtPlayer_Sub01_ToCallF4268OnScreenY1

CheckWarpAtPlayer_Sub01_ReturnAfterSetup::
    ld c, $00
    ret

CheckWarpAtPlayer_Sub01_ReturnAfterSetup_Case01::
    ld c, $00
    ret

CheckWarpAtPlayer_Sub01_ToWarpByKeyWorldAreaExitsEntryAtScreenRow1::
    call WarpByKeyWorldAreaExitsEntryAtScreenRow1
    ret

CheckWarpAtPlayer_Sub01_ToCheckKeyWorldWarpTable::
    call CheckKeyWorldWarpTable
    ret

CheckWarpAtPlayer_Sub01_ToWarpToScreen01Event83::
    call WarpToScreen01Event83
    ret

CheckWarpAtPlayer_Sub01_ToWarpByWCD89EntryAtScreen14::
    call WarpByWCD89EntryAtScreen14
    ret

CheckWarpAtPlayer_Sub01_ToCallF4268OnScreenY1::
    call CallF4268OnScreenY1
    ret

; C = 0 unless hMapScreenY = 1, in which case far-calls WarpToLinkedMapForCurrentMap (E-0122)
CallF4268OnScreenY1::
    ldh a, [hMapScreenY]
    cp $01
    jr z, .call_warp_to_linked_map_for_current_map
    ld c, $00
    ret

.call_warp_to_linked_map_for_current_map:
    farcall WarpToLinkedMapForCurrentMap
    ret

; when wKeyWorldArea is 0, the wKeyWorldFloorInfo + $1 entry is 5 and the player is at screen (1,
; 4): warps to the stored screen and starts the transition; C = 1 (E-0127)
WarpByWCD89EntryAtScreen14::
    ld a, [wKeyWorldArea]
    or a
    jr z, .read_key_world_floor

.loop:
    ld c, $00
    ret

.read_key_world_floor:
    ld a, [wKeyWorldFloor]
    sla a
    sla a
    ld hl, wKeyWorldFloorInfo + $1
    add_a_to_hl
    ld a, [hl]
    cp $05
    jr nz, .loop
    ldh a, [hMapScreenX]
    dec a
    jr nz, .loop
    ldh a, [hMapScreenY]
    cp $04
    jr nz, .loop
    dec hl
    ld a, [hl]
    swap a
    and $0f
    ldh [hMapScreenX], a
    ld a, [hl]
    and $0f
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld [wWarpDestY], a
    ld a, $f0
    ld [wWarpDestFacing], a
    ld a, $60
    call QueueSoundEffect
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or $80
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wFieldTransitionKind], a
    ld c, $01
    ret

; on map screen row 1: warps to screen (0, 1) at ($40, $38), shifts the wKeyWorldFloorState + $1
; entry, plays sound $60, wMapType = $83 and starts the transition; C = 1 (E-0125)
WarpToScreen01Event83::
    ldh a, [hMapScreenY]
    cp $01
    jr z, .clear_map_screen_x
    ld c, $00
    ret

.clear_map_screen_x:
    xor a
    ldh [hMapScreenX], a
    inc a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $38
    ld [wWarpDestY], a
    ld a, $ff
    ld [wWarpDestFacing], a
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState + $1
    add_a_to_hl
    ld a, [hld]
    ld [hl], a
    ld a, $60
    call QueueSoundEffect
    ld a, $83
    ld [wMapType], a
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or $40
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wFieldTransitionKind], a
    ld c, $01
    ret

; on screen row 1: warps to the screen in the wKeyWorldAreaExits entry of wKeyWorldFloor and starts
; the transition; C = 1 (E-0127)
WarpByKeyWorldAreaExitsEntryAtScreenRow1::
    ldh a, [hMapScreenY]
    cp $01
    jr z, .check_key_world_floor
    ld c, $00
    ret

.check_key_world_floor:
    ld a, [wKeyWorldFloor]
    and $7f
    sla a
    sla a
    ld hl, wKeyWorldAreaExits
    add_a_to_hl
    ld a, [wKeyWorldFloor]
    bit 7, a
    jr z, .skip
    inc hl

.skip:
    ld a, [hl]
    swap a
    and $0f
    ldh [hMapScreenX], a
    ld a, [hl]
    and $0f
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld [wWarpDestY], a
    ld a, $f0
    ld [wWarpDestFacing], a
    ld a, $60
    call QueueSoundEffect
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or $80
    ldh [hPlayerStateFlags], a
    ldh a, [hPlayerStateFlags]
    and $fe
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wFieldTransitionKind], a
    ld c, $01
    ret

; checks the warp list KeyWorldWarpListTable[wKeyWorldFloorState entry] against the current screen
; and warps when one matches; C = 0 when none (E-0130)
CheckKeyWorldWarpTable::
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState
    add_a_to_hl
    ld a, [hl]
    and $7f
    ld l, a
    ld h, $00
    sla l
    rl h
    ld de, KeyWorldWarpListTable
    add hl, de
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a

.skip:
    push de
    ld a, [de]
    inc de
    cp $80
    jr nz, .cp_FD
    pop de
    ld c, $00
    ret

.cp_FD:
    cp $fd
    jr z, .restore
    cp $fe
    jr z, .set_warp_dest_facing
    cp $ff
    jr z, .set_warp_dest_facing
    jr .restore

.set_warp_dest_facing:
    ld [wWarpDestFacing], a
    inc de
    ld a, [de]
    inc de
    ld c, a
    ldh a, [hMapScreenX]
    cp c
    jr nz, .restore
    ld a, [de]
    inc de
    ld c, a
    ldh a, [hMapScreenY]
    cp c
    jr nz, .restore
    jr .skip2
    db $f1

.restore:
    pop de
    ld a, e
    add $09
    ld e, a
    ld a, d
    adc $00
    ld d, a
    jr .skip

.skip2:
    ld a, [de]
    cp $ff
    jr nz, .done
    inc de
    inc de
    inc de
    ld a, [de]
    ld [wWarpDestX], a
    inc de
    ld a, [de]
    ld [wWarpDestY], a
    ld a, [wKeyWorldFloor]
    sla a
    sla a
    ld hl, wKeyWorldFloorInfo
    add_a_to_hl
    ld a, [hl]
    swap a
    and $0f
    ldh [hMapScreenX], a
    ld a, [hl]
    and $0f
    ldh [hMapScreenY], a
    ld a, $f0
    ld [wWarpDestFacing], a
    jr .call_start_palette_fade

.done:
    pop de
    ld c, $00
    ret

.call_start_palette_fade:
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or $80
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wFieldTransitionKind], a
    pop de
    ld a, $60
    call QueueSoundEffect
    ld c, $01
    ret

; runs the routine for wMapType & 7 (jump table; 7 reuses 4) (E-0122)
CheckWarpsByMapType::
    ld a, [wMapType]
    and $07
    jumptable
    dw CheckWarpsByMapType_Case00_WriteFieldReturnPhaseAndFieldTransitionStepEtc_Case00
    dw CheckWarpsByMapType_ToReturnStub_5CCF
    dw CheckWarpsByMapType_Case02_WriteMapToggleRequestAndKeyWorldFloorEtc_Case02
    dw CheckWarpsByMapType_Case03_WritePlayerStateFlagsAndWarpDestFacingEtc_Case03
    dw CheckWarpsByMapType_Return
    dw CheckWarpsByMapType_Case05_WritePlayerStateFlagsAndTemp0Etc_Case05
    dw CheckWarpsByMapType_Case06_WriteKeyWorldAreaAndMapScreenXEtc_Case06
    dw CheckWarpsByMapType_Return

CheckWarpsByMapType_Return::
    ret

CheckWarpsByMapType_Case00_WriteFieldReturnPhaseAndFieldTransitionStepEtc_Case00::
    call CheckWarpsByMapType_Case00_WriteFieldReturnPhaseAndFieldTransitionStepEtc
    or a
    ret nz
    call CheckWarpsByMapType_Case00_WriteWarpDestXAndWarpDestYEtc
    or a
    ret nz
    call CheckWarpsByMapType_Case00_WriteTemp1AndPlayerStateFlagsEtc
    or a
    ret nz
    ret

CheckWarpsByMapType_ToReturnStub_5CCF::
    call ReturnStub_5CCF
    ret

CheckWarpsByMapType_Case02_WriteMapToggleRequestAndKeyWorldFloorEtc_Case02::
    call CheckWarpsByMapType_Case02_WriteMapToggleRequestAndKeyWorldFloorEtc
    ret

CheckWarpsByMapType_Case03_WritePlayerStateFlagsAndWarpDestFacingEtc_Case03::
    call CheckWarpsByMapType_Case03_WritePlayerStateFlagsAndWarpDestFacingEtc
    ret

CheckWarpsByMapType_Case05_WritePlayerStateFlagsAndTemp0Etc_Case05::
    call CheckWarpsByMapType_Case05_WritePlayerStateFlagsAndTemp0Etc
    ret

CheckWarpsByMapType_Case06_WriteKeyWorldAreaAndMapScreenXEtc_Case06::
    call CheckWarpsByMapType_Case06_WriteKeyWorldAreaAndMapScreenXEtc
    ret

CheckWarpsByMapType_Case06_WriteKeyWorldAreaAndMapScreenXEtc::
    ldh a, [hPlayerX]
    cp $40
    jr z, .check_player_y

.loop:
    ld c, $00
    ret

.check_player_y:
    ldh a, [hPlayerY]
    cp $40
    jr nz, .loop
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState + $1
    add_a_to_hl
    ld a, [hl]
    add a
    ld de, wKeyWorldRoomTable + $1
    add e
    ld e, a
    jr nc, .check_key_world_area
    inc d

.check_key_world_area:
    ld a, [wKeyWorldArea]
    dec a
    ld [wKeyWorldArea], a
    add a
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    swap a
    and $0f
    ld hl, CheckWarpsByMapType_Case06_WriteKeyWorldAreaAndMapScreenXEtc_Data
    add_a_to_hl
    ld a, [hl]
    swap a
    and $0f
    ldh [hMapScreenX], a
    ld a, [hl]
    and $0f
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld [wWarpDestY], a
    xor a
    ld [wWarpDestFacing], a
    ld a, $85
    ld [wMapType], a
    ld a, $01
    ld [wWarpPending], a
    ld a, $60
    call QueueSoundEffect
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or $80
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wFieldTransitionKind], a
    ld c, $01
    ret

CheckWarpsByMapType_Case06_WriteKeyWorldAreaAndMapScreenXEtc_Data::
    db $00, $30, $11, $22, $03, $33

CheckWarpsByMapType_Case05_WritePlayerStateFlagsAndTemp0Etc::
    ldh a, [hPlayerX]
    cp $40
    jr z, .check_player_y

.loop:
    ldh a, [hPlayerStateFlags]
    and $7f
    ldh [hPlayerStateFlags], a
    ld c, $00
    ret

.check_player_y:
    ldh a, [hPlayerY]
    cp $40
    jr nz, .loop
    ld a, [wKeyWorldFloor]
    add a
    add a
    push af
    ld hl, wKeyWorldFloorInfo + $1
    add_a_to_hl
    ld a, [hl]
    ldh [hTemp0], a
    pop af
    add a
    add a
    ld hl, wKeyWorldFloorState
    add_a_to_hl
    ld a, [hli]
    ldh [hTemp1], a
    ld a, [hl]
    add a
    ld de, wKeyWorldRoomTable + $1
    add e
    ld e, a
    jr nc, .read_key_world_area
    inc d

.read_key_world_area:
    ld a, [wKeyWorldArea]
    add a
    add e
    ld e, a
    jr nc, .check_map_screen_x
    inc d

.check_map_screen_x:
    ldh a, [hMapScreenX]
    and $0f
    swap a
    ld b, a
    ldh a, [hMapScreenY]
    and $0f
    or b
    ld b, a
    ld a, [de]
    and $0f
    cp $0f
    jp z, .skip
    ld hl, CheckWarpsByMapType_Case05_WritePlayerStateFlagsAndTemp0Etc_Data
    add_a_to_hl
    ld a, [hl]
    cp b
    jr z, .check_key_world_area

.skip:
    ld a, [de]
    swap a
    and $0f
    ld hl, CheckWarpsByMapType_Case05_WritePlayerStateFlagsAndTemp0Etc_Data
    add_a_to_hl
    ld a, [hl]
    cp b
    jr z, .check_key_world_area3
    ldh a, [hPlayerStateFlags]
    and $7f
    ldh [hPlayerStateFlags], a
    ld c, $00
    ret

.check_key_world_area:
    ld a, [wKeyWorldArea]
    or a
    jr nz, .check_key_world_area2
    ldh a, [hTemp0]
    cp $04
    jr nz, .check_key_world_area2
    ld a, [wKeyWorldFloor]
    add a
    add a
    ld hl, wKeyWorldFloorInfo
    add_a_to_hl
    ld a, [hl]
    swap a
    and $0f
    ldh [hMapScreenX], a
    ld a, [hl]
    and $0f
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld [wWarpDestY], a
    ld a, $f0
    ld [wWarpDestFacing], a
    ld a, $60
    call QueueSoundEffect
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or $80
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wFieldTransitionKind], a
    ld c, $01
    ret

.check_key_world_area2:
    ld a, [wKeyWorldArea]
    dec a
    ld [wKeyWorldArea], a
    dec de
    dec de
    ld a, [de]
    swap a
    and $0f
    jr .skip2

.check_key_world_area3:
    ld a, [wKeyWorldArea]
    inc a
    ld [wKeyWorldArea], a
    inc a
    ld c, a
    ldh a, [hTemp1]
    cp c
    jr nz, .next
    ld a, $86
    ld [wMapType], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld [wWarpDestY], a
    xor a
    ld [wWarpDestFacing], a
    ld a, $60
    call QueueSoundEffect
    ld a, $01
    ld [wWarpPending], a
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a
    ld [wFieldTransitionStep], a
    xor a
    ld [wFieldReturnPhase], a
    ldh a, [hPlayerStateFlags]
    or $80
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wFieldTransitionKind], a
    ld c, $01
    ret

.next:
    inc de
    inc de
    ld a, [de]
    and $0f

.skip2:
    ld hl, CheckWarpsByMapType_Case05_WritePlayerStateFlagsAndTemp0Etc_Data
    add_a_to_hl
    ld a, [hl]
    swap a
    and $0f
    ldh [hMapScreenX], a
    ld a, [hl]
    and $0f
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld [wWarpDestY], a
    xor a
    ld [wWarpDestFacing], a
    ld a, $60
    call QueueSoundEffect
    ld a, $01
    ld [wWarpPending], a
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or $80
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wFieldTransitionKind], a
    xor a
    ld [wFieldReturnPhase], a
    ld c, $01
    ret

CheckWarpsByMapType_Case05_WritePlayerStateFlagsAndTemp0Etc_Data::
    db $00, $30, $11, $22, $03, $33

CheckWarpsByMapType_Case02_WriteMapToggleRequestAndKeyWorldFloorEtc::
    ldh a, [hPlayerX]
    cp $40
    jr z, .check_player_y

.loop:
    ld c, $00
    ret

.check_player_y:
    ldh a, [hPlayerY]
    cp $30
    jr nz, .loop
    ld a, [wMapToggleRequest]
    or a
    jr z, .loop
    xor a
    ld [wMapToggleRequest], a
    ld a, [wKeyWorldFloor]
    add $80
    ld [wKeyWorldFloor], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $30
    ld [wWarpDestY], a
    ld a, $ff
    ld [wWarpDestFacing], a
    xor a
    ld [wMapToggleFlag], a
    ld a, $06
    ld [wModeState], a
    xor a
    ld [wMenuState], a
    ld [wMenuSubState], a
    ldh a, [hPlayerStateFlags]
    or $80
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wFieldTransitionKind], a
    ret

CheckWarpsByMapType_Case03_WritePlayerStateFlagsAndWarpDestFacingEtc::
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState
    add_a_to_hl
    ld a, [hl]
    and $7f
    ld l, a
    ld h, $00
    sla l
    rl h
    ld de, KeyWorldWarpListTable
    add hl, de
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a

.skip:
    push de
    ld a, [de]
    inc de
    cp $80
    jr nz, .cp_FD
    pop de
    ldh a, [hPlayerStateFlags]
    and $7f
    ldh [hPlayerStateFlags], a
    ld c, $00
    ret

.cp_FD:
    cp $fd
    jr z, .set_warp_dest_facing
    jr .restore2

.set_warp_dest_facing:
    ld a, [de]
    inc de
    ld [wWarpDestFacing], a
    push af
    swap a
    and $0f
    ld c, a
    ldh a, [hMapScreenX]
    cp c
    jr nz, .restore
    pop af
    and $0f
    ld c, a
    ldh a, [hMapScreenY]
    cp c
    jr nz, .restore2
    ld a, [de]
    inc de
    ld c, a
    ldh a, [hPlayerX]
    cp c
    jr nz, .restore2
    ld a, [de]
    inc de
    ld c, a
    ldh a, [hPlayerY]
    cp c
    jr nz, .restore2
    ldh a, [hPlayerStateFlags]
    bit 7, a
    jr z, .skip2
    pop de
    ld c, $00
    ret

.skip2:
    jr .skip3

.restore:
    pop af

.restore2:
    pop de
    ld a, e
    add $09
    ld e, a
    ld a, d
    adc $00
    ld d, a
    jr .skip

.skip3:
    ld a, [de]
    cp $f2
    jr nz, .done
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $80
    ld [wWarpDestY], a
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState
    add_a_to_hl
    ld a, [hli]
    ld [hld], a
    ld a, $63
    ld [hl], a
    ld a, $84
    ld [wMapType], a
    ld a, $60
    call QueueSoundEffect
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or $80
    ldh [hPlayerStateFlags], a
    ld a, $03
    ld [wFieldTransitionKind], a
    pop de
    ld c, $01
    ret

.done:
    pop de
    ld c, $00
    ret

; a bare ret (E-0116)
ReturnStub_5CCF::
    ret

CheckWarpsByMapType_Case00_WriteTemp1AndPlayerStateFlagsEtc::
    ld hl, wKeyWorldFloorInfo + $3
    xor a
    ldh [hTemp1], a

.skip:
    ld a, [hl]
    cp $ff
    jr nz, .skip2
    ldh a, [hPlayerStateFlags]
    and $5f
    ldh [hPlayerStateFlags], a
    xor a
    ret

.loop:
    pop hl
    xor a
    ret

.skip2:
    push hl
    dec hl
    dec hl
    ld a, [hl]
    ldh [hTemp2], a
    cp $04
    jr z, .read_player_x
    cp $05
    jr z, .read_player_x
    ldh a, [hPlayerX]
    swap a
    and $0f
    cp $04
    jr z, .read_player_y
    cp $05
    jr nz, .loop2

.read_player_y:
    ldh a, [hPlayerY]
    swap a
    and $0f
    cp $04
    jr nz, .loop2
    jr .next

.loop2:
    jp .restore

.read_player_x:
    ldh a, [hPlayerX]
    swap a
    and $0f
    cp $04
    jr nz, .loop2
    ldh a, [hPlayerY]
    swap a
    and $0f
    cp $04
    jr nz, .loop2

.next:
    dec hl
    ld a, [hl]
    swap a
    and $0f
    ld b, a
    ld a, [hl]
    and $0f
    ld c, a
    ldh a, [hMapScreenX]
    cp b
    jp nz, .restore
    ldh a, [hMapScreenY]
    cp c
    jp nz, .restore
    ldh a, [hPlayerStateFlags]
    bit 7, a
    jr nz, .loop
    ldh a, [hTemp2]
    cp $04
    jp z, .clear_key_world_area2
    cp $05
    jp z, .clear_key_world_area
    ldh a, [hTemp1]
    ld [wKeyWorldFloor], a
    ld a, $83
    ld [wMapType], a
    ldh a, [hTemp1]
    swap a
    ld hl, wKeyWorldFloorState
    add_a_to_hl
    ld a, [hl]
    and $7f
    ld e, a
    ld d, $00
    sla e
    rl d
    ld a, e
    add $d8
    ld e, a
    ld a, d
    adc $60
    ld d, a
    ld b, $61
    call ReadByteInBank
    ld l, c
    inc de
    call ReadByteInBank
    ld h, c
    ld a, $0c
    add_a_to_hl
    ldh a, [hPlayerX]
    cp $40
    jr z, .call_read_byte_in_bank
    inc hl
    inc hl
    inc hl
    inc hl

.call_read_byte_in_bank:
    ld e, l
    ld d, h
    call ReadByteInBank
    ld a, c
    ldh [hMapScreenX], a
    inc de
    call ReadByteInBank
    ld a, c
    ldh [hMapScreenY], a
    inc de
    call ReadByteInBank
    ld a, c
    ld [wWarpDestX], a
    inc de
    call ReadByteInBank
    ld a, c
    ld [wWarpDestY], a
    xor a
    ld [wWarpDestFacing], a
    ld a, $60
    call QueueSoundEffect
    xor a
    ld [wFieldReturnPhase], a
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or $80
    ldh [hPlayerStateFlags], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ClearPendingFieldEventIfBit7AndNot6
    pop hl
    ld a, $01
    ret

.clear_key_world_area:
    xor a
    ld [wKeyWorldArea], a
    ld a, $01
    ldh [hMapScreenX], a
    ld a, $03
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $80
    ld [wWarpDestY], a
    xor a
    ld [wWarpDestFacing], a
    ld a, $03
    ld [wFieldTransitionKind], a
    jr .read_temp1

.clear_key_world_area2:
    xor a
    ld [wKeyWorldArea], a
    ldh a, [hTemp1]
    swap a
    ld hl, wKeyWorldFloorState + $1
    add_a_to_hl
    ld a, [hl]
    add a
    ld hl, wKeyWorldRoomTable + $1
    add_a_to_hl
    ld a, [hl]
    and $0f
    ld hl, CheckWarpsByMapType_Case00_WriteTemp1AndPlayerStateFlagsEtc_Data
    add_a_to_hl
    ld a, [hl]
    swap a
    and $0f
    ldh [hMapScreenX], a
    ld a, [hl]
    and $0f
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld [wWarpDestY], a
    xor a
    ld [wWarpDestFacing], a
    ld a, $01
    ld [wFieldTransitionKind], a

.read_temp1:
    ldh a, [hTemp1]
    ld [wKeyWorldFloor], a
    ld a, $85
    ld [wMapType], a
    ld a, $01
    ld [wWarpPending], a
    ld a, $60
    call QueueSoundEffect
    xor a
    ld [wFieldReturnPhase], a
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or $80
    ldh [hPlayerStateFlags], a
    farcall ClearPendingFieldEventIfBit7AndNot6
    pop hl
    ld a, $01
    ret

.restore:
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    ldh a, [hTemp1]
    inc a
    ldh [hTemp1], a
    jp .skip

CheckWarpsByMapType_Case00_WriteTemp1AndPlayerStateFlagsEtc_Data::
    db $00, $30, $11, $22, $03, $33

CheckWarpsByMapType_Case00_WriteFieldReturnPhaseAndFieldTransitionStepEtc::
    ld a, [wKeyWorldActive]
    or a
    jr z, .read_map_screen_x
    ld a, [wKeyWorldKey]
    bit 7, a
    jr z, .read_map_screen_x
    and $7f
    ld c, a
    ld a, [wKeyWorldSlot]
    cp c
    jr nz, .read_map_screen_x
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or c
    ld c, a
    ld a, [wKeyWorldGoalCell]
    cp c
    jr nz, .loop
    ldh a, [hPlayerX]
    and $f0
    ld c, a
    ldh a, [hPlayerY]
    and $f0
    swap a
    or c
    ld c, a
    ld a, [wKeyWorldGoal]
    cp c
    jr nz, .loop
    jr .check_player_state_flags

.loop:
    ldh a, [hPlayerStateFlags]
    and $df
    ldh [hPlayerStateFlags], a

.loop2:
    xor a
    ret

.read_map_screen_x:
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or c
    ld c, a
    ld a, [wKeyWorldGoalScreen]
    cp c
    jr nz, .loop
    ld a, [wKeyWorldGoalPos]
    ld c, a
    ldh a, [hPlayerX]
    cp c
    jr nz, .loop
    ld a, [wKeyWorldGoalPos2]
    ld c, a
    ldh a, [hPlayerY]
    cp c
    jr nz, .loop

.check_player_state_flags:
    ldh a, [hPlayerStateFlags]
    bit 5, a
    jr nz, .loop2
    ld a, $60
    call QueueSoundEffect
    xor a
    ld [wFieldReturnPhase], a
    ld a, $04
    call StartPaletteFade
    xor a
    ld [wFieldTransitionStep], a
    ld a, $04
    ld [wModeState], a
    ldh a, [hPlayerStateFlags]
    or $20
    ldh [hPlayerStateFlags], a
    ld a, $87
    ld [wMapType], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $80
    ld [wWarpDestY], a
    xor a
    ld [wWarpDestFacing], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ClearPendingFieldEventIfBit7AndNot6
    ld a, $01
    ret

CheckWarpsByMapType_Case00_WriteWarpDestXAndWarpDestYEtc::
    ldh a, [hPlayerX]
    ld c, a
    ldh a, [hPlayerY]
    cp c
    jr nz, .return_0
    swap a
    and $0f
    cp $04
    jr nz, .return_0
    ld hl, wKeyWorldObjects

.skip:
    ld a, [hl]
    cp $ff
    jr nz, .skip2

.return_0:
    xor a
    ret

.loop:
    pop hl
    xor a
    ret

.skip2:
    push hl
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    swap a
    and $0f
    ld b, a
    ld a, [hl]
    and $0f
    ld c, a
    ldh a, [hMapScreenX]
    cp b
    jp nz, .next
    ldh a, [hMapScreenY]
    cp c
    jp nz, .next
    ldh a, [hPlayerStateFlags]
    bit 7, a
    jr nz, .loop
    ld a, $40
    ld [wWarpDestX], a
    ld [wWarpDestY], a
    xor a
    ld [wWarpDestFacing], a
    ld a, $60
    call QueueSoundEffect
    xor a
    ld [wFieldReturnPhase], a
    push hl
    ld a, $04
    call StartPaletteFade
    pop hl
    xor a
    ld [wFieldTransitionStep], a
    ld a, $04
    ld [wModeState], a
    ldh a, [hPlayerStateFlags]
    or $80
    ldh [hPlayerStateFlags], a
    inc hl
    inc hl
    ld a, [hl]
    or a
    jr nz, .return
    inc hl
    ld a, l
    sub $7b
    ld l, a
    ld a, h
    sbc $cd
    ld h, a
    sra h
    rr l
    sra h
    rr l
    ld a, l
    ld [wKeyWorldFloor], a
    ld a, $82
    ld [wMapType], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $80
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ClearPendingFieldEventIfBit7AndNot6
    pop hl
    ld a, $01
    ret

.return:
    ret

.next:
    inc hl
    ld a, [hl]
    swap a
    and $0f
    ld b, a
    ld a, [hl]
    and $0f
    ld c, a
    ldh a, [hMapScreenX]
    cp b
    jp nz, .restore
    ldh a, [hMapScreenY]
    cp c
    jp nz, .restore
    ldh a, [hPlayerStateFlags]
    bit 7, a
    jp nz, .loop
    ld a, $40
    ld [wWarpDestX], a
    ld [wWarpDestY], a
    xor a
    ld [wWarpDestFacing], a
    ld a, $60
    call QueueSoundEffect
    push hl
    ld a, $04
    call StartPaletteFade
    pop hl
    xor a
    ld [wFieldTransitionStep], a
    ld a, $04
    ld [wModeState], a
    ldh a, [hPlayerStateFlags]
    or $80
    ldh [hPlayerStateFlags], a
    inc hl
    ld a, [hl]
    or a
    jr nz, .return2
    inc hl
    ld a, l
    sub $7b
    ld l, a
    ld a, h
    sbc $cd
    ld h, a
    sra h
    rr l
    sra h
    rr l
    ld a, l
    or $80
    ld [wKeyWorldFloor], a
    ld a, $82
    ld [wMapType], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $80
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ClearPendingFieldEventIfBit7AndNot6
    pop hl
    ld a, $01
    ret

.return2:
    ret

.restore:
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jp .skip

; hTemp0 = 1 when bit 7 of wKeyWorldFlags is set; otherwise on map types $80/$85 the
; wKeyWorldEncounterTable + $3 entry of the current area (wKeyWorldAreaInfo), else 0 (E-0129)
KeyWorldAreaEncounterIndex::
    ld a, [wKeyWorldFlags]
    bit 7, a
    jr z, .check_map_type
    ld a, $01
    ldh [hTemp0], a
    ret

.check_map_type:
    push hl
    push de
    ld a, [wMapType]
    cp $80
    jr z, .read_map_screen_y
    cp $85
    jr z, .read_key_world_floor
    xor a
    ldh [hTemp0], a
    ret

.read_key_world_floor:
    ld a, [wKeyWorldFloor]
    add a
    add a
    ld de, wKeyWorldFloorInfo
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    and $0f
    srl a
    srl a
    add a
    ld l, a
    ld a, [de]
    swap a
    and $0f
    srl a
    srl a
    add l
    jr .skip2

.read_map_screen_y:
    ldh a, [hMapScreenY]
    srl a
    srl a
    add a
    ld l, a
    ldh a, [hMapScreenX]
    srl a
    srl a
    add l

.skip2:
    ld hl, wKeyWorldAreaInfo
    add_a_to_hl
    ld a, [hl]
    and $f0
    swap a
    add a
    add a
    ld hl, wKeyWorldEncounterTable + $3
    add_a_to_hl
    ld a, [hl]
    ldh [hTemp0], a
    pop de
    pop hl
    ret

; LoadSpecialMapHeader and LoadMapScreenFromChunk map bank $61 and read the word $60D8 + 2 * hTemp0;
; every non-zero word is $61D8 + 26 * n (E-0144, C1)
; record: special map record ($0000 = none)
SpecialMapTable::
    dw SpecialMapRecords ; id 0
    dw SpecialMapRecord01 ; id 1
    dw SpecialMapRecord02 ; id 2
    dw SpecialMapRecord03 ; id 3
    dw SpecialMapRecord04 ; id 4
    dw SpecialMapRecord05 ; id 5
    dw $0000 ; id 6
    dw $0000 ; id 7
    dw $0000 ; id 8
    dw $0000 ; id 9
    dw $0000 ; id 10
    dw $0000 ; id 11
    dw $0000 ; id 12
    dw $0000 ; id 13
    dw $0000 ; id 14
    dw $0000 ; id 15
    dw $0000 ; id 16
    dw $0000 ; id 17
    dw $0000 ; id 18
    dw $0000 ; id 19
    dw $0000 ; id 20
    dw $0000 ; id 21
    dw $0000 ; id 22
    dw $0000 ; id 23
    dw $0000 ; id 24
    dw $0000 ; id 25
    dw $0000 ; id 26
    dw $0000 ; id 27
    dw $0000 ; id 28
    dw $0000 ; id 29
    dw $0000 ; id 30
    dw $0000 ; id 31
    dw SpecialMapRecord06 ; id 32
    dw SpecialMapRecord07 ; id 33
    dw SpecialMapRecord08 ; id 34
    dw SpecialMapRecord09 ; id 35
    dw SpecialMapRecord0A ; id 36
    dw SpecialMapRecord0B ; id 37
    dw SpecialMapRecord0C ; id 38
    dw SpecialMapRecord0D ; id 39
    dw SpecialMapRecord0E ; id 40
    dw SpecialMapRecord0F ; id 41
    dw $0000 ; id 42
    dw $0000 ; id 43
    dw $0000 ; id 44
    dw $0000 ; id 45
    dw $0000 ; id 46
    dw $0000 ; id 47
    dw $0000 ; id 48
    dw $0000 ; id 49
    dw $0000 ; id 50
    dw $0000 ; id 51
    dw $0000 ; id 52
    dw $0000 ; id 53
    dw $0000 ; id 54
    dw $0000 ; id 55
    dw $0000 ; id 56
    dw $0000 ; id 57
    dw $0000 ; id 58
    dw $0000 ; id 59
    dw $0000 ; id 60
    dw $0000 ; id 61
    dw $0000 ; id 62
    dw $0000 ; id 63
    dw SpecialMapRecord10 ; id 64
    dw SpecialMapRecord11 ; id 65
    dw SpecialMapRecord12 ; id 66
    dw SpecialMapRecord13 ; id 67
    dw SpecialMapRecord14 ; id 68
    dw SpecialMapRecord15 ; id 69
    dw SpecialMapRecord16 ; id 70
    dw SpecialMapRecord17 ; id 71
    dw SpecialMapRecord18 ; id 72
    dw SpecialMapRecord19 ; id 73
    dw $0000 ; id 74
    dw $0000 ; id 75
    dw $0000 ; id 76
    dw $0000 ; id 77
    dw $0000 ; id 78
    dw $0000 ; id 79
    dw SpecialMapRecord1A ; id 80
    dw SpecialMapRecord1B ; id 81
    dw SpecialMapRecord1C ; id 82
    dw SpecialMapRecord1D ; id 83
    dw SpecialMapRecord1E ; id 84
    dw $0000 ; id 85
    dw $0000 ; id 86
    dw $0000 ; id 87
    dw $0000 ; id 88
    dw $0000 ; id 89
    dw $0000 ; id 90
    dw $0000 ; id 91
    dw $0000 ; id 92
    dw $0000 ; id 93
    dw $0000 ; id 94
    dw $0000 ; id 95
    dw $0000 ; id 96
    dw SpecialMapRecord1F ; id 97
    dw SpecialMapRecord20 ; id 98
    dw SpecialMapRecord21 ; id 99
    dw SpecialMapRecord22 ; id 100
    dw SpecialMapRecord22 ; id 101
    dw SpecialMapRecord22 ; id 102
    dw $0000 ; id 103
    dw $0000 ; id 104
    dw $0000 ; id 105
    dw $0000 ; id 106
    dw $0000 ; id 107
    dw $0000 ; id 108
    dw $0000 ; id 109
    dw $0000 ; id 110
    dw $0000 ; id 111
    dw $0000 ; id 112
    dw $0000 ; id 113
    dw $0000 ; id 114
    dw $0000 ; id 115
    dw $0000 ; id 116
    dw $0000 ; id 117
    dw $0000 ; id 118
    dw $0000 ; id 119
    dw $0000 ; id 120
    dw $0000 ; id 121
    dw $0000 ; id 122
    dw $0000 ; id 123
    dw $0000 ; id 124
    dw $0000 ; id 125
    dw $0000 ; id 126
    dw $0000 ; id 127

; LoadSpecialMapHeader decompresses the tileset to vTiles2, loads the palettes with
; LoadBGPaletteBufferFromBank and stores the five header bytes; LoadMapScreenFromChunk takes the far
; pointer at +$14 as the screen array (3 * (hMapScreenY * width + hMapScreenX)) and, on CGB, the one
; at +$17 as the attribute array; every array decodes to 360-byte screens (E-0144, C1)
; record: tileset; its ROM bank; palettes; its ROM bank; width, height, wMaxBlockingTile,
; wMapHeaderByte7, wFieldEventKind; 9 bytes not read by these routines; screen tile-map array; its
; ROM bank; screen attribute-map array; its ROM bank
SpecialMapRecords::
SpecialMapRecord00::
    dfar SpecialMap00Tileset ; id 0
    dfar SpecialMap00Palettes
    db $01, $02, $4f, $4c, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap00Screens
    dfar SpecialMap00Attrs
SpecialMapRecord01::
    dfar SpecialMap01Tileset ; id 1
    dfar SpecialMap01Palettes
    db $01, $02, $4f, $4c, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap01Screens
    dfar SpecialMap01Attrs
SpecialMapRecord02::
    dfar SpecialMap02Tileset ; id 2
    dfar SpecialMap02Palettes
    db $01, $02, $4f, $4c, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap02Screens
    dfar SpecialMap02Attrs
SpecialMapRecord03::
    dfar SpecialMap03Tileset ; id 3
    dfar SpecialMap03Palettes
    db $01, $02, $4f, $4c, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap03Screens
    dfar SpecialMap03Attrs
SpecialMapRecord04::
    dfar SpecialMap04Tileset ; id 4
    dfar SpecialMap04Palettes
    db $01, $02, $4f, $4c, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap04Screens
    dfar SpecialMap04Attrs
SpecialMapRecord05::
    dfar SpecialMap05Tileset ; id 5
    dfar SpecialMap05Palettes
    db $01, $02, $4f, $4c, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap05Screens
    dfar SpecialMap05Attrs
SpecialMapRecord06::
    dfar SpecialMap06Tileset ; id 6
    dfar SpecialMap06Palettes
    db $02, $02, $4f, $00, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap06Screens
    dfar SpecialMap06Attrs
SpecialMapRecord07::
    dfar SpecialMap07Tileset ; id 7
    dfar SpecialMap07Palettes
    db $02, $02, $4f, $00, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap07Screens
    dfar SpecialMap07Attrs
SpecialMapRecord08::
    dfar SpecialMap08Tileset ; id 8
    dfar SpecialMap08Palettes
    db $02, $02, $4f, $00, $01, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap08Screens
    dfar SpecialMap08Attrs
SpecialMapRecord09::
    dfar SpecialMap09Tileset ; id 9
    dfar SpecialMap09Palettes
    db $02, $02, $4f, $00, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap09Screens
    dfar SpecialMap09Attrs
SpecialMapRecord0A::
    dfar SpecialMap0ATileset ; id 10
    dfar SpecialMap0APalettes
    db $02, $02, $4f, $00, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap0AScreens
    dfar SpecialMap0AAttrs
SpecialMapRecord0B::
    dfar SpecialMap0BTileset ; id 11
    dfar SpecialMap0BPalettes
    db $02, $02, $4f, $00, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap0BScreens
    dfar SpecialMap0BAttrs
SpecialMapRecord0C::
    dfar SpecialMap0CTileset ; id 12
    dfar SpecialMap0CPalettes
    db $02, $02, $4f, $00, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap0CScreens
    dfar SpecialMap0CAttrs
SpecialMapRecord0D::
    dfar SpecialMap0DTileset ; id 13
    dfar SpecialMap0DPalettes
    db $02, $02, $4f, $00, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap0DScreens
    dfar SpecialMap0DAttrs
SpecialMapRecord0E::
    dfar SpecialMap0ETileset ; id 14
    dfar SpecialMap0EPalettes
    db $02, $02, $4f, $00, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap0EScreens
    dfar SpecialMap0EAttrs
SpecialMapRecord0F::
    dfar SpecialMap0FTileset ; id 15
    dfar SpecialMap0FPalettes
    db $02, $02, $4f, $00, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap0FScreens
    dfar SpecialMap0FAttrs
SpecialMapRecord10::
    dfar SpecialMap10Tileset ; id 16
    dfar SpecialMap10Palettes
    db $02, $01, $3f, $00, $00, $00, $00, $00, $40, $80, $00, $00, $40, $80
    dfar SpecialMap10Screens
    dfar SpecialMap10Attrs
SpecialMapRecord11::
    dfar SpecialMap11Tileset ; id 17
    dfar SpecialMap11Palettes
    db $02, $01, $3f, $00, $00, $00, $00, $00, $40, $80, $00, $00, $40, $80
    dfar SpecialMap11Screens
    dfar SpecialMap11Attrs
SpecialMapRecord12::
    dfar SpecialMap12Tileset ; id 18
    dfar SpecialMap12Palettes
    db $02, $01, $3f, $00, $00, $00, $00, $00, $40, $80, $00, $00, $40, $80
    dfar SpecialMap12Screens
    dfar SpecialMap12Attrs
SpecialMapRecord13::
    dfar SpecialMap13Tileset ; id 19
    dfar SpecialMap13Palettes
    db $02, $01, $3f, $00, $00, $00, $00, $00, $40, $80, $00, $00, $40, $80
    dfar SpecialMap13Screens
    dfar SpecialMap13Attrs
SpecialMapRecord14::
    dfar SpecialMap14Tileset ; id 20
    dfar SpecialMap14Palettes
    db $02, $01, $3f, $00, $00, $00, $00, $00, $40, $80, $00, $00, $40, $80
    dfar SpecialMap14Screens
    dfar SpecialMap14Attrs
SpecialMapRecord15::
    dfar SpecialMap15Tileset ; id 21
    dfar SpecialMap15Palettes
    db $02, $01, $3f, $00, $00, $00, $00, $00, $40, $80, $00, $00, $40, $80
    dfar SpecialMap15Screens
    dfar SpecialMap15Attrs
SpecialMapRecord16::
    dfar SpecialMap16Tileset ; id 22
    dfar SpecialMap16Palettes
    db $02, $01, $3f, $00, $00, $00, $00, $00, $40, $80, $00, $00, $40, $80
    dfar SpecialMap16Screens
    dfar SpecialMap16Attrs
SpecialMapRecord17::
    dfar SpecialMap17Tileset ; id 23
    dfar SpecialMap17Palettes
    db $02, $01, $3f, $00, $00, $00, $00, $00, $40, $80, $00, $00, $40, $80
    dfar SpecialMap17Screens
    dfar SpecialMap17Attrs
SpecialMapRecord18::
    dfar SpecialMap18Tileset ; id 24
    dfar SpecialMap18Palettes
    db $02, $01, $3f, $00, $01, $00, $00, $00, $40, $80, $00, $00, $40, $80
    dfar SpecialMap18Screens
    dfar SpecialMap18Attrs
SpecialMapRecord19::
    dfar SpecialMap19Tileset ; id 25
    dfar SpecialMap19Palettes
    db $02, $01, $3f, $00, $00, $00, $00, $00, $40, $80, $00, $00, $40, $80
    dfar SpecialMap19Screens
    dfar SpecialMap19Attrs
SpecialMapRecord1A::
    dfar SpecialMap1ATileset ; id 26
    dfar SpecialMap1APalettes
    db $01, $01, $3f, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    dfar SpecialMap1AScreens
    dfar SpecialMap1AAttrs
SpecialMapRecord1B::
    dfar SpecialMap1ATileset ; id 27
    dfar SpecialMap1APalettes
    db $01, $01, $3f, $3c, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    dfar SpecialMap1BScreens
    dfar SpecialMap1BAttrs
SpecialMapRecord1C::
    dfar SpecialMap1ATileset ; id 28
    dfar SpecialMap1APalettes
    db $01, $01, $3f, $3c, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    dfar SpecialMap1CScreens
    dfar SpecialMap1CAttrs
SpecialMapRecord1D::
    dfar SpecialMap1ATileset ; id 29
    dfar SpecialMap1APalettes
    db $01, $01, $3f, $3c, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    dfar SpecialMap1DScreens
    dfar SpecialMap1DAttrs
SpecialMapRecord1E::
    dfar SpecialMap1ATileset ; id 30
    dfar SpecialMap1APalettes
    db $01, $01, $3f, $3c, $00, $00, $00, $00, $40, $80, $00, $00, $50, $80
    dfar SpecialMap1EScreens
    dfar SpecialMap1EAttrs
SpecialMapRecord1F::
    dfar SpecialMap1FTileset ; id 31
    dfar SpecialMap1FPalettes
    db $01, $01, $23, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    dfar SpecialMap1FScreens
    dfar SpecialMap1FAttrs
SpecialMapRecord20::
    dfar SpecialMap20Tileset ; id 32
    dfar SpecialMap20Palettes
    db $01, $01, $23, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    dfar SpecialMap20Screens
    dfar SpecialMap20Attrs
SpecialMapRecord21::
    dfar SpecialMap21Tileset ; id 33
    dfar SpecialMap21Palettes
    db $01, $01, $19, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    dfar SpecialMap21Screens
    dfar SpecialMap21Attrs
SpecialMapRecord22::
    dfar Map29Tileset ; id 34
    dfar Map29Palettes
    db $01, $01, $32, $2c, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    dfar Map29Screens0
    dfar Map29Attrs0

; CheckKeyWorldWarpTable and CheckWarpsByMapType_Case03_Sub01 read the word at $6566 + 2 * (floor
; state byte 0 & $7F) and walk 9-byte entries until $80; an entry of kind $FE or $FF whose bytes 2-3
; equal hMapScreenX/Y and whose byte 4 is $FF warps to (byte 7, byte 8) on the floor's start screen;
; 128 words, then the lists up to TownObjectSpotGrid0 at $6705 (E-0195, C1)
; record: warp list for this floor-state value
KeyWorldWarpListTable::
    dw KeyWorldWarps00 ; id 0
    dw KeyWorldWarps00 ; id 1
    dw KeyWorldWarps00 ; id 2
    dw KeyWorldWarps00 ; id 3
    dw KeyWorldWarps00 ; id 4
    dw KeyWorldWarps00 ; id 5
    dw KeyWorldWarps06 ; id 6
    dw KeyWorldWarps06 ; id 7
    dw KeyWorldWarps06 ; id 8
    dw KeyWorldWarps06 ; id 9
    dw KeyWorldWarps06 ; id 10
    dw KeyWorldWarps06 ; id 11
    dw KeyWorldWarps06 ; id 12
    dw KeyWorldWarps06 ; id 13
    dw KeyWorldWarps06 ; id 14
    dw KeyWorldWarps06 ; id 15
    dw KeyWorldWarps06 ; id 16
    dw KeyWorldWarps06 ; id 17
    dw KeyWorldWarps06 ; id 18
    dw KeyWorldWarps06 ; id 19
    dw KeyWorldWarps06 ; id 20
    dw KeyWorldWarps06 ; id 21
    dw KeyWorldWarps06 ; id 22
    dw KeyWorldWarps06 ; id 23
    dw KeyWorldWarps06 ; id 24
    dw KeyWorldWarps06 ; id 25
    dw KeyWorldWarps06 ; id 26
    dw KeyWorldWarps06 ; id 27
    dw KeyWorldWarps06 ; id 28
    dw KeyWorldWarps06 ; id 29
    dw KeyWorldWarps06 ; id 30
    dw KeyWorldWarps06 ; id 31
    dw KeyWorldWarps20 ; id 32
    dw KeyWorldWarps20 ; id 33
    dw KeyWorldWarps20 ; id 34
    dw KeyWorldWarps20 ; id 35
    dw KeyWorldWarps20 ; id 36
    dw KeyWorldWarps20 ; id 37
    dw KeyWorldWarps20 ; id 38
    dw KeyWorldWarps20 ; id 39
    dw KeyWorldWarps20 ; id 40
    dw KeyWorldWarps20 ; id 41
    dw KeyWorldWarps06 ; id 42
    dw KeyWorldWarps06 ; id 43
    dw KeyWorldWarps06 ; id 44
    dw KeyWorldWarps06 ; id 45
    dw KeyWorldWarps06 ; id 46
    dw KeyWorldWarps06 ; id 47
    dw KeyWorldWarps06 ; id 48
    dw KeyWorldWarps06 ; id 49
    dw KeyWorldWarps06 ; id 50
    dw KeyWorldWarps06 ; id 51
    dw KeyWorldWarps06 ; id 52
    dw KeyWorldWarps06 ; id 53
    dw KeyWorldWarps06 ; id 54
    dw KeyWorldWarps06 ; id 55
    dw KeyWorldWarps06 ; id 56
    dw KeyWorldWarps06 ; id 57
    dw KeyWorldWarps06 ; id 58
    dw KeyWorldWarps06 ; id 59
    dw KeyWorldWarps06 ; id 60
    dw KeyWorldWarps06 ; id 61
    dw KeyWorldWarps06 ; id 62
    dw KeyWorldWarps06 ; id 63
    dw KeyWorldWarps40 ; id 64
    dw KeyWorldWarps40 ; id 65
    dw KeyWorldWarps40 ; id 66
    dw KeyWorldWarps40 ; id 67
    dw KeyWorldWarps40 ; id 68
    dw KeyWorldWarps40 ; id 69
    dw KeyWorldWarps40 ; id 70
    dw KeyWorldWarps40 ; id 71
    dw KeyWorldWarps40 ; id 72
    dw KeyWorldWarps40 ; id 73
    dw KeyWorldWarps06 ; id 74
    dw KeyWorldWarps06 ; id 75
    dw KeyWorldWarps06 ; id 76
    dw KeyWorldWarps06 ; id 77
    dw KeyWorldWarps06 ; id 78
    dw KeyWorldWarps06 ; id 79
    dw KeyWorldWarps06 ; id 80
    dw KeyWorldWarps06 ; id 81
    dw KeyWorldWarps06 ; id 82
    dw KeyWorldWarps06 ; id 83
    dw KeyWorldWarps54 ; id 84
    dw KeyWorldWarps06 ; id 85
    dw KeyWorldWarps06 ; id 86
    dw KeyWorldWarps06 ; id 87
    dw KeyWorldWarps06 ; id 88
    dw KeyWorldWarps06 ; id 89
    dw KeyWorldWarps06 ; id 90
    dw KeyWorldWarps06 ; id 91
    dw KeyWorldWarps06 ; id 92
    dw KeyWorldWarps06 ; id 93
    dw KeyWorldWarps06 ; id 94
    dw KeyWorldWarps06 ; id 95
    dw KeyWorldWarps06 ; id 96
    dw KeyWorldWarps06 ; id 97
    dw KeyWorldWarps06 ; id 98
    dw KeyWorldWarps63 ; id 99
    dw KeyWorldWarps06 ; id 100
    dw KeyWorldWarps06 ; id 101
    dw KeyWorldWarps06 ; id 102
    dw KeyWorldWarps06 ; id 103
    dw KeyWorldWarps06 ; id 104
    dw KeyWorldWarps06 ; id 105
    dw KeyWorldWarps06 ; id 106
    dw KeyWorldWarps06 ; id 107
    dw KeyWorldWarps06 ; id 108
    dw KeyWorldWarps06 ; id 109
    dw KeyWorldWarps06 ; id 110
    dw KeyWorldWarps06 ; id 111
    dw KeyWorldWarps06 ; id 112
    dw KeyWorldWarps06 ; id 113
    dw KeyWorldWarps06 ; id 114
    dw KeyWorldWarps06 ; id 115
    dw KeyWorldWarps06 ; id 116
    dw KeyWorldWarps06 ; id 117
    dw KeyWorldWarps06 ; id 118
    dw KeyWorldWarps06 ; id 119
    dw KeyWorldWarps06 ; id 120
    dw KeyWorldWarps06 ; id 121
    dw KeyWorldWarps06 ; id 122
    dw KeyWorldWarps06 ; id 123
    dw KeyWorldWarps06 ; id 124
    dw KeyWorldWarps06 ; id 125
    dw KeyWorldWarps06 ; id 126
    dw KeyWorldWarps06 ; id 127

; list for entry $06 of KeyWorldWarpListTable; 0 record(s), then $80 (E-0157)
; record: kind ($FE/$FF = warp, $FD and others skipped; stored in wWarpDestFacing), byte 1, screen
; X, screen Y, $FF (other values end the search), 2 bytes, destination X, destination Y
KeyWorldWarps06::
    db $80 ; end

; list for entry $00 of KeyWorldWarpListTable; 1 record(s), then $80 (E-0157)
KeyWorldWarps00::
    db $fe, $00, $00, $02, $ff ; id 0: kind, byte 1 (not read), screen X, screen Y, $FF
    db $ff, $ff ; not read here
    db $40, $40 ; wWarpDestX, wWarpDestY
    db $80 ; end

; list for entry $20 of KeyWorldWarpListTable; 9 record(s), then $80 (E-0157)
KeyWorldWarps20::
    db $fe, $00, $ff, $00, $ff ; id 0: kind, byte 1 (not read), screen X, screen Y, $FF
    db $ff, $ff ; not read here
    db $40, $40 ; wWarpDestX, wWarpDestY
    db $fe, $00, $00, $ff, $ff ; id 1: kind, byte 1 (not read), screen X, screen Y, $FF
    db $ff, $ff ; not read here
    db $40, $40 ; wWarpDestX, wWarpDestY
    db $fe, $00, $01, $ff, $ff ; id 2: kind, byte 1 (not read), screen X, screen Y, $FF
    db $ff, $ff ; not read here
    db $40, $40 ; wWarpDestX, wWarpDestY
    db $fe, $00, $02, $00, $ff ; id 3: kind, byte 1 (not read), screen X, screen Y, $FF
    db $ff, $ff ; not read here
    db $40, $40 ; wWarpDestX, wWarpDestY
    db $fe, $00, $ff, $01, $ff ; id 4: kind, byte 1 (not read), screen X, screen Y, $FF
    db $ff, $ff ; not read here
    db $40, $40 ; wWarpDestX, wWarpDestY
    db $fe, $00, $02, $01, $ff ; id 5: kind, byte 1 (not read), screen X, screen Y, $FF
    db $ff, $ff ; not read here
    db $40, $40 ; wWarpDestX, wWarpDestY
    db $fe, $00, $00, $02, $ff ; id 6: kind, byte 1 (not read), screen X, screen Y, $FF
    db $ff, $ff ; not read here
    db $40, $40 ; wWarpDestX, wWarpDestY
    db $fe, $00, $01, $02, $ff ; id 7: kind, byte 1 (not read), screen X, screen Y, $FF
    db $ff, $ff ; not read here
    db $40, $40 ; wWarpDestX, wWarpDestY
    db $fd, $01, $40, $30, $f2 ; id 8: kind, byte 1 (not read), screen X, screen Y, $FF
    db $00, $00 ; not read here
    db $04, $08 ; wWarpDestX, wWarpDestY
    db $80 ; end

; list for entry $40 of KeyWorldWarpListTable; 6 record(s), then $80 (E-0157)
KeyWorldWarps40::
    db $fe, $00, $ff, $00, $ff ; id 0: kind, byte 1 (not read), screen X, screen Y, $FF
    db $ff, $ff ; not read here
    db $40, $40 ; wWarpDestX, wWarpDestY
    db $fe, $00, $00, $ff, $ff ; id 1: kind, byte 1 (not read), screen X, screen Y, $FF
    db $ff, $ff ; not read here
    db $40, $40 ; wWarpDestX, wWarpDestY
    db $fe, $00, $01, $ff, $ff ; id 2: kind, byte 1 (not read), screen X, screen Y, $FF
    db $ff, $ff ; not read here
    db $40, $40 ; wWarpDestX, wWarpDestY
    db $fe, $00, $02, $00, $ff ; id 3: kind, byte 1 (not read), screen X, screen Y, $FF
    db $ff, $ff ; not read here
    db $40, $40 ; wWarpDestX, wWarpDestY
    db $fe, $00, $00, $01, $ff ; id 4: kind, byte 1 (not read), screen X, screen Y, $FF
    db $ff, $ff ; not read here
    db $40, $40 ; wWarpDestX, wWarpDestY
    db $fe, $00, $01, $01, $ff ; id 5: kind, byte 1 (not read), screen X, screen Y, $FF
    db $ff, $ff ; not read here
    db $40, $40 ; wWarpDestX, wWarpDestY
    db $80 ; end

; list for entry $54 of KeyWorldWarpListTable; 1 record(s), then $80 (E-0157)
; record: kind ($FE/$FF = warp, $FD and others skipped; stored in wWarpDestFacing), byte 1, screen
; X, screen Y, $FF (other values end the search), 2 bytes, destination X, destination Y
KeyWorldWarps54::
    db $fe, $00, $00, $01, $ff ; id 0: kind, byte 1 (not read), screen X, screen Y, $FF
    db $ff, $ff ; not read here
    db $40, $40 ; wWarpDestX, wWarpDestY
    db $80 ; end

; list for entry $63 of KeyWorldWarpListTable; 0 record(s), then $80 (E-0157)
KeyWorldWarps63::
    db $80 ; end

; SetupTownObjectsForMap case 0 (band 0 (SetupTownObjectsForMap.set_map_object_count_to_0A),
; wMapObjectCount $0A) passes $6705 to RemoveMapObjectsEntryMatching;
; RemoveMapObjectsEntryMatching_NextRandomSeed picks a random screen inside wMapWidthScreens x
; wMapHeightScreens and reads, with ReadByteInBank B = $61, the pair at $6705 + (screen Y * width +
; screen X) * 8 + 2 * (random & 3): a first byte of $FE draws a new screen, $FF a new spot,
; otherwise its nibbles place the object; 64 screens (E-0194, C1)
; record: one screen: four candidate spots (two bytes each); $FE first byte = none on this screen,
; $FF = draw again
TownObjectSpotGrid0::
    db $03, $02, $05, $05, $07, $04, $08, $06 ; id 0
    db $02, $04, $03, $07, $06, $06, $08, $03 ; id 1
    db $01, $03, $03, $07, $04, $05, $06, $06 ; id 2
    db $04, $05, $06, $01, $07, $03, $ff, $ff ; id 3
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 4
    db $02, $07, $05, $02, $06, $04, $07, $06 ; id 5
    db $02, $05, $03, $02, $04, $07, $07, $04 ; id 6
    db $02, $01, $02, $05, $04, $03, $06, $06 ; id 7
    db $04, $06, $07, $02, $07, $07, $ff, $ff ; id 8
    db $01, $03, $03, $05, $05, $02, $08, $04 ; id 9
    db $03, $02, $03, $05, $04, $07, $06, $06 ; id 10
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 11
    db $02, $02, $03, $06, $06, $03, $08, $05 ; id 12
    db $02, $06, $03, $02, $05, $05, $07, $01 ; id 13
    db $02, $03, $05, $05, $06, $01, $07, $06 ; id 14
    db $02, $07, $03, $03, $05, $05, $06, $02 ; id 15
    db $04, $03, $07, $04, $08, $01, $ff, $ff ; id 16
    db $02, $02, $04, $07, $05, $01, $08, $06 ; id 17
    db $02, $06, $03, $07, $04, $02, $05, $05 ; id 18
    db $02, $05, $04, $03, $06, $06, $07, $02 ; id 19
    db $02, $04, $05, $03, $07, $01, $07, $06 ; id 20
    db $02, $07, $03, $02, $06, $03, $08, $06 ; id 21
    db $02, $03, $04, $04, $05, $06, $07, $02 ; id 22
    db $01, $06, $02, $07, $03, $01, $ff, $ff ; id 23
    db $02, $06, $04, $03, $05, $04, $06, $05 ; id 24
    db $04, $04, $06, $05, $07, $02, $08, $07 ; id 25
    db $01, $04, $03, $02, $03, $06, $04, $03 ; id 26
    db $02, $02, $04, $05, $05, $03, $07, $06 ; id 27
    db $02, $05, $03, $02, $05, $03, $05, $06 ; id 28
    db $02, $03, $04, $06, $06, $05, $07, $02 ; id 29
    db $01, $07, $03, $05, $05, $03, $07, $06 ; id 30
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 31
    db $03, $04, $05, $03, $06, $06, $08, $01 ; id 32
    db $05, $05, $06, $07, $07, $03, $08, $06 ; id 33
    db $02, $02, $03, $06, $05, $07, $07, $03 ; id 34
    db $02, $02, $02, $06, $06, $03, $07, $05 ; id 35
    db $02, $03, $02, $06, $04, $04, $06, $02 ; id 36
    db $03, $06, $04, $04, $06, $07, $07, $03 ; id 37
    db $03, $06, $05, $04, $07, $05, $08, $01 ; id 38
    db $02, $05, $03, $02, $04, $03, $ff, $ff ; id 39
    db $05, $06, $06, $07, $07, $05, $ff, $ff ; id 40
    db $03, $06, $06, $02, $06, $04, $08, $07 ; id 41
    db $02, $05, $04, $02, $05, $07, $07, $04 ; id 42
    db $02, $04, $04, $07, $05, $01, $07, $05 ; id 43
    db $02, $07, $03, $03, $04, $05, $ff, $ff ; id 44
    db $02, $05, $03, $02, $05, $06, $07, $04 ; id 45
    db $02, $05, $04, $07, $06, $03, $06, $06 ; id 46
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 47
    db $06, $02, $07, $01, $08, $04, $ff, $ff ; id 48
    db $01, $04, $04, $02, $06, $03, $ff, $ff ; id 49
    db $01, $05, $03, $02, $04, $06, $07, $03 ; id 50
    db $02, $07, $03, $03, $05, $02, $07, $06 ; id 51
    db $02, $04, $05, $07, $06, $06, $08, $05 ; id 52
    db $01, $04, $02, $02, $05, $03, $07, $06 ; id 53
    db $01, $05, $02, $03, $04, $06, $07, $04 ; id 54
    db $02, $02, $02, $04, $03, $05, $ff, $ff ; id 55
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 56
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 57
    db $03, $02, $05, $05, $07, $03, $08, $01 ; id 58
    db $02, $06, $03, $03, $07, $02, $07, $04 ; id 59
    db $02, $05, $03, $02, $04, $07, $07, $03 ; id 60
    db $02, $03, $03, $01, $06, $02, $ff, $ff ; id 61
    db $03, $01, $05, $04, $06, $02, $07, $03 ; id 62
    db $03, $04, $05, $01, $05, $05, $08, $03 ; id 63

; SetupTownObjectsForMap case 1 (band 3, wMapObjectCount $0A) passes $6905 to
; RemoveMapObjectsEntryMatching; RemoveMapObjectsEntryMatching_NextRandomSeed picks a random screen
; inside wMapWidthScreens x wMapHeightScreens and reads, with ReadByteInBank B = $61, the pair at
; $6905 + (screen Y * width + screen X) * 8 + 2 * (random & 3): a first byte of $FE draws a new
; screen, $FF a new spot, otherwise its nibbles place the object; 64 screens (E-0194, C1)
TownObjectSpotGrid1::
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 0
    db $01, $03, $04, $05, $05, $01, $07, $07 ; id 1
    db $03, $04, $03, $06, $06, $07, $ff, $ff ; id 2
    db $04, $06, $07, $04, $08, $07, $ff, $ff ; id 3
    db $01, $04, $02, $05, $03, $07, $ff, $ff ; id 4
    db $04, $04, $04, $07, $06, $02, $07, $06 ; id 5
    db $02, $03, $03, $06, $06, $05, $07, $07 ; id 6
    db $02, $06, $03, $05, $04, $04, $ff, $ff ; id 7
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 8
    db $02, $06, $05, $05, $02, $06, $05, $05 ; id 9
    db $03, $01, $04, $04, $07, $02, $08, $06 ; id 10
    db $02, $05, $05, $02, $07, $06, $08, $03 ; id 11
    db $03, $04, $05, $02, $05, $06, $08, $07 ; id 12
    db $02, $05, $03, $03, $07, $02, $08, $06 ; id 13
    db $01, $06, $03, $03, $04, $07, $07, $02 ; id 14
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 15
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 16
    db $03, $03, $05, $05, $03, $05, $03, $05 ; id 17
    db $03, $05, $07, $01, $07, $04, $ff, $ff ; id 18
    db $02, $02, $04, $04, $06, $06, $ff, $ff ; id 19
    db $01, $04, $03, $02, $06, $03, $07, $01 ; id 20
    db $06, $04, $07, $05, $08, $02, $ff, $ff ; id 21
    db $02, $02, $02, $06, $03, $03, $ff, $ff ; id 22
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 23
    db $02, $03, $05, $06, $07, $05, $ff, $ff ; id 24
    db $02, $05, $04, $03, $04, $07, $07, $06 ; id 25
    db $02, $05, $05, $07, $06, $03, $07, $06 ; id 26
    db $03, $02, $03, $06, $07, $05, $08, $03 ; id 27
    db $03, $06, $05, $01, $06, $05, $07, $03 ; id 28
    db $04, $06, $06, $07, $07, $05, $ff, $ff ; id 29
    db $02, $04, $03, $06, $05, $07, $ff, $ff ; id 30
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 31
    db $02, $04, $03, $05, $05, $06, $07, $03 ; id 32
    db $01, $07, $03, $04, $04, $06, $05, $02 ; id 33
    db $03, $07, $05, $06, $07, $03, $07, $05 ; id 34
    db $02, $02, $05, $07, $07, $03, $ff, $ff ; id 35
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 36
    db $05, $04, $06, $02, $06, $05, $ff, $ff ; id 37
    db $02, $02, $02, $04, $03, $03, $ff, $ff ; id 38
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 39
    db $04, $02, $06, $01, $07, $04, $ff, $ff ; id 40
    db $02, $05, $04, $03, $06, $01, $ff, $ff ; id 41
    db $02, $03, $05, $07, $06, $02, $07, $04 ; id 42
    db $02, $04, $03, $02, $03, $07, $07, $05 ; id 43
    db $01, $06, $03, $05, $07, $02, $ff, $ff ; id 44
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 45
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 46
    db $04, $06, $06, $01, $06, $04, $ff, $ff ; id 47
    db $03, $05, $06, $04, $03, $05, $06, $04 ; id 48
    db $04, $05, $05, $03, $04, $05, $05, $03 ; id 49
    db $06, $06, $07, $02, $06, $06, $07, $02 ; id 50
    db $02, $05, $03, $02, $05, $04, $07, $03 ; id 51
    db $02, $02, $03, $06, $04, $03, $06, $05 ; id 52
    db $01, $07, $04, $06, $07, $03, $ff, $ff ; id 53
    db $02, $06, $05, $05, $07, $04, $07, $07 ; id 54
    db $01, $03, $02, $04, $04, $06, $07, $05 ; id 55
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 56
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 57
    db $04, $02, $07, $01, $04, $02, $07, $01 ; id 58
    db $03, $02, $07, $01, $03, $02, $07, $01 ; id 59
    db $02, $06, $04, $04, $05, $05, $08, $03 ; id 60
    db $02, $03, $04, $01, $07, $02, $ff, $ff ; id 61
    db $01, $04, $03, $03, $05, $02, $ff, $ff ; id 62
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 63

; SetupTownObjectsForMap case 2 (band 6, wMapObjectCount $0F) passes $6B05 to
; RemoveMapObjectsEntryMatching; RemoveMapObjectsEntryMatching_NextRandomSeed picks a random screen
; inside wMapWidthScreens x wMapHeightScreens and reads, with ReadByteInBank B = $61, the pair at
; $6B05 + (screen Y * width + screen X) * 8 + 2 * (random & 3): a first byte of $FE draws a new
; screen, $FF a new spot, otherwise its nibbles place the object; 144 screens (E-0194, C1)
TownObjectSpotGrid2::
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 0
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 1
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 2
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 3
    db $06, $07, $07, $06, $06, $07, $07, $06 ; id 4
    db $02, $03, $03, $06, $05, $01, $07, $05 ; id 5
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 6
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 7
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 8
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 9
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 10
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 11
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 12
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 13
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 14
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 15
    db $04, $04, $05, $06, $06, $02, $07, $05 ; id 16
    db $02, $02, $02, $06, $04, $04, $08, $03 ; id 17
    db $02, $03, $03, $07, $05, $04, $07, $06 ; id 18
    db $02, $04, $04, $03, $05, $05, $07, $06 ; id 19
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 20
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 21
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 22
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 23
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 24
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 25
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 26
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 27
    db $05, $04, $06, $03, $07, $02, $07, $06 ; id 28
    db $02, $06, $04, $03, $07, $02, $07, $05 ; id 29
    db $02, $05, $03, $02, $06, $06, $07, $01 ; id 30
    db $02, $05, $03, $06, $05, $03, $07, $02 ; id 31
    db $02, $05, $03, $02, $07, $01, $07, $06 ; id 32
    db $01, $02, $03, $06, $05, $04, $07, $03 ; id 33
    db $02, $05, $04, $03, $05, $02, $07, $06 ; id 34
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 35
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 36
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 37
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 38
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 39
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 40
    db $02, $06, $03, $03, $03, $07, $07, $04 ; id 41
    db $03, $05, $05, $02, $06, $03, $07, $06 ; id 42
    db $02, $03, $07, $02, $07, $05, $ff, $ff ; id 43
    db $01, $07, $03, $04, $05, $01, $07, $03 ; id 44
    db $02, $03, $04, $04, $06, $05, $07, $02 ; id 45
    db $02, $03, $03, $06, $05, $05, $07, $02 ; id 46
    db $02, $05, $02, $07, $03, $03, $05, $06 ; id 47
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 48
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 49
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 50
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 51
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 52
    db $03, $06, $06, $04, $06, $07, $07, $05 ; id 53
    db $02, $01, $02, $04, $04, $03, $ff, $ff ; id 54
    db $02, $06, $06, $04, $07, $05, $ff, $ff ; id 55
    db $02, $03, $06, $06, $07, $04, $08, $02 ; id 56
    db $02, $07, $03, $02, $04, $05, $06, $03 ; id 57
    db $04, $02, $05, $06, $07, $03, $07, $05 ; id 58
    db $02, $02, $02, $05, $07, $03, $07, $06 ; id 59
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 60
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 61
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 62
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 63
    db $02, $03, $03, $02, $04, $05, $07, $04 ; id 64
    db $02, $02, $03, $01, $06, $03, $07, $05 ; id 65
    db $02, $03, $02, $06, $06, $02, $ff, $ff ; id 66
    db $02, $01, $02, $05, $07, $02, $ff, $ff ; id 67
    db $06, $03, $07, $02, $06, $03, $07, $02 ; id 68
    db $01, $02, $02, $01, $01, $02, $02, $01 ; id 69
    db $03, $06, $06, $01, $06, $07, $07, $02 ; id 70
    db $02, $01, $04, $02, $02, $01, $04, $02 ; id 71
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 72
    db $04, $05, $06, $06, $07, $04, $ff, $ff ; id 73
    db $02, $03, $03, $06, $05, $05, $07, $04 ; id 74
    db $02, $05, $04, $06, $06, $03, $07, $04 ; id 75
    db $02, $03, $04, $06, $07, $02, $08, $05 ; id 76
    db $02, $05, $03, $02, $06, $03, $06, $06 ; id 77
    db $01, $02, $02, $04, $03, $06, $ff, $ff ; id 78
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 79
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 80
    db $07, $06, $08, $04, $07, $06, $08, $04 ; id 81
    db $02, $02, $04, $04, $06, $06, $07, $03 ; id 82
    db $02, $02, $02, $04, $03, $05, $04, $03 ; id 83
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 84
    db $03, $03, $04, $05, $07, $02, $07, $04 ; id 85
    db $03, $06, $04, $03, $06, $02, $08, $05 ; id 86
    db $02, $04, $04, $05, $06, $03, $07, $06 ; id 87
    db $02, $02, $06, $04, $07, $01, $08, $03 ; id 88
    db $05, $02, $06, $04, $07, $03, $ff, $ff ; id 89
    db $01, $04, $02, $02, $03, $03, $ff, $ff ; id 90
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 91
    db $03, $05, $05, $03, $03, $05, $05, $03 ; id 92
    db $04, $06, $05, $04, $07, $02, $07, $07 ; id 93
    db $02, $06, $03, $03, $03, $05, $06, $02 ; id 94
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 95
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 96
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 97
    db $05, $02, $06, $06, $07, $04, $08, $01 ; id 98
    db $02, $03, $04, $06, $05, $02, $07, $04 ; id 99
    db $02, $03, $02, $05, $03, $02, $03, $06 ; id 100
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 101
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 102
    db $07, $07, $08, $06, $07, $07, $08, $06 ; id 103
    db $01, $06, $02, $07, $01, $06, $02, $07 ; id 104
    db $05, $06, $06, $02, $08, $05, $ff, $ff ; id 105
    db $02, $06, $03, $03, $04, $05, $ff, $ff ; id 106
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 107
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 108
    db $03, $07, $05, $06, $07, $05, $ff, $ff ; id 109
    db $02, $05, $05, $02, $08, $03, $08, $07 ; id 110
    db $01, $07, $03, $04, $06, $02, $07, $05 ; id 111
    db $02, $02, $02, $04, $02, $06, $08, $05 ; id 112
    db $02, $04, $03, $03, $04, $06, $06, $05 ; id 113
    db $02, $05, $03, $04, $05, $06, $06, $03 ; id 114
    db $01, $05, $03, $04, $07, $02, $ff, $ff ; id 115
    db $02, $02, $03, $04, $05, $05, $07, $06 ; id 116
    db $02, $04, $04, $07, $07, $02, $07, $06 ; id 117
    db $02, $06, $03, $03, $06, $02, $07, $04 ; id 118
    db $02, $04, $02, $07, $03, $06, $ff, $ff ; id 119
    db $03, $07, $05, $05, $07, $04, $08, $06 ; id 120
    db $02, $06, $04, $05, $06, $02, $07, $03 ; id 121
    db $02, $03, $05, $07, $07, $02, $07, $05 ; id 122
    db $02, $04, $04, $06, $06, $01, $06, $07 ; id 123
    db $03, $02, $03, $07, $06, $05, $07, $06 ; id 124
    db $02, $06, $04, $02, $05, $05, $06, $07 ; id 125
    db $01, $06, $02, $04, $04, $02, $ff, $ff ; id 126
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 127
    db $04, $03, $06, $02, $07, $05, $ff, $ff ; id 128
    db $02, $05, $03, $02, $04, $06, $06, $03 ; id 129
    db $02, $06, $04, $03, $07, $02, $07, $05 ; id 130
    db $02, $02, $02, $06, $05, $03, $06, $05 ; id 131
    db $02, $01, $04, $03, $06, $02, $07, $04 ; id 132
    db $02, $04, $04, $02, $04, $06, $07, $03 ; id 133
    db $02, $04, $03, $02, $05, $01, $ff, $ff ; id 134
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 135
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 136
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 137
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 138
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 139
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 140
    db $04, $01, $06, $02, $07, $03, $ff, $ff ; id 141
    db $02, $03, $05, $04, $06, $02, $06, $05 ; id 142
    db $02, $02, $03, $04, $05, $05, $07, $03 ; id 143

; SetupTownObjectsForMap case 3 (band 9, wMapObjectCount $0F) passes $6F85 to
; RemoveMapObjectsEntryMatching; RemoveMapObjectsEntryMatching_NextRandomSeed picks a random screen
; inside wMapWidthScreens x wMapHeightScreens and reads, with ReadByteInBank B = $61, the pair at
; $6F85 + (screen Y * width + screen X) * 8 + 2 * (random & 3): a first byte of $FE draws a new
; screen, $FF a new spot, otherwise its nibbles place the object; 144 screens (E-0194, C1)
TownObjectSpotGrid3::
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 0
    db $02, $06, $05, $04, $06, $07, $ff, $ff ; id 1
    db $01, $05, $03, $02, $04, $06, $05, $04 ; id 2
    db $02, $02, $03, $04, $06, $05, $07, $06 ; id 3
    db $02, $04, $02, $07, $05, $06, $07, $05 ; id 4
    db $01, $05, $02, $06, $06, $07, $ff, $ff ; id 5
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 6
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 7
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 8
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 9
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 10
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 11
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 12
    db $03, $02, $03, $05, $05, $06, $07, $04 ; id 13
    db $02, $04, $03, $02, $05, $03, $ff, $ff ; id 14
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 15
    db $02, $04, $04, $02, $04, $07, $07, $06 ; id 16
    db $02, $02, $02, $06, $04, $05, $06, $04 ; id 17
    db $02, $04, $02, $06, $04, $05, $ff, $ff ; id 18
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 19
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 20
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 21
    db $05, $06, $06, $01, $07, $05, $ff, $ff ; id 22
    db $02, $04, $02, $06, $02, $04, $02, $06 ; id 23
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 24
    db $04, $04, $06, $05, $04, $04, $06, $05 ; id 25
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 26
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 27
    db $05, $04, $06, $02, $08, $03, $ff, $ff ; id 28
    db $02, $02, $05, $07, $06, $01, $07, $04 ; id 29
    db $02, $02, $03, $05, $07, $01, $07, $04 ; id 30
    db $02, $03, $04, $04, $05, $02, $ff, $ff ; id 31
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 32
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 33
    db $05, $02, $06, $05, $07, $03, $ff, $ff ; id 34
    db $02, $03, $03, $06, $05, $05, $06, $02 ; id 35
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 36
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 37
    db $03, $05, $06, $04, $07, $06, $ff, $ff ; id 38
    db $01, $06, $03, $03, $05, $05, $06, $02 ; id 39
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 40
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 41
    db $04, $02, $04, $05, $07, $03, $07, $06 ; id 42
    db $02, $03, $03, $05, $05, $02, $05, $04 ; id 43
    db $03, $07, $04, $04, $05, $05, $07, $03 ; id 44
    db $02, $02, $02, $06, $04, $03, $05, $05 ; id 45
    db $06, $02, $06, $06, $08, $05, $ff, $ff ; id 46
    db $01, $06, $02, $04, $05, $03, $06, $02 ; id 47
    db $05, $06, $06, $02, $07, $05, $ff, $ff ; id 48
    db $01, $03, $02, $06, $06, $02, $07, $05 ; id 49
    db $03, $06, $06, $02, $07, $05, $ff, $ff ; id 50
    db $02, $02, $04, $06, $05, $04, $07, $05 ; id 51
    db $01, $07, $02, $05, $03, $06, $ff, $ff ; id 52
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 53
    db $03, $04, $05, $02, $06, $03, $07, $01 ; id 54
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 55
    db $03, $05, $05, $02, $07, $03, $07, $06 ; id 56
    db $02, $03, $03, $06, $05, $02, $ff, $ff ; id 57
    db $03, $02, $06, $03, $08, $01, $ff, $ff ; id 58
    db $02, $02, $06, $03, $05, $07, $ff, $ff ; id 59
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 60
    db $02, $02, $05, $01, $06, $06, $07, $04 ; id 61
    db $01, $07, $03, $05, $05, $01, $07, $05 ; id 62
    db $02, $05, $04, $03, $06, $06, $07, $02 ; id 63
    db $02, $05, $05, $03, $07, $06, $ff, $ff ; id 64
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 65
    db $05, $04, $06, $02, $06, $06, $ff, $ff ; id 66
    db $02, $05, $04, $04, $06, $06, $07, $03 ; id 67
    db $02, $04, $04, $07, $05, $03, $07, $05 ; id 68
    db $03, $04, $04, $06, $05, $03, $ff, $ff ; id 69
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 70
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 71
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 72
    db $02, $07, $03, $05, $06, $04, $07, $06 ; id 73
    db $02, $03, $03, $06, $05, $05, $06, $02 ; id 74
    db $03, $02, $06, $01, $07, $05, $ff, $ff ; id 75
    db $03, $06, $06, $04, $07, $05, $ff, $ff ; id 76
    db $02, $03, $02, $07, $06, $06, $07, $04 ; id 77
    db $02, $05, $03, $03, $06, $02, $07, $06 ; id 78
    db $02, $02, $03, $05, $04, $07, $07, $02 ; id 79
    db $03, $06, $04, $03, $05, $04, $07, $02 ; id 80
    db $01, $04, $04, $02, $05, $03, $ff, $ff ; id 81
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 82
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 83
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 84
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 85
    db $03, $03, $05, $05, $07, $07, $08, $02 ; id 86
    db $02, $03, $06, $04, $07, $06, $ff, $ff ; id 87
    db $03, $05, $06, $02, $06, $06, $07, $03 ; id 88
    db $02, $04, $04, $05, $05, $02, $06, $07 ; id 89
    db $02, $04, $03, $05, $04, $02, $06, $02 ; id 90
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 91
    db $03, $03, $05, $06, $06, $01, $06, $04 ; id 92
    db $02, $04, $03, $03, $04, $06, $ff, $ff ; id 93
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 94
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 95
    db $04, $06, $06, $07, $07, $05, $ff, $ff ; id 96
    db $02, $05, $03, $03, $04, $06, $05, $04 ; id 97
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 98
    db $03, $04, $05, $06, $06, $02, $06, $05 ; id 99
    db $02, $03, $03, $05, $06, $02, $07, $06 ; id 100
    db $02, $04, $03, $06, $07, $05, $ff, $ff ; id 101
    db $02, $04, $04, $02, $05, $06, $07, $05 ; id 102
    db $04, $04, $04, $06, $06, $03, $07, $05 ; id 103
    db $02, $01, $02, $03, $04, $07, $06, $03 ; id 104
    db $02, $05, $03, $03, $05, $02, $ff, $ff ; id 105
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 106
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 107
    db $04, $03, $04, $07, $05, $05, $07, $02 ; id 108
    db $02, $04, $03, $02, $03, $06, $ff, $ff ; id 109
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 110
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 111
    db $02, $06, $04, $05, $06, $02, $08, $03 ; id 112
    db $03, $02, $07, $03, $07, $06, $ff, $ff ; id 113
    db $01, $04, $05, $03, $07, $01, $07, $05 ; id 114
    db $02, $01, $02, $05, $05, $04, $07, $03 ; id 115
    db $02, $03, $02, $05, $03, $01, $07, $02 ; id 116
    db $05, $07, $07, $04, $07, $06, $ff, $ff ; id 117
    db $02, $04, $03, $01, $08, $02, $ff, $ff ; id 118
    db $03, $06, $05, $01, $07, $05, $ff, $ff ; id 119
    db $04, $01, $04, $06, $07, $02, $07, $05 ; id 120
    db $01, $02, $02, $07, $04, $03, $06, $06 ; id 121
    db $01, $07, $02, $05, $04, $06, $ff, $ff ; id 122
    db $02, $04, $04, $06, $06, $03, $07, $05 ; id 123
    db $06, $07, $07, $05, $07, $06, $ff, $ff ; id 124
    db $02, $05, $05, $02, $05, $06, $06, $05 ; id 125
    db $02, $07, $05, $02, $05, $06, $07, $04 ; id 126
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 127
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 128
    db $03, $03, $05, $04, $06, $06, $07, $02 ; id 129
    db $02, $06, $03, $02, $04, $05, $06, $03 ; id 130
    db $02, $07, $03, $02, $04, $06, $07, $05 ; id 131
    db $05, $02, $07, $03, $07, $05, $ff, $ff ; id 132
    db $02, $05, $05, $01, $05, $06, $07, $02 ; id 133
    db $02, $03, $02, $06, $04, $02, $07, $04 ; id 134
    db $02, $03, $04, $02, $04, $04, $ff, $ff ; id 135
    db $02, $03, $04, $04, $05, $02, $07, $01 ; id 136
    db $02, $03, $04, $06, $06, $02, $07, $04 ; id 137
    db $02, $03, $03, $04, $05, $02, $ff, $ff ; id 138
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 139
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 140
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 141
    db $05, $05, $06, $01, $07, $04, $08, $02 ; id 142
    db $02, $04, $03, $02, $04, $05, $06, $03 ; id 143

; SetupTownObjectsForMap case 4 (band $0B, wMapObjectCount $0A) passes $7405 to
; RemoveMapObjectsEntryMatching; RemoveMapObjectsEntryMatching_NextRandomSeed picks a random screen
; inside wMapWidthScreens x wMapHeightScreens and reads, with ReadByteInBank B = $61, the pair at
; $7405 + (screen Y * width + screen X) * 8 + 2 * (random & 3): a first byte of $FE draws a new
; screen, $FF a new spot, otherwise its nibbles place the object; 36 screens (E-0194, C1)
; record: one screen: four candidate spots (two bytes each); $FE first byte = none on this screen,
; $FF = draw again
TownObjectSpotGrid4::
    db $02, $04, $03, $07, $06, $06, $07, $02 ; id 0
    db $02, $03, $05, $05, $07, $01, $08, $07 ; id 1
    db $02, $06, $08, $03, $02, $06, $08, $03 ; id 2
    db $02, $04, $02, $04, $02, $04, $02, $04 ; id 3
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 4
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 5
    db $02, $02, $05, $04, $07, $07, $08, $01 ; id 6
    db $02, $04, $05, $06, $07, $02, $ff, $ff ; id 7
    db $07, $07, $07, $07, $07, $07, $07, $07 ; id 8
    db $02, $06, $06, $03, $08, $05, $ff, $ff ; id 9
    db $03, $05, $05, $02, $07, $06, $ff, $ff ; id 10
    db $02, $07, $04, $02, $06, $03, $ff, $ff ; id 11
    db $05, $06, $07, $04, $05, $06, $07, $04 ; id 12
    db $02, $06, $04, $03, $07, $05, $ff, $ff ; id 13
    db $02, $03, $06, $02, $08, $06, $ff, $ff ; id 14
    db $02, $07, $03, $01, $06, $04, $08, $02 ; id 15
    db $02, $02, $03, $05, $06, $07, $07, $03 ; id 16
    db $01, $03, $02, $04, $03, $02, $05, $06 ; id 17
    db $02, $06, $03, $03, $07, $01, $07, $05 ; id 18
    db $01, $01, $05, $05, $01, $01, $05, $05 ; id 19
    db $02, $07, $03, $01, $05, $05, $ff, $ff ; id 20
    db $02, $06, $07, $02, $02, $06, $07, $02 ; id 21
    db $02, $05, $04, $02, $06, $06, $08, $03 ; id 22
    db $02, $02, $04, $05, $05, $03, $07, $07 ; id 23
    db $03, $06, $04, $03, $07, $05, $08, $02 ; id 24
    db $02, $02, $04, $05, $08, $03, $ff, $ff ; id 25
    db $02, $03, $02, $07, $04, $02, $06, $05 ; id 26
    db $02, $03, $08, $05, $02, $03, $08, $05 ; id 27
    db $02, $04, $05, $06, $06, $02, $ff, $ff ; id 28
    db $01, $07, $03, $01, $04, $04, $07, $06 ; id 29
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 30
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 31
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 32
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 33
    db $05, $05, $07, $02, $05, $05, $07, $02 ; id 34
    db $03, $06, $06, $02, $03, $06, $06, $02 ; id 35

; SetupTownObjectsForMap case 5 (band $0B, wMapObjectCount $02) passes $7525 to
; RemoveMapObjectsEntryMatching; RemoveMapObjectsEntryMatching_NextRandomSeed picks a random screen
; inside wMapWidthScreens x wMapHeightScreens and reads, with ReadByteInBank B = $61, the pair at
; $7525 + (screen Y * width + screen X) * 8 + 2 * (random & 3): a first byte of $FE draws a new
; screen, $FF a new spot, otherwise its nibbles place the object; 6 screens (E-0194, C1)
TownObjectSpotGrid5::
    db $02, $03, $04, $06, $06, $02, $07, $07 ; id 0
    db $03, $01, $06, $06, $03, $01, $06, $06 ; id 1
    db $02, $02, $02, $05, $04, $03, $07, $06 ; id 2
    db $03, $04, $04, $01, $06, $06, $07, $03 ; id 3
    db $02, $04, $06, $01, $02, $04, $06, $01 ; id 4
    db $02, $01, $03, $04, $07, $02, $ff, $ff ; id 5

; SetupTownObjectsForMap case 6 (band $0D, wMapObjectCount $08) passes $7555 to
; RemoveMapObjectsEntryMatching; RemoveMapObjectsEntryMatching_NextRandomSeed picks a random screen
; inside wMapWidthScreens x wMapHeightScreens and reads, with ReadByteInBank B = $61, the pair at
; $7555 + (screen Y * width + screen X) * 8 + 2 * (random & 3): a first byte of $FE draws a new
; screen, $FF a new spot, otherwise its nibbles place the object; 25 screens (E-0194, C1)
TownObjectSpotGrid6::
    db $03, $05, $05, $03, $07, $06, $ff, $ff ; id 0
    db $03, $02, $04, $06, $07, $03, $ff, $ff ; id 1
    db $02, $03, $04, $02, $05, $07, $07, $05 ; id 2
    db $02, $04, $05, $05, $02, $04, $05, $05 ; id 3
    db $fe, $fe, $fe, $fe, $fe, $fe, $fe, $fe ; id 4
    db $03, $02, $04, $06, $07, $05, $ff, $ff ; id 5
    db $02, $06, $05, $02, $07, $04, $ff, $ff ; id 6
    db $02, $02, $03, $06, $05, $05, $07, $01 ; id 7
    db $03, $02, $03, $06, $06, $05, $ff, $ff ; id 8
    db $02, $06, $06, $03, $02, $06, $06, $03 ; id 9
    db $02, $03, $04, $05, $07, $02, $07, $06 ; id 10
    db $02, $02, $04, $07, $05, $04, $ff, $ff ; id 11
    db $03, $04, $05, $02, $02, $06, $ff, $ff ; id 12
    db $02, $06, $06, $02, $08, $05, $ff, $ff ; id 13
    db $02, $05, $02, $05, $02, $05, $02, $05 ; id 14
    db $03, $07, $04, $02, $07, $04, $ff, $ff ; id 15
    db $03, $03, $04, $07, $05, $04, $08, $01 ; id 16
    db $02, $01, $04, $05, $05, $03, $07, $06 ; id 17
    db $03, $06, $04, $02, $07, $05, $ff, $ff ; id 18
    db $04, $07, $07, $02, $04, $07, $07, $02 ; id 19
    db $05, $05, $06, $02, $05, $05, $06, $02 ; id 20
    db $02, $06, $04, $03, $07, $04, $ff, $ff ; id 21
    db $02, $03, $04, $04, $07, $02, $ff, $ff ; id 22
    db $02, $04, $04, $02, $05, $05, $ff, $ff ; id 23
    db $02, $02, $03, $06, $06, $04, $ff, $ff ; id 24
    ds $9e3, $00
