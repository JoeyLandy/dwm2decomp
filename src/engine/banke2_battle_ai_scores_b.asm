; ROM bank $E2: battle AI: the second set of scoring routines
; The annotated listing of this bank is build/listing/banke2.asm.

SECTION "Bank E2", ROMX
    db $e2

; Fight's AI score: needs AIScore_Fight_Conditions; then weight row $00 to wAISkillScore when
; AnyFoeHasDEFAtLeast2 gives 0; weight row $01 to wAISkillScore when AtLeastTwoFoesPresent gives 0;
; weight row $02 to wAISkillScore when CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row
; $03 to wAISkillScore2 when CheckFoeStatus7Bit2 gives 0; weight row $05 to wAISkillScore when
; ActorLacksStatus1Bits23And4Bits01 gives 0; always weight row $06 to wAISkillScore; weight row $66
; to wAISkillScore when CheckBattleKindAtLeast2OrLinkModeSet gives 0; weight row $67 to
; wAISkillScore when FoeHPCheckReadsWrongSlot gives 0; weight row $68 to wAISkillScore when
; CheckActorSlot0To3OrLinkModeSet gives 0; weight row $05 to wAISkillScore when
; ActorStatus4CheckReadsAddress gives 0; weight row $33 to wAISkillScore2 when
; ActorLacksStatus2Bit1And5Bits01 gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 0 (no name). It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083) (E-0332: skill 0 is Fight, the plain attack: with Guard (skill $AC) it is scored on every
; monster's turn whether or not any record holds it, as the Command menu offers Fight / Skill /
; Guard; C2) (was AIScore_Fight)
AIScore_Fight:: ; configured code entry (E-0395 (AIScore_Fight: found only by the $4001 fall-through guess, which a new entry later in the bank can change; listed so it stays traced)); C0
    farcall AIScore_Fight_Conditions
    ld a, c
    and a
    ret z
    farcall AnyFoeHasDEFAtLeast2
    ld a, c
    and a
    jr nz, .call_at_least_two_foes_present
    ld bc, $0000
    call AddAIWeight

.call_at_least_two_foes_present:
    farcall AtLeastTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_check_lone_foe_hp_not_below_ai_damage
    ld bc, $0001
    call AddAIWeight

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_check_foe_status7_bit2
    ld bc, $0002
    call AddAIWeight

.call_check_foe_status7_bit2:
    farcall CheckFoeStatus7Bit2
    ld a, c
    cp $01
    jr z, .call_actor_lacks_status1_bits23_and4_bits01
    and a
    jr nz, .call_actor_lacks_status1_bits23_and4_bits01
    ld bc, $0003
    call AddAIWeightToScore2

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0005
    call AddAIWeight

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_check_battle_kind_at_least2_or_link_mode
    ld bc, $0006
    call AddAIWeight

.call_check_battle_kind_at_least2_or_link_mode:
    farcall CheckBattleKindAtLeast2OrLinkModeSet
    ld a, c
    and a
    jr nz, .call_foe_hp_check_reads_wrong_slot
    ld bc, $0066
    call AddAIWeight

.call_foe_hp_check_reads_wrong_slot:
    farcall FoeHPCheckReadsWrongSlot
    ld a, c
    and a
    jr nz, .call_check_actor_slot0_to3_or_link_mode_set
    ld bc, $0067
    call AddAIWeight

.call_check_actor_slot0_to3_or_link_mode_set:
    farcall CheckActorSlot0To3OrLinkModeSet
    ld a, c
    and a
    jr nz, .call_actor_status4_check_reads_address
    ld bc, $0068
    call AddAIWeight

.call_actor_status4_check_reads_address:
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a
    jr nz, .call_actor_lacks_status2_bit1_and5_bits01
    ld bc, $0005
    call AddAIWeight

.call_actor_lacks_status2_bit1_and5_bits01:
    farcall ActorLacksStatus2Bit1And5Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_Blaze", ROMX

; Blaze's AI score: needs AIFireSkillUsable; then weight row $08 to wAISkillScore2 when
; FailIfFoeAIDamageEstimatesAtLeastEstimate gives 0; weight row $09 to wAISkillScore when
; PassIfFoesAverageResistanceAtLeast2 gives 0; always weight row $0B to wAISkillScore; weight row
; $0C to wAISkillScore when PassIfFoeAIDamageEstimatesAtLeastEstimate gives 0;
; WeighLinkRuleBit6AndTurnLimit; weight row $10 to wAISkillScore2 when FewerThanTwoFoesPresent gives
; 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 3 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 1 Blaze, 2 Blazemore, 3 Blazemost. It runs checks
; and adds weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_Blaze:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIFireSkillUsable
    ld a, c
    and a
    ret z
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $0008
    call AddAIWeightToScore2

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0009
    call AddAIWeight

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_pass_if_foe_ai_damage_estimates_at_least
    ld bc, $000b
    call AddAIWeight

.call_pass_if_foe_ai_damage_estimates_at_least:
    farcall PassIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_weigh_link_rule_bit6_and_turn_limit
    ld bc, $000c
    call AddAIWeight

.call_weigh_link_rule_bit6_and_turn_limit:
    call WeighLinkRuleBit6AndTurnLimit
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .return
    ld bc, $0010
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_Firebal", ROMX

; Firebal's AI score: needs AIFireSkillUsable; then weight row $04 to wAISkillScore2 when
; AIGateFoeStatus2Mask22 gives 0; weight row $0A to wAISkillScore2 when
; FailIfFoeAIDamageEstimatesAtLeastEstimate gives 0; weight row $09 to wAISkillScore when
; PassIfFoesAverageResistanceAtLeast2 gives 0; always weight row $0B to wAISkillScore; weight row
; $0D to wAISkillScore when PassIfFoeAIDamageEstimatesAtLeastEstimate gives 0;
; WeighLinkRuleBit6AndTurnLimit; weight row $14 to wAISkillScore when
; AllySlotsCheckThenFewerThanTwoFoes gives 0; weight row $15 to wAISkillScore when
; FewerThanTwoFoesPresent gives 0; weight row $4A to wAISkillScore2 when CheckFoeStatus6Bit3 gives
; 0; weight row $12 to wAISkillScore2 when FailIfSkillHasResistanceClass gives 0. (C2, E-0357;
; probed E-0385)
; AI scoring routine for 15 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 4 Firebal, 5 Firebane, 6 Firebolt, 7 Bang, 8 Boom,
; 9 Explodet, 10 Infernos, 11 Infermore, 12 Infermost, 13 Bolt .... It runs checks and adds weights
; to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_Firebal:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIFireSkillUsable
    ld a, c
    and a
    ret z
    farcall AIGateFoeStatus2Mask22
    ld a, c
    cp $01
    jr z, .call_fail_if_foe_ai_damage_estimates_at_least
    and a
    jr nz, .call_fail_if_foe_ai_damage_estimates_at_least
    ld bc, $0004
    call AddAIWeightToScore2

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $000a
    call AddAIWeightToScore2

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0009
    call AddAIWeight

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_pass_if_foe_ai_damage_estimates_at_least
    ld bc, $000b
    call AddAIWeight

.call_pass_if_foe_ai_damage_estimates_at_least:
    farcall PassIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_weigh_link_rule_bit6_and_turn_limit
    ld bc, $000d
    call AddAIWeight

.call_weigh_link_rule_bit6_and_turn_limit:
    call WeighLinkRuleBit6AndTurnLimit
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a
    jr nz, .call_fewer_than_two_foes_present
    ld bc, $0014
    call AddAIWeight

.call_fewer_than_two_foes_present:
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0015
    call AddAIWeight

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp $01
    jr z, .call_fail_if_skill_has_resistance_class
    and a
    jr nz, .call_fail_if_skill_has_resistance_class
    ld bc, $004a
    call AddAIWeightToScore2

.call_fail_if_skill_has_resistance_class:
    farcall FailIfSkillHasResistanceClass
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0012
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_Beat_UnreferencedVariant", ROMX

; Not used by the game: AIScoreRoutineTableA and AIScoreRoutineTableB hold the same 201 entries,
; none points here, and nothing in src calls it. It calls AIScore_Beat and returns if that gives C =
; 0 (the conditions of 'Beat' failed). Otherwise it farcalls AIGateFoeSlotResistances2Bits45 and,
; when that gives 0, adds weight row $B5 to wAISkillScore, the same row AIScore_Beat adds under the
; same check, so the row would count twice. (C2, E-0385)
; table-B AI score: AIScore_Beat, then adds a penalty word when the follow-up check fails (E-0122)
AIScore_Beat_UnreferencedVariant:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    call AIScore_Beat
    ld a, c
    and a
    ret z
    farcall AIGateFoeSlotResistances2Bits45
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $00b5
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_Beat", ROMX

; Beat's AI score: needs AIScore_Beat_Conditions; then weight row $04 to wAISkillScore2 when
; AIGateFoeStatus2Mask22 gives 0; always weight row $CD to wAISkillScore and weight row $CF to
; wAISkillScore2; WeighLinkRuleBit6AndTurnLimit; weight row $15 to wAISkillScore when
; FewerThanTwoFoesPresent gives 0; weight row $B5 to wAISkillScore when
; AIGateFoeSlotResistances2Bits45 gives 0; weight row $12 to wAISkillScore2 when
; FailIfSkillHasResistanceClass gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForAISide gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForFoeAIMode3 gives 0; returns C = 1. (C2, E-0357; probed E-0385)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 19 Beat, 20 Defeat. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_Beat::
    farcall AIScore_Beat_Conditions
    ld a, c
    and a
    ret z
    farcall AIGateFoeStatus2Mask22
    ld a, c
    cp $01
    jr z, .call_set_c_to_zero
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0004
    call AddAIWeightToScore2

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rule_bit6_and_turn_limit
    ld bc, $00cd
    call AddAIWeight
    ld bc, $00cf
    call AddAIWeightToScore2

.call_weigh_link_rule_bit6_and_turn_limit:
    call WeighLinkRuleBit6AndTurnLimit
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_ai_gate_foe_slot_resistances2_bits45
    ld bc, $0015
    call AddAIWeight

.call_ai_gate_foe_slot_resistances2_bits45:
    farcall AIGateFoeSlotResistances2Bits45
    ld a, c
    cp $01
    jr z, .call_fail_if_skill_has_resistance_class
    and a
    jr nz, .call_fail_if_skill_has_resistance_class
    ld bc, $00b5
    call AddAIWeight

.call_fail_if_skill_has_resistance_class:
    farcall FailIfSkillHasResistanceClass
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AddAIWeightToScore2

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AddAIWeight

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .done
    and a
    jr nz, .done
    ld bc, $0009
    call AddAIWeight

.done:
    ld c, $01
    ret

SECTION "Bank E2 AIScore_Sacrifice", ROMX

; Sacrifice's AI score: needs AIScore_Sacrifice_Conditions; then weight row $17 to wAISkillScore2
; when ActorLacksStatus4Bits67 gives 0; weight row $17 to wAISkillScore2 when
; AllOtherAlliesHaveStatus0Bit6 gives 0; weight row $11 to wAISkillScore2 when AtLeastTwoFoesPresent
; gives 0; weight row $1B to wAISkillScore2 when AnyAllyHPAtMostThreeQuarters gives 0; weight row
; $07 to wAISkillScore2 when CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; always weight row $CD
; to wAISkillScore and weight row $CF to wAISkillScore2; AIScore_Sacrifice_WeighLinkRule; weight row
; $19 to wAISkillScore when AIScore_Sacrifice_LowHPAndFoesVulnerable gives 0; weight row $12 to
; wAISkillScore2 when FailIfSkillHasResistanceClass gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 21 Sacrifice. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Sacrifice:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_Sacrifice_Conditions
    ld a, c
    and a
    ret z
    farcall ActorLacksStatus4Bits67
    ld a, c
    and a
    jr nz, .call_all_other_allies_have_status0_bit6
    ld bc, $0017
    call AddAIWeightToScore2

.call_all_other_allies_have_status0_bit6:
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a
    jr nz, .call_at_least_two_foes_present
    ld bc, $0017
    call AddAIWeightToScore2

.call_at_least_two_foes_present:
    farcall AtLeastTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_any_ally_hp_at_most_three_quarters
    ld bc, $0011
    call AddAIWeightToScore2

.call_any_ally_hp_at_most_three_quarters:
    farcall AnyAllyHPAtMostThreeQuarters
    ld a, c
    and a
    jr nz, .call_check_lone_foe_hp_not_below_ai_damage
    ld bc, $001b
    call AddAIWeightToScore2

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0007
    call AddAIWeightToScore2

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_ai_score_sacrifice_weigh_link_rule
    ld bc, $00cd
    call AddAIWeight
    ld bc, $00cf
    call AddAIWeightToScore2

.call_ai_score_sacrifice_weigh_link_rule:
    call AIScore_Sacrifice_WeighLinkRule
    farcall AIScore_Sacrifice_LowHPAndFoesVulnerable
    ld a, c
    and a
    jr nz, .call_fail_if_skill_has_resistance_class
    ld bc, $0019
    call AddAIWeight

.call_fail_if_skill_has_resistance_class:
    farcall FailIfSkillHasResistanceClass
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0012
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_Heal", ROMX

; AI score of the 'Heal' skills (entries 22-24 of both tables). Returns at once unless AIHealUsable
; gives non-zero. Adds row $69 to wAISkillScore2 when FailIfTwoAlliesBelowHalfHP gives 0, then in
; every case goes on at AIScore_HealUs_StatusAndHPWeights (a jump when the check gives non-zero,
; otherwise a fall-through). (C2, E-0385)
; AI scoring routine for 3 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 22 Heal, 23 HealMore, 24 HealAll. It runs checks
; and adds weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_Heal:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIHealUsable
    ld a, c
    and a
    ret z
    farcall FailIfTwoAlliesBelowHalfHP
    ld a, c
    cp $01
    jr z, AIScore_HealUs_StatusAndHPWeights
    and a
    jr nz, AIScore_HealUs_StatusAndHPWeights
    ld bc, $0069
    call AddAIWeightToScore2

; Second half of the 'Heal' and 'HealUs' scores (AIScore_Heal continues into it, AIScore_HealUs
; calls it), ending in ret. Adds row $1A to wAISkillScore when AnyFoeLacksStatus0MaskCC gives 0 and
; row $1A again when AnyFoeHasClearStatus3 gives 0, row $1B to wAISkillScore2 when
; AnyAllyHPAtMostThreeQuarters gives 0, runs AIScore_HealUs_ScoreHPBands with A = wBattleActor, adds
; row $23 when ActorHPIsNotOne gives 0, always adds rows $24 and $C8, and calls
; WeighLinkRules1RuleBit4. (C2, E-0385)
AIScore_HealUs_StatusAndHPWeights::
    farcall AnyFoeLacksStatus0MaskCC
    ld a, c
    and a
    jr nz, .call_any_foe_has_clear_status3
    ld bc, $001a
    call AddAIWeight

.call_any_foe_has_clear_status3:
    farcall AnyFoeHasClearStatus3
    ld a, c
    and a
    jr nz, .call_any_ally_hp_at_most_three_quarters
    ld bc, $001a
    call AddAIWeight

.call_any_ally_hp_at_most_three_quarters:
    farcall AnyAllyHPAtMostThreeQuarters
    ld a, c
    and a
    jr nz, .read_battle_actor
    ld bc, $001b
    call AddAIWeightToScore2

.read_battle_actor:
    ld a, [wBattleActor]
    call AIScore_HealUs_ScoreHPBands
    farcall ActorHPIsNotOne
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0023
    call AddAIWeight

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit4
    ld bc, $0024
    call AddAIWeight
    ld bc, $00c8
    call AddAIWeight

.call_weigh_link_rules1_rule_bit4:
    call WeighLinkRules1RuleBit4
    ret

SECTION "Bank E2 AIScore_HealUs", ROMX

; HealUs' AI score: needs AIHealUsable; then AIScore_HealUs_StatusAndHPWeights; weight row $23 to
; wAISkillScore when FewerThanTwoAlliesAtHP1 gives 0; weight row $69 to wAISkillScore when
; FailIfTwoAlliesBelowHalfHP gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 25 HealUs, 26 HealUsAll. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_HealUs:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIHealUsable
    ld a, c
    and a
    ret z
    call AIScore_HealUs_StatusAndHPWeights
    farcall FewerThanTwoAlliesAtHP1
    ld a, c
    and a
    jr nz, .call_fail_if_two_allies_below_half_hp
    ld bc, $0023
    call AddAIWeight

.call_fail_if_two_allies_below_half_hp:
    farcall FailIfTwoAlliesBelowHalfHP
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0069
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_MPass", ROMX

; MPass' AI score: needs AIScore_MPass_Conditions and adds nothing. (C2, E-0357; probed E-0385)
; AI scoring routine for 3 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 27 MPass, 28 MPassmore, 29 MPassmost. It runs
; checks and adds weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_MPass:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_MPass_Conditions
    ld a, c
    and a
    ret z
    ret

SECTION "Bank E2 AIScore_Vivify", ROMX

; Vivify's AI score: needs AIScore_Vivify_Conditions; then WeighActorAloneOnSide; weight row $2E to
; wAISkillScore2 when AIGateCompareAllyStatAverages gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 30 Vivify, 31 Revive. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_Vivify:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_Vivify_Conditions
    ld a, c
    and a
    ret z
    call WeighActorAloneOnSide
    farcall AIGateCompareAllyStatAverages
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $002e
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_Farewell", ROMX

; Farewell's AI score: needs AIScore_Farewell_Conditions; then WeighActorAloneOnSide; always weight
; row $BC to wAISkillScore and weight row $C4 to wAISkillScore2; weight row $2E to wAISkillScore2
; when AIGateCompareAllyStatAverages gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 32 Farewell. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Farewell:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_Farewell_Conditions
    ld a, c
    and a
    ret z
    call WeighActorAloneOnSide
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_ai_gate_compare_ally_stat_averages
    ld bc, $00bc
    call AddAIWeight
    ld bc, $00c4
    call AddAIWeightToScore2

.call_ai_gate_compare_ally_stat_averages:
    farcall AIGateCompareAllyStatAverages
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $002e
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_Antidote", ROMX

; Antidote's AI score: needs AIScore_Antidote_Conditions; then always weight row $2A to
; wAISkillScore; WeighLinkRules1RuleBit4. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 33 Antidote. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Antidote:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_Antidote_Conditions
    ld a, c
    and a
    ret z
    ld bc, $002a
    call AddAIWeight
    call WeighLinkRules1RuleBit4
    ret

SECTION "Bank E2 AIScore_DeChaos", ROMX

; DeChaos' AI score: needs AIScore_DeChaos_Conditions; then always weight row $2A to wAISkillScore;
; WeighLinkRules1RuleBit4. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 34 DeChaos. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_DeChaos:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_DeChaos_Conditions
    ld a, c
    and a
    ret z
    ld bc, $002a
    call AddAIWeight
    call WeighLinkRules1RuleBit4
    ret

SECTION "Bank E2 AIScore_NumbOff", ROMX

; NumbOff's AI score: needs AIScore_NumbOff_Conditions; then always weight row $2A to wAISkillScore;
; WeighLinkRules1RuleBit4. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 35 NumbOff. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_NumbOff:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_NumbOff_Conditions
    ld a, c
    and a
    ret z
    ld bc, $002a
    call AddAIWeight
    call WeighLinkRules1RuleBit4
    ret

SECTION "Bank E2 AIScore_CurseOff", ROMX

; CurseOff's AI score: needs AIScore_CurseOff_Conditions; then always weight row $2A to
; wAISkillScore; WeighLinkRules1RuleBit4. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 36 CurseOff. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_CurseOff:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_CurseOff_Conditions
    ld a, c
    and a
    ret z
    ld bc, $002a
    call AddAIWeight
    call WeighLinkRules1RuleBit4
    ret

SECTION "Bank E2 AIScore_Upper", ROMX

; Upper's AI score: needs AIScore_Upper_Conditions; then weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; WeighLinkRules1RuleBit5;
; AIScore_Upper_WeighFoeATKVsAllyDEF; always weight row $C1 to wAISkillScore2. (C2, E-0357; probed
; E-0385)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 37 Upper, 38 Increase. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_Upper:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_Upper_Conditions
    ld a, c
    and a
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $0007
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    call AIScore_Upper_WeighFoeATKVsAllyDEF
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .return
    ld bc, $00c1
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_Sap", ROMX

; Sap's AI score: needs AIScore_Sap_Conditions; then weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row $2C to wAISkillScore when
; PassIfFoeAverageDEFAtMostTwiceAllyATK gives 0; weight row $2C to wAISkillScore when
; PassIfTwiceATKAboveHighestFoeDEF gives 0; always weight row $CC to wAISkillScore and weight row
; $D1 to wAISkillScore2; WeighLinkRules1RuleBit5; weight row $12 to wAISkillScore2 when
; FailIfSkillHasResistanceClass gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForAISide gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForFoeAIMode3 gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 39 Sap, 40 Defense. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_Sap:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_Sap_Conditions
    ld a, c
    and a
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_pass_if_foe_average_def_at_most_twice
    ld bc, $0007
    call AddAIWeightToScore2

.call_pass_if_foe_average_def_at_most_twice:
    farcall PassIfFoeAverageDEFAtMostTwiceAllyATK
    ld a, c
    cp $01
    jr z, .call_pass_if_twice_atk_above_highest_foe_def
    and a
    jr nz, .call_pass_if_twice_atk_above_highest_foe_def
    ld bc, $002c
    call AddAIWeight

.call_pass_if_twice_atk_above_highest_foe_def:
    farcall PassIfTwiceATKAboveHighestFoeDEF
    ld a, c
    cp $01
    jr z, .call_set_c_to_zero
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $002c
    call AddAIWeight

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $00cc
    call AddAIWeight
    ld bc, $00d1
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    farcall FailIfSkillHasResistanceClass
    ld a, c
    cp $01
    jr z, .call_ai_score_sap_weigh_atk_vs_def
    and a
    jr nz, .call_ai_score_sap_weigh_atk_vs_def
    ld bc, $0012
    call AddAIWeightToScore2

.call_ai_score_sap_weigh_atk_vs_def:
    call AIScore_Sap_WeighATKVsDEF
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AddAIWeight

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0009
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_Speed", ROMX

; Speed's AI score: needs AIScore_Speed_Conditions; then weight row $2D to wAISkillScore2 when
; FastestFoeAGLAbove31PercentOfActor gives 0; weight row $2C to wAISkillScore when
; AllyAverageAGLAtLeastFoes gives 0; WeighLinkRules1RuleBit5. (C2, E-0357; probed E-0385)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 41 Speed, 42 SpeedUp. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_Speed:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_Speed_Conditions
    ld a, c
    and a
    ret z
    farcall FastestFoeAGLAbove31PercentOfActor
    ld a, c
    and a
    jr nz, .call_ally_average_agl_at_least_foes
    ld bc, $002d
    call AddAIWeightToScore2

.call_ally_average_agl_at_least_foes:
    farcall AllyAverageAGLAtLeastFoes
    ld a, c
    cp $01
    jr z, .call_weigh_link_rules1_rule_bit5
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $002c
    call AddAIWeight

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    ret

SECTION "Bank E2 AIScore_Slow", ROMX

; Slow's AI score: needs AIScore_Slow_Conditions; then weight row $04 to wAISkillScore2 when
; AIGateFoeStatus2Mask22 gives 0; weight row $2D to wAISkillScore2 when
; FastestFoeAGLAbove31PercentOfActor gives 0; weight row $2C to wAISkillScore when
; AllyAverageAGLAtLeastFoes gives 0; always weight row $CC to wAISkillScore and weight row $D1 to
; wAISkillScore2; WeighLinkRules1RuleBit5; weight row $12 to wAISkillScore2 when
; FailIfSkillHasResistanceClass gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForAISide gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForFoeAIMode3 gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 43 Slow, 44 SlowAll. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_Slow:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_Slow_Conditions
    ld a, c
    and a
    ret z
    farcall AIGateFoeStatus2Mask22
    ld a, c
    cp $01
    jr z, .call_fastest_foe_agl_above31_percent_of_actor
    and a
    jr nz, .call_fastest_foe_agl_above31_percent_of_actor
    ld bc, $0004
    call AddAIWeightToScore2

.call_fastest_foe_agl_above31_percent_of_actor:
    farcall FastestFoeAGLAbove31PercentOfActor
    ld a, c
    and a
    jr nz, .call_ally_average_agl_at_least_foes
    ld bc, $002d
    call AddAIWeightToScore2

.call_ally_average_agl_at_least_foes:
    farcall AllyAverageAGLAtLeastFoes
    ld a, c
    cp $01
    jr z, .call_set_c_to_zero
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $002c
    call AddAIWeight

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $00cc
    call AddAIWeight
    ld bc, $00d1
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    farcall FailIfSkillHasResistanceClass
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AddAIWeightToScore2

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AddAIWeight

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0009
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_TwinHits_UnreferencedVariant", ROMX

; Not used by the game: AIScoreRoutineTableA and AIScoreRoutineTableB hold the same 201 entries,
; none points here, and nothing in src calls it. It calls AIScore_TwinHits and returns if that gives
; C = 0 (the conditions of 'TwinHits' failed). Otherwise it farcalls FailIfAllyCanUseSkill63Or64
; and, when that gives 0, adds weight row $B3 to wAISkillScore, the same row AIScore_TwinHits adds
; under the same check, so the row would count twice. (C2, E-0385)
; table-B AI score: AIScore_TwinHits, then adds a penalty word when the follow-up check fails
; (E-0122)
AIScore_TwinHits_UnreferencedVariant:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    call AIScore_TwinHits
    ld a, c
    and a
    ret z
    farcall FailIfAllyCanUseSkill63Or64
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $00b3
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_TwinHits", ROMX

; AI score of 'TwinHits' (skill 45, entry of both tables). Returns C = 0 at once unless
; AIScore_TwinHits_Conditions gives non-zero. Then adds row $2F to wAISkillScore when
; AIScore_TwinHits_CompareATKWithFoeDEF gives 0 and row $30 when AIScore_TwinHits_CheckAllyATK gives
; 0, always adds row $BA, calls WeighLinkRules1RuleBit5, and adds row $B3 when
; FailIfAllyCanUseSkill63Or64 gives 0. Returns C = 1 after a full run. (C2, E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 45 TwinHits. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_TwinHits::
    farcall AIScore_TwinHits_Conditions
    ld a, c
    and a
    ret z
    farcall AIScore_TwinHits_CompareATKWithFoeDEF
    ld a, c
    cp $01
    jr z, .call_ai_score_twin_hits_check_ally_atk
    and a
    jr nz, .call_ai_score_twin_hits_check_ally_atk
    ld bc, $002f
    call AddAIWeight

.call_ai_score_twin_hits_check_ally_atk:
    farcall AIScore_TwinHits_CheckAllyATK
    ld a, c
    cp $01
    jr z, .call_set_c_to_zero
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0030
    call AddAIWeight

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $00ba
    call AddAIWeight

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    farcall FailIfAllyCanUseSkill63Or64
    ld a, c
    cp $01
    jr z, .done
    and a
    jr nz, .done
    ld bc, $00b3
    call AddAIWeight

.done:
    ld c, $01
    ret

SECTION "Bank E2 AIScore_Surround", ROMX

; Surround's AI score: needs AIScore_Surround_Conditions; then weight row $04 to wAISkillScore2 when
; AIGateFoeStatus2Mask22 gives 0; weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row $31 to wAISkillScore when
; PassIfFoeAverageATKAtMostTwiceAllyDEF gives 0; always weight row $BA to wAISkillScore2 and weight
; row $CC to wAISkillScore and weight row $D1 to wAISkillScore2; WeighLinkRules1RuleBit5; weight row
; $32 to wAISkillScore when CompareFoeAverageATKWithAllyDEF gives 0; weight row $12 to
; wAISkillScore2 when FailIfSkillHasResistanceClass gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForAISide gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForFoeAIMode3 gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 46 Surround. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Surround:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_Surround_Conditions
    ld a, c
    and a
    ret z
    farcall AIGateFoeStatus2Mask22
    ld a, c
    cp $01
    jr z, .call_check_lone_foe_hp_not_below_ai_damage
    and a
    jr nz, .call_check_lone_foe_hp_not_below_ai_damage
    ld bc, $0004
    call AddAIWeightToScore2

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_pass_if_foe_average_atk_at_most_twice
    ld bc, $0007
    call AddAIWeightToScore2

.call_pass_if_foe_average_atk_at_most_twice:
    farcall PassIfFoeAverageATKAtMostTwiceAllyDEF
    ld a, c
    cp $01
    jr z, .call_set_c_to_zero
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0031
    call AddAIWeight

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $00ba
    call AddAIWeightToScore2
    ld bc, $00cc
    call AddAIWeight
    ld bc, $00d1
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    farcall CompareFoeAverageATKWithAllyDEF
    ld a, c
    and a
    jr nz, .call_fail_if_skill_has_resistance_class
    ld bc, $0032
    call AddAIWeight

.call_fail_if_skill_has_resistance_class:
    farcall FailIfSkillHasResistanceClass
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AddAIWeightToScore2

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AddAIWeight

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0009
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_Sleep", ROMX

; Sleep's AI score: needs AIScore_Sleep_Conditions; then weight row $04 to wAISkillScore2 when
; AIGateFoeStatus2Mask22 gives 0; weight row $2C to wAISkillScore when AllyAverageAGLAtLeastFoes
; gives 0; always weight row $BC to wAISkillScore2; WeighLinkRules1RuleBit5; weight row $09 to
; wAISkillScore when ResistanceAverageGateForAISide gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForFoeAIMode3 gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 47 Sleep, 48 SleepAll. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_Sleep:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_Sleep_Conditions
    ld a, c
    and a
    ret z
    farcall AIGateFoeStatus2Mask22
    ld a, c
    cp $01
    jr z, .call_ally_average_agl_at_least_foes
    and a
    jr nz, .call_ally_average_agl_at_least_foes
    ld bc, $0004
    call AddAIWeightToScore2

.call_ally_average_agl_at_least_foes:
    farcall AllyAverageAGLAtLeastFoes
    ld a, c
    cp $01
    jr z, .call_set_c_to_zero
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $002c
    call AddAIWeight

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $00bc
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AddAIWeight

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0009
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_TakeMagic", ROMX

; TakeMagic's AI score: needs AIScore_TakeMagic_Conditions; then weight row $34 to wAISkillScore2
; when ActorMPBelowThreeQuarters gives 0; WeighLinkRules1RuleBit5. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 49 TakeMagic. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_TakeMagic:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_TakeMagic_Conditions
    ld a, c
    and a
    ret z
    farcall ActorMPBelowThreeQuarters
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $0034
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    ret

SECTION "Bank E2 AIScore_RobMagic", ROMX

; RobMagic's AI score: needs AIScore_RobMagic_Conditions; then always weight row $35 to
; wAISkillScore; weight row $09 to wAISkillScore when PassIfFoesAverageResistanceAtLeast2 gives 0;
; WeighLinkRules1RuleBit5. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 50 RobMagic. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_RobMagic:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_RobMagic_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0035
    call AddAIWeight
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $0009
    call AddAIWeight

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    ret

SECTION "Bank E2 AIScore_StopSpell", ROMX

; StopSpell's AI score: needs AIScore_StopSpell_Conditions; then weight row $04 to wAISkillScore2
; when AIGateFoeStatus2Mask22 gives 0; WeighLinkRules1RuleBit5; always weight row $CC to
; wAISkillScore and weight row $D1 to wAISkillScore2; weight row $36 to wAISkillScore when
; FailIfFoeKnowsSkillList gives 0; weight row $12 to wAISkillScore2 when
; FailIfSkillHasResistanceClass gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForAISide gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForFoeAIMode3 gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 51 StopSpell. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_StopSpell:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_StopSpell_Conditions
    ld a, c
    and a
    ret z
    farcall AIGateFoeStatus2Mask22
    ld a, c
    cp $01
    jr z, .call_weigh_link_rules1_rule_bit5
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $0004
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_fail_if_foe_knows_skill_list
    ld bc, $00cc
    call AddAIWeight
    ld bc, $00d1
    call AddAIWeightToScore2

.call_fail_if_foe_knows_skill_list:
    farcall FailIfFoeKnowsSkillList
    ld a, c
    cp $01
    jr z, .call_fail_if_skill_has_resistance_class
    and a
    jr nz, .call_fail_if_skill_has_resistance_class
    ld bc, $0036
    call AddAIWeight

.call_fail_if_skill_has_resistance_class:
    farcall FailIfSkillHasResistanceClass
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AddAIWeightToScore2

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AddAIWeight

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0009
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_PanicAll", ROMX

; PanicAll's AI score: needs AIPanicAllUsable; then always weight row $CA to wAISkillScore;
; WeighLinkRules1RuleBit5; weight row $12 to wAISkillScore2 when FailIfSkillHasResistanceClass gives
; 0; weight row $09 to wAISkillScore when ResistanceAverageGateForAISide gives 0; weight row $09 to
; wAISkillScore when ResistanceAverageGateForFoeAIMode3 gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 52 PanicAll. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_PanicAll:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIPanicAllUsable
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $00ca
    call AddAIWeight

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    farcall FailIfSkillHasResistanceClass
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AddAIWeightToScore2

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AddAIWeight

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0009
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_Ironize", ROMX

; Ironize's AI score: needs AIIronizeUsable and AIScoreGuardSkill; then always weight row $D0 to
; wAISkillScore; WeighLinkRules1RuleBit5. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 53 Ironize. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Ironize:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIIronizeUsable
    ld a, c
    and a
    ret z
    call AIScoreGuardSkill
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $00d0
    call AddAIWeight

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    ret

SECTION "Bank E2 AIScore_MagicBack", ROMX

; MagicBack's AI score: needs AIScore_MagicBack_Conditions; then always weight row $C0 to
; wAISkillScore2; weight row $36 to wAISkillScore when FailIfFoeKnowsSkillList gives 0. (C2, E-0357;
; probed E-0385)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 54 MagicBack, 55 Bounce. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_MagicBack:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_MagicBack_Conditions
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_fail_if_foe_knows_skill_list
    ld bc, $00c0
    call AddAIWeightToScore2

.call_fail_if_foe_knows_skill_list:
    farcall FailIfFoeKnowsSkillList
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0036
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_Barrier", ROMX

; Barrier's AI score: needs AIScore_Barrier_Conditions; then weight row $3A to wAISkillScore when
; FailIfFoeKnowsSkills42To47 gives 0; WeighLinkRules1RuleBit5. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 56 Barrier. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Barrier:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_Barrier_Conditions
    ld a, c
    and a
    ret z
    farcall FailIfFoeKnowsSkills42To47
    ld a, c
    cp $01
    jr z, .call_weigh_link_rules1_rule_bit5
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $003a
    call AddAIWeight

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    ret

SECTION "Bank E2 AIScore_MagicWall", ROMX

; MagicWall's AI score: needs AIScore_MagicWall_Conditions; then WeighLinkRules1RuleBit5; weight row
; $36 to wAISkillScore when FailIfFoeKnowsSkillList gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 57 MagicWall. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_MagicWall:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_MagicWall_Conditions
    ld a, c
    and a
    ret z
    call WeighLinkRules1RuleBit5
    farcall FailIfFoeKnowsSkillList
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0036
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_Transform", ROMX

; Transform's AI score: needs AIUsableAndActorLacksStatus4Bits67; then weight row $3B to
; wAISkillScore when PassIfTwiceATKAboveHighestFoeDEF gives 0; weight row $3C to wAISkillScore when
; AIScore_Transform_NoWeakerFoe gives 0; always weight row $CE to wAISkillScore;
; WeighLinkRules1RuleBit5. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 58 Transform. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Transform:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIUsableAndActorLacksStatus4Bits67
    ld a, c
    and a
    ret z
    farcall PassIfTwiceATKAboveHighestFoeDEF
    ld a, c
    cp $01
    jr z, .call_ai_score_transform_no_weaker_foe
    and a
    jr nz, .call_ai_score_transform_no_weaker_foe
    ld bc, $003b
    call AddAIWeight

.call_ai_score_transform_no_weaker_foe:
    farcall AIScore_Transform_NoWeakerFoe
    ld a, c
    cp $01
    jr z, .call_set_c_to_zero
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $003c
    call AddAIWeight

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $00ce
    call AddAIWeight

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    ret

SECTION "Bank E2 AIScore_BeDragon", ROMX

; BeDragon's AI score: needs AIUsableAndActorLacksStatus4Bits67; then weight row $3A to
; wAISkillScore when FailIfFoeKnowsSkills42To47 gives 0; WeighLinkRules1RuleBit5; weight row $3D to
; wAISkillScore when AIScore_BeDragon_CountHighStats gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 59 BeDragon. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_BeDragon:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIUsableAndActorLacksStatus4Bits67
    ld a, c
    and a
    ret z
    farcall FailIfFoeKnowsSkills42To47
    ld a, c
    cp $01
    jr z, .call_weigh_link_rules1_rule_bit5
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $003a
    call AddAIWeight

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    farcall AIScore_BeDragon_CountHighStats
    ld a, c
    and a
    jr nz, .return
    ld bc, $003d
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_Chance", ROMX

; Chance's AI score: needs CheckSkillUsableStatusElseResetAISkillScore; then weight row $3F to
; wAISkillScore when AllOtherAlliesHaveStatus0Bit6 gives 0; weight row $40 to wAISkillScore when
; ActorHPIsNotOne gives 0; always weight row $BF to wAISkillScore and weight row $C5 to
; wAISkillScore2; WeighLinkRules1RuleBit5; weight row $42 to wAISkillScore when
; AllySlotsCheckThenFewerThanTwoFoes gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 60 Chance. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Chance:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a
    ret z
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a
    jr nz, .call_actor_hp_is_not_one
    ld bc, $003f
    call AddAIWeight

.call_actor_hp_is_not_one:
    farcall ActorHPIsNotOne
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0040
    call AddAIWeight

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $00bf
    call AddAIWeight
    ld bc, $00c5
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a
    jr nz, .return
    ld bc, $0042
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_MegaMagic", ROMX

; MegaMagic's AI score: needs AIScore_MegaMagic_Conditions; then weight row $43 to wAISkillScore
; when AllOtherAlliesHaveStatus0Bit6 gives 0; weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row $44 to wAISkillScore2 when
; AnyAllyLacksStatus1Bits23And4Bits01 gives 0; weight row $09 to wAISkillScore when
; PassIfFoesAverageResistanceAtLeast2 gives 0; always weight row $45 to wAISkillScore; weight row
; $0E to wAISkillScore2 when AIScore_MegaMagic_LinkRule gives 0; weight row $46 to wAISkillScore
; when LinkRuleCheckLinkRuleTurnLimitTurnLimit gives 0; weight row $47 to wAISkillScore when
; AllySlotsCheckThenFewerThanTwoFoes gives 0; weight row $48 to wAISkillScore when
; AIScore_MegaMagic_LinkModeAllows gives 0; weight row $3E to wAISkillScore2 when
; AIScore_MegaMagic_FoeHPPlusDEFHigh gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 61 MegaMagic. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_MegaMagic:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_MegaMagic_Conditions
    ld a, c
    and a
    ret z
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a
    jr nz, .call_check_lone_foe_hp_not_below_ai_damage
    ld bc, $0043
    call AddAIWeight

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_any_ally_lacks_status1_bits23_and4
    ld bc, $0007
    call AddAIWeightToScore2

.call_any_ally_lacks_status1_bits23_and4:
    farcall AnyAllyLacksStatus1Bits23And4Bits01
    ld a, c
    and a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $0044
    call AddAIWeightToScore2

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0009
    call AddAIWeight

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_ai_score_mega_magic_link_rule
    ld bc, $0045
    call AddAIWeight

.call_ai_score_mega_magic_link_rule:
    farcall AIScore_MegaMagic_LinkRule
    ld a, c
    and a
    jr nz, .call_link_rule_check_link_rule_turn_limit
    ld bc, $000e
    call AddAIWeightToScore2

.call_link_rule_check_link_rule_turn_limit:
    farcall LinkRuleCheckLinkRuleTurnLimitTurnLimit
    ld a, c
    and a
    jr nz, .call_ally_slots_check_then_fewer_than_two
    ld bc, $0046
    call AddAIWeight

.call_ally_slots_check_then_fewer_than_two:
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a
    jr nz, .call_ai_score_mega_magic_link_mode_allows
    ld bc, $0047
    call AddAIWeight

.call_ai_score_mega_magic_link_mode_allows:
    farcall AIScore_MegaMagic_LinkModeAllows
    ld a, c
    and a
    jr nz, .call_ai_score_mega_magic_foe_hp_plus_def_high
    ld bc, $0048
    call AddAIWeight

.call_ai_score_mega_magic_foe_hp_plus_def_high:
    farcall AIScore_MegaMagic_FoeHPPlusDEFHigh
    ld a, c
    cp $01
    jr z, .return
    or a
    jr nz, .return
    ld bc, $003e
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_BigBang", ROMX

; BigBang's AI score: needs AIAttackSkillUsable; then weight row $49 to wAISkillScore when
; ActorLacksStatus4Bits67 gives 0; weight row $0A to wAISkillScore2 when
; FailIfFoeAIDamageEstimatesAtLeastEstimate gives 0; weight row $09 to wAISkillScore when
; PassIfFoesAverageResistanceAtLeast2 gives 0; weight row $0D to wAISkillScore when
; PassIfFoeAIDamageEstimatesAtLeastEstimate gives 0; WeighLinkRules1RuleBit1; weight row $46 to
; wAISkillScore when LinkRuleCheckLinkRuleTurnLimitTurnLimit gives 0; weight row $47 to
; wAISkillScore when AllySlotsCheckThenFewerThanTwoFoes gives 0; weight row $15 to wAISkillScore
; when FewerThanTwoFoesPresent gives 0; weight row $4A to wAISkillScore2 when CheckFoeStatus6Bit3
; gives 0; weight row $4B to wAISkillScore when CheckBattleKindNot2Or3 gives 0; weight row $12 to
; wAISkillScore2 when FailIfSkillHasResistanceClass gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 62 BigBang, 63 Hellblast. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_BigBang:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIAttackSkillUsable
    ld a, c
    and a
    ret z
    farcall ActorLacksStatus4Bits67
    ld a, c
    and a
    jr nz, .call_fail_if_foe_ai_damage_estimates_at_least
    ld bc, $0049
    call AddAIWeight

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $000a
    call AddAIWeightToScore2

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a
    jr nz, .call_pass_if_foe_ai_damage_estimates_at_least
    ld bc, $0009
    call AddAIWeight

.call_pass_if_foe_ai_damage_estimates_at_least:
    farcall PassIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit1
    ld bc, $000d
    call AddAIWeight

.call_weigh_link_rules1_rule_bit1:
    call WeighLinkRules1RuleBit1
    farcall LinkRuleCheckLinkRuleTurnLimitTurnLimit
    ld a, c
    and a
    jr nz, .call_ally_slots_check_then_fewer_than_two
    ld bc, $0046
    call AddAIWeight

.call_ally_slots_check_then_fewer_than_two:
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a
    jr nz, .call_fewer_than_two_foes_present
    ld bc, $0047
    call AddAIWeight

.call_fewer_than_two_foes_present:
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0015
    call AddAIWeight

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp $01
    jr z, .call_check_battle_kind_not2_or3
    and a
    jr nz, .call_check_battle_kind_not2_or3
    ld bc, $004a
    call AddAIWeightToScore2

.call_check_battle_kind_not2_or3:
    farcall CheckBattleKindNot2Or3
    ld a, c
    and a
    jr nz, .call_fail_if_skill_has_resistance_class
    ld bc, $004b
    call AddAIWeight

.call_fail_if_skill_has_resistance_class:
    farcall FailIfSkillHasResistanceClass
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0012
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_FireAir", ROMX

; FireAir's AI score: needs AIScore_FireAir_Conditions; then weight row $4C to wAISkillScore2 when
; AIScore_FireAir_WindGuardCheck gives 0; weight row $11 to wAISkillScore2 when
; AtLeastTwoFoesPresent gives 0; weight row $0A to wAISkillScore2 when
; FailIfFoeAIDamageEstimatesAtLeastEstimate gives 0; weight row $09 to wAISkillScore when
; PassIfFoesAverageResistanceAtLeast2 gives 0; weight row $4D to wAISkillScore when
; ActorLacksStatus4Bits45 gives 0; always weight row $6A to wAISkillScore; weight row $0D to
; wAISkillScore when PassIfFoeAIDamageEstimatesAtLeastEstimate gives 0; WeighLinkRules1RuleBit3;
; weight row $15 to wAISkillScore when FewerThanTwoFoesPresent gives 0; weight row $4A to
; wAISkillScore2 when CheckFoeStatus6Bit3 gives 0; weight row $4E to wAISkillScore2 when
; AnyAllyLacksStatus2Bit2_2 gives 0; weight row $12 to wAISkillScore2 when
; FailIfSkillHasResistanceClass gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 8 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 64 FireAir, 65 BlazeAir, 66 Scorching, 67
; WhiteFire, 68 FrigidAir, 69 IceAir, 70 IceStorm, 71 WhiteAir. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_FireAir:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_FireAir_Conditions
    ld a, c
    and a
    ret z
    farcall AIScore_FireAir_WindGuardCheck
    ld a, c
    and a
    jr nz, .call_at_least_two_foes_present
    ld bc, $004c
    call AddAIWeightToScore2

.call_at_least_two_foes_present:
    farcall AtLeastTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_fail_if_foe_ai_damage_estimates_at_least
    ld bc, $0011
    call AddAIWeightToScore2

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $000a
    call AddAIWeightToScore2

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a
    jr nz, .call_actor_lacks_status4_bits45
    ld bc, $0009
    call AddAIWeight

.call_actor_lacks_status4_bits45:
    farcall ActorLacksStatus4Bits45
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $004d
    call AddAIWeight

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_pass_if_foe_ai_damage_estimates_at_least
    ld bc, $006a
    call AddAIWeight

.call_pass_if_foe_ai_damage_estimates_at_least:
    farcall PassIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit3
    ld bc, $000d
    call AddAIWeight

.call_weigh_link_rules1_rule_bit3:
    call WeighLinkRules1RuleBit3
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0015
    call AddAIWeight

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp $01
    jr z, .call_any_ally_lacks_status2_bit2_2
    and a
    jr nz, .call_any_ally_lacks_status2_bit2_2
    ld bc, $004a
    call AddAIWeightToScore2

.call_any_ally_lacks_status2_bit2_2:
    farcall AnyAllyLacksStatus2Bit2_2
    ld a, c
    and a
    jr nz, .call_fail_if_skill_has_resistance_class
    ld bc, $004e
    call AddAIWeightToScore2

.call_fail_if_skill_has_resistance_class:
    farcall FailIfSkillHasResistanceClass
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0012
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_WindBeast", ROMX

; WindBeast's AI score: needs AIAttackSkillUsable; then weight row $10 to wAISkillScore2 when
; FewerThanTwoFoesPresent gives 0; then goes on at AIScore_Vacuum_DamageAndResistWeights. (C2,
; E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 72 WindBeast. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_WindBeast:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIAttackSkillUsable
    ld a, c
    and a
    ret z
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, AIScore_Vacuum_DamageAndResistWeights
    ld bc, $0010
    call AddAIWeightToScore2

; Second half of the 'Vacuum' and 'WindBeast' scores (AIScore_Vacuum calls it, AIScore_WindBeast
; continues into it), ending in ret. Adds row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0, row $0A to wAISkillScore2 when
; FailIfFoeAIDamageEstimatesAtLeastEstimate gives 0, row $09 when
; PassIfFoesAverageResistanceAtLeast2 gives 0 and row $0D when
; PassIfFoeAIDamageEstimatesAtLeastEstimate gives 0, calls WeighLinkRules1RuleBit1, and adds row $4F
; when FailIfFoeHPAtLeast150PercentOfActor gives 0. (C2, E-0385)
AIScore_Vacuum_DamageAndResistWeights::
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_fail_if_foe_ai_damage_estimates_at_least
    ld bc, $0007
    call AddAIWeightToScore2

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $000a
    call AddAIWeightToScore2

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a
    jr nz, .call_pass_if_foe_ai_damage_estimates_at_least
    ld bc, $0009
    call AddAIWeight

.call_pass_if_foe_ai_damage_estimates_at_least:
    farcall PassIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit1
    ld bc, $000d
    call AddAIWeight

.call_weigh_link_rules1_rule_bit1:
    call WeighLinkRules1RuleBit1
    farcall FailIfFoeHPAtLeast150PercentOfActor
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $004f
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_Vacuum", ROMX

; Vacuum's AI score: needs AIAttackSkillUsable; then AIScore_Vacuum_DamageAndResistWeights; weight
; row $15 to wAISkillScore when FewerThanTwoFoesPresent gives 0; weight row $4A to wAISkillScore2
; when CheckFoeStatus6Bit3 gives 0; weight row $12 to wAISkillScore2 when
; FailIfSkillHasResistanceClass gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 73 Vacuum, 74 Lightning. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_Vacuum:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIAttackSkillUsable
    ld a, c
    and a
    ret z
    call AIScore_Vacuum_DamageAndResistWeights
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0015
    call AddAIWeight

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp $01
    jr z, .call_fail_if_skill_has_resistance_class
    and a
    jr nz, .call_fail_if_skill_has_resistance_class
    ld bc, $004a
    call AddAIWeightToScore2

.call_fail_if_skill_has_resistance_class:
    farcall FailIfSkillHasResistanceClass
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0012
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_RockThrow", ROMX

; RockThrow's AI score: needs AIAndFoeLacksStatus3And4; then weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row $0A to wAISkillScore2 when
; FailIfFoeAIDamageEstimatesAtLeastEstimate gives 0; weight row $09 to wAISkillScore when
; PassIfFoesAverageResistanceAtLeast2 gives 0; weight row $0D to wAISkillScore when
; PassIfFoeAIDamageEstimatesAtLeastEstimate gives 0; WeighLinkRules1RuleBit1; weight row $15 to
; wAISkillScore when FewerThanTwoFoesPresent gives 0; weight row $4A to wAISkillScore2 when
; CheckFoeStatus6Bit3 gives 0; weight row $6B to wAISkillScore2 when CheckActorSlot0To3OrLinkModeSet
; gives 0; weight row $12 to wAISkillScore2 when FailIfSkillHasResistanceClass gives 0. (C2, E-0357;
; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 75 RockThrow. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_RockThrow:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIAndFoeLacksStatus3And4
    ld a, c
    and a
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_fail_if_foe_ai_damage_estimates_at_least
    ld bc, $0007
    call AddAIWeightToScore2

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $000a
    call AddAIWeightToScore2

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a
    jr nz, .call_pass_if_foe_ai_damage_estimates_at_least
    ld bc, $0009
    call AddAIWeight

.call_pass_if_foe_ai_damage_estimates_at_least:
    farcall PassIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit1
    ld bc, $000d
    call AddAIWeight

.call_weigh_link_rules1_rule_bit1:
    call WeighLinkRules1RuleBit1
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0015
    call AddAIWeight

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp $01
    jr z, .call_check_actor_slot0_to3_or_link_mode_set
    and a
    jr nz, .call_check_actor_slot0_to3_or_link_mode_set
    ld bc, $004a
    call AddAIWeightToScore2

.call_check_actor_slot0_to3_or_link_mode_set:
    farcall CheckActorSlot0To3OrLinkModeSet
    ld a, c
    and a
    jr nz, .call_fail_if_skill_has_resistance_class
    ld bc, $006b
    call AddAIWeightToScore2

.call_fail_if_skill_has_resistance_class:
    farcall FailIfSkillHasResistanceClass
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0012
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_Watershot", ROMX

; Watershot's AI score: needs AIAndFoeLacksStatus3And4; then weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row $0D to wAISkillScore2 when
; FailIfFoeAIDamageEstimatesAtLeastEstimate gives 0; weight row $09 to wAISkillScore when
; PassIfFoesAverageResistanceAtLeast2 gives 0; weight row $0D to wAISkillScore when
; PassIfFoeAIDamageEstimatesAtLeastEstimate gives 0; WeighLinkRules1RuleBit1; weight row $10 to
; wAISkillScore2 when FewerThanTwoFoesPresent gives 0; weight row $4A to wAISkillScore2 when
; CheckFoeStatus6Bit3 gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 76 Watershot. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Watershot:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIAndFoeLacksStatus3And4
    ld a, c
    and a
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_fail_if_foe_ai_damage_estimates_at_least
    ld bc, $0007
    call AddAIWeightToScore2

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $000d
    call AddAIWeightToScore2

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a
    jr nz, .call_pass_if_foe_ai_damage_estimates_at_least
    ld bc, $0009
    call AddAIWeight

.call_pass_if_foe_ai_damage_estimates_at_least:
    farcall PassIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit1
    ld bc, $000d
    call AddAIWeight

.call_weigh_link_rules1_rule_bit1:
    call WeighLinkRules1RuleBit1
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0010
    call AddAIWeightToScore2

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $004a
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_Tidalwave", ROMX

; Tidalwave's AI score: needs AIAndFoeLacksStatus3And4; then weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row $0A to wAISkillScore2 when
; FailIfFoeAIDamageEstimatesAtLeastEstimate gives 0; weight row $09 to wAISkillScore when
; PassIfFoesAverageResistanceAtLeast2 gives 0; weight row $0D to wAISkillScore when
; PassIfFoeAIDamageEstimatesAtLeastEstimate gives 0; WeighLinkRules1RuleBit1; weight row $15 to
; wAISkillScore when FewerThanTwoFoesPresent gives 0; weight row $4A to wAISkillScore2 when
; CheckFoeStatus6Bit3 gives 0; weight row $12 to wAISkillScore2 when FailIfSkillHasResistanceClass
; gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 77 Tidalwave. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Tidalwave:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIAndFoeLacksStatus3And4
    ld a, c
    and a
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_fail_if_foe_ai_damage_estimates_at_least
    ld bc, $0007
    call AddAIWeightToScore2

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $000a
    call AddAIWeightToScore2

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a
    jr nz, .call_pass_if_foe_ai_damage_estimates_at_least
    ld bc, $0009
    call AddAIWeight

.call_pass_if_foe_ai_damage_estimates_at_least:
    farcall PassIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit1
    ld bc, $000d
    call AddAIWeight

.call_weigh_link_rules1_rule_bit1:
    call WeighLinkRules1RuleBit1
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0015
    call AddAIWeight

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp $01
    jr z, .call_fail_if_skill_has_resistance_class
    and a
    jr nz, .call_fail_if_skill_has_resistance_class
    ld bc, $004a
    call AddAIWeightToScore2

.call_fail_if_skill_has_resistance_class:
    farcall FailIfSkillHasResistanceClass
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0012
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_CallHelp", ROMX

; CallHelp's AI score: needs AIAndFoeLacksStatus3And4; then weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row $08 to wAISkillScore2 when
; FailIfFoeAIDamageEstimatesAtLeastEstimate gives 0; weight row $09 to wAISkillScore when
; PassIfFoesAverageResistanceAtLeast2 gives 0; weight row $0A to wAISkillScore2 when
; ActorLacksStatus1Bits23And4Bits01 gives 0; always weight row $BE to wAISkillScore2 and weight row
; $C5 to wAISkillScore; weight row $0D to wAISkillScore when
; PassIfFoeAIDamageEstimatesAtLeastEstimate gives 0; WeighLinkRules1RuleBit1; weight row $15 to
; wAISkillScore when FewerThanTwoFoesPresent gives 0; weight row $4A to wAISkillScore2 when
; CheckFoeStatus6Bit3 gives 0; weight row $4F to wAISkillScore when
; FailIfFoeHPAtLeast150PercentOfActor gives 0; weight row $12 to wAISkillScore2 when
; FailIfSkillHasResistanceClass gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 78 CallHelp, 79 YellHelp. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_CallHelp:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIAndFoeLacksStatus3And4
    ld a, c
    and a
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_fail_if_foe_ai_damage_estimates_at_least
    ld bc, $0007
    call AddAIWeightToScore2

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $0008
    call AddAIWeightToScore2

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a
    jr nz, .call_actor_lacks_status1_bits23_and4_bits01
    ld bc, $0009
    call AddAIWeight

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $000a
    call AddAIWeightToScore2

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_pass_if_foe_ai_damage_estimates_at_least
    ld bc, $00be
    call AddAIWeightToScore2
    ld bc, $00c5
    call AddAIWeight

.call_pass_if_foe_ai_damage_estimates_at_least:
    farcall PassIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit1
    ld bc, $000d
    call AddAIWeight

.call_weigh_link_rules1_rule_bit1:
    call WeighLinkRules1RuleBit1
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0015
    call AddAIWeight

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp $01
    jr z, .call_fail_if_foe_hp_at_least150_percent_of
    and a
    jr nz, .call_fail_if_foe_hp_at_least150_percent_of
    ld bc, $004a
    call AddAIWeightToScore2

.call_fail_if_foe_hp_at_least150_percent_of:
    farcall FailIfFoeHPAtLeast150PercentOfActor
    ld a, c
    cp $01
    jr z, .call_fail_if_skill_has_resistance_class
    and a
    jr nz, .call_fail_if_skill_has_resistance_class
    ld bc, $004f
    call AddAIWeight

.call_fail_if_skill_has_resistance_class:
    farcall FailIfSkillHasResistanceClass
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0012
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_FireSlash", ROMX

; FireSlash's AI score: needs AIAndFoeLacksStatus3And4; then weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row $03 to wAISkillScore2 when
; CheckFoeStatus7Bit2 gives 0; weight row $08 to wAISkillScore2 when
; FailIfFoeAIDamageEstimatesAtLeastEstimate gives 0; weight row $09 to wAISkillScore when
; PassIfFoesAverageResistanceAtLeast2 gives 0; weight row $55 to wAISkillScore when
; ActorLacksStatus1Bits23And4Bits01 gives 0; weight row $0D to wAISkillScore when
; PassIfFoeAIDamageEstimatesAtLeastEstimate gives 0; WeighLinkRules1RuleBit1; weight row $66 to
; wAISkillScore when CheckBattleKindAtLeast2OrLinkModeSet gives 0; weight row $67 to wAISkillScore
; when FoeHPCheckReadsWrongSlot gives 0; weight row $05 to wAISkillScore when
; ActorStatus4CheckReadsAddress gives 0; weight row $33 to wAISkillScore2 when
; ActorLacksStatus2Bit1And5Bits01 gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 4 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 80 FireSlash, 81 VacuSlash, 82 BoltSlash, 83
; IceSlash. It runs checks and adds weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70)
; (E-0083)
AIScore_FireSlash:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIAndFoeLacksStatus3And4
    ld a, c
    and a
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_check_foe_status7_bit2
    ld bc, $0007
    call AddAIWeightToScore2

.call_check_foe_status7_bit2:
    farcall CheckFoeStatus7Bit2
    ld a, c
    cp $01
    jr z, .call_fail_if_foe_ai_damage_estimates_at_least
    and a
    jr nz, .call_fail_if_foe_ai_damage_estimates_at_least
    ld bc, $0003
    call AddAIWeightToScore2

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $0008
    call AddAIWeightToScore2

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a
    jr nz, .call_actor_lacks_status1_bits23_and4_bits01
    ld bc, $0009
    call AddAIWeight

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a
    jr nz, .call_pass_if_foe_ai_damage_estimates_at_least
    ld bc, $0055
    call AddAIWeight

.call_pass_if_foe_ai_damage_estimates_at_least:
    farcall PassIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit1
    ld bc, $000d
    call AddAIWeight

.call_weigh_link_rules1_rule_bit1:
    call WeighLinkRules1RuleBit1
    farcall CheckBattleKindAtLeast2OrLinkModeSet
    ld a, c
    and a
    jr nz, .call_foe_hp_check_reads_wrong_slot
    ld bc, $0066
    call AddAIWeight

.call_foe_hp_check_reads_wrong_slot:
    farcall FoeHPCheckReadsWrongSlot
    ld a, c
    and a
    jr nz, .call_actor_status4_check_reads_address
    ld bc, $0067
    call AddAIWeight

.call_actor_status4_check_reads_address:
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a
    jr nz, .call_actor_lacks_status2_bit1_and5_bits01
    ld bc, $0005
    call AddAIWeight

.call_actor_lacks_status2_bit1_and5_bits01:
    farcall ActorLacksStatus2Bit1And5Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_SlimeBlow", ROMX

; AI score of 'SlimeBlow' (skill 84, entry of both tables). Returns at once unless
; AIScore_SlimeBlow_Conditions gives non-zero. Then always adds row $52 to wAISkillScore and falls
; into AIScore_SlimeBlow_CommonWeights, which adds the rest of the weights. (C2, E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 84 SlimeBlow. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_SlimeBlow:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_SlimeBlow_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AddAIWeight

; Shared second half of the scores of 'SlimeBlow' (which falls into it), 'DrakSlash', 'BeastCut',
; 'BirdBlow', 'BugBlow', 'Shears', 'DevilCut', 'ZombieCut', 'CleanCut', 'AquaCut' and 'MetalCut'
; (which jump to it), ending in ret. Adds row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0, row $03 to wAISkillScore2 when
; CheckFoeStatus7Bit2 gives 0, row $53 when ActorLacksStatus1Bits23And4Bits01 gives 0, calls
; WeighLinkRules1RuleBit1, adds row $66 when CheckBattleKindAtLeast2OrLinkModeSet gives 0 and row
; $67 when FoeHPCheckReadsWrongSlot gives 0. Only when that last check gives 0 does it go on to add
; row $05 when ActorStatus4CheckReadsAddress gives 0 and row $33 to wAISkillScore2 when
; ActorLacksStatus2Bit1And5Bits01 gives 0; a non-zero result returns without those two. (C2, E-0385)
AIScore_SlimeBlow_CommonWeights::
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_check_foe_status7_bit2
    ld bc, $0007
    call AddAIWeightToScore2

.call_check_foe_status7_bit2:
    farcall CheckFoeStatus7Bit2
    ld a, c
    cp $01
    jr z, .call_actor_lacks_status1_bits23_and4_bits01
    and a
    jr nz, .call_actor_lacks_status1_bits23_and4_bits01
    ld bc, $0003
    call AddAIWeightToScore2

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit1
    ld bc, $0053
    call AddAIWeight

.call_weigh_link_rules1_rule_bit1:
    call WeighLinkRules1RuleBit1
    farcall CheckBattleKindAtLeast2OrLinkModeSet
    ld a, c
    and a
    jr nz, .call_foe_hp_check_reads_wrong_slot
    ld bc, $0066
    call AddAIWeight

.call_foe_hp_check_reads_wrong_slot:
    farcall FoeHPCheckReadsWrongSlot
    ld a, c
    and a
    jr nz, .return
    ld bc, $0067
    call AddAIWeight
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a
    jr nz, .call_actor_lacks_status2_bit1_and5_bits01
    ld bc, $0005
    call AddAIWeight

.call_actor_lacks_status2_bit1_and5_bits01:
    farcall ActorLacksStatus2Bit1And5Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_DrakSlash", ROMX

; DrakSlash's AI score: needs AIScore_DrakSlash_Conditions; then always weight row $52 to
; wAISkillScore; then goes on at AIScore_SlimeBlow_CommonWeights. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 85 DrakSlash. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_DrakSlash:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_DrakSlash_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AddAIWeight
    jp AIScore_SlimeBlow_CommonWeights

SECTION "Bank E2 AIScore_BeastCut", ROMX

; BeastCut's AI score: needs AIScore_BeastCut_Conditions; then always weight row $52 to
; wAISkillScore; then goes on at AIScore_SlimeBlow_CommonWeights. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 86 BeastCut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_BeastCut:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_BeastCut_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AddAIWeight
    jp AIScore_SlimeBlow_CommonWeights

SECTION "Bank E2 AIScore_BirdBlow", ROMX

; BirdBlow's AI score: needs AIScore_BirdBlow_Conditions; then always weight row $52 to
; wAISkillScore; then goes on at AIScore_SlimeBlow_CommonWeights. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 87 BirdBlow. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_BirdBlow:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_BirdBlow_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AddAIWeight
    jp AIScore_SlimeBlow_CommonWeights

SECTION "Bank E2 AIScore_BugBlow", ROMX

; BugBlow's AI score: needs AIScore_BugBlow_Conditions; then always weight row $52 to wAISkillScore;
; then goes on at AIScore_SlimeBlow_CommonWeights. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 88 BugBlow. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_BugBlow:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_BugBlow_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AddAIWeight
    jp AIScore_SlimeBlow_CommonWeights

SECTION "Bank E2 AIScore_Shears", ROMX

; Shears' AI score: needs AIScore_Shears_Conditions; then always weight row $52 to wAISkillScore;
; then goes on at AIScore_SlimeBlow_CommonWeights. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 89 Shears. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Shears:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_Shears_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AddAIWeight
    jp AIScore_SlimeBlow_CommonWeights

SECTION "Bank E2 AIScore_DevilCut", ROMX

; DevilCut's AI score: needs AIScore_DevilCut_Conditions; then always weight row $52 to
; wAISkillScore; then goes on at AIScore_SlimeBlow_CommonWeights. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 90 DevilCut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_DevilCut:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_DevilCut_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AddAIWeight
    jp AIScore_SlimeBlow_CommonWeights

SECTION "Bank E2 AIScore_ZombieCut", ROMX

; ZombieCut's AI score: needs AIScore_ZombieCut_Conditions; then always weight row $52 to
; wAISkillScore; then goes on at AIScore_SlimeBlow_CommonWeights. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 91 ZombieCut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_ZombieCut:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_ZombieCut_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AddAIWeight
    jp AIScore_SlimeBlow_CommonWeights

SECTION "Bank E2 AIScore_CleanCut", ROMX

; CleanCut's AI score: needs AIScore_CleanCut_Conditions; then always weight row $52 to
; wAISkillScore; then goes on at AIScore_SlimeBlow_CommonWeights. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 92 CleanCut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_CleanCut:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_CleanCut_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AddAIWeight
    jp AIScore_SlimeBlow_CommonWeights

SECTION "Bank E2 AIScore_AquaCut", ROMX

; AquaCut's AI score: needs AIScore_AquaCut_Conditions; then always weight row $52 to wAISkillScore;
; then goes on at AIScore_SlimeBlow_CommonWeights. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 93 AquaCut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_AquaCut:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_AquaCut_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AddAIWeight
    jp AIScore_SlimeBlow_CommonWeights

SECTION "Bank E2 AIScore_MetalCut", ROMX

; MetalCut's AI score: needs AIScore_MetalCut_Conditions; then always weight row $53 to
; wAISkillScore; then goes on at AIScore_SlimeBlow_CommonWeights. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 94 MetalCut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_MetalCut:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_MetalCut_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0053
    call AddAIWeight
    jp AIScore_SlimeBlow_CommonWeights

SECTION "Bank E2 AIScore_PoisonHit", ROMX

; AI score of 'PoisonHit' (skill 95, entry of both tables). Returns at once unless
; AIScore_PoisonHit_Conditions gives non-zero. Then always adds row $54 to wAISkillScore and falls
; into AIScore_PoisonHit_StatusAndResistWeights, which adds the rest of the weights. (C2, E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 95 PoisonHit. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_PoisonHit:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_PoisonHit_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0054
    call AddAIWeight

; Shared second half of the scores of 'PoisonHit' (which falls into it), 'Paralyze' and 'NapAttack'
; (which jump to it), ending in ret. Adds row $55 when ActorLacksStatus1Bits23And4Bits01 gives 0,
; calls WeighLinkRules1RuleBit1, adds row $66 when CheckBattleKindAtLeast2OrLinkModeSet gives 0, row
; $67 when FoeHPCheckReadsWrongSlot gives 0, row $39 to wAISkillScore2 when
; CheckActorSlot0To3OrLinkModeSet gives 0, row $05 when ActorStatus4CheckReadsAddress gives 0, row
; $33 to wAISkillScore2 when ActorLacksStatus2Bit1And5Bits01 gives 0, and row $09 when
; ResistanceAverageGateForAISide gives 0 and again when ResistanceAverageGateForFoeAIMode3 gives 0.
; (C2, E-0385)
AIScore_PoisonHit_StatusAndResistWeights::
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit1
    ld bc, $0055
    call AddAIWeight

.call_weigh_link_rules1_rule_bit1:
    call WeighLinkRules1RuleBit1
    farcall CheckBattleKindAtLeast2OrLinkModeSet
    ld a, c
    and a
    jr nz, .call_foe_hp_check_reads_wrong_slot
    ld bc, $0066
    call AddAIWeight

.call_foe_hp_check_reads_wrong_slot:
    farcall FoeHPCheckReadsWrongSlot
    ld a, c
    and a
    jr nz, .call_check_actor_slot0_to3_or_link_mode_set
    ld bc, $0067
    call AddAIWeight

.call_check_actor_slot0_to3_or_link_mode_set:
    farcall CheckActorSlot0To3OrLinkModeSet
    ld a, c
    and a
    jr nz, .call_actor_status4_check_reads_address
    ld bc, $0039
    call AddAIWeightToScore2

.call_actor_status4_check_reads_address:
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a
    jr nz, .call_actor_lacks_status2_bit1_and5_bits01
    ld bc, $0005
    call AddAIWeight

.call_actor_lacks_status2_bit1_and5_bits01:
    farcall ActorLacksStatus2Bit1And5Bits01
    ld a, c
    and a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0033
    call AddAIWeightToScore2

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AddAIWeight

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0009
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_Paralyze", ROMX

; Paralyze's AI score: needs AIScore_Paralyze_Conditions; then always weight row $54 to
; wAISkillScore; then goes on at AIScore_PoisonHit_StatusAndResistWeights. (C2, E-0357; probed
; E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 96 Paralyze. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Paralyze:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_Paralyze_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0054
    call AddAIWeight
    jp AIScore_PoisonHit_StatusAndResistWeights

SECTION "Bank E2 AIScore_NapAttack", ROMX

; NapAttack's AI score: needs AIScore_NapAttack_Conditions; then always weight row $54 to
; wAISkillScore; then goes on at AIScore_PoisonHit_StatusAndResistWeights. (C2, E-0357; probed
; E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 97 NapAttack. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_NapAttack:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_NapAttack_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0054
    call AddAIWeight
    jp AIScore_PoisonHit_StatusAndResistWeights

SECTION "Bank E2 AIScore_SquallHit_UnreferencedVariant", ROMX

; Not used by the game: AIScoreRoutineTableA and AIScoreRoutineTableB hold the same 201 entries,
; none points here, and nothing in src calls it. It calls AIScore_SquallHit and returns if that
; gives C = 0. Otherwise it farcalls FailIfFoeHurtAndHealerCanCast and, when that gives 0, adds
; weight row $B4 to wAISkillScore, the same row AIScore_SquallHit adds under the same check, so the
; row would count twice. (C2, E-0385)
; table-B AI score: AIScore_SquallHit, then adds a penalty word when the follow-up check fails
; (E-0122)
AIScore_SquallHit_UnreferencedVariant:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    call AIScore_SquallHit
    ld a, c
    and a
    ret z
    farcall FailIfFoeHurtAndHealerCanCast
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $00b4
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_SquallHit", ROMX

; AI score of 'SquallHit' (skill 98, entry of both tables). Returns C = 0 at once unless
; AIScore_SquallHit_Conditions gives non-zero, and returns again when MaxNegativeScoreWhenAIFlagBit0
; returns Z. Then adds row $07 to wAISkillScore2 when CheckLoneFoeHPNotBelowAIDamageEstimates gives
; 0, always row $C8 to wAISkillScore2, calls WeighLinkRules1RuleBit1, adds row $56 when
; FailIfFoeHPAtMostFourFifthsAIDamageEstimates gives 0, row $B4 when FailIfFoeHurtAndHealerCanCast
; gives 0, row $05 when ActorStatus4CheckReadsAddress gives 0 and row $33 to wAISkillScore2 when
; ActorLacksStatus2Bit1And5Bits01 gives 0. Returns C = 1 after a full run. (C2, E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 98 SquallHit. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_SquallHit::
    farcall AIScore_SquallHit_Conditions
    ld a, c
    and a
    ret z
    call MaxNegativeScoreWhenAIFlagBit0
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0007
    call AddAIWeightToScore2

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit1
    ld bc, $00c8
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit1:
    call WeighLinkRules1RuleBit1
    farcall FailIfFoeHPAtMostFourFifthsAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_fail_if_foe_hurt_and_healer_can_cast
    ld bc, $0056
    call AddAIWeight

.call_fail_if_foe_hurt_and_healer_can_cast:
    farcall FailIfFoeHurtAndHealerCanCast
    ld a, c
    cp $01
    jr z, .call_actor_status4_check_reads_address
    and a
    jr nz, .call_actor_status4_check_reads_address
    ld bc, $00b4
    call AddAIWeight

.call_actor_status4_check_reads_address:
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a
    jr nz, .call_actor_lacks_status2_bit1_and5_bits01
    ld bc, $0005
    call AddAIWeight

.call_actor_lacks_status2_bit1_and5_bits01:
    farcall ActorLacksStatus2Bit1And5Bits01
    ld a, c
    and a
    jr nz, .done
    ld bc, $0033
    call AddAIWeightToScore2

.done:
    ld c, $01
    ret

SECTION "Bank E2 AIScore_BiAttack", ROMX

; BiAttack's AI score: needs AIScore_BiAttack_Conditions; then weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row $05 to wAISkillScore when
; ActorLacksStatus1Bits23And4Bits01 gives 0; always weight row $C8 to wAISkillScore2;
; WeighLinkRules1RuleBit1; weight row $15 to wAISkillScore when FewerThanTwoFoesPresent gives 0;
; weight row $4A to wAISkillScore2 when CheckFoeStatus6Bit3 gives 0; weight row $56 to wAISkillScore
; when FailIfFoeHPAtMostFourFifthsAIDamageEstimates gives 0; weight row $56 to wAISkillScore when
; AIScore_BiAttack_FoeHPCheck gives 0; weight row $05 to wAISkillScore when
; ActorStatus4CheckReadsAddress gives 0; weight row $33 to wAISkillScore2 when
; ActorLacksStatus2Bit1And5Bits01 gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 99 BiAttack, 100 QuadHits. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_BiAttack:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_BiAttack_Conditions
    ld a, c
    and a
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_actor_lacks_status1_bits23_and4_bits01
    ld bc, $0007
    call AddAIWeightToScore2

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0005
    call AddAIWeight

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit1
    ld bc, $00c8
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit1:
    call WeighLinkRules1RuleBit1
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0015
    call AddAIWeight

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp $01
    jr z, .call_fail_if_foe_hp_at_most_four_fifths_ai
    and a
    jr nz, .call_fail_if_foe_hp_at_most_four_fifths_ai
    ld bc, $004a
    call AddAIWeightToScore2

.call_fail_if_foe_hp_at_most_four_fifths_ai:
    farcall FailIfFoeHPAtMostFourFifthsAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_ai_score_bi_attack_foe_hp_check
    ld bc, $0056
    call AddAIWeight

.call_ai_score_bi_attack_foe_hp_check:
    farcall AIScore_BiAttack_FoeHPCheck
    ld a, c
    and a
    jr nz, .call_actor_status4_check_reads_address
    ld bc, $0056
    call AddAIWeight

.call_actor_status4_check_reads_address:
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a
    jr nz, .call_actor_lacks_status2_bit1_and5_bits01
    ld bc, $0005
    call AddAIWeight

.call_actor_lacks_status2_bit1_and5_bits01:
    farcall ActorLacksStatus2Bit1And5Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_RainSlash", ROMX

; RainSlash's AI score: needs AIScore_RainSlash_Conditions; then weight row $05 to wAISkillScore
; when ActorLacksStatus1Bits23And4Bits01 gives 0; always weight row $C3 to wAISkillScore and weight
; row $CB to wAISkillScore2; WeighLinkRules1RuleBit1; weight row $15 to wAISkillScore when
; FewerThanTwoFoesPresent gives 0; weight row $4A to wAISkillScore2 when CheckFoeStatus6Bit3 gives
; 0; weight row $05 to wAISkillScore when ActorStatus4CheckReadsAddress gives 0; weight row $33 to
; wAISkillScore2 when ActorLacksStatus2Bit1And5Bits01 gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 101 RainSlash. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_RainSlash:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_RainSlash_Conditions
    ld a, c
    and a
    ret z
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0005
    call AddAIWeight

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit1
    ld bc, $00c3
    call AddAIWeight
    ld bc, $00cb
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit1:
    call WeighLinkRules1RuleBit1
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0015
    call AddAIWeight

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp $01
    jr z, .call_actor_status4_check_reads_address
    and a
    jr nz, .call_actor_status4_check_reads_address
    ld bc, $004a
    call AddAIWeightToScore2

.call_actor_status4_check_reads_address:
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a
    jr nz, .call_actor_lacks_status2_bit1_and5_bits01
    ld bc, $0005
    call AddAIWeight

.call_actor_lacks_status2_bit1_and5_bits01:
    farcall ActorLacksStatus2Bit1And5Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_MultiCut", ROMX

; MultiCut's AI score: needs AIScore_MultiCut_Conditions; then weight row $12 to wAISkillScore2 when
; FailIfSkillHasResistanceClass gives 0; then goes on at AIScore_MultiCut_DamageAndFoeWeights. (C2,
; E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 102 MultiCut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_MultiCut:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_MultiCut_Conditions
    ld a, c
    and a
    ret z
    farcall FailIfSkillHasResistanceClass
    ld a, c
    cp $01
    jr z, AIScore_MultiCut_DamageAndFoeWeights
    and a
    jr nz, AIScore_MultiCut_DamageAndFoeWeights
    ld bc, $0012
    call AddAIWeightToScore2

; Shared second half of the scores of 'MultiCut' (which falls or jumps into it) and 'GigaSlash'
; (which jumps to it), ending in ret. Adds row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0, row $0A to wAISkillScore2 when
; FailIfFoeAIDamageEstimatesAtLeastEstimate gives 0, row $09 when
; PassIfFoesAverageResistanceAtLeast2 gives 0 and row $0D when
; PassIfFoeAIDamageEstimatesAtLeastEstimate gives 0, calls WeighLinkRules1RuleBit1, adds row $57
; when FewerThanTwoFoesPresent gives 0 and row $4A to wAISkillScore2 when CheckFoeStatus6Bit3 gives
; 0. (C2, E-0385)
AIScore_MultiCut_DamageAndFoeWeights::
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_fail_if_foe_ai_damage_estimates_at_least
    ld bc, $0007
    call AddAIWeightToScore2

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $000a
    call AddAIWeightToScore2

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a
    jr nz, .call_pass_if_foe_ai_damage_estimates_at_least
    ld bc, $0009
    call AddAIWeight

.call_pass_if_foe_ai_damage_estimates_at_least:
    farcall PassIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit1
    ld bc, $000d
    call AddAIWeight

.call_weigh_link_rules1_rule_bit1:
    call WeighLinkRules1RuleBit1
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0057
    call AddAIWeight

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $004a
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_GigaSlash", ROMX

; GigaSlash's AI score: needs AIAndFoeLacksStatus3And4; then weight row $33 to wAISkillScore2 when
; ActorLacksStatus2Bit1And5Bits01 gives 0; then goes on at AIScore_MultiCut_DamageAndFoeWeights.
; (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 103 GigaSlash. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_GigaSlash:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIAndFoeLacksStatus3And4
    ld a, c
    and a
    ret z
    farcall ActorLacksStatus2Bit1And5Bits01
    ld a, c
    and a
    jr nz, .to_ai_score_multi_cut_damage_and_foe
    ld bc, $0033
    call AddAIWeightToScore2

.to_ai_score_multi_cut_damage_and_foe:
    jp AIScore_MultiCut_DamageAndFoeWeights

SECTION "Bank E2 AIScore_ChargeUp", ROMX

; ChargeUp's AI score: needs AIScore_ChargeUp_Conditions; then weight row $58 to wAISkillScore when
; PassIfFoeAverageDEFAtMostTwiceAllyATK gives 0; always weight row $BA to wAISkillScore and weight
; row $BF to wAISkillScore2; WeighLinkRules1RuleBit1. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 104 ChargeUp. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_ChargeUp:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_ChargeUp_Conditions
    ld a, c
    and a
    ret z
    farcall PassIfFoeAverageDEFAtMostTwiceAllyATK
    ld a, c
    cp $01
    jr z, .call_set_c_to_zero
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0058
    call AddAIWeight

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit1
    ld bc, $00ba
    call AddAIWeight
    ld bc, $00bf
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit1:
    call WeighLinkRules1RuleBit1
    ret

SECTION "Bank E2 AIScore_PsycheUp", ROMX

; PsycheUp's AI score: needs AIScore_PsycheUp_Conditions; then weight row $2D to wAISkillScore2 when
; FastestFoeAGLAbove31PercentOfActor gives 0; weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row $2C to wAISkillScore when
; AllyAverageAGLAtLeastFoes gives 0; weight row $0A to wAISkillScore2 when
; ActorLacksStatus1Bits23And4Bits01 gives 0; always weight row $BA to wAISkillScore and weight row
; $BF to wAISkillScore2; WeighLinkRules1RuleBit1. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 105 PsycheUp. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_PsycheUp:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_PsycheUp_Conditions
    ld a, c
    and a
    ret z
    farcall FastestFoeAGLAbove31PercentOfActor
    ld a, c
    and a
    jr nz, .call_check_lone_foe_hp_not_below_ai_damage
    ld bc, $002d
    call AddAIWeightToScore2

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_ally_average_agl_at_least_foes
    ld bc, $0007
    call AddAIWeightToScore2

.call_ally_average_agl_at_least_foes:
    farcall AllyAverageAGLAtLeastFoes
    ld a, c
    cp $01
    jr z, .call_actor_lacks_status1_bits23_and4_bits01
    and a
    jr nz, .call_actor_lacks_status1_bits23_and4_bits01
    ld bc, $002c
    call AddAIWeight

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $000a
    call AddAIWeightToScore2

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit1
    ld bc, $00ba
    call AddAIWeight
    ld bc, $00bf
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit1:
    call WeighLinkRules1RuleBit1
    ret

SECTION "Bank E2 AIScore_HighJump", ROMX

; HighJump's AI score: needs AIScore_HighJump_Conditions; then weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row $58 to wAISkillScore2 when
; PassIfFoeAverageDEFAtMostTwiceAllyATK gives 0; weight row $59 to wAISkillScore2 when
; PassIfTwiceATKAboveHighestFoeDEF gives 0; weight row $0A to wAISkillScore2 when
; ActorLacksStatus1Bits23And4Bits01 gives 0; WeighLinkRules1RuleBit1; weight row $33 to
; wAISkillScore2 when ActorLacksStatus2Bit1And5Bits01 gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 106 HighJump. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_HighJump:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_HighJump_Conditions
    ld a, c
    and a
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_pass_if_foe_average_def_at_most_twice
    ld bc, $0007
    call AddAIWeightToScore2

.call_pass_if_foe_average_def_at_most_twice:
    farcall PassIfFoeAverageDEFAtMostTwiceAllyATK
    ld a, c
    cp $01
    jr z, .call_pass_if_twice_atk_above_highest_foe_def
    and a
    jr nz, .call_pass_if_twice_atk_above_highest_foe_def
    ld bc, $0058
    call AddAIWeightToScore2

.call_pass_if_twice_atk_above_highest_foe_def:
    farcall PassIfTwiceATKAboveHighestFoeDEF
    ld a, c
    cp $01
    jr z, .call_actor_lacks_status1_bits23_and4_bits01
    and a
    jr nz, .call_actor_lacks_status1_bits23_and4_bits01
    ld bc, $0059
    call AddAIWeightToScore2

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit1
    ld bc, $000a
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit1:
    call WeighLinkRules1RuleBit1
    farcall ActorLacksStatus2Bit1And5Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_EvilSlash", ROMX

; EvilSlash's AI score: needs CheckSkillUsableElseResetAISkillScore; then weight row $5A to
; wAISkillScore when AnyFoeNotBlocked gives 0; weight row $5B to wAISkillScore when
; AnyFoeHasClearStatus3 gives 0; weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row $58 to wAISkillScore when
; PassIfFoeAverageDEFAtMostTwiceAllyATK gives 0; weight row $59 to wAISkillScore when
; PassIfTwiceATKAboveHighestFoeDEF gives 0; weight row $5C to wAISkillScore2 when
; ActorLacksStatus1Bits23And4Bits01 gives 0; always weight row $BD to wAISkillScore;
; WeighLinkRules1RuleBit1; weight row $B0 to wAISkillScore when AIScore_EvilSlash_CheckFoes gives 0;
; weight row $33 to wAISkillScore2 when ActorLacksStatus2Bit1And5Bits01 gives 0. (C2, E-0357; probed
; E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 107 EvilSlash. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_EvilSlash:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    farcall AnyFoeNotBlocked
    ld a, c
    and a
    jr nz, .call_any_foe_has_clear_status3
    ld bc, $005a
    call AddAIWeight

.call_any_foe_has_clear_status3:
    farcall AnyFoeHasClearStatus3
    ld a, c
    and a
    jr nz, .call_check_lone_foe_hp_not_below_ai_damage
    ld bc, $005b
    call AddAIWeight

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_pass_if_foe_average_def_at_most_twice
    ld bc, $0007
    call AddAIWeightToScore2

.call_pass_if_foe_average_def_at_most_twice:
    farcall PassIfFoeAverageDEFAtMostTwiceAllyATK
    ld a, c
    cp $01
    jr z, .call_pass_if_twice_atk_above_highest_foe_def
    and a
    jr nz, .call_pass_if_twice_atk_above_highest_foe_def
    ld bc, $0058
    call AddAIWeight

.call_pass_if_twice_atk_above_highest_foe_def:
    farcall PassIfTwiceATKAboveHighestFoeDEF
    ld a, c
    cp $01
    jr z, .call_actor_lacks_status1_bits23_and4_bits01
    and a
    jr nz, .call_actor_lacks_status1_bits23_and4_bits01
    ld bc, $0059
    call AddAIWeight

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $005c
    call AddAIWeightToScore2

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit1
    ld bc, $00bd
    call AddAIWeight

.call_weigh_link_rules1_rule_bit1:
    call WeighLinkRules1RuleBit1
    farcall AIScore_EvilSlash_CheckFoes
    ld a, c
    and a
    jr nz, .call_actor_lacks_status2_bit1_and5_bits01
    ld bc, $00b0
    call AddAIWeight

.call_actor_lacks_status2_bit1_and5_bits01:
    farcall ActorLacksStatus2Bit1And5Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_Massacre", ROMX

; Massacre's AI score: needs CheckSkillUsableElseResetAISkillScore; then weight row $11 to
; wAISkillScore2 when AtLeastTwoFoesPresent gives 0; weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; always weight row $C4 to wAISkillScore;
; WeighLinkRules1RuleBit1; weight row $33 to wAISkillScore2 when ActorLacksStatus2Bit1And5Bits01
; gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 108 Massacre. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Massacre:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    farcall AtLeastTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_check_lone_foe_hp_not_below_ai_damage
    ld bc, $0011
    call AddAIWeightToScore2

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0007
    call AddAIWeightToScore2

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit1
    ld bc, $00c4
    call AddAIWeight

.call_weigh_link_rules1_rule_bit1:
    call WeighLinkRules1RuleBit1
    farcall ActorLacksStatus2Bit1And5Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_TwinSlash", ROMX

; TwinSlash's AI score: needs AIScore_TwinSlash_Conditions; then weight row $5E to wAISkillScore2
; when AnyFoeLacksStatus0Bit6 gives 0; weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row $5F to wAISkillScore2 when
; PassIfFoeAverageDEFAtMostTwiceAllyATK gives 0; weight row $5F to wAISkillScore2 when
; PassIfTwiceATKAboveHighestFoeDEF gives 0; weight row $60 to wAISkillScore2 when ActorHPIsNotOne
; gives 0; weight row $5C to wAISkillScore2 when ActorLacksStatus1Bits23And4Bits01 gives 0; always
; weight row $C7 to wAISkillScore and weight row $D0 to wAISkillScore2; WeighLinkRules1RuleBit1;
; weight row $62 to wAISkillScore2 when AllyCheckSide0FlagAndOtherSlots gives 0; weight row $33 to
; wAISkillScore2 when ActorLacksStatus2Bit1And5Bits01 gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 109 TwinSlash. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_TwinSlash:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_TwinSlash_Conditions
    ld a, c
    and a
    ret z
    farcall AnyFoeLacksStatus0Bit6
    ld a, c
    and a
    jr nz, .call_check_lone_foe_hp_not_below_ai_damage
    ld bc, $005e
    call AddAIWeightToScore2

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_pass_if_foe_average_def_at_most_twice
    ld bc, $0007
    call AddAIWeightToScore2

.call_pass_if_foe_average_def_at_most_twice:
    farcall PassIfFoeAverageDEFAtMostTwiceAllyATK
    ld a, c
    cp $01
    jr z, .call_pass_if_twice_atk_above_highest_foe_def
    and a
    jr nz, .call_pass_if_twice_atk_above_highest_foe_def
    ld bc, $005f
    call AddAIWeightToScore2

.call_pass_if_twice_atk_above_highest_foe_def:
    farcall PassIfTwiceATKAboveHighestFoeDEF
    ld a, c
    cp $01
    jr z, .call_actor_hp_is_not_one
    and a
    jr nz, .call_actor_hp_is_not_one
    ld bc, $005f
    call AddAIWeightToScore2

.call_actor_hp_is_not_one:
    farcall ActorHPIsNotOne
    ld a, c
    and a
    jr nz, .call_actor_lacks_status1_bits23_and4_bits01
    ld bc, $0060
    call AddAIWeightToScore2

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $005c
    call AddAIWeightToScore2

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit1
    ld bc, $00c7
    call AddAIWeight
    ld bc, $00d0
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit1:
    call WeighLinkRules1RuleBit1
    farcall AllyCheckSide0FlagAndOtherSlots
    ld a, c
    and a
    jr nz, .call_actor_lacks_status2_bit1_and5_bits01
    ld bc, $0062
    call AddAIWeightToScore2

.call_actor_lacks_status2_bit1_and5_bits01:
    farcall ActorLacksStatus2Bit1And5Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_Berserker", ROMX

; Berserker's AI score: needs AIAttackSkillUsable_3 and MaxNegativeScoreWhenAIFlagBit0; then weight
; row $5A to wAISkillScore when AnyFoeNotBlocked gives 0; weight row $17 to wAISkillScore2 when
; AllOtherAlliesHaveStatus0Bit6 gives 0; weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row $5F to wAISkillScore2 when
; PassIfFoeAverageDEFAtMostTwiceAllyATK gives 0; weight row $5F to wAISkillScore2 when
; PassIfTwiceATKAboveHighestFoeDEF gives 0; weight row $60 to wAISkillScore2 when ActorHPIsNotOne
; gives 0; weight row $5C to wAISkillScore2 when ActorLacksStatus1Bits23And4Bits01 gives 0; always
; weight row $C7 to wAISkillScore and weight row $D0 to wAISkillScore2; WeighLinkRules1RuleBit1;
; weight row $63 to wAISkillScore2 when AllySlotsCheckThenFewerThanTwoFoes gives 0; weight row $5F
; to wAISkillScore2 when AllyCheckSide0FlagAndOtherSlots gives 0; weight row $64 to wAISkillScore
; when AIScore_Berserker_SpeedAndHPCheck gives 0; weight row $33 to wAISkillScore2 when
; ActorLacksStatus2Bit1And5Bits01 gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 110 Berserker. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Berserker:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIAttackSkillUsable_3
    ld a, c
    and a
    ret z
    call MaxNegativeScoreWhenAIFlagBit0
    ret z
    farcall AnyFoeNotBlocked
    ld a, c
    and a
    jr nz, .call_all_other_allies_have_status0_bit6
    ld bc, $005a
    call AddAIWeight

.call_all_other_allies_have_status0_bit6:
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a
    jr nz, .call_check_lone_foe_hp_not_below_ai_damage
    ld bc, $0017
    call AddAIWeightToScore2

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_pass_if_foe_average_def_at_most_twice
    ld bc, $0007
    call AddAIWeightToScore2

.call_pass_if_foe_average_def_at_most_twice:
    farcall PassIfFoeAverageDEFAtMostTwiceAllyATK
    ld a, c
    cp $01
    jr z, .call_pass_if_twice_atk_above_highest_foe_def
    and a
    jr nz, .call_pass_if_twice_atk_above_highest_foe_def
    ld bc, $005f
    call AddAIWeightToScore2

.call_pass_if_twice_atk_above_highest_foe_def:
    farcall PassIfTwiceATKAboveHighestFoeDEF
    ld a, c
    cp $01
    jr z, .call_actor_hp_is_not_one
    and a
    jr nz, .call_actor_hp_is_not_one
    ld bc, $005f
    call AddAIWeightToScore2

.call_actor_hp_is_not_one:
    farcall ActorHPIsNotOne
    ld a, c
    and a
    jr nz, .call_actor_lacks_status1_bits23_and4_bits01
    ld bc, $0060
    call AddAIWeightToScore2

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $005c
    call AddAIWeightToScore2

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit1
    ld bc, $00c7
    call AddAIWeight
    ld bc, $00d0
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit1:
    call WeighLinkRules1RuleBit1
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a
    jr nz, .call_ally_check_side0_flag_and_other_slots
    ld bc, $0063
    call AddAIWeightToScore2

.call_ally_check_side0_flag_and_other_slots:
    farcall AllyCheckSide0FlagAndOtherSlots
    ld a, c
    and a
    jr nz, .call_ai_score_berserker_speed_and_hp_check
    ld bc, $005f
    call AddAIWeightToScore2

.call_ai_score_berserker_speed_and_hp_check:
    farcall AIScore_Berserker_SpeedAndHPCheck
    ld a, c
    cp $01
    jr z, .call_actor_lacks_status2_bit1_and5_bits01
    and a
    jr nz, .call_actor_lacks_status2_bit1_and5_bits01
    ld bc, $0064
    call AddAIWeight

.call_actor_lacks_status2_bit1_and5_bits01:
    farcall ActorLacksStatus2Bit1And5Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_Ramming", ROMX

; Ramming's AI score: needs AIAndAnyFoeNotFullyResistantAndActorHPNotOne; then weight row $5E to
; wAISkillScore2 when AnyFoeLacksStatus0Bit6 gives 0; weight row $17 to wAISkillScore2 when
; AllOtherAlliesHaveStatus0Bit6 gives 0; weight row $64 to wAISkillScore when
; AIScore_Ramming_LastFoeHPAndResist gives 0; then goes on at AIScore_Ramming_HPAndStatusWeights.
; (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 111 Ramming. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Ramming:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIAndAnyFoeNotFullyResistantAndActorHPNotOne
    ld a, c
    and a
    ret z
    farcall AnyFoeLacksStatus0Bit6
    ld a, c
    and a
    jr nz, .call_all_other_allies_have_status0_bit6
    ld bc, $005e
    call AddAIWeightToScore2

.call_all_other_allies_have_status0_bit6:
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a
    jr nz, .call_ai_score_ramming_last_foe_hp_and_resist
    ld bc, $0017
    call AddAIWeightToScore2

.call_ai_score_ramming_last_foe_hp_and_resist:
    farcall AIScore_Ramming_LastFoeHPAndResist
    ld a, c
    cp $01
    jr z, AIScore_Ramming_HPAndStatusWeights
    and a
    jr nz, AIScore_Ramming_HPAndStatusWeights
    ld bc, $0064
    call AddAIWeight

; Shared second half of the scores of 'Ramming' and 'Kamikaze' (both continue into it), ending in
; ret. Adds row $07 to wAISkillScore2 when CheckLoneFoeHPNotBelowAIDamageEstimates gives 0, row $09
; when PassIfFoesAverageResistanceAtLeast2 gives 0, runs AIScore_Ramming_WeighHPBand with A =
; wBattleActor, adds row $5C to wAISkillScore2 when ActorLacksStatus1Bits23And4Bits01 gives 0,
; always adds row $C7 to wAISkillScore and row $D0 to wAISkillScore2, calls WeighLinkRules1RuleBit1,
; adds row $5F to wAISkillScore2 when AllyCheckSide0FlagAndOtherSlots gives 0 and row $33 to
; wAISkillScore2 when ActorLacksStatus2Bit1And5Bits01 gives 0. (C2, E-0385)
AIScore_Ramming_HPAndStatusWeights::
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $0007
    call AddAIWeightToScore2

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a
    jr nz, .read_battle_actor
    ld bc, $0009
    call AddAIWeight

.read_battle_actor:
    ld a, [wBattleActor]
    call AIScore_Ramming_WeighHPBand
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $005c
    call AddAIWeightToScore2

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit1
    ld bc, $00c7
    call AddAIWeight
    ld bc, $00d0
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit1:
    call WeighLinkRules1RuleBit1
    farcall AllyCheckSide0FlagAndOtherSlots
    ld a, c
    and a
    jr nz, .call_actor_lacks_status2_bit1_and5_bits01
    ld bc, $005f
    call AddAIWeightToScore2

.call_actor_lacks_status2_bit1_and5_bits01:
    farcall ActorLacksStatus2Bit1And5Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_Kamikaze", ROMX

; Kamikaze's AI score: needs AIScore_Kamikaze_Conditions; then weight row $64 to wAISkillScore when
; AIScore_Kamikaze_HealerAllyAndFoeHP gives 0; then goes on at AIScore_Ramming_HPAndStatusWeights.
; (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 112 Kamikaze. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Kamikaze:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_Kamikaze_Conditions
    ld a, c
    and a
    ret z
    farcall AIScore_Kamikaze_HealerAllyAndFoeHP
    ld a, c
    cp $01
    jr z, .to_ai_score_ramming_hp_and_status_weights
    and a
    jr nz, .to_ai_score_ramming_hp_and_status_weights
    ld bc, $0064
    call AddAIWeight

.to_ai_score_ramming_hp_and_status_weights:
    jp AIScore_Ramming_HPAndStatusWeights

SECTION "Bank E2 AIScore_SleepAir", ROMX

; SleepAir's AI score: needs AIScore_SleepAir_Conditions; then always weight row $BC to
; wAISkillScore2; then goes on at AIScore_SleepAir_CommonWeights. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 113 SleepAir. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_SleepAir:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_SleepAir_Conditions
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, AIScore_SleepAir_CommonWeights
    ld bc, $00bc
    call AddAIWeightToScore2

; The shared scoring of AIScore_SleepAir, AIScore_PalsyAir, AIScore_PoisonGas and AIScore_PoisonAir
; after their conditions: weighs link rule bit 3 (WeighLinkRules1RuleBit3), then falls into
; AIScore_SleepAir_FoeCountAndResistWeights for the foe-count and resistance weights. (C2, E-0371;
; probed E-0385)
AIScore_SleepAir_CommonWeights::
    call WeighLinkRules1RuleBit3

; Shared last part of the scores of 'SleepAir', 'PalsyAir', 'PoisonGas' and 'PoisonAir' (through
; AIScore_SleepAir_CommonWeights) and 'Curse' (which jumps here), ending in ret. Adds row $15 when
; FewerThanTwoFoesPresent gives 0, row $12 to wAISkillScore2 when FailIfSkillHasResistanceClass
; gives 0, and row $09 when ResistanceAverageGateForAISide gives 0 and again when
; ResistanceAverageGateForFoeAIMode3 gives 0. (C2, E-0385)
AIScore_SleepAir_FoeCountAndResistWeights::
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_fail_if_skill_has_resistance_class
    ld bc, $0015
    call AddAIWeight

.call_fail_if_skill_has_resistance_class:
    farcall FailIfSkillHasResistanceClass
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AddAIWeightToScore2

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AddAIWeight

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0009
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_PalsyAir", ROMX

; PalsyAir's AI score: needs AIScore_PalsyAir_Conditions; then goes on at
; AIScore_SleepAir_CommonWeights. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 114 PalsyAir. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_PalsyAir:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_PalsyAir_Conditions
    ld a, c
    and a
    ret z
    jr AIScore_SleepAir_CommonWeights

SECTION "Bank E2 AIScore_PoisonGas", ROMX

; PoisonGas' AI score: needs AIScore_PoisonGas_Conditions; then goes on at
; AIScore_SleepAir_CommonWeights. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 115 PoisonGas. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_PoisonGas:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_PoisonGas_Conditions
    ld a, c
    and a
    ret z
    jr AIScore_SleepAir_CommonWeights

SECTION "Bank E2 AIScore_PoisonAir", ROMX

; PoisonAir's AI score: needs AIScore_PoisonAir_Conditions; then goes on at
; AIScore_SleepAir_CommonWeights. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 116 PoisonAir. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_PoisonAir:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_PoisonAir_Conditions
    ld a, c
    and a
    ret z
    jr AIScore_SleepAir_CommonWeights

SECTION "Bank E2 AIScore_Curse", ROMX

; Curse's AI score: needs AIScore_Curse_Conditions; then always weight row $BD to wAISkillScore2;
; WeighLinkRules1RuleBit5; then goes on at AIScore_SleepAir_FoeCountAndResistWeights. (C2, E-0357;
; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 117 Curse. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Curse:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_Curse_Conditions
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $00bd
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    jp AIScore_SleepAir_FoeCountAndResistWeights

SECTION "Bank E2 AIScore_OddDance", ROMX

; OddDance's AI score: needs AIScore_OddDance_Conditions; then always weight row $09 to
; wAISkillScore; always weight row $C2 to wAISkillScore2 and weight row $D2 to wAISkillScore;
; WeighLinkRules1RuleBit2; weight row $09 to wAISkillScore when ResistanceAverageGateForAISide gives
; 0; weight row $09 to wAISkillScore when ResistanceAverageGateForFoeAIMode3 gives 0. (C2, E-0357;
; probed E-0385)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 118 OddDance, 119 RobDance. It runs checks and
; adds weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_OddDance:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_OddDance_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0009
    call AddAIWeight
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit2
    ld bc, $00c2
    call AddAIWeightToScore2
    ld bc, $00d2
    call AddAIWeight

.call_weigh_link_rules1_rule_bit2:
    call WeighLinkRules1RuleBit2
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AddAIWeight

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0009
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_PaniDance", ROMX

; PaniDance's AI score: needs AIScore_PaniDance_Conditions; then always weight row $C2 to
; wAISkillScore2 and weight row $CA to wAISkillScore and weight row $D2 to wAISkillScore;
; WeighLinkRules1RuleBit2; weight row $15 to wAISkillScore when FewerThanTwoFoesPresent gives 0;
; weight row $12 to wAISkillScore2 when FailIfSkillHasResistanceClass gives 0; weight row $09 to
; wAISkillScore when ResistanceAverageGateForAISide gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForFoeAIMode3 gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 120 PaniDance. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_PaniDance:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_PaniDance_Conditions
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit2
    ld bc, $00c2
    call AddAIWeightToScore2
    ld bc, $00ca
    call AddAIWeight
    ld bc, $00d2
    call AddAIWeight

.call_weigh_link_rules1_rule_bit2:
    call WeighLinkRules1RuleBit2
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_fail_if_skill_has_resistance_class
    ld bc, $0015
    call AddAIWeight

.call_fail_if_skill_has_resistance_class:
    farcall FailIfSkillHasResistanceClass
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AddAIWeightToScore2

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AddAIWeight

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0009
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_KODance", ROMX

; KODance's AI score: needs AIScore_KODance_Conditions; then always weight row $CD to wAISkillScore
; and weight row $CF to wAISkillScore2; WeighLinkRules1RuleBit2; weight row $15 to wAISkillScore
; when FewerThanTwoFoesPresent gives 0; weight row $B5 to wAISkillScore when
; AIGateFoeSlotResistances2Bits45 gives 0; weight row $12 to wAISkillScore2 when
; FailIfSkillHasResistanceClass gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForAISide gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForFoeAIMode3 gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 121 K.O.Dance. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_KODance:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_KODance_Conditions
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit2
    ld bc, $00cd
    call AddAIWeight
    ld bc, $00cf
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit2:
    call WeighLinkRules1RuleBit2
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_ai_gate_foe_slot_resistances2_bits45
    ld bc, $0015
    call AddAIWeight

.call_ai_gate_foe_slot_resistances2_bits45:
    farcall AIGateFoeSlotResistances2Bits45
    ld a, c
    cp $01
    jr z, .call_fail_if_skill_has_resistance_class
    and a
    jr nz, .call_fail_if_skill_has_resistance_class
    ld bc, $00b5
    call AddAIWeight

.call_fail_if_skill_has_resistance_class:
    farcall FailIfSkillHasResistanceClass
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AddAIWeightToScore2

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AddAIWeight

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0009
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_LureDance_UnreferencedVariant", ROMX

; Not used by the game: AIScoreRoutineTableA and AIScoreRoutineTableB hold the same 201 entries,
; none points here, and nothing in src calls it. It calls AIScore_LureDance and returns if that
; gives C = 0 (its conditions failed). Otherwise it calls AIAddScoresForTwoLists, which
; AIScore_LureDance already ends with, so that call, and any row it adds (row $B1 to wAISkillScore
; when AIAddScoresForTwoLists_SealingFoes gives 0, row $B2 when AIAddScoresForTwoLists_OtherAllies
; gives 0), happens twice. (C2, E-0385)
; table-B AI score: AIScore_LureDance, then AIAddScoresForTwoLists when usable (E-0122)
AIScore_LureDance_UnreferencedVariant:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    call AIScore_LureDance
    ld a, c
    and a
    ret z
    call AIAddScoresForTwoLists
    ret

SECTION "Bank E2 AIScore_LureDance", ROMX

; AI score of 'LureDance' (skill 122, entry of both tables). Returns C = 0 at once unless
; AIScore_LureDance_Conditions gives non-zero. Then always adds row $C2 to wAISkillScore2 and row
; $D2 to wAISkillScore, calls WeighLinkRules1RuleBit2, adds row $15 when FewerThanTwoFoesPresent
; gives 0, row $12 to wAISkillScore2 when FailIfSkillHasResistanceClass gives 0, row $09 when
; ResistanceAverageGateForAISide gives 0 and row $09 again when ResistanceAverageGateForFoeAIMode3
; gives 0, and ends with AIAddScoresForTwoLists. Returns C = 1 after a full run. (C2, E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 122 LureDance. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_LureDance::
    farcall AIScore_LureDance_Conditions
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit2
    ld bc, $00c2
    call AddAIWeightToScore2
    ld bc, $00d2
    call AddAIWeight

.call_weigh_link_rules1_rule_bit2:
    call WeighLinkRules1RuleBit2
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_fail_if_skill_has_resistance_class
    ld bc, $0015
    call AddAIWeight

.call_fail_if_skill_has_resistance_class:
    farcall FailIfSkillHasResistanceClass
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AddAIWeightToScore2

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AddAIWeight

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .call_ai_add_scores_for_two_lists
    and a
    jr nz, .call_ai_add_scores_for_two_lists
    ld bc, $0009
    call AddAIWeight

.call_ai_add_scores_for_two_lists:
    call AIAddScoresForTwoLists
    ld c, $01
    ret

SECTION "Bank E2 AIScore_LifeDance", ROMX

; LifeDance's AI score: needs AIScore_LifeDance_Conditions; then always weight row $BC to
; wAISkillScore and weight row $C4 to wAISkillScore2; WeighLinkRules1RuleBit2; weight row $29 to
; wAISkillScore when AllySlotsCheckThenFewerThanTwoFoes gives 0; weight row $29 to wAISkillScore
; when PassIfSideFlagOrOtherAllyPresent gives 0; weight row $2E to wAISkillScore2 when
; AIGateCompareAllyStatAverages gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 123 LifeDance. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_LifeDance:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_LifeDance_Conditions
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit2
    ld bc, $00bc
    call AddAIWeight
    ld bc, $00c4
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit2:
    call WeighLinkRules1RuleBit2
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a
    jr nz, .call_pass_if_side_flag_or_other_ally_present
    ld bc, $0029
    call AddAIWeight

.call_pass_if_side_flag_or_other_ally_present:
    farcall PassIfSideFlagOrOtherAllyPresent
    ld a, c
    and a
    jr nz, .call_ai_gate_compare_ally_stat_averages
    ld bc, $0029
    call AddAIWeight

.call_ai_gate_compare_ally_stat_averages:
    farcall AIGateCompareAllyStatAverages
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $002e
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_Hustle", ROMX

; Hustle's AI score: needs AIScore_Hustle_Conditions; then ForEachPresentSlotOfSideRun; weight row
; $1A to wAISkillScore when AnyFoeLacksStatus0MaskCC gives 0; weight row $1A to wAISkillScore when
; AnyFoeHasClearStatus3 gives 0; weight row $1B to wAISkillScore2 when AnyAllyHPAtMostThreeQuarters
; gives 0; weight row $23 to wAISkillScore when ActorHPIsNotOne gives 0; weight row $23 to
; wAISkillScore when FewerThanTwoAlliesAtHP1 gives 0; always weight row $24 to wAISkillScore;
; WeighLinkRules1RuleBit2; weight row $69 to wAISkillScore when FailIfTwoAlliesBelowHalfHP gives 0.
; (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 124 Hustle. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Hustle:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_Hustle_Conditions
    ld a, c
    and a
    ret z
    ld a, [wBattleActor]
    call ForEachPresentSlotOfSideRun
    farcall AnyFoeLacksStatus0MaskCC
    ld a, c
    and a
    jr nz, .call_any_foe_has_clear_status3
    ld bc, $001a
    call AddAIWeight

.call_any_foe_has_clear_status3:
    farcall AnyFoeHasClearStatus3
    ld a, c
    and a
    jr nz, .call_any_ally_hp_at_most_three_quarters
    ld bc, $001a
    call AddAIWeight

.call_any_ally_hp_at_most_three_quarters:
    farcall AnyAllyHPAtMostThreeQuarters
    ld a, c
    and a
    jr nz, .call_actor_hp_is_not_one
    ld bc, $001b
    call AddAIWeightToScore2

.call_actor_hp_is_not_one:
    farcall ActorHPIsNotOne
    ld a, c
    and a
    jr nz, .call_fewer_than_two_allies_at_hp1
    ld bc, $0023
    call AddAIWeight

.call_fewer_than_two_allies_at_hp1:
    farcall FewerThanTwoAlliesAtHP1
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0023
    call AddAIWeight

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit2
    ld bc, $0024
    call AddAIWeight

.call_weigh_link_rules1_rule_bit2:
    call WeighLinkRules1RuleBit2
    farcall FailIfTwoAlliesBelowHalfHP
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0069
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_SideStep", ROMX

; SideStep's AI score: needs AIScore_SideStep_Conditions; then weight row $6C to wAISkillScore2 when
; AnyFoeLacksStatus5Bits01And1Bit1 gives 0; weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row $6D to wAISkillScore when
; PassIfFoeAverageATKAtMostTwiceAllyDEF gives 0; always weight row $BE to wAISkillScore;
; WeighLinkRules1RuleBit2; weight row $32 to wAISkillScore when CompareFoeAverageATKWithAllyDEF
; gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 125 SideStep. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_SideStep:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_SideStep_Conditions
    ld a, c
    and a
    ret z
    farcall AnyFoeLacksStatus5Bits01And1Bit1
    ld a, c
    and a
    jr nz, .call_check_lone_foe_hp_not_below_ai_damage
    ld bc, $006c
    call AddAIWeightToScore2

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_pass_if_foe_average_atk_at_most_twice
    ld bc, $0007
    call AddAIWeightToScore2

.call_pass_if_foe_average_atk_at_most_twice:
    farcall PassIfFoeAverageATKAtMostTwiceAllyDEF
    ld a, c
    cp $01
    jr z, .call_set_c_to_zero
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $006d
    call AddAIWeight

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit2
    ld bc, $00be
    call AddAIWeight

.call_weigh_link_rules1_rule_bit2:
    call WeighLinkRules1RuleBit2
    farcall CompareFoeAverageATKWithAllyDEF
    ld a, c
    and a
    jr nz, .return
    ld bc, $0032
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_SandStorm", ROMX

; AI score of 'SandStorm' (skill 126, entry of both tables). Returns at once unless
; AIScore_SandStorm_Conditions gives non-zero, then falls into
; AIScore_SandStorm_DamageAndATKWeights, which adds all of its weights. (C2, E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 126 SandStorm. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_SandStorm:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_SandStorm_Conditions
    ld a, c
    and a
    ret z

; Shared second half of the scores of 'SandStorm' (which falls into it) and 'Radiant' (which jumps
; to it), ending in ret. Adds row $07 to wAISkillScore2 when CheckLoneFoeHPNotBelowAIDamageEstimates
; gives 0, row $6D when PassIfFoeAverageATKAtMostTwiceAllyDEF gives 0, always row $BA to
; wAISkillScore2, calls WeighLinkRules1RuleBit5, adds row $15 when FewerThanTwoFoesPresent gives 0,
; row $32 when CompareFoeAverageATKWithAllyDEF gives 0, row $12 to wAISkillScore2 when
; FailIfSkillHasResistanceClass gives 0, and row $09 when ResistanceAverageGateForAISide gives 0 and
; again when ResistanceAverageGateForFoeAIMode3 gives 0. (C2, E-0385)
AIScore_SandStorm_DamageAndATKWeights::
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_pass_if_foe_average_atk_at_most_twice
    ld bc, $0007
    call AddAIWeightToScore2

.call_pass_if_foe_average_atk_at_most_twice:
    farcall PassIfFoeAverageATKAtMostTwiceAllyDEF
    ld a, c
    cp $01
    jr z, .call_set_c_to_zero
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $006d
    call AddAIWeight

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $00ba
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_compare_foe_average_atk_with_ally_def
    ld bc, $0015
    call AddAIWeight

.call_compare_foe_average_atk_with_ally_def:
    farcall CompareFoeAverageATKWithAllyDEF
    ld a, c
    and a
    jr nz, .call_fail_if_skill_has_resistance_class
    ld bc, $0032
    call AddAIWeight

.call_fail_if_skill_has_resistance_class:
    farcall FailIfSkillHasResistanceClass
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AddAIWeightToScore2

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AddAIWeight

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0009
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_Radiant", ROMX

; Radiant's AI score: needs AIScore_Radiant_Conditions; then goes on at
; AIScore_SandStorm_DamageAndATKWeights. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 127 Radiant. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Radiant:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_Radiant_Conditions
    ld a, c
    and a
    ret z
    jp AIScore_SandStorm_DamageAndATKWeights

SECTION "Bank E2 AIScore_EerieLite", ROMX

; EerieLite's AI score: needs AIScore_EerieLite_Conditions; then always weight row $CC to
; wAISkillScore and weight row $D1 to wAISkillScore2; WeighLinkRules1RuleBit5; weight row $15 to
; wAISkillScore when FewerThanTwoFoesPresent gives 0; weight row $12 to wAISkillScore2 when
; FailIfSkillHasResistanceClass gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForAISide gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForFoeAIMode3 gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 128 EerieLite. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_EerieLite:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_EerieLite_Conditions
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $00cc
    call AddAIWeight
    ld bc, $00d1
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_fail_if_skill_has_resistance_class
    ld bc, $0015
    call AddAIWeight

.call_fail_if_skill_has_resistance_class:
    farcall FailIfSkillHasResistanceClass
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AddAIWeightToScore2

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AddAIWeight

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0009
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_Surge", ROMX

; Surge's AI score: needs AIScore_Surge_Conditions; then always weight row $6F to wAISkillScore;
; always weight row $CA to wAISkillScore2; WeighLinkRules1RuleBit4. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 129 Surge. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Surge:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_Surge_Conditions
    ld a, c
    and a
    ret z
    ld bc, $006f
    call AddAIWeight
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit4
    ld bc, $00ca
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit4:
    call WeighLinkRules1RuleBit4
    ret

SECTION "Bank E2 AIScore_UltraDown", ROMX

; UltraDown's AI score: needs AIScore_UltraDown_Conditions; then always weight row $6F to
; wAISkillScore; always weight row $CC to wAISkillScore; WeighLinkRules1RuleBit5. (C2, E-0357;
; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 130 UltraDown. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_UltraDown:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_UltraDown_Conditions
    ld a, c
    and a
    ret z
    ld bc, $006f
    call AddAIWeight
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $00cc
    call AddAIWeight

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    ret

SECTION "Bank E2 AIScore_DeMagic", ROMX

; DeMagic's AI score: needs AIScore_DeMagic_Conditions; then always weight row $71 to wAISkillScore;
; weight row $70 to wAISkillScore when AnyFoeLacksStatus5Bits67 gives 0; always weight row $C9 to
; wAISkillScore2 and weight row $CB to wAISkillScore; WeighLinkRules1RuleBit5. (C2, E-0357; probed
; E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 131 DeMagic. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_DeMagic:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_DeMagic_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0071
    call AddAIWeight
    farcall AnyFoeLacksStatus5Bits67
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0070
    call AddAIWeight

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $00c9
    call AddAIWeightToScore2
    ld bc, $00cb
    call AddAIWeight

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    ret

SECTION "Bank E2 AIScore_ThickFog", ROMX

; ThickFog's AI score: needs AIScore_ThickFog_Conditions; then always weight row $C9 to
; wAISkillScore; WeighLinkRules1RuleBit5; weight row $72 to wAISkillScore when
; FailIfFoeKnowsSkillList gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 132 ThickFog. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_ThickFog:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_ThickFog_Conditions
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $00c9
    call AddAIWeight

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    farcall FailIfFoeKnowsSkillList
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0072
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_TatsuCall", ROMX

; TatsuCall's AI score: needs AIScore_TatsuCall_Conditions; then weight row $73 to wAISkillScore
; when AllOtherAlliesHaveStatus0Bit6 gives 0; weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; always weight row $74 to wAISkillScore and weight
; row $BB to wAISkillScore and weight row $C7 to wAISkillScore2; WeighLinkRules1RuleBit5; weight row
; $75 to wAISkillScore when AllySlotsCheckThenFewerThanTwoFoes gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 4 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 133 TatsuCall, 134 DiagoCall, 135 SamsiCall, 136
; BazooCall. It runs checks and adds weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70)
; (E-0083)
AIScore_TatsuCall:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_TatsuCall_Conditions
    ld a, c
    and a
    ret z
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a
    jr nz, .call_check_lone_foe_hp_not_below_ai_damage
    ld bc, $0073
    call AddAIWeight

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0007
    call AddAIWeightToScore2

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $0074
    call AddAIWeight
    ld bc, $00bb
    call AddAIWeight
    ld bc, $00c7
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a
    jr nz, .return
    ld bc, $0075
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_SuckAir", ROMX

; SuckAir's AI score: needs AIScore_SuckAir_Conditions; then weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; always weight row $76 to wAISkillScore;
; WeighLinkRules1RuleBit3; weight row $77 to wAISkillScore2 when AnyAllyLacksStatus2Bit2_2 gives 0.
; (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 137 SuckAir. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_SuckAir:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_SuckAir_Conditions
    ld a, c
    and a
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0007
    call AddAIWeightToScore2

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit3
    ld bc, $0076
    call AddAIWeight

.call_weigh_link_rules1_rule_bit3:
    call WeighLinkRules1RuleBit3
    farcall AnyAllyLacksStatus2Bit2_2
    ld a, c
    and a
    jr nz, .return
    ld bc, $0077
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_Focus", ROMX

; Focus' AI score: needs AIScore_Focus_Conditions; then weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; always weight row $C2 to wAISkillScore and weight
; row $D2 to wAISkillScore2; WeighLinkRules1RuleBit5. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 138 Focus. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Focus:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_Focus_Conditions
    ld a, c
    and a
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0007
    call AddAIWeightToScore2

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $00c2
    call AddAIWeight
    ld bc, $00d2
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    ret

SECTION "Bank E2 AIScore_LushLicks_UnreferencedVariant", ROMX

; Not used by the game: AIScoreRoutineTableA and AIScoreRoutineTableB hold the same 201 entries,
; none points here, and nothing in src calls it. It calls AIScore_LushLicks and returns if that
; gives C = 0 (its conditions failed). Otherwise it calls AIAddScoresForTwoLists, which
; AIScore_LushLicks already ends with, so that call, and any row it adds (row $B1 to wAISkillScore
; when AIAddScoresForTwoLists_SealingFoes gives 0, row $B2 when AIAddScoresForTwoLists_OtherAllies
; gives 0), happens twice. (C2, E-0385)
; table-B AI score: AIScore_LushLicks, then AIAddScoresForTwoLists when usable (E-0122)
AIScore_LushLicks_UnreferencedVariant:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    call AIScore_LushLicks
    ld a, c
    and a
    ret z
    call AIAddScoresForTwoLists
    ret

SECTION "Bank E2 AIScore_LushLicks", ROMX

; AI score of 'LushLicks' (skill 139, entry of both tables). Returns C = 0 at once unless
; AILickSkillUsable gives non-zero. Then always adds row $78 to wAISkillScore, calls
; WeighLinkRules1RuleBit5, adds row $09 when ResistanceAverageGateForAISide gives 0 and row $09
; again when ResistanceAverageGateForFoeAIMode3 gives 0, and ends with AIAddScoresForTwoLists.
; Returns C = 1 after a full run. (C2, E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 139 LushLicks. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_LushLicks::
    farcall AILickSkillUsable
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $0078
    call AddAIWeight

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AddAIWeight

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .call_ai_add_scores_for_two_lists
    and a
    jr nz, .call_ai_add_scores_for_two_lists
    ld bc, $0009
    call AddAIWeight

.call_ai_add_scores_for_two_lists:
    call AIAddScoresForTwoLists
    ld c, $01
    ret

SECTION "Bank E2 AIScore_SickLick", ROMX

; SickLick's AI score: needs AIStatusLickUsable; then weight row $79 to wAISkillScore2 when
; AnyFoeHasDEFAtLeast2 gives 0; weight row $2C to wAISkillScore when
; PassIfFoeAverageDEFAtMostTwiceAllyATK gives 0; weight row $2C to wAISkillScore when
; PassIfTwiceATKAboveHighestFoeDEF gives 0; always weight row $78 to wAISkillScore;
; WeighLinkRules1RuleBit5; weight row $09 to wAISkillScore when ResistanceAverageGateForAISide gives
; 0; weight row $09 to wAISkillScore when ResistanceAverageGateForFoeAIMode3 gives 0;
; AIAddScoresForTwoLists. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 140 SickLick. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_SickLick:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIStatusLickUsable
    ld a, c
    and a
    ret z
    farcall AnyFoeHasDEFAtLeast2
    ld a, c
    and a
    jr nz, .call_pass_if_foe_average_def_at_most_twice
    ld bc, $0079
    call AddAIWeightToScore2

.call_pass_if_foe_average_def_at_most_twice:
    farcall PassIfFoeAverageDEFAtMostTwiceAllyATK
    ld a, c
    cp $01
    jr z, .call_pass_if_twice_atk_above_highest_foe_def
    and a
    jr nz, .call_pass_if_twice_atk_above_highest_foe_def
    ld bc, $002c
    call AddAIWeight

.call_pass_if_twice_atk_above_highest_foe_def:
    farcall PassIfTwiceATKAboveHighestFoeDEF
    ld a, c
    cp $01
    jr z, .call_set_c_to_zero
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $002c
    call AddAIWeight

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $0078
    call AddAIWeight

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AddAIWeight

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .call_ai_add_scores_for_two_lists
    and a
    jr nz, .call_ai_add_scores_for_two_lists
    ld bc, $0009
    call AddAIWeight

.call_ai_add_scores_for_two_lists:
    call AIAddScoresForTwoLists
    ret

SECTION "Bank E2 AIScore_LegSweep_UnreferencedVariant", ROMX

; Not used by the game: AIScoreRoutineTableA and AIScoreRoutineTableB hold the same 201 entries,
; none points here, and nothing in src calls it. It calls AIScore_LegSweep and returns if that gives
; C = 0 (its conditions failed). Otherwise it calls AIAddScoresForTwoLists, which AIScore_LegSweep
; already ends with, so that call, and any row it adds (row $B1 to wAISkillScore when
; AIAddScoresForTwoLists_SealingFoes gives 0, row $B2 when AIAddScoresForTwoLists_OtherAllies gives
; 0), happens twice. (C2, E-0385)
; table-B AI score: AIScore_LegSweep, then AIAddScoresForTwoLists when usable (E-0122)
AIScore_LegSweep_UnreferencedVariant:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    call AIScore_LegSweep
    ld a, c
    and a
    ret z
    call AIAddScoresForTwoLists
    ret

SECTION "Bank E2 AIScore_LegSweep", ROMX

; LegSweep's AI score: needs AIScore_LegSweep_Conditions; then always weight row $7B to
; wAISkillScore; WeighLinkRules1RuleBit5; weight row $09 to wAISkillScore when
; ResistanceAverageGateForAISide gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForFoeAIMode3 gives 0; AIAddScoresForTwoLists; returns C = 1. (C2, E-0357;
; probed E-0385)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 141 LegSweep, 142 BigTrip. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_LegSweep::
    farcall AIScore_LegSweep_Conditions
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $007b
    call AddAIWeight

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AddAIWeight

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .call_ai_add_scores_for_two_lists
    and a
    jr nz, .call_ai_add_scores_for_two_lists
    ld bc, $0009
    call AddAIWeight

.call_ai_add_scores_for_two_lists:
    call AIAddScoresForTwoLists
    ld c, $01
    ret

SECTION "Bank E2 AIScore_Ahhh_UnreferencedVariant", ROMX

; Not used by the game: AIScoreRoutineTableA and AIScoreRoutineTableB hold the same 201 entries,
; none points here, and nothing in src calls it. It calls AIScore_Ahhh and returns if that gives C =
; 0 (its conditions failed). Otherwise it calls AIAddScoresForTwoLists, which AIScore_Ahhh already
; ends with, so that call, and any row it adds (row $B1 to wAISkillScore when
; AIAddScoresForTwoLists_SealingFoes gives 0, row $B2 when AIAddScoresForTwoLists_OtherAllies gives
; 0), happens twice. (C2, E-0385)
; table-B AI score: AIScore_Ahhh, then AIAddScoresForTwoLists when usable (E-0122)
AIScore_Ahhh_UnreferencedVariant:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    call AIScore_Ahhh
    ld a, c
    and a
    ret z
    call AIAddScoresForTwoLists
    ret

SECTION "Bank E2 AIScore_Ahhh", ROMX

; Ahhh's AI score: needs AILickSkillUsable; then always weight row $C0 to wAISkillScore and weight
; row $C3 to wAISkillScore2 and weight row $CE to wAISkillScore2 and weight row $D3 to
; wAISkillScore; WeighLinkRules1RuleBit5; weight row $09 to wAISkillScore when
; ResistanceAverageGateForAISide gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForFoeAIMode3 gives 0; AIAddScoresForTwoLists; returns C = 1. (C2, E-0357;
; probed E-0385)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 143 Ahhh, 144 WarCry. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_Ahhh::
    farcall AILickSkillUsable
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $00c0
    call AddAIWeight
    ld bc, $00c3
    call AddAIWeightToScore2
    ld bc, $00ce
    call AddAIWeightToScore2
    ld bc, $00d3
    call AddAIWeight

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AddAIWeight

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .call_ai_add_scores_for_two_lists
    and a
    jr nz, .call_ai_add_scores_for_two_lists
    ld bc, $0009
    call AddAIWeight

.call_ai_add_scores_for_two_lists:
    call AIAddScoresForTwoLists
    ld c, $01
    ret

SECTION "Bank E2 AIScore_Geyser", ROMX

; Geyser's AI score: needs AIScore_Geyser_Conditions; then always weight row $7D to wAISkillScore;
; WeighLinkRules1RuleBit5; weight row $09 to wAISkillScore when ResistanceAverageGateForAISide gives
; 0; weight row $09 to wAISkillScore when ResistanceAverageGateForFoeAIMode3 gives 0. (C2, E-0357;
; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 145 Geyser. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Geyser:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_Geyser_Conditions
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $007d
    call AddAIWeight

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AddAIWeight

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0009
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_DanceShut", ROMX

; DanceShut's AI score: needs AIScore_DanceShut_Conditions; then always weight row $7E to
; wAISkillScore; WeighLinkRules1RuleBit2. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 146 DanceShut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_DanceShut:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_DanceShut_Conditions
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit2
    ld bc, $007e
    call AddAIWeight

.call_weigh_link_rules1_rule_bit2:
    call WeighLinkRules1RuleBit2
    ret

SECTION "Bank E2 AIScore_MouthShut", ROMX

; MouthShut's AI score: needs AIScore_MouthShut_Conditions; then weight row $7F to wAISkillScore
; when FailIfFoeKnowsSkills42To47 gives 0; always weight row $80 to wAISkillScore;
; WeighLinkRules1RuleBit3. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 147 MouthShut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_MouthShut:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_MouthShut_Conditions
    ld a, c
    and a
    ret z
    farcall FailIfFoeKnowsSkills42To47
    ld a, c
    cp $01
    jr z, .call_set_c_to_zero
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $007f
    call AddAIWeight

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit3
    ld bc, $0080
    call AddAIWeight

.call_weigh_link_rules1_rule_bit3:
    call WeighLinkRules1RuleBit3
    ret

SECTION "Bank E2 AIScore_StrongD", ROMX

; StrongD's AI score: needs AIScore_StrongD_Conditions and AIScoreGuardSkill; then
; AIScore_StrongD_WeighHPBand; always weight row $C1 to wAISkillScore2; weight row $00 to
; wAISkillScore when FailIfFoeSkill3DThreatensActorHP gives 0; WeighLinkRules1RuleBit4. (C2, E-0357;
; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 148 StrongD. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_StrongD:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_StrongD_Conditions
    ld a, c
    and a
    ret z
    call AIScoreGuardSkill
    ret z
    ld a, [wBattleActor]
    call AIScore_StrongD_WeighHPBand
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_fail_if_foe_skill3_d_threatens_actor_hp
    ld bc, $00c1
    call AddAIWeightToScore2

.call_fail_if_foe_skill3_d_threatens_actor_hp:
    farcall FailIfFoeSkill3DThreatensActorHP
    ld a, c
    cp $01
    jr z, .call_weigh_link_rules1_rule_bit4
    and a
    jr nz, .call_weigh_link_rules1_rule_bit4
    ld bc, $0000
    call AddAIWeight

.call_weigh_link_rules1_rule_bit4:
    call WeighLinkRules1RuleBit4
    ret

SECTION "Bank E2 AIScore_Dodge", ROMX

; Dodge's AI score: needs AIScore_Dodge_Conditions and AIScoreGuardSkill; then always weight row $88
; to wAISkillScore and weight row $C1 to wAISkillScore2; WeighLinkRules1RuleBit5. (C2, E-0357;
; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 149 Dodge. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Dodge:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_Dodge_Conditions
    ld a, c
    and a
    ret z
    call AIScoreGuardSkill
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $0088
    call AddAIWeight
    ld bc, $00c1
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    ret

SECTION "Bank E2 AIScore_BladeD", ROMX

; BladeD's AI score: needs AIGuardSkillUsable and AIScoreGuardSkill; then always weight row $8A to
; wAISkillScore and weight row $C1 to wAISkillScore2; WeighLinkRules1RuleBit4. (C2, E-0357; probed
; E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 150 BladeD. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_BladeD:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIGuardSkillUsable
    ld a, c
    and a
    ret z
    call AIScoreGuardSkill
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit4
    ld bc, $008a
    call AddAIWeight
    ld bc, $00c1
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit4:
    call WeighLinkRules1RuleBit4
    ret

SECTION "Bank E2 AIScore_Cover", ROMX

; Cover's AI score: needs AIScore_Cover_Conditions; then AIScoreGuardSkill (returning when it gives
; 0); AIScore_Cover_ScoreHPBands; always weight row $CD to wAISkillScore2 and weight row $D1 to
; wAISkillScore; WeighLinkRules1RuleBit5. (C2, E-0357; probed E-0385)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 151 Cover, 152 Guardian. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_Cover:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_Cover_Conditions
    ld a, c
    and a
    ret z
    call AIScoreGuardSkill
    ret z
    ld a, [wBattleActor]
    call AIScore_Cover_ScoreHPBands
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $00cd
    call AddAIWeightToScore2
    ld bc, $00d1
    call AddAIWeight

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    ret

SECTION "Bank E2 AIScore_TailWind", ROMX

; AI score of 'TailWind' (skill 153, entry of both tables). Returns at once unless
; AIScore_TailWind_Conditions gives non-zero. Then calls AIScore_TailWind_WeighFirstTurn: when
; wBattleTurn is not 0 it returns with Z clear and the routine falls into
; AIScore_TailWind_FoeSkillWeights; on turn 0 it adds row $B6 to wAISkillScore2 and the routine
; returns if Z is then set. The Z flag is the one left by that addition, and it is set for every
; personality in this ROM (the row $B6 words are $00FF or 0), so on turn 0 only row $B6 is added.
; (C2, E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 153 TailWind. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_TailWind:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_TailWind_Conditions
    ld a, c
    and a
    ret z
    call AIScore_TailWind_WeighFirstTurn
    ret z

; Shared second half of the scores of 'TailWind' (which falls into it, after turn 0) and 'StormWind'
; (which jumps to it), ending in ret. FailIfFoeKnowsSkills42To47 decides: a result of 0 adds row $3A
; and then row $8C (always added after SetCToZero); a result of 1 skips row $3A but still adds row
; $8C; any other non-zero result skips both. Then it calls WeighLinkRules1RuleBit5. Rows are added
; with AddAIWeight. (C2, E-0385)
AIScore_TailWind_FoeSkillWeights::
    farcall FailIfFoeKnowsSkills42To47
    ld a, c
    cp $01
    jr z, .call_set_c_to_zero
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $003a
    call AddAIWeight

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $008c
    call AddAIWeight

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    ret

SECTION "Bank E2 AIScore_StormWind", ROMX

; StormWind's AI score: needs AIScore_StormWind_Conditions; then goes on at
; AIScore_TailWind_FoeSkillWeights. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 154 StormWind. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_StormWind:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_StormWind_Conditions
    ld a, c
    and a
    ret z
    jr AIScore_TailWind_FoeSkillWeights

SECTION "Bank E2 AIScore_AquaWall", ROMX

; AquaWall's AI score: needs AIScore_AquaWall_Conditions; then AIScore_AquaWall_WeighHPBand;
; WeighLinkRules1RuleBit5. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 155 AquaWall. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_AquaWall:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_AquaWall_Conditions
    ld a, c
    and a
    ret z
    ld a, [wBattleActor]
    call AIScore_AquaWall_WeighHPBand
    call WeighLinkRules1RuleBit5
    ret

SECTION "Bank E2 AIScore_SealPray", ROMX

; SealPray's AI score: needs AIScore_SealPray_Conditions; then weight row $8D to wAISkillScore2 when
; AIScore_SealPray_QueuedSkillInList gives 0; weight row $8E to wAISkillScore when
; FailIfFoeKnowsSkills42To47 gives 0; always weight row $CB to wAISkillScore; weight row $8F to
; wAISkillScore when FailIfFoeSkill3DThreatensActorHP gives 0; WeighLinkRules1RuleBit5; weight row
; $90 to wAISkillScore when FailIfFoeKnowsSkillList gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 156 SealPray. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_SealPray:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_SealPray_Conditions
    ld a, c
    and a
    ret z
    farcall AIScore_SealPray_QueuedSkillInList
    ld a, c
    and a
    jr nz, .call_fail_if_foe_knows_skills42_to47
    ld bc, $008d
    call AddAIWeightToScore2

.call_fail_if_foe_knows_skills42_to47:
    farcall FailIfFoeKnowsSkills42To47
    ld a, c
    cp $01
    jr z, .call_set_c_to_zero
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $008e
    call AddAIWeight

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_fail_if_foe_skill3_d_threatens_actor_hp
    ld bc, $00cb
    call AddAIWeight

.call_fail_if_foe_skill3_d_threatens_actor_hp:
    farcall FailIfFoeSkill3DThreatensActorHP
    ld a, c
    cp $01
    jr z, .call_weigh_link_rules1_rule_bit5
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $008f
    call AddAIWeight

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    farcall FailIfFoeKnowsSkillList
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0090
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_SuckAll", ROMX

; SuckAll's AI score: needs AIScore_SuckAll_Conditions and AIScoreGuardSkill; then weight row $91 to
; wAISkillScore when AllOtherAlliesHaveStatus0Bit6 gives 0; weight row $92 to wAISkillScore2 when
; AnyAllyHPAtMostThreeQuarters gives 0; AIScore_SuckAll_ScoreHPBands; weight row $8E to
; wAISkillScore when FailIfFoeKnowsSkills42To47 gives 0; WeighLinkRules1RuleBit3; weight row $97 to
; wAISkillScore2 when AnyAllyLacksStatus2Bit2 gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 157 SuckAll. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_SuckAll:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_SuckAll_Conditions
    ld a, c
    and a
    ret z
    call AIScoreGuardSkill
    ret z
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a
    jr nz, .call_any_ally_hp_at_most_three_quarters
    ld bc, $0091
    call AddAIWeight

.call_any_ally_hp_at_most_three_quarters:
    farcall AnyAllyHPAtMostThreeQuarters
    ld a, c
    and a
    jr nz, .read_battle_actor
    ld bc, $0092
    call AddAIWeightToScore2

.read_battle_actor:
    ld a, [wBattleActor]
    call AIScore_SuckAll_ScoreHPBands
    farcall FailIfFoeKnowsSkills42To47
    ld a, c
    cp $01
    jr z, .call_weigh_link_rules1_rule_bit3
    and a
    jr nz, .call_weigh_link_rules1_rule_bit3
    ld bc, $008e
    call AddAIWeight

.call_weigh_link_rules1_rule_bit3:
    call WeighLinkRules1RuleBit3
    farcall AnyAllyLacksStatus2Bit2
    ld a, c
    and a
    jr nz, .return
    ld bc, $0097
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_Imitate", ROMX

; Imitate's AI score: needs AIScore_Imitate_Conditions and AIScoreGuardSkill; then weight row $07 to
; wAISkillScore2 when CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row $98 to
; wAISkillScore when FailIfFoeKnowsSkills42To47 gives 0; always weight row $BB to wAISkillScore2 and
; weight row $C6 to wAISkillScore; WeighLinkRules1RuleBit5; weight row $9A to wAISkillScore when
; FailIfFoeKnowsSkillList gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 158 Imitate. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Imitate:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_Imitate_Conditions
    ld a, c
    and a
    ret z
    call AIScoreGuardSkill
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_fail_if_foe_knows_skills42_to47
    ld bc, $0007
    call AddAIWeightToScore2

.call_fail_if_foe_knows_skills42_to47:
    farcall FailIfFoeKnowsSkills42To47
    ld a, c
    cp $01
    jr z, .call_set_c_to_zero
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0098
    call AddAIWeight

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit5
    ld bc, $00bb
    call AddAIWeightToScore2
    ld bc, $00c6
    call AddAIWeight

.call_weigh_link_rules1_rule_bit5:
    call WeighLinkRules1RuleBit5
    farcall FailIfFoeKnowsSkillList
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $009a
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_Meditate", ROMX

; Meditate's AI score: needs AIScore_Meditate_Conditions; then AIScore_Meditate_WeighHPBand; weight
; row $A1 to wAISkillScore when ActorHPIsNotOne gives 0; always weight row $C2 to wAISkillScore and
; weight row $D2 to wAISkillScore2; WeighLinkRules1RuleBit4; weight row $69 to wAISkillScore2 when
; FailIfTwoAlliesBelowHalfHP gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 159 Meditate. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Meditate:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_Meditate_Conditions
    ld a, c
    and a
    ret z
    ld a, [wBattleActor]
    call AIScore_Meditate_WeighHPBand
    farcall ActorHPIsNotOne
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $00a1
    call AddAIWeight

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit4
    ld bc, $00c2
    call AddAIWeight
    ld bc, $00d2
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit4:
    call WeighLinkRules1RuleBit4
    farcall FailIfTwoAlliesBelowHalfHP
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0069
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_LifeSong", ROMX

; LifeSong's AI score: needs AIScore_LifeSong_Conditions; then always weight row $CC to
; wAISkillScore2 and weight row $D3 to wAISkillScore2; WeighLinkRules1RuleBit4; weight row $2E to
; wAISkillScore2 when AIGateCompareAllyStatAverages gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 160 LifeSong. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_LifeSong:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_LifeSong_Conditions
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit4
    ld bc, $00cc
    call AddAIWeightToScore2
    ld bc, $00d3
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit4:
    call WeighLinkRules1RuleBit4
    farcall AIGateCompareAllyStatAverages
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $002e
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_LoveRain", ROMX

; LoveRain's AI score: needs AIScore_LoveRain_Conditions; then weight row $1B to wAISkillScore2 when
; AnyAllyHPAtMostThreeQuarters gives 0; ForEachPresentSlotOfSideRun; weight row $A3 to wAISkillScore
; when ActorHPIsNotOne gives 0; weight row $A4 to wAISkillScore when FewerThanTwoAlliesAtHP1 gives
; 0; always weight row $CC to wAISkillScore2 and weight row $CF to wAISkillScore and weight row $D3
; to wAISkillScore2; WeighLinkRules1RuleBit4; weight row $69 to wAISkillScore when
; FailIfTwoAlliesBelowHalfHP gives 0. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 161 LoveRain. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_LoveRain:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_LoveRain_Conditions
    ld a, c
    and a
    ret z
    farcall AnyAllyHPAtMostThreeQuarters
    ld a, c
    and a
    jr nz, .read_battle_actor
    ld bc, $001b
    call AddAIWeightToScore2

.read_battle_actor:
    ld a, [wBattleActor]
    call ForEachPresentSlotOfSideRun
    farcall ActorHPIsNotOne
    ld a, c
    and a
    jr nz, .call_fewer_than_two_allies_at_hp1
    ld bc, $00a3
    call AddAIWeight

.call_fewer_than_two_allies_at_hp1:
    farcall FewerThanTwoAlliesAtHP1
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $00a4
    call AddAIWeight

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit4
    ld bc, $00cc
    call AddAIWeightToScore2
    ld bc, $00cf
    call AddAIWeight
    ld bc, $00d3
    call AddAIWeightToScore2

.call_weigh_link_rules1_rule_bit4:
    call WeighLinkRules1RuleBit4
    farcall FailIfTwoAlliesBelowHalfHP
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0069
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_Whistle", ROMX

; AI score of the action ids 162-169 ('Whistle', 'Pheromone', 'StepGuard', 'Outside', 'Informer',
; 'Errand', 'EagleEye', 'MapMagic') and also 178, 179, 182 and 183, which the skill-name table gives
; a placeholder name; every one is an entry of both tables. It farcalls
; AINeverUsableResetAISkillScore, which sets C = 0 and resets wAISkillScore to 0 and wAISkillScore2
; to $FFFF, so ScoreSkillForAI sets the word of the skill to the unusable value $FFFF and the AI
; never picks these. (C2, E-0385)
; AI scoring routine for 8 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 162 Whistle, 163 Pheromone, 164 StepGuard, 165
; Outside, 166 Informer, 167 Errand, 168 EagleEye, 169 MapMagic. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Whistle:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AINeverUsableResetAISkillScore
    ret

SECTION "Bank E2 AIScore_AhhhStatusLick", ROMX

; AI score of the action ids 170 (SKILL_AHHH_AA) and 186, entries of both tables. Returns at once
; unless AIStatusLickUsable gives non-zero (when one of its checks fails it resets the score). Then
; always adds row $A5 to wAISkillScore and calls WeighLinkRules1RuleBit1. (C2, E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 170 Ahhh. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083) (E-0344: the address in its name dropped or read as the label there; was
; AIScore_AhhhStatusLick)
AIScore_AhhhStatusLick:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIStatusLickUsable
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_link_rules1_rule_bit1
    ld bc, $00a5
    call AddAIWeight

.call_weigh_link_rules1_rule_bit1:
    call WeighLinkRules1RuleBit1
    ret

SECTION "Bank E2 AIScore_ZoneOut", ROMX

; AI score of the action ids 171 ('ZoneOut') and 187, entries of both tables. It farcalls
; AINeverUsableResetAISkillScore, which sets C = 0 and resets wAISkillScore to 0 and wAISkillScore2
; to $FFFF, so ScoreSkillForAI sets the word of the skill to the unusable value $FFFF and the AI
; never picks it. (C2, E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 171 ZoneOut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_ZoneOut:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AINeverUsableResetAISkillScore
    ret

SECTION "Bank E2 AIScore_Guard", ROMX

; Guard's AI score: needs MaxNegativeScoreWhenAIFlagBit0 and AIScore_Guard_Conditions; then weight
; row $A6 to wAISkillScore2 when AnyFoeLacksStatus5Bits01And1Bit1 gives 0; weight row $A7 to
; wAISkillScore2 when AllOtherAlliesHaveStatus0Bit6 gives 0; weight row $A8 to wAISkillScore2 when
; ActorHPIsNotOne gives 0; always weight row $A9 to wAISkillScore. (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 172 Guard. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Guard:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    call MaxNegativeScoreWhenAIFlagBit0
    ret z
    farcall AIScore_Guard_Conditions
    ld a, c
    and a
    ret z
    farcall AnyFoeLacksStatus5Bits01And1Bit1
    ld a, c
    and a
    jr nz, .call_all_other_allies_have_status0_bit6
    ld bc, $00a6
    call AddAIWeightToScore2

.call_all_other_allies_have_status0_bit6:
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a
    jr nz, .call_actor_hp_is_not_one
    ld bc, $00a7
    call AddAIWeightToScore2

.call_actor_hp_is_not_one:
    farcall ActorHPIsNotOne
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $00a8
    call AddAIWeightToScore2

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .return
    ld bc, $00a9
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_PanicAll_2", ROMX

; PanicAll's second AI score: needs AIPanicAllUsable; then always weight row $37 to wAISkillScore.
; (C2, E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 173 PanicAll. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083) (E-0344: the address in its name dropped or read as the label there; was
; AIScore_PanicAll_2)
AIScore_PanicAll_2:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIPanicAllUsable
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .return
    ld bc, $0037
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_Ironize_2", ROMX

; Ironize's second AI score: needs AIIronizeUsable and AIScoreGuardSkill; then always weight row $38
; to wAISkillScore; weight row $39 to wAISkillScore when FailIfFoeKnowsSkillList gives 0. (C2,
; E-0357; probed E-0385)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 174 Ironize. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083) (E-0344: the address in its name dropped or read as the label there; was
; AIScore_Ironize_2)
AIScore_Ironize_2:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIIronizeUsable
    ld a, c
    and a
    ret z
    call AIScoreGuardSkill
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_fail_if_foe_knows_skill_list
    ld bc, $0038
    call AddAIWeight

.call_fail_if_foe_knows_skill_list:
    farcall FailIfFoeKnowsSkillList
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0039
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_NoWeightA", ROMX

; AI scoring routine that does nothing (a lone ret): the registers and both score words are left as
; they are. AIScoreRoutineTableA and AIScoreRoutineTableB use it for skill numbers 175-177, 180,
; 181, 184, 185, 188, 189 and 191, so those skills get no weight row. AIScore_NoWeightB is the same
; code for the numbers 192-199. (C2, E-0385)
; AI scoring routine (a lone ret: leaves the score unchanged) for skill numbers 175-191 of the
; per-skill far tables (AIScoreRoutineTableA/B, 201 entries); the skill-name table gives these
; numbers the placeholder name 'HighJump'
AIScore_NoWeightA:: ; configured code entry (E-0316); C0
    ret

SECTION "Bank E2 AIScore_NoWeightB", ROMX

; AI scoring routine that does nothing (a lone ret): the registers and both score words are left as
; they are. AIScoreRoutineTableA and AIScoreRoutineTableB use it for skill numbers 192-199, so those
; skills get no weight row. AIScore_NoWeightA is the same code for other skill numbers. (C2, E-0385)
; AI scoring routine (a lone ret) for skill numbers 192-199 of the per-skill far tables
AIScore_NoWeightB:: ; configured code entry (E-0316); C0
    ret

SECTION "Bank E2 AIScore_Skill200", ROMX

; AI scoring routine for skill number 200, the last entry of AIScoreRoutineTableA and
; AIScoreRoutineTableB. It advances the random value (AdvanceRandom) and, when bit 7 of wRandomLo is
; clear, calls ResetAISkillScoreE2 (wAISkillScore = $0000, wAISkillScore2 = $FFFF); when bit 7 is
; set the scores stay as they were. It adds no weight row. (C2, E-0385)
; AI scoring routine for skill number 200: advances the random value and, when wRandomLo bit 7 is
; clear, sets wAISkillScore to $0000 and the next word to $FFFF (ResetAISkillScoreE2)
AIScore_Skill200:: ; configured code entry (E-0316); C0
    call AdvanceRandom
    ld a, [wRandomLo]
    bit 7, a
    call z, ResetAISkillScoreE2
    ret
    db $c9

; BC = weight row (B is 0 in every caller). Reads the word of that row for the personality in
; wPersonalityIndex (ReadBank6TableWord) and adds it into the AI score pair: a word whose low byte
; is $FF counts as 5000 and a word below $8000 is added as it is, both to wAISkillScore; a word of
; $8000 or more is negated (16 bits) and that magnitude is added to wAISkillScore2. Clobbers A, BC
; and HL. AddAIWeightToScore2 is the mirror. (C2, E-0385)
; BC = weight row: its word for the actor's personality (ReadBank6TableWord); a low byte of $FF
; counts as 5000 and is added to wAISkillScore, as is a positive word; a negative word's magnitude
; is added to wAISkillScore2 (renamed from AccumulateBank6WordToDA6E, E-0365)
AddAIWeight::
    call ReadBank6TableWord
    cp $ff
    jr nz, .skip
    ld bc, $1388
    jr .call_add_bc_to_word_at_hl

.skip:
    bit 7, b
    jr nz, .skip2
    jr .call_add_bc_to_word_at_hl

.skip2:
    cpl
    ld c, a
    ld a, b
    cpl
    ld b, a
    inc bc
    ld hl, wAISkillScore2
    call AddBCToWordAtHL
    jr .return

.call_add_bc_to_word_at_hl:
    ld hl, wAISkillScore
    call AddBCToWordAtHL

.return:
    ret

SECTION "Bank E2 AddAIWeightToScore2", ROMX

; Mirror of AddAIWeight. BC = weight row (B is 0 in every caller): reads the word of that row for
; the personality in wPersonalityIndex (ReadBank6TableWord). A word whose low byte is $FF (counted
; as 5000) or that is below $8000 is added to wAISkillScore2; a word of $8000 or more is negated and
; that magnitude is added to wAISkillScore. Clobbers A, BC and HL. (C2, E-0385)
; the mirror of AddAIWeight: weight row BC's word, $FF (5000) and positive words added to
; wAISkillScore2, a negative word's magnitude to wAISkillScore (renamed from
; AccumulateBank6WordToDA70, E-0365)
AddAIWeightToScore2::
    call ReadBank6TableWord
    cp $ff
    jr nz, .skip
    ld bc, $1388
    jr .call_add_bc_to_word_at_hl

.skip:
    bit 7, b
    jr nz, .skip2
    jr .call_add_bc_to_word_at_hl

.skip2:
    cpl
    ld c, a
    ld a, b
    cpl
    ld b, a
    inc bc
    ld hl, wAISkillScore
    call AddBCToWordAtHL
    jr .return

.call_add_bc_to_word_at_hl:
    ld hl, wAISkillScore2
    call AddBCToWordAtHL

.return:
    ret

SECTION "Bank E2 AddBCToWordAtHL", ROMX

; The 16-bit word at [HL] (low byte first) += BC, wrapping at 16 bits. On return BC = the sum and HL
; = the address of the high byte of the word (the original HL + 1, not the original HL); A is
; clobbered. AddAIWeight and AddAIWeightToScore2 use it on wAISkillScore and wAISkillScore2. (C2,
; E-0385)
; the 16-bit word at [HL] += BC; HL is unchanged
AddBCToWordAtHL::
    push hl
    deref_hl
    add hl, bc
    ld b, h
    ld c, l
    pop hl
    ld [hl], c
    inc hl
    ld [hl], b
    ret

SECTION "Bank E2 SubtractBCFromWordAtHLMin0", ROMX

; The word at HL minus BC, stored back at HL (low byte first); a result with bit 15 set becomes 0.
; BC = the result and HL ends on the stored high byte (HL + 1). AddBCToWordAtHL just before it adds
; instead. No traced code, jump table or pointer reaches it (E-0395: it decodes as a routine but is
; unreached in the static listing). (C2, E-0395; probed E-0395)
SubtractBCFromWordAtHLMin0:: ; configured code entry (E-0395); C0
    push hl
    deref_hl
    ld a, l
    sub c
    ld l, a
    ld a, h
    sbc b
    ld h, a
    bit 7, h
    jr z, .skip
    ld hl, $0000

.skip:
    ld b, h
    ld c, l
    pop hl
    ld [hl], c
    inc hl
    ld [hl], b
    ret

SECTION "Bank E2 ResetAISkillScoreE2", ROMX

; wAISkillScore = $0000 and wAISkillScore2 = $FFFF. Returns A = $FF and HL = wAISkillScore2 + 2 (the
; address after both words). Called by AIScore_Skill200. (C2, E-0385)
; wAISkillScore = $0000 and the next word = $FFFF
ResetAISkillScoreE2::
    xor a
    ld hl, wAISkillScore
    ld [hli], a
    ld [hli], a
    ld a, $ff
    ld [hli], a
    ld [hli], a
    ret

SECTION "Bank E2 ReadBank6TableWord", ROMX

; BC = weight row (B is 0 in every caller). Sets wDataBank to 6 and reads the word at ROM bank 6
; address $4001 + $36 * row + 2 * wPersonalityIndex (each row holds 27 words, one per personality
; index 0-26). Returns BC = the word (the first ROM byte is the low byte) and A = its low byte.
; Clobbers HL and E. Called by AddAIWeight and AddAIWeightToScore2. (C2, E-0385)
; BC = the 16-bit word at ROM bank 6, $4001 + $36 * BC + 2 * wPersonalityIndex (rows of 27 words); A
; = its low byte; clobbers HL, E
ReadBank6TableWord::
    ld a, $36
    call Multiply8By16
    ld a, l
    add LOW(AIPersonalityWeightTable)
    ld l, a
    ld a, h
    adc HIGH(AIPersonalityWeightTable)
    ld h, a
    ld a, [wPersonalityIndex]
    add a
    add_a_to_hl
    ld a, $06
    ld [wDataBank], a
    call ReadWordFromDataBank
    ld a, b
    ld b, c
    ld c, a
    ret

SECTION "Bank E2 AIScore_StrongD_WeighHPBand", ROMX

; StrongD scoring by HP band of slot A: bands 0-3 (HP at least a quarter) $83 against; band 4 $84
; for; lower $85 for. (C2, E-0357; probed E-0385)
AIScore_StrongD_WeighHPBand:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    ldh [hTemp0], a
    farcall HPBandOfSlotTemp0
    ld a, c
    and a
    jr z, .call_add_ai_weight_to_score2
    cp $01
    jr z, .call_add_ai_weight_to_score22
    cp $02
    jr z, .call_add_ai_weight_to_score23
    cp $03
    jr z, .call_add_ai_weight_to_score24
    cp $04
    jr z, .call_add_ai_weight
    ld bc, $0085
    call AddAIWeight
    jr .return

.call_add_ai_weight_to_score2:
    ld bc, $0083
    call AddAIWeightToScore2
    jr .return

.call_add_ai_weight_to_score22:
    ld bc, $0083
    call AddAIWeightToScore2
    jr .return

.call_add_ai_weight_to_score23:
    ld bc, $0083
    call AddAIWeightToScore2
    jr .return

.call_add_ai_weight_to_score24:
    ld bc, $0083
    call AddAIWeightToScore2
    jr .return

.call_add_ai_weight:
    ld bc, $0084
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_AquaWall_WeighHPBand", ROMX

; AquaWall scoring by HP band of slot A: band 0 $81 for, band 1 $82 for, band 2 $83 against, band 3
; $84 against, band 4 $85 against, lower $86 against. (C2, E-0357; probed E-0385)
AIScore_AquaWall_WeighHPBand:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    ldh [hTemp0], a
    farcall HPBandOfSlotTemp0
    ld a, c
    and a
    jr z, .call_add_ai_weight
    cp $01
    jr z, .call_add_ai_weight2
    cp $02
    jr z, .call_add_ai_weight_to_score2
    cp $03
    jr z, .call_add_ai_weight_to_score22
    cp $04
    jr z, .call_add_ai_weight_to_score23
    ld bc, $0086
    call AddAIWeightToScore2
    jr .return

.call_add_ai_weight:
    ld bc, $0081
    call AddAIWeight
    jr .return

.call_add_ai_weight2:
    ld bc, $0082
    call AddAIWeight
    jr .return

.call_add_ai_weight_to_score2:
    ld bc, $0083
    call AddAIWeightToScore2
    jr .return

.call_add_ai_weight_to_score22:
    ld bc, $0084
    call AddAIWeightToScore2
    jr .return

.call_add_ai_weight_to_score23:
    ld bc, $0085
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_SuckAll_ScoreHPBands", ROMX

; For each present slot on side A, scores its HP band for SuckAll
; (AIScore_SuckAll_ScoreHPBands_WeighSlot). (C2, E-0357; probed E-0385)
AIScore_SuckAll_ScoreHPBands:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp0], a
    push bc
    call AIScore_SuckAll_ScoreHPBands_WeighSlot
    pop bc

.next:
    inc c
    dec b
    jr nz, .loop
    ret

SECTION "Bank E2 AIScore_SuckAll_ScoreHPBands_WeighSlot", ROMX

; SuckAll by HP band: at least half HP (bands 0-1) $93 for, lower $94 against. (C2, E-0357; probed
; E-0385)
AIScore_SuckAll_ScoreHPBands_WeighSlot::
    farcall HPBandOfSlotTemp0
    ld a, c
    cp $02
    jr nc, .call_add_ai_weight_to_score2
    ld bc, $0093
    call AddAIWeight
    jr .return

.call_add_ai_weight_to_score2:
    ld bc, $0094
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_Meditate_WeighHPBand", ROMX

; Meditate scoring by HP band of slot A: bands 0-2 $9B, $9C, $9D against; band 3 $9E for, band 4 $9F
; for, lower $A0 for. (C2, E-0357; probed E-0385)
AIScore_Meditate_WeighHPBand:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    ldh [hTemp0], a
    farcall HPBandOfSlotTemp0
    ld a, c
    and a
    jr z, .call_add_ai_weight_to_score2
    cp $01
    jr z, .call_add_ai_weight_to_score22
    cp $02
    jr z, .call_add_ai_weight_to_score23
    cp $03
    jr z, .call_add_ai_weight
    cp $04
    jr z, .call_add_ai_weight2
    ld bc, $00a0
    call AddAIWeight
    jr .return

.call_add_ai_weight_to_score2:
    ld bc, $009b
    call AddAIWeightToScore2
    jr .return

.call_add_ai_weight_to_score22:
    ld bc, $009c
    call AddAIWeightToScore2
    jr .return

.call_add_ai_weight_to_score23:
    ld bc, $009d
    call AddAIWeightToScore2
    jr .return

.call_add_ai_weight:
    ld bc, $009e
    call AddAIWeight
    jr .return

.call_add_ai_weight2:
    ld bc, $009f
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_HealUs_ScoreHPBands", ROMX

; For each present slot on side A, scores its HP band for HealUs
; (AIScore_HealUs_ScoreHPBands_WeighSlot). (C2, E-0357; probed E-0385)
AIScore_HealUs_ScoreHPBands:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp0], a
    push bc
    call AIScore_HealUs_ScoreHPBands_WeighSlot
    pop bc

.next:
    inc c
    dec b
    jr nz, .loop
    ret

SECTION "Bank E2 AIScore_HealUs_ScoreHPBands_WeighSlot", ROMX

; hTemp0 = C = a present slot (from AIScore_HealUs_ScoreHPBands). Takes the weight row for the HP
; band of the slot (HPBandOfSlotTemp0, 0-5) from the 6-byte table after it ($1E-$22, used when C is
; wBattleActor) or from the next one ($AB-$AF, for the other slots) and adds it with AddAIWeight (a
; positive word to wAISkillScore, a negative word as a magnitude to wAISkillScore2). Clobbers BC.
; (C2, E-0385)
AIScore_HealUs_ScoreHPBands_WeighSlot::
    push bc
    farcall HPBandOfSlotTemp0
    ld a, c
    pop bc
    ld b, a
    ld a, [wBattleActor]
    cp c
    ld hl, AIScore_HealUs_ScoreHPBands_WeighSlot_Data1
    jr z, .skip
    ld hl, AIScore_HealUs_ScoreHPBands_WeighSlot_Data2

.skip:
    ld a, b
    add_a_to_hl
    ld c, [hl]
    ld b, $00
    call AddAIWeight
    ret

SECTION "Bank E2 AIScore_HealUs_ScoreHPBands_WeighSlot_Data1", ROMX

; Six weight row ids, $1E, $1F, $20, $21, $22, $22, indexed by the HP band 0-5 of the slot
; (HPBandOfSlotTemp0). AIScore_HealUs_ScoreHPBands_WeighSlot uses this row set when the slot being
; weighed is the actor (wBattleActor equals C) and the table after it for other slots. The entry is
; the weight row id given to AddAIWeight in C (B = 0), which reads the word of that row for the
; actor personality (ReadBank6TableWord). (C1, E-0381)
AIScore_HealUs_ScoreHPBands_WeighSlot_Data1::
    db $1e, $1f, $20, $21, $22, $22

; Six weight row ids, $AB, $AC, $AD, $AE, $AF, $AF, indexed by the HP band 0-5 of the slot
; (HPBandOfSlotTemp0). AIScore_HealUs_ScoreHPBands_WeighSlot uses this row set when the slot being
; weighed is not the actor (wBattleActor differs from C). The entry is the weight row id given to
; AddAIWeight in C (B = 0), which reads the word of that row for the actor personality
; (ReadBank6TableWord). (C1, E-0381)
AIScore_HealUs_ScoreHPBands_WeighSlot_Data2::
    db $ab, $ac, $ad, $ae, $af, $af

; A = a side selector (only bit 2 is used: clear = slots 0-2, set = slots 4-6). For each of the
; three slots of that side that is present (CarryUnlessBattleSlotOutSlotEmpty gives carry clear)
; sets hTemp0 = the slot and calls ForEachPresentSlotOfSideRun_WeighSlot. Called by AIScore_Hustle
; and AIScore_LoveRain. Clobbers A, B and C. (C2, E-0385)
; for the three slots of the side in A (bit 2), runs ForEachPresentSlotOfSideRun_WeighSlot with
; hTemp0 = slot for each occupied one (E-0122) (E-0344: the address in its name dropped or read as
; the label there; was ForEachPresentSlotOfSideRun)
ForEachPresentSlotOfSideRun::
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp0], a
    push bc
    call ForEachPresentSlotOfSideRun_WeighSlot
    pop bc

.next:
    inc c
    dec b
    jr nz, .loop
    ret

SECTION "Bank E2 ForEachPresentSlotOfSideRun_WeighSlot", ROMX

; hTemp0 = C = a present slot (from ForEachPresentSlotOfSideRun). Takes the weight row for the HP
; band of the slot (HPBandOfSlotTemp0, 0-5) from the 6-byte table after it ($1D-$22, used when C is
; wBattleActor) or from the next one ($AA-$AF, for the other slots) and adds it with AddAIWeight (a
; positive word to wAISkillScore, a negative word as a magnitude to wAISkillScore2). Clobbers BC.
; (C2, E-0385)
ForEachPresentSlotOfSideRun_WeighSlot::
    push bc
    farcall HPBandOfSlotTemp0
    ld a, c
    pop bc
    ld b, a
    ld a, [wBattleActor]
    cp c
    ld hl, ForEachPresentSlotOfSideRun_WeighSlot_Data1
    jr z, .skip
    ld hl, ForEachPresentSlotOfSideRun_WeighSlot_Data2

.skip:
    ld a, b
    add_a_to_hl
    ld c, [hl]
    ld b, $00
    call AddAIWeight
    ret

SECTION "Bank E2 ForEachPresentSlotOfSideRun_WeighSlot_Data1", ROMX

; Six weight row ids, $1D to $22 in order, indexed by the HP band 0-5 of the slot
; (HPBandOfSlotTemp0). ForEachPresentSlotOfSideRun_WeighSlot, called for each present slot of a side
; by ForEachPresentSlotOfSideRun, uses this row set when the slot is the actor (wBattleActor equals
; C). The entry is the weight row id given to AddAIWeight in C (B = 0), which reads the word of that
; row for the actor personality (ReadBank6TableWord). (C1, E-0381)
ForEachPresentSlotOfSideRun_WeighSlot_Data1::
    db $1d, $1e, $1f, $20, $21, $22

; Six weight row ids, $AA to $AF in order, indexed by the HP band 0-5 of the slot
; (HPBandOfSlotTemp0). ForEachPresentSlotOfSideRun_WeighSlot uses this row set for slots other than
; the actor. The entry is the weight row id given to AddAIWeight in C (B = 0), which reads the word
; of that row for the actor personality (ReadBank6TableWord). (C1, E-0381)
ForEachPresentSlotOfSideRun_WeighSlot_Data2::
    db $aa, $ab, $ac, $ad, $ae, $af

; A = slot (the actor): sets hTemp0 = A, then takes the weight row for the HP band of the slot
; (HPBandOfSlotTemp0, 0-5) from the 6-byte table after it ($1D-$22) and adds it with AddAIWeight (a
; positive word to wAISkillScore, a negative word as a magnitude to wAISkillScore2). Clobbers BC.
; Called by AIScore_Ramming_HPAndStatusWeights, the shared tail of AIScore_Ramming and
; AIScore_Kamikaze. (C2, E-0385)
AIScore_Ramming_WeighHPBand::
    ldh [hTemp0], a
    push bc
    farcall HPBandOfSlotTemp0
    ld a, c
    pop bc
    ld b, a
    ld hl, AIScore_Ramming_WeighHPBand_Data
    ld a, b
    add_a_to_hl
    ld c, [hl]
    ld b, $00
    call AddAIWeight
    ret

SECTION "Bank E2 AIScore_Ramming_WeighHPBand_Data", ROMX

; Six weight row ids, $1D to $22 in order, indexed by the HP band 0-5 (HPBandOfSlotTemp0) of the
; slot passed in A. AIScore_Ramming_WeighHPBand adds that row with AddAIWeight with no own-slot or
; other-slot split. The entry is the weight row id given to AddAIWeight in C (B = 0), which reads
; the word of that row for the actor personality (ReadBank6TableWord). (C1, E-0381)
AIScore_Ramming_WeighHPBand_Data::
    db $1d, $1e, $1f, $20, $21, $22

; For each present slot on side A, scores its HP band for Cover
; (AIScore_Cover_ScoreHPBands_WeighSlot). (C2, E-0357; probed E-0385)
AIScore_Cover_ScoreHPBands::
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp0], a
    push bc
    call AIScore_Cover_ScoreHPBands_WeighSlot
    pop bc

.next:
    inc c
    dec b
    jr nz, .loop
    ret

SECTION "Bank E2 AIScore_Cover_ScoreHPBands_WeighSlot", ROMX

; hTemp0 = C = a present slot (from AIScore_Cover_ScoreHPBands). Takes the weight row for the HP
; band of the slot (HPBandOfSlotTemp0, 0-5) from the 6-byte table after it ($21 down to $1D, used
; when C is wBattleActor) or from the next one ($AA-$AE, for the other slots) and adds it with
; AddAIWeight (a positive word to wAISkillScore, a negative word as a magnitude to wAISkillScore2).
; Clobbers BC. (C2, E-0385)
AIScore_Cover_ScoreHPBands_WeighSlot::
    push bc
    farcall HPBandOfSlotTemp0
    ld a, c
    pop bc
    ld b, a
    ld a, [wBattleActor]
    cp c
    ld hl, AIScore_Cover_ScoreHPBands_WeighSlot_Data1
    jr z, .skip
    ld hl, AIScore_Cover_ScoreHPBands_WeighSlot_Data2

.skip:
    ld a, b
    add_a_to_hl
    ld c, [hl]
    ld b, $00
    call AddAIWeight
    ret

SECTION "Bank E2 AIScore_Cover_ScoreHPBands_WeighSlot_Data1", ROMX

; Six weight row ids, $21, $20, $1F, $1E, $1D, $1D (descending), indexed by the HP band 0-5 of the
; slot (HPBandOfSlotTemp0). AIScore_Cover_ScoreHPBands_WeighSlot uses this row set when the slot is
; the actor (wBattleActor equals C). The entry is the weight row id given to AddAIWeight in C (B =
; 0), which reads the word of that row for the actor personality (ReadBank6TableWord). (C1, E-0381)
AIScore_Cover_ScoreHPBands_WeighSlot_Data1::
    db $21, $20, $1f, $1e, $1d, $1d

; Six weight row ids, $AA, $AA, $AB, $AC, $AD, $AE, indexed by the HP band 0-5 of the slot
; (HPBandOfSlotTemp0). AIScore_Cover_ScoreHPBands_WeighSlot uses this row set for slots other than
; the actor. The entry is the weight row id given to AddAIWeight in C (B = 0), which reads the word
; of that row for the actor personality (ReadBank6TableWord). (C1, E-0381)
AIScore_Cover_ScoreHPBands_WeighSlot_Data2::
    db $aa, $aa, $ab, $ac, $ad, $ae

; Far-calls CompareFoeAverageATKWithAllyDEF, which gives C = 0 when twice the average ATK of the
; present foes exceeds the average DEF of the present slots on the actor side (the actor included)
; by more than half their average max HP, and C = $FF otherwise. With C = 0 adds weight row $2B with
; AddAIWeight (for); otherwise adds weight row $13 with AddAIWeightToScore2 (against). (C2, E-0385)
AIScore_Upper_WeighFoeATKVsAllyDEF::
    farcall CompareFoeAverageATKWithAllyDEF
    ld a, c
    and a
    jr nz, .call_add_ai_weight_to_score2
    ld bc, $002b
    call AddAIWeight
    jr .return

.call_add_ai_weight_to_score2:
    ld bc, $0013
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 AIScore_Sap_WeighATKVsDEF", ROMX

; Far-calls AIScore_Sap_CompareATKWithDEF, which gives C = 0 when twice the average ATK of the
; present slots on the actor side exceeds the average DEF of the present foes by more than half the
; average current HP of the foes, and C = $FF otherwise. With C = 0 adds weight row $13 with
; AddAIWeightToScore2 (against); otherwise adds weight row $2B with AddAIWeight (for). (C2, E-0385)
AIScore_Sap_WeighATKVsDEF:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIScore_Sap_CompareATKWithDEF
    ld a, c
    and a
    jr nz, .call_add_ai_weight
    ld bc, $0013
    call AddAIWeightToScore2
    jr .return

.call_add_ai_weight:
    ld bc, $002b
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 MaxNegativeScoreWhenAIFlagBit0", ROMX

; Reads wAIFlag. With bit 0 clear returns C = 1 with Z clear and leaves the scores. With bit 0 set
; sets wAISkillScore = $0000 and wAISkillScore2 = $FFFF and returns C = 0 with Z set. The skill
; scorers call it first and return when Z is set (AIScore_Guard, AIScore_SquallHit,
; AIScore_Berserker and AIScoreGuardSkill). (C2, E-0385)
; C = (wAIFlag & 1) ^ 1 and returns when non-zero; when bit 0 is set: wAISkillScore = 0,
; wAISkillScore2/wAISkillScore2 + $1 = $FFFF, C = 0 (E-0118)
MaxNegativeScoreWhenAIFlagBit0:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    ld a, [wAIFlag]
    and $01
    xor $01
    ld c, a
    ret nz
    xor a
    ld [wAISkillScore], a
    ld [wAISkillScore + $1], a
    ld a, $ff
    ld [wAISkillScore2], a
    ld [wAISkillScore2 + $1], a
    xor a
    ld c, a
    ret

SECTION "Bank E2 AIScore_TailWind_WeighFirstTurn", ROMX

; On the first turn (wBattleTurn 0) adds weight row $B6 to wAISkillScore2 and returns C = $FF; on
; later turns returns at once with C = wBattleTurn (non-zero). Called by AIScore_TailWind and
; reached from AIScoreGuardSkill. (C2, E-0371; probed E-0385)
AIScore_TailWind_WeighFirstTurn:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    ld a, [wBattleTurn]
    ld c, a
    or a
    ret nz
    ld bc, $00b6
    call AddAIWeightToScore2
    ld c, $ff
    ret

SECTION "Bank E2 AIScoreGuardSkill", ROMX

; Guard at the start of the buff-skill scorers (AIScore_StrongD, AIScore_Ironize, AIScore_Ironize_2,
; AIScore_Cover, AIScore_Dodge, AIScore_SuckAll, AIScore_BladeD, AIScore_Imitate), which return when
; it leaves Z set. Calls MaxNegativeScoreWhenAIFlagBit0 and returns at once with Z set when wAIFlag
; bit 0 is set (scores already reset). Otherwise jumps to AIScore_TailWind_WeighFirstTurn: on battle
; turn 0 it adds weight row $B6 to wAISkillScore2 and returns C = $FF with Z set (so these scorers
; stop there on turn 0); on later turns it returns C = wBattleTurn with Z clear and the scorer goes
; on. (C2, E-0385)
; returns when MaxNegativeScoreWhenAIFlagBit0 applies; otherwise continues with
; AIScore_TailWind_Sub02 (E-0122) (E-0344: the address in its name dropped or read as the label
; there; was AIScoreGuardSkill)
AIScoreGuardSkill::
    call MaxNegativeScoreWhenAIFlagBit0
    ret z
    jr AIScore_TailWind_WeighFirstTurn

SECTION "Bank E2 WeighActorAloneOnSide", ROMX

; Calls WeighLinkRules1RuleBit4, then adds weight row $29 to wAISkillScore (AddAIWeight) when
; AllySlotsCheckThenFewerThanTwoFoes gives C = 0 (the actor is the only present slot of its side and
; two or more foes are present), and adds it again when PassIfSideFlagOrOtherAllyPresent gives C = 0
; (wSide0Flag or wSide1Flag of the actor side is not 1 and no other slot of that side is present).
; Called by AIScore_Farewell and AIScore_Vivify. (C2, E-0385)
; WeighLinkRules1RuleBit4, then adds score word $29 to wAISkillScore when
; AllySlotsCheckThenFewerThanTwoFoes fails and again when PassIfSideFlagOrOtherAllyPresent fails
; (E-0122) (E-0344: the address in its name dropped or read as the label there; was
; WeighActorAloneOnSide)
WeighActorAloneOnSide::
    call WeighLinkRules1RuleBit4
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a
    jr nz, .call_pass_if_side_flag_or_other_ally_present
    ld bc, $0029
    call AddAIWeight

.call_pass_if_side_flag_or_other_ally_present:
    farcall PassIfSideFlagOrOtherAllyPresent
    ld a, c
    and a
    jr nz, .return
    ld bc, $0029
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIAddScoresForTwoLists", ROMX

; Calls AIAddScoresForTwoLists_SealingFoes and AIAddScoresForTwoLists_OtherAllies; each gives C = 1
; (AI mode below 4, counts as a pass), $FF (pass) or 0 (fail). A fail adds weight row $B1 (first
; check) or $B2 (second check) to wAISkillScore with AddAIWeight. The note of the first check says
; it cannot give 0 (its foe loop never tests a foe), so in practice only row $B2 is added: wAIFlag
; set, AI mode 4 or more and an ally other than the actor that meets the second check. Called by
; AIScore_Ahhh, AIScore_LegSweep, AIScore_LureDance, AIScore_LushLicks, AIScore_SickLick and the
; AIScoreB_ versions of the first four. (C2, E-0385)
; adds score word $B1 when AIAddScoresForTwoLists_SealingFoes fails and $B2 when
; AIAddScoresForTwoLists_OtherAllies fails (results of 1 count as passing) (E-0124) (E-0344: the
; address in its name dropped or read as the label there; was AIAddScoresForTwoLists; a trailing
; preposition left by the dropped address removed)
AIAddScoresForTwoLists:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall AIAddScoresForTwoLists_SealingFoes
    ld a, c
    cp $01
    jr z, .call_ai_add_scores_for_two_lists_other_allies
    and a
    jr nz, .call_ai_add_scores_for_two_lists_other_allies
    ld bc, $00b1
    call AddAIWeight

.call_ai_add_scores_for_two_lists_other_allies:
    farcall AIAddScoresForTwoLists_OtherAllies
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $00b2
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 WeighLinkRuleBit6AndTurnLimit", ROMX

; Adds weight row $0E (5000) to wAISkillScore2 when LinkRuleCheckLinkRules1Bit6 fails (a link
; battle, link rule bit 6 on and not met), then adds weight row $0F to wAISkillScore when
; LinkRuleCheckLinkRuleTurnLimitTurnLimit fails (a link battle with a turn limit on and wBattleTurn
; less than 4 past it). Outside link battles it changes nothing. Called by AIScore_Beat,
; AIScore_Blaze and AIScore_Firebal. (C2, E-0385)
; adds score word $0E to wAISkillScore2 when LinkRuleCheckLinkRules1Bit6 fails and $0F to
; wAISkillScore when LinkRuleCheckLinkRuleTurnLimitTurnLimit fails (E-0122) (E-0344: the address in
; its name dropped or read as the label there; was WeighLinkRuleBit6AndTurnLimit)
WeighLinkRuleBit6AndTurnLimit::
    farcall LinkRuleCheckLinkRules1Bit6
    ld a, c
    and a
    jr nz, .call_link_rule_check_link_rule_turn_limit
    ld bc, $000e
    call AddAIWeightToScore2

.call_link_rule_check_link_rule_turn_limit:
    farcall LinkRuleCheckLinkRuleTurnLimitTurnLimit
    ld a, c
    and a
    jr nz, .return
    ld bc, $000f
    call AddAIWeight

.return:
    ret

SECTION "Bank E2 AIScore_Sacrifice_WeighLinkRule", ROMX

; Sacrifice: $0E against when link rule bit 6 forbids it (C = 0). (C2, E-0357; probed E-0385)
AIScore_Sacrifice_WeighLinkRule:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall LinkRuleCheckLinkRules1Bit6
    ld a, c
    and a
    jr nz, .return
    ld bc, $000e
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 WeighLinkRules1RuleBit5", ROMX

; Far-calls CheckLinkRules1RuleBit5; when it fails (C = 0: wLinkMode neither 0 nor 2, bits 7 and 5
; of wLinkRules + 1 set, and bit 5 of wLinkRules + 2 clear or bit 5 of wLinkRuleFlags for the actor
; side set) adds weight row $0E (a word of $00FF, counted as 5000) to wAISkillScore2 with
; AddAIWeightToScore2; otherwise changes nothing. Called by many skill scorers. (C2, E-0385)
; far-calls CheckLinkRules1RuleBit5; when it fails (C = 0) adds weight-table entry $0E to
; wAISkillScore2 (AddAIWeightToScore2); used by the AI scoring routines (E-0091) (E-0340: the
; address in its name read as its RAM name; was WeighLinkRules1RuleBit5)
WeighLinkRules1RuleBit5:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall CheckLinkRules1RuleBit5
    ld a, c
    and a
    jr nz, .return
    ld bc, $000e
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 WeighLinkRules1RuleBit4", ROMX

; Far-calls CheckLinkRules1RuleBit4; when it fails (C = 0: wLinkMode neither 0 nor 2, bits 7 and 4
; of wLinkRules + 1 set, and bit 4 of wLinkRules + 2 clear or bit 4 of wLinkRuleFlags for the actor
; side set) adds weight row $0E (a word of $00FF, counted as 5000) to wAISkillScore2 with
; AddAIWeightToScore2; otherwise changes nothing. Called by many skill scorers. (C2, E-0385)
; far-calls CheckLinkRules1RuleBit4; when it fails (C = 0) adds weight-table entry $0E to
; wAISkillScore2 (AddAIWeightToScore2); used by the AI scoring routines (E-0091) (E-0340: the
; address in its name read as its RAM name; was WeighLinkRules1RuleBit4)
WeighLinkRules1RuleBit4:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall CheckLinkRules1RuleBit4
    ld a, c
    and a
    jr nz, .return
    ld bc, $000e
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 WeighLinkRules1RuleBit3", ROMX

; Far-calls CheckLinkRules1RuleBit3; when it fails (C = 0: wLinkMode neither 0 nor 2, bits 7 and 3
; of wLinkRules + 1 set, and bit 3 of wLinkRules + 2 clear or bit 3 of wLinkRuleFlags for the actor
; side set) adds weight row $0E (a word of $00FF, counted as 5000) to wAISkillScore2 with
; AddAIWeightToScore2; otherwise changes nothing. Called by many skill scorers. (C2, E-0385)
; far-calls CheckLinkRules1RuleBit3; when it fails (C = 0) adds weight-table entry $0E to
; wAISkillScore2 (AddAIWeightToScore2); used by the AI scoring routines (E-0091) (E-0340: the
; address in its name read as its RAM name; was WeighLinkRules1RuleBit3)
WeighLinkRules1RuleBit3:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall CheckLinkRules1RuleBit3
    ld a, c
    and a
    jr nz, .return
    ld bc, $000e
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 WeighLinkRules1RuleBit2", ROMX

; Far-calls CheckLinkRules1RuleBit2; when it fails (C = 0: wLinkMode neither 0 nor 2, bits 7 and 2
; of wLinkRules + 1 set, and bit 2 of wLinkRules + 2 clear or bit 2 of wLinkRuleFlags for the actor
; side set) adds weight row $0E (a word of $00FF, counted as 5000) to wAISkillScore2 with
; AddAIWeightToScore2; otherwise changes nothing. Called by many skill scorers. (C2, E-0385)
; far-calls CheckLinkRules1RuleBit2; when it fails (C = 0) adds weight-table entry $0E to
; wAISkillScore2 (AddAIWeightToScore2); used by the AI scoring routines (E-0091) (E-0340: the
; address in its name read as its RAM name; was WeighLinkRules1RuleBit2)
WeighLinkRules1RuleBit2:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall CheckLinkRules1RuleBit2
    ld a, c
    and a
    jr nz, .return
    ld bc, $000e
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 WeighLinkRules1RuleBit1", ROMX

; Far-calls CheckLinkRules1RuleBit1; when it fails (C = 0: wLinkMode neither 0 nor 2, bits 7 and 1
; of wLinkRules + 1 set, and bit 1 of wLinkRules + 2 clear or bit 1 of wLinkRuleFlags for the actor
; side set) adds weight row $0E (a word of $00FF, counted as 5000) to wAISkillScore2 with
; AddAIWeightToScore2; otherwise changes nothing. Called by many skill scorers. (C2, E-0385)
; far-calls CheckLinkRules1RuleBit1; when it fails (C = 0) adds weight-table entry $0E to
; wAISkillScore2 (AddAIWeightToScore2); used by the AI scoring routines (E-0091) (E-0340: the
; address in its name read as its RAM name; was WeighLinkRules1RuleBit1)
WeighLinkRules1RuleBit1:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    farcall CheckLinkRules1RuleBit1
    ld a, c
    and a
    jr nz, .return
    ld bc, $000e
    call AddAIWeightToScore2

.return:
    ret

SECTION "Bank E2 GetBattleATK_BankE2", ROMX

; A = battle slot: HL = the attack word of that slot (wBattleATK + 2 * A), A = its low byte, through
; GetBattleStatWord_BankE2. (C2, E-0385)
; A = battle slot: HL = the word for that slot at wBattleATK; A = its low byte (E-0064)
GetBattleATK_BankE2:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    ld hl, wBattleATK
    jr GetBattleStatWord_BankE2

SECTION "Bank E2 GetBattleDEF_BankE2", ROMX

; HL = wBattleDEF, then the slot's word (GetBattleStatWord_BankE2). (C2, E-0357; probed E-0385)
; the same 50 bytes as GetBattleDEF_Bank39 (GetBattleDEF_Bank39) (E-0060)
GetBattleDEF_BankE2:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    ld hl, wBattleDEF
    jr GetBattleStatWord_BankE2

SECTION "Bank E2 GetBattleMaxHP_BankE2", ROMX

; HL = wBattleMaxHP, then the slot's word (GetBattleStatWord_BankE2). (C2, E-0357; probed E-0385)
; the same 45 bytes as GetBattleMaxHP_Bank39 (GetBattleMaxHP_Bank39) (E-0060)
GetBattleMaxHP_BankE2:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    ld hl, wBattleMaxHP
    jr GetBattleStatWord_BankE2

SECTION "Bank E2 GetBattleMaxMP_BankE2", ROMX

; HL = wBattleMaxMP, then the slot's word (GetBattleStatWord_BankE2). (C2, E-0357; probed E-0385)
; the same 40 bytes as GetBattleMaxMP_Bank39 (GetBattleMaxMP_Bank39) (E-0060)
GetBattleMaxMP_BankE2:: ; configured code entry (E-0395 (traced before by the fall-through guess alone; listed so new entries in the bank cannot drop it)); C0
    ld hl, wBattleMaxMP
    jr GetBattleStatWord_BankE2

SECTION "Bank E2 GetBattleHP_BankE2", ROMX

; HL = wBattleHP, then the slot's word (GetBattleStatWord_BankE2). (C2, E-0357; probed E-0385)
; the same 35 bytes as GetBattleHP_Bank39 (GetBattleHP_Bank39) (E-0060)
GetBattleHP_BankE2:: ; configured code entry (E-0395 (traced before by the fall-through guess alone; listed so new entries in the bank cannot drop it)); C0
    ld hl, wBattleHP
    jr GetBattleStatWord_BankE2

SECTION "Bank E2 GetBattleMP_BankE2", ROMX

; HL = wBattleMP, then the slot's word (GetBattleStatWord_BankE2). (C2, E-0357; probed E-0385)
; the same 30 bytes as GetBattleMP_Bank39 (GetBattleMP_Bank39) (E-0060)
GetBattleMP_BankE2:: ; configured code entry (E-0395 (traced before by the fall-through guess alone; listed so new entries in the bank cannot drop it)); C0
    ld hl, wBattleMP
    jr GetBattleStatWord_BankE2

SECTION "Bank E2 GetBattleAGL_BankE2", ROMX

; HL = wBattleAGL, then GetBattleStatWord_BankE2: HL = the word at wBattleAGL + 2 x A (A = the
; battle slot). One of this bank's GetBattle* stat getters. No traced code, jump table or pointer
; reaches it (E-0395: it decodes as a routine but is unreached in the static listing). (C2, E-0395;
; probed E-0395)
; the same 25 bytes as GetBattleAGL_Bank39 (GetBattleAGL_Bank39) (E-0060)
GetBattleAGL_BankE2:: ; configured code entry (E-0395); C0
    ld hl, wBattleAGL
    jr GetBattleStatWord_BankE2

SECTION "Bank E2 ReadSlotAIModeIndexed_BankE2", ROMX

; A = the byte at wSlotAIMode + A, the AI mode of slot A. A copy of the routine of the same shape
; found in other banks. No traced code, jump table or pointer reaches it (E-0395: it decodes as a
; routine but is unreached in the static listing). (C2, E-0395; probed E-0395)
; A = the byte at wSlotAIMode + A; clobbers HL (the same 10 bytes appear in 13 banks)
ReadSlotAIModeIndexed_BankE2::
    ld hl, wSlotAIMode
    add_a_to_hl
    ld a, [hl]
    ret

SECTION "Bank E2 GetBattleStatWord_BankE2", ROMX

; HL = array base, A = battle slot: HL = the 16-bit word at HL + 2 * A (the value, not a pointer); A
; = its low byte. The shared tail of GetBattleATK_BankE2 through GetBattleMP_BankE2, the same bytes
; as ReadBattleWordFromArray in bank $36. (C2, E-0371; probed E-0385)
GetBattleStatWord_BankE2::
    add a
    add_a_to_hl
    deref_hl
    ret

SECTION "Bank E2 AddDoubleAToHL_BankE2", ROMX

; HL += 2 * A. A is doubled in 8 bits first, so it wraps above $7F; A is clobbered. (C2, E-0385)
; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes
; appear in 12 banks)
AddDoubleAToHL_BankE2:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    add a
    add_a_to_hl
    ret

SECTION "Bank E2 ActorOnLocalSide_BankE2", ROMX

; Carry set when wBattleActor is below 4 (slots 0-3), clear otherwise. In a link battle (wLinkMode
; 1) with wLinkRole bit 1 set the answer is reversed: carry set for slots 4-7. Which side is local
; is inferred from that reversal, not checked. (C2, E-0385)
; carry set when wBattleActor < 4 (slots 0-3); when wLinkMode = 1 and wLinkRole bit 1 is set the
; test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the
; reversal, not checked (E-0064) (the same 27 bytes appear in 12 banks)
ActorOnLocalSide_BankE2:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
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

SECTION "Bank E2 TargetOnLocalSide_BankE2", ROMX

; Carry set when wBattleTarget is below 4 (slots 0-3), clear otherwise. In a link battle (wLinkMode
; 1) with wLinkRole bit 1 set the answer is reversed: carry set for slots 4-7. (C2, E-0385)
; carry set when wBattleTarget < 4 (slots 0-3); when wLinkMode = 1 and wLinkRole bit 1 is set the
; test is reversed (carry set when wBattleTarget >= 4) (E-0064) (the same 27 bytes appear in 12
; banks)
TargetOnLocalSide_BankE2:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
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

SECTION "Bank E2 ClearBattleStatusBitsWithMaskD_BankE2", ROMX

; Status byte 0 of slot E &= the mask for D (ClearBattleStatusBitsWithMaskD_BankE2_Data); a copy of
; the bank $05 routine. (C2, E-0357; probed E-0385)
ClearBattleStatusBitsWithMaskD_BankE2:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    ld a, d
    ld hl, ClearBattleStatusBitsWithMaskD_BankE2_Data
    add_a_to_hl
    ld d, [hl]
    ld a, e
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, d
    and [hl]
    ld [hl], a
    ret

SECTION "Bank E2 ClearBattleStatusBitsWithMaskD_BankE2_Data", ROMX

; Seven AND masks indexed by D: $DF (clears bit 5), $FE (bit 0), $00 (all bits), $FD (bit 1), $73
; (bits 7, 3 and 2), $EF (bit 4) and $BF (bit 6). ClearBattleStatusBitsWithMaskD_BankE2 ANDs the
; chosen mask into the first byte of the 9-byte status record of slot E (wBattleStatus + 9 * E), the
; byte that holds the bits BSTAT0_POISONED to BSTAT0_ASLEEP. (C1, E-0381)
ClearBattleStatusBitsWithMaskD_BankE2_Data::
    db $df, $fe, $00, $fd, $73, $ef, $bf

; Sets bit 0 of the byte at wLevelUpGains + A. HL is kept; A is clobbered. (C2, E-0385)
; Sets bit 0 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit0OfLevelUpGainsIndexed_BankE2:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

SECTION "Bank E2 SetBit1OfLevelUpGainsIndexed_BankE2", ROMX

; Sets bit 1 of the byte at wLevelUpGains + A. HL is kept; A is clobbered. (C2, E-0385)
; Sets bit 1 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit1OfLevelUpGainsIndexed_BankE2:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

SECTION "Bank E2 SetBit2OfLevelUpGainsIndexed_BankE2", ROMX

; Sets bit 2 of the byte at wLevelUpGains + A. HL is kept; A is clobbered. (C2, E-0385)
; Sets bit 2 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit2OfLevelUpGainsIndexed_BankE2:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 2, [hl]
    pop hl
    ret

SECTION "Bank E2 PersonalityIndexOfSlot_BankE2", ROMX

; A = slot 0-7: returns A = 9 * g(wSlotPersonalityHi[A]) + 3 * g(wSlotPersonalityMid[A]) +
; g(wSlotPersonalityLo[A]), where g(v) = 0 for v >= $C0, 1 for v >= $40 and 2 below $40. The result
; 0-26 is a personality index (wPersonalityIndex, the column of the bank 6 weight table read by
; ReadBank6TableWord); PersonalityIndexOfRecord builds the same index from a save record. BC and HL
; are kept. (C2, E-0385)
; A = slot 0-7: returns A = 9 * g(wSlotPersonalityHi[A]) + 3 * g(wSlotPersonalityMid[A]) +
; g(wSlotPersonalityLo[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index
; PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes
; appear in 13 banks)
PersonalityIndexOfSlot_BankE2:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
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

SECTION "Bank E2 CheckSlotStatusBlockWide_BankE2", ROMX

; A = slot: carry set when CheckSlotStatusBlock sets it, or when status byte 3 & $C0 or status byte
; 4 & $0C is set (wBattleStatus3 + 9 * slot, then the next byte); otherwise carry clear. A, BC and
; HL are kept. (C2, E-0385)
; A = slot: carry set when CheckSlotStatusBlock sets it, or when status byte 3 & $C0 or byte 4 & $0C
; is set (wBattleStatus3 + 9 * A); otherwise carry clear; A, BC, HL kept (E-0067) (the same 31 bytes
; appear in 12 banks)
CheckSlotStatusBlockWide_BankE2:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
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

SECTION "Bank E2 SlotHasStatus3Or4Bits_BankE2", ROMX

; A = slot: HL is kept; with the slot status record at wBattleStatus3 + 9 * A, returns A = status
; byte 3 & $C0 or, when that is zero, status byte 4 & $0C; Z is set when both are clear. (C2,
; E-0385)
; A = slot: with HL = wBattleStatus3 + 9 * A (status byte 3 of wBattleStatus), A = byte 3 & $C0, or
; byte 4 & $0C when that is zero; Z set when both are clear; HL kept (E-0067) (the same 17 bytes
; appear in 13 banks)
SlotHasStatus3Or4Bits_BankE2:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries in the bank cannot drop it)); C0
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
    ds $1619, $00
