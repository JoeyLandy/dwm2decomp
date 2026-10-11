SECTION "Bank 61", ROMX[$4000], BANK[$61]
    db $61

; wCD05 = a strength value from the party's stats (AGL and INT halved, ATK, DEF, max HP), 0 without a party (E-0130)
; 2 call sites from 2 routines (e.g. RunBattleIntroKindCase_Case05, ScriptCommand84_Run_Case04_Sub01)
; reads: wPartyCount, hTemp0, hTemp1, hTemp4, hTemp5
; writes: wPartyStrength, hTemp4, hTemp5, rRAMG
; points at: wPartyList
ComputePartyStrengthLevelPartyStrength::
Func_061_4001:: ; address name
    ld a, [wPartyCount]
    or a, a
    jr nz, Jump_061_400C
    xor a, a
    ld [wPartyStrength], a
    ret

Jump_061_400C::
    ld b, a
    ld hl, $0000
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    ld hl, wPartyList
    ld a, $0A
    ld [rRAMG], a

Jump_061_401E::
    push bc
    push hl
    ld a, [hl]
    push af
    ld c, $67
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    pop af
    push af
    ld c, $69
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
    ld c, $63
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    add hl, de
    pop af
    push af
    ld c, $65
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    add hl, de
    pop af
    push af
    ld c, $5D
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    add hl, de
    pop af
    push af
    ld c, $61
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
    jp nz, Jump_061_401E
    xor a, a
    ld [rRAMG], a
    ldh a, [hTemp4]
    ld l, a
    ldh a, [hTemp5]
    ld h, a
    ld a, [wPartyCount]
    call DivideHLByA
    ld a, h
    or a, a
    jr nz, Jump_061_40AA
    ld a, l
    cp a, $63
    jr c, Jump_061_40B0

Jump_061_40AA::
    ld a, $63
    ld [wPartyStrength], a
    ret

Jump_061_40B0::
    ld [wPartyStrength], a
    ret

; computes the party strength from AGL + INT, ATK, DEF and max HP of each member into hFFCA-hFFCD and wCD05 for key generation (E-0131)
; 2 call sites from 2 routines (e.g. RunBattleIntroKindCase_Case06, WriteKeyEntryTemp0)
; reads: wPartyCount, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, hTemp5, hTemp6, ...
; writes: wPartyStrength, hTemp4, hTemp5, hTemp6, hTemp7, rRAMG, hTemp2, hTemp3
; points at: wPartyList
ComputePartyStrengthForKey::
Func_061_40B4:: ; address name
    ld a, [wPartyCount]
    or a, a
    jr nz, Jump_061_40BF
    xor a, a
    ld [wPartyStrength], a
    ret

Jump_061_40BF::
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
    ld a, $0A
    ld [rRAMG], a

Jump_061_40D7::
    push bc
    push hl
    ld a, [hl]
    push af
    ld c, $67
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    pop af
    push af
    ld c, $69
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
    ld c, $63
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
    ld c, $65
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
    ld c, $5D
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
    ld c, $61
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
    ld c, $56
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
    sub a, e
    ld l, a
    ld a, h
    sbc a, d
    ld h, a
    ld a, h
    bit 7, a
    jr z, Jump_061_41C4
    ld hl, $0000
    jr Jump_061_41C9

Jump_061_41C4::
    ld a, $32
    call DivideHLByA

Jump_061_41C9::
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
    jp nz, Jump_061_40D7
    xor a, a
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
    jr z, Jump_061_41F8
    xor a, a
    ld [wPartyStrength], a
    ret

Jump_061_41F8::
    ld a, [wPartyCount]
    call DivideHLByA
    ld a, l
    cp a, $63
    jr c, Jump_061_4209
    ld a, $63
    ld [wPartyStrength], a
    ret

Jump_061_4209::
    ld [wPartyStrength], a
    ret

; runs the routine for wCC44 & 7 (jump table; 4 reuses 3) (E-0122)
; 1 call site from 1 routine (e.g. LoadMapHeader)
; reads: wMapType
RunMapType_420D::
Func_061_420D:: ; address name
    ld a, [wMapType]
    and a, $07
    rst $00
    dw LoadKeyWorldTilesetAndHeader
    dw RunMapType_420D_Case01
    dw RunMapType_420D_Case02
    dw RunMapType_420D_Case03
    dw RunMapType_420D_Case03
    dw LoadMapType5TilesetAndHeader
    dw RunMapType_420D_Case06
    dw RunMapType_420D_Case07

; entry 7 of the `rst $00` table in RunMapType_420D
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
RunMapType_420D_Case07::
Jump_061_4223:: ; address name
    ld a, $66
    ldh [hTemp0], a
    call LoadSpecialMapHeader
    ret

; entry 6 of the `rst $00` table in RunMapType_420D
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldFloor, hTemp0
; writes: hTemp0
RunMapType_420D_Case06::
Jump_061_422B:: ; address name
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
    and a, $01
    ldh [hTemp0], a
    pop af
    ld hl, wKeyWorldFloorState + $3
    ld a, [wKeyWorldFloor]
    swap a
    add_a_to_hl
    ld a, [hl]
    and a, $01
    add a, a
    ld c, a
    ldh a, [hTemp0]
    add a, $50
    ldh [hTemp0], a
    call LoadSpecialMapHeader
    ret

; map type 5 (wMapType & 7 = 5): takes byte 2 of the floor's wKeyWorldFloorState entry as the index into MapType5TilesetTable (61:42DD, 6 bytes each), decompresses its tiles to vTiles2, on CGB copies its $40-byte palettes to wBGPaletteBuffer and requests the upload, then sets a 4 x 4-screen map, wMaxBlockingTile = $3F and other map-header bytes (E-0140)
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldFloor, wIsCGB
; writes: wBGPaletteUploadRequest, wMapWidthScreens, wMapHeightScreens, wMaxBlockingTile, wFieldEventKind, wMapSpriteKind, wMapHeaderByte11, wMapTallTileMin, ...
; points at: wBGPaletteBuffer
LoadMapType5TilesetAndHeader::
Jump_061_4261:: ; address name
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState + $2
    add_a_to_hl
    ld a, [hl]
    push af
    ld c, a
    sla a
    add a, c
    sla a
    ld hl, Data_061_42DD
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld b, a
    push hl
    ld hl, vTiles2
    call DecompressToVRAM
    pop hl
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_061_42A5
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld b, a
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBank
    ld a, $7F
    ld [wBGPaletteUploadRequest], a

Jump_061_42A5::
    ld a, $04
    ld [wMapWidthScreens], a
    ld [wMapHeightScreens], a
    ld a, $3F
    ld [wMaxBlockingTile], a
    xor a, a
    ld [wFieldEventKind], a
    ld a, $10
    ld [wMapSpriteKind], a
    ld a, $2A
    ld [wMapHeaderByte11], a
    xor a, a
    ld [wMapTallTileMin], a
    ld a, $A3
    ld [wEncounterRate], a
    pop af
    cp a, $07
    jr z, Jump_061_42D7
    cp a, $09
    jr z, Jump_061_42D7
    xor a, a
    ld [wMapMoveType], a
    ret

Jump_061_42D7::
    ld a, $05
    ld [wMapMoveType], a
    ret

; E-0140 (C1: LoadMapType5TilesetAndHeader indexes it with 6 * byte 2 of the floor's wKeyWorldFloorState entry, decompresses the first far pointer to vTiles2 and, on CGB, copies $40 bytes from the second to wBGPaletteBuffer; entries 0-11 decode to 2048-byte tile sets with 15-bit palettes, entry 12 onward is not a valid record).
; record: compressed BG tiles decompressed to vTiles2 (128 tiles); ROM bank of the tiles; $40-byte CGB BG palette set copied to wBGPaletteBuffer; ROM bank of the palettes
MapType5TilesetTable::
Data_061_42DD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dfar MapType5Tiles0 ; id 0
    dfar MapType5Palettes0
    dfar MapType5Tiles1 ; id 1
    dfar MapType5Palettes1
    dfar MapType5Tiles2 ; id 2
    dfar MapType5Palettes2
    dfar MapType5Tiles3 ; id 3
    dfar MapType5Palettes3
    dfar MapType5Tiles4 ; id 4
    dfar MapType5Palettes4
    dfar MapType5Tiles5 ; id 5
    dfar MapType5Palettes5
    dfar MapType5Tiles6 ; id 6
    dfar MapType5Palettes6
    dfar MapType5Tiles7 ; id 7
    dfar MapType5Palettes7
    dfar MapType5Tiles8 ; id 8
    dfar MapType5Palettes8
    dfar MapType5Tiles9 ; id 9
    dfar MapType5Palettes9
    dfar MapType5Tiles10 ; id 10
    dfar MapType5Palettes10
    dfar MapType5Tiles11 ; id 11
    dfar MapType5Palettes11

; entry 1 of the `rst $00` table in RunMapType_420D
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wKeyWorldFloor
; writes: wBGPaletteUploadRequest, wMaxBlockingTile, wFieldEventKind, wMapSpriteKind, wMapTallTileMin, wMapWidthScreens, wMapHeightScreens, wEncounterRate, ...
; points at: wBGPaletteBuffer, wKeyWorldObjects
RunMapType_420D_Case01::
Jump_061_4325:: ; address name
    ld de, MapType5Tiles5
    ld b, $6E
    ld hl, vTiles2
    call DecompressToVRAM
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_061_4348
    ld de, Data_06E_77E0
    ld b, $6E
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBank
    ld a, $7F
    ld [wBGPaletteUploadRequest], a

Jump_061_4348::
    ld a, $3F
    ld [wMaxBlockingTile], a
    xor a, a
    ld [wFieldEventKind], a
    ld [wMapSpriteKind], a
    ld [wMapTallTileMin], a
    ld hl, wKeyWorldObjects
    ld a, [wKeyWorldFloor]
    sla a
    sla a
    add_a_to_hl
    ld a, [hl]
    and a, $0F
    dec a
    sla a
    sla a
    sla a
    ld e, a
    ld d, $00
    ld a, [hl]
    swap a
    and a, $0F
    dec a
    sla a
    add a, e
    ld e, a
    jr nc, Jump_061_4380
    inc d

Jump_061_4380::
    ld a, e
    add a, $05
    ld e, a
    ld a, d
    adc a, $67
    ld d, a
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [hl+]
    ld [wMapWidthScreens], a
    ld a, [hl]
    ld [wMapHeightScreens], a
    ld a, $A3
    ld [wEncounterRate], a
    xor a, a
    ld [wMapMoveType], a
    ret

; entry 2 of the `rst $00` table in RunMapType_420D
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldFloor, hTemp0
; writes: hTemp0, wKeyWorldByte06
; points at: hTemp0
RunMapType_420D_Case02::
Jump_061_439F:: ; address name
    ld a, $61
    ldh [hTemp0], a
    ld a, [wKeyWorldFloor]
    bit 7, a
    jr z, Jump_061_43AE
    ld hl, hTemp0
    inc [hl]

Jump_061_43AE::
    ldh a, [hTemp0]
    sub a, $61
    ld [wKeyWorldByte06], a
    call LoadSpecialMapHeader
    ret

; entry 3 of the `rst $00` table in RunMapType_420D
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldFloor
; writes: hTemp0
; points at: wKeyWorldFloorState
RunMapType_420D_Case03::
Jump_061_43B9:: ; address name
    ld hl, wKeyWorldFloorState
    ld a, [wKeyWorldFloor]
    swap a
    add_a_to_hl
    ld a, [hl]
    and a, $7F
    ldh [hTemp0], a
    call LoadSpecialMapHeader
    ret

; map type 0 (wMapType & 7 = 0): decompresses entry wKeyWorldGoalKind of KeyWorldTilesetTable (61:5728, 6 bytes each) to vTiles2, on CGB copies its $40-byte palette set to wBGPaletteBuffer and requests the upload, then sets wMaxBlockingTile = $3D, wFieldEventKind, wEncounterRate and other map-header bytes (E-0139)
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldGoalKind, wIsCGB, wMapSpriteKind
; writes: wBGPaletteUploadRequest, wMaxBlockingTile, wFieldEventKind, wEncounterRate, wMapMoveType, wMapTallTileMin, wMapHeaderByte11, wMapSpriteKind
; points at: wBGPaletteBuffer
LoadKeyWorldTilesetAndHeader::
Jump_061_43CF:: ; address name
    ld a, [wKeyWorldGoalKind]
    ld c, a
    sla a
    add a, c
    sla a
    ld l, a
    ld h, $00
    ld a, l
    add a, $28
    ld l, a
    ld a, h
    adc a, $57
    ld h, a
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld b, a
    push hl
    ld hl, vTiles2
    call DecompressToVRAM
    pop hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld b, a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_061_440A
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBank
    ld a, $7F
    ld [wBGPaletteUploadRequest], a

Jump_061_440A::
    ld a, $3D
    ld [wMaxBlockingTile], a
    ld a, [wKeyWorldGoalKind]
    cp a, $04
    jr z, Jump_061_441D
    ld a, $02
    ld [wFieldEventKind], a
    jr Jump_061_4421

Jump_061_441D::
    xor a, a
    ld [wFieldEventKind], a

Jump_061_4421::
    ld a, $A2
    ld [wEncounterRate], a
    ld a, [wKeyWorldGoalKind]
    cp a, $01
    jr z, Jump_061_4437
    cp a, $07
    jr z, Jump_061_4437
    xor a, a
    ld [wMapMoveType], a
    jr Jump_061_443C

Jump_061_4437::
    ld a, $04
    ld [wMapMoveType], a

Jump_061_443C::
    xor a, a
    ld [wMapTallTileMin], a
    ld [wMapHeaderByte11], a
    ld a, [wKeyWorldGoalKind]
    ld hl, Data_061_4468
    add_a_to_hl
    ld a, [hl]
    ld [wMapSpriteKind], a
    and a, $0F
    jr z, Jump_061_445B
    ld a, $29
    ld [wMapTallTileMin], a

Jump_061_445B::
    ld a, [wMapSpriteKind]
    and a, $F0
    jr z, Jump_061_4467
    ld a, $2C
    ld [wMapHeaderByte11], a

Jump_061_4467::
    ret

; address loaded by LoadKeyWorldTilesetAndHeader
Data_061_4468:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $11, $11, $21, $11, $12, $12, $11, $11, $11, $31

; only called from LoadMapScreen (E-0047)
; 1 call site from 1 routine (e.g. LoadMapScreen)
; reads: wMapType
LoadMapScreen_Sub03::
Func_061_4472:: ; address name
    ld a, [wMapType]
    and a, $07
    rst $00
    dw Func_061_4472_Case00
    dw Func_061_4472_Case01
    dw Func_061_4472_Case02
    dw Func_061_4472_Case03
    dw Func_061_4472_Case03
    dw Func_061_4472_Case05
    dw Func_061_4472_Case06
    dw Func_061_4472_Case07

; entry 7 of the `rst $00` table in Func_061_4472
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
Func_061_4472_Case07::
Jump_061_4488:: ; address name
    ld a, $66
    ldh [hTemp0], a
    call LoadMapScreenFromChunk
    ret

; entry 6 of the `rst $00` table in Func_061_4472
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldFloor, hTemp0
; writes: hTemp0
Func_061_4472_Case06::
Jump_061_4490:: ; address name
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
    and a, $01
    ldh [hTemp0], a
    pop af
    ld hl, wKeyWorldFloorState + $3
    ld a, [wKeyWorldFloor]
    swap a
    add_a_to_hl
    ld a, [hl]
    push hl
    cp a, $FF
    jr nz, Jump_061_44BF
    ld a, $00

Jump_061_44BF::
    dec a
    and a, $01
    sla a
    ld c, a
    ldh a, [hTemp0]
    add a, $50
    ldh [hTemp0], a
    call LoadMapScreenFromChunk
    pop hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_061_44D7
    and a, $01
    ret z

Jump_061_44D7::
    call DrawDoorTilesForKeyWorldFloor
    ret

; writes a 2 x 2 tile block ($1A or $1C by the wCDAF entry, then $1E) at wC244, with CGB attribute 5 (E-0127)
; 3 call sites from 3 routines (e.g. Func_061_4472_Case06, ScriptCommand86_Run_Case04, ScriptCommand86_Run_Case02)
; reads: wKeyWorldFloor, wIsCGB
; writes: rSVBK
DrawDoorTilesForKeyWorldFloor::
Func_061_44DB:: ; address name
    ld a, [wKeyWorldFloor]
    swap a
    ld de, wKeyWorldFloorState + $3
    add a, e
    ld e, a
    jr nc, Jump_061_44E8
    inc d

Jump_061_44E8::
    ld c, $1A
    ld a, [de]
    cp a, $FF
    jr nz, Jump_061_44F1
    ld c, $1C

Jump_061_44F1::
    ld hl, wScreenTileBuffer + $AC
    push hl
    ld a, c
    ld [hl+], a
    inc a
    ld [hl-], a
    ld a, $14
    add_a_to_hl
    ld a, $1E
    ld [hl+], a
    inc a
    ld [hl], a
    pop hl
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, $02
    ldh [rSVBK], a
    ld a, l
    sub a, $98
    ld l, a
    ld a, h
    sbc a, $C1
    ld h, a
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ld a, $05
    ld [hl+], a
    ld [hl-], a
    ld a, $14
    add_a_to_hl
    ld a, $05
    ld [hl+], a
    ld [hl], a
    ld a, $00
    ldh [rSVBK], a
    ret

; entry 5 of the `rst $00` table in Func_061_4472
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldFloor, wKeyWorldArea, hMapScreenY, hMapScreenX, wIsCGB
; writes: hTemp0, rSVBK
; points at: wScreenTileBuffer, wScreenAttrBuffer
Func_061_4472_Case05::
Jump_061_4533:: ; address name
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState + $1
    add_a_to_hl
    ld a, [hl]
    add a, a
    ld e, a
    ld d, $00
    ld a, [wKeyWorldArea]
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_061_454E
    inc d

Jump_061_454E::
    ld a, e
    add a, $2C
    ld e, a
    ld a, d
    adc a, $CE
    ld d, a
    ld a, [de]
    ldh [hTemp0], a
    ld e, a
    ld d, $00
    sla e
    rl d
    ld a, e
    add a, $01
    ld e, a
    ld a, d
    adc a, $40
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
    add a, c
    sla a
    sla a
    add_a_to_hl
    ldh a, [hMapScreenX]
    ld c, a
    sla a
    add a, c
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
    or a, a
    jr z, Jump_061_45E1
    ld a, l
    add a, $30
    ld l, a
    ld a, h
    adc a, $00
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

Jump_061_45E1::
    call DrawKeyWorldExitTile
    call CheckTwoWCDB0EntriesForKeyWorldArea
    ret

; for the two wCDB0 entries of wCC45 matching wCC43 runs Func_061_462F with C = $80 or the stored value (E-0127)
; 2 call sites from 2 routines (e.g. Func_061_4472_Case05, ScriptCommand81_Run_Case02)
; reads: wKeyWorldFloor, wKeyWorldArea, hMapScreenX, hMapScreenY, wIsCGB
; writes: rSVBK
CheckTwoWCDB0EntriesForKeyWorldArea::
Func_061_45E8:: ; address name
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState + $4
    add_a_to_hl
    push hl
    ld a, [hl]
    ld b, a
    ld a, [wKeyWorldArea]
    cp a, b
    jr nz, Jump_061_4613
    inc hl
    inc hl
    ld a, [hl+]
    ld b, a
    ld a, [hl]
    or a, a
    jr z, Jump_061_460A
    ld c, $80
    jr Jump_061_460E

Jump_061_460A::
    dec hl
    dec hl
    ld a, [hl]
    ld c, a

Jump_061_460E::
    push hl
    call CheckTwoWCDB0EntriesForKeyWorldArea_Sub01
    pop hl

Jump_061_4613::
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    ld b, a
    ld a, [wKeyWorldArea]
    cp a, b
    ret nz
    inc hl
    inc hl
    ld a, [hl+]
    ld b, a
    ld a, [hl]
    or a, a
    jr z, Jump_061_462B
    ld c, $80
    jr CheckTwoWCDB0EntriesForKeyWorldArea_Sub01

Jump_061_462B::
    dec hl
    dec hl
    ld a, [hl]
    ld c, a

; only called from CheckTwoWCDB0EntriesForKeyWorldArea (E-0047)
; 1 call site from 1 routine (e.g. CheckTwoWCDB0EntriesForKeyWorldArea)
; reads: hMapScreenX, hMapScreenY, wKeyWorldFloor, wKeyWorldArea, wIsCGB
; writes: rSVBK
CheckTwoWCDB0EntriesForKeyWorldArea_Sub01::
Func_061_462F:: ; address name
    ld a, b
    ld hl, Data_061_4810
    add_a_to_hl
    ld a, [hl]
    ld e, a
    ldh a, [hMapScreenX]
    swap a
    ld d, a
    ldh a, [hMapScreenY]
    or a, d
    cp a, e
    ret nz
    bit 7, c
    jr nz, Jump_061_464C
    ld a, $2C
    jr Jump_061_464E

Jump_061_464C::
    ld a, $2E

Jump_061_464E::
    push af
    ld a, [wKeyWorldFloor]
    swap a
    ld de, wKeyWorldFloorState + $1
    add a, e
    ld e, a
    jr nc, Jump_061_465C
    inc d

Jump_061_465C::
    ld a, [de]
    add a, a
    ld e, a
    ld d, $00
    ld a, [wKeyWorldArea]
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_061_466A
    inc d

Jump_061_466A::
    ld a, e
    add a, $2C
    ld e, a
    ld a, d
    adc a, $CE
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
    add a, e
    ld e, a
    jr nc, Jump_061_468E
    inc d

Jump_061_468E::
    ld a, e
    add a, $19
    ld e, a
    ld a, d
    adc a, $48
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
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    pop af
    push hl
    ld [hl+], a
    inc a
    ld [hl-], a
    push af
    ld a, $14
    add_a_to_hl
    pop af
    add a, $0F
    ld [hl+], a
    inc a
    ld [hl], a
    pop hl
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, $02
    ldh [rSVBK], a
    ld a, l
    sub a, $98
    ld l, a
    ld a, h
    sbc a, $C1
    ld h, a
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ld a, [hl]
    and a, $F8
    or a, $06
    ld [hl+], a
    ld a, [hl]
    and a, $F8
    or a, $06
    ld [hl-], a
    ld a, $14
    add_a_to_hl
    ld a, [hl]
    and a, $F8
    or a, $06
    ld [hl+], a
    ld a, [hl]
    and a, $F8
    or a, $06
    ld [hl-], a
    ld a, $00
    ldh [rSVBK], a
    ret

; hFFC6 = the two nibbles at $4818 + 16 * [$CE2C + 2 * wCDAD[16 * wCC45] + 2 * wCC43] + 2 * hFFC6, packed into one byte (E-0121)
; 1 call site from 1 routine (e.g. WriteRandomEntryFromTable690E)
; reads: wKeyWorldFloor, wKeyWorldArea, hTemp0
; writes: hTemp0
LookupTable4818NibblePairForTemp0::
Func_061_4706:: ; address name
    push hl
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState + $1
    add_a_to_hl
    ld a, [hl]
    add a, a
    ld l, a
    ld h, $00
    ld a, [wKeyWorldArea]
    add a, a
    add_a_to_hl
    ld a, l
    add a, $2C
    ld l, a
    ld a, h
    adc a, $CE
    ld h, a
    ld a, [hl]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ldh a, [hTemp0]
    add a, a
    add_a_to_hl
    ld a, l
    add a, $18
    ld l, a
    ld a, h
    adc a, $48
    ld h, a
    ld a, [hl+]
    swap a
    ld c, a
    ld a, [hl]
    or a, c
    ldh [hTemp0], a
    pop hl
    ret

; draws the exit or stairs tile block for the current screen when it matches the area entry in wCE2D (E-0130)
; 1 call site from 1 routine (e.g. Func_061_4472_Case05)
; reads: wKeyWorldFloor, wKeyWorldArea, hMapScreenX, hMapScreenY, hTemp0, wIsCGB
; writes: hTemp0, rSVBK
DrawKeyWorldExitTile::
Func_061_474C:: ; address name
    ld a, [wKeyWorldFloor]
    add a, a
    add a, a
    push af
    ld hl, wKeyWorldFloorInfo + $1
    add_a_to_hl
    ld a, [hl]
    ldh [hTemp0], a
    pop af
    add a, a
    add a, a
    ld hl, wKeyWorldFloorState + $1
    add_a_to_hl
    ld a, [hl]
    add a, a
    ld hl, wKeyWorldRoomTable + $1
    add_a_to_hl
    ld a, [wKeyWorldArea]
    add a, a
    add_a_to_hl
    ldh a, [hMapScreenX]
    and a, $0F
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    and a, $0F
    or a, c
    ld c, a
    ld a, [hl]
    and a, $0F
    cp a, $0F
    jr z, Jump_061_479B
    ld de, Data_061_480A
    add a, e
    ld e, a
    jr nc, Jump_061_4797
    inc d

Jump_061_4797::
    ld a, [de]
    cp a, c
    jr z, Jump_061_47AD

Jump_061_479B::
    ld a, [hl]
    swap a
    and a, $0F
    ld de, Data_061_480A
    add a, e
    ld e, a
    jr nc, Jump_061_47A8
    inc d

Jump_061_47A8::
    ld a, [de]
    cp a, c
    jr z, Jump_061_47B9
    ret

Jump_061_47AD::
    ldh a, [hTemp0]
    dec a
    dec a
    dec a
    dec a
    sla a
    add a, $46
    jr Jump_061_47C5

Jump_061_47B9::
    ldh a, [hTemp0]
    dec a
    dec a
    dec a
    dec a
    sla a
    ld c, a
    ld a, $48
    sub a, c

Jump_061_47C5::
    ld hl, wScreenTileBuffer + $A8
    ld [hl+], a
    inc a
    ld [hl-], a
    push af
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    pop af
    add a, $0F
    ld [hl+], a
    inc a
    ld [hl-], a
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, $02
    ldh [rSVBK], a
    ld hl, wWorkBuf + $B
    ld a, [hl]
    and a, $F8
    or a, $04
    ld [hl+], a
    ld a, [hl]
    and a, $F8
    or a, $04
    ld [hl-], a
    ld a, $14
    add_a_to_hl
    ld a, [hl]
    and a, $F8
    or a, $04
    ld [hl+], a
    ld a, [hl]
    and a, $F8
    or a, $04
    ld [hl-], a
    ld a, $00
    ldh [rSVBK], a
    ret

; address loaded by DrawKeyWorldExitTile
Data_061_480A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $30, $11, $22, $03, $33

; address loaded by CheckTwoWCDB0EntriesForKeyWorldArea_Sub01
Data_061_4810:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $184810, $98
    ds $40, $04
    db $03, $03, $03, $02, $02, $06, $07, $02, $03, $02, $02, $03, $06, $06, $05, $05
    db $01, $04, $04, $04, $04, $04, $04, $07, $04, $04, $07, $03
    ds $14, $04
    INCBIN "dwm2-cobi-us.gbc", $184918, $EC
    ds $12, $04
    db $07, $05, $05, $07, $04, $03, $03, $03, $04, $04, $06, $02, $04, $03, $06, $04
    db $01, $03
    ds $40, $04
    db $07, $06, $05, $02, $06, $03, $04, $02, $08, $02, $03, $03, $01, $02, $07, $04
    db $04, $04, $04, $04, $08, $02, $04, $04, $04, $04, $02, $07
    ds $14, $04
    INCBIN "dwm2-cobi-us.gbc", $184A98, $72
    ds $3E, $04
    db $01, $06, $07, $06, $07, $02, $01, $05, $05, $06, $01, $07, $01, $03, $07, $06
    ds $10, $04
    db $05, $01, $03, $03, $04, $02, $08, $03, $06, $02, $05, $07, $03, $05, $03, $03
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $06, $06
    ds $54, $04
    db $07, $03, $07, $02, $03, $05, $04, $04, $05, $04, $05, $05, $04, $03, $01, $06
    db $07, $06, $02, $04, $05, $06, $07, $02, $01, $02, $07, $03, $08, $03, $05, $03
    db $04, $04, $04, $04, $04, $04, $04, $04, $02, $04, $04, $04, $04, $04, $03, $03
    ds $10, $04
    INCBIN "dwm2-cobi-us.gbc", $184C18, $6E
    ds $10, $04
    INCBIN "dwm2-cobi-us.gbc", $184C96, $17E
    ds $34, $04
    db $07, $05, $02, $05, $05, $06, $05, $02, $07, $06, $01, $05, $05, $03, $02, $03
    ds $10, $04
    db $06, $03, $06, $03, $06, $03, $02, $06, $02, $05, $01, $07, $02, $02, $04, $06
    db $04, $04, $05, $03, $04, $04, $01, $06, $04, $04, $06, $02, $04, $04, $08, $06
    ds $50, $04
    db $07, $06, $02, $02, $07, $03, $04, $02, $06, $06, $03, $04, $07, $04, $04, $06
    db $03, $03, $01, $06, $07, $05, $01, $03, $04, $02, $01, $02, $07, $03, $03, $05
    db $03, $02, $04, $04, $06, $05, $04, $04, $02, $06, $06, $03, $07, $02
    ds $1C, $04
    INCBIN "dwm2-cobi-us.gbc", $184F22, $F4
    ds $42, $04
    db $05, $04, $03, $07, $01, $02, $05, $06, $02, $02, $02, $06, $01, $04, $01, $07
    db $04, $07, $03, $06, $07, $07, $06, $04, $07, $04, $02, $05, $01, $03, $07, $05
    db $01, $04, $06, $02, $05, $05, $04, $04, $08, $05
    ds $46, $04
    db $05, $02, $05, $04, $01, $02, $08, $02, $05, $02, $05, $06, $07, $02, $07, $03
    ds $12, $04
    db $03, $04, $01, $03, $02, $05, $03, $04, $04, $04, $04, $04, $05, $01, $04, $04
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $08, $03, $04, $06
    ds $11, $04
    INCBIN "dwm2-cobi-us.gbc", $185119, $FE
    ds $51, $04
    ds $30, $00
    ds $50, $04
    ds $30, $00
    ds $50, $04
    ds $30, $00
    ds $50, $04
    ds $30, $00

; entry 1 of the `rst $00` table in Func_061_4472
; no direct call (reached through a table, a jump or a vector)
Func_061_4472_Case01::
Jump_061_5418:: ; address name
    ret
    db $C9

; entry 2 of the `rst $00` table in Func_061_4472
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldFloor
; writes: hTemp0
; points at: hTemp0
Func_061_4472_Case02::
Jump_061_541A:: ; address name
    ld a, $61
    ldh [hTemp0], a
    ld a, [wKeyWorldFloor]
    bit 7, a
    jr z, Jump_061_5429
    ld hl, hTemp0
    inc [hl]

Jump_061_5429::
    call LoadMapScreenFromChunk
    ret

; entry 3 of the `rst $00` table in Func_061_4472
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldFloor
; writes: hTemp0
; points at: wKeyWorldFloorState
Func_061_4472_Case03::
Jump_061_542D:: ; address name
    ld hl, wKeyWorldFloorState
    ld a, [wKeyWorldFloor]
    swap a
    add_a_to_hl
    ld a, [hl]
    and a, $7F
    ldh [hTemp0], a
    call LoadMapScreenFromChunk
    ret

; entry 0 of the `rst $00` table in Func_061_4472
; no direct call (reached through a table, a jump or a vector)
; reads: hMapScreenY, hMapScreenX, wIsCGB
; writes: rSVBK
; points at: wScreenTileBuffer, wScreenAttrBuffer
Func_061_4472_Case00::
Jump_061_5443:: ; address name
    ldh a, [hMapScreenY]
    and a, $FC
    add a, a
    ld l, a
    ld h, $00
    ldh a, [hMapScreenX]
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
    ldh a, [hMapScreenY]
    and a, $03
    ld c, a
    sla a
    add a, c
    sla a
    sla a
    add_a_to_hl
    ldh a, [hMapScreenX]
    and a, $03
    ld c, a
    sla a
    add a, c
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
    or a, a
    jr z, Jump_061_54E2
    ld a, l
    add a, $30
    ld l, a
    ld a, h
    adc a, $00
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

Jump_061_54E2::
    call DrawKeyWorldObjectsEntryTilesForScreen
    call DrawWCD8BObjectTilesForScreen
    call DrawKeyWorldGoalAtScreen
    ret

; on key-world maps draws the goal object for the current screen (from wC88F when the wC891 key matches, else from wCD0A) (E-0130)
; 1 call site from 1 routine (e.g. Func_061_4472_Case00)
; reads: wMapType, wKeyWorldActive, wKeyWorldKey, wKeyWorldSlot, hMapScreenX, hMapScreenY, wKeyWorldGoalCell, wKeyWorldGoal, ...
; writes: rSVBK
DrawKeyWorldGoalAtScreen::
Func_061_54EC:: ; address name
    ld a, [wMapType]
    cp a, $80
    ret nz
    ld a, [wKeyWorldActive]
    or a, a
    jr z, Jump_061_5548
    ld a, [wKeyWorldKey]
    bit 7, a
    jr z, Jump_061_5548
    and a, $7F
    ld c, a
    ld a, [wKeyWorldSlot]
    cp a, c
    jr nz, Jump_061_5548
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or a, c
    ld c, a
    ld a, [wKeyWorldGoalCell]
    cp a, c
    ret nz
    ld a, [wKeyWorldGoal]
    and a, $0F
    ld c, a
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_061_552D
    inc d

Jump_061_552D::
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld a, [wKeyWorldGoal]
    swap a
    and a, $0F
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_061_5546
    inc d

Jump_061_5546::
    jr Jump_061_5585

Jump_061_5548::
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or a, c
    ld c, a
    ld a, [wKeyWorldGoalScreen]
    cp a, c
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
    add a, e
    ld e, a
    jr nc, Jump_061_556D
    inc d

Jump_061_556D::
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld a, [wKeyWorldGoalPos]
    swap a
    sla a
    add a, e
    ld e, a
    jr nc, Jump_061_5585
    inc d

Jump_061_5585::
    push de
    ld a, e
    add a, $98
    ld e, a
    ld a, d
    adc a, $C1
    ld d, a
    ld a, $46
    call Write2x2TileBlockAtDE
    pop de
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, e
    add a, $00
    ld e, a
    ld a, d
    adc a, $D0
    ld d, a
    ld a, $02
    ldh [rSVBK], a
    ld a, $05
    call Write2x2SameTileAtDE
    ld a, $00
    ldh [rSVBK], a
    ret

; for the wCD7B entry on the current screen writes its 2 x 2 tile block ($46, or $70-$73) at wC240 with CGB attribute 5 (E-0129)
; 1 call site from 1 routine (e.g. Func_061_4472_Case00)
; reads: hMapScreenX, hMapScreenY, wIsCGB
; writes: rSVBK
; points at: wKeyWorldObjects
DrawKeyWorldObjectsEntryTilesForScreen::
Func_061_55AF:: ; address name
    ld hl, wKeyWorldObjects

Jump_061_55B2::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_061_562E
    push hl
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    swap a
    and a, $0F
    ld b, a
    ld a, [hl]
    and a, $0F
    ld c, a
    ldh a, [hMapScreenX]
    cp a, b
    jr nz, Jump_061_560E
    ldh a, [hMapScreenY]
    cp a, c
    jr nz, Jump_061_560E
    ldh a, [hMapScreenY]

Jump_061_55D1::
    pop hl
    ld de, wScreenTileBuffer + $A8
    dec hl
    ld a, [hl]
    or a, a
    jr nz, Jump_061_55E1
    ld a, $46
    call Write2x2TileBlockAtDE
    jr Jump_061_55F6

Jump_061_55E1::
    ld a, $70
    ld [de], a
    inc de
    inc a
    ld [de], a
    inc a
    push af
    ld a, e
    add a, $13
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop af
    ld [de], a
    inc de
    inc a
    ld [de], a

Jump_061_55F6::
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_061_562E
    ld de, wWorkBuf + $B
    ld a, $02
    ldh [rSVBK], a
    ld a, $05
    call Write2x2SameTileAtDE
    ld a, $00
    ldh [rSVBK], a
    jr Jump_061_562E

Jump_061_560E::
    inc hl
    ld a, [hl]
    swap a
    and a, $0F
    ld b, a
    ld a, [hl]
    and a, $0F
    ld c, a
    ldh a, [hMapScreenX]
    cp a, b
    jr nz, Jump_061_5627
    ldh a, [hMapScreenY]
    cp a, c
    jr nz, Jump_061_5627
    ldh a, [hMapScreenY]
    jr Jump_061_55D1

Jump_061_5627::
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_061_55B2

Jump_061_562E::
    ret

; for the wCD8B object on the current screen draws its 4 x 2 or 2 x 2 tile blocks by kind (E-0130)
; 1 call site from 1 routine (e.g. Func_061_4472_Case00)
; reads: hMapScreenX, hMapScreenY, wIsCGB
; writes: rSVBK
DrawWCD8BObjectTilesForScreen::
Func_061_562F:: ; address name
    ld hl, wKeyWorldFloorInfo + $3

Jump_061_5632::
    ld a, [hl]
    cp a, $FF
    ret z
    push hl
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    swap a
    and a, $0F
    ld b, a
    ld a, [hl]
    and a, $0F
    ld c, a
    ldh a, [hMapScreenX]
    cp a, b
    jp nz, Jump_061_56DA
    ldh a, [hMapScreenY]
    cp a, c
    jp nz, Jump_061_56DA
    pop hl
    ld de, wScreenTileBuffer + $A8
    dec hl
    dec hl
    ld a, [hl]
    or a, a
    jr nz, Jump_061_565B
    ret

Jump_061_565B::
    dec a
    jr nz, Jump_061_5667

Jump_061_565E::
    ld a, $68
    call Write4x2TileBlockAtDE
    ld c, $01
    jr Jump_061_56A6

Jump_061_5667::
    dec a
    jr nz, Jump_061_5680
    ld a, $4C
    call Write2x2TileBlockAtDE
    ld a, e
    sub a, $13
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    ld a, $4E
    call Write2x2TileBlockAtDE
    ld c, $01
    jr Jump_061_56A6

Jump_061_5680::
    dec a
    jr nz, Jump_061_568C
    ld a, $60
    call Write4x2TileBlockAtDE
    ld c, $01
    jr Jump_061_56A6

Jump_061_568C::
    dec a
    jr nz, Jump_061_5698
    ld a, $4A
    call Write2x2TileBlockAtDE
    ld c, $00
    jr Jump_061_56A6

Jump_061_5698::
    dec a
    jr nz, Jump_061_56A4
    ld a, $48
    call Write2x2TileBlockAtDE
    ld c, $00
    jr Jump_061_56A6

Jump_061_56A4::
    jr Jump_061_565E

Jump_061_56A6::
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_061_56E2
    ld de, wWorkBuf + $B
    ld a, $02
    ldh [rSVBK], a
    bit 0, c
    jr nz, Jump_061_56C2
    ld a, $05
    call Write2x2SameTileAtDE
    ld a, $00
    ldh [rSVBK], a
    jr Jump_061_56E2

Jump_061_56C2::
    ld a, $06
    call Write2x2SameTileAtDE
    ld a, e
    sub a, $13
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    ld a, $06
    call Write2x2SameTileAtDE
    ld a, $00
    ldh [rSVBK], a
    jr Jump_061_56E2

Jump_061_56DA::
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jp Jump_061_5632

Jump_061_56E2::
    ret

; writes tiles A, A+1 at DE and A+$10, A+$11 one 20-tile row below (E-0121)
; 6 call sites from 3 routines (e.g. DrawKeyWorldGoalAtScreen, DrawWCD8BObjectTilesForScreen, DrawKeyWorldObjectsEntryTilesForScreen)
Write2x2TileBlockAtDE::
Func_061_56E3:: ; address name
    ld [de], a
    inc de
    inc a
    ld [de], a
    add a, $0F
    push af
    ld a, e
    add a, $13
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop af
    ld [de], a
    inc de
    inc a
    ld [de], a
    ret

; writes tiles A..A+3 at DE and the next four one 20-tile row below (E-0121)
; 2 call sites from 1 routine (e.g. DrawWCD8BObjectTilesForScreen)
Write4x2TileBlockAtDE::
Func_061_56F8:: ; address name
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
    add a, $11
    ld e, a
    ld a, d
    adc a, $00
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
; 5 call sites from 3 routines (e.g. DrawKeyWorldGoalAtScreen, DrawWCD8BObjectTilesForScreen, DrawKeyWorldObjectsEntryTilesForScreen)
Write2x2SameTileAtDE::
Func_061_5718:: ; address name
    ld [de], a
    inc de
    ld [de], a
    push af
    ld a, $13
    add a, e
    ld e, a
    jr nc, Jump_061_5723
    inc d

Jump_061_5723::
    pop af
    ld [de], a
    inc de
    ld [de], a
    ret

; E-0139 (C1: RunWCC44Type_420D_Case00 indexes it with 6 * wKeyWorldGoalKind, decompresses the first far pointer to vTiles2 and, on CGB, copies $40 bytes from the second to wBGPaletteBuffer; all 10 tile streams decode to 2048 bytes and all 10 palettes are 15-bit colours).
; record: compressed BG tiles decompressed to vTiles2 (128 tiles); ROM bank of the tiles; $40-byte CGB BG palette set copied to wBGPaletteBuffer; ROM bank of the palettes
KeyWorldTilesetTable::
Data_061_5728:: ; heuristic: start of a structured table; C0
    dfar KeyWorldTiles0 ; id 0
    dfar KeyWorldPalettes0
    dfar KeyWorldTiles1 ; id 1
    dfar KeyWorldPalettes1
    dfar KeyWorldTiles2 ; id 2
    dfar KeyWorldPalettes2
    dfar KeyWorldTiles3 ; id 3
    dfar KeyWorldPalettes3
    dfar KeyWorldTiles4 ; id 4
    dfar KeyWorldPalettes4
    dfar KeyWorldTiles5 ; id 5
    dfar KeyWorldPalettes5
    dfar KeyWorldTiles6 ; id 6
    dfar KeyWorldPalettes6
    dfar KeyWorldTiles7 ; id 7
    dfar KeyWorldPalettes7
    dfar KeyWorldTiles8 ; id 8
    dfar KeyWorldPalettes8
    dfar KeyWorldTiles9 ; id 9
    dfar KeyWorldPalettes9

; only called from CheckWarpAtPlayer (E-0047)
; 1 call site from 1 routine (e.g. CheckWarpAtPlayer)
; reads: wMapType
CheckWarpAtPlayer_Sub01::
Func_061_5764:: ; address name
    ld a, [wMapType]
    and a, $07
    rst $00
    dw Func_061_5764_Case00
    dw Func_061_5764_Case01
    dw Func_061_5764_Case02
    dw Func_061_5764_Case03
    dw Func_061_5764_Case04
    dw Func_061_5764_Case05
    dw Func_061_5764_Case00
    dw Func_061_5764_Case07

; entry 0 of the `rst $00` table in Func_061_5764
; no direct call (reached through a table, a jump or a vector)
Func_061_5764_Case00::
Jump_061_577A:: ; address name
    ld c, $00
    ret

; entry 1 of the `rst $00` table in Func_061_5764
; no direct call (reached through a table, a jump or a vector)
Func_061_5764_Case01::
Jump_061_577D:: ; address name
    ld c, $00
    ret

; entry 2 of the `rst $00` table in Func_061_5764
; no direct call (reached through a table, a jump or a vector)
Func_061_5764_Case02::
Jump_061_5780:: ; address name
    call WarpByKeyWorldAreaExitsEntryAtScreenRow1
    ret

; entry 3 of the `rst $00` table in Func_061_5764
; no direct call (reached through a table, a jump or a vector)
Func_061_5764_Case03::
Jump_061_5784:: ; address name
    call CheckKeyWorldWarpTable
    ret

; entry 4 of the `rst $00` table in Func_061_5764
; no direct call (reached through a table, a jump or a vector)
Func_061_5764_Case04::
Jump_061_5788:: ; address name
    call WarpToScreen01Event83
    ret

; entry 5 of the `rst $00` table in Func_061_5764
; no direct call (reached through a table, a jump or a vector)
Func_061_5764_Case05::
Jump_061_578C:: ; address name
    call WarpByWCD89EntryAtScreen14
    ret

; entry 7 of the `rst $00` table in Func_061_5764
; no direct call (reached through a table, a jump or a vector)
Func_061_5764_Case07::
Jump_061_5790:: ; address name
    call CallF4268OnScreenY1
    ret

; C = 0 unless hMapScreenY = 1, in which case far-calls Func_011_4268 (E-0122)
; 1 call site from 1 routine (e.g. Func_061_5764_Case07)
; reads: hMapScreenY
CallF4268OnScreenY1::
Func_061_5794:: ; address name
    ldh a, [hMapScreenY]
    cp a, $01
    jr z, Jump_061_579D
    ld c, $00
    ret

Jump_061_579D::
    farcall WarpToLinkedMapForCurrentMap
    ret

; when wCC43 is 0, the wCD89 entry is 5 and the player is at screen (1, 4): warps to the stored screen and starts the transition; C = 1 (E-0127)
; 1 call site from 1 routine (e.g. Func_061_5764_Case05)
; reads: wKeyWorldArea, wKeyWorldFloor, hMapScreenX, hMapScreenY, hPlayerStateFlags
; writes: hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wWarpDestFacing, wModeState, wFieldTransitionStep, hPlayerStateFlags, ...
WarpByWCD89EntryAtScreen14::
Func_061_57A4:: ; address name
    ld a, [wKeyWorldArea]
    or a, a
    jr z, Jump_061_57AD

Jump_061_57AA::
    ld c, $00
    ret

Jump_061_57AD::
    ld a, [wKeyWorldFloor]
    sla a
    sla a
    ld hl, wKeyWorldFloorInfo + $1
    add_a_to_hl
    ld a, [hl]
    cp a, $05
    jr nz, Jump_061_57AA
    ldh a, [hMapScreenX]
    dec a
    jr nz, Jump_061_57AA
    ldh a, [hMapScreenY]
    cp a, $04
    jr nz, Jump_061_57AA
    dec hl
    ld a, [hl]
    swap a
    and a, $0F
    ldh [hMapScreenX], a
    ld a, [hl]
    and a, $0F
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld [wWarpDestY], a
    ld a, $F0
    ld [wWarpDestFacing], a
    ld a, $60
    call QueueSoundEffect
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or a, $80
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wFieldTransitionKind], a
    ld c, $01
    ret

; on map screen row 1: warps to screen (0, 1) at ($40, $38), shifts the wCDAD entry, plays sound $60, wCC44 = $83 and starts the transition; C = 1 (E-0125)
; 1 call site from 1 routine (e.g. Func_061_5764_Case04)
; reads: hMapScreenY, wKeyWorldFloor, hPlayerStateFlags
; writes: hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wWarpDestFacing, wMapType, wModeState, wFieldTransitionStep, ...
WarpToScreen01Event83::
Func_061_5807:: ; address name
    ldh a, [hMapScreenY]
    cp a, $01
    jr z, Jump_061_5810
    ld c, $00
    ret

Jump_061_5810::
    xor a, a
    ldh [hMapScreenX], a
    inc a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $38
    ld [wWarpDestY], a
    ld a, $FF
    ld [wWarpDestFacing], a
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState + $1
    add_a_to_hl
    ld a, [hl-]
    ld [hl], a
    ld a, $60
    call QueueSoundEffect
    ld a, $83
    ld [wMapType], a
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or a, $40
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wFieldTransitionKind], a
    ld c, $01
    ret

; on screen row 1: warps to the screen in the wCD78 entry of wCC45 and starts the transition; C = 1 (E-0127)
; 1 call site from 1 routine (e.g. Func_061_5764_Case02)
; reads: hMapScreenY, wKeyWorldFloor, hPlayerStateFlags
; writes: hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wWarpDestFacing, wModeState, wFieldTransitionStep, hPlayerStateFlags, ...
; points at: wKeyWorldAreaExits
WarpByKeyWorldAreaExitsEntryAtScreenRow1::
Func_061_585A:: ; address name
    ldh a, [hMapScreenY]
    cp a, $01
    jr z, Jump_061_5863
    ld c, $00
    ret

Jump_061_5863::
    ld a, [wKeyWorldFloor]
    and a, $7F
    sla a
    sla a
    ld hl, wKeyWorldAreaExits
    add_a_to_hl
    ld a, [wKeyWorldFloor]
    bit 7, a
    jr z, Jump_061_587C
    inc hl

Jump_061_587C::
    ld a, [hl]
    swap a
    and a, $0F
    ldh [hMapScreenX], a
    ld a, [hl]
    and a, $0F
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld [wWarpDestY], a
    ld a, $F0
    ld [wWarpDestFacing], a
    ld a, $60
    call QueueSoundEffect
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or a, $80
    ldh [hPlayerStateFlags], a
    ldh a, [hPlayerStateFlags]
    and a, $FE
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wFieldTransitionKind], a
    ld c, $01
    ret

; checks the warp list Data_061_6566[wCDAC entry] against the current screen and warps when one matches; C = 0 when none (E-0130)
; 1 call site from 1 routine (e.g. Func_061_5764_Case03)
; reads: wKeyWorldFloor, hMapScreenX, hMapScreenY, hPlayerStateFlags
; writes: wWarpDestFacing, wWarpDestX, wWarpDestY, hMapScreenX, hMapScreenY, wModeState, wFieldTransitionStep, hPlayerStateFlags, ...
; points at: wKeyWorldFloorState, wKeyWorldFloorInfo
CheckKeyWorldWarpTable::
Func_061_58BC:: ; address name
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState
    add_a_to_hl
    ld a, [hl]
    and a, $7F
    ld l, a
    ld h, $00
    sla l
    rl h
    ld de, Data_061_6566
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a

Jump_061_58DB::
    push de
    ld a, [de]
    inc de
    cp a, $80
    jr nz, Jump_061_58E6
    pop de
    ld c, $00
    ret

Jump_061_58E6::
    cp a, $FD
    jr z, Jump_061_590B
    cp a, $FE
    jr z, Jump_061_58F4
    cp a, $FF
    jr z, Jump_061_58F4
    jr Jump_061_590B

Jump_061_58F4::
    ld [wWarpDestFacing], a
    inc de
    ld a, [de]
    inc de
    ld c, a
    ldh a, [hMapScreenX]
    cp a, c
    jr nz, Jump_061_590B
    ld a, [de]
    inc de
    ld c, a
    ldh a, [hMapScreenY]
    cp a, c
    jr nz, Jump_061_590B
    jr Jump_061_5916
    db $F1

Jump_061_590B::
    pop de
    ld a, e
    add a, $09
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    jr Jump_061_58DB

Jump_061_5916::
    ld a, [de]
    cp a, $FF
    jr nz, Jump_061_5949
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
    and a, $0F
    ldh [hMapScreenX], a
    ld a, [hl]
    and a, $0F
    ldh [hMapScreenY], a
    ld a, $F0
    ld [wWarpDestFacing], a
    jr Jump_061_594D

Jump_061_5949::
    pop de
    ld c, $00
    ret

Jump_061_594D::
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or a, $80
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wFieldTransitionKind], a
    pop de
    ld a, $60
    call QueueSoundEffect
    ld c, $01
    ret

; runs the routine for wCC44 & 7 (jump table; 7 reuses 4) (E-0122)
; 1 call site from 1 routine (e.g. CheckWarpsAtPlayerPosition)
; reads: wMapType
RunMapType_596F::
Func_061_596F:: ; address name
    ld a, [wMapType]
    and a, $07
    rst $00
    dw RunMapType_596F_Case00
    dw RunMapType_596F_Case01
    dw RunMapType_596F_Case02
    dw RunMapType_596F_Case03
    dw RunMapType_596F_Case04
    dw RunMapType_596F_Case05
    dw RunMapType_596F_Case06
    dw RunMapType_596F_Case04

; entry 4 of the `rst $00` table in RunMapType_596F
; no direct call (reached through a table, a jump or a vector)
RunMapType_596F_Case04::
Jump_061_5985:: ; address name
    ret

; entry 0 of the `rst $00` table in RunMapType_596F
; no direct call (reached through a table, a jump or a vector)
RunMapType_596F_Case00::
Jump_061_5986:: ; address name
    call RunMapType_596F_Case00_Sub02
    or a, a
    ret nz
    call RunMapType_596F_Case00_Sub03
    or a, a
    ret nz
    call RunMapType_596F_Case00_Sub01
    or a, a
    ret nz
    ret

; entry 1 of the `rst $00` table in RunMapType_596F
; no direct call (reached through a table, a jump or a vector)
RunMapType_596F_Case01::
Jump_061_5996:: ; address name
    call ReturnStub_5CCF
    ret

; entry 2 of the `rst $00` table in RunMapType_596F
; no direct call (reached through a table, a jump or a vector)
RunMapType_596F_Case02::
Jump_061_599A:: ; address name
    call RunMapType_596F_Case02_Sub01
    ret

; entry 3 of the `rst $00` table in RunMapType_596F
; no direct call (reached through a table, a jump or a vector)
RunMapType_596F_Case03::
Jump_061_599E:: ; address name
    call RunMapType_596F_Case03_Sub01
    ret

; entry 5 of the `rst $00` table in RunMapType_596F
; no direct call (reached through a table, a jump or a vector)
RunMapType_596F_Case05::
Jump_061_59A2:: ; address name
    call RunMapType_596F_Case05_Sub01
    ret

; entry 6 of the `rst $00` table in RunMapType_596F
; no direct call (reached through a table, a jump or a vector)
RunMapType_596F_Case06::
Jump_061_59A6:: ; address name
    call RunMapType_596F_Case06_Sub01
    ret

; only called from RunMapType_596F_Case06 (E-0047)
; 1 call site from 1 routine (e.g. RunMapType_596F_Case06)
; reads: hPlayerX, hPlayerY, wKeyWorldFloor, wKeyWorldArea, hPlayerStateFlags
; writes: wKeyWorldArea, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wWarpDestFacing, wMapType, wWarpPending, ...
RunMapType_596F_Case06_Sub01::
Func_061_59AA:: ; address name
    ldh a, [hPlayerX]
    cp a, $40
    jr z, Jump_061_59B3

Jump_061_59B0::
    ld c, $00
    ret

Jump_061_59B3::
    ldh a, [hPlayerY]
    cp a, $40
    jr nz, Jump_061_59B0
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState + $1
    add_a_to_hl
    ld a, [hl]
    add a, a
    ld de, wKeyWorldRoomTable + $1
    add a, e
    ld e, a
    jr nc, Jump_061_59D0
    inc d

Jump_061_59D0::
    ld a, [wKeyWorldArea]
    dec a
    ld [wKeyWorldArea], a
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_061_59DD
    inc d

Jump_061_59DD::
    ld a, [de]
    swap a
    and a, $0F
    ld hl, Data_061_5A2D
    add_a_to_hl
    ld a, [hl]
    swap a
    and a, $0F
    ldh [hMapScreenX], a
    ld a, [hl]
    and a, $0F
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld [wWarpDestY], a
    xor a, a
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
    xor a, a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or a, $80
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wFieldTransitionKind], a
    ld c, $01
    ret

; address loaded by RunMapType_596F_Case06_Sub01
Data_061_5A2D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $30, $11, $22, $03, $33

; only called from RunMapType_596F_Case05 (E-0047)
; 1 call site from 1 routine (e.g. RunMapType_596F_Case05)
; reads: hPlayerX, hPlayerStateFlags, hPlayerY, wKeyWorldFloor, wKeyWorldArea, hMapScreenX, hMapScreenY, hTemp1, ...
; writes: hPlayerStateFlags, hTemp0, hTemp1, wKeyWorldArea, wMapType, hMapScreenX, hMapScreenY, wWarpDestX, ...
; points at: wKeyWorldFloorState, wKeyWorldFloorInfo
RunMapType_596F_Case05_Sub01::
Func_061_5A33:: ; address name
    ldh a, [hPlayerX]
    cp a, $40
    jr z, Jump_061_5A42

Jump_061_5A39::
    ldh a, [hPlayerStateFlags]
    and a, $7F
    ldh [hPlayerStateFlags], a
    ld c, $00
    ret

Jump_061_5A42::
    ldh a, [hPlayerY]
    cp a, $40
    jr nz, Jump_061_5A39
    ld a, [wKeyWorldFloor]
    add a, a
    add a, a
    push af
    ld hl, wKeyWorldFloorInfo + $1
    add_a_to_hl
    ld a, [hl]
    ldh [hTemp0], a
    pop af
    add a, a
    add a, a
    ld hl, wKeyWorldFloorState
    add_a_to_hl
    ld a, [hl+]
    ldh [hTemp1], a
    ld a, [hl]
    add a, a
    ld de, wKeyWorldRoomTable + $1
    add a, e
    ld e, a
    jr nc, Jump_061_5A71
    inc d

Jump_061_5A71::
    ld a, [wKeyWorldArea]
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_061_5A7A
    inc d

Jump_061_5A7A::
    ldh a, [hMapScreenX]
    and a, $0F
    swap a
    ld b, a
    ldh a, [hMapScreenY]
    and a, $0F
    or a, b
    ld b, a
    ld a, [de]
    and a, $0F
    cp a, $0F
    jp z, Jump_061_5A9B
    ld hl, Data_061_5BB5
    add_a_to_hl
    ld a, [hl]
    cp a, b
    jr z, Jump_061_5AB5

Jump_061_5A9B::
    ld a, [de]
    swap a
    and a, $0F
    ld hl, Data_061_5BB5
    add_a_to_hl
    ld a, [hl]
    cp a, b
    jr z, Jump_061_5B18
    ldh a, [hPlayerStateFlags]
    and a, $7F
    ldh [hPlayerStateFlags], a
    ld c, $00
    ret

Jump_061_5AB5::
    ld a, [wKeyWorldArea]
    or a, a
    jr nz, Jump_061_5B08
    ldh a, [hTemp0]
    cp a, $04
    jr nz, Jump_061_5B08
    ld a, [wKeyWorldFloor]
    add a, a
    add a, a
    ld hl, wKeyWorldFloorInfo
    add_a_to_hl
    ld a, [hl]
    swap a
    and a, $0F
    ldh [hMapScreenX], a
    ld a, [hl]
    and a, $0F
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld [wWarpDestY], a
    ld a, $F0
    ld [wWarpDestFacing], a
    ld a, $60
    call QueueSoundEffect
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or a, $80
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wFieldTransitionKind], a
    ld c, $01
    ret

Jump_061_5B08::
    ld a, [wKeyWorldArea]
    dec a
    ld [wKeyWorldArea], a
    dec de
    dec de
    ld a, [de]
    swap a
    and a, $0F
    jr Jump_061_5B6B

Jump_061_5B18::
    ld a, [wKeyWorldArea]
    inc a
    ld [wKeyWorldArea], a
    inc a
    ld c, a
    ldh a, [hTemp1]
    cp a, c
    jr nz, Jump_061_5B66
    ld a, $86
    ld [wMapType], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld [wWarpDestY], a
    xor a, a
    ld [wWarpDestFacing], a
    ld a, $60
    call QueueSoundEffect
    ld a, $01
    ld [wWarpPending], a
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wFieldTransitionStep], a
    xor a, a
    ld [wFieldReturnPhase], a
    ldh a, [hPlayerStateFlags]
    or a, $80
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wFieldTransitionKind], a
    ld c, $01
    ret

Jump_061_5B66::
    inc de
    inc de
    ld a, [de]
    and a, $0F

Jump_061_5B6B::
    ld hl, Data_061_5BB5
    add_a_to_hl
    ld a, [hl]
    swap a
    and a, $0F
    ldh [hMapScreenX], a
    ld a, [hl]
    and a, $0F
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld [wWarpDestY], a
    xor a, a
    ld [wWarpDestFacing], a
    ld a, $60
    call QueueSoundEffect
    ld a, $01
    ld [wWarpPending], a
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or a, $80
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wFieldTransitionKind], a
    xor a, a
    ld [wFieldReturnPhase], a
    ld c, $01
    ret

; address loaded by RunMapType_596F_Case05_Sub01
Data_061_5BB5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $30, $11, $22, $03, $33

; only called from RunMapType_596F_Case02 (E-0047)
; 1 call site from 1 routine (e.g. RunMapType_596F_Case02)
; reads: hPlayerX, hPlayerY, wMapToggleRequest, wKeyWorldFloor, hPlayerStateFlags
; writes: wMapToggleRequest, wKeyWorldFloor, wWarpDestX, wWarpDestY, wWarpDestFacing, wMapToggleFlag, wModeState, wMenuState, ...
RunMapType_596F_Case02_Sub01::
Func_061_5BBB:: ; address name
    ldh a, [hPlayerX]
    cp a, $40
    jr z, Jump_061_5BC4

Jump_061_5BC1::
    ld c, $00
    ret

Jump_061_5BC4::
    ldh a, [hPlayerY]
    cp a, $30
    jr nz, Jump_061_5BC1
    ld a, [wMapToggleRequest]
    or a, a
    jr z, Jump_061_5BC1
    xor a, a
    ld [wMapToggleRequest], a
    ld a, [wKeyWorldFloor]
    add a, $80
    ld [wKeyWorldFloor], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $30
    ld [wWarpDestY], a
    ld a, $FF
    ld [wWarpDestFacing], a
    xor a, a
    ld [wMapToggleFlag], a
    ld a, $06
    ld [wModeState], a
    xor a, a
    ld [wMenuState], a
    ld [wMenuSubState], a
    ldh a, [hPlayerStateFlags]
    or a, $80
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wFieldTransitionKind], a
    ret

; only called from RunMapType_596F_Case03 (E-0047)
; 1 call site from 1 routine (e.g. RunMapType_596F_Case03)
; reads: wKeyWorldFloor, hPlayerStateFlags, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY
; writes: hPlayerStateFlags, wWarpDestFacing, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wMapType, wModeState, ...
; points at: wKeyWorldFloorState
RunMapType_596F_Case03_Sub01::
Func_061_5C07:: ; address name
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState
    add_a_to_hl
    ld a, [hl]
    and a, $7F
    ld l, a
    ld h, $00
    sla l
    rl h
    ld de, Data_061_6566
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a

Jump_061_5C26::
    push de
    ld a, [de]
    inc de
    cp a, $80
    jr nz, Jump_061_5C37
    pop de
    ldh a, [hPlayerStateFlags]
    and a, $7F
    ldh [hPlayerStateFlags], a
    ld c, $00
    ret

Jump_061_5C37::
    cp a, $FD
    jr z, Jump_061_5C3D
    jr Jump_061_5C73

Jump_061_5C3D::
    ld a, [de]
    inc de
    ld [wWarpDestFacing], a
    push af
    swap a
    and a, $0F
    ld c, a
    ldh a, [hMapScreenX]
    cp a, c
    jr nz, Jump_061_5C72
    pop af
    and a, $0F
    ld c, a
    ldh a, [hMapScreenY]
    cp a, c
    jr nz, Jump_061_5C73
    ld a, [de]
    inc de
    ld c, a
    ldh a, [hPlayerX]
    cp a, c
    jr nz, Jump_061_5C73
    ld a, [de]
    inc de
    ld c, a
    ldh a, [hPlayerY]
    cp a, c
    jr nz, Jump_061_5C73
    ldh a, [hPlayerStateFlags]
    bit 7, a
    jr z, Jump_061_5C70
    pop de
    ld c, $00
    ret

Jump_061_5C70::
    jr Jump_061_5C7E

Jump_061_5C72::
    pop af

Jump_061_5C73::
    pop de
    ld a, e
    add a, $09
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    jr Jump_061_5C26

Jump_061_5C7E::
    ld a, [de]
    cp a, $F2
    jr nz, Jump_061_5CCB
    xor a, a
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
    ld a, [hl+]
    ld [hl-], a
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
    xor a, a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or a, $80
    ldh [hPlayerStateFlags], a
    ld a, $03
    ld [wFieldTransitionKind], a
    pop de
    ld c, $01
    ret

Jump_061_5CCB::
    pop de
    ld c, $00
    ret

; a bare ret (E-0116)
; 1 call site from 1 routine (e.g. RunMapType_596F_Case01)
ReturnStub_5CCF::
Func_061_5CCF:: ; address name
    ret

; only called from RunMapType_596F_Case00 (E-0047)
; 1 call site from 1 routine (e.g. RunMapType_596F_Case00)
; reads: hPlayerStateFlags, hPlayerX, hPlayerY, hMapScreenX, hMapScreenY, hTemp2, hTemp1
; writes: hTemp1, hPlayerStateFlags, hTemp2, wKeyWorldFloor, wMapType, hMapScreenX, hMapScreenY, wWarpDestX, ...
; points at: wKeyWorldFloorState
RunMapType_596F_Case00_Sub01::
Func_061_5CD0:: ; address name
    ld hl, wKeyWorldFloorInfo + $3
    xor a, a
    ldh [hTemp1], a

Jump_061_5CD6::
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_061_5CE6
    ldh a, [hPlayerStateFlags]
    and a, $5F
    ldh [hPlayerStateFlags], a
    xor a, a
    ret

Jump_061_5CE3::
    pop hl
    xor a, a
    ret

Jump_061_5CE6::
    push hl
    dec hl
    dec hl
    ld a, [hl]
    ldh [hTemp2], a
    cp a, $04
    jr z, Jump_061_5D11
    cp a, $05
    jr z, Jump_061_5D11
    ldh a, [hPlayerX]
    swap a
    and a, $0F
    cp a, $04
    jr z, Jump_061_5D02
    cp a, $05
    jr nz, Jump_061_5D0E

Jump_061_5D02::
    ldh a, [hPlayerY]
    swap a
    and a, $0F
    cp a, $04
    jr nz, Jump_061_5D0E
    jr Jump_061_5D25

Jump_061_5D0E::
    jp Jump_061_5E7A

Jump_061_5D11::
    ldh a, [hPlayerX]
    swap a
    and a, $0F
    cp a, $04
    jr nz, Jump_061_5D0E
    ldh a, [hPlayerY]
    swap a
    and a, $0F
    cp a, $04
    jr nz, Jump_061_5D0E

Jump_061_5D25::
    dec hl
    ld a, [hl]
    swap a
    and a, $0F
    ld b, a
    ld a, [hl]
    and a, $0F
    ld c, a
    ldh a, [hMapScreenX]
    cp a, b
    jp nz, Jump_061_5E7A
    ldh a, [hMapScreenY]
    cp a, c
    jp nz, Jump_061_5E7A
    ldh a, [hPlayerStateFlags]
    bit 7, a
    jr nz, Jump_061_5CE3
    ldh a, [hTemp2]
    cp a, $04
    jp z, Jump_061_5E02
    cp a, $05
    jp z, Jump_061_5DE1
    ldh a, [hTemp1]
    ld [wKeyWorldFloor], a
    ld a, $83
    ld [wMapType], a
    ldh a, [hTemp1]
    swap a
    ld hl, wKeyWorldFloorState
    add_a_to_hl
    ld a, [hl]
    and a, $7F
    ld e, a
    ld d, $00
    sla e
    rl d
    ld a, e
    add a, $D8
    ld e, a
    ld a, d
    adc a, $60
    ld d, a
    ld b, $61
    call ReadByteInBank
    ld l, c
    inc de
    call ReadByteInBank
    ld h, c
    ld a, $0C
    add_a_to_hl
    ldh a, [hPlayerX]
    cp a, $40
    jr z, Jump_061_5D92
    inc hl
    inc hl
    inc hl
    inc hl

Jump_061_5D92::
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
    xor a, a
    ld [wWarpDestFacing], a
    ld a, $60
    call QueueSoundEffect
    xor a, a
    ld [wFieldReturnPhase], a
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or a, $80
    ldh [hPlayerStateFlags], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ClearPendingFieldEventIfBit7AndNot6
    pop hl
    ld a, $01
    ret

Jump_061_5DE1::
    xor a, a
    ld [wKeyWorldArea], a
    ld a, $01
    ldh [hMapScreenX], a
    ld a, $03
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $80
    ld [wWarpDestY], a
    xor a, a
    ld [wWarpDestFacing], a
    ld a, $03
    ld [wFieldTransitionKind], a
    jr Jump_061_5E44

Jump_061_5E02::
    xor a, a
    ld [wKeyWorldArea], a
    ldh a, [hTemp1]
    swap a
    ld hl, wKeyWorldFloorState + $1
    add_a_to_hl
    ld a, [hl]
    add a, a
    ld hl, wKeyWorldRoomTable + $1
    add_a_to_hl
    ld a, [hl]
    and a, $0F
    ld hl, Data_061_5E87
    add_a_to_hl
    ld a, [hl]
    swap a
    and a, $0F
    ldh [hMapScreenX], a
    ld a, [hl]
    and a, $0F
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld [wWarpDestY], a
    xor a, a
    ld [wWarpDestFacing], a
    ld a, $01
    ld [wFieldTransitionKind], a

Jump_061_5E44::
    ldh a, [hTemp1]
    ld [wKeyWorldFloor], a
    ld a, $85
    ld [wMapType], a
    ld a, $01
    ld [wWarpPending], a
    ld a, $60
    call QueueSoundEffect
    xor a, a
    ld [wFieldReturnPhase], a
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wFieldTransitionStep], a
    ldh a, [hPlayerStateFlags]
    or a, $80
    ldh [hPlayerStateFlags], a
    farcall ClearPendingFieldEventIfBit7AndNot6
    pop hl
    ld a, $01
    ret

Jump_061_5E7A::
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    ldh a, [hTemp1]
    inc a
    ldh [hTemp1], a
    jp Jump_061_5CD6

; address loaded by RunMapType_596F_Case00_Sub01
Data_061_5E87:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $30, $11, $22, $03, $33

; only called from RunMapType_596F_Case00 (E-0047)
; 1 call site from 1 routine (e.g. RunMapType_596F_Case00)
; reads: wKeyWorldActive, wKeyWorldKey, wKeyWorldSlot, hMapScreenX, hMapScreenY, wKeyWorldGoalCell, hPlayerX, hPlayerY, ...
; writes: wFieldReturnPhase, wFieldTransitionStep, wModeState, hPlayerStateFlags, wMapType, hMapScreenX, hMapScreenY, wWarpDestX, ...
RunMapType_596F_Case00_Sub02::
Func_061_5E8D:: ; address name
    ld a, [wKeyWorldActive]
    or a, a
    jr z, Jump_061_5ECF
    ld a, [wKeyWorldKey]
    bit 7, a
    jr z, Jump_061_5ECF
    and a, $7F
    ld c, a
    ld a, [wKeyWorldSlot]
    cp a, c
    jr nz, Jump_061_5ECF
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or a, c
    ld c, a
    ld a, [wKeyWorldGoalCell]
    cp a, c
    jr nz, Jump_061_5EC7
    ldh a, [hPlayerX]
    and a, $F0
    ld c, a
    ldh a, [hPlayerY]
    and a, $F0
    swap a
    or a, c
    ld c, a
    ld a, [wKeyWorldGoal]
    cp a, c
    jr nz, Jump_061_5EC7
    jr Jump_061_5EF0

Jump_061_5EC7::
    ldh a, [hPlayerStateFlags]
    and a, $DF
    ldh [hPlayerStateFlags], a

Jump_061_5ECD::
    xor a, a
    ret

Jump_061_5ECF::
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or a, c
    ld c, a
    ld a, [wKeyWorldGoalScreen]
    cp a, c
    jr nz, Jump_061_5EC7
    ld a, [wKeyWorldGoalPos]
    ld c, a
    ldh a, [hPlayerX]
    cp a, c
    jr nz, Jump_061_5EC7
    ld a, [wKeyWorldGoalPos2]
    ld c, a
    ldh a, [hPlayerY]
    cp a, c
    jr nz, Jump_061_5EC7

Jump_061_5EF0::
    ldh a, [hPlayerStateFlags]
    bit 5, a
    jr nz, Jump_061_5ECD
    ld a, $60
    call QueueSoundEffect
    xor a, a
    ld [wFieldReturnPhase], a
    ld a, $04
    call StartPaletteFade
    xor a, a
    ld [wFieldTransitionStep], a
    ld a, $04
    ld [wModeState], a
    ldh a, [hPlayerStateFlags]
    or a, $20
    ldh [hPlayerStateFlags], a
    ld a, $87
    ld [wMapType], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $80
    ld [wWarpDestY], a
    xor a, a
    ld [wWarpDestFacing], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ClearPendingFieldEventIfBit7AndNot6
    ld a, $01
    ret

; only called from RunMapType_596F_Case00 (E-0047)
; 1 call site from 1 routine (e.g. RunMapType_596F_Case00)
; reads: hPlayerX, hPlayerY, hMapScreenX, hMapScreenY, hPlayerStateFlags
; writes: wWarpDestX, wWarpDestY, wWarpDestFacing, wFieldReturnPhase, wFieldTransitionStep, wModeState, hPlayerStateFlags, wKeyWorldFloor, ...
; points at: wKeyWorldObjects
RunMapType_596F_Case00_Sub03::
Func_061_5F39:: ; address name
    ldh a, [hPlayerX]
    ld c, a
    ldh a, [hPlayerY]
    cp a, c
    jr nz, Jump_061_5F51
    swap a
    and a, $0F
    cp a, $04
    jr nz, Jump_061_5F51
    ld hl, wKeyWorldObjects

Jump_061_5F4C::
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_061_5F56

Jump_061_5F51::
    xor a, a
    ret

Jump_061_5F53::
    pop hl
    xor a, a
    ret

Jump_061_5F56::
    push hl
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    swap a
    and a, $0F
    ld b, a
    ld a, [hl]
    and a, $0F
    ld c, a
    ldh a, [hMapScreenX]
    cp a, b
    jp nz, Jump_061_5FE0
    ldh a, [hMapScreenY]
    cp a, c
    jp nz, Jump_061_5FE0
    ldh a, [hPlayerStateFlags]
    bit 7, a
    jr nz, Jump_061_5F53
    ld a, $40
    ld [wWarpDestX], a
    ld [wWarpDestY], a
    xor a, a
    ld [wWarpDestFacing], a
    ld a, $60
    call QueueSoundEffect
    xor a, a
    ld [wFieldReturnPhase], a
    push hl
    ld a, $04
    call StartPaletteFade
    pop hl
    xor a, a
    ld [wFieldTransitionStep], a
    ld a, $04
    ld [wModeState], a
    ldh a, [hPlayerStateFlags]
    or a, $80
    ldh [hPlayerStateFlags], a
    inc hl
    inc hl
    ld a, [hl]
    or a, a
    jr nz, Jump_061_5FDF
    inc hl
    ld a, l
    sub a, $7B
    ld l, a
    ld a, h
    sbc a, $CD
    ld h, a
    sra h
    rr l
    sra h
    rr l
    ld a, l
    ld [wKeyWorldFloor], a
    ld a, $82
    ld [wMapType], a
    xor a, a
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

Jump_061_5FDF::
    ret

Jump_061_5FE0::
    inc hl
    ld a, [hl]
    swap a
    and a, $0F
    ld b, a
    ld a, [hl]
    and a, $0F
    ld c, a
    ldh a, [hMapScreenX]
    cp a, b
    jp nz, Jump_061_6065
    ldh a, [hMapScreenY]
    cp a, c
    jp nz, Jump_061_6065
    ldh a, [hPlayerStateFlags]
    bit 7, a
    jp nz, Jump_061_5F53
    ld a, $40
    ld [wWarpDestX], a
    ld [wWarpDestY], a
    xor a, a
    ld [wWarpDestFacing], a
    ld a, $60
    call QueueSoundEffect
    push hl
    ld a, $04
    call StartPaletteFade
    pop hl
    xor a, a
    ld [wFieldTransitionStep], a
    ld a, $04
    ld [wModeState], a
    ldh a, [hPlayerStateFlags]
    or a, $80
    ldh [hPlayerStateFlags], a
    inc hl
    ld a, [hl]
    or a, a
    jr nz, Jump_061_6064
    inc hl
    ld a, l
    sub a, $7B
    ld l, a
    ld a, h
    sbc a, $CD
    ld h, a
    sra h
    rr l
    sra h
    rr l
    ld a, l
    or a, $80
    ld [wKeyWorldFloor], a
    ld a, $82
    ld [wMapType], a
    xor a, a
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

Jump_061_6064::
    ret

Jump_061_6065::
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jp Jump_061_5F4C

; hFFC6 = 1 when bit 7 of wCD07 is set; otherwise on map types $80/$85 the wCE7E entry of the current area (wCD74), else 0 (E-0129)
; 1 call site from 1 routine (e.g. Func_016_5D13_Case00)
; reads: wKeyWorldFlags, wMapType, wKeyWorldFloor, hMapScreenY, hMapScreenX
; writes: hTemp0
; points at: wKeyWorldFloorInfo, wKeyWorldAreaInfo
KeyWorldAreaEncounterIndex::
Func_061_606D:: ; address name
    ld a, [wKeyWorldFlags]
    bit 7, a
    jr z, Jump_061_6079
    ld a, $01
    ldh [hTemp0], a
    ret

Jump_061_6079::
    push hl
    push de
    ld a, [wMapType]
    cp a, $80
    jr z, Jump_061_60AC
    cp a, $85
    jr z, Jump_061_608A
    xor a, a
    ldh [hTemp0], a
    ret

Jump_061_608A::
    ld a, [wKeyWorldFloor]
    add a, a
    add a, a
    ld de, wKeyWorldFloorInfo
    add a, e
    ld e, a
    jr nc, Jump_061_6097
    inc d

Jump_061_6097::
    ld a, [de]
    and a, $0F
    srl a
    srl a
    add a, a
    ld l, a
    ld a, [de]
    swap a
    and a, $0F
    srl a
    srl a
    add a, l
    jr Jump_061_60BB

Jump_061_60AC::
    ldh a, [hMapScreenY]
    srl a
    srl a
    add a, a
    ld l, a
    ldh a, [hMapScreenX]
    srl a
    srl a
    add a, l

Jump_061_60BB::
    ld hl, wKeyWorldAreaInfo
    add_a_to_hl
    ld a, [hl]
    and a, $F0
    swap a
    add a, a
    add a, a
    ld hl, wKeyWorldEncounterTable + $3
    add_a_to_hl
    ld a, [hl]
    ldh [hTemp0], a
    pop de
    pop hl
    ret

; E-0144 (C1: LoadSpecialMapHeader and LoadMapScreenFromChunk map bank $61 and read the word $60D8 + 2 * hFFC6; every non-zero word is $61D8 + 26 * n).
; record: special map record ($0000 = none)
SpecialMapTable::
Data_061_60D8:: ; heuristic: start of a structured table; C0
    dw SpecialMapRecords ; id 0
    dw Data_061_61F2 ; id 1
    dw Data_061_620C ; id 2
    dw Data_061_6226 ; id 3
    dw Data_061_6240 ; id 4
    dw Data_061_625A ; id 5
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
    dw Data_061_6274 ; id 32
    dw Data_061_628E ; id 33
    dw Data_061_62A8 ; id 34
    dw Data_061_62C2 ; id 35
    dw Data_061_62DC ; id 36
    dw Data_061_62F6 ; id 37
    dw Data_061_6310 ; id 38
    dw Data_061_632A ; id 39
    dw Data_061_6344 ; id 40
    dw Data_061_635E ; id 41
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
    dw Data_061_6378 ; id 64
    dw Data_061_6392 ; id 65
    dw Data_061_63AC ; id 66
    dw Data_061_63C6 ; id 67
    dw Data_061_63E0 ; id 68
    dw Data_061_63FA ; id 69
    dw Data_061_6414 ; id 70
    dw Data_061_642E ; id 71
    dw Data_061_6448 ; id 72
    dw Data_061_6462 ; id 73
    dw $0000 ; id 74
    dw $0000 ; id 75
    dw $0000 ; id 76
    dw $0000 ; id 77
    dw $0000 ; id 78
    dw $0000 ; id 79
    dw Data_061_647C ; id 80
    dw Data_061_6496 ; id 81
    dw Data_061_64B0 ; id 82
    dw Data_061_64CA ; id 83
    dw Data_061_64E4 ; id 84
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
    dw Data_061_64FE ; id 97
    dw Data_061_6518 ; id 98
    dw Data_061_6532 ; id 99
    dw Data_061_654C ; id 100
    dw Data_061_654C ; id 101
    dw Data_061_654C ; id 102
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

; E-0144 (C1: LoadSpecialMapHeader decompresses the tileset to vTiles2, loads the palettes with LoadBGPaletteBufferFromBank and stores the five header bytes; LoadMapScreenFromChunk takes the far pointer at +$14 as the screen array (3 * (hMapScreenY * width + hMapScreenX)) and, on CGB, the one at +$17 as the attribute array; every array decodes to 360-byte screens).
; record: tileset; its ROM bank; palettes; its ROM bank; width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind; 9 bytes not read by these routines; screen tile-map array; its ROM bank; screen attribute-map array; its ROM bank
SpecialMapRecords::
Data_061_61D8:: ; heuristic: special map record; C0
    dfar SpecialMap00Tileset ; id 0
    dfar SpecialMap00Palettes
    db $01, $02, $4F, $4C, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap00Screens
    dfar SpecialMap00Attrs
Data_061_61F2:: ; heuristic: special map record; C0
    dfar SpecialMap01Tileset ; id 1
    dfar SpecialMap01Palettes
    db $01, $02, $4F, $4C, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap01Screens
    dfar SpecialMap01Attrs
Data_061_620C:: ; heuristic: special map record; C0
    dfar SpecialMap02Tileset ; id 2
    dfar SpecialMap02Palettes
    db $01, $02, $4F, $4C, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap02Screens
    dfar SpecialMap02Attrs
Data_061_6226:: ; heuristic: special map record; C0
    dfar SpecialMap03Tileset ; id 3
    dfar SpecialMap03Palettes
    db $01, $02, $4F, $4C, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap03Screens
    dfar SpecialMap03Attrs
Data_061_6240:: ; heuristic: special map record; C0
    dfar SpecialMap04Tileset ; id 4
    dfar SpecialMap04Palettes
    db $01, $02, $4F, $4C, $00
Data_061_624B:: ; heuristic: label inside a table; C0
    db $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap04Screens
    dfar SpecialMap04Attrs
Data_061_625A:: ; heuristic: special map record; C0
    dfar SpecialMap05Tileset ; id 5
    dfar SpecialMap05Palettes
    db $01, $02, $4F, $4C, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap05Screens
    dfar SpecialMap05Attrs
Data_061_6274:: ; heuristic: special map record; C0
    dfar SpecialMap06Tileset ; id 6
    dfar SpecialMap06Palettes
    db $02, $02, $4F, $00, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap06Screens
    dfar SpecialMap06Attrs
Data_061_628E:: ; heuristic: special map record; C0
    dfar SpecialMap07Tileset ; id 7
    dfar SpecialMap07Palettes
    db $02, $02, $4F, $00, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap07Screens
    dfar SpecialMap07Attrs
Data_061_62A8:: ; heuristic: special map record; C0
    dfar SpecialMap08Tileset ; id 8
    dfar SpecialMap08Palettes
    db $02, $02, $4F, $00, $01, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap08Screens
    dfar SpecialMap08Attrs
Data_061_62C2:: ; heuristic: special map record; C0
    dfar SpecialMap09Tileset ; id 9
    dfar SpecialMap09Palettes
    db $02, $02, $4F, $00, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap09Screens
    dfar SpecialMap09Attrs
Data_061_62DC:: ; heuristic: special map record; C0
    dfar SpecialMap0ATileset ; id 10
    dfar SpecialMap0APalettes
    db $02, $02, $4F, $00, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap0AScreens
    dfar SpecialMap0AAttrs
Data_061_62F6:: ; heuristic: special map record; C0
    dfar SpecialMap0BTileset ; id 11
    dfar SpecialMap0BPalettes
    db $02, $02, $4F, $00, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap0BScreens
    dfar SpecialMap0BAttrs
Data_061_6310:: ; heuristic: special map record; C0
    dfar SpecialMap0CTileset ; id 12
    dfar SpecialMap0CPalettes
    db $02, $02, $4F, $00, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap0CScreens
    dfar SpecialMap0CAttrs
Data_061_632A:: ; heuristic: special map record; C0
    dfar SpecialMap0DTileset ; id 13
    dfar SpecialMap0DPalettes
    db $02, $02, $4F, $00, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap0DScreens
    dfar SpecialMap0DAttrs
Data_061_6344:: ; heuristic: special map record; C0
    dfar SpecialMap0ETileset ; id 14
    dfar SpecialMap0EPalettes
    db $02, $02, $4F, $00, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap0EScreens
    dfar SpecialMap0EAttrs
Data_061_635E:: ; heuristic: special map record; C0
    dfar SpecialMap0FTileset ; id 15
    dfar SpecialMap0FPalettes
    db $02, $02, $4F, $00, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80
    dfar SpecialMap0FScreens
    dfar SpecialMap0FAttrs
Data_061_6378:: ; heuristic: special map record; C0
    dfar SpecialMap10Tileset ; id 16
    dfar SpecialMap10Palettes
    db $02, $01, $3F, $00, $00, $00, $00, $00, $40, $80, $00, $00, $40, $80
    dfar SpecialMap10Screens
    dfar SpecialMap10Attrs
Data_061_6392:: ; heuristic: special map record; C0
    dfar SpecialMap11Tileset ; id 17
    dfar SpecialMap11Palettes
    db $02, $01, $3F, $00, $00, $00, $00, $00, $40, $80, $00, $00, $40, $80
    dfar SpecialMap11Screens
    dfar SpecialMap11Attrs
Data_061_63AC:: ; heuristic: special map record; C0
    dfar SpecialMap12Tileset ; id 18
    dfar SpecialMap12Palettes
    db $02, $01, $3F, $00, $00, $00, $00, $00, $40, $80, $00, $00, $40, $80
    dfar SpecialMap12Screens
    dfar SpecialMap12Attrs
Data_061_63C6:: ; heuristic: special map record; C0
    dfar SpecialMap13Tileset ; id 19
    dfar SpecialMap13Palettes
    db $02, $01, $3F, $00, $00, $00, $00, $00, $40, $80, $00, $00, $40, $80
    dfar SpecialMap13Screens
    dfar SpecialMap13Attrs
Data_061_63E0:: ; heuristic: special map record; C0
    dfar SpecialMap14Tileset ; id 20
    dfar SpecialMap14Palettes
    db $02, $01, $3F, $00, $00, $00, $00, $00, $40, $80, $00, $00, $40, $80
    dfar SpecialMap14Screens
    dfar SpecialMap14Attrs
Data_061_63FA:: ; heuristic: special map record; C0
    dfar SpecialMap15Tileset ; id 21
    dfar SpecialMap15Palettes
    db $02, $01, $3F, $00, $00, $00, $00, $00, $40, $80, $00, $00, $40, $80
    dfar SpecialMap15Screens
    dfar SpecialMap15Attrs
Data_061_6414:: ; heuristic: special map record; C0
    dfar SpecialMap16Tileset ; id 22
    dfar SpecialMap16Palettes
    db $02, $01, $3F, $00, $00, $00, $00, $00, $40, $80, $00, $00, $40, $80
    dfar SpecialMap16Screens
    dfar SpecialMap16Attrs
Data_061_642E:: ; heuristic: special map record; C0
    dfar SpecialMap17Tileset ; id 23
    dfar SpecialMap17Palettes
    db $02, $01, $3F, $00, $00, $00, $00, $00, $40, $80, $00, $00, $40, $80
    dfar SpecialMap17Screens
    dfar SpecialMap17Attrs
Data_061_6448:: ; heuristic: special map record; C0
    dfar SpecialMap18Tileset ; id 24
    dfar SpecialMap18Palettes
    db $02, $01, $3F, $00, $01, $00, $00, $00, $40, $80, $00, $00, $40, $80
    dfar SpecialMap18Screens
    dfar SpecialMap18Attrs
Data_061_6462:: ; heuristic: special map record; C0
    dfar SpecialMap19Tileset ; id 25
    dfar SpecialMap19Palettes
    db $02, $01, $3F, $00, $00, $00, $00, $00, $40, $80, $00, $00, $40, $80
    dfar SpecialMap19Screens
    dfar SpecialMap19Attrs
Data_061_647C:: ; heuristic: special map record; C0
    dfar SpecialMap1ATileset ; id 26
    dfar SpecialMap1APalettes
    db $01, $01, $3F, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    dfar SpecialMap1AScreens
    dfar SpecialMap1AAttrs
Data_061_6496:: ; heuristic: special map record; C0
    dfar SpecialMap1ATileset ; id 27
    dfar SpecialMap1APalettes
    db $01, $01, $3F, $3C, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    dfar SpecialMap1BScreens
    dfar SpecialMap1BAttrs
Data_061_64B0:: ; heuristic: special map record; C0
    dfar SpecialMap1ATileset ; id 28
    dfar SpecialMap1APalettes
    db $01, $01, $3F, $3C, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    dfar SpecialMap1CScreens
    dfar SpecialMap1CAttrs
Data_061_64CA:: ; heuristic: special map record; C0
    dfar SpecialMap1ATileset ; id 29
    dfar SpecialMap1APalettes
    db $01, $01, $3F, $3C, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    dfar SpecialMap1DScreens
    dfar SpecialMap1DAttrs
Data_061_64E4:: ; heuristic: special map record; C0
    dfar SpecialMap1ATileset ; id 30
    dfar SpecialMap1APalettes
    db $01, $01, $3F, $3C, $00, $00, $00, $00, $40, $80, $00, $00, $50, $80
    dfar SpecialMap1EScreens
    dfar SpecialMap1EAttrs
Data_061_64FE:: ; heuristic: special map record; C0
    dfar SpecialMap1FTileset ; id 31
    dfar SpecialMap1FPalettes
    db $01, $01, $23, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    dfar SpecialMap1FScreens
    dfar SpecialMap1FAttrs
Data_061_6518:: ; heuristic: special map record; C0
    dfar SpecialMap20Tileset ; id 32
    dfar SpecialMap20Palettes
    db $01, $01, $23, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    dfar SpecialMap20Screens
    dfar SpecialMap20Attrs
Data_061_6532:: ; heuristic: special map record; C0
    dfar SpecialMap21Tileset ; id 33
    dfar SpecialMap21Palettes
    db $01, $01, $19, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    dfar SpecialMap21Screens
    dfar SpecialMap21Attrs
Data_061_654C:: ; heuristic: special map record; C0
    dfar Map29Tileset ; id 34
    dfar Map29Palettes
    db $01, $01, $32, $2C, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    dfar Map29Screens0
    dfar Map29Attrs0

; address loaded by CheckKeyWorldWarpTable, RunMapType_596F_Case03_Sub01
Data_061_6566:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $67, $66, $67, $66, $67, $66, $67, $66, $67, $66, $67
    ds $35, $66
    db $71, $66, $71, $66, $71, $66, $71, $66, $71, $66, $71, $66, $71, $66, $71, $66
    db $71, $66, $71
    ds $2D, $66
    db $C3, $66, $C3, $66, $C3, $66, $C3, $66, $C3, $66, $C3, $66, $C3, $66, $C3, $66
    db $C3, $66, $C3
    ds $15, $66
    db $FA
    ds $1D, $66
    db $04, $67
    ds $38, $66
    INCBIN "dwm2-cobi-us.gbc", $186666, $AA

; LZSS-compressed asset: 607 bytes expand to 1543 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_061_6710:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $186710, $1B5
    ds $10, $FE
    INCBIN "dwm2-cobi-us.gbc", $1868D5, $9A

; LZSS-compressed asset: 166 bytes expand to 771 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_061_696F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $03, $03, $07, $02, $08, $06, $01, $06, $03, $03, $04, $07, $07, $02
    ds $10, $FE
    INCBIN "dwm2-cobi-us.gbc", $18698D, $88

; LZSS-compressed asset: 1089 bytes expand to 1795 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_061_6A15:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $186A15, $58
    ds $10, $FE
    INCBIN "dwm2-cobi-us.gbc", $186A7D, $48
    ds $10, $FE
    db $04, $02, $07, $01, $04, $02, $07, $01, $03, $02, $07, $01, $03, $02, $07, $01
    db $02, $06, $04, $04, $05, $05, $08, $03, $02, $03, $04, $01, $07, $02, $FF, $FF
    db $01, $04, $03, $03, $05, $02, $FF, $FF
    ds $28, $FE
    db $06, $07, $07, $06, $06, $07, $07, $06, $02, $03, $03, $06, $05, $01, $07, $05
    ds $50, $FE
    db $04, $04, $05, $06, $06, $02, $07, $05, $02, $02, $02, $06, $04, $04, $08, $03
    db $02, $03, $03, $07, $05, $04, $07, $06, $02, $04, $04, $03, $05, $05, $07, $06
    ds $40, $FE
    db $05, $04, $06, $03, $07, $02, $07, $06, $02, $06, $04, $03, $07, $02, $07, $05
    db $02, $05, $03, $02, $06, $06, $07, $01, $02, $05, $03, $06, $05, $03, $07, $02
    db $02, $05, $03, $02, $07, $01, $07, $06, $01, $02, $03, $06, $05, $04, $07, $03
    db $02, $05, $04, $03, $05, $02, $07, $06
    ds $30, $FE
    db $02, $06, $03, $03, $03, $07, $07, $04, $03, $05, $05, $02, $06, $03, $07, $06
    db $02, $03, $07, $02, $07, $05, $FF, $FF, $01, $07, $03, $04, $05, $01, $07, $03
    db $02, $03, $04, $04, $06, $05, $07, $02, $02, $03, $03, $06, $05, $05, $07, $02
    db $02, $05, $02, $07, $03, $03, $05, $06
    ds $28, $FE
    db $03, $06, $06, $04, $06, $07, $07, $05, $02, $01, $02, $04, $04, $03, $FF, $FF
    db $02, $06, $06, $04, $07, $05, $FF, $FF, $02, $03, $06, $06, $07, $04, $08, $02
    db $02, $07, $03, $02, $04, $05, $06, $03, $04, $02, $05, $06, $07, $03, $07, $05
    db $02, $02, $02, $05, $07, $03, $07, $06
    ds $20, $FE
    db $02, $03, $03, $02, $04, $05, $07, $04, $02, $02, $03, $01, $06, $03, $07, $05
    db $02, $03, $02, $06, $06, $02, $FF, $FF, $02, $01, $02, $05, $07, $02, $FF, $FF
    db $06, $03, $07, $02, $06, $03, $07, $02, $01, $02, $02, $01, $01, $02, $02, $01
    db $03, $06, $06, $01, $06, $07, $07, $02, $02, $01, $04

Data_061_6D40:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $01

Data_061_6D43:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $04, $05, $06, $06, $07, $04
    db $FF, $FF, $02

Data_061_6D56:: ; heuristic: target of a monotone pointer table; C0
    db $03, $03, $06

Data_061_6D59:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $07, $04, $02, $05, $04, $06, $06, $03, $07, $04, $02, $03, $04, $06
    db $07, $02, $08

Data_061_6D6C:: ; heuristic: target of a monotone pointer table; C0
    db $05, $02, $05, $03

Data_061_6D70:: ; heuristic: target of a monotone pointer table; C0
    db $02, $06, $03, $06, $06, $01, $02, $02, $04, $03, $06, $FF, $FF
    ds $10, $FE
    INCBIN "dwm2-cobi-us.gbc", $186D8D, $70
    ds $18, $FE
    db $05, $02, $06, $06, $07, $04, $08, $01, $02, $03, $04, $06, $05, $02, $07, $04
    db $02, $03, $02, $05, $03, $02, $03, $06
    ds $10, $FE
    db $07, $07, $08, $06, $07, $07, $08, $06, $01, $06, $02

Data_061_6E48:: ; heuristic: target of a monotone pointer table; C0
    db $07, $01, $06, $02

Data_061_6E4C:: ; heuristic: target of a monotone pointer table; C0
    db $07, $05, $06, $06, $02, $08, $05, $FF, $FF, $02

; LZSS-compressed asset: 341 bytes expand to 774 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_061_6E56:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $06, $03, $03, $04, $05, $FF, $FF, $FE

Data_061_6E5E:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $FE, $FE, $FE

Data_061_6E62:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $03, $07, $05, $06, $07
    db $05, $FF

Data_061_6E74:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $02, $05

Data_061_6E77:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $186E77, $C6
    ds $13, $FE

Data_061_6F50:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $FE

Data_061_6F52:: ; heuristic: target of a monotone pointer table; C0
    ds $11, $FE

Data_061_6F63:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $FE, $FE

Data_061_6F66:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $186F66, $45

; LZSS-compressed asset: 1130 bytes expand to 1287 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_061_6FAB:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $07, $05, $01, $05, $02, $06, $06, $07, $FF, $FF
    ds $38, $FE
    db $03, $02, $03, $05, $05, $06, $07, $04, $02, $04, $03, $02, $05, $03, $FF, $FF
    db $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $02, $04, $04, $02, $04, $07, $07, $06
    db $02, $02, $02, $06, $04, $05, $06, $04, $02, $04, $02, $06, $04, $05, $FF, $FF
    ds $18, $FE
    db $05, $06, $06, $01, $07, $05, $FF, $FF, $02, $04, $02

Data_061_7040:: ; heuristic: target of a monotone pointer table; C0
    db $06, $02

Data_061_7042:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $06, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $04, $04, $06, $05, $04
    db $04

Data_061_7053:: ; heuristic: target of a monotone pointer table; C0
    db $06, $05, $FE

Data_061_7056:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $05
    db $04

Data_061_7067:: ; heuristic: target of a monotone pointer table; C0
    db $06, $02, $08

Data_061_706A:: ; heuristic: target of a monotone pointer table; C0
    db $03, $FF, $FF, $02, $02, $05, $07, $06, $01, $07, $04, $02, $02, $03, $05, $07

Data_061_707A:: ; heuristic: target of a monotone pointer table; C0
    db $01, $07, $04, $02

Data_061_707E:: ; heuristic: target of a monotone pointer table; C0
    db $03, $04, $04, $05, $02, $FF, $FF
    ds $10, $FE
    db $05, $02, $06, $05, $07, $03, $FF, $FF, $02, $03, $03, $06, $05, $05, $06, $02
    ds $10, $FE
    db $03, $05, $06, $04, $07, $06, $FF, $FF, $01, $06, $03, $03, $05, $05, $06, $02
    ds $10, $FE
    INCBIN "dwm2-cobi-us.gbc", $1870D5, $E0
    ds $18, $FE
    INCBIN "dwm2-cobi-us.gbc", $1871CD, $48
    ds $20, $FE
    db $03, $03, $05, $05, $07, $07, $08, $02, $02, $03, $06, $04, $07, $06, $FF, $FF
    db $03, $05, $06, $02, $06, $06, $07, $03, $02, $04, $04, $05, $05, $02, $06, $07
    db $02, $04, $03, $05, $04, $02, $06, $02, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE
    db $03, $03, $05, $06, $06, $01, $06, $04, $02, $04, $03, $03, $04, $06, $FF, $FF
    ds $10, $FE
    INCBIN "dwm2-cobi-us.gbc", $187285, $50
    ds $10, $FE
    db $04, $03, $04, $07, $05, $05, $07, $02, $02, $04, $03, $02, $03, $06, $FF, $FF
    ds $10, $FE
    INCBIN "dwm2-cobi-us.gbc", $187305, $78
    ds $10, $FE
    INCBIN "dwm2-cobi-us.gbc", $18738D, $50
    ds $18, $FE
    db $05, $05, $06, $01, $07, $04, $08, $02, $02, $04, $03, $02, $04, $05, $06, $03
    db $02, $04, $03, $07, $06, $06, $07, $02, $02, $03, $05, $05, $07, $01, $08, $07
    db $02, $06, $08, $03, $02, $06, $08, $03, $02, $04, $02, $04, $02, $04, $02, $04
    ds $10, $FE
    INCBIN "dwm2-cobi-us.gbc", $187435, $C0
    ds $20, $FE
    INCBIN "dwm2-cobi-us.gbc", $187515, $108
    ds $9E3, $00
