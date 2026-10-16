; ROM bank $84: key-world helpers and debug field code
; The annotated listing of this bank is build/listing/bank84.asm.

SECTION "Bank 84", ROMX
    db $84

; Builds the floor state of every floor entrance of a freshly generated key world. Sets
; wKeyWorldGenRoom to 0, takes the area layout for wKeyWorldAreaCount from KeyWorldAreaLayoutTable
; (skipping its first byte, the block count) and walks wKeyWorldFloorInfo (4 bytes per entrance;
; byte 1 = the entrance kind; the list ends at the first entry whose byte 3 is $FF). For each
; entrance it calls KeyWorldLayout_BuildEntrance with hTemp0 = the kind, DE = the next 16-byte entry
; of wKeyWorldFloorState and [hTemp8/hTemp9] = the next 16-byte block of the layout, so entrance k
; uses block k. Called through farcall by GenerateKeyWorld after
; KeyWorldLayout_NumberCellsAndPlaceEntrances accepted the layout. (C2, E-0384)
KeyWorldLayout_FillEntrances::
    xor a
    ld [wKeyWorldGenRoom], a
    ld a, [wKeyWorldAreaCount]
    add a
    ld hl, KeyWorldAreaLayoutTable
    add_a_to_hl
    ld a, [hli]
    ldh [hTemp8], a
    ld a, [hl]
    ldh [hTemp9], a
    ldh a, [hTemp8]
    add $01
    ldh [hTemp8], a
    ldh a, [hTemp9]
    adc $00
    ldh [hTemp9], a
    ld hl, wKeyWorldFloorInfo + $3
    ld de, wKeyWorldFloorState

.skip:
    ld a, [hl]
    cp $ff
    ret z
    push hl
    push de
    dec hl
    dec hl
    ld a, [hl]
    ldh [hTemp0], a
    call KeyWorldLayout_BuildEntrance
    ldh a, [hTemp8]
    ld l, a
    ldh a, [hTemp9]
    ld h, a
    ld a, $10
    add_a_to_hl
    ld a, l
    ldh [hTemp8], a
    ld a, h
    ldh [hTemp9], a
    pop de
    pop hl
    ld a, $04
    add_a_to_hl
    ld a, $10
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    jr .skip

SECTION "Bank 84 KeyWorldLayout_BuildEntrance", ROMX

; Builds one floor state entry by the entrance kind in hTemp0 (jump table of seven: 0
; KeyWorldLayout_BuildEntrance_Blank, 1 to 5 KeyWorldLayout_BuildEntrance_Kind1 to
; KeyWorldLayout_BuildEntrance_Kind5, 6 KeyWorldLayout_BuildEntrance_FixedState). DE = the 16-byte
; entry in wKeyWorldFloorState, [hTemp8/hTemp9] = the 16-byte block of the area layout for this
; entrance. Called only by KeyWorldLayout_FillEntrances, which is called by GenerateKeyWorld while a
; key world is generated; the name speaks of the debug automap, but nothing in this chain is
; debug-only. (C2, E-0384)
; debug automap: runs the routine for hTemp0 (jump table of seven) (E-0122)
KeyWorldLayout_BuildEntrance::
    ldh a, [hTemp0]
    jumptable
    dw KeyWorldLayout_BuildEntrance_Blank
    dw KeyWorldLayout_BuildEntrance_Kind1
    dw KeyWorldLayout_BuildEntrance_Kind2
    dw KeyWorldLayout_BuildEntrance_Kind3
    dw KeyWorldLayout_BuildEntrance_Kind4
    dw KeyWorldLayout_BuildEntrance_Kind5
    dw KeyWorldLayout_BuildEntrance_FixedState

; Entrance kind 0: returns at once and leaves the floor state entry at DE as it was. (C2, E-0384)
KeyWorldLayout_BuildEntrance_Blank::
    ret

SECTION "Bank 84 KeyWorldLayout_BuildEntrance_FixedState", ROMX

; Entrance kind 6: sets byte 0 of the floor state entry at DE to $54 and leaves the other 15 bytes
; alone. (C2, E-0384)
KeyWorldLayout_BuildEntrance_FixedState::
    ld a, $54
    ld [de], a
    ret

SECTION "Bank 84 KeyWorldLayout_BuildEntrance_Kind1", ROMX

; Entrance kind 1: DE = the 16-byte floor state entry, [hTemp8/hTemp9] = the 16-byte block of the
; area layout for this entrance (KeyWorldAreaLayoutTable). Byte 0 of the entry = the byte of
; KeyWorldLayout_BuildEntrance_Kind1_Data picked by wKeyWorldGoalKind, byte 1 is left alone, bytes
; 2-15 are copied from bytes 1-14 of the layout block. No random numbers are used. (C2, E-0384)
KeyWorldLayout_BuildEntrance_Kind1::
    ld hl, KeyWorldLayout_BuildEntrance_Kind1_Data
    ld a, [wKeyWorldGoalKind]
    add_a_to_hl
    ld a, [hl]
    ld [de], a
    inc de
    inc de
    ldh a, [hTemp8]
    ld l, a
    ldh a, [hTemp9]
    ld h, a
    inc hl
    ld b, $0e

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ret

SECTION "Bank 84 KeyWorldLayout_BuildEntrance_Kind2", ROMX

; Entrance kind 2: DE = the 16-byte floor state entry, [hTemp8/hTemp9] = the layout block of the
; entrance. Byte 0 of the entry = the byte of KeyWorldLayout_BuildEntrance_Kind2_Data picked by
; wKeyWorldGoalKind plus $20, with bit 7 set when bit 1 of the new wKeyRandomHi (one NextRandomSeed
; step) is set; byte 1 is left alone; bytes 2-15 are copied from bytes 1-14 of the layout block.
; (C2, E-0384)
KeyWorldLayout_BuildEntrance_Kind2::
    ld hl, KeyWorldLayout_BuildEntrance_Kind2_Data
    ld a, [wKeyWorldGoalKind]
    add_a_to_hl
    ld a, [hl]
    add $20
    ld [de], a
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    srl a
    and $01
    jr z, .read_temp8
    ld a, [de]
    or $80
    ld [de], a

.read_temp8:
    inc de
    inc de
    ldh a, [hTemp8]
    ld l, a
    ldh a, [hTemp9]
    ld h, a
    inc hl
    ld b, $0e

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ret

SECTION "Bank 84 KeyWorldLayout_BuildEntrance_Kind3", ROMX

; Entrance kind 3: DE = the 16-byte floor state entry, [hTemp8/hTemp9] = the layout block of the
; entrance. Byte 0 of the entry = the byte of KeyWorldLayout_BuildEntrance_Kind2_Data picked by
; wKeyWorldGoalKind plus $40, with bit 7 set when bit 1 of the new wKeyRandomHi (one NextRandomSeed
; step) is set; byte 1 is left alone; bytes 2-15 are copied from bytes 1-14 of the layout block.
; (C2, E-0384)
KeyWorldLayout_BuildEntrance_Kind3::
    ld hl, KeyWorldLayout_BuildEntrance_Kind2_Data
    ld a, [wKeyWorldGoalKind]
    add_a_to_hl
    ld a, [hl]
    add $40
    ld [de], a
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    srl a
    and $01
    jr z, .read_temp8
    ld a, [de]
    or $80
    ld [de], a

.read_temp8:
    inc de
    inc de
    ldh a, [hTemp8]
    ld l, a
    ldh a, [hTemp9]
    ld h, a
    inc hl
    ld b, $0e

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ret

SECTION "Bank 84 KeyWorldLayout_BuildEntrance_Kind4", ROMX

; Entrance kind 4 (rooms): DE = the 16-byte floor state entry, [hTemp8/hTemp9] = the layout block of
; the entrance. Byte 0 of the entry = block byte 1 (the room count, also left in hTemp0), byte 1 =
; wKeyWorldGenRoom (the number of the first room), byte 2 = one of the four bytes of the row of the
; goal kind in KeyWorldLayout_BuildEntrance_Kind4_Data, picked by the low 2 bits of the new
; wKeyRandomHi, bytes 3-15 = block bytes 2-14. When byte 4 of the entry is not $FF a random 0-7
; replaces byte 6, and then, when byte 8 is not $FF, a random 0-7 replaces byte 10. Finally it
; generates the rooms with KeyWorldLayout_BuildEntrance_GenerateRooms (A = 1), which advances
; wKeyWorldGenRoom. (C2, E-0384)
KeyWorldLayout_BuildEntrance_Kind4::
    ldh a, [hTemp8]
    ld l, a
    ldh a, [hTemp9]
    ld h, a
    inc hl
    ld a, [hli]
    ld [de], a
    ldh [hTemp0], a
    push hl
    inc de
    ld a, [wKeyWorldGenRoom]
    ld [de], a
    inc de
    ld a, [wKeyWorldGoalKind]
    add a
    add a
    ld hl, KeyWorldLayout_BuildEntrance_Kind4_Data
    add_a_to_hl
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $03
    add_a_to_hl
    ld a, [hl]
    ld [de], a
    pop hl
    inc de
    push de
    ld b, $0d

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    pop de
    inc de
    ld a, [de]
    cp $ff
    jr z, .call_key_world_layout_build_entrance_generate
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $07
    inc de
    inc de
    ld [de], a
    inc de
    inc de
    ld a, [de]
    cp $ff
    jr z, .call_key_world_layout_build_entrance_generate
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $07
    inc de
    inc de
    ld [de], a

.call_key_world_layout_build_entrance_generate:
    ld a, $01
    call KeyWorldLayout_BuildEntrance_GenerateRooms
    ret

SECTION "Bank 84 KeyWorldLayout_BuildEntrance_Kind5", ROMX

; Entrance kind 5 (rooms): DE = the 16-byte floor state entry, [hTemp8/hTemp9] = the layout block of
; the entrance. Byte 0 of the entry = block byte 1 (the room count, also left in hTemp0), byte 1 =
; wKeyWorldGenRoom (the number of the first room), byte 2 = a byte of
; KeyWorldLayout_BuildEntrance_Kind5_Data picked by the low 3 bits of the new wKeyRandomHi, bytes
; 3-15 = block bytes 2-14. When byte 4 of the entry is not $FF a random 0-7 replaces byte 6, and
; then, when byte 8 is not $FF, a random 0-7 replaces byte 10. Finally it generates the rooms with
; KeyWorldLayout_BuildEntrance_GenerateRooms (A = 0), which advances wKeyWorldGenRoom. (C2, E-0384)
KeyWorldLayout_BuildEntrance_Kind5::
    ldh a, [hTemp8]
    ld l, a
    ldh a, [hTemp9]
    ld h, a
    inc hl
    ld a, [hli]
    ld [de], a
    ldh [hTemp0], a
    push hl
    inc de
    ld a, [wKeyWorldGenRoom]
    ld [de], a
    inc de
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $07
    ld hl, KeyWorldLayout_BuildEntrance_Kind5_Data
    add_a_to_hl
    ld a, [hl]
    ld [de], a
    pop hl
    inc de
    push de
    ld b, $0d

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    pop de
    inc de
    ld a, [de]
    cp $ff
    jr z, .call_key_world_layout_build_entrance_generate
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $07
    inc de
    inc de
    ld [de], a
    inc de
    inc de
    ld a, [de]
    cp $ff
    jr z, .call_key_world_layout_build_entrance_generate
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $07
    inc de
    inc de
    ld [de], a

.call_key_world_layout_build_entrance_generate:
    xor a
    call KeyWorldLayout_BuildEntrance_GenerateRooms
    ret

SECTION "Bank 84 KeyWorldLayout_BuildEntrance_Kind1_Data", ROMX

; Ten bytes indexed by wKeyWorldGoalKind (0-9): $00, $00, $03, $01, $00, $00, $04, $05, $02, $00.
; KeyWorldLayout_BuildEntrance_Kind1 (entrance kind 1) stores the byte as byte 0 of the 16-byte
; wKeyWorldFloorState entry for the floor; CheckWarpsByMapType_FloorEntrances later masks that byte
; with $7F and uses it to index a table of 2-byte pointers in bank $61. (C1, E-0381)
KeyWorldLayout_BuildEntrance_Kind1_Data::
    db $00, $00, $03, $01, $00, $00, $04, $05, $02, $00

; Ten bytes indexed by wKeyWorldGoalKind (0-9): $00, $06, $03, $01, $07, $08, $04, $05, $02, $09.
; KeyWorldLayout_BuildEntrance_Kind2 adds $20 and KeyWorldLayout_BuildEntrance_Kind3 adds $40, sets
; bit 7 half the time at random, and stores the result as byte 0 of the 16-byte wKeyWorldFloorState
; entry; the low seven bits later index a 2-byte pointer table in bank $61 in
; CheckWarpsByMapType_FloorEntrances. (C1, E-0381)
KeyWorldLayout_BuildEntrance_Kind2_Data::
    db $00, $06, $03, $01, $07, $08, $04, $05, $02, $09

; Eight bytes indexed by wKeyRandomHi AND 7: $05, $06, $07, $08, $09, $05, $07, $09.
; KeyWorldLayout_BuildEntrance_Kind5 (entrance kind 5, rooms) stores the picked byte as byte 2 of
; the 16-byte wKeyWorldFloorState entry, which LoadMapType5TilesetAndHeader uses as the index into
; MapType5TilesetTable. (C1, E-0381)
KeyWorldLayout_BuildEntrance_Kind5_Data::
    db $05, $06, $07, $08, $09, $05, $07, $09

; Ten rows of four bytes (40 bytes), one row per wKeyWorldGoalKind (0-9), each pick made with
; wKeyRandomHi AND 3: (0,$0B,0,$0B), (0,2,0,2), (2,3,$0B,2), (2,4,2,4), (1,1,1,1), (1,3,1,3),
; (0,4,0,4), (1,4,1,4), (1,3,$0B,1) and (0,$0B,0,$0B). KeyWorldLayout_BuildEntrance_Kind4 (entrance
; kind 4, rooms) stores the picked byte as byte 2 of the 16-byte wKeyWorldFloorState entry, which
; LoadMapType5TilesetAndHeader uses as the index into MapType5TilesetTable. (C1, E-0381)
KeyWorldLayout_BuildEntrance_Kind4_Data::
    db $00, $0b, $00, $0b, $00, $02, $00, $02, $02, $03, $0b, $02, $02, $04, $02, $04
    db $01, $01, $01, $01, $01, $03, $01, $03, $00, $04, $00, $04, $01, $04, $01, $04
    db $01, $03, $0b, $01, $00, $0b, $00, $0b

; Generates the rooms of one rooms-type entrance (kind 4 or 5) into wKeyWorldRoomTable, two bytes
; per room starting at entry wKeyWorldGenRoom (which is incremented for every room). Input A and
; hTemp0 = the room count. The first room: A = 0 gives the record $A0 + 8 * (0-3) + (0-4) and its
; second byte has the exit it is left by in the high nibble and $F in the low nibble; A non-zero
; gives the record 8 * (0-8) + (0-7) with the two exits from RunDebugAutomapCaseTemp0_PickTwoExits
; (high nibble = the second exit, low nibble = the first). Each of the hTemp0 - 2 further rooms is
; the byte at KeyWorldNextRoomRows + 16 * (the previous leaving exit) + (0-9) plus (0-7), entered by
; the previous leaving exit and left by another one (KeyWorldLayout_BuildEntrance_PickOtherExit). A
; count of 2 would run 256 more rooms (the counter underflows). Random numbers come from
; RandomBelowC and NextRandomSeed. Kind 4 (KeyWorldLayout_BuildEntrance_Kind4) passes A = 1, kind 5
; passes A = 0. (C2, E-0384)
KeyWorldLayout_BuildEntrance_GenerateRooms::
    push af
    ld a, [wKeyWorldGenRoom]
    add a
    ld hl, wKeyWorldRoomTable
    add_a_to_hl
    pop af
    or a
    jr nz, .clear_temp2
    ld a, $a0
    ldh [hTemp2], a
    call NextRandomSeed
    and $03
    add a
    add a
    add a
    ld c, a
    ldh a, [hTemp2]
    add c
    ldh [hTemp2], a
    ld c, $05
    call RandomBelowC
    ld c, a
    ldh a, [hTemp2]
    add c
    ldh [hTemp2], a
    ld [hli], a
    ldh a, [hTemp2]
    ld e, a
    ld d, $00
    sla e
    rl d
    call KeyWorldLayout_BuildEntrance_PickTwoExits
    ldh a, [hTemp4]
    swap a
    or $0f
    ld [hli], a
    ld a, $0f
    ldh [hTemp3], a
    ld a, [wKeyWorldGenRoom]
    inc a
    ld [wKeyWorldGenRoom], a
    jr .check_temp0

.clear_temp2:
    xor a
    ldh [hTemp2], a
    ld c, $09
    call RandomBelowC
    sla a
    sla a
    sla a
    ld c, a
    ldh a, [hTemp2]
    add c
    ldh [hTemp2], a
    ld c, $08
    call RandomBelowC
    ld c, a
    ldh a, [hTemp2]
    add c
    ldh [hTemp2], a
    ld [hli], a
    ldh a, [hTemp2]
    ld e, a
    ld d, $00
    sla e
    rl d
    call KeyWorldLayout_BuildEntrance_PickTwoExits
    ldh a, [hTemp4]
    swap a
    ld c, a
    ldh a, [hTemp3]
    or c
    ld [hli], a
    ld a, [wKeyWorldGenRoom]
    inc a
    ld [wKeyWorldGenRoom], a

.check_temp0:
    ldh a, [hTemp0]
    dec a
    dec a
    ld b, a

.loop:
    push bc
    ldh a, [hTemp4]
    and $0f
    swap a
    ld de, KeyWorldNextRoomRows
    add e
    ld e, a
    jr nc, .call_random_below_c
    inc d

.call_random_below_c:
    ld c, $0a
    call RandomBelowC
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld b, a
    ld c, $08
    call RandomBelowC
    add b
    ld [hli], a
    ld e, a
    ld d, $00
    sla e
    rl d
    ldh a, [hTemp4]
    ldh [hTemp3], a
    call KeyWorldLayout_BuildEntrance_PickOtherExit
    ldh a, [hTemp3]
    ld c, a
    ldh a, [hTemp4]
    swap a
    or c
    ld [hli], a
    ld a, [wKeyWorldGenRoom]
    inc a
    ld [wKeyWorldGenRoom], a
    pop bc
    dec b
    jr nz, .loop
    ret

SECTION "Bank 84 KeyWorldNextRoomRows", ROMX

; E-0193 (C1: KeyWorldLayout_BuildEntrance_GenerateRooms.loop reads the byte at $42C7 + 16 * (hTemp4
; & $0F) + a random 0-9, adds a random 0-7, stores the sum and uses it doubled as an index for
; KeyWorldLayout_BuildEntrance_PickOtherExit; 6 rows end at that routine). E-0364: the sum is the
; next room's record in wKeyWorldRoomTable (bank $72's room table), chosen by the exit it is entered
; from, so these are room bases, not monster bases.
; record: ten base room records, then six zero bytes; one row per exit of the previous room
KeyWorldNextRoomRows::
    db $00, $08, $10, $18, $20, $28, $30, $38, $40, $48, $00, $00, $00, $00, $00, $00 ; id 0
    db $00, $08, $10, $18, $50, $58, $60, $68, $70, $78, $00, $00, $00, $00, $00, $00 ; id 1
    db $00, $20, $28, $30, $50, $58, $60, $80, $88, $90, $00, $00, $00, $00, $00, $00 ; id 2
    db $08, $20, $38, $40, $50, $68, $70, $80, $88, $98, $00, $00, $00, $00, $00, $00 ; id 3
    db $10, $28, $38, $48, $58, $68, $78, $80, $90, $98, $00, $00, $00, $00, $00, $00 ; id 4
    db $18, $30, $40, $48, $60, $70, $78, $88, $90, $98, $00, $00, $00, $00, $00, $00 ; id 5

; Picks the exit by which a room is left. Input DE = 2 * the room record number, hTemp3 = the exit
; the room was entered by. The three exit values of the record are the 3 bytes behind the word at
; $4001 + DE in bank $72. Random draws (NextRandomSeed, low 2 bits, repeated when 0) choose one of
; the three until its value differs from hTemp3, and hTemp4 = that exit. hTemp3 and HL are
; preserved; A, BC and DE are not. (C2, E-0384)
KeyWorldLayout_BuildEntrance_PickOtherExit::
    push hl
    ld a, e
    add LOW(KeyWorldRoomPointers)
    ld e, a
    ld a, d
    adc HIGH(KeyWorldRoomPointers)
    ld d, a
    ld a, BANK(KeyWorldRoomPointers)
    ld b, a
    call ReadByteInBank
    ld l, c
    inc de
    call ReadByteInBank
    ld h, c

.loop:
    call NextRandomSeed
    and $03
    jr z, .loop
    push hl
    dec a
    add_a_to_hl
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    call ReadByteInBank
    pop hl
    ldh a, [hTemp3]
    cp c
    jr z, .loop
    ld a, c
    ldh [hTemp4], a
    pop hl
    ret

SECTION "Bank 84 KeyWorldLayout_BuildEntrance_PickTwoExits", ROMX

; Picks two different exits for a room. Input DE = 2 * the room record number ($A0-$B4 range or
; $00-$47 in practice). The three exit values of the record are the 3 bytes behind the word at $4001
; + DE in bank $72. A random draw (NextRandomSeed, low 2 bits of the result, repeated when 0)
; chooses one of the three into hTemp3; then draws are repeated until another exit with a different
; value is chosen into hTemp4. HL is preserved; A, BC and DE are not. (It would never end if all
; three exits of a record had the same value.) (C2, E-0384)
KeyWorldLayout_BuildEntrance_PickTwoExits::
    push hl
    ld a, e
    add LOW(KeyWorldRoomPointers)
    ld e, a
    ld a, d
    adc HIGH(KeyWorldRoomPointers)
    ld d, a
    ld a, BANK(KeyWorldRoomPointers)
    ld b, a
    call ReadByteInBank
    ld a, c
    ld l, a
    inc de
    call ReadByteInBank
    ld a, c
    ld h, a
    push hl

.loop:
    call NextRandomSeed
    and $03
    jr z, .loop
    dec a
    add_a_to_hl
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    call ReadByteInBank
    ld a, c
    ldh [hTemp3], a
    pop hl

.loop2:
    call NextRandomSeed
    and $03
    jr z, .loop2
    push hl
    dec a
    add_a_to_hl
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    call ReadByteInBank
    pop hl
    ldh a, [hTemp3]
    cp c
    jr z, .loop2
    ld a, c
    ldh [hTemp4], a
    pop hl
    ret

SECTION "Bank 84 RandomBelowC", ROMX

; Draws a random number below C: calls NextRandomSeed (wKeyRandomLo/Hi = 5 * seed + 11) until the
; low 4 bits of the new wKeyRandomHi are less than C, and returns A = that value (0 to C - 1). C
; must be 1 to 16; with C = 0 it would never finish. Because it draws repeatedly the number of seed
; steps used varies. Used by KeyWorldLayout_BuildEntrance_GenerateRooms for room numbers (0-4, 0-7,
; 0-8, 0-9). (C2, E-0384)
; repeats NextRandomSeed until wKeyRandomHi & $0F is below C (C must be 1-16); returns A = that
; value (E-0077)
RandomBelowC::
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $0f
    cp c
    jr nc, RandomBelowC
    ret

SECTION "Bank 84 ApplyMapScreenFlagEvents", ROMX

; Redraws the flag-dependent tiles of the current map screen. It walks the 8-byte entries of
; MapScreenFlagTiles (map id, screen X, screen Y, tile, story flag word, offset word; the list ends
; at $FF) and, for every entry whose map id equals hMapId, whose screen equals hMapScreenX /
; hMapScreenY and whose story flag is set (TestFlagBit), runs ApplyMapScreenFlagEvents_DrawTiles
; with hTemp0 = the entry tile. Called by LoadMapScreen after the screen is built, and by
; RunOneTimeTreasure_RedrawChest and SetFlagRedraw after a flag changes. (C2, E-0384)
; for each 8-byte entry of MapScreenFlagTiles matching hMapId and the screen position, with its
; story flag set, runs ApplyMapScreenFlagEvents_DrawTiles (hTemp0 = its value) (E-0125)
ApplyMapScreenFlagEvents::
    ld hl, MapScreenFlagTiles

.skip:
    push hl
    ld a, [hli]
    cp $ff
    jr nz, .check_map_id
    pop hl
    ret

.check_map_id:
    ld c, a
    ldh a, [hMapId]
    cp c
    jr nz, .restore
    ld a, [hli]
    ld c, a
    ldh a, [hMapScreenX]
    cp c
    jr nz, .restore
    ld a, [hli]
    ld c, a
    ldh a, [hMapScreenY]
    cp c
    jr nz, .restore
    ld a, [hli]
    ldh [hTemp0], a
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    call TestFlagBit
    jr nc, .restore
    pop hl
    push hl
    call ApplyMapScreenFlagEvents_DrawTiles

.restore:
    pop hl
    ld a, $08
    add_a_to_hl
    jr .skip

SECTION "Bank 84 ApplyMapScreenFlagEvents_DrawTiles", ROMX

; Draws one flag-dependent map tile. HL = the 8-byte MapScreenFlagTiles entry, hTemp0 = its tile;
; the entry offset word (entry + 6) is added to wScreenTileBuffer. A normal tile writes hTemp0 and
; hTemp0 + 1 side by side. Tile $FF draws the 2 x 2 block $40, $41 over $50, $51 (the second row 20
; tiles on) and, on a CGB, writes palette 5 into the four attribute bytes in WRAM bank 2 and selects
; bank 0 again. The palette bytes are not checked by a probe. (C2, E-0384)
ApplyMapScreenFlagEvents_DrawTiles::
    ldh a, [hTemp0]
    cp $ff
    jr z, .skip
    ld a, $06
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, e
    add $98
    ld e, a
    ld a, d
    adc $c1
    ld d, a
    ldh a, [hTemp0]
    ld [de], a
    inc a
    inc de
    ld [de], a
    ret

.skip:
    ld a, $06
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    push de
    ld a, e
    add $98
    ld e, a
    ld a, d
    adc $c1
    ld d, a
    ld a, $40
    ld [de], a
    inc a
    inc de
    ld [de], a
    ld a, $13
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, $50
    ld [de], a
    inc a
    inc de
    ld [de], a
    pop de
    ld a, [wIsCGB]
    or a
    ret z
    ld a, $02
    ldh [rSVBK], a
    ld a, e
    add $00
    ld e, a
    ld a, d
    adc $d0
    ld d, a
    ld a, $05
    ld [de], a
    inc de
    ld [de], a
    ld a, $13
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, $05
    ld [de], a
    inc de
    ld [de], a
    ld a, $00
    ldh [rSVBK], a
    ret

SECTION "Bank 84 MapScreenFlagTiles", ROMX

; ApplyMapScreenFlagEvents walks these 8-byte entries until $FF; when hMapId and hMapScreenX/Y match
; and the story flag is set, ApplyMapScreenFlagEvents_DrawTiles writes the tile and tile + 1 at
; wScreenTileBuffer + offset (tile $FF takes another path); 108 entries (E-0151, C1)
; record: map number, screen X, screen Y, tile; story flag number (TestFlagBit); offset into
; wScreenTileBuffer
MapScreenFlagTiles::
    db $19, $00, $02, $3e ; id 0
    dw $011b
    dw $0088
    db $19, $00, $02, $3e ; id 1
    dw $011c
    dw $0100
    db $1b, $00, $02, $1a ; id 2
    dw $013e
    dw $00a6
    db $1b, $00, $02, $1a ; id 3
    dw $013f
    dw $00ac
    db $2b, $01, $02, $3c ; id 4
    dw $004f
    dw $0054
    db $2b, $02, $02, $3c ; id 5
    dw $0050
    dw $0084
    db $2b, $00, $03, $3c ; id 6
    dw $0051
    dw $011e
    db $2b, $00, $03, $3c ; id 7
    dw $0052
    dw $0122
    db $35, $00, $00, $16 ; id 8
    dw $0067
    dw $00d2
    db $35, $01, $00, $16 ; id 9
    dw $0068
    dw $00a8
    db $35, $03, $00, $16 ; id 10
    dw $0069
    dw $0086
    db $35, $03, $00, $16 ; id 11
    dw $006a
    dw $00d6
    db $35, $03, $00, $16 ; id 12
    dw $006b
    dw $0126
    db $35, $02, $03, $16 ; id 13
    dw $006c
    dw $0056
    db $42, $00, $00, $4c ; id 14
    dw $00eb
    dw $0030
    db $42, $00, $00, $4c ; id 15
    dw $00ec
    dw $0032
    db $42, $00, $00, $4c ; id 16
    dw $00ed
    dw $0034
    db $42, $01, $00, $4c ; id 17
    dw $00ee
    dw $00aa
    db $44, $00, $00, $4c ; id 18
    dw $0076
    dw $0034
    db $39, $03, $00, $06 ; id 19
    dw $00e0
    dw $00a4
    db $39, $03, $00, $06 ; id 20
    dw $00e1
    dw $00ae
    db $39, $03, $02, $06 ; id 21
    dw $00e2
    dw $00f6
    db $39, $03, $02, $06 ; id 22
    dw $00e3
    dw $00fa
    db $39, $03, $02, $06 ; id 23
    dw $00e4
    dw $00fe
    db $3a, $00, $00, $06 ; id 24
    dw $00e5
    dw $00d0
    db $3a, $00, $00, $06 ; id 25
    dw $00e6
    dw $00d2
    db $3e, $01, $01, $1c ; id 26
    dw $0079
    dw $0084
    db $55, $00, $00, $2c ; id 27
    dw $0084
    dw $00a6
    db $62, $01, $01, $2c ; id 28
    dw $01e0
    dw $005e
    db $73, $00, $01, $4c ; id 29
    dw $00a1
    dw $0060
    db $76, $00, $00, $4c ; id 30
    dw $00a2
    dw $00ce
    db $76, $00, $00, $4c ; id 31
    dw $00a3
    dw $0100
    db $7a, $00, $00, $2e ; id 32
    dw $00aa
    dw $0030
    db $82, $02, $02, $2c ; id 33
    dw $00ab
    dw $00aa
    db $84, $00, $00, $2c ; id 34
    dw $00ac
    dw $0034
    db $85, $01, $00, $3c ; id 35
    dw $00af
    dw $005a
    db $91, $00, $00, $2c ; id 36
    dw $00b5
    dw $0058
    db $94, $02, $00, $3e ; id 37
    dw $00bc
    dw $00a8
    db $96, $00, $00, $3e ; id 38
    dw $00bd
    dw $00a8
    db $98, $00, $00, $3e ; id 39
    dw $00be
    dw $00f2
    db $9a, $00, $00, $3e ; id 40
    dw $00bf
    dw $0128
    db $63, $01, $00, $2c ; id 41
    dw $01e9
    dw $011a
    db $63, $00, $01, $2c ; id 42
    dw $01ea
    dw $0038
    db $64, $00, $00, $2c ; id 43
    dw $01eb
    dw $00a2
    db $64, $00, $00, $2c ; id 44
    dw $01ec
    dw $00d0
    db $66, $00, $00, $2c ; id 45
    dw $01ed
    dw $00a2
    db $66, $00, $00, $2c ; id 46
    dw $01ee
    dw $00a6
    db $67, $00, $00, $2c ; id 47
    dw $01ef
    dw $011e
    db $67, $00, $00, $2c ; id 48
    dw $01f0
    dw $0124
    db $ad, $00, $00, $2e ; id 49
    dw $0156
    dw $00ac
    db $ae, $00, $02, $2e ; id 50
    dw $0157
    dw $00ac
    db $ae, $02, $03, $2e ; id 51
    dw $0158
    dw $0060
    db $be, $00, $00, $2e ; id 52
    dw $01cb
    dw $0082
    db $c0, $00, $01, $2e ; id 53
    dw $01cc
    dw $011a
    db $c2, $01, $01, $2e ; id 54
    dw $01cd
    dw $0080
    db $c4, $00, $00, $2e ; id 55
    dw $01ce
    dw $00f6
    db $c4, $00, $00, $ff ; id 56
    dw $01cf
    dw $007c
    db $c4, $00, $00, $ff ; id 57
    dw $01d0
    dw $00a8
    db $c4, $00, $00, $ff ; id 58
    dw $01d1
    dw $005a
    db $c4, $00, $00, $ff ; id 59
    dw $01d2
    dw $00d8
    db $ca, $00, $00, $3e ; id 60
    dw $01d5
    dw $0052
    db $ca, $00, $00, $3e ; id 61
    dw $01d6
    dw $002e
    db $ca, $00, $00, $3e ; id 62
    dw $01d8
    dw $0060
    db $cb, $00, $00, $3e ; id 63
    dw $01da
    dw $0052
    db $cb, $00, $00, $3e ; id 64
    dw $01db
    dw $002e
    db $cb, $00, $00, $3e ; id 65
    dw $01dc
    dw $0034
    db $cc, $00, $00, $3e ; id 66
    dw $01de
    dw $002e
    db $cc, $00, $00, $3e ; id 67
    dw $01df
    dw $0034
    db $cc, $00, $00, $3e ; id 68
    dw $0169
    dw $0060
    db $cd, $00, $00, $3e ; id 69
    dw $016b
    dw $0052
    db $cd, $00, $00, $3e ; id 70
    dw $016c
    dw $002e
    db $cd, $00, $00, $3e ; id 71
    dw $016d
    dw $0034
    db $ce, $00, $00, $3e ; id 72
    dw $016f
    dw $00a4
    db $ce, $00, $00, $3e ; id 73
    dw $0170
    dw $007e
    db $ce, $00, $00, $3e ; id 74
    dw $0171
    dw $0084
    db $ce, $00, $00, $3e ; id 75
    dw $0172
    dw $00ae
    db $d3, $00, $00, $3e ; id 76
    dw $0175
    dw $0052
    db $d3, $00, $00, $3e ; id 77
    dw $0176
    dw $002e
    db $d3, $00, $00, $3e ; id 78
    dw $0177
    dw $0034
    db $d4, $00, $00, $3e ; id 79
    dw $0179
    dw $002e
    db $d4, $00, $00, $3e ; id 80
    dw $017a
    dw $0034
    db $d4, $00, $00, $3e ; id 81
    dw $017b
    dw $0060
    db $d5, $00, $00, $3e ; id 82
    dw $017d
    dw $002e
    db $d5, $00, $00, $3e ; id 83
    dw $017e
    dw $0034
    db $d5, $00, $00, $3e ; id 84
    dw $017f
    dw $0060
    db $d6, $00, $00, $3e ; id 85
    dw $00d6
    dw $002e
    db $d6, $00, $00, $3e ; id 86
    dw $00d7
    dw $0034
    db $d6, $00, $00, $3e ; id 87
    dw $00d8
    dw $0060
    db $d7, $00, $00, $3e ; id 88
    dw $00da
    dw $00a4
    db $d7, $00, $00, $3e ; id 89
    dw $00db
    dw $007e
    db $d7, $00, $00, $3e ; id 90
    dw $00dc
    dw $0084
    db $d7, $00, $00, $3e ; id 91
    dw $00dd
    dw $00ae
    db $dc, $00, $00, $3e ; id 92
    dw $00f5
    dw $002e
    db $dc, $00, $00, $3e ; id 93
    dw $00f6
    dw $0034
    db $dc, $00, $00, $3e ; id 94
    dw $00f7
    dw $0060
    db $dd, $00, $00, $3e ; id 95
    dw $00f9
    dw $0052
    db $dd, $00, $00, $3e ; id 96
    dw $00fa
    dw $002e
    db $dd, $00, $00, $3e ; id 97
    dw $00fb
    dw $0034
    db $de, $00, $00, $3e ; id 98
    dw $00fd
    dw $002e
    db $de, $00, $00, $3e ; id 99
    dw $00fe
    dw $0034
    db $de, $00, $00, $3e ; id 100
    dw $00ff
    dw $0060
    db $df, $00, $00, $3e ; id 101
    dw $01f3
    dw $002e
    db $df, $00, $00, $3e ; id 102
    dw $01f4
    dw $0034
    db $df, $00, $00, $3e ; id 103
    dw $01f5
    dw $0060
    db $e0, $00, $00, $3e ; id 104
    dw $01f7
    dw $00a4
    db $e0, $00, $00, $3e ; id 105
    dw $01f8
    dw $007e
    db $e0, $00, $00, $3e ; id 106
    dw $01f9
    dw $0084
    db $e0, $00, $00, $3e ; id 107
    dw $01fa
    dw $00ae
    db $ff ; end

; Decides whether the Log Twig has an effect here and records the spot. Result in hTempA: 1 = a new
; goal was recorded, 0 = nothing changed (ItemUsable_LogTwig then refuses the item). Steps: returns
; with 0 while hPlayerStateFlags bit 3 is set; in a key world (wMapType bit 7) it continues in
; ItemUsable_LogTwig_KeyWorld; on maps below $20, on the trigger cell (IsPlayerOnTriggerCell_Bank84)
; and on a spot of LogTwigSpotList (map, screen, and one or two player positions) it returns with 0.
; Otherwise it looks the map up in ItemUsable_LogTwig_Check_Data (record number E). When
; wKeyWorldActive is set it first saves wKeyWorldGoal, wKeyWorldGoalCell and wKeyWorldKey in
; wLogTwigKeyWorldGoal, wLogTwigKeyWorldGoalCell and wLogTwigKeyWorldKey, and it keeps
; wKeyWorldActive in wSpriteSnapshot (for RunFieldReturnPhase_AfterLogTwig); it returns with 0 when
; the old goal is the same spot under the key E, or when the player position is $44 on screen $44.
; In every other case it sets wKeyWorldActive = 1, wKeyWorldGoal = player position (x tile high
; nibble, y tile low), wKeyWorldGoalCell = the screen (hMapScreenX high nibble, hMapScreenY low),
; wKeyWorldKey = E + 1 (12 for a map missing from the data) and hTempA = 1. Quirks: the old key is
; compared with E, not E + 1, so a goal this routine stored never counts as the same spot; and at
; the end the screen byte of the record is not compared (the position byte $44 is compared with the
; screen instead). (C2, E-0384)
ItemUsable_LogTwig_Check::
    xor a
    ldh [hTempA], a
    ldh a, [hPlayerStateFlags]
    bit 3, a
    ret nz
    ld a, [wMapType]
    bit 7, a
    jp nz, ItemUsable_LogTwig_KeyWorld
    ldh a, [hMapId]
    cp $20
    ret c
    push af
    call IsPlayerOnTriggerCell_Bank84
    or a
    jr z, .restore
    pop af
    ret

.restore:
    pop af
    ld e, a
    ld hl, LogTwigSpotList
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or c
    ld c, a
    ldh a, [hPlayerX]
    and $f0
    ld b, a
    ldh a, [hPlayerY]
    and $f0
    swap a
    or b
    ld b, a

.skip:
    push hl
    ld a, [hli]
    cp $ff
    jr z, .read_map_id
    cp e
    jr nz, .restore2
    ld a, [hli]
    cp c
    jr nz, .restore2
    ld a, [hli]
    cp b
    jr z, .done
    ld a, [hl]
    cp $ff
    jr z, .restore2
    cp b
    jr z, .done

.restore2:
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr .skip

.done:
    pop hl
    ret

.read_map_id:
    pop hl
    ldh a, [hMapId]
    ld d, a
    ld e, $00
    ld hl, ItemUsable_LogTwig_Check_Data

.skip2:
    ld a, [hl]
    cp $ff
    jr z, .set_key_world_active_to_01
    cp d
    jr z, .read_key_world_active
    inc e
    inc hl
    inc hl
    inc hl
    jr .skip2

.read_key_world_active:
    ld a, [wKeyWorldActive]
    ld [wSpriteSnapshot], a
    or a
    jr z, .next
    ld a, [wKeyWorldGoal]
    ld [wLogTwigKeyWorldGoal], a
    ld a, [wKeyWorldGoalCell]
    ld [wLogTwigKeyWorldGoalCell], a
    ld a, [wKeyWorldKey]
    ld [wLogTwigKeyWorldKey], a
    ld a, [wKeyWorldKey]
    bit 7, a
    jr nz, .next
    cp e
    jr nz, .next
    ld a, [wKeyWorldGoal]
    cp b
    jr nz, .set_key_world_active_to_01
    ld a, [wKeyWorldGoalCell]
    cp c
    jr nz, .set_key_world_active_to_01
    ret

.next:
    inc hl
    ld a, [hl]
    cp b
    jr nz, .set_key_world_active_to_01
    inc hl
    cp c
    jr nz, .set_key_world_active_to_01
    ret

.set_key_world_active_to_01:
    ld a, $01
    ld [wKeyWorldActive], a
    ld a, b
    ld [wKeyWorldGoal], a
    ld a, c
    ld [wKeyWorldGoalCell], a
    ld a, e
    inc a
    ld [wKeyWorldKey], a
    ld a, $01
    ldh [hTempA], a
    ret

SECTION "Bank 84 ItemUsable_LogTwig_Check_Data", ROMX

; Eleven 3-byte records ended by $FF (34 bytes): map id, position in the screen ($44 in every
; record, x nibble then y nibble), and screen (x nibble then y nibble). The maps are $20, $30, $48,
; $70, $A0, $A8, $B0, $B8, $C8, $D1 and $DA, with screens $00, $76, $B4, $B4, $10, $00, $01, $44,
; $01, $00 and $00. ItemUsable_LogTwig_Check finds the record for hMapId (same 34 bytes as
; RunFieldReturnPhase_AfterLogTwig_Data) and, when the goal is not yet recorded, stores the position
; and screen in wKeyWorldGoal and wKeyWorldGoalCell and the record number plus 1 in wKeyWorldKey.
; (C1, E-0381)
ItemUsable_LogTwig_Check_Data::
    db $20, $44, $00, $30, $44, $76, $48, $44, $b4, $70, $44, $b4, $a0, $44, $10, $a8
    db $44, $00, $b0, $44, $01, $b8, $44, $44, $c8, $44, $01, $d1, $44, $00, $da, $44
    db $00, $ff

; The Log Twig in a key world; A = wMapType on entry. Returns at once unless A is $80, on the
; trigger cell (IsPlayerOnTriggerCell_Bank84), when hPlayerX and hPlayerY are both $40 on the screen
; of an entry of the wKeyWorldObjects list (the screen bytes sit 3 and 2 bytes before the tested
; byte), and when hPlayerY is $40 on the screen of a wKeyWorldFloorInfo entry with hPlayerX = $40,
; or hPlayerX = $50 unless that floor is kind 4 or 5. Otherwise it keeps wKeyWorldActive in
; wSpriteSnapshot; when wKeyWorldActive is set it saves the old goal (wLogTwigKeyWorldGoal,
; wLogTwigKeyWorldGoalCell, wLogTwigKeyWorldKey) and, when wKeyWorldKey has bit 7 set for this slot
; (wKeyWorldSlot) and the goal is the current position and screen, returns with nothing new; when no
; goal is active it also returns with nothing new if the current spot is the one in
; wKeyWorldGoalScreen, wKeyWorldGoalPos and wKeyWorldGoalPos2. In every other case it records
; wKeyWorldActive = 1, wKeyWorldGoal = position (x tile high nibble, y tile low nibble),
; wKeyWorldGoalCell = the screen, wKeyWorldKey = wKeyWorldSlot | $80 and hTempA = 1. hTempA is not
; cleared here: ItemUsable_LogTwig_Check clears it before the jump. (C2, E-0384)
ItemUsable_LogTwig_KeyWorld::
    cp $80
    ret nz
    call IsPlayerOnTriggerCell_Bank84
    or a
    ret nz
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or c
    ld c, a
    ldh a, [hPlayerX]
    cp $40
    jr nz, .check_player_y2
    ldh a, [hPlayerY]
    cp $40
    jr nz, .check_player_y2
    ld hl, wKeyWorldObjects

.skip:
    push hl
    ld a, [hl]
    cp $ff
    jr z, .check_player_y
    dec hl
    dec hl
    dec hl
    ld a, [hli]
    cp c
    jp z, .done
    ld a, [hl]
    cp c
    jp z, .done
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr .skip

.check_player_y:
    pop hl

.check_player_y2:
    ldh a, [hPlayerY]
    cp $40
    jr nz, .read_key_world_active2
    ld hl, wKeyWorldFloorInfo + $3

.skip2:
    push hl
    ld a, [hl]
    cp $ff
    jr z, .read_key_world_active
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    cp c
    jr nz, .restore
    ldh a, [hPlayerX]
    cp $40
    jp z, .done
    inc hl
    ld a, [hl]
    cp $04
    jr z, .restore
    cp $05
    jr z, .restore
    ldh a, [hPlayerX]
    cp $50
    jp z, .done

.restore:
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr .skip2

.read_key_world_active:
    pop hl

.read_key_world_active2:
    ld a, [wKeyWorldActive]
    ld [wSpriteSnapshot], a
    or a
    jr z, .check_key_world_goal_screen
    ld a, [wKeyWorldGoal]
    ld [wLogTwigKeyWorldGoal], a
    ld a, [wKeyWorldGoalCell]
    ld [wLogTwigKeyWorldGoalCell], a
    ld a, [wKeyWorldKey]
    ld [wLogTwigKeyWorldKey], a
    ld a, [wKeyWorldKey]
    bit 7, a
    jr z, .check_key_world_goal_screen
    and $7f
    ld b, a
    ld a, [wKeyWorldSlot]
    cp b
    jr nz, .check_key_world_goal_screen
    ldh a, [hPlayerX]
    and $f0
    ld b, a
    ldh a, [hPlayerY]
    and $f0
    swap a
    or b
    ld b, a
    ld a, [wKeyWorldGoal]
    cp b
    jr nz, .check_player_x
    ld a, [wKeyWorldGoalCell]
    cp c
    jr nz, .check_player_x
    ret

.check_key_world_goal_screen:
    ld a, [wKeyWorldGoalScreen]
    cp c
    jr nz, .check_player_x
    ld a, [wKeyWorldGoalPos]
    ld b, a
    ldh a, [hPlayerX]
    cp b
    jr nz, .check_player_x
    ld a, [wKeyWorldGoalPos2]
    ld b, a
    ldh a, [hPlayerY]
    cp b
    jr nz, .check_player_x
    ret

.check_player_x:
    ldh a, [hPlayerX]
    and $f0
    ld b, a
    ldh a, [hPlayerY]
    and $f0
    swap a
    or b
    ld b, a
    ld a, $01
    ld [wKeyWorldActive], a
    ld a, b
    ld [wKeyWorldGoal], a
    ld a, c
    ld [wKeyWorldGoalCell], a
    ld a, [wKeyWorldSlot]
    or $80
    ld [wKeyWorldKey], a
    ld a, $01
    ldh [hTempA], a
    ret

.done:
    pop hl
    ret

SECTION "Bank 84 LogTwigSpotList", ROMX

; ItemUsable_LogTwig_Check, on maps from $20, walks 4-byte records from $49A1 until $FF and returns
; at the first whose map id equals hMapId, whose screen byte equals hMapScreenX/Y and whose third or
; fourth byte equals the player's tile position; on no match it goes on to
; ItemUsable_LogTwig_Check_Data; 50 records then $FF (E-0193, C1)
; record: map id; screen XY; two tile positions ($FF = none)
LogTwigSpotList::
    db $20, $21, $44, $54 ; id 0
    db $20, $25, $44, $54 ; id 1
    db $20, $55, $44, $54 ; id 2
    db $30, $56, $44, $54 ; id 3
    db $30, $42, $44, $54 ; id 4
    db $30, $24, $44, $54 ; id 5
    db $30, $03, $44, $ff ; id 6
    db $30, $62, $44, $ff ; id 7
    db $30, $53, $44, $ff ; id 8
    db $48, $82, $44, $54 ; id 9
    db $48, $73, $44, $ff ; id 10
    db $48, $74, $44, $ff ; id 11
    db $48, $75, $44, $54 ; id 12
    db $48, $46, $44, $64 ; id 13
    db $48, $48, $44, $54 ; id 14
    db $48, $29, $44, $54 ; id 15
    db $48, $5a, $43, $53 ; id 16
    db $48, $99, $44, $54 ; id 17
    db $48, $a5, $44, $ff ; id 18
    db $48, $87, $44, $ff ; id 19
    db $48, $50, $44, $54 ; id 20
    db $48, $4a, $51, $61 ; id 21
    db $48, $79, $55, $65 ; id 22
    db $70, $b1, $44, $ff ; id 23
    db $70, $a4, $44, $ff ; id 24
    db $70, $94, $44, $ff ; id 25
    db $70, $56, $44, $54 ; id 26
    db $70, $04, $44, $ff ; id 27
    db $70, $36, $44, $ff ; id 28
    db $70, $37, $44, $ff ; id 29
    db $70, $59, $44, $54 ; id 30
    db $70, $89, $44, $ff ; id 31
    db $70, $99, $44, $ff ; id 32
    db $70, $5b, $44, $ff ; id 33
    db $70, $1b, $44, $ff ; id 34
    db $70, $ba, $44, $54 ; id 35
    db $70, $52, $44, $ff ; id 36
    db $70, $41, $44, $54 ; id 37
    db $a0, $12, $44, $ff ; id 38
    db $a8, $11, $44, $ff ; id 39
    db $a8, $24, $44, $54 ; id 40
    db $a8, $43, $44, $ff ; id 41
    db $a8, $51, $44, $ff ; id 42
    db $b0, $10, $44, $ff ; id 43
    db $b8, $43, $44, $54 ; id 44
    db $b8, $11, $35, $ff ; id 45
    db $b8, $40, $44, $ff ; id 46
    db $c8, $00, $44, $ff ; id 47
    db $d1, $01, $44, $ff ; id 48
    db $da, $10, $44, $ff ; id 49
    db $ff ; end

; A = 1 when the player stands on the trigger cell, else A = 0. There is no trigger when
; wTriggerKind is $FF. The player cell is the high nibble of hPlayerX as the high nibble and the
; high nibble of hPlayerY as the low nibble; it is compared with wTriggerCell. C is clobbered. The
; bank-$84 copy of the helper used by the Log Twig checks. (C2, E-0384)
IsPlayerOnTriggerCell_Bank84::
    ld a, [wTriggerKind]
    cp $ff
    jr z, .return_0
    ldh a, [hPlayerX]
    and $f0
    ld c, a
    ldh a, [hPlayerY]
    swap a
    and $0f
    or c
    ld c, a
    ld a, [wTriggerCell]
    cp c
    jr nz, .return_0
    ld a, $01
    ret

.return_0:
    xor a
    ret

SECTION "Bank 84 RunFieldReturnPhase_AfterLogTwig", ROMX

; Back in the field after the LogTwig, on a region map: finds the map's region; with a recorded key
; world for this region whose goal cell is this screen, marks the goal there
; (RunFieldReturnPhase_AfterLogTwig_DrawMarker), otherwise marks the table's spot when the screen
; matches; then the key-world goal (RunFieldReturnPhase_AfterLogTwig_DrawGoal). (C1, E-0357)
RunFieldReturnPhase_AfterLogTwig::
    xor a
    ldh [hSpriteWindowClipMode], a
    ld a, [wMapType]
    bit 7, a
    jr nz, RunFieldReturnPhase_AfterLogTwig_InKeyWorld
    ldh a, [hMapId]
    ld c, a
    ld hl, RunFieldReturnPhase_AfterLogTwig_Data
    ld b, $00

.skip:
    ld a, [hl]
    cp c
    jr z, .set_temp0
    inc b
    inc hl
    inc hl
    inc hl
    jr .skip

.set_temp0:
    ld a, b
    ldh [hTemp0], a
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or c
    ld c, a
    ld a, [wSpriteSnapshot]
    or a
    jr z, .next
    ld a, [wLogTwigKeyWorldKey]
    dec a
    cp b
    jr nz, .next
    ld a, [wLogTwigKeyWorldGoalCell]
    cp c
    jp nz, RunFieldReturnPhase_AfterLogTwig_DrawGoal
    ld a, [wLogTwigKeyWorldGoal]
    ld c, a
    call RunFieldReturnPhase_AfterLogTwig_DrawMarker
    jr RunFieldReturnPhase_AfterLogTwig_DrawGoal

.next:
    inc hl
    inc hl
    ld a, [hl]
    cp c
    jr nz, RunFieldReturnPhase_AfterLogTwig_DrawGoal
    dec hl
    ld a, [hl]
    ld c, a
    call RunFieldReturnPhase_AfterLogTwig_DrawMarker
    jr RunFieldReturnPhase_AfterLogTwig_DrawGoal

SECTION "Bank 84 RunFieldReturnPhase_AfterLogTwig_Data", ROMX

; The same eleven 3-byte records and $FF end as ItemUsable_LogTwig_Check_Data (34 bytes): map id,
; position in the screen ($44 in every record) and screen. RunFieldReturnPhase_AfterLogTwig searches
; it for hMapId (it has no check for the $FF end), keeps the record number in hTemp0 and b, and when
; the packed current screen equals byte 2 draws the 2 x 2 marker at byte 1 with
; RunFieldReturnPhase_AfterLogTwig_DrawMarker. (C1, E-0381)
RunFieldReturnPhase_AfterLogTwig_Data::
    db $20, $44, $00, $30, $44, $76, $48, $44, $b4, $70, $44, $b4, $a0, $44, $10, $a8
    db $44, $00, $b0, $44, $01, $b8, $44, $44, $c8, $44, $01, $d1, $44, $00, $da, $44
    db $00, $ff

; The same in a key world: the recorded goal when the key's slot matches and the screen is its cell,
; otherwise wKeyWorldGoalPos on wKeyWorldGoalScreen. (C1, E-0357)
RunFieldReturnPhase_AfterLogTwig_InKeyWorld::
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or c
    ld c, a
    ld a, [wSpriteSnapshot]
    or a
    jr z, .check_key_world_goal_screen
    ld a, [wLogTwigKeyWorldKey]
    bit 7, a
    jr z, .check_key_world_goal_screen
    and $7f
    ld b, a
    ld a, [wKeyWorldSlot]
    cp b
    jr nz, .check_key_world_goal_screen
    ld a, [wLogTwigKeyWorldGoalCell]
    cp c
    jr nz, RunFieldReturnPhase_AfterLogTwig_DrawGoal
    ld a, [wLogTwigKeyWorldGoal]
    ld c, a
    call RunFieldReturnPhase_AfterLogTwig_DrawMarker
    jr RunFieldReturnPhase_AfterLogTwig_DrawGoal

.check_key_world_goal_screen:
    ld a, [wKeyWorldGoalScreen]
    cp c
    jr nz, RunFieldReturnPhase_AfterLogTwig_DrawGoal
    ld a, [wKeyWorldGoalPos]
    and $f0
    ld c, a
    ld a, [wKeyWorldGoalPos2]
    and $f0
    swap a
    or c
    ld c, a
    call RunFieldReturnPhase_AfterLogTwig_DrawMarker
    jr RunFieldReturnPhase_AfterLogTwig_DrawGoal

SECTION "Bank 84 RunFieldReturnPhase_AfterLogTwig_DrawGoal", ROMX

; Draws the key-world goal tiles ($46/$47 over $56/$57) at wKeyWorldGoal in wScreenTileBuffer with
; the CGB palette (5 in key worlds, 3 for regions 4 and $0A, 5 for 5-7, otherwise 1), then copies
; them to the BG map at the scroll. (C1, E-0357)
RunFieldReturnPhase_AfterLogTwig_DrawGoal::
    ld a, [wKeyWorldGoal]
    and $0f
    ld l, a
    ld e, a
    ld h, $00
    ld d, $00
    sla l
    rl h
    sla l
    rl h
    add hl, de
    sla l
    rl h
    sla l
    rl h
    sla l
    rl h
    ld a, [wKeyWorldGoal]
    and $f0
    swap a
    add a
    add_a_to_hl
    push hl
    ld a, l
    add $98
    ld l, a
    ld a, h
    adc $c1
    ld h, a
    ld [hl], $46
    inc hl
    ld [hl], $47
    ld a, $13
    add_a_to_hl
    ld [hl], $56
    inc hl
    ld [hl], $57
    pop hl
    ld a, [wIsCGB]
    or a
    jr z, .check_scroll_y
    ld c, $05
    ld a, [wMapType]
    bit 7, a
    jr nz, .skip
    ld c, $03
    ldh a, [hTemp0]
    cp $04
    jr z, .skip
    cp $0a
    jr z, .skip
    ld c, $05
    cp $05
    jr z, .skip
    cp $06
    jr z, .skip
    cp $07
    jr z, .skip
    ld c, $01

.skip:
    ld a, $02
    ldh [rSVBK], a
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $d0
    ld h, a
    ld a, c
    ld [hli], a
    ld [hl], a
    ld a, $13
    add_a_to_hl
    ld a, c
    ld [hli], a
    ld [hl], a
    ld a, $00
    ldh [rSVBK], a

.check_scroll_y:
    ldh a, [hScrollY]
    and $f8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add $00
    ld e, a
    ld a, d
    adc $98
    ld d, a
    ld a, d
    and $9b
    ld d, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add e
    ld e, a
    jr nc, .call_draw_full_screen_buffer_to_bg_map
    inc d

.call_draw_full_screen_buffer_to_bg_map:
    ld l, e
    ld h, d
    call DrawFullScreenBufferToBGMap
    ret

SECTION "Bank 84 RunFieldReturnPhase_AfterLogTwig_DrawMarker", ROMX

; Draws a 2 x 2 tile marker for a screen cell. Input C = the cell (x in the high nibble, y in the
; low nibble; the tile column is 2 * x, the tile row 2 * y; wScreenTileBuffer is 20 tiles wide):
; tiles $40, $41 on the top row and $50, $51 on the row below. On a CGB (wIsCGB non-zero) it also
; writes the palette number into the matching attribute bytes in WRAM bank 2 ($D000 + the same
; offset), then selects bank 0 again: palette 1 in a key world (wMapType bit 7), otherwise the byte
; of RunFieldReturnPhase_AfterLogTwig_DrawMarker_Data picked by B (the region record number). B and
; C are inputs; A, DE and HL are clobbered. The palette bytes in bank 2 are not checked by a probe.
; (C2, E-0384)
RunFieldReturnPhase_AfterLogTwig_DrawMarker::
    ld a, c
    and $0f
    ld l, a
    ld e, a
    ld h, $00
    ld d, $00
    sla l
    rl h
    sla l
    rl h
    add hl, de
    sla l
    rl h
    sla l
    rl h
    sla l
    rl h
    ld a, c
    and $f0
    swap a
    add a
    add_a_to_hl
    push hl
    ld a, l
    add $98
    ld l, a
    ld a, h
    adc $c1
    ld h, a
    ld [hl], $40
    inc hl
    ld [hl], $41
    ld a, $13
    add_a_to_hl
    ld [hl], $50
    inc hl
    ld [hl], $51
    pop hl
    ld a, [wIsCGB]
    or a
    ret z
    ld c, $01
    ld a, [wMapType]
    bit 7, a
    jr nz, .skip2
    ld a, b
    ld de, RunFieldReturnPhase_AfterLogTwig_DrawMarker_Data
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld c, a

.skip2:
    ld a, $02
    ldh [rSVBK], a
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $d0
    ld h, a
    ld a, c
    ld [hli], a
    ld [hl], a
    ld a, $13
    add_a_to_hl
    ld a, c
    ld [hli], a
    ld [hl], a
    ld a, $00
    ldh [rSVBK], a
    ret

SECTION "Bank 84 RunFieldReturnPhase_AfterLogTwig_DrawMarker_Data", ROMX

; Five CGB palette numbers, $01, $01, $03, $02, $02, indexed by b, the record number that
; RunFieldReturnPhase_AfterLogTwig found for the map in RunFieldReturnPhase_AfterLogTwig_Data.
; RunFieldReturnPhase_AfterLogTwig_DrawMarker writes the number as the background attribute of the
; four marker tiles on a CGB when the map is not a key world (a key world uses palette 1). (C1,
; E-0381)
RunFieldReturnPhase_AfterLogTwig_DrawMarker_Data::
    db $01, $01, $03, $02, $02

; Called when key entry hTemp0 is deleted (DeleteKeyEntryTemp0): clears wKeyWorldActive if the
; recorded Log Twig goal belongs to that entry. Does nothing when wKeyWorldActive is 0. The entry is
; the 4-byte record at wKeyList + 4 * hTemp0. If bit 7 of its byte 3 is set, the goal belongs to it
; when wKeyWorldKey has bit 7 clear and wKeyWorldKey - 1 equals entry byte 0. Otherwise (byte 3 bit
; 7 clear) the entry must not be $FF in byte 0 and must have bit 7 of byte 0 set, and the goal
; belongs to it when wKeyWorldKey has bit 7 set and wKeyWorldKey & $7F equals byte 0 & $3F. A, C, HL
; are clobbered. (C2, E-0384)
; when wKeyWorldActive is set and key entry hTemp0 matches wKeyWorldKey, clears wKeyWorldActive
; (E-0127)
ClearKeyWorldActiveForMatchingKeyEntry::
    ld a, [wKeyWorldActive]
    or a
    ret z
    ldh a, [hTemp0]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add $0a
    ld l, a
    ld a, h
    adc $c7
    ld h, a
    ld a, [hl]
    dec hl
    dec hl
    dec hl
    bit 7, a
    jr z, .skip
    ld a, [hl]
    ld c, a
    ld a, [wKeyWorldKey]
    bit 7, a
    ret nz
    dec a
    cp c
    ret nz
    ld a, $00
    ld [wKeyWorldActive], a
    ret

.skip:
    ld a, [hl]
    cp $ff
    ret z
    bit 7, a
    ret z
    and $3f
    ld c, a
    ld a, [wKeyWorldKey]
    bit 7, a
    ret z
    and $7f
    cp c
    ret nz
    ld a, $00
    ld [wKeyWorldActive], a
    ret

SECTION "Bank 84 KeyWorldAreaLayoutTable", ROMX

; KeyWorldLayout_FillEntrances reads the word at $4CCB + 2 * wKeyWorldAreaCount, skips the layout's
; first byte, and passes one 16-byte block per wKeyWorldFloorInfo entry (until $FF) to
; KeyWorldLayout_BuildEntrance with DE stepping through wKeyWorldFloorState by 16 (E-0193, C1)
; record: area layout
KeyWorldAreaLayoutTable::
    dw KeyWorldAreaLayout00 ; id 0
    dw KeyWorldAreaLayout01 ; id 1
    dw KeyWorldAreaLayout02 ; id 2
    dw KeyWorldAreaLayout03 ; id 3
    dw KeyWorldAreaLayout04 ; id 4
    dw KeyWorldAreaLayout05 ; id 5
    dw KeyWorldAreaLayout06 ; id 6
    dw KeyWorldAreaLayout07 ; id 7
    dw KeyWorldAreaLayout08 ; id 8
    dw KeyWorldAreaLayout09 ; id 9
    dw KeyWorldAreaLayout10 ; id 10
    dw KeyWorldAreaLayout11 ; id 11
    dw KeyWorldAreaLayout12 ; id 12
    dw KeyWorldAreaLayout13 ; id 13
    dw KeyWorldAreaLayout14 ; id 14
    dw KeyWorldAreaLayout15 ; id 15
    dw KeyWorldAreaLayout16 ; id 16
    dw KeyWorldAreaLayout17 ; id 17
    dw KeyWorldAreaLayout18 ; id 18
    dw KeyWorldAreaLayout19 ; id 19
    dw KeyWorldAreaLayout20 ; id 20
    dw KeyWorldAreaLayout21 ; id 21
    dw KeyWorldAreaLayout22 ; id 22
    dw KeyWorldAreaLayout23 ; id 23
    dw KeyWorldAreaLayout24 ; id 24
    dw KeyWorldAreaLayout25 ; id 25
    dw KeyWorldAreaLayout26 ; id 26
    dw KeyWorldAreaLayout27 ; id 27
    dw KeyWorldAreaLayout28 ; id 28
    dw KeyWorldAreaLayout29 ; id 29
    dw KeyWorldAreaLayout30 ; id 30
    dw KeyWorldAreaLayout31 ; id 31
    dw KeyWorldAreaLayout32 ; id 32
    dw KeyWorldAreaLayout33 ; id 33
    dw KeyWorldAreaLayout34 ; id 34
    dw KeyWorldAreaLayout35 ; id 35
    dw KeyWorldAreaLayout36 ; id 36
    dw KeyWorldAreaLayout37 ; id 37
    dw KeyWorldAreaLayout38 ; id 38
    dw KeyWorldAreaLayout39 ; id 39
    dw KeyWorldAreaLayout40 ; id 40
    dw KeyWorldAreaLayout41 ; id 41
    dw KeyWorldAreaLayout42 ; id 42
    dw KeyWorldAreaLayout43 ; id 43
    dw KeyWorldAreaLayout44 ; id 44
    dw KeyWorldAreaLayout45 ; id 45
    dw KeyWorldAreaLayout46 ; id 46
    dw KeyWorldAreaLayout47 ; id 47

; entry 0 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
; record: block count 3, then 3 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout00::
    db $03 ; entry 0: block count
    db $03, $0a, $9e, $e0, $c2, $00, $00, $00, $00, $0a, $9e, $e0, $c2, $00, $00, $00 ; block 0
    db $05, $03, $03, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $ff ; end

; entry 1 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout01::
    db $03 ; entry 0: block count
    db $03, $a6, $09, $6a, $c8, $00, $00, $00, $00, $a6, $09, $6a, $c8, $00, $00, $00 ; block 0
    db $04, $03, $03, $01, $2c, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $ff ; end

; entry 2 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout02::
    db $03 ; entry 0: block count
    db $03, $b1, $8e, $08, $c6, $00, $00, $00, $00, $00, $8e, $08, $c6, $00, $00, $00 ; block 0
    db $04, $03, $03, $01, $2c, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $ff ; end

; entry 3 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout03::
    db $03 ; entry 0: block count
    db $02, $69, $e5, $0a, $00, $bb, $92, $c9, $7b, $00, $00, $00, $00, $00, $00, $00 ; block 0
    db $05, $03, $03, $00, $2c, $00, $00, $01, $2a, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $ff ; end

; entry 4 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
; record: block count 4, then 4 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout04::
    db $04 ; entry 0: block count
    db $03, $af, $09, $72, $c0, $00, $00, $00, $00, $af, $09, $72, $c0, $00, $00, $00 ; block 0
    db $05, $04, $03, $01, $03, $00, $00, $02, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $02, $6c, $e5, $b4, $de, $bf, $97, $d4, $66, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $ff ; end

; entry 5 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout05::
    db $04 ; entry 0: block count
    db $03, $a2, $93, $08, $c3, $00, $00, $00, $00, $a2, $93, $08, $c3, $00, $00, $00 ; block 0
    db $04, $04, $03, $01, $2c, $00, $00, $02, $03, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $02, $73, $89, $b1, $d9, $ba, $84, $d5, $69, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $ff ; end

; entry 6 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout06::
    db $04 ; entry 0: block count
    db $03, $0a, $85, $6d, $ca, $00, $00, $00, $00, $0a, $85, $6d, $ca, $00, $00, $00 ; block 0
    db $04, $04, $03, $01, $03, $00, $00, $02, $12, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $02, $7c, $97, $a3, $c4, $b9, $9e, $da, $77, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $ff ; end

; entry 7 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout07::
    db $04 ; entry 0: block count
    db $03, $a1, $09, $66, $cb, $00, $00, $00, $00, $a1, $09, $66, $cb, $00, $00, $00 ; block 0
    db $05, $04, $03, $01, $0d, $00, $00, $02, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $02, $76, $94, $ad, $cf, $b6, $96, $d7, $68, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $ff ; end

; entry 8 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
; record: block count 4, then 4 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout08::
    db $04 ; entry 0: block count
    db $03, $b7, $90, $08, $db, $00, $00, $00, $00, $b7, $90, $08, $db, $00, $00, $00 ; block 0
    db $04, $04, $03, $01, $03, $00, $00, $02, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $05, $04, $03, $01, $0c, $00, $00, $02, $11, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $ff ; end

; entry 9 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout09::
    db $04 ; entry 0: block count
    db $03, $0a, $95, $6b, $ce, $00, $00, $00, $00, $0a, $95, $6b, $ce, $00, $00, $00 ; block 0
    db $05, $03, $03, $01, $2c, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $04, $04, $03, $01, $0c, $00, $00, $02, $12, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $ff ; end

; entry 10 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout10::
    db $04 ; entry 0: block count
    db $01, $10, $31, $49, $08, $00, $00, $00, $00, $10, $31, $49, $08, $00, $00, $00 ; block 0
    db $04, $03, $03, $01, $0e, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $05, $04, $03, $01, $0f, $00, $00, $02, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $ff ; end

; entry 11 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout11::
    db $04 ; entry 0: block count
    db $01, $16, $37, $08, $e1, $00, $00, $00, $00, $16, $37, $08, $e1, $00, $00, $00 ; block 0
    db $05, $04, $03, $01, $03, $00, $00, $02, $10, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $04, $03, $03, $01, $11, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $ff ; end

; entry 12 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
; record: block count 4, then 4 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout12::
    db $04 ; entry 0: block count
    db $02, $7d, $09, $a5, $d1, $b3, $99, $d8, $62, $00, $00, $00, $00, $00, $00, $00 ; block 0
    db $04, $04, $03, $01, $05, $00, $00, $02, $0c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $03, $bc, $9d, $78, $c7, $00, $00, $00, $00, $bc, $9d, $78, $c7, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $ff ; end

; entry 13 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout13::
    db $04 ; entry 0: block count
    db $01, $2c, $08, $34, $3c, $00, $00, $00, $00, $2c, $08, $34, $3c, $00, $00, $00 ; block 0
    db $05, $03, $03, $01, $2c, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $03, $b0, $e6, $ea, $cc, $00, $00, $00, $00, $b0, $e6, $ea, $cc, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $ff ; end

; entry 14 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout14::
    db $04 ; entry 0: block count
    db $01, $14, $42, $51, $08, $00, $00, $00, $00, $14, $42, $51, $08, $00, $00, $00 ; block 0
    db $04, $04, $03, $01, $2c, $00, $00, $02, $0c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $03, $bd, $8d, $6e, $cd, $00, $00, $00, $00, $bd, $8d, $6e, $cd, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $ff ; end

; entry 15 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout15::
    db $04 ; entry 0: block count
    db $02, $08, $8a, $e4, $d2, $ac, $98, $d6, $65, $00, $00, $00, $00, $00, $00, $00 ; block 0
    db $04, $04, $03, $01, $0c, $00, $00, $02, $0d, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $01, $1c, $32, $3a, $3b, $00, $00, $00, $00, $1c, $32, $3a, $3b, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $ff ; end

; entry 16 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
; record: block count 5, then 5 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout16::
    db $05 ; entry 0: block count
    db $02, $7e, $9b, $0a, $d0, $a9, $8f, $d3, $6f, $00, $00, $00, $00, $00, $00, $00 ; block 0
    db $04, $03, $03, $01, $05, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $03, $b2, $88, $71, $df, $00, $00, $00, $00, $b2, $88, $71, $df, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $05, $03, $02, $2c, $00, $00, $03, $12, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $ff ; end

; entry 17 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout17::
    db $05 ; entry 0: block count
    db $02, $71, $09, $aa, $d1, $ae, $91, $dc, $62, $00, $00, $00, $00, $00, $00, $00 ; block 0
    db $04, $05, $03, $01, $05, $00, $00, $03, $0c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $03, $b5, $9c, $7a, $dd, $00, $00, $00, $00, $b5, $9c, $7a, $dd, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $05, $05, $03, $02, $10, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $ff ; end

; entry 18 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout18::
    db $05 ; entry 0: block count
    db $03, $be, $9a, $08, $d9, $00, $00, $00, $00, $be, $9a, $64, $d9, $00, $00, $00 ; block 0
    db $05, $03, $03, $01, $11, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $02, $6a, $95, $b9, $d3, $b3, $85, $c8, $01, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $05, $05, $03, $02, $05, $00, $00, $03, $0f, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $ff ; end

; entry 19 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout19::
    db $05 ; entry 0: block count
    db $03, $0a, $e6, $eb, $cc, $00, $00, $00, $00, $0a, $e6, $eb, $cc, $00, $00, $00 ; block 0
    db $04, $05, $03, $01, $11, $00, $00, $03, $03, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $02, $69, $84, $ab, $d8, $a4, $8c, $dd, $6d, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $05, $03, $02, $2c, $00, $00, $03, $0c, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $ff ; end

; entry 20 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
; record: block count 5, then 5 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout20::
    db $05 ; entry 0: block count
    db $03, $a1, $09, $67, $cb, $00, $00, $00, $00, $a1, $09, $67, $cb, $00, $00, $00 ; block 0
    db $04, $03, $03, $01, $03, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $01, $13, $35, $e1, $47, $00, $00, $00, $00, $13, $35, $e1, $47, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $05, $03, $01, $2c, $00, $00, $03, $0e, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $ff ; end

; entry 21 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout21::
    db $05 ; entry 0: block count
    db $03, $a1, $89, $08, $cb, $00, $00, $00, $00, $a1, $89, $08, $cb, $00, $00, $00 ; block 0
    db $05, $05, $03, $01, $05, $00, $00, $03, $03, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $01, $28, $38, $56, $e3, $00, $00, $00, $00, $28, $38, $56, $e3, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $05, $05, $03, $02, $2c, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $ff ; end

; entry 22 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout22::
    db $05 ; entry 0: block count
    db $03, $0a, $8b, $ea, $cd, $00, $00, $00, $00, $0a, $8b, $ea, $cd, $00, $00, $00 ; block 0
    db $02, $75, $e5, $ad, $db, $ba, $8c, $de, $6c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $04, $04, $03, $01, $0f, $00, $00, $02, $0d, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $05, $03, $02, $12, $00, $00, $03, $10, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $ff ; end

; entry 23 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout23::
    db $05 ; entry 0: block count
    db $03, $a0, $09, $7e, $ca, $00, $00, $00, $00, $a0, $09, $7e, $ca, $00, $00, $00 ; block 0
    db $02, $63, $94, $bb, $da, $b3, $9b, $df, $72, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $05, $03, $03, $01, $0f, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $05, $06, $03, $02, $2c, $00, $00, $04, $05, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $ff ; end

; entry 24 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
; record: block count 5, then 5 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout24::
    db $05 ; entry 0: block count
    db $03, $a5, $83, $08, $d7, $00, $00, $00, $00, $a5, $83, $08, $d7, $00, $00, $00 ; block 0
    db $02, $ef, $93, $b4, $c3, $be, $99, $dc, $74, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $01, $15, $5f, $50, $45, $00, $00, $00, $00, $15, $5f, $50, $45, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $07, $03, $02, $0c, $00, $00, $04, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $ff ; end

; entry 25 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout25::
    db $05 ; entry 0: block count
    db $03, $0a, $8a, $6b, $c2, $00, $00, $00, $00, $0a, $8a, $6b, $c2, $00, $00, $00 ; block 0
    db $02, $71, $91, $ac, $d2, $b2, $98, $d5, $79, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $01, $23, $30, $39, $4a, $00, $00, $00, $00, $23, $30, $39, $4a, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $05, $06, $03, $02, $11, $00, $00, $04, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $ff ; end

; entry 26 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout26::
    db $05 ; entry 0: block count
    db $01, $1d, $3f, $e2, $08, $00, $00, $00, $00, $1d, $3f, $e2, $08, $00, $00, $00 ; block 0
    db $04, $05, $03, $01, $0e, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $05, $03, $03, $01, $0d, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $08, $03, $02, $2c, $00, $00, $05, $05, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $ff ; end

; entry 27 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout27::
    db $05 ; entry 0: block count
    db $01, $19, $58, $08, $4b, $00, $00, $00, $00, $19, $58, $08, $4b, $00, $00, $00 ; block 0
    db $05, $03, $03, $01, $10, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $04, $04, $03, $01, $0d, $00, $00, $02, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $05, $08, $03, $02, $03, $00, $00, $05, $0f, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $ff ; end

; entry 28 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
; record: block count 6, then 6 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout28::
    db $06 ; entry 0: block count
    db $01, $2d, $08, $e3, $3e, $00, $00, $00, $00, $2d, $08, $e3, $3e, $00, $00, $00 ; block 0
    db $05, $03, $03, $01, $0e, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $03, $b0, $96, $7b, $cf, $00, $00, $00, $00, $b0, $96, $7b, $cf, $00, $00, $00 ; block 2
    db $04, $04, $03, $01, $0d, $00, $00, $02, $0c, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $05, $08, $03, $02, $11, $00, $00, $05, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $ff ; end

; entry 29 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout29::
    db $06 ; entry 0: block count
    db $01, $1b, $59, $4c, $08, $00, $00, $00, $00, $1b, $59, $4c, $08, $00, $00, $00 ; block 0
    db $05, $03, $03, $01, $0e, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $03, $af, $e7, $78, $ce, $00, $00, $00, $00, $af, $e7, $78, $ce, $00, $00, $00 ; block 2
    db $04, $04, $03, $01, $0d, $00, $00, $02, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $04, $05, $03, $02, $2c, $00, $00, $03, $11, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $ff ; end

; entry 30 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout30::
    db $06 ; entry 0: block count
    db $01, $20, $5d, $08, $5a, $00, $00, $00, $00, $20, $5d, $08, $5a, $00, $00, $00 ; block 0
    db $04, $04, $03, $01, $12, $00, $00, $02, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $05, $03, $03, $01, $0c, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 2
    db $03, $b1, $9e, $73, $ee, $00, $00, $00, $00, $b1, $9e, $73, $ee, $00, $00, $00 ; block 3
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $04, $06, $03, $02, $05, $00, $00, $04, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $ff ; end

; entry 31 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout31::
    db $06 ; entry 0: block count
    db $01, $22, $08, $53, $54, $00, $00, $00, $00, $22, $08, $53, $54, $00, $00, $00 ; block 0
    db $05, $03, $03, $01, $2c, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $05, $03, $03, $01, $05, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 2
    db $03, $b8, $e7, $68, $d0, $00, $00, $00, $00, $b8, $e7, $68, $d0, $00, $00, $00 ; block 3
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $04, $09, $03, $02, $2c, $00, $00, $05, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $ff ; end

; entry 32 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
; record: block count 7, then 7 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout32::
    db $07 ; entry 0: block count
    db $03, $0a, $9d, $7f, $cf, $00, $00, $00, $00, $0a, $9d, $7f, $cf, $00, $00, $00 ; block 0
    db $04, $04, $03, $01, $0c, $00, $00, $02, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $04, $03, $03, $01, $11, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 2
    db $02, $75, $82, $e4, $c1, $03, $88, $c4, $6e, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $04, $03, $01, $05, $00, $00, $02, $12, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $05, $07, $03, $01, $0f, $00, $00, $04, $10, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $ff ; end

; entry 33 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout33::
    db $07 ; entry 0: block count
    db $03, $bc, $09, $7d, $c9, $00, $00, $00, $00, $bc, $09, $7d, $c9, $00, $00, $00 ; block 0
    db $05, $03, $03, $01, $0c, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $05, $03, $03, $01, $11, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 2
    db $02, $70, $e6, $a9, $c0, $b7, $8f, $c6, $77, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $05, $03, $03, $01, $05, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 4
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $04, $06, $03, $02, $2c, $00, $00, $03, $0f, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $ff ; end

; entry 34 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout34::
    db $07 ; entry 0: block count
    db $03, $b5, $95, $08, $c1, $00, $00, $00, $00, $b5, $95, $08, $c1, $00, $00, $00 ; block 0
    db $04, $03, $03, $01, $0d, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $04, $04, $03, $01, $0e, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 2
    db $04, $05, $03, $01, $0f, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $02, $76, $87, $a7, $c7, $ae, $8e, $d3, $7c, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $04, $04, $03, $01, $11, $00, $00, $02, $0c, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $ff ; end

; entry 35 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout35::
    db $07 ; entry 0: block count
    db $03, $0a, $e8, $7e, $f1, $00, $00, $00, $00, $0a, $e8, $7e, $f1, $00, $00, $00 ; block 0
    db $05, $04, $03, $01, $0d, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $05, $03, $03, $01, $2c, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 2
    db $05, $04, $03, $01, $0f, $00, $00, $02, $12, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $02, $65, $8c, $a8, $c5, $b9, $92, $d2, $73, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $05, $07, $03, $02, $2c, $00, $00, $04, $0c, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $ff ; end

; entry 36 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
; record: block count 7, then 7 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout36::
    db $07 ; entry 0: block count
    db $03, $b7, $09, $7b, $f0, $00, $00, $00, $00, $b7, $09, $7b, $f0, $00, $00, $00 ; block 0
    db $04, $05, $03, $01, $11, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $02, $6e, $e8, $aa, $ee, $b3, $93, $db, $79, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $04, $04, $03, $01, $12, $00, $00, $02, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $01, $2b, $4e, $55, $35, $00, $00, $00, $00, $2b, $4e, $55, $35, $00, $00, $00 ; block 4
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $05, $06, $03, $02, $2c, $00, $00, $04, $0d, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $ff ; end

; entry 37 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout37::
    db $07 ; entry 0: block count
    db $03, $b5, $99, $08, $da, $00, $00, $00, $00, $b5, $99, $08, $da, $00, $00, $00 ; block 0
    db $05, $03, $03, $01, $11, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $02, $64, $82, $a4, $c3, $ab, $8a, $d0, $6c, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $05, $04, $03, $01, $12, $00, $00, $02, $0f, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $01, $2f, $33, $4a, $04, $00, $00, $00, $00, $2f, $33, $4a, $04, $00, $00, $00 ; block 4
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $04, $07, $03, $02, $2c, $00, $00, $05, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $ff ; end

; entry 38 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout38::
    db $07 ; entry 0: block count
    db $03, $0a, $e7, $ec, $cf, $00, $00, $00, $00, $0a, $e7, $ec, $cf, $00, $00, $00 ; block 0
    db $04, $03, $03, $01, $2c, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $04, $05, $03, $01, $0e, $00, $00, $03, $11, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $04, $06, $03, $01, $03, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $07, $03, $01, $0c, $00, $00, $03, $05, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $05, $04, $03, $01, $12, $00, $00, $02, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $ff ; end

; entry 39 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout39::
    db $07 ; entry 0: block count
    db $03, $ad, $09, $71, $f0, $00, $00, $00, $00, $ad, $09, $71, $f0, $00, $00, $00 ; block 0
    db $05, $04, $03, $01, $0d, $00, $00, $02, $03, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $05, $04, $03, $01, $0e, $00, $00, $02, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $05, $03, $03, $01, $2c, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 3
    db $05, $03, $03, $01, $0c, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 4
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $04, $07, $03, $02, $2c, $00, $00, $05, $11, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $ff ; end

; entry 40 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
; record: block count 8, then 8 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout40::
    db $08 ; entry 0: block count
    db $03, $b8, $91, $08, $f1, $00, $00, $00, $00, $b8, $91, $08, $f1, $00, $00, $00 ; block 0
    db $04, $06, $03, $01, $0d, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $04, $05, $03, $01, $0e, $00, $00, $03, $03, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $02, $62, $e9, $a5, $c2, $b1, $8b, $d1, $6b, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $03, $03, $01, $12, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 4
    db $01, $2e, $3b, $44, $3d, $00, $00, $00, $00, $2e, $3b, $44, $3d, $00, $00, $00 ; block 5
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $04, $07, $03, $02, $05, $00, $00, $05, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 7
    db $ff ; end

; entry 41 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout41::
    db $08 ; entry 0: block count
    db $03, $0a, $98, $74, $d8, $00, $00, $00, $00, $0a, $98, $74, $d8, $00, $00, $00 ; block 0
    db $05, $07, $03, $01, $0d, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $05, $03, $03, $01, $0c, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 2
    db $02, $69, $96, $a2, $ca, $ac, $8f, $d4, $6d, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $05, $03, $03, $01, $11, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 4
    db $01, $2a, $43, $49, $57, $00, $00, $00, $00, $2a, $43, $49, $57, $00, $00, $00 ; block 5
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $05, $06, $03, $02, $2c, $00, $00, $04, $05, $00, $00, $00, $00, $00, $00, $00 ; block 7
    db $ff ; end

; entry 42 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout42::
    db $08 ; entry 0: block count
    db $01, $2d, $5a, $5e, $08, $00, $00, $00, $00, $2d, $5a, $5e, $08, $00, $00, $00 ; block 0
    db $04, $03, $03, $01, $11, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $03, $a7, $e9, $ed, $c4, $00, $00, $00, $00, $a7, $e9, $ed, $c4, $00, $00, $00 ; block 2
    db $01, $24, $45, $47, $53, $00, $00, $00, $00, $24, $45, $47, $53, $00, $00, $00 ; block 3
    db $04, $04, $03, $01, $0d, $00, $00, $02, $10, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $05, $03, $03, $01, $03, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 5
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $04, $07, $03, $02, $2c, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 7
    db $ff ; end

; entry 43 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout43::
    db $08 ; entry 0: block count
    db $01, $29, $3a, $08, $42, $00, $00, $00, $00, $29, $3a, $08, $42, $00, $00, $00 ; block 0
    db $05, $06, $03, $01, $11, $00, $00, $03, $12, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $03, $b4, $8d, $75, $cd, $00, $00, $00, $00, $b4, $8d, $75, $cd, $00, $00, $00 ; block 2
    db $01, $26, $4c, $34, $58, $00, $00, $00, $00, $26, $4c, $34, $58, $00, $00, $00 ; block 3
    db $05, $06, $03, $01, $0e, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $04, $03, $03, $01, $03, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 5
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $05, $07, $03, $04, $2c, $00, $00, $05, $0f, $00, $00, $00, $00, $00, $00, $00 ; block 7
    db $ff ; end

; entry 44 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
; record: block count 8, then 8 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout44::
    db $08 ; entry 0: block count
    db $01, $2c, $08, $52, $4d, $00, $00, $00, $00, $2c, $08, $52, $4d, $00, $00, $00 ; block 0
    db $04, $09, $03, $01, $2c, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $03, $af, $9d, $7a, $c7, $00, $00, $00, $00, $af, $9d, $7a, $c7, $00, $00, $00 ; block 2
    db $04, $09, $03, $01, $2c, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $01, $2b, $40, $3c, $54, $00, $00, $00, $00, $2b, $40, $3c, $54, $00, $00, $00 ; block 4
    db $04, $09, $03, $01, $2c, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $04, $09, $03, $02, $2c, $00, $00, $05, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 7
    db $ff ; end

; entry 45 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout45::
    db $08 ; entry 0: block count
    db $01, $17, $39, $5f, $08, $00, $00, $00, $00, $17, $39, $5f, $08, $00, $00, $00 ; block 0
    db $05, $09, $03, $01, $0d, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $02, $63, $88, $a3, $c8, $ba, $9f, $dc, $6f, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $05, $09, $03, $01, $2c, $00, $00, $03, $10, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $01, $18, $50, $3e, $5d, $00, $00, $00, $00, $18, $50, $3e, $5d, $00, $00, $00 ; block 4
    db $05, $09, $03, $01, $12, $00, $00, $03, $05, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $05, $09, $03, $02, $11, $00, $00, $05, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 7
    db $ff ; end

; entry 46 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout46::
    db $08 ; entry 0: block count
    db $01, $1f, $31, $08, $56, $00, $00, $00, $00, $1f, $31, $08, $56, $00, $00, $00 ; block 0
    db $04, $04, $03, $01, $2c, $00, $00, $02, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $04, $04, $03, $01, $0f, $00, $00, $02, $12, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $04, $04, $03, $01, $05, $00, $00, $02, $11, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $04, $03, $01, $03, $00, $00, $02, $10, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $04, $03, $03, $01, $0c, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 5
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $05, $09, $03, $03, $0e, $00, $00, $05, $0d, $00, $00, $00, $00, $00, $00, $00 ; block 7
    db $ff ; end

; entry 47 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout47::
    db $08 ; entry 0: block count
    db $01, $1e, $08, $4e, $55, $00, $00, $00, $00, $1e, $08, $4e, $55, $00, $00, $00 ; block 0
    db $05, $04, $03, $01, $0e, $00, $00, $03, $03, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $05, $06, $03, $01, $2c, $00, $00, $03, $10, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $05, $04, $03, $01, $0d, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $05, $06, $03, $01, $11, $00, $00, $03, $12, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $05, $05, $03, $01, $0c, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $04, $09, $03, $02, $2c, $00, $00, $05, $11, $00, $00, $00, $00, $00, $00, $00 ; block 7
    db $ff ; end
    ds $21f5, $00
