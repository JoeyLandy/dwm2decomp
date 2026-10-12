SECTION "Bank 30", ROMX[$4000], BANK[$30]
    db $30

; battle fight step 2: returns while a message is being drawn (wC52B); otherwise one of 7 sub-steps by wBattleSubPhase; case 0 loads the slots' personality bytes (wSlotPersonality*), the command menu loop follows
; 1 call site from 1 routine (e.g. BattleFight_Step2)
; reads: wTextFlags, wBattleSubPhase
RunBattleCommandEntry::
Func_030_4001:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wBattleSubPhase]
    rst $00
    dw RunBattleCommandEntry_WriteCommandByteE8
    dw RunBattleCommandEntry_CarryUnlessBattleSlotOutSlotEmpty
    dw RunBattleCommandEntry_ToRunCommandEntryResolveStep
    dw RunBattleCommandEntry_ChooseTargetForActor
    dw RunBattleCommandEntry_CarryUnlessBattleSlotOutSlotEmpty_Case04
    dw RunBattleCommandEntry_CompareHLToBC
    dw RunBattleCommandEntry_AddWordAtHLToBC_Bank30

; entry 0 of the `rst $00` table in RunBattleCommandEntry
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wBattlePartyCount
; writes: wCommandByteE8
; points at: wBattleSubPhase, wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo, wSlotTrait
RunBattleCommandEntry_WriteCommandByteE8::
Jump_030_4018:: ; address name
    ld hl, wBattleSubPhase
    inc [hl]
    ld a, [wLinkMode]
    or a, a
    ret nz
    xor a, a
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
    sub a, e
    ld a, h
    sbc a, d
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
    sub a, e
    ld a, h
    sbc a, d
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
    sub a, e
    ld a, h
    sbc a, d
    jr nc, .return
    ld a, $03
    ld [wCommandByteE8], a

.return:
    ret

; only called from RunBattleCommandEntry_Case00 (E-0047)
; 4 call sites from 1 routine (e.g. RunBattleCommandEntry_WriteCommandByteE8)
RunBattleCommandEntry_Case00_CarryUnlessBattleSlotOutSlotEmpty::
Func_030_408D:: ; address name
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, e
    add a, [hl]
    ld e, a
    ld a, d
    adc a, $00
    ld d, a

.next:
    inc hl
    inc c
    dec b
    jr nz, RunBattleCommandEntry_Case00_CarryUnlessBattleSlotOutSlotEmpty
    ret

; entry 1 of the `rst $00` table in RunBattleCommandEntry
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wBattleActor
; writes: wBattleActor, wBattleResolveStep
; points at: wSlotMarks, wBattleSubPhase
RunBattleCommandEntry_CarryUnlessBattleSlotOutSlotEmpty::
Jump_030_40A0:: ; address name
    ld a, [wLinkMode]
    or a, a
    call nz, NextTableByteSecondStream
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
    ld hl, wBattleSubPhase
    inc [hl]
    ld hl, wBattleSubPhase
    inc [hl]

.return:
    ret

; entry 2 of the `rst $00` table in RunBattleCommandEntry
; no direct call (reached through a table, a jump or a vector)
RunBattleCommandEntry_ToRunCommandEntryResolveStep::
Jump_030_40E3:: ; address name
    call RunCommandEntryResolveStep
    ret

; entry 3 of the `rst $00` table in RunBattleCommandEntry
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wBattleSubPhase
; points at: wSlotMarks, wBattleActor
RunBattleCommandEntry_ChooseTargetForActor::
Jump_030_40E7:: ; address name
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

; uses the preset target when the side is player-controlled, bit 7 of its wDAD8 byte is clear and wBattleTargetChoice is set; otherwise ChooseActionTarget; stores the result (E-0125)
; 5 call sites from 4 routines (e.g. RunBattleCommandEntry_ChooseTargetForActor, ActionEffect_Chance, RunBattleActions_CarryUnlessBattleSlotOutSlotEmpty, RunMultiHitCounter)
; reads: wLinkMode, wMenuState, wBattleActor
; points at: wSideControl, wBattleTargetChoice, wCommandBytesE9
ChooseTargetForActor::
Func_030_4102:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr z, .read_battle_actor
    cp a, $02
    jr z, .call_choose_action_target
    ld a, [wMenuState]
    jr .skip

.read_battle_actor:
    ld a, [wBattleActor]
    rrca
    rrca
    and a, $01
    ld hl, wCommandBytesE9
    add_a_to_hl
    ld a, [hl]

.skip:
    and a, $03
    cp a, $01
    jr nz, .call_choose_action_target
    ld a, [wBattleActor]
    ld hl, wSideControl
    add_a_to_hl
    bit 7, [hl]
    jr nz, .call_choose_action_target
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jp nz, .read_battle_actor2

.call_choose_action_target:
    farcall ChooseActionTarget
    jr .read_battle_actor3

.read_battle_actor2:
    ld d, a

.read_battle_actor3:
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld d, [hl]
    ret

; entry 4 of the `rst $00` table in RunBattleCommandEntry
; no direct call (reached through a table, a jump or a vector)
; reads: wLoadSlot
; writes: wActionQueuePos, wLoadSlot, wBattleTemp7A, wBattleTemp7B
; points at: wActionQueue, wBattleArg0, wBattleTemp7D, wSlotMarks, wBattleTemp7A, wLoadSlot, wBattleSubPhase
RunBattleCommandEntry_CarryUnlessBattleSlotOutSlotEmpty_Case04::
Jump_030_4160:: ; address name
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
    call RunBattleCommandEntry_Case04_AdvanceRandom
    call RunBattleCommandEntry_Case04_WriteRecordBufferAndBattleArg0Etc
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
    call RunBattleCommandEntry_Case04_WaitBattleFlag92
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; only called from RunBattleCommandEntry_Case04 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleCommandEntry_CarryUnlessBattleSlotOutSlotEmpty_Case04)
; points at: wBattleAGL
RunBattleCommandEntry_Case04_AdvanceRandom::
Func_030_41DF:: ; address name
    push de
    call AdvanceRandom
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

; only called from RunBattleCommandEntry_Case04 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleCommandEntry_CarryUnlessBattleSlotOutSlotEmpty_Case04)
; reads: wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3, wRecordBufferData, wRandomLo
; writes: wRecordBuffer, wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3
; points at: wBattleActionChoice
RunBattleCommandEntry_Case04_WriteRecordBufferAndBattleArg0Etc::
Func_030_4203:: ; address name
    push de
    ld a, e
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $62
    jr z, .skip
    cp a, $69
    jr z, .call_advance_random
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
    ld hl, $03E8
    jr .skip3

.call_advance_random:
    call AdvanceRandom
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

; only called from RunBattleCommandEntry_Case04 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleCommandEntry_CarryUnlessBattleSlotOutSlotEmpty_Case04)
; reads: wBattleFlag92, wLoadSlot
; points at: wBattleTemp7A, wBattleArg0
RunBattleCommandEntry_Case04_WaitBattleFlag92::
Func_030_4297:: ; address name
    ld a, [wBattleFlag92]
    cp a, $FF
    ret z
    ld bc, $07DA
    ld hl, wBattleTemp7A
    deref_hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wLoadSlot]
    ld hl, wBattleArg0
    add_a_to_hl
    ld [hl], $10
    ret

; entry 5 of the `rst $00` table in RunBattleCommandEntry
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTemp7A, wBattleTemp7B, wBattleDamageLo, wBattleDamageHi, wTargetEstimates, wActionQueuePos
; writes: wBattleTemp7A, wBattleTemp7B, wBattleDamageLo, wBattleDamageHi, wTargetEstimates, wActionQueuePos
; points at: wBattleTemp7D, wBattleTemp7F, wBattleArg0, wBattleTemp7A, wActionQueue, wBattleSubPhase
RunBattleCommandEntry_CompareHLToBC::
Jump_030_42B7:: ; address name
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

; entry 6 of the `rst $00` table in RunBattleCommandEntry
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleCommandArgs, wBattleSubPhase
; points at: wBattleHP, wBattleMaxHP, wBattleStep, wBattleResolveStep
RunBattleCommandEntry_AddWordAtHLToBC_Bank30::
Jump_030_434C:: ; address name
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
    xor a, a
    ld [wBattleSubPhase], a
    xor a, a
    ld hl, wBattleResolveStep
    ld bc, $0005
    call FillBytes
    farcall SaveActionChoicesAndPickFormations
    call RunBattleCommandEntry_Case06_CarryUnlessBattleSlotOutSlotEmpty
    ret

; BC += the word at [HL]; HL += 2; clobbers A (the same 7 bytes appear in 2 banks)
; 6 call sites from 1 routine (e.g. RunBattleCommandEntry_AddWordAtHLToBC_Bank30)
AddWordAtHLToBC_Bank30::
Func_030_4396:: ; address name
    ld a, [hl+]
    add a, c
    ld c, a
    ld a, [hl+]
    adc a, b
    ld b, a
    ret

; only called from RunBattleCommandEntry_Case06 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleCommandEntry_AddWordAtHLToBC_Bank30)
; points at: wBattleActionChoice, wBattleStatus6
RunBattleCommandEntry_Case06_CarryUnlessBattleSlotOutSlotEmpty::
Func_030_439D:: ; address name
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

; runs the routine for wBattleResolveStep (jump table of four) (E-0122)
; 2 call sites from 2 routines (e.g. RunBattleCommandEntry_ToRunCommandEntryResolveStep, RunBattleCommandEntry_BankA1_ToRunCommandEntryResolveStep)
; reads: wBattleResolveStep
RunCommandEntryResolveStep::
Func_030_43C4:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw RunCommandEntryResolveStep_PersonalityIndexOfSlot_Bank30
    dw RunCommandEntryResolveStep_AddAx9ToHL
    dw AIChooseActionResolveStep
    dw RunCommandEntryResolveStep_RunActorActionHandlersForAISlots

; entry 0 of the `rst $00` table in RunCommandEntryResolveStep
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wLinkMode, wMenuState, wCommandBytesE9
; writes: wPersonalityIndex
; points at: wCommandBytesE9, wBattleResolveStep
RunCommandEntryResolveStep_PersonalityIndexOfSlot_Bank30::
Jump_030_43D0:: ; address name
    ld a, [wBattleActor]
    call PersonalityIndexOfSlot_Bank30
    ld [wPersonalityIndex], a
    call ForcedActionForActorStatus
    jr nz, .skip2
    ld a, [wLinkMode]
    or a, a
    jr z, .check_menu_state
    cp a, $02
    jr z, .check_battle_actor
    ld a, [wBattleActor]
    rrca
    rrca
    and a, $01
    ld hl, wCommandBytesE9
    add_a_to_hl
    ld a, [hl]
    jr .skip

.check_battle_actor:
    ld a, [wBattleActor]
    cp a, $01
    jr z, .read_command_bytes_e9
    ld a, [wMenuState]
    jr .skip

.read_command_bytes_e9:
    ld a, [wCommandBytesE9]
    jr .skip

.check_menu_state:
    ld a, [wMenuState]

.skip:
    and a, $03
    cp a, $01
    jr z, .done

.skip2:
    ld hl, wBattleResolveStep
    inc [hl]

.done:
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunCommandEntryResolveStep
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wBattleActor, wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3
; writes: wBattleStatResultLo, wBattleResolveStep
; points at: wBattleResolveStep, wBattleArg0, wBattleStatus, wResolveBytesE0, wBattleActionChoice, wSideControl
RunCommandEntryResolveStep_AddAx9ToHL::
Jump_030_441D:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleStatResultLo], a
    ld a, [wLinkMode]
    or a, a
    jr z, .check_battle_actor
    cp a, $02
    jr z, .check_battle_actor
    jr .set_battle_stat_result_lo_to_01

.check_battle_actor:
    ld a, [wBattleActor]
    cp a, $04
    jr nc, .call_get_actor_slot_tactic_low2

.set_battle_stat_result_lo_to_01:
    ld a, $01
    ld [wBattleStatResultLo], a
    ld hl, wBattleArg0
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 6, [hl]
    jr nz, .call_get_actor_slot_tactic_low2
    call ActorBattleWordArray3FBand
    or a, a
    jr z, .call_get_actor_slot_tactic_low2
    cp a, $01
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
    ld a, $FF
    ld [hl+], a
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
    and a, $03
    cp a, $03
    jr z, .return
    ld d, $28
    farcall ShowBattleTextCategory0

.return:
    ret

; A = 0 when the actor's wD93F word is below $33, 2 when below $3B6, otherwise 3 (E-0122)
; 1 call site from 1 routine (e.g. RunCommandEntryResolveStep_AddAx9ToHL)
; reads: wBattleActor
; points at: wBattleWordArray3F
ActorBattleWordArray3FBand::
Func_030_44E0:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleWordArray3F
    add a, a
    add_a_to_hl
    deref_hl
    ld bc, $0033
    call CompareHLToBC
    ld a, $00
    jr c, .return
    ld bc, $03B6
    call CompareHLToBC
    ld a, $02
    jr c, .return
    ld a, $03

.return:
    ret

; only called from RunCommandEntryResolveStep_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunCommandEntryResolveStep_AddAx9ToHL)
; reads: wBattleActor
; points at: wSlotTrait, wBattleArg0
RunCommandEntryResolveStep_Case01_ReadBattleActor::
Func_030_4506:: ; address name
    ld hl, wSlotTrait
    jr RunCommandEntryResolveStep_Case01_GetActorSlotTacticLow2_Data_ReadBattleActor

; only called from RunCommandEntryResolveStep_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunCommandEntryResolveStep_AddAx9ToHL)
; reads: wBattleActor
; points at: wBattleArg0
RunCommandEntryResolveStep_Case01_GetActorSlotTacticLow2::
Func_030_450B:: ; address name
    call GetActorSlotTacticLow2
    cp a, $03
    ret z
    ld hl, RunCommandEntryResolveStep_Case01_GetActorSlotTacticLow2_Data
    call ReadBattleWordFromArray_Bank30
    jr RunCommandEntryResolveStep_Case01_GetActorSlotTacticLow2_Data_ReadBattleActor

; address loaded by RunCommandEntryResolveStep_Case01_GetActorSlotTacticLow2
RunCommandEntryResolveStep_Case01_GetActorSlotTacticLow2_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_030_4519:: ; address name
    db $68, $D9, $70, $D9, $78, $D9

RunCommandEntryResolveStep_Case01_GetActorSlotTacticLow2_Data_ReadBattleActor::
Jump_030_451F:: ; address name
    ld a, [wBattleActor]
    add_a_to_hl
    ld a, [hl]
    srl a
    srl a
    ld hl, wBattleArg0
    add a, [hl]
    ld [hl+], a
    ld a, $00
    adc a, [hl]
    ld [hl], a
    ret

; the word wD868 += Data_030_5587[wPersonalityIndex * 4 + (wDA43[actor] & 3)] (E-0120)
; 1 call site from 1 routine (e.g. RunCommandEntryResolveStep_AddAx9ToHL)
; reads: wPersonalityIndex
; points at: wBattleArg0
AddPersonalityWeightToBattleArg0::
Func_030_4536:: ; address name
    ld a, [wPersonalityIndex]
    add a, a
    add a, a
    ld hl, PersonalityTacticWeights
    add_a_to_hl
    push hl
    call GetActorSlotTacticLow2
    pop hl
    add_a_to_hl
    ld a, [hl]
    ld hl, wBattleArg0
    add a, [hl]
    ld [hl+], a
    ld a, $00
    adc a, [hl]
    ld [hl], a
    ret

; adds the actor's wD93F word / 16 to the word wD86A (E-0122)
; 1 call site from 1 routine (e.g. RunCommandEntryResolveStep_AddAx9ToHL)
; reads: wBattleActor, wBattleArg2, wBattleArg3
; writes: wBattleArg2, wBattleArg3
; points at: wBattleWordArray3F
AddActorBattleWordArray3FDiv16ToBattleArg2::
Func_030_4558:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleWordArray3F
    add a, a
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

; adds a random value 0-63 (wC5E7 & $3F) to the word wD86A (E-0122)
; 1 call site from 1 routine (e.g. RunCommandEntryResolveStep_AddAx9ToHL)
; reads: wRandomLo, wBattleArg2, wBattleArg3
; writes: wBattleArg2, wBattleArg3
AddRandom0To63ToBattleArg2::
Func_030_4579:: ; address name
    call AdvanceRandom
    ld a, [wRandomLo]
    and a, $3F
    ld l, a
    ld h, $00
    jr AddRandom0To63ToBattleArg2_ReadBattleArg2

AddRandom0To63ToBattleArg2_ReadBattleArg2::
Jump_030_4586:: ; address name
    ld a, [wBattleArg2]
    add a, l
    ld [wBattleArg2], a
    ld a, [wBattleArg3]
    adc a, h
    ld [wBattleArg3], a
    ret

; when the actor has no forced action and bit 7 of its wDAD8 byte is set, initialises the AI weights and runs the routine for its AI mode; a forced action is stored directly; then wBattleResolveStep += 1 (E-0124)
; 2 call sites from 1 routine (e.g. RunDebugState_E0_ChooseActionTargets_Case01_WriteRandomLoAndRandomHiEtc)
; reads: wBattleActor
; writes: wAIFlag
; points at: wSideControl, wSlotAIMode, wBattleResolveStep
AIChooseActionResolveStep::
Func_030_4595:: ; address name
    call ForcedActionForActorStatus
    jr nz, .call_actor_action_choice_address
    ld a, [wBattleActor]
    ld hl, wSideControl
    add_a_to_hl
    bit 7, [hl]
    jr z, .done
    call InitAIWeightsForActor
    xor a, a
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

; E-0181 (C1: AIChooseActionResolveStep and AIChooseActionForActor read the word at $45D0 + 2 * AI mode and call it: mode 0 AIRunNextChoice, modes 1-3 ScoreActionsWithAIScoreTableA, mode 4 UseAIScoreTableB).
; record: routine run for this AI mode (wSlotAIMode)
AIModeRoutineTable::
Data_030_45D0:: ; address name
    dw AIRunNextChoice ; id 0
    dw ScoreActionsWithAIScoreTableA ; id 1
    dw ScoreActionsWithAIScoreTableA ; id 2
    dw ScoreActionsWithAIScoreTableA ; id 3
    dw UseAIScoreTableB ; id 4

; clears wD2AD ($14 bytes), sets wDA3C-wDA42 = 0, 0, 0, 1, 2, 3, 3, then adds personality, HP and other weights (Func_030_4617, 46BA, 47B9, 483F); wD871 = 0 (E-0124)
; 1 call site from 1 routine (e.g. AIChooseActionResolveStep)
; writes: wAIChoiceWeights, wAIChoiceOrder, wAIChoiceIndex, wLoadSlot
; points at: wAIWeights
InitAIWeightsForActor::
Func_030_45DA:: ; address name
    ld hl, wAIWeights
    ld bc, $0014
    xor a, a
    call FillBytes
    xor a, a
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

; for player-side actors: with battle command 1 adds $2D to wDA3C[actor's wDA43 mode] (unless 3), otherwise $14 to wDA3C[wDA4B & 3] (E-0127)
; 2 call sites from 2 routines (e.g. InitAIWeightsForActor, AIChooseActionForActor_AddCommandWeightToAIChoiceWeights)
; reads: wLinkMode, wBattleActor, wMenuState, wCommandBytesE9
; points at: wAIChoiceWeights, wSlotLastTactic, wCommandBytesE9
AddCommandWeightToAIChoiceWeights::
Func_030_4617:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, .check_battle_actor
    cp a, $02
    jr nz, .read_battle_actor
    ld a, [wBattleActor]
    cp a, $04
    jr nc, .return
    cp a, $00
    ld a, [wMenuState]
    jr z, .skip
    ld a, [wCommandBytesE9]
    jr .skip

.read_battle_actor:
    ld a, [wBattleActor]
    rrca
    rrca
    and a, $01
    ld hl, wCommandBytesE9
    add_a_to_hl
    ld a, [hl]
    jr .skip

.check_battle_actor:
    ld a, [wBattleActor]
    cp a, $04
    jr nc, .return
    ld a, [wMenuState]

.skip:
    and a, $03
    cp a, $01
    jr nz, .read_battle_actor2
    call GetActorSlotTacticLow2
    cp a, $03
    jr z, .return
    ld hl, wAIChoiceWeights
    add_a_to_hl
    ld e, $2D
    call AddSignedEToByteAtHLClamped
    jr .return

.read_battle_actor2:
    ld a, [wBattleActor]
    ld hl, wSlotLastTactic
    add_a_to_hl
    ld a, [hl]
    and a, $03
    ld hl, wAIChoiceWeights
    add_a_to_hl
    ld e, $14
    call AddSignedEToByteAtHLClamped

.return:
    ret

; for the actor's three personality bytes (Hi, Mid, Lo) adds value / 10 to wDA3C + 0, 1, 2 (Func_030_5428) (E-0122)
; 2 call sites from 2 routines (e.g. InitAIWeightsForActor, AIChooseActionForActor_AddCommandWeightToAIChoiceWeights)
; reads: wBattleActor
; points at: wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo, wAIChoiceWeights
AddActorPersonalityTensToAIChoiceWeights::
Func_030_4688:: ; address name
    ld hl, wSlotPersonalityHi
    ld a, $00
    call AddActorPersonalityTensForIndexA
    ld hl, wSlotPersonalityMid
    ld a, $01
    call AddActorPersonalityTensForIndexA
    ld hl, wSlotPersonalityLo
    ld a, $02

; B = [HL + actor] / 10, then Func_030_5428 on wDA3C + A with E = B (E-0122)
; 2 call sites from 1 routine (e.g. AddActorPersonalityTensToAIChoiceWeights)
; reads: wBattleActor
; points at: wAIChoiceWeights
AddActorPersonalityTensForIndexA::
Func_030_469D:: ; address name
    push af
    ld a, [wBattleActor]
    add_a_to_hl
    ld b, [hl]
    ld a, $0A
    call DivideBByA
    pop af
    ld hl, wAIChoiceWeights
    add_a_to_hl
    ld e, b
    call AddSignedEToByteAtHLClamped
    ret

; adds AI weights for the actor's status (wD80D bits) and command mode, and for allies below a sixth of max HP in AI modes 3 and 4 (E-0130)
; 2 call sites from 2 routines (e.g. InitAIWeightsForActor, AIChooseActionForActor_AddCommandWeightToAIChoiceWeights)
; reads: wBattleActor, wLinkMode, wMenuState, wCommandBytesE9, wBattleTurn
; points at: wBattleStatus1, wAIChoiceWeights, wSlotAIMode, wBattleSkills, wCommandBytesE9
AddStatusAndHPWeightsToAI::
Func_030_46BA:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    ld a, [hl+]
    and a, $08
    jr nz, .check_link_mode
    inc hl
    inc hl
    ld a, [hl]
    and a, $33
    jr z, .call_any_ally_hp_below_sixth_of_max

.check_link_mode:
    ld a, [wLinkMode]
    or a, a
    jr z, .check_menu_state
    cp a, $02
    jr nz, .read_battle_actor
    ld a, [wBattleActor]
    cp a, $00
    ld a, [wMenuState]
    jr z, .skip
    ld a, [wCommandBytesE9]
    jr .skip

.read_battle_actor:
    ld a, [wBattleActor]
    rrca
    rrca
    and a, $01
    ld hl, wCommandBytesE9
    add_a_to_hl
    ld a, [hl]
    jr .skip

.check_menu_state:
    ld a, [wMenuState]

.skip:
    and a, $03
    cp a, $01
    jr z, .call_any_ally_hp_below_sixth_of_max
    ld hl, wAIChoiceWeights
    ld e, $1E
    call AddSignedEToByteAtHLClamped

.call_any_ally_hp_below_sixth_of_max:
    call AnyAllyHPBelowSixthOfMax
    jr z, .check_battle_turn
    ld a, [wBattleActor]
    ld hl, wSlotAIMode
    add_a_to_hl
    ld a, [hl]
    cp a, $04
    jr z, .read_battle_actor2
    cp a, $03
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
    cp a, $FF
    jr z, .check_battle_turn
    cp a, $16
    jr c, .next
    cp a, $21
    jr c, .call_get_actor_slot_tactic_low2
    cp a, $7B
    jr z, .call_get_actor_slot_tactic_low2
    cp a, $7C
    jr z, .call_get_actor_slot_tactic_low2
    cp a, $9F
    jr c, .next
    cp a, $A2
    jr c, .call_get_actor_slot_tactic_low2

.next:
    inc hl
    inc hl
    dec b
    jr nz, .loop
    jr .check_battle_turn

.call_get_actor_slot_tactic_low2:
    call GetActorSlotTacticLow2
    cp a, $03
    jr z, .check_battle_turn
    ld hl, wAIChoiceWeights + $2
    ld e, $1E
    call AddSignedEToByteAtHLClamped

.check_battle_turn:
    ld a, [wBattleTurn]
    or a, a
    jr nz, .return
    ld a, [wBattleActor]
    cp a, $04
    jr nc, .return
    ld a, [wLinkMode]
    or a, a
    jr nz, .return
    ld a, [wMenuState]
    and a, $01
    jr nz, .return
    ld hl, wAIChoiceWeights + $2
    ld e, $E2
    call AddSignedEToByteAtHLClamped

.return:
    ret

; A = 1 and NZ when an occupied ally has HP below a sixth of its max; otherwise returns with the last comparison flags (E-0124)
; 1 call site from 1 routine (e.g. AddStatusAndHPWeightsToAI)
; reads: wBattleActor
AnyAllyHPBelowSixthOfMax::
Func_030_478B:: ; address name
    ld a, [wBattleActor]
    and a, $04
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
    or a, a
    ret

; for player-controlled slots adds random 0-15 to wDA3C-wDA3E; for AI slots adds weights by personality band (AddRandomWeightByValueBand) (E-0125)
; 2 call sites from 2 routines (e.g. InitAIWeightsForActor, AIChooseActionForActor_AddCommandWeightToAIChoiceWeights)
; reads: wLinkMode, wBattleActor, wRandomLo
; points at: wAIChoiceWeights, wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo
AddRandomPersonalityWeights::
Func_030_47B9:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, .check_battle_actor
    cp a, $02
    jr nz, .loop
    ld a, [wBattleActor]
    cp a, $04
    jr c, .check_battle_actor

.loop:
    call GetActorSlotTacticLow2
    cp a, $03
    ret z
    ld hl, wAIChoiceWeights
    ld b, $03

.loop2:
    call AdvanceRandom
    ld a, [wRandomLo]
    and a, $0F
    ld e, a
    call AddSignedEToByteAtHLClamped
    inc hl
    dec b
    jr nz, .loop2
    ret

.check_battle_actor:
    ld a, [wBattleActor]
    cp a, $04
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

; adds RandomInRange(0, 30/25/20/15/10) to [DE] (Func_030_5428), the bound chosen by [HL + A] (< 50, 100, 150, 200, or more) (E-0124)
; 2 call sites from 1 routine (e.g. AddRandomPersonalityWeights)
AddRandomWeightByValueBand::
Func_030_480E:: ; address name
    push de
    add_a_to_hl
    ld a, [hl]
    ld bc, $001E
    cp a, $32
    jr c, .call_random_in_range
    ld bc, $0019
    cp a, $64
    jr c, .call_random_in_range
    ld bc, $0014
    cp a, $96
    jr c, .call_random_in_range
    ld bc, $000F
    cp a, $C8
    jr c, .call_random_in_range
    ld bc, $000A

.call_random_in_range:
    ld hl, $0000
    call RandomInRange
    pop hl
    call AddSignedEToByteAtHLClamped
    ret

; sorts wDA3C-wDA3E in descending order (ties broken by the random bits in wC5E7/8), swapping the matching wDA3F-wDA41 entries (E-0128)
; 2 call sites from 2 routines (e.g. InitAIWeightsForActor, AIChooseActionForActor_AddCommandWeightToAIChoiceWeights)
; reads: wRandomLo, wRandomHi, wAIChoiceOrder, wAIChoiceWeights, wBattleActor
; writes: wAIChoiceOrder
; points at: wAIChoiceWeights, wBattleSkillsPrefix, wAIWeights
SortThreeAIWeightsRandomTies::
Func_030_483F:: ; address name
    ld a, [wRandomLo]
    ld c, a
    ld a, [wRandomHi]
    ld b, a
    ld hl, wAIChoiceWeights
    ld a, [hl+]
    cp a, [hl]
    ccf
    jr c, .skip2
    jr nz, .skip
    bit 0, b
    jr nz, .skip2

.skip:
    push af
    ld a, [hl-]
    ld [hl+], a
    pop af
    ld [hl], a
    ld a, [wAIChoiceOrder]
    push af
    ld a, [wAIChoiceOrder + $1]
    ld [wAIChoiceOrder], a
    pop af
    ld [wAIChoiceOrder + $1], a

.skip2:
    ld a, [hl+]
    cp a, [hl]
    ccf
    jr c, .check_ai_choice_weights
    jr nz, .skip3
    bit 0, c
    jr nz, .check_ai_choice_weights

.skip3:
    push af
    ld a, [hl-]
    ld [hl+], a
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
    cp a, [hl]
    ccf
    jr c, .read_ai_choice_order
    jr nz, .skip4
    bit 1, b
    jr nz, .read_ai_choice_order

.skip4:
    push af
    ld a, [hl-]
    ld [hl+], a
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

; for each of the actor's skills equal to D adds weight through Func_030_48F3 to wD2AD[index]; for D other than 2 also to wD2BD[D - 1] (E-0125)
; 1 call site from 1 routine (e.g. SortThreeAIWeightsRandomTies)
; reads: wBattleActor
; points at: wBattleSkillsPrefix, wAIWeights
AddWeightsForSkillD::
Func_030_48B6:: ; address name
    ld bc, $0800
    ld hl, wBattleSkillsPrefix
    ld a, [wBattleActor]
    swap a
    add a, l
    ld l, a
    jr nc, .loop
    inc h

.loop:
    push bc
    ld a, [hl]
    cp a, d
    jr nz, .restore
    push hl
    ld a, c
    ld hl, wAIWeights
    add a, a
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
    cp a, $02
    jr z, .return
    dec a
    ld hl, wAIWeights + $10
    add_a_to_hl
    call AddWeightsForSkillD_ReadLinkModeAndBattleActorEtc

.return:
    ret

; only called from AddWeightsForSkillD (E-0047)
; 2 call sites from 1 routine (e.g. AddWeightsForSkillD)
; reads: wLinkMode, wBattleActor, wMenuState, wCommandBytesE9
; points at: wCommandBytesE9
AddWeightsForSkillD_ReadLinkModeAndBattleActorEtc::
Func_030_48F3:: ; address name
    push de
    push hl
    ld a, [wLinkMode]
    or a, a
    jr z, .check_menu_state
    cp a, $01
    jr z, .read_battle_actor
    ld a, [wBattleActor]
    cp a, $00
    ld a, [wMenuState]
    jr z, .skip
    ld a, [wCommandBytesE9]
    jr .skip

.read_battle_actor:
    ld a, [wBattleActor]
    rrca
    rrca
    and a, $01
    ld hl, wCommandBytesE9
    add_a_to_hl
    ld a, [hl]
    jr .skip

.check_menu_state:
    ld a, [wMenuState]

.skip:
    and a, $03
    cp a, $01
    jr z, .call_get_actor_slot_tactic_low2
    and a, $01
    jr z, .skip2
    jr .restore

.call_get_actor_slot_tactic_low2:
    call GetActorSlotTacticLow2
    cp a, $03
    jr z, .skip2
    sla e
    jr .restore

.skip2:
    ld e, $00

.restore:
    pop hl
    ld a, e
    add a, [hl]
    ld [hl+], a
    ld a, $00
    adc a, [hl]
    ld [hl], a
    pop de
    ret

; for player-controlled actors in manual mode chooses action 0; otherwise runs the AI routine for the next wDA3C entry (Data_030_4998) and advances wDA42 (E-0125)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wLinkMode, wAIChoiceIndex, wLoadSlot
; points at: wAIChoiceWeights, wAIChoiceIndex
AIRunNextChoice:: ; code pointer of the table AIModeRoutineTable; C0
Func_030_4946:: ; address name
    ld a, [wBattleActor]
    and a, $03
    cp a, $03
    jr z, .check_ai_choice_index
    ld a, [wLinkMode]
    or a, a
    jr z, .check_battle_actor
    cp a, $02
    jr nz, .call_get_actor_slot_tactic_low2

.check_battle_actor:
    ld a, [wBattleActor]
    cp a, $04
    jr nc, .check_ai_choice_index

.call_get_actor_slot_tactic_low2:
    call GetActorSlotTacticLow2
    cp a, $03
    jr nz, .check_ai_choice_index

.loop:
    ld b, $00
    call ActorActionChoiceAddress
    ld [hl], b
    ret

.check_ai_choice_index:
    ld a, [wAIChoiceIndex]
    cp a, $06
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
    cp a, $FF
    ret z
    ld hl, wAIChoiceIndex
    inc [hl]
    jr AIRunNextChoice

; E-0181 (C1: AIRunNextChoice reads the word at $4998 + 2 * (wAIChoiceWeights[wAIChoiceIndex] - 1) and calls it (JumpToHL); three words, and the three routines follow directly).
; record: AI choice routine for this wAIChoiceWeights value
AIChoiceRoutineTable::
Data_030_4998:: ; address name
    dw AIPickRandomActionOfKind1 ; id 1
    dw AIPickRandomSkillOfKind2 ; id 2
    dw AIPickRandomSkillOfKind3 ; id 3

; lists action 0 plus every skill of the actor whose kind byte (the byte before it in wBattleSkills, wBattleSkillsPrefix + 16 * slot) is 1, picks one at random as the actor's action choice and sets wLoadSlot = $FF (choice weight 1 of AIChoiceRoutineTable) (E-0181)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wRandomLo
; writes: wBattleArg0, wLoadSlot
; points at: wBattleArg0, wBattleSkillsPrefix, wBattleArg1
AIPickRandomActionOfKind1:: ; code pointer of the table AIChoiceRoutineTable; C0
Func_030_499E:: ; address name
    ld hl, wBattleArg0
    ld bc, $0009
    ld a, $FF
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
    or a, a
    jr z, .call_advance_random
    cp a, $01
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
    add a, $01
    call DivideBByA
    ld hl, wBattleArg0
    add_a_to_hl
    ld a, [hl]
    push af
    call ActorActionChoiceAddress
    pop af
    ld [hl], a
    ld a, $FF
    ld [wLoadSlot], a
    ret

; lists the actor's skills of kind 2 (as AIPickRandomActionOfKind1, without action 0) and picks one at random as the action choice; returns when there is none (choice weight 2) (E-0181)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wRandomLo
; writes: wLoadSlot
; points at: wBattleArg0, wBattleSkillsPrefix
AIPickRandomSkillOfKind2:: ; code pointer of the table AIChoiceRoutineTable; C0
Func_030_49FD:: ; address name
    ld hl, wBattleArg0
    ld bc, $0008
    ld a, $FF
    call FillBytes
    ld a, [wBattleActor]
    swap a
    ld hl, wBattleSkillsPrefix
    add_a_to_hl
    ld b, $08
    ld c, $00

.loop:
    ld a, [hl]
    or a, a
    jr z, .skip
    cp a, $02
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
    or a, a
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
    ld a, $FF
    ld [wLoadSlot], a
    ret

; lists the actor's skills of kind 3, adds skill $AC when Func_030_540C returns 2, and picks one at random as the action choice; returns when there is none (choice weight 3) (E-0181)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wRandomLo
; writes: wLoadSlot
; points at: wBattleArg0, wBattleSkillsPrefix
AIPickRandomSkillOfKind3:: ; code pointer of the table AIChoiceRoutineTable; C0
Func_030_4A58:: ; address name
    ld hl, wBattleArg0
    ld bc, $0009
    ld a, $FF
    call FillBytes
    ld a, [wBattleActor]
    swap a
    ld hl, wBattleSkillsPrefix
    add_a_to_hl
    ld b, $08
    ld c, $00

.loop:
    ld a, [hl]
    or a, a
    jr z, .call_get_actor_slot_tactic_low2
    cp a, $03
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
    cp a, $02
    jr nz, .skip
    ld a, c
    ld hl, wBattleArg0
    add_a_to_hl
    ld [hl], $AC
    inc c

.skip:
    ld a, c
    or a, a
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
    ld a, $FF
    ld [wLoadSlot], a
    ret

; wDA6B/wDA6C = AIScoreRoutineTableB, then continues with the scoring loop (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wLinkMode, wAIChoiceOrder
; writes: wBattleExpAward
; points at: wBattleSkillsPrefix, wAIWeights
UseAIScoreTableB:: ; code pointer of the table AIModeRoutineTable; C0
Func_030_4AC6:: ; address name
    ld hl, AIScoreRoutineTableB
    ld a, l
    ld [wBattleExpAward], a
    ld a, h
    ld [wBattleExpAward + $1], a
    jr ScoreActionsWithAIScoreTableA_CheckBattleActor

; sets wDA6B/C to AIScoreRoutineTableA; for AI-controlled actors estimates damage, scores the eight skills, attack (0) and $AC into wD2AD, and doubles the weight of the preferred kind (E-0129)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wLinkMode, wAIChoiceOrder
; writes: wBattleExpAward
; points at: wBattleSkillsPrefix, wAIWeights
ScoreActionsWithAIScoreTableA:: ; code pointer of the table AIModeRoutineTable; C0
Func_030_4AD3:: ; address name
    ld hl, AIScoreRoutineTableA
    ld a, l
    ld [wBattleExpAward], a
    ld a, h
    ld [wBattleExpAward + $1], a

ScoreActionsWithAIScoreTableA_CheckBattleActor::
Jump_030_4ADE:: ; address name
    ld a, [wBattleActor]
    and a, $03
    cp a, $03
    jr z, .call_estimate_damage_vs_each_foe_to_ai_damage
    ld a, [wLinkMode]
    or a, a
    jr z, .check_battle_actor
    cp a, $02
    jr nz, .call_get_actor_slot_tactic_low2

.check_battle_actor:
    ld a, [wBattleActor]
    cp a, $04
    jr nc, .call_estimate_damage_vs_each_foe_to_ai_damage

.call_get_actor_slot_tactic_low2:
    call GetActorSlotTacticLow2
    cp a, $03
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
    cp a, [hl]
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
    cp a, $01
    call z, DoubleWordAtDEUnlessBit15
    inc de
    inc de
    ld a, $AC
    push de
    call ScoreSkillForAI
    pop de
    ld a, [wBattleActor]
    and a, $03
    cp a, $03
    jr z, .call_quarter_word_at_de_unless_bit15
    ld a, [wLinkMode]
    or a, a
    jr z, .check_battle_actor2
    cp a, $02
    jr nz, .check_ai_choice_order

.check_battle_actor2:
    ld a, [wBattleActor]
    cp a, $04
    jr nc, .call_quarter_word_at_de_unless_bit15

.check_ai_choice_order:
    ld a, [wAIChoiceOrder]
    cp a, $03
    call z, DoubleWordAtDEUnlessBit15
    jr .call_choose_highest_weighted_action

.call_quarter_word_at_de_unless_bit15:
    call QuarterWordAtDEUnlessBit15

.call_choose_highest_weighted_action:
    call ChooseHighestWeightedAction
    ret

; doubles the word at DE unless its bit 15 is already set (E-0122)
; 3 call sites from 1 routine (e.g. ScoreActionsWithAIScoreTableA)
DoubleWordAtDEUnlessBit15::
Func_030_4B76:: ; address name
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
; 1 call site from 1 routine (e.g. ScoreActionsWithAIScoreTableA)
QuarterWordAtDEUnlessBit15::
Func_030_4B88:: ; address name
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
; 1 call site from 1 routine (e.g. ScoreActionsWithAIScoreTableA)
; reads: wRecordBufferData, wBattleExpAward, wAISkillScore, wAISkillScore2
; writes: wAISkillScore, wAISkillScore2
ScoreSkillAtHLForAI::
Func_030_4B9F:: ; address name
    ld a, [hl]

; A = skill number ($FF skips): AddSkillBaseWeightAndLoadSkill; when wCFF1 bit 0 (in the skill record) is set, clears wDA6E-wDA71 and far-calls the skill's AI scoring routine from the table in wDA6B/wDA6C (AIScoreRoutineTableA or B), then folds the accumulated weights into the word at DE (the rest is not fully read) (E-0083)
; 2 call sites from 1 routine (e.g. ScoreActionsWithAIScoreTableA)
; reads: wRecordBufferData, wBattleExpAward, wAISkillScore, wAISkillScore2
; writes: wAISkillScore, wAISkillScore2
ScoreSkillForAI::
Func_030_4BA0:: ; address name
    push de
    cp a, $FF
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
    ld a, [hl+]
    ld b, [hl]
    ld h, a
    ld l, e
    xor a, a
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
    and a, l
    cp a, $FF
    jr z, .restore
    ld a, c
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    pop hl
    ld a, [hl]
    add a, c
    ld [hl+], a
    ld a, [hl]
    adc a, b
    ld [hl], a
    bit 7, a
    jr z, .return
    dec hl
    push hl

.restore:
    pop hl
    ld a, $FF
    ld [hl+], a
    ld [hl], a

.return:
    ret

; picks the largest of the ten wD2AD weights (ties at random); index 8 chooses action 0, 9 chooses $AC, others the actor's skill in that slot (E-0127)
; 1 call site from 1 routine (e.g. ScoreActionsWithAIScoreTableA)
; reads: wRandomLo, wBattleActor, hTemp0
; writes: hTemp0
; points at: wAIWeights, wBattleSkills
ChooseHighestWeightedAction::
Func_030_4C00:: ; address name
    xor a, a
    ldh [hTemp0], a
    ld hl, $0000
    ld de, $0A00

.loop:
    ld a, e
    push hl
    ld hl, wAIWeights
    add a, a
    add_a_to_hl
    ld c, [hl]
    inc hl
    ld b, [hl]
    pop hl
    ld a, b
    and a, c
    cp a, $FF
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
    cp a, $08
    jr z, .skip2
    cp a, $09
    jr z, .call_actor_action_choice_address
    add a, a
    add_a_to_hl
    ld b, [hl]
    jr .call_actor_action_choice_address2

.skip2:
    ld b, $00
    jr .call_actor_action_choice_address2

.call_actor_action_choice_address:
    ld b, $AC

.call_actor_action_choice_address2:
    call ActorActionChoiceAddress
    ld [hl], b
    ret

; for each foe stores (actor ATK - foe DEF / 2) / 2, floored at 0, in wD2C1[foe & 3] (0 for empty slots) (E-0125)
; 1 call site from 1 routine (e.g. ScoreActionsWithAIScoreTableA)
; reads: wBattleActor
; points at: wAIDamageEstimates
EstimateDamageVsEachFoeToAIDamageEstimates::
Func_030_4C63:: ; address name
    ld a, [wBattleActor]
    call ReadBattleATKOfSlot_Bank30
    ld d, h
    ld e, l
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
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
    sub a, l
    ld e, a
    ld a, d
    sbc a, h
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
    and a, $03
    ld hl, wAIDamageEstimates
    add a, a
    add_a_to_hl
    ld [hl], e
    inc hl
    ld [hl], d
    pop de
    inc c
    dec b
    jr nz, .loop
    ret

; A = skill number: when the word at $55F3 + 2 * A (a per-skill weight table in this bank) is non-zero it is added to the word at DE and Func_030_4CDB adds a random adjustment; then the skill record is loaded (wRecordBuffer = A, wCFED = 0, LoadSkillRecord); A and DE kept (E-0083)
; 1 call site from 1 routine (e.g. ScoreSkillForAI)
; writes: wRecordBuffer
AddSkillBaseWeightAndLoadSkill::
Func_030_4CAB:: ; address name
    push de
    push af
    ld l, a
    ld h, $00
    add hl, hl
    ld a, l
    add a, $F3
    ld l, a
    ld a, h
    adc a, $55
    ld h, a
    ld a, [hl+]
    or a, [hl]
    jr z, .set_record_buffer
    dec hl
    ld a, [de]
    add a, [hl]
    ld [de], a
    inc hl
    inc de
    ld a, [de]
    adc a, [hl]
    ld [de], a
    call AddSkillBaseWeightAndLoadSkill_AdvanceRandom

.set_record_buffer:
    pop af
    push af
    ld [wRecordBuffer], a
    xor a, a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    pop af
    pop de
    ret

; only called from AddSkillBaseWeightAndLoadSkill (E-0047)
; 1 call site from 1 routine (e.g. AddSkillBaseWeightAndLoadSkill)
; reads: wRandomLo
AddSkillBaseWeightAndLoadSkill_AdvanceRandom::
Func_030_4CDB:: ; address name
    push af
    dec de
    call AdvanceRandom
    ld a, [wRandomLo]
    and a, $3F
    ld b, a
    ld a, [de]
    add a, b
    ld [de], a
    inc de
    ld a, [de]
    adc a, $00
    ld [de], a
    pop af
    ret

; entry 3 of the `rst $00` table in RunCommandEntryResolveStep
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep
; points at: wBattleSubPhase
RunCommandEntryResolveStep_RunActorActionHandlersForAISlots::
Jump_030_4CF0:: ; address name
    call RunActorActionHandlersForAISlots
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleResolveStep], a
    ret

; for AI-controlled slots (foes, or both sides outside normal battles, never slot 3/7) runs the handlers for the set bits of the actor's action data word (E-0124)
; 2 call sites from 2 routines (e.g. RunCommandEntryResolveStep_RunActorActionHandlersForAISlots, AIChooseActionForActor)
; reads: wLinkMode, wBattleActor
RunActorActionHandlersForAISlots::
Func_030_4CFC:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, .check_battle_actor
    cp a, $02
    jr nz, .check_battle_actor2

.check_battle_actor:
    ld a, [wBattleActor]
    cp a, $03
    jr nc, .return
    jr .call_actor_action_data_word

.check_battle_actor2:
    ld a, [wBattleActor]
    and a, $03
    cp a, $03
    jr z, .return

.call_actor_action_data_word:
    call ActorActionDataWord
    ld a, c
    and a, b
    cp a, $FF
    jr z, .return
    call RunHandlersForSetBitsInBC

.return:
    ret

; BC = the word at Data_030_4D34 + 2 * the actor's chosen action (ActorActionChoiceAddress) (E-0118)
; 1 call site from 1 routine (e.g. RunActorActionHandlersForAISlots)
ActorActionDataWord::
Func_030_4D25:: ; address name
    call ActorActionChoiceAddress
    ld c, [hl]
    ld b, $00
    ld hl, ActionHandlerMaskTable
    add hl, bc
    add hl, bc
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ret

; E-0237 (C1: ActorActionDataWord reads the word at $4D34 + 2 * the actor's chosen action byte; RunActorActionHandlersForAISlots skips $FFFF and otherwise passes it to RunHandlersForSetBitsInBC; 240 words up to that routine at $4F14).
; record: handler bit mask ($FFFF = none)
ActionHandlerMaskTable::
Data_030_4D34:: ; address name
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
    dw $FFFF ; id 21
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
    dw $FFFF ; id 32
    dw $0010 ; id 33
    dw $0010 ; id 34
    dw $0010 ; id 35
    dw $0010 ; id 36
    dw $FFFF ; id 37
    dw $FFFF ; id 38
    dw $0004 ; id 39
    dw $0004 ; id 40
    dw $FFFF ; id 41
    dw $FFFF ; id 42
    dw $0004 ; id 43
    dw $0004 ; id 44
    dw $FFFF ; id 45
    dw $0004 ; id 46
    dw $0004 ; id 47
    dw $0004 ; id 48
    dw $FFFF ; id 49
    dw $0004 ; id 50
    dw $0004 ; id 51
    dw $0004 ; id 52
    dw $FFFF ; id 53
    dw $FFFF ; id 54
    dw $FFFF ; id 55
    dw $FFFF ; id 56
    dw $FFFF ; id 57
    dw $FFFF ; id 58
    dw $FFFF ; id 59
    dw $FFFF ; id 60
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
    dw $FFFF ; id 78
    dw $FFFF ; id 79
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
    dw $FFFF ; id 104
    dw $FFFF ; id 105
    dw $FFFF ; id 106
    dw $FFFF ; id 107
    dw $FFFF ; id 108
    dw $FFFF ; id 109
    dw $FFFF ; id 110
    dw $FFFF ; id 111
    dw $FFFF ; id 112
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
    dw $FFFF ; id 123
    dw $0010 ; id 124
    dw $0080 ; id 125
    dw $0004 ; id 126
    dw $0004 ; id 127
    dw $0004 ; id 128
    dw $0010 ; id 129
    dw $FFFF ; id 130
    dw $FFFF ; id 131
    dw $FFFF ; id 132
    dw $FFFF ; id 133
    dw $FFFF ; id 134
    dw $FFFF ; id 135
    dw $FFFF ; id 136
    dw $FFFF ; id 137
    dw $FFFF ; id 138
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
    dw $000A ; id 150
    dw $FFFF ; id 151
    dw $FFFF ; id 152
    dw $FFFF ; id 153
    dw $FFFF ; id 154
    dw $FFFF ; id 155
    dw $FFFF ; id 156
    dw $FFFF ; id 157
    dw $FFFF ; id 158
    dw $0010 ; id 159
    dw $0010 ; id 160
    dw $FFFF ; id 161
    dw $FFFF ; id 162
    dw $FFFF ; id 163
    dw $FFFF ; id 164
    dw $FFFF ; id 165
    dw $FFFF ; id 166
    dw $FFFF ; id 167
    dw $FFFF ; id 168
    dw $FFFF ; id 169
    dw $0002 ; id 170
    dw $FFFF ; id 171
    dw $FFFF ; id 172
    dw $FFFF ; id 173
    dw $FFFF ; id 174
    dw $FFFF ; id 175
    dw $FFFF ; id 176
    dw $FFFF ; id 177
    dw $FFFF ; id 178
    dw $FFFF ; id 179
    dw $FFFF ; id 180
    dw $FFFF ; id 181
    dw $FFFF ; id 182
    dw $FFFF ; id 183
    dw $FFFF ; id 184
    dw $FFFF ; id 185
    dw $FFFF ; id 186
    dw $FFFF ; id 187
    dw $FFFF ; id 188
    dw $FFFF ; id 189
    dw $FFFF ; id 190
    dw $FFFF ; id 191
    dw $FFFF ; id 192
    dw $FFFF ; id 193
    dw $FFFF ; id 194
    dw $FFFF ; id 195
    dw $FFFF ; id 196
    dw $FFFF ; id 197
    dw $FFFF ; id 198
    dw $FFFF ; id 199
    dw $FFFF ; id 200
    dw $FFFF ; id 201
    dw $FFFF ; id 202
    dw $FFFF ; id 203
    dw $FFFF ; id 204
    dw $FFFF ; id 205
    dw $FFFF ; id 206
    dw $FFFF ; id 207
    dw $FFFF ; id 208
    dw $FFFF ; id 209
    dw $FFFF ; id 210
    dw $FFFF ; id 211
    dw $FFFF ; id 212
    dw $FFFF ; id 213
    dw $FFFF ; id 214
    dw $FFFF ; id 215
    dw $FFFF ; id 216
    dw $FFFF ; id 217
    dw $FFFF ; id 218
    dw $FFFF ; id 219
    dw $FFFF ; id 220
    dw $FFFF ; id 221
    dw $FFFF ; id 222
    dw $FFFF ; id 223
    dw $FFFF ; id 224
    dw $FFFF ; id 225
    dw $FFFF ; id 226
    dw $FFFF ; id 227
    dw $FFFF ; id 228
    dw $FFFF ; id 229
    dw $FFFF ; id 230
    dw $FFFF ; id 231
    dw $FFFF ; id 232
    dw $FFFF ; id 233
    dw $FFFF ; id 234
    dw $FFFF ; id 235
    dw $FFFF ; id 236
    dw $FFFF ; id 237
    dw $FFFF ; id 238
    dw $FFFF ; id 239

; for bit numbers 0-15 in turn (BitMaskWords16): when the bit is set in BC (C for 0-7, B for 8-15), calls handler E through CallFlagBitHandlerE; stops early when a handler returns carry (E-0102)
; 1 call site from 1 routine (e.g. RunActorActionHandlersForAISlots)
RunHandlersForSetBitsInBC::
Func_030_4F14:: ; address name
    ld e, $00
    ld d, $10
    ld hl, BitMaskWords16

.loop:
    push hl
    push bc
    push de
    ld a, c
    and a, [hl]
    jr z, .next
    call CallFlagBitHandlerE
    jr .restore

.next:
    inc hl
    ld a, b
    and a, [hl]
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
; 2 call sites from 1 routine (e.g. RunHandlersForSetBitsInBC)
CallFlagBitHandlerE::
Func_030_4F3B:: ; address name
    ld d, $00
    ld hl, $4F66
    add hl, de
    add hl, de
    call JumpToWordAtHL
    ret

; 16 words $0001, $0002, ... $8000, one bit each (E-0102)
; address loaded by RunHandlersForSetBitsInBC
BitMaskWords16:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_030_4F46:: ; address name
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
    db $C6, $4F, $C6, $4F, $C6, $4F, $C6, $4F, $C6, $4F, $C6, $4F, $C6, $4F, $C6, $4F

; AI trait roll with mask DE = $01: when the actor's value is at least $80 rolls a chance that grows with its distance from $80 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wBattleActor
; points at: wSlotPersonalityHi, wSlotFlags854
RollPersonalityHiHighFlag01:: ; heuristic: target of a pointer table; C0
Func_030_4F86:: ; address name
    ld hl, wSlotPersonalityHi
    ld de, $0001
    jr RollSlotTraitLowFlag80_CallAdvanceRandom

; AI trait roll with mask DE = $02: when the actor's value is below $80 rolls a chance that grows with its distance from $80 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wBattleActor
; points at: wSlotPersonalityHi, wSlotFlags854
RollPersonalityHiLowFlag02:: ; heuristic: target of a pointer table; C0
Func_030_4F8E:: ; address name
    ld hl, wSlotPersonalityHi
    ld de, $0002
    jr RollSlotTraitLowFlag80_CallAdvanceRandom2

; AI trait roll with mask DE = $04: when the actor's value is at least $80 rolls a chance that grows with its distance from $80 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wBattleActor
; points at: wSlotPersonalityMid, wSlotFlags854
RollPersonalityMidHighFlag04:: ; heuristic: target of a pointer table; C0
Func_030_4F96:: ; address name
    ld hl, wSlotPersonalityMid
    ld de, $0004
    jr RollSlotTraitLowFlag80_CallAdvanceRandom

; AI trait roll with mask DE = $08: when the actor's value is below $80 rolls a chance that grows with its distance from $80 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wBattleActor
; points at: wSlotPersonalityMid, wSlotFlags854
RollPersonalityMidLowFlag08:: ; heuristic: target of a pointer table; C0
Func_030_4F9E:: ; address name
    ld hl, wSlotPersonalityMid
    ld de, $0008
    jr RollSlotTraitLowFlag80_CallAdvanceRandom2

; AI trait roll with mask DE = $10: when the actor's value is at least $80 rolls a chance that grows with its distance from $80 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wBattleActor
; points at: wSlotPersonalityLo, wSlotFlags854
RollPersonalityLoHighFlag10:: ; heuristic: target of a pointer table; C0
Func_030_4FA6:: ; address name
    ld hl, wSlotPersonalityLo
    ld de, $0010
    jr RollSlotTraitLowFlag80_CallAdvanceRandom

; AI trait roll with mask DE = $20: when the actor's value is below $80 rolls a chance that grows with its distance from $80 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wBattleActor
; points at: wSlotPersonalityLo, wSlotFlags854
RollPersonalityLoLowFlag20:: ; heuristic: target of a pointer table; C0
Func_030_4FAE:: ; address name
    ld hl, wSlotPersonalityLo
    ld de, $0020
    jr RollSlotTraitLowFlag80_CallAdvanceRandom2

; AI trait roll with mask DE = $40: when the actor's value is at least $80 rolls a chance that grows with its distance from $80 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wBattleActor
; points at: wSlotTrait, wSlotFlags854
RollSlotTraitHighFlag40:: ; heuristic: target of a pointer table; C0
Func_030_4FB6:: ; address name
    ld hl, wSlotTrait
    ld de, $0040
    jr RollSlotTraitLowFlag80_CallAdvanceRandom

; AI trait roll with mask DE = $80: when the actor's wD980 value is below $80 rolls a chance that grows with its distance from $80 (E-0125)
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wBattleActor
; points at: wSlotTrait, wSlotFlags854
RollSlotTraitLowFlag80:: ; heuristic: target of a pointer table; C0
Func_030_4FBE:: ; address name
    ld hl, wSlotTrait
    ld de, $0080
    jr RollSlotTraitLowFlag80_CallAdvanceRandom2
    db $AF, $C9

RollSlotTraitLowFlag80_CallAdvanceRandom::
Jump_030_4FC8:: ; address name
    call AdvanceRandom
    ld a, [wRandomLo]
    ld b, a
    ld a, [wBattleActor]
    add_a_to_hl
    ld a, [hl]
    cp a, $80
    ret c
    cp a, $A2
    jr c, RollSlotTraitLowFlag80_Skip2
    cp a, $C3
    jr c, RollSlotTraitLowFlag80_Skip3
    cp a, $E4
    jr c, RollSlotTraitLowFlag80_Skip4
    jr RollSlotTraitLowFlag80_Skip

RollSlotTraitLowFlag80_CallAdvanceRandom2::
Jump_030_4FE9:: ; address name
    call AdvanceRandom
    ld a, [wRandomLo]
    ld b, a
    ld a, [wBattleActor]
    add_a_to_hl
    ld a, [hl]
    cp a, $80
    ret nc
    cp a, $60
    jr nc, RollSlotTraitLowFlag80_Skip2
    cp a, $3F
    jr nc, RollSlotTraitLowFlag80_Skip3
    cp a, $1E
    jr nc, RollSlotTraitLowFlag80_Skip4

RollSlotTraitLowFlag80_Skip::
Jump_030_5008:: ; address name
    ld c, $08
    jr RollSlotTraitLowFlag80_Skip5

RollSlotTraitLowFlag80_Skip2::
Jump_030_500C:: ; address name
    ld c, $01
    jr RollSlotTraitLowFlag80_Skip5

RollSlotTraitLowFlag80_Skip3::
Jump_030_5010:: ; address name
    ld c, $02
    jr RollSlotTraitLowFlag80_Skip5

RollSlotTraitLowFlag80_Skip4::
Jump_030_5014:: ; address name
    ld c, $04

RollSlotTraitLowFlag80_Skip5::
Jump_030_5016:: ; address name
    ld a, b
    cp a, c
    ret nc
    ld a, [wBattleActor]
    ld hl, wSlotFlags854
    add a, a
    add_a_to_hl
    ld a, [hl]
    or a, e
    ld [hl+], a
    ld a, [hl]
    or a, d
    ld [hl], a
    scf
    ret

; only called from RunCommandEntryResolveStep_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunCommandEntryResolveStep_AddAx9ToHL)
; reads: wBattleActor, wTemp0, wPauseMenuStep
; points at: wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo, wTemp0
RunCommandEntryResolveStep_Case01_IncBIfActorEntryBelow40::
Func_030_502D:: ; address name
    ld b, $00
    ld hl, wSlotPersonalityHi
    call IncBIfActorEntryBelow40
    ld hl, wSlotPersonalityMid
    call IncBIfActorEntryBelow40
    ld hl, wSlotPersonalityLo
    call IncBIfActorEntryBelow40
    ld a, b
    cp a, $03
    jr z, .call_actor_action_choice_address
    ld b, $00
    ld hl, wSlotPersonalityMid
    call CountIfActorPersonalityHiAtLeastHLEntry
    ld hl, wSlotPersonalityLo
    call CountIfActorPersonalityHiAtLeastHLEntry
    ld a, b
    cp a, $02
    jr nz, .call_actor_action_choice_address2
    ld hl, wTemp0
    ld bc, $0008
    ld a, $FF
    call FillBytes
    call RunCommandEntryResolveStep_Case01_Sub03_WriteRecordBufferAndBattleArg0Etc
    ld a, [wBattleActor]
    ld hl, wSlotPersonalityHi
    add_a_to_hl
    ld a, [hl]
    cp a, $40
    jr c, .call_filter_skill_list_by_mp
    ld a, [wTemp0]
    cp a, $FF
    jr z, .call_actor_action_choice_address3

.call_filter_skill_list_by_mp:
    call FilterSkillListByMP
    ld a, [wPauseMenuStep]
    cp a, $FF
    jr z, .call_actor_action_choice_address3
    call RunCommandEntryResolveStep_Case01_Sub03_FillBytes
    ld a, [wTemp0]
    cp a, $FF
    jr z, .call_actor_action_choice_address3
    call RunCommandEntryResolveStep_Case01_Sub03_LoadSkillRecordPart
    call ActorActionChoiceAddress
    ld [hl], c
    ret

.call_actor_action_choice_address:
    call ActorActionChoiceAddress
    ld [hl], $AB
    ret

.call_actor_action_choice_address2:
    call ActorActionChoiceAddress
    ld [hl], $AC
    ret

.call_actor_action_choice_address3:
    call ActorActionChoiceAddress
    ld [hl], $00
    ret

; B += 1 when the byte at HL + wBattleActor is below $40 (E-0115)
; 3 call sites from 1 routine (e.g. RunCommandEntryResolveStep_Case01_IncBIfActorEntryBelow40)
; reads: wBattleActor
IncBIfActorEntryBelow40::
Func_030_50AC:: ; address name
    ld a, [wBattleActor]
    add_a_to_hl
    ld a, [hl]
    cp a, $40
    ret nc
    inc b
    ret

; B += 1 when wSlotPersonalityHi[actor] >= [HL + actor] (E-0122)
; 2 call sites from 1 routine (e.g. RunCommandEntryResolveStep_Case01_IncBIfActorEntryBelow40)
; reads: wBattleActor
; points at: wSlotPersonalityHi
CountIfActorPersonalityHiAtLeastHLEntry::
Func_030_50BA:: ; address name
    ld a, [wBattleActor]
    add_a_to_hl
    ld a, [wBattleActor]
    ld de, wSlotPersonalityHi
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    cp a, [hl]
    ret c
    inc b
    ret

; only called from RunCommandEntryResolveStep_Case01_Sub03 (E-0047)
; 1 call site from 1 routine (e.g. RunCommandEntryResolveStep_Case01_IncBIfActorEntryBelow40)
; reads: wBattleActor, wRecordBufferData
; writes: wRecordBuffer, wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3
; points at: wBattleSkills, wTemp0
RunCommandEntryResolveStep_Case01_Sub03_WriteRecordBufferAndBattleArg0Etc::
Func_030_50D2:: ; address name
    ld a, [wBattleActor]
    swap a
    ld hl, wBattleSkills
    add_a_to_hl
    ld b, $08
    ld c, $00

.loop:
    ld a, [hl]
    cp a, $FF
    jr z, .next
    push hl
    push bc
    ld [wRecordBuffer], a
    ld a, $03
    ld [wBattleArg0], a
    xor a, a
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
    and a, $03
    cp a, $02
    pop bc
    pop hl
    jr z, .next
    ld a, c
    ld de, wTemp0
    add a, e
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

; wBattleActor selects the actor; its MP word is at wD8DF + 2 * actor. For each of the 8 skill numbers in wC0A0 it loads the record (LoadSkillRecordPart) and keeps the number only when byte 0 of the record is below that MP word; otherwise it writes $FF to that slot. The comparison is strict: a skill whose cost equals the MP is dropped. Executed on the emulator for MP 0-40 against the ROM's costs (E-0048)
; 1 call site from 1 routine (e.g. RunCommandEntryResolveStep_Case01_IncBIfActorEntryBelow40)
; reads: wBattleActor, wRecordBufferData
; writes: wRecordBuffer, wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3
; points at: wBattleMP, wTemp0, wRecordBufferData, wPauseMenuStep
FilterSkillListByMP::
Func_030_5129:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleMP
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld hl, wTemp0
    ld e, $08
    ld d, $00

.loop:
    ld a, [hl]
    cp a, $FF
    jr z, .skip
    push hl
    push bc
    push de
    ld [wRecordBuffer], a
    ld a, $00
    ld [wBattleArg0], a
    xor a, a
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
    ld [hl], $FF

.next:
    inc d
    pop hl
    inc hl
    dec e
    jr nz, .loop

.skip:
    ld hl, wPauseMenuStep
    ld bc, $0008
    ld a, $FF
    call FillBytes
    ld hl, wTemp0
    ld de, wPauseMenuStep
    jr RunCommandEntryResolveStep_Case01_Sub03_FillBytes_Skip

; only called from RunCommandEntryResolveStep_Case01_Sub03 (E-0047)
; 1 call site from 1 routine (e.g. RunCommandEntryResolveStep_Case01_IncBIfActorEntryBelow40)
; points at: wPauseMenuStep, wTemp0
RunCommandEntryResolveStep_Case01_Sub03_FillBytes::
Func_030_519A:: ; address name
    ld hl, wPauseMenuStep
    ld b, $08
    ld c, $00

.loop:
    ld a, [hl]
    cp a, $FF
    jr z, .skip2
    call RunCommandEntryResolveStep_Case01_Sub03_Sub02_Sub01
    jr c, .next
    ld a, c
    ld de, wPauseMenuStep
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, $FF
    ld [de], a

.next:
    inc c
    inc hl
    dec b
    jr nz, .loop

.skip2:
    ld hl, wTemp0
    ld bc, $0008
    ld a, $FF
    call FillBytes
    ld hl, wPauseMenuStep
    ld de, wTemp0

RunCommandEntryResolveStep_Case01_Sub03_FillBytes_Skip::
Jump_030_51CD:: ; address name
    ld b, $08

.loop:
    ld a, [hl]
    cp a, $FF
    jr z, .next
    ld a, [hl]
    ld [de], a
    inc de

.next:
    inc hl
    dec b
    jr nz, .loop
    ret

; only called from RunCommandEntryResolveStep_Case01_Sub03_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. RunCommandEntryResolveStep_Case01_Sub03_FillBytes)
RunCommandEntryResolveStep_Case01_Sub03_Sub02_Sub01::
Func_030_51DC:: ; address name
    cp a, $01
    jr c, .done
    cp a, $16
    jr c, .return_carry
    cp a, $3D
    jr c, .done
    cp a, $68
    jr c, .return_carry
    cp a, $6B
    jr z, .return_carry
    cp a, $6C
    jr z, .return_carry
    cp a, $6D
    jr z, .return_carry
    cp a, $6E
    jr z, .return_carry
    cp a, $6F
    jr z, .return_carry
    cp a, $70
    jr z, .return_carry

.done:
    scf
    ccf
    ret

.return_carry:
    scf
    ret

; only called from RunCommandEntryResolveStep_Case01_Sub03 (E-0047)
; 1 call site from 1 routine (e.g. RunCommandEntryResolveStep_Case01_IncBIfActorEntryBelow40)
; reads: wTemp0, wRecordBufferData
; writes: wRecordBuffer, wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3
; points at: wRecordBufferData, wTemp1, wTemp0
RunCommandEntryResolveStep_Case01_Sub03_LoadSkillRecordPart::
Func_030_5209:: ; address name
    ld a, [wTemp0]
    ld [wRecordBuffer], a
    ld a, $00
    ld [wBattleArg0], a
    xor a, a
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
    cp a, $FF
    jr z, .skip
    push hl
    push de
    push bc
    ld [wRecordBuffer], a
    ld a, $00
    ld [wBattleArg0], a
    xor a, a
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
    sub a, d
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

; B = forced action $CD, $CC, $CE or $CF by the actor's status bits (wD80F byte 0 bit 6, byte 1 bit 2, byte 2 bit 4, byte 5 bit 0); Z when none (E-0124)
; 2 call sites from 2 routines (e.g. AIChooseActionResolveStep, RunCommandEntryResolveStep_PersonalityIndexOfSlot_Bank30)
; reads: wBattleActor
; points at: wBattleStatus3
ForcedActionForActorStatus::
Func_030_5287:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl+]
    and a, $40
    jr z, .skip
    ld b, $CD
    jr .return

.skip:
    ld a, [hl+]
    and a, $04
    jr z, .skip2
    ld b, $CC
    jr .return

.skip2:
    ld a, [hl+]
    and a, $10
    jr z, .next
    ld b, $CE
    jr .return

.next:
    inc hl
    inc hl
    ld a, [hl]
    and a, $01
    jr z, .return
    ld b, $CF

.return:
    ret

; only called from RunCommandEntryResolveStep_Case01 (E-0047)
; 2 call sites from 1 routine (e.g. RunCommandEntryResolveStep_AddAx9ToHL)
; reads: wLinkMode, wBattleActor
; writes: hTemp0, hTemp1, hTemp2, hTemp3
; points at: wBattleLevel, wSlotTrait
RunCommandEntryResolveStep_Case01_WaitLinkMode::
Func_030_52B5:: ; address name
    ld a, [wLinkMode]
    or a, a
    ret nz
    ld a, [wBattleActor]
    cp a, $03
    ret nc
    xor a, a
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a
    ldh [hTemp3], a
    ld bc, $0000
    ld a, [wBattleActor]
    ld hl, wBattleLevel
    add_a_to_hl
    ld a, [hl]
    cp a, $0A
    jr c, .skip
    cp a, $14
    jr c, .skip2
    cp a, $1E
    jr c, .read_battle_actor
    ld c, $0C
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
    cp a, $97
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

; copies four bytes from HL to hFFC6, negating each when bit 6 of the actor's wDA43 byte is set (CopyByteNegateIfCBit6) (E-0122)
; 1 call site from 1 routine (e.g. RunCommandEntryResolveStep_Case01_WaitLinkMode)
; points at: hTemp0
CopyFourBytesNegatedByActorSlotTactic::
Func_030_5319:: ; address name
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
; 4 call sites from 1 routine (e.g. CopyFourBytesNegatedByActorSlotTactic)
CopyByteNegateIfCBit6::
Func_030_5335:: ; address name
    ld a, [hl]
    ld [de], a
    bit 6, c
    ret z
    cpl
    inc a
    ld [de], a
    ret

; only called from RunCommandEntryResolveStep_Case01_Sub04 (E-0047)
; 1 call site from 1 routine (e.g. RunCommandEntryResolveStep_Case01_WaitLinkMode)
; reads: wCommandByteE8, hTemp0, hTemp1, hTemp2, hTemp3, wBattleActor
; points at: hTemp0, wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo, wSlotTrait
RunCommandEntryResolveStep_Case01_Sub04_GetActorSlotTacticLow2::
Func_030_533E:: ; address name
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

; HL += actor, then Func_030_5428 (E-0122)
; 3 call sites from 1 routine (e.g. RunCommandEntryResolveStep_Case01_Sub04_GetActorSlotTacticLow2)
; reads: wBattleActor
AddSignedEToByteAtHLClampedForActorEntryOfHL::
Func_030_5378:: ; address name
    ld a, [wBattleActor]
    add_a_to_hl
    call AddSignedEToByteAtHLClamped
    ret

; E-0234 (C1: the code at RunCommandEntryResolveStep_Case01_WaitLinkMode.call_get_actor_slot_tactic_low2 indexes it with GetActorSlotTacticLow2 (wSlotTactic & 3), adds E ($10 when wSlotTrait >= $97, else 0) and C (0/4/8/12 from a threshold test on A), then CopyFourBytesNegatedByActorSlotTactic copies the four bytes to hTemp0, negating each when bit 6 of the actor's tactic byte is set).
; record: block of eight 4-byte records for this tactic
TacticOffsetTable::
Data_030_5384:: ; address name
    dw TacticOffsets0 ; id 0
    dw TacticOffsets1 ; id 1
    dw TacticOffsets2 ; id 2
    dw TacticOffsets3 ; id 3

; E-0234 (C1: block 0 of TacticOffsetTable; records 0-3 are used when wSlotTrait < $97 and records 4-7 otherwise, the record within each half chosen by the threshold test before RunCommandEntryResolveStep_Case01_WaitLinkMode.read_battle_actor2).
; record: four bytes copied to hTemp0 (two's complement; negated when bit 6 of the tactic byte is set)
TacticOffsets0::
Data_030_538C:: ; address name
    db $07, $FF, $00, $03 ; id 0
    db $05, $FF, $00, $02 ; id 1
    db $03, $FF, $00, $01 ; id 2
    db $02, $FF, $00, $01 ; id 3
    db $0A, $FF, $00, $04 ; id 4
    db $07, $FF, $00, $03 ; id 5
    db $05, $FF, $00, $02 ; id 6
    db $05, $00, $00, $01 ; id 7

; E-0234 (C1: block 1 of TacticOffsetTable; records 0-3 are used when wSlotTrait < $97 and records 4-7 otherwise, the record within each half chosen by the threshold test before RunCommandEntryResolveStep_Case01_WaitLinkMode.read_battle_actor2).
; record: four bytes copied to hTemp0 (two's complement; negated when bit 6 of the tactic byte is set)
TacticOffsets1::
Data_030_53AC:: ; address name
    db $00, $07, $FE, $03 ; id 0
    db $00, $05, $FE, $02 ; id 1
    db $00, $04, $FF, $01 ; id 2
    db $00, $03, $FF, $01 ; id 3
    db $00, $0A, $FD, $04 ; id 4
    db $00, $07, $FE, $03 ; id 5
    db $00, $05, $FF, $02 ; id 6
    db $00, $05, $00, $01 ; id 7

; E-0234 (C1: block 2 of TacticOffsetTable; records 0-3 are used when wSlotTrait < $97 and records 4-7 otherwise, the record within each half chosen by the threshold test before RunCommandEntryResolveStep_Case01_WaitLinkMode.read_battle_actor2).
; record: four bytes copied to hTemp0 (two's complement; negated when bit 6 of the tactic byte is set)
TacticOffsets2::
Data_030_53CC:: ; address name
    db $FE, $00, $07, $03 ; id 0
    db $FE, $00, $05, $02 ; id 1
    db $FF, $00, $04, $01 ; id 2
    db $FF, $00, $03, $01 ; id 3
    db $FE, $00, $0A, $04 ; id 4
    db $FE, $00, $07, $03 ; id 5
    db $FF, $00, $05, $02 ; id 6
    db $00, $00, $05, $01 ; id 7

; E-0234 (C1: block 3 of TacticOffsetTable; records 0-3 are used when wSlotTrait < $97 and records 4-7 otherwise, the record within each half chosen by the threshold test before RunCommandEntryResolveStep_Case01_WaitLinkMode.read_battle_actor2).
; record: four bytes copied to hTemp0 (two's complement; negated when bit 6 of the tactic byte is set)
TacticOffsets3::
Data_030_53EC:: ; address name
    db $00, $00, $00, $FF ; id 0
    db $00, $00, $00, $FE ; id 1
    db $00, $00, $00, $FE ; id 2
    db $00, $00, $00, $FF ; id 3
    db $00, $00, $00, $FF ; id 4
    db $00, $00, $00, $FE ; id 5
    db $00, $00, $00, $FE ; id 6
    db $00, $00, $00, $FF ; id 7

; A = wDA43[wBattleActor] & 3 (E-0072)
; 14 call sites from 13 routines (e.g. ScoreActionsWithAIScoreTableA, AIRunNextChoice, AIPickRandomSkillOfKind3, AddWeightsForSkillD_ReadLinkModeAndBattleActorEtc, ...)
; reads: wBattleActor
; points at: wSlotTactic
GetActorSlotTacticLow2::
Func_030_540C:: ; address name
    ld a, [wBattleActor]
    ld hl, wSlotTactic
    add_a_to_hl
    ld a, [hl]
    and a, $03
    ret

; HL = wBattleActionChoice + 2 * wBattleActor (the actor's action byte; the target follows) (E-0072)
; 15 call sites from 11 routines (e.g. ScoreActionsWithAIScoreTableA, ChooseHighestWeightedAction, AIRunNextChoice, AIPickRandomSkillOfKind3, ...)
; reads: wBattleActor
; points at: wBattleActionChoice
ActorActionChoiceAddress::
Func_030_541B:: ; address name
    ld a, [wBattleActor]
    add a, a
    ld hl, wBattleActionChoice
    add_a_to_hl
    ret

; [HL] += E as a signed value, clamped to 0-$FF (E-0124)
; 9 call sites from 6 routines (e.g. AddRandomPersonalityWeights, AddRandomWeightByValueBand, AddStatusAndHPWeightsToAI, AddActorPersonalityTensForIndexA, ...)
AddSignedEToByteAtHLClamped::
Func_030_5428:: ; address name
    bit 7, e
    jr z, .skip
    ld a, e
    cpl
    inc a
    ld e, a
    ld a, [hl]
    sub a, e
    jr nc, .done
    ld a, $00
    jr .done

.skip:
    ld a, e
    add a, [hl]
    jr nc, .done
    ld a, $FF

.done:
    ld [hl], a
    ret

; wPersonalityIndex = PersonalityIndexOfSlot_Bank30(actor); resets the AI workspace (Func_030_5472); with wD2CC = 1 runs the routine for the actor's AI mode (Data_030_45D0 indexed by wDA53[actor], JumpToHL) and stores its result B as the actor's chosen action; runs Func_030_4CFC; wD2CC = 0 (E-0120)
; 3 call sites from 2 routines (e.g. RunBattleActions_StatusChecks_CheckAction_ActorActionIsD0ToE3, RunDebugState_E0_ChooseActionTargets_Case05_AIChooseActionForActor)
; reads: wBattleActor
; writes: wPersonalityIndex, wAIFlag
; points at: wSlotAIMode
AIChooseActionForActor::
Func_030_5440:: ; address name
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
    xor a, a
    ld [wAIFlag], a
    ret

; only called from AIChooseActionForActor (E-0047)
; 1 call site from 1 routine (e.g. AIChooseActionForActor)
; writes: wAIChoiceWeights, wAIChoiceOrder, wAIChoiceIndex, wLoadSlot
; points at: wAIWeights
AIChooseActionForActor_AddCommandWeightToAIChoiceWeights::
Func_030_5472:: ; address name
    ld hl, wAIWeights
    ld bc, $0014
    xor a, a
    call FillBytes
    xor a, a
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

; only called from AIChooseActionForActor_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. AIChooseActionForActor_AddCommandWeightToAIChoiceWeights)
; reads: wRecordBufferData
; points at: wAIChoiceWeights
AIChooseActionForActor_Sub01_ReadRecordBufferData::
Func_030_54B5:: ; address name
    ld a, [wRecordBufferData + $3]
    and a, $F0
    cp a, $10
    jr z, .skip
    cp a, $20
    jr z, .skip2
    cp a, $30
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
    add a, $0A
    ld [hl], a

.return:
    ret

; only called from AIChooseActionForActor_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. AIChooseActionForActor_AddCommandWeightToAIChoiceWeights)
; reads: wBattleActor, wAIChoiceWeights
; writes: wAIChoiceWeights
; points at: wBattleCommandArgs, wBattleHP
AIChooseActionForActor_Sub01_WriteAIChoiceWeights::
Func_030_54DA:: ; address name
    ld a, [wBattleActor]
    rrca
    and a, $02
    xor a, $02
    ld hl, wBattleCommandArgs
    add_a_to_hl
    deref_hl
    push hl
    ld a, [wBattleActor]
    rrca
    and a, $02
    ld hl, wBattleCommandArgs
    add_a_to_hl
    deref_hl
    push hl
    ld a, [wBattleActor]
    rlca
    and a, $08
    ld hl, wBattleHP
    add_a_to_hl
    ld bc, $0000
    ld a, [hl+]
    add a, c
    ld c, a
    ld a, [hl+]
    adc a, b
    ld b, a
    ld a, [hl+]
    add a, c
    ld c, a
    ld a, [hl+]
    adc a, b
    ld b, a
    ld a, [hl+]
    add a, c
    ld c, a
    ld a, [hl+]
    adc a, b
    ld b, a
    ld h, b
    ld l, c
    add hl, bc
    pop bc
    call CompareHLToBC
    jr nc, .read_battle_actor
    ld a, [wAIChoiceWeights + $2]
    add a, $14
    ld [wAIChoiceWeights + $2], a

.read_battle_actor:
    ld a, [wBattleActor]
    rlca
    and a, $08
    xor a, $08
    ld hl, wBattleHP
    add_a_to_hl
    ld bc, $0000
    ld a, [hl+]
    add a, c
    ld c, a
    ld a, [hl+]
    adc a, b
    ld b, a
    ld a, [hl+]
    add a, c
    ld c, a
    ld a, [hl+]
    adc a, b
    ld b, a
    ld a, [hl+]
    add a, c
    ld c, a
    ld a, [hl+]
    adc a, b
    ld b, a
    ld h, b
    ld l, c
    add hl, bc
    add hl, bc
    pop bc
    call CompareHLToBC
    jr nc, .return
    ld a, [wAIChoiceWeights]
    add a, $14
    ld [wAIChoiceWeights], a

.return:
    ret

; advances the random seed; when wC5F8 is set and the random value is below wC5FA, stores wC5F9 as the actor's action choice (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wDebugCursor, wDebugValue1, wRandomLo, wDebugValue0
MaybeOverrideActorActionWithDebugValue0:: ; heuristic: follows a terminator; C0
Func_030_556C:: ; address name
    call AdvanceRandom
    call ActorActionChoiceAddress
    ld a, [wDebugCursor]
    or a, a
    jr z, .return
    ld a, [wDebugValue1]
    ld b, a
    ld a, [wRandomLo]
    cp a, b
    jr nc, .return
    ld a, [wDebugValue0]
    ld [hl], a

.return:
    ret

; E-0173 (C1: AddPersonalityWeightToBattleArg0 adds the byte $5587 + 4 * wPersonalityIndex + (the actor's wSlotTactic & 3) to the word wBattleArg0; 27 personality rows).
; record: weight added for tactic 0, 1, 2, 3
PersonalityTacticWeights::
Data_030_5587:: ; address name
    db $14, $14, $14, $00 ; id 0
    db $14, $14, $0F, $00 ; id 1
    db $14, $14, $05, $00 ; id 2
    db $14, $0F, $14, $00 ; id 3
    db $14, $0F, $0F, $00 ; id 4
    db $14, $0F, $05, $0A ; id 5
    db $14, $05, $14, $00 ; id 6
    db $14, $05, $0F, $00 ; id 7
    db $14, $05, $05, $00 ; id 8
    db $0F, $14, $14, $00 ; id 9
    db $0F, $14, $0F, $00 ; id 10
    db $0F, $14, $05, $00 ; id 11
    db $0F, $0F, $14, $00 ; id 12
    db $0F, $0F, $0F, $00 ; id 13
    db $0F, $0F, $05, $00 ; id 14
    db $0F, $05, $14, $00 ; id 15
    db $0F, $05, $0F, $00 ; id 16
    db $0F, $05, $05, $00 ; id 17
    db $05, $14, $14, $00 ; id 18
    db $05, $14, $0F, $00 ; id 19
    db $05, $14, $05, $00 ; id 20
    db $05, $0F, $14, $00 ; id 21
    db $05, $0F, $0F, $00 ; id 22
    db $05, $0F, $05, $00 ; id 23
    db $05, $05, $14, $00 ; id 24
    db $05, $05, $0F, $00 ; id 25
    db $05, $05, $05, $00 ; id 26

; E-0208 (C1: AddSkillBaseWeightAndLoadSkill (from ScoreSkillForAI) adds the word at $55F3 + 2 * skill to the score at DE when it is non-zero, then Func_030_4CDB adds a random adjustment; 201 words end at the far-pointer table at $5785; most weights are 50-110).
; record: base weight (0 = none)
SkillAIBaseWeightTable::
Data_030_55F3:: ; address name
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

; E-0174 (C1: ScoreActionsWithAIScoreTableA stores this table's address in wBattleExpAward / +1 (the AI's routine-table pointer) and ScoreSkillForAI far-calls entry 3 * skill; all 131 entries point at named AIScore_* routines).
; record: AI scoring routine for this skill number; its ROM bank
AIScoreRoutineTableA::
Data_030_5785:: ; address name
    dfar AIScore_Skill00 ; id 0
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
    dw PointerRun_30_590E_Entry00
    db $E2
    dw PointerRun_30_5911_Entry00
    db $E2
    dw PointerRun_30_5914_Entry00
    db $E2
    dw PointerRun_30_5914_Entry00
    db $E2
    dw PointerRun_30_5914_Entry00
    db $E2
    dw PointerRun_30_5914_Entry00
    db $E2
    dw PointerRun_30_5920_Entry00
    db $E2
    dw PointerRun_30_5923_Entry00
    db $E2
    dw PointerRun_30_5926_Entry00
    db $E2
    dw PointerRun_30_5929_Entry00
    db $E2
    dw PointerRun_30_592C_Entry00
    db $E2
    dw PointerRun_30_592C_Entry00
    db $E2
    dw PointerRun_30_5932_Entry00
    db $E2
    dw PointerRun_30_5932_Entry00
    db $E2
    dw PointerRun_30_5938_Entry00
    db $E2
    dw PointerRun_30_593B_Entry00
    db $E2
    dw PointerRun_30_593E_Entry00
    db $E2
    dw PointerRun_30_5941_Entry00
    db $E2
    dw PointerRun_30_5944_Entry00
    db $E2
    dw PointerRun_30_5947_Entry00
    db $E2
    dw PointerRun_30_594A_Entry00
    db $E2
    dw PointerRun_30_594A_Entry00
    db $E2
    dw PointerRun_30_5950_Entry00
    db $E2
    dw PointerRun_30_5953_Entry00
    db $E2
    dw PointerRun_30_5956_Entry00
    db $E2
    dw PointerRun_30_5959_Entry00
    db $E2
    dw PointerRun_30_595C_Entry00
    db $E2
    dw PointerRun_30_595F_Entry00
    db $E2
    dw PointerRun_30_5962_Entry00
    db $E2
    dw PointerRun_30_5965_Entry00
    db $E2
    dw PointerRun_30_5968_Entry00
    db $E2
    dw PointerRun_30_596B_Entry00
    db $E2
    dw PointerRun_30_596B_Entry00
    db $E2
    dw PointerRun_30_596B_Entry00
    db $E2
    dw PointerRun_30_596B_Entry00
    db $E2
    dw PointerRun_30_596B_Entry00
    db $E2
    dw PointerRun_30_596B_Entry00
    db $E2
    dw PointerRun_30_596B_Entry00
    db $E2
    dw PointerRun_30_596B_Entry00
    db $E2
    dw PointerRun_30_5983_Entry00
    db $E2
    dw PointerRun_30_5986_Entry00
    db $E2
    dw PointerRun_30_5989_Entry00
    db $E2
    dw PointerRun_30_598C_Entry00
    db $E2
    dw PointerRun_30_598F_Entry00
    db $E2
    dw PointerRun_30_5992_Entry00
    db $E2
    dw PointerRun_30_5992_Entry00
    db $E2
    dw PointerRun_30_5992_Entry00
    db $E2, $FA, $63, $E2, $FA, $63, $E2, $BF, $64, $E2, $BF, $64, $E2, $FA, $63, $E2
    db $FA, $63, $E2, $BF, $64, $E2, $BF, $64, $E2, $01, $64, $E2, $1E, $64, $E2, $BF
    db $64, $E2, $BF, $64, $E2
    dw PointerRun_30_598F_Entry00
    db $E2
    dw PointerRun_30_5992_Entry00
    db $E2
    dw PointerRun_30_59C5_Entry00
    db $E2
    dw PointerRun_30_59C5_Entry00
    db $E2
    dw PointerRun_30_59C5_Entry00
    db $E2
    dw PointerRun_30_59C5_Entry00
    db $E2
    dw PointerRun_30_59C5_Entry00
    db $E2
    dw PointerRun_30_59C5_Entry00
    db $E2
    dw PointerRun_30_59C5_Entry00
    db $E2
    dw PointerRun_30_59C5_Entry00
    db $E2
    dw PointerRun_30_59DD_Entry00
    db $E2

; E-0174 (C1: UseAIScoreTableB stores this table's address in wBattleExpAward / +1 (the AI's routine-table pointer) and ScoreSkillForAI far-calls entry 3 * skill; all 131 entries point at named AIScore_* routines).
; record: AI scoring routine for this skill number; its ROM bank
AIScoreRoutineTableB::
Data_030_59E0:: ; address name
    dfar AIScore_Skill00 ; id 0
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
    dw PointerRun_30_590E_Entry00
    db $E2
    dw PointerRun_30_5911_Entry00
    db $E2
    dw PointerRun_30_5914_Entry00
    db $E2
    dw PointerRun_30_5914_Entry00
    db $E2
    dw PointerRun_30_5914_Entry00
    db $E2
    dw PointerRun_30_5914_Entry00
    db $E2
    dw PointerRun_30_5920_Entry00
    db $E2
    dw PointerRun_30_5923_Entry00
    db $E2
    dw PointerRun_30_5926_Entry00
    db $E2
    dw PointerRun_30_5929_Entry00
    db $E2
    dw PointerRun_30_592C_Entry00
    db $E2
    dw PointerRun_30_592C_Entry00
    db $E2
    dw PointerRun_30_5932_Entry00
    db $E2
    dw PointerRun_30_5932_Entry00
    db $E2
    dw PointerRun_30_5938_Entry00
    db $E2
    dw PointerRun_30_593B_Entry00
    db $E2
    dw PointerRun_30_593E_Entry00
    db $E2
    dw PointerRun_30_5941_Entry00
    db $E2
    dw PointerRun_30_5944_Entry00
    db $E2
    dw PointerRun_30_5947_Entry00
    db $E2
    dw PointerRun_30_594A_Entry00
    db $E2
    dw PointerRun_30_594A_Entry00
    db $E2
    dw PointerRun_30_5950_Entry00
    db $E2
    dw PointerRun_30_5953_Entry00
    db $E2
    dw PointerRun_30_5956_Entry00
    db $E2
    dw PointerRun_30_5959_Entry00
    db $E2
    dw PointerRun_30_595C_Entry00
    db $E2
    dw PointerRun_30_595F_Entry00
    db $E2
    dw PointerRun_30_5962_Entry00
    db $E2
    dw PointerRun_30_5965_Entry00
    db $E2
    dw PointerRun_30_5968_Entry00
    db $E2
    dw PointerRun_30_596B_Entry00
    db $E2
    dw PointerRun_30_596B_Entry00
    db $E2
    dw PointerRun_30_596B_Entry00
    db $E2
    dw PointerRun_30_596B_Entry00
    db $E2
    dw PointerRun_30_596B_Entry00
    db $E2
    dw PointerRun_30_596B_Entry00
    db $E2
    dw PointerRun_30_596B_Entry00
    db $E2
    dw PointerRun_30_596B_Entry00
    db $E2
    dw PointerRun_30_5983_Entry00
    db $E2
    dw PointerRun_30_5986_Entry00
    db $E2
    dw PointerRun_30_5989_Entry00
    db $E2
    dw PointerRun_30_598C_Entry00
    db $E2
    dw PointerRun_30_598F_Entry00
    db $E2
    dw PointerRun_30_5992_Entry00
    db $E2
    dw PointerRun_30_5992_Entry00
    db $E2
    dw PointerRun_30_5992_Entry00
    db $E2, $FA, $63, $E2, $FA, $63, $E2, $BF, $64, $E2, $BF, $64, $E2, $FA, $63, $E2
    db $FA, $63, $E2, $BF, $64, $E2, $BF, $64, $E2, $01, $64, $E2, $1E, $64, $E2, $BF
    db $64, $E2, $BF, $64, $E2
    dw PointerRun_30_598F_Entry00
    db $E2
    dw PointerRun_30_5992_Entry00
    db $E2
    dw PointerRun_30_59C5_Entry00
    db $E2
    dw PointerRun_30_59C5_Entry00
    db $E2
    dw PointerRun_30_59C5_Entry00
    db $E2
    dw PointerRun_30_59C5_Entry00
    db $E2
    dw PointerRun_30_59C5_Entry00
    db $E2
    dw PointerRun_30_59C5_Entry00
    db $E2
    dw PointerRun_30_59C5_Entry00
    db $E2
    dw PointerRun_30_59C5_Entry00
    db $E2
    dw PointerRun_30_59DD_Entry00
    db $E2

; HL = wBattleATK, then ReadBattleWordFromArray_Bank30 (E-0122)
; 1 call site from 1 routine (e.g. EstimateDamageVsEachFoeToAIDamageEstimates)
; points at: wBattleATK
ReadBattleATKOfSlot_Bank30::
Func_030_5C3B:: ; address name
    ld hl, wBattleATK
    jr ReadBattleWordFromArray_Bank30

; HL = wBattleDEF, then ReadBattleWordFromArray_Bank30 (E-0122)
; 1 call site from 1 routine (e.g. EstimateDamageVsEachFoeToAIDamageEstimates)
; points at: wBattleDEF
ReadBattleDEFOfSlot_Bank30::
Func_030_5C40:: ; address name
    ld hl, wBattleDEF
    jr ReadBattleWordFromArray_Bank30

; HL = wBattleMaxHP, then ReadBattleWordFromArray_Bank30 (E-0122)
; 1 call site from 1 routine (e.g. AnyAllyHPBelowSixthOfMax)
; points at: wBattleMaxHP
ReadBattleMaxHPOfSlot_Bank30::
Func_030_5C45:: ; address name
    ld hl, wBattleMaxHP
    jr ReadBattleWordFromArray_Bank30
    db $21, $EF, $D8, $18, $19

; HL = wBattleHP, then ReadBattleWordFromArray_Bank30 (E-0122)
; 1 call site from 1 routine (e.g. AnyAllyHPBelowSixthOfMax)
; points at: wBattleHP
ReadBattleHPOfSlot_Bank30::
Func_030_5C4F:: ; address name
    ld hl, wBattleHP
    jr ReadBattleWordFromArray_Bank30

; no direct call (reached through a table, a jump or a vector)
; points at: wBattleMP
GetBattleMP_Bank30:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:401A; C0
Func_030_5C54:: ; address name
    ld hl, wBattleMP
    jr ReadBattleWordFromArray_Bank30
    db $21, $1F, $D9, $18, $0A, $21, $53, $DA, $85, $6F, $30, $01, $24, $7E, $C9

; the same 10 bytes as ReadBattleWordFromArray (36:7E5B)
; 5 call sites from 5 routines (e.g. AIRunNextChoice, AIChooseActionResolveStep, RunCommandEntryResolveStep_Case01_WaitLinkMode, RunCommandEntryResolveStep_Case01_GetActorSlotTacticLow2, ...)
ReadBattleWordFromArray_Bank30::
Func_030_5C68:: ; address name
    add a, a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes appear in 12 banks)
; 1 call site from 1 routine (e.g. RunCommandEntryResolveStep_AddAx9ToHL)
AddDoubleAToHL_Bank30::
Func_030_5C72:: ; address name
    add a, a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the reversal, not checked (E-0064) (the same 27 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole, wBattleActor
ActorOnLocalSide_Bank30:: ; heuristic: follows a terminator; C0
Func_030_5C79:: ; address name
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
TargetOnLocalSide_Bank30:: ; heuristic: follows a terminator; C0
Func_030_5C94:: ; address name
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

; no direct call (reached through a table, a jump or a vector)
; points at: wBattleStatus
ClearBattleStatusBitsWithMaskD_Bank30:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:4075; C0
Func_030_5CAF:: ; address name
    ld a, d
    ld hl, ClearBattleStatusBitsWithMaskD_Bank30_Data
    add_a_to_hl
    ld d, [hl]
    ld a, e
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, d
    and a, [hl]
    ld [hl], a
    ret

; address loaded by ClearBattleStatusBitsWithMaskD_Bank30
ClearBattleStatusBitsWithMaskD_Bank30_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_030_5CC4:: ; address name
    db $DF, $FE, $00, $FD, $73, $EF, $BF

; Sets bit 0 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wLevelUpGains
SetBit0OfLevelUpGainsIndexed_Bank30:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:4091; C0
Func_030_5CCB:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; Sets bit 1 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wLevelUpGains
SetBit1OfLevelUpGainsIndexed_Bank30:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:409E; C0
Func_030_5CD8:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; Sets bit 2 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wLevelUpGains
SetBit2OfLevelUpGainsIndexed_Bank30:: ; heuristic: follows a terminator; C0
Func_030_5CE5:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 2, [hl]
    pop hl
    ret

; A = slot 0-7: returns A = 9 * g(wD968[A]) + 3 * g(wD970[A]) + g(wD978[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes appear in 13 banks)
; 2 call sites from 2 routines (e.g. RunCommandEntryResolveStep_PersonalityIndexOfSlot_Bank30, AIChooseActionForActor)
; points at: wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo
PersonalityIndexOfSlot_Bank30::
Func_030_5CF2:: ; address name
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
CheckSlotStatusBlockWide_Bank30:: ; heuristic: follows a terminator; C0
Func_030_5D49:: ; address name
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
SlotHasStatus3Or4Bits_Bank30:: ; heuristic: follows a terminator; C0
Func_030_5D68:: ; address name
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
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

PointerRun_30_590E_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_5D83:: ; address name
    ds $39, $00

PointerRun_30_5911_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_5DBC:: ; address name
    ds $31, $00

PointerRun_30_5914_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_5DED:: ; address name
    ds $59, $00

PointerRun_30_5920_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_5E46:: ; address name
    ds $3D, $00

PointerRun_30_5923_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_5E83:: ; address name
    ds $3D, $00

PointerRun_30_5926_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_5EC0:: ; address name
    ds $4A, $00

PointerRun_30_5929_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_5F0A:: ; address name
    ds $8A, $00

PointerRun_30_592C_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_5F94:: ; address name
    ds $54, $00

PointerRun_30_5932_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_5FE8:: ; address name
    ds $5C, $00

PointerRun_30_5938_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_6044:: ; address name
    ds $45, $00

PointerRun_30_593B_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_6089:: ; address name
    ds $1D, $00

PointerRun_30_593E_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_60A6:: ; address name
    ds $31, $00

PointerRun_30_5941_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_60D7:: ; address name
    ds $3B, $00

PointerRun_30_5944_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_6112:: ; address name
    ds $27, $00

PointerRun_30_5947_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_6139:: ; address name
    ds $27, $00

PointerRun_30_594A_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_6160:: ; address name
    ds $2D, $00

PointerRun_30_5950_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_618D:: ; address name
    ds $35, $00

PointerRun_30_5953_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_61C2:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

PointerRun_30_5956_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_61CD:: ; address name
    ds $13, $00

PointerRun_30_5959_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_61E0:: ; address name
    ds $69, $00

PointerRun_30_595C_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_6249:: ; address name
    ds $5B, $00

PointerRun_30_595F_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_62A4:: ; address name
    ds $5F, $00

PointerRun_30_5962_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_6303:: ; address name
    ds $4D, $00

PointerRun_30_5965_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_6350:: ; address name
    ds $37, $00

PointerRun_30_5968_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_6387:: ; address name
    ds $73, $00

PointerRun_30_596B_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_63FA:: ; address name
    db $00, $00, $00, $00, $00, $00, $00

PointerRun_30_5983_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_6401:: ; address name
    ds $1D, $00

PointerRun_30_5986_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_641E:: ; address name
    db $00, $00, $00, $00, $00, $00, $00

PointerRun_30_5989_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_6425:: ; address name
    ds $4E, $00

PointerRun_30_598C_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_6473:: ; address name
    ds $1A, $00

PointerRun_30_598F_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_648D:: ; address name
    ds $32, $00

PointerRun_30_5992_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_64BF:: ; address name
    db $00

PointerRun_30_59C5_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_64C0:: ; address name
    db $00

PointerRun_30_59DD_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_030_64C1:: ; address name
    ds $1B3F, $00
