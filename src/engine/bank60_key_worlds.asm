; ROM bank $60: key worlds: random rooms and the debug automap
; The annotated listing of this bank is build/listing/bank60.asm.

SECTION "Bank 60", ROMX
    db $60

; Far-called by WarpEffect_Warp when byte 0 of the current key's wKeyList entry (wKeyList + 4 *
; wCurrentKeyIndex) has bit 7 clear: FindSRAMSlotMarkerIndex picks the first SRAM slot whose marker
; is not $50 + its index (returns at once when none); the slot goes to wKeyWorldSlot and, with bit 7
; set, into that entry byte 0; the key's wKeySeeds word goes to wKeyRandomLo/Hi, and the code falls
; through into GenerateKeyWorld. (C2, E-0371; probed E-0384)
WarpEffect_Warp_StartNewKeyWorld::
    ld a, [wCurrentKeyIndex]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add $07
    ld l, a
    ld a, h
    adc $c7
    ld h, a
    push hl
    call FindSRAMSlotMarkerIndex
    pop hl
    ldh a, [hTemp0]
    cp $ff
    ret z
    ld [wKeyWorldSlot], a
    or $80
    ld [hl], a
    ld a, [wCurrentKeyIndex]
    add a
    ld hl, wKeySeeds
    add_a_to_hl
    ld a, [hli]
    ld [wKeyRandomLo], a
    ld a, [hl]
    ld [wKeyRandomHi], a

; Generates the key world from the key's seed: the size and areas (repeated until
; KeyWorldLayout_NumberCellsAndPlaceEntrances accepts the layout), the rooms, the floor menus, the
; objects, the monsters and the goal; then marks the key's list entry generated (bit 7 set, bit 6
; clear). WarpEffect_Warp_StartNewKeyWorld falls through into it after loading the seed, and
; DebugAutomap_Update_EnterKeyWorld (bank $01) far-calls it. (C2, E-0369; probed E-0384)
GenerateKeyWorld::
    call KeyWorldLayout_Start
    call GenerateKeyWorld_FillChunkSlots
    call GenerateKeyWorld_ShuffleAreaNumbers
    call GenerateKeyWorld_MergeAreaInfo
    call KeyWorldLayout_PlaceAreaExits
    call GenerateKeyWorld_EmptyStep
    call KeyWorldLayout_NumberCellsAndPlaceEntrances
    or a
    jr nz, GenerateKeyWorld
    farcall KeyWorldLayout_FillEntrances
    call KeyWorldLayout_SetEntranceFlags
    call GenerateKeyWorld_PlaceObjects
    call GenerateKeyWorld_RollMonsters
    call KeyWorldLayout_PlaceGoal
    ld a, [wCurrentKeyIndex]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add $07
    ld l, a
    ld a, h
    adc $c7
    ld h, a
    ld a, [hl]
    and $bf
    or $80
    ld [hl], a
    ret

SECTION "Bank 60 GenerateKeyWorld_RollMonsters", ROMX

; The key world's monsters: the level base for the party strength, the key's parameters, 32 normal
; and 8 boss monsters with their levels, the monster ids and the encounter table. (C2, E-0357;
; probed E-0384)
GenerateKeyWorld_RollMonsters::
    call LoadKeyWorldLevelBaseTripleForPartyStrength
    call LoadKeyWorldParamsForCurrentKeyIndex
    call GenerateKeyWorld_RollMonsters_Normal
    call GenerateKeyWorld_RollMonsters_NormalLevels
    call GenerateKeyWorld_RollMonsters_Boss
    call GenerateKeyWorld_RollMonsters_BossLevels
    call GenerateKeyWorld_RollEncounterFoes
    call GenerateKeyWorld_RollEncounterTable
    ret

SECTION "Bank 60 GenerateKeyWorld_RollMonsters_Normal", ROMX

; Fills the 32 two-byte entries of wKeyWorldMonsters with monster ids (the level byte is added
; later). For each entry it takes the next family from wKeyWorldMonsterBands (the list ends with $FF
; and then starts again), draws a band from the 16-byte row of KeyWorldBossBandPickRows picked by
; min(wKeyWorldBandAdjust, 16), finds the list for that family and band in KeyWorldBandSpeciesTable
; (a count byte, then that many two-byte monster words) and copies one word of it, chosen by drawing
; wKeyRandomHi & 7 until the draw is below the count. An empty list fills no entry and the next
; family is tried. Every draw advances wKeyRandomLo/Hi (NextRandomSeed); hTemp0/hTemp1 are used as
; the write pointer. (C2, E-0384)
; fills 32 two-byte entries from wKeyWorldMonsters with random monster ids from the
; wKeyWorldMonsterBands band lists (rows from KeyWorldBossBandPickRows by wKeyWorldBandAdjust)
; (E-0130)
GenerateKeyWorld_RollMonsters_Normal::
    ld b, $20
    ld de, wKeyWorldMonsters
    ld a, e
    ldh [hTemp0], a
    ld a, d
    ldh [hTemp1], a

.loop:
    ld hl, wKeyWorldMonsterBands

.loop2:
    ld a, [hli]
    cp $ff
    jr z, .loop
    push hl
    push af
    ld a, [wKeyWorldBandAdjust]
    cp $10
    jr c, .skip
    ld a, $10

.skip:
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
    add LOW(KeyWorldBossBandPickRows)
    ld e, a
    ld a, d
    adc HIGH(KeyWorldBossBandPickRows)
    ld d, a
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $0f
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    add a
    ld c, a
    pop af
    swap a
    ld de, KeyWorldBandSpeciesTable
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, c
    add e
    ld e, a
    jr nc, .skip4
    inc d

.skip4:
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [hli]
    or a
    jr nz, .skip5
    pop hl
    jr .loop2

.skip5:
    dec a
    jr z, .read_temp0
    inc a
    ld c, a

.loop3:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $07
    cp c
    jr nc, .loop3

.read_temp0:
    add a
    add_a_to_hl
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    inc de
    ld a, e
    ldh [hTemp0], a
    ld a, d
    ldh [hTemp1], a
    pop hl
    dec b
    jp nz, .loop2
    ret

SECTION "Bank 60 KeyWorldBossBandPickRows", ROMX

; GenerateKeyWorld_RollMonsters_Boss reads the byte at $4123 + 8 * wKeyWorldBandAdjust + (random &
; 7), doubles it and reads the band-list pointer at $6D6D + $90 + that offset; it retries when the
; list is empty; 34 rows end at GenerateKeyWorld_RollMonsters_NormalLevels ($4233); higher rows pick
; from more bands (E-0192, C1)
; record: eight picks for one wKeyWorldBandAdjust value; a random 0-7 chooses one
KeyWorldBossBandPickRows::
    db $00, $00, $00, $00, $00, $00, $00, $00 ; id 0
    db $00, $00, $00, $00, $00, $00, $00, $00 ; id 1
    db $00, $00, $00, $00, $00, $00, $00, $00 ; id 2
    db $00, $00, $00, $00, $00, $00, $00, $00 ; id 3
    db $00, $01, $00, $01, $00, $01, $00, $01 ; id 4
    db $01, $00, $01, $00, $01, $00, $01, $00 ; id 5
    db $00, $01, $00, $01, $00, $01, $00, $01 ; id 6
    db $01, $00, $01, $00, $01, $00, $01, $00 ; id 7
    db $00, $01, $02, $00, $01, $02, $00, $01 ; id 8
    db $02, $00, $01, $02, $00, $01, $02, $00 ; id 9
    db $01, $02, $00, $01, $02, $00, $01, $02 ; id 10
    db $00, $01, $02, $00, $01, $02, $00, $01 ; id 11
    db $00, $01, $02, $03, $00, $01, $02, $03 ; id 12
    db $03, $02, $01, $00, $03, $02, $01, $00 ; id 13
    db $00, $01, $02, $03, $00, $01, $02, $03 ; id 14
    db $03, $02, $01, $00, $03, $02, $01, $00 ; id 15
    db $00, $01, $02, $03, $04, $00, $01, $02 ; id 16
    db $03, $04, $00, $01, $02, $03, $04, $00 ; id 17
    db $01, $02, $03, $04, $00, $01, $02, $03 ; id 18
    db $04, $00, $01, $02, $03, $04, $00, $01 ; id 19
    db $00, $01, $02, $03, $04, $05, $00, $01 ; id 20
    db $02, $03, $04, $05, $00, $01, $02, $03 ; id 21
    db $04, $05, $00, $01, $02, $03, $04, $05 ; id 22
    db $00, $01, $02, $03, $04, $05, $00, $01 ; id 23
    db $00, $01, $02, $03, $04, $05, $06, $00 ; id 24
    db $01, $02, $03, $04, $05, $06, $00, $01 ; id 25
    db $02, $03, $04, $05, $06, $00, $01, $02 ; id 26
    db $00, $01, $02, $03, $04, $05, $06, $00 ; id 27
    db $01, $02, $03, $04, $05, $06, $01, $02 ; id 28
    db $03, $04, $05, $06, $01, $02, $03, $04 ; id 29
    db $05, $06, $01, $02, $03, $04, $05, $06 ; id 30
    db $01, $02, $03, $04, $05, $06, $01, $02 ; id 31
    db $00, $01, $02, $03, $04, $05, $06, $07 ; id 32
    db $07, $06, $05, $04, $03, $02, $01, $00 ; id 33

; Adds a level to the second byte of each of the 32 entries of wKeyWorldMonsters. Entry n (0-31)
; gets 2 x level ORed in, level = min(wKeyWorldLevelBase + ((wPartyStrength + 10) x n / 150) / 2,
; 99), so the levels rise along the table. The id byte of each entry is not changed. (C2, E-0384)
; for 32 entries from wKeyWorldMonsters + $1 ORs 2 * min(wKeyWorldLevelBase + (32 - n) *
; (wPartyStrength + 10) / 150 / 2, 99) into every other byte (E-0125) (E-0340: the address in its
; name read as its RAM name; was GenerateKeyWorld_RollMonsters_NormalLevels)
GenerateKeyWorld_RollMonsters_NormalLevels::
    ld b, $20
    ld de, wKeyWorldMonsters + $1
    ld a, [wKeyWorldLevelBase]
    ld c, a

.loop:
    push bc
    push bc
    push de
    ld a, $20
    sub b
    ld c, a
    ld a, [wPartyStrength]
    add $0a
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
    or a
    jr nz, .skip
    ld a, l
    cp $64
    jr c, .skip2

.skip:
    ld l, $63

.skip2:
    ld c, l
    sla c
    ld a, [de]
    or c
    ld [de], a
    inc de
    inc de
    pop bc
    dec b
    jr nz, .loop
    ret

SECTION "Bank 60 GenerateKeyWorld_RollMonsters_Boss", ROMX

; Fills the 8 two-byte entries at wKeyWorldMonsters + $40 (the boss monsters) with monster ids.
; Every entry uses family 9 of KeyWorldBandSpeciesTable and a band read from
; KeyWorldBossBandPickRows[8 x wKeyWorldBandAdjust + (wKeyRandomHi & 7)]; it copies one word of that
; band list, drawn with wKeyRandomHi & 7 until it is below the count, and an empty list is drawn
; again. Advances wKeyRandomLo/Hi; hTemp0/hTemp1 are the write pointer. (C2, E-0384)
; fills 8 two-byte entries from wKeyWorldMonsters + $40 with random monster ids from the band lists
; (KeyWorldBossBandPickRows row wKeyWorldBandAdjust) (E-0129)
GenerateKeyWorld_RollMonsters_Boss::
    ld b, $08
    ld a, $40
    ld de, wKeyWorldMonsters
    add e
    ld e, a
    jr nc, .set_temp0
    inc d

.set_temp0:
    ld a, e
    ldh [hTemp0], a
    ld a, d
    ldh [hTemp1], a

.loop:
    ld a, $09
    swap a
    ld de, KeyWorldBandSpeciesTable
    add e
    ld e, a
    jr nc, .call_next_random_seed
    inc d

.call_next_random_seed:
    push de
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $07
    ld de, KeyWorldBossBandPickRows
    add e
    ld e, a
    jr nc, .read_key_world_band_adjust
    inc d

.read_key_world_band_adjust:
    ld a, [wKeyWorldBandAdjust]
    sla a
    sla a
    sla a
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    add a
    pop de
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [hli]
    or a
    jr nz, .skip3
    jr .loop

.skip3:
    dec a
    jr z, .read_temp0
    inc a
    ld c, a

.loop2:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $07
    cp c
    jr nc, .loop2

.read_temp0:
    sla a
    add_a_to_hl
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    inc de
    ld a, e
    ldh [hTemp0], a
    ld a, d
    ldh [hTemp1], a
    dec b
    jp nz, .loop
    ret

SECTION "Bank 60 GenerateKeyWorld_RollMonsters_BossLevels", ROMX

; Adds the same level to the second byte of each of the 8 boss entries at wKeyWorldMonsters + $40: 2
; x min(wKeyWorldLevelBase + ((wPartyStrength + 10) x 15 / 150) / 2, 99), that is the level the
; normal table would give entry 15. The id bytes are not changed. (C2, E-0384)
; for 8 entries from wKeyWorldMonsters + $41 ORs 2 * min(wKeyWorldLevelBase + 15 *
; (wPartyStrength + 10) / 150 / 2, 99) into every other byte (E-0127) (E-0340: the address in its
; name read as its RAM name; was GenerateKeyWorld_RollMonsters_BossLevels)
GenerateKeyWorld_RollMonsters_BossLevels::
    ld b, $08
    ld a, $40
    ld de, wKeyWorldMonsters + $1
    add e
    ld e, a
    jr nc, .read_key_world_level_base
    inc d

.read_key_world_level_base:
    ld a, [wKeyWorldLevelBase]
    ld c, a

.loop:
    push bc
    push bc
    push de
    ld c, $0f
    ld a, [wPartyStrength]
    add $0a
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
    or a
    jr nz, .skip
    ld a, l
    cp $64
    jr c, .skip2

.skip:
    ld l, $63

.skip2:
    ld c, l
    sla c
    ld a, [de]
    or c
    ld [de], a
    inc de
    inc de
    pop bc
    dec b
    jr nz, .loop
    ret

SECTION "Bank 60 GenerateKeyWorld_RollMonsters_BossLevelsAlt", ROMX

; Adds a level to the second byte of each of the 8 boss entries at wKeyWorldMonsters + $40: 2 x
; min(wPartyStrength + 3 x (wPartyStrength / 10), 99), whatever wKeyWorldLevelBase is. Nothing in
; src/ calls or points to it, so it looks like an unused alternative to
; GenerateKeyWorld_RollMonsters_BossLevels. (C2, E-0384)
; for 8 entries from wKeyWorldMonsters + $41 ORs 2 * min(wPartyStrength + 3 * (wPartyStrength /
; 10), 99) into every other byte (E-0125) (E-0340: the address in its name read as its RAM name; was
; GenerateKeyWorld_RollMonsters_BossLevelsAlt)
GenerateKeyWorld_RollMonsters_BossLevelsAlt:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wPartyStrength]
    ld b, a
    ld a, $0a
    call DivideBByA
    ld a, b
    add a
    add b
    ld c, a
    ld a, [wPartyStrength]
    add c
    ld c, a
    ld b, $08
    ld a, $40
    ld de, wKeyWorldMonsters + $1
    add e
    ld e, a
    jr nc, .loop
    inc d

.loop:
    ld a, c
    cp $64
    jr c, .skip
    ld a, $63
    ld c, a

.skip:
    push bc
    sla c
    ld a, [de]
    or c
    ld [de], a
    inc de
    inc de
    pop bc
    dec b
    jr nz, .loop
    ret

SECTION "Bank 60 LoadKeyWorldParamsForCurrentKeyIndex", ROMX

; Reads the entry of wCurrentKeyIndex in wKeyList (4 bytes each). Byte 1 picks wKeyWorldBandAdjust =
; KeyWorldBandAdjustTable[byte 1]; byte 2 picks a row of KeyWorldBandRows (8 bytes): its
; $FF-terminated list of family numbers is copied to wKeyWorldMonsterBands, and byte 6 of the row is
; added to wKeyWorldBandAdjust (a negative sum becomes 0). The monster rollers of
; GenerateKeyWorld_RollMonsters use both results. (C2, E-0384)
; from the wKeyList + $1 entry wCurrentKeyIndex: wKeyWorldBandAdjust = KeyWorldBandAdjustTable[byte
; 0] plus a row adjustment, and copies the $FF-terminated list of KeyWorldBandRows row byte 1 to
; wKeyWorldMonsterBands (E-0127)
LoadKeyWorldParamsForCurrentKeyIndex::
    ld a, [wCurrentKeyIndex]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add $08
    ld l, a
    ld a, h
    adc $c7
    ld h, a
    ld a, [hl]
    ld de, wKeyWorldMonsterBands
    push hl
    ld hl, KeyWorldBandAdjustTable
    add_a_to_hl
    ld a, [hl]
    ld [wKeyWorldBandAdjust], a
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
    ld de, KeyWorldBandRows
    add hl, de
    ld de, wKeyWorldMonsterBands
    push hl

.skip:
    ld a, [hli]
    cp $ff
    jr z, .skip2
    ld [de], a
    inc de
    jr .skip

.skip2:
    ld [de], a
    pop hl
    ld a, $06
    add_a_to_hl
    ld a, [wKeyWorldBandAdjust]
    ld c, a
    ld a, [hl]
    add c
    bit 7, a
    jr z, .set_key_world_band_adjust
    xor a

.set_key_world_band_adjust:
    ld [wKeyWorldBandAdjust], a
    ret

SECTION "Bank 60 KeyWorldBandAdjustTable", ROMX

; LoadKeyWorldParamsForCurrentKeyIndex indexes it by byte 0 of the current key's 4-byte entry at
; wKeyList + $1 + 4 * wCurrentKeyIndex: values -2 to 13 (E-0192, C1)
; record: signed starting value of wKeyWorldBandAdjust
KeyWorldBandAdjustTable::
    db $fe ; id 0
    db $ff ; id 1
    db $00 ; id 2
    db $01 ; id 3
    db $02 ; id 4
    db $03 ; id 5
    db $04 ; id 6
    db $05 ; id 7
    db $06 ; id 8
    db $07 ; id 9
    db $08 ; id 10
    db $09 ; id 11
    db $0a ; id 12
    db $0b ; id 13
    db $0c ; id 14
    db $0d ; id 15

; LoadKeyWorldParamsForCurrentKeyIndex indexes it by 8 * byte 1 of the current key's entry, copies
; bytes up to and including the $FF to wKeyWorldMonsterBands, then adds byte 6 to
; wKeyWorldBandAdjust; 56 rows end at the routine after them; every row has its $FF within the first
; six bytes (E-0192, C1)
; record: band list ($FF-terminated, 6 bytes); band adjustment; unused 0
KeyWorldBandRows::
    db $00, $ff, $ff, $ff, $ff, $ff, $02, $00 ; id 0
    db $01, $ff, $ff, $ff, $ff, $ff, $02, $00 ; id 1
    db $02, $ff, $ff, $ff, $ff, $ff, $02, $00 ; id 2
    db $03, $ff, $ff, $ff, $ff, $ff, $02, $00 ; id 3
    db $04, $ff, $ff, $ff, $ff, $ff, $02, $00 ; id 4
    db $05, $ff, $ff, $ff, $ff, $ff, $02, $00 ; id 5
    db $06, $ff, $ff, $ff, $ff, $ff, $02, $00 ; id 6
    db $07, $ff, $ff, $ff, $ff, $ff, $02, $00 ; id 7
    db $08, $ff, $ff, $ff, $ff, $ff, $02, $00 ; id 8
    db $09, $ff, $ff, $ff, $ff, $ff, $02, $00 ; id 9
    db $0a, $ff, $ff, $ff, $ff, $ff, $10, $00 ; id 10
    db $00, $01, $ff, $ff, $ff, $ff, $00, $00 ; id 11
    db $00, $02, $ff, $ff, $ff, $ff, $00, $00 ; id 12
    db $00, $03, $ff, $ff, $ff, $ff, $00, $00 ; id 13
    db $00, $04, $ff, $ff, $ff, $ff, $00, $00 ; id 14
    db $00, $05, $ff, $ff, $ff, $ff, $00, $00 ; id 15
    db $00, $06, $ff, $ff, $ff, $ff, $00, $00 ; id 16
    db $00, $07, $ff, $ff, $ff, $ff, $00, $00 ; id 17
    db $00, $08, $ff, $ff, $ff, $ff, $00, $00 ; id 18
    db $00, $09, $ff, $ff, $ff, $ff, $00, $00 ; id 19
    db $01, $02, $ff, $ff, $ff, $ff, $00, $00 ; id 20
    db $01, $03, $ff, $ff, $ff, $ff, $00, $00 ; id 21
    db $01, $04, $ff, $ff, $ff, $ff, $00, $00 ; id 22
    db $01, $05, $ff, $ff, $ff, $ff, $00, $00 ; id 23
    db $01, $06, $ff, $ff, $ff, $ff, $00, $00 ; id 24
    db $01, $07, $ff, $ff, $ff, $ff, $00, $00 ; id 25
    db $01, $08, $ff, $ff, $ff, $ff, $00, $00 ; id 26
    db $01, $09, $ff, $ff, $ff, $ff, $00, $00 ; id 27
    db $02, $03, $ff, $ff, $ff, $ff, $00, $00 ; id 28
    db $02, $04, $ff, $ff, $ff, $ff, $00, $00 ; id 29
    db $02, $05, $ff, $ff, $ff, $ff, $00, $00 ; id 30
    db $02, $06, $ff, $ff, $ff, $ff, $00, $00 ; id 31
    db $02, $07, $ff, $ff, $ff, $ff, $00, $00 ; id 32
    db $02, $08, $ff, $ff, $ff, $ff, $00, $00 ; id 33
    db $02, $09, $ff, $ff, $ff, $ff, $00, $00 ; id 34
    db $03, $04, $ff, $ff, $ff, $ff, $00, $00 ; id 35
    db $03, $05, $ff, $ff, $ff, $ff, $00, $00 ; id 36
    db $03, $06, $ff, $ff, $ff, $ff, $00, $00 ; id 37
    db $03, $07, $ff, $ff, $ff, $ff, $00, $00 ; id 38
    db $03, $08, $ff, $ff, $ff, $ff, $00, $00 ; id 39
    db $03, $09, $ff, $ff, $ff, $ff, $00, $00 ; id 40
    db $04, $05, $ff, $ff, $ff, $ff, $00, $00 ; id 41
    db $04, $06, $ff, $ff, $ff, $ff, $00, $00 ; id 42
    db $04, $07, $ff, $ff, $ff, $ff, $00, $00 ; id 43
    db $04, $08, $ff, $ff, $ff, $ff, $00, $00 ; id 44
    db $04, $09, $ff, $ff, $ff, $ff, $00, $00 ; id 45
    db $05, $06, $ff, $ff, $ff, $ff, $00, $00 ; id 46
    db $05, $07, $ff, $ff, $ff, $ff, $00, $00 ; id 47
    db $05, $08, $ff, $ff, $ff, $ff, $00, $00 ; id 48
    db $05, $09, $ff, $ff, $ff, $ff, $00, $00 ; id 49
    db $06, $07, $ff, $ff, $ff, $ff, $00, $00 ; id 50
    db $06, $08, $ff, $ff, $ff, $ff, $00, $00 ; id 51
    db $06, $09, $ff, $ff, $ff, $ff, $00, $00 ; id 52
    db $07, $08, $ff, $ff, $ff, $ff, $00, $00 ; id 53
    db $07, $09, $ff, $ff, $ff, $ff, $00, $00 ; id 54
    db $08, $09, $ff, $ff, $ff, $ff, $00, $00 ; id 55

; Builds wKeyWorldEncounterTable (16 bytes, cleared first): one 4-byte entry per entry of the area
; exit list wKeyWorldAreaExits (it walks the list from wKeyWorldObjects, which is byte 3 of the
; first exit entry, and stops at the $FF that ends the list). Each table entry is a monster word, a
; level and a zero byte. The level is wKeyWorldLevelArea + 2 x the area number, taken from the high
; nibble of wKeyWorldAreaInfo for the area of the first cell of the exit entry (x / 4 + 2 x (y /
; 4)). The monster is drawn with PickRandomKeyWorldMonsterBandsEntry and
; PickRandomMonsterFromBandList in band max(BandFromStrength(wPartyStrength) - 2, 0), repeated until
; a valid one comes. (C2, E-0384)
; clears wKeyWorldEncounterTable ($10 bytes) and fills a 4-byte entry per map area (from
; wKeyWorldObjects) with a random monster id and level from the band lists (E-0128)
GenerateKeyWorld_RollEncounterTable::
    ld b, $10
    ld hl, wKeyWorldEncounterTable
    xor a

.loop:
    ld [hli], a
    dec b
    jr nz, .loop
    ld a, [wPartyStrength]
    call BandFromStrength
    dec a
    dec a
    bit 7, a
    jr z, .set_temp0
    xor a

.set_temp0:
    ldh [hTemp0], a
    ld hl, wKeyWorldObjects
    ld de, wKeyWorldEncounterTable

.skip:
    ld a, [hl]
    cp $ff
    ret z
    push hl
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    and $f0
    swap a
    srl a
    srl a
    ld c, a
    ld a, [hl]
    and $0f
    srl a
    srl a
    add a
    add c
    ld hl, wKeyWorldAreaInfo
    add_a_to_hl
    ld a, [hl]
    and $f0
    swap a
    add a
    ld c, a
    ld a, [wKeyWorldLevelArea]
    add c
    ldh [hTemp2], a
    push de

.loop2:
    call PickRandomKeyWorldMonsterBandsEntry
    call PickRandomMonsterFromBandList
    jr nc, .loop2
    ld l, e
    ld h, d
    pop de
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    inc de
    ldh a, [hTemp2]
    ld [de], a
    inc de
    xor a
    ld [de], a
    inc de
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jp .skip

; The same as GenerateKeyWorld_RollEncounterTable except for the level of an entry:
; min((wPartyStrength / 5) x 7 + 2 x the area number, 99), not using wKeyWorldLevelArea. Nothing in
; src/ calls or points to it, so it looks like an unused alternative. (C2, E-0384)
; like GenerateKeyWorld_RollEncounterTable, with each entry's level from wPartyStrength / 5 * 7 plus
; the area value, capped at 99 (E-0129)
GenerateKeyWorld_RollEncounterTableAlt:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld b, $10
    ld hl, wKeyWorldEncounterTable
    xor a

.loop:
    ld [hli], a
    dec b
    jr nz, .loop
    ld a, [wPartyStrength]
    call BandFromStrength
    dec a
    dec a
    bit 7, a
    jr z, .set_temp0
    xor a

.set_temp0:
    ldh [hTemp0], a
    ld hl, wKeyWorldObjects
    ld de, wKeyWorldEncounterTable

.skip:
    ld a, [hl]
    cp $ff
    ret z
    push hl
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    and $f0
    swap a
    srl a
    srl a
    ld c, a
    ld a, [hl]
    and $0f
    srl a
    srl a
    add a
    add c
    ld hl, wKeyWorldAreaInfo
    add_a_to_hl
    ld a, [hl]
    and $f0
    swap a
    add a
    push hl
    push de
    push af
    ld a, [wPartyStrength]
    ld b, a
    ld a, $05
    call DivideBByA
    ld a, b
    ld c, $07
    call Multiply8
    pop af
    add_a_to_hl
    ld a, h
    or a
    jr nz, .skip2
    ld a, l
    cp $64
    jr c, .skip3

.skip2:
    ld l, $63

.skip3:
    ld a, l
    pop de
    pop hl
    ldh [hTemp2], a
    push de

.loop2:
    call PickRandomKeyWorldMonsterBandsEntry
    call PickRandomMonsterFromBandList
    jr nc, .loop2
    ld l, e
    ld h, d
    pop de
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    inc de
    ldh a, [hTemp2]
    ld [de], a
    inc de
    xor a
    ld [de], a
    inc de
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jp .skip

; Rolls the three foes of the key world encounter in wKeyWorldEncounter (3 bytes each: monster word,
; level). Foe 1 is a valid monster of band BandFromStrength(wPartyStrength) and gets level
; wKeyWorldLevelMonster. Foes 2 and 3 are both empty (words 0) when a draw of wKeyRandomLo & 7 is 0
; (one time in eight); otherwise they are both the same monster, picked from a band two lower (not
; below 0). Their level byte is max(wKeyWorldLevelMonster, 5) - 4 in both cases. An invalid pick
; (empty list or a rejected id) starts the whole roll again, and the band already lowered for foes 2
; and 3 is not restored, so it can fall further on a restart. (C2, E-0384)
; picks random monster ids for the key world from the wKeyWorldMonsterBands lists by band
; (PickRandomMonsterFromBandList) into wKeyWorldEncounter-wKeyWorldEncounter + $7, and
; wKeyWorldEncounter + $2/wKeyWorldEncounter + $5/wKeyWorldEncounter + $8 from wKeyWorldLevelMonster
; (E-0127)
GenerateKeyWorld_RollEncounterFoes::
    ld a, [wPartyStrength]
    call BandFromStrength
    ldh [hTemp0], a

.loop:
    call PickRandomKeyWorldMonsterBandsEntry
    call PickRandomMonsterFromBandList
    jr nc, .loop
    ld a, e
    ld [wKeyWorldEncounter], a
    ld a, d
    ld [wKeyWorldEncounter + $1], a
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and $07
    jr nz, .check_temp0
    ld hl, $0000
    ld a, l
    ld [wKeyWorldEncounter + $3], a
    ld a, h
    ld [wKeyWorldEncounter + $4], a
    ld a, l
    ld [wKeyWorldEncounter + $6], a
    ld a, h
    ld [wKeyWorldEncounter + $7], a
    jr .read_key_world_level_monster

.check_temp0:
    ldh a, [hTemp0]
    dec a
    dec a
    bit 7, a
    jr z, .set_temp0
    xor a

.set_temp0:
    ldh [hTemp0], a
    call PickRandomKeyWorldMonsterBandsEntry
    call PickRandomMonsterFromBandList
    jr nc, .loop
    ld a, e
    ld [wKeyWorldEncounter + $3], a
    ld a, d
    ld [wKeyWorldEncounter + $4], a
    ld a, e
    ld [wKeyWorldEncounter + $6], a
    ld a, d
    ld [wKeyWorldEncounter + $7], a

.read_key_world_level_monster:
    ld a, [wKeyWorldLevelMonster]
    ld [wKeyWorldEncounter + $2], a
    cp $05
    jr nc, .skip
    ld a, $05

.skip:
    dec a
    dec a
    dec a
    dec a
    ld [wKeyWorldEncounter + $5], a
    ld [wKeyWorldEncounter + $8], a
    ret

SECTION "Bank 60 PickRandomKeyWorldMonsterBandsEntry", ROMX

; Advances the seed and sets hTemp1 to wKeyWorldMonsterBands[wKeyRandomLo & 1], the family number.
; If that byte is $FF (the list holds one entry) it steps back to the previous byte. Used before
; PickRandomMonsterFromBandList. (C2, E-0384)
; hTemp1 = wKeyWorldMonsterBands[random & 1], stepping back over $FF entries (E-0124)
PickRandomKeyWorldMonsterBandsEntry::
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and $01
    ld hl, wKeyWorldMonsterBands
    add l
    ld l, a
    jr nc, .skip
    inc h

.skip:
    ld a, [hl]
    cp $ff
    jr nz, .set_temp1
    dec hl
    jr .skip

.set_temp1:
    ldh [hTemp1], a
    ret

SECTION "Bank 60 PickRandomMonsterFromBandList", ROMX

; Input hTemp1 = family, hTemp0 = band. Looks up the list at KeyWorldBandSpeciesTable[16 x family +
; 2 x band] (a count byte, then two-byte monster words) and returns DE = one word of it, chosen by
; drawing wKeyRandomHi & 7 until it is below the count (a one-word list uses no draw). Carry set =
; DE is valid; carry clear = the list is empty or the word is one of the rejected ids $00A4, $00A5
; and $0174 (DE is then not meaningful). (C2, E-0384)
; DE = a random entry of the list KeyWorldBandSpeciesTable[16 * hTemp1 + 2 * hTemp0]; carry when
; valid, no carry for an empty list or ids $A4, $A5 and $174 (E-0127)
PickRandomMonsterFromBandList::
    ldh a, [hTemp1]
    swap a
    ld de, KeyWorldBandSpeciesTable
    add e
    ld e, a
    jr nc, .read_temp0
    inc d

.read_temp0:
    ldh a, [hTemp0]
    add a
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [hli]
    or a
    jr nz, .skip2

.loop:
    sub a
    ret

.skip2:
    dec a
    jr z, .skip3
    inc a
    ld c, a

.loop2:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $07
    cp c
    jr nc, .loop2

.skip3:
    sla a
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    or a
    jr nz, .skip4
    ld a, e
    cp $a4
    jr z, .loop
    cp $a5
    jr z, .loop
    scf
    ret

.skip4:
    ld a, e
    cp $74
    jr z, .loop
    scf
    ret

SECTION "Bank 60 BandFromStrength", ROMX

; A = a party strength or level value: returns A = 2 below 20 ($14), 3 below 40, 4 below 60, 5 below
; 80, 6 below 95 and 7 from 95 up. (C2, E-0384)
; A = 2-7 by thresholds 20, 40, 60, 70, 80, 90, 95 (E-0125) (E-0344: the address in its name dropped
; or read as the label there; was BandFromStrength)
BandFromStrength::
    cp $14
    jr nc, .cp_28
    ld a, $02
    ret

.cp_28:
    cp $28
    jr nc, .cp_3C
    ld a, $03
    ret

.cp_3C:
    cp $3c
    jr nc, .cp_46
    ld a, $04
    ret

.cp_46:
    cp $46
    jr nc, .cp_50
    ld a, $05
    ret

.cp_50:
    cp $50
    jr nc, .cp_5A
    ld a, $05
    ret

.cp_5A:
    cp $5a
    jr nc, .cp_5F
    ld a, $06
    ret

.cp_5F:
    cp $5f
    jr nc, .return_07
    ld a, $06
    ret

.return_07:
    ld a, $07
    ret

SECTION "Bank 60 LoadKeyWorldLevelBaseTripleForPartyStrength", ROMX

; Copies the first three bytes of record wPartyStrength (8 bytes each, 100 records) of
; KeyWorldLevelTable to wKeyWorldLevelBase, wKeyWorldLevelArea and wKeyWorldLevelMonster, the three
; level values the other key world rollers use. (C2, E-0384)
; copies three bytes of entry wPartyStrength of the 8-byte table at $47C5 to
; wKeyWorldLevelBase-wKeyWorldLevelMonster (E-0121)
LoadKeyWorldLevelBaseTripleForPartyStrength::
    ld a, [wPartyStrength]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, l
    add LOW(KeyWorldLevelTable)
    ld l, a
    ld a, h
    adc HIGH(KeyWorldLevelTable)
    ld h, a
    ld a, [hli]
    ld [wKeyWorldLevelBase], a
    ld a, [hli]
    ld [wKeyWorldLevelArea], a
    ld a, [hli]
    ld [wKeyWorldLevelMonster], a
    ret

SECTION "Bank 60 KeyWorldLevelTable", ROMX

; LoadKeyWorldLevelBaseTripleForPartyStrength reads the record at $47C5 + 8 * wPartyStrength and
; copies its first three bytes; 100 records end at the routine at $4AE5; record 0 is all zero, and
; the three levels rise with the index (E-0192, C1)
; record: three level bytes copied to wKeyWorldLevelBase/Area/Monster; five bytes not read ($64,
; $64, $64, 0, 0)
KeyWorldLevelTable::
    db $00, $00, $00, $00, $00, $00, $00, $00 ; id 0
    db $0e, $12, $13, $64, $64, $64, $00, $00 ; id 1
    db $0f, $13, $14, $64, $64, $64, $00, $00 ; id 2
    db $10, $14, $15, $64, $64, $64, $00, $00 ; id 3
    db $11, $15, $17, $64, $64, $64, $00, $00 ; id 4
    db $12, $16, $18, $64, $64, $64, $00, $00 ; id 5
    db $13, $17, $19, $64, $64, $64, $00, $00 ; id 6
    db $14, $18, $1a, $64, $64, $64, $00, $00 ; id 7
    db $15, $19, $1b, $64, $64, $64, $00, $00 ; id 8
    db $16, $1a, $1c, $64, $64, $64, $00, $00 ; id 9
    db $17, $1b, $1d, $64, $64, $64, $00, $00 ; id 10
    db $17, $1c, $1d, $64, $64, $64, $00, $00 ; id 11
    db $18, $1d, $1e, $64, $64, $64, $00, $00 ; id 12
    db $18, $1d, $1f, $64, $64, $64, $00, $00 ; id 13
    db $19, $1e, $20, $64, $64, $64, $00, $00 ; id 14
    db $19, $1e, $20, $64, $64, $64, $00, $00 ; id 15
    db $1a, $1f, $21, $64, $64, $64, $00, $00 ; id 16
    db $1a, $1f, $21, $64, $64, $64, $00, $00 ; id 17
    db $1a, $20, $22, $64, $64, $64, $00, $00 ; id 18
    db $1a, $20, $22, $64, $64, $64, $00, $00 ; id 19
    db $1b, $21, $23, $64, $64, $64, $00, $00 ; id 20
    db $1b, $21, $23, $64, $64, $64, $00, $00 ; id 21
    db $1b, $21, $23, $64, $64, $64, $00, $00 ; id 22
    db $1c, $22, $24, $64, $64, $64, $00, $00 ; id 23
    db $1c, $22, $24, $64, $64, $64, $00, $00 ; id 24
    db $1c, $23, $24, $64, $64, $64, $00, $00 ; id 25
    db $1d, $23, $25, $64, $64, $64, $00, $00 ; id 26
    db $1d, $23, $25, $64, $64, $64, $00, $00 ; id 27
    db $1e, $24, $26, $64, $64, $64, $00, $00 ; id 28
    db $1e, $24, $26, $64, $64, $64, $00, $00 ; id 29
    db $1f, $25, $27, $64, $64, $64, $00, $00 ; id 30
    db $20, $25, $27, $64, $64, $64, $00, $00 ; id 31
    db $21, $26, $28, $64, $64, $64, $00, $00 ; id 32
    db $21, $26, $29, $64, $64, $64, $00, $00 ; id 33
    db $22, $27, $2a, $64, $64, $64, $00, $00 ; id 34
    db $23, $27, $2a, $64, $64, $64, $00, $00 ; id 35
    db $24, $28, $2b, $64, $64, $64, $00, $00 ; id 36
    db $25, $29, $2c, $64, $64, $64, $00, $00 ; id 37
    db $26, $29, $2d, $64, $64, $64, $00, $00 ; id 38
    db $27, $29, $2e, $64, $64, $64, $00, $00 ; id 39
    db $28, $2a, $2f, $64, $64, $64, $00, $00 ; id 40
    db $29, $2a, $30, $64, $64, $64, $00, $00 ; id 41
    db $2a, $2b, $31, $64, $64, $64, $00, $00 ; id 42
    db $2b, $2c, $32, $64, $64, $64, $00, $00 ; id 43
    db $2c, $2d, $33, $64, $64, $64, $00, $00 ; id 44
    db $2c, $2e, $34, $64, $64, $64, $00, $00 ; id 45
    db $2d, $2f, $35, $64, $64, $64, $00, $00 ; id 46
    db $2e, $30, $36, $64, $64, $64, $00, $00 ; id 47
    db $2f, $31, $37, $64, $64, $64, $00, $00 ; id 48
    db $2f, $31, $37, $64, $64, $64, $00, $00 ; id 49
    db $31, $33, $39, $64, $64, $64, $00, $00 ; id 50
    db $32, $34, $3a, $64, $64, $64, $00, $00 ; id 51
    db $33, $35, $3b, $64, $64, $64, $00, $00 ; id 52
    db $33, $35, $3b, $64, $64, $64, $00, $00 ; id 53
    db $34, $36, $3c, $64, $64, $64, $00, $00 ; id 54
    db $35, $38, $3e, $64, $64, $64, $00, $00 ; id 55
    db $36, $39, $3f, $64, $64, $64, $00, $00 ; id 56
    db $36, $39, $3f, $64, $64, $64, $00, $00 ; id 57
    db $37, $3a, $40, $64, $64, $64, $00, $00 ; id 58
    db $38, $3b, $41, $64, $64, $64, $00, $00 ; id 59
    db $3a, $3d, $43, $64, $64, $64, $00, $00 ; id 60
    db $3a, $3d, $43, $64, $64, $64, $00, $00 ; id 61
    db $3b, $3e, $44, $64, $64, $64, $00, $00 ; id 62
    db $3c, $3f, $45, $64, $64, $64, $00, $00 ; id 63
    db $3c, $40, $46, $64, $64, $64, $00, $00 ; id 64
    db $3d, $41, $47, $64, $64, $64, $00, $00 ; id 65
    db $3e, $42, $48, $64, $64, $64, $00, $00 ; id 66
    db $3f, $43, $49, $64, $64, $64, $00, $00 ; id 67
    db $40, $44, $4a, $64, $64, $64, $00, $00 ; id 68
    db $41, $45, $4b, $64, $64, $64, $00, $00 ; id 69
    db $42, $46, $4c, $64, $64, $64, $00, $00 ; id 70
    db $42, $47, $4d, $64, $64, $64, $00, $00 ; id 71
    db $43, $48, $4e, $64, $64, $64, $00, $00 ; id 72
    db $44, $49, $4f, $64, $64, $64, $00, $00 ; id 73
    db $45, $4a, $50, $64, $64, $64, $00, $00 ; id 74
    db $46, $4b, $51, $64, $64, $64, $00, $00 ; id 75
    db $47, $4c, $52, $64, $64, $64, $00, $00 ; id 76
    db $48, $4d, $53, $64, $64, $64, $00, $00 ; id 77
    db $48, $4e, $54, $64, $64, $64, $00, $00 ; id 78
    db $49, $4f, $55, $64, $64, $64, $00, $00 ; id 79
    db $4a, $50, $56, $64, $64, $64, $00, $00 ; id 80
    db $4b, $51, $57, $64, $64, $64, $00, $00 ; id 81
    db $4c, $52, $58, $64, $64, $64, $00, $00 ; id 82
    db $4c, $52, $58, $64, $64, $64, $00, $00 ; id 83
    db $4c, $53, $59, $64, $64, $64, $00, $00 ; id 84
    db $4c, $53, $59, $64, $64, $64, $00, $00 ; id 85
    db $4d, $54, $5a, $64, $64, $64, $00, $00 ; id 86
    db $4d, $54, $5a, $64, $64, $64, $00, $00 ; id 87
    db $4e, $55, $5b, $64, $64, $64, $00, $00 ; id 88
    db $4e, $56, $5b, $64, $64, $64, $00, $00 ; id 89
    db $4e, $57, $5c, $64, $64, $64, $00, $00 ; id 90
    db $4f, $57, $5c, $64, $64, $64, $00, $00 ; id 91
    db $4f, $57, $5d, $64, $64, $64, $00, $00 ; id 92
    db $4f, $58, $5e, $64, $64, $64, $00, $00 ; id 93
    db $50, $58, $5e, $64, $64, $64, $00, $00 ; id 94
    db $50, $59, $5f, $64, $64, $64, $00, $00 ; id 95
    db $50, $5a, $5f, $64, $64, $64, $00, $00 ; id 96
    db $51, $5b, $5f, $64, $64, $64, $00, $00 ; id 97
    db $52, $5b, $60, $64, $64, $64, $00, $00 ; id 98
    db $56, $60, $63, $64, $64, $64, $00, $00 ; id 99

; Starts the layout: clears the flags and visited screens, picks the goal kind, the size (a random
; entry of the table row for the party strength rounded down to 10; a 0 nibble means 10 screens) and
; the area count (the row for strength / 10: a base plus a random part), and clears the four chunk
; slots and areas. (C2, E-0357; probed E-0384)
KeyWorldLayout_Start::
    xor a
    ld [wKeyWorldFlags], a
    call KeyWorldLayout_ClearActiveIfSameKey
    xor a
    ld hl, wVisitedScreens
    ld b, $08

.loop:
    ld [hli], a
    dec b
    jr nz, .loop
    call PickRandomNonzeroFromKeyWorldGoalKindRows
    ld a, [wPartyStrength]
    ld l, a
    ld h, $00
    ld a, $0a
    call DivideHLByA
    ld c, a
    ld a, [wPartyStrength]
    sub c
    ld l, a
    ld h, $00

.loop2:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $0f
    cp $0a
    jr nc, .loop2
    add_a_to_hl
    ld a, l
    add LOW(KeyWorldSizeByStrength)
    ld l, a
    ld a, h
    adc HIGH(KeyWorldSizeByStrength)
    ld h, a
    ld a, [hl]
    swap a
    and $0f
    jr nz, .set_key_world_width
    ld a, $0a

.set_key_world_width:
    ld [wKeyWorldWidth], a
    ld [wMapWidthScreens], a
    ld a, [hl]
    and $0f
    jr nz, .set_key_world_height
    ld a, $0a

.set_key_world_height:
    ld [wKeyWorldHeight], a
    ld [wMapHeightScreens], a
    ld a, [wKeyWorldWidth]
    srl a
    srl a
    ldh [hTemp8], a
    ld a, [wKeyWorldHeight]
    srl a
    srl a
    ldh [hTemp9], a
    ld a, [wPartyStrength]
    ld b, a
    ld a, $0a
    call DivideBByA
    ld a, b
    add a
    ld hl, KeyWorldLayout_Start_Data
    add_a_to_hl
    ld a, [hli]
    ld b, a
    ld a, [hl]
    ld c, a
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and c
    add b
    ld [wKeyWorldAreaCount], a
    ld hl, wKeyWorldChunks + $3
    ld de, wKeyWorldAreas
    ld b, $04

.loop3:
    ld a, $ff
    ld [hl], a
    ld a, $04
    add_a_to_hl
    ld a, $ff
    ld [de], a
    inc de
    dec b
    jr nz, .loop3
    ld hl, wKeyWorldChunks + $3
    ld de, wKeyWorldAreas
    ldh a, [hTemp8]
    or a
    jr z, .check_temp9
    ld c, a
    ld b, $00

.loop4:
    push hl
    push de
    ld a, b
    cp c
    jr c, .restore
    ld [hl], $fe
    ld a, $08
    add_a_to_hl
    ld [hl], $fe
    ld a, $fe
    ld [de], a
    inc de
    inc de
    ld [de], a

.restore:
    pop de
    inc de
    pop hl
    ld a, $04
    add_a_to_hl
    inc b
    ld a, b
    cp $02
    jr nz, .loop4

.check_temp9:
    ld hl, wKeyWorldChunks + $3
    ld de, wKeyWorldAreas
    ldh a, [hTemp9]
    or a
    jr z, .return
    ld c, a
    ld b, $00

.loop5:
    push hl
    push de
    ld a, b
    cp c
    jr c, .restore2
    ld a, $fe
    ld [hl], a
    inc hl
    inc hl
    inc hl
    inc hl
    ld [hl], a
    ld [de], a
    inc de
    ld [de], a

.restore2:
    pop de
    inc de
    inc de
    pop hl
    ld a, $08
    add_a_to_hl
    inc b
    ld a, b
    cp $02
    jr nz, .loop5

.return:
    ret

SECTION "Bank 60 KeyWorldSizeByStrength", ROMX

; KeyWorldLayout_Start reads the byte at $4BF4 + (wPartyStrength rounded down to 10) + a roll of
; 0-9, through an add/adc of $4BF4; 100 bytes, $44 (4 x 4 screens) for 0-9 and $88 (8 x 8) from 10
; on, ending where KeyWorldLayout_Start_Data begins (E-0401, C1)
; record: the size of a new key world: high nibble wKeyWorldWidth, low nibble wKeyWorldHeight
KeyWorldSizeByStrength::
    db $44 ; id 0
    db $44 ; id 1
    db $44 ; id 2
    db $44 ; id 3
    db $44 ; id 4
    db $44 ; id 5
    db $44 ; id 6
    db $44 ; id 7
    db $44 ; id 8
    db $44 ; id 9
    db $88 ; id 10
    db $88 ; id 11
    db $88 ; id 12
    db $88 ; id 13
    db $88 ; id 14
    db $88 ; id 15
    db $88 ; id 16
    db $88 ; id 17
    db $88 ; id 18
    db $88 ; id 19
    db $88 ; id 20
    db $88 ; id 21
    db $88 ; id 22
    db $88 ; id 23
    db $88 ; id 24
    db $88 ; id 25
    db $88 ; id 26
    db $88 ; id 27
    db $88 ; id 28
    db $88 ; id 29
    db $88 ; id 30
    db $88 ; id 31
    db $88 ; id 32
    db $88 ; id 33
    db $88 ; id 34
    db $88 ; id 35
    db $88 ; id 36
    db $88 ; id 37
    db $88 ; id 38
    db $88 ; id 39
    db $88 ; id 40
    db $88 ; id 41
    db $88 ; id 42
    db $88 ; id 43
    db $88 ; id 44
    db $88 ; id 45
    db $88 ; id 46
    db $88 ; id 47
    db $88 ; id 48
    db $88 ; id 49
    db $88 ; id 50
    db $88 ; id 51
    db $88 ; id 52
    db $88 ; id 53
    db $88 ; id 54
    db $88 ; id 55
    db $88 ; id 56
    db $88 ; id 57
    db $88 ; id 58
    db $88 ; id 59
    db $88 ; id 60
    db $88 ; id 61
    db $88 ; id 62
    db $88 ; id 63
    db $88 ; id 64
    db $88 ; id 65
    db $88 ; id 66
    db $88 ; id 67
    db $88 ; id 68
    db $88 ; id 69
    db $88 ; id 70
    db $88 ; id 71
    db $88 ; id 72
    db $88 ; id 73
    db $88 ; id 74
    db $88 ; id 75
    db $88 ; id 76
    db $88 ; id 77
    db $88 ; id 78
    db $88 ; id 79
    db $88 ; id 80
    db $88 ; id 81
    db $88 ; id 82
    db $88 ; id 83
    db $88 ; id 84
    db $88 ; id 85
    db $88 ; id 86
    db $88 ; id 87
    db $88 ; id 88
    db $88 ; id 89
    db $88 ; id 90
    db $88 ; id 91
    db $88 ; id 92
    db $88 ; id 93
    db $88 ; id 94
    db $88 ; id 95
    db $88 ; id 96
    db $88 ; id 97
    db $88 ; id 98
    db $88 ; id 99

; Ten (base, mask) byte pairs, one per tens of the party strength (wPartyStrength / 10, 0-9): (0,
; $0F), (8, $0F), (8, $0F), then (16, $1F) for the rest. KeyWorldLayout_Start rolls wKeyRandomHi AND
; mask, adds the base and stores the result in wKeyWorldAreaCount, so the area count is 0-15 at
; strength below 10, 8-23 at 10-29 and 16-47 from 30 up. (C1, E-0381)
KeyWorldLayout_Start_Data::
    db $00, $0f, $08, $0f, $08, $0f, $10, $1f, $10, $1f, $10, $1f, $10, $1f, $10, $1f
    db $10, $1f, $10, $1f

; Called by KeyWorldLayout_Start: when wKeyWorldActive is non-zero and wKeyWorldKey has bit 7 set
; with its low 7 bits equal to wKeyWorldSlot, clears wKeyWorldActive; otherwise returns with it
; unchanged. (C2, E-0372; probed E-0384)
; when wKeyWorldActive is set and wKeyWorldKey has bit 7 with low bits equal to wKeyWorldSlot,
; clears wKeyWorldActive (E-0122)
KeyWorldLayout_ClearActiveIfSameKey::
    ld a, [wKeyWorldActive]
    or a
    ret z
    ld a, [wKeyWorldKey]
    bit 7, a
    ret z
    and $7f
    ld c, a
    ld a, [wKeyWorldSlot]
    cp c
    ret nz
    ld a, $00
    ld [wKeyWorldActive], a
    ret

SECTION "Bank 60 PickRandomNonzeroFromKeyWorldGoalKindRows", ROMX

; Sets wKeyWorldGoalKind. It reads byte 2 of the wKeyList entry of wCurrentKeyIndex, which picks a
; 4-byte row of KeyWorldGoalKindRows, draws one of the four bytes (the low bits of wKeyRandomLo
; after a seed step) and draws again while that byte is 0; wKeyWorldGoalKind = the byte - 1.
; KeyWorldLayout_Start calls it. (C2, E-0384)
; repeatedly picks entry (wKeyRandomLo & 3) of the 4-byte row of KeyWorldGoalKindRows selected by
; the second byte of the wKeyList + $1 entry wCurrentKeyIndex until it is non-zero;
; wKeyWorldGoalKind = entry - 1 (E-0121)
PickRandomNonzeroFromKeyWorldGoalKindRows::
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and $07
    push af
    ld a, [wCurrentKeyIndex]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add $08
    ld e, a
    ld a, d
    adc $c7
    ld d, a
    inc de
    ld hl, KeyWorldGoalKindRows
    ld a, [de]
    add a
    add a
    add_a_to_hl
    pop af
    and $03
    add_a_to_hl
    ld a, [hl]
    or a
    jr z, PickRandomNonzeroFromKeyWorldGoalKindRows
    dec a
    ld [wKeyWorldGoalKind], a
    ret

SECTION "Bank 60 KeyWorldGoalKindRows", ROMX

; PickRandomNonzeroFromKeyWorldGoalKindRows reads the byte at $4CC1 + 4 * (byte 1 of the current
; key's entry at wKeyList + $1) + (random & 3), repeating until it is non-zero, and stores it minus
; 1 in wKeyWorldGoalKind; 56 rows, the same count as KeyWorldBandRows, which the same byte indexes
; (E-0192, C1)
; record: four choices of wKeyWorldGoalKind + 1 (0 = no choice; drawn again)
KeyWorldGoalKindRows::
    db $01, $02, $06, $00 ; id 0
    db $04, $05, $07, $00 ; id 1
    db $02, $03, $0a, $00 ; id 2
    db $05, $09, $0a, $00 ; id 3
    db $01, $05, $0a, $00 ; id 4
    db $04, $08, $09, $00 ; id 5
    db $06, $07, $08, $00 ; id 6
    db $02, $06, $08, $00 ; id 7
    db $03, $04, $07, $00 ; id 8
    db $01, $03, $09, $00 ; id 9
    db $06, $06, $06, $06 ; id 10
    db $02, $02, $02, $02 ; id 11
    db $09, $09, $09, $09 ; id 12
    db $01, $01, $01, $01 ; id 13
    db $01, $01, $01, $01 ; id 14
    db $07, $07, $07, $07 ; id 15
    db $06, $06, $06, $06 ; id 16
    db $08, $08, $08, $08 ; id 17
    db $07, $07, $07, $07 ; id 18
    db $09, $09, $09, $09 ; id 19
    db $04, $04, $04, $04 ; id 20
    db $05, $05, $05, $05 ; id 21
    db $03, $03, $03, $03 ; id 22
    db $01, $01, $01, $01 ; id 23
    db $06, $06, $06, $06 ; id 24
    db $04, $04, $04, $04 ; id 25
    db $04, $04, $04, $04 ; id 26
    db $03, $03, $03, $03 ; id 27
    db $0a, $0a, $0a, $0a ; id 28
    db $05, $05, $05, $05 ; id 29
    db $01, $01, $01, $01 ; id 30
    db $0a, $0a, $0a, $0a ; id 31
    db $08, $08, $08, $08 ; id 32
    db $07, $07, $07, $07 ; id 33
    db $02, $02, $02, $02 ; id 34
    db $0a, $0a, $0a, $0a ; id 35
    db $05, $05, $05, $05 ; id 36
    db $02, $02, $02, $02 ; id 37
    db $03, $03, $03, $03 ; id 38
    db $05, $05, $05, $05 ; id 39
    db $09, $09, $09, $09 ; id 40
    db $05, $05, $05, $05 ; id 41
    db $0a, $0a, $0a, $0a ; id 42
    db $02, $02, $02, $02 ; id 43
    db $06, $06, $06, $06 ; id 44
    db $09, $09, $09, $09 ; id 45
    db $04, $04, $04, $04 ; id 46
    db $08, $08, $08, $08 ; id 47
    db $07, $07, $07, $07 ; id 48
    db $01, $01, $01, $01 ; id 49
    db $08, $08, $08, $08 ; id 50
    db $06, $06, $06, $06 ; id 51
    db $03, $03, $03, $03 ; id 52
    db $04, $04, $04, $04 ; id 53
    db $02, $02, $02, $02 ; id 54
    db $03, $03, $03, $03 ; id 55

; Fills each of the four chunk slots that is still empty with a random chunk pattern
; (RunRandomPatternCase, retried until one fits), counting the areas in hTemp7. (C2, E-0357; probed
; E-0384)
GenerateKeyWorld_FillChunkSlots::
    ld b, $00
    ld hl, wKeyWorldChunks + $3
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ld de, wKeyWorldAreas
    ld a, e
    ldh [hTemp5], a
    ld a, d
    ldh [hTemp6], a
    xor a
    ldh [hTemp7], a

.loop:
    push bc
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, [hl]
    cp $ff
    jr nz, .read_temp5

.loop2:
    call RunRandomPatternCase
    or a
    jr z, .loop2
    ld hl, hTemp7
    inc [hl]

.read_temp5:
    ldh a, [hTemp5]
    ld e, a
    ldh a, [hTemp6]
    ld d, a
    inc de
    ld a, e
    ldh [hTemp5], a
    ld a, d
    ldh [hTemp6], a
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, $04
    add_a_to_hl
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    pop bc
    inc b
    ld a, b
    cp $04
    jr nz, .loop
    ret

SECTION "Bank 60 GenerateKeyWorld_MergeAreaInfo", ROMX

; ORs the low nibble of each of the four wKeyWorldAreas bytes into the matching byte of
; wKeyWorldAreaInfo, which GenerateKeyWorld_ShuffleAreaNumbers has just filled with the high nibbles
; (the area numbers). No input; nothing else changes. Only GenerateKeyWorld calls it; the name
; mentions the debug automap but this routine has no part in it. (C2, E-0384)
; ORs the low nibbles of the four wKeyWorldAreas bytes into wKeyWorldAreaInfo
GenerateKeyWorld_MergeAreaInfo::
    ld b, $04
    ld hl, wKeyWorldAreas
    ld de, wKeyWorldAreaInfo

.loop:
    ld a, [hli]
    and $0f
    ld c, a
    ld a, [de]
    or c
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ret

SECTION "Bank 60 GenerateKeyWorld_ShuffleAreaNumbers", ROMX

; With more than one area (hTemp7), swaps random pairs of area numbers (the high nibbles of
; wKeyWorldAreas, once per area), then walks the areas by number to settle their cells' order
; (SwapDEByteWithMatchingKeyWorldAreas); finally copies the four area numbers (high nibbles of
; wKeyWorldAreas) into wKeyWorldAreaInfo. (C2, E-0369; probed E-0384)
GenerateKeyWorld_ShuffleAreaNumbers::
    ldh a, [hTemp7]
    cp $01
    jp z, .skip4
    ld c, a
    ld b, a

.loop:
    push bc

.loop2:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $03
    cp c
    jr nc, .loop2
    ldh [hTemp0], a

.loop3:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $03
    cp c
    jr nc, .loop3
    ld c, a
    ldh a, [hTemp0]
    cp c
    jr z, .restore
    ld a, c
    ldh [hTemp1], a
    ld hl, wKeyWorldAreas
    ld b, $04

.loop4:
    ld a, [hl]
    cp $ff
    jr z, .next
    cp $fe
    jr z, .next
    swap a
    and $0f
    ld c, a
    ldh a, [hTemp0]
    cp c
    jr nz, .check_temp1
    ldh a, [hTemp1]
    swap a
    ld c, a
    ld a, [hl]
    and $0f
    or c
    ld [hl], a
    jr .next

.check_temp1:
    ldh a, [hTemp1]
    cp c
    jr nz, .next
    ldh a, [hTemp0]
    swap a
    ld c, a
    ld a, [hl]
    and $0f
    or c
    ld [hl], a

.next:
    inc hl
    dec b
    jr nz, .loop4

.restore:
    pop bc
    dec b
    jr nz, .loop
    ld b, $00

.loop5:
    push bc
    ld hl, wKeyWorldAreas
    ld e, $00
    ld c, $00

.loop6:
    ld a, [hl]
    cp $ff
    jr z, .next2
    cp $fe
    jr z, .next2
    swap a
    and $0f
    cp b
    jr nz, .next2
    ld a, [hl]
    and $0f
    cp e
    jr c, .next2
    ld e, a
    ld a, c
    ldh [hTemp0], a

.next2:
    inc hl
    inc c
    ld a, c
    cp $04
    jr nz, .loop6
    ldh a, [hTemp0]
    and $0c
    jr z, .check_temp0
    ldh a, [hTemp0]
    dec a
    dec a
    ld de, wKeyWorldAreas
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    swap a
    and $0f
    dec a
    cp b
    jr nz, .check_temp0
    ld a, [de]
    and $0f
    jp z, .check_temp7
    call SwapDEByteWithMatchingKeyWorldAreas
    jp .check_temp7

.check_temp0:
    ldh a, [hTemp0]
    and $01
    jr z, .check_temp02
    ldh a, [hTemp0]
    dec a
    ld de, wKeyWorldAreas
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    swap a
    and $0f
    dec a
    cp b
    jr nz, .check_temp02
    ld a, [de]
    and $0f
    jr z, .check_temp7
    call SwapDEByteWithMatchingKeyWorldAreas
    jr .check_temp7

.check_temp02:
    ldh a, [hTemp0]
    and $02
    cp $02
    jr z, .check_temp03
    ldh a, [hTemp0]
    inc a
    inc a
    ld de, wKeyWorldAreas
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, [de]
    cp $ff
    jr z, .check_temp03
    cp $fe
    jr z, .check_temp03
    ld a, [de]
    swap a
    and $0f
    dec a
    cp b
    jr nz, .check_temp03
    ld a, [de]
    and $0f
    jr z, .check_temp7
    call SwapDEByteWithMatchingKeyWorldAreas
    jr .check_temp7

.check_temp03:
    ldh a, [hTemp0]
    and $01
    cp $01
    jr z, .check_temp7
    ldh a, [hTemp0]
    inc a
    ld de, wKeyWorldAreas
    add e
    ld e, a
    jr nc, .cp_FF
    inc d

.cp_FF:
    cp $ff
    jr z, .check_temp7
    cp $fe
    jr z, .check_temp7
    ld a, [de]
    swap a
    and $0f
    dec a
    cp b
    jr nz, .check_temp7
    ld a, [de]
    and $0f
    jr z, .check_temp7
    call SwapDEByteWithMatchingKeyWorldAreas

.check_temp7:
    pop bc
    inc b
    ldh a, [hTemp7]
    dec a
    cp b
    jp nz, .loop5

.skip4:
    ld b, $04
    ld hl, wKeyWorldAreas
    ld de, wKeyWorldAreaInfo

.loop7:
    ld a, [hli]
    and $f0
    ld [de], a
    inc de
    dec b
    jr nz, .loop7
    ret

SECTION "Bank 60 SwapDEByteWithMatchingKeyWorldAreas", ROMX

; DE = address of a byte of wKeyWorldAreas. Sets hTemp1 = [DE] & $F0 and exchanges [DE] with the
; first of the four wKeyWorldAreas bytes whose whole value equals hTemp1, that is the same area
; number with a low nibble of 0 (the first cell of that area). Nothing changes when there is none.
; Called by GenerateKeyWorld_ShuffleAreaNumbers for a neighbour slot that holds the next area
; number. (C2, E-0384)
; swaps [DE] with the first of the four wKeyWorldAreas bytes whose high nibble matches [DE]'s
; (E-0124)
SwapDEByteWithMatchingKeyWorldAreas::
    ld a, [de]
    and $f0
    ldh [hTemp1], a
    ld c, $04
    ld hl, wKeyWorldAreas

.loop:
    push bc
    ld a, [hl]
    ld c, a
    ldh a, [hTemp1]
    cp c
    jr nz, .next
    pop bc
    ld a, [hl]
    ld c, a
    ld a, [de]
    ld [hl], a
    ld a, c
    ld [de], a
    ret

.next:
    inc hl
    pop bc
    dec c
    jr nz, .loop
    ret

SECTION "Bank 60 KeyWorldLayout_PlaceAreaExits", ROMX

; Clears the area exits and, for each area after the first, finds where it meets the next one and
; places two random open cells between them (PlaceTwoRandomOpenCells); $FF ends the list. (C2,
; E-0357; probed E-0384)
KeyWorldLayout_PlaceAreaExits::
    ld hl, wKeyWorldAreaExits + $2
    ld b, $05

.loop:
    push hl
    xor a
    ld [hli], a
    ld [hl], a
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    dec b
    jr nz, .loop
    ld hl, wKeyWorldAreaExits
    ldh a, [hTemp7]
    dec a
    jr z, .next2
    ld b, a
    ld c, $00

.loop2:
    push bc
    push hl
    ld de, wKeyWorldAreas
    ld b, $00
    xor a
    ldh [hTemp0], a

.loop3:
    push bc
    ld a, [de]
    cp $ff
    jr z, .next
    cp $fe
    jr z, .next
    swap a
    and $0f
    cp c
    jr nz, .skip
    ldh a, [hTemp0]
    ld c, a
    ld a, [de]
    and $0f
    cp c
    jr c, .next
    ldh [hTemp0], a
    ld a, b
    ldh [hTemp1], a
    jr .next

.skip:
    dec a
    cp c
    jr nz, .next
    ld a, [de]
    and $0f
    jr nz, .next
    ld a, b
    ldh [hTemp2], a

.next:
    inc de
    pop bc
    inc b
    ld a, b
    cp $04
    jr nz, .loop3
    call PlaceTwoRandomOpenCells
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    pop bc
    inc c
    dec b
    jr nz, .loop2

.next2:
    inc hl
    inc hl
    inc hl
    ld [hl], $ff
    ret

SECTION "Bank 60 PlaceTwoRandomOpenCells", ROMX

; Draws two cells for one area exit entry and writes them as (x << 4) | y at HL and HL + 1; HL ends
; at the old HL + 2. hTemp1 and hTemp2 = the chunk slots (0-3) of the two areas: slot s covers x = 4
; x (s & 1) + 0..3 and y = 4 x (s >> 1) + 0..3. Each cell is drawn (y first, then x, with
; wKeyRandomHi & 3) until CheckKeyWorldCellIsOpen gives A = 1; the first cell is also drawn again
; while it equals the byte three before HL (the second cell of the previous exit entry). Uses hTemp3
; and hTemp4. (C2, E-0384)
; picks two random open cells (CheckKeyWorldCellIsOpen) in the areas named by hTemp1 and hTemp2,
; avoiding the previous cell, and stores their positions (E-0129)
PlaceTwoRandomOpenCells::
    ldh a, [hTemp1]
    and $fe
    add a
    ldh [hTemp4], a
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $03
    ld c, a
    ldh a, [hTemp4]
    or c
    ldh [hTemp4], a
    ldh a, [hTemp1]
    and $01
    add a
    add a
    ldh [hTemp3], a
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $03
    ld c, a
    ldh a, [hTemp3]
    or c
    ldh [hTemp3], a
    call CheckKeyWorldCellIsOpen
    or a
    jr z, PlaceTwoRandomOpenCells
    ldh a, [hTemp3]
    and $0f
    swap a
    ld c, a
    ldh a, [hTemp4]
    and $0f
    or c
    ld [hl], a
    ld c, a
    push hl
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    cp c
    jr nz, .check_temp2
    pop hl
    jr PlaceTwoRandomOpenCells

.check_temp2:
    pop hl
    inc hl

.loop:
    ldh a, [hTemp2]
    and $fe
    add a
    ldh [hTemp4], a
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $03
    ld c, a
    ldh a, [hTemp4]
    or c
    ldh [hTemp4], a
    ldh a, [hTemp2]
    and $01
    add a
    add a
    ldh [hTemp3], a
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $03
    ld c, a
    ldh a, [hTemp3]
    or c
    ldh [hTemp3], a
    call CheckKeyWorldCellIsOpen
    or a
    jr z, .loop
    ldh a, [hTemp3]
    and $0f
    swap a
    ld c, a
    ldh a, [hTemp4]
    and $0f
    or c
    ld [hli], a
    ret

SECTION "Bank 60 CheckKeyWorldCellIsOpen", ROMX

; Input hTemp3 = x, hTemp4 = y of a cell of the key world (x and y are 0-15, as in the (x << 4) | y
; cell bytes). Slot (y / 4) x 2 + x / 4 of wKeyWorldChunks (4 bytes: address low and high, bank,
; sub-chunk number) names a chunk; the 3-byte record of the cell is at address + $60 x sub-chunk +
; 12 x (y & 3) + 3 x (x & 3) in that bank, and gives the address and bank of a screen record.
; Returns A = 1 when the first byte of that screen record is not $FF and A = 0 when it is $FF. HL is
; kept; B, C, D and E are changed. The callers place exits and objects only on cells that return 1,
; so the name reads the wrong way round. (C2, E-0384)
; reads the cell at (hTemp3, hTemp4) from the area map chunk in wKeyWorldChunks; A = 1 when its byte
; is not $FF, else 0 (E-0128)
CheckKeyWorldCellIsOpen::
    push hl
    ldh a, [hTemp4]
    and $fc
    add a
    ld l, a
    ld h, $00
    ldh a, [hTemp3]
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
    ldh a, [hTemp4]
    and $03
    ld c, a
    sla a
    add c
    sla a
    sla a
    add_a_to_hl
    ldh a, [hTemp3]
    and $03
    ld c, a
    sla a
    add c
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
    cp $ff
    jr nz, .done
    xor a
    pop hl
    ret

.done:
    ld a, $01
    pop hl
    ret

SECTION "Bank 60 GenerateKeyWorld_EmptyStep", ROMX

; An empty step of GenerateKeyWorld (called between KeyWorldLayout_PlaceAreaExits and
; KeyWorldLayout_NumberCellsAndPlaceEntrances): only a ret. (C2, E-0369; probed E-0384)
GenerateKeyWorld_EmptyStep::
    ret

SECTION "Bank 60 KeyWorldLayout_SetEntranceFlags", ROMX

; Sets the menu flag of each floor entrance of kind 4 or 5 ($FF ends the list): floor state 1 gives
; $80, state 2 nothing, otherwise a random 0-99 below 5 gives state 3 and $81, below 30 state 1 and
; $80, else a flag from a random entry of a 64-byte table. (C2, E-0357; probed E-0384)
KeyWorldLayout_SetEntranceFlags::
    ld hl, wKeyWorldMenuFlag
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ld hl, wKeyWorldFloorInfo + $3
    ld de, wKeyWorldFloorState + $3

.skip:
    ld a, [hl]
    cp $ff
    ret z
    push hl
    dec hl
    dec hl
    ld a, [hl]
    cp $04
    jr z, .skip2
    cp $05
    jr z, .skip2
    jr .read_temp03

.skip2:
    ld a, [de]
    dec a
    jr z, .read_temp0
    dec a
    jr z, .read_temp03

.loop:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $7f
    cp $64
    jr nc, .loop
    cp $05
    jr nc, .cp_1E
    ld a, $03
    ld [de], a
    jr .read_temp02

.cp_1E:
    cp $1e
    jr nc, .call_next_random_seed
    ld a, $01
    ld [de], a
    jr .read_temp0

.call_next_random_seed:
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and $3f
    ld hl, KeyWorldLayout_SetEntranceFlags_Data
    add_a_to_hl
    ld a, [hl]
    push af
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    pop af
    ld [hl], a
    jr .read_temp03

.read_temp0:
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld [hl], $80
    jr .read_temp03

.read_temp02:
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld [hl], $81

.read_temp03:
    ldh a, [hTemp0]
    add $01
    ldh [hTemp0], a
    ldh a, [hTemp1]
    adc $00
    ldh [hTemp1], a
    pop hl
    ld a, $04
    add_a_to_hl
    ld a, $10
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    jp .skip

; Sixty-four flag bytes, indexed by wKeyRandomLo AND $3F: $40-$53, $5A-$61, repeated, with the first
; eight values ($40-$47) again at the end, so every flag value has about the same chance.
; KeyWorldLayout_SetEntranceFlags stores the chosen byte in the matching slot of wKeyWorldMenuFlag
; for a floor entrance of kind 4 or 5 whose random roll (0-99) did not give the fixed flags $80 or
; $81. (C1, E-0381)
KeyWorldLayout_SetEntranceFlags_Data::
    db $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4a, $4b, $4c, $4d, $4e, $4f
    db $50, $51, $52, $53, $5a, $5b, $5c, $5d, $5e, $5f, $60, $61, $40, $41, $42, $43
    db $44, $45, $46, $47, $48, $49, $4a, $4b, $4c, $4d, $4e, $4f, $50, $51, $52, $53
    db $5a, $5b, $5c, $5d, $5e, $5f, $60, $61, $40, $41, $42, $43, $44, $45, $46, $47

; With more than one area, numbers the areas' cells one after another; then places the floor
; entrances (their number from the area count's entry in KeyWorldAreaLayoutTable_Bank60, bank $84)
; spread evenly over the cells into wKeyWorldFloorInfo (PlaceObjectInAreaC); A = 0 when all fit,
; otherwise non-zero, which makes GenerateKeyWorld generate the layout again. (C2, E-0357; probed
; E-0384)
KeyWorldLayout_NumberCellsAndPlaceEntrances::
    ldh a, [hTemp7]
    cp $01
    jr z, .read_key_world_area_count
    ld e, a
    ld b, $00
    xor a
    ldh [hTemp0], a

.loop:
    xor a
    ldh [hTemp1], a
    ld hl, wKeyWorldAreas
    ld c, $04

.loop2:
    ld a, [hl]
    cp $ff
    jr z, .next
    cp $fe
    jr z, .next
    swap a
    and $0f
    cp b
    jr nz, .next
    ldh a, [hTemp0]
    ld d, a
    ld a, [hl]
    and $0f
    add d
    ld [hl], a
    ldh a, [hTemp1]
    inc a
    ldh [hTemp1], a

.next:
    inc hl
    dec c
    jr nz, .loop2
    ldh a, [hTemp0]
    ld c, a
    ldh a, [hTemp1]
    add c
    ldh [hTemp0], a
    inc b
    ld a, b
    cp e
    jr nz, .loop

.read_key_world_area_count:
    ld a, [wKeyWorldAreaCount]
    sla a
    ld hl, KeyWorldAreaLayoutTable_Bank60
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    push bc
    ld b, $84
    call ReadByteInBank
    ld a, c
    ldh [hTemp5], a
    pop bc
    ld c, $00
    ld a, [wKeyWorldHeight]
    dec a
    srl a
    srl a
    inc a
    ld b, a

.loop3:
    ld a, [wKeyWorldWidth]
    dec a
    srl a
    srl a
    inc a
    add c
    ld c, a
    dec b
    jr nz, .loop3
    ldh a, [hTemp5]
    ld h, a
    ld l, $00
    ld a, c
    call DivideHLByA
    inc hl
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ld hl, $0000
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    ld hl, wKeyWorldFloorInfo
    ld a, l
    ldh [hTemp8], a
    ld a, h
    ldh [hTemp9], a
    inc hl
    inc hl
    inc hl
    ld [hl], $ff
    ld b, $00
    ld c, $00

.read_temp2:
    ldh a, [hTemp2]
    ld l, a
    ldh a, [hTemp3]
    ld h, a
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    add hl, de

.skip:
    ld a, h
    or a
    jr nz, .call_place_object_in_area_c
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    inc c
    jr .read_temp2

.call_place_object_in_area_c:
    push hl
    push bc
    call PlaceObjectInAreaC
    or a
    jr nz, .done
    pop bc
    pop hl
    inc b
    ldh a, [hTemp5]
    cp b
    jr z, .return_0
    dec h
    jr .skip

.return_0:
    xor a
    ret

.done:
    pop bc
    pop hl
    ret

SECTION "Bank 60 PlaceObjectInAreaC", ROMX

; C = a cell number: the number a slot of wKeyWorldAreas got in
; KeyWorldLayout_NumberCellsAndPlaceEntrances. Finds the slot B whose wKeyWorldAreas byte equals C
; (none: A = 0 and nothing changes), then draws a cell inside that slot (y, then x, with
; wKeyRandomHi & 3 on the slot origin) until CheckKeyWorldCellIsOpen gives 1 and the cell is not one
; of the cells of the area exit list wKeyWorldAreaExits or of an earlier wKeyWorldFloorInfo entry.
; It appends an entry to wKeyWorldFloorInfo at hTemp8/hTemp9: byte 0 = the cell as (x << 4) | y,
; byte 1 = the byte at offset 1 + 16 x B of the layout record for wKeyWorldAreaCount in bank $84
; (KeyWorldAreaLayoutTable_Bank60), byte 3 = 0, then $FF after the entry, and returns A = 0. After
; 100 refused draws it returns A = 1. (C2, E-0384)
; finds area C in wKeyWorldAreas and picks a random free cell inside it for the object (avoiding
; wKeyWorldObjects and wKeyWorldFloorInfo + $3 entries) (E-0131)
PlaceObjectInAreaC::
    push bc
    xor a
    ldh [hTempA], a
    ld hl, wKeyWorldAreas
    ld b, $00

.loop:
    ld a, [hli]
    cp $ff
    jr z, .next
    cp $fe
    jr z, .next
    cp c
    jr z, .read_temp3

.next:
    inc b
    ld a, b
    cp $04
    jr nz, .loop
    pop bc
    xor a
    ret

.read_temp3:
    ldh a, [hTemp3]
    ldh [hTemp6], a

.loop2:
    ld a, b
    srl a
    add a
    add a
    ld c, a
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $03
    add c
    ldh [hTemp4], a
    ld a, b
    and $01
    add a
    add a
    ld c, a
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $03
    add c
    ldh [hTemp3], a
    ldh a, [hTemp3]
    and $0f
    swap a
    ld c, a
    ldh a, [hTemp4]
    and $0f
    or c
    ld c, a
    ld hl, wKeyWorldObjects

.skip:
    ld a, [hl]
    cp $ff
    jr z, .skip2
    dec hl
    dec hl
    ld a, [hl]
    cp c
    jr z, .check_temp_a
    dec hl
    ld a, [hl]
    cp c
    jr z, .check_temp_a
    ld a, $07
    add_a_to_hl
    jr .skip

.skip2:
    ld hl, wKeyWorldFloorInfo + $3

.skip3:
    ld a, [hl]
    cp $ff
    jr z, .call_check_key_world_cell_is_open
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    cp c
    jr z, .check_temp_a
    ld a, $07
    add_a_to_hl
    jr .skip3

.call_check_key_world_cell_is_open:
    push bc
    call CheckKeyWorldCellIsOpen
    pop bc
    or a
    jr z, .check_temp_a
    ldh a, [hTemp8]
    ld l, a
    ldh a, [hTemp9]
    ld h, a
    ldh a, [hTemp3]
    and $0f
    swap a
    ld c, a
    ldh a, [hTemp4]
    and $0f
    or c
    ld [hli], a
    pop bc
    push hl
    ld a, [wKeyWorldAreaCount]
    sla a
    ld hl, KeyWorldAreaLayoutTable_Bank60
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    inc de
    pop hl
    ld a, b
    swap a
    add e
    ld e, a
    jr nc, .call_read_byte_in_bank
    inc d

.call_read_byte_in_bank:
    push bc
    ld b, $84
    call ReadByteInBank
    ld a, c
    ld [hli], a
    pop bc
    inc hl
    xor a
    ld [hli], a
    ld a, l
    ldh [hTemp8], a
    ld a, h
    ldh [hTemp9], a
    inc hl
    inc hl
    inc hl
    ld [hl], $ff
    ldh a, [hTemp6]
    ldh [hTemp3], a
    xor a
    ret

.check_temp_a:
    ldh a, [hTempA]
    inc a
    ldh [hTempA], a
    cp $64
    jp nz, .loop2
    pop bc
    ld a, $01
    ret

SECTION "Bank 60 GenerateKeyWorld_PlaceObjects", ROMX

; Places the key world's objects: the band from the party strength (SetKeyWorldBandForA on
; wPartyStrength) picks the object count (wMapObjectCount: 10, 15 or 20 from the 16-byte table after
; it); each object in wMapObjects (8 bytes each) gets a kind (RollKeyWorldObjectKind) and a random
; free cell (PlaceKeyWorldObjectAtRandomCell). When one cannot be placed the count is cut to those
; placed; when none were placed it starts again with wKeyWorldBand = 0 (10 objects). (C2, E-0369;
; probed E-0384)
GenerateKeyWorld_PlaceObjects::
    ld a, [wPartyStrength]
    call SetKeyWorldBandForA

.loop:
    ld [wKeyWorldBand], a
    ld hl, GenerateKeyWorld_PlaceObjects_Data
    add_a_to_hl
    ld a, [hl]
    ld [wMapObjectCount], a
    ld b, a
    ld de, wMapObjects

.loop2:
    push de
    push bc
    ld a, b
    ldh [hTemp0], a
    call RollKeyWorldObjectKind
    call PlaceKeyWorldObjectAtRandomCell
    or a
    jr nz, .read_map_object_count
    pop bc
    pop de
    ld a, $08
    add e
    ld e, a
    jr nc, .next
    inc d

.next:
    dec b
    jr nz, .loop2
    ret

.read_map_object_count:
    pop bc
    pop de
    ld a, [wMapObjectCount]
    sub b
    ld [wMapObjectCount], a
    jr z, .loop
    ret

SECTION "Bank 60 GenerateKeyWorld_PlaceObjects_Data", ROMX

; Sixteen bytes, one per key world band (wKeyWorldBand 0-15, set from wPartyStrength by
; SetKeyWorldBandForA): the number of map objects to place. Bands 0-7 give 10, bands 8-11 give 15
; and bands 12-15 give 20. GenerateKeyWorld_PlaceObjects stores the value in wMapObjectCount and
; places that many objects. (C1, E-0381)
GenerateKeyWorld_PlaceObjects_Data::
    db $0a, $0a, $0a, $0a, $0a, $0a, $0a, $0a, $0f, $0f, $0f, $0f, $14, $14, $14, $14

; A = a level or strength value. Returns A = the key world band and stores it in wKeyWorldBand: 0
; for A below $0B, $0F from $50 up, otherwise (A - $0A) / 5 + 1. (C2, E-0384)
; wKeyWorldBand = 0 for A < $0B, $0F for A >= $50, otherwise (A - $0A) / 5 + 1 (E-0124)
SetKeyWorldBandForA::
    cp $0b
    jr nc, .cp_50
    ld a, $00
    jr .set_key_world_band

.cp_50:
    cp $50
    jr c, .skip
    ld a, $0f
    jr .set_key_world_band

.skip:
    sub $0a
    ld l, a
    ld h, $00
    ld a, $05
    call DivideHLByA
    ld a, l
    inc a

.set_key_world_band:
    and $0f
    ld [wKeyWorldBand], a
    ret

SECTION "Bank 60 PlaceKeyWorldObjectAtRandomCell", ROMX

; Input DE = an entry of wMapObjects (8 bytes), hTemp0 = the number of objects still to place
; including this one (wMapObjectCount - hTemp0 entries are already placed). Zeroes
; wKeyWorldPlaceFlag, then draws x below wKeyWorldWidth and y below wKeyWorldHeight (wKeyRandomHi &
; $0F, redrawn until below), and rejects a cell equal to byte 4 of an earlier entry. It then reads
; byte 1-4 (random) of the screen record of the cell: when that is not $FF it stores the cell as (x
; << 4) | y at DE + 4 and that byte at DE + 5 and returns A = 0. Each rejection adds one to
; wKeyWorldPlaceFlag; after 100 it gives up with A = 1. After a gold roll of RollKeyWorldObjectKind
; hTemp0 no longer holds the object count, so the number of earlier entries it compares is then
; wrong. (C2, E-0384)
; picks a random open cell within wKeyWorldWidth x wKeyWorldHeight not used by another object and
; stores it for object hTemp0 (E-0130)
PlaceKeyWorldObjectAtRandomCell::
    xor a
    ld [wKeyWorldPlaceFlag], a
    push de

.loop:
    ld a, [wKeyWorldWidth]
    ld c, a

.loop2:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $0f
    cp c
    jr nc, .loop2
    ldh [hTemp3], a
    ld a, [wKeyWorldHeight]
    ld c, a

.loop3:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $0f
    cp c
    jr nc, .loop3
    ldh [hTemp4], a
    ldh a, [hTemp3]
    swap a
    ld c, a
    ldh a, [hTemp4]
    or c
    ldh [hTemp5], a
    ld c, a
    ldh a, [hTemp0]
    ld b, a
    ld a, [wMapObjectCount]
    sub b
    jr z, .check_temp4
    ld b, a
    ld hl, wMapObjects + $4

.loop4:
    ld a, [hl]
    cp c
    jp z, .check_key_world_place_flag
    ld a, $08
    add_a_to_hl
    dec b
    jr nz, .loop4

.check_temp4:
    ldh a, [hTemp4]
    and $fc
    add a
    ld l, a
    ld h, $00
    ldh a, [hTemp3]
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
    ldh a, [hTemp4]
    and $03
    ld c, a
    add a
    add c
    add a
    add a
    add_a_to_hl
    ldh a, [hTemp3]
    and $03
    ld c, a
    add a
    add c
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
    ld a, [wKeyRandomHi]
    and $03
    inc a
    add_a_to_hl
    ld e, l
    ld d, h
    call ReadByteInBank
    ld a, c
    cp $ff
    jr z, .check_key_world_place_flag
    pop de
    inc de
    inc de
    inc de
    inc de
    inc de
    ld [de], a
    dec de
    ldh a, [hTemp5]
    ld [de], a
    ld a, $00
    ret

.check_key_world_place_flag:
    ld a, [wKeyWorldPlaceFlag]
    inc a
    ld [wKeyWorldPlaceFlag], a
    cp $64
    jp nz, .loop
    pop de
    ld a, $01
    ret

SECTION "Bank 60 RollKeyWorldObjectKind", ROMX

; DE = a wMapObjects entry. Rolls wKeyRandomHi & $7F until it is below 100 and walks the 64-byte row
; of RollKeyWorldObjectKind_Data for wKeyWorldBand (row start = label + $10 + 64 x band) to the
; first non-zero byte that is not below the roll; the position p of that byte decides: p = 0 stores
; kind 1 at [DE] and an amount at DE + 1 ((a draw below 100 x band + a digit 0-9 x band) / 10, at
; least 1); p = 1 stores kind 3; p of 2 or more stores kind 0 at [DE] and contents p - 2 at DE + 1
; (and then makes one more draw that is not used). A gold roll (p = 0) also leaves the 16-bit
; product of its first draw and the band in hTemp0 (low byte) and hTemp1, overwriting the hTemp0
; that the callers set for PlaceKeyWorldObjectAtRandomCell. Advances the seed. (C2, E-0384)
; picks an object kind for the key level band wKeyWorldBand from the chance rows at $556F and its
; contents ([DE + 1]) (E-0130)
RollKeyWorldObjectKind::
    ld a, [wKeyWorldBand]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, l
    add LOW(RollKeyWorldObjectKind_Data + $10)
    ld l, a
    ld a, h
    adc HIGH(RollKeyWorldObjectKind_Data + $10)
    ld h, a

.loop:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $7f
    cp $64
    jr nc, .loop
    ld c, a
    ld b, $00

.skip:
    ld a, [hli]
    or a
    jr z, .next
    cp c
    jr nc, .skip2

.next:
    inc b
    jr .skip

.skip2:
    ld a, b
    or a
    jr z, .read_key_world_band
    dec a
    jr z, .done
    inc de
    ld a, b
    dec a
    dec a
    ld [de], a
    dec de

.loop2:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $7f
    cp $64
    jr nc, .loop2
    ld c, a
    ld a, [wKeyWorldBand]
    ld hl, RollKeyWorldObjectKind_Data
    add_a_to_hl
    xor a
    ld [de], a
    ret
    db $3e, $02, $12, $c9

.read_key_world_band:
    ld a, $01
    ld [de], a
    ld a, [wKeyWorldBand]
    ld c, a

.loop3:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $7f
    cp $64
    jr nc, .loop3
    call Multiply8
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ld a, [wKeyWorldBand]
    ld c, a

.loop4:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $0f
    cp $0a
    jr nc, .loop4
    call Multiply8
    ldh a, [hTemp0]
    ld c, a
    ldh a, [hTemp1]
    ld b, a
    add hl, bc
    push de
    ld a, $0a
    call DivideHLByA
    pop de
    ld a, l
    or a
    jr nz, .next2
    ld a, $01

.next2:
    inc de
    ld [de], a
    dec de
    ret

.done:
    ld a, $03
    ld [de], a
    ret

SECTION "Bank 60 RollKeyWorldObjectKind_Data", ROMX

; A 1040-byte table: 16 zero bytes, then 16 rows of 64 bytes, one per key world band (row start =
; label + $10 + 64 * wKeyWorldBand). A row is a list of cumulative chances: RollKeyWorldObjectKind
; rolls 0-99 and takes the first nonzero byte at or above the roll, and the byte position in the row
; is the result: position 0 makes a gold object (kind 1, amount scaled by the band), position 1
; would make kind 3 (always 0 here), and position p from 2 up makes kind 0 with contents p - 2, an
; item id (position 3 is ITEM_HERB, $25 is ITEM_FRIEND). Each row ends in the chance $64 so a roll
; always matches, and the 16 leading bytes are never read. (C1, E-0381)
RollKeyWorldObjectKind_Data::
    ds $13, $00
    db $5e
    ds $21, $00
    db $5f, $00, $00, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $14, $00, $00, $45, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $46, $47, $00, $00, $00, $00, $00, $00, $00, $00, $5b, $5e, $00, $00, $00
    db $00, $00, $00, $00, $00, $5f, $00, $00, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $14, $00, $00, $45, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $46, $47, $00, $00, $00, $00, $00, $00, $00, $00, $56, $5b, $5e, $00, $00
    db $00, $00, $00, $00, $00, $5f, $00, $00, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $14, $00, $00, $39, $3d, $00, $00, $00, $3e, $3f, $40, $41, $42, $00, $43, $44
    db $45, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $4a, $54, $5c, $00, $00
    db $00, $00, $00, $00, $00, $5f, $00, $00, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $14, $00, $00, $2f, $39, $00, $3d, $00, $3e, $3f, $40, $41, $42, $00, $43, $44
    db $45, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $4a, $54, $5c, $00, $00
    db $00, $00, $00, $00, $00, $5f, $00, $00, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $14, $00, $00, $25, $34, $00, $3d, $00, $3e, $3f, $40, $41, $42, $00, $43, $00
    db $00, $00, $00, $44, $45, $00, $00, $00, $00, $00, $00, $46, $4e, $58, $59, $5a
    db $00, $00, $00, $00, $5b, $5e, $5f, $00, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $14, $00, $00, $1b, $2f, $00, $3d, $00, $3e, $3f, $40, $41, $42, $00, $43, $00
    db $00, $00, $00, $44, $45, $00, $00, $00, $00, $00, $00, $00, $4a, $58, $59, $5a
    db $00, $00, $00, $00, $5b, $5e, $5f, $00, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $14, $00, $00, $16, $2f, $00, $39, $3d, $3e, $3f, $40, $41, $42, $00, $43, $44
    db $45, $46, $47, $48, $49, $00, $00, $00, $00, $00, $00, $00, $00, $57, $58, $59
    db $00, $00, $00, $00, $5a, $5d, $5e, $5f, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $13, $00, $00, $00, $29, $2e, $38, $3c, $3d, $3e, $3f, $40, $41, $00, $42, $43
    db $44, $45, $46, $47, $48, $00, $00, $00, $00, $00, $00, $00, $00, $56, $57, $58
    db $00, $00, $59, $00, $5a, $5d, $5e, $5f, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $13, $00, $00, $00, $29, $2e, $32, $3c, $3d, $3e, $3f, $40, $41, $00, $42, $43
    db $44, $45, $46, $47, $48, $00, $00, $00, $00, $00, $00, $00, $00, $52, $57, $58
    db $00, $00, $59, $00, $5a, $5d, $5e, $5f, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $13, $00, $00, $00, $29, $2e, $32, $3c, $3d, $3e, $3f, $40, $41, $00, $42, $43
    db $44, $45, $46, $47, $48, $00, $00, $00, $00, $00, $00, $00, $00, $52, $57, $58
    db $00, $00, $59, $00, $5a, $5d, $00, $5f, $60, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $13, $00, $00, $00, $29, $2e, $32, $3c, $3d, $3e, $3f, $40, $41, $00, $42, $43
    db $44, $45, $46, $47, $48, $00, $00, $00, $00, $00, $00, $00, $00, $52, $57, $58
    db $00, $00, $59, $00, $5a, $5d, $00, $00, $5e, $5f, $61, $62, $63, $00, $64
    ds $11, $00
    db $13, $00, $00, $00, $29, $2e, $32, $3c, $3d, $3e, $3f, $40, $41, $00, $42, $43
    db $44, $45, $46, $47, $48, $00, $00, $00, $00, $00, $00, $00, $00, $52, $57, $58
    db $00, $00, $59, $00, $5a, $5d, $00, $00, $5e, $5f, $61, $62, $63, $00, $64
    ds $11, $00
    db $13, $00, $00, $00, $29, $2e, $32, $3c, $3d, $3e, $3f, $40, $41, $00, $42, $43
    db $44, $45, $46, $47, $48, $00, $00, $00, $00, $00, $00, $00, $00, $52, $57, $58
    db $00, $00, $59, $00, $5a, $5d, $00, $00, $5e, $5f, $61, $62, $63, $00, $64
    ds $11, $00
    db $13, $00, $00, $00, $29, $2e, $32, $3c, $3d, $3e, $3f, $40, $41, $00, $42, $43
    db $44, $45, $46, $47, $48, $00, $00, $00, $00, $00, $00, $00, $00, $52, $57, $58
    db $00, $00, $59, $00, $5a, $5d, $00, $00, $5e, $5f, $61, $62, $63, $00, $64
    ds $11, $00
    db $13, $00, $00, $00, $29, $2e, $32, $3c, $3d, $3e, $3f, $40, $41, $00, $42, $43
    db $44, $45, $46, $47, $48, $00, $00, $00, $00, $00, $00, $00, $00, $52, $57, $58
    db $00, $00, $59, $00, $5a, $5d, $00, $00, $5e, $5f, $61, $62, $63, $00, $64
    ds $11, $00

; Rolls a screen trigger's contents for the band: a random 0-99 against the band's cumulative chance
; row (64 bytes per band) picks the kind, then further rolls (scaled by the band) its amount,
; written at DE. (C2, E-0357; probed E-0384)
FieldState_MapTransition_RollTriggerContents::
    ld a, [wKeyWorldBand]
    and $0f
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, l
    add LOW(FieldState_MapTransition_RollTriggerContents_Data + $10)
    ld l, a
    ld a, h
    adc HIGH(FieldState_MapTransition_RollTriggerContents_Data + $10)
    ld h, a

.loop:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $7f
    cp $64
    jr nc, .loop
    ld c, a
    ld b, $00

.skip:
    ld a, [hli]
    or a
    jr z, .next
    cp c
    jr nc, .skip2

.next:
    inc b
    jr .skip

.skip2:
    ld a, b
    or a
    jr z, .read_key_world_band
    dec a
    jr z, .done2
    inc de
    ld a, b
    dec a
    dec a
    ld [de], a
    dec de

.loop2:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $7f
    cp $64
    jr nc, .loop2
    ld c, a
    ld a, [wKeyWorldBand]
    ld hl, FieldState_MapTransition_RollTriggerContents_Data
    add_a_to_hl
    ld a, [hl]
    cp c
    jr nc, .done
    xor a
    ld [de], a
    ret

.done:
    ld a, $02
    ld [de], a
    ret

.read_key_world_band:
    ld a, $01
    ld [de], a
    ld a, [wKeyWorldBand]
    ld c, a

.loop3:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $7f
    cp $64
    jr nc, .loop3
    call Multiply8
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ld a, [wKeyWorldBand]
    ld c, a

.loop4:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $0f
    cp $0a
    jr nc, .loop4
    call Multiply8
    ldh a, [hTemp0]
    ld c, a
    ldh a, [hTemp1]
    ld b, a
    add hl, bc
    push de
    ld a, $0a
    call DivideHLByA
    pop de
    ld a, l
    or a
    jr nz, .next2
    ld a, $01

.next2:
    inc de
    ld [de], a
    dec de
    ret

.done2:
    ld a, $03
    ld [de], a
    ret

SECTION "Bank 60 FieldState_MapTransition_RollTriggerContents_Data", ROMX

; A 1040-byte table plus a 25-byte tail: 16 zero bytes, then 16 rows of 64 bytes, one per key world
; band (row start = label + $10 + 64 * wKeyWorldBand). Each row is a list of cumulative chances in
; the same format as RollKeyWorldObjectKind_Data: position 0 gives gold (kind 1), position 1 kind 3,
; position p from 2 gives contents p - 2 (an item id; the rows hold $0F-$14 at position 0 and end in
; $64). FieldState_MapTransition_RollTriggerContents also reads the leading byte for the band (all
; zeros here) as a percent chance to write kind 2 instead of kind 0, so kind 2 only happens on a
; roll of 0. (C1, E-0381)
FieldState_MapTransition_RollTriggerContents_Data::
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
    db $4b, $50, $55, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $56
    db $57, $64
    ds $13, $00
    db $14, $19, $00, $37, $3c, $00, $00, $00, $3d, $3e, $3f, $40, $41, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $46, $50, $55, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $56, $57, $64
    ds $13, $00
    db $14, $19, $00, $2d, $37, $00, $3c, $00, $3d, $3e, $3f, $40, $41, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $46, $4b, $55, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $56, $57, $64
    ds $13, $00
    db $14, $19, $00, $23, $32, $00, $3c, $00, $3d, $3e, $3f, $40, $41, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $46, $50, $00, $55
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $56, $57, $64
    ds $13, $00
    db $14, $19, $00, $23, $32, $00, $3c, $00, $3d, $3e, $3f, $40, $41, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $46, $50, $00, $55
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $56, $57, $64
    ds $13, $00
    db $14, $19, $00, $23, $32, $00, $3c, $00, $3d, $3e, $3f, $40, $41, $00, $00, $00
    db $00, $49, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $50, $00, $55
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $56, $57, $64
    ds $13, $00
    db $0f, $19, $00, $1e, $2d, $32, $3c, $00, $3d, $3e, $3f, $40, $41
    ds $10, $00
    db $50, $55, $5a, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $5b, $5c, $64
    ds $13, $00
    db $0f, $19, $00, $1e, $2d, $32, $3c, $00, $3d, $3e, $3f, $40, $41
    ds $10, $00
    db $50, $55, $5a, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $5b, $5c, $64
    ds $13, $00
    db $0f, $19, $00, $1e, $2d, $32, $3c, $00, $3d, $3e, $3f, $40, $41
    ds $10, $00
    db $50, $55, $5a, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $5b, $5c, $64
    ds $13, $00
    db $0f, $19, $00, $1e, $2d, $32, $3c, $00, $3d, $3e, $3f, $40, $41
    ds $10, $00
    db $50, $55, $5a, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $5b, $5c, $64
    ds $13, $00
    db $0f, $19, $00, $1e, $2d, $32, $3c, $00, $3d, $3e, $3f, $40, $41
    ds $10, $00
    db $50, $55, $5a, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $5b, $5c, $64
    ds $13, $00
    db $0f, $19, $00, $1e, $2d, $32, $3c, $00, $3d, $3e, $3f, $40, $41
    ds $10, $00
    db $50, $55, $5a, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $5b, $5c, $64
    ds $13, $00
    db $0f, $19, $00, $1e, $2d, $32, $3c, $00, $3d, $3e, $3f, $40, $41
    ds $10, $00
    db $50, $55, $5a, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $5b, $5c, $64
    ds $13, $00
    db $0f, $19, $00, $1e, $2d, $32, $3c, $00, $3d, $3e, $3f, $40, $41
    ds $10, $00
    db $50, $55, $5a, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $5b, $5c, $64
    ds $13, $00
    db $06, $08, $0e, $34, $1e, $00, $f5, $cd, $80, $1f, $f0, $c6, $fe, $ff, $28, $07
    db $f1, $0c, $1c, $05, $20, $f0, $c9, $f1, $c9

; The goal: wKeyWorldGoalScreen = the first floor entrance's screen; reads that screen's chunk and
; takes the goal position from the table by its first byte (a byte of $FF hangs in an endless loop).
; (C2, E-0357; probed E-0384)
KeyWorldLayout_PlaceGoal::
    ld a, [wKeyWorldFloorInfo]
    ld [wKeyWorldGoalScreen], a
    swap a
    and $0f
    ldh [hTemp3], a
    ld a, [wKeyWorldFloorInfo]
    and $0f
    ldh [hTemp4], a
    ldh a, [hTemp4]
    and $fc
    add a
    ld l, a
    ld h, $00
    ldh a, [hTemp3]
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
    ldh a, [hTemp4]
    and $03
    ld c, a
    sla a
    add c
    sla a
    sla a
    add_a_to_hl
    ldh a, [hTemp3]
    and $03
    ld c, a
    sla a
    add c
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
    cp $ff
    jr nz, .skip2

.skip:
    jr .skip

.skip2:
    sla a
    ld hl, KeyWorldLayout_PlaceGoal_Data
    add_a_to_hl
    ld a, [hli]
    ld [wKeyWorldGoalPos], a
    ld a, [hl]
    ld [wKeyWorldGoalPos2], a
    ret

SECTION "Bank 60 KeyWorldLayout_PlaceGoal_Data", ROMX

; Eight pairs of position bytes (16 bytes), indexed by the first byte of the goal screen record read
; through ReadByteInBank (0-7). KeyWorldLayout_PlaceGoal copies the pair into wKeyWorldGoalPos and
; wKeyWorldGoalPos2; the marker drawing code in bank $84 uses only the high nibble of each:
; ($10,$10), ($10,$60), ($40,$20), ($40,$60), ($50,$20), ($50,$60), ($70,$30), ($80,$70). (C1,
; E-0381)
KeyWorldLayout_PlaceGoal_Data::
    db $10, $10, $10, $60, $40, $20, $40, $60, $50, $20, $50, $60, $70, $30, $80, $70

; One step of GenerateKeyWorld_FillChunkSlots for an empty chunk slot: advances the seed and picks
; an entry of a 16-entry jumptable by wKeyRandomHi & $0F. Entries 0, 6 and 12 run
; RunRandomPatternCase_SingleChunk, 1, 5, 7, 11 and 13 RunRandomPatternCase_TallBlock, 2, 4, 8, 10
; and 14 RunRandomPatternCase_WideBlock, and 3, 9 and 15 RunRandomPatternCase_Block2x2. B = the slot
; number (0-3) and hTemp0/hTemp1 and hTemp5/hTemp6 point into the slot table and wKeyWorldAreas, as
; the fill loop sets them. Returns the A of the pattern routine: 1 = the chunks were placed, 0 = the
; pattern did not fit. (C2, E-0384)
; runs one of four routines chosen by random & $0F through a 16-entry table (E-0124)
RunRandomPatternCase::
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $0f
    jumptable
    dw RunRandomPatternCase_SingleChunk
    dw RunRandomPatternCase_TallBlock
    dw RunRandomPatternCase_WideBlock
    dw RunRandomPatternCase_Block2x2
    dw RunRandomPatternCase_WideBlock
    dw RunRandomPatternCase_TallBlock
    dw RunRandomPatternCase_SingleChunk
    dw RunRandomPatternCase_TallBlock
    dw RunRandomPatternCase_WideBlock
    dw RunRandomPatternCase_Block2x2
    dw RunRandomPatternCase_WideBlock
    dw RunRandomPatternCase_TallBlock
    dw RunRandomPatternCase_SingleChunk
    dw RunRandomPatternCase_TallBlock
    dw RunRandomPatternCase_WideBlock
    dw RunRandomPatternCase_Block2x2
    db $c9, $c9

; Chunk pattern 3, a 2 x 2 block: only in an even left column with the three other slots free; picks
; one of 32 patterns, fills the four slots (0-3) and writes the area's cells. (C2, E-0357; probed
; E-0384)
RunRandomPatternCase_Block2x2::
    ld a, b
    and $01
    cp $01
    jr nz, .skip

.loop:
    xor a
    ret

.skip:
    ld a, b
    cp $02
    jr c, .read_temp0
    xor a
    ret

.read_temp0:
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, $04
    add_a_to_hl
    ld a, [hl]
    cp $fe
    jr z, .loop
    cp $ff
    jr nz, .loop
    ld a, $08
    add_a_to_hl
    ld a, [hl]
    cp $fe
    jr z, .loop
    ld a, l
    sub $04
    ld l, a
    ld a, h
    sbc $00
    ld h, a
    ld a, [hl]
    cp $fe
    jr z, .loop
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $1f
    ld c, a
    add a
    add c
    ld de, RunRandomPatternCase_Block2x2_Data
    add e
    ld e, a
    jr nc, .call_store_three_bytes_before_temp0_pointer
    inc d

.call_store_three_bytes_before_temp0_pointer:
    call StoreThreeBytesBeforeTemp0Pointer
    ld [hl], $00
    ld hl, $0004
    call StoreTemp2To3BytesBeforeHLPlusTemp0
    ld [hl], $01
    ld hl, $0008
    call StoreTemp2To3BytesBeforeHLPlusTemp0
    ld [hl], $02
    ld hl, $000c
    call StoreTemp2To3BytesBeforeHLPlusTemp0
    ld [hl], $03
    ldh a, [hTemp7]
    swap a
    and $f0
    ldh [hTempA], a
    ldh a, [hTemp2]
    ld e, a
    ldh a, [hTemp3]
    ld d, a
    ld a, e
    add $80
    ld e, a
    ld a, d
    adc $01
    ld d, a
    ldh a, [hTemp4]
    ld b, a
    call ReadByteInBank
    ldh a, [hTemp5]
    ld l, a
    ldh a, [hTemp6]
    ld h, a
    ldh a, [hTempA]
    or c
    ld [hl], a
    inc de
    call ReadByteInBank
    inc hl
    ldh a, [hTempA]
    or c
    ld [hl], a
    inc de
    call ReadByteInBank
    inc hl
    ldh a, [hTempA]
    or c
    ld [hl], a
    inc de
    call ReadByteInBank
    inc hl
    ldh a, [hTempA]
    or c
    ld [hl], a
    ld a, $01
    ret

SECTION "Bank 60 RunRandomPatternCase_WideBlock", ROMX

; Chunk pattern 2, a block two wide: only in an even column with the slot to the right free; picks
; one of 32, fills both slots and the area's cells. (C2, E-0357; probed E-0384)
RunRandomPatternCase_WideBlock::
    ld a, b
    and $01
    cp $01
    jr nz, .read_temp0

.loop:
    xor a
    ret

.read_temp0:
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, $04
    add_a_to_hl
    ld a, [hl]
    cp $fe
    jr z, .loop
    cp $ff
    jr nz, .loop
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $1f
    ld c, a
    sla a
    add c
    ld de, RunRandomPatternCase_WideBlock_Data
    add e
    ld e, a
    jr nc, .call_store_three_bytes_before_temp0_pointer
    inc d

.call_store_three_bytes_before_temp0_pointer:
    call StoreThreeBytesBeforeTemp0Pointer
    ld [hl], $00
    ld hl, $0004
    call StoreTemp2To3BytesBeforeHLPlusTemp0
    ld [hl], $01
    ldh a, [hTemp7]
    swap a
    and $f0
    ldh [hTempA], a
    ldh a, [hTemp2]
    ld e, a
    ldh a, [hTemp3]
    ld d, a
    ld a, e
    add $c0
    ld e, a
    ld a, d
    adc $00
    ld d, a
    ldh a, [hTemp4]
    ld b, a
    call ReadByteInBank
    ldh a, [hTemp5]
    ld l, a
    ldh a, [hTemp6]
    ld h, a
    ldh a, [hTempA]
    or c
    ld [hl], a
    inc de
    call ReadByteInBank
    inc hl
    ldh a, [hTempA]
    or c
    ld [hl], a
    ld a, $01
    ret

SECTION "Bank 60 RunRandomPatternCase_TallBlock", ROMX

; Chunk pattern 1, a block two tall: only in the top row with the slot below free; picks one of 32,
; fills both slots and the area's cells. (C2, E-0357; probed E-0384)
RunRandomPatternCase_TallBlock::
    ld a, b
    cp $02
    jr c, .read_temp0

.loop:
    xor a
    ret

.read_temp0:
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, $08
    add_a_to_hl
    ld a, [hl]
    cp $fe
    jr z, .loop
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $1f
    ld c, a
    sla a
    add c
    ld de, RunRandomPatternCase_TallBlock_Data
    add e
    ld e, a
    jr nc, .call_store_three_bytes_before_temp0_pointer
    inc d

.call_store_three_bytes_before_temp0_pointer:
    call StoreThreeBytesBeforeTemp0Pointer
    ld [hl], $00
    ld hl, $0008
    call StoreTemp2To3BytesBeforeHLPlusTemp0
    ld [hl], $01
    ldh a, [hTemp7]
    swap a
    and $f0
    ldh [hTempA], a
    ldh a, [hTemp2]
    ld e, a
    ldh a, [hTemp3]
    ld d, a
    ld a, e
    add $c0
    ld e, a
    ld a, d
    adc $00
    ld d, a
    ldh a, [hTemp4]
    ld b, a
    call ReadByteInBank
    ldh a, [hTemp5]
    ld l, a
    ldh a, [hTemp6]
    ld h, a
    ldh a, [hTempA]
    or c
    ld [hl], a
    inc de
    call ReadByteInBank
    inc hl
    inc hl
    ldh a, [hTempA]
    or c
    ld [hl], a
    ld a, $01
    ret

SECTION "Bank 60 RunRandomPatternCase_SingleChunk", ROMX

; Chunk pattern 0, a single chunk: one of 32 from KeyWorldChunkLists into the slot, and the area's
; cell. (C2, E-0357; probed E-0384)
RunRandomPatternCase_SingleChunk::
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and $1f
    ld c, a
    sla a
    add c
    ld de, KeyWorldChunkLists
    add e
    ld e, a
    jr nc, .call_store_three_bytes_before_temp0_pointer
    inc d

.call_store_three_bytes_before_temp0_pointer:
    call StoreThreeBytesBeforeTemp0Pointer
    ld [hl], $00
    ldh a, [hTemp7]
    swap a
    and $f0
    ldh [hTempA], a
    ldh a, [hTemp2]
    ld e, a
    ldh a, [hTemp3]
    ld d, a
    ld a, e
    add $60
    ld e, a
    ld a, d
    adc $00
    ld d, a
    ldh a, [hTemp4]
    ld b, a
    call ReadByteInBank
    ldh a, [hTemp5]
    ld l, a
    ldh a, [hTemp6]
    ld h, a
    ldh a, [hTempA]
    or c
    ld [hl], a
    ld a, $01
    ret

SECTION "Bank 60 StoreThreeBytesBeforeTemp0Pointer", ROMX

; DE = 3 source bytes. Copies them to the three bytes just before the address in hTemp0/hTemp1 and
; also into hTemp2, hTemp3 and hTemp4; on return HL = the address in hTemp0/hTemp1 and DE points at
; the last source byte. The chunk pattern routines use it to store a far pointer (address, bank) in
; a slot of wKeyWorldChunks. (C2, E-0384)
; copies three bytes at DE to the address in hTemp0/hTemp1 minus 3 and to hTemp2-hTemp4 (E-0121)
StoreThreeBytesBeforeTemp0Pointer::
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    dec hl
    dec hl
    dec hl
    ld a, [de]
    inc de
    ld [hli], a
    ldh [hTemp2], a
    ld a, [de]
    inc de
    ld [hli], a
    ldh [hTemp3], a
    ld a, [de]
    ld [hli], a
    ldh [hTemp4], a
    ret

SECTION "Bank 60 StoreTemp2To3BytesBeforeHLPlusTemp0", ROMX

; HL = HL + the word hTemp0/hTemp1, then stores hTemp2, hTemp3 and hTemp4 at the three bytes before
; the new HL; HL is left at the sum. The block patterns use it to copy the same far pointer into the
; other slots (HL = 4, 8 or $0C past the first slot byte). (C2, E-0384)
; HL += the word hTemp0/hTemp1, then stores hTemp2, hTemp3, hTemp4 at HL - 3 onward (E-0119)
StoreTemp2To3BytesBeforeHLPlusTemp0::
    ldh a, [hTemp0]
    add l
    ld l, a
    ldh a, [hTemp1]
    adc h
    ld h, a
    dec hl
    dec hl
    dec hl
    ldh a, [hTemp2]
    ld [hli], a
    ldh a, [hTemp3]
    ld [hli], a
    ldh a, [hTemp4]
    ld [hli], a
    ret

SECTION "Bank 60 KeyWorldChunkLists", ROMX

; RunRandomPatternCase_SingleChunk/01/02 pick entry (random & $1F) of the lists at $610D, $616D and
; $61E5 and store the far pointer in the key-world area data; the far pointers run to $62F8 and all
; point at chunk groups ($61 bytes per sub-chunk) (E-0146, C1)
; record: chunk group in bank $67/$68; its ROM bank
KeyWorldChunkLists::
    dfar KeyWorldChunkGroup00 ; id 0
    dfar KeyWorldChunkGroup01 ; id 1
    dfar KeyWorldChunkGroup02 ; id 2
    dfar KeyWorldChunkGroup03 ; id 3
    dfar KeyWorldChunkGroup04 ; id 4
    dfar KeyWorldChunkGroup05 ; id 5
    dfar KeyWorldChunkGroup06 ; id 6
    dfar KeyWorldChunkGroup07 ; id 7
    dfar KeyWorldChunkGroup08 ; id 8
    dfar KeyWorldChunkGroup09 ; id 9
    dfar KeyWorldChunkGroup0A ; id 10
    dfar KeyWorldChunkGroup0B ; id 11
    dfar KeyWorldChunkGroup0C ; id 12
    dfar KeyWorldChunkGroup0D ; id 13
    dfar KeyWorldChunkGroup0E ; id 14
    dfar KeyWorldChunkGroup0F ; id 15
    dfar KeyWorldChunkGroup0F ; id 16
    dfar KeyWorldChunkGroup0E ; id 17
    dfar KeyWorldChunkGroup0D ; id 18
    dfar KeyWorldChunkGroup0C ; id 19
    dfar KeyWorldChunkGroup0B ; id 20
    dfar KeyWorldChunkGroup0A ; id 21
    dfar KeyWorldChunkGroup09 ; id 22
    dfar KeyWorldChunkGroup08 ; id 23
    dfar KeyWorldChunkGroup07 ; id 24
    dfar KeyWorldChunkGroup06 ; id 25
    dfar KeyWorldChunkGroup05 ; id 26
    dfar KeyWorldChunkGroup04 ; id 27
    dfar KeyWorldChunkGroup03 ; id 28
    dfar KeyWorldChunkGroup02 ; id 29
    dfar KeyWorldChunkGroup01 ; id 30
    dfar KeyWorldChunkGroup00 ; id 31
RunRandomPatternCase_TallBlock_Data::
    dfar KeyWorldChunkGroup10 ; id 32
    dfar KeyWorldChunkGroup11 ; id 33
    dfar KeyWorldChunkGroup12 ; id 34
    dfar KeyWorldChunkGroup13 ; id 35
    dfar KeyWorldChunkGroup14 ; id 36
    dfar KeyWorldChunkGroup15 ; id 37
    dfar KeyWorldChunkGroup16 ; id 38
    dfar KeyWorldChunkGroup17 ; id 39
    dfar KeyWorldChunkGroup18 ; id 40
    dfar KeyWorldChunkGroup19 ; id 41
    dfar KeyWorldChunkGroup1A ; id 42
    dfar KeyWorldChunkGroup1B ; id 43
    dfar KeyWorldChunkGroup1C ; id 44
    dfar KeyWorldChunkGroup1D ; id 45
    dfar KeyWorldChunkGroup1E ; id 46
    dfar KeyWorldChunkGroup1F ; id 47
    dfar KeyWorldChunkGroup1F ; id 48
    dfar KeyWorldChunkGroup1E ; id 49
    dfar KeyWorldChunkGroup1D ; id 50
    dfar KeyWorldChunkGroup1C ; id 51
    dfar KeyWorldChunkGroup1B ; id 52
    dfar KeyWorldChunkGroup1A ; id 53
    dfar KeyWorldChunkGroup19 ; id 54
    dfar KeyWorldChunkGroup18 ; id 55
    dfar KeyWorldChunkGroup17 ; id 56
    dfar KeyWorldChunkGroup16 ; id 57
    dfar KeyWorldChunkGroup15 ; id 58
    dfar KeyWorldChunkGroup14 ; id 59
    dfar KeyWorldChunkGroup13 ; id 60
    dfar KeyWorldChunkGroup12 ; id 61
    dfar KeyWorldChunkGroup11 ; id 62
    dfar KeyWorldChunkGroup10 ; id 63
    dfar KeyWorldChunkGroup20 ; id 64
    dfar KeyWorldChunkGroup20 ; id 65
    dfar KeyWorldChunkGroup20 ; id 66
    dfar KeyWorldChunkGroup20 ; id 67
    dfar KeyWorldChunkGroup20 ; id 68
    dfar KeyWorldChunkGroup20 ; id 69
    dfar KeyWorldChunkGroup20 ; id 70
    dfar KeyWorldChunkGroup20 ; id 71
RunRandomPatternCase_WideBlock_Data::
    dfar KeyWorldChunkGroup20 ; id 72
    dfar KeyWorldChunkGroup21 ; id 73
    dfar KeyWorldChunkGroup22 ; id 74
    dfar KeyWorldChunkGroup23 ; id 75
    dfar KeyWorldChunkGroup24 ; id 76
    dfar KeyWorldChunkGroup25 ; id 77
    dfar KeyWorldChunkGroup26 ; id 78
    dfar KeyWorldChunkGroup27 ; id 79
    dfar KeyWorldChunkGroup28 ; id 80
    dfar KeyWorldChunkGroup29 ; id 81
    dfar KeyWorldChunkGroup2A ; id 82
    dfar KeyWorldChunkGroup2B ; id 83
    dfar KeyWorldChunkGroup2C ; id 84
    dfar KeyWorldChunkGroup2D ; id 85
    dfar KeyWorldChunkGroup2E ; id 86
    dfar KeyWorldChunkGroup2F ; id 87
    dfar KeyWorldChunkGroup2F ; id 88
    dfar KeyWorldChunkGroup2E ; id 89
    dfar KeyWorldChunkGroup2D ; id 90
    dfar KeyWorldChunkGroup2C ; id 91
    dfar KeyWorldChunkGroup2B ; id 92
    dfar KeyWorldChunkGroup2A ; id 93
    dfar KeyWorldChunkGroup29 ; id 94
    dfar KeyWorldChunkGroup28 ; id 95
    dfar KeyWorldChunkGroup27 ; id 96
    dfar KeyWorldChunkGroup26 ; id 97
    dfar KeyWorldChunkGroup25 ; id 98
    dfar KeyWorldChunkGroup24 ; id 99
    dfar KeyWorldChunkGroup23 ; id 100
    dfar KeyWorldChunkGroup22 ; id 101
    dfar KeyWorldChunkGroup21 ; id 102
    dfar KeyWorldChunkGroup20 ; id 103
RunRandomPatternCase_Block2x2_Data::
    dfar KeyWorldChunkGroup30 ; id 104
    dfar KeyWorldChunkGroup31 ; id 105
    dfar KeyWorldChunkGroup32 ; id 106
    dfar KeyWorldChunkGroup33 ; id 107
    dfar KeyWorldChunkGroup34 ; id 108
    dfar KeyWorldChunkGroup35 ; id 109
    dfar KeyWorldChunkGroup36 ; id 110
    dfar KeyWorldChunkGroup37 ; id 111
    dfar KeyWorldChunkGroup38 ; id 112
    dfar KeyWorldChunkGroup39 ; id 113
    dfar KeyWorldChunkGroup3A ; id 114
    dfar KeyWorldChunkGroup3B ; id 115
    dfar KeyWorldChunkGroup3C ; id 116
    dfar KeyWorldChunkGroup3D ; id 117
    dfar KeyWorldChunkGroup3E ; id 118
    dfar KeyWorldChunkGroup3F ; id 119
    dfar KeyWorldChunkGroup3F ; id 120
    dfar KeyWorldChunkGroup3E ; id 121
    dfar KeyWorldChunkGroup3D ; id 122
    dfar KeyWorldChunkGroup3C ; id 123
    dfar KeyWorldChunkGroup3B ; id 124
    dfar KeyWorldChunkGroup3A ; id 125
    dfar KeyWorldChunkGroup39 ; id 126
    dfar KeyWorldChunkGroup38 ; id 127
    dfar KeyWorldChunkGroup37 ; id 128
    dfar KeyWorldChunkGroup36 ; id 129
    dfar KeyWorldChunkGroup35 ; id 130
    dfar KeyWorldChunkGroup34 ; id 131
    dfar KeyWorldChunkGroup33 ; id 132
    dfar KeyWorldChunkGroup32 ; id 133
    dfar KeyWorldChunkGroup31 ; id 134
    dfar KeyWorldChunkGroup30 ; id 135
    dfar KeyWorldChunkGroup40 ; id 136
    dfar KeyWorldChunkGroup41 ; id 137
    dfar KeyWorldChunkGroup42 ; id 138
    dfar KeyWorldChunkGroup43 ; id 139
    dfar KeyWorldChunkGroup44 ; id 140
    dfar KeyWorldChunkGroup45 ; id 141
    dfar KeyWorldChunkGroup46 ; id 142
    dfar KeyWorldChunkGroup47 ; id 143
    dfar KeyWorldChunkGroup48 ; id 144
    dfar KeyWorldChunkGroup48 ; id 145
    dfar KeyWorldChunkGroup48 ; id 146
    dfar KeyWorldChunkGroup48 ; id 147
    dfar KeyWorldChunkGroup48 ; id 148
    dfar KeyWorldChunkGroup49 ; id 149
    dfar KeyWorldChunkGroup4A ; id 150
    dfar KeyWorldChunkGroup4B ; id 151
    dfar KeyWorldChunkGroup4C ; id 152
    dfar KeyWorldChunkGroup4D ; id 153
    dfar KeyWorldChunkGroup4E ; id 154
    dfar KeyWorldChunkGroup4F ; id 155
    dfar KeyWorldChunkGroup50 ; id 156
    dfar KeyWorldChunkGroup51 ; id 157
    dfar KeyWorldChunkGroup52 ; id 158
    dfar KeyWorldChunkGroup53 ; id 159
    dfar KeyWorldChunkGroup54 ; id 160
    dfar KeyWorldChunkGroup55 ; id 161
    dfar KeyWorldChunkGroup56 ; id 162
    dfar KeyWorldChunkGroup57 ; id 163

; Rebuilds the objects of a key world map on entry. It acts only when wMapType is $80 and bit 7 of
; wKeyWorldRefresh is set (the bit is cleared first). The band is SetKeyWorldBandForA of byte 3 of
; the wKeyList entry of wCurrentKeyIndex (stored in wKeyWorldBand); wMapObjectCount =
; RefreshKeyWorldObjectsOnEntry_Data[band] (10, 15 or 20); each 8-byte wMapObjects entry gets
; RollKeyWorldObjectKind and PlaceKeyWorldObjectAtRandomCell on the layout already in
; wKeyWorldChunks. When an entry cannot be placed the count is cut to the entries before it. Only in
; that cut case, with the count still above 0, the routine goes on to set bit 7 of byte 0 of the
; entry whose byte 4 equals wKeyWorldGoalCell, if wKeyWorldActive is set and wKeyWorldKey has bit 7
; set with its low 7 bits equal to wKeyWorldSlot. When every object fits it returns without marking,
; and a count cut to 0 restarts the routine, which then returns at once because the refresh bit is
; already clear. (C2, E-0384)
; on key-world maps with bit 7 of wKeyWorldRefresh set: sets the object count wMapObjectCount from
; the band of the key level and drops objects for which PlaceKeyWorldObjectAtRandomCell fails; marks
; the wKeyWorldGoalCell object (E-0129)
RefreshKeyWorldObjectsOnEntry::
    ld a, [wMapType]
    cp $80
    ret nz
    ld a, [wKeyWorldRefresh]
    bit 7, a
    ret z
    and $7f
    ld [wKeyWorldRefresh], a
    ld a, [wCurrentKeyIndex]
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
    call SetKeyWorldBandForA
    ld a, [wKeyWorldBand]
    and $0f
    ld hl, RefreshKeyWorldObjectsOnEntry_Data
    add_a_to_hl
    ld a, [hl]
    ld [wMapObjectCount], a
    ld b, a
    ld de, wMapObjects

.loop:
    push de
    push bc
    ld a, b
    ldh [hTemp0], a
    call RollKeyWorldObjectKind
    call PlaceKeyWorldObjectAtRandomCell
    or a
    jr nz, .read_map_object_count
    pop bc
    pop de
    ld a, $08
    add e
    ld e, a
    jr nc, .next
    inc d

.next:
    dec b
    jr nz, .loop
    ret

.read_map_object_count:
    pop bc
    pop de
    ld a, [wMapObjectCount]
    sub b
    ld [wMapObjectCount], a
    jr z, RefreshKeyWorldObjectsOnEntry
    ld a, [wKeyWorldActive]
    or a
    ret z
    ld a, [wKeyWorldKey]
    bit 7, a
    ret z
    and $7f
    ld c, a
    ld a, [wKeyWorldSlot]
    cp c
    ret nz
    ld a, [wKeyWorldGoalCell]
    ld c, a
    ld hl, wMapObjects + $4
    ld a, [wMapObjectCount]
    ld b, a

.loop2:
    ld a, [hl]
    cp c
    jr nz, .skip
    dec hl
    dec hl
    dec hl
    dec hl
    set 7, [hl]
    ret

.skip:
    ld a, $08
    add_a_to_hl
    dec b
    jr nz, .loop2
    ret

SECTION "Bank 60 RefreshKeyWorldObjectsOnEntry_Data", ROMX

; Sixteen bytes indexed by wKeyWorldBand AND $0F: the number of map objects to place, 10 for bands
; 0-7, 15 for bands 8-11 and 20 for bands 12-15. RefreshKeyWorldObjectsOnEntry stores the value in
; wMapObjectCount; it repeats GenerateKeyWorld_PlaceObjects_Data byte for byte. (C1, E-0381)
RefreshKeyWorldObjectsOnEntry_Data::
    db $0a, $0a, $0a, $0a, $0a, $0a, $0a, $0a, $0f, $0f, $0f, $0f, $14, $14, $14, $14

; Sets up the random objects of a town (non key world) map. It acts when bit 7 of wMapType is clear
; and bit 7 of wKeyWorldRefresh is set, by hMapId: map $20 gives wMapObjectCount 10, wKeyWorldBand
; 0, spot table TownObjectSpotGrid0 and hTemp0 = 1; $30: 10, 3, TownObjectSpotGrid1, 2; $48: 15, 6,
; TownObjectSpotGrid2, 3; $70: 15, 9, TownObjectSpotGrid3, 4; $A8: 10, $0B, TownObjectSpotGrid4, 5;
; $B0: 2, $0B, TownObjectSpotGrid5, 6; $B8: 8, $0D, TownObjectSpotGrid6, 7. For these it calls
; SetupTownObjectsForMap_RollObjects with HL = the spot table and then
; MarkMapObjectsEntryForKeyWorldGoalCell with that hTemp0. Maps $A0, $C8, $D1 and $DA set
; wMapObjectCount to 0 and nothing else; other maps change nothing. (C2, E-0384)
; on town maps with bit 7 of wKeyWorldRefresh set: sets the object count and band for the map, drops
; listed objects and marks the wKeyWorldGoalCell one (E-0130)
SetupTownObjectsForMap::
    ld a, [wMapType]
    bit 7, a
    ret nz
    ld a, [wKeyWorldRefresh]
    bit 7, a
    ret z
    ldh a, [hMapId]
    cp $20
    jr z, .set_map_object_count_to_0A
    cp $30
    jr z, .set_map_object_count_to_0A2
    cp $48
    jr z, .set_map_object_count_to_0F
    cp $70
    jr z, .set_map_object_count_to_0F2
    cp $a8
    jp z, .set_map_object_count_to_0A3
    cp $b0
    jp z, .set_map_object_count_to_02
    cp $b8
    jp z, .set_map_object_count_to_08
    cp $a0
    jr z, .clear_map_object_count
    cp $c8
    jr z, .clear_map_object_count
    cp $d1
    jr z, .clear_map_object_count
    cp $da
    jr z, .clear_map_object_count
    ret

.clear_map_object_count:
    xor a
    ld [wMapObjectCount], a
    ret

.set_map_object_count_to_0A:
    ld a, $0a
    ld [wMapObjectCount], a
    ld a, $00
    ld [wKeyWorldBand], a
    ld hl, TownObjectSpotGrid0
    ASSERT BANK(TownObjectSpotGrid0) == $61, "TownObjectSpotGrid0 is read with bank $61 mapped"
    call SetupTownObjectsForMap_RollObjects
    ld a, $01
    ldh [hTemp0], a
    call MarkMapObjectsEntryForKeyWorldGoalCell
    ret

.set_map_object_count_to_0A2:
    ld a, $0a
    ld [wMapObjectCount], a
    ld a, $03
    ld [wKeyWorldBand], a
    ld hl, TownObjectSpotGrid1
    ASSERT BANK(TownObjectSpotGrid1) == $61, "TownObjectSpotGrid1 is read with bank $61 mapped"
    call SetupTownObjectsForMap_RollObjects
    ld a, $02
    ldh [hTemp0], a
    call MarkMapObjectsEntryForKeyWorldGoalCell
    ret

.set_map_object_count_to_0F:
    ld a, $0f
    ld [wMapObjectCount], a
    ld a, $06
    ld [wKeyWorldBand], a
    ld hl, TownObjectSpotGrid2
    ASSERT BANK(TownObjectSpotGrid2) == $61, "TownObjectSpotGrid2 is read with bank $61 mapped"
    call SetupTownObjectsForMap_RollObjects
    ld a, $03
    ldh [hTemp0], a
    call MarkMapObjectsEntryForKeyWorldGoalCell
    ret

.set_map_object_count_to_0F2:
    ld a, $0f
    ld [wMapObjectCount], a
    ld a, $09
    ld [wKeyWorldBand], a
    ld hl, TownObjectSpotGrid3
    ASSERT BANK(TownObjectSpotGrid3) == $61, "TownObjectSpotGrid3 is read with bank $61 mapped"
    call SetupTownObjectsForMap_RollObjects
    ld a, $04
    ldh [hTemp0], a
    call MarkMapObjectsEntryForKeyWorldGoalCell
    ret

.set_map_object_count_to_0A3:
    ld a, $0a
    ld [wMapObjectCount], a
    ld a, $0b
    ld [wKeyWorldBand], a
    ld hl, TownObjectSpotGrid4
    ASSERT BANK(TownObjectSpotGrid4) == $61, "TownObjectSpotGrid4 is read with bank $61 mapped"
    call SetupTownObjectsForMap_RollObjects
    ld a, $05
    ldh [hTemp0], a
    call MarkMapObjectsEntryForKeyWorldGoalCell
    ret

.set_map_object_count_to_02:
    ld a, $02
    ld [wMapObjectCount], a
    ld a, $0b
    ld [wKeyWorldBand], a
    ld hl, TownObjectSpotGrid5
    ASSERT BANK(TownObjectSpotGrid5) == $61, "TownObjectSpotGrid5 is read with bank $61 mapped"
    call SetupTownObjectsForMap_RollObjects
    ld a, $06
    ldh [hTemp0], a
    call MarkMapObjectsEntryForKeyWorldGoalCell
    ret

.set_map_object_count_to_08:
    ld a, $08
    ld [wMapObjectCount], a
    ld a, $0d
    ld [wKeyWorldBand], a
    ld hl, TownObjectSpotGrid6
    ASSERT BANK(TownObjectSpotGrid6) == $61, "TownObjectSpotGrid6 is read with bank $61 mapped"
    call SetupTownObjectsForMap_RollObjects
    ld a, $07
    ldh [hTemp0], a
    call MarkMapObjectsEntryForKeyWorldGoalCell
    ret

SECTION "Bank 60 SetupTownObjectsForMap_RollObjects", ROMX

; HL = a spot table (TownObjectSpotGrid0-6), kept in hTemp6/hTemp7. Clears bit 7 of
; wKeyWorldRefresh, then for each of the wMapObjectCount entries of wMapObjects (8 bytes) rolls a
; kind (RollKeyWorldObjectKind for wKeyWorldBand) and a screen with a spot
; (SetupTownObjectsForMap_RollObjects_PlaceObject). When one cannot be placed it lowers
; wMapObjectCount by the number of entries from that one on and returns. SetupTownObjectsForMap
; calls it; despite the name it removes nothing. (C2, E-0384)
; clears bit 7 of wKeyWorldRefresh; walks the wMapObjectCount 8-byte entries at wMapObjects and
; drops the count at the first entry for which SetupTownObjectsForMap_RollObjects_PlaceObject
; returns 0 (E-0125)
SetupTownObjectsForMap_RollObjects::
    ld a, l
    ldh [hTemp6], a
    ld a, h
    ldh [hTemp7], a
    ld a, [wKeyWorldRefresh]
    and $7f
    ld [wKeyWorldRefresh], a
    ld a, [wMapObjectCount]
    ld b, a
    ld de, wMapObjects

.loop:
    push de
    push bc
    ld a, b
    ldh [hTemp0], a
    call RollKeyWorldObjectKind
    call SetupTownObjectsForMap_RollObjects_PlaceObject
    or a
    jr z, .read_map_object_count
    pop bc
    pop de
    ld a, $08
    add e
    ld e, a
    jr nc, .next
    inc d

.next:
    dec b
    jr nz, .loop
    ret

.read_map_object_count:
    pop bc
    pop de
    ld a, [wMapObjectCount]
    sub b
    ld [wMapObjectCount], a
    ret

SECTION "Bank 60 MarkMapObjectsEntryForKeyWorldGoalCell", ROMX

; hTemp0 = a key number. Does something only when wKeyWorldActive is non-zero and wKeyWorldKey has
; bit 7 clear and equals hTemp0: it then sets bit 7 of byte 0 of the first of the wMapObjectCount
; wMapObjects entries whose byte 4 equals wKeyWorldGoalCell. Used at the end of each map case of
; SetupTownObjectsForMap. (C2, E-0384)
; when wKeyWorldActive is set and wKeyWorldKey equals hTemp0, sets bit 7 of the entry whose byte 4
; equals wKeyWorldGoalCell (E-0125)
MarkMapObjectsEntryForKeyWorldGoalCell::
    ld a, [wKeyWorldActive]
    or a
    ret z
    ld a, [wKeyWorldKey]
    bit 7, a
    ret nz
    ld c, a
    ldh a, [hTemp0]
    cp c
    ret nz
    ld a, [wKeyWorldGoalCell]
    ld c, a
    ld hl, wMapObjects + $4
    ld a, [wMapObjectCount]
    ld b, a

.loop:
    ld a, [hl]
    cp c
    jr nz, .skip
    dec hl
    dec hl
    dec hl
    dec hl
    set 7, [hl]
    ret

.skip:
    ld a, $08
    add_a_to_hl
    dec b
    jr nz, .loop
    ret

SECTION "Bank 60 SetupTownObjectsForMap_RollObjects_PlaceObject", ROMX

; DE = the object's 8-byte wMapObjects entry, hTemp0 = the entries left, hTemp6/hTemp7 = the spot
; table: picks a random screen (X below wMapWidthScreens, Y below wMapHeightScreens, kept in hTemp5
; as X * 16 + Y) that no earlier entry's byte 4 holds, giving up with A = 0 after 100 clashes. It
; then reads one of the screen's four 2-byte spots from bank $61 (8 bytes per screen): $FE picks a
; new screen, $FF another spot, otherwise entry byte 5 = (first << 4) | second and byte 4 = hTemp5,
; returning A = 1. (C2, E-0371; probed E-0384)
SetupTownObjectsForMap_RollObjects_PlaceObject::
    push de
    xor a
    ldh [hTempA], a

.loop:
    ld a, [wMapWidthScreens]
    ld c, a

.loop2:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $0f
    cp c
    jr nc, .loop2
    ldh [hTemp3], a
    ld a, [wMapHeightScreens]
    ld c, a

.loop3:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $0f
    cp c
    jr nc, .loop3
    ldh [hTemp4], a
    ldh a, [hTemp3]
    swap a
    ld c, a
    ldh a, [hTemp4]
    or c
    ldh [hTemp5], a
    ld c, a
    ldh a, [hTemp0]
    ld b, a
    ld a, [wMapObjectCount]
    sub b
    jr z, .read_map_width_screens
    ld b, a
    ld hl, wMapObjects + $4

.loop4:
    ld a, [hl]
    cp c
    jr nz, .skip
    ldh a, [hTempA]
    inc a
    ldh [hTempA], a
    cp $64
    jr nz, .loop
    pop de
    xor a
    ret

.skip:
    ld a, $08
    add_a_to_hl
    dec b
    jr nz, .loop4

.read_map_width_screens:
    ld a, [wMapWidthScreens]
    add a
    add a
    add a
    ld c, a
    ldh a, [hTemp4]
    call Multiply8
    ldh a, [hTemp3]
    add a
    add a
    add a
    add_a_to_hl
    ld e, l
    ld d, h
    ldh a, [hTemp6]
    ld l, a
    ldh a, [hTemp7]
    ld h, a
    add hl, de

.call_next_random_seed:
    push hl
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $03
    add a
    add_a_to_hl
    ld e, l
    ld d, h
    ld b, $61
    call ReadByteInBank
    ld a, c
    cp $fe
    jr nz, .cp_FF
    pop hl
    jp .loop

.cp_FF:
    cp $ff
    jr nz, .restore
    pop hl
    jr .call_next_random_seed

.restore:
    pop hl
    swap a
    ld c, a
    push bc
    inc de
    call ReadByteInBank
    ld a, c
    pop bc
    or c
    pop de
    inc de
    inc de
    inc de
    inc de
    inc de
    ld [de], a
    dec de
    ldh a, [hTemp5]
    ld [de], a
    ld a, $01
    ret

SECTION "Bank 60 FieldState_MapTransition_AfterWarp", ROMX

; After a warp onto a map listed in FieldState_MapTransition_AfterWarp_Data2 (except map $39 at
; screen (1, 1) and map $2B at (1, 2)): sets the band from the map's entry in
; FieldState_MapTransition_AfterWarp_Data1 and rolls three screen triggers; otherwise none. In key
; worlds FieldState_MapTransition_RoomWarp decides. (C2, E-0357; probed E-0384)
FieldState_MapTransition_AfterWarp::
    ld a, [wMapType]
    bit 7, a
    jr z, .check_map_id
    call FieldState_MapTransition_RoomWarp
    ret

.check_map_id:
    ldh a, [hMapId]
    cp $39
    jr nz, .check_map_id2
    ldh a, [hMapScreenX]
    cp $01
    jr nz, .check_map_id2
    ldh a, [hMapScreenY]
    cp $01
    ret z

.check_map_id2:
    ldh a, [hMapId]
    cp $2b
    jr nz, .read_map_id
    ldh a, [hMapScreenX]
    cp $01
    jr nz, .read_map_id
    ldh a, [hMapScreenY]
    cp $02
    ret z

.read_map_id:
    ldh a, [hMapId]
    ld c, a
    ld hl, FieldState_MapTransition_AfterWarp_Data2
    ld b, $00

.skip:
    ld a, [hli]
    cp $ff
    jr nz, .skip2

.loop:
    xor a
    ld [wScreenTriggerCount], a
    ret

.skip2:
    cp c
    jr z, .check_warp_pending
    inc b
    jr .skip

.check_warp_pending:
    ld a, [wWarpPending]
    or a
    jr z, .loop
    xor a
    ld [wWarpPending], a
    ld a, b
    push af
    ld hl, FieldState_MapTransition_AfterWarp_Data1
    add_a_to_hl
    ld a, [hl]
    ld [wKeyWorldBand], a
    pop af
    ldh [hTemp2], a
    ld a, $03
    ld [wScreenTriggerCount], a
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $1f
    ldh [hTemp3], a
    ld b, $03
    ld de, wScreenTriggers

.loop2:
    push de
    push bc
    call FieldState_MapTransition_RollTriggerContents
    call WriteKeyContentsWordRowsEntryForTemp2Temp3
    ld hl, hTemp3
    inc [hl]
    pop bc
    pop de
    inc de
    inc de
    inc de
    inc de
    dec b
    jr nz, .loop2
    ret

SECTION "Bank 60 FieldState_MapTransition_AfterWarp_Data1", ROMX

; Eleven bytes, parallel to FieldState_MapTransition_AfterWarp_Data2: the entry at the same index as
; the current map id in that list is the key world band, 0, 3, 3, 3, 3, 6, 6, 9, 9, 12, 12 (the last
; entry matches the $FF end marker, so no map reaches it). FieldState_MapTransition_AfterWarp stores
; it in wKeyWorldBand before rolling the three screen triggers. (C1, E-0381)
FieldState_MapTransition_AfterWarp_Data1::
    db $00, $03, $03, $03, $03, $06, $06, $09, $09, $0c, $0c

; A list of ten map ids ($2B, $38, $39, $3A, $53, $5D, $82, $83, $AD, $AE) ended by $FF.
; FieldState_MapTransition_AfterWarp searches it for hMapId; the position found is the index into
; FieldState_MapTransition_AfterWarp_Data1 and is kept in hTemp2 for the trigger rows; a map not in
; the list gets wScreenTriggerCount = 0. (C1, E-0381)
FieldState_MapTransition_AfterWarp_Data2::
    db $2b, $38, $39, $3a, $53, $5d, $82, $83, $ad, $ae, $ff

; DE = a 4-byte screen trigger entry. DE moves up by 2 and the two bytes of row hTemp2 of
; KeyContentsWordRows at position 2 x KeyContentsColumnPicks[hTemp3] (rows are 16 bytes) are written
; at DE and DE + 1 (bytes 2 and 3 of the entry); DE ends 3 above the start.
; FieldState_MapTransition_AfterWarp calls it after FieldState_MapTransition_RollTriggerContents
; with hTemp3 rising by one per trigger. (C2, E-0384)
; DE += 2; writes the word at $669C + 16 * hTemp2 + 2 * KeyContentsColumnPicks[hTemp3] at DE
; (E-0121)
WriteKeyContentsWordRowsEntryForTemp2Temp3::
    inc de
    inc de
    ldh a, [hTemp2]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, l
    add LOW(KeyContentsWordRows)
    ld l, a
    ld a, h
    adc HIGH(KeyContentsWordRows)
    ld h, a
    push hl
    ldh a, [hTemp3]
    ld hl, KeyContentsColumnPicks
    add_a_to_hl
    ld a, [hl]
    pop hl
    sla a
    add_a_to_hl
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ret

SECTION "Bank 60 KeyContentsColumnPicks", ROMX

; WriteKeyContentsWordRowsEntryForTemp2Temp3 reads the byte at $6677 + hTemp3 and uses it as the
; word index in row hTemp2 of KeyContentsWordRows; the first 32 bytes are four permutations of 0-7;
; the table ends where the rows begin, and a larger hTemp3 would read into them (E-0192, C1)
; record: 37 bytes, each a word index 0-7 within a row
KeyContentsColumnPicks::
    db $00, $02, $04, $06, $07, $01, $03, $05, $02, $06, $00, $07, $04, $05, $03, $01, $02, $07, $00, $05, $06, $03, $01, $04, $00, $05, $02, $06, $03, $07, $04, $01, $05, $00, $03, $06, $02 ; entry 0

; WriteKeyContentsWordRowsEntryForTemp2Temp3 copies the two bytes at $669C + 16 * hTemp2 + 2 *
; KeyContentsColumnPicks[hTemp3] to DE + 2; rows 0-9 hold values, rows 10-28 are zero, and the 29
; rows end at the code at $686C (E-0192, C1)
; record: eight two-byte values (copied as a pair to DE)
KeyContentsWordRows::
    db $03, $47, $23, $53, $12, $23, $21, $52, $11, $46, $00, $44, $00, $44, $00, $44 ; id 0
    db $10, $54, $00, $44, $11, $64, $21, $74, $12, $44, $32, $72, $00, $44, $22, $26 ; id 1
    db $10, $34, $01, $45, $11, $72, $21, $74, $20, $44, $12, $65, $22, $44, $32, $46 ; id 2
    db $00, $35, $22, $44, $02, $26, $22, $44, $20, $43, $11, $35, $22, $44, $01, $44 ; id 3
    db $10, $45, $30, $44, $21, $42, $11, $76, $01, $56, $12, $33, $32, $54, $33, $32 ; id 4
    db $33, $42, $02, $46, $31, $22, $30, $74, $13, $33, $12, $43, $10, $85, $00, $47 ; id 5
    db $44, $44, $44, $44, $44, $44, $44, $44, $44, $44, $11, $22, $21, $15, $10, $54 ; id 6
    db $00, $26, $10, $32, $11, $54, $12, $34, $02, $44, $02, $44, $02, $44, $02, $44 ; id 7
    db $10, $42, $22, $44, $21, $76, $12, $74, $11, $44, $03, $62, $02, $86, $23, $53 ; id 8
    db $13, $56, $03, $73, $12, $54, $22, $55, $21, $86, $01, $73, $20, $72, $00, $44 ; id 9
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 10
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 11
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 12
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 13
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 14
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 15
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 16
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 17
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 18
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 19
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 20
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 21
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 22
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 23
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 24
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 25
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 26
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 27
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 28

; In a key world's rooms (map type 5), after a warp into an area other than the floor's two special
; ones: the band from the key's level byte, two screen triggers rolled; when both landed in the same
; place only one is kept. (C2, E-0357; probed E-0384)
FieldState_MapTransition_RoomWarp::
    ld a, [wMapType]
    and $07
    cp $05
    jr z, .check_key_world_area

.loop:
    xor a
    ld [wScreenTriggerCount], a
    ret

.check_key_world_area:
    ld a, [wKeyWorldArea]
    or a
    jr z, .loop
    ld c, a
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState + $4
    add_a_to_hl
    ld a, [hl]
    cp c
    jr z, .loop
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    cp c
    jr z, .loop
    ld a, [wWarpPending]
    or a
    jr z, .loop
    xor a
    ld [wWarpPending], a
    ld a, [wCurrentKeyIndex]
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
    call SetKeyWorldBandForA
    ld a, $02
    ld [wScreenTriggerCount], a
    ld b, $02
    ld de, wScreenTriggers

.loop2:
    push de
    push bc
    call FieldState_MapTransition_RollTriggerContents
    call WriteRandomEntryFromTable
    pop bc
    pop de
    inc de
    inc de
    inc de
    inc de
    dec b
    jr nz, .loop2
    ld a, [wScreenTriggers + $2]
    ld c, a
    ld a, [wScreenTriggers + $6]
    cp c
    ret nz
    ld a, [wScreenTriggers + $3]
    ld c, a
    ld a, [wScreenTriggers + $7]
    cp c
    ret nz
    ld a, $01
    ld [wScreenTriggerCount], a
    ret

SECTION "Bank 60 WriteRandomEntryFromTable", ROMX

; DE = a 4-byte screen trigger entry. DE moves up by 2; after a seed step i = wKeyRandomHi & 7;
; WriteRandomEntryFromTable_Data[i] is written at DE (byte 2 of the entry) and byte 3 gets the
; position pair that LookupKeyWorldScreenSpotRecordsNibblePairForTemp0 (bank $61) gives for the same
; i; DE ends 3 above the start and hTemp0 holds that pair. (C2, E-0384)
; DE += 2; advances the random seed; hTemp0 = wKeyRandomHi & 7; writes
; WriteRandomEntryFromTable_Data[hTemp0] at DE, calls
; LookupKeyWorldScreenSpotRecordsNibblePairForTemp0, then writes hTemp0 at the next byte (E-0121)
; (E-0344: the address in its name dropped or read as the label there; was
; WriteRandomEntryFromTable)
WriteRandomEntryFromTable::
    inc de
    inc de
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $07
    ldh [hTemp0], a
    ld hl, WriteRandomEntryFromTable_Data
    add_a_to_hl
    ld a, [hl]
    ld [de], a
    inc de
    push de
    farcall LookupKeyWorldScreenSpotRecordsNibblePairForTemp0
    pop de
    ldh a, [hTemp0]
    ld [de], a
    ret

SECTION "Bank 60 WriteRandomEntryFromTable_Data", ROMX

; Eight bytes, each a pair of nibbles: $01, $10, $12, $13, $20, $21, $23, $32.
; WriteRandomEntryFromTable picks the entry with wKeyRandomHi AND 7 and writes it at byte 2 of a
; 4-byte screen trigger entry (DE + 2); byte 3 is then the nibble pair
; LookupKeyWorldScreenSpotRecordsNibblePairForTemp0 gives for the same random index. (C1, E-0381)
WriteRandomEntryFromTable_Data::
    db $01, $10, $12, $13, $20, $21, $23, $32

; hTemp0 = a level (party strength). Sets hTemp3 = hTemp0, hTemp1 = the position of the first
; non-zero byte not below a random 0-99 in row level / 10 of KeyContentsKindChanceRows (16 bytes per
; row), and hTemp2 = the position of the first byte not below a second random 0-99 in row level / 10
; of KeyContentsChanceRows (60 bytes per row). WriteKeyEntryTemp0 stores hTemp1, hTemp2 and hTemp3
; as bytes 1-3 of a new key entry in wKeyList (the first two pick the words of the key name). (C2,
; E-0384)
; hTemp3 = hTemp0; picks hTemp1 from the chance row KeyContentsKindChanceRows[level / 10] and hTemp2
; from row KeyContentsChanceRows + $3C * (level / 10) (E-0125)
RollKeyContentsForLevelTemp0::
    ldh a, [hTemp0]
    ldh [hTemp3], a
    ld l, a
    ld h, $00
    ld a, $0a
    call DivideHLByA
    ld a, l
    push af
    swap a
    ld hl, KeyContentsKindChanceRows
    add_a_to_hl
    call RandomBelow100
    ld c, a
    ld b, $00

.skip:
    ld a, [hli]
    or a
    jr z, .next
    cp c
    jr nc, .set_temp1

.next:
    inc b
    jr .skip

.set_temp1:
    ld a, b
    ldh [hTemp1], a
    pop af
    ld c, $3c
    call Multiply8
    ld de, KeyContentsChanceRows
    add hl, de
    call RandomBelow100
    ld c, a
    ld b, $00

.skip2:
    ld a, [hli]
    cp c
    jr nc, .set_temp2
    inc b
    jr .skip2

.set_temp2:
    ld a, b
    ldh [hTemp2], a
    ret

SECTION "Bank 60 RandomBelow100", ROMX

; Steps the seed (NextRandomSeed) until wKeyRandomHi & $7F is below 100 and returns that value in A.
; (C2, E-0384)
; repeats NextRandomSeed until wKeyRandomHi & $7F is below 100; returns A = that value (E-0116)
RandomBelow100::
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $7f
    cp $64
    jr nc, RandomBelow100
    ret

SECTION "Bank 60 KeyContentsKindChanceRows", ROMX

; RollKeyContentsForLevelTemp0 takes level / 10, reads the 16-byte row at $6969 + 16 * that, and
; counts entries until one is non-zero and not below a random 0-99; the count goes to hTemp1
; (E-0192, C1)
; record: one row per 10 levels: threshold bytes compared with a random 0-99
KeyContentsKindChanceRows::
    db $14, $28, $37, $46, $50, $5a, $5f, $64, $00, $00, $00, $00, $00, $00, $00, $00 ; id 0
    db $0f, $1e, $2d, $3c, $4b, $55, $5a, $5f, $64, $00, $00, $00, $00, $00, $00, $00 ; id 1
    db $00, $0a, $19, $28, $37, $46, $50, $5a, $5f, $64, $00, $00, $00, $00, $00, $00 ; id 2
    db $00, $00, $0f, $1e, $2d, $3c, $4b, $55, $5a, $5f, $64, $00, $00, $00, $00, $00 ; id 3
    db $00, $00, $05, $0f, $19, $28, $37, $46, $50, $5a, $5f, $64, $00, $00, $00, $00 ; id 4
    db $00, $00, $03, $08, $12, $21, $30, $44, $4e, $58, $5d, $62, $64, $00, $00, $00 ; id 5
    db $00, $00, $03, $08, $12, $1c, $26, $35, $44, $53, $58, $5d, $62, $64, $00, $00 ; id 6
    db $00, $00, $00, $02, $05, $0f, $19, $28, $37, $46, $50, $5a, $5f, $62, $64, $00 ; id 7
    db $00, $00, $00, $00, $03, $08, $0d, $12, $21, $30, $3f, $49, $53, $5d, $62, $64 ; id 8
    db $00, $00, $00, $00, $00, $05, $0a, $0f, $19, $23, $2d, $37, $46, $55, $5f, $64 ; id 9

; RollKeyContentsForLevelTemp0 reads the row at $6A09 + $3C * (level / 10) and counts entries below
; a random 0-99 until one is not; the count goes to hTemp2; 10 rows end at $6C61 (E-0192, C1)
; record: one row per 10 levels: 60 threshold bytes compared with a random 0-99, 20 per line
KeyContentsChanceRows::
    db $01, $00, $02, $03, $04, $05, $00, $00, $06, $07, $00, $09, $0c, $0f, $12, $00, $00, $00, $15, $18 ; id 0
    db $1b, $1e, $21, $24, $00, $26, $29, $2c, $2f, $00, $32, $35, $00, $38, $3b, $3e, $41, $44, $00, $47
    db $4a, $4d, $50, $53, $00, $00, $00, $55, $57, $5a, $00, $5c, $5e, $61, $64, $00, $00, $00, $00, $00
    db $01, $00, $02, $03, $04, $05, $00, $00, $06, $07, $00, $09, $0c, $0f, $12, $00, $00, $00, $15, $18 ; id 1
    db $1b, $1e, $21, $24, $00, $26, $29, $2c, $2f, $00, $32, $35, $00, $38, $3b, $3e, $41, $44, $00, $47
    db $4a, $4d, $50, $53, $00, $00, $00, $55, $57, $5a, $00, $5c, $5e, $61, $64, $00, $00, $00, $00, $00
    db $01, $00, $02, $03, $04, $05, $00, $00, $06, $07, $00, $09, $0c, $0f, $12, $00, $00, $00, $15, $18 ; id 2
    db $1b, $1e, $21, $24, $00, $26, $29, $2c, $2f, $00, $32, $35, $00, $38, $3b, $3e, $41, $44, $00, $47
    db $4a, $4d, $50, $53, $00, $00, $00, $55, $57, $5a, $00, $5c, $5e, $61, $64, $00, $00, $00, $00, $00
    db $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $00, $0c, $0e, $10, $12, $14, $16, $18, $1a, $1c ; id 3
    db $1e, $20, $22, $24, $26, $28, $2a, $2c, $2e, $30, $32, $34, $36, $38, $3a, $3c, $3e, $40, $42, $44
    db $46, $48, $4a, $4c, $4e, $50, $52, $54, $56, $58, $5a, $5c, $5e, $60, $62, $64, $00, $00, $00, $00
    db $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $00, $0c, $0e, $10, $12, $14, $16, $18, $1a, $1c ; id 4
    db $1e, $20, $22, $24, $26, $28, $2a, $2c, $2e, $30, $32, $34, $36, $38, $3a, $3c, $3e, $40, $42, $44
    db $46, $48, $4a, $4c, $4e, $50, $52, $54, $56, $58, $5a, $5c, $5e, $60, $62, $64, $00, $00, $00, $00
    db $06, $0c, $12, $18, $1e, $23, $28, $2d, $32, $37, $00, $38, $39, $3a, $3b, $3c, $3d, $3e, $3f, $40 ; id 5
    db $41, $42, $43, $44, $45, $46, $47, $48, $49, $4a, $4b, $4c, $4d, $4e, $4f, $50, $51, $52, $53, $54
    db $55, $56, $57, $58, $59, $5a, $5b, $5c, $5d, $5e, $5f, $60, $61, $62, $63, $64, $00, $00, $00, $00
    db $06, $0c, $12, $18, $1e, $23, $28, $2d, $32, $37, $00, $38, $39, $3a, $3b, $3c, $3d, $3e, $3f, $40 ; id 6
    db $41, $42, $43, $44, $45, $46, $47, $48, $49, $4a, $4b, $4c, $4d, $4e, $4f, $50, $51, $52, $53, $54
    db $55, $56, $57, $58, $59, $5a, $5b, $5c, $5d, $5e, $5f, $60, $61, $62, $63, $64, $00, $00, $00, $00
    db $06, $0c, $12, $18, $1e, $23, $28, $2d, $32, $37, $00, $38, $39, $3a, $3b, $3c, $3d, $3e, $3f, $40 ; id 7
    db $41, $42, $43, $44, $45, $46, $47, $48, $49, $4a, $4b, $4c, $4d, $4e, $4f, $50, $51, $52, $53, $54
    db $55, $56, $57, $58, $59, $5a, $5b, $5c, $5d, $5e, $5f, $60, $61, $62, $63, $64, $00, $00, $00, $00
    db $06, $0c, $12, $18, $1e, $23, $28, $2d, $32, $37, $3a, $3b, $00, $3c, $3d, $3f, $41, $42, $00, $00 ; id 8
    db $00, $00, $43, $00, $46, $47, $00, $00, $48, $4b, $00, $00, $4d, $00, $4e, $4f, $50, $00, $51, $52
    db $53, $00, $54, $00, $55, $57, $58, $5a, $5b, $00, $5e, $60, $62, $00, $00, $64, $00, $00, $00, $00
    db $06, $0c, $12, $18, $1d, $22, $27, $2c, $31, $36, $3b, $3c, $00, $3d, $3e, $40, $41, $42, $00, $00 ; id 9
    db $00, $00, $43, $00, $46, $47, $00, $00, $48, $4b, $00, $00, $4d, $00, $4e, $4f, $50, $00, $51, $52
    db $53, $00, $54, $00, $55, $57, $58, $5a, $5b, $00, $5e, $60, $62, $00, $00, $64, $00, $00, $00, $00

; Looks at the 20 key world slots in SRAM bank 2 ($195 bytes each, the first byte of a slot is its
; marker). hTemp0 = the index of the first slot whose marker is not $50 + its index, or $FF when all
; 20 match. SRAM is enabled for the check and switched off again (rRAMG and rRAMB set to 0). (C2,
; E-0384)
; hTemp0 = the index of the first of 20 SRAM-bank-2 slots ($195 bytes apart) whose marker is not $50
; + index, or $FF when all match (E-0125)
FindSRAMSlotMarkerIndex::
    ld a, $02
    ld [rRAMB], a
    ld a, $0a
    ld [rRAMG], a
    xor a
    ldh [hTemp0], a
    ld hl, sRecords
    ld b, $14
    ld c, $50

.loop:
    ld a, [hl]
    cp c
    jr nz, .skip
    ld a, l
    add $95
    ld l, a
    ld a, h
    adc $01
    ld h, a
    ldh a, [hTemp0]
    inc a
    ldh [hTemp0], a
    inc c
    dec b
    jr nz, .loop
    ld a, $ff
    ldh [hTemp0], a

.skip:
    xor a
    ld [rRAMG], a
    ld [rRAMB], a
    ret

SECTION "Bank 60 SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot", ROMX

; When wKeyWorldSlot is below 20, writes the marker byte wKeyWorldSlot + $50 and then the $194 bytes
; at wKeyWorldFlags to SRAM bank 2 at $A000 + $195 x wKeyWorldSlot; SRAM is switched off again
; (rRAMG and rRAMB set to 0). With a slot of 20 or more it returns without writing. (C2, E-0384)
; when wKeyWorldSlot < 20, writes wKeyWorldSlot + $50 and the $194 bytes at wKeyWorldFlags to SRAM
; bank 2 at $A000 + $195 * wKeyWorldSlot (E-0121)
SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot::
    ld a, [wKeyWorldSlot]
    cp $14
    ret nc
    ld a, $02
    ld [rRAMB], a
    ld a, [wKeyWorldSlot]
    ld bc, $0195
    call Multiply8By16
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $a0
    ld h, a
    ld e, l
    ld d, h
    ld hl, wKeyWorldFlags
    ld a, $0a
    ld [rRAMG], a
    ld a, [wKeyWorldSlot]
    add $50
    ld [de], a
    inc de
    ld bc, $0194
    call CopyBytes
    xor a
    ld [rRAMG], a
    ld [rRAMB], a
    ret

SECTION "Bank 60 LoadKeyWorldFlagsRecordFromSRAMSlotKeyWorldSlot", ROMX

; The counterpart of SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot: when wKeyWorldSlot is below 20
; and the first byte of its slot in SRAM bank 2 is wKeyWorldSlot + $50, copies the $194 bytes after
; the marker to wKeyWorldFlags; otherwise nothing is copied. SRAM is switched off again afterwards.
; (C2, E-0384)
; when wKeyWorldSlot < 20 and SRAM bank 2 slot wKeyWorldSlot is marked wKeyWorldSlot + $50, copies
; its $194 bytes to wKeyWorldFlags; counterpart of SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot
; (E-0124)
LoadKeyWorldFlagsRecordFromSRAMSlotKeyWorldSlot::
    ld a, [wKeyWorldSlot]
    cp $14
    ret nc
    ld a, $02
    ld [rRAMB], a
    ld a, [wKeyWorldSlot]
    ld bc, $0195
    call Multiply8By16
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $a0
    ld h, a
    ld de, wKeyWorldFlags
    ld a, $0a
    ld [rRAMG], a
    ld a, [wKeyWorldSlot]
    add $50
    ld c, a
    ld a, [hli]
    cp c
    jr nz, .skip
    ld bc, $0194
    call CopyBytes

.skip:
    xor a
    ld [rRAMG], a
    ld [rRAMB], a
    ret

SECTION "Bank 60 KeyWorldAreaLayoutTable_Bank60", ROMX

; a copy of KeyWorldAreaLayoutTable (84:$4CCB), word for word;
; KeyWorldLayout_NumberCellsAndPlaceEntrances.read_key_world_area_count and PlaceObjectInAreaC read
; the layout's first byte or a block byte through ReadByteInBank with B = $84 (E-0193, C1)
; record: area layout in bank $84
KeyWorldAreaLayoutTable_Bank60::
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

; PickRandomMonsterFromBandList (with GenerateKeyWorld_RollMonsters_Normal and ...BossMonsters)
; reads the word at $6D6D + 16 * hTemp1 + 2 * hTemp0 and picks one of the count words that follow
; the list's count byte; 11 rows (families, StringTable_MonsterFamilies order) of 8 bands (E-0256,
; C1)
; record: species list (count, then words)
KeyWorldBandSpeciesTable::
    dw KeyWorldBandSpecies_Slime_0 ; id 0
    dw KeyWorldBandSpecies_Slime_1 ; id 1
    dw KeyWorldBandSpecies_Slime_2 ; id 2
    dw KeyWorldBandSpecies_Slime_3 ; id 3
    dw KeyWorldBandSpecies_Slime_4 ; id 4
    dw KeyWorldBandSpecies_Slime_5 ; id 5
    dw KeyWorldBandSpecies_Slime_6 ; id 6
    dw KeyWorldBandSpecies_Slime_7 ; id 7
    dw KeyWorldBandSpecies_Dragon_0 ; id 8
    dw KeyWorldBandSpecies_Dragon_1 ; id 9
    dw KeyWorldBandSpecies_Dragon_2 ; id 10
    dw KeyWorldBandSpecies_Dragon_3 ; id 11
    dw KeyWorldBandSpecies_Dragon_4 ; id 12
    dw KeyWorldBandSpecies_Dragon_5 ; id 13
    dw KeyWorldBandSpecies_Dragon_6 ; id 14
    dw KeyWorldBandSpecies_Dragon_7 ; id 15
    dw KeyWorldBandSpecies_Beast_0 ; id 16
    dw KeyWorldBandSpecies_Beast_1 ; id 17
    dw KeyWorldBandSpecies_Beast_2 ; id 18
    dw KeyWorldBandSpecies_Beast_3 ; id 19
    dw KeyWorldBandSpecies_Beast_4 ; id 20
    dw KeyWorldBandSpecies_Beast_5 ; id 21
    dw KeyWorldBandSpecies_Beast_6 ; id 22
    dw KeyWorldBandSpecies_Beast_7 ; id 23
    dw KeyWorldBandSpecies_Bird_0 ; id 24
    dw KeyWorldBandSpecies_Bird_1 ; id 25
    dw KeyWorldBandSpecies_Bird_2 ; id 26
    dw KeyWorldBandSpecies_Bird_3 ; id 27
    dw KeyWorldBandSpecies_Bird_4 ; id 28
    dw KeyWorldBandSpecies_Bird_5 ; id 29
    dw KeyWorldBandSpecies_Bird_6 ; id 30
    dw KeyWorldBandSpecies_Bird_7 ; id 31
    dw KeyWorldBandSpecies_Plant_0 ; id 32
    dw KeyWorldBandSpecies_Plant_1 ; id 33
    dw KeyWorldBandSpecies_Plant_2 ; id 34
    dw KeyWorldBandSpecies_Plant_3 ; id 35
    dw KeyWorldBandSpecies_Plant_4 ; id 36
    dw KeyWorldBandSpecies_Plant_5 ; id 37
    dw KeyWorldBandSpecies_Plant_6 ; id 38
    dw KeyWorldBandSpecies_Plant_7 ; id 39
    dw KeyWorldBandSpecies_Bug_0 ; id 40
    dw KeyWorldBandSpecies_Bug_1 ; id 41
    dw KeyWorldBandSpecies_Bug_2 ; id 42
    dw KeyWorldBandSpecies_Bug_3 ; id 43
    dw KeyWorldBandSpecies_Bug_4 ; id 44
    dw KeyWorldBandSpecies_Bug_5 ; id 45
    dw KeyWorldBandSpecies_Bug_6 ; id 46
    dw KeyWorldBandSpecies_Bug_7 ; id 47
    dw KeyWorldBandSpecies_Demon_0 ; id 48
    dw KeyWorldBandSpecies_Demon_1 ; id 49
    dw KeyWorldBandSpecies_Demon_2 ; id 50
    dw KeyWorldBandSpecies_Demon_3 ; id 51
    dw KeyWorldBandSpecies_Demon_4 ; id 52
    dw KeyWorldBandSpecies_Demon_5 ; id 53
    dw KeyWorldBandSpecies_Demon_6 ; id 54
    dw KeyWorldBandSpecies_Demon_7 ; id 55
    dw KeyWorldBandSpecies_Zombie_0 ; id 56
    dw KeyWorldBandSpecies_Zombie_1 ; id 57
    dw KeyWorldBandSpecies_Zombie_2 ; id 58
    dw KeyWorldBandSpecies_Zombie_3 ; id 59
    dw KeyWorldBandSpecies_Zombie_4 ; id 60
    dw KeyWorldBandSpecies_Zombie_5 ; id 61
    dw KeyWorldBandSpecies_Zombie_6 ; id 62
    dw KeyWorldBandSpecies_Zombie_7 ; id 63
    dw KeyWorldBandSpecies_Material_0 ; id 64
    dw KeyWorldBandSpecies_Material_1 ; id 65
    dw KeyWorldBandSpecies_Material_2 ; id 66
    dw KeyWorldBandSpecies_Material_3 ; id 67
    dw KeyWorldBandSpecies_Material_4 ; id 68
    dw KeyWorldBandSpecies_Material_5 ; id 69
    dw KeyWorldBandSpecies_Material_6 ; id 70
    dw KeyWorldBandSpecies_Material_7 ; id 71
    dw KeyWorldBandSpecies_Water_0 ; id 72
    dw KeyWorldBandSpecies_Water_1 ; id 73
    dw KeyWorldBandSpecies_Water_2 ; id 74
    dw KeyWorldBandSpecies_Water_3 ; id 75
    dw KeyWorldBandSpecies_Water_4 ; id 76
    dw KeyWorldBandSpecies_Water_5 ; id 77
    dw KeyWorldBandSpecies_Water_6 ; id 78
    dw KeyWorldBandSpecies_Water_7 ; id 79
    dw KeyWorldBandSpecies_Boss_0 ; id 80
    dw KeyWorldBandSpecies_Boss_1 ; id 81
    dw KeyWorldBandSpecies_Boss_2 ; id 82
    dw KeyWorldBandSpecies_Boss_3 ; id 83
    dw KeyWorldBandSpecies_Boss_4 ; id 84
    dw KeyWorldBandSpecies_Boss_5 ; id 85
    dw KeyWorldBandSpecies_Boss_6 ; id 86
    dw KeyWorldBandSpecies_Boss_7 ; id 87

; row 0 (Slime), band 0 of KeyWorldBandSpeciesTable (E-0256, C1)
; record: count; species
KeyWorldBandSpecies_Slime_0::
    db $03 ; entry 0
    dw MONSTER_SPOTSLIME
    dw MONSTER_SNAILY
    dw MONSTER_SLABBIT

; row 0 (Slime), band 1 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Slime_1::
    db $04 ; entry 0
    dw MONSTER_TREESLIME
    dw MONSTER_BABBLE
    dw MONSTER_SLIME
    dw MONSTER_TROPICGEL

; row 0 (Slime), band 2 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Slime_2::
    db $04 ; entry 0
    dw MONSTER_SPOTSLIME
    dw MONSTER_BOXSLIME
    dw MONSTER_PEARLGEL
    dw MONSTER_HEALER

; row 0 (Slime), band 3 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Slime_3::
    db $05 ; entry 0
    dw MONSTER_DRAKSLIME
    dw MONSTER_SLIMENITE
    dw MONSTER_FANGSLIME
    dw MONSTER_ROCKSLIME
    dw MONSTER_SLIMEBORG

; row 0 (Slime), band 4 of KeyWorldBandSpeciesTable (E-0256, C1)
; record: count; species
KeyWorldBandSpecies_Slime_4::
    db $04 ; entry 0
    dw MONSTER_METALY
    dw MONSTER_SPOTKING
    dw MONSTER_MIMESLIME
    dw MONSTER_HALOSLIME

; row 0 (Slime), band 5 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Slime_5::
    db $03 ; entry 0
    dw MONSTER_KINGSLIME
    dw MONSTER_METABBLE
    dw MONSTER_METALKING

; row 0 (Slime), band 6 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Slime_6::
    db $01 ; entry 0
    dw MONSTER_GOLDSLIME

; row 0 (Slime), band 7 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Slime_7::
    db $02 ; entry 0
    dw MONSTER_GRANSLIME
    dw MONSTER_WONDEREGG

; row 1 (Dragon), band 0 of KeyWorldBandSpeciesTable (E-0256, C1)
; record: count; species
KeyWorldBandSpecies_Dragon_0::
    db $03 ; entry 0
    dw MONSTER_FAIRYDRAK
    dw MONSTER_CHAMELGON
    dw MONSTER_LIZARDFLY

; row 1 (Dragon), band 1 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Dragon_1::
    db $05 ; entry 0
    dw MONSTER_POISONGON
    dw MONSTER_MINIDRAK
    dw MONSTER_KINGCOBRA
    dw MONSTER_SNAKEBAT
    dw MONSTER_CRESTPENT

; row 1 (Dragon), band 2 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Dragon_2::
    db $05 ; entry 0
    dw MONSTER_DRAGONKID
    dw MONSTER_TORTRAGON
    dw MONSTER_PTERANOD
    dw MONSTER_GASGON
    dw MONSTER_WINGSNAKE

; row 1 (Dragon), band 3 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Dragon_3::
    db $04 ; entry 0
    dw MONSTER_SWORDGON
    dw MONSTER_DRYGON
    dw MONSTER_RAYBURN
    dw MONSTER_VAMPIRUS

; row 1 (Dragon), band 4 of KeyWorldBandSpeciesTable (E-0256, C1)
; record: count; species
KeyWorldBandSpecies_Dragon_4::
    db $06 ; entry 0
    dw MONSTER_LIZARDMAN
    dw MONSTER_DRAGON
    dw MONSTER_MADDRAGON
    dw MONSTER_ANDREAL
    dw MONSTER_SPIKEROUS
    dw MONSTER_COATOL

; row 1 (Dragon), band 5 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Dragon_5::
    db $04 ; entry 0
    dw MONSTER_GREATDRAK
    dw MONSTER_BATTLEREX
    dw MONSTER_SKYDRAGON
    dw MONSTER_SERPENTIA

; row 1 (Dragon), band 6 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Dragon_6::
    db $03 ; entry 0
    dw MONSTER_OROCHI
    dw MONSTER_DIVINEGON
    dw MONSTER_GIGADRACO

; row 1 (Dragon), band 7 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Dragon_7::
    db $01 ; entry 0
    dw MONSTER_ORLIGON

; row 2 (Beast), band 0 of KeyWorldBandSpeciesTable (E-0256, C1)
; record: count; species
KeyWorldBandSpecies_Beast_0::
    db $06 ; entry 0
    dw MONSTER_ALMIRAJ
    dw MONSTER_CATFLY
    dw MONSTER_PILLOWRAT
    dw MONSTER_SACCER
    dw MONSTER_ANTBEAR
    dw MONSTER_FAIRYRAT

; row 2 (Beast), band 1 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Beast_1::
    db $06 ; entry 0
    dw MONSTER_SKULLROO
    dw MONSTER_WINDBEAST
    dw MONSTER_MOMMONJA
    dw MONSTER_HAMMERMAN
    dw MONSTER_ARROWDOG
    dw MONSTER_MADGOPHER

; row 2 (Beast), band 2 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Beast_2::
    db $06 ; entry 0
    dw MONSTER_TONGUELLA
    dw MONSTER_BEAVERN
    dw MONSTER_SUPERTEN
    dw MONSTER_IRONTURT
    dw MONSTER_NOCTOKING
    dw MONSTER_BEASTNITE

; row 2 (Beast), band 3 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Beast_3::
    db $06 ; entry 0
    dw MONSTER_GRIZZLY
    dw MONSTER_YETI
    dw MONSTER_GOATEGON
    dw MONSTER_WILDAPE
    dw MONSTER_CATMAGE
    dw MONSTER_DUMBIRA

; row 2 (Beast), band 4 of KeyWorldBandSpeciesTable (E-0256, C1)
; record: count; species
KeyWorldBandSpecies_Beast_4::
    db $04 ; entry 0
    dw MONSTER_GULPBEAST
    dw MONSTER_TRUMPETER
    dw MONSTER_MADCAT
    dw MONSTER_BIGEYE

; row 2 (Beast), band 5 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Beast_5::
    db $02 ; entry 0
    dw MONSTER_UNICORN
    dw MONSTER_DARKHORN

; row 2 (Beast), band 6 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Beast_6::
    db $01 ; entry 0
    dw MONSTER_KINGLEO

; row 2 (Beast), band 7 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Beast_7::
    db $01 ; entry 0
    dw MONSTER_GORAGO

; row 3 (Bird), band 0 of KeyWorldBandSpeciesTable (E-0256, C1)
; record: count; species
KeyWorldBandSpecies_Bird_0::
    db $02 ; entry 0
    dw MONSTER_PICKY
    dw MONSTER_DRACKY

; row 3 (Bird), band 1 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Bird_1::
    db $04 ; entry 0
    dw MONSTER_FLORAJAY
    dw MONSTER_MADRAVEN
    dw MONSTER_KITEHAWK
    dw MONSTER_BIGROOST

; row 3 (Bird), band 2 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Bird_2::
    db $06 ; entry 0
    dw MONSTER_BULLBIRD
    dw MONSTER_MISTYWING
    dw MONSTER_AQUAHAWK
    dw MONSTER_STUBBIRD
    dw MONSTER_LANDOWL
    dw MONSTER_CRAGDEVIL

; row 3 (Bird), band 3 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Bird_3::
    db $06 ; entry 0
    dw MONSTER_WYVERN
    dw MONSTER_DUCKKITE
    dw MONSTER_MADPECKER
    dw MONSTER_MADGOOSE
    dw MONSTER_MADCONDOR
    dw MONSTER_EMYU

; row 3 (Bird), band 4 of KeyWorldBandSpeciesTable (E-0256, C1)
; record: count; species
KeyWorldBandSpecies_Bird_4::
    db $04 ; entry 0
    dw MONSTER_BLIZZARDY
    dw MONSTER_PHOENIX
    dw MONSTER_ZAPBIRD
    dw MONSTER_FUNKYBIRD

; row 3 (Bird), band 5 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Bird_5::
    db $02 ; entry 0
    dw MONSTER_GARUDIAN
    dw MONSTER_WHIPBIRD

; row 3 (Bird), band 6 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Bird_6::
    db $02 ; entry 0
    dw MONSTER_RAINHAWK
    dw MONSTER_SHANTAK

; row 3 (Bird), band 7 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Bird_7::
    db $01 ; entry 0
    dw MONSTER_AZURILE

; row 4 (Plant), band 0 of KeyWorldBandSpeciesTable (E-0256, C1)
; record: count; species
KeyWorldBandSpecies_Plant_0::
    db $04 ; entry 0
    dw MONSTER_CACTIBALL
    dw MONSTER_TOADSTOOL
    dw MONSTER_SLURPERON
    dw MONSTER_EGGPLATON

; row 4 (Plant), band 1 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Plant_1::
    db $03 ; entry 0
    dw MONSTER_MADPLANT
    dw MONSTER_WINGTREE
    dw MONSTER_ONIONO

; row 4 (Plant), band 2 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Plant_2::
    db $05 ; entry 0
    dw MONSTER_FIREWEED
    dw MONSTER_FLORAMAN
    dw MONSTER_GULPPLE
    dw MONSTER_STUBSUCK
    dw MONSTER_DANCEVEGI

; row 4 (Plant), band 3 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Plant_3::
    db $07 ; entry 0
    dw MONSTER_AMBERWEED
    dw MONSTER_TREEBOY
    dw MONSTER_DEVIPINE
    dw MONSTER_BEANMAN
    dw MONSTER_EVILSEED
    dw MONSTER_MANEATER
    dw MONSTER_FOOHERO

; row 4 (Plant), band 4 of KeyWorldBandSpeciesTable (E-0256, C1)
; record: count; species
KeyWorldBandSpecies_Plant_4::
    db $02 ; entry 0
    dw MONSTER_SNAPPER
    dw MONSTER_GHOSTREE

; row 4 (Plant), band 5 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Plant_5::
    db $02 ; entry 0
    dw MONSTER_FACETREE
    dw MONSTER_HERBMAN

; row 4 (Plant), band 6 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Plant_6::
    db $01 ; entry 0
    dw MONSTER_ROSEVINE

; row 4 (Plant), band 7 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Plant_7::
    db $03 ; entry 0
    dw MONSTER_EGDRACIL
    dw MONSTER_WARUBOU
    dw MONSTER_WATABOU

; row 5 (Bug), band 0 of KeyWorldBandSpeciesTable (E-0256, C1)
; record: count; species
KeyWorldBandSpecies_Bug_0::
    db $04 ; entry 0
    dw MONSTER_GIANTSLUG
    dw MONSTER_GIANTWORM
    dw MONSTER_ARMYANT
    dw MONSTER_TAILEATER

; row 5 (Bug), band 1 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Bug_1::
    db $03 ; entry 0
    dw MONSTER_GOPHECADA
    dw MONSTER_BUTTERFLY
    dw MONSTER_GOHOPPER

; row 5 (Bug), band 2 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Bug_2::
    db $05 ; entry 0
    dw MONSTER_LIPSY
    dw MONSTER_STAGBUG
    dw MONSTER_PYURO
    dw MONSTER_EYEDER
    dw MONSTER_BELZEBUB

; row 5 (Bug), band 3 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Bug_3::
    db $07 ; entry 0
    dw MONSTER_CATAPILA
    dw MONSTER_WEEDBUG
    dw MONSTER_ARMORPEDE
    dw MONSTER_GIANTMOTH
    dw MONSTER_DROLL
    dw MONSTER_MADHORNET
    dw MONSTER_MULTIEYES

; row 5 (Bug), band 4 of KeyWorldBandSpeciesTable (E-0256, C1)
; record: count; species
KeyWorldBandSpecies_Bug_4::
    db $02 ; entry 0
    dw MONSTER_ARMYCRAB
    dw MONSTER_SICKLER

; row 5 (Bug), band 5 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Bug_5::
    db $03 ; entry 0
    dw MONSTER_WARMANTIS
    dw MONSTER_HORNBEET
    dw MONSTER_DIGSTER

; row 5 (Bug), band 6 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Bug_6::
    db $01 ; entry 0
    dw MONSTER_ARMORPION

; row 5 (Bug), band 7 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Bug_7::
    db $01 ; entry 0
    dw MONSTER_SKULARACH

; row 6 (Demon), band 0 of KeyWorldBandSpeciesTable (E-0256, C1)
; record: count; species
KeyWorldBandSpecies_Demon_0::
    db $02 ; entry 0
    dw MONSTER_PIXY
    dw MONSTER_DEMONITE

; row 6 (Demon), band 1 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Demon_1::
    db $02 ; entry 0
    dw MONSTER_1EYECLOWN
    dw MONSTER_GREMLIN

; row 6 (Demon), band 2 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Demon_2::
    db $03 ; entry 0
    dw MONSTER_MEDUSAEYE
    dw MONSTER_EYEBALL
    dw MONSTER_ORC

; row 6 (Demon), band 3 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Demon_3::
    db $04 ; entry 0
    dw MONSTER_DARKEYE
    dw MONSTER_SKULRIDER
    dw MONSTER_GIGANTES
    dw MONSTER_EVILARMOR

; row 6 (Demon), band 4 of KeyWorldBandSpeciesTable (E-0256, C1)
; record: count; species
KeyWorldBandSpecies_Demon_4::
    db $06 ; entry 0
    dw MONSTER_AGDEVIL
    dw MONSTER_EVILBEAST
    dw MONSTER_BUBBLEMON
    dw MONSTER_LIONEX
    dw MONSTER_OGRE
    dw MONSTER_MADKNIGHT

; row 6 (Demon), band 5 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Demon_5::
    db $08 ; entry 0
    dw MONSTER_ARCDEMON
    dw MONSTER_GOATHORN
    dw MONSTER_GATEGUARD
    dw MONSTER_CHOPCLOWN
    dw MONSTER_BOSSTROLL
    dw MONSTER_GRENDAL
    dw MONSTER_EVILWELL
    dw MONSTER_CENTASAUR

; row 6 (Demon), band 6 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Demon_6::
    db $04 ; entry 0
    dw MONSTER_AKUBAR
    dw MONSTER_JAMIRUS
    dw MONSTER_DURRAN
    dw MONSTER_LAMPGENIE

; row 6 (Demon), band 7 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Demon_7::
    db $01 ; entry 0
    dw MONSTER_TITANIS

; row 7 (Zombie), band 0 of KeyWorldBandSpeciesTable (E-0256, C1)
; record: count; species
KeyWorldBandSpecies_Zombie_0::
    db $01 ; entry 0
    dw MONSTER_SPOOKY

; row 7 (Zombie), band 1 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Zombie_1::
    db $04 ; entry 0
    dw MONSTER_ROTRAVEN
    dw MONSTER_MUDRON
    dw MONSTER_INVERZON
    dw MONSTER_FOXFIRE

; row 7 (Zombie), band 2 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Zombie_2::
    db $08 ; entry 0
    dw MONSTER_PUTREPUP
    dw MONSTER_MUMMY
    dw MONSTER_SHADOW
    dw MONSTER_SKULPENT
    dw MONSTER_HORK
    dw MONSTER_NITEWHIP
    dw MONSTER_WINDMERGE
    dw MONSTER_POMPOMBOM

; row 7 (Zombie), band 3 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Zombie_3::
    db $06 ; entry 0
    dw MONSTER_DARKCRAB
    dw MONSTER_DEADNITE
    dw MONSTER_REAPER
    dw MONSTER_CAPTDEAD
    dw MONSTER_BONESLAVE
    dw MONSTER_MADSPIRIT

; row 7 (Zombie), band 4 of KeyWorldBandSpeciesTable (E-0256, C1)
; record: count; species
KeyWorldBandSpecies_Zombie_4::
    db $01 ; entry 0
    dw MONSTER_SKELETOR

; row 7 (Zombie), band 5 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Zombie_5::
    db $02 ; entry 0
    dw MONSTER_SKULLGON
    dw MONSTER_SERVANT

; row 7 (Zombie), band 6 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Zombie_6::
    db $04 ; entry 0
    dw MONSTER_DEADNOBLE
    dw MONSTER_WHITEKING
    dw MONSTER_COPYCAT
    dw MONSTER_NITERICH

; row 7 (Zombie), band 7 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Zombie_7::
    db $01 ; entry 0
    dw MONSTER_LAZAMANUS

; row 8 (Material), band 0 of KeyWorldBandSpeciesTable (E-0256, C1)
; record: count; species
KeyWorldBandSpecies_Material_0::
    db $05 ; entry 0
    dw MONSTER_MADCANDLE
    dw MONSTER_FACER
    dw MONSTER_SPIKYBOY
    dw MONSTER_GOOPI
    dw MONSTER_MUDDOLL

; row 8 (Material), band 1 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Material_1::
    db $04 ; entry 0
    dw MONSTER_JEWELBAG
    dw MONSTER_COILBIRD
    dw MONSTER_BRUSHEAD
    dw MONSTER_PROTOMECH

; row 8 (Material), band 2 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Material_2::
    db $03 ; entry 0
    dw MONSTER_EVILWAND
    dw MONSTER_PUPPETOR
    dw MONSTER_CURSELAMP

; row 8 (Material), band 3 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Material_3::
    db $08 ; entry 0
    dw MONSTER_MADMIRROR
    dw MONSTER_ROGUENITE
    dw MONSTER_VOODOLL
    dw MONSTER_SABREMAN
    dw MONSTER_EVILPOT
    dw MONSTER_GISMO
    dw MONSTER_EXAUCERS
    dw MONSTER_CLOUDKING

; row 8 (Material), band 4 of KeyWorldBandSpeciesTable (E-0256, C1)
; record: count; species
KeyWorldBandSpecies_Material_4::
    db $06 ; entry 0
    dw MONSTER_METALDRAK
    dw MONSTER_ROBOSTER
    dw MONSTER_MIMIC
    dw MONSTER_GOLEM
    dw MONSTER_STONEMAN
    dw MONSTER_BOMBCRAG

; row 8 (Material), band 5 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Material_5::
    db $04 ; entry 0
    dw MONSTER_BALZAK
    dw MONSTER_ROBOSTER2
    dw MONSTER_LAVAMAN
    dw MONSTER_ICEMAN

; row 8 (Material), band 6 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Material_6::
    db $01 ; entry 0
    dw MONSTER_GOLDGOLEM

; row 8 (Material), band 7 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Material_7::
    db $01 ; entry 0
    dw MONSTER_DARKMATE

; row 9 (Water), band 0 of KeyWorldBandSpeciesTable (E-0256, C1)
; record: count; species
KeyWorldBandSpecies_Water_0::
    db $03 ; entry 0
    dw MONSTER_PETITEEL
    dw MONSTER_MORAY
    dw MONSTER_PUTREFISH

; row 9 (Water), band 1 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Water_1::
    db $04 ; entry 0
    dw MONSTER_OCTOKID
    dw MONSTER_GAMANIAN
    dw MONSTER_SCALLOPA
    dw MONSTER_STARFISH

; row 9 (Water), band 2 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Water_2::
    db $05 ; entry 0
    dw MONSTER_ANEMON
    dw MONSTER_AQUARELLA
    dw MONSTER_OCTOREACH
    dw MONSTER_ROGUEWAVE
    dw MONSTER_PUMPOISE

; row 9 (Water), band 3 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Water_3::
    db $06 ; entry 0
    dw MONSTER_WALRUSMAN
    dw MONSTER_RAYGIGAS
    dw MONSTER_MERMAN
    dw MONSTER_ANGLERON
    dw MONSTER_FISHRIDER
    dw MONSTER_CLAWSTER

; row 9 (Water), band 4 of KeyWorldBandSpeciesTable (E-0256, C1)
; record: count; species
KeyWorldBandSpecies_Water_4::
    db $05 ; entry 0
    dw MONSTER_RUSHFISH
    dw MONSTER_CANCERMAN
    dw MONSTER_SEAHORSE
    dw MONSTER_HOODSQUID
    dw MONSTER_MERTIGER

; row 9 (Water), band 5 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Water_5::
    db $05 ; entry 0
    dw MONSTER_AXESHARK
    dw MONSTER_OCTOGON
    dw MONSTER_DIGONG
    dw MONSTER_WHALEMAGE
    dw MONSTER_OCTORAID

; row 9 (Water), band 6 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Water_6::
    db $03 ; entry 0
    dw MONSTER_KINGSQUID
    dw MONSTER_AQUADON
    dw MONSTER_GRAKOS

; row 9 (Water), band 7 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Water_7::
    db $01 ; entry 0
    dw MONSTER_POSEIDON

; row 10 (Boss), band 0 of KeyWorldBandSpeciesTable (E-0256, C1)
; record: count; species
KeyWorldBandSpecies_Boss_0::
    db $06 ; entry 0
    dw MONSTER_DRACOLORD
    dw MONSTER_HARGON
    dw MONSTER_BARAMOS
    dw MONSTER_ESTERK
    dw MONSTER_MIRUDRAAS
    dw MONSTER_MUDOU

; row 10 (Boss), band 1 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Boss_1::
    db $06 ; entry 0
    dw MONSTER_DRACOLORD
    dw MONSTER_HARGON
    dw MONSTER_BARAMOS
    dw MONSTER_ESTERK
    dw MONSTER_MIRUDRAAS
    dw MONSTER_MUDOU

; row 10 (Boss), band 2 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Boss_2::
    db $06 ; entry 0
    dw MONSTER_DRACOLORD
    dw MONSTER_HARGON
    dw MONSTER_BARAMOS
    dw MONSTER_ESTERK
    dw MONSTER_MIRUDRAAS
    dw MONSTER_MUDOU

; row 10 (Boss), band 3 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Boss_3::
    db $06 ; entry 0
    dw MONSTER_DRACOLORD
    dw MONSTER_HARGON
    dw MONSTER_BARAMOS
    dw MONSTER_ESTERK
    dw MONSTER_MIRUDRAAS
    dw MONSTER_MUDOU

; row 10 (Boss), band 4 of KeyWorldBandSpeciesTable (E-0256, C1)
; record: count; species
KeyWorldBandSpecies_Boss_4::
    db $06 ; entry 0
    dw MONSTER_DRACOLORD
    dw MONSTER_HARGON
    dw MONSTER_BARAMOS
    dw MONSTER_ESTERK
    dw MONSTER_MIRUDRAAS
    dw MONSTER_MUDOU

; row 10 (Boss), band 5 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Boss_5::
    db $06 ; entry 0
    dw MONSTER_DRACOLORD
    dw MONSTER_HARGON
    dw MONSTER_BARAMOS
    dw MONSTER_ESTERK
    dw MONSTER_MIRUDRAAS
    dw MONSTER_MUDOU
    db $06

; row 10 (Boss), band 6 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Boss_6::
    db $06 ; entry 0
    dw MONSTER_DRACOLORD
    dw MONSTER_HARGON
    dw MONSTER_BARAMOS
    dw MONSTER_ESTERK
    dw MONSTER_MIRUDRAAS
    dw MONSTER_MUDOU

; row 10 (Boss), band 7 of KeyWorldBandSpeciesTable (E-0256, C1)
KeyWorldBandSpecies_Boss_7::
    db $10 ; entry 0
    dw MONSTER_DRACOLORD_160
    dw MONSTER_LORDDRACO
    dw MONSTER_SIDOH
    dw MONSTER_GENOSIDOH
    dw MONSTER_ZOMA
    dw MONSTER_ASURAZOMA
    dw MONSTER_PIZZARO
    dw MONSTER_PSYCHOPIZ
    dw MONSTER_MIRUDRAAS_16C
    dw MONSTER_DEATHMORE
    dw MONSTER_DEATHMORE_16F
    dw MONSTER_DEATHMORE_170
    dw MONSTER_DARKDRIUM
    dw MONSTER_ORGODEMIR
    dw MONSTER_ORGODEMIR_173
    dw MONSTER_DARCK
    ds $ed2, $00
