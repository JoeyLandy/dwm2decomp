; ROM bank $36: battle action resolution and skill effects (ActionEffect_*)
; The annotated listing of this bank is build/listing/bank36.asm.

SECTION "Bank 36", ROMX
    db $36

; Runs one resolve step of the current battle action: jumps through 16 entries picked by
; wBattleResolveStep (0 ResolveStepBegin, 1 ResolveStepTargetAndSubEffects, 2
; ResolveStepCallEffect82, 3 ResolveStepRolledOutOfWay, 4 ResolveStepEffectChecks, 5
; ResolveStepCriticalRoll, 6 ResolveStepActionEffect, 7 ResolveStepComputeDamage, 8
; ResolveStepSoundWaitAndMessage, 9 ResolveStepEffectFlags13AndSound, 10 ResolveStepDamageMessage,
; 11 ResolveStepBranchOnAction, 12 ResolveStepApplyDamage, 13 ResolveStepDefeat, 14
; ResolveStep0ECallEffect, 15 ResolveStepAdvanceSubPhase). Far-called by
; RunBattleActions_ResolveStep and RunBattleStep4_ResolveStep, sub-phase 1 of the fight steps, most
; steps add 1 to wBattleResolveStep (some 2, or fall into the next step in the same call), and step
; 15 moves wBattleSubPhase on and starts the counter again at 0. (C1, E-0380)
; jumps through a 16-entry table indexed by wBattleResolveStep (wBattleResolveStep): one step of
; resolving a battle action; the steps advance wBattleResolveStep and use wBattleSubStep
; (wBattleSubStep) and wBattleSubStep2 (wBattleSubStep2) for nested state
RunBattleResolveStep:: ; configured code entry (E-0395 (RunBattleResolveStep: found only by the $4001 fall-through guess, which a new entry later in the bank can change; listed so it stays traced)); C0
    ld a, [wBattleResolveStep]
    jumptable
    dw ResolveStepBegin
    dw ResolveStepTargetAndSubEffects
    dw ResolveStepCallEffect82
    dw ResolveStepRolledOutOfWay
    dw ResolveStepEffectChecks
    dw ResolveStepCriticalRoll
    dw ResolveStepActionEffect
    dw ResolveStepComputeDamage
    dw ResolveStepSoundWaitAndMessage
    dw ResolveStepEffectFlags13AndSound
    dw ResolveStepDamageMessage
    dw ResolveStepBranchOnAction
    dw ResolveStepApplyDamage
    dw ResolveStepDefeat
    dw ResolveStep0ECallEffect
    dw ResolveStepAdvanceSubPhase

; Resolve step 0: next step, sub-step 0. For a first action (no follow-up) with record flag bit 7,
; on a target that no status blocks and whose personality has act bit 5, picks an ally to duck
; behind (PickDuckBehindAlly); with one, keeps it in wDuckBehindSlot and shows battle text $33
; (category 0); otherwise clears the target's act bit 5. (C1, E-0357)
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

; Resolve step 1: by the sub-step, the target's reaction (ResolveTargetReaction) or the local-side
; follow-up (ResolveStepTargetAndSubEffects_AquaWall). (C1, E-0357)
ResolveStepTargetAndSubEffects::
    ld a, [wBattleSubStep]
    jumptable
    dw ResolveTargetReaction
    dw ResolveStepTargetAndSubEffects_AquaWall

; Resolve step 1, case 0 of wBattleSubStep: the reactions of the target before the hit.
; wAttackDeflected is cleared first. A follow-up action (wFollowUpAction non-zero) skips ahead to
; step 4 (through ResolveStepTargetAndSubEffects_AquaWall); a skill whose record byte 4 is $40 or
; $2x goes straight to ResolveStepTargetAndSubEffects_AquaWall, which leaves the counter at 2. When
; record byte 5 has bit 4 and bit 6 of the side flag byte of the target side (wSideFlags0 + 0 or 1)
; is set, the slot on the target side numbered by bits 2-3 of the byte $5A after that flag byte
; takes the hit instead if CheckSlotStatusBlockWide_Bank36 passes it: wAttackInhaled = 1,
; wBattleTarget and the actor entry of wBattleTargetChoice become that slot, '0 inhaled the attack!'
; is shown and wBattleSubStep becomes 1. Otherwise wBattleSubStep becomes 1 and record byte 5 bit 7,
; 4 or 6 picks TryShuntOrGuard, TryWindBounce or TryWallOfLightBounce, with none of them
; CheckTargetOutOfReach; carry set from it means a reaction took the turn and the step returns,
; otherwise it goes on into ResolveStepTargetAndSubEffects_AquaWall. (C1, E-0380)
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
    jp z, ResolveStepTargetAndSubEffects_AquaWall
    and $f0
    cp $20
    jp z, ResolveStepTargetAndSubEffects_AquaWall
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
    jr ResolveStepTargetAndSubEffects_AquaWall

.return:
    ret

.skip2:
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]

; Resolve step 1, sub-step 1 (AquaWall): when the target has BSTAT2_AQUA_WALL and the skill's record
; byte 5 bit 3, the wall takes the hit: clears it, shows battle text $E9 (near-side target) or $EA,
; sets defeat step 3, clears message flag bit 4 and restarts the resolve at sub-phase 2. (C1,
; E-0357)
ResolveStepTargetAndSubEffects_AquaWall::
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

SECTION "Bank 36 TryShuntOrGuard", ROMX

; Reaction for skills with record byte 5 bit 7, called by ResolveTargetReaction; carry set on return
; means a reaction took the turn, no carry means none. A target that is out of reach
; (SlotHasStatus3Or4Bits_Bank36) and a skill with record byte 7 bit 5:
; SetSubPhase2AndRestartResolve, then 'But the call went unheard!' for SKILL_CALLHELP and
; SKILL_YELLHELP, otherwise sound $84 and 'But it failed to reach 0!'. Otherwise TryAllyGuard ('0
; guarded <ally>!' through ShowReactionTextAndCarry). With no guard: SKILL_CALLHELP and
; SKILL_YELLHELP need BSTAT6_CALLED_HELP on the actor, and the target must be present; a target with
; the duck act (bit 5 of its wPersonalityActs byte) or BSTAT6_DODGE then asks PickShuntSlot: carry
; from it shows '0 failed to avert attack!', otherwise the attack is shunted ('0 shunted the
; attack!', wOriginalTarget = the old target, wBattleTarget and the actor entry of
; wBattleTargetChoice = the new slot, wRedirectFlags bit 0 set, and for ACTION_CC the actor
; wBattleStatus4 bits 2-3 cleared) and carry is set. (C1, E-0380)
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
    cp ACTION_CC
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

SECTION "Bank 36 TryWindBounce", ROMX

; Reaction for skills with record byte 5 bit 4 (and bit 7 clear), called by ResolveTargetReaction;
; carry set on return means a reaction took the turn. TryAllyGuard goes first ('0 guarded <ally>!').
; A target with BSTAT2_WIND_GUARD then loses it: wDefeatStep = 2, 'The wind around 0 bounced the
; attack!', wAttackDeflected = 1 and, if the actor is still in play, TurnActionBackOnActor with D =
; 1 (the attack is aimed back at the actor); an actor that is out gets SetSubPhase2AndRestartResolve
; instead. Carry is set either way. Without the wind guard it returns no carry. (C1, E-0380)
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

SECTION "Bank 36 TryWallOfLightBounce", ROMX

; Reaction for skills with record byte 5 bit 6 (bits 7 and 4 clear), called by
; ResolveTargetReaction; carry set on return means a reaction took the turn. TryAllyGuard goes
; first. A target with BSTAT2_BOUNCE or BSTAT2_MAGIC_BACK hit by a skill with record byte 7 bit 7
; bounces it: BSTAT2_MAGIC_BACK is cleared and wDefeatStep = 1 unless BSTAT2_BOUNCE is set, 'The
; wall of light bounced the spell!' is shown (text $C5 or $C6 by side), wAttackDeflected = 1, and
; TurnActionBackOnActor runs with D = 4 (or SetSubPhase2AndRestartResolve when the actor is out);
; carry is set. Otherwise no carry. (C1, E-0380)
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

SECTION "Bank 36 CheckTargetOutOfReach", ROMX

; Reaction for skills with none of record byte 5 bits 7, 6 and 4, called by ResolveTargetReaction;
; carry set on return means a reaction took the turn. A target that is out of reach
; (SlotHasStatus3Or4Bits_Bank36: wBattleStatus3 bits 6-7 or wBattleStatus4 bits 2-3) hit by a skill
; with record byte 7 bit 5 gets sound $84, 'But it failed to reach 0!' and
; SetSubPhase2AndRestartResolve, carry set. Otherwise TryAllyGuard: a guard shows '0 guarded
; <ally>!' with carry set; without one it returns no carry. (C1, E-0380)
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

SECTION "Bank 36 TryAllyGuard", ROMX

; Returns carry SET when nobody guards (the opposite of the other Try routines) and carry clear with
; D = $CA when an ally takes the hit. It guards when the target has BSTAT6_GUARDED, the skill record
; byte 6 has bit 0, and the ally named by the high nibble of the next status byte of the target
; (wBattleStatus7 + 9 * target) passes CheckSlotStatusBlockWide_Bank36. Then wOriginalTarget = the
; old target, the ally becomes wBattleTarget and the actor entry of wBattleTargetChoice,
; wAttackDeflected = 1 and wRedirectFlags bit 1 is set; the callers show text D, '0 guarded
; <ally>!'. (C2, E-0380)
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

SECTION "Bank 36 ShowReactionTextAndCarry", ROMX

; D = battle text: far-calls ShowBattleText and returns with carry set. The shared exit of
; TryShuntOrGuard, TryWindBounce, TryWallOfLightBounce and CheckTargetOutOfReach when they show a
; reaction text, so the caller sees that a reaction took the turn. (C1, E-0380)
; far-calls ShowBattleText with text D and returns carry (E-0337)
ShowReactionTextAndCarry::
    farcall ShowBattleText
    scf
    ret

SECTION "Bank 36 ResolveStepCallEffect82", ROMX

; Resolve step 2: wBattleResolveStep += 1. For a follow-up action (wFollowUpAction non-zero) that
; was not inhaled (wAttackInhaled zero) it returns at once when ActionIs91AndStatusBit6Set gives Z,
; otherwise stores $82 in wEffectFlags, farcalls SelectEffectByEffectFlags and returns, to step 3 on
; the next call. For a normal action or an inhaled attack it falls straight into
; ResolveStepRolledOutOfWay in the same call. (C1, E-0380)
; resolve step $02: advances wBattleResolveStep; when wFollowUpAction is non-zero and wAttackInhaled
; is zero and ActionIs91AndStatusBit6Set is not set, it stores $82 in wEffectFlags and farcalls
; SelectEffectByEffectFlags. When wFollowUpAction is zero or wAttackInhaled is non-zero it continues
; as ResolveStepRolledOutOfWay; when ActionIs91AndStatusBit6Set is set it returns (E-0050)
ResolveStepCallEffect82::
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wFollowUpAction]
    or a
    jr z, ResolveStepRolledOutOfWay
    ld a, [wAttackInhaled]
    or a
    jr nz, ResolveStepRolledOutOfWay
    call ActionIs91AndStatusBit6Set
    ret z
    ld a, $82
    ld [wEffectFlags], a
    farcall SelectEffectByEffectFlags
    ret

SECTION "Bank 36 ActionIs91AndStatusBit6Set", ROMX

; Z set (A = 0) when wBattleActionId is SKILL_GEYSER ($91) and bit 6 of the actor wBattleStatus3
; byte (wBattleStatus3 + 9 * wBattleActor) is set; Z clear otherwise (A = $40 for Geyser with the
; bit clear, A = the action id for any other action). Used only by ResolveStepCallEffect82. (C2,
; E-0380)
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

SECTION "Bank 36 ResolveStepRolledOutOfWay", ROMX

; Resolve step 3: wBattleResolveStep += 1. When the target is present
; (CheckSlotStatusBlockWide_Bank36 gives no carry), the skill record byte 6 has bit 6 and bit 7 of
; the target wPersonalityActs byte is set, it shows battle text $35 of category 0 ('0 rolled out of
; the way!'), runs SetSubPhase2AndRestartResolve, queues sound $84 and returns. Otherwise it falls
; straight into ResolveStepEffectChecks in the same call. (C1, E-0380)
; resolve step $03: advances wBattleResolveStep. When wBattleTarget is present
; (CheckSlotStatusBlockWide_Bank36 does not set carry), wRecordBufferData + $6 bit 6 is set, and the
; target's wPersonalityActs byte has bit 7 set, it farcalls ShowBattleTextCategory0 with D = $35,
; calls SetSubPhase2AndRestartResolve and queues sound $84; otherwise it goes on to case 4 (E-0050)
ResolveStepRolledOutOfWay::
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

SECTION "Bank 36 ResolveStepEffectChecks", ROMX

; Resolve step 4, the checks that make an action fail before the damage. A target that is out
; (CarryUnlessBattleSlotOutSlotEmpty) and an action outside
; ResolveStepEffectChecks_AllowsAbsentTarget end it at once with SetSubPhase3AndRestartResolve.
; Otherwise wBattleResolveStep += 1 and, unless ResolveStepEffectChecks_IsExemptAction, these tests
; run in order; a failing test shows its text and ends with wResolveMsgFlags bit 4 cleared and
; SetSubPhase2AndRestartResolve: (1) skill record byte 6 bit 1 (skipped for ACTION_CC when the actor
; has no wBattleStatus4 bits 2-3): a target with BSTAT5_IRONIZED or BSTAT5_IRONIZE_TURNS_HI shows '0
; is a hunk of iron!'. (2) record byte 5 bit 7: a target with wBattleStatus4 bits 2-3 or
; wBattleStatus3 bits 6-7 gets sound $84 and 'But it failed to reach 0!', except that ACTION_CC
; passes a target that has both bits of a pair set (for wBattleStatus4 only when the actor has none
; of its own bits 2-3). (3) record byte 5 bit 0: a BSTAT1_BLINDED actor misses when wRandomLo is
; below $A0, an actor with wBattleStatus5 bits 0-1 when it is below $60, unless bit 2 of its
; wPersonalityActs byte is set; a miss runs ResolveStepEffectChecks_ShowMissHeroAvoidedDamage. (4)
; record byte 6 bit 6: unless the target is asleep, paralyzed or confused (wBattleStatus byte 0 AND
; $D0) or has wBattleStatus4 bits 0-1, wBattleStatus5 bits 4-5 or wBattleStatus byte 8 bits 0-1, it
; leaps out of the way ('0 leapt out of the way!', sound $84) when wRandomLo is even and it has
; wBattleStatus5 bits 2-3, or when wRandomLo is below a limit taken from target AGL minus actor AGL
; (not above 0: 1; 1-99: 2; $64: 4; $C8: 8; $190: 16; $258: 32; $320 or more: 128). If nothing fails
; the counter stays at 5 for ResolveStepCriticalRoll. (C1, E-0380)
; resolve step $04: runs ResolveStepEffectChecks_AllowsAbsentTarget (returns on action $35) and,
; when the target is present, advances the step. Then it selects one of several effects from
; wRecordBufferData + $6 bits 1, 6 and wRecordBufferData + $5 bits 7 and 0 and the status bytes of
; the actor and target: messages $66, $68 and $D2 (with sound $84) and calls to
; ResolveStepEffectChecks_ShowMissHeroAvoidedDamage when the roll is below a threshold. The
; threshold for the roll comes from the actor's AGL minus the target's AGL, in bands of $320, $258,
; $190, $C8 and $64 (values $80 down to $01); the roll is AdvanceRandom's wRandomLo (E-0054)
ResolveStepEffectChecks::
    call ResolveStepEffectChecks_AllowsAbsentTarget
    jr z, .call_resolve_step_effect_checks_is_exempt
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .call_resolve_step_effect_checks_is_exempt
    call SetSubPhase3AndRestartResolve
    ret

.call_resolve_step_effect_checks_is_exempt:
    ld hl, wBattleResolveStep
    inc [hl]
    call ResolveStepEffectChecks_IsExemptAction
    ret z
    ld a, [wRecordBufferData + $6]
    bit 1, a
    jr z, .check_record_buffer_data
    ld a, [wBattleActionId]
    cp ACTION_CC
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
    cp ACTION_CC
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
    cp ACTION_CC
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

SECTION "Bank 36 ResolveStepEffectChecks_AllowsAbsentTarget", ROMX

; Z when wBattleActionId is SKILL_IRONIZE, SKILL_HEAL, SKILL_HEALMORE, SKILL_HEALALL, SKILL_MPASS,
; SKILL_MPASSMORE, SKILL_MPASSMOST, SKILL_VIVIFY, SKILL_REVIVE, SKILL_FAREWELL, SKILL_LIFEDANCE,
; SKILL_GUARDIAN, SKILL_STORMWIND, SKILL_SUCKALL, ACTION_BB or ACTION_CE. ResolveStepEffectChecks
; lets these actions go on without its target check; any other action with a target that
; CarryUnlessBattleSlotOutSlotEmpty reports as out (wBattleSlotOut non-zero) ends with
; SetSubPhase3AndRestartResolve. (C2, E-0372; probed E-0380)
ResolveStepEffectChecks_AllowsAbsentTarget::
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
    cp ACTION_BB
    ret z
    cp ACTION_CE
    ret

SECTION "Bank 36 ResolveStepEffectChecks_IsExemptAction", ROMX

; Z when wBattleActionId is SKILL_HIGHJUMP, SKILL_LIFESONG or SKILL_LOVERAIN.
; ResolveStepEffectChecks, after advancing wBattleResolveStep, returns at once for these actions and
; skips the remaining checks (the dodge rolls with '0 leapt out of the way!' and the other
; messages). (C2, E-0372; probed E-0380)
ResolveStepEffectChecks_IsExemptAction::
    ld a, [wBattleActionId]
    cp SKILL_HIGHJUMP
    ret z
    cp SKILL_LIFESONG
    ret z
    cp SKILL_LOVERAIN
    ret

SECTION "Bank 36 ResolveStepCriticalRoll", ROMX

; Resolve step 5, the critical-hit roll: wBattleResolveStep += 1. It runs ResolveStepActionEffect at
; once when skill record byte 6 has neither bit 3 nor bit 4, or has bit 4 and the actor has
; BSTAT1_ATK_DOUBLED. With record byte 6 bit 3 the hit is critical without a roll if bit 0 of the
; actor wPersonalityActs byte or BSTAT1_CRITICAL is set, otherwise when AdvanceRandom and
; RollRandomLoBelowChance give carry. A critical hit sets BSTAT2_CRITICAL_ROLLED on the actor, shows
; 'Critical hit!' (text $9C, actor on the local side) or 'A brutal hit!' ($9D), queues sound $83 and
; adds 1 to the counter again, so the next call is step 7 and step 6 is skipped. If record byte 6
; bit 3 is clear or the roll fails, BSTAT2_CRITICAL_ROLLED is cleared and it returns, to step 6 on
; the next call. (C1, E-0380)
; resolve step $05: advances wBattleResolveStep. With wRecordBufferData + $6 bits 3-4 both clear it
; continues into case 6. Bit 4 with the actor's status byte 1 bit 2 set continues into case 6. With
; wRecordBufferData + $6 bit 3 set and wPersonalityActs bit 0 (target) and status byte 1 bit 3
; (actor) both clear, it rolls RollRandomLoBelowChance: on success it sets bit 7 of the actor's
; status byte 2 (wBattleStatus2), calls ActorOnLocalSide_Bank36, shows message $9C (carry) or $9D
; through ShowBattleText, queues sound $83 and advances the step again; on failure, or when bit 3 is
; clear, it clears that bit (E-0052)
ResolveStepCriticalRoll::
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

SECTION "Bank 36 ResolveStepActionEffect", ROMX

; Resolve step 6: wBattleResolveStep += 1, then DispatchActionEffectTable jumps through
; ActionEffectTable by wBattleActionId to the effect routine of the action (the attack, spell or
; effect itself); it returns when that routine does. Also run in the same call by
; ResolveStepCriticalRoll when no critical roll applies. (C1, E-0380)
; resolve step $06: advances wBattleResolveStep, then calls DispatchActionEffectTable for
; wBattleActionId (E-0053)
ResolveStepActionEffect::
    ld hl, wBattleResolveStep
    inc [hl]
    call DispatchActionEffectTable
    ret

SECTION "Bank 36 ResolveStepComputeDamage", ROMX

; Resolve step 7, finishes the damage word wBattleDamageLo/Hi (16-bit). If the actor has
; BSTAT2_CRITICAL_ROLLED it first returns, without advancing, until wSoundChannelSlots AND
; wSoundChannel1 is $FF (the critical-hit sound is over). Then wBattleResolveStep += 1 and the first
; of these that applies changes the damage: skill record byte 6 bit 4 with BSTAT1_ATK_DOUBLED on the
; actor doubles it; record byte 6 bit 3 with BSTAT2_CRITICAL_ROLLED clears that bit, stores the hit
; message (StoreHitMessage_Bank36) and replaces the damage by a random value within 5 percent of the
; actor ATK (RandomWithin5PercentOfHL; the personality bonus below is skipped); record byte 6 bit 5
; with BSTAT4_CHARGE_UP doubles it; record byte 5 bit 1 with BSTAT4_SUCK_AIR replaces it by a random
; value from 2 to 2.5 times (ResolveStepComputeDamage_SuckAirBoost). Then bit 6 of the actor
; wPersonalityActs byte adds half again. Then the target wBattleStatus7 (zero skips this): with only
; bit 2 set, a skill with record byte 5 bit 7 halves the damage; with bit 0 or 1 set, record byte 6
; bit 7 halves it for bit 0 and divides it by 10 for bit 1 alone; after either, bit 1 of the target
; wPersonalityActs byte halves it once more. Last, BSTAT6_BERSERK on the target doubles damage from
; skills with record byte 5 bit 7 unless the action is SKILL_RAMMING or SKILL_KAMIKAZE. The next
; step is 8. (C2, E-0380)
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
    call StoreHitMessage_Bank36
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
    call ResolveStepComputeDamage_SuckAirBoost
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

SECTION "Bank 36 ResolveStepSoundWaitAndMessage", ROMX

; Resolve step 8: for ACTION_CD it first returns, changing nothing, until wSoundChannelSlots AND
; wSoundChannel1 is $FF. Then wBattleResolveStep += 2 (step 9 is skipped). With wResolveMsgFlags bit
; 5 set it sets flag bit 4 and clears bit 6 when the damage word is non-zero, else clears bit 4 and
; sets bit 6. For ACTION_CF with flag bit 4 clear it returns here; with bit 4 set it takes one step
; back (the counter ends +1) and returns while wMultiHitCount is non-zero. Then it plays the hit:
; wEffectFlags = $41 when flag bit 4 is set and bit 6 clear, else $40, and SelectEffectByEffectFlags
; starts the animation; wEffectFlags2 = (flags AND $10) OR $20 and SelectEffectByEffectFlags2Flags
; plays the sound. (C2, E-0380)
; resolve step $08: for action $CD it returns while the sound channels in wSoundChannel1 are busy
; (wSoundChannelSlots and wSoundChannel1 not both $FF). Otherwise it advances the step twice,
; updates bit 4 or 6 of wResolveMsgFlags from wBattleDamageLo/Hi and wBattleDamageHi when
; wResolveMsgFlags bit 5 is set, and for action $CF rewinds the step while wResolveMsgFlags bit 4 is
; set and wMultiHitCount is zero. It then stores $40 or $41 in wEffectFlags, farcalls
; SelectEffectByEffectFlags and SelectEffectByEffectFlags2Flags (E-0053)
ResolveStepSoundWaitAndMessage::
    ld a, [wBattleActionId]
    cp ACTION_CD
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
    cp ACTION_CF
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

SECTION "Bank 36 ResolveStepEffectFlags13AndSound", ROMX

; Resolve step 9: wBattleResolveStep += 1, stores $13 in wEffectFlags, farcalls
; SelectEffectByEffectFlags (flag value $13 starts effect animation $14) and queues sound effect
; $85. The $13 is the effect flag value, not a battle text number; the message follows in step 10.
; Step 8 skips this step except for ACTION_CF, and RunBattleActions_StatusChecks_StartAction_Curse
; sets wBattleResolveStep to 9 for a cursed actor at 0 HP. (C2, E-0380)
; resolve step $09: advances wBattleResolveStep, stores $13 in wEffectFlags, farcalls
; SelectEffectByEffectFlags and queues sound effect $85 (E-0053)
ResolveStepEffectFlags13AndSound::
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $13
    ld [wEffectFlags], a
    farcall SelectEffectByEffectFlags
    ld a, $85
    call QueueSoundEffect
    ret

SECTION "Bank 36 ResolveStepDamageMessage", ROMX

; Resolve step 10, the message of the hit: wBattleResolveStep += 1. When wResolveMsgFlags bit 7 is
; set it takes the message number into wTemp0: with flag bit 4 set wResolveMsgActor, changed by
; ResolveStepDamageMessage_AdjustActorMessage when flag bit 3 is set; with bit 4 clear
; wResolveMsgTarget, changed by ResolveStepDamageMessage_AdjustTargetMessage when wResolveMsgArg bit
; 3 is set. ACTION_DC shows nothing; ACTION_D7 first farcalls ApplyDamageModifiers; every other
; action shows wTemp0 with ShowBattleText. Then ResolveStepDamageMessage_RestartForTarget runs and a
; target message (flag bit 4 clear) ends the step. After an actor message (bit 4 set):
; SKILL_TRANSFORM loads the picture of the target species for the actor slot and sets the name byte;
; SKILL_BEDRAGON and ACTION_B8 load picture $0160 (MONSTER_DRACOLORD_160) for the actor;
; SKILL_ROBMAGIC and SKILL_ROBDANCE set bit 1 of the actor wLevelUpGains byte; ACTION_DC loads
; picture $0161 (MONSTER_LORDDRACO) for the actor and for its formation partner; action $DF sets
; that bit for the partner and the actor; other actions just return. (C1, E-0380)
; resolve step $0A: advances wBattleResolveStep and, for the actor or target side chosen by
; wResolveMsgFlags bit 4, stores wResolveMsgActor or wResolveMsgTarget in wTemp0 and calls
; ResolveStepDamageMessage_AdjustActorMessage / ResolveStepDamageMessage_AdjustTargetMessage; the
; first fight showed the battle text 'took N damage!' (bank $2F, category 1, index 53) at this step
ResolveStepDamageMessage::
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wResolveMsgFlags]
    bit 7, a
    jr z, .call_resolve_step_damage_message_restart_for
    bit 4, a
    jr z, .read_resolve_msg_target
    ld a, [wResolveMsgActor]
    ld [wTemp0], a
    ld a, [wResolveMsgFlags]
    bit 3, a
    call nz, ResolveStepDamageMessage_AdjustActorMessage
    jr .check_battle_action_id

.read_resolve_msg_target:
    ld a, [wResolveMsgTarget]
    ld [wTemp0], a
    ld a, [wResolveMsgArg]
    bit 3, a
    call nz, ResolveStepDamageMessage_AdjustTargetMessage

.check_battle_action_id:
    ld a, [wBattleActionId]
    cp ACTION_DC
    jr z, .call_resolve_step_damage_message_restart_for
    cp ACTION_D7
    jr nz, .read_temp0
    farcall ApplyDamageModifiers

.read_temp0:
    ld a, [wTemp0]
    ld d, a
    farcall ShowBattleText

.call_resolve_step_damage_message_restart_for:
    call ResolveStepDamageMessage_RestartForTarget
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
    cp ACTION_B8
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
    call ResolveStepDamageMessage_SetTransformNameByte
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
    call ResolveStepDamageMessage_ShowLordDracoPicture
    pop af
    ld [wBattleActor], a

; Writes the species word $0161 (MONSTER_LORDDRACO) at wTemp0 and loads that picture for slot
; wBattleActor (LoadBattleMonsterPictureForSlotB). ResolveStepDamageMessage reaches it only for
; ACTION_DC: it first calls it with wBattleActor set to the actor's formation partner
; (ActorFormationSlotToTemp0), then restores the actor and falls into it again. (C1, E-0372)
ResolveStepDamageMessage_ShowLordDracoPicture::
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

SECTION "Bank 36 ResolveStepBranchOnAction", ROMX

; Resolve step 11: SKILL_ULTRADOWN jumps to ResolveStepBranchOnAction_UltraDown; SKILL_DEMAGIC,
; SKILL_THICKFOG and ACTION_B3 jump to ResolveStepBranchOnAction_RemoveEffects (they keep the
; counter at 11 and finish by moving wBattleSubPhase on); any other action only does
; wBattleResolveStep += 1 and returns, to step 12. (C1, E-0380)
; resolve step $0B: wBattleActionId $82 jumps to ResolveStepBranchOnAction_UltraDown; $83, $84 and
; $B3 jump to ResolveStepBranchOnAction_RemoveEffects; any other action advances wBattleResolveStep
; and returns (E-0050)
ResolveStepBranchOnAction::
    ld a, [wBattleActionId]
    cp SKILL_ULTRADOWN
    jp z, ResolveStepBranchOnAction_UltraDown
    cp SKILL_DEMAGIC
    jp z, ResolveStepBranchOnAction_RemoveEffects
    cp SKILL_THICKFOG
    jp z, ResolveStepBranchOnAction_RemoveEffects
    cp ACTION_B3
    jp z, ResolveStepBranchOnAction_RemoveEffects
    ld hl, wBattleResolveStep
    inc [hl]
    ret

SECTION "Bank 36 ResolveStepApplyDamage", ROMX

; Resolve step 12: farcalls ApplyDamageToTarget (bank $32): wBattleResolveStep += 2 and
; wBattleSubStep = 0. With wResolveMsgArg bits 7-6 equal to 00 nothing else happens; with 01 only
; bits 0-2 of the target wLevelUpGains byte are set; otherwise it also subtracts wBattleDamageLo/Hi
; from the target wBattleHP. A result of 0 or below clamps the HP to 0, takes one step back (so the
; next step is 13, ResolveStepDefeat, instead of 14) and clears wBattleSubStep2. (C2, E-0380)
; resolve step $0C: farcalls ApplyDamageToTarget
ResolveStepApplyDamage::
    farcall ApplyDamageToTarget
    ret

SECTION "Bank 36 ResolveStepDefeat", ROMX

; Resolve step 13: farcalls RunDefeatSequence (bank $32), three sub-steps by wBattleSubStep2: lower
; the target mark in wSlotMarks by 5 and defeat it (DefeatTarget); blank its picture; then
; wBattleResolveStep += 1 (to step 14) and show 'died!' (text $8A, target on the local side) or 'was
; defeated!' ($8B), unless the action took the target out by itself (Beat, Defeat, Sacrifice or
; action $D6). Reached from ResolveStepApplyDamage when the target HP fell to 0. (C1, E-0380)
; resolve step $0D: runs the defeat sequence RunDefeatSequence (RunDefeatSequence); the first fight
; showed 'was defeated!' (category 1, index 139) at this step
ResolveStepDefeat::
    farcall RunDefeatSequence
    ret

SECTION "Bank 36 ResolveStep0ECallEffect", ROMX

; Resolve step 14: farcalls ResolveStep0EEffect (bank $32), the aftermath of the action after the
; damage: a ten-case jump table on wBattleSubStep (case 0 starts by skill, others show a message,
; recoil, Brutalize or Sacrifice effects). Its ResolveStep0EEffect_Finish case sets wBattleSubStep
; to 0 and adds 1 to wBattleResolveStep, which leads to step 15. Several routines set
; wBattleResolveStep to $0E to run it directly. (C1, E-0380)
; resolve step $0E: farcalls ResolveStep0EEffect in bank $32 (E-0053)
ResolveStep0ECallEffect::
    farcall ResolveStep0EEffect
    ret

SECTION "Bank 36 ResolveStepAdvanceSubPhase", ROMX

; Resolve step 15, the last: wBattleSubPhase += 1 and wBattleResolveStep = 0, so the fight step
; moves on to its next sub-phase and the next resolve starts again at step 0. (C2, E-0380)
; resolve step $0F: increments wBattleSubPhase and sets wBattleResolveStep to 0 (E-0050)
ResolveStepAdvanceSubPhase::
    ld hl, wBattleSubPhase
    inc [hl]
    xor a
    ld [wBattleResolveStep], a
    ret

SECTION "Bank 36 RollRandomLoBelowChance", ROMX

; Carry when wRandomLo is below the actor's resolve chance
; (RollRandomLoBelowChance_LoadActorChance), a chance of 3 taken as 4. (C2, E-0357; probed E-0380)
RollRandomLoBelowChance::
    push bc
    push hl
    farcall RollRandomLoBelowChance_LoadActorChance
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

SECTION "Bank 36 RandomWithin5PercentOfHL", ROMX

; HL = a value; returns DE = a random value from HL - HL / 20 to HL + HL / 20 (16-bit, the division
; rounds down), so within about 5 percent of HL. When HL / 20 is 0 (HL below 20) it returns DE = HL
; without a random step. HL and BC are changed. ResolveStepComputeDamage (the critical hit),
; ActionEffect_EvilSlash and ActionEffect_Massacre call it with HL = the ATK of the actor and store
; DE as wBattleDamageLo/Hi. (C2, E-0380)
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

SECTION "Bank 36 ResolveStepComputeDamage_SuckAirBoost", ROMX

; HL = damage: returns DE = RandomInRange(2 x HL, 2 x HL + HL / 2), all 16-bit with wrap, so between
; two and two and a half times the damage. ResolveStepComputeDamage uses it when the skill record
; has wRecordBufferData + $5 bit 1 set and the actor has BSTAT4_SUCK_AIR, storing DE as the new
; wBattleDamageLo/Hi. (C2, E-0372; probed E-0380)
ResolveStepComputeDamage_SuckAirBoost::
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

SECTION "Bank 36 ResolveStepDamageMessage_RestartForTarget", ROMX

; When the message was the target's and there is no follow-up, restarts the resolve at sub-phase 3
; and puts back a redirected target (wOriginalTarget) as the target and choice. (C2, E-0357; probed
; E-0380)
ResolveStepDamageMessage_RestartForTarget::
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

SECTION "Bank 36 ResolveStepDamageMessage_AdjustActorMessage", ROMX

; Called by ResolveStepDamageMessage when wResolveMsgFlags bits 4 and 3 are set, with wTemp0 =
; wResolveMsgActor: adjusts that message number for the sides. SKILL_MASSACRE, or a shunted attack
; (wRedirectFlags bit 0), adds 1 when TargetOnLocalSide_Bank36 sets carry. Otherwise a near-side
; actor (ActorOnLocalSide_Bank36 carry) keeps it; for a far-side actor SKILL_PANICALL,
; SKILL_PANICALL_AD, SKILL_PANIDANCE, ACTION_BF, ACTION_C0, ACTION_C9, ACTION_CA and ACTION_CB
; subtract 1; SKILL_BEAT, SKILL_DEFEAT and SKILL_KODANCE set $8A; SKILL_SACRIFICE sets $8A when the
; damage is 1000-1255, else adds 1; SKILL_SLOW and SKILL_SLOWALL set $CD; SKILL_EERIELITE $56;
; SKILL_DANCESHUT $63; ACTION_B5 adds 1 when wResolveMsgActor is $73, else subtracts 1; ACTION_BA
; sets $78; any other action adds 1. (C2, E-0372; probed E-0380)
ResolveStepDamageMessage_AdjustActorMessage::
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
    cp ACTION_B5
    jr z, .check_resolve_msg_actor
    cp ACTION_BA
    jr z, .set_temp0_to_78
    cp ACTION_BF
    jr z, .done
    cp ACTION_C0
    jr z, .done
    cp ACTION_C9
    jr z, .done
    cp ACTION_CA
    jr z, .done
    cp ACTION_CB
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

SECTION "Bank 36 ResolveStepDamageMessage_AdjustTargetMessage", ROMX

; Called by ResolveStepDamageMessage when wResolveMsgFlags bit 4 is clear and wResolveMsgArg bit 3
; is set, with wTemp0 = wResolveMsgTarget: a near-side actor (ActorOnLocalSide_Bank36 carry) keeps
; the message; for a far-side actor SKILL_PALSYAIR, SKILL_POISONGAS and SKILL_POISONAIR set $6A,
; SKILL_CURSE $6B, SKILL_SANDSTORM $6C, SKILL_RADIANT $6D, SKILL_EERIELITE, SKILL_LUSHLICKS and
; SKILL_SICKLICK $6E, SKILL_AHHH and SKILL_AHHH_AA $71, ACTION_C0 subtracts 1, and any other action
; adds 1. (C2, E-0372; probed E-0380)
ResolveStepDamageMessage_AdjustTargetMessage::
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
    cp ACTION_C0
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

SECTION "Bank 36 ResolveStepBranchOnAction_UltraDown", ROMX

; Resolve step $0B for SKILL_ULTRADOWN (jumped to by ResolveStepBranchOnAction); does nothing until
; wSoundChannelSlots AND wSoundChannel1 is $FF. First pass (wBattleSubStep 0): LowerTargetAGL, then
; with wResolveMsgFlags bit 4 queues sound $87 and shows the actor message (wResolveMsgActor, or
; text $CD for a far-side actor), else the target message (wResolveMsgTarget); sets wBattleSubStep
; to 1. Second pass: increments wBattleSubPhase, clears wBattleResolveStep and wBattleSubStep, runs
; ActionEffect_Surround and, unless wBattleSubPhase is now 5, with flag bit 4 queues sound $99 and
; shows the actor message; then ResolveStepDamageMessage_RestartForTarget. (C1, E-0372)
ResolveStepBranchOnAction_UltraDown::
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannel1
    and [hl]
    cp $ff
    ret nz
    ld a, [wBattleSubStep]
    or a
    jr z, .call_lower_target_agl
    ld hl, wBattleSubPhase
    inc [hl]
    xor a
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleSubStep], a
    call ActionEffect_Surround
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
    jr z, .call_resolve_step_damage_message_restart_for
    ld a, [wResolveMsgActor]
    ld d, a
    farcall ShowBattleText

.call_resolve_step_damage_message_restart_for:
    call ResolveStepDamageMessage_RestartForTarget
    ret

.call_lower_target_agl:
    call LowerTargetAGL
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

SECTION "Bank 36 ResolveStepBranchOnAction_RemoveEffects", ROMX

; Resolve step $0B for SKILL_DEMAGIC, SKILL_THICKFOG and ACTION_B3 (jumped to by
; ResolveStepBranchOnAction): runs one step per call by wBattleSubStep: 0 removes the target's
; BSTAT2_WIND_GUARD ('The wind around 0 died!'); 1 turns a transformed target back ('0 turned back
; to normal!') and restores its stats; 2 reloads its picture; 3 makes a present slot-3 or slot-7
; target leave ('0 went away!'); 4 removes BSTAT8_SEAL_PRAY; 5 ends with the next sub-phase
; (ResolveStepDamageMessage_NextSubPhase). (C1, E-0372)
ResolveStepBranchOnAction_RemoveEffects::
    ld a, [wBattleSubStep]
    jumptable
    dw ResolveStepBranchOnAction_ShowTheWindAroundHero
    dw ResolveStepBranchOnAction_RemoveEffects_RevertForm
    dw ResolveStepDamageMessage_ReloadPicture
    dw ResolveStepBranchOnAction_RemoveEffects_Leave
    dw ResolveStepDamageMessage_BreakSealPray
    dw ResolveStepDamageMessage_NextSubPhase

; Aftermath, step 0: a target with BSTAT2_WIND_GUARD loses it with battle text $80. (C1, E-0357)
ResolveStepBranchOnAction_ShowTheWindAroundHero::
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

SECTION "Bank 36 ResolveStepBranchOnAction_RemoveEffects_RevertForm", ROMX

; Aftermath, step 1 (entry 1 of ResolveStepBranchOnAction_RemoveEffects): adds 2 to wBattleSubStep.
; When the target has BSTAT1_DRAGON_FORM or BSTAT1_TRANSFORMED it clears both bits, steps
; wBattleSubStep back to 2 (so ResolveStepDamageMessage_ReloadPicture runs next; otherwise step 3
; follows), shows battle text $5F ('0 turned back to normal!'), cancels its action
; (CancelTargetActionUnlessSpecial), clears the low three bits of its wSideControl byte, reloads its
; skills (LoadSlotSkillsFromBattlerRecord with wBattleArg0 = 1), runs
; RefreshTargetResistancesFromRecord and stores the base values of max HP and max MP (lowering
; wBattleHP and wBattleMP to them when they are not below, with SetBit0OfLevelUpGainsIndexed_Bank36
; and SetBit1OfLevelUpGainsIndexed_Bank36), ATK and INT, then runs SetSlotAIModeFromINT and stores
; wBattleLevel, the three personality bytes and wSlotTrait from the record. In every case it then
; stores the base AGL and DEF of the target in wBattleAGL and wBattleDEF. (C1, E-0373)
ResolveStepBranchOnAction_RemoveEffects_RevertForm::
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
    call RefreshTargetResistancesFromRecord
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
    farcall GetSlotLevel
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wBattleLevel
    add_a_to_hl
    ld [hl], c
    ld a, [wBattleTarget]
    ld c, a
    farcall GetSlotPersonalityHi
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wSlotPersonalityHi
    add_a_to_hl
    ld [hl], c
    ld a, [wBattleTarget]
    ld c, a
    farcall GetSlotPersonalityMid
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wSlotPersonalityMid
    add_a_to_hl
    ld [hl], c
    ld a, [wBattleTarget]
    ld c, a
    farcall GetSlotPersonalityLo
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wSlotPersonalityLo
    add_a_to_hl
    ld [hl], c
    ld a, [wBattleTarget]
    ld c, a
    farcall GetSlotTrait
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

SECTION "Bank 36 RefreshTargetResistancesFromRecord", ROMX

; Packs the 27 resistance levels of the battler record of wBattleTarget (field BATTLER_RESISTANCES,
; one byte per level) into the 7-byte record of that slot in wSlotResistances: it sets
; wBattleArg0/wBattleArg1 to the address of the field (BattlerRecordFieldAddress) and
; wBattleArg2/wBattleArg3 to wSlotResistances + 7 x wBattleTarget, then far-calls
; PackResistancesFromBattleArgs. A target in slot 3 or 7 (wBattleTarget & 3 = 3, no battler record)
; returns at once. Despite its name it changes no stat.
; ResolveStepBranchOnAction_RemoveEffects_RevertForm is the only caller, after a transformed target
; turned back. (C2, E-0380)
; for a target other than slot 3/7: wBattleArg0 = its record field $31 address, wBattleArg2 = its
; wSlotResistances record, then far-calls PackResistancesFromBattleArgs (E-0124)
RefreshTargetResistancesFromRecord::
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
    farcall PackResistancesFromBattleArgs
    ret

SECTION "Bank 36 ResolveStepDamageMessage_ReloadPicture", ROMX

; Aftermath, step 2: reloads the target's picture, marks it done (3) and, outside link mode 1,
; clears a far-side target's name byte (not slot 7). (C1, E-0357)
ResolveStepDamageMessage_ReloadPicture::
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

SECTION "Bank 36 ResolveStepBranchOnAction_RemoveEffects_Leave", ROMX

; Aftermath, step 3: advances wBattleSubStep to 4, then acts only on a target in slot 3 or 7
; (wBattleTarget & 3 = 3) whose wBattleSlotOut byte is 0 (CarryUnlessBattleSlotOutSlotEmpty returns
; carry clear): shows battle text $7F ('0 went away!'), sets its wBattleSlotOut and wSlotMarks bytes
; to $FF, clears its nine wBattleStatus bytes and clears bit 2 of wSideFlags0. It works out the side
; from wBattleTarget bit 2 but never adds it to the address, so the bit is cleared in wSideFlags0
; for a target on either side. (C1, E-0373)
ResolveStepBranchOnAction_RemoveEffects_Leave::
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

SECTION "Bank 36 ResolveStepDamageMessage_BreakSealPray", ROMX

; Aftermath, step 4: a target with BSTAT8_SEAL_PRAY loses it and the queued action and SealPray
; state are cleared. (C2, E-0357; probed E-0380)
ResolveStepDamageMessage_BreakSealPray::
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

SECTION "Bank 36 ResolveStepDamageMessage_NextSubPhase", ROMX

; Aftermath, step 5: the next sub-phase; clears the side flags except bits 0, 1, 4 and 7 and, unless
; the skill was DeMagic, sets bit 3 on both sides. (C2, E-0357; probed E-0380)
ResolveStepDamageMessage_NextSubPhase::
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

SECTION "Bank 36 LoadBattleMonsterPictureForSlotB", ROMX

; B = battle slot, DE = the address of the 16-bit monster id of that slot (wBattleMonsterId + 2 x
; slot, or a forced id such as the one ResolveStepDamageMessage_ShowLordDracoPicture writes at
; wTemp0). Draws the picture of that monster at the foe position of the slot; nothing is returned in
; a register. Outside link mode 1 (or in link mode 1 with wLinkRole bit 1 clear) slots 0-3 and 7
; draw nothing and slots 4-6 are positions 0-2; in link mode 1 with wLinkRole bit 1 set slots 0-2
; are positions 0-2 and slots 3 and up draw nothing. For position P it decompresses the picture
; (LoadMonsterPicture) to vTiles2 + $140 + $240 x P with palette slot 2 x P + 1; on a Game Boy Color
; (wIsCGB not 0) it also sets wBGPaletteUploadRequest to $7F and writes the attribute map
; (LoadMonsterPictureAttributes) at vBGMap0 + $E7, $E4 or $E1 for 1, 2 or 3 foes (wBattleFoeCount,
; or wSide1Flag / wSide0Flag in link mode 1) plus 6 x P. (C1, E-0380)
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

SECTION "Bank 36 TurnActionBackOnActor", ROMX

; D = bits to OR into wFollowUpAction (TryWindBounce passes 1, TryWallOfLightBounce 4). Saves seven
; bytes at wSavedActorTarget: wBattleActor, wBattleTarget, wMultiHitCount, the two bytes (action id,
; target slot) of the wBattleActionChoice word of the actor, then the two bytes of the word of the
; target. Then the word of the target becomes the action id of the actor aimed at the slot of the
; actor, and wBattleActor and wBattleTarget are swapped, so the bounced action is run by the old
; target against the old actor. Last, D is ORed into wFollowUpAction (three bit tests of D before
; that change nothing: every path reaches the same OR). (C2, E-0380)
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

SECTION "Bank 36 SetSubPhase3AndRestartResolve_Bank36", ROMX

; Sets wBattleSubPhase to 3 and wBattleResolveStep to 0 (A = 0 on return), the same 10 bytes as
; SetSubPhase3AndRestartResolve. No caller of this copy was found in src; the live copy is
; SetSubPhase3AndRestartResolve. (C2, E-0380)
; the same 10 bytes as SetSubPhase3AndRestartResolve (SetSubPhase3AndRestartResolve) (E-0055)
SetSubPhase3AndRestartResolve_Bank36:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    ld a, $03
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    ret

SECTION "Bank 36 PickShuntSlot", ROMX

; Picks the slot an attack on wBattleTarget is shunted to; TryShuntOrGuard calls it. Carry clear and
; A = the slot, or carry set = no shunt. A target whose wPersonalityActs word has bit 5 (the duck
; act) gives A = wDuckBehindSlot with no random step. Otherwise AdvanceRandom decides on wRandomLo:
; below $33 returns carry (PickShuntSlot_NoSlot); $33 to $65 goes to PickShuntSlot_TargetSideAlly;
; $66 or more lists in wSlotChoices (first filled with $FF) the present slots
; (CarryUnlessBattleSlotOutSlotEmpty clear) of the three slots 0-2 or 4-6 of the other side (bit 2
; of wBattleTarget flipped), E = how many, and falls into PickRandomEntryOfSlotChoices for the
; random pick. With no present slot on the other side E is 0 and the pick would run past
; wSlotChoices. (C2, E-0380)
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
    jp c, PickShuntSlot_NoSlot
    cp $66
    jr c, PickShuntSlot_TargetSideAlly
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

; E = the number of entries filled in wSlotChoices (at least 1). Returns A = a random one of the
; first E bytes of wSlotChoices (index RandomInRange(0, E - 1); with E = 1 no random step) and carry
; clear. E, BC and HL are changed. PickShuntSlot falls into it and PickShuntSlot_TargetSideAlly
; calls it. (C2, E-0380)
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

SECTION "Bank 36 PickShuntSlot_TargetSideAlly", ROMX

; The case of PickShuntSlot for a roll of $33-$65: lists the slots of the target's own side other
; than wBattleTarget that are present (CarryUnlessBattleSlotOutSlotEmpty clear) in wSlotChoices
; (first set to $FF) and returns a random one (PickRandomEntryOfSlotChoices, no carry); with none it
; returns carry (PickShuntSlot_NoSlot). (C2, E-0372; probed E-0380)
PickShuntSlot_TargetSideAlly::
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
    jr z, PickShuntSlot_NoSlot
    call PickRandomEntryOfSlotChoices
    ret

SECTION "Bank 36 PickShuntSlot_NoSlot", ROMX

; Returns carry: PickShuntSlot found no slot to shunt the attack to (its roll was below $33, or
; PickShuntSlot_TargetSideAlly found no other present slot on the target's side). (C2, E-0372;
; probed E-0380)
PickShuntSlot_NoSlot::
    scf
    ret

SECTION "Bank 36 ResolveStepEffectChecks_ShowMissHeroAvoidedDamage", ROMX

; Plays sound $84 and shows the miss message: battle text $D0 for a near-side actor, $D1 otherwise.
; (C1, E-0357)
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

SECTION "Bank 36 SetSubPhase2AndRestartResolve", ROMX

; Sets wBattleSubPhase to 2 and wBattleResolveStep to 0, so RunBattleActions_ResolveAction runs next
; (it reloads the skill record and runs RunActionResolveStep from its step 0). First: for
; wBattleActionId = ACTION_CC it clears bits 2-3 of the wBattleStatus4 byte of the actor when they
; hold binary 01 (it does not touch bits 0-1); for an action from $D0 to $E3 it marks the formation
; partner of the actor (wSlotMarks entry = 3, through
; RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3). TryShuntOrGuard, TryWindBounce,
; TryWallOfLightBounce, CheckTargetOutOfReach, ResolveStepRolledOutOfWay, ResolveStepEffectChecks
; and ResolveStepTargetAndSubEffects_AquaWall call it when an effect check ends the action early.
; (C2, E-0380)
; for action $CC clears bits 0-1 of the actor's wBattleStatus4 byte when bits 2-3 equal 4; for an
; action in $D0-$E3 it farcalls RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3 first. Then it sets
; wBattleSubPhase to 2 and clears wBattleResolveStep (E-0055)
SetSubPhase2AndRestartResolve::
    ld a, [wBattleActionId]
    cp ACTION_CC
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

SECTION "Bank 36 SetSubPhase3AndRestartResolve", ROMX

; Sets wBattleSubPhase to 3 and wBattleResolveStep to 0 (A = 0 on return), so
; RunBattleActions_AfterAction runs next. ResolveStepEffectChecks calls it when the target slot is
; absent and ResolveStepDamageMessage_RestartForTarget calls it after a target message. Same 10
; bytes as SetSubPhase3AndRestartResolve_Bank36. (C2, E-0380)
; sets wBattleSubPhase to 3 and clears wBattleResolveStep (E-0055)
SetSubPhase3AndRestartResolve::
    ld a, $03
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    ret

SECTION "Bank 36 ComputeAttackDamage", ROMX

; Plain attack damage: AdvanceRandom, then BC = the DEF word of wBattleTarget (wBattleDEF) divided
; by 2, then falls into ComputeBasicDamage, which uses the ATK of the actor. The 16-bit damage ends
; in wBattleDamageLo/Hi (and DE). ActionEffect_Fight, ActionEffect_SquallHit, ActionEffect_RainSlash
; and many others call it. (C2, E-0380)
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

; The damage formula. It loads HL = the ATK word of wBattleActor (GetBattleATK); BC = the defence
; value the caller sets (ComputeAttackDamage passes DEF / 2, ActionEffect_ActionD7_Damage passes 0).
; If ATK is not above BC the damage is RandomInRange(0, 1). Otherwise half = (ATK - BC) / 2: when
; ATK / 16 is at least half the damage is RandomInRange(0, ATK / 16); else it is half +
; RandomInRange(-(half / 16), half / 16) + RandomInRange(-1, 1). The 16-bit result goes to
; wBattleDamageLo/Hi and DE. (C2, E-0380)
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

SECTION "Bank 36 ActionEffect_ActionD1_Damage", ROMX

; Damage for ACTION_D1: rolls the skill damage from its record (RollSkillDamageFromRecord, which
; leaves HL at the target's wBattleStatus8 entry) and scales it with level 0
; (ScaleDamageByFlagsAtHL). (C2, E-0372; probed E-0380)
ActionEffect_ActionD1_Damage::
    call RollSkillDamageFromRecord
    ld a, $00
    call ScaleDamageByFlagsAtHL
    ret

SECTION "Bank 36 ActionEffect_ActionD2_ScaleByGigaSlashResistance", ROMX

; Damage for action $D2, called by ActionEffect_ActionD2: SkillDamageScaledByGigaSlashResistance
; (the rolled skill damage scaled by the GigaSlash resistance of the target), then times 3 / 2
; (ScaleDamageBy3Over2: damage + damage / 2) when the species family of the target
; (GetTargetSpeciesFamily) is 0, 8 or 9 (Slime, Material or Water); any other family leaves it. (C2,
; E-0380)
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

SECTION "Bank 36 ActionEffect_ActionD3_ScaleByGigaSlashResistance", ROMX

; Damage for action $D3, called by ActionEffect_ActionD3: SkillDamageScaledByGigaSlashResistance
; (the rolled skill damage scaled by the GigaSlash resistance of the target), then times 3 / 2
; (ScaleDamageBy3Over2: damage + damage / 2) when the species family of the target
; (GetTargetSpeciesFamily) is 1, 3 or 6 (Dragon, Bird or Demon); any other family leaves it. (C2,
; E-0380)
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

SECTION "Bank 36 ActionEffect_ActionD4_ScaleByGigaSlashResistance", ROMX

; Damage for action $D4, called by ActionEffect_ActionD4: SkillDamageScaledByGigaSlashResistance
; (the rolled skill damage scaled by the GigaSlash resistance of the target), then times 3 / 2
; (ScaleDamageBy3Over2: damage + damage / 2) when the species family of the target
; (GetTargetSpeciesFamily) is 2, 4 or 5 (Beast, Plant or Bug); any other family leaves it. (C2,
; E-0380)
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

SECTION "Bank 36 ActionEffect_ActionD7_Damage", ROMX

; Damage for ACTION_D7: AdvanceRandom and ComputeBasicDamage (BC = 0) for the actor, then the same
; with wBattleActor set to its formation partner (ActorFormationSlotToTemp0); wBattleDamageLo/Hi =
; the 16-bit sum of the two; wBattleActor is restored. (C2, E-0372; probed E-0380)
ActionEffect_ActionD7_Damage::
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

SECTION "Bank 36 ActionEffect_ActionD8_Damage", ROMX

; Damage for ACTION_D8: ComputeAttackDamage for the actor, then for its formation partner
; (ActorFormationSlotToTemp0) as wBattleActor; wBattleDamageLo/Hi = the 16-bit sum; wBattleActor is
; restored. (C2, E-0372; probed E-0380)
ActionEffect_ActionD8_Damage::
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

SECTION "Bank 36 ActionEffect_ActionD9_Damage", ROMX

; Damage for action $D9, called by ActionEffect_ActionD9: E is read as a slot number without being
; loaded here (it is whatever the caller left; the level of that slot is used for both halves). With
; M = wAllMPSpent and L = wBattleLevel of slot E it builds 8 x M + 8 x L (16-bit): 2M + 2L, then
; adds 2M again (after setting wBattleActor to the formation partner of the actor for the pass,
; ActorFormationSlotToTemp0), adds 2L and doubles it. wBattleActor is restored, then it jumps to
; ActionEffect_MegaMagic_Damage_SpreadAndResist (a random spread of about 10 percent each way, then
; the byte 4 bits 7-6 resistance scaling). The damage is not cut to 40 percent. (C2, E-0380)
ActionEffect_ActionD9_Damage::
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
    jp ActionEffect_MegaMagic_Damage_SpreadAndResist
    db $c9

; Damage for ActionEffect_Blaze: rolls the skill damage from its record (RollSkillDamageFromRecord,
; leaving HL at the target's wBattleStatus8 entry) and scales it by the target's RESIST_BLAZE level
; (byte 0 bits 5-4 of its wSlotResistances record) with ScaleDamageByFlagsAtHL. (C2, E-0372; probed
; E-0380)
ActionEffect_Blaze_Damage::
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte0
    swap a
    and $03
    call ScaleDamageByFlagsAtHL
    ret

SECTION "Bank 36 ActionEffect_Firebal_Damage", ROMX

; Damage for ActionEffect_Firebal: rolls the skill damage from its record
; (RollSkillDamageFromRecord, leaving HL at the target's wBattleStatus8 entry) and scales it by the
; target's RESIST_FIREBAL level (byte 0 bits 3-2 of its wSlotResistances record) with
; ScaleDamageByFlagsAtHL. (C2, E-0372; probed E-0380)
ActionEffect_Firebal_Damage::
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte0
    rrca
    rrca
    and $03
    call ScaleDamageByFlagsAtHL
    ret

SECTION "Bank 36 ActionEffect_Bang_Damage", ROMX

; Damage for ActionEffect_Bang: rolls the skill damage from its record (RollSkillDamageFromRecord,
; leaving HL at the target's wBattleStatus8 entry) and scales it by the target's RESIST_BANG level
; (byte 0 bits 1-0 of its wSlotResistances record) with ScaleDamageByFlagsAtHL. (C2, E-0372; probed
; E-0380)
ActionEffect_Bang_Damage::
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte0
    and $03
    call ScaleDamageByFlagsAtHL
    ret

SECTION "Bank 36 ActionEffect_Infernos_Damage", ROMX

; Damage for ActionEffect_Infernos: rolls the skill damage from its record
; (RollSkillDamageFromRecord, leaving HL at the target's wBattleStatus8 entry) and falls into
; ScaleDamageByVacuumResistance, which scales it by the target's RESIST_VACUUM level (byte 1 bits
; 7-6) with ScaleDamageByFlagsAtHL. (C2, E-0372; probed E-0380)
ActionEffect_Infernos_Damage::
    call RollSkillDamageFromRecord

; HL = the wBattleStatus8 entry of the target (its bits 6 and 7 pick the table), wBattleDamageLo/Hi
; = the damage. Scales the damage by the RESIST_VACUUM level of the target (byte 1 bits 7-6 of its
; wSlotResistances record) with ScaleDamageByFlagsAtHL. ActionEffect_Infernos_Damage falls into it;
; ActionEffect_WindBeast_Damage and ActionEffect_Vacuum_Damage call it. (C2, E-0380)
; scales the skill damage in HL by the target's Vacuum (byte 1, bits 7-6) resistance level (2 bits);
; used by Vacuum and WindBeast (E-0338)
ScaleDamageByVacuumResistance::
    call GetTargetSlotResistancesByte1
    rlca
    rlca
    and $03
    call ScaleDamageByFlagsAtHL
    ret

SECTION "Bank 36 RollSkillDamageScaledByBoltResistance", ROMX

; Rolls the skill damage from its record (RollSkillDamageFromRecord, which leaves HL at the
; wBattleStatus8 entry of the target) and falls into ScaleDamageByBoltResistance. Used by
; ActionEffect_Bolt and ActionEffect_ActionD0. (C2, E-0380)
; rolls the skill's damage from its record, then ScaleDamageByBoltResistance; used by Bolt and
; action $D0 (E-0338)
RollSkillDamageScaledByBoltResistance::
    call RollSkillDamageFromRecord

; HL = the wBattleStatus8 entry of the target (its bits 6 and 7 pick the table), wBattleDamageLo/Hi
; = the damage. Scales the damage by the RESIST_BOLT level of the target (byte 1 bits 5-4 of its
; wSlotResistances record) with ScaleDamageByFlagsAtHL. RollSkillDamageScaledByBoltResistance falls
; into it and ActionEffect_Lightning_Damage calls it. (C2, E-0380)
; scales the skill damage in HL by the target's Bolt (byte 1, bits 5-4) resistance level (2 bits);
; used by Bolt, Lightning and action $D0 (E-0338)
ScaleDamageByBoltResistance::
    call GetTargetSlotResistancesByte1
    swap a
    and $03
    call ScaleDamageByFlagsAtHL
    ret

SECTION "Bank 36 ActionEffect_IceBolt_Damage", ROMX

; Damage for ActionEffect_IceBolt: rolls the skill damage from its record
; (RollSkillDamageFromRecord, leaving HL at the target's wBattleStatus8 entry) and scales it by the
; target's RESIST_ICEBOLT level (byte 1 bits 3-2 of its wSlotResistances record) with
; ScaleDamageByFlagsAtHL. (C2, E-0372; probed E-0380)
ActionEffect_IceBolt_Damage::
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte1
    rrca
    rrca
    and $03
    call ScaleDamageByFlagsAtHL
    ret

SECTION "Bank 36 HealTargetHP", ROMX

; Adds an amount to the HP of wBattleTarget, not above its maximum (wBattleMaxHP), and returns carry
; set. The amount is also stored in wBattleDamageLo/Hi (before the cap). SKILL_FAREWELL, ACTION_B1,
; SKILL_LIFEDANCE and ACTION_DA use the maximum HP of the target as the amount; SKILL_HEALALL and
; SKILL_HEALUSALL do too when wLinkMode is 1 or the actor is in slots 0-3, and otherwise roll the
; skill amount (RollSkillDamageFromRecord) like any other action. ACTION_CF uses the maximum HP when
; wHealFlags of the actor is 0, 40 percent of it when that is 1 and 20 percent (the 40 percent
; halved) when it is 2 or more. ActionEffect_Heal and ActionEffect_ActionDA call it. (C2, E-0380)
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
    cp ACTION_B1
    jr z, .loop
    cp SKILL_LIFEDANCE
    jr z, .loop
    cp ACTION_CF
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

; MPass: gives the target 15 MP (MPass), 30 (MPassMore) or 80 (MPassMost), at most up to its max,
; with the amount in wBattleDamage; returns carry. (C2, E-0357; probed E-0380)
ActionEffect_MPass_GiveMP::
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

; Damage for ActionEffect_BigBang: rolls the skill damage from its record
; (RollSkillDamageFromRecord, leaving HL at the target's wBattleStatus8 entry) and scales it by the
; target's RESIST_BLAZE level (byte 0 bits 5-4 of its wSlotResistances record) with
; ScaleDamageByFlagsAtHLAlt. (C2, E-0372; probed E-0380)
ActionEffect_BigBang_Damage::
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte0
    swap a
    and $03
    call ScaleDamageByFlagsAtHLAlt
    ret

SECTION "Bank 36 ActionEffect_FireAir_Damage", ROMX

; Damage for ActionEffect_FireAir: rolls the skill damage from its record
; (RollSkillDamageFromRecord, leaving HL at the target's wBattleStatus8 entry) and scales it by the
; target's RESIST_FIREAIR level (byte 4 bits 5-4 of its wSlotResistances record) with
; ScaleDamageByFlagsAtHLAlt. (C2, E-0372; probed E-0380)
ActionEffect_FireAir_Damage::
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte4
    swap a
    and $03
    call ScaleDamageByFlagsAtHLAlt
    ret

SECTION "Bank 36 ActionEffect_FrigidAir_Damage", ROMX

; Damage for ActionEffect_FrigidAir: rolls the skill damage from its record
; (RollSkillDamageFromRecord, leaving HL at the target's wBattleStatus8 entry) and scales it by the
; target's RESIST_FRIGIDAIR level (byte 4 bits 3-2 of its wSlotResistances record) with
; ScaleDamageByFlagsAtHLAlt. (C2, E-0372; probed E-0380)
ActionEffect_FrigidAir_Damage::
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte4
    rrca
    rrca
    and $03
    call ScaleDamageByFlagsAtHLAlt
    ret

SECTION "Bank 36 ActionEffect_RockThrow_Damage", ROMX

; Damage for ActionEffect_RockThrow: rolls the skill damage from its record
; (RollSkillDamageFromRecord, leaving HL at the target's wBattleStatus8 entry) and scales it by the
; target's RESIST_ROCKTHROW level (byte 6 bits 5-4 of its wSlotResistances record) with
; ScaleDamageByFlagsAtHL. It is also entry 4 of EffectHandlerTable (RunEffectHandlerForActionId).
; (C2, E-0372; probed E-0380)
ActionEffect_RockThrow_Damage::
    call RollSkillDamageFromRecord
    call GetTargetSlotResistancesByte6
    swap a
    and $03
    call ScaleDamageByFlagsAtHL
    ret

SECTION "Bank 36 RaiseTargetDEF", ROMX

; Raises wBattleDEF of wBattleTarget by a third of its base DEF (GetBaseDEF), or by a half for
; SKILL_UPPER, and stores the real gain in wBattleDamageLo/Hi; returns carry set. It does nothing (A
; = 0, carry clear) when DEF is 999 or more, or at or above the cap, which is 2 x the base DEF for
; slots 4-7 outside link mode 1 and 4 x the base DEF otherwise (slots 0-3 and link mode 1); a DEF
; exactly at the cap or at 999 counts as full. A new DEF above 999 is cut to 999 (even when the cap
; is lower); otherwise a new DEF above the cap is cut to the cap; the damage is lowered by the cut
; amount. ActionEffect_Upper calls it. (C2, E-0380)
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

SECTION "Bank 36 RollVsSapResistance", ROMX

; HL is set to the wBattleStatus8 entry of wBattleTarget. Carry set = the action gets through the
; Sap resistance of the target (byte 3 bits 5-4 of its wSlotResistances record, a level 0-3, also
; copied to wBattleArg2). An actor with the concentrate act (wPersonalityActs bit 2) raises any
; level but 3 to 4 (ForceLevel4IfActorConcentrated), and level 4 always gets through. Otherwise it
; rolls by level: for SKILL_SICKLICK RollChanceByFlagsAtHLSided, else RollChanceByFlagsAtHL (level 3
; never gets through). ActionEffect_Sap and ActionEffect_LushLicks call it. (C2, E-0380)
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

SECTION "Bank 36 LowerTargetDEF_ApplyDrop", ROMX

; Lowers the target's DEF by a third of its base DEF (a half for Sap), not below 0, with the drop in
; wBattleDamage; no effect (A = 0) when DEF is already 0 or below 2. (C2, E-0357; probed E-0380)
LowerTargetDEF_ApplyDrop::
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

SECTION "Bank 36 RaiseTargetAGL", ROMX

; Raises wBattleAGL of wBattleTarget by a third of its base AGL (GetBaseAGL), or by a half for
; SKILL_SPEED, and stores the real gain in wBattleDamageLo/Hi; returns carry set. It does nothing (A
; = 0, carry clear) when AGL is above 999 or above the cap, which is 2 x the base AGL for slots 4-7
; outside link mode 1 and 4 x the base AGL otherwise. Unlike RaiseTargetDEF, an AGL exactly at 999
; or at the cap is still raised (and then cut back, so the gain is 0). A new AGL above 999 is cut to
; 999 (even when the cap is lower); otherwise a new AGL above the cap is cut to the cap; the damage
; is lowered by the cut amount. ActionEffect_Speed calls it. (C2, E-0380)
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

SECTION "Bank 36 RollVsSlowResistance", ROMX

; Carry set = the action gets through the Slow resistance of the target (byte 3 bits 3-2 of the
; wSlotResistances record of wBattleTarget). HL is set to the wBattleStatus8 entry of the target. An
; actor with the concentrate act raises any level but 3 to 4 (ForceLevel4IfActorConcentrated), and
; level 4 always gets through; otherwise RollChanceByFlagsAtHL (level 3 never gets through).
; ActionEffect_Slow calls it. (C2, E-0380)
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

SECTION "Bank 36 LowerTargetAGL_ApplyDrop", ROMX

; Lowers the target's AGL by a third of its base AGL (a half for Slow), keeping at least 1, with the
; drop in wBattleDamage; no effect (A = 0) when AGL is below 2. (C2, E-0357; probed E-0380)
LowerTargetAGL_ApplyDrop::
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

SECTION "Bank 36 AttackDamageScaledByBlazeResistance", ROMX

; ComputeAttackDamage, then HL = the wBattleStatus8 entry of the target and the damage is scaled by
; the RESIST_BLAZE level of the target (byte 0 bits 5-4 of its wSlotResistances record) with
; ScaleDamageByFlagsAtHLBit6: with bit 6 of the flags clear it uses the table 21/16, 37/32, 3/4, 30
; percent for levels 0-3, with bit 6 set 1, 85 percent, 1/2, 0. ActionEffect_FireSlash calls it.
; (C2, E-0380)
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

SECTION "Bank 36 AttackDamageScaledByVacuumResistance", ROMX

; ComputeAttackDamage, then HL = the wBattleStatus8 entry of the target and the damage is scaled by
; the RESIST_VACUUM level of the target (byte 1 bits 7-6 of its wSlotResistances record) with
; ScaleDamageByFlagsAtHLBit6: with bit 6 of the flags clear it uses the table 21/16, 37/32, 3/4, 30
; percent for levels 0-3, with bit 6 set 1, 85 percent, 1/2, 0. ActionEffect_VacuSlash calls it.
; (C2, E-0380)
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

SECTION "Bank 36 AttackDamageScaledByBoltResistance", ROMX

; ComputeAttackDamage, then HL = the wBattleStatus8 entry of the target and the damage is scaled by
; the RESIST_BOLT level of the target (byte 1 bits 5-4 of its wSlotResistances record) with
; ScaleDamageByFlagsAtHLBit6: with bit 6 of the flags clear it uses the table 21/16, 37/32, 3/4, 30
; percent for levels 0-3, with bit 6 set 1, 85 percent, 1/2, 0. ActionEffect_BoltSlash calls it.
; (C2, E-0380)
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

SECTION "Bank 36 AttackDamageScaledByIceBoltResistance", ROMX

; ComputeAttackDamage, then HL = the wBattleStatus8 entry of the target and the damage is scaled by
; the RESIST_ICEBOLT level of the target (byte 1 bits 3-2 of its wSlotResistances record) with
; ScaleDamageByFlagsAtHLBit6: with bit 6 of the flags clear it uses the table 21/16, 37/32, 3/4, 30
; percent for levels 0-3, with bit 6 set 1, 85 percent, 1/2, 0. ActionEffect_IceSlash calls it. (C2,
; E-0380)
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

SECTION "Bank 36 AttackDamageHalvedDEFVsSlime", ROMX

; Attack damage that ignores more defence against one species family: when the species family of the
; target (GetTargetSpeciesFamily) is 0 (Slime) it runs ComputeAttackDamageWithHalvedDEF (the DEF
; word of the target is halved first, so DEF / 4 is used, and put back afterwards), otherwise
; ComputeAttackDamage. The result is in wBattleDamageLo/Hi. ActionEffect_SlimeBlow calls it. (C2,
; E-0380)
; when the target's species family (GetTargetSpeciesFamily) is 0 (Slime), damage =
; ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
AttackDamageHalvedDEFVsSlime::
    call GetTargetSpeciesFamily
    cp $00
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

SECTION "Bank 36 AttackDamageHalvedDEFVsDragon", ROMX

; Attack damage that ignores more defence against one species family: when the species family of the
; target (GetTargetSpeciesFamily) is 1 (Dragon) it runs ComputeAttackDamageWithHalvedDEF (the DEF
; word of the target is halved first, so DEF / 4 is used, and put back afterwards), otherwise
; ComputeAttackDamage. The result is in wBattleDamageLo/Hi. (C2, E-0380)
; when the target's species family (GetTargetSpeciesFamily) is 1 (Dragon), damage =
; ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
AttackDamageHalvedDEFVsDragon::
    call GetTargetSpeciesFamily
    cp $01
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

SECTION "Bank 36 AttackDamageHalvedDEFVsBeast", ROMX

; Attack damage that ignores more defence against one species family: when the species family of the
; target (GetTargetSpeciesFamily) is 2 (Beast) it runs ComputeAttackDamageWithHalvedDEF (the DEF
; word of the target is halved first, so DEF / 4 is used, and put back afterwards), otherwise
; ComputeAttackDamage. The result is in wBattleDamageLo/Hi. (C2, E-0380)
; when the target's species family (GetTargetSpeciesFamily) is 2 (Beast), damage =
; ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
AttackDamageHalvedDEFVsBeast::
    call GetTargetSpeciesFamily
    cp $02
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

SECTION "Bank 36 AttackDamageHalvedDEFVsBird", ROMX

; Attack damage that ignores more defence against one species family: when the species family of the
; target (GetTargetSpeciesFamily) is 3 (Bird) it runs ComputeAttackDamageWithHalvedDEF (the DEF word
; of the target is halved first, so DEF / 4 is used, and put back afterwards), otherwise
; ComputeAttackDamage. The result is in wBattleDamageLo/Hi. (C2, E-0380)
; when the target's species family (GetTargetSpeciesFamily) is 3 (Bird), damage =
; ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
AttackDamageHalvedDEFVsBird::
    call GetTargetSpeciesFamily
    cp $03
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

SECTION "Bank 36 AttackDamageHalvedDEFVsBug", ROMX

; Attack damage that ignores more defence against one species family: when the species family of the
; target (GetTargetSpeciesFamily) is 5 (Bug) it runs ComputeAttackDamageWithHalvedDEF (the DEF word
; of the target is halved first, so DEF / 4 is used, and put back afterwards), otherwise
; ComputeAttackDamage. The result is in wBattleDamageLo/Hi. (C2, E-0380)
; when the target's species family (GetTargetSpeciesFamily) is 5 (Bug), damage =
; ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
AttackDamageHalvedDEFVsBug::
    call GetTargetSpeciesFamily
    cp $05
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

SECTION "Bank 36 AttackDamageHalvedDEFVsPlant", ROMX

; Attack damage that ignores more defence against one species family: when the species family of the
; target (GetTargetSpeciesFamily) is 4 (Plant) it runs ComputeAttackDamageWithHalvedDEF (the DEF
; word of the target is halved first, so DEF / 4 is used, and put back afterwards), otherwise
; ComputeAttackDamage. The result is in wBattleDamageLo/Hi. (C2, E-0380)
; when the target's species family (GetTargetSpeciesFamily) is 4 (Plant), damage =
; ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
AttackDamageHalvedDEFVsPlant::
    call GetTargetSpeciesFamily
    cp $04
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

SECTION "Bank 36 AttackDamageHalvedDEFVsDemon", ROMX

; Attack damage that ignores more defence against one species family: when the species family of the
; target (GetTargetSpeciesFamily) is 6 (Demon) it runs ComputeAttackDamageWithHalvedDEF (the DEF
; word of the target is halved first, so DEF / 4 is used, and put back afterwards), otherwise
; ComputeAttackDamage. The result is in wBattleDamageLo/Hi. (C2, E-0380)
; when the target's species family (GetTargetSpeciesFamily) is 6 (Demon), damage =
; ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
AttackDamageHalvedDEFVsDemon::
    call GetTargetSpeciesFamily
    cp $06
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

SECTION "Bank 36 AttackDamageHalvedDEFVsZombie", ROMX

; Attack damage that ignores more defence against one species family: when the species family of the
; target (GetTargetSpeciesFamily) is 7 (Zombie) it runs ComputeAttackDamageWithHalvedDEF (the DEF
; word of the target is halved first, so DEF / 4 is used, and put back afterwards), otherwise
; ComputeAttackDamage. The result is in wBattleDamageLo/Hi. (C2, E-0380)
; when the target's species family (GetTargetSpeciesFamily) is 7 (Zombie), damage =
; ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
AttackDamageHalvedDEFVsZombie::
    call GetTargetSpeciesFamily
    cp $07
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

SECTION "Bank 36 AttackDamageHalvedDEFVsMaterial", ROMX

; Attack damage that ignores more defence against one species family: when the species family of the
; target (GetTargetSpeciesFamily) is 8 (Material) it runs ComputeAttackDamageWithHalvedDEF (the DEF
; word of the target is halved first, so DEF / 4 is used, and put back afterwards), otherwise
; ComputeAttackDamage. The result is in wBattleDamageLo/Hi. (C2, E-0380)
; when the target's species family (GetTargetSpeciesFamily) is 8 (Material), damage =
; ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
AttackDamageHalvedDEFVsMaterial::
    call GetTargetSpeciesFamily
    cp $08
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

SECTION "Bank 36 AttackDamageHalvedDEFVsWater", ROMX

; Attack damage that ignores more defence against one species family: when the species family of the
; target (GetTargetSpeciesFamily) is 9 (Water) it runs ComputeAttackDamageWithHalvedDEF (the DEF
; word of the target is halved first, so DEF / 4 is used, and put back afterwards), otherwise
; ComputeAttackDamage. The result is in wBattleDamageLo/Hi. ActionEffect_AquaCut calls it. (C2,
; E-0380)
; when the target's species family (GetTargetSpeciesFamily) is 9 (Water), damage =
; ComputeAttackDamageWithHalvedDEF; otherwise ComputeAttackDamage (E-0115)
AttackDamageHalvedDEFVsWater::
    call GetTargetSpeciesFamily
    cp $09
    jp nz, ComputeAttackDamage
    jp ComputeAttackDamageWithHalvedDEF

SECTION "Bank 36 AttackDamageTimes1_5IfSlotBodyFlagsBit0", ROMX

; ComputeAttackDamage, then when bit 0 of the wSlotBodyFlags byte of wBattleTarget is set (a metal
; body, per SPECIES_METAL) the damage becomes damage + damage / 2 + 1. ActionEffect_MetalCut calls
; it. (C2, E-0380)
; ComputeAttackDamage, then damage = damage * 3 / 2 + 1 when bit 0 of wSlotBodyFlags[target] is set
; (E-0124)
AttackDamageTimes1_5IfSlotBodyFlagsBit0::
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

SECTION "Bank 36 RollVsRadiantResistance", ROMX

; Carry set = the action gets through the Radiant resistance of the target (byte 1 bits 1-0 of the
; wSlotResistances record of wBattleTarget). SKILL_ULTRADOWN always gets through at once. Otherwise
; HL is set to the wBattleStatus8 entry of the target; an actor with the concentrate act raises any
; level but 3 to 4 (ForceLevel4IfActorConcentrated), and level 4 always gets through; else it rolls
; by level with RollChanceByHLBits6And7 for SKILL_SANDSTORM and RollChanceByFlagsAtHL for the others
; (level 3 never gets through). ActionEffect_Radiant_Blind and ActionEffect_Surround call it. (C2,
; E-0380)
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

SECTION "Bank 36 RollVsRobMagicResistance", ROMX

; Carry set = the action gets through the RobMagic resistance of the target (byte 2 bits 3-2 of the
; wSlotResistances record of wBattleTarget). HL is set to the wBattleStatus8 entry of the target and
; the level is also stored in wBattleArg2. An actor with the concentrate act raises any level but 3
; to 4 (ForceLevel4IfActorConcentrated), and level 4 always gets through; otherwise
; RollChanceByFlagsAtHL (level 3 never gets through). ActionEffect_RobMagic and
; ActionEffect_OddDance call it. (C2, E-0380)
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

SECTION "Bank 36 ActionEffect_RobMagic_StealMP", ROMX

; Takes MP from the target (DrainTargetMPAmount, which also stores the amount BC as the damage) and
; adds BC to the wBattleMP word of wBattleActor (16-bit); when ActionEffect_RobMagic_MPAboveMax then
; sets carry, the MP is set to the wBattleMaxMP word of the actor. ActionEffect_RobMagic calls it
; for the actor and, for action $DF, again with its formation partner as wBattleActor. (C2, E-0372;
; probed E-0380)
ActionEffect_RobMagic_StealMP::
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
    call ActionEffect_RobMagic_MPAboveMax
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

SECTION "Bank 36 DrainTargetMPAmount", ROMX

; Takes MP from wBattleTarget: the amount BC is the level of the actor (wBattleLevel) / 4 + 5, at
; most all the MP of the target, and 0 when the target has no MP; for wBattleActionId $DF it is
; instead the word wSavedActorSlot (low) / wSavedActorByte (high), with no limit (the MP word wraps
; if it is smaller). The amount is subtracted from the wBattleMP word of the target, stored in
; wBattleDamageLo/Hi and left in BC. ActionEffect_RobMagic_StealMP and ActionEffect_OddDance call
; it. (C2, E-0380)
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

SECTION "Bank 36 ActionEffect_StopSpell_RollVsResistance", ROMX

; Roll for ActionEffect_StopSpell: carry = it gets through. Level = the target's RESIST_STOPSPELL
; (byte 2 bits 1-0 of wSlotResistances), raised to 4 by ForceLevel4IfActorConcentrated unless it is
; 3; level 4 always gets through, otherwise RollChanceByFlagsAtHL with HL at the target's
; wBattleStatus8 entry. (C2, E-0372; probed E-0380)
ActionEffect_StopSpell_RollVsResistance::
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

SECTION "Bank 36 ActionEffect_PanicAll_RollVsResistance", ROMX

; Roll for ActionEffect_PanicAll: carry = it gets through. Level = the target's RESIST_PANICALL
; (byte 3 bits 7-6), or 0 for action $E1; ForceLevel4IfActorConcentrated may raise it to 4, which
; always gets through; otherwise RollChanceByFlagsAtHLSided with HL at the target's wBattleStatus8
; entry. (C2, E-0372; probed E-0380)
ActionEffect_PanicAll_RollVsResistance::
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

SECTION "Bank 36 ActionEffect_Transform_TakeTargetStats", ROMX

; Transform: the actor takes the target's body flags, its base HP and MP as maximums (current values
; capped), base ATK, DEF and AGL, then its resistances and the rest. (C2, E-0357; probed E-0380)
ActionEffect_Transform_TakeTargetStats::
    ld a, [wBattleTarget]
    call ActionEffect_Transform_GetBodyFlags
    ld a, [wBattleActor]
    ld hl, wSlotBodyFlags
    add_a_to_hl
    ld [hl], c
    ld a, [wBattleTarget]
    call ActionEffect_Transform_CappedBaseHP
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
    call ActionEffect_Transform_CappedBaseMP
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
    call ActionEffect_Transform_ResistancesAddress
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
    farcall PackResistancesFromBattleArgs
    ld a, [wBattleTarget]
    call ActionEffect_Transform_SkillListAddress
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

SECTION "Bank 36 ActionEffect_MegaMagic_Damage", ROMX

; Damage for MegaMagic: 2 x wAllMPSpent + 2 x the wBattleLevel of the actor (16-bit) in
; wBattleDamageLo/Hi, then it falls into ActionEffect_MegaMagic_Damage_SpreadAndResist, which adds a
; random amount of up to about 10 percent either way and scales the result by the target resistance.
; The damage itself is not cut to 40 percent; only the size of the spread is 40 percent / 4. (C2,
; E-0380)
ActionEffect_MegaMagic_Damage::
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

; HL = base damage (already in wBattleDamageLo/Hi): spread = HL x 40% / 4 (ScaleHLTo40Percent then
; ShiftHLRight2, so 10%); when non-zero, adds RandomInRange(-spread, spread) to wBattleDamageLo/Hi
; (the damage itself is not cut). Then scales it by the target's RESIST_MEGAMAGIC level (byte 4 bits
; 7-6) with ScaleDamageByFlagsAtHLAlt. ActionEffect_MegaMagic_Damage falls into it and
; ActionEffect_ActionD9_Damage jumps to it. (C2, E-0372; probed E-0380)
ActionEffect_MegaMagic_Damage_SpreadAndResist::
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

SECTION "Bank 36 ActionEffect_WindBeast_Damage", ROMX

; Damage for ActionEffect_WindBeast, from the actor's wBattleLevel L: 3 x L + 10, or L + L / 2 for
; an actor in slots 4-7 outside link mode 1; at most 180; then plus RandomInRange of minus to plus
; 15% (ScaleHLTo30Percent / 2), and the RESIST_VACUUM scaling (ScaleDamageByVacuumResistance). Also
; entry 1 of EffectHandlerTable. (C2, E-0372; probed E-0380)
ActionEffect_WindBeast_Damage::
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

SECTION "Bank 36 ActionEffect_Vacuum_Damage", ROMX

; Damage for ActionEffect_Vacuum, from the actor's wBattleLevel L: 2 x L + 30, at most 150; then
; plus RandomInRange of minus to plus 10% (ScaleHLTo40Percent / 4) and the RESIST_VACUUM scaling.
; The L + L / 2 branch is taken only when wLinkMode (not the actor) is 4 or more and not 1, so foes
; use the same formula. Also entry 2 of EffectHandlerTable. (C2, E-0372; probed E-0380)
ActionEffect_Vacuum_Damage::
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

SECTION "Bank 36 ActionEffect_Lightning_Damage", ROMX

; Damage for ActionEffect_Lightning, from the actor's wBattleLevel L: 2 x L + 20, or L + L / 2 for
; an actor in slots 4-7 outside link mode 1; at most 180 (220 when GetTargetSpeciesFamily returns
; 9); then plus RandomInRange of minus to plus 10% and the RESIST_BOLT scaling
; (ScaleDamageByBoltResistance). Also entry 3 of EffectHandlerTable. (C2, E-0372; probed E-0380)
ActionEffect_Lightning_Damage::
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

SECTION "Bank 36 ActionEffect_MultiCut_Damage", ROMX

; Damage for ActionEffect_MultiCut: loads the skill record of wBattleActionId (LoadSkillRecord) and
; rolls RandomInRange(base, base + spread) from record bytes $9-$B (link mode 1 or actor in slots
; 0-3) or $D-$F (an actor in slots 4-7); multiplies by 21/16 (ScaleHLBy21Over16) when
; GetTargetSpeciesFamily returns 7; then scales by the target's RESIST_VACUUM level (byte 1 bits
; 7-6) with ScaleDamageByFlagsAtHLAlt. (C2, E-0372; probed E-0380)
ActionEffect_MultiCut_Damage::
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

SECTION "Bank 36 SkillDamageScaledByGigaSlashResistance", ROMX

; Rolls the skill damage from its record (RollSkillDamageFromRecord, HL left at the wBattleStatus8
; entry of the target) and scales it by the RESIST_GIGASLASH level of the target (byte 6 bits 3-2 of
; its wSlotResistances record) with ScaleDamageByFlagsAtHL. ActionEffect_GigaSlash,
; ActionEffect_ActionD5 and the three D2-D4 routines call it. (C2, E-0380)
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

SECTION "Bank 36 DamageEightyPercentOfTargetHPScaled", ROMX

; Sets the damage word wBattleDamageLo/wBattleDamageHi to the HP of wBattleTarget times 8 / 10, plus
; 1 (ScaleHLTo80Percent_Bank36), then scales it with ScaleDamageByFlagsAtHL: the level is bits 1-0
; of byte 3 of the resistance record of the target (RESIST_SACRIFICE) and HL is the wBattleStatus8
; entry of the target. ActionEffect_Ramming calls it. (C2, E-0382)
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

SECTION "Bank 36 ActionEffect_Kamikaze_Damage", ROMX

; Roll and damage for ActionEffect_Kamikaze: rolls RollChanceByFlagsAtHL with the target's
; RESIST_SACRIFICE level (byte 3 bits 1-0). On failure the damage is 0, A = 0, no carry. On success
; the damage starts as the actor's HP, then the word at the address given by that HP value is read
; (an apparent second dereference): when it is 1 the damage is 1; otherwise outside a link in
; wBattleKind 0 or 1 the damage is the target's HP - 1, else (the actor's HP - 1) / 2, at least 1;
; returns carry. (C2, E-0372; probed E-0382)
ActionEffect_Kamikaze_Damage::
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

SECTION "Bank 36 ActionEffect_Curse_RollVsResistance", ROMX

; Roll for ActionEffect_Curse: carry = it gets through. Level = the target's RESIST_CURSE (byte 5
; bits 5-4); ForceLevel4IfActorConcentrated may raise it to 4, which always gets through; otherwise
; RollChanceByFlagsAtHLSided with HL at the target's wBattleStatus8 entry. (C2, E-0372; probed
; E-0382)
ActionEffect_Curse_RollVsResistance::
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

SECTION "Bank 36 RollVsBeatResistance", ROMX

; Roll for the Beat family of actions; carry = it gets through. Fails at once (FailResistanceRoll: A
; = 0, E = 1) for an ally actor in wBattleKind 2 or 3 (ZIfAllyActorInBattleKindMode2Or3). Otherwise
; the level is bits 5-4 of byte 2 of the resistance record of the target (RESIST_BEAT), kept in
; wBattleArg2; ForceLevel4IfActorConcentrated raising it to 4 gets through without a roll. Else
; wBattleActionId picks the table with HL at the wBattleStatus8 entry of the target: actions with an
; id below SKILL_BEAT, and SKILL_DEFEAT and SKILL_KODANCE, use RollChanceByFlagsAtHLSided,
; SKILL_ULTRADOWN uses RollChanceByHLBits6And7, every other action (SKILL_BEAT itself) uses
; RollChanceByFlagsAtHL. ActionEffect_Beat and ActionEffect_UltraDown call it. (C2, E-0382)
; rolls whether the action gets through the target's Beat (byte 2, bits 5-4) resistance (a 2-bit
; level; certain when ForceLevel4IfActorConcentrated gives 4); used by Beat and UltraDown; carry =
; it gets through (E-0095, E-0338)
RollVsBeatResistance::
    call ZIfAllyActorInBattleKindMode2Or3
    jp z, FailResistanceRoll
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

SECTION "Bank 36 RollVsLegSweepResistance", ROMX

; Roll against the LegSweep resistance of the target (byte 5 bits 3-2, RESIST_LEGSWEEP); carry = it
; gets through. HL is the wBattleStatus8 entry of the target. For SKILL_LUREDANCE, SKILL_BIGTRIP and
; SKILL_WARCRY a level raised to 4 by ForceLevel4IfActorConcentrated gets through at once, else
; RollChanceByFlagsAtHLSided rolls; every other action (Ahhh, LegSweep, LushLicks) goes straight to
; RollChanceByFlagsAtHL. Called by ActionEffect_Ahhh, ActionEffect_LureDance,
; ActionEffect_LushLicks, ActionEffect_WarCry and ActionEffect_LegSweep_RollVsLegSweepResistance.
; (C2, E-0382)
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

SECTION "Bank 36 ActionEffect_UltraDown_CanLower", ROMX

; Returns A = 0 and no carry (nothing left to lower) only when the target's wBattleDEF and
; wBattleAGL words are both 1 and it has BSTAT1_BLINDED; otherwise carry. ActionEffect_UltraDown
; lowers DEF (LowerTargetDEF) only on carry. (C2, E-0372; probed E-0382)
ActionEffect_UltraDown_CanLower::
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

SECTION "Bank 36 ActionEffect_TatsuCall_PutMonsterIn", ROMX

; TatsuCall: puts the side's special monster (wSpecialSlotMonsters, by the side of wLoadSlot) into
; slot wLoadSlot: clears its status, marks it in and fills its species, level, HP, MP, ATK, DEF, AGL
; and INT from its monster record (INT from record bytes $12-$13) and the rest. (C2, E-0357; probed
; E-0382)
ActionEffect_TatsuCall_PutMonsterIn::
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
    call ActionEffect_TatsuCall_PutMonsterIn_StoreByte
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
    ld a, [wRecordBufferData + $12]
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
    call ActionEffect_TatsuCall_PutMonsterIn_StoreByte
    ld a, [wRecordBufferData + $15]
    ld c, a
    ld hl, wSlotPersonalityLo
    call ActionEffect_TatsuCall_PutMonsterIn_StoreByte
    ld a, [wRecordBufferData + $16]
    ld c, a
    ld hl, wSlotPersonalityMid
    call ActionEffect_TatsuCall_PutMonsterIn_StoreByte
    ld a, [wRecordBufferData + $17]
    ld c, a
    ld hl, wSlotTrait
    call ActionEffect_TatsuCall_PutMonsterIn_StoreByte
    ld c, $00
    ld hl, wSlotBodyFlags
    call ActionEffect_TatsuCall_PutMonsterIn_StoreByte
    ld c, $00
    ld hl, wSlotNameSuffix
    call ActionEffect_TatsuCall_PutMonsterIn_StoreByte
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
    farcall PackResistancesFromBattleArgs
    ld hl, wRecordBufferData
    ld de, wTemp0
    ld bc, $0004
    call CopyBytes
    ld hl, wTemp0
    call ActionEffect_TatsuCall_CopySkills
    ret

SECTION "Bank 36 ActionEffect_TatsuCall_CopySkills", ROMX

; Copies up to four skills from HL into slot wLoadSlot's skill list, each with the high nibble of
; its record byte 3, stopping at $FF. (C2, E-0357; probed E-0382)
ActionEffect_TatsuCall_CopySkills::
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

SECTION "Bank 36 ActionEffect_TatsuCall_PutMonsterIn_StoreByte", ROMX

; HL = byte table, C = value: stores C at HL + wLoadSlot (the byte counterpart of
; StoreBCAtWordEntryLoadSlot). ActionEffect_TatsuCall_PutMonsterIn uses it for wBattleLevel, the
; personality bytes, wSlotTrait, wSlotBodyFlags and wSlotNameSuffix. (C2, E-0372; probed E-0382)
ActionEffect_TatsuCall_PutMonsterIn_StoreByte::
    ld a, [wLoadSlot]
    add_a_to_hl
    ld [hl], c
    ret

SECTION "Bank 36 StoreBCAtWordEntryLoadSlot", ROMX

; HL = word table: stores C at HL + 2 * wLoadSlot and B in the next byte (low byte first); HL ends
; on the high byte. ActionEffect_TatsuCall_PutMonsterIn uses it for the monster id, HP, maximum HP,
; MP, maximum MP, ATK, DEF, AGL, INT and extra-stat words of the new monster. (C2, E-0382)
; HL = table: stores BC (low byte first) at HL + 2 * wLoadSlot (E-0073)
StoreBCAtWordEntryLoadSlot::
    ld a, [wLoadSlot]
    add a
    add_a_to_hl
    ld [hl], c
    inc hl
    ld [hl], b
    ret

SECTION "Bank 36 ActionEffect_LegSweep_RollVsLegSweepResistance", ROMX

; Roll for ActionEffect_LegSweep; carry = it gets through. Returns with no carry at once when bit 4
; of the wSlotBodyFlags byte of wBattleTarget is set (a target that cannot be tripped); otherwise
; RollVsLegSweepResistance decides. (C2, E-0382)
; RollVsLegSweepResistance for LegSweep (E-0338)
ActionEffect_LegSweep_RollVsLegSweepResistance::
    ld a, [wBattleTarget]
    ld hl, wSlotBodyFlags
    add_a_to_hl
    bit 4, [hl]
    ret nz
    call RollVsLegSweepResistance
    ret

SECTION "Bank 36 ActionEffect_DanceShut_RollVsResistance", ROMX

; Roll for ActionEffect_DanceShut: carry = it gets through. Level = the target's RESIST_DANCESHUT
; (byte 5 bits 1-0); ForceLevel4IfActorConcentrated may raise it to 4, which always gets through;
; otherwise RollChanceByFlagsAtHL with HL at the target's wBattleStatus8 entry. (C2, E-0372; probed
; E-0382)
ActionEffect_DanceShut_RollVsResistance::
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

SECTION "Bank 36 ActionEffect_MouthShut_RollVsResistance", ROMX

; Roll for ActionEffect_MouthShut: carry = it gets through. Level = the target's RESIST_MOUTHSHUT
; (byte 6 bits 7-6); ForceLevel4IfActorConcentrated may raise it to 4, which always gets through;
; otherwise RollChanceByFlagsAtHL with HL at the target's wBattleStatus8 entry. (C2, E-0372; probed
; E-0382)
ActionEffect_MouthShut_RollVsResistance::
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

SECTION "Bank 36 ActionEffect_CallHelp_Damage", ROMX

; CallHelp's damage: twice the actor's level (a foe outside link mode 1: 1.5 times), scaled by bits
; 4-5 of resistance byte 6. (C2, E-0357; probed E-0382)
ActionEffect_CallHelp_Damage::
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

SECTION "Bank 36 ActionEffect_BiAttack_Damage", ROMX

; Damage for SKILL_BIATTACK and SKILL_QUADHITS: temporarily replaces the actor's wBattleATK word
; with 30 x ATK cut to 75% (SKILL_BIATTACK) or 62.5% (other actions), runs ComputeBasicDamage with
; BC = 30 x the target's DEF / 2, divides the damage by 30 (DivideHLByA) and puts the old ATK back.
; Also entries 28 and 29 of EffectHandlerTable. (C2, E-0372; probed E-0382)
ActionEffect_BiAttack_Damage::
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

SECTION "Bank 36 ActionEffect_Meditate_Heal", ROMX

; Meditate: heals the actor 500 HP, at most to its max; NC when its HP is already full. (C2, E-0357;
; probed E-0382)
ActionEffect_Meditate_Heal::
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

SECTION "Bank 36 ActionEffect_Sacrifice_RollVsResistance", ROMX

; Roll for ActionEffect_Sacrifice (also for ACTION_D6, which jumps to it): carry = it gets through.
; Fails (FailResistanceRoll: A = 0, no carry) for an ally actor in wBattleKind 2 or 3
; (ZIfAllyActorInBattleKindMode2Or3). Level = the target's RESIST_SACRIFICE (byte 3 bits 1-0);
; ForceLevel4IfActorConcentrated may raise it to 4, which always gets through; otherwise ACTION_D6
; rolls RollChanceByLevel_100_100_75_40Percent and other actions
; ActionEffect_Sacrifice_RollChanceByFlags with HL at the target's wBattleStatus8 entry. (C2,
; E-0372; probed E-0382)
ActionEffect_Sacrifice_RollVsResistance::
    call ZIfAllyActorInBattleKindMode2Or3
    jp z, FailResistanceRoll
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
    jr z, .call_roll_chance_by_level_100_100_75_40
    pop af
    call ActionEffect_Sacrifice_RollChanceByFlags
    ret

.call_roll_chance_by_level_100_100_75_40:
    pop af
    call RollChanceByLevel_100_100_75_40Percent
    ret

SECTION "Bank 36 RollVsSleepResistance", ROMX

; Roll for the Sleep family of actions; carry = it gets through. It first rolls the skill damage
; from the record buffer into wBattleDamageLo/wBattleDamageHi (RollSkillDamageFromRecord, which also
; leaves HL at the wBattleStatus8 entry of the target), then takes the level from bits 7-6 of byte 2
; of the resistance record of the target (RESIST_SLEEP) into wBattleArg2.
; ForceLevel4IfActorConcentrated raising it to 4 gets through without a roll; otherwise SKILL_SLEEP
; rolls RollChanceByFlagsAtHL and every other action RollChanceByFlagsAtHLSided. ActionEffect_Sleep
; and ResolveStep0EEffect_RollVsSleepResistance call it. (C2, E-0382)
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

SECTION "Bank 36 ActionEffect_BeDragon_LoadDragonStats", ROMX

; Loads monster record $0082 ($0262 for ACTION_DC) into wMonsterId (LoadMonsterRecord) and gives the
; actor its max HP and MP (current HP and MP capped by ActionEffect_BeDragon_CapAtNewMax), ATK, DEF,
; AGL and INT (record bytes $12-$13), its AI mode from INT (SetSlotAIModeFromINT), its resistances
; from the species record (PackResistancesFromBattleArgs) and its four skills
; (ActionEffect_BeDragon_CopySkills); then clears its wSlotBodyFlags byte and sets bits 0 and 1 of
; its level-up gains byte (SetBit0OfLevelUpGainsIndexed_Bank36,
; SetBit1OfLevelUpGainsIndexed_Bank36). (C2, E-0372; probed E-0382)
ActionEffect_BeDragon_LoadDragonStats::
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
    call ActionEffect_BeDragon_CapAtNewMax
    ld a, [wRecordBufferData + $a]
    ld c, a
    ld a, [wRecordBufferData + $b]
    ld b, a
    ld hl, wBattleMaxMP
    call StoreBCAtActorWordEntry
    ld a, [wBattleActor]
    ld hl, wBattleMP
    call ActionEffect_BeDragon_CapAtNewMax
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
    ld a, [wRecordBufferData + $12]
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
    farcall PackResistancesFromBattleArgs
    ld hl, wRecordBufferData
    ld de, wTemp0
    ld bc, $0004
    call CopyBytes
    call ActionEffect_BeDragon_CopySkills
    ld a, [wBattleActor]
    ld hl, wSlotBodyFlags
    add_a_to_hl
    ld [hl], $00
    ld a, [wBattleActor]
    call SetBit0OfLevelUpGainsIndexed_Bank36
    ld a, [wBattleActor]
    call SetBit1OfLevelUpGainsIndexed_Bank36
    ret

SECTION "Bank 36 ActionEffect_BeDragon_CopySkills", ROMX

; Copies the four skill ids at wTemp0 into the actor's eight two-byte wBattleSkills entries (16
; bytes per slot): each id at the entry's address and the high nibble of its record byte 3
; (LoadSkillRecordPart) in the byte before it; an $FF id clears that entry instead
; (ActionEffect_BeDragon_ClearEntry writes $FF there and 0 before it). Then clears the remaining
; four entries (three calls and a fall-through into ActionEffect_BeDragon_ClearEntry). (C2, E-0372;
; probed E-0382)
ActionEffect_BeDragon_CopySkills::
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

; Writes $FF at DE and 0 in the byte before it (the empty skill entry of the skill list of a slot:
; id $FF, prefix 0), and leaves DE two higher than it was (it steps back one byte and forward
; three). ActionEffect_BeDragon_CopySkills calls it for an $FF id and runs into it after the last
; copied entry. (C2, E-0382)
; writes $FF at DE and 0 before it, then DE += 3
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

SECTION "Bank 36 StoreCAtActorEntry", ROMX

; HL = byte table, C = value: stores C at HL + wBattleActor; HL ends on that byte. Nothing in src/
; calls it. (C2, E-0382)
; [HL + wBattleActor] = C (E-0115)
StoreCAtActorEntry:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    ld a, [wBattleActor]
    add_a_to_hl
    ld [hl], c
    ret

SECTION "Bank 36 StoreBCAtActorWordEntry", ROMX

; HL = word table: stores C at HL + 2 * wBattleActor and B in the next byte (low byte first); HL
; ends on the high byte. ActionEffect_BeDragon_LoadDragonStats uses it for the new maximum HP,
; maximum MP, ATK, DEF, AGL and INT words of the actor. (C2, E-0382)
; HL = table: stores BC (low byte first) at HL + 2 * wBattleActor; HL ends on the high byte (E-0077)
StoreBCAtActorWordEntry::
    ld a, [wBattleActor]
    add a
    add_a_to_hl
    ld [hl], c
    inc hl
    ld [hl], b
    ret

SECTION "Bank 36 AttackDamageWithATK200", ROMX

; Sets the wBattleATK word of wBattleActor to 200, runs ComputeAttackDamage (the plain attack
; formula against the DEF of wBattleTarget, leaving the damage in wBattleDamageLo/wBattleDamageHi)
; and puts the old ATK word back. ActionEffect_ActionB9 calls it. (C2, E-0382)
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

SECTION "Bank 36 ActionEffect_Watershot_Damage", ROMX

; Watershot-type damage: rolls the skill damage from its record (RollSkillDamageFromRecord) and
; scales it by the target's RESIST_WATERSHOT level (byte 0 bits 7-6): with ScaleDamageByFlagsAtHL
; for SKILL_WATERSHOT, with ScaleDamageByFlagsAtHLAlt for any other action (SKILL_TIDALWAVE and
; EffectHandlerTable entries 5 and 6). (C2, E-0372; probed E-0382)
ActionEffect_Watershot_Damage::
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

SECTION "Bank 36 RollVsPoisonGasResistance", ROMX

; Roll against the PoisonGas resistance of the target (byte 4 bits 1-0, RESIST_POISONGAS); carry =
; it gets through. HL is the wBattleStatus8 entry of the target. ForceLevel4IfActorConcentrated
; raising the level to 4 gets through without a roll (D and E are then left pointing at the
; resistance byte); otherwise RollChanceByFlagsAtHLSided rolls and E = 0 on success, 1 on failure.
; Called by ActionEffect_PoisonGas, ItemEffect_BadMeat and ResolveStep0EEffect_Start. (C2, E-0382)
; rolls whether the action gets through the target's PoisonGas (byte 4, bits 1-0) resistance (a
; 2-bit level; certain when ForceLevel4IfActorConcentrated gives 4); used by PoisonGas,
; ItemEffect_BadMeat and ResolveStep0EEffect; carry = it gets through (E-0095, E-0338) (sided roll)
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

SECTION "Bank 36 RollVsPalsyAirResistance", ROMX

; Roll against the PalsyAir resistance of the target (byte 5 bits 7-6, RESIST_PALSYAIR); carry = it
; gets through. Fails at once (FailResistanceRoll: A = 0, E = 1) for an ally actor in wBattleKind 2
; or 3 (ZIfAllyActorInBattleKindMode2Or3). Otherwise HL is the wBattleStatus8 entry of the target;
; ForceLevel4IfActorConcentrated raising the level to 4 gets through without a roll (D and E are
; then left pointing at the resistance byte), else RollChanceByFlagsAtHLSided rolls and E = 0 on
; success, 1 on failure. Called by ActionEffect_PalsyAir and ResolveStep0EEffect_Start. (C2, E-0382)
; rolls whether the action gets through the target's PalsyAir (byte 5, bits 7-6) resistance (a 2-bit
; level; certain when ForceLevel4IfActorConcentrated gives 4); used by PalsyAir and
; ResolveStep0EEffect; carry = it gets through (E-0095, E-0338) (sided roll)
RollVsPalsyAirResistance::
    call ZIfAllyActorInBattleKindMode2Or3
    jp z, FailResistanceRoll
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

SECTION "Bank 36 ResolveStep0EEffect_RollVsSleepResistance", ROMX

; RollVsSleepResistance for resolve step $0E: carry = it gets through, E = 0 on success and 1 on
; failure. ResolveStep0EEffect_Start calls it. (C2, E-0382)
; RollVsSleepResistance for resolve step $0E (E-0338)
ResolveStep0EEffect_RollVsSleepResistance::
    call RollVsSleepResistance
    ld e, $00
    ret c
    ld e, $01
    ret

SECTION "Bank 36 ActionEffect_Geyser_RollVsResistance", ROMX

; Roll for ActionEffect_Geyser: carry = it gets through. RollChanceByFlagsAtHL with the target's
; RESIST_WATERSHOT level (byte 0 bits 7-6) and HL at its wBattleStatus8 entry; no
; ForceLevel4IfActorConcentrated step. (C2, E-0372; probed E-0382)
ActionEffect_Geyser_RollVsResistance::
    call HLToBattleStatus8EntryOfBattleTarget_Bank36
    call GetTargetSlotResistancesByte0
    swap a
    rrca
    rrca
    and $03
    call RollChanceByFlagsAtHL
    ret

SECTION "Bank 36 ActionEffect_EerieLite_RollVsResistance", ROMX

; Roll for ActionEffect_EerieLite: carry = it gets through. Level = the target's RESIST_BEAT (byte 2
; bits 5-4); ForceLevel4IfActorConcentrated may raise it to 4, which always gets through; otherwise
; RollChanceByFlagsAtHL with HL at the target's wBattleStatus8 entry. (C2, E-0372; probed E-0382)
ActionEffect_EerieLite_RollVsResistance::
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

SECTION "Bank 36 FailResistanceRoll", ROMX

; The shared failure exit of three resistance rolls: A = 0 (Z set), no carry, E = 1.
; RollVsBeatResistance, ActionEffect_Sacrifice_RollVsResistance and RollVsPalsyAirResistance jump
; here when ZIfAllyActorInBattleKindMode2Or3 reports an ally actor in wBattleKind 2 or 3. (C2,
; E-0372; probed E-0382)
FailResistanceRoll::
    xor a
    ld e, $01
    ret

SECTION "Bank 36 ZIfAllyActorInBattleKindMode2Or3", ROMX

; A = 0 and Z set when wBattleKind is 2 or 3 and wBattleActor is below 4 (an ally); otherwise A = 1
; and NZ. RollVsBeatResistance, ActionEffect_Sacrifice_RollVsResistance and RollVsPalsyAirResistance
; fail at once on Z. (C2, E-0382)
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

SECTION "Bank 36 RollSkillDamageFromRecord", ROMX

; Rolls the damage of the skill whose record is in wRecordBufferData: base word and spread byte are
; at +$D, +$E and +$F for an actor in slots 4-7 when wLinkMode is not 1, otherwise at +$9, +$A and
; +$B. The spread goes to wBattleArg2 and RollDamageBaseToBasePlusBattleArg2 stores base + (random
; mod (spread + 1)) in wBattleDamageLo/wBattleDamageHi. It then runs into
; HLToBattleStatus8EntryOfBattleTarget_Bank36, so it returns with HL = the wBattleStatus8 entry of
; wBattleTarget. (C2, E-0382)
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

; HL = wBattleStatus8 + 9 * wBattleTarget, the status byte 8 entry of the target (A is clobbered, BC
; and DE are kept). The damage and resistance routines call it to get the status byte whose bits 6
; and 7 (BSTAT8_MAGIC_WALL, BSTAT8_EERIE_LITE) the chance and damage-scaling pickers test. (C2,
; E-0382)
; HL = wBattleStatus8 + 9 * wBattleTarget (AddAx9ToHL); A is clobbered (E-0353: corrected; was: HL =
; wBattleStatus8 + 9 * [wBattleTarget] (AddAx9ToHL); A = [wBattleTarget]) (the same 10 bytes appear
; in 2 banks)
HLToBattleStatus8EntryOfBattleTarget_Bank36::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus8
    call AddAx9ToHL
    ret

SECTION "Bank 36 RollDamageBaseToBasePlusBattleArg2", ROMX

; HL = base, wBattleArg2 = spread: stores base + (random mod (spread + 1)) in
; wBattleDamageLo/wBattleDamageHi (RandomInRange from HL to HL + wBattleArg2; a zero spread stores
; the base without advancing the random state). HL is not kept: after RandomInRange with a non-zero
; spread it ends as $10000 minus the base (0 for a base of 0). (C2, E-0382)
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

SECTION "Bank 36 GetTargetSlotResistancesByte0", ROMX

; A = byte 0 of the 7-byte resistance record of wBattleTarget (wSlotResistances + 0 + 7 *
; wBattleTarget); DE points at it. It holds RESIST_WATERSHOT bits 7-6, RESIST_BLAZE bits 5-4,
; RESIST_FIREBAL bits 3-2, RESIST_BANG bits 1-0. Used by the Bang, Firebal, Blaze, Watershot and
; Geyser damage and roll routines. (C2, E-0382)
; A = byte 0 of the target's 7-byte resistance record (wSlotResistances + 0 + 7 * wBattleTarget); DE
; points at it; its four 2-bit fields are in wSlotResistances's note (E-0095, E-0338)
GetTargetSlotResistancesByte0::
    ld de, wSlotResistances
    jr GetTargetResistanceByte

SECTION "Bank 36 GetTargetSlotResistancesByte1", ROMX

; A = byte 1 of the 7-byte resistance record of wBattleTarget (wSlotResistances + 1 + 7 *
; wBattleTarget); DE points at it. It holds RESIST_VACUUM bits 7-6, RESIST_BOLT bits 5-4,
; RESIST_ICEBOLT bits 3-2, RESIST_RADIANT bits 1-0. Used by the IceBolt, Bolt, Vacuum, Radiant and
; MultiCut routines. (C2, E-0382)
; A = byte 1 of the target's 7-byte resistance record (wSlotResistances + 1 + 7 * wBattleTarget); DE
; points at it; its four 2-bit fields are in wSlotResistances's note (E-0095, E-0338)
GetTargetSlotResistancesByte1::
    ld de, wSlotResistances + $1
    jr GetTargetResistanceByte

SECTION "Bank 36 GetTargetSlotResistancesByte2", ROMX

; A = byte 2 of the 7-byte resistance record of wBattleTarget (wSlotResistances + 2 + 7 *
; wBattleTarget); DE points at it. It holds RESIST_SLEEP bits 7-6, RESIST_BEAT bits 5-4,
; RESIST_ROBMAGIC bits 3-2, RESIST_STOPSPELL bits 1-0. Used by the Sleep, Beat, EerieLite, RobMagic
; and StopSpell rolls. (C2, E-0382)
; A = byte 2 of the target's 7-byte resistance record (wSlotResistances + 2 + 7 * wBattleTarget); DE
; points at it; its four 2-bit fields are in wSlotResistances's note (E-0095, E-0338)
GetTargetSlotResistancesByte2::
    ld de, wSlotResistances + $2
    jr GetTargetResistanceByte

SECTION "Bank 36 GetTargetSlotResistancesByte3", ROMX

; A = byte 3 of the 7-byte resistance record of wBattleTarget (wSlotResistances + 3 + 7 *
; wBattleTarget); DE points at it. It holds RESIST_PANICALL bits 7-6, RESIST_SAP bits 5-4,
; RESIST_SLOW bits 3-2, RESIST_SACRIFICE bits 1-0. Used by the Sacrifice, Kamikaze, Slow, Sap,
; PanicAll and Ramming routines. (C2, E-0382)
; A = byte 3 of the target's 7-byte resistance record (wSlotResistances + 3 + 7 * wBattleTarget); DE
; points at it; its four 2-bit fields are in wSlotResistances's note (E-0095, E-0338)
GetTargetSlotResistancesByte3::
    ld de, wSlotResistances + $3
    jr GetTargetResistanceByte

SECTION "Bank 36 GetTargetSlotResistancesByte4", ROMX

; A = byte 4 of the 7-byte resistance record of wBattleTarget (wSlotResistances + 4 + 7 *
; wBattleTarget); DE points at it. It holds RESIST_MEGAMAGIC bits 7-6, RESIST_FIREAIR bits 5-4,
; RESIST_FRIGIDAIR bits 3-2, RESIST_POISONGAS bits 1-0. Used by the FireAir, FrigidAir, MegaMagic
; and PoisonGas routines. (C2, E-0382)
; A = byte 4 of the target's 7-byte resistance record (wSlotResistances + 4 + 7 * wBattleTarget); DE
; points at it; its four 2-bit fields are in wSlotResistances's note (E-0095, E-0338)
GetTargetSlotResistancesByte4::
    ld de, wSlotResistances + $4
    jr GetTargetResistanceByte

SECTION "Bank 36 GetTargetSlotResistancesByte5", ROMX

; A = byte 5 of the 7-byte resistance record of wBattleTarget (wSlotResistances + 5 + 7 *
; wBattleTarget); DE points at it. It holds RESIST_PALSYAIR bits 7-6, RESIST_CURSE bits 5-4,
; RESIST_LEGSWEEP bits 3-2, RESIST_DANCESHUT bits 1-0. Used by the Curse, DanceShut, LegSweep-type
; and PalsyAir rolls. (C2, E-0382)
; A = byte 5 of the target's 7-byte resistance record (wSlotResistances + 5 + 7 * wBattleTarget); DE
; points at it; its four 2-bit fields are in wSlotResistances's note (E-0095, E-0338)
GetTargetSlotResistancesByte5::
    ld de, wSlotResistances + $5
    jr GetTargetResistanceByte

SECTION "Bank 36 GetTargetSlotResistancesByte6", ROMX

; A = byte 6 of the 7-byte resistance record of wBattleTarget (wSlotResistances + 6 + 7 *
; wBattleTarget); DE points at it. It holds RESIST_MOUTHSHUT bits 7-6, RESIST_ROCKTHROW bits 5-4,
; RESIST_GIGASLASH bits 3-2; bits 1-0 are not read. Used by the RockThrow, CallHelp, MouthShut and
; GigaSlash routines. (C2, E-0382)
; A = byte 6 of the target's 7-byte resistance record (wSlotResistances + 6 + 7 * wBattleTarget); DE
; points at it; its four 2-bit fields are in wSlotResistances's note (E-0095, E-0338)
GetTargetSlotResistancesByte6::
    ld de, wSlotResistances + $6

; DE = a byte of the first resistance record (wSlotResistances + n): A = the byte at DE + 7 *
; wBattleTarget, DE ends pointing at it. GetTargetSlotResistancesByte0 to
; GetTargetSlotResistancesByte5 jump here and GetTargetSlotResistancesByte6 runs into it. (C2,
; E-0382)
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

SECTION "Bank 36 RollChanceByFlagsAtHL", ROMX

; A = level 0-3, HL = the status byte entry of the target: picks the chance table by its status
; bits; carry = success. BSTAT8_MAGIC_WALL (bit 6) set uses RollChanceByLevel_100_75_40_0, else
; BSTAT8_EERIE_LITE (bit 7) set uses RollChanceByLevel_100_100_75_0, else
; RollChanceByLevel_100_84_50_0. Most of the resistance rolls end here. (C2, E-0382)
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

SECTION "Bank 36 ActionEffect_Sacrifice_RollChanceByFlags", ROMX

; A = level, HL = the target's wBattleStatus8 entry: with BSTAT8_MAGIC_WALL (bit 6) set rolls
; RollChanceByLevel_100_84_50_0, otherwise RollChanceByLevel_100_100_75_0; carry = it gets through.
; Used by the Sacrifice roll (ActionEffect_Sacrifice_RollVsResistance) for actions other than
; ACTION_D6. (C2, E-0372; probed E-0382)
ActionEffect_Sacrifice_RollChanceByFlags::
    bit 6, [hl]
    jr z, .call_roll_chance_by_level_100_100_75_0
    call RollChanceByLevel_100_84_50_0
    jr .return

.call_roll_chance_by_level_100_100_75_0:
    call RollChanceByLevel_100_100_75_0

.return:
    ret

SECTION "Bank 36 RollChanceByHLBits6And7", ROMX

; A = level 0-3, HL = the status byte entry of the target: BSTAT8_MAGIC_WALL (bit 6) set rolls
; RollChanceByLevelAndSide, else BSTAT8_EERIE_LITE (bit 7) set rolls RollChanceByLevel_100_100_75_0,
; else RollChanceByLevel_100_75_40_0; carry = success. RollVsBeatResistance (for SKILL_ULTRADOWN)
; and RollVsRadiantResistance call it. (C2, E-0382)
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

SECTION "Bank 36 RollChanceByFlagsAtHLSided", ROMX

; A = level 0-3, HL = the status byte entry of the target: BSTAT8_EERIE_LITE (bit 7) set rolls
; RollChanceByLevel_100_84_50_0, otherwise RollChanceByLevelAndSide (bit 6 is not read); carry =
; success. (C2, E-0382)
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

SECTION "Bank 36 ScaleDamageByFlagsAtHL", ROMX

; A = level 0-3, HL = the status byte entry of the target: scales the damage word
; wBattleDamageLo/wBattleDamageHi by the table the status picks. BSTAT8_MAGIC_WALL (bit 6) set uses
; ScaleDamageByLevel_1_075_04_0, else BSTAT8_EERIE_LITE (bit 7) set uses
; ScaleDamageByLevel_131_116_075_03, else ScaleDamageByLevel_1_085_05_0. (C2, E-0382)
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

SECTION "Bank 36 ScaleDamageByFlagsAtHLAlt", ROMX

; A = level 0-3, HL = the status byte entry of the target: scales the damage word by the table the
; status picks. BSTAT8_MAGIC_WALL (bit 6) set uses ScaleDamageByLevel_075_05_025_0, else
; BSTAT8_EERIE_LITE (bit 7) set uses ScaleDamageByLevel_131_116_075_03, else
; ScaleDamageByLevel_1_075_04_0. (C2, E-0382)
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

SECTION "Bank 36 ScaleDamageByFlagsAtHLBit6", ROMX

; A = level 0-3, HL = the status byte entry of the target: scales the damage word with
; ScaleDamageByLevel_1_085_05_0 when BSTAT8_MAGIC_WALL (bit 6) is set, otherwise with
; ScaleDamageByLevel_131_116_075_03 (bit 7 is not read). (C2, E-0382)
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

SECTION "Bank 36 ScaleDamageByLevelByHLBit7", ROMX

; A = level 0-3, HL = a status byte: scales the damage word with ScaleDamageByLevel_1_085_05_0 when
; bit 7 (BSTAT8_EERIE_LITE for the status byte of a target) is set, otherwise with
; ScaleDamageByLevel_075_05_025_0. Nothing in src/ calls it. (C2, E-0382)
; bit 7 of [HL]: ScaleDamageByLevel_1_085_05_0, else ScaleDamageByLevel_075_05_025_0 (E-0122)
ScaleDamageByLevelByHLBit7:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    bit 7, [hl]
    jr z, .call_scale_damage_by_level_075_05_025_0
    call ScaleDamageByLevel_1_085_05_0
    jr .return

.call_scale_damage_by_level_075_05_025_0:
    call ScaleDamageByLevel_075_05_025_0

.return:
    ret

SECTION "Bank 36 RollChanceByFlagsAtHLAlt", ROMX

; A = level, HL = a status byte: bit 6 (BSTAT8_MAGIC_WALL for the status byte of a target) set rolls
; RollChanceByLevel_100_75_40_0, else bit 7 set rolls RollChanceByLevel_100_100_75_40Percent, else
; RollChanceForLevelA; carry = success. Nothing in src/ calls it. (C2, E-0382)
; bit 6 of [HL]: RollChanceByLevel_100_75_40_0; else bit 7: RollChanceByLevel_100_100_75_40Percent;
; else RollChanceForLevelA (E-0122) (E-0344: the address in its name dropped or read as the label
; there; was RollChanceByFlagsAtHLAlt)
RollChanceByFlagsAtHLAlt:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    bit 6, [hl]
    jr z, .skip
    call RollChanceByLevel_100_75_40_0
    jr .return

.skip:
    bit 7, [hl]
    jr z, .call_roll_chance_for_level_a
    call RollChanceByLevel_100_100_75_40Percent
    jr .return

.call_roll_chance_for_level_a:
    call RollChanceForLevelA

.return:
    ret

SECTION "Bank 36 RollChanceByLevel_100_84_50_0", ROMX

; A = level 0-3: carry set = success. Level 0 always succeeds and level 3 never does, both without
; touching the random state; level 1 succeeds when a new random byte (AdvanceRandom, wRandomLo) is
; below $D8 (RollChance84Percent) and level 2 when it is below $7F (RollChance50Percent). (C2,
; E-0382)
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
    jp RollChance84Percent

.cp_02:
    cp $02
    jr nz, .done
    jp RollChance50Percent

.done:
    scf
    ccf
    ret

SECTION "Bank 36 RollChanceByLevel_100_100_75_0", ROMX

; A = level 0-3: carry set = success. Levels 0 and 1 always succeed and level 3 never does, without
; touching the random state; level 2 succeeds when a new random byte (AdvanceRandom, wRandomLo) is
; below $BF (RollChance75Percent). (C2, E-0382)
; A = level 0-3: success always for 0 and 1, when wRandomLo < $BF (191/256) for 2, never for 3;
; carry set = success; each roll is AdvanceRandom then wRandomLo compared with a threshold (E-0095)
RollChanceByLevel_100_100_75_0::
    cp $02
    jr nc, .skip
    ret

.skip:
    jr nz, .done
    jp RollChance75Percent

.done:
    scf
    ccf
    ret

SECTION "Bank 36 RollChanceByLevel_100_75_40_0", ROMX

; A = level 0-3: carry set = success. Level 0 always succeeds and level 3 never does, without
; touching the random state; level 1 succeeds when a new random byte (AdvanceRandom, wRandomLo) is
; below $BF (RollChance75Percent) and level 2 when it is below $66 (RollChance40Percent). (C2,
; E-0382)
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
    jp RollChance75Percent

.cp_02:
    cp $02
    jr nz, .done
    jp RollChance40Percent

.done:
    scf
    ccf
    ret

SECTION "Bank 36 RollChanceByLevelAndSide", ROMX

; A = level 0-3: carry set = success. For wBattleTarget in slots 0-3 outside link mode 1 it uses
; RollChanceForLevel50Down (about 50, 30 and 15 percent for levels 0-2); for a target in slots 4-7,
; or when wLinkMode is 1, level 0 succeeds below $BF, level 1 below $7F and level 2 below $3F (75,
; 50 and 25 percent). Level 3 never succeeds. (C2, E-0382)
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
    jp RollChanceForLevel50Down

.restore:
    pop af
    and a
    jr nz, .cp_01
    jp RollChance75Percent

.cp_01:
    cp $01
    jr nz, .cp_02
    jp RollChance50Percent

.cp_02:
    cp $02
    jr nz, .done
    jp RollChance25Percent

.done:
    scf
    ccf
    ret

SECTION "Bank 36 ScaleDamageByLevel_1_085_05_0", ROMX

; A = level 0-3: scales the damage word wBattleDamageLo/wBattleDamageHi by 1 (unchanged) for level
; 0, 85 percent (ScaleDamageTo85Percent) for 1, one half (HalveDamage) for 2 and to 0 (ClearDamage)
; for 3. (C2, E-0382)
; A = level 0-3: scales the damage word wBattleDamageLo/wBattleDamageHi by 1 (unchanged), 85/100,
; 1/2 or 0 (E-0095)
ScaleDamageByLevel_1_085_05_0::
    and a
    ret z
    cp $01
    jr nz, .cp_02
    jp ScaleDamageTo85Percent

.cp_02:
    cp $02
    jr nz, .to_clear_damage
    jp HalveDamage

.to_clear_damage:
    jp ClearDamage

SECTION "Bank 36 ScaleDamageByLevel_1_075_04_0", ROMX

; A = level 0-3: scales the damage word wBattleDamageLo/wBattleDamageHi by 1 (unchanged) for level
; 0, 75 percent (ScaleDamageTo75Percent) for 1, 40 percent (ScaleDamageTo40Percent) for 2 and to 0
; (ClearDamage) for 3. (C2, E-0382)
; A = level 0-3: scales the damage word wBattleDamageLo/wBattleDamageHi by 1 (unchanged), 3/4, 0.4
; or 0 (E-0095)
ScaleDamageByLevel_1_075_04_0::
    and a
    ret z
    cp $01
    jr nz, .cp_02
    jp ScaleDamageTo75Percent

.cp_02:
    cp $02
    jr nz, .to_clear_damage
    jp ScaleDamageTo40Percent

.to_clear_damage:
    jp ClearDamage

SECTION "Bank 36 ScaleDamageByLevel_131_116_075_03", ROMX

; A = level 0-3: scales the damage word wBattleDamageLo/wBattleDamageHi by 21/16
; (ScaleDamageBy21Over16) for level 0, 37/32 (ScaleDamageBy37Over32) for 1, 75 percent
; (ScaleDamageTo75Percent) for 2 and 30 percent (ScaleDamageTo30Percent) for 3. (C2, E-0382)
; A = level 0-3: scales the damage word wBattleDamageLo/wBattleDamageHi by 21/16, 37/32, 3/4 or 0.3
; (E-0095)
ScaleDamageByLevel_131_116_075_03::
    and a
    jr nz, .cp_01
    jp ScaleDamageBy21Over16

.cp_01:
    cp $01
    jr nz, .cp_02
    jp ScaleDamageBy37Over32

.cp_02:
    cp $02
    jr nz, .to_scale_damage_to30_percent
    jp ScaleDamageTo75Percent

.to_scale_damage_to30_percent:
    jp ScaleDamageTo30Percent

SECTION "Bank 36 ScaleDamageByLevel_075_05_025_0", ROMX

; A = level 0-3: scales the damage word wBattleDamageLo/wBattleDamageHi to 75 percent
; (ScaleDamageTo75Percent) for level 0, one half (HalveDamage) for 1, one quarter (QuarterDamage)
; for 2 and to 0 (ClearDamage) for 3. (C2, E-0382)
; A = level 0-3: scales the damage word wBattleDamageLo/wBattleDamageHi by 3/4, 1/2, 1/4 or 0
; (E-0095)
ScaleDamageByLevel_075_05_025_0::
    and a
    jr nz, .cp_01
    jp ScaleDamageTo75Percent

.cp_01:
    cp $01
    jr nz, .cp_02
    jp HalveDamage

.cp_02:
    cp $02
    jr nz, .to_clear_damage
    jp QuarterDamage

.to_clear_damage:
    jp ClearDamage

SECTION "Bank 36 RollChanceForLevelA", ROMX

; A = level: carry set = success. Level 0 always succeeds; level 1 succeeds when a new random byte
; is below $BF (RollChance75Percent), level 2 below $7F (RollChance50Percent), level 3 or more below
; $3F (RollChance25Percent). Only RollChanceByFlagsAtHLAlt calls it. (C2, E-0382)
; level A: 0 returns carry; 1, 2 and 3 take three different chance rolls (E-0122) (E-0344: the
; address in its name dropped or read as the label there; was RollChanceForLevelA)
RollChanceForLevelA:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    and a
    jr nz, .cp_01
    scf
    ret

.cp_01:
    cp $01
    jr nz, .cp_02
    jp RollChance75Percent

.cp_02:
    cp $02
    jr nz, .to_roll_chance25_percent
    jp RollChance50Percent

.to_roll_chance25_percent:
    jp RollChance25Percent

SECTION "Bank 36 RollChanceByLevel_100_100_75_40Percent", ROMX

; A = level: carry set = success. Levels 0 and 1 always succeed without touching the random state;
; level 2 succeeds when a new random byte is below $BF (RollChance75Percent), level 3 or more below
; $66 (RollChance40Percent). ActionEffect_Sacrifice_RollVsResistance (for ACTION_D6) and
; RollChanceByFlagsAtHLAlt call it. (C2, E-0382)
; level A: 0 and 1 return, 2 and 3 take chance rolls; the following entries roll random values
; against $D8, $BF, $7F, $66, $4C, $3F and $26 (E-0130) (E-0344: the address in its name dropped or
; read as the label there; was RollChanceByLevel_100_100_75_40Percent)
RollChanceByLevel_100_100_75_40Percent::
    cp $02
    jr nc, .skip
    ret

.skip:
    jr nz, .to_roll_chance40_percent
    jp RollChance75Percent

.to_roll_chance40_percent:
    jp RollChance40Percent

SECTION "Bank 36 RollChanceForLevel50Down", ROMX

; A = level 0-3: carry (success) when a new random byte (AdvanceRandom, wRandomLo) is below $7F for
; level 0, $4C for 1 and $26 for 2 (about 50%, 30% and 15%); level 3 or more returns NC.
; RollChanceByLevelAndSide uses it for a target in slots 0-3 outside link mode 1. (C2, E-0371;
; probed E-0382)
RollChanceForLevel50Down::
    and a
    jr nz, .cp_01
    jp RollChance50Percent

.cp_01:
    cp $01
    jr nz, .cp_02
    jp RollChance30Percent

.cp_02:
    cp $02
    jr nz, .done
    jp RollChance15Percent

.done:
    scf
    ccf
    ret

SECTION "Bank 36 RollChance84Percent", ROMX

; Carry when a new random byte is below $D8 (216 in 256). (C2, E-0357; probed E-0382)
RollChance84Percent::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $d8
    ret

SECTION "Bank 36 RollChance75Percent", ROMX

; Carry when a new random byte is below $BF. (C2, E-0357; probed E-0382)
RollChance75Percent::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $bf
    ret

SECTION "Bank 36 RollChance50Percent", ROMX

; Carry when a new random byte is below $7F. (C2, E-0357; probed E-0382)
RollChance50Percent::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $7f
    ret

SECTION "Bank 36 RollChance40Percent", ROMX

; Carry when a new random byte is below $66. (C2, E-0357; probed E-0382)
RollChance40Percent::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $66
    ret

SECTION "Bank 36 RollChance30Percent", ROMX

; Carry when a new random byte is below $4C. (C2, E-0357; probed E-0382)
RollChance30Percent::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $4c
    ret

SECTION "Bank 36 RollChance25Percent", ROMX

; Carry when a new random byte is below $3F. (C2, E-0357; probed E-0382)
RollChance25Percent::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $3f
    ret

SECTION "Bank 36 RollChance15Percent", ROMX

; Carry when a new random byte is below $26. (C2, E-0357; probed E-0382)
RollChance15Percent::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $26
    ret

SECTION "Bank 36 ScaleDamageBy21Over16", ROMX

; Damage times 21/16. (C2, E-0357; probed E-0382)
ScaleDamageBy21Over16::
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

SECTION "Bank 36 ScaleDamageBy37Over32", ROMX

; Damage times 37/32. (C2, E-0357; probed E-0382)
ScaleDamageBy37Over32::
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

SECTION "Bank 36 ScaleDamageTo85Percent", ROMX

; Damage times 85%. (C2, E-0357; probed E-0382)
ScaleDamageTo85Percent::
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

SECTION "Bank 36 ScaleDamageTo75Percent", ROMX

; Damage times 75%. (C2, E-0357; probed E-0382)
ScaleDamageTo75Percent::
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

SECTION "Bank 36 HalveDamage", ROMX

; Damage halved. (C2, E-0357; probed E-0382)
HalveDamage::
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

SECTION "Bank 36 ScaleDamageTo40Percent", ROMX

; Scales the damage word wBattleDamageLo/wBattleDamageHi to 40 percent (ScaleHLTo40Percent).
; HealTargetHP and ScaleDamageByLevel_1_075_04_0 call it. (C2, E-0382)
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

SECTION "Bank 36 ScaleDamageTo30Percent", ROMX

; Damage cut to 30%. (C2, E-0357; probed E-0382)
ScaleDamageTo30Percent::
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

SECTION "Bank 36 QuarterDamage", ROMX

; Damage cut to a quarter. (C2, E-0357; probed E-0382)
QuarterDamage::
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

SECTION "Bank 36 ClearDamage", ROMX

; Damage 0. (C2, E-0357; probed E-0382)
ClearDamage::
    xor a
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a
    ret

SECTION "Bank 36 ScaleDamageBy3Over2", ROMX

; Scales the damage word wBattleDamageLo/wBattleDamageHi by 3/2 (ScaleHLBy3Over2).
; ActionEffect_ActionD2_ScaleByGigaSlashResistance, ActionEffect_ActionD3_ScaleByGigaSlashResistance
; and ActionEffect_ActionD4_ScaleByGigaSlashResistance call it. (C2, E-0382)
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

SECTION "Bank 36 ScaleHLBy3Over2", ROMX

; HL = HL + HL / 2 (the half rounded down, wrapping at 16 bits); BC = the old HL. (C2, E-0382)
; HL += HL / 2 (rounded down); BC = the old HL (E-0115)
ScaleHLBy3Over2::
    ld b, h
    ld c, l
    call ShiftHLRight1
    add hl, bc
    ret

SECTION "Bank 36 ScaleHLBy21Over16", ROMX

; HL = HL + HL / 4 + HL / 16, each term cut down by shifts and the sum wrapping at 16 bits; BC = the
; old HL / 16. (C2, E-0382)
; HL += HL / 4 + HL / 16 (each shift rounds down); BC = HL / 16 (E-0095)
ScaleHLBy21Over16::
    ld b, h
    ld c, l
    call ShiftBCRight2
    add hl, bc
    call ShiftBCRight2
    add hl, bc
    ret

SECTION "Bank 36 ScaleHLBy37Over32", ROMX

; HL = HL + HL / 8 + HL / 32, each term cut down by shifts and the sum wrapping at 16 bits. (C2,
; E-0382)
; HL += HL / 8 + HL / 32 (each shift rounds down) (E-0095)
ScaleHLBy37Over32::
    ld b, h
    ld c, l
    call ShiftBCRight3
    add hl, bc
    call ShiftBCRight2
    add hl, bc
    ret

SECTION "Bank 36 ScaleHLBy29Over32", ROMX

; HL = HL / 2 + HL / 4 + HL / 8 + HL / 32, each term cut down by shifts (about 0.9 of the old
; value). Nothing in src/ calls it. (C2, E-0382)
; HL = HL/2 + HL/4 + HL/8 + HL/32 (each rounded down) (E-0118)
ScaleHLBy29Over32:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
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

SECTION "Bank 36 ScaleHLTo85Percent", ROMX

; HL = HL * 85 / 100 (24-bit product, Divide24ByA); DE kept. ScaleDamageTo85Percent calls it. (C2,
; E-0382)
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

SECTION "Bank 36 ScaleHLTo80Percent_Bank36", ROMX

; HL = HL * 8 / 10 (24-bit product, Divide24ByA); DE kept. (C2, E-0382)
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

SECTION "Bank 36 ScaleHLTo75Percent", ROMX

; HL = HL / 2 + HL / 4, the half rounded down first; BC kept. (C2, E-0382)
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

SECTION "Bank 36 ScaleHLTo60Percent", ROMX

; HL = HL * 6 / 10 (24-bit product, Divide24ByA); DE kept. (C2, E-0382)
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

SECTION "Bank 36 ScaleHLTo40Percent", ROMX

; HL = (HL * 8 / 10) / 2 (ScaleHLTo80Percent_Bank36, then one shift right); DE kept. (C2, E-0382)
; HL = (HL * 8 / 10) / 2 (E-0095)
ScaleHLTo40Percent::
    call ScaleHLTo80Percent_Bank36
    call ShiftHLRight1
    ret

SECTION "Bank 36 ScaleHLTo30Percent", ROMX

; HL = (HL * 6 / 10) / 2 (ScaleHLTo60Percent, then one shift right); DE kept. (C2, E-0382)
; HL = (HL * 6 / 10) / 2 (E-0095)
ScaleHLTo30Percent::
    call ScaleHLTo60Percent
    call ShiftHLRight1
    ret

SECTION "Bank 36 DivideHLBy3", ROMX

; HL = HL / 3 (DivideHLByBC with BC = 3, quotient rounded down). LowerTargetDEF_ApplyDrop,
; LowerTargetAGL_ApplyDrop, RaiseTargetDEF and RaiseTargetAGL call it. (C2, E-0382)
; HL = HL / 3 (DivideHLByBC with BC = 3) (E-0095)
DivideHLBy3::
    ld bc, $0003
    call DivideHLByBC
    ret

SECTION "Bank 36 ActionEffect_Geyser_ScaleHLTo15Percent", ROMX

; HL = 15% of HL (60%, then a quarter). (C2, E-0357; probed E-0382)
ActionEffect_Geyser_ScaleHLTo15Percent::
    call ScaleHLTo60Percent
    call ShiftHLRight1
    call ShiftHLRight1
    ret

SECTION "Bank 36 ActionEffect_Geyser_ScaleHLTo5Percent", ROMX

; HL = 5% of HL (80%, then a sixteenth). (C2, E-0357; probed E-0382)
ActionEffect_Geyser_ScaleHLTo5Percent::
    call ScaleHLTo80Percent_Bank36
    call ShiftHLRight1
    call ShiftHLRight1
    call ShiftHLRight1
    call ShiftHLRight1
    ret

SECTION "Bank 36 ReadWordTableEntry_Bank36", ROMX

; HL = word table, A = index: HL = the word at HL + 2 * A (AddDoubleAToHL_Bank36 doubles A in 8
; bits, so an index above $7F wraps). SlotAGLBelowBuffCap calls it. (C2, E-0382)
; HL = table, A = index: HL = the word at HL + 2 * A (AddDoubleAToHL_Bank36) (E-0115)
ReadWordTableEntry_Bank36::
    call AddDoubleAToHL_Bank36
    deref_hl
    ret

SECTION "Bank 36 ShiftBCRight3", ROMX

; BC >>= 3 (unsigned); it runs into ShiftBCRight2 and ShiftBCRight1 after its own shift. (C2,
; E-0382)
; BC >>= 3 (falls through ShiftBCRight2) (E-0095)
ShiftBCRight3::
    srl b
    rr c

; BC >>= 2 (unsigned); it runs into ShiftBCRight1 after its own shift. (C2, E-0382)
; BC >>= 2 (falls through ShiftBCRight1) (E-0095)
ShiftBCRight2::
    srl b
    rr c

; BC >>= 1 (unsigned). (C2, E-0382)
; BC >>= 1 (unsigned) (E-0064)
ShiftBCRight1::
    srl b
    rr c
    ret

SECTION "Bank 36 ShiftHLRight4", ROMX

; HL >>= 4 (unsigned); it shifts twice and then runs into ShiftHLRight2 and ShiftHLRight1. (C2,
; E-0382)
; HL >>= 4 (unsigned): two shifts, then falls through ShiftHLRight2 (E-0064)
ShiftHLRight4::
    srl h
    rr l
    srl h
    rr l

; HL >>= 2 (unsigned); it shifts once and then runs into ShiftHLRight1. (C2, E-0382)
; HL >>= 2 (unsigned): one shift, then falls through ShiftHLRight1 (E-0064)
ShiftHLRight2::
    srl h
    rr l

; HL >>= 1 (unsigned). (C2, E-0382)
; HL >>= 1 (unsigned) (E-0064)
ShiftHLRight1::
    srl h
    rr l
    ret

SECTION "Bank 36 SlotDEFBelowBuffCap", ROMX

; A = battle slot: carry when the DEF word of the slot (GetBattleDEF) may still rise, otherwise A =
; 0 and no carry. A DEF of exactly 999 gives carry and above 999 gives no carry; below 999 the DEF
; must be at most the cap, which is 4 times the base DEF of the slot (GetBaseDEFOfSlotA) for slots
; 0-3 and in link mode 1 (wLinkMode = 1), and 2 times for slots 4-7 otherwise; equal to the cap
; counts as below. RaiseTargetDEF calls it. (C2, E-0382)
; slot A: carry when its DEF is below 999 and below 2x (4x for foes outside link battles... allies)
; its base DEF; NC otherwise (E-0124)
SlotDEFBelowBuffCap::
    ld [wBattleArg0], a
    call GetBattleDEF
    ld bc, $03e7
    call CompareHLToBC
    jr nc, SlotDEFBelowBuffCap_NotBelow
    push hl
    ld a, [wBattleArg0]
    call GetBaseDEFOfSlotA
    ld a, [wLinkMode]
    cp $01
    jr z, SlotDEFBelowBuffCap_QuadrupleCap
    ld a, [wBattleArg0]
    cp $04
    jr nc, SlotDEFBelowBuffCap_CompareCap

; Doubles the base DEF in BC a second time (the 4x cap). (C2, E-0357; probed E-0382)
SlotDEFBelowBuffCap_QuadrupleCap::
    sla c
    rl b

; Doubles the base DEF in BC and compares the slot's DEF with it: carry when below. (C2, E-0357;
; probed E-0382)
SlotDEFBelowBuffCap_CompareCap::
    sla c
    rl b
    pop hl
    call CompareHLToBC
    jr nc, SlotDEFBelowBuffCap_NotBelow

; Returns carry (DEF may still rise). (C2, E-0357; probed E-0382)
SlotDEFBelowBuffCap_Below::
    scf
    ret

SECTION "Bank 36 SlotDEFBelowBuffCap_NotBelow", ROMX

; Entered with NC from CompareHLToBC (the DEF at or above 999 or at or above the cap): equal still
; returns carry (SlotDEFBelowBuffCap_Below), so a DEF exactly at 999 or at the cap counts as below;
; above it returns A = 0 with NC. (C2, E-0371; probed E-0382)
SlotDEFBelowBuffCap_NotBelow::
    jr z, SlotDEFBelowBuffCap_Below
    xor a
    ret

SECTION "Bank 36 SlotAGLBelowBuffCap", ROMX

; A = battle slot: carry when the AGL word of the slot (ReadWordTableEntry_Bank36 on wBattleAGL) may
; still rise, otherwise A = 0 and no carry. Same rule as SlotDEFBelowBuffCap: exactly 999 gives
; carry, above 999 none, and below 999 the AGL must be at most 4 times the base AGL
; (GetBaseAGLOfSlotA) for slots 0-3 and in link mode 1, 2 times for slots 4-7 otherwise, equal
; counting as below; link mode 1 continues in SlotDEFBelowBuffCap_QuadrupleCap. RaiseTargetAGL calls
; it. (C2, E-0382)
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
    jr z, SlotDEFBelowBuffCap_QuadrupleCap
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

SECTION "Bank 36 GetTargetSpeciesFamily", ROMX

; Loads the species record of the monster id of wBattleTarget (TargetMonsterIdAddress into
; wSpeciesIdLo/wSpeciesIdHi, then LoadSpeciesRecord) and returns its family byte in A.
; ActionEffect_Lightning_Damage, ActionEffect_MultiCut_Damage, AttackDamageHalvedDEFVsBeast and a
; dozen other damage routines call it. (C2, E-0382)
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

SECTION "Bank 36 TargetMonsterIdAddress", ROMX

; HL = wBattleMonsterId + 2 * wBattleTarget, the monster id word of the target (A is clobbered).
; GetTargetSpeciesFamily calls it. (C2, E-0382)
; HL = wBattleMonsterId + 2 * wBattleTarget, the target's monster id word (E-0069)
TargetMonsterIdAddress::
    ld a, [wBattleTarget]
    add a
    ld hl, wBattleMonsterId
    add_a_to_hl
    ret

SECTION "Bank 36 ForceLevel4IfActorConcentrated", ROMX

; A = level: returns 3 unchanged; any other level becomes 4 when the actor concentrated (bit 2 of
; the wPersonalityActs byte at wPersonalityActs + 2 * wBattleActor), else is returned unchanged. BC
; and HL are kept. The resistance rolls treat a 4 as always getting through. (C2, E-0382)
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

SECTION "Bank 36 ActionEffect_RobMagic_MPAboveMax", ROMX

; Compares slot A's MP with its max MP: carry when the MP is above the max (HL and BC kept). (C2,
; E-0357; probed E-0382)
ActionEffect_RobMagic_MPAboveMax::
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

SECTION "Bank 36 ActionEffect_Transform_CappedBaseHP", ROMX

; BC = slot A's base HP, at most 999. (C2, E-0357; probed E-0382)
ActionEffect_Transform_CappedBaseHP::
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

SECTION "Bank 36 ActionEffect_Transform_CappedBaseMP", ROMX

; BC = slot A's base MP, at most 999. (C2, E-0357; probed E-0382)
ActionEffect_Transform_CappedBaseMP::
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

SECTION "Bank 36 GetBaseATKOfSlotA", ROMX

; A = battle slot. Returns BC = the base ATK word of that slot (low byte in C, high byte in B), the
; value GetBaseATK leaves in wBattleStatResultLo and wBattleStatResultHi: the ATK field of the
; battler record of the slot, or for slot 3 and 7 the ATK of its special monster record
; (wSpecialSlotMonsters). HL is kept. ActionEffect_Transform_TakeTargetStats uses it to copy the
; base ATK of the target to the actor. (C2, E-0382)
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

SECTION "Bank 36 GetBaseDEFOfSlotA", ROMX

; A = battle slot. Returns BC = the base DEF word of that slot (low byte in C, high byte in B), the
; value GetBaseDEF leaves in wBattleStatResultLo and wBattleStatResultHi: the DEF field of the
; battler record of the slot, or for slot 3 and 7 the DEF of its special monster record. HL is kept.
; RaiseTargetDEF, LowerTargetDEF_ApplyDrop and SlotDEFBelowBuffCap size their change and cap from
; it, and ActionEffect_Transform_TakeTargetStats copies it to the actor. (C2, E-0382)
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

SECTION "Bank 36 GetBaseAGLOfSlotA", ROMX

; A = battle slot. Returns BC = the base AGL word of that slot (low byte in C, high byte in B), the
; value GetBaseAGL leaves in wBattleStatResultLo and wBattleStatResultHi: the AGL field of the
; battler record of the slot, or for slot 3 and 7 the AGL of its special monster record. HL is kept.
; RaiseTargetAGL, LowerTargetAGL_ApplyDrop and SlotAGLBelowBuffCap size their change and cap from
; it, and ActionEffect_Transform_TakeTargetStats copies it to the actor. (C2, E-0382)
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

SECTION "Bank 36 ActionEffect_Transform_ResistancesAddress", ROMX

; HL = where slot A's resistances come from: its battler record's resistance field, or for slot 3 or
; 7 the special monster's species record. (C2, E-0357; probed E-0382)
ActionEffect_Transform_ResistancesAddress::
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

SECTION "Bank 36 ActionEffect_Transform_SkillListAddress", ROMX

; HL and B = slot A's skill list and length: its battler record's eight skills, or for slot 3 or 7
; the special monster record's four. (C2, E-0357; probed E-0382)
ActionEffect_Transform_SkillListAddress::
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

SECTION "Bank 36 ActionEffect_Transform_GetBodyFlags", ROMX

; C = slot A's body nibbles (GetSlotBodyFlags), HL kept. (C2, E-0357; probed E-0382)
ActionEffect_Transform_GetBodyFlags::
    push hl
    ld c, a
    farcall GetSlotBodyFlags
    pop hl
    ret

SECTION "Bank 36 ComputeAttackDamageWithHalvedDEF", ROMX

; Plain attack damage against a quarter of the DEF of the target. It halves the wBattleDEF word of
; wBattleTarget, runs ComputeAttackDamage (which halves the DEF word once more) and then writes the
; original DEF word back, so afterwards only wBattleDamageLo, wBattleDamageHi and the random state
; differ. The ten routines AttackDamageHalvedDEFVsSlime, AttackDamageHalvedDEFVsDragon and so on
; jump here when the species family of the target is the one they name. (C2, E-0382)
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

SECTION "Bank 36 ActionEffect_BeDragon_CapAtNewMax", ROMX

; Stores BC in word A of the table at HL, but no more than the value already there (caps HP or MP at
; a new maximum). (C2, E-0357; probed E-0382)
ActionEffect_BeDragon_CapAtNewMax::
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

SECTION "Bank 36 DispatchActionEffectTable", ROMX

; Runs the effect routine of the current action: reads wBattleActionId, adds twice its value to
; ActionEffectTable and calls the routine whose address is stored there (JumpToWordAtHL), so the
; effect routine returns to the caller of this routine. The table has one entry for each id 0-239
; and there is no bounds check; many ids share one routine (Blaze, Blazemore and Blazemost all use
; ActionEffect_Blaze). ResolveStepActionEffect, resolve step 6, is the only caller. (C1, E-0382)
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

SECTION "Bank 36 ActionEffectTable", ROMX

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
    dw ActionEffect_Surround ; entry 46
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
    dw ActionEffect_AhhhAA ; entry 170
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

; Action $D0: Bolt-scaled skill damage (RollSkillDamageScaledByBoltResistance); marks the actor's
; formation partner (wSlotMarks 3) and stores the damage message ('took G damage!' / 'But ... was
; unaffected!'). (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $D0; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
ActionEffect_ActionD0::
    call RollSkillDamageScaledByBoltResistance
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    jp StoreHitOrUnaffectedMessage

SECTION "Bank 36 ActionEffect_ActionD1", ROMX

; Action $D1: skill damage scaled by resistance level 0; marks the formation partner; the damage
; message. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $D1; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
ActionEffect_ActionD1::
    call ActionEffect_ActionD1_Damage
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    jp StoreHitOrUnaffectedMessage

SECTION "Bank 36 ActionEffect_ActionD2", ROMX

; Action $D2: skill damage scaled by GigaSlash resistance; marks the formation partner; the hit
; message ('took G damage!' / 'Miss! ... was unharmed!'). (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $D2; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
ActionEffect_ActionD2::
    call ActionEffect_ActionD2_ScaleByGigaSlashResistance
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_ActionD3", ROMX

; Action $D3: as $D2 (GigaSlash-scaled skill damage, partner marked, hit message). (C2, E-0357;
; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $D3; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
ActionEffect_ActionD3::
    call ActionEffect_ActionD3_ScaleByGigaSlashResistance
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_ActionD4", ROMX

; Action $D4: as $D2 (GigaSlash-scaled skill damage, partner marked, hit message). (C2, E-0357;
; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $D4; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
ActionEffect_ActionD4::
    call ActionEffect_ActionD4_ScaleByGigaSlashResistance
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_ActionD5", ROMX

; Action $D5: as $D2 (GigaSlash-scaled skill damage, partner marked, hit message). (C2, E-0357;
; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $D5; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
ActionEffect_ActionD5::
    call SkillDamageScaledByGigaSlashResistance
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_ActionD6", ROMX

; Action $D6: marks the formation partner, then Sacrifice's effect. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $D6; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
ActionEffect_ActionD6::
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    jp ActionEffect_Sacrifice

SECTION "Bank 36 ActionEffect_ActionD7", ROMX

; Action $D7: marks the formation partner; the damage is the actor's basic damage plus its
; partner's; hit message. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $D7; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
ActionEffect_ActionD7::
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    call ActionEffect_ActionD7_Damage
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_ActionD8", ROMX

; Action $D8: marks the formation partner; the damage is the actor's attack damage plus its
; partner's; hit message. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $D8; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
ActionEffect_ActionD8::
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    call ActionEffect_ActionD8_Damage
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_ActionD9", ROMX

; Action $D9, one of the formation actions: the damage comes from ActionEffect_ActionD9_Damage
; (built from wAllMPSpentLo and the level of the slot in register E, for the actor and for its
; formation partner, with a random spread and the resistance scaling of byte 4), the formation
; partner is marked (wSlotMarks 3), and the hit message is stored ('took G damage!' for a hit,
; 'Miss! ... was unharmed!' for the target). This routine never loads E: the damage code uses
; whatever E holds on entry. (C2, E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 217; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_ActionD9::
    call ActionEffect_ActionD9_Damage
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_ActionDA", ROMX

; Action $DA: marks the formation partner; cures every status in the target's status byte 0,
; restores its HP fully when below max (HealTargetHP) and fills its MP; with any change '<name>'s
; wound was healed!' ($37), otherwise 'But nothing happened!'. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $DA; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
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
    jr z, .to_store_nothing_happened_message_bank36
    ld l, $37
    lb bc, $40, $90
    jp StoreActorMessage_Bank36

.to_store_nothing_happened_message_bank36:
    jp StoreNothingHappenedMessage_Bank36

SECTION "Bank 36 ActionEffect_ActionDB", ROMX

; Action $DB: marks the formation partner and, by wRandomLo bits 2-3, gives the target one of four
; statuses with no resistance roll: badly poisoned ('terribly poisoned!'), cursed, paralyzed or
; confused (ActionEffect_ActionDB_Data: status bit, effect action $2F or $34, message), playing that
; action's effect (SelectEffectByEffectFlags with flags $41/$30, the flags put back after). (C2,
; E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $DB; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
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
    jp StoreActorMessage_Bank36

SECTION "Bank 36 ActionEffect_ActionDB_Data", ROMX

; Four entries of four bytes: status bit, effect action id, message id and a zero that is not read.
; $02, $2F, $77; $20, $34, $D9; $40, $2F, $76; $10, $34, $42. ActionEffect_ActionDB picks the entry
; with bits 2 and 3 of wRandomLo, ORs byte 0 into the target status byte (badly poisoned, cursed,
; paralyzed or confused: BSTAT0_BADLY_POISONED, BSTAT0_CURSED, BSTAT0_PARALYZED, BSTAT0_CONFUSED),
; plays the effect action in byte 1 (unless it is $FF) and stores the message in byte 2 with
; StoreActorMessage_Bank36. (C1, E-0381)
ActionEffect_ActionDB_Data::
    db $02, $2f, $77, $00, $20, $34, $d9, $00, $40, $2f, $76, $00, $10, $34, $42, $00

; Action $DC: BeDragon for the formation partner (as actor), then for the actor. (C2, E-0357; probed
; E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $DC; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
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

SECTION "Bank 36 ActionEffect_ActionDD", ROMX

; Action $DD: marks the formation partner (wSlotMarks 3). On the target it sets BSTAT1_ATK_DOUBLED,
; sets the SideStep field (status 5 bits 2-3) to 1 or 2 by bit 2 of wRandomLo after AdvanceRandom
; (the other bits of status 5 stay), then runs RaiseTargetDEF and RaiseTargetAGL; each one that
; returns carry sets BSTAT6_STATS_RAISED (an AGL of exactly 999 returns carry with a gain of 0). The
; damage word is cleared and the message is actor $93 'became flush with power!' (flags $90,
; argument 0). (C2, E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $DD; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
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

SECTION "Bank 36 ActionEffect_ActionDE", ROMX

; Action $DE: marks the formation partner; seals the target's spells, dances and breaths ($9E). (C2,
; E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $DE; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
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

SECTION "Bank 36 ActionEffect_ActionDF", ROMX

; Action $DF: marks the formation partner, then RobMagic's effect. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $DF; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
ActionEffect_ActionDF::
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    jp ActionEffect_RobMagic

SECTION "Bank 36 ActionEffect_ActionE0", ROMX

; Action $E0: marks the formation partner; StrongD for the partner (as actor), then for the actor.
; (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $E0; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
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

SECTION "Bank 36 ActionEffect_ActionE1", ROMX

; Action $E1: marks the formation partner, then PanicAll's effect. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $E1; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
ActionEffect_ActionE1::
    farcall RunA3ActorFormationSlotToTemp0AndMarkSlotMarks3
    jp ActionEffect_PanicAll

SECTION "Bank 36 ActionEffect_ActionE2", ROMX

; Action $E2: marks the formation partner; sets BSTAT7_DAMAGE_X10 on every present slot of the
; actor's side (four from its first), then ends the sub-phase (RestoreTargetAndEndEffect). (C2,
; E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $E2; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
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
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_ActionE3", ROMX

; Action $E3: marks the formation partner (wSlotMarks 3); each present slot among the first three
; slots of the side of the actor gets BSTAT1_CRITICAL and has BSTAT4_FOCUS set with BSTAT4_FOCUS_LO
; cleared (status 4 bit 7 set, bit 6 cleared); then the sub-phase ends. (C2, E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $E3; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
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
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_ActionAF", ROMX

; Does nothing: returns at once. It is the entry of ActionEffectTable for ids 175 ($AF), 190 ($BE)
; and 228-239 ($E4-$EF). (C2, E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 175, 190, 228, 229, 230, 231 ...; the misaligned decoding before E-0126 hid this
; entry (E-0126)
ActionEffect_ActionAF::
    ret

SECTION "Bank 36 ActionEffect_Fight", ROMX

; Fight: the attack damage (ComputeAttackDamage) and the hit message ('took G damage!' / 'Miss! ...
; was unharmed!'). (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 0 (no name); ids below 175 are skills named from
; StringTable_SkillNames (E-0084) (E-0333: action 0 is Fight, the plain attack: it is dispatched on
; turns whose battle text names no skill, while every other action follows the skill-name lookup of
; its own id; skill 0 is AIScore_Fight; C2) (was ActionEffect_Fight)
ActionEffect_Fight::
    call ComputeAttackDamage
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_Blaze", ROMX

; Blaze (Blazemore, Blazemost): skill damage scaled by Blaze resistance; the damage message. (C2,
; E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 1 Blaze, 2 Blazemore, 3 Blazemost; ids below 175 are skills named
; from StringTable_SkillNames (E-0084)
ActionEffect_Blaze::
    call ActionEffect_Blaze_Damage
    jp StoreHitOrUnaffectedMessage

SECTION "Bank 36 ActionEffect_Firebal", ROMX

; Firebal: skill damage scaled by Firebal resistance; the damage message. (C2, E-0357; probed
; E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 4 Firebal, 5 Firebane, 6 Firebolt; ids below 175 are skills named
; from StringTable_SkillNames (E-0084)
ActionEffect_Firebal::
    call ActionEffect_Firebal_Damage
    jp StoreHitOrUnaffectedMessage

SECTION "Bank 36 ActionEffect_Bang", ROMX

; Bang: skill damage scaled by Bang resistance; the damage message. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 7 Bang, 8 Boom, 9 Explodet; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_Bang::
    call ActionEffect_Bang_Damage
    jp StoreHitOrUnaffectedMessage

SECTION "Bank 36 ActionEffect_Infernos", ROMX

; Infernos: skill damage with its resistance scaling; the damage message. (C2, E-0357; probed
; E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 10 Infernos, 11 Infermore, 12 Infermost; ids below 175 are skills
; named from StringTable_SkillNames (E-0084)
ActionEffect_Infernos::
    call ActionEffect_Infernos_Damage
    jp StoreHitOrUnaffectedMessage

SECTION "Bank 36 ActionEffect_Bolt", ROMX

; Bolt: skill damage scaled by Bolt resistance; the damage message. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 13 Bolt, 14 Zap, 15 Thordain, 63 Hellblast; ids below 175 are
; skills named from StringTable_SkillNames (E-0084)
ActionEffect_Bolt::
    call RollSkillDamageScaledByBoltResistance
    jp StoreHitOrUnaffectedMessage

SECTION "Bank 36 ActionEffect_IceBolt", ROMX

; IceBolt: skill damage scaled by IceBolt resistance; the damage message. (C2, E-0357; probed
; E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 16 IceBolt, 17 SnowStorm, 18 Blizzard; ids below 175 are skills
; named from StringTable_SkillNames (E-0084)
ActionEffect_IceBolt::
    call ActionEffect_IceBolt_Damage
    jp StoreHitOrUnaffectedMessage

SECTION "Bank 36 ActionEffect_Beat", ROMX

; Beat: when the roll gets through Beat resistance (RollVsBeatResistance), the target's HP becomes 0
; with 1000 as the damage and '<name> was instantly slain!' ($8E); otherwise 'But ... was
; unaffected!'. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 19 Beat, 20 Defeat, 121 K.O.Dance; ids below 175 are skills named
; from StringTable_SkillNames (E-0084)
ActionEffect_Beat::
    call RollVsBeatResistance
    jr nc, .to_store_unaffected_message_bank36
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
    jp StoreResolveMessage_Bank36

.to_store_unaffected_message_bank36:
    jp StoreUnaffectedMessage_Bank36

SECTION "Bank 36 ActionEffect_Sacrifice", ROMX

; Sacrifice: no effect for an ally in battle kind 2 or 3 or when the Sacrifice resistance roll fails
; ('But ... was unaffected!'); otherwise on a coin flip the target loses all but a hundredth of its
; HP (damage HP - HP/100, at least 1), or its HP becomes 0 with 1000 as the damage and 'The <name>
; shattered!' ($8F). (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 21 Sacrifice; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_Sacrifice::
    call ActionEffect_Sacrifice_RollVsResistance
    jr nc, .to_store_unaffected_message_bank36
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
    jp StoreHitOrUnaffectedMessage

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
    jp StoreResolveMessage_Bank36

.to_store_unaffected_message_bank36:
    jp StoreUnaffectedMessage_Bank36

SECTION "Bank 36 ActionEffect_Heal", ROMX

; Heals the target. A present target (wBattleSlotOut byte 0) below its max HP is healed by
; HealTargetHP and gets the message actor $37 'wound was healed!' (flags $90, argument $40); a
; target at its max HP, or a fallen one (wBattleSlotOut byte other than 0 and $FF), gets 'But
; nothing happened!'; an empty slot ($FF) ends the sub-phase without a message. HealTargetHP picks
; the amount from wBattleActionId (rolled from the skill record for Heal, HealMore and the others,
; the max HP for action $B1). Entries 22-26, 124 and 177 of ActionEffectTable; ActionEffect_Farewell
; and ActionEffect_LoveRain_HealIfFlagSet call it too. (C2, E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 22 Heal, 23 HealMore, 24 HealAll, 25 HealUs, 26 HealUsAll, 124
; Hustle, $B1; ids below 175 are skills named from StringTable_SkillNames; the body is not
; interpreted (E-0084)
ActionEffect_Heal::
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .read_battle_target
    jr z, .to_restore_target_and_end_effect
    jr .to_store_nothing_happened_message_bank36

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
    jr z, .to_store_nothing_happened_message_bank36
    call HealTargetHP
    ld l, $37
    lb bc, $40, $90
    jp StoreActorMessage_Bank36

.to_store_nothing_happened_message_bank36:
    jp StoreNothingHappenedMessage_Bank36

.to_restore_target_and_end_effect:
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_MPass", ROMX

; MPass (MPassMore, MPassMost): an absent target ends the sub-phase or has no effect; at full MP
; 'But nothing happened!'; otherwise restores MP (ActionEffect_MPass_GiveMP) with '<name>'s MP was
; restored!' ($C3). (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 27 MPass, 28 MPassmore, 29 MPassmost; ids below 175 are skills
; named from StringTable_SkillNames (E-0084)
ActionEffect_MPass::
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .read_battle_target
    jr z, .to_restore_target_and_end_effect
    jr .to_store_nothing_happened_message_bank36

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
    jr z, .to_store_nothing_happened_message_bank36
    call ActionEffect_MPass_GiveMP
    jr nc, .to_store_nothing_happened_message_bank36
    ld l, $c3
    lb bc, $40, $90
    jp StoreActorMessage_Bank36

.to_store_nothing_happened_message_bank36:
    jp StoreNothingHappenedMessage_Bank36

.to_restore_target_and_end_effect:
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_Vivify", ROMX

; Vivify: a present target gets 'But nothing happened!' and an empty slot ends the sub-phase; a
; fallen one comes back on a coin flip with half its max HP (ReviveTarget: HP set, picture reloaded
; on the far side, back in with its status cleared, message $50), otherwise message $67. (C1,
; E-0357)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 30 Vivify; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_Vivify::
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jp nc, ActionEffect_Revive_NothingHappened
    jp z, ActionEffect_Revive_NoEffect
    call AdvanceRandom
    ld a, [wRandomLo]
    and $01
    jr z, ActionEffect_Vivify_Fail
    ld a, [wBattleTarget]
    ld b, a
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank36
    ld a, [hli]
    ld d, [hl]
    ld e, a
    srl d
    rr e

; Shared revival tail (Vivify falls in; ApplyTargetMaxHPAmount jumps here for Revive, Farewell and
; ActionEffect_LifeSong): B = the target slot, DE = its new HP. Stores DE in its wBattleHP word,
; reloads the picture of a target that is not on the local side (TargetOnLocalSide_Bank36,
; LoadBattleMonsterPictureForSlotB with its wBattleMonsterId entry), brings it back
; (BringTargetBack) and clears the damage with actor message $50 '<name> came back to life!' (flags
; $90, argument $40). (C1, E-0371)
ReviveTarget::
    ld a, b
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank36
    ld a, e
    ld [hli], a
    ld [hl], d
    call TargetOnLocalSide_Bank36
    jr c, .call_bring_target_back
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
    jr .call_bring_target_back

.call_bring_target_back:
    call BringTargetBack
    ld l, $50
    lb bc, $40, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

SECTION "Bank 36 ActionEffect_Vivify_Fail", ROMX

; Vivify's failed coin flip: target message $67 '<name> did not come back to life!' (flags $80,
; argument 0). (C2, E-0371; probed E-0382)
ActionEffect_Vivify_Fail::
    ld h, $67
    lb bc, $00, $80
    jp StoreTargetMessage_Bank36

SECTION "Bank 36 ActionEffect_Revive", ROMX

; Revive: no effect on a side's fourth slot, 'But nothing happened!' on a present target, nothing
; for an empty slot; a fallen target comes back with its full max HP (ApplyTargetMaxHPAmount). (C1,
; E-0357)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 31 Revive, $BB; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_Revive::
    ld a, [wBattleTarget]
    and $03
    cp $03
    jr z, ActionEffect_Revive_NoEffect
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jp nc, ActionEffect_Revive_NothingHappened
    jp z, ActionEffect_Revive_NoEffect

; Sets B = wBattleTarget and DE = the max HP of the target (its wBattleMaxHP entry), then jumps to
; ReviveTarget, which stores DE as the HP of the target and brings it back. ActionEffect_Revive
; falls into it; ActionEffect_Farewell, ActionEffect_LifeSong_Revive and the item effect
; ItemEffect_ReviveFallenTarget (bank $3B, far call) call it. (C1, E-0382)
; DE = the target's max HP and continues with the shared HP amount path (ReviveTarget) (E-0122)
ApplyTargetMaxHPAmount::
    ld a, [wBattleTarget]
    ld b, a
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank36
    ld a, [hli]
    ld d, [hl]
    ld e, a
    jp ReviveTarget

SECTION "Bank 36 ActionEffect_Revive_NothingHappened", ROMX

; Vivify and Revive on a target that has not fallen: 'But nothing happened!'
; (StoreNothingHappenedMessage_Bank36). (C2, E-0371; probed E-0382)
ActionEffect_Revive_NothingHappened::
    jp StoreNothingHappenedMessage_Bank36

SECTION "Bank 36 ActionEffect_Revive_NoEffect", ROMX

; Vivify, Revive and Farewell with no target to act on (an empty slot, a side's fourth slot, or for
; Farewell the actor itself): ends without a message (RestoreTargetAndEndEffect). (C2, E-0371;
; probed E-0382)
ActionEffect_Revive_NoEffect::
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_Farewell", ROMX

; Farewell: never the actor itself or a side's fourth slot; a present target is healed as by Heal
; (message flag 6 cleared); a fallen one comes back with full max HP (flag 6 set); an empty slot
; ends the sub-phase. (C1, E-0357)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 32 Farewell; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_Farewell::
    ld a, [wBattleTarget]
    ld hl, wBattleActor
    cp [hl]
    jr z, ActionEffect_Revive_NoEffect
    ld a, [wBattleTarget]
    and $03
    cp $03
    jr z, ActionEffect_Revive_NoEffect
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .call_action_effect_heal
    jr z, ActionEffect_Revive_NoEffect
    call ApplyTargetMaxHPAmount
    ld hl, wResolveMsgFlags
    set 6, [hl]
    ret

.call_action_effect_heal:
    call ActionEffect_Heal
    ld hl, wResolveMsgFlags
    res 6, [hl]
    ret

SECTION "Bank 36 ActionEffect_Antidote", ROMX

; Antidote: cures poison and bad poison (status 0 bits 0-1) with '<name> was cured of poison.'
; ($4E); otherwise 'But nothing happened!'. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 33 Antidote; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_Antidote::
    call ClearDamageAndReadTargetStatus0_Bank36
    and $03
    jr z, .to_store_nothing_happened_message_bank36
    ld a, [hl]
    and $fc
    ld [hl], a
    ld l, $4e
    lb bc, $40, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.to_store_nothing_happened_message_bank36:
    jp StoreNothingHappenedMessage_Bank36

SECTION "Bank 36 ActionEffect_DeChaos", ROMX

; DeChaos: cures confusion (BSTAT0_CONFUSED), marks the target (wSlotMarks 3) and says '<name>
; snapped out of confusion!' ($83); otherwise 'But nothing happened!'. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 34 DeChaos; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_DeChaos::
    call ClearDamageAndReadTargetStatus0_Bank36
    and $10
    jr z, .to_store_nothing_happened_message_bank36
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

.to_store_nothing_happened_message_bank36:
    jp StoreNothingHappenedMessage_Bank36

SECTION "Bank 36 ActionEffect_NumbOff", ROMX

; NumbOff: when the target is asleep or paralyzed (status 0 & $CC) says '<name> is no longer
; paralyzed.' ($4F) for paralysis, else '<name> woke up!' ($82), clears both with the sleep counter
; and marks the target; otherwise 'But nothing happened!'. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 35 NumbOff; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_NumbOff::
    call ClearDamageAndReadTargetStatus0_Bank36
    and $cc
    jr z, .to_store_nothing_happened_message_bank36
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

.to_store_nothing_happened_message_bank36:
    jp StoreNothingHappenedMessage_Bank36

SECTION "Bank 36 ActionEffect_CurseOff", ROMX

; CurseOff: lifts the curse (BSTAT0_CURSED) with '<name> was uncursed!' ($51); otherwise 'But
; nothing happened!'. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 36 CurseOff; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_CurseOff::
    call ClearDamageAndReadTargetStatus0_Bank36
    and $20
    jr z, .to_store_nothing_happened_message_bank36
    ld a, [hl]
    and $df
    ld [hl], a
    ld l, $51
    lb bc, $40, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.to_store_nothing_happened_message_bank36:
    jp StoreNothingHappenedMessage_Bank36

SECTION "Bank 36 ActionEffect_Upper", ROMX

; Upper (action $25) and Increase (action $26): raises the DEF of the target with RaiseTargetDEF
; (half of the base DEF for Upper, a third for Increase) and sets BSTAT6_STATS_RAISED when that
; returns carry. When the gain left in the damage word is not zero the message is actor $45 'DEF
; rose by G!' (flags $90, argument 0); otherwise it is 'But nothing happened!' (target message $CC,
; flags $84). (C2, E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 37 Upper, 38 Increase; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
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
    jp StoreActorMessage_Bank36

.skip:
    ld h, $cc
    lb bc, $00, $84
    jp StoreTargetMessage_Bank36

SECTION "Bank 36 ActionEffect_Sap", ROMX

; Sap: when the roll gets through Sap resistance (RollVsSapResistance), lowers the target's DEF
; (LowerTargetDEF: '<name>'s DEF fell by G!', marking BSTAT6_STATS_LOWERED); otherwise 'But ... was
; unaffected!'. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 39 Sap, 40 Defense; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_Sap::
    call RollVsSapResistance
    jp nc, StoreUnaffectedMessage_Bank36

; Lowers the target's DEF (LowerTargetDEF_ApplyDrop); when it fell marks BSTAT6_STATS_LOWERED
; (SetSlotStatus6Bit7) with actor message $39 '<name>'s DEF fell by G!' (flags $98); otherwise
; target message $CC 'But nothing happened!' (flags $84). ActionEffect_Sap falls into it and
; ActionEffect_UltraDown calls it. (C2, E-0371; probed E-0382)
LowerTargetDEF::
    call LowerTargetDEF_ApplyDrop
    jr nc, .skip
    ld a, [wBattleTarget]
    call SetSlotStatus6Bit7
    ld l, $39
    lb bc, $00, $98
    jp StoreActorMessage_Bank36

.skip:
    ld h, $cc
    lb bc, $00, $84
    jp StoreTargetMessage_Bank36

SECTION "Bank 36 ActionEffect_Speed", ROMX

; Raises the AGL of the target with RaiseTargetAGL (half of the base AGL for Speed, a third for
; SpeedUp) and sets BSTAT6_STATS_RAISED whenever that returns carry. When the gain left in the
; damage word is not zero the message is actor $49 'AGL rose by G!' (flags $90, argument 0);
; otherwise it is 'But nothing happened!' (target message $CC, flags $84), which also happens for an
; AGL of exactly 999 (carry with a gain of 0, so the status bit is set anyway). (C2, E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 41 Speed, 42 SpeedUp; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
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
    jp StoreActorMessage_Bank36

.skip:
    ld h, $cc
    lb bc, $00, $84
    jp StoreTargetMessage_Bank36

SECTION "Bank 36 ActionEffect_Slow", ROMX

; Slow: when the roll gets through Slow resistance, cuts the target's AGL (LowerTargetAGL: '<name>'s
; AGL was cut by G!', marking BSTAT6_STATS_LOWERED); otherwise 'But ... was unaffected!'. (C2,
; E-0357; probed E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 43 Slow, 44 SlowAll; the misaligned decoding before E-0126 hid this entry (E-0126)
ActionEffect_Slow::
    call RollVsSlowResistance
    jp nc, StoreUnaffectedMessage_Bank36

; Lowers the target's AGL (LowerTargetAGL_ApplyDrop); when it fell marks BSTAT6_STATS_LOWERED
; (SetSlotStatus6Bit7) with actor message $48 '<name>'s AGL was cut by G!' (flags $98); otherwise
; target message $CC 'But nothing happened!' (flags $84). ActionEffect_Slow falls into it and
; ResolveStepBranchOnAction_UltraDown calls it on its first pass. (C2, E-0371; probed E-0382)
LowerTargetAGL::
    call LowerTargetAGL_ApplyDrop
    jr nc, .skip
    ld a, [wBattleTarget]
    call SetSlotStatus6Bit7
    ld l, $48
    lb bc, $00, $98
    jp StoreActorMessage_Bank36

.skip:
    ld h, $cc
    lb bc, $00, $84
    jp StoreTargetMessage_Bank36

SECTION "Bank 36 ActionEffect_TwinHits", ROMX

; TwinHits: doubles the target's ATK once (BSTAT1_ATK_DOUBLED) with '<name>'s ATK doubled!' ($43);
; already doubled, it ends the sub-phase without a message. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 45 TwinHits; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_TwinHits::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_ATK_DOUBLED, [hl]
    jr nz, .to_restore_target_and_end_effect
    set BSTAT1_ATK_DOUBLED, [hl]
    ld l, $43
    lb bc, $00, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.to_restore_target_and_end_effect:
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_Surround", ROMX

; Effect routine of action 46 (SKILL_SURROUND); it is entry 46 of ActionEffectTable and is not a
; step of ResolveStepDamageMessage. A target that already has BSTAT1_BLINDED only has bit 4 of
; wResolveMsgFlags cleared and the sub-phase ends. Otherwise, when the roll gets through the Radiant
; resistance of the target (RollVsRadiantResistance), the target gets BSTAT1_BLINDED, the damage
; word is cleared and the message is actor $4A '... is lost in a daze!' (flags $90); a failed roll
; gives 'But ... was unaffected!'. (C2, E-0382)
; RollVsRadiantResistance during the damage message step (E-0338)
ActionEffect_Surround::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_BLINDED, [hl]
    jr nz, .check_resolve_msg_flags
    call RollVsRadiantResistance
    jr nc, .to_store_unaffected_message_bank36
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
    jp RestoreTargetAndEndEffect

.to_store_unaffected_message_bank36:
    jp StoreUnaffectedMessage_Bank36

SECTION "Bank 36 ActionEffect_Sleep", ROMX

; Sleep (SleepAir ...): an already sleeping target gets '<name> is already asleep!' ($D4); when the
; roll gets through Sleep resistance, sets asleep with the sleep counter at 3 (or $8C) and '<name>
; was put to sleep!' ($73); otherwise 'But ... was unaffected!' for SleepAir, '<name> didn't fall
; asleep!' ($CE) for the rest. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 47 Sleep, 48 SleepAll, 113 SleepAir; ids below 175 are skills named
; from StringTable_SkillNames (E-0084)
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
    jp StoreTargetMessage_Bank36

.skip2:
    ld h, $d4
    lb bc, $00, $80
    jp StoreTargetMessage_Bank36

SECTION "Bank 36 ActionEffect_TakeMagic", ROMX

; TakeMagic: sets BSTAT2_TAKE_MAGIC on the actor once with '<name> started glowing!' ($3F); already
; set, it ends the sub-phase. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 49 TakeMagic; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_TakeMagic::
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit BSTAT2_TAKE_MAGIC, [hl]
    jr nz, .to_restore_target_and_end_effect
    set BSTAT2_TAKE_MAGIC, [hl]
    ld l, $3f
    lb bc, $00, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.to_restore_target_and_end_effect:
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_RobMagic", ROMX

; RobMagic (and action $DF): needs MP on the target and, except for $DF, the actor below its max MP;
; when the roll gets through RobMagic resistance, the actor takes MP from the target
; (ActionEffect_RobMagic_StealMP); for $DF the formation partner drains too, the target's MP becomes
; 0 and the shown amount is twice half of what it had; '<name> was stripped of GMP!' ($3D);
; otherwise it ends the sub-phase. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 50 RobMagic, 119 RobDance; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_RobMagic::
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    ld a, [hli]
    or [hl]
    jp z, .to_restore_target_and_end_effect
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
    jr nc, .to_restore_target_and_end_effect

.call_roll_vs_rob_magic_resistance:
    call RollVsRobMagicResistance
    jr nc, .to_restore_target_and_end_effect
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
    call ActionEffect_RobMagic_StealMP
    ld a, [wBattleActionId]
    cp $df
    jr nz, .skip2
    farcall ActorFormationSlotToTemp0
    ld a, [wBattleActor]
    push af
    ldh a, [hTemp0]
    ld [wBattleActor], a
    call ActionEffect_RobMagic_StealMP
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
    jp StoreActorMessage_Bank36

.to_restore_target_and_end_effect:
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_StopSpell", ROMX

; StopSpell: an already sealed target ends the sub-phase; when the StopSpell roll succeeds
; (ActionEffect_StopSpell_RollVsResistance) seals its spells (BSTAT1_SPELLS_SEALED) with '<name>
; can't use spells now!' ($3B); otherwise 'But ... was unaffected!'. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 51 StopSpell; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_StopSpell::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_SPELLS_SEALED, [hl]
    jr nz, .to_restore_target_and_end_effect
    call ActionEffect_StopSpell_RollVsResistance
    jr nc, .to_store_unaffected_message_bank36
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    set BSTAT1_SPELLS_SEALED, [hl]
    ld l, $3b
    lb bc, $40, $98
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.to_restore_target_and_end_effect:
    jp RestoreTargetAndEndEffect

.to_store_unaffected_message_bank36:
    jp StoreUnaffectedMessage_Bank36

SECTION "Bank 36 ActionEffect_PanicAll", ROMX

; PanicAll (and action $E1): an already confused target gets '<name> became more confused!' ($CF);
; when the PanicAll roll succeeds, confuses it (BSTAT0_CONFUSED) with '<name> became confused!'
; ($42); otherwise 'But ... was unaffected!'. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 52 PanicAll, 120 PaniDance, 173 PanicAll; ids below 175 are skills
; named from StringTable_SkillNames (E-0084)
ActionEffect_PanicAll::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit BSTAT0_CONFUSED, [hl]
    jr nz, .skip
    call ActionEffect_PanicAll_RollVsResistance
    jr nc, .to_store_unaffected_message_bank36
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
    jp StoreTargetMessage_Bank36

.to_store_unaffected_message_bank36:
    jp StoreUnaffectedMessage_Bank36

SECTION "Bank 36 ActionEffect_Ironize", ROMX

; Ironize: turns to iron (status 5 | $C0, the Ironize field at 3) only the target when it is a foe
; outside link mode 1, otherwise every present slot of the target's side; message $46 or $47 by
; ActionEffect_Ironize_Text. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 53 Ironize, 174 Ironize; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
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
    farcall ActionEffect_Ironize_Text
    ld l, d
    lb bc, $00, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

SECTION "Bank 36 ActionEffect_MagicBack", ROMX

; MagicBack and Bounce, on the actor: Bounce sets the lasting bounce (BSTAT2_BOUNCE) and MagicBack
; the one-time one (BSTAT2_MAGIC_BACK), each clearing the other, with 'A veil of light formed before
; <name>!' ($4C / $4B); when the bit is already set, 'But nothing happened!'. (C2, E-0357; probed
; E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 54 MagicBack, 55 Bounce; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
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
    jp StoreTargetMessage_Bank36

SECTION "Bank 36 ActionEffect_Barrier", ROMX

; Barrier: every present slot of the target's side without BSTAT2_DAMAGE_HALVED gets it (absent ones
; lose it); when any gained it, 'A barrier of light appeared.' ($4D), otherwise it ends the
; sub-phase. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 56 Barrier; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
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
    jr z, .to_restore_target_and_end_effect
    ld l, $4d
    lb bc, $00, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.to_restore_target_and_end_effect:
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_MagicWall", ROMX

; Sets BSTAT8_MAGIC_WALL on each present slot among the first three slots of the side of the actor
; (the fourth slot is not visited) and ends the sub-phase. (C2, E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 57 MagicWall; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
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
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_Transform", ROMX

; Transform: stores '<name> assumed G's form!' ($52), takes the target's stats, resistances and the
; rest (ActionEffect_Transform_TakeTargetStats), clears the low three bits of the actor's side
; control, and sets BSTAT1_TRANSFORMED (clearing the dragon form). (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 58 Transform; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_Transform::
    ld l, $52
    lb bc, $40, $90
    call ClearDamageAndStoreResolveMsgFlags_Bank36
    call ActionEffect_Transform_TakeTargetStats
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

SECTION "Bank 36 ResolveStepDamageMessage_SetTransformNameByte", ROMX

; After Transform's picture reload: unless wLinkMode is 1, a foe actor (slot 4 and up) stores
; wBattleTarget in its wSlotNameBytes entry (actor & 3), the byte CopySlotNameToHL_HighSlot checks
; before naming a foe. (C2, E-0371; probed E-0382)
ResolveStepDamageMessage_SetTransformNameByte::
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

SECTION "Bank 36 ActionEffect_BeDragon", ROMX

; BeDragon (and action $DC): the actor becomes monster $0082 ($0262 for $DC) with its stats,
; resistances and skills (ActionEffect_BeDragon_LoadDragonStats), clears the low three bits of its
; side control, sets BSTAT1_DRAGON_FORM (clearing transformed) and shows its species name again;
; '<name> turned into a dragon!' ($44), or for $DC '<name> and G turned into a huge dragon!' ($F7).
; (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 59 BeDragon, $B8; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_BeDragon::
    call ActionEffect_BeDragon_LoadDragonStats
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
    farcall ResetFoeSlotNameToSpecies
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

SECTION "Bank 36 ActionEffect_Chance", ROMX

; Chance: picks one of its effects at random (ActionEffect_Chance_PickEffect), makes it the actor's
; action choice and wBattleActionId, loads its skill record, chooses a new target
; (ChooseTargetForActor) and restarts the resolution at step 3 of sub-phase 0. (C1, E-0357)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 60 Chance; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_Chance::
    farcall ActionEffect_Chance_PickEffect
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

SECTION "Bank 36 ActionEffect_MegaMagic", ROMX

; Effect of MegaMagic (action 61). With wAllMPSpentLo and wAllMPSpentHi both 0 it only stores the
; unaffected message ('But ... was unaffected!'); otherwise the damage comes from
; ActionEffect_MegaMagic_Damage and the hit-or-unaffected message is stored ('took G damage!' for a
; hit, 'But ... was unaffected!' for the target). (C2, E-0382)
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
    jp z, StoreUnaffectedMessage_Bank36
    call ActionEffect_MegaMagic_Damage
    jp StoreHitOrUnaffectedMessage

SECTION "Bank 36 ActionEffect_BigBang", ROMX

; BigBang: skill damage scaled by Blaze resistance with the alternative table; the damage message.
; (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 62 BigBang; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_BigBang::
    call ActionEffect_BigBang_Damage
    jp StoreHitOrUnaffectedMessage

SECTION "Bank 36 ActionEffect_FireAir", ROMX

; FireAir: skill damage scaled by FireAir resistance, halved under a barrier (BSTAT2_DAMAGE_HALVED);
; the damage message. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 64 FireAir, 65 BlazeAir, 66 Scorching, 67 WhiteFire; ids below 175
; are skills named from StringTable_SkillNames (E-0084)
ActionEffect_FireAir::
    call ActionEffect_FireAir_Damage
    call HalveDamageIfTargetStatus2Bit2
    jp StoreHitOrUnaffectedMessage

SECTION "Bank 36 ActionEffect_FrigidAir", ROMX

; FrigidAir: skill damage scaled by FrigidAir resistance, halved under a barrier; the damage
; message. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 68 FrigidAir, 69 IceAir, 70 IceStorm, 71 WhiteAir; ids below 175
; are skills named from StringTable_SkillNames (E-0084)
ActionEffect_FrigidAir::
    call ActionEffect_FrigidAir_Damage
    call HalveDamageIfTargetStatus2Bit2
    jp StoreHitOrUnaffectedMessage

SECTION "Bank 36 ActionEffect_WindBeast", ROMX

; WindBeast: damage from the actor's level (ActionEffect_WindBeast_Damage: 3 x level + 10, at most
; 180, +-15%, Vacuum-scaled); the damage message. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 72 WindBeast; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_WindBeast::
    call ActionEffect_WindBeast_Damage
    jp StoreHitOrUnaffectedMessage

SECTION "Bank 36 ActionEffect_Vacuum", ROMX

; Vacuum: damage from the actor's level (2 x level + 30, at most 150, +-10%, Vacuum-scaled); the
; damage message. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 73 Vacuum; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_Vacuum::
    call ActionEffect_Vacuum_Damage
    jp StoreHitOrUnaffectedMessage

SECTION "Bank 36 ActionEffect_Lightning", ROMX

; Lightning: damage from the actor's level (2 x level + 20, at most 180, +-10%, Bolt-scaled); the
; damage message. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 74 Lightning; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_Lightning::
    call ActionEffect_Lightning_Damage
    jp StoreHitOrUnaffectedMessage

SECTION "Bank 36 ActionEffect_RockThrow", ROMX

; RockThrow: skill damage scaled by RockThrow resistance; the damage message. (C2, E-0357; probed
; E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 75 RockThrow; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_RockThrow::
    call ActionEffect_RockThrow_Damage
    jp StoreHitOrUnaffectedMessage

SECTION "Bank 36 ActionEffect_Watershot", ROMX

; Watershot: skill damage scaled by Watershot resistance; the damage message. (C2, E-0357; probed
; E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 76 Watershot, 77 Tidalwave; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_Watershot::
    call ActionEffect_Watershot_Damage
    jp StoreHitOrUnaffectedMessage

SECTION "Bank 36 ActionEffect_CallHelp", ROMX

; CallHelp: the first time, on a roll of $80 or more sets BSTAT6_CALLED_HELP and shows 'Help arrived
; from seemingly nowhere!' at once (sub-phase 3, step 0), otherwise 'But the call went unheard!'
; ($69); once help has come, deals the helpers' damage (ActionEffect_CallHelp_Damage) with the hit
; message. (C1, E-0357)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 78 CallHelp, 79 YellHelp; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_CallHelp::
    ld a, [wBattleActor]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    bit BSTAT6_CALLED_HELP, [hl]
    jr nz, .call_action_effect_call_help_damage
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
    jp StoreTargetMessage_Bank36

.call_action_effect_call_help_damage:
    call ActionEffect_CallHelp_Damage
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_FireSlash", ROMX

; Effect of FireSlash: the attack damage scaled by the Blaze resistance of the target
; (AttackDamageScaledByBlazeResistance), then the hit message ('took G damage!' for a hit, 'Miss!
; ... was unharmed!' for the target). (C2, E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 80 FireSlash; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_FireSlash::
    call AttackDamageScaledByBlazeResistance
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_VacuSlash", ROMX

; Effect of VacuSlash: the attack damage scaled by the Vacuum resistance of the target
; (AttackDamageScaledByVacuumResistance), then the hit message ('took G damage!' for a hit, 'Miss!
; ... was unharmed!' for the target). (C2, E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 81 VacuSlash; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_VacuSlash::
    call AttackDamageScaledByVacuumResistance
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_BoltSlash", ROMX

; Effect of BoltSlash: the attack damage scaled by the Bolt resistance of the target
; (AttackDamageScaledByBoltResistance), then the hit message ('took G damage!' for a hit, 'Miss! ...
; was unharmed!' for the target). (C2, E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 82 BoltSlash; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_BoltSlash::
    call AttackDamageScaledByBoltResistance
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_IceSlash", ROMX

; Effect of IceSlash: the attack damage scaled by the IceBolt resistance of the target
; (AttackDamageScaledByIceBoltResistance), then the hit message ('took G damage!' for a hit, 'Miss!
; ... was unharmed!' for the target). (C2, E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 83 IceSlash; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_IceSlash::
    call AttackDamageScaledByIceBoltResistance
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_SlimeBlow", ROMX

; Effect of SlimeBlow: AttackDamageHalvedDEFVsSlime (the attack damage, computed against a quarter
; of the DEF of the target when its species family is 0 (Slime), otherwise plain
; ComputeAttackDamage), then the hit message ('took G damage!' for a hit, 'Miss! ... was unharmed!'
; for the target). (C2, E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 84 SlimeBlow; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_SlimeBlow::
    call AttackDamageHalvedDEFVsSlime
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_DrakSlash", ROMX

; Effect of DrakSlash: AttackDamageHalvedDEFVsDragon (the attack damage, computed against a quarter
; of the DEF of the target when its species family is 1 (Dragon), otherwise plain
; ComputeAttackDamage), then the hit message ('took G damage!' for a hit, 'Miss! ... was unharmed!'
; for the target). (C2, E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 85 DrakSlash; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_DrakSlash::
    call AttackDamageHalvedDEFVsDragon
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_BeastCut", ROMX

; Effect of BeastCut: AttackDamageHalvedDEFVsBeast (the attack damage, computed against a quarter of
; the DEF of the target when its species family is 2 (Beast), otherwise plain ComputeAttackDamage),
; then the hit message ('took G damage!' for a hit, 'Miss! ... was unharmed!' for the target). (C2,
; E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 86 BeastCut; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_BeastCut::
    call AttackDamageHalvedDEFVsBeast
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_BirdBlow", ROMX

; Effect of BirdBlow: AttackDamageHalvedDEFVsBird (the attack damage, computed against a quarter of
; the DEF of the target when its species family is 3 (Bird), otherwise plain ComputeAttackDamage),
; then the hit message ('took G damage!' for a hit, 'Miss! ... was unharmed!' for the target). (C2,
; E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 87 BirdBlow; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_BirdBlow::
    call AttackDamageHalvedDEFVsBird
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_BugBlow", ROMX

; Effect of BugBlow: AttackDamageHalvedDEFVsBug (the attack damage, computed against a quarter of
; the DEF of the target when its species family is 5 (Bug), otherwise plain ComputeAttackDamage),
; then the hit message ('took G damage!' for a hit, 'Miss! ... was unharmed!' for the target). (C2,
; E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 88 BugBlow; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_BugBlow::
    call AttackDamageHalvedDEFVsBug
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_Shears", ROMX

; Effect of Shears: AttackDamageHalvedDEFVsPlant (the attack damage, computed against a quarter of
; the DEF of the target when its species family is 4 (Plant), otherwise plain ComputeAttackDamage),
; then the hit message ('took G damage!' for a hit, 'Miss! ... was unharmed!' for the target). (C2,
; E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 89 Shears; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_Shears::
    call AttackDamageHalvedDEFVsPlant
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_DevilCut", ROMX

; Effect of DevilCut: AttackDamageHalvedDEFVsDemon (the attack damage, computed against a quarter of
; the DEF of the target when its species family is 6 (Demon), otherwise plain ComputeAttackDamage),
; then the hit message ('took G damage!' for a hit, 'Miss! ... was unharmed!' for the target). (C2,
; E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 90 DevilCut; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_DevilCut::
    call AttackDamageHalvedDEFVsDemon
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_ZombieCut", ROMX

; Effect of ZombieCut: AttackDamageHalvedDEFVsZombie (the attack damage, computed against a quarter
; of the DEF of the target when its species family is 7 (Zombie), otherwise plain
; ComputeAttackDamage), then the hit message ('took G damage!' for a hit, 'Miss! ... was unharmed!'
; for the target). (C2, E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 91 ZombieCut; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_ZombieCut::
    call AttackDamageHalvedDEFVsZombie
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_CleanCut", ROMX

; Effect of CleanCut: AttackDamageHalvedDEFVsMaterial (the attack damage, computed against a quarter
; of the DEF of the target when its species family is 8 (Material), otherwise plain
; ComputeAttackDamage), then the hit message ('took G damage!' for a hit, 'Miss! ... was unharmed!'
; for the target). (C2, E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 92 CleanCut; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_CleanCut::
    call AttackDamageHalvedDEFVsMaterial
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_AquaCut", ROMX

; Effect of AquaCut: AttackDamageHalvedDEFVsWater (the attack damage, computed against a quarter of
; the DEF of the target when its species family is 9 (Water), otherwise plain ComputeAttackDamage),
; then the hit message ('took G damage!' for a hit, 'Miss! ... was unharmed!' for the target). (C2,
; E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 93 AquaCut; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_AquaCut::
    call AttackDamageHalvedDEFVsWater
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_MetalCut", ROMX

; Effect of MetalCut: AttackDamageTimes1_5IfSlotBodyFlagsBit0 (the attack damage, times 3/2 plus 1
; when bit 0 of the wSlotBodyFlags byte of the target is set), then the hit message ('took G
; damage!' for a hit, 'Miss! ... was unharmed!' for the target). (C2, E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 94 MetalCut; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_MetalCut::
    call AttackDamageTimes1_5IfSlotBodyFlagsBit0
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_PoisonHit", ROMX

; PoisonHit: Fight's effect (attack damage and hit message). (C2, E-0357; probed E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 95 PoisonHit, 96 Paralyze, 97 NapAttack; the misaligned decoding before E-0126 hid
; this entry (E-0126)
ActionEffect_PoisonHit::
    call ActionEffect_Fight
    ret

SECTION "Bank 36 ActionEffect_SquallHit", ROMX

; Effect of SquallHit: the attack damage (ComputeAttackDamage) scaled to 80 percent
; (ScaleHLTo80Percent_Bank36), then the hit message ('took G damage!' for a hit, 'Miss! ... was
; unharmed!' for the target). (C2, E-0382)
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
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_BiAttack", ROMX

; BiAttack (QuadHits): the reduced-ATK damage of ActionEffect_BiAttack_Damage (ATK cut to 75% or
; 62.5% against half the DEF); the hit message. (C2, E-0357; probed E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 99 BiAttack, 100 QuadHits; the misaligned decoding before E-0126 hid this entry
; (E-0126)
ActionEffect_BiAttack::
    call ActionEffect_BiAttack_Damage
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_RainSlash", ROMX

; Effect of RainSlash: the attack damage (ComputeAttackDamage) scaled by the slot of the target & 3:
; 80 percent for 0, 60 percent for 1 and 40 percent for 2 and 3 (ScaleHLTo80Percent_Bank36,
; ScaleHLTo60Percent, ScaleHLTo40Percent), then the hit message ('took G damage!' for a hit, 'Miss!
; ... was unharmed!' for the target). (C2, E-0382)
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
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_MultiCut", ROMX

; Effect of MultiCut: the damage of ActionEffect_MultiCut_Damage (rolled from the skill record of
; wBattleActionId, times 21/16 against species family 7, scaled by the resistance in byte 1 bits 7-6
; of the target), then the hit message ('took G damage!' for a hit, 'Miss! ... was unharmed!' for
; the target). (C2, E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 102 MultiCut; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_MultiCut::
    call ActionEffect_MultiCut_Damage
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_GigaSlash", ROMX

; Effect of GigaSlash: SkillDamageScaledByGigaSlashResistance (the rolled skill damage scaled by the
; GigaSlash resistance of the target), then the hit message ('took G damage!' for a hit, 'Miss! ...
; was unharmed!' for the target). (C2, E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 103 GigaSlash; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_GigaSlash::
    call SkillDamageScaledByGigaSlashResistance
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_ChargeUp", ROMX

; Effect of ChargeUp: ORs $03 into status 4 of the actor (BSTAT4_CHARGE_UP and BSTAT4_CHARGE_UP_HI,
; other bits kept) and ends the sub-phase (RestoreTargetAndEndEffect). ResolveStepComputeDamage
; doubles the damage of a skill that has bit 5 of record byte 6 while BSTAT4_CHARGE_UP is set. (C2,
; E-0382)
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
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_PsycheUp", ROMX

; PsycheUp: the attack damage times 1.5 (ScaleHLBy3Over2); the hit message. (C2, E-0357; probed
; E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 105 PsycheUp; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
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
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_HighJump", ROMX

; HighJump: on the first turn sets the actor's HighJump field (status 4 | $0C) and ends the
; sub-phase (it is up in the air); with the field set, clears it and lands with PsycheUp's damage
; (ActionEffect_HighJump_Land). (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 106 HighJump; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_HighJump::
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    ld a, [hl]
    and $0c
    jr nz, ActionEffect_HighJump_Land
    ld a, [hl]
    or $0c
    ld [hl], a
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_HighJump_Land", ROMX

; HighJump: clears bits 2-3 of the status byte at HL, then goes on as PsycheUp. (C2, E-0357; probed
; E-0382)
ActionEffect_HighJump_Land::
    ld a, [hl]
    and $f3
    ld [hl], a
    jr ActionEffect_PsycheUp

SECTION "Bank 36 ActionEffect_EvilSlash", ROMX

; EvilSlash: against a target some status blocks, or on a roll of $A0 or more, clears the actor's
; critical roll and deals its ATK within 5% as damage; otherwise '<name> leapt out of the way!'
; ($D2). (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 107 EvilSlash; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
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
    jp StoreResolveMessage_Bank36

.skip:
    ld h, $d2
    lb bc, $00, $80
    jp StoreTargetMessage_Bank36

SECTION "Bank 36 ActionEffect_Massacre", ROMX

; Massacre: clears the actor's critical roll and deals its ATK within 5% as damage ('took G damage!'
; / 'But ... was unaffected!'). (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 108 Massacre; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
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
    jp StoreResolveMessage_Bank36

SECTION "Bank 36 ActionEffect_TwinSlash", ROMX

; TwinSlash: clears the actor's critical roll, then PsycheUp's damage (attack damage x 1.5). (C2,
; E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 109 TwinSlash; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_TwinSlash::
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    res BSTAT2_CRITICAL_ROLLED, [hl]
    call ActionEffect_PsycheUp
    ret

SECTION "Bank 36 ActionEffect_Berserker", ROMX

; Berserker: sets BSTAT6_BERSERK on the actor, clears its critical roll and deals twice the attack
; damage; the hit message. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 110 Berserker; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
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
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_Ramming", ROMX

; Effect of Ramming: DamageEightyPercentOfTargetHPScaled (80 percent of the current HP of the target
; plus 1, scaled by the resistance in byte 3 bits 1-0 of the target), then the hit message ('took G
; damage!' for a hit, 'Miss! ... was unharmed!' for the target). (C2, E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 111 Ramming; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_Ramming::
    call DamageEightyPercentOfTargetHPScaled
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_Kamikaze", ROMX

; Effect of Kamikaze: the damage of ActionEffect_Kamikaze_Damage (0 when its roll against byte 3
; bits 1-0 of the resistances of the target fails; otherwise derived from the HP of the actor and of
; the target), then the hit-or-unaffected message ('took G damage!' for a hit, 'But ... was
; unaffected!' for the target). (C2, E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 112 Kamikaze; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_Kamikaze::
    call ActionEffect_Kamikaze_Damage
    jp StoreHitOrUnaffectedMessage

SECTION "Bank 36 ActionEffect_PalsyAir", ROMX

; PalsyAir: an already paralyzed target ends the sub-phase; when the roll gets through PalsyAir
; resistance, paralyzes it with '<name> became paralyzed!' ($76); otherwise 'But ... was
; unaffected!'. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 114 PalsyAir; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_PalsyAir::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit BSTAT0_PARALYZED, [hl]
    jr nz, .to_restore_target_and_end_effect
    push hl
    call RollVsPalsyAirResistance
    pop hl
    jr c, .skip
    ld h, $b5
    lb bc, $08, $88
    jp StoreTargetMessage_Bank36

.skip:
    set 6, [hl]
    ld l, $76
    lb bc, $40, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.to_restore_target_and_end_effect:
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_PoisonGas", ROMX

; PoisonGas and PoisonAir: PoisonAir badly poisons ('<name> was terribly poisoned!', $77; skipped
; when already badly poisoned), the others poison ('<name> was poisoned!', $75; skipped when
; poisoned either way), each replacing the other kind, when the roll gets through PoisonGas
; resistance; otherwise 'But ... was unaffected!'. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 115 PoisonGas, 116 PoisonAir; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_PoisonGas::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [wBattleActionId]
    cp SKILL_POISONAIR
    jr z, .skip
    ld a, [hl]
    and $03
    jr nz, .to_restore_target_and_end_effect
    jr .call_roll_vs_poison_gas_resistance

.skip:
    bit 1, [hl]
    jr nz, .to_restore_target_and_end_effect

.call_roll_vs_poison_gas_resistance:
    push hl
    call RollVsPoisonGasResistance
    pop hl
    jr c, .check_battle_action_id
    ld h, $b5
    lb bc, $08, $88
    jp StoreTargetMessage_Bank36

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

.to_restore_target_and_end_effect:
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_Curse", ROMX

; Curse: an already cursed target ends the sub-phase; when the Curse roll succeeds
; (ActionEffect_Curse_RollVsResistance) curses it with '<name> was cursed!' ($D9); otherwise 'But
; ... was unaffected!'. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 117 Curse; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_Curse::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit BSTAT0_CURSED, [hl]
    jr nz, .to_restore_target_and_end_effect
    push hl
    call ActionEffect_Curse_RollVsResistance
    pop hl
    jr c, .skip
    ld h, $b5
    lb bc, $08, $88
    jp StoreTargetMessage_Bank36

.skip:
    set 5, [hl]
    ld l, $d9
    lb bc, $40, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.to_restore_target_and_end_effect:
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_OddDance", ROMX

; OddDance: a target without MP ends the sub-phase; when the roll gets through RobMagic resistance,
; drains its MP (DrainTargetMPAmount) with '<name> lost GMP!' ($57); otherwise 'But ... was
; unaffected!'. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 118 OddDance; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_OddDance::
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    ld a, [hli]
    or [hl]
    jr z, .to_restore_target_and_end_effect
    call RollVsRobMagicResistance
    jp nc, StoreUnaffectedMessage_Bank36
    call DrainTargetMPAmount
    ld l, $57
    lb bc, $40, $90
    jp StoreActorMessage_Bank36

.to_restore_target_and_end_effect:
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_LureDance", ROMX

; LureDance: an already dancing target ends the sub-phase; when the roll gets through LegSweep
; resistance, sets BSTAT3_DANCING, clears its SideStep and status 7 bits 0-2, and says '<name>
; joined the dancing!' ($58); otherwise 'But ... was unaffected!'. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 122 LureDance; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_LureDance::
    call TargetStatus3Address
    bit BSTAT3_DANCING, [hl]
    jr nz, .to_restore_target_and_end_effect
    call RollVsLegSweepResistance
    jr nc, .to_store_unaffected_message_bank36
    call TargetStatus3Address
    set BSTAT3_DANCING, [hl]
    call ClearTargetStatus5Bits23And7Bits012
    ld l, $58
    lb bc, $00, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.to_store_unaffected_message_bank36:
    jp StoreUnaffectedMessage_Bank36

.to_restore_target_and_end_effect:
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_LifeDance", ROMX

; LifeDance: on a repeated hit, or on a coin flip, Farewell's effect; otherwise shows 'But nothing
; happened!' at once and jumps to resolve step $0E of sub-phase 1 (screen flag bit 0 set). (C1,
; E-0357)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 123 LifeDance; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
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

SECTION "Bank 36 ActionEffect_SideStep", ROMX

; SideStep: unless the actor's SideStep field is set, sets it to 1 or 2 at random; then ends the
; sub-phase. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 125 SideStep; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_SideStep::
    call AdvanceRandom
    ld a, [wBattleActor]
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hl]
    and $0c
    jr nz, .to_restore_target_and_end_effect
    ld a, [wRandomLo]
    and $04
    add $04
    ld b, a
    ld a, [hl]
    and $f3
    or b
    ld [hl], a

.to_restore_target_and_end_effect:
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_SandStorm", ROMX

; SandStorm: the blinding with D = 2 (BSTAT5_SANDSTORM_BLIND; ActionEffect_Radiant_Blind): '<name>
; was blinded by sand!'. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 126 SandStorm; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_SandStorm::
    ld d, $02
    jr ActionEffect_Radiant_Blind

SECTION "Bank 36 ActionEffect_Radiant", ROMX

; Radiant: the blinding with D = 1 (BSTAT5_RADIANT_BLIND): a target with bit D or BSTAT1_BLINDED
; ends the sub-phase; when the roll gets through Radiant resistance sets bit D with message action -
; $2A ('<name>'s vision was harmed!'); otherwise 'But ... was unaffected!'. (C2, E-0357; probed
; E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 127 Radiant; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_Radiant::
    ld d, $01

; Radiant and SandStorm's blinding: no effect when the target already has the blinding bit D or is
; blinded; otherwise a roll against its Radiant resistance either sets bit D in status 5 (message
; action - $2A, flags $90) or fails (target message $B5, flags $88). (C2, E-0357; probed E-0382)
ActionEffect_Radiant_Blind::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hl]
    and d
    jr nz, .to_restore_target_and_end_effect
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_BLINDED, [hl]
    jr nz, .to_restore_target_and_end_effect
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
    jp StoreTargetMessage_Bank36

.to_restore_target_and_end_effect:
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_EerieLite", ROMX

; EerieLite: when the target already has BSTAT8_EERIE_LITE, 'But nothing happened!'; when the
; EerieLite roll succeeds sets it with '<name> is now weak to spells!' ($D5); otherwise 'But ... was
; unaffected!'. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 128 EerieLite; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_EerieLite::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus8
    call AddAx9ToHL
    bit BSTAT8_EERIE_LITE, [hl]
    jr nz, .skip2
    call ActionEffect_EerieLite_RollVsResistance
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
    jp StoreTargetMessage_Bank36

.skip2:
    ld h, $cc
    lb bc, $00, $84
    jp StoreTargetMessage_Bank36

SECTION "Bank 36 ActionEffect_Surge", ROMX

; Surge: cures the target (ActionEffect_Surge_CureTarget: status 0, the seals and blindings, and
; stats lowered back to base) with '<name> was fully cured!' ($60). (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 129 Surge; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_Surge::
    farcall ActionEffect_Surge_CureTarget
    ld l, $60
    lb bc, $00, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

SECTION "Bank 36 ActionEffect_UltraDown", ROMX

; UltraDown: when the roll gets through Beat resistance and the target can still be lowered
; (ActionEffect_UltraDown_CanLower), lowers its DEF (LowerTargetDEF) and clears the sub-step;
; otherwise 'But ... was unaffected!'. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 130 UltraDown; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_UltraDown::
    call RollVsBeatResistance
    jr nc, .skip
    call ActionEffect_UltraDown_CanLower
    jr nc, .skip
    call LowerTargetDEF
    xor a
    ld [wBattleSubStep], a
    ret

.skip:
    ld h, $b5
    lb bc, $00, $80
    jp StoreTargetMessage_Bank36

SECTION "Bank 36 ActionEffect_DeMagic", ROMX

; DeMagic: clears most of the target's applied statuses (ActionEffect_DeMagic_ClearTargetStatus),
; clears the sub-step and says '<name> lost all applied magic!' ($5E). (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 131 DeMagic, 132 ThickFog, $B3; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_DeMagic::
    farcall ActionEffect_DeMagic_ClearTargetStatus
    xor a
    ld [wBattleSubStep], a
    ld l, $5e
    lb bc, $00, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

SECTION "Bank 36 ActionEffect_TatsuCall", ROMX

; TatsuCall (DiagoCall, SamsiCall, BazooCall): once per side (side flag bit 2; later calls 'But
; nothing happened!'); always with personality act bit 2, otherwise on a roll below $C0; monster
; action - 7 joins in the side's fourth slot (wSpecialSlotMonsters,
; ActionEffect_TatsuCall_PutMonsterIn), becomes the target, and '<name> joined the battle!' ($61); a
; failed roll gives 'But the prayer went unanswered!' ($72). (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 133 TatsuCall, 134 DiagoCall, 135 SamsiCall, 136 BazooCall; ids
; below 175 are skills named from StringTable_SkillNames (E-0084)
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
    call ActionEffect_TatsuCall_PutMonsterIn
    ld a, [wLoadSlot]
    ld [wBattleTarget], a
    ld l, $61
    lb bc, $00, $90
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.skip:
    ld h, $72
    lb bc, $00, $80
    jp StoreTargetMessage_Bank36

.skip2:
    ld h, $cc
    lb bc, $00, $84
    jp StoreTargetMessage_Bank36

SECTION "Bank 36 ActionEffect_SuckAir", ROMX

; SuckAir: sets the actor's SuckAir field (status 4 | $30) and ends the sub-phase. (C2, E-0357;
; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 137 SuckAir; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_SuckAir::
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    ld a, [hl]
    or $30
    ld [hl], a
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_Focus", ROMX

; Focus: sets BSTAT4_FOCUS on the actor and ends the sub-phase. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 138 Focus; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_Focus::
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    set BSTAT4_FOCUS, [hl]
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_LushLicks", ROMX

; LushLicks and SickLick: a shivering target ends the sub-phase; when the roll gets through LegSweep
; resistance (Sap resistance for SickLick), sets BSTAT3_SHIVERING and clears its SideStep and status
; 7 bits 0-2; SickLick also drops its DEF to 1 (marking BSTAT6_STATS_LOWERED); message action - $31
; ('<name> got goose bumps!', $5A; SickLick adds that its DEF dropped to 1, $5B); a failed roll
; gives '<name> was unharmed!' ($71). (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 139 LushLicks, 140 SickLick; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_LushLicks::
    call TargetStatus3Address
    bit BSTAT3_SHIVERING, [hl]
    jr nz, .to_restore_target_and_end_effect
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
    jp StoreTargetMessage_Bank36

.to_restore_target_and_end_effect:
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_LegSweep", ROMX

; LegSweep: a tripped target ends the sub-phase; when the roll gets through LegSweep resistance,
; sets BSTAT3_TRIPPED, clears its SideStep and status 7 bits 0-2, and says '<name> wiped out!'
; ($5D); otherwise '<name> slid out of the way!' ($70), or 'But it failed to reach <name>!' ($68)
; for a target with body flag bit 4. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 141 LegSweep, 142 BigTrip; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_LegSweep::
    call TargetStatus3Address
    bit BSTAT3_TRIPPED, [hl]
    jp nz, RestoreTargetAndEndEffect
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
    jp StoreTargetMessage_Bank36

SECTION "Bank 36 ActionEffect_Ahhh", ROMX

; Ahhh: a vacant target ends the sub-phase; when the roll gets through LegSweep resistance, sets
; BSTAT3_VACANT, clears its SideStep and status 7 bits 0-2, and says '<name> looks content!' ($59);
; otherwise 'But ... was unaffected!'. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 143 Ahhh; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_Ahhh::
    call TargetStatus3Address
    bit BSTAT3_VACANT, [hl]
    jr nz, .to_restore_target_and_end_effect
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
    jp StoreTargetMessage_Bank36

.to_restore_target_and_end_effect:
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_WarCry", ROMX

; WarCry: a cowering target ends the sub-phase; when the roll gets through LegSweep resistance, sets
; BSTAT3_COWERING, clears its SideStep and status 7 bits 0-2, and says '<name> was shocked!' ($5C);
; otherwise '<name> quickly covered its ears!' ($6B). (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 144 WarCry; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_WarCry::
    call TargetStatus3Address
    bit BSTAT3_COWERING, [hl]
    jr nz, .to_restore_target_and_end_effect
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
    jp StoreTargetMessage_Bank36

.to_restore_target_and_end_effect:
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_Geyser", ROMX

; Geyser: when the actor's own airborne field is 1 it backfires (ActionEffect_Geyser_Backfire); when
; the roll gets through Watershot resistance the target's status 3 becomes $40 (airborne, its other
; byte 3 bits cleared), its personality acts are cleared, '<name> was blown sky-high!' is shown at
; once and the resolve step restarts; otherwise '<name> quickly dodged the attack!' ($6E). (C1,
; E-0357)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 145 Geyser; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_Geyser::
    ld a, [wBattleActor]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl]
    and $c0
    cp $40
    jr z, ActionEffect_Geyser_Backfire
    call ActionEffect_Geyser_RollVsResistance
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
    jp StoreTargetMessage_Bank36

SECTION "Bank 36 ActionEffect_Geyser_Backfire", ROMX

; Geyser's backlash: clears bits 6-7 of the status byte at HL and turns on the actor: a paralyzed or
; sleeping actor always, others half the time, take 5-15% of their max HP (at least 1; messages
; $AD/$D0); otherwise target message $AF. (C2, E-0357; probed E-0382)
ActionEffect_Geyser_Backfire::
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
    call ActionEffect_Geyser_ScaleHLTo15Percent
    ld c, l
    ld b, h
    pop hl
    push bc
    call ActionEffect_Geyser_ScaleHLTo5Percent
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
    jp StoreResolveMessage_Bank36

.skip:
    ld h, $af
    lb bc, $00, $80
    jp StoreTargetMessage_Bank36

SECTION "Bank 36 ActionEffect_DanceShut", ROMX

; DanceShut: an already dance-sealed target ends the sub-phase; when the DanceShut roll succeeds
; seals its dances (BSTAT1_DANCE_SEALED) with '<name> can't dance anymore!' ($DE); otherwise 'But
; ... was unaffected!'. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 146 DanceShut; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_DanceShut::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_DANCE_SEALED, [hl]
    jp nz, RestoreTargetAndEndEffect
    call ActionEffect_DanceShut_RollVsResistance
    jr nc, .to_store_unaffected_message_bank36
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    set BSTAT1_DANCE_SEALED, [hl]
    ld l, $de
    lb bc, $40, $98
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.to_store_unaffected_message_bank36:
    jp StoreUnaffectedMessage_Bank36

SECTION "Bank 36 ActionEffect_MouthShut", ROMX

; MouthShut: an already breath-sealed target ends the sub-phase; when the MouthShut roll succeeds
; seals its breaths (BSTAT1_BREATH_SEALED) with '<name>'s mouth was sealed!' ($64); otherwise 'But
; ... was unaffected!'. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 147 MouthShut; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_MouthShut::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_BREATH_SEALED, [hl]
    jr nz, .to_restore_target_and_end_effect
    call ActionEffect_MouthShut_RollVsResistance
    jr nc, .to_store_unaffected_message_bank36
    ld a, [wBattleTarget]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    set BSTAT1_BREATH_SEALED, [hl]
    ld l, $64
    lb bc, $40, $98
    jp ClearDamageAndStoreResolveMsgFlags_Bank36

.to_store_unaffected_message_bank36:
    jp StoreUnaffectedMessage_Bank36

.to_restore_target_and_end_effect:
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_StrongD", ROMX

; StrongD (BladeD, action $E0): sets the low nibble of the actor's status 7 to 2
; (BSTAT7_DAMAGE_X10), 4 for BladeD (BSTAT7_COUNTER) or $0C for $E0 (doubled and counter), then ends
; the sub-phase. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 148 StrongD, 150 BladeD; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
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
    jr .to_restore_target_and_end_effect

.skip:
    ld a, [hl]
    and $f0
    or $02
    ld [hl], a
    jr .to_restore_target_and_end_effect

.skip2:
    ld a, [hl]
    and $f0
    or $04
    ld [hl], a

.to_restore_target_and_end_effect:
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_Dodge", ROMX

; Dodge: sets BSTAT6_DODGE on the actor and ends the sub-phase. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 149 Dodge; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_Dodge::
    ld a, [wBattleActor]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    set BSTAT6_DODGE, [hl]
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_Cover", ROMX

; Cover and Guardian: when bit 4 of the wSideFlags0 byte of the side of the target is already set
; nothing happens. Cover looks at the target only; Guardian sets that bit and goes over the first
; three slots of the side of the target. A present slot other than the actor that does not have
; BSTAT6_GUARDED gets it, and the slot of the actor is ORed into the high nibble of its status 7.
; The sub-phase ends. (C2, E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 151 Cover, 152 Guardian; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_Cover::
    ld a, [wBattleTarget]
    rrca
    rrca
    and $01
    ld hl, wSideFlags0
    add_a_to_hl
    bit 4, [hl]
    jp nz, RestoreTargetAndEndEffect
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
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_TailWind", ROMX

; TailWind gives the target BSTAT2_WIND_GUARD. StormWind gives it to each present slot among the
; first three slots of the side of the target and sets bit 5 of the wSideFlags0 byte of that side.
; The sub-phase ends. (C2, E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 153 TailWind, 154 StormWind; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_TailWind::
    ld a, [wBattleActionId]
    cp SKILL_STORMWIND
    jr z, .check_battle_target
    ld a, [wBattleTarget]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    set BSTAT2_WIND_GUARD, [hl]
    jr .to_restore_target_and_end_effect

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

.to_restore_target_and_end_effect:
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_AquaWall", ROMX

; AquaWall: sets BSTAT2_AQUA_WALL on the actor and ends the sub-phase. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 155 AquaWall; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_AquaWall::
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    set BSTAT2_AQUA_WALL, [hl]
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_SealPray", ROMX

; SealPray: sets BSTAT8_SEAL_PRAY on the actor and ends the sub-phase. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 156 SealPray; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_SealPray::
    ld a, [wBattleActor]
    ld hl, wBattleStatus8
    call AddAx9ToHL
    set BSTAT8_SEAL_PRAY, [hl]
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_SuckAll", ROMX

; SuckAll: once per side (side flag bit 6): records the actor's slot (x 4) in the side's
; wSlotPairBytes entry and sets BSTAT6_SUCK_ALL on it; then ends the sub-phase. (C2, E-0357; probed
; E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 157 SuckAll; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_SuckAll::
    ld a, [wBattleActor]
    rrca
    rrca
    and $01
    ld b, a
    ld hl, wSideFlags0
    add_a_to_hl
    bit 6, [hl]
    jp nz, RestoreTargetAndEndEffect
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
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_Imitate", ROMX

; Imitate: sets BSTAT6_IMITATE on the actor and ends the sub-phase. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 158 Imitate; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_Imitate::
    ld a, [wBattleActor]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    set BSTAT6_IMITATE, [hl]
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_Meditate", ROMX

; Effect of Meditate: heals the actor by 500 HP, at most up to its max HP
; (ActionEffect_Meditate_Heal), and stores the message actor $37 'wound was healed!' (flags $90,
; argument $40); an actor already at its max HP gets 'But nothing happened!'. The damage word is not
; touched. (C2, E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 159 Meditate; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_Meditate::
    call ActionEffect_Meditate_Heal
    jr nc, .to_store_nothing_happened_message_bank36
    ld l, $37
    lb bc, $40, $90
    jp StoreActorMessage_Bank36

.to_store_nothing_happened_message_bank36:
    jp StoreNothingHappenedMessage_Bank36

SECTION "Bank 36 ActionEffect_LifeSong", ROMX

; Effect of LifeSong. When BSTAT5_SONG_FORCED (status 5 bit 4) is not set on the actor it sets
; BSTAT5_LIFE_SONG (status 5 bit 5) and ends with wBattleSubPhase 7 and wBattleResolveStep 0
; (SetSubPhase7AndResetResolveStep). With BSTAT5_SONG_FORCED set (the forced turn that
; ForcedActionForActorStatus gives as action $CE) it goes on as ActionEffect_LifeSong_Revive
; instead. (C1, E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 160 LifeSong; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_LifeSong::
    ld a, [wBattleActor]
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hl]
    and $10
    jr nz, ActionEffect_LifeSong_Revive
    ld a, [hl]
    and $cf
    or $20
    ld [hl], a
    jp SetSubPhase7AndResetResolveStep

SECTION "Bank 36 ActionEffect_LifeSong_Revive", ROMX

; LifeSong: on its first hit half the time ends with battle text $72; otherwise a fallen target (not
; slot 3 or 7) comes back with full HP (ApplyTargetMaxHPAmount); anything else has no effect. (C1,
; E-0357)
ActionEffect_LifeSong_Revive::
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
    jr nc, .to_restore_target_and_end_effect
    jr z, .to_restore_target_and_end_effect
    ld a, [wBattleTarget]
    and $03
    cp $03
    jr z, .to_restore_target_and_end_effect
    call ApplyTargetMaxHPAmount
    ret

.to_restore_target_and_end_effect:
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_LoveRain", ROMX

; LoveRain: the first time, stores a random heal kind (0, 1 or 2 by wRandomLo's low nibble, from
; ActionEffect_LoveRain_Data) in the actor's wHealFlags entry, sets BSTAT8_LOVE_RAIN and ends with
; sub-phase 7; with BSTAT8_LOVE_RAIN_FORCED set, heals when wLoveRainFlag is set
; (ActionEffect_LoveRain_HealIfFlagSet). (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) 161 LoveRain; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_LoveRain::
    ld a, [wBattleActor]
    ld hl, wBattleStatus8
    call AddAx9ToHL
    ld a, [hl]
    and $01
    jr nz, ActionEffect_LoveRain_HealIfFlagSet
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

SECTION "Bank 36 ActionEffect_LoveRain_HealIfFlagSet", ROMX

; LoveRain: heals (ActionEffect_Heal) when the LoveRain flag is set, otherwise ends (sub-phase 7).
; (C2, E-0357; probed E-0382)
ActionEffect_LoveRain_HealIfFlagSet::
    ld a, [wLoveRainFlag]
    or a
    jr z, .to_set_sub_phase7_and_reset_resolve_step
    call ActionEffect_Heal
    ret

.to_set_sub_phase7_and_reset_resolve_step:
    jp SetSubPhase7AndResetResolveStep

SECTION "Bank 36 ActionEffect_LoveRain_Data", ROMX

; Sixteen bytes: 0 seven times, 1 five times and 2 four times. ActionEffect_LoveRain indexes it by
; the low nibble of wRandomLo and stores the byte (the heal kind 0, 1 or 2) in the actor wHealFlags
; entry, so the three kinds have odds 7, 5 and 4 in 16. (C1, E-0381)
ActionEffect_LoveRain_Data::
    db $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $01, $01, $02, $02, $02, $02

; Whistle, Pheromone, StepGuard, Outside, Informer, Errand ... (field skills): no battle effect.
; (C2, E-0357; probed E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 162 Whistle, 163 Pheromone, 164 StepGuard, 165 Outside, 166 Informer, 167 Errand
; ...; the misaligned decoding before E-0126 hid this entry (E-0126)
ActionEffect_Whistle::
    ret

SECTION "Bank 36 ActionEffect_AhhhAA", ROMX

; Effect of action $AA (a second skill named Ahhh): the attack damage (ComputeAttackDamage) halved
; (ShiftHLRight1), then the hit-or-unaffected message ('took G damage!' for a hit, 'But ... was
; unaffected!' for the target). (C2, E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 170 Ahhh; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126) (E-0344: the address in its name dropped or read as the label there; was
; ActionEffect_AhhhAA)
ActionEffect_AhhhAA::
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
    jp StoreHitOrUnaffectedMessage

SECTION "Bank 36 ActionEffect_Guard", ROMX

; Effect of Guard: sets the low nibble of status 7 of the actor to 1 (BSTAT7_GUARD), keeping the
; high nibble, and ends the sub-phase. (C2, E-0382)
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
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_ActionB0", ROMX

; Action $B0 (a Chance effect): only for a player-side actor outside link play; a foe target is
; removed (HP 0, out $FF, slot bytes cleared, picture blanked) with '<name> fled!' ($D8) and sound
; $82, or for action $B2 'The <name> shattered!'; a player-side target only gets '<name> was
; shocked!' ($5C, $8F for $B2); shown at once, then the sub-phase ends. (C1, E-0357)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $B0, $B2; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_ActionB0::
    ld a, [wLinkMode]
    or a
    jp nz, RestoreTargetAndEndEffect
    ld a, [wBattleActor]
    cp $04
    jp nc, RestoreTargetAndEndEffect
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
    cp ACTION_B2
    ld d, $8f
    jr z, .call_show_battle_text
    ld d, $d8 ; battle text '0 fled!'
    farcall ShowBattleText
    ld a, $82
    call QueueSoundEffect
    jp RestoreTargetAndEndEffect

.check_battle_action_id:
    ld a, [wBattleActionId]
    cp ACTION_B2
    ld d, $8f
    jr z, .call_show_battle_text
    ld d, $5c ; battle text '0 was shocked!'

.call_show_battle_text:
    farcall ShowBattleText
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_ActionB4", ROMX

; Action $B4: sets BSTAT1_CRITICAL on each present slot among the first three slots of the side of
; the actor, then ends the sub-phase. (C2, E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $B4; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
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
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_ActionB5", ROMX

; Action $B5: puts the target to sleep (status 0 | $8C) unless it already sleeps ('<name> is already
; asleep!'), with '<name> was put to sleep!' ($73), or '<name> fell asleep!' ($74) on the local
; side. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $B5; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
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
    jp StoreTargetMessage_Bank36

SECTION "Bank 36 ActionEffect_ActionB6", ROMX

; Action $B6: empties the target's MP with '<name> lost its MP!' ($DF); a target without MP ends the
; sub-phase. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $B6; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
ActionEffect_ActionB6::
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank36
    ld a, [hli]
    or [hl]
    jp z, RestoreTargetAndEndEffect
    xor a
    ld [hld], a
    ld [hl], a
    ld l, $df
    lb bc, $40, $90
    jp StoreActorMessage_Bank36

SECTION "Bank 36 ActionEffect_ActionB9", ROMX

; Action $B9 (185): works out the attack damage as if the ATK of the actor (wBattleActor) were 200,
; so its real ATK no longer matters: AttackDamageWithATK200 swaps 200 into the wBattleATK word of
; the actor, runs ComputeAttackDamage and puts the old word back. Then it stores the hit message
; with StoreHitMessage_Bank36. Reached through ActionEffectTable; no skill name or purpose for id
; 185 has been found. (C2, E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 185; the misaligned decoding before E-0126 hid this entry; the body is not
; interpreted (E-0126)
ActionEffect_ActionB9::
    call AttackDamageWithATK200
    jp StoreHitMessage_Bank36

SECTION "Bank 36 ActionEffect_ActionBA", ROMX

; Action $BA: freezes the target (BSTAT3_FROZEN), clearing its SideStep and status 7 bits 0-2, with
; '<name> froze solid!' ($78); already frozen, the sub-phase ends. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $BA; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
ActionEffect_ActionBA::
    call TargetStatus3Address
    bit BSTAT3_FROZEN, [hl]
    jp nz, RestoreTargetAndEndEffect
    set 0, [hl]
    call ClearTargetStatus5Bits23And7Bits012
    ld l, $78
    lb bc, $00, $98
    jp StoreActorMessage_Bank36

SECTION "Bank 36 ActionEffect_ActionBC", ROMX

; Action $BC: fills the target's MP to its max with '<name>'s MP was restored!' ($C3); at full MP
; the sub-phase ends. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $BC; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
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
    jp z, RestoreTargetAndEndEffect
    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    ld l, $c3
    lb bc, $40, $90
    jp StoreActorMessage_Bank36

SECTION "Bank 36 ActionEffect_ActionBD", ROMX

; Action $BD: a target at 1 HP takes 1 damage ('took G damage!'); any other target's HP becomes 1
; with '<name> was brutalized!' ($38). (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $BD; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
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
    jr .to_store_actor_message_bank36

.skip:
    ld a, $01
    ld [bc], a
    inc bc
    ld a, $00
    ld [bc], a
    ld l, $38
    lb bc, $40, $90

.to_store_actor_message_bank36:
    jp StoreActorMessage_Bank36

SECTION "Bank 36 ActionEffect_ActionC0", ROMX

; Action $C0: on a roll of $40 or more the attack damage ('took G damage!', $36); otherwise 'Miss!
; <name> avoided damage!' ($D1). (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $C0; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
ActionEffect_ActionC0::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $40
    jr c, .skip
    call ComputeAttackDamage
    lb hl, $d1, $36
    lb bc, $80, $a8
    jp StoreResolveMessage_Bank36

.skip:
    ld h, $d1
    lb bc, $08, $88
    jp StoreTargetMessage_Bank36

SECTION "Bank 36 ActionEffect_ActionC1", ROMX

; Action $C1: on a roll of $C0 or more the attack damage with the hit message; otherwise 'Miss!
; <name> was unharmed!' ($D0). (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $C1; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
ActionEffect_ActionC1::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $c0
    jr c, .skip
    call ComputeAttackDamage
    jp StoreHitMessage_Bank36

.skip:
    ld h, $d0
    lb bc, $08, $88
    jp StoreTargetMessage_Bank36

SECTION "Bank 36 ActionEffect_ActionC2", ROMX

; Action $C2: Fight's effect. (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $C2; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
ActionEffect_ActionC2::
    call ActionEffect_Fight
    ret

SECTION "Bank 36 ActionEffect_ZoneOut", ROMX

; ZoneOut: no effect; ends the sub-phase. (C2, E-0357; probed E-0382)
; effect routine reached through ActionEffectTable (ActionEffectTable, indexed by wBattleActionId)
; for action(s) 171 ZoneOut, 183, 195, 196; the misaligned decoding before E-0126 hid this entry
; (E-0126)
ActionEffect_ZoneOut::
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_ActionC5", ROMX

; Action $C5: the actor trips itself (BSTAT3_TRIPPED); ends the sub-phase. (C2, E-0357; probed
; E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $C5; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
ActionEffect_ActionC5::
    ld a, [wBattleActor]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    set BSTAT3_TRIPPED, [hl]
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_ActionC6", ROMX

; Action $C6: the actor becomes paralyzed (BSTAT0_PARALYZED) with '<name> became paralyzed!' ($76).
; (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $C6, $C7; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
ActionEffect_ActionC6::
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    set BSTAT0_PARALYZED, [hl]
    ld l, $76
    lb bc, $40, $90
    jp StoreActorMessage_Bank36

SECTION "Bank 36 ActionEffect_ActionC8", ROMX

; Action $C8: takes the target out of the battle (wBattleSlotOut $FF), clearing its slot bytes and
; blanking its picture on the far side; ends the sub-phase. (C1, E-0357)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $C8; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
ActionEffect_ActionC8::
    ld a, [wBattleTarget]
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld [hl], $ff
    call TargetOnLocalSide_Bank36
    jr c, .to_restore_target_and_end_effect
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

.to_restore_target_and_end_effect:
    jp RestoreTargetAndEndEffect

SECTION "Bank 36 ActionEffect_ActionC9", ROMX

; Action $C9: the actor comes down: clears its airborne and HighJump fields and takes a tenth of its
; HP (at least 1) as damage ('took G damage!', target message 'landed safely!'). (C2, E-0357; probed
; E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $C9, $CA; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
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
    jp StoreResolveMessage_Bank36

SECTION "Bank 36 ActionEffect_ActionBF", ROMX

; Action $BF: clears the actor's airborne and HighJump fields; with its sleep counter set it falls
; as in action $C9; otherwise '<name> landed safely!' ($AF) with no damage. (C2, E-0357; probed
; E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $BF, $CB; ids below 175 are skills named from
; StringTable_SkillNames (E-0084)
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
    jp StoreResolveMessage_Bank36

SECTION "Bank 36 ActionEffect_ActionCC", ROMX

; Action $CC (the forced HighJump landing): ActionEffect_HighJump_Land on the actor's status 4
; (clears the field, then PsycheUp's damage). (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $CC; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
ActionEffect_ActionCC::
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    jp ActionEffect_HighJump_Land

SECTION "Bank 36 ActionEffect_ActionCD", ROMX

; Action $CD: Geyser's backlash on the actor (ActionEffect_Geyser_Backfire with its status 3). (C2,
; E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $CD; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
ActionEffect_ActionCD::
    ld a, [wBattleActor]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    jp ActionEffect_Geyser_Backfire

SECTION "Bank 36 ActionEffect_ActionCE", ROMX

; Action $CE (the forced LifeSong turn): LifeSong's second path (ActionEffect_LifeSong_Revive). (C1,
; E-0357)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $CE; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
ActionEffect_ActionCE::
    jp ActionEffect_LifeSong_Revive

SECTION "Bank 36 ActionEffect_ActionCF", ROMX

; Action $CF (the forced LoveRain turn): heals when wLoveRainFlag is set
; (ActionEffect_LoveRain_HealIfFlagSet). (C2, E-0357; probed E-0382)
; effect routine reached through DispatchActionEffectTable (ActionEffectTable, indexed by
; wBattleActionId) for action(s) $CF; ids below 175 are skills named from StringTable_SkillNames
; (E-0084)
ActionEffect_ActionCF::
    jp ActionEffect_LoveRain_HealIfFlagSet

SECTION "Bank 36 StoreHitOrUnaffectedMessage", ROMX

; Stores the resolve message of a hit that can fail, keeping the damage word: actor message $35
; '<name> took G damage!', target message $B5 'But <name> was unaffected!', flags $A8, argument $80
; (StoreResolveMessage_Bank36). About twenty effect routines jump here after computing damage, among
; them ActionEffect_ActionD0 and ActionEffect_AhhhAA. (C2, E-0371; probed E-0382)
StoreHitOrUnaffectedMessage::
    lb hl, $b5, $35
    lb bc, $80, $a8
    jr StoreResolveMessage_Bank36

SECTION "Bank 36 StoreHitMessage_Bank36", ROMX

; Stores the resolve message of a plain hit: actor message $35 ('<name> took G damage!'), target
; message $D0 ('Miss! <name> was unharmed!'), message flags $A8, argument $88. It loads HL = $D035
; and BC = $88A8 and falls into StoreResolveMessage_Bank36; the damage word is not touched.
; ActionEffect_Fight, ActionEffect_ActionB9 and ActionEffect_PsycheUp end in a jump to it. (C2,
; E-0382)
; the resolve message of a hit: actor message $35 'took G damage!', target message $D0 'Miss! ...
; was unharmed!', flags $A8, argument $88; the same bytes as
; UnreferencedStoreResolveMessage35_TargetD0 in bank $3B, but here the effect routines jump to it
; (renamed from UnreferencedStoreResolveMessage35D0_Bank36, E-0365)
StoreHitMessage_Bank36::
    lb hl, $d0, $35
    lb bc, $88, $a8

; Stores the resolve message: actor L, target H, flags C, argument B. (C2, E-0357; probed E-0382)
StoreResolveMessage_Bank36::
    ld a, l
    ld [wResolveMsgActor], a
    ld a, h
    ld [wResolveMsgTarget], a
    ld a, c
    ld [wResolveMsgFlags], a
    ld a, b
    ld [wResolveMsgArg], a
    ret

SECTION "Bank 36 ClearDamageAndStoreResolveMsgFlags_Bank36", ROMX

; Sets the damage word (wBattleDamageLo, wBattleDamageHi) to 0, then stores the actor message L, the
; message flags C and the argument B in wResolveMsgActor, wResolveMsgFlags and wResolveMsgArg (it
; falls into StoreActorMessage_Bank36). The target message is left alone. Effects that only change a
; status, such as ActionEffect_DanceShut, end in a jump to it. (C2, E-0382)
; clears wBattleDamageLo/wBattleDamageHi (the damage word), then wResolveMsgActor = L,
; wResolveMsgFlags = C, wResolveMsgArg = B (E-0073)
ClearDamageAndStoreResolveMsgFlags_Bank36::
    xor a
    ld [wBattleDamageLo], a
    ld [wBattleDamageHi], a

; Stores the actor message L, flags C and argument B. (C2, E-0357; probed E-0382)
StoreActorMessage_Bank36::
    ld a, l
    ld [wResolveMsgActor], a
    ld a, c
    ld [wResolveMsgFlags], a
    ld a, b
    ld [wResolveMsgArg], a
    ret

SECTION "Bank 36 StoreNothingHappenedMessage_Bank36", ROMX

; 'But nothing happened!': target message $CC, flags $80, argument 0 (StoreTargetMessage_Bank36);
; the damage word is kept. (C2, E-0371; probed E-0382)
StoreNothingHappenedMessage_Bank36::
    ld h, $cc
    lb bc, $00, $80
    jr StoreTargetMessage_Bank36

SECTION "Bank 36 StoreUnaffectedMessage_Bank36", ROMX

; 'But <name> was unaffected!': target message $B5, flags $80, argument 0; the damage word is kept.
; (C2, E-0371; probed E-0382)
StoreUnaffectedMessage_Bank36::
    ld h, $b5
    lb bc, $00, $80

; Stores the target message H, then flags C and argument B. (C2, E-0357; probed E-0382)
StoreTargetMessage_Bank36::
    ld a, h
    ld [wResolveMsgTarget], a

; Stores the message flags C and argument B. (C2, E-0357; probed E-0382)
StoreMessageFlags_Bank36::
    ld a, c
    ld [wResolveMsgFlags], a
    ld a, b
    ld [wResolveMsgArg], a
    ret

SECTION "Bank 36 SetSubPhase2AndResetResolveStep", ROMX

; Sets wBattleSubPhase to 2 (RunBattleActions_ResolveAction) and wBattleResolveStep to 0, so the
; action is resolved again from its first step; returns with A = 0. Effect routines jump or call
; here after changing the action, for example ActionEffect_Geyser. (C2, E-0382)
; wBattleSubPhase = 2, wBattleResolveStep = 0 (E-0115)
SetSubPhase2AndResetResolveStep::
    ld a, $02
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    ret

SECTION "Bank 36 RestoreTargetAndEndEffect", ROMX

; Ends an effect routine without a result: when wOriginalTarget holds a redirected target (not $FF)
; puts it back as wBattleTarget and the actor's wBattleTargetChoice and sets wOriginalTarget to $FF;
; then during a follow-up action (wFollowUpAction non-zero) only clears the message flags and
; argument (RestoreTargetAndEndEffect_ClearMessage), otherwise sets wBattleSubPhase 3
; (RunBattleActions_AfterAction) with wBattleResolveStep 0. HL is kept. (C2, E-0371; probed E-0382)
RestoreTargetAndEndEffect::
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
    jr nz, RestoreTargetAndEndEffect_ClearMessage
    ld a, $03
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    ret

SECTION "Bank 36 SetSubPhase7AndResetResolveStep", ROMX

; Sets wBattleSubPhase to 7 (RunBattleActions_MarkActorDone) and wBattleResolveStep to 0, which ends
; the action of this actor without a result; returns with A = 0. ActionEffect_LifeSong,
; ActionEffect_LifeSong_Revive, ActionEffect_LoveRain and ActionEffect_LoveRain_HealIfFlagSet jump
; here when they have nothing more to show. (C2, E-0382)
; wBattleSubPhase = 7, wBattleResolveStep = 0 (E-0115)
SetSubPhase7AndResetResolveStep::
    ld a, $07
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    ret

SECTION "Bank 36 RestoreTargetAndEndEffect_ClearMessage", ROMX

; Clears the message flags and argument. (C2, E-0357; probed E-0382)
RestoreTargetAndEndEffect_ClearMessage::
    lb bc, $00, $00
    jp StoreMessageFlags_Bank36

SECTION "Bank 36 HalveDamageIfTargetStatus2Bit2", ROMX

; Halves the damage word (wBattleDamageLo, wBattleDamageHi) when the target (wBattleTarget) has
; BSTAT2_DAMAGE_HALVED set in its wBattleStatus2 byte: a plain logical shift right of the 16-bit
; word, rounding down. With the bit clear it returns with the damage unchanged. (C2, E-0382)
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

SECTION "Bank 36 ClearDamageAndReadTargetStatus0_Bank36", ROMX

; Sets the damage word (wBattleDamageLo, wBattleDamageHi) to 0 and returns A = the first status byte
; of the target (wBattleStatus + 9 * wBattleTarget), with HL pointing at that byte. The copy of
; ClearDamageAndReadTargetStatus0 for this bank (same 18 bytes). (C2, E-0382)
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

SECTION "Bank 36 SetSlotStatus6Bit6", ROMX

; A = battle slot: sets bit 6 (BSTAT6_STATS_RAISED) of the wBattleStatus6 byte of that slot (9 bytes
; per slot); HL is kept, A is clobbered. ActionEffect_Speed, ActionEffect_Upper and
; ActionEffect_ActionDD call it after raising a stat. (C2, E-0382)
; A = slot: sets bit 6 of its status byte 6 (wBattleStatus6 + 9 * slot); HL kept (E-0096)
SetSlotStatus6Bit6::
    push hl
    ld hl, wBattleStatus6
    call AddAx9ToHL
    set BSTAT6_STATS_RAISED, [hl]
    pop hl
    ret

SECTION "Bank 36 SetSlotStatus6Bit7", ROMX

; A = battle slot: sets bit 7 (BSTAT6_STATS_LOWERED) of the wBattleStatus6 byte of that slot (9
; bytes per slot); HL is kept, A is clobbered. LowerTargetDEF, LowerTargetAGL and
; ActionEffect_LushLicks call it after lowering a stat. (C2, E-0382)
; A = slot: sets bit 7 of its status byte 6 (wBattleStatus6 + 9 * slot); HL kept (E-0115)
SetSlotStatus6Bit7::
    push hl
    ld hl, wBattleStatus6
    call AddAx9ToHL
    set BSTAT6_STATS_LOWERED, [hl]
    pop hl
    ret

SECTION "Bank 36 TargetStatus3Address", ROMX

; HL = the address of the third status byte of the target: wBattleStatus3 + 9 * wBattleTarget (nine
; bytes per slot). A is clobbered. (C2, E-0382)
; HL = wBattleStatus3 + 9 * wBattleTarget, the target's status byte 3 (E-0096)
TargetStatus3Address::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ret

SECTION "Bank 36 ClearTargetStatus5Bits23And7Bits012", ROMX

; Clears bits 2-3 of the wBattleStatus5 byte of the target (BSTAT5_SIDE_STEP and its high bit) and
; bits 0-2 of its wBattleStatus7 byte (BSTAT7_GUARD, BSTAT7_DAMAGE_X10, BSTAT7_COUNTER); the other
; bits and the other slots stay. HL ends on the status 7 byte. (C2, E-0382)
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

SECTION "Bank 36 BringTargetBack", ROMX

; Brings the target back: marks it in, clears its nine status bytes and marks it done (3). (C2,
; E-0357; probed E-0382)
BringTargetBack::
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

SECTION "Bank 36 RemoveCFromActionQueue", ROMX

; Removes the first entry equal to C from the action queue: the first eight bytes of wActionQueue
; are searched, and every later byte moves down one place. The shift runs through the ninth byte
; (wActionQueue + 8, which RunBattleCommandEntry_ListSpeeds also fills with $FF), so that byte lands
; in the eighth place and the ninth is set to $FF. With no match nothing changes. The old comment
; and the wActionQueue note say an 8-byte queue: that is wrong by one. (C2, E-0382)
; removes the first byte equal to C from the 8-byte queue at wActionQueue, shifting later bytes down
; and filling with $FF (E-0124)
RemoveCFromActionQueue:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
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

SECTION "Bank 36 RunEffectHandlerForActionId", ROMX

; Jumps to the damage routine for the action wBattleActionId: A = 0 uses entry 0, any other id uses
; entry id - $47 (8-bit, doubled to a word offset) of EffectHandlerTable, a table of 40 words. The
; routine reached returns to the caller of this one. ComputeDamageEstimateForAction (bank $39)
; farcalls it for ACTION_FIGHT and for the ids from SKILL_WINDBEAST up except SKILL_MULTICUT,
; SKILL_EVILSLASH and SKILL_MASSACRE, so it picks the damage formula of the action. HL and A are
; clobbered. (C1, E-0382)
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

SECTION "Bank 36 EffectHandlerTable", ROMX

; RunEffectHandlerForActionId (RunEffectHandlerForActionId) indexes it with 2 * (action id - $47),
; or 0 for action 0, and jumps through JumpToWordAtHL; all 40 words point into the bank, and
; GetBattleATK follows at $7E2E (E-0126, C1)
; record: handler
EffectHandlerTable::
    dw ComputeAttackDamage ; entry 0
    dw ActionEffect_WindBeast_Damage ; entry 1
    dw ActionEffect_Vacuum_Damage ; entry 2
    dw ActionEffect_Lightning_Damage ; entry 3
    dw ActionEffect_RockThrow_Damage ; entry 4
    dw ActionEffect_Watershot_Damage ; entry 5
    dw ActionEffect_Watershot_Damage ; entry 6
    dw ActionEffect_CallHelp_Damage ; entry 7
    dw ActionEffect_CallHelp_Damage ; entry 8
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
    dw AttackDamageTimes1_5IfSlotBodyFlagsBit0 ; entry 23
    dw ComputeAttackDamage ; entry 24
    dw ComputeAttackDamage ; entry 25
    dw ComputeAttackDamage ; entry 26
    dw ActionEffect_SquallHit ; entry 27
    dw ActionEffect_BiAttack_Damage ; entry 28
    dw ActionEffect_BiAttack_Damage ; entry 29
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

; A = battle slot (0-7): HL = the 16-bit word of that slot in the wBattleATK array. It loads the
; array address and jumps to ReadBattleWordFromArray; A is clobbered. (C2, E-0382)
; A = battle slot: HL = the word for that slot in the array at wBattleATK (ReadBattleWordFromArray)
GetBattleATK::
    ld hl, wBattleATK
    jr ReadBattleWordFromArray

SECTION "Bank 36 GetBattleDEF", ROMX

; A = battle slot (0-7): HL = the 16-bit word of that slot in the wBattleDEF array. It loads the
; array address and jumps to ReadBattleWordFromArray; A is clobbered. (C2, E-0382)
; A = battle slot: HL = the word for that slot in the array at wBattleDEF (ReadBattleWordFromArray)
GetBattleDEF::
    ld hl, wBattleDEF
    jr ReadBattleWordFromArray

SECTION "Bank 36 GetBattleMaxHP", ROMX

; A = battle slot (0-7): HL = the 16-bit word of that slot in the wBattleMaxHP array. It loads the
; array address and jumps to ReadBattleWordFromArray; A is clobbered. (C2, E-0382)
; A = battle slot: HL = the word for that slot in the array at wBattleMaxHP
; (ReadBattleWordFromArray)
GetBattleMaxHP::
    ld hl, wBattleMaxHP
    jr ReadBattleWordFromArray

SECTION "Bank 36 GetBattleMaxMP", ROMX

; A = battle slot (0-7): HL = the 16-bit word of that slot in the wBattleMaxMP array. It loads the
; array address and jumps to ReadBattleWordFromArray; A is clobbered. (C2, E-0382)
; A = battle slot: HL = the word for that slot in the array at wBattleMaxMP
; (ReadBattleWordFromArray)
GetBattleMaxMP::
    ld hl, wBattleMaxMP
    jr ReadBattleWordFromArray

SECTION "Bank 36 GetBattleHP", ROMX

; A = battle slot (0-7): HL = the 16-bit word of that slot in the wBattleHP array. It loads the
; array address and jumps to ReadBattleWordFromArray; A is clobbered. (C2, E-0382)
; A = battle slot: HL = the word for that slot in the array at wBattleHP (ReadBattleWordFromArray)
GetBattleHP::
    ld hl, wBattleHP
    jr ReadBattleWordFromArray

SECTION "Bank 36 GetBattleMP", ROMX

; A = battle slot (0-7): HL = the 16-bit word of that slot in the wBattleMP array. It loads the
; array address and jumps to ReadBattleWordFromArray; A is clobbered. (C2, E-0382)
; A = battle slot: HL = the word for that slot in the array at wBattleMP (ReadBattleWordFromArray)
GetBattleMP::
    ld hl, wBattleMP
    jr ReadBattleWordFromArray

SECTION "Bank 36 GetBattleAGL_Bank36", ROMX

; HL = wBattleAGL, then ReadBattleWordFromArray: HL = the word at wBattleAGL + 2 x A (A = the battle
; slot). One of this bank's GetBattle* stat getters. No traced code, jump table or pointer reaches
; it (E-0395: it decodes as a routine but is unreached in the static listing). (C2, E-0395; probed
; E-0395)
; the same 25 bytes as GetBattleAGL_Bank39 (GetBattleAGL_Bank39) (E-0060)
GetBattleAGL_Bank36:: ; configured code entry (E-0395); C0
    ld hl, wBattleAGL
    jr ReadBattleWordFromArray

SECTION "Bank 36 ReadSlotAIModeIndexed_Bank36", ROMX

; A = the byte at wSlotAIMode + A, the AI mode of slot A. A copy of the routine of the same shape
; found in other banks. No traced code, jump table or pointer reaches it (E-0395: it decodes as a
; routine but is unreached in the static listing). (C2, E-0395; probed E-0395)
; A = the byte at wSlotAIMode + A; clobbers HL (the same 10 bytes appear in 13 banks)
ReadSlotAIModeIndexed_Bank36::
    ld hl, wSlotAIMode
    add_a_to_hl
    ld a, [hl]
    ret

SECTION "Bank 36 ReadBattleWordFromArray", ROMX

; HL = the address of a table of 16-bit words, A = index: returns HL = the word at HL + 2 * A
; (little-endian). A is doubled in 8 bits first, so an index of $80 or more wraps. A is clobbered.
; GetBattleATK, GetBattleDEF, GetBattleMaxHP, GetBattleMaxMP, GetBattleHP and GetBattleMP use it for
; the per-slot battle arrays. (C2, E-0382)
; HL = array base, A = slot: HL = the 16-bit word at HL + 2 * A
ReadBattleWordFromArray::
    add a
    add_a_to_hl
    deref_hl
    ret

SECTION "Bank 36 AddDoubleAToHL_Bank36", ROMX

; HL = HL + 2 * A. A is doubled in 8 bits first, so a value of $80 or more wraps (A = $90 adds $20).
; The carry out of L goes into H. A is clobbered. A copy of the same 7 bytes is in 12 banks. (C2,
; E-0382)
; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes
; appear in 12 banks)
AddDoubleAToHL_Bank36::
    add a
    add_a_to_hl
    ret

SECTION "Bank 36 ActorOnLocalSide_Bank36", ROMX

; Carry set when the actor (wBattleActor) is one of the slots 0-3, carry clear for 4-7. When
; wLinkMode is 1 and bit 1 of wLinkRole is set the answer is reversed (carry set for 4-7). Which
; side is the local one is inferred from that reversal only. A is clobbered. A copy of the same 27
; bytes is in 12 banks. (C2, E-0382)
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

SECTION "Bank 36 TargetOnLocalSide_Bank36", ROMX

; Carry set when the target (wBattleTarget) is one of the slots 0-3, carry clear for 4-7. When
; wLinkMode is 1 and bit 1 of wLinkRole is set the answer is reversed (carry set for 4-7). A is
; clobbered. A copy of the same 27 bytes is in 12 banks. (C2, E-0382)
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

SECTION "Bank 36 ClearBattleStatusBitsWithMaskD_Bank36", ROMX

; ANDs status byte 0 of slot E with entry D of ClearBattleStatusBitsWithMaskD_Bank36_Data. (C2,
; E-0357; probed E-0382)
ClearBattleStatusBitsWithMaskD_Bank36:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
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

SECTION "Bank 36 ClearBattleStatusBitsWithMaskD_Bank36_Data", ROMX

; Seven AND masks for the first status byte of a battler (BSTAT0_*): $DF clears bit 5
; (BSTAT0_CURSED), $FE bit 0 (BSTAT0_POISONED), $00 all bits, $FD bit 1 (BSTAT0_BADLY_POISONED), $73
; bits 2, 3 and 7 (the sleep counter and BSTAT0_ASLEEP), $EF bit 4 (BSTAT0_CONFUSED) and $BF bit 6
; (BSTAT0_PARALYZED). ClearBattleStatusBitsWithMaskD_Bank36 indexes it by D (0 to 6) and ANDs the
; mask into the wBattleStatus byte of slot E (9 bytes per slot). The same 7 bytes are in several
; battle banks. (C1, E-0381)
ClearBattleStatusBitsWithMaskD_Bank36_Data::
    db $df, $fe, $00, $fd, $73, $ef, $bf

; A = index: sets bit 0 of the byte at wLevelUpGains + A; HL is kept and A is clobbered. A copy of
; the same 13 bytes is in 12 banks. (C2, E-0382)
; Sets bit 0 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit0OfLevelUpGainsIndexed_Bank36::
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

SECTION "Bank 36 SetBit1OfLevelUpGainsIndexed_Bank36", ROMX

; A = index: sets bit 1 of the byte at wLevelUpGains + A; HL is kept and A is clobbered. A copy of
; the same 13 bytes is in 12 banks. (C2, E-0382)
; Sets bit 1 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit1OfLevelUpGainsIndexed_Bank36::
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

SECTION "Bank 36 SetBit2OfLevelUpGainsIndexed_Bank36", ROMX

; A = index: sets bit 2 of the byte at wLevelUpGains + A; HL is kept and A is clobbered. A copy of
; the same 13 bytes is in 12 banks. (C2, E-0382)
; Sets bit 2 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit2OfLevelUpGainsIndexed_Bank36:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 2, [hl]
    pop hl
    ret

SECTION "Bank 36 PersonalityIndexOfSlot_Bank36", ROMX

; A = slot (0-7): returns A = 9 * g(wSlotPersonalityHi[A]) + 3 * g(wSlotPersonalityMid[A]) +
; g(wSlotPersonalityLo[A]), where g(v) is 0 for v of $C0 or more, 1 for $40 to $BF and 2 below $40;
; so each of the three bytes counts as one of three bands and the result is a number 0-26, one per
; combination. HL and BC are kept. It is the same index that PersonalityIndexOfRecord builds from a
; save record. A copy of the same 87 bytes is in 13 banks. (C2, E-0382)
; A = slot 0-7: returns A = 9 * g(wSlotPersonalityHi[A]) + 3 * g(wSlotPersonalityMid[A]) +
; g(wSlotPersonalityLo[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index
; PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes
; appear in 13 banks)
PersonalityIndexOfSlot_Bank36:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
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

SECTION "Bank 36 CheckSlotStatusBlockWide_Bank36", ROMX

; A = slot: carry set when CheckSlotStatusBlock sets it (slot absent, or status 0 & $D0, status 3 &
; $3F, status 5 & $C0 or status 8 bit 3), or else when the status 3 byte has bit 6 or 7 set or the
; status 4 byte has bit 2 or 3 set (wBattleStatus3 and wBattleStatus4 at 9 bytes per slot).
; Otherwise carry clear. A, BC and HL are kept. A copy of the same 31 bytes is in 12 banks. (C2,
; E-0382)
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

SECTION "Bank 36 SlotHasStatus3Or4Bits_Bank36", ROMX

; A = slot: with the third and fourth status bytes of the slot (wBattleStatus3, wBattleStatus4; 9
; bytes per slot), returns A = status 3 & $C0 (BSTAT3_AIRBORNE and BSTAT3_AIRBORNE_HI) when that is
; not zero, else A = status 4 & $0C (BSTAT4_HIGH_JUMP and BSTAT4_HIGH_JUMP_HI); Z is set when both
; are clear. HL is kept. A copy of the same 17 bytes is in 13 banks. (C2, E-0382)
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
