; ROM bank $30: battle commands and personality rolls
; The annotated listing of this bank is build/listing/bank30.asm.

SECTION "Bank 30", ROMX[$4000], BANK[$30]
    db $30

; battle fight step 2: returns while a message is being drawn (wTextFlags); otherwise one of 7
; sub-steps by wBattleSubPhase; case 0 loads the slots' personality bytes (wSlotPersonality*), the
; command menu loop follows
RunBattleCommandEntry::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, [wBattleSubPhase]
    jumptable
    dw RunBattleCommandEntry_WriteCommandByteE8
    dw RunBattleCommandEntry_CarryUnlessBattleSlotOutSlotEmpty
    dw RunBattleCommandEntry_ToRunCommandEntryResolveStep
    dw RunBattleCommandEntry_ChooseTargetForActor
    dw RunBattleCommandEntry_CarryUnlessBattleSlotOutSlotEmpty_SetActionQueuePos
    dw RunBattleCommandEntry_CompareHLToBC
    dw RunBattleCommandEntry_AddWordAtHLToBC_Bank30

RunBattleCommandEntry_WriteCommandByteE8::
    ld hl, wBattleSubPhase
    inc [hl]
    ld a, [wLinkMode]
    or a
    ret nz
    xor a
    ld [wCommandByteE8], a
    ld a, [wBattlePartyCount]
    ld b, a
    ld c, $00
    ld hl, wSlotPersonalityHi
    ld de, $0000
    call RunBattleCommandEntry_Case00_CarryUnlessBattleSlotOutSlotEmpty
    ld a, [wBattlePartyCount]
    ld b, a
    ld c, $00
    ld hl, wSlotPersonalityMid
    push de
    ld de, $0000
    call RunBattleCommandEntry_Case00_CarryUnlessBattleSlotOutSlotEmpty
    pop hl
    ld a, l
    sub e
    ld a, h
    sbc d
    jr nc, .read_battle_party_count
    ld h, d
    ld l, e
    ld a, $01
    ld [wCommandByteE8], a

.read_battle_party_count:
    push hl
    ld a, [wBattlePartyCount]
    ld b, a
    ld c, $00
    ld hl, wSlotPersonalityLo
    ld de, $0000
    call RunBattleCommandEntry_Case00_CarryUnlessBattleSlotOutSlotEmpty
    pop hl
    ld a, l
    sub e
    ld a, h
    sbc d
    jr nc, .read_battle_party_count2
    ld h, d
    ld l, e
    ld a, $02
    ld [wCommandByteE8], a

.read_battle_party_count2:
    push hl
    ld a, [wBattlePartyCount]
    ld b, a
    ld c, $00
    ld hl, wSlotTrait
    ld de, $0000
    call RunBattleCommandEntry_Case00_CarryUnlessBattleSlotOutSlotEmpty
    pop hl
    ld a, l
    sub e
    ld a, h
    sbc d
    jr nc, .return
    ld a, $03
    ld [wCommandByteE8], a

.return:
    ret

RunBattleCommandEntry_Case00_CarryUnlessBattleSlotOutSlotEmpty::
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, e
    add [hl]
    ld e, a
    ld a, d
    adc $00
    ld d, a

.next:
    inc hl
    inc c
    dec b
    jr nz, RunBattleCommandEntry_Case00_CarryUnlessBattleSlotOutSlotEmpty
    ret

RunBattleCommandEntry_CarryUnlessBattleSlotOutSlotEmpty::
    ld a, [wLinkMode]
    or a
    call nz, NextTableByteSecondStream
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
    ld hl, wBattleSubPhase
    inc [hl]
    ld hl, wBattleSubPhase
    inc [hl]

.return:
    ret

RunBattleCommandEntry_ToRunCommandEntryResolveStep::
    call RunCommandEntryResolveStep
    ret

RunBattleCommandEntry_ChooseTargetForActor::
    call ChooseTargetForActor
    ld a, [wBattleActor]
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, $02
    ld [hl], a
    ld a, $01
    ld [wBattleSubPhase], a
    ld hl, wBattleActor
    inc [hl]
    ret

; uses the preset target when the side is player-controlled, bit 7 of its wSideControl byte is clear
; and wBattleTargetChoice is set; otherwise ChooseActionTarget; stores the result (E-0125)
ChooseTargetForActor::
    ld a, [wLinkMode]
    cp $01
    jr z, .read_battle_actor
    cp $02
    jr z, .call_choose_action_target
    ld a, [wMenuState]
    jr .skip

.read_battle_actor:
    ld a, [wBattleActor]
    rrca
    rrca
    and $01
    ld hl, wCommandBytesE9
    add_a_to_hl
    ld a, [hl]

.skip:
    and $03
    cp $01
    jr nz, .call_choose_action_target
    ld a, [wBattleActor]
    ld hl, wSideControl
    add_a_to_hl
    bit 7, [hl]
    jr nz, .call_choose_action_target
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld a, [hl]
    cp $ff
    jp nz, .read_battle_actor2

.call_choose_action_target:
    farcall ChooseActionTarget
    jr .read_battle_actor3

.read_battle_actor2:
    ld d, a

.read_battle_actor3:
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld d, [hl]
    ret

RunBattleCommandEntry_CarryUnlessBattleSlotOutSlotEmpty_SetActionQueuePos::
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
    call RunBattleCommandEntry_Case04_AdvanceRandom
    call RunBattleCommandEntry_Case04_WriteRecordBufferAndBattleArg0Etc
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
    call RunBattleCommandEntry_Case04_WaitBattleItemTarget
    ld hl, wBattleSubPhase
    inc [hl]
    ret

RunBattleCommandEntry_Case04_AdvanceRandom::
    push de
    call AdvanceRandom
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

RunBattleCommandEntry_Case04_WriteRecordBufferAndBattleArg0Etc::
    push de
    ld a, e
    ld hl, wBattleActionChoice
    add a
    add_a_to_hl
    ld a, [hl]
    cp $62
    jr z, .skip
    cp $69
    jr z, .call_advance_random
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
    ld hl, $03e8
    jr .skip3

.call_advance_random:
    call AdvanceRandom
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

RunBattleCommandEntry_Case04_WaitBattleItemTarget::
    ld a, [wBattleItemTarget]
    cp $ff
    ret z
    ld bc, $07da
    ld hl, wBattleTempPtrLo
    deref_hl
    ld a, c
    ld [hli], a
    ld [hl], b
    ld a, [wLoadSlot]
    ld hl, wBattleArg0
    add_a_to_hl
    ld [hl], $10
    ret

RunBattleCommandEntry_CompareHLToBC::
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

RunBattleCommandEntry_AddWordAtHLToBC_Bank30::
    ld hl, wBattleHP
    ld bc, $0000
    call AddWordAtHLToBC_Bank30
    call AddWordAtHLToBC_Bank30
    call AddWordAtHLToBC_Bank30
    ld a, c
    ld [wBattleCommandArgs], a
    ld a, b
    ld [wBattleCommandArgs + $1], a
    ld hl, wBattleMaxHP
    ld bc, $0000
    call AddWordAtHLToBC_Bank30
    call AddWordAtHLToBC_Bank30
    call AddWordAtHLToBC_Bank30
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
    call RunBattleCommandEntry_Case06_CarryUnlessBattleSlotOutSlotEmpty
    ret

; BC += the word at [HL]; HL += 2; clobbers A (the same 7 bytes appear in 2 banks)
AddWordAtHLToBC_Bank30::
    ld a, [hli]
    add c
    ld c, a
    ld a, [hli]
    adc b
    ld b, a
    ret

RunBattleCommandEntry_Case06_CarryUnlessBattleSlotOutSlotEmpty::
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

; runs the routine for wBattleResolveStep (jump table of four) (E-0122)
RunCommandEntryResolveStep::
    ld a, [wBattleResolveStep]
    jumptable
    dw RunCommandEntryResolveStep_PersonalityIndexOfSlot_Bank30
    dw RunCommandEntryResolveStep_AddAx9ToHL
    dw AIChooseActionResolveStep
    dw RunCommandEntryResolveStep_RunActorActionHandlersForAISlots

RunCommandEntryResolveStep_PersonalityIndexOfSlot_Bank30::
    ld a, [wBattleActor]
    call PersonalityIndexOfSlot_Bank30
    ld [wPersonalityIndex], a
    call ForcedActionForActorStatus
    jr nz, .skip2
    ld a, [wLinkMode]
    or a
    jr z, .check_menu_state
    cp $02
    jr z, .check_battle_actor
    ld a, [wBattleActor]
    rrca
    rrca
    and $01
    ld hl, wCommandBytesE9
    add_a_to_hl
    ld a, [hl]
    jr .skip

.check_battle_actor:
    ld a, [wBattleActor]
    cp $01
    jr z, .read_command_bytes_e9
    ld a, [wMenuState]
    jr .skip

.read_command_bytes_e9:
    ld a, [wCommandBytesE9]
    jr .skip

.check_menu_state:
    ld a, [wMenuState]

.skip:
    and $03
    cp $01
    jr z, .done

.skip2:
    ld hl, wBattleResolveStep
    inc [hl]

.done:
    ld hl, wBattleResolveStep
    inc [hl]
    ret

RunCommandEntryResolveStep_AddAx9ToHL::
    ld hl, wBattleResolveStep
    inc [hl]
    xor a
    ld [wBattleStatResultLo], a
    ld a, [wLinkMode]
    or a
    jr z, .check_battle_actor
    cp $02
    jr z, .check_battle_actor
    jr .set_battle_stat_result_lo_to_01

.check_battle_actor:
    ld a, [wBattleActor]
    cp $04
    jr nc, .call_get_actor_slot_tactic_low2

.set_battle_stat_result_lo_to_01:
    ld a, $01
    ld [wBattleStatResultLo], a
    ld hl, wBattleArg0
    xor a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hl], a
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 6, [hl]
    jr nz, .call_get_actor_slot_tactic_low2
    call ActorBattleWordArray3FBand
    or a
    jr z, .call_get_actor_slot_tactic_low2
    cp $01
    jr z, .call_get_actor_slot_tactic_low22
    call RunCommandEntryResolveStep_Case01_ReadBattleActor
    call RunCommandEntryResolveStep_Case01_GetActorSlotTacticLow2
    call AddPersonalityWeightToBattleArg0
    call AddActorBattleWordArray3FDiv16ToBattleArg2
    call AddRandom0To63ToBattleArg2
    ld a, [wBattleArg0]
    ld l, a
    ld a, [wBattleArg1]
    ld h, a
    ld a, [wBattleArg2]
    ld c, a
    ld a, [wBattleArg3]
    ld b, a
    call CompareHLToBC
    jr c, .call_get_actor_slot_tactic_low22

.call_get_actor_slot_tactic_low2:
    call GetActorSlotTacticLow2
    res 6, [hl]
    ld a, [wBattleActor]
    ld hl, wResolveBytesE0
    add_a_to_hl
    ld [hl], $00
    call RunCommandEntryResolveStep_Case01_WaitLinkMode
    jr .return

.call_get_actor_slot_tactic_low22:
    call GetActorSlotTacticLow2
    set 6, [hl]
    ld a, [wBattleActor]
    ld hl, wResolveBytesE0
    add_a_to_hl
    ld [hl], $01
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    call AddDoubleAToHL_Bank30
    ld a, $ff
    ld [hli], a
    ld [hl], a
    ld a, [wBattleActor]
    ld hl, wSideControl
    add_a_to_hl
    set 7, [hl]
    call RunCommandEntryResolveStep_Case01_WaitLinkMode
    call RunCommandEntryResolveStep_Case01_IncBIfActorEntryBelow40
    ld a, $03
    ld [wBattleResolveStep], a
    ld a, [wBattleActor]
    and $03
    cp $03
    jr z, .return
    ld d, $28
    farcall ShowBattleTextCategory0

.return:
    ret

; A = 0 when the actor's wBattleWordArray3F word is below $33, 2 when below $3B6, otherwise 3
; (E-0122)
ActorBattleWordArray3FBand::
    ld a, [wBattleActor]
    ld hl, wBattleWordArray3F
    add a
    add_a_to_hl
    deref_hl
    ld bc, $0033
    call CompareHLToBC
    ld a, $00
    jr c, .return
    ld bc, $03b6
    call CompareHLToBC
    ld a, $02
    jr c, .return
    ld a, $03

.return:
    ret

RunCommandEntryResolveStep_Case01_ReadBattleActor::
    ld hl, wSlotTrait
    jr RunCommandEntryResolveStep_Case01_GetActorSlotTacticLow2_Data_ReadBattleActor

RunCommandEntryResolveStep_Case01_GetActorSlotTacticLow2::
    call GetActorSlotTacticLow2
    cp $03
    ret z
    ld hl, RunCommandEntryResolveStep_Case01_GetActorSlotTacticLow2_Data
    call ReadBattleWordFromArray_Bank30
    jr RunCommandEntryResolveStep_Case01_GetActorSlotTacticLow2_Data_ReadBattleActor

RunCommandEntryResolveStep_Case01_GetActorSlotTacticLow2_Data::
    db $68, $d9, $70, $d9, $78, $d9

RunCommandEntryResolveStep_Case01_GetActorSlotTacticLow2_Data_ReadBattleActor::
    ld a, [wBattleActor]
    add_a_to_hl
    ld a, [hl]
    srl a
    srl a
    ld hl, wBattleArg0
    add [hl]
    ld [hli], a
    ld a, $00
    adc [hl]
    ld [hl], a
    ret

; the word wBattleArg0 += PersonalityTacticWeights[wPersonalityIndex * 4 + (wSlotTactic[actor] & 3)]
; (E-0120)
AddPersonalityWeightToBattleArg0::
    ld a, [wPersonalityIndex]
    add a
    add a
    ld hl, PersonalityTacticWeights
    add_a_to_hl
    push hl
    call GetActorSlotTacticLow2
    pop hl
    add_a_to_hl
    ld a, [hl]
    ld hl, wBattleArg0
    add [hl]
    ld [hli], a
    ld a, $00
    adc [hl]
    ld [hl], a
    ret

; adds the actor's wBattleWordArray3F word / 16 to the word wBattleArg2 (E-0122)
AddActorBattleWordArray3FDiv16ToBattleArg2::
    ld a, [wBattleActor]
    ld hl, wBattleWordArray3F
    add a
    add_a_to_hl
    deref_hl
    srl h
    rr l
    srl h
    rr l
    srl h
    rr l
    srl h
    rr l
    jr AddRandom0To63ToBattleArg2_ReadBattleArg2

; adds a random value 0-63 (wRandomLo & $3F) to the word wBattleArg2 (E-0122)
AddRandom0To63ToBattleArg2::
    call AdvanceRandom
    ld a, [wRandomLo]
    and $3f
    ld l, a
    ld h, $00
    jr AddRandom0To63ToBattleArg2_ReadBattleArg2

AddRandom0To63ToBattleArg2_ReadBattleArg2::
    ld a, [wBattleArg2]
    add l
    ld [wBattleArg2], a
    ld a, [wBattleArg3]
    adc h
    ld [wBattleArg3], a
    ret

; when the actor has no forced action and bit 7 of its wSideControl byte is set, initialises the AI
; weights and runs the routine for its AI mode; a forced action is stored directly; then
; wBattleResolveStep += 1 (E-0124)
AIChooseActionResolveStep::
    call ForcedActionForActorStatus
    jr nz, .call_actor_action_choice_address
    ld a, [wBattleActor]
    ld hl, wSideControl
    add_a_to_hl
    bit 7, [hl]
    jr z, .done
    call InitAIWeightsForActor
    xor a
    ld [wAIFlag], a
    ld a, [wBattleActor]
    ld hl, wSlotAIMode
    add_a_to_hl
    ld a, [hl]
    ld hl, AIModeRoutineTable
    call ReadBattleWordFromArray_Bank30
    call JumpToHL
    jr .done

.call_actor_action_choice_address:
    call ActorActionChoiceAddress
    ld [hl], b

.done:
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; AIChooseActionResolveStep and AIChooseActionForActor read the word at $45D0 + 2 * AI mode and call
; it: mode 0 AIRunNextChoice, modes 1-3 ScoreActionsWithAIScoreTableA, mode 4 UseAIScoreTableB
; (E-0181, C1)
; record: routine run for this AI mode (wSlotAIMode)
AIModeRoutineTable::
    dw AIRunNextChoice ; id 0
    dw ScoreActionsWithAIScoreTableA ; id 1
    dw ScoreActionsWithAIScoreTableA ; id 2
    dw ScoreActionsWithAIScoreTableA ; id 3
    dw UseAIScoreTableB ; id 4

; clears wAIWeights ($14 bytes), sets wAIChoiceWeights-wAIChoiceIndex = 0, 0, 0, 1, 2, 3, 3, then
; adds personality, HP and other weights (AddCommandWeightToAIChoiceWeights, 46BA, 47B9, 483F);
; wLoadSlot = 0 (E-0124)
InitAIWeightsForActor::
    ld hl, wAIWeights
    ld bc, $0014
    xor a
    call FillBytes
    xor a
    ld [wAIChoiceWeights], a
    ld [wAIChoiceWeights + $1], a
    ld [wAIChoiceWeights + $2], a
    ld a, $01
    ld [wAIChoiceOrder], a
    ld a, $02
    ld [wAIChoiceOrder + $1], a
    ld a, $03
    ld [wAIChoiceOrder + $2], a
    ld a, $03
    ld [wAIChoiceIndex], a
    call AddCommandWeightToAIChoiceWeights
    call AddActorPersonalityTensToAIChoiceWeights
    call AddStatusAndHPWeightsToAI
    call AddRandomPersonalityWeights
    call SortThreeAIWeightsRandomTies
    ld a, $00
    ld [wLoadSlot], a
    ret

; for player-side actors: with battle command 1 adds $2D to wAIChoiceWeights[actor's wSlotTactic
; mode] (unless 3), otherwise $14 to wAIChoiceWeights[wSlotLastTactic & 3] (E-0127)
AddCommandWeightToAIChoiceWeights::
    ld a, [wLinkMode]
    or a
    jr z, .check_battle_actor
    cp $02
    jr nz, .read_battle_actor
    ld a, [wBattleActor]
    cp $04
    jr nc, .return
    cp $00
    ld a, [wMenuState]
    jr z, .skip
    ld a, [wCommandBytesE9]
    jr .skip

.read_battle_actor:
    ld a, [wBattleActor]
    rrca
    rrca
    and $01
    ld hl, wCommandBytesE9
    add_a_to_hl
    ld a, [hl]
    jr .skip

.check_battle_actor:
    ld a, [wBattleActor]
    cp $04
    jr nc, .return
    ld a, [wMenuState]

.skip:
    and $03
    cp $01
    jr nz, .read_battle_actor2
    call GetActorSlotTacticLow2
    cp $03
    jr z, .return
    ld hl, wAIChoiceWeights
    add_a_to_hl
    ld e, $2d
    call AddSignedEToByteAtHLClamped
    jr .return

.read_battle_actor2:
    ld a, [wBattleActor]
    ld hl, wSlotLastTactic
    add_a_to_hl
    ld a, [hl]
    and $03
    ld hl, wAIChoiceWeights
    add_a_to_hl
    ld e, $14
    call AddSignedEToByteAtHLClamped

.return:
    ret

; for the actor's three personality bytes (Hi, Mid, Lo) adds value / 10 to wAIChoiceWeights + 0, 1,
; 2 (AddSignedEToByteAtHLClamped) (E-0122)
AddActorPersonalityTensToAIChoiceWeights::
    ld hl, wSlotPersonalityHi
    ld a, $00
    call AddActorPersonalityTensForIndexA
    ld hl, wSlotPersonalityMid
    ld a, $01
    call AddActorPersonalityTensForIndexA
    ld hl, wSlotPersonalityLo
    ld a, $02

; B = [HL + actor] / 10, then AddSignedEToByteAtHLClamped on wAIChoiceWeights + A with E = B
; (E-0122)
AddActorPersonalityTensForIndexA::
    push af
    ld a, [wBattleActor]
    add_a_to_hl
    ld b, [hl]
    ld a, $0a
    call DivideBByA
    pop af
    ld hl, wAIChoiceWeights
    add_a_to_hl
    ld e, b
    call AddSignedEToByteAtHLClamped
    ret

; adds AI weights for the actor's status (wBattleStatus1 bits) and command mode, and for allies
; below a sixth of max HP in AI modes 3 and 4 (E-0130)
AddStatusAndHPWeightsToAI::
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    ld a, [hli]
    and $08
    jr nz, .check_link_mode
    inc hl
    inc hl
    ld a, [hl]
    and $33
    jr z, .call_any_ally_hp_below_sixth_of_max

.check_link_mode:
    ld a, [wLinkMode]
    or a
    jr z, .check_menu_state
    cp $02
    jr nz, .read_battle_actor
    ld a, [wBattleActor]
    cp $00
    ld a, [wMenuState]
    jr z, .skip
    ld a, [wCommandBytesE9]
    jr .skip

.read_battle_actor:
    ld a, [wBattleActor]
    rrca
    rrca
    and $01
    ld hl, wCommandBytesE9
    add_a_to_hl
    ld a, [hl]
    jr .skip

.check_menu_state:
    ld a, [wMenuState]

.skip:
    and $03
    cp $01
    jr z, .call_any_ally_hp_below_sixth_of_max
    ld hl, wAIChoiceWeights
    ld e, $1e
    call AddSignedEToByteAtHLClamped

.call_any_ally_hp_below_sixth_of_max:
    call AnyAllyHPBelowSixthOfMax
    jr z, .check_battle_turn
    ld a, [wBattleActor]
    ld hl, wSlotAIMode
    add_a_to_hl
    ld a, [hl]
    cp $04
    jr z, .read_battle_actor2
    cp $03
    jr z, .read_battle_actor2
    jr .check_battle_turn

.read_battle_actor2:
    ld a, [wBattleActor]
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld b, $08

.loop:
    ld a, [hl]
    cp $ff
    jr z, .check_battle_turn
    cp $16
    jr c, .next
    cp $21
    jr c, .call_get_actor_slot_tactic_low2
    cp $7b
    jr z, .call_get_actor_slot_tactic_low2
    cp $7c
    jr z, .call_get_actor_slot_tactic_low2
    cp $9f
    jr c, .next
    cp $a2
    jr c, .call_get_actor_slot_tactic_low2

.next:
    inc hl
    inc hl
    dec b
    jr nz, .loop
    jr .check_battle_turn

.call_get_actor_slot_tactic_low2:
    call GetActorSlotTacticLow2
    cp $03
    jr z, .check_battle_turn
    ld hl, wAIChoiceWeights + $2
    ld e, $1e
    call AddSignedEToByteAtHLClamped

.check_battle_turn:
    ld a, [wBattleTurn]
    or a
    jr nz, .return
    ld a, [wBattleActor]
    cp $04
    jr nc, .return
    ld a, [wLinkMode]
    or a
    jr nz, .return
    ld a, [wMenuState]
    and $01
    jr nz, .return
    ld hl, wAIChoiceWeights + $2
    ld e, $e2
    call AddSignedEToByteAtHLClamped

.return:
    ret

; A = 1 and NZ when an occupied ally has HP below a sixth of its max; otherwise returns with the
; last comparison flags (E-0124)
AnyAllyHPBelowSixthOfMax::
    ld a, [wBattleActor]
    and $04
    ld c, a
    ld b, $03

.loop:
    push bc
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .restore
    ld a, c
    call ReadBattleMaxHPOfSlot_Bank30
    ld a, $06
    call DivideHLByA
    push hl
    ld a, c
    call ReadBattleHPOfSlot_Bank30
    pop bc
    call CompareHLToBC
    jr c, .restore2

.restore:
    pop bc
    inc c
    dec b
    jr nz, .loop
    ret

.restore2:
    pop bc
    ld a, $01
    or a
    ret

; for player-controlled slots adds random 0-15 to wAIChoiceWeights-wAIChoiceWeights + $2; for AI
; slots adds weights by personality band (AddRandomWeightByValueBand) (E-0125)
AddRandomPersonalityWeights::
    ld a, [wLinkMode]
    or a
    jr z, .check_battle_actor
    cp $02
    jr nz, .loop
    ld a, [wBattleActor]
    cp $04
    jr c, .check_battle_actor

.loop:
    call GetActorSlotTacticLow2
    cp $03
    ret z
    ld hl, wAIChoiceWeights
    ld b, $03

.loop2:
    call AdvanceRandom
    ld a, [wRandomLo]
    and $0f
    ld e, a
    call AddSignedEToByteAtHLClamped
    inc hl
    dec b
    jr nz, .loop2
    ret

.check_battle_actor:
    ld a, [wBattleActor]
    cp $04
    jr c, .loop
    ld a, [wBattleActor]
    ld hl, wSlotPersonalityHi
    ld de, wAIChoiceWeights
    call AddRandomWeightByValueBand
    ld a, [wBattleActor]
    ld hl, wSlotPersonalityMid
    ld de, wAIChoiceWeights + $1
    call AddRandomWeightByValueBand
    ld a, [wBattleActor]
    ld hl, wSlotPersonalityLo
    ld de, wAIChoiceWeights + $2

; adds RandomInRange(0, 30/25/20/15/10) to [DE] (AddSignedEToByteAtHLClamped), the bound chosen by
; [HL + A] (< 50, 100, 150, 200, or more) (E-0124)
AddRandomWeightByValueBand::
    push de
    add_a_to_hl
    ld a, [hl]
    ld bc, $001e
    cp $32
    jr c, .call_random_in_range
    ld bc, $0019
    cp $64
    jr c, .call_random_in_range
    ld bc, $0014
    cp $96
    jr c, .call_random_in_range
    ld bc, $000f
    cp $c8
    jr c, .call_random_in_range
    ld bc, $000a

.call_random_in_range:
    ld hl, $0000
    call RandomInRange
    pop hl
    call AddSignedEToByteAtHLClamped
    ret

; sorts wAIChoiceWeights-wAIChoiceWeights + $2 in descending order (ties broken by the random bits
; in wRandomLo/8), swapping the matching wAIChoiceOrder-wAIChoiceOrder + $2 entries (E-0128)
SortThreeAIWeightsRandomTies::
    ld a, [wRandomLo]
    ld c, a
    ld a, [wRandomHi]
    ld b, a
    ld hl, wAIChoiceWeights
    ld a, [hli]
    cp [hl]
    ccf
    jr c, .skip2
    jr nz, .skip
    bit 0, b
    jr nz, .skip2

.skip:
    push af
    ld a, [hld]
    ld [hli], a
    pop af
    ld [hl], a
    ld a, [wAIChoiceOrder]
    push af
    ld a, [wAIChoiceOrder + $1]
    ld [wAIChoiceOrder], a
    pop af
    ld [wAIChoiceOrder + $1], a

.skip2:
    ld a, [hli]
    cp [hl]
    ccf
    jr c, .check_ai_choice_weights
    jr nz, .skip3
    bit 0, c
    jr nz, .check_ai_choice_weights

.skip3:
    push af
    ld a, [hld]
    ld [hli], a
    pop af
    ld [hl], a
    ld a, [wAIChoiceOrder + $1]
    push af
    ld a, [wAIChoiceOrder + $2]
    ld [wAIChoiceOrder + $1], a
    pop af
    ld [wAIChoiceOrder + $2], a

.check_ai_choice_weights:
    dec hl
    ld a, [wAIChoiceWeights]
    cp [hl]
    ccf
    jr c, .read_ai_choice_order
    jr nz, .skip4
    bit 1, b
    jr nz, .read_ai_choice_order

.skip4:
    push af
    ld a, [hld]
    ld [hli], a
    pop af
    ld [hl], a
    ld a, [wAIChoiceOrder]
    push af
    ld a, [wAIChoiceOrder + $1]
    ld [wAIChoiceOrder], a
    pop af
    ld [wAIChoiceOrder + $1], a

.read_ai_choice_order:
    ld a, [wAIChoiceOrder]
    ld d, a
    ld e, $32
    call AddWeightsForSkillD
    ld a, [wAIChoiceOrder + $1]
    ld d, a
    ld e, $19

; for each of the actor's skills equal to D adds weight through
; AddWeightsForSkillD_ReadLinkModeAndBattleActorEtc to wAIWeights[index]; for D other than 2 also to
; wAIWeights + $10[D - 1] (E-0125)
AddWeightsForSkillD::
    ld bc, $0800
    ld hl, wBattleSkillsPrefix
    ld a, [wBattleActor]
    swap a
    add l
    ld l, a
    jr nc, .loop
    inc h

.loop:
    push bc
    ld a, [hl]
    cp d
    jr nz, .restore
    push hl
    ld a, c
    ld hl, wAIWeights
    add a
    add_a_to_hl
    call AddWeightsForSkillD_ReadLinkModeAndBattleActorEtc
    pop hl

.restore:
    pop bc
    inc hl
    inc hl
    inc c
    dec b
    jr nz, .loop
    ld a, d
    cp $02
    jr z, .return
    dec a
    ld hl, wAIWeights + $10
    add_a_to_hl
    call AddWeightsForSkillD_ReadLinkModeAndBattleActorEtc

.return:
    ret

AddWeightsForSkillD_ReadLinkModeAndBattleActorEtc::
    push de
    push hl
    ld a, [wLinkMode]
    or a
    jr z, .check_menu_state
    cp $01
    jr z, .read_battle_actor
    ld a, [wBattleActor]
    cp $00
    ld a, [wMenuState]
    jr z, .skip
    ld a, [wCommandBytesE9]
    jr .skip

.read_battle_actor:
    ld a, [wBattleActor]
    rrca
    rrca
    and $01
    ld hl, wCommandBytesE9
    add_a_to_hl
    ld a, [hl]
    jr .skip

.check_menu_state:
    ld a, [wMenuState]

.skip:
    and $03
    cp $01
    jr z, .call_get_actor_slot_tactic_low2
    and $01
    jr z, .skip2
    jr .restore

.call_get_actor_slot_tactic_low2:
    call GetActorSlotTacticLow2
    cp $03
    jr z, .skip2
    sla e
    jr .restore

.skip2:
    ld e, $00

.restore:
    pop hl
    ld a, e
    add [hl]
    ld [hli], a
    ld a, $00
    adc [hl]
    ld [hl], a
    pop de
    ret

; for player-controlled actors in manual mode chooses action 0; otherwise runs the AI routine for
; the next wAIChoiceWeights entry (AIChoiceRoutineTable) and advances wAIChoiceIndex (E-0125)
AIRunNextChoice::
    ld a, [wBattleActor]
    and $03
    cp $03
    jr z, .check_ai_choice_index
    ld a, [wLinkMode]
    or a
    jr z, .check_battle_actor
    cp $02
    jr nz, .call_get_actor_slot_tactic_low2

.check_battle_actor:
    ld a, [wBattleActor]
    cp $04
    jr nc, .check_ai_choice_index

.call_get_actor_slot_tactic_low2:
    call GetActorSlotTacticLow2
    cp $03
    jr nz, .check_ai_choice_index

.loop:
    ld b, $00
    call ActorActionChoiceAddress
    ld [hl], b
    ret

.check_ai_choice_index:
    ld a, [wAIChoiceIndex]
    cp $06
    jr nc, .loop
    ld hl, wAIChoiceWeights
    add_a_to_hl
    ld a, [hl]
    ld hl, AIChoiceRoutineTable
    dec a
    call ReadBattleWordFromArray_Bank30
    call JumpToHL
    call ActorActionChoiceAddress
    ld b, [hl]
    ld a, [wLoadSlot]
    cp $ff
    ret z
    ld hl, wAIChoiceIndex
    inc [hl]
    jr AIRunNextChoice

; AIRunNextChoice reads the word at $4998 + 2 * (wAIChoiceWeights[wAIChoiceIndex] - 1) and calls it
; (JumpToHL); three words, and the three routines follow directly (E-0181, C1)
; record: AI choice routine for this wAIChoiceWeights value
AIChoiceRoutineTable::
    dw AIPickRandomActionOfKind1 ; id 1
    dw AIPickRandomSkillOfKind2 ; id 2
    dw AIPickRandomSkillOfKind3 ; id 3

; lists action 0 plus every skill of the actor whose kind byte (the byte before it in wBattleSkills,
; wBattleSkillsPrefix + 16 * slot) is 1, picks one at random as the actor's action choice and sets
; wLoadSlot = $FF (choice weight 1 of AIChoiceRoutineTable) (E-0181)
AIPickRandomActionOfKind1::
    ld hl, wBattleArg0
    ld bc, $0009
    ld a, $ff
    call FillBytes
    ld a, $00
    ld [wBattleArg0], a
    ld a, [wBattleActor]
    swap a
    ld hl, wBattleSkillsPrefix
    add_a_to_hl
    ld b, $08
    ld c, $00

.loop:
    ld a, [hl]
    or a
    jr z, .call_advance_random
    cp $01
    jr nz, .next
    push hl
    inc hl
    ld d, [hl]
    ld a, c
    ld hl, wBattleArg1
    add_a_to_hl
    ld [hl], d
    inc c
    pop hl

.next:
    inc hl
    inc hl
    dec b
    jr nz, .loop

.call_advance_random:
    call AdvanceRandom
    ld a, [wRandomLo]
    ld b, a
    ld a, c
    add $01
    call DivideBByA
    ld hl, wBattleArg0
    add_a_to_hl
    ld a, [hl]
    push af
    call ActorActionChoiceAddress
    pop af
    ld [hl], a
    ld a, $ff
    ld [wLoadSlot], a
    ret

; lists the actor's skills of kind 2 (as AIPickRandomActionOfKind1, without action 0) and picks one
; at random as the action choice; returns when there is none (choice weight 2) (E-0181)
AIPickRandomSkillOfKind2::
    ld hl, wBattleArg0
    ld bc, $0008
    ld a, $ff
    call FillBytes
    ld a, [wBattleActor]
    swap a
    ld hl, wBattleSkillsPrefix
    add_a_to_hl
    ld b, $08
    ld c, $00

.loop:
    ld a, [hl]
    or a
    jr z, .skip
    cp $02
    jr nz, .next
    push hl
    inc hl
    ld d, [hl]
    ld a, c
    ld hl, wBattleArg0
    add_a_to_hl
    ld [hl], d
    inc c
    pop hl

.next:
    inc hl
    inc hl
    dec b
    jr nz, .loop

.skip:
    ld a, c
    or a
    ret z
    call AdvanceRandom
    ld a, [wRandomLo]
    ld b, a
    ld a, c
    call DivideBByA
    ld hl, wBattleArg0
    add_a_to_hl
    ld a, [hl]
    push af
    call ActorActionChoiceAddress
    pop af
    ld [hl], a
    ld a, $ff
    ld [wLoadSlot], a
    ret

; lists the actor's skills of kind 3, adds skill $AC when GetActorSlotTacticLow2 returns 2, and
; picks one at random as the action choice; returns when there is none (choice weight 3) (E-0181)
AIPickRandomSkillOfKind3::
    ld hl, wBattleArg0
    ld bc, $0009
    ld a, $ff
    call FillBytes
    ld a, [wBattleActor]
    swap a
    ld hl, wBattleSkillsPrefix
    add_a_to_hl
    ld b, $08
    ld c, $00

.loop:
    ld a, [hl]
    or a
    jr z, .call_get_actor_slot_tactic_low2
    cp $03
    jr nz, .next
    push hl
    inc hl
    ld d, [hl]
    ld a, c
    ld hl, wBattleArg0
    add_a_to_hl
    ld [hl], d
    inc c
    pop hl

.next:
    inc hl
    inc hl
    dec b
    jr nz, .loop

.call_get_actor_slot_tactic_low2:
    call GetActorSlotTacticLow2
    cp $02
    jr nz, .skip
    ld a, c
    ld hl, wBattleArg0
    add_a_to_hl
    ld [hl], $ac
    inc c

.skip:
    ld a, c
    or a
    ret z
    call AdvanceRandom
    ld a, [wRandomLo]
    ld b, a
    ld a, c
    call DivideBByA
    ld hl, wBattleArg0
    add_a_to_hl
    ld a, [hl]
    push af
    call ActorActionChoiceAddress
    pop af
    ld [hl], a
    ld a, $ff
    ld [wLoadSlot], a
    ret

; wBattleExpAward/wBattleExpAward + $1 = AIScoreRoutineTableB, then continues with the scoring loop
; (E-0122)
UseAIScoreTableB::
    ld hl, AIScoreRoutineTableB
    ld a, l
    ld [wBattleExpAward], a
    ld a, h
    ld [wBattleExpAward + $1], a
    jr ScoreActionsWithAIScoreTableA_CheckBattleActor

; sets wBattleExpAward/C to AIScoreRoutineTableA; for AI-controlled actors estimates damage, scores
; the eight skills, attack (0) and $AC into wAIWeights, and doubles the weight of the preferred kind
; (E-0129)
ScoreActionsWithAIScoreTableA::
    ld hl, AIScoreRoutineTableA
    ld a, l
    ld [wBattleExpAward], a
    ld a, h
    ld [wBattleExpAward + $1], a

ScoreActionsWithAIScoreTableA_CheckBattleActor::
    ld a, [wBattleActor]
    and $03
    cp $03
    jr z, .call_estimate_damage_vs_each_foe_to_ai_damage
    ld a, [wLinkMode]
    or a
    jr z, .check_battle_actor
    cp $02
    jr nz, .call_get_actor_slot_tactic_low2

.check_battle_actor:
    ld a, [wBattleActor]
    cp $04
    jr nc, .call_estimate_damage_vs_each_foe_to_ai_damage

.call_get_actor_slot_tactic_low2:
    call GetActorSlotTacticLow2
    cp $03
    jr nz, .call_estimate_damage_vs_each_foe_to_ai_damage
    ld b, $00
    call ActorActionChoiceAddress
    ld [hl], b
    ret

.call_estimate_damage_vs_each_foe_to_ai_damage:
    call EstimateDamageVsEachFoeToAIDamageEstimates
    ld a, [wBattleActor]
    ld hl, wBattleSkillsPrefix
    swap a
    add_a_to_hl
    ld de, wAIWeights
    ld b, $08

.loop:
    push bc
    push hl
    push de
    inc hl
    call ScoreSkillAtHLForAI
    pop de
    pop hl
    ld a, [wAIChoiceOrder]
    cp [hl]
    call z, DoubleWordAtDEUnlessBit15
    inc hl
    inc hl
    inc de
    inc de
    pop bc
    dec b
    jr nz, .loop
    ld a, $00
    push de
    call ScoreSkillForAI
    pop de
    ld a, [wAIChoiceOrder]
    cp $01
    call z, DoubleWordAtDEUnlessBit15
    inc de
    inc de
    ld a, $ac
    push de
    call ScoreSkillForAI
    pop de
    ld a, [wBattleActor]
    and $03
    cp $03
    jr z, .call_quarter_word_at_de_unless_bit15
    ld a, [wLinkMode]
    or a
    jr z, .check_battle_actor2
    cp $02
    jr nz, .check_ai_choice_order

.check_battle_actor2:
    ld a, [wBattleActor]
    cp $04
    jr nc, .call_quarter_word_at_de_unless_bit15

.check_ai_choice_order:
    ld a, [wAIChoiceOrder]
    cp $03
    call z, DoubleWordAtDEUnlessBit15
    jr .call_choose_highest_weighted_action

.call_quarter_word_at_de_unless_bit15:
    call QuarterWordAtDEUnlessBit15

.call_choose_highest_weighted_action:
    call ChooseHighestWeightedAction
    ret

; doubles the word at DE unless its bit 15 is already set (E-0122)
DoubleWordAtDEUnlessBit15::
    push de
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    bit 7, a
    jr nz, .done
    sla c
    rla
    ld [de], a
    dec de
    ld a, c
    ld [de], a

.done:
    pop de
    ret

; divides the word at DE by 4 unless its bit 15 is set (E-0124)
QuarterWordAtDEUnlessBit15::
    push de
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    bit 7, a
    jr nz, .done
    srl a
    rr c
    srl a
    rr c
    ld [de], a
    dec de
    ld a, c
    ld [de], a

.done:
    pop de
    ret

; A = [HL], then falls into ScoreSkillForAI (E-0126)
ScoreSkillAtHLForAI::
    ld a, [hl]

; A = skill number ($FF skips): AddSkillBaseWeightAndLoadSkill; when wRecordBufferData + $3 bit 0
; (in the skill record) is set, clears wAISkillScore-wAISkillScore2 + $1 and far-calls the skill's
; AI scoring routine from the table in wBattleExpAward/wBattleExpAward + $1 (AIScoreRoutineTableA or
; B), then folds the accumulated weights into the word at DE (the rest is not fully read) (E-0083)
ScoreSkillForAI::
    push de
    cp $ff
    jr z, .restore
    call AddSkillBaseWeightAndLoadSkill
    ld e, a
    ld d, $00
    ld a, [wRecordBufferData + $3]
    bit 0, a
    jr z, .restore
    ld a, [wBattleExpAward]
    ld l, a
    ld a, [wBattleExpAward + $1]
    ld h, a
    add hl, de
    add hl, de
    add hl, de
    ld e, [hl]
    inc hl
    ld a, [hli]
    ld b, [hl]
    ld h, a
    ld l, e
    xor a
    ld [wAISkillScore], a
    ld [wAISkillScore + $1], a
    ld [wAISkillScore2], a
    ld [wAISkillScore2 + $1], a
    rst $10
    ld a, [wAISkillScore]
    ld c, a
    ld a, [wAISkillScore + $1]
    ld b, a
    ld a, [wAISkillScore2]
    ld l, a
    ld a, [wAISkillScore2 + $1]
    ld h, a
    ld a, h
    and l
    cp $ff
    jr z, .restore
    ld a, c
    sub l
    ld c, a
    ld a, b
    sbc h
    ld b, a
    pop hl
    ld a, [hl]
    add c
    ld [hli], a
    ld a, [hl]
    adc b
    ld [hl], a
    bit 7, a
    jr z, .return
    dec hl
    push hl

.restore:
    pop hl
    ld a, $ff
    ld [hli], a
    ld [hl], a

.return:
    ret

; picks the largest of the ten wAIWeights weights (ties at random); index 8 chooses action 0, 9
; chooses $AC, others the actor's skill in that slot (E-0127)
ChooseHighestWeightedAction::
    xor a
    ldh [hTemp0], a
    ld hl, $0000
    ld de, $0a00

.loop:
    ld a, e
    push hl
    ld hl, wAIWeights
    add a
    add_a_to_hl
    ld c, [hl]
    inc hl
    ld b, [hl]
    pop hl
    ld a, b
    and c
    cp $ff
    jr z, .next
    call CompareHLToBC
    jr c, .skip
    jr nz, .next
    call AdvanceRandom
    ld a, [wRandomLo]
    bit 0, a
    jr z, .next

.skip:
    ld h, b
    ld l, c
    ld a, e
    ldh [hTemp0], a

.next:
    inc e
    dec d
    jr nz, .loop
    ld a, [wBattleActor]
    swap a
    ld hl, wBattleSkills
    add_a_to_hl
    ldh a, [hTemp0]
    cp $08
    jr z, .skip2
    cp $09
    jr z, .call_actor_action_choice_address
    add a
    add_a_to_hl
    ld b, [hl]
    jr .call_actor_action_choice_address2

.skip2:
    ld b, $00
    jr .call_actor_action_choice_address2

.call_actor_action_choice_address:
    ld b, $ac

.call_actor_action_choice_address2:
    call ActorActionChoiceAddress
    ld [hl], b
    ret

; for each foe stores (actor ATK - foe DEF / 2) / 2, floored at 0, in wAIDamageEstimates[foe & 3] (0
; for empty slots) (E-0125)
EstimateDamageVsEachFoeToAIDamageEstimates::
    ld a, [wBattleActor]
    call ReadBattleATKOfSlot_Bank30
    ld d, h
    ld e, l
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03

.loop:
    push de
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    call ReadBattleDEFOfSlot_Bank30
    srl h
    rr l
    ld a, e
    sub l
    ld e, a
    ld a, d
    sbc h
    ld d, a
    bit 7, a
    jr z, .skip2

.skip:
    ld de, $0000
    jr .skip3

.skip2:
    srl d
    rr e

.skip3:
    ld a, c
    and $03
    ld hl, wAIDamageEstimates
    add a
    add_a_to_hl
    ld [hl], e
    inc hl
    ld [hl], d
    pop de
    inc c
    dec b
    jr nz, .loop
    ret

; A = skill number: when the word at $55F3 + 2 * A (a per-skill weight table in this bank) is
; non-zero it is added to the word at DE and AddSkillBaseWeightAndLoadSkill_AdvanceRandom adds a
; random adjustment; then the skill record is loaded (wRecordBuffer = A, wRecordBuffer + $1 = 0,
; LoadSkillRecord); A and DE kept (E-0083)
AddSkillBaseWeightAndLoadSkill::
    push de
    push af
    ld l, a
    ld h, $00
    add hl, hl
    ld a, l
    add $f3
    ld l, a
    ld a, h
    adc $55
    ld h, a
    ld a, [hli]
    or [hl]
    jr z, .set_record_buffer
    dec hl
    ld a, [de]
    add [hl]
    ld [de], a
    inc hl
    inc de
    ld a, [de]
    adc [hl]
    ld [de], a
    call AddSkillBaseWeightAndLoadSkill_AdvanceRandom

.set_record_buffer:
    pop af
    push af
    ld [wRecordBuffer], a
    xor a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    pop af
    pop de
    ret

AddSkillBaseWeightAndLoadSkill_AdvanceRandom::
    push af
    dec de
    call AdvanceRandom
    ld a, [wRandomLo]
    and $3f
    ld b, a
    ld a, [de]
    add b
    ld [de], a
    inc de
    ld a, [de]
    adc $00
    ld [de], a
    pop af
    ret

RunCommandEntryResolveStep_RunActorActionHandlersForAISlots::
    call RunActorActionHandlersForAISlots
    ld hl, wBattleSubPhase
    inc [hl]
    xor a
    ld [wBattleResolveStep], a
    ret

; for AI-controlled slots (foes, or both sides outside normal battles, never slot 3/7) runs the
; handlers for the set bits of the actor's action data word (E-0124)
RunActorActionHandlersForAISlots::
    ld a, [wLinkMode]
    or a
    jr z, .check_battle_actor
    cp $02
    jr nz, .check_battle_actor2

.check_battle_actor:
    ld a, [wBattleActor]
    cp $03
    jr nc, .return
    jr .call_actor_action_data_word

.check_battle_actor2:
    ld a, [wBattleActor]
    and $03
    cp $03
    jr z, .return

.call_actor_action_data_word:
    call ActorActionDataWord
    ld a, c
    and b
    cp $ff
    jr z, .return
    call RunHandlersForSetBitsInBC

.return:
    ret

; BC = the word at ActionHandlerMaskTable + 2 * the actor's chosen action (ActorActionChoiceAddress)
; (E-0118)
ActorActionDataWord::
    call ActorActionChoiceAddress
    ld c, [hl]
    ld b, $00
    ld hl, ActionHandlerMaskTable
    add hl, bc
    add hl, bc
    ld a, [hli]
    ld b, [hl]
    ld c, a
    ret

; ActorActionDataWord reads the word at $4D34 + 2 * the actor's chosen action byte;
; RunActorActionHandlersForAISlots skips $FFFF and otherwise passes it to RunHandlersForSetBitsInBC;
; 240 words up to that routine at $4F14 (E-0237, C1)
; record: handler bit mask ($FFFF = none)
ActionHandlerMaskTable::
    dw $0041 ; id 0
    dw $0040 ; id 1
    dw $0040 ; id 2
    dw $0040 ; id 3
    dw $0040 ; id 4
    dw $0040 ; id 5
    dw $0040 ; id 6
    dw $0040 ; id 7
    dw $0040 ; id 8
    dw $0040 ; id 9
    dw $0040 ; id 10
    dw $0040 ; id 11
    dw $0040 ; id 12
    dw $0040 ; id 13
    dw $0040 ; id 14
    dw $0040 ; id 15
    dw $0040 ; id 16
    dw $0040 ; id 17
    dw $0040 ; id 18
    dw $0004 ; id 19
    dw $0004 ; id 20
    dw $ffff ; id 21
    dw $0010 ; id 22
    dw $0010 ; id 23
    dw $0010 ; id 24
    dw $0010 ; id 25
    dw $0010 ; id 26
    dw $0010 ; id 27
    dw $0010 ; id 28
    dw $0010 ; id 29
    dw $0010 ; id 30
    dw $0010 ; id 31
    dw $ffff ; id 32
    dw $0010 ; id 33
    dw $0010 ; id 34
    dw $0010 ; id 35
    dw $0010 ; id 36
    dw $ffff ; id 37
    dw $ffff ; id 38
    dw $0004 ; id 39
    dw $0004 ; id 40
    dw $ffff ; id 41
    dw $ffff ; id 42
    dw $0004 ; id 43
    dw $0004 ; id 44
    dw $ffff ; id 45
    dw $0004 ; id 46
    dw $0004 ; id 47
    dw $0004 ; id 48
    dw $ffff ; id 49
    dw $0004 ; id 50
    dw $0004 ; id 51
    dw $0004 ; id 52
    dw $ffff ; id 53
    dw $ffff ; id 54
    dw $ffff ; id 55
    dw $ffff ; id 56
    dw $ffff ; id 57
    dw $ffff ; id 58
    dw $ffff ; id 59
    dw $ffff ; id 60
    dw $0040 ; id 61
    dw $0040 ; id 62
    dw $0040 ; id 63
    dw $0040 ; id 64
    dw $0040 ; id 65
    dw $0040 ; id 66
    dw $0040 ; id 67
    dw $0040 ; id 68
    dw $0040 ; id 69
    dw $0040 ; id 70
    dw $0040 ; id 71
    dw $0040 ; id 72
    dw $0040 ; id 73
    dw $0040 ; id 74
    dw $0040 ; id 75
    dw $0040 ; id 76
    dw $0040 ; id 77
    dw $ffff ; id 78
    dw $ffff ; id 79
    dw $0041 ; id 80
    dw $0041 ; id 81
    dw $0041 ; id 82
    dw $0041 ; id 83
    dw $0041 ; id 84
    dw $0041 ; id 85
    dw $0041 ; id 86
    dw $0041 ; id 87
    dw $0041 ; id 88
    dw $0041 ; id 89
    dw $0041 ; id 90
    dw $0041 ; id 91
    dw $0041 ; id 92
    dw $0041 ; id 93
    dw $0041 ; id 94
    dw $0041 ; id 95
    dw $0041 ; id 96
    dw $0041 ; id 97
    dw $0041 ; id 98
    dw $0041 ; id 99
    dw $0041 ; id 100
    dw $0041 ; id 101
    dw $0041 ; id 102
    dw $0041 ; id 103
    dw $ffff ; id 104
    dw $ffff ; id 105
    dw $ffff ; id 106
    dw $ffff ; id 107
    dw $ffff ; id 108
    dw $ffff ; id 109
    dw $ffff ; id 110
    dw $ffff ; id 111
    dw $ffff ; id 112
    dw $0004 ; id 113
    dw $0004 ; id 114
    dw $0004 ; id 115
    dw $0004 ; id 116
    dw $0004 ; id 117
    dw $0004 ; id 118
    dw $0004 ; id 119
    dw $0004 ; id 120
    dw $0004 ; id 121
    dw $0004 ; id 122
    dw $ffff ; id 123
    dw $0010 ; id 124
    dw $0080 ; id 125
    dw $0004 ; id 126
    dw $0004 ; id 127
    dw $0004 ; id 128
    dw $0010 ; id 129
    dw $ffff ; id 130
    dw $ffff ; id 131
    dw $ffff ; id 132
    dw $ffff ; id 133
    dw $ffff ; id 134
    dw $ffff ; id 135
    dw $ffff ; id 136
    dw $ffff ; id 137
    dw $ffff ; id 138
    dw $0004 ; id 139
    dw $0004 ; id 140
    dw $0004 ; id 141
    dw $0004 ; id 142
    dw $0004 ; id 143
    dw $0004 ; id 144
    dw $0004 ; id 145
    dw $0004 ; id 146
    dw $0004 ; id 147
    dw $0002 ; id 148
    dw $0020 ; id 149
    dw $000a ; id 150
    dw $ffff ; id 151
    dw $ffff ; id 152
    dw $ffff ; id 153
    dw $ffff ; id 154
    dw $ffff ; id 155
    dw $ffff ; id 156
    dw $ffff ; id 157
    dw $ffff ; id 158
    dw $0010 ; id 159
    dw $0010 ; id 160
    dw $ffff ; id 161
    dw $ffff ; id 162
    dw $ffff ; id 163
    dw $ffff ; id 164
    dw $ffff ; id 165
    dw $ffff ; id 166
    dw $ffff ; id 167
    dw $ffff ; id 168
    dw $ffff ; id 169
    dw $0002 ; id 170
    dw $ffff ; id 171
    dw $ffff ; id 172
    dw $ffff ; id 173
    dw $ffff ; id 174
    dw $ffff ; id 175
    dw $ffff ; id 176
    dw $ffff ; id 177
    dw $ffff ; id 178
    dw $ffff ; id 179
    dw $ffff ; id 180
    dw $ffff ; id 181
    dw $ffff ; id 182
    dw $ffff ; id 183
    dw $ffff ; id 184
    dw $ffff ; id 185
    dw $ffff ; id 186
    dw $ffff ; id 187
    dw $ffff ; id 188
    dw $ffff ; id 189
    dw $ffff ; id 190
    dw $ffff ; id 191
    dw $ffff ; id 192
    dw $ffff ; id 193
    dw $ffff ; id 194
    dw $ffff ; id 195
    dw $ffff ; id 196
    dw $ffff ; id 197
    dw $ffff ; id 198
    dw $ffff ; id 199
    dw $ffff ; id 200
    dw $ffff ; id 201
    dw $ffff ; id 202
    dw $ffff ; id 203
    dw $ffff ; id 204
    dw $ffff ; id 205
    dw $ffff ; id 206
    dw $ffff ; id 207
    dw $ffff ; id 208
    dw $ffff ; id 209
    dw $ffff ; id 210
    dw $ffff ; id 211
    dw $ffff ; id 212
    dw $ffff ; id 213
    dw $ffff ; id 214
    dw $ffff ; id 215
    dw $ffff ; id 216
    dw $ffff ; id 217
    dw $ffff ; id 218
    dw $ffff ; id 219
    dw $ffff ; id 220
    dw $ffff ; id 221
    dw $ffff ; id 222
    dw $ffff ; id 223
    dw $ffff ; id 224
    dw $ffff ; id 225
    dw $ffff ; id 226
    dw $ffff ; id 227
    dw $ffff ; id 228
    dw $ffff ; id 229
    dw $ffff ; id 230
    dw $ffff ; id 231
    dw $ffff ; id 232
    dw $ffff ; id 233
    dw $ffff ; id 234
    dw $ffff ; id 235
    dw $ffff ; id 236
    dw $ffff ; id 237
    dw $ffff ; id 238
    dw $ffff ; id 239

; for bit numbers 0-15 in turn (BitMaskWords16): when the bit is set in BC (C for 0-7, B for 8-15),
; calls handler E through CallFlagBitHandlerE; stops early when a handler returns carry (E-0102)
RunHandlersForSetBitsInBC::
    ld e, $00
    ld d, $10
    ld hl, BitMaskWords16

.loop:
    push hl
    push bc
    push de
    ld a, c
    and [hl]
    jr z, .next
    call CallFlagBitHandlerE
    jr .restore

.next:
    inc hl
    ld a, b
    and [hl]
    jr z, .restore
    call CallFlagBitHandlerE

.restore:
    pop de
    pop bc
    pop hl
    jr c, .return
    inc hl
    inc hl
    inc e
    dec d
    jr nz, .loop

.return:
    ret

; E = bit number: jumps through the 16-word handler table at $4F66 (JumpToWordAtHL) (E-0102)
CallFlagBitHandlerE::
    ld d, $00
    ld hl, $4f66
    add hl, de
    add hl, de
    call JumpToWordAtHL
    ret

; 16 words $0001, $0002, ... $8000, one bit each (E-0102)
BitMaskWords16::
    db $01, $00, $02, $00, $04, $00, $08, $00, $10, $00, $20, $00, $40, $00, $80, $00
    db $00, $01, $00, $02, $00, $04, $00, $08, $00, $10, $00, $20, $00, $40, $00, $80
    dw RollPersonalityHiHighFlag01
    dw RollPersonalityHiLowFlag02
    dw RollPersonalityMidHighFlag04
    dw RollPersonalityMidLowFlag08
    dw RollPersonalityLoHighFlag10
    dw RollPersonalityLoLowFlag20
    dw RollSlotTraitHighFlag40
    dw RollSlotTraitLowFlag80
    db $c6, $4f, $c6, $4f, $c6, $4f, $c6, $4f, $c6, $4f, $c6, $4f, $c6, $4f, $c6, $4f

; AI trait roll with mask DE = $01: when the actor's value is at least $80 rolls a chance that grows
; with its distance from $80 (E-0122) (C2 from E-0337: sets bit 0 of the actor's wPersonalityActs;
; forced, that act shows 'struck at full power!' ($2E))
RollPersonalityHiHighFlag01::
    ld hl, wSlotPersonalityHi
    ld de, $0001
    jr RollSlotTraitLowFlag80_CallAdvanceRandom

; AI trait roll with mask DE = $02: when the actor's value is below $80 rolls a chance that grows
; with its distance from $80 (E-0122) (C2 from E-0337: sets bit 1 of the actor's wPersonalityActs;
; forced, that act shows 'tucked tighter in fear!' ($2F))
RollPersonalityHiLowFlag02::
    ld hl, wSlotPersonalityHi
    ld de, $0002
    jr RollSlotTraitLowFlag80_CallAdvanceRandom2

; AI trait roll with mask DE = $04: when the actor's value is at least $80 rolls a chance that grows
; with its distance from $80 (E-0122) (C2 from E-0337: sets bit 2 of the actor's wPersonalityActs;
; forced, that act shows 'concentrated!' ($30))
RollPersonalityMidHighFlag04::
    ld hl, wSlotPersonalityMid
    ld de, $0004
    jr RollSlotTraitLowFlag80_CallAdvanceRandom

; AI trait roll with mask DE = $08: when the actor's value is below $80 rolls a chance that grows
; with its distance from $80 (E-0122) (E-0337: sets bit 3 of wPersonalityActs; forced, it showed no
; text)
RollPersonalityMidLowFlag08::
    ld hl, wSlotPersonalityMid
    ld de, $0008
    jr RollSlotTraitLowFlag80_CallAdvanceRandom2

; AI trait roll with mask DE = $10: when the actor's value is at least $80 rolls a chance that grows
; with its distance from $80 (E-0122) (C2 from E-0337: sets bit 4 of the actor's wPersonalityActs;
; forced, that act shows 'Light fell softly on 0!' ($32))
RollPersonalityLoHighFlag10::
    ld hl, wSlotPersonalityLo
    ld de, $0010
    jr RollSlotTraitLowFlag80_CallAdvanceRandom

; AI trait roll with mask DE = $20: when the actor's value is below $80 rolls a chance that grows
; with its distance from $80 (E-0122) (C2 from E-0337: sets bit 5 of the actor's wPersonalityActs;
; forced, that act shows 'ducked behind <ally>!' ($33))
RollPersonalityLoLowFlag20::
    ld hl, wSlotPersonalityLo
    ld de, $0020
    jr RollSlotTraitLowFlag80_CallAdvanceRandom2

; AI trait roll with mask DE = $40: when the actor's value is at least $80 rolls a chance that grows
; with its distance from $80 (E-0122) (C2 from E-0337: sets bit 6 of the actor's wPersonalityActs;
; forced, that act shows 'pumped itself up!' ($34))
RollSlotTraitHighFlag40::
    ld hl, wSlotTrait
    ld de, $0040
    jr RollSlotTraitLowFlag80_CallAdvanceRandom

; AI trait roll with mask DE = $80: when the actor's wSlotTrait value is below $80 rolls a chance
; that grows with its distance from $80 (E-0125) (C2 from E-0337: sets bit 7 of the actor's
; wPersonalityActs; forced, that act shows 'rolled out of the way!' ($35))
RollSlotTraitLowFlag80::
    ld hl, wSlotTrait
    ld de, $0080
    jr RollSlotTraitLowFlag80_CallAdvanceRandom2
    db $af, $c9

RollSlotTraitLowFlag80_CallAdvanceRandom::
    call AdvanceRandom
    ld a, [wRandomLo]
    ld b, a
    ld a, [wBattleActor]
    add_a_to_hl
    ld a, [hl]
    cp $80
    ret c
    cp $a2
    jr c, RollSlotTraitLowFlag80_Skip2
    cp $c3
    jr c, RollSlotTraitLowFlag80_Skip3
    cp $e4
    jr c, RollSlotTraitLowFlag80_Skip4
    jr RollSlotTraitLowFlag80_Skip

RollSlotTraitLowFlag80_CallAdvanceRandom2::
    call AdvanceRandom
    ld a, [wRandomLo]
    ld b, a
    ld a, [wBattleActor]
    add_a_to_hl
    ld a, [hl]
    cp $80
    ret nc
    cp $60
    jr nc, RollSlotTraitLowFlag80_Skip2
    cp $3f
    jr nc, RollSlotTraitLowFlag80_Skip3
    cp $1e
    jr nc, RollSlotTraitLowFlag80_Skip4

RollSlotTraitLowFlag80_Skip::
    ld c, $08
    jr RollSlotTraitLowFlag80_Skip5

RollSlotTraitLowFlag80_Skip2::
    ld c, $01
    jr RollSlotTraitLowFlag80_Skip5

RollSlotTraitLowFlag80_Skip3::
    ld c, $02
    jr RollSlotTraitLowFlag80_Skip5

RollSlotTraitLowFlag80_Skip4::
    ld c, $04

RollSlotTraitLowFlag80_Skip5::
    ld a, b
    cp c
    ret nc
    ld a, [wBattleActor]
    ld hl, wPersonalityActs
    add a
    add_a_to_hl
    ld a, [hl]
    or e
    ld [hli], a
    ld a, [hl]
    or d
    ld [hl], a
    scf
    ret

RunCommandEntryResolveStep_Case01_IncBIfActorEntryBelow40::
    ld b, $00
    ld hl, wSlotPersonalityHi
    call IncBIfActorEntryBelow40
    ld hl, wSlotPersonalityMid
    call IncBIfActorEntryBelow40
    ld hl, wSlotPersonalityLo
    call IncBIfActorEntryBelow40
    ld a, b
    cp $03
    jr z, .call_actor_action_choice_address
    ld b, $00
    ld hl, wSlotPersonalityMid
    call CountIfActorPersonalityHiAtLeastHLEntry
    ld hl, wSlotPersonalityLo
    call CountIfActorPersonalityHiAtLeastHLEntry
    ld a, b
    cp $02
    jr nz, .call_actor_action_choice_address2
    ld hl, wTemp0
    ld bc, $0008
    ld a, $ff
    call FillBytes
    call RunCommandEntryResolveStep_Case01_Sub03_WriteRecordBufferAndBattleArg0Etc
    ld a, [wBattleActor]
    ld hl, wSlotPersonalityHi
    add_a_to_hl
    ld a, [hl]
    cp $40
    jr c, .call_filter_skill_list_by_mp
    ld a, [wTemp0]
    cp $ff
    jr z, .call_actor_action_choice_address3

.call_filter_skill_list_by_mp:
    call FilterSkillListByMP
    ld a, [wPauseMenuStep]
    cp $ff
    jr z, .call_actor_action_choice_address3
    call RunCommandEntryResolveStep_Case01_Sub03_FillBytes
    ld a, [wTemp0]
    cp $ff
    jr z, .call_actor_action_choice_address3
    call RunCommandEntryResolveStep_Case01_Sub03_LoadSkillRecordPart
    call ActorActionChoiceAddress
    ld [hl], c
    ret

.call_actor_action_choice_address:
    call ActorActionChoiceAddress
    ld [hl], $ab
    ret

.call_actor_action_choice_address2:
    call ActorActionChoiceAddress
    ld [hl], $ac
    ret

.call_actor_action_choice_address3:
    call ActorActionChoiceAddress
    ld [hl], $00
    ret

; B += 1 when the byte at HL + wBattleActor is below $40 (E-0115)
IncBIfActorEntryBelow40::
    ld a, [wBattleActor]
    add_a_to_hl
    ld a, [hl]
    cp $40
    ret nc
    inc b
    ret

; B += 1 when wSlotPersonalityHi[actor] >= [HL + actor] (E-0122)
CountIfActorPersonalityHiAtLeastHLEntry::
    ld a, [wBattleActor]
    add_a_to_hl
    ld a, [wBattleActor]
    ld de, wSlotPersonalityHi
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    cp [hl]
    ret c
    inc b
    ret

RunCommandEntryResolveStep_Case01_Sub03_WriteRecordBufferAndBattleArg0Etc::
    ld a, [wBattleActor]
    swap a
    ld hl, wBattleSkills
    add_a_to_hl
    ld b, $08
    ld c, $00

.loop:
    ld a, [hl]
    cp $ff
    jr z, .next
    push hl
    push bc
    ld [wRecordBuffer], a
    ld a, $03
    ld [wBattleArg0], a
    xor a
    ld [wRecordBuffer + $1], a
    ld a, $01
    ld [wBattleArg1], a
    ld hl, wRecordBufferData + $3
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    farcall LoadSkillRecordPart
    ld a, [wRecordBufferData + $3]
    and $03
    cp $02
    pop bc
    pop hl
    jr z, .next
    ld a, c
    ld de, wTemp0
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [hl]
    ld [de], a
    inc c

.next:
    inc hl
    inc hl
    dec b
    jr nz, .loop
    ret

; wBattleActor selects the actor; its MP word is at wBattleMP + 2 * actor. For each of the 8 skill
; numbers in wTemp0 it loads the record (LoadSkillRecordPart) and keeps the number only when byte 0
; of the record is below that MP word; otherwise it writes $FF to that slot. The comparison is
; strict: a skill whose cost equals the MP is dropped. Executed on the emulator for MP 0-40 against
; the ROM's costs (E-0048)
FilterSkillListByMP::
    ld a, [wBattleActor]
    ld hl, wBattleMP
    add a
    add_a_to_hl
    ld a, [hli]
    ld b, [hl]
    ld c, a
    ld hl, wTemp0
    ld e, $08
    ld d, $00

.loop:
    ld a, [hl]
    cp $ff
    jr z, .skip
    push hl
    push bc
    push de
    ld [wRecordBuffer], a
    ld a, $00
    ld [wBattleArg0], a
    xor a
    ld [wRecordBuffer + $1], a
    ld a, $01
    ld [wBattleArg1], a
    ld hl, wRecordBufferData
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    farcall LoadSkillRecordPart
    pop de
    pop bc
    ld a, [wRecordBufferData]
    ld l, a
    ld h, $00
    call CompareHLToBC
    jr c, .next
    ld a, d
    ld hl, wTemp0
    add_a_to_hl
    ld [hl], $ff

.next:
    inc d
    pop hl
    inc hl
    dec e
    jr nz, .loop

.skip:
    ld hl, wPauseMenuStep
    ld bc, $0008
    ld a, $ff
    call FillBytes
    ld hl, wTemp0
    ld de, wPauseMenuStep
    jr RunCommandEntryResolveStep_Case01_Sub03_FillBytes_Skip

RunCommandEntryResolveStep_Case01_Sub03_FillBytes::
    ld hl, wPauseMenuStep
    ld b, $08
    ld c, $00

.loop:
    ld a, [hl]
    cp $ff
    jr z, .skip2
    call RunCommandEntryResolveStep_Case01_Sub03_Sub02_Cp01
    jr c, .next
    ld a, c
    ld de, wPauseMenuStep
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, $ff
    ld [de], a

.next:
    inc c
    inc hl
    dec b
    jr nz, .loop

.skip2:
    ld hl, wTemp0
    ld bc, $0008
    ld a, $ff
    call FillBytes
    ld hl, wPauseMenuStep
    ld de, wTemp0

RunCommandEntryResolveStep_Case01_Sub03_FillBytes_Skip::
    ld b, $08

.loop:
    ld a, [hl]
    cp $ff
    jr z, .next
    ld a, [hl]
    ld [de], a
    inc de

.next:
    inc hl
    dec b
    jr nz, .loop
    ret

RunCommandEntryResolveStep_Case01_Sub03_Sub02_Cp01::
    cp $01
    jr c, .done
    cp $16
    jr c, .return_carry
    cp $3d
    jr c, .done
    cp $68
    jr c, .return_carry
    cp $6b
    jr z, .return_carry
    cp $6c
    jr z, .return_carry
    cp $6d
    jr z, .return_carry
    cp $6e
    jr z, .return_carry
    cp $6f
    jr z, .return_carry
    cp $70
    jr z, .return_carry

.done:
    scf
    ccf
    ret

.return_carry:
    scf
    ret

RunCommandEntryResolveStep_Case01_Sub03_LoadSkillRecordPart::
    ld a, [wTemp0]
    ld [wRecordBuffer], a
    ld a, $00
    ld [wBattleArg0], a
    xor a
    ld [wRecordBuffer + $1], a
    ld a, $01
    ld [wBattleArg1], a
    ld hl, wRecordBufferData
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    farcall LoadSkillRecordPart
    ld a, [wRecordBufferData]
    ld c, a
    ld b, $00
    ld hl, wTemp1
    ld de, $0700

.loop:
    ld a, [hl]
    cp $ff
    jr z, .skip
    push hl
    push de
    push bc
    ld [wRecordBuffer], a
    ld a, $00
    ld [wBattleArg0], a
    xor a
    ld [wRecordBuffer + $1], a
    ld a, $01
    ld [wBattleArg1], a
    ld hl, wRecordBufferData
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    farcall LoadSkillRecordPart
    ld a, [wRecordBufferData]
    ld l, a
    ld h, $00
    pop bc
    pop de
    call CompareHLToBC
    jr c, .restore
    ld c, l
    ld b, h
    ld a, $08
    sub d
    ld e, a

.restore:
    pop hl
    inc hl
    dec d
    jr nz, .loop

.skip:
    ld a, e
    ld hl, wTemp0
    add_a_to_hl
    ld c, [hl]
    ret

; B = forced action $CD, $CC, $CE or $CF by the actor's status bits (wBattleStatus3 byte 0 bit 6,
; byte 1 bit 2, byte 2 bit 4, byte 5 bit 0); Z when none (E-0124)
ForcedActionForActorStatus::
    ld a, [wBattleActor]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hli]
    and $40
    jr z, .skip
    ld b, $cd
    jr .return

.skip:
    ld a, [hli]
    and $04
    jr z, .skip2
    ld b, $cc
    jr .return

.skip2:
    ld a, [hli]
    and $10
    jr z, .next
    ld b, $ce
    jr .return

.next:
    inc hl
    inc hl
    ld a, [hl]
    and $01
    jr z, .return
    ld b, $cf

.return:
    ret

RunCommandEntryResolveStep_Case01_WaitLinkMode::
    ld a, [wLinkMode]
    or a
    ret nz
    ld a, [wBattleActor]
    cp $03
    ret nc
    xor a
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ld bc, $0000
    ld a, [wBattleActor]
    ld hl, wBattleLevel
    add_a_to_hl
    ld a, [hl]
    cp $0a
    jr c, .skip
    cp $14
    jr c, .skip2
    cp $1e
    jr c, .read_battle_actor
    ld c, $0c
    jr .read_battle_actor2

.skip:
    ld c, $00
    jr .read_battle_actor2

.skip2:
    ld c, $04
    jr .read_battle_actor2

.read_battle_actor:
    ld c, $08

.read_battle_actor2:
    ld de, $0000
    ld a, [wBattleActor]
    ld hl, wSlotTrait
    add_a_to_hl
    ld a, [hl]
    cp $97
    jr c, .call_get_actor_slot_tactic_low2
    ld e, $10

.call_get_actor_slot_tactic_low2:
    call GetActorSlotTacticLow2
    ld hl, TacticOffsetTable
    call ReadBattleWordFromArray_Bank30
    add hl, de
    add hl, bc
    call CopyFourBytesNegatedByActorSlotTactic
    call RunCommandEntryResolveStep_Case01_Sub04_GetActorSlotTacticLow2
    ret

; copies four bytes from HL to hTemp0, negating each when bit 6 of the actor's wSlotTactic byte is
; set (CopyByteNegateIfCBit6) (E-0122)
CopyFourBytesNegatedByActorSlotTactic::
    push hl
    call GetActorSlotTacticLow2
    ld c, [hl]
    pop hl
    ld de, hTemp0
    call CopyByteNegateIfCBit6
    inc hl
    inc de
    call CopyByteNegateIfCBit6
    inc hl
    inc de
    call CopyByteNegateIfCBit6
    inc hl
    inc de
    call CopyByteNegateIfCBit6
    ret

; [DE] = [HL], negated (two's complement) when bit 6 of C is set (E-0115)
CopyByteNegateIfCBit6::
    ld a, [hl]
    ld [de], a
    bit 6, c
    ret z
    cpl
    inc a
    ld [de], a
    ret

RunCommandEntryResolveStep_Case01_Sub04_GetActorSlotTacticLow2::
    ld a, [wCommandByteE8]
    ld c, a
    ld b, $00
    ld hl, hTemp0
    add hl, bc
    ld e, [hl]
    push hl
    call GetActorSlotTacticLow2
    bit 6, [hl]
    pop hl
    jr z, .read_temp0
    ld a, e
    cpl
    inc a
    ld e, a
    ld [hl], e

.read_temp0:
    ldh a, [hTemp0]
    ld e, a
    ld hl, wSlotPersonalityHi
    call AddSignedEToByteAtHLClampedForActorEntryOfHL
    ldh a, [hTemp1]
    ld e, a
    ld hl, wSlotPersonalityMid
    call AddSignedEToByteAtHLClampedForActorEntryOfHL
    ldh a, [hTemp2]
    ld e, a
    ld hl, wSlotPersonalityLo
    call AddSignedEToByteAtHLClampedForActorEntryOfHL
    ldh a, [hTemp3]
    ld e, a
    ld hl, wSlotTrait

; HL += actor, then AddSignedEToByteAtHLClamped (E-0122)
AddSignedEToByteAtHLClampedForActorEntryOfHL::
    ld a, [wBattleActor]
    add_a_to_hl
    call AddSignedEToByteAtHLClamped
    ret

; the code at RunCommandEntryResolveStep_Case01_WaitLinkMode.call_get_actor_slot_tactic_low2 indexes
; it with GetActorSlotTacticLow2 (wSlotTactic & 3), adds E ($10 when wSlotTrait >= $97, else 0) and
; C (0/4/8/12 from a threshold test on A), then CopyFourBytesNegatedByActorSlotTactic copies the
; four bytes to hTemp0, negating each when bit 6 of the actor's tactic byte is set (E-0234, C1)
; record: block of eight 4-byte records for this tactic
TacticOffsetTable::
    dw TacticOffsets0 ; id 0
    dw TacticOffsets1 ; id 1
    dw TacticOffsets2 ; id 2
    dw TacticOffsets3 ; id 3

; block 0 of TacticOffsetTable; records 0-3 are used when wSlotTrait < $97 and records 4-7
; otherwise, the record within each half chosen by the threshold test before
; RunCommandEntryResolveStep_Case01_WaitLinkMode.read_battle_actor2 (E-0234, C1)
; record: four bytes copied to hTemp0 (two's complement; negated when bit 6 of the tactic byte is
; set)
TacticOffsets0::
    db $07, $ff, $00, $03 ; id 0
    db $05, $ff, $00, $02 ; id 1
    db $03, $ff, $00, $01 ; id 2
    db $02, $ff, $00, $01 ; id 3
    db $0a, $ff, $00, $04 ; id 4
    db $07, $ff, $00, $03 ; id 5
    db $05, $ff, $00, $02 ; id 6
    db $05, $00, $00, $01 ; id 7

; block 1 of TacticOffsetTable; records 0-3 are used when wSlotTrait < $97 and records 4-7
; otherwise, the record within each half chosen by the threshold test before
; RunCommandEntryResolveStep_Case01_WaitLinkMode.read_battle_actor2 (E-0234, C1)
TacticOffsets1::
    db $00, $07, $fe, $03 ; id 0
    db $00, $05, $fe, $02 ; id 1
    db $00, $04, $ff, $01 ; id 2
    db $00, $03, $ff, $01 ; id 3
    db $00, $0a, $fd, $04 ; id 4
    db $00, $07, $fe, $03 ; id 5
    db $00, $05, $ff, $02 ; id 6
    db $00, $05, $00, $01 ; id 7

; block 2 of TacticOffsetTable; records 0-3 are used when wSlotTrait < $97 and records 4-7
; otherwise, the record within each half chosen by the threshold test before
; RunCommandEntryResolveStep_Case01_WaitLinkMode.read_battle_actor2 (E-0234, C1)
TacticOffsets2::
    db $fe, $00, $07, $03 ; id 0
    db $fe, $00, $05, $02 ; id 1
    db $ff, $00, $04, $01 ; id 2
    db $ff, $00, $03, $01 ; id 3
    db $fe, $00, $0a, $04 ; id 4
    db $fe, $00, $07, $03 ; id 5
    db $ff, $00, $05, $02 ; id 6
    db $00, $00, $05, $01 ; id 7

; block 3 of TacticOffsetTable; records 0-3 are used when wSlotTrait < $97 and records 4-7
; otherwise, the record within each half chosen by the threshold test before
; RunCommandEntryResolveStep_Case01_WaitLinkMode.read_battle_actor2 (E-0234, C1)
TacticOffsets3::
    db $00, $00, $00, $ff ; id 0
    db $00, $00, $00, $fe ; id 1
    db $00, $00, $00, $fe ; id 2
    db $00, $00, $00, $ff ; id 3
    db $00, $00, $00, $ff ; id 4
    db $00, $00, $00, $fe ; id 5
    db $00, $00, $00, $fe ; id 6
    db $00, $00, $00, $ff ; id 7

; A = wSlotTactic[wBattleActor] & 3 (E-0072)
GetActorSlotTacticLow2::
    ld a, [wBattleActor]
    ld hl, wSlotTactic
    add_a_to_hl
    ld a, [hl]
    and $03
    ret

; HL = wBattleActionChoice + 2 * wBattleActor (the actor's action byte; the target follows) (E-0072)
ActorActionChoiceAddress::
    ld a, [wBattleActor]
    add a
    ld hl, wBattleActionChoice
    add_a_to_hl
    ret

; [HL] += E as a signed value, clamped to 0-$FF (E-0124)
AddSignedEToByteAtHLClamped::
    bit 7, e
    jr z, .skip
    ld a, e
    cpl
    inc a
    ld e, a
    ld a, [hl]
    sub e
    jr nc, .done
    ld a, $00
    jr .done

.skip:
    ld a, e
    add [hl]
    jr nc, .done
    ld a, $ff

.done:
    ld [hl], a
    ret

; wPersonalityIndex = PersonalityIndexOfSlot_Bank30(actor); resets the AI workspace
; (AIChooseActionForActor_AddCommandWeightToAIChoiceWeights); with wAIFlag = 1 runs the routine for
; the actor's AI mode (AIModeRoutineTable indexed by wSlotAIMode[actor], JumpToHL) and stores its
; result B as the actor's chosen action; runs RunActorActionHandlersForAISlots; wAIFlag = 0 (E-0120)
AIChooseActionForActor::
    ld a, [wBattleActor]
    call PersonalityIndexOfSlot_Bank30
    ld [wPersonalityIndex], a
    call AIChooseActionForActor_AddCommandWeightToAIChoiceWeights
    ld a, $01
    ld [wAIFlag], a
    ld a, [wBattleActor]
    ld hl, wSlotAIMode
    add_a_to_hl
    ld a, [hl]
    ld hl, AIModeRoutineTable
    call ReadBattleWordFromArray_Bank30
    call JumpToHL
    call ActorActionChoiceAddress
    ld [hl], b
    call RunActorActionHandlersForAISlots
    xor a
    ld [wAIFlag], a
    ret

AIChooseActionForActor_AddCommandWeightToAIChoiceWeights::
    ld hl, wAIWeights
    ld bc, $0014
    xor a
    call FillBytes
    xor a
    ld [wAIChoiceWeights], a
    ld [wAIChoiceWeights + $1], a
    ld [wAIChoiceWeights + $2], a
    ld a, $01
    ld [wAIChoiceOrder], a
    ld a, $02
    ld [wAIChoiceOrder + $1], a
    ld a, $03
    ld [wAIChoiceOrder + $2], a
    ld a, $03
    ld [wAIChoiceIndex], a
    call AIChooseActionForActor_Sub01_ReadRecordBufferData
    call AddCommandWeightToAIChoiceWeights
    call AddActorPersonalityTensToAIChoiceWeights
    call AddStatusAndHPWeightsToAI
    call AIChooseActionForActor_Sub01_WriteAIChoiceWeights
    call AddRandomPersonalityWeights
    call SortThreeAIWeightsRandomTies
    ld a, $00
    ld [wLoadSlot], a
    ret

AIChooseActionForActor_Sub01_ReadRecordBufferData::
    ld a, [wRecordBufferData + $3]
    and $f0
    cp $10
    jr z, .skip
    cp $20
    jr z, .skip2
    cp $30
    jr z, .skip3
    jr .return

.skip:
    ld hl, wAIChoiceWeights
    jr .skip4

.skip2:
    ld hl, wAIChoiceWeights + $1
    jr .skip4

.skip3:
    ld hl, wAIChoiceWeights + $2

.skip4:
    ld a, [hl]
    add $0a
    ld [hl], a

.return:
    ret

AIChooseActionForActor_Sub01_WriteAIChoiceWeights::
    ld a, [wBattleActor]
    rrca
    and $02
    xor $02
    ld hl, wBattleCommandArgs
    add_a_to_hl
    deref_hl
    push hl
    ld a, [wBattleActor]
    rrca
    and $02
    ld hl, wBattleCommandArgs
    add_a_to_hl
    deref_hl
    push hl
    ld a, [wBattleActor]
    rlca
    and $08
    ld hl, wBattleHP
    add_a_to_hl
    ld bc, $0000
    ld a, [hli]
    add c
    ld c, a
    ld a, [hli]
    adc b
    ld b, a
    ld a, [hli]
    add c
    ld c, a
    ld a, [hli]
    adc b
    ld b, a
    ld a, [hli]
    add c
    ld c, a
    ld a, [hli]
    adc b
    ld b, a
    ld h, b
    ld l, c
    add hl, bc
    pop bc
    call CompareHLToBC
    jr nc, .read_battle_actor
    ld a, [wAIChoiceWeights + $2]
    add $14
    ld [wAIChoiceWeights + $2], a

.read_battle_actor:
    ld a, [wBattleActor]
    rlca
    and $08
    xor $08
    ld hl, wBattleHP
    add_a_to_hl
    ld bc, $0000
    ld a, [hli]
    add c
    ld c, a
    ld a, [hli]
    adc b
    ld b, a
    ld a, [hli]
    add c
    ld c, a
    ld a, [hli]
    adc b
    ld b, a
    ld a, [hli]
    add c
    ld c, a
    ld a, [hli]
    adc b
    ld b, a
    ld h, b
    ld l, c
    add hl, bc
    add hl, bc
    pop bc
    call CompareHLToBC
    jr nc, .return
    ld a, [wAIChoiceWeights]
    add $14
    ld [wAIChoiceWeights], a

.return:
    ret

; advances the random seed; when wDebugCursor is set and the random value is below wDebugValue1,
; stores wDebugValue0 as the actor's action choice (E-0122)
MaybeOverrideActorActionWithDebugValue0::
    call AdvanceRandom
    call ActorActionChoiceAddress
    ld a, [wDebugCursor]
    or a
    jr z, .return
    ld a, [wDebugValue1]
    ld b, a
    ld a, [wRandomLo]
    cp b
    jr nc, .return
    ld a, [wDebugValue0]
    ld [hl], a

.return:
    ret

; AddPersonalityWeightToBattleArg0 adds the byte $5587 + 4 * wPersonalityIndex + (the actor's
; wSlotTactic & 3) to the word wBattleArg0; 27 personality rows (E-0173, C1)
; record: weight added for tactic 0, 1, 2, 3
PersonalityTacticWeights::
    db $14, $14, $14, $00 ; id 0
    db $14, $14, $0f, $00 ; id 1
    db $14, $14, $05, $00 ; id 2
    db $14, $0f, $14, $00 ; id 3
    db $14, $0f, $0f, $00 ; id 4
    db $14, $0f, $05, $0a ; id 5
    db $14, $05, $14, $00 ; id 6
    db $14, $05, $0f, $00 ; id 7
    db $14, $05, $05, $00 ; id 8
    db $0f, $14, $14, $00 ; id 9
    db $0f, $14, $0f, $00 ; id 10
    db $0f, $14, $05, $00 ; id 11
    db $0f, $0f, $14, $00 ; id 12
    db $0f, $0f, $0f, $00 ; id 13
    db $0f, $0f, $05, $00 ; id 14
    db $0f, $05, $14, $00 ; id 15
    db $0f, $05, $0f, $00 ; id 16
    db $0f, $05, $05, $00 ; id 17
    db $05, $14, $14, $00 ; id 18
    db $05, $14, $0f, $00 ; id 19
    db $05, $14, $05, $00 ; id 20
    db $05, $0f, $14, $00 ; id 21
    db $05, $0f, $0f, $00 ; id 22
    db $05, $0f, $05, $00 ; id 23
    db $05, $05, $14, $00 ; id 24
    db $05, $05, $0f, $00 ; id 25
    db $05, $05, $05, $00 ; id 26

; AddSkillBaseWeightAndLoadSkill (from ScoreSkillForAI) adds the word at $55F3 + 2 * skill to the
; score at DE when it is non-zero, then AddSkillBaseWeightAndLoadSkill_AdvanceRandom adds a random
; adjustment; 201 words end at the far-pointer table at $5785; most weights are 50-110 (E-0208, C1)
; record: base weight (0 = none)
SkillAIBaseWeightTable::
    dw 100 ; id 0
    dw 80 ; id 1
    dw 90 ; id 2
    dw 100 ; id 3
    dw 80 ; id 4
    dw 90 ; id 5
    dw 100 ; id 6
    dw 85 ; id 7
    dw 95 ; id 8
    dw 105 ; id 9
    dw 80 ; id 10
    dw 90 ; id 11
    dw 105 ; id 12
    dw 95 ; id 13
    dw 100 ; id 14
    dw 110 ; id 15
    dw 85 ; id 16
    dw 90 ; id 17
    dw 100 ; id 18
    dw 80 ; id 19
    dw 90 ; id 20
    dw 50 ; id 21
    dw 110 ; id 22
    dw 100 ; id 23
    dw 90 ; id 24
    dw 90 ; id 25
    dw 80 ; id 26
    dw 90 ; id 27
    dw 80 ; id 28
    dw 70 ; id 29
    dw 100 ; id 30
    dw 110 ; id 31
    dw 70 ; id 32
    dw 90 ; id 33
    dw 90 ; id 34
    dw 90 ; id 35
    dw 90 ; id 36
    dw 100 ; id 37
    dw 100 ; id 38
    dw 100 ; id 39
    dw 100 ; id 40
    dw 100 ; id 41
    dw 100 ; id 42
    dw 100 ; id 43
    dw 100 ; id 44
    dw 100 ; id 45
    dw 100 ; id 46
    dw 100 ; id 47
    dw 100 ; id 48
    dw 90 ; id 49
    dw 90 ; id 50
    dw 100 ; id 51
    dw 100 ; id 52
    dw 0 ; id 53
    dw 100 ; id 54
    dw 100 ; id 55
    dw 100 ; id 56
    dw 100 ; id 57
    dw 80 ; id 58
    dw 80 ; id 59
    dw 70 ; id 60
    dw 70 ; id 61
    dw 80 ; id 62
    dw 80 ; id 63
    dw 80 ; id 64
    dw 90 ; id 65
    dw 100 ; id 66
    dw 110 ; id 67
    dw 80 ; id 68
    dw 90 ; id 69
    dw 100 ; id 70
    dw 110 ; id 71
    dw 90 ; id 72
    dw 100 ; id 73
    dw 100 ; id 74
    dw 100 ; id 75
    dw 90 ; id 76
    dw 100 ; id 77
    dw 90 ; id 78
    dw 100 ; id 79
    dw 90 ; id 80
    dw 90 ; id 81
    dw 90 ; id 82
    dw 90 ; id 83
    dw 100 ; id 84
    dw 100 ; id 85
    dw 100 ; id 86
    dw 100 ; id 87
    dw 100 ; id 88
    dw 100 ; id 89
    dw 100 ; id 90
    dw 100 ; id 91
    dw 100 ; id 92
    dw 100 ; id 93
    dw 100 ; id 94
    dw 100 ; id 95
    dw 100 ; id 96
    dw 100 ; id 97
    dw 80 ; id 98
    dw 90 ; id 99
    dw 100 ; id 100
    dw 90 ; id 101
    dw 100 ; id 102
    dw 110 ; id 103
    dw 80 ; id 104
    dw 80 ; id 105
    dw 80 ; id 106
    dw 80 ; id 107
    dw 80 ; id 108
    dw 80 ; id 109
    dw 80 ; id 110
    dw 80 ; id 111
    dw 80 ; id 112
    dw 90 ; id 113
    dw 100 ; id 114
    dw 90 ; id 115
    dw 100 ; id 116
    dw 100 ; id 117
    dw 90 ; id 118
    dw 100 ; id 119
    dw 100 ; id 120
    dw 100 ; id 121
    dw 100 ; id 122
    dw 70 ; id 123
    dw 100 ; id 124
    dw 100 ; id 125
    dw 90 ; id 126
    dw 90 ; id 127
    dw 90 ; id 128
    dw 80 ; id 129
    dw 90 ; id 130
    dw 100 ; id 131
    dw 90 ; id 132
    dw 90 ; id 133
    dw 90 ; id 134
    dw 100 ; id 135
    dw 100 ; id 136
    dw 90 ; id 137
    dw 90 ; id 138
    dw 90 ; id 139
    dw 100 ; id 140
    dw 90 ; id 141
    dw 100 ; id 142
    dw 90 ; id 143
    dw 100 ; id 144
    dw 100 ; id 145
    dw 100 ; id 146
    dw 100 ; id 147
    dw 90 ; id 148
    dw 90 ; id 149
    dw 90 ; id 150
    dw 90 ; id 151
    dw 90 ; id 152
    dw 90 ; id 153
    dw 90 ; id 154
    dw 100 ; id 155
    dw 80 ; id 156
    dw 80 ; id 157
    dw 80 ; id 158
    dw 80 ; id 159
    dw 70 ; id 160
    dw 80 ; id 161
    dw 0 ; id 162
    dw 0 ; id 163
    dw 0 ; id 164
    dw 0 ; id 165
    dw 0 ; id 166
    dw 0 ; id 167
    dw 0 ; id 168
    dw 0 ; id 169
    dw 80 ; id 170
    dw 0 ; id 171
    dw 80 ; id 172
    dw 90 ; id 173
    dw 60 ; id 174
    dw 0 ; id 175
    dw 0 ; id 176
    dw 0 ; id 177
    dw 0 ; id 178
    dw 0 ; id 179
    dw 0 ; id 180
    dw 0 ; id 181
    dw 0 ; id 182
    dw 0 ; id 183
    dw 0 ; id 184
    dw 0 ; id 185
    dw 0 ; id 186
    dw 0 ; id 187
    dw 0 ; id 188
    dw 0 ; id 189
    dw 0 ; id 190
    dw 0 ; id 191
    dw 0 ; id 192
    dw 0 ; id 193
    dw 0 ; id 194
    dw 0 ; id 195
    dw 0 ; id 196
    dw 0 ; id 197
    dw 0 ; id 198
    dw 0 ; id 199
    dw 100 ; id 200

; ScoreActionsWithAIScoreTableA stores this table's address in wBattleExpAward / +1 (the AI's
; routine-table pointer) and ScoreSkillForAI far-calls entry 3 * skill; all 131 entries point at
; named AIScore_* routines (E-0174, C1)
; record: AI scoring routine for this skill number; its ROM bank
AIScoreRoutineTableA::
    dfar AIScore_Fight ; id 0
    dfar AIScore_Blaze ; id 1
    dfar AIScore_Blaze ; id 2
    dfar AIScore_Blaze ; id 3
    dfar AIScore_Firebal ; id 4
    dfar AIScore_Firebal ; id 5
    dfar AIScore_Firebal ; id 6
    dfar AIScore_Firebal ; id 7
    dfar AIScore_Firebal ; id 8
    dfar AIScore_Firebal ; id 9
    dfar AIScore_Firebal ; id 10
    dfar AIScore_Firebal ; id 11
    dfar AIScore_Firebal ; id 12
    dfar AIScore_Firebal ; id 13
    dfar AIScore_Firebal ; id 14
    dfar AIScore_Firebal ; id 15
    dfar AIScore_Firebal ; id 16
    dfar AIScore_Firebal ; id 17
    dfar AIScore_Firebal ; id 18
    dfar AIScore_Beat ; id 19
    dfar AIScore_Beat ; id 20
    dfar AIScore_Sacrifice ; id 21
    dfar AIScore_Heal ; id 22
    dfar AIScore_Heal ; id 23
    dfar AIScore_Heal ; id 24
    dfar AIScore_HealUs ; id 25
    dfar AIScore_HealUs ; id 26
    dfar AIScore_MPass ; id 27
    dfar AIScore_MPass ; id 28
    dfar AIScore_MPass ; id 29
    dfar AIScore_Vivify ; id 30
    dfar AIScore_Vivify ; id 31
    dfar AIScore_Farewell ; id 32
    dfar AIScore_Antidote ; id 33
    dfar AIScore_DeChaos ; id 34
    dfar AIScore_NumbOff ; id 35
    dfar AIScore_CurseOff ; id 36
    dfar AIScore_Upper ; id 37
    dfar AIScore_Upper ; id 38
    dfar AIScore_Sap ; id 39
    dfar AIScore_Sap ; id 40
    dfar AIScore_Speed ; id 41
    dfar AIScore_Speed ; id 42
    dfar AIScore_Slow ; id 43
    dfar AIScore_Slow ; id 44
    dfar AIScore_TwinHits ; id 45
    dfar AIScore_Surround ; id 46
    dfar AIScore_Sleep ; id 47
    dfar AIScore_Sleep ; id 48
    dfar AIScore_TakeMagic ; id 49
    dfar AIScore_RobMagic ; id 50
    dfar AIScore_StopSpell ; id 51
    dfar AIScore_PanicAll ; id 52
    dfar AIScore_Ironize ; id 53
    dfar AIScore_MagicBack ; id 54
    dfar AIScore_MagicBack ; id 55
    dfar AIScore_Barrier ; id 56
    dfar AIScore_MagicWall ; id 57
    dfar AIScore_Transform ; id 58
    dfar AIScore_BeDragon ; id 59
    dfar AIScore_Chance ; id 60
    dfar AIScore_MegaMagic ; id 61
    dfar AIScore_BigBang ; id 62
    dfar AIScore_BigBang ; id 63
    dfar AIScore_FireAir ; id 64
    dfar AIScore_FireAir ; id 65
    dfar AIScore_FireAir ; id 66
    dfar AIScore_FireAir ; id 67
    dfar AIScore_FireAir ; id 68
    dfar AIScore_FireAir ; id 69
    dfar AIScore_FireAir ; id 70
    dfar AIScore_FireAir ; id 71
    dfar AIScore_WindBeast ; id 72
    dfar AIScore_Vacuum ; id 73
    dfar AIScore_Vacuum ; id 74
    dfar AIScore_RockThrow ; id 75
    dfar AIScore_Watershot ; id 76
    dfar AIScore_Tidalwave ; id 77
    dfar AIScore_CallHelp ; id 78
    dfar AIScore_CallHelp ; id 79
    dfar AIScore_FireSlash ; id 80
    dfar AIScore_FireSlash ; id 81
    dfar AIScore_FireSlash ; id 82
    dfar AIScore_FireSlash ; id 83
    dfar AIScore_SlimeBlow ; id 84
    dfar AIScore_DrakSlash ; id 85
    dfar AIScore_BeastCut ; id 86
    dfar AIScore_BirdBlow ; id 87
    dfar AIScore_BugBlow ; id 88
    dfar AIScore_Shears ; id 89
    dfar AIScore_DevilCut ; id 90
    dfar AIScore_ZombieCut ; id 91
    dfar AIScore_CleanCut ; id 92
    dfar AIScore_AquaCut ; id 93
    dfar AIScore_MetalCut ; id 94
    dfar AIScore_PoisonHit ; id 95
    dfar AIScore_Paralyze ; id 96
    dfar AIScore_NapAttack ; id 97
    dfar AIScore_SquallHit ; id 98
    dfar AIScore_BiAttack ; id 99
    dfar AIScore_BiAttack ; id 100
    dfar AIScore_RainSlash ; id 101
    dfar AIScore_MultiCut ; id 102
    dfar AIScore_GigaSlash ; id 103
    dfar AIScore_ChargeUp ; id 104
    dfar AIScore_PsycheUp ; id 105
    dfar AIScore_HighJump ; id 106
    dfar AIScore_EvilSlash ; id 107
    dfar AIScore_Massacre ; id 108
    dfar AIScore_TwinSlash ; id 109
    dfar AIScore_Berserker ; id 110
    dfar AIScore_Ramming ; id 111
    dfar AIScore_Kamikaze ; id 112
    dfar AIScore_SleepAir ; id 113
    dfar AIScore_PalsyAir ; id 114
    dfar AIScore_PoisonGas ; id 115
    dfar AIScore_PoisonAir ; id 116
    dfar AIScore_Curse ; id 117
    dfar AIScore_OddDance ; id 118
    dfar AIScore_OddDance ; id 119
    dfar AIScore_PaniDance ; id 120
    dfar AIScore_KODance ; id 121
    dfar AIScore_LureDance ; id 122
    dfar AIScore_LifeDance ; id 123
    dfar AIScore_Hustle ; id 124
    dfar AIScore_SideStep ; id 125
    dfar AIScore_SandStorm ; id 126
    dfar AIScore_Radiant ; id 127
    dfar AIScore_EerieLite ; id 128
    dfar AIScore_Surge ; id 129
    dfar AIScore_UltraDown ; id 130
    dfar AIScore_DeMagic ; id 131
    dfar AIScore_ThickFog ; id 132
    dfar AIScore_TatsuCall ; id 133
    dfar AIScore_TatsuCall ; id 134
    dfar AIScore_TatsuCall ; id 135
    dfar AIScore_TatsuCall ; id 136
    dfar AIScore_SuckAir ; id 137
    dfar AIScore_Focus ; id 138
    dfar AIScore_LushLicks ; id 139
    dfar AIScore_SickLick ; id 140
    dfar AIScore_LegSweep ; id 141
    dfar AIScore_LegSweep ; id 142
    dfar AIScore_Ahhh ; id 143
    dfar AIScore_Ahhh ; id 144
    dfar AIScore_Geyser ; id 145
    dfar AIScore_DanceShut ; id 146
    dfar AIScore_MouthShut ; id 147
    dfar AIScore_StrongD ; id 148
    dfar AIScore_Dodge ; id 149
    dfar AIScore_BladeD ; id 150
    dfar AIScore_Cover ; id 151
    dfar AIScore_Cover ; id 152
    dfar AIScore_TailWind ; id 153
    dfar AIScore_StormWind ; id 154
    dfar AIScore_AquaWall ; id 155
    dfar AIScore_SealPray ; id 156
    dfar AIScore_SuckAll ; id 157
    dfar AIScore_Imitate ; id 158
    dfar AIScore_Meditate ; id 159
    dfar AIScore_LifeSong ; id 160
    dfar AIScore_LoveRain ; id 161
    dfar AIScore_Whistle ; id 162
    dfar AIScore_Whistle ; id 163
    dfar AIScore_Whistle ; id 164
    dfar AIScore_Whistle ; id 165
    dfar AIScore_Whistle ; id 166
    dfar AIScore_Whistle ; id 167
    dfar AIScore_Whistle ; id 168
    dfar AIScore_Whistle ; id 169
    dfar AIScore_Ahhh_6401 ; id 170
    dfar AIScore_ZoneOut ; id 171
    dfar AIScore_Guard ; id 172
    dfar AIScore_PanicAll_6473 ; id 173
    dfar AIScore_Ironize_648D ; id 174
    dfar AIScore_NoWeightA ; id 175
    dfar AIScore_NoWeightA ; id 176
    dfar AIScore_NoWeightA ; id 177
    dfar AIScore_Whistle ; id 178
    dfar AIScore_Whistle ; id 179
    dfar AIScore_NoWeightA ; id 180
    dfar AIScore_NoWeightA ; id 181
    dfar AIScore_Whistle ; id 182
    dfar AIScore_Whistle ; id 183
    dfar AIScore_NoWeightA ; id 184
    dfar AIScore_NoWeightA ; id 185
    dfar AIScore_Ahhh_6401 ; id 186
    dfar AIScore_ZoneOut ; id 187
    dfar AIScore_NoWeightA ; id 188
    dfar AIScore_NoWeightA ; id 189
    dfar AIScore_Ironize_648D ; id 190
    dfar AIScore_NoWeightA ; id 191
    dfar AIScore_NoWeightB ; id 192
    dfar AIScore_NoWeightB ; id 193
    dfar AIScore_NoWeightB ; id 194
    dfar AIScore_NoWeightB ; id 195
    dfar AIScore_NoWeightB ; id 196
    dfar AIScore_NoWeightB ; id 197
    dfar AIScore_NoWeightB ; id 198
    dfar AIScore_NoWeightB ; id 199
    dfar AIScore_Skill200 ; id 200

; UseAIScoreTableB stores this table's address in wBattleExpAward / +1 (the AI's routine-table
; pointer) and ScoreSkillForAI far-calls entry 3 * skill; all 131 entries point at named AIScore_*
; routines (E-0174, C1)
AIScoreRoutineTableB::
    dfar AIScore_Fight ; id 0
    dfar AIScore_Blaze ; id 1
    dfar AIScore_Blaze ; id 2
    dfar AIScore_Blaze ; id 3
    dfar AIScore_Firebal ; id 4
    dfar AIScore_Firebal ; id 5
    dfar AIScore_Firebal ; id 6
    dfar AIScore_Firebal ; id 7
    dfar AIScore_Firebal ; id 8
    dfar AIScore_Firebal ; id 9
    dfar AIScore_Firebal ; id 10
    dfar AIScore_Firebal ; id 11
    dfar AIScore_Firebal ; id 12
    dfar AIScore_Firebal ; id 13
    dfar AIScore_Firebal ; id 14
    dfar AIScore_Firebal ; id 15
    dfar AIScore_Firebal ; id 16
    dfar AIScore_Firebal ; id 17
    dfar AIScore_Firebal ; id 18
    dfar AIScore_Beat ; id 19
    dfar AIScore_Beat ; id 20
    dfar AIScore_Sacrifice ; id 21
    dfar AIScore_Heal ; id 22
    dfar AIScore_Heal ; id 23
    dfar AIScore_Heal ; id 24
    dfar AIScore_HealUs ; id 25
    dfar AIScore_HealUs ; id 26
    dfar AIScore_MPass ; id 27
    dfar AIScore_MPass ; id 28
    dfar AIScore_MPass ; id 29
    dfar AIScore_Vivify ; id 30
    dfar AIScore_Vivify ; id 31
    dfar AIScore_Farewell ; id 32
    dfar AIScore_Antidote ; id 33
    dfar AIScore_DeChaos ; id 34
    dfar AIScore_NumbOff ; id 35
    dfar AIScore_CurseOff ; id 36
    dfar AIScore_Upper ; id 37
    dfar AIScore_Upper ; id 38
    dfar AIScore_Sap ; id 39
    dfar AIScore_Sap ; id 40
    dfar AIScore_Speed ; id 41
    dfar AIScore_Speed ; id 42
    dfar AIScore_Slow ; id 43
    dfar AIScore_Slow ; id 44
    dfar AIScore_TwinHits ; id 45
    dfar AIScore_Surround ; id 46
    dfar AIScore_Sleep ; id 47
    dfar AIScore_Sleep ; id 48
    dfar AIScore_TakeMagic ; id 49
    dfar AIScore_RobMagic ; id 50
    dfar AIScore_StopSpell ; id 51
    dfar AIScore_PanicAll ; id 52
    dfar AIScore_Ironize ; id 53
    dfar AIScore_MagicBack ; id 54
    dfar AIScore_MagicBack ; id 55
    dfar AIScore_Barrier ; id 56
    dfar AIScore_MagicWall ; id 57
    dfar AIScore_Transform ; id 58
    dfar AIScore_BeDragon ; id 59
    dfar AIScore_Chance ; id 60
    dfar AIScore_MegaMagic ; id 61
    dfar AIScore_BigBang ; id 62
    dfar AIScore_BigBang ; id 63
    dfar AIScore_FireAir ; id 64
    dfar AIScore_FireAir ; id 65
    dfar AIScore_FireAir ; id 66
    dfar AIScore_FireAir ; id 67
    dfar AIScore_FireAir ; id 68
    dfar AIScore_FireAir ; id 69
    dfar AIScore_FireAir ; id 70
    dfar AIScore_FireAir ; id 71
    dfar AIScore_WindBeast ; id 72
    dfar AIScore_Vacuum ; id 73
    dfar AIScore_Vacuum ; id 74
    dfar AIScore_RockThrow ; id 75
    dfar AIScore_Watershot ; id 76
    dfar AIScore_Tidalwave ; id 77
    dfar AIScore_CallHelp ; id 78
    dfar AIScore_CallHelp ; id 79
    dfar AIScore_FireSlash ; id 80
    dfar AIScore_FireSlash ; id 81
    dfar AIScore_FireSlash ; id 82
    dfar AIScore_FireSlash ; id 83
    dfar AIScore_SlimeBlow ; id 84
    dfar AIScore_DrakSlash ; id 85
    dfar AIScore_BeastCut ; id 86
    dfar AIScore_BirdBlow ; id 87
    dfar AIScore_BugBlow ; id 88
    dfar AIScore_Shears ; id 89
    dfar AIScore_DevilCut ; id 90
    dfar AIScore_ZombieCut ; id 91
    dfar AIScore_CleanCut ; id 92
    dfar AIScore_AquaCut ; id 93
    dfar AIScore_MetalCut ; id 94
    dfar AIScore_PoisonHit ; id 95
    dfar AIScore_Paralyze ; id 96
    dfar AIScore_NapAttack ; id 97
    dfar AIScore_SquallHit ; id 98
    dfar AIScore_BiAttack ; id 99
    dfar AIScore_BiAttack ; id 100
    dfar AIScore_RainSlash ; id 101
    dfar AIScore_MultiCut ; id 102
    dfar AIScore_GigaSlash ; id 103
    dfar AIScore_ChargeUp ; id 104
    dfar AIScore_PsycheUp ; id 105
    dfar AIScore_HighJump ; id 106
    dfar AIScore_EvilSlash ; id 107
    dfar AIScore_Massacre ; id 108
    dfar AIScore_TwinSlash ; id 109
    dfar AIScore_Berserker ; id 110
    dfar AIScore_Ramming ; id 111
    dfar AIScore_Kamikaze ; id 112
    dfar AIScore_SleepAir ; id 113
    dfar AIScore_PalsyAir ; id 114
    dfar AIScore_PoisonGas ; id 115
    dfar AIScore_PoisonAir ; id 116
    dfar AIScore_Curse ; id 117
    dfar AIScore_OddDance ; id 118
    dfar AIScore_OddDance ; id 119
    dfar AIScore_PaniDance ; id 120
    dfar AIScore_KODance ; id 121
    dfar AIScore_LureDance ; id 122
    dfar AIScore_LifeDance ; id 123
    dfar AIScore_Hustle ; id 124
    dfar AIScore_SideStep ; id 125
    dfar AIScore_SandStorm ; id 126
    dfar AIScore_Radiant ; id 127
    dfar AIScore_EerieLite ; id 128
    dfar AIScore_Surge ; id 129
    dfar AIScore_UltraDown ; id 130
    dfar AIScore_DeMagic ; id 131
    dfar AIScore_ThickFog ; id 132
    dfar AIScore_TatsuCall ; id 133
    dfar AIScore_TatsuCall ; id 134
    dfar AIScore_TatsuCall ; id 135
    dfar AIScore_TatsuCall ; id 136
    dfar AIScore_SuckAir ; id 137
    dfar AIScore_Focus ; id 138
    dfar AIScore_LushLicks ; id 139
    dfar AIScore_SickLick ; id 140
    dfar AIScore_LegSweep ; id 141
    dfar AIScore_LegSweep ; id 142
    dfar AIScore_Ahhh ; id 143
    dfar AIScore_Ahhh ; id 144
    dfar AIScore_Geyser ; id 145
    dfar AIScore_DanceShut ; id 146
    dfar AIScore_MouthShut ; id 147
    dfar AIScore_StrongD ; id 148
    dfar AIScore_Dodge ; id 149
    dfar AIScore_BladeD ; id 150
    dfar AIScore_Cover ; id 151
    dfar AIScore_Cover ; id 152
    dfar AIScore_TailWind ; id 153
    dfar AIScore_StormWind ; id 154
    dfar AIScore_AquaWall ; id 155
    dfar AIScore_SealPray ; id 156
    dfar AIScore_SuckAll ; id 157
    dfar AIScore_Imitate ; id 158
    dfar AIScore_Meditate ; id 159
    dfar AIScore_LifeSong ; id 160
    dfar AIScore_LoveRain ; id 161
    dfar AIScore_Whistle ; id 162
    dfar AIScore_Whistle ; id 163
    dfar AIScore_Whistle ; id 164
    dfar AIScore_Whistle ; id 165
    dfar AIScore_Whistle ; id 166
    dfar AIScore_Whistle ; id 167
    dfar AIScore_Whistle ; id 168
    dfar AIScore_Whistle ; id 169
    dfar AIScore_Ahhh_6401 ; id 170
    dfar AIScore_ZoneOut ; id 171
    dfar AIScore_Guard ; id 172
    dfar AIScore_PanicAll_6473 ; id 173
    dfar AIScore_Ironize_648D ; id 174
    dfar AIScore_NoWeightA ; id 175
    dfar AIScore_NoWeightA ; id 176
    dfar AIScore_NoWeightA ; id 177
    dfar AIScore_Whistle ; id 178
    dfar AIScore_Whistle ; id 179
    dfar AIScore_NoWeightA ; id 180
    dfar AIScore_NoWeightA ; id 181
    dfar AIScore_Whistle ; id 182
    dfar AIScore_Whistle ; id 183
    dfar AIScore_NoWeightA ; id 184
    dfar AIScore_NoWeightA ; id 185
    dfar AIScore_Ahhh_6401 ; id 186
    dfar AIScore_ZoneOut ; id 187
    dfar AIScore_NoWeightA ; id 188
    dfar AIScore_NoWeightA ; id 189
    dfar AIScore_Ironize_648D ; id 190
    dfar AIScore_NoWeightA ; id 191
    dfar AIScore_NoWeightB ; id 192
    dfar AIScore_NoWeightB ; id 193
    dfar AIScore_NoWeightB ; id 194
    dfar AIScore_NoWeightB ; id 195
    dfar AIScore_NoWeightB ; id 196
    dfar AIScore_NoWeightB ; id 197
    dfar AIScore_NoWeightB ; id 198
    dfar AIScore_NoWeightB ; id 199
    dfar AIScore_Skill200 ; id 200

; HL = wBattleATK, then ReadBattleWordFromArray_Bank30 (E-0122)
ReadBattleATKOfSlot_Bank30::
    ld hl, wBattleATK
    jr ReadBattleWordFromArray_Bank30

; HL = wBattleDEF, then ReadBattleWordFromArray_Bank30 (E-0122)
ReadBattleDEFOfSlot_Bank30::
    ld hl, wBattleDEF
    jr ReadBattleWordFromArray_Bank30

; HL = wBattleMaxHP, then ReadBattleWordFromArray_Bank30 (E-0122)
ReadBattleMaxHPOfSlot_Bank30::
    ld hl, wBattleMaxHP
    jr ReadBattleWordFromArray_Bank30
    db $21, $ef, $d8, $18, $19

; HL = wBattleHP, then ReadBattleWordFromArray_Bank30 (E-0122)
ReadBattleHPOfSlot_Bank30::
    ld hl, wBattleHP
    jr ReadBattleWordFromArray_Bank30

GetBattleMP_Bank30::
    ld hl, wBattleMP
    jr ReadBattleWordFromArray_Bank30
    db $21, $1f, $d9, $18, $0a, $21, $53, $da, $85, $6f, $30, $01, $24, $7e, $c9

; the same 10 bytes as ReadBattleWordFromArray (ReadBattleWordFromArray)
ReadBattleWordFromArray_Bank30::
    add a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes
; appear in 12 banks)
AddDoubleAToHL_Bank30::
    add a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wLinkMode = 1 and wLinkRole bit 1 is set the
; test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the
; reversal, not checked (E-0064) (the same 27 bytes appear in 12 banks)
ActorOnLocalSide_Bank30::
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

; carry set when wBattleTarget < 4 (slots 0-3); when wLinkMode = 1 and wLinkRole bit 1 is set the
; test is reversed (carry set when wBattleTarget >= 4) (E-0064) (the same 27 bytes appear in 12
; banks)
TargetOnLocalSide_Bank30::
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

ClearBattleStatusBitsWithMaskD_Bank30::
    ld a, d
    ld hl, ClearBattleStatusBitsWithMaskD_Bank30_Data
    add_a_to_hl
    ld d, [hl]
    ld a, e
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, d
    and [hl]
    ld [hl], a
    ret

ClearBattleStatusBitsWithMaskD_Bank30_Data::
    db $df, $fe, $00, $fd, $73, $ef, $bf

; Sets bit 0 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit0OfLevelUpGainsIndexed_Bank30::
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; Sets bit 1 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit1OfLevelUpGainsIndexed_Bank30::
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; Sets bit 2 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit2OfLevelUpGainsIndexed_Bank30::
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 2, [hl]
    pop hl
    ret

; A = slot 0-7: returns A = 9 * g(wSlotPersonalityHi[A]) + 3 * g(wSlotPersonalityMid[A]) +
; g(wSlotPersonalityLo[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index
; PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes
; appear in 13 banks)
PersonalityIndexOfSlot_Bank30::
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

; A = slot: carry set when CheckSlotStatusBlock sets it, or when status byte 3 & $C0 or byte 4 & $0C
; is set (wBattleStatus3 + 9 * A); otherwise carry clear; A, BC, HL kept (E-0067) (the same 31 bytes
; appear in 12 banks)
CheckSlotStatusBlockWide_Bank30::
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

; A = slot: with HL = wBattleStatus3 + 9 * A (status byte 3 of wBattleStatus), A = byte 3 & $C0, or
; byte 4 & $0C when that is zero; Z set when both are clear; HL kept (E-0067) (the same 17 bytes
; appear in 13 banks)
SlotHasStatus3Or4Bits_Bank30::
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
    ds $2287, $00
