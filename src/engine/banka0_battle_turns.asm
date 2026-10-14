; ROM bank $A0: battle turns, encounter bands, game mode 7
; The annotated listing of this bank is build/listing/banka0.asm.

SECTION "Bank A0", ROMX[$4000], BANK[$A0]
    db $a0

; called from GameMode7_Init: calls FillBytes; copies wDataBank to wDataBankSave; calls FillBytes;
; sets wBattleKind to $0a; calls GameMode7_Init_FillBytes_2; calls FillBytes; calls
; GameMode7_Init_ReadLinkRole; calls GameMode7_Init_RunA0OrBySlotC; calls
; GameMode7_Init_ClearAttributesAndScreenBuffer_Bank31; calls GameMode7_Init_QueueMusic; calls
; GameMode7_Init_CarryUnlessBattleSlotOutSlotEmpty (E-0347)
; why: a helper of GameMode7_Init; GameMode7_Init: start-up for wGameMode = 7 (E-0352, E-0029)
GameMode7_Init_FillBytes::
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
    call GameMode7_Init_FillBytes_2
    ld hl, wWorkBuf
    ld bc, $0200
    xor a
    call FillBytes
    call GameMode7_Init_ReadLinkRole
    call GameMode7_Init_RunA0OrBySlotC
    call GameMode7_Init_ClearAttributesAndScreenBuffer_Bank31
    call GameMode7_Init_QueueMusic
    call GameMode7_Init_CarryUnlessBattleSlotOutSlotEmpty
    ret

; clears the slot-out bytes of slots 4-7, marking the last one absent ($FF) unless
; wScreenCountPlusOne is 2, then checks the slots (CarryUnlessBattleSlotOutSlotEmpty) (E-0289)
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

; Sets wEffectId to $ff; sets wQueuedActionId to $ff; sets wSealPrayState to $ff; sets
; wBattleItemTarget to $ff; calls FillBytes; sets wDebugValue3 to 0; sets wDebugState to 0; sets
; wDebugSubState to 0; calls FillBytes; sets wDisplaySlot to $ff; sets wBattleMeter to $0a; calls
; FillBytes; then 9 more steps (see the code) (E-0347)
; why: part of GameMode7_Init_FillBytes, in a helper of GameMode7_Init; GameMode7_Init: start-up for
; wGameMode = 7 (E-0352, E-0029)
GameMode7_Init_FillBytes_2::
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

; Calls ClearAttributesAndScreenBuffer_Bank31; calls GameMode7_Init_CopyGlyphTilesToVRAM; calls
; GameMode7_Init_ReadScreenBufferRectHeader_BankA0; calls GameMode7_Init_DrawSlotPanelValues_BankA0;
; calls FillTilesFromRequest; calls CopyRectRecordToScreenBuffer; calls
; CopyScreenTileBufferToVRAM_A0; sets wBGPaletteUploadRequest to $7f (E-0347)
; why: part of GameMode7_Init; GameMode7_Init: start-up for wGameMode = 7 (E-0352, E-0029)
GameMode7_Init_ClearAttributesAndScreenBuffer_Bank31::
    farcall ClearAttributesAndScreenBuffer_Bank31
    call GameMode7_Init_CopyGlyphTilesToVRAM
    call GameMode7_Init_ReadScreenBufferRectHeader_BankA0
    call GameMode7_Init_DrawSlotPanelValues_BankA0
    call FillTilesFromRequest
    farcall CopyRectRecordToScreenBuffer
    ld hl, vBGMap0
    call CopyScreenTileBufferToVRAM_A0
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    ret

; Calls RunA0OrBySlotC (E-0347)
; why: part of GameMode7_Init; GameMode7_Init: start-up for wGameMode = 7 (E-0352, E-0029)
GameMode7_Init_RunA0OrBySlotC::
    ld bc, $0200

.loop:
    push bc
    call RunA0OrBySlotC
    pop bc
    inc c
    dec b
    jr nz, .loop
    ret

; runs the slot setup (RunA0OrBySlotC) for slots 4-5, then falls into the shared loop's tail:
; AdjustSkillsForBattleStart_A0 and the slot damage flags (E-0289)
PrepareTwoFoeSlots::
    ld bc, $0204
    jr PrepareThreeFoeSlots_Loop

; runs the slot setup (RunA0OrBySlotC) for slots 4-6, then AdjustSkillsForBattleStart_A0 and the
; slot damage flags (E-0289)
PrepareThreeFoeSlots::
    ld bc, $0304

; Calls RunA0OrBySlotC; may continue in PrepareThreeFoeSlots_Loop; calls
; AdjustSkillsForBattleStart_A0; branches on the byte at wBattleSlotOut; copies the byte at
; wBattleMonsterId to wSpeciesIdLo; copies the byte at wBattleMonsterId to wSpeciesIdHi; calls
; LoadSpeciesRecord; also changes HL, DE, BC and A by register arithmetic (E-0347)
; why: part of PrepareThreeFoeSlots; PrepareThreeFoeSlots: runs the slot setup (RunA0OrBySlotC) for
; slots 4-6, then AdjustSkillsForBattleStart_A0 and the slot damage flags (E-0352)
PrepareThreeFoeSlots_Loop::
    push bc
    call RunA0OrBySlotC
    pop bc
    inc c
    dec b
    jr nz, PrepareThreeFoeSlots_Loop
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
    call StoreTileADAtHL_BankA0
    jr .next2

.cp_35:
    cp $35
    jr nz, .next2
    call StoreTileAEAtHL_BankA0

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

; [HL] = $AD (E-0116)
StoreTileADAtHL_BankA0::
    ld [hl], $ad
    ret

; [HL] = $AE (E-0116)
StoreTileAEAtHL_BankA0::
    ld [hl], $ae
    ret

; sets wBattleSlotOut for slot C from bit 7 of the record byte and the slot's wBattleStatus bits
; from its other flags (E-0344: the address in its name dropped or read as the label there; was
; RunA0OrBySlotC_SetSlotOutAndStatus)
RunA0OrBySlotC_SetSlotOutAndStatus::
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

; DE += C; copies the byte at HL to [DE]; HL += 1 (the same 9 bytes appear in 2 banks) (E-0353)
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

; DE += 2 * C; copies the word at HL to [DE]; HL += 2, DE ends on the second byte written (the same
; 13 bytes appear in 2 banks) (E-0353)
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

; Branches on wBattleKind; plays music $13 (E-0347)
; why: part of GameMode7_Init; GameMode7_Init: start-up for wGameMode = 7 (E-0352, E-0029)
GameMode7_Init_QueueMusic::
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

; Branches on wLinkRole; calls GameMode7_Init_CopyBytesDEFromHL_BankA0; continues in
; GameMode7_Init_CopyBytesDEFromHL_BankA0; calls GameMode7_Init_CopyBytesDEFromHL_BankA0 (E-0347)
; why: part of GameMode7_Init; GameMode7_Init: start-up for wGameMode = 7 (E-0352, E-0029)
GameMode7_Init_ReadLinkRole::
    ld de, wBattlerRecords
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .call_game_mode7_init_copy_bytes_de_from_hl
    ld hl, wRecordBufA
    call GameMode7_Init_CopyBytesDEFromHL_BankA0
    ld hl, wRecordBufB
    jr GameMode7_Init_CopyBytesDEFromHL_BankA0

.call_game_mode7_init_copy_bytes_de_from_hl:
    ld hl, wRecordBufB
    call GameMode7_Init_CopyBytesDEFromHL_BankA0
    ld hl, wRecordBufA

; Calls CopyBytesDEFromHL_BankA0; calls ApplyIncrementOffsetRowsA0ForA0DTo13; also changes HL, DE, A
; and B by register arithmetic (E-0347)
; why: part of GameMode7_Init; GameMode7_Init: start-up for wGameMode = 7 (E-0352, E-0029)
GameMode7_Init_CopyBytesDEFromHL_BankA0::
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
    call ApplyIncrementOffsetRowsA0ForA0DTo13
    ld a, $ff
    ld [de], a
    inc de
    ret

; the same 7 bytes as CopyBytesDEFromHL (CopyBytesDEFromHL) (E-0353)
CopyBytesDEFromHL_BankA0::
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, CopyBytesDEFromHL_BankA0
    ret

; for A in $0D-$13 increments (capped at 3) each byte listed in IncrementOffsetRows_A0 row A - $0D,
; relative to DE (E-0125)
ApplyIncrementOffsetRowsA0ForA0DTo13::
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

; ApplyIncrementOffsetRowsA0ForA0DTo13 takes A in $0D-$13, reads row 16 * (A - $0D) and for each
; byte before $80 increments the byte at DE + $FF00 + byte, capped at 3
; (IncrementTableByteCappedAt3); 7 rows; the bank $19 and $A0 copies are identical (E-0236, C1)
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

; runs RunA0OrBySlotC_BattlerRecordAddress_BankA0 for slots 0-3 or
; RunA0OrBySlotC_BattlerRecordAddress_BankA0_2 for slots 4-7, clears the species record buffer and
; restores wBattleArg0 (E-0122) (E-0344: the address in its name dropped or read as the label there;
; was RunA0OrBySlotC)
RunA0OrBySlotC::
    ld a, [wBattleArg0]
    push af
    ld a, c
    cp $04
    jr nc, .call_run_a0_or_by_slot_c_battler_record
    call RunA0OrBySlotC_BattlerRecordAddress_BankA0
    jr .call_clear_species_record_buffer_bank_a0

.call_run_a0_or_by_slot_c_battler_record:
    call RunA0OrBySlotC_BattlerRecordAddress_BankA0_2

.call_clear_species_record_buffer_bank_a0:
    call ClearSpeciesRecordBuffer_BankA0
    pop af
    ld [wBattleArg0], a
    ret

; called from RunA0OrBySlotC: calls BattlerRecordAddress_BankA0; branches on C; branches on
; wLinkRole; branches on wBattleArg0; calls LoadSlotSkillsFromBattlerRecord; calls
; SetCFromBattleArg0ThenRunLoadSlotSkillsFromBattlerRecord; calls
; RunA0OrBySlotC_SetSlotOutAndStatus; calls StoreByteAtDEPlusC_BankA0; branches on wLoadSlot; calls
; StoreWordAtDEPlus2C_BankA0; branches on wLoadSlot; calls StoreByteAtDEPlusC_BankA0; then 7 more
; steps (see the code) (E-0347)
; why: a helper of RunA0OrBySlotC; RunA0OrBySlotC: runs RunA0OrBySlotC_BattlerRecordAddress_BankA0
; for slots 0-3 or RunA0OrBySlotC_BattlerRecordAddress_BankA0_2 for slots 4-7, clears the ...
; (E-0352, E-0122, E-0344)
RunA0OrBySlotC_BattlerRecordAddress_BankA0::
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
    jr nz, .call_set_c_from_battle_arg0_then_run_load
    farcall LoadSlotSkillsFromBattlerRecord
    jr .restore4

.call_set_c_from_battle_arg0_then_run_load:
    farcall SetCFromBattleArg0ThenRunLoadSlotSkillsFromBattlerRecord

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
    call z, RunA0OrBySlotC_SetSlotOutAndStatus
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
    farcall LoadBattleArg0PointersThenRunPackResistanceFieldsToDE
    pop bc
    farcall SetSlotAIModeFromINT
    ret

; called from RunA0OrBySlotC: calls BattlerRecordAddress_BankA0; branches on wBattleArg0; calls
; LoadSlotSkillsFromBattlerRecord; calls SetCFromBattleArg0ThenRunLoadSlotSkillsFromBattlerRecord;
; calls RunA0OrBySlotC_SetSlotOutAndStatus; calls StoreByteAtDEPlusC_BankA0; branches on wLoadSlot;
; calls StoreWordAtDEPlus2C_BankA0; branches on wLoadSlot; calls StoreByteAtDEPlusC_BankA0; copies L
; to wBattleArg0; copies H to wBattleArg1; then 5 more steps (see the code) (E-0347)
; why: a helper of RunA0OrBySlotC; RunA0OrBySlotC: runs RunA0OrBySlotC_BattlerRecordAddress_BankA0
; for slots 0-3 or RunA0OrBySlotC_BattlerRecordAddress_BankA0_2 for slots 4-7, clears the ...
; (E-0352, E-0122, E-0344)
RunA0OrBySlotC_BattlerRecordAddress_BankA0_2::
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
    jr nz, .call_set_c_from_battle_arg0_then_run_load
    farcall LoadSlotSkillsFromBattlerRecord
    jr .restore

.call_set_c_from_battle_arg0_then_run_load:
    farcall SetCFromBattleArg0ThenRunLoadSlotSkillsFromBattlerRecord

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
    call z, RunA0OrBySlotC_SetSlotOutAndStatus
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
    farcall LoadBattleArg0PointersThenRunPackResistanceFieldsToDE
    pop bc
    farcall SetSlotAIModeFromINT
    ret

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

; Calls CarryUnlessBattleSlotOutSlotEmpty; calls CheckSlotStatusBlock; sets wSlotMarks to 0; sets
; wSlotMarks to 1; sets wSlotMarks to $ff (E-0347)
; why: part of GameMode7_Init; GameMode7_Init: start-up for wGameMode = 7 (E-0352, E-0029)
GameMode7_Init_CarryUnlessBattleSlotOutSlotEmpty::
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

; ComputeWildEncounterLevel, then ApplyLevelScaledStatsToSlots (E-0289)
ComputeWildLevelAndScaleStats::
    push bc
    call ComputeWildEncounterLevel
    pop bc
    call ApplyLevelScaledStatsToSlots
    ret

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

; DE += the word at [HL]; HL += 1 (ends on the high byte); clobbers A (E-0353)
AddWordAtHLToDE::
    ld a, [hli]
    add e
    ld e, a
    ld a, [hl]
    adc d
    ld d, a
    ret

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

; data read by PickRandomBand0To10 (11 bytes) (E-0347)
PickRandomBand0To10_Data::
    db $19, $32, $4b, $64, $7d, $96, $af, $c8, $e1, $fa, $ff

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

; hTemp1 = min(4 * wWildLevel / 5 + 5, 99); runs ApplyLevelScaledStatsToSlots_LoadSpeciesRecord for
; B slots from C with wBattleArg2 = ApplyLevelScaledStatsToSlots_Data[slot] (E-0125)
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
    call ApplyLevelScaledStatsToSlots_LoadSpeciesRecord
    pop bc
    inc c
    dec b
    jr nz, .loop
    ret

; called from ApplyLevelScaledStatsToSlots: copies C to wBattleArg1; copies L to wSpeciesIdLo;
; copies H to wSpeciesIdHi; calls LoadSpeciesRecord; copies wSpeciesRecord + SPECIES_GROWTH to
; hTemp0; calls StatFromGrowthRow; sets wBattleArg0 to 1; calls ScaleStatByWildLevelCapped999; calls
; StoreTemp2WordAtHL_BankA0; sets hTemp0; calls StatFromGrowthRow; sets wBattleArg0 to 0; then 18
; more steps (see the code) (E-0347)
; why: a helper of ApplyLevelScaledStatsToSlots; ApplyLevelScaledStatsToSlots: hTemp1 = min(4 *
; wWildLevel / 5 + 5, 99) (E-0352, E-0125)
ApplyLevelScaledStatsToSlots_LoadSpeciesRecord::
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

; stores hTemp2 then hTemp3 at HL; HL += 2; clobbers A (E-0065) (the same 7 bytes appear in 2 banks)
StoreTemp2WordAtHL_BankA0::
    ldh a, [hTemp2]
    ld [hli], a
    ldh a, [hTemp3]
    ld [hli], a
    ret

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

; data read by ApplyLevelScaledStatsToSlots (6 bytes) (E-0347)
ApplyLevelScaledStatsToSlots_Data::
    db $bf, $d1, $0d, $d2, $5b, $d2

; Sets wNameGlyphBuf to $90; calls CopyGlyphTilesToVRAM; calls CopyBytes; calls
; CopyGlyphTilesToVRAM; calls CopyBytes; calls CopyGlyphTilesToVRAM; branches on wLinkRole; calls
; CopyBytes; calls CopyGlyphTilesToVRAM; calls CopyBytes; calls CopyGlyphTilesToVRAM; branches on
; the byte at wPlayerName; then 10 more steps (see the code) (E-0347)
; why: part of GameMode7_Init; GameMode7_Init: start-up for wGameMode = 7 (E-0352, E-0029)
GameMode7_Init_CopyGlyphTilesToVRAM::
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

; Fills the $160 bytes at wScreenTileBuffer + $E0 with $C3; clobbers A, BC, HL (the same 15 bytes
; appear in 2 banks) (E-0353)
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

; Calls ReadScreenBufferRectHeader_BankA0; calls CopyRectToStride32_BankA0 (E-0347)
; why: part of GameMode7_Init; GameMode7_Init: start-up for wGameMode = 7 (E-0352, E-0029)
GameMode7_Init_ReadScreenBufferRectHeader_BankA0::
    ld hl, GameMode7_Init_ReadScreenBufferRectHeader_BankA0_TileRect
    call ReadScreenBufferRectHeader_BankA0
    call CopyRectToStride32_BankA0
    ret

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

; Calls DrawSlotPanelValues_BankA0 (E-0347)
; why: part of GameMode7_Init; GameMode7_Init: start-up for wGameMode = 7 (E-0352, E-0029)
GameMode7_Init_DrawSlotPanelValues_BankA0::
    ld c, $00
    call DrawSlotPanelValues_BankA0
    ld c, $01

; DrawSlotHPDigits_BankA0, DrawSlotMPDigits_BankA0 and DrawSlotStatusMarks_BankA0 for slot C
; (E-0116)
DrawSlotPanelValues_BankA0::
    call DrawSlotHPDigits_BankA0
    call DrawSlotMPDigits_BankA0
    call DrawSlotStatusMarks_BankA0
    ret

; runs BuildAndCopySlotPanel_A0 for slot 0 and falls into it for slot 1 (E-0126)
BuildAndCopySlotPanels0And1_A0::
    ld c, $00
    call BuildAndCopySlotPanel_A0
    ld c, $01

; runs CopySlotHPDigitsPanelToVRAM_BankA0 and 6C22 for slot C and copies its panel row to VRAM
; (E-0122)
BuildAndCopySlotPanel_A0::
    call CopySlotHPDigitsPanelToVRAM_BankA0
    call CopySlotMPDigitsPanelToVRAM_BankA0
    call CopySlotPanelRowToVRAM_BankA0
    ret

; copies a 20 x 5 rectangle from wWindowTileBuffer + $38 (rows 32 bytes apart) to vBGMap0 + $1A0
; (row 13) with CopyRect32StrideToVRAM_BankA0, as DrawWindowTileBufferRow2Col16RowsToBGMapRow13 does
; in bank $31 (E-0076) (E-0340: the address in its name read as its RAM name; was
; DrawWindowTileBufferRow2Col16RowsToBGMapRow13_BankA0)
DrawWindowTileBufferRow2Col16RowsToBGMapRow13_BankA0::
    ld de, wWindowTileBuffer + $38
    ld hl, vBGMap0 + $1a0
    lb bc, $14, $05
    call CopyRect32StrideToVRAM_BankA0
    ret

; Calls CopyRect32StrideToVRAM_BankA0 (E-0347)
; why: part of RunBattleSetup_BankA0_EntrySelect; RunBattleSetup_BankA0_EntrySelect: by
; wBattleResolveStep: lays out the tile blocks for the foe count and moves a selection over entries,
; setting or clearing bit 6 and the ... (E-0352)
RunBattleSetup_BankA0_EntrySelect_ToCopyRect32StrideToVRAM_BankA0::
    ld de, wWindowTileBuffer + $38
    ld hl, vBGMap0 + $1a0
    lb bc, $0e, $05
    call CopyRect32StrideToVRAM_BankA0
    ret

; copies a 20 x 11 rectangle from wScreenTileBuffer + $E0 to vBGMap0 + $E0 (row 7) with
; CopyRect32StrideToVRAM_BankA0 (E-0116) (E-0340: the address in its name read as its RAM name; was
; DrawScreenTileBufferRow11Col4Rect20x11ToBGMapRow7_BankA0)
DrawScreenTileBufferRow11Col4Rect20x11ToBGMapRow7_BankA0::
    ld de, wScreenTileBuffer + $e0
    ld hl, vBGMap0 + $e0
    lb bc, $14, $0b
    call CopyRect32StrideToVRAM_BankA0
    ret

; copies an 11 x 9 rectangle from wScreenTileBuffer + $120 to vBGMap0 + $120 (row 9) with
; CopyRect32StrideToVRAM_BankA0 (E-0111) (E-0340: the address in its name read as its RAM name; was
; DrawScreenTileBufferRow14Col8Rect11x9ToBGMapRow9_BankA0)
DrawScreenTileBufferRow14Col8Rect11x9ToBGMapRow9_BankA0::
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    lb bc, $0b, $09
    call CopyRect32StrideToVRAM_BankA0
    ret

; copies a 20 x 9 rectangle from wScreenTileBuffer + $120 to vBGMap0 + $120 (row 9), then
; wBattleArg0 = 1 (E-0116) (E-0340: the address in its name read as its RAM name; was
; DrawScreenTileBufferRow14Col8RowsToBGMapRow9_BankA0)
DrawScreenTileBufferRow14Col8RowsToBGMapRow9_BankA0::
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    lb bc, $14, $09
    call CopyRect32StrideToVRAM_BankA0
    ld a, $01
    ld [wBattleArg0], a
    ret

; copies an 8 x 9 rectangle from wScreenTileBuffer + $120 to vBGMap0 + $120 (row 9) (E-0116)
; (E-0340: the address in its name read as its RAM name; was
; DrawScreenTileBufferRow14Col8LeftToBGMapRow9_BankA0)
DrawScreenTileBufferRow14Col8LeftToBGMapRow9_BankA0::
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    lb bc, $08, $09
    call CopyRect32StrideToVRAM_BankA0
    ret

; copies a 7 x 7 rectangle from wScreenTileBuffer + $160 to vBGMap0 + $160 (row 11) (E-0116)
; (E-0340: the address in its name read as its RAM name; was
; DrawScreenTileBufferRow17Col12Rect7x7ToBGMapRow11_BankA0)
DrawScreenTileBufferRow17Col12Rect7x7ToBGMapRow11_BankA0::
    ld de, wScreenTileBuffer + $160
    ld hl, vBGMap0 + $160
    lb bc, $07, $07
    call CopyRect32StrideToVRAM_BankA0
    ret

; copies 7 x 1 from wScreenTileBuffer + $10C to vBGMap0 + $10C and 20 x 9 from wScreenTileBuffer +
; $120 to vBGMap0 + $120 (CopyRect32StrideToVRAM_BankA0) (E-0118) (E-0340: the address in its name
; read as its RAM name; was DrawScreenTileBufferRow13Col8AndScreenTileBufferRow14Col8Rects_BankA0)
DrawScreenTileBufferRow13Col8AndScreenTileBufferRow14Col8Rects_BankA0::
    ld de, wScreenTileBuffer + $10c
    ld hl, vBGMap0 + $10c
    lb bc, $07, $01
    call CopyRect32StrideToVRAM_BankA0
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    lb bc, $14, $09
    call CopyRect32StrideToVRAM_BankA0
    ret

; copies a 13 x 7 rectangle from wScreenTileBuffer + $160 to vBGMap0 + $160 (row 11) (E-0116)
; (E-0340: the address in its name read as its RAM name; was
; DrawScreenTileBufferRow17Col12Rect13x7ToBGMapRow11_BankA0)
DrawScreenTileBufferRow17Col12Rect13x7ToBGMapRow11_BankA0::
    ld de, wScreenTileBuffer + $160
    ld hl, vBGMap0 + $160
    lb bc, $0d, $07
    call CopyRect32StrideToVRAM_BankA0
    ret

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
GameMode7_Init_ReadScreenBufferRectHeader_BankA0_TileRect::
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
    ld b, $31
    ld de, Tiles1Plus240Gfx
    ld hl, vTiles1 + $240
    call DecompressToRAMLocked
    ld b, $31
    ld de, Tiles1Plus5F0Gfx
    ld hl, vTiles1 + $5f0
    call DecompressToRAMLocked
    call GameMode7_Init_FillBytes
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
    jp ClearSGBPacketBuffer_CheckLinkMode

; per-frame routine for wGameMode = 7 (E-0029)
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

; by wBattleStep: waits for the link, computes the wild level and shows each opposing monster's
; picture ('The first/second/third monster is 0!', 'Please wait') (E-0288)
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters::
    ld a, [wBattleStep]
    jumptable
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WaitFadeState
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WaitLinkMessage
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_ReadRandomLo
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WaitLinkMessage_SetLinkSendByte
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_SetBattleStep
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WaitLinkMessage_SetLinkSendByte_2
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_InitBattleSlotsForFoeCount
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_BeginStringDisplay_Bank07
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_ShowTheFirstMonsterIs
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_LoadMonsterPictureAttributes
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_LoadMonsterPictureAttributes_2
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_ShowTheSecondMonsterIs
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_LoadMonsterPictureAndStep
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WriteBattleStepAndTemp0
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_ShowTheThirdMonsterIs
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_LoadMonsterPictureAndStep_SetBGPaletteUploadRequest
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_LoadMonsterPictureAttributes_3
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_ShowPleaseWait
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WaitLinkMessage_SetBattleStep

; step 0 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: returns unless wFadeState is 0;
; advances wBattleStep; sets wLinkSendByte to $0c (E-0347)
; why: step 0 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters (when wBattleStep = 0);
; RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: by wBattleStep: waits for the link, computes the
; wild level and shows each opposing monster's picture ('The first/second/third monster is ...
; (E-0352)
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WaitFadeState::
    ld a, [wFadeState]
    and a
    ret nz
    ld hl, wBattleStep
    inc [hl]
    ld a, $0c
    ld [wLinkSendByte], a
    ret

; step 1 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: returns unless wLinkMessage is $0c;
; sets wLinkSendByte to 0; advances wBattleStep (E-0347)
; why: step 1 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters (when wBattleStep = 1);
; RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: by wBattleStep: waits for the link, computes the
; wild level and shows each opposing monster's picture ('The first/second/third monster is ...
; (E-0352)
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WaitLinkMessage::
    ld a, [wLinkMessage]
    cp $0c
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld hl, wBattleStep
    inc [hl]
    ret

; step 2 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: advances wBattleStep; copies wRandomLo
; to wLinkRecvBuffer; copies wRandomHi to wIntroOrFamilyCount; copies L to wLinkTimeoutLo; copies H
; to wLinkTimeoutHi; copies L to wLinkBufferPtrLo; copies H to wLinkBufferPtrHi; sets
; wLinkBufferCountLo to 2; sets wLinkSendByte to $ff; sets wLinkReady to 1 (E-0347)
; why: step 2 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters (when wBattleStep = 2);
; RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: by wBattleStep: waits for the link, computes the
; wild level and shows each opposing monster's picture ('The first/second/third monster is ...
; (E-0352)
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_ReadRandomLo::
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

; step 3 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: returns unless wLinkMessage is $f0;
; sets wLinkSendByte to 0; sets wLinkReady to 0; advances wBattleStep (E-0347)
; why: step 3 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters (when wBattleStep = 3);
; RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: by wBattleStep: waits for the link, computes the
; wild level and shows each opposing monster's picture ('The first/second/third monster is ...
; (E-0352)
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WaitLinkMessage_SetLinkSendByte::
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

; step 4 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: advances wBattleStep; sets
; wLinkSendByte to 3 (E-0347)
; why: step 4 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters (when wBattleStep = 4);
; RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: by wBattleStep: waits for the link, computes the
; wild level and shows each opposing monster's picture ('The first/second/third monster is ...
; (E-0352)
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_SetBattleStep::
    ld hl, wBattleStep
    inc [hl]
    ld a, $03
    ld [wLinkSendByte], a
    ret

; step 5 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: returns unless wLinkMessage is $03;
; sets wLinkSendByte to 0; branches on wLinkRole; copies L to wLinkPartnerName; copies L to
; wRandomSeed2Lo; copies L to wRandomLo; copies H to wLinkPartnerByte1; copies H to wRandomSeed2Hi;
; copies H to wRandomHi; advances wBattleStep (E-0347)
; why: step 5 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters (when wBattleStep = 5);
; RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: by wBattleStep: waits for the link, computes the
; wild level and shows each opposing monster's picture ('The first/second/third monster is ...
; (E-0352)
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WaitLinkMessage_SetLinkSendByte_2::
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

; step 6 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: calls InitBattleSlotsForFoeCount;
; branches on wScreenCountPlusOne; sets wEncounterKind to 2; calls ComputeWildLevelAndScaleStats;
; calls PrepareThreeFoeSlots; advances wBattleStep; sets wEncounterKind to 1; sets wBattleFoeCount
; to 2; sets wSide1Flag to 2; calls BackupBattlerRecords0And1; calls PrepareTwoFoeSlots; advances
; wBattleStep (E-0347)
; why: step 6 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters (when wBattleStep = 6);
; RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: by wBattleStep: waits for the link, computes the
; wild level and shows each opposing monster's picture ('The first/second/third monster is ...
; (E-0352)
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_InitBattleSlotsForFoeCount::
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

; step 7 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: returns unless wFadeState is 0; copies
; wScreenCountPlusOne to wStringIndex; sets wStringCategory to 6; calls BeginStringDisplay_Bank07;
; advances wBattleStep (E-0347)
; why: step 7 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters (when wBattleStep = 7);
; RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: by wBattleStep: waits for the link, computes the
; wild level and shows each opposing monster's picture ('The first/second/third monster is ...
; (E-0352)
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_BeginStringDisplay_Bank07::
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

; step 8 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: returns unless wTextFlags is 0; calls
; CopyStringHLToDE; sets wStringIndex to 3; sets wStringCategory to 6; calls
; BeginStringDisplay_Bank07; advances wBattleStep (E-0347)
; why: step 8 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters (when wBattleStep = 8);
; RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: by wBattleStep: waits for the link, computes the
; wild level and shows each opposing monster's picture ('The first/second/third monster is ...
; (E-0352)
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_ShowTheFirstMonsterIs::
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

; step 9 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: branches on wIsCGB; sets hTemp0 to 1;
; calls LoadMonsterPictureAttributes; calls LoadMonsterPicture; sets wBGPaletteUploadRequest to $7f;
; advances wBattleStep (E-0347)
; why: step 9 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters (when wBattleStep = 9);
; RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: by wBattleStep: waits for the link, computes the
; wild level and shows each opposing monster's picture ('The first/second/third monster is ...
; (E-0352)
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_LoadMonsterPictureAttributes::
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

; step 10 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: branches on wScreenCountPlusOne; calls
; RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WriteVRAMByteInc; branches on wIsCGB; branches on
; wScreenCountPlusOne; sets hTemp0 to 1; calls LoadMonsterPictureAttributes; advances wBattleStep;
; also changes HL, DE and A by register arithmetic (E-0347)
; why: step 10 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters (when wBattleStep = 10);
; RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: by wBattleStep: waits for the link, computes the
; wild level and shows each opposing monster's picture ('The first/second/third monster is ...
; (E-0352)
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_LoadMonsterPictureAttributes_2::
    ld hl, vBGMap0 + $e1
    ld a, [wScreenCountPlusOne]
    cp $02
    jr nz, .call_run_battle_phase_when_text_idle_a0
    ld hl, vBGMap0 + $e4

.call_run_battle_phase_when_text_idle_a0:
    ld d, $14
    call RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WriteVRAMByteInc
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

; step 11 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: returns unless wTextFlags is 0; calls
; CopyStringHLToDE; sets wStringIndex to 4; sets wStringCategory to 6; calls
; BeginStringDisplay_Bank07; advances wBattleStep (E-0347)
; why: step 11 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters (when wBattleStep = 11);
; RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: by wBattleStep: waits for the link, computes the
; wild level and shows each opposing monster's picture ('The first/second/third monster is ...
; (E-0352)
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_ShowTheSecondMonsterIs::
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

; step 12 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: calls LoadMonsterPicture; sets
; wBGPaletteUploadRequest to $7f; advances wBattleStep (E-0347)
; why: step 12 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters (when wBattleStep = 12);
; RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: by wBattleStep: waits for the link, computes the
; wild level and shows each opposing monster's picture ('The first/second/third monster is ...
; (E-0352)
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_LoadMonsterPictureAndStep::
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

; step 13 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: branches on wScreenCountPlusOne; sets
; wBattleStep; calls RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WriteVRAMByteInc; branches on
; wIsCGB; branches on wScreenCountPlusOne; sets hTemp0 to 3; calls LoadMonsterPictureAttributes;
; advances wBattleStep; also changes HL, DE and A by register arithmetic (E-0347)
; why: step 13 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters (when wBattleStep = 13);
; RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: by wBattleStep: waits for the link, computes the
; wild level and shows each opposing monster's picture ('The first/second/third monster is ...
; (E-0352)
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WriteBattleStepAndTemp0::
    ld hl, vBGMap0 + $e7
    ld a, [wScreenCountPlusOne]
    cp $02
    jr nz, .call_run_battle_phase_when_text_idle_a0
    ld a, [wBattleStep]
    add $03
    ld [wBattleStep], a
    ld hl, vBGMap0 + $ea

.call_run_battle_phase_when_text_idle_a0:
    ld d, $38
    call RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WriteVRAMByteInc
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

; step 14 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: returns unless wTextFlags is 0; calls
; CopyStringHLToDE; sets wStringIndex to 5; sets wStringCategory to 6; calls
; BeginStringDisplay_Bank07; advances wBattleStep (E-0347)
; why: step 14 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters (when wBattleStep = 14);
; RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: by wBattleStep: waits for the link, computes the
; wild level and shows each opposing monster's picture ('The first/second/third monster is ...
; (E-0352)
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_ShowTheThirdMonsterIs::
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

; step 15 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: calls LoadMonsterPicture; sets
; wBGPaletteUploadRequest to $7f; advances wBattleStep (E-0347)
; why: step 15 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters (when wBattleStep = 15);
; RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: by wBattleStep: waits for the link, computes the
; wild level and shows each opposing monster's picture ('The first/second/third monster is ...
; (E-0352)
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_LoadMonsterPictureAndStep_SetBGPaletteUploadRequest::
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

; step 16 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: calls
; RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WriteVRAMByteInc; branches on wIsCGB; sets hTemp0
; to 5; calls LoadMonsterPictureAttributes; advances wBattleStep; also changes HL, DE and A by
; register arithmetic (E-0347)
; why: step 16 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters (when wBattleStep = 16);
; RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: by wBattleStep: waits for the link, computes the
; wild level and shows each opposing monster's picture ('The first/second/third monster is ...
; (E-0352)
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_LoadMonsterPictureAttributes_3::
    ld d, $5c
    ld hl, vBGMap0 + $ed
    call RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WriteVRAMByteInc
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

; step 17 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: returns unless wTextFlags is 0; sets
; wStringCategory to 5; sets wStringIndex to $0c; calls ShowString_Bank07; sets wLinkSendByte to 1;
; advances wBattleStep (E-0347)
; why: step 17 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters (when wBattleStep = 17);
; RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: by wBattleStep: waits for the link, computes the
; wild level and shows each opposing monster's picture ('The first/second/third monster is ...
; (E-0352)
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_ShowPleaseWait::
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

; step 18 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: returns unless wLinkMessage is $01;
; sets wBattleStep to 0; sets wLinkSendByte to 0; advances wBattlePhase (E-0347)
; why: step 18 of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters (when wBattleStep = 18);
; RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: by wBattleStep: waits for the link, computes the
; wild level and shows each opposing monster's picture ('The first/second/third monster is ...
; (E-0352)
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WaitLinkMessage_SetBattleStep::
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

; Calls WriteVRAMByteInc; also changes HL, BC, A and D by register arithmetic (E-0347)
; why: part of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters;
; RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters: by wBattleStep: waits for the link, computes the
; wild level and shows each opposing monster's picture ('The first/second/third monster is ...
; (E-0352)
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WriteVRAMByteInc::
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

; by wBattleStep: clears a buffer, then RunBattleSetup_BankA0, the command entry (bank $A1),
; RunBattleActions and RunBattleStep4 (E-0294)
RunBattlePhaseWhenTextIdle_A0_RunTurn::
    ld a, [wBattleStep]
    jumptable
    dw RunBattlePhaseWhenTextIdle_A0_RunTurn_FillBytesAndStep
    dw RunBattlePhaseWhenTextIdle_A0_RunTurn_ToRunBattleSetup_BankA0
    dw RunBattlePhaseWhenTextIdle_A0_RunTurn_ToRunBattleCommandEntry_BankA1
    dw RunBattlePhaseWhenTextIdle_A0_RunTurn_ToRunBattleActions
    dw RunBattlePhaseWhenTextIdle_A0_RunTurn_ToRunBattleStep4

; step 0 of RunBattlePhaseWhenTextIdle_A0_RunTurn: calls
; RunBattlePhaseWhenTextIdle_A0_RunTurn_FillBytes; advances wBattleStep (E-0347)
; why: step 0 of RunBattlePhaseWhenTextIdle_A0_RunTurn (when wBattleStep = 0);
; RunBattlePhaseWhenTextIdle_A0_RunTurn: by wBattleStep: clears a buffer, then
; RunBattleSetup_BankA0, the command entry (bank $A1), RunBattleActions and RunBattleStep4 (E-0352)
RunBattlePhaseWhenTextIdle_A0_RunTurn_FillBytesAndStep::
    call RunBattlePhaseWhenTextIdle_A0_RunTurn_FillBytes
    ld hl, wBattleStep
    inc [hl]
    ret

; step 1 of RunBattlePhaseWhenTextIdle_A0_RunTurn: calls RunBattleSetup_BankA0 (E-0347)
; why: step 1 of RunBattlePhaseWhenTextIdle_A0_RunTurn (when wBattleStep = 1);
; RunBattlePhaseWhenTextIdle_A0_RunTurn: by wBattleStep: clears a buffer, then
; RunBattleSetup_BankA0, the command entry (bank $A1), RunBattleActions and RunBattleStep4 (E-0352)
RunBattlePhaseWhenTextIdle_A0_RunTurn_ToRunBattleSetup_BankA0::
    call RunBattleSetup_BankA0
    ret

; step 2 of RunBattlePhaseWhenTextIdle_A0_RunTurn: calls RunBattleCommandEntry_BankA1 (E-0347)
; why: step 2 of RunBattlePhaseWhenTextIdle_A0_RunTurn (when wBattleStep = 2);
; RunBattlePhaseWhenTextIdle_A0_RunTurn: by wBattleStep: clears a buffer, then
; RunBattleSetup_BankA0, the command entry (bank $A1), RunBattleActions and RunBattleStep4 (E-0352)
RunBattlePhaseWhenTextIdle_A0_RunTurn_ToRunBattleCommandEntry_BankA1::
    farcall RunBattleCommandEntry_BankA1
    ret

; step 3 of RunBattlePhaseWhenTextIdle_A0_RunTurn: calls RunBattleActions (E-0347)
; why: step 3 of RunBattlePhaseWhenTextIdle_A0_RunTurn (when wBattleStep = 3);
; RunBattlePhaseWhenTextIdle_A0_RunTurn: by wBattleStep: clears a buffer, then
; RunBattleSetup_BankA0, the command entry (bank $A1), RunBattleActions and RunBattleStep4 (E-0352)
RunBattlePhaseWhenTextIdle_A0_RunTurn_ToRunBattleActions::
    farcall RunBattleActions
    ret

; step 4 of RunBattlePhaseWhenTextIdle_A0_RunTurn: calls RunBattleStep4 (E-0347)
; why: step 4 of RunBattlePhaseWhenTextIdle_A0_RunTurn (when wBattleStep = 4);
; RunBattlePhaseWhenTextIdle_A0_RunTurn: by wBattleStep: clears a buffer, then
; RunBattleSetup_BankA0, the command entry (bank $A1), RunBattleActions and RunBattleStep4 (E-0352)
RunBattlePhaseWhenTextIdle_A0_RunTurn_ToRunBattleStep4::
    farcall RunBattleStep4
    ret

; by wBattleStep: exchanges bytes and messages over the link ('Please wait.') (E-0288)
RunBattlePhaseWhenTextIdle_A0_SyncLink::
    ld a, [wBattleStep]
    jumptable
    dw RunBattlePhaseWhenTextIdle_A0_SyncLink_SetLinkSendByte
    dw RunBattlePhaseWhenTextIdle_A0_SyncLink_WaitLinkMessage
    dw RunBattlePhaseWhenTextIdle_A0_SyncLink_WaitLinkMessage_2
    dw RunBattlePhaseWhenTextIdle_A0_SyncLink_AddAx9ToHL
    dw RunBattlePhaseWhenTextIdle_A0_SyncLink_PleaseWait
    dw RunBattlePhaseWhenTextIdle_A0_SyncLink_ReadSTAT
    dw RunBattlePhaseWhenTextIdle_A0_SyncLink_WriteVBK
    dw RunBattlePhaseWhenTextIdle_A0_SyncLink_SetBattleStep
    dw RunBattlePhaseWhenTextIdle_A0_SyncLink_WaitLinkMessage_SetLinkSendByte

; step 0 of RunBattlePhaseWhenTextIdle_A0_SyncLink: sets wLinkSendByte to 1; advances wBattleStep
; (E-0347)
; why: step 0 of RunBattlePhaseWhenTextIdle_A0_SyncLink (when wBattleStep = 0);
; RunBattlePhaseWhenTextIdle_A0_SyncLink: by wBattleStep: exchanges bytes and messages over the link
; ('Please wait.') (E-0352)
RunBattlePhaseWhenTextIdle_A0_SyncLink_SetLinkSendByte::
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wBattleStep
    inc [hl]
    ret

; step 1 of RunBattlePhaseWhenTextIdle_A0_SyncLink: returns unless wLinkMessage is $01; copies L to
; wLinkTimeoutLo; copies H to wLinkTimeoutHi; copies L to wLinkBufferPtrLo; copies H to
; wLinkBufferPtrHi; sets wLinkBufferCountLo to 8; sets wLinkSendByte to $ff; advances wBattleStep
; (E-0347)
; why: step 1 of RunBattlePhaseWhenTextIdle_A0_SyncLink (when wBattleStep = 1);
; RunBattlePhaseWhenTextIdle_A0_SyncLink: by wBattleStep: exchanges bytes and messages over the link
; ('Please wait.') (E-0352)
RunBattlePhaseWhenTextIdle_A0_SyncLink_WaitLinkMessage::
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

; step 2 of RunBattlePhaseWhenTextIdle_A0_SyncLink: returns unless wLinkMessage is $f0; branches on
; wLinkRole; copies wLinkPartnerName to wBattleSlotOut; advances wBattleStep; sets wLinkSendByte to
; 0 (E-0347)
; why: step 2 of RunBattlePhaseWhenTextIdle_A0_SyncLink (when wBattleStep = 2);
; RunBattlePhaseWhenTextIdle_A0_SyncLink: by wBattleStep: exchanges bytes and messages over the link
; ('Please wait.') (E-0352)
RunBattlePhaseWhenTextIdle_A0_SyncLink_WaitLinkMessage_2::
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

; step 3 of RunBattlePhaseWhenTextIdle_A0_SyncLink: sets wLinkRuleTurnLimit to $63; branches on the
; byte at wBattleSlotOut; branches on the byte at wBattleStatus; branches on the byte at
; wBattleSlotOut + $1; branches on the byte at wBattleStatus; sets wStringIndex; sets
; wStringCategory to 6; calls BeginStringDisplay_Bank07; advances wBattleStep; plays music $02;
; advances wBattlePhase; sets wBattleStep to 0; then 1 more step (see the code) (E-0347)
; why: step 3 of RunBattlePhaseWhenTextIdle_A0_SyncLink (when wBattleStep = 3);
; RunBattlePhaseWhenTextIdle_A0_SyncLink: by wBattleStep: exchanges bytes and messages over the link
; ('Please wait.') (E-0352)
RunBattlePhaseWhenTextIdle_A0_SyncLink_AddAx9ToHL::
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

; step 4 of RunBattlePhaseWhenTextIdle_A0_SyncLink: returns unless wTextFlags is 0; branches on
; wScreenCountPlusOne; increments wScreenCountPlusOne; calls
; RunBattlePhaseWhenTextIdle_A0_SyncLink_CarryUnlessBattleSlotOutSlotEmpty; calls
; DrawSlotStatusMarks; calls CopySlotPanelRowToVRAM; calls DrawSlotHPDigits; calls
; CopySlotPanelPartToVRAM; calls DrawSlotMPDigits; calls CopySlotPanelPartToVRAM_2; calls
; DrawSlotStatusMarks; calls CopySlotPanelRowToVRAM; then 12 more steps (see the code) (E-0347)
; why: step 4 of RunBattlePhaseWhenTextIdle_A0_SyncLink (when wBattleStep = 4);
; RunBattlePhaseWhenTextIdle_A0_SyncLink: by wBattleStep: exchanges bytes and messages over the link
; ('Please wait.') (E-0352)
RunBattlePhaseWhenTextIdle_A0_SyncLink_PleaseWait::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, [wScreenCountPlusOne]
    cp $02
    jp z, .skip
    inc a
    ld [wScreenCountPlusOne], a
    farcall RunBattlePhaseWhenTextIdle_A0_SyncLink_CarryUnlessBattleSlotOutSlotEmpty
    ld c, $00
    farcall DrawSlotStatusMarks
    farcall CopySlotPanelRowToVRAM
    ld c, $00
    farcall DrawSlotHPDigits
    farcall CopySlotPanelPartToVRAM
    ld c, $00
    farcall DrawSlotMPDigits
    farcall CopySlotPanelPartToVRAM_2
    ld c, $01
    farcall DrawSlotStatusMarks
    farcall CopySlotPanelRowToVRAM
    ld c, $01
    farcall DrawSlotHPDigits
    farcall CopySlotPanelPartToVRAM
    ld c, $01
    farcall DrawSlotMPDigits
    farcall CopySlotPanelPartToVRAM_2
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

; step 5 of RunBattlePhaseWhenTextIdle_A0_SyncLink: branches on rSTAT; sets vBGMap0 + $e1 to $c3;
; branches on rSTAT; advances wBattleStep; also changes HL, DE, BC and A by register arithmetic
; (E-0347)
; why: step 5 of RunBattlePhaseWhenTextIdle_A0_SyncLink (when wBattleStep = 5);
; RunBattlePhaseWhenTextIdle_A0_SyncLink: by wBattleStep: exchanges bytes and messages over the link
; ('Please wait.') (E-0352)
RunBattlePhaseWhenTextIdle_A0_SyncLink_ReadSTAT::
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

; step 6 of RunBattlePhaseWhenTextIdle_A0_SyncLink: branches on wIsCGB; sets rVBK to 1; branches on
; rSTAT; sets vBGMap0 + $e1 to 0; branches on rSTAT; sets rVBK to 0; advances wBattleStep; also
; changes HL, DE, BC and A by register arithmetic (E-0347)
; why: step 6 of RunBattlePhaseWhenTextIdle_A0_SyncLink (when wBattleStep = 6);
; RunBattlePhaseWhenTextIdle_A0_SyncLink: by wBattleStep: exchanges bytes and messages over the link
; ('Please wait.') (E-0352)
RunBattlePhaseWhenTextIdle_A0_SyncLink_WriteVBK::
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

; step 7 of RunBattlePhaseWhenTextIdle_A0_SyncLink: advances wBattleStep; sets wLinkSendByte to 1
; (E-0347)
; why: step 7 of RunBattlePhaseWhenTextIdle_A0_SyncLink (when wBattleStep = 7);
; RunBattlePhaseWhenTextIdle_A0_SyncLink: by wBattleStep: exchanges bytes and messages over the link
; ('Please wait.') (E-0352)
RunBattlePhaseWhenTextIdle_A0_SyncLink_SetBattleStep::
    ld hl, wBattleStep
    inc [hl]
    ld a, $01
    ld [wLinkSendByte], a
    ret

; step 8 of RunBattlePhaseWhenTextIdle_A0_SyncLink: returns unless wLinkMessage is $01; sets
; wLinkSendByte to 0; sets wBattlePhase to 0; sets wBattleStep to 0 (E-0347)
; why: step 8 of RunBattlePhaseWhenTextIdle_A0_SyncLink (when wBattleStep = 8);
; RunBattlePhaseWhenTextIdle_A0_SyncLink: by wBattleStep: exchanges bytes and messages over the link
; ('Please wait.') (E-0352)
RunBattlePhaseWhenTextIdle_A0_SyncLink_WaitLinkMessage_SetLinkSendByte::
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

; for each party member with a battle entry in wBattleStateBuffer, writes two words to SRAM record
; offsets $5B and $5F and one byte to $55, then ClampPartyHPAndMPToMax (E-0289)
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

; by wBattleStep: the results screen ('RESULTS ... Level Turns Win Rank', the rank letters
; 'GFEDCBAS', "0's G fell by W.", 'received WG.') (E-0288)
RunBattlePhaseWhenTextIdle_A0_ResultsScreen::
    ld a, [wBattleStep]
    jumptable
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_SetTextSpeedTo01
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_RunBackupAndSaveSteps
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_CopyScreenTileBufferToVRAM_A0
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_ShowString_Bank07
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_DrawRectAndWriteDATiles
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_CopyScreenTileBufferToVRAM_A0_FillTilesRequest
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_CopyF0StringFromTableToTextBuf1
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_CopyF0StringFromTableToTextBuf1_2
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_ShowReceivedWG
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_BlankPartnerRecord
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_FadeOut

; step 0 of RunBattlePhaseWhenTextIdle_A0_ResultsScreen: sets wTextSpeed to 1; copies L to
; wResultsUnreadWordLo; copies H to wResultsUnreadWordHi; branches on C & $30; branches on C & $21;
; branches on C & $12; branches on the byte at wBattleSlotOut; sets wBattleResultStep to 3; copies
; wBattleResultDelay to wBattleResultCounter; calls ComputeBattleResultRank; calls
; ApplyBattleResultStatChanges; sets wSaveStep to 0; then 4 more steps (see the code) (E-0347)
; why: step 0 of RunBattlePhaseWhenTextIdle_A0_ResultsScreen (when wBattleStep = 0);
; RunBattlePhaseWhenTextIdle_A0_ResultsScreen: by wBattleStep: the results screen ('RESULTS ...
; Level Turns Win Rank', the rank letters 'GFEDCBAS', "0's G fell by W.", 'received WG.') (E-0352)
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_SetTextSpeedTo01::
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

; step 1 of RunBattlePhaseWhenTextIdle_A0_ResultsScreen: calls RunBackupAndSaveSteps; returns unless
; bit 7 of wSaveStep is set; calls SaveGameToSRAMWithChecksum; sets wStringIndex; sets
; wStringCategory to 5; calls BeginStringDisplay_Bank07; advances wBattleStep (E-0347)
; why: step 1 of RunBattlePhaseWhenTextIdle_A0_ResultsScreen (when wBattleStep = 1);
; RunBattlePhaseWhenTextIdle_A0_ResultsScreen: by wBattleStep: the results screen ('RESULTS ...
; Level Turns Win Rank', the rank letters 'GFEDCBAS', "0's G fell by W.", 'received WG.') (E-0352)
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_RunBackupAndSaveSteps::
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

; step 2 of RunBattlePhaseWhenTextIdle_A0_ResultsScreen: returns unless wTextFlags is 0; calls
; FillBytes; calls CopyScreenTileBufferToVRAM_A0; advances wBattleStep (E-0347)
; why: step 2 of RunBattlePhaseWhenTextIdle_A0_ResultsScreen (when wBattleStep = 2);
; RunBattlePhaseWhenTextIdle_A0_ResultsScreen: by wBattleStep: the results screen ('RESULTS ...
; Level Turns Win Rank', the rank letters 'GFEDCBAS', "0's G fell by W.", 'received WG.') (E-0352)
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_CopyScreenTileBufferToVRAM_A0::
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

; step 3 of RunBattlePhaseWhenTextIdle_A0_ResultsScreen: copies L to wTextWindowTileLo; copies H to
; wTextWindowTileHi; copies L to wTextWindowRows; copies H to wTextWindowWidth; sets wStringCategory
; to 1; sets wStringIndex to 3; calls ShowString_Bank07; copies L to wTextWindowTileLo; copies H to
; wTextWindowTileHi; copies L to wTextWindowRows; copies H to wTextWindowWidth; sets wStringCategory
; to 1; then 3 more steps (see the code) (E-0347)
; why: step 3 of RunBattlePhaseWhenTextIdle_A0_ResultsScreen (when wBattleStep = 3);
; RunBattlePhaseWhenTextIdle_A0_ResultsScreen: by wBattleStep: the results screen ('RESULTS ...
; Level Turns Win Rank', the rank letters 'GFEDCBAS', "0's G fell by W.", 'received WG.') (E-0352)
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_ShowString_Bank07::
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

; step 4 of RunBattlePhaseWhenTextIdle_A0_ResultsScreen: calls DrawRectAndWriteDATiles; branches on
; E; calls WriteTwoDigitsBlankLeading_A0; sets wWindowTileBuffer; calls WriteThreeTwoDigitRows;
; advances wBattleStep; also changes HL, DE and A by register arithmetic (E-0347)
; why: step 4 of RunBattlePhaseWhenTextIdle_A0_ResultsScreen (when wBattleStep = 4);
; RunBattlePhaseWhenTextIdle_A0_ResultsScreen: by wBattleStep: the results screen ('RESULTS ...
; Level Turns Win Rank', the rank letters 'GFEDCBAS', "0's G fell by W.", 'received WG.') (E-0352)
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_DrawRectAndWriteDATiles::
    call DrawRectAndWriteDATiles
    ld a, [wBattleResultStep]
    ld hl, RunBattlePhaseWhenTextIdle_A0_ResultsScreen_DrawRectAndWriteDATiles_Data
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

; three WriteTwoDigitsFromDEStepRow calls: three numbers from DE, one per row (E-0289)
WriteThreeTwoDigitRows::
    call WriteTwoDigitsFromDEStepRow
    call WriteTwoDigitsFromDEStepRow
    call WriteTwoDigitsFromDEStepRow

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

; data read by RunBattlePhaseWhenTextIdle_A0_ResultsScreen_DrawRectAndWriteDATiles (8 bytes)
; (E-0347)
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_DrawRectAndWriteDATiles_Data::
    db $04, $f7, $04, $0e, $04, $12, $04, $16

; step 5 of RunBattlePhaseWhenTextIdle_A0_ResultsScreen: calls CopyScreenTileBufferToVRAM_A0; calls
; FillTilesRequest; calls CopyBytes; advances wBattleStep (E-0347)
; why: step 5 of RunBattlePhaseWhenTextIdle_A0_ResultsScreen (when wBattleStep = 5);
; RunBattlePhaseWhenTextIdle_A0_ResultsScreen: by wBattleStep: the results screen ('RESULTS ...
; Level Turns Win Rank', the rank letters 'GFEDCBAS', "0's G fell by W.", 'received WG.') (E-0352)
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_CopyScreenTileBufferToVRAM_A0_FillTilesRequest::
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

; step 6 of RunBattlePhaseWhenTextIdle_A0_ResultsScreen: advances wBattleStep; continues in
; RunBattlePhaseWhenTextIdle_A0_ResultsScreen_CopyF0StringFromTableToTextBuf1_2_ReadBattleSubPhase;
; calls CopyF0StringFromTableToTextBuf1; calls WriteDecimalByteString; branches on
; wBattleResultStep; sets wStringIndex to $15; sets wStringCategory to 5; calls
; BeginStringDisplay_Bank07; advances wBattleStep (E-0347)
; why: step 6 of RunBattlePhaseWhenTextIdle_A0_ResultsScreen (when wBattleStep = 6);
; RunBattlePhaseWhenTextIdle_A0_ResultsScreen: by wBattleStep: the results screen ('RESULTS ...
; Level Turns Win Rank', the rank letters 'GFEDCBAS', "0's G fell by W.", 'received WG.') (E-0352)
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_CopyF0StringFromTableToTextBuf1::
    ld a, [wWorkBuf + $9]
    cp $ff
    jr nz, .call_copy_f0_string_from_table_to_text_buf1
    ld hl, wBattleStep
    inc [hl]
    jr RunBattlePhaseWhenTextIdle_A0_ResultsScreen_CopyF0StringFromTableToTextBuf1_2_ReadBattleSubPhase

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

; step 7 of RunBattlePhaseWhenTextIdle_A0_ResultsScreen: returns unless wTextFlags is 0 (E-0347)
; why: step 7 of RunBattlePhaseWhenTextIdle_A0_ResultsScreen (when wBattleStep = 7);
; RunBattlePhaseWhenTextIdle_A0_ResultsScreen: by wBattleStep: the results screen ('RESULTS ...
; Level Turns Win Rank', the rank letters 'GFEDCBAS', "0's G fell by W.", 'received WG.') (E-0352)
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_CopyF0StringFromTableToTextBuf1_2::
    ld a, [wTextFlags]
    or a
    ret nz

; Calls CopyF0StringFromTableToTextBuf1; calls WriteDecimalByteString; sets wStringCategory to 5;
; sets wStringIndex to $15; calls BeginStringDisplay_Bank07; increments wBattleSubPhase; returns if
; wBattleSubPhase is below $06; sets wBattleSubPhase to 0; advances wBattleStep (E-0347)
; why: part of RunBattlePhaseWhenTextIdle_A0_ResultsScreen_CopyF0StringFromTableToTextBuf1_2, in
; step 7 of RunBattlePhaseWhenTextIdle_A0_ResultsScreen (when wBattleStep = 7);
; RunBattlePhaseWhenTextIdle_A0_ResultsScreen: by wBattleStep: the results screen ('RESULTS ...
; Level Turns Win Rank', the rank letters 'GFEDCBAS', "0's G fell by W.", 'received WG.') (E-0352)
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_CopyF0StringFromTableToTextBuf1_2_ReadBattleSubPhase::
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

; step 8 of RunBattlePhaseWhenTextIdle_A0_ResultsScreen: returns unless wTextFlags is 0; sets
; hTemp0; sets hTemp1; sets hTemp2 to 0; calls WriteNumber24AsDecimalString; sets wStringCategory to
; 5; sets wStringIndex to $16; calls BeginStringDisplay_Bank07; sets wBattleSubPhase to 0; sets
; wLinkSendByte to 0; advances wBattleStep; returns if wBattleResultStep is $01; then 1 more step
; (see the code) (E-0347)
; why: step 8 of RunBattlePhaseWhenTextIdle_A0_ResultsScreen (when wBattleStep = 8);
; RunBattlePhaseWhenTextIdle_A0_ResultsScreen: by wBattleStep: the results screen ('RESULTS ...
; Level Turns Win Rank', the rank letters 'GFEDCBAS', "0's G fell by W.", 'received WG.') (E-0352)
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_ShowReceivedWG::
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

; waits for the text, then fills record buffer B with '???' names and $FF species
; (WriteUnknownNamePlaceholder) (E-0303)
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_BlankPartnerRecord::
    ld a, [wBattleSubPhase]
    jumptable
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_BlankPartnerRecord_WaitTextFlags
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_BlankPartnerRecord_WaitLinkMessage

; step 0 of RunBattlePhaseWhenTextIdle_A0_ResultsScreen_BlankPartnerRecord: returns unless
; wTextFlags is 0; sets wLinkSendByte to 1; advances wBattleSubPhase (E-0347)
; why: step 0 of RunBattlePhaseWhenTextIdle_A0_ResultsScreen_BlankPartnerRecord (when
; wBattleSubPhase = 0); RunBattlePhaseWhenTextIdle_A0_ResultsScreen_BlankPartnerRecord: waits for
; the text, then fills record buffer B with '???' names and $FF species
; (WriteUnknownNamePlaceholder) (E-0352)
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_BlankPartnerRecord_WaitTextFlags::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; step 1 of RunBattlePhaseWhenTextIdle_A0_ResultsScreen_BlankPartnerRecord: returns unless
; wLinkMessage is $01; sets wBattleScene to 8; calls CopyBytes; sets wRecordBufB to 1; sets
; wRecordBufB + MON_PARENT1_SPECIES to $ff; sets wRecordBufB + MON_PARENT2_SPECIES to $ff; calls
; WriteUnknownNamePlaceholder; sets wRecordBufB + MON_UNUSED_28 to $ff; calls
; WriteUnknownNamePlaceholder; sets wRecordBufB + MON_UNUSED_33 to $ff; calls
; AppendMappedSkillsToRecordBufBSkillList; sets wRecordBufB + MON_STATUS to 0; then 40 more steps
; (see the code) (E-0347)
; why: step 1 of RunBattlePhaseWhenTextIdle_A0_ResultsScreen_BlankPartnerRecord (when
; wBattleSubPhase = 1); RunBattlePhaseWhenTextIdle_A0_ResultsScreen_BlankPartnerRecord: waits for
; the text, then fills record buffer B with '???' names and $FF species
; (WriteUnknownNamePlaceholder) (E-0352)
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_BlankPartnerRecord_WaitLinkMessage::
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

; waits for the text, then starts the palette fade (E-0303)
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_FadeOut::
    ld a, [wBattleSubPhase]
    jumptable
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_FadeOut_WaitTextFlags
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_FadeOut_StartPaletteFade

; step 0 of RunBattlePhaseWhenTextIdle_A0_ResultsScreen_FadeOut: returns unless wTextFlags is 0;
; sets wLinkSendByte to 1; advances wBattleSubPhase (E-0347)
; why: step 0 of RunBattlePhaseWhenTextIdle_A0_ResultsScreen_FadeOut (when wBattleSubPhase = 0);
; RunBattlePhaseWhenTextIdle_A0_ResultsScreen_FadeOut: waits for the text, then starts the palette
; fade (E-0352)
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_FadeOut_WaitTextFlags::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; step 1 of RunBattlePhaseWhenTextIdle_A0_ResultsScreen_FadeOut: returns unless wLinkMessage is $01;
; calls StartPaletteFade; sets wGameMode to 5; sets wModeState to 1; sets wWorldMapState to 0; sets
; wGameMode2Arg to 0; sets wScreenState to 0; increments wModeChangeRequest; sets wLinkSession to 0;
; sets wLinkExchangeState to 0; sets wLinkRole to 0; sets wLinkStatus to 0; then 4 more steps (see
; the code) (E-0347)
; why: step 1 of RunBattlePhaseWhenTextIdle_A0_ResultsScreen_FadeOut (when wBattleSubPhase = 1);
; RunBattlePhaseWhenTextIdle_A0_ResultsScreen_FadeOut: waits for the text, then starts the palette
; fade (E-0352)
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_FadeOut_StartPaletteFade::
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

; data read by CopyF0StringFromTableToTextBuf1 (34 bytes) (E-0347)
CopyF0StringFromTableToTextBuf1_Data::
    db $56, $5a, $59, $5a, $5c, $5a, $60, $5a, $64, $5a, $68, $5a, $11, $19, $f0, $16
    db $19, $f0, $0a, $1d, $14, $f0, $0d, $0e, $0f, $f0, $0a, $10, $15, $f0, $12, $17
    db $1d, $f0

; adds 1 (up to 99) to battle result counter wBattleResultStep of the four at $C895-$C898
; (wKeyNameBuf, wKeyNameBuf+1, wBattleResultCount2, wBattleResultCount3); band = (counter 0 +
; counter 1) * 10 / (sum of all four) to wWorkBuf and wWildBand; adds BattleResultBandAdjust[band
; bracket] and BattleResultTurnLimitAdjust[wLinkRuleTurnLimit bracket] to wWildLevel, clamped to
; 0-99; the rank 0-7 (count of BattleResultRankThresholds at or below it) goes to wWorkBuf+1 and
; wEncounterClass and is shown as one of 'GFEDCBAS' (E-0289, E-0314)
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

; by wBattleResultStep: results 0 and 1 raise the lowest of five record words by
; BattleResultStatBonusByRank[rank] (capped at 999) and take a word from BattleResultGoldByRank;
; result 2 lowers the highest by BattleResultStatPenaltyByRank[rank]; others lower all five; the
; word (or 1000) goes to wWorkBuf+$10 (E-0289)
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
    jr z, .call_offset_by_index_of_min_of_five_words
    cp $01
    jr z, .call_offset_by_index_of_min_of_five_words
    cp $02
    jr z, .call_offset_by_index_of_max_of_five_words
    jr .read_work_buf

.call_offset_by_index_of_min_of_five_words:
    call OffsetByIndexOfMinOfFiveWords
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

.call_offset_by_index_of_max_of_five_words:
    call OffsetByIndexOfMaxOfFiveWords
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

; finds the entry with the smallest of five words after HL (ties broken randomly), stores its index
; in wWorkBuf + $9 and returns HL + OffsetByIndexOfMinOfFiveWords_Data[index] (E-0122)
OffsetByIndexOfMinOfFiveWords::
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
    ld hl, OffsetByIndexOfMinOfFiveWords_Data
    add_a_to_hl
    ld a, [hl]
    pop hl
    add_a_to_hl
    ret

; next table entry: D += 1; if its word is below BC (or equal and RollChance80Of256 succeeds), BC =
; word and E = D (E-0122)
KeepMinWordEntry::
    inc hl
    inc d
    ld a, [hli]
    push hl
    ld h, [hl]
    ld l, a
    call CompareHLToBC
    call z, RollChance80Of256
    jr nc, .done
    ld b, h
    ld c, l
    ld e, d

.done:
    pop hl
    ret

; finds the entry with the largest of five words after HL (ties broken randomly), stores its index
; in wWorkBuf + $9 and returns HL + OffsetByIndexOfMinOfFiveWords_Data[index] (E-0122)
OffsetByIndexOfMaxOfFiveWords::
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
    ld hl, OffsetByIndexOfMinOfFiveWords_Data
    add_a_to_hl
    ld a, [hl]
    pop hl
    add_a_to_hl
    ret

; next table entry: D += 1; if its word is not below BC (equal only when RollChance80Of256 fails),
; BC = word and E = D (E-0122)
KeepMaxWordEntry::
    inc hl
    inc d
    ld a, [hli]
    push hl
    ld h, [hl]
    ld l, a
    call CompareHLToBC
    call z, RollChance80Of256
    jr c, .done
    ld b, h
    ld c, l
    ld e, d

.done:
    pop hl
    ret

; AdvanceRandom, then compares wRandomLo with $80: carry (success) half the time (E-0116)
RollChance80Of256::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $80
    ret

; data read by OffsetByIndexOfMinOfFiveWords (6 bytes) (E-0347)
OffsetByIndexOfMinOfFiveWords_Data::
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

; called from RunBattlePhaseWhenTextIdle_A0_RunTurn_FillBytesAndStep: sets bit 7 of wSideControl;
; calls FillBytes; sets wBattleItemTarget to $ff; sets wBattleItemId to $ff; sets wMenuState to 0;
; branches on the byte at wSlotMarks; branches on C; advances wBattleStep; calls
; CarryUnlessBattleSlotOutSlotEmpty; calls CheckSlotStatusBlock; also changes HL, BC, A and E by
; register arithmetic (E-0347)
; why: a helper of RunBattlePhaseWhenTextIdle_A0_RunTurn_FillBytesAndStep, in step 0 of
; RunBattlePhaseWhenTextIdle_A0_RunTurn (when wBattleStep = 0);
; RunBattlePhaseWhenTextIdle_A0_RunTurn: by wBattleStep: clears a buffer, then
; RunBattleSetup_BankA0, the command entry (bank $A1), RunBattleActions and RunBattleStep4 (E-0352)
RunBattlePhaseWhenTextIdle_A0_RunTurn_FillBytes::
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

; the same instruction sequence as RunBattleSetup (bank $31) apart from label operands, which refer
; to this bank's own routines and tables; the twin's note describes the shape (E-0107)
RunBattleSetup_BankA0::
    ld a, [wBattleSubPhase]
    jumptable
    dw RunBattleSetup_BankA0_EntrySelect
    dw RunBattleSetup_BankA0_CommandMenu
    dw RunBattleSetup_BankA0_Return
    dw RunBattleSetup_BankA0_ClearAndLayoutTileBlocksForBattleFoeCount
    dw RunBattleSetup_BankA0_ShowSelectingHeroSMove
    dw RunBattleSetup_BankA0_AdvanceRandom
    dw RunBattleSetup_BankA0_WaitLinkMessage
    dw RunBattleSetup_BankA0_SetBattleSubPhase
    dw RunBattleSetup_BankA0_WaitLinkMessage_SetLinkSendByte
    dw RunBattleSetup_BankA0_WriteLinkSendByteAndCounterPtr0Lo
    dw RunBattleSetup_BankA0_WriteCounterPtr0HiAndLinkSendByte
    dw RunBattleSetup_BankA0_WriteLinkSendByteAndBattleSubPhase
    dw RunBattleSetup_BankA0_FillTilesFromRequest

; by wBattleResolveStep: lays out the tile blocks for the foe count and moves a selection over
; entries, setting or clearing bit 6 and the entry tile (SetBit6AndBlankEntryTile_BankA0,
; ClearBit6AndCursorEntryTile_BankA0) (E-0304)
RunBattleSetup_BankA0_EntrySelect::
    ld a, [wBattleResolveStep]
    jumptable
    dw RunBattleSetup_BankA0_EntrySelect_ClearAndLayoutTileBlocksForBattleFoeCount
    dw RunBattleSetup_BankA0_EntrySelect_ToCopyRect32StrideToVRAM_BankA0_AdvanceBattleResolveStep
    dw RunBattleSetup_BankA0_EntrySelect_ClearAndLayoutTileBlocksForBattleFoeCount_2
    dw RunBattleSetup_BankA0_EntrySelect_ToCopyRect32StrideToVRAM_BankA0AndStep
    dw RunBattleSetup_BankA0_EntrySelect_WriteBattleSetupDBAndStringIndexEtc
    dw RunBattleSetup_BankA0_EntrySelect_CopyRectRecordToScreenBufferAndStep
    dw RunBattleSetup_BankA0_EntrySelect_ToBeginStringDisplay_Bank2FAndStep
    dw RunBattleSetup_BankA0_EntrySelect_ClearAndLayoutTileBlocksForBattleFoeCount_3

; step 0 of RunBattleSetup_BankA0_EntrySelect: sets bit 7 of wSideControl; calls
; ClearAndLayoutTileBlocksForBattleFoeCount; calls DrawScreenTileBufferRow11Col4RowsToBGMapRow7;
; sets wStringCategory to 2; sets wStringIndex to 0; calls ShowStringBank09AtTilesHL_BankA0; calls
; CopyRectRecordToScreenBuffer_2; advances wBattleResolveStep (E-0347)
; why: step 0 of RunBattleSetup_BankA0_EntrySelect (when wBattleResolveStep = 0);
; RunBattleSetup_BankA0_EntrySelect: by wBattleResolveStep: lays out the tile blocks for the foe
; count and moves a selection over entries, setting or clearing bit 6 and the ... (E-0352)
RunBattleSetup_BankA0_EntrySelect_ClearAndLayoutTileBlocksForBattleFoeCount::
    ld hl, wSideControl
    set 7, [hl]
    inc hl
    set 7, [hl]
    inc hl
    set 7, [hl]
    inc hl
    set 7, [hl]
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    farcall DrawScreenTileBufferRow11Col4RowsToBGMapRow7
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

; step 1 of RunBattleSetup_BankA0_EntrySelect: calls
; RunBattleSetup_BankA0_EntrySelect_ToCopyRect32StrideToVRAM_BankA0; calls WriteVRAMByte; advances
; wBattleResolveStep; also changes HL, DE and A by register arithmetic (E-0347)
; why: step 1 of RunBattleSetup_BankA0_EntrySelect (when wBattleResolveStep = 1);
; RunBattleSetup_BankA0_EntrySelect: by wBattleResolveStep: lays out the tile blocks for the foe
; count and moves a selection over entries, setting or clearing bit 6 and the ... (E-0352)
RunBattleSetup_BankA0_EntrySelect_ToCopyRect32StrideToVRAM_BankA0_AdvanceBattleResolveStep::
    call RunBattleSetup_BankA0_EntrySelect_ToCopyRect32StrideToVRAM_BankA0
    ld hl, RunBattleSetup_BankA0_EntrySelect_ToCopyRect32StrideToVRAM_BankA0_Data
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

; step 2 of RunBattleSetup_BankA0_EntrySelect: calls
; RunBattleSetup_BankA0_EntrySelect_SetBit6AndBlankEntryTile_BankA0; branches on wJoypadPressed;
; plays sound $69; calls FillBytes; calls ClearAndLayoutTileBlocksForBattleFoeCount; advances
; wBattleResolveStep (E-0347)
; why: step 2 of RunBattleSetup_BankA0_EntrySelect (when wBattleResolveStep = 2);
; RunBattleSetup_BankA0_EntrySelect: by wBattleResolveStep: lays out the tile blocks for the foe
; count and moves a selection over entries, setting or clearing bit 6 and the ... (E-0352)
RunBattleSetup_BankA0_EntrySelect_ClearAndLayoutTileBlocksForBattleFoeCount_2::
    ld de, RunBattleSetup_BankA0_EntrySelect_ToCopyRect32StrideToVRAM_BankA0_Data
    ld hl, wMenuState
    call RunBattleSetup_BankA0_EntrySelect_SetBit6AndBlankEntryTile_BankA0
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

; step 3 of RunBattleSetup_BankA0_EntrySelect: calls
; RunBattleSetup_BankA0_EntrySelect_ToCopyRect32StrideToVRAM_BankA0; advances wBattleResolveStep
; (E-0347)
; why: step 3 of RunBattleSetup_BankA0_EntrySelect (when wBattleResolveStep = 3);
; RunBattleSetup_BankA0_EntrySelect: by wBattleResolveStep: lays out the tile blocks for the foe
; count and moves a selection over entries, setting or clearing bit 6 and the ... (E-0352)
RunBattleSetup_BankA0_EntrySelect_ToCopyRect32StrideToVRAM_BankA0AndStep::
    call RunBattleSetup_BankA0_EntrySelect_ToCopyRect32StrideToVRAM_BankA0
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; step 4 of RunBattleSetup_BankA0_EntrySelect: copies wMenuState & $03 to wBattleSetupDB; branches
; on wMenuState & $03; calls RunBattleSetup_BankA0_EntrySelect_ReadLinkRole; sets wBattleSubPhase to
; 3; sets wBattleResolveStep to 0; branches on the byte at wSlotMarks; sets wStringCategory to 0;
; sets wStringIndex to $2d; advances wBattleResolveStep; copies C to wCommandMonster; sets
; wBattleSubPhase to 1; sets wBattleResolveStep to 0; then 3 more steps (see the code) (E-0347)
; why: step 4 of RunBattleSetup_BankA0_EntrySelect (when wBattleResolveStep = 4);
; RunBattleSetup_BankA0_EntrySelect: by wBattleResolveStep: lays out the tile blocks for the foe
; count and moves a selection over entries, setting or clearing bit 6 and the ... (E-0352)
RunBattleSetup_BankA0_EntrySelect_WriteBattleSetupDBAndStringIndexEtc::
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
    call RunBattleSetup_BankA0_EntrySelect_ReadLinkRole
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

; called from RunBattleSetup_BankA0_EntrySelect_WriteBattleSetupDBAndStringIndexEtc: changes HL and
; A (E-0347)
; why: a helper of RunBattleSetup_BankA0_EntrySelect_WriteBattleSetupDBAndStringIndexEtc, in step 4
; of RunBattleSetup_BankA0_EntrySelect (when wBattleResolveStep = 4);
; RunBattleSetup_BankA0_EntrySelect: by wBattleResolveStep: lays out the tile blocks for the foe
; count and moves a selection over entries, setting or clearing bit 6 and the ... (E-0352)
RunBattleSetup_BankA0_EntrySelect_ReadLinkRole::
    ld a, [wLinkRole]
    and $02
    ld hl, wBattleActionChoice
    add_a_to_hl
    ld a, $ff
    ld [hli], a
    ld [hli], a
    ret

; step 5 of RunBattleSetup_BankA0_EntrySelect: calls RunBattleSetup_BankA0_ReadSTAT; calls
; CopyRectRecordToScreenBuffer; calls DrawWindowTileBufferRow2Col16RowsToBGMapRow13_BankA0; advances
; wBattleResolveStep (E-0347)
; why: step 5 of RunBattleSetup_BankA0_EntrySelect (when wBattleResolveStep = 5);
; RunBattleSetup_BankA0_EntrySelect: by wBattleResolveStep: lays out the tile blocks for the foe
; count and moves a selection over entries, setting or clearing bit 6 and the ... (E-0352)
RunBattleSetup_BankA0_EntrySelect_CopyRectRecordToScreenBufferAndStep::
    call RunBattleSetup_BankA0_ReadSTAT
    farcall CopyRectRecordToScreenBuffer
    call DrawWindowTileBufferRow2Col16RowsToBGMapRow13_BankA0
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; step 6 of RunBattleSetup_BankA0_EntrySelect: calls BeginStringDisplay_Bank2F; advances
; wBattleResolveStep (E-0347)
; why: step 6 of RunBattleSetup_BankA0_EntrySelect (when wBattleResolveStep = 6);
; RunBattleSetup_BankA0_EntrySelect: by wBattleResolveStep: lays out the tile blocks for the foe
; count and moves a selection over entries, setting or clearing bit 6 and the ... (E-0352)
RunBattleSetup_BankA0_EntrySelect_ToBeginStringDisplay_Bank2FAndStep::
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; step 7 of RunBattleSetup_BankA0_EntrySelect: returns unless wTextFlags is 0; calls
; ClearAndLayoutTileBlocksForBattleFoeCount; calls
; DrawWindowTileBufferRow2Col16RowsToBGMapRow13_BankA0; calls CopyRectRecordToScreenBuffer_2; sets
; wBattleResolveStep to 1 (E-0347)
; why: step 7 of RunBattleSetup_BankA0_EntrySelect (when wBattleResolveStep = 7);
; RunBattleSetup_BankA0_EntrySelect: by wBattleResolveStep: lays out the tile blocks for the foe
; count and moves a selection over entries, setting or clearing bit 6 and the ... (E-0352)
RunBattleSetup_BankA0_EntrySelect_ClearAndLayoutTileBlocksForBattleFoeCount_3::
    ld a, [wTextFlags]
    or a
    ret nz
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    call DrawWindowTileBufferRow2Col16RowsToBGMapRow13_BankA0
    farcall CopyRectRecordToScreenBuffer_2
    ld a, $01
    ld [wBattleResolveStep], a
    ret

; by wBattleResolveStep: the bank-$A0 copy of RunBattleSetup_CommandMenu (command windows, 'It has
; no usable ...') (E-0288)
RunBattleSetup_BankA0_CommandMenu::
    ld a, [wBattleResolveStep]
    jumptable
    dw RunBattleSetup_BankA0_CommandMenu_ShowStringBank09AtTilesHL_BankA0
    dw RunBattleSetup_BankA0_CommandMenu_WriteMenuSubStateAndListLastPageSize
    dw RunBattleSetup_BankA0_CommandMenu_WriteBattleArg1AndBattleResolveStepEtc
    dw RunBattleSetup_BankA0_CommandMenu_WriteBattleResolveStepAndBattleSubPhase
    dw RunBattleSetup_BankA0_CommandMenu_WriteBattleArg1AndStringCategoryEtc
    dw RunBattleSetup_BankA0_CommandMenu_ReadMenuSelectedMember
    dw RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount
    dw RunBattleSetup_BankA0_CommandMenu_WriteBattleResolveStep
    dw RunBattleSetup_BankA0_CommandMenu_CallDrawScreenTileBufferRow14Col8Rect11x9ToBGMapRow9_BankA0
    dw RunBattleSetup_BankA0_CommandMenu_ShowItHasNoUsable
    dw RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount_AdvanceBattleResolveStep
    dw RunBattleSetup_BankA0_CommandMenu_WriteBattleResolveStep_DrawWindowTileBufferRow2Col16RowsToBGMapRow13_BankA0
    dw RunBattleSetup_BankA0_CommandMenu_WriteBattleArg1AndMenuCursorEtc
    dw RunBattleSetup_BankA0_CommandMenu_WriteListLastPageSize
    dw RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount_2
    dw RunBattleSetup_BankA0_CommandMenu_WriteBattleResolveStepAndBattleArg1
    dw RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount_3
    dw RunBattleSetup_BankA0_CommandMenu_WriteStringCategory
    dw RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount_AdvanceBattleResolveStep_2
    dw RunBattleSetup_BankA0_CommandMenu_WriteBattleResolveStep_2
    dw RunBattleSetup_BankA0_CommandMenu_SetBattleResolveStep
    dw RunBattleSetup_BankA0_CommandMenu_CallDrawScreenTileBufferRow14Col8Rect11x9ToBGMapRow9_BankA0
    dw RunBattleSetup_BankA0_CommandMenu_ShowButThereIsNo
    dw RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount_AdvanceBattleResolveStep
    dw RunBattleSetup_BankA0_CommandMenu_WriteBattleResolveStep_DrawWindowTileBufferRow2Col16RowsToBGMapRow13_BankA0

; step 0 of RunBattleSetup_BankA0_CommandMenu: sets wStringCategory to 2; sets wStringIndex to 1;
; calls ShowStringBank09AtTilesHL_BankA0; sets wStringIndex to 8; calls
; ShowStringBank09AtTilesHL_BankA0; sets wCommandPageCount to 0; sets wCommandCursorMax to 3; sets
; wCommandCursor to 0; calls CopyRectRecordToScreenBuffer_4; calls WriteFiveTilesFromTable_2;
; advances wBattleResolveStep (E-0347)
; why: step 0 of RunBattleSetup_BankA0_CommandMenu (when wBattleResolveStep = 0);
; RunBattleSetup_BankA0_CommandMenu: by wBattleResolveStep: the bank-$A0 copy of
; RunBattleSetup_CommandMenu (command windows, 'It has no usable ...') (E-0352)
RunBattleSetup_BankA0_CommandMenu_ShowStringBank09AtTilesHL_BankA0::
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
    call WriteFiveTilesFromTable_2
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; step 1 of RunBattleSetup_BankA0_CommandMenu: copies the byte at wBattleLoadWork to wMenuSubState;
; calls DrawScreenTileBufferRow11Col4Rect20x11ToBGMapRow7_BankA0; calls WriteVRAMByte; advances
; wBattleResolveStep; sets wListLastPageSize to 3; also changes HL, DE and A by register arithmetic
; (E-0347)
; why: step 1 of RunBattleSetup_BankA0_CommandMenu (when wBattleResolveStep = 1);
; RunBattleSetup_BankA0_CommandMenu: by wBattleResolveStep: the bank-$A0 copy of
; RunBattleSetup_CommandMenu (command windows, 'It has no usable ...') (E-0352)
RunBattleSetup_BankA0_CommandMenu_WriteMenuSubStateAndListLastPageSize::
    ld a, [wCommandMonster]
    ld hl, wBattleLoadWork
    add_a_to_hl
    ld a, [hl]
    ld [wMenuSubState], a
    call DrawScreenTileBufferRow11Col4Rect20x11ToBGMapRow7_BankA0
    ld hl, RunBattleSetup_BankA0_CommandMenu_WriteMenuSubStateAndListLastPageSize_Data
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

; step 2 of RunBattleSetup_BankA0_CommandMenu: calls
; RunBattleSetup_BankA0_CommandMenu_SetBit6AndBlankEntryTile_BankA0; branches on wJoypadPressed;
; plays sound $69; calls SetSlotTacticAndSlotLastTacticForCommandMonster_BankA0; calls
; ClearAndLayoutTileBlocksForBattleFoeCount; advances wBattleResolveStep; sets wBattleArg1 to 0;
; branches on $00; sets wBattleArg1 to 0; sets bit 7 of wSideControl; sets wBattleResolveStep to 0;
; sets wBattleSubPhase to 3; then 3 more steps (see the code) (E-0347)
; why: step 2 of RunBattleSetup_BankA0_CommandMenu (when wBattleResolveStep = 2);
; RunBattleSetup_BankA0_CommandMenu: by wBattleResolveStep: the bank-$A0 copy of
; RunBattleSetup_CommandMenu (command windows, 'It has no usable ...') (E-0352)
RunBattleSetup_BankA0_CommandMenu_WriteBattleArg1AndBattleResolveStepEtc::
    ld de, RunBattleSetup_BankA0_CommandMenu_WriteMenuSubStateAndListLastPageSize_Data
    ld hl, wMenuSubState
    call RunBattleSetup_BankA0_CommandMenu_SetBit6AndBlankEntryTile_BankA0
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
    call SetSlotTacticAndSlotLastTacticForCommandMonster_BankA0
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

; step 3 of RunBattleSetup_BankA0_CommandMenu: calls
; DrawScreenTileBufferRow11Col4Rect20x11ToBGMapRow7_BankA0; sets wBattleResolveStep to 0; sets
; wBattleSubPhase to 0 (E-0347)
; why: step 3 of RunBattleSetup_BankA0_CommandMenu (when wBattleResolveStep = 3);
; RunBattleSetup_BankA0_CommandMenu: by wBattleResolveStep: the bank-$A0 copy of
; RunBattleSetup_CommandMenu (command windows, 'It has no usable ...') (E-0352)
RunBattleSetup_BankA0_CommandMenu_WriteBattleResolveStepAndBattleSubPhase::
    call DrawScreenTileBufferRow11Col4Rect20x11ToBGMapRow7_BankA0
    xor a
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleSubPhase], a
    ret

; step 4 of RunBattleSetup_BankA0_CommandMenu: calls
; DrawScreenTileBufferRow11Col4Rect20x11ToBGMapRow7_BankA0; sets wBattleArg1 to 0; sets
; wStringCategory to 2; sets wStringIndex to 9; calls ShowStringBank09AtTilesHL_BankA0; calls
; CopyRectRecordToScreenBuffer_6; calls WriteFiveTilesFromTable_2; copies the byte at wSideControl &
; $03 to wMenuSelectedMember; advances wBattleResolveStep (E-0347)
; why: step 4 of RunBattleSetup_BankA0_CommandMenu (when wBattleResolveStep = 4);
; RunBattleSetup_BankA0_CommandMenu: by wBattleResolveStep: the bank-$A0 copy of
; RunBattleSetup_CommandMenu (command windows, 'It has no usable ...') (E-0352)
RunBattleSetup_BankA0_CommandMenu_WriteBattleArg1AndStringCategoryEtc::
    ld a, [wBattleArg1]
    or a
    call z, DrawScreenTileBufferRow11Col4Rect20x11ToBGMapRow7_BankA0
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
    call WriteFiveTilesFromTable_2
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

; step 5 of RunBattleSetup_BankA0_CommandMenu: calls
; DrawScreenTileBufferRow14Col8Rect11x9ToBGMapRow9_BankA0; calls WriteVRAMByte; advances
; wBattleResolveStep; also changes HL, DE and A by register arithmetic (E-0347)
; why: step 5 of RunBattleSetup_BankA0_CommandMenu (when wBattleResolveStep = 5);
; RunBattleSetup_BankA0_CommandMenu: by wBattleResolveStep: the bank-$A0 copy of
; RunBattleSetup_CommandMenu (command windows, 'It has no usable ...') (E-0352)
RunBattleSetup_BankA0_CommandMenu_ReadMenuSelectedMember::
    call DrawScreenTileBufferRow14Col8Rect11x9ToBGMapRow9_BankA0
    ld hl, RunBattleSetup_BankA0_CommandMenu_ReadMenuSelectedMember_Data
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

; step 6 of RunBattleSetup_BankA0_CommandMenu: calls
; RunBattleSetup_BankA0_CommandMenu_SetBit6AndBlankEntryTile_BankA0_2; branches on wJoypadPressed;
; sets wBattleArg1 to 0; calls ClearAndLayoutTileBlocksForBattleFoeCount; advances
; wBattleResolveStep; plays sound $69; branches on wMenuSelectedMember & $03; calls
; CarryUnlessBattleSlotOutSlotEmpty; calls ClearAndLayoutTileBlocksForBattleFoeCount; sets
; wBattleResolveStep to $15; calls
; RunBattleSetup_BankA0_CommandMenu_WriteBattleArg2AndBattleArg3Etc; branches on D; then 9 more
; steps (see the code) (E-0347)
; why: step 6 of RunBattleSetup_BankA0_CommandMenu (when wBattleResolveStep = 6);
; RunBattleSetup_BankA0_CommandMenu: by wBattleResolveStep: the bank-$A0 copy of
; RunBattleSetup_CommandMenu (command windows, 'It has no usable ...') (E-0352)
RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount::
    ld de, RunBattleSetup_BankA0_CommandMenu_ReadMenuSelectedMember_Data
    ld hl, wMenuSelectedMember
    call RunBattleSetup_BankA0_CommandMenu_SetBit6AndBlankEntryTile_BankA0_2
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
    jr z, .call_run_battle_setup_bank_a0_command_menu
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

.call_run_battle_setup_bank_a0_command_menu:
    call RunBattleSetup_BankA0_CommandMenu_WriteBattleArg2AndBattleArg3Etc
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

; step 7 of RunBattleSetup_BankA0_CommandMenu: calls
; DrawScreenTileBufferRow14Col8Rect11x9ToBGMapRow9_BankA0; branches on wBattleArg1; sets
; wBattleResolveStep to $14 (E-0347)
; why: step 7 of RunBattleSetup_BankA0_CommandMenu (when wBattleResolveStep = 7);
; RunBattleSetup_BankA0_CommandMenu: by wBattleResolveStep: the bank-$A0 copy of
; RunBattleSetup_CommandMenu (command windows, 'It has no usable ...') (E-0352)
RunBattleSetup_BankA0_CommandMenu_WriteBattleResolveStep::
    call DrawScreenTileBufferRow14Col8Rect11x9ToBGMapRow9_BankA0
    ld a, [wBattleArg1]
    or a
    jr z, .set_battle_resolve_step
    ld a, $14

.set_battle_resolve_step:
    ld [wBattleResolveStep], a
    ret

; step 8 of RunBattleSetup_BankA0_CommandMenu: calls
; DrawScreenTileBufferRow14Col8Rect11x9ToBGMapRow9_BankA0; calls FillTilesFromRequest; calls
; CopyRectRecordToScreenBuffer; advances wBattleResolveStep (E-0347)
; why: step 8 of RunBattleSetup_BankA0_CommandMenu (when wBattleResolveStep = 8);
; RunBattleSetup_BankA0_CommandMenu: by wBattleResolveStep: the bank-$A0 copy of
; RunBattleSetup_CommandMenu (command windows, 'It has no usable ...') (E-0352)
RunBattleSetup_BankA0_CommandMenu_CallDrawScreenTileBufferRow14Col8Rect11x9ToBGMapRow9_BankA0::
    call DrawScreenTileBufferRow14Col8Rect11x9ToBGMapRow9_BankA0
    call FillTilesFromRequest
    farcall CopyRectRecordToScreenBuffer
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; step 9 of RunBattleSetup_BankA0_CommandMenu: calls
; DrawWindowTileBufferRow2Col16RowsToBGMapRow13_BankA0; sets wStringCategory to 0; sets wStringIndex
; to $29; calls BeginStringDisplay_Bank2F; advances wBattleResolveStep (E-0347)
; why: step 9 of RunBattleSetup_BankA0_CommandMenu (when wBattleResolveStep = 9);
; RunBattleSetup_BankA0_CommandMenu: by wBattleResolveStep: the bank-$A0 copy of
; RunBattleSetup_CommandMenu (command windows, 'It has no usable ...') (E-0352)
RunBattleSetup_BankA0_CommandMenu_ShowItHasNoUsable::
    call DrawWindowTileBufferRow2Col16RowsToBGMapRow13_BankA0
    ld a, $00
    ld [wStringCategory], a
    ld a, $29
    ld [wStringIndex], a ; 'It has no usable battle skills!'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; step 22 of RunBattleSetup_BankA0_CommandMenu: calls
; DrawWindowTileBufferRow2Col16RowsToBGMapRow13_BankA0; sets wStringCategory to 0; sets wStringIndex
; to $7f; calls BeginStringDisplay_Bank2F; advances wBattleResolveStep (E-0347)
; why: step 22 of RunBattleSetup_BankA0_CommandMenu (when wBattleResolveStep = 22);
; RunBattleSetup_BankA0_CommandMenu: by wBattleResolveStep: the bank-$A0 copy of
; RunBattleSetup_CommandMenu (command windows, 'It has no usable ...') (E-0352)
RunBattleSetup_BankA0_CommandMenu_ShowButThereIsNo::
    call DrawWindowTileBufferRow2Col16RowsToBGMapRow13_BankA0
    ld a, $00
    ld [wStringCategory], a
    ld a, $7f
    ld [wStringIndex], a ; 'But there is no one to'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; step 10 of RunBattleSetup_BankA0_CommandMenu: returns unless wTextFlags is 0; calls
; ClearAndLayoutTileBlocksForBattleFoeCount; advances wBattleResolveStep (E-0347)
; why: step 10 of RunBattleSetup_BankA0_CommandMenu (when wBattleResolveStep = 10);
; RunBattleSetup_BankA0_CommandMenu: by wBattleResolveStep: the bank-$A0 copy of
; RunBattleSetup_CommandMenu (command windows, 'It has no usable ...') (E-0352)
RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount_AdvanceBattleResolveStep::
    ld a, [wTextFlags]
    or a
    ret nz
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; step 11 of RunBattleSetup_BankA0_CommandMenu: calls
; DrawWindowTileBufferRow2Col16RowsToBGMapRow13_BankA0; sets wBattleResolveStep to 4 (E-0347)
; why: step 11 of RunBattleSetup_BankA0_CommandMenu (when wBattleResolveStep = 11);
; RunBattleSetup_BankA0_CommandMenu: by wBattleResolveStep: the bank-$A0 copy of
; RunBattleSetup_CommandMenu (command windows, 'It has no usable ...') (E-0352)
RunBattleSetup_BankA0_CommandMenu_WriteBattleResolveStep_DrawWindowTileBufferRow2Col16RowsToBGMapRow13_BankA0::
    call DrawWindowTileBufferRow2Col16RowsToBGMapRow13_BankA0
    ld a, $04
    ld [wBattleResolveStep], a
    ret

; step 12 of RunBattleSetup_BankA0_CommandMenu: calls
; DrawScreenTileBufferRow14Col8Rect11x9ToBGMapRow9_BankA0; sets wBattleArg1 to 0; copies the byte at
; wSideControl & $03 to wMenuCursor; sets wCommandCursor; clears bit 7 of wCommandCursor; calls
; ShowSkillPageNames_BankA0; calls
; RunBattleSetup_BankA0_CommandMenu_ClearBit6AndCursorEntryTile_BankA0; calls
; CopyRectRecordsAndToScreenBuffer; sets wStringCategory to 9; calls
; RunBattleSetup_BankA0_CommandMenu_ShowStringBank08AtTilesHL_BankA0; advances wBattleResolveStep
; (E-0347)
; why: step 12 of RunBattleSetup_BankA0_CommandMenu (when wBattleResolveStep = 12);
; RunBattleSetup_BankA0_CommandMenu: by wBattleResolveStep: the bank-$A0 copy of
; RunBattleSetup_CommandMenu (command windows, 'It has no usable ...') (E-0352)
RunBattleSetup_BankA0_CommandMenu_WriteBattleArg1AndMenuCursorEtc::
    ld a, [wBattleArg1]
    or a
    call z, DrawScreenTileBufferRow14Col8Rect11x9ToBGMapRow9_BankA0
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
    ld de, RunBattleSetup_BankA0_CommandMenu_WriteMenuSubStateAndListLastPageSize_Data
    call ShowSkillPageNames_BankA0
    call RunBattleSetup_BankA0_CommandMenu_ClearBit6AndCursorEntryTile_BankA0
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
    call RunBattleSetup_BankA0_CommandMenu_ShowStringBank08AtTilesHL_BankA0
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; step 13 of RunBattleSetup_BankA0_CommandMenu: calls
; DrawScreenTileBufferRow13Col8AndScreenTileBufferRow14Col8Rects_BankA0; calls WriteVRAMByte; calls
; DrawInventoryPageIndicator_BankA0; advances wBattleResolveStep; sets wListLastPageSize to 3
; (E-0347)
; why: step 13 of RunBattleSetup_BankA0_CommandMenu (when wBattleResolveStep = 13);
; RunBattleSetup_BankA0_CommandMenu: by wBattleResolveStep: the bank-$A0 copy of
; RunBattleSetup_CommandMenu (command windows, 'It has no usable ...') (E-0352)
RunBattleSetup_BankA0_CommandMenu_WriteListLastPageSize::
    call DrawScreenTileBufferRow13Col8AndScreenTileBufferRow14Col8Rects_BankA0
    ld hl, RunBattleSetup_BankA0_CommandMenu_WriteMenuSubStateAndListLastPageSize_Data
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

; step 14 of RunBattleSetup_BankA0_CommandMenu: calls
; RunBattleSetup_BankA0_CommandMenu_SetBit6AndBlankEntryTile_BankA0; branches on wJoypadPressed;
; plays sound $69; calls ClearAndLayoutTileBlocksForBattleFoeCount; sets wBattleArg1 to $14; calls
; LoadSelectedSkillRecord_BankA0; branches on wRecordBufferData; branches on h; advances
; wBattleResolveStep; branches on wJoypadPressed; calls ClearAndLayoutTileBlocksForBattleFoeCount;
; sets wBattleArg1 to 4; then 10 more steps (see the code) (E-0347)
; why: step 14 of RunBattleSetup_BankA0_CommandMenu (when wBattleResolveStep = 14);
; RunBattleSetup_BankA0_CommandMenu: by wBattleResolveStep: the bank-$A0 copy of
; RunBattleSetup_CommandMenu (command windows, 'It has no usable ...') (E-0352)
RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount_2::
    ld de, RunBattleSetup_BankA0_CommandMenu_WriteMenuSubStateAndListLastPageSize_Data
    ld hl, wMenuCursor
    call RunBattleSetup_BankA0_CommandMenu_SetBit6AndBlankEntryTile_BankA0
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
    jr z, .call_run_battle_setup_bank_a0_command_menu
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    ld a, $04
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.call_run_battle_setup_bank_a0_command_menu:
    call RunBattleSetup_BankA0_CommandMenu_ClearBit6AndCursorEntryTile_BankA0
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

; step 15 of RunBattleSetup_BankA0_CommandMenu: calls
; DrawScreenTileBufferRow13Col8AndScreenTileBufferRow14Col8Rects_BankA0; copies wBattleArg1 to
; wBattleResolveStep; sets wBattleArg1 to 0 (E-0347)
; why: step 15 of RunBattleSetup_BankA0_CommandMenu (when wBattleResolveStep = 15);
; RunBattleSetup_BankA0_CommandMenu: by wBattleResolveStep: the bank-$A0 copy of
; RunBattleSetup_CommandMenu (command windows, 'It has no usable ...') (E-0352)
RunBattleSetup_BankA0_CommandMenu_WriteBattleResolveStepAndBattleArg1::
    call DrawScreenTileBufferRow13Col8AndScreenTileBufferRow14Col8Rects_BankA0
    ld a, [wBattleArg1]
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleArg1], a
    ret

; step 16 of RunBattleSetup_BankA0_CommandMenu: calls ClearAndLayoutTileBlocksForBattleFoeCount;
; calls DrawScreenTileBufferRow13Col8AndScreenTileBufferRow14Col8Rects_BankA0; calls
; CopyRectRecordToScreenBuffer; advances wBattleResolveStep (E-0347)
; why: step 16 of RunBattleSetup_BankA0_CommandMenu (when wBattleResolveStep = 16);
; RunBattleSetup_BankA0_CommandMenu: by wBattleResolveStep: the bank-$A0 copy of
; RunBattleSetup_CommandMenu (command windows, 'It has no usable ...') (E-0352)
RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount_3::
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    call DrawScreenTileBufferRow13Col8AndScreenTileBufferRow14Col8Rects_BankA0
    farcall CopyRectRecordToScreenBuffer
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; step 17 of RunBattleSetup_BankA0_CommandMenu: calls
; DrawWindowTileBufferRow2Col16RowsToBGMapRow13_BankA0; sets wStringCategory to 0; calls
; BeginStringDisplay_Bank2F; advances wBattleResolveStep (E-0347)
; why: step 17 of RunBattleSetup_BankA0_CommandMenu (when wBattleResolveStep = 17);
; RunBattleSetup_BankA0_CommandMenu: by wBattleResolveStep: the bank-$A0 copy of
; RunBattleSetup_CommandMenu (command windows, 'It has no usable ...') (E-0352)
RunBattleSetup_BankA0_CommandMenu_WriteStringCategory::
    call DrawWindowTileBufferRow2Col16RowsToBGMapRow13_BankA0
    xor a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; step 18 of RunBattleSetup_BankA0_CommandMenu: returns unless wTextFlags is 0; calls
; ClearAndLayoutTileBlocksForBattleFoeCount; advances wBattleResolveStep (E-0347)
; why: step 18 of RunBattleSetup_BankA0_CommandMenu (when wBattleResolveStep = 18);
; RunBattleSetup_BankA0_CommandMenu: by wBattleResolveStep: the bank-$A0 copy of
; RunBattleSetup_CommandMenu (command windows, 'It has no usable ...') (E-0352)
RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount_AdvanceBattleResolveStep_2::
    ld a, [wTextFlags]
    or a
    ret nz
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; step 19 of RunBattleSetup_BankA0_CommandMenu: calls
; DrawWindowTileBufferRow2Col16RowsToBGMapRow13_BankA0; sets wBattleResolveStep to $0c (E-0347)
; why: step 19 of RunBattleSetup_BankA0_CommandMenu (when wBattleResolveStep = 19);
; RunBattleSetup_BankA0_CommandMenu: by wBattleResolveStep: the bank-$A0 copy of
; RunBattleSetup_CommandMenu (command windows, 'It has no usable ...') (E-0352)
RunBattleSetup_BankA0_CommandMenu_WriteBattleResolveStep_2::
    call DrawWindowTileBufferRow2Col16RowsToBGMapRow13_BankA0
    ld a, $0c
    ld [wBattleResolveStep], a
    ret

; step 20 of RunBattleSetup_BankA0_CommandMenu: sets wBattleResolveStep to 0; sets wBattleSubPhase
; to 3 (E-0347)
; why: step 20 of RunBattleSetup_BankA0_CommandMenu (when wBattleResolveStep = 20);
; RunBattleSetup_BankA0_CommandMenu: by wBattleResolveStep: the bank-$A0 copy of
; RunBattleSetup_CommandMenu (command windows, 'It has no usable ...') (E-0352)
RunBattleSetup_BankA0_CommandMenu_SetBattleResolveStep::
    xor a
    ld [wBattleResolveStep], a
    ld a, $03
    ld [wBattleSubPhase], a
    ret

; step 2 of RunBattleSetup_BankA0: returns at once (E-0347)
; why: step 2 of RunBattleSetup_BankA0 (when wBattleSubPhase = 2); RunBattleSetup_BankA0: the same
; instruction sequence as RunBattleSetup (bank $31) apart from label operands, which refer to this
; bank's own routines and tables (E-0352, E-0107)
RunBattleSetup_BankA0_Return::
    ret

; step 3 of RunBattleSetup_BankA0: branches on the byte at wSlotMarks; sets wSlotMarks to 1;
; branches on the byte at wSlotMarks; sets wBattleActor to 0; calls
; ClearAndLayoutTileBlocksForBattleFoeCount; calls RunBattleSetup_BankA0_ReadSTAT; calls
; CopyRectRecordToScreenBuffer; calls DrawScreenTileBufferRow11Col4RowsToBGMapRow7; advances
; wBattleSubPhase; sets wLinkSendByte to 0 (E-0347)
; why: step 3 of RunBattleSetup_BankA0 (when wBattleSubPhase = 3); RunBattleSetup_BankA0: the same
; instruction sequence as RunBattleSetup (bank $31) apart from label operands, which refer to this
; bank's own routines and tables (E-0352, E-0107)
RunBattleSetup_BankA0_ClearAndLayoutTileBlocksForBattleFoeCount::
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
    call RunBattleSetup_BankA0_ReadSTAT
    farcall CopyRectRecordToScreenBuffer
    farcall DrawScreenTileBufferRow11Col4RowsToBGMapRow7
    ld hl, wBattleSubPhase
    inc [hl]
    xor a
    ld [wLinkSendByte], a
    ret

; step 4 of RunBattleSetup_BankA0: calls CopyFiveGlyphsPlusMarks; sets wStringCategory to 0; sets
; wStringIndex to $22; calls BeginStringDisplay_Bank2F; advances wBattleSubPhase (E-0347)
; why: step 4 of RunBattleSetup_BankA0 (when wBattleSubPhase = 4); RunBattleSetup_BankA0: the same
; instruction sequence as RunBattleSetup (bank $31) apart from label operands, which refer to this
; bank's own routines and tables (E-0352, E-0107)
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

; step 5 of RunBattleSetup_BankA0: calls AdvanceRandom; returns if wRandomLo is $f3; returns if
; wRandomHi is $f3; sets wLinkSendByte to 1; advances wBattleSubPhase; also changes HL, A and D by
; register arithmetic (E-0347)
; why: step 5 of RunBattleSetup_BankA0 (when wBattleSubPhase = 5); RunBattleSetup_BankA0: the same
; instruction sequence as RunBattleSetup (bank $31) apart from label operands, which refer to this
; bank's own routines and tables (E-0352, E-0107)
RunBattleSetup_BankA0_AdvanceRandom::
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

; step 6 of RunBattleSetup_BankA0: returns unless wLinkMessage is $01; advances wBattleSubPhase;
; sets wLinkBufferCountHi to 0; sets wLinkBufferCountLo to $0b; copies L to wLinkTimeoutLo; copies H
; to wLinkTimeoutHi; copies L to wLinkBufferPtrLo; copies H to wLinkBufferPtrHi (E-0347)
; why: step 6 of RunBattleSetup_BankA0 (when wBattleSubPhase = 6); RunBattleSetup_BankA0: the same
; instruction sequence as RunBattleSetup (bank $31) apart from label operands, which refer to this
; bank's own routines and tables (E-0352, E-0107)
RunBattleSetup_BankA0_WaitLinkMessage::
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

; step 7 of RunBattleSetup_BankA0: advances wBattleSubPhase; sets wLinkSendByte to $ff; sets
; wLinkReady to 1 (E-0347)
; why: step 7 of RunBattleSetup_BankA0 (when wBattleSubPhase = 7); RunBattleSetup_BankA0: the same
; instruction sequence as RunBattleSetup (bank $31) apart from label operands, which refer to this
; bank's own routines and tables (E-0352, E-0107)
RunBattleSetup_BankA0_SetBattleSubPhase::
    ld hl, wBattleSubPhase
    inc [hl]
    ld a, $ff
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; step 8 of RunBattleSetup_BankA0: returns unless wLinkMessage is $f0; sets wLinkSendByte to 0; sets
; wLinkReady to 0; branches on wLinkRole; copies the byte at wLinkPartnerName to wSlotCommands;
; copies the byte at wLinkPartnerName to wPartnerCommand; copies the byte at wMenuState to
; wSlotCommands; copies the byte at wMenuState to wPartnerCommand; copies the byte at
; wLinkPartnerName to wMenuState; copies the byte at wLinkPartnerName to wMenuSubState; copies the
; byte at wLinkPartnerName to wSlotTactic; copies the byte at wLinkPartnerName to wRandomLo; then 7
; more steps (see the code) (E-0347)
; why: step 8 of RunBattleSetup_BankA0 (when wBattleSubPhase = 8); RunBattleSetup_BankA0: the same
; instruction sequence as RunBattleSetup (bank $31) apart from label operands, which refer to this
; bank's own routines and tables (E-0352, E-0107)
RunBattleSetup_BankA0_WaitLinkMessage_SetLinkSendByte::
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

; step 9 of RunBattleSetup_BankA0: branches on wRandomSeed2Lo; branches on wRandomSeed2Hi; sets
; wLinkSendByte to $22; sets wCounterPtr0Lo to $22; sets wLinkSendByte to $33; sets wCounterPtr0Lo
; to $33; advances wBattleSubPhase; also changes HL, A and B by register arithmetic (E-0347)
; why: step 9 of RunBattleSetup_BankA0 (when wBattleSubPhase = 9); RunBattleSetup_BankA0: the same
; instruction sequence as RunBattleSetup (bank $31) apart from label operands, which refer to this
; bank's own routines and tables (E-0352, E-0107)
RunBattleSetup_BankA0_WriteLinkSendByteAndCounterPtr0Lo::
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

; step 10 of RunBattleSetup_BankA0: branches on wLinkMessage; copies wLinkMessage to wCounterPtr0Hi;
; sets wLinkSendByte to 0; advances wBattleSubPhase (E-0347)
; why: step 10 of RunBattleSetup_BankA0 (when wBattleSubPhase = 10); RunBattleSetup_BankA0: the same
; instruction sequence as RunBattleSetup (bank $31) apart from label operands, which refer to this
; bank's own routines and tables (E-0352, E-0107)
RunBattleSetup_BankA0_WriteCounterPtr0HiAndLinkSendByte::
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

; step 11 of RunBattleSetup_BankA0: branches on wCounterPtr0Lo; branches on wCounterPtr0Hi; sets
; wBattleSubPhase to 5; advances wBattleSubPhase; sets wLinkSendByte to 2; also changes HL and A by
; register arithmetic (E-0347)
; why: step 11 of RunBattleSetup_BankA0 (when wBattleSubPhase = 11); RunBattleSetup_BankA0: the same
; instruction sequence as RunBattleSetup (bank $31) apart from label operands, which refer to this
; bank's own routines and tables (E-0352, E-0107)
RunBattleSetup_BankA0_WriteLinkSendByteAndBattleSubPhase::
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

; step 12 of RunBattleSetup_BankA0: returns unless wLinkMessage is $02; calls FillTilesFromRequest;
; advances wBattleStep; sets wBattleSubPhase to 0 (E-0347)
; why: step 12 of RunBattleSetup_BankA0 (when wBattleSubPhase = 12); RunBattleSetup_BankA0: the same
; instruction sequence as RunBattleSetup (bank $31) apart from label operands, which refer to this
; bank's own routines and tables (E-0352, E-0107)
RunBattleSetup_BankA0_FillTilesFromRequest::
    ld a, [wLinkMessage]
    cp $02
    ret nz
    call FillTilesFromRequest
    ld hl, wBattleStep
    inc [hl]
    xor a
    ld [wBattleSubPhase], a
    ret

; called from RunBattleSetup_BankA0_EntrySelect_ClearAndLayoutTileBlocksForBattleFoeCount_2: calls
; SetBit6AndBlankEntryTile_BankA0; calls ClearBit6AndCursorEntryTile_BankA0; plays sound $69; calls
; SetBit6AndBlankEntryTile_BankA0; calls ClearBit6AndCursorEntryTile_BankA0; plays sound $69; calls
; ClearBit6AndCursorEntryTile_BankA0; calls SetBit6AndBlankEntryTile_BankA0; copies wFrameCounterLo
; & $f0 to wFrameCounterLo (E-0347)
; why: a helper of RunBattleSetup_BankA0_EntrySelect_ClearAndLayoutTileBlocksForBattleFoeCount_2, in
; step 2 of RunBattleSetup_BankA0_EntrySelect (when wBattleResolveStep = 2);
; RunBattleSetup_BankA0_EntrySelect: by wBattleResolveStep: lays out the tile blocks for the foe
; count and moves a selection over entries, setting or clearing bit 6 and the ... (E-0352)
RunBattleSetup_BankA0_EntrySelect_SetBit6AndBlankEntryTile_BankA0::
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

; called from RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount: calls
; SetBit6AndBlankEntryTile_BankA0; calls ClearBit6AndCursorEntryTile_BankA0; plays sound $69; calls
; ClearBit6AndCursorEntryTile_BankA0; calls SetBit6AndBlankEntryTile_BankA0; copies wFrameCounterLo
; & $f0 to wFrameCounterLo; also changes A by register arithmetic (E-0347)
; why: a helper of RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount, in
; step 6 of RunBattleSetup_BankA0_CommandMenu (when wBattleResolveStep = 6);
; RunBattleSetup_BankA0_CommandMenu: by wBattleResolveStep: the bank-$A0 copy of
; RunBattleSetup_CommandMenu (command windows, 'It has no usable ...') (E-0352)
RunBattleSetup_BankA0_CommandMenu_SetBit6AndBlankEntryTile_BankA0_2::
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

; Branches on wCommandPageCount; branches on wCommandCursorMax; calls
; SetBit6AndBlankEntryTile_BankA0; calls ClearBit6AndCursorEntryTile_BankA0; plays sound $69;
; branches on wCommandPageCount; branches on wCommandCursorMax; calls
; SetBit6AndBlankEntryTile_BankA0; calls ClearBit6AndCursorEntryTile_BankA0; plays sound $69;
; branches on wCommandPageCount; branches on wCommandCursor; then 11 more steps (see the code)
; (E-0347)
; why: part of RunBattleSetup_BankA0_CommandMenu; RunBattleSetup_BankA0_CommandMenu: by
; wBattleResolveStep: the bank-$A0 copy of RunBattleSetup_CommandMenu (command windows, 'It has no
; usable ...') (E-0352)
RunBattleSetup_BankA0_CommandMenu_SetBit6AndBlankEntryTile_BankA0::
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

; clears wMenuSubState and writes five consecutive tile numbers starting at
; WriteFiveTilesFromTable_2_Data[wCommandMonster] to HL (E-0122) (E-0344: the address in its name
; dropped or read as the label there; was WriteFiveTilesFromTable_2)
WriteFiveTilesFromTable_2::
    push hl
    ld a, [wCommandMonster]
    ld hl, WriteFiveTilesFromTable_2_Data
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

; data read by WriteFiveTilesFromTable (2 bytes) (E-0347)
WriteFiveTilesFromTable_2_Data::
    db $d0, $d5

; called from RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount: copies L
; to wBattleArg2; copies H to wBattleArg3; branches on the byte at wBattleSkills; branches on C;
; sets wCommandPageCount to 0; branches on C; copies C & $03 & $03 to wCommandCursorMax; sets
; wCommandCursor to 0; also changes HL, BC, A and D by register arithmetic (E-0347)
; why: a helper of RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount, in
; step 6 of RunBattleSetup_BankA0_CommandMenu (when wBattleResolveStep = 6);
; RunBattleSetup_BankA0_CommandMenu: by wBattleResolveStep: the bank-$A0 copy of
; RunBattleSetup_CommandMenu (command windows, 'It has no usable ...') (E-0352)
RunBattleSetup_BankA0_CommandMenu_WriteBattleArg2AndBattleArg3Etc::
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
    call z, ReturnZero_3
    call ShowStringAAtTiles16D0_BankA0
    ld a, [hli]
    inc hl
    cp $ff
    call z, ReturnZero_3
    call ShowStringAAtTiles1760_BankA0
    ld a, [hli]
    inc hl
    cp $ff
    call z, ReturnZero_3
    call ShowStringAAtTiles17F0_BankA0
    ld a, [hl]
    cp $ff
    call z, ReturnZero_3
    call ShowStringAAtTiles2080_BankA0
    ret

; A = 0 (xor a); a two-byte handler stub (E-0111) (E-0344: the address in its name dropped or read
; as the label there; was ReturnZero_3)
ReturnZero_3::
    xor a
    ret

; Branches on wCommandCursor; sets wCommandCursor; calls ClearBit6AndCursorEntryTile_BankA0; calls
; ShowSkillPageNames_BankA0; sets bit 7 of wMenuCursor; returns unless bit 7 of wMenuCursor is set;
; sets wMenuCursor; sets wStringCategory to 9; calls
; RunBattleSetup_BankA0_CommandMenu_ShowStringBank08AtTilesHL_BankA0; calls WriteVRAMByteInc; calls
; WriteVRAMByte; also changes HL, DE, A and C by register arithmetic (E-0347)
; why: part of RunBattleSetup_BankA0_CommandMenu; RunBattleSetup_BankA0_CommandMenu: by
; wBattleResolveStep: the bank-$A0 copy of RunBattleSetup_CommandMenu (command windows, 'It has no
; usable ...') (E-0352)
RunBattleSetup_BankA0_CommandMenu_ClearBit6AndCursorEntryTile_BankA0::
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
    call RunBattleSetup_BankA0_CommandMenu_ShowStringBank08AtTilesHL_BankA0
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

; wStringIndex = A, then the string at vTiles1 + $760 with size $0901; HL kept (E-0116)
ShowStringAAtTiles1760_BankA0::
    ld [wStringIndex], a
    push hl
    ld hl, vTiles1 + $760
    ld de, $0901
    call ShowStringBank08AtTilesHL_BankA0
    pop hl
    ret

; wStringIndex = A, then the string at vTiles1 + $7F0 with size $0901; HL kept (E-0116)
ShowStringAAtTiles17F0_BankA0::
    ld [wStringIndex], a
    push hl
    ld hl, vTiles1 + $7f0
    ld de, $0901
    call ShowStringBank08AtTilesHL_BankA0
    pop hl
    ret

; wStringIndex = A, then the string at vTiles2 + $80 with size $0901 (E-0116)
ShowStringAAtTiles2080_BankA0::
    ld [wStringIndex], a
    ld hl, vTiles2 + $80
    ld de, $0901
    call ShowStringBank08AtTilesHL_BankA0
    ret

; Sets wStringIndex; calls ShowStringBank08AtTilesHL_BankA0; sets wRecordBuffer; calls
; LoadSkillRecord; branches on wRecordBufferData; calls HLToDecimalDigits; calls
; WriteDecimalDigitTiles; also changes HL, DE and A by register arithmetic (E-0347)
; why: part of RunBattleSetup_BankA0_CommandMenu; RunBattleSetup_BankA0_CommandMenu: by
; wBattleResolveStep: the bank-$A0 copy of RunBattleSetup_CommandMenu (command windows, 'It has no
; usable ...') (E-0352)
RunBattleSetup_BankA0_CommandMenu_ShowStringBank08AtTilesHL_BankA0::
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

; data read by RunBattleSetup (8 bytes) (E-0347)
RunBattleSetup_BankA0_EntrySelect_ToCopyRect32StrideToVRAM_BankA0_Data::
    db $c1, $01, $01, $02, $c7, $01, $07, $02

RunBattleSetup_BankA0_CommandMenu_WriteMenuSubStateAndListLastPageSize_Data::
    db $41, $01, $81, $01, $c1, $01, $01, $02

RunBattleSetup_BankA0_CommandMenu_ReadMenuSelectedMember_Data::
    db $81, $01, $c1, $01, $01, $02, $c1, $01, $01, $02, $c1, $01, $01, $02, $29, $00
    db $69, $00, $a9, $00, $e9, $00, $2f, $01, $6f, $01

; A = value: stores A in wSlotTactic[wCommandMonster], and also in wSlotLastTactic[wCommandMonster]
; unless A is 3 (E-0118)
SetSlotTacticAndSlotLastTacticForCommandMonster_BankA0::
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

; far-calls RunDebugState_E0 (E-0122) (E-0344: the address in its name dropped or read as the label
; there; was CallRunDebugStateInBankE0_BankA0; shortened from CallRunDebugState_E0InBankE0_BankA0)
CallRunDebugStateInBankE0_BankA0::
    farcall RunDebugState_E0
    ret

; Changes HL, BC and A; branches on rSTAT (E-0347)
; why: part of RunBattleSetup_BankA0; RunBattleSetup_BankA0: the same instruction sequence as
; RunBattleSetup (bank $31) apart from label operands, which refer to this bank's own routines and
; tables (E-0352, E-0107)
RunBattleSetup_BankA0_ReadSTAT::
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

; C = slot 0-2: when the slot is present and its status byte 0 is non-zero, calls one marker routine
; for each of bits 0, 1, 4, 5, 6 and 7 that is set (the zero-status path is not read) (E-0111)
; code: branches on C; calls CarryUnlessBattleSlotOutSlotEmpty; branches on the byte at
; wBattleStatus; calls DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0; calls
; DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_3; calls
; DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_4; calls
; DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_6; calls
; DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_2; calls
; DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_7; calls
; DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_5; calls DrawSlotLevel_BankA0; calls
; DerefHL_BankA0; then 4 more steps (see the code) (E-0347)
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
    call DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0
    bit 0, [hl]
    call nz, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_3
    bit 1, [hl]
    call nz, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_4
    bit 4, [hl]
    call nz, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_6
    bit 5, [hl]
    call nz, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_2
    bit 6, [hl]
    call nz, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_7
    bit 7, [hl]
    call nz, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_5
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

; called from DrawSlotStatusMarks_BankA0: takes HL; changes HL and A (E-0347)
; why: a helper of DrawSlotStatusMarks_BankA0; DrawSlotStatusMarks_BankA0: C = slot 0-2: when the
; slot is present and its status byte 0 is non-zero, calls one marker routine for each of bits 0, 1,
; 4, 5, 6 and 7 ... (E-0352, E-0111)
DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0::
    push hl
    ld hl, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Data
    call ReadWordTableEntryForSlotC_BankA0
    ld a, $c3
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hl], a
    pop hl
    ret

; called from DrawSlotStatusMarks_BankA0: sets
; DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Data to $c0 (E-0347)
; why: a helper of DrawSlotStatusMarks_BankA0; DrawSlotStatusMarks_BankA0: C = slot 0-2: when the
; slot is present and its status byte 0 is non-zero, calls one marker routine for each of bits 0, 1,
; 4, 5, 6 and 7 ... (E-0352, E-0111)
DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_2::
    push hl
    ld hl, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Data
    call ReadWordTableEntryForSlotC_BankA0
    ld [hl], $c0
    pop hl
    ret

; called from DrawSlotStatusMarks_BankA0: sets
; DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Data_3 to $c1 (E-0347)
; why: a helper of DrawSlotStatusMarks_BankA0; DrawSlotStatusMarks_BankA0: C = slot 0-2: when the
; slot is present and its status byte 0 is non-zero, calls one marker routine for each of bits 0, 1,
; 4, 5, 6 and 7 ... (E-0352, E-0111)
DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_3::
    push hl
    ld hl, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Data_3
    call ReadWordTableEntryForSlotC_BankA0
    ld [hl], $c1
    pop hl
    ret

; called from DrawSlotStatusMarks_BankA0: sets
; DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Data_3 to $c7 (E-0347)
; why: a helper of DrawSlotStatusMarks_BankA0; DrawSlotStatusMarks_BankA0: C = slot 0-2: when the
; slot is present and its status byte 0 is non-zero, calls one marker routine for each of bits 0, 1,
; 4, 5, 6 and 7 ... (E-0352, E-0111)
DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_4::
    push hl
    ld hl, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Data_3
    call ReadWordTableEntryForSlotC_BankA0
    ld [hl], $c7
    pop hl
    ret

; called from DrawSlotStatusMarks_BankA0: sets
; DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Data_4 to $c8 (E-0347)
; why: a helper of DrawSlotStatusMarks_BankA0; DrawSlotStatusMarks_BankA0: C = slot 0-2: when the
; slot is present and its status byte 0 is non-zero, calls one marker routine for each of bits 0, 1,
; 4, 5, 6 and 7 ... (E-0352, E-0111)
DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_5::
    push hl
    ld hl, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Data_4
    call ReadWordTableEntryForSlotC_BankA0
    ld [hl], $c8
    pop hl
    ret

; called from DrawSlotStatusMarks_BankA0: sets
; DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Data_2 to $c9 (E-0347)
; why: a helper of DrawSlotStatusMarks_BankA0; DrawSlotStatusMarks_BankA0: C = slot 0-2: when the
; slot is present and its status byte 0 is non-zero, calls one marker routine for each of bits 0, 1,
; 4, 5, 6 and 7 ... (E-0352, E-0111)
DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_6::
    push hl
    ld hl, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Data_2
    call ReadWordTableEntryForSlotC_BankA0
    ld [hl], $c9
    pop hl
    ret

; called from DrawSlotStatusMarks_BankA0: sets DrawSlotStatusMarks_BankA0_Data to $ca (E-0347)
; why: a helper of DrawSlotStatusMarks_BankA0; DrawSlotStatusMarks_BankA0: C = slot 0-2: when the
; slot is present and its status byte 0 is non-zero, calls one marker routine for each of bits 0, 1,
; 4, 5, 6 and 7 ... (E-0352, E-0111)
DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_7::
    push hl
    ld hl, DrawSlotStatusMarks_BankA0_Data
    call ReadWordTableEntryForSlotC_BankA0
    ld [hl], $ca
    pop hl
    ret

; the same 13 bytes as ReadWordTableEntryForSlotC (ReadWordTableEntryForSlotC) (E-0110)
ReadWordTableEntryForSlotC_BankA0::
    ld a, c
    and $03
    add a
    add l
    ld l, a
    jr nc, DerefHL_BankA0
    inc h

; the same 4 bytes as DerefHL_Bank31 (DerefHL_Bank31) (E-0110)
DerefHL_BankA0::
    deref_hl
    ret

; data read by DrawSlotStatusMarks (4 bytes) (E-0347)
DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Data::
    db $39, $c2, $46, $c2

DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Data_2::
    db $3a, $c2, $47, $c2

DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Data_3::
    db $3b, $c2, $48, $c2

DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Data_4::
    db $3c, $c2, $49, $c2

DrawSlotStatusMarks_BankA0_Data::
    db $3d, $c2, $4a, $c2

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

; C = slot 0-2: writes tiles $EA, $AF (not in the charmap; probably a level mark) into
; wScreenTileBuffer at the position from DrawSlotLevel_BankA0_Data, then the value
; wBattleLevel[slot] as digits (probably the level; the digit part is not read to its end) (E-0111)
; code: branches on C; branches on C & $03; sets DrawSlotLevel_BankA0_Data to $ea; sets
; DrawSlotLevel_BankA0_Data to $af; calls HLToDecimalDigits; calls WriteTwoDigitTilesFromDigits1;
; also changes HL, DE, BC and A by register arithmetic (E-0347)
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

; data read by DrawSlotHPDigits (4 bytes) (E-0347)
DrawSlotHPDigits_BankA0_Data::
    db $62, $00, $6f, $00

DrawSlotMPDigits_BankA0_Data::
    db $82, $00, $8f, $00

DrawSlotLevel_BankA0_Data::
    db $a1, $00, $ae, $00

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
