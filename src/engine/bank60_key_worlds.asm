; ROM bank $60: key worlds: random rooms and the debug automap
; The annotated listing of this bank is build/listing/bank60.asm.

SECTION "Bank 60", ROMX[$4000], BANK[$60]
    db $60

; called from RunMenuStateMenuState_InitSoundHardware: calls FindSRAMSlotMarkerIndex; returns if
; hTemp0 is $ff; copies hTemp0 to wKeyWorldSlot; copies the byte at wKeySeeds to wKeyRandomLo;
; copies the byte at wKeySeeds to wKeyRandomHi; also changes HL and A by register arithmetic
; (E-0347)
; why: a helper of RunMenuStateMenuState_InitSoundHardware, in step 5 of RunMenuStateMenuState (when
; wMenuState & $0F = 5); RunMenuStateMenuState: the field menu (field state 6): by wMenuState & $0F
; it plays the menu's music and sounds, sets the cursor and sub-state of the open menu, ... (E-0352,
; E-0354, E-0122)
RunMenuStateMenuState_FindSRAMSlotMarkerIndex::
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

; Calls DebugAutomap_Update_WriteKeyWorldFlagsAndKeyWorldWidthEtc; calls
; DebugAutomap_Update_RunRandomPatternCase; calls DebugAutomap_Update_NextRandomSeed; calls
; DebugAutomap_Update_MergeKeyWorldAreas; calls DebugAutomap_Update_WriteTemp0AndTemp1Etc; calls
; DebugAutomap_Update_Return; calls DebugAutomap_Update_SetTemp0; may continue in
; DebugAutomap_Update_DebugAutomap_Update_MergeKeyWorldAreas; calls
; DebugAutomap_Update_WriteKeyWorldGenRoomAndTemp8Etc; calls DebugAutomap_Update_WriteTemp0AndTemp1;
; calls DebugAutomap_Update_SetKeyWorldBandForA; calls
; DebugAutomap_Update_LoadKeyWorldLevelBaseTripleForPartyStrength; then 1 more step (see the code)
; (E-0347)
; why: part of DebugAutomap_Update; DebugAutomap_Update: update for debug-mode state 3: the screen
; shows '? AUTOMAP ?' (key, level, position) (E-0352, E-0041)
DebugAutomap_Update_DebugAutomap_Update_MergeKeyWorldAreas::
    call DebugAutomap_Update_WriteKeyWorldFlagsAndKeyWorldWidthEtc
    call DebugAutomap_Update_RunRandomPatternCase
    call DebugAutomap_Update_NextRandomSeed
    call DebugAutomap_Update_MergeKeyWorldAreas
    call DebugAutomap_Update_WriteTemp0AndTemp1Etc
    call DebugAutomap_Update_Return
    call DebugAutomap_Update_SetTemp0
    or a
    jr nz, DebugAutomap_Update_DebugAutomap_Update_MergeKeyWorldAreas
    farcall DebugAutomap_Update_WriteKeyWorldGenRoomAndTemp8Etc
    call DebugAutomap_Update_WriteTemp0AndTemp1
    call DebugAutomap_Update_SetKeyWorldBandForA
    call DebugAutomap_Update_LoadKeyWorldLevelBaseTripleForPartyStrength
    call DebugAutomap_Update_WriteKeyWorldGoalScreenAndTemp3Etc
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

; Calls LoadKeyWorldLevelBaseTripleForPartyStrength; calls LoadKeyWorldParamsForCurrentKeyIndex;
; calls RollKeyWorldMonsterTableKeyWorldMonsters; calls FillKeyWorldMonsters1LevelsForPartyStrength;
; calls RollKeyWorldMonsterTableKeyWorldBossMonsters; calls FillKeyWorldBossMonsters1LevelsSlope;
; calls RollKeyWorldMonsterIds; calls RollKeyWorldEncounterTable (E-0347)
; why: part of DebugAutomap_Update; DebugAutomap_Update: update for debug-mode state 3: the screen
; shows '? AUTOMAP ?' (key, level, position) (E-0352, E-0041)
DebugAutomap_Update_LoadKeyWorldLevelBaseTripleForPartyStrength::
    call LoadKeyWorldLevelBaseTripleForPartyStrength
    call LoadKeyWorldParamsForCurrentKeyIndex
    call RollKeyWorldMonsterTableKeyWorldMonsters
    call FillKeyWorldMonsters1LevelsForPartyStrength
    call RollKeyWorldMonsterTableKeyWorldBossMonsters
    call FillKeyWorldBossMonsters1LevelsSlope
    call RollKeyWorldMonsterIds
    call RollKeyWorldEncounterTable
    ret

; fills 32 two-byte entries from wKeyWorldMonsters with random monster ids from the
; wKeyWorldMonsterBands band lists (rows from KeyWorldBossBandPickRows by wKeyWorldBandAdjust)
; (E-0130)
RollKeyWorldMonsterTableKeyWorldMonsters::
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
    add $23
    ld e, a
    ld a, d
    adc $41
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

; RollKeyWorldMonsterTableKeyWorldBossMonsters reads the byte at $4123 + 8 * wKeyWorldBandAdjust +
; (random & 7), doubles it and reads the band-list pointer at $6D6D + $90 + that offset; it retries
; when the list is empty; 34 rows end at FillKeyWorldMonsters1LevelsForPartyStrength ($4233); higher
; rows pick from more bands (E-0192, C1)
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

; for 32 entries from wKeyWorldMonsters + $1 ORs 2 * min(wKeyWorldLevelBase + (32 - n) *
; (wPartyStrength + 10) / 150 / 2, 99) into every other byte (E-0125) (E-0340: the address in its
; name read as its RAM name; was FillKeyWorldMonsters1LevelsForPartyStrength)
FillKeyWorldMonsters1LevelsForPartyStrength::
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

; fills 8 two-byte entries from wKeyWorldBossMonsters with random monster ids from the band lists
; (KeyWorldBossBandPickRows row wKeyWorldBandAdjust) (E-0129)
RollKeyWorldMonsterTableKeyWorldBossMonsters::
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

; for 8 entries from wKeyWorldBossMonsters + $1 ORs 2 * min(wKeyWorldLevelBase + 15 *
; (wPartyStrength + 10) / 150 / 2, 99) into every other byte (E-0127) (E-0340: the address in its
; name read as its RAM name; was FillKeyWorldBossMonsters1LevelsSlope)
FillKeyWorldBossMonsters1LevelsSlope::
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

; for 8 entries from wKeyWorldBossMonsters + $1 ORs 2 * min(wPartyStrength + 3 * (wPartyStrength /
; 10), 99) into every other byte (E-0125) (E-0340: the address in its name read as its RAM name; was
; FillKeyWorldBossMonsters1LevelsForPartyStrength)
FillKeyWorldBossMonsters1LevelsForPartyStrength::
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

; clears wKeyWorldEncounterTable ($10 bytes) and fills a 4-byte entry per map area (from
; wKeyWorldObjects) with a random monster id and level from the band lists (E-0128)
RollKeyWorldEncounterTable::
    ld b, $10
    ld hl, wKeyWorldEncounterTable
    xor a

.loop:
    ld [hli], a
    dec b
    jr nz, .loop
    ld a, [wPartyStrength]
    call BandForA
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

; like RollKeyWorldEncounterTable, with each entry's level from wPartyStrength / 5 * 7 plus the area
; value, capped at 99 (E-0129)
RollKeyWorldEncounterTableLevels::
    ld b, $10
    ld hl, wKeyWorldEncounterTable
    xor a

.loop:
    ld [hli], a
    dec b
    jr nz, .loop
    ld a, [wPartyStrength]
    call BandForA
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

; picks random monster ids for the key world from the wKeyWorldMonsterBands lists by band
; (PickRandomMonsterFromBandList) into wKeyWorldEncounter-wKeyWorldEncounter + $7, and
; wKeyWorldEncounter + $2/wKeyWorldEncounter + $5/wKeyWorldEncounter + $8 from wKeyWorldLevelMonster
; (E-0127)
RollKeyWorldMonsterIds::
    ld a, [wPartyStrength]
    call BandForA
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

; A = 2-7 by thresholds 20, 40, 60, 70, 80, 90, 95 (E-0125) (E-0344: the address in its name dropped
; or read as the label there; was BandForA)
BandForA::
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
    add $c5
    ld l, a
    ld a, h
    adc $47
    ld h, a
    ld a, [hli]
    ld [wKeyWorldLevelBase], a
    ld a, [hli]
    ld [wKeyWorldLevelArea], a
    ld a, [hli]
    ld [wKeyWorldLevelMonster], a
    ret

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

; Sets wKeyWorldFlags to 0; calls ClearKeyWorldActiveWhenKeyWorldKeyMatchesKeyWorldSlot; calls
; PickRandomNonzeroFromKeyWorldGoalKindRows; calls NextRandomSeed; branches on wKeyRandomHi & $0f;
; sets wKeyWorldWidth to $0a; sets wMapWidthScreens to $0a; branches on wKeyRandomHi & $0f; sets
; wKeyWorldHeight to $0a; sets wMapHeightScreens to $0a; copies wKeyWorldWidth to hTemp8; copies
; wKeyWorldHeight to hTemp9; then 9 more steps (see the code) (E-0347)
; why: part of DebugAutomap_Update; DebugAutomap_Update: update for debug-mode state 3: the screen
; shows '? AUTOMAP ?' (key, level, position) (E-0352, E-0041)
DebugAutomap_Update_WriteKeyWorldFlagsAndKeyWorldWidthEtc::
    xor a
    ld [wKeyWorldFlags], a
    call ClearKeyWorldActiveWhenKeyWorldKeyMatchesKeyWorldSlot
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
    add $f4
    ld l, a
    ld a, h
    adc $4b
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
    ld hl, DebugAutomap_Update_WriteKeyWorldFlagsAndKeyWorldWidthEtc_Data
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
    db $44, $44, $44, $44, $44, $44, $44, $44, $44, $44
    ds $5a, $88

; data read by DebugAutomap_Update_WriteKeyWorldFlagsAndKeyWorldWidthEtc (20 bytes) (E-0347)
DebugAutomap_Update_WriteKeyWorldFlagsAndKeyWorldWidthEtc_Data::
    db $00, $0f, $08, $0f, $08, $0f, $10, $1f, $10, $1f, $10, $1f, $10, $1f, $10, $1f
    db $10, $1f, $10, $1f

; when wKeyWorldActive is set and wKeyWorldKey has bit 7 with low bits equal to wKeyWorldSlot,
; clears wKeyWorldActive (E-0122)
ClearKeyWorldActiveWhenKeyWorldKeyMatchesKeyWorldSlot::
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

; Copies L to hTemp0; copies H to hTemp1; copies E to hTemp5; copies D to hTemp6; sets hTemp7 to 0;
; branches on the byte at wKeyWorldChunks + $3; calls RunRandomPatternCase; increments hTemp7;
; copies E to hTemp5; copies D to hTemp6; copies L to hTemp0; copies H to hTemp1; then 2 more steps
; (see the code) (E-0347)
; why: part of DebugAutomap_Update; DebugAutomap_Update: update for debug-mode state 3: the screen
; shows '? AUTOMAP ?' (key, level, position) (E-0352, E-0041)
DebugAutomap_Update_RunRandomPatternCase::
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

; ORs the low nibbles of the four wKeyWorldAreas bytes into wKeyWorldAreaInfo (E-0305)
DebugAutomap_Update_MergeKeyWorldAreas::
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

; Branches on hTemp7; calls NextRandomSeed; branches on wKeyRandomHi & $03; copies wKeyRandomHi &
; $03 to hTemp0; calls NextRandomSeed; branches on wKeyRandomHi & $03; branches on hTemp0; copies C
; to hTemp1; branches on the byte at wKeyWorldAreas; branches on hTemp0; branches on hTemp1;
; branches on the byte at wKeyWorldAreas; then 16 more steps (see the code) (E-0347)
; why: part of DebugAutomap_Update; DebugAutomap_Update: update for debug-mode state 3: the screen
; shows '? AUTOMAP ?' (key, level, position) (E-0352, E-0041)
DebugAutomap_Update_NextRandomSeed::
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

; Sets hTemp0 to 0; branches on the byte at wKeyWorldAreas; branches on the byte at wKeyWorldAreas &
; $0f; copies the byte at wKeyWorldAreas & $0f to hTemp0; copies B to hTemp1; branches on B; copies
; B to hTemp2; branches on B; calls PlaceTwoRandomOpenCells; sets wKeyWorldAreaExits to $ff; also
; changes HL, DE, BC and A by register arithmetic (E-0347)
; why: part of DebugAutomap_Update; DebugAutomap_Update: update for debug-mode state 3: the screen
; shows '? AUTOMAP ?' (key, level, position) (E-0352, E-0041)
DebugAutomap_Update_WriteTemp0AndTemp1Etc::
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

; picks two random open cells (ReadKeyWorldCellIsSolid) in the areas named by hTemp1 and hTemp2,
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
    call ReadKeyWorldCellIsSolid
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
    call ReadKeyWorldCellIsSolid
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

; reads the cell at (hTemp3, hTemp4) from the area map chunk in wKeyWorldChunks; A = 1 when its byte
; is not $FF, else 0 (E-0128)
ReadKeyWorldCellIsSolid::
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

; Returns at once (E-0347)
; why: part of DebugAutomap_Update; DebugAutomap_Update: update for debug-mode state 3: the screen
; shows '? AUTOMAP ?' (key, level, position) (E-0352, E-0041)
DebugAutomap_Update_Return::
    ret

; Copies L to hTemp0; copies H to hTemp1; returns if the byte at wKeyWorldFloorInfo + $3 is $ff;
; branches on the byte at wKeyWorldFloorInfo + $3; calls NextRandomSeed; branches on wKeyRandomHi &
; $7f; branches on $03; calls NextRandomSeed; sets DebugAutomap_Update_WriteTemp0AndTemp1_Data to
; $80; sets DebugAutomap_Update_WriteTemp0AndTemp1_Data to $81; sets hTemp0; sets hTemp1; then 1
; more step (see the code) (E-0347)
; why: part of DebugAutomap_Update; DebugAutomap_Update: update for debug-mode state 3: the screen
; shows '? AUTOMAP ?' (key, level, position) (E-0352, E-0041)
DebugAutomap_Update_WriteTemp0AndTemp1::
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
    ld hl, DebugAutomap_Update_WriteTemp0AndTemp1_Data
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

; data read by DebugAutomap_Update_WriteTemp0AndTemp1 (64 bytes) (E-0347)
DebugAutomap_Update_WriteTemp0AndTemp1_Data::
    db $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4a, $4b, $4c, $4d, $4e, $4f
    db $50, $51, $52, $53, $5a, $5b, $5c, $5d, $5e, $5f, $60, $61, $40, $41, $42, $43
    db $44, $45, $46, $47, $48, $49, $4a, $4b, $4c, $4d, $4e, $4f, $50, $51, $52, $53
    db $5a, $5b, $5c, $5d, $5e, $5f, $60, $61, $40, $41, $42, $43, $44, $45, $46, $47

; Branches on hTemp7; sets hTemp0 to 0; sets hTemp1 to 0; branches on the byte at wKeyWorldAreas;
; branches on the byte at wKeyWorldAreas & $0f; increments hTemp1; branches on the byte at
; wKeyWorldAreas & $0f; sets hTemp0; branches on B; calls ReadByteInBank; copies C to hTemp5; copies
; L to hTemp0; then 12 more steps (see the code) (E-0347)
; why: part of DebugAutomap_Update; DebugAutomap_Update: update for debug-mode state 3: the screen
; shows '? AUTOMAP ?' (key, level, position) (E-0352, E-0041)
DebugAutomap_Update_SetTemp0::
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
    jr z, .call_read_key_world_cell_is_solid
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    cp c
    jr z, .check_temp_a
    ld a, $07
    add_a_to_hl
    jr .skip3

.call_read_key_world_cell_is_solid:
    push bc
    call ReadKeyWorldCellIsSolid
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

; Calls SetKeyWorldBandForA; sets wKeyWorldBand; copies the byte at
; DebugAutomap_Update_SetKeyWorldBandForA_Data to wMapObjectCount; copies B to hTemp0; calls
; RollKeyWorldObjectKind; calls PlaceKeyWorldObjectAtRandomCell; sets wMapObjectCount; also changes
; HL, DE, BC and A by register arithmetic (E-0347)
; why: part of DebugAutomap_Update; DebugAutomap_Update: update for debug-mode state 3: the screen
; shows '? AUTOMAP ?' (key, level, position) (E-0352, E-0041)
DebugAutomap_Update_SetKeyWorldBandForA::
    ld a, [wPartyStrength]
    call SetKeyWorldBandForA

.loop:
    ld [wKeyWorldBand], a
    ld hl, DebugAutomap_Update_SetKeyWorldBandForA_Data
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

; data read by DebugAutomap_Update_SetKeyWorldBandForA (16 bytes) (E-0347)
DebugAutomap_Update_SetKeyWorldBandForA_Data::
    db $0a, $0a, $0a, $0a, $0a, $0a, $0a, $0a, $0f, $0f, $0f, $0f, $14, $14, $14, $14

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
    add $6f
    ld l, a
    ld a, h
    adc $55
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

; data read by RollKeyWorldObjectKind (716 bytes) (E-0347)
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

; Calls NextRandomSeed; branches on wKeyRandomHi & $7f; branches on B; calls NextRandomSeed;
; branches on wKeyRandomHi & $7f; branches on the byte at
; FieldState_MapTransition_NextRandomSeed_Data; calls NextRandomSeed; branches on wKeyRandomHi &
; $7f; copies L to hTemp0; copies H to hTemp1; calls NextRandomSeed; branches on wKeyRandomHi & $0f;
; then 2 more steps (see the code) (E-0347)
; why: part of FieldState_MapTransition; FieldState_MapTransition: field state 4: a map or screen
; transition: warps, the key-world floor and the transition steps (wFieldTransitionStep) (E-0352,
; E-0339)
FieldState_MapTransition_NextRandomSeed::
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
    add $29
    ld l, a
    ld a, h
    adc $5a
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
    ld hl, FieldState_MapTransition_NextRandomSeed_Data
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

; data read by FieldState_MapTransition_NextRandomSeed (530 bytes) (E-0347)
FieldState_MapTransition_NextRandomSeed_Data::
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

; Copies wKeyWorldFloorInfo to wKeyWorldGoalScreen; copies wKeyWorldFloorInfo & $0f to hTemp3;
; copies wKeyWorldFloorInfo & $0f to hTemp4; calls ReadByteInBank; branches on C; copies the byte at
; DebugAutomap_Update_WriteKeyWorldGoalScreenAndTemp3Etc_Data to wKeyWorldGoalPos; copies the byte
; at DebugAutomap_Update_WriteKeyWorldGoalScreenAndTemp3Etc_Data to wKeyWorldGoalPos2; also changes
; HL, DE, BC and A by register arithmetic (E-0347)
; why: part of DebugAutomap_Update; DebugAutomap_Update: update for debug-mode state 3: the screen
; shows '? AUTOMAP ?' (key, level, position) (E-0352, E-0041)
DebugAutomap_Update_WriteKeyWorldGoalScreenAndTemp3Etc::
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
    ld hl, DebugAutomap_Update_WriteKeyWorldGoalScreenAndTemp3Etc_Data
    add_a_to_hl
    ld a, [hli]
    ld [wKeyWorldGoalPos], a
    ld a, [hl]
    ld [wKeyWorldGoalPos2], a
    ret

; data read by DebugAutomap_Update_WriteKeyWorldGoalScreenAndTemp3Etc (16 bytes) (E-0347)
DebugAutomap_Update_WriteKeyWorldGoalScreenAndTemp3Etc_Data::
    db $10, $10, $10, $60, $40, $20, $40, $60, $50, $20, $50, $60, $70, $30, $80, $70

; runs one of four routines chosen by random & $0F through a 16-entry table (E-0124)
RunRandomPatternCase::
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $0f
    jumptable
    dw RunRandomPatternCase_StoreThreeBytesBeforeTemp0Pointer
    dw RunRandomPatternCase_WriteTempA
    dw RunRandomPatternCase_WriteTempA_3
    dw RunRandomPatternCase_WriteTempA_2
    dw RunRandomPatternCase_WriteTempA_3
    dw RunRandomPatternCase_WriteTempA
    dw RunRandomPatternCase_StoreThreeBytesBeforeTemp0Pointer
    dw RunRandomPatternCase_WriteTempA
    dw RunRandomPatternCase_WriteTempA_3
    dw RunRandomPatternCase_WriteTempA_2
    dw RunRandomPatternCase_WriteTempA_3
    dw RunRandomPatternCase_WriteTempA
    dw RunRandomPatternCase_StoreThreeBytesBeforeTemp0Pointer
    dw RunRandomPatternCase_WriteTempA
    dw RunRandomPatternCase_WriteTempA_3
    dw RunRandomPatternCase_WriteTempA_2
    db $c9, $c9

; step 3 of RunRandomPatternCase: branches on B & $01; branches on B; calls NextRandomSeed; calls
; StoreThreeBytesBeforeTemp0Pointer; calls StoreTemp2To3BytesBeforeHLPlusTemp0; copies hTemp7 & $f0
; to hTempA; calls ReadByteInBank; also changes HL, DE, BC and A by register arithmetic (E-0347)
; why: step 3 of RunRandomPatternCase (when wKeyRandomHi & $0F = 3); RunRandomPatternCase: runs one
; of four routines chosen by random & $0F through a 16-entry table (E-0352, E-0124)
RunRandomPatternCase_WriteTempA_2::
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
    ld de, RunRandomPatternCase_WriteTempA_Data_3
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

; step 2 of RunRandomPatternCase: branches on B & $01; calls NextRandomSeed; calls
; StoreThreeBytesBeforeTemp0Pointer; calls StoreTemp2To3BytesBeforeHLPlusTemp0; copies hTemp7 & $f0
; to hTempA; calls ReadByteInBank; also changes HL, DE, BC and A by register arithmetic (E-0347)
; why: step 2 of RunRandomPatternCase (when wKeyRandomHi & $0F = 2); RunRandomPatternCase: runs one
; of four routines chosen by random & $0F through a 16-entry table (E-0352, E-0124)
RunRandomPatternCase_WriteTempA_3::
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
    ld de, RunRandomPatternCase_WriteTempA_Data_2
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

; step 1 of RunRandomPatternCase: branches on B; calls NextRandomSeed; calls
; StoreThreeBytesBeforeTemp0Pointer; calls StoreTemp2To3BytesBeforeHLPlusTemp0; copies hTemp7 & $f0
; to hTempA; calls ReadByteInBank; also changes HL, DE, BC and A by register arithmetic (E-0347)
; why: step 1 of RunRandomPatternCase (when wKeyRandomHi & $0F = 1); RunRandomPatternCase: runs one
; of four routines chosen by random & $0F through a 16-entry table (E-0352, E-0124)
RunRandomPatternCase_WriteTempA::
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
    ld de, RunRandomPatternCase_WriteTempA_Data
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

; step 0 of RunRandomPatternCase: calls NextRandomSeed; calls StoreThreeBytesBeforeTemp0Pointer;
; copies hTemp7 & $f0 to hTempA; calls ReadByteInBank; also changes HL, DE, BC and A by register
; arithmetic (E-0347)
; why: step 0 of RunRandomPatternCase (when wKeyRandomHi & $0F = 0); RunRandomPatternCase: runs one
; of four routines chosen by random & $0F through a 16-entry table (E-0352, E-0124)
RunRandomPatternCase_StoreThreeBytesBeforeTemp0Pointer::
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

; RunRandomPatternCase_StoreThreeBytesBeforeTemp0Pointer/01/02 pick entry (random & $1F) of the
; lists at $610D, $616D and $61E5 and store the far pointer in the key-world area data; the far
; pointers run to $62F8 and all point at chunk groups ($61 bytes per sub-chunk) (E-0146, C1)
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
RunRandomPatternCase_WriteTempA_Data::
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
RunRandomPatternCase_WriteTempA_Data_2::
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
RunRandomPatternCase_WriteTempA_Data_3::
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

; data read by RefreshKeyWorldObjectsOnEntry (16 bytes) (E-0347)
RefreshKeyWorldObjectsOnEntry_Data::
    db $0a, $0a, $0a, $0a, $0a, $0a, $0a, $0a, $0f, $0f, $0f, $0f, $14, $14, $14, $14

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
    call RemoveMapObjectsEntryMatching
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
    call RemoveMapObjectsEntryMatching
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
    call RemoveMapObjectsEntryMatching
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
    call RemoveMapObjectsEntryMatching
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
    call RemoveMapObjectsEntryMatching
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
    call RemoveMapObjectsEntryMatching
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
    call RemoveMapObjectsEntryMatching
    ld a, $07
    ldh [hTemp0], a
    call MarkMapObjectsEntryForKeyWorldGoalCell
    ret

; clears bit 7 of wKeyWorldRefresh; walks the wMapObjectCount 8-byte entries at wMapObjects and
; drops the count at the first entry for which RemoveMapObjectsEntryMatching_NextRandomSeed returns
; 0 (E-0125)
RemoveMapObjectsEntryMatching::
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
    call RemoveMapObjectsEntryMatching_NextRandomSeed
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

; called from RemoveMapObjectsEntryMatching: sets hTempA to 0; calls NextRandomSeed; branches on
; wKeyRandomHi & $0f; copies wKeyRandomHi & $0f to hTemp3; calls NextRandomSeed; branches on
; wKeyRandomHi & $0f; copies wKeyRandomHi & $0f to hTemp4; sets hTemp5; branches on wKeyRandomHi &
; $0f; branches on the byte at wMapObjects + $4; increments hTempA; branches on hTempA; then 5 more
; steps (see the code) (E-0347)
; why: a helper of RemoveMapObjectsEntryMatching; RemoveMapObjectsEntryMatching: clears bit 7 of
; wKeyWorldRefresh (E-0352, E-0125)
RemoveMapObjectsEntryMatching_NextRandomSeed::
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

; called from FieldState_MapTransition: branches on wMapType; calls
; FieldState_MapTransition_WriteScreenTriggerCountAndWarpPending; branches on hMapId; branches on
; hMapScreenX; returns if hMapScreenY is $01; branches on hMapId; branches on hMapScreenX; returns
; if hMapScreenY is $02; branches on the byte at FieldState_MapTransition_Data2; sets
; wScreenTriggerCount to 0; branches on 0; branches on wWarpPending; then 10 more steps (see the
; code) (E-0347)
; why: a helper of FieldState_MapTransition; FieldState_MapTransition: field state 4: a map or
; screen transition: warps, the key-world floor and the transition steps (wFieldTransitionStep)
; (E-0352, E-0339)
FieldState_MapTransition_WriteScreenTriggerCountAndWarpPendingEtc::
    ld a, [wMapType]
    bit 7, a
    jr z, .check_map_id
    call FieldState_MapTransition_WriteScreenTriggerCountAndWarpPending
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
    ld hl, FieldState_MapTransition_Data2
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
    ld hl, FieldState_MapTransition_Data1
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
    call FieldState_MapTransition_NextRandomSeed
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

; data read by FieldState_MapTransition (11 bytes) (E-0347)
FieldState_MapTransition_Data1::
    db $00, $03, $03, $03, $03, $06, $06, $09, $09, $0c, $0c

FieldState_MapTransition_Data2::
    db $2b, $38, $39, $3a, $53, $5d, $82, $83, $ad, $ae, $ff

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
    add $9c
    ld l, a
    ld a, h
    adc $66
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

; Branches on wMapType & $07; sets wScreenTriggerCount to 0; branches on wKeyWorldArea; branches on
; the byte at wKeyWorldFloorState + $4; branches on wWarpPending; sets wWarpPending to 0; calls
; SetKeyWorldBandForA; sets wScreenTriggerCount to 2; calls FieldState_MapTransition_NextRandomSeed;
; calls WriteRandomEntryFromTable; may return early; sets wScreenTriggerCount to 1; then 1 more step
; (see the code) (E-0347)
; why: part of FieldState_MapTransition; FieldState_MapTransition: field state 4: a map or screen
; transition: warps, the key-world floor and the transition steps (wFieldTransitionStep) (E-0352,
; E-0339)
FieldState_MapTransition_WriteScreenTriggerCountAndWarpPending::
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
    call FieldState_MapTransition_NextRandomSeed
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

; data read by WriteRandomEntryFromTable (8 bytes) (E-0347)
WriteRandomEntryFromTable_Data::
    db $01, $10, $12, $13, $20, $21, $23, $32

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

; repeats NextRandomSeed until wKeyRandomHi & $7F is below 100; returns A = that value (E-0116)
RandomBelow100::
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $7f
    cp $64
    jr nc, RandomBelow100
    ret

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

; a copy of KeyWorldAreaLayoutTable (84:$4CCB), word for word;
; DebugAutomap_Update_SetTemp0.read_key_world_area_count and PlaceObjectInAreaC read the layout's
; first byte or a block byte through ReadByteInBank with B = $84 (E-0193, C1)
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

; PickRandomMonsterFromBandList (with RollKeyWorldMonsterTableKeyWorldMonsters and ...BossMonsters)
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
