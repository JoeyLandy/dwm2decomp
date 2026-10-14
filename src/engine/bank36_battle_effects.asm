; ROM bank $36: battle action resolution and skill effects (ActionEffect_*)
; The annotated listing of this bank is build/listing/bank36.asm.

SECTION "Bank 36", ROMX[$4000], BANK[$36]
    db $36

; jumps through a 16-entry table indexed by wBattleResolveStep (wBattleResolveStep): one step of
; resolving a battle action; the steps advance wBattleResolveStep and use wBattleSubStep
; (wBattleSubStep) and wBattleSubStep2 (wBattleSubStep2) for nested state (E-0043)
RunBattleResolveStep::
    ld a, [wBattleResolveStep]
    jumptable
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

; resolve step $00: advances wBattleResolveStep and clears wBattleSubStep. When wFollowUpAction is
; zero, wRecordBufferData + $5 bit 7 is set, the target is present and bit 5 of the target's
; wPersonalityActs byte is set, it farcalls PickDuckBehindAlly (not read), stores the result in
; wDuckBehindSlot when it is not $FF, shows message $33 and returns; otherwise it clears that bit
; and continues into ResolveStepTargetAndSubEffects (E-0053)
; code: advances wBattleResolveStep; sets wBattleSubStep to 0; branches on wFollowUpAction; calls
; CheckSlotStatusBlockWide_Bank36; branches on wPersonalityActs; calls PickDuckBehindAlly; branches
; on C; copies C to wDuckBehindSlot; calls ShowBattleTextCategory0; clears bit 5 of
; wPersonalityActs; also changes HL, A and D by register arithmetic (E-0347)
ResolveStepBegin::
    ld hl, wBattleResolveStep
    inc [hl]
    xor a
    ld [wBattleSubStep], a
    ld a, [wFollowUpAction]
    or a
    jr nz, .read_battle_target
    ld a, [wRecordBufferData + $5]
    bit 7, a
    jr z, .read_battle_target
    ld a, [wBattleTarget]
    call CheckSlotStatusBlockWide_Bank36
    jr c, .read_battle_target
    ld a, [wBattleTarget]
    ld hl, wPersonalityActs
    add a
    add_a_to_hl
    bit 5, [hl]
    jr z, .read_battle_target
    farcall PickDuckBehindAlly
    ld a, c
    cp $ff
    jr z, .read_battle_target
    ld [wDuckBehindSlot], a
    ld d, $33
    farcall ShowBattleTextCategory0
    ret

.read_battle_target:
    ld a, [wBattleTarget]
    ld hl, wPersonalityActs
    add a
    add_a_to_hl
    res 5, [hl]

; resolve step $01: dispatches on wBattleSubStep to two cases. Case 0 (ResolveTargetReaction) may
; redirect wBattleTarget and shows message $CB, then selects one of four sub-effects by
; wRecordBufferData + $5 bits 7, 4 and 6 (TryShuntOrGuard-Sub04, not read); case 1
; (ResolveStepTargetAndSubEffects_TargetOnLocalSide_Bank36) follows (E-0053)
; code: dispatches on wBattleSubStep (E-0347)
ResolveStepTargetAndSubEffects::
    ld a, [wBattleSubStep]
    jumptable
    dw ResolveTargetReaction
    dw ResolveStepTargetAndSubEffects_TargetOnLocalSide_Bank36

; case 0 of ResolveStepTargetAndSubEffects: unless the action is a follow-up, a target that inhales
; attacks takes the hit in place of its side ('0 inhaled the attack!', wAttackInhaled = 1);
; otherwise, by bits 7, 4 and 6 of the action's record byte 5, tries TryShuntOrGuard, TryWindBounce,
; TryWallOfLightBounce or CheckTargetOutOfReach (E-0053, E-0337)
ResolveTargetReaction::
    xor a
    ld [wAttackDeflected], a
    ld a, [wFollowUpAction]
    or a
    jp nz, .skip2
    ld a, [wRecordBufferData + $4]
    cp $40
    jp z, ResolveStepTargetAndSubEffects_TargetOnLocalSide_Bank36
    and $f0
    cp $20
    jp z, ResolveStepTargetAndSubEffects_TargetOnLocalSide_Bank36
    ld a, [wRecordBufferData + $5]
    bit 4, a
    jr z, .check_record_buffer_data
    ld a, [wBattleTarget]
    and $04
    ld c, a
    rrca
    rrca
    and $01
    ld hl, wSideFlags0
    add_a_to_hl
    bit 6, [hl]
    jr z, .check_record_buffer_data
    ld a, l
    add $5a
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [hl]
    rrca
    rrca
    and $03
    or c
    ld c, a
    call CheckSlotStatusBlockWide_Bank36
    jr c, .check_record_buffer_data
    ld a, $01
    ld [wAttackInhaled], a
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld [hl], c
    ld a, c
    ld [wBattleTarget], a
    ld d, $cb ; battle text '0 inhaled the attack!'
    farcall ShowBattleText
    ld hl, wBattleSubStep
    inc [hl]
    ret

.check_record_buffer_data:
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wRecordBufferData + $5]
    bit 7, a
    jr nz, .call_try_shunt_or_guard
    bit 4, a
    jr nz, .call_try_wind_bounce
    bit 6, a
    jr nz, .call_try_wall_of_light_bounce
    jr .call_check_target_out_of_reach

.call_try_shunt_or_guard:
    call TryShuntOrGuard
    jr c, .return
    jr .skip

.call_try_wind_bounce:
    call TryWindBounce
    jr c, .return
    jr .skip

.call_try_wall_of_light_bounce:
    call TryWallOfLightBounce
    jr c, .return
    jr .skip

.call_check_target_out_of_reach:
    call CheckTargetOutOfReach
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

; step 1 of ResolveStepTargetAndSubEffects: advances wBattleResolveStep; sets wBattleSubStep to 0;
; returns unless bit BSTAT2_AQUA_WALL of wBattleStatus2 is set; may return early; clears
; BSTAT2_AQUA_WALL of wBattleStatus2; calls TargetOnLocalSide_Bank36; calls ShowBattleText; sets
; wDefeatStep to 3; sets wResolveMsgFlags; calls SetSubPhase2AndRestartResolve (E-0347)
; why: step 1 of ResolveStepTargetAndSubEffects (when wBattleSubStep = 1);
; ResolveStepTargetAndSubEffects: resolve step $01: dispatches on wBattleSubStep to two cases. Case
; 0 (ResolveTargetReaction) may redirect wBattleTarget and shows message ... (E-0352, E-0053)
ResolveStepTargetAndSubEffects_TargetOnLocalSide_Bank36::
    ld hl, wBattleResolveStep
    inc [hl]
    xor a
    ld [wBattleSubStep], a
    ld a, [wBattleTarget]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit BSTAT2_AQUA_WALL, [hl]
    ret z
    ld a, [wRecordBufferData + $5]
    bit 3, a
    ret z
    res BSTAT2_AQUA_WALL, [hl]
    ld d, $e9
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

; out of reach: 'But it failed to reach 0!'; else an ally guards the target (TryAllyGuard); else,
; when the target has its duck act (wPersonalityActs bit 5) or status 6 bit 5, it shunts the attack
; to the slot PickShuntSlot returns ('0 shunted the attack!', wOriginalTarget, wRedirectFlags bit 0)
; or fails ('0 failed to avert attack!') (E-0337)
TryShuntOrGuard::
    ld a, [wBattleTarget]
    call SlotHasStatus3Or4Bits_Bank36
    jr z, .call_try_ally_guard
    ld a, [wRecordBufferData + $7]
    bit 5, a
    jr z, .call_try_ally_guard
    ld a, [wBattleActionId]
    cp SKILL_CALLHELP
    jr z, .call_set_sub_phase2_and_restart_resolve
    cp SKILL_YELLHELP
    jr z, .call_set_sub_phase2_and_restart_resolve
    ld a, $84
    call QueueSoundEffect
    call SetSubPhase2AndRestartResolve
    ld d, $68
    jp ShowReactionTextAndCarry

.call_set_sub_phase2_and_restart_resolve:
    call SetSubPhase2AndRestartResolve
    ld d, $69
    jp ShowReactionTextAndCarry

.call_try_ally_guard:
    call TryAllyGuard
    jp nc, ShowReactionTextAndCarry
    ld a, [wBattleActionId]
    cp SKILL_CALLHELP
    jr z, .read_battle_actor
    cp SKILL_YELLHELP
    jr nz, .read_battle_target

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    bit BSTAT6_CALLED_HELP, [hl]
    jr z, .return_0

.read_battle_target:
    ld a, [wBattleTarget]
    call CheckSlotStatusBlockWide_Bank36
    jr c, .return_0
    ld a, [wBattleTarget]
    ld hl, wPersonalityActs
    call AddDoubleAToHL_Bank36
    bit 5, [hl]
    jr nz, .call_pick_shunt_slot
    ld a, [wBattleTarget]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    bit BSTAT6_DODGE, [hl]
    jr z, .return_0

.call_pick_shunt_slot:
    call PickShuntSlot
    jr c, .call_show_battle_text
    push af
    ld a, [wBattleActionId]
    cp SKILL_HIGHJUMP_CC
    jr nz, .restore
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    ld a, [hl]
    and $f3
    ld [hl], a

.restore:
    pop af
    push af
    ld d, $c8 ; battle text '0 shunted the attack!'
    farcall ShowBattleText
    ld a, [wBattleTarget]
    ld [wOriginalTarget], a
    pop af
    ld [wBattleTarget], a
    ld b, a
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    call AddDoubleAToHL_Bank36
    ld [hl], b
    ld hl, wRedirectFlags
    set 0, [hl]
    scf
    ret

.call_show_battle_text:
    ld d, $c9 ; battle text '0 failed to avert attack!'
    farcall ShowBattleText
    scf
    ret

.return_0:
    xor a
    ret

; when the target's status 2 bit 6 is set (a wind guard): clears it, shows 'The wind around 0
; bounced the attack!', sets wAttackDeflected and turns the action back on the actor
; (TurnActionBackOnActor) (E-0337)
TryWindBounce::
    call TryAllyGuard
    jp nc, ShowReactionTextAndCarry
    ld a, [wBattleTarget]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit BSTAT2_WIND_GUARD, [hl]
    jr z, .return_0
    res BSTAT2_WIND_GUARD, [hl]
    ld a, $02
    ld [wDefeatStep], a
    ld d, $c7 ; battle text 'The wind around 0 bounced the'
    farcall ShowBattleText
    ld a, $01
    ld [wAttackDeflected], a
    ld a, [wBattleActor]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .call_set_sub_phase2_and_restart_resolve
    ld d, $01
    call TurnActionBackOnActor
    scf
    ret

.return_0:
    xor a
    ret

.call_set_sub_phase2_and_restart_resolve:
    call SetSubPhase2AndRestartResolve
    scf
    ret

; when the target's status 2 has bit 5 or 1 and the action's record byte 7 bit 7 (a spell): 'The
; wall of light bounced the spell!' (or text $C5 on the other side), sets wAttackDeflected and turns
; the action back on the actor (TurnActionBackOnActor) (E-0337)
TryWallOfLightBounce::
    call TryAllyGuard
    jp nc, ShowReactionTextAndCarry
    ld a, [wBattleTarget]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    ld a, [hl]
    and $22
    jr z, .return_0
    ld a, [wRecordBufferData + $7]
    bit 7, a
    jr z, .return_0
    bit BSTAT2_BOUNCE, [hl]
    jr nz, .call_target_on_local_side_bank36
    res BSTAT2_MAGIC_BACK, [hl]
    ld a, $01
    ld [wDefeatStep], a

.call_target_on_local_side_bank36:
    call TargetOnLocalSide_Bank36
    ld d, $c5
    jr c, .call_show_battle_text
    ld d, $c6 ; battle text 'The wall of light bounced the'

.call_show_battle_text:
    farcall ShowBattleText
    ld a, $01
    ld [wAttackDeflected], a
    ld a, [wBattleActor]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .call_set_sub_phase2_and_restart_resolve
    ld d, $04
    call TurnActionBackOnActor
    scf
    ret

.return_0:
    xor a
    ret

.call_set_sub_phase2_and_restart_resolve:
    call SetSubPhase2AndRestartResolve
    scf
    ret

; when the target is out of reach (status 3 or 4 bits) and the action's record byte 7 bit 5 is set:
; sound $84 and 'But it failed to reach 0!'; otherwise TryAllyGuard (E-0337)
CheckTargetOutOfReach::
    ld a, [wBattleTarget]
    call SlotHasStatus3Or4Bits_Bank36
    jr z, .call_try_ally_guard
    ld a, [wRecordBufferData + $7]
    bit 5, a
    jr z, .call_try_ally_guard
    ld a, $84
    call QueueSoundEffect
    ld d, $68 ; battle text 'But it failed to reach 0!'
    farcall ShowBattleText
    call SetSubPhase2AndRestartResolve
    scf
    ret

.call_try_ally_guard:
    call TryAllyGuard
    jp nc, ShowReactionTextAndCarry
    xor a
    ret

; when the target's status 6 bit 4 is set and the action's record byte 6 bit 0: the ally in the high
; nibble of the next status byte, if able, takes the hit: wOriginalTarget = the target, the ally
; becomes the target, wAttackDeflected = 1, wRedirectFlags bit 1, text $CA '0 guarded <ally>!'
; (returns no carry with D = the text) (E-0337)
TryAllyGuard::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    bit BSTAT6_GUARDED, [hl]
    jr z, .return_carry
    ld a, [wRecordBufferData + $6]
    bit 0, a
    jr z, .return_carry
    inc hl
    ld a, [hl]
    swap a
    and $0f
    ld c, a
    call CheckSlotStatusBlockWide_Bank36
    jr c, .return_carry
    ld a, [wBattleTarget]
    ld [wOriginalTarget], a
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    call AddDoubleAToHL_Bank36
    ld [hl], c
    ld a, c
    ld [wBattleTarget], a
    ld a, $01
    ld [wAttackDeflected], a
    ld hl, wRedirectFlags
    set 1, [hl]
    ld d, $ca
    xor a
    ret

.return_carry:
    scf
    ret

; far-calls ShowBattleText with text D and returns carry (E-0337)
ShowReactionTextAndCarry::
    farcall ShowBattleText
    scf
    ret

; resolve step $02: advances wBattleResolveStep; when wFollowUpAction is non-zero and wAttackInhaled
; is zero and ActionIs91AndStatusBit6Set is not set, it stores $82 in wEffectFlags and farcalls
; SelectEffectByEffectFlags. When wFollowUpAction is zero or wAttackInhaled is non-zero it continues
; as ResolveStepFlagBit7Effect; when ActionIs91AndStatusBit6Set is set it returns (E-0050)
ResolveStepCallEffect82::
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wFollowUpAction]
    or a
    jr z, ResolveStepFlagBit7Effect
    ld a, [wAttackInhaled]
    or a
    jr nz, ResolveStepFlagBit7Effect
    call ActionIs91AndStatusBit6Set
    ret z
    ld a, $82
    ld [wEffectFlags], a
    farcall SelectEffectByEffectFlags
    ret

; Z set when wBattleActionId = $91 and bit 6 of the actor's status byte 3 (wBattleStatus3 + 9 *
; actor) is set; Z clear otherwise (A is $40 or 0 for $91, the comparison result otherwise). Used by
; ResolveStepCallEffect82 (E-0050)
ActionIs91AndStatusBit6Set::
    ld a, [wBattleActionId]
    cp SKILL_GEYSER
    jr z, .read_battle_actor
    ret

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl]
    and $40
    xor $40
    ret

; resolve step $03: advances wBattleResolveStep. When wBattleTarget is present
; (CheckSlotStatusBlockWide_Bank36 does not set carry), wRecordBufferData + $6 bit 6 is set, and the
; target's wPersonalityActs byte has bit 7 set, it farcalls ShowBattleTextCategory0 with D = $35,
; calls SetSubPhase2AndRestartResolve and queues sound $84; otherwise it goes on to case 4 (E-0050)
ResolveStepFlagBit7Effect::
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleTarget]
    call CheckSlotStatusBlockWide_Bank36
    jr c, ResolveStepEffectChecks
    ld a, [wRecordBufferData + $6]
    bit 6, a
    jr z, ResolveStepEffectChecks
    ld a, [wBattleTarget]
    ld hl, wPersonalityActs
    add a
    add_a_to_hl
    bit 7, [hl]
    jr z, ResolveStepEffectChecks
    ld d, $35
    farcall ShowBattleTextCategory0
    call SetSubPhase2AndRestartResolve
    ld a, $84
    call QueueSoundEffect
    ret

; resolve step $04: runs ResolveStepEffectChecks_WaitBattleActionId (returns on action $35) and,
; when the target is present, advances the step. Then it selects one of several effects from
; wRecordBufferData + $6 bits 1, 6 and wRecordBufferData + $5 bits 7 and 0 and the status bytes of
; the actor and target: messages $66, $68 and $D2 (with sound $84) and calls to
; ResolveStepEffectChecks_ShowMissHeroAvoidedDamage when the roll is below a threshold. The
; threshold for the roll comes from the actor's AGL minus the target's AGL, in bands of $320, $258,
; $190, $C8 and $64 (values $80 down to $01); the roll is AdvanceRandom's wRandomLo (E-0054)
ResolveStepEffectChecks::
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
    call ResolveStepEffectChecks_WaitBattleActionId_2
    ret z
    ld a, [wRecordBufferData + $6]
    bit 1, a
    jr z, .check_record_buffer_data
    ld a, [wBattleActionId]
    cp SKILL_HIGHJUMP_CC
    jr nz, .read_battle_target
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    ld a, [hl]
    and $0c
    jr z, .check_record_buffer_data

.read_battle_target:
    ld a, [wBattleTarget]
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hl]
    and $c0
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
    and $0c
    jr z, .read_battle_target2
    cp $0c
    jr nz, .loop
    ld a, [wBattleActionId]
    cp SKILL_HIGHJUMP_CC
    jr nz, .loop
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    ld a, [hl]
    and $0c
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
    and $c0
    jr z, .check_record_buffer_data2
    cp $c0
    jr nz, .loop
    ld a, [wBattleActionId]
    cp SKILL_HIGHJUMP_CC
    jr z, .check_record_buffer_data2
    jr .loop

.check_record_buffer_data2:
    ld a, [wRecordBufferData + $5]
    bit 0, a
    jr z, .check_record_buffer_data3
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_BLINDED, [hl]
    jr z, .read_battle_actor
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $a0
    jr nc, .read_battle_actor
    jr .read_battle_actor2

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hl]
    and $03
    jr z, .check_record_buffer_data3
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $60
    jr nc, .check_record_buffer_data3

.read_battle_actor2:
    ld a, [wBattleActor]
    ld hl, wPersonalityActs
    add a
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
    and $d0
    jp nz, .return
    ld bc, $0004
    add hl, bc
    ld a, [hl]
    and $03
    jp nz, .return
    inc hl
    ld a, [hl]
    and $30
    jp nz, .return
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and $03
    jp nz, .return
    call AdvanceRandom
    ld a, [wBattleTarget]
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hl]
    and $0c
    jr z, .read_battle_actor3
    ld a, [wRandomLo]
    and $01
    jr z, .call_show_battle_text

.read_battle_actor3:
    ld a, [wBattleActor]
    ld hl, wBattleAGL
    add a
    add_a_to_hl
    ld a, [hli]
    ld b, [hl]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wBattleAGL
    call ReadBattleWordFromArray
    ld a, l
    sub c
    ld l, a
    ld a, h
    sbc b
    ld h, a
    jr c, .check_random_lo
    or l
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
    ld bc, $00c8
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
    cp b
    jr nc, .return

.call_show_battle_text:
    ld d, $d2 ; battle text '0 leapt out of the way!'
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

; called from ResolveStepEffectChecks: returns if wBattleActionId is SKILL_IRONIZE; returns if
; wBattleActionId is SKILL_HEAL; returns if wBattleActionId is SKILL_HEALMORE; returns if
; wBattleActionId is SKILL_HEALALL; returns if wBattleActionId is SKILL_MPASS; returns if
; wBattleActionId is SKILL_MPASSMORE; returns if wBattleActionId is SKILL_MPASSMOST; returns if
; wBattleActionId is SKILL_VIVIFY; returns if wBattleActionId is SKILL_REVIVE; returns if
; wBattleActionId is SKILL_FAREWELL; returns if wBattleActionId is SKILL_LIFEDANCE; returns if
; wBattleActionId is SKILL_GUARDIAN; then 3 more steps (see the code) (E-0347)
; why: a helper of ResolveStepEffectChecks; ResolveStepEffectChecks: resolve step $04: runs
; ResolveStepEffectChecks_WaitBattleActionId (returns on action $35) and, when the target is
; present, advances the ... (E-0352, E-0054)
ResolveStepEffectChecks_WaitBattleActionId::
    ld a, [wBattleActionId]
    cp SKILL_IRONIZE
    ret z
    cp SKILL_HEAL
    ret z
    cp SKILL_HEALMORE
    ret z
    cp SKILL_HEALALL
    ret z
    cp SKILL_MPASS
    ret z
    cp SKILL_MPASSMORE
    ret z
    cp SKILL_MPASSMOST
    ret z
    cp SKILL_VIVIFY
    ret z
    cp SKILL_REVIVE
    ret z
    cp SKILL_FAREWELL
    ret z
    cp SKILL_LIFEDANCE
    ret z
    cp SKILL_GUARDIAN
    ret z
    cp SKILL_STORMWIND
    ret z
    cp SKILL_SUCKALL
    ret z
    cp SKILL_HIGHJUMP_BB
    ret z
    cp SKILL_LOVERAIN_CE
    ret

; called from ResolveStepEffectChecks: returns if wBattleActionId is SKILL_HIGHJUMP; returns if
; wBattleActionId is SKILL_LIFESONG (E-0347)
; why: a helper of ResolveStepEffectChecks; ResolveStepEffectChecks: resolve step $04: runs
; ResolveStepEffectChecks_WaitBattleActionId (returns on action $35) and, when the target is
; present, advances the ... (E-0352, E-0054)
ResolveStepEffectChecks_WaitBattleActionId_2::
    ld a, [wBattleActionId]
    cp SKILL_HIGHJUMP
    ret z
    cp SKILL_LIFESONG
    ret z
    cp SKILL_LOVERAIN
    ret

; resolve step $05: advances wBattleResolveStep. With wRecordBufferData + $6 bits 3-4 both clear it
; continues into case 6. Bit 4 with the actor's status byte 1 bit 2 set continues into case 6. With
; wRecordBufferData + $6 bit 3 set and wPersonalityActs bit 0 (target) and status byte 1 bit 3
; (actor) both clear, it rolls RollRandomLoBelowChance: on success it sets bit 7 of the actor's
; status byte 2 (wBattleStatus2), calls ActorOnLocalSide_Bank36, shows message $9C (carry) or $9D
; through ShowBattleText, queues sound $83 and advances the step again; on failure, or when bit 3 is
; clear, it clears that bit (E-0052)
ResolveStepChanceRoll::
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wRecordBufferData + $6]
    and $18
    jr z, ResolveStepActionEffect
    bit 4, a
    jr z, .check_record_buffer_data
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_ATK_DOUBLED, [hl]
    jr nz, ResolveStepActionEffect

.check_record_buffer_data:
    ld a, [wRecordBufferData + $6]
    bit 3, a
    jr z, .read_battle_actor2
    ld a, [wBattleActor]
    ld hl, wPersonalityActs
    call AddDoubleAToHL_Bank36
    bit 0, [hl]
    jr nz, .read_battle_actor
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_CRITICAL, [hl]
    jr nz, .read_battle_actor
    call AdvanceRandom
    call RollRandomLoBelowChance
    jr nc, .read_battle_actor2

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    set BSTAT2_CRITICAL_ROLLED, [hl]
    call ActorOnLocalSide_Bank36
    ld d, $9c
    jr c, .call_show_battle_text
    ld d, $9d ; battle text 'A brutal hit!'

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
    res BSTAT2_CRITICAL_ROLLED, [hl]
    ret

; resolve step $06: advances wBattleResolveStep, then calls DispatchActionEffectTable for
; wBattleActionId (E-0053)
ResolveStepActionEffect::
    ld hl, wBattleResolveStep
    inc [hl]
    call DispatchActionEffectTable
    ret

; resolve step $07: waits for the sound channels in wSoundChannel1 when the actor's wBattleStatus2
; bit 7 is set; advances the step; then works on the damage in wBattleDamageLo/Hi and
; wBattleDamageHi: doubles it for several status bits (wBattleStatus1 bit 2, wBattleStatus4 bits 0
; and 4 with wRecordBufferData + $5 and wRecordBufferData + $6), rerolls it from the actor's ATK
; through RandomWithin5PercentOfHL when wRecordBufferData + $6 bit 3 and wBattleStatus2 bit 7 are
; set, adds half again for wPersonalityActs bit 6, and halves or doubles it on the target's
; wBattleStatus7 and wBattleStatus6 bits (E-0054)
ResolveStepComputeDamage::
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit BSTAT2_CRITICAL_ROLLED, [hl]
    jr z, .check_record_buffer_data
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannel1
    and [hl]
    cp $ff
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
    bit BSTAT1_ATK_DOUBLED, [hl]
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
    bit BSTAT2_CRITICAL_ROLLED, [hl]
    jr z, .check_record_buffer_data3
    res BSTAT2_CRITICAL_ROLLED, [hl]
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
    bit BSTAT4_CHARGE_UP, [hl]
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
    bit BSTAT4_SUCK_AIR, [hl]
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
    ld hl, wPersonalityActs
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
    and $07
    jr z, .read_battle_target3
    and $03
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
    ld a, $0a
    call DivideHLByA

.read_battle_target2:
    ld a, [wBattleTarget]
    ld de, wPersonalityActs
    add a
    add e
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
    bit BSTAT6_BERSERK, [hl]
    jr z, .return
    ld a, [wRecordBufferData + $5]
    bit 7, a
    jr z, .return
    ld a, [wBattleActionId]
    cp SKILL_RAMMING
    jr z, .return
    cp SKILL_KAMIKAZE
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

; resolve step $08: for action $CD it returns while the sound channels in wSoundChannel1 are busy
; (wSoundChannelSlots and wSoundChannel1 not both $FF). Otherwise it advances the step twice,
; updates bit 4 or 6 of wResolveMsgFlags from wBattleDamageLo/Hi and wBattleDamageHi when
; wResolveMsgFlags bit 5 is set, and for action $CF rewinds the step while wResolveMsgFlags bit 4 is
; set and wMultiHitCount is zero. It then stores $40 or $41 in wEffectFlags, farcalls
; SelectEffectByEffectFlags and SelectEffectByEffectFlags2Flags (E-0053)
ResolveStepSoundWaitAndMessage::
    ld a, [wBattleActionId]
    cp SKILL_LOVERAIN_CD
    jr nz, .skip
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannel1
    and [hl]
    cp $ff
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
    or l
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
    cp SKILL_LOVERAIN_CF
    jr nz, .check_resolve_msg_flags
    ld a, [wResolveMsgFlags]
    bit 4, a
    ret z
    ld hl, wBattleResolveStep
    dec [hl]
    ld a, [wMultiHitCount]
    or a
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
    and $10
    or $20
    ld [wEffectFlags2], a
    farcall SelectEffectByEffectFlags2Flags
    ret

; resolve step $09: advances wBattleResolveStep, stores $13 in wEffectFlags, farcalls
; SelectEffectByEffectFlags and queues sound effect $85 (E-0053)
ResolveStepMessage13AndSound::
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $13
    ld [wEffectFlags], a
    farcall SelectEffectByEffectFlags
    ld a, $85
    call QueueSoundEffect
    ret

; resolve step $0A: advances wBattleResolveStep and, for the actor or target side chosen by
; wResolveMsgFlags bit 4, stores wResolveMsgActor or wResolveMsgTarget in wTemp0 and calls
; ResolveStepDamageMessage_TargetOnLocalSide_Bank36 /
; ResolveStepDamageMessage_ActorOnLocalSide_Bank36; the first fight showed the battle text 'took N
; damage!' (bank $2F, category 1, index 53) at this step (E-0045)
ResolveStepDamageMessage::
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
    cp ACTION_DC
    jr z, .call_resolve_step_damage_message_set_sub
    cp ACTION_D7
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
    cp SKILL_TRANSFORM
    jr z, .read_battle_target
    cp SKILL_BEDRAGON
    jr z, .skip
    cp SKILL_HIGHJUMP_B8
    jr z, .skip
    cp SKILL_ROBMAGIC
    jr z, .read_battle_actor2
    cp SKILL_ROBDANCE
    jr z, .read_battle_actor2
    cp ACTION_DC
    jr z, .read_battle_actor3
    cp $df
    jr z, .call_actor_formation_slot_to_temp0
    ret

.read_battle_target:
    ld a, [wBattleTarget]
    add a
    ld de, wBattleMonsterId
    add e
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

; called from ResolveStepDamageMessage: calls LoadBattleMonsterPictureForSlotB (E-0347)
; why: a helper of ResolveStepDamageMessage; ResolveStepDamageMessage: resolve step $0A: advances
; wBattleResolveStep and, for the actor or target side chosen by wResolveMsgFlags bit 4, stores
; wResolveMsgActor ... (E-0352)
ResolveStepDamageMessage_LoadBattleMonsterPictureForSlotB::
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

; resolve step $0B: wBattleActionId $82 jumps to ResolveStepDamageMessage_ReadSoundChannelSlots;
; $83, $84 and $B3 jump to ResolveStepDamageMessage_ReadBattleSubStep; any other action advances
; wBattleResolveStep and returns (E-0050)
ResolveStepBranchOnAction::
    ld a, [wBattleActionId]
    cp SKILL_ULTRADOWN
    jp z, ResolveStepDamageMessage_ReadSoundChannelSlots
    cp SKILL_DEMAGIC
    jp z, ResolveStepDamageMessage_ReadBattleSubStep
    cp SKILL_THICKFOG
    jp z, ResolveStepDamageMessage_ReadBattleSubStep
    cp SKILL_HIGHJUMP_B3
    jp z, ResolveStepDamageMessage_ReadBattleSubStep
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; resolve step $0C: farcalls ApplyDamageToTarget (E-0043)
ResolveStepApplyDamage::
    farcall ApplyDamageToTarget
    ret

; resolve step $0D: runs the defeat sequence RunDefeatSequence (RunDefeatSequence); the first fight
; showed 'was defeated!' (category 1, index 139) at this step (E-0045)
ResolveStepDefeat::
    farcall RunDefeatSequence
    ret

; resolve step $0E: farcalls ResolveStep0EEffect in bank $32 (E-0053)
ResolveStep0ECallEffect::
    farcall ResolveStep0EEffect
    ret

; resolve step $0F: increments wBattleSubPhase and sets wBattleResolveStep to 0 (E-0050)
ResolveStepAdvanceSubPhase::
    ld hl, wBattleSubPhase
    inc [hl]
    xor a
    ld [wBattleResolveStep], a
    ret

; farcalls RollRandomLoBelowChance_WriteTemp0 (not read) and returns the comparison of wRandomLo
; with hTemp0 (taken as 4 when hTemp0 is 3): carry set when wRandomLo is below that value (E-0052)
; code: calls RollRandomLoBelowChance_WriteTemp0; branches on hTemp0; also changes HL, BC and A by
; register arithmetic (E-0347)
RollRandomLoBelowChance::
    push bc
    push hl
    farcall RollRandomLoBelowChance_WriteTemp0
    pop hl
    pop bc
    ldh a, [hTemp0]
    ld b, a
    cp $03
    jr nz, .check_random_lo
    ld b, $04

.check_random_lo:
    ld a, [wRandomLo]
    cp b
    ret

; returns RandomInRange(HL - HL/20, HL + HL/20) in DE (E-0120)
RandomWithin5PercentOfHL::
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
    add $01
    ld e, a
    ld a, d
    cpl
    adc $00
    ld d, a
    add hl, de
    call RandomInRange
    ret

; called from ResolveStepComputeDamage: calls RandomInRange; also changes HL and BC by register
; arithmetic (E-0347)
; why: a helper of ResolveStepComputeDamage; ResolveStepComputeDamage: resolve step $07: waits for
; the sound channels in wSoundChannel1 when the actor's wBattleStatus2 bit 7 is set (E-0352, E-0054)
ResolveStepComputeDamage_RandomInRange::
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

; Returns if bit 4 of wResolveMsgFlags is set; returns unless wFollowUpAction is 0; calls
; SetSubPhase3AndRestartResolve; returns if wRedirectFlags is 0; returns if wOriginalTarget is $ff;
; copies wOriginalTarget to wBattleTarget; sets wOriginalTarget to $ff (E-0347)
; why: part of ResolveStepDamageMessage; ResolveStepDamageMessage: resolve step $0A: advances
; wBattleResolveStep and, for the actor or target side chosen by wResolveMsgFlags bit 4, stores
; wResolveMsgActor ... (E-0352)
ResolveStepDamageMessage_SetSubPhase3AndRestartResolve::
    ld a, [wResolveMsgFlags]
    bit 4, a
    ret nz
    ld a, [wFollowUpAction]
    or a
    ret nz
    call SetSubPhase3AndRestartResolve
    ld a, [wRedirectFlags]
    or a
    ret z
    ld a, [wOriginalTarget]
    cp $ff
    ret z
    ld [wBattleTarget], a
    ld b, a
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld [hl], b
    ld a, $ff
    ld [wOriginalTarget], a
    ret

; called from ResolveStepDamageMessage: branches on wBattleActionId; calls TargetOnLocalSide_Bank36;
; may return early; increments wTemp0; branches on wRedirectFlags; calls ActorOnLocalSide_Bank36;
; may return early; branches on wBattleActionId; increments wTemp0; decrements wTemp0; sets wTemp0
; to $8a; sets wTemp0 to $56; then 7 more steps (see the code) (E-0347)
; why: a helper of ResolveStepDamageMessage; ResolveStepDamageMessage: resolve step $0A: advances
; wBattleResolveStep and, for the actor or target side chosen by wResolveMsgFlags bit 4, stores
; wResolveMsgActor ... (E-0352)
ResolveStepDamageMessage_TargetOnLocalSide_Bank36::
    ld a, [wBattleActionId]
    cp SKILL_MASSACRE
    jr nz, .check_redirect_flags

.loop:
    call TargetOnLocalSide_Bank36
    ret nc
    ld hl, wTemp0
    inc [hl]
    ret

.check_redirect_flags:
    ld a, [wRedirectFlags]
    bit 0, a
    jr nz, .loop
    call ActorOnLocalSide_Bank36
    ret c
    ld a, [wBattleActionId]
    cp SKILL_PANICALL
    jr z, .done
    cp SKILL_PANICALL_AD
    jr z, .done
    cp SKILL_PANIDANCE
    jr z, .done
    cp SKILL_BEAT
    jr z, .loop3
    cp SKILL_DEFEAT
    jr z, .loop3
    cp SKILL_SACRIFICE
    jr z, .skip
    cp SKILL_SLOW
    jr z, .set_temp0_to_CD
    cp SKILL_SLOWALL
    jr z, .set_temp0_to_CD
    cp SKILL_KODANCE
    jr z, .loop3
    cp SKILL_EERIELITE
    jr z, .set_temp0_to_56
    cp SKILL_DANCESHUT
    jr z, .set_temp0_to_63
    cp SKILL_HIGHJUMP_B5
    jr z, .check_resolve_msg_actor
    cp SKILL_HIGHJUMP_BA
    jr z, .set_temp0_to_78
    cp SKILL_HIGHJUMP_BF
    jr z, .done
    cp SKILL_HIGHJUMP_C0
    jr z, .done
    cp SKILL_HIGHJUMP_C9
    jr z, .done
    cp SKILL_HIGHJUMP_CA
    jr z, .done
    cp SKILL_HIGHJUMP_CB
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
    ld a, $8a
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
    ld a, [hli]
    sub $e8
    ld a, [hl]
    sbc $03
    jr z, .loop3
    ld hl, wTemp0
    inc [hl]
    ret

.set_temp0_to_CD:
    ld a, $cd
    ld [wTemp0], a
    ret

.check_resolve_msg_actor:
    ld a, [wResolveMsgActor]
    cp $73
    jr z, .loop2
    jr .done

.set_temp0_to_78:
    ld a, $78
    ld [wTemp0], a
    ret

; called from ResolveStepDamageMessage: calls ActorOnLocalSide_Bank36; may return early; branches on
; wBattleActionId; increments wTemp0; sets wTemp0 to $6a; sets wTemp0 to $6b; sets wTemp0 to $6c;
; sets wTemp0 to $6d; sets wTemp0 to $6e; sets wTemp0 to $71; decrements wTemp0; also changes HL and
; A by register arithmetic (E-0347)
; why: a helper of ResolveStepDamageMessage; ResolveStepDamageMessage: resolve step $0A: advances
; wBattleResolveStep and, for the actor or target side chosen by wResolveMsgFlags bit 4, stores
; wResolveMsgActor ... (E-0352)
ResolveStepDamageMessage_ActorOnLocalSide_Bank36::
    call ActorOnLocalSide_Bank36
    ret c
    ld a, [wBattleActionId]
    cp SKILL_PALSYAIR
    jr z, .set_temp0_to_6A
    cp SKILL_POISONGAS
    jr z, .set_temp0_to_6A
    cp SKILL_POISONAIR
    jr z, .set_temp0_to_6A
    cp SKILL_CURSE
    jr z, .set_temp0_to_6B
    cp SKILL_SANDSTORM
    jr z, .set_temp0_to_6C
    cp SKILL_RADIANT
    jr z, .set_temp0_to_6D
    cp SKILL_EERIELITE
    jr z, .set_temp0_to_6E
    cp SKILL_LUSHLICKS
    jr z, .set_temp0_to_6E
    cp SKILL_SICKLICK
    jr z, .set_temp0_to_6E
    cp SKILL_AHHH
    jr z, .set_temp0_to_71
    cp SKILL_AHHH_AA
    jr z, .set_temp0_to_71
    cp SKILL_HIGHJUMP_C0
    jr z, .done
    ld hl, wTemp0
    inc [hl]
    ret

.set_temp0_to_6A:
    ld a, $6a
    ld [wTemp0], a
    ret

.set_temp0_to_6B:
    ld a, $6b
    ld [wTemp0], a
    ret

.set_temp0_to_6C:
    ld a, $6c
    ld [wTemp0], a
    ret

.set_temp0_to_6D:
    ld a, $6d
    ld [wTemp0], a
    ret

.set_temp0_to_6E:
    ld a, $6e
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

; Returns unless wSoundChannelSlots is $ff; branches on wBattleSubStep; advances wBattleSubPhase;
; sets wBattleResolveStep to 0; sets wBattleSubStep to 0; calls
; ResolveStepDamageMessage_RollVsRadiantResistance; returns if wBattleSubPhase is $05; plays sound
; $99; branches on wResolveMsgFlags; calls ShowBattleText; calls
; ResolveStepDamageMessage_SetSubPhase3AndRestartResolve; calls
; ResolveStepDamageMessage_SetSlotStatus6Bit7; then 5 more steps (see the code) (E-0347)
; why: part of ResolveStepDamageMessage_ActorOnLocalSide_Bank36, in a helper of
; ResolveStepDamageMessage; ResolveStepDamageMessage: resolve step $0A: advances wBattleResolveStep
; and, for the actor or target side chosen by wResolveMsgFlags bit 4, stores wResolveMsgActor ...
; (E-0352)
ResolveStepDamageMessage_ReadSoundChannelSlots::
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannel1
    and [hl]
    cp $ff
    ret nz
    ld a, [wBattleSubStep]
    or a
    jr z, .call_resolve_step_damage_message_set_slot
    ld hl, wBattleSubPhase
    inc [hl]
    xor a
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleSubStep], a
    call ResolveStepDamageMessage_RollVsRadiantResistance
    ld a, [wBattleSubPhase]
    cp $05
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

.call_resolve_step_damage_message_set_slot:
    call ResolveStepDamageMessage_SetSlotStatus6Bit7
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
    ld d, $cd
    jr .call_show_battle_text

.read_resolve_msg_target:
    ld a, [wResolveMsgTarget]
    ld d, a

.call_show_battle_text:
    farcall ShowBattleText
    ld a, $01
    ld [wBattleSubStep], a
    ret

; Dispatches on wBattleSubStep (E-0347)
; why: part of ResolveStepDamageMessage_ActorOnLocalSide_Bank36, in a helper of
; ResolveStepDamageMessage; ResolveStepDamageMessage: resolve step $0A: advances wBattleResolveStep
; and, for the actor or target side chosen by wResolveMsgFlags bit 4, stores wResolveMsgActor ...
; (E-0352)
ResolveStepDamageMessage_ReadBattleSubStep::
    ld a, [wBattleSubStep]
    jumptable
    dw ResolveStepDamageMessage_ShowTheWindAroundHero
    dw ResolveStepDamageMessage_ShowHeroTurnedBackTo
    dw ResolveStepDamageMessage_LoadBattleMonsterPictureForSlotB_2
    dw ResolveStepDamageMessage_ShowHeroWentAway
    dw ResolveStepDamageMessage_AddAx9ToHL_2
    dw ResolveStepDamageMessage_WriteBattleResolveStepAndBattleSubStepEtc

; step 0 of ResolveStepDamageMessage_ActorOnLocalSide_Bank36: advances wBattleSubStep; returns
; unless bit BSTAT2_WIND_GUARD of wBattleStatus2 is set; clears BSTAT2_WIND_GUARD of wBattleStatus2;
; shows battle text 'The wind around 0 died!' (E-0347)
; why: step 0 of ResolveStepDamageMessage_ActorOnLocalSide_Bank36, in a helper of
; ResolveStepDamageMessage; ResolveStepDamageMessage: resolve step $0A: advances wBattleResolveStep
; and, for the actor or target side chosen by wResolveMsgFlags bit 4, stores wResolveMsgActor ...
; (E-0352)
ResolveStepDamageMessage_ShowTheWindAroundHero::
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit BSTAT2_WIND_GUARD, [hl]
    ret z
    res BSTAT2_WIND_GUARD, [hl]
    ld d, $80 ; battle text 'The wind around 0 died!'
    farcall ShowBattleText
    ret

; step 1 of ResolveStepDamageMessage_ActorOnLocalSide_Bank36: advances wBattleSubStep; decrements
; wBattleSubStep; shows battle text '0 turned back to normal!'; calls
; CancelTargetActionUnlessSpecial; sets wBattleArg0 to 1; calls LoadSlotSkillsFromBattlerRecord;
; calls RecomputeTargetStatsFromRecord; calls GetBaseHP; calls GetBattleHP; calls
; SetBit0OfLevelUpGainsIndexed_Bank36; calls GetBaseMP; calls GetBattleMP; then 12 more steps (see
; the code) (E-0347)
; why: step 1 of ResolveStepDamageMessage_ActorOnLocalSide_Bank36, in a helper of
; ResolveStepDamageMessage; ResolveStepDamageMessage: resolve step $0A: advances wBattleResolveStep
; and, for the actor or target side chosen by wResolveMsgFlags bit 4, stores wResolveMsgActor ...
; (E-0352)
ResolveStepDamageMessage_ShowHeroTurnedBackTo::
    ld hl, wBattleSubStep
    inc [hl]
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    ld a, [hl]
    and $30
    jp z, .read_battle_target3
    ld a, [hl]
    and $cf
    ld [hl], a
    ld hl, wBattleSubStep
    dec [hl]
    ld d, $5f ; battle text '0 turned back to normal!'
    farcall ShowBattleText
    push hl
    farcall CancelTargetActionUnlessSpecial
    ld a, [wBattleTarget]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    and $f8
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

; for a target other than slot 3/7: wBattleArg0 = its record field $31 address, wBattleArg2 = its
; wSlotResistances record, then far-calls LoadBattleArg0PointersThenRunPackResistanceFieldsToDE
; (E-0124)
RecomputeTargetStatsFromRecord::
    ld a, [wBattleTarget]
    ld b, a
    and $03
    cp $03
    ret z
    ld a, b
    ld e, BATTLER_RESISTANCES
    call BattlerRecordFieldAddress
    ld a, l
    ld [wBattleArg0], a
    ld a, h
    ld [wBattleArg1], a
    ld a, [wBattleTarget]
    ld de, wSlotResistances
    ld b, a
    add a
    add b
    add a
    add b
    add e
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

; step 2 of ResolveStepDamageMessage_ActorOnLocalSide_Bank36: advances wBattleSubStep; calls
; LoadBattleMonsterPictureForSlotB; sets wSlotMarks to 3; returns if wLinkMode is $01; returns if
; wBattleTarget is below $04; returns if wBattleTarget & $03 is $03; sets wSlotNameBytes to $ff
; (E-0347)
; why: step 2 of ResolveStepDamageMessage_ActorOnLocalSide_Bank36, in a helper of
; ResolveStepDamageMessage; ResolveStepDamageMessage: resolve step $0A: advances wBattleResolveStep
; and, for the actor or target side chosen by wResolveMsgFlags bit 4, stores wResolveMsgActor ...
; (E-0352)
ResolveStepDamageMessage_LoadBattleMonsterPictureForSlotB_2::
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wBattleTarget]
    ld b, a
    add a
    ld de, wBattleMonsterId
    add e
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
    cp $01
    ret z
    ld a, [wBattleTarget]
    cp $04
    ret c
    and $03
    cp $03
    ret z
    ld hl, wSlotNameBytes
    add_a_to_hl
    ld [hl], $ff
    ret

; step 3 of ResolveStepDamageMessage_ActorOnLocalSide_Bank36: advances wBattleSubStep; returns
; unless wBattleTarget & $03 is $03; calls CarryUnlessBattleSlotOutSlotEmpty; may return early;
; shows battle text '0 went away!'; sets wBattleSlotOut to $ff; sets wSlotMarks to $ff; clears bit 2
; of wSideFlags0; also changes HL, A and D by register arithmetic (E-0347)
; why: step 3 of ResolveStepDamageMessage_ActorOnLocalSide_Bank36, in a helper of
; ResolveStepDamageMessage; ResolveStepDamageMessage: resolve step $0A: advances wBattleResolveStep
; and, for the actor or target side chosen by wResolveMsgFlags bit 4, stores wResolveMsgActor ...
; (E-0352)
ResolveStepDamageMessage_ShowHeroWentAway::
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wBattleTarget]
    and $03
    cp $03
    ret nz
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    ret c
    ld d, $7f ; battle text '0 went away!'
    farcall ShowBattleText
    ld a, [wBattleTarget]
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld [hl], $ff
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $ff
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    xor a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hl], a
    ld a, [wBattleTarget]
    and $04
    rrca
    rrca
    and $01
    ld hl, wSideFlags0
    res 2, [hl]
    ret

; step 4 of ResolveStepDamageMessage_ActorOnLocalSide_Bank36: advances wBattleSubStep; returns
; unless bit BSTAT8_SEAL_PRAY of wBattleStatus8 is set; clears BSTAT8_SEAL_PRAY of wBattleStatus8;
; sets wQueuedActionId to $ff; sets wSealPrayState to $ff (E-0347)
; why: step 4 of ResolveStepDamageMessage_ActorOnLocalSide_Bank36, in a helper of
; ResolveStepDamageMessage; ResolveStepDamageMessage: resolve step $0A: advances wBattleResolveStep
; and, for the actor or target side chosen by wResolveMsgFlags bit 4, stores wResolveMsgActor ...
; (E-0352)
ResolveStepDamageMessage_AddAx9ToHL_2::
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wBattleStatus8
    call AddAx9ToHL
    bit BSTAT8_SEAL_PRAY, [hl]
    ret z
    res BSTAT8_SEAL_PRAY, [hl]
    ld a, $ff
    ld [wQueuedActionId], a
    ld a, $ff
    ld [wSealPrayState], a
    ret

; step 5 of ResolveStepDamageMessage_ActorOnLocalSide_Bank36: advances wBattleSubPhase; sets
; wBattleResolveStep to 0; sets wBattleSubStep to 0; copies wSideFlags0 & $93 to wSideFlags0; copies
; wSideFlags1 & $93 to wSideFlags1; returns if wBattleActionId is SKILL_DEMAGIC; sets wSideFlags0;
; sets wSideFlags1 (E-0347)
; why: step 5 of ResolveStepDamageMessage_ActorOnLocalSide_Bank36, in a helper of
; ResolveStepDamageMessage; ResolveStepDamageMessage: resolve step $0A: advances wBattleResolveStep
; and, for the actor or target side chosen by wResolveMsgFlags bit 4, stores wResolveMsgActor ...
; (E-0352)
ResolveStepDamageMessage_WriteBattleResolveStepAndBattleSubStepEtc::
    ld hl, wBattleSubPhase
    inc [hl]
    xor a
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleSubStep], a
    ld a, [wSideFlags0]
    and $93
    ld [wSideFlags0], a
    ld a, [wSideFlags1]
    and $93
    ld [wSideFlags1], a
    ld a, [wBattleActionId]
    cp SKILL_DEMAGIC
    ret z
    ld a, [wSideFlags0]
    or $08
    ld [wSideFlags0], a
    ld a, [wSideFlags1]
    or $08
    ld [wSideFlags1], a
    ret

; loads the picture of battle slot B (species at DE) into its picture area at vTiles2 + $140 + $240
; * position and, on CGB, its attributes (E-0128)
LoadBattleMonsterPictureForSlotB::
    ld a, [wLinkMode]
    cp $01
    ld a, b
    jr nz, .cp_04
    ld a, [wLinkRole]
    bit 1, a
    ld a, b
    jr z, .cp_04
    cp $03
    jr nc, .return
    jr .skip

.cp_04:
    cp $04
    jr c, .return
    cp $07
    jr z, .return
    sub $04

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
    add $01
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
    or a
    ret z
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    ld a, c
    ldh [hTemp0], a
    ld a, [wLinkMode]
    cp $01
    ld a, [wBattleFoeCount]
    jr nz, .cp_01
    ld a, [wLinkRole]
    bit 1, a
    ld a, [wSide1Flag]
    jr z, .cp_01
    ld a, [wSide0Flag]

.cp_01:
    cp $01
    jr z, .skip2
    cp $03
    jr z, .skip3
    ld hl, vBGMap0 + $e4
    jr .skip4

.skip2:
    ld hl, vBGMap0 + $e7
    jr .skip4

.skip3:
    ld hl, vBGMap0 + $e1

.skip4:
    ld a, c
    sub $01
    srl a
    ld b, a
    add a
    add b
    add a
    add_a_to_hl
    call LoadMonsterPictureAttributes

.return:
    ret

; after a bounce: saves the actor, the target, wMultiHitCount and both slots' action choices at
; wSavedActorTarget, gives the target the actor's action aimed back at the actor, swaps wBattleActor
; and wBattleTarget, and ORs D (1 wind, 4 wall of light) into wFollowUpAction (E-0337)
TurnActionBackOnActor::
    push de
    ld hl, wSavedActorTarget
    ld a, [wBattleActor]
    ld [hli], a
    ld a, [wBattleTarget]
    ld [hli], a
    ld a, [wMultiHitCount]
    ld [hli], a
    ld a, [wBattleActor]
    ld de, wBattleActionChoice
    add a
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    ld a, [wBattleTarget]
    ld bc, wBattleActionChoice
    add a
    add c
    ld c, a
    jr nc, .skip2
    inc b

.skip2:
    ld a, [bc]
    ld [hli], a
    inc bc
    ld a, [bc]
    ld [hli], a
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
    or d
    ld [wFollowUpAction], a
    ret

; the same 10 bytes as SetSubPhase3AndRestartResolve (SetSubPhase3AndRestartResolve) (E-0055)
SetSubPhase3AndRestartResolve_Bank36::
    ld a, $03
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    ret

; the slot an attack is shunted to: the ally the target ducked behind (wDuckBehindSlot), no carry,
; when its duck act is set; otherwise a random roll: below $33 carry (the attack is not averted),
; else a choice among the able slots of the other side (wSlotChoices) (E-0337)
PickShuntSlot::
    ld a, [wBattleTarget]
    ld hl, wPersonalityActs
    add a
    add_a_to_hl
    bit 5, [hl]
    jr z, .call_advance_random
    ld a, [wDuckBehindSlot]
    scf
    ccf
    ret

.call_advance_random:
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $33
    jp c, PickRandomEntryOfSlotChoices_ReturnCarry
    cp $66
    jr c, PickRandomEntryOfSlotChoices_Skip
    ld a, $ff
    ld hl, wSlotChoices
    ld bc, $0003
    call FillBytes
    ld a, [wBattleTarget]
    and $04
    xor $04
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

; A = a random one of the first E bytes at wSlotChoices (no carry); the next entry lists the
; target's other occupied ally slots there and carries when none (E-0127)
PickRandomEntryOfSlotChoices::
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

; Calls FillBytes; branches on C; calls CarryUnlessBattleSlotOutSlotEmpty; may continue in
; PickRandomEntryOfSlotChoices_ReturnCarry; calls PickRandomEntryOfSlotChoices; also changes HL, DE,
; BC and A by register arithmetic (E-0347)
; why: part of PickRandomEntryOfSlotChoices; PickRandomEntryOfSlotChoices: A = a random one of the
; first E bytes at wSlotChoices (no carry) (E-0352, E-0127)
PickRandomEntryOfSlotChoices_Skip::
    ld a, $ff
    ld hl, wSlotChoices
    ld bc, $0003
    call FillBytes
    ld a, [wBattleTarget]
    ld d, a
    ld a, [wBattleTarget]
    and $04
    ld c, a
    ld b, $03
    ld e, $00

.loop:
    ld a, c
    cp d
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
    or a
    jr z, PickRandomEntryOfSlotChoices_ReturnCarry
    call PickRandomEntryOfSlotChoices
    ret

; Works on registers only (E-0347)
; why: part of PickRandomEntryOfSlotChoices; PickRandomEntryOfSlotChoices: A = a random one of the
; first E bytes at wSlotChoices (no carry) (E-0352, E-0127)
PickRandomEntryOfSlotChoices_ReturnCarry::
    scf
    ret

; called from ResolveStepEffectChecks: plays sound $84; calls ActorOnLocalSide_Bank36; shows battle
; text 'Miss! 0 avoided damage!' (E-0347)
; why: a helper of ResolveStepEffectChecks; ResolveStepEffectChecks: resolve step $04: runs
; ResolveStepEffectChecks_WaitBattleActionId (returns on action $35) and, when the target is
; present, advances the ... (E-0352, E-0054)
ResolveStepEffectChecks_ShowMissHeroAvoidedDamage::
    ld a, $84
    call QueueSoundEffect
    call ActorOnLocalSide_Bank36
    ld d, $d0
    jr c, .call_show_battle_text
    ld d, $d1 ; battle text 'Miss! 0 avoided damage!'

.call_show_battle_text:
    farcall ShowBattleText
    ret

; for action $CC clears bits 0-1 of the actor's wBattleStatus4 byte when bits 2-3 equal 4; for an
; action in $D0-$E3 it farcalls RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3 first. Then it sets
; wBattleSubPhase to 2 and clears wBattleResolveStep (E-0055)
SetSubPhase2AndRestartResolve::
    ld a, [wBattleActionId]
    cp SKILL_HIGHJUMP_CC
    jr z, .read_battle_actor
    ld a, [wBattleActionId]
    cp ACTION_D0
    jr c, .loop
    cp $e4
    jr nc, .loop
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3

.loop:
    ld a, $02
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    ret

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    ld a, [hl]
    and $0c
    cp $04
    jr nz, .loop
    ld a, [hl]
    and $f3
    ld [hl], a
    jr .loop

; sets wBattleSubPhase to 3 and clears wBattleResolveStep (E-0055)
SetSubPhase3AndRestartResolve::
    ld a, $03
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    ret

; AdvanceRandom, then BC = the target's DEF (wBattleDEF) / 2 and falls into ComputeBasicDamage with
; HL = the actor's ATK (E-0064)
ComputeAttackDamage::
    call AdvanceRandom
    ld a, [wBattleTarget]
    ld hl, wBattleDEF
    call AddDoubleAToHL_Bank36
    ld a, [hli]
    ld b, [hl]
    ld c, a
    call ShiftBCRight1

; the damage formula: HL = the acting slot's value from the array at wBattleATK (GetBattleATK), BC =
; the value to compare with, set by the caller. If HL <= BC the damage is RandomInRange(0, 1).
; Otherwise, with half = (HL - BC) / 2: when HL / 16 >= half the damage is RandomInRange(0, HL /
; 16); else it is half + RandomInRange(-(half / 16), half / 16) + RandomInRange(-1, 1). The 16-bit
; result goes to wBattleDamageLo/Hi. The divisors are 16, not 4: ShiftHLRight4 falls through two
; more shifts (corrected in E-0064)
ComputeBasicDamage::
    ld a, [wBattleActor]
    call GetBattleATK
    call CompareHLToBC
    jr z, .call_random_in_range
    jr c, .call_random_in_range
    ld a, l
    sub c
    ld e, a
    ld a, h
    sbc b
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
    add $01
    ld l, a
    ld a, h
    cpl
    adc $00
    ld h, a
    call RandomInRange
    pop hl
    add hl, de
    push hl
    ld hl, -1
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

; called from ActionEffect_ActionD1: calls RollSkillDamageFromRecord; calls ScaleDamageByFlagsAtHL
; (E-0347)
; why: a helper of ActionEffect_ActionD1; ActionEffect_ActionD1: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) $D1
; (E-0352, E-0084)
ActionEffect_ActionD1_RollSkillDamageFromRecord::
    call RollSkillDamageFromRecord
    ld a, $00
    call ScaleDamageByFlagsAtHL
    ret

; SkillDamageScaledByGigaSlashResistance for action $D2 (E-0338)
ActionEffect_ActionD2_ScaleByGigaSlashResistance::
    call SkillDamageScaledByGigaSlashResistance
    call GetTargetSpeciesFamily
    cp $00
    jr z, .call_scale_damage_by3_over2
    cp $08
    jr z, .call_scale_damage_by3_over2
    cp $09
    ret nz

.call_scale_damage_by3_over2:
    call ScaleDamageBy3Over2
    ret

; SkillDamageScaledByGigaSlashResistance for action $D3 (E-0338)
ActionEffect_ActionD3_ScaleByGigaSlashResistance::
    call SkillDamageScaledByGigaSlashResistance
    call GetTargetSpeciesFamily
    cp $01
    jr z, .call_scale_damage_by3_over2
    cp $03
    jr z, .call_scale_damage_by3_over2
    cp $06
    ret nz

.call_scale_damage_by3_over2:
    call ScaleDamageBy3Over2
    ret

; SkillDamageScaledByGigaSlashResistance for action $D4 (E-0338)
ActionEffect_ActionD4_ScaleByGigaSlashResistance::
    call SkillDamageScaledByGigaSlashResistance
    call GetTargetSpeciesFamily
    cp $02
    jr z, .call_scale_damage_by3_over2
    cp $05
    jr z, .call_scale_damage_by3_over2
    cp $04
    ret nz

.call_scale_damage_by3_over2:
    call ScaleDamageBy3Over2
    ret

; called from ActionEffect_ActionD7: calls AdvanceRandom; calls ComputeBasicDamage; calls
; ActorFormationSlotToTemp0; copies hTemp0 to wBattleActor; calls AdvanceRandom; calls
; ComputeBasicDamage; copies L to wBattleDamageLo; copies H to wBattleDamageHi; sets wBattleActor
; (E-0347)
; why: a helper of ActionEffect_ActionD7; ActionEffect_ActionD7: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) $D7
; (E-0352, E-0084)
ActionEffect_ActionD7_AdvanceRandom::
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

; called from ActionEffect_ActionD8: calls ComputeAttackDamage; calls ActorFormationSlotToTemp0;
; copies hTemp0 to wBattleActor; calls ComputeAttackDamage; copies L to wBattleDamageLo; copies H to
; wBattleDamageHi; sets wBattleActor (E-0347)
; why: a helper of ActionEffect_ActionD8; ActionEffect_ActionD8: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) $D8
; (E-0352, E-0084)
ActionEffect_ActionD8_ComputeAttackDamage::
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

; called from ActionEffect_ActionD9: copies L to wBattleDamageLo; copies H to wBattleDamageHi;
; copies L to wBattleDamageLo; copies H to wBattleDamageHi; calls ActorFormationSlotToTemp0; copies
; hTemp0 to wBattleActor; copies L to wBattleDamageLo; copies H to wBattleDamageHi; copies L to
; wBattleDamageLo; copies H to wBattleDamageHi; sets wBattleActor; continues in
; ActionEffect_MegaMagic_CallScaleHLTo40Percent; then 1 more step (see the code) (E-0347)
; why: a helper of ActionEffect_ActionD9; ActionEffect_ActionD9: effect routine reached through
; ActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 217 (E-0352,
; E-0126)
ActionEffect_ActionD9_WriteBattleDamageLoAndBattleDamageHiEtc::
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
    jp ActionEffect_MegaMagic_CallScaleHLTo40Percent
    db $c9

; called from ActionEffect_Blaze: calls RollSkillDamageFromRecord; calls
; GetTargetSlotResistancesByte0; calls ScaleDamageByFlagsAtHL (E-0347)
; why: a helper of ActionEffect_Blaze; ActionEffect_Blaze: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 1 Blaze, 2
; ... (E-0352, E-0084)
ActionEffect_Blaze_RollSkillDamageFromRecord::
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte0
    swap a
    and $03
    call ScaleDamageByFlagsAtHL
    ret

; called from ActionEffect_Firebal: calls RollSkillDamageFromRecord; calls
; GetTargetSlotResistancesByte0; calls ScaleDamageByFlagsAtHL (E-0347)
; why: a helper of ActionEffect_Firebal; ActionEffect_Firebal: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 4 Firebal,
; 5 ... (E-0352, E-0084)
ActionEffect_Firebal_RollSkillDamageFromRecord::
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte0
    rrca
    rrca
    and $03
    call ScaleDamageByFlagsAtHL
    ret

; called from ActionEffect_Bang: calls RollSkillDamageFromRecord; calls
; GetTargetSlotResistancesByte0; calls ScaleDamageByFlagsAtHL (E-0347)
; why: a helper of ActionEffect_Bang; ActionEffect_Bang: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 7 Bang, 8
; Boom, 9 ... (E-0352, E-0084)
ActionEffect_Bang_RollSkillDamageFromRecord::
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte0
    and $03
    call ScaleDamageByFlagsAtHL
    ret

; called from ActionEffect_Infernos: calls RollSkillDamageFromRecord (E-0347)
; why: a helper of ActionEffect_Infernos; ActionEffect_Infernos: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 10
; Infernos, 11 ... (E-0352, E-0084)
ActionEffect_Infernos_RollSkillDamageFromRecord::
    call RollSkillDamageFromRecord

; scales the skill damage in HL by the target's Vacuum (byte 1, bits 7-6) resistance level (2 bits);
; used by Vacuum and WindBeast (E-0338)
ScaleDamageByVacuumResistance::
    call GetTargetSlotResistancesByte1
    rlca
    rlca
    and $03
    call ScaleDamageByFlagsAtHL
    ret

; rolls the skill's damage from its record, then ScaleDamageByBoltResistance; used by Bolt and
; action $D0 (E-0338)
RollSkillDamageScaledByBoltResistance::
    call RollSkillDamageFromRecord

; scales the skill damage in HL by the target's Bolt (byte 1, bits 5-4) resistance level (2 bits);
; used by Bolt, Lightning and action $D0 (E-0338)
ScaleDamageByBoltResistance::
    call GetTargetSlotResistancesByte1
    swap a
    and $03
    call ScaleDamageByFlagsAtHL
    ret

; called from ActionEffect_IceBolt: calls RollSkillDamageFromRecord; calls
; GetTargetSlotResistancesByte1; calls ScaleDamageByFlagsAtHL (E-0347)
; why: a helper of ActionEffect_IceBolt; ActionEffect_IceBolt: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 16
; IceBolt, 17 ... (E-0352, E-0084)
ActionEffect_IceBolt_RollSkillDamageFromRecord::
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte1
    rrca
    rrca
    and $03
    call ScaleDamageByFlagsAtHL
    ret

; restores the target's HP by the rolled skill amount, or fully for actions $20, $B1, $7B, $DA (with
; other cases for $18, $1A, $CF), capped at its max HP (E-0129)
HealTargetHP::
    ld a, [wBattleActionId]
    cp SKILL_HEALALL
    jp z, .check_link_mode
    cp SKILL_HEALUSALL
    jp z, .check_link_mode
    cp SKILL_FAREWELL
    jr z, .loop
    cp SKILL_HIGHJUMP_B1
    jr z, .loop
    cp SKILL_LIFEDANCE
    jr z, .loop
    cp SKILL_LOVERAIN_CF
    jr z, .read_battle_target
    cp ACTION_DA
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
    ld a, [hli]
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
    add e
    ld c, a
    ld a, h
    adc d
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
    ld [hli], a
    ld [hl], b
    scf
    ret

.read_battle_target:
    ld a, [wBattleTarget]
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank36
    ld a, [hli]
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
    or a
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
    cp $01
    jp z, .loop
    ld a, [wBattleActor]
    bit 2, a
    jp z, .loop
    jp .call_roll_skill_damage_from_record

; called from ActionEffect_MPass: branches on wBattleActionId; copies E to wBattleDamageLo; copies D
; to wBattleDamageHi; calls GetBattleMaxMP; also changes HL, DE, BC and A by register arithmetic
; (E-0347)
; why: a helper of ActionEffect_MPass; ActionEffect_MPass: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 27 MPass,
; 28 ... (E-0352, E-0084)
ActionEffect_MPass_AddDoubleAToHL_Bank36::
    ld a, [wBattleActionId]
    cp SKILL_MPASS
    jr z, .skip
    cp SKILL_MPASSMORE
    jr z, .set_battle_damage_lo
    ld de, $0050
    jr .set_battle_damage_lo2

.skip:
    ld de, $000f
    jr .set_battle_damage_lo2

.set_battle_damage_lo:
    ld de, $001e

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
    add e
    ld c, a
    ld a, h
    adc d
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
    ld [hli], a
    ld [hl], b
    scf
    ret
    db $37, $3f, $c9

; called from ActionEffect_BigBang: calls RollSkillDamageFromRecord; calls
; GetTargetSlotResistancesByte0; calls ScaleDamageByFlagsAtHLAlt (E-0347)
; why: a helper of ActionEffect_BigBang; ActionEffect_BigBang: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 62 BigBang
; (E-0352, E-0084)
ActionEffect_BigBang_RollSkillDamageFromRecord::
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte0
    swap a
    and $03
    call ScaleDamageByFlagsAtHLAlt
    ret

; called from ActionEffect_FireAir: calls RollSkillDamageFromRecord; calls
; GetTargetSlotResistancesByte4; calls ScaleDamageByFlagsAtHLAlt (E-0347)
; why: a helper of ActionEffect_FireAir; ActionEffect_FireAir: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 64
; FireAir, 65 ... (E-0352, E-0084)
ActionEffect_FireAir_RollSkillDamageFromRecord::
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte4
    swap a
    and $03
    call ScaleDamageByFlagsAtHLAlt
    ret

; called from ActionEffect_FrigidAir: calls RollSkillDamageFromRecord; calls
; GetTargetSlotResistancesByte4; calls ScaleDamageByFlagsAtHLAlt (E-0347)
; why: a helper of ActionEffect_FrigidAir; ActionEffect_FrigidAir: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 68
; FrigidAir, 69 ... (E-0352, E-0084)
ActionEffect_FrigidAir_RollSkillDamageFromRecord::
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte4
    rrca
    rrca
    and $03
    call ScaleDamageByFlagsAtHLAlt
    ret

; called from ActionEffect_RockThrow: calls RollSkillDamageFromRecord; calls
; GetTargetSlotResistancesByte6; calls ScaleDamageByFlagsAtHL (E-0347)
; why: a helper of ActionEffect_RockThrow; ActionEffect_RockThrow: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 75
; RockThrow (E-0352, E-0084)
ActionEffect_RockThrow_RollSkillDamageFromRecord::
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte6
    swap a
    and $03
    call ScaleDamageByFlagsAtHL
    ret

; raises the target's DEF by a third (half for action $25) of its base DEF, limited by the buff cap;
; the actual gain is stored as damage (E-0128)
RaiseTargetDEF::
    ld a, [wBattleTarget]
    call SlotDEFBelowBuffCap
    jr nc, .return_0
    jr z, .return_0
    ld a, [wBattleTarget]
    call GetBaseDEFOfSlotA
    ld a, [wBattleActionId]
    cp SKILL_UPPER
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
    add c
    ld [hli], a
    ld a, [hl]
    adc b
    ld [hl], a
    ld a, [wBattleTarget]
    push hl
    call SlotDEFBelowBuffCap
    pop hl
    jr c, .return_carry
    ld a, [hld]
    ld e, [hl]
    ld d, a
    ld a, c
    ld [hli], a
    ld [hl], b
    ld a, e
    sub c
    ld e, a
    ld a, d
    sbc b
    ld d, a
    ld a, [wBattleDamageLo]
    sub e
    ld e, a
    ld a, [wBattleDamageHi]
    sbc d
    ld d, a
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wBattleDamageHi], a

.return_carry:
    scf
    ret

.return_0:
    xor a
    ret

; rolls whether the action gets through the target's Sap (byte 3, bits 5-4) resistance (a 2-bit
; level; certain when ForceLevel4IfActorConcentrated gives 4); used by Sap and LushLicks; carry = it
; gets through (E-0095, E-0338)
RollVsSapResistance::
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte3
    swap a
    and $03
    ld [wBattleArg2], a
    call ForceLevel4IfActorConcentrated
    cp $04
    jr nz, .check_battle_action_id
    scf
    ret

.check_battle_action_id:
    and $03
    ld b, a
    ld a, [wBattleActionId]
    cp SKILL_SICKLICK
    ld a, b
    jr z, .call_roll_chance_by_flags_at_hl_sided
    call RollChanceByFlagsAtHL
    ret

.call_roll_chance_by_flags_at_hl_sided:
    call RollChanceByFlagsAtHLSided
    ret

; Calls GetBattleDEF; calls GetBaseDEFOfSlotA; branches on wBattleActionId; calls ShiftBCRight1;
; copies C to wBattleDamageLo; copies B to wBattleDamageHi; also changes HL, BC and A by register
; arithmetic (E-0347)
; why: part of ActionEffect_UltraDown; ActionEffect_UltraDown: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 130
; UltraDown (E-0352, E-0084)
ActionEffect_UltraDown_GetBattleDEF::
    ld a, [wBattleTarget]
    call GetBattleDEF
    ld b, h
    ld c, l
    ld hl, $0001
    call CompareHLToBC
    jr c, .read_battle_target
    xor a
    ret

.read_battle_target:
    ld a, [wBattleTarget]
    call GetBaseDEFOfSlotA
    ld a, [wBattleActionId]
    cp SKILL_SAP
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
    ld a, [hli]
    ld h, [hl]
    or h
    pop hl
    jr z, .return_0
    ld a, c
    ld [wBattleDamageLo], a
    ld a, b
    ld [wBattleDamageHi], a
    ld a, [hl]
    sub c
    ld [hli], a
    ld a, [hl]
    sbc b
    ld [hl], a
    jr nc, .return_carry
    xor a
    ld [hld], a
    ld [hl], a

.return_carry:
    scf
    ret

.return_0:
    xor a
    ret

; raises the target's AGL by a third (half for action $29) of its base AGL, limited by the buff cap;
; the actual gain is stored as damage (E-0128)
RaiseTargetAGL::
    ld a, [wBattleTarget]
    call SlotAGLBelowBuffCap
    jr nc, .return_0
    ld a, [wBattleTarget]
    call GetBaseAGLOfSlotA
    ld a, [wBattleActionId]
    cp SKILL_SPEED
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
    add c
    ld [hli], a
    ld a, [hl]
    adc b
    ld [hl], a
    ld a, [wBattleTarget]
    push hl
    call SlotAGLBelowBuffCap
    pop hl
    jr c, .return_carry
    dec hl
    ld a, [hli]
    sub c
    ld e, a
    ld a, [hl]
    sbc b
    ld d, a
    ld a, b
    ld [hld], a
    ld [hl], c
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    ld a, c
    sub e
    ld e, a
    ld a, b
    sbc d
    ld d, a
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wBattleDamageHi], a

.return_carry:
    scf
    ret

.return_0:
    xor a
    ret

; rolls whether the action gets through the target's Slow (byte 3, bits 3-2) resistance (a 2-bit
; level; certain when ForceLevel4IfActorConcentrated gives 4); used by Slow; carry = it gets through
; (E-0095, E-0338)
RollVsSlowResistance::
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte3
    rrca
    rrca
    and $03
    call ForceLevel4IfActorConcentrated
    cp $04
    jr nz, .call_roll_chance_by_flags_at_hl
    scf
    ret

.call_roll_chance_by_flags_at_hl:
    call RollChanceByFlagsAtHL
    ret

; Calls GetBaseAGLOfSlotA; branches on wBattleActionId; calls ShiftBCRight1; copies C to
; wBattleDamageLo; copies B to wBattleDamageHi; sets wBattleAGL to 1; copies E to wBattleDamageLo;
; copies D to wBattleDamageHi; also changes HL, DE, BC and A by register arithmetic (E-0347)
; why: part of ResolveStepDamageMessage; ResolveStepDamageMessage: resolve step $0A: advances
; wBattleResolveStep and, for the actor or target side chosen by wResolveMsgFlags bit 4, stores
; wResolveMsgActor ... (E-0352)
ResolveStepDamageMessage_GetBaseAGLOfSlotA::
    ld a, [wBattleTarget]
    call GetBaseAGLOfSlotA
    ld a, [wBattleActionId]
    cp SKILL_SLOW
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
    sub d
    ld c, a
    ld a, b
    sbc $00
    ld b, a
    ld a, c
    ld [wBattleDamageLo], a
    ld a, b
    ld [wBattleDamageHi], a
    ld a, [hl]
    ld e, a
    sub c
    ld [hli], a
    ld a, [hl]
    ld d, a
    sbc b
    ld [hl], a
    jr nc, .return_carry
    xor a
    ld [hld], a
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
    xor a
    ret

; scales the attack damage in HL by the target's Blaze (byte 0, bits 5-4) resistance level (2 bits);
; used by FireSlash (E-0338)
AttackDamageScaledByBlazeResistance::
    call ComputeAttackDamage
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte0
    swap a
    and $03
    call ScaleDamageByFlagsAtHLBit6
    ret

; scales the attack damage in HL by the target's Vacuum (byte 1, bits 7-6) resistance level (2
; bits); used by VacuSlash (E-0338)
AttackDamageScaledByVacuumResistance::
    call ComputeAttackDamage
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte1
    rlca
    rlca
    and $03
    call ScaleDamageByFlagsAtHLBit6
    ret

; scales the attack damage in HL by the target's Bolt (byte 1, bits 5-4) resistance level (2 bits);
; used by BoltSlash (E-0338)
AttackDamageScaledByBoltResistance::
    call ComputeAttackDamage
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte1
    swap a
    and $03
    call ScaleDamageByFlagsAtHLBit6
    ret

; scales the attack damage in HL by the target's IceBolt (byte 1, bits 3-2) resistance level (2
; bits); used by IceSlash (E-0338)
AttackDamageScaledByIceBoltResistance::
    call ComputeAttackDamage
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte1
    rrca
    rrca
    and $03
    call ScaleDamageByFlagsAtHLBit6
    ret

; when the target's species family (GetTargetSpeciesFamily) is 0 (Slime), damage =
; ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
AttackDamageHalvedDEFVsSlime::
    call GetTargetSpeciesFamily
    cp $00
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

; when the target's species family (GetTargetSpeciesFamily) is 1 (Dragon), damage =
; ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
AttackDamageHalvedDEFVsDragon::
    call GetTargetSpeciesFamily
    cp $01
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

; when the target's species family (GetTargetSpeciesFamily) is 2 (Beast), damage =
; ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
AttackDamageHalvedDEFVsBeast::
    call GetTargetSpeciesFamily
    cp $02
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

; when the target's species family (GetTargetSpeciesFamily) is 3 (Bird), damage =
; ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
AttackDamageHalvedDEFVsBird::
    call GetTargetSpeciesFamily
    cp $03
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

; when the target's species family (GetTargetSpeciesFamily) is 5 (Bug), damage =
; ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
AttackDamageHalvedDEFVsBug::
    call GetTargetSpeciesFamily
    cp $05
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

; when the target's species family (GetTargetSpeciesFamily) is 4 (Plant), damage =
; ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
AttackDamageHalvedDEFVsPlant::
    call GetTargetSpeciesFamily
    cp $04
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

; when the target's species family (GetTargetSpeciesFamily) is 6 (Demon), damage =
; ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
AttackDamageHalvedDEFVsDemon::
    call GetTargetSpeciesFamily
    cp $06
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

; when the target's species family (GetTargetSpeciesFamily) is 7 (Zombie), damage =
; ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
AttackDamageHalvedDEFVsZombie::
    call GetTargetSpeciesFamily
    cp $07
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

; when the target's species family (GetTargetSpeciesFamily) is 8 (Material), damage =
; ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
AttackDamageHalvedDEFVsMaterial::
    call GetTargetSpeciesFamily
    cp $08
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

; when the target's species family (GetTargetSpeciesFamily) is 9 (Water), damage =
; ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
AttackDamageHalvedDEFVsWater::
    call GetTargetSpeciesFamily
    cp $09
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

; ComputeAttackDamage, then damage = damage * 3 / 2 + 1 when bit 0 of wSlotBodyFlags[target] is set
; (E-0124)
AttackDamageTimes1_5IfSlotDamageFlagsBit0::
    call ComputeAttackDamage
    ld a, [wBattleTarget]
    ld hl, wSlotBodyFlags
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

; rolls whether the action gets through the target's Radiant (byte 1, bits 1-0) resistance (a 2-bit
; level; certain when ForceLevel4IfActorConcentrated gives 4); used by Radiant; carry = it gets
; through (E-0095, E-0338)
RollVsRadiantResistance::
    ld a, [wBattleActionId]
    cp SKILL_ULTRADOWN
    jr z, .return_carry
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte1
    and $03
    call ForceLevel4IfActorConcentrated
    cp $04
    jr nz, .check_battle_action_id

.return_carry:
    scf
    ret

.check_battle_action_id:
    and $03
    ld b, a
    ld a, [wBattleActionId]
    cp SKILL_SANDSTORM
    ld a, b
    jr z, .call_roll_chance_by_hl_bits6_and7
    call RollChanceByFlagsAtHL
    ret

.call_roll_chance_by_hl_bits6_and7:
    call RollChanceByHLBits6And7
    ret

; rolls whether the action gets through the target's RobMagic (byte 2, bits 3-2) resistance (a 2-bit
; level; certain when ForceLevel4IfActorConcentrated gives 4); used by RobMagic and OddDance; carry
; = it gets through (E-0095, E-0338)
RollVsRobMagicResistance::
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte2
    rrca
    rrca
    and $03
    ld [wBattleArg2], a
    call ForceLevel4IfActorConcentrated
    cp $04
    jr nz, .call_roll_chance_by_flags_at_hl
    scf
    ret

.call_roll_chance_by_flags_at_hl:
    call RollChanceByFlagsAtHL
    ret

; called from ActionEffect_RobMagic: calls DrainTargetMPAmount; calls
; ActionEffect_RobMagic_GetBattleMP; also changes HL, BC and A by register arithmetic (E-0347)
; why: a helper of ActionEffect_RobMagic; ActionEffect_RobMagic: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 50
; RobMagic, 119 ... (E-0352, E-0084)
ActionEffect_RobMagic_DrainTargetMPAmount::
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
    ld [hli], a
    ld [hl], b
    ld a, [wBattleActor]
    call ActionEffect_RobMagic_GetBattleMP
    jr nc, .return
    ld a, [wBattleActor]
    ld bc, wBattleMaxMP + $1
    add a
    add c
    ld c, a
    jr nc, .skip
    inc b

.skip:
    ld a, [bc]
    ld [hld], a
    dec bc
    ld a, [bc]
    ld [hl], a

.return:
    ret

; takes MP from the target: up to wBattleLevel[actor] / 4 + 5 (or wSavedActorSlot for action $DF),
; limited by its MP; the amount is stored as damage (E-0127)
DrainTargetMPAmount::
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    push hl
    ld a, [wBattleActionId]
    cp $df
    jr nz, .skip
    ld a, [wSavedActorSlot]
    ld c, a
    ld a, [wSavedActorByte]
    ld b, a
    jr .set_battle_damage_lo

.skip:
    deref_hl
    or h
    jr z, .set_battle_damage_lo2
    ld a, [wBattleActor]
    ld de, wBattleLevel
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    srl a
    srl a
    add $05
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
    sub c
    ld [hli], a
    ld a, [hl]
    sbc b
    ld [hl], a
    ret

; called from ActionEffect_StopSpell: calls HLToBattleStatus8EntryOfBattleTarget_Bank36; calls
; GetTargetSlotResistancesByte2; calls ForceLevel4IfActorConcentrated; calls RollChanceByFlagsAtHL
; (E-0347)
; why: a helper of ActionEffect_StopSpell; ActionEffect_StopSpell: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 51
; StopSpell (E-0352, E-0084)
ActionEffect_StopSpell_HLToBattleStatus8EntryOfBattleTarget_Bank36::
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte2
    and $03
    call ForceLevel4IfActorConcentrated
    cp $04
    jr nz, .call_roll_chance_by_flags_at_hl
    scf
    ret

.call_roll_chance_by_flags_at_hl:
    call RollChanceByFlagsAtHL
    ret

; called from ActionEffect_PanicAll: calls HLToBattleStatus8EntryOfBattleTarget_Bank36; calls
; GetTargetSlotResistancesByte3; branches on wBattleActionId; calls ForceLevel4IfActorConcentrated;
; calls RollChanceByFlagsAtHLSided; also changes A by register arithmetic (E-0347)
; why: a helper of ActionEffect_PanicAll; ActionEffect_PanicAll: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 52
; PanicAll, 120 ... (E-0352, E-0084)
ActionEffect_PanicAll_HLToBattleStatus8EntryOfBattleTarget_Bank36::
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte3
    rlca
    rlca
    and $03
    push af
    ld a, [wBattleActionId]
    cp $e1
    jr nz, .call_force_level4_if_actor_concentrated
    pop af
    xor a
    push af

.call_force_level4_if_actor_concentrated:
    pop af
    call ForceLevel4IfActorConcentrated
    cp $04
    jr nz, .call_roll_chance_by_flags_at_hl_sided
    scf
    ret

.call_roll_chance_by_flags_at_hl_sided:
    call RollChanceByFlagsAtHLSided
    ret

; called from ActionEffect_Transform: calls ActionEffect_Transform_SlotSpeciesNibblesD00AD00B_2;
; calls ActionEffect_Transform_GetBaseHP; calls SetBit0OfLevelUpGainsIndexed_Bank36; calls
; ActionEffect_Transform_GetBaseMP; calls SetBit1OfLevelUpGainsIndexed_Bank36; calls
; GetBaseATKOfSlotA; calls GetBaseDEFOfSlotA; calls GetBaseAGLOfSlotA; calls
; ActionEffect_Transform_BattlerRecordFieldAddress; copies L to wBattleArg0; copies H to
; wBattleArg1; copies E to wBattleArg2; then 12 more steps (see the code) (E-0347)
; why: a helper of ActionEffect_Transform; ActionEffect_Transform: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 58
; Transform (E-0352, E-0084)
ActionEffect_Transform_SlotSpeciesNibblesD00AD00B::
    ld a, [wBattleTarget]
    call ActionEffect_Transform_SlotSpeciesNibblesD00AD00B_2
    ld a, [wBattleActor]
    ld hl, wSlotBodyFlags
    add_a_to_hl
    ld [hl], c
    ld a, [wBattleTarget]
    call ActionEffect_Transform_GetBaseHP
    ld a, [wBattleActor]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank36
    push hl
    deref_hl
    call CompareHLToBC
    pop hl
    jr c, .read_battle_actor
    ld a, c
    ld [hli], a
    ld [hl], b
    ld a, [wBattleActor]
    call SetBit0OfLevelUpGainsIndexed_Bank36

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank36
    ld a, c
    ld [hli], a
    ld [hl], b
    ld a, [wBattleTarget]
    call ActionEffect_Transform_GetBaseMP
    ld a, [wBattleActor]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    push hl
    deref_hl
    call CompareHLToBC
    pop hl
    jr c, .read_battle_actor2
    ld a, c
    ld [hli], a
    ld [hl], b
    ld a, [wBattleActor]
    call SetBit1OfLevelUpGainsIndexed_Bank36

.read_battle_actor2:
    ld a, [wBattleActor]
    ld hl, wBattleMaxMP
    call AddDoubleAToHL_Bank36
    ld a, c
    ld [hli], a
    ld [hl], b
    ld a, [wBattleActor]
    ld hl, wBattleATK
    call AddDoubleAToHL_Bank36
    ld a, [wBattleTarget]
    call GetBaseATKOfSlotA
    ld a, c
    ld [hli], a
    ld [hl], b
    ld a, [wBattleActor]
    ld hl, wBattleDEF
    call AddDoubleAToHL_Bank36
    ld a, [wBattleTarget]
    call GetBaseDEFOfSlotA
    ld a, c
    ld [hli], a
    ld [hl], b
    ld a, [wBattleActor]
    ld hl, wBattleAGL
    call AddDoubleAToHL_Bank36
    ld a, [wBattleTarget]
    call GetBaseAGLOfSlotA
    ld a, c
    ld [hli], a
    ld [hl], b
    ld a, [wBattleTarget]
    call ActionEffect_Transform_BattlerRecordFieldAddress
    ld a, [wBattleActor]
    ld de, wSlotResistances
    ld b, a
    add a
    add b
    add a
    add b
    add e
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
    call ActionEffect_Transform_BattlerRecordFieldAddress_2
    ld a, [wBattleActor]
    ld de, wBattleSkillsPrefix
    swap a
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld c, $00

.loop:
    ld a, [hl]
    cp $ff
    jr z, .loop2
    cp $c8
    jr z, .loop2
    push af
    ld a, [wLinkMode]
    cp $01
    jr z, .restore2
    ld a, [wBattleTarget]
    cp $04
    jr nc, .restore
    pop af
    cp $34
    jr nz, .cp_35
    ld a, $ad
    jr .skip2

.cp_35:
    cp $35
    jr nz, .skip2
    ld a, $ae
    jr .skip2

.restore:
    pop af
    cp $ad
    jr nz, .cp_AE
    ld a, $34
    jr .skip2

.cp_AE:
    cp $ae
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
    xor a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    pop bc
    pop de
    pop hl
    ld a, [wRecordBufferData + $3]
    swap a
    and $0f
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
    cp $08
    jr z, .return

.loop2:
    ld a, $00
    ld [de], a
    inc de
    ld a, $ff
    ld [de], a
    inc de
    inc c
    ld a, c
    cp $08
    jr nz, .loop2

.return:
    ret

; called from ActionEffect_MegaMagic: copies L to wBattleDamageLo; copies H to wBattleDamageHi;
; copies L to wBattleDamageLo; copies H to wBattleDamageHi; also changes HL, BC and A by register
; arithmetic (E-0347)
; why: a helper of ActionEffect_MegaMagic; ActionEffect_MegaMagic: effect routine reached through
; ActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 61 MegaMagic
; (E-0352, E-0126)
ActionEffect_MegaMagic_WriteBattleDamageLoAndBattleDamageHi::
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

; Calls ScaleHLTo40Percent; calls RandomInRange; copies L to wBattleDamageLo; copies H to
; wBattleDamageHi; calls HLToBattleStatus8EntryOfBattleTarget_Bank36; calls
; GetTargetSlotResistancesByte4; calls ScaleDamageByFlagsAtHLAlt; also changes HL, BC and A by
; register arithmetic (E-0347)
; why: part of ActionEffect_MegaMagic_WriteBattleDamageLoAndBattleDamageHi, in a helper of
; ActionEffect_MegaMagic; ActionEffect_MegaMagic: effect routine reached through ActionEffectTable
; (ActionEffectTable, indexed by wBattleActionId) for action(s) 61 MegaMagic (E-0352, E-0126)
ActionEffect_MegaMagic_CallScaleHLTo40Percent::
    call ScaleHLTo40Percent
    call ShiftHLRight2
    ld a, l
    or h
    jr z, .call_hl_to_battle_status8_entry_of_battle
    ld b, h
    ld c, l
    ld a, l
    cpl
    add $01
    ld l, a
    ld a, h
    cpl
    adc $00
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
    and $03
    call ScaleDamageByFlagsAtHLAlt
    ret

; called from ActionEffect_WindBeast: branches on wLinkMode; branches on wBattleActor; calls
; ShiftBCRight1; copies L to wBattleDamageLo; copies H to wBattleDamageHi; calls ScaleHLTo30Percent;
; calls RandomInRange; copies L to wBattleDamageLo; copies H to wBattleDamageHi; calls
; HLToBattleStatus8EntryOfBattleTarget_Bank36; calls ScaleDamageByVacuumResistance; also changes HL,
; BC and A by register arithmetic (E-0347)
; why: a helper of ActionEffect_WindBeast; ActionEffect_WindBeast: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 72
; WindBeast (E-0352, E-0084)
ActionEffect_WindBeast_ShiftBCRight1::
    ld a, [wBattleActor]
    ld hl, wBattleLevel
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    ld b, h
    ld c, l
    ld a, [wLinkMode]
    cp $01
    jr z, .skip
    ld a, [wBattleActor]
    cp $04
    jr c, .skip
    call ShiftBCRight1
    jr .call_compare_hl_to_bc

.skip:
    add hl, bc
    add hl, bc
    ld bc, $000a

.call_compare_hl_to_bc:
    add hl, bc
    ld bc, $00b4
    call CompareHLToBC
    jr c, .set_battle_damage_lo
    ld hl, $00b4

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
    add $01
    ld l, a
    ld a, h
    cpl
    adc $00
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
    call ScaleDamageByVacuumResistance
    ret

; called from ActionEffect_Vacuum: branches on wLinkMode; calls ShiftBCRight1; copies L to
; wBattleDamageLo; copies H to wBattleDamageHi; calls ScaleHLTo40Percent; calls RandomInRange;
; copies L to wBattleDamageLo; copies H to wBattleDamageHi; calls
; HLToBattleStatus8EntryOfBattleTarget_Bank36; calls ScaleDamageByVacuumResistance; also changes HL,
; BC and A by register arithmetic (E-0347)
; why: a helper of ActionEffect_Vacuum; ActionEffect_Vacuum: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 73 Vacuum
; (E-0352, E-0084)
ActionEffect_Vacuum_ShiftBCRight1::
    ld a, [wBattleActor]
    ld hl, wBattleLevel
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    ld a, [wLinkMode]
    cp $01
    jr z, .skip
    cp $04
    jr c, .skip
    ld b, h
    ld c, l
    call ShiftBCRight1
    jr .call_compare_hl_to_bc

.skip:
    add hl, hl
    ld bc, $001e

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
    add $01
    ld l, a
    ld a, h
    cpl
    adc $00
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
    call ScaleDamageByVacuumResistance
    ret

; called from ActionEffect_Lightning: branches on wLinkMode; branches on wBattleActor; calls
; ShiftBCRight1; calls GetTargetSpeciesFamily; copies L to wBattleDamageLo; copies H to
; wBattleDamageHi; calls ScaleHLTo40Percent; calls RandomInRange; copies L to wBattleDamageLo;
; copies H to wBattleDamageHi; calls HLToBattleStatus8EntryOfBattleTarget_Bank36; calls
; ScaleDamageByBoltResistance; then 1 more step (see the code) (E-0347)
; why: a helper of ActionEffect_Lightning; ActionEffect_Lightning: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 74
; Lightning (E-0352, E-0084)
ActionEffect_Lightning_ShiftBCRight1::
    ld a, [wBattleActor]
    ld hl, wBattleLevel
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    ld a, [wLinkMode]
    cp $01
    jr z, .skip
    ld a, [wBattleActor]
    cp $04
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
    cp $09
    jr z, .call_compare_hl_to_bc
    ld bc, $00b4
    jr .call_compare_hl_to_bc2

.call_compare_hl_to_bc:
    ld bc, $00dc

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
    add $01
    ld l, a
    ld a, h
    cpl
    adc $00
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
    call ScaleDamageByBoltResistance
    ret

; called from ActionEffect_MultiCut: copies wBattleActionId to wRecordBuffer; calls LoadSkillRecord;
; branches on wLinkMode; branches on wBattleActor; sets wBattleArg2; calls
; RollDamageBaseToBasePlusBattleArg2; calls GetTargetSpeciesFamily; calls ScaleHLBy21Over16; copies
; L to wBattleDamageLo; copies H to wBattleDamageHi; calls
; HLToBattleStatus8EntryOfBattleTarget_Bank36; calls GetTargetSlotResistancesByte1; then 1 more step
; (see the code) (E-0347)
; why: a helper of ActionEffect_MultiCut; ActionEffect_MultiCut: effect routine reached through
; ActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 102 MultiCut
; (E-0352, E-0126)
ActionEffect_MultiCut_LoadSkillRecord::
    ld a, [wBattleActionId]
    ld [wRecordBuffer], a
    xor a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    ld a, [wLinkMode]
    cp $01
    jr z, .read_record_buffer_data
    ld a, [wBattleActor]
    cp $04
    jr c, .read_record_buffer_data
    ld a, [wRecordBufferData + $d]
    ld l, a
    ld a, [wRecordBufferData + $e]
    ld h, a
    ld a, [wRecordBufferData + $f]
    jr .set_battle_arg2

.read_record_buffer_data:
    ld a, [wRecordBufferData + $9]
    ld l, a
    ld a, [wRecordBufferData + $a]
    ld h, a
    ld a, [wRecordBufferData + $b]

.set_battle_arg2:
    ld [wBattleArg2], a
    call RollDamageBaseToBasePlusBattleArg2
    call GetTargetSpeciesFamily
    cp $07
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
    and $03
    call ScaleDamageByFlagsAtHLAlt
    ret

; scales the skill damage in HL by the target's GigaSlash (byte 6, bits 3-2) resistance level (2
; bits); used by GigaSlash and actions $D2-$D5 (E-0338)
SkillDamageScaledByGigaSlashResistance::
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte6
    rrca
    rrca
    and $03
    call ScaleDamageByFlagsAtHL
    ret

; damage = the target's HP * 8 / 10 + 1 (ScaleHLTo80Percent_Bank36), then ScaleDamageByFlagsAtHL
; with level = bits 1-0 of the target's wSlotResistances byte 3 (E-0118)
DamageEightyPercentOfTargetHPScaled::
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
    and $03
    call ScaleDamageByFlagsAtHL
    ret

; called from ActionEffect_Kamikaze: calls HLToBattleStatus8EntryOfBattleTarget_Bank36; calls
; GetTargetSlotResistancesByte3; calls RollChanceByFlagsAtHL; calls GetBattleHP; copies L to
; wBattleDamageLo; copies H to wBattleDamageHi; branches on H; branches on L; branches on wLinkMode;
; branches on wBattleKind; calls GetBattleHP; copies L to wBattleDamageLo; then 4 more steps (see
; the code) (E-0347)
; why: a helper of ActionEffect_Kamikaze; ActionEffect_Kamikaze: effect routine reached through
; ActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 112 Kamikaze
; (E-0352, E-0126)
ActionEffect_Kamikaze_HLToBattleStatus8EntryOfBattleTarget_Bank36::
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte3
    and $03
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
    or a
    jr nz, .check_link_mode
    ld a, l
    cp $01
    jr z, .set_battle_damage_lo

.check_link_mode:
    ld a, [wLinkMode]
    or a
    jr nz, .read_battle_damage_lo
    ld a, [wBattleKind]
    or a
    jr z, .read_battle_target
    cp $01
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
    or l
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
    xor a
    ret

; called from ActionEffect_Curse: calls HLToBattleStatus8EntryOfBattleTarget_Bank36; calls
; GetTargetSlotResistancesByte5; calls ForceLevel4IfActorConcentrated; calls
; RollChanceByFlagsAtHLSided (E-0347)
; why: a helper of ActionEffect_Curse; ActionEffect_Curse: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 117 Curse
; (E-0352, E-0084)
ActionEffect_Curse_HLToBattleStatus8EntryOfBattleTarget_Bank36::
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte5
    swap a
    and $03
    call ForceLevel4IfActorConcentrated
    cp $04
    jr nz, .call_roll_chance_by_flags_at_hl_sided
    scf
    ret

.call_roll_chance_by_flags_at_hl_sided:
    call RollChanceByFlagsAtHLSided
    ret

; rolls whether the action gets through the target's Beat (byte 2, bits 5-4) resistance (a 2-bit
; level; certain when ForceLevel4IfActorConcentrated gives 4); used by Beat and UltraDown; carry =
; it gets through (E-0095, E-0338)
RollVsBeatResistance::
    call ZIfAllyActorInBattleKindMode2Or3
    jp z, ActionEffect_EerieLite_Done
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte2
    swap a
    and $03
    ld [wBattleArg2], a
    call ForceLevel4IfActorConcentrated
    cp $04
    jr nz, .check_battle_action_id
    scf
    ret

.check_battle_action_id:
    ld a, [wBattleActionId]
    cp SKILL_BEAT
    jr c, .read_battle_arg2
    cp SKILL_DEFEAT
    jr z, .read_battle_arg2
    cp SKILL_KODANCE
    jr z, .read_battle_arg2
    cp SKILL_ULTRADOWN
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

; HL = the target's wBattleStatus8 entry; level = the target's LegSweep resistance (byte 5, bits
; 3-2); for actions $7A, $8E and $90 success is certain when ForceLevel4IfActorConcentrated returns
; 4, else RollChanceByFlagsAtHLSided; other actions use RollChanceByFlagsAtHL; used by Ahhh,
; LegSweep, LureDance, LushLicks and WarCry; carry = success (E-0096, E-0338; was
; RollVsLegSweepResistance)
RollVsLegSweepResistance::
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte5
    rrca
    rrca
    and $03
    ld b, a
    ld a, [wBattleActionId]
    cp SKILL_LUREDANCE
    jr z, .call_force_level4_if_actor_concentrated
    cp SKILL_BIGTRIP
    jr z, .call_force_level4_if_actor_concentrated
    cp SKILL_WARCRY
    jr z, .call_force_level4_if_actor_concentrated
    ld a, b
    call RollChanceByFlagsAtHL
    jr .return

.call_force_level4_if_actor_concentrated:
    ld a, b
    call ForceLevel4IfActorConcentrated
    cp $04
    jr nz, .call_roll_chance_by_flags_at_hl_sided
    scf
    ret

.call_roll_chance_by_flags_at_hl_sided:
    call RollChanceByFlagsAtHLSided

.return:
    ret

; called from ActionEffect_UltraDown: changes HL, BC and A; branches on wBattleStatus1 (E-0347)
; why: a helper of ActionEffect_UltraDown; ActionEffect_UltraDown: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 130
; UltraDown (E-0352, E-0084)
ActionEffect_UltraDown_ReadBattleTarget::
    ld a, [wBattleTarget]
    ld hl, wBattleDEF
    add a
    add_a_to_hl
    ld a, [hli]
    ld b, [hl]
    ld c, a
    dec bc
    ld a, b
    or c
    jr nz, .return_carry
    ld a, [wBattleTarget]
    ld hl, wBattleAGL
    add a
    add_a_to_hl
    ld a, [hli]
    ld b, [hl]
    ld c, a
    dec bc
    ld a, b
    or c
    jr nz, .return_carry
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_BLINDED, [hl]
    jr z, .return_carry
    xor a
    ret

.return_carry:
    scf
    ret

; called from ActionEffect_TatsuCall: sets wBattleSlotOut to 0; copies L to wMonsterId; calls
; LoadMonsterRecord; calls StoreBCAtWordEntryLoadSlot; calls ActionEffect_TatsuCall_ReadLoadSlot;
; calls StoreBCAtWordEntryLoadSlot; calls ActionEffect_TatsuCall_ReadLoadSlot; calls
; SetSlotAIModeFromINT; copies L to wSpeciesIdLo; copies H to wSpeciesIdHi; calls LoadSpeciesRecord;
; copies L to wBattleArg0; then 7 more steps (see the code) (E-0347)
; why: a helper of ActionEffect_TatsuCall; ActionEffect_TatsuCall: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 133
; TatsuCall, 134 ... (E-0352, E-0084)
ActionEffect_TatsuCall_AddAx9ToHL::
    ld a, [wLoadSlot]
    ld hl, wBattleStatus
    call AddAx9ToHL
    xor a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hl], a
    ld a, [wLoadSlot]
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld [hl], $00
    ld a, [wLoadSlot]
    srl a
    srl a
    and $01
    ld hl, wSpecialSlotMonsters
    add a
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
    call ActionEffect_TatsuCall_ReadLoadSlot
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
    ld a, [wRecordBufferData + $a]
    ld c, a
    ld a, [wRecordBufferData + $b]
    ld b, a
    ld hl, wBattleMP
    call StoreBCAtWordEntryLoadSlot
    ld a, [wRecordBufferData + $a]
    ld c, a
    ld a, [wRecordBufferData + $b]
    ld b, a
    ld hl, wBattleMaxMP
    call StoreBCAtWordEntryLoadSlot
    ld a, [wRecordBufferData + $c]
    ld c, a
    ld a, [wRecordBufferData + $d]
    ld b, a
    ld hl, wBattleATK
    call StoreBCAtWordEntryLoadSlot
    ld a, [wRecordBufferData + $e]
    ld c, a
    ld a, [wRecordBufferData + $f]
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
    ld bc, $03e7
    ld hl, wBattleExtraStat
    call StoreBCAtWordEntryLoadSlot
    ld a, [wRecordBufferData + $14]
    ld c, a
    ld hl, wSlotPersonalityHi
    call ActionEffect_TatsuCall_ReadLoadSlot
    ld a, [wRecordBufferData + $15]
    ld c, a
    ld hl, wSlotPersonalityLo
    call ActionEffect_TatsuCall_ReadLoadSlot
    ld a, [wRecordBufferData + $16]
    ld c, a
    ld hl, wSlotPersonalityMid
    call ActionEffect_TatsuCall_ReadLoadSlot
    ld a, [wRecordBufferData + $17]
    ld c, a
    ld hl, wSlotTrait
    call ActionEffect_TatsuCall_ReadLoadSlot
    ld c, $00
    ld hl, wSlotBodyFlags
    call ActionEffect_TatsuCall_ReadLoadSlot
    ld c, $00
    ld hl, wSlotNameSuffix
    call ActionEffect_TatsuCall_ReadLoadSlot
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
    ld hl, wSpeciesRecord + SPECIES_RESISTANCES
    ld a, l
    ld [wBattleArg0], a
    ld a, h
    ld [wBattleArg1], a
    ld a, [wLoadSlot]
    ld c, a
    add a
    add c
    add a
    add c
    ld de, wSlotResistances
    add e
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
    call ActionEffect_TatsuCall_WriteRecordBufferAndBattleArg0Etc
    ret

; May return early; sets wRecordBuffer; sets wBattleArg0 to 3; sets wBattleArg1 to 1; copies L to
; wBattleArg2; copies H to wBattleArg3; calls LoadSkillRecordPart; also changes HL, DE, BC and A by
; register arithmetic (E-0347)
; why: part of ActionEffect_TatsuCall; ActionEffect_TatsuCall: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 133
; TatsuCall, 134 ... (E-0352, E-0084)
ActionEffect_TatsuCall_WriteRecordBufferAndBattleArg0Etc::
    ld b, $04
    ld a, [wLoadSlot]
    ld de, wBattleSkills
    swap a
    add e
    ld e, a
    jr nc, .loop
    inc d

.loop:
    ld a, [hl]
    cp $ff
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
    swap a
    and $0f
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

; Takes HL and C; changes HL and A (E-0347)
; why: part of ActionEffect_TatsuCall; ActionEffect_TatsuCall: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 133
; TatsuCall, 134 ... (E-0352, E-0084)
ActionEffect_TatsuCall_ReadLoadSlot::
    ld a, [wLoadSlot]
    add_a_to_hl
    ld [hl], c
    ret

; HL = table: stores BC (low byte first) at HL + 2 * wLoadSlot (E-0073)
StoreBCAtWordEntryLoadSlot::
    ld a, [wLoadSlot]
    add a
    add_a_to_hl
    ld [hl], c
    inc hl
    ld [hl], b
    ret

; RollVsLegSweepResistance for LegSweep (E-0338)
ActionEffect_LegSweep_RollVsLegSweepResistance::
    ld a, [wBattleTarget]
    ld hl, wSlotBodyFlags
    add_a_to_hl
    bit 4, [hl]
    ret nz
    call RollVsLegSweepResistance
    ret

; called from ActionEffect_DanceShut: calls HLToBattleStatus8EntryOfBattleTarget_Bank36; calls
; GetTargetSlotResistancesByte5; calls ForceLevel4IfActorConcentrated; calls RollChanceByFlagsAtHL
; (E-0347)
; why: a helper of ActionEffect_DanceShut; ActionEffect_DanceShut: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 146
; DanceShut (E-0352, E-0084)
ActionEffect_DanceShut_HLToBattleStatus8EntryOfBattleTarget_Bank36::
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte5
    and $03
    call ForceLevel4IfActorConcentrated
    cp $04
    jr nz, .call_roll_chance_by_flags_at_hl
    scf
    ret

.call_roll_chance_by_flags_at_hl:
    call RollChanceByFlagsAtHL
    ret

; called from ActionEffect_MouthShut: calls HLToBattleStatus8EntryOfBattleTarget_Bank36; calls
; GetTargetSlotResistancesByte6; calls ForceLevel4IfActorConcentrated; calls RollChanceByFlagsAtHL
; (E-0347)
; why: a helper of ActionEffect_MouthShut; ActionEffect_MouthShut: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 147
; MouthShut (E-0352, E-0084)
ActionEffect_MouthShut_HLToBattleStatus8EntryOfBattleTarget_Bank36::
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte6
    rlca
    rlca
    and $03
    call ForceLevel4IfActorConcentrated
    cp $04
    jr nz, .call_roll_chance_by_flags_at_hl
    scf
    ret

.call_roll_chance_by_flags_at_hl:
    call RollChanceByFlagsAtHL
    ret

; called from ActionEffect_CallHelp: branches on wLinkMode; branches on wBattleActor; copies L to
; wBattleDamageLo; copies H to wBattleDamageHi; calls HLToBattleStatus8EntryOfBattleTarget_Bank36;
; calls GetTargetSlotResistancesByte6; calls ScaleDamageByFlagsAtHL; also changes HL, BC and A by
; register arithmetic (E-0347)
; why: a helper of ActionEffect_CallHelp; ActionEffect_CallHelp: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 78
; CallHelp, 79 ... (E-0352, E-0084)
ActionEffect_CallHelp_WriteBattleDamageLoAndBattleDamageHi::
    ld a, [wBattleActor]
    ld hl, wBattleLevel
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    ld a, [wLinkMode]
    cp $01
    jr z, .set_battle_damage_lo
    ld a, [wBattleActor]
    cp $04
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
    and $03
    call ScaleDamageByFlagsAtHL
    ret

; called from ActionEffect_BiAttack: branches on wBattleActionId; calls ShiftBCRight2; calls
; ScaleHLTo75Percent; calls ShiftBCRight1; calls ComputeBasicDamage; copies L to wBattleDamageLo;
; copies H to wBattleDamageHi; also changes HL, BC and A by register arithmetic (E-0347)
; why: a helper of ActionEffect_BiAttack; ActionEffect_BiAttack: effect routine reached through
; ActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 99 BiAttack, 100
; QuadHits (E-0352, E-0126)
ActionEffect_BiAttack_ShiftHLRight1::
    ld a, [wBattleActor]
    ld hl, wBattleATK
    call AddDoubleAToHL_Bank36
    ld a, l
    ld [wBattleTempBuf + $2], a
    ld a, h
    ld [wBattleTempBuf + $3], a
    deref_hl
    push hl
    ld c, l
    ld b, h
    ld a, $1e
    call Multiply8By16
    ld a, [wBattleActionId]
    cp SKILL_BIATTACK
    jr z, .call_scale_hl_to75_percent
    call ShiftHLRight1
    ld b, h
    ld c, l
    call ShiftBCRight2
    add hl, bc
    jr .read_battle_temp_buf

.call_scale_hl_to75_percent:
    call ScaleHLTo75Percent

.read_battle_temp_buf:
    ld a, [wBattleTempBuf + $2]
    ld c, a
    ld a, [wBattleTempBuf + $3]
    ld b, a
    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    ld a, [wBattleTarget]
    ld hl, wBattleDEF
    call AddDoubleAToHL_Bank36
    ld a, [hli]
    ld b, [hl]
    ld c, a
    ld a, $1e
    call Multiply8By16
    ld c, l
    ld b, h
    call ShiftBCRight1
    call ComputeBasicDamage
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    ld a, $1e
    call DivideHLByA
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    pop hl
    ld a, [wBattleTempBuf + $2]
    ld c, a
    ld a, [wBattleTempBuf + $3]
    ld b, a
    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    ret

; called from ActionEffect_Meditate: copies C to wEffectTemp0; copies B to wEffectTemp1; copies L to
; wEffectTemp2; copies H to wEffectTemp3; also changes HL, BC and A by register arithmetic (E-0347)
; why: a helper of ActionEffect_Meditate; ActionEffect_Meditate: effect routine reached through
; ActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 159 Meditate
; (E-0352, E-0126)
ActionEffect_Meditate_AddDoubleAToHL_Bank36::
    ld a, [wBattleActor]
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank36
    ld a, [hli]
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
    ld bc, $01f4
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

; called from ActionEffect_Sacrifice: calls ZIfAllyActorInBattleKindMode2Or3; may continue in
; ActionEffect_EerieLite_Done; calls HLToBattleStatus8EntryOfBattleTarget_Bank36; calls
; GetTargetSlotResistancesByte3; calls ForceLevel4IfActorConcentrated; branches on wBattleActionId;
; calls ActionEffect_Sacrifice_RollChanceByLevel_100_84_50_0; calls RollChanceForLevelA_2 (E-0347)
; why: a helper of ActionEffect_Sacrifice; ActionEffect_Sacrifice: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 21
; Sacrifice (E-0352, E-0084)
ActionEffect_Sacrifice_ZIfAllyActorInBattleKindMode2Or3::
    call ZIfAllyActorInBattleKindMode2Or3
    jp z, ActionEffect_EerieLite_Done
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte3
    and $03
    call ForceLevel4IfActorConcentrated
    cp $04
    jr nz, .check_battle_action_id
    scf
    ret

.check_battle_action_id:
    push af
    ld a, [wBattleActionId]
    cp ACTION_D6
    jr z, .call_roll_chance_for_level_a_2
    pop af
    call ActionEffect_Sacrifice_RollChanceByLevel_100_84_50_0
    ret

.call_roll_chance_for_level_a_2:
    pop af
    call RollChanceForLevelA_2
    ret

; rolls whether the action gets through the target's Sleep (byte 2, bits 7-6) resistance (a 2-bit
; level; certain when ForceLevel4IfActorConcentrated gives 4); used by Sleep and
; ResolveStep0EEffect; carry = it gets through (E-0095, E-0338)
RollVsSleepResistance::
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte2
    rlca
    rlca
    and $03
    ld [wBattleArg2], a
    call ForceLevel4IfActorConcentrated
    cp $04
    jr nz, .check_battle_action_id
    scf
    ret

.check_battle_action_id:
    ld a, [wBattleActionId]
    cp SKILL_SLEEP
    ld a, [wBattleArg2]
    jp z, RollChanceByFlagsAtHL
    jp RollChanceByFlagsAtHLSided

; called from ActionEffect_BeDragon: branches on wBattleActionId; copies L to wMonsterId; calls
; LoadMonsterRecord; calls StoreBCAtActorWordEntry; calls ActionEffect_BeDragon_CompareHLToBC; calls
; StoreBCAtActorWordEntry; calls ActionEffect_BeDragon_CompareHLToBC; calls StoreBCAtActorWordEntry;
; copies L to wSpeciesIdLo; copies H to wSpeciesIdHi; calls LoadSpeciesRecord; calls
; SetSlotAIModeFromINT; then 11 more steps (see the code) (E-0347)
; why: a helper of ActionEffect_BeDragon; ActionEffect_BeDragon: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 59
; BeDragon, $B8 (E-0352, E-0084)
ActionEffect_BeDragon_LoadMonsterRecord::
    ld hl, $0082
    ld a, [wBattleActionId]
    cp ACTION_DC
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
    call ActionEffect_BeDragon_CompareHLToBC
    ld a, [wRecordBufferData + $a]
    ld c, a
    ld a, [wRecordBufferData + $b]
    ld b, a
    ld hl, wBattleMaxMP
    call StoreBCAtActorWordEntry
    ld a, [wBattleActor]
    ld hl, wBattleMP
    call ActionEffect_BeDragon_CompareHLToBC
    ld a, [wRecordBufferData + $c]
    ld c, a
    ld a, [wRecordBufferData + $d]
    ld b, a
    ld hl, wBattleATK
    call StoreBCAtActorWordEntry
    ld a, [wRecordBufferData + $e]
    ld c, a
    ld a, [wRecordBufferData + $f]
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
    ld hl, wSpeciesRecord + SPECIES_RESISTANCES
    ld a, l
    ld [wBattleArg0], a
    ld a, h
    ld [wBattleArg1], a
    ld a, [wBattleActor]
    ld c, a
    add a
    add c
    add a
    add c
    ld de, wSlotResistances
    add e
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
    call ActionEffect_BeDragon_ActionEffect_BeDragon_ClearEntry
    ld a, [wBattleActor]
    ld hl, wSlotBodyFlags
    add_a_to_hl
    ld [hl], $00
    ld a, [wBattleActor]
    call SetBit0OfLevelUpGainsIndexed_Bank36
    ld a, [wBattleActor]
    call SetBit1OfLevelUpGainsIndexed_Bank36
    ret

; Branches on the byte at wTemp0; calls ActionEffect_BeDragon_ClearEntry; copies the byte at wTemp0
; to wRecordBuffer; sets wBattleArg0 to 3; sets wBattleArg1 to 1; copies L to wBattleArg2; copies H
; to wBattleArg3; calls LoadSkillRecordPart; calls ActionEffect_BeDragon_ClearEntry; also changes
; HL, DE, BC and A by register arithmetic (E-0347)
; why: part of ActionEffect_BeDragon; ActionEffect_BeDragon: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 59
; BeDragon, $B8 (E-0352, E-0084)
ActionEffect_BeDragon_ActionEffect_BeDragon_ClearEntry::
    ld hl, wTemp0
    ld b, $04
    ld a, [wBattleActor]
    ld de, wBattleSkills
    swap a
    add e
    ld e, a
    jr nc, .loop
    inc d

.loop:
    ld a, [hl]
    cp $ff
    jr nz, .skip
    call ActionEffect_BeDragon_ClearEntry
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
    swap a
    and $0f
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
    call ActionEffect_BeDragon_ClearEntry
    call ActionEffect_BeDragon_ClearEntry
    call ActionEffect_BeDragon_ClearEntry

; writes $FF at DE and 0 before it, then DE += 3 (E-0305)
ActionEffect_BeDragon_ClearEntry::
    ld a, $ff
    ld [de], a
    dec de
    xor a
    ld [de], a
    inc de
    inc de
    inc de
    ret

; [HL + wBattleActor] = C (E-0115)
StoreCAtActorEntry::
    ld a, [wBattleActor]
    add_a_to_hl
    ld [hl], c
    ret

; HL = table: stores BC (low byte first) at HL + 2 * wBattleActor; HL ends on the high byte (E-0077)
StoreBCAtActorWordEntry::
    ld a, [wBattleActor]
    add a
    add_a_to_hl
    ld [hl], c
    inc hl
    ld [hl], b
    ret

; sets the actor's ATK word to 200 ($00C8), runs ComputeAttackDamage, then restores the old ATK
; (E-0120)
AttackDamageWithATK200::
    ld a, [wBattleActor]
    ld hl, wBattleATK
    call AddDoubleAToHL_Bank36
    push hl
    ld a, [hli]
    ld b, [hl]
    ld c, a
    push bc
    ld a, $00
    ld [hld], a
    ld [hl], $c8
    call ComputeAttackDamage
    pop bc
    pop hl
    ld a, c
    ld [hli], a
    ld [hl], b
    ret

; called from ActionEffect_Watershot: calls RollSkillDamageFromRecord; calls
; GetTargetSlotResistancesByte0; branches on wBattleActionId; calls ScaleDamageByFlagsAtHLAlt; calls
; ScaleDamageByFlagsAtHL (E-0347)
; why: a helper of ActionEffect_Watershot; ActionEffect_Watershot: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 76
; Watershot, 77 ... (E-0352, E-0084)
ActionEffect_Watershot_RollSkillDamageFromRecord::
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte0
    swap a
    rrca
    rrca
    and $03
    ld b, a
    ld a, [wBattleActionId]
    cp SKILL_WATERSHOT
    ld a, b
    jr z, .call_scale_damage_by_flags_at_hl
    call ScaleDamageByFlagsAtHLAlt
    ret

.call_scale_damage_by_flags_at_hl:
    call ScaleDamageByFlagsAtHL
    ret

; rolls whether the action gets through the target's PoisonGas (byte 4, bits 1-0) resistance (a
; 2-bit level; certain when ForceLevel4IfActorConcentrated gives 4); used by PoisonGas,
; InflictStatus0Bit0WithBattleWordArray3FReduction and ResolveStep0EEffect; carry = it gets through
; (E-0095, E-0338) (sided roll)
RollVsPoisonGasResistance::
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte4
    and $03
    call ForceLevel4IfActorConcentrated
    cp $04
    jr nz, .call_roll_chance_by_flags_at_hl_sided
    scf
    ret

.call_roll_chance_by_flags_at_hl_sided:
    call RollChanceByFlagsAtHLSided
    ld e, $00
    ret c
    ld e, $01
    ret

; rolls whether the action gets through the target's PalsyAir (byte 5, bits 7-6) resistance (a 2-bit
; level; certain when ForceLevel4IfActorConcentrated gives 4); used by PalsyAir and
; ResolveStep0EEffect; carry = it gets through (E-0095, E-0338) (sided roll)
RollVsPalsyAirResistance::
    call ZIfAllyActorInBattleKindMode2Or3
    jp z, ActionEffect_EerieLite_Done
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte5
    rlca
    rlca
    and $03
    call ForceLevel4IfActorConcentrated
    cp $04
    jr nz, .call_roll_chance_by_flags_at_hl_sided
    scf
    ret

.call_roll_chance_by_flags_at_hl_sided:
    call RollChanceByFlagsAtHLSided
    ld e, $00
    ret c
    ld e, $01
    ret

; RollVsSleepResistance for resolve step $0E (E-0338)
ResolveStep0EEffect_RollVsSleepResistance::
    call RollVsSleepResistance
    ld e, $00
    ret c
    ld e, $01
    ret

; called from ActionEffect_Geyser: calls HLToBattleStatus8EntryOfBattleTarget_Bank36; calls
; GetTargetSlotResistancesByte0; calls RollChanceByFlagsAtHL (E-0347)
; why: a helper of ActionEffect_Geyser; ActionEffect_Geyser: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 145 Geyser
; (E-0352, E-0084)
ActionEffect_Geyser_HLToBattleStatus8EntryOfBattleTarget_Bank36::
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte0
    swap a
    rrca
    rrca
    and $03
    call RollChanceByFlagsAtHL
    ret

; called from ActionEffect_EerieLite: calls HLToBattleStatus8EntryOfBattleTarget_Bank36; calls
; GetTargetSlotResistancesByte2; calls ForceLevel4IfActorConcentrated; calls RollChanceByFlagsAtHL
; (E-0347)
; why: a helper of ActionEffect_EerieLite; ActionEffect_EerieLite: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 128
; EerieLite (E-0352, E-0084)
ActionEffect_EerieLite_HLToBattleStatus8EntryOfBattleTarget_Bank36::
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte2
    swap a
    and $03
    call ForceLevel4IfActorConcentrated
    cp $04
    jr nz, .call_roll_chance_by_flags_at_hl
    scf
    ret

.call_roll_chance_by_flags_at_hl:
    call RollChanceByFlagsAtHL
    ret

; Takes A; changes A and E (E-0347)
; why: part of ActionEffect_EerieLite_HLToBattleStatus8EntryOfBattleTarget_Bank36, in a helper of
; ActionEffect_EerieLite; ActionEffect_EerieLite: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 128
; EerieLite (E-0352, E-0084)
ActionEffect_EerieLite_Done::
    xor a
    ld e, $01
    ret

; A = 0 and Z when wBattleKind is 2 or 3 and the actor is an ally (slot < 4); otherwise A = 1 and NZ
; (E-0122)
ZIfAllyActorInBattleKindMode2Or3::
    ld a, [wBattleKind]
    cp $02
    jr z, .check_battle_actor
    cp $03
    jr nz, .done

.check_battle_actor:
    ld a, [wBattleActor]
    cp $04
    jr nc, .done
    xor a
    ret

.done:
    ld a, $01
    or a
    ret

; picks a base and spread from the loaded skill record: wRecordBufferData + $D/wRecordBufferData +
; $E and wRecordBufferData + $F for actors in slots 4-7 when wLinkMode is not 1, otherwise
; wRecordBufferData + $9/wRecordBufferData + $A and wRecordBufferData + $B; the spread goes to
; wBattleArg2 and RollDamageBaseToBasePlusBattleArg2 sets the damage word; then falls into
; HLToWD814EntryOfWD8A5_Bank36 (E-0095)
RollSkillDamageFromRecord::
    ld a, [wLinkMode]
    cp $01
    jr z, .read_record_buffer_data
    ld a, [wBattleActor]
    bit 2, a
    jr z, .read_record_buffer_data
    ld a, [wRecordBufferData + $d]
    ld l, a
    ld a, [wRecordBufferData + $e]
    ld h, a
    ld a, [wRecordBufferData + $f]
    jr .set_battle_arg2

.read_record_buffer_data:
    ld a, [wRecordBufferData + $9]
    ld l, a
    ld a, [wRecordBufferData + $a]
    ld h, a
    ld a, [wRecordBufferData + $b]

.set_battle_arg2:
    ld [wBattleArg2], a
    call RollDamageBaseToBasePlusBattleArg2

; HL = wBattleStatus8 + 9 * wBattleTarget (AddAx9ToHL); A is clobbered (E-0353: corrected; was: HL =
; wBattleStatus8 + 9 * [wBattleTarget] (AddAx9ToHL); A = [wBattleTarget]) (the same 10 bytes appear
; in 2 banks)
HLToBattleStatus8EntryOfBattleTarget_Bank36::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus8
    call AddAx9ToHL
    ret

; HL = base: wBattleDamageLo/wBattleDamageHi = RandomInRange(HL, HL + wBattleArg2); HL kept (E-0095)
RollDamageBaseToBasePlusBattleArg2::
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

; A = byte 0 of the target's 7-byte resistance record (wSlotResistances + 0 + 7 * wBattleTarget); DE
; points at it; its four 2-bit fields are in wSlotResistances's note (E-0095, E-0338)
GetTargetSlotResistancesByte0::
    ld de, wSlotResistances
    jr GetTargetResistanceByte

; A = byte 1 of the target's 7-byte resistance record (wSlotResistances + 1 + 7 * wBattleTarget); DE
; points at it; its four 2-bit fields are in wSlotResistances's note (E-0095, E-0338)
GetTargetSlotResistancesByte1::
    ld de, wSlotResistances + $1
    jr GetTargetResistanceByte

; A = byte 2 of the target's 7-byte resistance record (wSlotResistances + 2 + 7 * wBattleTarget); DE
; points at it; its four 2-bit fields are in wSlotResistances's note (E-0095, E-0338)
GetTargetSlotResistancesByte2::
    ld de, wSlotResistances + $2
    jr GetTargetResistanceByte

; A = byte 3 of the target's 7-byte resistance record (wSlotResistances + 3 + 7 * wBattleTarget); DE
; points at it; its four 2-bit fields are in wSlotResistances's note (E-0095, E-0338)
GetTargetSlotResistancesByte3::
    ld de, wSlotResistances + $3
    jr GetTargetResistanceByte

; A = byte 4 of the target's 7-byte resistance record (wSlotResistances + 4 + 7 * wBattleTarget); DE
; points at it; its four 2-bit fields are in wSlotResistances's note (E-0095, E-0338)
GetTargetSlotResistancesByte4::
    ld de, wSlotResistances + $4
    jr GetTargetResistanceByte

; A = byte 5 of the target's 7-byte resistance record (wSlotResistances + 5 + 7 * wBattleTarget); DE
; points at it; its four 2-bit fields are in wSlotResistances's note (E-0095, E-0338)
GetTargetSlotResistancesByte5::
    ld de, wSlotResistances + $5
    jr GetTargetResistanceByte

; A = byte 6 of the target's 7-byte resistance record (wSlotResistances + 6 + 7 * wBattleTarget); DE
; points at it; its four 2-bit fields are in wSlotResistances's note (E-0095, E-0338)
GetTargetSlotResistancesByte6::
    ld de, wSlotResistances + $6

; A = the byte at DE + 7 * wBattleTarget: byte DE - wSlotResistances of the target's resistance
; record (GetTargetSlotResistancesByte0-6 load DE); DE points at it (E-0095, E-0338)
GetTargetResistanceByte::
    ld a, [wBattleTarget]
    ld b, a
    add a
    add b
    add a
    add b
    add e
    ld e, a
    jr nc, .done
    inc d

.done:
    ld a, [de]
    ret

; picks the chance table by the flags at [HL]: bit 6 set uses RollChanceByLevel_100_75_40_0, else
; bit 7 set uses RollChanceByLevel_100_100_75_0, else RollChanceByLevel_100_84_50_0 (A = level)
; (E-0095)
RollChanceByFlagsAtHL::
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

; Calls RollChanceByLevel_100_84_50_0; calls RollChanceByLevel_100_100_75_0 (E-0347)
; why: part of ActionEffect_Sacrifice; ActionEffect_Sacrifice: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 21
; Sacrifice (E-0352, E-0084)
ActionEffect_Sacrifice_RollChanceByLevel_100_84_50_0::
    bit 6, [hl]
    jr z, .call_roll_chance_by_level_100_100_75_0
    call RollChanceByLevel_100_84_50_0
    jr .return

.call_roll_chance_by_level_100_100_75_0:
    call RollChanceByLevel_100_100_75_0

.return:
    ret

; bit 6 of [HL]: RollChanceByLevelAndSide; else bit 7: RollChanceByLevel_100_100_75_0; else
; RollChanceByLevel_100_75_40_0 (E-0122)
RollChanceByHLBits6And7::
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

; bit 7 of [HL] set uses RollChanceByLevel_100_84_50_0, otherwise RollChanceByLevelAndSide (A =
; level) (E-0095)
RollChanceByFlagsAtHLSided::
    bit 7, [hl]
    jr z, .call_roll_chance_by_level_and_side
    call RollChanceByLevel_100_84_50_0
    jr .return

.call_roll_chance_by_level_and_side:
    call RollChanceByLevelAndSide

.return:
    ret

; bit 6 of [HL] set uses ScaleDamageByLevel_1_075_04_0, else bit 7 set uses
; ScaleDamageByLevel_131_116_075_03, else ScaleDamageByLevel_1_085_05_0 (A = level) (E-0095)
ScaleDamageByFlagsAtHL::
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

; bit 6 of [HL] set uses ScaleDamageByLevel_075_05_025_0, else bit 7 set uses
; ScaleDamageByLevel_131_116_075_03, else ScaleDamageByLevel_1_075_04_0 (A = level) (E-0096)
ScaleDamageByFlagsAtHLAlt::
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

; bit 6 of [HL] set uses ScaleDamageByLevel_1_085_05_0, otherwise ScaleDamageByLevel_131_116_075_03
; (A = level) (E-0096)
ScaleDamageByFlagsAtHLBit6::
    bit 6, [hl]
    jr z, .call_scale_damage_by_level_131_116_075_03
    call ScaleDamageByLevel_1_085_05_0
    jr .return

.call_scale_damage_by_level_131_116_075_03:
    call ScaleDamageByLevel_131_116_075_03

.return:
    ret

; bit 7 of [HL]: ScaleDamageByLevel_1_085_05_0, else ScaleDamageByLevel_075_05_025_0 (E-0122)
ScaleDamageByLevelByHLBit7::
    bit 7, [hl]
    jr z, .call_scale_damage_by_level_075_05_025_0
    call ScaleDamageByLevel_1_085_05_0
    jr .return

.call_scale_damage_by_level_075_05_025_0:
    call ScaleDamageByLevel_075_05_025_0

.return:
    ret

; bit 6 of [HL]: RollChanceByLevel_100_75_40_0; else bit 7: RollChanceForLevelA_2; else
; RollChanceForLevelA (E-0122) (E-0344: the address in its name dropped or read as the label there;
; was RollChanceByHLBits6And7_2)
RollChanceByHLBits6And7_2::
    bit 6, [hl]
    jr z, .skip
    call RollChanceByLevel_100_75_40_0
    jr .return

.skip:
    bit 7, [hl]
    jr z, .call_roll_chance_for_level_a
    call RollChanceForLevelA_2
    jr .return

.call_roll_chance_for_level_a:
    call RollChanceForLevelA

.return:
    ret

; A = level 0-3: success always for 0, when wRandomLo < $D8 (216/256) for 1, < $7F (127/256) for 2,
; never for 3; carry set = success; each roll is AdvanceRandom then wRandomLo compared with a
; threshold (E-0095)
RollChanceByLevel_100_84_50_0::
    and a
    jr nz, .cp_01
    scf
    ret

.cp_01:
    cp $01
    jr nz, .cp_02
    jp RollChanceForLevelA_2_CallAdvanceRandom

.cp_02:
    cp $02
    jr nz, .done
    jp RollChanceForLevelA_2_CallAdvanceRandom3

.done:
    scf
    ccf
    ret

; A = level 0-3: success always for 0 and 1, when wRandomLo < $BF (191/256) for 2, never for 3;
; carry set = success; each roll is AdvanceRandom then wRandomLo compared with a threshold (E-0095)
RollChanceByLevel_100_100_75_0::
    cp $02
    jr nc, .skip
    ret

.skip:
    jr nz, .done
    jp RollChanceForLevelA_2_CallAdvanceRandom2

.done:
    scf
    ccf
    ret

; A = level 0-3: success always for 0, when wRandomLo < $BF for 1, < $66 (102/256) for 2, never for
; 3; carry set = success; each roll is AdvanceRandom then wRandomLo compared with a threshold
; (E-0095)
RollChanceByLevel_100_75_40_0::
    and a
    jr nz, .cp_01
    scf
    ret

.cp_01:
    cp $01
    jr nz, .cp_02
    jp RollChanceForLevelA_2_CallAdvanceRandom2

.cp_02:
    cp $02
    jr nz, .done
    jp RollChanceForLevelA_2_CallAdvanceRandom4

.done:
    scf
    ccf
    ret

; A = level 0-3: for a target in slots 0-3 (unless wLinkMode = 1) success when wRandomLo < $7F, $4C,
; $26 for levels 0-2 (about 50%, 30%, 15%); otherwise < $BF, $7F, $3F (about 75%, 50%, 25%); never
; for level 3; carry set = success; each roll is AdvanceRandom then wRandomLo compared with a
; threshold (E-0095)
RollChanceByLevelAndSide::
    push af
    ld a, [wLinkMode]
    cp $01
    jr z, .restore
    ld a, [wBattleTarget]
    cp $04
    jr nc, .restore
    pop af
    jp RollChanceForLevelA_2_Skip

.restore:
    pop af
    and a
    jr nz, .cp_01
    jp RollChanceForLevelA_2_CallAdvanceRandom2

.cp_01:
    cp $01
    jr nz, .cp_02
    jp RollChanceForLevelA_2_CallAdvanceRandom3

.cp_02:
    cp $02
    jr nz, .done
    jp RollChanceForLevelA_2_CallAdvanceRandom6

.done:
    scf
    ccf
    ret

; A = level 0-3: scales the damage word wBattleDamageLo/wBattleDamageHi by 1 (unchanged), 85/100,
; 1/2 or 0 (E-0095)
ScaleDamageByLevel_1_085_05_0::
    and a
    ret z
    cp $01
    jr nz, .cp_02
    jp RollChanceForLevelA_2_ReadBattleDamageLo3

.cp_02:
    cp $02
    jr nz, .skip
    jp RollChanceForLevelA_2_ReadBattleDamageLo5

.skip:
    jp ScaleDamageTo40Percent_ClearBattleDamageLo

; A = level 0-3: scales the damage word wBattleDamageLo/wBattleDamageHi by 1 (unchanged), 3/4, 0.4
; or 0 (E-0095)
ScaleDamageByLevel_1_075_04_0::
    and a
    ret z
    cp $01
    jr nz, .cp_02
    jp RollChanceForLevelA_2_ReadBattleDamageLo4

.cp_02:
    cp $02
    jr nz, .skip
    jp ScaleDamageTo40Percent

.skip:
    jp ScaleDamageTo40Percent_ClearBattleDamageLo

; A = level 0-3: scales the damage word wBattleDamageLo/wBattleDamageHi by 21/16, 37/32, 3/4 or 0.3
; (E-0095)
ScaleDamageByLevel_131_116_075_03::
    and a
    jr nz, .cp_01
    jp RollChanceForLevelA_2_ReadBattleDamageLo

.cp_01:
    cp $01
    jr nz, .cp_02
    jp RollChanceForLevelA_2_ReadBattleDamageLo2

.cp_02:
    cp $02
    jr nz, .skip
    jp RollChanceForLevelA_2_ReadBattleDamageLo4

.skip:
    jp ScaleDamageTo40Percent_ReadBattleDamageLo

; A = level 0-3: scales the damage word wBattleDamageLo/wBattleDamageHi by 3/4, 1/2, 1/4 or 0
; (E-0095)
ScaleDamageByLevel_075_05_025_0::
    and a
    jr nz, .cp_01
    jp RollChanceForLevelA_2_ReadBattleDamageLo4

.cp_01:
    cp $01
    jr nz, .cp_02
    jp RollChanceForLevelA_2_ReadBattleDamageLo5

.cp_02:
    cp $02
    jr nz, .skip
    jp ScaleDamageTo40Percent_ReadBattleDamageLo2

.skip:
    jp ScaleDamageTo40Percent_ClearBattleDamageLo

; level A: 0 returns carry; 1, 2 and 3 take three different chance rolls (E-0122) (E-0344: the
; address in its name dropped or read as the label there; was RollChanceForLevelA)
RollChanceForLevelA::
    and a
    jr nz, .cp_01
    scf
    ret

.cp_01:
    cp $01
    jr nz, .cp_02
    jp RollChanceForLevelA_2_CallAdvanceRandom2

.cp_02:
    cp $02
    jr nz, .skip
    jp RollChanceForLevelA_2_CallAdvanceRandom3

.skip:
    jp RollChanceForLevelA_2_CallAdvanceRandom6

; level A: 0 and 1 return, 2 and 3 take chance rolls; the following entries roll random values
; against $D8, $BF, $7F, $66, $4C, $3F and $26 (E-0130) (E-0344: the address in its name dropped or
; read as the label there; was RollChanceForLevelA_2)
RollChanceForLevelA_2::
    cp $02
    jr nc, .skip
    ret

.skip:
    jr nz, .skip2
    jp RollChanceForLevelA_2_CallAdvanceRandom2

.skip2:
    jp RollChanceForLevelA_2_CallAdvanceRandom4

; Takes A; changes A; continues in RollChanceForLevelA_2_CallAdvanceRandom3; continues in
; RollChanceForLevelA_2_CallAdvanceRandom5; continues in RollChanceForLevelA_2_CallAdvanceRandom7
; (E-0347)
; why: part of RollChanceForLevelA_2; RollChanceForLevelA_2: level A: 0 and 1 return, 2 and 3 take
; chance rolls (E-0352, E-0130, E-0344)
RollChanceForLevelA_2_Skip::
    and a
    jr nz, .cp_01
    jp RollChanceForLevelA_2_CallAdvanceRandom3

.cp_01:
    cp $01
    jr nz, .cp_02
    jp RollChanceForLevelA_2_CallAdvanceRandom5

.cp_02:
    cp $02
    jr nz, .done
    jp RollChanceForLevelA_2_CallAdvanceRandom7

.done:
    scf
    ccf
    ret

; Calls AdvanceRandom (E-0347)
; why: part of RollChanceForLevelA_2; RollChanceForLevelA_2: level A: 0 and 1 return, 2 and 3 take
; chance rolls (E-0352, E-0130, E-0344)
RollChanceForLevelA_2_CallAdvanceRandom::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $d8
    ret

; Calls AdvanceRandom (E-0347)
; why: part of RollChanceForLevelA_2; RollChanceForLevelA_2: level A: 0 and 1 return, 2 and 3 take
; chance rolls (E-0352, E-0130, E-0344)
RollChanceForLevelA_2_CallAdvanceRandom2::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $bf
    ret

; Calls AdvanceRandom (E-0347)
; why: part of RollChanceForLevelA_2; RollChanceForLevelA_2: level A: 0 and 1 return, 2 and 3 take
; chance rolls (E-0352, E-0130, E-0344)
RollChanceForLevelA_2_CallAdvanceRandom3::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $7f
    ret

; Calls AdvanceRandom (E-0347)
; why: part of RollChanceForLevelA_2; RollChanceForLevelA_2: level A: 0 and 1 return, 2 and 3 take
; chance rolls (E-0352, E-0130, E-0344)
RollChanceForLevelA_2_CallAdvanceRandom4::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $66
    ret

; Calls AdvanceRandom (E-0347)
; why: part of RollChanceForLevelA_2; RollChanceForLevelA_2: level A: 0 and 1 return, 2 and 3 take
; chance rolls (E-0352, E-0130, E-0344)
RollChanceForLevelA_2_CallAdvanceRandom5::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $4c
    ret

; Calls AdvanceRandom (E-0347)
; why: part of RollChanceForLevelA_2; RollChanceForLevelA_2: level A: 0 and 1 return, 2 and 3 take
; chance rolls (E-0352, E-0130, E-0344)
RollChanceForLevelA_2_CallAdvanceRandom6::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $3f
    ret

; Calls AdvanceRandom (E-0347)
; why: part of RollChanceForLevelA_2; RollChanceForLevelA_2: level A: 0 and 1 return, 2 and 3 take
; chance rolls (E-0352, E-0130, E-0344)
RollChanceForLevelA_2_CallAdvanceRandom7::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $26
    ret

; Calls ScaleHLBy21Over16; copies L to wBattleDamageLo; copies H to wBattleDamageHi (E-0347)
; why: part of RollChanceForLevelA_2; RollChanceForLevelA_2: level A: 0 and 1 return, 2 and 3 take
; chance rolls (E-0352, E-0130, E-0344)
RollChanceForLevelA_2_ReadBattleDamageLo::
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

; Calls ScaleHLBy37Over32; copies L to wBattleDamageLo; copies H to wBattleDamageHi (E-0347)
; why: part of RollChanceForLevelA_2; RollChanceForLevelA_2: level A: 0 and 1 return, 2 and 3 take
; chance rolls (E-0352, E-0130, E-0344)
RollChanceForLevelA_2_ReadBattleDamageLo2::
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

; Calls ScaleHLTo85Percent; copies L to wBattleDamageLo; copies H to wBattleDamageHi (E-0347)
; why: part of RollChanceForLevelA_2; RollChanceForLevelA_2: level A: 0 and 1 return, 2 and 3 take
; chance rolls (E-0352, E-0130, E-0344)
RollChanceForLevelA_2_ReadBattleDamageLo3::
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

; Calls ScaleHLTo75Percent; copies L to wBattleDamageLo; copies H to wBattleDamageHi (E-0347)
; why: part of RollChanceForLevelA_2; RollChanceForLevelA_2: level A: 0 and 1 return, 2 and 3 take
; chance rolls (E-0352, E-0130, E-0344)
RollChanceForLevelA_2_ReadBattleDamageLo4::
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

; Copies L to wBattleDamageLo; copies H to wBattleDamageHi (E-0347)
; why: part of RollChanceForLevelA_2; RollChanceForLevelA_2: level A: 0 and 1 return, 2 and 3 take
; chance rolls (E-0352, E-0130, E-0344)
RollChanceForLevelA_2_ReadBattleDamageLo5::
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
ScaleDamageTo40Percent::
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

; Calls ScaleHLTo30Percent; copies L to wBattleDamageLo; copies H to wBattleDamageHi (E-0347)
; why: part of ScaleDamageTo40Percent; ScaleDamageTo40Percent: damage = 40 percent (E-0352, E-0125)
ScaleDamageTo40Percent_ReadBattleDamageLo::
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

; Copies L to wBattleDamageLo; copies H to wBattleDamageHi (E-0347)
; why: part of ScaleDamageTo40Percent; ScaleDamageTo40Percent: damage = 40 percent (E-0352, E-0125)
ScaleDamageTo40Percent_ReadBattleDamageLo2::
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

; Sets wBattleDamageLo to 0; sets wBattleDamageHi to 0 (E-0347)
; why: part of ScaleDamageTo40Percent; ScaleDamageTo40Percent: damage = 40 percent (E-0352, E-0125)
ScaleDamageTo40Percent_ClearBattleDamageLo::
    xor a
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a
    ret

; the damage word = ScaleHLBy3Over2 of itself (x 1.5) (E-0118)
ScaleDamageBy3Over2::
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
ScaleHLBy3Over2::
    ld b, h
    ld c, l
    call ShiftHLRight1
    add hl, bc
    ret

; HL += HL / 4 + HL / 16 (each shift rounds down); BC = HL / 16 (E-0095)
ScaleHLBy21Over16::
    ld b, h
    ld c, l
    call ShiftBCRight2
    add hl, bc
    call ShiftBCRight2
    add hl, bc
    ret

; HL += HL / 8 + HL / 32 (each shift rounds down) (E-0095)
ScaleHLBy37Over32::
    ld b, h
    ld c, l
    call ShiftBCRight3
    add hl, bc
    call ShiftBCRight2
    add hl, bc
    ret

; HL = HL/2 + HL/4 + HL/8 + HL/32 (each rounded down) (E-0118)
ScaleHLBy29Over32::
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
ScaleHLTo85Percent::
    push de
    ld b, h
    ld c, l
    ld a, $55
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    pop de
    ret

; HL = HL * 8 / 10 (24-bit intermediate; Multiply8By16 then Divide24ByA), A = the remainder; DE kept
; (E-0067) (the same 15 bytes appear in 2 banks)
ScaleHLTo80Percent_Bank36::
    push de
    ld b, h
    ld c, l
    ld a, $08
    call Multiply8By16
    ld a, $0a
    call Divide24ByA
    pop de
    ret

; HL = HL / 2 + HL / 4; BC kept (E-0095)
ScaleHLTo75Percent::
    push bc
    call ShiftHLRight1
    ld b, h
    ld c, l
    call ShiftBCRight1
    add hl, bc
    pop bc
    ret

; HL = HL * 6 / 10 (24-bit intermediate); DE kept (E-0095)
ScaleHLTo60Percent::
    push de
    ld b, h
    ld c, l
    ld a, $06
    call Multiply8By16
    ld a, $0a
    call Divide24ByA
    pop de
    ret

; HL = (HL * 8 / 10) / 2 (E-0095)
ScaleHLTo40Percent::
    call ScaleHLTo80Percent_Bank36
    call ShiftHLRight1
    ret

; HL = (HL * 6 / 10) / 2 (E-0095)
ScaleHLTo30Percent::
    call ScaleHLTo60Percent
    call ShiftHLRight1
    ret

; HL = HL / 3 (DivideHLByBC with BC = 3) (E-0095)
DivideHLBy3::
    ld bc, $0003
    call DivideHLByBC
    ret

; called from ActionEffect_Geyser: calls ScaleHLTo60Percent (E-0347)
; why: a helper of ActionEffect_Geyser; ActionEffect_Geyser: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 145 Geyser
; (E-0352, E-0084)
ActionEffect_Geyser_ScaleHLTo60Percent::
    call ScaleHLTo60Percent
    call ShiftHLRight1
    call ShiftHLRight1
    ret

; called from ActionEffect_Geyser: calls ScaleHLTo80Percent_Bank36 (E-0347)
; why: a helper of ActionEffect_Geyser; ActionEffect_Geyser: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 145 Geyser
; (E-0352, E-0084)
ActionEffect_Geyser_ScaleHLTo80Percent_Bank36::
    call ScaleHLTo80Percent_Bank36
    call ShiftHLRight1
    call ShiftHLRight1
    call ShiftHLRight1
    call ShiftHLRight1
    ret

; HL = table, A = index: HL = the word at HL + 2 * A (AddDoubleAToHL_Bank36) (E-0115)
ReadWordTableEntry_Bank36::
    call AddDoubleAToHL_Bank36
    deref_hl
    ret

; BC >>= 3 (falls through ShiftBCRight2) (E-0095)
ShiftBCRight3::
    srl b
    rr c

; BC >>= 2 (falls through ShiftBCRight1) (E-0095)
ShiftBCRight2::
    srl b
    rr c

; BC >>= 1 (unsigned) (E-0064)
ShiftBCRight1::
    srl b
    rr c
    ret

; HL >>= 4 (unsigned): two shifts, then falls through ShiftHLRight2 (E-0064)
ShiftHLRight4::
    srl h
    rr l
    srl h
    rr l

; HL >>= 2 (unsigned): one shift, then falls through ShiftHLRight1 (E-0064)
ShiftHLRight2::
    srl h
    rr l

; HL >>= 1 (unsigned) (E-0064)
ShiftHLRight1::
    srl h
    rr l
    ret

; slot A: carry when its DEF is below 999 and below 2x (4x for foes outside link battles... allies)
; its base DEF; NC otherwise (E-0124)
SlotDEFBelowBuffCap::
    ld [wBattleArg0], a
    call GetBattleDEF
    ld bc, $03e7
    call CompareHLToBC
    jr nc, SlotDEFBelowBuffCap_Skip3
    push hl
    ld a, [wBattleArg0]
    call GetBaseDEFOfSlotA
    ld a, [wLinkMode]
    cp $01
    jr z, SlotDEFBelowBuffCap_Skip
    ld a, [wBattleArg0]
    cp $04
    jr nc, SlotDEFBelowBuffCap_Skip2

; Takes BC; changes BC (E-0347)
; why: part of SlotDEFBelowBuffCap; SlotDEFBelowBuffCap: slot A: carry when its DEF is below 999 and
; below 2x (4x for foes outside link battles... allies) its base DEF (E-0352, E-0124)
SlotDEFBelowBuffCap_Skip::
    sla c
    rl b

; Takes BC; changes HL and BC; may continue in SlotDEFBelowBuffCap_Skip3 (E-0347)
; why: part of SlotDEFBelowBuffCap; SlotDEFBelowBuffCap: slot A: carry when its DEF is below 999 and
; below 2x (4x for foes outside link battles... allies) its base DEF (E-0352, E-0124)
SlotDEFBelowBuffCap_Skip2::
    sla c
    rl b
    pop hl
    call CompareHLToBC
    jr nc, SlotDEFBelowBuffCap_Skip3

; Works on registers only (E-0347)
; why: part of SlotDEFBelowBuffCap; SlotDEFBelowBuffCap: slot A: carry when its DEF is below 999 and
; below 2x (4x for foes outside link battles... allies) its base DEF (E-0352, E-0124)
SlotDEFBelowBuffCap_Loop::
    scf
    ret

; Takes A; changes A; may continue in SlotDEFBelowBuffCap_Loop (E-0347)
; why: part of SlotDEFBelowBuffCap; SlotDEFBelowBuffCap: slot A: carry when its DEF is below 999 and
; below 2x (4x for foes outside link battles... allies) its base DEF (E-0352, E-0124)
SlotDEFBelowBuffCap_Skip3::
    jr z, SlotDEFBelowBuffCap_Loop
    xor a
    ret

; slot A: carry when its AGL is below 999 and below 2x (4x for allies or link battles) its base AGL
; (E-0125)
SlotAGLBelowBuffCap::
    ld [wBattleArg0], a
    ld hl, wBattleAGL
    call ReadWordTableEntry_Bank36
    ld bc, $03e7
    call CompareHLToBC
    jr z, .skip2
    jr nc, .skip2
    push hl
    ld a, [wBattleArg0]
    call GetBaseAGLOfSlotA
    ld a, [wLinkMode]
    cp $01
    jr z, SlotDEFBelowBuffCap_Skip
    ld a, [wBattleArg0]
    cp $04
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
    xor a
    ret

; loads the species record of wBattleTarget's monster id (TargetMonsterIdAddress,
; LoadSpeciesRecord); A = its family (E-0069)
GetTargetSpeciesFamily::
    call TargetMonsterIdAddress
    ld a, [hli]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesRecord]
    ret

; HL = wBattleMonsterId + 2 * wBattleTarget, the target's monster id word (E-0069)
TargetMonsterIdAddress::
    ld a, [wBattleTarget]
    add a
    ld hl, wBattleMonsterId
    add_a_to_hl
    ret

; A = level: returns A unchanged when it is 3; otherwise 4 when the actor has its concentrate act
; (wPersonalityActs bit 2), else A unchanged; BC, HL kept (E-0096, E-0337; was
; ForceLevel4IfActorConcentrated)
ForceLevel4IfActorConcentrated::
    cp $03
    ret z
    push bc
    push hl
    ld b, a
    ld a, [wBattleActor]
    ld hl, wPersonalityActs
    add a
    add_a_to_hl
    ld a, [hl]
    and $04
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

; Calls GetBattleMP; calls GetBattleMaxMP; also changes HL, BC and A by register arithmetic (E-0347)
; why: part of ActionEffect_RobMagic; ActionEffect_RobMagic: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 50
; RobMagic, 119 ... (E-0352, E-0084)
ActionEffect_RobMagic_GetBattleMP::
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

; Calls GetBaseHP; also changes HL, BC and A by register arithmetic (E-0347)
; why: part of ActionEffect_Transform; ActionEffect_Transform: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 58
; Transform (E-0352, E-0084)
ActionEffect_Transform_GetBaseHP::
    push hl
    ld c, a
    farcall GetBaseHP
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    ld hl, $03e7
    call CompareHLToBC
    jr nc, .done
    ld bc, $03e7

.done:
    pop hl
    ret

; Calls GetBaseMP; also changes HL, BC and A by register arithmetic (E-0347)
; why: part of ActionEffect_Transform; ActionEffect_Transform: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 58
; Transform (E-0352, E-0084)
ActionEffect_Transform_GetBaseMP::
    push hl
    ld c, a
    farcall GetBaseMP
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    ld hl, $03e7
    call CompareHLToBC
    jr nc, .done
    ld bc, $03e7

.done:
    pop hl
    ret

; A = battle slot: BC = the slot's base ATK (GetBaseATK, wBattleStatResultLo/Hi) (E-0096)
GetBaseATKOfSlotA::
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
GetBaseDEFOfSlotA::
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
GetBaseAGLOfSlotA::
    push hl
    ld c, a
    farcall GetBaseAGL
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    pop hl
    ret

; Calls BattlerRecordFieldAddress; copies L to wMonsterId; calls LoadMonsterRecord; copies
; wRecordBuffer to wSpeciesIdLo; sets wSpeciesIdHi; calls LoadSpeciesRecord; also changes HL, A, B
; and E by register arithmetic (E-0347)
; why: part of ActionEffect_Transform; ActionEffect_Transform: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 58
; Transform (E-0352, E-0084)
ActionEffect_Transform_BattlerRecordFieldAddress::
    ld b, a
    and $03
    cp $03
    jr z, .skip
    ld a, b
    ld e, BATTLER_RESISTANCES
    call BattlerRecordFieldAddress
    jr .return

.skip:
    ld a, b
    srl a
    srl a
    and $01
    ld hl, wSpecialSlotMonsters
    add a
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
    ld hl, wSpeciesRecord + SPECIES_RESISTANCES

.return:
    ret

; Calls BattlerRecordFieldAddress; copies L to wMonsterId; calls LoadMonsterRecord; also changes HL,
; A, B and E by register arithmetic (E-0347)
; why: part of ActionEffect_Transform_BattlerRecordFieldAddress, in part of ActionEffect_Transform;
; ActionEffect_Transform: effect routine reached through DispatchActionEffectTable
; (ActionEffectTable, indexed by wBattleActionId) for action(s) 58 Transform (E-0352, E-0084)
ActionEffect_Transform_BattlerRecordFieldAddress_2::
    ld b, a
    and $03
    cp $03
    jr z, .skip
    ld a, b
    ld e, BATTLER_SKILLS
    call BattlerRecordFieldAddress
    ld b, $08
    jr .return

.skip:
    ld a, b
    srl a
    srl a
    and $01
    ld hl, wSpecialSlotMonsters
    add a
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

; Calls SlotSpeciesNibblesD00AD00B (E-0347)
; why: part of ActionEffect_Transform_SlotSpeciesNibblesD00AD00B, in a helper of
; ActionEffect_Transform; ActionEffect_Transform: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 58
; Transform (E-0352, E-0084)
ActionEffect_Transform_SlotSpeciesNibblesD00AD00B_2::
    push hl
    ld c, a
    farcall SlotSpeciesNibblesD00AD00B
    pop hl
    ret

; halves the target's wBattleDEF word, runs ComputeAttackDamage (which halves DEF again, so the
; effective DEF is a quarter), then restores the DEF word (E-0096)
ComputeAttackDamageWithHalvedDEF::
    ld a, [wBattleTarget]
    add a
    ld hl, wBattleDEF
    add_a_to_hl
    push hl
    ld a, [hli]
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
    ld [hli], a
    ld [hl], b
    ret

; Takes HL and A; changes HL, BC and A (E-0347)
; why: part of ActionEffect_BeDragon; ActionEffect_BeDragon: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 59
; BeDragon, $B8 (E-0352, E-0084)
ActionEffect_BeDragon_CompareHLToBC::
    add a
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

; jumps to the routine whose 16-bit address is at ActionEffectTable + 2 * wBattleActionId (the same
; JumpToHL idiom as CallInBank). The table has 240 entries (ids 0-239) and ends at $6906, where the
; first effect routine starts; the routines are named ActionEffect_<skill> after the skills that use
; them (E-0053, E-0084)
DispatchActionEffectTable::
    ld a, [wBattleActionId]
    ld c, a
    ld b, $00
    ld hl, ActionEffectTable
    add hl, bc
    add hl, bc
    call JumpToWordAtHL
    ret

; DispatchActionEffectTable (DispatchActionEffectTable) jumps through the word at $6726 + 2 *
; wBattleActionId; E-0053 and E-0084 counted 240 entries ending at $6906, where the first effect
; routine starts (E-0126, C1)
; record: effect routine
ActionEffectTable::
    dw ActionEffect_Fight ; entry 0
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
    dw ResolveStepDamageMessage_RollVsRadiantResistance ; entry 46
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
    dw ActionEffect_Ahhh_2 ; entry 170
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

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $D0; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: calls RollSkillDamageScaledByBoltResistance; calls
; RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3; continues in ActionEffect_ActionCF_Skip (E-0347)
ActionEffect_ActionD0::
    call RollSkillDamageScaledByBoltResistance
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $D1; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: calls ActionEffect_ActionD1_RollSkillDamageFromRecord; calls
; RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3; continues in ActionEffect_ActionCF_Skip (E-0347)
ActionEffect_ActionD1::
    call ActionEffect_ActionD1_RollSkillDamageFromRecord
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $D2; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: calls ActionEffect_ActionD2_ScaleByGigaSlashResistance; calls
; RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3; continues in
; UnreferencedStoreResolveMessage35D0_Bank36 (E-0347)
ActionEffect_ActionD2::
    call ActionEffect_ActionD2_ScaleByGigaSlashResistance
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $D3; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: calls ActionEffect_ActionD3_ScaleByGigaSlashResistance; calls
; RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3; continues in
; UnreferencedStoreResolveMessage35D0_Bank36 (E-0347)
ActionEffect_ActionD3::
    call ActionEffect_ActionD3_ScaleByGigaSlashResistance
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $D4; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: calls ActionEffect_ActionD4_ScaleByGigaSlashResistance; calls
; RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3; continues in
; UnreferencedStoreResolveMessage35D0_Bank36 (E-0347)
ActionEffect_ActionD4::
    call ActionEffect_ActionD4_ScaleByGigaSlashResistance
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $D5; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: calls SkillDamageScaledByGigaSlashResistance; calls
; RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3; continues in
; UnreferencedStoreResolveMessage35D0_Bank36 (E-0347)
ActionEffect_ActionD5::
    call SkillDamageScaledByGigaSlashResistance
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $D6; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: calls RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3; continues in ActionEffect_Sacrifice
; (E-0347)
ActionEffect_ActionD6::
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    jp ActionEffect_Sacrifice

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $D7; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: calls RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3; calls
; ActionEffect_ActionD7_AdvanceRandom; continues in UnreferencedStoreResolveMessage35D0_Bank36
; (E-0347)
ActionEffect_ActionD7::
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    call ActionEffect_ActionD7_AdvanceRandom
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $D8; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: calls RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3; calls
; ActionEffect_ActionD8_ComputeAttackDamage; continues in UnreferencedStoreResolveMessage35D0_Bank36
; (E-0347)
ActionEffect_ActionD8::
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    call ActionEffect_ActionD8_ComputeAttackDamage
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 217; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_ActionD9::
    call ActionEffect_ActionD9_WriteBattleDamageLoAndBattleDamageHiEtc
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $DA; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: calls RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3; sets hTemp0 to 0; calls
; ClearDamageAndReadTargetStatus0_Bank36; sets hTemp0 to 1; calls HealTargetHP; sets hTemp0 to 1;
; branches on hTemp0; continues in ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor;
; continues in ClearDamageAndStoreResolveMsgFlags_Bank36_Skip; also changes HL, DE, BC and A by
; register arithmetic (E-0347)
ActionEffect_ActionDA::
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    xor a
    ldh [hTemp0], a
    call ClearDamageAndReadTargetStatus0_Bank36
    or a
    jr z, .read_battle_target
    ld [hl], $00
    ld a, $01
    ldh [hTemp0], a

.read_battle_target:
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank36
    ld a, [hli]
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
    ld a, [hli]
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
    or a
    jr z, .skip
    ld l, $37
    lb bc, $40, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $DB; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: calls RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3; calls
; ClearDamageAndReadTargetStatus0_Bank36; calls AdvanceRandom; branches on the byte at
; ActionEffect_ActionDB_Data; copies the byte at ActionEffect_ActionDB_Data to wBattleActionId;
; copies wEffectFlags2 to hTemp0; copies wEffectFlags to hTemp1; sets wEffectFlags to $41; sets
; wEffectFlags2 to $30; calls SelectEffectByEffectFlags; calls SelectEffectByEffectFlags2Flags;
; copies hTemp0 to wEffectFlags2; then 3 more steps (see the code) (E-0347)
ActionEffect_ActionDB::
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    call ClearDamageAndReadTargetStatus0_Bank36
    call AdvanceRandom
    ld a, [wRandomLo]
    sra a
    sra a
    and $03
    sla a
    sla a
    ld de, ActionEffect_ActionDB_Data
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    inc de
    ld c, a
    ld a, [hl]
    or c
    ld [hl], a
    ld a, [wBattleActionId]
    push af
    push de
    ld a, [de]
    cp $ff
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
    lb bc, $40, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

; data read by ActionEffect_ActionDB (16 bytes) (E-0347)
ActionEffect_ActionDB_Data::
    db $02, $2f, $77, $00, $20, $34, $d9, $00, $40, $2f, $76, $00, $10, $34, $42, $00

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $DC; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: calls ActorFormationSlotToTemp0; copies hTemp0 to wBattleActor; calls ActionEffect_BeDragon;
; sets wBattleActor; continues in ActionEffect_BeDragon (E-0347)
ActionEffect_ActionDC::
    ld a, [wBattleActor]
    push af
    farcall ActorFormationSlotToTemp0
    ldh a, [hTemp0]
    ld [wBattleActor], a
    call ActionEffect_BeDragon
    pop af
    ld [wBattleActor], a
    jp ActionEffect_BeDragon

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $DD; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: calls RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3; sets BSTAT1_ATK_DOUBLED of
; wBattleStatus1; calls AdvanceRandom; calls RaiseTargetDEF; calls SetSlotStatus6Bit6; calls
; RaiseTargetAGL; calls SetSlotStatus6Bit6; continues in ClearDamageAndStoreResolveMsgFlags_Bank36;
; also changes HL, BC and A by register arithmetic (E-0347)
ActionEffect_ActionDD::
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    set BSTAT1_ATK_DOUBLED, [hl]
    push hl
    call AdvanceRandom
    pop hl
    ld a, $04
    add_a_to_hl
    ld a, [wRandomLo]
    and $04
    add $04
    ld b, a
    ld a, [hl]
    and $f3
    or b
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
    lb bc, $00, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $DE; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: calls RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3; sets BSTAT1_SPELLS_SEALED of
; wBattleStatus1; sets BSTAT1_DANCE_SEALED of wBattleStatus1; sets BSTAT1_BREATH_SEALED of
; wBattleStatus1; continues in ClearDamageAndStoreResolveMsgFlags_Bank36 (E-0347)
ActionEffect_ActionDE::
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    set BSTAT1_SPELLS_SEALED, [hl]
    set BSTAT1_DANCE_SEALED, [hl]
    set BSTAT1_BREATH_SEALED, [hl]
    ld l, $9e
    lb bc, $00, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $DF; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: calls RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3; continues in ActionEffect_RobMagic
; (E-0347)
ActionEffect_ActionDF::
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    jp ActionEffect_RobMagic

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $E0; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: calls RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3; calls ActorFormationSlotToTemp0;
; copies hTemp0 to wBattleActor; calls ActionEffect_StrongD; sets wBattleActor; continues in
; ActionEffect_StrongD (E-0347)
ActionEffect_ActionE0::
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    ld a, [wBattleActor]
    push af
    farcall ActorFormationSlotToTemp0
    ldh a, [hTemp0]
    ld [wBattleActor], a
    call ActionEffect_StrongD
    pop af
    ld [wBattleActor], a
    jp ActionEffect_StrongD

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $E1; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: calls RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3; continues in ActionEffect_PanicAll
; (E-0347)
ActionEffect_ActionE1::
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    jp ActionEffect_PanicAll

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $E2; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: calls RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3; copies wBattleActor & $04 to hTemp0;
; calls CarryUnlessBattleSlotOutSlotEmpty; sets BSTAT7_DAMAGE_X10 of wBattleStatus7; increments
; hTemp0; continues in SetSubPhase2AndResetResolveStep_CheckOriginalTarget (E-0347)
ActionEffect_ActionE2::
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    ld a, [wBattleActor]
    and $04
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
    set BSTAT7_DAMAGE_X10, [hl]

.skip:
    ld hl, hTemp0
    inc [hl]
    dec b
    jr nz, .loop
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $E3; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: calls RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3; copies wBattleActor & $04 to hTemp0;
; calls CarryUnlessBattleSlotOutSlotEmpty; sets BSTAT1_CRITICAL of wBattleStatus1; clears bit 6 of
; wBattleStatus1; sets bit 7 of wBattleStatus1; increments hTemp0; continues in
; SetSubPhase2AndResetResolveStep_CheckOriginalTarget (E-0347)
ActionEffect_ActionE3::
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    ld a, [wBattleActor]
    and $04
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
    set BSTAT1_CRITICAL, [hl]
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
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 175, 190, 228, 229, 230, 231 ...; the misaligned decoding before E-0126 hid this
; entry; the body is not interpreted (E-0126)
; code: returns at once (E-0347)
ActionEffect_ActionAF::
    ret

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 0 (no name); ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084) (E-0333: action 0 is Fight, the plain
; attack: it is dispatched on turns whose battle text names no skill, while every other action
; follows the skill-name lookup of its own id; skill 0 is AIScore_Fight; C2) (was
; ActionEffect_Fight)
; code: calls ComputeAttackDamage; continues in UnreferencedStoreResolveMessage35D0_Bank36 (E-0347)
ActionEffect_Fight::
    call ComputeAttackDamage
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 1 Blaze, 2 Blazemore, 3 Blazemost; ids below 175 are skills named
; from StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls ActionEffect_Blaze_RollSkillDamageFromRecord; continues in ActionEffect_ActionCF_Skip
; (E-0347)
ActionEffect_Blaze::
    call ActionEffect_Blaze_RollSkillDamageFromRecord
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 4 Firebal, 5 Firebane, 6 Firebolt; ids below 175 are skills named
; from StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls ActionEffect_Firebal_RollSkillDamageFromRecord; continues in
; ActionEffect_ActionCF_Skip (E-0347)
ActionEffect_Firebal::
    call ActionEffect_Firebal_RollSkillDamageFromRecord
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 7 Bang, 8 Boom, 9 Explodet; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls ActionEffect_Bang_RollSkillDamageFromRecord; continues in ActionEffect_ActionCF_Skip
; (E-0347)
ActionEffect_Bang::
    call ActionEffect_Bang_RollSkillDamageFromRecord
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 10 Infernos, 11 Infermore, 12 Infermost; ids below 175 are skills
; named from StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls ActionEffect_Infernos_RollSkillDamageFromRecord; continues in
; ActionEffect_ActionCF_Skip (E-0347)
ActionEffect_Infernos::
    call ActionEffect_Infernos_RollSkillDamageFromRecord
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 13 Bolt, 14 Zap, 15 Thordain, 63 Hellblast; ids below 175 are
; skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls RollSkillDamageScaledByBoltResistance; continues in ActionEffect_ActionCF_Skip
; (E-0347)
ActionEffect_Bolt::
    call RollSkillDamageScaledByBoltResistance
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 16 IceBolt, 17 SnowStorm, 18 Blizzard; ids below 175 are skills
; named from StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls ActionEffect_IceBolt_RollSkillDamageFromRecord; continues in
; ActionEffect_ActionCF_Skip (E-0347)
ActionEffect_IceBolt::
    call ActionEffect_IceBolt_RollSkillDamageFromRecord
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 19 Beat, 20 Defeat, 121 K.O.Dance; ids below 175 are skills named
; from StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls RollVsBeatResistance; copies L to wBattleDamageLo; copies H to wBattleDamageHi;
; continues in UnreferencedStoreResolveMessage35D0_Bank36_SetResolveMsgActor; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2; also changes HL, BC and A by register arithmetic
; (E-0347)
ActionEffect_Beat::
    call RollVsBeatResistance
    jr nc, .skip
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank36
    xor a
    ld [hli], a
    ld [hl], a
    ld hl, $03e8
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    lb hl, $b5, $8e
    lb bc, $80, $a8
    jp UnreferencedStoreResolveMessage35D0_Bank36_SetResolveMsgActor

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 21 Sacrifice; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls ActionEffect_Sacrifice_ZIfAllyActorInBattleKindMode2Or3; calls AdvanceRandom; calls
; GetBattleHP; copies C to wBattleDamageLo; copies B to wBattleDamageHi; continues in
; ActionEffect_ActionCF_Skip; copies L to wBattleDamageLo; copies H to wBattleDamageHi; continues in
; UnreferencedStoreResolveMessage35D0_Bank36_SetResolveMsgActor; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2; also changes HL, BC and A by register arithmetic
; (E-0347)
ActionEffect_Sacrifice::
    call ActionEffect_Sacrifice_ZIfAllyActorInBattleKindMode2Or3
    jr nc, .skip
    call AdvanceRandom
    ld a, [wRandomLo]
    and $01
    jr z, .read_battle_target
    ld a, [wBattleTarget]
    call GetBattleHP
    push hl
    ld a, $64
    call DivideHLByA
    ld a, h
    or l
    jr nz, .restore
    ld hl, $0001

.restore:
    pop bc
    ld a, c
    sub l
    ld c, a
    ld a, b
    sbc h
    ld b, a
    or c
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
    xor a
    ld [hli], a
    ld [hl], a
    ld hl, $03e8
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    lb hl, $b5, $8f
    lb bc, $80, $a8
    jp UnreferencedStoreResolveMessage35D0_Bank36_SetResolveMsgActor

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 22 Heal, 23 HealMore, 24 HealAll, 25 HealUs, 26 HealUsAll, 124
; Hustle, $B1; ids below 175 are skills named from StringTable_SkillNames; the body is not
; interpreted (E-0084)
ActionEffect_Heal::
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .read_battle_target
    jr z, .skip2
    jr .skip

.read_battle_target:
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank36
    ld a, [hli]
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
    lb bc, $40, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip

.skip2:
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 27 MPass, 28 MPassmore, 29 MPassmost; ids below 175 are skills
; named from StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls CarryUnlessBattleSlotOutSlotEmpty; calls ActionEffect_MPass_AddDoubleAToHL_Bank36;
; continues in ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_Skip; continues in
; SetSubPhase2AndResetResolveStep_CheckOriginalTarget; also changes HL, BC and A by register
; arithmetic (E-0347)
ActionEffect_MPass::
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .read_battle_target
    jr z, .skip2
    jr .skip

.read_battle_target:
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    ld a, [hli]
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
    ld l, $c3
    lb bc, $40, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip

.skip2:
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 30 Vivify; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls CarryUnlessBattleSlotOutSlotEmpty; may continue in ApplyTargetMaxHPAmount_Skip; may
; continue in ApplyTargetMaxHPAmount_Skip2; calls AdvanceRandom; may continue in
; ActionEffect_Vivify_Skip; also changes HL, DE, A and B by register arithmetic (E-0347)
ActionEffect_Vivify::
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jp nc, ApplyTargetMaxHPAmount_Skip
    jp z, ApplyTargetMaxHPAmount_Skip2
    call AdvanceRandom
    ld a, [wRandomLo]
    and $01
    jr z, ActionEffect_Vivify_Skip
    ld a, [wBattleTarget]
    ld b, a
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank36
    ld a, [hli]
    ld d, [hl]
    ld e, a
    srl d
    rr e

; Calls TargetOnLocalSide_Bank36; calls LoadBattleMonsterPictureForSlotB; calls
; ActionEffect_Vivify_AddAx9ToHL; continues in ClearDamageAndStoreResolveMsgFlags_Bank36; also
; changes HL, DE, BC and A by register arithmetic (E-0347)
; why: part of ActionEffect_Vivify; ActionEffect_Vivify: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 30 Vivify
; (E-0352, E-0084)
ActionEffect_Vivify_CallAddDoubleAToHL_Bank36::
    ld a, b
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank36
    ld a, e
    ld [hli], a
    ld [hl], d
    call TargetOnLocalSide_Bank36
    jr c, .call_action_effect_vivify_add_ax9_to_hl
    ld a, [wBattleTarget]
    ld b, a
    add a
    ld de, wBattleMonsterId
    add e
    ld e, a
    jr nc, .call_load_battle_monster_picture_for_slot_b
    inc d

.call_load_battle_monster_picture_for_slot_b:
    call LoadBattleMonsterPictureForSlotB
    jr .call_action_effect_vivify_add_ax9_to_hl

.call_action_effect_vivify_add_ax9_to_hl:
    call ActionEffect_Vivify_AddAx9ToHL
    ld l, $50
    lb bc, $40, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

; Changes BC and H; continues in ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget
; (E-0347)
; why: part of ActionEffect_Vivify; ActionEffect_Vivify: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 30 Vivify
; (E-0352, E-0084)
ActionEffect_Vivify_Skip::
    ld h, $67
    lb bc, $00, $80
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 31 Revive, $BB; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: may continue in ApplyTargetMaxHPAmount_Skip2; calls CarryUnlessBattleSlotOutSlotEmpty; may
; continue in ApplyTargetMaxHPAmount_Skip; may continue in ApplyTargetMaxHPAmount_Skip2 (E-0347)
ActionEffect_Revive::
    ld a, [wBattleTarget]
    and $03
    cp $03
    jr z, ApplyTargetMaxHPAmount_Skip2
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jp nc, ApplyTargetMaxHPAmount_Skip
    jp z, ApplyTargetMaxHPAmount_Skip2

; DE = the target's max HP and continues with the shared HP amount path
; (ActionEffect_Vivify_CallAddDoubleAToHL_Bank36) (E-0122)
ApplyTargetMaxHPAmount::
    ld a, [wBattleTarget]
    ld b, a
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank36
    ld a, [hli]
    ld d, [hl]
    ld e, a
    jp ActionEffect_Vivify_CallAddDoubleAToHL_Bank36

; Continues in ClearDamageAndStoreResolveMsgFlags_Bank36_Skip (E-0347)
; why: part of ApplyTargetMaxHPAmount; ApplyTargetMaxHPAmount: DE = the target's max HP and
; continues with the shared HP amount path (ActionEffect_Vivify_CallAddDoubleAToHL_Bank36) (E-0352,
; E-0122)
ApplyTargetMaxHPAmount_Skip::
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip

; Continues in SetSubPhase2AndResetResolveStep_CheckOriginalTarget (E-0347)
; why: part of ApplyTargetMaxHPAmount; ApplyTargetMaxHPAmount: DE = the target's max HP and
; continues with the shared HP amount path (ActionEffect_Vivify_CallAddDoubleAToHL_Bank36) (E-0352,
; E-0122)
ApplyTargetMaxHPAmount_Skip2::
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 32 Farewell; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: may continue in ApplyTargetMaxHPAmount_Skip2; calls CarryUnlessBattleSlotOutSlotEmpty; may
; continue in ApplyTargetMaxHPAmount_Skip2; calls ApplyTargetMaxHPAmount; sets bit 6 of
; wResolveMsgFlags; calls ActionEffect_Heal; clears bit 6 of wResolveMsgFlags (E-0347)
ActionEffect_Farewell::
    ld a, [wBattleTarget]
    ld hl, wBattleActor
    cp [hl]
    jr z, ApplyTargetMaxHPAmount_Skip2
    ld a, [wBattleTarget]
    and $03
    cp $03
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

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 33 Antidote; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls ClearDamageAndReadTargetStatus0_Bank36; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_Skip (E-0347)
ActionEffect_Antidote::
    call ClearDamageAndReadTargetStatus0_Bank36
    and $03
    jr z, .skip
    ld a, [hl]
    and $fc
    ld [hl], a
    ld l, $4e
    lb bc, $40, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 34 DeChaos; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls ClearDamageAndReadTargetStatus0_Bank36; sets wSlotMarks to 3; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_Skip; also changes HL, BC and A by register arithmetic
; (E-0347)
ActionEffect_DeChaos::
    call ClearDamageAndReadTargetStatus0_Bank36
    and $10
    jr z, .skip
    ld a, [hl]
    and $ef
    ld [hl], a
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $03
    ld l, $83
    lb bc, $40, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 35 NumbOff; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls ClearDamageAndReadTargetStatus0_Bank36; calls
; ClearDamageAndStoreResolveMsgFlags_Bank36; sets wSlotMarks to 3; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_Skip; also changes HL, BC and A by register arithmetic
; (E-0347)
ActionEffect_NumbOff::
    call ClearDamageAndReadTargetStatus0_Bank36
    and $cc
    jr z, .skip
    push hl
    bit 6, [hl]
    jr z, .call_clear_damage_and_store_resolve_msg_flags
    ld l, $4f
    jr .call_clear_damage_and_store_resolve_msg_flags2

.call_clear_damage_and_store_resolve_msg_flags:
    ld l, $82

.call_clear_damage_and_store_resolve_msg_flags2:
    lb bc, $40, $90
    call ClearDamageAndStoreResolveMsgFlags_Bank36
    pop hl
    ld a, [hl]
    and $33
    ld [hl], a
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $03
    ret

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 36 CurseOff; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls ClearDamageAndReadTargetStatus0_Bank36; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_Skip (E-0347)
ActionEffect_CurseOff::
    call ClearDamageAndReadTargetStatus0_Bank36
    and $20
    jr z, .skip
    ld a, [hl]
    and $df
    ld [hl], a
    ld l, $51
    lb bc, $40, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 37 Upper, 38 Increase; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls RaiseTargetDEF; calls SetSlotStatus6Bit6; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget; also changes HL, BC and A by
; register arithmetic (E-0347)
ActionEffect_Upper::
    call RaiseTargetDEF
    jr nc, .skip
    ld a, [wBattleTarget]
    call SetSlotStatus6Bit6
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    ld a, l
    or h
    jr z, .skip
    ld l, $45
    lb bc, $00, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

.skip:
    ld h, $cc
    lb bc, $00, $84
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 39 Sap, 40 Defense; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls RollVsSapResistance; may continue in ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2
; (E-0347)
ActionEffect_Sap::
    call RollVsSapResistance
    jp nc, ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2

; called from ActionEffect_UltraDown: calls ActionEffect_UltraDown_GetBattleDEF; calls
; SetSlotStatus6Bit7; continues in ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor;
; continues in ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget (E-0347)
; why: a helper of ActionEffect_UltraDown; ActionEffect_UltraDown: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 130
; UltraDown (E-0352, E-0084)
ActionEffect_UltraDown_SetSlotStatus6Bit7::
    call ActionEffect_UltraDown_GetBattleDEF
    jr nc, .skip
    ld a, [wBattleTarget]
    call SetSlotStatus6Bit7
    ld l, $39
    lb bc, $00, $98
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

.skip:
    ld h, $cc
    lb bc, $00, $84
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 41 Speed, 42 SpeedUp; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls RaiseTargetAGL; calls SetSlotStatus6Bit6; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget; also changes HL, BC and A by
; register arithmetic (E-0347)
ActionEffect_Speed::
    call RaiseTargetAGL
    jr nc, .skip
    ld a, [wBattleTarget]
    call SetSlotStatus6Bit6
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    ld a, l
    or h
    jr z, .skip
    ld l, $49
    lb bc, $00, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

.skip:
    ld h, $cc
    lb bc, $00, $84
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 43 Slow, 44 SlowAll; the misaligned decoding before E-0126 hid this entry; the body
; is not interpreted (E-0126)
; code: calls RollVsSlowResistance; may continue in ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2
; (E-0347)
ActionEffect_Slow::
    call RollVsSlowResistance
    jp nc, ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2

; Calls ResolveStepDamageMessage_GetBaseAGLOfSlotA; calls SetSlotStatus6Bit7; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget (E-0347)
; why: part of ResolveStepDamageMessage; ResolveStepDamageMessage: resolve step $0A: advances
; wBattleResolveStep and, for the actor or target side chosen by wResolveMsgFlags bit 4, stores
; wResolveMsgActor ... (E-0352)
ResolveStepDamageMessage_SetSlotStatus6Bit7::
    call ResolveStepDamageMessage_GetBaseAGLOfSlotA
    jr nc, .skip
    ld a, [wBattleTarget]
    call SetSlotStatus6Bit7
    ld l, $48
    lb bc, $00, $98
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

.skip:
    ld h, $cc
    lb bc, $00, $84
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 45 TwinHits; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: branches on wBattleStatus1; sets BSTAT1_ATK_DOUBLED of wBattleStatus1; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36; continues in
; SetSubPhase2AndResetResolveStep_CheckOriginalTarget (E-0347)
ActionEffect_TwinHits::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_ATK_DOUBLED, [hl]
    jr nz, .skip
    set BSTAT1_ATK_DOUBLED, [hl]
    ld l, $43
    lb bc, $00, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; RollVsRadiantResistance during the damage message step (E-0338)
ResolveStepDamageMessage_RollVsRadiantResistance::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_BLINDED, [hl]
    jr nz, .check_resolve_msg_flags
    call RollVsRadiantResistance
    jr nc, .skip
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    set BSTAT1_BLINDED, [hl]
    ld l, $4a
    lb bc, $00, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.check_resolve_msg_flags:
    ld a, [wResolveMsgFlags]
    and $ef
    ld [wResolveMsgFlags], a
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 47 Sleep, 48 SleepAll, 113 SleepAir; ids below 175 are skills named
; from StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls RollVsSleepResistance; continues in ClearDamageAndStoreResolveMsgFlags_Bank36;
; branches on wBattleActionId; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget; also changes HL, BC and A by
; register arithmetic (E-0347)
ActionEffect_Sleep::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and $8c
    jr nz, .skip2
    push hl
    call RollVsSleepResistance
    pop hl
    jr nc, .check_battle_action_id
    ld a, [hl]
    or $8c
    ld [hl], a
    ld l, $73
    lb bc, $40, $98
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.check_battle_action_id:
    ld a, [wBattleActionId]
    cp SKILL_SLEEPAIR
    ld h, $b5
    jr z, .skip
    ld h, $ce

.skip:
    lb bc, $00, $80
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

.skip2:
    ld h, $d4
    lb bc, $00, $80
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 49 TakeMagic; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: branches on wBattleStatus2; sets BSTAT2_TAKE_MAGIC of wBattleStatus2; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36; continues in
; SetSubPhase2AndResetResolveStep_CheckOriginalTarget (E-0347)
ActionEffect_TakeMagic::
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit BSTAT2_TAKE_MAGIC, [hl]
    jr nz, .skip
    set BSTAT2_TAKE_MAGIC, [hl]
    ld l, $3f
    lb bc, $00, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 50 RobMagic, 119 RobDance; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: branches on wBattleActionId; calls GetBattleMP; calls RollVsRobMagicResistance; copies C to
; wSavedActorSlot; copies B to wSavedActorByte; calls ActionEffect_RobMagic_DrainTargetMPAmount;
; branches on wBattleActionId; calls ActorFormationSlotToTemp0; copies hTemp0 to wBattleActor; calls
; ActionEffect_RobMagic_DrainTargetMPAmount; sets wBattleActor; copies C to wBattleDamageLo; then 4
; more steps (see the code) (E-0347)
ActionEffect_RobMagic::
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    ld a, [hli]
    or [hl]
    jp z, .skip3
    ld a, [wBattleActionId]
    cp $df
    jr z, .call_roll_vs_rob_magic_resistance
    ld a, [wBattleActor]
    call GetBattleMP
    ld a, [wBattleActor]
    ld de, wBattleMaxMP
    add a
    add e
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

.call_roll_vs_rob_magic_resistance:
    call RollVsRobMagicResistance
    jr nc, .skip3
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    ld a, [hli]
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
    cp $df
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
    xor a
    ld [hli], a
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
    ld l, $3d
    lb bc, $40, $98
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

.skip3:
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 51 StopSpell; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: branches on wBattleStatus1; calls
; ActionEffect_StopSpell_HLToBattleStatus8EntryOfBattleTarget_Bank36; sets BSTAT1_SPELLS_SEALED of
; wBattleStatus1; continues in ClearDamageAndStoreResolveMsgFlags_Bank36; continues in
; SetSubPhase2AndResetResolveStep_CheckOriginalTarget; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2; also changes HL, BC and A by register arithmetic
; (E-0347)
ActionEffect_StopSpell::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_SPELLS_SEALED, [hl]
    jr nz, .skip
    call ActionEffect_StopSpell_HLToBattleStatus8EntryOfBattleTarget_Bank36
    jr nc, .skip2
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    set BSTAT1_SPELLS_SEALED, [hl]
    ld l, $3b
    lb bc, $40, $98
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

.skip2:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 52 PanicAll, 120 PaniDance, 173 PanicAll; ids below 175 are skills
; named from StringTable_SkillNames; the body is not interpreted (E-0084)
; code: branches on wBattleStatus; calls
; ActionEffect_PanicAll_HLToBattleStatus8EntryOfBattleTarget_Bank36; sets BSTAT0_CONFUSED of
; wBattleStatus; continues in ClearDamageAndStoreResolveMsgFlags_Bank36; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2; also changes HL, BC and A by register arithmetic
; (E-0347)
ActionEffect_PanicAll::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit BSTAT0_CONFUSED, [hl]
    jr nz, .skip
    call ActionEffect_PanicAll_HLToBattleStatus8EntryOfBattleTarget_Bank36
    jr nc, .skip2
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    set BSTAT0_CONFUSED, [hl]
    ld l, $42
    lb bc, $40, $98
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    ld h, $cf
    lb bc, $00, $84
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

.skip2:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 53 Ironize, 174 Ironize; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: branches on wLinkMode; branches on wBattleTarget; calls CarryUnlessBattleSlotOutSlotEmpty;
; calls ActionEffect_Ironize_ReadLinkModeAndBattleTarget; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36; also changes HL, BC and A by register arithmetic
; (E-0347)
ActionEffect_Ironize::
    ld a, [wLinkMode]
    cp $01
    jr z, .check_battle_target
    ld a, [wBattleTarget]
    cp $04
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
    and $04
    ld c, a
    ld hl, wBattleStatus5
    call AddAx9ToHL

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    ld a, [hl]
    or $c0
    ld [hl], a

.skip:
    ld a, $09
    add_a_to_hl
    inc c
    dec b
    jr nz, .loop
    farcall ActionEffect_Ironize_ReadLinkModeAndBattleTarget
    ld l, d
    lb bc, $00, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 54 MagicBack, 55 Bounce; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: changes HL, BC and A; branches on wBattleActionId; branches on wBattleStatus2; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36; branches on wBattleStatus2; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget (E-0347)
ActionEffect_MagicBack::
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    ld a, [wBattleActionId]
    cp SKILL_BOUNCE
    jr z, .skip
    bit BSTAT2_MAGIC_BACK, [hl]
    jr nz, .skip2
    ld a, [hl]
    and $dd
    or $20
    ld [hl], a
    ld l, $4b
    lb bc, $00, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    bit 1, [hl]
    jr nz, .skip2
    ld a, [hl]
    and $dd
    or $02
    ld [hl], a
    ld l, $4c
    lb bc, $00, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip2:
    ld h, $cc
    lb bc, $00, $84
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 56 Barrier; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls CarryUnlessBattleSlotOutSlotEmpty; branches on wBattleStatus2; sets bit 2 of
; wBattleStatus2; clears bit 2 of wBattleStatus2; branches on wBattleStatus2; branches on D;
; continues in ClearDamageAndStoreResolveMsgFlags_Bank36; continues in
; SetSubPhase2AndResetResolveStep_CheckOriginalTarget; also changes HL, BC, A and D by register
; arithmetic (E-0347)
ActionEffect_Barrier::
    ld a, [wBattleTarget]
    and $04
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
    or a
    jr z, .skip2
    ld l, $4d
    lb bc, $00, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip2:
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 57 MagicWall; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls CarryUnlessBattleSlotOutSlotEmpty; sets BSTAT8_MAGIC_WALL of wBattleStatus8; continues
; in SetSubPhase2AndResetResolveStep_CheckOriginalTarget; also changes HL, BC and A by register
; arithmetic (E-0347)
ActionEffect_MagicWall::
    ld a, [wBattleActor]
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus8
    call AddAx9ToHL
    set BSTAT8_MAGIC_WALL, [hl]

.next:
    inc c
    dec b
    jr nz, .loop
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 58 Transform; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls ClearDamageAndStoreResolveMsgFlags_Bank36; calls
; ActionEffect_Transform_SlotSpeciesNibblesD00AD00B; sets BSTAT1_TRANSFORMED of wBattleStatus1;
; clears BSTAT1_DRAGON_FORM of wBattleStatus1 (E-0347)
ActionEffect_Transform::
    ld l, $52
    lb bc, $40, $90
    call ClearDamageAndStoreResolveMsgFlags_Bank36
    call ActionEffect_Transform_SlotSpeciesNibblesD00AD00B
    ld a, [wBattleActor]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    and $f8
    ld [hl], a
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    set BSTAT1_TRANSFORMED, [hl]
    res BSTAT1_DRAGON_FORM, [hl]
    ret

; called from ResolveStepDamageMessage: returns if wLinkMode is $01; returns if wBattleActor is
; below $04; also changes HL and A by register arithmetic (E-0347)
; why: a helper of ResolveStepDamageMessage; ResolveStepDamageMessage: resolve step $0A: advances
; wBattleResolveStep and, for the actor or target side chosen by wResolveMsgFlags bit 4, stores
; wResolveMsgActor ... (E-0352)
ResolveStepDamageMessage_WaitLinkMode::
    ld a, [wLinkMode]
    cp $01
    ret z
    ld a, [wBattleActor]
    cp $04
    ret c
    and $03
    ld hl, wSlotNameBytes
    add_a_to_hl
    ld a, [wBattleTarget]
    ld [hl], a
    ret

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 59 BeDragon, $B8; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls ActionEffect_BeDragon_LoadMonsterRecord; sets BSTAT1_DRAGON_FORM of wBattleStatus1;
; clears BSTAT1_TRANSFORMED of wBattleStatus1; calls ActionEffect_BeDragon_ReadLinkMode; branches on
; wBattleActionId; continues in ClearDamageAndStoreResolveMsgFlags_Bank36; also changes HL, BC and A
; by register arithmetic (E-0347)
ActionEffect_BeDragon::
    call ActionEffect_BeDragon_LoadMonsterRecord
    ld a, [wBattleActor]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    and $f8
    ld [hl], a
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    set BSTAT1_DRAGON_FORM, [hl]
    res BSTAT1_TRANSFORMED, [hl]
    ld a, [wBattleActor]
    ld c, a
    farcall ActionEffect_BeDragon_ReadLinkMode
    ld a, [wBattleActionId]
    cp ACTION_DC
    jr z, .skip
    ld l, $44
    lb bc, $40, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    ld l, $f7
    lb bc, $40, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 60 Chance; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls ActionEffect_Chance_AdvanceRandom; copies C to wBattleActionId; copies C to
; wRecordBuffer; calls LoadSkillRecord; sets wBattleTargetChoice to $ff; calls ChooseTargetForActor;
; copies D to wBattleTarget; sets wBattleSubPhase to 0; sets wBattleResolveStep to 3 (E-0347)
ActionEffect_Chance::
    farcall ActionEffect_Chance_AdvanceRandom
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    add a
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
    add a
    add_a_to_hl
    ld [hl], $ff
    farcall ChooseTargetForActor
    ld a, d
    ld [wBattleTarget], a
    xor a
    ld [wBattleSubPhase], a
    ld a, $03
    ld [wBattleResolveStep], a
    ret

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 61 MegaMagic; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_MegaMagic::
    ld a, [wAllMPSpentLo]
    ld l, a
    ld a, [wAllMPSpentHi]
    ld h, a
    ld a, l
    or h
    jp z, ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2
    call ActionEffect_MegaMagic_WriteBattleDamageLoAndBattleDamageHi
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 62 BigBang; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls ActionEffect_BigBang_RollSkillDamageFromRecord; continues in
; ActionEffect_ActionCF_Skip (E-0347)
ActionEffect_BigBang::
    call ActionEffect_BigBang_RollSkillDamageFromRecord
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 64 FireAir, 65 BlazeAir, 66 Scorching, 67 WhiteFire; ids below 175
; are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls ActionEffect_FireAir_RollSkillDamageFromRecord; calls HalveDamageIfTargetStatus2Bit2;
; continues in ActionEffect_ActionCF_Skip (E-0347)
ActionEffect_FireAir::
    call ActionEffect_FireAir_RollSkillDamageFromRecord
    call HalveDamageIfTargetStatus2Bit2
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 68 FrigidAir, 69 IceAir, 70 IceStorm, 71 WhiteAir; ids below 175
; are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls ActionEffect_FrigidAir_RollSkillDamageFromRecord; calls
; HalveDamageIfTargetStatus2Bit2; continues in ActionEffect_ActionCF_Skip (E-0347)
ActionEffect_FrigidAir::
    call ActionEffect_FrigidAir_RollSkillDamageFromRecord
    call HalveDamageIfTargetStatus2Bit2
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 72 WindBeast; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls ActionEffect_WindBeast_ShiftBCRight1; continues in ActionEffect_ActionCF_Skip (E-0347)
ActionEffect_WindBeast::
    call ActionEffect_WindBeast_ShiftBCRight1
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 73 Vacuum; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls ActionEffect_Vacuum_ShiftBCRight1; continues in ActionEffect_ActionCF_Skip (E-0347)
ActionEffect_Vacuum::
    call ActionEffect_Vacuum_ShiftBCRight1
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 74 Lightning; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls ActionEffect_Lightning_ShiftBCRight1; continues in ActionEffect_ActionCF_Skip (E-0347)
ActionEffect_Lightning::
    call ActionEffect_Lightning_ShiftBCRight1
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 75 RockThrow; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls ActionEffect_RockThrow_RollSkillDamageFromRecord; continues in
; ActionEffect_ActionCF_Skip (E-0347)
ActionEffect_RockThrow::
    call ActionEffect_RockThrow_RollSkillDamageFromRecord
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 76 Watershot, 77 Tidalwave; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls ActionEffect_Watershot_RollSkillDamageFromRecord; continues in
; ActionEffect_ActionCF_Skip (E-0347)
ActionEffect_Watershot::
    call ActionEffect_Watershot_RollSkillDamageFromRecord
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 78 CallHelp, 79 YellHelp; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: branches on wBattleStatus6; calls AdvanceRandom; branches on wRandomLo; sets bit 0 of
; wBattleStatus6; shows battle text 'Help arrived from seemingly nowhere!'; sets wBattleSubPhase to
; 3; sets wBattleResolveStep to 0; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget; calls
; ActionEffect_CallHelp_WriteBattleDamageLoAndBattleDamageHi; continues in
; UnreferencedStoreResolveMessage35D0_Bank36 (E-0347)
ActionEffect_CallHelp::
    ld a, [wBattleActor]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    bit BSTAT6_CALLED_HELP, [hl]
    jr nz, .call_action_effect_call_help_write_battle
    push hl
    call AdvanceRandom
    pop hl
    ld a, [wRandomLo]
    cp $80
    jr c, .skip
    set 0, [hl]
    ld d, $53 ; battle text 'Help arrived from seemingly nowhere!'
    farcall ShowBattleText
    ld a, $03
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    ret

.skip:
    ld h, $69
    lb bc, $00, $80
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

.call_action_effect_call_help_write_battle:
    call ActionEffect_CallHelp_WriteBattleDamageLoAndBattleDamageHi
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 80 FireSlash; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_FireSlash::
    call AttackDamageScaledByBlazeResistance
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 81 VacuSlash; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_VacuSlash::
    call AttackDamageScaledByVacuumResistance
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 82 BoltSlash; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_BoltSlash::
    call AttackDamageScaledByBoltResistance
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 83 IceSlash; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_IceSlash::
    call AttackDamageScaledByIceBoltResistance
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 84 SlimeBlow; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_SlimeBlow::
    call AttackDamageHalvedDEFVsSlime
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 85 DrakSlash; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_DrakSlash::
    call AttackDamageHalvedDEFVsDragon
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 86 BeastCut; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_BeastCut::
    call AttackDamageHalvedDEFVsBeast
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 87 BirdBlow; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_BirdBlow::
    call AttackDamageHalvedDEFVsBird
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 88 BugBlow; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_BugBlow::
    call AttackDamageHalvedDEFVsBug
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 89 Shears; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_Shears::
    call AttackDamageHalvedDEFVsPlant
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 90 DevilCut; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_DevilCut::
    call AttackDamageHalvedDEFVsDemon
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 91 ZombieCut; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_ZombieCut::
    call AttackDamageHalvedDEFVsZombie
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 92 CleanCut; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_CleanCut::
    call AttackDamageHalvedDEFVsMaterial
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 93 AquaCut; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_AquaCut::
    call AttackDamageHalvedDEFVsWater
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 94 MetalCut; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_MetalCut::
    call AttackDamageTimes1_5IfSlotDamageFlagsBit0
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 95 PoisonHit, 96 Paralyze, 97 NapAttack; the misaligned decoding before E-0126 hid
; this entry; the body is not interpreted (E-0126)
; code: calls ActionEffect_Fight (E-0347)
ActionEffect_PoisonHit::
    call ActionEffect_Fight
    ret

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 98 SquallHit; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_SquallHit::
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

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 99 BiAttack, 100 QuadHits; the misaligned decoding before E-0126 hid this entry; the
; body is not interpreted (E-0126)
; code: calls ActionEffect_BiAttack_ShiftHLRight1; continues in
; UnreferencedStoreResolveMessage35D0_Bank36 (E-0347)
ActionEffect_BiAttack::
    call ActionEffect_BiAttack_ShiftHLRight1
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 101 RainSlash; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_RainSlash::
    call ComputeAttackDamage
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    ld a, [wBattleTarget]
    and $03
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

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 102 MultiCut; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_MultiCut::
    call ActionEffect_MultiCut_LoadSkillRecord
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 103 GigaSlash; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_GigaSlash::
    call SkillDamageScaledByGigaSlashResistance
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 104 ChargeUp; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_ChargeUp::
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    ld a, [hl]
    or $03
    ld [hl], a
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 105 PsycheUp; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls ComputeAttackDamage; calls ScaleHLBy3Over2; copies L to wBattleDamageLo; copies H to
; wBattleDamageHi; continues in UnreferencedStoreResolveMessage35D0_Bank36 (E-0347)
ActionEffect_PsycheUp::
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

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 106 HighJump; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: changes HL and A; may continue in ActionEffect_HighJump_Skip; continues in
; SetSubPhase2AndResetResolveStep_CheckOriginalTarget (E-0347)
ActionEffect_HighJump::
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    ld a, [hl]
    and $0c
    jr nz, ActionEffect_HighJump_Skip
    ld a, [hl]
    or $0c
    ld [hl], a
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; Takes HL; changes A; continues in ActionEffect_PsycheUp (E-0347)
; why: part of ActionEffect_HighJump; ActionEffect_HighJump: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 106
; HighJump (E-0352, E-0084)
ActionEffect_HighJump_Skip::
    ld a, [hl]
    and $f3
    ld [hl], a
    jr ActionEffect_PsycheUp

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 107 EvilSlash; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls CheckSlotStatusBlock; calls AdvanceRandom; branches on wRandomLo; clears
; BSTAT2_CRITICAL_ROLLED of wBattleStatus2; calls GetBattleATK; calls RandomWithin5PercentOfHL;
; copies E to wBattleDamageLo; copies D to wBattleDamageHi; continues in
; UnreferencedStoreResolveMessage35D0_Bank36_SetResolveMsgActor; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget (E-0347)
ActionEffect_EvilSlash::
    ld a, [wBattleTarget]
    call CheckSlotStatusBlock
    jr c, .read_battle_actor
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $a0
    jr c, .skip

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    res BSTAT2_CRITICAL_ROLLED, [hl]
    ld a, [wBattleActor]
    call GetBattleATK
    call RandomWithin5PercentOfHL
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wBattleDamageHi], a
    lb hl, $d2, $35
    lb bc, $80, $a8
    jp UnreferencedStoreResolveMessage35D0_Bank36_SetResolveMsgActor

.skip:
    ld h, $d2
    lb bc, $00, $80
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 108 Massacre; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: clears BSTAT2_CRITICAL_ROLLED of wBattleStatus2; calls GetBattleATK; calls
; RandomWithin5PercentOfHL; copies E to wBattleDamageLo; copies D to wBattleDamageHi; continues in
; UnreferencedStoreResolveMessage35D0_Bank36_SetResolveMsgActor (E-0347)
ActionEffect_Massacre::
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    res BSTAT2_CRITICAL_ROLLED, [hl]
    ld a, [wBattleActor]
    call GetBattleATK
    call RandomWithin5PercentOfHL
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wBattleDamageHi], a
    lb hl, $b5, $35
    lb bc, $80, $a8
    jp UnreferencedStoreResolveMessage35D0_Bank36_SetResolveMsgActor

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 109 TwinSlash; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: clears BSTAT2_CRITICAL_ROLLED of wBattleStatus2; calls ActionEffect_PsycheUp (E-0347)
ActionEffect_TwinSlash::
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    res BSTAT2_CRITICAL_ROLLED, [hl]
    call ActionEffect_PsycheUp
    ret

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 110 Berserker; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: sets BSTAT6_BERSERK of wBattleStatus6; clears BSTAT2_CRITICAL_ROLLED of wBattleStatus2;
; calls ComputeAttackDamage; copies L to wBattleDamageLo; copies H to wBattleDamageHi; continues in
; UnreferencedStoreResolveMessage35D0_Bank36 (E-0347)
ActionEffect_Berserker::
    ld a, [wBattleActor]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    set BSTAT6_BERSERK, [hl]
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    res BSTAT2_CRITICAL_ROLLED, [hl]
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

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 111 Ramming; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_Ramming::
    call DamageEightyPercentOfTargetHPScaled
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 112 Kamikaze; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_Kamikaze::
    call ActionEffect_Kamikaze_HLToBattleStatus8EntryOfBattleTarget_Bank36
    jp ActionEffect_ActionCF_Skip

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 114 PalsyAir; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: branches on wBattleStatus; calls RollVsPalsyAirResistance; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget; sets bit 6 of wBattleStatus;
; continues in ClearDamageAndStoreResolveMsgFlags_Bank36; continues in
; SetSubPhase2AndResetResolveStep_CheckOriginalTarget; also changes HL, BC and A by register
; arithmetic (E-0347)
ActionEffect_PalsyAir::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit BSTAT0_PARALYZED, [hl]
    jr nz, .skip2
    push hl
    call RollVsPalsyAirResistance
    pop hl
    jr c, .skip
    ld h, $b5
    lb bc, $08, $88
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

.skip:
    set 6, [hl]
    ld l, $76
    lb bc, $40, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip2:
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 115 PoisonGas, 116 PoisonAir; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: branches on wBattleActionId; branches on wBattleStatus; calls RollVsPoisonGasResistance;
; continues in ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget; branches on
; wBattleActionId; sets bit 0 of wBattleStatus; clears bit 1 of wBattleStatus; sets bit 1 of
; wBattleStatus; clears bit 0 of wBattleStatus; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36; continues in
; SetSubPhase2AndResetResolveStep_CheckOriginalTarget; also changes HL, BC and A by register
; arithmetic (E-0347)
ActionEffect_PoisonGas::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [wBattleActionId]
    cp SKILL_POISONAIR
    jr z, .skip
    ld a, [hl]
    and $03
    jr nz, .skip4
    jr .call_roll_vs_poison_gas_resistance

.skip:
    bit 1, [hl]
    jr nz, .skip4

.call_roll_vs_poison_gas_resistance:
    push hl
    call RollVsPoisonGasResistance
    pop hl
    jr c, .check_battle_action_id
    ld h, $b5
    lb bc, $08, $88
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

.check_battle_action_id:
    ld a, [wBattleActionId]
    cp SKILL_POISONAIR
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
    lb bc, $40, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip4:
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 117 Curse; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: branches on wBattleStatus; calls
; ActionEffect_Curse_HLToBattleStatus8EntryOfBattleTarget_Bank36; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget; sets bit 5 of wBattleStatus;
; continues in ClearDamageAndStoreResolveMsgFlags_Bank36; continues in
; SetSubPhase2AndResetResolveStep_CheckOriginalTarget; also changes HL, BC and A by register
; arithmetic (E-0347)
ActionEffect_Curse::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit BSTAT0_CURSED, [hl]
    jr nz, .skip2
    push hl
    call ActionEffect_Curse_HLToBattleStatus8EntryOfBattleTarget_Bank36
    pop hl
    jr c, .skip
    ld h, $b5
    lb bc, $08, $88
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

.skip:
    set 5, [hl]
    ld l, $d9
    lb bc, $40, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip2:
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 118 OddDance; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls RollVsRobMagicResistance; may continue in
; ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2; calls DrainTargetMPAmount; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor; continues in
; SetSubPhase2AndResetResolveStep_CheckOriginalTarget; also changes HL, BC and A by register
; arithmetic (E-0347)
ActionEffect_OddDance::
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    ld a, [hli]
    or [hl]
    jr z, .skip
    call RollVsRobMagicResistance
    jp nc, ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2
    call DrainTargetMPAmount
    ld l, $57
    lb bc, $40, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

.skip:
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 122 LureDance; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls TargetStatus3Address; calls RollVsLegSweepResistance; calls TargetStatus3Address;
; calls ClearTargetStatus5Bits23And7Bits012; continues in ClearDamageAndStoreResolveMsgFlags_Bank36;
; continues in ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2; continues in
; SetSubPhase2AndResetResolveStep_CheckOriginalTarget (E-0347)
ActionEffect_LureDance::
    call TargetStatus3Address
    bit BSTAT3_DANCING, [hl]
    jr nz, .skip2
    call RollVsLegSweepResistance
    jr nc, .skip
    call TargetStatus3Address
    set BSTAT3_DANCING, [hl]
    call ClearTargetStatus5Bits23And7Bits012
    ld l, $58
    lb bc, $00, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2

.skip2:
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 123 LifeDance; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: branches on wMultiHitCount; calls AdvanceRandom; shows battle text 'But nothing happened!';
; sets wBattleSubPhase to 1; sets wBattleResolveStep to $0e; sets wBattleSubStep to 0; sets bit 0 of
; wBattleScreenFlags; calls ActionEffect_Farewell (E-0347)
ActionEffect_LifeDance::
    ld a, [wMultiHitCount]
    or a
    jr nz, .call_action_effect_farewell
    call AdvanceRandom
    ld a, [wRandomLo]
    and $01
    jr nz, .call_action_effect_farewell
    ld d, $cc ; battle text 'But nothing happened!'
    farcall ShowBattleText
    ld a, $01
    ld [wBattleSubPhase], a
    ld a, $0e
    ld [wBattleResolveStep], a
    ld a, $00
    ld [wBattleSubStep], a
    ld hl, wBattleScreenFlags
    set 0, [hl]
    ret

.call_action_effect_farewell:
    call ActionEffect_Farewell
    ret

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 125 SideStep; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls AdvanceRandom; continues in SetSubPhase2AndResetResolveStep_CheckOriginalTarget; also
; changes HL, A and B by register arithmetic (E-0347)
ActionEffect_SideStep::
    call AdvanceRandom
    ld a, [wBattleActor]
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hl]
    and $0c
    jr nz, .skip
    ld a, [wRandomLo]
    and $04
    add $04
    ld b, a
    ld a, [hl]
    and $f3
    or b
    ld [hl], a

.skip:
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 126 SandStorm; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: changes D; continues in ActionEffect_Radiant_ReadBattleTarget (E-0347)
ActionEffect_SandStorm::
    ld d, $02
    jr ActionEffect_Radiant_ReadBattleTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 127 Radiant; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: changes D (E-0347)
ActionEffect_Radiant::
    ld d, $01

; Branches on wBattleStatus1; calls RollVsRadiantResistance; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget; continues in
; SetSubPhase2AndResetResolveStep_CheckOriginalTarget; also changes HL, DE, BC and A by register
; arithmetic (E-0347)
; why: part of ActionEffect_Radiant; ActionEffect_Radiant: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 127
; Radiant (E-0352, E-0084)
ActionEffect_Radiant_ReadBattleTarget::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hl]
    and d
    jr nz, .skip2
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_BLINDED, [hl]
    jr nz, .skip2
    push de
    call RollVsRadiantResistance
    pop de
    jr nc, .skip
    ld a, [wBattleTarget]
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hl]
    or d
    ld [hl], a
    ld a, [wBattleActionId]
    sub $2a
    ld l, a
    lb bc, $00, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    ld h, $b5
    lb bc, $08, $88
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

.skip2:
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 128 EerieLite; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: branches on wBattleStatus8; calls
; ActionEffect_EerieLite_HLToBattleStatus8EntryOfBattleTarget_Bank36; sets BSTAT8_EERIE_LITE of
; wBattleStatus8; continues in ClearDamageAndStoreResolveMsgFlags_Bank36; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget; also changes HL, BC and A by
; register arithmetic (E-0347)
ActionEffect_EerieLite::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus8
    call AddAx9ToHL
    bit BSTAT8_EERIE_LITE, [hl]
    jr nz, .skip2
    call ActionEffect_EerieLite_HLToBattleStatus8EntryOfBattleTarget_Bank36
    jr nc, .skip
    ld a, [wBattleTarget]
    ld hl, wBattleStatus8
    call AddAx9ToHL
    set BSTAT8_EERIE_LITE, [hl]
    ld l, $d5
    lb bc, $00, $98
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    ld h, $b5
    lb bc, $08, $88
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

.skip2:
    ld h, $cc
    lb bc, $00, $84
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 129 Surge; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls ActionEffect_Surge_SetTargetSlotMarksTo3; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36 (E-0347)
ActionEffect_Surge::
    farcall ActionEffect_Surge_SetTargetSlotMarksTo3
    ld l, $60
    lb bc, $00, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 130 UltraDown; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls RollVsBeatResistance; calls ActionEffect_UltraDown_ReadBattleTarget; calls
; ActionEffect_UltraDown_SetSlotStatus6Bit7; sets wBattleSubStep to 0; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget (E-0347)
ActionEffect_UltraDown::
    call RollVsBeatResistance
    jr nc, .skip
    call ActionEffect_UltraDown_ReadBattleTarget
    jr nc, .skip
    call ActionEffect_UltraDown_SetSlotStatus6Bit7
    xor a
    ld [wBattleSubStep], a
    ret

.skip:
    ld h, $b5
    lb bc, $00, $80
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 131 DeMagic, 132 ThickFog, $B3; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls ActionEffect_DeMagic_SetTargetSlotMarksTo3; sets wBattleSubStep to 0; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36 (E-0347)
ActionEffect_DeMagic::
    farcall ActionEffect_DeMagic_SetTargetSlotMarksTo3
    xor a
    ld [wBattleSubStep], a
    ld l, $5e
    lb bc, $00, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 133 TatsuCall, 134 DiagoCall, 135 SamsiCall, 136 BazooCall; ids
; below 175 are skills named from StringTable_SkillNames; the body is not interpreted (E-0084)
; code: branches on wSideFlags0; calls AdvanceRandom; branches on wRandomLo; sets bit 2 of
; wPersonalityActs; sets wLoadSlot; calls ActionEffect_TatsuCall_AddAx9ToHL; copies wLoadSlot to
; wBattleTarget; continues in ClearDamageAndStoreResolveMsgFlags_Bank36; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget; also changes HL, BC and A by
; register arithmetic (E-0347)
ActionEffect_TatsuCall::
    ld a, [wBattleActor]
    rrca
    rrca
    and $01
    ld hl, wSideFlags0
    add_a_to_hl
    bit 2, [hl]
    jr nz, .skip2
    push hl
    ld a, [wBattleActor]
    ld hl, wPersonalityActs
    add a
    add_a_to_hl
    ld a, [hl]
    pop hl
    and $04
    jr nz, .check_battle_actor
    call AdvanceRandom
    ld a, $c0
    ld b, a
    ld a, [wRandomLo]
    cp b
    jr nc, .skip

.check_battle_actor:
    set 2, [hl]
    ld a, [wBattleActor]
    and $04
    or $03
    ld [wLoadSlot], a
    ld a, [wBattleActionId]
    sub $07
    ld c, a
    ld b, $00
    ld a, [wLoadSlot]
    srl a
    srl a
    and $01
    add a
    ld hl, wSpecialSlotMonsters
    add_a_to_hl
    ld [hl], c
    inc hl
    ld [hl], b
    call ActionEffect_TatsuCall_AddAx9ToHL
    ld a, [wLoadSlot]
    ld [wBattleTarget], a
    ld l, $61
    lb bc, $00, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    ld h, $72
    lb bc, $00, $80
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

.skip2:
    ld h, $cc
    lb bc, $00, $84
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 137 SuckAir; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: changes HL and A; continues in SetSubPhase2AndResetResolveStep_CheckOriginalTarget (E-0347)
ActionEffect_SuckAir::
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    ld a, [hl]
    or $30
    ld [hl], a
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 138 Focus; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: sets BSTAT4_FOCUS of wBattleStatus4; continues in
; SetSubPhase2AndResetResolveStep_CheckOriginalTarget (E-0347)
ActionEffect_Focus::
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    set BSTAT4_FOCUS, [hl]
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 139 LushLicks, 140 SickLick; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls TargetStatus3Address; branches on wBattleActionId; calls RollVsLegSweepResistance;
; calls RollVsSapResistance; calls TargetStatus3Address; calls ClearTargetStatus5Bits23And7Bits012;
; branches on wBattleActionId; sets wBattleDEF to 0; calls SetSlotStatus6Bit7; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget; continues in
; SetSubPhase2AndResetResolveStep_CheckOriginalTarget; then 1 more step (see the code) (E-0347)
ActionEffect_LushLicks::
    call TargetStatus3Address
    bit BSTAT3_SHIVERING, [hl]
    jr nz, .skip3
    ld a, [wBattleActionId]
    cp SKILL_SICKLICK
    jr z, .call_roll_vs_sap_resistance
    call RollVsLegSweepResistance
    jr .skip

.call_roll_vs_sap_resistance:
    call RollVsSapResistance

.skip:
    jr nc, .skip2
    call TargetStatus3Address
    set BSTAT3_SHIVERING, [hl]
    call ClearTargetStatus5Bits23And7Bits012
    ld a, [wBattleActionId]
    cp SKILL_LUSHLICKS
    jr z, .read_battle_action_id
    ld a, [wBattleTarget]
    ld hl, wBattleDEF
    call AddDoubleAToHL_Bank36
    ld a, $01
    ld [hli], a
    ld [hl], $00
    ld a, [wBattleTarget]
    call SetSlotStatus6Bit7

.read_battle_action_id:
    ld a, [wBattleActionId]
    sub $31
    ld l, a
    lb bc, $00, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip2:
    ld h, $71
    lb bc, $08, $88
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

.skip3:
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 141 LegSweep, 142 BigTrip; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls TargetStatus3Address; may continue in
; SetSubPhase2AndResetResolveStep_CheckOriginalTarget; calls
; ActionEffect_LegSweep_RollVsLegSweepResistance; calls TargetStatus3Address; calls
; ClearTargetStatus5Bits23And7Bits012; continues in ClearDamageAndStoreResolveMsgFlags_Bank36;
; branches on wSlotBodyFlags; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget; also changes HL, BC and A by
; register arithmetic (E-0347)
ActionEffect_LegSweep::
    call TargetStatus3Address
    bit BSTAT3_TRIPPED, [hl]
    jp nz, SetSubPhase2AndResetResolveStep_CheckOriginalTarget
    call ActionEffect_LegSweep_RollVsLegSweepResistance
    jr nc, .read_battle_target
    call TargetStatus3Address
    set BSTAT3_TRIPPED, [hl]
    call ClearTargetStatus5Bits23And7Bits012
    ld l, $5d
    lb bc, $00, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.read_battle_target:
    ld a, [wBattleTarget]
    ld hl, wSlotBodyFlags
    add_a_to_hl
    bit 4, [hl]
    ld h, $70
    jr z, .skip
    ld h, $68

.skip:
    lb bc, $00, $80
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 143 Ahhh; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls TargetStatus3Address; calls RollVsLegSweepResistance; calls TargetStatus3Address;
; calls ClearTargetStatus5Bits23And7Bits012; continues in ClearDamageAndStoreResolveMsgFlags_Bank36;
; continues in ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget; continues in
; SetSubPhase2AndResetResolveStep_CheckOriginalTarget (E-0347)
ActionEffect_Ahhh::
    call TargetStatus3Address
    bit BSTAT3_VACANT, [hl]
    jr nz, .skip2
    call RollVsLegSweepResistance
    jr nc, .skip
    call TargetStatus3Address
    set BSTAT3_VACANT, [hl]
    call ClearTargetStatus5Bits23And7Bits012
    ld l, $59
    lb bc, $00, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    ld h, $b5
    lb bc, $08, $88
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

.skip2:
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 144 WarCry; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls TargetStatus3Address; calls RollVsLegSweepResistance; calls TargetStatus3Address;
; calls ClearTargetStatus5Bits23And7Bits012; continues in ClearDamageAndStoreResolveMsgFlags_Bank36;
; continues in ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget; continues in
; SetSubPhase2AndResetResolveStep_CheckOriginalTarget (E-0347)
ActionEffect_WarCry::
    call TargetStatus3Address
    bit BSTAT3_COWERING, [hl]
    jr nz, .skip2
    call RollVsLegSweepResistance
    jr nc, .skip
    call TargetStatus3Address
    set BSTAT3_COWERING, [hl]
    call ClearTargetStatus5Bits23And7Bits012
    ld l, $5c
    lb bc, $00, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    ld h, $6b
    lb bc, $00, $80
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

.skip2:
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 145 Geyser; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: may continue in ActionEffect_Geyser_Skip; calls
; ActionEffect_Geyser_HLToBattleStatus8EntryOfBattleTarget_Bank36; sets wPersonalityActs to 0; shows
; battle text '0 was blown sky-high!'; continues in SetSubPhase2AndResetResolveStep; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget; also changes HL, BC, A and D by
; register arithmetic (E-0347)
ActionEffect_Geyser::
    ld a, [wBattleActor]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl]
    and $c0
    cp $40
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
    add a
    ld hl, wPersonalityActs
    add_a_to_hl
    ld [hl], $00
    ld d, $dd ; battle text '0 was blown sky-high!'
    farcall ShowBattleText
    jp SetSubPhase2AndResetResolveStep

.skip:
    ld h, $6e
    lb bc, $00, $80
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; Copies wBattleActor to wBattleTarget; branches on wBattleStatus; calls AdvanceRandom; calls
; GetBattleMaxHP; calls ActionEffect_Geyser_ScaleHLTo60Percent; calls
; ActionEffect_Geyser_ScaleHLTo80Percent_Bank36; calls RandomInRange; copies E to wBattleDamageLo;
; copies D to wBattleDamageHi; continues in
; UnreferencedStoreResolveMessage35D0_Bank36_SetResolveMsgActor; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget; also changes HL, DE, BC and A by
; register arithmetic (E-0347)
; why: part of ActionEffect_Geyser; ActionEffect_Geyser: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 145 Geyser
; (E-0352, E-0084)
ActionEffect_Geyser_Skip::
    ld a, [hl]
    and $3f
    ld [hl], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit BSTAT0_PARALYZED, [hl]
    jr nz, .read_battle_actor
    bit BSTAT0_ASLEEP, [hl]
    jr nz, .read_battle_actor
    call AdvanceRandom
    ld a, [wRandomLo]
    and $01
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
    or e
    jr nz, .set_battle_damage_lo
    ld de, $0001

.set_battle_damage_lo:
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wBattleDamageHi], a
    lb hl, $d0, $ad
    lb bc, $88, $a8
    jp UnreferencedStoreResolveMessage35D0_Bank36_SetResolveMsgActor

.skip:
    ld h, $af
    lb bc, $00, $80
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 146 DanceShut; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: may continue in SetSubPhase2AndResetResolveStep_CheckOriginalTarget; calls
; ActionEffect_DanceShut_HLToBattleStatus8EntryOfBattleTarget_Bank36; sets BSTAT1_DANCE_SEALED of
; wBattleStatus1; continues in ClearDamageAndStoreResolveMsgFlags_Bank36; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2; also changes HL, BC and A by register arithmetic
; (E-0347)
ActionEffect_DanceShut::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_DANCE_SEALED, [hl]
    jp nz, SetSubPhase2AndResetResolveStep_CheckOriginalTarget
    call ActionEffect_DanceShut_HLToBattleStatus8EntryOfBattleTarget_Bank36
    jr nc, .skip
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    set BSTAT1_DANCE_SEALED, [hl]
    ld l, $de
    lb bc, $40, $98
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 147 MouthShut; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: branches on wBattleStatus1; calls
; ActionEffect_MouthShut_HLToBattleStatus8EntryOfBattleTarget_Bank36; sets BSTAT1_BREATH_SEALED of
; wBattleStatus1; continues in ClearDamageAndStoreResolveMsgFlags_Bank36; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2; continues in
; SetSubPhase2AndResetResolveStep_CheckOriginalTarget; also changes HL, BC and A by register
; arithmetic (E-0347)
ActionEffect_MouthShut::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_BREATH_SEALED, [hl]
    jr nz, .skip2
    call ActionEffect_MouthShut_HLToBattleStatus8EntryOfBattleTarget_Bank36
    jr nc, .skip
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    set BSTAT1_BREATH_SEALED, [hl]
    ld l, $64
    lb bc, $40, $98
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2

.skip2:
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 148 StrongD, 150 BladeD; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: changes HL and A; branches on wBattleActionId; continues in
; SetSubPhase2AndResetResolveStep_CheckOriginalTarget (E-0347)
ActionEffect_StrongD::
    ld a, [wBattleActor]
    ld hl, wBattleStatus7
    call AddAx9ToHL
    ld a, [wBattleActionId]
    cp SKILL_BLADED
    jr z, .skip2
    cp $e0
    jr nz, .skip
    ld a, [hl]
    and $f0
    or $0c
    ld [hl], a
    jr .skip3

.skip:
    ld a, [hl]
    and $f0
    or $02
    ld [hl], a
    jr .skip3

.skip2:
    ld a, [hl]
    and $f0
    or $04
    ld [hl], a

.skip3:
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 149 Dodge; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: sets BSTAT6_DODGE of wBattleStatus6; continues in
; SetSubPhase2AndResetResolveStep_CheckOriginalTarget (E-0347)
ActionEffect_Dodge::
    ld a, [wBattleActor]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    set BSTAT6_DODGE, [hl]
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 151 Cover, 152 Guardian; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: may continue in SetSubPhase2AndResetResolveStep_CheckOriginalTarget; branches on
; wBattleActionId; sets bit 4 of wSideFlags0; calls CarryUnlessBattleSlotOutSlotEmpty; branches on
; C; branches on wBattleStatus6; sets BSTAT6_GUARDED of wBattleStatus6; branches on wBattleStatus6;
; continues in SetSubPhase2AndResetResolveStep_CheckOriginalTarget; also changes HL, BC and A by
; register arithmetic (E-0347)
ActionEffect_Cover::
    ld a, [wBattleTarget]
    rrca
    rrca
    and $01
    ld hl, wSideFlags0
    add_a_to_hl
    bit 4, [hl]
    jp nz, SetSubPhase2AndResetResolveStep_CheckOriginalTarget
    ld a, [wBattleActionId]
    cp SKILL_GUARDIAN
    jr z, .check_battle_target
    ld a, [wBattleTarget]
    ld c, a
    ld b, $01
    jr .loop

.check_battle_target:
    set 4, [hl]
    ld a, [wBattleTarget]
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleActor
    cp [hl]
    jr z, .next
    ld hl, wBattleStatus6
    call AddAx9ToHL
    bit BSTAT6_GUARDED, [hl]
    jr nz, .next
    set BSTAT6_GUARDED, [hl]
    inc hl
    ld a, [wBattleActor]
    and $0f
    swap a
    or [hl]
    ld [hl], a

.next:
    inc c
    dec b
    jr nz, .loop
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 153 TailWind, 154 StormWind; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: branches on wBattleActionId; sets BSTAT2_WIND_GUARD of wBattleStatus2; calls
; CarryUnlessBattleSlotOutSlotEmpty; sets BSTAT2_WIND_GUARD of wBattleStatus2; sets bit 5 of
; wSideFlags0; continues in SetSubPhase2AndResetResolveStep_CheckOriginalTarget; also changes HL, BC
; and A by register arithmetic (E-0347)
ActionEffect_TailWind::
    ld a, [wBattleActionId]
    cp SKILL_STORMWIND
    jr z, .check_battle_target
    ld a, [wBattleTarget]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    set BSTAT2_WIND_GUARD, [hl]
    jr .skip

.check_battle_target:
    ld a, [wBattleTarget]
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus2
    call AddAx9ToHL
    set BSTAT2_WIND_GUARD, [hl]

.next:
    inc c
    dec b
    jr nz, .loop
    ld a, [wBattleTarget]
    rra
    rra
    and $01
    ld hl, wSideFlags0
    add_a_to_hl
    set 5, [hl]

.skip:
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 155 AquaWall; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: sets BSTAT2_AQUA_WALL of wBattleStatus2; continues in
; SetSubPhase2AndResetResolveStep_CheckOriginalTarget (E-0347)
ActionEffect_AquaWall::
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    set BSTAT2_AQUA_WALL, [hl]
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 156 SealPray; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: sets BSTAT8_SEAL_PRAY of wBattleStatus8; continues in
; SetSubPhase2AndResetResolveStep_CheckOriginalTarget (E-0347)
ActionEffect_SealPray::
    ld a, [wBattleActor]
    ld hl, wBattleStatus8
    call AddAx9ToHL
    set BSTAT8_SEAL_PRAY, [hl]
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 157 SuckAll; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: may continue in SetSubPhase2AndResetResolveStep_CheckOriginalTarget; sets bit 6 of
; wSideFlags0; sets BSTAT6_SUCK_ALL of wBattleStatus6; continues in
; SetSubPhase2AndResetResolveStep_CheckOriginalTarget; also changes HL, A and B by register
; arithmetic (E-0347)
ActionEffect_SuckAll::
    ld a, [wBattleActor]
    rrca
    rrca
    and $01
    ld b, a
    ld hl, wSideFlags0
    add_a_to_hl
    bit 6, [hl]
    jp nz, SetSubPhase2AndResetResolveStep_CheckOriginalTarget
    set 6, [hl]
    ld a, b
    ld hl, wSlotPairBytes
    add_a_to_hl
    ld a, [wBattleActor]
    and $03
    rla
    rla
    or [hl]
    ld [hl], a
    ld a, [wBattleActor]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    set BSTAT6_SUCK_ALL, [hl]
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 158 Imitate; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: sets BSTAT6_IMITATE of wBattleStatus6; continues in
; SetSubPhase2AndResetResolveStep_CheckOriginalTarget (E-0347)
ActionEffect_Imitate::
    ld a, [wBattleActor]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    set BSTAT6_IMITATE, [hl]
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 159 Meditate; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_Meditate::
    call ActionEffect_Meditate_AddDoubleAToHL_Bank36
    jr nc, .skip
    ld l, $37
    lb bc, $40, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

.skip:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_Skip

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 160 LifeSong; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_LifeSong::
    ld a, [wBattleActor]
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hl]
    and $10
    jr nz, ActionEffect_LifeSong_CheckMultiHitCount
    ld a, [hl]
    and $cf
    or $20
    ld [hl], a
    jp SetSubPhase7AndResetResolveStep

; Branches on wMultiHitCount; calls AdvanceRandom; branches on wRandomLo; shows battle text 'But the
; prayer went unanswered!'; continues in SetSubPhase7AndResetResolveStep; calls
; CarryUnlessBattleSlotOutSlotEmpty; branches on wBattleTarget & $03; calls ApplyTargetMaxHPAmount;
; continues in SetSubPhase2AndResetResolveStep_CheckOriginalTarget; also changes A and D by register
; arithmetic (E-0347)
; why: part of ActionEffect_LifeSong; ActionEffect_LifeSong: effect routine reached through
; ActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 160 LifeSong
; (E-0352, E-0126)
ActionEffect_LifeSong_CheckMultiHitCount::
    ld a, [wMultiHitCount]
    or a
    jr nz, .read_battle_target
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $80
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
    and $03
    cp $03
    jr z, .skip
    call ApplyTargetMaxHPAmount
    ret

.skip:
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 161 LoveRain; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: may continue in ActionEffect_LoveRain_CheckLoveRainFlag; calls AdvanceRandom; sets bit 1 of
; wHealFlags; continues in SetSubPhase7AndResetResolveStep; also changes HL and A by register
; arithmetic (E-0347)
ActionEffect_LoveRain::
    ld a, [wBattleActor]
    ld hl, wBattleStatus8
    call AddAx9ToHL
    ld a, [hl]
    and $01
    jr nz, ActionEffect_LoveRain_CheckLoveRainFlag
    push hl
    call AdvanceRandom
    ld a, [wRandomLo]
    and $0f
    ld hl, ActionEffect_LoveRain_Data
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

; Branches on wLoveRainFlag; calls ActionEffect_Heal; continues in SetSubPhase7AndResetResolveStep
; (E-0347)
; why: part of ActionEffect_LoveRain; ActionEffect_LoveRain: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 161
; LoveRain (E-0352, E-0084)
ActionEffect_LoveRain_CheckLoveRainFlag::
    ld a, [wLoveRainFlag]
    or a
    jr z, .to_set_sub_phase7_and_reset_resolve_step
    call ActionEffect_Heal
    ret

.to_set_sub_phase7_and_reset_resolve_step:
    jp SetSubPhase7AndResetResolveStep

; data read by ActionEffect_LoveRain (16 bytes) (E-0347)
ActionEffect_LoveRain_Data::
    db $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $01, $01, $02, $02, $02, $02

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 162 Whistle, 163 Pheromone, 164 StepGuard, 165 Outside, 166 Informer, 167 Errand
; ...; the misaligned decoding before E-0126 hid this entry; the body is not interpreted (E-0126)
; code: returns at once (E-0347)
ActionEffect_Whistle::
    ret

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 170 Ahhh; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126) (E-0344: the address in its name dropped or read as the label there; was
; ActionEffect_Ahhh_2)
ActionEffect_Ahhh_2::
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

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 172 Guard; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_Guard::
    ld a, [wBattleActor]
    ld hl, wBattleStatus7
    call AddAx9ToHL
    ld a, [hl]
    and $f0
    or $01
    ld [hl], a
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $B0, $B2; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: may continue in SetSubPhase2AndResetResolveStep_CheckOriginalTarget; branches on
; wBattleTarget; sets wBattleSlotOut to $ff; calls BlankTargetMonsterPicture; branches on
; wBattleActionId; shows battle text '0 fled!'; plays sound $82; continues in
; SetSubPhase2AndResetResolveStep_CheckOriginalTarget; branches on wBattleActionId; shows battle
; text '0 was shocked!'; continues in SetSubPhase2AndResetResolveStep_CheckOriginalTarget; also
; changes HL, A, B and D by register arithmetic (E-0347)
ActionEffect_ActionB0::
    ld a, [wLinkMode]
    or a
    jp nz, SetSubPhase2AndResetResolveStep_CheckOriginalTarget
    ld a, [wBattleActor]
    cp $04
    jp nc, SetSubPhase2AndResetResolveStep_CheckOriginalTarget
    ld a, [wBattleTarget]
    cp $04
    jr c, .check_battle_action_id
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank36
    xor a
    ld [hli], a
    ld [hl], a
    ld a, [wBattleTarget]
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld [hl], $ff
    ld a, [wBattleTarget]
    and $03
    ld hl, wBattleSlotTriples
    ld b, a
    add a
    add b
    add_a_to_hl
    xor a
    ld [hli], a
    ld [hli], a
    ld [hl], a
    farcall BlankTargetMonsterPicture
    ld a, [wBattleActionId]
    cp SKILL_HIGHJUMP_B2
    ld d, $8f
    jr z, .call_show_battle_text
    ld d, $d8 ; battle text '0 fled!'
    farcall ShowBattleText
    ld a, $82
    call QueueSoundEffect
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

.check_battle_action_id:
    ld a, [wBattleActionId]
    cp SKILL_HIGHJUMP_B2
    ld d, $8f
    jr z, .call_show_battle_text
    ld d, $5c ; battle text '0 was shocked!'

.call_show_battle_text:
    farcall ShowBattleText
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $B4; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: calls CarryUnlessBattleSlotOutSlotEmpty; sets BSTAT1_CRITICAL of wBattleStatus1; continues
; in SetSubPhase2AndResetResolveStep_CheckOriginalTarget; also changes HL, BC and A by register
; arithmetic (E-0347)
ActionEffect_ActionB4::
    ld a, [wBattleActor]
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    set BSTAT1_CRITICAL, [hl]

.next:
    inc c
    dec b
    jr nz, .loop
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $B5; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: calls TargetOnLocalSide_Bank36; continues in ClearDamageAndStoreResolveMsgFlags_Bank36;
; continues in ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget; also changes HL, BC
; and A by register arithmetic (E-0347)
ActionEffect_ActionB5::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and $8c
    jr nz, .skip2
    ld a, [hl]
    or $8c
    ld [hl], a
    call TargetOnLocalSide_Bank36
    ld l, $73
    jr nc, .skip
    ld l, $74

.skip:
    lb bc, $40, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip2:
    ld h, $d4
    lb bc, $00, $80
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $B6; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: changes HL, BC and A; may continue in SetSubPhase2AndResetResolveStep_CheckOriginalTarget;
; continues in ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor (E-0347)
ActionEffect_ActionB6::
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    ld a, [hli]
    or [hl]
    jp z, SetSubPhase2AndResetResolveStep_CheckOriginalTarget
    xor a
    ld [hld], a
    ld [hl], a
    ld l, $df
    lb bc, $40, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 185; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_ActionB9::
    call AttackDamageWithATK200
    jp UnreferencedStoreResolveMessage35D0_Bank36

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $BA; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: calls TargetStatus3Address; may continue in
; SetSubPhase2AndResetResolveStep_CheckOriginalTarget; calls ClearTargetStatus5Bits23And7Bits012;
; continues in ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor (E-0347)
ActionEffect_ActionBA::
    call TargetStatus3Address
    bit BSTAT3_FROZEN, [hl]
    jp nz, SetSubPhase2AndResetResolveStep_CheckOriginalTarget
    set 0, [hl]
    call ClearTargetStatus5Bits23And7Bits012
    ld l, $78
    lb bc, $00, $98
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $BC; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: changes HL, BC and A; may continue in SetSubPhase2AndResetResolveStep_CheckOriginalTarget;
; continues in ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor (E-0347)
ActionEffect_ActionBC::
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    push hl
    ld a, [hli]
    ld b, [hl]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wBattleMaxMP
    call AddDoubleAToHL_Bank36
    deref_hl
    call CompareHLToBC
    pop bc
    jp z, SetSubPhase2AndResetResolveStep_CheckOriginalTarget
    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    ld l, $c3
    lb bc, $40, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $BD; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: branches on the byte at wBattleHP; copies L to wBattleDamageLo; copies H to wBattleDamageHi;
; continues in ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor; also changes HL, BC and
; A by register arithmetic (E-0347)
ActionEffect_ActionBD::
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank36
    ld c, l
    ld b, h
    ld a, [hli]
    cp $01
    jr nz, .skip
    ld a, [hl]
    or a
    jr nz, .skip
    ld hl, $0001
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ld l, $35
    lb bc, $88, $a8
    jr .skip2

.skip:
    ld a, $01
    ld [bc], a
    inc bc
    ld a, $00
    ld [bc], a
    ld l, $38
    lb bc, $40, $90

.skip2:
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $C0; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: calls AdvanceRandom; branches on wRandomLo; calls ComputeAttackDamage; continues in
; UnreferencedStoreResolveMessage35D0_Bank36_SetResolveMsgActor; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget (E-0347)
ActionEffect_ActionC0::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $40
    jr c, .skip
    call ComputeAttackDamage
    lb hl, $d1, $36
    lb bc, $80, $a8
    jp UnreferencedStoreResolveMessage35D0_Bank36_SetResolveMsgActor

.skip:
    ld h, $d1
    lb bc, $08, $88
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $C1; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: calls AdvanceRandom; branches on wRandomLo; calls ComputeAttackDamage; continues in
; UnreferencedStoreResolveMessage35D0_Bank36; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget (E-0347)
ActionEffect_ActionC1::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $c0
    jr c, .skip
    call ComputeAttackDamage
    jp UnreferencedStoreResolveMessage35D0_Bank36

.skip:
    ld h, $d0
    lb bc, $08, $88
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $C2; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: calls ActionEffect_Fight (E-0347)
ActionEffect_ActionC2::
    call ActionEffect_Fight
    ret

; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 171 ZoneOut, 183, 195, 196; the misaligned decoding before E-0126 hid this entry;
; the body is not interpreted (E-0126)
; code: continues in SetSubPhase2AndResetResolveStep_CheckOriginalTarget (E-0347)
ActionEffect_ZoneOut::
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $C5; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: sets BSTAT3_TRIPPED of wBattleStatus3; continues in
; SetSubPhase2AndResetResolveStep_CheckOriginalTarget (E-0347)
ActionEffect_ActionC5::
    ld a, [wBattleActor]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    set BSTAT3_TRIPPED, [hl]
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $C6, $C7; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: sets BSTAT0_PARALYZED of wBattleStatus; continues in
; ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor (E-0347)
ActionEffect_ActionC6::
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    set BSTAT0_PARALYZED, [hl]
    ld l, $76
    lb bc, $40, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $C8; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: sets wBattleSlotOut to $ff; calls TargetOnLocalSide_Bank36; calls BlankTargetMonsterPicture;
; continues in SetSubPhase2AndResetResolveStep_CheckOriginalTarget; also changes HL, A and B by
; register arithmetic (E-0347)
ActionEffect_ActionC8::
    ld a, [wBattleTarget]
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld [hl], $ff
    call TargetOnLocalSide_Bank36
    jr c, .skip
    ld a, [wBattleTarget]
    and $03
    ld hl, wBattleSlotTriples
    ld b, a
    add a
    add b
    add_a_to_hl
    xor a
    ld [hli], a
    ld [hli], a
    ld [hl], a
    farcall BlankTargetMonsterPicture

.skip:
    jp SetSubPhase2AndResetResolveStep_CheckOriginalTarget

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $C9, $CA; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: calls GetBattleHP; copies L to wBattleDamageLo; copies H to wBattleDamageHi; continues in
; UnreferencedStoreResolveMessage35D0_Bank36_SetResolveMsgActor; also changes HL, BC and A by
; register arithmetic (E-0347)
ActionEffect_ActionC9::
    ld a, [wBattleActor]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl]
    and $3f
    ld [hli], a
    ld a, [hl]
    and $f3
    ld [hl], a
    ld a, [wBattleActor]
    call GetBattleHP
    ld a, $0a
    call DivideHLByA
    ld a, h
    or l
    jr nz, .set_battle_damage_lo
    ld hl, $0001

.set_battle_damage_lo:
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    lb hl, $af, $36
    lb bc, $80, $a8
    jp UnreferencedStoreResolveMessage35D0_Bank36_SetResolveMsgActor

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $BF, $CB; ids below 175 are skills named from
; StringTable_SkillNames; the body is not interpreted (E-0084)
; code: may continue in ActionEffect_ActionC9; copies L to wBattleDamageLo; copies H to
; wBattleDamageHi; continues in UnreferencedStoreResolveMessage35D0_Bank36_SetResolveMsgActor; also
; changes HL, BC and A by register arithmetic (E-0347)
ActionEffect_ActionBF::
    ld a, [wBattleActor]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl]
    and $3f
    ld [hli], a
    ld a, [hl]
    and $f3
    ld [hl], a
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and $0c
    jr nz, ActionEffect_ActionC9
    ld hl, $0000
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    lb hl, $af, $af
    lb bc, $00, $80
    jp UnreferencedStoreResolveMessage35D0_Bank36_SetResolveMsgActor

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $CC; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: changes HL and A; continues in ActionEffect_HighJump_Skip (E-0347)
ActionEffect_ActionCC::
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    jp ActionEffect_HighJump_Skip

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $CD; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: changes HL and A; continues in ActionEffect_Geyser_Skip (E-0347)
ActionEffect_ActionCD::
    ld a, [wBattleActor]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    jp ActionEffect_Geyser_Skip

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $CE; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: continues in ActionEffect_LifeSong_CheckMultiHitCount (E-0347)
ActionEffect_ActionCE::
    jp ActionEffect_LifeSong_CheckMultiHitCount

; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $CF; ids below 175 are skills named from StringTable_SkillNames;
; the body is not interpreted (E-0084)
; code: continues in ActionEffect_LoveRain_CheckLoveRainFlag (E-0347)
ActionEffect_ActionCF::
    jp ActionEffect_LoveRain_CheckLoveRainFlag

; Changes HL and BC; continues in UnreferencedStoreResolveMessage35D0_Bank36_SetResolveMsgActor
; (E-0347)
; why: part of ActionEffect_ActionCF; ActionEffect_ActionCF: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) $CF
; (E-0352, E-0084)
ActionEffect_ActionCF_Skip::
    lb hl, $b5, $35
    lb bc, $80, $a8
    jr UnreferencedStoreResolveMessage35D0_Bank36_SetResolveMsgActor

; the same 23 bytes as UnreferencedStoreResolveMessage35D0 (UnreferencedStoreResolveMessage35D0)
; (E-0236)
UnreferencedStoreResolveMessage35D0_Bank36::
    lb hl, $d0, $35
    lb bc, $88, $a8

; Copies L to wResolveMsgActor; copies H to wResolveMsgTarget; copies C to wResolveMsgFlags; copies
; B to wResolveMsgArg (E-0347)
; why: part of UnreferencedStoreResolveMessage35D0_Bank36;
; UnreferencedStoreResolveMessage35D0_Bank36: the same 23 bytes as
; UnreferencedStoreResolveMessage35D0 (UnreferencedStoreResolveMessage35D0) (E-0352, E-0236)
UnreferencedStoreResolveMessage35D0_Bank36_SetResolveMsgActor::
    ld a, l
    ld [wResolveMsgActor], a
    ld a, h
    ld [wResolveMsgTarget], a
    ld a, c
    ld [wResolveMsgFlags], a
    ld a, b
    ld [wResolveMsgArg], a
    ret

; clears wBattleDamageLo/wBattleDamageHi (the damage word), then wResolveMsgActor = L,
; wResolveMsgFlags = C, wResolveMsgArg = B (E-0073)
ClearDamageAndStoreResolveMsgFlags_Bank36::
    xor a
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a

; Copies L to wResolveMsgActor; copies C to wResolveMsgFlags; copies B to wResolveMsgArg (E-0347)
; why: part of ClearDamageAndStoreResolveMsgFlags_Bank36; ClearDamageAndStoreResolveMsgFlags_Bank36:
; clears wBattleDamageLo/wBattleDamageHi (the damage word), then wResolveMsgActor = L,
; wResolveMsgFlags = C, wResolveMsgArg = B (E-0352, E-0073)
ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgActor::
    ld a, l
    ld [wResolveMsgActor], a
    ld a, c
    ld [wResolveMsgFlags], a
    ld a, b
    ld [wResolveMsgArg], a
    ret

; Changes BC and H; continues in ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget
; (E-0347)
; why: part of ClearDamageAndStoreResolveMsgFlags_Bank36; ClearDamageAndStoreResolveMsgFlags_Bank36:
; clears wBattleDamageLo/wBattleDamageHi (the damage word), then wResolveMsgActor = L,
; wResolveMsgFlags = C, wResolveMsgArg = B (E-0352, E-0073)
ClearDamageAndStoreResolveMsgFlags_Bank36_Skip::
    ld h, $cc
    lb bc, $00, $80
    jr ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget

; Changes BC and H (E-0347)
; why: part of ClearDamageAndStoreResolveMsgFlags_Bank36; ClearDamageAndStoreResolveMsgFlags_Bank36:
; clears wBattleDamageLo/wBattleDamageHi (the damage word), then wResolveMsgActor = L,
; wResolveMsgFlags = C, wResolveMsgArg = B (E-0352, E-0073)
ClearDamageAndStoreResolveMsgFlags_Bank36_Skip2::
    ld h, $b5
    lb bc, $00, $80

; Copies H to wResolveMsgTarget (E-0347)
; why: part of ClearDamageAndStoreResolveMsgFlags_Bank36; ClearDamageAndStoreResolveMsgFlags_Bank36:
; clears wBattleDamageLo/wBattleDamageHi (the damage word), then wResolveMsgActor = L,
; wResolveMsgFlags = C, wResolveMsgArg = B (E-0352, E-0073)
ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgTarget::
    ld a, h
    ld [wResolveMsgTarget], a

; Copies C to wResolveMsgFlags; copies B to wResolveMsgArg (E-0347)
; why: part of ClearDamageAndStoreResolveMsgFlags_Bank36; ClearDamageAndStoreResolveMsgFlags_Bank36:
; clears wBattleDamageLo/wBattleDamageHi (the damage word), then wResolveMsgActor = L,
; wResolveMsgFlags = C, wResolveMsgArg = B (E-0352, E-0073)
ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgFlags::
    ld a, c
    ld [wResolveMsgFlags], a
    ld a, b
    ld [wResolveMsgArg], a
    ret

; wBattleSubPhase = 2, wBattleResolveStep = 0 (E-0115)
SetSubPhase2AndResetResolveStep::
    ld a, $02
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    ret

; Branches on wOriginalTarget; copies wOriginalTarget to wBattleTarget; sets wOriginalTarget to $ff;
; may continue in SetSubPhase7AndResetResolveStep_Skip; sets wBattleSubPhase to 3; sets
; wBattleResolveStep to 0; also changes HL and A by register arithmetic (E-0347)
; why: part of SetSubPhase2AndResetResolveStep; SetSubPhase2AndResetResolveStep: wBattleSubPhase =
; 2, wBattleResolveStep = 0 (E-0352, E-0115)
SetSubPhase2AndResetResolveStep_CheckOriginalTarget::
    ld a, [wOriginalTarget]
    cp $ff
    jr z, .check_follow_up_action
    push hl
    ld [wBattleTarget], a
    push af
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    pop af
    ld [hl], a
    ld a, $ff
    ld [wOriginalTarget], a
    pop hl

.check_follow_up_action:
    ld a, [wFollowUpAction]
    or a
    jr nz, SetSubPhase7AndResetResolveStep_Skip
    ld a, $03
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    ret

; wBattleSubPhase = 7, wBattleResolveStep = 0 (E-0115)
SetSubPhase7AndResetResolveStep::
    ld a, $07
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    ret

; Changes BC; continues in ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgFlags (E-0347)
; why: part of SetSubPhase7AndResetResolveStep; SetSubPhase7AndResetResolveStep: wBattleSubPhase =
; 7, wBattleResolveStep = 0 (E-0352, E-0115)
SetSubPhase7AndResetResolveStep_Skip::
    lb bc, $00, $00
    jp ClearDamageAndStoreResolveMsgFlags_Bank36_SetResolveMsgFlags

; when the target's status byte 2 (wBattleStatus2) bit 2 is set, the damage word is halved (E-0118)
HalveDamageIfTargetStatus2Bit2::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit BSTAT2_DAMAGE_HALVED, [hl]
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

; the same 18 bytes as ClearDamageAndReadTargetStatus0 (ClearDamageAndReadTargetStatus0) (E-0078)
ClearDamageAndReadTargetStatus0_Bank36::
    xor a
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    ret

; A = slot: sets bit 6 of its status byte 6 (wBattleStatus6 + 9 * slot); HL kept (E-0096)
SetSlotStatus6Bit6::
    push hl
    ld hl, wBattleStatus6
    call AddAx9ToHL
    set BSTAT6_STATS_RAISED, [hl]
    pop hl
    ret

; A = slot: sets bit 7 of its status byte 6 (wBattleStatus6 + 9 * slot); HL kept (E-0115)
SetSlotStatus6Bit7::
    push hl
    ld hl, wBattleStatus6
    call AddAx9ToHL
    set BSTAT6_STATS_LOWERED, [hl]
    pop hl
    ret

; HL = wBattleStatus3 + 9 * wBattleTarget, the target's status byte 3 (E-0096)
TargetStatus3Address::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ret

; clears bits 2-3 of the target's status byte 5 (wBattleStatus5) and bits 0-2 of its status byte 7
; (E-0096)
ClearTargetStatus5Bits23And7Bits012::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hl]
    and $f3
    ld [hl], a
    inc hl
    inc hl
    ld a, [hl]
    and $f8
    ld [hl], a
    ret

; called from ActionEffect_Vivify: sets wBattleSlotOut to 0; sets wSlotMarks to 3; also changes HL,
; A and B by register arithmetic (E-0347)
; why: a helper of ActionEffect_Vivify; ActionEffect_Vivify: effect routine reached through
; DispatchActionEffectTable (ActionEffectTable, indexed by wBattleActionId) for action(s) 30 Vivify
; (E-0352, E-0084)
ActionEffect_Vivify_AddAx9ToHL::
    ld a, [wBattleTarget]
    ld b, a
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld [hl], $00
    ld a, b
    ld hl, wBattleStatus
    call AddAx9ToHL
    xor a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hl], a
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $03
    ret

; removes the first byte equal to C from the 8-byte queue at wActionQueue, shifting later bytes down
; and filling with $FF (E-0124)
RemoveCFromActionQueue::
    ld hl, wActionQueue
    ld b, $08
    ld d, $00

.loop:
    bit 0, d
    jr nz, .next
    ld a, [hl]
    cp c
    jr nz, .next2
    ld d, $01

.next:
    inc hl
    ld a, [hl]
    ld [hl], $ff
    dec hl
    ld [hl], a
    inc hl
    dec b
    jr nz, .loop
    ld [hl], $ff
    ret

.next2:
    inc hl
    dec b
    jr nz, .loop
    ret

; jumps to the handler for wBattleActionId (0, or id - $47) from the word table $7DDE (E-0124)
RunEffectHandlerForActionId::
    ld a, [wBattleActionId]
    or a
    jr z, .skip
    sub $47

.skip:
    ld hl, EffectHandlerTable
    add a
    add_a_to_hl
    call JumpToWordAtHL
    ret

; RunEffectHandlerForActionId (RunEffectHandlerForActionId) indexes it with 2 * (action id - $47),
; or 0 for action 0, and jumps through JumpToWordAtHL; all 40 words point into the bank, and
; GetBattleATK follows at $7E2E (E-0126, C1)
; record: handler
EffectHandlerTable::
    dw ComputeAttackDamage ; entry 0
    dw ActionEffect_WindBeast_ShiftBCRight1 ; entry 1
    dw ActionEffect_Vacuum_ShiftBCRight1 ; entry 2
    dw ActionEffect_Lightning_ShiftBCRight1 ; entry 3
    dw ActionEffect_RockThrow_RollSkillDamageFromRecord ; entry 4
    dw ActionEffect_Watershot_RollSkillDamageFromRecord ; entry 5
    dw ActionEffect_Watershot_RollSkillDamageFromRecord ; entry 6
    dw ActionEffect_CallHelp_WriteBattleDamageLoAndBattleDamageHi ; entry 7
    dw ActionEffect_CallHelp_WriteBattleDamageLoAndBattleDamageHi ; entry 8
    dw AttackDamageScaledByBlazeResistance ; entry 9
    dw AttackDamageScaledByVacuumResistance ; entry 10
    dw AttackDamageScaledByBoltResistance ; entry 11
    dw AttackDamageScaledByIceBoltResistance ; entry 12
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
    dw SkillDamageScaledByGigaSlashResistance ; entry 32
    dw ComputeAttackDamage ; entry 33
    dw ActionEffect_PsycheUp ; entry 34
    dw ComputeAttackDamage ; entry 35
    dw ComputeAttackDamage ; entry 36
    dw ComputeAttackDamage ; entry 37
    dw ActionEffect_PsycheUp ; entry 38
    dw ComputeAttackDamage ; entry 39

; A = battle slot: HL = the word for that slot in the array at wBattleATK (ReadBattleWordFromArray)
; (E-0043)
GetBattleATK::
    ld hl, wBattleATK
    jr ReadBattleWordFromArray

; A = battle slot: HL = the word for that slot in the array at wBattleDEF (ReadBattleWordFromArray)
; (E-0043)
GetBattleDEF::
    ld hl, wBattleDEF
    jr ReadBattleWordFromArray

; A = battle slot: HL = the word for that slot in the array at wBattleMaxHP
; (ReadBattleWordFromArray) (E-0043)
GetBattleMaxHP::
    ld hl, wBattleMaxHP
    jr ReadBattleWordFromArray

; A = battle slot: HL = the word for that slot in the array at wBattleMaxMP
; (ReadBattleWordFromArray) (E-0043)
GetBattleMaxMP::
    ld hl, wBattleMaxMP
    jr ReadBattleWordFromArray

; A = battle slot: HL = the word for that slot in the array at wBattleHP (ReadBattleWordFromArray)
; (E-0043)
GetBattleHP::
    ld hl, wBattleHP
    jr ReadBattleWordFromArray

; A = battle slot: HL = the word for that slot in the array at wBattleMP (ReadBattleWordFromArray)
; (E-0043)
GetBattleMP::
    ld hl, wBattleMP
    jr ReadBattleWordFromArray
    db $21, $1f, $d9, $18, $0a, $21, $53, $da, $85, $6f, $30, $01, $24, $7e, $c9

; HL = array base, A = slot: HL = the 16-bit word at HL + 2 * A (E-0043)
ReadBattleWordFromArray::
    add a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes
; appear in 12 banks) (E-0353)
AddDoubleAToHL_Bank36::
    add a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wLinkMode = 1 and wLinkRole bit 1 is set the
; test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the
; reversal, not checked (E-0064) (the same 27 bytes appear in 12 banks)
ActorOnLocalSide_Bank36::
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
TargetOnLocalSide_Bank36::
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

; Takes DE; changes HL, A and D (E-0347)
; why: a copy of ClearBattleStatusBitsWithMaskD_Bank05; ClearBattleStatusBitsWithMaskD_Bank05:
; wBattleStatus + 9 * E &= ClearBitMaskTable_Bank05[D] (AddAx9ToHL) (E-0352, E-0205)
ClearBattleStatusBitsWithMaskD_Bank36::
    ld a, d
    ld hl, ClearBattleStatusBitsWithMaskD_Bank36_Data
    add_a_to_hl
    ld d, [hl]
    ld a, e
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, d
    and [hl]
    ld [hl], a
    ret

; data read by ClearBattleStatusBitsWithMaskD_Bank36 (7 bytes) (E-0347)
ClearBattleStatusBitsWithMaskD_Bank36_Data::
    db $df, $fe, $00, $fd, $73, $ef, $bf

; Sets bit 0 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks) (E-0353)
SetBit0OfLevelUpGainsIndexed_Bank36::
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; Sets bit 1 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks) (E-0353)
SetBit1OfLevelUpGainsIndexed_Bank36::
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; Sets bit 2 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks) (E-0353)
SetBit2OfLevelUpGainsIndexed_Bank36::
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
PersonalityIndexOfSlot_Bank36::
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
CheckSlotStatusBlockWide_Bank36::
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
SlotHasStatus3Or4Bits_Bank36::
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
    ds $94, $00
