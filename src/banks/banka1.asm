SECTION "Bank A1", ROMX[$4000], BANK[$A1]
    db $A1

; A = battle slot: HL = the word for that slot at wBattleATK; A = its low byte (E-0064)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleATK
GetBattleATK_BankA1:: ; heuristic: follows a terminator; C0
Func_0A1_4001:: ; address name
    ld hl, wBattleATK
    jr GetBattleMP_BankA1_Skip

; no direct call (reached through a table, a jump or a vector)
; points at: wBattleDEF
GetBattleDEF_BankA1:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:4006; C0
Func_0A1_4006:: ; address name
    ld hl, wBattleDEF
    jr GetBattleMP_BankA1_Skip

; no direct call (reached through a table, a jump or a vector)
; points at: wBattleMaxHP
GetBattleMaxHP_BankA1:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:400B; C0
Func_0A1_400B:: ; address name
    ld hl, wBattleMaxHP
    jr GetBattleMP_BankA1_Skip

; no direct call (reached through a table, a jump or a vector)
; points at: wBattleMaxMP
GetBattleMaxMP_BankA1:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:4010; C0
Func_0A1_4010:: ; address name
    ld hl, wBattleMaxMP
    jr GetBattleMP_BankA1_Skip

; no direct call (reached through a table, a jump or a vector)
; points at: wBattleHP
GetBattleHP_BankA1:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:4015; C0
Func_0A1_4015:: ; address name
    ld hl, wBattleHP
    jr GetBattleMP_BankA1_Skip

; no direct call (reached through a table, a jump or a vector)
; points at: wBattleMP
GetBattleMP_BankA1:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:401A; C0
Func_0A1_401A:: ; address name
    ld hl, wBattleMP
    jr GetBattleMP_BankA1_Skip
    db $21, $1F, $D9, $18, $0A, $21, $53, $DA, $85, $6F, $30, $01, $24, $7E, $C9

GetBattleMP_BankA1_Skip::
Jump_0A1_402E:: ; address name
    add a, a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
AddDoubleAToHL_BankA1:: ; heuristic: follows a terminator; C0
Func_0A1_4038:: ; address name
    add a, a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the reversal, not checked (E-0064) (the same 27 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole, wBattleActor
ActorOnLocalSide_BankA1:: ; heuristic: follows a terminator; C0
Func_0A1_403F:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr nz, .check_battle_actor
    ld a, [wLinkRole]
    bit 1, a
    jr z, .check_battle_actor
    ld a, [wBattleActor]
    cp a, $04
    ccf
    ret

.check_battle_actor:
    ld a, [wBattleActor]
    cp a, $04
    ret

; carry set when wBattleTarget < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleTarget >= 4) (E-0064) (the same 27 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole, wBattleTarget
TargetOnLocalSide_BankA1:: ; heuristic: follows a terminator; C0
Func_0A1_405A:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr nz, .check_battle_target
    ld a, [wLinkRole]
    bit 1, a
    jr z, .check_battle_target
    ld a, [wBattleTarget]
    cp a, $04
    ccf
    ret

.check_battle_target:
    ld a, [wBattleTarget]
    cp a, $04
    ret

; wBattleStatus + 9 * E &= ClearBitMaskTable_BankA1[D] (AddAx9ToHL); not reached from traced code (E-0205)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleStatus
ClearBattleStatusBitsWithMaskD_BankA1:: ; configured code entry (E-0205); C0
Func_0A1_4075:: ; address name
    ld a, d
    ld hl, ClearBitMaskTable_BankA1
    add_a_to_hl
    ld d, [hl]
    ld a, e
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, d
    and a, [hl]
    ld [hl], a
    ret

; E-0205 (C1: the routine at $4075 reads the byte at $408A + D and ANDs it into the byte at wBattleStatus + 9 * E (AddAx9ToHL); the same 202-byte block of routines and this table sit at $4075-$413F in banks $05, $A1 and $A3).
; record: AND mask
ClearBitMaskTable_BankA1::
Data_0A1_408A:: ; address name
    db $DF ; id 0
    db $FE ; id 1
    db $00 ; id 2
    db $FD ; id 3
    db $73 ; id 4
    db $EF ; id 5
    db $BF ; id 6

; Sets bit 0 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wLevelUpGains
SetBit0OfLevelUpGainsIndexed_BankA1:: ; configured code entry (E-0205); C0
Func_0A1_4091:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; Sets bit 1 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wLevelUpGains
SetBit1OfLevelUpGainsIndexed_BankA1:: ; configured code entry (E-0205); C0
Func_0A1_409E:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; Sets bit 2 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wLevelUpGains
SetBit2OfLevelUpGainsIndexed_BankA1:: ; configured code entry (E-0205); C0
Func_0A1_40AB:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 2, [hl]
    pop hl
    ret

; A = slot 0-7: returns A = 9 * g(wD968[A]) + 3 * g(wD970[A]) + g(wD978[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes appear in 13 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo
PersonalityIndexOfSlot_BankA1:: ; configured code entry (E-0205); C0
Func_0A1_40B8:: ; address name
    push hl
    push bc
    ld c, a
    ld b, $00
    ld hl, wSlotPersonalityHi
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, .skip
    ld l, $09
    cp a, $40
    jr nc, .skip
    ld l, $12

.skip:
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityMid
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, .skip2
    ld l, $03
    cp a, $40
    jr nc, .skip2
    ld l, $06

.skip2:
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityLo
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, .skip3
    ld l, $01
    cp a, $40
    jr nc, .skip3
    ld l, $02

.skip3:
    ld a, l
    add a, b
    pop bc
    pop hl
    ret

; A = slot: carry set when CheckSlotStatusBlock sets it, or when status byte 3 & $C0 or byte 4 & $0C is set (wD80F + 9 * A); otherwise carry clear; A, BC, HL kept (E-0067) (the same 31 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleStatus3
CheckSlotStatusBlockWide_BankA1:: ; configured code entry (E-0205); C0
Func_0A1_410F:: ; address name
    call CheckSlotStatusBlock
    ret c
    push hl
    push bc
    ld c, a
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, .set_carry
    ld a, [hl]
    and a, $0C
    jr nz, .set_carry
    xor a, a
    jr .skip

.set_carry:
    scf

.skip:
    ld a, c
    pop bc
    pop hl
    ret

; A = slot: with HL = wD80F + 9 * A (status byte 3 of wBattleStatus), A = byte 3 & $C0, or byte 4 & $0C when that is zero; Z set when both are clear; HL kept (E-0067) (the same 17 bytes appear in 13 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleStatus3
SlotHasStatus3Or4Bits_BankA1:: ; configured code entry (E-0205); C0
Func_0A1_412E:: ; address name
    push hl
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, .done
    ld a, [hl]
    and a, $0C

.done:
    pop hl
    ret

; the same instruction sequence as RunBattleCommandEntry (bank $30) apart from label operands, which refer to this bank's own routines and tables; the twin's note describes the shape (E-0107)
; 1 call site from 1 routine (e.g. RunBattlePhaseWhenTextIdle_A0_RunTurn_ToRunBattleCommandEntry_BankA1)
; reads: wTextFlags, wBattleSubPhase
RunBattleCommandEntry_BankA1::
Func_0A1_413F:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wBattleSubPhase]
    rst $00
    dw RunBattleCommandEntry_BankA1_CarryUnlessBattleSlotOutSlotEmpty
    dw RunBattleCommandEntry_BankA1_CarryUnlessBattleSlotOutSlotEmpty_Case01
    dw RunBattleCommandEntry_BankA1_ToRunCommandEntryResolveStep
    dw RunBattleCommandEntry_BankA1_ChooseActionTarget
    dw RunBattleCommandEntry_BankA1_CarryUnlessBattleSlotOutSlotEmpty_Case04
    dw RunBattleCommandEntry_BankA1_CompareHLToBC
    dw RunBattleCommandEntry_BankA1_AddWordAtHLToBC_BankA1

; entry 0 of the `rst $00` table in RunBattleCommandEntry_BankA1
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte, wBattleActor
; points at: wBattleSubPhase
RunBattleCommandEntry_BankA1_CarryUnlessBattleSlotOutSlotEmpty::
Jump_0A1_4156:: ; address name
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wBattleActor], a
    ld bc, $0304
    ld hl, wSlotMarks + $4

.loop:
    ld a, [hl]
    ld e, $FF
    cp a, $FF
    jr z, .skip
    ld e, $03
    cp a, $FE
    jr z, .skip
    cp a, $FD
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

; entry 1 of the `rst $00` table in RunBattleCommandEntry_BankA1
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wBattleActor, wBattleResolveStep
; points at: wSlotMarks, wBattleSubPhase
RunBattleCommandEntry_BankA1_CarryUnlessBattleSlotOutSlotEmpty_Case01::
Jump_0A1_418A:: ; address name
    call NextTableByteSecondStream
    ld a, [wBattleActor]
    cp a, $08
    jr z, .skip
    ld e, a
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    cp a, $01
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
    xor a, a
    ld [wBattleResolveStep], a
    jr .return

.skip:
    ld hl, wBattleSubPhase
    inc [hl]
    inc [hl]
    inc [hl]

.return:
    ret

; entry 2 of the `rst $00` table in RunBattleCommandEntry_BankA1
; no direct call (reached through a table, a jump or a vector)
RunBattleCommandEntry_BankA1_ToRunCommandEntryResolveStep::
Jump_0A1_41C3:: ; address name
    farcall RunCommandEntryResolveStep
    ret

; entry 3 of the `rst $00` table in RunBattleCommandEntry_BankA1
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wBattleSubPhase
; points at: wBattleTargetChoice, wSlotMarks, wBattleActor
RunBattleCommandEntry_BankA1_ChooseActionTarget::
Jump_0A1_41CA:: ; address name
    farcall ChooseActionTarget
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
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

; entry 4 of the `rst $00` table in RunBattleCommandEntry_BankA1
; no direct call (reached through a table, a jump or a vector)
; reads: wLoadSlot
; writes: wActionQueuePos, wLoadSlot, wBattleTemp7A, wBattleTemp7B
; points at: wActionQueue, wBattleArg0, wBattleTemp7D, wSlotMarks, wBattleTemp7A, wLoadSlot, wBattleSubPhase
RunBattleCommandEntry_BankA1_CarryUnlessBattleSlotOutSlotEmpty_Case04::
Jump_0A1_41F4:: ; address name
    ld hl, wActionQueue
    ld bc, $0009
    ld a, $FF
    call FillBytes
    ld hl, wBattleArg0
    ld bc, $0009
    ld a, $FF
    call FillBytes
    ld hl, wBattleTemp7D
    ld bc, $0012
    ld a, $00
    call FillBytes
    xor a, a
    ld [wActionQueuePos], a
    ld [wLoadSlot], a
    ld hl, wBattleTemp7D
    ld a, l
    ld [wBattleTemp7A], a
    ld a, h
    ld [wBattleTemp7B], a
    ld de, $0800

.loop:
    ld a, e
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, e
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    cp a, $02
    jr nz, .next
    ld a, e
    call RunBattleCommandEntry_BankA1_Case04_RandomInRange
    call RunBattleCommandEntry_BankA1_Case04_WriteRecordBufferAndBattleArg0Etc
    ld hl, wBattleTemp7A
    deref_hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wLoadSlot]
    ld hl, wBattleArg0
    add_a_to_hl
    ld [hl], e
    ld hl, wLoadSlot
    inc [hl]
    ld hl, wBattleTemp7A
    inc [hl]
    ld hl, wBattleTemp7A
    inc [hl]

.next:
    inc e
    dec d
    jp nz, .loop
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunBattleCommandEntry_BankA1
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTemp7A, wBattleTemp7B, wBattleDamageLo, wBattleDamageHi, wTargetEstimates, wActionQueuePos
; writes: wBattleTemp7A, wBattleTemp7B, wBattleDamageLo, wBattleDamageHi, wTargetEstimates, wActionQueuePos
; points at: wBattleTemp7D, wBattleTemp7F, wBattleArg0, wBattleTemp7A, wActionQueue, wBattleSubPhase
RunBattleCommandEntry_BankA1_CompareHLToBC::
Jump_0A1_4270:: ; address name
    ld d, $08

.loop:
    ld hl, wBattleTemp7D
    ld a, l
    ld [wBattleTemp7A], a
    ld a, h
    ld [wBattleTemp7B], a
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld hl, wBattleTemp7F
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
    ld a, [wBattleTemp7A]
    ld l, a
    ld a, [wBattleTemp7B]
    ld h, a
    ld a, [wBattleDamageLo]
    ld [hl+], a
    ld a, [wBattleDamageHi]
    ld [hl+], a
    ld a, [wTargetEstimates]
    ld [hl+], a
    ld a, [wTargetEstimates + $1]
    ld [hl], a
    ld a, e
    ld hl, wBattleArg0
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld [hl-], a
    ld [hl], b

.next:
    inc e
    ld a, e
    cp a, d
    jr z, .next2
    ld hl, wBattleTemp7A
    inc [hl]
    ld hl, wBattleTemp7A
    inc [hl]
    deref_hl
    ld a, [hl+]
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
    add a, e
    ld e, a
    jr nc, .read_action_queue_pos
    inc d

.read_action_queue_pos:
    ld a, [wActionQueuePos]
    ld hl, wBattleArg0
    ld b, $09

.loop2:
    ld a, [hl+]
    cp a, $FF
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

; entry 6 of the `rst $00` table in RunBattleCommandEntry_BankA1
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleCommandArgs, wBattleSubPhase
; points at: wBattleHP, wBattleMaxHP, wBattleStep, wBattleResolveStep
RunBattleCommandEntry_BankA1_AddWordAtHLToBC_BankA1::
Jump_0A1_4305:: ; address name
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
    xor a, a
    ld [wBattleSubPhase], a
    xor a, a
    ld hl, wBattleResolveStep
    ld bc, $0005
    call FillBytes
    farcall SaveActionChoicesAndPickFormations
    call RunBattleCommandEntry_BankA1_Case06_CarryUnlessBattleSlotOutSlotEmpty
    ret

; BC += the word at [HL]; HL += 2; clobbers A (the same 7 bytes appear in 2 banks)
; 6 call sites from 1 routine (e.g. RunBattleCommandEntry_BankA1_AddWordAtHLToBC_BankA1)
AddWordAtHLToBC_BankA1::
Func_0A1_434F:: ; address name
    ld a, [hl+]
    add a, c
    ld c, a
    ld a, [hl+]
    adc a, b
    ld b, a
    ret

; only called from RunBattleCommandEntry_BankA1_Case06 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleCommandEntry_BankA1_AddWordAtHLToBC_BankA1)
; points at: wBattleActionChoice, wBattleStatus6
RunBattleCommandEntry_BankA1_Case06_CarryUnlessBattleSlotOutSlotEmpty::
Func_0A1_4356:: ; address name
    ld c, $00
    ld b, $08

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    add a, a
    ld hl, wBattleActionChoice
    add_a_to_hl
    ld a, [hl]
    cp a, $6E
    jr nz, .next
    ld a, c
    ld hl, wBattleStatus6
    call AddAx9ToHL
    set 2, [hl]

.next:
    inc c
    dec b
    jr nz, .loop
    ret

; only called from RunBattleCommandEntry_BankA1_Case04 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleCommandEntry_BankA1_CarryUnlessBattleSlotOutSlotEmpty_Case04)
; points at: wBattleAGL
RunBattleCommandEntry_BankA1_Case04_RandomInRange::
Func_0A1_437D:: ; address name
    push de
    call NextTableByteSecondStream
    ld a, e
    ld hl, wBattleAGL
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    push bc
    ld a, $03
    call Multiply8By16
    ld a, $0A
    call Divide24ByA
    pop bc
    call RandomInRange
    ld c, e
    ld b, d
    pop de
    ret

; only called from RunBattleCommandEntry_BankA1_Case04 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleCommandEntry_BankA1_CarryUnlessBattleSlotOutSlotEmpty_Case04)
; reads: wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3, wRecordBufferData, wRandomLo
; writes: wRecordBuffer, wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3
; points at: wBattleActionChoice
RunBattleCommandEntry_BankA1_Case04_WriteRecordBufferAndBattleArg0Etc::
Func_0A1_43A1:: ; address name
    push de
    ld a, e
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $62
    jr z, .skip
    cp a, $69
    jr z, .call_next_table_byte_second_stream
    cp a, $D8
    jr z, .skip
    push af
    push bc
    push de
    push hl
    ld [wRecordBuffer], a
    xor a, a
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
    ld hl, $000A
    jr .skip3

.skip:
    ld hl, $0BB8
    jr .skip3

.skip2:
    ld hl, $07D0
    jr .skip3

.call_next_table_byte_second_stream:
    call NextTableByteSecondStream
    ld a, [wRandomLo]
    ld b, a
    ld a, $09
    call DivideBByA
    add a, $01
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

; on map type $80 sets the bit for the current map screen in the visited-screen bitmap wCE93 (E-0125)
; 6 call sites from 3 routines (e.g. MarkVisitedScreens5x5AroundPlayer, RunFieldActionRequestActionIfBit7_WriteScrollXAndScrollY, RunMenuStateMenuState_InitSoundHardware)
; reads: wMapType, hMapScreenY, hMapScreenX
; points at: wVisitedScreens
MarkVisitedMapScreenInVisitedScreens::
Func_0A1_4435:: ; address name
    ld a, [wMapType]
    bit 7, a
    ret z
    cp a, $80
    ret nz
    ldh a, [hMapScreenY]
    and a, $FC
    ld hl, wVisitedScreens
    add_a_to_hl
    ldh a, [hMapScreenX]
    srl a
    and a, $FE
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
    and a, $03
    jr z, .skip2
    ld b, a

.loop:
    sla c
    dec b
    jr nz, .loop

.skip2:
    ld a, [hl]
    or a, c
    ld [hl], a
    ret

; only called from RunMenuStateMenuState_Case05 (E-0047)
; 1 call site from 1 routine (e.g. RunMenuStateMenuState_InitSoundHardware)
; reads: wKeyWorldFloor
; points at: wKeyWorldAreaExits, wVisitedScreens
RunMenuStateMenuState_Case05_ReadKeyWorldFloor::
Func_0A1_4474:: ; address name
    ld hl, wKeyWorldAreaExits
    ld a, [wKeyWorldFloor]
    bit 7, a
    jr z, .skip
    inc hl

.skip:
    and a, $0F
    add a, a
    add a, a
    add_a_to_hl
    ld a, [hl]
    push af
    and a, $0F
    and a, $FC
    ld hl, wVisitedScreens
    add_a_to_hl
    pop af
    push af
    swap a
    and a, $0F
    srl a
    and a, $FE
    add_a_to_hl
    pop af
    push af
    and a, $0F
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
    and a, $0F
    and a, $03
    jr z, .skip3
    ld b, a

.loop:
    sla c
    dec b
    jr nz, .loop

.skip3:
    ld a, [hl]
    or a, c
    ld [hl], a
    ret

; marks the 5 x 5 map screens around the current one (within wCD0D x wCD0E) as visited (E-0127)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_UseFieldSkill_Case07_Sub01_MarkVisitedScreens5x5AroundPlayer)
; reads: hMapScreenX, hMapScreenY, wKeyWorldHeight, wKeyWorldWidth, hTemp0, hTemp1
; writes: hTemp0, hMapScreenX, hTemp1, hMapScreenY
; points at: hMapScreenX, hMapScreenY
MarkVisitedScreens5x5AroundPlayer::
Func_0A1_44C9:: ; address name
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
    cp a, d
    jr nc, .read_temp0
    ld a, [wKeyWorldWidth]
    ld d, a
    ldh a, [hMapScreenX]
    bit 7, a
    jr nz, .skip
    cp a, d
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
    sub a, $02
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

; runs the routine for wC5DD & 7 (field mode state 8; jump table, 3 reuses 0) (E-0122)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_RunGameMode2State)
; reads: wGameMode2State
RunGameMode2State::
Func_0A1_4519:: ; address name
    ld a, [wGameMode2State]
    and a, $07
    rst $00
    dw RunGameMode2State_UploadBGPalettes
    dw RunGameMode2State_CopyScrollToHardware
    dw RunGameMode2State_WriteGameMode2State
    dw RunGameMode2State_UploadBGPalettes
    dw RunGameMode2State_CopyScrollToHardware_Case04
    dw RunGameMode2State_WriteBGPaletteUploadRequestAndOBJPaletteUploadRequest
    dw RunGameMode2State_ToEnterGameMode1WithDefaultPalettes

; entry 4 of the `rst $00` table in RunGameMode2State
; no direct call (reached through a table, a jump or a vector)
; reads: wMapType, wIsCGB
; writes: hScrollX, hScrollY, wOBJPaletteUploadRequest, wBGPaletteUploadRequest
; points at: wDMGPaletteBGP, wOBJPaletteBuffer, wBGPaletteBuffer, wGameMode2State
RunGameMode2State_CopyScrollToHardware_Case04::
Jump_0A1_452D:: ; address name
    xor a, a
    ldh [hScrollX], a
    ldh [hScrollY], a
    call CopyScrollToHardware
    ld de, Tiles0Gfx_7E_4EB3
    ld b, $7E
    ld hl, vTiles0
    call DecompressToVRAM
    ld de, Tiles0Plus100Gfx_7E_5B27
    ld b, $7E
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld de, Tiles0Plus200Gfx_7E_5B46
    ld b, $7E
    ld hl, vTiles0 + $200
    call DecompressToVRAM
    ld de, Tiles2Gfx_5D_43AE
    ld b, $5D
    ld hl, vTiles2
    call DecompressToVRAM
    call FillBGMap0With57
    call RunGameMode2State_Case04_WriteVRAMByteInc
    ld a, [wMapType]
    bit 7, a
    jr nz, .call_run_game_mode2_state_case04_store_temp5
    call RunGameMode2State_Case04_StoreTemp5ValuesToCursorCellX
    jr .skip

.call_run_game_mode2_state_case04_store_temp5:
    call RunGameMode2State_Case04_StoreTemp5ValuesToCursorCellX_Sub01

.skip:
    ld hl, wDMGPaletteBGP
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, .done
    ld a, $40
    ld de, OBJPaletteBufferData_7E_4BBD
    add a, e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld b, $7E
    ld hl, wOBJPaletteBuffer
    ld c, $08
    call CopyFromBank
    ld de, OBJPaletteBufferPlus8Data_7E_5AF6
    ld b, $7E
    ld hl, wOBJPaletteBuffer + $8
    ld c, $10
    call CopyFromBank
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ld de, BGPaletteBufferData_5D_4565
    ld b, $5D
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBank
    ld a, $7F
    ld [wBGPaletteUploadRequest], a

.done:
    ld hl, wGameMode2State
    inc [hl]
    ret

; only called from RunGameMode2State_Case04 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_CopyScrollToHardware_Case04)
; reads: hTemp5, hTemp7, hTempA, hTemp3, hTemp8, hTemp4, hTemp9, hTemp6
; writes: hTemp9, hTempA, hTemp8, hTemp6
RunGameMode2State_Case04_StoreTemp5ValuesToCursorCellX_Sub01::
Func_0A1_45C5:: ; address name
    call RunGameMode2State_Case04_Sub01_RunGameMode2MapTypeState
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
    cp a, c
    jr c, .check_temp9
    ldh a, [hTemp8]
    bit 7, a
    jr nz, .check_temp9
    ld c, a
    ldh a, [hTemp4]
    dec a
    cp a, c
    jr c, .check_temp9
    push bc
    ldh a, [hTempA]
    and a, $0F
    swap a
    ld c, a
    ldh a, [hTemp8]
    and a, $0F
    or a, c
    pop bc
    push de
    call IsMapScreenAVisited
    pop de
    or a, a
    jr z, .check_temp9
    call RunGameMode2State_Case04_Sub01_WriteTemp0AndTemp1

.check_temp9:
    ldh a, [hTemp9]
    inc a
    cp a, $05
    jr nz, .set_temp9
    ldh a, [hTempA]
    inc a
    ldh [hTempA], a
    xor a, a

.set_temp9:
    ldh [hTemp9], a
    pop hl
    inc hl
    pop bc
    dec b
    jr nz, .loop2
    ldh a, [hTemp6]
    inc a
    cp a, $05
    jr nz, .set_temp6
    ldh a, [hTemp8]
    inc a
    ldh [hTemp8], a
    xor a, a

.set_temp6:
    ldh [hTemp6], a
    pop hl
    ld a, $20
    add_a_to_hl
    dec c
    jr nz, .loop
    ret

; only called from RunGameMode2State_Case04_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case04_StoreTemp5ValuesToCursorCellX_Sub01)
; reads: hTemp8, hTempA, hTemp6, hTemp9
; writes: hTemp0, hTemp1
RunGameMode2State_Case04_Sub01_WriteTemp0AndTemp1::
Func_0A1_4640:: ; address name
    push hl
    ldh a, [hTemp8]
    and a, $FC
    add a, a
    ld l, a
    ld h, $00
    ldh a, [hTempA]
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
    ldh a, [hTemp8]
    and a, $03
    ld c, a
    sla a
    add a, c
    sla a
    sla a
    add_a_to_hl
    ldh a, [hTempA]
    and a, $03
    ld c, a
    sla a
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
    add a, c
    add_a_to_hl
    ldh a, [hTemp9]
    add_a_to_hl
    ld a, l
    add a, $A0
    ld l, a
    ld a, h
    adc a, $43
    ld h, a
    ld e, l
    ld d, h
    ld b, $5E
    call ReadByteInBank
    pop hl
    ld a, c
    call WriteVRAMByte
    ret

; only called from RunGameMode2State_Case04_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case04_StoreTemp5ValuesToCursorCellX_Sub01)
; reads: hPlayerX, hMapScreenX, hPlayerY, hMapScreenY, wKeyWorldWidth, wKeyWorldHeight
; writes: hTemp3, hTemp4, hTemp7, hTemp8, hTemp5, hTemp6, hPlayerY, hMapScreenY, ...
; points at: hTemp7, hTemp8
RunGameMode2State_Case04_Sub01_RunGameMode2MapTypeState::
Func_0A1_46DF:: ; address name
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
    call RunGameMode2MapTypeState
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
    and a, $0F
    srl a
    inc a
    cp a, $05
    jr c, .set_temp5
    sub a, $05
    push af
    ld hl, hTemp7
    inc [hl]
    pop af

.set_temp5:
    ldh [hTemp5], a
    ldh a, [hPlayerY]
    swap a
    and a, $0F
    srl a
    inc a
    inc a
    cp a, $05
    jr c, .set_temp6
    sub a, $05
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

; runs the routine for wCC44 & 7 (jump table) (E-0122)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case04_Sub01_RunGameMode2MapTypeState)
; reads: wMapType
RunGameMode2MapTypeState::
Func_0A1_4744:: ; address name
    ld a, [wMapType]
    and a, $07
    rst $00
    dw RunGameMode2MapTypeState_Return
    dw RunGameMode2MapTypeState_WriteMapScreenXAndMapScreenYEtc
    dw RunGameMode2MapTypeState_WriteMapScreenXAndMapScreenYEtc
    dw RunGameMode2MapTypeState_WriteMapScreenXAndMapScreenYEtc_Case03
    dw RunGameMode2MapTypeState_WriteMapScreenXAndMapScreenYEtc_Case03
    dw RunGameMode2MapTypeState_WriteMapScreenXAndMapScreenYEtc_Case03
    dw RunGameMode2MapTypeState_WriteMapScreenXAndMapScreenYEtc_Case03
    dw RunGameMode2MapTypeState_SetMapScreenFromAAndCenterPlayer

; entry 0 of the `rst $00` table in RunGameMode2MapTypeState
; no direct call (reached through a table, a jump or a vector)
RunGameMode2MapTypeState_Return::
Jump_0A1_475A:: ; address name
    ret

; entry 1 of the `rst $00` table in RunGameMode2MapTypeState
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldFloor
; writes: hMapScreenX, hMapScreenY, hPlayerX, hPlayerY
; points at: wKeyWorldAreaExits
RunGameMode2MapTypeState_WriteMapScreenXAndMapScreenYEtc::
Jump_0A1_475B:: ; address name
    ld a, [wKeyWorldFloor]
    and a, $07
    add a, a
    add a, a
    ld hl, wKeyWorldAreaExits
    add_a_to_hl
    ld a, [wKeyWorldFloor]
    bit 7, a
    jr z, .skip
    inc hl

.skip:
    ld a, [hl]
    jr SetMapScreenFromAAndCenterPlayer

; entry 3 of the `rst $00` table in RunGameMode2MapTypeState
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldFloor
; writes: hMapScreenX, hMapScreenY, hPlayerX, hPlayerY
; points at: wKeyWorldFloorInfo
RunGameMode2MapTypeState_WriteMapScreenXAndMapScreenYEtc_Case03::
Jump_0A1_4775:: ; address name
    ld a, [wKeyWorldFloor]
    and a, $07
    add a, a
    add a, a
    ld hl, wKeyWorldFloorInfo
    add_a_to_hl
    ld a, [hl]
    jr SetMapScreenFromAAndCenterPlayer

; entry 7 of the `rst $00` table in RunGameMode2MapTypeState
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldActive, wKeyWorldKey, wKeyWorldSlot, wKeyWorldGoalCell, wKeyWorldGoal, wKeyWorldGoalScreen, wKeyWorldGoalPos, wKeyWorldGoalPos2
; writes: hPlayerX, hPlayerY
RunGameMode2MapTypeState_SetMapScreenFromAAndCenterPlayer::
Jump_0A1_4787:: ; address name
    ld a, [wKeyWorldActive]
    or a, a
    jr z, .read_key_world_goal_screen
    ld a, [wKeyWorldKey]
    bit 7, a
    jr z, .read_key_world_goal_screen
    and a, $7F
    ld c, a
    ld a, [wKeyWorldSlot]
    cp a, c
    jr nz, .read_key_world_goal_screen
    ld a, [wKeyWorldGoalCell]
    call SetMapScreenFromAAndCenterPlayer
    ld a, [wKeyWorldGoal]
    and a, $F0
    ldh [hPlayerX], a
    ld a, [wKeyWorldGoal]
    and a, $0F
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

; hMapScreenX = A >> 4, hMapScreenY = A & $0F, hPlayerX = hPlayerY = $40 (E-0118)
; 2 call sites from 1 routine (e.g. RunGameMode2MapTypeState_SetMapScreenFromAAndCenterPlayer)
; writes: hMapScreenX, hMapScreenY, hPlayerX, hPlayerY
SetMapScreenFromAAndCenterPlayer::
Func_0A1_47C5:: ; address name
    push af
    swap a
    and a, $0F
    ldh [hMapScreenX], a
    pop af
    and a, $0F
    ldh [hMapScreenY], a
    ld a, $40
    ldh [hPlayerX], a
    ldh [hPlayerY], a
    ret

; only called from RunGameMode2State_Case04 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_CopyScrollToHardware_Case04)
; reads: hTemp0, hTemp1, hTemp5, hTemp7, hTempA, hTemp3, hTemp8, hTemp4, ...
; writes: hTemp9, hTempA, hTemp8, hTemp6
RunGameMode2State_Case04_StoreTemp5ValuesToCursorCellX::
Func_0A1_47D8:: ; address name
    call RunGameMode2State_Case04_Sub02_WriteTemp3AndTemp4Etc
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
    cp a, c
    jr c, .check_temp9
    ldh a, [hTemp8]
    bit 7, a
    jr nz, .check_temp9
    ld c, a
    ldh a, [hTemp4]
    dec a
    cp a, c
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
    cp a, $05
    jr nz, .set_temp9
    ldh a, [hTempA]
    inc a
    ldh [hTempA], a
    ld a, e
    add a, $14
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    xor a, a

.set_temp9:
    ldh [hTemp9], a
    pop hl
    inc hl
    pop bc
    dec b
    jr nz, .loop2
    pop de
    ld a, $05
    add a, e
    ld e, a
    jr nc, .check_temp6
    inc d

.check_temp6:
    ldh a, [hTemp6]
    inc a
    cp a, $05
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
    sub a, $19
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    pop bc
    xor a, a

.set_temp6:
    ldh [hTemp6], a
    pop hl
    ld a, $20
    add_a_to_hl
    dec c
    jp nz, .loop
    ret

; only called from RunGameMode2State_Case04_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case04_StoreTemp5ValuesToCursorCellX)
; reads: hPlayerX, hMapScreenX, hPlayerY, hMapScreenY, wGameMode2Byte44, hMapId, hTemp0, hTemp1, ...
; writes: hTemp3, hTemp4, hTemp0, hTemp1, hTemp2, hTemp7, hTemp8, hTemp5, ...
; points at: hTemp7, hTemp8
RunGameMode2State_Case04_Sub02_WriteTemp3AndTemp4Etc::
Func_0A1_4874:: ; address name
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
    call RunGameMode2State_Case04_Sub02_Sub01_WriteMapScreenXAndMapScreenYEtc
    ld a, [wGameMode2Byte44]
    add a, a
    add a, a
    ld hl, WorldMapScreenCellTable
    add_a_to_hl
    ld a, [hl]
    swap a
    and a, $0F
    ldh [hTemp3], a
    ld a, [hl+]
    and a, $0F
    ldh [hTemp4], a
    ld a, [hl+]
    ldh [hTemp0], a
    ld a, [hl+]
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
    and a, $0F
    srl a
    inc a
    cp a, $05
    jr c, .set_temp5
    sub a, $05
    push af
    ld hl, hTemp7
    inc [hl]
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, l
    add a, $19
    ld l, a
    ld a, h
    adc a, $00
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
    and a, $0F
    srl a
    inc a
    inc a
    cp a, $05
    jr c, .set_temp6
    sub a, $05
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
    add a, a
    add a, a
    add a, c
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

; E-0185 (C1: RunGameMode2State_Case04_Sub02_Sub01 reads the record at $497C + 4 * wGameMode2Byte44: width and height from the nibbles of byte 0, then a 24-bit pointer; it adds (hMapScreenX - 2) * 25 and (hMapScreenY - 2) * width * 25, then steps 5 cells per row; each grid is exactly width * height * 25 bytes and the 11 grids fill bank $5D from $45A5 to $7692).
; record: size nibbles (width, height in screens); pointer and bank of the 25-byte-per-screen cell grid
WorldMapScreenCellTable::
Data_0A1_497C:: ; address name
    db $88 ; id 0: size: width in screens (high nibble), height in screens (low nibble)
    dfar WorldMapScreenCells0 ; screen cell grid: 25 bytes (5 x 5) per screen
    db $88 ; id 1: size: width in screens (high nibble), height in screens (low nibble)
    dfar WorldMapScreenCells1 ; screen cell grid: 25 bytes (5 x 5) per screen
    db $CC ; id 2: size: width in screens (high nibble), height in screens (low nibble)
    dfar WorldMapScreenCells2 ; screen cell grid: 25 bytes (5 x 5) per screen
    db $CC ; id 3: size: width in screens (high nibble), height in screens (low nibble)
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

; only called from RunGameMode2State_Case04_Sub02_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case04_Sub02_WriteTemp3AndTemp4Etc)
; reads: hMapId, wLastWarpIndex, wGameMode2Byte44, wKeyWorldActive, wKeyWorldKey, wKeyWorldGoalCell, wKeyWorldGoal
; writes: hMapScreenX, hMapScreenY, hPlayerX, hPlayerY
RunGameMode2State_Case04_Sub02_Sub01_WriteMapScreenXAndMapScreenYEtc::
Func_0A1_49A8:: ; address name
    ldh a, [hMapId]
    ld c, $01
    cp a, $29
    jp z, .check_game_mode2_byte44
    ld c, $02
    cp a, $45
    jp z, .check_game_mode2_byte44
    ld c, $03
    cp a, $68
    jp z, .check_game_mode2_byte44
    ld c, $04
    cp a, $9D
    jp z, .check_game_mode2_byte44
    ld c, $05
    cp a, $A4
    jp z, .check_game_mode2_byte44
    ld c, $06
    cp a, $AF
    jp z, .check_game_mode2_byte44
    ld c, $07
    cp a, $B2
    jp z, .check_game_mode2_byte44
    ld c, $08
    cp a, $C5
    jr z, .check_game_mode2_byte44
    ld c, $09
    cp a, $D0
    jr z, .check_game_mode2_byte44
    ld c, $0A
    cp a, $D9
    jr z, .check_game_mode2_byte44
    ld c, $0B
    cp a, $E2
    jr z, .check_game_mode2_byte44
    cp a, $20
    ret z
    cp a, $30
    ret z
    cp a, $48
    ret z
    cp a, $70
    ret z
    cp a, $A0
    ret z
    cp a, $A8
    ret z
    cp a, $B0
    ret z
    cp a, $B8
    ret z
    cp a, $C8
    ret z
    cp a, $D1
    ret z
    cp a, $DA
    ret z
    ld c, a
    ld hl, WorldMapScreenPositionTable

.skip:
    ld a, [hl]
    cp a, c
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

.check_game_mode2_byte44:
    ld a, [wGameMode2Byte44]
    inc a
    ld c, a
    ld a, [wKeyWorldActive]
    or a, a
    jr z, .skip2
    ld a, [wKeyWorldKey]
    bit 7, a
    jr nz, .skip2
    cp a, c
    jr nz, .skip2
    ld a, [wKeyWorldGoalCell]
    swap a
    and a, $0F
    ldh [hMapScreenX], a
    ld a, [wKeyWorldGoalCell]
    and a, $0F
    ldh [hMapScreenY], a
    ld a, [wKeyWorldGoal]
    and a, $F0
    ldh [hPlayerX], a
    ld a, [wKeyWorldGoal]
    and a, $0F
    swap a
    ldh [hPlayerY], a
    ret

.skip2:
    ld a, c
    dec a
    add a, a
    add a, a
    ld hl, WorldMapStartPositions
    add_a_to_hl
    call LoadMapPositionFromHL
    ret

; hMapScreenX/Y = the nibbles of [HL]; hPlayerX = [HL + 1] & $F0, hPlayerY = ([HL + 1] & $0F) << 4 (E-0118)
; 2 call sites from 1 routine (e.g. RunGameMode2State_Case04_Sub02_Sub01_WriteMapScreenXAndMapScreenYEtc)
; writes: hMapScreenX, hMapScreenY, hPlayerX, hPlayerY
LoadMapPositionFromHL::
Func_0A1_4A77:: ; address name
    ld a, [hl]
    swap a
    and a, $0F
    ldh [hMapScreenX], a
    ld a, [hl]
    and a, $0F
    ldh [hMapScreenY], a
    inc hl
    ld a, [hl]
    and a, $F0
    ldh [hPlayerX], a
    ld a, [hl]
    and a, $0F
    swap a
    ldh [hPlayerY], a
    ret

; wC945 = hFFCB, wC946 = hFFCD, wC947 = hFFCC, wC948 = hFFCE (E-0118)
; 2 call sites from 2 routines (e.g. RunGameMode2State_Case04_StoreTemp5ValuesToCursorCellX, RunGameMode2State_Case04_StoreTemp5ValuesToCursorCellX_Sub01)
; reads: hTemp5, hTemp7, hTemp6, hTemp8
; writes: wCursorCellX, wCursorCellY, wCursorCellW, wCursorCellH
StoreTemp5ValuesToCursorCellX::
Func_0A1_4A91:: ; address name
    ldh a, [hTemp5]
    ld [wCursorCellX], a
    ldh a, [hTemp7]
    ld [wCursorCellY], a
    ldh a, [hTemp6]
    ld [wCursorCellW], a
    ldh a, [hTemp8]
    ld [wCursorCellH], a
    ret

; entry 5 of the `rst $00` table in RunGameMode2State
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wIsCGB
; writes: wBGPaletteUploadRequest, wOBJPaletteUploadRequest
; points at: wDMGPaletteBGP, wBGPaletteBuffer, wGameMode2State
RunGameMode2State_WriteBGPaletteUploadRequestAndOBJPaletteUploadRequest::
Jump_0A1_4AA6:: ; address name
    ld a, [wJoypadPressed]
    bit 1, a
    jr nz, RunGameMode2State_Case02_UploadBGPalettes
    bit 2, a
    jr z, RunGameMode2State_Case02_UploadBGPalettes_CallDrawBlinkingMetaSprite8

; only called from RunGameMode2State_Case02 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_WriteGameMode2State)
; reads: wIsCGB
; writes: wBGPaletteUploadRequest, wOBJPaletteUploadRequest
; points at: wDMGPaletteBGP, wBGPaletteBuffer, wGameMode2State
RunGameMode2State_Case02_UploadBGPalettes::
Func_0A1_4AB1:: ; address name
    ld hl, wDMGPaletteBGP
    ld a, $00
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, .done
    ld hl, wBGPaletteBuffer
    ld bc, $0050
    ld a, $FF
    call FillBytes
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    call UploadBGPalettes

.done:
    ld hl, wGameMode2State
    inc [hl]
    ret

RunGameMode2State_Case02_UploadBGPalettes_CallDrawBlinkingMetaSprite8::
Jump_0A1_4ADC:: ; address name
    call DrawBlinkingMetaSprite8
    call RunGameMode2State_Case02_Sub01_WriteSpriteOriginXAndSpriteOriginYEtc
    call RunGameMode2State_Case02_Sub01_WaitMapType
    call RunGameMode2State_Case02_Sub01_WaitGameMode2Byte50
    call RunGameMode2State_Case02_Sub01_WriteTemp1AndTemp2
    ret

; only called from RunGameMode2State_Case02_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case02_UploadBGPalettes)
; reads: wMapType, hMapId, wKeyWorldActive, wKeyWorldKey, wKeyWorldGoalCell, wKeyWorldGoal, wKeyWorldSlot, wKeyWorldGoalScreen, ...
; writes: hTemp1, hTemp2
RunGameMode2State_Case02_Sub01_WriteTemp1AndTemp2::
Func_0A1_4AEC:: ; address name
    ld a, [wMapType]
    bit 7, a
    jp nz, .check_key_world_active2
    ldh a, [hMapId]
    ld c, $01
    cp a, $30
    jr c, .check_key_world_active
    ld c, $02
    cp a, $48
    jr c, .check_key_world_active
    ld c, $03
    cp a, $70
    jr c, .check_key_world_active
    ld c, $04
    cp a, $A0
    jr c, .check_key_world_active
    ld c, $05
    cp a, $A8
    jr c, .check_key_world_active
    ld c, $06
    cp a, $B0
    jr c, .check_key_world_active
    ld c, $07
    cp a, $B8
    jr c, .check_key_world_active
    ld c, $08
    cp a, $C8
    jr c, .check_key_world_active
    ld c, $09
    cp a, $D1
    jr c, .check_key_world_active
    ld c, $0A
    cp a, $DA
    jr c, .check_key_world_active
    ld c, $0B

.check_key_world_active:
    ld a, [wKeyWorldActive]
    or a, a
    jr z, .skip
    ld a, [wKeyWorldKey]
    cp a, c
    jr nz, .skip
    ld a, [wKeyWorldGoalCell]
    ldh [hTemp1], a
    ld a, [wKeyWorldGoal]
    ldh [hTemp2], a
    call RunGameMode2State_Case02_Sub01_Sub01_Multiply8
    ret

.skip:
    ld a, c
    dec a
    add a, a
    add a, a
    ld hl, WorldMapStartPositions
    add_a_to_hl
    ld a, [hl+]
    ldh [hTemp1], a
    ld a, [hl]
    ldh [hTemp2], a
    call RunGameMode2State_Case02_Sub01_Sub01_Multiply8
    ret

.check_key_world_active2:
    ld a, [wKeyWorldActive]
    or a, a
    jr z, .read_key_world_goal_screen
    ld a, [wKeyWorldKey]
    bit 7, a
    jr z, .read_key_world_goal_screen
    and a, $7F
    ld c, a
    ld a, [wKeyWorldSlot]
    cp a, c
    jr nz, .read_key_world_goal_screen
    ld a, [wKeyWorldGoalCell]
    ldh [hTemp1], a
    ld a, [wKeyWorldGoal]
    ldh [hTemp2], a
    call RunGameMode2State_Case02_Sub01_Sub01_Multiply8
    ret

.read_key_world_goal_screen:
    ld a, [wKeyWorldGoalScreen]
    ldh [hTemp1], a
    ld a, [wKeyWorldGoalPos]
    and a, $F0
    ld c, a
    ld a, [wKeyWorldGoalPos2]
    and a, $F0
    swap a
    or a, c
    ldh [hTemp2], a
    call RunGameMode2State_Case02_Sub01_Sub01_Multiply8
    ret

; only called from RunGameMode2State_Case02_Sub01_Sub01 (E-0047)
; 4 call sites from 1 routine (e.g. RunGameMode2State_Case02_Sub01_WriteTemp1AndTemp2)
; reads: wCursorCellY, hTemp1, wCursorCellH, wCursorCellX, hTemp2, hSpriteOriginX, wCursorCellW, hSpriteOriginY
; writes: hSpriteOriginX, hSpriteOriginY, hSpriteTileOffset, hSpriteAttrXor, hSpriteSetIndex, hSpriteSubIndex, hSpriteOriginXHi, hSpriteOriginYHi
RunGameMode2State_Case02_Sub01_Sub01_Multiply8::
Func_0A1_4BA1:: ; address name
    ld a, [wCursorCellY]
    ld c, a
    ldh a, [hTemp1]
    swap a
    and a, $0F
    sub a, c
    bit 7, a
    jp nz, .return
    cp a, $05
    jp nc, .return
    ld c, $28
    call Multiply8
    ld a, l
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellH]
    ld c, a
    ldh a, [hTemp1]
    and a, $0F
    sub a, c
    bit 7, a
    jr nz, .return
    cp a, $05
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
    and a, $0F
    srl a
    sla a
    sla a
    sla a
    sub a, c
    ld c, a
    ldh a, [hSpriteOriginX]
    add a, c
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellW]
    sla a
    sla a
    sla a
    ld c, a
    ldh a, [hTemp2]
    and a, $0F
    srl a
    sla a
    sla a
    sla a
    sub a, c
    ld c, a
    ldh a, [hSpriteOriginY]
    add a, c
    ldh [hSpriteOriginY], a
    ld a, $20
    ldh [hSpriteTileOffset], a
    ld a, $01
    ldh [hSpriteAttrXor], a
    ld a, $28
    ldh [hSpriteSetIndex], a
    xor a, a
    ldh [hSpriteSubIndex], a
    xor a, a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite

.return:
    ret

; only called from RunGameMode2State_Case02_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case02_UploadBGPalettes)
; reads: wGameMode2Byte50, wMapType, wMapObjectCount, wCursorCellY, wCursorCellH, wCursorCellX, hSpriteOriginX, wCursorCellW, ...
; writes: hSpriteOriginX, hSpriteOriginY, hSpriteTileOffset, hSpriteAttrXor, hSpriteSetIndex, hSpriteSubIndex, hSpriteOriginXHi, hSpriteOriginYHi
; points at: wMapObjects
RunGameMode2State_Case02_Sub01_WaitGameMode2Byte50::
Func_0A1_4C2E:: ; address name
    ld a, [wGameMode2Byte50]
    or a, a
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
    and a, $0F
    sub a, c
    bit 7, a
    jp nz, .restore
    cp a, $05
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
    and a, $0F
    sub a, c
    bit 7, a
    jr nz, .restore
    cp a, $05
    jr nc, .restore
    ld c, $28
    push de
    call Multiply8
    pop de
    ld a, l
    ldh [hSpriteOriginY], a
    ld a, [wCursorCellX]
    add a, a
    add a, a
    add a, a
    ld c, a
    inc de
    ld a, [de]
    swap a
    and a, $0F
    srl a
    add a, a
    add a, a
    add a, a
    sub a, c
    ld c, a
    ldh a, [hSpriteOriginX]
    add a, c
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellW]
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, [de]
    and a, $0F
    srl a
    add a, a
    add a, a
    add a, a
    sub a, c
    ld c, a
    ldh a, [hSpriteOriginY]
    add a, c
    ldh [hSpriteOriginY], a
    ld a, $10
    ldh [hSpriteTileOffset], a
    ld a, $02
    ldh [hSpriteAttrXor], a
    ld a, $27
    ldh [hSpriteSetIndex], a
    xor a, a
    ldh [hSpriteSubIndex], a
    xor a, a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite

.restore:
    pop de
    ld a, $08
    add a, e
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
    and a, $0F
    sub a, c
    bit 7, a
    jp nz, .restore3
    cp a, $05
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
    and a, $0F
    sub a, c
    bit 7, a
    jr nz, .restore3
    cp a, $05
    jr nc, .restore3
    ld c, $28
    push de
    call Multiply8
    pop de
    ld a, l
    ldh [hSpriteOriginY], a
    inc de
    ld a, [de]
    ld hl, $4D94
    add_a_to_hl
    ld a, [wCursorCellX]
    sla a
    sla a
    sla a
    ld c, a
    ld a, [hl]
    swap a
    and a, $0F
    srl a
    sla a
    sla a
    sla a
    sub a, c
    ld c, a
    ldh a, [hSpriteOriginX]
    add a, c
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellW]
    sla a
    sla a
    sla a
    ld c, a
    ld a, [hl]
    and a, $0F
    srl a
    sla a
    sla a
    sla a
    sub a, c
    ld c, a
    ldh a, [hSpriteOriginY]
    add a, c
    ldh [hSpriteOriginY], a
    ld a, $10
    ldh [hSpriteTileOffset], a
    ld a, $02
    ldh [hSpriteAttrXor], a
    ld a, $27
    ldh [hSpriteSetIndex], a
    xor a, a
    ldh [hSpriteSubIndex], a
    xor a, a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite

.restore3:
    pop de
    ld a, $08
    add a, e
    ld e, a
    jr nc, .restore4
    inc d

.restore4:
    pop bc
    dec b
    jp nz, .loop2
    ret
    db $12, $17, $21, $24, $26, $33, $45, $47, $51, $53, $65, $72, $74, $77, $81, $86

; only called from RunGameMode2State_Case02_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case02_UploadBGPalettes)
; reads: wMapType, wGameMode2Byte44, wCursorCellY, wCursorCellH, wCursorCellX, hSpriteOriginX, wCursorCellW, hSpriteOriginY, ...
; writes: hSpriteOriginX, hSpriteOriginY, hSpriteTileOffset, hSpriteAttrXor, hSpriteSetIndex, hSpriteSubIndex, hSpriteOriginXHi, hSpriteOriginYHi
RunGameMode2State_Case02_Sub01_WriteSpriteOriginXAndSpriteOriginYEtc::
Func_0A1_4DA4:: ; address name
    ld a, [wMapType]
    bit 7, a
    jp nz, .skip
    ld a, [wGameMode2Byte44]
    add a, a
    ld hl, WorldMapMarkerLists
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, [de]
    or a, a
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
    and a, $0F
    sub a, c
    bit 7, a
    jp nz, .restore
    cp a, $05
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
    and a, $0F
    sub a, c
    bit 7, a
    jr nz, .restore
    cp a, $05
    jr nc, .restore
    ld c, $28
    push de
    call Multiply8
    pop de
    ld a, l
    ldh [hSpriteOriginY], a
    ld a, [wCursorCellX]
    add a, a
    add a, a
    add a, a
    ld c, a
    inc de
    ld a, [de]
    swap a
    and a, $0F
    srl a
    add a, a
    add a, a
    add a, a
    sub a, c
    ld c, a
    ldh a, [hSpriteOriginX]
    add a, c
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellW]
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, [de]
    and a, $0F
    srl a
    add a, a
    add a, a
    add a, a
    sub a, c
    ld c, a
    ldh a, [hSpriteOriginY]
    add a, c
    ldh [hSpriteOriginY], a
    ld a, $20
    ldh [hSpriteTileOffset], a
    ld a, $01
    ldh [hSpriteAttrXor], a
    ld a, $28
    ldh [hSpriteSetIndex], a
    xor a, a
    ldh [hSpriteSubIndex], a
    xor a, a
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
    cp a, $FF
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
    and a, $0F
    sub a, c
    bit 7, a
    jp nz, .restore2
    cp a, $05
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
    and a, $0F
    sub a, c
    bit 7, a
    jr nz, .restore2
    cp a, $05
    jr nc, .restore2
    ld c, $28
    push de
    call Multiply8
    pop de
    ld a, l
    ldh [hSpriteOriginY], a
    ld a, [wGameMode2Byte50]
    or a, a
    jr nz, .read_cursor_cell_x
    ld a, [de]
    call IsMapScreenAVisited
    or a, a
    jr z, .restore2

.read_cursor_cell_x:
    ld a, [wCursorCellX]
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, $02
    add a, a
    add a, a
    add a, a
    sub a, c
    ld c, a
    ldh a, [hSpriteOriginX]
    add a, c
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellW]
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, $02
    add a, a
    add a, a
    add a, a
    sub a, c
    ld c, a
    ldh a, [hSpriteOriginY]
    add a, c
    ldh [hSpriteOriginY], a
    ld a, $20
    ldh [hSpriteTileOffset], a
    ld a, $01
    ldh [hSpriteAttrXor], a
    ld a, $28
    ldh [hSpriteSetIndex], a
    xor a, a
    ldh [hSpriteSubIndex], a
    xor a, a
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

; only called from RunGameMode2State_Case02_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case02_UploadBGPalettes)
; reads: wMapType
; points at: wKeyWorldObjects
RunGameMode2State_Case02_Sub01_WaitMapType::
Func_0A1_4EE7:: ; address name
    ld a, [wMapType]
    bit 7, a
    ret z
    ld de, wKeyWorldObjects

.skip:
    push de
    ld a, [de]
    cp a, $FF
    jr nz, .next
    pop de
    ret

.next:
    dec de
    dec de
    dec de
    call RunGameMode2State_Case02_Sub01_Sub04_Multiply8
    inc de
    call RunGameMode2State_Case02_Sub01_Sub04_Multiply8
    pop de
    inc de
    inc de
    inc de
    inc de
    jp .skip

; only called from RunGameMode2State_Case02_Sub01_Sub04 (E-0047)
; 2 call sites from 1 routine (e.g. RunGameMode2State_Case02_Sub01_WaitMapType)
; reads: wCursorCellY, wCursorCellH, wGameMode2Byte50, wCursorCellX, hSpriteOriginX, wCursorCellW, hSpriteOriginY
; writes: hSpriteOriginX, hSpriteOriginY, hSpriteTileOffset, hSpriteAttrXor, hSpriteSetIndex, hSpriteSubIndex, hSpriteOriginXHi, hSpriteOriginYHi
RunGameMode2State_Case02_Sub01_Sub04_Multiply8::
Func_0A1_4F0A:: ; address name
    ld a, [wCursorCellY]
    ld c, a
    ld a, [de]
    swap a
    and a, $0F
    sub a, c
    bit 7, a
    ret nz
    cp a, $05
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
    and a, $0F
    sub a, c
    bit 7, a
    ret nz
    cp a, $05
    ret nc
    ld c, $28
    push de
    call Multiply8
    pop de
    ld a, l
    ldh [hSpriteOriginY], a
    ld a, [wGameMode2Byte50]
    or a, a
    jr nz, .read_cursor_cell_x
    ld a, [de]
    call IsMapScreenAVisited
    or a, a
    ret z

.read_cursor_cell_x:
    ld a, [wCursorCellX]
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, $02
    add a, a
    add a, a
    add a, a
    sub a, c
    ld c, a
    ldh a, [hSpriteOriginX]
    add a, c
    ldh [hSpriteOriginX], a
    ld a, [wCursorCellW]
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, $02
    add a, a
    add a, a
    add a, a
    sub a, c
    ld c, a
    ldh a, [hSpriteOriginY]
    add a, c
    ldh [hSpriteOriginY], a
    ld a, $20
    ldh [hSpriteTileOffset], a
    ld a, $01
    ldh [hSpriteAttrXor], a
    ld a, $28
    ldh [hSpriteSetIndex], a
    xor a, a
    ldh [hSpriteSubIndex], a
    xor a, a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    push de
    farcall DrawMetaSprite
    pop de
    ret

; while bit 5 of wFrameCounterLo is set, draws metasprite set 8 at ($4E, $46) (E-0121)
; 1 call site from 1 routine (e.g. RunGameMode2State_Case02_UploadBGPalettes)
; reads: wFrameCounterLo
; writes: hSpriteOriginX, hSpriteOriginY, hSpriteTileOffset, hSpriteAttrXor, hSpriteSetIndex, hSpriteSubIndex, hSpriteOriginXHi, hSpriteOriginYHi
DrawBlinkingMetaSprite8::
Func_0A1_4F8B:: ; address name
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
    xor a, a
    ldh [hSpriteSubIndex], a
    xor a, a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite
    ret

; entry 0 of the `rst $00` table in RunGameMode2State
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: wSpriteSlotCount, wBGPaletteUploadRequest
; points at: wDMGPaletteBGP, wBGPaletteBuffer, wGameMode2State
RunGameMode2State_UploadBGPalettes::
Jump_0A1_4FB8:: ; address name
    xor a, a
    ld [wSpriteSlotCount], a
    ld hl, wDMGPaletteBGP
    ld a, $00
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, .done
    ld hl, wBGPaletteBuffer
    ld bc, $0040
    ld a, $FF
    call FillBytes
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes

.done:
    ld hl, wGameMode2State
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunGameMode2State
; no direct call (reached through a table, a jump or a vector)
; reads: wMapType, wIsCGB
; writes: hScrollX, hScrollY, wOBJPaletteUploadRequest, wBGPaletteUploadRequest
; points at: wDMGPaletteBGP, wOBJPaletteBuffer, wBGPaletteBuffer, wGameMode2State
RunGameMode2State_CopyScrollToHardware::
Jump_0A1_4FE2:: ; address name
    xor a, a
    ldh [hScrollX], a
    ldh [hScrollY], a
    call CopyScrollToHardware
    ld de, Tiles0Gfx_7E_4EB3
    ld b, $7E
    ld hl, vTiles0
    call DecompressToVRAM
    ld de, Tiles0Plus100Gfx_7E_5B0E
    ld b, $7E
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld de, Tiles2Gfx_5D_4001
    ld b, $5D
    ld hl, vTiles2
    call DecompressToVRAM
    ld de, Tiles2Plus500Gfx_5E_4001
    ld b, $5E
    ld hl, vTiles2 + $500
    call DecompressToVRAM
    ld de, $4238
    ld a, $5E
    ld bc, $1412
    ld hl, vBGMap0
    call CopyRectFromBankToVRAM
    call DrawRect12x12FromBankA1
    call RunGameMode2State_Case01_WriteVRAMByteInc
    ld a, [wMapType]
    bit 7, a
    jr nz, .call_run_game_mode2_state_case01_centered_bg
    call RunGameMode2State_Case01_CenteredBGMapOriginForSizeBC
    jr .skip

.call_run_game_mode2_state_case01_centered_bg:
    call RunGameMode2State_Case01_CenteredBGMapOriginForSizeBC_Sub01

.skip:
    ld hl, wDMGPaletteBGP
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, .done
    ld a, $40
    ld de, OBJPaletteBufferData_7E_4BBD
    add a, e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld b, $7E
    ld hl, wOBJPaletteBuffer
    ld c, $08
    call CopyFromBank
    ld de, OBJPaletteBufferPlus8Data_7E_5AF6
    ld b, $7E
    ld hl, wOBJPaletteBuffer + $8
    ld c, $08
    call CopyFromBank
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ld de, BGPaletteBufferData_5D_4139
    ld b, $5D
    ld hl, wBGPaletteBuffer
    ld c, $08
    call CopyFromBank
    ld de, BGPaletteBufferPlus8Data_5E_422F
    ld b, $5E
    ld hl, wBGPaletteBuffer + $8
    ld c, $08
    call CopyFromBank
    ld a, $7F
    ld [wBGPaletteUploadRequest], a

.done:
    ld hl, wGameMode2State
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunGameMode2State
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed
; writes: wGameMode2State
; points at: wGameMode2State
RunGameMode2State_WriteGameMode2State::
Jump_0A1_5095:: ; address name
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_bit2
    call RunGameMode2State_Case02_UploadBGPalettes
    ld a, $06
    ld [wGameMode2State], a
    ret

.check_bit2:
    bit 2, a
    jr z, .call_run_game_mode2_state_case02_wait_frame
    ld hl, wGameMode2State
    inc [hl]
    ret

.call_run_game_mode2_state_case02_wait_frame:
    call RunGameMode2State_Case02_WaitFrameCounterLo
    call RunGameMode2State_Case02_WriteSpriteOriginXAndSpriteOriginY
    call RunGameMode2State_Case02_WaitMapType
    call RunGameMode2State_Case02_WriteTemp1
    ret

; entry 6 of the `rst $00` table in RunGameMode2State
; no direct call (reached through a table, a jump or a vector)
RunGameMode2State_ToEnterGameMode1WithDefaultPalettes::
Jump_0A1_50BB:: ; address name
    call EnterGameMode1WithDefaultPalettes
    ret

; only called from RunGameMode2State_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_CopyScrollToHardware)
; reads: wKeyWorldHeight, wKeyWorldWidth, hTemp4, hTemp5, hTemp0, hTemp1, hTemp2, hTemp3, ...
; writes: hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, hTemp5, hTemp6, hTemp7
; points at: wVisitedScreens, wKeyWorldChunks, wNameGlyphBuf
RunGameMode2State_Case01_CenteredBGMapOriginForSizeBC_Sub01::
Func_0A1_50BF:: ; address name
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
    ld e, a
    ldh a, [hTemp5]
    ld d, a
    ld a, [de]
    call RunGameMode2State_Case01_Sub01_WriteTemp0
    call RunGameMode2State_Case01_Sub01_WriteTemp0
    call RunGameMode2State_Case01_Sub01_WriteTemp0
    call RunGameMode2State_Case01_Sub01_WriteTemp0
    push af
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, $1C
    add a, e
    ld e, a
    jr nc, .set_temp0
    inc d

.set_temp0:
    ld a, e
    ldh [hTemp0], a
    ld a, d
    ldh [hTemp1], a
    pop af
    call RunGameMode2State_Case01_Sub01_WriteTemp0
    call RunGameMode2State_Case01_Sub01_WriteTemp0
    call RunGameMode2State_Case01_Sub01_WriteTemp0
    call RunGameMode2State_Case01_Sub01_WriteTemp0
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, $1C
    add a, e
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
    call RunGameMode2State_Case01_Sub01_WriteTemp0
    call RunGameMode2State_Case01_Sub01_WriteTemp0
    call RunGameMode2State_Case01_Sub01_WriteTemp0
    call RunGameMode2State_Case01_Sub01_WriteTemp0
    push af
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, $1C
    add a, e
    ld e, a
    jr nc, .set_temp03
    inc d

.set_temp03:
    ld a, e
    ldh [hTemp0], a
    ld a, d
    ldh [hTemp1], a
    pop af
    call RunGameMode2State_Case01_Sub01_WriteTemp0
    call RunGameMode2State_Case01_Sub01_WriteTemp0
    call RunGameMode2State_Case01_Sub01_WriteTemp0
    call RunGameMode2State_Case01_Sub01_WriteTemp0
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, $1C
    add a, e
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
    sub a, $7C
    ld e, a
    ld a, d
    sbc a, $00
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
    add a, e
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
    add a, $04
    ld e, a
    ld a, d
    adc a, $00
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
    ld a, $FF
    call WriteVRAMByteInc
    xor a, a
    call WriteVRAMByteInc
    dec b
    jr nz, .loop3
    ld de, wNameGlyphBuf
    ld a, [wCurrentKeyIndex]
    call WriteKeyNameToDE
    call RunGameMode2State_Shared01
    ld de, vTiles1
    call CopyGlyphTilesToVRAM
    ld e, $80
    ld hl, vBGMap0 + $204
    ld b, $0B

.loop4:
    ld a, e
    call WriteVRAMByteInc
    inc e
    dec b
    jr nz, .loop4
    ret

; only called from RunGameMode2State_Case01_Sub01 (E-0047)
; 16 call sites from 1 routine (e.g. RunGameMode2State_Case01_CenteredBGMapOriginForSizeBC_Sub01)
; reads: hTemp0, hTemp1
; writes: hTemp0
RunGameMode2State_Case01_Sub01_WriteTemp0::
Func_0A1_5242:: ; address name
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

; only called from routines of RunGameMode2State (E-0098)
; 2 call sites from 2 routines (e.g. RunGameMode2State_Case01_CenteredBGMapOriginForSizeBC, RunGameMode2State_Case01_CenteredBGMapOriginForSizeBC_Sub01)
; points at: wNameGlyphBuf
RunGameMode2State_Shared01::
Func_0A1_528B:: ; address name
    push hl
    push de
    ld hl, wNameGlyphBuf
    ld bc, $0000

.loop:
    inc b
    ld a, [hl+]
    cp a, $8D
    jr z, .loop
    cp a, $8E
    jr z, .loop
    inc c
    cp a, $F0
    jr z, .skip
    jr .loop

.skip:
    ld a, $0D
    sub a, c
    srl a
    jr z, .done
    ld c, b
    ld b, a
    ld a, c
    add a, b
    ld de, wNameGlyphBuf
    add a, e
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

; only called from RunGameMode2State_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_CopyScrollToHardware)
; reads: wGameMode2Byte44, hMapId
; writes: wStringIndex, wStringCategory, wStringDestLo, wStringDestHi
; points at: wNameGlyphBuf
RunGameMode2State_Case01_CenteredBGMapOriginForSizeBC::
Func_0A1_52D4:: ; address name
    ld a, [wGameMode2Byte44]
    add a, a
    add a, a
    add a, a
    ld hl, WorldMapViewTable
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    push hl
    push de
    call CenteredBGMapOriginForSizeBC
    pop de
    ld a, $5D
    call CopyRectFromBankToVRAM
    pop hl
    ld hl, vTiles1
    ld b, $58

.loop:
    ld a, $FF
    call WriteVRAMByteInc
    xor a, a
    call WriteVRAMByteInc
    dec b
    jr nz, .loop
    ldh a, [hMapId]
    add a, $0A
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    ld de, wNameGlyphBuf
    ld a, e
    ld [wStringDestLo], a
    ld a, d
    ld [wStringDestHi], a
    farcall CopyStringToBuffer_Bank08
    call RunGameMode2State_Shared01
    ld de, vTiles1
    call CopyGlyphTilesToVRAM
    ld e, $80
    ld hl, vBGMap0 + $204
    ld b, $0B

.loop2:
    ld a, e
    call WriteVRAMByteInc
    inc e
    dec b
    jr nz, .loop2
    ret

; E-0167 (C1: RunGameMode2State_Case01_Sub02 takes entry 8 * wGameMode2Byte44, centres a rectangle of these rows and width (CenteredBGMapOriginForSizeBC) and copies it from bank $5D with CopyRectFromBankToVRAM; 11 entries whose rectangles are contiguous from $41B9 to $43AE).
; record: tile rectangle in bank $5D; rows, width; a map number ($20, $30, $48 ...) and three zero bytes; not read here
WorldMapViewTable::
Data_0A1_533C:: ; address name
    dw WorldMapView0 ; id 0: tile rectangle in bank $5D
    db $08, $08 ; rows, width
    db $20, $00, $00, $00 ; a map number ($20, $30, $48 ...) and three zero bytes; not read here
    dw WorldMapView1 ; id 1: tile rectangle in bank $5D
    db $08, $08 ; rows, width
    db $30, $00, $00, $00 ; a map number ($20, $30, $48 ...) and three zero bytes; not read here
    dw WorldMapView2 ; id 2: tile rectangle in bank $5D
    db $0C, $0C ; rows, width
    db $48, $00, $00, $00 ; a map number ($20, $30, $48 ...) and three zero bytes; not read here
    dw WorldMapView3 ; id 3: tile rectangle in bank $5D
    db $0C, $0C ; rows, width
    db $70, $00, $00, $00 ; a map number ($20, $30, $48 ...) and three zero bytes; not read here
    dw WorldMapView4 ; id 4: tile rectangle in bank $5D
    db $03, $04 ; rows, width
    db $A0, $00, $00, $00 ; a map number ($20, $30, $48 ...) and three zero bytes; not read here
    dw WorldMapView5 ; id 5: tile rectangle in bank $5D
    db $06, $06 ; rows, width
    db $A8, $00, $00, $00 ; a map number ($20, $30, $48 ...) and three zero bytes; not read here
    dw WorldMapView6 ; id 6: tile rectangle in bank $5D
    db $02, $03 ; rows, width
    db $B0, $00, $00, $00 ; a map number ($20, $30, $48 ...) and three zero bytes; not read here
    dw WorldMapView7 ; id 7: tile rectangle in bank $5D
    db $05, $05 ; rows, width
    db $B8, $00, $00, $00 ; a map number ($20, $30, $48 ...) and three zero bytes; not read here
    dw WorldMapView8 ; id 8: tile rectangle in bank $5D
    db $02, $01 ; rows, width
    db $C8, $00, $00, $00 ; a map number ($20, $30, $48 ...) and three zero bytes; not read here
    dw WorldMapView9 ; id 9: tile rectangle in bank $5D
    db $02, $01 ; rows, width
    db $D1, $00, $00, $00 ; a map number ($20, $30, $48 ...) and three zero bytes; not read here
    dw WorldMapView10 ; id 10: tile rectangle in bank $5D
    db $01, $02 ; rows, width
    db $DA, $00, $00, $00 ; a map number ($20, $30, $48 ...) and three zero bytes; not read here

; only called from RunGameMode2State_Case02 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_WriteGameMode2State)
; reads: wMapType, hMapId, wKeyWorldActive, wKeyWorldKey, wKeyWorldGoalCell, wKeyWorldSlot, wKeyWorldGoalScreen
; writes: hTemp1
RunGameMode2State_Case02_WriteTemp1::
Func_0A1_5394:: ; address name
    ld a, [wMapType]
    bit 7, a
    jp nz, .check_key_world_active2
    ldh a, [hMapId]
    ld c, $01
    cp a, $30
    jr c, .check_key_world_active
    ld c, $02
    cp a, $48
    jr c, .check_key_world_active
    ld c, $03
    cp a, $70
    jr c, .check_key_world_active
    ld c, $04
    cp a, $A0
    jr c, .check_key_world_active
    ld c, $05
    cp a, $A8
    jr c, .check_key_world_active
    ld c, $06
    cp a, $B0
    jr c, .check_key_world_active
    ld c, $07
    cp a, $B8
    jr c, .check_key_world_active
    ld c, $08
    cp a, $C8
    jr c, .check_key_world_active
    ld c, $09
    cp a, $D1
    jr c, .check_key_world_active
    ld c, $0A
    cp a, $DA
    jr c, .check_key_world_active
    ld c, $0B

.check_key_world_active:
    ld a, [wKeyWorldActive]
    or a, a
    jr z, .skip
    ld a, [wKeyWorldKey]
    cp a, c
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
    or a, a
    jr z, .read_key_world_goal_screen
    ld a, [wKeyWorldKey]
    bit 7, a
    jr z, .read_key_world_goal_screen
    and a, $7F
    ld c, a
    ld a, [wKeyWorldSlot]
    cp a, c
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

; draws metasprite set $26 at X = 8 * (wC945 + 8 * high nibble of hFFC7), Y = 8 * (wC946 + 8 * low nibble) (E-0121)
; 4 call sites from 1 routine (e.g. RunGameMode2State_Case02_WriteTemp1)
; reads: hTemp1, wCursorCellX, wCursorCellY
; writes: hSpriteOriginX, hSpriteOriginY, hSpriteTileOffset, hSpriteAttrXor, hSpriteSetIndex, hSpriteSubIndex, hSpriteOriginXHi, hSpriteOriginYHi
DrawCursorSpriteAtTemp1Cell::
Func_0A1_542E:: ; address name
    ldh a, [hTemp1]
    and a, $F0
    swap a
    sla a
    sla a
    sla a
    ld c, a
    ld a, [wCursorCellX]
    sla a
    sla a
    sla a
    add a, c
    ldh [hSpriteOriginX], a
    ldh a, [hTemp1]
    and a, $0F
    sla a
    sla a
    sla a
    ld c, a
    ld a, [wCursorCellY]
    sla a
    sla a
    sla a
    add a, c
    ldh [hSpriteOriginY], a
    ld a, $10
    ldh [hSpriteTileOffset], a
    ld a, $01
    ldh [hSpriteAttrXor], a
    ld a, $26
    ldh [hSpriteSetIndex], a
    xor a, a
    ldh [hSpriteSubIndex], a
    xor a, a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite
    ret

; only called from RunGameMode2State_Case02 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_WriteGameMode2State)
; reads: wFrameCounterLo, wMapType, hMapId, wLastWarpIndex, hMapScreenX, hMapScreenY, wKeyWorldActive, wKeyWorldKey, ...
RunGameMode2State_Case02_WaitFrameCounterLo::
Func_0A1_5479:: ; address name
    ld a, [wFrameCounterLo]
    bit 5, a
    ret z
    ld a, [wMapType]
    bit 7, a
    jp nz, SetSpriteYFromCursorCellY_CheckMapType
    ldh a, [hMapId]
    ld c, $01
    cp a, $29
    jp z, SetSpriteYFromCursorCellY_SetSpriteXFromCursorCellX_CheckKeyWorldActive
    ld c, $02
    cp a, $45
    jp z, SetSpriteYFromCursorCellY_SetSpriteXFromCursorCellX_CheckKeyWorldActive
    ld c, $03
    cp a, $68
    jp z, SetSpriteYFromCursorCellY_SetSpriteXFromCursorCellX_CheckKeyWorldActive
    ld c, $04
    cp a, $9D
    jp z, SetSpriteYFromCursorCellY_SetSpriteXFromCursorCellX_CheckKeyWorldActive
    ld c, $05
    cp a, $A4
    jp z, SetSpriteYFromCursorCellY_SetSpriteXFromCursorCellX_CheckKeyWorldActive
    ld c, $06
    cp a, $AF
    jp z, SetSpriteYFromCursorCellY_SetSpriteXFromCursorCellX_CheckKeyWorldActive
    ld c, $07
    cp a, $B2
    jp z, SetSpriteYFromCursorCellY_SetSpriteXFromCursorCellX_CheckKeyWorldActive
    ld c, $08
    cp a, $C5
    jr z, SetSpriteYFromCursorCellY_SetSpriteXFromCursorCellX_CheckKeyWorldActive
    ld c, $09
    cp a, $D0
    jr z, SetSpriteYFromCursorCellY_SetSpriteXFromCursorCellX_CheckKeyWorldActive
    ld c, $0A
    cp a, $D9
    jr z, SetSpriteYFromCursorCellY_SetSpriteXFromCursorCellX_CheckKeyWorldActive
    ld c, $0B
    cp a, $E2
    jr z, SetSpriteYFromCursorCellY_SetSpriteXFromCursorCellX_CheckKeyWorldActive
    cp a, $20
    jr z, SetSpriteYFromCursorCellY_SetSpriteXFromCursorCellX
    cp a, $30
    jr z, SetSpriteYFromCursorCellY_SetSpriteXFromCursorCellX
    cp a, $48
    jr z, SetSpriteYFromCursorCellY_SetSpriteXFromCursorCellX
    cp a, $70
    jr z, SetSpriteYFromCursorCellY_SetSpriteXFromCursorCellX
    cp a, $A0
    jr z, SetSpriteYFromCursorCellY_SetSpriteXFromCursorCellX
    cp a, $A8
    jr z, SetSpriteYFromCursorCellY_SetSpriteXFromCursorCellX
    cp a, $B0
    jr z, SetSpriteYFromCursorCellY_SetSpriteXFromCursorCellX
    cp a, $B8
    jr z, SetSpriteYFromCursorCellY_SetSpriteXFromCursorCellX
    cp a, $C8
    jr z, SetSpriteYFromCursorCellY_SetSpriteXFromCursorCellX
    cp a, $D1
    jr z, SetSpriteYFromCursorCellY_SetSpriteXFromCursorCellX
    cp a, $DA
    jr z, SetSpriteYFromCursorCellY_SetSpriteXFromCursorCellX
    ld c, a
    ld hl, WorldMapCursorCellTable

.skip:
    ld a, [hl]
    cp a, c
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
    ld a, [hl+]
    call SetSpriteXFromCursorCellX
    ld a, [hl]
    call SetSpriteYFromCursorCellY
    call DrawMetaSpriteSet08
    ret

; entry 0 of the `rst $00` table in SetSpriteYFromCursorCellY
; no direct call (reached through a table, a jump or a vector)
; reads: hMapScreenX, hMapScreenY
SetSpriteYFromCursorCellY_SetSpriteXFromCursorCellX::
Jump_0A1_5523:: ; address name
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

SetSpriteYFromCursorCellY_SetSpriteXFromCursorCellX_CheckKeyWorldActive::
Jump_0A1_553D:: ; address name
    ld a, [wKeyWorldActive]
    or a, a
    jr z, .check_key_world_goal_screen
    ld a, [wKeyWorldKey]
    cp a, c
    jr nz, .check_key_world_goal_screen
    ld a, [wKeyWorldGoalCell]
    and a, $F0
    swap a
    add a, a
    add a, a
    add a, a
    call SetSpriteXFromCursorCellX
    ld a, [wKeyWorldGoalCell]
    and a, $0F
    add a, a
    add a, a
    add a, a
    call SetSpriteYFromCursorCellY
    call DrawMetaSpriteSet08
    ret

.check_key_world_goal_screen:
    ld a, [wKeyWorldGoalScreen]
    and a, $F0
    swap a
    add a, a
    add a, a
    add a, a
    call SetSpriteXFromCursorCellX
    ld a, [wKeyWorldGoalScreen]
    and a, $0F
    add a, a
    add a, a
    add a, a
    call SetSpriteYFromCursorCellY
    call DrawMetaSpriteSet08
    ret

; hSpriteOriginX = 8 * wC945 + A + 6 (E-0122)
; 4 call sites from 2 routines (e.g. RunGameMode2State_Case02_WaitFrameCounterLo, SetSpriteYFromCursorCellY_SetSpriteXFromCursorCellX)
; reads: wCursorCellX
; writes: hSpriteOriginX
SetSpriteXFromCursorCellX::
Func_0A1_5581:: ; address name
    ld c, a
    ld a, [wCursorCellX]
    sla a
    sla a
    sla a
    add a, c
    add a, $06
    ldh [hSpriteOriginX], a
    ret

; hSpriteOriginY = 8 * wC946 + A + 6; the next entry dispatches on wCC44 & 7 (E-0124)
; 4 call sites from 2 routines (e.g. RunGameMode2State_Case02_WaitFrameCounterLo, SetSpriteYFromCursorCellY_SetSpriteXFromCursorCellX)
; reads: wCursorCellY
; writes: hSpriteOriginY
SetSpriteYFromCursorCellY::
Func_0A1_5591:: ; address name
    ld c, a
    ld a, [wCursorCellY]
    sla a
    sla a
    sla a
    add a, c
    add a, $06
    ldh [hSpriteOriginY], a
    ret

SetSpriteYFromCursorCellY_CheckMapType::
Jump_0A1_55A1:: ; address name
    ld a, [wMapType]
    and a, $07
    rst $00
    dw SetSpriteYFromCursorCellY_SetSpriteXFromCursorCellX
    dw SetSpriteYFromCursorCellY_SetSpriteXYFromCellA
    dw SetSpriteYFromCursorCellY_SetSpriteXYFromCellA
    dw SetSpriteYFromCursorCellY_SetSpriteXYFromCellA_Case03
    dw SetSpriteYFromCursorCellY_SetSpriteXYFromCellA_Case03
    dw SetSpriteYFromCursorCellY_SetSpriteXYFromCellA_Case03
    dw SetSpriteYFromCursorCellY_SetSpriteXYFromCellA_Case03
    dw SetSpriteYFromCursorCellY_SetSpriteXYFromCellA_Case07

; entry 1 of the `rst $00` table in SetSpriteYFromCursorCellY
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldFloor
; points at: wKeyWorldAreaExits
SetSpriteYFromCursorCellY_SetSpriteXYFromCellA::
Jump_0A1_55B7:: ; address name
    ld a, [wKeyWorldFloor]
    and a, $07
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

; entry 3 of the `rst $00` table in SetSpriteYFromCursorCellY
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldFloor
; points at: wKeyWorldFloorInfo
SetSpriteYFromCursorCellY_SetSpriteXYFromCellA_Case03::
Jump_0A1_55D5:: ; address name
    ld a, [wKeyWorldFloor]
    and a, $07
    add a, a
    add a, a
    ld hl, wKeyWorldFloorInfo
    add_a_to_hl
    ld a, [hl]
    call SetSpriteXYFromCellA
    ret

; entry 7 of the `rst $00` table in SetSpriteYFromCursorCellY
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldActive, wKeyWorldKey, wKeyWorldSlot, wKeyWorldGoalCell, wKeyWorldGoalScreen
SetSpriteYFromCursorCellY_SetSpriteXYFromCellA_Case07::
Jump_0A1_55E9:: ; address name
    ld a, [wKeyWorldActive]
    or a, a
    jr z, .read_key_world_goal_screen
    ld a, [wKeyWorldKey]
    bit 7, a
    jr z, .read_key_world_goal_screen
    and a, $7F
    ld c, a
    ld a, [wKeyWorldSlot]
    cp a, c
    jr nz, .read_key_world_goal_screen
    ld a, [wKeyWorldGoalCell]
    call SetSpriteXYFromCellA
    ret

.read_key_world_goal_screen:
    ld a, [wKeyWorldGoalScreen]
    call SetSpriteXYFromCellA
    ret

; hSpriteOriginX = 8 * wC945 + (A >> 4) * 8 + 6 and hSpriteOriginY = 8 * wC946 + (A & $0F) * 8 + 6 (E-0124)
; 4 call sites from 3 routines (e.g. SetSpriteYFromCursorCellY_SetSpriteXYFromCellA_Case07, SetSpriteYFromCursorCellY_SetSpriteXYFromCellA_Case03, SetSpriteYFromCursorCellY_SetSpriteXYFromCellA)
; reads: wCursorCellX, wCursorCellY
; writes: hSpriteOriginX, hSpriteOriginY, hSpriteTileOffset, hSpriteAttrXor, hSpriteSetIndex, hSpriteSubIndex, hSpriteOriginXHi, hSpriteOriginYHi
SetSpriteXYFromCellA::
Func_0A1_560D:: ; address name
    push af
    and a, $F0
    srl a
    ld c, a
    ld a, [wCursorCellX]
    sla a
    sla a
    sla a
    add a, c
    add a, $06
    ldh [hSpriteOriginX], a
    pop af
    and a, $0F
    sla a
    sla a
    sla a
    ld c, a
    ld a, [wCursorCellY]
    sla a
    sla a
    sla a
    add a, c
    add a, $06
    ldh [hSpriteOriginY], a

; DrawMetaSprite with set $08, sub-index 0, no tile offset or attribute change (origin high bytes 0) (E-0118)
; 4 call sites from 2 routines (e.g. RunGameMode2State_Case02_WaitFrameCounterLo, SetSpriteYFromCursorCellY_SetSpriteXFromCursorCellX)
; writes: hSpriteTileOffset, hSpriteAttrXor, hSpriteSetIndex, hSpriteSubIndex, hSpriteOriginXHi, hSpriteOriginYHi
DrawMetaSpriteSet08::
Func_0A1_5639:: ; address name
    ld a, $00
    ldh [hSpriteTileOffset], a
    ld a, $00
    ldh [hSpriteAttrXor], a
    ld a, $08
    ldh [hSpriteSetIndex], a
    xor a, a
    ldh [hSpriteSubIndex], a
    xor a, a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite
    ret

; only called from RunGameMode2State_Case02 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_WriteGameMode2State)
; reads: wMapType, wGameMode2Byte44, wCursorCellX, wCursorCellY, wGameMode2Byte50
; writes: hSpriteOriginX, hSpriteOriginY
RunGameMode2State_Case02_WriteSpriteOriginXAndSpriteOriginY::
Func_0A1_5654:: ; address name
    ld a, [wMapType]
    bit 7, a
    jr nz, .skip
    ld a, [wGameMode2Byte44]
    add a, a
    ld hl, WorldMapCursorSpriteLists
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, [de]
    or a, a
    ret z
    inc de
    ld b, a

.loop:
    push bc
    push de
    ld a, [de]
    ld c, a
    ld a, [wCursorCellX]
    add a, a
    add a, a
    add a, a
    add a, c
    ldh [hSpriteOriginX], a
    inc de
    ld a, [de]
    ld c, a
    ld a, [wCursorCellY]
    add a, a
    add a, a
    add a, a
    add a, c
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
    cp a, $FF
    ret z
    push de
    dec de
    dec de
    dec de
    ld a, [de]
    ld a, [wGameMode2Byte50]
    or a, a
    jr nz, .skip3
    ld a, [de]
    call IsMapScreenAVisited
    or a, a
    jr z, .restore

.skip3:
    ld a, [de]
    swap a
    and a, $0F
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, [wCursorCellX]
    add a, a
    add a, a
    add a, a
    add a, c
    ldh [hSpriteOriginX], a
    ld a, [de]
    and a, $0F
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, [wCursorCellY]
    add a, a
    add a, a
    add a, a
    add a, c
    ldh [hSpriteOriginY], a
    call DrawMetaSpriteSet26

.restore:
    pop de
    ld a, $04
    add a, e
    ld e, a
    jr nc, .skip4
    inc d

.skip4:
    jr .skip2

; DrawMetaSprite with set $26, sub-index 0, tile offset $10, attribute XOR $01 (origin high bytes 0) (E-0118)
; 2 call sites from 1 routine (e.g. RunGameMode2State_Case02_WriteSpriteOriginXAndSpriteOriginY)
; writes: hSpriteTileOffset, hSpriteAttrXor, hSpriteSetIndex, hSpriteSubIndex, hSpriteOriginXHi, hSpriteOriginYHi
DrawMetaSpriteSet26::
Func_0A1_56DC:: ; address name
    ld a, $10
    ldh [hSpriteTileOffset], a
    ld a, $01
    ldh [hSpriteAttrXor], a
    ld a, $26
    ldh [hSpriteSetIndex], a
    xor a, a
    ldh [hSpriteSubIndex], a
    xor a, a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite
    ret

; only called from RunGameMode2State_Case02 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_WriteGameMode2State)
; reads: wMapType
; points at: wKeyWorldObjects
RunGameMode2State_Case02_WaitMapType::
Func_0A1_56F7:: ; address name
    ld a, [wMapType]
    bit 7, a
    ret z
    ld de, wKeyWorldObjects

.skip:
    ld a, [de]
    cp a, $FF
    ret z
    push de
    dec de
    dec de
    dec de
    call RunGameMode2State_Case02_Sub05_IsMapScreenAVisited
    inc de
    call RunGameMode2State_Case02_Sub05_IsMapScreenAVisited
    pop de
    ld a, $04
    add a, e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    jr .skip

; only called from RunGameMode2State_Case02_Sub05 (E-0047)
; 2 call sites from 1 routine (e.g. RunGameMode2State_Case02_WaitMapType)
; reads: wGameMode2Byte50, wCursorCellX, wCursorCellY
; writes: hSpriteOriginX, hSpriteOriginY, hSpriteTileOffset, hSpriteAttrXor, hSpriteSetIndex, hSpriteSubIndex, hSpriteOriginXHi, hSpriteOriginYHi
RunGameMode2State_Case02_Sub05_IsMapScreenAVisited::
Func_0A1_5719:: ; address name
    ld a, [wGameMode2Byte50]
    or a, a
    jr nz, .skip
    ld a, [de]
    call IsMapScreenAVisited
    or a, a
    ret z

.skip:
    ld a, [de]
    swap a
    and a, $0F
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, [wCursorCellX]
    add a, a
    add a, a
    add a, a
    add a, c
    ldh [hSpriteOriginX], a
    ld a, [de]
    and a, $0F
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, [wCursorCellY]
    add a, a
    add a, a
    add a, a
    add a, c
    ldh [hSpriteOriginY], a
    ld a, $10
    ldh [hSpriteTileOffset], a
    ld a, $01
    ldh [hSpriteAttrXor], a
    ld a, $26
    ldh [hSpriteSetIndex], a
    xor a, a
    ldh [hSpriteSubIndex], a
    xor a, a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    push de
    farcall DrawMetaSprite
    pop de
    ret

; row = 9 - C/2 (wC946), column = 10 - B/2 (wC945); HL = vBGMap0 + 32 * row + column (E-0121)
; 2 call sites from 2 routines (e.g. RunGameMode2State_Case01_CenteredBGMapOriginForSizeBC, RunGameMode2State_Case01_CenteredBGMapOriginForSizeBC_Sub01)
; writes: wCursorCellY, wCursorCellX
CenteredBGMapOriginForSizeBC::
Func_0A1_5764:: ; address name
    ld a, c
    srl a
    ld l, a
    ld a, $09
    sub a, l
    ld [wCursorCellY], a
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $98
    ld h, a
    ld a, b
    srl a
    ld e, a
    ld a, $0A
    sub a, e
    ld [wCursorCellX], a
    add_a_to_hl
    ret

; fills the $400 bytes of vBGMap0 with tile $57 (E-0122)
; 1 call site from 1 routine (e.g. RunGameMode2State_CopyScrollToHardware_Case04)
FillBGMap0With57::
Func_0A1_578E:: ; address name
    ld hl, vBGMap0
    ld bc, $0400

.loop:
    ld a, $57
    call WriteVRAMByteInc
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ret

; only called from RunGameMode2State_Case04 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_CopyScrollToHardware_Case04)
; reads: wIsCGB
RunGameMode2State_Case04_WriteVRAMByteInc::
Func_0A1_579F:: ; address name
    ld a, [wIsCGB]
    or a, a
    ret z
    ld c, $4F
    ld a, $01
    ldh [c], a
    ld hl, vBGMap0
    ld bc, $0400

.loop:
    xor a, a
    call WriteVRAMByteInc
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ld c, $4F
    ld a, $00
    ldh [c], a
    ret

; only called from RunGameMode2State_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode2State_CopyScrollToHardware)
; reads: wIsCGB
RunGameMode2State_Case01_WriteVRAMByteInc::
Func_0A1_57BE:: ; address name
    ld a, [wIsCGB]
    or a, a
    ret z
    ld c, $4F
    ld a, $01
    ldh [c], a
    ld hl, vBGMap0
    ld bc, $0400

.loop:
    ld a, $01
    call WriteVRAMByteInc
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ld hl, vBGMap0 + $64
    ld c, $0C

.loop2:
    push hl
    ld b, $0C

.loop3:
    xor a, a
    call WriteVRAMByte
    inc hl
    dec b
    jr nz, .loop3
    pop hl
    ld a, $20
    add_a_to_hl
    dec c
    jr nz, .loop2
    ld c, $4F
    ld a, $00
    ldh [c], a
    ret

; copies a 12 x 12 tile rectangle from A1:$5808 to vBGMap0 + $64 (CopyRectFromBankToVRAM) (E-0116)
; 1 call site from 1 routine (e.g. RunGameMode2State_CopyScrollToHardware)
DrawRect12x12FromBankA1::
Func_0A1_57F9:: ; address name
    ld de, $5808
    ld bc, $0C0C
    ld hl, vBGMap0 + $64
    ld a, $A1
    call CopyRectFromBankToVRAM
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 12 x 12 tiles, one row per line
TileRect_A1_5808::
Data_0A1_5808:: ; address name
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

; wC5E0 = 3, wDataBankSave = $40, far-calls Func_002_4628, sets the default DMG palette bytes ($D2, $D2, $E2) and wGameMode = 1 (E-0118)
; 1 call site from 1 routine (e.g. RunGameMode2State_ToEnterGameMode1WithDefaultPalettes)
; writes: wFieldInitStage, wDataBankSave, wGameMode
; points at: wDMGPaletteBGP
EnterGameMode1WithDefaultPalettes::
Func_0A1_5898:: ; address name
    ld a, $03
    ld [wFieldInitStage], a
    ld a, $40
    ld [wDataBankSave], a
    farcall InitFieldScreen
    ld hl, wDMGPaletteBGP
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld a, $01
    ld [wGameMode], a
    ret

; A = 1 when the bit for screen A (high nibble x, low nibble y) is set in wCE93, else 0 (E-0125)
; 5 call sites from 5 routines (e.g. RunGameMode2State_Case02_Sub01_Sub04_Multiply8, RunGameMode2State_Case02_Sub01_WriteSpriteOriginXAndSpriteOriginYEtc, RunGameMode2State_Case04_StoreTemp5ValuesToCursorCellX_Sub01, RunGameMode2State_Case02_Sub05_IsMapScreenAVisited, ...)
; reads: hTemp0
; writes: hTemp0
; points at: wVisitedScreens
IsMapScreenAVisited::
Func_0A1_58BA:: ; address name
    push bc
    push hl
    ldh [hTemp0], a
    and a, $0F
    and a, $FC
    ld hl, wVisitedScreens
    add_a_to_hl
    ldh a, [hTemp0]
    swap a
    and a, $0F
    srl a
    and a, $FE
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
    and a, $03
    jr z, .skip2
    ld b, a

.loop:
    sla c
    dec b
    jr nz, .loop

.skip2:
    ld a, [hl]
    and a, c
    jr nz, .skip3
    xor a, a
    pop hl
    pop bc
    ret

.skip3:
    ld a, $01
    pop hl
    pop bc
    ret

; only called from routines of FieldModeStateDispatch (E-0098)
; 2 call sites from 2 routines (e.g. FieldModeStateDispatch_UpdatePlayerMovement, FieldModeStateDispatch_UpdatePlayerMovement_Case05)
; reads: wFadeState, wTextWindowState, wFieldActionRequest, hPlayerStateFlags, wMapType, hMapId
; writes: hTemp0, wGameMode2Byte44, wFieldReturnPhase, wModeState, wGameMode2State
FieldModeStateDispatch_WriteTemp0AndGameMode2Byte44Etc::
Func_0A1_5903:: ; address name
    xor a, a
    ldh [hTemp0], a
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wTextWindowState]
    and a, $03
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
    cp a, $20
    ret c
    ld c, $00
    cp a, $30
    jr c, .set_game_mode2_byte44
    inc c
    cp a, $48
    jr c, .set_game_mode2_byte44
    inc c
    cp a, $70
    jr c, .set_game_mode2_byte44
    inc c
    cp a, $A0
    jr c, .set_game_mode2_byte44
    inc c
    cp a, $A8
    jr c, .set_game_mode2_byte44
    inc c
    cp a, $B0
    jr c, .set_game_mode2_byte44
    inc c
    cp a, $B8
    jr c, .set_game_mode2_byte44
    inc c
    cp a, $C8
    jr c, .set_game_mode2_byte44
    inc c
    cp a, $D1
    jr c, .set_game_mode2_byte44
    inc c
    cp a, $DA
    jr c, .set_game_mode2_byte44
    inc c

.set_game_mode2_byte44:
    ld a, c
    ld [wGameMode2Byte44], a
    ld a, $01
    ldh [hTemp0], a
    ld a, $01
    ld [wFieldReturnPhase], a
    farcall SaveScreenBufferToBGMap1
    ld a, $08
    ld [wModeState], a
    ldh a, [hMapId]
    cp a, $20
    jr z, .clear_game_mode2_state
    cp a, $30
    jr z, .clear_game_mode2_state
    cp a, $48
    jr z, .clear_game_mode2_state
    cp a, $70
    jr z, .clear_game_mode2_state
    cp a, $A0
    jr z, .clear_game_mode2_state
    cp a, $A8
    jr z, .clear_game_mode2_state
    cp a, $B0
    jr z, .clear_game_mode2_state
    cp a, $B8
    jr z, .clear_game_mode2_state
    cp a, $C8
    jr z, .clear_game_mode2_state
    cp a, $D1
    jr z, .clear_game_mode2_state
    cp a, $DA
    jr z, .clear_game_mode2_state
    ld a, $03
    ld [wGameMode2State], a
    ret

.clear_game_mode2_state:
    xor a, a
    ld [wGameMode2State], a
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
    and a, $7F
    jr nz, .set_game_mode2_state_to_03
    xor a, a
    ld [wGameMode2State], a
    ret

.set_game_mode2_state_to_03:
    ld a, $03
    ld [wGameMode2State], a
    ret
    db $01, $01

; E-0215 (C1: RunGameMode2State_Case04_Sub02_Sub01_WriteMapScreenXAndMapScreenYEtc.skip2 reads the record at $59D6 + 4 * wGameMode2Byte44 with LoadMapPositionFromHL (hMapScreenX/Y, hPlayerX/Y from nibbles); 11 indexes, so record 10's first two bytes are the tail and its other two would be WorldMapCursorSpriteLists' first word).
; record: screen X/Y and position X/Y nibbles; two bytes not read here
WorldMapStartPositions::
Data_0A1_59D6:: ; address name
    db $00, $44, $39, $31 ; id 0
    db $76, $44, $59, $21 ; id 1
    db $B4, $44, $59, $21 ; id 2
    db $B4, $44, $09, $01 ; id 3
    db $10, $44, $01, $01 ; id 4
    db $00, $44, $01, $09 ; id 5
    db $01, $44, $21, $21 ; id 6
    db $44, $44, $01, $09 ; id 7
    db $01, $44, $01, $01 ; id 8
    db $00, $44, $01, $01 ; id 9
    db $00, $44 ; end

; E-0215 (C1: Func_0A1_5654 reads word wGameMode2Byte44 and draws DrawMetaSpriteSet26 once per entry at wCursorCellX * 8 + X, wCursorCellY * 8 + Y; the lists run to $5A49).
; record: list
WorldMapCursorSpriteLists::
Data_0A1_5A00:: ; address name
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

; E-0199 (derived: list for entry $00 of WorldMapCursorSpriteLists; it runs to the next list)
; record: count, then an X offset and a Y offset (from the cursor cell) per sprite
WorldMapCursorSprites000::
Data_0A1_5A16:: ; address name
    db $02, $11, $09, $11, $29 ; id 0

; E-0199 (derived: list for entry $01 of WorldMapCursorSpriteLists; it runs to the next list)
; record: count, then an X offset and a Y offset (from the cursor cell) per sprite
WorldMapCursorSprites001::
Data_0A1_5A1B:: ; address name
    db $03, $29, $31, $21, $11, $11, $21 ; id 0

; E-0199 (derived: list for entry $02 of WorldMapCursorSpriteLists; it runs to the next list)
; record: count, then an X offset and a Y offset (from the cursor cell) per sprite
WorldMapCursorSprites002::
Data_0A1_5A22:: ; address name
    db $05, $41, $11, $39, $29, $21, $41, $11, $49, $49, $49 ; id 0

; E-0199 (derived: list for entry $03 of WorldMapCursorSpriteLists; it runs to the next list)
; record: count, then an X offset and a Y offset (from the cursor cell) per sprite
WorldMapCursorSprites003::
Data_0A1_5A2D:: ; address name
    db $03, $59, $09, $29, $31, $29, $49 ; id 0

; E-0199 (derived: list for entry $04 of WorldMapCursorSpriteLists; it runs to the next list)
; record: count, then an X offset and a Y offset (from the cursor cell) per sprite
WorldMapCursorSprites004::
Data_0A1_5A34:: ; address name
    db $00 ; id 0

; E-0199 (derived: list for entry $05 of WorldMapCursorSpriteLists; it runs to the next list)
; record: count, then an X offset and a Y offset (from the cursor cell) per sprite
WorldMapCursorSprites005::
Data_0A1_5A35:: ; address name
    db $01, $11, $21 ; id 0

; E-0199 (derived: list for entry $06 of WorldMapCursorSpriteLists; it runs to the next list)
; record: count, then an X offset and a Y offset (from the cursor cell) per sprite
WorldMapCursorSprites006::
Data_0A1_5A38:: ; address name
    db $01, $09, $01 ; id 0

; E-0199 (derived: list for entry $07 of WorldMapCursorSpriteLists; it runs to the next list)
; record: count, then an X offset and a Y offset (from the cursor cell) per sprite
WorldMapCursorSprites007::
Data_0A1_5A3B:: ; address name
    db $02, $21, $19, $09, $09 ; id 0

; E-0199 (derived: list for entry $08 of WorldMapCursorSpriteLists; it runs to the next list)
; record: count, then an X offset and a Y offset (from the cursor cell) per sprite
WorldMapCursorSprites008::
Data_0A1_5A40:: ; address name
    db $01, $01, $01 ; id 0

; E-0199 (derived: list for entry $09 of WorldMapCursorSpriteLists; it runs to the next list)
; record: count, then an X offset and a Y offset (from the cursor cell) per sprite
WorldMapCursorSprites009::
Data_0A1_5A43:: ; address name
    db $01, $01, $09 ; id 0

; E-0199 (derived: list for entry $0A of WorldMapCursorSpriteLists; it runs to the next list)
; record: count, then an X offset and a Y offset (from the cursor cell) per sprite
WorldMapCursorSprites00A::
Data_0A1_5A46:: ; address name
    db $01, $09, $01 ; id 0

; E-0215 (C1: Func_0A1_4DA4 reads word wGameMode2Byte44 and walks count entries of two bytes; the lists run to $5A92).
; record: list
WorldMapMarkerLists::
Data_0A1_5A49:: ; address name
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

; E-0199 (derived: list for entry $00 of WorldMapMarkerLists; it runs to the next list)
; record: count, then two bytes (screen / position nibbles) per entry
WorldMapMarkers000::
Data_0A1_5A5F:: ; address name
    db $02, $21, $44, $25, $44 ; id 0

; E-0199 (derived: list for entry $01 of WorldMapMarkerLists; it runs to the next list)
; record: count, then two bytes (screen / position nibbles) per entry
WorldMapMarkers001::
Data_0A1_5A64:: ; address name
    db $03, $56, $44, $42, $44, $24, $44 ; id 0

; E-0199 (derived: list for entry $02 of WorldMapMarkerLists; it runs to the next list)
; record: count, then two bytes (screen / position nibbles) per entry
WorldMapMarkers002::
Data_0A1_5A6B:: ; address name
    db $05, $82, $44, $75, $44, $48, $44, $29, $44, $99, $44 ; id 0

; E-0199 (derived: list for entry $03 of WorldMapMarkerLists; it runs to the next list)
; record: count, then two bytes (screen / position nibbles) per entry
WorldMapMarkers003::
Data_0A1_5A76:: ; address name
    db $03, $B1, $44, $56, $64, $59, $44 ; id 0

; E-0199 (derived: list for entry $04 of WorldMapMarkerLists; it runs to the next list)
; record: count, then two bytes (screen / position nibbles) per entry
WorldMapMarkers004::
Data_0A1_5A7D:: ; address name
    db $00 ; id 0

; E-0199 (derived: list for entry $05 of WorldMapMarkerLists; it runs to the next list)
; record: count, then two bytes (screen / position nibbles) per entry
WorldMapMarkers005::
Data_0A1_5A7E:: ; address name
    db $01, $24, $44 ; id 0

; E-0199 (derived: list for entry $06 of WorldMapMarkerLists; it runs to the next list)
; record: count, then two bytes (screen / position nibbles) per entry
WorldMapMarkers006::
Data_0A1_5A81:: ; address name
    db $01, $10, $44 ; id 0

; E-0199 (derived: list for entry $07 of WorldMapMarkerLists; it runs to the next list)
; record: count, then two bytes (screen / position nibbles) per entry
WorldMapMarkers007::
Data_0A1_5A84:: ; address name
    db $02, $43, $44, $11, $35 ; id 0

; E-0199 (derived: list for entry $08 of WorldMapMarkerLists; it runs to the next list)
; record: count, then two bytes (screen / position nibbles) per entry
WorldMapMarkers008::
Data_0A1_5A89:: ; address name
    db $01, $00, $44 ; id 0

; E-0199 (derived: list for entry $09 of WorldMapMarkerLists; it runs to the next list)
; record: count, then two bytes (screen / position nibbles) per entry
WorldMapMarkers009::
Data_0A1_5A8C:: ; address name
    db $01, $01, $44 ; id 0

; E-0199 (derived: list for entry $0A of WorldMapMarkerLists; it runs to the next list)
; record: count, then two bytes (screen / position nibbles) per entry
WorldMapMarkers00A::
Data_0A1_5A8F:: ; address name
    db $01, $10, $44 ; id 0

; E-0215 (C1: SetSpriteYFromCursorCellY's path scans 5-byte records from $5A92 for the current map id (no terminator) and takes bytes 1-2, or 3-4 when wLastWarpIndex = 2; 150 records, map ids rising, end exactly at WorldMapScreenPositionTable).
; record: map id; cursor cell X, Y; second X, Y used when wLastWarpIndex = 2
WorldMapCursorCellTable::
Data_0A1_5A92:: ; address name
    db $21, $11, $09, $00, $00 ; id 0
    db $22, $11, $09, $00, $00 ; id 1
    db $23, $11, $29, $00, $00 ; id 2
    db $24, $11, $29, $00, $00 ; id 3
    db $25, $11, $29, $00, $00 ; id 4
    db $26, $11, $29, $00, $00 ; id 5
    db $28, $29, $29, $00, $00 ; id 6
    db $2A, $11, $09, $00, $00 ; id 7
    db $2B, $11, $09, $11, $29 ; id 8
    db $2D, $11, $29, $00, $00 ; id 9
    db $2E, $11, $29, $00, $00 ; id 10
    db $2F, $29, $29, $00, $00 ; id 11
    db $31, $29, $31, $00, $00 ; id 12
    db $32, $21, $11, $00, $00 ; id 13
    db $33, $21, $11, $00, $00 ; id 14
    db $34, $21, $11, $00, $00 ; id 15
    db $35, $01, $19, $00, $00 ; id 16
    db $36, $29, $29, $00, $00 ; id 17
    db $37, $29, $29, $00, $00 ; id 18
    db $38, $29, $19, $00, $00 ; id 19
    db $39, $29, $19, $00, $00 ; id 20
    db $3A, $29, $19, $00, $00 ; id 21
    db $3B, $29, $19, $00, $00 ; id 22
    db $3C, $11, $21, $00, $00 ; id 23
    db $3D, $11, $21, $00, $00 ; id 24
    db $3E, $31, $0D, $00, $00 ; id 25
    db $3F, $31, $0D, $00, $00 ; id 26
    db $40, $31, $0D, $00, $00 ; id 27
    db $41, $11, $21, $00, $00 ; id 28
    db $42, $29, $29, $00, $00 ; id 29
    db $43, $29, $29, $00, $00 ; id 30
    db $44, $29, $29, $00, $00 ; id 31
    db $49, $29, $01, $00, $00 ; id 32
    db $4A, $41, $11, $00, $00 ; id 33
    db $4B, $41, $11, $00, $00 ; id 34
    db $4C, $41, $11, $00, $00 ; id 35
    db $4D, $41, $11, $00, $00 ; id 36
    db $4E, $39, $19, $39, $21 ; id 37
    db $4F, $39, $29, $00, $00 ; id 38
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
    db $5A, $11, $49, $00, $00 ; id 49
    db $5B, $11, $49, $00, $00 ; id 50
    db $5C, $11, $49, $00, $00 ; id 51
    db $5D, $28, $51, $00, $00 ; id 52
    db $5E, $49, $49, $00, $00 ; id 53
    db $5F, $49, $49, $00, $00 ; id 54
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
    db $7A, $01, $21, $00, $00 ; id 72
    db $7B, $19, $31, $19, $39 ; id 73
    db $7C, $29, $49, $00, $00 ; id 74
    db $7D, $29, $49, $00, $00 ; id 75
    db $7E, $29, $49, $00, $00 ; id 76
    db $7F, $29, $49, $00, $00 ; id 77
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
    db $8A, $59, $51, $00, $00 ; id 88
    db $8B, $59, $51, $00, $00 ; id 89
    db $8C, $59, $51, $00, $00 ; id 90
    db $8D, $59, $51, $00, $00 ; id 91
    db $8E, $59, $51, $00, $00 ; id 92
    db $8F, $59, $51, $00, $00 ; id 93
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
    db $9A, $11, $01, $00, $00 ; id 104
    db $9B, $11, $01, $00, $00 ; id 105
    db $A1, $09, $11, $00, $00 ; id 106
    db $A2, $09, $09, $00, $00 ; id 107
    db $A3, $09, $09, $00, $00 ; id 108
    db $A9, $11, $21, $00, $00 ; id 109
    db $AA, $09, $09, $00, $00 ; id 110
    db $AB, $21, $19, $00, $00 ; id 111
    db $AC, $29, $09, $00, $00 ; id 112
    db $AD, $29, $09, $00, $00 ; id 113
    db $AE, $29, $09, $00, $00 ; id 114
    db $B1, $09, $01, $00, $00 ; id 115
    db $B3, $09, $01, $00, $00 ; id 116
    db $B4, $09, $01, $00, $00 ; id 117
    db $B5, $09, $01, $00, $00 ; id 118
    db $B6, $09, $01, $00, $00 ; id 119
    db $B9, $21, $19, $00, $00 ; id 120
    db $BA, $09, $09, $00, $00 ; id 121
    db $BB, $21, $01, $00, $00 ; id 122
    db $BC, $21, $19, $00, $00 ; id 123
    db $BD, $21, $01, $00, $00 ; id 124
    db $BE, $21, $01, $00, $00 ; id 125
    db $BF, $21, $01, $00, $00 ; id 126
    db $C0, $21, $01, $00, $00 ; id 127
    db $C1, $21, $01, $00, $00 ; id 128
    db $C2, $21, $01, $00, $00 ; id 129
    db $C3, $21, $01, $00, $00 ; id 130
    db $C4, $21, $01, $00, $00 ; id 131
    db $C9, $01, $01, $00, $00 ; id 132
    db $CA, $01, $01, $00, $00 ; id 133
    db $CB, $01, $01, $00, $00 ; id 134
    db $CC, $01, $01, $00, $00 ; id 135
    db $CD, $01, $01, $00, $00 ; id 136
    db $CE, $01, $01, $00, $00 ; id 137
    db $D2, $01, $09, $00, $00 ; id 138
    db $D3, $01, $09, $00, $00 ; id 139
    db $D4, $01, $09, $00, $00 ; id 140
    db $D5, $01, $09, $00, $00 ; id 141
    db $D6, $01, $09, $00, $00 ; id 142
    db $D7, $01, $09, $00, $00 ; id 143
    db $DB, $09, $01, $00, $00 ; id 144
    db $DC, $09, $01, $00, $00 ; id 145
    db $DD, $09, $01, $00, $00 ; id 146
    db $DE, $09, $01, $00, $00 ; id 147
    db $DF, $09, $01, $00, $00 ; id 148
    db $E0, $09, $01, $00, $00 ; id 149

; E-0215 (C1: the routine before RunGameMode2State_Case04_Sub02_Sub01_WriteMapScreenXAndMapScreenYEtc.skip scans 5-byte records from $5D80 for the map id and loads LoadMapPositionFromHL from bytes 1-2, or 3-4 when wLastWarpIndex = 2; 150 records with the same map ids as WorldMapCursorCellTable, then zero padding from $606E).
; record: map id; screen / position nibbles; the same for wLastWarpIndex = 2
WorldMapScreenPositionTable::
Data_0A1_5D80:: ; address name
    db $21, $21, $44, $00, $00 ; id 0
    db $22, $21, $44, $00, $00 ; id 1
    db $23, $25, $44, $00, $00 ; id 2
    db $24, $25, $44, $00, $00 ; id 3
    db $25, $25, $44, $00, $00 ; id 4
    db $26, $25, $44, $00, $00 ; id 5
    db $28, $55, $44, $00, $00 ; id 6
    db $2A, $21, $44, $00, $00 ; id 7
    db $2B, $21, $44, $25, $44 ; id 8
    db $2D, $25, $44, $00, $00 ; id 9
    db $2E, $25, $44, $00, $00 ; id 10
    db $2F, $55, $44, $00, $00 ; id 11
    db $31, $56, $44, $00, $00 ; id 12
    db $32, $42, $44, $00, $00 ; id 13
    db $33, $42, $44, $00, $00 ; id 14
    db $34, $42, $44, $00, $00 ; id 15
    db $35, $03, $44, $00, $00 ; id 16
    db $36, $55, $44, $00, $00 ; id 17
    db $37, $55, $44, $00, $00 ; id 18
    db $38, $53, $44, $00, $00 ; id 19
    db $39, $53, $44, $00, $00 ; id 20
    db $3A, $53, $44, $00, $00 ; id 21
    db $3B, $53, $44, $00, $00 ; id 22
    db $3C, $24, $44, $00, $00 ; id 23
    db $3D, $24, $44, $00, $00 ; id 24
    db $3E, $62, $44, $00, $00 ; id 25
    db $3F, $62, $44, $00, $00 ; id 26
    db $40, $62, $44, $00, $00 ; id 27
    db $41, $24, $44, $00, $00 ; id 28
    db $42, $55, $44, $00, $00 ; id 29
    db $43, $55, $44, $00, $00 ; id 30
    db $44, $55, $44, $00, $00 ; id 31
    db $49, $50, $44, $00, $00 ; id 32
    db $4A, $82, $44, $00, $00 ; id 33
    db $4B, $82, $44, $00, $00 ; id 34
    db $4C, $82, $44, $00, $00 ; id 35
    db $4D, $82, $44, $00, $00 ; id 36
    db $4E, $73, $44, $74, $44 ; id 37
    db $4F, $75, $44, $00, $00 ; id 38
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
    db $5A, $29, $44, $00, $00 ; id 49
    db $5B, $29, $44, $00, $00 ; id 50
    db $5C, $29, $44, $00, $00 ; id 51
    db $5D, $5A, $43, $00, $00 ; id 52
    db $5E, $99, $44, $00, $00 ; id 53
    db $5F, $99, $44, $00, $00 ; id 54
    db $60, $99, $44, $00, $00 ; id 55
    db $61, $99, $44, $00, $00 ; id 56
    db $62, $A5, $44, $00, $00 ; id 57
    db $63, $87, $44, $00, $00 ; id 58
    db $64, $87, $44, $00, $00 ; id 59
    db $65, $87, $44, $00, $00 ; id 60
    db $66, $87, $44, $00, $00 ; id 61
    db $67, $87, $44, $00, $00 ; id 62
    db $71, $B1, $44, $00, $00 ; id 63
    db $72, $B1, $44, $00, $00 ; id 64
    db $73, $B1, $44, $00, $00 ; id 65
    db $74, $B1, $44, $00, $00 ; id 66
    db $75, $B1, $44, $00, $00 ; id 67
    db $76, $B1, $44, $00, $00 ; id 68
    db $77, $A4, $44, $94, $44 ; id 69
    db $78, $56, $44, $00, $00 ; id 70
    db $79, $56, $44, $00, $00 ; id 71
    db $7A, $04, $44, $00, $00 ; id 72
    db $7B, $36, $44, $37, $44 ; id 73
    db $7C, $59, $44, $00, $00 ; id 74
    db $7D, $59, $44, $00, $00 ; id 75
    db $7E, $59, $44, $00, $00 ; id 76
    db $7F, $59, $44, $00, $00 ; id 77
    db $80, $89, $44, $99, $44 ; id 78
    db $81, $5B, $44, $00, $00 ; id 79
    db $82, $5B, $44, $00, $00 ; id 80
    db $83, $5B, $44, $00, $00 ; id 81
    db $84, $5B, $44, $00, $00 ; id 82
    db $85, $1B, $44, $00, $00 ; id 83
    db $86, $1B, $44, $00, $00 ; id 84
    db $87, $1B, $44, $00, $00 ; id 85
    db $88, $1B, $44, $00, $00 ; id 86
    db $89, $B1, $44, $00, $00 ; id 87
    db $8A, $BA, $44, $00, $00 ; id 88
    db $8B, $BA, $44, $00, $00 ; id 89
    db $8C, $BA, $44, $00, $00 ; id 90
    db $8D, $BA, $44, $00, $00 ; id 91
    db $8E, $BA, $44, $00, $00 ; id 92
    db $8F, $BA, $44, $00, $00 ; id 93
    db $90, $BA, $44, $00, $00 ; id 94
    db $91, $BA, $44, $00, $00 ; id 95
    db $92, $52, $44, $00, $00 ; id 96
    db $93, $41, $44, $00, $00 ; id 97
    db $94, $41, $44, $00, $00 ; id 98
    db $95, $41, $44, $00, $00 ; id 99
    db $96, $41, $44, $00, $00 ; id 100
    db $97, $41, $44, $00, $00 ; id 101
    db $98, $41, $44, $00, $00 ; id 102
    db $99, $41, $44, $00, $00 ; id 103
    db $9A, $41, $44, $00, $00 ; id 104
    db $9B, $41, $44, $00, $00 ; id 105
    db $A1, $12, $44, $00, $00 ; id 106
    db $A2, $11, $44, $00, $00 ; id 107
    db $A3, $11, $44, $00, $00 ; id 108
    db $A9, $24, $44, $00, $00 ; id 109
    db $AA, $11, $44, $00, $00 ; id 110
    db $AB, $43, $44, $00, $00 ; id 111
    db $AC, $51, $44, $00, $00 ; id 112
    db $AD, $51, $44, $00, $00 ; id 113
    db $AE, $51, $44, $00, $00 ; id 114
    db $B1, $10, $44, $00, $00 ; id 115
    db $B3, $10, $44, $00, $00 ; id 116
    db $B4, $10, $44, $00, $00 ; id 117
    db $B5, $10, $44, $00, $00 ; id 118
    db $B6, $10, $44, $00, $00 ; id 119
    db $B9, $43, $44, $00, $00 ; id 120
    db $BA, $11, $44, $00, $00 ; id 121
    db $BB, $40, $44, $00, $00 ; id 122
    db $BC, $43, $44, $00, $00 ; id 123
    db $BD, $40, $44, $00, $00 ; id 124
    db $BE, $40, $44, $00, $00 ; id 125
    db $BF, $40, $44, $00, $00 ; id 126
    db $C0, $40, $44, $00, $00 ; id 127
    db $C1, $40, $44, $00, $00 ; id 128
    db $C2, $40, $44, $00, $00 ; id 129
    db $C3, $40, $44, $00, $00 ; id 130
    db $C4, $40, $44, $00, $00 ; id 131
    db $C9, $00, $44, $00, $00 ; id 132
    db $CA, $00, $44, $00, $00 ; id 133
    db $CB, $00, $44, $00, $00 ; id 134
    db $CC, $00, $44, $00, $00 ; id 135
    db $CD, $00, $44, $00, $00 ; id 136
    db $CE, $00, $44, $00, $00 ; id 137
    db $D2, $01, $44, $00, $00 ; id 138
    db $D3, $01, $44, $00, $00 ; id 139
    db $D4, $01, $44, $00, $00 ; id 140
    db $D5, $01, $44, $00, $00 ; id 141
    db $D6, $01, $44, $00, $00 ; id 142
    db $D7, $01, $44, $00, $00 ; id 143
    db $DB, $10, $44, $00, $00 ; id 144
    db $DC, $10, $44, $00, $00 ; id 145
    db $DD, $10, $44, $00, $00 ; id 146
    db $DE, $10, $44, $00, $00 ; id 147
    db $DF, $10, $44, $00, $00 ; id 148
    db $E0, $10, $44, $00, $00 ; id 149
    ds $1F92, $00
