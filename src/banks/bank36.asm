SECTION "Bank 36", ROMX[$4000], BANK[$36]
    db $36

; jumps through a 16-entry table indexed by wBattleResolveStep (wCFCB): one step of resolving a battle action; the steps advance wBattleResolveStep and use wBattleSubStep (wCFCC) and wBattleSubStep2 (wCFCD) for nested state
; 2 call sites from 2 routines (e.g. RunBattleActions_ToRunBattleResolveStep, RunBattleStep4_ToRunBattleResolveStep)
; reads: wBattleResolveStep
RunBattleResolveStep::
Func_036_4001:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw ResolveStepBegin
    dw ResolveStepTargetAndSubEffects
    dw ResolveStepCallEffect82
    dw ResolveStepFlagBit7Effect
    dw ResolveStepEffectChecks
    dw ResolveStepChanceRoll
    dw ResolveStepActionEffect
    dw ResolveStepComputeDamage
    dw ResolveStepSoundWaitAndMessage
    dw ResolveStepMessage13AndSound
    dw ResolveStepDamageMessage
    dw ResolveStepBranchOnAction
    dw ResolveStepApplyDamage
    dw ResolveStepDefeat
    dw ResolveStep0ECallEffect
    dw ResolveStepAdvanceSubPhase

; resolve step $00: advances wBattleResolveStep and clears wBattleSubStep. When wDABD is zero, wCFF3 bit 7 is set, the target is present and bit 5 of the target's wD854 byte is set, it farcalls RunBattleResolveStep_Case00_Sub01 (not read), stores the result in wC971 when it is not $FF, shows message $33 and returns; otherwise it clears that bit and continues into ResolveStepTargetAndSubEffects (E-0053)
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowUpAction, wRecordBufferData, wBattleTarget, wBattleSubStep
; writes: wBattleSubStep, wResolveByte71
; points at: wBattleResolveStep, wSlotFlags854
ResolveStepBegin::
Jump_036_4025:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep], a
    ld a, [wFollowUpAction]
    or a, a
    jr nz, .read_battle_target
    ld a, [wRecordBufferData + $5]
    bit 7, a
    jr z, .read_battle_target
    ld a, [wBattleTarget]
    call CheckSlotStatusBlockWide_Bank36
    jr c, .read_battle_target
    ld a, [wBattleTarget]
    ld hl, wSlotFlags854
    add a, a
    add_a_to_hl
    bit 5, [hl]
    jr z, .read_battle_target
    farcall ResolveStepBegin_AdvanceRandom
    ld a, c
    cp a, $FF
    jr z, .read_battle_target
    ld [wResolveByte71], a
    ld d, $33
    farcall ShowBattleTextCategory0
    ret

.read_battle_target:
    ld a, [wBattleTarget]
    ld hl, wSlotFlags854
    add a, a
    add_a_to_hl
    res 5, [hl]

; resolve step $01: dispatches on wBattleSubStep to two cases. Case 0 (RunBattleResolveStep_Table2_Case00) may redirect wBattleTarget and shows message $CB, then selects one of four sub-effects by wCFF3 bits 7, 4 and 6 (RunBattleResolveStep_Table2_Case00_Sub01-Sub04, not read); case 1 (36:4127) follows (E-0053)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubStep
ResolveStepTargetAndSubEffects::
Jump_036_4077:: ; address name
    ld a, [wBattleSubStep]
    rst $00
    dw ResolveStepTargetAndSubEffects_WriteResolveByte81AndResolveFlagB2Etc
    dw ResolveStepTargetAndSubEffects_TargetOnLocalSide_Bank36

; entry 0 of the `rst $00` table in ResolveStepTargetAndSubEffects
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowUpAction, wRecordBufferData, wBattleTarget, wBattleActor, wResolveMsgFlags
; writes: wResolveByte81, wResolveFlagB2, wBattleTarget, wBattleSubStep, wDefeatStep, wResolveMsgFlags
; points at: wSideFlags0, wBattleTargetChoice, wBattleSubStep, wBattleResolveStep, wBattleStatus2
ResolveStepTargetAndSubEffects_WriteResolveByte81AndResolveFlagB2Etc::
Jump_036_407F:: ; address name
    xor a, a
    ld [wResolveByte81], a
    ld a, [wFollowUpAction]
    or a, a
    jp nz, .skip2
    ld a, [wRecordBufferData + $4]
    cp a, $40
    jp z, ResolveStepTargetAndSubEffects_TargetOnLocalSide_Bank36
    and a, $F0
    cp a, $20
    jp z, ResolveStepTargetAndSubEffects_TargetOnLocalSide_Bank36
    ld a, [wRecordBufferData + $5]
    bit 4, a
    jr z, .check_record_buffer_data
    ld a, [wBattleTarget]
    and a, $04
    ld c, a
    rrca
    rrca
    and a, $01
    ld hl, wSideFlags0
    add_a_to_hl
    bit 6, [hl]
    jr z, .check_record_buffer_data
    ld a, l
    add a, $5A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    rrca
    rrca
    and a, $03
    or a, c
    ld c, a
    call CheckSlotStatusBlockWide_Bank36
    jr c, .check_record_buffer_data
    ld a, $01
    ld [wResolveFlagB2], a
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld [hl], c
    ld a, c
    ld [wBattleTarget], a
    ld d, $CB ; battle text '0 inhaled the attack!'
    farcall ShowBattleText
    ld hl, wBattleSubStep
    inc [hl]
    ret

.check_record_buffer_data:
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wRecordBufferData + $5]
    bit 7, a
    jr nz, .call_resolve_step_target_and_sub_effects
    bit 4, a
    jr nz, .call_resolve_step_target_and_sub_effects2
    bit 6, a
    jr nz, .call_resolve_step_target_and_sub_effects3
    jr .call_resolve_step_target_and_sub_effects4

.call_resolve_step_target_and_sub_effects:
    call ResolveStepTargetAndSubEffects_Case00_SlotHasStatus3Or4Bits_Bank36
    jr c, .return
    jr .skip

.call_resolve_step_target_and_sub_effects2:
    call ResolveStepTargetAndSubEffects_Case00_ShowTheWindAroundHero
    jr c, .return
    jr .skip

.call_resolve_step_target_and_sub_effects3:
    call ResolveStepTargetAndSubEffects_Case00_WriteDefeatStepAndResolveByte81
    jr c, .return
    jr .skip

.call_resolve_step_target_and_sub_effects4:
    call ResolveStepTargetAndSubEffects_Case00_ShowButItFailedTo
    jr c, .return

.skip:
    jr ResolveStepTargetAndSubEffects_TargetOnLocalSide_Bank36

.return:
    ret

.skip2:
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]

; entry 1 of the `rst $00` table in ResolveStepTargetAndSubEffects
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wRecordBufferData, wResolveMsgFlags
; writes: wBattleSubStep, wDefeatStep, wResolveMsgFlags
; points at: wBattleResolveStep, wBattleStatus2
ResolveStepTargetAndSubEffects_TargetOnLocalSide_Bank36::
Jump_036_4127:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep], a
    ld a, [wBattleTarget]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit 3, [hl]
    ret z
    ld a, [wRecordBufferData + $5]
    bit 3, a
    ret z
    res 3, [hl]
    ld d, $E9
    call TargetOnLocalSide_Bank36
    jr c, .call_show_battle_text
    inc d

.call_show_battle_text:
    farcall ShowBattleText
    ld a, $03
    ld [wDefeatStep], a
    ld a, [wResolveMsgFlags]
    res 4, a
    ld [wResolveMsgFlags], a
    call SetSubPhase2AndRestartResolve
    ret

; only called from ResolveStepTargetAndSubEffects_Case00 (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepTargetAndSubEffects_WriteResolveByte81AndResolveFlagB2Etc)
; reads: wBattleTarget, wRecordBufferData, wBattleActionId, wBattleActor
; writes: wDefeatByteD1, wBattleTarget
; points at: wBattleStatus6, wSlotFlags854, wBattleStatus4, wBattleTargetChoice, wDefeatByteBF
ResolveStepTargetAndSubEffects_Case00_SlotHasStatus3Or4Bits_Bank36::
Func_036_4162:: ; address name
    ld a, [wBattleTarget]
    call SlotHasStatus3Or4Bits_Bank36
    jr z, .call_resolve_step_target_and_sub_effects
    ld a, [wRecordBufferData + $7]
    bit 5, a
    jr z, .call_resolve_step_target_and_sub_effects
    ld a, [wBattleActionId]
    cp a, $4E
    jr z, .call_set_sub_phase2_and_restart_resolve
    cp a, $4F
    jr z, .call_set_sub_phase2_and_restart_resolve
    ld a, $84
    call QueueSoundEffect
    call SetSubPhase2AndRestartResolve
    ld d, $68
    jp ResolveStepTargetAndSubEffects_CheckSlotStatusBlockWide_Bank36_CallShowBattleText

.call_set_sub_phase2_and_restart_resolve:
    call SetSubPhase2AndRestartResolve
    ld d, $69
    jp ResolveStepTargetAndSubEffects_CheckSlotStatusBlockWide_Bank36_CallShowBattleText

.call_resolve_step_target_and_sub_effects:
    call ResolveStepTargetAndSubEffects_CheckSlotStatusBlockWide_Bank36
    jp nc, ResolveStepTargetAndSubEffects_CheckSlotStatusBlockWide_Bank36_CallShowBattleText
    ld a, [wBattleActionId]
    cp a, $4E
    jr z, .read_battle_actor
    cp a, $4F
    jr nz, .read_battle_target

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    bit 0, [hl]
    jr z, .return_0

.read_battle_target:
    ld a, [wBattleTarget]
    call CheckSlotStatusBlockWide_Bank36
    jr c, .return_0
    ld a, [wBattleTarget]
    ld hl, wSlotFlags854
    call AddDoubleAToHL_Bank36
    bit 5, [hl]
    jr nz, .call_resolve_step_target_and_sub_effects2
    ld a, [wBattleTarget]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    bit 5, [hl]
    jr z, .return_0

.call_resolve_step_target_and_sub_effects2:
    call ResolveStepTargetAndSubEffects_Case00_Sub01_ReadBattleTargetAndResolveByte71Etc
    jr c, .call_show_battle_text
    push af
    ld a, [wBattleActionId]
    cp a, $CC
    jr nz, .restore
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    ld a, [hl]
    and a, $F3
    ld [hl], a

.restore:
    pop af
    push af
    ld d, $C8 ; battle text '0 shunted the attack!'
    farcall ShowBattleText
    ld a, [wBattleTarget]
    ld [wDefeatByteD1], a
    pop af
    ld [wBattleTarget], a
    ld b, a
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    call AddDoubleAToHL_Bank36
    ld [hl], b
    ld hl, wDefeatByteBF
    set 0, [hl]
    scf
    ret

.call_show_battle_text:
    ld d, $C9 ; battle text '0 failed to avert attack!'
    farcall ShowBattleText
    scf
    ret

.return_0:
    xor a, a
    ret

; only called from ResolveStepTargetAndSubEffects_Case00 (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepTargetAndSubEffects_WriteResolveByte81AndResolveFlagB2Etc)
; reads: wBattleTarget, wBattleActor
; writes: wDefeatStep, wResolveByte81
; points at: wBattleStatus2
ResolveStepTargetAndSubEffects_Case00_ShowTheWindAroundHero::
Func_036_421D:: ; address name
    call ResolveStepTargetAndSubEffects_CheckSlotStatusBlockWide_Bank36
    jp nc, ResolveStepTargetAndSubEffects_CheckSlotStatusBlockWide_Bank36_CallShowBattleText
    ld a, [wBattleTarget]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit 6, [hl]
    jr z, .return_0
    res 6, [hl]
    ld a, $02
    ld [wDefeatStep], a
    ld d, $C7 ; battle text 'The wind around 0 bounced the'
    farcall ShowBattleText
    ld a, $01
    ld [wResolveByte81], a
    ld a, [wBattleActor]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .call_set_sub_phase2_and_restart_resolve
    ld d, $01
    call ResolveStepTargetAndSubEffects_WriteBattleActorAndBattleTargetEtc
    scf
    ret

.return_0:
    xor a, a
    ret

.call_set_sub_phase2_and_restart_resolve:
    call SetSubPhase2AndRestartResolve
    scf
    ret

; only called from ResolveStepTargetAndSubEffects_Case00 (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepTargetAndSubEffects_WriteResolveByte81AndResolveFlagB2Etc)
; reads: wBattleTarget, wRecordBufferData, wBattleActor
; writes: wDefeatStep, wResolveByte81
; points at: wBattleStatus2
ResolveStepTargetAndSubEffects_Case00_WriteDefeatStepAndResolveByte81::
Func_036_425A:: ; address name
    call ResolveStepTargetAndSubEffects_CheckSlotStatusBlockWide_Bank36
    jp nc, ResolveStepTargetAndSubEffects_CheckSlotStatusBlockWide_Bank36_CallShowBattleText
    ld a, [wBattleTarget]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    ld a, [hl]
    and a, $22
    jr z, .return_0
    ld a, [wRecordBufferData + $7]
    bit 7, a
    jr z, .return_0
    bit 1, [hl]
    jr nz, .call_target_on_local_side_bank36
    res 5, [hl]
    ld a, $01
    ld [wDefeatStep], a

.call_target_on_local_side_bank36:
    call TargetOnLocalSide_Bank36
    ld d, $C5
    jr c, .call_show_battle_text
    ld d, $C6 ; battle text 'The wall of light bounced the'

.call_show_battle_text:
    farcall ShowBattleText
    ld a, $01
    ld [wResolveByte81], a
    ld a, [wBattleActor]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .call_set_sub_phase2_and_restart_resolve
    ld d, $04
    call ResolveStepTargetAndSubEffects_WriteBattleActorAndBattleTargetEtc
    scf
    ret

.return_0:
    xor a, a
    ret

.call_set_sub_phase2_and_restart_resolve:
    call SetSubPhase2AndRestartResolve
    scf
    ret

; only called from ResolveStepTargetAndSubEffects_Case00 (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepTargetAndSubEffects_WriteResolveByte81AndResolveFlagB2Etc)
; reads: wBattleTarget, wRecordBufferData
ResolveStepTargetAndSubEffects_Case00_ShowButItFailedTo::
Func_036_42AA:: ; address name
    ld a, [wBattleTarget]
    call SlotHasStatus3Or4Bits_Bank36
    jr z, .call_resolve_step_target_and_sub_effects
    ld a, [wRecordBufferData + $7]
    bit 5, a
    jr z, .call_resolve_step_target_and_sub_effects
    ld a, $84
    call QueueSoundEffect
    ld d, $68 ; battle text 'But it failed to reach 0!'
    farcall ShowBattleText
    call SetSubPhase2AndRestartResolve
    scf
    ret

.call_resolve_step_target_and_sub_effects:
    call ResolveStepTargetAndSubEffects_CheckSlotStatusBlockWide_Bank36
    jp nc, ResolveStepTargetAndSubEffects_CheckSlotStatusBlockWide_Bank36_CallShowBattleText
    xor a, a
    ret

; only called from routines of ResolveStepTargetAndSubEffects (E-0098)
; 4 call sites from 4 routines (e.g. ResolveStepTargetAndSubEffects_Case00_ShowButItFailedTo, ResolveStepTargetAndSubEffects_Case00_WriteDefeatStepAndResolveByte81, ResolveStepTargetAndSubEffects_Case00_ShowTheWindAroundHero, ResolveStepTargetAndSubEffects_Case00_SlotHasStatus3Or4Bits_Bank36)
; reads: wBattleTarget, wRecordBufferData, wBattleActor
; writes: wDefeatByteD1, wBattleTarget, wResolveByte81
; points at: wBattleStatus6, wBattleTargetChoice, wDefeatByteBF
ResolveStepTargetAndSubEffects_CheckSlotStatusBlockWide_Bank36::
Func_036_42D3:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    bit 4, [hl]
    jr z, .return_carry
    ld a, [wRecordBufferData + $6]
    bit 0, a
    jr z, .return_carry
    inc hl
    ld a, [hl]
    swap a
    and a, $0F
    ld c, a
    call CheckSlotStatusBlockWide_Bank36
    jr c, .return_carry
    ld a, [wBattleTarget]
    ld [wDefeatByteD1], a
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    call AddDoubleAToHL_Bank36
    ld [hl], c
    ld a, c
    ld [wBattleTarget], a
    ld a, $01
    ld [wResolveByte81], a
    ld hl, wDefeatByteBF
    set 1, [hl]
    ld d, $CA
    xor a, a
    ret

.return_carry:
    scf
    ret

ResolveStepTargetAndSubEffects_CheckSlotStatusBlockWide_Bank36_CallShowBattleText::
Jump_036_4317:: ; address name
    farcall ShowBattleText
    scf
    ret

; resolve step $02: advances wBattleResolveStep; when wDABD is non-zero and wDAB2 is zero and ActionIs91AndStatusBit6Set is not set, it stores $82 in wDAD2 and farcalls 3A:4001. When wDABD is zero or wDAB2 is non-zero it continues as ResolveStepFlagBit7Effect; when ActionIs91AndStatusBit6Set is set it returns (E-0050)
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowUpAction, wResolveFlagB2, wBattleTarget, wRecordBufferData, wBattleActionId, wBattleActor, wResolveMsgFlags, wRandomLo
; writes: wEffectFlags, wResolveMsgFlags
; points at: wBattleResolveStep, wSlotFlags854, wBattleStatus4, wBattleStatus5, wBattleStatus3, wBattleStatus1, wBattleStatus, wBattleAGL
ResolveStepCallEffect82::
Jump_036_431F:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wFollowUpAction]
    or a, a
    jr z, ResolveStepFlagBit7Effect
    ld a, [wResolveFlagB2]
    or a, a
    jr nz, ResolveStepFlagBit7Effect
    call ActionIs91AndStatusBit6Set
    ret z
    ld a, $82
    ld [wEffectFlags], a
    farcall SelectEffectByEffectFlags
    ret

; Z set when wBattleActionId = $91 and bit 6 of the actor's status byte 3 (wD80F + 9 * actor) is set; Z clear otherwise (A is $40 or 0 for $91, the comparison result otherwise). Used by RunBattleResolveStep_Case02 (E-0050)
; 1 call site from 1 routine (e.g. ResolveStepCallEffect82)
; reads: wBattleActionId, wBattleActor
; points at: wBattleStatus3
ActionIs91AndStatusBit6Set::
Func_036_433F:: ; address name
    ld a, [wBattleActionId]
    cp a, $91
    jr z, .read_battle_actor
    ret

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl]
    and a, $40
    xor a, $40
    ret

; resolve step $03: advances wBattleResolveStep. When wBattleTarget is present (Func_036_7F3C does not set carry), wCFF4 bit 6 is set, and the target's wD854 byte has bit 7 set, it farcalls 3A:6EE5 with D = $35, calls Func_036_4FD1 and queues sound $84; otherwise it goes on to case 4 (E-0050)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wRecordBufferData, wBattleActionId, wBattleActor, wResolveMsgFlags, wRandomLo
; writes: wResolveMsgFlags
; points at: wBattleResolveStep, wSlotFlags854, wBattleStatus4, wBattleStatus5, wBattleStatus3, wBattleStatus1, wBattleStatus, wBattleAGL
ResolveStepFlagBit7Effect::
Jump_036_4356:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleTarget]
    call CheckSlotStatusBlockWide_Bank36
    jr c, ResolveStepEffectChecks
    ld a, [wRecordBufferData + $6]
    bit 6, a
    jr z, ResolveStepEffectChecks
    ld a, [wBattleTarget]
    ld hl, wSlotFlags854
    add a, a
    add_a_to_hl
    bit 7, [hl]
    jr z, ResolveStepEffectChecks
    ld d, $35
    farcall ShowBattleTextCategory0
    call SetSubPhase2AndRestartResolve
    ld a, $84
    call QueueSoundEffect
    ret

; resolve step $04: runs RunBattleResolveStep_Case04_Sub01 (returns on action $35) and, when the target is present, advances the step. Then it selects one of several effects from wCFF4 bits 1, 6 and wCFF3 bits 7 and 0 and the status bytes of the actor and target: messages $66, $68 and $D2 (with sound $84) and calls to RunBattleResolveStep_Case04_Sub03 when the roll is below a threshold. The threshold for the roll comes from the actor's AGL minus the target's AGL, in bands of $320, $258, $190, $C8 and $64 (values $80 down to $01); the roll is AdvanceRandom's wC5E7 (E-0054)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wRecordBufferData, wBattleActionId, wBattleActor, wResolveMsgFlags, wRandomLo
; writes: wResolveMsgFlags
; points at: wBattleResolveStep, wBattleStatus4, wBattleStatus5, wBattleStatus3, wBattleStatus1, wSlotFlags854, wBattleStatus, wBattleAGL
ResolveStepEffectChecks::
Jump_036_438A:: ; address name
    call ResolveStepEffectChecks_WaitBattleActionId
    jr z, .call_resolve_step_effect_checks_wait_battle
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .call_resolve_step_effect_checks_wait_battle
    call SetSubPhase3AndRestartResolve
    ret

.call_resolve_step_effect_checks_wait_battle:
    ld hl, wBattleResolveStep
    inc [hl]
    call ResolveStepEffectChecks_WaitBattleActionId_Sub02
    ret z
    ld a, [wRecordBufferData + $6]
    bit 1, a
    jr z, .check_record_buffer_data
    ld a, [wBattleActionId]
    cp a, $CC
    jr nz, .read_battle_target
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    jr z, .check_record_buffer_data

.read_battle_target:
    ld a, [wBattleTarget]
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hl]
    and a, $C0
    jr z, .check_record_buffer_data
    ld d, $66 ; battle text '0 is a hunk of iron!'
    farcall ShowBattleText
    jp .read_resolve_msg_flags

.check_record_buffer_data:
    ld a, [wRecordBufferData + $5]
    bit 7, a
    jr z, .check_record_buffer_data2
    ld a, [wBattleTarget]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    jr z, .read_battle_target2
    cp a, $0C
    jr nz, .loop
    ld a, [wBattleActionId]
    cp a, $CC
    jr nz, .loop
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    jr z, .read_battle_target2

.loop:
    ld a, $84
    call QueueSoundEffect
    ld d, $68 ; battle text 'But it failed to reach 0!'
    farcall ShowBattleText
    jp .read_resolve_msg_flags

.read_battle_target2:
    ld a, [wBattleTarget]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl]
    and a, $C0
    jr z, .check_record_buffer_data2
    cp a, $C0
    jr nz, .loop
    ld a, [wBattleActionId]
    cp a, $CC
    jr z, .check_record_buffer_data2
    jr .loop

.check_record_buffer_data2:
    ld a, [wRecordBufferData + $5]
    bit 0, a
    jr z, .check_record_buffer_data3
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 1, [hl]
    jr z, .read_battle_actor
    call AdvanceRandom
    ld a, [wRandomLo]
    cp a, $A0
    jr nc, .read_battle_actor
    jr .read_battle_actor2

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hl]
    and a, $03
    jr z, .check_record_buffer_data3
    call AdvanceRandom
    ld a, [wRandomLo]
    cp a, $60
    jr nc, .check_record_buffer_data3

.read_battle_actor2:
    ld a, [wBattleActor]
    ld hl, wSlotFlags854
    add a, a
    add_a_to_hl
    bit 2, [hl]
    jr nz, .check_record_buffer_data3
    call ResolveStepEffectChecks_ShowMissHeroAvoidedDamage
    jp .read_resolve_msg_flags

.check_record_buffer_data3:
    ld a, [wRecordBufferData + $6]
    bit 6, a
    jp z, .return
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $D0
    jp nz, .return
    ld bc, $0004
    add hl, bc
    ld a, [hl]
    and a, $03
    jp nz, .return
    inc hl
    ld a, [hl]
    and a, $30
    jp nz, .return
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $03
    jp nz, .return
    call AdvanceRandom
    ld a, [wBattleTarget]
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    jr z, .read_battle_actor3
    ld a, [wRandomLo]
    and a, $01
    jr z, .call_show_battle_text

.read_battle_actor3:
    ld a, [wBattleActor]
    ld hl, wBattleAGL
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wBattleAGL
    call ReadBattleWordFromArray
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    jr c, .check_random_lo
    or a, l
    jr z, .check_random_lo
    ld bc, $0320
    call CompareHLToBC
    jr nc, .skip
    ld bc, $0258
    call CompareHLToBC
    jr nc, .skip2
    ld bc, $0190
    call CompareHLToBC
    jr nc, .skip3
    ld bc, $00C8
    call CompareHLToBC
    jr nc, .skip4
    ld bc, $0064
    call CompareHLToBC
    jr nc, .skip5
    ld b, $02
    jr .check_random_lo2

.skip:
    ld b, $80
    jr .check_random_lo2

.skip2:
    ld b, $20
    jr .check_random_lo2

.skip3:
    ld b, $10
    jr .check_random_lo2

.skip4:
    ld b, $08
    jr .check_random_lo2

.skip5:
    ld b, $04
    jr .check_random_lo2

.check_random_lo:
    ld b, $01

.check_random_lo2:
    ld a, [wRandomLo]
    cp a, b
    jr nc, .return

.call_show_battle_text:
    ld d, $D2 ; battle text '0 leapt out of the way!'
    farcall ShowBattleText
    ld a, $84
    call QueueSoundEffect
    jr .read_resolve_msg_flags

.return:
    ret

.read_resolve_msg_flags:
    ld a, [wResolveMsgFlags]
    res 4, a
    ld [wResolveMsgFlags], a
    call SetSubPhase2AndRestartResolve
    ret

; only called from ResolveStepEffectChecks (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepEffectChecks)
; reads: wBattleActionId
ResolveStepEffectChecks_WaitBattleActionId::
Func_036_454F:: ; address name
    ld a, [wBattleActionId]
    cp a, $35
    ret z
    cp a, $16
    ret z
    cp a, $17
    ret z
    cp a, $18
    ret z
    cp a, $1B
    ret z
    cp a, $1C
    ret z
    cp a, $1D
    ret z
    cp a, $1E
    ret z
    cp a, $1F
    ret z
    cp a, $20
    ret z
    cp a, $7B
    ret z
    cp a, $98
    ret z
    cp a, $9A
    ret z
    cp a, $9D
    ret z
    cp a, $BB
    ret z
    cp a, $CE
    ret

; only called from ResolveStepEffectChecks (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepEffectChecks)
; reads: wBattleActionId
ResolveStepEffectChecks_WaitBattleActionId_Sub02::
Func_036_4582:: ; address name
    ld a, [wBattleActionId]
    cp a, $6A
    ret z
    cp a, $A0
    ret z
    cp a, $A1
    ret

; resolve step $05: advances wBattleResolveStep. With wCFF4 bits 3-4 both clear it continues into case 6. Bit 4 with the actor's status byte 1 bit 2 set continues into case 6. With wCFF4 bit 3 set and wD854 bit 0 (target) and status byte 1 bit 3 (actor) both clear, it rolls RollRandomLoBelowChance: on success it sets bit 7 of the actor's status byte 2 (wD80E), calls Func_036_7E6C, shows message $9C (carry) or $9D through 3A:7193, queues sound $83 and advances the step again; on failure, or when bit 3 is clear, it clears that bit (E-0052)
; no direct call (reached through a table, a jump or a vector)
; reads: wRecordBufferData, wBattleActor
; points at: wBattleResolveStep, wBattleStatus1, wSlotFlags854, wBattleStatus2
ResolveStepChanceRoll::
Jump_036_458E:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wRecordBufferData + $6]
    and a, $18
    jr z, ResolveStepActionEffect
    bit 4, a
    jr z, .check_record_buffer_data
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 2, [hl]
    jr nz, ResolveStepActionEffect

.check_record_buffer_data:
    ld a, [wRecordBufferData + $6]
    bit 3, a
    jr z, .read_battle_actor2
    ld a, [wBattleActor]
    ld hl, wSlotFlags854
    call AddDoubleAToHL_Bank36
    bit 0, [hl]
    jr nz, .read_battle_actor
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 3, [hl]
    jr nz, .read_battle_actor
    call AdvanceRandom
    call RollRandomLoBelowChance
    jr nc, .read_battle_actor2

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    set 7, [hl]
    call ActorOnLocalSide_Bank36
    ld d, $9C
    jr c, .call_show_battle_text
    ld d, $9D ; battle text 'A brutal hit!'

.call_show_battle_text:
    farcall ShowBattleText
    ld a, $83
    call QueueSoundEffect
    ld hl, wBattleResolveStep
    inc [hl]
    ret

.read_battle_actor2:
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    res 7, [hl]
    ret

; resolve step $06: advances wBattleResolveStep, then calls DispatchActionEffectTable for wBattleActionId (E-0053)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleResolveStep
ResolveStepActionEffect::
Jump_036_4603:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    call DispatchActionEffectTable
    ret

; resolve step $07: waits for the sound channels in wDC20 when the actor's wD80E bit 7 is set; advances the step; then works on the damage in wBattleDamageLo/Hi and wD873: doubles it for several status bits (wD80D bit 2, wD810 bits 0 and 4 with wCFF3 and wCFF4), rerolls it from the actor's ATK through Func_036_4930 when wCFF4 bit 3 and wD80E bit 7 are set, adds half again for wD854 bit 6, and halves or doubles it on the target's wD813 and wD812 bits (E-0054)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wSoundChannelSlots, wRecordBufferData, wBattleDamageLo, wBattleDamageHi, wBattleTarget, wBattleActionId
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleStatus2, wSoundChannel1, wBattleResolveStep, wBattleStatus1, wSlotFlags854, wBattleStatus7, wBattleStatus6, wBattleStatus4
ResolveStepComputeDamage::
Jump_036_460B:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit 7, [hl]
    jr z, .check_record_buffer_data
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannel1
    and a, [hl]
    cp a, $FF
    ret nz

.check_record_buffer_data:
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wRecordBufferData + $6]
    bit 4, a
    jr z, .check_record_buffer_data2
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 2, [hl]
    jr z, .check_record_buffer_data2
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    add hl, hl
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    jr .read_battle_actor

.check_record_buffer_data2:
    ld a, [wRecordBufferData + $6]
    bit 3, a
    jr z, .check_record_buffer_data3
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit 7, [hl]
    jr z, .check_record_buffer_data3
    res 7, [hl]
    call UnreferencedStoreResolveMessage35D0_Bank36
    ld a, [wBattleActor]
    call GetBattleATK
    call RandomWithin5PercentOfHL
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wBattleDamageHi], a
    jr .read_battle_target

.check_record_buffer_data3:
    ld a, [wRecordBufferData + $6]
    bit 5, a
    jr z, .check_record_buffer_data4
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    bit 0, [hl]
    jr z, .check_record_buffer_data4
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    add hl, hl
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    jr .read_battle_actor

.check_record_buffer_data4:
    ld a, [wRecordBufferData + $5]
    bit 1, a
    jr z, .read_battle_actor
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    bit 4, [hl]
    jr z, .read_battle_actor
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    call ResolveStepComputeDamage_RandomInRange
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wBattleDamageHi], a

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wSlotFlags854
    call AddDoubleAToHL_Bank36
    bit 6, [hl]
    jr z, .read_battle_target
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    ld c, l
    ld b, h
    srl b
    rr c
    add hl, bc
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a

.read_battle_target:
    ld a, [wBattleTarget]
    ld hl, wBattleStatus7
    call AddAx9ToHL
    ld a, [hl]
    and a, $07
    jr z, .read_battle_target3
    and a, $03
    ld c, a
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    jr nz, .check_record_buffer_data5
    ld a, [wRecordBufferData + $5]
    bit 7, a
    jr z, .read_battle_target3

.loop:
    srl h
    rr l
    jr .read_battle_target2

.check_record_buffer_data5:
    ld a, [wRecordBufferData + $6]
    bit 7, a
    jr z, .read_battle_target3
    bit 0, c
    jr nz, .loop
    ld a, $0A
    call DivideHLByA

.read_battle_target2:
    ld a, [wBattleTarget]
    ld de, wSlotFlags854
    add a, a
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    bit 1, a
    jr z, .set_battle_damage_lo
    srl h
    rr l

.set_battle_damage_lo:
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    jr .read_battle_target3

.read_battle_target3:
    ld a, [wBattleTarget]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    bit 2, [hl]
    jr z, .return
    ld a, [wRecordBufferData + $5]
    bit 7, a
    jr z, .return
    ld a, [wBattleActionId]
    cp a, $6F
    jr z, .return
    cp a, $70
    jr z, .return
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    sla l
    rl h
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a

.return:
    ret

; resolve step $08: for action $CD it returns while the sound channels in wDC20 are busy (wSoundChannelSlots and wDC20 not both $FF). Otherwise it advances the step twice, updates bit 4 or 6 of wDAC0 from wBattleDamageLo/Hi and wD873 when wDAC0 bit 5 is set, and for action $CF rewinds the step while wDAC0 bit 4 is set and wDABA is zero. It then stores $40 or $41 in wDAD2, farcalls 3A:4001 and 3A:5762 (E-0053)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActionId, wSoundChannelSlots, wResolveMsgFlags, wBattleDamageLo, wBattleDamageHi, wDefeatFlagsBA
; writes: wResolveMsgFlags, wEffectFlags, wEffectFlags2
; points at: wSoundChannel1, wBattleResolveStep
ResolveStepSoundWaitAndMessage::
Jump_036_4776:: ; address name
    ld a, [wBattleActionId]
    cp a, $CD
    jr nz, .skip
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannel1
    and a, [hl]
    cp a, $FF
    ret nz

.skip:
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wResolveMsgFlags]
    ld b, a
    bit 5, a
    jr z, .check_battle_action_id
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    ld a, h
    or a, l
    jr z, .skip2
    set 4, b
    res 6, b
    jr .set_resolve_msg_flags

.skip2:
    res 4, b
    set 6, b

.set_resolve_msg_flags:
    ld a, b
    ld [wResolveMsgFlags], a

.check_battle_action_id:
    ld a, [wBattleActionId]
    cp a, $CF
    jr nz, .check_resolve_msg_flags
    ld a, [wResolveMsgFlags]
    bit 4, a
    ret z
    ld hl, wBattleResolveStep
    dec [hl]
    ld a, [wDefeatFlagsBA]
    or a, a
    ret nz

.check_resolve_msg_flags:
    ld b, $40
    ld a, [wResolveMsgFlags]
    bit 4, a
    jr z, .set_effect_flags
    bit 6, a
    jr nz, .set_effect_flags
    set 0, b

.set_effect_flags:
    ld a, b
    ld [wEffectFlags], a
    farcall SelectEffectByEffectFlags
    ld a, [wResolveMsgFlags]
    and a, $10
    or a, $20
    ld [wEffectFlags2], a
    farcall SelectEffectByEffectFlags2Flags
    ret

; resolve step $09: advances wBattleResolveStep, stores $13 in wDAD2, farcalls 3A:4001 and queues sound effect $85 (E-0053)
; no direct call (reached through a table, a jump or a vector)
; writes: wEffectFlags
; points at: wBattleResolveStep
ResolveStepMessage13AndSound::
Jump_036_47F1:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $13
    ld [wEffectFlags], a
    farcall SelectEffectByEffectFlags
    ld a, $85
    call QueueSoundEffect
    ret

; resolve step $0A: advances wBattleResolveStep and, for the actor or target side chosen by wDAC0 bit 4, stores wDAC2 or wDAC3 in wC0A0 and calls Func_036_4991 / Func_036_4A38; the first fight showed the battle text 'took N damage!' (bank $2F, category 1, index 53) at this step
; no direct call (reached through a table, a jump or a vector)
; reads: wResolveMsgFlags, wResolveMsgActor, wBattleActionId, wTemp0, hTemp0, wBattleActor, wBattleTarget, wResolveMsgTarget, ...
; writes: wTemp0, wBattleActor
; points at: wBattleResolveStep, wTemp0, wBattleMonsterId
ResolveStepDamageMessage::
Jump_036_4806:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wResolveMsgFlags]
    bit 7, a
    jr z, .call_resolve_step_damage_message_set_sub
    bit 4, a
    jr z, .read_resolve_msg_target
    ld a, [wResolveMsgActor]
    ld [wTemp0], a
    ld a, [wResolveMsgFlags]
    bit 3, a
    call nz, ResolveStepDamageMessage_TargetOnLocalSide_Bank36
    jr .check_battle_action_id

.read_resolve_msg_target:
    ld a, [wResolveMsgTarget]
    ld [wTemp0], a
    ld a, [wResolveMsgArg]
    bit 3, a
    call nz, ResolveStepDamageMessage_ActorOnLocalSide_Bank36

.check_battle_action_id:
    ld a, [wBattleActionId]
    cp a, $DC
    jr z, .call_resolve_step_damage_message_set_sub
    cp a, $D7
    jr nz, .read_temp0
    farcall ResolveStepDamageMessage_AddAx9ToHL

.read_temp0:
    ld a, [wTemp0]
    ld d, a
    farcall ShowBattleText

.call_resolve_step_damage_message_set_sub:
    call ResolveStepDamageMessage_SetSubPhase3AndRestartResolve
    ld a, [wResolveMsgFlags]
    bit 4, a
    jr nz, .check_battle_action_id2
    ret

.check_battle_action_id2:
    ld a, [wBattleActionId]
    cp a, $3A
    jr z, .read_battle_target
    cp a, $3B
    jr z, .skip
    cp a, $B8
    jr z, .skip
    cp a, $32
    jr z, .read_battle_actor2
    cp a, $77
    jr z, .read_battle_actor2
    cp a, $DC
    jr z, .read_battle_actor3
    cp a, $DF
    jr z, .call_actor_formation_slot_to_temp0
    ret

.read_battle_target:
    ld a, [wBattleTarget]
    add a, a
    ld de, wBattleMonsterId
    add a, e
    ld e, a
    jr nc, .read_battle_actor
    inc d

.read_battle_actor:
    ld a, [wBattleActor]
    ld b, a
    call LoadBattleMonsterPictureForSlotB
    call ResolveStepDamageMessage_WaitLinkMode
    ret

.skip:
    ld de, wTemp0
    ld a, $60
    ld [de], a
    inc de
    ld a, $01
    ld [de], a
    dec de
    ld a, [wBattleActor]
    ld b, a
    call LoadBattleMonsterPictureForSlotB
    ret

.call_actor_formation_slot_to_temp0:
    farcall ActorFormationSlotToTemp0
    ldh a, [hTemp0]
    call SetBit1OfLevelUpGainsIndexed_Bank36

.read_battle_actor2:
    ld a, [wBattleActor]
    call SetBit1OfLevelUpGainsIndexed_Bank36
    ret

.read_battle_actor3:
    ld a, [wBattleActor]
    push af
    farcall ActorFormationSlotToTemp0
    ldh a, [hTemp0]
    ld [wBattleActor], a
    call ResolveStepDamageMessage_LoadBattleMonsterPictureForSlotB
    pop af
    ld [wBattleActor], a

; only called from ResolveStepDamageMessage (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepDamageMessage)
; reads: wBattleActor
; points at: wTemp0
ResolveStepDamageMessage_LoadBattleMonsterPictureForSlotB::
Func_036_48CB:: ; address name
    ld de, wTemp0
    ld a, $61
    ld [de], a
    inc de
    ld a, $01
    ld [de], a
    dec de
    ld a, [wBattleActor]
    ld b, a
    call LoadBattleMonsterPictureForSlotB
    ret

; resolve step $0B: wBattleActionId $82 jumps to 36:4A9D; $83, $84 and $B3 jump to 36:4B16; any other action advances wBattleResolveStep and returns (E-0050)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActionId, wBattleSubStep, wSoundChannelSlots, wBattleSubPhase, wResolveMsgFlags, wResolveMsgTarget, wResolveMsgActor
; writes: wBattleResolveStep, wBattleSubStep
; points at: wBattleResolveStep, wSoundChannel1, wBattleSubPhase
ResolveStepBranchOnAction::
Jump_036_48DE:: ; address name
    ld a, [wBattleActionId]
    cp a, $82
    jp z, ResolveStepDamageMessage_ActorOnLocalSide_Bank36_ReadSoundChannelSlots
    cp a, $83
    jp z, ResolveStepDamageMessage_ActorOnLocalSide_Bank36_ReadBattleSubStep
    cp a, $84
    jp z, ResolveStepDamageMessage_ActorOnLocalSide_Bank36_ReadBattleSubStep
    cp a, $B3
    jp z, ResolveStepDamageMessage_ActorOnLocalSide_Bank36_ReadBattleSubStep
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; resolve step $0C: farcalls ApplyDamageToTarget
; no direct call (reached through a table, a jump or a vector)
ResolveStepApplyDamage::
Jump_036_48FA:: ; address name
    farcall ApplyDamageToTarget
    ret

; resolve step $0D: runs the defeat sequence Func_032_5A3A (RunDefeatSequence); the first fight showed 'was defeated!' (category 1, index 139) at this step
; no direct call (reached through a table, a jump or a vector)
ResolveStepDefeat::
Jump_036_4901:: ; address name
    farcall RunDefeatSequence
    ret

; resolve step $0E: farcalls ResolveStep0EEffect in bank $32 (E-0053)
; no direct call (reached through a table, a jump or a vector)
ResolveStep0ECallEffect::
Jump_036_4908:: ; address name
    farcall ResolveStep0EEffect
    ret

; resolve step $0F: increments wBattleSubPhase and sets wBattleResolveStep to 0 (E-0050)
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep
; points at: wBattleSubPhase
ResolveStepAdvanceSubPhase::
Jump_036_490F:: ; address name
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleResolveStep], a
    ret

; farcalls RunBattleResolveStep_Case05_Sub01_Sub01 (not read) and returns the comparison of wC5E7 with hFFC6 (taken as 4 when hFFC6 is 3): carry set when wC5E7 is below that value (E-0052)
; 1 call site from 1 routine (e.g. ResolveStepChanceRoll)
; reads: hTemp0, wRandomLo
RollRandomLoBelowChance::
Func_036_4918:: ; address name
    push bc
    push hl
    farcall RollRandomLoBelowChance_WriteTemp0
    pop hl
    pop bc
    ldh a, [hTemp0]
    ld b, a
    cp a, $03
    jr nz, .check_random_lo
    ld b, $04

.check_random_lo:
    ld a, [wRandomLo]
    cp a, b
    ret

; returns RandomInRange(HL - HL/20, HL + HL/20) in DE (E-0120)
; 3 call sites from 3 routines (e.g. ActionEffect_Massacre, ActionEffect_EvilSlash, ResolveStepComputeDamage)
RandomWithin5PercentOfHL::
Func_036_4930:: ; address name
    push hl
    ld bc, $0014
    call DivideHLByBC
    ld e, l
    ld d, h
    pop bc
    push bc
    add hl, bc
    ld c, l
    ld b, h
    pop hl
    ld a, e
    cpl
    add a, $01
    ld e, a
    ld a, d
    cpl
    adc a, $00
    ld d, a
    add hl, de
    call RandomInRange
    ret

; only called from ResolveStepComputeDamage (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepComputeDamage)
ResolveStepComputeDamage_RandomInRange::
Func_036_494E:: ; address name
    ld c, l
    ld b, h
    srl b
    rr c
    sla l
    rl h
    push hl
    add hl, bc
    ld c, l
    ld b, h
    pop hl
    call RandomInRange
    ret

; only called from routines of ResolveStepDamageMessage (E-0098)
; 2 call sites from 2 routines (e.g. ResolveStepDamageMessage_ActorOnLocalSide_Bank36, ResolveStepDamageMessage)
; reads: wResolveMsgFlags, wFollowUpAction, wDefeatByteBF, wDefeatByteD1, wBattleActor
; writes: wBattleTarget, wDefeatByteD1
; points at: wBattleTargetChoice
ResolveStepDamageMessage_SetSubPhase3AndRestartResolve::
Func_036_4961:: ; address name
    ld a, [wResolveMsgFlags]
    bit 4, a
    ret nz
    ld a, [wFollowUpAction]
    or a, a
    ret nz
    call SetSubPhase3AndRestartResolve
    ld a, [wDefeatByteBF]
    or a, a
    ret z
    ld a, [wDefeatByteD1]
    cp a, $FF
    ret z
    ld [wBattleTarget], a
    ld b, a
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld [hl], b
    ld a, $FF
    ld [wDefeatByteD1], a
    ret

; only called from ResolveStepDamageMessage (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepDamageMessage)
; reads: wBattleActionId, wDefeatByteBF, wResolveMsgActor
; writes: wTemp0
; points at: wTemp0, wBattleDamageLo
ResolveStepDamageMessage_TargetOnLocalSide_Bank36::
Func_036_4991:: ; address name
    ld a, [wBattleActionId]
    cp a, $6C
    jr nz, .check_defeat_byte_bf

.loop:
    call TargetOnLocalSide_Bank36
    ret nc
    ld hl, wTemp0
    inc [hl]
    ret

.check_defeat_byte_bf:
    ld a, [wDefeatByteBF]
    bit 0, a
    jr nz, .loop
    call ActorOnLocalSide_Bank36
    ret c
    ld a, [wBattleActionId]
    cp a, $34
    jr z, .done
    cp a, $AD
    jr z, .done
    cp a, $78
    jr z, .done
    cp a, $13
    jr z, .loop3
    cp a, $14
    jr z, .loop3
    cp a, $15
    jr z, .skip
    cp a, $2B
    jr z, .set_temp0_to_CD
    cp a, $2C
    jr z, .set_temp0_to_CD
    cp a, $79
    jr z, .loop3
    cp a, $80
    jr z, .set_temp0_to_56
    cp a, $92
    jr z, .set_temp0_to_63
    cp a, $B5
    jr z, .check_resolve_msg_actor
    cp a, $BA
    jr z, .set_temp0_to_78
    cp a, $BF
    jr z, .done
    cp a, $C0
    jr z, .done
    cp a, $C9
    jr z, .done
    cp a, $CA
    jr z, .done
    cp a, $CB
    jr z, .done

.loop2:
    ld hl, wTemp0
    inc [hl]
    ret

.done:
    ld hl, wTemp0
    dec [hl]
    ret

.loop3:
    ld a, $8A
    ld [wTemp0], a
    ret

.set_temp0_to_56:
    ld a, $56
    ld [wTemp0], a
    ret

.set_temp0_to_63:
    ld a, $63
    ld [wTemp0], a
    ret

.skip:
    ld hl, wBattleDamageLo
    ld a, [hl+]
    sub a, $E8
    ld a, [hl]
    sbc a, $03
    jr z, .loop3
    ld hl, wTemp0
    inc [hl]
    ret

.set_temp0_to_CD:
    ld a, $CD
    ld [wTemp0], a
    ret

.check_resolve_msg_actor:
    ld a, [wResolveMsgActor]
    cp a, $73
    jr z, .loop2
    jr .done

.set_temp0_to_78:
    ld a, $78
    ld [wTemp0], a
    ret

; only called from ResolveStepDamageMessage (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepDamageMessage)
; reads: wBattleActionId
; writes: wTemp0
; points at: wTemp0
ResolveStepDamageMessage_ActorOnLocalSide_Bank36::
Func_036_4A38:: ; address name
    call ActorOnLocalSide_Bank36
    ret c
    ld a, [wBattleActionId]
    cp a, $72
    jr z, .set_temp0_to_6A
    cp a, $73
    jr z, .set_temp0_to_6A
    cp a, $74
    jr z, .set_temp0_to_6A
    cp a, $75
    jr z, .set_temp0_to_6B
    cp a, $7E
    jr z, .set_temp0_to_6C
    cp a, $7F
    jr z, .set_temp0_to_6D
    cp a, $80
    jr z, .set_temp0_to_6E
    cp a, $8B
    jr z, .set_temp0_to_6E
    cp a, $8C
    jr z, .set_temp0_to_6E
    cp a, $8F
    jr z, .set_temp0_to_71
    cp a, $AA
    jr z, .set_temp0_to_71
    cp a, $C0
    jr z, .done
    ld hl, wTemp0
    inc [hl]
    ret

.set_temp0_to_6A:
    ld a, $6A
    ld [wTemp0], a
    ret

.set_temp0_to_6B:
    ld a, $6B
    ld [wTemp0], a
    ret

.set_temp0_to_6C:
    ld a, $6C
    ld [wTemp0], a
    ret

.set_temp0_to_6D:
    ld a, $6D
    ld [wTemp0], a
    ret

.set_temp0_to_6E:
    ld a, $6E
    ld [wTemp0], a
    ret

.set_temp0_to_71:
    ld a, $71
    ld [wTemp0], a
    ret

.done:
    ld hl, wTemp0
    dec [hl]
    ret

ResolveStepDamageMessage_ActorOnLocalSide_Bank36_ReadSoundChannelSlots::
Jump_036_4A9D:: ; address name
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannel1
    and a, [hl]
    cp a, $FF
    ret nz
    ld a, [wBattleSubStep]
    or a, a
    jr z, .call_resolve_step_damage_message_sub04_sub01
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep], a
    call ResolveStepDamageMessage_Sub04_RollTargetSlotResistancesByte1Bits01Chance
    ld a, [wBattleSubPhase]
    cp a, $05
    ret z
    ld a, [wResolveMsgFlags]
    bit 4, a
    ld a, $99
    call nz, QueueSoundEffect
    ld a, [wResolveMsgTarget]
    ld d, a
    ld a, [wResolveMsgFlags]
    bit 4, a
    jr z, .call_resolve_step_damage_message_set_sub
    ld a, [wResolveMsgActor]
    ld d, a
    farcall ShowBattleText

.call_resolve_step_damage_message_set_sub:
    call ResolveStepDamageMessage_SetSubPhase3AndRestartResolve
    ret

.call_resolve_step_damage_message_sub04_sub01:
    call ResolveStepDamageMessage_Sub04_Sub01_GetBaseAGLOfSlotA_Sub01
    ld a, [wResolveMsgFlags]
    bit 4, a
    ld a, $87
    call nz, QueueSoundEffect
    ld a, [wResolveMsgFlags]
    bit 4, a
    jr z, .read_resolve_msg_target
    ld a, [wResolveMsgActor]
    ld d, a
    call ActorOnLocalSide_Bank36
    jr c, .call_show_battle_text
    ld d, $CD
    jr .call_show_battle_text

.read_resolve_msg_target:
    ld a, [wResolveMsgTarget]
    ld d, a

.call_show_battle_text:
    farcall ShowBattleText
    ld a, $01
    ld [wBattleSubStep], a
    ret

ResolveStepDamageMessage_ActorOnLocalSide_Bank36_ReadBattleSubStep::
Jump_036_4B16:: ; address name
    ld a, [wBattleSubStep]
    rst $00
    dw ResolveStepDamageMessage_Sub04_ShowTheWindAroundHero
    dw ResolveStepDamageMessage_Sub04_ShowHeroTurnedBackTo
    dw ResolveStepDamageMessage_Sub04_LoadBattleMonsterPictureForSlotB
    dw ResolveStepDamageMessage_Sub04_ShowHeroWentAway
    dw ResolveStepDamageMessage_Sub04_AddAx9ToHL
    dw ResolveStepDamageMessage_Sub04_WriteBattleResolveStepAndBattleSubStepEtc

; entry 0 of the `rst $00` table in Func_036_4A38
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; points at: wBattleSubStep, wBattleStatus2
ResolveStepDamageMessage_Sub04_ShowTheWindAroundHero::
Jump_036_4B26:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit 6, [hl]
    ret z
    res 6, [hl]
    ld d, $80 ; battle text 'The wind around 0 died!'
    farcall ShowBattleText
    ret

; entry 1 of the `rst $00` table in Func_036_4A38
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleStatResultLo, wBattleStatResultHi
; writes: wBattleArg0
; points at: wBattleSubStep, wBattleStatus1, wSideControl, wBattleMaxHP, wBattleHP, wBattleMaxMP, wBattleMP, wBattleATK, ...
ResolveStepDamageMessage_Sub04_ShowHeroTurnedBackTo::
Jump_036_4B41:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    ld a, [hl]
    and a, $30
    jp z, .read_battle_target3
    ld a, [hl]
    and a, $CF
    ld [hl], a
    ld hl, wBattleSubStep
    dec [hl]
    ld d, $5F ; battle text '0 turned back to normal!'
    farcall ShowBattleText
    push hl
    farcall CancelTargetActionUnlessSpecial
    ld a, [wBattleTarget]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    and a, $F8
    ld [hl], a
    pop hl
    ld a, $01
    ld [wBattleArg0], a
    ld a, [wBattleTarget]
    ld c, a
    farcall LoadSlotSkillsFromBattlerRecord
    call RecomputeTargetStatsFromRecord
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseHP
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    ld a, [wBattleTarget]
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank36
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wBattleTarget]
    call GetBattleHP
    call CompareHLToBC
    jr c, .read_battle_target
    ld a, [wBattleTarget]
    call SetBit0OfLevelUpGainsIndexed_Bank36
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank36
    ld [hl], c
    inc hl
    ld [hl], b

.read_battle_target:
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseMP
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    ld a, [wBattleTarget]
    ld hl, wBattleMaxMP
    call AddDoubleAToHL_Bank36
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wBattleTarget]
    call GetBattleMP
    call CompareHLToBC
    jr c, .read_battle_target2
    ld a, [wBattleTarget]
    call SetBit1OfLevelUpGainsIndexed_Bank36
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    ld [hl], c
    inc hl
    ld [hl], b

.read_battle_target2:
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseATK
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    ld a, [wBattleTarget]
    ld hl, wBattleATK
    call AddDoubleAToHL_Bank36
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseINT
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    ld a, [wBattleTarget]
    ld hl, wBattleINT
    call AddDoubleAToHL_Bank36
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wBattleTarget]
    ld c, a
    farcall SetSlotAIModeFromINT
    ld a, [wBattleTarget]
    ld c, a
    farcall SlotField17OrMonsterCFF5
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wBattleLevel
    add_a_to_hl
    ld [hl], c
    ld a, [wBattleTarget]
    ld c, a
    farcall SlotField2DOrMonsterD002
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wSlotPersonalityHi
    add_a_to_hl
    ld [hl], c
    ld a, [wBattleTarget]
    ld c, a
    farcall SlotField30OrMonsterD004
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wSlotPersonalityMid
    add_a_to_hl
    ld [hl], c
    ld a, [wBattleTarget]
    ld c, a
    farcall SlotField2EOrMonsterD003
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wSlotPersonalityLo
    add_a_to_hl
    ld [hl], c
    ld a, [wBattleTarget]
    ld c, a
    farcall SlotField2FOrMonsterD005
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wSlotTrait
    add_a_to_hl
    ld [hl], c

.read_battle_target3:
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseAGL
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    ld a, [wBattleTarget]
    ld hl, wBattleAGL
    call AddDoubleAToHL_Bank36
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseDEF
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    ld a, [wBattleTarget]
    ld hl, wBattleDEF
    call AddDoubleAToHL_Bank36
    ld [hl], c
    inc hl
    ld [hl], b
    ret

; for a target other than slot 3/7: wD868 = its record field $31 address, wD86A = its wDA72 record, then far-calls Func_019_44B9 (E-0124)
; 1 call site from 1 routine (e.g. ResolveStepDamageMessage_Sub04_ShowHeroTurnedBackTo)
; reads: wBattleTarget
; writes: wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3
; points at: wSlotResistances
RecomputeTargetStatsFromRecord::
Func_036_4D0C:: ; address name
    ld a, [wBattleTarget]
    ld b, a
    and a, $03
    cp a, $03
    ret z
    ld a, b
    ld e, $31
    call BattlerRecordFieldAddress
    ld a, l
    ld [wBattleArg0], a
    ld a, h
    ld [wBattleArg1], a
    ld a, [wBattleTarget]
    ld de, wSlotResistances
    ld b, a
    add a, a
    add a, b
    add a, a
    add a, b
    add a, e
    ld e, a
    jr nc, .set_battle_arg2
    inc d

.set_battle_arg2:
    ld a, e
    ld [wBattleArg2], a
    ld a, d
    ld [wBattleArg3], a
    farcall LoadBattleArg0PointersThenRunPackResistanceFieldsToDE
    ret

; entry 2 of the `rst $00` table in Func_036_4A38
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wLinkMode
; points at: wBattleSubStep, wBattleMonsterId, wSlotMarks, wSlotNameBytes
ResolveStepDamageMessage_Sub04_LoadBattleMonsterPictureForSlotB::
Jump_036_4D42:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wBattleTarget]
    ld b, a
    add a, a
    ld de, wBattleMonsterId
    add a, e
    ld e, a
    jr nc, .call_load_battle_monster_picture_for_slot_b
    inc d

.call_load_battle_monster_picture_for_slot_b:
    call LoadBattleMonsterPictureForSlotB
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $03
    ld a, [wLinkMode]
    cp a, $01
    ret z
    ld a, [wBattleTarget]
    cp a, $04
    ret c
    and a, $03
    cp a, $03
    ret z
    ld hl, wSlotNameBytes
    add_a_to_hl
    ld [hl], $FF
    ret

; entry 3 of the `rst $00` table in Func_036_4A38
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; points at: wBattleSubStep, wBattleSlotOut, wSlotMarks, wBattleStatus, wSideFlags0
ResolveStepDamageMessage_Sub04_ShowHeroWentAway::
Jump_036_4D7F:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wBattleTarget]
    and a, $03
    cp a, $03
    ret nz
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    ret c
    ld d, $7F ; battle text '0 went away!'
    farcall ShowBattleText
    ld a, [wBattleTarget]
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld [hl], $FF
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $FF
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, [wBattleTarget]
    and a, $04
    rrca
    rrca
    and a, $01
    ld hl, wSideFlags0
    res 2, [hl]
    ret

; entry 4 of the `rst $00` table in Func_036_4A38
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wQueuedActionId, wBattleByteAD
; points at: wBattleSubStep, wBattleStatus8
ResolveStepDamageMessage_Sub04_AddAx9ToHL::
Jump_036_4DD6:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wBattleStatus8
    call AddAx9ToHL
    bit 4, [hl]
    ret z
    res 4, [hl]
    ld a, $FF
    ld [wQueuedActionId], a
    ld a, $FF
    ld [wBattleByteAD], a
    ret

; entry 5 of the `rst $00` table in Func_036_4A38
; no direct call (reached through a table, a jump or a vector)
; reads: wSideFlags0, wSideFlags1, wBattleActionId
; writes: wBattleResolveStep, wBattleSubStep, wSideFlags0, wSideFlags1
; points at: wBattleSubPhase
ResolveStepDamageMessage_Sub04_WriteBattleResolveStepAndBattleSubStepEtc::
Jump_036_4DF3:: ; address name
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep], a
    ld a, [wSideFlags0]
    and a, $93
    ld [wSideFlags0], a
    ld a, [wSideFlags1]
    and a, $93
    ld [wSideFlags1], a
    ld a, [wBattleActionId]
    cp a, $83
    ret z
    ld a, [wSideFlags0]
    or a, $08
    ld [wSideFlags0], a
    ld a, [wSideFlags1]
    or a, $08
    ld [wSideFlags1], a
    ret

; loads the picture of battle slot B (species at DE) into its picture area at vTiles2 + $140 + $240 * position and, on CGB, its attributes (E-0128)
; 5 call sites from 4 routines (e.g. ActionEffect_Vivify, ResolveStepDamageMessage_LoadBattleMonsterPictureForSlotB, ResolveStepDamageMessage, ResolveStepDamageMessage_Sub04_LoadBattleMonsterPictureForSlotB)
; reads: wLinkMode, wLinkRole, wIsCGB, wBattleFoeCount, wSide1Flag, wSide0Flag
; writes: wBGPaletteUploadRequest, hTemp0
LoadBattleMonsterPictureForSlotB::
Func_036_4E26:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    ld a, b
    jr nz, .cp_04
    ld a, [wLinkRole]
    bit 1, a
    ld a, b
    jr z, .cp_04
    cp a, $03
    jr nc, .return
    jr .skip

.cp_04:
    cp a, $04
    jr c, .return
    cp a, $07
    jr z, .return
    sub a, $04

.skip:
    push de
    push af
    ld bc, $0240
    call Multiply8By16
    ld bc, vTiles2 + $140
    add hl, bc
    pop af
    pop de
    sla a
    add a, $01
    ld c, a
    push bc
    ld a, [de]
    ld b, a
    inc de
    ld a, [de]
    ld d, a
    ld e, b
    push de
    call LoadMonsterPicture
    pop de
    pop bc
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    ld a, c
    ldh [hTemp0], a
    ld a, [wLinkMode]
    cp a, $01
    ld a, [wBattleFoeCount]
    jr nz, .cp_01
    ld a, [wLinkRole]
    bit 1, a
    ld a, [wSide1Flag]
    jr z, .cp_01
    ld a, [wSide0Flag]

.cp_01:
    cp a, $01
    jr z, .skip2
    cp a, $03
    jr z, .skip3
    ld hl, vBGMap0 + $E4
    jr .skip4

.skip2:
    ld hl, vBGMap0 + $E7
    jr .skip4

.skip3:
    ld hl, vBGMap0 + $E1

.skip4:
    ld a, c
    sub a, $01
    srl a
    ld b, a
    add a, a
    add a, b
    add a, a
    add_a_to_hl
    call LoadMonsterPictureAttributes

.return:
    ret

; only called from routines of ResolveStepTargetAndSubEffects (E-0098)
; 2 call sites from 2 routines (e.g. ResolveStepTargetAndSubEffects_Case00_WriteDefeatStepAndResolveByte81, ResolveStepTargetAndSubEffects_Case00_ShowTheWindAroundHero)
; reads: wBattleActor, wBattleTarget, wDefeatFlagsBA, wFollowUpAction
; writes: wBattleActor, wBattleTarget, wFollowUpAction
; points at: wSavedActorTarget, wBattleActionChoice
ResolveStepTargetAndSubEffects_WriteBattleActorAndBattleTargetEtc::
Func_036_4EB1:: ; address name
    push de
    ld hl, wSavedActorTarget
    ld a, [wBattleActor]
    ld [hl+], a
    ld a, [wBattleTarget]
    ld [hl+], a
    ld a, [wDefeatFlagsBA]
    ld [hl+], a
    ld a, [wBattleActor]
    ld de, wBattleActionChoice
    add a, a
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    ld a, [wBattleTarget]
    ld bc, wBattleActionChoice
    add a, a
    add a, c
    ld c, a
    jr nc, .skip2
    inc b

.skip2:
    ld a, [bc]
    ld [hl+], a
    inc bc
    ld a, [bc]
    ld [hl+], a
    ld a, [wBattleActor]
    ld [bc], a
    dec bc
    dec de
    ld a, [de]
    ld [bc], a
    ld a, [wBattleActor]
    ld l, a
    ld a, [wBattleTarget]
    ld h, a
    ld a, h
    ld [wBattleActor], a
    ld a, l
    ld [wBattleTarget], a
    pop de
    bit 0, d
    jr nz, .check_follow_up_action
    bit 2, d
    jr nz, .check_follow_up_action
    jr .check_follow_up_action

.check_follow_up_action:
    ld a, [wFollowUpAction]
    or a, d
    ld [wFollowUpAction], a
    ret

; the same 10 bytes as SetSubPhase3AndRestartResolve (36:5009)
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleSubPhase, wBattleResolveStep
SetSubPhase3AndRestartResolve_Bank36:: ; heuristic: follows a terminator; C0
Func_036_4F0E:: ; address name
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

; only called from ResolveStepTargetAndSubEffects_Case00_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepTargetAndSubEffects_Case00_SlotHasStatus3Or4Bits_Bank36)
; reads: wBattleTarget, wResolveByte71, wRandomLo
; points at: wSlotFlags854, wSlotChoices
ResolveStepTargetAndSubEffects_Case00_Sub01_ReadBattleTargetAndResolveByte71Etc::
Func_036_4F18:: ; address name
    ld a, [wBattleTarget]
    ld hl, wSlotFlags854
    add a, a
    add_a_to_hl
    bit 5, [hl]
    jr z, .call_advance_random
    ld a, [wResolveByte71]
    scf
    ccf
    ret

.call_advance_random:
    call AdvanceRandom
    ld a, [wRandomLo]
    cp a, $33
    jp c, PickRandomEntryOfSlotChoices_ReturnCarry
    cp a, $66
    jr c, PickRandomEntryOfSlotChoices_Skip
    ld a, $FF
    ld hl, wSlotChoices
    ld bc, $0003
    call FillBytes
    ld a, [wBattleTarget]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, e
    ld hl, wSlotChoices
    add_a_to_hl
    ld [hl], c
    inc e

.next:
    inc c
    dec b
    jr nz, .loop

; A = a random one of the first E bytes at wD86D (no carry); the next entry lists the target's other occupied ally slots there and carries when none (E-0127)
; 1 call site from 1 routine (e.g. PickRandomEntryOfSlotChoices)
; points at: wSlotChoices
PickRandomEntryOfSlotChoices::
Func_036_4F69:: ; address name
    ld hl, $0000
    ld b, $00
    dec e
    ld c, e
    call RandomInRange
    ld a, e
    ld hl, wSlotChoices
    add_a_to_hl
    ld a, [hl]
    scf
    ccf
    ret

PickRandomEntryOfSlotChoices_Skip::
Jump_036_4F80:: ; address name
    ld a, $FF
    ld hl, wSlotChoices
    ld bc, $0003
    call FillBytes
    ld a, [wBattleTarget]
    ld d, a
    ld a, [wBattleTarget]
    and a, $04
    ld c, a
    ld b, $03
    ld e, $00

.loop:
    ld a, c
    cp a, d
    jr z, .next
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, e
    ld hl, wSlotChoices
    add_a_to_hl
    ld [hl], c
    inc e

.next:
    inc c
    dec b
    jr nz, .loop
    ld a, e
    or a, a
    jr z, PickRandomEntryOfSlotChoices_ReturnCarry
    call PickRandomEntryOfSlotChoices
    ret

PickRandomEntryOfSlotChoices_ReturnCarry::
Jump_036_4FBA:: ; address name
    scf
    ret

; only called from ResolveStepEffectChecks (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepEffectChecks)
ResolveStepEffectChecks_ShowMissHeroAvoidedDamage::
Func_036_4FBC:: ; address name
    ld a, $84
    call QueueSoundEffect
    call ActorOnLocalSide_Bank36
    ld d, $D0
    jr c, .call_show_battle_text
    ld d, $D1 ; battle text 'Miss! 0 avoided damage!'

.call_show_battle_text:
    farcall ShowBattleText
    ret

; for action $CC clears bits 0-1 of the actor's wD810 byte when bits 2-3 equal 4; for an action in $D0-$E3 it farcalls Func_0A3_413F first. Then it sets wBattleSubPhase to 2 and clears wBattleResolveStep (E-0055)
; 8 call sites from 7 routines (e.g. ResolveStepEffectChecks, ResolveStepFlagBit7Effect, ResolveStepTargetAndSubEffects_TargetOnLocalSide_Bank36, ResolveStepTargetAndSubEffects_Case00_ShowButItFailedTo, ...)
; reads: wBattleActionId, wBattleActor
; writes: wBattleSubPhase, wBattleResolveStep
; points at: wBattleStatus4
SetSubPhase2AndRestartResolve::
Func_036_4FD1:: ; address name
    ld a, [wBattleActionId]
    cp a, $CC
    jr z, .read_battle_actor
    ld a, [wBattleActionId]
    cp a, $D0
    jr c, .loop
    cp a, $E4
    jr nc, .loop
    farcall RunA3414FAndMarkWDA5B3

.loop:
    ld a, $02
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    cp a, $04
    jr nz, .loop
    ld a, [hl]
    and a, $F3
    ld [hl], a
    jr .loop

; sets wBattleSubPhase to 3 and clears wBattleResolveStep (E-0055)
; 2 call sites from 2 routines (e.g. ResolveStepDamageMessage_SetSubPhase3AndRestartResolve, ResolveStepEffectChecks)
; writes: wBattleSubPhase, wBattleResolveStep
SetSubPhase3AndRestartResolve::
Func_036_5009:: ; address name
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

; AdvanceRandom, then BC = the target's DEF (wBattleDEF) / 2 and falls into ComputeBasicDamage with HL = the actor's ATK (E-0064)
; 17 call sites from 16 routines (e.g. AttackDamageTimes1_5IfSlotDamageFlagsBit0, ComputeAttackDamageWithHalvedDEF, AttackDamageScaledBySlotResistancesByte1Bits32, AttackDamageScaledBySlotResistancesByte1Bits54, ...)
; reads: wBattleTarget, wBattleActor
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleDEF
ComputeAttackDamage:: ; code pointer of the table EffectHandlerTable; C0
Func_036_5013:: ; address name
    call AdvanceRandom
    ld a, [wBattleTarget]
    ld hl, wBattleDEF
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    call ShiftBCRight1

; the damage formula: HL = the acting slot's value from the array at wD8FF (Func_036_7E2E), BC = the value to compare with, set by the caller. If HL <= BC the damage is RandomInRange(0, 1). Otherwise, with half = (HL - BC) / 2: when HL / 16 >= half the damage is RandomInRange(0, HL / 16); else it is half + RandomInRange(-(half / 16), half / 16) + RandomInRange(-1, 1). The 16-bit result goes to wBattleDamageLo/Hi. The divisors are 16, not 4: ShiftHLRight4 falls through two more shifts (corrected in E-0064)
; 3 call sites from 2 routines (e.g. ActionEffect_BiAttack_ShiftHLRight1, ActionEffect_ActionD7_AdvanceRandom)
; reads: wBattleActor
; writes: wBattleDamageLo, wBattleDamageHi
ComputeBasicDamage::
Func_036_5025:: ; address name
    ld a, [wBattleActor]
    call GetBattleATK
    call CompareHLToBC
    jr z, .call_random_in_range
    jr c, .call_random_in_range
    ld a, l
    sub a, c
    ld e, a
    ld a, h
    sbc a, b
    ld d, a
    srl d
    rr e
    push hl
    push bc
    ld b, d
    ld c, e
    call ShiftHLRight4
    call CompareHLToBC
    pop bc
    pop hl
    jr z, .call_shift_hl_right4
    jr nc, .call_shift_hl_right4
    jr .skip

.call_random_in_range:
    ld hl, $0000
    ld bc, $0001
    call RandomInRange
    jr .set_battle_damage_lo

.call_shift_hl_right4:
    call ShiftHLRight4
    ld c, l
    ld b, h
    ld hl, $0000
    call RandomInRange
    jr .set_battle_damage_lo

.skip:
    ld l, e
    ld h, d
    push hl
    call ShiftHLRight4
    ld c, l
    ld b, h
    ld a, l
    cpl
    add a, $01
    ld l, a
    ld a, h
    cpl
    adc a, $00
    ld h, a
    call RandomInRange
    pop hl
    add hl, de
    push hl
    ld hl, $FFFF
    ld bc, $0001
    call RandomInRange
    pop hl
    add hl, de
    ld e, l
    ld d, h

.set_battle_damage_lo:
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wBattleDamageHi], a
    ret

; only called from ActionEffect_ActionD1 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_ActionD1)
ActionEffect_ActionD1_RollSkillDamageFromRecord::
Func_036_5094:: ; address name
    call RollSkillDamageFromRecord
    ld a, $00
    call ScaleDamageByFlagsAtHL
    ret

; only called from ActionEffect_ActionD2 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_ActionD2)
ActionEffect_ActionD2_SkillDamageScaledBySlotResistancesByte6Bits32::
Func_036_509D:: ; address name
    call SkillDamageScaledBySlotResistancesByte6Bits32
    call GetTargetSpeciesFamily
    cp a, $00
    jr z, .call_scale_damage_by3_over2
    cp a, $08
    jr z, .call_scale_damage_by3_over2
    cp a, $09
    ret nz

.call_scale_damage_by3_over2:
    call ScaleDamageBy3Over2
    ret

; only called from ActionEffect_ActionD3 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_ActionD3)
ActionEffect_ActionD3_SkillDamageScaledBySlotResistancesByte6Bits32::
Func_036_50B2:: ; address name
    call SkillDamageScaledBySlotResistancesByte6Bits32
    call GetTargetSpeciesFamily
    cp a, $01
    jr z, .call_scale_damage_by3_over2
    cp a, $03
    jr z, .call_scale_damage_by3_over2
    cp a, $06
    ret nz

.call_scale_damage_by3_over2:
    call ScaleDamageBy3Over2
    ret

; only called from ActionEffect_ActionD4 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_ActionD4)
ActionEffect_ActionD4_SkillDamageScaledBySlotResistancesByte6Bits32::
Func_036_50C7:: ; address name
    call SkillDamageScaledBySlotResistancesByte6Bits32
    call GetTargetSpeciesFamily
    cp a, $02
    jr z, .call_scale_damage_by3_over2
    cp a, $05
    jr z, .call_scale_damage_by3_over2
    cp a, $04
    ret nz

.call_scale_damage_by3_over2:
    call ScaleDamageBy3Over2
    ret

; only called from ActionEffect_ActionD7 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_ActionD7)
; reads: wBattleActor, wBattleDamageLo, wBattleDamageHi, hTemp0
; writes: wBattleActor, wBattleDamageLo, wBattleDamageHi
ActionEffect_ActionD7_AdvanceRandom::
Func_036_50DC:: ; address name
    ld a, [wBattleActor]
    push af
    call AdvanceRandom
    ld bc, $0000
    call ComputeBasicDamage
    ld a, [wBattleDamageLo]
    ld e, a
    ld a, [wBattleDamageHi]
    ld d, a
    push de
    farcall ActorFormationSlotToTemp0
    ldh a, [hTemp0]
    ld [wBattleActor], a
    call AdvanceRandom
    ld bc, $0000
    call ComputeBasicDamage
    pop de
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    add hl, de
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    pop af
    ld [wBattleActor], a
    ret

; only called from ActionEffect_ActionD8 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_ActionD8)
; reads: wBattleActor, wBattleDamageLo, wBattleDamageHi, hTemp0
; writes: wBattleActor, wBattleDamageLo, wBattleDamageHi
ActionEffect_ActionD8_ComputeAttackDamage::
Func_036_511D:: ; address name
    ld a, [wBattleActor]
    push af
    call ComputeAttackDamage
    ld a, [wBattleDamageLo]
    ld e, a
    ld a, [wBattleDamageHi]
    ld d, a
    push de
    farcall ActorFormationSlotToTemp0
    ldh a, [hTemp0]
    ld [wBattleActor], a
    call ComputeAttackDamage
    pop de
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    add hl, de
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    pop af
    ld [wBattleActor], a
    ret

; only called from ActionEffect_ActionD9 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_ActionD9)
; reads: wBattleActor, wAllMPSpentLo, wAllMPSpentHi, wBattleDamageLo, wBattleDamageHi, hTemp0
; writes: wBattleDamageLo, wBattleDamageHi, wBattleActor
; points at: wBattleLevel
ActionEffect_ActionD9_WriteBattleDamageLoAndBattleDamageHiEtc::
Func_036_5152:: ; address name
    ld a, [wBattleActor]
    push af
    ld a, [wAllMPSpentLo]
    ld l, a
    ld a, [wAllMPSpentHi]
    ld h, a
    add hl, hl
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ld a, e
    ld hl, wBattleLevel
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    add hl, hl
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    add hl, bc
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    farcall ActorFormationSlotToTemp0
    ldh a, [hTemp0]
    ld [wBattleActor], a
    ld a, [wAllMPSpentLo]
    ld l, a
    ld a, [wAllMPSpentHi]
    ld h, a
    add hl, hl
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    add hl, bc
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ld a, e
    ld hl, wBattleLevel
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    add hl, hl
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    add hl, bc
    add hl, hl
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    pop af
    ld [wBattleActor], a
    jp ActionEffect_MegaMagic_WriteBattleDamageLoAndBattleDamageHi_CallScaleHLTo40Percent
    db $C9

; only called from ActionEffect_Blaze (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Blaze)
ActionEffect_Blaze_RollSkillDamageFromRecord::
Func_036_51D1:: ; address name
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte0
    swap a
    and a, $03
    call ScaleDamageByFlagsAtHL
    ret

; only called from ActionEffect_Firebal (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Firebal)
ActionEffect_Firebal_RollSkillDamageFromRecord::
Func_036_51DF:: ; address name
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte0
    rrca
    rrca
    and a, $03
    call ScaleDamageByFlagsAtHL
    ret

; only called from ActionEffect_Bang (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Bang)
ActionEffect_Bang_RollSkillDamageFromRecord::
Func_036_51ED:: ; address name
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte0
    and a, $03
    call ScaleDamageByFlagsAtHL
    ret

; only called from ActionEffect_Infernos (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Infernos)
ActionEffect_Infernos_RollSkillDamageFromRecord::
Func_036_51F9:: ; address name
    call RollSkillDamageFromRecord

; level = bits 7-6 of the target's wDA72 byte 1, then ScaleDamageByFlagsAtHL (HL from the caller) (E-0115)
; 2 call sites from 2 routines (e.g. ActionEffect_Vacuum_ShiftBCRight1, ActionEffect_WindBeast_ShiftBCRight1)
ScaleDamageBySlotResistancesByte1Bits76::
Func_036_51FC:: ; address name
    call GetTargetSlotResistancesByte1
    rlca
    rlca
    and a, $03
    call ScaleDamageByFlagsAtHL
    ret

; RollSkillDamageFromRecord, then falls into the scale by bits 4-5 of the target's wDA72 byte 1 (E-0126)
; 2 call sites from 2 routines (e.g. ActionEffect_ActionD0, ActionEffect_Bolt)
RollSkillDamageThenScaleBySlotResistancesByte1::
Func_036_5207:: ; address name
    call RollSkillDamageFromRecord

; only called from ActionEffect_Lightning_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Lightning_ShiftBCRight1)
ActionEffect_Lightning_Sub01_GetTargetSlotResistancesByte1::
Func_036_520A:: ; address name
    call GetTargetSlotResistancesByte1
    swap a
    and a, $03
    call ScaleDamageByFlagsAtHL
    ret

; only called from ActionEffect_IceBolt (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_IceBolt)
ActionEffect_IceBolt_RollSkillDamageFromRecord::
Func_036_5215:: ; address name
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte1
    rrca
    rrca
    and a, $03
    call ScaleDamageByFlagsAtHL
    ret

; restores the target's HP by the rolled skill amount, or fully for actions $20, $B1, $7B, $DA (with other cases for $18, $1A, $CF), capped at its max HP (E-0129)
; 2 call sites from 2 routines (e.g. ActionEffect_ActionDA, ActionEffect_Heal)
; reads: wBattleActionId, wBattleDamageLo, wBattleDamageHi, wBattleTarget, wBattleActor, wLinkMode
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleHP, wBattleMaxHP, wHealFlags
HealTargetHP::
Func_036_5223:: ; address name
    ld a, [wBattleActionId]
    cp a, $18
    jp z, .check_link_mode
    cp a, $1A
    jp z, .check_link_mode
    cp a, $20
    jr z, .loop
    cp a, $B1
    jr z, .loop
    cp a, $7B
    jr z, .loop
    cp a, $CF
    jr z, .read_battle_target
    cp a, $DA
    jr z, .loop

.call_roll_skill_damage_from_record:
    call RollSkillDamageFromRecord
    ld a, [wBattleDamageLo]
    ld e, a
    ld a, [wBattleDamageHi]
    ld d, a
    jr .loop2

.loop:
    ld a, [wBattleTarget]
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wBattleDamageHi], a

.loop2:
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank36
    push hl
    deref_hl
    ld a, l
    add a, e
    ld c, a
    ld a, h
    adc a, d
    ld b, a
    ld a, [wBattleTarget]
    call GetBattleMaxHP
    call CompareHLToBC
    jr nc, .restore
    ld b, h
    ld c, l

.restore:
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    scf
    ret

.read_battle_target:
    ld a, [wBattleTarget]
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wBattleDamageHi], a
    ld a, [wBattleActor]
    ld hl, wHealFlags
    add_a_to_hl
    ld a, [hl]
    or a, a
    jr z, .loop2
    push af
    call ScaleDamageTo40Percent
    ld a, [wBattleDamageLo]
    ld e, a
    ld a, [wBattleDamageHi]
    ld d, a
    pop af
    dec a
    jr z, .loop2
    sra d
    rr e
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wBattleDamageHi], a
    jr .loop2

.check_link_mode:
    ld a, [wLinkMode]
    cp a, $01
    jp z, .loop
    ld a, [wBattleActor]
    bit 2, a
    jp z, .loop
    jp .call_roll_skill_damage_from_record

; only called from ActionEffect_MPass (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_MPass)
; reads: wBattleActionId, wBattleTarget
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleMP
ActionEffect_MPass_AddDoubleAToHL_Bank36::
Func_036_52DF:: ; address name
    ld a, [wBattleActionId]
    cp a, $1B
    jr z, .skip
    cp a, $1C
    jr z, .set_battle_damage_lo
    ld de, $0050
    jr .set_battle_damage_lo2

.skip:
    ld de, $000F
    jr .set_battle_damage_lo2

.set_battle_damage_lo:
    ld de, $001E

.set_battle_damage_lo2:
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wBattleDamageHi], a
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    push hl
    deref_hl
    ld a, l
    add a, e
    ld c, a
    ld a, h
    adc a, d
    ld b, a
    ld a, [wBattleTarget]
    call GetBattleMaxMP
    call CompareHLToBC
    jr nc, .restore
    ld b, h
    ld c, l

.restore:
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    scf
    ret
    db $37, $3F, $C9

; only called from ActionEffect_BigBang (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_BigBang)
ActionEffect_BigBang_RollSkillDamageFromRecord::
Func_036_5328:: ; address name
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte0
    swap a
    and a, $03
    call ScaleDamageByFlagsAtHLAlt
    ret

; only called from ActionEffect_FireAir (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_FireAir)
ActionEffect_FireAir_RollSkillDamageFromRecord::
Func_036_5336:: ; address name
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte4
    swap a
    and a, $03
    call ScaleDamageByFlagsAtHLAlt
    ret

; only called from ActionEffect_FrigidAir (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_FrigidAir)
ActionEffect_FrigidAir_RollSkillDamageFromRecord::
Func_036_5344:: ; address name
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte4
    rrca
    rrca
    and a, $03
    call ScaleDamageByFlagsAtHLAlt
    ret

; only called from ActionEffect_RockThrow (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_RockThrow)
ActionEffect_RockThrow_RollSkillDamageFromRecord:: ; code pointer of the table EffectHandlerTable; C0
Func_036_5352:: ; address name
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte6
    swap a
    and a, $03
    call ScaleDamageByFlagsAtHL
    ret

; raises the target's DEF by a third (half for action $25) of its base DEF, limited by the buff cap; the actual gain is stored as damage (E-0128)
; 2 call sites from 2 routines (e.g. ActionEffect_ActionDD, ActionEffect_Upper)
; reads: wBattleTarget, wBattleActionId, wBattleDamageLo, wBattleDamageHi
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleDEF
RaiseTargetDEF::
Func_036_5360:: ; address name
    ld a, [wBattleTarget]
    call SlotDEFBelowBuffCap
    jr nc, .return_0
    jr z, .return_0
    ld a, [wBattleTarget]
    call GetBaseDEFOfSlotA
    ld a, [wBattleActionId]
    cp a, $25
    jr z, .call_shift_bc_right1
    ld l, c
    ld h, b
    call DivideHLBy3
    ld c, l
    ld b, h
    jr .set_battle_damage_lo

.call_shift_bc_right1:
    call ShiftBCRight1

.set_battle_damage_lo:
    ld a, c
    ld [wBattleDamageLo], a
    ld a, b
    ld [wBattleDamageHi], a
    ld a, [wBattleTarget]
    ld hl, wBattleDEF
    call AddDoubleAToHL_Bank36
    ld a, [hl]
    add a, c
    ld [hl+], a
    ld a, [hl]
    adc a, b
    ld [hl], a
    ld a, [wBattleTarget]
    push hl
    call SlotDEFBelowBuffCap
    pop hl
    jr c, .return_carry
    ld a, [hl-]
    ld e, [hl]
    ld d, a
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, e
    sub a, c
    ld e, a
    ld a, d
    sbc a, b
    ld d, a
    ld a, [wBattleDamageLo]
    sub a, e
    ld e, a
    ld a, [wBattleDamageHi]
    sbc a, d
    ld d, a
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wBattleDamageHi], a

.return_carry:
    scf
    ret

.return_0:
    xor a, a
    ret

; level = bits 4-5 of the target's wDA72 byte 3 (stored in wD86A; 4 when forced) returns carry at 4; otherwise rolls the chance (sided for action $8C) (E-0124)
; 2 call sites from 2 routines (e.g. ActionEffect_LushLicks, ActionEffect_Sap)
; reads: wBattleActionId
; writes: wBattleArg2
RollTargetSlotResistancesByte3Bits45Chance::
Func_036_53C6:: ; address name
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte3
    swap a
    and a, $03
    ld [wBattleArg2], a
    call ForceLevel4IfActorSlotFlags854Bit2
    cp a, $04
    jr nz, .check_battle_action_id
    scf
    ret

.check_battle_action_id:
    and a, $03
    ld b, a
    ld a, [wBattleActionId]
    cp a, $8C
    ld a, b
    jr z, .call_roll_chance_by_flags_at_hl_sided
    call RollChanceByFlagsAtHL
    ret

.call_roll_chance_by_flags_at_hl_sided:
    call RollChanceByFlagsAtHLSided
    ret

; only called from ActionEffect_UltraDown_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_UltraDown_SetSlotStatus6Bit7)
; reads: wBattleTarget, wBattleActionId
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleDEF
ActionEffect_UltraDown_Sub02_GetBattleDEF::
Func_036_53EF:: ; address name
    ld a, [wBattleTarget]
    call GetBattleDEF
    ld b, h
    ld c, l
    ld hl, $0001
    call CompareHLToBC
    jr c, .read_battle_target
    xor a, a
    ret

.read_battle_target:
    ld a, [wBattleTarget]
    call GetBaseDEFOfSlotA
    ld a, [wBattleActionId]
    cp a, $27
    jr z, .call_shift_bc_right1
    ld l, c
    ld h, b
    call DivideHLBy3
    ld c, l
    ld b, h
    jr .read_battle_target2

.call_shift_bc_right1:
    call ShiftBCRight1

.read_battle_target2:
    ld a, [wBattleTarget]
    ld hl, wBattleDEF
    call AddDoubleAToHL_Bank36
    push hl
    ld a, [hl+]
    ld h, [hl]
    or a, h
    pop hl
    jr z, .return_0
    ld a, c
    ld [wBattleDamageLo], a
    ld a, b
    ld [wBattleDamageHi], a
    ld a, [hl]
    sub a, c
    ld [hl+], a
    ld a, [hl]
    sbc a, b
    ld [hl], a
    jr nc, .return_carry
    xor a, a
    ld [hl-], a
    ld [hl], a

.return_carry:
    scf
    ret

.return_0:
    xor a, a
    ret

; raises the target's AGL by a third (half for action $29) of its base AGL, limited by the buff cap; the actual gain is stored as damage (E-0128)
; 2 call sites from 2 routines (e.g. ActionEffect_ActionDD, ActionEffect_Speed)
; reads: wBattleTarget, wBattleActionId, wBattleDamageLo, wBattleDamageHi
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleAGL
RaiseTargetAGL::
Func_036_5441:: ; address name
    ld a, [wBattleTarget]
    call SlotAGLBelowBuffCap
    jr nc, .return_0
    ld a, [wBattleTarget]
    call GetBaseAGLOfSlotA
    ld a, [wBattleActionId]
    cp a, $29
    jr z, .call_shift_bc_right1
    ld l, c
    ld h, b
    call DivideHLBy3
    ld c, l
    ld b, h
    jr .set_battle_damage_lo

.call_shift_bc_right1:
    call ShiftBCRight1

.set_battle_damage_lo:
    ld a, c
    ld [wBattleDamageLo], a
    ld a, b
    ld [wBattleDamageHi], a
    ld a, [wBattleTarget]
    ld hl, wBattleAGL
    call AddDoubleAToHL_Bank36
    ld a, [hl]
    add a, c
    ld [hl+], a
    ld a, [hl]
    adc a, b
    ld [hl], a
    ld a, [wBattleTarget]
    push hl
    call SlotAGLBelowBuffCap
    pop hl
    jr c, .return_carry
    dec hl
    ld a, [hl+]
    sub a, c
    ld e, a
    ld a, [hl]
    sbc a, b
    ld d, a
    ld a, b
    ld [hl-], a
    ld [hl], c
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    ld a, c
    sub a, e
    ld e, a
    ld a, b
    sbc a, d
    ld d, a
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wBattleDamageHi], a

.return_carry:
    scf
    ret

.return_0:
    xor a, a
    ret

; level = bits 2-3 of the target's wDA72 byte 3 (forced to 4 by bit 2 of the actor's wD854); level 4 returns carry, otherwise rolls the chance by the flags at HL (E-0122)
; 1 call site from 1 routine (e.g. ActionEffect_Slow)
RollTargetSlotResistancesByte3Bits23Chance::
Func_036_54A7:: ; address name
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte3
    rrca
    rrca
    and a, $03
    call ForceLevel4IfActorSlotFlags854Bit2
    cp a, $04
    jr nz, .call_roll_chance_by_flags_at_hl
    scf
    ret

.call_roll_chance_by_flags_at_hl:
    call RollChanceByFlagsAtHL
    ret

; only called from ResolveStepDamageMessage_Sub04_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepDamageMessage_Sub04_Sub01_GetBaseAGLOfSlotA_Sub01)
; reads: wBattleTarget, wBattleActionId
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleAGL
ResolveStepDamageMessage_Sub04_Sub01_GetBaseAGLOfSlotA::
Func_036_54BE:: ; address name
    ld a, [wBattleTarget]
    call GetBaseAGLOfSlotA
    ld a, [wBattleActionId]
    cp a, $2B
    jr z, .call_shift_bc_right1
    ld l, c
    ld h, b
    call DivideHLBy3
    ld c, l
    ld b, h
    jr .read_battle_target

.call_shift_bc_right1:
    call ShiftBCRight1

.read_battle_target:
    ld a, [wBattleTarget]
    ld hl, wBattleAGL
    call AddDoubleAToHL_Bank36
    push hl
    ld d, $00
    deref_hl
    call CompareHLToBC
    jr nz, .call_compare_hl_to_bc
    ld d, $01

.call_compare_hl_to_bc:
    push bc
    ld bc, $0002
    call CompareHLToBC
    pop bc
    pop hl
    jr c, .return_0
    ld a, c
    sub a, d
    ld c, a
    ld a, b
    sbc a, $00
    ld b, a
    ld a, c
    ld [wBattleDamageLo], a
    ld a, b
    ld [wBattleDamageHi], a
    ld a, [hl]
    ld e, a
    sub a, c
    ld [hl+], a
    ld a, [hl]
    ld d, a
    sbc a, b
    ld [hl], a
    jr nc, .return_carry
    xor a, a
    ld [hl-], a
    ld [hl], $01
    dec de
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wBattleDamageHi], a

.return_carry:
    scf
    ret

.return_0:
    xor a, a
    ret

; ComputeAttackDamage, then ScaleDamageByFlagsAtHLBit6 with HL = the target's wD814 entry and level = bits 5-4 of the target's wDA72 byte 0 (E-0115)
; 1 call site from 1 routine (e.g. ActionEffect_FireSlash)
AttackDamageScaledBySlotResistancesByte0Bits54:: ; code pointer of the table EffectHandlerTable; C0
Func_036_5522:: ; address name
    call ComputeAttackDamage
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte0
    swap a
    and a, $03
    call ScaleDamageByFlagsAtHLBit6
    ret

; ComputeAttackDamage, then ScaleDamageByFlagsAtHLBit6 with HL = the target's wD814 entry and level = bits 7-6 of the target's wDA72 byte 1 (E-0115)
; 1 call site from 1 routine (e.g. ActionEffect_VacuSlash)
AttackDamageScaledBySlotResistancesByte1Bits76:: ; code pointer of the table EffectHandlerTable; C0
Func_036_5533:: ; address name
    call ComputeAttackDamage
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte1
    rlca
    rlca
    and a, $03
    call ScaleDamageByFlagsAtHLBit6
    ret

; ComputeAttackDamage, then ScaleDamageByFlagsAtHLBit6 with HL = the target's wD814 entry and level = bits 5-4 of the target's wDA72 byte 1 (E-0115)
; 1 call site from 1 routine (e.g. ActionEffect_BoltSlash)
AttackDamageScaledBySlotResistancesByte1Bits54:: ; code pointer of the table EffectHandlerTable; C0
Func_036_5544:: ; address name
    call ComputeAttackDamage
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte1
    swap a
    and a, $03
    call ScaleDamageByFlagsAtHLBit6
    ret

; ComputeAttackDamage, then ScaleDamageByFlagsAtHLBit6 with HL = the target's wD814 entry and level = bits 3-2 of the target's wDA72 byte 1 (E-0115)
; 1 call site from 1 routine (e.g. ActionEffect_IceSlash)
AttackDamageScaledBySlotResistancesByte1Bits32:: ; code pointer of the table EffectHandlerTable; C0
Func_036_5555:: ; address name
    call ComputeAttackDamage
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte1
    rrca
    rrca
    and a, $03
    call ScaleDamageByFlagsAtHLBit6
    ret

; when the target's species family (GetTargetSpeciesFamily) is 0 (Slime), damage = ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
; 1 call site from 1 routine (e.g. ActionEffect_SlimeBlow)
; reads: wBattleTarget, wBattleActor
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleDEF
AttackDamageHalvedDEFVsSlime:: ; code pointer of the table EffectHandlerTable; C0
Func_036_5566:: ; address name
    call GetTargetSpeciesFamily
    cp a, $00
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

; when the target's species family (GetTargetSpeciesFamily) is 1 (Dragon), damage = ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
; 1 call site from 1 routine (e.g. ActionEffect_DrakSlash)
; reads: wBattleTarget, wBattleActor
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleDEF
AttackDamageHalvedDEFVsDragon:: ; code pointer of the table EffectHandlerTable; C0
Func_036_5571:: ; address name
    call GetTargetSpeciesFamily
    cp a, $01
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

; when the target's species family (GetTargetSpeciesFamily) is 2 (Beast), damage = ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
; 1 call site from 1 routine (e.g. ActionEffect_BeastCut)
; reads: wBattleTarget, wBattleActor
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleDEF
AttackDamageHalvedDEFVsBeast:: ; code pointer of the table EffectHandlerTable; C0
Func_036_557C:: ; address name
    call GetTargetSpeciesFamily
    cp a, $02
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

; when the target's species family (GetTargetSpeciesFamily) is 3 (Bird), damage = ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
; 1 call site from 1 routine (e.g. ActionEffect_BirdBlow)
; reads: wBattleTarget, wBattleActor
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleDEF
AttackDamageHalvedDEFVsBird:: ; code pointer of the table EffectHandlerTable; C0
Func_036_5587:: ; address name
    call GetTargetSpeciesFamily
    cp a, $03
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

; when the target's species family (GetTargetSpeciesFamily) is 5 (Bug), damage = ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
; 1 call site from 1 routine (e.g. ActionEffect_BugBlow)
; reads: wBattleTarget, wBattleActor
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleDEF
AttackDamageHalvedDEFVsBug:: ; code pointer of the table EffectHandlerTable; C0
Func_036_5592:: ; address name
    call GetTargetSpeciesFamily
    cp a, $05
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

; when the target's species family (GetTargetSpeciesFamily) is 4 (Plant), damage = ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
; 1 call site from 1 routine (e.g. ActionEffect_Shears)
; reads: wBattleTarget, wBattleActor
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleDEF
AttackDamageHalvedDEFVsPlant:: ; code pointer of the table EffectHandlerTable; C0
Func_036_559D:: ; address name
    call GetTargetSpeciesFamily
    cp a, $04
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

; when the target's species family (GetTargetSpeciesFamily) is 6 (Demon), damage = ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
; 1 call site from 1 routine (e.g. ActionEffect_DevilCut)
; reads: wBattleTarget, wBattleActor
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleDEF
AttackDamageHalvedDEFVsDemon:: ; code pointer of the table EffectHandlerTable; C0
Func_036_55A8:: ; address name
    call GetTargetSpeciesFamily
    cp a, $06
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

; when the target's species family (GetTargetSpeciesFamily) is 7 (Zombie), damage = ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
; 1 call site from 1 routine (e.g. ActionEffect_ZombieCut)
; reads: wBattleTarget, wBattleActor
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleDEF
AttackDamageHalvedDEFVsZombie:: ; code pointer of the table EffectHandlerTable; C0
Func_036_55B3:: ; address name
    call GetTargetSpeciesFamily
    cp a, $07
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

; when the target's species family (GetTargetSpeciesFamily) is 8 (Material), damage = ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
; 1 call site from 1 routine (e.g. ActionEffect_CleanCut)
; reads: wBattleTarget, wBattleActor
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleDEF
AttackDamageHalvedDEFVsMaterial:: ; code pointer of the table EffectHandlerTable; C0
Func_036_55BE:: ; address name
    call GetTargetSpeciesFamily
    cp a, $08
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

; when the target's species family (GetTargetSpeciesFamily) is 9 (Water), damage = ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
; 1 call site from 1 routine (e.g. ActionEffect_AquaCut)
; reads: wBattleTarget, wBattleActor
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleDEF
AttackDamageHalvedDEFVsWater:: ; code pointer of the table EffectHandlerTable; C0
Func_036_55C9:: ; address name
    call GetTargetSpeciesFamily
    cp a, $09
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

; ComputeAttackDamage, then damage = damage * 3 / 2 + 1 when bit 0 of wD8A7[target] is set (E-0124)
; 1 call site from 1 routine (e.g. ActionEffect_MetalCut)
; reads: wBattleTarget, wBattleDamageLo, wBattleDamageHi
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wSlotDamageFlags
AttackDamageTimes1_5IfSlotDamageFlagsBit0:: ; code pointer of the table EffectHandlerTable; C0
Func_036_55D4:: ; address name
    call ComputeAttackDamage
    ld a, [wBattleTarget]
    ld hl, wSlotDamageFlags
    add_a_to_hl
    bit 0, [hl]
    jr z, .return
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    call ScaleHLBy3Over2
    inc hl
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a

.return:
    ret

; carry for action $82 or level 4; otherwise rolls by bits 0-1 of the target's wDA72 byte 1 (RollChanceByHLBits6And7 for action $7E) (E-0124)
; 2 call sites from 2 routines (e.g. ActionEffect_Radiant, ResolveStepDamageMessage_Sub04_RollTargetSlotResistancesByte1Bits01Chance)
; reads: wBattleActionId
RollTargetSlotResistancesByte1Bits01Chance::
Func_036_55FB:: ; address name
    ld a, [wBattleActionId]
    cp a, $82
    jr z, .return_carry
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte1
    and a, $03
    call ForceLevel4IfActorSlotFlags854Bit2
    cp a, $04
    jr nz, .check_battle_action_id

.return_carry:
    scf
    ret

.check_battle_action_id:
    and a, $03
    ld b, a
    ld a, [wBattleActionId]
    cp a, $7E
    ld a, b
    jr z, .call_roll_chance_by_hl_bits6_and7
    call RollChanceByFlagsAtHL
    ret

.call_roll_chance_by_hl_bits6_and7:
    call RollChanceByHLBits6And7
    ret

; level = bits 2-3 of the target's wDA72 byte 2 (wD86A; forced to 4): carry at 4, otherwise RollChanceByFlagsAtHL (E-0127)
; 2 call sites from 2 routines (e.g. ActionEffect_OddDance, ActionEffect_RobMagic)
; writes: wBattleArg2
RollTargetSlotResistancesByte2Bits23Chance::
Func_036_5626:: ; address name
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte2
    rrca
    rrca
    and a, $03
    ld [wBattleArg2], a
    call ForceLevel4IfActorSlotFlags854Bit2
    cp a, $04
    jr nz, .call_roll_chance_by_flags_at_hl
    scf
    ret

.call_roll_chance_by_flags_at_hl:
    call RollChanceByFlagsAtHL
    ret

; only called from ActionEffect_RobMagic (E-0047)
; 2 call sites from 1 routine (e.g. ActionEffect_RobMagic)
; reads: wBattleActor
; points at: wBattleMP
ActionEffect_RobMagic_DrainTargetMPAmount::
Func_036_5640:: ; address name
    call DrainTargetMPAmount
    ld a, [wBattleActor]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    push hl
    deref_hl
    add hl, bc
    ld b, h
    ld c, l
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wBattleActor]
    call ActionEffect_RobMagic_Sub01_GetBattleMP
    jr nc, .return
    ld a, [wBattleActor]
    ld bc, wBattleMaxMP + $1
    add a, a
    add a, c
    ld c, a
    jr nc, .skip
    inc b

.skip:
    ld a, [bc]
    ld [hl-], a
    dec bc
    ld a, [bc]
    ld [hl], a

.return:
    ret

; takes MP from the target: up to wD8B7[actor] / 4 + 5 (or wC982 for action $DF), limited by its MP; the amount is stored as damage (E-0127)
; 2 call sites from 2 routines (e.g. ActionEffect_OddDance, ActionEffect_RobMagic_DrainTargetMPAmount)
; reads: wBattleTarget, wBattleActionId, wSavedActorSlot, wSavedActorByte, wBattleActor
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleMP, wBattleLevel
DrainTargetMPAmount::
Func_036_5671:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    push hl
    ld a, [wBattleActionId]
    cp a, $DF
    jr nz, .skip
    ld a, [wSavedActorSlot]
    ld c, a
    ld a, [wSavedActorByte]
    ld b, a
    jr .set_battle_damage_lo

.skip:
    deref_hl
    or a, h
    jr z, .set_battle_damage_lo2
    ld a, [wBattleActor]
    ld de, wBattleLevel
    add a, e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    srl a
    srl a
    add a, $05
    ld c, a
    ld b, $00
    call CompareHLToBC
    jr nc, .set_battle_damage_lo
    ld b, h
    ld c, l

.set_battle_damage_lo:
    ld a, c
    ld [wBattleDamageLo], a
    ld a, b
    ld [wBattleDamageHi], a
    jr .restore

.set_battle_damage_lo2:
    ld bc, $0000
    ld a, c
    ld [wBattleDamageLo], a
    ld a, b
    ld [wBattleDamageHi], a

.restore:
    pop hl
    ld a, [hl]
    sub a, c
    ld [hl+], a
    ld a, [hl]
    sbc a, b
    ld [hl], a
    ret

; only called from ActionEffect_StopSpell (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_StopSpell)
ActionEffect_StopSpell_HLToBattleStatus8EntryOfBattleTarget_Bank36::
Func_036_56CB:: ; address name
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte2
    and a, $03
    call ForceLevel4IfActorSlotFlags854Bit2
    cp a, $04
    jr nz, .call_roll_chance_by_flags_at_hl
    scf
    ret

.call_roll_chance_by_flags_at_hl:
    call RollChanceByFlagsAtHL
    ret

; only called from ActionEffect_PanicAll (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_PanicAll)
; reads: wBattleActionId
ActionEffect_PanicAll_HLToBattleStatus8EntryOfBattleTarget_Bank36::
Func_036_56E0:: ; address name
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte3
    rlca
    rlca
    and a, $03
    push af
    ld a, [wBattleActionId]
    cp a, $E1
    jr nz, .call_force_level4_if_actor_slot_flags854_bit2
    pop af
    xor a, a
    push af

.call_force_level4_if_actor_slot_flags854_bit2:
    pop af
    call ForceLevel4IfActorSlotFlags854Bit2
    cp a, $04
    jr nz, .call_roll_chance_by_flags_at_hl_sided
    scf
    ret

.call_roll_chance_by_flags_at_hl_sided:
    call RollChanceByFlagsAtHLSided
    ret

; only called from ActionEffect_Transform (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Transform)
; reads: wBattleTarget, wBattleActor, wLinkMode, wRecordBufferData
; writes: wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3, wRecordBuffer
; points at: wSlotDamageFlags, wBattleHP, wBattleMaxHP, wBattleMP, wBattleMaxMP, wBattleATK, wBattleDEF, wBattleAGL, ...
ActionEffect_Transform_Sub01_SlotSpeciesNibblesD00AD00B_Sub01::
Func_036_5703:: ; address name
    ld a, [wBattleTarget]
    call ActionEffect_Transform_Sub01_SlotSpeciesNibblesD00AD00B
    ld a, [wBattleActor]
    ld hl, wSlotDamageFlags
    add_a_to_hl
    ld [hl], c
    ld a, [wBattleTarget]
    call ActionEffect_Transform_Sub01_GetBaseHP
    ld a, [wBattleActor]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank36
    push hl
    deref_hl
    call CompareHLToBC
    pop hl
    jr c, .read_battle_actor
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wBattleActor]
    call SetBit0OfLevelUpGainsIndexed_Bank36

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank36
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wBattleTarget]
    call ActionEffect_Transform_Sub01_GetBaseMP
    ld a, [wBattleActor]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    push hl
    deref_hl
    call CompareHLToBC
    pop hl
    jr c, .read_battle_actor2
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wBattleActor]
    call SetBit1OfLevelUpGainsIndexed_Bank36

.read_battle_actor2:
    ld a, [wBattleActor]
    ld hl, wBattleMaxMP
    call AddDoubleAToHL_Bank36
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wBattleActor]
    ld hl, wBattleATK
    call AddDoubleAToHL_Bank36
    ld a, [wBattleTarget]
    call GetBaseATKOfSlotA
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wBattleActor]
    ld hl, wBattleDEF
    call AddDoubleAToHL_Bank36
    ld a, [wBattleTarget]
    call GetBaseDEFOfSlotA
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wBattleActor]
    ld hl, wBattleAGL
    call AddDoubleAToHL_Bank36
    ld a, [wBattleTarget]
    call GetBaseAGLOfSlotA
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wBattleTarget]
    call ActionEffect_Transform_Sub01_BattlerRecordFieldAddress
    ld a, [wBattleActor]
    ld de, wSlotResistances
    ld b, a
    add a, a
    add a, b
    add a, a
    add a, b
    add a, e
    ld e, a
    jr nc, .set_battle_arg0
    inc d

.set_battle_arg0:
    ld a, l
    ld [wBattleArg0], a
    ld a, h
    ld [wBattleArg1], a
    ld a, e
    ld [wBattleArg2], a
    ld a, d
    ld [wBattleArg3], a
    farcall LoadBattleArg0PointersThenRunPackResistanceFieldsToDE
    ld a, [wBattleTarget]
    call ActionEffect_Transform_Sub01_BattlerRecordFieldAddress_Sub04
    ld a, [wBattleActor]
    ld de, wBattleSkillsPrefix
    swap a
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld c, $00

.loop:
    ld a, [hl]
    cp a, $FF
    jr z, .loop2
    cp a, $C8
    jr z, .loop2
    push af
    ld a, [wLinkMode]
    cp a, $01
    jr z, .restore2
    ld a, [wBattleTarget]
    cp a, $04
    jr nc, .restore
    pop af
    cp a, $34
    jr nz, .cp_35
    ld a, $AD
    jr .skip2

.cp_35:
    cp a, $35
    jr nz, .skip2
    ld a, $AE
    jr .skip2

.restore:
    pop af
    cp a, $AD
    jr nz, .cp_AE
    ld a, $34
    jr .skip2

.cp_AE:
    cp a, $AE
    jr nz, .skip2
    ld a, $35
    jr .skip2

.restore2:
    pop af

.skip2:
    push af
    push hl
    push de
    push bc
    ld [wRecordBuffer], a
    xor a, a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    pop bc
    pop de
    pop hl
    ld a, [wRecordBufferData + $3]
    swap a
    and a, $0F
    ld [de], a
    inc de
    pop af
    ld [de], a
    inc hl
    inc de
    inc c
    dec b
    jr nz, .loop
    ld a, c
    cp a, $08
    jr z, .return

.loop2:
    ld a, $00
    ld [de], a
    inc de
    ld a, $FF
    ld [de], a
    inc de
    inc c
    ld a, c
    cp a, $08
    jr nz, .loop2

.return:
    ret

; only called from ActionEffect_MegaMagic (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_MegaMagic)
; reads: wAllMPSpentLo, wAllMPSpentHi, wBattleActor, wBattleDamageLo, wBattleDamageHi
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleLevel
ActionEffect_MegaMagic_WriteBattleDamageLoAndBattleDamageHi::
Func_036_585C:: ; address name
    ld a, [wAllMPSpentLo]
    ld l, a
    ld a, [wAllMPSpentHi]
    ld h, a
    add hl, hl
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ld a, [wBattleActor]
    ld hl, wBattleLevel
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    add hl, hl
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    add hl, bc
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a

ActionEffect_MegaMagic_WriteBattleDamageLoAndBattleDamageHi_CallScaleHLTo40Percent::
Jump_036_588D:: ; address name
    call ScaleHLTo40Percent
    call ShiftHLRight2
    ld a, l
    or a, h
    jr z, .call_hl_to_battle_status8_entry_of_battle
    ld b, h
    ld c, l
    ld a, l
    cpl
    add a, $01
    ld l, a
    ld a, h
    cpl
    adc a, $00
    ld h, a
    call RandomInRange
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    add hl, de
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a

.call_hl_to_battle_status8_entry_of_battle:
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte4
    rlca
    rlca
    and a, $03
    call ScaleDamageByFlagsAtHLAlt
    ret

; only called from ActionEffect_WindBeast (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_WindBeast)
; reads: wBattleActor, wLinkMode, wBattleDamageLo, wBattleDamageHi
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleLevel
ActionEffect_WindBeast_ShiftBCRight1:: ; code pointer of the table EffectHandlerTable; C0
Func_036_58C5:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleLevel
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    ld b, h
    ld c, l
    ld a, [wLinkMode]
    cp a, $01
    jr z, .skip
    ld a, [wBattleActor]
    cp a, $04
    jr c, .skip
    call ShiftBCRight1
    jr .call_compare_hl_to_bc

.skip:
    add hl, bc
    add hl, bc
    ld bc, $000A

.call_compare_hl_to_bc:
    add hl, bc
    ld bc, $00B4
    call CompareHLToBC
    jr c, .set_battle_damage_lo
    ld hl, $00B4

.set_battle_damage_lo:
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    call ScaleHLTo30Percent
    call ShiftHLRight1
    ld b, h
    ld c, l
    ld a, l
    cpl
    add a, $01
    ld l, a
    ld a, h
    cpl
    adc a, $00
    ld h, a
    call RandomInRange
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    add hl, de
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call ScaleDamageBySlotResistancesByte1Bits76
    ret

; only called from ActionEffect_Vacuum (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Vacuum)
; reads: wBattleActor, wLinkMode, wBattleDamageLo, wBattleDamageHi
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleLevel
ActionEffect_Vacuum_ShiftBCRight1:: ; code pointer of the table EffectHandlerTable; C0
Func_036_592E:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleLevel
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    ld a, [wLinkMode]
    cp a, $01
    jr z, .skip
    cp a, $04
    jr c, .skip
    ld b, h
    ld c, l
    call ShiftBCRight1
    jr .call_compare_hl_to_bc

.skip:
    add hl, hl
    ld bc, $001E

.call_compare_hl_to_bc:
    add hl, bc
    ld bc, $0096
    call CompareHLToBC
    jr c, .set_battle_damage_lo
    ld hl, $0096

.set_battle_damage_lo:
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    call ScaleHLTo40Percent
    call ShiftHLRight2
    ld b, h
    ld c, l
    ld a, l
    cpl
    add a, $01
    ld l, a
    ld a, h
    cpl
    adc a, $00
    ld h, a
    call RandomInRange
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    add hl, de
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call ScaleDamageBySlotResistancesByte1Bits76
    ret

; only called from ActionEffect_Lightning (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Lightning)
; reads: wBattleActor, wLinkMode, wBattleDamageLo, wBattleDamageHi
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleLevel
ActionEffect_Lightning_ShiftBCRight1:: ; code pointer of the table EffectHandlerTable; C0
Func_036_5993:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleLevel
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    ld a, [wLinkMode]
    cp a, $01
    jr z, .skip
    ld a, [wBattleActor]
    cp a, $04
    jr c, .skip
    ld b, h
    ld c, l
    call ShiftBCRight1
    jr .call_get_target_species_family

.skip:
    add hl, hl
    ld bc, $0014

.call_get_target_species_family:
    add hl, bc
    push hl
    call GetTargetSpeciesFamily
    cp a, $09
    jr z, .call_compare_hl_to_bc
    ld bc, $00B4
    jr .call_compare_hl_to_bc2

.call_compare_hl_to_bc:
    ld bc, $00DC

.call_compare_hl_to_bc2:
    pop hl
    call CompareHLToBC
    jr c, .set_battle_damage_lo
    ld l, c
    ld h, b

.set_battle_damage_lo:
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    call ScaleHLTo40Percent
    call ShiftHLRight2
    ld b, h
    ld c, l
    ld a, l
    cpl
    add a, $01
    ld l, a
    ld a, h
    cpl
    adc a, $00
    ld h, a
    call RandomInRange
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    add hl, de
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call ActionEffect_Lightning_Sub01_GetTargetSlotResistancesByte1
    ret

; only called from ActionEffect_MultiCut (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_MultiCut)
; reads: wBattleActionId, wLinkMode, wBattleActor, wRecordBufferData, wBattleDamageLo, wBattleDamageHi
; writes: wRecordBuffer, wBattleArg2, wBattleDamageLo, wBattleDamageHi
ActionEffect_MultiCut_LoadSkillRecord::
Func_036_5A08:: ; address name
    ld a, [wBattleActionId]
    ld [wRecordBuffer], a
    xor a, a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    ld a, [wLinkMode]
    cp a, $01
    jr z, .read_record_buffer_data
    ld a, [wBattleActor]
    cp a, $04
    jr c, .read_record_buffer_data
    ld a, [wRecordBufferData + $D]
    ld l, a
    ld a, [wRecordBufferData + $E]
    ld h, a
    ld a, [wRecordBufferData + $F]
    jr .set_battle_arg2

.read_record_buffer_data:
    ld a, [wRecordBufferData + $9]
    ld l, a
    ld a, [wRecordBufferData + $A]
    ld h, a
    ld a, [wRecordBufferData + $B]

.set_battle_arg2:
    ld [wBattleArg2], a
    call RollDamageBaseToBasePlusBattleArg2
    call GetTargetSpeciesFamily
    cp a, $07
    jr nz, .call_hl_to_battle_status8_entry_of_battle
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    call ScaleHLBy21Over16
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a

.call_hl_to_battle_status8_entry_of_battle:
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte1
    rlca
    rlca
    and a, $03
    call ScaleDamageByFlagsAtHLAlt
    ret

; RollSkillDamageFromRecord, then ScaleDamageByFlagsAtHL with level = bits 3-2 of the target's wDA72 byte 6 (E-0115)
; 5 call sites from 5 routines (e.g. ActionEffect_ActionD5, ActionEffect_ActionD4_SkillDamageScaledBySlotResistancesByte6Bits32, ActionEffect_ActionD3_SkillDamageScaledBySlotResistancesByte6Bits32, ActionEffect_ActionD2_SkillDamageScaledBySlotResistancesByte6Bits32, ...)
SkillDamageScaledBySlotResistancesByte6Bits32:: ; code pointer of the table EffectHandlerTable; C0
Func_036_5A6C:: ; address name
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte6
    rrca
    rrca
    and a, $03
    call ScaleDamageByFlagsAtHL
    ret

; damage = the target's HP * 8 / 10 + 1 (ScaleHLTo80Percent_Bank36), then ScaleDamageByFlagsAtHL with level = bits 1-0 of the target's wDA72 byte 3 (E-0118)
; 1 call site from 1 routine (e.g. ActionEffect_Ramming)
; reads: wBattleTarget
; writes: wBattleDamageLo, wBattleDamageHi
DamageEightyPercentOfTargetHPScaled::
Func_036_5A7A:: ; address name
    ld a, [wBattleTarget]
    call GetBattleHP
    call ScaleHLTo80Percent_Bank36
    inc hl
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte3
    and a, $03
    call ScaleDamageByFlagsAtHL
    ret

; only called from ActionEffect_Kamikaze (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Kamikaze)
; reads: wBattleActor, wLinkMode, wBattleKind, wBattleTarget, wBattleDamageLo, wBattleDamageHi
; writes: wBattleDamageLo, wBattleDamageHi
ActionEffect_Kamikaze_HLToBattleStatus8EntryOfBattleTarget_Bank36::
Func_036_5A98:: ; address name
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte3
    and a, $03
    call RollChanceByFlagsAtHL
    jr nc, .set_battle_damage_lo2
    ld a, [wBattleActor]
    call GetBattleHP
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    deref_hl
    ld a, h
    or a, a
    jr nz, .check_link_mode
    ld a, l
    cp a, $01
    jr z, .set_battle_damage_lo

.check_link_mode:
    ld a, [wLinkMode]
    or a, a
    jr nz, .read_battle_damage_lo
    ld a, [wBattleKind]
    or a, a
    jr z, .read_battle_target
    cp a, $01
    jr nz, .read_battle_damage_lo

.read_battle_target:
    ld a, [wBattleTarget]
    call GetBattleHP
    dec hl
    jr .skip

.read_battle_damage_lo:
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    dec hl
    call ShiftHLRight1

.skip:
    ld a, h
    or a, l
    jr nz, .set_battle_damage_lo
    ld hl, $0001

.set_battle_damage_lo:
    scf
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ret

.set_battle_damage_lo2:
    ld hl, $0000
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    xor a, a
    ret

; only called from ActionEffect_Curse (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Curse)
ActionEffect_Curse_HLToBattleStatus8EntryOfBattleTarget_Bank36::
Func_036_5B02:: ; address name
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte5
    swap a
    and a, $03
    call ForceLevel4IfActorSlotFlags854Bit2
    cp a, $04
    jr nz, .call_roll_chance_by_flags_at_hl_sided
    scf
    ret

.call_roll_chance_by_flags_at_hl_sided:
    call RollChanceByFlagsAtHLSided
    ret

; skips allies in modes 2/3; level = bits 4-5 of the target's wDA72 byte 2 (wD86A): carry at 4, else the chance (sided for actions below $13, $14 and $79; RollChanceByHLBits6And7 for $82) (E-0125)
; 2 call sites from 2 routines (e.g. ActionEffect_UltraDown, ActionEffect_Beat)
; reads: wBattleActionId, wBattleArg2
; writes: wBattleArg2
RollTargetSlotResistancesByte2Bits45Chance::
Func_036_5B19:: ; address name
    call ZIfAllyActorInBattleKindMode2Or3
    jp z, ActionEffect_EerieLite_HLToBattleStatus8EntryOfBattleTarget_Bank36_Done
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte2
    swap a
    and a, $03
    ld [wBattleArg2], a
    call ForceLevel4IfActorSlotFlags854Bit2
    cp a, $04
    jr nz, .check_battle_action_id
    scf
    ret

.check_battle_action_id:
    ld a, [wBattleActionId]
    cp a, $13
    jr c, .read_battle_arg2
    cp a, $14
    jr z, .read_battle_arg2
    cp a, $79
    jr z, .read_battle_arg2
    cp a, $82
    jr z, .read_battle_arg22
    ld a, [wBattleArg2]
    call RollChanceByFlagsAtHL
    ret

.read_battle_arg2:
    ld a, [wBattleArg2]
    call RollChanceByFlagsAtHLSided
    ret

.read_battle_arg22:
    ld a, [wBattleArg2]
    call RollChanceByHLBits6And7
    ret

; HL = the target's wD814 entry; level = bits 3-2 of the target's wDA72 byte 5 (GetTargetSlotResistancesByte5); for actions $7A, $8E and $90 success is certain when ForceLevel4IfActorSlotFlags854Bit2 returns 4, else RollChanceByFlagsAtHLSided; other actions use RollChanceByFlagsAtHL; carry = success (E-0096)
; 5 call sites from 5 routines (e.g. ActionEffect_WarCry, ActionEffect_Ahhh, ActionEffect_LegSweep_RollChanceVsTargetSlotResistancesByte5Bits23, ActionEffect_LushLicks, ...)
; reads: wBattleActionId
RollChanceVsTargetSlotResistancesByte5Bits23::
Func_036_5B5D:: ; address name
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte5
    rrca
    rrca
    and a, $03
    ld b, a
    ld a, [wBattleActionId]
    cp a, $7A
    jr z, .call_force_level4_if_actor_slot_flags854_bit2
    cp a, $8E
    jr z, .call_force_level4_if_actor_slot_flags854_bit2
    cp a, $90
    jr z, .call_force_level4_if_actor_slot_flags854_bit2
    ld a, b
    call RollChanceByFlagsAtHL
    jr .return

.call_force_level4_if_actor_slot_flags854_bit2:
    ld a, b
    call ForceLevel4IfActorSlotFlags854Bit2
    cp a, $04
    jr nz, .call_roll_chance_by_flags_at_hl_sided
    scf
    ret

.call_roll_chance_by_flags_at_hl_sided:
    call RollChanceByFlagsAtHLSided

.return:
    ret

; only called from ActionEffect_UltraDown (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_UltraDown)
; reads: wBattleTarget
; points at: wBattleDEF, wBattleAGL, wBattleStatus1
ActionEffect_UltraDown_ReadBattleTarget::
Func_036_5B8B:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleDEF
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    dec bc
    ld a, b
    or a, c
    jr nz, .return_carry
    ld a, [wBattleTarget]
    ld hl, wBattleAGL
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    dec bc
    ld a, b
    or a, c
    jr nz, .return_carry
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 1, [hl]
    jr z, .return_carry
    xor a, a
    ret

.return_carry:
    scf
    ret

; only called from ActionEffect_TatsuCall (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_TatsuCall)
; reads: wLoadSlot, wRecordBuffer, wRecordBufferData, wScreenAttrBuffer
; writes: wMonsterId, wSpeciesIdLo, wSpeciesIdHi, wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3
; points at: wBattleStatus, wBattleSlotOut, wSpecialSlotMonsters, wBattleMonsterId, wBattleLevel, wBattleHP, wBattleMaxHP, wBattleMP, ...
ActionEffect_TatsuCall_AddAx9ToHL::
Func_036_5BC4:: ; address name
    ld a, [wLoadSlot]
    ld hl, wBattleStatus
    call AddAx9ToHL
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, [wLoadSlot]
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld [hl], $00
    ld a, [wLoadSlot]
    srl a
    srl a
    and a, $01
    ld hl, wSpecialSlotMonsters
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wMonsterId + $1], a
    farcall LoadMonsterRecord
    ld a, [wRecordBuffer]
    ld c, a
    ld a, [wRecordBuffer + $1]
    ld b, a
    ld hl, wBattleMonsterId
    call StoreBCAtWordEntryLoadSlot
    ld a, [wRecordBufferData + $7]
    ld c, a
    ld hl, wBattleLevel
    call ActionEffect_TatsuCall_Sub01_ReadLoadSlot
    ld a, [wRecordBufferData + $8]
    ld c, a
    ld a, [wRecordBufferData + $9]
    ld b, a
    ld hl, wBattleHP
    call StoreBCAtWordEntryLoadSlot
    ld a, [wRecordBufferData + $8]
    ld c, a
    ld a, [wRecordBufferData + $9]
    ld b, a
    ld hl, wBattleMaxHP
    call StoreBCAtWordEntryLoadSlot
    ld a, [wRecordBufferData + $A]
    ld c, a
    ld a, [wRecordBufferData + $B]
    ld b, a
    ld hl, wBattleMP
    call StoreBCAtWordEntryLoadSlot
    ld a, [wRecordBufferData + $A]
    ld c, a
    ld a, [wRecordBufferData + $B]
    ld b, a
    ld hl, wBattleMaxMP
    call StoreBCAtWordEntryLoadSlot
    ld a, [wRecordBufferData + $C]
    ld c, a
    ld a, [wRecordBufferData + $D]
    ld b, a
    ld hl, wBattleATK
    call StoreBCAtWordEntryLoadSlot
    ld a, [wRecordBufferData + $E]
    ld c, a
    ld a, [wRecordBufferData + $F]
    ld b, a
    ld hl, wBattleDEF
    call StoreBCAtWordEntryLoadSlot
    ld a, [wRecordBufferData + $10]
    ld c, a
    ld a, [wRecordBufferData + $11]
    ld b, a
    ld hl, wBattleAGL
    call StoreBCAtWordEntryLoadSlot
    ld a, [wScreenAttrBuffer]
    ld c, a
    ld a, [wRecordBufferData + $13]
    ld b, a
    ld hl, wBattleINT
    call StoreBCAtWordEntryLoadSlot
    ld bc, $03E7
    ld hl, wBattleWordArray3F
    call StoreBCAtWordEntryLoadSlot
    ld a, [wRecordBufferData + $14]
    ld c, a
    ld hl, wSlotPersonalityHi
    call ActionEffect_TatsuCall_Sub01_ReadLoadSlot
    ld a, [wRecordBufferData + $15]
    ld c, a
    ld hl, wSlotPersonalityLo
    call ActionEffect_TatsuCall_Sub01_ReadLoadSlot
    ld a, [wRecordBufferData + $16]
    ld c, a
    ld hl, wSlotPersonalityMid
    call ActionEffect_TatsuCall_Sub01_ReadLoadSlot
    ld a, [wRecordBufferData + $17]
    ld c, a
    ld hl, wSlotTrait
    call ActionEffect_TatsuCall_Sub01_ReadLoadSlot
    ld c, $00
    ld hl, wSlotDamageFlags
    call ActionEffect_TatsuCall_Sub01_ReadLoadSlot
    ld c, $00
    ld hl, wSlotNameSuffix
    call ActionEffect_TatsuCall_Sub01_ReadLoadSlot
    ld a, [wLoadSlot]
    ld c, a
    farcall SetSlotAIModeFromINT
    ld a, [wRecordBuffer]
    ld l, a
    ld a, [wRecordBuffer + $1]
    ld h, a
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld hl, wSpeciesRecord + $12
    ld a, l
    ld [wBattleArg0], a
    ld a, h
    ld [wBattleArg1], a
    ld a, [wLoadSlot]
    ld c, a
    add a, a
    add a, c
    add a, a
    add a, c
    ld de, wSlotResistances
    add a, e
    ld e, a
    jr nc, .set_battle_arg2
    inc d

.set_battle_arg2:
    ld a, e
    ld [wBattleArg2], a
    ld a, d
    ld [wBattleArg3], a
    farcall LoadBattleArg0PointersThenRunPackResistanceFieldsToDE
    ld hl, wRecordBufferData
    ld de, wTemp0
    ld bc, $0004
    call CopyBytes
    ld hl, wTemp0
    call ActionEffect_TatsuCall_Sub01_WriteRecordBufferAndBattleArg0Etc
    ret

; only called from ActionEffect_TatsuCall_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_TatsuCall_AddAx9ToHL)
; reads: wLoadSlot, wRecordBufferData
; writes: wRecordBuffer, wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3
; points at: wBattleSkills
ActionEffect_TatsuCall_Sub01_WriteRecordBufferAndBattleArg0Etc::
Func_036_5D2C:: ; address name
    ld b, $04
    ld a, [wLoadSlot]
    ld de, wBattleSkills
    swap a
    add a, e
    ld e, a
    jr nc, .loop
    inc d

.loop:
    ld a, [hl]
    cp a, $FF
    ret z
    push hl
    push bc
    ld a, [hl]
    ld [de], a
    dec de
    push de
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
    swap a
    and a, $0F
    pop de
    ld [de], a
    inc de
    inc de
    inc de
    pop bc
    pop hl
    inc hl
    dec b
    jr nz, .loop
    ret

; only called from ActionEffect_TatsuCall_Sub01 (E-0047)
; 7 call sites from 1 routine (e.g. ActionEffect_TatsuCall_AddAx9ToHL)
; reads: wLoadSlot
ActionEffect_TatsuCall_Sub01_ReadLoadSlot::
Func_036_5D7A:: ; address name
    ld a, [wLoadSlot]
    add_a_to_hl
    ld [hl], c
    ret

; HL = table: stores BC (low byte first) at HL + 2 * wD871 (E-0073)
; 10 call sites from 1 routine (e.g. ActionEffect_TatsuCall_AddAx9ToHL)
; reads: wLoadSlot
StoreBCAtWordEntryLoadSlot::
Func_036_5D84:: ; address name
    ld a, [wLoadSlot]
    add a, a
    add_a_to_hl
    ld [hl], c
    inc hl
    ld [hl], b
    ret

; only called from ActionEffect_LegSweep (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_LegSweep)
; reads: wBattleTarget
; points at: wSlotDamageFlags
ActionEffect_LegSweep_RollChanceVsTargetSlotResistancesByte5Bits23::
Func_036_5D91:: ; address name
    ld a, [wBattleTarget]
    ld hl, wSlotDamageFlags
    add_a_to_hl
    bit 4, [hl]
    ret nz
    call RollChanceVsTargetSlotResistancesByte5Bits23
    ret

; only called from ActionEffect_DanceShut (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_DanceShut)
ActionEffect_DanceShut_HLToBattleStatus8EntryOfBattleTarget_Bank36::
Func_036_5DA3:: ; address name
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte5
    and a, $03
    call ForceLevel4IfActorSlotFlags854Bit2
    cp a, $04
    jr nz, .call_roll_chance_by_flags_at_hl
    scf
    ret

.call_roll_chance_by_flags_at_hl:
    call RollChanceByFlagsAtHL
    ret

; only called from ActionEffect_MouthShut (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_MouthShut)
ActionEffect_MouthShut_HLToBattleStatus8EntryOfBattleTarget_Bank36::
Func_036_5DB8:: ; address name
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte6
    rlca
    rlca
    and a, $03
    call ForceLevel4IfActorSlotFlags854Bit2
    cp a, $04
    jr nz, .call_roll_chance_by_flags_at_hl
    scf
    ret

.call_roll_chance_by_flags_at_hl:
    call RollChanceByFlagsAtHL
    ret

; only called from ActionEffect_CallHelp (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_CallHelp)
; reads: wBattleActor, wLinkMode
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleLevel
ActionEffect_CallHelp_WriteBattleDamageLoAndBattleDamageHi:: ; code pointer of the table EffectHandlerTable; C0
Func_036_5DCF:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleLevel
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    ld a, [wLinkMode]
    cp a, $01
    jr z, .set_battle_damage_lo
    ld a, [wBattleActor]
    cp a, $04
    jr c, .set_battle_damage_lo
    push hl
    srl h
    rr l
    pop bc
    add hl, bc
    jr .set_battle_damage_lo2

.set_battle_damage_lo:
    add hl, hl

.set_battle_damage_lo2:
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte6
    swap a
    and a, $03
    call ScaleDamageByFlagsAtHL
    ret

; only called from ActionEffect_BiAttack (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_BiAttack)
; reads: wBattleActor, wBattleActionId, wBattleTemp7F, wBattleTemp80, wBattleTarget, wBattleDamageLo, wBattleDamageHi
; writes: wBattleTemp7F, wBattleTemp80, wBattleDamageLo, wBattleDamageHi
; points at: wBattleATK, wBattleDEF
ActionEffect_BiAttack_ShiftHLRight1:: ; code pointer of the table EffectHandlerTable; C0
Func_036_5E0B:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleATK
    call AddDoubleAToHL_Bank36
    ld a, l
    ld [wBattleTemp7F], a
    ld a, h
    ld [wBattleTemp80], a
    deref_hl
    push hl
    ld c, l
    ld b, h
    ld a, $1E
    call Multiply8By16
    ld a, [wBattleActionId]
    cp a, $63
    jr z, .call_scale_hl_to75_percent
    call ShiftHLRight1
    ld b, h
    ld c, l
    call ShiftBCRight2
    add hl, bc
    jr .read_battle_temp7_f

.call_scale_hl_to75_percent:
    call ScaleHLTo75Percent

.read_battle_temp7_f:
    ld a, [wBattleTemp7F]
    ld c, a
    ld a, [wBattleTemp80]
    ld b, a
    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    ld a, [wBattleTarget]
    ld hl, wBattleDEF
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, $1E
    call Multiply8By16
    ld c, l
    ld b, h
    call ShiftBCRight1
    call ComputeBasicDamage
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    ld a, $1E
    call DivideHLByA
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    pop hl
    ld a, [wBattleTemp7F]
    ld c, a
    ld a, [wBattleTemp80]
    ld b, a
    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    ret

; only called from ActionEffect_Meditate (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Meditate)
; reads: wBattleActor, wEffectTemp0, wEffectTemp1, wEffectTemp2, wEffectTemp3
; writes: wEffectTemp0, wEffectTemp1, wEffectTemp2, wEffectTemp3
; points at: wBattleMaxHP, wBattleHP
ActionEffect_Meditate_AddDoubleAToHL_Bank36::
Func_036_5E86:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, c
    ld [wEffectTemp0], a
    ld a, b
    ld [wEffectTemp1], a
    ld a, [wBattleActor]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank36
    ld a, l
    ld [wEffectTemp2], a
    ld a, h
    ld [wEffectTemp3], a
    deref_hl
    call CompareHLToBC
    jr z, .done
    ld bc, $01F4
    add hl, bc
    ld a, [wEffectTemp0]
    ld c, a
    ld a, [wEffectTemp1]
    ld b, a
    call CompareHLToBC
    jr c, .read_effect_temp2
    ld h, b
    ld l, c

.read_effect_temp2:
    ld a, [wEffectTemp2]
    ld c, a
    ld a, [wEffectTemp3]
    ld b, a
    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    scf
    ret

.done:
    scf
    ccf
    ret

; only called from ActionEffect_Sacrifice (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Sacrifice)
; reads: wBattleActionId
ActionEffect_Sacrifice_ZIfAllyActorInBattleKindMode2Or3::
Func_036_5ED8:: ; address name
    call ZIfAllyActorInBattleKindMode2Or3
    jp z, ActionEffect_EerieLite_HLToBattleStatus8EntryOfBattleTarget_Bank36_Done
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte3
    and a, $03
    call ForceLevel4IfActorSlotFlags854Bit2
    cp a, $04
    jr nz, .check_battle_action_id
    scf
    ret

.check_battle_action_id:
    push af
    ld a, [wBattleActionId]
    cp a, $D6
    jr z, .call_roll_chance_for_level_a_6346
    pop af
    call ActionEffect_Sacrifice_Sub01_RollChanceByLevel_100_84_50_0
    ret

.call_roll_chance_for_level_a_6346:
    pop af
    call RollChanceForLevelA_6346
    ret

; rolls skill damage, then by bits 6-7 of the target's wDA72 byte 2 (wD86A): carry at level 4, else the chance (unsided for action $2F) (E-0124)
; 2 call sites from 2 routines (e.g. ActionEffect_Sleep, ResolveStep0EEffect_Case00_RollTargetSlotResistancesByte2Bits67Chance)
; reads: wBattleActionId, wBattleArg2
; writes: wBattleArg2
RollTargetSlotResistancesByte2Bits67Chance::
Func_036_5F01:: ; address name
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte2
    rlca
    rlca
    and a, $03
    ld [wBattleArg2], a
    call ForceLevel4IfActorSlotFlags854Bit2
    cp a, $04
    jr nz, .check_battle_action_id
    scf
    ret

.check_battle_action_id:
    ld a, [wBattleActionId]
    cp a, $2F
    ld a, [wBattleArg2]
    jp z, RollChanceByFlagsAtHL
    jp RollChanceByFlagsAtHLSided

; only called from ActionEffect_BeDragon (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_BeDragon)
; reads: wBattleActionId, wRecordBufferData, wBattleActor, wScreenAttrBuffer, wRecordBuffer
; writes: wMonsterId, wSpeciesIdLo, wSpeciesIdHi, wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3
; points at: wBattleMaxHP, wBattleHP, wBattleMaxMP, wBattleMP, wBattleATK, wBattleDEF, wBattleAGL, wBattleINT, ...
ActionEffect_BeDragon_LoadMonsterRecord::
Func_036_5F25:: ; address name
    ld hl, $0082
    ld a, [wBattleActionId]
    cp a, $DC
    jr nz, .set_monster_id
    ld hl, $0262

.set_monster_id:
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wMonsterId + $1], a
    farcall LoadMonsterRecord
    ld a, [wRecordBufferData + $8]
    ld c, a
    ld a, [wRecordBufferData + $9]
    ld b, a
    ld hl, wBattleMaxHP
    call StoreBCAtActorWordEntry
    ld a, [wBattleActor]
    ld hl, wBattleHP
    call ActionEffect_BeDragon_Sub02_CompareHLToBC
    ld a, [wRecordBufferData + $A]
    ld c, a
    ld a, [wRecordBufferData + $B]
    ld b, a
    ld hl, wBattleMaxMP
    call StoreBCAtActorWordEntry
    ld a, [wBattleActor]
    ld hl, wBattleMP
    call ActionEffect_BeDragon_Sub02_CompareHLToBC
    ld a, [wRecordBufferData + $C]
    ld c, a
    ld a, [wRecordBufferData + $D]
    ld b, a
    ld hl, wBattleATK
    call StoreBCAtActorWordEntry
    ld a, [wRecordBufferData + $E]
    ld c, a
    ld a, [wRecordBufferData + $F]
    ld b, a
    ld hl, wBattleDEF
    call StoreBCAtActorWordEntry
    ld a, [wRecordBufferData + $10]
    ld c, a
    ld a, [wRecordBufferData + $11]
    ld b, a
    ld hl, wBattleAGL
    call StoreBCAtActorWordEntry
    ld a, [wScreenAttrBuffer]
    ld c, a
    ld a, [wRecordBufferData + $13]
    ld b, a
    ld hl, wBattleINT
    call StoreBCAtActorWordEntry
    ld a, [wRecordBuffer]
    ld l, a
    ld a, [wRecordBuffer + $1]
    ld h, a
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wBattleActor]
    ld c, a
    farcall SetSlotAIModeFromINT
    ld hl, wSpeciesRecord + $12
    ld a, l
    ld [wBattleArg0], a
    ld a, h
    ld [wBattleArg1], a
    ld a, [wBattleActor]
    ld c, a
    add a, a
    add a, c
    add a, a
    add a, c
    ld de, wSlotResistances
    add a, e
    ld e, a
    jr nc, .set_battle_arg2
    inc d

.set_battle_arg2:
    ld a, e
    ld [wBattleArg2], a
    ld a, d
    ld [wBattleArg3], a
    farcall LoadBattleArg0PointersThenRunPackResistanceFieldsToDE
    ld hl, wRecordBufferData
    ld de, wTemp0
    ld bc, $0004
    call CopyBytes
    call ActionEffect_BeDragon_Sub02_WriteRecordBufferAndBattleArg0Etc
    ld a, [wBattleActor]
    ld hl, wSlotDamageFlags
    add_a_to_hl
    ld [hl], $00
    ld a, [wBattleActor]
    call SetBit0OfLevelUpGainsIndexed_Bank36
    ld a, [wBattleActor]
    call SetBit1OfLevelUpGainsIndexed_Bank36
    ret

; only called from ActionEffect_BeDragon_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_BeDragon_LoadMonsterRecord)
; reads: wBattleActor, wRecordBufferData
; writes: wRecordBuffer, wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3
; points at: wTemp0, wBattleSkills
ActionEffect_BeDragon_Sub02_WriteRecordBufferAndBattleArg0Etc::
Func_036_6018:: ; address name
    ld hl, wTemp0
    ld b, $04
    ld a, [wBattleActor]
    ld de, wBattleSkills
    swap a
    add a, e
    ld e, a
    jr nc, .loop
    inc d

.loop:
    ld a, [hl]
    cp a, $FF
    jr nz, .skip
    call ActionEffect_BeDragon_Sub02_Sub01_Sub01
    jr .next

.skip:
    push hl
    push bc
    ld a, [hl]
    ld [de], a
    dec de
    push de
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
    swap a
    and a, $0F
    pop de
    pop bc
    pop hl
    ld [de], a
    inc de
    inc de
    inc de

.next:
    inc hl
    dec b
    jr nz, .loop
    call ActionEffect_BeDragon_Sub02_Sub01_Sub01
    call ActionEffect_BeDragon_Sub02_Sub01_Sub01
    call ActionEffect_BeDragon_Sub02_Sub01_Sub01

; only called from ActionEffect_BeDragon_Sub02_Sub01 (E-0047)
; 4 call sites from 1 routine (e.g. ActionEffect_BeDragon_Sub02_WriteRecordBufferAndBattleArg0Etc)
ActionEffect_BeDragon_Sub02_Sub01_Sub01::
Func_036_6077:: ; address name
    ld a, $FF
    ld [de], a
    dec de
    xor a, a
    ld [de], a
    inc de
    inc de
    inc de
    ret

; [HL + wBattleActor] = C (E-0115)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
StoreCAtActorEntry:: ; heuristic: follows a terminator; C0
Func_036_6081:: ; address name
    ld a, [wBattleActor]
    add_a_to_hl
    ld [hl], c
    ret

; HL = table: stores BC (low byte first) at HL + 2 * wBattleActor; HL ends on the high byte (E-0077)
; 6 call sites from 1 routine (e.g. ActionEffect_BeDragon_LoadMonsterRecord)
; reads: wBattleActor
StoreBCAtActorWordEntry::
Func_036_608B:: ; address name
    ld a, [wBattleActor]
    add a, a
    add_a_to_hl
    ld [hl], c
    inc hl
    ld [hl], b
    ret

; sets the actor's ATK word to 200 ($00C8), runs ComputeAttackDamage, then restores the old ATK (E-0120)
; 1 call site from 1 routine (e.g. ActionEffect_ActionB9)
; reads: wBattleActor
; points at: wBattleATK
AttackDamageWithATK200::
Func_036_6098:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleATK
    call AddDoubleAToHL_Bank36
    push hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    push bc
    ld a, $00
    ld [hl-], a
    ld [hl], $C8
    call ComputeAttackDamage
    pop bc
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ret

; only called from ActionEffect_Watershot (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Watershot)
; reads: wBattleActionId
ActionEffect_Watershot_RollSkillDamageFromRecord:: ; code pointer of the table EffectHandlerTable; C0
Func_036_60B4:: ; address name
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte0
    swap a
    rrca
    rrca
    and a, $03
    ld b, a
    ld a, [wBattleActionId]
    cp a, $4C
    ld a, b
    jr z, .call_scale_damage_by_flags_at_hl
    call ScaleDamageByFlagsAtHLAlt
    ret

.call_scale_damage_by_flags_at_hl:
    call ScaleDamageByFlagsAtHL
    ret

; level = bits 0-1 of the target's wDA72 byte 4 (forced to 4 by bit 2 of the actor's wD854); level 4 returns carry; otherwise rolls the sided chance, E = 0 on carry else 1 (E-0122)
; 3 call sites from 3 routines (e.g. ActionEffect_PoisonGas, ResolveStep0EEffect_WriteBattleSubStep2AndEffectSubStepEtc, InflictStatus0Bit0WithBattleWordArray3FReduction)
RollTargetSlotResistancesByte4Bits01ChanceToE::
Func_036_60D1:: ; address name
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte4
    and a, $03
    call ForceLevel4IfActorSlotFlags854Bit2
    cp a, $04
    jr nz, .call_roll_chance_by_flags_at_hl_sided
    scf
    ret

.call_roll_chance_by_flags_at_hl_sided:
    call RollChanceByFlagsAtHLSided
    ld e, $00
    ret c
    ld e, $01
    ret

; skips allies in modes 2/3; otherwise level = bits 6-7 of the target's wDA72 byte 5: carry at 4, else the sided chance with E = 0 on carry, 1 otherwise (E-0124)
; 2 call sites from 2 routines (e.g. ActionEffect_PalsyAir, ResolveStep0EEffect_WriteBattleSubStep2AndEffectSubStepEtc)
RollTargetSlotResistancesByte5Bits67ChanceToE::
Func_036_60EB:: ; address name
    call ZIfAllyActorInBattleKindMode2Or3
    jp z, ActionEffect_EerieLite_HLToBattleStatus8EntryOfBattleTarget_Bank36_Done
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte5
    rlca
    rlca
    and a, $03
    call ForceLevel4IfActorSlotFlags854Bit2
    cp a, $04
    jr nz, .call_roll_chance_by_flags_at_hl_sided
    scf
    ret

.call_roll_chance_by_flags_at_hl_sided:
    call RollChanceByFlagsAtHLSided
    ld e, $00
    ret c
    ld e, $01
    ret

; only called from ResolveStep0EEffect_Case00 (E-0047)
; 1 call site from 1 routine (e.g. ResolveStep0EEffect_WriteBattleSubStep2AndEffectSubStepEtc)
ResolveStep0EEffect_Case00_RollTargetSlotResistancesByte2Bits67Chance::
Func_036_610D:: ; address name
    call RollTargetSlotResistancesByte2Bits67Chance
    ld e, $00
    ret c
    ld e, $01
    ret

; only called from ActionEffect_Geyser (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Geyser)
ActionEffect_Geyser_HLToBattleStatus8EntryOfBattleTarget_Bank36::
Func_036_6116:: ; address name
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte0
    swap a
    rrca
    rrca
    and a, $03
    call RollChanceByFlagsAtHL
    ret

; only called from ActionEffect_EerieLite (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_EerieLite)
ActionEffect_EerieLite_HLToBattleStatus8EntryOfBattleTarget_Bank36::
Func_036_6126:: ; address name
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte2
    swap a
    and a, $03
    call ForceLevel4IfActorSlotFlags854Bit2
    cp a, $04
    jr nz, .call_roll_chance_by_flags_at_hl
    scf
    ret

.call_roll_chance_by_flags_at_hl:
    call RollChanceByFlagsAtHL
    ret

ActionEffect_EerieLite_HLToBattleStatus8EntryOfBattleTarget_Bank36_Done::
Jump_036_613D:: ; address name
    xor a, a
    ld e, $01
    ret

; A = 0 and Z when wCFC5 is 2 or 3 and the actor is an ally (slot < 4); otherwise A = 1 and NZ (E-0122)
; 3 call sites from 3 routines (e.g. RollTargetSlotResistancesByte2Bits45Chance, RollTargetSlotResistancesByte5Bits67ChanceToE, ActionEffect_Sacrifice_ZIfAllyActorInBattleKindMode2Or3)
; reads: wBattleKind, wBattleActor
ZIfAllyActorInBattleKindMode2Or3::
Func_036_6141:: ; address name
    ld a, [wBattleKind]
    cp a, $02
    jr z, .check_battle_actor
    cp a, $03
    jr nz, .done

.check_battle_actor:
    ld a, [wBattleActor]
    cp a, $04
    jr nc, .done
    xor a, a
    ret

.done:
    ld a, $01
    or a, a
    ret

; picks a base and spread from the loaded skill record: wCFFB/wCFFC and wCFFD for actors in slots 4-7 when wC58A is not 1, otherwise wCFF7/wCFF8 and wCFF9; the spread goes to wD86A and RollDamageBaseToBasePlusBattleArg2 sets the damage word; then falls into HLToWD814EntryOfWD8A5_Bank36 (E-0095)
; 15 call sites from 15 routines (e.g. SkillDamageScaledBySlotResistancesByte6Bits32, ActionEffect_Watershot_RollSkillDamageFromRecord, ActionEffect_RockThrow_RollSkillDamageFromRecord, HealTargetHP, ...)
; reads: wLinkMode, wBattleActor, wRecordBufferData, wBattleTarget
; writes: wBattleArg2
; points at: wBattleStatus8
RollSkillDamageFromRecord::
Func_036_6159:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr z, .read_record_buffer_data
    ld a, [wBattleActor]
    bit 2, a
    jr z, .read_record_buffer_data
    ld a, [wRecordBufferData + $D]
    ld l, a
    ld a, [wRecordBufferData + $E]
    ld h, a
    ld a, [wRecordBufferData + $F]
    jr .set_battle_arg2

.read_record_buffer_data:
    ld a, [wRecordBufferData + $9]
    ld l, a
    ld a, [wRecordBufferData + $A]
    ld h, a
    ld a, [wRecordBufferData + $B]

.set_battle_arg2:
    ld [wBattleArg2], a
    call RollDamageBaseToBasePlusBattleArg2

; HL = wD814 + 9 * [wD8A5] (AddAx9ToHL); A = [wD8A5] (the same 10 bytes appear in 2 banks)
; 28 call sites from 28 routines (e.g. AttackDamageScaledBySlotResistancesByte1Bits32, AttackDamageScaledBySlotResistancesByte1Bits54, AttackDamageScaledBySlotResistancesByte1Bits76, AttackDamageScaledBySlotResistancesByte0Bits54, ...)
; reads: wBattleTarget
; points at: wBattleStatus8
HLToBattleStatus8EntryOfBattleTarget_Bank36::
Func_036_6185:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus8
    call AddAx9ToHL
    ret

; HL = base: wBattleDamageLo/wD873 = RandomInRange(HL, HL + wD86A); HL kept (E-0095)
; 2 call sites from 2 routines (e.g. RollSkillDamageFromRecord, ActionEffect_MultiCut_LoadSkillRecord)
; reads: wBattleArg2
; writes: wBattleDamageLo, wBattleDamageHi
RollDamageBaseToBasePlusBattleArg2::
Func_036_618F:: ; address name
    push hl
    ld a, [wBattleArg2]
    ld c, a
    ld b, $00
    add hl, bc
    ld c, l
    ld b, h
    pop hl
    call RandomInRange
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wBattleDamageHi], a
    ret

; A = byte 0 of wBattleTarget's 7-byte record at wDA72 + 7 * target (that is, wDA72 + 7 * target); DE points at it (E-0095)
; 7 call sites from 7 routines (e.g. AttackDamageScaledBySlotResistancesByte0Bits54, ActionEffect_Watershot_RollSkillDamageFromRecord, ActionEffect_Geyser_HLToBattleStatus8EntryOfBattleTarget_Bank36, ActionEffect_BigBang_RollSkillDamageFromRecord, ...)
; reads: wBattleTarget
; points at: wSlotResistances
GetTargetSlotResistancesByte0::
Func_036_61A6:: ; address name
    ld de, wSlotResistances
    jr GetTargetSlotResistancesByte6_ReadBattleTarget

; A = byte 1 of wBattleTarget's 7-byte record at wDA72 + 7 * target (that is, wDA73 + 7 * target); DE points at it (E-0095)
; 8 call sites from 8 routines (e.g. AttackDamageScaledBySlotResistancesByte1Bits32, AttackDamageScaledBySlotResistancesByte1Bits54, AttackDamageScaledBySlotResistancesByte1Bits76, ActionEffect_Lightning_Sub01_GetTargetSlotResistancesByte1, ...)
; reads: wBattleTarget
GetTargetSlotResistancesByte1::
Func_036_61AB:: ; address name
    ld de, wSlotResistances + $1
    jr GetTargetSlotResistancesByte6_ReadBattleTarget

; A = byte 2 of wBattleTarget's 7-byte record at wDA72 + 7 * target (that is, wDA74 + 7 * target); DE points at it (E-0095)
; 5 call sites from 5 routines (e.g. RollTargetSlotResistancesByte2Bits45Chance, ActionEffect_EerieLite_HLToBattleStatus8EntryOfBattleTarget_Bank36, RollTargetSlotResistancesByte2Bits23Chance, ActionEffect_StopSpell_HLToBattleStatus8EntryOfBattleTarget_Bank36, ...)
; reads: wBattleTarget
GetTargetSlotResistancesByte2::
Func_036_61B0:: ; address name
    ld de, wSlotResistances + $2
    jr GetTargetSlotResistancesByte6_ReadBattleTarget

; A = byte 3 of wBattleTarget's 7-byte record at wDA72 + 7 * target (that is, wDA75 + 7 * target); DE points at it (E-0095)
; 6 call sites from 6 routines (e.g. RollTargetSlotResistancesByte3Bits45Chance, ActionEffect_Kamikaze_HLToBattleStatus8EntryOfBattleTarget_Bank36, DamageEightyPercentOfTargetHPScaled, ActionEffect_PanicAll_HLToBattleStatus8EntryOfBattleTarget_Bank36, ...)
; reads: wBattleTarget
GetTargetSlotResistancesByte3::
Func_036_61B5:: ; address name
    ld de, wSlotResistances + $3
    jr GetTargetSlotResistancesByte6_ReadBattleTarget

; A = byte 4 of wBattleTarget's 7-byte record at wDA72 + 7 * target (that is, wDA76 + 7 * target); DE points at it (E-0095)
; 4 call sites from 4 routines (e.g. ActionEffect_MegaMagic_WriteBattleDamageLoAndBattleDamageHi, RollTargetSlotResistancesByte4Bits01ChanceToE, ActionEffect_FrigidAir_RollSkillDamageFromRecord, ActionEffect_FireAir_RollSkillDamageFromRecord)
; reads: wBattleTarget
GetTargetSlotResistancesByte4::
Func_036_61BA:: ; address name
    ld de, wSlotResistances + $4
    jr GetTargetSlotResistancesByte6_ReadBattleTarget

; A = byte 5 of wBattleTarget's 7-byte record at wDA72 + 7 * target (that is, wDA77 + 7 * target); DE points at it (E-0095)
; 4 call sites from 4 routines (e.g. ActionEffect_DanceShut_HLToBattleStatus8EntryOfBattleTarget_Bank36, RollChanceVsTargetSlotResistancesByte5Bits23, ActionEffect_Curse_HLToBattleStatus8EntryOfBattleTarget_Bank36, RollTargetSlotResistancesByte5Bits67ChanceToE)
; reads: wBattleTarget
GetTargetSlotResistancesByte5::
Func_036_61BF:: ; address name
    ld de, wSlotResistances + $5
    jr GetTargetSlotResistancesByte6_ReadBattleTarget

; A = byte 6 of wBattleTarget's 7-byte record at wDA72 + 7 * target (that is, wDA78 + 7 * target); DE points at it (E-0095)
; 4 call sites from 4 routines (e.g. SkillDamageScaledBySlotResistancesByte6Bits32, ActionEffect_CallHelp_WriteBattleDamageLoAndBattleDamageHi, ActionEffect_RockThrow_RollSkillDamageFromRecord, ActionEffect_MouthShut_HLToBattleStatus8EntryOfBattleTarget_Bank36)
; reads: wBattleTarget
GetTargetSlotResistancesByte6::
Func_036_61C4:: ; address name
    ld de, wSlotResistances + $6

GetTargetSlotResistancesByte6_ReadBattleTarget::
Jump_036_61C7:: ; address name
    ld a, [wBattleTarget]
    ld b, a
    add a, a
    add a, b
    add a, a
    add a, b
    add a, e
    ld e, a
    jr nc, .done
    inc d

.done:
    ld a, [de]
    ret

; picks the chance table by the flags at [HL]: bit 6 set uses RollChanceByLevel_100_75_40_0, else bit 7 set uses RollChanceByLevel_100_100_75_0, else RollChanceByLevel_100_84_50_0 (A = level) (E-0095)
; 12 call sites from 12 routines (e.g. ActionEffect_MouthShut_HLToBattleStatus8EntryOfBattleTarget_Bank36, ActionEffect_DanceShut_HLToBattleStatus8EntryOfBattleTarget_Bank36, ActionEffect_Geyser_HLToBattleStatus8EntryOfBattleTarget_Bank36, RollChanceVsTargetSlotResistancesByte5Bits23, ...)
RollChanceByFlagsAtHL::
Func_036_61D6:: ; address name
    bit 6, [hl]
    jr z, .skip
    call RollChanceByLevel_100_75_40_0
    jr .return

.skip:
    bit 7, [hl]
    jr z, .call_roll_chance_by_level_100_84_50_0
    call RollChanceByLevel_100_100_75_0
    jr .return

.call_roll_chance_by_level_100_84_50_0:
    call RollChanceByLevel_100_84_50_0

.return:
    ret

; only called from ActionEffect_Sacrifice_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Sacrifice_ZIfAllyActorInBattleKindMode2Or3)
ActionEffect_Sacrifice_Sub01_RollChanceByLevel_100_84_50_0::
Func_036_61EC:: ; address name
    bit 6, [hl]
    jr z, .call_roll_chance_by_level_100_100_75_0
    call RollChanceByLevel_100_84_50_0
    jr .return

.call_roll_chance_by_level_100_100_75_0:
    call RollChanceByLevel_100_100_75_0

.return:
    ret

; bit 6 of [HL]: RollChanceByLevelAndSide; else bit 7: RollChanceByLevel_100_100_75_0; else RollChanceByLevel_100_75_40_0 (E-0122)
; 2 call sites from 2 routines (e.g. RollTargetSlotResistancesByte2Bits45Chance, RollTargetSlotResistancesByte1Bits01Chance)
RollChanceByHLBits6And7::
Func_036_61F9:: ; address name
    bit 6, [hl]
    jr z, .skip
    call RollChanceByLevelAndSide
    jr .return

.skip:
    bit 7, [hl]
    jr z, .call_roll_chance_by_level_100_75_40_0
    call RollChanceByLevel_100_100_75_0
    jr .return

.call_roll_chance_by_level_100_75_40_0:
    call RollChanceByLevel_100_75_40_0

.return:
    ret

; bit 7 of [HL] set uses RollChanceByLevel_100_84_50_0, otherwise RollChanceByLevelAndSide (A = level) (E-0095)
; 7 call sites from 7 routines (e.g. RollChanceVsTargetSlotResistancesByte5Bits23, RollTargetSlotResistancesByte3Bits45Chance, RollTargetSlotResistancesByte2Bits45Chance, ActionEffect_Curse_HLToBattleStatus8EntryOfBattleTarget_Bank36, ...)
RollChanceByFlagsAtHLSided::
Func_036_620F:: ; address name
    bit 7, [hl]
    jr z, .call_roll_chance_by_level_and_side
    call RollChanceByLevel_100_84_50_0
    jr .return

.call_roll_chance_by_level_and_side:
    call RollChanceByLevelAndSide

.return:
    ret

; bit 6 of [HL] set uses ScaleDamageByLevel_1_075_04_0, else bit 7 set uses ScaleDamageByLevel_131_116_075_03, else ScaleDamageByLevel_1_085_05_0 (A = level) (E-0095)
; 12 call sites from 12 routines (e.g. SkillDamageScaledBySlotResistancesByte6Bits32, ActionEffect_CallHelp_WriteBattleDamageLoAndBattleDamageHi, ActionEffect_Watershot_RollSkillDamageFromRecord, ActionEffect_RockThrow_RollSkillDamageFromRecord, ...)
ScaleDamageByFlagsAtHL::
Func_036_621C:: ; address name
    bit 6, [hl]
    jr z, .skip
    call ScaleDamageByLevel_1_075_04_0
    jr .return

.skip:
    bit 7, [hl]
    jr z, .call_scale_damage_by_level_1_085_05_0
    call ScaleDamageByLevel_131_116_075_03
    jr .return

.call_scale_damage_by_level_1_085_05_0:
    call ScaleDamageByLevel_1_085_05_0

.return:
    ret

; bit 6 of [HL] set uses ScaleDamageByLevel_075_05_025_0, else bit 7 set uses ScaleDamageByLevel_131_116_075_03, else ScaleDamageByLevel_1_075_04_0 (A = level) (E-0096)
; 6 call sites from 6 routines (e.g. ActionEffect_Watershot_RollSkillDamageFromRecord, ActionEffect_MegaMagic_WriteBattleDamageLoAndBattleDamageHi, ActionEffect_MultiCut_LoadSkillRecord, ActionEffect_FrigidAir_RollSkillDamageFromRecord, ...)
ScaleDamageByFlagsAtHLAlt::
Func_036_6232:: ; address name
    bit 6, [hl]
    jr z, .skip
    call ScaleDamageByLevel_075_05_025_0
    jr .return

.skip:
    bit 7, [hl]
    jr z, .call_scale_damage_by_level_1_075_04_0
    call ScaleDamageByLevel_131_116_075_03
    jr .return

.call_scale_damage_by_level_1_075_04_0:
    call ScaleDamageByLevel_1_075_04_0

.return:
    ret

; bit 6 of [HL] set uses ScaleDamageByLevel_1_085_05_0, otherwise ScaleDamageByLevel_131_116_075_03 (A = level) (E-0096)
; 4 call sites from 4 routines (e.g. AttackDamageScaledBySlotResistancesByte1Bits32, AttackDamageScaledBySlotResistancesByte1Bits54, AttackDamageScaledBySlotResistancesByte1Bits76, AttackDamageScaledBySlotResistancesByte0Bits54)
ScaleDamageByFlagsAtHLBit6::
Func_036_6248:: ; address name
    bit 6, [hl]
    jr z, .call_scale_damage_by_level_131_116_075_03
    call ScaleDamageByLevel_1_085_05_0
    jr .return

.call_scale_damage_by_level_131_116_075_03:
    call ScaleDamageByLevel_131_116_075_03

.return:
    ret

; bit 7 of [HL]: ScaleDamageByLevel_1_085_05_0, else ScaleDamageByLevel_075_05_025_0 (E-0122)
; no direct call (reached through a table, a jump or a vector)
ScaleDamageByLevelByHLBit7:: ; heuristic: follows a terminator; C0
Func_036_6255:: ; address name
    bit 7, [hl]
    jr z, .call_scale_damage_by_level_075_05_025_0
    call ScaleDamageByLevel_1_085_05_0
    jr .return

.call_scale_damage_by_level_075_05_025_0:
    call ScaleDamageByLevel_075_05_025_0

.return:
    ret

; bit 6 of [HL]: RollChanceByLevel_100_75_40_0; else bit 7: Func_036_6346; else Func_036_6330 (E-0122)
; no direct call (reached through a table, a jump or a vector)
RollChanceByHLBits6And7_6262:: ; heuristic: follows a terminator; C0
Func_036_6262:: ; address name
    bit 6, [hl]
    jr z, .skip
    call RollChanceByLevel_100_75_40_0
    jr .return

.skip:
    bit 7, [hl]
    jr z, .call_roll_chance_for_level_a_6330
    call RollChanceForLevelA_6346
    jr .return

.call_roll_chance_for_level_a_6330:
    call RollChanceForLevelA_6330

.return:
    ret

; A = level 0-3: success always for 0, when wC5E7 < $D8 (216/256) for 1, < $7F (127/256) for 2, never for 3; carry set = success; each roll is AdvanceRandom then wC5E7 compared with a threshold (E-0095)
; 3 call sites from 3 routines (e.g. RollChanceByFlagsAtHL, RollChanceByFlagsAtHLSided, ActionEffect_Sacrifice_Sub01_RollChanceByLevel_100_84_50_0)
; reads: wRandomLo
RollChanceByLevel_100_84_50_0::
Func_036_6278:: ; address name
    and a, a
    jr nz, .cp_01
    scf
    ret

.cp_01:
    cp a, $01
    jr nz, .cp_02
    jp RollChanceForLevelA_6346_CallAdvanceRandom

.cp_02:
    cp a, $02
    jr nz, .done
    jp RollChanceForLevelA_6346_CallAdvanceRandom3

.done:
    scf
    ccf
    ret

; A = level 0-3: success always for 0 and 1, when wC5E7 < $BF (191/256) for 2, never for 3; carry set = success; each roll is AdvanceRandom then wC5E7 compared with a threshold (E-0095)
; 3 call sites from 3 routines (e.g. RollChanceByFlagsAtHL, RollChanceByHLBits6And7, ActionEffect_Sacrifice_Sub01_RollChanceByLevel_100_84_50_0)
; reads: wRandomLo
RollChanceByLevel_100_100_75_0::
Func_036_628E:: ; address name
    cp a, $02
    jr nc, .skip
    ret

.skip:
    jr nz, .done
    jp RollChanceForLevelA_6346_CallAdvanceRandom2

.done:
    scf
    ccf
    ret

; A = level 0-3: success always for 0, when wC5E7 < $BF for 1, < $66 (102/256) for 2, never for 3; carry set = success; each roll is AdvanceRandom then wC5E7 compared with a threshold (E-0095)
; 3 call sites from 3 routines (e.g. RollChanceByFlagsAtHL, RollChanceByHLBits6And7, RollChanceByHLBits6And7_6262)
; reads: wRandomLo
RollChanceByLevel_100_75_40_0::
Func_036_629B:: ; address name
    and a, a
    jr nz, .cp_01
    scf
    ret

.cp_01:
    cp a, $01
    jr nz, .cp_02
    jp RollChanceForLevelA_6346_CallAdvanceRandom2

.cp_02:
    cp a, $02
    jr nz, .done
    jp RollChanceForLevelA_6346_CallAdvanceRandom4

.done:
    scf
    ccf
    ret

; A = level 0-3: for a target in slots 0-3 (unless wC58A = 1) success when wC5E7 < $7F, $4C, $26 for levels 0-2 (about 50%, 30%, 15%); otherwise < $BF, $7F, $3F (about 75%, 50%, 25%); never for level 3; carry set = success; each roll is AdvanceRandom then wC5E7 compared with a threshold (E-0095)
; 2 call sites from 2 routines (e.g. RollChanceByFlagsAtHLSided, RollChanceByHLBits6And7)
; reads: wLinkMode, wBattleTarget, wRandomLo
RollChanceByLevelAndSide::
Func_036_62B1:: ; address name
    push af
    ld a, [wLinkMode]
    cp a, $01
    jr z, .restore
    ld a, [wBattleTarget]
    cp a, $04
    jr nc, .restore
    pop af
    jp RollChanceForLevelA_6346_Skip

.restore:
    pop af
    and a, a
    jr nz, .cp_01
    jp RollChanceForLevelA_6346_CallAdvanceRandom2

.cp_01:
    cp a, $01
    jr nz, .cp_02
    jp RollChanceForLevelA_6346_CallAdvanceRandom3

.cp_02:
    cp a, $02
    jr nz, .done
    jp RollChanceForLevelA_6346_CallAdvanceRandom6

.done:
    scf
    ccf
    ret

; A = level 0-3: scales the damage word wBattleDamageLo/wD873 by 1 (unchanged), 85/100, 1/2 or 0 (E-0095)
; 3 call sites from 3 routines (e.g. ScaleDamageByFlagsAtHL, ScaleDamageByFlagsAtHLBit6, ScaleDamageByLevelByHLBit7)
; reads: wBattleDamageLo, wBattleDamageHi
; writes: wBattleDamageLo, wBattleDamageHi
ScaleDamageByLevel_1_085_05_0::
Func_036_62DC:: ; address name
    and a, a
    ret z
    cp a, $01
    jr nz, .cp_02
    jp RollChanceForLevelA_6346_ReadBattleDamageLo3

.cp_02:
    cp a, $02
    jr nz, .skip
    jp RollChanceForLevelA_6346_ReadBattleDamageLo5

.skip:
    jp ScaleDamageTo40Percent_ClearBattleDamageLo

; A = level 0-3: scales the damage word wBattleDamageLo/wD873 by 1 (unchanged), 3/4, 0.4 or 0 (E-0095)
; 2 call sites from 2 routines (e.g. ScaleDamageByFlagsAtHL, ScaleDamageByFlagsAtHLAlt)
; reads: wBattleDamageLo, wBattleDamageHi
; writes: wBattleDamageLo, wBattleDamageHi
ScaleDamageByLevel_1_075_04_0::
Func_036_62EF:: ; address name
    and a, a
    ret z
    cp a, $01
    jr nz, .cp_02
    jp RollChanceForLevelA_6346_ReadBattleDamageLo4

.cp_02:
    cp a, $02
    jr nz, .skip
    jp ScaleDamageTo40Percent

.skip:
    jp ScaleDamageTo40Percent_ClearBattleDamageLo

; A = level 0-3: scales the damage word wBattleDamageLo/wD873 by 21/16, 37/32, 3/4 or 0.3 (E-0095)
; 3 call sites from 3 routines (e.g. ScaleDamageByFlagsAtHL, ScaleDamageByFlagsAtHLBit6, ScaleDamageByFlagsAtHLAlt)
; reads: wBattleDamageLo, wBattleDamageHi
; writes: wBattleDamageLo, wBattleDamageHi
ScaleDamageByLevel_131_116_075_03::
Func_036_6302:: ; address name
    and a, a
    jr nz, .cp_01
    jp RollChanceForLevelA_6346_ReadBattleDamageLo

.cp_01:
    cp a, $01
    jr nz, .cp_02
    jp RollChanceForLevelA_6346_ReadBattleDamageLo2

.cp_02:
    cp a, $02
    jr nz, .skip
    jp RollChanceForLevelA_6346_ReadBattleDamageLo4

.skip:
    jp ScaleDamageTo40Percent_ReadBattleDamageLo

; A = level 0-3: scales the damage word wBattleDamageLo/wD873 by 3/4, 1/2, 1/4 or 0 (E-0095)
; 2 call sites from 2 routines (e.g. ScaleDamageByFlagsAtHLAlt, ScaleDamageByLevelByHLBit7)
; reads: wBattleDamageLo, wBattleDamageHi
; writes: wBattleDamageLo, wBattleDamageHi
ScaleDamageByLevel_075_05_025_0::
Func_036_6319:: ; address name
    and a, a
    jr nz, .cp_01
    jp RollChanceForLevelA_6346_ReadBattleDamageLo4

.cp_01:
    cp a, $01
    jr nz, .cp_02
    jp RollChanceForLevelA_6346_ReadBattleDamageLo5

.cp_02:
    cp a, $02
    jr nz, .skip
    jp ScaleDamageTo40Percent_ReadBattleDamageLo2

.skip:
    jp ScaleDamageTo40Percent_ClearBattleDamageLo

; level A: 0 returns carry; 1, 2 and 3 take three different chance rolls (E-0122)
; 1 call site from 1 routine (e.g. RollChanceByHLBits6And7_6262)
; reads: wRandomLo
RollChanceForLevelA_6330:: ; heuristic: follows a terminator; C0
Func_036_6330:: ; address name
    and a, a
    jr nz, .cp_01
    scf
    ret

.cp_01:
    cp a, $01
    jr nz, .cp_02
    jp RollChanceForLevelA_6346_CallAdvanceRandom2

.cp_02:
    cp a, $02
    jr nz, .skip
    jp RollChanceForLevelA_6346_CallAdvanceRandom3

.skip:
    jp RollChanceForLevelA_6346_CallAdvanceRandom6

; level A: 0 and 1 return, 2 and 3 take chance rolls; the following entries roll random values against $D8, $BF, $7F, $66, $4C, $3F and $26 (E-0130)
; 2 call sites from 2 routines (e.g. ActionEffect_Sacrifice_ZIfAllyActorInBattleKindMode2Or3, RollChanceByHLBits6And7_6262)
; reads: wRandomLo
RollChanceForLevelA_6346::
Func_036_6346:: ; address name
    cp a, $02
    jr nc, .skip
    ret

.skip:
    jr nz, .skip2
    jp RollChanceForLevelA_6346_CallAdvanceRandom2

.skip2:
    jp RollChanceForLevelA_6346_CallAdvanceRandom4

RollChanceForLevelA_6346_Skip::
Jump_036_6353:: ; address name
    and a, a
    jr nz, .cp_01
    jp RollChanceForLevelA_6346_CallAdvanceRandom3

.cp_01:
    cp a, $01
    jr nz, .cp_02
    jp RollChanceForLevelA_6346_CallAdvanceRandom5

.cp_02:
    cp a, $02
    jr nz, .done
    jp RollChanceForLevelA_6346_CallAdvanceRandom7

.done:
    scf
    ccf
    ret

RollChanceForLevelA_6346_CallAdvanceRandom::
Jump_036_636A:: ; address name
    call AdvanceRandom
    ld a, [wRandomLo]
    cp a, $D8
    ret

RollChanceForLevelA_6346_CallAdvanceRandom2::
Jump_036_6373:: ; address name
    call AdvanceRandom
    ld a, [wRandomLo]
    cp a, $BF
    ret

RollChanceForLevelA_6346_CallAdvanceRandom3::
Jump_036_637C:: ; address name
    call AdvanceRandom
    ld a, [wRandomLo]
    cp a, $7F
    ret

RollChanceForLevelA_6346_CallAdvanceRandom4::
Jump_036_6385:: ; address name
    call AdvanceRandom
    ld a, [wRandomLo]
    cp a, $66
    ret

RollChanceForLevelA_6346_CallAdvanceRandom5::
Jump_036_638E:: ; address name
    call AdvanceRandom
    ld a, [wRandomLo]
    cp a, $4C
    ret

RollChanceForLevelA_6346_CallAdvanceRandom6::
Jump_036_6397:: ; address name
    call AdvanceRandom
    ld a, [wRandomLo]
    cp a, $3F
    ret

RollChanceForLevelA_6346_CallAdvanceRandom7::
Jump_036_63A0:: ; address name
    call AdvanceRandom
    ld a, [wRandomLo]
    cp a, $26
    ret

RollChanceForLevelA_6346_ReadBattleDamageLo::
Jump_036_63A9:: ; address name
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    call ScaleHLBy21Over16
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ret

RollChanceForLevelA_6346_ReadBattleDamageLo2::
Jump_036_63BD:: ; address name
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    call ScaleHLBy37Over32
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ret

RollChanceForLevelA_6346_ReadBattleDamageLo3::
Jump_036_63D1:: ; address name
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    call ScaleHLTo85Percent
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ret

RollChanceForLevelA_6346_ReadBattleDamageLo4::
Jump_036_63E5:: ; address name
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    call ScaleHLTo75Percent
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ret

RollChanceForLevelA_6346_ReadBattleDamageLo5::
Jump_036_63F9:: ; address name
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    call ShiftHLRight1
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ret

; damage = 40 percent; the following entries scale it to 30 percent, a quarter or 0 (E-0125)
; 1 call site from 1 routine (e.g. HealTargetHP)
; reads: wBattleDamageLo, wBattleDamageHi
; writes: wBattleDamageLo, wBattleDamageHi
ScaleDamageTo40Percent::
Func_036_640D:: ; address name
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    call ScaleHLTo40Percent
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ret

ScaleDamageTo40Percent_ReadBattleDamageLo::
Jump_036_6421:: ; address name
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    call ScaleHLTo30Percent
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ret

ScaleDamageTo40Percent_ReadBattleDamageLo2::
Jump_036_6435:: ; address name
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    call ShiftHLRight2
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ret

ScaleDamageTo40Percent_ClearBattleDamageLo::
Jump_036_6449:: ; address name
    xor a, a
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a
    ret

; the damage word = ScaleHLBy3Over2 of itself (x 1.5) (E-0118)
; 3 call sites from 3 routines (e.g. ActionEffect_ActionD4_SkillDamageScaledBySlotResistancesByte6Bits32, ActionEffect_ActionD3_SkillDamageScaledBySlotResistancesByte6Bits32, ActionEffect_ActionD2_SkillDamageScaledBySlotResistancesByte6Bits32)
; reads: wBattleDamageLo, wBattleDamageHi
; writes: wBattleDamageLo, wBattleDamageHi
ScaleDamageBy3Over2::
Func_036_6451:: ; address name
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    call ScaleHLBy3Over2
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ret

; HL += HL / 2 (rounded down); BC = the old HL (E-0115)
; 3 call sites from 3 routines (e.g. AttackDamageTimes1_5IfSlotDamageFlagsBit0, ScaleDamageBy3Over2, ActionEffect_PsycheUp)
ScaleHLBy3Over2::
Func_036_6465:: ; address name
    ld b, h
    ld c, l
    call ShiftHLRight1
    add hl, bc
    ret

; HL += HL / 4 + HL / 16 (each shift rounds down); BC = HL / 16 (E-0095)
; 2 call sites from 2 routines (e.g. RollChanceForLevelA_6346, ActionEffect_MultiCut_LoadSkillRecord)
ScaleHLBy21Over16::
Func_036_646C:: ; address name
    ld b, h
    ld c, l
    call ShiftBCRight2
    add hl, bc
    call ShiftBCRight2
    add hl, bc
    ret

; HL += HL / 8 + HL / 32 (each shift rounds down) (E-0095)
; 1 call site from 1 routine (e.g. RollChanceForLevelA_6346)
ScaleHLBy37Over32::
Func_036_6477:: ; address name
    ld b, h
    ld c, l
    call ShiftBCRight3
    add hl, bc
    call ShiftBCRight2
    add hl, bc
    ret

; HL = HL/2 + HL/4 + HL/8 + HL/32 (each rounded down) (E-0118)
; no direct call (reached through a table, a jump or a vector)
ScaleHLBy29Over32:: ; heuristic: follows a terminator; C0
Func_036_6482:: ; address name
    call ShiftHLRight1
    ld b, h
    ld c, l
    call ShiftBCRight1
    add hl, bc
    call ShiftBCRight1
    add hl, bc
    call ShiftBCRight2
    add hl, bc
    ret

; HL = HL * 85 / 100 (24-bit intermediate); DE kept (E-0095)
; 1 call site from 1 routine (e.g. RollChanceForLevelA_6346)
ScaleHLTo85Percent::
Func_036_6494:: ; address name
    push de
    ld b, h
    ld c, l
    ld a, $55
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    pop de
    ret

; HL = HL * 8 / 10 (24-bit intermediate; Multiply8By16 then Divide24ByA), A = the remainder; DE kept (E-0067) (the same 15 bytes appear in 2 banks)
; 5 call sites from 5 routines (e.g. ScaleHLTo40Percent, ActionEffect_Geyser_ScaleHLTo80Percent_Bank36, DamageEightyPercentOfTargetHPScaled, ActionEffect_RainSlash, ...)
ScaleHLTo80Percent_Bank36::
Func_036_64A3:: ; address name
    push de
    ld b, h
    ld c, l
    ld a, $08
    call Multiply8By16
    ld a, $0A
    call Divide24ByA
    pop de
    ret

; HL = HL / 2 + HL / 4; BC kept (E-0095)
; 2 call sites from 2 routines (e.g. RollChanceForLevelA_6346, ActionEffect_BiAttack_ShiftHLRight1)
ScaleHLTo75Percent::
Func_036_64B2:: ; address name
    push bc
    call ShiftHLRight1
    ld b, h
    ld c, l
    call ShiftBCRight1
    add hl, bc
    pop bc
    ret

; HL = HL * 6 / 10 (24-bit intermediate); DE kept (E-0095)
; 3 call sites from 3 routines (e.g. ScaleHLTo30Percent, ActionEffect_Geyser_ScaleHLTo60Percent, ActionEffect_RainSlash)
ScaleHLTo60Percent::
Func_036_64BE:: ; address name
    push de
    ld b, h
    ld c, l
    ld a, $06
    call Multiply8By16
    ld a, $0A
    call Divide24ByA
    pop de
    ret

; HL = (HL * 8 / 10) / 2 (E-0095)
; 5 call sites from 5 routines (e.g. ScaleDamageTo40Percent, ActionEffect_Lightning_ShiftBCRight1, ActionEffect_Vacuum_ShiftBCRight1, ActionEffect_MegaMagic_WriteBattleDamageLoAndBattleDamageHi, ...)
ScaleHLTo40Percent::
Func_036_64CD:: ; address name
    call ScaleHLTo80Percent_Bank36
    call ShiftHLRight1
    ret

; HL = (HL * 6 / 10) / 2 (E-0095)
; 2 call sites from 2 routines (e.g. ScaleDamageTo40Percent, ActionEffect_WindBeast_ShiftBCRight1)
ScaleHLTo30Percent::
Func_036_64D4:: ; address name
    call ScaleHLTo60Percent
    call ShiftHLRight1
    ret

; HL = HL / 3 (DivideHLByBC with BC = 3) (E-0095)
; 4 call sites from 4 routines (e.g. RaiseTargetAGL, RaiseTargetDEF, ActionEffect_UltraDown_Sub02_GetBattleDEF, ResolveStepDamageMessage_Sub04_Sub01_GetBaseAGLOfSlotA)
DivideHLBy3::
Func_036_64DB:: ; address name
    ld bc, $0003
    call DivideHLByBC
    ret

; only called from ActionEffect_Geyser (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Geyser)
ActionEffect_Geyser_ScaleHLTo60Percent::
Func_036_64E2:: ; address name
    call ScaleHLTo60Percent
    call ShiftHLRight1
    call ShiftHLRight1
    ret

; only called from ActionEffect_Geyser (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Geyser)
ActionEffect_Geyser_ScaleHLTo80Percent_Bank36::
Func_036_64EC:: ; address name
    call ScaleHLTo80Percent_Bank36
    call ShiftHLRight1
    call ShiftHLRight1
    call ShiftHLRight1
    call ShiftHLRight1
    ret

; HL = table, A = index: HL = the word at HL + 2 * A (AddDoubleAToHL_Bank36) (E-0115)
; 1 call site from 1 routine (e.g. SlotAGLBelowBuffCap)
ReadWordTableEntry_Bank36::
Func_036_64FC:: ; address name
    call AddDoubleAToHL_Bank36
    deref_hl
    ret

; BC >>= 3 (falls through ShiftBCRight2) (E-0095)
; 1 call site from 1 routine (e.g. ScaleHLBy37Over32)
ShiftBCRight3::
Func_036_6503:: ; address name
    srl b
    rr c

; BC >>= 2 (falls through ShiftBCRight1) (E-0095)
; 5 call sites from 4 routines (e.g. ScaleHLBy21Over16, ScaleHLBy37Over32, ActionEffect_BiAttack_ShiftHLRight1, ScaleHLBy29Over32)
ShiftBCRight2::
Func_036_6507:: ; address name
    srl b
    rr c

; BC >>= 1 (unsigned) (E-0064)
; 12 call sites from 11 routines (e.g. ScaleHLTo75Percent, ActionEffect_BiAttack_ShiftHLRight1, ActionEffect_Lightning_ShiftBCRight1, ActionEffect_Vacuum_ShiftBCRight1, ...)
ShiftBCRight1::
Func_036_650B:: ; address name
    srl b
    rr c
    ret

; HL >>= 4 (unsigned): two shifts, then falls through ShiftHLRight2 (E-0064)
; 3 call sites from 1 routine (e.g. ComputeBasicDamage)
ShiftHLRight4::
Func_036_6510:: ; address name
    srl h
    rr l
    srl h
    rr l

; HL >>= 2 (unsigned): one shift, then falls through ShiftHLRight1 (E-0064)
; 4 call sites from 4 routines (e.g. ScaleDamageTo40Percent, ActionEffect_Lightning_ShiftBCRight1, ActionEffect_Vacuum_ShiftBCRight1, ActionEffect_MegaMagic_WriteBattleDamageLoAndBattleDamageHi)
ShiftHLRight2::
Func_036_6518:: ; address name
    srl h
    rr l

; HL >>= 1 (unsigned) (E-0064)
; 17 call sites from 13 routines (e.g. ScaleHLTo75Percent, ScaleHLTo40Percent, ScaleHLTo30Percent, RollChanceForLevelA_6346, ...)
ShiftHLRight1::
Func_036_651C:: ; address name
    srl h
    rr l
    ret

; slot A: carry when its DEF is below 999 and below 2x (4x for foes outside link battles... allies) its base DEF; NC otherwise (E-0124)
; 2 call sites from 1 routine (e.g. RaiseTargetDEF)
; reads: wBattleArg0, wLinkMode
; writes: wBattleArg0
SlotDEFBelowBuffCap::
Func_036_6521:: ; address name
    ld [wBattleArg0], a
    call GetBattleDEF
    ld bc, $03E7
    call CompareHLToBC
    jr nc, SlotDEFBelowBuffCap_Skip3
    push hl
    ld a, [wBattleArg0]
    call GetBaseDEFOfSlotA
    ld a, [wLinkMode]
    cp a, $01
    jr z, SlotDEFBelowBuffCap_Skip
    ld a, [wBattleArg0]
    cp a, $04
    jr nc, SlotDEFBelowBuffCap_Skip2

SlotDEFBelowBuffCap_Skip::
Jump_036_6544:: ; address name
    sla c
    rl b

SlotDEFBelowBuffCap_Skip2::
Jump_036_6548:: ; address name
    sla c
    rl b
    pop hl
    call CompareHLToBC
    jr nc, SlotDEFBelowBuffCap_Skip3

SlotDEFBelowBuffCap_Loop::
Jump_036_6552:: ; address name
    scf
    ret

SlotDEFBelowBuffCap_Skip3::
Jump_036_6554:: ; address name
    jr z, SlotDEFBelowBuffCap_Loop
    xor a, a
    ret

; slot A: carry when its AGL is below 999 and below 2x (4x for allies or link battles) its base AGL (E-0125)
; 2 call sites from 1 routine (e.g. RaiseTargetAGL)
; reads: wBattleArg0, wLinkMode
; writes: wBattleArg0
; points at: wBattleAGL
SlotAGLBelowBuffCap::
Func_036_6558:: ; address name
    ld [wBattleArg0], a
    ld hl, wBattleAGL
    call ReadWordTableEntry_Bank36
    ld bc, $03E7
    call CompareHLToBC
    jr z, .skip2
    jr nc, .skip2
    push hl
    ld a, [wBattleArg0]
    call GetBaseAGLOfSlotA
    ld a, [wLinkMode]
    cp a, $01
    jr z, SlotDEFBelowBuffCap_Skip
    ld a, [wBattleArg0]
    cp a, $04
    jr nc, .skip
    sla c
    rl b

.skip:
    sla c
    rl b
    pop hl
    call CompareHLToBC
    jr nc, .skip2

.loop:
    scf
    ret

.skip2:
    jr z, .loop
    xor a, a
    ret

; loads the species record of wBattleTarget's monster id (TargetMonsterIdAddress, LoadSpeciesRecord); A = its family (E-0069)
; 15 call sites from 15 routines (e.g. AttackDamageHalvedDEFVsWater, AttackDamageHalvedDEFVsMaterial, AttackDamageHalvedDEFVsZombie, AttackDamageHalvedDEFVsDemon, ...)
; reads: wSpeciesRecord
; writes: wSpeciesIdLo, wSpeciesIdHi
GetTargetSpeciesFamily::
Func_036_6594:: ; address name
    call TargetMonsterIdAddress
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesRecord]
    ret

; HL = wBattleMonsterId + 2 * wBattleTarget, the target's monster id word (E-0069)
; 1 call site from 1 routine (e.g. GetTargetSpeciesFamily)
; reads: wBattleTarget
; points at: wBattleMonsterId
TargetMonsterIdAddress::
Func_036_65A9:: ; address name
    ld a, [wBattleTarget]
    add a, a
    ld hl, wBattleMonsterId
    add_a_to_hl
    ret

; A = level: returns A unchanged when it is 3; otherwise A = 4 when bit 2 of the actor's wD854 entry (word per slot) is set, else A unchanged; BC, HL kept (E-0096)
; 16 call sites from 16 routines (e.g. ActionEffect_MouthShut_HLToBattleStatus8EntryOfBattleTarget_Bank36, ActionEffect_DanceShut_HLToBattleStatus8EntryOfBattleTarget_Bank36, RollChanceVsTargetSlotResistancesByte5Bits23, RollTargetSlotResistancesByte3Bits45Chance, ...)
; reads: wBattleActor
; points at: wSlotFlags854
ForceLevel4IfActorSlotFlags854Bit2::
Func_036_65B6:: ; address name
    cp a, $03
    ret z
    push bc
    push hl
    ld b, a
    ld a, [wBattleActor]
    ld hl, wSlotFlags854
    add a, a
    add_a_to_hl
    ld a, [hl]
    and a, $04
    jr nz, .skip
    ld a, b
    pop hl
    pop bc
    ret

.skip:
    ld a, $04
    pop hl
    pop bc
    ret

; only called from ActionEffect_RobMagic_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_RobMagic_DrainTargetMPAmount)
ActionEffect_RobMagic_Sub01_GetBattleMP::
Func_036_65D6:: ; address name
    push hl
    push bc
    ld b, a
    call GetBattleMP
    push hl
    ld a, b
    call GetBattleMaxMP
    pop bc
    call CompareHLToBC
    pop bc
    pop hl
    ret

; only called from ActionEffect_Transform_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Transform_Sub01_SlotSpeciesNibblesD00AD00B_Sub01)
; reads: wBattleStatResultLo, wBattleStatResultHi
ActionEffect_Transform_Sub01_GetBaseHP::
Func_036_65E8:: ; address name
    push hl
    ld c, a
    farcall GetBaseHP
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    ld hl, $03E7
    call CompareHLToBC
    jr nc, .done
    ld bc, $03E7

.done:
    pop hl
    ret

; only called from ActionEffect_Transform_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Transform_Sub01_SlotSpeciesNibblesD00AD00B_Sub01)
; reads: wBattleStatResultLo, wBattleStatResultHi
ActionEffect_Transform_Sub01_GetBaseMP::
Func_036_6605:: ; address name
    push hl
    ld c, a
    farcall GetBaseMP
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    ld hl, $03E7
    call CompareHLToBC
    jr nc, .done
    ld bc, $03E7

.done:
    pop hl
    ret

; A = battle slot: BC = the slot's base ATK (GetBaseATK, wBattleStatResultLo/Hi) (E-0096)
; 1 call site from 1 routine (e.g. ActionEffect_Transform_Sub01_SlotSpeciesNibblesD00AD00B_Sub01)
; reads: wBattleStatResultLo, wBattleStatResultHi
GetBaseATKOfSlotA::
Func_036_6622:: ; address name
    push hl
    ld c, a
    farcall GetBaseATK
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    pop hl
    ret

; A = battle slot: BC = the slot's base DEF (GetBaseDEF); HL kept (E-0096)
; 4 call sites from 4 routines (e.g. RaiseTargetDEF, SlotDEFBelowBuffCap, ActionEffect_UltraDown_Sub02_GetBattleDEF, ActionEffect_Transform_Sub01_SlotSpeciesNibblesD00AD00B_Sub01)
; reads: wBattleStatResultLo, wBattleStatResultHi
GetBaseDEFOfSlotA::
Func_036_6634:: ; address name
    push hl
    ld c, a
    farcall GetBaseDEF
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    pop hl
    ret

; A = battle slot: BC = the slot's base AGL (GetBaseAGL); HL kept (E-0096)
; 4 call sites from 4 routines (e.g. RaiseTargetAGL, SlotAGLBelowBuffCap, ActionEffect_Transform_Sub01_SlotSpeciesNibblesD00AD00B_Sub01, ResolveStepDamageMessage_Sub04_Sub01_GetBaseAGLOfSlotA)
; reads: wBattleStatResultLo, wBattleStatResultHi
GetBaseAGLOfSlotA::
Func_036_6646:: ; address name
    push hl
    ld c, a
    farcall GetBaseAGL
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    pop hl
    ret

; only called from ActionEffect_Transform_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Transform_Sub01_SlotSpeciesNibblesD00AD00B_Sub01)
; reads: wRecordBuffer
; writes: wMonsterId, wSpeciesIdLo, wSpeciesIdHi
; points at: wSpecialSlotMonsters
ActionEffect_Transform_Sub01_BattlerRecordFieldAddress::
Func_036_6658:: ; address name
    ld b, a
    and a, $03
    cp a, $03
    jr z, .skip
    ld a, b
    ld e, $31
    call BattlerRecordFieldAddress
    jr .return

.skip:
    ld a, b
    srl a
    srl a
    and a, $01
    ld hl, wSpecialSlotMonsters
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wMonsterId + $1], a
    farcall LoadMonsterRecord
    ld a, [wRecordBuffer]
    ld [wSpeciesIdLo], a
    ld a, [wRecordBuffer + $1]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld hl, wSpeciesRecord + $12

.return:
    ret

; only called from ActionEffect_Transform_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Transform_Sub01_SlotSpeciesNibblesD00AD00B_Sub01)
; writes: wMonsterId
; points at: wSpecialSlotMonsters, wRecordBufferData
ActionEffect_Transform_Sub01_BattlerRecordFieldAddress_Sub04::
Func_036_669E:: ; address name
    ld b, a
    and a, $03
    cp a, $03
    jr z, .skip
    ld a, b
    ld e, $0E
    call BattlerRecordFieldAddress
    ld b, $08
    jr .return

.skip:
    ld a, b
    srl a
    srl a
    and a, $01
    ld hl, wSpecialSlotMonsters
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wMonsterId + $1], a
    farcall LoadMonsterRecord
    ld hl, wRecordBufferData
    ld b, $04

.return:
    ret

; only called from ActionEffect_Transform_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Transform_Sub01_SlotSpeciesNibblesD00AD00B_Sub01)
ActionEffect_Transform_Sub01_SlotSpeciesNibblesD00AD00B::
Func_036_66D6:: ; address name
    push hl
    ld c, a
    farcall SlotSpeciesNibblesD00AD00B
    pop hl
    ret

; halves the target's wBattleDEF word, runs ComputeAttackDamage (which halves DEF again, so the effective DEF is a quarter), then restores the DEF word (E-0096)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; points at: wBattleDEF
ComputeAttackDamageWithHalvedDEF::
Jump_036_66E0:: ; address name
    ld a, [wBattleTarget]
    add a, a
    ld hl, wBattleDEF
    add_a_to_hl
    push hl
    ld a, [hl+]
    ld c, a
    ld b, [hl]
    push bc
    srl b
    rr c
    ld [hl], b
    dec hl
    ld [hl], c
    call ComputeAttackDamage
    pop bc
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ret

; only called from ActionEffect_BeDragon_Sub02 (E-0047)
; 2 call sites from 1 routine (e.g. ActionEffect_BeDragon_LoadMonsterRecord)
ActionEffect_BeDragon_Sub02_CompareHLToBC::
Func_036_6701:: ; address name
    add a, a
    add_a_to_hl
    push hl
    deref_hl
    call CompareHLToBC
    jr nc, .restore
    ld b, h
    ld c, l

.restore:
    pop hl
    ld [hl], c
    inc hl
    ld [hl], b
    ret

; jumps to the routine whose 16-bit address is at 36:6726 + 2 * wBattleActionId (the same JumpToHL idiom as CallInBank). The table has 240 entries (ids 0-239) and ends at $6906, where the first effect routine starts; the routines are named ActionEffect_<skill> after the skills that use them (E-0053, E-0084)
; 1 call site from 1 routine (e.g. ResolveStepActionEffect)
; reads: wBattleActionId
DispatchActionEffectTable::
Func_036_6717:: ; address name
    ld a, [wBattleActionId]
    ld c, a
    ld b, $00
    ld hl, $6726
    add hl, bc
    add hl, bc
    call JumpToWordAtHL
    ret

; E-0126 (C1: DispatchActionEffectTable (36:6717) jumps through the word at $6726 + 2 * wBattleActionId; E-0053 and E-0084 counted 240 entries ending at $6906, where the first effect routine starts).
; record: effect routine
ActionEffectTable::
Data_036_6726:: ; address name
    dw ActionEffect_Action00 ; entry 0
    dw ActionEffect_Blaze ; entry 1
    dw ActionEffect_Blaze ; entry 2
    dw ActionEffect_Blaze ; entry 3
    dw ActionEffect_Firebal ; entry 4
    dw ActionEffect_Firebal ; entry 5
    dw ActionEffect_Firebal ; entry 6
    dw ActionEffect_Bang ; entry 7
    dw ActionEffect_Bang ; entry 8
    dw ActionEffect_Bang ; entry 9
    dw ActionEffect_Infernos ; entry 10
    dw ActionEffect_Infernos ; entry 11
    dw ActionEffect_Infernos ; entry 12
    dw ActionEffect_Bolt ; entry 13
    dw ActionEffect_Bolt ; entry 14
    dw ActionEffect_Bolt ; entry 15
    dw ActionEffect_IceBolt ; entry 16
    dw ActionEffect_IceBolt ; entry 17
    dw ActionEffect_IceBolt ; entry 18
    dw ActionEffect_Beat ; entry 19
    dw ActionEffect_Beat ; entry 20
    dw ActionEffect_Sacrifice ; entry 21
    dw ActionEffect_Heal ; entry 22
    dw ActionEffect_Heal ; entry 23
    dw ActionEffect_Heal ; entry 24
    dw ActionEffect_Heal ; entry 25
    dw ActionEffect_Heal ; entry 26
    dw ActionEffect_MPass ; entry 27
    dw ActionEffect_MPass ; entry 28
    dw ActionEffect_MPass ; entry 29
    dw ActionEffect_Vivify ; entry 30
    dw ActionEffect_Revive ; entry 31
    dw ActionEffect_Farewell ; entry 32
    dw ActionEffect_Antidote ; entry 33
    dw ActionEffect_DeChaos ; entry 34
    dw ActionEffect_NumbOff ; entry 35
    dw ActionEffect_CurseOff ; entry 36
    dw ActionEffect_Upper ; entry 37
    dw ActionEffect_Upper ; entry 38
    dw ActionEffect_Sap ; entry 39
    dw ActionEffect_Sap ; entry 40
    dw ActionEffect_Speed ; entry 41
    dw ActionEffect_Speed ; entry 42
    dw ActionEffect_Slow ; entry 43
    dw ActionEffect_Slow ; entry 44
    dw ActionEffect_TwinHits ; entry 45
    dw ResolveStepDamageMessage_Sub04_RollTargetSlotResistancesByte1Bits01Chance ; entry 46
    dw ActionEffect_Sleep ; entry 47
    dw ActionEffect_Sleep ; entry 48
    dw ActionEffect_TakeMagic ; entry 49
    dw ActionEffect_RobMagic ; entry 50
    dw ActionEffect_StopSpell ; entry 51
    dw ActionEffect_PanicAll ; entry 52
    dw ActionEffect_Ironize ; entry 53
    dw ActionEffect_MagicBack ; entry 54
    dw ActionEffect_MagicBack ; entry 55
    dw ActionEffect_Barrier ; entry 56
    dw ActionEffect_MagicWall ; entry 57
    dw ActionEffect_Transform ; entry 58
    dw ActionEffect_BeDragon ; entry 59
    dw ActionEffect_Chance ; entry 60
    dw ActionEffect_MegaMagic ; entry 61
    dw ActionEffect_BigBang ; entry 62
    dw ActionEffect_Bolt ; entry 63
    dw ActionEffect_FireAir ; entry 64
    dw ActionEffect_FireAir ; entry 65
    dw ActionEffect_FireAir ; entry 66
    dw ActionEffect_FireAir ; entry 67
    dw ActionEffect_FrigidAir ; entry 68
    dw ActionEffect_FrigidAir ; entry 69
    dw ActionEffect_FrigidAir ; entry 70
    dw ActionEffect_FrigidAir ; entry 71
    dw ActionEffect_WindBeast ; entry 72
    dw ActionEffect_Vacuum ; entry 73
    dw ActionEffect_Lightning ; entry 74
    dw ActionEffect_RockThrow ; entry 75
    dw ActionEffect_Watershot ; entry 76
    dw ActionEffect_Watershot ; entry 77
    dw ActionEffect_CallHelp ; entry 78
    dw ActionEffect_CallHelp ; entry 79
    dw ActionEffect_FireSlash ; entry 80
    dw ActionEffect_VacuSlash ; entry 81
    dw ActionEffect_BoltSlash ; entry 82
    dw ActionEffect_IceSlash ; entry 83
    dw ActionEffect_SlimeBlow ; entry 84
    dw ActionEffect_DrakSlash ; entry 85
    dw ActionEffect_BeastCut ; entry 86
    dw ActionEffect_BirdBlow ; entry 87
    dw ActionEffect_BugBlow ; entry 88
    dw ActionEffect_Shears ; entry 89
    dw ActionEffect_DevilCut ; entry 90
    dw ActionEffect_ZombieCut ; entry 91
    dw ActionEffect_CleanCut ; entry 92
    dw ActionEffect_AquaCut ; entry 93
    dw ActionEffect_MetalCut ; entry 94
    dw ActionEffect_PoisonHit ; entry 95
    dw ActionEffect_PoisonHit ; entry 96
    dw ActionEffect_PoisonHit ; entry 97
    dw ActionEffect_SquallHit ; entry 98
    dw ActionEffect_BiAttack ; entry 99
    dw ActionEffect_BiAttack ; entry 100
    dw ActionEffect_RainSlash ; entry 101
    dw ActionEffect_MultiCut ; entry 102
    dw ActionEffect_GigaSlash ; entry 103
    dw ActionEffect_ChargeUp ; entry 104
    dw ActionEffect_PsycheUp ; entry 105
    dw ActionEffect_HighJump ; entry 106
    dw ActionEffect_EvilSlash ; entry 107
    dw ActionEffect_Massacre ; entry 108
    dw ActionEffect_TwinSlash ; entry 109
    dw ActionEffect_Berserker ; entry 110
    dw ActionEffect_Ramming ; entry 111
    dw ActionEffect_Kamikaze ; entry 112
    dw ActionEffect_Sleep ; entry 113
    dw ActionEffect_PalsyAir ; entry 114
    dw ActionEffect_PoisonGas ; entry 115
    dw ActionEffect_PoisonGas ; entry 116
    dw ActionEffect_Curse ; entry 117
    dw ActionEffect_OddDance ; entry 118
    dw ActionEffect_RobMagic ; entry 119
    dw ActionEffect_PanicAll ; entry 120
    dw ActionEffect_Beat ; entry 121
    dw ActionEffect_LureDance ; entry 122
    dw ActionEffect_LifeDance ; entry 123
    dw ActionEffect_Heal ; entry 124
    dw ActionEffect_SideStep ; entry 125
    dw ActionEffect_SandStorm ; entry 126
    dw ActionEffect_Radiant ; entry 127
    dw ActionEffect_EerieLite ; entry 128
    dw ActionEffect_Surge ; entry 129
    dw ActionEffect_UltraDown ; entry 130
    dw ActionEffect_DeMagic ; entry 131
    dw ActionEffect_DeMagic ; entry 132
    dw ActionEffect_TatsuCall ; entry 133
    dw ActionEffect_TatsuCall ; entry 134
    dw ActionEffect_TatsuCall ; entry 135
    dw ActionEffect_TatsuCall ; entry 136
    dw ActionEffect_SuckAir ; entry 137
    dw ActionEffect_Focus ; entry 138
    dw ActionEffect_LushLicks ; entry 139
    dw ActionEffect_LushLicks ; entry 140
    dw ActionEffect_LegSweep ; entry 141
    dw ActionEffect_LegSweep ; entry 142
    dw ActionEffect_Ahhh ; entry 143
    dw ActionEffect_WarCry ; entry 144
    dw ActionEffect_Geyser ; entry 145
    dw ActionEffect_DanceShut ; entry 146
    dw ActionEffect_MouthShut ; entry 147
    dw ActionEffect_StrongD ; entry 148
    dw ActionEffect_Dodge ; entry 149
    dw ActionEffect_StrongD ; entry 150
    dw ActionEffect_Cover ; entry 151
    dw ActionEffect_Cover ; entry 152
    dw ActionEffect_TailWind ; entry 153
    dw ActionEffect_TailWind ; entry 154
    dw ActionEffect_AquaWall ; entry 155
    dw ActionEffect_SealPray ; entry 156
    dw ActionEffect_SuckAll ; entry 157
    dw ActionEffect_Imitate ; entry 158
    dw ActionEffect_Meditate ; entry 159
    dw ActionEffect_LifeSong ; entry 160
    dw ActionEffect_LoveRain ; entry 161
    dw ActionEffect_Whistle ; entry 162
    dw ActionEffect_Whistle ; entry 163
    dw ActionEffect_Whistle ; entry 164
    dw ActionEffect_Whistle ; entry 165
    dw ActionEffect_Whistle ; entry 166
    dw ActionEffect_Whistle ; entry 167
    dw ActionEffect_Whistle ; entry 168
    dw ActionEffect_Whistle ; entry 169
    dw ActionEffect_Ahhh_79ED ; entry 170
    dw ActionEffect_ZoneOut ; entry 171
    dw ActionEffect_Guard ; entry 172
    dw ActionEffect_PanicAll ; entry 173
    dw ActionEffect_Ironize ; entry 174
    dw ActionEffect_ActionAF ; entry 175
    dw ActionEffect_ActionB0 ; entry 176
    dw ActionEffect_Heal ; entry 177
    dw ActionEffect_ActionB0 ; entry 178
    dw ActionEffect_DeMagic ; entry 179
    dw ActionEffect_ActionB4 ; entry 180
    dw ActionEffect_ActionB5 ; entry 181
    dw ActionEffect_ActionB6 ; entry 182
    dw ActionEffect_ZoneOut ; entry 183
    dw ActionEffect_BeDragon ; entry 184
    dw ActionEffect_ActionB9 ; entry 185
    dw ActionEffect_ActionBA ; entry 186
    dw ActionEffect_Revive ; entry 187
    dw ActionEffect_ActionBC ; entry 188
    dw ActionEffect_ActionBD ; entry 189
    dw ActionEffect_ActionAF ; entry 190
    dw ActionEffect_ActionBF ; entry 191
    dw ActionEffect_ActionC0 ; entry 192
    dw ActionEffect_ActionC1 ; entry 193
    dw ActionEffect_ActionC2 ; entry 194
    dw ActionEffect_ZoneOut ; entry 195
    dw ActionEffect_ZoneOut ; entry 196
    dw ActionEffect_ActionC5 ; entry 197
    dw ActionEffect_ActionC6 ; entry 198
    dw ActionEffect_ActionC6 ; entry 199
    dw ActionEffect_ActionC8 ; entry 200
    dw ActionEffect_ActionC9 ; entry 201
    dw ActionEffect_ActionC9 ; entry 202
    dw ActionEffect_ActionBF ; entry 203
    dw ActionEffect_ActionCC ; entry 204
    dw ActionEffect_ActionCD ; entry 205
    dw ActionEffect_ActionCE ; entry 206
    dw ActionEffect_ActionCF ; entry 207
    dw ActionEffect_ActionD0 ; entry 208
    dw ActionEffect_ActionD1 ; entry 209
    dw ActionEffect_ActionD2 ; entry 210
    dw ActionEffect_ActionD3 ; entry 211
    dw ActionEffect_ActionD4 ; entry 212
    dw ActionEffect_ActionD5 ; entry 213
    dw ActionEffect_ActionD6 ; entry 214
    dw ActionEffect_ActionD7 ; entry 215
    dw ActionEffect_ActionD8 ; entry 216
    dw ActionEffect_ActionD9 ; entry 217
    dw ActionEffect_ActionDA ; entry 218
    dw ActionEffect_ActionDB ; entry 219
    dw ActionEffect_ActionDC ; entry 220
    dw ActionEffect_ActionDD ; entry 221
    dw ActionEffect_ActionDE ; entry 222
    dw ActionEffect_ActionDF ; entry 223
    dw ActionEffect_ActionE0 ; entry 224
    dw ActionEffect_ActionE1 ; entry 225
    dw ActionEffect_ActionE2 ; entry 226
    dw ActionEffect_ActionE3 ; entry 227
    dw ActionEffect_ActionAF ; entry 228
    dw ActionEffect_ActionAF ; entry 229
    dw ActionEffect_ActionAF ; entry 230
    dw ActionEffect_ActionAF ; entry 231
    dw ActionEffect_ActionAF ; entry 232
    dw ActionEffect_ActionAF ; entry 233
    dw ActionEffect_ActionAF ; entry 234
    dw ActionEffect_ActionAF ; entry 235
    dw ActionEffect_ActionAF ; entry 236
    dw ActionEffect_ActionAF ; entry 237
    dw ActionEffect_ActionAF ; entry 238
    dw ActionEffect_ActionAF ; entry 239

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $D0; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_ActionD0:: ; code pointer of the table ActionEffectTable; C0
Func_036_6906:: ; address name
    call RollSkillDamageThenScaleBySlotResistancesByte1
    farcall RunA3414FAndMarkWDA5B3
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $D1; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_ActionD1:: ; code pointer of the table ActionEffectTable; C0
Func_036_6912:: ; address name
    call ActionEffect_ActionD1_RollSkillDamageFromRecord
    farcall RunA3414FAndMarkWDA5B3
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $D2; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_ActionD2:: ; code pointer of the table ActionEffectTable; C0
Func_036_691E:: ; address name
    call ActionEffect_ActionD2_SkillDamageScaledBySlotResistancesByte6Bits32
    farcall RunA3414FAndMarkWDA5B3
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $D3; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_ActionD3:: ; code pointer of the table ActionEffectTable; C0
Func_036_692A:: ; address name
    call ActionEffect_ActionD3_SkillDamageScaledBySlotResistancesByte6Bits32
    farcall RunA3414FAndMarkWDA5B3
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $D4; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_ActionD4:: ; code pointer of the table ActionEffectTable; C0
Func_036_6936:: ; address name
    call ActionEffect_ActionD4_SkillDamageScaledBySlotResistancesByte6Bits32
    farcall RunA3414FAndMarkWDA5B3
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $D5; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_ActionD5:: ; code pointer of the table ActionEffectTable; C0
Func_036_6942:: ; address name
    call SkillDamageScaledBySlotResistancesByte6Bits32
    farcall RunA3414FAndMarkWDA5B3
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $D6; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wBattleTarget
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleHP
ActionEffect_ActionD6:: ; code pointer of the table ActionEffectTable; C0
Func_036_694E:: ; address name
    farcall RunA3414FAndMarkWDA5B3
    jp ActionEffect_Sacrifice

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $D7; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_ActionD7:: ; code pointer of the table ActionEffectTable; C0
Func_036_6957:: ; address name
    farcall RunA3414FAndMarkWDA5B3
    call ActionEffect_ActionD7_AdvanceRandom
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $D8; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_ActionD8:: ; code pointer of the table ActionEffectTable; C0
Func_036_6963:: ; address name
    farcall RunA3414FAndMarkWDA5B3
    call ActionEffect_ActionD8_ComputeAttackDamage
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 217; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_ActionD9:: ; code pointer of the table ActionEffectTable; C0
Func_036_696F:: ; address name
    call ActionEffect_ActionD9_WriteBattleDamageLoAndBattleDamageHiEtc
    farcall RunA3414FAndMarkWDA5B3
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $DA; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, hTemp0
; writes: hTemp0, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget
; points at: wBattleHP, wBattleMaxHP, wBattleMP, wBattleMaxMP
ActionEffect_ActionDA:: ; code pointer of the table ActionEffectTable; C0
Func_036_697B:: ; address name
    farcall RunA3414FAndMarkWDA5B3
    xor a, a
    ldh [hTemp0], a
    call ClearDamageAndReadTargetStatus0_Bank36
    or a, a
    jr z, .read_battle_target
    ld [hl], $00
    ld a, $01
    ldh [hTemp0], a

.read_battle_target:
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank36
    deref_hl
    call CompareHLToBC
    jr z, .read_battle_target2
    call HealTargetHP
    ld a, $01
    ldh [hTemp0], a

.read_battle_target2:
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    dec hl
    ld e, l
    ld d, h
    ld a, [wBattleTarget]
    ld hl, wBattleMaxMP
    call AddDoubleAToHL_Bank36
    deref_hl
    call CompareHLToBC
    jr z, .check_temp0
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    ld a, $01
    ldh [hTemp0], a

.check_temp0:
    ldh a, [hTemp0]
    or a, a
    jr z, .skip
    ld l, $37
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $DB; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wBattleActionId, wEffectFlags2, wEffectFlags, hTemp0, hTemp1
; writes: wBattleActionId, hTemp0, hTemp1, wEffectFlags, wEffectFlags2, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg
ActionEffect_ActionDB:: ; code pointer of the table ActionEffectTable; C0
Func_036_69ED:: ; address name
    farcall RunA3414FAndMarkWDA5B3
    call ClearDamageAndReadTargetStatus0_Bank36
    call AdvanceRandom
    ld a, [wRandomLo]
    sra a
    sra a
    and a, $03
    sla a
    sla a
    ld de, $6A59
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    inc de
    ld c, a
    ld a, [hl]
    or a, c
    ld [hl], a
    ld a, [wBattleActionId]
    push af
    push de
    ld a, [de]
    cp a, $FF
    jr z, .restore
    ld [wBattleActionId], a
    ld a, [wEffectFlags2]
    ldh [hTemp0], a
    ld a, [wEffectFlags]
    ldh [hTemp1], a
    ld a, $41
    ld [wEffectFlags], a
    ld a, $30
    ld [wEffectFlags2], a
    farcall SelectEffectByEffectFlags
    farcall SelectEffectByEffectFlags2Flags
    ldh a, [hTemp0]
    ld [wEffectFlags2], a
    ldh a, [hTemp1]
    ld [wEffectFlags], a

.restore:
    pop de
    inc de
    pop af
    ld [wBattleActionId], a
    ld a, [de]
    ld l, a
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor
    db $02, $2F, $77, $00, $20, $34, $D9, $00, $40, $2F, $76, $00, $10, $34, $42, $00

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $DC; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp0, wBattleActionId
; writes: wBattleActor, wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg
; points at: wSideControl, wBattleStatus1
ActionEffect_ActionDC:: ; code pointer of the table ActionEffectTable; C0
Func_036_6A69:: ; address name
    ld a, [wBattleActor]
    push af
    farcall ActorFormationSlotToTemp0
    ldh a, [hTemp0]
    ld [wBattleActor], a
    call ActionEffect_BeDragon
    pop af
    ld [wBattleActor], a
    jp ActionEffect_BeDragon

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $DD; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wRandomLo
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleStatus1
ActionEffect_ActionDD:: ; code pointer of the table ActionEffectTable; C0
Func_036_6A82:: ; address name
    farcall RunA3414FAndMarkWDA5B3
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    set 2, [hl]
    push hl
    call AdvanceRandom
    pop hl
    ld a, $04
    add_a_to_hl
    ld a, [wRandomLo]
    and a, $04
    add a, $04
    ld b, a
    ld a, [hl]
    and a, $F3
    or a, b
    ld [hl], a
    call RaiseTargetDEF
    jr nc, .call_raise_target_agl
    ld a, [wBattleTarget]
    call SetSlotStatus6Bit6

.call_raise_target_agl:
    call RaiseTargetAGL
    jr nc, .skip
    ld a, [wBattleTarget]
    call SetSlotStatus6Bit6

.skip:
    ld l, $93
    ld bc, $0090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $DE; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleStatus1
ActionEffect_ActionDE:: ; code pointer of the table ActionEffectTable; C0
Func_036_6ACA:: ; address name
    farcall RunA3414FAndMarkWDA5B3
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    set 0, [hl]
    set 6, [hl]
    set 7, [hl]
    ld l, $9E
    ld bc, $0090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $DF; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActionId, wBattleActor, hTemp0, wSavedActorSlot, wSavedActorByte, wDefeatByteD1, wFollowUpAction
; writes: wSavedActorSlot, wSavedActorByte, wBattleActor, wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, ...
; points at: wBattleMP, wBattleMaxMP, wBattleTargetChoice
ActionEffect_ActionDF:: ; code pointer of the table ActionEffectTable; C0
Func_036_6AE7:: ; address name
    farcall RunA3414FAndMarkWDA5B3
    jp ActionEffect_RobMagic

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $E0; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp0, wBattleActionId, wDefeatByteD1, wFollowUpAction
; writes: wBattleActor, wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleStatus7, wBattleTargetChoice
ActionEffect_ActionE0:: ; code pointer of the table ActionEffectTable; C0
Func_036_6AF0:: ; address name
    farcall RunA3414FAndMarkWDA5B3
    ld a, [wBattleActor]
    push af
    farcall ActorFormationSlotToTemp0
    ldh a, [hTemp0]
    ld [wBattleActor], a
    call ActionEffect_StrongD
    pop af
    ld [wBattleActor], a
    jp ActionEffect_StrongD

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $E1; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget
; points at: wBattleStatus
ActionEffect_ActionE1:: ; code pointer of the table ActionEffectTable; C0
Func_036_6B0F:: ; address name
    farcall RunA3414FAndMarkWDA5B3
    jp ActionEffect_PanicAll

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $E2; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp0, wDefeatByteD1, wFollowUpAction
; writes: hTemp0, wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleStatus7, hTemp0, wBattleTargetChoice
ActionEffect_ActionE2:: ; code pointer of the table ActionEffectTable; C0
Func_036_6B18:: ; address name
    farcall RunA3414FAndMarkWDA5B3
    ld a, [wBattleActor]
    and a, $04
    ldh [hTemp0], a
    ld b, $04

.loop:
    ldh a, [hTemp0]
    ld c, a
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    ld a, c
    ld hl, wBattleStatus7
    call AddAx9ToHL
    set 1, [hl]

.skip:
    ld hl, hTemp0
    inc [hl]
    dec b
    jr nz, .loop
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $E3; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, hTemp0, wDefeatByteD1, wFollowUpAction
; writes: hTemp0, wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleStatus1, hTemp0, wBattleTargetChoice
ActionEffect_ActionE3:: ; code pointer of the table ActionEffectTable; C0
Func_036_6B42:: ; address name
    farcall RunA3414FAndMarkWDA5B3
    ld a, [wBattleActor]
    and a, $04
    ldh [hTemp0], a
    ld b, $03

.loop:
    ldh a, [hTemp0]
    ld c, a
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    ldh a, [hTemp0]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    set 3, [hl]
    inc hl
    inc hl
    inc hl
    res 6, [hl]
    set 7, [hl]

.skip:
    ld hl, hTemp0
    inc [hl]
    dec b
    jr nz, .loop
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 175, 190, 228, 229, 230, 231 ...; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
ActionEffect_ActionAF:: ; code pointer of the table ActionEffectTable; C0
Func_036_6B74:: ; address name
    ret

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 0 (no name); ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; 2 call sites from 2 routines (e.g. ActionEffect_ActionC2, ActionEffect_PoisonHit)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_Action00:: ; code pointer of the table ActionEffectTable; C0
Func_036_6B75:: ; address name
    call ComputeAttackDamage
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 1 Blaze, 2 Blazemore, 3 Blazemost; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_Blaze:: ; code pointer of the table ActionEffectTable; C0
Func_036_6B7B:: ; address name
    call ActionEffect_Blaze_RollSkillDamageFromRecord
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 4 Firebal, 5 Firebane, 6 Firebolt; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_Firebal:: ; code pointer of the table ActionEffectTable; C0
Func_036_6B81:: ; address name
    call ActionEffect_Firebal_RollSkillDamageFromRecord
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 7 Bang, 8 Boom, 9 Explodet; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_Bang:: ; code pointer of the table ActionEffectTable; C0
Func_036_6B87:: ; address name
    call ActionEffect_Bang_RollSkillDamageFromRecord
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 10 Infernos, 11 Infermore, 12 Infermost; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_Infernos:: ; code pointer of the table ActionEffectTable; C0
Func_036_6B8D:: ; address name
    call ActionEffect_Infernos_RollSkillDamageFromRecord
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 13 Bolt, 14 Zap, 15 Thordain, 63 Hellblast; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_Bolt:: ; code pointer of the table ActionEffectTable; C0
Func_036_6B93:: ; address name
    call RollSkillDamageThenScaleBySlotResistancesByte1
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 16 IceBolt, 17 SnowStorm, 18 Blizzard; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_IceBolt:: ; code pointer of the table ActionEffectTable; C0
Func_036_6B99:: ; address name
    call ActionEffect_IceBolt_RollSkillDamageFromRecord
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 19 Beat, 20 Defeat, 121 K.O.Dance; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleHP
ActionEffect_Beat:: ; code pointer of the table ActionEffectTable; C0
Func_036_6B9F:: ; address name
    call RollTargetSlotResistancesByte2Bits45Chance
    jr nc, .skip
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank36
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld hl, $03E8
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ld hl, $B58E
    ld bc, $80A8
    jp UnreferencedStoreResolveMessage35D0_Bank36_SetResolveMsgActor

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 21 Sacrifice; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wBattleTarget
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleHP
ActionEffect_Sacrifice:: ; code pointer of the table ActionEffectTable; C0
Func_036_6BC7:: ; address name
    call ActionEffect_Sacrifice_ZIfAllyActorInBattleKindMode2Or3
    jr nc, .skip
    call AdvanceRandom
    ld a, [wRandomLo]
    and a, $01
    jr z, .read_battle_target
    ld a, [wBattleTarget]
    call GetBattleHP
    push hl
    ld a, $64
    call DivideHLByA
    ld a, h
    or a, l
    jr nz, .restore
    ld hl, $0001

.restore:
    pop bc
    ld a, c
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    or a, c
    jr nz, .set_battle_damage_lo
    ld bc, $0001

.set_battle_damage_lo:
    ld a, c
    ld [wBattleDamageLo], a
    ld a, b
    ld [wBattleDamageHi], a
    jp ActionEffect_ActionCF_Skip

.read_battle_target:
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank36
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld hl, $03E8
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ld hl, $B58F
    ld bc, $80A8
    jp UnreferencedStoreResolveMessage35D0_Bank36_SetResolveMsgActor

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 22 Heal, 23 HealMore, 24 HealAll, 25 HealUs, 26 HealUsAll, 124 Hustle, $B1; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; 2 call sites from 2 routines (e.g. ActionEffect_LoveRain, ActionEffect_Farewell)
; reads: wBattleTarget, wDefeatByteD1, wBattleActor, wFollowUpAction
; writes: wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg, wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep, wResolveMsgActor
; points at: wBattleTargetChoice, wBattleHP, wBattleMaxHP
ActionEffect_Heal:: ; code pointer of the table ActionEffectTable; C0
Func_036_6C24:: ; address name
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .read_battle_target
    jr z, .skip2
    jr .skip

.read_battle_target:
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank36
    deref_hl
    call CompareHLToBC
    jr z, .skip
    call HealTargetHP
    ld l, $37
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip

.skip2:
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 27 MPass, 28 MPassmore, 29 MPassmost; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wDefeatByteD1, wBattleActor, wFollowUpAction
; writes: wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg, wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep, wResolveMsgActor
; points at: wBattleTargetChoice, wBattleMP, wBattleMaxMP
ActionEffect_MPass:: ; code pointer of the table ActionEffectTable; C0
Func_036_6C5E:: ; address name
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .read_battle_target
    jr z, .skip2
    jr .skip

.read_battle_target:
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wBattleMaxMP
    call AddDoubleAToHL_Bank36
    deref_hl
    call CompareHLToBC
    jr z, .skip
    call ActionEffect_MPass_AddDoubleAToHL_Bank36
    jr nc, .skip
    ld l, $C3
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip

.skip2:
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 30 Vivify; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wRandomLo, wDefeatByteD1, wBattleActor, wFollowUpAction
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget, wBattleTarget, wDefeatByteD1, ...
; points at: wBattleMaxHP, wBattleHP, wBattleMonsterId, wBattleTargetChoice
ActionEffect_Vivify:: ; code pointer of the table ActionEffectTable; C0
Func_036_6C9A:: ; address name
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jp nc, ApplyTargetMaxHPAmount_Skip
    jp z, ApplyTargetMaxHPAmount_Skip2
    call AdvanceRandom
    ld a, [wRandomLo]
    and a, $01
    jr z, ActionEffect_Vivify_Skip
    ld a, [wBattleTarget]
    ld b, a
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    srl d
    rr e

ActionEffect_Vivify_CallAddDoubleAToHL_Bank36::
Jump_036_6CC1:: ; address name
    ld a, b
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank36
    ld a, e
    ld [hl+], a
    ld [hl], d
    call TargetOnLocalSide_Bank36
    jr c, .call_action_effect_vivify_add_ax9_to_hl
    ld a, [wBattleTarget]
    ld b, a
    add a, a
    ld de, wBattleMonsterId
    add a, e
    ld e, a
    jr nc, .call_load_battle_monster_picture_for_slot_b
    inc d

.call_load_battle_monster_picture_for_slot_b:
    call LoadBattleMonsterPictureForSlotB
    jr .call_action_effect_vivify_add_ax9_to_hl

.call_action_effect_vivify_add_ax9_to_hl:
    call ActionEffect_Vivify_AddAx9ToHL
    ld l, $50
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

ActionEffect_Vivify_Skip::
Jump_036_6CED:: ; address name
    ld h, $67
    ld bc, $0080
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 31 Revive, $BB; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wDefeatByteD1, wBattleActor, wFollowUpAction
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wBattleTarget, wDefeatByteD1, wBattleSubPhase, ...
; points at: wBattleMaxHP, wBattleHP, wBattleMonsterId, wBattleTargetChoice
ActionEffect_Revive:: ; code pointer of the table ActionEffectTable; C0
Func_036_6CF5:: ; address name
    ld a, [wBattleTarget]
    and a, $03
    cp a, $03
    jr z, ApplyTargetMaxHPAmount_Skip2
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jp nc, ApplyTargetMaxHPAmount_Skip
    jp z, ApplyTargetMaxHPAmount_Skip2

; DE = the target's max HP and continues with the shared HP amount path (ActionEffect_Vivify_CallAddDoubleAToHL_Bank36) (E-0122)
; 3 call sites from 3 routines (e.g. ActionEffect_LifeSong, ActionEffect_Farewell, ApplyTargetMaxHPIfPresent)
; reads: wBattleTarget
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleMaxHP, wBattleHP, wBattleMonsterId
ApplyTargetMaxHPAmount::
Func_036_6D0A:: ; address name
    ld a, [wBattleTarget]
    ld b, a
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    jp ActionEffect_Vivify_CallAddDoubleAToHL_Bank36

ApplyTargetMaxHPAmount_Skip::
Jump_036_6D1A:: ; address name
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip

ApplyTargetMaxHPAmount_Skip2::
Jump_036_6D1D:: ; address name
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 32 Farewell; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; 1 call site from 1 routine (e.g. ActionEffect_LifeDance)
; reads: wBattleTarget, wDefeatByteD1, wBattleActor, wFollowUpAction
; writes: wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleActor, wResolveMsgFlags, wBattleTargetChoice
ActionEffect_Farewell:: ; code pointer of the table ActionEffectTable; C0
Func_036_6D20:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleActor
    cp a, [hl]
    jr z, ApplyTargetMaxHPAmount_Skip2
    ld a, [wBattleTarget]
    and a, $03
    cp a, $03
    jr z, ApplyTargetMaxHPAmount_Skip2
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .call_action_effect_heal
    jr z, ApplyTargetMaxHPAmount_Skip2
    call ApplyTargetMaxHPAmount
    ld hl, wResolveMsgFlags
    set 6, [hl]
    ret

.call_action_effect_heal:
    call ActionEffect_Heal
    ld hl, wResolveMsgFlags
    res 6, [hl]
    ret

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 33 Antidote; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget
ActionEffect_Antidote:: ; code pointer of the table ActionEffectTable; C0
Func_036_6D4E:: ; address name
    call ClearDamageAndReadTargetStatus0_Bank36
    and a, $03
    jr z, .skip
    ld a, [hl]
    and a, $FC
    ld [hl], a
    ld l, $4E
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 34 DeChaos; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget
; points at: wSlotMarks
ActionEffect_DeChaos:: ; code pointer of the table ActionEffectTable; C0
Func_036_6D64:: ; address name
    call ClearDamageAndReadTargetStatus0_Bank36
    and a, $10
    jr z, .skip
    ld a, [hl]
    and a, $EF
    ld [hl], a
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $03
    ld l, $83
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 35 NumbOff; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
; points at: wSlotMarks
ActionEffect_NumbOff:: ; code pointer of the table ActionEffectTable; C0
Func_036_6D87:: ; address name
    call ClearDamageAndReadTargetStatus0_Bank36
    and a, $CC
    jr z, .skip
    push hl
    bit 6, [hl]
    jr z, .call_clear_damage_and_store_resolve_msg_flags
    ld l, $4F
    jr .call_clear_damage_and_store_resolve_msg_flags2

.call_clear_damage_and_store_resolve_msg_flags:
    ld l, $82

.call_clear_damage_and_store_resolve_msg_flags2:
    ld bc, $4090
    call ClearDamageAndStoreResolveMsgFlags_Bank36
    pop hl
    ld a, [hl]
    and a, $33
    ld [hl], a
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $03
    ret

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 36 CurseOff; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget
ActionEffect_CurseOff:: ; code pointer of the table ActionEffectTable; C0
Func_036_6DB5:: ; address name
    call ClearDamageAndReadTargetStatus0_Bank36
    and a, $20
    jr z, .skip
    ld a, [hl]
    and a, $DF
    ld [hl], a
    ld l, $51
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 37 Upper, 38 Increase; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleDamageLo, wBattleDamageHi
; writes: wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget
ActionEffect_Upper:: ; code pointer of the table ActionEffectTable; C0
Func_036_6DCB:: ; address name
    call RaiseTargetDEF
    jr nc, .skip
    ld a, [wBattleTarget]
    call SetSlotStatus6Bit6
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    ld a, l
    or a, h
    jr z, .skip
    ld l, $45
    ld bc, $0090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

.skip:
    ld h, $CC
    ld bc, $0084
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 39 Sap, 40 Defense; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget
ActionEffect_Sap:: ; code pointer of the table ActionEffectTable; C0
Func_036_6DF2:: ; address name
    call RollTargetSlotResistancesByte3Bits45Chance
    jp nc, ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2

; only called from ActionEffect_UltraDown (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_UltraDown)
; reads: wBattleTarget
; writes: wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget
ActionEffect_UltraDown_SetSlotStatus6Bit7::
Func_036_6DF8:: ; address name
    call ActionEffect_UltraDown_Sub02_GetBattleDEF
    jr nc, .skip
    ld a, [wBattleTarget]
    call SetSlotStatus6Bit7
    ld l, $39
    ld bc, $0098
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

.skip:
    ld h, $CC
    ld bc, $0084
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 41 Speed, 42 SpeedUp; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleDamageLo, wBattleDamageHi
; writes: wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget
ActionEffect_Speed:: ; code pointer of the table ActionEffectTable; C0
Func_036_6E13:: ; address name
    call RaiseTargetAGL
    jr nc, .skip
    ld a, [wBattleTarget]
    call SetSlotStatus6Bit6
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    ld a, l
    or a, h
    jr z, .skip
    ld l, $49
    ld bc, $0090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

.skip:
    ld h, $CC
    ld bc, $0084
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 43 Slow, 44 SlowAll; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget
ActionEffect_Slow:: ; code pointer of the table ActionEffectTable; C0
Func_036_6E3A:: ; address name
    call RollTargetSlotResistancesByte3Bits23Chance
    jp nc, ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2

; only called from ResolveStepDamageMessage_Sub04 (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepDamageMessage_ActorOnLocalSide_Bank36)
; reads: wBattleTarget
; writes: wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget
ResolveStepDamageMessage_Sub04_Sub01_GetBaseAGLOfSlotA_Sub01::
Func_036_6E40:: ; address name
    call ResolveStepDamageMessage_Sub04_Sub01_GetBaseAGLOfSlotA
    jr nc, .skip
    ld a, [wBattleTarget]
    call SetSlotStatus6Bit7
    ld l, $48
    ld bc, $0098
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

.skip:
    ld h, $CC
    ld bc, $0084
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 45 TwinHits; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wDefeatByteD1, wBattleActor, wFollowUpAction
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wBattleTarget, wDefeatByteD1, wBattleSubPhase, ...
; points at: wBattleStatus1, wBattleTargetChoice
ActionEffect_TwinHits:: ; code pointer of the table ActionEffectTable; C0
Func_036_6E5B:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 2, [hl]
    jr nz, .skip
    set 2, [hl]
    ld l, $43
    ld bc, $0090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; only called from ResolveStepDamageMessage_Sub04 (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepDamageMessage_ActorOnLocalSide_Bank36)
; reads: wBattleTarget, wResolveMsgFlags, wDefeatByteD1, wBattleActor, wFollowUpAction
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget, wBattleTarget, wDefeatByteD1, ...
; points at: wBattleStatus1, wBattleTargetChoice
ResolveStepDamageMessage_Sub04_RollTargetSlotResistancesByte1Bits01Chance:: ; code pointer of the table ActionEffectTable; C0
Func_036_6E75:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 1, [hl]
    jr nz, .check_resolve_msg_flags
    call RollTargetSlotResistancesByte1Bits01Chance
    jr nc, .skip
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    set 1, [hl]
    ld l, $4A
    ld bc, $0090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.check_resolve_msg_flags:
    ld a, [wResolveMsgFlags]
    and a, $EF
    ld [wResolveMsgFlags], a
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 47 Sleep, 48 SleepAll, 113 SleepAir; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActionId
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget
; points at: wBattleStatus
ActionEffect_Sleep:: ; code pointer of the table ActionEffectTable; C0
Func_036_6EA8:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $8C
    jr nz, .skip2
    push hl
    call RollTargetSlotResistancesByte2Bits67Chance
    pop hl
    jr nc, .check_battle_action_id
    ld a, [hl]
    or a, $8C
    ld [hl], a
    ld l, $73
    ld bc, $4098
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.check_battle_action_id:
    ld a, [wBattleActionId]
    cp a, $71
    ld h, $B5
    jr z, .skip
    ld h, $CE

.skip:
    ld bc, $0080
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

.skip2:
    ld h, $D4
    ld bc, $0080
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 49 TakeMagic; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wDefeatByteD1, wFollowUpAction
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wBattleTarget, wDefeatByteD1, wBattleSubPhase, ...
; points at: wBattleStatus2, wBattleTargetChoice
ActionEffect_TakeMagic:: ; code pointer of the table ActionEffectTable; C0
Func_036_6EE2:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit 0, [hl]
    jr nz, .skip
    set 0, [hl]
    ld l, $3F
    ld bc, $0090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 50 RobMagic, 119 RobDance; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActionId, wBattleActor, hTemp0, wSavedActorSlot, wSavedActorByte, wDefeatByteD1, wFollowUpAction
; writes: wSavedActorSlot, wSavedActorByte, wBattleActor, wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, ...
; points at: wBattleMP, wBattleMaxMP, wBattleTargetChoice
ActionEffect_RobMagic:: ; code pointer of the table ActionEffectTable; C0
Func_036_6EFC:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    or a, [hl]
    jp z, .skip3
    ld a, [wBattleActionId]
    cp a, $DF
    jr z, .call_roll_target_slot_resistances_byte2
    ld a, [wBattleActor]
    call GetBattleMP
    ld a, [wBattleActor]
    ld de, wBattleMaxMP
    add a, a
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    call CompareHLToBC
    jr nc, .skip3

.call_roll_target_slot_resistances_byte2:
    call RollTargetSlotResistancesByte2Bits23Chance
    jr nc, .skip3
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld b, a
    sra b
    rr c
    ld a, c
    ld [wSavedActorSlot], a
    ld a, b
    ld [wSavedActorByte], a
    call ActionEffect_RobMagic_DrainTargetMPAmount
    ld a, [wBattleActionId]
    cp a, $DF
    jr nz, .skip2
    farcall ActorFormationSlotToTemp0
    ld a, [wBattleActor]
    push af
    ldh a, [hTemp0]
    ld [wBattleActor], a
    call ActionEffect_RobMagic_DrainTargetMPAmount
    pop af
    ld [wBattleActor], a
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld a, [wSavedActorSlot]
    ld c, a
    ld a, [wSavedActorByte]
    ld b, a
    sla c
    rl b
    ld a, c
    ld [wBattleDamageLo], a
    ld a, b
    ld [wBattleDamageHi], a

.skip2:
    ld l, $3D
    ld bc, $4098
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

.skip3:
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 51 StopSpell; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wDefeatByteD1, wBattleActor, wFollowUpAction
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget, wBattleTarget, wDefeatByteD1, ...
; points at: wBattleStatus1, wBattleTargetChoice
ActionEffect_StopSpell:: ; code pointer of the table ActionEffectTable; C0
Func_036_6F96:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 0, [hl]
    jr nz, .skip
    call ActionEffect_StopSpell_HLToBattleStatus8EntryOfBattleTarget_Bank36
    jr nc, .skip2
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    set 0, [hl]
    ld l, $3B
    ld bc, $4098
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

.skip2:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 52 PanicAll, 120 PaniDance, 173 PanicAll; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget
; points at: wBattleStatus
ActionEffect_PanicAll:: ; code pointer of the table ActionEffectTable; C0
Func_036_6FC1:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 4, [hl]
    jr nz, .skip
    call ActionEffect_PanicAll_HLToBattleStatus8EntryOfBattleTarget_Bank36
    jr nc, .skip2
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    set 4, [hl]
    ld l, $42
    ld bc, $4098
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    ld h, $CF
    ld bc, $0084
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

.skip2:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 53 Ironize, 174 Ironize; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wBattleTarget
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleStatus5
ActionEffect_Ironize:: ; code pointer of the table ActionEffectTable; C0
Func_036_6FF1:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr z, .check_battle_target
    ld a, [wBattleTarget]
    cp a, $04
    jr c, .check_battle_target
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld b, $01
    ld a, [wBattleTarget]
    ld c, a
    jr .loop

.check_battle_target:
    ld b, $04
    ld a, [wBattleTarget]
    and a, $04
    ld c, a
    ld hl, wBattleStatus5
    call AddAx9ToHL

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    ld a, [hl]
    or a, $C0
    ld [hl], a

.skip:
    ld a, $09
    add_a_to_hl
    inc c
    dec b
    jr nz, .loop
    farcall ActionEffect_Ironize_ReadLinkModeAndBattleTarget
    ld l, d
    ld bc, $0090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 54 MagicBack, 55 Bounce; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleActionId
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget
; points at: wBattleStatus2
ActionEffect_MagicBack:: ; code pointer of the table ActionEffectTable; C0
Func_036_703D:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    ld a, [wBattleActionId]
    cp a, $37
    jr z, .skip
    bit 5, [hl]
    jr nz, .skip2
    ld a, [hl]
    and a, $DD
    or a, $20
    ld [hl], a
    ld l, $4B
    ld bc, $0090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    bit 1, [hl]
    jr nz, .skip2
    ld a, [hl]
    and a, $DD
    or a, $02
    ld [hl], a
    ld l, $4C
    ld bc, $0090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip2:
    ld h, $CC
    ld bc, $0084
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 56 Barrier; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wDefeatByteD1, wBattleActor, wFollowUpAction
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wBattleTarget, wDefeatByteD1, wBattleSubPhase, ...
; points at: wBattleStatus2, wBattleTargetChoice
ActionEffect_Barrier:: ; code pointer of the table ActionEffectTable; C0
Func_036_7079:: ; address name
    ld a, [wBattleTarget]
    and a, $04
    ld c, a
    ld b, $04
    ld d, $00

.loop:
    ld a, c
    ld hl, wBattleStatus2
    call AddAx9ToHL
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    bit 2, [hl]
    jr nz, .next
    inc d
    set 2, [hl]
    jr .next

.skip:
    res 2, [hl]

.next:
    inc c
    dec b
    jr nz, .loop
    ld a, d
    or a, a
    jr z, .skip2
    ld l, $4D
    ld bc, $0090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip2:
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 57 MagicWall; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wDefeatByteD1, wFollowUpAction
; writes: wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleStatus8, wBattleTargetChoice
ActionEffect_MagicWall:: ; code pointer of the table ActionEffectTable; C0
Func_036_70AE:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus8
    call AddAx9ToHL
    set 6, [hl]

.next:
    inc c
    dec b
    jr nz, .loop
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 58 Transform; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wSideControl, wBattleStatus1
ActionEffect_Transform:: ; code pointer of the table ActionEffectTable; C0
Func_036_70CC:: ; address name
    ld l, $52
    ld bc, $4090
    call ClearDamageAndStoreResolveMsgFlags_Bank36
    call ActionEffect_Transform_Sub01_SlotSpeciesNibblesD00AD00B_Sub01
    ld a, [wBattleActor]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    and a, $F8
    ld [hl], a
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    set 5, [hl]
    res 4, [hl]
    ret

; only called from ResolveStepDamageMessage (E-0047)
; 1 call site from 1 routine (e.g. ResolveStepDamageMessage)
; reads: wLinkMode, wBattleActor, wBattleTarget
; points at: wSlotNameBytes
ResolveStepDamageMessage_WaitLinkMode::
Func_036_70F4:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    ret z
    ld a, [wBattleActor]
    cp a, $04
    ret c
    and a, $03
    ld hl, wSlotNameBytes
    add_a_to_hl
    ld a, [wBattleTarget]
    ld [hl], a
    ret

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 59 BeDragon, $B8; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; 1 call site from 1 routine (e.g. ActionEffect_ActionDC)
; reads: wBattleActor, wBattleActionId
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg
; points at: wSideControl, wBattleStatus1
ActionEffect_BeDragon:: ; code pointer of the table ActionEffectTable; C0
Func_036_710F:: ; address name
    call ActionEffect_BeDragon_LoadMonsterRecord
    ld a, [wBattleActor]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    and a, $F8
    ld [hl], a
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    set 4, [hl]
    res 5, [hl]
    ld a, [wBattleActor]
    ld c, a
    farcall ActionEffect_BeDragon_ReadLinkMode
    ld a, [wBattleActionId]
    cp a, $DC
    jr z, .skip
    ld l, $44
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    ld l, $F7
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 60 Chance; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wBattleActionId, wRecordBuffer, wBattleTarget, wBattleSubPhase, wBattleResolveStep
; points at: wBattleActionChoice, wBattleTargetChoice
ActionEffect_Chance:: ; code pointer of the table ActionEffectTable; C0
Func_036_714F:: ; address name
    farcall ActionEffect_Chance_AdvanceRandom
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, c
    ld [hl], a
    ld [wBattleActionId], a
    ld [wRecordBuffer], a
    ld a, $00
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld [hl], $FF
    farcall ChooseTargetForActor
    ld a, d
    ld [wBattleTarget], a
    xor a, a
    ld [wBattleSubPhase], a
    ld a, $03
    ld [wBattleResolveStep], a
    ret

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 61 MegaMagic; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; reads: wAllMPSpentLo, wAllMPSpentHi
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_MegaMagic:: ; code pointer of the table ActionEffectTable; C0
Func_036_7196:: ; address name
    ld a, [wAllMPSpentLo]
    ld l, a
    ld a, [wAllMPSpentHi]
    ld h, a
    ld a, l
    or a, h
    jp z, ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2
    call ActionEffect_MegaMagic_WriteBattleDamageLoAndBattleDamageHi
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 62 BigBang; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_BigBang:: ; code pointer of the table ActionEffectTable; C0
Func_036_71A9:: ; address name
    call ActionEffect_BigBang_RollSkillDamageFromRecord
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 64 FireAir, 65 BlazeAir, 66 Scorching, 67 WhiteFire; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_FireAir:: ; code pointer of the table ActionEffectTable; C0
Func_036_71AF:: ; address name
    call ActionEffect_FireAir_RollSkillDamageFromRecord
    call HalveDamageIfTargetStatus2Bit2
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 68 FrigidAir, 69 IceAir, 70 IceStorm, 71 WhiteAir; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_FrigidAir:: ; code pointer of the table ActionEffectTable; C0
Func_036_71B8:: ; address name
    call ActionEffect_FrigidAir_RollSkillDamageFromRecord
    call HalveDamageIfTargetStatus2Bit2
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 72 WindBeast; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_WindBeast:: ; code pointer of the table ActionEffectTable; C0
Func_036_71C1:: ; address name
    call ActionEffect_WindBeast_ShiftBCRight1
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 73 Vacuum; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_Vacuum:: ; code pointer of the table ActionEffectTable; C0
Func_036_71C7:: ; address name
    call ActionEffect_Vacuum_ShiftBCRight1
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 74 Lightning; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_Lightning:: ; code pointer of the table ActionEffectTable; C0
Func_036_71CD:: ; address name
    call ActionEffect_Lightning_ShiftBCRight1
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 75 RockThrow; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_RockThrow:: ; code pointer of the table ActionEffectTable; C0
Func_036_71D3:: ; address name
    call ActionEffect_RockThrow_RollSkillDamageFromRecord
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 76 Watershot, 77 Tidalwave; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_Watershot:: ; code pointer of the table ActionEffectTable; C0
Func_036_71D9:: ; address name
    call ActionEffect_Watershot_RollSkillDamageFromRecord
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 78 CallHelp, 79 YellHelp; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wRandomLo
; writes: wBattleSubPhase, wBattleResolveStep, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg, wResolveMsgActor
; points at: wBattleStatus6
ActionEffect_CallHelp:: ; code pointer of the table ActionEffectTable; C0
Func_036_71DF:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    bit 0, [hl]
    jr nz, .call_action_effect_call_help_write_battle
    push hl
    call AdvanceRandom
    pop hl
    ld a, [wRandomLo]
    cp a, $80
    jr c, .skip
    set 0, [hl]
    ld d, $53 ; battle text 'Help arrived from seemingly nowhere!'
    farcall ShowBattleText
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

.skip:
    ld h, $69
    ld bc, $0080
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

.call_action_effect_call_help_write_battle:
    call ActionEffect_CallHelp_WriteBattleDamageLoAndBattleDamageHi
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 80 FireSlash; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_FireSlash:: ; code pointer of the table ActionEffectTable; C0
Func_036_721A:: ; address name
    call AttackDamageScaledBySlotResistancesByte0Bits54
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 81 VacuSlash; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_VacuSlash:: ; code pointer of the table ActionEffectTable; C0
Func_036_7220:: ; address name
    call AttackDamageScaledBySlotResistancesByte1Bits76
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 82 BoltSlash; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_BoltSlash:: ; code pointer of the table ActionEffectTable; C0
Func_036_7226:: ; address name
    call AttackDamageScaledBySlotResistancesByte1Bits54
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 83 IceSlash; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_IceSlash:: ; code pointer of the table ActionEffectTable; C0
Func_036_722C:: ; address name
    call AttackDamageScaledBySlotResistancesByte1Bits32
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 84 SlimeBlow; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_SlimeBlow:: ; code pointer of the table ActionEffectTable; C0
Func_036_7232:: ; address name
    call AttackDamageHalvedDEFVsSlime
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 85 DrakSlash; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_DrakSlash:: ; code pointer of the table ActionEffectTable; C0
Func_036_7238:: ; address name
    call AttackDamageHalvedDEFVsDragon
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 86 BeastCut; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_BeastCut:: ; code pointer of the table ActionEffectTable; C0
Func_036_723E:: ; address name
    call AttackDamageHalvedDEFVsBeast
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 87 BirdBlow; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_BirdBlow:: ; code pointer of the table ActionEffectTable; C0
Func_036_7244:: ; address name
    call AttackDamageHalvedDEFVsBird
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 88 BugBlow; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_BugBlow:: ; code pointer of the table ActionEffectTable; C0
Func_036_724A:: ; address name
    call AttackDamageHalvedDEFVsBug
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 89 Shears; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_Shears:: ; code pointer of the table ActionEffectTable; C0
Func_036_7250:: ; address name
    call AttackDamageHalvedDEFVsPlant
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 90 DevilCut; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_DevilCut:: ; code pointer of the table ActionEffectTable; C0
Func_036_7256:: ; address name
    call AttackDamageHalvedDEFVsDemon
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 91 ZombieCut; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_ZombieCut:: ; code pointer of the table ActionEffectTable; C0
Func_036_725C:: ; address name
    call AttackDamageHalvedDEFVsZombie
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 92 CleanCut; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_CleanCut:: ; code pointer of the table ActionEffectTable; C0
Func_036_7262:: ; address name
    call AttackDamageHalvedDEFVsMaterial
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 93 AquaCut; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_AquaCut:: ; code pointer of the table ActionEffectTable; C0
Func_036_7268:: ; address name
    call AttackDamageHalvedDEFVsWater
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 94 MetalCut; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_MetalCut:: ; code pointer of the table ActionEffectTable; C0
Func_036_726E:: ; address name
    call AttackDamageTimes1_5IfSlotDamageFlagsBit0
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 95 PoisonHit, 96 Paralyze, 97 NapAttack; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
ActionEffect_PoisonHit:: ; code pointer of the table ActionEffectTable; C0
Func_036_7274:: ; address name
    call ActionEffect_Action00
    ret

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 98 SquallHit; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleDamageLo, wBattleDamageHi
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_SquallHit:: ; code pointer of the table ActionEffectTable; C0
Func_036_7278:: ; address name
    call ComputeAttackDamage
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    call ScaleHLTo80Percent_Bank36
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 99 BiAttack, 100 QuadHits; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_BiAttack:: ; code pointer of the table ActionEffectTable; C0
Func_036_7291:: ; address name
    call ActionEffect_BiAttack_ShiftHLRight1
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 101 RainSlash; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleDamageLo, wBattleDamageHi, wBattleTarget
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_RainSlash:: ; code pointer of the table ActionEffectTable; C0
Func_036_7297:: ; address name
    call ComputeAttackDamage
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    ld a, [wBattleTarget]
    and a, $03
    jr nz, .skip
    call ScaleHLTo80Percent_Bank36
    jr .set_battle_damage_lo

.skip:
    dec a
    jr nz, .call_scale_hl_to40_percent
    call ScaleHLTo60Percent
    jr .set_battle_damage_lo

.call_scale_hl_to40_percent:
    call ScaleHLTo40Percent

.set_battle_damage_lo:
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 102 MultiCut; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_MultiCut:: ; code pointer of the table ActionEffectTable; C0
Func_036_72C4:: ; address name
    call ActionEffect_MultiCut_LoadSkillRecord
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 103 GigaSlash; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_GigaSlash:: ; code pointer of the table ActionEffectTable; C0
Func_036_72CA:: ; address name
    call SkillDamageScaledBySlotResistancesByte6Bits32
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 104 ChargeUp; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wDefeatByteD1, wFollowUpAction
; writes: wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleStatus4, wBattleTargetChoice
ActionEffect_ChargeUp:: ; code pointer of the table ActionEffectTable; C0
Func_036_72D0:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    ld a, [hl]
    or a, $03
    ld [hl], a
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 105 PsycheUp; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; 1 call site from 1 routine (e.g. ActionEffect_TwinSlash)
; reads: wBattleDamageLo, wBattleDamageHi
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_PsycheUp:: ; code pointer of the table ActionEffectTable; C0
Func_036_72E0:: ; address name
    call ComputeAttackDamage
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    call ScaleHLBy3Over2
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 106 HighJump; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wDefeatByteD1, wFollowUpAction, wBattleDamageLo, wBattleDamageHi
; writes: wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep, wResolveMsgFlags, wResolveMsgArg, wBattleDamageLo, wBattleDamageHi, ...
; points at: wBattleStatus4, wBattleTargetChoice
ActionEffect_HighJump:: ; code pointer of the table ActionEffectTable; C0
Func_036_72F9:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    jr nz, ActionEffect_HighJump_Skip
    ld a, [hl]
    or a, $0C
    ld [hl], a
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

ActionEffect_HighJump_Skip::
Jump_036_730E:: ; address name
    ld a, [hl]
    and a, $F3
    ld [hl], a
    jr ActionEffect_PsycheUp

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 107 EvilSlash; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wRandomLo, wBattleActor
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleStatus2
ActionEffect_EvilSlash:: ; code pointer of the table ActionEffectTable; C0
Func_036_7314:: ; address name
    ld a, [wBattleTarget]
    call CheckSlotStatusBlock
    jr c, .read_battle_actor
    call AdvanceRandom
    ld a, [wRandomLo]
    cp a, $A0
    jr c, .skip

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    res 7, [hl]
    ld a, [wBattleActor]
    call GetBattleATK
    call RandomWithin5PercentOfHL
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wBattleDamageHi], a
    ld hl, $D235
    ld bc, $80A8
    jp UnreferencedStoreResolveMessage35D0_Bank36_SetResolveMsgActor

.skip:
    ld h, $D2
    ld bc, $0080
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 108 Massacre; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleStatus2
ActionEffect_Massacre:: ; code pointer of the table ActionEffectTable; C0
Func_036_7353:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    res 7, [hl]
    ld a, [wBattleActor]
    call GetBattleATK
    call RandomWithin5PercentOfHL
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wBattleDamageHi], a
    ld hl, $B535
    ld bc, $80A8
    jp UnreferencedStoreResolveMessage35D0_Bank36_SetResolveMsgActor

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 109 TwinSlash; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wBattleStatus2
ActionEffect_TwinSlash:: ; code pointer of the table ActionEffectTable; C0
Func_036_7378:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    res 7, [hl]
    call ActionEffect_PsycheUp
    ret

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 110 Berserker; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleDamageLo, wBattleDamageHi
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleStatus6, wBattleStatus2
ActionEffect_Berserker:: ; code pointer of the table ActionEffectTable; C0
Func_036_7387:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    set 2, [hl]
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    res 7, [hl]
    call ComputeAttackDamage
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    sla l
    rl h
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 111 Ramming; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_Ramming:: ; code pointer of the table ActionEffectTable; C0
Func_036_73B7:: ; address name
    call DamageEightyPercentOfTargetHPScaled
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 112 Kamikaze; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_Kamikaze:: ; code pointer of the table ActionEffectTable; C0
Func_036_73BD:: ; address name
    call ActionEffect_Kamikaze_HLToBattleStatus8EntryOfBattleTarget_Bank36
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 114 PalsyAir; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wDefeatByteD1, wBattleActor, wFollowUpAction
; writes: wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg, wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wBattleTarget, wDefeatByteD1, ...
; points at: wBattleStatus, wBattleTargetChoice
ActionEffect_PalsyAir:: ; code pointer of the table ActionEffectTable; C0
Func_036_73C3:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 6, [hl]
    jr nz, .skip2
    push hl
    call RollTargetSlotResistancesByte5Bits67ChanceToE
    pop hl
    jr c, .skip
    ld h, $B5
    ld bc, $0888
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

.skip:
    set 6, [hl]
    ld l, $76
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip2:
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 115 PoisonGas, 116 PoisonAir; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActionId, wDefeatByteD1, wBattleActor, wFollowUpAction
; writes: wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg, wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wBattleTarget, wDefeatByteD1, ...
; points at: wBattleStatus, wBattleTargetChoice
ActionEffect_PoisonGas:: ; code pointer of the table ActionEffectTable; C0
Func_036_73EC:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [wBattleActionId]
    cp a, $74
    jr z, .skip
    ld a, [hl]
    and a, $03
    jr nz, .skip4
    jr .call_roll_target_slot_resistances_byte4

.skip:
    bit 1, [hl]
    jr nz, .skip4

.call_roll_target_slot_resistances_byte4:
    push hl
    call RollTargetSlotResistancesByte4Bits01ChanceToE
    pop hl
    jr c, .check_battle_action_id
    ld h, $B5
    ld bc, $0888
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

.check_battle_action_id:
    ld a, [wBattleActionId]
    cp a, $74
    jr z, .skip2
    set 0, [hl]
    res 1, [hl]
    ld l, $75
    jr .skip3

.skip2:
    set 1, [hl]
    res 0, [hl]
    ld l, $77

.skip3:
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip4:
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 117 Curse; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wDefeatByteD1, wBattleActor, wFollowUpAction
; writes: wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg, wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wBattleTarget, wDefeatByteD1, ...
; points at: wBattleStatus, wBattleTargetChoice
ActionEffect_Curse:: ; code pointer of the table ActionEffectTable; C0
Func_036_7434:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 5, [hl]
    jr nz, .skip2
    push hl
    call ActionEffect_Curse_HLToBattleStatus8EntryOfBattleTarget_Bank36
    pop hl
    jr c, .skip
    ld h, $B5
    ld bc, $0888
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

.skip:
    set 5, [hl]
    ld l, $D9
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip2:
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 118 OddDance; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wDefeatByteD1, wBattleActor, wFollowUpAction
; writes: wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget, wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep
; points at: wBattleMP, wBattleTargetChoice
ActionEffect_OddDance:: ; code pointer of the table ActionEffectTable; C0
Func_036_745D:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    or a, [hl]
    jr z, .skip
    call RollTargetSlotResistancesByte2Bits23Chance
    jp nc, ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2
    call DrainTargetMPAmount
    ld l, $57
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

.skip:
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 122 LureDance; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wDefeatByteD1, wBattleActor, wFollowUpAction
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget, wBattleTarget, wDefeatByteD1, ...
; points at: wBattleTargetChoice
ActionEffect_LureDance:: ; code pointer of the table ActionEffectTable; C0
Func_036_747E:: ; address name
    call TargetStatus3Address
    bit 1, [hl]
    jr nz, .skip2
    call RollChanceVsTargetSlotResistancesByte5Bits23
    jr nc, .skip
    call TargetStatus3Address
    set 1, [hl]
    call ClearTargetStatus5Bits23And7Bits012
    ld l, $58
    ld bc, $0090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2

.skip2:
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 123 LifeDance; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wDefeatFlagsBA, wRandomLo
; writes: wBattleSubPhase, wBattleResolveStep, wBattleSubStep
; points at: wBattleScreenFlags
ActionEffect_LifeDance:: ; code pointer of the table ActionEffectTable; C0
Func_036_74A0:: ; address name
    ld a, [wDefeatFlagsBA]
    or a, a
    jr nz, .call_action_effect_farewell
    call AdvanceRandom
    ld a, [wRandomLo]
    and a, $01
    jr nz, .call_action_effect_farewell
    ld d, $CC ; battle text 'But nothing happened!'
    farcall ShowBattleText
    ld a, $01
    ld [wBattleSubPhase], a
    ld a, $0E
    ld [wBattleResolveStep], a
    ld a, $00
    ld [wBattleSubStep], a
    ld hl, wBattleScreenFlags
    set 0, [hl]
    ret

.call_action_effect_farewell:
    call ActionEffect_Farewell
    ret

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 125 SideStep; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wRandomLo, wDefeatByteD1, wFollowUpAction
; writes: wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleStatus5, wBattleTargetChoice
ActionEffect_SideStep:: ; code pointer of the table ActionEffectTable; C0
Func_036_74D1:: ; address name
    call AdvanceRandom
    ld a, [wBattleActor]
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    jr nz, .skip
    ld a, [wRandomLo]
    and a, $04
    add a, $04
    ld b, a
    ld a, [hl]
    and a, $F3
    or a, b
    ld [hl], a

.skip:
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 126 SandStorm; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActionId, wDefeatByteD1, wBattleActor, wFollowUpAction
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget, wBattleTarget, wDefeatByteD1, ...
; points at: wBattleStatus5, wBattleStatus1, wBattleTargetChoice
ActionEffect_SandStorm:: ; code pointer of the table ActionEffectTable; C0
Func_036_74F2:: ; address name
    ld d, $02
    jr ActionEffect_Radiant_ReadBattleTarget

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 127 Radiant; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActionId, wDefeatByteD1, wBattleActor, wFollowUpAction
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget, wBattleTarget, wDefeatByteD1, ...
; points at: wBattleStatus5, wBattleStatus1, wBattleTargetChoice
ActionEffect_Radiant:: ; code pointer of the table ActionEffectTable; C0
Func_036_74F6:: ; address name
    ld d, $01

ActionEffect_Radiant_ReadBattleTarget::
Jump_036_74F8:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hl]
    and a, d
    jr nz, .skip2
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 1, [hl]
    jr nz, .skip2
    push de
    call RollTargetSlotResistancesByte1Bits01Chance
    pop de
    jr nc, .skip
    ld a, [wBattleTarget]
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hl]
    or a, d
    ld [hl], a
    ld a, [wBattleActionId]
    sub a, $2A
    ld l, a
    ld bc, $0090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    ld h, $B5
    ld bc, $0888
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

.skip2:
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 128 EerieLite; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget
; points at: wBattleStatus8
ActionEffect_EerieLite:: ; code pointer of the table ActionEffectTable; C0
Func_036_753C:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus8
    call AddAx9ToHL
    bit 7, [hl]
    jr nz, .skip2
    call ActionEffect_EerieLite_HLToBattleStatus8EntryOfBattleTarget_Bank36
    jr nc, .skip
    ld a, [wBattleTarget]
    ld hl, wBattleStatus8
    call AddAx9ToHL
    set 7, [hl]
    ld l, $D5
    ld bc, $0098
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    ld h, $B5
    ld bc, $0888
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

.skip2:
    ld h, $CC
    ld bc, $0084
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 129 Surge; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg
ActionEffect_Surge:: ; code pointer of the table ActionEffectTable; C0
Func_036_7571:: ; address name
    farcall ActionEffect_Surge_SetTargetSlotMarksTo3
    ld l, $60
    ld bc, $0090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 130 UltraDown; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleSubStep, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_UltraDown:: ; code pointer of the table ActionEffectTable; C0
Func_036_757F:: ; address name
    call RollTargetSlotResistancesByte2Bits45Chance
    jr nc, .skip
    call ActionEffect_UltraDown_ReadBattleTarget
    jr nc, .skip
    call ActionEffect_UltraDown_SetSlotStatus6Bit7
    xor a, a
    ld [wBattleSubStep], a
    ret

.skip:
    ld h, $B5
    ld bc, $0080
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 131 DeMagic, 132 ThickFog, $B3; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleSubStep, wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg
ActionEffect_DeMagic:: ; code pointer of the table ActionEffectTable; C0
Func_036_7599:: ; address name
    farcall ActionEffect_DeMagic_SetTargetSlotMarksTo3
    xor a, a
    ld [wBattleSubStep], a
    ld l, $5E
    ld bc, $0090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 133 TatsuCall, 134 DiagoCall, 135 SamsiCall, 136 BazooCall; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wRandomLo, wBattleActionId, wLoadSlot
; writes: wLoadSlot, wBattleTarget, wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget
; points at: wSideFlags0, wSlotFlags854, wSpecialSlotMonsters
ActionEffect_TatsuCall:: ; code pointer of the table ActionEffectTable; C0
Func_036_75AB:: ; address name
    ld a, [wBattleActor]
    rrca
    rrca
    and a, $01
    ld hl, wSideFlags0
    add_a_to_hl
    bit 2, [hl]
    jr nz, .skip2
    push hl
    ld a, [wBattleActor]
    ld hl, wSlotFlags854
    add a, a
    add_a_to_hl
    ld a, [hl]
    pop hl
    and a, $04
    jr nz, .check_battle_actor
    call AdvanceRandom
    ld a, $C0
    ld b, a
    ld a, [wRandomLo]
    cp a, b
    jr nc, .skip

.check_battle_actor:
    set 2, [hl]
    ld a, [wBattleActor]
    and a, $04
    or a, $03
    ld [wLoadSlot], a
    ld a, [wBattleActionId]
    sub a, $07
    ld c, a
    ld b, $00
    ld a, [wLoadSlot]
    srl a
    srl a
    and a, $01
    add a, a
    ld hl, wSpecialSlotMonsters
    add_a_to_hl
    ld [hl], c
    inc hl
    ld [hl], b
    call ActionEffect_TatsuCall_AddAx9ToHL
    ld a, [wLoadSlot]
    ld [wBattleTarget], a
    ld l, $61
    ld bc, $0090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    ld h, $72
    ld bc, $0080
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

.skip2:
    ld h, $CC
    ld bc, $0084
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 137 SuckAir; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wDefeatByteD1, wFollowUpAction
; writes: wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleStatus4, wBattleTargetChoice
ActionEffect_SuckAir:: ; code pointer of the table ActionEffectTable; C0
Func_036_7627:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    ld a, [hl]
    or a, $30
    ld [hl], a
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 138 Focus; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wDefeatByteD1, wFollowUpAction
; writes: wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleStatus4, wBattleTargetChoice
ActionEffect_Focus:: ; code pointer of the table ActionEffectTable; C0
Func_036_7637:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    set 7, [hl]
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 139 LushLicks, 140 SickLick; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActionId, wBattleTarget, wDefeatByteD1, wBattleActor, wFollowUpAction
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget, wBattleTarget, wDefeatByteD1, ...
; points at: wBattleDEF, wBattleTargetChoice
ActionEffect_LushLicks:: ; code pointer of the table ActionEffectTable; C0
Func_036_7645:: ; address name
    call TargetStatus3Address
    bit 3, [hl]
    jr nz, .skip3
    ld a, [wBattleActionId]
    cp a, $8C
    jr z, .call_roll_target_slot_resistances_byte3
    call RollChanceVsTargetSlotResistancesByte5Bits23
    jr .skip

.call_roll_target_slot_resistances_byte3:
    call RollTargetSlotResistancesByte3Bits45Chance

.skip:
    jr nc, .skip2
    call TargetStatus3Address
    set 3, [hl]
    call ClearTargetStatus5Bits23And7Bits012
    ld a, [wBattleActionId]
    cp a, $8B
    jr z, .read_battle_action_id
    ld a, [wBattleTarget]
    ld hl, wBattleDEF
    call AddDoubleAToHL_Bank36
    ld a, $01
    ld [hl+], a
    ld [hl], $00
    ld a, [wBattleTarget]
    call SetSlotStatus6Bit7

.read_battle_action_id:
    ld a, [wBattleActionId]
    sub a, $31
    ld l, a
    ld bc, $0090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip2:
    ld h, $71
    ld bc, $0888
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

.skip3:
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 141 LegSweep, 142 BigTrip; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wDefeatByteD1, wBattleActor, wFollowUpAction
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget, wBattleTarget, wDefeatByteD1, ...
; points at: wSlotDamageFlags, wBattleTargetChoice
ActionEffect_LegSweep:: ; code pointer of the table ActionEffectTable; C0
Func_036_7697:: ; address name
    call TargetStatus3Address
    bit 2, [hl]
    jp nz, SetSubPhase2AndResetResolveStep_CheckDefeatByteD1
    call ActionEffect_LegSweep_RollChanceVsTargetSlotResistancesByte5Bits23
    jr nc, .read_battle_target
    call TargetStatus3Address
    set 2, [hl]
    call ClearTargetStatus5Bits23And7Bits012
    ld l, $5D
    ld bc, $0090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.read_battle_target:
    ld a, [wBattleTarget]
    ld hl, wSlotDamageFlags
    add_a_to_hl
    bit 4, [hl]
    ld h, $70
    jr z, .skip
    ld h, $68

.skip:
    ld bc, $0080
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 143 Ahhh; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wDefeatByteD1, wBattleActor, wFollowUpAction
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget, wBattleTarget, wDefeatByteD1, ...
; points at: wBattleTargetChoice
ActionEffect_Ahhh:: ; code pointer of the table ActionEffectTable; C0
Func_036_76CD:: ; address name
    call TargetStatus3Address
    bit 5, [hl]
    jr nz, .skip2
    call RollChanceVsTargetSlotResistancesByte5Bits23
    jr nc, .skip
    call TargetStatus3Address
    set 5, [hl]
    call ClearTargetStatus5Bits23And7Bits012
    ld l, $59
    ld bc, $0090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    ld h, $B5
    ld bc, $0888
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

.skip2:
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 144 WarCry; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wDefeatByteD1, wBattleActor, wFollowUpAction
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget, wBattleTarget, wDefeatByteD1, ...
; points at: wBattleTargetChoice
ActionEffect_WarCry:: ; code pointer of the table ActionEffectTable; C0
Func_036_76F4:: ; address name
    call TargetStatus3Address
    bit 4, [hl]
    jr nz, .skip2
    call RollChanceVsTargetSlotResistancesByte5Bits23
    jr nc, .skip
    call TargetStatus3Address
    set 4, [hl]
    call ClearTargetStatus5Bits23And7Bits012
    ld l, $5C
    ld bc, $0090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    ld h, $6B
    ld bc, $0080
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

.skip2:
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 145 Geyser; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleTarget, wRandomLo
; writes: wBattleSubPhase, wBattleResolveStep, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg, wBattleTarget, wBattleDamageLo, wBattleDamageHi, ...
; points at: wBattleStatus3, wSlotFlags854, wBattleStatus
ActionEffect_Geyser:: ; code pointer of the table ActionEffectTable; C0
Func_036_771B:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl]
    and a, $C0
    cp a, $40
    jr z, ActionEffect_Geyser_Skip
    call ActionEffect_Geyser_HLToBattleStatus8EntryOfBattleTarget_Bank36
    jr nc, .skip
    ld a, [wBattleTarget]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl]
    ld a, $40
    ld [hl], a
    ld a, [wBattleTarget]
    add a, a
    ld hl, wSlotFlags854
    add_a_to_hl
    ld [hl], $00
    ld d, $DD ; battle text '0 was blown sky-high!'
    farcall ShowBattleText
    jp SetSubPhase2AndResetResolveStep

.skip:
    ld h, $6E
    ld bc, $0080
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

ActionEffect_Geyser_Skip::
Jump_036_775E:: ; address name
    ld a, [hl]
    and a, $3F
    ld [hl], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 6, [hl]
    jr nz, .read_battle_actor
    bit 7, [hl]
    jr nz, .read_battle_actor
    call AdvanceRandom
    ld a, [wRandomLo]
    and a, $01
    jr z, .skip

.read_battle_actor:
    ld a, [wBattleActor]
    call GetBattleMaxHP
    push hl
    call ActionEffect_Geyser_ScaleHLTo60Percent
    ld c, l
    ld b, h
    pop hl
    push bc
    call ActionEffect_Geyser_ScaleHLTo80Percent_Bank36
    pop bc
    call RandomInRange
    ld a, d
    or a, e
    jr nz, .set_battle_damage_lo
    ld de, $0001

.set_battle_damage_lo:
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wBattleDamageHi], a
    ld hl, $D0AD
    ld bc, $88A8
    jp UnreferencedStoreResolveMessage35D0_Bank36_SetResolveMsgActor

.skip:
    ld h, $AF
    ld bc, $0080
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 146 DanceShut; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wDefeatByteD1, wBattleActor, wFollowUpAction
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget, wBattleTarget, wDefeatByteD1, ...
; points at: wBattleStatus1, wBattleTargetChoice
ActionEffect_DanceShut:: ; code pointer of the table ActionEffectTable; C0
Func_036_77B5:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 6, [hl]
    jp nz, SetSubPhase2AndResetResolveStep_CheckDefeatByteD1
    call ActionEffect_DanceShut_HLToBattleStatus8EntryOfBattleTarget_Bank36
    jr nc, .skip
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    set 6, [hl]
    ld l, $DE
    ld bc, $4098
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 147 MouthShut; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wDefeatByteD1, wBattleActor, wFollowUpAction
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget, wBattleTarget, wDefeatByteD1, ...
; points at: wBattleStatus1, wBattleTargetChoice
ActionEffect_MouthShut:: ; code pointer of the table ActionEffectTable; C0
Func_036_77DE:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 7, [hl]
    jr nz, .skip2
    call ActionEffect_MouthShut_HLToBattleStatus8EntryOfBattleTarget_Bank36
    jr nc, .skip
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    set 7, [hl]
    ld l, $64
    ld bc, $4098
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2

.skip2:
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 148 StrongD, 150 BladeD; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; 1 call site from 1 routine (e.g. ActionEffect_ActionE0)
; reads: wBattleActor, wBattleActionId, wDefeatByteD1, wFollowUpAction
; writes: wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleStatus7, wBattleTargetChoice
ActionEffect_StrongD:: ; code pointer of the table ActionEffectTable; C0
Func_036_7809:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus7
    call AddAx9ToHL
    ld a, [wBattleActionId]
    cp a, $96
    jr z, .skip2
    cp a, $E0
    jr nz, .skip
    ld a, [hl]
    and a, $F0
    or a, $0C
    ld [hl], a
    jr .skip3

.skip:
    ld a, [hl]
    and a, $F0
    or a, $02
    ld [hl], a
    jr .skip3

.skip2:
    ld a, [hl]
    and a, $F0
    or a, $04
    ld [hl], a

.skip3:
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 149 Dodge; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wDefeatByteD1, wFollowUpAction
; writes: wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleStatus6, wBattleTargetChoice
ActionEffect_Dodge:: ; code pointer of the table ActionEffectTable; C0
Func_036_7836:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    set 5, [hl]
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 151 Cover, 152 Guardian; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActionId, wBattleActor, wDefeatByteD1, wFollowUpAction
; writes: wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep, wResolveMsgFlags, wResolveMsgArg
; points at: wSideFlags0, wBattleActor, wBattleStatus6, wBattleTargetChoice
ActionEffect_Cover:: ; code pointer of the table ActionEffectTable; C0
Func_036_7844:: ; address name
    ld a, [wBattleTarget]
    rrca
    rrca
    and a, $01
    ld hl, wSideFlags0
    add_a_to_hl
    bit 4, [hl]
    jp nz, SetSubPhase2AndResetResolveStep_CheckDefeatByteD1
    ld a, [wBattleActionId]
    cp a, $98
    jr z, .check_battle_target
    ld a, [wBattleTarget]
    ld c, a
    ld b, $01
    jr .loop

.check_battle_target:
    set 4, [hl]
    ld a, [wBattleTarget]
    and a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleActor
    cp a, [hl]
    jr z, .next
    ld hl, wBattleStatus6
    call AddAx9ToHL
    bit 4, [hl]
    jr nz, .next
    set 4, [hl]
    inc hl
    ld a, [wBattleActor]
    and a, $0F
    swap a
    or a, [hl]
    ld [hl], a

.next:
    inc c
    dec b
    jr nz, .loop
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 153 TailWind, 154 StormWind; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActionId, wBattleTarget, wDefeatByteD1, wBattleActor, wFollowUpAction
; writes: wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleStatus2, wBattleTargetChoice, wSideFlags0
ActionEffect_TailWind:: ; code pointer of the table ActionEffectTable; C0
Func_036_789B:: ; address name
    ld a, [wBattleActionId]
    cp a, $9A
    jr z, .check_battle_target
    ld a, [wBattleTarget]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    set 6, [hl]
    jr .skip

.check_battle_target:
    ld a, [wBattleTarget]
    and a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus2
    call AddAx9ToHL
    set 6, [hl]

.next:
    inc c
    dec b
    jr nz, .loop
    ld a, [wBattleTarget]
    rra
    rra
    and a, $01
    ld hl, wSideFlags0
    add_a_to_hl
    set 5, [hl]

.skip:
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 155 AquaWall; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wDefeatByteD1, wFollowUpAction
; writes: wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleStatus2, wBattleTargetChoice
ActionEffect_AquaWall:: ; code pointer of the table ActionEffectTable; C0
Func_036_78DE:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    set 3, [hl]
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 156 SealPray; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wDefeatByteD1, wFollowUpAction
; writes: wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleStatus8, wBattleTargetChoice
ActionEffect_SealPray:: ; code pointer of the table ActionEffectTable; C0
Func_036_78EC:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus8
    call AddAx9ToHL
    set 4, [hl]
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 157 SuckAll; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wDefeatByteD1, wFollowUpAction
; writes: wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep, wResolveMsgFlags, wResolveMsgArg
; points at: wSideFlags0, wSlotPairBytes, wBattleStatus6, wBattleTargetChoice
ActionEffect_SuckAll:: ; code pointer of the table ActionEffectTable; C0
Func_036_78FA:: ; address name
    ld a, [wBattleActor]
    rrca
    rrca
    and a, $01
    ld b, a
    ld hl, wSideFlags0
    add_a_to_hl
    bit 6, [hl]
    jp nz, SetSubPhase2AndResetResolveStep_CheckDefeatByteD1
    set 6, [hl]
    ld a, b
    ld hl, wSlotPairBytes
    add_a_to_hl
    ld a, [wBattleActor]
    and a, $03
    rla
    rla
    or a, [hl]
    ld [hl], a
    ld a, [wBattleActor]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    set 1, [hl]
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 158 Imitate; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wDefeatByteD1, wFollowUpAction
; writes: wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleStatus6, wBattleTargetChoice
ActionEffect_Imitate:: ; code pointer of the table ActionEffectTable; C0
Func_036_7931:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    set 3, [hl]
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 159 Meditate; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget
ActionEffect_Meditate:: ; code pointer of the table ActionEffectTable; C0
Func_036_793F:: ; address name
    call ActionEffect_Meditate_AddDoubleAToHL_Bank36
    jr nc, .skip
    ld l, $37
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 160 LifeSong; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wDefeatFlagsBA, wRandomLo, wBattleTarget, wDefeatByteD1, wFollowUpAction
; writes: wBattleSubPhase, wBattleResolveStep, wBattleTarget, wDefeatByteD1, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleStatus5, wBattleTargetChoice
ActionEffect_LifeSong:: ; code pointer of the table ActionEffectTable; C0
Func_036_794F:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hl]
    and a, $10
    jr nz, ActionEffect_LifeSong_CheckDefeatFlagsBA
    ld a, [hl]
    and a, $CF
    or a, $20
    ld [hl], a
    jp SetSubPhase7AndResetResolveStep

ActionEffect_LifeSong_CheckDefeatFlagsBA::
Jump_036_7966:: ; address name
    ld a, [wDefeatFlagsBA]
    or a, a
    jr nz, .read_battle_target
    call AdvanceRandom
    ld a, [wRandomLo]
    cp a, $80
    jr c, .read_battle_target
    ld d, $72 ; battle text 'But the prayer went unanswered!'
    farcall ShowBattleText
    jp SetSubPhase7AndResetResolveStep

.read_battle_target:
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .skip
    jr z, .skip
    ld a, [wBattleTarget]
    and a, $03
    cp a, $03
    jr z, .skip
    call ApplyTargetMaxHPAmount
    ret

.skip:
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 161 LoveRain; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wRandomLo, wEffectByte6F
; writes: wBattleSubPhase, wBattleResolveStep
; points at: wBattleStatus8, wHealFlags
ActionEffect_LoveRain:: ; code pointer of the table ActionEffectTable; C0
Func_036_799B:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus8
    call AddAx9ToHL
    ld a, [hl]
    and a, $01
    jr nz, ActionEffect_LoveRain_CheckEffectByte6F
    push hl
    call AdvanceRandom
    ld a, [wRandomLo]
    and a, $0F
    ld hl, $79DC
    add_a_to_hl
    ld a, [hl]
    push af
    ld a, [wBattleActor]
    ld hl, wHealFlags
    add_a_to_hl
    pop af
    ld [hl], a
    pop hl
    set 1, [hl]
    jp SetSubPhase7AndResetResolveStep

ActionEffect_LoveRain_CheckEffectByte6F::
Jump_036_79CF:: ; address name
    ld a, [wEffectByte6F]
    or a, a
    jr z, .to_set_sub_phase7_and_reset_resolve_step
    call ActionEffect_Heal
    ret

.to_set_sub_phase7_and_reset_resolve_step:
    jp SetSubPhase7AndResetResolveStep
    db $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $01, $01, $02, $02, $02, $02

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 162 Whistle, 163 Pheromone, 164 StepGuard, 165 Outside, 166 Informer, 167 Errand ...; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
ActionEffect_Whistle:: ; code pointer of the table ActionEffectTable; C0
Func_036_79EC:: ; address name
    ret

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 170 Ahhh; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleDamageLo, wBattleDamageHi
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_Ahhh_79ED:: ; code pointer of the table ActionEffectTable; C0
Func_036_79ED:: ; address name
    call ComputeAttackDamage
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    call ShiftHLRight1
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    jp ActionEffect_ActionCF_Skip

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 172 Guard; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wDefeatByteD1, wFollowUpAction
; writes: wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleStatus7, wBattleTargetChoice
ActionEffect_Guard:: ; code pointer of the table ActionEffectTable; C0
Func_036_7A06:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus7
    call AddAx9ToHL
    ld a, [hl]
    and a, $F0
    or a, $01
    ld [hl], a
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $B0, $B2; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wBattleActor, wBattleTarget, wBattleActionId, wDefeatByteD1, wFollowUpAction
; writes: wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleHP, wBattleSlotOut, wBattleBytes4F, wBattleTargetChoice
ActionEffect_ActionB0:: ; code pointer of the table ActionEffectTable; C0
Func_036_7A18:: ; address name
    ld a, [wLinkMode]
    or a, a
    jp nz, SetSubPhase2AndResetResolveStep_CheckDefeatByteD1
    ld a, [wBattleActor]
    cp a, $04
    jp nc, SetSubPhase2AndResetResolveStep_CheckDefeatByteD1
    ld a, [wBattleTarget]
    cp a, $04
    jr c, .check_battle_action_id
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank36
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld a, [wBattleTarget]
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld [hl], $FF
    ld a, [wBattleTarget]
    and a, $03
    ld hl, wBattleBytes4F
    ld b, a
    add a, a
    add a, b
    add_a_to_hl
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    farcall BlankTargetMonsterPicture
    ld a, [wBattleActionId]
    cp a, $B2
    ld d, $8F
    jr z, .call_show_battle_text
    ld d, $D8 ; battle text '0 fled!'
    farcall ShowBattleText
    ld a, $82
    call QueueSoundEffect
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

.check_battle_action_id:
    ld a, [wBattleActionId]
    cp a, $B2
    ld d, $8F
    jr z, .call_show_battle_text
    ld d, $5C ; battle text '0 was shocked!'

.call_show_battle_text:
    farcall ShowBattleText
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $B4; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wDefeatByteD1, wFollowUpAction
; writes: wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleStatus1, wBattleTargetChoice
ActionEffect_ActionB4:: ; code pointer of the table ActionEffectTable; C0
Func_036_7A8E:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    set 3, [hl]

.next:
    inc c
    dec b
    jr nz, .loop
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $B5; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wResolveMsgTarget
; points at: wBattleStatus
ActionEffect_ActionB5:: ; code pointer of the table ActionEffectTable; C0
Func_036_7AAC:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $8C
    jr nz, .skip2
    ld a, [hl]
    or a, $8C
    ld [hl], a
    call TargetOnLocalSide_Bank36
    ld l, $73
    jr nc, .skip
    ld l, $74

.skip:
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip2:
    ld h, $D4
    ld bc, $0080
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $B6; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wDefeatByteD1, wBattleActor, wFollowUpAction
; writes: wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep
; points at: wBattleMP, wBattleTargetChoice
ActionEffect_ActionB6:: ; code pointer of the table ActionEffectTable; C0
Func_036_7AD5:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    or a, [hl]
    jp z, SetSubPhase2AndResetResolveStep_CheckDefeatByteD1
    xor a, a
    ld [hl-], a
    ld [hl], a
    ld l, $DF
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 185; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_ActionB9:: ; code pointer of the table ActionEffectTable; C0
Func_036_7AEE:: ; address name
    call AttackDamageWithATK200
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $BA; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wDefeatByteD1, wBattleActor, wFollowUpAction
; writes: wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep
; points at: wBattleTargetChoice
ActionEffect_ActionBA:: ; code pointer of the table ActionEffectTable; C0
Func_036_7AF4:: ; address name
    call TargetStatus3Address
    bit 0, [hl]
    jp nz, SetSubPhase2AndResetResolveStep_CheckDefeatByteD1
    set 0, [hl]
    call ClearTargetStatus5Bits23And7Bits012
    ld l, $78
    ld bc, $0098
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $BC; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wDefeatByteD1, wBattleActor, wFollowUpAction
; writes: wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg, wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep
; points at: wBattleMP, wBattleMaxMP, wBattleTargetChoice
ActionEffect_ActionBC:: ; code pointer of the table ActionEffectTable; C0
Func_036_7B09:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    push hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wBattleMaxMP
    call AddDoubleAToHL_Bank36
    deref_hl
    call CompareHLToBC
    pop bc
    jp z, SetSubPhase2AndResetResolveStep_CheckDefeatByteD1
    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    ld l, $C3
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $BD; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleHP
ActionEffect_ActionBD:: ; code pointer of the table ActionEffectTable; C0
Func_036_7B36:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank36
    ld c, l
    ld b, h
    ld a, [hl+]
    cp a, $01
    jr nz, .skip
    ld a, [hl]
    or a, a
    jr nz, .skip
    ld hl, $0001
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ld l, $35
    ld bc, $88A8
    jr .skip2

.skip:
    ld a, $01
    ld [bc], a
    inc bc
    ld a, $00
    ld [bc], a
    ld l, $38
    ld bc, $4090

.skip2:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $C0; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_ActionC0:: ; code pointer of the table ActionEffectTable; C0
Func_036_7B6B:: ; address name
    call AdvanceRandom
    ld a, [wRandomLo]
    cp a, $40
    jr c, .skip
    call ComputeAttackDamage
    ld hl, $D136
    ld bc, $80A8
    jp UnreferencedStoreResolveMessage35D0_Bank36_SetResolveMsgActor

.skip:
    ld h, $D1
    ld bc, $0888
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $C1; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
ActionEffect_ActionC1:: ; code pointer of the table ActionEffectTable; C0
Func_036_7B89:: ; address name
    call AdvanceRandom
    ld a, [wRandomLo]
    cp a, $C0
    jr c, .skip
    call ComputeAttackDamage
    jp UnreferencedStoreResolveMessage35D0_Bank36

.skip:
    ld h, $D0
    ld bc, $0888
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $C2; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
ActionEffect_ActionC2:: ; code pointer of the table ActionEffectTable; C0
Func_036_7BA1:: ; address name
    call ActionEffect_Action00
    ret

; effect routine reached through ActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) 171 ZoneOut, 183, 195, 196; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; no direct call (reached through a table, a jump or a vector)
; reads: wDefeatByteD1, wBattleActor, wFollowUpAction
; writes: wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleTargetChoice
ActionEffect_ZoneOut:: ; code pointer of the table ActionEffectTable; C0
Func_036_7BA5:: ; address name
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $C5; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wDefeatByteD1, wFollowUpAction
; writes: wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleStatus3, wBattleTargetChoice
ActionEffect_ActionC5:: ; code pointer of the table ActionEffectTable; C0
Func_036_7BA8:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    set 2, [hl]
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $C6, $C7; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleStatus
ActionEffect_ActionC6:: ; code pointer of the table ActionEffectTable; C0
Func_036_7BB6:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    set 6, [hl]
    ld l, $76
    ld bc, $4090
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $C8; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wDefeatByteD1, wBattleActor, wFollowUpAction
; writes: wBattleTarget, wDefeatByteD1, wBattleSubPhase, wBattleResolveStep, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleSlotOut, wBattleBytes4F, wBattleTargetChoice
ActionEffect_ActionC8:: ; code pointer of the table ActionEffectTable; C0
Func_036_7BC9:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld [hl], $FF
    call TargetOnLocalSide_Bank36
    jr c, .skip
    ld a, [wBattleTarget]
    and a, $03
    ld hl, wBattleBytes4F
    ld b, a
    add a, a
    add a, b
    add_a_to_hl
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    farcall BlankTargetMonsterPicture

.skip:
    jp SetSubPhase2AndResetResolveStep_CheckDefeatByteD1

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $C9, $CA; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleStatus3
ActionEffect_ActionC9:: ; code pointer of the table ActionEffectTable; C0
Func_036_7BF8:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl]
    and a, $3F
    ld [hl+], a
    ld a, [hl]
    and a, $F3
    ld [hl], a
    ld a, [wBattleActor]
    call GetBattleHP
    ld a, $0A
    call DivideHLByA
    ld a, h
    or a, l
    jr nz, .set_battle_damage_lo
    ld hl, $0001

.set_battle_damage_lo:
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ld hl, $AF36
    ld bc, $80A8
    jp UnreferencedStoreResolveMessage35D0_Bank36_SetResolveMsgActor

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $BF, $CB; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleStatus3, wBattleStatus
ActionEffect_ActionBF:: ; code pointer of the table ActionEffectTable; C0
Func_036_7C2C:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl]
    and a, $3F
    ld [hl+], a
    ld a, [hl]
    and a, $F3
    ld [hl], a
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    jr nz, ActionEffect_ActionC9
    ld hl, $0000
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ld hl, $AFAF
    ld bc, $0080
    jp UnreferencedStoreResolveMessage35D0_Bank36_SetResolveMsgActor

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $CC; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleDamageLo, wBattleDamageHi
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleStatus4
ActionEffect_ActionCC:: ; code pointer of the table ActionEffectTable; C0
Func_036_7C5F:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    jp ActionEffect_HighJump_Skip

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $CD; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wRandomLo
; writes: wBattleTarget, wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleStatus3, wBattleStatus
ActionEffect_ActionCD:: ; code pointer of the table ActionEffectTable; C0
Func_036_7C6B:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    jp ActionEffect_Geyser_Skip

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $CE; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wDefeatFlagsBA, wRandomLo, wBattleTarget, wDefeatByteD1, wBattleActor, wFollowUpAction
; writes: wBattleSubPhase, wBattleResolveStep, wBattleTarget, wDefeatByteD1, wResolveMsgFlags, wResolveMsgArg
; points at: wBattleTargetChoice
ActionEffect_ActionCE:: ; code pointer of the table ActionEffectTable; C0
Func_036_7C77:: ; address name
    jp ActionEffect_LifeSong_CheckDefeatFlagsBA

; effect routine reached through DispatchActionEffectTable (36:6726, indexed by wBattleActionId) for action(s) $CF; ids below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; no direct call (reached through a table, a jump or a vector)
; reads: wEffectByte6F
; writes: wBattleSubPhase, wBattleResolveStep
ActionEffect_ActionCF:: ; code pointer of the table ActionEffectTable; C0
Func_036_7C7A:: ; address name
    jp ActionEffect_LoveRain_CheckEffectByte6F

ActionEffect_ActionCF_Skip::
Jump_036_7C7D:: ; address name
    ld hl, $B535
    ld bc, $80A8
    jr UnreferencedStoreResolveMessage35D0_Bank36_SetResolveMsgActor

; the same 23 bytes as UnreferencedStoreResolveMessage35D0 (3B:4EB8)
; 1 call site from 1 routine (e.g. ResolveStepComputeDamage)
; writes: wResolveMsgActor, wResolveMsgTarget, wResolveMsgFlags, wResolveMsgArg
UnreferencedStoreResolveMessage35D0_Bank36::
Func_036_7C85:: ; address name
    ld hl, $D035
    ld bc, $88A8

UnreferencedStoreResolveMessage35D0_Bank36_SetResolveMsgActor::
Jump_036_7C8B:: ; address name
    ld a, l
    ld [wResolveMsgActor], a
    ld a, h
    ld [wResolveMsgTarget], a
    ld a, c
    ld [wResolveMsgFlags], a
    ld a, b
    ld [wResolveMsgArg], a
    ret

; clears wBattleDamageLo/wD873 (the damage word), then wDAC2 = L, wDAC0 = C, wDAC1 = B (E-0073)
; 2 call sites from 2 routines (e.g. ActionEffect_Transform, ActionEffect_NumbOff)
; writes: wBattleDamageLo, wBattleDamageHi, wResolveMsgActor, wResolveMsgFlags, wResolveMsgArg
ClearDamageAndStoreResolveMsgFlags_Bank36::
Func_036_7C9C:: ; address name
    xor a, a
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a

ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor::
Jump_036_7CA3:: ; address name
    ld a, l
    ld [wResolveMsgActor], a
    ld a, c
    ld [wResolveMsgFlags], a
    ld a, b
    ld [wResolveMsgArg], a
    ret

ClearDamageAndStoreResolveMsgFlags_Bank36_Skip::
Jump_036_7CB0:: ; address name
    ld h, $CC
    ld bc, $0080
    jr ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2::
Jump_036_7CB7:: ; address name
    ld h, $B5
    ld bc, $0080

ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget::
Jump_036_7CBC:: ; address name
    ld a, h
    ld [wResolveMsgTarget], a

ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgFlags::
Jump_036_7CC0:: ; address name
    ld a, c
    ld [wResolveMsgFlags], a
    ld a, b
    ld [wResolveMsgArg], a
    ret

; wBattleSubPhase = 2, wBattleResolveStep = 0 (E-0115)
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleSubPhase, wBattleResolveStep
SetSubPhase2AndResetResolveStep::
Jump_036_7CC9:: ; address name
    ld a, $02
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

SetSubPhase2AndResetResolveStep_CheckDefeatByteD1::
Jump_036_7CD3:: ; address name
    ld a, [wDefeatByteD1]
    cp a, $FF
    jr z, .check_follow_up_action
    push hl
    ld [wBattleTarget], a
    push af
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    pop af
    ld [hl], a
    ld a, $FF
    ld [wDefeatByteD1], a
    pop hl

.check_follow_up_action:
    ld a, [wFollowUpAction]
    or a, a
    jr nz, SetSubPhase7AndResetResolveStep_Skip
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

; wBattleSubPhase = 7, wBattleResolveStep = 0 (E-0115)
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleSubPhase, wBattleResolveStep
SetSubPhase7AndResetResolveStep::
Jump_036_7D03:: ; address name
    ld a, $07
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

SetSubPhase7AndResetResolveStep_Skip::
Jump_036_7D0D:: ; address name
    ld bc, $0000
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgFlags

; when the target's status byte 2 (wD80E) bit 2 is set, the damage word is halved (E-0118)
; 2 call sites from 2 routines (e.g. ActionEffect_FrigidAir, ActionEffect_FireAir)
; reads: wBattleTarget, wBattleDamageLo, wBattleDamageHi
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleStatus2
HalveDamageIfTargetStatus2Bit2::
Func_036_7D13:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit 2, [hl]
    ret z
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    call ShiftHLRight1
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ret

; the same 18 bytes as ClearDamageAndReadTargetStatus0 (3B:4F03)
; 6 call sites from 6 routines (e.g. ActionEffect_ActionDB, ActionEffect_ActionDA, ActionEffect_CurseOff, ActionEffect_NumbOff, ...)
; reads: wBattleTarget
; writes: wBattleDamageLo, wBattleDamageHi
; points at: wBattleStatus
ClearDamageAndReadTargetStatus0_Bank36::
Func_036_7D33:: ; address name
    xor a, a
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    ret

; A = slot: sets bit 6 of its status byte 6 (wD812 + 9 * slot); HL kept (E-0096)
; 4 call sites from 3 routines (e.g. ActionEffect_ActionDD, ActionEffect_Speed, ActionEffect_Upper)
; points at: wBattleStatus6
SetSlotStatus6Bit6::
Func_036_7D45:: ; address name
    push hl
    ld hl, wBattleStatus6
    call AddAx9ToHL
    set 6, [hl]
    pop hl
    ret

; A = slot: sets bit 7 of its status byte 6 (wD812 + 9 * slot); HL kept (E-0115)
; 3 call sites from 3 routines (e.g. ActionEffect_LushLicks, ActionEffect_UltraDown_SetSlotStatus6Bit7, ResolveStepDamageMessage_Sub04_Sub01_GetBaseAGLOfSlotA_Sub01)
; points at: wBattleStatus6
SetSlotStatus6Bit7::
Func_036_7D50:: ; address name
    push hl
    ld hl, wBattleStatus6
    call AddAx9ToHL
    set 7, [hl]
    pop hl
    ret

; HL = wD80F + 9 * wBattleTarget, the target's status byte 3 (E-0096)
; 11 call sites from 6 routines (e.g. ActionEffect_ActionBA, ActionEffect_WarCry, ActionEffect_Ahhh, ActionEffect_LegSweep, ...)
; reads: wBattleTarget
; points at: wBattleStatus3
TargetStatus3Address::
Func_036_7D5B:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ret

; clears bits 2-3 of the target's status byte 5 (wD811) and bits 0-2 of its status byte 7 (E-0096)
; 6 call sites from 6 routines (e.g. ActionEffect_ActionBA, ActionEffect_WarCry, ActionEffect_Ahhh, ActionEffect_LegSweep, ...)
; reads: wBattleTarget
; points at: wBattleStatus5
ClearTargetStatus5Bits23And7Bits012::
Func_036_7D65:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hl]
    and a, $F3
    ld [hl], a
    inc hl
    inc hl
    ld a, [hl]
    and a, $F8
    ld [hl], a
    ret

; only called from ActionEffect_Vivify (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Vivify)
; reads: wBattleTarget
; points at: wBattleSlotOut, wBattleStatus, wSlotMarks
ActionEffect_Vivify_AddAx9ToHL::
Func_036_7D79:: ; address name
    ld a, [wBattleTarget]
    ld b, a
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld [hl], $00
    ld a, b
    ld hl, wBattleStatus
    call AddAx9ToHL
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $03
    ret

; removes the first byte equal to C from the 8-byte queue at wD895, shifting later bytes down and filling with $FF (E-0124)
; no direct call (reached through a table, a jump or a vector)
; points at: wActionQueue
RemoveCFromActionQueue:: ; heuristic: follows a terminator; C0
Func_036_7DA6:: ; address name
    ld hl, wActionQueue
    ld b, $08
    ld d, $00

.loop:
    bit 0, d
    jr nz, .next
    ld a, [hl]
    cp a, c
    jr nz, .next2
    ld d, $01

.next:
    inc hl
    ld a, [hl]
    ld [hl], $FF
    dec hl
    ld [hl], a
    inc hl
    dec b
    jr nz, .loop
    ld [hl], $FF
    ret

.next2:
    inc hl
    dec b
    jr nz, .loop
    ret

; jumps to the handler for wBattleActionId (0, or id - $47) from the word table $7DDE (E-0124)
; 1 call site from 1 routine (e.g. ComputeDamageEstimateForAction)
; reads: wBattleActionId
RunEffectHandlerForActionId::
Func_036_7DC9:: ; address name
    ld a, [wBattleActionId]
    or a, a
    jr z, .skip
    sub a, $47

.skip:
    ld hl, EffectHandlerTable
    add a, a
    add_a_to_hl
    call JumpToWordAtHL
    ret

; E-0126 (C1: RunEffectHandlerForActionId (36:7DC9) indexes it with 2 * (action id - $47), or 0 for action 0, and jumps through JumpToWordAtHL; all 40 words point into the bank, and GetBattleATK follows at $7E2E).
; record: handler
EffectHandlerTable::
Data_036_7DDE:: ; address name
    dw ComputeAttackDamage ; entry 0
    dw ActionEffect_WindBeast_ShiftBCRight1 ; entry 1
    dw ActionEffect_Vacuum_ShiftBCRight1 ; entry 2
    dw ActionEffect_Lightning_ShiftBCRight1 ; entry 3
    dw ActionEffect_RockThrow_RollSkillDamageFromRecord ; entry 4
    dw ActionEffect_Watershot_RollSkillDamageFromRecord ; entry 5
    dw ActionEffect_Watershot_RollSkillDamageFromRecord ; entry 6
    dw ActionEffect_CallHelp_WriteBattleDamageLoAndBattleDamageHi ; entry 7
    dw ActionEffect_CallHelp_WriteBattleDamageLoAndBattleDamageHi ; entry 8
    dw AttackDamageScaledBySlotResistancesByte0Bits54 ; entry 9
    dw AttackDamageScaledBySlotResistancesByte1Bits76 ; entry 10
    dw AttackDamageScaledBySlotResistancesByte1Bits54 ; entry 11
    dw AttackDamageScaledBySlotResistancesByte1Bits32 ; entry 12
    dw AttackDamageHalvedDEFVsSlime ; entry 13
    dw AttackDamageHalvedDEFVsDragon ; entry 14
    dw AttackDamageHalvedDEFVsBeast ; entry 15
    dw AttackDamageHalvedDEFVsBird ; entry 16
    dw AttackDamageHalvedDEFVsBug ; entry 17
    dw AttackDamageHalvedDEFVsPlant ; entry 18
    dw AttackDamageHalvedDEFVsDemon ; entry 19
    dw AttackDamageHalvedDEFVsZombie ; entry 20
    dw AttackDamageHalvedDEFVsMaterial ; entry 21
    dw AttackDamageHalvedDEFVsWater ; entry 22
    dw AttackDamageTimes1_5IfSlotDamageFlagsBit0 ; entry 23
    dw ComputeAttackDamage ; entry 24
    dw ComputeAttackDamage ; entry 25
    dw ComputeAttackDamage ; entry 26
    dw ActionEffect_SquallHit ; entry 27
    dw ActionEffect_BiAttack_ShiftHLRight1 ; entry 28
    dw ActionEffect_BiAttack_ShiftHLRight1 ; entry 29
    dw ComputeAttackDamage ; entry 30
    dw ComputeAttackDamage ; entry 31
    dw SkillDamageScaledBySlotResistancesByte6Bits32 ; entry 32
    dw ComputeAttackDamage ; entry 33
    dw ActionEffect_PsycheUp ; entry 34
    dw ComputeAttackDamage ; entry 35
    dw ComputeAttackDamage ; entry 36
    dw ComputeAttackDamage ; entry 37
    dw ActionEffect_PsycheUp ; entry 38
    dw ComputeAttackDamage ; entry 39

; A = battle slot: HL = the word for that slot in the array at wD8FF (Func_036_7E5B)
; 4 call sites from 4 routines (e.g. ComputeBasicDamage, ActionEffect_Massacre, ActionEffect_EvilSlash, ResolveStepComputeDamage)
; points at: wBattleATK
GetBattleATK::
Func_036_7E2E:: ; address name
    ld hl, wBattleATK
    jr ReadBattleWordFromArray

; A = battle slot: HL = the word for that slot in the array at wD90F (Func_036_7E5B)
; 2 call sites from 2 routines (e.g. SlotDEFBelowBuffCap, ActionEffect_UltraDown_Sub02_GetBattleDEF)
; points at: wBattleDEF
GetBattleDEF::
Func_036_7E33:: ; address name
    ld hl, wBattleDEF
    jr ReadBattleWordFromArray

; A = battle slot: HL = the word for that slot in the array at wBattleMaxHP (Func_036_7E5B)
; 2 call sites from 2 routines (e.g. HealTargetHP, ActionEffect_Geyser)
; points at: wBattleMaxHP
GetBattleMaxHP::
Func_036_7E38:: ; address name
    ld hl, wBattleMaxHP
    jr ReadBattleWordFromArray

; A = battle slot: HL = the word for that slot in the array at wBattleMaxMP (Func_036_7E5B)
; 2 call sites from 2 routines (e.g. ActionEffect_RobMagic_Sub01_GetBattleMP, ActionEffect_MPass_AddDoubleAToHL_Bank36)
; points at: wBattleMaxMP
GetBattleMaxMP::
Func_036_7E3D:: ; address name
    ld hl, wBattleMaxMP
    jr ReadBattleWordFromArray

; A = battle slot: HL = the word for that slot in the array at wBattleHP (Func_036_7E5B)
; 6 call sites from 5 routines (e.g. ActionEffect_ActionC9, ActionEffect_Kamikaze_HLToBattleStatus8EntryOfBattleTarget_Bank36, DamageEightyPercentOfTargetHPScaled, ActionEffect_Sacrifice, ...)
; points at: wBattleHP
GetBattleHP::
Func_036_7E42:: ; address name
    ld hl, wBattleHP
    jr ReadBattleWordFromArray

; A = battle slot: HL = the word for that slot in the array at wBattleMP (Func_036_7E5B)
; 3 call sites from 3 routines (e.g. ActionEffect_RobMagic, ActionEffect_RobMagic_Sub01_GetBattleMP, ResolveStepDamageMessage_Sub04_ShowHeroTurnedBackTo)
; points at: wBattleMP
GetBattleMP::
Func_036_7E47:: ; address name
    ld hl, wBattleMP
    jr ReadBattleWordFromArray
    db $21, $1F, $D9, $18, $0A, $21, $53, $DA, $85, $6F, $30, $01, $24, $7E, $C9

; HL = array base, A = slot: HL = the 16-bit word at HL + 2 * A
; 1 call site from 1 routine (e.g. ResolveStepEffectChecks)
ReadBattleWordFromArray::
Func_036_7E5B:: ; address name
    add a, a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes appear in 12 banks)
; 60 call sites from 33 routines (e.g. ActionEffect_BiAttack_ShiftHLRight1, ComputeAttackDamage, RaiseTargetAGL, ReadWordTableEntry_Bank36, ...)
AddDoubleAToHL_Bank36::
Func_036_7E65:: ; address name
    add a, a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the reversal, not checked (E-0064) (the same 27 bytes appear in 12 banks)
; 5 call sites from 4 routines (e.g. ResolveStepDamageMessage_ActorOnLocalSide_Bank36, ResolveStepDamageMessage_TargetOnLocalSide_Bank36, ResolveStepChanceRoll, ResolveStepEffectChecks_ShowMissHeroAvoidedDamage)
; reads: wLinkMode, wLinkRole, wBattleActor
ActorOnLocalSide_Bank36::
Func_036_7E6C:: ; address name
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
; 6 call sites from 6 routines (e.g. ActionEffect_Vivify, ActionEffect_ActionC8, ActionEffect_ActionB5, ResolveStepDamageMessage_TargetOnLocalSide_Bank36, ...)
; reads: wLinkMode, wLinkRole, wBattleTarget
TargetOnLocalSide_Bank36::
Func_036_7E87:: ; address name
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
ClearBattleStatusBitsWithMaskD_Bank36:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:4075; C0
Func_036_7EA2:: ; address name
    ld a, d
    ld hl, $7EB7
    add_a_to_hl
    ld d, [hl]
    ld a, e
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, d
    and a, [hl]
    ld [hl], a
    ret
    db $DF, $FE, $00, $FD, $73, $EF, $BF

; Sets bit 0 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; 3 call sites from 3 routines (e.g. ActionEffect_BeDragon_LoadMonsterRecord, ActionEffect_Transform_Sub01_SlotSpeciesNibblesD00AD00B_Sub01, ResolveStepDamageMessage_Sub04_ShowHeroTurnedBackTo)
; points at: wLevelUpGains
SetBit0OfLevelUpGainsIndexed_Bank36::
Func_036_7EBE:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; Sets bit 1 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; 5 call sites from 4 routines (e.g. ActionEffect_BeDragon_LoadMonsterRecord, ActionEffect_Transform_Sub01_SlotSpeciesNibblesD00AD00B_Sub01, ResolveStepDamageMessage, ResolveStepDamageMessage_Sub04_ShowHeroTurnedBackTo)
; points at: wLevelUpGains
SetBit1OfLevelUpGainsIndexed_Bank36::
Func_036_7ECB:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; Sets bit 2 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wLevelUpGains
SetBit2OfLevelUpGainsIndexed_Bank36:: ; heuristic: follows a terminator; C0
Func_036_7ED8:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 2, [hl]
    pop hl
    ret

; A = slot 0-7: returns A = 9 * g(wD968[A]) + 3 * g(wD970[A]) + g(wD978[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes appear in 13 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo
PersonalityIndexOfSlot_Bank36:: ; heuristic: follows a terminator; C0
Func_036_7EE5:: ; address name
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
; 5 call sites from 5 routines (e.g. ResolveStepFlagBit7Effect, ResolveStepBegin, ResolveStepTargetAndSubEffects_WriteResolveByte81AndResolveFlagB2Etc, ResolveStepTargetAndSubEffects_CheckSlotStatusBlockWide_Bank36, ...)
; points at: wBattleStatus3
CheckSlotStatusBlockWide_Bank36::
Func_036_7F3C:: ; address name
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
; 2 call sites from 2 routines (e.g. ResolveStepTargetAndSubEffects_Case00_ShowButItFailedTo, ResolveStepTargetAndSubEffects_Case00_SlotHasStatus3Or4Bits_Bank36)
; points at: wBattleStatus3
SlotHasStatus3Or4Bits_Bank36::
Func_036_7F5B:: ; address name
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
    ds $94, $00
