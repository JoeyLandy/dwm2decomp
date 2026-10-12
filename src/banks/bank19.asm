SECTION "Bank 19", ROMX[$4000], BANK[$19]
    db $19

; only called from GameMode4_Init (E-0047)
; 1 call site from 1 routine (e.g. GameMode4_Init)
; reads: wBattleKind, wDataBank, wLinkMode, wBattlerRecordSlot4, wBattlerRecordSlot5, wBattlerRecordSlot6
; writes: wDataBankSave, wBattleKind, rRAMG, rRAMB, wBattleInitA1, wBattleInitA2, wBattleInitA3
; points at: wEffectAnimState, wBattlePhase, wListPageSize, wWorkBuf
GameMode4_Init_FillBytes::
Func_019_4001:: ; address name
    ld a, [wBattleKind]
    push af
    ld hl, wEffectAnimState
    ld bc, $0303
    xor a, a
    call FillBytes
    ld a, [wDataBank]
    ld [wDataBankSave], a
    ld hl, wBattlePhase
    ld bc, $0008
    xor a, a
    call FillBytes
    ld hl, wListPageSize
    ld bc, $0008
    xor a, a
    call FillBytes
    pop af
    ld [wBattleKind], a
    call GameMode4_Init_Sub01_FillBytes
    ld a, [wLinkMode]
    or a, a
    jr nz, .call_game_mode4_init_sub01_write_species_id
    ld hl, wWorkBuf
    ld bc, $0200
    xor a, a
    call FillBytes
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    call GameMode4_Init_Sub01_ReadBattlePartyCount
    call GameMode4_Init_Sub01_LoadMonsterAndSpeciesForListEntryC
    ld a, [wBattlerRecordSlot4 + $4D]
    ld [wBattleInitA1], a
    ld a, [wBattlerRecordSlot5 + $4D]
    ld [wBattleInitA2], a
    ld a, [wBattlerRecordSlot6 + $4D]
    ld [wBattleInitA3], a
    ld a, $00
    ld [rRAMG], a
    jr .call_game_mode4_init_sub01_write_species_id

.call_game_mode4_init_sub01_write_species_id:
    call GameMode4_Init_Sub01_WriteSpeciesIdLoAndSpeciesIdHi
    call GameMode4_Init_Sub01_ClearAttributesAndScreenBuffer_Bank31
    call GameMode4_Init_Sub01_Sub03_LoadMonsterPicture_Sub03
    call GameMode4_Init_Sub01_QueueMusic
    call GameMode4_Init_Sub01_CarryUnlessBattleSlotOutSlotEmpty
    ret

; only called from GameMode4_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode4_Init_FillBytes)
; reads: wBattleKind, wLinkMode, wPartyCount, wEncounterKind, wBattleResultByte, wMenuSaveByte34, wLinkRole
; writes: wBattleSetupD7, wEffectId, wQueuedActionId, wBattleByteAD, wBattleFlag92, wDebugValue3, wDebugState, wDebugSubState, ...
; points at: wMenuState, wSlotMarks, wSideControl, wBattleSlotOut, wBattleMonsterId, wSlotNameBytes, wActionQueue
GameMode4_Init_Sub01_FillBytes::
Func_019_4079:: ; address name
    ld a, [wBattleKind]
    cp a, $04
    jr z, .set_battle_setup_d7_to_01
    cp a, $05
    jr z, .set_battle_setup_d7_to_01
    cp a, $09
    jr z, .set_battle_setup_d7_to_01
    xor a, a
    jr .set_battle_setup_d7

.set_battle_setup_d7_to_01:
    ld a, $01

.set_battle_setup_d7:
    ld [wBattleSetupD7], a
    ld a, $FF
    ld [wEffectId], a
    ld [wQueuedActionId], a
    ld [wBattleByteAD], a
    ld [wBattleFlag92], a
    ld hl, wMenuState
    ld bc, $0008
    xor a, a
    call FillBytes
    xor a, a
    ld [wDebugValue3], a
    ld [wDebugState], a
    ld [wDebugSubState], a
    ld hl, wSlotMarks
    ld bc, $0008
    ld a, $FF
    call FillBytes
    ld hl, wSideControl
    ld bc, $0008
    ld a, $80
    call FillBytes
    ld hl, wBattleSlotOut
    ld bc, $0008
    ld a, $FF
    call FillBytes
    ld hl, wBattleMonsterId
    ld bc, $0010
    ld a, $FF
    call FillBytes
    ld a, $FF
    ld hl, wBattleSkills + $7F
    ld bc, $0080
    call FillBytes
    ld a, $FF
    ld hl, wSlotNameBytes
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, $FF
    ld [wDisplaySlot], a
    ld a, $0A
    ld [wBattleMeter], a
    ld hl, wActionQueue
    ld bc, $000A
    ld a, $FF
    call FillBytes
    xor a, a
    ld [wBattleTurn], a
    ld a, $00
    ld [wBattleScene], a
    xor a, a
    ld [wBattleSetupD8], a
    ld [wBattleSetupD8 + $1], a
    ld [wBattleSetupD8 + $2], a
    ld a, [wLinkMode]
    or a, a
    jr nz, .set_battle_kind_flags_to_03
    ld a, [wPartyCount]
    ld [wBattlePartyCount], a
    ld [wSide0Flag], a
    ld a, [wEncounterKind]
    inc a
    ld [wBattleFoeCount], a
    ld [wSide1Flag], a
    ld a, [wBattleResultByte]
    ld [wBattleSetupDB], a
    ld a, [wMenuSaveByte34]
    ld [wBattleKindFlags], a
    jr .clear_link_rule_work57

.set_battle_kind_flags_to_03:
    ld a, $03
    ld [wBattleKindFlags], a
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .call_game_mode4_init_sub01_sub01_sub01
    ld hl, wBattlerRecords + $17
    call GameMode4_Init_Sub01_Sub01_Sub01
    ld [wBattlePartyCount], a
    ld [wSide0Flag], a
    ld hl, wBattlerRecordSlot4 + $17
    call GameMode4_Init_Sub01_Sub01_Sub01
    ld [wBattleFoeCount], a
    ld [wSide1Flag], a
    jr .clear_link_rule_work57

.call_game_mode4_init_sub01_sub01_sub01:
    ld hl, wBattlerRecords + $17
    call GameMode4_Init_Sub01_Sub01_Sub01
    ld [wBattleFoeCount], a
    ld [wSide0Flag], a
    ld hl, wBattlerRecordSlot4 + $17
    call GameMode4_Init_Sub01_Sub01_Sub01
    ld [wBattlePartyCount], a
    ld [wSide1Flag], a

.clear_link_rule_work57:
    xor a, a
    ld [wLinkRuleWork57], a
    ld [wBattleInitByte58], a
    ret

; only called from GameMode4_Init_Sub01_Sub01 (E-0047)
; 4 call sites from 1 routine (e.g. GameMode4_Init_Sub01_FillBytes)
GameMode4_Init_Sub01_Sub01_Sub01::
Func_019_4186:: ; address name
    ld de, $004E
    ld c, $01
    add hl, de
    ld a, [hl]
    or a, a
    jr z, .done
    ld c, $02
    add hl, de
    ld a, [hl]
    or a, a
    jr z, .done
    ld c, $03

.done:
    ld a, c
    ret

; only called from GameMode4_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode4_Init_FillBytes)
; writes: wBGPaletteUploadRequest
GameMode4_Init_Sub01_ClearAttributesAndScreenBuffer_Bank31::
Func_019_419B:: ; address name
    farcall GameMode4_Init_Sub01_Sub02_CopyGlyphTilesToVRAM
    farcall ClearAttributesAndScreenBuffer_Bank31
    farcall CopyRectRecordForBattlePartyCount_Bank31
    farcall LayoutTileBlocksForBattleFoeCount
    farcall DrawPartySlotStatusPanels
    farcall LoadBattleMonsterPictureAttributes
    ld hl, vBGMap0
    call CopyScreenTileBufferToVRAM_A0_Bank19
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    ret

; only called from GameMode4_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode4_Init_FillBytes)
; reads: wLinkRole, wBattleFoeCount
GameMode4_Init_Sub01_Sub03_LoadMonsterPicture_Sub03::
Func_019_41CB:: ; address name
    ld de, wBattlerRecordSlot4 + $A
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_game_mode4_init_sub01_sub03_load_monster
    ld de, wBattlerRecords + $A

.call_game_mode4_init_sub01_sub03_load_monster:
    ld hl, vTiles2 + $140
    ld c, $01
    call GameMode4_Init_Sub01_Sub03_LoadMonsterPicture
    ld a, [wBattleFoeCount]
    cp a, $01
    jr z, .return
    ld de, wBattlerRecordSlot5 + $A
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_game_mode4_init_sub01_sub03_load_monster2
    ld de, wBattlerRecordSlot1 + $A

.call_game_mode4_init_sub01_sub03_load_monster2:
    ld hl, vTiles2 + $380
    ld c, $03
    call GameMode4_Init_Sub01_Sub03_LoadMonsterPicture
    ld a, [wBattleFoeCount]
    cp a, $02
    jr z, .return
    ld de, wBattlerRecordSlot6 + $A
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_game_mode4_init_sub01_sub03_load_monster3
    ld de, wBattlerRecordSlot2 + $A

.call_game_mode4_init_sub01_sub03_load_monster3:
    ld hl, vTiles2 + $5C0
    ld c, $05
    call GameMode4_Init_Sub01_Sub03_LoadMonsterPicture

.return:
    ret

; only called from GameMode4_Init_Sub01_Sub03 (E-0047)
; 3 call sites from 1 routine (e.g. GameMode4_Init_Sub01_Sub03_LoadMonsterPicture_Sub03)
GameMode4_Init_Sub01_Sub03_LoadMonsterPicture::
Func_019_4219:: ; address name
    ld a, [de]
    push af
    inc de
    ld a, [de]
    ld d, a
    pop af
    ld e, a
    call LoadMonsterPicture
    ret

; only called from GameMode4_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode4_Init_FillBytes)
; reads: wBattlePartyCount, wLinkRole, wBattleFoeCount, wSpeciesRecord
; writes: wSpeciesIdLo, wSpeciesIdHi
; points at: wSlotDamageFlags, wBattleSlotOut, wBattleMonsterId
GameMode4_Init_Sub01_WriteSpeciesIdLoAndSpeciesIdHi::
Func_019_4224:: ; address name
    ld a, [wBattlePartyCount]
    ld b, a
    ld c, $00
    ld a, [wLinkRole]
    bit 1, a
    jr z, .loop
    ld a, [wBattleFoeCount]
    ld b, a

.loop:
    call GameMode4_Init_Sub01_Sub04_LoadBattleSlotFromBattlerRecord_4BA8
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
    call GameMode4_Init_Sub01_Sub04_LoadBattleSlotFromBattlerRecord_4BA8
    inc c
    dec b
    jr nz, .loop2
    call AdjustSkillsForBattleStart
    ld de, wSlotDamageFlags
    ld bc, $0800

.loop3:
    push bc
    ld a, c
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jr z, .restore
    ld a, c
    add a, a
    ld hl, wBattleMonsterId
    add_a_to_hl
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    push de
    farcall LoadSpeciesRecord
    pop de
    ld a, [wSpeciesRecord + $3]
    ld h, a
    ld a, [wSpeciesRecord + $2]
    swap a
    or a, h
    ld [de], a

.restore:
    pop bc
    inc de
    inc c
    dec b
    jr nz, .loop3
    ret

; wDA53[C] = 0-4 by slot C's INT: below 30, 100, 550, 900, or more (E-0127)
; 8 call sites from 8 routines (e.g. LoadBattleSlotFromBattlerRecord_4CF8, LoadBattleSlotFromBattlerRecord_4BA8, RecomputeTargetMaxHPAndMP, ResolveStepDamageMessage_Sub04_ShowHeroTurnedBackTo, ...)
; points at: wSlotAIMode, wBattleINT
SetSlotAIModeFromINT::
Func_019_4298:: ; address name
    push bc
    ld a, c
    ld hl, wSlotAIMode
    add_a_to_hl
    push hl
    ld a, c
    ld hl, wBattleINT
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    sub a, $1E
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    jr c, .skip4
    ld a, l
    sub a, $46
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    jr c, .skip3
    ld a, l
    sub a, $C2
    ld l, a
    ld a, h
    sbc a, $01
    ld h, a
    jr c, .skip2
    ld a, l
    sub a, $5E
    ld l, a
    ld a, h
    sbc a, $01
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

; zero-fills the 47 bytes of wSpeciesRecord, where LoadSpeciesRecord writes; BC, HL kept (E-0067) (the same 15 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01_Sub04_LoadBattleSlotFromBattlerRecord_4BA8)
; points at: wSpeciesRecord
ClearSpeciesRecordBuffer_Bank19::
Func_019_42EE:: ; address name
    push bc
    push hl
    ld hl, wSpeciesRecord
    ld bc, $002F
    xor a, a
    call FillBytes
    pop hl
    pop bc
    ret

; outside link and special battles stores a random value between 80 and 100 percent of the word at HL into BC's target (E-0127)
; 1 call site from 1 routine (e.g. LoadBattleSlotFromBattlerRecord_4CF8)
; reads: wBattleKind, wLinkMode, wRandomLo, wRandomHi
RandomizeWordBetween80And100Percent::
Func_019_42FD:: ; address name
    ld a, [wBattleKind]
    cp a, $02
    ret z
    cp a, $03
    ret z
    cp a, $05
    ret z
    ld a, [wLinkMode]
    or a, a
    ret nz
    push bc
    push hl
    ld a, [hl+]
    ld h, [hl]
    ld b, h
    ld l, a
    ld c, a
    call ScaleHLToEightTenths_Bank19
    ld a, c
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
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
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
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

; C = wD868, then falls into Func_019_434D (E-0126)
; 4 call sites from 4 routines (e.g. LoadBattleSlotFromBattlerRecord_4CF8, LoadBattleSlotFromBattlerRecord_4BA8, RunA04410Or456FBySlotC_BattlerRecordAddress_BankA0, RunA04410Or456FBySlotC_BattlerRecordAddress_BankA0_Sub02)
; reads: wBattleArg0, wBattleArg2, wBattleArg3
; writes: wRecordBuffer, wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3
; points at: wBattleSkillsPrefix, wBattleSkills
SetCFromBattleArg0ThenRunLoadSlotSkillsFromBattlerRecord::
Func_019_4349:: ; address name
    ld a, [wBattleArg0]
    ld c, a

; for slot C clears its skill list and copies the skills from its 78-byte battler record, then loads each skill record (with wD868 = 3) (E-0130)
; 6 call sites from 6 routines (e.g. LoadBattleSlotFromBattlerRecord_4CF8, LoadBattleSlotFromBattlerRecord_4BA8, RecomputeTargetMaxHPAndMP, ResolveStepDamageMessage_Sub04_ShowHeroTurnedBackTo, ...)
; reads: wBattleArg0, wBattleArg2, wBattleArg3
; writes: wRecordBuffer, wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3
; points at: wBattleSkillsPrefix, wBattleSkills
LoadSlotSkillsFromBattlerRecord::
Func_019_434D:: ; address name
    ld hl, wBattleSkillsPrefix
    ld a, c
    swap a
    add_a_to_hl
    ld b, $08

.loop:
    ld a, $00
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    dec b
    jr nz, .loop
    push bc
    ld a, c
    cp a, $04
    jr c, .call_multiply8
    dec a
    ld c, a

.call_multiply8:
    ld a, $4E
    call Multiply8
    pop bc
    ld a, l
    add a, $E3
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ld de, wBattleSkills
    ld a, c
    swap a
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld b, $08

.loop2:
    ld a, [hl+]
    ld [de], a
    inc de
    inc de
    ld a, [hl]
    or a, a
    jr z, .skip2
    cp a, $FF
    jr z, .skip2
    dec b
    jr nz, .loop2

.skip2:
    ld a, c
    ld de, wBattleSkills
    swap a
    add a, e
    ld e, a
    jr nc, .read_battle_arg0
    inc d

.read_battle_arg0:
    ld b, $08
    ld a, [wBattleArg0]
    push af
    xor a, a
    ld [wRecordBuffer + $1], a

.loop3:
    ld a, [de]
    cp a, $FF
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
    and a, $0F
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
    or a, a
    call nz, AdjustSkillsForBattleStart
    ret

; replaces skill $8F by $AA for slots without wD8AF set; outside link battles marks skills $34 and $35 of the foe slots with tiles $AD and $AE (E-0127)
; 2 call sites from 2 routines (e.g. LoadSlotSkillsFromBattlerRecord, GameMode4_Init_Sub01_WriteSpeciesIdLoAndSpeciesIdHi)
; reads: wLinkMode
; points at: wSlotNameSuffix, wBattleSkills
AdjustSkillsForBattleStart::
Func_019_43ED:: ; address name
    ld bc, $0800
    ld hl, wSlotNameSuffix

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, [hl]
    or a, a
    call z, ReplaceSkill8FWithAAInSlotC

.next:
    inc c
    inc hl
    dec b
    jr nz, .loop
    ld a, [wLinkMode]
    or a, a
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
    cp a, $FF
    jr z, .next3
    cp a, $34
    jr nz, .cp_35
    call StoreTileADAtHL
    jr .next2

.cp_35:
    cp a, $35
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

; in slot C's skill list replaces the first skill $8F by $AA, stopping at $FF (E-0124)
; 1 call site from 1 routine (e.g. AdjustSkillsForBattleStart)
; points at: wBattleSkills
ReplaceSkill8FWithAAInSlotC::
Func_019_4440:: ; address name
    push hl
    ld a, c
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld d, $08

.loop:
    ld a, [hl]
    cp a, $FF
    jr z, .done
    cp a, $8F
    jr nz, .next
    ld [hl], $AA

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

; [HL] = $AD (E-0114)
; 1 call site from 1 routine (e.g. AdjustSkillsForBattleStart)
StoreTileADAtHL::
Func_019_4462:: ; address name
    ld [hl], $AD
    ret

; [HL] = $AE (E-0114)
; 1 call site from 1 routine (e.g. AdjustSkillsForBattleStart)
StoreTileAEAtHL::
Func_019_4465:: ; address name
    ld [hl], $AE
    ret

; slot C: wBattleSlotOut = 1 when bit 7 of [HL] is set; otherwise 0 and, unless wCFC5 = 4, the status byte gets $20 for bit 0 and bit 0 for bit 2 (E-0125)
; 2 call sites from 2 routines (e.g. LoadBattleSlotFromBattlerRecord_4CF8, LoadBattleSlotFromBattlerRecord_4BA8)
; reads: wBattleKind
; points at: wBattleSlotOut, wBattleStatus
InitSlotOutAndStatusFromRecordFlags::
Func_019_4468:: ; address name
    push hl
    ld a, c
    ld de, wBattleSlotOut
    add a, e
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
    cp a, $04
    jr z, .done
    ld a, c
    ld de, wBattleStatus
    add a, a
    add a, a
    add a, a
    add a, c
    add a, e
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
    or a, $01
    ld [de], a

.done:
    pop hl
    ret

; DE += C; copies the byte at HL to [DE]; HL += 1 (the same 9 bytes appear in 2 banks)
; 10 call sites from 2 routines (e.g. LoadBattleSlotFromBattlerRecord_4CF8, LoadBattleSlotFromBattlerRecord_4BA8)
StoreByteAtDEPlusC_Bank19::
Func_019_44A3:: ; address name
    ld a, c
    add a, e
    ld e, a
    jr nc, .done
    inc d

.done:
    ld a, [hl+]
    ld [de], a
    ret

; DE += 2 * C; copies the word at HL to [DE]; HL += 2, DE ends on the second byte written (the same 13 bytes appear in 2 banks)
; 22 call sites from 2 routines (e.g. LoadBattleSlotFromBattlerRecord_4CF8, LoadBattleSlotFromBattlerRecord_4BA8)
StoreWordAtDEPlus2C_Bank19::
Func_019_44AC:: ; address name
    ld a, c
    add a, a
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ret

; HL = the word wD868, DE = the word wD86A, then falls into Func_019_44C9 (E-0126)
; 7 call sites from 7 routines (e.g. RecomputeTargetMaxHPAndMP, RecomputeTargetStatsFromRecord, ActionEffect_Transform_Sub01_SlotSpeciesNibblesD00AD00B_Sub01, ActionEffect_TatsuCall_AddAx9ToHL, ...)
; reads: wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3
LoadBattleArg0PointersThenRunPackResistanceFieldsToDE::
Func_019_44B9:: ; address name
    ld a, [wBattleArg0]
    ld l, a
    ld a, [wBattleArg1]
    ld h, a
    ld a, [wBattleArg2]
    ld e, a
    ld a, [wBattleArg3]
    ld d, a

; packs the 2-bit fields at HL (and bits 0-1 of byte $1A) into the 7-byte wDA72-style record at DE (E-0127)
; 2 call sites from 2 routines (e.g. LoadBattleSlotFromBattlerRecord_4CF8, LoadBattleSlotFromBattlerRecord_4BA8)
PackResistanceFieldsToDE::
Func_019_44C9:: ; address name
    push hl
    ld a, $1A
    add_a_to_hl
    ld a, [hl]
    and a, $03
    rrc a
    rrc a
    ld c, a
    pop hl
    ld a, [hl+]
    sla a
    sla a
    or a, [hl]
    inc hl
    sla a
    sla a
    or a, [hl]
    inc hl
    or a, c
    ld [de], a
    inc de
    ld b, $05

.loop:
    ld a, [hl+]
    sla a
    sla a
    or a, [hl]
    inc hl
    sla a
    sla a
    or a, [hl]
    inc hl
    sla a
    sla a
    or a, [hl]
    inc hl
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld a, [hl+]
    sla a
    sla a
    or a, [hl]
    inc hl
    sla a
    sla a
    or a, [hl]
    sla a
    sla a
    ld [de], a
    ret

; the same 33 bytes as CopyScreenTileBufferToVRAM_A0 (A0:42B2)
; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01_ClearAttributesAndScreenBuffer_Bank31)
; points at: wScreenTileBuffer
CopyScreenTileBufferToVRAM_A0_Bank19::
Func_019_4516:: ; address name
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
    ld a, $0C
    add a, e
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

; HL = (HL * 8) / 10 with 16-bit arithmetic (the multiply can overflow above 8191); BC and DE kept (E-0118)
; 1 call site from 1 routine (e.g. RandomizeWordBetween80And100Percent)
ScaleHLToEightTenths_Bank19::
Func_019_4537:: ; address name
    push bc
    push de
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, $0A
    call DivideHLByA
    pop de
    pop bc
    ret

; only called from GameMode4_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode4_Init_FillBytes)
; reads: wBattleKind
GameMode4_Init_Sub01_QueueMusic::
Func_019_4544:: ; address name
    ld a, [wBattleKind]
    or a, a
    jr z, .skip
    dec a
    jr nz, .call_queue_music

.skip:
    ld a, $0F
    jr .call_queue_music2

.call_queue_music:
    ld a, $13

.call_queue_music2:
    call QueueMusic
    ret

; only called from GameMode4_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode4_Init_FillBytes)
; reads: wBattlePartyCount
; points at: wBattlerRecords
GameMode4_Init_Sub01_ReadBattlePartyCount::
Func_019_4557:: ; address name
    ld a, [wBattlePartyCount]
    ld b, a
    ld c, $00
    ld de, wBattlerRecords

.loop:
    push bc
    call GameMode4_Init_Sub01_Sub06_SRAMRecordAddressMapped
    pop bc
    inc c
    dec b
    jr nz, .loop
    ret

; only called from GameMode4_Init_Sub01_Sub06 (E-0047)
; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01_ReadBattlePartyCount)
GameMode4_Init_Sub01_Sub06_SRAMRecordAddressMapped::
Func_019_456A:: ; address name
    ld a, c
    ld c, $01
    call SRAMRecordAddressMapped
    ld b, $0A

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, l
    add a, $25
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $08

.loop2:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop2
    ld a, l
    add a, $19
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $15

.loop3:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop3
    ld a, l
    add a, $02
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $04

.loop4:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop4
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $1B

.loop5:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop5
    ld a, l
    add a, $16
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    ld [de], a
    call ApplyIncrementOffsetRows19ForA0DTo13
    inc de
    ld a, $FF
    ld [de], a
    inc de
    ret

; for A in $0D-$13 increments (capped at 3) each byte listed in Data_019_4641 row A - $0D, relative to DE (E-0125)
; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01_Sub06_SRAMRecordAddressMapped)
; writes: hTemp0, hTemp1
ApplyIncrementOffsetRows19ForA0DTo13::
Func_019_4605:: ; address name
    or a, a
    ret z
    cp a, $0D
    ret c
    cp a, $14
    ret nc
    push af
    ld a, e
    ldh [hTemp0], a
    ld a, d
    ldh [hTemp1], a
    pop af
    push de
    sub a, $0D
    swap a
    ld de, IncrementOffsetRows_19
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    cp a, $80
    jr nz, .call_increment_table_byte_capped_at3
    pop de
    ret

.call_increment_table_byte_capped_at3:
    ld l, a
    ld h, $FF
    call IncrementTableByteCappedAt3
    inc de
    jr .skip

; increments the byte at HL + the word hFFC6/hFFC7 unless it is already 3 or more (E-0118)
; 1 call site from 1 routine (e.g. ApplyIncrementOffsetRows19ForA0DTo13)
; reads: hTemp0, hTemp1
IncrementTableByteCappedAt3::
Func_019_4632:: ; address name
    ldh a, [hTemp0]
    add a, l
    ld l, a
    ldh a, [hTemp1]
    adc a, h
    ld h, a
    ld a, [hl]
    cp a, $03
    ret nc
    inc a
    ld [hl], a
    ret

; E-0236 (C1: ApplyIncrementOffsetRows19ForA0DTo13 takes A in $0D-$13, reads row 16 * (A - $0D) and for each byte before $80 increments the byte at DE + $FF00 + byte, capped at 3 (IncrementTableByteCappedAt3); 7 rows; the bank $19 and $A0 copies are identical).
; record: offsets ($FF00 + byte, added to the base in DE) of the bytes to increment, up to $80, then zero padding
IncrementOffsetRows_19::
Data_019_4641:: ; address name
    db $E5, $E6, $E7, $E8, $E9, $EA, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 13
    db $F5, $F6, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 14
    db $EC, $F0, $F7, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 15
    db $EC, $F0, $F7, $F8, $F9, $EB, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 16
    db $EC, $F0, $F7, $F8, $F9, $ED, $F3, $EB, $EF, $80, $00, $00, $00, $00, $00, $00 ; id 17
    db $FF, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 18
    db $FA, $FB, $FC, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 19

; only called from BattleEnd_Step3_Sub06_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3_Sub06_Sub01_LoadMonsterAndSpeciesForListEntryC_Sub01)
; reads: wDisplaySlot
; points at: wBattlerRecordSlot5, wBattlerRecordSlot4
BattleEnd_Step3_Sub06_Sub01_LoadMonsterAndSpeciesForListEntryC::
Func_019_46B1:: ; address name
    ld de, wBattlerRecordSlot5
    ld a, [wDisplaySlot]
    and a, $03
    ld c, a
    cp a, $01
    jr z, .skip
    ld de, wBattlerRecordSlot4

.skip:
    push de
    ld a, e
    add a, $0D
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, [de]
    pop de
    push af
    push de
    call LoadMonsterAndSpeciesForListEntryC
    pop de
    ld a, e
    add a, $0D
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop af
    ld [de], a
    ret

; only called from GameMode4_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode4_Init_FillBytes)
; reads: wBattleFoeCount, wBattleKind
; points at: wBattlerRecordSlot4
GameMode4_Init_Sub01_LoadMonsterAndSpeciesForListEntryC::
Func_019_46DD:: ; address name
    ld a, [wBattleFoeCount]
    ld b, a
    ld c, $00
    ld de, wBattlerRecordSlot4
    ld a, [wBattleKind]
    cp a, $05
    jr z, .loop
    and a, $01
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
    call GameMode4_Init_Sub01_Sub07_WriteBattleArg2AndBattleArg3Etc
    pop bc
    inc c
    ld a, e
    add a, $4E
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, .loop2
    ret

; loads monster wCFDD[C] (LoadMonsterRecord), runs Func_019_4A9A, loads the species named in wRecordBuffer, then runs Func_019_4B37 (E-0121)
; 2 call sites from 2 routines (e.g. GameMode4_Init_Sub01_LoadMonsterAndSpeciesForListEntryC, BattleEnd_Step3_Sub06_Sub01_LoadMonsterAndSpeciesForListEntryC)
; reads: wRecordBuffer
; writes: wMonsterId, wSpeciesIdLo, wSpeciesIdHi
; points at: wEncounterMonsters
LoadMonsterAndSpeciesForListEntryC::
Func_019_470F:: ; address name
    push bc
    ld a, c
    ld hl, wEncounterMonsters
    add a, a
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
    call LoadMonsterAndSpeciesForListEntryC_ReadRecordBufferAndRecordBufferData
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
    call LoadMonsterAndSpeciesForListEntryC_ReadSpeciesRecordAndRandomLoEtc
    pop bc
    ret

; only called from GameMode4_Init_Sub01_Sub07 (E-0047)
; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01_LoadMonsterAndSpeciesForListEntryC)
; reads: wBattleArg2, wBattleArg3, wSpeciesIdLo, wSpeciesIdHi, wSpeciesRecord, hTemp1
; writes: wBattleArg2, wBattleArg3, wBattleArg1, hTemp1, wSpeciesIdLo, wSpeciesIdHi, hTemp0, wBattleArg0
; points at: wWildLevel, wEncounterMonsters
GameMode4_Init_Sub01_Sub07_WriteBattleArg2AndBattleArg3Etc::
Func_019_4752:: ; address name
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
    or a, a
    jr nz, .skip
    ld a, $01
    ldh [hTemp1], a

.skip:
    ld a, c
    add a, a
    ld hl, wEncounterMonsters
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wBattleArg2]
    add a, $0A
    ld l, a
    ld a, [wBattleArg3]
    adc a, $00
    ld h, a
    ld a, [wSpeciesIdLo]
    ld [hl+], a
    ld a, [wSpeciesIdHi]
    ld [hl+], a
    ld a, [wSpeciesRecord]
    ld [hl+], a
    ld a, [wSpeciesRecord + $1]
    ld [hl+], a
    ld a, [wSpeciesRecord + $8]
    ld [hl+], a
    ld a, [wSpeciesRecord + $9]
    ld [hl+], a
    ld a, [wSpeciesRecord + $A]
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ldh a, [hTemp1]
    ld [hl+], a
    ld a, [wSpeciesRecord + $2D]
    ld [hl+], a
    ld a, [wSpeciesRecord + $2E]
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    push hl
    ld a, [wSpeciesRecord + $C]
    ldh [hTemp0], a
    farcall StatFromGrowthRow
    pop hl
    ld a, $01
    ld [wBattleArg0], a
    call ScaleStatAndCapByBattleKind
    call StoreTemp2WordAtHL_Bank19
    ld a, [wSpeciesRecord + $D]
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
    ld a, [wSpeciesRecord + $E]
    ldh [hTemp0], a
    push hl
    farcall StatFromGrowthRow
    pop hl
    call ScaleStatAndCapByBattleKind
    ld a, $03
    ld [wBattleArg0], a
    ld a, [wSpeciesRecord + $F]
    ldh [hTemp0], a
    push hl
    farcall StatFromGrowthRow
    pop hl
    call ScaleStatAndCapByBattleKind
    ld a, $00
    ld [wBattleArg0], a
    ld a, [wSpeciesRecord + $10]
    ldh [hTemp0], a
    push hl
    farcall StatFromGrowthRow
    pop hl
    call ScaleStatAndCapByBattleKind
    ld a, [wSpeciesRecord + $11]
    ldh [hTemp0], a
    push hl
    farcall StatFromGrowthRow
    pop hl
    call ScaleStatAndCapByBattleKind
    ld a, $E7
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    call StoreRandomByte80ToFFAtHL
    call StoreRandomByteAtHL_Bank19
    call StoreRandomByteAtHL_Bank19
    call StoreRandomByteAtHL_Bank19
    call CopyWD01ARecordToHL_Bank19
    ld a, $00
    ld [hl+], a
    push hl
    ld a, [wSpeciesIdLo]
    ld l, a
    ld a, [wSpeciesIdHi]
    ld h, a
    ld a, l
    add a, $1C
    ld l, a
    ld a, h
    adc a, $74
    ld h, a
    ld a, [hl]
    pop hl
    ld [hl+], a
    call RollRecordField0DState
    call AccumulateGrowthForLevelsTemp1
    farcall CheckSkillsLearnableAtLevel
    ld a, [wBattleArg2]
    ld e, a
    ld a, [wBattleArg3]
    ld d, a
    pop bc
    ret

; advances the random table (NextTableByte) and stores the new wC5E7 at HL; HL += 1; AF, BC, DE kept apart from A = the byte (E-0067) (the same 16 bytes appear in 2 banks)
; 3 call sites from 1 routine (e.g. GameMode4_Init_Sub01_Sub07_WriteBattleArg2AndBattleArg3Etc)
; reads: wRandomLo
StoreRandomByteAtHL_Bank19::
Func_019_488D:: ; address name
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
    ld [hl+], a
    ret

; NextTableByte, then stores (wC5E7 & $7F) + $80 at HL; HL += 1 (E-0118)
; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01_Sub07_WriteBattleArg2AndBattleArg3Etc)
; reads: wRandomLo
StoreRandomByte80ToFFAtHL::
Func_019_489D:: ; address name
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
    and a, $7F
    add a, $80
    ld [hl+], a
    ret

; scales the word hFFC8 by 101 percent and caps it at 999, 600 or 700 depending on wD868 and the battle kind wCFC5, then stores it (E-0128)
; 6 call sites from 1 routine (e.g. GameMode4_Init_Sub01_Sub07_WriteBattleArg2AndBattleArg3Etc)
; reads: hTemp2, hTemp3, wBattleKind, wBattleArg0, wBattleIntroFlag, wBattleArg1, wSpeciesRecord
; writes: hTemp2, hTemp3
ScaleStatAndCapByBattleKind::
Func_019_48B1:: ; address name
    push af
    push bc
    push de
    push hl
    ldh a, [hTemp2]
    ld c, a
    ldh a, [hTemp3]
    ld b, a
    ld a, $01
    add a, $64
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    ld a, [wBattleKind]
    cp a, $03
    jr nz, .check_battle_arg0
    ld a, [wBattleArg0]
    cp a, $01
    jr nz, .check_battle_arg0
    ld a, [wBattleIntroFlag]
    cp a, $01
    ld a, $05
    jr z, ScaleWordBy6Or12Capped10000_CallMultiply24By8
    ld a, [wBattleArg1]
    cp a, $01
    ld a, $02
    jr nz, ScaleWordBy6Or12Capped10000_CallMultiply24By8
    ld a, $05
    jr ScaleWordBy6Or12Capped10000_CallMultiply24By8

.check_battle_arg0:
    ld a, [wBattleArg0]
    cp a, $02
    jr z, .check_battle_kind
    cp a, $03
    jr z, .check_battle_kind2
    ld bc, $03E7
    jr .skip2

.check_battle_kind:
    ld a, [wBattleKind]
    cp a, $03
    jr z, .skip
    ld bc, $0258
    jr .skip2

.skip:
    ld bc, $02BC
    jr .skip2

.check_battle_kind2:
    ld bc, $02BC
    ld a, [wBattleKind]
    cp a, $03
    jr nz, .skip2
    ld a, [wSpeciesRecord + $3]
    or a, a
    jr z, .skip2
    ld bc, $03E7

.skip2:
    ld a, e
    or a, a
    jr nz, ScaleWordBy6Or12Capped10000_Restore
    push bc
    ld a, c
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    bit 7, b
    jr nz, ScaleWordBy6Or12Capped10000_Restore
    pop bc
    jr ScaleWordBy6Or12Capped10000_SetTemp2

; multiplies by 6 (or 12 when wD869 = 1) and caps the result at 10000, then stores the word at [HL+] (E-0127)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg1, hTemp2, hTemp3
; writes: hTemp2, hTemp3
ScaleWordBy6Or12Capped10000:: ; heuristic: follows a terminator; C0
Func_019_4931:: ; address name
    ld a, [wBattleArg1]
    cp a, $01
    ld a, $06
    jr nz, ScaleWordBy6Or12Capped10000_CallMultiply24By8
    ld a, $0C

ScaleWordBy6Or12Capped10000_CallMultiply24By8::
Jump_019_493C:: ; address name
    call Multiply24By8
    ld a, d
    or a, e
    jr z, ScaleWordBy6Or12Capped10000_SetTemp2
    ld hl, $2710
    jr ScaleWordBy6Or12Capped10000_SetTemp2

ScaleWordBy6Or12Capped10000_Restore::
Jump_019_4948:: ; address name
    pop bc
    ld l, c
    ld h, b

ScaleWordBy6Or12Capped10000_SetTemp2::
Jump_019_494B:: ; address name
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    pop hl
    pop de
    pop bc
    pop af
    ldh a, [hTemp2]
    ld [hl+], a
    ldh a, [hTemp3]
    ld [hl+], a
    ret

; stores hFFC8 then hFFC9 at HL; HL += 2; clobbers A (E-0065) (the same 7 bytes appear in 2 banks)
; 2 call sites from 1 routine (e.g. GameMode4_Init_Sub01_Sub07_WriteBattleArg2AndBattleArg3Etc)
; reads: hTemp2, hTemp3
StoreTemp2WordAtHL_Bank19::
Func_019_495C:: ; address name
    ldh a, [hTemp2]
    ld [hl+], a
    ldh a, [hTemp3]
    ld [hl+], a
    ret

; copies the 27 ($1B) bytes at wD01A to HL; HL ends past the copy; clobbers A, B, DE (E-0065) (the same 12 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01_Sub07_WriteBattleArg2AndBattleArg3Etc)
CopyWD01ARecordToHL_Bank19::
Func_019_4963:: ; address name
    ld de, wSpeciesRecord + $12
    ld b, $1B

.loop:
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, .loop
    ret

; field $0D of record wD86A: values 1, 2 and others roll with thresholds 2, $80 and $E6 and become 1 or 0; with wD068 set bit 4 is cleared (E-0125)
; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01_Sub07_WriteBattleArg2AndBattleArg3Etc)
; reads: wBattleArg2, wBattleArg3, wRandomLo, wNewRecordByte0D
RollRecordField0DState::
Func_019_496F:: ; address name
    ld a, [wBattleArg2]
    add a, $0D
    ld l, a
    ld a, [wBattleArg3]
    adc a, $00
    ld h, a
    ld a, [hl]
    or a, a
    jr z, .check_new_record_byte0_d2
    cp a, $01
    jr z, .skip
    cp a, $02
    jr z, .skip2
    ld b, $E6
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
    cp a, b
    jr c, .check_new_record_byte0_d
    xor a, a
    jr .check_new_record_byte0_d2

.check_new_record_byte0_d:
    ld a, $01

.check_new_record_byte0_d2:
    ld [hl], a
    ld a, [wNewRecordByte0D]
    or a, a
    ret z
    res 4, a
    ld [hl], a
    ret

; sums the stat word at record + $18 times each level 1..hFFC7 (with a /20 rounding term outside battle kind 3) into the 24-bit hFFCA-hFFCC (E-0130)
; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01_Sub07_WriteBattleArg2AndBattleArg3Etc)
; reads: wBattleArg2, wBattleArg3, hTemp1, hTemp7, hTemp8, wBattleKind, hTemp9, hTemp4, ...
; writes: hTemp4, hTemp5, hTemp6, hTemp9, hTemp7, hTemp8
AccumulateGrowthForLevelsTemp1::
Func_019_49B1:: ; address name
    ld a, [wBattleArg2]
    add a, $18
    ld l, a
    ld a, [wBattleArg3]
    adc a, $00
    ld h, a
    push de
    push hl
    xor a, a
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
    cp a, $03
    jr z, .read_temp4
    ld a, $14
    call Divide24ByA
    ld c, a
    ldh a, [hTemp9]
    add a, c
    ldh [hTemp9], a

.read_temp4:
    ldh a, [hTemp4]
    add a, l
    ldh [hTemp4], a
    ldh a, [hTemp5]
    adc a, h
    ldh [hTemp5], a
    ldh a, [hTemp6]
    adc a, e
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
    add a, b
    ldh [hTemp4], a
    ldh a, [hTemp5]
    adc a, $00
    ldh [hTemp5], a
    ldh a, [hTemp6]
    adc a, $00
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
    cp a, $03
    jr nz, .skip
    sra e
    rr h
    rr l
    sra e
    rr h
    rr l

.skip:
    ld a, e
    or a, h
    or a, l
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
    or a, e
    jr z, .restore
    ld hl, $FFFF

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

; DEHL = A * EHL (a 24-bit by 8-bit multiply from three Multiply8 calls) (E-0121)
; 2 call sites from 2 routines (e.g. AccumulateGrowthForLevelsTemp1, ScaleWordBy6Or12Capped10000)
Multiply24By8::
Func_019_4A74:: ; address name
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
    add a, h
    ld h, a
    ld a, b
    adc a, $00
    ld e, a
    pop bc
    ld a, c
    add a, e
    ld e, a
    ld a, b
    adc a, $00
    ld d, a
    ret

; only called from LoadMonsterAndSpeciesForListEntryC (E-0047)
; 1 call site from 1 routine (e.g. LoadMonsterAndSpeciesForListEntryC)
; reads: wRecordBuffer, wRecordBufferData
; points at: wRecordBufferData
LoadMonsterAndSpeciesForListEntryC_ReadRecordBufferAndRecordBufferData::
Func_019_4A9A:: ; address name
    push bc
    ld b, $0A
    ld a, $FF

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
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop2
    ld a, $FF
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
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl-]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl-]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, $E7
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
    ld a, $1C
    add a, e
    ld e, a
    jr nc, .read_record_buffer_data
    inc d

.read_record_buffer_data:
    ld a, [wRecordBufferData + $6]
    ld [de], a
    pop bc
    ret

; only called from LoadMonsterAndSpeciesForListEntryC (E-0047)
; 1 call site from 1 routine (e.g. LoadMonsterAndSpeciesForListEntryC)
; reads: wSpeciesRecord, wRandomLo, wNewRecordByte0D
LoadMonsterAndSpeciesForListEntryC_ReadSpeciesRecordAndRandomLoEtc::
Func_019_4B37:: ; address name
    ld a, $0C
    add a, e
    ld e, a
    jr nc, .read_species_record
    inc d

.read_species_record:
    ld a, [wSpeciesRecord]
    ld [de], a
    inc de
    ld a, [wSpeciesRecord + $1]
    or a, a
    jr z, .check_new_record_byte0_d2
    cp a, $01
    jr z, .skip
    cp a, $02
    jr z, .skip2
    ld b, $E6
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
    cp a, b
    jr c, .check_new_record_byte0_d
    xor a, a
    jr .check_new_record_byte0_d2

.check_new_record_byte0_d:
    ld a, $01

.check_new_record_byte0_d2:
    ld [de], a
    ld a, [wNewRecordByte0D]
    or a, a
    jr z, .skip4
    res 4, a
    ld [de], a

.skip4:
    ld a, $24
    add a, e
    ld e, a
    jr nc, .skip5
    inc d

.skip5:
    ld b, $1B
    ld hl, wSpeciesRecord + $12

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    inc de
    inc de
    pop bc
    ret

; only called from GameMode4_Init_Sub01_Sub04 (E-0047)
; 2 call sites from 1 routine (e.g. GameMode4_Init_Sub01_WriteSpeciesIdLoAndSpeciesIdHi)
; reads: wLinkMode, wBattleArg0, wLoadSlot
; points at: wBattleMonsterId, wSlotNameSuffix, wSlotTactic, wSlotLastTactic, wBattleSetupD8, wBattleLevel, wBattleMaxHP, wBattleMaxMP, ...
GameMode4_Init_Sub01_Sub04_LoadBattleSlotFromBattlerRecord_4BA8::
Func_019_4B91:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr nz, LoadBattleSlotFromBattlerRecord_4BA8
    ld a, c
    cp a, $04
    jr nc, .call_load_battle_slot_from_battler_record_4
    call LoadBattleSlotFromBattlerRecord_4BA8
    jr .call_clear_species_record_buffer_bank19

.call_load_battle_slot_from_battler_record_4:
    call LoadBattleSlotFromBattlerRecord_4CF8

.call_clear_species_record_buffer_bank19:
    call ClearSpeciesRecordBuffer_Bank19
    ret

; slot C: copies species, family, AI settings (wDA43/wDA4B outside link battles) and stats from its battler record into the battle arrays (E-0131)
; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01_Sub04_LoadBattleSlotFromBattlerRecord_4BA8)
; reads: wLinkMode, wBattleArg0, wLoadSlot
; points at: wBattleMonsterId, wSlotNameSuffix, wSlotTactic, wSlotLastTactic, wBattleSetupD8, wBattleLevel, wBattleMaxHP, wBattleMaxMP, ...
LoadBattleSlotFromBattlerRecord_4BA8::
Func_019_4BA8:: ; address name
    ld a, c
    push bc
    call BattlerRecordAddress_Bank19
    pop bc
    ld a, c
    add a, a
    ld de, wBattleMonsterId
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc hl
    ld a, c
    ld de, wSlotNameSuffix
    add a, e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [hl]
    and a, $0F
    ld [de], a
    ld a, [wLinkMode]
    or a, a
    jr z, .skip5
    ld a, c
    ld de, wSlotTactic
    add a, e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, $00
    ld [de], a
    ld a, c
    ld de, wSlotLastTactic
    add a, e
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
    add a, e
    ld e, a
    jr nc, .skip6
    inc d

.skip6:
    ld a, [hl+]
    swap a
    and a, $0F
    push af
    and a, $03
    ld [de], a
    pop af
    push af
    push af
    ld a, c
    ld de, wSlotLastTactic
    add a, e
    ld e, a
    jr nc, .restore
    inc d

.restore:
    pop af
    rrca
    rrca
    and a, $03
    ld [de], a

.skip7:
    ld a, c
    cp a, $04
    jr nc, .restore3
    ld a, c
    ld de, wBattleSetupD8
    add a, e
    ld e, a
    jr nc, .restore2
    inc d

.restore2:
    pop af
    and a, $03
    ld [de], a
    jr .check_battle_arg0

.restore3:
    pop af

.check_battle_arg0:
    push hl
    push bc
    ld a, [wBattleArg0]
    or a, a
    jr nz, .call_set_c_from_battle_arg0_then_run_load
    call LoadSlotSkillsFromBattlerRecord
    jr .restore4

.call_set_c_from_battle_arg0_then_run_load:
    call SetCFromBattleArg0ThenRunLoadSlotSkillsFromBattlerRecord

.restore4:
    pop bc
    pop hl
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wLoadSlot]
    or a, a
    call z, InitSlotOutAndStatusFromRecordFlags
    inc hl
    ld de, wBattleLevel
    call StoreByteAtDEPlusC_Bank19
    inc hl
    inc hl
    inc hl
    ld a, [wLoadSlot]
    or a, a
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
    ld de, wBattleWordArray3F
    call StoreWordAtDEPlus2C_Bank19
    ld a, [wLoadSlot]
    or a, a
    jr z, .call_store_byte_at_de_plus_c_bank19
    ld a, [wBattleArg0]
    push hl
    ld l, a
    add a, a
    add a, a
    add a, a
    add a, l
    ld hl, wBattleStatus1
    add_a_to_hl
    ld a, [hl]
    and a, $30
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
    add a, a
    add a, c
    add a, a
    add a, c
    ld de, wSlotResistances
    add a, e
    ld e, a
    jr nc, .call_pack_resistance_fields_to_de
    inc d

.call_pack_resistance_fields_to_de:
    push bc
    call PackResistanceFieldsToDE
    pop bc
    call SetSlotAIModeFromINT
    ret

; slot C: copies species, family, wDA43 and stats from its battler record into the battle arrays and loads its skills (E-0131)
; 1 call site from 1 routine (e.g. GameMode4_Init_Sub01_Sub04_LoadBattleSlotFromBattlerRecord_4BA8)
; reads: wBattleArg0, wLoadSlot
; points at: wBattleMonsterId, wSlotNameSuffix, wSlotTactic, wBattleLevel, wBattleMaxHP, wBattleMaxMP, wBattleATK, wBattleDEF, ...
LoadBattleSlotFromBattlerRecord_4CF8::
Func_019_4CF8:: ; address name
    push bc
    call BattlerRecordAddress_Bank19
    pop bc
    ld a, c
    add a, a
    ld de, wBattleMonsterId
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc hl
    ld a, c
    ld de, wSlotNameSuffix
    add a, e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [hl+]
    ld [de], a
    ld a, c
    ld de, wSlotTactic
    add a, e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, $00
    ld [de], a
    push hl
    push bc
    ld a, [wBattleArg0]
    or a, a
    jr nz, .call_set_c_from_battle_arg0_then_run_load
    call LoadSlotSkillsFromBattlerRecord
    jr .restore

.call_set_c_from_battle_arg0_then_run_load:
    call SetCFromBattleArg0ThenRunLoadSlotSkillsFromBattlerRecord

.restore:
    pop bc
    pop hl
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wLoadSlot]
    or a, a
    call z, InitSlotOutAndStatusFromRecordFlags
    inc hl
    ld de, wBattleLevel
    call StoreByteAtDEPlusC_Bank19
    inc hl
    inc hl
    inc hl
    ld a, [wLoadSlot]
    or a, a
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
    sub a, $01
    ld l, a
    ld a, d
    sbc a, $00
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
    ld de, wBattleWordArray3F
    call StoreWordAtDEPlus2C_Bank19
    ld a, [wLoadSlot]
    or a, a
    jr z, .call_store_byte_at_de_plus_c_bank19
    ld a, [wBattleArg0]
    push hl
    ld l, a
    add a, a
    add a, a
    add a, a
    add a, l
    ld hl, wBattleStatus1
    add_a_to_hl
    ld a, [hl]
    and a, $30
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
    add a, a
    add a, c
    add a, a
    add a, c
    ld de, wSlotResistances
    add a, e
    ld e, a
    jr nc, .call_pack_resistance_fields_to_de
    inc d

.call_pack_resistance_fields_to_de:
    push bc
    call PackResistanceFieldsToDE
    pop bc
    call SetSlotAIModeFromINT
    ret

; A = battle slot: for slots 3 and 7 returns at once with Z set and HL unchanged; otherwise HL = wBattlerRecords + $4E * A' with A' = A - 1 for slots 4-6 (as BattlerRecordFieldAddress without the field offset) (E-0067) (the same 23 bytes appear in 2 banks)
; 2 call sites from 2 routines (e.g. LoadBattleSlotFromBattlerRecord_4CF8, LoadBattleSlotFromBattlerRecord_4BA8)
BattlerRecordAddress_Bank19::
Func_019_4E05:: ; address name
    cp a, $03
    jr c, .call_multiply8
    ret z
    cp a, $07
    ret z
    dec a

.call_multiply8:
    ld c, $4E
    call Multiply8
    ld a, l
    add a, $D5
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ret

; only called from GameMode4_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode4_Init_FillBytes)
; reads: wLinkMode
; points at: wSlotMarks
GameMode4_Init_Sub01_CarryUnlessBattleSlotOutSlotEmpty::
Func_019_4E1C:: ; address name
    ld a, [wLinkMode]
    or a, a
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
    ld [hl], $FF

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
    ld [hl], $FF

.next2:
    inc c
    inc hl
    dec b
    jr nz, .loop2
    ret

; E-0148 (C1: LoadTable4E60EntryForWC991ToWC9DE copies the 3 bytes at $4E60 + $129 * (species record byte 7) + 3 * (level - 1) to the record's EXP field (+$58); RecordReachedNextLevelExp and DrawWCA83ExpAndToNextLevel read the same rows; 32 rows of 99 rising values, each row starting at 0).
; record: EXP needed for levels 1-99 (24-bit)
ExpTable::
Data_019_4E60:: ; address name
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

; copies the 3 bytes at $4E60 + $129 * hFFC6 + 3 * hFFC7 into hFFC8-hFFCA (E-0120)
; 4 call sites from 4 routines (e.g. WithSRAMDraw4ACEAnd4BE8_ShowStringBank08AtTilesHL_Bank03, SwapMonstersMenu_ShowMonsterDetails_Case13_LoadRecordThreeBytesToTemp0, RecordReachedNextLevelExp, DrawWCA83ExpAndToNextLevel)
; reads: hTemp0, hTemp1
; writes: hTemp2, hTemp3, hTemp4
LoadExpTableEntryToTemp2::
Func_019_7380:: ; address name
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
    add a, $60
    ld l, a
    ld a, h
    adc a, $4E
    ld h, a
    ld a, [hl+]
    ldh [hTemp2], a
    ld a, [hl+]
    ldh [hTemp3], a
    ld a, [hl]
    ldh [hTemp4], a
    ret

; loads species record [wC991] and copies three bytes of table $4E60 entry (wD00F * $129 + 3 * ([wC9DC] - 1)) to wC9DE (E-0121)
; 2 call sites from 2 routines (e.g. CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord, BattleEnd_Step3)
; reads: wRecordBufA, wSpeciesExpCurve
; writes: wSpeciesIdLo, wSpeciesIdHi
LoadTable4E60EntryForWC991ToWC9DE::
Func_019_73A2:: ; address name
    ld a, [wRecordBufA + $B]
    ld l, a
    ld a, [wRecordBufA + $C]
    ld h, a
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesExpCurve]
    ld bc, $0129
    call Multiply8By16
    ld a, [wRecordBufA + $56]
    dec a
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    add hl, bc
    ld a, l
    add a, $60
    ld l, a
    ld a, h
    adc a, $4E
    ld h, a
    ld de, wRecordBufA + $58
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ret

; loads species record [wCA36] and copies three bytes of table $4E60 entry (wD00F * $129 + 3 * ([wCA81] - 1)) to wCA83 (E-0121)
; 1 call site from 1 routine (e.g. UnpackLinkRecordToRecordBufB)
; reads: wRecordBufB, wSpeciesExpCurve
; writes: wSpeciesIdLo, wSpeciesIdHi
LoadTable4E60EntryForWCA36ToWCA83::
Func_019_73DF:: ; address name
    ld a, [wRecordBufB + $B]
    ld l, a
    ld a, [wRecordBufB + $C]
    ld h, a
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesExpCurve]
    ld bc, $0129
    call Multiply8By16
    ld a, [wRecordBufB + $56]
    dec a
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    add hl, bc
    ld a, l
    add a, $60
    ld l, a
    ld a, h
    adc a, $4E
    ld h, a
    ld de, wRecordBufB + $58
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ret

; E-0208 (C1: while GameMode4_Init_Sub01_Sub07_Sub01 builds a new monster record, the code reads the byte at $741C + wSpeciesId and stores it at the next record byte, right after the zero that follows the copied name; 384 bytes, one per species, values 1-7; what the field means is not read).
; record: value 1-7 stored in a new monster record
SpeciesNewRecordByteTable::
Data_019_741C:: ; address name
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
    ds $A64, $00
