; ROM bank $19: battle loading (game mode 4 set-up)
; The annotated listing of this bank is build/listing/bank19.asm.

SECTION "Bank 19", ROMX
    db $19

; Battle start (GameMode4_Init far-calls it): keeps wBattleKind while clearing $303 bytes from
; wEffectAnimState, 8 from wBattlePhase and 8 from wListPageSize, saves wDataBank in wDataBankSave
; and resets the battle arrays (GameMode4_Init_ResetBattleArrays); outside link battles clears 512
; bytes of wWorkBuf, copies the party's records into the battler records
; (GameMode4_Init_CopyPartyToBattlers), loads the foes (GameMode4_Init_LoadFoes) and copies foe
; slots 4-6's BATTLER_JOIN_CLASS to wFoeJoinClass1-3; then the battle slots
; (GameMode4_Init_LoadBattleSlots), the screen, the foe pictures (GameMode4_Init_LoadFoePictures),
; the music (GameMode4_Init_PlayBattleMusic) and the slot marks. (C1, E-0370)
GameMode4_Init_SetUpBattle::
    ld a, [wBattleKind]
    push af
    ld hl, wEffectAnimState
    ld bc, $0303
    xor a
    call FillBytes
    ld a, [wDataBank]
    ld [wDataBankSave], a
    ld hl, wBattlePhase
    ld bc, $0008
    xor a
    call FillBytes
    ld hl, wListPageSize
    ld bc, $0008
    xor a
    call FillBytes
    pop af
    ld [wBattleKind], a
    call GameMode4_Init_ResetBattleArrays
    ld a, [wLinkMode]
    or a
    jr nz, .call_game_mode4_init_load_battle_slots
    ld hl, wWorkBuf
    ld bc, $0200
    xor a
    call FillBytes
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    call GameMode4_Init_CopyPartyToBattlers
    call GameMode4_Init_LoadFoes
    ld a, [wBattlerRecordSlot4 + BATTLER_JOIN_CLASS]
    ld [wFoeJoinClass1], a
    ld a, [wBattlerRecordSlot5 + BATTLER_JOIN_CLASS]
    ld [wFoeJoinClass2], a
    ld a, [wBattlerRecordSlot6 + BATTLER_JOIN_CLASS]
    ld [wFoeJoinClass3], a
    ld a, $00
    ld [rRAMG], a
    jr .call_game_mode4_init_load_battle_slots

.call_game_mode4_init_load_battle_slots:
    call GameMode4_Init_LoadBattleSlots
    call GameMode4_Init_BuildBattleScreen
    call GameMode4_Init_LoadFoePictures
    call GameMode4_Init_PlayBattleMusic
    call GameMode4_Init_SetSlotMarks
    ret

SECTION "Bank 19 GameMode4_Init_ResetBattleArrays", ROMX

; Resets the battle arrays: command menu state 1 for battle kinds 4, 5 and 9 (else 0); no effect,
; queued action, Seal/Pray state or item target; slot marks, monster ids, skills, slot out and name
; bytes $FF; side control $80; battle meter 10; turn 0, scene 0. Outside link battles takes the
; party count, the foe count (wEncounterKind + 1), the setup byte and the text speed; in link
; battles text speed 3 and the counts from the battler records by link role. (C2, E-0357; probed
; E-0378)
GameMode4_Init_ResetBattleArrays::
    ld a, [wBattleKind]
    cp $04
    jr z, .set_command_menu_state_to_01
    cp $05
    jr z, .set_command_menu_state_to_01
    cp $09
    jr z, .set_command_menu_state_to_01
    xor a
    jr .set_command_menu_state

.set_command_menu_state_to_01:
    ld a, $01

.set_command_menu_state:
    ld [wCommandMenuState], a
    ld a, $ff
    ld [wEffectId], a
    ld [wQueuedActionId], a
    ld [wSealPrayState], a
    ld [wBattleItemTarget], a
    ld hl, wMenuState
    ld bc, $0008
    xor a
    call FillBytes
    xor a
    ld [wDebugValue3], a
    ld [wDebugState], a
    ld [wDebugSubState], a
    ld hl, wSlotMarks
    ld bc, $0008
    ld a, $ff
    call FillBytes
    ld hl, wSideControl
    ld bc, $0008
    ld a, $80
    call FillBytes
    ld hl, wBattleSlotOut
    ld bc, $0008
    ld a, $ff
    call FillBytes
    ld hl, wBattleMonsterId
    ld bc, $0010
    ld a, $ff
    call FillBytes
    ld a, $ff
    ld hl, wBattleSkills + $7f
    ld bc, $0080
    call FillBytes
    ld a, $ff
    ld hl, wSlotNameBytes
    ld [hli], a
    ld [hli], a
    ld [hl], a
    ld a, $ff
    ld [wDisplaySlot], a
    ld a, $0a
    ld [wBattleMeter], a
    ld hl, wActionQueue
    ld bc, $000a
    ld a, $ff
    call FillBytes
    xor a
    ld [wBattleTurn], a
    ld a, $00
    ld [wBattleScene], a
    xor a
    ld [wBattleLoadWork], a
    ld [wBattleLoadWork + $1], a
    ld [wBattleLoadWork + $2], a
    ld a, [wLinkMode]
    or a
    jr nz, .set_text_speed_to_03
    ld a, [wPartyCount]
    ld [wBattlePartyCount], a
    ld [wSide0Flag], a
    ld a, [wEncounterKind]
    inc a
    ld [wBattleFoeCount], a
    ld [wSide1Flag], a
    ld a, [wBattleResultByte]
    ld [wBattleSetupDB], a
    ld a, [wBattleTextSpeed]
    ld [wTextSpeed], a
    jr .clear_link_rule_flags

.set_text_speed_to_03:
    ld a, $03
    ld [wTextSpeed], a
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .call_game_mode4_init_count_battler_records
    ld hl, wBattlerRecords + BATTLER_LEVEL
    call GameMode4_Init_CountBattlerRecords
    ld [wBattlePartyCount], a
    ld [wSide0Flag], a
    ld hl, wBattlerRecordSlot4 + BATTLER_LEVEL
    call GameMode4_Init_CountBattlerRecords
    ld [wBattleFoeCount], a
    ld [wSide1Flag], a
    jr .clear_link_rule_flags

.call_game_mode4_init_count_battler_records:
    ld hl, wBattlerRecords + BATTLER_LEVEL
    call GameMode4_Init_CountBattlerRecords
    ld [wBattleFoeCount], a
    ld [wSide0Flag], a
    ld hl, wBattlerRecordSlot4 + BATTLER_LEVEL
    call GameMode4_Init_CountBattlerRecords
    ld [wBattlePartyCount], a
    ld [wSide1Flag], a

.clear_link_rule_flags:
    xor a
    ld [wLinkRuleFlags], a
    ld [wLinkRuleState], a
    ret

SECTION "Bank 19 GameMode4_Init_CountBattlerRecords", ROMX

; HL = the BATTLER_LEVEL field of the first of up to three $4E-byte battler records: returns A = C =
; 1, plus 1 for the second record when its byte is non-zero, plus 1 more for the third when that one
; is non-zero as well. The first record byte is not tested. (C2, E-0378)
; A = 1, 2 or 3: how many $4E-byte battler records from HL are in use
GameMode4_Init_CountBattlerRecords::
    ld de, $004e
    ld c, $01
    add hl, de
    ld a, [hl]
    or a
    jr z, .done
    ld c, $02
    add hl, de
    ld a, [hl]
    or a
    jr z, .done
    ld c, $03

.done:
    ld a, c
    ret

SECTION "Bank 19 GameMode4_Init_BuildBattleScreen", ROMX

; Builds the battle screen: the glyph tiles, cleared attributes, the party's layout, the foes'
; picture blocks, the status panels and the picture attributes, copied to the BG map with a palette
; upload. (C1, E-0357)
GameMode4_Init_BuildBattleScreen::
    farcall GameMode4_Init_BuildBattleScreen_LoadNameTiles
    farcall ClearAttributesAndScreenBuffer_Bank31
    farcall CopyRectRecordForBattlePartyCount_Bank31
    farcall LayoutTileBlocksForBattleFoeCount
    farcall DrawPartySlotStatusPanels
    farcall LoadBattleMonsterPictureAttributes
    ld hl, vBGMap0
    call CopyScreenTileBufferToVRAM_A0_Bank19
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    ret

SECTION "Bank 19 GameMode4_Init_LoadFoePictures", ROMX

; Loads the foes' pictures (the link follower's foes are slots 0-2, otherwise 4-6) into vTiles2 +
; $140, $380 and $5C0 with palettes 1, 3 and 5, as many as there are foes. (C1, E-0357)
GameMode4_Init_LoadFoePictures::
    ld de, wBattlerRecordSlot4 + BATTLER_SPECIES
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_game_mode4_init_load_foe_pictures_load
    ld de, wBattlerRecords + BATTLER_SPECIES

.call_game_mode4_init_load_foe_pictures_load:
    ld hl, vTiles2 + $140
    ld c, $01
    call GameMode4_Init_LoadFoePictures_LoadOne
    ld a, [wBattleFoeCount]
    cp $01
    jr z, .return
    ld de, wBattlerRecordSlot5 + BATTLER_SPECIES
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_game_mode4_init_load_foe_pictures_load2
    ld de, wBattlerRecordSlot1 + BATTLER_SPECIES

.call_game_mode4_init_load_foe_pictures_load2:
    ld hl, vTiles2 + $380
    ld c, $03
    call GameMode4_Init_LoadFoePictures_LoadOne
    ld a, [wBattleFoeCount]
    cp $02
    jr z, .return
    ld de, wBattlerRecordSlot6 + BATTLER_SPECIES
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_game_mode4_init_load_foe_pictures_load3
    ld de, wBattlerRecordSlot2 + BATTLER_SPECIES

.call_game_mode4_init_load_foe_pictures_load3:
    ld hl, vTiles2 + $5c0
    ld c, $05
    call GameMode4_Init_LoadFoePictures_LoadOne

.return:
    ret

SECTION "Bank 19 GameMode4_Init_LoadFoePictures_LoadOne", ROMX

; DE = address of a BATTLER_SPECIES word, HL = VRAM destination, C = palette slot: loads that
; monster's picture (LoadMonsterPicture with DE = the id). (C1, E-0370)
GameMode4_Init_LoadFoePictures_LoadOne::
    ld a, [de]
    push af
    inc de
    ld a, [de]
    ld d, a
    pop af
    ld e, a
    call LoadMonsterPicture
    ret

SECTION "Bank 19 GameMode4_Init_LoadBattleSlots", ROMX

; Loads the battle slots from the battler records (the player's side from slot 0 and the other from
; slot 4, the counts swapped for the link follower), adjusts the skills, and sets each present
; slot's body flags from its species (metal in the low nibble, untrippable in the high). (C2,
; E-0357; probed E-0378)
GameMode4_Init_LoadBattleSlots::
    ld a, [wBattlePartyCount]
    ld b, a
    ld c, $00
    ld a, [wLinkRole]
    bit 1, a
    jr z, .loop
    ld a, [wBattleFoeCount]
    ld b, a

.loop:
    call GameMode4_Init_LoadBattleSlots_LoadSlot
    inc c
    dec b
    jr nz, .loop
    ld a, [wBattleFoeCount]
    ld b, a
    ld c, $04
    ld a, [wLinkRole]
    bit 1, a
    jr z, .loop2
    ld a, [wBattlePartyCount]
    ld b, a

.loop2:
    call GameMode4_Init_LoadBattleSlots_LoadSlot
    inc c
    dec b
    jr nz, .loop2
    call AdjustSkillsForBattleStart
    ld de, wSlotBodyFlags
    ld bc, $0800

.loop3:
    push bc
    ld a, c
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    cp $ff
    jr z, .restore
    ld a, c
    add a
    ld hl, wBattleMonsterId
    add_a_to_hl
    ld a, [hli]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    push de
    farcall LoadSpeciesRecord
    pop de
    ld a, [wSpeciesRecord + SPECIES_METAL]
    ld h, a
    ld a, [wSpeciesRecord + SPECIES_UNTRIPPABLE]
    swap a
    or h
    ld [de], a

.restore:
    pop bc
    inc de
    inc c
    dec b
    jr nz, .loop3
    ret

SECTION "Bank 19 SetSlotAIModeFromINT", ROMX

; C = battle slot: wSlotAIMode[C] = 0, 1, 2, 3 or 4 by the INT word of the slot in wBattleINT, below
; 30, 100, 550, 900, or more. BC is kept. (C2, E-0378)
; wSlotAIMode[C] = 0-4 by slot C's INT: below 30, 100, 550, 900, or more (E-0127)
SetSlotAIModeFromINT::
    push bc
    ld a, c
    ld hl, wSlotAIMode
    add_a_to_hl
    push hl
    ld a, c
    ld hl, wBattleINT
    add a
    add_a_to_hl
    deref_hl
    ld a, l
    sub $1e
    ld l, a
    ld a, h
    sbc $00
    ld h, a
    jr c, .skip4
    ld a, l
    sub $46
    ld l, a
    ld a, h
    sbc $00
    ld h, a
    jr c, .skip3
    ld a, l
    sub $c2
    ld l, a
    ld a, h
    sbc $01
    ld h, a
    jr c, .skip2
    ld a, l
    sub $5e
    ld l, a
    ld a, h
    sbc $01
    ld h, a
    jr c, .skip
    ld a, $04
    jr .restore

.skip:
    ld a, $03
    jr .restore

.skip2:
    ld a, $02
    jr .restore

.skip3:
    ld a, $01
    jr .restore

.skip4:
    ld a, $00

.restore:
    pop hl
    ld [hl], a
    pop bc
    ret

SECTION "Bank 19 ClearSpeciesRecordBuffer_Bank19", ROMX

; Zero-fills the 47 bytes of wSpeciesRecord, where LoadSpeciesRecord writes. BC and HL are kept.
; (C2, E-0378)
; zero-fills the 47 bytes of wSpeciesRecord, where LoadSpeciesRecord writes; BC, HL kept (E-0067)
; (the same 15 bytes appear in 2 banks)
ClearSpeciesRecordBuffer_Bank19::
    push bc
    push hl
    ld hl, wSpeciesRecord
    ld bc, $002f
    xor a
    call FillBytes
    pop hl
    pop bc
    ret

SECTION "Bank 19 RandomizeWordBetween80And100Percent", ROMX

; HL = pointer to a word. Unless wBattleKind is 2, 3 or 5 or wLinkMode is non-zero, the word is
; replaced in place by 80 to 100 percent of itself: 80 percent (ScaleHLToEightTenths_Bank19) plus a
; table random value (NextTableByte) modulo the remaining 20 percent, found by repeated subtraction.
; BC is kept; other registers are not. (C2, E-0378)
; outside link and special battles stores a random value between 80 and 100 percent of the word at
; HL into BC's target (E-0127)
RandomizeWordBetween80And100Percent::
    ld a, [wBattleKind]
    cp $02
    ret z
    cp $03
    ret z
    cp $05
    ret z
    ld a, [wLinkMode]
    or a
    ret nz
    push bc
    push hl
    ld a, [hli]
    ld h, [hl]
    ld b, h
    ld l, a
    ld c, a
    call ScaleHLToEightTenths_Bank19
    ld a, c
    sub l
    ld c, a
    ld a, b
    sbc h
    ld b, a
    push hl
    push af
    push bc
    push de
    push hl
    call NextTableByte
    pop hl
    pop de
    pop bc
    pop af
    ld a, [wRandomLo]
    ld l, a
    ld a, [wRandomHi]
    ld h, a

.call_compare_hl_to_bc:
    call CompareHLToBC
    jr c, .restore
    ld a, l
    sub c
    ld l, a
    ld a, h
    sbc b
    ld h, a
    jr .call_compare_hl_to_bc

.restore:
    pop bc
    add hl, bc
    pop bc
    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    pop bc
    ret

SECTION "Bank 19 LoadSlotSkillsForBattleArg0", ROMX

; Entry for far callers: C = wBattleArg0 (the battle slot), then falls into
; LoadSlotSkillsFromBattlerRecord, which refills that slot's 8 entries of wBattleSkills from its
; 78-byte battler record and loads each skill's record part. Called from bank $19 (twice) and by
; farcall from bank $A0. (C2, E-0372; probed E-0378)
; C = wBattleArg0, then falls into LoadSlotSkillsFromBattlerRecord (E-0126)
LoadSlotSkillsForBattleArg0::
    ld a, [wBattleArg0]
    ld c, a

; C = battle slot. Clears the 8 (prefix, skill) pairs of the slot in
; wBattleSkillsPrefix/wBattleSkills to (0, $FF), then copies the skills from its 78-byte battler
; record (record C below 4, else C - 1; the field at BATTLER_SKILLS) up to 8, stopping before the
; first $00 or $FF after the first one. For each skill it stores the high nibble of byte 3 of the
; skill record (LoadSkillRecordPart) in the prefix byte before it. When wBattleArg0 is non-zero it
; finally runs AdjustSkillsForBattleStart; wBattleArg0 is restored. (C2, E-0378)
; for slot C clears its skill list and copies the skills from its 78-byte battler record, then loads
; each skill record (with wBattleArg0 = 3) (E-0130)
LoadSlotSkillsFromBattlerRecord::
    ld hl, wBattleSkillsPrefix
    ld a, c
    swap a
    add_a_to_hl
    ld b, $08

.loop:
    ld a, $00
    ld [hli], a
    ld a, $ff
    ld [hli], a
    dec b
    jr nz, .loop
    push bc
    ld a, c
    cp $04
    jr c, .call_multiply8
    dec a
    ld c, a

.call_multiply8:
    ld a, $4e
    call Multiply8
    pop bc
    ld a, l
    add $e3
    ld l, a
    ld a, h
    adc $d0
    ld h, a
    ld de, wBattleSkills
    ld a, c
    swap a
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld b, $08

.loop2:
    ld a, [hli]
    ld [de], a
    inc de
    inc de
    ld a, [hl]
    or a
    jr z, .skip2
    cp $ff
    jr z, .skip2
    dec b
    jr nz, .loop2

.skip2:
    ld a, c
    ld de, wBattleSkills
    swap a
    add e
    ld e, a
    jr nc, .read_battle_arg0
    inc d

.read_battle_arg0:
    ld b, $08
    ld a, [wBattleArg0]
    push af
    xor a
    ld [wRecordBuffer + $1], a

.loop3:
    ld a, [de]
    cp $ff
    jr z, .set_battle_arg0
    push bc
    ld a, [de]
    ld [wRecordBuffer], a
    ld a, $03
    ld [wBattleArg0], a
    ld a, $01
    ld [wBattleArg1], a
    dec de
    push de
    ld a, e
    ld [wBattleArg2], a
    ld a, d
    ld [wBattleArg3], a
    farcall LoadSkillRecordPart
    ld a, [wBattleArg2]
    ld e, a
    ld a, [wBattleArg3]
    ld d, a
    ld a, [de]
    swap a
    and $0f
    ld [de], a
    pop de
    inc de
    inc de
    inc de
    pop bc
    dec b
    jr nz, .loop3

.set_battle_arg0:
    pop af
    ld [wBattleArg0], a
    or a
    call nz, AdjustSkillsForBattleStart
    ret

SECTION "Bank 19 AdjustSkillsForBattleStart", ROMX

; For each of the 8 slots whose wBattleSlotOut is 0 and whose wSlotNameSuffix is 0, the first skill
; $8F in its list becomes $AA (ReplaceSkill8FWithAAInSlotC). Outside link battles, in the foe slots
; 4-6 that are present, the first four skills $34 and $35 are replaced by the tiles $AD and $AE (a
; list ends at $FF). (C2, E-0378)
; replaces skill $8F by $AA for slots without wSlotNameSuffix set; outside link battles marks skills
; $34 and $35 of the foe slots with tiles $AD and $AE (E-0127)
AdjustSkillsForBattleStart::
    ld bc, $0800
    ld hl, wSlotNameSuffix

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, [hl]
    or a
    call z, ReplaceSkill8FWithAAInSlotC

.next:
    inc c
    inc hl
    dec b
    jr nz, .loop
    ld a, [wLinkMode]
    or a
    ret nz
    ld bc, $0304
    ld hl, wBattleSkills + $40

.loop2:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next3
    ld d, $04

.loop3:
    ld a, [hl]
    cp $ff
    jr z, .next3
    cp $34
    jr nz, .cp_35
    call StoreTileADAtHL
    jr .next2

.cp_35:
    cp $35
    jr nz, .next2
    call StoreTileAEAtHL

.next2:
    inc hl
    inc hl
    dec d
    jr nz, .loop3

.next3:
    inc c
    ld a, c
    swap a
    ld hl, wBattleSkills
    add_a_to_hl
    dec b
    jr nz, .loop2
    ret

SECTION "Bank 19 ReplaceSkill8FWithAAInSlotC", ROMX

; C = battle slot: in its skill list (8 entries, 2 bytes apart in wBattleSkills) the first skill $8F
; becomes $AA; the scan stops at the first $FF. HL is kept. (C2, E-0378)
; in slot C's skill list replaces the first skill $8F by $AA, stopping at $FF (E-0124)
ReplaceSkill8FWithAAInSlotC::
    push hl
    ld a, c
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld d, $08

.loop:
    ld a, [hl]
    cp $ff
    jr z, .done
    cp $8f
    jr nz, .next
    ld [hl], $aa

.done:
    pop hl
    ret

.next:
    inc hl
    inc hl
    dec d
    jr nz, .loop
    pop hl
    ret

SECTION "Bank 19 StoreTileADAtHL", ROMX

; Stores the byte $AD at [HL] (a tile id); HL and every register are kept. (C2, E-0378)
; [HL] = $AD (E-0114)
StoreTileADAtHL::
    ld [hl], $ad
    ret

SECTION "Bank 19 StoreTileAEAtHL", ROMX

; Stores the byte $AE at [HL] (a tile id); HL and every register are kept. (C2, E-0378)
; [HL] = $AE (E-0114)
StoreTileAEAtHL::
    ld [hl], $ae
    ret

SECTION "Bank 19 InitSlotOutAndStatusFromRecordFlags", ROMX

; C = battle slot, HL = a record status byte: with bit 7 set, wBattleSlotOut[C] = 1 and nothing
; more. Otherwise wBattleSlotOut[C] = 0 and, unless wBattleKind is 4, bit 0 of the flags stores $20
; in the first byte of the slot status record (wBattleStatus, 9 bytes per slot, replacing it) and
; bit 2 then sets bit 0 of that byte. HL is kept. (C2, E-0378)
; slot C: wBattleSlotOut = 1 when bit 7 of [HL] is set; otherwise 0 and, unless wBattleKind = 4, the
; status byte gets $20 for bit 0 and bit 0 for bit 2 (E-0125)
InitSlotOutAndStatusFromRecordFlags::
    push hl
    ld a, c
    ld de, wBattleSlotOut
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    bit 7, [hl]
    jr z, .check_battle_kind
    ld a, $01
    ld [de], a
    jr .done

.check_battle_kind:
    ld a, $00
    ld [de], a
    ld a, [wBattleKind]
    cp $04
    jr z, .done
    ld a, c
    ld de, wBattleStatus
    add a
    add a
    add a
    add c
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    bit 0, [hl]
    jr z, .skip3
    ld a, $20
    ld [de], a

.skip3:
    bit 2, [hl]
    jr z, .done
    ld a, [de]
    or $01
    ld [de], a

.done:
    pop hl
    ret

SECTION "Bank 19 StoreByteAtDEPlusC_Bank19", ROMX

; DE += C, then copies the byte at HL to [DE] and HL += 1. (C2, E-0378)
; DE += C; copies the byte at HL to [DE]; HL += 1 (the same 9 bytes appear in 2 banks)
StoreByteAtDEPlusC_Bank19::
    ld a, c
    add e
    ld e, a
    jr nc, .done
    inc d

.done:
    ld a, [hli]
    ld [de], a
    ret

SECTION "Bank 19 StoreWordAtDEPlus2C_Bank19", ROMX

; DE += 2 x C, then copies the word at HL to [DE] and [DE + 1] and HL += 2; DE ends on the second
; byte written. (C2, E-0378)
; DE += 2 * C; copies the word at HL to [DE]; HL += 2, DE ends on the second byte written (the same
; 13 bytes appear in 2 banks)
StoreWordAtDEPlus2C_Bank19::
    ld a, c
    add a
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    ret

SECTION "Bank 19 PackResistancesFromBattleArgs", ROMX

; Entry for far callers: HL = the word wBattleArg0/wBattleArg1 (source fields), DE = the word
; wBattleArg2/wBattleArg3 (destination), then falls into PackResistanceFieldsToDE, which packs the
; 2-bit fields at HL into the 7-byte record at DE. Far-called from banks $32, $36 and $A0. (C2,
; E-0372; probed E-0378)
; HL = the word wBattleArg0, DE = the word wBattleArg2, then falls into PackResistanceFieldsToDE
; (E-0126)
PackResistancesFromBattleArgs::
    ld a, [wBattleArg0]
    ld l, a
    ld a, [wBattleArg1]
    ld h, a
    ld a, [wBattleArg2]
    ld e, a
    ld a, [wBattleArg3]
    ld d, a

; HL = 27 resistance fields of 2 bits, one per byte, DE = destination: packs them into 7 bytes. Byte
; 0 holds field 26 in bits 7-6 and fields 0-2 in bits 5-0, bytes 1-5 hold fields 3-22 four to a byte
; (the first in bits 7-6), byte 6 holds fields 23-25 in bits 7-2. (C2, E-0378)
; packs the 2-bit fields at HL (and bits 0-1 of byte $1A) into the 7-byte wSlotResistances-style
; record at DE (E-0127)
PackResistanceFieldsToDE::
    push hl
    ld a, $1a
    add_a_to_hl
    ld a, [hl]
    and $03
    rrc a
    rrc a
    ld c, a
    pop hl
    ld a, [hli]
    sla a
    sla a
    or [hl]
    inc hl
    sla a
    sla a
    or [hl]
    inc hl
    or c
    ld [de], a
    inc de
    ld b, $05

.loop:
    ld a, [hli]
    sla a
    sla a
    or [hl]
    inc hl
    sla a
    sla a
    or [hl]
    inc hl
    sla a
    sla a
    or [hl]
    inc hl
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld a, [hli]
    sla a
    sla a
    or [hl]
    inc hl
    sla a
    sla a
    or [hl]
    sla a
    sla a
    ld [de], a
    ret

SECTION "Bank 19 CopyScreenTileBufferToVRAM_A0_Bank19", ROMX

; HL = VRAM address: copies the 20 x 18 tiles of wScreenTileBuffer (rows 32 bytes apart in the
; buffer) to the VRAM rectangle at HL with rows 32 bytes apart, using WriteVRAMByteInc. (C1, E-0378)
; the same 33 bytes as CopyScreenTileBufferToVRAM_A0 (CopyScreenTileBufferToVRAM_A0) (E-0124)
CopyScreenTileBufferToVRAM_A0_Bank19::
    ld de, wScreenTileBuffer
    ld bc, $1412

.loop:
    push bc
    push hl

.loop2:
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, .loop2
    ld a, $0c
    add e
    ld e, a
    jr nc, .restore
    inc d

.restore:
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, .loop
    ret

SECTION "Bank 19 ScaleHLToEightTenths_Bank19", ROMX

; HL = HL x 8 / 10, the multiply done in 16 bits so it wraps above 8191 (8192 gives 0). BC and DE
; are kept. (C2, E-0378)
; HL = (HL * 8) / 10 with 16-bit arithmetic (the multiply can overflow above 8191); BC and DE kept
; (E-0118)
ScaleHLToEightTenths_Bank19::
    push bc
    push de
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, $0a
    call DivideHLByA
    pop de
    pop bc
    ret

SECTION "Bank 19 GameMode4_Init_PlayBattleMusic", ROMX

; Battle music: $0F for battle kinds 0 and 1, otherwise $13. (C2, E-0357; probed E-0378)
GameMode4_Init_PlayBattleMusic::
    ld a, [wBattleKind]
    or a
    jr z, .skip
    dec a
    jr nz, .call_queue_music

.skip:
    ld a, $0f
    jr .call_queue_music2

.call_queue_music:
    ld a, $13

.call_queue_music2:
    call QueueMusic
    ret

SECTION "Bank 19 GameMode4_Init_CopyPartyToBattlers", ROMX

; With SRAM enabled by the caller, copies each of the wBattlePartyCount party members' SRAM records
; into consecutive $4E-byte battler records from wBattlerRecords
; (GameMode4_Init_CopyPartyToBattlers_Member). (C2, E-0370; probed E-0378)
GameMode4_Init_CopyPartyToBattlers::
    ld a, [wBattlePartyCount]
    ld b, a
    ld c, $00
    ld de, wBattlerRecords

.loop:
    push bc
    call GameMode4_Init_CopyPartyToBattlers_Member
    pop bc
    inc c
    dec b
    jr nz, .loop
    ret

SECTION "Bank 19 GameMode4_Init_CopyPartyToBattlers_Member", ROMX

; Copies party member C's SRAM record (SRAMRecordAddressMapped) into the battler record at DE in
; battler order: MON_NAME, MON_SPECIES, MON_FAMILY, MON_SEX, MON_SKILLS, MON_STATUS, MON_LEVEL,
; MON_EXP through MON_WLD, MON_PERSONALITY, MON_RESISTANCES and MON_ITEM; for an item value $0D-$13
; (the capes) it then raises listed BATTLER_RESISTANCES bytes by one, up to 3
; (ApplyIncrementOffsetRows19ForA0DTo13), and the last byte (BATTLER_JOIN_CLASS) is $FF. DE ends
; past the record. (C2, E-0370; probed E-0378)
GameMode4_Init_CopyPartyToBattlers_Member::
    ld a, c
    ld c, MON_NAME
    call SRAMRecordAddressMapped
    ld b, $0a

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [hli]
    ld [de], a
    inc de
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [hli]
    ld [de], a
    inc de
    ld a, l
    add $25
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld b, $08

.loop2:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop2
    ld a, l
    add $19
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [hli]
    ld [de], a
    inc de
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [hli]
    ld [de], a
    inc de
    ld a, l
    add $01
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld b, $15

.loop3:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop3
    ld a, l
    add $02
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld b, $04

.loop4:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop4
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld b, $1b

.loop5:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop5
    ld a, l
    add $16
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [hl]
    ld [de], a
    call ApplyIncrementOffsetRows19ForA0DTo13
    inc de
    ld a, $ff
    ld [de], a
    inc de
    ret

SECTION "Bank 19 ApplyIncrementOffsetRows19ForA0DTo13", ROMX

; A = a MON_ITEM value copied into a battler record, DE = the address of that item byte (the byte
; just after the 27 BATTLER_RESISTANCES bytes). Returns at once, changing nothing, when A is 0 or
; outside $0D-$13. Otherwise it reads row A - $0D of IncrementOffsetRows_19, a list of offsets ended
; by $80, and for each offset adds one to the byte at DE + $FF00 + offset (that is DE minus up to
; 27, one of the resistance bytes) unless that byte is already 3 or more. DE is restored and AF and
; HL are changed. Only GameMode4_Init_CopyPartyToBattlers_Member calls it. (C2, E-0379)
; for A in $0D-$13 increments (capped at 3) each byte listed in IncrementOffsetRows_19 row A - $0D,
; relative to DE (E-0125)
ApplyIncrementOffsetRows19ForA0DTo13::
    or a
    ret z
    cp $0d
    ret c
    cp $14
    ret nc
    push af
    ld a, e
    ldh [hTemp0], a
    ld a, d
    ldh [hTemp1], a
    pop af
    push de
    sub $0d
    swap a
    ld de, IncrementOffsetRows_19
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    cp $80
    jr nz, .call_increment_table_byte_capped_at3
    pop de
    ret

.call_increment_table_byte_capped_at3:
    ld l, a
    ld h, $ff
    call IncrementTableByteCappedAt3
    inc de
    jr .skip

SECTION "Bank 19 IncrementTableByteCappedAt3", ROMX

; HL = a 16-bit offset, hTemp0/hTemp1 = a base address (low, high). Adds the two to make the
; address, leaves it in HL, and adds one to the byte there unless it is already 3 or more. Carry is
; clear when the byte was 3 or more and left alone. Only ApplyIncrementOffsetRows19ForA0DTo13 calls
; it, once for each offset of a row. (C2, E-0379)
; increments the byte at HL + the word hTemp0/hTemp1 unless it is already 3 or more (E-0118)
IncrementTableByteCappedAt3::
    ldh a, [hTemp0]
    add l
    ld l, a
    ldh a, [hTemp1]
    adc h
    ld h, a
    ld a, [hl]
    cp $03
    ret nc
    inc a
    ld [hl], a
    ret

SECTION "Bank 19 IncrementOffsetRows_19", ROMX

; ApplyIncrementOffsetRows19ForA0DTo13 takes A in $0D-$13, reads row 16 * (A - $0D) and for each
; byte before $80 increments the byte at DE + $FF00 + byte, capped at 3
; (IncrementTableByteCappedAt3); 7 rows; the bank $19 and $A0 copies are identical (E-0236, C1)
; record: offsets ($FF00 + byte, added to the base in DE) of the bytes to increment, up to $80, then
; zero padding
IncrementOffsetRows_19::
    db $e5, $e6, $e7, $e8, $e9, $ea, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 13
    db $f5, $f6, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 14
    db $ec, $f0, $f7, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 15
    db $ec, $f0, $f7, $f8, $f9, $eb, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 16
    db $ec, $f0, $f7, $f8, $f9, $ed, $f3, $eb, $ef, $80, $00, $00, $00, $00, $00, $00 ; id 17
    db $ff, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 18
    db $fa, $fb, $fc, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 19

; Reloads the battler record of foe slot 4 (wDisplaySlot 4) or 5 (wDisplaySlot 5) from its
; wEncounterMonsters entry (LoadMonsterAndSpeciesForListEntryC with C = 0 or 1), keeping the
; record's byte $0D (after BATTLER_FAMILY, copied from MON_SEX). BattleEnd_Records_ReplaceSpecialFoe
; reaches it through BattleEnd_Records_ReplaceSpecialFoe_SetMonster after writing the next form's
; monster id into that entry. (C2, E-0370; probed E-0379)
BattleEnd_Records_ReloadFoeBattler::
    ld de, wBattlerRecordSlot5
    ld a, [wDisplaySlot]
    and $03
    ld c, a
    cp $01
    jr z, .skip
    ld de, wBattlerRecordSlot4

.skip:
    push de
    ld a, e
    add $0d
    ld e, a
    ld a, d
    adc $00
    ld d, a
    ld a, [de]
    pop de
    push af
    push de
    call LoadMonsterAndSpeciesForListEntryC
    pop de
    ld a, e
    add $0d
    ld e, a
    ld a, d
    adc $00
    ld d, a
    pop af
    ld [de], a
    ret

SECTION "Bank 19 GameMode4_Init_LoadFoes", ROMX

; Loads the foes: in battle kind 5 or an even kind from their monster records
; (LoadMonsterAndSpeciesForListEntryC); in odd kinds other than 5 builds each from its species
; (GameMode4_Init_BuildFoeRecord), $4E bytes apart. (C2, E-0357; probed E-0379)
GameMode4_Init_LoadFoes::
    ld a, [wBattleFoeCount]
    ld b, a
    ld c, $00
    ld de, wBattlerRecordSlot4
    ld a, [wBattleKind]
    cp $05
    jr z, .loop
    and $01
    jr z, .loop
    jr .loop2

.loop:
    push bc
    call LoadMonsterAndSpeciesForListEntryC
    pop bc
    inc c
    dec b
    jr nz, .loop
    ret

.loop2:
    push bc
    call GameMode4_Init_BuildFoeRecord
    pop bc
    inc c
    ld a, e
    add $4e
    ld e, a
    ld a, d
    adc $00
    ld d, a
    dec b
    jr nz, .loop2
    ret

SECTION "Bank 19 LoadMonsterAndSpeciesForListEntryC", ROMX

; C = index 0-2 into wEncounterMonsters (monster ids, words), DE = the battler record to fill. Reads
; the 26-byte monster record of that id (LoadMonsterRecord), writes it into the battler record with
; FillBattlerRecordFromMonster, loads the species record named by the first word of the monster
; record (LoadSpeciesRecord), and finishes with SetBattlerFamilyAndSex, which adds the family, the
; sex roll and the 27 resistances. SetBattlerFamilyAndSex ends with a pop bc that discards the
; return address, so this routine never reaches its own last pop bc and ret: it returns straight to
; its caller with BC = $4750 and DE = the start of the next battler record ($4E bytes on). Callers:
; GameMode4_Init_LoadFoes and BattleEnd_Records_ReloadFoeBattler. (C2, E-0379)
; loads monster wEncounterMonsters[C] (LoadMonsterRecord), runs FillBattlerRecordFromMonster, loads
; the species named in wRecordBuffer, then runs SetBattlerFamilyAndSex (E-0121)
LoadMonsterAndSpeciesForListEntryC::
    push bc
    ld a, c
    ld hl, wEncounterMonsters
    add a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wMonsterId + $1], a
    push de
    farcall LoadMonsterRecord
    pop de
    pop bc
    push de
    call FillBattlerRecordFromMonster
    pop de
    ld a, [wRecordBuffer]
    ld l, a
    ld a, [wRecordBuffer + $1]
    ld h, a
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    push bc
    push de
    farcall LoadSpeciesRecord
    pop de
    pop bc
    call SetBattlerFamilyAndSex
    pop bc
    ret

SECTION "Bank 19 GameMode4_Init_BuildFoeRecord", ROMX

; Builds foe C's battler record from its species (wEncounterMonsters): species, family, sex ratio
; and three skills, level wWildLevel[C] (at least 1), experience, and the stats from the species'
; growth rows scaled by the battle kind (ScaleStatAndCapByBattleKind). (C2, E-0357; probed E-0379)
GameMode4_Init_BuildFoeRecord::
    push bc
    ld a, e
    ld [wBattleArg2], a
    ld a, d
    ld [wBattleArg3], a
    ld a, c
    ld [wBattleArg1], a
    ld hl, wWildLevel
    add_a_to_hl
    ld a, [hl]
    ldh [hTemp1], a
    or a
    jr nz, .skip
    ld a, $01
    ldh [hTemp1], a

.skip:
    ld a, c
    add a
    ld hl, wEncounterMonsters
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wBattleArg2]
    add $0a
    ld l, a
    ld a, [wBattleArg3]
    adc $00
    ld h, a
    ld a, [wSpeciesIdLo]
    ld [hli], a
    ld a, [wSpeciesIdHi]
    ld [hli], a
    ld a, [wSpeciesRecord]
    ld [hli], a
    ld a, [wSpeciesRecord + SPECIES_SEX_RATIO]
    ld [hli], a
    ld a, [wSpeciesRecord + SPECIES_SKILLS]
    ld [hli], a
    ld a, [wSpeciesRecord + SPECIES_SKILLS + 1]
    ld [hli], a
    ld a, [wSpeciesRecord + SPECIES_SKILLS + 2]
    ld [hli], a
    ld a, $ff
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld a, $00
    ld [hli], a
    ldh a, [hTemp1]
    ld [hli], a
    ld a, [wSpeciesRecord + SPECIES_EXP]
    ld [hli], a
    ld a, [wSpeciesRecord + SPECIES_EXP + 1]
    ld [hli], a
    ld a, $00
    ld [hli], a
    push hl
    ld a, [wSpeciesRecord + SPECIES_GROWTH]
    ldh [hTemp0], a
    farcall StatFromGrowthRow
    pop hl
    ld a, $01
    ld [wBattleArg0], a
    call ScaleStatAndCapByBattleKind
    call StoreTemp2WordAtHL_Bank19
    ld a, [wSpeciesRecord + SPECIES_GROWTH + 1]
    ldh [hTemp0], a
    push hl
    farcall StatFromGrowthRow
    pop hl
    ld a, $00
    ld [wBattleArg0], a
    call ScaleStatAndCapByBattleKind
    call StoreTemp2WordAtHL_Bank19
    ld a, $02
    ld [wBattleArg0], a
    ld a, [wSpeciesRecord + SPECIES_GROWTH + 2]
    ldh [hTemp0], a
    push hl
    farcall StatFromGrowthRow
    pop hl
    call ScaleStatAndCapByBattleKind
    ld a, $03
    ld [wBattleArg0], a
    ld a, [wSpeciesRecord + SPECIES_GROWTH + 3]
    ldh [hTemp0], a
    push hl
    farcall StatFromGrowthRow
    pop hl
    call ScaleStatAndCapByBattleKind
    ld a, $00
    ld [wBattleArg0], a
    ld a, [wSpeciesRecord + SPECIES_GROWTH + 4]
    ldh [hTemp0], a
    push hl
    farcall StatFromGrowthRow
    pop hl
    call ScaleStatAndCapByBattleKind
    ld a, [wSpeciesRecord + SPECIES_GROWTH + 5]
    ldh [hTemp0], a
    push hl
    farcall StatFromGrowthRow
    pop hl
    call ScaleStatAndCapByBattleKind
    ld a, $e7
    ld [hli], a
    ld a, $03
    ld [hli], a
    call StoreRandom80ToFFAtHL
    call StoreRandomByteAtHL_Bank19
    call StoreRandomByteAtHL_Bank19
    call StoreRandomByteAtHL_Bank19
    call CopySpeciesExpCurveBRecordToHL_Bank19
    ld a, $00
    ld [hli], a
    push hl
    ld a, [wSpeciesIdLo]
    ld l, a
    ld a, [wSpeciesIdHi]
    ld h, a
    ld a, l
    add LOW(SpeciesNewRecordByteTable)
    ld l, a
    ld a, h
    adc HIGH(SpeciesNewRecordByteTable)
    ld h, a
    ld a, [hl]
    pop hl
    ld [hli], a
    call RollRecordField0DState
    call AccumulateGrowthForLevelsTemp1
    farcall CheckSkillsLearnableAtLevel
    ld a, [wBattleArg2]
    ld e, a
    ld a, [wBattleArg3]
    ld d, a
    pop bc
    ret

SECTION "Bank 19 StoreRandomByteAtHL_Bank19", ROMX

; HL = where to store. Steps the table random number once (NextTableByte, so wRandomHi goes up by
; one and wRandomLo changes), stores wRandomLo at [HL] and adds 1 to HL. A = the byte stored; BC and
; DE are kept. GameMode4_Init_BuildFoeRecord calls it three times to fill three personality bytes of
; a new foe record. (C2, E-0379)
; advances the random table (NextTableByte) and stores the new wRandomLo at HL; HL += 1; AF, BC, DE
; kept apart from A = the byte (E-0067) (the same 16 bytes appear in 2 banks)
StoreRandomByteAtHL_Bank19::
    push af
    push bc
    push de
    push hl
    call NextTableByte
    pop hl
    pop de
    pop bc
    pop af
    ld a, [wRandomLo]
    ld [hli], a
    ret

SECTION "Bank 19 StoreRandom80ToFFAtHL", ROMX

; HL = where to store. Steps the table random number once (NextTableByte), stores (wRandomLo AND
; $7F) + $80 at [HL], so the byte is always $80-$FF, and adds 1 to HL. A = the byte stored; BC and
; DE are kept. GameMode4_Init_BuildFoeRecord calls it once for the first personality byte of a new
; foe record. (C2, E-0379)
; NextTableByte, then stores (wRandomLo & $7F) + $80 at HL; HL += 1 (E-0118) (E-0345: was
; StoreRandom80ToFFAtHL)
StoreRandom80ToFFAtHL::
    push af
    push bc
    push de
    push hl
    call NextTableByte
    pop hl
    pop de
    pop bc
    pop af
    ld a, [wRandomLo]
    and $7f
    add $80
    ld [hli], a
    ret

SECTION "Bank 19 ScaleStatAndCapByBattleKind", ROMX

; Scales one stat of a new foe record and stores it. hTemp2/hTemp3 = the stat (a word), HL = where
; to store it, wBattleArg0 = which stat it is, wBattleKind = the kind of battle. The value is first
; made 101 percent of itself (rounded down). Special case: in battle kind 3 with wBattleArg0 = 1
; (the first growth stat, which GameMode4_Init_BuildFoeRecord stores as HP and maximum HP) the 101
; percent value is multiplied by 5 when wBattleIntroFlag or wBattleArg1 is 1, otherwise by 2, and a
; product over 65535 becomes 10000 (ScaleStatAndCapByBattleKind_ApplyMultiplier). Otherwise it is
; capped: 999, except wBattleArg0 = 2 gives 600 (700 in battle kind 3) and wBattleArg0 = 3 gives 700
; (999 in battle kind 3 when SPECIES_METAL of wSpeciesRecord is not 0). The word is written at [HL]
; and again in hTemp2/hTemp3, HL goes up by 2 and A ends as its high byte; BC and DE are kept. The
; cap test is a 16-bit signed difference, so a value more than 32767 above its cap would not be
; capped. (C2, E-0379)
; scales the word hTemp2 by 101 percent and caps it at 999, 600 or 700 depending on wBattleArg0 and
; the battle kind wBattleKind, then stores it (E-0128)
ScaleStatAndCapByBattleKind::
    push af
    push bc
    push de
    push hl
    ldh a, [hTemp2]
    ld c, a
    ldh a, [hTemp3]
    ld b, a
    ld a, $01
    add $64
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    ld a, [wBattleKind]
    cp $03
    jr nz, .check_battle_arg0
    ld a, [wBattleArg0]
    cp $01
    jr nz, .check_battle_arg0
    ld a, [wBattleIntroFlag]
    cp $01
    ld a, $05
    jr z, ScaleStatAndCapByBattleKind_ApplyMultiplier
    ld a, [wBattleArg1]
    cp $01
    ld a, $02
    jr nz, ScaleStatAndCapByBattleKind_ApplyMultiplier
    ld a, $05
    jr ScaleStatAndCapByBattleKind_ApplyMultiplier

.check_battle_arg0:
    ld a, [wBattleArg0]
    cp $02
    jr z, .check_battle_kind
    cp $03
    jr z, .check_battle_kind2
    ld bc, $03e7
    jr .skip2

.check_battle_kind:
    ld a, [wBattleKind]
    cp $03
    jr z, .skip
    ld bc, $0258
    jr .skip2

.skip:
    ld bc, $02bc
    jr .skip2

.check_battle_kind2:
    ld bc, $02bc
    ld a, [wBattleKind]
    cp $03
    jr nz, .skip2
    ld a, [wSpeciesRecord + SPECIES_METAL]
    or a
    jr z, .skip2
    ld bc, $03e7

.skip2:
    ld a, e
    or a
    jr nz, ScaleStatAndCapByBattleKind_UseCap
    push bc
    ld a, c
    sub l
    ld c, a
    ld a, b
    sbc h
    ld b, a
    bit 7, b
    jr nz, ScaleStatAndCapByBattleKind_UseCap
    pop bc
    jr ScaleStatAndCapByBattleKind_Store

SECTION "Bank 19 ScaleWordBy6Or12_OverflowToTenThousand", ROMX

; No caller was found. It sets A to 6, or to 12 when wBattleArg1 is 1, and falls into
; ScaleStatAndCapByBattleKind_ApplyMultiplier, so it expects the state of that branch: E:H:L = a
; 24-bit value and the caller AF, BC, DE and HL pushed on the stack. The product A * E:H:L is a word
; that ScaleStatAndCapByBattleKind_Store writes at [HL] (the HL popped from the stack), after
; popping the four registers, and HL goes up by 2. A product above 65535 becomes 10000; a smaller
; product, even above 10000, is stored as it is, so the cap in the old name is wrong. (C2, E-0379)
; multiplies by 6 (or 12 when wBattleArg1 = 1) and caps the result at 10000, then stores the word at
; [HL+] (E-0127)
ScaleWordBy6Or12_OverflowToTenThousand::
    ld a, [wBattleArg1]
    cp $01
    ld a, $06
    jr nz, ScaleStatAndCapByBattleKind_ApplyMultiplier
    ld a, $0c

; A = multiplier, E:H:L = value: multiplies (Multiply24By8); a product above 65,535 becomes HL =
; 10,000; then stores HL (ScaleStatAndCapByBattleKind_Store). ScaleStatAndCapByBattleKind jumps here
; in battle kind 3 for wBattleArg0 = 1 (the first growth stat, stored as HP and max HP) with A = 5
; when wBattleIntroFlag or wBattleArg1 is 1, else 2; ScaleWordBy6Or12_OverflowToTenThousand falls in
; with A = 6 or 12. (C2, E-0370; probed E-0379)
ScaleStatAndCapByBattleKind_ApplyMultiplier::
    call Multiply24By8
    ld a, d
    or e
    jr z, ScaleStatAndCapByBattleKind_Store
    ld hl, $2710
    jr ScaleStatAndCapByBattleKind_Store

SECTION "Bank 19 ScaleStatAndCapByBattleKind_UseCap", ROMX

; Pops BC into HL: from the cap test of ScaleStatAndCapByBattleKind this is the cap it pushed (the
; 101% value was above it), so the stat becomes the cap; then stores it
; (ScaleStatAndCapByBattleKind_Store). The other jump here, taken when the 101% value does not fit
; in 16 bits (E non-zero), has pushed nothing, so it would pop the caller's saved HL instead and
; unbalance the stack. (C2, E-0370; probed E-0379)
ScaleStatAndCapByBattleKind_UseCap::
    pop bc
    ld l, c
    ld h, b

; Stores HL in hTemp2/hTemp3, pops the HL, DE, BC and AF that ScaleStatAndCapByBattleKind pushed,
; then writes the word to [HL] and advances HL by 2. (C2, E-0370; probed E-0379)
ScaleStatAndCapByBattleKind_Store::
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    pop hl
    pop de
    pop bc
    pop af
    ldh a, [hTemp2]
    ld [hli], a
    ldh a, [hTemp3]
    ld [hli], a
    ret

SECTION "Bank 19 StoreTemp2WordAtHL_Bank19", ROMX

; HL = destination. Stores hTemp2 then hTemp3 (a word, low byte first) at [HL], adds 2 to HL; A ends
; as hTemp3. GameMode4_Init_BuildFoeRecord uses it right after ScaleStatAndCapByBattleKind to store
; the same scaled value a second time, as the maximum HP and maximum MP next to the current ones.
; (C2, E-0379)
; stores hTemp2 then hTemp3 at HL; HL += 2; clobbers A (E-0065) (the same 7 bytes appear in 2 banks)
StoreTemp2WordAtHL_Bank19::
    ldh a, [hTemp2]
    ld [hli], a
    ldh a, [hTemp3]
    ld [hli], a
    ret

SECTION "Bank 19 CopySpeciesExpCurveBRecordToHL_Bank19", ROMX

; HL = destination. Copies the 27 bytes of wSpeciesRecord + SPECIES_RESISTANCES (the species
; resistance levels) to [HL]; HL ends 27 bytes on, DE ends just past the source, B = 0 and A = the
; last byte copied. GameMode4_Init_BuildFoeRecord uses it to fill BATTLER_RESISTANCES of a new foe
; record. The name is the shared name of the identical copies in two banks and does not describe
; what it copies. (C2, E-0379)
; copies the 27 ($1B) bytes at wSpeciesRecord + $12 to HL; HL ends past the copy; clobbers A, B, DE
; (E-0065) (the same 12 bytes appear in 2 banks)
CopySpeciesExpCurveBRecordToHL_Bank19::
    ld de, wSpeciesRecord + SPECIES_RESISTANCES
    ld b, $1b

.loop:
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, .loop
    ret

SECTION "Bank 19 RollRecordField0DState", ROMX

; wBattleArg2/wBattleArg3 = the address of a battler record whose byte $0D holds a sex-ratio class
; from the species. 0 stays 0 without using the random number. For 1, 2 and any other value it steps
; the table random number once (NextTableByte) and the byte becomes 1 when wRandomLo is below 2
; (class 1), $80 (class 2) or $E6 (other classes), otherwise 0. Afterwards, if wNewRecordFamily is
; not 0, byte $0D is replaced by wNewRecordFamily with bit 4 cleared. Only
; GameMode4_Init_BuildFoeRecord calls it. (C2, E-0379)
; field $0D of record wBattleArg2: values 1, 2 and others roll with thresholds 2, $80 and $E6 and
; become 1 or 0; with wNewRecordFamily set bit 4 is cleared (E-0125)
RollRecordField0DState::
    ld a, [wBattleArg2]
    add $0d
    ld l, a
    ld a, [wBattleArg3]
    adc $00
    ld h, a
    ld a, [hl]
    or a
    jr z, .check_new_record_family2
    cp $01
    jr z, .skip
    cp $02
    jr z, .skip2
    ld b, $e6
    jr .skip3

.skip:
    ld b, $02
    jr .skip3

.skip2:
    ld b, $80

.skip3:
    push af
    push bc
    push de
    push hl
    call NextTableByte
    pop hl
    pop de
    pop bc
    pop af
    ld a, [wRandomLo]
    cp b
    jr c, .check_new_record_family
    xor a
    jr .check_new_record_family2

.check_new_record_family:
    ld a, $01

.check_new_record_family2:
    ld [hl], a
    ld a, [wNewRecordFamily]
    or a
    ret z
    res 4, a
    ld [hl], a
    ret

SECTION "Bank 19 AccumulateGrowthForLevelsTemp1", ROMX

; Sets the experience of a new foe record. wBattleArg2/wBattleArg3 = the record, hTemp1 = its level,
; and the word at BATTLER_EXP of the record = the species base experience
; (GameMode4_Init_BuildFoeRecord stored SPECIES_EXP there). With X the base word and L the level, it
; first builds a 24-bit sum S over c = 1 to L: outside battle kind 3 each term is c * X / 20 rounded
; down, plus the remainders added up in one byte (they wrap at 256) and divided by 20; in battle
; kind 3 each term is c * X, undivided. The result is S / 3 (rounded down), divided by 4 again by
; two arithmetic shifts in battle kind 3; a result of 0 becomes 1 and one of 65536 or more becomes
; 65535. It is stored as three bytes (low, high, 0) over BATTLER_EXP; hTemp4-hTemp6 hold the 24-bit
; result before the cap; hTemp7-hTemp9 are work bytes; DE is kept. A level of 0 would run the loop
; 256 times. (C2, E-0379)
; sums the stat word at record + $18 times each level 1..hTemp1 (with a /20 rounding term outside
; battle kind 3) into the 24-bit hTemp4-hTemp6 (E-0130)
AccumulateGrowthForLevelsTemp1::
    ld a, [wBattleArg2]
    add $18
    ld l, a
    ld a, [wBattleArg3]
    adc $00
    ld h, a
    push de
    push hl
    xor a
    ldh [hTemp4], a
    ldh [hTemp5], a
    ldh [hTemp6], a
    ldh [hTemp9], a
    deref_hl
    ld a, l
    ldh [hTemp7], a
    ld a, h
    ldh [hTemp8], a
    ldh a, [hTemp1]
    ld b, a
    ld c, $01

.loop:
    push bc
    ldh a, [hTemp7]
    ld l, a
    ldh a, [hTemp8]
    ld h, a
    ld e, $00
    ld a, c
    call Multiply24By8
    ld a, [wBattleKind]
    cp $03
    jr z, .read_temp4
    ld a, $14
    call Divide24ByA
    ld c, a
    ldh a, [hTemp9]
    add c
    ldh [hTemp9], a

.read_temp4:
    ldh a, [hTemp4]
    add l
    ldh [hTemp4], a
    ldh a, [hTemp5]
    adc h
    ldh [hTemp5], a
    ldh a, [hTemp6]
    adc e
    ldh [hTemp6], a
    pop bc
    inc c
    dec b
    jr nz, .loop
    ldh a, [hTemp9]
    ld b, a
    ld a, $14
    call DivideBByA
    ldh a, [hTemp4]
    add b
    ldh [hTemp4], a
    ldh a, [hTemp5]
    adc $00
    ldh [hTemp5], a
    ldh a, [hTemp6]
    adc $00
    ldh [hTemp6], a
    push bc
    push de
    ldh a, [hTemp6]
    ld e, a
    ldh a, [hTemp5]
    ld h, a
    ldh a, [hTemp4]
    ld l, a
    ld a, $03
    call Divide24ByA
    ld a, [wBattleKind]
    cp $03
    jr nz, .skip
    sra e
    rr h
    rr l
    sra e
    rr h
    rr l

.skip:
    ld a, e
    or h
    or l
    jr nz, .set_temp6
    ld hl, $0001

.set_temp6:
    ld a, e
    ldh [hTemp6], a
    ld a, h
    ldh [hTemp5], a
    ld a, l
    ldh [hTemp4], a
    pop de
    pop bc
    ldh a, [hTemp6]
    ld e, a
    ldh a, [hTemp5]
    ld h, a
    ldh a, [hTemp4]
    ld l, a
    ld a, d
    or e
    jr z, .restore
    ld hl, -1

.restore:
    pop bc
    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    inc bc
    ld a, $00
    ld [bc], a
    pop de
    ret

SECTION "Bank 19 Multiply24By8", ROMX

; A = the multiplier, E:H:L = a 24-bit number (E the high byte). Returns the 32-bit product D:E:H:L
; = A * E:H:L, from three 8-bit multiplies (Multiply8) added with carries. A, B and C are changed.
; ScaleStatAndCapByBattleKind_ApplyMultiplier and AccumulateGrowthForLevelsTemp1 are the callers.
; (C2, E-0379)
; DEHL = A * EHL (a 24-bit by 8-bit multiply from three Multiply8 calls) (E-0121)
Multiply24By8::
    push af
    push hl
    ld c, e
    call Multiply8
    pop bc
    pop af
    push hl
    push af
    push bc
    ld c, b
    call Multiply8
    pop bc
    pop af
    push hl
    call Multiply8
    pop bc
    ld a, c
    add h
    ld h, a
    ld a, b
    adc $00
    ld e, a
    pop bc
    ld a, c
    add e
    ld e, a
    ld a, b
    adc $00
    ld d, a
    ret

SECTION "Bank 19 FillBattlerRecordFromMonster", ROMX

; Fills a battler record at DE from the loaded monster record: $FF for the name, the monster id, and
; the record's fields in battler order. (C2, E-0357; probed E-0379)
FillBattlerRecordFromMonster::
    push bc
    ld b, $0a
    ld a, $ff

.loop:
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld a, [wRecordBuffer]
    ld [de], a
    inc de
    ld a, [wRecordBuffer + $1]
    ld [de], a
    inc de
    inc de
    inc de
    ld b, $04
    ld hl, wRecordBufferData

.loop2:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop2
    ld a, $ff
    ld b, $04

.loop3:
    ld [de], a
    inc de
    dec b
    jr nz, .loop3
    ld a, $00
    ld [de], a
    inc de
    ld a, [wRecordBufferData + $7]
    ld [de], a
    inc de
    ld a, [wRecordBufferData + $4]
    ld [de], a
    inc de
    ld a, [wRecordBufferData + $5]
    ld [de], a
    inc de
    ld a, $00
    ld [de], a
    inc de
    ld hl, wRecordBufferData + $8
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hld]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hld]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, $e7
    ld [de], a
    inc de
    ld a, $03
    ld [de], a
    inc de
    ld a, [wRecordBufferData + $14]
    ld [de], a
    inc de
    ld a, [wRecordBufferData + $15]
    ld [de], a
    inc de
    ld a, [wRecordBufferData + $17]
    ld [de], a
    inc de
    ld a, [wRecordBufferData + $16]
    ld [de], a
    inc de
    ld a, $1c
    add e
    ld e, a
    jr nc, .read_record_buffer_data
    inc d

.read_record_buffer_data:
    ld a, [wRecordBufferData + $6]
    ld [de], a
    pop bc
    ret

SECTION "Bank 19 SetBattlerFamilyAndSex", ROMX

; DE = the start of a battler record, wSpeciesRecord = the species record of its monster. Writes the
; family (species byte 0) at BATTLER_FAMILY and the sex byte at the next byte, then the 27
; resistance bytes of wSpeciesRecord + SPECIES_RESISTANCES at BATTLER_RESISTANCES. The sex byte is 0
; for sex ratio class 0; for class 1, 2 and any other it steps the table random number
; (NextTableByte) and is 1 when wRandomLo is below 2, $80 or $E6, otherwise 0. A non-zero
; wNewRecordFamily replaces it, with bit 4 cleared. DE ends 2 bytes past the record resistances
; (record + $4E). It ends with pop bc and ret, which discard its own return address: it returns to
; the caller of LoadMonsterAndSpeciesForListEntryC, its only caller, with BC = $4750, so that
; routine never reaches its final pop bc. (C2, E-0379)
SetBattlerFamilyAndSex::
    ld a, $0c
    add e
    ld e, a
    jr nc, .read_species_record
    inc d

.read_species_record:
    ld a, [wSpeciesRecord]
    ld [de], a
    inc de
    ld a, [wSpeciesRecord + SPECIES_SEX_RATIO]
    or a
    jr z, .check_new_record_family2
    cp $01
    jr z, .skip
    cp $02
    jr z, .skip2
    ld b, $e6
    jr .skip3

.skip:
    ld b, $02
    jr .skip3

.skip2:
    ld b, $80

.skip3:
    push af
    push bc
    push de
    push hl
    call NextTableByte
    pop hl
    pop de
    pop bc
    pop af
    ld a, [wRandomLo]
    cp b
    jr c, .check_new_record_family
    xor a
    jr .check_new_record_family2

.check_new_record_family:
    ld a, $01

.check_new_record_family2:
    ld [de], a
    ld a, [wNewRecordFamily]
    or a
    jr z, .skip4
    res 4, a
    ld [de], a

.skip4:
    ld a, $24
    add e
    ld e, a
    jr nc, .skip5
    inc d

.skip5:
    ld b, $1b
    ld hl, wSpeciesRecord + SPECIES_RESISTANCES

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    inc de
    inc de
    pop bc
    ret

SECTION "Bank 19 GameMode4_Init_LoadBattleSlots_LoadSlot", ROMX

; Loads battle slot C from its battler record: in link battles it goes straight to
; LoadBattleSlotFromBattlerRecord; otherwise slots below 4 use LoadBattleSlotFromBattlerRecord and
; foe slots LoadBattleSlotFromBattlerRecord_UnlinkedFoe, and then the species record buffer is
; cleared (ClearSpeciesRecordBuffer_Bank19). (C2, E-0370; probed E-0379)
GameMode4_Init_LoadBattleSlots_LoadSlot::
    ld a, [wLinkMode]
    or a
    jr nz, LoadBattleSlotFromBattlerRecord
    ld a, c
    cp $04
    jr nc, .call_load_battle_slot_from_battler_record
    call LoadBattleSlotFromBattlerRecord
    jr .call_clear_species_record_buffer_bank19

.call_load_battle_slot_from_battler_record:
    call LoadBattleSlotFromBattlerRecord_UnlinkedFoe

.call_clear_species_record_buffer_bank19:
    call ClearSpeciesRecordBuffer_Bank19
    ret

SECTION "Bank 19 LoadBattleSlotFromBattlerRecord", ROMX

; C = battle slot (0-2 or 4-6). Copies that slot battler record (BattlerRecordAddress_Bank19) into
; the per-slot battle arrays: the species word to wBattleMonsterId; the low nibble of record byte
; $0D to wSlotNameSuffix; the high nibble of byte $0D as the tactics, bits 4-5 to wSlotTactic and
; bits 6-7 to wSlotLastTactic (both 0 in a link battle), with wSlotTactic also saved in
; wBattleLoadWork for slots below 4; the skills (LoadSlotSkillsFromBattlerRecord, or
; LoadSlotSkillsForBattleArg0 when wBattleArg0 is not 0); the level to wBattleLevel; the maximum HP,
; maximum MP, ATK, DEF, AGL, INT and extra stat (WLD) words; the 27 resistance bytes packed into
; wSlotResistances (PackResistanceFieldsToDE); and finally wSlotAIMode from the INT word
; (SetSlotAIModeFromINT). When wLoadSlot is 0 it also sets wBattleSlotOut and wBattleStatus from the
; status byte of the record (byte $16, just before BATTLER_LEVEL;
; InitSlotOutAndStatusFromRecordFlags), and copies the current HP and MP words and the four
; personality bytes (to wSlotPersonalityHi, Lo, Trait and Mid). When wLoadSlot is not 0 the current
; HP and MP and the slot flags are left alone, and the personality bytes are copied only if the
; first status byte of slot wBattleArg0 has bit 4 or 5 set. GameMode4_Init_SetUpBattle clears
; wLoadSlot, so the wLoadSlot branches are not reached at battle set-up. It is the loader for slots
; below 4, and for every slot in a link battle (GameMode4_Init_LoadBattleSlots_LoadSlot). (C2,
; E-0379)
; slot C: copies species, family, AI settings (wSlotTactic/wSlotLastTactic outside link battles) and
; stats from its battler record into the battle arrays (E-0131) (E-0344: the address in its name
; dropped or read as the label there; was LoadBattleSlotFromBattlerRecord)
LoadBattleSlotFromBattlerRecord::
    ld a, c
    push bc
    call BattlerRecordAddress_Bank19
    pop bc
    ld a, c
    add a
    ld de, wBattleMonsterId
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, l
    add $0a
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc hl
    ld a, c
    ld de, wSlotNameSuffix
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [hl]
    and $0f
    ld [de], a
    ld a, [wLinkMode]
    or a
    jr z, .skip5
    ld a, c
    ld de, wSlotTactic
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, $00
    ld [de], a
    ld a, c
    ld de, wSlotLastTactic
    add e
    ld e, a
    jr nc, .skip4
    inc d

.skip4:
    ld a, $00
    ld [de], a
    inc hl
    push af
    jr .skip7

.skip5:
    ld a, c
    ld de, wSlotTactic
    add e
    ld e, a
    jr nc, .skip6
    inc d

.skip6:
    ld a, [hli]
    swap a
    and $0f
    push af
    and $03
    ld [de], a
    pop af
    push af
    push af
    ld a, c
    ld de, wSlotLastTactic
    add e
    ld e, a
    jr nc, .restore
    inc d

.restore:
    pop af
    rrca
    rrca
    and $03
    ld [de], a

.skip7:
    ld a, c
    cp $04
    jr nc, .restore3
    ld a, c
    ld de, wBattleLoadWork
    add e
    ld e, a
    jr nc, .restore2
    inc d

.restore2:
    pop af
    and $03
    ld [de], a
    jr .check_battle_arg0

.restore3:
    pop af

.check_battle_arg0:
    push hl
    push bc
    ld a, [wBattleArg0]
    or a
    jr nz, .call_load_slot_skills_for_battle_arg0
    call LoadSlotSkillsFromBattlerRecord
    jr .restore4

.call_load_slot_skills_for_battle_arg0:
    call LoadSlotSkillsForBattleArg0

.restore4:
    pop bc
    pop hl
    ld a, l
    add $08
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wLoadSlot]
    or a
    call z, InitSlotOutAndStatusFromRecordFlags
    inc hl
    ld de, wBattleLevel
    call StoreByteAtDEPlusC_Bank19
    inc hl
    inc hl
    inc hl
    ld a, [wLoadSlot]
    or a
    jr z, .call_store_word_at_de_plus2_c_bank19
    inc hl
    inc hl
    ld de, wBattleMaxHP
    call StoreWordAtDEPlus2C_Bank19
    inc hl
    inc hl
    ld de, wBattleMaxMP
    call StoreWordAtDEPlus2C_Bank19
    jr .call_store_word_at_de_plus2_c_bank192

.call_store_word_at_de_plus2_c_bank19:
    ld de, wBattleHP
    call StoreWordAtDEPlus2C_Bank19
    ld de, wBattleMaxHP
    call StoreWordAtDEPlus2C_Bank19
    ld de, wBattleMP
    call StoreWordAtDEPlus2C_Bank19
    ld de, wBattleMaxMP
    call StoreWordAtDEPlus2C_Bank19

.call_store_word_at_de_plus2_c_bank192:
    ld de, wBattleATK
    call StoreWordAtDEPlus2C_Bank19
    ld de, wBattleDEF
    call StoreWordAtDEPlus2C_Bank19
    ld de, wBattleAGL
    call StoreWordAtDEPlus2C_Bank19
    ld de, wBattleINT
    call StoreWordAtDEPlus2C_Bank19
    ld de, wBattleExtraStat
    call StoreWordAtDEPlus2C_Bank19
    ld a, [wLoadSlot]
    or a
    jr z, .call_store_byte_at_de_plus_c_bank19
    ld a, [wBattleArg0]
    push hl
    ld l, a
    add a
    add a
    add a
    add l
    ld hl, wBattleStatus1
    add_a_to_hl
    ld a, [hl]
    and $30
    pop hl
    jr nz, .call_store_byte_at_de_plus_c_bank19
    inc hl
    inc hl
    inc hl
    inc hl
    jr .skip8

.call_store_byte_at_de_plus_c_bank19:
    ld de, wSlotPersonalityHi
    call StoreByteAtDEPlusC_Bank19
    ld de, wSlotPersonalityLo
    call StoreByteAtDEPlusC_Bank19
    ld de, wSlotTrait
    call StoreByteAtDEPlusC_Bank19
    ld de, wSlotPersonalityMid
    call StoreByteAtDEPlusC_Bank19

.skip8:
    ld a, c
    add a
    add c
    add a
    add c
    ld de, wSlotResistances
    add e
    ld e, a
    jr nc, .call_pack_resistance_fields_to_de
    inc d

.call_pack_resistance_fields_to_de:
    push bc
    call PackResistanceFieldsToDE
    pop bc
    call SetSlotAIModeFromINT
    ret

SECTION "Bank 19 LoadBattleSlotFromBattlerRecord_UnlinkedFoe", ROMX

; A = C = battle slot (4-6): the routine passes A to BattlerRecordAddress_Bank19 without loading it,
; so the caller must have A = C. It is the foe variant of LoadBattleSlotFromBattlerRecord used
; outside link battles. Differences: wSlotNameSuffix gets the whole of record byte $0D, wSlotTactic
; is set to 0, and wSlotLastTactic and wBattleLoadWork are not written. With wLoadSlot 0 the current
; HP is stored and then replaced in place by RandomizeWordBetween80And100Percent unless wBattleKind
; is 2, 3 or 5 (in a link battle this routine is not used): with w = 80 percent of the HP (16-bit,
; HP * 8 / 10) the HP becomes w plus a 16-bit random value (wRandomHi, wRandomLo after one
; NextTableByte step) modulo HP - w, which is a value from w up to HP - 1; an HP of 0 would loop
; forever. The maximum HP is stored unchanged. The skills, level, other stat words, personality
; bytes, resistances and wSlotAIMode are loaded as in LoadBattleSlotFromBattlerRecord. (C2, E-0379)
; slot C: copies species, family, wSlotTactic and stats from its battler record into the battle
; arrays and loads its skills (E-0131) (E-0344: the address in its name dropped or read as the label
; there; was LoadBattleSlotFromBattlerRecord_UnlinkedFoe)
LoadBattleSlotFromBattlerRecord_UnlinkedFoe::
    push bc
    call BattlerRecordAddress_Bank19
    pop bc
    ld a, c
    add a
    ld de, wBattleMonsterId
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, l
    add $0a
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc hl
    ld a, c
    ld de, wSlotNameSuffix
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [hli]
    ld [de], a
    ld a, c
    ld de, wSlotTactic
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, $00
    ld [de], a
    push hl
    push bc
    ld a, [wBattleArg0]
    or a
    jr nz, .call_load_slot_skills_for_battle_arg0
    call LoadSlotSkillsFromBattlerRecord
    jr .restore

.call_load_slot_skills_for_battle_arg0:
    call LoadSlotSkillsForBattleArg0

.restore:
    pop bc
    pop hl
    ld a, l
    add $08
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wLoadSlot]
    or a
    call z, InitSlotOutAndStatusFromRecordFlags
    inc hl
    ld de, wBattleLevel
    call StoreByteAtDEPlusC_Bank19
    inc hl
    inc hl
    inc hl
    ld a, [wLoadSlot]
    or a
    jr z, .call_store_word_at_de_plus2_c_bank19
    inc hl
    inc hl
    ld de, wBattleMaxHP
    call StoreWordAtDEPlus2C_Bank19
    inc hl
    inc hl
    ld de, wBattleMaxMP
    call StoreWordAtDEPlus2C_Bank19
    jr .call_store_word_at_de_plus2_c_bank192

.call_store_word_at_de_plus2_c_bank19:
    ld de, wBattleHP
    call StoreWordAtDEPlus2C_Bank19
    push de
    push hl
    ld a, e
    sub $01
    ld l, a
    ld a, d
    sbc $00
    ld h, a
    call RandomizeWordBetween80And100Percent
    pop hl
    pop de
    ld de, wBattleMaxHP
    call StoreWordAtDEPlus2C_Bank19
    ld de, wBattleMP
    call StoreWordAtDEPlus2C_Bank19
    ld de, wBattleMaxMP
    call StoreWordAtDEPlus2C_Bank19

.call_store_word_at_de_plus2_c_bank192:
    ld de, wBattleATK
    call StoreWordAtDEPlus2C_Bank19
    ld de, wBattleDEF
    call StoreWordAtDEPlus2C_Bank19
    ld de, wBattleAGL
    call StoreWordAtDEPlus2C_Bank19
    ld de, wBattleINT
    call StoreWordAtDEPlus2C_Bank19
    ld de, wBattleExtraStat
    call StoreWordAtDEPlus2C_Bank19
    ld a, [wLoadSlot]
    or a
    jr z, .call_store_byte_at_de_plus_c_bank19
    ld a, [wBattleArg0]
    push hl
    ld l, a
    add a
    add a
    add a
    add l
    ld hl, wBattleStatus1
    add_a_to_hl
    ld a, [hl]
    and $30
    pop hl
    jr nz, .call_store_byte_at_de_plus_c_bank19
    inc hl
    inc hl
    inc hl
    inc hl
    jr .skip4

.call_store_byte_at_de_plus_c_bank19:
    ld de, wSlotPersonalityHi
    call StoreByteAtDEPlusC_Bank19
    ld de, wSlotPersonalityLo
    call StoreByteAtDEPlusC_Bank19
    ld de, wSlotTrait
    call StoreByteAtDEPlusC_Bank19
    ld de, wSlotPersonalityMid
    call StoreByteAtDEPlusC_Bank19

.skip4:
    ld a, c
    add a
    add c
    add a
    add c
    ld de, wSlotResistances
    add e
    ld e, a
    jr nc, .call_pack_resistance_fields_to_de
    inc d

.call_pack_resistance_fields_to_de:
    push bc
    call PackResistanceFieldsToDE
    pop bc
    call SetSlotAIModeFromINT
    ret

SECTION "Bank 19 BattlerRecordAddress_Bank19", ROMX

; A = battle slot. For slots 3 and 7 it returns at once with Z set and HL unchanged (they have no
; battler record). Otherwise HL = wBattlerRecords + $4E * n, where n = A for slots 0-2 and A - 1 for
; slots 4-6, the address of the battler record of that slot (so the records of slots 4-6 are the
; fourth to sixth). B and C are changed. Both LoadBattleSlotFromBattlerRecord and
; LoadBattleSlotFromBattlerRecord_UnlinkedFoe call it. (C2, E-0379)
; A = battle slot: for slots 3 and 7 returns at once with Z set and HL unchanged; otherwise HL =
; wBattlerRecords + $4E * A' with A' = A - 1 for slots 4-6 (as BattlerRecordFieldAddress without the
; field offset) (E-0067) (the same 23 bytes appear in 2 banks)
BattlerRecordAddress_Bank19::
    cp $03
    jr c, .call_multiply8
    ret z
    cp $07
    ret z
    dec a

.call_multiply8:
    ld c, $4e
    call Multiply8
    ld a, l
    add $d5
    ld l, a
    ld a, h
    adc $d0
    ld h, a
    ret

SECTION "Bank 19 GameMode4_Init_SetSlotMarks", ROMX

; Sets wSlotMarks from wBattleSlotOut. Outside link battles the foe slots 4-7 are done first: $FF
; for a slot whose wBattleSlotOut is $FF (no monster), $01 for any other. Then slots 0-3 (all eight
; slots in a link battle): $FF when wBattleSlotOut is $FF; otherwise $01 when CheckSlotStatusBlock
; says the slot is blocked, which includes a defeated monster (wBattleSlotOut 1) as well as asleep,
; paralyzed, confused, frozen and the other statuses it tests, and $00 when it is not. (C2, E-0379)
GameMode4_Init_SetSlotMarks::
    ld a, [wLinkMode]
    or a
    jr nz, .skip2
    ld hl, wSlotMarks + $4
    ld bc, $0404

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr z, .skip
    ld [hl], $01
    jr .next

.skip:
    ld [hl], $ff

.next:
    inc hl
    inc c
    dec b
    jr nz, .loop
    ld bc, $0400
    jr .call_carry_unless_battle_slot_out_slot_empty

.skip2:
    ld bc, $0800

.call_carry_unless_battle_slot_out_slot_empty:
    ld hl, wSlotMarks

.loop2:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr z, .skip4
    ld a, c
    call CheckSlotStatusBlock
    jr c, .skip3
    ld [hl], $00
    jr .next2

.skip3:
    ld [hl], $01
    jr .next2

.skip4:
    ld [hl], $ff

.next2:
    inc c
    inc hl
    dec b
    jr nz, .loop2
    ret

SECTION "Bank 19 ExpTable", ROMX

; LoadTableEntryForRecordBufASpeciesToRecordBufAExp copies the 3 bytes at $4E60 + $129 * (species
; record byte 7) + 3 * (level - 1) to the record's EXP field (+$58); RecordReachedNextLevelExp and
; DrawRecordBufBExpAndExpToNextLevel read the same rows; 32 rows of 99 rising values, each row
; starting at 0 (E-0148, C1)
; record: EXP needed for levels 1-99 (24-bit)
ExpTable::
    d24 0, 2, 7, 15, 27, 45, 72, 113, 175, 268, 408 ; id 0
    d24 618, 933, 1327, 1820, 2436, 3206, 4169, 5373, 6878, 8759, 10875
    d24 13256, 15935, 18949, 22340, 26155, 30447, 35276, 40709, 46482, 52616, 59133
    d24 66057, 73414, 81231, 89537, 98362, 107739, 117702, 128288, 139536, 151487, 164185
    d24 177677, 192012, 207243, 223426, 240620, 258889, 278300, 298924, 320837, 344120, 368858
    d24 393646, 418485, 443376, 468320, 493318, 518371, 543480, 568646, 593870, 619153, 644496
    d24 669900, 695366, 720895, 746488, 772146, 797870, 823661, 849520, 875448, 901446, 927515
    d24 953656, 979870, 1006158, 1032521, 1058960, 1085476, 1112070, 1138743, 1165496, 1192330, 1219246
    d24 1246245, 1273328, 1300496, 1327750, 1355092, 1382523, 1410044, 1437656, 1465360, 1493157, 1521048
    d24 0, 2, 7, 15, 27, 45, 72, 113, 175, 268, 408 ; id 1
    d24 618, 933, 1327, 1820, 2436, 3206, 4169, 5373, 6878, 8759, 10875
    d24 13256, 15935, 18949, 22340, 26155, 30447, 35276, 40709, 46482, 52616, 59133
    d24 66057, 73414, 81231, 89537, 98105, 106943, 116059, 125462, 136040, 147940, 161328
    d24 176390, 193335, 212398, 233844, 257971, 285114, 312307, 339551, 366847, 394196, 421599
    d24 449057, 476571, 504142, 531771, 559459, 587207, 615016, 642887, 670821, 698819, 726882
    d24 755011, 783207, 811471, 839804, 868207, 896681, 925227, 953846, 982539, 1011307, 1040151
    d24 1069072, 1098071, 1127149, 1156307, 1185546, 1214867, 1244271, 1273759, 1303332, 1332991, 1362737
    d24 1392571, 1422494, 1452507, 1482611, 1512807, 1543096, 1573479, 1603957, 1634531, 1665202, 1695971
    d24 0, 2, 7, 15, 27, 45, 72, 113, 175, 268, 408 ; id 2
    d24 618, 933, 1327, 1820, 2436, 3206, 4169, 5373, 6878, 8759, 11110
    d24 14049, 17355, 21074, 25258, 29965, 35260, 41217, 47919, 55459, 63470, 71982
    d24 81026, 90635, 100845, 111693, 123219, 135465, 148476, 162300, 176988, 192594, 209175
    d24 226792, 245510, 265398, 286529, 308981, 332836, 356741, 380697, 404705, 428766, 452881
    d24 477051, 501277, 525560, 549901, 574301, 598761, 623282, 647865, 672511, 697221, 721996
    d24 746837, 771745, 796721, 821766, 846881, 872067, 897325, 922656, 948061, 973541, 999097
    d24 1024730, 1050441, 1076231, 1102101, 1128052, 1154085, 1180201, 1206401, 1232686, 1259057, 1285515
    d24 1312061, 1338696, 1365421, 1392237, 1419145, 1446146, 1473241, 1500431, 1527717, 1555100, 1582581
    d24 0, 2, 7, 15, 27, 45, 72, 113, 175, 268, 408 ; id 3
    d24 618, 933, 1327, 1820, 2436, 3206, 4169, 5373, 6878, 8759, 11110
    d24 14049, 17355, 21074, 25258, 29965, 35260, 41217, 47919, 55459, 63470, 71982
    d24 81026, 90635, 100845, 111693, 123219, 135465, 148476, 162300, 176988, 193512, 212102
    d24 233016, 255237, 278847, 303933, 330587, 358907, 387277, 415698, 444171, 472697, 501277
    d24 529912, 558603, 587351, 616157, 645022, 673947, 702933, 731981, 761092, 790267, 819507
    d24 848813, 878186, 907627, 937137, 966717, 996368, 1026091, 1055887, 1085757, 1115702, 1145723
    d24 1175821, 1205997, 1236252, 1266587, 1297003, 1327501, 1358082, 1388747, 1419497, 1450333, 1481256
    d24 1512267, 1543367, 1574557, 1605838, 1637211, 1668677, 1700237, 1731892, 1763643, 1795491, 1827437
    d24 0, 2, 7, 15, 27, 45, 72, 113, 175, 268, 408 ; id 4
    d24 618, 933, 1327, 1820, 2436, 3206, 4169, 5373, 6878, 8759, 11110
    d24 14049, 17723, 22316, 27483, 33296, 39836, 47194, 55472, 64785, 74680, 85193
    d24 96363, 108231, 120841, 134239, 148474, 163599, 179669, 196743, 214884, 234159, 254639
    d24 276399, 299519, 324084, 348699, 373365, 398083, 422854, 447679, 472559, 497495, 522488
    d24 547539, 572649, 597819, 623050, 648343, 673699, 699119, 724604, 750155, 775773, 801459
    d24 827214, 853039, 878935, 904903, 930944, 957059, 983249, 1009515, 1035858, 1062279, 1088779
    d24 1115359, 1142020, 1168763, 1195589, 1222499, 1249494, 1276575, 1303743, 1330999, 1358344, 1385779
    d24 1413305, 1440923, 1468634, 1496439, 1524339, 1552335, 1580428, 1608619, 1636909, 1665299, 1693790
    d24 0, 2, 7, 15, 27, 45, 72, 113, 175, 268, 408 ; id 5
    d24 618, 933, 1327, 1820, 2436, 3206, 4169, 5373, 6878, 8759, 11110
    d24 14049, 17723, 22316, 27483, 33296, 39836, 47194, 55472, 64785, 75262, 86394
    d24 98222, 110789, 124141, 138328, 153402, 169418, 186435, 204516, 223727, 244139, 265827
    d24 288871, 313355, 339369, 367009, 396377, 425795, 455264, 484785, 514359, 543987, 573670
    d24 603409, 633205, 663059, 692972, 722945, 752979, 783075, 813234, 843457, 873745, 904099
    d24 934520, 965009, 995567, 1026195, 1056894, 1087665, 1118509, 1149427, 1180420, 1211489, 1242635
    d24 1273859, 1305162, 1336545, 1368009, 1399555, 1431184, 1462897, 1494695, 1526579, 1558550, 1590609
    d24 1622757, 1654995, 1687324, 1719745, 1752259, 1784867, 1817570, 1850369, 1883265, 1916259, 1949352
    d24 0, 2, 7, 15, 27, 45, 72, 113, 175, 268, 408 ; id 6
    d24 618, 933, 1327, 1820, 2436, 3206, 4169, 5373, 6878, 8759, 11110
    d24 14049, 17723, 22316, 28057, 35233, 43306, 52388, 62605, 74099, 86311, 99286
    d24 113072, 127720, 143284, 159821, 177392, 196061, 215897, 236973, 259366, 281809, 304303
    d24 326849, 349448, 372101, 394809, 417573, 440394, 463273, 486211, 509209, 532268, 555389
    d24 578573, 601821, 625134, 648513, 671959, 695473, 719056, 742709, 766433, 790229, 814098
    d24 838041, 862059, 886153, 910324, 934573, 958901, 983309, 1007798, 1032369, 1057023, 1081761
    d24 1106584, 1131493, 1156489, 1181573, 1206746, 1232009, 1257363, 1282809, 1308348, 1333981, 1359709
    d24 1385533, 1411454, 1437473, 1463591, 1489810, 1516131, 1542555, 1569083, 1595716, 1622455, 1649301
    d24 0, 2, 7, 15, 27, 45, 72, 113, 175, 268, 408 ; id 7
    d24 618, 933, 1327, 1820, 2436, 3206, 4169, 5373, 6878, 8759, 11110
    d24 14049, 17723, 22316, 28057, 35233, 43306, 52388, 62605, 74099, 86311, 99286
    d24 113072, 127720, 143284, 159821, 177392, 196061, 215897, 236973, 259366, 283159, 308439
    d24 335299, 363838, 392427, 421067, 449759, 478504, 507303, 536157, 565067, 594034, 623059
    d24 652143, 681287, 710492, 739759, 769089, 798483, 827942, 857467, 887059, 916719, 946448
    d24 976247, 1006117, 1036059, 1066074, 1096163, 1126327, 1156567, 1186884, 1217279, 1247753, 1278307
    d24 1308942, 1339659, 1370459, 1401343, 1432312, 1463367, 1494509, 1525739, 1557058, 1588467, 1619967
    d24 1651559, 1683244, 1715023, 1746897, 1778867, 1810934, 1843099, 1875363, 1907728, 1940195, 1972765
    d24 0, 5, 15, 30, 53, 88, 141, 221, 341, 521, 791 ; id 8
    d24 1196, 1804, 2564, 3514, 4702, 6187, 8043, 10363, 13263, 16888, 21419
    d24 26516, 32250, 38701, 45958, 54122, 63307, 73066, 83435, 94452, 106158, 118596
    d24 131811, 145852, 160771, 176622, 193464, 211359, 230372, 249979, 270199, 291051, 312555
    d24 334731, 358293, 383328, 409928, 438191, 468220, 500126, 534026, 570045, 607190, 645496
    d24 684999, 725736, 767746, 811069, 855746, 901819, 949332, 998330, 1047378, 1096477, 1145628
    d24 1194832, 1244090, 1293403, 1342772, 1392198, 1441682, 1491225, 1540828, 1590492, 1640218, 1690007
    d24 1739860, 1789778, 1839762, 1889813, 1939932, 1990120, 2040378, 2090707, 2141108, 2191582, 2242130
    d24 2292753, 2343452, 2394228, 2445082, 2496015, 2547028, 2598122, 2649298, 2700557, 2751900, 2803328
    d24 0, 5, 15, 30, 53, 88, 141, 221, 341, 521, 791 ; id 9
    d24 1196, 1804, 2564, 3514, 4702, 6187, 8043, 10363, 12973, 16236, 20315
    d24 25414, 31150, 37603, 44863, 53031, 62220, 71983, 82356, 93377, 105087, 117529
    d24 130749, 144795, 159719, 175576, 192424, 210325, 229345, 249554, 271026, 293840, 319506
    d24 348380, 380863, 417406, 456233, 497487, 541319, 586521, 633136, 681208, 730782, 781131
    d24 832267, 884202, 936948, 990518, 1044925, 1100182, 1156302, 1213299, 1271187, 1329980, 1388823
    d24 1447717, 1506663, 1565662, 1624715, 1683823, 1742987, 1802208, 1861487, 1920825, 1980223, 2039682
    d24 2099203, 2158787, 2218435, 2278148, 2337927, 2397773, 2457687, 2517670, 2577723, 2637847, 2698043
    d24 2758312, 2818655, 2879073, 2939567, 3000138, 3060787, 3121515, 3182323, 3243212, 3304183, 3365237
    d24 0, 5, 15, 30, 53, 88, 141, 221, 341, 521, 791 ; id 10
    d24 1196, 1804, 2564, 3514, 4702, 6187, 8043, 10363, 13263, 16526, 20605
    d24 25704, 32078, 40046, 49010, 59095, 70441, 83205, 97565, 112823, 129035, 146260
    d24 164562, 184008, 204669, 226621, 249945, 274727, 301058, 328212, 356215, 385093, 414873
    d24 446514, 480133, 515853, 552689, 590676, 629850, 670248, 711277, 752947, 795268, 838250
    d24 881904, 926240, 971269, 1017002, 1063450, 1110624, 1158535, 1207195, 1256615, 1306085, 1355606
    d24 1405179, 1454805, 1504485, 1554220, 1604011, 1653859, 1703765, 1753730, 1803755, 1853841, 1903989
    d24 1954200, 2004475, 2054815, 2105221, 2155694, 2206235, 2256845, 2307525, 2358276, 2409099, 2459995
    d24 2510965, 2562010, 2613131, 2664329, 2715605, 2766960, 2818395, 2869911, 2921509, 2973190, 3024955
    d24 0, 5, 15, 30, 53, 88, 141, 221, 341, 521, 791 ; id 11
    d24 1196, 1804, 2564, 3514, 4702, 6187, 8043, 10363, 13263, 16526, 20197
    d24 24786, 30522, 37692, 46655, 56738, 68081, 80842, 95198, 110451, 126657, 143876
    d24 162171, 181609, 202262, 224206, 247522, 272295, 298616, 326582, 356296, 387867, 421411
    d24 457052, 494921, 535157, 577908, 623331, 671593, 721363, 771911, 823249, 875389, 928344
    d24 982126, 1036748, 1092223, 1148565, 1205787, 1263903, 1322069, 1380286, 1438555, 1496877, 1555253
    d24 1613684, 1672171, 1730715, 1789317, 1847978, 1906699, 1965481, 2024325, 2083232, 2142203, 2201239
    d24 2260341, 2319510, 2378747, 2438053, 2497429, 2556876, 2616395, 2675987, 2735653, 2795394, 2855211
    d24 2915105, 2975077, 3035128, 3095259, 3155471, 3215765, 3276142, 3336603, 3397149, 3457781, 3518500
    d24 0, 5, 15, 30, 53, 88, 141, 221, 341, 521, 791 ; id 12
    d24 1196, 1804, 2564, 3514, 4702, 6187, 8043, 10363, 12973, 15909, 19579
    d24 25084, 31965, 40566, 51317, 63412, 77019, 92327, 109549, 127847, 147289, 167946
    d24 189894, 213214, 237992, 264319, 292291, 322011, 353589, 386154, 419737, 453845, 488486
    d24 523668, 559400, 595690, 632547, 669980, 707998, 746610, 785825, 825090, 864406, 903774
    d24 943195, 982670, 1022200, 1061786, 1101429, 1141130, 1180890, 1220710, 1260591, 1300534, 1340540
    d24 1380610, 1420745, 1460946, 1501214, 1541550, 1581955, 1622430, 1662976, 1703594, 1744285, 1785050
    d24 1825890, 1866806, 1907799, 1948870, 1990020, 2031250, 2072561, 2113954, 2155430, 2196990, 2238635
    d24 2280366, 2322184, 2364090, 2406085, 2448170, 2490346, 2532614, 2574975, 2617430, 2659980, 2702626
    d24 0, 5, 15, 30, 53, 88, 141, 221, 341, 521, 791 ; id 13
    d24 1196, 1804, 2564, 3514, 4702, 6187, 8043, 10363, 13263, 16888, 21419
    d24 27083, 34163, 43013, 52969, 64170, 76771, 90947, 106895, 124837, 143900, 164154
    d24 185674, 208539, 232833, 258645, 286070, 315209, 346169, 379064, 414015, 451150, 489445
    d24 528937, 569663, 611662, 654973, 699637, 744999, 791070, 837861, 885383, 933648, 982667
    d24 1031736, 1080856, 1130028, 1179253, 1228532, 1277866, 1327256, 1376703, 1426208, 1475772, 1525396
    d24 1575081, 1624828, 1674638, 1724512, 1774451, 1824456, 1874528, 1924668, 1974877, 2025156, 2075506
    d24 2125928, 2176423, 2226992, 2277636, 2328356, 2379153, 2430028, 2480982, 2532016, 2583131, 2634328
    d24 2685608, 2736972, 2788421, 2839956, 2891578, 2943288, 2995087, 3046976, 3098956, 3151028, 3203193
    d24 0, 5, 15, 30, 53, 88, 141, 221, 341, 521, 791 ; id 14
    d24 1196, 1804, 2564, 3514, 4702, 6187, 8043, 10363, 12973, 15909, 19579
    d24 25084, 33342, 43665, 55278, 68343, 83041, 99576, 118178, 139105, 162648, 189134
    d24 217275, 247175, 278944, 312699, 348564, 386671, 425969, 466495, 508287, 551385, 595830
    d24 641664, 686782, 731195, 774914, 817950, 860314, 902016, 943066, 983475, 1023253, 1062409
    d24 1101615, 1140872, 1180181, 1219543, 1258959, 1298430, 1337957, 1377541, 1417183, 1456884, 1496645
    d24 1536467, 1576351, 1616298, 1656309, 1696385, 1736527, 1776736, 1817013, 1857359, 1897775, 1938262
    d24 1978821, 2019453, 2060159, 2100940, 2141797, 2182731, 2223743, 2264834, 2306005, 2347257, 2388591
    d24 2430008, 2471509, 2513095, 2554767, 2596526, 2638373, 2680309, 2722335, 2764452, 2806661, 2848963
    d24 0, 5, 15, 30, 53, 88, 141, 221, 341, 521, 791 ; id 15
    d24 1196, 1804, 2564, 3514, 4702, 6187, 8043, 10363, 12973, 15909, 20313
    d24 26919, 35177, 45500, 58404, 72921, 89253, 107627, 128298, 150261, 173597, 198392
    d24 224737, 252729, 282471, 313142, 344771, 376894, 409519, 442654, 476307, 510486, 545199
    d24 580454, 616811, 654304, 692969, 732842, 773961, 816365, 860094, 905190, 951695, 999653
    d24 1049110, 1100113, 1152710, 1206129, 1260383, 1315485, 1371448, 1428285, 1486010, 1544637, 1604180
    d24 1663773, 1723417, 1783113, 1842862, 1902665, 1962523, 2022437, 2082408, 2142437, 2202525, 2262673
    d24 2322882, 2383153, 2443487, 2503885, 2564348, 2624877, 2685473, 2746137, 2806870, 2867673, 2928547
    d24 2989493, 3050512, 3111605, 3172773, 3234017, 3295338, 3356737, 3418215, 3479773, 3541412, 3603133
    d24 0, 10, 35, 73, 130, 216, 345, 539, 830, 1267, 1923 ; id 16
    d24 2907, 4137, 5675, 7598, 10002, 13007, 16763, 21458, 27327, 33930, 41358
    d24 49715, 59117, 69694, 81593, 94979, 109202, 124314, 140371, 157432, 175559, 195952
    d24 218894, 244704, 272127, 300407, 329571, 359646, 390661, 422645, 455629, 489644, 524722
    d24 560896, 598200, 636670, 676342, 717254, 759445, 802954, 847823, 894094, 941811, 991019
    d24 1041765, 1094097, 1148064, 1203717, 1261109, 1320295, 1381331, 1444274, 1509184, 1576122, 1645152
    d24 1714232, 1783363, 1852546, 1921782, 1991072, 2060417, 2129818, 2199276, 2268792, 2338367, 2408002
    d24 2477698, 2547456, 2617277, 2687162, 2757112, 2827128, 2897211, 2967362, 3037582, 3107872, 3178233
    d24 3248666, 3319172, 3389752, 3460407, 3531138, 3601946, 3672832, 3743797, 3814842, 3885968, 3957176
    d24 0, 10, 35, 73, 130, 216, 345, 539, 830, 1267, 1923 ; id 17
    d24 2907, 4137, 5675, 7598, 10002, 13007, 16763, 21458, 26740, 32682, 40110
    d24 49395, 59841, 71593, 84080, 97347, 111443, 126420, 142333, 159241, 178263, 199663
    d24 223738, 249318, 276497, 305375, 336058, 367700, 400331, 433982, 468685, 505557, 543581
    d24 582793, 623230, 666194, 711843, 760345, 810363, 861944, 915137, 969992, 1026561, 1084898
    d24 1145058, 1207098, 1270107, 1334101, 1399095, 1465105, 1532146, 1600235, 1669388, 1738591, 1807845
    d24 1877151, 1946510, 2015923, 2085391, 2154915, 2224496, 2294135, 2363833, 2433591, 2503410, 2573291
    d24 2643235, 2713243, 2783316, 2853455, 2923661, 2993935, 3064278, 3134691, 3205175, 3275731, 3346360
    d24 3417063, 3487841, 3558695, 3629626, 3700635, 3771723, 3842891, 3914140, 3985471, 4056885, 4128383
    d24 0, 10, 35, 73, 130, 216, 345, 539, 830, 1267, 1923 ; id 18
    d24 2907, 4137, 5675, 7598, 10002, 13007, 16763, 21458, 26740, 32682, 40110
    d24 49395, 61001, 75509, 93644, 114046, 136998, 162819, 190254, 219404, 252198, 287042
    d24 324064, 363400, 405195, 448296, 492744, 538581, 585134, 632414, 680433, 729202, 778733
    d24 829038, 880129, 932018, 984718, 1038241, 1092600, 1147808, 1203879, 1260826, 1318663, 1377404
    d24 1437063, 1497654, 1559192, 1621692, 1685169, 1749638, 1815114, 1881613, 1949151, 2017744, 2086387
    d24 2155081, 2223827, 2292626, 2361479, 2430387, 2499351, 2568372, 2637451, 2706589, 2775787, 2845046
    d24 2914367, 2983751, 3053199, 3122712, 3192291, 3261937, 3331651, 3401434, 3471287, 3541211, 3611207
    d24 3681276, 3751419, 3821637, 3891931, 3962302, 4032751, 4103279, 4173887, 4244576, 4315347, 4386201
    d24 0, 10, 35, 73, 130, 216, 345, 539, 830, 1267, 1923 ; id 19
    d24 2907, 4137, 5675, 7598, 10002, 13007, 16763, 21458, 26740, 33343, 41597
    d24 51915, 63523, 76582, 92906, 111271, 131932, 155176, 181326, 209110, 238631, 269997
    d24 303323, 337690, 373131, 409680, 447371, 486240, 526324, 567661, 610290, 654251, 699586
    d24 746338, 793821, 842046, 891025, 941535, 993623, 1047339, 1102734, 1159860, 1218771, 1279523
    d24 1342174, 1406783, 1473411, 1542121, 1612978, 1686049, 1761403, 1839112, 1919249, 1999436, 2079674
    d24 2159964, 2240307, 2320704, 2401156, 2481664, 2562229, 2642852, 2723534, 2804276, 2885079, 2965944
    d24 3046872, 3127864, 3208921, 3290044, 3371234, 3452492, 3533819, 3615216, 3696684, 3778224, 3859837
    d24 3941524, 4023286, 4105124, 4187039, 4269032, 4351104, 4433256, 4515489, 4597804, 4680202, 4762684
    d24 0, 10, 35, 73, 130, 216, 345, 539, 830, 1267, 1923 ; id 20
    d24 2907, 4137, 5675, 7598, 10002, 13007, 16763, 21458, 26740, 33343, 41597
    d24 51915, 64813, 80936, 99074, 119479, 142435, 168261, 197315, 230001, 264730, 301630
    d24 339683, 378925, 419393, 461126, 504163, 548545, 594314, 641513, 690187, 739622, 789829
    d24 840820, 892608, 945205, 998624, 1052878, 1107980, 1163943, 1220780, 1278505, 1337132, 1396675
    d24 1457148, 1518566, 1580944, 1644297, 1708640, 1773988, 1840357, 1907763, 1976222, 2044731, 2113291
    d24 2181903, 2250568, 2319287, 2388061, 2456891, 2525778, 2594723, 2663727, 2732791, 2801916, 2871103
    d24 2940353, 3009667, 3079046, 3148491, 3218003, 3287583, 3357232, 3426951, 3496741, 3566603, 3636538
    d24 3706547, 3776631, 3846791, 3917028, 3987343, 4057737, 4128211, 4198766, 4269403, 4340123, 4410927
    d24 0, 10, 35, 73, 130, 216, 345, 539, 830, 1267, 1923 ; id 21
    d24 2907, 4137, 5675, 7598, 10002, 13007, 16763, 21458, 27327, 33930, 41358
    d24 52500, 66428, 83838, 103424, 127907, 153920, 181559, 210925, 242126, 275277, 310500
    d24 347924, 387687, 429935, 474824, 521116, 568855, 618086, 668855, 721211, 775203, 830882
    d24 888301, 947514, 1008577, 1071548, 1135503, 1200457, 1266426, 1333426, 1401473, 1470583, 1540773
    d24 1612060, 1684461, 1757993, 1832674, 1908522, 1985555, 2063792, 2143251, 2222760, 2302320, 2381932
    d24 2461597, 2541316, 2621090, 2700920, 2780807, 2860752, 2940756, 3020820, 3100945, 3181132, 3261382
    d24 3341696, 3422075, 3502520, 3583032, 3663612, 3744261, 3824980, 3905770, 3986632, 4067567, 4148576
    d24 4229660, 4310820, 4392057, 4473372, 4554766, 4636240, 4717795, 4799432, 4881152, 4962956, 5044845
    d24 0, 10, 35, 73, 130, 216, 345, 539, 830, 1267, 1923 ; id 22
    d24 2907, 4137, 5675, 7598, 10002, 13007, 16763, 21458, 26740, 32682, 40110
    d24 51252, 67965, 88856, 111053, 134637, 161169, 189359, 219311, 251135, 284948, 320874
    d24 359045, 398409, 439003, 480866, 524037, 568557, 614468, 661814, 709900, 758737, 808337
    d24 858712, 909874, 961835, 1014608, 1068206, 1122641, 1177927, 1234077, 1291104, 1349022, 1407845
    d24 1466718, 1525642, 1584618, 1643647, 1702730, 1761868, 1821062, 1880313, 1939622, 1998990, 2058418
    d24 2117907, 2177458, 2237072, 2296750, 2356493, 2416302, 2476178, 2536122, 2596135, 2656218, 2716372
    d24 2776598, 2836897, 2897270, 2957718, 3018242, 3078843, 3139522, 3200280, 3261118, 3322037, 3383038
    d24 3444122, 3505290, 3566543, 3627882, 3689308, 3750822, 3812425, 3874118, 3935902, 3997778, 4059747
    d24 0, 10, 35, 73, 130, 216, 345, 539, 830, 1267, 1923 ; id 23
    d24 2907, 4137, 5675, 7598, 10002, 13007, 16763, 21458, 26740, 33343, 41597
    d24 53978, 69454, 88799, 112980, 140184, 170789, 203307, 237857, 276726, 318024, 361903
    d24 408524, 458059, 509142, 561821, 615323, 669661, 724848, 780897, 837822, 895636, 954353
    d24 1013987, 1073671, 1133406, 1193193, 1253033, 1312927, 1372876, 1432881, 1492943, 1553063, 1613242
    d24 1674361, 1736435, 1799479, 1863508, 1928537, 1994582, 2061659, 2129784, 2198973, 2268212, 2337502
    d24 2406844, 2476239, 2545688, 2615192, 2684752, 2754369, 2824044, 2893778, 2963572, 3033427, 3103344
    d24 3173324, 3243368, 3313477, 3383652, 3453894, 3524204, 3594583, 3665032, 3735552, 3806144, 3876809
    d24 3947548, 4018362, 4089252, 4160219, 4231264, 4302388, 4373592, 4444877, 4516244, 4587694, 4659228
    d24 0, 100, 370, 775, 1383, 2295, 3663, 5715, 8793, 13410, 20336 ; id 24
    d24 30725, 43711, 59944, 80235, 103062, 128742, 155225, 183363, 213260, 245026, 278777
    d24 314637, 352738, 392030, 432550, 474336, 517428, 561867, 607695, 654239, 701510, 749520
    d24 798280, 847802, 897374, 946997, 996672, 1046400, 1096182, 1146019, 1195912, 1245862, 1295870
    d24 1345937, 1396064, 1446974, 1498679, 1551192, 1604115, 1657451, 1711204, 1765377, 1819973, 1875422
    d24 1931737, 1988932, 2047914, 2108739, 2171465, 2236151, 2301828, 2368512, 2436218, 2504962, 2573756
    d24 2642601, 2711498, 2780448, 2849452, 2918511, 2987626, 3056798, 3126028, 3195317, 3264666, 3334076
    d24 3403548, 3473083, 3542682, 3612346, 3682076, 3751873, 3821738, 3891672, 3961676, 4031751, 4101898
    d24 4172118, 4242412, 4312781, 4383226, 4453748, 4524348, 4595027, 4665786, 4736626, 4807548, 4878553
    d24 0, 100, 370, 775, 1383, 2295, 3663, 5715, 8793, 13410, 20336 ; id 25
    d24 30725, 43711, 59944, 80235, 105599, 137304, 172972, 210869, 251135, 293918, 338038
    d24 382847, 428356, 474576, 521157, 568102, 615414, 663096, 711151, 759581, 808389, 857578
    d24 907151, 957111, 1007461, 1058204, 1109343, 1160882, 1212824, 1265172, 1317929, 1371098, 1424682
    d24 1478685, 1533110, 1588385, 1644524, 1701540, 1759447, 1818259, 1877990, 1938654, 2000266, 2062841
    d24 2126394, 2190940, 2256495, 2324099, 2393816, 2465712, 2539855, 2616315, 2695164, 2774063, 2853013
    d24 2932015, 3011070, 3090179, 3169343, 3248563, 3327840, 3407175, 3486569, 3566023, 3645538, 3725115
    d24 3804755, 3884459, 3964228, 4044063, 4123965, 4203935, 4283974, 4364083, 4444263, 4524515, 4604840
    d24 4685239, 4765713, 4846263, 4926890, 5007595, 5088379, 5169243, 5250188, 5331215, 5412325, 5493519
    d24 0, 100, 370, 775, 1383, 2295, 3663, 5715, 8793, 13410, 20336 ; id 26
    d24 30725, 43711, 59944, 80235, 105599, 137304, 172972, 210869, 251135, 293918, 339375
    d24 386253, 434596, 484450, 535083, 586507, 638333, 690564, 743203, 796253, 849717, 903599
    d24 957902, 1012629, 1067784, 1123370, 1179390, 1235848, 1292747, 1350091, 1407883, 1466127, 1524826
    d24 1583984, 1643604, 1703274, 1762995, 1822768, 1882594, 1942474, 2002409, 2062400, 2122860, 2183792
    d24 2245200, 2307088, 2369460, 2432807, 2497144, 2562486, 2628849, 2696249, 2764702, 2834225, 2903798
    d24 2973422, 3043098, 3112827, 3182610, 3252448, 3322342, 3392293, 3462302, 3532370, 3602498, 3672687
    d24 3742938, 3813252, 3883630, 3954073, 4024582, 4095158, 4165802, 4236515, 4307298, 4378152, 4449078
    d24 4520077, 4591150, 4662298, 4733522, 4804823, 4876202, 4947660, 5019198, 5090817, 5162518, 5234302
    d24 0, 100, 370, 775, 1383, 2295, 3663, 5715, 8793, 13410, 20336 ; id 27
    d24 30725, 46309, 65789, 87704, 115098, 149341, 187864, 231202, 279957, 328762, 377618
    d24 426526, 475487, 524502, 573572, 622698, 673359, 725603, 778663, 832552, 886862, 941596
    d24 996758, 1052351, 1108378, 1164843, 1221749, 1279100, 1336899, 1395150, 1453856, 1513021, 1572648
    d24 1632741, 1693303, 1754338, 1815850, 1877843, 1940320, 2003285, 2066742, 2130695, 2195148, 2260105
    d24 2326077, 2393080, 2461130, 2531307, 2603677, 2678309, 2754107, 2831089, 2909274, 2988681, 3068138
    d24 3147646, 3227206, 3306819, 3386486, 3466208, 3545986, 3625821, 3705714, 3785666, 3865678, 3945751
    d24 4025886, 4106084, 4186346, 4266673, 4347066, 4427526, 4508054, 4588651, 4669318, 4750056, 4830866
    d24 4911749, 4992706, 5073738, 5154846, 5236031, 5317294, 5398636, 5480058, 5561561, 5643146, 5724814
    d24 0, 100, 370, 775, 1383, 2295, 3663, 5715, 8793, 13410, 20336 ; id 28
    d24 30725, 46309, 65789, 87704, 115098, 149341, 187864, 231202, 279957, 328762, 377618
    d24 426526, 475487, 524502, 573572, 624175, 675569, 727766, 780779, 834206, 888050, 942315
    d24 997004, 1052120, 1107667, 1163648, 1220066, 1276925, 1334228, 1391979, 1450181, 1508838, 1567953
    d24 1627530, 1688038, 1749491, 1811904, 1875292, 1939670, 2005054, 2071460, 2138904, 2207402, 2276970
    d24 2347625, 2419384, 2492264, 2566283, 2641459, 2717810, 2795354, 2874110, 2952916, 3031773, 3110682
    d24 3189644, 3268660, 3347731, 3426858, 3506042, 3585284, 3664585, 3743946, 3823368, 3902852, 3982399
    d24 4062010, 4141686, 4221428, 4301237, 4381114, 4461060, 4541076, 4621163, 4701322, 4781554, 4861860
    d24 4942241, 5022698, 5103232, 5183844, 5264535, 5345306, 5426158, 5507092, 5588109, 5669210, 5750396
    d24 0, 100, 370, 775, 1383, 2295, 3663, 5715, 8793, 13410, 20336 ; id 29
    d24 30725, 46309, 65789, 87704, 115098, 149341, 187864, 231202, 279957, 328762, 377618
    d24 426526, 475487, 524502, 573572, 624175, 675569, 727766, 780779, 834620, 888882, 943568
    d24 998681, 1054225, 1110203, 1166618, 1223474, 1280774, 1338522, 1396721, 1455375, 1514487, 1574061
    d24 1634100, 1696015, 1759865, 1825710, 1893613, 1963638, 2035851, 2110321, 2187118, 2265115, 2344331
    d24 2426023, 2510268, 2597146, 2685381, 2774995, 2867409, 2962711, 3060991, 3159321, 3257702, 3356135
    d24 3454621, 3553161, 3651756, 3750407, 3849115, 3947881, 4046706, 4145591, 4244537, 4343545, 4442616
    d24 4541751, 4640951, 4740217, 4839550, 4938951, 5038421, 5137961, 5237572, 5337255, 5437011, 5536841
    d24 5636746, 5736727, 5836785, 5936921, 6037136, 6137431, 6237807, 6338265, 6438806, 6539431, 6640141
    d24 0, 100, 370, 775, 1383, 2295, 3663, 5715, 8793, 13410, 20336 ; id 30
    d24 30725, 43711, 59944, 80235, 105599, 137304, 176935, 221520, 271678, 321886, 372145
    d24 422456, 472820, 523971, 575921, 628683, 682269, 736692, 791965, 848102, 905116, 963021
    d24 1021831, 1081560, 1142222, 1203832, 1266405, 1329956, 1394500, 1460053, 1526630, 1594247, 1662921
    d24 1732668, 1803505, 1875449, 1948517, 2022727, 2098097, 2174645, 2252389, 2331348, 2411541, 2492987
    d24 2575706, 2659717, 2745041, 2831698, 2919709, 3009095, 3099878, 3192079, 3285721, 3380826, 3477417
    d24 3575517, 3675150, 3774833, 3874567, 3974353, 4074192, 4174085, 4274033, 4374037, 4474098, 4574217
    d24 4674395, 4774633, 4874932, 4975293, 5075717, 5176205, 5276758, 5377377, 5478063, 5578817, 5679640
    d24 5780533, 5881497, 5982533, 6083642, 6184825, 6286083, 6387417, 6488828, 6590317, 6691885, 6793533
    d24 0, 100, 370, 775, 1383, 2295, 3663, 5715, 8793, 13410, 20336 ; id 31
    d24 30725, 46309, 65789, 90139, 117533, 148351, 186874, 230212, 278967, 330769, 385809
    d24 442569, 501103, 561466, 622772, 685036, 748273, 812498, 877727, 943975, 1011258, 1079592
    d24 1148994, 1219480, 1291067, 1363773, 1437615, 1512611, 1588779, 1666137, 1744704, 1824499, 1905541
    d24 1987849, 2071443, 2156343, 2242570, 2330144, 2419086, 2508723, 2599060, 2690103, 2781857, 2874328
    d24 2967521, 3061442, 3156097, 3251491, 3347630, 3444520, 3542167, 3639864, 3737612, 3835412, 3933265
    d24 4031172, 4129134, 4227152, 4325227, 4423360, 4521552, 4619804, 4718117, 4816492, 4914930, 5013432
    d24 5111999, 5210632, 5309332, 5408100, 5506937, 5605844, 5704822, 5803872, 5902995, 6002192, 6101464
    d24 6200812, 6300237, 6399740, 6499322, 6598984, 6698727, 6798552, 6898460, 6998452, 7098529, 7198692

; hTemp0 = an EXP curve (the row of ExpTable, SPECIES_EXP_CURVE of a species; wSpeciesExpCurve after
; LoadSpeciesRecord), hTemp1 = an index into the 99 entries of that row. Copies the 3-byte entry
; (low byte first) to hTemp2, hTemp3 and hTemp4. Entry 0 is level 1, so with hTemp1 = the current
; level of a monster the entry is the experience needed for the next level; the pause-menu status
; page does that with MON_LEVEL. A, BC, E and HL are changed. Callers:
; PauseMenu_Info_Page2_DrawDetails, DrawRecordExperience, RecordReachedNextLevelExp and
; DrawRecordBufBExpAndExpToNextLevel. (C2, E-0379)
; copies the 3 bytes at $4E60 + $129 * hTemp0 + 3 * hTemp1 into hTemp2-hTemp4 (E-0120)
LoadExpTableEntryToTemp2::
    ld bc, $0129
    ldh a, [hTemp0]
    call Multiply8By16
    ldh a, [hTemp1]
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    add hl, bc
    ld a, l
    add LOW(ExpTable)
    ld l, a
    ld a, h
    adc HIGH(ExpTable)
    ld h, a
    ld a, [hli]
    ldh [hTemp2], a
    ld a, [hli]
    ldh [hTemp3], a
    ld a, [hl]
    ldh [hTemp4], a
    ret

SECTION "Bank 19 LoadTableEntryForRecordBufASpeciesToRecordBufAExp", ROMX

; Sets the experience of the monster record in wRecordBufA to the least experience of its level. It
; loads the species record of the species word at MON_SPECIES of wRecordBufA (LoadSpeciesRecord,
; which also leaves wSpeciesIdLo/Hi and wSpeciesRecord set), then copies the 3-byte entry number
; MON_LEVEL - 1 of ExpTable row wSpeciesExpCurve to MON_EXP of wRecordBufA (low byte first).
; Callers: CreateMonsterRecordInSlot_Build and BattleEnd_Records, after the record has its species
; and level. (C2, E-0379)
; loads species record [wRecordBufA + $B] and copies three bytes of table $4E60 entry
; (wSpeciesExpCurve * $129 + 3 * ([wRecordBufA + $56] - 1)) to wRecordBufA + $58 (E-0121) (E-0340:
; the address in its name read as its RAM name; was
; LoadTableEntryForRecordBufASpeciesToRecordBufAExp) (E-0344: the address in its name dropped or
; read as the label there; was LoadTableEntryForRecordBufASpeciesToRecordBufAExp)
LoadTableEntryForRecordBufASpeciesToRecordBufAExp::
    ld a, [wRecordBufA + MON_SPECIES]
    ld l, a
    ld a, [wRecordBufA + MON_SPECIES + 1]
    ld h, a
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesExpCurve]
    ld bc, $0129
    call Multiply8By16
    ld a, [wRecordBufA + MON_LEVEL]
    dec a
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    add hl, bc
    ld a, l
    add LOW(ExpTable)
    ld l, a
    ld a, h
    adc HIGH(ExpTable)
    ld h, a
    ld de, wRecordBufA + MON_EXP
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ret

SECTION "Bank 19 LoadTableEntryForRecordBufBSpeciesToRecordBufBExp", ROMX

; The same as LoadTableEntryForRecordBufASpeciesToRecordBufAExp for the record in wRecordBufB: loads
; the species record of its MON_SPECIES word and copies the 3-byte entry number MON_LEVEL - 1 of
; ExpTable row wSpeciesExpCurve to MON_EXP of wRecordBufB. Its only caller is
; UnpackLinkRecordToRecordBufB. (C2, E-0379)
; loads species record [wRecordBufB + $B] and copies three bytes of table $4E60 entry
; (wSpeciesExpCurve * $129 + 3 * ([wRecordBufB + $56] - 1)) to wRecordBufB + $58 (E-0121) (E-0340:
; the address in its name read as its RAM name; was
; LoadTableEntryForRecordBufBSpeciesToRecordBufBExp) (E-0344: the address in its name dropped or
; read as the label there; was LoadTableEntryForRecordBufBSpeciesToRecordBufBExp)
LoadTableEntryForRecordBufBSpeciesToRecordBufBExp::
    ld a, [wRecordBufB + MON_SPECIES]
    ld l, a
    ld a, [wRecordBufB + MON_SPECIES + 1]
    ld h, a
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesExpCurve]
    ld bc, $0129
    call Multiply8By16
    ld a, [wRecordBufB + MON_LEVEL]
    dec a
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    add hl, bc
    ld a, l
    add LOW(ExpTable)
    ld l, a
    ld a, h
    adc HIGH(ExpTable)
    ld h, a
    ld de, wRecordBufB + MON_EXP
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ret

SECTION "Bank 19 SpeciesNewRecordByteTable", ROMX

; while GameMode4_Init_BuildFoeRecord builds a new monster record, the code reads the byte at $741C
; + wSpeciesId and stores it at the next record byte, right after the zero that follows the copied
; name; 384 bytes, one per species, values 1-7; what the field means is not read (E-0208, C1)
; record: value 1-7 stored in a new monster record
SpeciesNewRecordByteTable::
    db $07 ; id 0
    db $03 ; id 1 DrakSlime
    db $01 ; id 2 SpotSlime
    db $02 ; id 3 WingSlime
    db $01 ; id 4 TreeSlime
    db $01 ; id 5 Snaily
    db $03 ; id 6 SlimeNite
    db $01 ; id 7 Babble
    db $02 ; id 8 BoxSlime
    db $02 ; id 9 PearlGel
    db $01 ; id 10 Slime
    db $02 ; id 11 Healer
    db $03 ; id 12 FangSlime
    db $03 ; id 13 RockSlime
    db $03 ; id 14 SlimeBorg
    db $01 ; id 15 Slabbit
    db $05 ; id 16 KingSlime
    db $04 ; id 17 Metaly
    db $05 ; id 18 Metabble
    db $04 ; id 19 SpotKing
    db $01 ; id 20 TropicGel
    db $04 ; id 21 MimeSlime
    db $04 ; id 22 HaloSlime
    db $05 ; id 23 MetalKing
    db $06 ; id 24 GoldSlime
    db $06 ; id 25 GranSlime
    db $01 ; id 26 WonderEgg
    db $07 ; id 27 Butch
    db $07 ; id 28 ?
    db $07 ; id 29 ?
    db $07 ; id 30 ?
    db $07 ; id 31 ?
    db $07 ; id 32 ?
    db $07 ; id 33 ?
    db $07 ; id 34 ?
    db $07 ; id 35 ?
    db $02 ; id 36 DragonKid
    db $02 ; id 37 Tortragon
    db $02 ; id 38 Pteranod
    db $02 ; id 39 Gasgon
    db $01 ; id 40 FairyDrak
    db $04 ; id 41 LizardMan
    db $01 ; id 42 Poisongon
    db $03 ; id 43 Swordgon
    db $03 ; id 44 Drygon
    db $04 ; id 45 Dragon
    db $01 ; id 46 MiniDrak
    db $04 ; id 47 MadDragon
    db $03 ; id 48 Rayburn
    db $01 ; id 49 Chamelgon
    db $01 ; id 50 LizardFly
    db $02 ; id 51 Andreal
    db $01 ; id 52 KingCobra
    db $02 ; id 53 Vampirus
    db $01 ; id 54 SnakeBat
    db $04 ; id 55 Spikerous
    db $05 ; id 56 GreatDrak
    db $01 ; id 57 Crestpent
    db $01 ; id 58 WingSnake
    db $04 ; id 59 Coatol
    db $05 ; id 60 Orochi
    db $05 ; id 61 BattleRex
    db $05 ; id 62 SkyDragon
    db $06 ; id 63 Serpentia
    db $06 ; id 64 Divinegon
    db $06 ; id 65 Orligon
    db $06 ; id 66 GigaDraco
    db $07 ; id 67 ?
    db $07 ; id 68 ?
    db $07 ; id 69 ?
    db $07 ; id 70 ?
    db $02 ; id 71 Tonguella
    db $01 ; id 72 Almiraj
    db $01 ; id 73 CatFly
    db $01 ; id 74 PillowRat
    db $01 ; id 75 Saccer
    db $05 ; id 76 GulpBeast
    db $01 ; id 77 Skullroo
    db $01 ; id 78 WindBeast
    db $02 ; id 79 Beavern
    db $01 ; id 80 Antbear
    db $02 ; id 81 SuperTen
    db $02 ; id 82 IronTurt
    db $01 ; id 83 Mommonja
    db $01 ; id 84 HammerMan
    db $03 ; id 85 Grizzly
    db $03 ; id 86 Yeti
    db $01 ; id 87 ArrowDog
    db $02 ; id 88 NoctoKing
    db $02 ; id 89 BeastNite
    db $01 ; id 90 MadGopher
    db $01 ; id 91 FairyRat
    db $05 ; id 92 Unicorn
    db $03 ; id 93 Goategon
    db $03 ; id 94 WildApe
    db $04 ; id 95 Trumpeter
    db $06 ; id 96 KingLeo
    db $05 ; id 97 DarkHorn
    db $04 ; id 98 MadCat
    db $04 ; id 99 BigEye
    db $06 ; id 100 Gorago
    db $03 ; id 101 CatMage
    db $05 ; id 102 Dumbira
    db $07 ; id 103 ?
    db $07 ; id 104 ?
    db $07 ; id 105 ?
    db $01 ; id 106 Picky
    db $03 ; id 107 Wyvern
    db $02 ; id 108 BullBird
    db $01 ; id 109 Florajay
    db $03 ; id 110 DuckKite
    db $03 ; id 111 MadPecker
    db $01 ; id 112 MadRaven
    db $02 ; id 113 MistyWing
    db $02 ; id 114 AquaHawk
    db $01 ; id 115 Dracky
    db $01 ; id 116 KiteHawk
    db $01 ; id 117 BigRoost
    db $02 ; id 118 StubBird
    db $02 ; id 119 LandOwl
    db $03 ; id 120 MadGoose
    db $03 ; id 121 MadCondor
    db $03 ; id 122 Emyu
    db $04 ; id 123 Blizzardy
    db $04 ; id 124 Phoenix
    db $04 ; id 125 ZapBird
    db $05 ; id 126 Garudian
    db $05 ; id 127 WhipBird
    db $04 ; id 128 FunkyBird
    db $06 ; id 129 RainHawk
    db $06 ; id 130 Azurile
    db $06 ; id 131 Shantak
    db $03 ; id 132 CragDevil
    db $07 ; id 133 ?
    db $07 ; id 134 ?
    db $07 ; id 135 ?
    db $07 ; id 136 ?
    db $07 ; id 137 ?
    db $07 ; id 138 ?
    db $07 ; id 139 ?
    db $07 ; id 140 ?
    db $01 ; id 141 MadPlant
    db $02 ; id 142 FireWeed
    db $02 ; id 143 FloraMan
    db $01 ; id 144 WingTree
    db $01 ; id 145 CactiBall
    db $02 ; id 146 Gulpple
    db $02 ; id 147 Toadstool
    db $03 ; id 148 AmberWeed
    db $01 ; id 149 Slurperon
    db $02 ; id 150 Stubsuck
    db $01 ; id 151 Oniono
    db $02 ; id 152 DanceVegi
    db $03 ; id 153 TreeBoy
    db $03 ; id 154 Devipine
    db $04 ; id 155 FaceTree
    db $04 ; id 156 HerbMan
    db $03 ; id 157 BeanMan
    db $03 ; id 158 EvilSeed
    db $03 ; id 159 ManEater
    db $04 ; id 160 Snapper
    db $04 ; id 161 GhosTree
    db $06 ; id 162 Rosevine
    db $06 ; id 163 Egdracil
    db $06 ; id 164 Warubou
    db $06 ; id 165 Watabou
    db $01 ; id 166 Eggplaton
    db $03 ; id 167 FooHero
    db $07 ; id 168 ?
    db $07 ; id 169 ?
    db $07 ; id 170 ?
    db $07 ; id 171 ?
    db $07 ; id 172 ?
    db $07 ; id 173 ?
    db $07 ; id 174 ?
    db $07 ; id 175 ?
    db $01 ; id 176 GiantSlug
    db $03 ; id 177 Catapila
    db $01 ; id 178 Gophecada
    db $01 ; id 179 Butterfly
    db $03 ; id 180 WeedBug
    db $01 ; id 181 GiantWorm
    db $02 ; id 182 Lipsy
    db $02 ; id 183 StagBug
    db $02 ; id 184 Pyuro
    db $01 ; id 185 ArmyAnt
    db $01 ; id 186 GoHopper
    db $01 ; id 187 TailEater
    db $03 ; id 188 ArmorPede
    db $02 ; id 189 Eyeder
    db $03 ; id 190 GiantMoth
    db $03 ; id 191 Droll
    db $04 ; id 192 ArmyCrab
    db $03 ; id 193 MadHornet
    db $02 ; id 194 Belzebub
    db $05 ; id 195 WarMantis
    db $05 ; id 196 HornBeet
    db $04 ; id 197 Sickler
    db $05 ; id 198 Armorpion
    db $05 ; id 199 Digster
    db $06 ; id 200 Skularach
    db $04 ; id 201 MultiEyes
    db $07 ; id 202 ?
    db $07 ; id 203 ?
    db $07 ; id 204 ?
    db $07 ; id 205 ?
    db $07 ; id 206 ?
    db $07 ; id 207 ?
    db $07 ; id 208 ?
    db $07 ; id 209 ?
    db $07 ; id 210 ?
    db $01 ; id 211 Pixy
    db $02 ; id 212 MedusaEye
    db $04 ; id 213 AgDevil
    db $01 ; id 214 Demonite
    db $01 ; id 215 DarkEye
    db $02 ; id 216 EyeBall
    db $04 ; id 217 SkulRider
    db $04 ; id 218 EvilBeast
    db $04 ; id 219 Bubblemon
    db $01 ; id 220 1EyeClown
    db $01 ; id 221 Gremlin
    db $05 ; id 222 ArcDemon
    db $04 ; id 223 Lionex
    db $05 ; id 224 GoatHorn
    db $04 ; id 225 Orc
    db $05 ; id 226 Ogre
    db $04 ; id 227 GateGuard
    db $04 ; id 228 ChopClown
    db $05 ; id 229 BossTroll
    db $05 ; id 230 Grendal
    db $05 ; id 231 Akubar
    db $05 ; id 232 MadKnight
    db $04 ; id 233 EvilWell
    db $04 ; id 234 Gigantes
    db $05 ; id 235 Centasaur
    db $05 ; id 236 EvilArmor
    db $06 ; id 237 Jamirus
    db $06 ; id 238 Durran
    db $06 ; id 239 Titanis
    db $05 ; id 240 LampGenie
    db $07 ; id 241 ?
    db $07 ; id 242 ?
    db $07 ; id 243 ?
    db $07 ; id 244 ?
    db $07 ; id 245 ?
    db $01 ; id 246 Spooky
    db $06 ; id 247 Skullgon
    db $02 ; id 248 PutrePup
    db $01 ; id 249 RotRaven
    db $02 ; id 250 Mummy
    db $03 ; id 251 DarkCrab
    db $03 ; id 252 DeadNite
    db $02 ; id 253 Shadow
    db $02 ; id 254 Skulpent
    db $03 ; id 255 Hork
    db $01 ; id 256 Mudron
    db $02 ; id 257 NiteWhip
    db $02 ; id 258 WindMerge
    db $03 ; id 259 Reaper
    db $01 ; id 260 Inverzon
    db $01 ; id 261 FoxFire
    db $03 ; id 262 CaptDead
    db $06 ; id 263 DeadNoble
    db $06 ; id 264 WhiteKing
    db $03 ; id 265 BoneSlave
    db $04 ; id 266 Skeletor
    db $05 ; id 267 Servant
    db $06 ; id 268 Lazamanus
    db $03 ; id 269 Copycat
    db $03 ; id 270 MadSpirit
    db $04 ; id 271 PomPomBom
    db $06 ; id 272 Niterich
    db $07 ; id 273 ?
    db $07 ; id 274 ?
    db $07 ; id 275 ?
    db $07 ; id 276 ?
    db $07 ; id 277 ?
    db $07 ; id 278 ?
    db $07 ; id 279 ?
    db $07 ; id 280 ?
    db $02 ; id 281 JewelBag
    db $02 ; id 282 EvilWand
    db $01 ; id 283 MadCandle
    db $01 ; id 284 CoilBird
    db $01 ; id 285 Facer
    db $01 ; id 286 SpikyBoy
    db $03 ; id 287 MadMirror
    db $04 ; id 288 RogueNite
    db $02 ; id 289 Puppetor
    db $01 ; id 290 Goopi
    db $04 ; id 291 Voodoll
    db $05 ; id 292 MetalDrak
    db $03 ; id 293 Balzak
    db $02 ; id 294 SabreMan
    db $01 ; id 295 CurseLamp
    db $01 ; id 296 Brushead
    db $04 ; id 297 Roboster
    db $05 ; id 298 Roboster2
    db $03 ; id 299 EvilPot
    db $02 ; id 300 Gismo
    db $04 ; id 301 LavaMan
    db $05 ; id 302 IceMan
    db $04 ; id 303 Mimic
    db $03 ; id 304 Exaucers
    db $01 ; id 305 MudDoll
    db $04 ; id 306 Golem
    db $04 ; id 307 StoneMan
    db $04 ; id 308 BombCrag
    db $06 ; id 309 GoldGolem
    db $06 ; id 310 DarkMate
    db $04 ; id 311 ProtoMech
    db $06 ; id 312 CloudKing
    db $07 ; id 313 ?
    db $07 ; id 314 ?
    db $07 ; id 315 ?
    db $01 ; id 316 Petiteel
    db $01 ; id 317 Moray
    db $03 ; id 318 WalrusMan
    db $03 ; id 319 RayGigas
    db $02 ; id 320 Anemon
    db $02 ; id 321 Aquarella
    db $04 ; id 322 Merman
    db $01 ; id 323 Octokid
    db $03 ; id 324 PutreFish
    db $02 ; id 325 Octoreach
    db $01 ; id 326 Angleron
    db $04 ; id 327 FishRider
    db $03 ; id 328 RushFish
    db $01 ; id 329 Gamanian
    db $03 ; id 330 Clawster
    db $04 ; id 331 CancerMan
    db $02 ; id 332 RogueWave
    db $01 ; id 333 Scallopa
    db $04 ; id 334 SeaHorse
    db $04 ; id 335 HoodSquid
    db $05 ; id 336 MerTiger
    db $05 ; id 337 AxeShark
    db $05 ; id 338 Octogon
    db $06 ; id 339 KingSquid
    db $06 ; id 340 Digong
    db $05 ; id 341 WhaleMage
    db $06 ; id 342 Aquadon
    db $06 ; id 343 Octoraid
    db $06 ; id 344 Grakos
    db $06 ; id 345 Poseidon
    db $04 ; id 346 Pumpoise
    db $03 ; id 347 Starfish
    db $07 ; id 348 ?
    db $07 ; id 349 ?
    db $07 ; id 350 ?
    db $07 ; id 351 DracoLord
    db $07 ; id 352 DracoLord
    db $07 ; id 353 LordDraco
    db $07 ; id 354 Hargon
    db $07 ; id 355 Sidoh
    db $07 ; id 356 Genosidoh
    db $07 ; id 357 Baramos
    db $07 ; id 358 Zoma
    db $07 ; id 359 AsuraZoma
    db $07 ; id 360 Pizzaro
    db $07 ; id 361 PsychoPiz
    db $07 ; id 362 Esterk
    db $07 ; id 363 Mirudraas
    db $07 ; id 364 Mirudraas
    db $07 ; id 365 Mudou
    db $07 ; id 366 DeathMore
    db $07 ; id 367 DeathMore
    db $07 ; id 368 DeathMore
    db $07 ; id 369 Darkdrium
    db $07 ; id 370 Orgodemir
    db $07 ; id 371 Orgodemir
    db $07 ; id 372 Darck
    db $07 ; id 373 Tatsu
    db $07 ; id 374 Diago
    db $07 ; id 375 Samsi
    db $07 ; id 376 Bazoo
    db $07 ; id 377 ?
    db $07 ; id 378 ?
    db $07 ; id 379 ?
    db $07 ; id 380 Lamia
    db $07 ; id 381 Dimensaur
    db $07 ; id 382 Kagebou
    db $07 ; id 383 ?
    ds $a64, $00
