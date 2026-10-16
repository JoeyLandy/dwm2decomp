; ROM bank $A1: the world map and game-mode helpers
; The annotated listing of this bank is build/listing/banka1.asm.

SECTION "Bank A1", ROMX[$4000], BANK[$A1]
    db $a1

; A = a battle slot: HL = wBattleATK, then GetBattleStatWord_BankA1: HL = the word of that slot at
; wBattleATK + 2 * A (the value, not a pointer) and A = its low byte. GetBattleDEF_BankA1,
; GetBattleMaxHP_BankA1, GetBattleMaxMP_BankA1, GetBattleHP_BankA1 and GetBattleMP_BankA1 do the
; same for wBattleDEF, wBattleMaxHP, wBattleMaxMP, wBattleHP and wBattleMP. This bank holds a copy
; of the shared block of battle helper routines; no call to this copy was found in the source. (C2,
; E-0385)
; A = battle slot: HL = the word for that slot at wBattleATK; A = its low byte (E-0064)
GetBattleATK_BankA1::
    ld hl, wBattleATK
    jr GetBattleStatWord_BankA1

; HL = wBattleDEF, then the slot's word (GetBattleStatWord_BankA1). (C2, E-0357; probed E-0385)
GetBattleDEF_BankA1::
    ld hl, wBattleDEF
    jr GetBattleStatWord_BankA1

; HL = wBattleMaxHP, then the slot's word (GetBattleStatWord_BankA1). (C2, E-0357; probed E-0385)
GetBattleMaxHP_BankA1::
    ld hl, wBattleMaxHP
    jr GetBattleStatWord_BankA1

; HL = wBattleMaxMP, then the slot's word (GetBattleStatWord_BankA1). (C2, E-0357; probed E-0385)
GetBattleMaxMP_BankA1::
    ld hl, wBattleMaxMP
    jr GetBattleStatWord_BankA1

; HL = wBattleHP, then the slot's word (GetBattleStatWord_BankA1). (C2, E-0357; probed E-0385)
GetBattleHP_BankA1::
    ld hl, wBattleHP
    jr GetBattleStatWord_BankA1

; HL = wBattleMP, then the slot's word (GetBattleStatWord_BankA1). (C2, E-0357; probed E-0385)
GetBattleMP_BankA1::
    ld hl, wBattleMP
    jr GetBattleStatWord_BankA1
    db $21, $1f, $d9, $18, $0a, $21, $53, $da, $85, $6f, $30, $01, $24, $7e, $c9

; HL = the word at HL + 2 x slot A (the value, not a pointer). (C2, E-0357; probed E-0385)
GetBattleStatWord_BankA1::
    add a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A, with A doubled in 8 bits first (an A of $80 or more wraps); A is clobbered. This bank
; holds a copy of the shared block of battle helper routines; no call to this copy was found in the
; source. (C2, E-0385)
; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes
; appear in 12 banks)
AddDoubleAToHL_BankA1::
    add a
    add_a_to_hl
    ret

; Carry set when wBattleActor is below 4 (slots 0-3), clear otherwise; but when wLinkMode is 1 and
; wLinkRole bit 1 is set the test is reversed (carry set for 4 or more). A is clobbered. This bank
; holds a copy of the shared block of battle helper routines; no call to this copy was found in the
; source. (C2, E-0385)
; carry set when wBattleActor < 4 (slots 0-3); when wLinkMode = 1 and wLinkRole bit 1 is set the
; test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the
; reversal, not checked (E-0064) (the same 27 bytes appear in 12 banks)
ActorOnLocalSide_BankA1::
    ld a, [wLinkMode]
    cp $01
    jr nz, .check_battle_actor
    ld a, [wLinkRole]
    bit 1, a
    jr z, .check_battle_actor
    ld a, [wBattleActor]
    cp $04
    ccf
    ret

.check_battle_actor:
    ld a, [wBattleActor]
    cp $04
    ret

; Carry set when wBattleTarget is below 4, clear otherwise; but when wLinkMode is 1 and wLinkRole
; bit 1 is set the test is reversed (carry set for 4 or more). A is clobbered. This bank holds a
; copy of the shared block of battle helper routines; no call to this copy was found in the source.
; (C2, E-0385)
; carry set when wBattleTarget < 4 (slots 0-3); when wLinkMode = 1 and wLinkRole bit 1 is set the
; test is reversed (carry set when wBattleTarget >= 4) (E-0064) (the same 27 bytes appear in 12
; banks)
TargetOnLocalSide_BankA1::
    ld a, [wLinkMode]
    cp $01
    jr nz, .check_battle_target
    ld a, [wLinkRole]
    bit 1, a
    jr z, .check_battle_target
    ld a, [wBattleTarget]
    cp $04
    ccf
    ret

.check_battle_target:
    ld a, [wBattleTarget]
    cp $04
    ret

; D = an index 0-6, E = a slot: ANDs the byte at wBattleStatus + 9 * E (status byte 0 of the slot)
; with ClearBitMaskTable_BankA1[D] ($DF, $FE, $00, $FD, $73, $EF, $BF). A, D, HL are clobbered. Not
; reached from the traced code (a configured code entry); no caller was found in the source. (C2,
; E-0385)
; wBattleStatus + 9 * E &= ClearBitMaskTable_BankA1[D] (AddAx9ToHL); not reached from traced code
; (E-0205)
ClearBattleStatusBitsWithMaskD_BankA1:: ; configured code entry (E-0205); C0
    ld a, d
    ld hl, ClearBitMaskTable_BankA1
    add_a_to_hl
    ld d, [hl]
    ld a, e
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, d
    and [hl]
    ld [hl], a
    ret

; the routine at $4075 reads the byte at $408A + D and ANDs it into the byte at wBattleStatus + 9 *
; E (AddAx9ToHL); the same 202-byte block of routines and this table sit at $4075-$413F in banks
; $05, $A1 and $A3 (E-0205, C1)
; record: AND mask
ClearBitMaskTable_BankA1::
    db $df ; id 0
    db $fe ; id 1
    db $00 ; id 2
    db $fd ; id 3
    db $73 ; id 4
    db $ef ; id 5
    db $bf ; id 6

; A = an index: sets bit 0 of the byte at wLevelUpGains + A. HL is kept; A is clobbered. This bank
; holds a copy of the shared block of battle helper routines; no call to this copy was found in the
; source. (C2, E-0385)
; Sets bit 0 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit0OfLevelUpGainsIndexed_BankA1:: ; configured code entry (E-0205); C0
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; A = an index: sets bit 1 of the byte at wLevelUpGains + A. HL is kept; A is clobbered. This bank
; holds a copy of the shared block of battle helper routines; no call to this copy was found in the
; source. (C2, E-0385)
; Sets bit 1 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit1OfLevelUpGainsIndexed_BankA1:: ; configured code entry (E-0205); C0
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; A = an index: sets bit 2 of the byte at wLevelUpGains + A. HL is kept; A is clobbered. This bank
; holds a copy of the shared block of battle helper routines; no call to this copy was found in the
; source. (C2, E-0385)
; Sets bit 2 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit2OfLevelUpGainsIndexed_BankA1:: ; configured code entry (E-0205); C0
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 2, [hl]
    pop hl
    ret

; A = a slot 0-7: returns A = 9 * g(wSlotPersonalityHi[slot]) + 3 * g(wSlotPersonalityMid[slot]) +
; g(wSlotPersonalityLo[slot]), where g(v) = 0 for $C0 or more, 1 for $40 to $BF and 2 below $40 (so
; 0-26). BC and HL are kept. This bank holds a copy of the shared block of battle helper routines;
; no call to this copy was found in the source. (C2, E-0385)
; A = slot 0-7: returns A = 9 * g(wSlotPersonalityHi[A]) + 3 * g(wSlotPersonalityMid[A]) +
; g(wSlotPersonalityLo[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index
; PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes
; appear in 13 banks)
PersonalityIndexOfSlot_BankA1:: ; configured code entry (E-0205); C0
    push hl
    push bc
    ld c, a
    ld b, $00
    ld hl, wSlotPersonalityHi
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp $c0
    jr nc, .skip
    ld l, $09
    cp $40
    jr nc, .skip
    ld l, $12

.skip:
    ld a, l
    add b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityMid
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp $c0
    jr nc, .skip2
    ld l, $03
    cp $40
    jr nc, .skip2
    ld l, $06

.skip2:
    ld a, l
    add b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityLo
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp $c0
    jr nc, .skip3
    ld l, $01
    cp $40
    jr nc, .skip3
    ld l, $02

.skip3:
    ld a, l
    add b
    pop bc
    pop hl
    ret

; A = a slot: carry set when CheckSlotStatusBlock sets it (the slot is out, or a status bit it tests
; is set), or when bits 6-7 of status byte 3 or bits 2-3 of status byte 4 (wBattleStatus3 + 9 * A)
; are set; otherwise carry clear. A, BC, HL are kept. This bank holds a copy of the shared block of
; battle helper routines; no call to this copy was found in the source. (C2, E-0385)
; A = slot: carry set when CheckSlotStatusBlock sets it, or when status byte 3 & $C0 or byte 4 & $0C
; is set (wBattleStatus3 + 9 * A); otherwise carry clear; A, BC, HL kept (E-0067) (the same 31 bytes
; appear in 12 banks)
CheckSlotStatusBlockWide_BankA1:: ; configured code entry (E-0205); C0
    call CheckSlotStatusBlock
    ret c
    push hl
    push bc
    ld c, a
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hli]
    and $c0
    jr nz, .set_carry
    ld a, [hl]
    and $0c
    jr nz, .set_carry
    xor a
    jr .skip

.set_carry:
    scf

.skip:
    ld a, c
    pop bc
    pop hl
    ret

; A = a slot: A = status byte 3 of the slot (wBattleStatus3 + 9 * A) and $C0, or when that is 0
; status byte 4 and $0C; Z is set when both are clear. HL is kept. This bank holds a copy of the
; shared block of battle helper routines; no call to this copy was found in the source. (C2, E-0385)
; A = slot: with HL = wBattleStatus3 + 9 * A (status byte 3 of wBattleStatus), A = byte 3 & $C0, or
; byte 4 & $0C when that is zero; Z set when both are clear; HL kept (E-0067) (the same 17 bytes
; appear in 13 banks)
SlotHasStatus3Or4Bits_BankA1:: ; configured code entry (E-0205); C0
    push hl
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hli]
    and $c0
    jr nz, .done
    ld a, [hl]
    and $0c

.done:
    pop hl
    ret

; The command entry of the turn of game mode 7 (battle step 2;
; RunBattlePhaseWhenTextIdle_A0_RunTurn_Commands far-calls it every frame), a variant of
; RunBattleCommandEntry (bank $30) whose step 0 marks the enemy slots. Returns while text is shown
; (wTextFlags not 0); otherwise jumps by wBattleSubPhase to 0
; RunBattleCommandEntry_BankA1_MarkEnemySlots, 1 RunBattleCommandEntry_BankA1_NextActor, 2
; RunBattleCommandEntry_BankA1_ChooseAIAction, 3 RunBattleCommandEntry_BankA1_ChooseTarget, 4
; RunBattleCommandEntry_BankA1_ListSpeeds, 5 RunBattleCommandEntry_BankA1_SortBySpeed and 6
; RunBattleCommandEntry_BankA1_TotalHP. (C1, E-0385)
; a variant of RunBattleCommandEntry (bank $30) with the same seven steps, but step 0 marks the
; enemy slots 4-7 instead of choosing the command-entry monster, the second random stream always
; advances, step 3 uses ChooseActionTarget, step 4 lists no item entry, and a skill's speed bonus is
; 2,000 instead of 1,000 (E-0363; corrects E-0107, which called the two the same instruction
; sequence)
RunBattleCommandEntry_BankA1::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, [wBattleSubPhase]
    jumptable
    dw RunBattleCommandEntry_BankA1_MarkEnemySlots
    dw RunBattleCommandEntry_BankA1_NextActor
    dw RunBattleCommandEntry_BankA1_ChooseAIAction
    dw RunBattleCommandEntry_BankA1_ChooseTarget
    dw RunBattleCommandEntry_BankA1_ListSpeeds
    dw RunBattleCommandEntry_BankA1_SortBySpeed
    dw RunBattleCommandEntry_BankA1_TotalHP

; Turn order, step 0: clears wLinkSendByte and wBattleActor, then marks the three slots 4, 5 and 6
; (not 7) in wSlotMarks: $FF stays $FF, $FE and $FD become 3, any other mark becomes 3 for an absent
; slot and 1 for a present one (CarryUnlessBattleSlotOutSlotEmpty); adds 1 to wBattleSubPhase. (C2,
; E-0385)
RunBattleCommandEntry_BankA1_MarkEnemySlots::
    xor a
    ld [wLinkSendByte], a
    xor a
    ld [wBattleActor], a
    ld bc, $0304
    ld hl, wSlotMarks + $4

.loop:
    ld a, [hl]
    ld e, $ff
    cp $ff
    jr z, .skip
    ld e, $03
    cp $fe
    jr z, .skip
    cp $fd
    jr z, .skip
    ld e, $03
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    ld e, $01

.skip:
    ld [hl], e
    inc hl
    inc c
    dec b
    jr nz, .loop
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; Turn order, step 1, run every frame: advances the second random stream
; (NextTableByteSecondStream). With wBattleActor = 8 (past the last slot) adds 3 to wBattleSubPhase
; (on to step 4). Otherwise looks at the mark of wBattleActor in wSlotMarks: when it is 1 and the
; slot is present, wBattleActor stays, wBattleResolveStep is cleared and wBattleSubPhase moves on
; one step (the command entry of the computer, step 2); for any other slot only wBattleActor is
; increased by 1, so one slot is passed per call. (C2, E-0385)
RunBattleCommandEntry_BankA1_NextActor::
    call NextTableByteSecondStream
    ld a, [wBattleActor]
    cp $08
    jr z, .skip
    ld e, a
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    cp $01
    jr z, .call_carry_unless_battle_slot_out_slot_empty

.loop:
    inc e
    ld a, e
    ld [wBattleActor], a
    jr .return

.call_carry_unless_battle_slot_out_slot_empty:
    ld a, e
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .loop
    ld [wBattleActor], a
    ld hl, wBattleSubPhase
    inc [hl]
    xor a
    ld [wBattleResolveStep], a
    jr .return

.skip:
    ld hl, wBattleSubPhase
    inc [hl]
    inc [hl]
    inc [hl]

.return:
    ret

; Turn order, step 2: the computer's command entry for the slot (RunCommandEntryResolveStep). (C1,
; E-0357)
RunBattleCommandEntry_BankA1_ChooseAIAction::
    farcall RunCommandEntryResolveStep
    ret

; Turn order, step 3: chooses the action's target, marks the slot done (2) and returns to step 1
; with the next actor. (C1, E-0357)
RunBattleCommandEntry_BankA1_ChooseTarget::
    farcall ChooseActionTarget
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld d, [hl]
    ld a, [wBattleActor]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $02
    ld a, $01
    ld [wBattleSubPhase], a
    ld hl, wBattleActor
    inc [hl]
    ret

; Turn order, step 4: clears the action queue and the speed list, then for each present slot marked
; 2 works out a speed (RunBattleCommandEntry_BankA1_ListSpeeds_RollSpeed plus the action's bonus,
; AddActionSpeedBonus_BankA1) and lists it with the slot number; next step. (C2, E-0357; probed
; E-0385)
RunBattleCommandEntry_BankA1_ListSpeeds::
    ld hl, wActionQueue
    ld bc, $0009
    ld a, $ff
    call FillBytes
    ld hl, wBattleArg0
    ld bc, $0009
    ld a, $ff
    call FillBytes
    ld hl, wBattleTempBuf
    ld bc, $0012
    ld a, $00
    call FillBytes
    xor a
    ld [wActionQueuePos], a
    ld [wLoadSlot], a
    ld hl, wBattleTempBuf
    ld a, l
    ld [wBattleTempPtrLo], a
    ld a, h
    ld [wBattleTempPtrHi], a
    ld de, $0800

.loop:
    ld a, e
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, e
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    cp $02
    jr nz, .next
    ld a, e
    call RunBattleCommandEntry_BankA1_ListSpeeds_RollSpeed
    call AddActionSpeedBonus_BankA1
    ld hl, wBattleTempPtrLo
    deref_hl
    ld a, c
    ld [hli], a
    ld [hl], b
    ld a, [wLoadSlot]
    ld hl, wBattleArg0
    add_a_to_hl
    ld [hl], e
    ld hl, wLoadSlot
    inc [hl]
    ld hl, wBattleTempPtrLo
    inc [hl]
    ld hl, wBattleTempPtrLo
    inc [hl]

.next:
    inc e
    dec d
    jp nz, .loop
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; Turn order, step 5: sorts the listed slots by speed, fastest first (swapping neighbours, eight
; passes), and copies the order into wActionQueue; next step. (C2, E-0357; probed E-0385)
RunBattleCommandEntry_BankA1_SortBySpeed::
    ld d, $08

.loop:
    ld hl, wBattleTempBuf
    ld a, l
    ld [wBattleTempPtrLo], a
    ld a, h
    ld [wBattleTempPtrHi], a
    ld a, [hli]
    ld b, [hl]
    ld c, a
    ld hl, wBattleTempBuf + $2
    deref_hl
    ld e, $00

.call_compare_hl_to_bc:
    call CompareHLToBC
    jr c, .next
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ld a, c
    ld [wTargetEstimates], a
    ld a, b
    ld [wTargetEstimates + $1], a
    ld a, [wBattleTempPtrLo]
    ld l, a
    ld a, [wBattleTempPtrHi]
    ld h, a
    ld a, [wBattleDamageLo]
    ld [hli], a
    ld a, [wBattleDamageHi]
    ld [hli], a
    ld a, [wTargetEstimates]
    ld [hli], a
    ld a, [wTargetEstimates + $1]
    ld [hl], a
    ld a, e
    ld hl, wBattleArg0
    add_a_to_hl
    ld a, [hli]
    ld b, [hl]
    ld [hld], a
    ld [hl], b

.next:
    inc e
    ld a, e
    cp d
    jr z, .next2
    ld hl, wBattleTempPtrLo
    inc [hl]
    ld hl, wBattleTempPtrLo
    inc [hl]
    deref_hl
    ld a, [hli]
    ld b, [hl]
    ld c, a
    inc hl
    deref_hl
    jr .call_compare_hl_to_bc

.next2:
    dec d
    jr nz, .loop
    ld a, [wActionQueuePos]
    ld de, wActionQueue
    add e
    ld e, a
    jr nc, .read_action_queue_pos
    inc d

.read_action_queue_pos:
    ld a, [wActionQueuePos]
    ld hl, wBattleArg0
    ld b, $09

.loop2:
    ld a, [hli]
    cp $ff
    jr z, .set_action_queue_pos_to_00
    ld [de], a
    inc de
    dec b
    jr nz, .loop2

.set_action_queue_pos_to_00:
    ld a, $00
    ld [wActionQueuePos], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; Turn order, step 6: totals the HP and the max HP of slots 0-2 into wBattleCommandArgs, clears the
; resolve counters, saves the action choices (SaveActionChoicesAndPickFormations) and marks berserk
; actors (SetBerserkForAction6E_BankA1); next battle step. (C2, E-0357; probed E-0385)
RunBattleCommandEntry_BankA1_TotalHP::
    ld hl, wBattleHP
    ld bc, $0000
    call AddWordAtHLToBC_BankA1
    call AddWordAtHLToBC_BankA1
    call AddWordAtHLToBC_BankA1
    ld a, c
    ld [wBattleCommandArgs], a
    ld a, b
    ld [wBattleCommandArgs + $1], a
    ld hl, wBattleMaxHP
    ld bc, $0000
    call AddWordAtHLToBC_BankA1
    call AddWordAtHLToBC_BankA1
    call AddWordAtHLToBC_BankA1
    ld a, c
    ld [wBattleCommandArgs + $2], a
    ld a, b
    ld [wBattleCommandArgs + $3], a
    ld hl, wBattleStep
    inc [hl]
    xor a
    ld [wBattleSubPhase], a
    xor a
    ld hl, wBattleResolveStep
    ld bc, $0005
    call FillBytes
    farcall SaveActionChoicesAndPickFormations
    call SetBerserkForAction6E_BankA1
    ret

; BC += the word at HL (low byte first, 16-bit wrap); HL moves on 2 bytes; A is clobbered. Called
; six times by RunBattleCommandEntry_BankA1_TotalHP. (C2, E-0385)
; BC += the word at [HL]; HL += 2; clobbers A (the same 7 bytes appear in 2 banks)
AddWordAtHLToBC_BankA1::
    ld a, [hli]
    add c
    ld c, a
    ld a, [hli]
    adc b
    ld b, a
    ret

; Sets BSTAT6_BERSERK for every present slot whose chosen action is $6E. (C2, E-0357; probed E-0385)
SetBerserkForAction6E_BankA1::
    ld c, $00
    ld b, $08

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    add a
    ld hl, wBattleActionChoice
    add_a_to_hl
    ld a, [hl]
    cp $6e
    jr nz, .next
    ld a, c
    ld hl, wBattleStatus6
    call AddAx9ToHL
    set BSTAT6_BERSERK, [hl]

.next:
    inc c
    dec b
    jr nz, .loop
    ret

; BC = a random speed for slot E between 3/10 of its agility and its agility (second random stream).
; (C2, E-0357; probed E-0385)
RunBattleCommandEntry_BankA1_ListSpeeds_RollSpeed::
    push de
    call NextTableByteSecondStream
    ld a, e
    ld hl, wBattleAGL
    add a
    add_a_to_hl
    ld a, [hli]
    ld b, [hl]
    ld c, a
    push bc
    ld a, $03
    call Multiply8By16
    ld a, $0a
    call Divide24ByA
    pop bc
    call RandomInRange
    ld c, e
    ld b, d
    pop de
    ret

; Adds the action's speed bonus to BC: actions $62 and $D8 add 3,000 (they go first); a skill whose
; record byte 5 has bit 2 set adds 2,000, others 10; action $69 instead gives a random speed of 1 to
; 9 (random mod 9 + 1). (C2, E-0357; probed E-0385)
AddActionSpeedBonus_BankA1::
    push de
    ld a, e
    ld hl, wBattleActionChoice
    add a
    add_a_to_hl
    ld a, [hl]
    cp $62
    jr z, .skip
    cp $69
    jr z, .call_next_table_byte_second_stream
    cp $d8
    jr z, .skip
    push af
    push bc
    push de
    push hl
    ld [wRecordBuffer], a
    xor a
    ld [wRecordBuffer + $1], a
    ld a, [wBattleArg0]
    ld l, a
    ld a, [wBattleArg1]
    ld h, a
    push hl
    ld a, [wBattleArg2]
    ld l, a
    ld a, [wBattleArg3]
    ld h, a
    push hl
    ld a, $05
    ld [wBattleArg0], a
    ld a, $01
    ld [wBattleArg1], a
    ld hl, wRecordBufferData + $5
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    farcall LoadSkillRecordPart
    pop hl
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    pop hl
    ld a, l
    ld [wBattleArg0], a
    ld a, h
    ld [wBattleArg1], a
    pop hl
    pop de
    pop bc
    pop af
    ld a, [wRecordBufferData + $5]
    bit 2, a
    jr nz, .skip2
    ld hl, $000a
    jr .skip3

.skip:
    ld hl, $0bb8
    jr .skip3

.skip2:
    ld hl, $07d0
    jr .skip3

.call_next_table_byte_second_stream:
    call NextTableByteSecondStream
    ld a, [wRandomLo]
    ld b, a
    ld a, $09
    call DivideBByA
    add $01
    ld c, a
    ld b, $00
    jr .done

.skip3:
    add hl, bc
    ld c, l
    ld b, h

.done:
    pop de
    ret

; Does nothing unless wMapType is exactly $80 (a key world). Sets the bit of the screen
; (hMapScreenX, hMapScreenY) in the 8-byte map wVisitedScreens: byte 4 * (Y / 4) + 2 * (X / 4) + ((Y
; / 2) and 1), bit (X and 3) + 4 * (Y and 1). A, B, C, HL are clobbered. Called by
; RunFieldActionRequestActionIfBit7_ScrollScreen, WarpEffect_Warp and
; MarkVisitedScreens5x5AroundPlayer. (C2, E-0385)
; on map type $80 sets the bit for the current map screen in the visited-screen bitmap
; wVisitedScreens (E-0125)
MarkVisitedMapScreenInVisitedScreens::
    ld a, [wMapType]
    bit 7, a
    ret z
    cp $80
    ret nz
    ldh a, [hMapScreenY]
    and $fc
    ld hl, wVisitedScreens
    add_a_to_hl
    ldh a, [hMapScreenX]
    srl a
    and $fe
    add_a_to_hl
    ldh a, [hMapScreenY]
    bit 1, a
    jr z, .skip
    inc hl

.skip:
    ld c, $01
    bit 0, a
    jr z, .check_map_screen_x
    ld c, $10

.check_map_screen_x:
    ldh a, [hMapScreenX]
    and $03
    jr z, .skip2
    ld b, a

.loop:
    sla c
    dec b
    jr nz, .loop

.skip2:
    ld a, [hl]
    or c
    ld [hl], a
    ret

; Marks the current floor's exit screen (wKeyWorldAreaExits, second byte when wKeyWorldFloor bit 7)
; as visited: sets its bit in wVisitedScreens. (C2, E-0357; probed E-0385)
WarpEffect_Warp_MarkExitVisited::
    ld hl, wKeyWorldAreaExits
    ld a, [wKeyWorldFloor]
    bit 7, a
    jr z, .skip
    inc hl

.skip:
    and $0f
    add a
    add a
    add_a_to_hl
    ld a, [hl]
    push af
    and $0f
    and $fc
    ld hl, wVisitedScreens
    add_a_to_hl
    pop af
    push af
    swap a
    and $0f
    srl a
    and $fe
    add_a_to_hl
    pop af
    push af
    and $0f
    bit 1, a
    jr z, .skip2
    inc hl

.skip2:
    ld c, $01
    bit 0, a
    jr z, .restore
    ld c, $10

.restore:
    pop af
    swap a
    and $0f
    and $03
    jr z, .skip3
    ld b, a

.loop:
    sla c
    dec b
    jr nz, .loop

.skip3:
    ld a, [hl]
    or c
    ld [hl], a
    ret

; Marks the screens within 2 of (hMapScreenX, hMapScreenY) that lie inside wKeyWorldWidth x
; wKeyWorldHeight as visited (MarkVisitedMapScreenInVisitedScreens for each, so only in a key world
; of wMapType $80). hMapScreenX and hMapScreenY are restored; hTemp0 and hTemp1 are left holding the
; original X and Y. Called by FieldSkillEffect_MapAroundPlayer. (C2, E-0385)
; marks the 5 x 5 map screens around the current one (within wKeyWorldWidth x wKeyWorldHeight) as
; visited (E-0127)
MarkVisitedScreens5x5AroundPlayer::
    ldh a, [hMapScreenX]
    ldh [hTemp0], a
    dec a
    dec a
    ldh [hMapScreenX], a
    ldh a, [hMapScreenY]
    ldh [hTemp1], a
    dec a
    dec a
    ldh [hMapScreenY], a
    ld c, $05

.loop:
    ld b, $05

.loop2:
    ld a, [wKeyWorldHeight]
    ld d, a
    ldh a, [hMapScreenY]
    bit 7, a
    jr nz, .read_temp0
    cp d
    jr nc, .read_temp0
    ld a, [wKeyWorldWidth]
    ld d, a
    ldh a, [hMapScreenX]
    bit 7, a
    jr nz, .skip
    cp d
    jr nc, .skip
    push bc
    call MarkVisitedMapScreenInVisitedScreens
    pop bc

.skip:
    ld hl, hMapScreenX
    inc [hl]
    dec b
    jr nz, .loop2

.read_temp0:
    ldh a, [hTemp0]
    sub $02
    ldh [hMapScreenX], a
    ld hl, hMapScreenY
    inc [hl]
    dec c
    jr nz, .loop
    ldh a, [hTemp0]
    ldh [hMapScreenX], a
    ldh a, [hTemp1]
    ldh [hMapScreenY], a
    ret

; Field state 8, the world map: FieldState_WorldMap far-calls it every frame. Jumps by
; wWorldMapState and 7 to RunWorldMapState_BlankPalettes (0 and 3), RunWorldMapState_DrawOverview
; (1), RunWorldMapState_OverviewInput (2), RunWorldMapState_DrawCloseUp (4),
; RunWorldMapState_CloseUpInput (5) and RunWorldMapState_ReturnToField (6); state 7 has no entry.
; TryOpenWorldMap starts it at state 0 (the overview) or 3 (the close-up). (C1, E-0385)
; the world map screen (field state 8): by wWorldMapState & 7 it uploads the palettes, loads the map
; graphics and tiles, shows the region, and returns to the field (EnterGameMode1WithDefaultPalettes)
; (E-0354; was: runs the routine for wWorldMapState & 7 (field mode state 8; jump table, 3 reuses 0)
; (E-0122) (the world map, C2 from E-0339; was RunWorldMapState))
RunWorldMapState::
    ld a, [wWorldMapState]
    and $07
    jumptable
    dw RunWorldMapState_BlankPalettes
    dw RunWorldMapState_DrawOverview
    dw RunWorldMapState_OverviewInput
    dw RunWorldMapState_BlankPalettes
    dw RunWorldMapState_DrawCloseUp
    dw RunWorldMapState_CloseUpInput
    dw RunWorldMapState_ReturnToField

; World map, step 4 (the close-up): loads the tiles, fills the map with tile $57 (attributes cleared
; on CGB), draws the visited screens (key world or region), sets the palettes; next step. (C1,
; E-0357)
RunWorldMapState_DrawCloseUp::
    xor a
    ldh [hScrollX], a
    ldh [hScrollY], a
    call CopyScrollToHardware
    ld de, Tiles0Gfx_2
    ld b, $7e
    ld hl, vTiles0
    call DecompressToVRAM
    ld de, Tiles0Plus100Gfx_2
    ld b, $7e
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld de, Tiles0Plus200Gfx
    ld b, $7e
    ld hl, vTiles0 + $200
    call DecompressToVRAM
    ld de, WorldMapCloseUpTerrainTiles
    ld b, $5d
    ld hl, vTiles2
    call DecompressToVRAM
    call FillBGMap0With57
    call RunWorldMapState_DrawCloseUp_ClearAttributes
    ld a, [wMapType]
    bit 7, a
    jr nz, .call_run_world_map_state_draw_close_up_key
    call RunWorldMapState_DrawCloseUp_Region
    jr .skip

.call_run_world_map_state_draw_close_up_key:
    call RunWorldMapState_DrawCloseUp_KeyWorld

.skip:
    ld hl, wDMGPaletteBGP
    ld a, $d2
    ld [hli], a
    ld a, $d2
    ld [hli], a
    ld a, $e2
    ld [hl], a
    ld a, [wIsCGB]
    or a
    jr z, .done
    ld a, $40
    ld de, SharedOBJPalettes
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld b, $7e
    ld hl, wOBJPaletteBuffer
    ld c, $08
    call CopyFromBank
    ld de, OBJPaletteBufferPlus8Data_3
    ld b, $7e
    ld hl, wOBJPaletteBuffer + $8
    ld c, $10
    call CopyFromBank
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ld de, RunWorldMapState_DrawCloseUp_BGPaletteBufferData
    ld b, $5d
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBank
    ld a, $7f
    ld [wBGPaletteUploadRequest], a

.done:
    ld hl, wWorldMapState
    inc [hl]
    ret

; Draws the key world's close-up: each map screen is a 5 x 5 tile block, centred on the player's
; screen; only screens inside the world and visited are drawn (RunWorldMapState_DrawCloseUpCell).
; (C1, E-0357)
RunWorldMapState_DrawCloseUp_KeyWorld::
    call RunWorldMapState_DrawCloseUp_CenterKeyWorld
    call StoreTemp5ValuesToCursorCellX
    ld hl, vBGMap0
    ld c, $12

.loop:
    push hl
    ldh a, [hTemp5]
    ldh [hTemp9], a
    ldh a, [hTemp7]
    ldh [hTempA], a
    ld b, $14

.loop2:
    push bc
    push hl
    ldh a, [hTempA]
    bit 7, a
    jr nz, .check_temp9
    ld c, a
    ldh a, [hTemp3]
    dec a
    cp c
    jr c, .check_temp9
    ldh a, [hTemp8]
    bit 7, a
    jr nz, .check_temp9
    ld c, a
    ldh a, [hTemp4]
    dec a
    cp c
    jr c, .check_temp9
    push bc
    ldh a, [hTempA]
    and $0f
    swap a
    ld c, a
    ldh a, [hTemp8]
    and $0f
    or c
    pop bc
    push de
    call IsMapScreenAVisited
    pop de
    or a
    jr z, .check_temp9
    call RunWorldMapState_DrawCloseUpCell

.check_temp9:
    ldh a, [hTemp9]
    inc a
    cp $05
    jr nz, .set_temp9
    ldh a, [hTempA]
    inc a
    ldh [hTempA], a
    xor a

.set_temp9:
    ldh [hTemp9], a
    pop hl
    inc hl
    pop bc
    dec b
    jr nz, .loop2
    ldh a, [hTemp6]
    inc a
    cp $05
    jr nz, .set_temp6
    ldh a, [hTemp8]
    inc a
    ldh [hTemp8], a
    xor a

.set_temp6:
    ldh [hTemp6], a
    pop hl
    ld a, $20
    add_a_to_hl
    dec c
    jr nz, .loop
    ret

; Draws the tile for close-up cell (hTemp9, hTemp6) of key-world screen (hTempA, hTemp8), read
; through the world's chunk list (wKeyWorldChunks) from the chunk's ROM data. (C1, E-0357)
RunWorldMapState_DrawCloseUpCell::
    push hl
    ldh a, [hTemp8]
    and $fc
    add a
    ld l, a
    ld h, $00
    ldh a, [hTempA]
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
    ldh a, [hTemp8]
    and $03
    ld c, a
    sla a
    add c
    sla a
    sla a
    add_a_to_hl
    ldh a, [hTempA]
    and $03
    ld c, a
    sla a
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
    ld e, l
    ld d, h
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    call ReadByteInBank
    ld l, c
    inc de
    call ReadByteInBank
    ld h, c
    dec hl
    ld c, l
    ld b, h
    ld a, $19
    call Multiply8By16
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ldh a, [hTemp6]
    ld c, a
    sla a
    sla a
    add c
    add_a_to_hl
    ldh a, [hTemp9]
    add_a_to_hl
    ld a, l
    add $a0
    ld l, a
    ld a, h
    adc $43
    ld h, a
    ld e, l
    ld d, h
    ld b, $5e
    call ReadByteInBank
    pop hl
    ld a, c
    call WriteVRAMByte
    ret

; Finds where the player is for the close-up: runs the map-type position routine
; (SetWorldMapPlayerScreenByMapType), then sets the first screen and the cell within it
; (hTemp5-hTemp8) so the player's screen is in the middle; the player's position is restored. (C2,
; E-0357; probed E-0385)
RunWorldMapState_DrawCloseUp_CenterKeyWorld::
    ldh a, [hPlayerX]
    ld l, a
    ldh a, [hMapScreenX]
    ld h, a
    push hl
    ldh a, [hPlayerY]
    ld l, a
    ldh a, [hMapScreenY]
    ld h, a
    push hl
    call SetWorldMapPlayerScreenByMapType
    ld a, [wKeyWorldWidth]
    ldh [hTemp3], a
    ld a, [wKeyWorldHeight]
    ldh [hTemp4], a
    ldh a, [hMapScreenX]
    dec a
    dec a
    ldh [hTemp7], a
    ldh a, [hMapScreenY]
    dec a
    dec a
    ldh [hTemp8], a
    ldh a, [hPlayerX]
    swap a
    and $0f
    srl a
    inc a
    cp $05
    jr c, .set_temp5
    sub $05
    push af
    ld hl, hTemp7
    inc [hl]
    pop af

.set_temp5:
    ldh [hTemp5], a
    ldh a, [hPlayerY]
    swap a
    and $0f
    srl a
    inc a
    inc a
    cp $05
    jr c, .set_temp6
    sub $05
    push af
    ld hl, hTemp8
    inc [hl]
    pop af

.set_temp6:
    ldh [hTemp6], a
    pop hl
    ld a, l
    ldh [hPlayerY], a
    ld a, h
    ldh [hMapScreenY], a
    pop hl
    ld a, l
    ldh [hPlayerX], a
    ld a, h
    ldh [hMapScreenX], a
    ret

; Chooses where the player is placed for the world map by wMapType and 7: 0
; SetWorldMapPlayerScreenByMapType_KeepPlace, 1 and 2 SetWorldMapPlayerScreenByMapType_PlaceAtExit,
; 3 to 6 SetWorldMapPlayerScreenByMapType_PlaceAtFloor, 7
; SetWorldMapPlayerScreenByMapType_PlaceAtGoal. Called by
; RunWorldMapState_DrawCloseUp_CenterKeyWorld. It has nothing to do with game mode 2 (the pause
; menu). (C2, E-0385)
; runs the routine for wMapType & 7 (jump table) (E-0122)
SetWorldMapPlayerScreenByMapType::
    ld a, [wMapType]
    and $07
    jumptable
    dw SetWorldMapPlayerScreenByMapType_KeepPlace
    dw SetWorldMapPlayerScreenByMapType_PlaceAtExit
    dw SetWorldMapPlayerScreenByMapType_PlaceAtExit
    dw SetWorldMapPlayerScreenByMapType_PlaceAtFloor
    dw SetWorldMapPlayerScreenByMapType_PlaceAtFloor
    dw SetWorldMapPlayerScreenByMapType_PlaceAtFloor
    dw SetWorldMapPlayerScreenByMapType_PlaceAtFloor
    dw SetWorldMapPlayerScreenByMapType_PlaceAtGoal

; Map type 0: nothing to do. (C2, E-0357; probed E-0385)
SetWorldMapPlayerScreenByMapType_KeepPlace::
    ret

; Map type 1: places the player at the current floor's exit screen (wKeyWorldAreaExits). (C2,
; E-0357; probed E-0385)
SetWorldMapPlayerScreenByMapType_PlaceAtExit::
    ld a, [wKeyWorldFloor]
    and $07
    add a
    add a
    ld hl, wKeyWorldAreaExits
    add_a_to_hl
    ld a, [wKeyWorldFloor]
    bit 7, a
    jr z, .skip
    inc hl

.skip:
    ld a, [hl]
    jr SetMapScreenFromAAndCenterPlayer

; Map type 3: places the player at the current floor's screen from wKeyWorldFloorInfo. (C2, E-0357;
; probed E-0385)
SetWorldMapPlayerScreenByMapType_PlaceAtFloor::
    ld a, [wKeyWorldFloor]
    and $07
    add a
    add a
    ld hl, wKeyWorldFloorInfo
    add_a_to_hl
    ld a, [hl]
    jr SetMapScreenFromAAndCenterPlayer

; Map type 7: places the player at the key world's goal (wKeyWorldGoalCell and wKeyWorldGoal) when
; the active key's slot matches, otherwise at wKeyWorldGoalScreen / wKeyWorldGoalPos. (C2, E-0357;
; probed E-0385)
SetWorldMapPlayerScreenByMapType_PlaceAtGoal::
    ld a, [wKeyWorldActive]
    or a
    jr z, .read_key_world_goal_screen
    ld a, [wKeyWorldKey]
    bit 7, a
    jr z, .read_key_world_goal_screen
    and $7f
    ld c, a
    ld a, [wKeyWorldSlot]
    cp c
    jr nz, .read_key_world_goal_screen
    ld a, [wKeyWorldGoalCell]
    call SetMapScreenFromAAndCenterPlayer
    ld a, [wKeyWorldGoal]
    and $f0
    ldh [hPlayerX], a
    ld a, [wKeyWorldGoal]
    and $0f
    swap a
    ldh [hPlayerY], a
    ret

.read_key_world_goal_screen:
    ld a, [wKeyWorldGoalScreen]
    call SetMapScreenFromAAndCenterPlayer
    ld a, [wKeyWorldGoalPos]
    ldh [hPlayerX], a
    ld a, [wKeyWorldGoalPos2]
    ldh [hPlayerY], a
    ret

; A = a screen (high nibble X, low nibble Y): hMapScreenX = X, hMapScreenY = Y, hPlayerX = hPlayerY
; = $40. A is clobbered. Used by the placements SetWorldMapPlayerScreenByMapType_PlaceAtExit and
; SetWorldMapPlayerScreenByMapType_PlaceAtFloor (which jump to it) and
; SetWorldMapPlayerScreenByMapType_PlaceAtGoal (which calls it). (C2, E-0385)
; hMapScreenX = A >> 4, hMapScreenY = A & $0F, hPlayerX = hPlayerY = $40 (E-0118)
SetMapScreenFromAAndCenterPlayer::
    push af
    swap a
    and $0f
    ldh [hMapScreenX], a
    pop af
    and $0f
    ldh [hMapScreenY], a
    ld a, $40
    ldh [hPlayerX], a
    ldh [hPlayerY], a
    ret

; Draws a region's close-up: copies the 5 x 5 tile block of each screen in view from the region's
; screen tiles (WorldMapScreenCellTable) in ROM. (C1, E-0357)
RunWorldMapState_DrawCloseUp_Region::
    call RunWorldMapState_SetUpCloseUp
    call StoreTemp5ValuesToCursorCellX
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld hl, vBGMap0
    ld c, $12

.loop:
    push hl
    push de
    ldh a, [hTemp5]
    ldh [hTemp9], a
    ldh a, [hTemp7]
    ldh [hTempA], a
    ld b, $14

.loop2:
    push bc
    push hl
    ldh a, [hTempA]
    bit 7, a
    jr nz, .check_temp9
    ld c, a
    ldh a, [hTemp3]
    dec a
    cp c
    jr c, .check_temp9
    ldh a, [hTemp8]
    bit 7, a
    jr nz, .check_temp9
    ld c, a
    ldh a, [hTemp4]
    dec a
    cp c
    jr c, .check_temp9
    ldh a, [hTemp2]
    ld b, a
    call ReadByteInBank
    ld a, c
    call WriteVRAMByte

.check_temp9:
    inc de
    ldh a, [hTemp9]
    inc a
    cp $05
    jr nz, .set_temp9
    ldh a, [hTempA]
    inc a
    ldh [hTempA], a
    ld a, e
    add $14
    ld e, a
    ld a, d
    adc $00
    ld d, a
    xor a

.set_temp9:
    ldh [hTemp9], a
    pop hl
    inc hl
    pop bc
    dec b
    jr nz, .loop2
    pop de
    ld a, $05
    add e
    ld e, a
    jr nc, .check_temp6
    inc d

.check_temp6:
    ldh a, [hTemp6]
    inc a
    cp $05
    jr nz, .set_temp6
    ldh a, [hTemp8]
    inc a
    ldh [hTemp8], a
    push bc
    ldh a, [hTemp3]
    ld c, a
    ld a, $19
    push de
    call Multiply8
    pop de
    add hl, de
    ld e, l
    ld d, h
    ld a, e
    sub $19
    ld e, a
    ld a, d
    sbc $00
    ld d, a
    pop bc
    xor a

.set_temp6:
    ldh [hTemp6], a
    pop hl
    ld a, $20
    add_a_to_hl
    dec c
    jp nz, .loop
    ret

; Sets up a region's close-up: the region's size and screen-tile table from WorldMapScreenCellTable,
; and the first screen and cell so the player's screen is in the middle. (C2, E-0357; probed E-0385)
RunWorldMapState_SetUpCloseUp::
    ldh a, [hPlayerX]
    ld l, a
    ldh a, [hMapScreenX]
    ld h, a
    push hl
    ldh a, [hPlayerY]
    ld l, a
    ldh a, [hMapScreenY]
    ld h, a
    push hl
    call RunWorldMapState_FindPlayerScreen
    ld a, [wWorldMapRegion]
    add a
    add a
    ld hl, WorldMapScreenCellTable
    add_a_to_hl
    ld a, [hl]
    swap a
    and $0f
    ldh [hTemp3], a
    ld a, [hli]
    and $0f
    ldh [hTemp4], a
    ld a, [hli]
    ldh [hTemp0], a
    ld a, [hli]
    ldh [hTemp1], a
    ld a, [hl]
    ldh [hTemp2], a
    ldh a, [hMapScreenX]
    ld c, a
    ldh a, [hMapId]
    ld b, a
    ld b, $00
    dec bc
    dec bc
    ld a, c
    ldh [hTemp7], a
    ld a, $19
    call Multiply8By16
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    add hl, de
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ldh a, [hMapScreenY]
    ld c, a
    ldh a, [hPlayerSpriteOverride]
    ld b, a
    ld b, $00
    dec bc
    dec bc
    ld a, c
    ldh [hTemp8], a
    ldh a, [hTemp3]
    call Multiply8By16
    ld c, l
    ld b, h
    ld a, $19
    call Multiply8By16
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    add hl, de
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ldh a, [hPlayerX]
    swap a
    and $0f
    srl a
    inc a
    cp $05
    jr c, .set_temp5
    sub $05
    push af
    ld hl, hTemp7
    inc [hl]
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, l
    add $19
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    pop af

.set_temp5:
    ldh [hTemp5], a
    push af
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    pop af
    add_a_to_hl
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ldh a, [hPlayerY]
    swap a
    and $0f
    srl a
    inc a
    inc a
    cp $05
    jr c, .set_temp6
    sub $05
    push af
    ld hl, hTemp8
    inc [hl]
    ldh a, [hTemp3]
    ld c, $19
    call Multiply8
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    add hl, de
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    pop af

.set_temp6:
    ldh [hTemp6], a
    ld c, a
    add a
    add a
    add c
    push af
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    pop af
    add_a_to_hl
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    pop hl
    ld a, l
    ldh [hPlayerY], a
    ld a, h
    ldh [hMapScreenY], a
    pop hl
    ld a, l
    ldh [hPlayerX], a
    ld a, h
    ldh [hMapScreenX], a
    ret

; RunWorldMapState_SetUpCloseUp reads the record at $497C + 4 * wGameMode2Byte44: width and height
; from the nibbles of byte 0, then a 24-bit pointer; it adds (hMapScreenX - 2) * 25 and (hMapScreenY
; - 2) * width * 25, then steps 5 cells per row; each grid is exactly width * height * 25 bytes and
; the 11 grids fill bank $5D from $45A5 to $7692 (E-0185, C1)
; record: size nibbles (width, height in screens); pointer and bank of the 25-byte-per-screen cell
; grid
WorldMapScreenCellTable::
    db $88 ; id 0: size: width in screens (high nibble), height in screens (low nibble)
    dfar WorldMapScreenCells0 ; screen cell grid: 25 bytes (5 x 5) per screen
    db $88 ; id 1: size: width in screens (high nibble), height in screens (low nibble)
    dfar WorldMapScreenCells1 ; screen cell grid: 25 bytes (5 x 5) per screen
    db $cc ; id 2: size: width in screens (high nibble), height in screens (low nibble)
    dfar WorldMapScreenCells2 ; screen cell grid: 25 bytes (5 x 5) per screen
    db $cc ; id 3: size: width in screens (high nibble), height in screens (low nibble)
    dfar WorldMapScreenCells3 ; screen cell grid: 25 bytes (5 x 5) per screen
    db $43 ; id 4: size: width in screens (high nibble), height in screens (low nibble)
    dfar WorldMapScreenCells4 ; screen cell grid: 25 bytes (5 x 5) per screen
    db $66 ; id 5: size: width in screens (high nibble), height in screens (low nibble)
    dfar WorldMapScreenCells5 ; screen cell grid: 25 bytes (5 x 5) per screen
    db $32 ; id 6: size: width in screens (high nibble), height in screens (low nibble)
    dfar WorldMapScreenCells6 ; screen cell grid: 25 bytes (5 x 5) per screen
    db $55 ; id 7: size: width in screens (high nibble), height in screens (low nibble)
    dfar WorldMapScreenCells7 ; screen cell grid: 25 bytes (5 x 5) per screen
    db $12 ; id 8: size: width in screens (high nibble), height in screens (low nibble)
    dfar WorldMapScreenCells8 ; screen cell grid: 25 bytes (5 x 5) per screen
    db $12 ; id 9: size: width in screens (high nibble), height in screens (low nibble)
    dfar WorldMapScreenCells9 ; screen cell grid: 25 bytes (5 x 5) per screen
    db $21 ; id 10: size: width in screens (high nibble), height in screens (low nibble)
    dfar WorldMapScreenCells10 ; screen cell grid: 25 bytes (5 x 5) per screen

; Finds the player's region screen: on a region's entrance map (hMapId $29, $45, $68, $9D, $A4, $AF,
; $B2, $C5, $D0, $D9, $E2) the start position, or the key world's goal when that region's key is
; active; on maps $20, $30, $48, $70, $A0, $A8, $B0, $B8, $C8, $D1, $DA nothing changes; other maps
; look themselves up in WorldMapScreenPositionTable (the second position when the last warp was 2).
; (C2, E-0357; probed E-0385)
RunWorldMapState_FindPlayerScreen::
    ldh a, [hMapId]
    ld c, $01
    cp $29
    jp z, .check_world_map_region
    ld c, $02
    cp $45
    jp z, .check_world_map_region
    ld c, $03
    cp $68
    jp z, .check_world_map_region
    ld c, $04
    cp $9d
    jp z, .check_world_map_region
    ld c, $05
    cp $a4
    jp z, .check_world_map_region
    ld c, $06
    cp $af
    jp z, .check_world_map_region
    ld c, $07
    cp $b2
    jp z, .check_world_map_region
    ld c, $08
    cp $c5
    jr z, .check_world_map_region
    ld c, $09
    cp $d0
    jr z, .check_world_map_region
    ld c, $0a
    cp $d9
    jr z, .check_world_map_region
    ld c, $0b
    cp $e2
    jr z, .check_world_map_region
    cp $20
    ret z
    cp $30
    ret z
    cp $48
    ret z
    cp $70
    ret z
    cp $a0
    ret z
    cp $a8
    ret z
    cp $b0
    ret z
    cp $b8
    ret z
    cp $c8
    ret z
    cp $d1
    ret z
    cp $da
    ret z
    ld c, a
    ld hl, WorldMapScreenPositionTable

.skip:
    ld a, [hl]
    cp c
    jr z, .check_last_warp_index
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr .skip

.check_last_warp_index:
    ld a, [wLastWarpIndex]
    dec a
    dec a
    jr nz, .call_load_map_position_from_hl
    inc hl
    inc hl

.call_load_map_position_from_hl:
    inc hl
    call LoadMapPositionFromHL
    ret

.check_world_map_region:
    ld a, [wWorldMapRegion]
    inc a
    ld c, a
    ld a, [wKeyWorldActive]
    or a
    jr z, .skip2
    ld a, [wKeyWorldKey]
    bit 7, a
    jr nz, .skip2
    cp c
    jr nz, .skip2
    ld a, [wKeyWorldGoalCell]
    swap a
    and $0f
    ldh [hMapScreenX], a
    ld a, [wKeyWorldGoalCell]
    and $0f
    ldh [hMapScreenY], a
    ld a, [wKeyWorldGoal]
    and $f0
    ldh [hPlayerX], a
    ld a, [wKeyWorldGoal]
    and $0f
    swap a
    ldh [hPlayerY], a
    ret

.skip2:
    ld a, c
    dec a
    add a
    add a
    ld hl, WorldMapStartPositions
    add_a_to_hl
    call LoadMapPositionFromHL
    ret

; HL = a position record of two bytes: hMapScreenX and hMapScreenY = the high and low nibble of the
; first byte; hPlayerX = the second byte and $F0, hPlayerY = its low nibble shifted up by 4. HL ends
; on the second byte; A is clobbered. Called twice by RunWorldMapState_FindPlayerScreen. (C2,
; E-0385)
; hMapScreenX/Y = the nibbles of [HL]; hPlayerX = [HL + 1] & $F0, hPlayerY = ([HL + 1] & $0F) << 4
; (E-0118)
LoadMapPositionFromHL::
    ld a, [hl]
    swap a
    and $0f
    ldh [hMapScreenX], a
    ld a, [hl]
    and $0f
    ldh [hMapScreenY], a
    inc hl
    ld a, [hl]
    and $f0
    ldh [hPlayerX], a
    ld a, [hl]
    and $0f
    swap a
    ldh [hPlayerY], a
    ret

; wCursorCellX = hTemp5, wCursorCellY = hTemp7, wCursorCellW = hTemp6, wCursorCellH = hTemp8 (the
; first screen block and cell the close-up starts from). A is clobbered. Called by
; RunWorldMapState_DrawCloseUp_KeyWorld and RunWorldMapState_DrawCloseUp_Region. (C2, E-0385)
; wCursorCellX = hTemp5, wCursorCellY = hTemp7, wCursorCellW = hTemp6, wCursorCellH = hTemp8
; (E-0118)
StoreTemp5ValuesToCursorCellX::
    ldh a, [hTemp5]
    ld [wCursorCellX], a
    ldh a, [hTemp7]
    ld [wCursorCellY], a
    ldh a, [hTemp6]
    ld [wCursorCellW], a
    ldh a, [hTemp8]
    ld [wCursorCellH], a
    ret

; World map, step 5 (the close-up): B or Select closes the map (RunWorldMapState_WhiteOutScreen);
; otherwise draws the blinking player marker and the other markers. (C1, E-0357)
RunWorldMapState_CloseUpInput::
    ld a, [wJoypadPressed]
    bit 1, a
    jr nz, RunWorldMapState_WhiteOutScreen
    bit 2, a
    jr z, RunWorldMapState_DrawCloseUpMarkers

; Turns the screen white at once: clears the three DMG palette bytes at wDMGPaletteBGP and, on the
; GBC, fills $50 bytes of wBGPaletteBuffer with $FF, requests BG and OBJ palette uploads and uploads
; the BG palettes now (UploadBGPalettes); then advances wWorldMapState. Used to close the map from
; the overview (RunWorldMapState_OverviewInput, which then sets step 6) and from the close-up
; (RunWorldMapState_CloseUpInput). (C1, E-0371)
RunWorldMapState_WhiteOutScreen::
    ld hl, wDMGPaletteBGP
    ld a, $00
    ld [hli], a
    ld [hli], a
    ld [hl], a
    ld a, [wIsCGB]
    or a
    jr z, .done
    ld hl, wBGPaletteBuffer
    ld bc, $0050
    ld a, $ff
    call FillBytes
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    call UploadBGPalettes

.done:
    ld hl, wWorldMapState
    inc [hl]
    ret

; Close-up markers: the blinking player marker, the region's markers, the key-world objects, those
; shown by the field skill, and the goal marker. (C1, E-0357)
RunWorldMapState_DrawCloseUpMarkers::
    call DrawBlinkingMetaSprite8
    call RunWorldMapState_DrawRegionMarkers
    call RunWorldMapState_DrawKeyWorldMarkers
    call RunWorldMapState_DrawObjectMarkers
    call RunWorldMapState_GoalMarker
    ret

; Close-up goal marker: in a region, the key world's goal when its key is active (region by hMapId:
; below $30 is 1, below $48 2, ... $DA and over 11), otherwise the region's start position
; (WorldMapStartPositions); in a key world, its goal or goal screen; drawn by
; RunWorldMapState_GoalMarker_Draw. (C1, E-0357)
RunWorldMapState_GoalMarker::
    ld a, [wMapType]
    bit 7, a
    jp nz, .check_key_world_active2
    ldh a, [hMapId]
    ld c, $01
    cp $30
    jr c, .check_key_world_active
    ld c, $02
    cp $48
    jr c, .check_key_world_active
    ld c, $03
    cp $70
    jr c, .check_key_world_active
    ld c, $04
    cp $a0
    jr c, .check_key_world_active
    ld c, $05
    cp $a8
    jr c, .check_key_world_active
    ld c, $06
    cp $b0
    jr c, .check_key_world_active
    ld c, $07
    cp $b8
    jr c, .check_key_world_active
    ld c, $08
    cp $c8
    jr c, .check_key_world_active
    ld c, $09
    cp $d1
    jr c, .check_key_world_active
    ld c, $0a
    cp $da
    jr c, .check_key_world_active
    ld c, $0b

.check_key_world_active:
    ld a, [wKeyWorldActive]
    or a
    jr z, .skip
    ld a, [wKeyWorldKey]
    cp c
    jr nz, .skip
    ld a, [wKeyWorldGoalCell]
    ldh [hTemp1], a
    ld a, [wKeyWorldGoal]
    ldh [hTemp2], a
    call RunWorldMapState_GoalMarker_Draw
    ret

.skip:
    ld a, c
    dec a
    add a
    add a
    ld hl, WorldMapStartPositions
    add_a_to_hl
    ld a, [hli]
    ldh [hTemp1], a
    ld a, [hl]
    ldh [hTemp2], a
    call RunWorldMapState_GoalMarker_Draw
    ret

.check_key_world_active2:
    ld a, [wKeyWorldActive]
    or a
    jr z, .read_key_world_goal_screen
    ld a, [wKeyWorldKey]
    bit 7, a
    jr z, .read_key_world_goal_screen
    and $7f
    ld c, a
    ld a, [wKeyWorldSlot]
    cp c
    jr nz, .read_key_world_goal_screen
    ld a, [wKeyWorldGoalCell]
    ldh [hTemp1], a
    ld a, [wKeyWorldGoal]
    ldh [hTemp2], a
    call RunWorldMapState_GoalMarker_Draw
    ret

.read_key_world_goal_screen:
    ld a, [wKeyWorldGoalScreen]
    ldh [hTemp1], a
    ld a, [wKeyWorldGoalPos]
    and $f0
    ld c, a
    ld a, [wKeyWorldGoalPos2]
    and $f0
    swap a
    or c
    ldh [hTemp2], a
    call RunWorldMapState_GoalMarker_Draw
    ret

; Draws marker set $28 at screen hTemp1 (x high nibble, y low nibble), position hTemp2, when the
; screen is within the 5 x 5 screens in view: 40 pixels a screen plus 8 per half-tile step. (C1,
; E-0357)
RunWorldMapState_GoalMarker_Draw::
    ld a, [wCursorCellY]
    ld c, a
    ldh a, [hTemp1]
    swap a
    and $0f
    sub c
    bit 7, a
    jp nz, .return
    cp $05
    jp nc, .return
    ld c, $28
    call Multiply8
    ld a, l
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellH]
    ld c, a
    ldh a, [hTemp1]
    and $0f
    sub c
    bit 7, a
    jr nz, .return
    cp $05
    jr nc, .return
    ld c, $28
    call Multiply8
    ld a, l
    ldh [hSpriteOriginY], a
    ld a, [wCursorCellX]
    sla a
    sla a
    sla a
    ld c, a
    ldh a, [hTemp2]
    swap a
    and $0f
    srl a
    sla a
    sla a
    sla a
    sub c
    ld c, a
    ldh a, [hSpriteOriginX]
    add c
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellW]
    sla a
    sla a
    sla a
    ld c, a
    ldh a, [hTemp2]
    and $0f
    srl a
    sla a
    sla a
    sla a
    sub c
    ld c, a
    ldh a, [hSpriteOriginY]
    add c
    ldh [hSpriteOriginY], a
    ld a, $20
    ldh [hSpriteTileOffset], a
    ld a, $01
    ldh [hSpriteAttrXor], a
    ld a, $28
    ldh [hSpriteSetIndex], a
    xor a
    ldh [hSpriteSubIndex], a
    xor a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite

.return:
    ret

; Close-up markers of the map objects, only when the map was opened by the field skill
; (wWorldMapByFieldSkill): for each of the wMapObjectCount 8-byte entries of wMapObjects without bit
; 7 in byte 0 whose screen (byte 4: x high nibble, y low) lies within the 5 x 5 screens in view,
; draws marker set $27 (tile offset $10, attribute xor 2) at 40 pixels per screen plus 8 per
; half-tile step of its position byte (byte 5), less the view's cell offset (wCursorCellX,
; wCursorCellW). In a key world (wMapType bit 7) the same entries are used, but byte 5 is an index
; into the 16-byte position table that follows this routine. (C1, E-0371)
RunWorldMapState_DrawObjectMarkers::
    ld a, [wWorldMapByFieldSkill]
    or a
    ret z
    ld a, [wMapType]
    bit 7, a
    jp nz, .read_map_object_count
    ld a, [wMapObjectCount]
    ld b, a
    ld de, wMapObjects

.loop:
    push bc
    push de
    ld a, [de]
    bit 7, a
    jp nz, .restore
    inc de
    inc de
    inc de
    inc de
    ld a, [wCursorCellY]
    ld c, a
    ld a, [de]
    swap a
    and $0f
    sub c
    bit 7, a
    jp nz, .restore
    cp $05
    jp nc, .restore
    ld c, $28
    push de
    call Multiply8
    pop de
    ld a, l
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellH]
    ld c, a
    ld a, [de]
    and $0f
    sub c
    bit 7, a
    jr nz, .restore
    cp $05
    jr nc, .restore
    ld c, $28
    push de
    call Multiply8
    pop de
    ld a, l
    ldh [hSpriteOriginY], a
    ld a, [wCursorCellX]
    add a
    add a
    add a
    ld c, a
    inc de
    ld a, [de]
    swap a
    and $0f
    srl a
    add a
    add a
    add a
    sub c
    ld c, a
    ldh a, [hSpriteOriginX]
    add c
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellW]
    add a
    add a
    add a
    ld c, a
    ld a, [de]
    and $0f
    srl a
    add a
    add a
    add a
    sub c
    ld c, a
    ldh a, [hSpriteOriginY]
    add c
    ldh [hSpriteOriginY], a
    ld a, $10
    ldh [hSpriteTileOffset], a
    ld a, $02
    ldh [hSpriteAttrXor], a
    ld a, $27
    ldh [hSpriteSetIndex], a
    xor a
    ldh [hSpriteSubIndex], a
    xor a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite

.restore:
    pop de
    ld a, $08
    add e
    ld e, a
    jr nc, .restore2
    inc d

.restore2:
    pop bc
    dec b
    jp nz, .loop
    ret

.read_map_object_count:
    ld a, [wMapObjectCount]
    ld b, a
    ld de, wMapObjects

.loop2:
    push bc
    push de
    ld a, [de]
    bit 7, a
    jp nz, .restore3
    inc de
    inc de
    inc de
    inc de
    ld a, [wCursorCellY]
    ld c, a
    ld a, [de]
    swap a
    and $0f
    sub c
    bit 7, a
    jp nz, .restore3
    cp $05
    jp nc, .restore3
    ld c, $28
    push de
    call Multiply8
    pop de
    ld a, l
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellH]
    ld c, a
    ld a, [de]
    and $0f
    sub c
    bit 7, a
    jr nz, .restore3
    cp $05
    jr nc, .restore3
    ld c, $28
    push de
    call Multiply8
    pop de
    ld a, l
    ldh [hSpriteOriginY], a
    inc de
    ld a, [de]
    ld hl, RunWorldMapState_DrawObjectMarkers_Data
    add_a_to_hl
    ld a, [wCursorCellX]
    sla a
    sla a
    sla a
    ld c, a
    ld a, [hl]
    swap a
    and $0f
    srl a
    sla a
    sla a
    sla a
    sub c
    ld c, a
    ldh a, [hSpriteOriginX]
    add c
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellW]
    sla a
    sla a
    sla a
    ld c, a
    ld a, [hl]
    and $0f
    srl a
    sla a
    sla a
    sla a
    sub c
    ld c, a
    ldh a, [hSpriteOriginY]
    add c
    ldh [hSpriteOriginY], a
    ld a, $10
    ldh [hSpriteTileOffset], a
    ld a, $02
    ldh [hSpriteAttrXor], a
    ld a, $27
    ldh [hSpriteSetIndex], a
    xor a
    ldh [hSpriteSubIndex], a
    xor a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite

.restore3:
    pop de
    ld a, $08
    add e
    ld e, a
    jr nc, .restore4
    inc d

.restore4:
    pop bc
    dec b
    jp nz, .loop2
    ret

; Sixteen bytes, each a packed position inside a map screen: the high nibble feeds the marker X and
; the low nibble the marker Y, each as (nibble >> 1) * 8 pixels before the cursor-cell offset is
; subtracted. In a key world (wMapType bit 7 set) RunWorldMapState_DrawObjectMarkers uses byte 5 of
; each 8-byte wMapObjects entry as the index into this table; in other worlds it takes that byte
; itself as the packed position. The marker is drawn with DrawMetaSprite. (C1, E-0381)
RunWorldMapState_DrawObjectMarkers_Data::
    db $12, $17, $21, $24, $26, $33, $45, $47, $51, $53, $65, $72, $74, $77, $81, $86

; Draws the region's markers (WorldMapMarkerLists for wWorldMapRegion: a count, then screen and
; position pairs) with set $28 when in view; in a key world uses the floor list. (C1, E-0357)
RunWorldMapState_DrawRegionMarkers::
    ld a, [wMapType]
    bit 7, a
    jp nz, .skip
    ld a, [wWorldMapRegion]
    add a
    ld hl, WorldMapMarkerLists
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, [de]
    or a
    ret z
    inc de
    ld b, a

.loop:
    push bc
    push de
    ld a, [wCursorCellY]
    ld c, a
    ld a, [de]
    swap a
    and $0f
    sub c
    bit 7, a
    jp nz, .restore
    cp $05
    jp nc, .restore
    ld c, $28
    push de
    call Multiply8
    pop de
    ld a, l
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellH]
    ld c, a
    ld a, [de]
    and $0f
    sub c
    bit 7, a
    jr nz, .restore
    cp $05
    jr nc, .restore
    ld c, $28
    push de
    call Multiply8
    pop de
    ld a, l
    ldh [hSpriteOriginY], a
    ld a, [wCursorCellX]
    add a
    add a
    add a
    ld c, a
    inc de
    ld a, [de]
    swap a
    and $0f
    srl a
    add a
    add a
    add a
    sub c
    ld c, a
    ldh a, [hSpriteOriginX]
    add c
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellW]
    add a
    add a
    add a
    ld c, a
    ld a, [de]
    and $0f
    srl a
    add a
    add a
    add a
    sub c
    ld c, a
    ldh a, [hSpriteOriginY]
    add c
    ldh [hSpriteOriginY], a
    ld a, $20
    ldh [hSpriteTileOffset], a
    ld a, $01
    ldh [hSpriteAttrXor], a
    ld a, $28
    ldh [hSpriteSetIndex], a
    xor a
    ldh [hSpriteSubIndex], a
    xor a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite

.restore:
    pop de
    inc de
    inc de
    pop bc
    dec b
    jp nz, .loop
    ret

.skip:
    ld de, wKeyWorldFloorInfo + $3

.skip2:
    push de
    ld a, [de]
    cp $ff
    jr nz, .next
    pop de
    ret

.next:
    dec de
    dec de
    dec de
    ld a, [wCursorCellY]
    ld c, a
    ld a, [de]
    swap a
    and $0f
    sub c
    bit 7, a
    jp nz, .restore2
    cp $05
    jr nc, .restore2
    ld c, $28
    push de
    call Multiply8
    pop de
    ld a, l
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellH]
    ld c, a
    ld a, [de]
    and $0f
    sub c
    bit 7, a
    jr nz, .restore2
    cp $05
    jr nc, .restore2
    ld c, $28
    push de
    call Multiply8
    pop de
    ld a, l
    ldh [hSpriteOriginY], a
    ld a, [wWorldMapByFieldSkill]
    or a
    jr nz, .read_cursor_cell_x
    ld a, [de]
    call IsMapScreenAVisited
    or a
    jr z, .restore2

.read_cursor_cell_x:
    ld a, [wCursorCellX]
    add a
    add a
    add a
    ld c, a
    ld a, $02
    add a
    add a
    add a
    sub c
    ld c, a
    ldh a, [hSpriteOriginX]
    add c
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellW]
    add a
    add a
    add a
    ld c, a
    ld a, $02
    add a
    add a
    add a
    sub c
    ld c, a
    ldh a, [hSpriteOriginY]
    add c
    ldh [hSpriteOriginY], a
    ld a, $20
    ldh [hSpriteTileOffset], a
    ld a, $01
    ldh [hSpriteAttrXor], a
    ld a, $28
    ldh [hSpriteSetIndex], a
    xor a
    ldh [hSpriteSubIndex], a
    xor a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite

.restore2:
    pop de
    inc de
    inc de
    inc de
    inc de
    jp .skip2

; In a key world (wMapType bit 7) walks wKeyWorldObjects in 4-byte steps until an entry whose first
; byte is $FF, and for each draws the screen marker (RunWorldMapState_DrawKeyWorldMarkers_Screen)
; for the two bytes three and two bytes before that first byte, so the first entry reads the two
; bytes just before wKeyWorldObjects. (C1, E-0371)
RunWorldMapState_DrawKeyWorldMarkers::
    ld a, [wMapType]
    bit 7, a
    ret z
    ld de, wKeyWorldObjects

.skip:
    push de
    ld a, [de]
    cp $ff
    jr nz, .next
    pop de
    ret

.next:
    dec de
    dec de
    dec de
    call RunWorldMapState_DrawKeyWorldMarkers_Screen
    inc de
    call RunWorldMapState_DrawKeyWorldMarkers_Screen
    pop de
    inc de
    inc de
    inc de
    inc de
    jp .skip

; Draws marker set $28 near the middle of key-world screen [DE] when it is in view and visited (or
; the field skill shows everything). (C1, E-0357)
RunWorldMapState_DrawKeyWorldMarkers_Screen::
    ld a, [wCursorCellY]
    ld c, a
    ld a, [de]
    swap a
    and $0f
    sub c
    bit 7, a
    ret nz
    cp $05
    ret nc
    ld c, $28
    push de
    call Multiply8
    pop de
    ld a, l
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellH]
    ld c, a
    ld a, [de]
    and $0f
    sub c
    bit 7, a
    ret nz
    cp $05
    ret nc
    ld c, $28
    push de
    call Multiply8
    pop de
    ld a, l
    ldh [hSpriteOriginY], a
    ld a, [wWorldMapByFieldSkill]
    or a
    jr nz, .read_cursor_cell_x
    ld a, [de]
    call IsMapScreenAVisited
    or a
    ret z

.read_cursor_cell_x:
    ld a, [wCursorCellX]
    add a
    add a
    add a
    ld c, a
    ld a, $02
    add a
    add a
    add a
    sub c
    ld c, a
    ldh a, [hSpriteOriginX]
    add c
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellW]
    add a
    add a
    add a
    ld c, a
    ld a, $02
    add a
    add a
    add a
    sub c
    ld c, a
    ldh a, [hSpriteOriginY]
    add c
    ldh [hSpriteOriginY], a
    ld a, $20
    ldh [hSpriteTileOffset], a
    ld a, $01
    ldh [hSpriteAttrXor], a
    ld a, $28
    ldh [hSpriteSetIndex], a
    xor a
    ldh [hSpriteSubIndex], a
    xor a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    push de
    farcall DrawMetaSprite
    pop de
    ret

; While bit 5 of wFrameCounterLo is set, draws metasprite set 8 (DrawMetaSprite, sub-index 0, no
; tile offset or attribute change) with its origin at X $4E, Y $46 (near the middle of the screen);
; returns at once when the bit is clear, so it blinks. Called by RunWorldMapState_DrawCloseUpMarkers
; as the marker of the player. (C1, E-0385)
; while bit 5 of wFrameCounterLo is set, draws metasprite set 8 at ($4E, $46) (E-0121)
DrawBlinkingMetaSprite8::
    ld a, [wFrameCounterLo]
    bit 5, a
    ret z
    ld a, $50
    dec a
    dec a
    ldh [hSpriteOriginX], a
    ld a, $48
    dec a
    dec a
    ldh [hSpriteOriginY], a
    ld a, $00
    ldh [hSpriteTileOffset], a
    ld a, $00
    ldh [hSpriteAttrXor], a
    ld a, $08
    ldh [hSpriteSetIndex], a
    xor a
    ldh [hSpriteSubIndex], a
    xor a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite
    ret

; World map, step 0: hides the sprites and blanks the palettes (white on CGB); next step. (C1,
; E-0357)
RunWorldMapState_BlankPalettes::
    xor a
    ld [wSpriteSlotCount], a
    ld hl, wDMGPaletteBGP
    ld a, $00
    ld [hli], a
    ld [hli], a
    ld [hl], a
    ld a, [wIsCGB]
    or a
    jr z, .done
    ld hl, wBGPaletteBuffer
    ld bc, $0040
    ld a, $ff
    call FillBytes
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes

.done:
    ld hl, wWorldMapState
    inc [hl]
    ret

; World map, step 1 (the overview): loads the tiles, draws the frame and the 12 x 12 map, sets the
; attributes, draws the region or key-world overview, and sets the palettes; next step. (C1, E-0357)
RunWorldMapState_DrawOverview::
    xor a
    ldh [hScrollX], a
    ldh [hScrollY], a
    call CopyScrollToHardware
    ld de, Tiles0Gfx_2
    ld b, $7e
    ld hl, vTiles0
    call DecompressToVRAM
    ld de, Tiles0Plus100Gfx
    ld b, $7e
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld de, WorldMapOverviewLandTiles
    ld b, $5d
    ld hl, vTiles2
    call DecompressToVRAM
    ld de, WorldMapOverviewFrameTiles
    ld b, $5e
    ld hl, vTiles2 + $500
    call DecompressToVRAM
    ld de, RunWorldMapState_DrawOverview_TileRect
    ld a, $5e
    lb bc, $14, $12
    ld hl, vBGMap0
    call CopyRectFromBankToVRAM
    call DrawRect12x12FromBankA1
    call RunWorldMapState_DrawOverview_SetAttributes
    ld a, [wMapType]
    bit 7, a
    jr nz, .call_run_world_map_state_draw_overview_key
    call RunWorldMapState_DrawOverview_Region
    jr .skip

.call_run_world_map_state_draw_overview_key:
    call RunWorldMapState_DrawOverview_KeyWorld

.skip:
    ld hl, wDMGPaletteBGP
    ld a, $d2
    ld [hli], a
    ld a, $d2
    ld [hli], a
    ld a, $e2
    ld [hl], a
    ld a, [wIsCGB]
    or a
    jr z, .done
    ld a, $40
    ld de, SharedOBJPalettes
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld b, $7e
    ld hl, wOBJPaletteBuffer
    ld c, $08
    call CopyFromBank
    ld de, OBJPaletteBufferPlus8Data_3
    ld b, $7e
    ld hl, wOBJPaletteBuffer + $8
    ld c, $08
    call CopyFromBank
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ld de, WorldMapOverviewPalettes
    ld b, $5d
    ld hl, wBGPaletteBuffer
    ld c, $08
    call CopyFromBank
    ld de, BGPaletteBufferPlus8Data
    ld b, $5e
    ld hl, wBGPaletteBuffer + $8
    ld c, $08
    call CopyFromBank
    ld a, $7f
    ld [wBGPaletteUploadRequest], a

.done:
    ld hl, wWorldMapState
    inc [hl]
    ret

; World map, step 2 (the overview): B whites out the screen (RunWorldMapState_WhiteOutScreen) and
; sets step 6 (back to the field); Select goes on to step 3 (the close-up's set-up); otherwise draws
; the blinking player marker (RunWorldMapState_DrawOverviewPlayerMarker), the other markers
; (RunWorldMapState_DrawOverviewMarkers, RunWorldMapState_DrawKeyWorldObjectMarkers) and the goal
; marker (RunWorldMapState_DrawOverviewGoalMarker). (C1, E-0371)
RunWorldMapState_OverviewInput::
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_bit2
    call RunWorldMapState_WhiteOutScreen
    ld a, $06
    ld [wWorldMapState], a
    ret

.check_bit2:
    bit 2, a
    jr z, .call_run_world_map_state_draw_overview_player
    ld hl, wWorldMapState
    inc [hl]
    ret

.call_run_world_map_state_draw_overview_player:
    call RunWorldMapState_DrawOverviewPlayerMarker
    call RunWorldMapState_DrawOverviewMarkers
    call RunWorldMapState_DrawKeyWorldObjectMarkers
    call RunWorldMapState_DrawOverviewGoalMarker
    ret

; World map, step 6: returns to the field (EnterGameMode1WithDefaultPalettes). (C1, E-0357)
RunWorldMapState_ReturnToField::
    call EnterGameMode1WithDefaultPalettes
    ret

; Draws the key world's overview centred on the screen: two tiles per screen, only for visited
; screens, read through the chunk list (wKeyWorldChunks). (C1, E-0357)
RunWorldMapState_DrawOverview_KeyWorld::
    ld a, [wKeyWorldHeight]
    ld c, a
    ld a, [wKeyWorldWidth]
    ld b, a
    call CenteredBGMapOriginForSizeBC
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    ld hl, wVisitedScreens
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    ld a, l
    ldh [hTemp6], a
    ld a, h
    ldh [hTemp7], a
    ld a, [wKeyWorldHeight]
    srl a
    srl a
    ld c, a
    ld a, [wKeyWorldWidth]
    srl a
    srl a
    ld b, a
    ld hl, wKeyWorldChunks

.loop:
    push bc
    push hl

.loop2:
    push bc
    push hl
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
    ld e, a
    ldh a, [hTemp5]
    ld d, a
    ld a, [de]
    call RunWorldMapState_DrawOverview_KeyWorldCell
    call RunWorldMapState_DrawOverview_KeyWorldCell
    call RunWorldMapState_DrawOverview_KeyWorldCell
    call RunWorldMapState_DrawOverview_KeyWorldCell
    push af
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, $1c
    add e
    ld e, a
    jr nc, .set_temp0
    inc d

.set_temp0:
    ld a, e
    ldh [hTemp0], a
    ld a, d
    ldh [hTemp1], a
    pop af
    call RunWorldMapState_DrawOverview_KeyWorldCell
    call RunWorldMapState_DrawOverview_KeyWorldCell
    call RunWorldMapState_DrawOverview_KeyWorldCell
    call RunWorldMapState_DrawOverview_KeyWorldCell
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, $1c
    add e
    ld e, a
    jr nc, .set_temp02
    inc d

.set_temp02:
    ld a, e
    ldh [hTemp0], a
    ld a, d
    ldh [hTemp1], a
    ldh a, [hTemp4]
    ld e, a
    ldh a, [hTemp5]
    ld d, a
    inc de
    ld a, e
    ldh [hTemp4], a
    ld a, d
    ldh [hTemp5], a
    ld a, [de]
    call RunWorldMapState_DrawOverview_KeyWorldCell
    call RunWorldMapState_DrawOverview_KeyWorldCell
    call RunWorldMapState_DrawOverview_KeyWorldCell
    call RunWorldMapState_DrawOverview_KeyWorldCell
    push af
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, $1c
    add e
    ld e, a
    jr nc, .set_temp03
    inc d

.set_temp03:
    ld a, e
    ldh [hTemp0], a
    ld a, d
    ldh [hTemp1], a
    pop af
    call RunWorldMapState_DrawOverview_KeyWorldCell
    call RunWorldMapState_DrawOverview_KeyWorldCell
    call RunWorldMapState_DrawOverview_KeyWorldCell
    call RunWorldMapState_DrawOverview_KeyWorldCell
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, $1c
    add e
    ld e, a
    jr nc, .set_temp04
    inc d

.set_temp04:
    ld a, e
    ldh [hTemp0], a
    ld a, d
    ldh [hTemp1], a
    ldh a, [hTemp4]
    ld e, a
    ldh a, [hTemp5]
    ld d, a
    inc de
    ld a, e
    ldh [hTemp4], a
    ld a, d
    ldh [hTemp5], a
    ld a, [de]
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, e
    sub $7c
    ld e, a
    ld a, d
    sbc $00
    ld d, a
    ld a, e
    ldh [hTemp0], a
    ld a, d
    ldh [hTemp1], a
    pop hl
    ld a, $04
    add_a_to_hl
    pop bc
    dec b
    jp nz, .loop2
    ldh a, [hTemp2]
    ld e, a
    ldh a, [hTemp3]
    ld d, a
    ld a, $80
    add e
    ld e, a
    jr nc, .set_temp2
    inc d

.set_temp2:
    ld a, e
    ldh [hTemp2], a
    ld a, d
    ldh [hTemp3], a
    ld a, e
    ldh [hTemp0], a
    ld a, d
    ldh [hTemp1], a
    ldh a, [hTemp6]
    ld e, a
    ldh a, [hTemp7]
    ld d, a
    ld a, e
    add $04
    ld e, a
    ld a, d
    adc $00
    ld d, a
    ld a, e
    ldh [hTemp4], a
    ld a, d
    ldh [hTemp5], a
    ld a, e
    ldh [hTemp6], a
    ld a, d
    ldh [hTemp7], a
    pop hl
    ld a, $08
    add_a_to_hl
    pop bc
    dec c
    jp nz, .loop
    ld hl, vTiles1
    ld b, $58

.loop3:
    ld a, $ff
    call WriteVRAMByteInc
    xor a
    call WriteVRAMByteInc
    dec b
    jr nz, .loop3
    ld de, wNameGlyphBuf
    ld a, [wCurrentKeyIndex]
    call WriteKeyNameToDE
    call RunWorldMapState_CenterNameGlyphBuf
    ld de, vTiles1
    call CopyGlyphTilesToVRAM
    ld e, $80
    ld hl, vBGMap0 + $204
    ld b, $0b

.loop4:
    ld a, e
    call WriteVRAMByteInc
    inc e
    dec b
    jr nz, .loop4
    ret

; Shifts the next visited bit out of A; when set, draws the chunk's overview tile (its byte 5) at
; hTemp0; steps hTemp0 and the chunk pointer. (C1, E-0357)
RunWorldMapState_DrawOverview_KeyWorldCell::
    sra a
    push af
    jr c, .skip
    ld a, $03
    add_a_to_hl
    ldh a, [hTemp0]
    inc a
    ldh [hTemp0], a
    pop af
    ret

.skip:
    push bc
    push hl
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
    inc de
    inc de
    inc de
    inc de
    inc de
    call ReadByteInBank
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, c
    call WriteVRAMByte
    pop hl
    ld a, $03
    add_a_to_hl
    ldh a, [hTemp0]
    inc a
    ldh [hTemp0], a
    pop bc
    pop af
    ret

; Centers a name in wNameGlyphBuf: counts the glyphs up to the $F0 end byte (the $F0 is counted, the
; dakuten marks $8D and $8E are not), then moves the string right by (13 - that count) / 2 places
; and fills the places before it with the blank glyph $90; nothing moves when that number is 0. HL
; and DE are kept. Called by RunWorldMapState_DrawOverview_Region and
; RunWorldMapState_DrawOverview_KeyWorld. (C2, E-0385)
; counts the characters of wNameGlyphBuf (not the dakuten marks) and shifts it to center it in 13
; tiles
RunWorldMapState_CenterNameGlyphBuf::
    push hl
    push de
    ld hl, wNameGlyphBuf
    ld bc, $0000

.loop:
    inc b
    ld a, [hli]
    cp $8d
    jr z, .loop
    cp $8e
    jr z, .loop
    inc c
    cp $f0
    jr z, .skip
    jr .loop

.skip:
    ld a, $0d
    sub c
    srl a
    jr z, .done
    ld c, b
    ld b, a
    ld a, c
    add b
    ld de, wNameGlyphBuf
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, c
    ld hl, wNameGlyphBuf
    add_a_to_hl
    inc c

.loop2:
    ld a, [hl]
    ld [de], a
    dec hl
    dec de
    dec c
    jr nz, .loop2
    ld hl, wNameGlyphBuf

.loop3:
    ld [hl], $90
    inc hl
    dec b
    jr nz, .loop3

.done:
    pop de
    pop hl
    ret

; Draws the region's overview (WorldMapViewTable for wWorldMapRegion: picture and size) centred,
; then clears the name tiles and writes string hMapId + $0A of bank $08 (read as the place name)
; centred under it. (C1, E-0357)
RunWorldMapState_DrawOverview_Region::
    ld a, [wWorldMapRegion]
    add a
    add a
    add a
    ld hl, WorldMapViewTable
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a
    push hl
    push de
    call CenteredBGMapOriginForSizeBC
    pop de
    ld a, $5d
    call CopyRectFromBankToVRAM
    pop hl
    ld hl, vTiles1
    ld b, $58

.loop:
    ld a, $ff
    call WriteVRAMByteInc
    xor a
    call WriteVRAMByteInc
    dec b
    jr nz, .loop
    ldh a, [hMapId]
    add $0a
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    ld de, wNameGlyphBuf
    ld a, e
    ld [wStringDestLo], a
    ld a, d
    ld [wStringDestHi], a
    farcall CopyStringToBuffer_Bank08
    call RunWorldMapState_CenterNameGlyphBuf
    ld de, vTiles1
    call CopyGlyphTilesToVRAM
    ld e, $80
    ld hl, vBGMap0 + $204
    ld b, $0b

.loop2:
    ld a, e
    call WriteVRAMByteInc
    inc e
    dec b
    jr nz, .loop2
    ret

; RunWorldMapState_DrawOverview_Region takes entry 8 * wGameMode2Byte44, centres a rectangle of
; these rows and width (CenteredBGMapOriginForSizeBC) and copies it from bank $5D with
; CopyRectFromBankToVRAM; 11 entries whose rectangles are contiguous from $41B9 to $43AE (E-0167,
; C1)
; record: tile rectangle in bank $5D; rows, width; a map number ($20, $30, $48 ...) and three zero
; bytes; not read here
WorldMapViewTable::
    dw WorldMapView0 ; id 0: tile rectangle in bank $5D
    db $08, $08 ; rows, width
    db $20, $00, $00, $00 ; a map number ($20, $30, $48 ...) and three zero bytes; not read here
    dw WorldMapView1 ; id 1: tile rectangle in bank $5D
    db $08, $08 ; rows, width
    db $30, $00, $00, $00 ; a map number ($20, $30, $48 ...) and three zero bytes; not read here
    dw WorldMapView2 ; id 2: tile rectangle in bank $5D
    db $0c, $0c ; rows, width
    db $48, $00, $00, $00 ; a map number ($20, $30, $48 ...) and three zero bytes; not read here
    dw WorldMapView3 ; id 3: tile rectangle in bank $5D
    db $0c, $0c ; rows, width
    db $70, $00, $00, $00 ; a map number ($20, $30, $48 ...) and three zero bytes; not read here
    dw WorldMapView4 ; id 4: tile rectangle in bank $5D
    db $03, $04 ; rows, width
    db $a0, $00, $00, $00 ; a map number ($20, $30, $48 ...) and three zero bytes; not read here
    dw WorldMapView5 ; id 5: tile rectangle in bank $5D
    db $06, $06 ; rows, width
    db $a8, $00, $00, $00 ; a map number ($20, $30, $48 ...) and three zero bytes; not read here
    dw WorldMapView6 ; id 6: tile rectangle in bank $5D
    db $02, $03 ; rows, width
    db $b0, $00, $00, $00 ; a map number ($20, $30, $48 ...) and three zero bytes; not read here
    dw WorldMapView7 ; id 7: tile rectangle in bank $5D
    db $05, $05 ; rows, width
    db $b8, $00, $00, $00 ; a map number ($20, $30, $48 ...) and three zero bytes; not read here
    dw WorldMapView8 ; id 8: tile rectangle in bank $5D
    db $02, $01 ; rows, width
    db $c8, $00, $00, $00 ; a map number ($20, $30, $48 ...) and three zero bytes; not read here
    dw WorldMapView9 ; id 9: tile rectangle in bank $5D
    db $02, $01 ; rows, width
    db $d1, $00, $00, $00 ; a map number ($20, $30, $48 ...) and three zero bytes; not read here
    dw WorldMapView10 ; id 10: tile rectangle in bank $5D
    db $01, $02 ; rows, width
    db $da, $00, $00, $00 ; a map number ($20, $30, $48 ...) and three zero bytes; not read here

; Overview goal marker: as RunWorldMapState_GoalMarker, but drawn with DrawCursorSpriteAtTemp1Cell
; at the screen only. (C1, E-0357)
RunWorldMapState_DrawOverviewGoalMarker::
    ld a, [wMapType]
    bit 7, a
    jp nz, .check_key_world_active2
    ldh a, [hMapId]
    ld c, $01
    cp $30
    jr c, .check_key_world_active
    ld c, $02
    cp $48
    jr c, .check_key_world_active
    ld c, $03
    cp $70
    jr c, .check_key_world_active
    ld c, $04
    cp $a0
    jr c, .check_key_world_active
    ld c, $05
    cp $a8
    jr c, .check_key_world_active
    ld c, $06
    cp $b0
    jr c, .check_key_world_active
    ld c, $07
    cp $b8
    jr c, .check_key_world_active
    ld c, $08
    cp $c8
    jr c, .check_key_world_active
    ld c, $09
    cp $d1
    jr c, .check_key_world_active
    ld c, $0a
    cp $da
    jr c, .check_key_world_active
    ld c, $0b

.check_key_world_active:
    ld a, [wKeyWorldActive]
    or a
    jr z, .skip
    ld a, [wKeyWorldKey]
    cp c
    jr nz, .skip
    ld a, [wKeyWorldGoalCell]
    ldh [hTemp1], a
    call DrawCursorSpriteAtTemp1Cell
    ret

.skip:
    ld a, c
    dec a
    sla a
    sla a
    ld hl, WorldMapStartPositions
    add_a_to_hl
    ld a, [hl]
    ldh [hTemp1], a
    call DrawCursorSpriteAtTemp1Cell
    ret

.check_key_world_active2:
    ld a, [wKeyWorldActive]
    or a
    jr z, .read_key_world_goal_screen
    ld a, [wKeyWorldKey]
    bit 7, a
    jr z, .read_key_world_goal_screen
    and $7f
    ld c, a
    ld a, [wKeyWorldSlot]
    cp c
    jr nz, .read_key_world_goal_screen
    ld a, [wKeyWorldGoalCell]
    ldh [hTemp1], a
    call DrawCursorSpriteAtTemp1Cell
    ret

.read_key_world_goal_screen:
    ld a, [wKeyWorldGoalScreen]
    ldh [hTemp1], a
    call DrawCursorSpriteAtTemp1Cell
    ret

; hTemp1 = a screen (high nibble X, low nibble Y): draws metasprite set $26 (tile offset $10,
; attribute XOR 1, sub-index 0) with DrawMetaSprite at hSpriteOriginX = 8 * wCursorCellX + 8 * X and
; hSpriteOriginY = 8 * wCursorCellY + 8 * Y (origin high bytes 0). Called four times by
; RunWorldMapState_DrawOverviewGoalMarker. (C1, E-0385)
; draws metasprite set $26 at X = 8 * (wCursorCellX + 8 * high nibble of hTemp1), Y = 8 *
; (wCursorCellY + 8 * low nibble) (E-0121)
DrawCursorSpriteAtTemp1Cell::
    ldh a, [hTemp1]
    and $f0
    swap a
    sla a
    sla a
    sla a
    ld c, a
    ld a, [wCursorCellX]
    sla a
    sla a
    sla a
    add c
    ldh [hSpriteOriginX], a
    ldh a, [hTemp1]
    and $0f
    sla a
    sla a
    sla a
    ld c, a
    ld a, [wCursorCellY]
    sla a
    sla a
    sla a
    add c
    ldh [hSpriteOriginY], a
    ld a, $10
    ldh [hSpriteTileOffset], a
    ld a, $01
    ldh [hSpriteAttrXor], a
    ld a, $26
    ldh [hSpriteSetIndex], a
    xor a
    ldh [hSpriteSubIndex], a
    xor a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite
    ret

; The blinking player marker on the overview (shown while frame counter bit 5 is set): on an
; entrance map at the region start or the active key's goal; on maps $20, $30, ... $DA at the
; player's own screen; elsewhere from WorldMapCursorCellTable (the second position when the last
; warp was 2). (C1, E-0357)
RunWorldMapState_DrawOverviewPlayerMarker::
    ld a, [wFrameCounterLo]
    bit 5, a
    ret z
    ld a, [wMapType]
    bit 7, a
    jp nz, RunWorldMapState_WaitFrameCounterLo_KeyWorldMarker
    ldh a, [hMapId]
    ld c, $01
    cp $29
    jp z, RunWorldMapState_WaitFrameCounterLo_GoalMarker
    ld c, $02
    cp $45
    jp z, RunWorldMapState_WaitFrameCounterLo_GoalMarker
    ld c, $03
    cp $68
    jp z, RunWorldMapState_WaitFrameCounterLo_GoalMarker
    ld c, $04
    cp $9d
    jp z, RunWorldMapState_WaitFrameCounterLo_GoalMarker
    ld c, $05
    cp $a4
    jp z, RunWorldMapState_WaitFrameCounterLo_GoalMarker
    ld c, $06
    cp $af
    jp z, RunWorldMapState_WaitFrameCounterLo_GoalMarker
    ld c, $07
    cp $b2
    jp z, RunWorldMapState_WaitFrameCounterLo_GoalMarker
    ld c, $08
    cp $c5
    jr z, RunWorldMapState_WaitFrameCounterLo_GoalMarker
    ld c, $09
    cp $d0
    jr z, RunWorldMapState_WaitFrameCounterLo_GoalMarker
    ld c, $0a
    cp $d9
    jr z, RunWorldMapState_WaitFrameCounterLo_GoalMarker
    ld c, $0b
    cp $e2
    jr z, RunWorldMapState_WaitFrameCounterLo_GoalMarker
    cp $20
    jr z, SetSpriteYFromCursorCellY_PlayerMarker
    cp $30
    jr z, SetSpriteYFromCursorCellY_PlayerMarker
    cp $48
    jr z, SetSpriteYFromCursorCellY_PlayerMarker
    cp $70
    jr z, SetSpriteYFromCursorCellY_PlayerMarker
    cp $a0
    jr z, SetSpriteYFromCursorCellY_PlayerMarker
    cp $a8
    jr z, SetSpriteYFromCursorCellY_PlayerMarker
    cp $b0
    jr z, SetSpriteYFromCursorCellY_PlayerMarker
    cp $b8
    jr z, SetSpriteYFromCursorCellY_PlayerMarker
    cp $c8
    jr z, SetSpriteYFromCursorCellY_PlayerMarker
    cp $d1
    jr z, SetSpriteYFromCursorCellY_PlayerMarker
    cp $da
    jr z, SetSpriteYFromCursorCellY_PlayerMarker
    ld c, a
    ld hl, WorldMapCursorCellTable

.skip:
    ld a, [hl]
    cp c
    jr z, .check_last_warp_index
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr .skip

.check_last_warp_index:
    ld a, [wLastWarpIndex]
    dec a
    dec a
    jr nz, .call_set_sprite_x_from_cursor_cell_x
    inc hl
    inc hl

.call_set_sprite_x_from_cursor_cell_x:
    inc hl
    ld a, [hli]
    call SetSpriteXFromCursorCellX
    ld a, [hl]
    call SetSpriteYFromCursorCellY
    call DrawMetaSpriteSet08
    ret

; Draws the overview player marker at the player's screen (hMapScreenX, hMapScreenY). (C1, E-0357)
SetSpriteYFromCursorCellY_PlayerMarker::
    ldh a, [hMapScreenX]
    sla a
    sla a
    sla a
    call SetSpriteXFromCursorCellX
    ldh a, [hMapScreenY]
    sla a
    sla a
    sla a
    call SetSpriteYFromCursorCellY
    call DrawMetaSpriteSet08
    ret

; C = 1-11, the entrance map number the parent picked from hMapId: when wKeyWorldActive is non-zero
; and wKeyWorldKey equals C, draws the blinking overview marker (DrawMetaSpriteSet08) at the cell in
; wKeyWorldGoalCell, otherwise at the cell in wKeyWorldGoalScreen (high nibble = column, low nibble
; = row, 8 pixels each). (C1, E-0371)
RunWorldMapState_WaitFrameCounterLo_GoalMarker::
    ld a, [wKeyWorldActive]
    or a
    jr z, .check_key_world_goal_screen
    ld a, [wKeyWorldKey]
    cp c
    jr nz, .check_key_world_goal_screen
    ld a, [wKeyWorldGoalCell]
    and $f0
    swap a
    add a
    add a
    add a
    call SetSpriteXFromCursorCellX
    ld a, [wKeyWorldGoalCell]
    and $0f
    add a
    add a
    add a
    call SetSpriteYFromCursorCellY
    call DrawMetaSpriteSet08
    ret

.check_key_world_goal_screen:
    ld a, [wKeyWorldGoalScreen]
    and $f0
    swap a
    add a
    add a
    add a
    call SetSpriteXFromCursorCellX
    ld a, [wKeyWorldGoalScreen]
    and $0f
    add a
    add a
    add a
    call SetSpriteYFromCursorCellY
    call DrawMetaSpriteSet08
    ret

; A = an X offset in pixels: hSpriteOriginX = 8 * wCursorCellX + A + 6 (8 bits). A and C are
; clobbered. Used by the overview and close-up marker routines such as
; RunWorldMapState_DrawOverviewPlayerMarker. (C2, E-0385)
; hSpriteOriginX = 8 * wCursorCellX + A + 6 (E-0122)
SetSpriteXFromCursorCellX::
    ld c, a
    ld a, [wCursorCellX]
    sla a
    sla a
    sla a
    add c
    add $06
    ldh [hSpriteOriginX], a
    ret

; A = a Y offset in pixels: hSpriteOriginY = 8 * wCursorCellY + A + 6 (8 bits). A and C are
; clobbered. Used by the overview and close-up marker routines such as
; RunWorldMapState_DrawOverviewPlayerMarker. (C2, E-0385)
; hSpriteOriginY = 8 * wCursorCellY + A + 6; the next entry dispatches on wMapType & 7 (E-0124)
SetSpriteYFromCursorCellY::
    ld c, a
    ld a, [wCursorCellY]
    sla a
    sla a
    sla a
    add c
    add $06
    ldh [hSpriteOriginY], a
    ret

; In a key world, places the player marker by map type (wMapType & 7). (C1, E-0357)
RunWorldMapState_WaitFrameCounterLo_KeyWorldMarker::
    ld a, [wMapType]
    and $07
    jumptable
    dw SetSpriteYFromCursorCellY_PlayerMarker
    dw SetSpriteYFromCursorCellY_ExitMarker
    dw SetSpriteYFromCursorCellY_ExitMarker
    dw SetSpriteYFromCursorCellY_FloorMarker
    dw SetSpriteYFromCursorCellY_FloorMarker
    dw SetSpriteYFromCursorCellY_FloorMarker
    dw SetSpriteYFromCursorCellY_FloorMarker
    dw SetSpriteYFromCursorCellY_GoalMarker

; Map types 1 and 2: the marker at the current floor's exit screen. (C1, E-0357)
SetSpriteYFromCursorCellY_ExitMarker::
    ld a, [wKeyWorldFloor]
    and $07
    sla a
    sla a
    ld hl, wKeyWorldAreaExits
    add_a_to_hl
    ld a, [wKeyWorldFloor]
    bit 7, a
    jr z, .call_set_sprite_xy_from_cell_a
    inc hl

.call_set_sprite_xy_from_cell_a:
    ld a, [hl]
    call SetSpriteXYFromCellA
    ret

; Map types 3 to 6: the marker at the current floor's screen from wKeyWorldFloorInfo. (C1, E-0357)
SetSpriteYFromCursorCellY_FloorMarker::
    ld a, [wKeyWorldFloor]
    and $07
    add a
    add a
    ld hl, wKeyWorldFloorInfo
    add_a_to_hl
    ld a, [hl]
    call SetSpriteXYFromCellA
    ret

; Map type 7: the marker at the goal cell when the active key's slot matches, otherwise at the goal
; screen. (C1, E-0357)
SetSpriteYFromCursorCellY_GoalMarker::
    ld a, [wKeyWorldActive]
    or a
    jr z, .read_key_world_goal_screen
    ld a, [wKeyWorldKey]
    bit 7, a
    jr z, .read_key_world_goal_screen
    and $7f
    ld c, a
    ld a, [wKeyWorldSlot]
    cp c
    jr nz, .read_key_world_goal_screen
    ld a, [wKeyWorldGoalCell]
    call SetSpriteXYFromCellA
    ret

.read_key_world_goal_screen:
    ld a, [wKeyWorldGoalScreen]
    call SetSpriteXYFromCellA
    ret

; A = a screen (high nibble X, low nibble Y): hSpriteOriginX = 8 * wCursorCellX + 8 * X + 6 and
; hSpriteOriginY = 8 * wCursorCellY + 8 * Y + 6; it has no return of its own and falls into
; DrawMetaSpriteSet08, so it also draws metasprite set 8 there. Called by the key-world marker
; routines such as SetSpriteYFromCursorCellY_ExitMarker. (C1, E-0385)
; hSpriteOriginX = 8 * wCursorCellX + (A >> 4) * 8 + 6 and hSpriteOriginY = 8 * wCursorCellY + (A &
; $0F) * 8 + 6 (E-0124)
SetSpriteXYFromCellA::
    push af
    and $f0
    srl a
    ld c, a
    ld a, [wCursorCellX]
    sla a
    sla a
    sla a
    add c
    add $06
    ldh [hSpriteOriginX], a
    pop af
    and $0f
    sla a
    sla a
    sla a
    ld c, a
    ld a, [wCursorCellY]
    sla a
    sla a
    sla a
    add c
    add $06
    ldh [hSpriteOriginY], a

; Calls DrawMetaSprite (far) for metasprite set $08, sub-index 0, no tile offset, no attribute
; change and origin high bytes 0, at the position left in hSpriteOriginX and hSpriteOriginY by the
; caller. Called by RunWorldMapState_DrawOverviewPlayerMarker and other marker routines, and entered
; by falling through from SetSpriteXYFromCellA. (C1, E-0385)
; DrawMetaSprite with set $08, sub-index 0, no tile offset or attribute change (origin high bytes 0)
; (E-0118)
DrawMetaSpriteSet08::
    ld a, $00
    ldh [hSpriteTileOffset], a
    ld a, $00
    ldh [hSpriteAttrXor], a
    ld a, $08
    ldh [hSpriteSetIndex], a
    xor a
    ldh [hSpriteSubIndex], a
    xor a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite
    ret

; Overview markers: the region's list (WorldMapCursorSpriteLists: a count, then x and y) with set
; $26; in a key world the floor list, only for visited screens unless the field skill shows
; everything. (C1, E-0357)
RunWorldMapState_DrawOverviewMarkers::
    ld a, [wMapType]
    bit 7, a
    jr nz, .skip
    ld a, [wWorldMapRegion]
    add a
    ld hl, WorldMapCursorSpriteLists
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, [de]
    or a
    ret z
    inc de
    ld b, a

.loop:
    push bc
    push de
    ld a, [de]
    ld c, a
    ld a, [wCursorCellX]
    add a
    add a
    add a
    add c
    ldh [hSpriteOriginX], a
    inc de
    ld a, [de]
    ld c, a
    ld a, [wCursorCellY]
    add a
    add a
    add a
    add c
    ldh [hSpriteOriginY], a
    call DrawMetaSpriteSet26
    pop de
    inc de
    inc de
    pop bc
    dec b
    jr nz, .loop
    ret

.skip:
    ld de, wKeyWorldFloorInfo + $3

.skip2:
    ld a, [de]
    cp $ff
    ret z
    push de
    dec de
    dec de
    dec de
    ld a, [de]
    ld a, [wWorldMapByFieldSkill]
    or a
    jr nz, .skip3
    ld a, [de]
    call IsMapScreenAVisited
    or a
    jr z, .restore

.skip3:
    ld a, [de]
    swap a
    and $0f
    add a
    add a
    add a
    ld c, a
    ld a, [wCursorCellX]
    add a
    add a
    add a
    add c
    ldh [hSpriteOriginX], a
    ld a, [de]
    and $0f
    add a
    add a
    add a
    ld c, a
    ld a, [wCursorCellY]
    add a
    add a
    add a
    add c
    ldh [hSpriteOriginY], a
    call DrawMetaSpriteSet26

.restore:
    pop de
    ld a, $04
    add e
    ld e, a
    jr nc, .skip4
    inc d

.skip4:
    jr .skip2

; Calls DrawMetaSprite (far) for metasprite set $26, sub-index 0, tile offset $10, attribute XOR 1
; and origin high bytes 0, at the position left in hSpriteOriginX and hSpriteOriginY by the caller.
; Called twice by RunWorldMapState_DrawOverviewMarkers. (C1, E-0385)
; DrawMetaSprite with set $26, sub-index 0, tile offset $10, attribute XOR $01 (origin high bytes 0)
; (E-0118)
DrawMetaSpriteSet26::
    ld a, $10
    ldh [hSpriteTileOffset], a
    ld a, $01
    ldh [hSpriteAttrXor], a
    ld a, $26
    ldh [hSpriteSetIndex], a
    xor a
    ldh [hSpriteSubIndex], a
    xor a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite
    ret

; Returns at once unless wMapType bit 7 is set (a key world). Otherwise walks the 4-byte key-world
; object entries: DE starts at wKeyWorldObjects and the walk ends when [DE] is $FF; for each entry
; it calls RunWorldMapState_DrawVisitedScreenMarker on the bytes 3 and 2 before DE, then advances DE
; by 4. Called by RunWorldMapState_OverviewInput (the overview step) after the player marker and
; RunWorldMapState_DrawOverviewMarkers. (C1, E-0371)
RunWorldMapState_DrawKeyWorldObjectMarkers::
    ld a, [wMapType]
    bit 7, a
    ret z
    ld de, wKeyWorldObjects

.skip:
    ld a, [de]
    cp $ff
    ret z
    push de
    dec de
    dec de
    dec de
    call RunWorldMapState_DrawVisitedScreenMarker
    inc de
    call RunWorldMapState_DrawVisitedScreenMarker
    pop de
    ld a, $04
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    jr .skip

; DE = address of a key-world screen byte (high nibble = column, low nibble = row): unless
; wWorldMapByFieldSkill is set, returns when IsMapScreenAVisited says the screen was not visited;
; otherwise draws overview metasprite set $26 (tile offset $10, attribute XOR 1) at X = 8 *
; (wCursorCellX + column), Y = 8 * (wCursorCellY + row) through DrawMetaSprite. DE is kept. (C1,
; E-0371)
RunWorldMapState_DrawVisitedScreenMarker::
    ld a, [wWorldMapByFieldSkill]
    or a
    jr nz, .skip
    ld a, [de]
    call IsMapScreenAVisited
    or a
    ret z

.skip:
    ld a, [de]
    swap a
    and $0f
    add a
    add a
    add a
    ld c, a
    ld a, [wCursorCellX]
    add a
    add a
    add a
    add c
    ldh [hSpriteOriginX], a
    ld a, [de]
    and $0f
    add a
    add a
    add a
    ld c, a
    ld a, [wCursorCellY]
    add a
    add a
    add a
    add c
    ldh [hSpriteOriginY], a
    ld a, $10
    ldh [hSpriteTileOffset], a
    ld a, $01
    ldh [hSpriteAttrXor], a
    ld a, $26
    ldh [hSpriteSetIndex], a
    xor a
    ldh [hSpriteSubIndex], a
    xor a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    push de
    farcall DrawMetaSprite
    pop de
    ret

; B = width, C = rows of a block of tiles: wCursorCellY = 9 - C / 2, wCursorCellX = 10 - B / 2 and
; HL = vBGMap0 + 32 * row + column, the address of the top-left tile of the block when it is
; centered on the 20 x 18 tile screen. A and E are clobbered. Called by
; RunWorldMapState_DrawOverview_Region and RunWorldMapState_DrawOverview_KeyWorld. (C2, E-0385)
; row = 9 - C/2 (wCursorCellY), column = 10 - B/2 (wCursorCellX); HL = vBGMap0 + 32 * row + column
; (E-0121)
CenteredBGMapOriginForSizeBC::
    ld a, c
    srl a
    ld l, a
    ld a, $09
    sub l
    ld [wCursorCellY], a
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $98
    ld h, a
    ld a, b
    srl a
    ld e, a
    ld a, $0a
    sub e
    ld [wCursorCellX], a
    add_a_to_hl
    ret

; Fills the $400 bytes of vBGMap0 (the whole 32 x 32 map) with tile $57 using WriteVRAMByteInc. A,
; BC, HL are clobbered. Called by RunWorldMapState_DrawCloseUp before the map is drawn. (C1, E-0385)
; fills the $400 bytes of vBGMap0 with tile $57 (E-0122)
FillBGMap0With57::
    ld hl, vBGMap0
    ld bc, $0400

.loop:
    ld a, $57
    call WriteVRAMByteInc
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ret

; On CGB, clears all BG map attributes (VRAM bank 1) to 0. (C1, E-0357)
RunWorldMapState_DrawCloseUp_ClearAttributes::
    ld a, [wIsCGB]
    or a
    ret z
    ld c, $4f
    ld a, $01
    ldh [c], a
    ld hl, vBGMap0
    ld bc, $0400

.loop:
    xor a
    call WriteVRAMByteInc
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld c, $4f
    ld a, $00
    ldh [c], a
    ret

; On CGB, sets all BG map attributes to palette 1, then the 12 x 12 map area (from row 3, column 4)
; to palette 0. (C1, E-0357)
RunWorldMapState_DrawOverview_SetAttributes::
    ld a, [wIsCGB]
    or a
    ret z
    ld c, $4f
    ld a, $01
    ldh [c], a
    ld hl, vBGMap0
    ld bc, $0400

.loop:
    ld a, $01
    call WriteVRAMByteInc
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld hl, vBGMap0 + $64
    ld c, $0c

.loop2:
    push hl
    ld b, $0c

.loop3:
    xor a
    call WriteVRAMByte
    inc hl
    dec b
    jr nz, .loop3
    pop hl
    ld a, $20
    add_a_to_hl
    dec c
    jr nz, .loop2
    ld c, $4f
    ld a, $00
    ldh [c], a
    ret

; Copies the 12 x 12 tile block DrawRect12x12FromBankA1_TileRect (all 144 tiles are $34) from bank
; $A1 to vBGMap0 + $64 (row 3, column 4) with CopyRectFromBankToVRAM (B = 12 wide, C = 12 rows, A =
; the bank $A1). Called by RunWorldMapState_DrawOverview after it copies the frame. (C1, E-0385)
; copies a 12 x 12 tile rectangle from A1:$5808 to vBGMap0 + $64 (CopyRectFromBankToVRAM) (E-0116)
DrawRect12x12FromBankA1::
    ld de, DrawRect12x12FromBankA1_TileRect
    lb bc, $0c, $0c
    ld hl, vBGMap0 + $64
    ld a, $a1
    call CopyRectFromBankToVRAM
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 12 x 12 tiles, one row per line
DrawRect12x12FromBankA1_TileRect::
    db $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34 ; id 0
    db $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34 ; id 1
    db $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34 ; id 2
    db $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34 ; id 3
    db $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34 ; id 4
    db $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34 ; id 5
    db $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34 ; id 6
    db $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34 ; id 7
    db $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34 ; id 8
    db $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34 ; id 9
    db $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34 ; id 10
    db $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34, $34 ; id 11

; Sets wFieldInitStage to 3 and wDataBankSave to $40, far-calls InitFieldScreen, sets the three DMG
; palette bytes from wDMGPaletteBGP to $D2, $D2, $E2 and wGameMode to 1. Called by
; RunWorldMapState_ReturnToField when the world map closes. (C1, E-0385)
; wFieldInitStage = 3, wDataBankSave = $40, far-calls InitFieldScreen, sets the default DMG palette
; bytes ($D2, $D2, $E2) and wGameMode = 1 (E-0118)
EnterGameMode1WithDefaultPalettes::
    ld a, $03
    ld [wFieldInitStage], a
    ld a, $40
    ld [wDataBankSave], a
    farcall InitFieldScreen
    ld hl, wDMGPaletteBGP
    ld a, $d2
    ld [hli], a
    ld a, $d2
    ld [hli], a
    ld a, $e2
    ld [hl], a
    ld a, $01
    ld [wGameMode], a
    ret

; A = a screen (high nibble X, low nibble Y): A = 1 when its bit is set in the 8-byte map
; wVisitedScreens (byte 4 * (Y / 4) + 2 * (X / 4) + ((Y / 2) and 1), bit (X and 3) + 4 * (Y and 1)),
; else 0. BC and HL are kept; hTemp0 is clobbered. Called by the world map marker and close-up
; routines such as RunWorldMapState_DrawRegionMarkers and RunWorldMapState_DrawVisitedScreenMarker.
; (C2, E-0385)
; A = 1 when the bit for screen A (high nibble x, low nibble y) is set in wVisitedScreens, else 0
; (E-0125)
IsMapScreenAVisited::
    push bc
    push hl
    ldh [hTemp0], a
    and $0f
    and $fc
    ld hl, wVisitedScreens
    add_a_to_hl
    ldh a, [hTemp0]
    swap a
    and $0f
    srl a
    and $fe
    add_a_to_hl
    ldh a, [hTemp0]
    bit 1, a
    jr z, .skip
    inc hl

.skip:
    ld c, $01
    bit 0, a
    jr z, .read_temp0
    ld c, $10

.read_temp0:
    ldh a, [hTemp0]
    swap a
    and $03
    jr z, .skip2
    ld b, a

.loop:
    sla c
    dec b
    jr nz, .loop

.skip2:
    ld a, [hl]
    and c
    jr nz, .skip3
    xor a
    pop hl
    pop bc
    ret

.skip3:
    ld a, $01
    pop hl
    pop bc
    ret

; Called by FieldState_WalkATalks and FieldState_WalkAMenu when Select is newly pressed. Sets hTemp0
; to 0 and returns without opening the map unless no fade runs (wFadeState 0), the text window is
; closed (wTextWindowState bits 0-1 clear), wFieldActionRequest bit 7 is clear and hPlayerStateFlags
; bit 0 is clear. In a key world (wMapType bit 7) it goes on at once; on other maps below $20 it
; returns; from map $20 up it sets wWorldMapRegion to 0-10 by the hMapId bands $20-$2F, $30-$47,
; $48-$6F, $70-$9F, $A0-$A7, $A8-$AF, $B0-$B7, $B8-$C7, $C8-$D0, $D1-$D9 and $DA up. Opening the map
; sets hTemp0 to 1, wFieldReturnPhase to 1, saves the screen buffer (SaveScreenBufferToBGMap1), sets
; wModeState to 8 (field state 8) and wWorldMapState to 0 (open at the overview) for a $80 key world
; or for the first map of a band ($20, $30, $48, $70, $A0, $A8, $B0, $B8, $C8, $D1, $DA), otherwise
; to 3 (open at the close-up). (C1, E-0385)
; Select in field states 0 and 5: unless a fade, the text window, a field action or the player state
; blocks it, sets hTemp0 = 1 in a key world (bit 7 of wMapType); on maps $20 and up stores the map's
; region in wWorldMapRegion and opens the world map (C2 from E-0339: on map $30 it shows the Water
; region; was TryOpenWorldMap)
TryOpenWorldMap::
    xor a
    ldh [hTemp0], a
    ld a, [wFadeState]
    or a
    ret nz
    ld a, [wTextWindowState]
    and $03
    ret nz
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ldh a, [hPlayerStateFlags]
    bit 0, a
    ret nz
    ld a, [wMapType]
    bit 7, a
    jp nz, .set_temp0_to_01
    ldh a, [hMapId]
    cp $20
    ret c
    ld c, $00
    cp $30
    jr c, .set_world_map_region
    inc c
    cp $48
    jr c, .set_world_map_region
    inc c
    cp $70
    jr c, .set_world_map_region
    inc c
    cp $a0
    jr c, .set_world_map_region
    inc c
    cp $a8
    jr c, .set_world_map_region
    inc c
    cp $b0
    jr c, .set_world_map_region
    inc c
    cp $b8
    jr c, .set_world_map_region
    inc c
    cp $c8
    jr c, .set_world_map_region
    inc c
    cp $d1
    jr c, .set_world_map_region
    inc c
    cp $da
    jr c, .set_world_map_region
    inc c

.set_world_map_region:
    ld a, c
    ld [wWorldMapRegion], a
    ld a, $01
    ldh [hTemp0], a
    ld a, $01
    ld [wFieldReturnPhase], a
    farcall SaveScreenBufferToBGMap1
    ld a, $08
    ld [wModeState], a
    ldh a, [hMapId]
    cp $20
    jr z, .clear_world_map_state
    cp $30
    jr z, .clear_world_map_state
    cp $48
    jr z, .clear_world_map_state
    cp $70
    jr z, .clear_world_map_state
    cp $a0
    jr z, .clear_world_map_state
    cp $a8
    jr z, .clear_world_map_state
    cp $b0
    jr z, .clear_world_map_state
    cp $b8
    jr z, .clear_world_map_state
    cp $c8
    jr z, .clear_world_map_state
    cp $d1
    jr z, .clear_world_map_state
    cp $da
    jr z, .clear_world_map_state
    ld a, $03
    ld [wWorldMapState], a
    ret

.clear_world_map_state:
    xor a
    ld [wWorldMapState], a
    ret

.set_temp0_to_01:
    ld a, $01
    ldh [hTemp0], a
    ld a, $01
    ld [wFieldReturnPhase], a
    farcall SaveScreenBufferToBGMap1
    ld a, $08
    ld [wModeState], a
    ld a, [wMapType]
    and $7f
    jr nz, .set_world_map_state_to_03
    xor a
    ld [wWorldMapState], a
    ret

.set_world_map_state_to_03:
    ld a, $03
    ld [wWorldMapState], a
    ret
    db $01, $01

; RunWorldMapState_FindPlayerScreen.skip2 reads the record at $59D6 + 4 * wGameMode2Byte44 with
; LoadMapPositionFromHL (hMapScreenX/Y, hPlayerX/Y from nibbles); 11 indexes, so record 10's first
; two bytes are the tail and its other two would be WorldMapCursorSpriteLists' first word (E-0215,
; C1)
; record: screen X/Y and position X/Y nibbles; two bytes not read here
WorldMapStartPositions::
    db $00, $44, $39, $31 ; id 0
    db $76, $44, $59, $21 ; id 1
    db $b4, $44, $59, $21 ; id 2
    db $b4, $44, $09, $01 ; id 3
    db $10, $44, $01, $01 ; id 4
    db $00, $44, $01, $09 ; id 5
    db $01, $44, $21, $21 ; id 6
    db $44, $44, $01, $09 ; id 7
    db $01, $44, $01, $01 ; id 8
    db $00, $44, $01, $01 ; id 9
    db $00, $44 ; end

; RunWorldMapState_DrawOverviewMarkers reads word wGameMode2Byte44 and draws DrawMetaSpriteSet26
; once per entry at wCursorCellX * 8 + X, wCursorCellY * 8 + Y; the lists run to $5A49 (E-0215, C1)
; record: list
WorldMapCursorSpriteLists::
    dw WorldMapCursorSprites000 ; id 0
    dw WorldMapCursorSprites001 ; id 1
    dw WorldMapCursorSprites002 ; id 2
    dw WorldMapCursorSprites003 ; id 3
    dw WorldMapCursorSprites004 ; id 4
    dw WorldMapCursorSprites005 ; id 5
    dw WorldMapCursorSprites006 ; id 6
    dw WorldMapCursorSprites007 ; id 7
    dw WorldMapCursorSprites008 ; id 8
    dw WorldMapCursorSprites009 ; id 9
    dw WorldMapCursorSprites00A ; id 10

; list for entry $00 of WorldMapCursorSpriteLists; it runs to the next list (E-0199)
; record: count, then an X offset and a Y offset (from the cursor cell) per sprite
WorldMapCursorSprites000::
    db $02, $11, $09, $11, $29 ; id 0

; list for entry $01 of WorldMapCursorSpriteLists; it runs to the next list (E-0199)
WorldMapCursorSprites001::
    db $03, $29, $31, $21, $11, $11, $21 ; id 0

; list for entry $02 of WorldMapCursorSpriteLists; it runs to the next list (E-0199)
WorldMapCursorSprites002::
    db $05, $41, $11, $39, $29, $21, $41, $11, $49, $49, $49 ; id 0

; list for entry $03 of WorldMapCursorSpriteLists; it runs to the next list (E-0199)
WorldMapCursorSprites003::
    db $03, $59, $09, $29, $31, $29, $49 ; id 0

; list for entry $04 of WorldMapCursorSpriteLists; it runs to the next list (E-0199)
; record: count, then an X offset and a Y offset (from the cursor cell) per sprite
WorldMapCursorSprites004::
    db $00 ; id 0

; list for entry $05 of WorldMapCursorSpriteLists; it runs to the next list (E-0199)
WorldMapCursorSprites005::
    db $01, $11, $21 ; id 0

; list for entry $06 of WorldMapCursorSpriteLists; it runs to the next list (E-0199)
WorldMapCursorSprites006::
    db $01, $09, $01 ; id 0

; list for entry $07 of WorldMapCursorSpriteLists; it runs to the next list (E-0199)
WorldMapCursorSprites007::
    db $02, $21, $19, $09, $09 ; id 0

; list for entry $08 of WorldMapCursorSpriteLists; it runs to the next list (E-0199)
; record: count, then an X offset and a Y offset (from the cursor cell) per sprite
WorldMapCursorSprites008::
    db $01, $01, $01 ; id 0

; list for entry $09 of WorldMapCursorSpriteLists; it runs to the next list (E-0199)
WorldMapCursorSprites009::
    db $01, $01, $09 ; id 0

; list for entry $0A of WorldMapCursorSpriteLists; it runs to the next list (E-0199)
WorldMapCursorSprites00A::
    db $01, $09, $01 ; id 0

; RunWorldMapState_DrawRegionMarkers reads word wGameMode2Byte44 and walks count entries of two
; bytes; the lists run to $5A92 (E-0215, C1)
; record: list
WorldMapMarkerLists::
    dw WorldMapMarkers000 ; id 0
    dw WorldMapMarkers001 ; id 1
    dw WorldMapMarkers002 ; id 2
    dw WorldMapMarkers003 ; id 3
    dw WorldMapMarkers004 ; id 4
    dw WorldMapMarkers005 ; id 5
    dw WorldMapMarkers006 ; id 6
    dw WorldMapMarkers007 ; id 7
    dw WorldMapMarkers008 ; id 8
    dw WorldMapMarkers009 ; id 9
    dw WorldMapMarkers00A ; id 10

; list for entry $00 of WorldMapMarkerLists; it runs to the next list (E-0199)
; record: count, then two bytes (screen / position nibbles) per entry
WorldMapMarkers000::
    db $02, $21, $44, $25, $44 ; id 0

; list for entry $01 of WorldMapMarkerLists; it runs to the next list (E-0199)
WorldMapMarkers001::
    db $03, $56, $44, $42, $44, $24, $44 ; id 0

; list for entry $02 of WorldMapMarkerLists; it runs to the next list (E-0199)
WorldMapMarkers002::
    db $05, $82, $44, $75, $44, $48, $44, $29, $44, $99, $44 ; id 0

; list for entry $03 of WorldMapMarkerLists; it runs to the next list (E-0199)
WorldMapMarkers003::
    db $03, $b1, $44, $56, $64, $59, $44 ; id 0

; list for entry $04 of WorldMapMarkerLists; it runs to the next list (E-0199)
; record: count, then two bytes (screen / position nibbles) per entry
WorldMapMarkers004::
    db $00 ; id 0

; list for entry $05 of WorldMapMarkerLists; it runs to the next list (E-0199)
WorldMapMarkers005::
    db $01, $24, $44 ; id 0

; list for entry $06 of WorldMapMarkerLists; it runs to the next list (E-0199)
WorldMapMarkers006::
    db $01, $10, $44 ; id 0

; list for entry $07 of WorldMapMarkerLists; it runs to the next list (E-0199)
WorldMapMarkers007::
    db $02, $43, $44, $11, $35 ; id 0

; list for entry $08 of WorldMapMarkerLists; it runs to the next list (E-0199)
; record: count, then two bytes (screen / position nibbles) per entry
WorldMapMarkers008::
    db $01, $00, $44 ; id 0

; list for entry $09 of WorldMapMarkerLists; it runs to the next list (E-0199)
WorldMapMarkers009::
    db $01, $01, $44 ; id 0

; list for entry $0A of WorldMapMarkerLists; it runs to the next list (E-0199)
WorldMapMarkers00A::
    db $01, $10, $44 ; id 0

; SetSpriteYFromCursorCellY's path scans 5-byte records from $5A92 for the current map id (no
; terminator) and takes bytes 1-2, or 3-4 when wLastWarpIndex = 2; 150 records, map ids rising, end
; exactly at WorldMapScreenPositionTable (E-0215, C1)
; record: map id; cursor cell X, Y; second X, Y used when wLastWarpIndex = 2
WorldMapCursorCellTable::
    db $21, $11, $09, $00, $00 ; id 0
    db $22, $11, $09, $00, $00 ; id 1
    db $23, $11, $29, $00, $00 ; id 2
    db $24, $11, $29, $00, $00 ; id 3
    db $25, $11, $29, $00, $00 ; id 4
    db $26, $11, $29, $00, $00 ; id 5
    db $28, $29, $29, $00, $00 ; id 6
    db $2a, $11, $09, $00, $00 ; id 7
    db $2b, $11, $09, $11, $29 ; id 8
    db $2d, $11, $29, $00, $00 ; id 9
    db $2e, $11, $29, $00, $00 ; id 10
    db $2f, $29, $29, $00, $00 ; id 11
    db $31, $29, $31, $00, $00 ; id 12
    db $32, $21, $11, $00, $00 ; id 13
    db $33, $21, $11, $00, $00 ; id 14
    db $34, $21, $11, $00, $00 ; id 15
    db $35, $01, $19, $00, $00 ; id 16
    db $36, $29, $29, $00, $00 ; id 17
    db $37, $29, $29, $00, $00 ; id 18
    db $38, $29, $19, $00, $00 ; id 19
    db $39, $29, $19, $00, $00 ; id 20
    db $3a, $29, $19, $00, $00 ; id 21
    db $3b, $29, $19, $00, $00 ; id 22
    db $3c, $11, $21, $00, $00 ; id 23
    db $3d, $11, $21, $00, $00 ; id 24
    db $3e, $31, $0d, $00, $00 ; id 25
    db $3f, $31, $0d, $00, $00 ; id 26
    db $40, $31, $0d, $00, $00 ; id 27
    db $41, $11, $21, $00, $00 ; id 28
    db $42, $29, $29, $00, $00 ; id 29
    db $43, $29, $29, $00, $00 ; id 30
    db $44, $29, $29, $00, $00 ; id 31
    db $49, $29, $01, $00, $00 ; id 32
    db $4a, $41, $11, $00, $00 ; id 33
    db $4b, $41, $11, $00, $00 ; id 34
    db $4c, $41, $11, $00, $00 ; id 35
    db $4d, $41, $11, $00, $00 ; id 36
    db $4e, $39, $19, $39, $21 ; id 37
    db $4f, $39, $29, $00, $00 ; id 38
    db $50, $39, $29, $00, $00 ; id 39
    db $51, $39, $29, $00, $00 ; id 40
    db $52, $21, $31, $21, $31 ; id 41
    db $53, $21, $31, $21, $31 ; id 42
    db $54, $21, $31, $21, $31 ; id 43
    db $55, $21, $31, $21, $31 ; id 44
    db $56, $21, $31, $21, $31 ; id 45
    db $57, $21, $31, $21, $31 ; id 46
    db $58, $21, $41, $00, $00 ; id 47
    db $59, $21, $41, $00, $00 ; id 48
    db $5a, $11, $49, $00, $00 ; id 49
    db $5b, $11, $49, $00, $00 ; id 50
    db $5c, $11, $49, $00, $00 ; id 51
    db $5d, $28, $51, $00, $00 ; id 52
    db $5e, $49, $49, $00, $00 ; id 53
    db $5f, $49, $49, $00, $00 ; id 54
    db $60, $49, $49, $00, $00 ; id 55
    db $61, $49, $49, $00, $00 ; id 56
    db $62, $51, $29, $00, $00 ; id 57
    db $63, $41, $39, $00, $00 ; id 58
    db $64, $41, $39, $00, $00 ; id 59
    db $65, $41, $39, $00, $00 ; id 60
    db $66, $41, $39, $00, $00 ; id 61
    db $67, $41, $39, $00, $00 ; id 62
    db $71, $59, $09, $00, $00 ; id 63
    db $72, $59, $09, $00, $00 ; id 64
    db $73, $59, $09, $00, $00 ; id 65
    db $74, $59, $09, $00, $00 ; id 66
    db $75, $59, $09, $00, $00 ; id 67
    db $76, $59, $09, $00, $00 ; id 68
    db $77, $51, $21, $49, $21 ; id 69
    db $78, $29, $31, $00, $00 ; id 70
    db $79, $29, $31, $00, $00 ; id 71
    db $7a, $01, $21, $00, $00 ; id 72
    db $7b, $19, $31, $19, $39 ; id 73
    db $7c, $29, $49, $00, $00 ; id 74
    db $7d, $29, $49, $00, $00 ; id 75
    db $7e, $29, $49, $00, $00 ; id 76
    db $7f, $29, $49, $00, $00 ; id 77
    db $80, $41, $21, $49, $21 ; id 78
    db $81, $29, $59, $00, $00 ; id 79
    db $82, $29, $59, $00, $00 ; id 80
    db $83, $29, $59, $00, $00 ; id 81
    db $84, $29, $59, $00, $00 ; id 82
    db $85, $09, $59, $00, $00 ; id 83
    db $86, $09, $59, $00, $00 ; id 84
    db $87, $09, $59, $00, $00 ; id 85
    db $88, $09, $59, $00, $00 ; id 86
    db $89, $59, $09, $00, $00 ; id 87
    db $8a, $59, $51, $00, $00 ; id 88
    db $8b, $59, $51, $00, $00 ; id 89
    db $8c, $59, $51, $00, $00 ; id 90
    db $8d, $59, $51, $00, $00 ; id 91
    db $8e, $59, $51, $00, $00 ; id 92
    db $8f, $59, $51, $00, $00 ; id 93
    db $90, $59, $51, $00, $00 ; id 94
    db $91, $59, $51, $00, $00 ; id 95
    db $92, $29, $11, $00, $00 ; id 96
    db $93, $11, $01, $00, $00 ; id 97
    db $94, $11, $01, $00, $00 ; id 98
    db $95, $11, $01, $00, $00 ; id 99
    db $96, $11, $01, $00, $00 ; id 100
    db $97, $11, $01, $00, $00 ; id 101
    db $98, $11, $01, $00, $00 ; id 102
    db $99, $11, $01, $00, $00 ; id 103
    db $9a, $11, $01, $00, $00 ; id 104
    db $9b, $11, $01, $00, $00 ; id 105
    db $a1, $09, $11, $00, $00 ; id 106
    db $a2, $09, $09, $00, $00 ; id 107
    db $a3, $09, $09, $00, $00 ; id 108
    db $a9, $11, $21, $00, $00 ; id 109
    db $aa, $09, $09, $00, $00 ; id 110
    db $ab, $21, $19, $00, $00 ; id 111
    db $ac, $29, $09, $00, $00 ; id 112
    db $ad, $29, $09, $00, $00 ; id 113
    db $ae, $29, $09, $00, $00 ; id 114
    db $b1, $09, $01, $00, $00 ; id 115
    db $b3, $09, $01, $00, $00 ; id 116
    db $b4, $09, $01, $00, $00 ; id 117
    db $b5, $09, $01, $00, $00 ; id 118
    db $b6, $09, $01, $00, $00 ; id 119
    db $b9, $21, $19, $00, $00 ; id 120
    db $ba, $09, $09, $00, $00 ; id 121
    db $bb, $21, $01, $00, $00 ; id 122
    db $bc, $21, $19, $00, $00 ; id 123
    db $bd, $21, $01, $00, $00 ; id 124
    db $be, $21, $01, $00, $00 ; id 125
    db $bf, $21, $01, $00, $00 ; id 126
    db $c0, $21, $01, $00, $00 ; id 127
    db $c1, $21, $01, $00, $00 ; id 128
    db $c2, $21, $01, $00, $00 ; id 129
    db $c3, $21, $01, $00, $00 ; id 130
    db $c4, $21, $01, $00, $00 ; id 131
    db $c9, $01, $01, $00, $00 ; id 132
    db $ca, $01, $01, $00, $00 ; id 133
    db $cb, $01, $01, $00, $00 ; id 134
    db $cc, $01, $01, $00, $00 ; id 135
    db $cd, $01, $01, $00, $00 ; id 136
    db $ce, $01, $01, $00, $00 ; id 137
    db $d2, $01, $09, $00, $00 ; id 138
    db $d3, $01, $09, $00, $00 ; id 139
    db $d4, $01, $09, $00, $00 ; id 140
    db $d5, $01, $09, $00, $00 ; id 141
    db $d6, $01, $09, $00, $00 ; id 142
    db $d7, $01, $09, $00, $00 ; id 143
    db $db, $09, $01, $00, $00 ; id 144
    db $dc, $09, $01, $00, $00 ; id 145
    db $dd, $09, $01, $00, $00 ; id 146
    db $de, $09, $01, $00, $00 ; id 147
    db $df, $09, $01, $00, $00 ; id 148
    db $e0, $09, $01, $00, $00 ; id 149

; the routine before RunWorldMapState_FindPlayerScreen.skip scans 5-byte records from $5D80 for the
; map id and loads LoadMapPositionFromHL from bytes 1-2, or 3-4 when wLastWarpIndex = 2; 150 records
; with the same map ids as WorldMapCursorCellTable, then zero padding from $606E (E-0215, C1)
; record: map id; screen / position nibbles; the same for wLastWarpIndex = 2
WorldMapScreenPositionTable::
    db $21, $21, $44, $00, $00 ; id 0
    db $22, $21, $44, $00, $00 ; id 1
    db $23, $25, $44, $00, $00 ; id 2
    db $24, $25, $44, $00, $00 ; id 3
    db $25, $25, $44, $00, $00 ; id 4
    db $26, $25, $44, $00, $00 ; id 5
    db $28, $55, $44, $00, $00 ; id 6
    db $2a, $21, $44, $00, $00 ; id 7
    db $2b, $21, $44, $25, $44 ; id 8
    db $2d, $25, $44, $00, $00 ; id 9
    db $2e, $25, $44, $00, $00 ; id 10
    db $2f, $55, $44, $00, $00 ; id 11
    db $31, $56, $44, $00, $00 ; id 12
    db $32, $42, $44, $00, $00 ; id 13
    db $33, $42, $44, $00, $00 ; id 14
    db $34, $42, $44, $00, $00 ; id 15
    db $35, $03, $44, $00, $00 ; id 16
    db $36, $55, $44, $00, $00 ; id 17
    db $37, $55, $44, $00, $00 ; id 18
    db $38, $53, $44, $00, $00 ; id 19
    db $39, $53, $44, $00, $00 ; id 20
    db $3a, $53, $44, $00, $00 ; id 21
    db $3b, $53, $44, $00, $00 ; id 22
    db $3c, $24, $44, $00, $00 ; id 23
    db $3d, $24, $44, $00, $00 ; id 24
    db $3e, $62, $44, $00, $00 ; id 25
    db $3f, $62, $44, $00, $00 ; id 26
    db $40, $62, $44, $00, $00 ; id 27
    db $41, $24, $44, $00, $00 ; id 28
    db $42, $55, $44, $00, $00 ; id 29
    db $43, $55, $44, $00, $00 ; id 30
    db $44, $55, $44, $00, $00 ; id 31
    db $49, $50, $44, $00, $00 ; id 32
    db $4a, $82, $44, $00, $00 ; id 33
    db $4b, $82, $44, $00, $00 ; id 34
    db $4c, $82, $44, $00, $00 ; id 35
    db $4d, $82, $44, $00, $00 ; id 36
    db $4e, $73, $44, $74, $44 ; id 37
    db $4f, $75, $44, $00, $00 ; id 38
    db $50, $75, $44, $00, $00 ; id 39
    db $51, $75, $44, $00, $00 ; id 40
    db $52, $46, $44, $46, $64 ; id 41
    db $53, $46, $44, $46, $64 ; id 42
    db $54, $46, $44, $46, $64 ; id 43
    db $55, $46, $44, $46, $64 ; id 44
    db $56, $46, $44, $46, $64 ; id 45
    db $57, $46, $44, $46, $64 ; id 46
    db $58, $48, $44, $00, $00 ; id 47
    db $59, $48, $44, $00, $00 ; id 48
    db $5a, $29, $44, $00, $00 ; id 49
    db $5b, $29, $44, $00, $00 ; id 50
    db $5c, $29, $44, $00, $00 ; id 51
    db $5d, $5a, $43, $00, $00 ; id 52
    db $5e, $99, $44, $00, $00 ; id 53
    db $5f, $99, $44, $00, $00 ; id 54
    db $60, $99, $44, $00, $00 ; id 55
    db $61, $99, $44, $00, $00 ; id 56
    db $62, $a5, $44, $00, $00 ; id 57
    db $63, $87, $44, $00, $00 ; id 58
    db $64, $87, $44, $00, $00 ; id 59
    db $65, $87, $44, $00, $00 ; id 60
    db $66, $87, $44, $00, $00 ; id 61
    db $67, $87, $44, $00, $00 ; id 62
    db $71, $b1, $44, $00, $00 ; id 63
    db $72, $b1, $44, $00, $00 ; id 64
    db $73, $b1, $44, $00, $00 ; id 65
    db $74, $b1, $44, $00, $00 ; id 66
    db $75, $b1, $44, $00, $00 ; id 67
    db $76, $b1, $44, $00, $00 ; id 68
    db $77, $a4, $44, $94, $44 ; id 69
    db $78, $56, $44, $00, $00 ; id 70
    db $79, $56, $44, $00, $00 ; id 71
    db $7a, $04, $44, $00, $00 ; id 72
    db $7b, $36, $44, $37, $44 ; id 73
    db $7c, $59, $44, $00, $00 ; id 74
    db $7d, $59, $44, $00, $00 ; id 75
    db $7e, $59, $44, $00, $00 ; id 76
    db $7f, $59, $44, $00, $00 ; id 77
    db $80, $89, $44, $99, $44 ; id 78
    db $81, $5b, $44, $00, $00 ; id 79
    db $82, $5b, $44, $00, $00 ; id 80
    db $83, $5b, $44, $00, $00 ; id 81
    db $84, $5b, $44, $00, $00 ; id 82
    db $85, $1b, $44, $00, $00 ; id 83
    db $86, $1b, $44, $00, $00 ; id 84
    db $87, $1b, $44, $00, $00 ; id 85
    db $88, $1b, $44, $00, $00 ; id 86
    db $89, $b1, $44, $00, $00 ; id 87
    db $8a, $ba, $44, $00, $00 ; id 88
    db $8b, $ba, $44, $00, $00 ; id 89
    db $8c, $ba, $44, $00, $00 ; id 90
    db $8d, $ba, $44, $00, $00 ; id 91
    db $8e, $ba, $44, $00, $00 ; id 92
    db $8f, $ba, $44, $00, $00 ; id 93
    db $90, $ba, $44, $00, $00 ; id 94
    db $91, $ba, $44, $00, $00 ; id 95
    db $92, $52, $44, $00, $00 ; id 96
    db $93, $41, $44, $00, $00 ; id 97
    db $94, $41, $44, $00, $00 ; id 98
    db $95, $41, $44, $00, $00 ; id 99
    db $96, $41, $44, $00, $00 ; id 100
    db $97, $41, $44, $00, $00 ; id 101
    db $98, $41, $44, $00, $00 ; id 102
    db $99, $41, $44, $00, $00 ; id 103
    db $9a, $41, $44, $00, $00 ; id 104
    db $9b, $41, $44, $00, $00 ; id 105
    db $a1, $12, $44, $00, $00 ; id 106
    db $a2, $11, $44, $00, $00 ; id 107
    db $a3, $11, $44, $00, $00 ; id 108
    db $a9, $24, $44, $00, $00 ; id 109
    db $aa, $11, $44, $00, $00 ; id 110
    db $ab, $43, $44, $00, $00 ; id 111
    db $ac, $51, $44, $00, $00 ; id 112
    db $ad, $51, $44, $00, $00 ; id 113
    db $ae, $51, $44, $00, $00 ; id 114
    db $b1, $10, $44, $00, $00 ; id 115
    db $b3, $10, $44, $00, $00 ; id 116
    db $b4, $10, $44, $00, $00 ; id 117
    db $b5, $10, $44, $00, $00 ; id 118
    db $b6, $10, $44, $00, $00 ; id 119
    db $b9, $43, $44, $00, $00 ; id 120
    db $ba, $11, $44, $00, $00 ; id 121
    db $bb, $40, $44, $00, $00 ; id 122
    db $bc, $43, $44, $00, $00 ; id 123
    db $bd, $40, $44, $00, $00 ; id 124
    db $be, $40, $44, $00, $00 ; id 125
    db $bf, $40, $44, $00, $00 ; id 126
    db $c0, $40, $44, $00, $00 ; id 127
    db $c1, $40, $44, $00, $00 ; id 128
    db $c2, $40, $44, $00, $00 ; id 129
    db $c3, $40, $44, $00, $00 ; id 130
    db $c4, $40, $44, $00, $00 ; id 131
    db $c9, $00, $44, $00, $00 ; id 132
    db $ca, $00, $44, $00, $00 ; id 133
    db $cb, $00, $44, $00, $00 ; id 134
    db $cc, $00, $44, $00, $00 ; id 135
    db $cd, $00, $44, $00, $00 ; id 136
    db $ce, $00, $44, $00, $00 ; id 137
    db $d2, $01, $44, $00, $00 ; id 138
    db $d3, $01, $44, $00, $00 ; id 139
    db $d4, $01, $44, $00, $00 ; id 140
    db $d5, $01, $44, $00, $00 ; id 141
    db $d6, $01, $44, $00, $00 ; id 142
    db $d7, $01, $44, $00, $00 ; id 143
    db $db, $10, $44, $00, $00 ; id 144
    db $dc, $10, $44, $00, $00 ; id 145
    db $dd, $10, $44, $00, $00 ; id 146
    db $de, $10, $44, $00, $00 ; id 147
    db $df, $10, $44, $00, $00 ; id 148
    db $e0, $10, $44, $00, $00 ; id 149
    ds $1f92, $00
