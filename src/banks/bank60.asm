SECTION "Bank 60", ROMX[$4000], BANK[$60]
    db $60

; only called from RunMenuStateMenuState_Case05 (E-0047)
; 1 call site from 1 routine (e.g. RunMenuStateMenuState_InitSoundHardware)
; reads: wCurrentKeyIndex, hTemp0
; writes: wKeyWorldSlot, wKeyRandomLo, wKeyRandomHi
; points at: wKeySeeds
RunMenuStateMenuState_Case05_FindSRAMSlotMarkerIndex::
Func_060_4001:: ; address name
    ld a, [wCurrentKeyIndex]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    push hl
    call FindSRAMSlotMarkerIndex
    pop hl
    ldh a, [hTemp0]
    cp a, $FF
    ret z
    ld [wKeyWorldSlot], a
    or a, $80
    ld [hl], a
    ld a, [wCurrentKeyIndex]
    add a, a
    ld hl, wKeySeeds
    add_a_to_hl
    ld a, [hl+]
    ld [wKeyRandomLo], a
    ld a, [hl]
    ld [wKeyRandomHi], a

; only called from DebugAutomap_Update_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_RollKeyContentsForLevelTemp0)
; reads: wCurrentKeyIndex
DebugAutomap_Update_Sub01_DebugAutomap_Update_MergeKeyWorldAreas::
Func_060_4035:: ; address name
    call DebugAutomap_Update_Sub01_Sub01_WriteKeyWorldFlagsAndKeyWorldWidthEtc
    call DebugAutomap_Update_Sub01_Sub01_RunRandomPatternCase
    call DebugAutomap_Update_Sub01_Sub01_NextRandomSeed
    call DebugAutomap_Update_MergeKeyWorldAreas
    call DebugAutomap_Update_Sub01_Sub01_WriteTemp0AndTemp1Etc
    call DebugAutomap_Update_Sub01_Sub01_Return
    call DebugAutomap_Update_Sub01_Sub01_WriteTemp0AndTemp1Etc_Sub08
    or a, a
    jr nz, DebugAutomap_Update_Sub01_DebugAutomap_Update_MergeKeyWorldAreas
    farcall DebugAutomap_Update_Sub01_Sub01_WriteKeyWorldByte46AndTemp8Etc
    call DebugAutomap_Update_Sub01_Sub01_WriteTemp0AndTemp1
    call DebugAutomap_Update_Sub01_Sub01_SetKeyWorldBandForA
    call DebugAutomap_Update_Sub01_Sub01_LoadKeyWorldLevelBaseTripleForPartyStrength
    call DebugAutomap_Update_Sub01_Sub01_WriteKeyWorldGoalScreenAndTemp3Etc
    ld a, [wCurrentKeyIndex]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [hl]
    and a, $BF
    or a, $80
    ld [hl], a
    ret

; only called from DebugAutomap_Update_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_DebugAutomap_Update_MergeKeyWorldAreas)
DebugAutomap_Update_Sub01_Sub01_LoadKeyWorldLevelBaseTripleForPartyStrength::
Func_060_4076:: ; address name
    call LoadKeyWorldLevelBaseTripleForPartyStrength
    call LoadKeyWorldParamsForCurrentKeyIndex
    call RollKeyWorldMonsterTableKeyWorldMonsters
    call FillWCD11LevelsForPartyStrength
    call RollKeyWorldMonsterTableKeyWorldBossMonsters
    call FillWCD51LevelsSlope
    call RollKeyWorldMonsterIds
    call RollKeyWorldEncounterTable
    ret

; fills 32 two-byte entries from wCD10 with random monster ids from the wCCF7 band lists (rows from Data_060_4123 by wCD02) (E-0130)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_LoadKeyWorldLevelBaseTripleForPartyStrength)
; reads: wKeyWorldBandAdjust, wKeyRandomHi, hTemp0, hTemp1
; writes: hTemp0, hTemp1
; points at: wKeyWorldMonsters, wKeyWorldMonsterBands
RollKeyWorldMonsterTableKeyWorldMonsters::
Func_060_408F:: ; address name
    ld b, $20
    ld de, wKeyWorldMonsters
    ld a, e
    ldh [hTemp0], a
    ld a, d
    ldh [hTemp1], a

.loop:
    ld hl, wKeyWorldMonsterBands

.loop2:
    ld a, [hl+]
    cp a, $FF
    jr z, .loop
    push hl
    push af
    ld a, [wKeyWorldBandAdjust]
    cp a, $10
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
    add a, $23
    ld e, a
    ld a, d
    adc a, $41
    ld d, a
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $0F
    add a, e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    add a, a
    ld c, a
    pop af
    swap a
    ld de, KeyWorldBandSpeciesTable
    add a, e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, c
    add a, e
    ld e, a
    jr nc, .skip4
    inc d

.skip4:
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [hl+]
    or a, a
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
    and a, $07
    cp a, c
    jr nc, .loop3

.read_temp0:
    add a, a
    add_a_to_hl
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, [hl+]
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

; E-0192 (C1: RollKeyWorldMonsterTableKeyWorldBossMonsters reads the byte at $4123 + 8 * wKeyWorldBandAdjust + (random & 7), doubles it and reads the band-list pointer at $6D6D + $90 + that offset; it retries when the list is empty; 34 rows end at FillWCD11LevelsForPartyStrength ($4233); higher rows pick from more bands).
; record: eight picks for one wKeyWorldBandAdjust value; a random 0-7 chooses one
KeyWorldBossBandPickRows::
Data_060_4123:: ; address name
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

; for 32 entries from wCD11 ORs 2 * min(wC969 + (32 - n) * (wCD05 + 10) / 150 / 2, 99) into every other byte (E-0125)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_LoadKeyWorldLevelBaseTripleForPartyStrength)
; reads: wKeyWorldLevelBase, wPartyStrength
FillWCD11LevelsForPartyStrength::
Func_060_4233:: ; address name
    ld b, $20
    ld de, wKeyWorldMonsters + $1
    ld a, [wKeyWorldLevelBase]
    ld c, a

.loop:
    push bc
    push bc
    push de
    ld a, $20
    sub a, b
    ld c, a
    ld a, [wPartyStrength]
    add a, $0A
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
    or a, a
    jr nz, .skip
    ld a, l
    cp a, $64
    jr c, .skip2

.skip:
    ld l, $63

.skip2:
    ld c, l
    sla c
    ld a, [de]
    or a, c
    ld [de], a
    inc de
    inc de
    pop bc
    dec b
    jr nz, .loop
    ret

; fills 8 two-byte entries from wCD50 with random monster ids from the band lists (Data_060_4123 row wCD02) (E-0129)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_LoadKeyWorldLevelBaseTripleForPartyStrength)
; reads: wKeyRandomHi, wKeyWorldBandAdjust, hTemp0, hTemp1
; writes: hTemp0, hTemp1
; points at: wKeyWorldMonsters
RollKeyWorldMonsterTableKeyWorldBossMonsters::
Func_060_4274:: ; address name
    ld b, $08
    ld a, $40
    ld de, wKeyWorldMonsters
    add a, e
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
    add a, e
    ld e, a
    jr nc, .call_next_random_seed
    inc d

.call_next_random_seed:
    push de
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $07
    ld de, KeyWorldBossBandPickRows
    add a, e
    ld e, a
    jr nc, .read_key_world_band_adjust
    inc d

.read_key_world_band_adjust:
    ld a, [wKeyWorldBandAdjust]
    sla a
    sla a
    sla a
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    add a, a
    pop de
    add a, e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [hl+]
    or a, a
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
    and a, $07
    cp a, c
    jr nc, .loop2

.read_temp0:
    sla a
    add_a_to_hl
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, [hl+]
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

; for 8 entries from wCD51 ORs 2 * min(wC969 + 15 * (wCD05 + 10) / 150 / 2, 99) into every other byte (E-0127)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_LoadKeyWorldLevelBaseTripleForPartyStrength)
; reads: wKeyWorldLevelBase, wPartyStrength
FillWCD51LevelsSlope::
Func_060_42F2:: ; address name
    ld b, $08
    ld a, $40
    ld de, wKeyWorldMonsters + $1
    add a, e
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
    ld c, $0F
    ld a, [wPartyStrength]
    add a, $0A
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
    or a, a
    jr nz, .skip
    ld a, l
    cp a, $64
    jr c, .skip2

.skip:
    ld l, $63

.skip2:
    ld c, l
    sla c
    ld a, [de]
    or a, c
    ld [de], a
    inc de
    inc de
    pop bc
    dec b
    jr nz, .loop
    ret

; for 8 entries from wCD51 ORs 2 * min(wCD05 + 3 * (wCD05 / 10), 99) into every other byte (E-0125)
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyStrength
FillWCD51LevelsForPartyStrength:: ; heuristic: follows a terminator; C0
Func_060_4338:: ; address name
    ld a, [wPartyStrength]
    ld b, a
    ld a, $0A
    call DivideBByA
    ld a, b
    add a, a
    add a, b
    ld c, a
    ld a, [wPartyStrength]
    add a, c
    ld c, a
    ld b, $08
    ld a, $40
    ld de, wKeyWorldMonsters + $1
    add a, e
    ld e, a
    jr nc, .loop
    inc d

.loop:
    ld a, c
    cp a, $64
    jr c, .skip
    ld a, $63
    ld c, a

.skip:
    push bc
    sla c
    ld a, [de]
    or a, c
    ld [de], a
    inc de
    inc de
    pop bc
    dec b
    jr nz, .loop
    ret

; from the wC708 entry wC833: wCD02 = Data_060_43C7[byte 0] plus a row adjustment, and copies the $FF-terminated list of Data_060_43D7 row byte 1 to wCCF7 (E-0127)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_LoadKeyWorldLevelBaseTripleForPartyStrength)
; reads: wCurrentKeyIndex, wKeyWorldBandAdjust
; writes: wKeyWorldBandAdjust
; points at: wKeyWorldMonsterBands
LoadKeyWorldParamsForCurrentKeyIndex::
Func_060_436B:: ; address name
    ld a, [wCurrentKeyIndex]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $C7
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
    ld a, [hl+]
    cp a, $FF
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
    add a, c
    bit 7, a
    jr z, .set_key_world_band_adjust
    xor a, a

.set_key_world_band_adjust:
    ld [wKeyWorldBandAdjust], a
    ret

; E-0192 (C1: LoadKeyWorldParamsForCurrentKeyIndex indexes it by byte 0 of the current key's 4-byte entry at wC708 + 4 * wCurrentKeyIndex: values -2 to 13).
; record: signed starting value of wKeyWorldBandAdjust
KeyWorldBandAdjustTable::
Data_060_43C7:: ; address name
    db $FE ; id 0
    db $FF ; id 1
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
    db $0A ; id 12
    db $0B ; id 13
    db $0C ; id 14
    db $0D ; id 15

; E-0192 (C1: LoadKeyWorldParamsForCurrentKeyIndex indexes it by 8 * byte 1 of the current key's entry, copies bytes up to and including the $FF to wKeyWorldMonsterBands, then adds byte 6 to wKeyWorldBandAdjust; 56 rows end at the routine after them; every row has its $FF within the first six bytes).
; record: band list ($FF-terminated, 6 bytes); band adjustment; unused 0
KeyWorldBandRows::
Data_060_43D7:: ; address name
    db $00, $FF, $FF, $FF, $FF, $FF, $02, $00 ; id 0
    db $01, $FF, $FF, $FF, $FF, $FF, $02, $00 ; id 1
    db $02, $FF, $FF, $FF, $FF, $FF, $02, $00 ; id 2
    db $03, $FF, $FF, $FF, $FF, $FF, $02, $00 ; id 3
    db $04, $FF, $FF, $FF, $FF, $FF, $02, $00 ; id 4
    db $05, $FF, $FF, $FF, $FF, $FF, $02, $00 ; id 5
    db $06, $FF, $FF, $FF, $FF, $FF, $02, $00 ; id 6
    db $07, $FF, $FF, $FF, $FF, $FF, $02, $00 ; id 7
    db $08, $FF, $FF, $FF, $FF, $FF, $02, $00 ; id 8
    db $09, $FF, $FF, $FF, $FF, $FF, $02, $00 ; id 9
    db $0A, $FF, $FF, $FF, $FF, $FF, $10, $00 ; id 10
    db $00, $01, $FF, $FF, $FF, $FF, $00, $00 ; id 11
    db $00, $02, $FF, $FF, $FF, $FF, $00, $00 ; id 12
    db $00, $03, $FF, $FF, $FF, $FF, $00, $00 ; id 13
    db $00, $04, $FF, $FF, $FF, $FF, $00, $00 ; id 14
    db $00, $05, $FF, $FF, $FF, $FF, $00, $00 ; id 15
    db $00, $06, $FF, $FF, $FF, $FF, $00, $00 ; id 16
    db $00, $07, $FF, $FF, $FF, $FF, $00, $00 ; id 17
    db $00, $08, $FF, $FF, $FF, $FF, $00, $00 ; id 18
    db $00, $09, $FF, $FF, $FF, $FF, $00, $00 ; id 19
    db $01, $02, $FF, $FF, $FF, $FF, $00, $00 ; id 20
    db $01, $03, $FF, $FF, $FF, $FF, $00, $00 ; id 21
    db $01, $04, $FF, $FF, $FF, $FF, $00, $00 ; id 22
    db $01, $05, $FF, $FF, $FF, $FF, $00, $00 ; id 23
    db $01, $06, $FF, $FF, $FF, $FF, $00, $00 ; id 24
    db $01, $07, $FF, $FF, $FF, $FF, $00, $00 ; id 25
    db $01, $08, $FF, $FF, $FF, $FF, $00, $00 ; id 26
    db $01, $09, $FF, $FF, $FF, $FF, $00, $00 ; id 27
    db $02, $03, $FF, $FF, $FF, $FF, $00, $00 ; id 28
    db $02, $04, $FF, $FF, $FF, $FF, $00, $00 ; id 29
    db $02, $05, $FF, $FF, $FF, $FF, $00, $00 ; id 30
    db $02, $06, $FF, $FF, $FF, $FF, $00, $00 ; id 31
    db $02, $07, $FF, $FF, $FF, $FF, $00, $00 ; id 32
    db $02, $08, $FF, $FF, $FF, $FF, $00, $00 ; id 33
    db $02, $09, $FF, $FF, $FF, $FF, $00, $00 ; id 34
    db $03, $04, $FF, $FF, $FF, $FF, $00, $00 ; id 35
    db $03, $05, $FF, $FF, $FF, $FF, $00, $00 ; id 36
    db $03, $06, $FF, $FF, $FF, $FF, $00, $00 ; id 37
    db $03, $07, $FF, $FF, $FF, $FF, $00, $00 ; id 38
    db $03, $08, $FF, $FF, $FF, $FF, $00, $00 ; id 39
    db $03, $09, $FF, $FF, $FF, $FF, $00, $00 ; id 40
    db $04, $05, $FF, $FF, $FF, $FF, $00, $00 ; id 41
    db $04, $06, $FF, $FF, $FF, $FF, $00, $00 ; id 42
    db $04, $07, $FF, $FF, $FF, $FF, $00, $00 ; id 43
    db $04, $08, $FF, $FF, $FF, $FF, $00, $00 ; id 44
    db $04, $09, $FF, $FF, $FF, $FF, $00, $00 ; id 45
    db $05, $06, $FF, $FF, $FF, $FF, $00, $00 ; id 46
    db $05, $07, $FF, $FF, $FF, $FF, $00, $00 ; id 47
    db $05, $08, $FF, $FF, $FF, $FF, $00, $00 ; id 48
    db $05, $09, $FF, $FF, $FF, $FF, $00, $00 ; id 49
    db $06, $07, $FF, $FF, $FF, $FF, $00, $00 ; id 50
    db $06, $08, $FF, $FF, $FF, $FF, $00, $00 ; id 51
    db $06, $09, $FF, $FF, $FF, $FF, $00, $00 ; id 52
    db $07, $08, $FF, $FF, $FF, $FF, $00, $00 ; id 53
    db $07, $09, $FF, $FF, $FF, $FF, $00, $00 ; id 54
    db $08, $09, $FF, $FF, $FF, $FF, $00, $00 ; id 55

; clears wCE7B ($10 bytes) and fills a 4-byte entry per map area (from wCD7B) with a random monster id and level from the band lists (E-0128)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_LoadKeyWorldLevelBaseTripleForPartyStrength)
; reads: wPartyStrength, wKeyWorldLevelArea, hTemp2
; writes: hTemp0, hTemp2
; points at: wKeyWorldEncounterTable, wKeyWorldObjects, wKeyWorldAreaInfo
RollKeyWorldEncounterTable::
Func_060_4597:: ; address name
    ld b, $10
    ld hl, wKeyWorldEncounterTable
    xor a, a

.loop:
    ld [hl+], a
    dec b
    jr nz, .loop
    ld a, [wPartyStrength]
    call BandForA_4773
    dec a
    dec a
    bit 7, a
    jr z, .set_temp0
    xor a, a

.set_temp0:
    ldh [hTemp0], a
    ld hl, wKeyWorldObjects
    ld de, wKeyWorldEncounterTable

.skip:
    ld a, [hl]
    cp a, $FF
    ret z
    push hl
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    and a, $F0
    swap a
    srl a
    srl a
    ld c, a
    ld a, [hl]
    and a, $0F
    srl a
    srl a
    add a, a
    add a, c
    ld hl, wKeyWorldAreaInfo
    add_a_to_hl
    ld a, [hl]
    and a, $F0
    swap a
    add a, a
    ld c, a
    ld a, [wKeyWorldLevelArea]
    add a, c
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
    xor a, a
    ld [de], a
    inc de
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jp .skip

; like RollKeyWorldEncounterTable, with each entry's level from wCD05 / 5 * 7 plus the area value, capped at 99 (E-0129)
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyStrength, hTemp2
; writes: hTemp0, hTemp2
; points at: wKeyWorldEncounterTable, wKeyWorldObjects, wKeyWorldAreaInfo
RollKeyWorldEncounterTableLevels:: ; heuristic: follows a terminator; C0
Func_060_4607:: ; address name
    ld b, $10
    ld hl, wKeyWorldEncounterTable
    xor a, a

.loop:
    ld [hl+], a
    dec b
    jr nz, .loop
    ld a, [wPartyStrength]
    call BandForA_4773
    dec a
    dec a
    bit 7, a
    jr z, .set_temp0
    xor a, a

.set_temp0:
    ldh [hTemp0], a
    ld hl, wKeyWorldObjects
    ld de, wKeyWorldEncounterTable

.skip:
    ld a, [hl]
    cp a, $FF
    ret z
    push hl
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    and a, $F0
    swap a
    srl a
    srl a
    ld c, a
    ld a, [hl]
    and a, $0F
    srl a
    srl a
    add a, a
    add a, c
    ld hl, wKeyWorldAreaInfo
    add_a_to_hl
    ld a, [hl]
    and a, $F0
    swap a
    add a, a
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
    or a, a
    jr nz, .skip2
    ld a, l
    cp a, $64
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
    xor a, a
    ld [de], a
    inc de
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jp .skip

; picks random monster ids for the key world from the wCCF7 lists by band (Func_060_4724) into wCE72-wCE79, and wCE74/wCE77/wCE7A from wC96B (E-0127)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_LoadKeyWorldLevelBaseTripleForPartyStrength)
; reads: wPartyStrength, wKeyRandomLo, wKeyWorldLevelMonster, hTemp0
; writes: hTemp0, wKeyWorldEncounter
RollKeyWorldMonsterIds::
Func_060_4698:: ; address name
    ld a, [wPartyStrength]
    call BandForA_4773
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
    and a, $07
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
    xor a, a

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
    cp a, $05
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

; hFFC7 = wCCF7[random & 1], stepping back over $FF entries (E-0124)
; 4 call sites from 3 routines (e.g. RollKeyWorldEncounterTable, RollKeyWorldMonsterIds, RollKeyWorldEncounterTableLevels)
; reads: wKeyRandomLo
; writes: hTemp1
; points at: wKeyWorldMonsterBands
PickRandomKeyWorldMonsterBandsEntry::
Func_060_4709:: ; address name
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and a, $01
    ld hl, wKeyWorldMonsterBands
    add a, l
    ld l, a
    jr nc, .skip
    inc h

.skip:
    ld a, [hl]
    cp a, $FF
    jr nz, .set_temp1
    dec hl
    jr .skip

.set_temp1:
    ldh [hTemp1], a
    ret

; DE = a random entry of the list Data_060_6D6D[16 * hFFC7 + 2 * hFFC6]; carry when valid, no carry for an empty list or ids $A4, $A5 and $174 (E-0127)
; 4 call sites from 3 routines (e.g. RollKeyWorldEncounterTable, RollKeyWorldMonsterIds, RollKeyWorldEncounterTableLevels)
; reads: hTemp1, hTemp0, wKeyRandomHi
PickRandomMonsterFromBandList::
Func_060_4724:: ; address name
    ldh a, [hTemp1]
    swap a
    ld de, KeyWorldBandSpeciesTable
    add a, e
    ld e, a
    jr nc, .read_temp0
    inc d

.read_temp0:
    ldh a, [hTemp0]
    add a, a
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [hl+]
    or a, a
    jr nz, .skip2

.loop:
    sub a, a
    ret

.skip2:
    dec a
    jr z, .skip3
    inc a
    ld c, a

.loop2:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $07
    cp a, c
    jr nc, .loop2

.skip3:
    sla a
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    or a, a
    jr nz, .skip4
    ld a, e
    cp a, $A4
    jr z, .loop
    cp a, $A5
    jr z, .loop
    scf
    ret

.skip4:
    ld a, e
    cp a, $74
    jr z, .loop
    scf
    ret

; A = 2-7 by thresholds 20, 40, 60, 70, 80, 90, 95 (E-0125)
; 3 call sites from 3 routines (e.g. RollKeyWorldEncounterTable, RollKeyWorldMonsterIds, RollKeyWorldEncounterTableLevels)
BandForA_4773::
Func_060_4773:: ; address name
    cp a, $14
    jr nc, .cp_28
    ld a, $02
    ret

.cp_28:
    cp a, $28
    jr nc, .cp_3C
    ld a, $03
    ret

.cp_3C:
    cp a, $3C
    jr nc, .cp_46
    ld a, $04
    ret

.cp_46:
    cp a, $46
    jr nc, .cp_50
    ld a, $05
    ret

.cp_50:
    cp a, $50
    jr nc, .cp_5A
    ld a, $05
    ret

.cp_5A:
    cp a, $5A
    jr nc, .cp_5F
    ld a, $06
    ret

.cp_5F:
    cp a, $5F
    jr nc, .return_07
    ld a, $06
    ret

.return_07:
    ld a, $07
    ret

; copies three bytes of entry wCD05 of the 8-byte table at $47C5 to wC969-wC96B (E-0121)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_LoadKeyWorldLevelBaseTripleForPartyStrength)
; reads: wPartyStrength
; writes: wKeyWorldLevelBase, wKeyWorldLevelArea, wKeyWorldLevelMonster
LoadKeyWorldLevelBaseTripleForPartyStrength::
Func_060_47A7:: ; address name
    ld a, [wPartyStrength]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, l
    add a, $C5
    ld l, a
    ld a, h
    adc a, $47
    ld h, a
    ld a, [hl+]
    ld [wKeyWorldLevelBase], a
    ld a, [hl+]
    ld [wKeyWorldLevelArea], a
    ld a, [hl+]
    ld [wKeyWorldLevelMonster], a
    ret

; E-0192 (C1: LoadKeyWorldLevelBaseTripleForPartyStrength reads the record at $47C5 + 8 * wPartyStrength and copies its first three bytes; 100 records end at the routine at $4AE5; record 0 is all zero, and the three levels rise with the index).
; record: three level bytes copied to wKeyWorldLevelBase/Area/Monster; five bytes not read ($64, $64, $64, 0, 0)
KeyWorldLevelTable::
Data_060_47C5:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00 ; id 0
    db $0E, $12, $13, $64, $64, $64, $00, $00 ; id 1
    db $0F, $13, $14, $64, $64, $64, $00, $00 ; id 2
    db $10, $14, $15, $64, $64, $64, $00, $00 ; id 3
    db $11, $15, $17, $64, $64, $64, $00, $00 ; id 4
    db $12, $16, $18, $64, $64, $64, $00, $00 ; id 5
    db $13, $17, $19, $64, $64, $64, $00, $00 ; id 6
    db $14, $18, $1A, $64, $64, $64, $00, $00 ; id 7
    db $15, $19, $1B, $64, $64, $64, $00, $00 ; id 8
    db $16, $1A, $1C, $64, $64, $64, $00, $00 ; id 9
    db $17, $1B, $1D, $64, $64, $64, $00, $00 ; id 10
    db $17, $1C, $1D, $64, $64, $64, $00, $00 ; id 11
    db $18, $1D, $1E, $64, $64, $64, $00, $00 ; id 12
    db $18, $1D, $1F, $64, $64, $64, $00, $00 ; id 13
    db $19, $1E, $20, $64, $64, $64, $00, $00 ; id 14
    db $19, $1E, $20, $64, $64, $64, $00, $00 ; id 15
    db $1A, $1F, $21, $64, $64, $64, $00, $00 ; id 16
    db $1A, $1F, $21, $64, $64, $64, $00, $00 ; id 17
    db $1A, $20, $22, $64, $64, $64, $00, $00 ; id 18
    db $1A, $20, $22, $64, $64, $64, $00, $00 ; id 19
    db $1B, $21, $23, $64, $64, $64, $00, $00 ; id 20
    db $1B, $21, $23, $64, $64, $64, $00, $00 ; id 21
    db $1B, $21, $23, $64, $64, $64, $00, $00 ; id 22
    db $1C, $22, $24, $64, $64, $64, $00, $00 ; id 23
    db $1C, $22, $24, $64, $64, $64, $00, $00 ; id 24
    db $1C, $23, $24, $64, $64, $64, $00, $00 ; id 25
    db $1D, $23, $25, $64, $64, $64, $00, $00 ; id 26
    db $1D, $23, $25, $64, $64, $64, $00, $00 ; id 27
    db $1E, $24, $26, $64, $64, $64, $00, $00 ; id 28
    db $1E, $24, $26, $64, $64, $64, $00, $00 ; id 29
    db $1F, $25, $27, $64, $64, $64, $00, $00 ; id 30
    db $20, $25, $27, $64, $64, $64, $00, $00 ; id 31
    db $21, $26, $28, $64, $64, $64, $00, $00 ; id 32
    db $21, $26, $29, $64, $64, $64, $00, $00 ; id 33
    db $22, $27, $2A, $64, $64, $64, $00, $00 ; id 34
    db $23, $27, $2A, $64, $64, $64, $00, $00 ; id 35
    db $24, $28, $2B, $64, $64, $64, $00, $00 ; id 36
    db $25, $29, $2C, $64, $64, $64, $00, $00 ; id 37
    db $26, $29, $2D, $64, $64, $64, $00, $00 ; id 38
    db $27, $29, $2E, $64, $64, $64, $00, $00 ; id 39
    db $28, $2A, $2F, $64, $64, $64, $00, $00 ; id 40
    db $29, $2A, $30, $64, $64, $64, $00, $00 ; id 41
    db $2A, $2B, $31, $64, $64, $64, $00, $00 ; id 42
    db $2B, $2C, $32, $64, $64, $64, $00, $00 ; id 43
    db $2C, $2D, $33, $64, $64, $64, $00, $00 ; id 44
    db $2C, $2E, $34, $64, $64, $64, $00, $00 ; id 45
    db $2D, $2F, $35, $64, $64, $64, $00, $00 ; id 46
    db $2E, $30, $36, $64, $64, $64, $00, $00 ; id 47
    db $2F, $31, $37, $64, $64, $64, $00, $00 ; id 48
    db $2F, $31, $37, $64, $64, $64, $00, $00 ; id 49
    db $31, $33, $39, $64, $64, $64, $00, $00 ; id 50
    db $32, $34, $3A, $64, $64, $64, $00, $00 ; id 51
    db $33, $35, $3B, $64, $64, $64, $00, $00 ; id 52
    db $33, $35, $3B, $64, $64, $64, $00, $00 ; id 53
    db $34, $36, $3C, $64, $64, $64, $00, $00 ; id 54
    db $35, $38, $3E, $64, $64, $64, $00, $00 ; id 55
    db $36, $39, $3F, $64, $64, $64, $00, $00 ; id 56
    db $36, $39, $3F, $64, $64, $64, $00, $00 ; id 57
    db $37, $3A, $40, $64, $64, $64, $00, $00 ; id 58
    db $38, $3B, $41, $64, $64, $64, $00, $00 ; id 59
    db $3A, $3D, $43, $64, $64, $64, $00, $00 ; id 60
    db $3A, $3D, $43, $64, $64, $64, $00, $00 ; id 61
    db $3B, $3E, $44, $64, $64, $64, $00, $00 ; id 62
    db $3C, $3F, $45, $64, $64, $64, $00, $00 ; id 63
    db $3C, $40, $46, $64, $64, $64, $00, $00 ; id 64
    db $3D, $41, $47, $64, $64, $64, $00, $00 ; id 65
    db $3E, $42, $48, $64, $64, $64, $00, $00 ; id 66
    db $3F, $43, $49, $64, $64, $64, $00, $00 ; id 67
    db $40, $44, $4A, $64, $64, $64, $00, $00 ; id 68
    db $41, $45, $4B, $64, $64, $64, $00, $00 ; id 69
    db $42, $46, $4C, $64, $64, $64, $00, $00 ; id 70
    db $42, $47, $4D, $64, $64, $64, $00, $00 ; id 71
    db $43, $48, $4E, $64, $64, $64, $00, $00 ; id 72
    db $44, $49, $4F, $64, $64, $64, $00, $00 ; id 73
    db $45, $4A, $50, $64, $64, $64, $00, $00 ; id 74
    db $46, $4B, $51, $64, $64, $64, $00, $00 ; id 75
    db $47, $4C, $52, $64, $64, $64, $00, $00 ; id 76
    db $48, $4D, $53, $64, $64, $64, $00, $00 ; id 77
    db $48, $4E, $54, $64, $64, $64, $00, $00 ; id 78
    db $49, $4F, $55, $64, $64, $64, $00, $00 ; id 79
    db $4A, $50, $56, $64, $64, $64, $00, $00 ; id 80
    db $4B, $51, $57, $64, $64, $64, $00, $00 ; id 81
    db $4C, $52, $58, $64, $64, $64, $00, $00 ; id 82
    db $4C, $52, $58, $64, $64, $64, $00, $00 ; id 83
    db $4C, $53, $59, $64, $64, $64, $00, $00 ; id 84
    db $4C, $53, $59, $64, $64, $64, $00, $00 ; id 85
    db $4D, $54, $5A, $64, $64, $64, $00, $00 ; id 86
    db $4D, $54, $5A, $64, $64, $64, $00, $00 ; id 87
    db $4E, $55, $5B, $64, $64, $64, $00, $00 ; id 88
    db $4E, $56, $5B, $64, $64, $64, $00, $00 ; id 89
    db $4E, $57, $5C, $64, $64, $64, $00, $00 ; id 90
    db $4F, $57, $5C, $64, $64, $64, $00, $00 ; id 91
    db $4F, $57, $5D, $64, $64, $64, $00, $00 ; id 92
    db $4F, $58, $5E, $64, $64, $64, $00, $00 ; id 93
    db $50, $58, $5E, $64, $64, $64, $00, $00 ; id 94
    db $50, $59, $5F, $64, $64, $64, $00, $00 ; id 95
    db $50, $5A, $5F, $64, $64, $64, $00, $00 ; id 96
    db $51, $5B, $5F, $64, $64, $64, $00, $00 ; id 97
    db $52, $5B, $60, $64, $64, $64, $00, $00 ; id 98
    db $56, $60, $63, $64, $64, $64, $00, $00 ; id 99

; only called from DebugAutomap_Update_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_DebugAutomap_Update_MergeKeyWorldAreas)
; reads: wPartyStrength, wKeyRandomHi, wKeyWorldWidth, wKeyWorldHeight, hTemp8, hTemp9
; writes: wKeyWorldFlags, wKeyWorldWidth, wMapWidthScreens, wKeyWorldHeight, wMapHeightScreens, hTemp8, hTemp9, wKeyWorldAreaCount
; points at: wVisitedScreens, wKeyWorldAreas
DebugAutomap_Update_Sub01_Sub01_WriteKeyWorldFlagsAndKeyWorldWidthEtc::
Func_060_4AE5:: ; address name
    xor a, a
    ld [wKeyWorldFlags], a
    call ClearKeyWorldActiveWhenKeyWorldKeyMatchesKeyWorldSlot
    xor a, a
    ld hl, wVisitedScreens
    ld b, $08

.loop:
    ld [hl+], a
    dec b
    jr nz, .loop
    call PickRandomNonzeroFromKeyWorldGoalKindRows
    ld a, [wPartyStrength]
    ld l, a
    ld h, $00
    ld a, $0A
    call DivideHLByA
    ld c, a
    ld a, [wPartyStrength]
    sub a, c
    ld l, a
    ld h, $00

.loop2:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $0F
    cp a, $0A
    jr nc, .loop2
    add_a_to_hl
    ld a, l
    add a, $F4
    ld l, a
    ld a, h
    adc a, $4B
    ld h, a
    ld a, [hl]
    swap a
    and a, $0F
    jr nz, .set_key_world_width
    ld a, $0A

.set_key_world_width:
    ld [wKeyWorldWidth], a
    ld [wMapWidthScreens], a
    ld a, [hl]
    and a, $0F
    jr nz, .set_key_world_height
    ld a, $0A

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
    ld a, $0A
    call DivideBByA
    ld a, b
    add a, a
    ld hl, DebugAutomap_Update_Sub01_Sub01_WriteKeyWorldFlagsAndKeyWorldWidthEtc_Data
    add_a_to_hl
    ld a, [hl+]
    ld b, a
    ld a, [hl]
    ld c, a
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, c
    add a, b
    ld [wKeyWorldAreaCount], a
    ld hl, wKeyWorldChunks + $3
    ld de, wKeyWorldAreas
    ld b, $04

.loop3:
    ld a, $FF
    ld [hl], a
    ld a, $04
    add_a_to_hl
    ld a, $FF
    ld [de], a
    inc de
    dec b
    jr nz, .loop3
    ld hl, wKeyWorldChunks + $3
    ld de, wKeyWorldAreas
    ldh a, [hTemp8]
    or a, a
    jr z, .check_temp9
    ld c, a
    ld b, $00

.loop4:
    push hl
    push de
    ld a, b
    cp a, c
    jr c, .restore
    ld [hl], $FE
    ld a, $08
    add_a_to_hl
    ld [hl], $FE
    ld a, $FE
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
    cp a, $02
    jr nz, .loop4

.check_temp9:
    ld hl, wKeyWorldChunks + $3
    ld de, wKeyWorldAreas
    ldh a, [hTemp9]
    or a, a
    jr z, .return
    ld c, a
    ld b, $00

.loop5:
    push hl
    push de
    ld a, b
    cp a, c
    jr c, .restore2
    ld a, $FE
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
    cp a, $02
    jr nz, .loop5

.return:
    ret
    db $44, $44, $44, $44, $44, $44, $44, $44, $44, $44
    ds $5A, $88

; address loaded by DebugAutomap_Update_Sub01_Sub01_WriteKeyWorldFlagsAndKeyWorldWidthEtc
DebugAutomap_Update_Sub01_Sub01_WriteKeyWorldFlagsAndKeyWorldWidthEtc_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_060_4C58:: ; address name
    db $00, $0F, $08, $0F, $08, $0F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F

; when wC88E is set and wC891 has bit 7 with low bits equal to wCC42, clears wC88E (E-0122)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_WriteKeyWorldFlagsAndKeyWorldWidthEtc)
; reads: wKeyWorldActive, wKeyWorldKey, wKeyWorldSlot
; writes: wKeyWorldActive
ClearKeyWorldActiveWhenKeyWorldKeyMatchesKeyWorldSlot::
Func_060_4C6C:: ; address name
    ld a, [wKeyWorldActive]
    or a, a
    ret z
    ld a, [wKeyWorldKey]
    bit 7, a
    ret z
    and a, $7F
    ld c, a
    ld a, [wKeyWorldSlot]
    cp a, c
    ret nz
    ld a, $00
    ld [wKeyWorldActive], a
    ret

; repeatedly picks entry (wCD03 & 3) of the 4-byte row of Data_060_4CC1 selected by the second byte of the wC708 entry wC833 until it is non-zero; wCD0B = entry - 1 (E-0121)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_WriteKeyWorldFlagsAndKeyWorldWidthEtc)
; reads: wKeyRandomLo, wCurrentKeyIndex
; writes: wKeyWorldGoalKind
PickRandomNonzeroFromKeyWorldGoalKindRows::
Func_060_4C85:: ; address name
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and a, $07
    push af
    ld a, [wCurrentKeyIndex]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $08
    ld e, a
    ld a, d
    adc a, $C7
    ld d, a
    inc de
    ld hl, KeyWorldGoalKindRows
    ld a, [de]
    add a, a
    add a, a
    add_a_to_hl
    pop af
    and a, $03
    add_a_to_hl
    ld a, [hl]
    or a, a
    jr z, PickRandomNonzeroFromKeyWorldGoalKindRows
    dec a
    ld [wKeyWorldGoalKind], a
    ret

; E-0192 (C1: PickRandomNonzeroFromKeyWorldGoalKindRows reads the byte at $4CC1 + 4 * (byte 1 of the current key's entry at wC708) + (random & 3), repeating until it is non-zero, and stores it minus 1 in wKeyWorldGoalKind; 56 rows, the same count as KeyWorldBandRows, which the same byte indexes).
; record: four choices of wKeyWorldGoalKind + 1 (0 = no choice; drawn again)
KeyWorldGoalKindRows::
Data_060_4CC1:: ; address name
    db $01, $02, $06, $00 ; id 0
    db $04, $05, $07, $00 ; id 1
    db $02, $03, $0A, $00 ; id 2
    db $05, $09, $0A, $00 ; id 3
    db $01, $05, $0A, $00 ; id 4
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
    db $0A, $0A, $0A, $0A ; id 28
    db $05, $05, $05, $05 ; id 29
    db $01, $01, $01, $01 ; id 30
    db $0A, $0A, $0A, $0A ; id 31
    db $08, $08, $08, $08 ; id 32
    db $07, $07, $07, $07 ; id 33
    db $02, $02, $02, $02 ; id 34
    db $0A, $0A, $0A, $0A ; id 35
    db $05, $05, $05, $05 ; id 36
    db $02, $02, $02, $02 ; id 37
    db $03, $03, $03, $03 ; id 38
    db $05, $05, $05, $05 ; id 39
    db $09, $09, $09, $09 ; id 40
    db $05, $05, $05, $05 ; id 41
    db $0A, $0A, $0A, $0A ; id 42
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

; only called from DebugAutomap_Update_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_DebugAutomap_Update_MergeKeyWorldAreas)
; reads: hTemp0, hTemp1, hTemp5, hTemp6
; writes: hTemp0, hTemp1, hTemp5, hTemp6, hTemp7
; points at: wKeyWorldAreas, hTemp7
DebugAutomap_Update_Sub01_Sub01_RunRandomPatternCase::
Func_060_4DA1:: ; address name
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
    xor a, a
    ldh [hTemp7], a

.loop:
    push bc
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, [hl]
    cp a, $FF
    jr nz, .read_temp5

.loop2:
    call RunRandomPatternCase
    or a, a
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
    cp a, $04
    jr nz, .loop
    ret

; ORs the low nibbles of the four wKeyWorldAreas bytes into wKeyWorldAreaInfo
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_DebugAutomap_Update_MergeKeyWorldAreas)
; points at: wKeyWorldAreas, wKeyWorldAreaInfo
DebugAutomap_Update_MergeKeyWorldAreas::
Func_060_4DF6:: ; address name
    ld b, $04
    ld hl, wKeyWorldAreas
    ld de, wKeyWorldAreaInfo

.loop:
    ld a, [hl+]
    and a, $0F
    ld c, a
    ld a, [de]
    or a, c
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ret

; only called from DebugAutomap_Update_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_DebugAutomap_Update_MergeKeyWorldAreas)
; reads: hTemp7, wKeyRandomHi, hTemp0, hTemp1
; writes: hTemp0, hTemp1
; points at: wKeyWorldAreas, wKeyWorldAreaInfo
DebugAutomap_Update_Sub01_Sub01_NextRandomSeed::
Func_060_4E0A:: ; address name
    ldh a, [hTemp7]
    cp a, $01
    jp z, .skip4
    ld c, a
    ld b, a

.loop:
    push bc

.loop2:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $03
    cp a, c
    jr nc, .loop2
    ldh [hTemp0], a

.loop3:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $03
    cp a, c
    jr nc, .loop3
    ld c, a
    ldh a, [hTemp0]
    cp a, c
    jr z, .restore
    ld a, c
    ldh [hTemp1], a
    ld hl, wKeyWorldAreas
    ld b, $04

.loop4:
    ld a, [hl]
    cp a, $FF
    jr z, .next
    cp a, $FE
    jr z, .next
    swap a
    and a, $0F
    ld c, a
    ldh a, [hTemp0]
    cp a, c
    jr nz, .check_temp1
    ldh a, [hTemp1]
    swap a
    ld c, a
    ld a, [hl]
    and a, $0F
    or a, c
    ld [hl], a
    jr .next

.check_temp1:
    ldh a, [hTemp1]
    cp a, c
    jr nz, .next
    ldh a, [hTemp0]
    swap a
    ld c, a
    ld a, [hl]
    and a, $0F
    or a, c
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
    cp a, $FF
    jr z, .next2
    cp a, $FE
    jr z, .next2
    swap a
    and a, $0F
    cp a, b
    jr nz, .next2
    ld a, [hl]
    and a, $0F
    cp a, e
    jr c, .next2
    ld e, a
    ld a, c
    ldh [hTemp0], a

.next2:
    inc hl
    inc c
    ld a, c
    cp a, $04
    jr nz, .loop6
    ldh a, [hTemp0]
    and a, $0C
    jr z, .check_temp0
    ldh a, [hTemp0]
    dec a
    dec a
    ld de, wKeyWorldAreas
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    swap a
    and a, $0F
    dec a
    cp a, b
    jr nz, .check_temp0
    ld a, [de]
    and a, $0F
    jp z, .check_temp7
    call SwapDEByteWithMatchingKeyWorldAreas
    jp .check_temp7

.check_temp0:
    ldh a, [hTemp0]
    and a, $01
    jr z, .check_temp02
    ldh a, [hTemp0]
    dec a
    ld de, wKeyWorldAreas
    add a, e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    swap a
    and a, $0F
    dec a
    cp a, b
    jr nz, .check_temp02
    ld a, [de]
    and a, $0F
    jr z, .check_temp7
    call SwapDEByteWithMatchingKeyWorldAreas
    jr .check_temp7

.check_temp02:
    ldh a, [hTemp0]
    and a, $02
    cp a, $02
    jr z, .check_temp03
    ldh a, [hTemp0]
    inc a
    inc a
    ld de, wKeyWorldAreas
    add a, e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, [de]
    cp a, $FF
    jr z, .check_temp03
    cp a, $FE
    jr z, .check_temp03
    ld a, [de]
    swap a
    and a, $0F
    dec a
    cp a, b
    jr nz, .check_temp03
    ld a, [de]
    and a, $0F
    jr z, .check_temp7
    call SwapDEByteWithMatchingKeyWorldAreas
    jr .check_temp7

.check_temp03:
    ldh a, [hTemp0]
    and a, $01
    cp a, $01
    jr z, .check_temp7
    ldh a, [hTemp0]
    inc a
    ld de, wKeyWorldAreas
    add a, e
    ld e, a
    jr nc, .cp_FF
    inc d

.cp_FF:
    cp a, $FF
    jr z, .check_temp7
    cp a, $FE
    jr z, .check_temp7
    ld a, [de]
    swap a
    and a, $0F
    dec a
    cp a, b
    jr nz, .check_temp7
    ld a, [de]
    and a, $0F
    jr z, .check_temp7
    call SwapDEByteWithMatchingKeyWorldAreas

.check_temp7:
    pop bc
    inc b
    ldh a, [hTemp7]
    dec a
    cp a, b
    jp nz, .loop5

.skip4:
    ld b, $04
    ld hl, wKeyWorldAreas
    ld de, wKeyWorldAreaInfo

.loop7:
    ld a, [hl+]
    and a, $F0
    ld [de], a
    inc de
    dec b
    jr nz, .loop7
    ret

; swaps [DE] with the first of the four wCD70 bytes whose high nibble matches [DE]'s (E-0124)
; 4 call sites from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_NextRandomSeed)
; reads: hTemp1
; writes: hTemp1
; points at: wKeyWorldAreas
SwapDEByteWithMatchingKeyWorldAreas::
Func_060_4F5C:: ; address name
    ld a, [de]
    and a, $F0
    ldh [hTemp1], a
    ld c, $04
    ld hl, wKeyWorldAreas

.loop:
    push bc
    ld a, [hl]
    ld c, a
    ldh a, [hTemp1]
    cp a, c
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

; only called from DebugAutomap_Update_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_DebugAutomap_Update_MergeKeyWorldAreas)
; reads: hTemp7, hTemp0
; writes: hTemp0, hTemp1, hTemp2
; points at: wKeyWorldAreaExits, wKeyWorldAreas
DebugAutomap_Update_Sub01_Sub01_WriteTemp0AndTemp1Etc::
Func_060_4F7C:: ; address name
    ld hl, wKeyWorldAreaExits + $2
    ld b, $05

.loop:
    push hl
    xor a, a
    ld [hl+], a
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
    xor a, a
    ldh [hTemp0], a

.loop3:
    push bc
    ld a, [de]
    cp a, $FF
    jr z, .next
    cp a, $FE
    jr z, .next
    swap a
    and a, $0F
    cp a, c
    jr nz, .skip
    ldh a, [hTemp0]
    ld c, a
    ld a, [de]
    and a, $0F
    cp a, c
    jr c, .next
    ldh [hTemp0], a
    ld a, b
    ldh [hTemp1], a
    jr .next

.skip:
    dec a
    cp a, c
    jr nz, .next
    ld a, [de]
    and a, $0F
    jr nz, .next
    ld a, b
    ldh [hTemp2], a

.next:
    inc de
    pop bc
    inc b
    ld a, b
    cp a, $04
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
    ld [hl], $FF
    ret

; picks two random open cells (ReadKeyWorldCellIsSolid) in the areas named by hFFC7 and hFFC8, avoiding the previous cell, and stores their positions (E-0129)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_WriteTemp0AndTemp1Etc)
; reads: hTemp1, wKeyRandomHi, hTemp4, hTemp3, hTemp2
; writes: hTemp4, hTemp3
PlaceTwoRandomOpenCells::
Func_060_4FEA:: ; address name
    ldh a, [hTemp1]
    and a, $FE
    add a, a
    ldh [hTemp4], a
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $03
    ld c, a
    ldh a, [hTemp4]
    or a, c
    ldh [hTemp4], a
    ldh a, [hTemp1]
    and a, $01
    add a, a
    add a, a
    ldh [hTemp3], a
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $03
    ld c, a
    ldh a, [hTemp3]
    or a, c
    ldh [hTemp3], a
    call ReadKeyWorldCellIsSolid
    or a, a
    jr z, PlaceTwoRandomOpenCells
    ldh a, [hTemp3]
    and a, $0F
    swap a
    ld c, a
    ldh a, [hTemp4]
    and a, $0F
    or a, c
    ld [hl], a
    ld c, a
    push hl
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    cp a, c
    jr nz, .check_temp2
    pop hl
    jr PlaceTwoRandomOpenCells

.check_temp2:
    pop hl
    inc hl

.loop:
    ldh a, [hTemp2]
    and a, $FE
    add a, a
    ldh [hTemp4], a
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $03
    ld c, a
    ldh a, [hTemp4]
    or a, c
    ldh [hTemp4], a
    ldh a, [hTemp2]
    and a, $01
    add a, a
    add a, a
    ldh [hTemp3], a
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $03
    ld c, a
    ldh a, [hTemp3]
    or a, c
    ldh [hTemp3], a
    call ReadKeyWorldCellIsSolid
    or a, a
    jr z, .loop
    ldh a, [hTemp3]
    and a, $0F
    swap a
    ld c, a
    ldh a, [hTemp4]
    and a, $0F
    or a, c
    ld [hl+], a
    ret

; reads the cell at (hFFC9, hFFCA) from the area map chunk in wCD60; A = 1 when its byte is not $FF, else 0 (E-0128)
; 3 call sites from 2 routines (e.g. PlaceObjectInAreaC, PlaceTwoRandomOpenCells)
; reads: hTemp4, hTemp3
ReadKeyWorldCellIsSolid::
Func_060_5075:: ; address name
    push hl
    ldh a, [hTemp4]
    and a, $FC
    add a, a
    ld l, a
    ld h, $00
    ldh a, [hTemp3]
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
    ldh a, [hTemp4]
    and a, $03
    ld c, a
    sla a
    add a, c
    sla a
    sla a
    add_a_to_hl
    ldh a, [hTemp3]
    and a, $03
    ld c, a
    sla a
    add a, c
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
    cp a, $FF
    jr nz, .done
    xor a, a
    pop hl
    ret

.done:
    ld a, $01
    pop hl
    ret

; only called from DebugAutomap_Update_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_DebugAutomap_Update_MergeKeyWorldAreas)
DebugAutomap_Update_Sub01_Sub01_Return::
Func_060_50E4:: ; address name
    ret

; only called from DebugAutomap_Update_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_DebugAutomap_Update_MergeKeyWorldAreas)
; reads: hTemp0, hTemp1, wKeyRandomHi, wKeyRandomLo
; writes: hTemp0, hTemp1
; points at: wKeyWorldByte8B
DebugAutomap_Update_Sub01_Sub01_WriteTemp0AndTemp1::
Func_060_50E5:: ; address name
    ld hl, wKeyWorldByte8B
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ld hl, wKeyWorldFloorInfo + $3
    ld de, wKeyWorldFloorState + $3

.skip:
    ld a, [hl]
    cp a, $FF
    ret z
    push hl
    dec hl
    dec hl
    ld a, [hl]
    cp a, $04
    jr z, .skip2
    cp a, $05
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
    and a, $7F
    cp a, $64
    jr nc, .loop
    cp a, $05
    jr nc, .cp_1E
    ld a, $03
    ld [de], a
    jr .read_temp02

.cp_1E:
    cp a, $1E
    jr nc, .call_next_random_seed
    ld a, $01
    ld [de], a
    jr .read_temp0

.call_next_random_seed:
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and a, $3F
    ld hl, DebugAutomap_Update_Sub01_Sub01_WriteTemp0AndTemp1_Data
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
    add a, $01
    ldh [hTemp0], a
    ldh a, [hTemp1]
    adc a, $00
    ldh [hTemp1], a
    pop hl
    ld a, $04
    add_a_to_hl
    ld a, $10
    add a, e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    jp .skip

; address loaded by DebugAutomap_Update_Sub01_Sub01_WriteTemp0AndTemp1
DebugAutomap_Update_Sub01_Sub01_WriteTemp0AndTemp1_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_060_5177:: ; address name
    db $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F
    db $50, $51, $52, $53, $5A, $5B, $5C, $5D, $5E, $5F, $60, $61, $40, $41, $42, $43
    db $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F, $50, $51, $52, $53
    db $5A, $5B, $5C, $5D, $5E, $5F, $60, $61, $40, $41, $42, $43, $44, $45, $46, $47

; only called from DebugAutomap_Update_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_DebugAutomap_Update_MergeKeyWorldAreas)
; reads: hTemp7, hTemp0, hTemp1, wKeyWorldAreaCount, wKeyWorldHeight, wKeyWorldWidth, hTemp5, hTemp2, ...
; writes: hTemp0, hTemp1, hTemp5, hTemp2, hTemp3, hTemp8, hTemp9
; points at: wKeyWorldAreas, wKeyWorldFloorInfo
DebugAutomap_Update_Sub01_Sub01_WriteTemp0AndTemp1Etc_Sub08::
Func_060_51B7:: ; address name
    ldh a, [hTemp7]
    cp a, $01
    jr z, .read_key_world_area_count
    ld e, a
    ld b, $00
    xor a, a
    ldh [hTemp0], a

.loop:
    xor a, a
    ldh [hTemp1], a
    ld hl, wKeyWorldAreas
    ld c, $04

.loop2:
    ld a, [hl]
    cp a, $FF
    jr z, .next
    cp a, $FE
    jr z, .next
    swap a
    and a, $0F
    cp a, b
    jr nz, .next
    ldh a, [hTemp0]
    ld d, a
    ld a, [hl]
    and a, $0F
    add a, d
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
    add a, c
    ldh [hTemp0], a
    inc b
    ld a, b
    cp a, e
    jr nz, .loop

.read_key_world_area_count:
    ld a, [wKeyWorldAreaCount]
    sla a
    ld hl, KeyWorldAreaLayoutTable_Bank60
    add_a_to_hl
    ld a, [hl+]
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
    add a, c
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
    ld [hl], $FF
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
    or a, a
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
    or a, a
    jr nz, .done
    pop bc
    pop hl
    inc b
    ldh a, [hTemp5]
    cp a, b
    jr z, .return_0
    dec h
    jr .skip

.return_0:
    xor a, a
    ret

.done:
    pop bc
    pop hl
    ret

; finds area C in wCD70 and picks a random free cell inside it for the object (avoiding wCD7B and wCD8B entries) (E-0131)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_WriteTemp0AndTemp1Etc_Sub08)
; reads: hTemp3, wKeyRandomHi, hTemp4, hTempA, hTemp8, hTemp9, wKeyWorldAreaCount, hTemp6
; writes: hTempA, hTemp6, hTemp4, hTemp3, hTemp8, hTemp9
; points at: wKeyWorldAreas, wKeyWorldObjects
PlaceObjectInAreaC::
Func_060_528B:: ; address name
    push bc
    xor a, a
    ldh [hTempA], a
    ld hl, wKeyWorldAreas
    ld b, $00

.loop:
    ld a, [hl+]
    cp a, $FF
    jr z, .next
    cp a, $FE
    jr z, .next
    cp a, c
    jr z, .read_temp3

.next:
    inc b
    ld a, b
    cp a, $04
    jr nz, .loop
    pop bc
    xor a, a
    ret

.read_temp3:
    ldh a, [hTemp3]
    ldh [hTemp6], a

.loop2:
    ld a, b
    srl a
    add a, a
    add a, a
    ld c, a
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $03
    add a, c
    ldh [hTemp4], a
    ld a, b
    and a, $01
    add a, a
    add a, a
    ld c, a
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $03
    add a, c
    ldh [hTemp3], a
    ldh a, [hTemp3]
    and a, $0F
    swap a
    ld c, a
    ldh a, [hTemp4]
    and a, $0F
    or a, c
    ld c, a
    ld hl, wKeyWorldObjects

.skip:
    ld a, [hl]
    cp a, $FF
    jr z, .skip2
    dec hl
    dec hl
    ld a, [hl]
    cp a, c
    jr z, .check_temp_a
    dec hl
    ld a, [hl]
    cp a, c
    jr z, .check_temp_a
    ld a, $07
    add_a_to_hl
    jr .skip

.skip2:
    ld hl, wKeyWorldFloorInfo + $3

.skip3:
    ld a, [hl]
    cp a, $FF
    jr z, .call_read_key_world_cell_is_solid
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    cp a, c
    jr z, .check_temp_a
    ld a, $07
    add_a_to_hl
    jr .skip3

.call_read_key_world_cell_is_solid:
    push bc
    call ReadKeyWorldCellIsSolid
    pop bc
    or a, a
    jr z, .check_temp_a
    ldh a, [hTemp8]
    ld l, a
    ldh a, [hTemp9]
    ld h, a
    ldh a, [hTemp3]
    and a, $0F
    swap a
    ld c, a
    ldh a, [hTemp4]
    and a, $0F
    or a, c
    ld [hl+], a
    pop bc
    push hl
    ld a, [wKeyWorldAreaCount]
    sla a
    ld hl, KeyWorldAreaLayoutTable_Bank60
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    inc de
    pop hl
    ld a, b
    swap a
    add a, e
    ld e, a
    jr nc, .call_read_byte_in_bank
    inc d

.call_read_byte_in_bank:
    push bc
    ld b, $84
    call ReadByteInBank
    ld a, c
    ld [hl+], a
    pop bc
    inc hl
    xor a, a
    ld [hl+], a
    ld a, l
    ldh [hTemp8], a
    ld a, h
    ldh [hTemp9], a
    inc hl
    inc hl
    inc hl
    ld [hl], $FF
    ldh a, [hTemp6]
    ldh [hTemp3], a
    xor a, a
    ret

.check_temp_a:
    ldh a, [hTempA]
    inc a
    ldh [hTempA], a
    cp a, $64
    jp nz, .loop2
    pop bc
    ld a, $01
    ret

; only called from DebugAutomap_Update_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_DebugAutomap_Update_MergeKeyWorldAreas)
; reads: wPartyStrength, wMapObjectCount
; writes: wKeyWorldBand, wMapObjectCount, hTemp0
; points at: wMapObjects
DebugAutomap_Update_Sub01_Sub01_SetKeyWorldBandForA::
Func_060_5373:: ; address name
    ld a, [wPartyStrength]
    call SetKeyWorldBandForA

.loop:
    ld [wKeyWorldBand], a
    ld hl, DebugAutomap_Update_Sub01_Sub01_SetKeyWorldBandForA_Data
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
    or a, a
    jr nz, .read_map_object_count
    pop bc
    pop de
    ld a, $08
    add a, e
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
    sub a, b
    ld [wMapObjectCount], a
    jr z, .loop
    ret

; address loaded by DebugAutomap_Update_Sub01_Sub01_SetKeyWorldBandForA
DebugAutomap_Update_Sub01_Sub01_SetKeyWorldBandForA_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_060_53B3:: ; address name
    db $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0F, $0F, $0F, $0F, $14, $14, $14, $14

; wCD0F = 0 for A < $0B, $0F for A >= $50, otherwise (A - $0A) / 5 + 1 (E-0124)
; 3 call sites from 3 routines (e.g. RefreshKeyWorldObjectsOnEntry, FieldModeStateDispatch_Case04_Sub02_WriteScreenTriggerCountAndWarpPending, DebugAutomap_Update_Sub01_Sub01_SetKeyWorldBandForA)
; writes: wKeyWorldBand
SetKeyWorldBandForA::
Func_060_53C3:: ; address name
    cp a, $0B
    jr nc, .cp_50
    ld a, $00
    jr .set_key_world_band

.cp_50:
    cp a, $50
    jr c, .skip
    ld a, $0F
    jr .set_key_world_band

.skip:
    sub a, $0A
    ld l, a
    ld h, $00
    ld a, $05
    call DivideHLByA
    ld a, l
    inc a

.set_key_world_band:
    and a, $0F
    ld [wKeyWorldBand], a
    ret

; picks a random open cell within wCD0D x wCD0E not used by another object and stores it for object hFFC6 (E-0130)
; 2 call sites from 2 routines (e.g. RefreshKeyWorldObjectsOnEntry, DebugAutomap_Update_Sub01_Sub01_SetKeyWorldBandForA)
; reads: wKeyWorldWidth, wKeyRandomHi, wKeyWorldHeight, hTemp3, hTemp4, hTemp0, wMapObjectCount, hTemp5, ...
; writes: wKeyWorldPlaceFlag, hTemp3, hTemp4, hTemp5
PlaceKeyWorldObjectAtRandomCell::
Func_060_53E5:: ; address name
    xor a, a
    ld [wKeyWorldPlaceFlag], a
    push de

.loop:
    ld a, [wKeyWorldWidth]
    ld c, a

.loop2:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $0F
    cp a, c
    jr nc, .loop2
    ldh [hTemp3], a
    ld a, [wKeyWorldHeight]
    ld c, a

.loop3:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $0F
    cp a, c
    jr nc, .loop3
    ldh [hTemp4], a
    ldh a, [hTemp3]
    swap a
    ld c, a
    ldh a, [hTemp4]
    or a, c
    ldh [hTemp5], a
    ld c, a
    ldh a, [hTemp0]
    ld b, a
    ld a, [wMapObjectCount]
    sub a, b
    jr z, .check_temp4
    ld b, a
    ld hl, wMapObjects + $4

.loop4:
    ld a, [hl]
    cp a, c
    jp z, .check_key_world_place_flag
    ld a, $08
    add_a_to_hl
    dec b
    jr nz, .loop4

.check_temp4:
    ldh a, [hTemp4]
    and a, $FC
    add a, a
    ld l, a
    ld h, $00
    ldh a, [hTemp3]
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
    ldh a, [hTemp4]
    and a, $03
    ld c, a
    add a, a
    add a, c
    add a, a
    add a, a
    add_a_to_hl
    ldh a, [hTemp3]
    and a, $03
    ld c, a
    add a, a
    add a, c
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
    and a, $03
    inc a
    add_a_to_hl
    ld e, l
    ld d, h
    call ReadByteInBank
    ld a, c
    cp a, $FF
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
    cp a, $64
    jp nz, .loop
    pop de
    ld a, $01
    ret

; picks an object kind for the key level band wCD0F from the chance rows at $556F and its contents ([DE + 1]) (E-0130)
; 3 call sites from 3 routines (e.g. RefreshKeyWorldObjectsOnEntry, RemoveMapObjectsEntryMatching, DebugAutomap_Update_Sub01_Sub01_SetKeyWorldBandForA)
; reads: wKeyWorldBand, wKeyRandomHi, hTemp0, hTemp1
; writes: hTemp0, hTemp1
RollKeyWorldObjectKind::
Func_060_54BB:: ; address name
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
    add a, $6F
    ld l, a
    ld a, h
    adc a, $55
    ld h, a

.loop:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $7F
    cp a, $64
    jr nc, .loop
    ld c, a
    ld b, $00

.skip:
    ld a, [hl+]
    or a, a
    jr z, .next
    cp a, c
    jr nc, .skip2

.next:
    inc b
    jr .skip

.skip2:
    ld a, b
    or a, a
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
    and a, $7F
    cp a, $64
    jr nc, .loop2
    ld c, a
    ld a, [wKeyWorldBand]
    ld hl, RollKeyWorldObjectKind_Data
    add_a_to_hl
    xor a, a
    ld [de], a
    ret
    db $3E, $02, $12, $C9

.read_key_world_band:
    ld a, $01
    ld [de], a
    ld a, [wKeyWorldBand]
    ld c, a

.loop3:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $7F
    cp a, $64
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
    and a, $0F
    cp a, $0A
    jr nc, .loop4
    call Multiply8
    ldh a, [hTemp0]
    ld c, a
    ldh a, [hTemp1]
    ld b, a
    add hl, bc
    push de
    ld a, $0A
    call DivideHLByA
    pop de
    ld a, l
    or a, a
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

; address loaded by RollKeyWorldObjectKind
RollKeyWorldObjectKind_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_060_555F:: ; address name
    ds $13, $00
    db $5E
    ds $21, $00
    db $5F, $00, $00, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $14, $00, $00, $45, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $46, $47, $00, $00, $00, $00, $00, $00, $00, $00, $5B, $5E, $00, $00, $00
    db $00, $00, $00, $00, $00, $5F, $00, $00, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $14, $00, $00, $45, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $46, $47, $00, $00, $00, $00, $00, $00, $00, $00, $56, $5B, $5E, $00, $00
    db $00, $00, $00, $00, $00, $5F, $00, $00, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $14, $00, $00, $39, $3D, $00, $00, $00, $3E, $3F, $40, $41, $42, $00, $43, $44
    db $45, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $4A, $54, $5C, $00, $00
    db $00, $00, $00, $00, $00, $5F, $00, $00, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $14, $00, $00, $2F, $39, $00, $3D, $00, $3E, $3F, $40, $41, $42, $00, $43, $44
    db $45, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $4A, $54, $5C, $00, $00
    db $00, $00, $00, $00, $00, $5F, $00, $00, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $14, $00, $00, $25, $34, $00, $3D, $00, $3E, $3F, $40, $41, $42, $00, $43, $00
    db $00, $00, $00, $44, $45, $00, $00, $00, $00, $00, $00, $46, $4E, $58, $59, $5A
    db $00, $00, $00, $00, $5B, $5E, $5F, $00, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $14, $00, $00, $1B, $2F, $00, $3D, $00, $3E, $3F, $40, $41, $42, $00, $43, $00
    db $00, $00, $00, $44, $45, $00, $00, $00, $00, $00, $00, $00, $4A, $58, $59, $5A
    db $00, $00, $00, $00, $5B, $5E, $5F, $00, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $14, $00, $00, $16, $2F, $00, $39, $3D, $3E, $3F, $40, $41, $42, $00, $43, $44
    db $45, $46, $47, $48, $49, $00, $00, $00, $00, $00, $00, $00, $00, $57, $58, $59
    db $00, $00, $00, $00, $5A, $5D, $5E, $5F, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $13, $00, $00, $00, $29, $2E, $38, $3C, $3D, $3E, $3F, $40, $41, $00, $42, $43
    db $44, $45, $46, $47, $48, $00, $00, $00, $00, $00, $00, $00, $00, $56, $57, $58
    db $00, $00, $59, $00, $5A, $5D, $5E, $5F, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $13, $00, $00, $00, $29, $2E, $32, $3C, $3D, $3E, $3F, $40, $41, $00, $42, $43
    db $44, $45, $46, $47, $48, $00, $00, $00, $00, $00, $00, $00, $00, $52, $57, $58
    db $00, $00, $59, $00, $5A, $5D, $5E, $5F, $00, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $13, $00, $00, $00, $29, $2E, $32, $3C, $3D, $3E, $3F, $40, $41, $00, $42, $43
    db $44, $45, $46, $47, $48, $00, $00, $00, $00, $00, $00, $00, $00, $52, $57, $58
    db $00, $00, $59, $00, $5A, $5D, $00, $5F, $60, $00, $61, $62, $63, $00, $64
    ds $11, $00
    db $13, $00, $00, $00, $29, $2E, $32, $3C, $3D, $3E, $3F, $40, $41, $00, $42, $43
    db $44, $45, $46, $47, $48, $00, $00, $00, $00, $00, $00, $00, $00, $52, $57, $58
    db $00, $00, $59, $00, $5A, $5D, $00, $00, $5E, $5F, $61, $62, $63, $00, $64
    ds $11, $00
    db $13, $00, $00, $00, $29, $2E, $32, $3C, $3D, $3E, $3F, $40, $41, $00, $42, $43
    db $44, $45, $46, $47, $48, $00, $00, $00, $00, $00, $00, $00, $00, $52, $57, $58
    db $00, $00, $59, $00, $5A, $5D, $00, $00, $5E, $5F, $61, $62, $63, $00, $64
    ds $11, $00
    db $13, $00, $00, $00, $29, $2E, $32, $3C, $3D, $3E, $3F, $40, $41, $00, $42, $43
    db $44, $45, $46, $47, $48, $00, $00, $00, $00, $00, $00, $00, $00, $52, $57, $58
    db $00, $00, $59, $00, $5A, $5D, $00, $00, $5E, $5F, $61, $62, $63, $00, $64
    ds $11, $00
    db $13, $00, $00, $00, $29, $2E, $32, $3C, $3D, $3E, $3F, $40, $41, $00, $42, $43
    db $44, $45, $46, $47, $48, $00, $00, $00, $00, $00, $00, $00, $00, $52, $57, $58
    db $00, $00, $59, $00, $5A, $5D, $00, $00, $5E, $5F, $61, $62, $63, $00, $64
    ds $11, $00
    db $13, $00, $00, $00, $29, $2E, $32, $3C, $3D, $3E, $3F, $40, $41, $00, $42, $43
    db $44, $45, $46, $47, $48, $00, $00, $00, $00, $00, $00, $00, $00, $52, $57, $58
    db $00, $00, $59, $00, $5A, $5D, $00, $00, $5E, $5F, $61, $62, $63, $00, $64
    ds $11, $00

; only called from routines of FieldModeStateDispatch (E-0098)
; 2 call sites from 2 routines (e.g. FieldModeStateDispatch_Case04_Sub02_WriteScreenTriggerCountAndWarpPending, FieldModeStateDispatch_Case04_WriteScreenTriggerCountAndWarpPendingEtc)
; reads: wKeyWorldBand, wKeyRandomHi, hTemp0, hTemp1
; writes: hTemp0, hTemp1
FieldModeStateDispatch_NextRandomSeed::
Func_060_596F:: ; address name
    ld a, [wKeyWorldBand]
    and a, $0F
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, l
    add a, $29
    ld l, a
    ld a, h
    adc a, $5A
    ld h, a

.loop:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $7F
    cp a, $64
    jr nc, .loop
    ld c, a
    ld b, $00

.skip:
    ld a, [hl+]
    or a, a
    jr z, .next
    cp a, c
    jr nc, .skip2

.next:
    inc b
    jr .skip

.skip2:
    ld a, b
    or a, a
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
    and a, $7F
    cp a, $64
    jr nc, .loop2
    ld c, a
    ld a, [wKeyWorldBand]
    ld hl, FieldModeStateDispatch_NextRandomSeed_Data
    add_a_to_hl
    ld a, [hl]
    cp a, c
    jr nc, .done
    xor a, a
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
    and a, $7F
    cp a, $64
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
    and a, $0F
    cp a, $0A
    jr nc, .loop4
    call Multiply8
    ldh a, [hTemp0]
    ld c, a
    ldh a, [hTemp1]
    ld b, a
    add hl, bc
    push de
    ld a, $0A
    call DivideHLByA
    pop de
    ld a, l
    or a, a
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

; address loaded by FieldModeStateDispatch_NextRandomSeed
FieldModeStateDispatch_NextRandomSeed_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_060_5A19:: ; address name
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
    db $4B, $50, $55, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $56
    db $57, $64
    ds $13, $00
    db $14, $19, $00, $37, $3C, $00, $00, $00, $3D, $3E, $3F, $40, $41, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $46, $50, $55, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $56, $57, $64
    ds $13, $00
    db $14, $19, $00, $2D, $37, $00, $3C, $00, $3D, $3E, $3F, $40, $41, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $46, $4B, $55, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $56, $57, $64
    ds $13, $00
    db $14, $19, $00, $23, $32, $00, $3C, $00, $3D, $3E, $3F, $40, $41, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $46, $50, $00, $55
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $56, $57, $64
    ds $13, $00
    db $14, $19, $00, $23, $32, $00, $3C, $00, $3D, $3E, $3F, $40, $41, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $46, $50, $00, $55
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $56, $57, $64
    ds $13, $00
    db $14, $19, $00, $23, $32, $00, $3C, $00, $3D, $3E, $3F, $40, $41, $00, $00, $00
    db $00, $49, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $50, $00, $55
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $56, $57, $64
    ds $13, $00
    db $0F, $19, $00, $1E, $2D, $32, $3C, $00, $3D, $3E, $3F, $40, $41
    ds $10, $00
    db $50, $55, $5A, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $5B, $5C, $64
    ds $13, $00
    db $0F, $19, $00, $1E, $2D, $32, $3C, $00, $3D, $3E, $3F, $40, $41
    ds $10, $00
    db $50, $55, $5A, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $5B, $5C, $64
    ds $13, $00
    db $0F, $19, $00, $1E, $2D, $32, $3C, $00, $3D, $3E, $3F, $40, $41
    ds $10, $00
    db $50, $55, $5A, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $5B, $5C, $64
    ds $13, $00
    db $0F, $19, $00, $1E, $2D, $32, $3C, $00, $3D, $3E, $3F, $40, $41
    ds $10, $00
    db $50, $55, $5A, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $5B, $5C, $64
    ds $13, $00
    db $0F, $19, $00, $1E, $2D, $32, $3C, $00, $3D, $3E, $3F, $40, $41
    ds $10, $00
    db $50, $55, $5A, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $5B, $5C, $64
    ds $13, $00
    db $0F, $19, $00, $1E, $2D, $32, $3C, $00, $3D, $3E, $3F, $40, $41
    ds $10, $00
    db $50, $55, $5A, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $5B, $5C, $64
    ds $13, $00
    db $0F, $19, $00, $1E, $2D, $32, $3C, $00, $3D, $3E, $3F, $40, $41
    ds $10, $00
    db $50, $55, $5A, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $5B, $5C, $64
    ds $13, $00
    db $0F, $19, $00, $1E, $2D, $32, $3C, $00, $3D, $3E, $3F, $40, $41
    ds $10, $00
    db $50, $55, $5A, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $5B, $5C, $64
    ds $13, $00
    db $06, $08, $0E, $34, $1E, $00, $F5, $CD, $80, $1F, $F0, $C6, $FE, $FF, $28, $07
    db $F1, $0C, $1C, $05, $20, $F0, $C9, $F1, $C9

; only called from DebugAutomap_Update_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_DebugAutomap_Update_MergeKeyWorldAreas)
; reads: wKeyWorldFloorInfo, hTemp4, hTemp3
; writes: wKeyWorldGoalScreen, hTemp3, hTemp4, wKeyWorldGoalPos, wKeyWorldGoalPos2
DebugAutomap_Update_Sub01_Sub01_WriteKeyWorldGoalScreenAndTemp3Etc::
Func_060_5E42:: ; address name
    ld a, [wKeyWorldFloorInfo]
    ld [wKeyWorldGoalScreen], a
    swap a
    and a, $0F
    ldh [hTemp3], a
    ld a, [wKeyWorldFloorInfo]
    and a, $0F
    ldh [hTemp4], a
    ldh a, [hTemp4]
    and a, $FC
    add a, a
    ld l, a
    ld h, $00
    ldh a, [hTemp3]
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
    ldh a, [hTemp4]
    and a, $03
    ld c, a
    sla a
    add a, c
    sla a
    sla a
    add_a_to_hl
    ldh a, [hTemp3]
    and a, $03
    ld c, a
    sla a
    add a, c
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
    cp a, $FF
    jr nz, .skip2

.skip:
    jr .skip

.skip2:
    sla a
    ld hl, DebugAutomap_Update_Sub01_Sub01_WriteKeyWorldGoalScreenAndTemp3Etc_Data
    add_a_to_hl
    ld a, [hl+]
    ld [wKeyWorldGoalPos], a
    ld a, [hl]
    ld [wKeyWorldGoalPos2], a
    ret

; address loaded by DebugAutomap_Update_Sub01_Sub01_WriteKeyWorldGoalScreenAndTemp3Etc
DebugAutomap_Update_Sub01_Sub01_WriteKeyWorldGoalScreenAndTemp3Etc_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_060_5ED1:: ; address name
    db $10, $10, $10, $60, $40, $20, $40, $60, $50, $20, $50, $60, $70, $30, $80, $70

; runs one of four routines chosen by random & $0F through a 16-entry table (E-0124)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_RunRandomPatternCase)
; reads: wKeyRandomHi
RunRandomPatternCase::
Func_060_5EE1:: ; address name
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $0F
    rst $00
    dw RunRandomPatternCase_StoreThreeBytesBeforeTemp0Pointer
    dw RunRandomPatternCase_WriteTempA
    dw RunRandomPatternCase_WriteTempA_Case02
    dw RunRandomPatternCase_WriteTempA_Case03
    dw RunRandomPatternCase_WriteTempA_Case02
    dw RunRandomPatternCase_WriteTempA
    dw RunRandomPatternCase_StoreThreeBytesBeforeTemp0Pointer
    dw RunRandomPatternCase_WriteTempA
    dw RunRandomPatternCase_WriteTempA_Case02
    dw RunRandomPatternCase_WriteTempA_Case03
    dw RunRandomPatternCase_WriteTempA_Case02
    dw RunRandomPatternCase_WriteTempA
    dw RunRandomPatternCase_StoreThreeBytesBeforeTemp0Pointer
    dw RunRandomPatternCase_WriteTempA
    dw RunRandomPatternCase_WriteTempA_Case02
    dw RunRandomPatternCase_WriteTempA_Case03
    db $C9, $C9

; entry 3 of the `rst $00` table in RunRandomPatternCase
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, hTemp1, wKeyRandomHi, hTemp7, hTemp2, hTemp3, hTemp4, hTemp5, ...
; writes: hTempA
RunRandomPatternCase_WriteTempA_Case03::
Jump_060_5F0C:: ; address name
    ld a, b
    and a, $01
    cp a, $01
    jr nz, .skip

.loop:
    xor a, a
    ret

.skip:
    ld a, b
    cp a, $02
    jr c, .read_temp0
    xor a, a
    ret

.read_temp0:
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, $04
    add_a_to_hl
    ld a, [hl]
    cp a, $FE
    jr z, .loop
    cp a, $FF
    jr nz, .loop
    ld a, $08
    add_a_to_hl
    ld a, [hl]
    cp a, $FE
    jr z, .loop
    ld a, l
    sub a, $04
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, [hl]
    cp a, $FE
    jr z, .loop
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $1F
    ld c, a
    add a, a
    add a, c
    ld de, RunRandomPatternCase_WriteTempA_Case03_Data
    add a, e
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
    ld hl, $000C
    call StoreTemp2To3BytesBeforeHLPlusTemp0
    ld [hl], $03
    ldh a, [hTemp7]
    swap a
    and a, $F0
    ldh [hTempA], a
    ldh a, [hTemp2]
    ld e, a
    ldh a, [hTemp3]
    ld d, a
    ld a, e
    add a, $80
    ld e, a
    ld a, d
    adc a, $01
    ld d, a
    ldh a, [hTemp4]
    ld b, a
    call ReadByteInBank
    ldh a, [hTemp5]
    ld l, a
    ldh a, [hTemp6]
    ld h, a
    ldh a, [hTempA]
    or a, c
    ld [hl], a
    inc de
    call ReadByteInBank
    inc hl
    ldh a, [hTempA]
    or a, c
    ld [hl], a
    inc de
    call ReadByteInBank
    inc hl
    ldh a, [hTempA]
    or a, c
    ld [hl], a
    inc de
    call ReadByteInBank
    inc hl
    ldh a, [hTempA]
    or a, c
    ld [hl], a
    ld a, $01
    ret

; entry 2 of the `rst $00` table in RunRandomPatternCase
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, hTemp1, wKeyRandomHi, hTemp7, hTemp2, hTemp3, hTemp4, hTemp5, ...
; writes: hTempA
RunRandomPatternCase_WriteTempA_Case02::
Jump_060_5FBF:: ; address name
    ld a, b
    and a, $01
    cp a, $01
    jr nz, .read_temp0

.loop:
    xor a, a
    ret

.read_temp0:
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, $04
    add_a_to_hl
    ld a, [hl]
    cp a, $FE
    jr z, .loop
    cp a, $FF
    jr nz, .loop
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $1F
    ld c, a
    sla a
    add a, c
    ld de, RunRandomPatternCase_WriteTempA_Case02_Data
    add a, e
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
    and a, $F0
    ldh [hTempA], a
    ldh a, [hTemp2]
    ld e, a
    ldh a, [hTemp3]
    ld d, a
    ld a, e
    add a, $C0
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ldh a, [hTemp4]
    ld b, a
    call ReadByteInBank
    ldh a, [hTemp5]
    ld l, a
    ldh a, [hTemp6]
    ld h, a
    ldh a, [hTempA]
    or a, c
    ld [hl], a
    inc de
    call ReadByteInBank
    inc hl
    ldh a, [hTempA]
    or a, c
    ld [hl], a
    ld a, $01
    ret

; entry 1 of the `rst $00` table in RunRandomPatternCase
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, hTemp1, wKeyRandomHi, hTemp7, hTemp2, hTemp3, hTemp4, hTemp5, ...
; writes: hTempA
RunRandomPatternCase_WriteTempA::
Jump_060_6031:: ; address name
    ld a, b
    cp a, $02
    jr c, .read_temp0

.loop:
    xor a, a
    ret

.read_temp0:
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, $08
    add_a_to_hl
    ld a, [hl]
    cp a, $FE
    jr z, .loop
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $1F
    ld c, a
    sla a
    add a, c
    ld de, RunRandomPatternCase_WriteTempA_Data
    add a, e
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
    and a, $F0
    ldh [hTempA], a
    ldh a, [hTemp2]
    ld e, a
    ldh a, [hTemp3]
    ld d, a
    ld a, e
    add a, $C0
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ldh a, [hTemp4]
    ld b, a
    call ReadByteInBank
    ldh a, [hTemp5]
    ld l, a
    ldh a, [hTemp6]
    ld h, a
    ldh a, [hTempA]
    or a, c
    ld [hl], a
    inc de
    call ReadByteInBank
    inc hl
    inc hl
    ldh a, [hTempA]
    or a, c
    ld [hl], a
    ld a, $01
    ret

; entry 0 of the `rst $00` table in RunRandomPatternCase
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyRandomLo, hTemp7, hTemp2, hTemp3, hTemp4, hTemp5, hTemp6, hTempA
; writes: hTempA
RunRandomPatternCase_StoreThreeBytesBeforeTemp0Pointer::
Jump_060_609E:: ; address name
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and a, $1F
    ld c, a
    sla a
    add a, c
    ld de, KeyWorldChunkLists
    add a, e
    ld e, a
    jr nc, .call_store_three_bytes_before_temp0_pointer
    inc d

.call_store_three_bytes_before_temp0_pointer:
    call StoreThreeBytesBeforeTemp0Pointer
    ld [hl], $00
    ldh a, [hTemp7]
    swap a
    and a, $F0
    ldh [hTempA], a
    ldh a, [hTemp2]
    ld e, a
    ldh a, [hTemp3]
    ld d, a
    ld a, e
    add a, $60
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ldh a, [hTemp4]
    ld b, a
    call ReadByteInBank
    ldh a, [hTemp5]
    ld l, a
    ldh a, [hTemp6]
    ld h, a
    ldh a, [hTempA]
    or a, c
    ld [hl], a
    ld a, $01
    ret

; copies three bytes at DE to the address in hFFC6/hFFC7 minus 3 and to hFFC8-hFFCA (E-0121)
; 4 call sites from 4 routines (e.g. RunRandomPatternCase_WriteTempA_Case03, RunRandomPatternCase_WriteTempA_Case02, RunRandomPatternCase_WriteTempA, RunRandomPatternCase_StoreThreeBytesBeforeTemp0Pointer)
; reads: hTemp0, hTemp1
; writes: hTemp2, hTemp3, hTemp4
StoreThreeBytesBeforeTemp0Pointer::
Func_060_60E0:: ; address name
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    dec hl
    dec hl
    dec hl
    ld a, [de]
    inc de
    ld [hl+], a
    ldh [hTemp2], a
    ld a, [de]
    inc de
    ld [hl+], a
    ldh [hTemp3], a
    ld a, [de]
    ld [hl+], a
    ldh [hTemp4], a
    ret

; HL += the word hFFC6/hFFC7, then stores hFFC8, hFFC9, hFFCA at HL - 3 onward (E-0119)
; 5 call sites from 3 routines (e.g. RunRandomPatternCase_WriteTempA_Case03, RunRandomPatternCase_WriteTempA_Case02, RunRandomPatternCase_WriteTempA)
; reads: hTemp0, hTemp1, hTemp2, hTemp3, hTemp4
StoreTemp2To3BytesBeforeHLPlusTemp0::
Func_060_60F8:: ; address name
    ldh a, [hTemp0]
    add a, l
    ld l, a
    ldh a, [hTemp1]
    adc a, h
    ld h, a
    dec hl
    dec hl
    dec hl
    ldh a, [hTemp2]
    ld [hl+], a
    ldh a, [hTemp3]
    ld [hl+], a
    ldh a, [hTemp4]
    ld [hl+], a
    ret

; E-0146 (C1: RunRandomPatternCase_Case00/01/02 pick entry (random & $1F) of the lists at $610D, $616D and $61E5 and store the far pointer in the key-world area data; the far pointers run to $62F8 and all point at chunk groups ($61 bytes per sub-chunk)).
; record: chunk group in bank $67/$68; its ROM bank
KeyWorldChunkLists::
Data_060_610D:: ; address name
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
RunRandomPatternCase_WriteTempA_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_060_616D:: ; address name
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
RunRandomPatternCase_WriteTempA_Case02_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_060_61E5:: ; address name
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
RunRandomPatternCase_WriteTempA_Case03_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_060_6245:: ; address name
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

; on key-world maps with bit 7 of wC893 set: sets the object count wCC47 from the band of the key level and drops objects for which Func_060_53E5 fails; marks the wC890 object (E-0129)
; 2 call sites from 2 routines (e.g. InitFieldScreen, InnMenu_Morning)
; reads: wMapType, wKeyWorldRefresh, wCurrentKeyIndex, wKeyWorldBand, wMapObjectCount, wKeyWorldActive, wKeyWorldKey, wKeyWorldSlot, ...
; writes: wKeyWorldRefresh, wMapObjectCount, hTemp0
; points at: wMapObjects
RefreshKeyWorldObjectsOnEntry::
Func_060_62F9:: ; address name
    ld a, [wMapType]
    cp a, $80
    ret nz
    ld a, [wKeyWorldRefresh]
    bit 7, a
    ret z
    and a, $7F
    ld [wKeyWorldRefresh], a
    ld a, [wCurrentKeyIndex]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [hl]
    call SetKeyWorldBandForA
    ld a, [wKeyWorldBand]
    and a, $0F
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
    or a, a
    jr nz, .read_map_object_count
    pop bc
    pop de
    ld a, $08
    add a, e
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
    sub a, b
    ld [wMapObjectCount], a
    jr z, RefreshKeyWorldObjectsOnEntry
    ld a, [wKeyWorldActive]
    or a, a
    ret z
    ld a, [wKeyWorldKey]
    bit 7, a
    ret z
    and a, $7F
    ld c, a
    ld a, [wKeyWorldSlot]
    cp a, c
    ret nz
    ld a, [wKeyWorldGoalCell]
    ld c, a
    ld hl, wMapObjects + $4
    ld a, [wMapObjectCount]
    ld b, a

.loop2:
    ld a, [hl]
    cp a, c
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

; address loaded by RefreshKeyWorldObjectsOnEntry
RefreshKeyWorldObjectsOnEntry_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_060_638D:: ; address name
    db $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0F, $0F, $0F, $0F, $14, $14, $14, $14

; on town maps with bit 7 of wC893 set: sets the object count and band for the map, drops listed objects and marks the wC890 one (E-0130)
; 2 call sites from 2 routines (e.g. InitFieldScreen, InnMenu_Morning)
; reads: wMapType, wKeyWorldRefresh, hMapId
; writes: wMapObjectCount, wKeyWorldBand, hTemp0
SetupTownObjectsForMap::
Func_060_639D:: ; address name
    ld a, [wMapType]
    bit 7, a
    ret nz
    ld a, [wKeyWorldRefresh]
    bit 7, a
    ret z
    ldh a, [hMapId]
    cp a, $20
    jr z, .set_map_object_count_to_0A
    cp a, $30
    jr z, .set_map_object_count_to_0A2
    cp a, $48
    jr z, .set_map_object_count_to_0F
    cp a, $70
    jr z, .set_map_object_count_to_0F2
    cp a, $A8
    jp z, .set_map_object_count_to_0A3
    cp a, $B0
    jp z, .set_map_object_count_to_02
    cp a, $B8
    jp z, .set_map_object_count_to_08
    cp a, $A0
    jr z, .clear_map_object_count
    cp a, $C8
    jr z, .clear_map_object_count
    cp a, $D1
    jr z, .clear_map_object_count
    cp a, $DA
    jr z, .clear_map_object_count
    ret

.clear_map_object_count:
    xor a, a
    ld [wMapObjectCount], a
    ret

.set_map_object_count_to_0A:
    ld a, $0A
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
    ld a, $0A
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
    ld a, $0F
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
    ld a, $0F
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
    ld a, $0A
    ld [wMapObjectCount], a
    ld a, $0B
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
    ld a, $0B
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
    ld a, $0D
    ld [wKeyWorldBand], a
    ld hl, TownObjectSpotGrid6
    call RemoveMapObjectsEntryMatching
    ld a, $07
    ldh [hTemp0], a
    call MarkMapObjectsEntryForKeyWorldGoalCell
    ret

; clears bit 7 of wC893; walks the wCC47 8-byte entries at wCC48 and drops the count at the first entry for which Func_060_64F3 returns 0 (E-0125)
; 7 call sites from 1 routine (e.g. SetupTownObjectsForMap)
; reads: wKeyWorldRefresh, wMapObjectCount
; writes: hTemp6, hTemp7, wKeyWorldRefresh, hTemp0, wMapObjectCount
; points at: wMapObjects
RemoveMapObjectsEntryMatching::
Func_060_6488:: ; address name
    ld a, l
    ldh [hTemp6], a
    ld a, h
    ldh [hTemp7], a
    ld a, [wKeyWorldRefresh]
    and a, $7F
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
    or a, a
    jr z, .read_map_object_count
    pop bc
    pop de
    ld a, $08
    add a, e
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
    sub a, b
    ld [wMapObjectCount], a
    ret

; when wC88E is set and wC891 equals hFFC6, sets bit 7 of the entry whose byte 4 equals wC890 (E-0125)
; 7 call sites from 1 routine (e.g. SetupTownObjectsForMap)
; reads: wKeyWorldActive, wKeyWorldKey, hTemp0, wKeyWorldGoalCell, wMapObjectCount
MarkMapObjectsEntryForKeyWorldGoalCell::
Func_060_64C2:: ; address name
    ld a, [wKeyWorldActive]
    or a, a
    ret z
    ld a, [wKeyWorldKey]
    bit 7, a
    ret nz
    ld c, a
    ldh a, [hTemp0]
    cp a, c
    ret nz
    ld a, [wKeyWorldGoalCell]
    ld c, a
    ld hl, wMapObjects + $4
    ld a, [wMapObjectCount]
    ld b, a

.loop:
    ld a, [hl]
    cp a, c
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

; only called from RemoveMapObjectsEntryMatching (E-0047)
; 1 call site from 1 routine (e.g. RemoveMapObjectsEntryMatching)
; reads: wMapWidthScreens, wKeyRandomHi, wMapHeightScreens, hTemp3, hTemp4, hTemp0, wMapObjectCount, hTempA, ...
; writes: hTempA, hTemp3, hTemp4, hTemp5
RemoveMapObjectsEntryMatching_NextRandomSeed::
Func_060_64F3:: ; address name
    push de
    xor a, a
    ldh [hTempA], a

.loop:
    ld a, [wMapWidthScreens]
    ld c, a

.loop2:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $0F
    cp a, c
    jr nc, .loop2
    ldh [hTemp3], a
    ld a, [wMapHeightScreens]
    ld c, a

.loop3:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $0F
    cp a, c
    jr nc, .loop3
    ldh [hTemp4], a
    ldh a, [hTemp3]
    swap a
    ld c, a
    ldh a, [hTemp4]
    or a, c
    ldh [hTemp5], a
    ld c, a
    ldh a, [hTemp0]
    ld b, a
    ld a, [wMapObjectCount]
    sub a, b
    jr z, .read_map_width_screens
    ld b, a
    ld hl, wMapObjects + $4

.loop4:
    ld a, [hl]
    cp a, c
    jr nz, .skip
    ldh a, [hTempA]
    inc a
    ldh [hTempA], a
    cp a, $64
    jr nz, .loop
    pop de
    xor a, a
    ret

.skip:
    ld a, $08
    add_a_to_hl
    dec b
    jr nz, .loop4

.read_map_width_screens:
    ld a, [wMapWidthScreens]
    add a, a
    add a, a
    add a, a
    ld c, a
    ldh a, [hTemp4]
    call Multiply8
    ldh a, [hTemp3]
    add a, a
    add a, a
    add a, a
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
    and a, $03
    add a, a
    add_a_to_hl
    ld e, l
    ld d, h
    ld b, $61
    call ReadByteInBank
    ld a, c
    cp a, $FE
    jr nz, .cp_FF
    pop hl
    jp .loop

.cp_FF:
    cp a, $FF
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
    or a, c
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

; only called from FieldModeStateDispatch_Case04 (E-0047)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_DrawFieldSprites_Case04)
; reads: wMapType, hMapId, hMapScreenX, hMapScreenY, wWarpPending, wKeyRandomHi
; writes: wScreenTriggerCount, wWarpPending, wKeyWorldBand, hTemp2, hTemp3
; points at: wScreenTriggers, hTemp3
FieldModeStateDispatch_Case04_WriteScreenTriggerCountAndWarpPendingEtc::
Func_060_65AA:: ; address name
    ld a, [wMapType]
    bit 7, a
    jr z, .check_map_id
    call FieldModeStateDispatch_Case04_Sub02_WriteScreenTriggerCountAndWarpPending
    ret

.check_map_id:
    ldh a, [hMapId]
    cp a, $39
    jr nz, .check_map_id2
    ldh a, [hMapScreenX]
    cp a, $01
    jr nz, .check_map_id2
    ldh a, [hMapScreenY]
    cp a, $01
    ret z

.check_map_id2:
    ldh a, [hMapId]
    cp a, $2B
    jr nz, .read_map_id
    ldh a, [hMapScreenX]
    cp a, $01
    jr nz, .read_map_id
    ldh a, [hMapScreenY]
    cp a, $02
    ret z

.read_map_id:
    ldh a, [hMapId]
    ld c, a
    ld hl, FieldModeStateDispatch_Case04_WriteScreenTriggerCountAndWarpPendingEtc_Data_663F
    ld b, $00

.skip:
    ld a, [hl+]
    cp a, $FF
    jr nz, .skip2

.loop:
    xor a, a
    ld [wScreenTriggerCount], a
    ret

.skip2:
    cp a, c
    jr z, .check_warp_pending
    inc b
    jr .skip

.check_warp_pending:
    ld a, [wWarpPending]
    or a, a
    jr z, .loop
    xor a, a
    ld [wWarpPending], a
    ld a, b
    push af
    ld hl, FieldModeStateDispatch_Case04_WriteScreenTriggerCountAndWarpPendingEtc_Data_6634
    add_a_to_hl
    ld a, [hl]
    ld [wKeyWorldBand], a
    pop af
    ldh [hTemp2], a
    ld a, $03
    ld [wScreenTriggerCount], a
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $1F
    ldh [hTemp3], a
    ld b, $03
    ld de, wScreenTriggers

.loop2:
    push de
    push bc
    call FieldModeStateDispatch_NextRandomSeed
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

; address loaded by FieldModeStateDispatch_Case04_WriteScreenTriggerCountAndWarpPendingEtc
FieldModeStateDispatch_Case04_WriteScreenTriggerCountAndWarpPendingEtc_Data_6634:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_060_6634:: ; address name
    db $00, $03, $03, $03, $03, $06, $06, $09, $09, $0C, $0C

; address loaded by FieldModeStateDispatch_Case04_WriteScreenTriggerCountAndWarpPendingEtc
FieldModeStateDispatch_Case04_WriteScreenTriggerCountAndWarpPendingEtc_Data_663F:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_060_663F:: ; address name
    db $2B, $38, $39, $3A, $53, $5D, $82, $83, $AD, $AE, $FF

; DE += 2; writes the word at $669C + 16 * hFFC8 + 2 * Data_060_6677[hFFC9] at DE (E-0121)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case04_WriteScreenTriggerCountAndWarpPendingEtc)
; reads: hTemp2, hTemp3
WriteKeyContentsWordRowsEntryForTemp2Temp3::
Func_060_664A:: ; address name
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
    add a, $9C
    ld l, a
    ld a, h
    adc a, $66
    ld h, a
    push hl
    ldh a, [hTemp3]
    ld hl, KeyContentsColumnPicks
    add_a_to_hl
    ld a, [hl]
    pop hl
    sla a
    add_a_to_hl
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ret

; E-0192 (C1: WriteKeyContentsWordRowsEntryForTemp2Temp3 reads the byte at $6677 + hTemp3 and uses it as the word index in row hTemp2 of KeyContentsWordRows; the first 32 bytes are four permutations of 0-7; the table ends where the rows begin, and a larger hTemp3 would read into them).
; record: 37 bytes, each a word index 0-7 within a row
KeyContentsColumnPicks::
Data_060_6677:: ; address name
    db $00, $02, $04, $06, $07, $01, $03, $05, $02, $06, $00, $07, $04, $05, $03, $01, $02, $07, $00, $05, $06, $03, $01, $04, $00, $05, $02, $06, $03, $07, $04, $01, $05, $00, $03, $06, $02 ; entry 0

; E-0192 (C1: WriteKeyContentsWordRowsEntryForTemp2Temp3 copies the two bytes at $669C + 16 * hTemp2 + 2 * KeyContentsColumnPicks[hTemp3] to DE + 2; rows 0-9 hold values, rows 10-28 are zero, and the 29 rows end at the code at $686C).
; record: eight two-byte values (copied as a pair to DE)
KeyContentsWordRows::
Data_060_669C:: ; address name
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

; only called from FieldModeStateDispatch_Case04_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case04_WriteScreenTriggerCountAndWarpPendingEtc)
; reads: wMapType, wKeyWorldArea, wKeyWorldFloor, wWarpPending, wCurrentKeyIndex, wScreenTriggers
; writes: wScreenTriggerCount, wWarpPending
; points at: wScreenTriggers
FieldModeStateDispatch_Case04_Sub02_WriteScreenTriggerCountAndWarpPending::
Func_060_686C:: ; address name
    ld a, [wMapType]
    and a, $07
    cp a, $05
    jr z, .check_key_world_area

.loop:
    xor a, a
    ld [wScreenTriggerCount], a
    ret

.check_key_world_area:
    ld a, [wKeyWorldArea]
    or a, a
    jr z, .loop
    ld c, a
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState + $4
    add_a_to_hl
    ld a, [hl]
    cp a, c
    jr z, .loop
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    cp a, c
    jr z, .loop
    ld a, [wWarpPending]
    or a, a
    jr z, .loop
    xor a, a
    ld [wWarpPending], a
    ld a, [wCurrentKeyIndex]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $C7
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
    call FieldModeStateDispatch_NextRandomSeed
    call WriteRandomEntryFromTable690E
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
    cp a, c
    ret nz
    ld a, [wScreenTriggers + $3]
    ld c, a
    ld a, [wScreenTriggers + $7]
    cp a, c
    ret nz
    ld a, $01
    ld [wScreenTriggerCount], a
    ret

; DE += 2; advances the random seed; hFFC6 = wCD04 & 7; writes Data_060_690E[hFFC6] at DE, calls Func_061_4706, then writes hFFC6 at the next byte (E-0121)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case04_Sub02_WriteScreenTriggerCountAndWarpPending)
; reads: wKeyRandomHi, hTemp0
; writes: hTemp0
WriteRandomEntryFromTable690E::
Func_060_68EB:: ; address name
    inc de
    inc de
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $07
    ldh [hTemp0], a
    ld hl, WriteRandomEntryFromTable690E_Data
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

; address loaded by WriteRandomEntryFromTable690E
WriteRandomEntryFromTable690E_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_060_690E:: ; address name
    db $01, $10, $12, $13, $20, $21, $23, $32

; hFFC9 = hFFC6; picks hFFC7 from the chance row Data_060_6969[level / 10] and hFFC8 from row Data_060_6A09 + $3C * (level / 10) (E-0125)
; 2 call sites from 2 routines (e.g. DebugAutomap_Update_RollKeyContentsForLevelTemp0, WriteKeyEntryTemp0)
; reads: hTemp0
; writes: hTemp3, hTemp1, hTemp2
RollKeyContentsForLevelTemp0::
Func_060_6916:: ; address name
    ldh a, [hTemp0]
    ldh [hTemp3], a
    ld l, a
    ld h, $00
    ld a, $0A
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
    ld a, [hl+]
    or a, a
    jr z, .next
    cp a, c
    jr nc, .set_temp1

.next:
    inc b
    jr .skip

.set_temp1:
    ld a, b
    ldh [hTemp1], a
    pop af
    ld c, $3C
    call Multiply8
    ld de, KeyContentsChanceRows
    add hl, de
    call RandomBelow100
    ld c, a
    ld b, $00

.skip2:
    ld a, [hl+]
    cp a, c
    jr nc, .set_temp2
    inc b
    jr .skip2

.set_temp2:
    ld a, b
    ldh [hTemp2], a
    ret

; repeats NextRandomSeed until wCD04 & $7F is below 100; returns A = that value (E-0116)
; 2 call sites from 1 routine (e.g. RollKeyContentsForLevelTemp0)
; reads: wKeyRandomHi
RandomBelow100::
Func_060_695C:: ; address name
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $7F
    cp a, $64
    jr nc, RandomBelow100
    ret

; E-0192 (C1: RollKeyContentsForLevelTemp0 takes level / 10, reads the 16-byte row at $6969 + 16 * that, and counts entries until one is non-zero and not below a random 0-99; the count goes to hTemp1).
; record: one row per 10 levels: threshold bytes compared with a random 0-99
KeyContentsKindChanceRows::
Data_060_6969:: ; address name
    db $14, $28, $37, $46, $50, $5A, $5F, $64, $00, $00, $00, $00, $00, $00, $00, $00 ; id 0
    db $0F, $1E, $2D, $3C, $4B, $55, $5A, $5F, $64, $00, $00, $00, $00, $00, $00, $00 ; id 1
    db $00, $0A, $19, $28, $37, $46, $50, $5A, $5F, $64, $00, $00, $00, $00, $00, $00 ; id 2
    db $00, $00, $0F, $1E, $2D, $3C, $4B, $55, $5A, $5F, $64, $00, $00, $00, $00, $00 ; id 3
    db $00, $00, $05, $0F, $19, $28, $37, $46, $50, $5A, $5F, $64, $00, $00, $00, $00 ; id 4
    db $00, $00, $03, $08, $12, $21, $30, $44, $4E, $58, $5D, $62, $64, $00, $00, $00 ; id 5
    db $00, $00, $03, $08, $12, $1C, $26, $35, $44, $53, $58, $5D, $62, $64, $00, $00 ; id 6
    db $00, $00, $00, $02, $05, $0F, $19, $28, $37, $46, $50, $5A, $5F, $62, $64, $00 ; id 7
    db $00, $00, $00, $00, $03, $08, $0D, $12, $21, $30, $3F, $49, $53, $5D, $62, $64 ; id 8
    db $00, $00, $00, $00, $00, $05, $0A, $0F, $19, $23, $2D, $37, $46, $55, $5F, $64 ; id 9

; E-0192 (C1: RollKeyContentsForLevelTemp0 reads the row at $6A09 + $3C * (level / 10) and counts entries below a random 0-99 until one is not; the count goes to hTemp2; 10 rows end at $6C61).
; record: one row per 10 levels: 60 threshold bytes compared with a random 0-99, 20 per line
KeyContentsChanceRows::
Data_060_6A09:: ; address name
    db $01, $00, $02, $03, $04, $05, $00, $00, $06, $07, $00, $09, $0C, $0F, $12, $00, $00, $00, $15, $18 ; id 0
    db $1B, $1E, $21, $24, $00, $26, $29, $2C, $2F, $00, $32, $35, $00, $38, $3B, $3E, $41, $44, $00, $47
    db $4A, $4D, $50, $53, $00, $00, $00, $55, $57, $5A, $00, $5C, $5E, $61, $64, $00, $00, $00, $00, $00
    db $01, $00, $02, $03, $04, $05, $00, $00, $06, $07, $00, $09, $0C, $0F, $12, $00, $00, $00, $15, $18 ; id 1
    db $1B, $1E, $21, $24, $00, $26, $29, $2C, $2F, $00, $32, $35, $00, $38, $3B, $3E, $41, $44, $00, $47
    db $4A, $4D, $50, $53, $00, $00, $00, $55, $57, $5A, $00, $5C, $5E, $61, $64, $00, $00, $00, $00, $00
    db $01, $00, $02, $03, $04, $05, $00, $00, $06, $07, $00, $09, $0C, $0F, $12, $00, $00, $00, $15, $18 ; id 2
    db $1B, $1E, $21, $24, $00, $26, $29, $2C, $2F, $00, $32, $35, $00, $38, $3B, $3E, $41, $44, $00, $47
    db $4A, $4D, $50, $53, $00, $00, $00, $55, $57, $5A, $00, $5C, $5E, $61, $64, $00, $00, $00, $00, $00
    db $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $00, $0C, $0E, $10, $12, $14, $16, $18, $1A, $1C ; id 3
    db $1E, $20, $22, $24, $26, $28, $2A, $2C, $2E, $30, $32, $34, $36, $38, $3A, $3C, $3E, $40, $42, $44
    db $46, $48, $4A, $4C, $4E, $50, $52, $54, $56, $58, $5A, $5C, $5E, $60, $62, $64, $00, $00, $00, $00
    db $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $00, $0C, $0E, $10, $12, $14, $16, $18, $1A, $1C ; id 4
    db $1E, $20, $22, $24, $26, $28, $2A, $2C, $2E, $30, $32, $34, $36, $38, $3A, $3C, $3E, $40, $42, $44
    db $46, $48, $4A, $4C, $4E, $50, $52, $54, $56, $58, $5A, $5C, $5E, $60, $62, $64, $00, $00, $00, $00
    db $06, $0C, $12, $18, $1E, $23, $28, $2D, $32, $37, $00, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F, $40 ; id 5
    db $41, $42, $43, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F, $50, $51, $52, $53, $54
    db $55, $56, $57, $58, $59, $5A, $5B, $5C, $5D, $5E, $5F, $60, $61, $62, $63, $64, $00, $00, $00, $00
    db $06, $0C, $12, $18, $1E, $23, $28, $2D, $32, $37, $00, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F, $40 ; id 6
    db $41, $42, $43, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F, $50, $51, $52, $53, $54
    db $55, $56, $57, $58, $59, $5A, $5B, $5C, $5D, $5E, $5F, $60, $61, $62, $63, $64, $00, $00, $00, $00
    db $06, $0C, $12, $18, $1E, $23, $28, $2D, $32, $37, $00, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F, $40 ; id 7
    db $41, $42, $43, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F, $50, $51, $52, $53, $54
    db $55, $56, $57, $58, $59, $5A, $5B, $5C, $5D, $5E, $5F, $60, $61, $62, $63, $64, $00, $00, $00, $00
    db $06, $0C, $12, $18, $1E, $23, $28, $2D, $32, $37, $3A, $3B, $00, $3C, $3D, $3F, $41, $42, $00, $00 ; id 8
    db $00, $00, $43, $00, $46, $47, $00, $00, $48, $4B, $00, $00, $4D, $00, $4E, $4F, $50, $00, $51, $52
    db $53, $00, $54, $00, $55, $57, $58, $5A, $5B, $00, $5E, $60, $62, $00, $00, $64, $00, $00, $00, $00
    db $06, $0C, $12, $18, $1D, $22, $27, $2C, $31, $36, $3B, $3C, $00, $3D, $3E, $40, $41, $42, $00, $00 ; id 9
    db $00, $00, $43, $00, $46, $47, $00, $00, $48, $4B, $00, $00, $4D, $00, $4E, $4F, $50, $00, $51, $52
    db $53, $00, $54, $00, $55, $57, $58, $5A, $5B, $00, $5E, $60, $62, $00, $00, $64, $00, $00, $00, $00

; hFFC6 = the index of the first of 20 SRAM-bank-2 slots ($195 bytes apart) whose marker is not $50 + index, or $FF when all match (E-0125)
; 3 call sites from 3 routines (e.g. RunMenuStateMenuState_Case05_FindSRAMSlotMarkerIndex, DebugAutomap_Update_RollKeyContentsForLevelTemp0, LinkKeyTrade_DrawThreeTilesAtBGMap20FFromDE_Case21)
; reads: hTemp0
; writes: rRAMB, rRAMG, hTemp0
; points at: sRecords
FindSRAMSlotMarkerIndex::
Func_060_6C61:: ; address name
    ld a, $02
    ld [rRAMB], a
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ldh [hTemp0], a
    ld hl, sRecords
    ld b, $14
    ld c, $50

.loop:
    ld a, [hl]
    cp a, c
    jr nz, .skip
    ld a, l
    add a, $95
    ld l, a
    ld a, h
    adc a, $01
    ld h, a
    ldh a, [hTemp0]
    inc a
    ldh [hTemp0], a
    inc c
    dec b
    jr nz, .loop
    ld a, $FF
    ldh [hTemp0], a

.skip:
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ret

; when wCC42 < 20, writes wCC42 + $50 and the $194 bytes at wCD07 to SRAM bank 2 at $A000 + $195 * wCC42 (E-0121)
; 7 call sites from 6 routines (e.g. DebugAutomap_Update_RollKeyContentsForLevelTemp0, RunFieldReturnPhase_ResetLeadRecordFields55And5B, FieldModeStateDispatch_Case05_Sub01_WaitPlayerFacing, RunMenuStateMenuState_InitSoundHardware, ...)
; reads: wKeyWorldSlot
; writes: rRAMB, rRAMG
; points at: wKeyWorldFlags
SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot::
Func_060_6C96:: ; address name
    ld a, [wKeyWorldSlot]
    cp a, $14
    ret nc
    ld a, $02
    ld [rRAMB], a
    ld a, [wKeyWorldSlot]
    ld bc, $0195
    call Multiply8By16
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $A0
    ld h, a
    ld e, l
    ld d, h
    ld hl, wKeyWorldFlags
    ld a, $0A
    ld [rRAMG], a
    ld a, [wKeyWorldSlot]
    add a, $50
    ld [de], a
    inc de
    ld bc, $0194
    call CopyBytes
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ret

; when wCC42 < 20 and SRAM bank 2 slot wCC42 is marked wCC42 + $50, copies its $194 bytes to wCD07; counterpart of SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot (E-0124)
; 8 call sites from 8 routines (e.g. DebugAutomap_Update, RunMenuStateMenuState_InitSoundHardware, GameMode5_Init_SendSGBPaletteSetPacket, GameMode5_Init_SendSGBPaletteSetPacket_Case03, ...)
; reads: wKeyWorldSlot
; writes: rRAMB, rRAMG
; points at: wKeyWorldFlags
LoadKeyWorldFlagsRecordFromSRAMSlotKeyWorldSlot::
Func_060_6CD1:: ; address name
    ld a, [wKeyWorldSlot]
    cp a, $14
    ret nc
    ld a, $02
    ld [rRAMB], a
    ld a, [wKeyWorldSlot]
    ld bc, $0195
    call Multiply8By16
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $A0
    ld h, a
    ld de, wKeyWorldFlags
    ld a, $0A
    ld [rRAMG], a
    ld a, [wKeyWorldSlot]
    add a, $50
    ld c, a
    ld a, [hl+]
    cp a, c
    jr nz, .skip
    ld bc, $0194
    call CopyBytes

.skip:
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ret

; E-0193 (C1: a copy of KeyWorldAreaLayoutTable (84:$4CCB), word for word; Func_060_51F9's code and PlaceObjectInAreaC read the layout's first byte or a block byte through ReadByteInBank with B = $84).
; record: area layout in bank $84
KeyWorldAreaLayoutTable_Bank60::
Data_060_6D0D:: ; address name
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

; E-0256 (C1: PickRandomMonsterFromBandList (with RollKeyWorldMonsterTableKeyWorldMonsters and ...BossMonsters) reads the word at $6D6D + 16 * hTemp1 + 2 * hTemp0 and picks one of the count words that follow the list's count byte; 11 rows (families, StringTable_MonsterFamilies order) of 8 bands).
; record: species list (count, then words)
KeyWorldBandSpeciesTable::
Data_060_6D6D:: ; address name
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

; E-0256 (C1: row 0 (Slime), band 0 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Slime_0::
Data_060_6E1D:: ; address name
    db $03 ; entry 0
    dw $0002 ; SpotSlime
    dw $0005 ; Snaily
    dw $000F ; Slabbit

; E-0256 (C1: row 0 (Slime), band 1 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Slime_1::
Data_060_6E24:: ; address name
    db $04 ; entry 0
    dw $0004 ; TreeSlime
    dw $0007 ; Babble
    dw $000A ; Slime
    dw $0014 ; TropicGel

; E-0256 (C1: row 0 (Slime), band 2 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Slime_2::
Data_060_6E2D:: ; address name
    db $04 ; entry 0
    dw $0002 ; SpotSlime
    dw $0008 ; BoxSlime
    dw $0009 ; PearlGel
    dw $000B ; Healer

; E-0256 (C1: row 0 (Slime), band 3 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Slime_3::
Data_060_6E36:: ; address name
    db $05 ; entry 0
    dw $0001 ; DrakSlime
    dw $0006 ; SlimeNite
    dw $000C ; FangSlime
    dw $000D ; RockSlime
    dw $000E ; SlimeBorg

; E-0256 (C1: row 0 (Slime), band 4 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Slime_4::
Data_060_6E41:: ; address name
    db $04 ; entry 0
    dw $0011 ; Metaly
    dw $0013 ; SpotKing
    dw $0015 ; MimeSlime
    dw $0016 ; HaloSlime

; E-0256 (C1: row 0 (Slime), band 5 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Slime_5::
Data_060_6E4A:: ; address name
    db $03 ; entry 0
    dw $0010 ; KingSlime
    dw $0012 ; Metabble
    dw $0017 ; MetalKing

; E-0256 (C1: row 0 (Slime), band 6 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Slime_6::
Data_060_6E51:: ; address name
    db $01 ; entry 0
    dw $0018 ; GoldSlime

; E-0256 (C1: row 0 (Slime), band 7 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Slime_7::
Data_060_6E54:: ; address name
    db $02 ; entry 0
    dw $0019 ; GranSlime
    dw $001A ; WonderEgg

; E-0256 (C1: row 1 (Dragon), band 0 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Dragon_0::
Data_060_6E59:: ; address name
    db $03 ; entry 0
    dw $0028 ; FairyDrak
    dw $0031 ; Chamelgon
    dw $0032 ; LizardFly

; E-0256 (C1: row 1 (Dragon), band 1 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Dragon_1::
Data_060_6E60:: ; address name
    db $05 ; entry 0
    dw $002A ; Poisongon
    dw $002E ; MiniDrak
    dw $0034 ; KingCobra
    dw $0036 ; SnakeBat
    dw $0039 ; Crestpent

; E-0256 (C1: row 1 (Dragon), band 2 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Dragon_2::
Data_060_6E6B:: ; address name
    db $05 ; entry 0
    dw $0024 ; DragonKid
    dw $0025 ; Tortragon
    dw $0026 ; Pteranod
    dw $0027 ; Gasgon
    dw $003A ; WingSnake

; E-0256 (C1: row 1 (Dragon), band 3 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Dragon_3::
Data_060_6E76:: ; address name
    db $04 ; entry 0
    dw $002B ; Swordgon
    dw $002C ; Drygon
    dw $0030 ; Rayburn
    dw $0035 ; Vampirus

; E-0256 (C1: row 1 (Dragon), band 4 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Dragon_4::
Data_060_6E7F:: ; address name
    db $06 ; entry 0
    dw $0029 ; LizardMan
    dw $002D ; Dragon
    dw $002F ; MadDragon
    dw $0033 ; Andreal
    dw $0037 ; Spikerous
    dw $003B ; Coatol

; E-0256 (C1: row 1 (Dragon), band 5 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Dragon_5::
Data_060_6E8C:: ; address name
    db $04 ; entry 0
    dw $0038 ; GreatDrak
    dw $003D ; BattleRex
    dw $003E ; SkyDragon
    dw $003F ; Serpentia

; E-0256 (C1: row 1 (Dragon), band 6 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Dragon_6::
Data_060_6E95:: ; address name
    db $03 ; entry 0
    dw $003C ; Orochi
    dw $0040 ; Divinegon
    dw $0042 ; GigaDraco

; E-0256 (C1: row 1 (Dragon), band 7 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Dragon_7::
Data_060_6E9C:: ; address name
    db $01 ; entry 0
    dw $0041 ; Orligon

; E-0256 (C1: row 2 (Beast), band 0 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Beast_0::
Data_060_6E9F:: ; address name
    db $06 ; entry 0
    dw $0048 ; Almiraj
    dw $0049 ; CatFly
    dw $004A ; PillowRat
    dw $004B ; Saccer
    dw $0050 ; Antbear
    dw $005B ; FairyRat

; E-0256 (C1: row 2 (Beast), band 1 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Beast_1::
Data_060_6EAC:: ; address name
    db $06 ; entry 0
    dw $004D ; Skullroo
    dw $004E ; WindBeast
    dw $0053 ; Mommonja
    dw $0054 ; HammerMan
    dw $0057 ; ArrowDog
    dw $005A ; MadGopher

; E-0256 (C1: row 2 (Beast), band 2 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Beast_2::
Data_060_6EB9:: ; address name
    db $06 ; entry 0
    dw $0047 ; Tonguella
    dw $004F ; Beavern
    dw $0051 ; SuperTen
    dw $0052 ; IronTurt
    dw $0058 ; NoctoKing
    dw $0059 ; BeastNite

; E-0256 (C1: row 2 (Beast), band 3 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Beast_3::
Data_060_6EC6:: ; address name
    db $06 ; entry 0
    dw $0055 ; Grizzly
    dw $0056 ; Yeti
    dw $005D ; Goategon
    dw $005E ; WildApe
    dw $0065 ; CatMage
    dw $0066 ; Dumbira

; E-0256 (C1: row 2 (Beast), band 4 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Beast_4::
Data_060_6ED3:: ; address name
    db $04 ; entry 0
    dw $004C ; GulpBeast
    dw $005F ; Trumpeter
    dw $0062 ; MadCat
    dw $0063 ; BigEye

; E-0256 (C1: row 2 (Beast), band 5 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Beast_5::
Data_060_6EDC:: ; address name
    db $02 ; entry 0
    dw $005C ; Unicorn
    dw $0061 ; DarkHorn

; E-0256 (C1: row 2 (Beast), band 6 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Beast_6::
Data_060_6EE1:: ; address name
    db $01 ; entry 0
    dw $0060 ; KingLeo

; E-0256 (C1: row 2 (Beast), band 7 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Beast_7::
Data_060_6EE4:: ; address name
    db $01 ; entry 0
    dw $0064 ; Gorago

; E-0256 (C1: row 3 (Bird), band 0 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Bird_0::
Data_060_6EE7:: ; address name
    db $02 ; entry 0
    dw $006A ; Picky
    dw $0073 ; Dracky

; E-0256 (C1: row 3 (Bird), band 1 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Bird_1::
Data_060_6EEC:: ; address name
    db $04 ; entry 0
    dw $006D ; Florajay
    dw $0070 ; MadRaven
    dw $0074 ; KiteHawk
    dw $0075 ; BigRoost

; E-0256 (C1: row 3 (Bird), band 2 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Bird_2::
Data_060_6EF5:: ; address name
    db $06 ; entry 0
    dw $006C ; BullBird
    dw $0071 ; MistyWing
    dw $0072 ; AquaHawk
    dw $0076 ; StubBird
    dw $0077 ; LandOwl
    dw $0084 ; CragDevil

; E-0256 (C1: row 3 (Bird), band 3 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Bird_3::
Data_060_6F02:: ; address name
    db $06 ; entry 0
    dw $006B ; Wyvern
    dw $006E ; DuckKite
    dw $006F ; MadPecker
    dw $0078 ; MadGoose
    dw $0079 ; MadCondor
    dw $007A ; Emyu

; E-0256 (C1: row 3 (Bird), band 4 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Bird_4::
Data_060_6F0F:: ; address name
    db $04 ; entry 0
    dw $007B ; Blizzardy
    dw $007C ; Phoenix
    dw $007D ; ZapBird
    dw $0080 ; FunkyBird

; E-0256 (C1: row 3 (Bird), band 5 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Bird_5::
Data_060_6F18:: ; address name
    db $02 ; entry 0
    dw $007E ; Garudian
    dw $007F ; WhipBird

; E-0256 (C1: row 3 (Bird), band 6 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Bird_6::
Data_060_6F1D:: ; address name
    db $02 ; entry 0
    dw $0081 ; RainHawk
    dw $0083 ; Shantak

; E-0256 (C1: row 3 (Bird), band 7 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Bird_7::
Data_060_6F22:: ; address name
    db $01 ; entry 0
    dw $0082 ; Azurile

; E-0256 (C1: row 4 (Plant), band 0 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Plant_0::
Data_060_6F25:: ; address name
    db $04 ; entry 0
    dw $0091 ; CactiBall
    dw $0093 ; Toadstool
    dw $0095 ; Slurperon
    dw $00A6 ; Eggplaton

; E-0256 (C1: row 4 (Plant), band 1 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Plant_1::
Data_060_6F2E:: ; address name
    db $03 ; entry 0
    dw $008D ; MadPlant
    dw $0090 ; WingTree
    dw $0097 ; Oniono

; E-0256 (C1: row 4 (Plant), band 2 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Plant_2::
Data_060_6F35:: ; address name
    db $05 ; entry 0
    dw $008E ; FireWeed
    dw $008F ; FloraMan
    dw $0092 ; Gulpple
    dw $0096 ; Stubsuck
    dw $0098 ; DanceVegi

; E-0256 (C1: row 4 (Plant), band 3 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Plant_3::
Data_060_6F40:: ; address name
    db $07 ; entry 0
    dw $0094 ; AmberWeed
    dw $0099 ; TreeBoy
    dw $009A ; Devipine
    dw $009D ; BeanMan
    dw $009E ; EvilSeed
    dw $009F ; ManEater
    dw $00A7 ; FooHero

; E-0256 (C1: row 4 (Plant), band 4 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Plant_4::
Data_060_6F4F:: ; address name
    db $02 ; entry 0
    dw $00A0 ; Snapper
    dw $00A1 ; GhosTree

; E-0256 (C1: row 4 (Plant), band 5 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Plant_5::
Data_060_6F54:: ; address name
    db $02 ; entry 0
    dw $009B ; FaceTree
    dw $009C ; HerbMan

; E-0256 (C1: row 4 (Plant), band 6 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Plant_6::
Data_060_6F59:: ; address name
    db $01 ; entry 0
    dw $00A2 ; Rosevine

; E-0256 (C1: row 4 (Plant), band 7 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Plant_7::
Data_060_6F5C:: ; address name
    db $03 ; entry 0
    dw $00A3 ; Egdracil
    dw $00A4 ; Warubou
    dw $00A5 ; Watabou

; E-0256 (C1: row 5 (Bug), band 0 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Bug_0::
Data_060_6F63:: ; address name
    db $04 ; entry 0
    dw $00B0 ; GiantSlug
    dw $00B5 ; GiantWorm
    dw $00B9 ; ArmyAnt
    dw $00BB ; TailEater

; E-0256 (C1: row 5 (Bug), band 1 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Bug_1::
Data_060_6F6C:: ; address name
    db $03 ; entry 0
    dw $00B2 ; Gophecada
    dw $00B3 ; Butterfly
    dw $00BA ; GoHopper

; E-0256 (C1: row 5 (Bug), band 2 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Bug_2::
Data_060_6F73:: ; address name
    db $05 ; entry 0
    dw $00B6 ; Lipsy
    dw $00B7 ; StagBug
    dw $00B8 ; Pyuro
    dw $00BD ; Eyeder
    dw $00C2 ; Belzebub

; E-0256 (C1: row 5 (Bug), band 3 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Bug_3::
Data_060_6F7E:: ; address name
    db $07 ; entry 0
    dw $00B1 ; Catapila
    dw $00B4 ; WeedBug
    dw $00BC ; ArmorPede
    dw $00BE ; GiantMoth
    dw $00BF ; Droll
    dw $00C1 ; MadHornet
    dw $00C9 ; MultiEyes

; E-0256 (C1: row 5 (Bug), band 4 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Bug_4::
Data_060_6F8D:: ; address name
    db $02 ; entry 0
    dw $00C0 ; ArmyCrab
    dw $00C5 ; Sickler

; E-0256 (C1: row 5 (Bug), band 5 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Bug_5::
Data_060_6F92:: ; address name
    db $03 ; entry 0
    dw $00C3 ; WarMantis
    dw $00C4 ; HornBeet
    dw $00C7 ; Digster

; E-0256 (C1: row 5 (Bug), band 6 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Bug_6::
Data_060_6F99:: ; address name
    db $01 ; entry 0
    dw $00C6 ; Armorpion

; E-0256 (C1: row 5 (Bug), band 7 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Bug_7::
Data_060_6F9C:: ; address name
    db $01 ; entry 0
    dw $00C8 ; Skularach

; E-0256 (C1: row 6 (Demon), band 0 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Demon_0::
Data_060_6F9F:: ; address name
    db $02 ; entry 0
    dw $00D3 ; Pixy
    dw $00D6 ; Demonite

; E-0256 (C1: row 6 (Demon), band 1 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Demon_1::
Data_060_6FA4:: ; address name
    db $02 ; entry 0
    dw $00DC ; 1EyeClown
    dw $00DD ; Gremlin

; E-0256 (C1: row 6 (Demon), band 2 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Demon_2::
Data_060_6FA9:: ; address name
    db $03 ; entry 0
    dw $00D4 ; MedusaEye
    dw $00D8 ; EyeBall
    dw $00E1 ; Orc

; E-0256 (C1: row 6 (Demon), band 3 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Demon_3::
Data_060_6FB0:: ; address name
    db $04 ; entry 0
    dw $00D7 ; DarkEye
    dw $00D9 ; SkulRider
    dw $00EA ; Gigantes
    dw $00EC ; EvilArmor

; E-0256 (C1: row 6 (Demon), band 4 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Demon_4::
Data_060_6FB9:: ; address name
    db $06 ; entry 0
    dw $00D5 ; AgDevil
    dw $00DA ; EvilBeast
    dw $00DB ; Bubblemon
    dw $00DF ; Lionex
    dw $00E2 ; Ogre
    dw $00E8 ; MadKnight

; E-0256 (C1: row 6 (Demon), band 5 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Demon_5::
Data_060_6FC6:: ; address name
    db $08 ; entry 0
    dw $00DE ; ArcDemon
    dw $00E0 ; GoatHorn
    dw $00E3 ; GateGuard
    dw $00E4 ; ChopClown
    dw $00E5 ; BossTroll
    dw $00E6 ; Grendal
    dw $00E9 ; EvilWell
    dw $00EB ; Centasaur

; E-0256 (C1: row 6 (Demon), band 6 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Demon_6::
Data_060_6FD7:: ; address name
    db $04 ; entry 0
    dw $00E7 ; Akubar
    dw $00ED ; Jamirus
    dw $00EE ; Durran
    dw $00F0 ; LampGenie

; E-0256 (C1: row 6 (Demon), band 7 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Demon_7::
Data_060_6FE0:: ; address name
    db $01 ; entry 0
    dw $00EF ; Titanis

; E-0256 (C1: row 7 (Zombie), band 0 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Zombie_0::
Data_060_6FE3:: ; address name
    db $01 ; entry 0
    dw $00F6 ; Spooky

; E-0256 (C1: row 7 (Zombie), band 1 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Zombie_1::
Data_060_6FE6:: ; address name
    db $04 ; entry 0
    dw $00F9 ; RotRaven
    dw $0100 ; Mudron
    dw $0104 ; Inverzon
    dw $0105 ; FoxFire

; E-0256 (C1: row 7 (Zombie), band 2 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Zombie_2::
Data_060_6FEF:: ; address name
    db $08 ; entry 0
    dw $00F8 ; PutrePup
    dw $00FA ; Mummy
    dw $00FD ; Shadow
    dw $00FE ; Skulpent
    dw $00FF ; Hork
    dw $0101 ; NiteWhip
    dw $0102 ; WindMerge
    dw $010F ; PomPomBom

; E-0256 (C1: row 7 (Zombie), band 3 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Zombie_3::
Data_060_7000:: ; address name
    db $06 ; entry 0
    dw $00FB ; DarkCrab
    dw $00FC ; DeadNite
    dw $0103 ; Reaper
    dw $0106 ; CaptDead
    dw $0109 ; BoneSlave
    dw $010E ; MadSpirit

; E-0256 (C1: row 7 (Zombie), band 4 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Zombie_4::
Data_060_700D:: ; address name
    db $01 ; entry 0
    dw $010A ; Skeletor

; E-0256 (C1: row 7 (Zombie), band 5 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Zombie_5::
Data_060_7010:: ; address name
    db $02 ; entry 0
    dw $00F7 ; Skullgon
    dw $010B ; Servant

; E-0256 (C1: row 7 (Zombie), band 6 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Zombie_6::
Data_060_7015:: ; address name
    db $04 ; entry 0
    dw $0107 ; DeadNoble
    dw $0108 ; WhiteKing
    dw $010D ; Copycat
    dw $0110 ; Niterich

; E-0256 (C1: row 7 (Zombie), band 7 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Zombie_7::
Data_060_701E:: ; address name
    db $01 ; entry 0
    dw $010C ; Lazamanus

; E-0256 (C1: row 8 (Material), band 0 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Material_0::
Data_060_7021:: ; address name
    db $05 ; entry 0
    dw $011B ; MadCandle
    dw $011D ; Facer
    dw $011E ; SpikyBoy
    dw $0122 ; Goopi
    dw $0131 ; MudDoll

; E-0256 (C1: row 8 (Material), band 1 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Material_1::
Data_060_702C:: ; address name
    db $04 ; entry 0
    dw $0119 ; JewelBag
    dw $011C ; CoilBird
    dw $0128 ; Brushead
    dw $0137 ; ProtoMech

; E-0256 (C1: row 8 (Material), band 2 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Material_2::
Data_060_7035:: ; address name
    db $03 ; entry 0
    dw $011A ; EvilWand
    dw $0121 ; Puppetor
    dw $0127 ; CurseLamp

; E-0256 (C1: row 8 (Material), band 3 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Material_3::
Data_060_703C:: ; address name
    db $08 ; entry 0
    dw $011F ; MadMirror
    dw $0120 ; RogueNite
    dw $0123 ; Voodoll
    dw $0126 ; SabreMan
    dw $012B ; EvilPot
    dw $012C ; Gismo
    dw $0130 ; Exaucers
    dw $0138 ; CloudKing

; E-0256 (C1: row 8 (Material), band 4 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Material_4::
Data_060_704D:: ; address name
    db $06 ; entry 0
    dw $0124 ; MetalDrak
    dw $0129 ; Roboster
    dw $012F ; Mimic
    dw $0132 ; Golem
    dw $0133 ; StoneMan
    dw $0134 ; BombCrag

; E-0256 (C1: row 8 (Material), band 5 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Material_5::
Data_060_705A:: ; address name
    db $04 ; entry 0
    dw $0125 ; Balzak
    dw $012A ; Roboster2
    dw $012D ; LavaMan
    dw $012E ; IceMan

; E-0256 (C1: row 8 (Material), band 6 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Material_6::
Data_060_7063:: ; address name
    db $01 ; entry 0
    dw $0135 ; GoldGolem

; E-0256 (C1: row 8 (Material), band 7 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Material_7::
Data_060_7066:: ; address name
    db $01 ; entry 0
    dw $0136 ; DarkMate

; E-0256 (C1: row 9 (Water), band 0 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Water_0::
Data_060_7069:: ; address name
    db $03 ; entry 0
    dw $013C ; Petiteel
    dw $013D ; Moray
    dw $0144 ; PutreFish

; E-0256 (C1: row 9 (Water), band 1 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Water_1::
Data_060_7070:: ; address name
    db $04 ; entry 0
    dw $0143 ; Octokid
    dw $0149 ; Gamanian
    dw $014D ; Scallopa
    dw $015B ; Starfish

; E-0256 (C1: row 9 (Water), band 2 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Water_2::
Data_060_7079:: ; address name
    db $05 ; entry 0
    dw $0140 ; Anemon
    dw $0141 ; Aquarella
    dw $0145 ; Octoreach
    dw $014C ; RogueWave
    dw $015A ; Pumpoise

; E-0256 (C1: row 9 (Water), band 3 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Water_3::
Data_060_7084:: ; address name
    db $06 ; entry 0
    dw $013E ; WalrusMan
    dw $013F ; RayGigas
    dw $0142 ; Merman
    dw $0146 ; Angleron
    dw $0147 ; FishRider
    dw $014A ; Clawster

; E-0256 (C1: row 9 (Water), band 4 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Water_4::
Data_060_7091:: ; address name
    db $05 ; entry 0
    dw $0148 ; RushFish
    dw $014B ; CancerMan
    dw $014E ; SeaHorse
    dw $014F ; HoodSquid
    dw $0150 ; MerTiger

; E-0256 (C1: row 9 (Water), band 5 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Water_5::
Data_060_709C:: ; address name
    db $05 ; entry 0
    dw $0151 ; AxeShark
    dw $0152 ; Octogon
    dw $0154 ; Digong
    dw $0155 ; WhaleMage
    dw $0157 ; Octoraid

; E-0256 (C1: row 9 (Water), band 6 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Water_6::
Data_060_70A7:: ; address name
    db $03 ; entry 0
    dw $0153 ; KingSquid
    dw $0156 ; Aquadon
    dw $0158 ; Grakos

; E-0256 (C1: row 9 (Water), band 7 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Water_7::
Data_060_70AE:: ; address name
    db $01 ; entry 0
    dw $0159 ; Poseidon

; E-0256 (C1: row 10 (Boss), band 0 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Boss_0::
Data_060_70B1:: ; address name
    db $06 ; entry 0
    dw $015F ; DracoLord
    dw $0162 ; Hargon
    dw $0165 ; Baramos
    dw $016A ; Esterk
    dw $016B ; Mirudraas
    dw $016D ; Mudou

; E-0256 (C1: row 10 (Boss), band 1 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Boss_1::
Data_060_70BE:: ; address name
    db $06 ; entry 0
    dw $015F ; DracoLord
    dw $0162 ; Hargon
    dw $0165 ; Baramos
    dw $016A ; Esterk
    dw $016B ; Mirudraas
    dw $016D ; Mudou

; E-0256 (C1: row 10 (Boss), band 2 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Boss_2::
Data_060_70CB:: ; address name
    db $06 ; entry 0
    dw $015F ; DracoLord
    dw $0162 ; Hargon
    dw $0165 ; Baramos
    dw $016A ; Esterk
    dw $016B ; Mirudraas
    dw $016D ; Mudou

; E-0256 (C1: row 10 (Boss), band 3 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Boss_3::
Data_060_70D8:: ; address name
    db $06 ; entry 0
    dw $015F ; DracoLord
    dw $0162 ; Hargon
    dw $0165 ; Baramos
    dw $016A ; Esterk
    dw $016B ; Mirudraas
    dw $016D ; Mudou

; E-0256 (C1: row 10 (Boss), band 4 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Boss_4::
Data_060_70E5:: ; address name
    db $06 ; entry 0
    dw $015F ; DracoLord
    dw $0162 ; Hargon
    dw $0165 ; Baramos
    dw $016A ; Esterk
    dw $016B ; Mirudraas
    dw $016D ; Mudou

; E-0256 (C1: row 10 (Boss), band 5 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Boss_5::
Data_060_70F2:: ; address name
    db $06 ; entry 0
    dw $015F ; DracoLord
    dw $0162 ; Hargon
    dw $0165 ; Baramos
    dw $016A ; Esterk
    dw $016B ; Mirudraas
    dw $016D ; Mudou
    db $06

; E-0256 (C1: row 10 (Boss), band 6 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Boss_6::
Data_060_7100:: ; address name
    db $06 ; entry 0
    dw $015F ; DracoLord
    dw $0162 ; Hargon
    dw $0165 ; Baramos
    dw $016A ; Esterk
    dw $016B ; Mirudraas
    dw $016D ; Mudou

; E-0256 (C1: row 10 (Boss), band 7 of KeyWorldBandSpeciesTable).
; record: count; species
KeyWorldBandSpecies_Boss_7::
Data_060_710D:: ; address name
    db $10 ; entry 0
    dw $0160 ; DracoLord
    dw $0161 ; LordDraco
    dw $0163 ; Sidoh
    dw $0164 ; Genosidoh
    dw $0166 ; Zoma
    dw $0167 ; AsuraZoma
    dw $0168 ; Pizzaro
    dw $0169 ; PsychoPiz
    dw $016C ; Mirudraas
    dw $016E ; DeathMore
    dw $016F ; DeathMore
    dw $0170 ; DeathMore
    dw $0171 ; Darkdrium
    dw $0172 ; Orgodemir
    dw $0173 ; Orgodemir
    dw $0174 ; Darck
    ds $ED2, $00
