; ROM bank $A0: battle turns, encounter bands, game mode 7
; The annotated listing of this bank is build/listing/banka0.asm.

SECTION "Bank A0", ROMX[$4000], BANK[$A0]
    db $a0

; Game mode 7's start: clears the effect and battle state, keeps the data bank, sets wBattleKind
; $0A, resets the battle variables, copies the two linked monsters into battlers 0 and 1, sets up
; slots 0 and 1, draws the screen, starts the music and marks the slots. (C1, E-0357)
GameMode7_Init_Start::
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
    ld a, $0a
    ld [wBattleKind], a
    call GameMode7_Init_Start_ResetBattleVars
    ld hl, wWorkBuf
    ld bc, $0200
    xor a
    call FillBytes
    call GameMode7_Init_Start_CopyLinkedRecords
    call GameMode7_Init_Start_SetUpSlots
    call GameMode7_Init_DrawScreen
    call GameMode7_Init_Start_PlayMusic
    call GameMode7_Init_MarkSlots
    ret

; Prepares the foe half of the slot tables before the foes are loaded; wScreenCountPlusOne is the
; input (2 means two foes). It clears wBattleSlotOut for slots 4 and 5, sets slot 6 to $FF with two
; foes (otherwise 0) and slot 7 to $FF. Then it writes the eight wSlotMarks: 3 for slots 0 and 1
; when their wBattleSlotOut byte is not 0 (out or absent), otherwise 0; $FF for slot 2; $FF for slot
; 3 when its byte is not 0, otherwise 0; 1 for slots 4 and 5; 1 for slot 6 ($FF with two foes); $FF
; for slot 7. Last it clears wBattleTurn and the ten bytes from wBattleArg0. Its only caller is
; RunBattlePhaseWhenTextIdle_A0_IntroSetUpFoes. (C2, E-0385)
; clears the slot-out bytes of slots 4-7, marking the last one absent ($FF) unless
; wScreenCountPlusOne is 2, then checks the slots (CarryUnlessBattleSlotOutSlotEmpty)
InitBattleSlotsForFoeCount::
    xor a
    ld hl, wBattleSlotOut + $4
    ld [hli], a
    ld [hli], a
    ld a, [wScreenCountPlusOne]
    cp $02
    jr z, .skip
    xor a
    ld [hli], a
    ld a, $ff
    ld [hl], a
    jr .call_carry_unless_battle_slot_out_slot_empty

.skip:
    ld a, $ff
    ld [hli], a
    ld [hl], a

.call_carry_unless_battle_slot_out_slot_empty:
    ld hl, wSlotMarks
    ld a, $00
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .call_carry_unless_battle_slot_out_slot_empty2
    ld a, $03

.call_carry_unless_battle_slot_out_slot_empty2:
    ld [hli], a
    ld a, $01
    call CarryUnlessBattleSlotOutSlotEmpty
    ld a, $00
    jr nc, .skip2
    ld a, $03

.skip2:
    ld [hli], a
    ld a, $ff
    ld [hli], a
    ld a, $03
    call CarryUnlessBattleSlotOutSlotEmpty
    ld a, $00
    jr nc, .skip3
    ld a, $ff

.skip3:
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld [hli], a
    ld a, [wScreenCountPlusOne]
    cp $02
    jr z, .skip4
    ld a, $01
    ld [hli], a
    ld a, $ff
    ld [hl], a
    jr .clear_battle_turn

.skip4:
    ld a, $ff
    ld [hli], a
    ld [hl], a

.clear_battle_turn:
    xor a
    ld [wBattleTurn], a
    ld hl, wBattleArg0
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hl], a
    ret

; Resets the battle variables: no effect, queued action, SealPray or item target ($FF); slot marks
; 0, 0, $FF, $FF, 0, 0, 0, $FF; side control $80; every slot out and no species ($FF); skill and
; name tables $FF; meter 10; an empty action queue; turn 0; two party slots and three foes; text
; speed 3. (C2, E-0357; probed E-0385)
GameMode7_Init_Start_ResetBattleVars::
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
    xor a
    ld [hli], a
    ld [hli], a
    ld a, $ff
    ld [hli], a
    ld [hli], a
    xor a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld a, $ff
    ld [hl], a
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
    ld bc, $0020
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
    ld [wLinkRuleTurnLimit], a
    ld a, $00
    ld [wScreenCountPlusOne], a
    ld a, $02
    ld [wBattlePartyCount], a
    ld a, $03
    ld [wBattleFoeCount], a
    ld a, [wBattleResultByte]
    ld [wBattleSetupDB], a
    ld a, $03
    ld [wTextSpeed], a
    ret

; Draws game mode 7's screen: clears the attributes and buffer, loads the name tiles, the frame,
; both slots' HP, MP and marks, clears the text tiles, draws the record rectangle and copies the
; buffer to the BG map, then requests the palettes. (C1, E-0357)
GameMode7_Init_DrawScreen::
    farcall ClearAttributesAndScreenBuffer_Bank31
    call GameMode7_Init_DrawScreen_LoadNameTiles
    call GameMode7_Init_DrawScreen_DrawFrame
    call GameMode7_Init_DrawScreen_DrawSlotPanels
    call FillTilesFromRequest
    farcall CopyRectRecordToScreenBuffer
    ld hl, vBGMap0
    call CopyScreenTileBufferToVRAM_A0
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    ret

; Sets up battle slots 0 and 1 (LoadBattleSlotC_A0). (C2, E-0357; probed E-0385)
GameMode7_Init_Start_SetUpSlots::
    ld bc, $0200

.loop:
    push bc
    call LoadBattleSlotC_A0
    pop bc
    inc c
    dec b
    jr nz, .loop
    ret

; Loads the two foe slots 4 and 5 (BC = $0204: B = 2 slots, C = first slot), then continues in
; PrepareFoeSlots, which loads each slot with LoadBattleSlotC_A0, runs AdjustSkillsForBattleStart_A0
; and stores the wSlotBodyFlags. Its only caller is RunBattlePhaseWhenTextIdle_A0_IntroSetUpFoes
; (the two-foe case). (C2, E-0385)
; runs the slot setup (LoadBattleSlotC_A0) for slots 4-5, then falls into the shared loop's tail:
; AdjustSkillsForBattleStart_A0 and the slot damage flags
PrepareTwoFoeSlots::
    ld bc, $0204
    jr PrepareFoeSlots

; Loads the three foe slots 4, 5 and 6 (BC = $0304: B = 3 slots, C = first slot) by falling into
; PrepareFoeSlots, which loads each slot with LoadBattleSlotC_A0, runs AdjustSkillsForBattleStart_A0
; and stores the wSlotBodyFlags. Its only caller is RunBattlePhaseWhenTextIdle_A0_IntroSetUpFoes
; (the three wild monsters case). (C2, E-0385)
; runs the slot setup (LoadBattleSlotC_A0) for slots 4-6, then AdjustSkillsForBattleStart_A0 and the
; slot damage flags
PrepareThreeFoeSlots::
    ld bc, $0304

; Sets up the foe slots from C on, adjusts the skills for the battle start and stores each present
; slot's body flags (SPECIES_METAL with SPECIES_UNTRIPPABLE in the high nibble) in wSlotBodyFlags.
; (C2, E-0357; probed E-0385)
PrepareFoeSlots::
    push bc
    call LoadBattleSlotC_A0
    pop bc
    inc c
    dec b
    jr nz, PrepareFoeSlots
    call AdjustSkillsForBattleStart_A0
    ld de, wSlotBodyFlags
    ld bc, $0800

.loop:
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
    jr nz, .loop
    ret

; Zero-fills the 47 bytes of wSpeciesRecord (the buffer LoadSpeciesRecord fills); BC and HL are
; saved and restored. Called by LoadBattleSlotC_A0 after each battle slot has been loaded. One of 2
; identical copies in different banks. (C2, E-0385)
; zero-fills the 47 bytes of wSpeciesRecord, where LoadSpeciesRecord writes; BC, HL kept (E-0067)
; (the same 15 bytes appear in 2 banks)
ClearSpeciesRecordBuffer_BankA0::
    push bc
    push hl
    ld hl, wSpeciesRecord
    ld bc, $002f
    xor a
    call FillBytes
    pop hl
    pop bc
    ret

; Adjusts the skill lists once all slots are loaded (called by PrepareFoeSlots). Only slots whose
; wBattleSlotOut byte is 0 are looked at. First, for each of the 8 slots whose wSlotNameSuffix is 0,
; ReplaceSkill8FWithAAInSlotC_A0 changes the first SKILL_AHHH ($8F) into SKILL_AHHH_AA. Then, for
; the foe slots 4-6, each of the first four skills (the first byte of each 2-byte entry of
; wBattleSkills, up to a $FF entry) that is SKILL_PANICALL ($34) becomes SKILL_PANICALL_AD and
; SKILL_IRONIZE ($35) becomes SKILL_IRONIZE_AE. (C2, E-0385)
; replaces skill $8F by $AA for slots without wSlotNameSuffix set and marks skills $34 and $35 of
; the foe slots with tiles $AD and $AE (E-0127)
AdjustSkillsForBattleStart_A0::
    ld bc, $0800
    ld hl, wSlotNameSuffix

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, [hl]
    or a
    call z, ReplaceSkill8FWithAAInSlotC_A0

.next:
    inc c
    inc hl
    dec b
    jr nz, .loop
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
    call StoreSkillPanicAllADAtHL_BankA0
    jr .next2

.cp_35:
    cp $35
    jr nz, .next2
    call StoreSkillIronizeAEAtHL_BankA0

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

; C = battle slot: scans the 8 skill entries of that slot in wBattleSkills (2 bytes each, $10 bytes
; a slot) and changes the first entry that is SKILL_AHHH ($8F) into SKILL_AHHH_AA ($AA); the scan
; stops at an entry of $FF (empty), and only the first $8F is changed. HL is kept. Its only caller
; is AdjustSkillsForBattleStart_A0. (C2, E-0385)
; in slot C's skill list replaces the first skill $8F by $AA, stopping at $FF (E-0124)
ReplaceSkill8FWithAAInSlotC_A0::
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

; HL = address of a skill entry: stores $AD (SKILL_PANICALL_AD) there; A and HL are unchanged. Its
; only caller is AdjustSkillsForBattleStart_A0, which uses it to replace SKILL_PANICALL in a foe
; skill list. (C2, E-0385)
; [HL] = $AD (E-0116)
StoreSkillPanicAllADAtHL_BankA0::
    ld [hl], $ad
    ret

; HL = address of a skill entry: stores $AE (SKILL_IRONIZE_AE) there; A and HL are unchanged. Its
; only caller is AdjustSkillsForBattleStart_A0, which uses it to replace SKILL_IRONIZE in a foe
; skill list. (C2, E-0385)
; [HL] = $AE (E-0116)
StoreSkillIronizeAEAtHL_BankA0::
    ld [hl], $ae
    ret

; C = battle slot, HL = the flag byte of its battler record (record byte $16): bit 7 set stores 1 in
; wBattleSlotOut[C] and leaves the status alone. Bit 7 clear stores 0 there and sets the first
; status byte of the slot (wBattleStatus + 9 * C): bit 0 of the flag byte stores $20 (BSTAT0_CURSED)
; and then bit 2 ORs in $01 (BSTAT0_POISONED); with neither bit set the status byte is left as it
; was. HL is kept. Callers: LoadBattleSlotC_A0_Party and LoadBattleSlotC_A0_Foe, when wLoadSlot is
; 0. (C2, E-0385)
; sets wBattleSlotOut for slot C from bit 7 of the record byte and the slot's wBattleStatus bits
; from its other flags (E-0344: the address in its name dropped or read as the label there; was
; LoadBattleSlotC_A0_SetSlotOutAndStatus)
LoadBattleSlotC_A0_SetSlotOutAndStatus::
    push hl
    ld a, c
    ld de, wBattleSlotOut
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    bit 7, [hl]
    jr z, .skip2
    ld a, $01
    ld [de], a
    jr .done

.skip2:
    ld a, $00
    ld [de], a
    ld a, c
    ld de, wBattleStatus
    add a
    add a
    add a
    add c
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    bit 0, [hl]
    jr z, .skip4
    ld a, $20
    ld [de], a

.skip4:
    bit 2, [hl]
    jr z, .done
    ld a, [de]
    or $01
    ld [de], a

.done:
    pop hl
    ret

; DE = base of a per-slot table, C = slot, HL = source: DE becomes DE + C, the byte at HL is copied
; to [DE] and HL advances by 1; A ends as the byte. Used by the two slot loaders for the level and
; the personality bytes. Same 9 bytes in 2 banks. (C2, E-0385)
; DE += C; copies the byte at HL to [DE]; HL += 1 (the same 9 bytes appear in 2 banks)
StoreByteAtDEPlusC_BankA0::
    ld a, c
    add e
    ld e, a
    jr nc, .done
    inc d

.done:
    ld a, [hli]
    ld [de], a
    ret

; DE = base of a per-slot word table, C = slot, HL = source: DE becomes DE + 2 * C (worked out in 8
; bits), the word at HL is copied to [DE] and [DE + 1], low byte first; HL advances by 2 and DE ends
; on the second byte written. Used by the two slot loaders for HP, MP and the stats. Same 13 bytes
; in 2 banks. (C2, E-0385)
; DE += 2 * C; copies the word at HL to [DE]; HL += 2, DE ends on the second byte written (the same
; 13 bytes appear in 2 banks)
StoreWordAtDEPlus2C_BankA0::
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

; HL = BG map address: copies 18 rows of 20 tiles from wScreenTileBuffer (rows 32 bytes apart in the
; buffer) to the BG map starting at HL (rows 32 bytes apart too), each byte written with
; WriteVRAMByteInc. Callers: GameMode7_Init_DrawScreen,
; RunBattlePhaseWhenTextIdle_A0_ResultsScreen_Blank and
; RunBattlePhaseWhenTextIdle_A0_ShowResultsScreen. (C1, E-0385)
; copies the 20 x 18 screen tile buffer to the BG map at HL (32-byte rows) (E-0124)
CopyScreenTileBufferToVRAM_A0::
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

; Starts the battle music: $0F for wBattleKind 0, otherwise $13. (C2, E-0357; probed E-0385)
GameMode7_Init_Start_PlayMusic::
    ld a, [wBattleKind]
    or a
    jr nz, .call_queue_music
    ld a, $0f
    jr .call_queue_music2

.call_queue_music:
    ld a, $13

.call_queue_music2:
    call QueueMusic
    ret

; Copies the two linked records into battler records 0 and 1: wRecordBufA first and wRecordBufB
; second, the other way round for link role bit 1. (C2, E-0357; probed E-0385)
GameMode7_Init_Start_CopyLinkedRecords::
    ld de, wBattlerRecords
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .call_game_mode7_init_start_pack_battler
    ld hl, wRecordBufA
    call GameMode7_Init_Start_PackBattlerRecord
    ld hl, wRecordBufB
    jr GameMode7_Init_Start_PackBattlerRecord

.call_game_mode7_init_start_pack_battler:
    ld hl, wRecordBufB
    call GameMode7_Init_Start_PackBattlerRecord
    ld hl, wRecordBufA

; HL = a linked monster record, DE = the battler record to fill; both advance. The record byte 0 is
; skipped, then it copies 14 bytes from MON_NAME (the name, the species word and two more bytes),
; the 8 skills (MON_SKILLS), writes a zero byte, copies MON_LEVEL, 21 bytes from MON_EXP to MON_WLD,
; and 31 bytes from MON_PERSONALITY (the personality bytes and the resistances) followed by the
; MON_ITEM byte. ApplyEquippedItemIncrements then raises the resistance bytes that the item names,
; and the last byte written is $FF. Caller: GameMode7_Init_Start_CopyLinkedRecords (twice). (C2,
; E-0385)
GameMode7_Init_Start_PackBattlerRecord::
    inc hl
    ld b, $0e
    call CopyBytesDEFromHL_BankA0
    ld a, l
    add $25
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld b, $08
    call CopyBytesDEFromHL_BankA0
    xor a
    ld [de], a
    inc de
    ld a, l
    add $1a
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld b, $01
    call CopyBytesDEFromHL_BankA0
    inc hl
    ld b, $15
    call CopyBytesDEFromHL_BankA0
    inc hl
    inc hl
    ld b, $1f
    call CopyBytesDEFromHL_BankA0
    ld a, l
    add $16
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [hl]
    ld [de], a
    inc de
    call ApplyEquippedItemIncrements
    ld a, $ff
    ld [de], a
    inc de
    ret

; B = count, HL = source, DE = destination: copies B bytes from [HL] to [DE]; HL and DE end past the
; copy and B ends 0 (a count of 0 copies 256). Used by GameMode7_Init_Start_PackBattlerRecord. Same
; 7 bytes as CopyBytesDEFromHL. (C2, E-0385)
; the same 7 bytes as CopyBytesDEFromHL (CopyBytesDEFromHL) (E-0353)
CopyBytesDEFromHL_BankA0::
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, CopyBytesDEFromHL_BankA0
    ret

; A = the equipped item byte just packed (MON_ITEM), DE = the address after it: for A in $0D-$13 it
; reads row A - $0D of IncrementOffsetRows_A0 (16 bytes a row) and for each offset byte before the
; $80 end it raises the byte at DE - 256 + offset by one unless that byte is already 3 or more
; (IncrementTableByteCappedAt3_BankA0). Other values of A (0, below $0D, $14 and above) return at
; once. DE is kept. In the packed battler record the addressed bytes are the resistance levels,
; except that the one entry of the row for $12 ($FF) names the byte just before DE. Its only caller
; is GameMode7_Init_Start_PackBattlerRecord. (C2, E-0385)
; for A in $0D-$13 increments (capped at 3) each byte listed in IncrementOffsetRows_A0 row A - $0D,
; relative to DE (E-0125)
ApplyEquippedItemIncrements::
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
    ld de, IncrementOffsetRows_A0
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    cp $80
    jr nz, .call_increment_table_byte_capped_at3_bank_a0
    pop de
    ret

.call_increment_table_byte_capped_at3_bank_a0:
    ld l, a
    ld h, $ff
    call IncrementTableByteCappedAt3_BankA0
    inc de
    jr .skip

; HL = offset (the callers pass $FF00 + a table byte), hTemp0/hTemp1 = base: adds the base word to
; HL and raises the byte at that address by one unless it is already 3 or more. Its only caller is
; ApplyEquippedItemIncrements. The bank-$A0 copy of IncrementTableByteCappedAt3. (C2, E-0385)
; increments the byte at HL + the word hTemp0/hTemp1 unless it is already 3 or more (the bank-$A0
; copy of IncrementTableByteCappedAt3) (E-0118)
IncrementTableByteCappedAt3_BankA0::
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

; ApplyEquippedItemIncrements takes A in $0D-$13, reads row 16 * (A - $0D) and for each byte before
; $80 increments the byte at DE + $FF00 + byte, capped at 3 (IncrementTableByteCappedAt3); 7 rows;
; the bank $19 and $A0 copies are identical (E-0236, C1)
; record: offsets ($FF00 + byte, added to the base in DE) of the bytes to increment, up to $80, then
; zero padding
IncrementOffsetRows_A0::
    db $e5, $e6, $e7, $e8, $e9, $ea, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 13
    db $f5, $f6, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 14
    db $ec, $f0, $f7, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 15
    db $ec, $f0, $f7, $f8, $f9, $eb, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 16
    db $ec, $f0, $f7, $f8, $f9, $ed, $f3, $eb, $ef, $80, $00, $00, $00, $00, $00, $00 ; id 17
    db $ff, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 18
    db $fa, $fb, $fc, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 19

; C = battle slot: loads that slot from its battler record, with LoadBattleSlotC_A0_Party for slots
; 0-3 or LoadBattleSlotC_A0_Foe for slots 4-7, then clears the species record buffer
; (ClearSpeciesRecordBuffer_BankA0); wBattleArg0 is saved on entry and put back at the end. Callers:
; GameMode7_Init_Start_SetUpSlots (slots 0 and 1) and PrepareFoeSlots (foe slots). (C2, E-0385)
; runs LoadBattleSlotC_A0_Party for slots 0-3 or LoadBattleSlotC_A0_Foe for slots 4-7, clears the
; species record buffer and restores wBattleArg0 (E-0122) (E-0344: the address in its name dropped
; or read as the label there; was LoadBattleSlotC_A0)
LoadBattleSlotC_A0::
    ld a, [wBattleArg0]
    push af
    ld a, c
    cp $04
    jr nc, .call_load_battle_slot_c_a0_foe
    call LoadBattleSlotC_A0_Party
    jr .call_clear_species_record_buffer_bank_a0

.call_load_battle_slot_c_a0_foe:
    call LoadBattleSlotC_A0_Foe

.call_clear_species_record_buffer_bank_a0:
    call ClearSpeciesRecordBuffer_BankA0
    pop af
    ld [wBattleArg0], a
    ret

; C = slot 0-3: loads the battle slot from its battler record (BattlerRecordAddress_BankA0). The
; species word goes to wBattleMonsterId, the low nibble of record byte $0D to wSlotNameSuffix, and 0
; to wSlotTactic and wSlotLastTactic; wBattleLoadWork[C] is cleared too, unless bit 1 of wLinkRole
; is set (then it is left alone). The skills come from LoadSlotSkillsFromBattlerRecord, or from
; LoadSlotSkillsForBattleArg0 when wBattleArg0 is not 0. When wLoadSlot is 0 (a first load, not a
; reload) wBattleSlotOut and the first status byte are set from record byte $16
; (LoadBattleSlotC_A0_SetSlotOutAndStatus). Then come the level, HP, maximum HP, MP, maximum MP
; (only the two maximums on a reload), ATK, DEF, AGL, INT and the extra stat; the four personality
; bytes go to wSlotPersonalityHi, wSlotPersonalityLo, wSlotTrait and wSlotPersonalityMid (on a
; reload they are kept unless bit 4 or 5 of the status 1 byte of slot wBattleArg0 is set); the 27
; resistances are packed into wSlotResistances (PackResistancesFromBattleArgs); last,
; SetSlotAIModeFromINT sets the AI mode from INT (below 30, 100, 550, 900: 0, 1, 2, 3; more: 4).
; (C2, E-0385)
LoadBattleSlotC_A0_Party::
    ld a, c
    push bc
    call BattlerRecordAddress_BankA0
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
    ld a, c
    cp $04
    jr nc, .check_link_role
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .restore3
    ld a, c
    ld de, wBattleLoadWork
    add e
    ld e, a
    jr nc, .restore
    inc d

.restore:
    pop af
    and $03
    ld [de], a
    jr .check_battle_arg0

.check_link_role:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .restore3
    ld a, c
    and $03
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
    farcall LoadSlotSkillsFromBattlerRecord
    jr .restore4

.call_load_slot_skills_for_battle_arg0:
    farcall LoadSlotSkillsForBattleArg0

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
    call z, LoadBattleSlotC_A0_SetSlotOutAndStatus
    inc hl
    ld de, wBattleLevel
    call StoreByteAtDEPlusC_BankA0
    inc hl
    inc hl
    inc hl
    ld a, [wLoadSlot]
    or a
    jr z, .call_store_word_at_de_plus2_c_bank_a0
    inc hl
    inc hl
    ld de, wBattleMaxHP
    call StoreWordAtDEPlus2C_BankA0
    inc hl
    inc hl
    ld de, wBattleMaxMP
    call StoreWordAtDEPlus2C_BankA0
    jr .call_store_word_at_de_plus2_c_bank_a02

.call_store_word_at_de_plus2_c_bank_a0:
    ld de, wBattleHP
    call StoreWordAtDEPlus2C_BankA0
    ld de, wBattleMaxHP
    call StoreWordAtDEPlus2C_BankA0
    ld de, wBattleMP
    call StoreWordAtDEPlus2C_BankA0
    ld de, wBattleMaxMP
    call StoreWordAtDEPlus2C_BankA0

.call_store_word_at_de_plus2_c_bank_a02:
    ld de, wBattleATK
    call StoreWordAtDEPlus2C_BankA0
    ld de, wBattleDEF
    call StoreWordAtDEPlus2C_BankA0
    ld de, wBattleAGL
    call StoreWordAtDEPlus2C_BankA0
    ld de, wBattleINT
    call StoreWordAtDEPlus2C_BankA0
    ld de, wBattleExtraStat
    call StoreWordAtDEPlus2C_BankA0
    ld a, [wLoadSlot]
    or a
    jr z, .call_store_byte_at_de_plus_c_bank_a0
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
    jr nz, .call_store_byte_at_de_plus_c_bank_a0
    inc hl
    inc hl
    inc hl
    inc hl
    jr .skip5

.call_store_byte_at_de_plus_c_bank_a0:
    ld de, wSlotPersonalityHi
    call StoreByteAtDEPlusC_BankA0
    ld de, wSlotPersonalityLo
    call StoreByteAtDEPlusC_BankA0
    ld de, wSlotTrait
    call StoreByteAtDEPlusC_BankA0
    ld de, wSlotPersonalityMid
    call StoreByteAtDEPlusC_BankA0

.skip5:
    ld a, c
    add a
    add c
    add a
    add c
    ld de, wSlotResistances
    add e
    ld e, a
    jr nc, .set_battle_arg0
    inc d

.set_battle_arg0:
    push bc
    ld a, l
    ld [wBattleArg0], a
    ld a, h
    ld [wBattleArg1], a
    ld a, e
    ld [wBattleArg2], a
    ld a, d
    ld [wBattleArg3], a
    farcall PackResistancesFromBattleArgs
    pop bc
    farcall SetSlotAIModeFromINT
    ret

; Loads foe slot C (4-7) from its battler record (BattlerRecordAddress_BankA0) as
; LoadBattleSlotC_A0_Party does for slots 0-3: species id, the whole name suffix byte (not masked),
; tactic cleared, skills (LoadSlotSkillsFromBattlerRecord, or LoadSlotSkillsForBattleArg0 when
; wBattleArg0 is non-zero), the out flag and status unless reloading (wLoadSlot), the level and then
; zeroes the three record bytes after it, HP and MP (only the maximums when reloading), ATK, DEF,
; AGL, INT and the extra stat, the personality bytes and trait (kept when reloading unless status 1
; bits 4-5 are set), the resistances (PackResistancesFromBattleArgs) and the AI mode
; (SetSlotAIModeFromINT). Unlike the party version it stores no last tactic and no link side byte.
; (C2, E-0371; probed E-0385)
LoadBattleSlotC_A0_Foe::
    push bc
    call BattlerRecordAddress_BankA0
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
    farcall LoadSlotSkillsFromBattlerRecord
    jr .restore

.call_load_slot_skills_for_battle_arg0:
    farcall LoadSlotSkillsForBattleArg0

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
    call z, LoadBattleSlotC_A0_SetSlotOutAndStatus
    inc hl
    ld de, wBattleLevel
    call StoreByteAtDEPlusC_BankA0
    xor a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld a, [wLoadSlot]
    or a
    jr z, .call_store_word_at_de_plus2_c_bank_a0
    inc hl
    inc hl
    ld de, wBattleMaxHP
    call StoreWordAtDEPlus2C_BankA0
    inc hl
    inc hl
    ld de, wBattleMaxMP
    call StoreWordAtDEPlus2C_BankA0
    jr .call_store_word_at_de_plus2_c_bank_a02

.call_store_word_at_de_plus2_c_bank_a0:
    ld de, wBattleHP
    call StoreWordAtDEPlus2C_BankA0
    ld de, wBattleMaxHP
    call StoreWordAtDEPlus2C_BankA0
    ld de, wBattleMP
    call StoreWordAtDEPlus2C_BankA0
    ld de, wBattleMaxMP
    call StoreWordAtDEPlus2C_BankA0

.call_store_word_at_de_plus2_c_bank_a02:
    ld de, wBattleATK
    call StoreWordAtDEPlus2C_BankA0
    ld de, wBattleDEF
    call StoreWordAtDEPlus2C_BankA0
    ld de, wBattleAGL
    call StoreWordAtDEPlus2C_BankA0
    ld de, wBattleINT
    call StoreWordAtDEPlus2C_BankA0
    ld de, wBattleExtraStat
    call StoreWordAtDEPlus2C_BankA0
    ld a, [wLoadSlot]
    or a
    jr z, .call_store_byte_at_de_plus_c_bank_a0
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
    jr nz, .call_store_byte_at_de_plus_c_bank_a0
    inc hl
    inc hl
    inc hl
    inc hl
    jr .skip4

.call_store_byte_at_de_plus_c_bank_a0:
    ld de, wSlotPersonalityHi
    call StoreByteAtDEPlusC_BankA0
    ld de, wSlotPersonalityLo
    call StoreByteAtDEPlusC_BankA0
    ld de, wSlotTrait
    call StoreByteAtDEPlusC_BankA0
    ld de, wSlotPersonalityMid
    call StoreByteAtDEPlusC_BankA0

.skip4:
    ld a, c
    add a
    add c
    add a
    add c
    ld de, wSlotResistances
    add e
    ld e, a
    jr nc, .set_battle_arg0
    inc d

.set_battle_arg0:
    push bc
    ld a, l
    ld [wBattleArg0], a
    ld a, h
    ld [wBattleArg1], a
    ld a, e
    ld [wBattleArg2], a
    ld a, d
    ld [wBattleArg3], a
    farcall PackResistancesFromBattleArgs
    pop bc
    farcall SetSlotAIModeFromINT
    ret

; A = battle slot: slots 3 and 7 return at once with Z set and HL unchanged; otherwise HL =
; wBattlerRecords + $4E * n, with n = A for slots 0-2 and A - 1 for slots 4-6 (slot 4 is
; wBattlerRecordSlot4). Callers: LoadBattleSlotC_A0_Party and LoadBattleSlotC_A0_Foe. Same 23 bytes
; in 2 banks. (C2, E-0385)
; A = battle slot: for slots 3 and 7 returns at once with Z set and HL unchanged; otherwise HL =
; wBattlerRecords + $4E * A' with A' = A - 1 for slots 4-6 (as BattlerRecordFieldAddress without the
; field offset) (E-0067) (the same 23 bytes appear in 2 banks)
BattlerRecordAddress_BankA0::
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

; Marks slots 0 and 1: $FF when absent, 1 when it cannot act (CheckSlotStatusBlock), otherwise 0.
; (C2, E-0357; probed E-0385)
GameMode7_Init_MarkSlots::
    ld bc, $0200
    ld hl, wSlotMarks

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr z, .skip2
    ld a, c
    call CheckSlotStatusBlock
    jr c, .skip
    ld [hl], $00
    jr .next

.skip:
    ld [hl], $01
    jr .next

.skip2:
    ld [hl], $ff

.next:
    inc c
    inc hl
    dec b
    jr nz, .loop
    ret

; BC = (number of foe slots, first slot): ComputeWildEncounterLevel works out wWildLevel and
; wWildBand and picks the monsters for those slots, then ApplyLevelScaledStatsToSlots builds their
; wild battler records at that level. Its only caller is
; RunBattlePhaseWhenTextIdle_A0_IntroSetUpFoes (BC = $0300). (C2, E-0385)
; ComputeWildEncounterLevel, then ApplyLevelScaledStatsToSlots
ComputeWildLevelAndScaleStats::
    push bc
    call ComputeWildEncounterLevel
    pop bc
    call ApplyLevelScaledStatsToSlots
    ret

; B = number of slots, C = first slot. Works out a wild level from battler records 0 and 1 (the two
; party monsters): for each record, (AGL + INT) / 2 + max HP + max MP + ATK + DEF, divided by 50,
; plus (max HP + max MP + ATK + DEF + AGL + INT - 24 * level) / 50 (a negative second term is
; divided as its absolute value, then negated), a negative result becoming 0 and one above 99
; becoming 99. wWildLevel is 1 when both values are 0, otherwise the larger of the two (a zero value
; is ignored). wWildBand is 0 below level 20, then 1 to 7 at 20, 40, 50, 60, 70, 80 and 90 (levels
; $14, $28, $32, $3C, $46, $50, $5A). Finally PickEncounterMonsterForSlotC is run for each of the B
; slots from C. Its only caller is ComputeWildLevelAndScaleStats. (C2, E-0385)
; computes the wild monster level wWildLevel and band wWildBand from the party's stat totals
; (wBattlerRecords + $1D-wBattlerRecords + $29) and size (E-0131)
ComputeWildEncounterLevel::
    push bc
    ld de, $0000
    ld hl, wBattlerRecords + BATTLER_AGL
    call AddWordAtHLToDE
    ld hl, wBattlerRecords + BATTLER_INT
    call AddWordAtHLToDE
    srl d
    rr e
    ld hl, wBattlerRecords + BATTLER_MAX_HP
    call AddWordAtHLToDE
    ld hl, wBattlerRecords + BATTLER_MAX_MP
    call AddWordAtHLToDE
    ld hl, wBattlerRecords + BATTLER_ATK
    call AddWordAtHLToDE
    ld hl, wBattlerRecords + BATTLER_DEF
    call AddWordAtHLToDE
    ld h, d
    ld l, e
    ld a, $32
    call DivideHLByA
    push hl
    ld a, [wBattlerRecords + BATTLER_LEVEL]
    ld c, $18
    call Multiply8
    push hl
    ld de, $0000
    ld hl, wBattlerRecords + BATTLER_MAX_HP
    call AddWordAtHLToDE
    ld hl, wBattlerRecords + BATTLER_MAX_MP
    call AddWordAtHLToDE
    ld hl, wBattlerRecords + BATTLER_ATK
    call AddWordAtHLToDE
    ld hl, wBattlerRecords + BATTLER_DEF
    call AddWordAtHLToDE
    ld hl, wBattlerRecords + BATTLER_AGL
    call AddWordAtHLToDE
    ld hl, wBattlerRecords + BATTLER_INT
    call AddWordAtHLToDE
    pop hl
    ld a, e
    sub l
    ld l, a
    ld a, d
    sbc h
    ld h, a
    jr nc, .call_divide_hl_by_a
    cpl
    ld h, a
    ld a, l
    cpl
    ld l, a
    inc hl
    ld a, $32
    call DivideHLByA
    ld a, l
    cpl
    ld l, a
    ld a, h
    cpl
    ld h, a
    inc hl
    jr .restore

.call_divide_hl_by_a:
    ld a, $32
    call DivideHLByA

.restore:
    pop de
    add hl, de
    bit 7, h
    jr z, .skip
    ld hl, $0000

.skip:
    ld a, h
    or a
    jr nz, .skip2
    ld a, l
    cp $64
    jr c, .skip3

.skip2:
    ld hl, $0063

.skip3:
    push hl
    ld de, $0000
    ld hl, wBattlerRecordSlot1 + BATTLER_AGL
    call AddWordAtHLToDE
    ld hl, wBattlerRecordSlot1 + BATTLER_INT
    call AddWordAtHLToDE
    srl d
    rr e
    ld hl, wBattlerRecordSlot1 + BATTLER_MAX_HP
    call AddWordAtHLToDE
    ld hl, wBattlerRecordSlot1 + BATTLER_MAX_MP
    call AddWordAtHLToDE
    ld hl, wBattlerRecordSlot1 + BATTLER_ATK
    call AddWordAtHLToDE
    ld hl, wBattlerRecordSlot1 + BATTLER_DEF
    call AddWordAtHLToDE
    ld h, d
    ld l, e
    ld a, $32
    call DivideHLByA
    push hl
    ld a, [wBattlerRecordSlot1 + BATTLER_LEVEL]
    ld c, $18
    call Multiply8
    push hl
    ld de, $0000
    ld hl, wBattlerRecordSlot1 + BATTLER_MAX_HP
    call AddWordAtHLToDE
    ld hl, wBattlerRecordSlot1 + BATTLER_MAX_MP
    call AddWordAtHLToDE
    ld hl, wBattlerRecordSlot1 + BATTLER_ATK
    call AddWordAtHLToDE
    ld hl, wBattlerRecordSlot1 + BATTLER_DEF
    call AddWordAtHLToDE
    ld hl, wBattlerRecordSlot1 + BATTLER_AGL
    call AddWordAtHLToDE
    ld hl, wBattlerRecordSlot1 + BATTLER_INT
    call AddWordAtHLToDE
    pop hl
    ld a, e
    sub l
    ld l, a
    ld a, d
    sbc h
    ld h, a
    jr nc, .call_divide_hl_by_a2
    cpl
    ld h, a
    ld a, l
    cpl
    ld l, a
    inc hl
    ld a, $32
    call DivideHLByA
    ld a, h
    cpl
    ld h, a
    ld a, l
    cpl
    ld l, a
    inc hl
    jr .restore2

.call_divide_hl_by_a2:
    ld a, $32
    call DivideHLByA

.restore2:
    pop de
    add hl, de
    bit 7, h
    jr z, .skip4
    ld hl, $0000

.skip4:
    ld a, h
    or a
    jr nz, .skip5
    ld a, l
    cp $64
    jr c, .restore3

.skip5:
    ld hl, $0063

.restore3:
    pop bc
    ld a, l
    or c
    jr z, .skip6
    ld a, l
    or a
    jr z, .skip7
    ld a, c
    or a
    jr z, .skip8
    ld a, l
    cp c
    jr nc, .set_wild_level
    ld a, c
    jr .set_wild_level

.skip6:
    ld a, $01
    jr .set_wild_level

.skip7:
    ld a, c
    jr .set_wild_level

.skip8:
    ld a, l
    jr .set_wild_level

.set_wild_level:
    ld [wWildLevel], a
    pop bc
    or a
    jr z, .skip9
    cp $14
    jr c, .skip9
    cp $28
    jr c, .skip10
    cp $32
    jr c, .skip11
    cp $3c
    jr c, .skip12
    cp $46
    jr c, .skip13
    cp $50
    jr c, .skip14
    cp $5a
    jr c, .set_wild_band_to_06
    ld a, $07
    jr .set_wild_band

.skip9:
    xor a
    jr .set_wild_band

.skip10:
    ld a, $01
    jr .set_wild_band

.skip11:
    ld a, $02
    jr .set_wild_band

.skip12:
    ld a, $03
    jr .set_wild_band

.skip13:
    ld a, $04
    jr .set_wild_band

.skip14:
    ld a, $05
    jr .set_wild_band

.set_wild_band_to_06:
    ld a, $06

.set_wild_band:
    ld [wWildBand], a

.loop:
    push bc
    call PickEncounterMonsterForSlotC
    pop bc
    inc c
    dec b
    jr nz, .loop
    ret

; HL = address of a word: DE = DE + that word (16-bit sum); HL ends on the high byte; A is
; clobbered. Used by ComputeWildEncounterLevel to add up the stat words of a battler record. Same
; code in several banks. (C2, E-0385)
; DE += the word at [HL]; HL += 1 (ends on the high byte); clobbers A
AddWordAtHLToDE::
    ld a, [hli]
    add e
    ld e, a
    ld a, [hl]
    adc d
    ld d, a
    ret

; C = slot: stores a species word in wEncounterMonsters[C]. It takes the row from
; PickRandomBand0To10 (the row index is the family number; each row of EncounterBandSpeciesTable has
; 8 words, one list for each wWildBand 0-7), reads the list for wWildBand (a count byte, then that
; many species words), and draws a second random value (AdvanceRandom): the entry k is chosen when
; wRandomLo is not above (k + 1) * (255 / count); a count of 0, or a value above the last step,
; throws the draw away and starts again from a new row. Callers: ComputeWildEncounterLevel (and
; itself on a redraw). (C2, E-0385)
; picks a monster for slot C from the band row EncounterBandSpeciesTable (PickRandomBand0To10,
; wWildBand) by a weighted roll and stores its id in wEncounterMonsters[C] (E-0127)
PickEncounterMonsterForSlotC::
    push bc
    call PickRandomBand0To10
    add a
    add a
    add a
    add a
    ld hl, EncounterBandSpeciesTable
    add_a_to_hl
    ld a, [wWildBand]
    add a
    add_a_to_hl
    deref_hl
    ld a, [hli]
    push hl
    or a
    jr z, .restore2
    ld b, a
    push bc
    ld b, $ff
    call DivideBByA
    ld d, b
    call AdvanceRandom
    pop bc
    ld c, $00
    ld hl, wRandomLo
    ld a, d

.loop:
    cp [hl]
    jr nc, .restore
    add d
    jr c, .restore2
    inc c
    dec b
    jr nz, .loop
    jr .restore2

.restore:
    pop hl
    ld a, c
    add a
    add_a_to_hl
    pop bc
    ld de, wEncounterMonsters
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
    ld a, [hl]
    ld [de], a
    ret

.restore2:
    pop hl
    pop bc
    jr PickEncounterMonsterForSlotC

; Advances the random value (AdvanceRandom) and returns in A the number of thresholds of
; PickRandomBand0To10_Data that wRandomLo has reached: 0-9 for the steps of 25, 10 for $FA and
; above. A result of 10 is thrown away and drawn again while wWildBand is below 6. Its caller is
; PickEncounterMonsterForSlotC. (C2, E-0385)
; draws a random value and returns its band in the 11-entry threshold table
; PickRandomBand0To10_Data; band 10 is redrawn while wWildBand < 6 (E-0124)
PickRandomBand0To10::
    call AdvanceRandom
    ld a, [wRandomLo]
    ld bc, $0b00
    ld hl, PickRandomBand0To10_Data

.loop:
    cp [hl]
    jr c, .skip
    inc hl
    inc c
    dec b
    jr nz, .loop
    dec c

.skip:
    ld a, c
    cp $0a
    jr nz, .done
    ld a, [wWildBand]
    cp $06
    jr nc, .done
    jr PickRandomBand0To10

.done:
    ld a, c
    ret

; Eleven byte thresholds in steps of 25: $19, $32, $4B, $64, $7D, $96, $AF, $C8, $E1, $FA, $FF.
; PickRandomBand0To10 compares wRandomLo with them in order and the band is the number of thresholds
; that are not above it, so a value below $19 gives band 0, below $32 band 1, and so on up to band 9
; below $FA; $FA and above give band 10. Band 10 is drawn again while wWildBand is below 6. (C1,
; E-0381)
PickRandomBand0To10_Data::
    db $19, $32, $4b, $64, $7d, $96, $af, $c8, $e1, $fa, $ff

; Copies the $4E-byte battler records 0 and 1 (wBattlerRecords and wBattlerRecordSlot1) to
; wBattlerRecordSlot4 and wBattlerRecordSlot5, so that the two foes of a two-foe battle start as
; copies of the two party monsters. Its only caller is RunBattlePhaseWhenTextIdle_A0_IntroSetUpFoes.
; (C2, E-0385)
; copies battler records 0 and 1 ($4E bytes each, wBattlerRecords and wBattlerRecordSlot1) to
; wBattlerRecordSlot4 and wBattlerRecordSlot5 (E-0118)
BackupBattlerRecords0And1::
    ld hl, wBattlerRecords
    ld de, wBattlerRecordSlot4
    ld bc, $004e
    call CopyBytes
    ld hl, wBattlerRecordSlot1
    ld de, wBattlerRecordSlot5
    ld bc, $004e
    call CopyBytes
    ret

; B = number of slots, C = first slot: sets hTemp1 = min(4 * wWildLevel / 5 + 5, 99) (the level of
; the wild monsters), then for each slot runs ApplyLevelScaledStatsToSlots_BuildWildRecord with
; wBattleArg2/wBattleArg3 = the record address from ApplyLevelScaledStatsToSlots_Data entry C (the
; records of battle slots 4, 5 and 6). Its only caller is ComputeWildLevelAndScaleStats; DE is
; returned as the last record address. (C2, E-0385)
; hTemp1 = min(4 * wWildLevel / 5 + 5, 99); runs ApplyLevelScaledStatsToSlots_BuildWildRecord for B
; slots from C with wBattleArg2 = ApplyLevelScaledStatsToSlots_Data[slot] (E-0125)
ApplyLevelScaledStatsToSlots::
    push de
    ld a, [wWildLevel]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, $05
    call DivideHLByA
    ld a, $05
    add l
    pop de
    cp $64
    jr c, .set_temp1
    ld a, $63

.set_temp1:
    ldh [hTemp1], a

.loop:
    push bc
    ld a, c
    ld hl, ApplyLevelScaledStatsToSlots_Data
    add a
    add_a_to_hl
    ld a, [hli]
    ld [wBattleArg2], a
    ld a, [hl]
    ld [wBattleArg3], a
    call ApplyLevelScaledStatsToSlots_BuildWildRecord
    pop bc
    inc c
    dec b
    jr nz, .loop
    ret

; Builds wild monster C's battler record from its species (wEncounterMonsters): id, family, sex
; ratio, its three skills, the level (hTemp1) and each stat from its growth rows scaled by the wild
; level (at most 999). (C2, E-0357; probed E-0385)
ApplyLevelScaledStatsToSlots_BuildWildRecord::
    push bc
    ld a, c
    ld [wBattleArg1], a
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
    xor a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    push hl
    ld a, [wSpeciesRecord + SPECIES_GROWTH]
    ldh [hTemp0], a
    farcall StatFromGrowthRow
    pop hl
    ld a, $01
    ld [wBattleArg0], a
    call ScaleStatByWildLevelCapped999
    call StoreTemp2WordAtHL_BankA0
    ld a, [wSpeciesRecord + SPECIES_GROWTH + 1]
    ldh [hTemp0], a
    push hl
    farcall StatFromGrowthRow
    pop hl
    ld a, $00
    ld [wBattleArg0], a
    call ScaleStatByWildLevelCapped999
    call StoreTemp2WordAtHL_BankA0
    ld a, [wSpeciesRecord + SPECIES_GROWTH + 2]
    ldh [hTemp0], a
    push hl
    farcall StatFromGrowthRow
    pop hl
    call ScaleStatByWildLevelCapped999
    ld a, [wSpeciesRecord + SPECIES_GROWTH + 3]
    ldh [hTemp0], a
    push hl
    farcall StatFromGrowthRow
    pop hl
    call ScaleStatByWildLevelCapped999
    ld a, [wSpeciesRecord + SPECIES_GROWTH + 4]
    ldh [hTemp0], a
    push hl
    farcall StatFromGrowthRow
    pop hl
    call ScaleStatByWildLevelCapped999
    ld a, [wSpeciesRecord + SPECIES_GROWTH + 5]
    ldh [hTemp0], a
    push hl
    farcall StatFromGrowthRow
    pop hl
    call ScaleStatByWildLevelCapped999
    ld a, $e7
    ld [hli], a
    ld a, $03
    ld [hli], a
    call StoreRandomByteAtHL_BankA0
    call StoreRandomByteAtHL_BankA0
    call StoreRandomByteAtHL_BankA0
    call StoreRandomByteAtHL_BankA0
    call CopySpeciesExpCurveBRecordToHL_BankA0
    ld a, $00
    ld [hli], a
    ld a, $07
    ld [hli], a
    call RollRecordField0DState_A0
    farcall CheckSkillsLearnableAtLevel
    ld a, [wBattleArg2]
    ld e, a
    ld a, [wBattleArg3]
    ld d, a
    pop bc
    ret

; HL = destination: advances the random table (NextTableByte: wRandomHi + 1 modulo $80, wRandomLo =
; the next RandomByteTable byte) and stores wRandomLo at [HL]; HL advances by 1 and A ends as the
; byte. BC and DE are kept. Used by ApplyLevelScaledStatsToSlots_BuildWildRecord for four
; personality bytes. Same 16 bytes in 2 banks. (C2, E-0385)
; advances the random table (NextTableByte) and stores the new wRandomLo at HL; HL += 1; AF, BC, DE
; kept apart from A = the byte (E-0067) (the same 16 bytes appear in 2 banks)
StoreRandomByteAtHL_BankA0::
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

; hTemp3:hTemp2 = a stat word, HL = destination: multiplies the stat by (wWildLevel / 4 + 100) / 100
; (integer division), keeps at most 999 ($03E7), stores the result back in hTemp2/hTemp3 and writes
; it at [HL]; HL advances by 2. BC and DE are kept; A ends as the high byte of the result. Called
; for each growth-row stat by ApplyLevelScaledStatsToSlots_BuildWildRecord. (C2, E-0385)
; the word hTemp2 = hTemp2 * (wWildLevel / 4 + 100) / 100, capped at 999, stored at [HL+] (E-0125)
ScaleStatByWildLevelCapped999::
    push af
    push bc
    push de
    push hl
    ldh a, [hTemp2]
    ld c, a
    ldh a, [hTemp3]
    ld b, a
    ld a, [wWildLevel]
    rrca
    rrca
    and $3f
    add $64
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    ld a, e
    or a
    jr nz, .set_temp2
    ld bc, $03e7
    ld a, c
    sub l
    ld c, a
    ld a, b
    sbc h
    ld b, a
    bit 7, b
    jr nz, .set_temp2
    jr .set_temp22

.set_temp2:
    ld hl, $03e7

.set_temp22:
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

; HL = destination: stores hTemp2 then hTemp3 there; HL advances by 2 and A is clobbered. Used by
; ApplyLevelScaledStatsToSlots_BuildWildRecord to write the first two scaled stats (the maximum HP
; and MP). Same 7 bytes in 2 banks. (C2, E-0385)
; stores hTemp2 then hTemp3 at HL; HL += 2; clobbers A (E-0065) (the same 7 bytes appear in 2 banks)
StoreTemp2WordAtHL_BankA0::
    ldh a, [hTemp2]
    ld [hli], a
    ldh a, [hTemp3]
    ld [hli], a
    ret

; HL = destination: copies the 27 bytes of wSpeciesRecord from SPECIES_RESISTANCES on (the species
; resistance levels) to HL; HL ends past the copy and A, B and DE are clobbered. Used by
; ApplyLevelScaledStatsToSlots_BuildWildRecord for the resistances of a wild monster record. (C2,
; E-0385)
; copies the 27 ($1B) bytes at wSpeciesRecord + $12 to HL; HL ends past the copy; clobbers A, B, DE
; (E-0065) (the same 12 bytes appear in 2 banks)
CopySpeciesExpCurveBRecordToHL_BankA0::
    ld de, wSpeciesRecord + SPECIES_RESISTANCES
    ld b, $1b

.loop:
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, .loop
    ret

; wBattleArg2/wBattleArg3 = address of a battler record: byte $0D of the record (the sex ratio class
; that ApplyLevelScaledStatsToSlots_BuildWildRecord stored from SPECIES_SEX_RATIO) is rolled to 1 or
; 0. A value of 0 stays 0 and the random table is not stepped; otherwise NextTableByte runs and the
; byte becomes 1 when wRandomLo is below 2 (value 1), below $80 (value 2) or below $E6 (any other
; nonzero value), else 0. Its only caller is ApplyLevelScaledStatsToSlots_BuildWildRecord. (C2,
; E-0385)
; field $0D of record wBattleArg2: values 1, 2 and others roll with thresholds 2, $80 and $E6 and
; become 1 or 0 (E-0125)
RollRecordField0DState_A0::
    ld a, [wBattleArg2]
    add $0d
    ld l, a
    ld a, [wBattleArg3]
    adc $00
    ld h, a
    ld a, [hl]
    or a
    jr z, .done2
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
    jr c, .done
    xor a
    jr .done2

.done:
    ld a, $01

.done2:
    ld [hl], a
    ret

; A = factor, E:H:L = a 24-bit number (E high, L low): the 32-bit product A * E:H:L is returned in
; D:E:H:L (D the top byte). No routine in src/ calls this copy by name. Same 38 bytes as
; Multiply24By8. (C2, E-0385)
; the same 38 bytes as Multiply24By8 (Multiply24By8) (E-0121)
Multiply24By8_BankA0::
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

; Three little-endian RAM addresses, $D1BF, $D20D and $D25B, which are wBattlerRecordSlot4,
; wBattlerRecordSlot5 and wBattlerRecordSlot6 ($4E bytes apart), indexed by the slot counter from C
; (entry c times 2). ApplyLevelScaledStatsToSlots copies the address into wBattleArg2 and
; wBattleArg3 as the destination record for ApplyLevelScaledStatsToSlots_BuildWildRecord, which
; builds a wild monster record there. (C1, E-0381)
ApplyLevelScaledStatsToSlots_Data::
    db $bf, $d1, $0d, $d2, $5b, $d2

; Loads game mode 7's name tiles: blanks the glyph areas at vTiles1 + $500, $550 and $5A0, then
; draws battler 0's and battler 1's names (wBattlerRecords, wBattlerRecordSlot1) at vTiles1 + $500
; and $550 and one trainer name at vTiles1 + $5A0 (wPlayerName, or wLinkSeedCopy for link role bit
; 1). The other name is split: its glyphs up to the second counted one go to vTiles1 + $240 and the
; next ones, up to the fifth counted glyph, to vTiles1 + $4B0 (blanked first); the marks $8D and $8E
; are copied but not counted. (C1, E-0371)
GameMode7_Init_DrawScreen_LoadNameTiles::
    ld a, $90
    ld [wNameGlyphBuf], a
    ld [wNameGlyphBuf + $1], a
    ld [wNameGlyphBuf + $2], a
    ld [wNameGlyphBuf + $3], a
    ld [wNameGlyphBuf + $4], a
    ld a, $f0
    ld [wNameGlyphBuf + $5], a
    ld de, vTiles1 + $500
    call CopyGlyphTilesToVRAM
    ld de, vTiles1 + $550
    call CopyGlyphTilesToVRAM
    ld de, vTiles1 + $5a0
    call CopyGlyphTilesToVRAM
    ld hl, wBattlerRecords
    ld de, wNameGlyphBuf
    ld bc, $000a
    call CopyBytes
    ld de, vTiles1 + $500
    call CopyGlyphTilesToVRAM
    ld hl, wBattlerRecordSlot1
    ld de, wNameGlyphBuf
    ld bc, $000a
    call CopyBytes
    ld de, vTiles1 + $550
    call CopyGlyphTilesToVRAM
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .skip
    ld hl, wPlayerName
    ld de, wNameGlyphBuf
    ld bc, $000a
    call CopyBytes
    ld de, vTiles1 + $5a0
    call CopyGlyphTilesToVRAM
    ld hl, wLinkSeedCopy
    jr .skip2

.skip:
    ld hl, wLinkSeedCopy
    ld de, wNameGlyphBuf
    ld bc, $000a
    call CopyBytes
    ld de, vTiles1 + $5a0
    call CopyGlyphTilesToVRAM
    ld hl, wPlayerName

.skip2:
    ld de, wNameGlyphBuf
    ld bc, $0400

.loop:
    ld a, [hl]
    cp $f0
    jr z, .call_copy_glyph_tiles_to_vram
    cp $8d
    jr z, .skip3
    cp $8e
    jr z, .skip3
    ld a, c
    cp $02
    jr z, .skip4
    inc c
    ld a, [hl]

.skip3:
    ld [de], a
    inc hl
    inc de
    dec b
    jr nz, .loop
    jr .skip4

.call_copy_glyph_tiles_to_vram:
    ld [de], a
    ld de, vTiles1 + $240
    call CopyGlyphTilesToVRAM
    ld a, $90
    ld [wNameGlyphBuf], a
    ld [wNameGlyphBuf + $1], a
    ld [wNameGlyphBuf + $2], a
    ld a, $f0
    ld [wNameGlyphBuf + $3], a
    ld de, vTiles1 + $4b0
    call CopyGlyphTilesToVRAM
    ret

.skip4:
    ld a, $f0
    ld [de], a
    push hl
    push bc
    ld de, vTiles1 + $240
    call CopyGlyphTilesToVRAM
    ld a, $90
    ld [wNameGlyphBuf], a
    ld [wNameGlyphBuf + $1], a
    ld [wNameGlyphBuf + $2], a
    ld a, $f0
    ld [wNameGlyphBuf + $3], a
    ld de, vTiles1 + $4b0
    call CopyGlyphTilesToVRAM
    pop bc
    ld a, b
    add $06
    ld b, a
    pop hl
    ld de, wNameGlyphBuf

.loop2:
    ld a, [hl]
    cp $f0
    jr z, .skip6
    cp $8d
    jr z, .skip5
    cp $8e
    jr z, .skip5
    ld a, c
    cp $05
    jr z, .skip6
    inc c
    ld a, [hl]

.skip5:
    ld [de], a
    inc hl
    inc de
    dec b
    jr nz, .loop2

.skip6:
    ld a, $f0
    ld [de], a
    ld de, vTiles1 + $4b0
    call CopyGlyphTilesToVRAM
    ret

; Fills the $160 bytes from wScreenTileBuffer + $E0 with tile $C3 (the blank tile); the bytes around
; them are not changed. A, BC and HL are clobbered. No routine in src/ calls this copy by name. Same
; 15 bytes in 2 banks. (C2, E-0385)
; Fills the $160 bytes at wScreenTileBuffer + $E0 with $C3; clobbers A, BC, HL (the same 15 bytes
; appear in 2 banks)
FillScreenTileBufferRow11Col4WithC3_BankA0::
    ld hl, wScreenTileBuffer + $e0
    ld bc, $0160

.loop:
    ld a, $c3
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ret

; Copies game mode 7's frame rectangle into the screen buffer. (C2, E-0357; probed E-0385)
GameMode7_Init_DrawScreen_DrawFrame::
    ld hl, GameMode7_Init_DrawScreen_DrawFrame_TileRect
    call ReadScreenBufferRectHeader_BankA0
    call CopyRectToStride32_BankA0
    ret

; Copies the 20 x 13 tile rectangle DrawRectAndWriteDATiles_TileRect into wScreenTileBuffer
; (ReadScreenBufferRectHeader_BankA0, CopyRectToStride32_BankA0); unless bit 1 of wLinkRole is set
; it then writes the tiles $DA to $DE at wScreenTileBuffer + $2B. Its only caller is
; RunBattlePhaseWhenTextIdle_A0_DrawResults, which draws the results frame with it. (C2, E-0385)
; copies rectangle DrawRectAndWriteDATiles_TileRect to the screen buffer; unless bit 1 of wLinkRole
; is set, writes tiles $DA-$DE at wScreenTileBuffer + $2B (E-0122) (E-0344: the address in its name
; dropped or read as the label there; was DrawRectAndWriteDATiles)
DrawRectAndWriteDATiles::
    ld hl, DrawRectAndWriteDATiles_TileRect
    call ReadScreenBufferRectHeader_BankA0
    call CopyRectToStride32_BankA0
    ld a, [wLinkRole]
    bit 1, a
    ret nz
    ld hl, wScreenTileBuffer + $2b
    ld b, $05
    ld a, $da

.loop:
    ld [hli], a
    inc a
    dec b
    jr nz, .loop
    ret

; Draws slots 0 and 1's HP, MP and status marks. (C2, E-0357; probed E-0385)
GameMode7_Init_DrawScreen_DrawSlotPanels::
    ld c, $00
    call DrawSlotPanelValues_BankA0
    ld c, $01

; C = slot: runs DrawSlotHPDigits_BankA0, DrawSlotMPDigits_BankA0 and DrawSlotStatusMarks_BankA0 for
; that slot, which write the HP and MP as three digit tiles and the level and status marks into
; wScreenTileBuffer. GameMode7_Init_DrawScreen_DrawSlotPanels calls it for slot 0 and falls into it
; for slot 1. (C2, E-0385)
; DrawSlotHPDigits_BankA0, DrawSlotMPDigits_BankA0 and DrawSlotStatusMarks_BankA0 for slot C
; (E-0116)
DrawSlotPanelValues_BankA0::
    call DrawSlotHPDigits_BankA0
    call DrawSlotMPDigits_BankA0
    call DrawSlotStatusMarks_BankA0
    ret

; Runs BuildAndCopySlotPanel_A0 for slot 0 and falls into it for slot 1. No routine in src/ calls it
; by name. (C1, E-0385)
; runs BuildAndCopySlotPanel_A0 for slot 0 and falls into it for slot 1 (E-0126)
BuildAndCopySlotPanels0And1_A0::
    ld c, $00
    call BuildAndCopySlotPanel_A0
    ld c, $01

; C = slot: copies the drawn panel of that slot from wScreenTileBuffer to the BG map: its HP digits
; (CopySlotHPDigitsPanelToVRAM_BankA0), its MP digits (CopySlotMPDigitsPanelToVRAM_BankA0) and its
; panel row (CopySlotPanelRowToVRAM_BankA0). Its only caller is BuildAndCopySlotPanels0And1_A0. (C1,
; E-0385)
; runs CopySlotHPDigitsPanelToVRAM_BankA0 and 6C22 for slot C and copies its panel row to VRAM
; (E-0122)
BuildAndCopySlotPanel_A0::
    call CopySlotHPDigitsPanelToVRAM_BankA0
    call CopySlotMPDigitsPanelToVRAM_BankA0
    call CopySlotPanelRowToVRAM_BankA0
    ret

; Copies the 20 x 5 tile block at rows 13-17 of the 32-column screen buffer (written as
; wWindowTileBuffer + $38, which is wScreenTileBuffer + $1A0) to vBGMap0 + $1A0
; (CopyRect32StrideToVRAM_BankA0); the bank-$A0 copy of CopyMessageBoxToBGMapRow13 (bank $31). Its
; callers are RunBattleSetup_BankA0 steps such as RunBattleSetup_BankA0_EntrySelect_DrawRecordFrame,
; RunBattleSetup_BankA0_CommandMenu_ShowButThereIsNo and
; RunBattleSetup_BankA0_CommandMenu_ShowSkillError. (C1, E-0372)
; copies a 20 x 5 rectangle from wWindowTileBuffer + $38 (rows 32 bytes apart) to vBGMap0 + $1A0
; (row 13) with CopyRect32StrideToVRAM_BankA0, as CopyMessageBoxToBGMapRow13 does in bank $31
; (E-0076) (E-0340: the address in its name read as its RAM name; was DrawRows13To17ToBGMap_BankA0)
DrawRows13To17ToBGMap_BankA0::
    ld de, wWindowTileBuffer + $38
    ld hl, vBGMap0 + $1a0
    lb bc, $14, $05
    call CopyRect32StrideToVRAM_BankA0
    ret

; Copies the 14 x 5 tile block at row 13, column 0 of the 32-column screen buffer (written as
; wWindowTileBuffer + $38, which is wScreenTileBuffer + $1A0) to vBGMap0 row 13
; (CopyRect32StrideToVRAM_BankA0): the choice window that RunBattleSetup_BankA0_EntrySelect draws in
; steps 1 and 3. (C1, E-0371)
RunBattleSetup_BankA0_EntrySelect_DrawWindow::
    ld de, wWindowTileBuffer + $38
    ld hl, vBGMap0 + $1a0
    lb bc, $0e, $05
    call CopyRect32StrideToVRAM_BankA0
    ret

; Copies the 20 x 11 tile block at rows 7-17 of the 32-column screen buffer (wScreenTileBuffer +
; $E0) to vBGMap0 + $E0 (CopyRect32StrideToVRAM_BankA0). Callers:
; RunBattleSetup_BankA0_CommandMenu_ShowCommands, RunBattleSetup_BankA0_CommandMenu_BackToChoosing
; and RunBattleSetup_BankA0_CommandMenu_ShowTacticCursor. (C1, E-0372)
; copies a 20 x 11 rectangle from wScreenTileBuffer + $E0 to vBGMap0 + $E0 (row 7) with
; CopyRect32StrideToVRAM_BankA0 (E-0116) (E-0340: the address in its name read as its RAM name; was
; DrawRows7To17ToBGMap_BankA0)
DrawRows7To17ToBGMap_BankA0::
    ld de, wScreenTileBuffer + $e0
    ld hl, vBGMap0 + $e0
    lb bc, $14, $0b
    call CopyRect32StrideToVRAM_BankA0
    ret

; Copies the 11 x 9 tile block at rows 9-17, columns 0-10 of the 32-column screen buffer
; (wScreenTileBuffer + $120) to vBGMap0 + $120 (CopyRect32StrideToVRAM_BankA0). Callers:
; RunBattleSetup_BankA0_CommandMenu_CursorOnCommand, RunBattleSetup_BankA0_CommandMenu_AfterCommand,
; RunBattleSetup_BankA0_CommandMenu_PrepareMessage and RunBattleSetup_BankA0_CommandMenu_ShowSkills.
; (C1, E-0372)
; copies an 11 x 9 rectangle from wScreenTileBuffer + $120 to vBGMap0 + $120 (row 9) with
; CopyRect32StrideToVRAM_BankA0 (E-0111) (E-0340: the address in its name read as its RAM name; was
; DrawRect11x9AtRow9ToBGMap_BankA0)
DrawRect11x9AtRow9ToBGMap_BankA0::
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    lb bc, $0b, $09
    call CopyRect32StrideToVRAM_BankA0
    ret

; Copies the 20 x 9 tile block at rows 9-17 of the 32-column screen buffer (wScreenTileBuffer +
; $120) to vBGMap0 + $120 (CopyRect32StrideToVRAM_BankA0), then sets wBattleArg0 = 1. No caller is
; known: no reference in src/, and the listing found it only after a terminator. (C1, E-0372)
; copies a 20 x 9 rectangle from wScreenTileBuffer + $120 to vBGMap0 + $120 (row 9), then
; wBattleArg0 = 1 (E-0116) (E-0340: the address in its name read as its RAM name; was
; DrawRows9To17ToBGMap_BankA0)
DrawRows9To17ToBGMap_BankA0::
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    lb bc, $14, $09
    call CopyRect32StrideToVRAM_BankA0
    ld a, $01
    ld [wBattleArg0], a
    ret

; Copies the 8 x 9 tile block at rows 9-17, columns 0-7 of the 32-column screen buffer
; (wScreenTileBuffer + $120) to vBGMap0 + $120 (CopyRect32StrideToVRAM_BankA0). No caller is known:
; no reference in src/, and the listing found it only after a terminator. (C1, E-0372)
; copies an 8 x 9 rectangle from wScreenTileBuffer + $120 to vBGMap0 + $120 (row 9) (E-0116)
; (E-0340: the address in its name read as its RAM name; was DrawRect8x9AtRow9ToBGMap_BankA0)
DrawRect8x9AtRow9ToBGMap_BankA0::
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    lb bc, $08, $09
    call CopyRect32StrideToVRAM_BankA0
    ret

; Copies the 7 x 7 tile block at rows 11-17, columns 0-6 of the 32-column screen buffer
; (wScreenTileBuffer + $160) to vBGMap0 + $160 (CopyRect32StrideToVRAM_BankA0). No caller is known:
; no reference in src/, and the listing found it only after a terminator. (C1, E-0372)
; copies a 7 x 7 rectangle from wScreenTileBuffer + $160 to vBGMap0 + $160 (row 11) (E-0116)
; (E-0340: the address in its name read as its RAM name; was DrawRect7x7AtRow11ToBGMap_BankA0)
DrawRect7x7AtRow11ToBGMap_BankA0::
    ld de, wScreenTileBuffer + $160
    ld hl, vBGMap0 + $160
    lb bc, $07, $07
    call CopyRect32StrideToVRAM_BankA0
    ret

; Copies two blocks of the 32-column screen buffer to the same places in vBGMap0
; (CopyRect32StrideToVRAM_BankA0): the 7 x 1 strip at row 8, columns 12-18 (wScreenTileBuffer +
; $10C) and the 20 x 9 block at rows 9-17 (wScreenTileBuffer + $120). Callers:
; RunBattleSetup_BankA0_CommandMenu_ShowSkillCursor, RunBattleSetup_BankA0_CommandMenu_ReturnToStep
; and RunBattleSetup_BankA0_CommandMenu_DrawRecordFrame. (C1, E-0372)
; copies 7 x 1 from wScreenTileBuffer + $10C to vBGMap0 + $10C and 20 x 9 from wScreenTileBuffer +
; $120 to vBGMap0 + $120 (CopyRect32StrideToVRAM_BankA0) (E-0118) (E-0340: the address in its name
; read as its RAM name; was DrawRow8AndRows9To17ToBGMap_BankA0)
DrawRow8AndRows9To17ToBGMap_BankA0::
    ld de, wScreenTileBuffer + $10c
    ld hl, vBGMap0 + $10c
    lb bc, $07, $01
    call CopyRect32StrideToVRAM_BankA0
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    lb bc, $14, $09
    call CopyRect32StrideToVRAM_BankA0
    ret

; Copies the 13 x 7 tile block at rows 11-17, columns 0-12 of the 32-column screen buffer
; (wScreenTileBuffer + $160) to vBGMap0 + $160 (CopyRect32StrideToVRAM_BankA0). No caller is known:
; no reference in src/, and the listing found it only after a terminator. (C1, E-0372)
; copies a 13 x 7 rectangle from wScreenTileBuffer + $160 to vBGMap0 + $160 (row 11) (E-0116)
; (E-0340: the address in its name read as its RAM name; was DrawRect13x7AtRow11ToBGMap_BankA0)
DrawRect13x7AtRow11ToBGMap_BankA0::
    ld de, wScreenTileBuffer + $160
    ld hl, vBGMap0 + $160
    lb bc, $0d, $07
    call CopyRect32StrideToVRAM_BankA0
    ret

; DE = source tiles, HL = BG map address, B = width, C = rows: copies C rows of B tiles with
; WriteVRAMByteInc; after each row HL moves $20 on and DE moves to $20 past the start of that source
; row, so source and destination rows are both 32 bytes apart. B is kept. Callers:
; DrawRows13To17ToBGMap_BankA0, DrawRows9To17ToBGMap_BankA0, DrawRows7To17ToBGMap_BankA0,
; DrawRow8AndRows9To17ToBGMap_BankA0, DrawRect11x9AtRow9ToBGMap_BankA0,
; DrawRect13x7AtRow11ToBGMap_BankA0, DrawRect7x7AtRow11ToBGMap_BankA0,
; DrawRect8x9AtRow9ToBGMap_BankA0 and RunBattleSetup_BankA0_EntrySelect_DrawWindow. Same 28 bytes as
; CopyRect32StrideToVRAM. (C1, E-0385)
; the same 28 bytes as CopyRect32StrideToVRAM (CopyRect32StrideToVRAM) (E-0060)
CopyRect32StrideToVRAM_BankA0::
    push bc
    push hl

.loop:
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, .loop
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    ld a, $20
    sub b
    add e
    ld e, a
    jr nc, .next
    inc d

.next:
    dec c
    jr nz, CopyRect32StrideToVRAM_BankA0
    ret

; HL = a 4-byte header (word offset, width, rows): returns HL = wScreenTileBuffer + offset, B =
; width, C = rows and DE = the address just after the header. Callers:
; GameMode7_Init_DrawScreen_DrawFrame and DrawRectAndWriteDATiles. Same 15 bytes in 2 banks. (C2,
; E-0385)
; reads a 4-byte header at HL (word offset, width, rows): returns HL = wScreenTileBuffer + offset, B
; = width, C = rows, DE = the byte after the header (E-0065) (the same 15 bytes appear in 2 banks)
ReadScreenBufferRectHeader_BankA0::
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld c, [hl]
    inc hl
    push hl
    ld hl, wScreenTileBuffer
    add hl, de
    pop de
    ret

; DE = source (rows packed), HL = destination, B = width, C = rows: copies a B x C rectangle with
; the destination rows 32 bytes apart; DE ends past the source, HL at the start of the row below the
; last one, B is kept and C ends 0. Callers: GameMode7_Init_DrawScreen_DrawFrame and
; DrawRectAndWriteDATiles. Same 18 bytes in 2 banks. (C2, E-0385)
; DE = source (rows packed), HL = destination with rows 32 bytes apart, B = width, C = rows: copies
; a B x C rectangle; DE ends past the source, HL at the start of the row below; B kept, C = 0
; (E-0065) (the same 18 bytes appear in 2 banks)
CopyRectToStride32_BankA0::
    push bc
    push hl

.loop:
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, .loop
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, CopyRectToStride32_BankA0
    ret

; a tile-rectangle record for CopyRecordRectToScreenBuffer (E-0161)
; record: offset $0000 (row 0, column 0); 20 x 7 tiles
GameMode7_Init_DrawScreen_DrawFrame_TileRect::
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $14, $07 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b2, $b1, $b1, $b1, $b1, $b1, $b2, $b0, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $d0, $d1, $d2, $d3, $d4, $b7, $da, $db, $dc, $dd, $de, $b7, $b6, $d5, $d6, $d7, $d8, $d9, $b7 ; row 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $ba, $b4, $b4, $b4, $b4, $b4, $b5, $b8, $b9, $b9, $b9, $b9, $b9, $ba ; row 2
    db $b6, $eb, $c3, $c3, $c3, $c3, $b7, $c3, $c3, $c3, $c3, $c3, $c3, $b6, $eb, $c3, $c3, $c3, $c3, $b7 ; row 3
    db $b6, $ec, $c3, $c3, $c3, $c3, $b7, $b0, $b1, $b1, $b1, $b1, $b1, $b6, $ec, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $ea, $af, $c3, $c3, $c3, $b7, $b6, $a4, $a5, $cb, $cc, $cd, $b6, $ea, $af, $c3, $c3, $c3, $b7 ; row 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b5, $b3, $b4, $b4, $b4, $b4, $b4, $b3, $b4, $b4, $b4, $b4, $b4, $b5 ; row 6

; record: offset $0000 (row 0, column 0); 20 x 13 tiles
DrawRectAndWriteDATiles_TileRect::
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $14, $0d ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2, $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $f0, $f1, $f2, $f3, $f4, $f5, $f6, $c3, $b7, $b6, $a4, $a5, $cb, $cc, $cd, $c3, $c3, $c3, $b7 ; row 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba, $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; row 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $af, $fb, $e1, $b7, $b6, $f7, $f8, $f9, $c3, $fa, $af, $c3, $c3, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $fc, $fd, $fe, $ff, $00, $af, $c3, $c3, $b7, $b6, $0e, $0f, $10, $c3, $11, $af, $c3, $c3, $b7 ; row 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 6
    db $b6, $01, $02, $03, $04, $05, $af, $c3, $c3, $b7, $b6, $12, $13, $14, $c3, $15, $af, $c3, $c3, $b7 ; row 7
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 8
    db $b6, $06, $07, $08, $09, $c3, $af, $c3, $c3, $b7, $b6, $16, $17, $18, $c3, $19, $af, $c3, $c3, $b7 ; row 9
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 10
    db $b6, $0a, $0b, $0c, $0d, $c3, $af, $c3, $c3, $b7, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; row 11
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; row 12

; Start-up of game mode 7, the link battle (RunGameModeInit_LinkBattle far-calls it). It clears the
; STAT interrupt sources and queues music 2; when wSGBActive is set it clears wSGBPaletteSet and
; wSGBAttrFile and sends the SGB palette set packet. It zeroes the scroll (hScrollX, hScrollY and
; their high bytes), fills vBGMap0 with tile $C3 and, when wIsCGB is set, fills the attribute map in
; VRAM bank 1 with 0. The text cursor is set to vBGMap0 + $1C1, LetterFrameIconTiles is decompressed
; to vTiles1 + $240 and DigitLvHpMpTiles to vTiles1 + $5F0 (bank $31), and GameMode7_Init_Start sets
; up the battle (state, linked records, slots, screen, music, marks). Last it requests a tile fill
; at vTiles1 (FillTilesRequest, size $1202), resets the text cursor, starts a palette fade
; (StartPaletteFade with A = $FC), sets hWindowX = 7, hWindowY = $FF, the scroll to 0 and
; wLCDCShadow = 3, and jumps to ResumeAfterModeChange with A = $0B. (C1, E-0385)
; start-up for wGameMode = 7; forcing this mode on the emulator shows: two monster panels when
; forced (E-0029)
GameMode7_Init::
    call ClearSTATInterruptSources
    ld a, $02
    call QueueMusic
    ld a, [wSGBActive]
    or a
    jr z, .clear_scroll_x
    ld a, $00
    ld [wSGBPaletteSet], a
    ld a, $00
    ld [wSGBAttrFile], a
    farcall SendSGBPaletteSetPacket

.clear_scroll_x:
    xor a
    ldh [hScrollX], a
    ldh [hScrollXHi], a
    xor a
    ldh [hScrollY], a
    ldh [hScrollYHi], a
    ld hl, vBGMap0
    ld bc, $0400
    ld a, $c3
    call FillBytes
    ld a, [wIsCGB]
    or a
    jr z, .set_text_cursor_lo
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0
    ld bc, $0400
    xor a
    call FillBytes
    xor a
    ldh [rVBK], a

.set_text_cursor_lo:
    ld hl, vBGMap0 + $1c1
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    ld b, BANK(LetterFrameIconTiles)
    ld de, LetterFrameIconTiles
    ld hl, vTiles1 + $240
    call DecompressToRAMLocked
    ld b, BANK(LetterFrameIconTiles)
    ld de, DigitLvHpMpTiles
    ld hl, vTiles1 + $5f0
    call DecompressToRAMLocked
    call GameMode7_Init_Start
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld hl, vBGMap0 + $1c1
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    ld a, $fc
    call StartPaletteFade
    ld a, $07
    ldh [hWindowX], a
    ld a, $ff
    ldh [hWindowY], a
    ld a, $00
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    ld a, $03
    ld [wLCDCShadow], a
    ld a, $0b
    jp ResumeAfterModeChange

; Per-frame routine of game mode 7 (RunGameModeUpdate_LinkBattle far-calls it). It runs
; LinkExchangeJoypadPerFrame, then returns when wEffectId is $FF (no effect playing). Otherwise it
; runs RunBattleEffectAnimation, and when wEffectAnimState is 2 it runs TickSequencePtrLoSequence
; with interrupts disabled. (C1, E-0385)
; per-frame routine for wGameMode = 7
GameMode7_Update::
    call LinkExchangeJoypadPerFrame
    ld a, [wEffectId]
    cp $ff
    ret z
    farcall RunBattleEffectAnimation
    ld a, [wEffectAnimState]
    cp $02
    ret nz
    di
    farcall TickSequencePtrLoSequence
    ei
    ret

; Runs the current phase of the game mode 7 battle, but only while wTextFlags is 0 (no text being
; printed); otherwise it returns at once. wBattlePhase picks the phase: 0
; RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters, 1 RunBattlePhaseWhenTextIdle_A0_RunTurn, 2
; RunBattlePhaseWhenTextIdle_A0_SyncLink and 3 RunBattlePhaseWhenTextIdle_A0_ResultsScreen. Its
; caller is RunLinkSession7Exchange_Receive. (C1, E-0385)
; unless wTextFlags is set (text busy), runs the routine for wBattlePhase (jump table of four)
; (E-0122)
RunBattlePhaseWhenTextIdle_A0::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wBattlePhase]
    jumptable
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters
    dw RunBattlePhaseWhenTextIdle_A0_RunTurn
    dw RunBattlePhaseWhenTextIdle_A0_SyncLink
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen

; Phase 0 of the game mode 7 battle. It jumps on wBattleStep (19 steps): 0-5 are the link handshake
; and the shared random seed (RunBattlePhaseWhenTextIdle_A0_IntroAfterFade,
; RunBattlePhaseWhenTextIdle_A0_IntroPartnerReady, RunBattlePhaseWhenTextIdle_A0_IntroSendSeed,
; RunBattlePhaseWhenTextIdle_A0_IntroSeedReceived, RunBattlePhaseWhenTextIdle_A0_IntroAckSeed,
; RunBattlePhaseWhenTextIdle_A0_IntroShareSeed), 6 sets up the foes
; (RunBattlePhaseWhenTextIdle_A0_IntroSetUpFoes), 7 shows the Team Mode battle text
; (RunBattlePhaseWhenTextIdle_A0_IntroShowText), 8-16 name, load and draw the picture of each of the
; three foes ('The first monster is 0!' and so on), 17 shows 'Please wait'
; (RunBattlePhaseWhenTextIdle_A0_ShowPleaseWait) and 18 (RunBattlePhaseWhenTextIdle_A0_IntroFinish)
; moves to the next phase when the partner answers 1. (C1, E-0385)
; by wBattleStep: waits for the link, computes the wild level and shows each opposing monster's
; picture ('The first/second/third monster is 0!', 'Please wait')
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters::
    ld a, [wBattleStep]
    jumptable
    dw RunBattlePhaseWhenTextIdle_A0_IntroAfterFade
    dw RunBattlePhaseWhenTextIdle_A0_IntroPartnerReady
    dw RunBattlePhaseWhenTextIdle_A0_IntroSendSeed
    dw RunBattlePhaseWhenTextIdle_A0_IntroSeedReceived
    dw RunBattlePhaseWhenTextIdle_A0_IntroAckSeed
    dw RunBattlePhaseWhenTextIdle_A0_IntroShareSeed
    dw RunBattlePhaseWhenTextIdle_A0_IntroSetUpFoes
    dw RunBattlePhaseWhenTextIdle_A0_IntroShowText
    dw RunBattlePhaseWhenTextIdle_A0_NameFirstMonster
    dw RunBattlePhaseWhenTextIdle_A0_LoadFirstPicture
    dw RunBattlePhaseWhenTextIdle_A0_DrawFirstPicture
    dw RunBattlePhaseWhenTextIdle_A0_NameSecondMonster
    dw RunBattlePhaseWhenTextIdle_A0_LoadSecondPicture
    dw RunBattlePhaseWhenTextIdle_A0_DrawSecondPicture
    dw RunBattlePhaseWhenTextIdle_A0_NameThirdMonster
    dw RunBattlePhaseWhenTextIdle_A0_LoadThirdPicture
    dw RunBattlePhaseWhenTextIdle_A0_DrawThirdPicture
    dw RunBattlePhaseWhenTextIdle_A0_ShowPleaseWait
    dw RunBattlePhaseWhenTextIdle_A0_IntroFinish

; Game mode 7's introduction, step 0: after the fade sends $0C. (C2, E-0357; probed E-0385)
RunBattlePhaseWhenTextIdle_A0_IntroAfterFade::
    ld a, [wFadeState]
    and a
    ret nz
    ld hl, wBattleStep
    inc [hl]
    ld a, $0c
    ld [wLinkSendByte], a
    ret

; Introduction, step 1: when the partner answers $0C goes on. (C2, E-0357; probed E-0385)
RunBattlePhaseWhenTextIdle_A0_IntroPartnerReady::
    ld a, [wLinkMessage]
    cp $0c
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld hl, wBattleStep
    inc [hl]
    ret

; Introduction, step 2: starts a 2-byte exchange of the random seed (wRandomLo/Hi out, into
; wLinkPartnerName). (C2, E-0357; probed E-0385)
RunBattlePhaseWhenTextIdle_A0_IntroSendSeed::
    ld hl, wBattleStep
    inc [hl]
    ld a, [wRandomLo]
    ld [wLinkRecvBuffer], a
    ld a, [wRandomHi]
    ld [wIntroOrFamilyCount], a
    ld hl, wLinkRecvBuffer
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, wLinkPartnerName
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $02
    ld [wLinkBufferCountLo], a
    ld a, $ff
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; Introduction, step 3: when the exchange ends ($F0) goes on. (C2, E-0357; probed E-0385)
RunBattlePhaseWhenTextIdle_A0_IntroSeedReceived::
    ld a, [wLinkMessage]
    cp $f0
    ret nz
    xor a
    ld [wLinkSendByte], a
    xor a
    ld [wLinkReady], a
    ld hl, wBattleStep
    inc [hl]
    ret

; Introduction, step 4: sends 3. (C2, E-0357; probed E-0385)
RunBattlePhaseWhenTextIdle_A0_IntroAckSeed::
    ld hl, wBattleStep
    inc [hl]
    ld a, $03
    ld [wLinkSendByte], a
    ret

; Introduction, step 5: on the partner's 3 both sides take one seed (its own, or the partner's for
; link role bit 1) as wRandomLo/Hi and the second seed. (C2, E-0357; probed E-0385)
RunBattlePhaseWhenTextIdle_A0_IntroShareSeed::
    ld a, [wLinkMessage]
    cp $03
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .read_link_partner_name
    ld a, [wRandomLo]
    ld l, a
    ld a, [wRandomHi]
    ld h, a
    jr .set_link_partner_name

.read_link_partner_name:
    ld a, [wLinkPartnerName]
    ld l, a
    ld a, [wLinkPartnerByte1]
    ld h, a

.set_link_partner_name:
    ld a, l
    ld [wLinkPartnerName], a
    ld [wRandomSeed2Lo], a
    ld [wRandomLo], a
    ld a, h
    ld [wLinkPartnerByte1], a
    ld [wRandomSeed2Hi], a
    ld [wRandomHi], a
    ld hl, wBattleStep
    inc [hl]
    ret

; Introduction, step 6: sets up the foes: with wScreenCountPlusOne 2 two foes (encounter kind 1)
; from backed-up battler records; otherwise three wild monsters (encounter kind 2) at the computed
; wild level. (C2, E-0357; probed E-0385)
RunBattlePhaseWhenTextIdle_A0_IntroSetUpFoes::
    call InitBattleSlotsForFoeCount
    ld a, [wScreenCountPlusOne]
    cp $02
    jr z, .set_encounter_kind_to_01
    ld a, $02
    ld [wEncounterKind], a
    ld bc, $0300
    call ComputeWildLevelAndScaleStats
    call PrepareThreeFoeSlots
    ld hl, wBattleStep
    inc [hl]
    ret

.set_encounter_kind_to_01:
    ld a, $01
    ld [wEncounterKind], a
    ld a, $02
    ld [wBattleFoeCount], a
    ld a, $02
    ld [wSide1Flag], a
    call BackupBattlerRecords0And1
    call PrepareTwoFoeSlots
    ld hl, wBattleStep
    inc [hl]
    ret

; Team Mode introduction, step 7: after the fade (wFadeState 0) shows string wScreenCountPlusOne of
; category 6 (BeginStringDisplay_Bank07): 'Team Mode battle No. 1!', 'Team Mode battle No. 2!' or
; 'Team Mode final battle!' for 0, 1 and 2; next step. (C1, E-0372)
RunBattlePhaseWhenTextIdle_A0_IntroShowText::
    ld a, [wFadeState]
    or a
    ret nz
    ld a, [wScreenCountPlusOne]
    ld [wStringIndex], a
    ld a, $06
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank07
    ld hl, wBattleStep
    inc [hl]
    ret

; Introduction, step 8: 'The first monster is <name>!' (string 3 of category 6). (C1, E-0357)
RunBattlePhaseWhenTextIdle_A0_NameFirstMonster::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, [wBattlePictureIds]
    ld l, a
    ld a, [wBattlePictureIds + $1]
    add $02
    ld h, a
    ld de, wTextBuf0
    call CopyStringHLToDE
    ld a, $03
    ld [wStringIndex], a ; 'The first monster is 0!'
    ld a, $06
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank07
    ld hl, wBattleStep
    inc [hl]
    ret

; Introduction, step 9: loads the first monster's picture into VRAM $9140 (palette 1). (C1, E-0357)
RunBattlePhaseWhenTextIdle_A0_LoadFirstPicture::
    ld a, [wIsCGB]
    or a
    jr z, .read_battle_picture_ids
    ld de, $0000
    ld hl, vBGMap0 + $e1
    ld a, $01
    ldh [hTemp0], a
    call LoadMonsterPictureAttributes

.read_battle_picture_ids:
    ld a, [wBattlePictureIds]
    ld e, a
    ld a, [wBattlePictureIds + $1]
    ld d, a
    ld hl, vTiles2 + $140
    ld c, $01
    call LoadMonsterPicture
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    ld hl, wBattleStep
    inc [hl]
    ret

; Introduction, step 10: draws the first picture's 6 x 6 tiles (at column 1, or 4 with two foes)
; with its attributes on the GBC. (C1, E-0357)
RunBattlePhaseWhenTextIdle_A0_DrawFirstPicture::
    ld hl, vBGMap0 + $e1
    ld a, [wScreenCountPlusOne]
    cp $02
    jr nz, .call_run_battle_phase_when_text_idle_a0_draw
    ld hl, vBGMap0 + $e4

.call_run_battle_phase_when_text_idle_a0_draw:
    ld d, $14
    call RunBattlePhaseWhenTextIdle_A0_DrawPictureTiles
    ld a, [wIsCGB]
    or a
    jr z, .done
    ld hl, vBGMap0 + $e1
    ld a, [wScreenCountPlusOne]
    cp $02
    jr nz, .set_temp0_to_01
    ld hl, vBGMap0 + $e4

.set_temp0_to_01:
    ld a, $01
    ldh [hTemp0], a
    ld a, [wBattlePictureIds]
    ld e, a
    ld a, [wBattlePictureIds + $1]
    ld d, a
    call LoadMonsterPictureAttributes

.done:
    ld hl, wBattleStep
    inc [hl]
    ret

; Introduction, step 11: 'The second monster is <name>!' (string 4). (C1, E-0357)
RunBattlePhaseWhenTextIdle_A0_NameSecondMonster::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, [wBattlePictureIds + $2]
    ld l, a
    ld a, [wBattlePictureIds + $3]
    add $02
    ld h, a
    ld de, wTextBuf0
    call CopyStringHLToDE
    ld a, $04
    ld [wStringIndex], a ; 'The second monster is 0!'
    ld a, $06
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank07
    ld hl, wBattleStep
    inc [hl]
    ret

; Introduction, step 12: loads the second monster's picture into VRAM $9380 (palette 3). (C1,
; E-0357)
RunBattlePhaseWhenTextIdle_A0_LoadSecondPicture::
    ld a, [wBattlePictureIds + $2]
    ld e, a
    ld a, [wBattlePictureIds + $3]
    ld d, a
    ld hl, vTiles2 + $380
    ld c, $03
    call LoadMonsterPicture
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    ld hl, wBattleStep
    inc [hl]
    ret

; Introduction, step 13: draws the second picture (column 7, or 10 with two foes, then skipping the
; third). (C1, E-0357)
RunBattlePhaseWhenTextIdle_A0_DrawSecondPicture::
    ld hl, vBGMap0 + $e7
    ld a, [wScreenCountPlusOne]
    cp $02
    jr nz, .call_run_battle_phase_when_text_idle_a0_draw
    ld a, [wBattleStep]
    add $03
    ld [wBattleStep], a
    ld hl, vBGMap0 + $ea

.call_run_battle_phase_when_text_idle_a0_draw:
    ld d, $38
    call RunBattlePhaseWhenTextIdle_A0_DrawPictureTiles
    ld a, [wIsCGB]
    or a
    jr z, .done
    ld hl, vBGMap0 + $e7
    ld a, [wScreenCountPlusOne]
    cp $02
    jr nz, .set_temp0_to_03
    ld hl, vBGMap0 + $ea

.set_temp0_to_03:
    ld a, $03
    ldh [hTemp0], a
    ld a, [wBattlePictureIds + $2]
    ld e, a
    ld a, [wBattlePictureIds + $3]
    ld d, a
    call LoadMonsterPictureAttributes

.done:
    ld hl, wBattleStep
    inc [hl]
    ret

; Introduction, step 14: 'The third monster is <name>!' (string 5). (C1, E-0357)
RunBattlePhaseWhenTextIdle_A0_NameThirdMonster::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, [wBattlePictureIds + $4]
    ld l, a
    ld a, [wBattlePictureIds + $5]
    add $02
    ld h, a
    ld de, wTextBuf0
    call CopyStringHLToDE
    ld a, $05
    ld [wStringIndex], a ; 'The third monster is 0!'
    ld a, $06
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank07
    ld hl, wBattleStep
    inc [hl]
    ret

; Introduction, step 15: loads the third monster's picture into VRAM $95C0 (palette 5). (C1, E-0357)
RunBattlePhaseWhenTextIdle_A0_LoadThirdPicture::
    ld a, [wBattlePictureIds + $4]
    ld e, a
    ld a, [wBattlePictureIds + $5]
    ld d, a
    ld hl, vTiles2 + $5c0
    ld c, $05
    call LoadMonsterPicture
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    ld hl, wBattleStep
    inc [hl]
    ret

; Introduction, step 16: draws the third picture at column 13. (C1, E-0357)
RunBattlePhaseWhenTextIdle_A0_DrawThirdPicture::
    ld d, $5c
    ld hl, vBGMap0 + $ed
    call RunBattlePhaseWhenTextIdle_A0_DrawPictureTiles
    ld a, [wIsCGB]
    or a
    jr z, .done
    ld hl, vBGMap0 + $ed
    ld a, $05
    ldh [hTemp0], a
    ld a, [wBattlePictureIds + $4]
    ld e, a
    ld a, [wBattlePictureIds + $5]
    ld d, a
    call LoadMonsterPictureAttributes

.done:
    ld hl, wBattleStep
    inc [hl]
    ret

; Introduction, step 17: 'Please wait.' and sends 1. (C1, E-0357)
RunBattlePhaseWhenTextIdle_A0_ShowPleaseWait::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, $05
    ld [wStringCategory], a
    ld a, $0c
    ld [wStringIndex], a ; 'Please wait.'
    farcall ShowString_Bank07
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wBattleStep
    inc [hl]
    ret

; Introduction, step 18: on the partner's 1 goes to the next battle phase. (C2, E-0357; probed
; E-0385)
RunBattlePhaseWhenTextIdle_A0_IntroFinish::
    ld a, [wLinkMessage]
    cp $01
    ret nz
    xor a
    ld [wBattleStep], a
    xor a
    ld [wLinkSendByte], a
    ld hl, wBattlePhase
    inc [hl]
    ret

; Writes a 6 x 6 block of tile numbers from D on at HL in the BG map. (C1, E-0357)
RunBattlePhaseWhenTextIdle_A0_DrawPictureTiles::
    ld bc, $0606

.loop:
    ld a, d
    inc d
    call WriteVRAMByteInc
    dec b
    jr nz, .loop
    ld a, l
    add $1a
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld b, $06
    dec c
    jr nz, .loop
    ret

; Phase 1 of the game mode 7 battle. It jumps on wBattleStep: 0
; RunBattlePhaseWhenTextIdle_A0_RunTurn_Begin (resets the turn), 1
; RunBattlePhaseWhenTextIdle_A0_RunTurn_Setup (RunBattleSetup_BankA0), 2
; RunBattlePhaseWhenTextIdle_A0_RunTurn_Commands (the command entry in bank $A1), 3
; RunBattlePhaseWhenTextIdle_A0_RunTurn_Actions (RunBattleActions) and 4
; RunBattlePhaseWhenTextIdle_A0_RunTurn_FightStep (RunBattleStep4). (C1, E-0385)
; by wBattleStep: clears a buffer, then RunBattleSetup_BankA0, the command entry (bank $A1),
; RunBattleActions and RunBattleStep4
RunBattlePhaseWhenTextIdle_A0_RunTurn::
    ld a, [wBattleStep]
    jumptable
    dw RunBattlePhaseWhenTextIdle_A0_RunTurn_Begin
    dw RunBattlePhaseWhenTextIdle_A0_RunTurn_Setup
    dw RunBattlePhaseWhenTextIdle_A0_RunTurn_Commands
    dw RunBattlePhaseWhenTextIdle_A0_RunTurn_Actions
    dw RunBattlePhaseWhenTextIdle_A0_RunTurn_FightStep

; Game mode 7's turn, step 0: resets the turn (RunBattlePhaseWhenTextIdle_A0_RunTurn_Reset) and
; advances wBattleStep. When the reset found neither slot 0 nor 1 with mark 0 it has already
; advanced the step once, so step 1 (RunBattleSetup_BankA0) is skipped and the turn goes straight to
; the command entry (step 2). (C2, E-0371; probed E-0385)
RunBattlePhaseWhenTextIdle_A0_RunTurn_Begin::
    call RunBattlePhaseWhenTextIdle_A0_RunTurn_Reset
    ld hl, wBattleStep
    inc [hl]
    ret

; Game mode 7's turn, step 1: the battle setup (RunBattleSetup_BankA0). (C1, E-0357)
RunBattlePhaseWhenTextIdle_A0_RunTurn_Setup::
    call RunBattleSetup_BankA0
    ret

; Game mode 7's turn, step 2: the command entry (RunBattleCommandEntry_BankA1). (C1, E-0357)
RunBattlePhaseWhenTextIdle_A0_RunTurn_Commands::
    farcall RunBattleCommandEntry_BankA1
    ret

; Game mode 7's turn, step 3: the actions (RunBattleActions). (C1, E-0357)
RunBattlePhaseWhenTextIdle_A0_RunTurn_Actions::
    farcall RunBattleActions
    ret

; Game mode 7's turn, step 4: fight step 4 (RunBattleStep4). (C1, E-0357)
RunBattlePhaseWhenTextIdle_A0_RunTurn_FightStep::
    farcall RunBattleStep4
    ret

; Phase 2 of the game mode 7 battle (the end of a round, with the partner over the link). It jumps
; on wBattleStep: 0 RunBattlePhaseWhenTextIdle_A0_SyncLink_Start (sends 1), 1
; RunBattlePhaseWhenTextIdle_A0_SyncLink_SendSlots (sends wBattleSlotOut), 2
; RunBattlePhaseWhenTextIdle_A0_SyncLink_TakeOutFlag (takes the partner out flag), 3
; RunBattlePhaseWhenTextIdle_A0_SyncLink_CountTurns, 4
; RunBattlePhaseWhenTextIdle_A0_SyncLink_CountRound (shows 'Please wait.'), 5
; RunBattlePhaseWhenTextIdle_A0_SyncLink_BlankPics, 6
; RunBattlePhaseWhenTextIdle_A0_SyncLink_ClearAttrs, 7
; RunBattlePhaseWhenTextIdle_A0_SyncLink_SendReady (sends 1) and 8
; RunBattlePhaseWhenTextIdle_A0_SyncLink_NextRound, which returns to phase 0 when the partner
; answers 1. (C1, E-0385)
; by wBattleStep: exchanges bytes and messages over the link ('Please wait.')
RunBattlePhaseWhenTextIdle_A0_SyncLink::
    ld a, [wBattleStep]
    jumptable
    dw RunBattlePhaseWhenTextIdle_A0_SyncLink_Start
    dw RunBattlePhaseWhenTextIdle_A0_SyncLink_SendSlots
    dw RunBattlePhaseWhenTextIdle_A0_SyncLink_TakeOutFlag
    dw RunBattlePhaseWhenTextIdle_A0_SyncLink_CountTurns
    dw RunBattlePhaseWhenTextIdle_A0_SyncLink_CountRound
    dw RunBattlePhaseWhenTextIdle_A0_SyncLink_BlankPics
    dw RunBattlePhaseWhenTextIdle_A0_SyncLink_ClearAttrs
    dw RunBattlePhaseWhenTextIdle_A0_SyncLink_SendReady
    dw RunBattlePhaseWhenTextIdle_A0_SyncLink_NextRound

; Game mode 7's round end, step 0: sends 1. (C2, E-0357; probed E-0385)
RunBattlePhaseWhenTextIdle_A0_SyncLink_Start::
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wBattleStep
    inc [hl]
    ret

; Round end, step 1: on the partner's 1 starts an 8-byte exchange of wBattleSlotOut into
; wLinkPartnerName. (C2, E-0357; probed E-0385)
RunBattlePhaseWhenTextIdle_A0_SyncLink_SendSlots::
    ld a, [wLinkMessage]
    cp $01
    ret nz
    ld hl, wBattleSlotOut
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, wLinkPartnerName
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $08
    ld [wLinkBufferCountLo], a
    ld a, $ff
    ld [wLinkSendByte], a
    ld hl, wBattleStep
    inc [hl]
    ret

; Round end, step 2: when the exchange ends takes the partner's out flag for its slot (slot 1 from
; the partner's byte 1, or slot 0 for link role bit 1). (C2, E-0357; probed E-0385)
RunBattlePhaseWhenTextIdle_A0_SyncLink_TakeOutFlag::
    ld a, [wLinkMessage]
    cp $f0
    ret nz
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .read_link_partner_name
    ld a, [wLinkPartnerByte1]
    ld [wBattleSlotOut + $1], a
    jr .skip

.read_link_partner_name:
    ld a, [wLinkPartnerName]
    ld [wBattleSlotOut], a

.skip:
    ld hl, wBattleStep
    inc [hl]
    xor a
    ld [wLinkSendByte], a
    ret

; Round end, step 3: adds the turns (wBattleTurn + 1) to the total in wLinkRuleTurnLimit (at most
; 99); when both slots are out or paralyzed (status bit 6) plays music 2 and goes to the next phase;
; otherwise shows string wScreenCountPlusOne + 6 of category 6. (C1, E-0357)
RunBattlePhaseWhenTextIdle_A0_SyncLink_CountTurns::
    ld a, [wBattleTurn]
    inc a
    ld b, a
    ld a, [wLinkRuleTurnLimit]
    add b
    cp $64
    jr c, .set_link_rule_turn_limit
    ld a, $63

.set_link_rule_turn_limit:
    ld [wLinkRuleTurnLimit], a
    ld hl, wBattleSlotOut
    ld a, [hl]
    cp $01
    jr z, .skip
    ld a, $00
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    bit 6, a
    jr z, .read_screen_count_plus_one

.skip:
    ld hl, wBattleSlotOut + $1
    ld a, [hl]
    cp $01
    jr z, .call_queue_music
    ld a, $01
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    bit 6, a
    jr nz, .call_queue_music

.read_screen_count_plus_one:
    ld a, [wScreenCountPlusOne]
    add $06
    ld [wStringIndex], a
    ld a, $06
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank07
    ld hl, wBattleStep
    inc [hl]
    ret

.call_queue_music:
    ld a, $02
    call QueueMusic
    ld hl, wBattlePhase
    inc [hl]
    xor a
    ld [wBattleStep], a
    ret

; Round end, step 4: after the text, after round 2 goes to the next phase; otherwise counts the
; round up, refreshes slots 0 and 1 (marks, HP, MP), shows 'Please wait.' and goes on. (C1, E-0357)
RunBattlePhaseWhenTextIdle_A0_SyncLink_CountRound::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, [wScreenCountPlusOne]
    cp $02
    jp z, .skip
    inc a
    ld [wScreenCountPlusOne], a
    farcall RestoreTransformedStats
    ld c, $00
    farcall DrawSlotStatusMarks
    farcall CopySlotPanelRowToVRAM
    ld c, $00
    farcall DrawSlotHPDigits
    farcall CopySlotHPDigitsPanelToVRAM
    ld c, $00
    farcall DrawSlotMPDigits
    farcall CopySlotMPDigitsPanelToVRAM
    ld c, $01
    farcall DrawSlotStatusMarks
    farcall CopySlotPanelRowToVRAM
    ld c, $01
    farcall DrawSlotHPDigits
    farcall CopySlotHPDigitsPanelToVRAM
    ld c, $01
    farcall DrawSlotMPDigits
    farcall CopySlotMPDigitsPanelToVRAM
    ld a, $05
    ld [wStringCategory], a
    ld a, $0c
    ld [wStringIndex], a ; 'Please wait.'
    farcall BeginStringDisplay_Bank07
    xor a
    ld [wLinkSendByte], a
    ld hl, wBattleStep
    inc [hl]
    ret

.skip:
    ld hl, wBattlePhase
    inc [hl]
    xor a
    ld [wBattleStep], a
    xor a
    ld [wLinkSendByte], a
    ret

; Round end, step 5: blanks the 18 x 6 picture area at row 7 with tile $C3. (C1, E-0357)
RunBattlePhaseWhenTextIdle_A0_SyncLink_BlankPics::
    ld hl, vBGMap0 + $e1
    ld bc, $1206
    ld de, $000e

.loop:
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld [hl], $c3
    ei
    inc hl
    dec b
    jr nz, .loop
    add hl, de
    ld b, $12
    dec c
    jr nz, .loop
    ld hl, wBattleStep
    inc [hl]
    ret

; Round end, step 6: on the GBC clears that area's attributes (VRAM bank 1). (C1, E-0357)
RunBattlePhaseWhenTextIdle_A0_SyncLink_ClearAttrs::
    ld a, [wIsCGB]
    or a
    jr z, .done
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0 + $e1
    ld bc, $1206
    ld de, $000e

.loop:
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld [hl], $00
    ei
    inc hl
    dec b
    jr nz, .loop
    add hl, de
    ld b, $12
    dec c
    jr nz, .loop
    ld a, $00
    ldh [rVBK], a

.done:
    ld hl, wBattleStep
    inc [hl]
    ret

; Round end, step 7: sends 1. (C2, E-0357; probed E-0385)
RunBattlePhaseWhenTextIdle_A0_SyncLink_SendReady::
    ld hl, wBattleStep
    inc [hl]
    ld a, $01
    ld [wLinkSendByte], a
    ret

; Round end, step 8: on the partner's 1 returns to battle phase 0 (the next round's introduction).
; (C2, E-0357; probed E-0385)
RunBattlePhaseWhenTextIdle_A0_SyncLink_NextRound::
    ld a, [wLinkMessage]
    cp $01
    ret nz
    xor a
    ld [wLinkSendByte], a
    xor a
    ld [wBattlePhase], a
    xor a
    ld [wBattleStep], a
    ret

; For each of the wPartyCount party members that has an entry in wBattleStateBuffer (5 bytes: HP
; word, MP word, status byte; an entry whose second byte is $FF ends the list), writes the HP word
; to MON_HP, the MP word to MON_MP and the status byte to MON_STATUS of the save RAM record named in
; wPartyList, then far-calls ClampPartyHPAndMPToMax. Save RAM is enabled for the work (rRAMG $0A,
; written back to 0). Its only caller is RunBattlePhaseWhenTextIdle_A0_DecideResult. (C2, E-0385)
; for each party member with a battle entry in wBattleStateBuffer, writes two words to SRAM record
; offsets $5B and $5F and one byte to $55, then ClampPartyHPAndMPToMax
StoreBattleStateToPartyRecords::
    ld a, $0a
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList
    ld de, wBattleStateBuffer

.loop:
    inc de
    ld a, [de]
    cp $ff
    jr z, .call_clamp_party_hp_and_mp_to_max
    dec de
    push hl
    ld a, [hl]
    ld c, MON_HP
    call SRAMRecordAddress
    ld a, [de]
    inc de
    ld [hli], a
    ld a, [de]
    inc de
    ld [hl], a
    pop hl
    push hl
    ld a, [hl]
    ld c, MON_MP
    call SRAMRecordAddress
    ld a, [de]
    inc de
    ld [hli], a
    ld a, [de]
    inc de
    ld [hl], a
    pop hl
    push hl
    ld a, [hl]
    ld c, MON_STATUS
    call SRAMRecordAddress
    ld a, [de]
    inc de
    ld [hli], a
    pop hl
    inc hl
    dec b
    jr nz, .loop

.call_clamp_party_hp_and_mp_to_max:
    farcall ClampPartyHPAndMPToMax
    xor a
    ld [rRAMG], a
    ret

; Phase 3 of the game mode 7 battle (the results). It jumps on wBattleStep: 0
; RunBattlePhaseWhenTextIdle_A0_DecideResult, 1 RunBattlePhaseWhenTextIdle_A0_ResultsScreen_Save, 2
; RunBattlePhaseWhenTextIdle_A0_ResultsScreen_Blank, 3
; RunBattlePhaseWhenTextIdle_A0_DrawResultLabels, 4 RunBattlePhaseWhenTextIdle_A0_DrawResults, 5
; RunBattlePhaseWhenTextIdle_A0_ShowResultsScreen, 6 RunBattlePhaseWhenTextIdle_A0_ShowStatChange, 7
; RunBattlePhaseWhenTextIdle_A0_ShowStatFalls, 8 RunBattlePhaseWhenTextIdle_A0_ShowGoldReceived, 9
; RunBattlePhaseWhenTextIdle_A0_MakeEgg and 10 RunBattlePhaseWhenTextIdle_A0_EndResults. (C1,
; E-0385)
; by wBattleStep: the results screen ('RESULTS ... Level Turns Win Rank', the rank letters
; 'GFEDCBAS', "0's G fell by W.", 'received WG.')
RunBattlePhaseWhenTextIdle_A0_ResultsScreen::
    ld a, [wBattleStep]
    jumptable
    dw RunBattlePhaseWhenTextIdle_A0_DecideResult
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_Save
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_Blank
    dw RunBattlePhaseWhenTextIdle_A0_DrawResultLabels
    dw RunBattlePhaseWhenTextIdle_A0_DrawResults
    dw RunBattlePhaseWhenTextIdle_A0_ShowResultsScreen
    dw RunBattlePhaseWhenTextIdle_A0_ShowStatChange
    dw RunBattlePhaseWhenTextIdle_A0_ShowStatFalls
    dw RunBattlePhaseWhenTextIdle_A0_ShowGoldReceived
    dw RunBattlePhaseWhenTextIdle_A0_MakeEgg
    dw RunBattlePhaseWhenTextIdle_A0_EndResults

; The results, step 0: text speed 1; works out the result (0 both stand, 1 the partner fell, 2 both
; fell (out or paralyzed), 3 this side's monster fell) into wBattleResultStep, computes the rank and
; the stat changes, resets the save steps and stores the battle state in the party records. (C2,
; E-0357; probed E-0385)
RunBattlePhaseWhenTextIdle_A0_DecideResult::
    ld a, $01
    ld [wTextSpeed], a
    ld a, [wBattleResultStep]
    ld l, a
    ld a, [wBattleResultCounter]
    ld h, a
    ld a, l
    ld [wResultsUnreadWordLo], a
    ld a, h
    ld [wResultsUnreadWordHi], a
    ld hl, wBattleSlotOut
    ld a, [hli]
    ld c, a
    ld a, [hl]
    sla a
    or c
    ld c, a
    ld hl, wBattleStatus
    ld a, [hl]
    and $40
    sra a
    sra a
    or c
    ld c, a
    ld hl, wBattleStatus + $9
    ld a, [hl]
    and $40
    sra a
    or c
    ld c, a
    and $03
    cp $03
    jr z, .skip3
    ld a, c
    and $30
    cp $30
    jr z, .skip3
    ld a, c
    and $21
    cp $21
    jr z, .skip3
    ld a, c
    and $12
    cp $12
    jr z, .skip3
    ld a, c
    and $03
    jr z, .skip
    ld a, [wLinkRole]
    and $02
    rrca
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    or a
    jr z, .skip2
    jr .set_battle_result_step_to_03

.skip:
    ld a, $00
    jr .set_battle_result_step

.skip2:
    ld a, $01
    jr .set_battle_result_step

.skip3:
    ld a, $02
    jr .set_battle_result_step

.set_battle_result_step_to_03:
    ld a, $03

.set_battle_result_step:
    ld [wBattleResultStep], a
    ld a, [wBattleResultDelay]
    ld [wBattleResultCounter], a
    call ComputeBattleResultRank
    call ApplyBattleResultStatChanges
    xor a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld hl, wBattleStep
    inc [hl]
    call StoreBattleStateToPartyRecords
    ret

; The results, step 1: backs up and saves (RunBackupAndSaveSteps, then SaveGameToSRAMWithChecksum)
; and shows string $0F + the result of category 5. (C1, E-0357)
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_Save::
    farcall RunBackupAndSaveSteps
    ld a, [wSaveStep]
    bit 7, a
    ret z
    farcall SaveGameToSRAMWithChecksum
    ld a, [wBattleResultStep]
    add $0f
    ld [wStringIndex], a
    ld a, $05
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank07
    ld hl, wBattleStep
    inc [hl]
    ret

; The results, step 2: after the text blanks the screen buffer and the BG map. (C1, E-0357)
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_Blank::
    ld a, [wTextFlags]
    or a
    ret nz
    ld hl, wScreenTileBuffer
    ld bc, $01a0
    ld a, $c3
    call FillBytes
    ld hl, vBGMap0
    call CopyScreenTileBufferToVRAM_A0
    ld hl, wBattleStep
    inc [hl]
    ret

; The results, step 3: draws the glyphs of the results headings, string 3 of category 1 ('RESULTS',
; 'DuoW+', 'Level', 'Turns', 'Win', $92, 'Rank', 'OwnW', 'DuoL', 'OwnL'), as 44 x 1 tiles from
; vTiles1 + $700 (tile $F0 on), and the rank letters 'GFEDCBAS' (string 5) as 8 x 1 tiles at vTiles2
; + $200 (tile $20 on), both with ShowString_Bank07; next step. (C1, E-0372)
RunBattlePhaseWhenTextIdle_A0_DrawResultLabels::
    ld hl, vTiles1 + $700
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $2c01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $01
    ld [wStringCategory], a
    ld a, $03
    ld [wStringIndex], a ; 'RESULTSDuoW+LevelTurnsWin RankOwnWDuoLOwnL'
    farcall ShowString_Bank07
    ld hl, vTiles2 + $200
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0801
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $01
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a ; 'GFEDCBAS'
    farcall ShowString_Bank07
    ld hl, wBattleStep
    inc [hl]
    ret

; The results, step 4: draws the frame with DrawRectAndWriteDATiles, then four label tiles from the
; ResultLabelTiles entry for wBattleResultStep at wScreenTileBuffer + $61 (one column skipped before
; the last tile). The values of wWildLevel, wLinkRuleTurnLimit and wWildBand are written as
; two-digit numbers down column 7 (+ $A7, + $E7, + $127; WriteTwoDigitsBlankLeading_A0), the tile
; wEncounterClass + $20 goes to wWindowTileBuffer, and four two-digit numbers from wKeyNameBuf are
; written every $40 bytes from + $71 (WriteThreeTwoDigitRows). Then wBattleStep advances. (C2,
; E-0385)
RunBattlePhaseWhenTextIdle_A0_DrawResults::
    call DrawRectAndWriteDATiles
    ld a, [wBattleResultStep]
    ld hl, ResultLabelTiles
    add a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld hl, wScreenTileBuffer + $61

.loop:
    ld [hl], d
    inc d
    inc hl
    dec e
    ld a, e
    cp $00
    jr z, .read_wild_level
    cp $02
    jr nc, .loop
    inc hl
    jr .loop

.read_wild_level:
    ld a, [wWildLevel]
    ld hl, wScreenTileBuffer + $a7
    call WriteTwoDigitsBlankLeading_A0
    ld a, [wLinkRuleTurnLimit]
    ld hl, wScreenTileBuffer + $e7
    call WriteTwoDigitsBlankLeading_A0
    ld a, [wWildBand]
    ld hl, wScreenTileBuffer + $127
    call WriteTwoDigitsBlankLeading_A0
    ld a, [wEncounterClass]
    add $20
    ld [wWindowTileBuffer], a
    ld de, wKeyNameBuf
    ld hl, wScreenTileBuffer + $71
    call WriteThreeTwoDigitRows
    ld hl, wBattleStep
    inc [hl]
    ret

; A = number (0-255), HL = destination: writes the tens digit as tile $E0 + digit at [HL] (a blank
; tile $C3 when the tens digit is 0) and the ones digit as $E0 + digit at [HL + 1]; the hundreds
; digit is dropped (100 gives a blank tile and 0). HL ends on the second tile. Caller:
; RunBattlePhaseWhenTextIdle_A0_DrawResults. (C2, E-0385)
; writes A as two digit tiles at HL, with a blank ($C3) for a leading zero (E-0122)
WriteTwoDigitsBlankLeading_A0::
    push hl
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    pop hl
    ld a, [wDigits + $1]
    add $e0
    cp $e0
    jr nz, .read_digits
    ld a, $c3

.read_digits:
    ld [hli], a
    ld a, [wDigits + $2]
    add $e0
    ld [hl], a
    ret

; A = value, HL = table of ascending bytes: counts the leading table bytes that are not above A; C
; and A end as that count and HL on the first byte above A. The table must hold a byte above A or
; the scan runs on. No routine in src/ calls this copy by name (the other copy in the bank is
; CountTableBytesAtOrBelowA_BankA0). Same 11 bytes in 2 banks. (C2, E-0385)
; HL = ascending table of thresholds: C = A = the number of leading bytes that are <= A (the index
; of the first byte above A); HL ends on that byte. The table must contain a byte above A (E-0065)
; (the same 11 bytes appear in 2 banks)
CountTableBytesAtOrBelowA_BankA0_2::
    ld c, $00

.skip:
    cp [hl]
    jr c, .done
    inc c
    inc hl
    jr .skip

.done:
    ld a, c
    ret

; DE = list of numbers, HL = destination: calls WriteTwoDigitsFromDEStepRow three times and then
; falls into it for a fourth, so four numbers are written, one every $40 bytes from HL; DE ends 4
; bytes on and HL $100 on. Its only caller is RunBattlePhaseWhenTextIdle_A0_DrawResults. (C2,
; E-0385)
; three WriteTwoDigitsFromDEStepRow calls: three numbers from DE, one per row
WriteThreeTwoDigitRows::
    call WriteTwoDigitsFromDEStepRow
    call WriteTwoDigitsFromDEStepRow
    call WriteTwoDigitsFromDEStepRow

; DE = address of a number, HL = destination: reads the byte at [DE] (DE advances by 1) and writes
; its tens digit as tile $E0 + digit at [HL] only when the tens digit is not 0 (otherwise [HL] is
; left alone), and its ones digit at [HL + 1]; the hundreds digit is dropped. HL ends at the start
; position + $40 (two rows of the 32-tile buffer on). Caller: WriteThreeTwoDigitRows. (C2, E-0385)
; writes [DE] (DE += 1) as two digit tiles at HL (no leading zero digit), then HL moves to the next
; row ($40 on) (E-0124)
WriteTwoDigitsFromDEStepRow::
    push hl
    ld a, [de]
    inc de
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    pop hl
    ld a, [wDigits + $1]
    or a
    jr z, .read_digits
    add $e0
    ld [hl], a

.read_digits:
    inc hl
    ld a, [wDigits + $2]
    add $e0
    ld [hl], a
    ld a, l
    add $3f
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ret

; Four 2-byte entries, one per wBattleResultStep 0-3: a tile count (4) and the first tile ($F7, $0E,
; $12, $16) of that result's label among the heading glyphs that
; RunBattlePhaseWhenTextIdle_A0_DrawResultLabels draws from tile $F0;
; RunBattlePhaseWhenTextIdle_A0_DrawResults writes the tiles at wScreenTileBuffer + $61. Counting
; one tile per character of 'RESULTS', 'DuoW+', 'Level', 'Turns', 'Win', $92, 'Rank', 'OwnW',
; 'DuoL', 'OwnL', the labels are 'DuoW', 'OwnW', 'DuoL' and 'OwnL'. (C1, E-0372)
ResultLabelTiles::
    db $04, $f7, $04, $0e, $04, $12, $04, $16

; The results, step 5: copies the screen to the BG map, clears the text tiles and copies record A's
; name into wTextBuf0. (C1, E-0357)
RunBattlePhaseWhenTextIdle_A0_ShowResultsScreen::
    ld hl, vBGMap0
    call CopyScreenTileBufferToVRAM_A0
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld hl, wRecordBufA + MON_NAME
    ld de, wTextBuf0
    ld bc, $000a
    call CopyBytes
    ld a, $f0
    ld [wTextBuf0 + $a], a
    ld hl, wBattleStep
    inc [hl]
    ret

; The results, step 6: with one stat change (wWorkBuf + 9 not $FF) copies that stat's name to
; wTextBuf1 (CopyF0StringFromTableToTextBuf1) and the amount at wWorkBuf + $0A to wTextBuf2, shows
; '<name>'s <stat> rose by <n>.' (string $14 of category 5) for results 0-1 or '... fell by <n>.'
; ($15) otherwise, and skips step 7; with none goes to step 7 by falling into
; RunBattlePhaseWhenTextIdle_A0_ShowNextStatFall. (C1, E-0372)
RunBattlePhaseWhenTextIdle_A0_ShowStatChange::
    ld a, [wWorkBuf + $9]
    cp $ff
    jr nz, .call_copy_f0_string_from_table_to_text_buf1
    ld hl, wBattleStep
    inc [hl]
    jr RunBattlePhaseWhenTextIdle_A0_ShowNextStatFall

.call_copy_f0_string_from_table_to_text_buf1:
    call CopyF0StringFromTableToTextBuf1
    ld a, [wWorkBuf + $a]
    ld hl, wTextBuf2
    call WriteDecimalByteString
    ld a, [wBattleResultStep]
    cp $02
    ld a, $14
    jr c, .set_string_index
    ld a, $15

.set_string_index:
    ld [wStringIndex], a ; '0's G fell by W.'
    ld a, $05
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank07
    ld hl, wBattleStep
    inc [hl]
    ld hl, wBattleStep
    inc [hl]
    ret

; The results, step 7: after the text shows the six stats falling in turn ('<name>'s <stat> fell by
; <n>.', string $15, amounts from wWorkBuf + $0A). (C1, E-0357)
RunBattlePhaseWhenTextIdle_A0_ShowStatFalls::
    ld a, [wTextFlags]
    or a
    ret nz

; Shows stat wBattleSubPhase's fall (string $15, amount wWorkBuf + $0A + it); after the sixth goes
; on. (C1, E-0357)
RunBattlePhaseWhenTextIdle_A0_ShowNextStatFall::
    ld a, [wBattleSubPhase]
    call CopyF0StringFromTableToTextBuf1
    ld a, [wBattleSubPhase]
    ld hl, wWorkBuf + $a
    add_a_to_hl
    ld a, [hl]
    ld hl, wTextBuf2
    call WriteDecimalByteString
    ld a, $05
    ld [wStringCategory], a
    ld a, $15
    ld [wStringIndex], a ; '0's G fell by W.'
    farcall BeginStringDisplay_Bank07
    ld a, [wBattleSubPhase]
    inc a
    ld [wBattleSubPhase], a
    cp $06
    ret c
    xor a
    ld [wBattleSubPhase], a
    ld hl, wBattleStep
    inc [hl]
    ret

; The results, step 8: after the text shows 'received <n>G.' (string $16, the amount at wWorkBuf +
; $10); result 1 goes on to step 9, the others skip to step 10. (C1, E-0357)
RunBattlePhaseWhenTextIdle_A0_ShowGoldReceived::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, [wWorkBuf + $10]
    ldh [hTemp0], a
    ld a, [wWorkBuf + $11]
    ldh [hTemp1], a
    xor a
    ldh [hTemp2], a
    ld hl, wTextBuf2
    call WriteNumber24AsDecimalString
    ld a, $05
    ld [wStringCategory], a
    ld a, $16
    ld [wStringIndex], a ; 'received WG.'
    farcall BeginStringDisplay_Bank07
    xor a
    ld [wBattleSubPhase], a
    xor a
    ld [wLinkSendByte], a
    ld hl, wBattleStep
    inc [hl]
    ld a, [wBattleResultStep]
    cp $01
    ret z
    ld hl, wBattleStep
    inc [hl]
    ret

; The results, step 9 (reached only for wBattleResultStep 1; the others skip it): by wBattleSubPhase
; runs RunBattlePhaseWhenTextIdle_A0_EggSendReady (after the text sends 1) and then
; RunBattlePhaseWhenTextIdle_A0_MakeEggRecord (on the partner's 1 makes wRecordBufB an egg copy of
; wRecordBufA with unknown parents and switches to game mode 6). (C1, E-0372)
; waits for the text, then fills record buffer B with '???' names and $FF species
; (WriteUnknownNamePlaceholder)
RunBattlePhaseWhenTextIdle_A0_MakeEgg::
    ld a, [wBattleSubPhase]
    jumptable
    dw RunBattlePhaseWhenTextIdle_A0_EggSendReady
    dw RunBattlePhaseWhenTextIdle_A0_MakeEggRecord

; The partner's egg, sub-step 0: after the text sends 1. (C2, E-0357; probed E-0385)
RunBattlePhaseWhenTextIdle_A0_EggSendReady::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; The egg, sub-step 1 (of RunBattlePhaseWhenTextIdle_A0_MakeEgg): on the partner's 1 sets
; wBattleScene = 8 and wLinkRules + $9 = 1, and makes record B (wRecordBufB) an egg copy of record A
; (wRecordBufA, $A5 bytes): byte 0 = 1, unknown parents (species $FF, '???' masters and names by
; WriteUnknownNamePlaceholder), the skills mapped into the skill list
; (AppendMappedSkillsToRecordBufBSkillList), MON_STATUS 0, MON_LEVEL 1, MON_EXP 0, HP, MP and the
; stats quartered (QuarterHLAtLeast1, at least 1), MON_WLD, MON_PLUS and the parents' plus values 0,
; MON_EGG = 1 and MON_ITEM 0. Then starts fade 4, switches to game mode 6 (wModeState 0,
; wModeChangeRequest), bumps wBGFillFlag and clears the link state (wLinkSession through
; wLinkScreenStep). (C1, E-0371)
RunBattlePhaseWhenTextIdle_A0_MakeEggRecord::
    ld a, [wLinkMessage]
    cp $01
    ret nz
    ld a, $08
    ld [wBattleScene], a
    ld a, $01
    ld [wLinkRules + $9], a
    ld hl, wRecordBufA
    ld de, wRecordBufB
    ld bc, $00a5
    call CopyBytes
    ld a, $01
    ld [wRecordBufB], a
    ld a, $ff
    ld [wRecordBufB + MON_PARENT1_SPECIES], a
    ld [wRecordBufB + MON_PARENT1_SPECIES + 1], a
    ld [wRecordBufB + MON_PARENT2_SPECIES], a
    ld [wRecordBufB + MON_PARENT2_SPECIES + 1], a
    ld hl, wRecordBufB + MON_PARENT1_MASTER
    call WriteUnknownNamePlaceholder
    ld a, $ff
    ld [wRecordBufB + MON_UNUSED_28], a
    ld hl, wRecordBufB + MON_PARENT2_MASTER
    call WriteUnknownNamePlaceholder
    ld a, $ff
    ld [wRecordBufB + MON_UNUSED_33], a
    call AppendMappedSkillsToRecordBufBSkillList
    xor a
    ld [wRecordBufB + MON_STATUS], a
    ld a, $01
    ld [wRecordBufB + MON_LEVEL], a
    xor a
    ld [wRecordBufB + MON_EXP], a
    ld [wRecordBufB + MON_EXP + 1], a
    ld [wRecordBufB + MON_EXP + 2], a
    ld a, [wRecordBufB + MON_MAX_HP]
    ld l, a
    ld a, [wRecordBufB + MON_MAX_HP + 1]
    ld h, a
    call QuarterHLAtLeast1
    ld a, l
    ld [wRecordBufB + MON_MAX_HP], a
    ld a, h
    ld [wRecordBufB + MON_MAX_HP + 1], a
    ld a, l
    ld [wRecordBufB + MON_HP], a
    ld a, h
    ld [wRecordBufB + MON_HP + 1], a
    ld a, [wRecordBufB + MON_MAX_MP]
    ld l, a
    ld a, [wRecordBufB + MON_MAX_MP + 1]
    ld h, a
    call QuarterHLAtLeast1
    ld a, l
    ld [wRecordBufB + MON_MAX_MP], a
    ld a, h
    ld [wRecordBufB + MON_MAX_MP + 1], a
    ld a, l
    ld [wRecordBufB + MON_MP], a
    ld a, h
    ld [wRecordBufB + MON_MP + 1], a
    ld a, [wRecordBufB + MON_ATK]
    ld l, a
    ld a, [wRecordBufB + MON_ATK + 1]
    ld h, a
    call QuarterHLAtLeast1
    ld a, l
    ld [wRecordBufB + MON_ATK], a
    ld a, h
    ld [wRecordBufB + MON_ATK + 1], a
    ld a, [wRecordBufB + MON_DEF]
    ld l, a
    ld a, [wRecordBufB + MON_DEF + 1]
    ld h, a
    call QuarterHLAtLeast1
    ld a, l
    ld [wRecordBufB + MON_DEF], a
    ld a, h
    ld [wRecordBufB + MON_DEF + 1], a
    ld a, [wRecordBufB + MON_AGL]
    ld l, a
    ld a, [wRecordBufB + MON_AGL + 1]
    ld h, a
    call QuarterHLAtLeast1
    ld a, l
    ld [wRecordBufB + MON_AGL], a
    ld a, h
    ld [wRecordBufB + MON_AGL + 1], a
    ld a, [wRecordBufB + MON_INT]
    ld l, a
    ld a, [wRecordBufB + MON_INT + 1]
    ld h, a
    call QuarterHLAtLeast1
    ld a, l
    ld [wRecordBufB + MON_INT], a
    ld a, h
    ld [wRecordBufB + MON_INT + 1], a
    xor a
    ld [wRecordBufB + MON_WLD], a
    ld [wRecordBufB + MON_WLD + 1], a
    xor a
    ld [wRecordBufB + MON_PLUS], a
    ld a, $01
    ld [wRecordBufB + MON_EGG], a
    ld hl, wRecordBufB + MON_PARENT1_NAME
    call WriteUnknownNamePlaceholder
    xor a
    ld [wRecordBufB + MON_PARENT1_PLUS], a
    ld hl, wRecordBufB + MON_PARENT2_NAME
    call WriteUnknownNamePlaceholder
    xor a
    ld [wRecordBufB + MON_PARENT2_PLUS], a
    xor a
    ld [wRecordBufB + MON_ITEM], a
    ld a, $04
    call StartPaletteFade
    ld a, $06
    ld [wGameMode], a
    xor a
    ld [wModeState], a
    ld [wWorldMapState], a
    ld [wGameMode2Arg], a
    ld [wScreenState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ld hl, wBGFillFlag
    inc [hl]
    xor a
    ld [wLinkSession], a
    ld [wLinkExchangeState], a
    xor a
    ld [wLinkRole], a
    ld [wLinkStatus], a
    xor a
    ld [wLinkMode], a
    xor a
    ld [wLinkSendByte], a
    xor a
    ld [wLinkMessage], a
    xor a
    ld [wLinkScreenStep], a
    ret

; HL = HL / 4 with the sign kept (two arithmetic shifts right, so $FFFC gives $FFFF), then 1 when
; that leaves 0. A is clobbered. Called six times by RunBattlePhaseWhenTextIdle_A0_MakeEggRecord to
; quarter the HP, MP and the four stats of an egg copy. (C2, E-0385)
; HL >>= 2 (arithmetic), and 1 when that leaves 0 (E-0118)
QuarterHLAtLeast1::
    sra h
    rr l
    sra h
    rr l
    ld a, l
    or h
    ret nz
    ld hl, $0001
    ret

; HL = a 10-byte name field: writes the glyph $98 ('?') three times and then seven $F0 bytes, so the
; field reads '???'; HL ends on the last byte written (HL + 9). Called four times by
; RunBattlePhaseWhenTextIdle_A0_MakeEggRecord for the parent names and the parent master names of
; the egg copy. (C2, E-0385)
; writes '???' ($98 three times, the charmap '?') followed by seven $F0 bytes at HL: a 10-byte name
; field holding a placeholder (E-0111)
WriteUnknownNamePlaceholder::
    ld a, $98
    ld [hli], a
    ld a, $98
    ld [hli], a
    ld a, $98
    ld [hli], a
    ld a, $f0
    ld [hli], a
    ld a, $f0
    ld [hli], a
    ld a, $f0
    ld [hli], a
    ld a, $f0
    ld [hli], a
    ld a, $f0
    ld [hli], a
    ld a, $f0
    ld [hli], a
    ld a, $f0
    ld [hl], a
    ret

; Moves the eight skill bytes at wRecordBufB + MON_SKILLS into the skill list at wRecordBufB +
; MON_SKILL_LIST. The list is searched for its first $FF within 25 bytes (none: it returns and
; changes nothing). Each skill byte up to the first $FF is replaced by the second byte of the first
; pair of SkillReplacementPairs whose first byte matches (a byte with no pair is copied as it is)
; and stored in the list from that $FF on; then all eight skill bytes are set to $FF. Called once,
; by RunBattlePhaseWhenTextIdle_A0_MakeEggRecord. (C2, E-0385)
; appends the eight skills at wRecordBufB + $34 (mapped through the pair list SkillReplacementPairs)
; to the first free slot of wRecordBufB + $3C, then clears wRecordBufB + $34 (E-0127) (E-0340: the
; address in its name read as its RAM name; was AppendMappedSkillsToRecordBufBSkillList)
AppendMappedSkillsToRecordBufBSkillList::
    ld de, wRecordBufB + MON_SKILL_LIST
    ld b, $19

.loop:
    ld a, [de]
    cp $ff
    jr z, .skip
    inc de
    dec b
    jr nz, .loop
    ret

.skip:
    ld b, $08
    ld hl, wRecordBufB + MON_SKILLS

.loop2:
    ld a, [hl]
    cp $ff
    jr z, .skip4
    push hl
    ld c, a
    ld hl, SkillReplacementPairs

.skip2:
    ld a, [hl]
    cp $ff
    jr z, .skip3
    cp c
    jr z, .next
    inc hl
    inc hl
    jr .skip2

.next:
    inc hl
    ld a, [hl]
    ld c, a

.skip3:
    ld a, c
    ld [de], a
    pop hl
    inc hl
    inc de
    dec b
    jr nz, .loop2

.skip4:
    ld hl, wRecordBufB + MON_SKILLS
    ld b, $08

.loop3:
    ld a, $ff
    ld [hli], a
    dec b
    jr nz, .loop3
    ret

; AppendMappedSkillsToRecordBufBSkillList takes each of the 8 bytes at wRecordBufB + $34 up to $FF,
; replaces it by the second byte of the first pair here whose first byte matches (pairs end at $FF),
; appends it after the last used byte of wRecordBufB + $3C, then fills the 8 bytes with $FF; 44
; pairs and $FF $FF (E-0237, C1)
; record: byte to match, replacement
SkillReplacementPairs::
    db $02, $01 ; id 0
    db $03, $01 ; id 1
    db $05, $04 ; id 2
    db $06, $04 ; id 3
    db $08, $07 ; id 4
    db $09, $07 ; id 5
    db $0b, $0a ; id 6
    db $0c, $0a ; id 7
    db $0e, $0d ; id 8
    db $0f, $0d ; id 9
    db $11, $10 ; id 10
    db $12, $10 ; id 11
    db $14, $13 ; id 12
    db $17, $16 ; id 13
    db $18, $16 ; id 14
    db $1a, $19 ; id 15
    db $1c, $1b ; id 16
    db $1d, $1b ; id 17
    db $1f, $1e ; id 18
    db $26, $25 ; id 19
    db $28, $27 ; id 20
    db $2a, $29 ; id 21
    db $2c, $2b ; id 22
    db $20, $2f ; id 23
    db $37, $36 ; id 24
    db $41, $40 ; id 25
    db $42, $40 ; id 26
    db $43, $40 ; id 27
    db $45, $44 ; id 28
    db $46, $44 ; id 29
    db $47, $44 ; id 30
    db $49, $48 ; id 31
    db $4d, $4c ; id 32
    db $4f, $4e ; id 33
    db $64, $63 ; id 34
    db $74, $73 ; id 35
    db $77, $76 ; id 36
    db $86, $85 ; id 37
    db $87, $85 ; id 38
    db $88, $85 ; id 39
    db $8c, $8b ; id 40
    db $8e, $8d ; id 41
    db $98, $97 ; id 42
    db $9a, $99 ; id 43
    db $ff, $ff ; end

; The results, step 10: by wBattleSubPhase runs RunBattlePhaseWhenTextIdle_A0_FadeOutSendReady
; (after the text sends 1) and then RunBattlePhaseWhenTextIdle_A0_ReturnToTitleMenu (on the
; partner's 1 starts fade 4 and switches to wGameMode 5, wModeState 1, GameMode5_Init_TitleMenu).
; (C1, E-0372)
; waits for the text, then starts the palette fade
RunBattlePhaseWhenTextIdle_A0_EndResults::
    ld a, [wBattleSubPhase]
    jumptable
    dw RunBattlePhaseWhenTextIdle_A0_FadeOutSendReady
    dw RunBattlePhaseWhenTextIdle_A0_ReturnToTitleMenu

; The results' end, sub-step 0: after the text sends 1. (C2, E-0357; probed E-0385)
RunBattlePhaseWhenTextIdle_A0_FadeOutSendReady::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; The results' end, sub-step 1: on the partner's 1 starts fade 4, switches to game mode 5, state 1
; and clears the link state. (C1, E-0357)
RunBattlePhaseWhenTextIdle_A0_ReturnToTitleMenu::
    ld a, [wLinkMessage]
    cp $01
    ret nz
    ld a, $04
    call StartPaletteFade
    ld a, $05
    ld [wGameMode], a
    ld a, $01
    ld [wModeState], a
    xor a
    ld [wWorldMapState], a
    ld [wGameMode2Arg], a
    ld [wScreenState], a
    ld hl, wModeChangeRequest
    inc [hl]
    xor a
    ld [wLinkSession], a
    ld [wLinkExchangeState], a
    xor a
    ld [wLinkRole], a
    ld [wLinkStatus], a
    xor a
    ld [wLinkMode], a
    xor a
    ld [wLinkSendByte], a
    xor a
    ld [wLinkMessage], a
    xor a
    ld [wLinkScreenStep], a
    ret
    db $0a, $14, $1e

; A = stat number 0-5 (HP, MP, ATK, DEF, AGL, INT): copies the name of that stat, glyphs up to and
; including the $F0 end byte, from the strings after the pointer table
; CopyF0StringFromTableToTextBuf1_Data to wTextBuf1. A, HL, DE are clobbered. Called by
; RunBattlePhaseWhenTextIdle_A0_ShowStatChange and RunBattlePhaseWhenTextIdle_A0_ShowNextStatFall,
; which print a message that a stat rose or fell by an amount. (C2, E-0385)
; copies the $F0-terminated string at CopyF0StringFromTableToTextBuf1_Data[A] to wTextBuf1,
; including the terminator (E-0122) (E-0344: the address in its name dropped or read as the label
; there; was CopyF0StringFromTableToTextBuf1)
CopyF0StringFromTableToTextBuf1::
    ld hl, CopyF0StringFromTableToTextBuf1_Data
    add a
    add_a_to_hl
    deref_hl
    ld de, wTextBuf1

.skip:
    ld a, [hli]
    cp $f0
    jr z, .done
    ld [de], a
    inc de
    jr .skip

.done:
    ld [de], a
    ret

; Six little-endian in-bank pointers (12 bytes) followed by the six strings they point at, each
; ending in $F0 (22 bytes): "HP", "MP", "ATK", "DEF", "AGL" and "INT", the six stat names in charmap
; glyphs. CopyF0StringFromTableToTextBuf1 takes the pointer at index A (wWorkBuf + 9 or
; wBattleSubPhase in the battle results, 0-5) and copies its string with the $F0 into wTextBuf1 for
; the message "<name> rose by <n>" or "fell by <n>". (C1, E-0381)
CopyF0StringFromTableToTextBuf1_Data::
    db $56, $5a, $59, $5a, $5c, $5a, $60, $5a, $64, $5a, $68, $5a, $11, $19, $f0, $16
    db $19, $f0, $0a, $1d, $14, $f0, $0d, $0e, $0f, $f0, $0a, $10, $15, $f0, $12, $17
    db $1d, $f0

; Works out the rank 0-7 of a link battle result; called by
; RunBattlePhaseWhenTextIdle_A0_DecideResult. Adds 1 (stopping at 99) to counter number
; wBattleResultStep of the four counters wKeyNameBuf, wKeyNameBuf + 1, wBattleResultCount2 and
; wBattleResultCount3. The band = 10 * (counter 0 + counter 1) / (sum of the four), 0-10, goes to
; wWorkBuf and wWildBand. Then wWildLevel (read only, it is not changed) plus two signed adjustments
; is clamped to 0-99: BattleResultBandAdjust for the bracket of the band in
; BattleResultBandThresholds (-20 to +10) and BattleResultTurnLimitAdjust for the bracket of
; wLinkRuleTurnLimit in BattleResultTurnLimitThresholds (+20 to -20). The rank is how many of the
; BattleResultRankThresholds (20 40 50 60 70 80 90) are at or below that level; it goes to wWorkBuf
; + 1 and wEncounterClass. (C2, E-0385)
; adds 1 (up to 99) to battle result counter wBattleResultStep of the four at $C895-$C898
; (wKeyNameBuf, wKeyNameBuf+1, wBattleResultCount2, wBattleResultCount3); band = (counter 0 +
; counter 1) * 10 / (sum of all four) to wWorkBuf and wWildBand; adds BattleResultBandAdjust[band
; bracket] and BattleResultTurnLimitAdjust[wLinkRuleTurnLimit bracket] to wWildLevel, clamped to
; 0-99; the rank 0-7 (count of BattleResultRankThresholds at or below it) goes to wWorkBuf+1 and
; wEncounterClass and is shown as one of 'GFEDCBAS'
ComputeBattleResultRank::
    ld a, [wBattleResultStep]
    ld hl, wKeyNameBuf
    add_a_to_hl
    ld a, [hl]
    inc a
    cp $64
    jr c, .read_link_rule_turn_limit
    ld a, $63

.read_link_rule_turn_limit:
    ld [hl], a
    ld a, [wLinkRuleTurnLimit]
    ld hl, BattleResultTurnLimitThresholds
    call CountTableBytesAtOrBelowA_BankA0
    ld hl, BattleResultTurnLimitAdjust
    add_a_to_hl
    push hl
    ld hl, wKeyNameBuf
    ld a, [hli]
    add [hl]
    ld c, a
    ld b, $00
    push bc
    ld a, $0a
    call Multiply8
    pop bc
    ld a, [wBattleResultCount2]
    add c
    ld c, a
    ld a, $00
    adc b
    ld b, a
    ld a, [wBattleResultCount3]
    add c
    ld c, a
    ld a, $00
    adc b
    ld b, a
    call DivideHLByBC
    ld a, l
    ld [wWorkBuf], a
    ld [wWildBand], a
    ld hl, BattleResultBandThresholds
    call CountTableBytesAtOrBelowA_BankA0
    ld hl, BattleResultBandAdjust
    add_a_to_hl
    ld a, [wWildLevel]
    ld e, a
    ld d, $00
    ld a, [hl]
    ld c, a
    ld b, $00
    bit 7, a
    jr z, .skip
    ld b, $ff

.skip:
    ld a, e
    add c
    ld e, a
    ld a, d
    adc b
    ld d, a
    pop hl
    ld a, [hl]
    ld c, a
    ld b, $00
    bit 7, a
    jr z, .skip2
    ld b, $ff

.skip2:
    ld a, e
    add c
    ld e, a
    ld a, d
    adc b
    ld d, a
    bit 7, d
    jr z, .skip3
    ld de, $0000
    jr .call_count_table_bytes_at_or_below_a_bank_a0

.skip3:
    ld a, d
    or a
    jr z, .skip4
    ld de, $0063
    jr .call_count_table_bytes_at_or_below_a_bank_a0

.skip4:
    ld a, e
    cp $64
    jr c, .call_count_table_bytes_at_or_below_a_bank_a0
    ld de, $0063

.call_count_table_bytes_at_or_below_a_bank_a0:
    ld a, e
    ld hl, BattleResultRankThresholds
    call CountTableBytesAtOrBelowA_BankA0
    ld [wWorkBuf + $1], a
    ld [wEncounterClass], a
    ret

; HL = a table of ascending thresholds, A = a value: C = A = how many leading table bytes are at or
; below A; HL ends on the first byte above A. The table must contain a byte above A (the tables used
; here end in $FF) or the walk runs on. Called three times by ComputeBattleResultRank. (C2, E-0385)
; HL = ascending table of thresholds: C = A = the number of leading bytes that are <= A (the index
; of the first byte above A); HL ends on that byte. The table must contain a byte above A (E-0065)
; (the same 11 bytes appear in 2 banks)
CountTableBytesAtOrBelowA_BankA0::
    ld c, $00

.skip:
    cp [hl]
    jr c, .done
    inc c
    inc hl
    jr .skip

.done:
    ld a, c
    ret

; ascending turn-limit thresholds for ComputeBattleResultRank, $FF-terminated (E-0289)
BattleResultTurnLimitThresholds::
    db $06, $0b, $15, $29, $33, $3d, $ff

; signed level adjustment per turn-limit bracket: +20, +10, +5, 0, -5, -10, -20 (E-0289)
BattleResultTurnLimitAdjust::
    db $14, $0a, $05, $00, $fb, $f6, $ec

; ascending band thresholds for ComputeBattleResultRank, $FF-terminated (E-0289)
BattleResultBandThresholds::
    db $01, $03, $05, $07, $09, $ff

; signed level adjustment per band: -20, -10, -5, 0, +5, +10 (E-0289)
BattleResultBandAdjust::
    db $ec, $f6, $fb, $00, $05, $0a

; ascending rank thresholds 20-90, $FF-terminated: the count at or below the adjusted level is the
; rank 0-7 (E-0289)
BattleResultRankThresholds::
    db $14, $28, $32, $3c, $46, $50, $5a, $ff

; Applies a link battle result to the saved monster record number wLinkReceivedByte (SRAM bank 0,
; $A5 bytes per record) and to the gold; called by RunBattlePhaseWhenTextIdle_A0_DecideResult.
; Inputs: wBattleResultStep (the result) and the rank in wWorkBuf + 1. It first sets wWorkBuf + 9 to
; wWorkBuf + $11 to $FF, then works on the six words MON_MAX_HP, MON_MAX_MP, MON_ATK, MON_DEF,
; MON_AGL and MON_INT. Results 0 and 1: the smallest word (FindMinOfSixStatWords) gets
; BattleResultStatBonusByRank[rank] added, up to 999; its number is left in wWorkBuf + 9 and the
; amount that fitted in wWorkBuf + $A. Result 2: the largest word (FindMaxOfSixStatWords, its number
; in wWorkBuf + 9) is lowered by BattleResultStatPenaltyByRank[rank] (1), never below 1, amount in
; wWorkBuf + $A. Any other result lowers all six words that way, amounts in wWorkBuf + $A to + $F,
; and wWorkBuf + 9 stays $FF. The gold amount is BattleResultGoldByRank[rank] (1000 for every rank)
; after result 0 or 1 and 1000 after the others; it goes to wWorkBuf + $10 and + $11 and is added to
; the 24-bit gold at wGoldLo, which stops at 99999; when the sum is over that, wWorkBuf + $10 and +
; $11 are replaced by the 16-bit negative of the excess (not the amount that fitted). Last, MON_HP
; is set to MON_MAX_HP (the test compares the SRAM address high byte, so it always passes), and
; MON_MP is set to MON_MAX_MP only when the low byte of MON_MP, taken as both bytes of a word, is
; not below MON_MAX_MP (the test reads the wrong bytes); SRAM is closed again (rRAMG = 0). (C2,
; E-0385)
; by wBattleResultStep: results 0 and 1 raise the lowest of five record words by
; BattleResultStatBonusByRank[rank] (capped at 999) and take a word from BattleResultGoldByRank;
; result 2 lowers the highest by BattleResultStatPenaltyByRank[rank]; others lower all five; the
; word (or 1000) goes to wWorkBuf+$10
ApplyBattleResultStatChanges::
    ld a, $ff
    ld [wWorkBuf + $9], a
    ld [wWorkBuf + $a], a
    ld [wWorkBuf + $b], a
    ld [wWorkBuf + $c], a
    ld [wWorkBuf + $d], a
    ld [wWorkBuf + $e], a
    ld [wWorkBuf + $f], a
    ld [wWorkBuf + $10], a
    ld [wWorkBuf + $11], a
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [wLinkReceivedByte]
    ld c, MON_MAX_HP
    call SRAMRecordAddress
    ld a, [wBattleResultStep]
    or a
    jr z, .call_find_min_of_six_stat_words
    cp $01
    jr z, .call_find_min_of_six_stat_words
    cp $02
    jr z, .call_find_max_of_six_stat_words
    jr .read_work_buf

.call_find_min_of_six_stat_words:
    call FindMinOfSixStatWords
    push hl
    ld a, [wWorkBuf + $1]
    ld hl, BattleResultStatBonusByRank
    add_a_to_hl
    ld c, [hl]
    pop hl
    call AddCToWordCappedAt999
    ld a, c
    ld [wWorkBuf + $a], a
    ld a, [wWorkBuf + $1]
    add a
    ld hl, BattleResultGoldByRank
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    jr .set_work_buf

.call_find_max_of_six_stat_words:
    call FindMaxOfSixStatWords
    push hl
    ld a, [wWorkBuf + $1]
    ld hl, BattleResultStatPenaltyByRank
    add_a_to_hl
    ld c, [hl]
    pop hl
    call SubtractCFromWordMin1
    ld a, b
    ld [wWorkBuf + $a], a
    ld de, $03e8
    jr .set_work_buf

.read_work_buf:
    push hl
    ld a, [wWorkBuf + $1]
    ld hl, BattleResultStatPenaltyByRank
    add_a_to_hl
    ld c, [hl]
    pop hl
    call SubtractCFromWordMin1
    ld a, b
    ld [wWorkBuf + $a], a
    inc hl
    inc hl
    call SubtractCFromWordMin1
    ld a, b
    ld [wWorkBuf + $b], a
    call SubtractCFromWordMin1
    ld a, b
    ld [wWorkBuf + $c], a
    call SubtractCFromWordMin1
    ld a, b
    ld [wWorkBuf + $d], a
    call SubtractCFromWordMin1
    ld a, b
    ld [wWorkBuf + $e], a
    call SubtractCFromWordMin1
    ld a, b
    ld [wWorkBuf + $f], a
    ld de, $03e8

.set_work_buf:
    ld a, e
    ld [wWorkBuf + $10], a
    ld a, d
    ld [wWorkBuf + $11], a
    ld a, [wGoldLo]
    add e
    ld l, a
    ld a, [wGoldMid]
    adc d
    ld h, a
    ld a, [wGoldHi]
    adc $00
    ld e, a
    push hl
    ld a, l
    sub $9f
    ld l, a
    ld a, h
    sbc $86
    ld h, a
    ld a, e
    sbc $01
    jr c, .set_gold_lo
    or h
    or l
    jr z, .set_gold_lo
    ld a, l
    cpl
    ld l, a
    ld a, h
    cpl
    ld h, a
    inc hl
    ld a, l
    ld [wWorkBuf + $10], a
    ld a, h
    ld [wWorkBuf + $11], a
    pop hl
    ld e, $01
    ld h, $86
    ld l, $9f
    jr .set_gold_lo2

.set_gold_lo:
    pop hl

.set_gold_lo2:
    ld a, l
    ld [wGoldLo], a
    ld a, h
    ld [wGoldMid], a
    ld a, e
    ld [wGoldHi], a
    ld a, [wLinkReceivedByte]
    ld c, MON_MAX_HP + 1
    call SRAMRecordAddress
    ld a, [hld]
    ld b, a
    ld a, [hld]
    ld c, a
    push hl
    ld a, [hld]
    ld l, [hl]
    ld a, h
    call CompareHLToBC
    pop hl
    jr c, .read_link_received_byte
    ld a, b
    ld [hld], a
    ld [hl], c

.read_link_received_byte:
    ld a, [wLinkReceivedByte]
    ld c, MON_MAX_MP + 1
    call SRAMRecordAddress
    ld a, [hld]
    ld b, a
    ld a, [hld]
    ld c, a
    push hl
    ld a, [hld]
    ld a, [hl]
    ld l, a
    ld h, a
    call CompareHLToBC
    pop hl
    jr c, .done
    ld a, b
    ld [hld], a
    ld [hl], c

.done:
    xor a
    ld [rRAMG], a
    ret

; HL = a word, C = an amount: adds C to the word and stops it at 999; C becomes the amount that was
; really added; HL ends on the low byte of the word, A, DE are clobbered. Called by
; ApplyBattleResultStatChanges. (C2, E-0385)
; the word at HL += C, capped at 999; C becomes the amount actually added (E-0124)
AddCToWordCappedAt999::
    ld a, [hli]
    add c
    ld e, a
    ld a, [hl]
    adc $00
    ld d, a
    push de
    ld a, e
    sub $e7
    ld e, a
    ld a, d
    sbc $03
    jr c, .restore
    or e
    jr z, .restore
    ld a, c
    sub e
    ld c, a
    pop de
    ld d, $03
    ld e, $e7
    jr .skip

.restore:
    pop de

.skip:
    ld [hl], d
    dec hl
    ld [hl], e
    ret

; HL = a word, C = an amount: subtracts C from the word; a result of 0 or less is stored as 1. HL
; ends 2 bytes on (after the word); A, DE are clobbered. B = C, except when C is more than the word:
; then B = C minus the low byte of the word, which is not the amount taken (a result of exactly 0
; also gives B = C although only C - 1 was taken). Called seven times by
; ApplyBattleResultStatChanges, which stores B as the amount shown in the stat fall messages. (C2,
; E-0385)
; the word at HL -= C; results at or below 0 become 1 (B = the amount actually taken) (E-0124)
SubtractCFromWordMin1::
    ld b, c
    ld a, [hli]
    sub c
    ld e, a
    ld a, [hld]
    sbc $00
    ld d, a
    jr c, .skip
    or e
    jr nz, .skip3
    jr .skip2

.skip:
    ld a, e
    cpl
    inc a
    ld b, a

.skip2:
    ld de, $0001

.skip3:
    ld a, e
    ld [hli], a
    ld a, d
    ld [hli], a
    ret

; HL = the first word of a stat block (MON_MAX_HP in its one caller, ApplyBattleResultStatChanges):
; compares the six words at HL + 0, + 4, + 6, + 8, + $A and + $C (the word at + 2 is skipped) with
; KeepMinWordEntry and returns HL = the smallest one, HL + FindMinOfSixStatWords_Data[number]; the
; number 0-5 of the winner goes to wWorkBuf + 9. On equal words RollTieBreakCarry decides (carry
; takes the later word). A, BC, DE are clobbered; the name says five because five words are compared
; with the first. (C2, E-0385)
; finds the entry with the smallest of five words after HL (ties broken randomly), stores its index
; in wWorkBuf + $9 and returns HL + FindMinOfSixStatWords_Data[index] (E-0122)
FindMinOfSixStatWords::
    push hl
    ld de, $0000
    ld a, [hli]
    ld b, [hl]
    ld c, a
    inc hl
    inc hl
    call KeepMinWordEntry
    call KeepMinWordEntry
    call KeepMinWordEntry
    call KeepMinWordEntry
    call KeepMinWordEntry
    ld a, e
    ld [wWorkBuf + $9], a
    ld hl, FindMinOfSixStatWords_Data
    add_a_to_hl
    ld a, [hl]
    pop hl
    add_a_to_hl
    ret

; One step of the search in FindMinOfSixStatWords: D += 1; reads the word at HL + 1 (HL ends 2 bytes
; on, on its high byte); when it is below BC, or equal to BC and RollTieBreakCarry sets carry, BC =
; that word and E = D. A is clobbered. (C2, E-0385)
; next table entry: D += 1; if its word is below BC (or equal and RollTieBreakCarry succeeds), BC =
; word and E = D (E-0122)
KeepMinWordEntry::
    inc hl
    inc d
    ld a, [hli]
    push hl
    ld h, [hl]
    ld l, a
    call CompareHLToBC
    call z, RollTieBreakCarry
    jr nc, .done
    ld b, h
    ld c, l
    ld e, d

.done:
    pop hl
    ret

; Like FindMinOfSixStatWords but finds the largest of the six words at HL + 0, + 4, + 6, + 8, + $A
; and + $C (KeepMaxWordEntry): returns HL = the winner, the number 0-5 in wWorkBuf + 9. On equal
; words RollTieBreakCarry decides (carry keeps the earlier word). Called by
; ApplyBattleResultStatChanges for result 2. (C2, E-0385)
; finds the entry with the largest of five words after HL (ties broken randomly), stores its index
; in wWorkBuf + $9 and returns HL + FindMinOfSixStatWords_Data[index] (E-0122)
FindMaxOfSixStatWords::
    push hl
    ld de, $0000
    ld a, [hli]
    ld b, [hl]
    ld c, a
    inc hl
    inc hl
    call KeepMaxWordEntry
    call KeepMaxWordEntry
    call KeepMaxWordEntry
    call KeepMaxWordEntry
    call KeepMaxWordEntry
    ld a, e
    ld [wWorkBuf + $9], a
    ld hl, FindMinOfSixStatWords_Data
    add_a_to_hl
    ld a, [hl]
    pop hl
    add_a_to_hl
    ret

; One step of the search in FindMaxOfSixStatWords: D += 1; reads the word at HL + 1 (HL ends 2 bytes
; on); when it is not below BC (equal only when RollTieBreakCarry does not set carry), BC = that
; word and E = D. A is clobbered. (C2, E-0385)
; next table entry: D += 1; if its word is not below BC (equal only when RollTieBreakCarry fails),
; BC = word and E = D (E-0122)
KeepMaxWordEntry::
    inc hl
    inc d
    ld a, [hli]
    push hl
    ld h, [hl]
    ld l, a
    call CompareHLToBC
    call z, RollTieBreakCarry
    jr c, .done
    ld b, h
    ld c, l
    ld e, d

.done:
    pop hl
    ret

; Calls AdvanceRandom and compares the new wRandomLo with $80: carry set (and A below $80) about
; half of the time, carry clear otherwise. A = wRandomLo. Its two callers, KeepMinWordEntry and
; KeepMaxWordEntry, use it as the tie-break between equal words. (C2, E-0385)
; AdvanceRandom, then compares wRandomLo with $80: carry (success) half the time (E-0116)
RollTieBreakCarry::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $80
    ret

; Six bytes, one per candidate word: $00, $04, $06, $08, $0A, $0C. They are the byte offsets from
; the start of a record stat block (HL, which ApplyBattleResultStatChanges points at MON_MAX_HP) to
; the six words the search compares: MON_MAX_HP, MON_MAX_MP, MON_ATK, MON_DEF, MON_AGL and MON_INT
; (the word at +2, MON_MP, is skipped). Both FindMinOfSixStatWords and FindMaxOfSixStatWords index
; it with the winning word number 0-5 (also stored in wWorkBuf + $9) and return HL plus the byte.
; (C1, E-0381)
FindMinOfSixStatWords_Data::
    db $00, $04, $06, $08, $0a, $0c

; one byte per rank 0-7: the amount added to the lowest record word (E-0289)
BattleResultStatBonusByRank::
    db $01, $02, $03, $04, $05, $06, $08, $0a

; one byte per rank 0-7: the amount subtracted (floor 1) (E-0289)
BattleResultStatPenaltyByRank::
    db $01, $01, $01, $01, $01, $01, $01, $01

; one word per rank 0-7, stored to wWorkBuf+$10 (C1: a gold amount, from the gold reads that follow)
; (E-0289)
BattleResultGoldByRank::
    db $e8, $03, $e8, $03, $e8, $03, $e8, $03, $e8, $03, $e8, $03, $e8, $03, $e8, $03

; Starts a turn: sets side control bit 7 of all eight slots (wSideControl), clears wPersonalityActs
; ($10 bytes) and wActionQueue ($0A bytes), sets wBattleActionChoice ($10 bytes), wBattleItemTarget
; and wBattleItemId to $FF and wMenuState to 0. When neither slot 0 nor 1 has mark 0 in wSlotMarks
; it advances wBattleStep once, so the caller's own advance skips step 1 (RunBattleSetup_BankA0).
; Then marks slots 0 and 1 in wSlotMarks: 3 when absent (CarryUnlessBattleSlotOutSlotEmpty), 1 when
; it cannot act (CheckSlotStatusBlock) or has status 3 bits 6-7, status 4 bits 2-3, status 5 bits
; 4-5 or status 8 bits 0-1 (from wBattleStatus3), otherwise 0. (C2, E-0371; probed E-0385)
RunBattlePhaseWhenTextIdle_A0_RunTurn_Reset::
    ld hl, wSideControl
    ld b, $08

.loop:
    set 7, [hl]
    inc hl
    dec b
    jr nz, .loop
    ld hl, wPersonalityActs
    ld bc, $0010
    xor a
    call FillBytes
    ld hl, wActionQueue
    ld bc, $000a
    xor a
    call FillBytes
    ld hl, wBattleActionChoice
    ld bc, $0010
    ld a, $ff
    call FillBytes
    ld a, $ff
    ld [wBattleItemTarget], a
    ld [wBattleItemId], a
    ld a, $00
    ld [wMenuState], a
    ld bc, $0200
    ld hl, wSlotMarks
    push bc

.loop2:
    ld a, [hli]
    or a
    jr nz, .next
    inc c

.next:
    dec b
    jr nz, .loop2
    ld a, c
    or a
    jr nz, .restore
    ld hl, wBattleStep
    inc [hl]

.restore:
    pop bc

.loop3:
    ld e, $03
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    ld e, $01
    ld a, c
    call CheckSlotStatusBlock
    jr c, .skip
    ld a, c
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hli]
    and $c0
    jr nz, .skip
    ld a, [hli]
    and $0c
    jr nz, .skip
    ld a, [hli]
    and $30
    jr nz, .skip
    inc hl
    inc hl
    ld a, [hl]
    and $03
    jr nz, .skip
    ld e, $00

.skip:
    ld a, c
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], e
    inc c
    dec b
    jr nz, .loop3
    ret

; The turn set-up of game mode 7 (battle step 1; RunBattlePhaseWhenTextIdle_A0_RunTurn_Setup calls
; it every frame). Jumps by wBattleSubPhase to 13 sub-phases: 0 RunBattleSetup_BankA0_EntrySelect
; (choosing what to do), 1 RunBattleSetup_BankA0_CommandMenu (the commands of the monster), 2
; RunBattleSetup_BankA0_DoNothing, 3 RunBattleSetup_BankA0_MarkSlotsToAct, 4
; RunBattleSetup_BankA0_ShowSelectingHeroSMove, 5 RunBattleSetup_BankA0_PackChoice, 6
; RunBattleSetup_BankA0_PrepareExchange, 7 RunBattleSetup_BankA0_StartExchange, 8
; RunBattleSetup_BankA0_TakePartnerChoice, 9 RunBattleSetup_BankA0_CompareSeeds, 10
; RunBattleSetup_BankA0_WaitPartnerSeed, 11 RunBattleSetup_BankA0_ConfirmSeeds (back to 5 unless
; both sides agree on the seed) and 12 RunBattleSetup_BankA0_ClearWindow, which adds 1 to
; wBattleStep. Sub-phases 0 and 1 are the menus; 3 marks the slots, 4 shows the message that the
; partner is selecting a move, 5 to 11 trade the choices and the random seed with the partner over
; the link, and 12 waits for the partner and goes on. (C1, E-0385)
; a 13-step dispatcher on wBattleSubPhase laid out like RunBattleSetup (bank $31), but only the
; dispatch matches: the steps are this bank's own (E-0363; narrows E-0107)
RunBattleSetup_BankA0::
    ld a, [wBattleSubPhase]
    jumptable
    dw RunBattleSetup_BankA0_EntrySelect
    dw RunBattleSetup_BankA0_CommandMenu
    dw RunBattleSetup_BankA0_DoNothing
    dw RunBattleSetup_BankA0_MarkSlotsToAct
    dw RunBattleSetup_BankA0_ShowSelectingHeroSMove
    dw RunBattleSetup_BankA0_PackChoice
    dw RunBattleSetup_BankA0_PrepareExchange
    dw RunBattleSetup_BankA0_StartExchange
    dw RunBattleSetup_BankA0_TakePartnerChoice
    dw RunBattleSetup_BankA0_CompareSeeds
    dw RunBattleSetup_BankA0_WaitPartnerSeed
    dw RunBattleSetup_BankA0_ConfirmSeeds
    dw RunBattleSetup_BankA0_ClearWindow

; Sub-phase 0 of RunBattleSetup_BankA0, choosing what to do: jumps by wBattleResolveStep to 8 steps:
; 0 RunBattleSetup_BankA0_EntrySelect_ShowChoices, 1 RunBattleSetup_BankA0_EntrySelect_ShowCursor, 2
; RunBattleSetup_BankA0_EntrySelect_Cursor, 3 RunBattleSetup_BankA0_EntrySelect_RedrawWindow, 4
; RunBattleSetup_BankA0_EntrySelect_Choose, 5 RunBattleSetup_BankA0_EntrySelect_DrawRecordFrame, 6
; RunBattleSetup_BankA0_EntrySelect_ShowString, 7 RunBattleSetup_BankA0_EntrySelect_Redraw. Step 4
; either leaves the menu (wBattleSubPhase 3 or 1) or goes on through steps 5-7 to show a message and
; returns to step 1. (C1, E-0385)
; by wBattleResolveStep: lays out the tile blocks for the foe count and moves a selection over
; entries, setting or clearing bit 6 and the entry tile (SetBit6AndBlankEntryTile_BankA0,
; ClearBit6AndCursorEntryTile_BankA0)
RunBattleSetup_BankA0_EntrySelect::
    ld a, [wBattleResolveStep]
    jumptable
    dw RunBattleSetup_BankA0_EntrySelect_ShowChoices
    dw RunBattleSetup_BankA0_EntrySelect_ShowCursor
    dw RunBattleSetup_BankA0_EntrySelect_Cursor
    dw RunBattleSetup_BankA0_EntrySelect_RedrawWindow
    dw RunBattleSetup_BankA0_EntrySelect_Choose
    dw RunBattleSetup_BankA0_EntrySelect_DrawRecordFrame
    dw RunBattleSetup_BankA0_EntrySelect_ShowString
    dw RunBattleSetup_BankA0_EntrySelect_Redraw

; Choosing what to do, step 0: sets side control bit 7 on slots 0-3, lays out the screen, shows the
; choices (string 0 of category 2, 7 x 1 at VRAM $96D0) and draws the record frame. (C1, E-0357)
RunBattleSetup_BankA0_EntrySelect_ShowChoices::
    ld hl, wSideControl
    set 7, [hl]
    inc hl
    set 7, [hl]
    inc hl
    set 7, [hl]
    inc hl
    set 7, [hl]
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    farcall CopyScreenBufferRect20x11ToBGMapRow7
    ld hl, vTiles1 + $6d0
    ld de, $0701
    ld a, $02
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_BankA0
    farcall CopyRectRecordToScreenBuffer_2
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; Choosing what to do, step 1: draws the window and the cursor ($BB) at choice wMenuState. (C1,
; E-0357)
RunBattleSetup_BankA0_EntrySelect_ShowCursor::
    call RunBattleSetup_BankA0_EntrySelect_DrawWindow
    ld hl, RunBattleSetup_BankA0_EntrySelect_ShowCursor_Data
    ld a, [wMenuState]
    and $03
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $bb
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; Choosing what to do, step 2: moves the cursor; A (sound $69) clears the menu bytes, lays out the
; screen and goes on. (C1, E-0357)
RunBattleSetup_BankA0_EntrySelect_Cursor::
    ld de, RunBattleSetup_BankA0_EntrySelect_ShowCursor_Data
    ld hl, wMenuState
    call TwoByTwoCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .return
    ld a, $69
    call QueueSoundEffect
    ld hl, wMenuSubState
    ld bc, $0007
    ld a, $00
    call FillBytes
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]

.return:
    ret

; Choosing what to do, step 3: redraws the window. (C1, E-0357)
RunBattleSetup_BankA0_EntrySelect_RedrawWindow::
    call RunBattleSetup_BankA0_EntrySelect_DrawWindow
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; Choosing what to do, step 4: by the choice (wBattleSetupDB): 0 clears this side's action and
; fights (sub-phase 3); 1 commands this side's monster (wCommandMonster, sub-phase 1) when it can
; act, otherwise string $2D; 2 string $1D; 3 string $20. (C2, E-0357; probed E-0385)
RunBattleSetup_BankA0_EntrySelect_Choose::
    ld a, [wMenuState]
    and $03
    ld [wBattleSetupDB], a
    or a
    jr z, .call_run_battle_setup_bank_a0_entry_select
    cp $01
    jr z, .read_link_role
    cp $02
    jr z, .skip
    jr .set_string_index_to_20

.call_run_battle_setup_bank_a0_entry_select:
    call RunBattleSetup_BankA0_EntrySelect_ClearOwnAction
    ld a, $03
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    jp .return

.read_link_role:
    ld a, [wLinkRole]
    rrca
    and $01
    ld c, a
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    or a
    jr z, .set_command_monster
    ld a, $00
    ld [wStringCategory], a
    ld a, $2d
    ld [wStringIndex], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.set_command_monster:
    ld a, c
    ld [wCommandMonster], a
    ld a, $01
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    jr .return

.skip:
    ld a, $1d
    jr .set_string_index

.set_string_index_to_20:
    ld a, $20

.set_string_index:
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    ld hl, wBattleResolveStep
    inc [hl]

.return:
    ret

; Clears this side's action choice (slot 0, or 1 for link role bit 1). (C2, E-0357; probed E-0385)
RunBattleSetup_BankA0_EntrySelect_ClearOwnAction::
    ld a, [wLinkRole]
    and $02
    ld hl, wBattleActionChoice
    add_a_to_hl
    ld a, $ff
    ld [hli], a
    ld [hli], a
    ret

; Choosing what to do, step 5: redraws, draws the record frame and the bottom rows. (C1, E-0357)
RunBattleSetup_BankA0_EntrySelect_DrawRecordFrame::
    call RunBattleSetup_BankA0_ClearTextTiles
    farcall CopyRectRecordToScreenBuffer
    call DrawRows13To17ToBGMap_BankA0
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; Choosing what to do, step 6: starts the chosen string (bank $2F). (C1, E-0357)
RunBattleSetup_BankA0_EntrySelect_ShowString::
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; Choosing what to do, step 7: after the text redraws and returns to step 1. (C1, E-0357)
RunBattleSetup_BankA0_EntrySelect_Redraw::
    ld a, [wTextFlags]
    or a
    ret nz
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    call DrawRows13To17ToBGMap_BankA0
    farcall CopyRectRecordToScreenBuffer_2
    ld a, $01
    ld [wBattleResolveStep], a
    ret

; Sub-phase 1 of RunBattleSetup_BankA0, the command menu of the monster wCommandMonster: jumps by
; wBattleResolveStep to 25 steps. Tactic list: 0 RunBattleSetup_BankA0_CommandMenu_DrawLists, 1
; RunBattleSetup_BankA0_CommandMenu_ShowTacticCursor, 2 RunBattleSetup_BankA0_CommandMenu_SetTactic,
; 3 RunBattleSetup_BankA0_CommandMenu_BackToChoosing. Command list: 4
; RunBattleSetup_BankA0_CommandMenu_ShowCommands, 5
; RunBattleSetup_BankA0_CommandMenu_CursorOnCommand, 6
; RunBattleSetup_BankA0_CommandMenu_StoreCommand, 7 RunBattleSetup_BankA0_CommandMenu_AfterCommand.
; Messages: 8 and 21 RunBattleSetup_BankA0_CommandMenu_PrepareMessage, 9
; RunBattleSetup_BankA0_CommandMenu_NoUsableSkills, 22
; RunBattleSetup_BankA0_CommandMenu_ShowButThereIsNo, then 10 and 23
; RunBattleSetup_BankA0_CommandMenu_LayOut and 11 and 24
; RunBattleSetup_BankA0_CommandMenu_BackToList. Skill list: 12
; RunBattleSetup_BankA0_CommandMenu_ShowSkills, 13
; RunBattleSetup_BankA0_CommandMenu_ShowSkillCursor, 14
; RunBattleSetup_BankA0_CommandMenu_SkillCursor, 15 RunBattleSetup_BankA0_CommandMenu_ReturnToStep,
; 16 RunBattleSetup_BankA0_CommandMenu_DrawRecordFrame, 17
; RunBattleSetup_BankA0_CommandMenu_ShowSkillError, 18
; RunBattleSetup_BankA0_CommandMenu_LayOutAfterText, 19
; RunBattleSetup_BankA0_CommandMenu_BackToSkills. 20 RunBattleSetup_BankA0_CommandMenu_Finish ends
; the menu with wBattleSubPhase 3. (C1, E-0385)
; by wBattleResolveStep: the bank-$A0 copy of RunBattleSetup_PlanMenu (command windows, 'It has no
; usable ...')
RunBattleSetup_BankA0_CommandMenu::
    ld a, [wBattleResolveStep]
    jumptable
    dw RunBattleSetup_BankA0_CommandMenu_DrawLists
    dw RunBattleSetup_BankA0_CommandMenu_ShowTacticCursor
    dw RunBattleSetup_BankA0_CommandMenu_SetTactic
    dw RunBattleSetup_BankA0_CommandMenu_BackToChoosing
    dw RunBattleSetup_BankA0_CommandMenu_ShowCommands
    dw RunBattleSetup_BankA0_CommandMenu_CursorOnCommand
    dw RunBattleSetup_BankA0_CommandMenu_StoreCommand
    dw RunBattleSetup_BankA0_CommandMenu_AfterCommand
    dw RunBattleSetup_BankA0_CommandMenu_PrepareMessage
    dw RunBattleSetup_BankA0_CommandMenu_NoUsableSkills
    dw RunBattleSetup_BankA0_CommandMenu_LayOut
    dw RunBattleSetup_BankA0_CommandMenu_BackToList
    dw RunBattleSetup_BankA0_CommandMenu_ShowSkills
    dw RunBattleSetup_BankA0_CommandMenu_ShowSkillCursor
    dw RunBattleSetup_BankA0_CommandMenu_SkillCursor
    dw RunBattleSetup_BankA0_CommandMenu_ReturnToStep
    dw RunBattleSetup_BankA0_CommandMenu_DrawRecordFrame
    dw RunBattleSetup_BankA0_CommandMenu_ShowSkillError
    dw RunBattleSetup_BankA0_CommandMenu_LayOutAfterText
    dw RunBattleSetup_BankA0_CommandMenu_BackToSkills
    dw RunBattleSetup_BankA0_CommandMenu_Finish
    dw RunBattleSetup_BankA0_CommandMenu_PrepareMessage
    dw RunBattleSetup_BankA0_CommandMenu_ShowButThereIsNo
    dw RunBattleSetup_BankA0_CommandMenu_LayOut
    dw RunBattleSetup_BankA0_CommandMenu_BackToList

; The command menu, step 0: shows the tactic list (string 1 of category 2) and the command list
; (string 8), four places, and draws the frame. (C1, E-0357)
RunBattleSetup_BankA0_CommandMenu_DrawLists::
    ld hl, vTiles1 + $6d0
    ld de, $2001
    ld a, $02
    ld [wStringCategory], a
    ld a, $01
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_BankA0
    ld a, $08
    ld [wStringIndex], a
    ld hl, vTiles2 + $50
    ld de, $0801
    call ShowStringBank09AtTilesHL_BankA0
    xor a
    ld [wCommandPageCount], a
    ld a, $03
    ld [wCommandCursorMax], a
    xor a
    ld [wCommandCursor], a
    farcall CopyRectRecordToScreenBuffer_4
    ld hl, wScreenTileBuffer + $103
    call WriteFiveTileNumbersForCommandMonster
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; The command menu, step 1: puts the cursor on the monster's tactic (wBattleLoadWork) and draws it.
; (C1, E-0357)
RunBattleSetup_BankA0_CommandMenu_ShowTacticCursor::
    ld a, [wCommandMonster]
    ld hl, wBattleLoadWork
    add_a_to_hl
    ld a, [hl]
    ld [wMenuSubState], a
    call DrawRows7To17ToBGMap_BankA0
    ld hl, RunBattleSetup_BankA0_ListCursorOffsets
    ld a, [wMenuSubState]
    and $03
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $bb
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $03
    ld [wListLastPageSize], a
    ret

; The command menu, step 2: A (sound $69) sets the tactic; tactic 3 goes on two steps to the
; commands, the others clear the action, set side control bit 7 and fight (sub-phase 3); B goes
; back. (C1, E-0357)
RunBattleSetup_BankA0_CommandMenu_SetTactic::
    ld de, RunBattleSetup_BankA0_ListCursorOffsets
    ld hl, wMenuSubState
    call SkillListCursor_BankA0
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    ld a, [wCommandMonster]
    ld hl, wBattleLoadWork
    add_a_to_hl
    ld a, [wMenuSubState]
    and $03
    ld [hl], a
    call SetCommandMonsterTactic_BankA0
    cp $03
    jr nz, .read_command_monster
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $00
    ld [wBattleArg1], a
    ret

.check_bit1:
    bit 1, a
    jr z, .return
    ld a, $00
    ld [wBattleArg1], a
    jr .call_clear_and_layout_tile_blocks_for_battle

.read_command_monster:
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a
    add_a_to_hl
    ld a, $ff
    ld [hli], a
    ld [hl], a
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    set 7, [hl]
    xor a
    ld [wBattleResolveStep], a
    ld a, $03
    ld [wBattleSubPhase], a
    jr .return

.call_clear_and_layout_tile_blocks_for_battle:
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]

.return:
    ret

; The command menu, step 3: redraws and returns to choosing (sub-phase 0). (C1, E-0357)
RunBattleSetup_BankA0_CommandMenu_BackToChoosing::
    call DrawRows7To17ToBGMap_BankA0
    xor a
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleSubPhase], a
    ret

; The command menu, step 4: shows the command list (string 9 of category 2, 8 x 3), draws its frame
; and puts the cursor at side control bits 4-5. (C1, E-0357)
RunBattleSetup_BankA0_CommandMenu_ShowCommands::
    ld a, [wBattleArg1]
    or a
    call z, DrawRows7To17ToBGMap_BankA0
    xor a
    ld [wBattleArg1], a
    ld hl, vTiles1 + $6d0
    ld de, $0803
    ld a, $02
    ld [wStringCategory], a
    ld a, $09
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_BankA0
    farcall CopyRectRecordToScreenBuffer_6
    ld a, [wCommandMonster]
    and $03
    ld hl, wScreenTileBuffer + $142
    call WriteFiveTileNumbersForCommandMonster
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    swap a
    and $03
    ld [wMenuSelectedMember], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; The command menu, step 5: draws the cursor ($BB) at the command. (C1, E-0357)
RunBattleSetup_BankA0_CommandMenu_CursorOnCommand::
    call DrawRect11x9AtRow9ToBGMap_BankA0
    ld hl, RunBattleSetup_BankA0_CommandCursorOffsets
    ld a, [wMenuSelectedMember]
    and $03
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $bb
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; The command menu, step 6: B goes back; A (sound $69) stores the command in side control bits 4-5:
; 0 picks action $C0 aimed at the partner slot (step $15 when absent), 1 the skills (step 8 when
; none can be used, otherwise step $0C), 2 action $AC on itself. (C1, E-0357)
RunBattleSetup_BankA0_CommandMenu_StoreCommand::
    ld de, RunBattleSetup_BankA0_CommandCursorOffsets
    ld hl, wMenuSelectedMember
    call ThreeEntryCursor_BankA0
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_bit0
    ld a, $00
    ld [wBattleArg1], a
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]
    jp .return

.check_bit0:
    bit 0, a
    jp z, .return
    ld a, $69
    call QueueSoundEffect
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    and $0f
    ld [hl], a
    ld a, [wMenuSelectedMember]
    and $03
    swap a
    or [hl]
    ld [hl], a
    ld a, [wMenuSelectedMember]
    and $03
    or a
    jr z, .read_command_monster
    cp $01
    jr z, .call_count_skills_for_list_bank_a0
    jr .read_command_monster2

.read_command_monster:
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a
    add_a_to_hl
    ld a, $c0
    ld [hli], a
    ld a, [wCommandMonster]
    xor $01
    ld c, a
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .call_clear_and_layout_tile_blocks_for_battle
    ld a, c
    ld [hl], a
    jr .set_battle_arg1_to_01

.call_clear_and_layout_tile_blocks_for_battle:
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    ld a, $15
    ld [wBattleResolveStep], a
    jr .return

.call_count_skills_for_list_bank_a0:
    call CountSkillsForList_BankA0
    ld a, d
    or a
    jr nz, .call_clear_and_layout_tile_blocks_for_battle2
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    ld a, $08
    ld [wBattleResolveStep], a
    jr .return

.call_clear_and_layout_tile_blocks_for_battle2:
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    xor a
    ld [wBattleArg1], a
    ld a, $0c
    ld [wBattleResolveStep], a
    jr .return

.read_command_monster2:
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a
    add_a_to_hl
    ld a, $ac
    ld [hli], a
    ld a, [wCommandMonster]
    ld [hl], a

.set_battle_arg1_to_01:
    ld a, $01
    ld [wBattleArg1], a
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]

.return:
    ret

; The command menu, step 7: redraws; step $14 after a choice, otherwise step 0. (C1, E-0357)
RunBattleSetup_BankA0_CommandMenu_AfterCommand::
    call DrawRect11x9AtRow9ToBGMap_BankA0
    ld a, [wBattleArg1]
    or a
    jr z, .set_battle_resolve_step
    ld a, $14

.set_battle_resolve_step:
    ld [wBattleResolveStep], a
    ret

; The command menu, step 8: redraws, clears the text tiles and draws the record frame. (C1, E-0357)
RunBattleSetup_BankA0_CommandMenu_PrepareMessage::
    call DrawRect11x9AtRow9ToBGMap_BankA0
    call FillTilesFromRequest
    farcall CopyRectRecordToScreenBuffer
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; The command menu, step 9: 'It has no usable battle skills!' (string $29). (C1, E-0357)
RunBattleSetup_BankA0_CommandMenu_NoUsableSkills::
    call DrawRows13To17ToBGMap_BankA0
    ld a, $00
    ld [wStringCategory], a
    ld a, $29
    ld [wStringIndex], a ; 'It has no usable battle skills!'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; The command menu, step 22: 'But there is no one to ...' (string $7F). (C1, E-0357)
RunBattleSetup_BankA0_CommandMenu_ShowButThereIsNo::
    call DrawRows13To17ToBGMap_BankA0
    ld a, $00
    ld [wStringCategory], a
    ld a, $7f
    ld [wStringIndex], a ; 'But there is no one to'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; The command menu, step 10: after the text lays out the screen and goes on. (C2, E-0357; probed
; E-0385)
RunBattleSetup_BankA0_CommandMenu_LayOut::
    ld a, [wTextFlags]
    or a
    ret nz
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; The command menu, step 11: draws the bottom rows and returns to the command list (step 4). (C1,
; E-0357)
RunBattleSetup_BankA0_CommandMenu_BackToList::
    call DrawRows13To17ToBGMap_BankA0
    ld a, $04
    ld [wBattleResolveStep], a
    ret

; The command menu, step 12 (the skills): takes the cursor from side control (bits 0-1 the entry,
; bit 2 the page), shows the page's skill names, the cursor and frame, and the chosen skill's name
; and MP cost. (C1, E-0357)
RunBattleSetup_BankA0_CommandMenu_ShowSkills::
    ld a, [wBattleArg1]
    or a
    call z, DrawRect11x9AtRow9ToBGMap_BankA0
    xor a
    ld [wBattleArg1], a
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    and $03
    ld [wMenuCursor], a
    ld a, [hl]
    rrca
    rrca
    and $01
    ld [wCommandCursor], a
    ld hl, wCommandCursor
    res 7, [hl]
    ld de, RunBattleSetup_BankA0_ListCursorOffsets
    call ShowSkillPageNames_BankA0
    call RedrawSkillList_BankA0
    farcall CopyRectRecordsAndToScreenBuffer
    ld a, $09
    ld [wStringCategory], a
    ld a, [wBattleArg2]
    ld l, a
    ld a, [wBattleArg3]
    ld h, a
    ld a, [wCommandCursor]
    add a
    add a
    ld c, a
    ld a, [wMenuCursor]
    and $03
    add c
    add a
    add_a_to_hl
    ld a, [hl]
    call ShowSkillNameAndCost
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; The command menu, step 13: draws the list, the cursor ($BB) and the page indicator (three entries
; a page). (C1, E-0357)
RunBattleSetup_BankA0_CommandMenu_ShowSkillCursor::
    call DrawRow8AndRows9To17ToBGMap_BankA0
    ld hl, RunBattleSetup_BankA0_ListCursorOffsets
    ld a, [wMenuCursor]
    and $03
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $bb
    call WriteVRAMByte
    call DrawInventoryPageIndicator_BankA0
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $03
    ld [wListLastPageSize], a
    ret

; The command menu, step 14: the skill cursor: A (sound $69) loads the skill; one without record
; byte 3 bit 0 shows string $25, one costing more MP than the monster has (cost $FF counts as 1)
; string $26, both returning here through step 16; otherwise stores the page and entry in side
; control and the skill as the action and goes on; B returns to the commands. (C1, E-0357)
RunBattleSetup_BankA0_CommandMenu_SkillCursor::
    ld de, RunBattleSetup_BankA0_ListCursorOffsets
    ld hl, wMenuCursor
    call SkillListCursor_BankA0
    ld a, [wJoypadPressed]
    bit 0, a
    jp z, .check_joypad_pressed
    ld a, $69
    call QueueSoundEffect
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    ld a, $14
    ld [wBattleArg1], a
    call LoadSelectedSkillRecord_BankA0
    ld a, [wRecordBufferData + $3]
    bit 0, a
    jp z, .set_string_index_to_25
    ld a, [wCommandMonster]
    ld hl, wBattleMP
    add a
    add_a_to_hl
    deref_hl
    ld a, [wRecordBufferData]
    ld c, a
    cp $ff
    jr nz, .skip
    ld c, $01

.skip:
    xor a
    ld b, a
    ld a, l
    sub c
    ld l, a
    ld a, h
    sbc b
    ld h, a
    bit 7, h
    jp nz, .set_string_index_to_26
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    and $f0
    ld [hl], a
    ld a, [wCommandCursor]
    rlca
    rlca
    and $04
    or [hl]
    ld [hl], a
    ld a, [wMenuCursor]
    and $03
    or [hl]
    ld [hl], a
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a
    add_a_to_hl
    ld a, [wRecordBuffer]
    ld [hl], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .call_redraw_skill_list_bank_a0
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    ld a, $04
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.call_redraw_skill_list_bank_a0:
    call RedrawSkillList_BankA0
    call DrawInventoryPageIndicator_BankA0

.return:
    ret

.set_string_index_to_25:
    ld a, $25
    ld [wStringIndex], a
    ld a, $13
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.set_string_index_to_26:
    ld a, $26
    ld [wStringIndex], a
    ld a, $13
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

; The command menu, step 15: redraws and goes to the return step in wBattleArg1. (C1, E-0357)
RunBattleSetup_BankA0_CommandMenu_ReturnToStep::
    call DrawRow8AndRows9To17ToBGMap_BankA0
    ld a, [wBattleArg1]
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleArg1], a
    ret

; The command menu, step 16: lays out, redraws and draws the record frame. (C1, E-0357)
RunBattleSetup_BankA0_CommandMenu_DrawRecordFrame::
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    call DrawRow8AndRows9To17ToBGMap_BankA0
    farcall CopyRectRecordToScreenBuffer
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; The command menu, step 17: draws the bottom rows and starts the chosen string (bank $2F). (C1,
; E-0357)
RunBattleSetup_BankA0_CommandMenu_ShowSkillError::
    call DrawRows13To17ToBGMap_BankA0
    xor a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; The command menu, step 18: after the text lays out the screen. (C2, E-0357; probed E-0385)
RunBattleSetup_BankA0_CommandMenu_LayOutAfterText::
    ld a, [wTextFlags]
    or a
    ret nz
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; The command menu, step 19: draws the bottom rows and returns to the skill list (step $0C). (C1,
; E-0357)
RunBattleSetup_BankA0_CommandMenu_BackToSkills::
    call DrawRows13To17ToBGMap_BankA0
    ld a, $0c
    ld [wBattleResolveStep], a
    ret

; The command menu, step 20: the choice is made: fights (sub-phase 3). (C2, E-0357; probed E-0385)
RunBattleSetup_BankA0_CommandMenu_Finish::
    xor a
    ld [wBattleResolveStep], a
    ld a, $03
    ld [wBattleSubPhase], a
    ret

; Turn setup, sub-phase 2: nothing (a bare ret). (C2, E-0357; probed E-0385)
RunBattleSetup_BankA0_DoNothing::
    ret

; Turn setup, sub-phase 3: marks every slot with mark 0 as chosen (1), resets the actor, lays out
; the screen, blanks the text tiles, draws the frame and clears the send byte. (C1, E-0357)
RunBattleSetup_BankA0_MarkSlotsToAct::
    ld b, $08
    ld hl, wSlotMarks

.loop:
    ld a, [hl]
    or a
    jr nz, .next
    ld [hl], $01

.next:
    inc hl
    dec b
    jr nz, .loop
    xor a
    ld [wBattleActor], a
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    call RunBattleSetup_BankA0_ClearTextTiles
    farcall CopyRectRecordToScreenBuffer
    farcall CopyScreenBufferRect20x11ToBGMapRow7
    ld hl, wBattleSubPhase
    inc [hl]
    xor a
    ld [wLinkSendByte], a
    ret

; Turn setup, sub-phase 4: 'Selecting <partner>'s move...' (string $22) with the partner's name
; (wLinkSeedCopy). (C1, E-0357)
RunBattleSetup_BankA0_ShowSelectingHeroSMove::
    ld de, wLinkSeedCopy
    ld hl, wTextBuf0
    call CopyFiveGlyphsPlusMarks
    ld a, $00
    ld [wStringCategory], a
    ld a, $22
    ld [wStringIndex], a ; 'Selecting 0's move…'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; Turn set-up, sub-phase 5: advances the random number once (AdvanceRandom) and returns to try again
; on the next frame if wRandomLo or wRandomHi is $F3 (wRandomHi never gets that high and the random
; table holds no $F3, so it does not happen). Otherwise packs 11 bytes into wLinkRecvBuffer:
; wMenuState, wMenuSubState, the wSlotTactic byte of the own slot (wLinkRole bit 1), wRandomLo,
; wRandomHi, wSideControl and the byte after it, wBattleActionChoice, wBattleTargetChoice and
; wBattleActionChoice + 2 and + 3; sets wLinkSendByte to 1 and adds 1 to wBattleSubPhase. (C2,
; E-0385)
RunBattleSetup_BankA0_PackChoice::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $f3
    ret z
    ld a, [wRandomHi]
    cp $f3
    ret z
    ld a, [wLinkRole]
    rrca
    and $01
    ld hl, wSlotTactic
    add_a_to_hl
    ld d, [hl]
    ld hl, wLinkRecvBuffer
    ld a, [wMenuState]
    ld [hli], a
    ld a, [wMenuSubState]
    ld [hli], a
    ld a, d
    ld [hli], a
    ld a, [wRandomLo]
    ld [hli], a
    ld a, [wRandomHi]
    ld [hli], a
    ld a, [wSideControl]
    ld [hli], a
    ld a, [wSideControl + $1]
    ld [hli], a
    ld a, [wBattleActionChoice]
    ld [hli], a
    ld a, [wBattleTargetChoice]
    ld [hli], a
    ld a, [wBattleActionChoice + $2]
    ld [hli], a
    ld a, [wBattleActionChoice + $3]
    ld [hli], a
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; Turn setup, sub-phase 6: on the partner's 1 prepares an 11-byte exchange into wLinkPartnerName.
; (C2, E-0357; probed E-0385)
RunBattleSetup_BankA0_PrepareExchange::
    ld a, [wLinkMessage]
    cp $01
    ret nz
    ld hl, wBattleSubPhase
    inc [hl]
    xor a
    ld [wLinkBufferCountHi], a
    ld a, $0b
    ld [wLinkBufferCountLo], a
    ld hl, wLinkRecvBuffer
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, wLinkPartnerName
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ret

; Turn setup, sub-phase 7: starts the exchange (send byte $FF, wLinkReady). (C2, E-0357; probed
; E-0385)
RunBattleSetup_BankA0_StartExchange::
    ld hl, wBattleSubPhase
    inc [hl]
    ld a, $ff
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; Turn set-up, sub-phase 8: waits for wLinkMessage $F0, then clears wLinkSendByte and wLinkReady and
; takes the 11 bytes received in wLinkPartnerName. With wLinkRole bit 1 clear (this side owns slot
; 0): they become wSlotCommands and wPartnerCommand (bytes 0 and 1), the tactic of slot 1 (byte 2),
; the side control of slot 1 (byte 6) and the choice bytes of slot 1 (wBattleActionChoice + 2 and +
; 3, from bytes 9 and 10); bytes 3 and 4 (wRandomSeed2Lo and wRandomSeed2Hi) are overwritten with
; the own wBattleSetupFlagsLo and wBattleSetupFlagsHi. With bit 1 set (this side owns slot 1): the
; own wMenuState and wMenuSubState move to wSlotCommands and wPartnerCommand, then the partner bytes
; replace wMenuState, wMenuSubState, the tactic of slot 0, wRandomLo, wRandomHi, the side control of
; slot 0 (byte 5) and the choice and target bytes of slot 0 (bytes 7 and 8). The tactic taken is
; also copied to the last tactic unless it is 3. Then adds 1 to wBattleSubPhase. (C2, E-0385)
RunBattleSetup_BankA0_TakePartnerChoice::
    ld a, [wLinkMessage]
    cp $f0
    ret nz
    xor a
    ld [wLinkSendByte], a
    xor a
    ld [wLinkReady], a
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .set_slot_commands
    ld hl, wLinkPartnerName
    ld a, [hli]
    ld [wSlotCommands], a
    ld a, [hli]
    ld [wPartnerCommand], a
    ld a, [hli]
    ld [wSlotTactic + $1], a
    ld a, [wBattleSetupFlagsLo]
    ld [hli], a
    ld a, [wBattleSetupFlagsHi]
    ld [hli], a
    inc hl
    ld a, [hli]
    ld [wSideControl + $1], a
    inc hl
    inc hl
    ld a, [hli]
    ld [wBattleActionChoice + $2], a
    ld a, [hl]
    ld [wBattleActionChoice + $3], a
    ld hl, wSlotTactic + $1
    ld de, wSlotLastTactic + $1
    jr .skip

.set_slot_commands:
    ld hl, wMenuState
    ld a, [hli]
    ld [wSlotCommands], a
    ld a, [hl]
    ld [wPartnerCommand], a
    ld hl, wLinkPartnerName
    ld a, [hli]
    ld [wMenuState], a
    ld a, [hli]
    ld [wMenuSubState], a
    ld a, [hli]
    ld [wSlotTactic], a
    ld a, [hli]
    ld [wRandomLo], a
    ld a, [hli]
    ld [wRandomHi], a
    ld a, [hli]
    ld [wSideControl], a
    inc hl
    ld a, [hli]
    ld [wBattleActionChoice], a
    ld a, [hl]
    ld [wBattleTargetChoice], a
    ld hl, wSlotTactic
    ld de, wSlotLastTactic

.skip:
    ld a, [hl]
    cp $03
    jr z, .done
    ld [de], a

.done:
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; Turn setup, sub-phase 9: compares the second random seed with the exchanged one
; (wBattleSetupFlags) and sends $22 when they match, $33 when not (kept in wCounterPtr0Lo). (C2,
; E-0357; probed E-0385)
RunBattleSetup_BankA0_CompareSeeds::
    ld hl, wBattleSetupFlagsLo
    ld a, [hli]
    ld b, a
    ld a, [wRandomLo]
    cp b
    ld a, [wRandomSeed2Lo]
    cp b
    jr nz, .set_link_send_byte_to_33
    ld a, [hl]
    ld b, a
    ld a, [wRandomHi]
    cp b
    ld a, [wRandomSeed2Hi]
    cp b
    jr nz, .set_link_send_byte_to_33
    ld a, $22
    ld [wLinkSendByte], a
    ld [wCounterPtr0Lo], a
    jr .done

.set_link_send_byte_to_33:
    ld a, $33
    ld [wLinkSendByte], a
    ld [wCounterPtr0Lo], a

.done:
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; Turn setup, sub-phase 10: waits for the partner's $22 or $33 (kept in wCounterPtr0Hi). (C2,
; E-0357; probed E-0385)
RunBattleSetup_BankA0_WaitPartnerSeed::
    ld a, [wLinkMessage]
    cp $22
    jr z, .set_counter_ptr0_hi
    cp $33
    jr z, .set_counter_ptr0_hi
    ret

.set_counter_ptr0_hi:
    ld [wCounterPtr0Hi], a
    xor a
    ld [wLinkSendByte], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; Turn setup, sub-phase 11: when both sides sent $22 sends 2 and goes on; otherwise exchanges again
; from sub-phase 5. (C2, E-0357; probed E-0385)
RunBattleSetup_BankA0_ConfirmSeeds::
    ld a, [wCounterPtr0Lo]
    cp $22
    jr nz, .set_battle_sub_phase_to_05
    ld a, [wCounterPtr0Hi]
    cp $22
    jr nz, .set_battle_sub_phase_to_05
    jr .skip

.set_battle_sub_phase_to_05:
    ld a, $05
    ld [wBattleSubPhase], a
    ret

.skip:
    ld hl, wBattleSubPhase
    inc [hl]
    ld a, $02
    ld [wLinkSendByte], a
    ret

; Turn setup, sub-phase 12: on the partner's 2 clears the text tiles and goes to the next battle
; step. (C1, E-0357)
RunBattleSetup_BankA0_ClearWindow::
    ld a, [wLinkMessage]
    cp $02
    ret nz
    call FillTilesFromRequest
    ld hl, wBattleStep
    inc [hl]
    xor a
    ld [wBattleSubPhase], a
    ret

; A 2 x 2 cursor (entry byte HL, BG map offsets DE): Up/Down toggle bit 0, Left/Right bit 1 (sound
; $69); otherwise blinks the cursor every 16 frames. (C1, E-0357)
TwoByTwoCursor::
    ld a, [wJoypadPressedRepeat]
    and $c0
    jr z, .check_joypad_pressed_repeat
    call SetBit6AndBlankEntryTile_BankA0
    ld a, [hl]
    xor $01
    ld [hl], a
    call ClearBit6AndCursorEntryTile_BankA0
    ld a, $69
    call QueueSoundEffect
    jr .check_frame_counter_lo2

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and $30
    jr z, .check_frame_counter_lo
    call SetBit6AndBlankEntryTile_BankA0
    ld a, [hl]
    xor $02
    ld [hl], a
    call ClearBit6AndCursorEntryTile_BankA0
    ld a, $69
    call QueueSoundEffect
    jr .check_frame_counter_lo2

.check_frame_counter_lo:
    ld a, [wFrameCounterLo]
    and $0f
    jr nz, .return
    bit 6, [hl]
    jr z, .call_set_bit6_and_blank_entry_tile_bank_a0
    call ClearBit6AndCursorEntryTile_BankA0
    jr .check_frame_counter_lo2

.call_set_bit6_and_blank_entry_tile_bank_a0:
    call SetBit6AndBlankEntryTile_BankA0

.check_frame_counter_lo2:
    ld a, [wFrameCounterLo]
    and $f0
    ld [wFrameCounterLo], a

.return:
    ret

; A three-entry cursor: Up/Down move with wrap (sound $69); otherwise blinks the cursor every 16
; frames. (C1, E-0357)
ThreeEntryCursor_BankA0::
    ld a, [wJoypadPressedRepeat]
    and $40
    jr z, .check_joypad_pressed_repeat
    call SetBit6AndBlankEntryTile_BankA0
    ld a, [hl]
    and $03
    dec a
    cp $ff
    jr nz, .call_clear_bit6_and_cursor_entry_tile_bank_a0
    ld a, $02
    jr .call_clear_bit6_and_cursor_entry_tile_bank_a0

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and $80
    jr z, .check_frame_counter_lo
    call SetBit6AndBlankEntryTile_BankA0
    ld a, [hl]
    and $03
    inc a
    cp $03
    jr nz, .call_clear_bit6_and_cursor_entry_tile_bank_a0
    xor a

.call_clear_bit6_and_cursor_entry_tile_bank_a0:
    ld [hl], a
    call ClearBit6AndCursorEntryTile_BankA0
    ld a, $69
    call QueueSoundEffect
    jr .check_frame_counter_lo2

.check_frame_counter_lo:
    ld a, [wFrameCounterLo]
    and $0f
    jr nz, .return
    bit 6, [hl]
    jr z, .call_set_bit6_and_blank_entry_tile_bank_a0
    call ClearBit6AndCursorEntryTile_BankA0
    jr .check_frame_counter_lo2

.call_set_bit6_and_blank_entry_tile_bank_a0:
    call SetBit6AndBlankEntryTile_BankA0

.check_frame_counter_lo2:
    ld a, [wFrameCounterLo]
    and $f0
    ld [wFrameCounterLo], a

.return:
    ret

; The skill list cursor: Up/Down move within the page (the last page up to wCommandCursorMax, others
; up to wListLastPageSize) with wrap, Left/Right turn the page when there are two; marks a change
; (bit 7) for redrawing. (C1, E-0357)
SkillListCursor_BankA0::
    ld a, [wJoypadPressedRepeat]
    and $40
    jr z, .check_joypad_pressed_repeat
    ld a, [wCommandCursor]
    ld b, a
    ld a, [wCommandPageCount]
    cp b
    jr nz, .call_set_bit6_and_blank_entry_tile_bank_a0
    ld a, [wCommandCursorMax]
    or a
    jp z, .check_frame_counter_lo3
    call SetBit6AndBlankEntryTile_BankA0
    ld a, [hl]
    and $0f
    dec a
    cp $ff
    jr nz, .call_clear_bit6_and_cursor_entry_tile_bank_a0
    ld a, [wCommandCursorMax]
    jr .call_clear_bit6_and_cursor_entry_tile_bank_a0

.call_set_bit6_and_blank_entry_tile_bank_a0:
    call SetBit6AndBlankEntryTile_BankA0
    ld a, [hl]
    and $0f
    dec a
    cp $ff
    jr nz, .call_clear_bit6_and_cursor_entry_tile_bank_a0
    ld a, [wListLastPageSize]

.call_clear_bit6_and_cursor_entry_tile_bank_a0:
    ld [hl], a
    call ClearBit6AndCursorEntryTile_BankA0
    set 7, [hl]
    ld a, $69
    call QueueSoundEffect
    jp .check_frame_counter_lo3

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and $80
    jr z, .check_command_page_count
    ld a, [wCommandCursor]
    ld b, a
    ld a, [wCommandPageCount]
    cp b
    jr nz, .call_set_bit6_and_blank_entry_tile_bank_a02
    ld a, [wCommandCursorMax]
    or a
    jp z, .check_frame_counter_lo3
    ld b, a
    call SetBit6AndBlankEntryTile_BankA0
    inc b
    ld a, [hl]
    and $0f
    inc a
    cp b
    jr nz, .call_clear_bit6_and_cursor_entry_tile_bank_a02
    ld a, $00
    jr .call_clear_bit6_and_cursor_entry_tile_bank_a02

.call_set_bit6_and_blank_entry_tile_bank_a02:
    call SetBit6AndBlankEntryTile_BankA0
    ld a, [wListLastPageSize]
    inc a
    ld b, a
    ld a, [hl]
    and $0f
    inc a
    cp b
    jr nz, .call_clear_bit6_and_cursor_entry_tile_bank_a02
    xor a

.call_clear_bit6_and_cursor_entry_tile_bank_a02:
    ld [hl], a
    call ClearBit6AndCursorEntryTile_BankA0
    set 7, [hl]
    ld a, $69
    call QueueSoundEffect
    jr .check_frame_counter_lo3

.check_command_page_count:
    ld a, [wCommandPageCount]
    or a
    jr z, .check_frame_counter_lo
    ld b, a
    ld a, [wJoypadPressedRepeat]
    and $20
    jr z, .check_joypad_pressed_repeat2
    ld a, [wCommandCursor]
    or a
    jr nz, .set_command_cursor
    ld a, b
    jr .set_command_cursor2

.set_command_cursor:
    dec a

.set_command_cursor2:
    or $80
    ld [wCommandCursor], a
    ld a, $69
    call QueueSoundEffect
    jr .call_set_bit6_and_blank_entry_tile_bank_a04

.check_joypad_pressed_repeat2:
    ld a, [wJoypadPressedRepeat]
    and $10
    jr z, .check_frame_counter_lo
    ld a, [wCommandCursor]
    cp b
    jr nz, .set_command_cursor3
    xor a
    jr .set_command_cursor4

.set_command_cursor3:
    inc a

.set_command_cursor4:
    or $80
    ld [wCommandCursor], a
    ld a, $69
    call QueueSoundEffect
    jr .call_set_bit6_and_blank_entry_tile_bank_a04

.check_frame_counter_lo:
    ld a, [wFrameCounterLo]
    and $0f
    jr nz, .return
    bit 6, [hl]
    jr z, .call_set_bit6_and_blank_entry_tile_bank_a03
    call ClearBit6AndCursorEntryTile_BankA0
    jr .check_frame_counter_lo3

.call_set_bit6_and_blank_entry_tile_bank_a03:
    call SetBit6AndBlankEntryTile_BankA0
    jr .check_frame_counter_lo3

.call_set_bit6_and_blank_entry_tile_bank_a04:
    call SetBit6AndBlankEntryTile_BankA0
    ld a, [wCommandPageCount]
    ld b, a
    ld a, [wCommandCursor]
    res 7, a
    cp b
    jr nz, .check_frame_counter_lo3
    ld a, [wCommandCursorMax]
    or a
    jr nz, .skip
    xor a
    jr .check_frame_counter_lo2

.skip:
    ld b, a

.skip2:
    ld a, [hl]
    and $0f
    cp b
    jr z, .check_frame_counter_lo2
    jr c, .check_frame_counter_lo3
    dec [hl]
    jr .skip2

.check_frame_counter_lo2:
    set 7, a
    ld [hl], a

.check_frame_counter_lo3:
    ld a, [wFrameCounterLo]
    and $f0
    ld [wFrameCounterLo], a

.return:
    ret

; HL = a cursor entry byte, DE = a table of words (BG map offsets): sets bit 6 of [HL] and writes
; the blank tile $C3 at $9800 plus the word at DE + 2 * ([HL] and $3F) with WriteVRAMByte, which
; hides that cursor; HL and DE are kept. Used by TwoByTwoCursor, ThreeEntryCursor_BankA0 and
; SkillListCursor_BankA0 before they move or blink the cursor. (C1, E-0385)
; HL = entry byte, DE = table of BG map offsets: sets bit 6 of [HL] and writes tile $C3 at $9800 +
; table[[HL] & $3F] (WriteVRAMByte); HL kept (E-0074) (the same 31 bytes appear in 2 banks)
SetBit6AndBlankEntryTile_BankA0::
    set 6, [hl]
    ld a, [hl]
    and $3f
    push hl
    add a
    add e
    ld l, a
    ld a, d
    adc $00
    ld h, a
    deref_hl
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $98
    ld h, a
    ld a, $c3
    call WriteVRAMByte
    pop hl
    ret

; HL = a cursor entry byte, DE = a table of words (BG map offsets): clears bit 6 of [HL] and writes
; the cursor tile $BB at $9800 plus the word at DE + 2 * ([HL] and $3F) with WriteVRAMByte; HL and
; DE are kept. The partner of SetBit6AndBlankEntryTile_BankA0 in the cursor routines TwoByTwoCursor,
; ThreeEntryCursor_BankA0 and SkillListCursor_BankA0. (C1, E-0385)
; HL = entry byte, DE = table of BG map offsets: clears bit 6 of [HL] and writes tile $BB at $9800 +
; table[[HL] & $3F] (WriteVRAMByte); HL kept (E-0074) (the same 31 bytes appear in 2 banks)
ClearBit6AndCursorEntryTile_BankA0::
    res 6, [hl]
    ld a, [hl]
    and $3f
    push hl
    add a
    add e
    ld l, a
    ld a, d
    adc $00
    ld h, a
    deref_hl
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $98
    ld h, a
    ld a, $bb
    call WriteVRAMByte
    pop hl
    ret

; HL = a destination in a tile buffer: clears wMenuSubState and writes five consecutive tile
; numbers, starting at $D0 when wCommandMonster is 0 and at $D5 when it is 1
; (WriteFiveTileNumbersForCommandMonster_Data); HL ends 5 bytes on. Called by
; RunBattleSetup_BankA0_CommandMenu_DrawLists (at wScreenTileBuffer + $103) and
; RunBattleSetup_BankA0_CommandMenu_ShowCommands (at wScreenTileBuffer + $142, wCommandMonster
; masked with 3). (C2, E-0385)
; clears wMenuSubState and writes five consecutive tile numbers starting at
; WriteFiveTileNumbersForCommandMonster_Data[wCommandMonster] to HL (E-0122) (E-0344: the address in
; its name dropped or read as the label there; was WriteFiveTileNumbersForCommandMonster)
WriteFiveTileNumbersForCommandMonster::
    push hl
    ld a, [wCommandMonster]
    ld hl, WriteFiveTileNumbersForCommandMonster_Data
    add_a_to_hl
    xor a
    ld [wMenuSubState], a
    ld a, [hl]
    pop hl
    ld b, $05

.loop:
    ld [hli], a
    inc a
    dec b
    jr nz, .loop
    ret

; Two bytes, $D0 and $D5: the first of five consecutive tile numbers for a command monster.
; WriteFiveTileNumbersForCommandMonster indexes it with wCommandMonster (its second caller masks it
; with $03) and writes the five tiles starting at that value ($D0-$D4 for monster 0, $D5-$D9 for
; monster 1) to the buffer at HL. (C1, E-0381)
WriteFiveTileNumbersForCommandMonster_Data::
    db $d0, $d5

; Counts the command monster's skills (up to eight, stopping at $FF or 0) for the skill list: two
; pages from five on, the last page's size, and returns D = the skills outside $A2-$A9. (C2, E-0357;
; probed E-0385)
CountSkillsForList_BankA0::
    ld a, [wCommandMonster]
    ld hl, wBattleSkills
    swap a
    and $f0
    add_a_to_hl
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    ld bc, $0800
    ld d, $00

.loop:
    ld a, [hli]
    cp $ff
    jr z, .skip
    or a
    jr z, .skip
    cp $a2
    jr c, .next
    cp $aa
    jr c, .next2

.next:
    inc d

.next2:
    inc c
    inc hl
    dec b
    jr nz, .loop

.skip:
    ld a, c
    cp $05
    ld a, $00
    jr c, .set_command_page_count
    inc a

.set_command_page_count:
    ld [wCommandPageCount], a
    ld a, c
    or a
    jr z, .set_command_cursor_max
    and $03
    dec a
    and $03

.set_command_cursor_max:
    ld [wCommandCursorMax], a
    xor a
    ld [wCommandCursor], a
    ret

; Shows the names of the four skills on page wCommandCursor of the monster wCommandMonster, in the
; four 9 x 1 tile rows ShowStringAAtTiles16D0_BankA0, ShowStringAAtTiles1760_BankA0,
; ShowStringAAtTiles17F0_BankA0 and ShowStringAAtTiles2080_BankA0, with wStringCategory 4 and the
; skill number as the string index; a skill byte of $FF is shown as string 0
; (ShowSkillPageNames_EmptySlotToString0). The skills are the even bytes of wBattleSkills + 16 *
; wCommandMonster + 8 * the page; the start of that monster block is left in wBattleArg2 and
; wBattleArg3 for RedrawSkillList_BankA0. Called by RunBattleSetup_BankA0_CommandMenu_ShowSkills and
; RedrawSkillList_BankA0. (C1, E-0385)
; shows the four skill names (category 4) of page wCommandCursor of monster wCommandMonster's skills
; (wBattleSkills + 16 * wCommandMonster) in the four tile rows; $FF shows string 0 (E-0121)
ShowSkillPageNames_BankA0::
    ld a, $04
    ld [wStringCategory], a
    ld a, [wCommandMonster]
    ld hl, wBattleSkills
    swap a
    and $f0
    add_a_to_hl
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    ld a, [wCommandCursor]
    add a
    add a
    add a
    add_a_to_hl
    ld a, [hli]
    inc hl
    cp $ff
    call z, ShowSkillPageNames_EmptySlotToString0
    call ShowStringAAtTiles16D0_BankA0
    ld a, [hli]
    inc hl
    cp $ff
    call z, ShowSkillPageNames_EmptySlotToString0
    call ShowStringAAtTiles1760_BankA0
    ld a, [hli]
    inc hl
    cp $ff
    call z, ShowSkillPageNames_EmptySlotToString0
    call ShowStringAAtTiles17F0_BankA0
    ld a, [hl]
    cp $ff
    call z, ShowSkillPageNames_EmptySlotToString0
    call ShowStringAAtTiles2080_BankA0
    ret

; A = 0 and return. Its only calls are the conditional calls (call z) in ShowSkillPageNames_BankA0
; after a skill byte is compared with $FF, so an empty skill slot is shown with string index 0. (C2,
; E-0385)
; A = 0 (xor a); a two-byte handler stub (E-0111) (E-0344: the address in its name dropped or read
; as the label there; was ShowSkillPageNames_EmptySlotToString0)
ShowSkillPageNames_EmptySlotToString0::
    xor a
    ret

; Redraws after a cursor change: a new page shows its skill names; a new entry shows the skill's
; name and its MP cost at row 15. (C1, E-0357)
RedrawSkillList_BankA0::
    ld a, [wCommandCursor]
    bit 7, a
    jr z, .check_menu_cursor
    res 7, a
    ld [wCommandCursor], a
    ld hl, wMenuCursor
    call ClearBit6AndCursorEntryTile_BankA0
    call ShowSkillPageNames_BankA0
    ld hl, wMenuCursor
    set 7, [hl]

.check_menu_cursor:
    ld a, [wMenuCursor]
    bit 7, a
    ret z
    res 7, a
    ld [wMenuCursor], a
    and $0f
    push af
    ld a, $09
    ld [wStringCategory], a
    ld a, [wBattleArg2]
    ld l, a
    ld a, [wBattleArg3]
    ld h, a
    ld a, [wCommandCursor]
    add a
    add a
    ld c, a
    pop af
    add c
    add a
    add_a_to_hl
    ld a, [hl]
    call ShowSkillNameAndCost
    ld de, wWindowTileBuffer + $88
    ld hl, vBGMap0 + $1f0
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    ld a, [de]
    call WriteVRAMByte
    ret

; A = a string index: stores it in wStringIndex and shows that string (the category is in
; wStringCategory) with ShowStringBank08AtTilesHL_BankA0 in a 9 x 1 tile block at vTiles1 + $6D0; HL
; is kept. Called by ShowSkillPageNames_BankA0 for one of the four skill names. (C1, E-0385)
; wStringIndex = A, then ShowStringBank08AtTilesHL_BankA0 at vTiles1 + $6D0 with size $0901; HL kept
; (E-0116)
ShowStringAAtTiles16D0_BankA0::
    ld [wStringIndex], a
    push hl
    ld hl, vTiles1 + $6d0
    ld de, $0901
    call ShowStringBank08AtTilesHL_BankA0
    pop hl
    ret

; A = a string index: stores it in wStringIndex and shows that string (the category is in
; wStringCategory) with ShowStringBank08AtTilesHL_BankA0 in a 9 x 1 tile block at vTiles1 + $760; HL
; is kept. Called by ShowSkillPageNames_BankA0 for one of the four skill names. (C1, E-0385)
; wStringIndex = A, then the string at vTiles1 + $760 with size $0901; HL kept (E-0116)
ShowStringAAtTiles1760_BankA0::
    ld [wStringIndex], a
    push hl
    ld hl, vTiles1 + $760
    ld de, $0901
    call ShowStringBank08AtTilesHL_BankA0
    pop hl
    ret

; A = a string index: stores it in wStringIndex and shows that string (the category is in
; wStringCategory) with ShowStringBank08AtTilesHL_BankA0 in a 9 x 1 tile block at vTiles1 + $7F0; HL
; is kept. Called by ShowSkillPageNames_BankA0 for one of the four skill names. (C1, E-0385)
; wStringIndex = A, then the string at vTiles1 + $7F0 with size $0901; HL kept (E-0116)
ShowStringAAtTiles17F0_BankA0::
    ld [wStringIndex], a
    push hl
    ld hl, vTiles1 + $7f0
    ld de, $0901
    call ShowStringBank08AtTilesHL_BankA0
    pop hl
    ret

; A = a string index: stores it in wStringIndex and shows that string (the category is in
; wStringCategory) with ShowStringBank08AtTilesHL_BankA0 in a 9 x 1 tile block at vTiles2 + $80; HL
; is not kept. Called by ShowSkillPageNames_BankA0 for the fourth skill name. (C1, E-0385)
; wStringIndex = A, then the string at vTiles2 + $80 with size $0901 (E-0116)
ShowStringAAtTiles2080_BankA0::
    ld [wStringIndex], a
    ld hl, vTiles2 + $80
    ld de, $0901
    call ShowStringBank08AtTilesHL_BankA0
    ret

; Shows skill A's name in a 6 x 3 window at VRAM $8800 and its MP cost (record byte 0; $FF shows the
; monster's own MP) as three digits at wWindowTileBuffer + $88. (C1, E-0357)
ShowSkillNameAndCost::
    push af
    ld [wStringIndex], a
    ld hl, vTiles1
    ld de, $0603
    call ShowStringBank08AtTilesHL_BankA0
    pop af
    ld [wRecordBuffer], a
    xor a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    ld a, [wRecordBufferData]
    cp $ff
    jr nz, .skip
    ld a, [wCommandMonster]
    ld hl, wBattleMP
    add a
    add_a_to_hl
    deref_hl
    jr .call_hl_to_decimal_digits

.skip:
    ld l, a
    ld h, $00
    jr .call_hl_to_decimal_digits

.call_hl_to_decimal_digits:
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $88
    call WriteDecimalDigitTiles
    ret

; Draws the page indicator of the battle skill list: returns at once when wCommandPageCount is 0;
; otherwise writes at vBGMap0 + $226 the tile $C5, the digit tile $E0 + (wCommandCursor and 7) + 1,
; the tile $BE, the digit tile $E0 + wCommandPageCount + 1 and the tile $C6 (WriteVRAMByteInc,
; WriteVRAMByte). Called by RunBattleSetup_BankA0_CommandMenu_ShowSkillCursor and
; RunBattleSetup_BankA0_CommandMenu_SkillCursor. (C1, E-0385)
; when wCommandPageCount is non-zero writes tiles $C5, $E0 + (wCommandCursor & 7) + 1, $BE, $E0 +
; wCommandPageCount + 1, $C6 at vBGMap0 + $226 (page X of Y) (E-0121)
DrawInventoryPageIndicator_BankA0::
    ld a, [wCommandPageCount]
    or a
    ret z
    ld hl, vBGMap0 + $226
    ld a, $c5
    call WriteVRAMByteInc
    ld a, [wCommandCursor]
    and $07
    inc a
    add $e0
    call WriteVRAMByteInc
    ld a, $be
    call WriteVRAMByteInc
    ld a, [wCommandPageCount]
    inc a
    add $e0
    call WriteVRAMByteInc
    ld a, $c6
    call WriteVRAMByte
    ret

; Four little-endian words, $01C1, $0201, $01C7 and $0207: offsets from vBGMap0 of a two-by-two
; cursor grid (rows 14 and 16, columns 1 and 7). The entry is picked by the low two bits of
; wMenuState (bit 0 = Up/Down row, bit 1 = Left/Right column):
; RunBattleSetup_BankA0_EntrySelect_ShowCursor draws tile $BB at the chosen place, and
; RunBattleSetup_BankA0_EntrySelect_Cursor passes the table to TwoByTwoCursor, which blanks the
; place with tile $C3 and redraws it with $BB. (C1, E-0381)
RunBattleSetup_BankA0_EntrySelect_ShowCursor_Data::
    db $c1, $01, $01, $02, $c7, $01, $07, $02

; Four little-endian words, $0141, $0181, $01C1 and $0201: offsets from vBGMap0 of rows 10, 12, 14
; and 16 at column 1, the cursor places of a four-row list. The bank-$A0 command menu indexes it by
; wMenuSubState & 3 for the tactic list (RunBattleSetup_BankA0_CommandMenu_ShowTacticCursor draws
; tile $BB there; RunBattleSetup_BankA0_CommandMenu_SetTactic passes it to SkillListCursor_BankA0)
; and by wMenuCursor & 3 for the skill list (RunBattleSetup_BankA0_CommandMenu_ShowSkills,
; RunBattleSetup_BankA0_CommandMenu_ShowSkillCursor and
; RunBattleSetup_BankA0_CommandMenu_SkillCursor). The bytes match BattleMenu_FourRowCursorOffsets in
; bank $31. (C1, E-0373)
RunBattleSetup_BankA0_ListCursorOffsets::
    db $41, $01, $81, $01, $c1, $01, $01, $02

; Thirteen little-endian words, of which only the first three are read: $0181, $01C1 and $0201,
; offsets from vBGMap0 of rows 12, 14 and 16 at column 1, the places of the three commands.
; RunBattleSetup_BankA0_CommandMenu_CursorOnCommand draws tile $BB at entry wMenuSelectedMember & 3
; and RunBattleSetup_BankA0_CommandMenu_StoreCommand passes the table to ThreeEntryCursor_BankA0,
; which keeps the index in 0-2. The ten words after them ($01C1, $0201, $01C1, $0201, $0029, $0069,
; $00A9, $00E9, $012F, $016F) equal the bank-$31 tables RunBattleSetup_ItemMenu_ChooseSide_Data and
; ForgetSkillMenu_Cursor_Data and the first four bytes of RunBattleSetup_MainMenu_YesNoCursor_Data2;
; no reader of them in bank $A0 was found. (C1, E-0373)
RunBattleSetup_BankA0_CommandCursorOffsets::
    db $81, $01, $c1, $01, $01, $02, $c1, $01, $01, $02, $c1, $01, $01, $02, $29, $00
    db $69, $00, $a9, $00, $e9, $00, $2f, $01, $6f, $01

; A = tactic: stores A in the wSlotTactic byte of wCommandMonster and, unless A is 3 (manual
; command), also in its wSlotLastTactic byte; returns with A unchanged (Z set when it was 3). Called
; by RunBattleSetup_BankA0_CommandMenu_SetTactic; the same instructions as
; SetSlotTacticAndSlotLastTacticForCommandMonster in bank $31. (C2, E-0373; probed E-0385)
; A = value: stores A in wSlotTactic[wCommandMonster], and also in wSlotLastTactic[wCommandMonster]
; unless A is 3 (E-0118)
SetCommandMonsterTactic_BankA0::
    push af
    ld a, [wCommandMonster]
    ld hl, wSlotTactic
    add_a_to_hl
    pop af
    ld [hl], a
    cp $03
    ret z
    push af
    ld a, [wCommandMonster]
    ld hl, wSlotLastTactic
    add_a_to_hl
    pop af
    ld [hl], a
    ret

; Takes the skill number at wBattleSkills + 16 * wCommandMonster + 2 * (4 * (wCommandCursor and 1) +
; (wMenuCursor and 3)) into wRecordBuffer, clears wRecordBuffer + 1 and far-calls LoadSkillRecord,
; which copies the 17-byte record of that skill to wRecordBufferData. Called by
; RunBattleSetup_BankA0_CommandMenu_SkillCursor when A is pressed on a skill. (C2, E-0385)
; wRecordBuffer = the skill at wBattleSkills + 16 * wCommandMonster + 2 * (4 * (wCommandCursor & 1)
; + (wMenuCursor & 3)), wRecordBuffer + $1 = 0, then far-calls LoadSkillRecord (E-0120) (the same 48
; bytes appear in 2 banks)
LoadSelectedSkillRecord_BankA0::
    ld a, [wMenuCursor]
    and $03
    ld b, a
    ld a, [wCommandCursor]
    and $01
    add a
    add a
    add b
    add a
    ld hl, wBattleSkills
    add_a_to_hl
    ld a, [wCommandMonster]
    swap a
    add_a_to_hl
    ld a, [hl]
    ld [wRecordBuffer], a
    xor a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    ret

; Counts the present slots (CarryUnlessBattleSlotOutSlotEmpty carry clear) among the three slots
; starting at ((wLinkRole << 1) and 4) xor 4, that is 0 when wLinkRole bit 1 is set and 4 otherwise:
; D = how many, E = the number of the last present one (0 when none). A, BC are clobbered. No call
; to this bank copy was found in the source. (C2, E-0385)
; side base = ((wLinkRole << 1) & 4) ^ 4, the side opposite CountPresentSlotsOfLinkRoleSide_BankA0;
; D = how many of its three slots are present, E = the last present one (0 when none); clobbers A,
; BC (E-0067) (the same 28 bytes appear in 2 banks)
CountPresentFoesOfLinkRoleSide_BankA0::
    ld de, $0000
    ld b, $03
    ld a, [wLinkRole]
    sla a
    and $04
    xor $04
    ld c, a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    inc d
    ld e, c

.next:
    inc c
    dec b
    jr nz, .loop
    ret

; D = how many of the three slots starting at (wLinkRole << 1) and 4 (4 when wLinkRole bit 1 is set,
; otherwise 0) are present (CarryUnlessBattleSlotOutSlotEmpty carry clear). A, BC are clobbered. No
; call to this bank copy was found in the source. (C2, E-0385)
; side base = (wLinkRole << 1) & 4: D = how many of its three slots are present; clobbers A, BC
; (E-0067) (the same 24 bytes appear in 2 banks)
CountPresentSlotsOfLinkRoleSide_BankA0::
    ld d, $00
    ld b, $03
    ld a, [wLinkRole]
    sla a
    and $04
    ld c, a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    inc d

.next:
    inc c
    dec b
    jr nz, .loop
    ret

; Far-calls RunDebugState_E0 (the debug screens of bank $E0) and returns. No call to it was found in
; the source. (C1, E-0385)
; far-calls RunDebugState_E0 (E-0122) (E-0344: the address in its name dropped or read as the label
; there; was CallRunDebugStateInBankE0_BankA0; shortened from CallRunDebugState_E0InBankE0_BankA0)
CallRunDebugStateInBankE0_BankA0::
    farcall RunDebugState_E0
    ret

; Fills $120 two-byte rows at VRAM $8800 with $FF, $00 (blank tiles). (C1, E-0357)
RunBattleSetup_BankA0_ClearTextTiles::
    ld hl, vTiles1
    ld bc, $0120

.loop:
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, $ff
    ld [hli], a
    xor a
    ld [hli], a
    ei
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ret

; Draws the status mark of slot C (0-2) on the battle screen: tile $C2 with the level for an absent
; slot, $C3 with the level when status 0 is clear; otherwise the marker for each set status:
; poisoned, badly poisoned, confused, cursed, paralyzed, asleep (bits 0, 1, 4, 5, 6, 7). (C2,
; E-0357; probed E-0385)
DrawSlotStatusMarks_BankA0::
    push bc
    ld a, c
    cp $03
    jr nc, .done
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .call_draw_slot_level_bank_a02
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    or a
    jr z, .call_draw_slot_level_bank_a0
    call DrawSlotStatusMarks_BankA0_BlankMarks
    bit 0, [hl]
    call nz, DrawSlotStatusMarks_BankA0_PoisonMark
    bit 1, [hl]
    call nz, DrawSlotStatusMarks_BankA0_BadPoisonMark
    bit 4, [hl]
    call nz, DrawSlotStatusMarks_BankA0_ConfusionMark
    bit 5, [hl]
    call nz, DrawSlotStatusMarks_BankA0_CurseMark
    bit 6, [hl]
    call nz, DrawSlotStatusMarks_BankA0_ParalysisMark
    bit 7, [hl]
    call nz, DrawSlotStatusMarks_BankA0_SleepMark
    jr .done

.call_draw_slot_level_bank_a0:
    call DrawSlotLevel_BankA0
    ld a, c
    and $03
    ld hl, DrawSlotStatusMarks_BankA0_Data
    add a
    add_a_to_hl
    call DerefHL_BankA0
    ld [hl], $c3
    jr .done

.call_draw_slot_level_bank_a02:
    call DrawSlotLevel_BankA0
    ld a, c
    and $03
    ld hl, DrawSlotStatusMarks_BankA0_Data
    add a
    add_a_to_hl
    call DerefHL_BankA0
    ld [hl], $c2

.done:
    pop bc
    ret

; Blanks slot C's five status mark places (tile $C3). (C2, E-0357; probed E-0385)
DrawSlotStatusMarks_BankA0_BlankMarks::
    push hl
    ld hl, DrawSlotStatusMarks_BankA0_BlankMarks_Data
    call ReadWordTableEntryForSlotC_BankA0
    ld a, $c3
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hl], a
    pop hl
    ret

; Draws the curse mark ($C0, status bit 5) for slot C. (C2, E-0357; probed E-0385)
DrawSlotStatusMarks_BankA0_CurseMark::
    push hl
    ld hl, DrawSlotStatusMarks_BankA0_BlankMarks_Data
    call ReadWordTableEntryForSlotC_BankA0
    ld [hl], $c0
    pop hl
    ret

; Draws the poison mark ($C1, status bit 0) for slot C. (C2, E-0357; probed E-0385)
DrawSlotStatusMarks_BankA0_PoisonMark::
    push hl
    ld hl, DrawSlotStatusMarks_BankA0_PoisonMark_Data
    call ReadWordTableEntryForSlotC_BankA0
    ld [hl], $c1
    pop hl
    ret

; Draws the bad poison mark ($C7, status bit 1) for slot C at the poison place. (C2, E-0357; probed
; E-0385)
DrawSlotStatusMarks_BankA0_BadPoisonMark::
    push hl
    ld hl, DrawSlotStatusMarks_BankA0_PoisonMark_Data
    call ReadWordTableEntryForSlotC_BankA0
    ld [hl], $c7
    pop hl
    ret

; Draws the sleep mark ($C8, status bit 7) for slot C. (C2, E-0357; probed E-0385)
DrawSlotStatusMarks_BankA0_SleepMark::
    push hl
    ld hl, DrawSlotStatusMarks_BankA0_SleepMark_Data
    call ReadWordTableEntryForSlotC_BankA0
    ld [hl], $c8
    pop hl
    ret

; Draws the confusion mark ($C9, status bit 4) for slot C. (C2, E-0357; probed E-0385)
DrawSlotStatusMarks_BankA0_ConfusionMark::
    push hl
    ld hl, DrawSlotStatusMarks_BankA0_ConfusionMark_Data
    call ReadWordTableEntryForSlotC_BankA0
    ld [hl], $c9
    pop hl
    ret

; Draws the paralysis mark ($CA, status bit 6) for slot C. (C2, E-0357; probed E-0385)
DrawSlotStatusMarks_BankA0_ParalysisMark::
    push hl
    ld hl, DrawSlotStatusMarks_BankA0_Data
    call ReadWordTableEntryForSlotC_BankA0
    ld [hl], $ca
    pop hl
    ret

; HL = a table of words, C = a slot: HL = the word at HL + 2 * (C and 3) (the carry out of the low
; byte goes into H), by falling into DerefHL_BankA0. A is clobbered. Called by the
; DrawSlotStatusMarks_BankA0 mark routines to find the screen buffer place of a status mark for slot
; C. (C2, E-0385)
; the same 13 bytes as ReadWordTableEntryForSlotC (ReadWordTableEntryForSlotC) (E-0110)
ReadWordTableEntryForSlotC_BankA0::
    ld a, c
    and $03
    add a
    add l
    ld l, a
    jr nc, DerefHL_BankA0
    inc h

; HL = the word HL points to (low byte first). A is clobbered. Used by DrawSlotStatusMarks_BankA0
; and by ReadWordTableEntryForSlotC_BankA0, which falls into it. (C2, E-0385)
; the same 4 bytes as DerefHL_Bank31 (DerefHL_Bank31) (E-0110)
DerefHL_BankA0::
    deref_hl
    ret

; Two little-endian words, $C239 and $C246: absolute addresses in wScreenTileBuffer (offsets $A1 and
; $AE, so row 5 column 1 and row 5 column 14 of its 32-wide rows) of the first of five status mark
; tiles for slot 0 and slot 1. DrawSlotStatusMarks_BankA0_BlankMarks fills the five tiles with $C3,
; and DrawSlotStatusMarks_BankA0_CurseMark writes the curse tile $C0 at the first one; the other
; mark tables are this one moved right by 1 to 4 tiles. The word is picked by slot C & 3 through
; ReadWordTableEntryForSlotC_BankA0. (C1, E-0381)
DrawSlotStatusMarks_BankA0_BlankMarks_Data::
    db $39, $c2, $46, $c2

; Two little-endian words, $C23A and $C247: the screen buffer places (wScreenTileBuffer offsets $A2
; and $AF, row 5 columns 2 and 15) where DrawSlotStatusMarks_BankA0_ConfusionMark writes the
; confusion tile $C9 for slot 0 and slot 1. The word is picked by slot C & 3 through
; ReadWordTableEntryForSlotC_BankA0. (C1, E-0381)
DrawSlotStatusMarks_BankA0_ConfusionMark_Data::
    db $3a, $c2, $47, $c2

; Two little-endian words, $C23B and $C248: the screen buffer places (wScreenTileBuffer offsets $A3
; and $B0, row 5 columns 3 and 16) of the poison mark for slot 0 and slot 1.
; DrawSlotStatusMarks_BankA0_PoisonMark writes tile $C1 there and
; DrawSlotStatusMarks_BankA0_BadPoisonMark writes $C7 at the same place; the word is picked by slot
; C & 3. (C1, E-0381)
DrawSlotStatusMarks_BankA0_PoisonMark_Data::
    db $3b, $c2, $48, $c2

; Two little-endian words, $C23C and $C249: the screen buffer places (wScreenTileBuffer offsets $A4
; and $B1, row 5 columns 4 and 17) of the sleep mark for slot 0 and slot 1.
; DrawSlotStatusMarks_BankA0_SleepMark writes tile $C8 there; the word is picked by slot C & 3. (C1,
; E-0381)
DrawSlotStatusMarks_BankA0_SleepMark_Data::
    db $3c, $c2, $49, $c2

; Two little-endian words, $C23D and $C24A: the last mark place of the status strip for slot 0 and
; slot 1 (wScreenTileBuffer offsets $A5 and $B2, row 5 columns 5 and 18).
; DrawSlotStatusMarks_BankA0_ParalysisMark writes the paralysis tile $CA there, and
; DrawSlotStatusMarks_BankA0 itself writes $C3 or $C2 there for a slot with no status or no monster;
; the word is picked by slot C & 3. (C1, E-0381)
DrawSlotStatusMarks_BankA0_Data::
    db $3d, $c2, $4a, $c2

; C = slot: returns at once when C is 3 or more; otherwise copies the five tiles at
; wScreenTileBuffer + CopySlotPanelRowToVRAM_BankA0_Data[C] (the row with the level and the status
; marks of the slot) to vBGMap0 plus the same offset with WriteVRAMByteInc. Called by
; BuildAndCopySlotPanel_A0 and, from bank $31, by CopySlotPanelRowToVRAM. (C1, E-0385)
; C = slot 0-2: copies the 5-tile panel row at CopySlotPanelRowToVRAM_BankA0_Data's offset from
; wScreenTileBuffer to vBGMap0 (the wLinkMode = 2 form of CopySlotPanelRowToVRAM) (E-0111)
CopySlotPanelRowToVRAM_BankA0::
    ld a, c
    cp $03
    jr nc, .return
    ld hl, CopySlotPanelRowToVRAM_BankA0_Data
    add a
    add_a_to_hl
    deref_hl
    push hl
    ld de, wScreenTileBuffer
    add hl, de
    pop de
    push hl
    ld hl, vBGMap0
    add hl, de
    pop de
    ld b, $05

.loop:
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, .loop

.return:
    ret

; C = slot: for slots 0-2 turns wBattleHP[C] into three decimal digits (HLToDecimalDigits) and
; writes them as tiles ($E0 + digit, leading zeros the blank tile $C3) at wScreenTileBuffer +
; DrawSlotHPDigits_BankA0_Data[C] (WriteDecimalDigitTiles); does nothing for C of 3 or more; BC is
; kept. Called by DrawSlotPanelValues_BankA0 and, from bank $31, by DrawSlotHPDigits. (C2, E-0385)
; C = slot 0-2: writes the slot's HP as decimal digit tiles into wScreenTileBuffer at the position
; from DrawSlotHPDigits_BankA0_Data (the wLinkMode = 2 form of DrawSlotHPDigits) (E-0111)
DrawSlotHPDigits_BankA0::
    push bc
    ld a, c
    cp $03
    jr nc, .done
    ld hl, wBattleHP
    add a
    add_a_to_hl
    deref_hl
    push bc
    call HLToDecimalDigits
    pop bc
    ld a, c
    and $03
    push hl
    ld hl, DrawSlotHPDigits_BankA0_Data
    add a
    add_a_to_hl
    deref_hl
    ld de, wScreenTileBuffer
    add hl, de
    ld d, h
    ld e, l
    pop hl
    call WriteDecimalDigitTiles

.done:
    pop bc
    ret

; C = slot: for slots 0-2 turns wBattleMP[C] into three decimal digits and writes them as tiles ($E0
; + digit, leading zeros the blank tile $C3) at wScreenTileBuffer + DrawSlotMPDigits_BankA0_Data[C];
; does nothing for C of 3 or more; BC is kept. Called by DrawSlotPanelValues_BankA0 and, from bank
; $31, by DrawSlotMPDigits. (C2, E-0385)
; C = slot 0-2: writes the slot's MP as decimal digit tiles into wScreenTileBuffer at the position
; from DrawSlotMPDigits_BankA0_Data (the wLinkMode = 2 form of DrawSlotMPDigits) (E-0111)
DrawSlotMPDigits_BankA0::
    push bc
    ld a, c
    cp $04
    jr nc, .done
    and $03
    cp $03
    jr z, .done
    ld a, c
    ld hl, wBattleMP
    add a
    add_a_to_hl
    deref_hl
    push bc
    call HLToDecimalDigits
    pop bc
    ld a, c
    and $03
    push hl
    ld hl, DrawSlotMPDigits_BankA0_Data
    add a
    add_a_to_hl
    deref_hl
    ld de, wScreenTileBuffer
    add hl, de
    ld d, h
    ld e, l
    pop hl
    call WriteDecimalDigitTiles

.done:
    pop bc
    ret

; Draws 'Lv' (tiles $EA, $AF) and the two-digit level of slot C (0-2) into wScreenTileBuffer at the
; slot's place (DrawSlotLevel_BankA0_Data). (C2, E-0357; probed E-0385)
DrawSlotLevel_BankA0::
    push bc
    ld a, c
    cp $04
    jr nc, .done
    and $03
    cp $03
    jr z, .done
    ld a, c
    and $03
    ld hl, DrawSlotLevel_BankA0_Data
    add a
    add_a_to_hl
    deref_hl
    ld de, wScreenTileBuffer
    add hl, de
    ld [hl], $ea
    inc hl
    ld [hl], $af
    inc hl
    push hl
    ld a, c
    ld hl, wBattleLevel
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    push bc
    call HLToDecimalDigits
    pop bc
    pop de
    call WriteTwoDigitTilesFromDigits1

.done:
    pop bc
    ret

; C = slot: for slots 0-2 (nothing for 3 or more) copies the three tiles at wScreenTileBuffer +
; DrawSlotHPDigits_BankA0_Data[C] (the HP digits) to vBGMap0 plus the same offset with
; WriteVRAMByteInc. Called by BuildAndCopySlotPanel_A0 and, from bank $31, by
; CopySlotHPDigitsPanelToVRAM. (C1, E-0385)
; for slots 0-2: copies three tiles at offset DrawSlotHPDigits_BankA0_Data[slot] from the screen
; buffer to vBGMap0 (E-0124) (E-0344: the address in its name dropped or read as the label there;
; was CopySlotHPDigitsPanelToVRAM_BankA0; shortened from
; CopySlotPanelPartDrawSlotHPDigits_BankA0_DataToVRAM)
CopySlotHPDigitsPanelToVRAM_BankA0::
    ld a, c
    cp $04
    jr nc, .return
    and $03
    cp $03
    jr z, .return
    ld hl, DrawSlotHPDigits_BankA0_Data
    add a
    add_a_to_hl
    deref_hl
    push hl
    ld de, wScreenTileBuffer
    add hl, de
    pop de
    push hl
    ld hl, vBGMap0
    add hl, de
    pop de
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    call WriteVRAMByte

.return:
    ret

; C = slot: for slots 0-2 (nothing for 3 or more) copies the three tiles at wScreenTileBuffer +
; DrawSlotMPDigits_BankA0_Data[C] (the MP digits) to vBGMap0 plus the same offset. Called by
; BuildAndCopySlotPanel_A0 and, from bank $31, by CopySlotMPDigitsPanelToVRAM. (C1, E-0385)
; for slots 0-2: copies three tiles at offset DrawSlotMPDigits_BankA0_Data[slot] from the screen
; buffer to vBGMap0 (E-0124) (E-0344: the address in its name dropped or read as the label there;
; was CopySlotMPDigitsPanelToVRAM_BankA0; shortened from
; CopySlotPanelPartDrawSlotMPDigits_BankA0_DataToVRAM)
CopySlotMPDigitsPanelToVRAM_BankA0::
    ld a, c
    cp $04
    jr nc, .return
    and $03
    cp $03
    jr z, .return
    ld hl, DrawSlotMPDigits_BankA0_Data
    add a
    add_a_to_hl
    deref_hl
    push hl
    ld de, wScreenTileBuffer
    add hl, de
    pop de
    push hl
    ld hl, vBGMap0
    add hl, de
    pop de
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    call WriteVRAMByte

.return:
    ret

; C = slot: for slots 0-2 (nothing for 3 or more) copies the two tiles at wScreenTileBuffer +
; DrawSlotLevel_BankA0_Data[C] (the first two tiles of the level display, 'Lv' as drawn by
; DrawSlotLevel_BankA0) to vBGMap0 plus the same offset. Called only from bank $31, by
; CopySlotLevelPanelToVRAM. (C1, E-0385)
; for slots 0-2: copies two tiles at offset DrawSlotLevel_BankA0_Data[slot] from the screen buffer
; to vBGMap0 (E-0124) (E-0344: the address in its name dropped or read as the label there; was
; CopySlotLevelPanelToVRAM_BankA0; shortened from CopySlotPanelPartDrawSlotLevel_BankA0_DataToVRAM)
CopySlotLevelPanelToVRAM_BankA0::
    ld a, c
    cp $04
    jr nc, .return
    and $03
    cp $03
    jr z, .return
    ld hl, DrawSlotLevel_BankA0_Data
    add a
    add_a_to_hl
    deref_hl
    push hl
    ld de, wScreenTileBuffer
    add hl, de
    pop de
    push hl
    ld hl, vBGMap0
    add hl, de
    pop de
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    call WriteVRAMByte

.return:
    ret

; HL = the tile address, DE = the size (D width, E rows): saves the text window fields
; wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows and wTextWindowWidth, sets them from HL and
; DE, far-calls ShowString_Bank09 (the string is chosen by wStringCategory and wStringIndex, set by
; the caller) and restores the window fields. Called by the battle menu steps of
; RunBattleSetup_BankA0_EntrySelect and RunBattleSetup_BankA0_CommandMenu. (C1, E-0385)
; saves the string window wTextWindowTileLo-wTextWindowWidth, sets the tile destination to HL and
; the size to DE, far-calls ShowString_Bank09, then restores the window (E-0067) (the same 59 bytes
; appear in 3 banks)
ShowStringBank09AtTilesHL_BankA0::
    ld a, [wTextWindowTileLo]
    ld c, a
    ld a, [wTextWindowTileHi]
    ld b, a
    push bc
    ld a, [wTextWindowRows]
    ld c, a
    ld a, [wTextWindowWidth]
    ld b, a
    push bc
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    farcall ShowString_Bank09
    pop de
    pop hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    ret

; The same as ShowStringBank09AtTilesHL_BankA0 but far-calls ShowString_Bank08: HL = the tile
; address, DE = the size; the window fields are saved and restored. Called by
; ShowStringAAtTiles16D0_BankA0 and its three siblings and by ShowSkillNameAndCost. (C1, E-0385)
; saves the string window wTextWindowTileLo-wTextWindowWidth, sets the tile destination to HL and
; the size to DE, far-calls ShowString_Bank08, then restores the window (E-0067) (the same 59 bytes
; appear in 2 banks)
ShowStringBank08AtTilesHL_BankA0::
    ld a, [wTextWindowTileLo]
    ld c, a
    ld a, [wTextWindowTileHi]
    ld b, a
    push bc
    ld a, [wTextWindowRows]
    ld c, a
    ld a, [wTextWindowWidth]
    ld b, a
    push bc
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    farcall ShowString_Bank08
    pop de
    pop hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    ret

; HL = a tile address, DE = the source of five glyphs: copies them to wTextBuf0
; (CopyFiveGlyphsPlusMarks), then shows string 0 of category 2 in a 5 x 1 window at HL with
; ShowString_Bank08, saving and restoring the text window fields. No call to it was found in the
; source. (C1, E-0385)
; copies five glyphs plus marks to wTextBuf0 (CopyFiveGlyphsPlusMarks), then shows string category
; 2, index 0 in a 5 x 1 window at tile HL with ShowString_Bank08, saving and restoring the text
; window fields; no caller found (E-0238)
UnreferencedShowFiveGlyphsAtTilesHL_BankA0:: ; configured code entry (E-0238); C0
    push hl
    ld hl, wTextBuf0
    call CopyFiveGlyphsPlusMarks
    pop hl
    ld a, [wTextWindowTileLo]
    ld c, a
    ld a, [wTextWindowTileHi]
    ld b, a
    push bc
    ld a, [wTextWindowRows]
    ld c, a
    ld a, [wTextWindowWidth]
    ld b, a
    push bc
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld de, $0501
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    ld a, $02
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    farcall ShowString_Bank08
    pop de
    pop hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    ret

; Two little-endian words, $0062 and $006F: offsets into wScreenTileBuffer (row 3, columns 2 and 15
; of its 32-wide rows) where DrawSlotHPDigits_BankA0 writes the HP digit tiles of slot 0 and slot 1.
; CopySlotHPDigitsPanelToVRAM_BankA0 uses the same offsets to copy three tiles from the buffer to
; vBGMap0. (C1, E-0381)
DrawSlotHPDigits_BankA0_Data::
    db $62, $00, $6f, $00

; Two little-endian words, $0082 and $008F: offsets into wScreenTileBuffer (row 4, columns 2 and 15)
; where DrawSlotMPDigits_BankA0 writes the MP digit tiles of slot 0 and slot 1;
; CopySlotMPDigitsPanelToVRAM_BankA0 copies three tiles from the same offsets to vBGMap0. The entry
; is picked by slot C & 3. (C1, E-0381)
DrawSlotMPDigits_BankA0_Data::
    db $82, $00, $8f, $00

; Two little-endian words, $00A1 and $00AE: offsets into wScreenTileBuffer (row 5, columns 1 and 14)
; of the level display for slot 0 and slot 1. DrawSlotLevel_BankA0 writes the tiles $EA, $AF and the
; two level digits there, and CopySlotLevelPanelToVRAM_BankA0 copies two tiles from the same place
; to vBGMap0. (C1, E-0381)
DrawSlotLevel_BankA0_Data::
    db $a1, $00, $ae, $00

; Two little-endian words, $00A1 and $00AE (the same bytes as DrawSlotLevel_BankA0_Data): offsets of
; row 5, column 1 and column 14. CopySlotPanelRowToVRAM_BankA0 copies five tiles from
; wScreenTileBuffer plus the offset to vBGMap0 plus the offset, for slot C = 0 or 1 (it returns when
; C >= 3). (C1, E-0381)
CopySlotPanelRowToVRAM_BankA0_Data::
    db $a1, $00, $ae, $00

; PickEncounterMonsterForSlotC reads the word at $6D57 + 16 * PickRandomBand0To10 + 2 * wWildBand
; and picks one of the count words after the count byte with AdvanceRandom; 11 rows (families,
; StringTable_MonsterFamilies order) of 8 bands (E-0256, C1)
; record: species list (count, then words)
EncounterBandSpeciesTable::
    dw EncounterBandSpecies_Slime_0 ; id 0
    dw EncounterBandSpecies_Slime_1 ; id 1
    dw EncounterBandSpecies_Slime_2 ; id 2
    dw EncounterBandSpecies_Slime_3 ; id 3
    dw EncounterBandSpecies_Slime_4 ; id 4
    dw EncounterBandSpecies_Slime_5 ; id 5
    dw EncounterBandSpecies_Slime_6 ; id 6
    dw EncounterBandSpecies_Slime_7 ; id 7
    dw EncounterBandSpecies_Dragon_0 ; id 8
    dw EncounterBandSpecies_Dragon_1 ; id 9
    dw EncounterBandSpecies_Dragon_2 ; id 10
    dw EncounterBandSpecies_Dragon_3 ; id 11
    dw EncounterBandSpecies_Dragon_4 ; id 12
    dw EncounterBandSpecies_Dragon_5 ; id 13
    dw EncounterBandSpecies_Dragon_6 ; id 14
    dw EncounterBandSpecies_Dragon_7 ; id 15
    dw EncounterBandSpecies_Beast_0 ; id 16
    dw EncounterBandSpecies_Beast_1 ; id 17
    dw EncounterBandSpecies_Beast_2 ; id 18
    dw EncounterBandSpecies_Beast_3 ; id 19
    dw EncounterBandSpecies_Beast_4 ; id 20
    dw EncounterBandSpecies_Beast_5 ; id 21
    dw EncounterBandSpecies_Beast_6 ; id 22
    dw EncounterBandSpecies_Beast_7 ; id 23
    dw EncounterBandSpecies_Bird_0 ; id 24
    dw EncounterBandSpecies_Bird_1 ; id 25
    dw EncounterBandSpecies_Bird_2 ; id 26
    dw EncounterBandSpecies_Bird_3 ; id 27
    dw EncounterBandSpecies_Bird_4 ; id 28
    dw EncounterBandSpecies_Bird_5 ; id 29
    dw EncounterBandSpecies_Bird_6 ; id 30
    dw EncounterBandSpecies_Bird_7 ; id 31
    dw EncounterBandSpecies_Plant_0 ; id 32
    dw EncounterBandSpecies_Plant_1 ; id 33
    dw EncounterBandSpecies_Plant_2 ; id 34
    dw EncounterBandSpecies_Plant_3 ; id 35
    dw EncounterBandSpecies_Plant_4 ; id 36
    dw EncounterBandSpecies_Plant_5 ; id 37
    dw EncounterBandSpecies_Plant_6 ; id 38
    dw EncounterBandSpecies_Plant_7 ; id 39
    dw EncounterBandSpecies_Bug_0 ; id 40
    dw EncounterBandSpecies_Bug_1 ; id 41
    dw EncounterBandSpecies_Bug_2 ; id 42
    dw EncounterBandSpecies_Bug_3 ; id 43
    dw EncounterBandSpecies_Bug_4 ; id 44
    dw EncounterBandSpecies_Bug_5 ; id 45
    dw EncounterBandSpecies_Bug_6 ; id 46
    dw EncounterBandSpecies_Bug_7 ; id 47
    dw EncounterBandSpecies_Demon_0 ; id 48
    dw EncounterBandSpecies_Demon_1 ; id 49
    dw EncounterBandSpecies_Demon_2 ; id 50
    dw EncounterBandSpecies_Demon_3 ; id 51
    dw EncounterBandSpecies_Demon_4 ; id 52
    dw EncounterBandSpecies_Demon_5 ; id 53
    dw EncounterBandSpecies_Demon_6 ; id 54
    dw EncounterBandSpecies_Demon_7 ; id 55
    dw EncounterBandSpecies_Zombie_0 ; id 56
    dw EncounterBandSpecies_Zombie_1 ; id 57
    dw EncounterBandSpecies_Zombie_2 ; id 58
    dw EncounterBandSpecies_Zombie_3 ; id 59
    dw EncounterBandSpecies_Zombie_4 ; id 60
    dw EncounterBandSpecies_Zombie_5 ; id 61
    dw EncounterBandSpecies_Zombie_6 ; id 62
    dw EncounterBandSpecies_Zombie_7 ; id 63
    dw EncounterBandSpecies_Material_0 ; id 64
    dw EncounterBandSpecies_Material_1 ; id 65
    dw EncounterBandSpecies_Material_2 ; id 66
    dw EncounterBandSpecies_Material_3 ; id 67
    dw EncounterBandSpecies_Material_4 ; id 68
    dw EncounterBandSpecies_Material_5 ; id 69
    dw EncounterBandSpecies_Material_6 ; id 70
    dw EncounterBandSpecies_Material_7 ; id 71
    dw EncounterBandSpecies_Water_0 ; id 72
    dw EncounterBandSpecies_Water_1 ; id 73
    dw EncounterBandSpecies_Water_2 ; id 74
    dw EncounterBandSpecies_Water_3 ; id 75
    dw EncounterBandSpecies_Water_4 ; id 76
    dw EncounterBandSpecies_Water_5 ; id 77
    dw EncounterBandSpecies_Water_6 ; id 78
    dw EncounterBandSpecies_Water_7 ; id 79
    dw EncounterBandSpecies_Boss_0 ; id 80
    dw EncounterBandSpecies_Boss_1 ; id 81
    dw EncounterBandSpecies_Boss_2 ; id 82
    dw EncounterBandSpecies_Boss_3 ; id 83
    dw EncounterBandSpecies_Boss_4 ; id 84
    dw EncounterBandSpecies_Boss_5 ; id 85
    dw EncounterBandSpecies_Boss_6 ; id 86
    dw EncounterBandSpecies_Boss_7 ; id 87

; row 0 (Slime), band 0 of EncounterBandSpeciesTable (E-0256, C1)
; record: count; species
EncounterBandSpecies_Slime_0::
    db $03 ; entry 0
    dw MONSTER_SPOTSLIME
    dw MONSTER_SNAILY
    dw MONSTER_SLABBIT

; row 0 (Slime), band 1 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Slime_1::
    db $04 ; entry 0
    dw MONSTER_TREESLIME
    dw MONSTER_BABBLE
    dw MONSTER_SLIME
    dw MONSTER_TROPICGEL

; row 0 (Slime), band 2 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Slime_2::
    db $04 ; entry 0
    dw MONSTER_SPOTSLIME
    dw MONSTER_BOXSLIME
    dw MONSTER_PEARLGEL
    dw MONSTER_HEALER

; row 0 (Slime), band 3 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Slime_3::
    db $05 ; entry 0
    dw MONSTER_DRAKSLIME
    dw MONSTER_SLIMENITE
    dw MONSTER_FANGSLIME
    dw MONSTER_ROCKSLIME
    dw MONSTER_SLIMEBORG

; row 0 (Slime), band 4 of EncounterBandSpeciesTable (E-0256, C1)
; record: count; species
EncounterBandSpecies_Slime_4::
    db $04 ; entry 0
    dw MONSTER_METALY
    dw MONSTER_SPOTKING
    dw MONSTER_MIMESLIME
    dw MONSTER_HALOSLIME

; row 0 (Slime), band 5 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Slime_5::
    db $03 ; entry 0
    dw MONSTER_KINGSLIME
    dw MONSTER_METABBLE
    dw MONSTER_METALKING

; row 0 (Slime), band 6 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Slime_6::
    db $01 ; entry 0
    dw MONSTER_GOLDSLIME

; row 0 (Slime), band 7 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Slime_7::
    db $02 ; entry 0
    dw MONSTER_GRANSLIME
    dw MONSTER_WONDEREGG

; row 1 (Dragon), band 0 of EncounterBandSpeciesTable (E-0256, C1)
; record: count; species
EncounterBandSpecies_Dragon_0::
    db $03 ; entry 0
    dw MONSTER_FAIRYDRAK
    dw MONSTER_CHAMELGON
    dw MONSTER_LIZARDFLY

; row 1 (Dragon), band 1 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Dragon_1::
    db $05 ; entry 0
    dw MONSTER_POISONGON
    dw MONSTER_MINIDRAK
    dw MONSTER_KINGCOBRA
    dw MONSTER_SNAKEBAT
    dw MONSTER_CRESTPENT

; row 1 (Dragon), band 2 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Dragon_2::
    db $05 ; entry 0
    dw MONSTER_DRAGONKID
    dw MONSTER_TORTRAGON
    dw MONSTER_PTERANOD
    dw MONSTER_GASGON
    dw MONSTER_WINGSNAKE

; row 1 (Dragon), band 3 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Dragon_3::
    db $04 ; entry 0
    dw MONSTER_SWORDGON
    dw MONSTER_DRYGON
    dw MONSTER_RAYBURN
    dw MONSTER_VAMPIRUS

; row 1 (Dragon), band 4 of EncounterBandSpeciesTable (E-0256, C1)
; record: count; species
EncounterBandSpecies_Dragon_4::
    db $06 ; entry 0
    dw MONSTER_LIZARDMAN
    dw MONSTER_DRAGON
    dw MONSTER_MADDRAGON
    dw MONSTER_ANDREAL
    dw MONSTER_SPIKEROUS
    dw MONSTER_COATOL

; row 1 (Dragon), band 5 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Dragon_5::
    db $04 ; entry 0
    dw MONSTER_GREATDRAK
    dw MONSTER_BATTLEREX
    dw MONSTER_SKYDRAGON
    dw MONSTER_SERPENTIA

; row 1 (Dragon), band 6 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Dragon_6::
    db $03 ; entry 0
    dw MONSTER_OROCHI
    dw MONSTER_DIVINEGON
    dw MONSTER_GIGADRACO

; row 1 (Dragon), band 7 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Dragon_7::
    db $01 ; entry 0
    dw MONSTER_ORLIGON

; row 2 (Beast), band 0 of EncounterBandSpeciesTable (E-0256, C1)
; record: count; species
EncounterBandSpecies_Beast_0::
    db $06 ; entry 0
    dw MONSTER_ALMIRAJ
    dw MONSTER_CATFLY
    dw MONSTER_PILLOWRAT
    dw MONSTER_SACCER
    dw MONSTER_ANTBEAR
    dw MONSTER_FAIRYRAT

; row 2 (Beast), band 1 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Beast_1::
    db $06 ; entry 0
    dw MONSTER_SKULLROO
    dw MONSTER_WINDBEAST
    dw MONSTER_MOMMONJA
    dw MONSTER_HAMMERMAN
    dw MONSTER_ARROWDOG
    dw MONSTER_MADGOPHER

; row 2 (Beast), band 2 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Beast_2::
    db $06 ; entry 0
    dw MONSTER_TONGUELLA
    dw MONSTER_BEAVERN
    dw MONSTER_SUPERTEN
    dw MONSTER_IRONTURT
    dw MONSTER_NOCTOKING
    dw MONSTER_BEASTNITE

; row 2 (Beast), band 3 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Beast_3::
    db $06 ; entry 0
    dw MONSTER_GRIZZLY
    dw MONSTER_YETI
    dw MONSTER_GOATEGON
    dw MONSTER_WILDAPE
    dw MONSTER_CATMAGE
    dw MONSTER_DUMBIRA

; row 2 (Beast), band 4 of EncounterBandSpeciesTable (E-0256, C1)
; record: count; species
EncounterBandSpecies_Beast_4::
    db $04 ; entry 0
    dw MONSTER_GULPBEAST
    dw MONSTER_TRUMPETER
    dw MONSTER_MADCAT
    dw MONSTER_BIGEYE

; row 2 (Beast), band 5 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Beast_5::
    db $02 ; entry 0
    dw MONSTER_UNICORN
    dw MONSTER_DARKHORN

; row 2 (Beast), band 6 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Beast_6::
    db $01 ; entry 0
    dw MONSTER_KINGLEO

; row 2 (Beast), band 7 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Beast_7::
    db $01 ; entry 0
    dw MONSTER_GORAGO

; row 3 (Bird), band 0 of EncounterBandSpeciesTable (E-0256, C1)
; record: count; species
EncounterBandSpecies_Bird_0::
    db $02 ; entry 0
    dw MONSTER_PICKY
    dw MONSTER_DRACKY

; row 3 (Bird), band 1 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Bird_1::
    db $04 ; entry 0
    dw MONSTER_FLORAJAY
    dw MONSTER_MADRAVEN
    dw MONSTER_KITEHAWK
    dw MONSTER_BIGROOST

; row 3 (Bird), band 2 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Bird_2::
    db $06 ; entry 0
    dw MONSTER_BULLBIRD
    dw MONSTER_MISTYWING
    dw MONSTER_AQUAHAWK
    dw MONSTER_STUBBIRD
    dw MONSTER_LANDOWL
    dw MONSTER_CRAGDEVIL

; row 3 (Bird), band 3 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Bird_3::
    db $06 ; entry 0
    dw MONSTER_WYVERN
    dw MONSTER_DUCKKITE
    dw MONSTER_MADPECKER
    dw MONSTER_MADGOOSE
    dw MONSTER_MADCONDOR
    dw MONSTER_EMYU

; row 3 (Bird), band 4 of EncounterBandSpeciesTable (E-0256, C1)
; record: count; species
EncounterBandSpecies_Bird_4::
    db $04 ; entry 0
    dw MONSTER_BLIZZARDY
    dw MONSTER_PHOENIX
    dw MONSTER_ZAPBIRD
    dw MONSTER_FUNKYBIRD

; row 3 (Bird), band 5 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Bird_5::
    db $02 ; entry 0
    dw MONSTER_GARUDIAN
    dw MONSTER_WHIPBIRD

; row 3 (Bird), band 6 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Bird_6::
    db $02 ; entry 0
    dw MONSTER_RAINHAWK
    dw MONSTER_SHANTAK

; row 3 (Bird), band 7 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Bird_7::
    db $01 ; entry 0
    dw MONSTER_AZURILE

; row 4 (Plant), band 0 of EncounterBandSpeciesTable (E-0256, C1)
; record: count; species
EncounterBandSpecies_Plant_0::
    db $04 ; entry 0
    dw MONSTER_CACTIBALL
    dw MONSTER_TOADSTOOL
    dw MONSTER_SLURPERON
    dw MONSTER_EGGPLATON

; row 4 (Plant), band 1 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Plant_1::
    db $03 ; entry 0
    dw MONSTER_MADPLANT
    dw MONSTER_WINGTREE
    dw MONSTER_ONIONO

; row 4 (Plant), band 2 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Plant_2::
    db $05 ; entry 0
    dw MONSTER_FIREWEED
    dw MONSTER_FLORAMAN
    dw MONSTER_GULPPLE
    dw MONSTER_STUBSUCK
    dw MONSTER_DANCEVEGI

; row 4 (Plant), band 3 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Plant_3::
    db $07 ; entry 0
    dw MONSTER_AMBERWEED
    dw MONSTER_TREEBOY
    dw MONSTER_DEVIPINE
    dw MONSTER_BEANMAN
    dw MONSTER_EVILSEED
    dw MONSTER_MANEATER
    dw MONSTER_FOOHERO

; row 4 (Plant), band 4 of EncounterBandSpeciesTable (E-0256, C1)
; record: count; species
EncounterBandSpecies_Plant_4::
    db $02 ; entry 0
    dw MONSTER_SNAPPER
    dw MONSTER_GHOSTREE

; row 4 (Plant), band 5 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Plant_5::
    db $02 ; entry 0
    dw MONSTER_FACETREE
    dw MONSTER_HERBMAN

; row 4 (Plant), band 6 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Plant_6::
    db $01 ; entry 0
    dw MONSTER_ROSEVINE

; row 4 (Plant), band 7 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Plant_7::
    db $03 ; entry 0
    dw MONSTER_EGDRACIL
    dw MONSTER_WARUBOU
    dw MONSTER_WATABOU

; row 5 (Bug), band 0 of EncounterBandSpeciesTable (E-0256, C1)
; record: count; species
EncounterBandSpecies_Bug_0::
    db $04 ; entry 0
    dw MONSTER_GIANTSLUG
    dw MONSTER_GIANTWORM
    dw MONSTER_ARMYANT
    dw MONSTER_TAILEATER

; row 5 (Bug), band 1 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Bug_1::
    db $03 ; entry 0
    dw MONSTER_GOPHECADA
    dw MONSTER_BUTTERFLY
    dw MONSTER_GOHOPPER

; row 5 (Bug), band 2 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Bug_2::
    db $05 ; entry 0
    dw MONSTER_LIPSY
    dw MONSTER_STAGBUG
    dw MONSTER_PYURO
    dw MONSTER_EYEDER
    dw MONSTER_BELZEBUB

; row 5 (Bug), band 3 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Bug_3::
    db $07 ; entry 0
    dw MONSTER_CATAPILA
    dw MONSTER_WEEDBUG
    dw MONSTER_ARMORPEDE
    dw MONSTER_GIANTMOTH
    dw MONSTER_DROLL
    dw MONSTER_MADHORNET
    dw MONSTER_MULTIEYES

; row 5 (Bug), band 4 of EncounterBandSpeciesTable (E-0256, C1)
; record: count; species
EncounterBandSpecies_Bug_4::
    db $02 ; entry 0
    dw MONSTER_ARMYCRAB
    dw MONSTER_SICKLER

; row 5 (Bug), band 5 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Bug_5::
    db $03 ; entry 0
    dw MONSTER_WARMANTIS
    dw MONSTER_HORNBEET
    dw MONSTER_DIGSTER

; row 5 (Bug), band 6 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Bug_6::
    db $01 ; entry 0
    dw MONSTER_ARMORPION

; row 5 (Bug), band 7 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Bug_7::
    db $01 ; entry 0
    dw MONSTER_SKULARACH

; row 6 (Demon), band 0 of EncounterBandSpeciesTable (E-0256, C1)
; record: count; species
EncounterBandSpecies_Demon_0::
    db $02 ; entry 0
    dw MONSTER_PIXY
    dw MONSTER_DEMONITE

; row 6 (Demon), band 1 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Demon_1::
    db $02 ; entry 0
    dw MONSTER_1EYECLOWN
    dw MONSTER_GREMLIN

; row 6 (Demon), band 2 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Demon_2::
    db $03 ; entry 0
    dw MONSTER_MEDUSAEYE
    dw MONSTER_EYEBALL
    dw MONSTER_ORC

; row 6 (Demon), band 3 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Demon_3::
    db $04 ; entry 0
    dw MONSTER_DARKEYE
    dw MONSTER_SKULRIDER
    dw MONSTER_GIGANTES
    dw MONSTER_EVILARMOR

; row 6 (Demon), band 4 of EncounterBandSpeciesTable (E-0256, C1)
; record: count; species
EncounterBandSpecies_Demon_4::
    db $06 ; entry 0
    dw MONSTER_AGDEVIL
    dw MONSTER_EVILBEAST
    dw MONSTER_BUBBLEMON
    dw MONSTER_LIONEX
    dw MONSTER_OGRE
    dw MONSTER_MADKNIGHT

; row 6 (Demon), band 5 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Demon_5::
    db $08 ; entry 0
    dw MONSTER_ARCDEMON
    dw MONSTER_GOATHORN
    dw MONSTER_GATEGUARD
    dw MONSTER_CHOPCLOWN
    dw MONSTER_BOSSTROLL
    dw MONSTER_GRENDAL
    dw MONSTER_EVILWELL
    dw MONSTER_CENTASAUR

; row 6 (Demon), band 6 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Demon_6::
    db $04 ; entry 0
    dw MONSTER_AKUBAR
    dw MONSTER_JAMIRUS
    dw MONSTER_DURRAN
    dw MONSTER_LAMPGENIE

; row 6 (Demon), band 7 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Demon_7::
    db $01 ; entry 0
    dw MONSTER_TITANIS

; row 7 (Zombie), band 0 of EncounterBandSpeciesTable (E-0256, C1)
; record: count; species
EncounterBandSpecies_Zombie_0::
    db $01 ; entry 0
    dw MONSTER_SPOOKY

; row 7 (Zombie), band 1 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Zombie_1::
    db $04 ; entry 0
    dw MONSTER_ROTRAVEN
    dw MONSTER_MUDRON
    dw MONSTER_INVERZON
    dw MONSTER_FOXFIRE

; row 7 (Zombie), band 2 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Zombie_2::
    db $08 ; entry 0
    dw MONSTER_PUTREPUP
    dw MONSTER_MUMMY
    dw MONSTER_SHADOW
    dw MONSTER_SKULPENT
    dw MONSTER_HORK
    dw MONSTER_NITEWHIP
    dw MONSTER_WINDMERGE
    dw MONSTER_POMPOMBOM

; row 7 (Zombie), band 3 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Zombie_3::
    db $06 ; entry 0
    dw MONSTER_DARKCRAB
    dw MONSTER_DEADNITE
    dw MONSTER_REAPER
    dw MONSTER_CAPTDEAD
    dw MONSTER_BONESLAVE
    dw MONSTER_MADSPIRIT

; row 7 (Zombie), band 4 of EncounterBandSpeciesTable (E-0256, C1)
; record: count; species
EncounterBandSpecies_Zombie_4::
    db $01 ; entry 0
    dw MONSTER_SKELETOR

; row 7 (Zombie), band 5 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Zombie_5::
    db $02 ; entry 0
    dw MONSTER_SKULLGON
    dw MONSTER_SERVANT

; row 7 (Zombie), band 6 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Zombie_6::
    db $04 ; entry 0
    dw MONSTER_DEADNOBLE
    dw MONSTER_WHITEKING
    dw MONSTER_COPYCAT
    dw MONSTER_NITERICH

; row 7 (Zombie), band 7 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Zombie_7::
    db $01 ; entry 0
    dw MONSTER_LAZAMANUS

; row 8 (Material), band 0 of EncounterBandSpeciesTable (E-0256, C1)
; record: count; species
EncounterBandSpecies_Material_0::
    db $05 ; entry 0
    dw MONSTER_MADCANDLE
    dw MONSTER_FACER
    dw MONSTER_SPIKYBOY
    dw MONSTER_GOOPI
    dw MONSTER_MUDDOLL

; row 8 (Material), band 1 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Material_1::
    db $04 ; entry 0
    dw MONSTER_JEWELBAG
    dw MONSTER_COILBIRD
    dw MONSTER_BRUSHEAD
    dw MONSTER_PROTOMECH

; row 8 (Material), band 2 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Material_2::
    db $03 ; entry 0
    dw MONSTER_EVILWAND
    dw MONSTER_PUPPETOR
    dw MONSTER_CURSELAMP

; row 8 (Material), band 3 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Material_3::
    db $08 ; entry 0
    dw MONSTER_MADMIRROR
    dw MONSTER_ROGUENITE
    dw MONSTER_VOODOLL
    dw MONSTER_SABREMAN
    dw MONSTER_EVILPOT
    dw MONSTER_GISMO
    dw MONSTER_EXAUCERS
    dw MONSTER_CLOUDKING

; row 8 (Material), band 4 of EncounterBandSpeciesTable (E-0256, C1)
; record: count; species
EncounterBandSpecies_Material_4::
    db $06 ; entry 0
    dw MONSTER_METALDRAK
    dw MONSTER_ROBOSTER
    dw MONSTER_MIMIC
    dw MONSTER_GOLEM
    dw MONSTER_STONEMAN
    dw MONSTER_BOMBCRAG

; row 8 (Material), band 5 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Material_5::
    db $04 ; entry 0
    dw MONSTER_BALZAK
    dw MONSTER_ROBOSTER2
    dw MONSTER_LAVAMAN
    dw MONSTER_ICEMAN

; row 8 (Material), band 6 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Material_6::
    db $01 ; entry 0
    dw MONSTER_GOLDGOLEM

; row 8 (Material), band 7 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Material_7::
    db $01 ; entry 0
    dw MONSTER_DARKMATE

; row 9 (Water), band 0 of EncounterBandSpeciesTable (E-0256, C1)
; record: count; species
EncounterBandSpecies_Water_0::
    db $03 ; entry 0
    dw MONSTER_PETITEEL
    dw MONSTER_MORAY
    dw MONSTER_PUTREFISH

; row 9 (Water), band 1 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Water_1::
    db $04 ; entry 0
    dw MONSTER_OCTOKID
    dw MONSTER_GAMANIAN
    dw MONSTER_SCALLOPA
    dw MONSTER_STARFISH

; row 9 (Water), band 2 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Water_2::
    db $05 ; entry 0
    dw MONSTER_ANEMON
    dw MONSTER_AQUARELLA
    dw MONSTER_OCTOREACH
    dw MONSTER_ROGUEWAVE
    dw MONSTER_PUMPOISE

; row 9 (Water), band 3 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Water_3::
    db $06 ; entry 0
    dw MONSTER_WALRUSMAN
    dw MONSTER_RAYGIGAS
    dw MONSTER_MERMAN
    dw MONSTER_ANGLERON
    dw MONSTER_FISHRIDER
    dw MONSTER_CLAWSTER

; row 9 (Water), band 4 of EncounterBandSpeciesTable (E-0256, C1)
; record: count; species
EncounterBandSpecies_Water_4::
    db $05 ; entry 0
    dw MONSTER_RUSHFISH
    dw MONSTER_CANCERMAN
    dw MONSTER_SEAHORSE
    dw MONSTER_HOODSQUID
    dw MONSTER_MERTIGER

; row 9 (Water), band 5 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Water_5::
    db $05 ; entry 0
    dw MONSTER_AXESHARK
    dw MONSTER_OCTOGON
    dw MONSTER_DIGONG
    dw MONSTER_WHALEMAGE
    dw MONSTER_OCTORAID

; row 9 (Water), band 6 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Water_6::
    db $03 ; entry 0
    dw MONSTER_KINGSQUID
    dw MONSTER_AQUADON
    dw MONSTER_GRAKOS

; row 9 (Water), band 7 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Water_7::
    db $01 ; entry 0
    dw MONSTER_POSEIDON

; row 10 (Boss), band 0 of EncounterBandSpeciesTable (E-0256, C1)
; record: count; species
EncounterBandSpecies_Boss_0::
    db $06 ; entry 0
    dw MONSTER_DRACOLORD
    dw MONSTER_HARGON
    dw MONSTER_BARAMOS
    dw MONSTER_ESTERK
    dw MONSTER_MIRUDRAAS
    dw MONSTER_MUDOU

; row 10 (Boss), band 1 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Boss_1::
    db $06 ; entry 0
    dw MONSTER_DRACOLORD
    dw MONSTER_HARGON
    dw MONSTER_BARAMOS
    dw MONSTER_ESTERK
    dw MONSTER_MIRUDRAAS
    dw MONSTER_MUDOU

; row 10 (Boss), band 2 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Boss_2::
    db $06 ; entry 0
    dw MONSTER_DRACOLORD
    dw MONSTER_HARGON
    dw MONSTER_BARAMOS
    dw MONSTER_ESTERK
    dw MONSTER_MIRUDRAAS
    dw MONSTER_MUDOU

; row 10 (Boss), band 3 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Boss_3::
    db $06 ; entry 0
    dw MONSTER_DRACOLORD
    dw MONSTER_HARGON
    dw MONSTER_BARAMOS
    dw MONSTER_ESTERK
    dw MONSTER_MIRUDRAAS
    dw MONSTER_MUDOU

; row 10 (Boss), band 4 of EncounterBandSpeciesTable (E-0256, C1)
; record: count; species
EncounterBandSpecies_Boss_4::
    db $06 ; entry 0
    dw MONSTER_DRACOLORD
    dw MONSTER_HARGON
    dw MONSTER_BARAMOS
    dw MONSTER_ESTERK
    dw MONSTER_MIRUDRAAS
    dw MONSTER_MUDOU

; row 10 (Boss), band 5 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Boss_5::
    db $06 ; entry 0
    dw MONSTER_DRACOLORD
    dw MONSTER_HARGON
    dw MONSTER_BARAMOS
    dw MONSTER_ESTERK
    dw MONSTER_MIRUDRAAS
    dw MONSTER_MUDOU
    db $06

; row 10 (Boss), band 6 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Boss_6::
    db $06 ; entry 0
    dw MONSTER_DRACOLORD
    dw MONSTER_HARGON
    dw MONSTER_BARAMOS
    dw MONSTER_ESTERK
    dw MONSTER_MIRUDRAAS
    dw MONSTER_MUDOU

; row 10 (Boss), band 7 of EncounterBandSpeciesTable (E-0256, C1)
EncounterBandSpecies_Boss_7::
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
    ds $ee8, $00
