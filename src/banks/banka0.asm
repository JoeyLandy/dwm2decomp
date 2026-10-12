SECTION "Bank A0", ROMX[$4000], BANK[$A0]
    db $A0

; only called from GameMode7_Init (E-0047)
; 1 call site from 1 routine (e.g. GameMode7_Init)
; reads: wDataBank
; writes: wDataBankSave, wBattleKind
; points at: wEffectAnimState, wBattlePhase, wListPageSize, wWorkBuf
GameMode7_Init_FillBytes::
Func_0A0_4001:: ; address name
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
    ld a, $0A
    ld [wBattleKind], a
    call GameMode7_Init_Sub01_FillBytes
    ld hl, wWorkBuf
    ld bc, $0200
    xor a, a
    call FillBytes
    call GameMode7_Init_Sub01_ReadLinkRole
    call GameMode7_Init_Sub01_RunA04410Or456FBySlotC
    call GameMode7_Init_Sub01_ClearAttributesAndScreenBuffer_Bank31
    call GameMode7_Init_Sub01_QueueMusic
    call GameMode7_Init_Sub01_CarryUnlessBattleSlotOutSlotEmpty
    ret

; clears the slot-out bytes of slots 4-7, marking the last one absent ($FF) unless wScreenCountPlusOne is 2, then checks the slots (CarryUnlessBattleSlotOutSlotEmpty)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_InitBattleSlotsForFoeCount)
; reads: wScreenCountPlusOne
; writes: wBattleTurn
; points at: wSlotMarks, wBattleArg0
InitBattleSlotsForFoeCount::
Func_0A0_4047:: ; address name
    xor a, a
    ld hl, wBattleSlotOut + $4
    ld [hl+], a
    ld [hl+], a
    ld a, [wScreenCountPlusOne]
    cp a, $02
    jr z, .skip
    xor a, a
    ld [hl+], a
    ld a, $FF
    ld [hl], a
    jr .call_carry_unless_battle_slot_out_slot_empty

.skip:
    ld a, $FF
    ld [hl+], a
    ld [hl], a

.call_carry_unless_battle_slot_out_slot_empty:
    ld hl, wSlotMarks
    ld a, $00
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .call_carry_unless_battle_slot_out_slot_empty2
    ld a, $03

.call_carry_unless_battle_slot_out_slot_empty2:
    ld [hl+], a
    ld a, $01
    call CarryUnlessBattleSlotOutSlotEmpty
    ld a, $00
    jr nc, .skip2
    ld a, $03

.skip2:
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    ld a, $03
    call CarryUnlessBattleSlotOutSlotEmpty
    ld a, $00
    jr nc, .skip3
    ld a, $FF

.skip3:
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl+], a
    ld a, [wScreenCountPlusOne]
    cp a, $02
    jr z, .skip4
    ld a, $01
    ld [hl+], a
    ld a, $FF
    ld [hl], a
    jr .clear_battle_turn

.skip4:
    ld a, $FF
    ld [hl+], a
    ld [hl], a

.clear_battle_turn:
    xor a, a
    ld [wBattleTurn], a
    ld hl, wBattleArg0
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ret

; only called from GameMode7_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode7_Init_FillBytes)
; reads: wBattleResultByte
; writes: wEffectId, wQueuedActionId, wBattleByteAD, wBattleFlag92, wDebugValue3, wDebugState, wDebugSubState, wDisplaySlot, ...
; points at: wMenuState, wSlotMarks, wSideControl, wBattleSlotOut, wBattleMonsterId, wSlotNameBytes, wActionQueue
GameMode7_Init_Sub01_FillBytes::
Func_0A0_40B0:: ; address name
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
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, $FF
    ld [hl], a
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
    ld bc, $0020
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
    ld [wBattleKindFlags], a
    ret

; only called from GameMode7_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode7_Init_FillBytes)
; writes: wBGPaletteUploadRequest
GameMode7_Init_Sub01_ClearAttributesAndScreenBuffer_Bank31::
Func_0A0_415D:: ; address name
    farcall ClearAttributesAndScreenBuffer_Bank31
    call GameMode7_Init_Sub01_Sub02_CopyGlyphTilesToVRAM
    call GameMode7_Init_Sub01_Sub02_ReadScreenBufferRectHeader_BankA0
    call GameMode7_Init_Sub01_Sub02_DrawSlotPanelValues_BankA0
    call FillTilesFromRequest
    farcall CopyRectRecord7345ToScreenBuffer
    ld hl, vBGMap0
    call CopyScreenTileBufferToVRAM_A0
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    ret

; only called from GameMode7_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode7_Init_FillBytes)
GameMode7_Init_Sub01_RunA04410Or456FBySlotC::
Func_0A0_4181:: ; address name
    ld bc, $0200

.loop:
    push bc
    call RunA04410Or456FBySlotC
    pop bc
    inc c
    dec b
    jr nz, .loop
    ret

; runs the slot setup (RunA04410Or456FBySlotC) for slots 4-5, then falls into the shared loop's tail: AdjustSkillsForBattleStart_A0 and the slot damage flags
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_InitBattleSlotsForFoeCount)
; reads: wSpeciesRecord
; writes: wSpeciesIdLo, wSpeciesIdHi
; points at: wSlotDamageFlags, wBattleSlotOut, wBattleMonsterId
PrepareTwoFoeSlots::
Func_0A0_418E:: ; address name
    ld bc, $0204
    jr PrepareThreeFoeSlots_Loop

; runs the slot setup (RunA04410Or456FBySlotC) for slots 4-6, then AdjustSkillsForBattleStart_A0 and the slot damage flags
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_InitBattleSlotsForFoeCount)
; reads: wSpeciesRecord
; writes: wSpeciesIdLo, wSpeciesIdHi
; points at: wSlotDamageFlags, wBattleSlotOut, wBattleMonsterId
PrepareThreeFoeSlots::
Func_0A0_4193:: ; address name
    ld bc, $0304

PrepareThreeFoeSlots_Loop::
Jump_0A0_4196:: ; address name
    push bc
    call RunA04410Or456FBySlotC
    pop bc
    inc c
    dec b
    jr nz, PrepareThreeFoeSlots_Loop
    call AdjustSkillsForBattleStart_A0
    ld de, wSlotDamageFlags
    ld bc, $0800

.loop:
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
    jr nz, .loop
    ret

; zero-fills the 47 bytes of wSpeciesRecord, where LoadSpeciesRecord writes; BC, HL kept (E-0067) (the same 15 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. RunA04410Or456FBySlotC)
; points at: wSpeciesRecord
ClearSpeciesRecordBuffer_BankA0::
Func_0A0_41E3:: ; address name
    push bc
    push hl
    ld hl, wSpeciesRecord
    ld bc, $002F
    xor a, a
    call FillBytes
    pop hl
    pop bc
    ret

; replaces skill $8F by $AA for slots without wD8AF set and marks skills $34 and $35 of the foe slots with tiles $AD and $AE (E-0127)
; 1 call site from 1 routine (e.g. PrepareThreeFoeSlots)
; points at: wSlotNameSuffix, wBattleSkills
AdjustSkillsForBattleStart_A0::
Func_0A0_41F2:: ; address name
    ld bc, $0800
    ld hl, wSlotNameSuffix

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, [hl]
    or a, a
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
    cp a, $FF
    jr z, .next3
    cp a, $34
    jr nz, .cp_35
    call StoreTileADAtHL_BankA0
    jr .next2

.cp_35:
    cp a, $35
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
; 1 call site from 1 routine (e.g. AdjustSkillsForBattleStart_A0)
; points at: wBattleSkills
ReplaceSkill8FWithAAInSlotC_A0::
Func_0A0_4240:: ; address name
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

; [HL] = $AD (E-0116)
; 1 call site from 1 routine (e.g. AdjustSkillsForBattleStart_A0)
StoreTileADAtHL_BankA0::
Func_0A0_4262:: ; address name
    ld [hl], $AD
    ret

; [HL] = $AE (E-0116)
; 1 call site from 1 routine (e.g. AdjustSkillsForBattleStart_A0)
StoreTileAEAtHL_BankA0::
Func_0A0_4265:: ; address name
    ld [hl], $AE
    ret

; only called from routines of RunA04410Or456FBySlotC (E-0098)
; 2 call sites from 2 routines (e.g. RunA04410Or456FBySlotC_BattlerRecordAddress_BankA0, RunA04410Or456FBySlotC_BattlerRecordAddress_BankA0_Sub02)
; points at: wBattleSlotOut, wBattleStatus
RunA04410Or456FBySlotC_Shared01::
Func_0A0_4268:: ; address name
    push hl
    ld a, c
    ld de, wBattleSlotOut
    add a, e
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
    add a, a
    add a, a
    add a, a
    add a, c
    add a, e
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
    or a, $01
    ld [de], a

.done:
    pop hl
    ret

; DE += C; copies the byte at HL to [DE]; HL += 1 (the same 9 bytes appear in 2 banks)
; 10 call sites from 2 routines (e.g. RunA04410Or456FBySlotC_BattlerRecordAddress_BankA0, RunA04410Or456FBySlotC_BattlerRecordAddress_BankA0_Sub02)
StoreByteAtDEPlusC_BankA0::
Func_0A0_429C:: ; address name
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
; 22 call sites from 2 routines (e.g. RunA04410Or456FBySlotC_BattlerRecordAddress_BankA0, RunA04410Or456FBySlotC_BattlerRecordAddress_BankA0_Sub02)
StoreWordAtDEPlus2C_BankA0::
Func_0A0_42A5:: ; address name
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

; copies the 20 x 18 screen tile buffer to the BG map at HL (32-byte rows) (E-0124)
; 3 call sites from 3 routines (e.g. GameMode7_Init_Sub01_ClearAttributesAndScreenBuffer_Bank31, RunBattlePhaseWhenTextIdle_A0_ResultsScreen_CopyScreenTileBufferToVRAM_A0_Case05, RunBattlePhaseWhenTextIdle_A0_ResultsScreen_CopyScreenTileBufferToVRAM_A0)
; points at: wScreenTileBuffer
CopyScreenTileBufferToVRAM_A0::
Func_0A0_42B2:: ; address name
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

; only called from GameMode7_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode7_Init_FillBytes)
; reads: wBattleKind
GameMode7_Init_Sub01_QueueMusic::
Func_0A0_42D3:: ; address name
    ld a, [wBattleKind]
    or a, a
    jr nz, .call_queue_music
    ld a, $0F
    jr .call_queue_music2

.call_queue_music:
    ld a, $13

.call_queue_music2:
    call QueueMusic
    ret

; only called from GameMode7_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode7_Init_FillBytes)
; reads: wLinkRole
; points at: wBattlerRecords, wRecordBufA, wRecordBufB
GameMode7_Init_Sub01_ReadLinkRole::
Func_0A0_42E3:: ; address name
    ld de, wBattlerRecords
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .call_game_mode7_init_sub01_sub05_copy_bytes
    ld hl, wRecordBufA
    call GameMode7_Init_Sub01_Sub05_CopyBytesDEFromHL_BankA0
    ld hl, wRecordBufB
    jr GameMode7_Init_Sub01_Sub05_CopyBytesDEFromHL_BankA0

.call_game_mode7_init_sub01_sub05_copy_bytes:
    ld hl, wRecordBufB
    call GameMode7_Init_Sub01_Sub05_CopyBytesDEFromHL_BankA0
    ld hl, wRecordBufA

; only called from GameMode7_Init_Sub01_Sub05 (E-0047)
; 2 call sites from 1 routine (e.g. GameMode7_Init_Sub01_ReadLinkRole)
GameMode7_Init_Sub01_Sub05_CopyBytesDEFromHL_BankA0::
Func_0A0_4301:: ; address name
    inc hl
    ld b, $0E
    call CopyBytesDEFromHL_BankA0
    ld a, l
    add a, $25
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $08
    call CopyBytesDEFromHL_BankA0
    xor a, a
    ld [de], a
    inc de
    ld a, l
    add a, $1A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $01
    call CopyBytesDEFromHL_BankA0
    inc hl
    ld b, $15
    call CopyBytesDEFromHL_BankA0
    inc hl
    inc hl
    ld b, $1F
    call CopyBytesDEFromHL_BankA0
    ld a, l
    add a, $16
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    ld [de], a
    inc de
    call ApplyIncrementOffsetRowsA0ForA0DTo13
    ld a, $FF
    ld [de], a
    inc de
    ret

; the same 7 bytes as CopyBytesDEFromHL (34:406E)
; 5 call sites from 1 routine (e.g. GameMode7_Init_Sub01_Sub05_CopyBytesDEFromHL_BankA0)
CopyBytesDEFromHL_BankA0::
Func_0A0_4344:: ; address name
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, CopyBytesDEFromHL_BankA0
    ret

; for A in $0D-$13 increments (capped at 3) each byte listed in Data_0A0_4387 row A - $0D, relative to DE (E-0125)
; 1 call site from 1 routine (e.g. GameMode7_Init_Sub01_Sub05_CopyBytesDEFromHL_BankA0)
; writes: hTemp0, hTemp1
ApplyIncrementOffsetRowsA0ForA0DTo13::
Func_0A0_434B:: ; address name
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
    ld de, IncrementOffsetRows_A0
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    cp a, $80
    jr nz, .call_increment_table_byte_capped_at3_bank_a0
    pop de
    ret

.call_increment_table_byte_capped_at3_bank_a0:
    ld l, a
    ld h, $FF
    call IncrementTableByteCappedAt3_BankA0
    inc de
    jr .skip

; increments the byte at HL + the word hFFC6/hFFC7 unless it is already 3 or more (the bank-$A0 copy of IncrementTableByteCappedAt3) (E-0118)
; 1 call site from 1 routine (e.g. ApplyIncrementOffsetRowsA0ForA0DTo13)
; reads: hTemp0, hTemp1
IncrementTableByteCappedAt3_BankA0::
Func_0A0_4378:: ; address name
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

; E-0236 (C1: ApplyIncrementOffsetRowsA0ForA0DTo13 takes A in $0D-$13, reads row 16 * (A - $0D) and for each byte before $80 increments the byte at DE + $FF00 + byte, capped at 3 (IncrementTableByteCappedAt3); 7 rows; the bank $19 and $A0 copies are identical).
; record: offsets ($FF00 + byte, added to the base in DE) of the bytes to increment, up to $80, then zero padding
IncrementOffsetRows_A0::
Data_0A0_4387:: ; address name
    db $E5, $E6, $E7, $E8, $E9, $EA, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 13
    db $F5, $F6, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 14
    db $EC, $F0, $F7, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 15
    db $EC, $F0, $F7, $F8, $F9, $EB, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 16
    db $EC, $F0, $F7, $F8, $F9, $ED, $F3, $EB, $EF, $80, $00, $00, $00, $00, $00, $00 ; id 17
    db $FF, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 18
    db $FA, $FB, $FC, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 19

; runs Func_0A0_4410 for slots 0-3 or Func_0A0_456F for slots 4-7, clears the species record buffer and restores wD868 (E-0122)
; 2 call sites from 2 routines (e.g. GameMode7_Init_Sub01_RunA04410Or456FBySlotC, PrepareThreeFoeSlots)
; reads: wBattleArg0
; writes: wBattleArg0
RunA04410Or456FBySlotC::
Func_0A0_43F7:: ; address name
    ld a, [wBattleArg0]
    push af
    ld a, c
    cp a, $04
    jr nc, .call_run_a04410_or456_f_by_slot_c_battler
    call RunA04410Or456FBySlotC_BattlerRecordAddress_BankA0
    jr .call_clear_species_record_buffer_bank_a0

.call_run_a04410_or456_f_by_slot_c_battler:
    call RunA04410Or456FBySlotC_BattlerRecordAddress_BankA0_Sub02

.call_clear_species_record_buffer_bank_a0:
    call ClearSpeciesRecordBuffer_BankA0
    pop af
    ld [wBattleArg0], a
    ret

; only called from RunA04410Or456FBySlotC (E-0047)
; 1 call site from 1 routine (e.g. RunA04410Or456FBySlotC)
; reads: wLinkRole, wBattleArg0, wLoadSlot
; writes: wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3
; points at: wBattleMonsterId, wSlotNameSuffix, wSlotTactic, wSlotLastTactic, wBattleSetupD8, wBattleLevel, wBattleMaxHP, wBattleMaxMP, ...
RunA04410Or456FBySlotC_BattlerRecordAddress_BankA0::
Func_0A0_4410:: ; address name
    ld a, c
    push bc
    call BattlerRecordAddress_BankA0
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
    ld a, c
    cp a, $04
    jr nc, .check_link_role
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .restore3
    ld a, c
    ld de, wBattleSetupD8
    add a, e
    ld e, a
    jr nc, .restore
    inc d

.restore:
    pop af
    and a, $03
    ld [de], a
    jr .check_battle_arg0

.check_link_role:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .restore3
    ld a, c
    and a, $03
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
    farcall LoadSlotSkillsFromBattlerRecord
    jr .restore4

.call_set_c_from_battle_arg0_then_run_load:
    farcall SetCFromBattleArg0ThenRunLoadSlotSkillsFromBattlerRecord

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
    call z, RunA04410Or456FBySlotC_Shared01
    inc hl
    ld de, wBattleLevel
    call StoreByteAtDEPlusC_BankA0
    inc hl
    inc hl
    inc hl
    ld a, [wLoadSlot]
    or a, a
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
    ld de, wBattleWordArray3F
    call StoreWordAtDEPlus2C_BankA0
    ld a, [wLoadSlot]
    or a, a
    jr z, .call_store_byte_at_de_plus_c_bank_a0
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
    add a, a
    add a, c
    add a, a
    add a, c
    ld de, wSlotResistances
    add a, e
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

; only called from RunA04410Or456FBySlotC (E-0047)
; 1 call site from 1 routine (e.g. RunA04410Or456FBySlotC)
; reads: wBattleArg0, wLoadSlot
; writes: wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3
; points at: wBattleMonsterId, wSlotNameSuffix, wSlotTactic, wBattleLevel, wBattleMaxHP, wBattleMaxMP, wBattleATK, wBattleDEF, ...
RunA04410Or456FBySlotC_BattlerRecordAddress_BankA0_Sub02::
Func_0A0_456F:: ; address name
    push bc
    call BattlerRecordAddress_BankA0
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
    farcall LoadSlotSkillsFromBattlerRecord
    jr .restore

.call_set_c_from_battle_arg0_then_run_load:
    farcall SetCFromBattleArg0ThenRunLoadSlotSkillsFromBattlerRecord

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
    call z, RunA04410Or456FBySlotC_Shared01
    inc hl
    ld de, wBattleLevel
    call StoreByteAtDEPlusC_BankA0
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, [wLoadSlot]
    or a, a
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
    ld de, wBattleWordArray3F
    call StoreWordAtDEPlus2C_BankA0
    ld a, [wLoadSlot]
    or a, a
    jr z, .call_store_byte_at_de_plus_c_bank_a0
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
    add a, a
    add a, c
    add a, a
    add a, c
    ld de, wSlotResistances
    add a, e
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

; A = battle slot: for slots 3 and 7 returns at once with Z set and HL unchanged; otherwise HL = wBattlerRecords + $4E * A' with A' = A - 1 for slots 4-6 (as BattlerRecordFieldAddress without the field offset) (E-0067) (the same 23 bytes appear in 2 banks)
; 2 call sites from 2 routines (e.g. RunA04410Or456FBySlotC_BattlerRecordAddress_BankA0, RunA04410Or456FBySlotC_BattlerRecordAddress_BankA0_Sub02)
BattlerRecordAddress_BankA0::
Func_0A0_468A:: ; address name
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

; only called from GameMode7_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode7_Init_FillBytes)
; points at: wSlotMarks
GameMode7_Init_Sub01_CarryUnlessBattleSlotOutSlotEmpty::
Func_0A0_46A1:: ; address name
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
    ld [hl], $FF

.next:
    inc c
    inc hl
    dec b
    jr nz, .loop
    ret

; ComputeWildEncounterLevel, then ApplyLevelScaledStatsToSlots
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_InitBattleSlotsForFoeCount)
ComputeWildLevelAndScaleStats::
Func_0A0_46C3:: ; address name
    push bc
    call ComputeWildEncounterLevel
    pop bc
    call ApplyLevelScaledStatsToSlots
    ret

; computes the wild monster level wCFE3 and band wCFE4 from the party's stat totals (wD0F2-wD0FE) and size (E-0131)
; 1 call site from 1 routine (e.g. ComputeWildLevelAndScaleStats)
; reads: wBattlerRecords, wBattlerRecordSlot1
; writes: wWildLevel, wWildBand
ComputeWildEncounterLevel::
Func_0A0_46CC:: ; address name
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
    sub a, l
    ld l, a
    ld a, d
    sbc a, h
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
    or a, a
    jr nz, .skip2
    ld a, l
    cp a, $64
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
    sub a, l
    ld l, a
    ld a, d
    sbc a, h
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
    or a, a
    jr nz, .skip5
    ld a, l
    cp a, $64
    jr c, .restore3

.skip5:
    ld hl, $0063

.restore3:
    pop bc
    ld a, l
    or a, c
    jr z, .skip6
    ld a, l
    or a, a
    jr z, .skip7
    ld a, c
    or a, a
    jr z, .skip8
    ld a, l
    cp a, c
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
    or a, a
    jr z, .skip9
    cp a, $14
    jr c, .skip9
    cp a, $28
    jr c, .skip10
    cp a, $32
    jr c, .skip11
    cp a, $3C
    jr c, .skip12
    cp a, $46
    jr c, .skip13
    cp a, $50
    jr c, .skip14
    cp a, $5A
    jr c, .set_wild_band_to_06
    ld a, $07
    jr .set_wild_band

.skip9:
    xor a, a
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

; DE += the word at [HL]; HL += 1 (ends on the high byte); clobbers A
; 24 call sites from 1 routine (e.g. ComputeWildEncounterLevel)
AddWordAtHLToDE::
Func_0A0_486D:: ; address name
    ld a, [hl+]
    add a, e
    ld e, a
    ld a, [hl]
    adc a, d
    ld d, a
    ret

; picks a monster for slot C from the band row Data_0A0_6D57 (PickRandomBand0To10, wCFE4) by a weighted roll and stores its id in wCFDD[C] (E-0127)
; 1 call site from 1 routine (e.g. ComputeWildEncounterLevel)
; reads: wWildBand
; points at: wRandomLo, wEncounterMonsters
PickEncounterMonsterForSlotC::
Func_0A0_4874:: ; address name
    push bc
    call PickRandomBand0To10
    add a, a
    add a, a
    add a, a
    add a, a
    ld hl, EncounterBandSpeciesTable
    add_a_to_hl
    ld a, [wWildBand]
    add a, a
    add_a_to_hl
    deref_hl
    ld a, [hl+]
    push hl
    or a, a
    jr z, .restore2
    ld b, a
    push bc
    ld b, $FF
    call DivideBByA
    ld d, b
    call AdvanceRandom
    pop bc
    ld c, $00
    ld hl, wRandomLo
    ld a, d

.loop:
    cp a, [hl]
    jr nc, .restore
    add a, d
    jr c, .restore2
    inc c
    dec b
    jr nz, .loop
    jr .restore2

.restore:
    pop hl
    ld a, c
    add a, a
    add_a_to_hl
    pop bc
    ld de, wEncounterMonsters
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
    ld a, [hl]
    ld [de], a
    ret

.restore2:
    pop hl
    pop bc
    jr PickEncounterMonsterForSlotC

; draws a random value and returns its band in the 11-entry threshold table Data_0A0_48F5; band 10 is redrawn while wCFE4 < 6 (E-0124)
; 1 call site from 1 routine (e.g. PickEncounterMonsterForSlotC)
; reads: wRandomLo, wWildBand
PickRandomBand0To10::
Func_0A0_48D0:: ; address name
    call AdvanceRandom
    ld a, [wRandomLo]
    ld bc, $0B00
    ld hl, PickRandomBand0To10_Data

.loop:
    cp a, [hl]
    jr c, .skip
    inc hl
    inc c
    dec b
    jr nz, .loop
    dec c

.skip:
    ld a, c
    cp a, $0A
    jr nz, .done
    ld a, [wWildBand]
    cp a, $06
    jr nc, .done
    jr PickRandomBand0To10

.done:
    ld a, c
    ret

; address loaded by PickRandomBand0To10
PickRandomBand0To10_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0A0_48F5:: ; address name
    db $19, $32, $4B, $64, $7D, $96, $AF, $C8, $E1, $FA, $FF

; copies battler records 0 and 1 ($4E bytes each, wBattlerRecords and wD123) to wD1BF and wD20D (E-0118)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_InitBattleSlotsForFoeCount)
; points at: wBattlerRecords, wBattlerRecordSlot4, wBattlerRecordSlot1, wBattlerRecordSlot5
BackupBattlerRecords0And1::
Func_0A0_4900:: ; address name
    ld hl, wBattlerRecords
    ld de, wBattlerRecordSlot4
    ld bc, $004E
    call CopyBytes
    ld hl, wBattlerRecordSlot1
    ld de, wBattlerRecordSlot5
    ld bc, $004E
    call CopyBytes
    ret

; hFFC7 = min(4 * wCFE3 / 5 + 5, 99); runs Func_0A0_494F for B slots from C with wD86A = Data_0A0_4B0A[slot] (E-0125)
; 1 call site from 1 routine (e.g. ComputeWildLevelAndScaleStats)
; reads: wWildLevel
; writes: hTemp1, wBattleArg2, wBattleArg3
ApplyLevelScaledStatsToSlots::
Func_0A0_4919:: ; address name
    push de
    ld a, [wWildLevel]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, $05
    call DivideHLByA
    ld a, $05
    add a, l
    pop de
    cp a, $64
    jr c, .set_temp1
    ld a, $63

.set_temp1:
    ldh [hTemp1], a

.loop:
    push bc
    ld a, c
    ld hl, ApplyLevelScaledStatsToSlots_Data
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld [wBattleArg2], a
    ld a, [hl]
    ld [wBattleArg3], a
    call ApplyLevelScaledStatsToSlots_LoadSpeciesRecord
    pop bc
    inc c
    dec b
    jr nz, .loop
    ret

; only called from ApplyLevelScaledStatsToSlots (E-0047)
; 1 call site from 1 routine (e.g. ApplyLevelScaledStatsToSlots)
; reads: wBattleArg2, wBattleArg3, wSpeciesIdLo, wSpeciesIdHi, wSpeciesRecord, hTemp1
; writes: wBattleArg1, wSpeciesIdLo, wSpeciesIdHi, hTemp0, wBattleArg0
; points at: wEncounterMonsters
ApplyLevelScaledStatsToSlots_LoadSpeciesRecord::
Func_0A0_494F:: ; address name
    push bc
    ld a, c
    ld [wBattleArg1], a
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
    ld a, [wSpeciesRecord + SPECIES_SKILLS]
    ld [hl+], a
    ld a, [wSpeciesRecord + SPECIES_SKILLS + 1]
    ld [hl+], a
    ld a, [wSpeciesRecord + SPECIES_SKILLS + 2]
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
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    push hl
    ld a, [wSpeciesRecord + $C]
    ldh [hTemp0], a
    farcall StatFromGrowthRow
    pop hl
    ld a, $01
    ld [wBattleArg0], a
    call ScaleStatByWildLevelCapped999
    call StoreTemp2WordAtHL_BankA0
    ld a, [wSpeciesRecord + $D]
    ldh [hTemp0], a
    push hl
    farcall StatFromGrowthRow
    pop hl
    ld a, $00
    ld [wBattleArg0], a
    call ScaleStatByWildLevelCapped999
    call StoreTemp2WordAtHL_BankA0
    ld a, [wSpeciesRecord + $E]
    ldh [hTemp0], a
    push hl
    farcall StatFromGrowthRow
    pop hl
    call ScaleStatByWildLevelCapped999
    ld a, [wSpeciesRecord + $F]
    ldh [hTemp0], a
    push hl
    farcall StatFromGrowthRow
    pop hl
    call ScaleStatByWildLevelCapped999
    ld a, [wSpeciesRecord + SPECIES_GROWTH]
    ldh [hTemp0], a
    push hl
    farcall StatFromGrowthRow
    pop hl
    call ScaleStatByWildLevelCapped999
    ld a, [wSpeciesRecord + $11]
    ldh [hTemp0], a
    push hl
    farcall StatFromGrowthRow
    pop hl
    call ScaleStatByWildLevelCapped999
    ld a, $E7
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    call StoreRandomByteAtHL_BankA0
    call StoreRandomByteAtHL_BankA0
    call StoreRandomByteAtHL_BankA0
    call StoreRandomByteAtHL_BankA0
    call CopyWD01ARecordToHL_BankA0
    ld a, $00
    ld [hl+], a
    ld a, $07
    ld [hl+], a
    call RollRecordField0DState_A0
    farcall CheckSkillsLearnableAtLevel
    ld a, [wBattleArg2]
    ld e, a
    ld a, [wBattleArg3]
    ld d, a
    pop bc
    ret

; advances the random table (NextTableByte) and stores the new wC5E7 at HL; HL += 1; AF, BC, DE kept apart from A = the byte (E-0067) (the same 16 bytes appear in 2 banks)
; 4 call sites from 1 routine (e.g. ApplyLevelScaledStatsToSlots_LoadSpeciesRecord)
; reads: wRandomLo
StoreRandomByteAtHL_BankA0::
Func_0A0_4A45:: ; address name
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

; the word hFFC8 = hFFC8 * (wCFE3 / 4 + 100) / 100, capped at 999, stored at [HL+] (E-0125)
; 6 call sites from 1 routine (e.g. ApplyLevelScaledStatsToSlots_LoadSpeciesRecord)
; reads: hTemp2, hTemp3, wWildLevel
; writes: hTemp2, hTemp3
ScaleStatByWildLevelCapped999::
Func_0A0_4A55:: ; address name
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
    and a, $3F
    add a, $64
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    ld a, e
    or a, a
    jr nz, .set_temp2
    ld bc, $03E7
    ld a, c
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    bit 7, b
    jr nz, .set_temp2
    jr .set_temp22

.set_temp2:
    ld hl, $03E7

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
    ld [hl+], a
    ldh a, [hTemp3]
    ld [hl+], a
    ret

; stores hFFC8 then hFFC9 at HL; HL += 2; clobbers A (E-0065) (the same 7 bytes appear in 2 banks)
; 2 call sites from 1 routine (e.g. ApplyLevelScaledStatsToSlots_LoadSpeciesRecord)
; reads: hTemp2, hTemp3
StoreTemp2WordAtHL_BankA0::
Func_0A0_4A97:: ; address name
    ldh a, [hTemp2]
    ld [hl+], a
    ldh a, [hTemp3]
    ld [hl+], a
    ret

; copies the 27 ($1B) bytes at wD01A to HL; HL ends past the copy; clobbers A, B, DE (E-0065) (the same 12 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. ApplyLevelScaledStatsToSlots_LoadSpeciesRecord)
CopyWD01ARecordToHL_BankA0::
Func_0A0_4A9E:: ; address name
    ld de, wSpeciesRecord + SPECIES_RESISTANCES
    ld b, $1B

.loop:
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, .loop
    ret

; field $0D of record wD86A: values 1, 2 and others roll with thresholds 2, $80 and $E6 and become 1 or 0 (E-0125)
; 1 call site from 1 routine (e.g. ApplyLevelScaledStatsToSlots_LoadSpeciesRecord)
; reads: wBattleArg2, wBattleArg3, wRandomLo
RollRecordField0DState_A0::
Func_0A0_4AAA:: ; address name
    ld a, [wBattleArg2]
    add a, $0D
    ld l, a
    ld a, [wBattleArg3]
    adc a, $00
    ld h, a
    ld a, [hl]
    or a, a
    jr z, .done2
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
    jr c, .done
    xor a, a
    jr .done2

.done:
    ld a, $01

.done2:
    ld [hl], a
    ret

; the same 38 bytes as Multiply24By8 (19:4A74)
; no direct call (reached through a table, a jump or a vector)
Multiply24By8_BankA0:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 19:4A74; C0
Func_0A0_4AE4:: ; address name
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

; address loaded by ApplyLevelScaledStatsToSlots
ApplyLevelScaledStatsToSlots_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0A0_4B0A:: ; address name
    db $BF, $D1, $0D, $D2, $5B, $D2

; only called from GameMode7_Init_Sub01_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. GameMode7_Init_Sub01_ClearAttributesAndScreenBuffer_Bank31)
; reads: wLinkRole
; writes: wNameGlyphBuf
; points at: wBattlerRecords, wNameGlyphBuf, wBattlerRecordSlot1, wPlayerName, wLinkSeedCopy
GameMode7_Init_Sub01_Sub02_CopyGlyphTilesToVRAM::
Func_0A0_4B10:: ; address name
    ld a, $90
    ld [wNameGlyphBuf], a
    ld [wNameGlyphBuf + $1], a
    ld [wNameGlyphBuf + $2], a
    ld [wNameGlyphBuf + $3], a
    ld [wNameGlyphBuf + $4], a
    ld a, $F0
    ld [wNameGlyphBuf + $5], a
    ld de, vTiles1 + $500
    call CopyGlyphTilesToVRAM
    ld de, vTiles1 + $550
    call CopyGlyphTilesToVRAM
    ld de, vTiles1 + $5A0
    call CopyGlyphTilesToVRAM
    ld hl, wBattlerRecords
    ld de, wNameGlyphBuf
    ld bc, $000A
    call CopyBytes
    ld de, vTiles1 + $500
    call CopyGlyphTilesToVRAM
    ld hl, wBattlerRecordSlot1
    ld de, wNameGlyphBuf
    ld bc, $000A
    call CopyBytes
    ld de, vTiles1 + $550
    call CopyGlyphTilesToVRAM
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .skip
    ld hl, wPlayerName
    ld de, wNameGlyphBuf
    ld bc, $000A
    call CopyBytes
    ld de, vTiles1 + $5A0
    call CopyGlyphTilesToVRAM
    ld hl, wLinkSeedCopy
    jr .skip2

.skip:
    ld hl, wLinkSeedCopy
    ld de, wNameGlyphBuf
    ld bc, $000A
    call CopyBytes
    ld de, vTiles1 + $5A0
    call CopyGlyphTilesToVRAM
    ld hl, wPlayerName

.skip2:
    ld de, wNameGlyphBuf
    ld bc, $0400

.loop:
    ld a, [hl]
    cp a, $F0
    jr z, .call_copy_glyph_tiles_to_vram
    cp a, $8D
    jr z, .skip3
    cp a, $8E
    jr z, .skip3
    ld a, c
    cp a, $02
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
    ld a, $F0
    ld [wNameGlyphBuf + $3], a
    ld de, vTiles1 + $4B0
    call CopyGlyphTilesToVRAM
    ret

.skip4:
    ld a, $F0
    ld [de], a
    push hl
    push bc
    ld de, vTiles1 + $240
    call CopyGlyphTilesToVRAM
    ld a, $90
    ld [wNameGlyphBuf], a
    ld [wNameGlyphBuf + $1], a
    ld [wNameGlyphBuf + $2], a
    ld a, $F0
    ld [wNameGlyphBuf + $3], a
    ld de, vTiles1 + $4B0
    call CopyGlyphTilesToVRAM
    pop bc
    ld a, b
    add a, $06
    ld b, a
    pop hl
    ld de, wNameGlyphBuf

.loop2:
    ld a, [hl]
    cp a, $F0
    jr z, .skip6
    cp a, $8D
    jr z, .skip5
    cp a, $8E
    jr z, .skip5
    ld a, c
    cp a, $05
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
    ld a, $F0
    ld [de], a
    ld de, vTiles1 + $4B0
    call CopyGlyphTilesToVRAM
    ret

; Fills the $160 bytes at wC278 with $C3; clobbers A, BC, HL (the same 15 bytes appear in 2 banks)
; no direct call (reached through a table, a jump or a vector)
FillWC278WithC3_BankA0:: ; heuristic: follows a terminator; C0
Func_0A0_4C1D:: ; address name
    ld hl, wScreenTileBuffer + $E0
    ld bc, $0160

.loop:
    ld a, $C3
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ret

; only called from GameMode7_Init_Sub01_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. GameMode7_Init_Sub01_ClearAttributesAndScreenBuffer_Bank31)
GameMode7_Init_Sub01_Sub02_ReadScreenBufferRectHeader_BankA0::
Func_0A0_4C2C:: ; address name
    ld hl, TileRect_A0_4D37
    call ReadScreenBufferRectHeader_BankA0
    call CopyRectToStride32_BankA0
    ret

; copies rectangle Data_0A0_4DC7 to the screen buffer; unless bit 1 of wC57F is set, writes tiles $DA-$DE at wC1C3 (E-0122)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_ResultsScreen_DrawRect4DC7AndWriteDATiles)
; reads: wLinkRole
DrawRect4DC7AndWriteDATiles::
Func_0A0_4C36:: ; address name
    ld hl, TileRect_A0_4DC7
    call ReadScreenBufferRectHeader_BankA0
    call CopyRectToStride32_BankA0
    ld a, [wLinkRole]
    bit 1, a
    ret nz
    ld hl, wScreenTileBuffer + $2B
    ld b, $05
    ld a, $DA

.loop:
    ld [hl+], a
    inc a
    dec b
    jr nz, .loop
    ret

; only called from GameMode7_Init_Sub01_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. GameMode7_Init_Sub01_ClearAttributesAndScreenBuffer_Bank31)
GameMode7_Init_Sub01_Sub02_DrawSlotPanelValues_BankA0::
Func_0A0_4C52:: ; address name
    ld c, $00
    call DrawSlotPanelValues_BankA0
    ld c, $01

; DrawSlotHPDigits_BankA0, DrawSlotMPDigits_BankA0 and DrawSlotStatusMarks_BankA0 for slot C (E-0116)
; 1 call site from 1 routine (e.g. GameMode7_Init_Sub01_Sub02_DrawSlotPanelValues_BankA0)
DrawSlotPanelValues_BankA0::
Func_0A0_4C59:: ; address name
    call DrawSlotHPDigits_BankA0
    call DrawSlotMPDigits_BankA0
    call DrawSlotStatusMarks_BankA0
    ret

; runs BuildAndCopySlotPanel_A0 for slot 0 and falls into it for slot 1 (E-0126)
; no direct call (reached through a table, a jump or a vector)
BuildAndCopySlotPanels0And1_A0:: ; heuristic: follows a terminator; C0
Func_0A0_4C63:: ; address name
    ld c, $00
    call BuildAndCopySlotPanel_A0
    ld c, $01

; runs Func_0A0_6BF0 and 6C22 for slot C and copies its panel row to VRAM (E-0122)
; 1 call site from 1 routine (e.g. BuildAndCopySlotPanels0And1_A0)
BuildAndCopySlotPanel_A0::
Func_0A0_4C6A:: ; address name
    call CopySlotPanelPart6D47ToVRAM
    call CopySlotPanelPart6D4BToVRAM
    call CopySlotPanelRowToVRAM_BankA0
    ret

; copies a 20 x 5 rectangle from wC338 (rows 32 bytes apart) to vBGMap0 + $1A0 (row 13) with CopyRect32StrideToVRAM_BankA0, as DrawWC338RowsToBGMapRow13 does in bank $31 (E-0076)
; 7 call sites from 7 routines (e.g. RunBattleSetup_BankA0_EntrySelect_ClearAndLayoutTileBlocksForBattleFoeCount_Case07, RunBattleSetup_BankA0_EntrySelect_CopyRectRecord7345ToScreenBufferAndStep, RunBattleSetup_BankA0_CommandMenu_ShowButThereIsNo, RunBattleSetup_BankA0_CommandMenu_DrawWC338RowsToBGMapRow13_BankA0_Case13, ...)
DrawWC338RowsToBGMapRow13_BankA0::
Func_0A0_4C74:: ; address name
    ld de, wWindowTileBuffer + $38
    ld hl, vBGMap0 + $1A0
    ld bc, $1405
    call CopyRect32StrideToVRAM_BankA0
    ret

; only called from routines of RunBattleSetup_BankA0_EntrySelect (E-0098)
; 2 call sites from 2 routines (e.g. RunBattleSetup_BankA0_EntrySelect_ToCopyRect32StrideToVRAM_BankA0AndStep, RunBattleSetup_BankA0_EntrySelect_ToCopyRect32StrideToVRAM_BankA0_Case01)
RunBattleSetup_BankA0_EntrySelect_ToCopyRect32StrideToVRAM_BankA0::
Func_0A0_4C81:: ; address name
    ld de, wWindowTileBuffer + $38
    ld hl, vBGMap0 + $1A0
    ld bc, $0E05
    call CopyRect32StrideToVRAM_BankA0
    ret

; copies a 20 x 11 rectangle from wC278 to vBGMap0 + $E0 (row 7) with CopyRect32StrideToVRAM_BankA0 (E-0116)
; 3 call sites from 3 routines (e.g. RunBattleSetup_BankA0_CommandMenu_DrawWC278Rect20x11ToBGMapRow7_BankA0_Case04, RunBattleSetup_BankA0_CommandMenu_DrawWC278Rect20x11ToBGMapRow7_BankA0, RunBattleSetup_BankA0_CommandMenu_DrawWC278Rect20x11ToBGMapRow7_BankA0_Case01)
DrawWC278Rect20x11ToBGMapRow7_BankA0::
Func_0A0_4C8E:: ; address name
    ld de, wScreenTileBuffer + $E0
    ld hl, vBGMap0 + $E0
    ld bc, $140B
    call CopyRect32StrideToVRAM_BankA0
    ret

; copies an 11 x 9 rectangle from wC2B8 to vBGMap0 + $120 (row 9) with CopyRect32StrideToVRAM_BankA0 (E-0111)
; 4 call sites from 4 routines (e.g. RunBattleSetup_BankA0_CommandMenu_DrawWC2B8Rect11x9ToBGMapRow9_BankA0_Case0C, RunBattleSetup_BankA0_CommandMenu_DrawWC2B8Rect11x9ToBGMapRow9_BankA0AndStep, RunBattleSetup_BankA0_CommandMenu_DrawWC2B8Rect11x9ToBGMapRow9_BankA0_Case07, RunBattleSetup_BankA0_CommandMenu_DrawWC2B8Rect11x9ToBGMapRow9_BankA0)
DrawWC2B8Rect11x9ToBGMapRow9_BankA0::
Func_0A0_4C9B:: ; address name
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    ld bc, $0B09
    call CopyRect32StrideToVRAM_BankA0
    ret

; copies a 20 x 9 rectangle from wC2B8 to vBGMap0 + $120 (row 9), then wD868 = 1 (E-0116)
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleArg0
DrawWC2B8RowsToBGMapRow9_BankA0:: ; heuristic: follows a terminator; C0
Func_0A0_4CA8:: ; address name
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    ld bc, $1409
    call CopyRect32StrideToVRAM_BankA0
    ld a, $01
    ld [wBattleArg0], a
    ret

; copies an 8 x 9 rectangle from wC2B8 to vBGMap0 + $120 (row 9) (E-0116)
; no direct call (reached through a table, a jump or a vector)
DrawWC2B8LeftToBGMapRow9_BankA0:: ; heuristic: follows a terminator; C0
Func_0A0_4CBA:: ; address name
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    ld bc, $0809
    call CopyRect32StrideToVRAM_BankA0
    ret

; copies a 7 x 7 rectangle from wC2F8 to vBGMap0 + $160 (row 11) (E-0116)
; no direct call (reached through a table, a jump or a vector)
DrawWC2F8Rect7x7ToBGMapRow11_BankA0:: ; heuristic: follows a terminator; C0
Func_0A0_4CC7:: ; address name
    ld de, wScreenTileBuffer + $160
    ld hl, vBGMap0 + $160
    ld bc, $0707
    call CopyRect32StrideToVRAM_BankA0
    ret

; copies 7 x 1 from wC2A4 to vBGMap0 + $10C and 20 x 9 from wC2B8 to vBGMap0 + $120 (CopyRect32StrideToVRAM_BankA0) (E-0118)
; 3 call sites from 3 routines (e.g. RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount_Case10, RunBattleSetup_BankA0_CommandMenu_DrawWC2A4AndWC2B8Rects_BankA0, RunBattleSetup_BankA0_CommandMenu_DrawWC2A4AndWC2B8Rects_BankA0_Case0D)
DrawWC2A4AndWC2B8Rects_BankA0::
Func_0A0_4CD4:: ; address name
    ld de, wScreenTileBuffer + $10C
    ld hl, vBGMap0 + $10C
    ld bc, $0701
    call CopyRect32StrideToVRAM_BankA0
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    ld bc, $1409
    call CopyRect32StrideToVRAM_BankA0
    ret

; copies a 13 x 7 rectangle from wC2F8 to vBGMap0 + $160 (row 11) (E-0116)
; no direct call (reached through a table, a jump or a vector)
DrawWC2F8Rect13x7ToBGMapRow11_BankA0:: ; heuristic: follows a terminator; C0
Func_0A0_4CED:: ; address name
    ld de, wScreenTileBuffer + $160
    ld hl, vBGMap0 + $160
    ld bc, $0D07
    call CopyRect32StrideToVRAM_BankA0
    ret

; the same 28 bytes as CopyRect32StrideToVRAM (31:753F)
; 10 call sites from 9 routines (e.g. DrawWC338RowsToBGMapRow13_BankA0, RunBattleSetup_BankA0_EntrySelect_ToCopyRect32StrideToVRAM_BankA0, DrawWC2A4AndWC2B8Rects_BankA0, DrawWC2B8Rect11x9ToBGMapRow9_BankA0, ...)
CopyRect32StrideToVRAM_BankA0::
Func_0A0_4CFA:: ; address name
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
    sub a, b
    add a, e
    ld e, a
    jr nc, .next
    inc d

.next:
    dec c
    jr nz, CopyRect32StrideToVRAM_BankA0
    ret

; reads a 4-byte header at HL (word offset, width, rows): returns HL = wScreenTileBuffer + offset, B = width, C = rows, DE = the byte after the header (E-0065) (the same 15 bytes appear in 2 banks)
; 2 call sites from 2 routines (e.g. GameMode7_Init_Sub01_Sub02_ReadScreenBufferRectHeader_BankA0, DrawRect4DC7AndWriteDATiles)
; points at: wScreenTileBuffer
ReadScreenBufferRectHeader_BankA0::
Func_0A0_4D16:: ; address name
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

; DE = source (rows packed), HL = destination with rows 32 bytes apart, B = width, C = rows: copies a B x C rectangle; DE ends past the source, HL at the start of the row below; B kept, C = 0 (E-0065) (the same 18 bytes appear in 2 banks)
; 2 call sites from 2 routines (e.g. GameMode7_Init_Sub01_Sub02_ReadScreenBufferRectHeader_BankA0, DrawRect4DC7AndWriteDATiles)
CopyRectToStride32_BankA0::
Func_0A0_4D25:: ; address name
    push bc
    push hl

.loop:
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, .loop
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, CopyRectToStride32_BankA0
    ret

; E-0161 (derived: a tile-rectangle record for CopyRecordRectToScreenBuffer)
; record: offset $0000 (row 0, column 0); 20 x 7 tiles
TileRect_A0_4D37::
Data_0A0_4D37:: ; address name
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $14, $07 ; width, rows
    db $B0, $B1, $B1, $B1, $B1, $B1, $B2, $B1, $B1, $B1, $B1, $B1, $B2, $B0, $B1, $B1, $B1, $B1, $B1, $B2 ; row 0
    db $B6, $D0, $D1, $D2, $D3, $D4, $B7, $DA, $DB, $DC, $DD, $DE, $B7, $B6, $D5, $D6, $D7, $D8, $D9, $B7 ; row 1
    db $B8, $B9, $B9, $B9, $B9, $B9, $BA, $B4, $B4, $B4, $B4, $B4, $B5, $B8, $B9, $B9, $B9, $B9, $B9, $BA ; row 2
    db $B6, $EB, $C3, $C3, $C3, $C3, $B7, $C3, $C3, $C3, $C3, $C3, $C3, $B6, $EB, $C3, $C3, $C3, $C3, $B7 ; row 3
    db $B6, $EC, $C3, $C3, $C3, $C3, $B7, $B0, $B1, $B1, $B1, $B1, $B1, $B6, $EC, $C3, $C3, $C3, $C3, $B7 ; row 4
    db $B6, $EA, $AF, $C3, $C3, $C3, $B7, $B6, $A4, $A5, $CB, $CC, $CD, $B6, $EA, $AF, $C3, $C3, $C3, $B7 ; row 5
    db $B3, $B4, $B4, $B4, $B4, $B4, $B5, $B3, $B4, $B4, $B4, $B4, $B4, $B3, $B4, $B4, $B4, $B4, $B4, $B5 ; row 6

; E-0161 (derived: a tile-rectangle record for CopyRecordRectToScreenBuffer)
; record: offset $0000 (row 0, column 0); 20 x 13 tiles
TileRect_A0_4DC7::
Data_0A0_4DC7:: ; address name
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $14, $0D ; width, rows
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; row 0
    db $B6, $F0, $F1, $F2, $F3, $F4, $F5, $F6, $C3, $B7, $B6, $A4, $A5, $CB, $CC, $CD, $C3, $C3, $C3, $B7 ; row 1
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA, $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA ; row 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $AF, $FB, $E1, $B7, $B6, $F7, $F8, $F9, $C3, $FA, $AF, $C3, $C3, $B7 ; row 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 4
    db $B6, $FC, $FD, $FE, $FF, $00, $AF, $C3, $C3, $B7, $B6, $0E, $0F, $10, $C3, $11, $AF, $C3, $C3, $B7 ; row 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 6
    db $B6, $01, $02, $03, $04, $05, $AF, $C3, $C3, $B7, $B6, $12, $13, $14, $C3, $15, $AF, $C3, $C3, $B7 ; row 7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 8
    db $B6, $06, $07, $08, $09, $C3, $AF, $C3, $C3, $B7, $B6, $16, $17, $18, $C3, $19, $AF, $C3, $C3, $B7 ; row 9
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; row 10
    db $B6, $0A, $0B, $0C, $0D, $C3, $AF, $C3, $C3, $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; row 11
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; row 12

; start-up for wGameMode = 7; forcing this mode on the emulator shows: two monster panels when forced (E-0029)
; 1 call site from 1 routine (e.g. RunGameModeInit_ToGameMode7_Init)
; reads: wSGBActive, wIsCGB
; writes: wSGBPaletteSet, wSGBAttrFile, hScrollX, hScrollXHi, hScrollY, hScrollYHi, rVBK, wTextCursorLo, ...
GameMode7_Init::
Func_0A0_4ECF:: ; address name
    call ClearSTATInterruptSources
    ld a, $02
    call QueueMusic
    ld a, [wSGBActive]
    or a, a
    jr z, .clear_scroll_x
    ld a, $00
    ld [wSGBPaletteSet], a
    ld a, $00
    ld [wSGBAttrFile], a
    farcall SendSGBPaletteSetPacket

.clear_scroll_x:
    xor a, a
    ldh [hScrollX], a
    ldh [hScrollXHi], a
    xor a, a
    ldh [hScrollY], a
    ldh [hScrollYHi], a
    ld hl, vBGMap0
    ld bc, $0400
    ld a, $C3
    call FillBytes
    ld a, [wIsCGB]
    or a, a
    jr z, .set_text_cursor_lo
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0
    ld bc, $0400
    xor a, a
    call FillBytes
    xor a, a
    ldh [rVBK], a

.set_text_cursor_lo:
    ld hl, vBGMap0 + $1C1
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    ld b, $31
    ld de, Tiles1Plus240Gfx_31_7C1E
    ld hl, vTiles1 + $240
    call DecompressToRAMLocked
    ld b, $31
    ld de, Tiles1Plus5F0Gfx_31_7DFB
    ld hl, vTiles1 + $5F0
    call DecompressToRAMLocked
    call GameMode7_Init_FillBytes
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld hl, vBGMap0 + $1C1
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    ld a, $FC
    call StartPaletteFade
    ld a, $07
    ldh [hWindowX], a
    ld a, $FF
    ldh [hWindowY], a
    ld a, $00
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    ld a, $03
    ld [wLCDCShadow], a
    ld a, $0B
    jp ClearSGBPacketBuffer_CheckLinkMode

; per-frame routine for wGameMode = 7
; 1 call site from 1 routine (e.g. RunGameModeUpdate_ToGameMode7_Update)
; reads: wEffectId, wEffectAnimState
GameMode7_Update::
Func_0A0_4F70:: ; address name
    call LinkExchangeJoypadPerFrame
    ld a, [wEffectId]
    cp a, $FF
    ret z
    farcall RunBattleEffectAnimation
    ld a, [wEffectAnimState]
    cp a, $02
    ret nz
    di
    farcall TickSequencePtrLoSequence
    ei
    ret

; unless wC52B is set (text busy), runs the routine for wBattlePhase (jump table of four) (E-0122)
; 1 call site from 1 routine (e.g. RunLinkSession7Exchange_LinkReceiveStepWithBuffer)
; reads: wTextFlags, wBattlePhase
RunBattlePhaseWhenTextIdle_A0::
Func_0A0_4F8E:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wBattlePhase]
    rst $00
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters
    dw RunBattlePhaseWhenTextIdle_A0_RunTurn
    dw RunBattlePhaseWhenTextIdle_A0_SyncLink
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen

; by wBattleStep: waits for the link, computes the wild level and shows each opposing monster's picture ('The first/second/third monster is 0!', 'Please wait')
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleStep
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters::
Jump_0A0_4F9F:: ; address name
    ld a, [wBattleStep]
    rst $00
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WaitFadeState
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WaitLinkMessage
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_Case02
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WaitLinkMessage_Case03
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_SetBattleStep
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WaitLinkMessage_Case05
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_InitBattleSlotsForFoeCount
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_BeginStringDisplay_Bank07
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_ShowTheFirstMonsterIs
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_LoadMonsterPictureAttributes
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_LoadMonsterPictureAttributes_Case0A
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_ShowTheSecondMonsterIs
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_LoadMonsterPictureAndStep
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WriteBattleStepAndTemp0
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_ShowTheThirdMonsterIs
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_LoadMonsterPictureAndStep_Case0F
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_LoadMonsterPictureAttributes_Case10
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_ShowPleaseWait
    dw RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WaitLinkMessage_Case12

; entry 0 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; writes: wLinkSendByte
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WaitFadeState::
Jump_0A0_4FC9:: ; address name
    ld a, [wFadeState]
    and a, a
    ret nz
    ld hl, wBattleStep
    inc [hl]
    ld a, $0C
    ld [wLinkSendByte], a
    ret

; entry 1 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WaitLinkMessage::
Jump_0A0_4FD8:: ; address name
    ld a, [wLinkMessage]
    cp a, $0C
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wRandomHi
; writes: wLinkRecvBuffer, wBattleSetupByte98, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkBufferCountLo, wLinkSendByte, ...
; points at: wBattleStep, wLinkRecvBuffer, wLinkPartnerName
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_Case02::
Jump_0A0_4FE7:: ; address name
    ld hl, wBattleStep
    inc [hl]
    ld a, [wRandomLo]
    ld [wLinkRecvBuffer], a
    ld a, [wRandomHi]
    ld [wBattleSetupByte98], a
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
    ld a, $FF
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; entry 3 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte, wLinkReady
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WaitLinkMessage_Case03::
Jump_0A0_501D:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wLinkReady], a
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_SetBattleStep::
Jump_0A0_5030:: ; address name
    ld hl, wBattleStep
    inc [hl]
    ld a, $03
    ld [wLinkSendByte], a
    ret

; entry 5 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wLinkRole, wRandomLo, wRandomHi, wLinkPartnerName, wLinkPartnerByte1
; writes: wLinkSendByte, wLinkPartnerName, wRandomSeed2Lo, wRandomLo, wLinkPartnerByte1, wRandomSeed2Hi, wRandomHi
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WaitLinkMessage_Case05::
Jump_0A0_503A:: ; address name
    ld a, [wLinkMessage]
    cp a, $03
    ret nz
    xor a, a
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

; entry 6 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenCountPlusOne
; writes: wEncounterKind, wBattleFoeCount, wSide1Flag
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_InitBattleSlotsForFoeCount::
Jump_0A0_5076:: ; address name
    call InitBattleSlotsForFoeCount
    ld a, [wScreenCountPlusOne]
    cp a, $02
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

; entry 7 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wScreenCountPlusOne
; writes: wStringIndex, wStringCategory
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_BeginStringDisplay_Bank07::
Jump_0A0_50AD:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wScreenCountPlusOne]
    ld [wStringIndex], a
    ld a, $06
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank07
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 8 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wBattlePictureIds
; writes: wStringIndex, wStringCategory
; points at: wTextBuf0, wBattleStep
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_ShowTheFirstMonsterIs::
Jump_0A0_50C8:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wBattlePictureIds]
    ld l, a
    ld a, [wBattlePictureIds + $1]
    add a, $02
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

; entry 9 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wBattlePictureIds
; writes: hTemp0, wBGPaletteUploadRequest
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_LoadMonsterPictureAttributes::
Jump_0A0_50F2:: ; address name
    ld a, [wIsCGB]
    or a, a
    jr z, .read_battle_picture_ids
    ld de, $0000
    ld hl, vBGMap0 + $E1
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
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenCountPlusOne, wIsCGB, wBattlePictureIds
; writes: hTemp0
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_LoadMonsterPictureAttributes_Case0A::
Jump_0A0_511F:: ; address name
    ld hl, vBGMap0 + $E1
    ld a, [wScreenCountPlusOne]
    cp a, $02
    jr nz, .call_run_battle_phase_when_text_idle_a0
    ld hl, vBGMap0 + $E4

.call_run_battle_phase_when_text_idle_a0:
    ld d, $14
    call RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WriteVRAMByteInc
    ld a, [wIsCGB]
    or a, a
    jr z, .done
    ld hl, vBGMap0 + $E1
    ld a, [wScreenCountPlusOne]
    cp a, $02
    jr nz, .set_temp0_to_01
    ld hl, vBGMap0 + $E4

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

; entry 11 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wBattlePictureIds
; writes: wStringIndex, wStringCategory
; points at: wTextBuf0, wBattleStep
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_ShowTheSecondMonsterIs::
Jump_0A0_5158:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wBattlePictureIds + $2]
    ld l, a
    ld a, [wBattlePictureIds + $3]
    add a, $02
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

; entry 12 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters
; no direct call (reached through a table, a jump or a vector)
; reads: wBattlePictureIds
; writes: wBGPaletteUploadRequest
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_LoadMonsterPictureAndStep::
Jump_0A0_5182:: ; address name
    ld a, [wBattlePictureIds + $2]
    ld e, a
    ld a, [wBattlePictureIds + $3]
    ld d, a
    ld hl, vTiles2 + $380
    ld c, $03
    call LoadMonsterPicture
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenCountPlusOne, wBattleStep, wIsCGB, wBattlePictureIds
; writes: wBattleStep, hTemp0
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WriteBattleStepAndTemp0::
Jump_0A0_519C:: ; address name
    ld hl, vBGMap0 + $E7
    ld a, [wScreenCountPlusOne]
    cp a, $02
    jr nz, .call_run_battle_phase_when_text_idle_a0
    ld a, [wBattleStep]
    add a, $03
    ld [wBattleStep], a
    ld hl, vBGMap0 + $EA

.call_run_battle_phase_when_text_idle_a0:
    ld d, $38
    call RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WriteVRAMByteInc
    ld a, [wIsCGB]
    or a, a
    jr z, .done
    ld hl, vBGMap0 + $E7
    ld a, [wScreenCountPlusOne]
    cp a, $02
    jr nz, .set_temp0_to_03
    ld hl, vBGMap0 + $EA

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

; entry 14 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wBattlePictureIds
; writes: wStringIndex, wStringCategory
; points at: wTextBuf0, wBattleStep
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_ShowTheThirdMonsterIs::
Jump_0A0_51DD:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wBattlePictureIds + $4]
    ld l, a
    ld a, [wBattlePictureIds + $5]
    add a, $02
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

; entry 15 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters
; no direct call (reached through a table, a jump or a vector)
; reads: wBattlePictureIds
; writes: wBGPaletteUploadRequest
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_LoadMonsterPictureAndStep_Case0F::
Jump_0A0_5207:: ; address name
    ld a, [wBattlePictureIds + $4]
    ld e, a
    ld a, [wBattlePictureIds + $5]
    ld d, a
    ld hl, vTiles2 + $5C0
    ld c, $05
    call LoadMonsterPicture
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 16 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wBattlePictureIds
; writes: hTemp0
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_LoadMonsterPictureAttributes_Case10::
Jump_0A0_5221:: ; address name
    ld d, $5C
    ld hl, vBGMap0 + $ED
    call RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WriteVRAMByteInc
    ld a, [wIsCGB]
    or a, a
    jr z, .done
    ld hl, vBGMap0 + $ED
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

; entry 17 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wStringCategory, wStringIndex, wLinkSendByte
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_ShowPleaseWait::
Jump_0A0_5246:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, $05
    ld [wStringCategory], a
    ld a, $0C
    ld [wStringIndex], a ; 'Please wait.'
    farcall ShowString_Bank07
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 18 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wBattleStep, wLinkSendByte
; points at: wBattlePhase
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WaitLinkMessage_Case12::
Jump_0A0_5265:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    xor a, a
    ld [wBattleStep], a
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wBattlePhase
    inc [hl]
    ret

; only called from routines of RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters (E-0098)
; 3 call sites from 3 routines (e.g. RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_LoadMonsterPictureAttributes_Case10, RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WriteBattleStepAndTemp0, RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_LoadMonsterPictureAttributes_Case0A)
RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters_WriteVRAMByteInc::
Func_0A0_5278:: ; address name
    ld bc, $0606

.loop:
    ld a, d
    inc d
    call WriteVRAMByteInc
    dec b
    jr nz, .loop
    ld a, l
    add a, $1A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $06
    dec c
    jr nz, .loop
    ret

; by wBattleStep: clears a buffer, then RunBattleSetup_BankA0, the command entry (bank $A1), RunBattleActions and RunBattleStep4
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleStep
RunBattlePhaseWhenTextIdle_A0_RunTurn::
Jump_0A0_5291:: ; address name
    ld a, [wBattleStep]
    rst $00
    dw RunBattlePhaseWhenTextIdle_A0_RunTurn_Case00_FillBytesAndStep
    dw RunBattlePhaseWhenTextIdle_A0_RunTurn_ToRunBattleSetup_BankA0
    dw RunBattlePhaseWhenTextIdle_A0_RunTurn_ToRunBattleCommandEntry_BankA1
    dw RunBattlePhaseWhenTextIdle_A0_RunTurn_ToRunBattleActions
    dw RunBattlePhaseWhenTextIdle_A0_RunTurn_ToRunBattleStep4

; entry 0 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_RunTurn
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_RunTurn_Case00_FillBytesAndStep::
Jump_0A0_529F:: ; address name
    call RunBattlePhaseWhenTextIdle_A0_RunTurn_Case00_FillBytes
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_RunTurn
; no direct call (reached through a table, a jump or a vector)
RunBattlePhaseWhenTextIdle_A0_RunTurn_ToRunBattleSetup_BankA0::
Jump_0A0_52A7:: ; address name
    call RunBattleSetup_BankA0
    ret

; entry 2 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_RunTurn
; no direct call (reached through a table, a jump or a vector)
RunBattlePhaseWhenTextIdle_A0_RunTurn_ToRunBattleCommandEntry_BankA1::
Jump_0A0_52AB:: ; address name
    farcall RunBattleCommandEntry_BankA1
    ret

; entry 3 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_RunTurn
; no direct call (reached through a table, a jump or a vector)
RunBattlePhaseWhenTextIdle_A0_RunTurn_ToRunBattleActions::
Jump_0A0_52B2:: ; address name
    farcall RunBattleActions
    ret

; entry 4 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_RunTurn
; no direct call (reached through a table, a jump or a vector)
RunBattlePhaseWhenTextIdle_A0_RunTurn_ToRunBattleStep4::
Jump_0A0_52B9:: ; address name
    farcall RunBattleStep4
    ret

; by wBattleStep: exchanges bytes and messages over the link ('Please wait.')
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleStep
RunBattlePhaseWhenTextIdle_A0_SyncLink::
Jump_0A0_52C0:: ; address name
    ld a, [wBattleStep]
    rst $00
    dw RunBattlePhaseWhenTextIdle_A0_SyncLink_SetLinkSendByte
    dw RunBattlePhaseWhenTextIdle_A0_SyncLink_WaitLinkMessage
    dw RunBattlePhaseWhenTextIdle_A0_SyncLink_WaitLinkMessage_Case02
    dw RunBattlePhaseWhenTextIdle_A0_SyncLink_AddAx9ToHL
    dw RunBattlePhaseWhenTextIdle_A0_SyncLink_Case04_CarryUnlessBattleSlotOutSlotEmpty_Case04
    dw RunBattlePhaseWhenTextIdle_A0_SyncLink_ReadSTAT
    dw RunBattlePhaseWhenTextIdle_A0_SyncLink_WriteVBK
    dw RunBattlePhaseWhenTextIdle_A0_SyncLink_SetBattleStep
    dw RunBattlePhaseWhenTextIdle_A0_SyncLink_WaitLinkMessage_Case08

; entry 0 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_SyncLink
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_SyncLink_SetLinkSendByte::
Jump_0A0_52D6:: ; address name
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_SyncLink
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkBufferCountLo, wLinkSendByte
; points at: wBattleSlotOut, wLinkPartnerName, wBattleStep
RunBattlePhaseWhenTextIdle_A0_SyncLink_WaitLinkMessage::
Jump_0A0_52E0:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
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
    ld a, $FF
    ld [wLinkSendByte], a
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_SyncLink
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wLinkRole, wLinkPartnerByte1, wLinkPartnerName
; writes: wBattleSlotOut, wLinkSendByte
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_SyncLink_WaitLinkMessage_Case02::
Jump_0A0_530B:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
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
    xor a, a
    ld [wLinkSendByte], a
    ret

; entry 3 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_SyncLink
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTurn, wLinkRuleTurnLimit, wScreenCountPlusOne
; writes: wLinkRuleTurnLimit, wStringIndex, wStringCategory, wBattleStep
; points at: wBattleSlotOut, wBattleStatus, wBattleStep, wBattlePhase
RunBattlePhaseWhenTextIdle_A0_SyncLink_AddAx9ToHL::
Jump_0A0_532F:: ; address name
    ld a, [wBattleTurn]
    inc a
    ld b, a
    ld a, [wLinkRuleTurnLimit]
    add a, b
    cp a, $64
    jr c, .set_link_rule_turn_limit
    ld a, $63

.set_link_rule_turn_limit:
    ld [wLinkRuleTurnLimit], a
    ld hl, wBattleSlotOut
    ld a, [hl]
    cp a, $01
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
    cp a, $01
    jr z, .call_queue_music
    ld a, $01
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    bit 6, a
    jr nz, .call_queue_music

.read_screen_count_plus_one:
    ld a, [wScreenCountPlusOne]
    add a, $06
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
    xor a, a
    ld [wBattleStep], a
    ret

; entry 4 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_SyncLink
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenCountPlusOne
; writes: wScreenCountPlusOne, wStringCategory, wStringIndex, wLinkSendByte, wBattleStep
; points at: wBattleStep, wBattlePhase
RunBattlePhaseWhenTextIdle_A0_SyncLink_Case04_CarryUnlessBattleSlotOutSlotEmpty_Case04::
Jump_0A0_5391:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wScreenCountPlusOne]
    cp a, $02
    jp z, .skip
    inc a
    ld [wScreenCountPlusOne], a
    farcall RunBattlePhaseWhenTextIdle_A0_SyncLink_Case04_CarryUnlessBattleSlotOutSlotEmpty
    ld c, $00
    farcall DrawSlotStatusMarks
    farcall CopySlotPanelRowToVRAM
    ld c, $00
    farcall DrawSlotHPDigits
    farcall CopySlotPanelPart7AC8ToVRAM
    ld c, $00
    farcall DrawSlotMPDigits
    farcall CopySlotPanelPart7ACEToVRAM
    ld c, $01
    farcall DrawSlotStatusMarks
    farcall CopySlotPanelRowToVRAM
    ld c, $01
    farcall DrawSlotHPDigits
    farcall CopySlotPanelPart7AC8ToVRAM
    ld c, $01
    farcall DrawSlotMPDigits
    farcall CopySlotPanelPart7ACEToVRAM
    ld a, $05
    ld [wStringCategory], a
    ld a, $0C
    ld [wStringIndex], a ; 'Please wait.'
    farcall BeginStringDisplay_Bank07
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wBattleStep
    inc [hl]
    ret

.skip:
    ld hl, wBattlePhase
    inc [hl]
    xor a, a
    ld [wBattleStep], a
    xor a, a
    ld [wLinkSendByte], a
    ret

; entry 5 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_SyncLink
; no direct call (reached through a table, a jump or a vector)
; reads: rSTAT
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_SyncLink_ReadSTAT::
Jump_0A0_5422:: ; address name
    ld hl, vBGMap0 + $E1
    ld bc, $1206
    ld de, $000E

.loop:
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld [hl], $C3
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

; entry 6 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_SyncLink
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, rSTAT
; writes: rVBK
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_SyncLink_WriteVBK::
Jump_0A0_5444:: ; address name
    ld a, [wIsCGB]
    or a, a
    jr z, .done
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0 + $E1
    ld bc, $1206
    ld de, $000E

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

; entry 7 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_SyncLink
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_SyncLink_SetBattleStep::
Jump_0A0_5474:: ; address name
    ld hl, wBattleStep
    inc [hl]
    ld a, $01
    ld [wLinkSendByte], a
    ret

; entry 8 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_SyncLink
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte, wBattlePhase, wBattleStep
RunBattlePhaseWhenTextIdle_A0_SyncLink_WaitLinkMessage_Case08::
Jump_0A0_547E:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wBattlePhase], a
    xor a, a
    ld [wBattleStep], a
    ret

; for each party member with a battle entry in wBattleBuffer72, writes two words to SRAM record offsets $5B and $5F and one byte to $55, then ClampPartyHpAndMpToMax
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_ResultsScreen_Case00)
; reads: wPartyCount
; writes: rRAMG
; points at: wPartyList, wBattleBuffer72
StoreBattleStateToPartyRecords::
Func_0A0_5491:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList
    ld de, wBattleBuffer72

.loop:
    inc de
    ld a, [de]
    cp a, $FF
    jr z, .call_clamp_party_hp_and_mp_to_max
    dec de
    push hl
    ld a, [hl]
    ld c, MON_HP
    call SRAMRecordAddress
    ld a, [de]
    inc de
    ld [hl+], a
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
    ld [hl+], a
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
    ld [hl+], a
    pop hl
    inc hl
    dec b
    jr nz, .loop

.call_clamp_party_hp_and_mp_to_max:
    farcall ClampPartyHPAndMPToMax
    xor a, a
    ld [rRAMG], a
    ret

; by wBattleStep: the results screen ('RESULTS ... Level Turns Win Rank', the rank letters 'GFEDCBAS', "0's G fell by W.", 'received WG.')
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleStep
RunBattlePhaseWhenTextIdle_A0_ResultsScreen::
Jump_0A0_54DD:: ; address name
    ld a, [wBattleStep]
    rst $00
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_Case00
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_RunBackupAndSaveSteps
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_CopyScreenTileBufferToVRAM_A0
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_ShowString_Bank07
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_DrawRect4DC7AndWriteDATiles
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_CopyScreenTileBufferToVRAM_A0_Case05
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_CopyF0StringFromTable5A4AToTextBuf1
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_CopyF0StringFromTable5A4AToTextBuf1_Case07
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_ShowReceivedWG
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_BlankPartnerRecord
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_FadeOut

; entry 0 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_ResultsScreen
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleResultStep, wBattleResultCounter, wLinkRole, wBattleResultDelay
; writes: wBattleKindFlags, wBattleResultByte9B, wBattleResultByte9C, wBattleResultStep, wBattleResultCounter, wSaveStep, wSaveRecordIndex
; points at: wBattleSlotOut, wBattleStatus, wBattleStep
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_Case00::
Jump_0A0_54F7:: ; address name
    ld a, $01
    ld [wBattleKindFlags], a
    ld a, [wBattleResultStep]
    ld l, a
    ld a, [wBattleResultCounter]
    ld h, a
    ld a, l
    ld [wBattleResultByte9B], a
    ld a, h
    ld [wBattleResultByte9C], a
    ld hl, wBattleSlotOut
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    sla a
    or a, c
    ld c, a
    ld hl, wBattleStatus
    ld a, [hl]
    and a, $40
    sra a
    sra a
    or a, c
    ld c, a
    ld hl, wBattleStatus + $9
    ld a, [hl]
    and a, $40
    sra a
    or a, c
    ld c, a
    and a, $03
    cp a, $03
    jr z, .skip3
    ld a, c
    and a, $30
    cp a, $30
    jr z, .skip3
    ld a, c
    and a, $21
    cp a, $21
    jr z, .skip3
    ld a, c
    and a, $12
    cp a, $12
    jr z, .skip3
    ld a, c
    and a, $03
    jr z, .skip
    ld a, [wLinkRole]
    and a, $02
    rrca
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    or a, a
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
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld hl, wBattleStep
    inc [hl]
    call StoreBattleStateToPartyRecords
    ret

; entry 1 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_ResultsScreen
; no direct call (reached through a table, a jump or a vector)
; reads: wSaveStep, wBattleResultStep
; writes: wStringIndex, wStringCategory
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_RunBackupAndSaveSteps::
Jump_0A0_558C:: ; address name
    farcall RunBackupAndSaveSteps
    ld a, [wSaveStep]
    bit 7, a
    ret z
    farcall SaveGameToSRAMWithChecksum
    ld a, [wBattleResultStep]
    add a, $0F
    ld [wStringIndex], a
    ld a, $05
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank07
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_ResultsScreen
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; points at: wScreenTileBuffer, wBattleStep
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_CopyScreenTileBufferToVRAM_A0::
Jump_0A0_55B6:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld hl, wScreenTileBuffer
    ld bc, $01A0
    ld a, $C3
    call FillBytes
    ld hl, vBGMap0
    call CopyScreenTileBufferToVRAM_A0
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_ResultsScreen
; no direct call (reached through a table, a jump or a vector)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex
; points at: wBattleStep
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_ShowString_Bank07::
Jump_0A0_55D1:: ; address name
    ld hl, vTiles1 + $700
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $2C01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $01
    ld [wStringCategory], a
    ld a, $03
    ld [wStringIndex], a ; 'RESULTSDuoW LevelTurnsWin RankOwnWDuoLOwnL'
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

; entry 4 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_ResultsScreen
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleResultStep, wWildLevel, wLinkRuleTurnLimit, wWildBand, wWildByteE5
; writes: wWindowTileBuffer
; points at: wKeyNameBuf, wBattleStep
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_DrawRect4DC7AndWriteDATiles::
Jump_0A0_5622:: ; address name
    call DrawRect4DC7AndWriteDATiles
    ld a, [wBattleResultStep]
    ld hl, RunBattlePhaseWhenTextIdle_A0_ResultsScreen_DrawRect4DC7AndWriteDATiles_Data
    add a, a
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
    cp a, $00
    jr z, .read_wild_level
    cp a, $02
    jr nc, .loop
    inc hl
    jr .loop

.read_wild_level:
    ld a, [wWildLevel]
    ld hl, wScreenTileBuffer + $A7
    call WriteTwoDigitsBlankLeading_A0
    ld a, [wLinkRuleTurnLimit]
    ld hl, wScreenTileBuffer + $E7
    call WriteTwoDigitsBlankLeading_A0
    ld a, [wWildBand]
    ld hl, wScreenTileBuffer + $127
    call WriteTwoDigitsBlankLeading_A0
    ld a, [wWildByteE5]
    add a, $20
    ld [wWindowTileBuffer], a
    ld de, wKeyNameBuf
    ld hl, wScreenTileBuffer + $71
    call WriteThreeTwoDigitRows
    ld hl, wBattleStep
    inc [hl]
    ret

; writes A as two digit tiles at HL, with a blank ($C3) for a leading zero (E-0122)
; 3 call sites from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_ResultsScreen_DrawRect4DC7AndWriteDATiles)
; reads: wDigits
WriteTwoDigitsBlankLeading_A0::
Func_0A0_5678:: ; address name
    push hl
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    pop hl
    ld a, [wDigits + $1]
    add a, $E0
    cp a, $E0
    jr nz, .read_digits
    ld a, $C3

.read_digits:
    ld [hl+], a
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl], a
    ret

; HL = ascending table of thresholds: C = A = the number of leading bytes that are <= A (the index of the first byte above A); HL ends on that byte. The table must contain a byte above A (E-0065) (the same 11 bytes appear in 2 banks)
; no direct call (reached through a table, a jump or a vector)
CountTableBytesAtOrBelowA_BankA0_5693:: ; heuristic: follows a terminator; C0
Func_0A0_5693:: ; address name
    ld c, $00

.skip:
    cp a, [hl]
    jr c, .done
    inc c
    inc hl
    jr .skip

.done:
    ld a, c
    ret

; three WriteTwoDigitsFromDEStepRow calls: three numbers from DE, one per row
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_ResultsScreen_DrawRect4DC7AndWriteDATiles)
; reads: wDigits
WriteThreeTwoDigitRows::
Func_0A0_569E:: ; address name
    call WriteTwoDigitsFromDEStepRow
    call WriteTwoDigitsFromDEStepRow
    call WriteTwoDigitsFromDEStepRow

; writes [DE] (DE += 1) as two digit tiles at HL (no leading zero digit), then HL moves to the next row ($40 on) (E-0124)
; 3 call sites from 1 routine (e.g. WriteThreeTwoDigitRows)
; reads: wDigits
WriteTwoDigitsFromDEStepRow::
Func_0A0_56A7:: ; address name
    push hl
    ld a, [de]
    inc de
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    pop hl
    ld a, [wDigits + $1]
    or a, a
    jr z, .read_digits
    add a, $E0
    ld [hl], a

.read_digits:
    inc hl
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl], a
    ld a, l
    add a, $3F
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

; address loaded by RunBattlePhaseWhenTextIdle_A0_ResultsScreen_DrawRect4DC7AndWriteDATiles
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_DrawRect4DC7AndWriteDATiles_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0A0_56CA:: ; address name
    db $04, $F7, $04, $0E, $04, $12, $04, $16

; entry 5 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_ResultsScreen
; no direct call (reached through a table, a jump or a vector)
; writes: wTextBuf0
; points at: wTextBuf0, wBattleStep
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_CopyScreenTileBufferToVRAM_A0_Case05::
Jump_0A0_56D2:: ; address name
    ld hl, vBGMap0
    call CopyScreenTileBufferToVRAM_A0
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld hl, wRecordBufA + MON_NAME
    ld de, wTextBuf0
    ld bc, $000A
    call CopyBytes
    ld a, $F0
    ld [wTextBuf0 + $A], a
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_ResultsScreen
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf, wBattleSubPhase, wBattleResultStep
; writes: wStringCategory, wStringIndex, wBattleSubPhase
; points at: wBattleStep, wTextBuf2
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_CopyF0StringFromTable5A4AToTextBuf1::
Jump_0A0_56F7:: ; address name
    ld a, [wWorkBuf + $9]
    cp a, $FF
    jr nz, .call_copy_f0_string_from_table5_a4_a_to_text
    ld hl, wBattleStep
    inc [hl]
    jr RunBattlePhaseWhenTextIdle_A0_ResultsScreen_CopyF0StringFromTable5A4AToTextBuf1_Case07_ReadBattleSubPhase

.call_copy_f0_string_from_table5_a4_a_to_text:
    call CopyF0StringFromTable5A4AToTextBuf1
    ld a, [wWorkBuf + $A]
    ld hl, wTextBuf2
    call WriteDecimalByteString
    ld a, [wBattleResultStep]
    cp a, $02
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

; entry 7 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_ResultsScreen
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wBattleSubPhase
; writes: wStringCategory, wStringIndex, wBattleSubPhase
; points at: wTextBuf2, wBattleStep
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_CopyF0StringFromTable5A4AToTextBuf1_Case07::
Jump_0A0_5732:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz

RunBattlePhaseWhenTextIdle_A0_ResultsScreen_CopyF0StringFromTable5A4AToTextBuf1_Case07_ReadBattleSubPhase::
Jump_0A0_5737:: ; address name
    ld a, [wBattleSubPhase]
    call CopyF0StringFromTable5A4AToTextBuf1
    ld a, [wBattleSubPhase]
    ld hl, wWorkBuf + $A
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
    cp a, $06
    ret c
    xor a, a
    ld [wBattleSubPhase], a
    ld hl, wBattleStep
    inc [hl]
    ret

; entry 8 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_ResultsScreen
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wWorkBuf, wBattleResultStep
; writes: hTemp0, hTemp1, hTemp2, wStringCategory, wStringIndex, wBattleSubPhase, wLinkSendByte
; points at: wTextBuf2, wBattleStep
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_ShowReceivedWG::
Jump_0A0_5772:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wWorkBuf + $10]
    ldh [hTemp0], a
    ld a, [wWorkBuf + $11]
    ldh [hTemp1], a
    xor a, a
    ldh [hTemp2], a
    ld hl, wTextBuf2
    call WriteNumber24AsDecimalString
    ld a, $05
    ld [wStringCategory], a
    ld a, $16
    ld [wStringIndex], a ; 'received WG.'
    farcall BeginStringDisplay_Bank07
    xor a, a
    ld [wBattleSubPhase], a
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wBattleStep
    inc [hl]
    ld a, [wBattleResultStep]
    cp a, $01
    ret z
    ld hl, wBattleStep
    inc [hl]
    ret

; waits for the text, then fills record buffer B with '???' names and $FF species (WriteUnknownNamePlaceholder)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubPhase
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_BlankPartnerRecord::
Jump_0A0_57B1:: ; address name
    ld a, [wBattleSubPhase]
    rst $00
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_BlankPartnerRecord_WaitTextFlags
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_BlankPartnerRecord_WaitLinkMessage

; entry 0 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_ResultsScreen_BlankPartnerRecord
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wLinkSendByte
; points at: wBattleSubPhase
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_BlankPartnerRecord_WaitTextFlags::
Jump_0A0_57B9:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_ResultsScreen_BlankPartnerRecord
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wRecordBufB
; writes: wBattleScene, wLinkRules, wRecordBufB, wGameMode, wModeState, wGameMode2State, wGameMode2Arg, wScreenState, ...
; points at: wRecordBufA, wRecordBufB, wModeChangeRequest, wBGFillFlag
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_BlankPartnerRecord_WaitLinkMessage::
Jump_0A0_57C8:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    ld a, $08
    ld [wBattleScene], a
    ld a, $01
    ld [wLinkRules + $9], a
    ld hl, wRecordBufA
    ld de, wRecordBufB
    ld bc, $00A5
    call CopyBytes
    ld a, $01
    ld [wRecordBufB], a
    ld a, $FF
    ld [wRecordBufB + MON_PARENT1_SPECIES], a
    ld [wRecordBufB + MON_PARENT1_SPECIES + 1], a
    ld [wRecordBufB + MON_PARENT2_SPECIES], a
    ld [wRecordBufB + MON_PARENT2_SPECIES + 1], a
    ld hl, wRecordBufB + MON_PARENT1_MASTER
    call WriteUnknownNamePlaceholder
    ld a, $FF
    ld [wRecordBufB + $28], a
    ld hl, wRecordBufB + MON_PARENT2_MASTER
    call WriteUnknownNamePlaceholder
    ld a, $FF
    ld [wRecordBufB + $33], a
    call AppendMappedSkillsToWCA67
    xor a, a
    ld [wRecordBufB + MON_STATUS], a
    ld a, $01
    ld [wRecordBufB + MON_LEVEL], a
    xor a, a
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
    xor a, a
    ld [wRecordBufB + MON_WLD], a
    ld [wRecordBufB + MON_WLD + 1], a
    xor a, a
    ld [wRecordBufB + MON_PLUS], a
    ld a, $01
    ld [wRecordBufB + MON_EGG], a
    ld hl, wRecordBufB + MON_PARENT1_NAME
    call WriteUnknownNamePlaceholder
    xor a, a
    ld [wRecordBufB + MON_PARENT1_PLUS], a
    ld hl, wRecordBufB + MON_PARENT2_NAME
    call WriteUnknownNamePlaceholder
    xor a, a
    ld [wRecordBufB + MON_PARENT2_PLUS], a
    xor a, a
    ld [wRecordBufB + MON_ITEM], a
    ld a, $04
    call StartPaletteFade
    ld a, $06
    ld [wGameMode], a
    xor a, a
    ld [wModeState], a
    ld [wGameMode2State], a
    ld [wGameMode2Arg], a
    ld [wScreenState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ld hl, wBGFillFlag
    inc [hl]
    xor a, a
    ld [wLinkSession], a
    ld [wLinkExchangeState], a
    xor a, a
    ld [wLinkRole], a
    ld [wLinkStatus], a
    xor a, a
    ld [wLinkMode], a
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wLinkMessage], a
    xor a, a
    ld [wLinkScreenStep], a
    ret

; HL >>= 2 (arithmetic), and 1 when that leaves 0 (E-0118)
; 6 call sites from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_ResultsScreen_BlankPartnerRecord_WaitLinkMessage)
QuarterHLAtLeast1::
Func_0A0_590B:: ; address name
    sra h
    rr l
    sra h
    rr l
    ld a, l
    or a, h
    ret nz
    ld hl, $0001
    ret

; writes '???' ($98 three times, the charmap '?') followed by seven $F0 bytes at HL: a 10-byte name field holding a placeholder (E-0111)
; 4 call sites from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_ResultsScreen_BlankPartnerRecord_WaitLinkMessage)
WriteUnknownNamePlaceholder::
Func_0A0_591A:: ; address name
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $F0
    ld [hl+], a
    ld a, $F0
    ld [hl+], a
    ld a, $F0
    ld [hl+], a
    ld a, $F0
    ld [hl+], a
    ld a, $F0
    ld [hl+], a
    ld a, $F0
    ld [hl+], a
    ld a, $F0
    ld [hl], a
    ret

; appends the eight skills at wCA5F (mapped through the pair list Data_0A0_597A) to the first free slot of wCA67, then clears wCA5F (E-0127)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_ResultsScreen_BlankPartnerRecord_WaitLinkMessage)
AppendMappedSkillsToWCA67::
Func_0A0_5939:: ; address name
    ld de, wRecordBufB + MON_SKILL_LIST
    ld b, $19

.loop:
    ld a, [de]
    cp a, $FF
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
    cp a, $FF
    jr z, .skip4
    push hl
    ld c, a
    ld hl, SkillReplacementPairs

.skip2:
    ld a, [hl]
    cp a, $FF
    jr z, .skip3
    cp a, c
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
    ld a, $FF
    ld [hl+], a
    dec b
    jr nz, .loop3
    ret

; E-0237 (C1: AppendMappedSkillsToWCA67 takes each of the 8 bytes at wRecordBufB + $34 up to $FF, replaces it by the second byte of the first pair here whose first byte matches (pairs end at $FF), appends it after the last used byte of wRecordBufB + $3C, then fills the 8 bytes with $FF; 44 pairs and $FF $FF).
; record: byte to match, replacement
SkillReplacementPairs::
Data_0A0_597A:: ; address name
    db $02, $01 ; id 0
    db $03, $01 ; id 1
    db $05, $04 ; id 2
    db $06, $04 ; id 3
    db $08, $07 ; id 4
    db $09, $07 ; id 5
    db $0B, $0A ; id 6
    db $0C, $0A ; id 7
    db $0E, $0D ; id 8
    db $0F, $0D ; id 9
    db $11, $10 ; id 10
    db $12, $10 ; id 11
    db $14, $13 ; id 12
    db $17, $16 ; id 13
    db $18, $16 ; id 14
    db $1A, $19 ; id 15
    db $1C, $1B ; id 16
    db $1D, $1B ; id 17
    db $1F, $1E ; id 18
    db $26, $25 ; id 19
    db $28, $27 ; id 20
    db $2A, $29 ; id 21
    db $2C, $2B ; id 22
    db $20, $2F ; id 23
    db $37, $36 ; id 24
    db $41, $40 ; id 25
    db $42, $40 ; id 26
    db $43, $40 ; id 27
    db $45, $44 ; id 28
    db $46, $44 ; id 29
    db $47, $44 ; id 30
    db $49, $48 ; id 31
    db $4D, $4C ; id 32
    db $4F, $4E ; id 33
    db $64, $63 ; id 34
    db $74, $73 ; id 35
    db $77, $76 ; id 36
    db $86, $85 ; id 37
    db $87, $85 ; id 38
    db $88, $85 ; id 39
    db $8C, $8B ; id 40
    db $8E, $8D ; id 41
    db $98, $97 ; id 42
    db $9A, $99 ; id 43
    db $FF, $FF ; end

; waits for the text, then starts the palette fade
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubPhase
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_FadeOut::
Jump_0A0_59D4:: ; address name
    ld a, [wBattleSubPhase]
    rst $00
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_FadeOut_WaitTextFlags
    dw RunBattlePhaseWhenTextIdle_A0_ResultsScreen_FadeOut_StartPaletteFade

; entry 0 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_ResultsScreen_FadeOut
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wLinkSendByte
; points at: wBattleSubPhase
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_FadeOut_WaitTextFlags::
Jump_0A0_59DC:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunBattlePhaseWhenTextIdle_A0_ResultsScreen_FadeOut
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wGameMode, wModeState, wGameMode2State, wGameMode2Arg, wScreenState, wLinkSession, wLinkExchangeState, wLinkRole, ...
; points at: wModeChangeRequest
RunBattlePhaseWhenTextIdle_A0_ResultsScreen_FadeOut_StartPaletteFade::
Jump_0A0_59EB:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    ld a, $04
    call StartPaletteFade
    ld a, $05
    ld [wGameMode], a
    ld a, $01
    ld [wModeState], a
    xor a, a
    ld [wGameMode2State], a
    ld [wGameMode2Arg], a
    ld [wScreenState], a
    ld hl, wModeChangeRequest
    inc [hl]
    xor a, a
    ld [wLinkSession], a
    ld [wLinkExchangeState], a
    xor a, a
    ld [wLinkRole], a
    ld [wLinkStatus], a
    xor a, a
    ld [wLinkMode], a
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wLinkMessage], a
    xor a, a
    ld [wLinkScreenStep], a
    ret
    db $0A, $14, $1E

; copies the $F0-terminated string at Data_0A0_5A4A[A] to wC140, including the terminator (E-0122)
; 2 call sites from 2 routines (e.g. RunBattlePhaseWhenTextIdle_A0_ResultsScreen_CopyF0StringFromTable5A4AToTextBuf1_Case07, RunBattlePhaseWhenTextIdle_A0_ResultsScreen_CopyF0StringFromTable5A4AToTextBuf1)
; points at: wTextBuf1
CopyF0StringFromTable5A4AToTextBuf1::
Func_0A0_5A30:: ; address name
    ld hl, CopyF0StringFromTable5A4AToTextBuf1_Data
    add a, a
    add_a_to_hl
    deref_hl
    ld de, wTextBuf1

.skip:
    ld a, [hl+]
    cp a, $F0
    jr z, .done
    ld [de], a
    inc de
    jr .skip

.done:
    ld [de], a
    ret

; address loaded by CopyF0StringFromTable5A4AToTextBuf1
CopyF0StringFromTable5A4AToTextBuf1_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0A0_5A4A:: ; address name
    db $56, $5A, $59, $5A, $5C, $5A, $60, $5A, $64, $5A, $68, $5A, $11, $19, $F0, $16
    db $19, $F0, $0A, $1D, $14, $F0, $0D, $0E, $0F, $F0, $0A, $10, $15, $F0, $12, $17
    db $1D, $F0

; counts the result (wKeyNameBuf[wBattleResultStep] += 1, capped at 99); scores the counts and rewards into a band (wWorkBuf, wWildBand) by BattleResultBandThresholds; adds the signed BattleResultTurnLimitAdjust and BattleResultBandAdjust entries to wWildLevel and clamps it to 0-99; the rank (wWorkBuf+1, wWildByteE5) is the number of BattleResultRankThresholds at or below it, 0-7, which the results screen shows as one of 'GFEDCBAS'
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_ResultsScreen_Case00)
; reads: wBattleResultStep, wLinkRuleTurnLimit, wBattleRewardByte97, wBattleRewardByte98, wWildLevel
; writes: wWorkBuf, wWildBand, wWildByteE5
; points at: wKeyNameBuf
ComputeBattleResultRank::
Func_0A0_5A6C:: ; address name
    ld a, [wBattleResultStep]
    ld hl, wKeyNameBuf
    add_a_to_hl
    ld a, [hl]
    inc a
    cp a, $64
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
    ld a, [hl+]
    add a, [hl]
    ld c, a
    ld b, $00
    push bc
    ld a, $0A
    call Multiply8
    pop bc
    ld a, [wBattleRewardByte97]
    add a, c
    ld c, a
    ld a, $00
    adc a, b
    ld b, a
    ld a, [wBattleRewardByte98]
    add a, c
    ld c, a
    ld a, $00
    adc a, b
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
    ld b, $FF

.skip:
    ld a, e
    add a, c
    ld e, a
    ld a, d
    adc a, b
    ld d, a
    pop hl
    ld a, [hl]
    ld c, a
    ld b, $00
    bit 7, a
    jr z, .skip2
    ld b, $FF

.skip2:
    ld a, e
    add a, c
    ld e, a
    ld a, d
    adc a, b
    ld d, a
    bit 7, d
    jr z, .skip3
    ld de, $0000
    jr .call_count_table_bytes_at_or_below_a_bank_a0

.skip3:
    ld a, d
    or a, a
    jr z, .skip4
    ld de, $0063
    jr .call_count_table_bytes_at_or_below_a_bank_a0

.skip4:
    ld a, e
    cp a, $64
    jr c, .call_count_table_bytes_at_or_below_a_bank_a0
    ld de, $0063

.call_count_table_bytes_at_or_below_a_bank_a0:
    ld a, e
    ld hl, BattleResultRankThresholds
    call CountTableBytesAtOrBelowA_BankA0
    ld [wWorkBuf + $1], a
    ld [wWildByteE5], a
    ret

; HL = ascending table of thresholds: C = A = the number of leading bytes that are <= A (the index of the first byte above A); HL ends on that byte. The table must contain a byte above A (E-0065) (the same 11 bytes appear in 2 banks)
; 3 call sites from 1 routine (e.g. ComputeBattleResultRank)
CountTableBytesAtOrBelowA_BankA0::
Func_0A0_5B1A:: ; address name
    ld c, $00

.skip:
    cp a, [hl]
    jr c, .done
    inc c
    inc hl
    jr .skip

.done:
    ld a, c
    ret

; ascending turn-limit thresholds for ComputeBattleResultRank, $FF-terminated
; address loaded by ComputeBattleResultRank
BattleResultTurnLimitThresholds:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0A0_5B25:: ; address name
    db $06, $0B, $15, $29, $33, $3D, $FF

; signed level adjustment per turn-limit bracket: +20, +10, +5, 0, -5, -10, -20
; address loaded by ComputeBattleResultRank
BattleResultTurnLimitAdjust:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0A0_5B2C:: ; address name
    db $14, $0A, $05, $00, $FB, $F6, $EC

; ascending band thresholds for ComputeBattleResultRank, $FF-terminated
; address loaded by ComputeBattleResultRank
BattleResultBandThresholds:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0A0_5B33:: ; address name
    db $01, $03, $05, $07, $09, $FF

; signed level adjustment per band: -20, -10, -5, 0, +5, +10
; address loaded by ComputeBattleResultRank
BattleResultBandAdjust:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0A0_5B39:: ; address name
    db $EC, $F6, $FB, $00, $05, $0A

; ascending rank thresholds 20-90, $FF-terminated: the count at or below the adjusted level is the rank 0-7
; address loaded by ComputeBattleResultRank
BattleResultRankThresholds:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0A0_5B3F:: ; address name
    db $14, $28, $32, $3C, $46, $50, $5A, $FF

; by wBattleResultStep: results 0 and 1 raise the lowest of five record words by BattleResultStatBonusByRank[rank] (capped at 999) and take a word from BattleResultGoldByRank; result 2 lowers the highest by BattleResultStatPenaltyByRank[rank]; others lower all five; the word (or 1000) goes to wWorkBuf+$10
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_ResultsScreen_Case00)
; reads: wLinkReceivedByte, wBattleResultStep, wWorkBuf, wGoldLo, wGoldMid, wGoldHi
; writes: wWorkBuf, rRAMG, rRAMB, wGoldLo, wGoldMid, wGoldHi
ApplyBattleResultStatChanges::
Func_0A0_5B47:: ; address name
    ld a, $FF
    ld [wWorkBuf + $9], a
    ld [wWorkBuf + $A], a
    ld [wWorkBuf + $B], a
    ld [wWorkBuf + $C], a
    ld [wWorkBuf + $D], a
    ld [wWorkBuf + $E], a
    ld [wWorkBuf + $F], a
    ld [wWorkBuf + $10], a
    ld [wWorkBuf + $11], a
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wLinkReceivedByte]
    ld c, MON_MAX_HP
    call SRAMRecordAddress
    ld a, [wBattleResultStep]
    or a, a
    jr z, .call_offset_by_index_of_min_of_five_words
    cp a, $01
    jr z, .call_offset_by_index_of_min_of_five_words
    cp a, $02
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
    ld [wWorkBuf + $A], a
    ld a, [wWorkBuf + $1]
    add a, a
    ld hl, BattleResultGoldByRank
    add_a_to_hl
    ld a, [hl+]
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
    ld [wWorkBuf + $A], a
    ld de, $03E8
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
    ld [wWorkBuf + $A], a
    inc hl
    inc hl
    call SubtractCFromWordMin1
    ld a, b
    ld [wWorkBuf + $B], a
    call SubtractCFromWordMin1
    ld a, b
    ld [wWorkBuf + $C], a
    call SubtractCFromWordMin1
    ld a, b
    ld [wWorkBuf + $D], a
    call SubtractCFromWordMin1
    ld a, b
    ld [wWorkBuf + $E], a
    call SubtractCFromWordMin1
    ld a, b
    ld [wWorkBuf + $F], a
    ld de, $03E8

.set_work_buf:
    ld a, e
    ld [wWorkBuf + $10], a
    ld a, d
    ld [wWorkBuf + $11], a
    ld a, [wGoldLo]
    add a, e
    ld l, a
    ld a, [wGoldMid]
    adc a, d
    ld h, a
    ld a, [wGoldHi]
    adc a, $00
    ld e, a
    push hl
    ld a, l
    sub a, $9F
    ld l, a
    ld a, h
    sbc a, $86
    ld h, a
    ld a, e
    sbc a, $01
    jr c, .set_gold_lo
    or a, h
    or a, l
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
    ld l, $9F
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
    ld a, [hl-]
    ld b, a
    ld a, [hl-]
    ld c, a
    push hl
    ld a, [hl-]
    ld l, [hl]
    ld a, h
    call CompareHLToBC
    pop hl
    jr c, .read_link_received_byte
    ld a, b
    ld [hl-], a
    ld [hl], c

.read_link_received_byte:
    ld a, [wLinkReceivedByte]
    ld c, MON_MAX_MP + 1
    call SRAMRecordAddress
    ld a, [hl-]
    ld b, a
    ld a, [hl-]
    ld c, a
    push hl
    ld a, [hl-]
    ld a, [hl]
    ld l, a
    ld h, a
    call CompareHLToBC
    pop hl
    jr c, .done
    ld a, b
    ld [hl-], a
    ld [hl], c

.done:
    xor a, a
    ld [rRAMG], a
    ret

; the word at HL += C, capped at 999; C becomes the amount actually added (E-0124)
; 1 call site from 1 routine (e.g. ApplyBattleResultStatChanges)
AddCToWordCappedAt999::
Func_0A0_5C8F:: ; address name
    ld a, [hl+]
    add a, c
    ld e, a
    ld a, [hl]
    adc a, $00
    ld d, a
    push de
    ld a, e
    sub a, $E7
    ld e, a
    ld a, d
    sbc a, $03
    jr c, .restore
    or a, e
    jr z, .restore
    ld a, c
    sub a, e
    ld c, a
    pop de
    ld d, $03
    ld e, $E7
    jr .skip

.restore:
    pop de

.skip:
    ld [hl], d
    dec hl
    ld [hl], e
    ret

; the word at HL -= C; results at or below 0 become 1 (B = the amount actually taken) (E-0124)
; 7 call sites from 1 routine (e.g. ApplyBattleResultStatChanges)
SubtractCFromWordMin1::
Func_0A0_5CB2:: ; address name
    ld b, c
    ld a, [hl+]
    sub a, c
    ld e, a
    ld a, [hl-]
    sbc a, $00
    ld d, a
    jr c, .skip
    or a, e
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
    ld [hl+], a
    ld a, d
    ld [hl+], a
    ret

; finds the entry with the smallest of five words after HL (ties broken randomly), stores its index in wD0A6 and returns HL + Data_0A0_5D54[index] (E-0122)
; 1 call site from 1 routine (e.g. ApplyBattleResultStatChanges)
; writes: wWorkBuf
OffsetByIndexOfMinOfFiveWords::
Func_0A0_5CCD:: ; address name
    push hl
    ld de, $0000
    ld a, [hl+]
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

; next table entry: D += 1; if its word is below BC (or equal and RollChance80Of256 succeeds), BC = word and E = D (E-0122)
; 5 call sites from 1 routine (e.g. OffsetByIndexOfMinOfFiveWords)
KeepMinWordEntry::
Func_0A0_5CF9:: ; address name
    inc hl
    inc d
    ld a, [hl+]
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

; finds the entry with the largest of five words after HL (ties broken randomly), stores its index in wD0A6 and returns HL + Data_0A0_5D54[index] (E-0122)
; 1 call site from 1 routine (e.g. ApplyBattleResultStatChanges)
; writes: wWorkBuf
OffsetByIndexOfMaxOfFiveWords::
Func_0A0_5D0C:: ; address name
    push hl
    ld de, $0000
    ld a, [hl+]
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

; next table entry: D += 1; if its word is not below BC (equal only when RollChance80Of256 fails), BC = word and E = D (E-0122)
; 5 call sites from 1 routine (e.g. OffsetByIndexOfMaxOfFiveWords)
KeepMaxWordEntry::
Func_0A0_5D38:: ; address name
    inc hl
    inc d
    ld a, [hl+]
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

; AdvanceRandom, then compares wC5E7 with $80: carry (success) half the time (E-0116)
; 2 call sites from 2 routines (e.g. KeepMaxWordEntry, KeepMinWordEntry)
; reads: wRandomLo
RollChance80Of256::
Func_0A0_5D4B:: ; address name
    call AdvanceRandom
    ld a, [wRandomLo]
    cp a, $80
    ret

; address loaded by OffsetByIndexOfMinOfFiveWords, OffsetByIndexOfMaxOfFiveWords
OffsetByIndexOfMinOfFiveWords_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0A0_5D54:: ; address name
    db $00, $04, $06, $08, $0A, $0C

; one byte per rank 0-7: the amount added to the lowest record word
; address loaded by ApplyBattleResultStatChanges
BattleResultStatBonusByRank:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0A0_5D5A:: ; address name
    db $01, $02, $03, $04, $05, $06, $08, $0A

; one byte per rank 0-7: the amount subtracted (floor 1)
; address loaded by ApplyBattleResultStatChanges
BattleResultStatPenaltyByRank:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0A0_5D62:: ; address name
    db $01, $01, $01, $01, $01, $01, $01, $01

; one word per rank 0-7, stored to wWorkBuf+$10 (C1: a gold amount, from the gold reads that follow)
; address loaded by ApplyBattleResultStatChanges
BattleResultGoldByRank:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0A0_5D6A:: ; address name
    db $E8, $03, $E8, $03, $E8, $03, $E8, $03, $E8, $03, $E8, $03, $E8, $03, $E8, $03

; only called from RunBattlePhaseWhenTextIdle_A0_RunTurn_Case00 (E-0047)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_RunTurn_Case00_FillBytesAndStep)
; writes: wBattleFlag92, wBattleFlag93, wMenuState
; points at: wSideControl, wSlotFlags854, wActionQueue, wBattleActionChoice, wSlotMarks, wBattleStep, wBattleStatus3
RunBattlePhaseWhenTextIdle_A0_RunTurn_Case00_FillBytes::
Func_0A0_5D7A:: ; address name
    ld hl, wSideControl
    ld b, $08

.loop:
    set 7, [hl]
    inc hl
    dec b
    jr nz, .loop
    ld hl, wSlotFlags854
    ld bc, $0010
    xor a, a
    call FillBytes
    ld hl, wActionQueue
    ld bc, $000A
    xor a, a
    call FillBytes
    ld hl, wBattleActionChoice
    ld bc, $0010
    ld a, $FF
    call FillBytes
    ld a, $FF
    ld [wBattleFlag92], a
    ld [wBattleFlag93], a
    ld a, $00
    ld [wMenuState], a
    ld bc, $0200
    ld hl, wSlotMarks
    push bc

.loop2:
    ld a, [hl+]
    or a, a
    jr nz, .next
    inc c

.next:
    dec b
    jr nz, .loop2
    ld a, c
    or a, a
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
    ld a, [hl+]
    and a, $C0
    jr nz, .skip
    ld a, [hl+]
    and a, $0C
    jr nz, .skip
    ld a, [hl+]
    and a, $30
    jr nz, .skip
    inc hl
    inc hl
    ld a, [hl]
    and a, $03
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

; the same instruction sequence as RunBattleSetup (bank $31) apart from label operands, which refer to this bank's own routines and tables; the twin's note describes the shape (E-0107)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_RunTurn_ToRunBattleSetup_BankA0)
; reads: wBattleSubPhase
RunBattleSetup_BankA0::
Func_0A0_5E07:: ; address name
    ld a, [wBattleSubPhase]
    rst $00
    dw RunBattleSetup_BankA0_EntrySelect
    dw RunBattleSetup_BankA0_CommandMenu
    dw RunBattleSetup_BankA0_Return
    dw RunBattleSetup_BankA0_ClearAndLayoutTileBlocksForBattleFoeCount
    dw RunBattleSetup_BankA0_ShowSelectingHeroSMove
    dw RunBattleSetup_BankA0_AdvanceRandom
    dw RunBattleSetup_BankA0_WaitLinkMessage
    dw RunBattleSetup_BankA0_SetBattleSubPhase
    dw RunBattleSetup_BankA0_WaitLinkMessage_Case08
    dw RunBattleSetup_BankA0_WriteLinkSendByteAndCounterPtr0Lo
    dw RunBattleSetup_BankA0_WriteCounterPtr0HiAndLinkSendByte
    dw RunBattleSetup_BankA0_WriteLinkSendByteAndBattleSubPhase
    dw RunBattleSetup_BankA0_FillTilesFromRequest

; by wBattleResolveStep: lays out the tile blocks for the foe count and moves a selection over entries, setting or clearing bit 6 and the entry tile (SetBit6AndBlankEntryTile_BankA0, ClearBit6AndCursorEntryTile_BankA0)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleResolveStep
RunBattleSetup_BankA0_EntrySelect::
Jump_0A0_5E25:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw RunBattleSetup_BankA0_EntrySelect_ClearAndLayoutTileBlocksForBattleFoeCount
    dw RunBattleSetup_BankA0_EntrySelect_ToCopyRect32StrideToVRAM_BankA0_Case01
    dw RunBattleSetup_BankA0_EntrySelect_ClearAndLayoutTileBlocksForBattleFoeCount_Case02
    dw RunBattleSetup_BankA0_EntrySelect_ToCopyRect32StrideToVRAM_BankA0AndStep
    dw RunBattleSetup_BankA0_EntrySelect_WriteBattleSetupDBAndStringIndexEtc
    dw RunBattleSetup_BankA0_EntrySelect_CopyRectRecord7345ToScreenBufferAndStep
    dw RunBattleSetup_BankA0_EntrySelect_ToBeginStringDisplay_Bank2FAndStep
    dw RunBattleSetup_BankA0_EntrySelect_ClearAndLayoutTileBlocksForBattleFoeCount_Case07

; entry 0 of the `rst $00` table in RunBattleSetup_BankA0_EntrySelect
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wSideControl, wBattleResolveStep
RunBattleSetup_BankA0_EntrySelect_ClearAndLayoutTileBlocksForBattleFoeCount::
Jump_0A0_5E39:: ; address name
    ld hl, wSideControl
    set 7, [hl]
    inc hl
    set 7, [hl]
    inc hl
    set 7, [hl]
    inc hl
    set 7, [hl]
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    farcall DrawWC278RowsToBGMapRow7
    ld hl, vTiles1 + $6D0
    ld de, $0701
    ld a, $02
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_BankA0
    farcall CopyRectRecord73ADToScreenBuffer
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunBattleSetup_BankA0_EntrySelect
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuState
; points at: wBattleResolveStep
RunBattleSetup_BankA0_EntrySelect_ToCopyRect32StrideToVRAM_BankA0_Case01::
Jump_0A0_5E71:: ; address name
    call RunBattleSetup_BankA0_EntrySelect_ToCopyRect32StrideToVRAM_BankA0
    ld hl, RunBattleSetup_BankA0_EntrySelect_ToCopyRect32StrideToVRAM_BankA0_Case01_Data
    ld a, [wMenuState]
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunBattleSetup_BankA0_EntrySelect
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed
; points at: wMenuState, wMenuSubState, wBattleResolveStep
RunBattleSetup_BankA0_EntrySelect_ClearAndLayoutTileBlocksForBattleFoeCount_Case02::
Jump_0A0_5E93:: ; address name
    ld de, RunBattleSetup_BankA0_EntrySelect_ToCopyRect32StrideToVRAM_BankA0_Case01_Data
    ld hl, wMenuState
    call RunBattleSetup_BankA0_EntrySelect_Case02_SetBit6AndBlankEntryTile_BankA0
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

; entry 3 of the `rst $00` table in RunBattleSetup_BankA0_EntrySelect
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
RunBattleSetup_BankA0_EntrySelect_ToCopyRect32StrideToVRAM_BankA0AndStep::
Jump_0A0_5EBE:: ; address name
    call RunBattleSetup_BankA0_EntrySelect_ToCopyRect32StrideToVRAM_BankA0
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in RunBattleSetup_BankA0_EntrySelect
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuState, wLinkRole
; writes: wBattleSetupDB, wStringIndex, wStringCategory, wCommandMonster, wBattleSubPhase, wBattleResolveStep
; points at: wBattleResolveStep, wSlotMarks
RunBattleSetup_BankA0_EntrySelect_WriteBattleSetupDBAndStringIndexEtc::
Jump_0A0_5EC6:: ; address name
    ld a, [wMenuState]
    and a, $03
    ld [wBattleSetupDB], a
    or a, a
    jr z, .call_run_battle_setup_bank_a0_entry_select
    cp a, $01
    jr z, .read_link_role
    cp a, $02
    jr z, .skip
    jr .set_string_index_to_20

.call_run_battle_setup_bank_a0_entry_select:
    call RunBattleSetup_BankA0_EntrySelect_Case04_ReadLinkRole
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    jp .return

.read_link_role:
    ld a, [wLinkRole]
    rrca
    and a, $01
    ld c, a
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    or a, a
    jr z, .set_command_monster
    ld a, $00
    ld [wStringCategory], a
    ld a, $2D
    ld [wStringIndex], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.set_command_monster:
    ld a, c
    ld [wCommandMonster], a
    ld a, $01
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    jr .return

.skip:
    ld a, $1D
    jr .set_string_index

.set_string_index_to_20:
    ld a, $20

.set_string_index:
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    ld hl, wBattleResolveStep
    inc [hl]

.return:
    ret

; only called from RunBattleSetup_BankA0_EntrySelect_Case04 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_BankA0_EntrySelect_WriteBattleSetupDBAndStringIndexEtc)
; reads: wLinkRole
; points at: wBattleActionChoice
RunBattleSetup_BankA0_EntrySelect_Case04_ReadLinkRole::
Func_0A0_5F2E:: ; address name
    ld a, [wLinkRole]
    and a, $02
    ld hl, wBattleActionChoice
    add_a_to_hl
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ret

; entry 5 of the `rst $00` table in RunBattleSetup_BankA0_EntrySelect
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
RunBattleSetup_BankA0_EntrySelect_CopyRectRecord7345ToScreenBufferAndStep::
Jump_0A0_5F40:: ; address name
    call RunBattleSetup_BankA0_ReadSTAT
    farcall CopyRectRecord7345ToScreenBuffer
    call DrawWC338RowsToBGMapRow13_BankA0
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunBattleSetup_BankA0_EntrySelect
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
RunBattleSetup_BankA0_EntrySelect_ToBeginStringDisplay_Bank2FAndStep::
Jump_0A0_5F51:: ; address name
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in RunBattleSetup_BankA0_EntrySelect
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wBattleResolveStep
RunBattleSetup_BankA0_EntrySelect_ClearAndLayoutTileBlocksForBattleFoeCount_Case07::
Jump_0A0_5F5C:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    call DrawWC338RowsToBGMapRow13_BankA0
    farcall CopyRectRecord73ADToScreenBuffer
    ld a, $01
    ld [wBattleResolveStep], a
    ret

; by wBattleResolveStep: the bank-$A0 copy of RunBattleSetup_CommandMenu (command windows, 'It has no usable ...')
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleResolveStep
RunBattleSetup_BankA0_CommandMenu::
Jump_0A0_5F76:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw RunBattleSetup_BankA0_CommandMenu_ShowStringBank09AtTilesHL_BankA0
    dw RunBattleSetup_BankA0_CommandMenu_DrawWC278Rect20x11ToBGMapRow7_BankA0_Case01
    dw RunBattleSetup_BankA0_CommandMenu_WriteBattleArg1AndBattleResolveStepEtc
    dw RunBattleSetup_BankA0_CommandMenu_DrawWC278Rect20x11ToBGMapRow7_BankA0
    dw RunBattleSetup_BankA0_CommandMenu_DrawWC278Rect20x11ToBGMapRow7_BankA0_Case04
    dw RunBattleSetup_BankA0_CommandMenu_DrawWC2B8Rect11x9ToBGMapRow9_BankA0
    dw RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount
    dw RunBattleSetup_BankA0_CommandMenu_DrawWC2B8Rect11x9ToBGMapRow9_BankA0_Case07
    dw RunBattleSetup_BankA0_CommandMenu_DrawWC2B8Rect11x9ToBGMapRow9_BankA0AndStep
    dw RunBattleSetup_BankA0_CommandMenu_ShowItHasNoUsable
    dw RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount_Case0A
    dw RunBattleSetup_BankA0_CommandMenu_DrawWC338RowsToBGMapRow13_BankA0
    dw RunBattleSetup_BankA0_CommandMenu_DrawWC2B8Rect11x9ToBGMapRow9_BankA0_Case0C
    dw RunBattleSetup_BankA0_CommandMenu_DrawWC2A4AndWC2B8Rects_BankA0_Case0D
    dw RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount_Case0E
    dw RunBattleSetup_BankA0_CommandMenu_DrawWC2A4AndWC2B8Rects_BankA0
    dw RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount_Case10
    dw RunBattleSetup_BankA0_CommandMenu_DrawWC338RowsToBGMapRow13_BankA0AndStep
    dw RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount_Case12
    dw RunBattleSetup_BankA0_CommandMenu_DrawWC338RowsToBGMapRow13_BankA0_Case13
    dw RunBattleSetup_BankA0_CommandMenu_SetBattleResolveStep
    dw RunBattleSetup_BankA0_CommandMenu_DrawWC2B8Rect11x9ToBGMapRow9_BankA0AndStep
    dw RunBattleSetup_BankA0_CommandMenu_ShowButThereIsNo
    dw RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount_Case0A
    dw RunBattleSetup_BankA0_CommandMenu_DrawWC338RowsToBGMapRow13_BankA0

; entry 0 of the `rst $00` table in RunBattleSetup_BankA0_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex, wCommandPageCount, wCommandCursorMax, wCommandCursor
; points at: wBattleResolveStep
RunBattleSetup_BankA0_CommandMenu_ShowStringBank09AtTilesHL_BankA0::
Jump_0A0_5FAC:: ; address name
    ld hl, vTiles1 + $6D0
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
    xor a, a
    ld [wCommandPageCount], a
    ld a, $03
    ld [wCommandCursorMax], a
    xor a, a
    ld [wCommandCursor], a
    farcall CopyRectRecord747FToScreenBuffer
    ld hl, wScreenTileBuffer + $103
    call WriteFiveTilesFromTable67D2
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunBattleSetup_BankA0_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wCommandMonster, wMenuSubState
; writes: wMenuSubState, wListLastPageSize
; points at: wBattleSetupD8, wBattleResolveStep
RunBattleSetup_BankA0_CommandMenu_DrawWC278Rect20x11ToBGMapRow7_BankA0_Case01::
Jump_0A0_5FEB:: ; address name
    ld a, [wCommandMonster]
    ld hl, wBattleSetupD8
    add_a_to_hl
    ld a, [hl]
    ld [wMenuSubState], a
    call DrawWC278Rect20x11ToBGMapRow7_BankA0
    ld hl, RunBattleSetup_BankA0_CommandMenu_DrawWC278Rect20x11ToBGMapRow7_BankA0_Case01_Data
    ld a, [wMenuSubState]
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $03
    ld [wListLastPageSize], a
    ret

; entry 2 of the `rst $00` table in RunBattleSetup_BankA0_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wCommandMonster, wMenuSubState
; writes: wBattleArg1, wBattleResolveStep, wBattleSubPhase
; points at: wMenuSubState, wBattleSetupD8, wBattleResolveStep, wBattleActionChoice, wSideControl
RunBattleSetup_BankA0_CommandMenu_WriteBattleArg1AndBattleResolveStepEtc::
Jump_0A0_6021:: ; address name
    ld de, RunBattleSetup_BankA0_CommandMenu_DrawWC278Rect20x11ToBGMapRow7_BankA0_Case01_Data
    ld hl, wMenuSubState
    call RunBattleSetup_BankA0_CommandMenu_SetBit6AndBlankEntryTile_BankA0
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    ld a, [wCommandMonster]
    ld hl, wBattleSetupD8
    add_a_to_hl
    ld a, [wMenuSubState]
    and a, $03
    ld [hl], a
    call SetSlotTacticAndSlotLastTacticForCommandMonster_BankA0
    cp a, $03
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
    add a, a
    add_a_to_hl
    ld a, $FF
    ld [hl+], a
    ld [hl], a
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    set 7, [hl]
    xor a, a
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

; entry 3 of the `rst $00` table in RunBattleSetup_BankA0_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep, wBattleSubPhase
RunBattleSetup_BankA0_CommandMenu_DrawWC278Rect20x11ToBGMapRow7_BankA0::
Jump_0A0_60A0:: ; address name
    call DrawWC278Rect20x11ToBGMapRow7_BankA0
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubPhase], a
    ret

; entry 4 of the `rst $00` table in RunBattleSetup_BankA0_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg1, wCommandMonster
; writes: wBattleArg1, wStringCategory, wStringIndex, wMenuSelectedMember
; points at: wSideControl, wBattleResolveStep
RunBattleSetup_BankA0_CommandMenu_DrawWC278Rect20x11ToBGMapRow7_BankA0_Case04::
Jump_0A0_60AC:: ; address name
    ld a, [wBattleArg1]
    or a, a
    call z, DrawWC278Rect20x11ToBGMapRow7_BankA0
    xor a, a
    ld [wBattleArg1], a
    ld hl, vTiles1 + $6D0
    ld de, $0803
    ld a, $02
    ld [wStringCategory], a
    ld a, $09
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_BankA0
    farcall CopyRectRecord75ABToScreenBuffer
    ld a, [wCommandMonster]
    and a, $03
    ld hl, wScreenTileBuffer + $142
    call WriteFiveTilesFromTable67D2
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    swap a
    and a, $03
    ld [wMenuSelectedMember], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunBattleSetup_BankA0_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuSelectedMember
; points at: wBattleResolveStep
RunBattleSetup_BankA0_CommandMenu_DrawWC2B8Rect11x9ToBGMapRow9_BankA0::
Jump_0A0_60F3:: ; address name
    call DrawWC2B8Rect11x9ToBGMapRow9_BankA0
    ld hl, RunBattleSetup_BankA0_CommandMenu_DrawWC2B8Rect11x9ToBGMapRow9_BankA0_Data
    ld a, [wMenuSelectedMember]
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunBattleSetup_BankA0_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wCommandMonster, wMenuSelectedMember
; writes: wBattleArg1, wBattleResolveStep
; points at: wMenuSelectedMember, wBattleResolveStep, wSideControl, wBattleActionChoice
RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount::
Jump_0A0_6115:: ; address name
    ld de, RunBattleSetup_BankA0_CommandMenu_DrawWC2B8Rect11x9ToBGMapRow9_BankA0_Data
    ld hl, wMenuSelectedMember
    call RunBattleSetup_BankA0_CommandMenu_Case06_SetBit6AndBlankEntryTile_BankA0
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
    and a, $0F
    ld [hl], a
    ld a, [wMenuSelectedMember]
    and a, $03
    swap a
    or a, [hl]
    ld [hl], a
    ld a, [wMenuSelectedMember]
    and a, $03
    or a, a
    jr z, .read_command_monster
    cp a, $01
    jr z, .call_run_battle_setup_bank_a0_command_menu
    jr .read_command_monster2

.read_command_monster:
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, $C0
    ld [hl+], a
    ld a, [wCommandMonster]
    xor a, $01
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
    call RunBattleSetup_BankA0_CommandMenu_Case06_WriteBattleArg2AndBattleArg3Etc
    ld a, d
    or a, a
    jr nz, .call_clear_and_layout_tile_blocks_for_battle2
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    ld a, $08
    ld [wBattleResolveStep], a
    jr .return

.call_clear_and_layout_tile_blocks_for_battle2:
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    xor a, a
    ld [wBattleArg1], a
    ld a, $0C
    ld [wBattleResolveStep], a
    jr .return

.read_command_monster2:
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, $AC
    ld [hl+], a
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

; entry 7 of the `rst $00` table in RunBattleSetup_BankA0_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg1
; writes: wBattleResolveStep
RunBattleSetup_BankA0_CommandMenu_DrawWC2B8Rect11x9ToBGMapRow9_BankA0_Case07::
Jump_0A0_61DA:: ; address name
    call DrawWC2B8Rect11x9ToBGMapRow9_BankA0
    ld a, [wBattleArg1]
    or a, a
    jr z, .set_battle_resolve_step
    ld a, $14

.set_battle_resolve_step:
    ld [wBattleResolveStep], a
    ret

; entry 8 of the `rst $00` table in RunBattleSetup_BankA0_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
RunBattleSetup_BankA0_CommandMenu_DrawWC2B8Rect11x9ToBGMapRow9_BankA0AndStep::
Jump_0A0_61E9:: ; address name
    call DrawWC2B8Rect11x9ToBGMapRow9_BankA0
    call FillTilesFromRequest
    farcall CopyRectRecord7345ToScreenBuffer
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in RunBattleSetup_BankA0_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wBattleResolveStep
RunBattleSetup_BankA0_CommandMenu_ShowItHasNoUsable::
Jump_0A0_61FA:: ; address name
    call DrawWC338RowsToBGMapRow13_BankA0
    ld a, $00
    ld [wStringCategory], a
    ld a, $29
    ld [wStringIndex], a ; 'It has no usable battle skills!'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 22 of the `rst $00` table in RunBattleSetup_BankA0_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wBattleResolveStep
RunBattleSetup_BankA0_CommandMenu_ShowButThereIsNo::
Jump_0A0_6212:: ; address name
    call DrawWC338RowsToBGMapRow13_BankA0
    ld a, $00
    ld [wStringCategory], a
    ld a, $7F
    ld [wStringIndex], a ; 'But there is no one to'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in RunBattleSetup_BankA0_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; points at: wBattleResolveStep
RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount_Case0A::
Jump_0A0_622A:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 11 of the `rst $00` table in RunBattleSetup_BankA0_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep
RunBattleSetup_BankA0_CommandMenu_DrawWC338RowsToBGMapRow13_BankA0::
Jump_0A0_623A:: ; address name
    call DrawWC338RowsToBGMapRow13_BankA0
    ld a, $04
    ld [wBattleResolveStep], a
    ret

; entry 12 of the `rst $00` table in RunBattleSetup_BankA0_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg1, wCommandMonster, wBattleArg2, wBattleArg3, wCommandCursor, wMenuCursor
; writes: wBattleArg1, wMenuCursor, wCommandCursor, wStringCategory
; points at: wSideControl, wCommandCursor, wBattleResolveStep
RunBattleSetup_BankA0_CommandMenu_DrawWC2B8Rect11x9ToBGMapRow9_BankA0_Case0C::
Jump_0A0_6243:: ; address name
    ld a, [wBattleArg1]
    or a, a
    call z, DrawWC2B8Rect11x9ToBGMapRow9_BankA0
    xor a, a
    ld [wBattleArg1], a
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    and a, $03
    ld [wMenuCursor], a
    ld a, [hl]
    rrca
    rrca
    and a, $01
    ld [wCommandCursor], a
    ld hl, wCommandCursor
    res 7, [hl]
    ld de, RunBattleSetup_BankA0_CommandMenu_DrawWC278Rect20x11ToBGMapRow7_BankA0_Case01_Data
    call ShowSkillPageNames_BankA0
    call RunBattleSetup_BankA0_CommandMenu_ClearBit6AndCursorEntryTile_BankA0
    farcall CopyRectRecords7600And7734ToScreenBuffer
    ld a, $09
    ld [wStringCategory], a
    ld a, [wBattleArg2]
    ld l, a
    ld a, [wBattleArg3]
    ld h, a
    ld a, [wCommandCursor]
    add a, a
    add a, a
    ld c, a
    ld a, [wMenuCursor]
    and a, $03
    add a, c
    add a, a
    add_a_to_hl
    ld a, [hl]
    call RunBattleSetup_BankA0_CommandMenu_ShowStringBank08AtTilesHL_BankA0
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in RunBattleSetup_BankA0_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuCursor
; writes: wListLastPageSize
; points at: wBattleResolveStep
RunBattleSetup_BankA0_CommandMenu_DrawWC2A4AndWC2B8Rects_BankA0_Case0D::
Jump_0A0_62A3:: ; address name
    call DrawWC2A4AndWC2B8Rects_BankA0
    ld hl, RunBattleSetup_BankA0_CommandMenu_DrawWC278Rect20x11ToBGMapRow7_BankA0_Case01_Data
    ld a, [wMenuCursor]
    and a, $03
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    call DrawInventoryPageIndicator_BankA0
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $03
    ld [wListLastPageSize], a
    ret

; entry 14 of the `rst $00` table in RunBattleSetup_BankA0_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wRecordBufferData, wCommandMonster, wCommandCursor, wMenuCursor, wRecordBuffer
; writes: wBattleArg1, wStringIndex
; points at: wMenuCursor, wBattleMP, wSideControl, wBattleActionChoice, wBattleResolveStep
RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount_Case0E::
Jump_0A0_62CD:: ; address name
    ld de, RunBattleSetup_BankA0_CommandMenu_DrawWC278Rect20x11ToBGMapRow7_BankA0_Case01_Data
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
    add a, a
    add_a_to_hl
    deref_hl
    ld a, [wRecordBufferData]
    ld c, a
    cp a, $FF
    jr nz, .skip
    ld c, $01

.skip:
    xor a, a
    ld b, a
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    bit 7, h
    jp nz, .set_string_index_to_26
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    and a, $F0
    ld [hl], a
    ld a, [wCommandCursor]
    rlca
    rlca
    and a, $04
    or a, [hl]
    ld [hl], a
    ld a, [wMenuCursor]
    and a, $03
    or a, [hl]
    ld [hl], a
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a, a
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

; entry 15 of the `rst $00` table in RunBattleSetup_BankA0_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleArg1
; writes: wBattleResolveStep, wBattleArg1
RunBattleSetup_BankA0_CommandMenu_DrawWC2A4AndWC2B8Rects_BankA0::
Jump_0A0_639B:: ; address name
    call DrawWC2A4AndWC2B8Rects_BankA0
    ld a, [wBattleArg1]
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleArg1], a
    ret

; entry 16 of the `rst $00` table in RunBattleSetup_BankA0_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount_Case10::
Jump_0A0_63A9:: ; address name
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    call DrawWC2A4AndWC2B8Rects_BankA0
    farcall CopyRectRecord7345ToScreenBuffer
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 17 of the `rst $00` table in RunBattleSetup_BankA0_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory
; points at: wBattleResolveStep
RunBattleSetup_BankA0_CommandMenu_DrawWC338RowsToBGMapRow13_BankA0AndStep::
Jump_0A0_63BD:: ; address name
    call DrawWC338RowsToBGMapRow13_BankA0
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 18 of the `rst $00` table in RunBattleSetup_BankA0_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; points at: wBattleResolveStep
RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount_Case12::
Jump_0A0_63CF:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 19 of the `rst $00` table in RunBattleSetup_BankA0_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep
RunBattleSetup_BankA0_CommandMenu_DrawWC338RowsToBGMapRow13_BankA0_Case13::
Jump_0A0_63DF:: ; address name
    call DrawWC338RowsToBGMapRow13_BankA0
    ld a, $0C
    ld [wBattleResolveStep], a
    ret

; entry 20 of the `rst $00` table in RunBattleSetup_BankA0_CommandMenu
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep, wBattleSubPhase
RunBattleSetup_BankA0_CommandMenu_SetBattleResolveStep::
Jump_0A0_63E8:: ; address name
    xor a, a
    ld [wBattleResolveStep], a
    ld a, $03
    ld [wBattleSubPhase], a
    ret

; entry 2 of the `rst $00` table in RunBattleSetup_BankA0
; no direct call (reached through a table, a jump or a vector)
RunBattleSetup_BankA0_Return::
Jump_0A0_63F2:: ; address name
    ret

; entry 3 of the `rst $00` table in RunBattleSetup_BankA0
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleActor, wLinkSendByte
; points at: wSlotMarks, wBattleSubPhase
RunBattleSetup_BankA0_ClearAndLayoutTileBlocksForBattleFoeCount::
Jump_0A0_63F3:: ; address name
    ld b, $08
    ld hl, wSlotMarks

.loop:
    ld a, [hl]
    or a, a
    jr nz, .next
    ld [hl], $01

.next:
    inc hl
    dec b
    jr nz, .loop
    xor a, a
    ld [wBattleActor], a
    farcall ClearAndLayoutTileBlocksForBattleFoeCount
    call RunBattleSetup_BankA0_ReadSTAT
    farcall CopyRectRecord7345ToScreenBuffer
    farcall DrawWC278RowsToBGMapRow7
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wLinkSendByte], a
    ret

; entry 4 of the `rst $00` table in RunBattleSetup_BankA0
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wLinkSeedCopy, wTextBuf0, wBattleSubPhase
RunBattleSetup_BankA0_ShowSelectingHeroSMove::
Jump_0A0_6424:: ; address name
    ld de, wLinkSeedCopy
    ld hl, wTextBuf0
    call CopyFiveGlyphsPlusMarks
    ld a, $00
    ld [wStringCategory], a
    ld a, $22
    ld [wStringIndex], a ; 'Selecting 0's move'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunBattleSetup_BankA0
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wRandomHi, wLinkRole, wMenuState, wMenuSubState, wSideControl, wBattleActionChoice, wBattleTargetChoice
; writes: wLinkSendByte
; points at: wSlotTactic, wLinkRecvBuffer, wBattleSubPhase
RunBattleSetup_BankA0_AdvanceRandom::
Jump_0A0_6442:: ; address name
    call AdvanceRandom
    ld a, [wRandomLo]
    cp a, $F3
    ret z
    ld a, [wRandomHi]
    cp a, $F3
    ret z
    ld a, [wLinkRole]
    rrca
    and a, $01
    ld hl, wSlotTactic
    add_a_to_hl
    ld d, [hl]
    ld hl, wLinkRecvBuffer
    ld a, [wMenuState]
    ld [hl+], a
    ld a, [wMenuSubState]
    ld [hl+], a
    ld a, d
    ld [hl+], a
    ld a, [wRandomLo]
    ld [hl+], a
    ld a, [wRandomHi]
    ld [hl+], a
    ld a, [wSideControl]
    ld [hl+], a
    ld a, [wSideControl + $1]
    ld [hl+], a
    ld a, [wBattleActionChoice]
    ld [hl+], a
    ld a, [wBattleTargetChoice]
    ld [hl+], a
    ld a, [wBattleActionChoice + $2]
    ld [hl+], a
    ld a, [wBattleActionChoice + $3]
    ld [hl+], a
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunBattleSetup_BankA0
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkBufferCountHi, wLinkBufferCountLo, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, wLinkBufferPtrHi
; points at: wBattleSubPhase, wLinkRecvBuffer, wLinkPartnerName
RunBattleSetup_BankA0_WaitLinkMessage::
Jump_0A0_6497:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wLinkBufferCountHi], a
    ld a, $0B
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

; entry 7 of the `rst $00` table in RunBattleSetup_BankA0
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte, wLinkReady
; points at: wBattleSubPhase
RunBattleSetup_BankA0_SetBattleSubPhase::
Jump_0A0_64C1:: ; address name
    ld hl, wBattleSubPhase
    inc [hl]
    ld a, $FF
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; entry 8 of the `rst $00` table in RunBattleSetup_BankA0
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wLinkRole, wBattleSetupFlagsLo, wBattleSetupFlagsHi
; writes: wLinkSendByte, wLinkReady, wCommandBytesE9, wCommandByteEA, wSlotTactic, wSideControl, wBattleActionChoice, wMenuState, ...
; points at: wLinkPartnerName, wBattleSubPhase, wMenuState, wSlotTactic, wSlotLastTactic
RunBattleSetup_BankA0_WaitLinkMessage_Case08::
Jump_0A0_64D0:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wLinkReady], a
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .set_command_bytes_e9
    ld hl, wLinkPartnerName
    ld a, [hl+]
    ld [wCommandBytesE9], a
    ld a, [hl+]
    ld [wCommandByteEA], a
    ld a, [hl+]
    ld [wSlotTactic + $1], a
    ld a, [wBattleSetupFlagsLo]
    ld [hl+], a
    ld a, [wBattleSetupFlagsHi]
    ld [hl+], a
    inc hl
    ld a, [hl+]
    ld [wSideControl + $1], a
    inc hl
    inc hl
    ld a, [hl+]
    ld [wBattleActionChoice + $2], a
    ld a, [hl]
    ld [wBattleActionChoice + $3], a
    ld hl, wSlotTactic + $1
    ld de, wSlotLastTactic + $1
    jr .skip

.set_command_bytes_e9:
    ld hl, wMenuState
    ld a, [hl+]
    ld [wCommandBytesE9], a
    ld a, [hl]
    ld [wCommandByteEA], a
    ld hl, wLinkPartnerName
    ld a, [hl+]
    ld [wMenuState], a
    ld a, [hl+]
    ld [wMenuSubState], a
    ld a, [hl+]
    ld [wSlotTactic], a
    ld a, [hl+]
    ld [wRandomLo], a
    ld a, [hl+]
    ld [wRandomHi], a
    ld a, [hl+]
    ld [wSideControl], a
    inc hl
    ld a, [hl+]
    ld [wBattleActionChoice], a
    ld a, [hl]
    ld [wBattleTargetChoice], a
    ld hl, wSlotTactic
    ld de, wSlotLastTactic

.skip:
    ld a, [hl]
    cp a, $03
    jr z, .done
    ld [de], a

.done:
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 9 of the `rst $00` table in RunBattleSetup_BankA0
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wRandomSeed2Lo, wRandomHi, wRandomSeed2Hi
; writes: wLinkSendByte, wCounterPtr0Lo
; points at: wBattleSetupFlagsLo, wBattleSubPhase
RunBattleSetup_BankA0_WriteLinkSendByteAndCounterPtr0Lo::
Jump_0A0_6553:: ; address name
    ld hl, wBattleSetupFlagsLo
    ld a, [hl+]
    ld b, a
    ld a, [wRandomLo]
    cp a, b
    ld a, [wRandomSeed2Lo]
    cp a, b
    jr nz, .set_link_send_byte_to_33
    ld a, [hl]
    ld b, a
    ld a, [wRandomHi]
    cp a, b
    ld a, [wRandomSeed2Hi]
    cp a, b
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

; entry 10 of the `rst $00` table in RunBattleSetup_BankA0
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wCounterPtr0Hi, wLinkSendByte
; points at: wBattleSubPhase
RunBattleSetup_BankA0_WriteCounterPtr0HiAndLinkSendByte::
Jump_0A0_6585:: ; address name
    ld a, [wLinkMessage]
    cp a, $22
    jr z, .set_counter_ptr0_hi
    cp a, $33
    jr z, .set_counter_ptr0_hi
    ret

.set_counter_ptr0_hi:
    ld [wCounterPtr0Hi], a
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 11 of the `rst $00` table in RunBattleSetup_BankA0
; no direct call (reached through a table, a jump or a vector)
; reads: wCounterPtr0Lo, wCounterPtr0Hi
; writes: wLinkSendByte, wBattleSubPhase
; points at: wBattleSubPhase
RunBattleSetup_BankA0_WriteLinkSendByteAndBattleSubPhase::
Jump_0A0_659D:: ; address name
    ld a, [wCounterPtr0Lo]
    cp a, $22
    jr nz, .set_battle_sub_phase_to_05
    ld a, [wCounterPtr0Hi]
    cp a, $22
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

; entry 12 of the `rst $00` table in RunBattleSetup_BankA0
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wBattleSubPhase
; points at: wBattleStep
RunBattleSetup_BankA0_FillTilesFromRequest::
Jump_0A0_65BD:: ; address name
    ld a, [wLinkMessage]
    cp a, $02
    ret nz
    call FillTilesFromRequest
    ld hl, wBattleStep
    inc [hl]
    xor a, a
    ld [wBattleSubPhase], a
    ret

; only called from RunBattleSetup_BankA0_EntrySelect_Case02 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_BankA0_EntrySelect_ClearAndLayoutTileBlocksForBattleFoeCount_Case02)
; reads: wJoypadPressedRepeat, wFrameCounterLo
; writes: wFrameCounterLo
RunBattleSetup_BankA0_EntrySelect_Case02_SetBit6AndBlankEntryTile_BankA0::
Func_0A0_65CF:: ; address name
    ld a, [wJoypadPressedRepeat]
    and a, $C0
    jr z, .check_joypad_pressed_repeat
    call SetBit6AndBlankEntryTile_BankA0
    ld a, [hl]
    xor a, $01
    ld [hl], a
    call ClearBit6AndCursorEntryTile_BankA0
    ld a, $69
    call QueueSoundEffect
    jr .check_frame_counter_lo2

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and a, $30
    jr z, .check_frame_counter_lo
    call SetBit6AndBlankEntryTile_BankA0
    ld a, [hl]
    xor a, $02
    ld [hl], a
    call ClearBit6AndCursorEntryTile_BankA0
    ld a, $69
    call QueueSoundEffect
    jr .check_frame_counter_lo2

.check_frame_counter_lo:
    ld a, [wFrameCounterLo]
    and a, $0F
    jr nz, .return
    bit 6, [hl]
    jr z, .call_set_bit6_and_blank_entry_tile_bank_a0
    call ClearBit6AndCursorEntryTile_BankA0
    jr .check_frame_counter_lo2

.call_set_bit6_and_blank_entry_tile_bank_a0:
    call SetBit6AndBlankEntryTile_BankA0

.check_frame_counter_lo2:
    ld a, [wFrameCounterLo]
    and a, $F0
    ld [wFrameCounterLo], a

.return:
    ret

; only called from RunBattleSetup_BankA0_CommandMenu_Case06 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount)
; reads: wJoypadPressedRepeat, wFrameCounterLo
; writes: wFrameCounterLo
RunBattleSetup_BankA0_CommandMenu_Case06_SetBit6AndBlankEntryTile_BankA0::
Func_0A0_661B:: ; address name
    ld a, [wJoypadPressedRepeat]
    and a, $40
    jr z, .check_joypad_pressed_repeat
    call SetBit6AndBlankEntryTile_BankA0
    ld a, [hl]
    and a, $03
    dec a
    cp a, $FF
    jr nz, .call_clear_bit6_and_cursor_entry_tile_bank_a0
    ld a, $02
    jr .call_clear_bit6_and_cursor_entry_tile_bank_a0

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and a, $80
    jr z, .check_frame_counter_lo
    call SetBit6AndBlankEntryTile_BankA0
    ld a, [hl]
    and a, $03
    inc a
    cp a, $03
    jr nz, .call_clear_bit6_and_cursor_entry_tile_bank_a0
    xor a, a

.call_clear_bit6_and_cursor_entry_tile_bank_a0:
    ld [hl], a
    call ClearBit6AndCursorEntryTile_BankA0
    ld a, $69
    call QueueSoundEffect
    jr .check_frame_counter_lo2

.check_frame_counter_lo:
    ld a, [wFrameCounterLo]
    and a, $0F
    jr nz, .return
    bit 6, [hl]
    jr z, .call_set_bit6_and_blank_entry_tile_bank_a0
    call ClearBit6AndCursorEntryTile_BankA0
    jr .check_frame_counter_lo2

.call_set_bit6_and_blank_entry_tile_bank_a0:
    call SetBit6AndBlankEntryTile_BankA0

.check_frame_counter_lo2:
    ld a, [wFrameCounterLo]
    and a, $F0
    ld [wFrameCounterLo], a

.return:
    ret

; only called from routines of RunBattleSetup_BankA0_CommandMenu (E-0098)
; 2 call sites from 2 routines (e.g. RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount_Case0E, RunBattleSetup_BankA0_CommandMenu_WriteBattleArg1AndBattleResolveStepEtc)
; reads: wJoypadPressedRepeat, wCommandCursor, wCommandPageCount, wCommandCursorMax, wFrameCounterLo, wListLastPageSize
; writes: wFrameCounterLo, wCommandCursor
RunBattleSetup_BankA0_CommandMenu_SetBit6AndBlankEntryTile_BankA0::
Func_0A0_666B:: ; address name
    ld a, [wJoypadPressedRepeat]
    and a, $40
    jr z, .check_joypad_pressed_repeat
    ld a, [wCommandCursor]
    ld b, a
    ld a, [wCommandPageCount]
    cp a, b
    jr nz, .call_set_bit6_and_blank_entry_tile_bank_a0
    ld a, [wCommandCursorMax]
    or a, a
    jp z, .check_frame_counter_lo3
    call SetBit6AndBlankEntryTile_BankA0
    ld a, [hl]
    and a, $0F
    dec a
    cp a, $FF
    jr nz, .call_clear_bit6_and_cursor_entry_tile_bank_a0
    ld a, [wCommandCursorMax]
    jr .call_clear_bit6_and_cursor_entry_tile_bank_a0

.call_set_bit6_and_blank_entry_tile_bank_a0:
    call SetBit6AndBlankEntryTile_BankA0
    ld a, [hl]
    and a, $0F
    dec a
    cp a, $FF
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
    and a, $80
    jr z, .check_command_page_count
    ld a, [wCommandCursor]
    ld b, a
    ld a, [wCommandPageCount]
    cp a, b
    jr nz, .call_set_bit6_and_blank_entry_tile_bank_a02
    ld a, [wCommandCursorMax]
    or a, a
    jp z, .check_frame_counter_lo3
    ld b, a
    call SetBit6AndBlankEntryTile_BankA0
    inc b
    ld a, [hl]
    and a, $0F
    inc a
    cp a, b
    jr nz, .call_clear_bit6_and_cursor_entry_tile_bank_a02
    ld a, $00
    jr .call_clear_bit6_and_cursor_entry_tile_bank_a02

.call_set_bit6_and_blank_entry_tile_bank_a02:
    call SetBit6AndBlankEntryTile_BankA0
    ld a, [wListLastPageSize]
    inc a
    ld b, a
    ld a, [hl]
    and a, $0F
    inc a
    cp a, b
    jr nz, .call_clear_bit6_and_cursor_entry_tile_bank_a02
    xor a, a

.call_clear_bit6_and_cursor_entry_tile_bank_a02:
    ld [hl], a
    call ClearBit6AndCursorEntryTile_BankA0
    set 7, [hl]
    ld a, $69
    call QueueSoundEffect
    jr .check_frame_counter_lo3

.check_command_page_count:
    ld a, [wCommandPageCount]
    or a, a
    jr z, .check_frame_counter_lo
    ld b, a
    ld a, [wJoypadPressedRepeat]
    and a, $20
    jr z, .check_joypad_pressed_repeat2
    ld a, [wCommandCursor]
    or a, a
    jr nz, .set_command_cursor
    ld a, b
    jr .set_command_cursor2

.set_command_cursor:
    dec a

.set_command_cursor2:
    or a, $80
    ld [wCommandCursor], a
    ld a, $69
    call QueueSoundEffect
    jr .call_set_bit6_and_blank_entry_tile_bank_a04

.check_joypad_pressed_repeat2:
    ld a, [wJoypadPressedRepeat]
    and a, $10
    jr z, .check_frame_counter_lo
    ld a, [wCommandCursor]
    cp a, b
    jr nz, .set_command_cursor3
    xor a, a
    jr .set_command_cursor4

.set_command_cursor3:
    inc a

.set_command_cursor4:
    or a, $80
    ld [wCommandCursor], a
    ld a, $69
    call QueueSoundEffect
    jr .call_set_bit6_and_blank_entry_tile_bank_a04

.check_frame_counter_lo:
    ld a, [wFrameCounterLo]
    and a, $0F
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
    cp a, b
    jr nz, .check_frame_counter_lo3
    ld a, [wCommandCursorMax]
    or a, a
    jr nz, .skip
    xor a, a
    jr .check_frame_counter_lo2

.skip:
    ld b, a

.skip2:
    ld a, [hl]
    and a, $0F
    cp a, b
    jr z, .check_frame_counter_lo2
    jr c, .check_frame_counter_lo3
    dec [hl]
    jr .skip2

.check_frame_counter_lo2:
    set 7, a
    ld [hl], a

.check_frame_counter_lo3:
    ld a, [wFrameCounterLo]
    and a, $F0
    ld [wFrameCounterLo], a

.return:
    ret

; HL = entry byte, DE = table of BG map offsets: sets bit 6 of [HL] and writes tile $C3 at $9800 + table[[HL] & $3F] (WriteVRAMByte); HL kept (E-0074) (the same 31 bytes appear in 2 banks)
; 12 call sites from 3 routines (e.g. RunBattleSetup_BankA0_EntrySelect_Case02_SetBit6AndBlankEntryTile_BankA0, RunBattleSetup_BankA0_CommandMenu_SetBit6AndBlankEntryTile_BankA0, RunBattleSetup_BankA0_CommandMenu_Case06_SetBit6AndBlankEntryTile_BankA0)
SetBit6AndBlankEntryTile_BankA0::
Func_0A0_677A:: ; address name
    set 6, [hl]
    ld a, [hl]
    and a, $3F
    push hl
    add a, a
    add a, e
    ld l, a
    ld a, d
    adc a, $00
    ld h, a
    deref_hl
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $98
    ld h, a
    ld a, $C3
    call WriteVRAMByte
    pop hl
    ret

; HL = entry byte, DE = table of BG map offsets: clears bit 6 of [HL] and writes tile $BB at $9800 + table[[HL] & $3F] (WriteVRAMByte); HL kept (E-0074) (the same 31 bytes appear in 2 banks)
; 9 call sites from 4 routines (e.g. RunBattleSetup_BankA0_EntrySelect_Case02_SetBit6AndBlankEntryTile_BankA0, RunBattleSetup_BankA0_CommandMenu_ClearBit6AndCursorEntryTile_BankA0, RunBattleSetup_BankA0_CommandMenu_SetBit6AndBlankEntryTile_BankA0, RunBattleSetup_BankA0_CommandMenu_Case06_SetBit6AndBlankEntryTile_BankA0)
ClearBit6AndCursorEntryTile_BankA0::
Func_0A0_6799:: ; address name
    res 6, [hl]
    ld a, [hl]
    and a, $3F
    push hl
    add a, a
    add a, e
    ld l, a
    ld a, d
    adc a, $00
    ld h, a
    deref_hl
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $98
    ld h, a
    ld a, $BB
    call WriteVRAMByte
    pop hl
    ret

; clears wC46C and writes five consecutive tile numbers starting at Data_0A0_67D2[wCFD4] to HL (E-0122)
; 2 call sites from 2 routines (e.g. RunBattleSetup_BankA0_CommandMenu_DrawWC278Rect20x11ToBGMapRow7_BankA0_Case04, RunBattleSetup_BankA0_CommandMenu_ShowStringBank09AtTilesHL_BankA0)
; reads: wCommandMonster
; writes: wMenuSubState
WriteFiveTilesFromTable67D2::
Func_0A0_67B8:: ; address name
    push hl
    ld a, [wCommandMonster]
    ld hl, WriteFiveTilesFromTable67D2_Data
    add_a_to_hl
    xor a, a
    ld [wMenuSubState], a
    ld a, [hl]
    pop hl
    ld b, $05

.loop:
    ld [hl+], a
    inc a
    dec b
    jr nz, .loop
    ret

; address loaded by WriteFiveTilesFromTable67D2
WriteFiveTilesFromTable67D2_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0A0_67D2:: ; address name
    db $D0, $D5

; only called from RunBattleSetup_BankA0_CommandMenu_Case06 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount)
; reads: wCommandMonster
; writes: wBattleArg2, wBattleArg3, wCommandPageCount, wCommandCursorMax, wCommandCursor
; points at: wBattleSkills
RunBattleSetup_BankA0_CommandMenu_Case06_WriteBattleArg2AndBattleArg3Etc::
Func_0A0_67D4:: ; address name
    ld a, [wCommandMonster]
    ld hl, wBattleSkills
    swap a
    and a, $F0
    add_a_to_hl
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    ld bc, $0800
    ld d, $00

.loop:
    ld a, [hl+]
    cp a, $FF
    jr z, .skip
    or a, a
    jr z, .skip
    cp a, $A2
    jr c, .next
    cp a, $AA
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
    cp a, $05
    ld a, $00
    jr c, .set_command_page_count
    inc a

.set_command_page_count:
    ld [wCommandPageCount], a
    ld a, c
    or a, a
    jr z, .set_command_cursor_max
    and a, $03
    dec a
    and a, $03

.set_command_cursor_max:
    ld [wCommandCursorMax], a
    xor a, a
    ld [wCommandCursor], a
    ret

; shows the four skill names (category 4) of page wCFD5 of monster wCFD4's skills (wD989 + 16 * wCFD4) in the four tile rows; $FF shows string 0 (E-0121)
; 2 call sites from 2 routines (e.g. RunBattleSetup_BankA0_CommandMenu_ClearBit6AndCursorEntryTile_BankA0, RunBattleSetup_BankA0_CommandMenu_DrawWC2B8Rect11x9ToBGMapRow9_BankA0_Case0C)
; reads: wCommandMonster, wCommandCursor
; writes: wStringCategory, wBattleArg2, wBattleArg3
; points at: wBattleSkills
ShowSkillPageNames_BankA0::
Func_0A0_6822:: ; address name
    ld a, $04
    ld [wStringCategory], a
    ld a, [wCommandMonster]
    ld hl, wBattleSkills
    swap a
    and a, $F0
    add_a_to_hl
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    ld a, [wCommandCursor]
    add a, a
    add a, a
    add a, a
    add_a_to_hl
    ld a, [hl+]
    inc hl
    cp a, $FF
    call z, ReturnZero_6871
    call ShowStringAAtTiles16D0_BankA0
    ld a, [hl+]
    inc hl
    cp a, $FF
    call z, ReturnZero_6871
    call ShowStringAAtTiles1760_BankA0
    ld a, [hl+]
    inc hl
    cp a, $FF
    call z, ReturnZero_6871
    call ShowStringAAtTiles17F0_BankA0
    ld a, [hl]
    cp a, $FF
    call z, ReturnZero_6871
    call ShowStringAAtTiles2080_BankA0
    ret

; A = 0 (xor a); a two-byte handler stub (E-0111)
; 4 call sites from 1 routine (e.g. ShowSkillPageNames_BankA0)
ReturnZero_6871::
Func_0A0_6871:: ; address name
    xor a, a
    ret

; only called from routines of RunBattleSetup_BankA0_CommandMenu (E-0098)
; 2 call sites from 2 routines (e.g. RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount_Case0E, RunBattleSetup_BankA0_CommandMenu_DrawWC2B8Rect11x9ToBGMapRow9_BankA0_Case0C)
; reads: wCommandCursor, wMenuCursor, wBattleArg2, wBattleArg3
; writes: wCommandCursor, wMenuCursor, wStringCategory
; points at: wMenuCursor
RunBattleSetup_BankA0_CommandMenu_ClearBit6AndCursorEntryTile_BankA0::
Func_0A0_6873:: ; address name
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
    and a, $0F
    push af
    ld a, $09
    ld [wStringCategory], a
    ld a, [wBattleArg2]
    ld l, a
    ld a, [wBattleArg3]
    ld h, a
    ld a, [wCommandCursor]
    add a, a
    add a, a
    ld c, a
    pop af
    add a, c
    add a, a
    add_a_to_hl
    ld a, [hl]
    call RunBattleSetup_BankA0_CommandMenu_ShowStringBank08AtTilesHL_BankA0
    ld de, wWindowTileBuffer + $88
    ld hl, vBGMap0 + $1F0
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    ld a, [de]
    call WriteVRAMByte
    ret

; wStringIndex = A, then ShowStringBank08AtTilesHL_BankA0 at vTiles1 + $6D0 with size $0901; HL kept (E-0116)
; 1 call site from 1 routine (e.g. ShowSkillPageNames_BankA0)
; writes: wStringIndex
ShowStringAAtTiles16D0_BankA0::
Func_0A0_68CF:: ; address name
    ld [wStringIndex], a
    push hl
    ld hl, vTiles1 + $6D0
    ld de, $0901
    call ShowStringBank08AtTilesHL_BankA0
    pop hl
    ret

; wStringIndex = A, then the string at vTiles1 + $760 with size $0901; HL kept (E-0116)
; 1 call site from 1 routine (e.g. ShowSkillPageNames_BankA0)
; writes: wStringIndex
ShowStringAAtTiles1760_BankA0::
Func_0A0_68DE:: ; address name
    ld [wStringIndex], a
    push hl
    ld hl, vTiles1 + $760
    ld de, $0901
    call ShowStringBank08AtTilesHL_BankA0
    pop hl
    ret

; wStringIndex = A, then the string at vTiles1 + $7F0 with size $0901; HL kept (E-0116)
; 1 call site from 1 routine (e.g. ShowSkillPageNames_BankA0)
; writes: wStringIndex
ShowStringAAtTiles17F0_BankA0::
Func_0A0_68ED:: ; address name
    ld [wStringIndex], a
    push hl
    ld hl, vTiles1 + $7F0
    ld de, $0901
    call ShowStringBank08AtTilesHL_BankA0
    pop hl
    ret

; wStringIndex = A, then the string at vTiles2 + $80 with size $0901 (E-0116)
; 1 call site from 1 routine (e.g. ShowSkillPageNames_BankA0)
; writes: wStringIndex
ShowStringAAtTiles2080_BankA0::
Func_0A0_68FC:: ; address name
    ld [wStringIndex], a
    ld hl, vTiles2 + $80
    ld de, $0901
    call ShowStringBank08AtTilesHL_BankA0
    ret

; only called from routines of RunBattleSetup_BankA0_CommandMenu (E-0098)
; 2 call sites from 2 routines (e.g. RunBattleSetup_BankA0_CommandMenu_ClearBit6AndCursorEntryTile_BankA0, RunBattleSetup_BankA0_CommandMenu_DrawWC2B8Rect11x9ToBGMapRow9_BankA0_Case0C)
; reads: wRecordBufferData, wCommandMonster
; writes: wStringIndex, wRecordBuffer
; points at: wBattleMP
RunBattleSetup_BankA0_CommandMenu_ShowStringBank08AtTilesHL_BankA0::
Func_0A0_6909:: ; address name
    push af
    ld [wStringIndex], a
    ld hl, vTiles1
    ld de, $0603
    call ShowStringBank08AtTilesHL_BankA0
    pop af
    ld [wRecordBuffer], a
    xor a, a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    ld a, [wRecordBufferData]
    cp a, $FF
    jr nz, .skip
    ld a, [wCommandMonster]
    ld hl, wBattleMP
    add a, a
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

; when wCFD7 is non-zero writes tiles $C5, $E0 + (wCFD5 & 7) + 1, $BE, $E0 + wCFD7 + 1, $C6 at vBGMap0 + $226 (page X of Y) (E-0121)
; 2 call sites from 2 routines (e.g. RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount_Case0E, RunBattleSetup_BankA0_CommandMenu_DrawWC2A4AndWC2B8Rects_BankA0_Case0D)
; reads: wCommandPageCount, wCommandCursor
DrawInventoryPageIndicator_BankA0::
Func_0A0_694B:: ; address name
    ld a, [wCommandPageCount]
    or a, a
    ret z
    ld hl, vBGMap0 + $226
    ld a, $C5
    call WriteVRAMByteInc
    ld a, [wCommandCursor]
    and a, $07
    inc a
    add a, $E0
    call WriteVRAMByteInc
    ld a, $BE
    call WriteVRAMByteInc
    ld a, [wCommandPageCount]
    inc a
    add a, $E0
    call WriteVRAMByteInc
    ld a, $C6
    call WriteVRAMByte
    ret

; address loaded by RunBattleSetup_BankA0_EntrySelect_ToCopyRect32StrideToVRAM_BankA0_Case01, RunBattleSetup_BankA0_EntrySelect_ClearAndLayoutTileBlocksForBattleFoeCount_Case02
RunBattleSetup_BankA0_EntrySelect_ToCopyRect32StrideToVRAM_BankA0_Case01_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0A0_6977:: ; address name
    db $C1, $01, $01, $02, $C7, $01, $07, $02

; address loaded by RunBattleSetup_BankA0_CommandMenu_DrawWC278Rect20x11ToBGMapRow7_BankA0_Case01, RunBattleSetup_BankA0_CommandMenu_WriteBattleArg1AndBattleResolveStepEtc, RunBattleSetup_BankA0_CommandMenu_DrawWC2B8Rect11x9ToBGMapRow9_BankA0_Case0C, RunBattleSetup_BankA0_CommandMenu_DrawWC2A4AndWC2B8Rects_BankA0_Case0D and 1 more
RunBattleSetup_BankA0_CommandMenu_DrawWC278Rect20x11ToBGMapRow7_BankA0_Case01_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0A0_697F:: ; address name
    db $41, $01, $81, $01, $C1, $01, $01, $02

; address loaded by RunBattleSetup_BankA0_CommandMenu_DrawWC2B8Rect11x9ToBGMapRow9_BankA0, RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount
RunBattleSetup_BankA0_CommandMenu_DrawWC2B8Rect11x9ToBGMapRow9_BankA0_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0A0_6987:: ; address name
    db $81, $01, $C1, $01, $01, $02, $C1, $01, $01, $02, $C1, $01, $01, $02, $29, $00
    db $69, $00, $A9, $00, $E9, $00, $2F, $01, $6F, $01

; A = value: stores A in wDA43[wCFD4], and also in wDA4B[wCFD4] unless A is 3 (E-0118)
; 1 call site from 1 routine (e.g. RunBattleSetup_BankA0_CommandMenu_WriteBattleArg1AndBattleResolveStepEtc)
; reads: wCommandMonster
; points at: wSlotTactic, wSlotLastTactic
SetSlotTacticAndSlotLastTacticForCommandMonster_BankA0::
Func_0A0_69A1:: ; address name
    push af
    ld a, [wCommandMonster]
    ld hl, wSlotTactic
    add_a_to_hl
    pop af
    ld [hl], a
    cp a, $03
    ret z
    push af
    ld a, [wCommandMonster]
    ld hl, wSlotLastTactic
    add_a_to_hl
    pop af
    ld [hl], a
    ret

; wRecordBuffer = the skill at wD989 + 16 * wCFD4 + 2 * (4 * (wCFD5 & 1) + (wC46E & 3)), wCFED = 0, then far-calls LoadSkillRecord (E-0120) (the same 48 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. RunBattleSetup_BankA0_CommandMenu_ClearAndLayoutTileBlocksForBattleFoeCount_Case0E)
; reads: wMenuCursor, wCommandCursor, wCommandMonster
; writes: wRecordBuffer
; points at: wBattleSkills
LoadSelectedSkillRecord_BankA0::
Func_0A0_69C1:: ; address name
    ld a, [wMenuCursor]
    and a, $03
    ld b, a
    ld a, [wCommandCursor]
    and a, $01
    add a, a
    add a, a
    add a, b
    add a, a
    ld hl, wBattleSkills
    add_a_to_hl
    ld a, [wCommandMonster]
    swap a
    add_a_to_hl
    ld a, [hl]
    ld [wRecordBuffer], a
    xor a, a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    ret

; side base = ((wC57F << 1) & 4) ^ 4, the side opposite CountPresentSlotsOfLinkRoleSide; D = how many of its three slots are present, E = the last present one (0 when none); clobbers A, BC (E-0067) (the same 28 bytes appear in 2 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRole
CountPresentFoesOfLinkRoleSide_BankA0:: ; heuristic: follows a terminator; C0
Func_0A0_69F1:: ; address name
    ld de, $0000
    ld b, $03
    ld a, [wLinkRole]
    sla a
    and a, $04
    xor a, $04
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

; side base = (wC57F << 1) & 4: D = how many of its three slots are present; clobbers A, BC (E-0067) (the same 24 bytes appear in 2 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRole
CountPresentSlotsOfLinkRoleSide_BankA0:: ; heuristic: follows a terminator; C0
Func_0A0_6A0D:: ; address name
    ld d, $00
    ld b, $03
    ld a, [wLinkRole]
    sla a
    and a, $04
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

; far-calls RunDebugState_E0 (E-0122)
; no direct call (reached through a table, a jump or a vector)
CallFunc443BInBankE0_BankA0:: ; heuristic: follows a terminator; C0
Func_0A0_6A25:: ; address name
    farcall RunDebugState_E0
    ret

; only called from routines of RunBattleSetup_BankA0 (E-0098)
; 2 call sites from 2 routines (e.g. RunBattleSetup_BankA0_ClearAndLayoutTileBlocksForBattleFoeCount, RunBattleSetup_BankA0_EntrySelect_CopyRectRecord7345ToScreenBufferAndStep)
; reads: rSTAT
RunBattleSetup_BankA0_ReadSTAT::
Func_0A0_6A2C:: ; address name
    ld hl, vTiles1
    ld bc, $0120

.loop:
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, $FF
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ei
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ret

; C = slot 0-2: when the slot is present and its status byte 0 is non-zero, calls one marker routine for each of bits 0, 1, 4, 5, 6 and 7 that is set (the zero-status path is not read) (E-0111)
; 2 call sites from 2 routines (e.g. DrawSlotPanelValues_BankA0, DrawSlotStatusMarks)
; points at: wBattleStatus
DrawSlotStatusMarks_BankA0::
Func_0A0_6A45:: ; address name
    push bc
    ld a, c
    cp a, $03
    jr nc, .done
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .call_draw_slot_level_bank_a02
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    or a, a
    jr z, .call_draw_slot_level_bank_a0
    call DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0
    bit 0, [hl]
    call nz, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Sub03
    bit 1, [hl]
    call nz, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Sub04
    bit 4, [hl]
    call nz, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Sub06
    bit 5, [hl]
    call nz, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Sub02
    bit 6, [hl]
    call nz, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Sub07
    bit 7, [hl]
    call nz, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Sub05
    jr .done

.call_draw_slot_level_bank_a0:
    call DrawSlotLevel_BankA0
    ld a, c
    and a, $03
    ld hl, DrawSlotStatusMarks_BankA0_Data
    add a, a
    add_a_to_hl
    call DerefHL_BankA0
    ld [hl], $C3
    jr .done

.call_draw_slot_level_bank_a02:
    call DrawSlotLevel_BankA0
    ld a, c
    and a, $03
    ld hl, DrawSlotStatusMarks_BankA0_Data
    add a, a
    add_a_to_hl
    call DerefHL_BankA0
    ld [hl], $C2

.done:
    pop bc
    ret

; only called from DrawSlotStatusMarks_BankA0 (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotStatusMarks_BankA0)
DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0::
Func_0A0_6AAB:: ; address name
    push hl
    ld hl, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Data
    call ReadWordTableEntryForSlotC_BankA0
    ld a, $C3
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    pop hl
    ret

; only called from DrawSlotStatusMarks_BankA0 (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotStatusMarks_BankA0)
DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Sub02::
Func_0A0_6ABB:: ; address name
    push hl
    ld hl, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Data
    call ReadWordTableEntryForSlotC_BankA0
    ld [hl], $C0
    pop hl
    ret

; only called from DrawSlotStatusMarks_BankA0 (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotStatusMarks_BankA0)
DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Sub03::
Func_0A0_6AC6:: ; address name
    push hl
    ld hl, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Sub03_Data
    call ReadWordTableEntryForSlotC_BankA0
    ld [hl], $C1
    pop hl
    ret

; only called from DrawSlotStatusMarks_BankA0 (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotStatusMarks_BankA0)
DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Sub04::
Func_0A0_6AD1:: ; address name
    push hl
    ld hl, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Sub03_Data
    call ReadWordTableEntryForSlotC_BankA0
    ld [hl], $C7
    pop hl
    ret

; only called from DrawSlotStatusMarks_BankA0 (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotStatusMarks_BankA0)
DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Sub05::
Func_0A0_6ADC:: ; address name
    push hl
    ld hl, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Sub05_Data
    call ReadWordTableEntryForSlotC_BankA0
    ld [hl], $C8
    pop hl
    ret

; only called from DrawSlotStatusMarks_BankA0 (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotStatusMarks_BankA0)
DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Sub06::
Func_0A0_6AE7:: ; address name
    push hl
    ld hl, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Sub06_Data
    call ReadWordTableEntryForSlotC_BankA0
    ld [hl], $C9
    pop hl
    ret

; only called from DrawSlotStatusMarks_BankA0 (E-0047)
; 1 call site from 1 routine (e.g. DrawSlotStatusMarks_BankA0)
DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Sub07::
Func_0A0_6AF2:: ; address name
    push hl
    ld hl, DrawSlotStatusMarks_BankA0_Data
    call ReadWordTableEntryForSlotC_BankA0
    ld [hl], $CA
    pop hl
    ret

; the same 13 bytes as ReadWordTableEntryForSlotC (31:778E)
; 7 call sites from 7 routines (e.g. DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Sub05, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Sub07, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Sub02, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Sub06, ...)
ReadWordTableEntryForSlotC_BankA0::
Func_0A0_6AFD:: ; address name
    ld a, c
    and a, $03
    add a, a
    add a, l
    ld l, a
    jr nc, DerefHL_BankA0
    inc h

; the same 4 bytes as DerefHL_Bank31 (31:7797)
; 2 call sites from 1 routine (e.g. DrawSlotStatusMarks_BankA0)
DerefHL_BankA0::
Func_0A0_6B06:: ; address name
    deref_hl
    ret

; address loaded by DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Sub02
DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0A0_6B0A:: ; address name
    db $39, $C2, $46, $C2

; address loaded by DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Sub06
DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Sub06_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0A0_6B0E:: ; address name
    db $3A, $C2, $47, $C2

; address loaded by DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Sub03, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Sub04
DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Sub03_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0A0_6B12:: ; address name
    db $3B, $C2, $48, $C2

; address loaded by DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Sub05
DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Sub05_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0A0_6B16:: ; address name
    db $3C, $C2, $49, $C2

; address loaded by DrawSlotStatusMarks_BankA0, DrawSlotStatusMarks_BankA0_ReadWordTableEntryForSlotC_BankA0_Sub07
DrawSlotStatusMarks_BankA0_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0A0_6B1A:: ; address name
    db $3D, $C2, $4A, $C2

; C = slot 0-2: copies the 5-tile panel row at Data_0A0_6D53's offset from wScreenTileBuffer to vBGMap0 (the wC58A = 2 form of CopySlotPanelRowToVRAM) (E-0111)
; 2 call sites from 2 routines (e.g. BuildAndCopySlotPanel_A0, CopySlotPanelRowToVRAM)
; points at: wScreenTileBuffer
CopySlotPanelRowToVRAM_BankA0::
Func_0A0_6B1E:: ; address name
    ld a, c
    cp a, $03
    jr nc, .return
    ld hl, CopySlotPanelRowToVRAM_BankA0_Data
    add a, a
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

; C = slot 0-2: writes the slot's HP as decimal digit tiles into wScreenTileBuffer at the position from Data_0A0_6D47 (the wC58A = 2 form of DrawSlotHPDigits) (E-0111)
; 2 call sites from 2 routines (e.g. DrawSlotPanelValues_BankA0, DrawSlotHPDigits)
; points at: wBattleHP, wScreenTileBuffer
DrawSlotHPDigits_BankA0::
Func_0A0_6B46:: ; address name
    push bc
    ld a, c
    cp a, $03
    jr nc, .done
    ld hl, wBattleHP
    add a, a
    add_a_to_hl
    deref_hl
    push bc
    call HLToDecimalDigits
    pop bc
    ld a, c
    and a, $03
    push hl
    ld hl, DrawSlotHPDigits_BankA0_Data
    add a, a
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

; C = slot 0-2: writes the slot's MP as decimal digit tiles into wScreenTileBuffer at the position from Data_0A0_6D4B (the wC58A = 2 form of DrawSlotMPDigits) (E-0111)
; 2 call sites from 2 routines (e.g. DrawSlotPanelValues_BankA0, DrawSlotMPDigits)
; points at: wBattleMP, wScreenTileBuffer
DrawSlotMPDigits_BankA0::
Func_0A0_6B79:: ; address name
    push bc
    ld a, c
    cp a, $04
    jr nc, .done
    and a, $03
    cp a, $03
    jr z, .done
    ld a, c
    ld hl, wBattleMP
    add a, a
    add_a_to_hl
    deref_hl
    push bc
    call HLToDecimalDigits
    pop bc
    ld a, c
    and a, $03
    push hl
    ld hl, DrawSlotMPDigits_BankA0_Data
    add a, a
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

; C = slot 0-2: writes tiles $EA, $AF (not in the charmap; probably a level mark) into wScreenTileBuffer at the position from Data_0A0_6D4F, then the value wD8B7[slot] as digits (probably the level; the digit part is not read to its end) (E-0111)
; 3 call sites from 2 routines (e.g. DrawSlotStatusMarks_BankA0, DrawSlotStatusMarks_DrawSlotLevel_BankA0)
; points at: wScreenTileBuffer, wBattleLevel
DrawSlotLevel_BankA0::
Func_0A0_6BB3:: ; address name
    push bc
    ld a, c
    cp a, $04
    jr nc, .done
    and a, $03
    cp a, $03
    jr z, .done
    ld a, c
    and a, $03
    ld hl, DrawSlotLevel_BankA0_Data
    add a, a
    add_a_to_hl
    deref_hl
    ld de, wScreenTileBuffer
    add hl, de
    ld [hl], $EA
    inc hl
    ld [hl], $AF
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
    call WriteTwoDigitTilesFromWC8C1

.done:
    pop bc
    ret

; for slots 0-2: copies three tiles at offset Data_0A0_6D47[slot] from the screen buffer to vBGMap0 (E-0124)
; 2 call sites from 2 routines (e.g. BuildAndCopySlotPanel_A0, CopySlotPanelPart7AC8ToVRAM)
; points at: wScreenTileBuffer
CopySlotPanelPart6D47ToVRAM::
Func_0A0_6BF0:: ; address name
    ld a, c
    cp a, $04
    jr nc, .return
    and a, $03
    cp a, $03
    jr z, .return
    ld hl, DrawSlotHPDigits_BankA0_Data
    add a, a
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

; for slots 0-2: copies three tiles at offset Data_0A0_6D4B[slot] from the screen buffer to vBGMap0 (E-0124)
; 2 call sites from 2 routines (e.g. BuildAndCopySlotPanel_A0, CopySlotPanelPart7ACEToVRAM)
; points at: wScreenTileBuffer
CopySlotPanelPart6D4BToVRAM::
Func_0A0_6C22:: ; address name
    ld a, c
    cp a, $04
    jr nc, .return
    and a, $03
    cp a, $03
    jr z, .return
    ld hl, DrawSlotMPDigits_BankA0_Data
    add a, a
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

; for slots 0-2: copies two tiles at offset Data_0A0_6D4F[slot] from the screen buffer to vBGMap0 (E-0124)
; 1 call site from 1 routine (e.g. CopySlotPanelPart7AD4ToVRAM)
; points at: wScreenTileBuffer
CopySlotPanelPart6D4FToVRAM:: ; heuristic: follows a terminator; C0
Func_0A0_6C54:: ; address name
    ld a, c
    cp a, $04
    jr nc, .return
    and a, $03
    cp a, $03
    jr z, .return
    ld hl, DrawSlotLevel_BankA0_Data
    add a, a
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

; saves the string window wC52D-wC530, sets the tile destination to HL and the size to DE, far-calls ShowString_Bank09, then restores the window (E-0067) (the same 59 bytes appear in 3 banks)
; 4 call sites from 3 routines (e.g. RunBattleSetup_BankA0_EntrySelect_ClearAndLayoutTileBlocksForBattleFoeCount, RunBattleSetup_BankA0_CommandMenu_DrawWC278Rect20x11ToBGMapRow7_BankA0_Case04, RunBattleSetup_BankA0_CommandMenu_ShowStringBank09AtTilesHL_BankA0)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ShowStringBank09AtTilesHL_BankA0::
Func_0A0_6C81:: ; address name
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

; saves the string window wC52D-wC530, sets the tile destination to HL and the size to DE, far-calls ShowString_Bank08, then restores the window (E-0067) (the same 59 bytes appear in 2 banks)
; 5 call sites from 5 routines (e.g. RunBattleSetup_BankA0_CommandMenu_ShowStringBank08AtTilesHL_BankA0, ShowStringAAtTiles2080_BankA0, ShowStringAAtTiles17F0_BankA0, ShowStringAAtTiles1760_BankA0, ...)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ShowStringBank08AtTilesHL_BankA0::
Func_0A0_6CBC:: ; address name
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

; copies five glyphs plus marks to wTextBuf0 (CopyFiveGlyphsPlusMarks), then shows string category 2, index 0 in a 5 x 1 window at tile HL with ShowString_Bank08, saving and restoring the text window fields; no caller found (E-0238)
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex
; points at: wTextBuf0
UnreferencedShowFiveGlyphsAtTilesHL_BankA0:: ; configured code entry (E-0238); C0
Func_0A0_6CF7:: ; address name
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

; address loaded by DrawSlotHPDigits_BankA0, CopySlotPanelPart6D47ToVRAM
DrawSlotHPDigits_BankA0_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0A0_6D47:: ; address name
    db $62, $00, $6F, $00

; address loaded by DrawSlotMPDigits_BankA0, CopySlotPanelPart6D4BToVRAM
DrawSlotMPDigits_BankA0_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0A0_6D4B:: ; address name
    db $82, $00, $8F, $00

; address loaded by DrawSlotLevel_BankA0, CopySlotPanelPart6D4FToVRAM
DrawSlotLevel_BankA0_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0A0_6D4F:: ; address name
    db $A1, $00, $AE, $00

; address loaded by CopySlotPanelRowToVRAM_BankA0
CopySlotPanelRowToVRAM_BankA0_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0A0_6D53:: ; address name
    db $A1, $00, $AE, $00

; E-0256 (C1: PickEncounterMonsterForSlotC reads the word at $6D57 + 16 * PickRandomBand0To10 + 2 * wWildBand and picks one of the count words after the count byte with AdvanceRandom; 11 rows (families, StringTable_MonsterFamilies order) of 8 bands).
; record: species list (count, then words)
EncounterBandSpeciesTable::
Data_0A0_6D57:: ; address name
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

; E-0256 (C1: row 0 (Slime), band 0 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Slime_0::
Data_0A0_6E07:: ; address name
    db $03 ; entry 0
    dw $0002 ; SpotSlime
    dw $0005 ; Snaily
    dw $000F ; Slabbit

; E-0256 (C1: row 0 (Slime), band 1 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Slime_1::
Data_0A0_6E0E:: ; address name
    db $04 ; entry 0
    dw $0004 ; TreeSlime
    dw $0007 ; Babble
    dw $000A ; Slime
    dw $0014 ; TropicGel

; E-0256 (C1: row 0 (Slime), band 2 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Slime_2::
Data_0A0_6E17:: ; address name
    db $04 ; entry 0
    dw $0002 ; SpotSlime
    dw $0008 ; BoxSlime
    dw $0009 ; PearlGel
    dw $000B ; Healer

; E-0256 (C1: row 0 (Slime), band 3 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Slime_3::
Data_0A0_6E20:: ; address name
    db $05 ; entry 0
    dw $0001 ; DrakSlime
    dw $0006 ; SlimeNite
    dw $000C ; FangSlime
    dw $000D ; RockSlime
    dw $000E ; SlimeBorg

; E-0256 (C1: row 0 (Slime), band 4 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Slime_4::
Data_0A0_6E2B:: ; address name
    db $04 ; entry 0
    dw $0011 ; Metaly
    dw $0013 ; SpotKing
    dw $0015 ; MimeSlime
    dw $0016 ; HaloSlime

; E-0256 (C1: row 0 (Slime), band 5 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Slime_5::
Data_0A0_6E34:: ; address name
    db $03 ; entry 0
    dw $0010 ; KingSlime
    dw $0012 ; Metabble
    dw $0017 ; MetalKing

; E-0256 (C1: row 0 (Slime), band 6 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Slime_6::
Data_0A0_6E3B:: ; address name
    db $01 ; entry 0
    dw $0018 ; GoldSlime

; E-0256 (C1: row 0 (Slime), band 7 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Slime_7::
Data_0A0_6E3E:: ; address name
    db $02 ; entry 0
    dw $0019 ; GranSlime
    dw $001A ; WonderEgg

; E-0256 (C1: row 1 (Dragon), band 0 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Dragon_0::
Data_0A0_6E43:: ; address name
    db $03 ; entry 0
    dw $0028 ; FairyDrak
    dw $0031 ; Chamelgon
    dw $0032 ; LizardFly

; E-0256 (C1: row 1 (Dragon), band 1 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Dragon_1::
Data_0A0_6E4A:: ; address name
    db $05 ; entry 0
    dw $002A ; Poisongon
    dw $002E ; MiniDrak
    dw $0034 ; KingCobra
    dw $0036 ; SnakeBat
    dw $0039 ; Crestpent

; E-0256 (C1: row 1 (Dragon), band 2 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Dragon_2::
Data_0A0_6E55:: ; address name
    db $05 ; entry 0
    dw $0024 ; DragonKid
    dw $0025 ; Tortragon
    dw $0026 ; Pteranod
    dw $0027 ; Gasgon
    dw $003A ; WingSnake

; E-0256 (C1: row 1 (Dragon), band 3 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Dragon_3::
Data_0A0_6E60:: ; address name
    db $04 ; entry 0
    dw $002B ; Swordgon
    dw $002C ; Drygon
    dw $0030 ; Rayburn
    dw $0035 ; Vampirus

; E-0256 (C1: row 1 (Dragon), band 4 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Dragon_4::
Data_0A0_6E69:: ; address name
    db $06 ; entry 0
    dw $0029 ; LizardMan
    dw $002D ; Dragon
    dw $002F ; MadDragon
    dw $0033 ; Andreal
    dw $0037 ; Spikerous
    dw $003B ; Coatol

; E-0256 (C1: row 1 (Dragon), band 5 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Dragon_5::
Data_0A0_6E76:: ; address name
    db $04 ; entry 0
    dw $0038 ; GreatDrak
    dw $003D ; BattleRex
    dw $003E ; SkyDragon
    dw $003F ; Serpentia

; E-0256 (C1: row 1 (Dragon), band 6 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Dragon_6::
Data_0A0_6E7F:: ; address name
    db $03 ; entry 0
    dw $003C ; Orochi
    dw $0040 ; Divinegon
    dw $0042 ; GigaDraco

; E-0256 (C1: row 1 (Dragon), band 7 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Dragon_7::
Data_0A0_6E86:: ; address name
    db $01 ; entry 0
    dw $0041 ; Orligon

; E-0256 (C1: row 2 (Beast), band 0 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Beast_0::
Data_0A0_6E89:: ; address name
    db $06 ; entry 0
    dw $0048 ; Almiraj
    dw $0049 ; CatFly
    dw $004A ; PillowRat
    dw $004B ; Saccer
    dw $0050 ; Antbear
    dw $005B ; FairyRat

; E-0256 (C1: row 2 (Beast), band 1 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Beast_1::
Data_0A0_6E96:: ; address name
    db $06 ; entry 0
    dw $004D ; Skullroo
    dw $004E ; WindBeast
    dw $0053 ; Mommonja
    dw $0054 ; HammerMan
    dw $0057 ; ArrowDog
    dw $005A ; MadGopher

; E-0256 (C1: row 2 (Beast), band 2 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Beast_2::
Data_0A0_6EA3:: ; address name
    db $06 ; entry 0
    dw $0047 ; Tonguella
    dw $004F ; Beavern
    dw $0051 ; SuperTen
    dw $0052 ; IronTurt
    dw $0058 ; NoctoKing
    dw $0059 ; BeastNite

; E-0256 (C1: row 2 (Beast), band 3 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Beast_3::
Data_0A0_6EB0:: ; address name
    db $06 ; entry 0
    dw $0055 ; Grizzly
    dw $0056 ; Yeti
    dw $005D ; Goategon
    dw $005E ; WildApe
    dw $0065 ; CatMage
    dw $0066 ; Dumbira

; E-0256 (C1: row 2 (Beast), band 4 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Beast_4::
Data_0A0_6EBD:: ; address name
    db $04 ; entry 0
    dw $004C ; GulpBeast
    dw $005F ; Trumpeter
    dw $0062 ; MadCat
    dw $0063 ; BigEye

; E-0256 (C1: row 2 (Beast), band 5 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Beast_5::
Data_0A0_6EC6:: ; address name
    db $02 ; entry 0
    dw $005C ; Unicorn
    dw $0061 ; DarkHorn

; E-0256 (C1: row 2 (Beast), band 6 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Beast_6::
Data_0A0_6ECB:: ; address name
    db $01 ; entry 0
    dw $0060 ; KingLeo

; E-0256 (C1: row 2 (Beast), band 7 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Beast_7::
Data_0A0_6ECE:: ; address name
    db $01 ; entry 0
    dw $0064 ; Gorago

; E-0256 (C1: row 3 (Bird), band 0 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Bird_0::
Data_0A0_6ED1:: ; address name
    db $02 ; entry 0
    dw $006A ; Picky
    dw $0073 ; Dracky

; E-0256 (C1: row 3 (Bird), band 1 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Bird_1::
Data_0A0_6ED6:: ; address name
    db $04 ; entry 0
    dw $006D ; Florajay
    dw $0070 ; MadRaven
    dw $0074 ; KiteHawk
    dw $0075 ; BigRoost

; E-0256 (C1: row 3 (Bird), band 2 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Bird_2::
Data_0A0_6EDF:: ; address name
    db $06 ; entry 0
    dw $006C ; BullBird
    dw $0071 ; MistyWing
    dw $0072 ; AquaHawk
    dw $0076 ; StubBird
    dw $0077 ; LandOwl
    dw $0084 ; CragDevil

; E-0256 (C1: row 3 (Bird), band 3 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Bird_3::
Data_0A0_6EEC:: ; address name
    db $06 ; entry 0
    dw $006B ; Wyvern
    dw $006E ; DuckKite
    dw $006F ; MadPecker
    dw $0078 ; MadGoose
    dw $0079 ; MadCondor
    dw $007A ; Emyu

; E-0256 (C1: row 3 (Bird), band 4 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Bird_4::
Data_0A0_6EF9:: ; address name
    db $04 ; entry 0
    dw $007B ; Blizzardy
    dw $007C ; Phoenix
    dw $007D ; ZapBird
    dw $0080 ; FunkyBird

; E-0256 (C1: row 3 (Bird), band 5 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Bird_5::
Data_0A0_6F02:: ; address name
    db $02 ; entry 0
    dw $007E ; Garudian
    dw $007F ; WhipBird

; E-0256 (C1: row 3 (Bird), band 6 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Bird_6::
Data_0A0_6F07:: ; address name
    db $02 ; entry 0
    dw $0081 ; RainHawk
    dw $0083 ; Shantak

; E-0256 (C1: row 3 (Bird), band 7 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Bird_7::
Data_0A0_6F0C:: ; address name
    db $01 ; entry 0
    dw $0082 ; Azurile

; E-0256 (C1: row 4 (Plant), band 0 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Plant_0::
Data_0A0_6F0F:: ; address name
    db $04 ; entry 0
    dw $0091 ; CactiBall
    dw $0093 ; Toadstool
    dw $0095 ; Slurperon
    dw $00A6 ; Eggplaton

; E-0256 (C1: row 4 (Plant), band 1 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Plant_1::
Data_0A0_6F18:: ; address name
    db $03 ; entry 0
    dw $008D ; MadPlant
    dw $0090 ; WingTree
    dw $0097 ; Oniono

; E-0256 (C1: row 4 (Plant), band 2 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Plant_2::
Data_0A0_6F1F:: ; address name
    db $05 ; entry 0
    dw $008E ; FireWeed
    dw $008F ; FloraMan
    dw $0092 ; Gulpple
    dw $0096 ; Stubsuck
    dw $0098 ; DanceVegi

; E-0256 (C1: row 4 (Plant), band 3 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Plant_3::
Data_0A0_6F2A:: ; address name
    db $07 ; entry 0
    dw $0094 ; AmberWeed
    dw $0099 ; TreeBoy
    dw $009A ; Devipine
    dw $009D ; BeanMan
    dw $009E ; EvilSeed
    dw $009F ; ManEater
    dw $00A7 ; FooHero

; E-0256 (C1: row 4 (Plant), band 4 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Plant_4::
Data_0A0_6F39:: ; address name
    db $02 ; entry 0
    dw $00A0 ; Snapper
    dw $00A1 ; GhosTree

; E-0256 (C1: row 4 (Plant), band 5 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Plant_5::
Data_0A0_6F3E:: ; address name
    db $02 ; entry 0
    dw $009B ; FaceTree
    dw $009C ; HerbMan

; E-0256 (C1: row 4 (Plant), band 6 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Plant_6::
Data_0A0_6F43:: ; address name
    db $01 ; entry 0
    dw $00A2 ; Rosevine

; E-0256 (C1: row 4 (Plant), band 7 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Plant_7::
Data_0A0_6F46:: ; address name
    db $03 ; entry 0
    dw $00A3 ; Egdracil
    dw $00A4 ; Warubou
    dw $00A5 ; Watabou

; E-0256 (C1: row 5 (Bug), band 0 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Bug_0::
Data_0A0_6F4D:: ; address name
    db $04 ; entry 0
    dw $00B0 ; GiantSlug
    dw $00B5 ; GiantWorm
    dw $00B9 ; ArmyAnt
    dw $00BB ; TailEater

; E-0256 (C1: row 5 (Bug), band 1 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Bug_1::
Data_0A0_6F56:: ; address name
    db $03 ; entry 0
    dw $00B2 ; Gophecada
    dw $00B3 ; Butterfly
    dw $00BA ; GoHopper

; E-0256 (C1: row 5 (Bug), band 2 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Bug_2::
Data_0A0_6F5D:: ; address name
    db $05 ; entry 0
    dw $00B6 ; Lipsy
    dw $00B7 ; StagBug
    dw $00B8 ; Pyuro
    dw $00BD ; Eyeder
    dw $00C2 ; Belzebub

; E-0256 (C1: row 5 (Bug), band 3 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Bug_3::
Data_0A0_6F68:: ; address name
    db $07 ; entry 0
    dw $00B1 ; Catapila
    dw $00B4 ; WeedBug
    dw $00BC ; ArmorPede
    dw $00BE ; GiantMoth
    dw $00BF ; Droll
    dw $00C1 ; MadHornet
    dw $00C9 ; MultiEyes

; E-0256 (C1: row 5 (Bug), band 4 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Bug_4::
Data_0A0_6F77:: ; address name
    db $02 ; entry 0
    dw $00C0 ; ArmyCrab
    dw $00C5 ; Sickler

; E-0256 (C1: row 5 (Bug), band 5 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Bug_5::
Data_0A0_6F7C:: ; address name
    db $03 ; entry 0
    dw $00C3 ; WarMantis
    dw $00C4 ; HornBeet
    dw $00C7 ; Digster

; E-0256 (C1: row 5 (Bug), band 6 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Bug_6::
Data_0A0_6F83:: ; address name
    db $01 ; entry 0
    dw $00C6 ; Armorpion

; E-0256 (C1: row 5 (Bug), band 7 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Bug_7::
Data_0A0_6F86:: ; address name
    db $01 ; entry 0
    dw $00C8 ; Skularach

; E-0256 (C1: row 6 (Demon), band 0 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Demon_0::
Data_0A0_6F89:: ; address name
    db $02 ; entry 0
    dw $00D3 ; Pixy
    dw $00D6 ; Demonite

; E-0256 (C1: row 6 (Demon), band 1 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Demon_1::
Data_0A0_6F8E:: ; address name
    db $02 ; entry 0
    dw $00DC ; 1EyeClown
    dw $00DD ; Gremlin

; E-0256 (C1: row 6 (Demon), band 2 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Demon_2::
Data_0A0_6F93:: ; address name
    db $03 ; entry 0
    dw $00D4 ; MedusaEye
    dw $00D8 ; EyeBall
    dw $00E1 ; Orc

; E-0256 (C1: row 6 (Demon), band 3 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Demon_3::
Data_0A0_6F9A:: ; address name
    db $04 ; entry 0
    dw $00D7 ; DarkEye
    dw $00D9 ; SkulRider
    dw $00EA ; Gigantes
    dw $00EC ; EvilArmor

; E-0256 (C1: row 6 (Demon), band 4 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Demon_4::
Data_0A0_6FA3:: ; address name
    db $06 ; entry 0
    dw $00D5 ; AgDevil
    dw $00DA ; EvilBeast
    dw $00DB ; Bubblemon
    dw $00DF ; Lionex
    dw $00E2 ; Ogre
    dw $00E8 ; MadKnight

; E-0256 (C1: row 6 (Demon), band 5 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Demon_5::
Data_0A0_6FB0:: ; address name
    db $08 ; entry 0
    dw $00DE ; ArcDemon
    dw $00E0 ; GoatHorn
    dw $00E3 ; GateGuard
    dw $00E4 ; ChopClown
    dw $00E5 ; BossTroll
    dw $00E6 ; Grendal
    dw $00E9 ; EvilWell
    dw $00EB ; Centasaur

; E-0256 (C1: row 6 (Demon), band 6 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Demon_6::
Data_0A0_6FC1:: ; address name
    db $04 ; entry 0
    dw $00E7 ; Akubar
    dw $00ED ; Jamirus
    dw $00EE ; Durran
    dw $00F0 ; LampGenie

; E-0256 (C1: row 6 (Demon), band 7 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Demon_7::
Data_0A0_6FCA:: ; address name
    db $01 ; entry 0
    dw $00EF ; Titanis

; E-0256 (C1: row 7 (Zombie), band 0 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Zombie_0::
Data_0A0_6FCD:: ; address name
    db $01 ; entry 0
    dw $00F6 ; Spooky

; E-0256 (C1: row 7 (Zombie), band 1 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Zombie_1::
Data_0A0_6FD0:: ; address name
    db $04 ; entry 0
    dw $00F9 ; RotRaven
    dw $0100 ; Mudron
    dw $0104 ; Inverzon
    dw $0105 ; FoxFire

; E-0256 (C1: row 7 (Zombie), band 2 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Zombie_2::
Data_0A0_6FD9:: ; address name
    db $08 ; entry 0
    dw $00F8 ; PutrePup
    dw $00FA ; Mummy
    dw $00FD ; Shadow
    dw $00FE ; Skulpent
    dw $00FF ; Hork
    dw $0101 ; NiteWhip
    dw $0102 ; WindMerge
    dw $010F ; PomPomBom

; E-0256 (C1: row 7 (Zombie), band 3 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Zombie_3::
Data_0A0_6FEA:: ; address name
    db $06 ; entry 0
    dw $00FB ; DarkCrab
    dw $00FC ; DeadNite
    dw $0103 ; Reaper
    dw $0106 ; CaptDead
    dw $0109 ; BoneSlave
    dw $010E ; MadSpirit

; E-0256 (C1: row 7 (Zombie), band 4 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Zombie_4::
Data_0A0_6FF7:: ; address name
    db $01 ; entry 0
    dw $010A ; Skeletor

; E-0256 (C1: row 7 (Zombie), band 5 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Zombie_5::
Data_0A0_6FFA:: ; address name
    db $02 ; entry 0
    dw $00F7 ; Skullgon
    dw $010B ; Servant

; E-0256 (C1: row 7 (Zombie), band 6 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Zombie_6::
Data_0A0_6FFF:: ; address name
    db $04 ; entry 0
    dw $0107 ; DeadNoble
    dw $0108 ; WhiteKing
    dw $010D ; Copycat
    dw $0110 ; Niterich

; E-0256 (C1: row 7 (Zombie), band 7 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Zombie_7::
Data_0A0_7008:: ; address name
    db $01 ; entry 0
    dw $010C ; Lazamanus

; E-0256 (C1: row 8 (Material), band 0 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Material_0::
Data_0A0_700B:: ; address name
    db $05 ; entry 0
    dw $011B ; MadCandle
    dw $011D ; Facer
    dw $011E ; SpikyBoy
    dw $0122 ; Goopi
    dw $0131 ; MudDoll

; E-0256 (C1: row 8 (Material), band 1 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Material_1::
Data_0A0_7016:: ; address name
    db $04 ; entry 0
    dw $0119 ; JewelBag
    dw $011C ; CoilBird
    dw $0128 ; Brushead
    dw $0137 ; ProtoMech

; E-0256 (C1: row 8 (Material), band 2 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Material_2::
Data_0A0_701F:: ; address name
    db $03 ; entry 0
    dw $011A ; EvilWand
    dw $0121 ; Puppetor
    dw $0127 ; CurseLamp

; E-0256 (C1: row 8 (Material), band 3 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Material_3::
Data_0A0_7026:: ; address name
    db $08 ; entry 0
    dw $011F ; MadMirror
    dw $0120 ; RogueNite
    dw $0123 ; Voodoll
    dw $0126 ; SabreMan
    dw $012B ; EvilPot
    dw $012C ; Gismo
    dw $0130 ; Exaucers
    dw $0138 ; CloudKing

; E-0256 (C1: row 8 (Material), band 4 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Material_4::
Data_0A0_7037:: ; address name
    db $06 ; entry 0
    dw $0124 ; MetalDrak
    dw $0129 ; Roboster
    dw $012F ; Mimic
    dw $0132 ; Golem
    dw $0133 ; StoneMan
    dw $0134 ; BombCrag

; E-0256 (C1: row 8 (Material), band 5 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Material_5::
Data_0A0_7044:: ; address name
    db $04 ; entry 0
    dw $0125 ; Balzak
    dw $012A ; Roboster2
    dw $012D ; LavaMan
    dw $012E ; IceMan

; E-0256 (C1: row 8 (Material), band 6 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Material_6::
Data_0A0_704D:: ; address name
    db $01 ; entry 0
    dw $0135 ; GoldGolem

; E-0256 (C1: row 8 (Material), band 7 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Material_7::
Data_0A0_7050:: ; address name
    db $01 ; entry 0
    dw $0136 ; DarkMate

; E-0256 (C1: row 9 (Water), band 0 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Water_0::
Data_0A0_7053:: ; address name
    db $03 ; entry 0
    dw $013C ; Petiteel
    dw $013D ; Moray
    dw $0144 ; PutreFish

; E-0256 (C1: row 9 (Water), band 1 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Water_1::
Data_0A0_705A:: ; address name
    db $04 ; entry 0
    dw $0143 ; Octokid
    dw $0149 ; Gamanian
    dw $014D ; Scallopa
    dw $015B ; Starfish

; E-0256 (C1: row 9 (Water), band 2 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Water_2::
Data_0A0_7063:: ; address name
    db $05 ; entry 0
    dw $0140 ; Anemon
    dw $0141 ; Aquarella
    dw $0145 ; Octoreach
    dw $014C ; RogueWave
    dw $015A ; Pumpoise

; E-0256 (C1: row 9 (Water), band 3 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Water_3::
Data_0A0_706E:: ; address name
    db $06 ; entry 0
    dw $013E ; WalrusMan
    dw $013F ; RayGigas
    dw $0142 ; Merman
    dw $0146 ; Angleron
    dw $0147 ; FishRider
    dw $014A ; Clawster

; E-0256 (C1: row 9 (Water), band 4 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Water_4::
Data_0A0_707B:: ; address name
    db $05 ; entry 0
    dw $0148 ; RushFish
    dw $014B ; CancerMan
    dw $014E ; SeaHorse
    dw $014F ; HoodSquid
    dw $0150 ; MerTiger

; E-0256 (C1: row 9 (Water), band 5 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Water_5::
Data_0A0_7086:: ; address name
    db $05 ; entry 0
    dw $0151 ; AxeShark
    dw $0152 ; Octogon
    dw $0154 ; Digong
    dw $0155 ; WhaleMage
    dw $0157 ; Octoraid

; E-0256 (C1: row 9 (Water), band 6 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Water_6::
Data_0A0_7091:: ; address name
    db $03 ; entry 0
    dw $0153 ; KingSquid
    dw $0156 ; Aquadon
    dw $0158 ; Grakos

; E-0256 (C1: row 9 (Water), band 7 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Water_7::
Data_0A0_7098:: ; address name
    db $01 ; entry 0
    dw $0159 ; Poseidon

; E-0256 (C1: row 10 (Boss), band 0 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Boss_0::
Data_0A0_709B:: ; address name
    db $06 ; entry 0
    dw $015F ; DracoLord
    dw $0162 ; Hargon
    dw $0165 ; Baramos
    dw $016A ; Esterk
    dw $016B ; Mirudraas
    dw $016D ; Mudou

; E-0256 (C1: row 10 (Boss), band 1 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Boss_1::
Data_0A0_70A8:: ; address name
    db $06 ; entry 0
    dw $015F ; DracoLord
    dw $0162 ; Hargon
    dw $0165 ; Baramos
    dw $016A ; Esterk
    dw $016B ; Mirudraas
    dw $016D ; Mudou

; E-0256 (C1: row 10 (Boss), band 2 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Boss_2::
Data_0A0_70B5:: ; address name
    db $06 ; entry 0
    dw $015F ; DracoLord
    dw $0162 ; Hargon
    dw $0165 ; Baramos
    dw $016A ; Esterk
    dw $016B ; Mirudraas
    dw $016D ; Mudou

; E-0256 (C1: row 10 (Boss), band 3 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Boss_3::
Data_0A0_70C2:: ; address name
    db $06 ; entry 0
    dw $015F ; DracoLord
    dw $0162 ; Hargon
    dw $0165 ; Baramos
    dw $016A ; Esterk
    dw $016B ; Mirudraas
    dw $016D ; Mudou

; E-0256 (C1: row 10 (Boss), band 4 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Boss_4::
Data_0A0_70CF:: ; address name
    db $06 ; entry 0
    dw $015F ; DracoLord
    dw $0162 ; Hargon
    dw $0165 ; Baramos
    dw $016A ; Esterk
    dw $016B ; Mirudraas
    dw $016D ; Mudou

; E-0256 (C1: row 10 (Boss), band 5 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Boss_5::
Data_0A0_70DC:: ; address name
    db $06 ; entry 0
    dw $015F ; DracoLord
    dw $0162 ; Hargon
    dw $0165 ; Baramos
    dw $016A ; Esterk
    dw $016B ; Mirudraas
    dw $016D ; Mudou
    db $06

; E-0256 (C1: row 10 (Boss), band 6 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Boss_6::
Data_0A0_70EA:: ; address name
    db $06 ; entry 0
    dw $015F ; DracoLord
    dw $0162 ; Hargon
    dw $0165 ; Baramos
    dw $016A ; Esterk
    dw $016B ; Mirudraas
    dw $016D ; Mudou

; E-0256 (C1: row 10 (Boss), band 7 of EncounterBandSpeciesTable).
; record: count; species
EncounterBandSpecies_Boss_7::
Data_0A0_70F7:: ; address name
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
    ds $EE8, $00
