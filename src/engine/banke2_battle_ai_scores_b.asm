; ROM bank $E2: battle AI: the second set of scoring routines
; The annotated listing of this bank is build/listing/banke2.asm.

SECTION "Bank E2", ROMX[$4000], BANK[$E2]
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
; ActorLacksStatus2Bit1And5Bits01 gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 0 (no name). It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083) (E-0332: skill 0 is Fight, the plain attack: with Guard (skill $AC) it is scored on every
; monster's turn whether or not any record holds it, as the Command menu offers Fight / Skill /
; Guard; C2) (was AIScore_Fight)
AIScore_Fight::
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

; Blaze's AI score: needs AIFireSkillUsable; then weight row $08 to wAISkillScore2 when
; FailIfFoeAIDamageEstimatesAtLeastEstimate gives 0; weight row $09 to wAISkillScore when
; PassIfFoesAverageResistanceAtLeast2 gives 0; always weight row $0B to wAISkillScore; weight row
; $0C to wAISkillScore when PassIfFoeAIDamageEstimatesAtLeastEstimate gives 0;
; AIAddScoresForLinkRuleCheckLinkRules1Bit6; weight row $10 to wAISkillScore2 when
; FewerThanTwoFoesPresent gives 0. (C1, E-0357)
; AI scoring routine for 3 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 1 Blaze, 2 Blazemore, 3 Blazemost. It runs checks
; and adds weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_Blaze::
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
    jr nz, .call_ai_add_scores_for_link_rule_check_link
    ld bc, $000c
    call AddAIWeight

.call_ai_add_scores_for_link_rule_check_link:
    call AIAddScoresForLinkRuleCheckLinkRules1Bit6
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .return
    ld bc, $0010
    call AddAIWeightToScore2

.return:
    ret

; Firebal's AI score: needs AIFireSkillUsable; then weight row $04 to wAISkillScore2 when
; AIGateFoeStatus2Mask22 gives 0; weight row $0A to wAISkillScore2 when
; FailIfFoeAIDamageEstimatesAtLeastEstimate gives 0; weight row $09 to wAISkillScore when
; PassIfFoesAverageResistanceAtLeast2 gives 0; always weight row $0B to wAISkillScore; weight row
; $0D to wAISkillScore when PassIfFoeAIDamageEstimatesAtLeastEstimate gives 0;
; AIAddScoresForLinkRuleCheckLinkRules1Bit6; weight row $14 to wAISkillScore when
; AllySlotsCheckThenFewerThanTwoFoes gives 0; weight row $15 to wAISkillScore when
; FewerThanTwoFoesPresent gives 0; weight row $4A to wAISkillScore2 when CheckFoeStatus6Bit3 gives
; 0; weight row $12 to wAISkillScore2 when FailIfSkillHasResistanceClass gives 0. (C1, E-0357)
; AI scoring routine for 15 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 4 Firebal, 5 Firebane, 6 Firebolt, 7 Bang, 8 Boom,
; 9 Explodet, 10 Infernos, 11 Infermore, 12 Infermost, 13 Bolt .... It runs checks and adds weights
; to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_Firebal::
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
    jr nz, .call_ai_add_scores_for_link_rule_check_link
    ld bc, $000d
    call AddAIWeight

.call_ai_add_scores_for_link_rule_check_link:
    call AIAddScoresForLinkRuleCheckLinkRules1Bit6
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

; table-B AI score: AIScore_Beat, then adds a penalty word when the follow-up check fails (E-0122)
AIScoreB_Beat::
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

; Beat's AI score: needs AIScore_Beat_Conditions; then weight row $04 to wAISkillScore2 when
; AIGateFoeStatus2Mask22 gives 0; always weight row $CD to wAISkillScore and weight row $CF to
; wAISkillScore2; AIAddScoresForLinkRuleCheckLinkRules1Bit6; weight row $15 to wAISkillScore when
; FewerThanTwoFoesPresent gives 0; weight row $B5 to wAISkillScore when
; AIGateFoeSlotResistances2Bits45 gives 0; weight row $12 to wAISkillScore2 when
; FailIfSkillHasResistanceClass gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForAISide gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForFoeAIMode3 gives 0; returns C = 1. (C1, E-0357)
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
    jr nz, .call_ai_add_scores_for_link_rule_check_link
    ld bc, $00cd
    call AddAIWeight
    ld bc, $00cf
    call AddAIWeightToScore2

.call_ai_add_scores_for_link_rule_check_link:
    call AIAddScoresForLinkRuleCheckLinkRules1Bit6
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

; Sacrifice's AI score: needs AIScore_Sacrifice_Conditions; then weight row $17 to wAISkillScore2
; when ActorLacksStatus4Bits67 gives 0; weight row $17 to wAISkillScore2 when
; AllOtherAlliesHaveStatus0Bit6 gives 0; weight row $11 to wAISkillScore2 when AtLeastTwoFoesPresent
; gives 0; weight row $1B to wAISkillScore2 when AnyAllyHPAtMostThreeQuarters gives 0; weight row
; $07 to wAISkillScore2 when CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; always weight row $CD
; to wAISkillScore and weight row $CF to wAISkillScore2; AIScore_Sacrifice_WeighLinkRule; weight row
; $19 to wAISkillScore when AIScore_Sacrifice_LowHPAndFoesVulnerable gives 0; weight row $12 to
; wAISkillScore2 when FailIfSkillHasResistanceClass gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 21 Sacrifice. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Sacrifice::
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

; Heal's AI score: needs AIHealUsable; then weight row $69 to wAISkillScore2 when
; FailIfTwoAlliesBelowHalfHP gives 0; then goes on as HealUs from
; AIScore_HealUs_AnyFoeLacksStatus0MaskCC (also when the check passes). (C1, E-0357)
; AI scoring routine for 3 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 22 Heal, 23 HealMore, 24 HealAll. It runs checks
; and adds weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_Heal::
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

; HealUs scoring, the rest: adds weight $1A to wAISkillScore when every present foe has one of
; status 0 bits $CC (AnyFoeLacksStatus0MaskCC gives 0), $1A again when every present foe has some
; status 3 bit, $1B to wAISkillScore2 when no ally is at three quarters of its HP or less; adds by
; each ally's HP band (AIScore_HealUs_ScoreHPBands); $23 when the actor's HP is 1; always $24 and
; $C8 (the SetCToZero test cannot pass); then link rule bit 4. (C1, E-0357)
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

; HealUs' AI score: needs AIHealUsable; then AIScore_HealUs_StatusAndHPWeights; weight row $23 to
; wAISkillScore when FewerThanTwoAlliesAtHP1 gives 0; weight row $69 to wAISkillScore when
; FailIfTwoAlliesBelowHalfHP gives 0. (C1, E-0357)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 25 HealUs, 26 HealUsAll. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_HealUs::
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

; MPass' AI score: needs AIScore_MPass_Conditions and adds nothing. (C1, E-0357)
; AI scoring routine for 3 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 27 MPass, 28 MPassmore, 29 MPassmost. It runs
; checks and adds weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_MPass::
    farcall AIScore_MPass_Conditions
    ld a, c
    and a
    ret z
    ret

; Vivify's AI score: needs AIScore_Vivify_Conditions; then
; AIAddPenaltyForAllySlotsCheckThenFewerThanTwoFoes; weight row $2E to wAISkillScore2 when
; AIGateCompareAllyStatAverages gives 0. (C1, E-0357)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 30 Vivify, 31 Revive. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_Vivify::
    farcall AIScore_Vivify_Conditions
    ld a, c
    and a
    ret z
    call AIAddPenaltyForAllySlotsCheckThenFewerThanTwoFoes
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

; Farewell's AI score: needs AIScore_Farewell_Conditions; then
; AIAddPenaltyForAllySlotsCheckThenFewerThanTwoFoes; always weight row $BC to wAISkillScore and
; weight row $C4 to wAISkillScore2; weight row $2E to wAISkillScore2 when
; AIGateCompareAllyStatAverages gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 32 Farewell. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Farewell::
    farcall AIScore_Farewell_Conditions
    ld a, c
    and a
    ret z
    call AIAddPenaltyForAllySlotsCheckThenFewerThanTwoFoes
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

; Antidote's AI score: needs AIScore_Antidote_Conditions; then always weight row $2A to
; wAISkillScore; WeighLinkRules1RuleBit4. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 33 Antidote. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Antidote::
    farcall AIScore_Antidote_Conditions
    ld a, c
    and a
    ret z
    ld bc, $002a
    call AddAIWeight
    call WeighLinkRules1RuleBit4
    ret

; DeChaos' AI score: needs AIScore_DeChaos_Conditions; then always weight row $2A to wAISkillScore;
; WeighLinkRules1RuleBit4. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 34 DeChaos. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_DeChaos::
    farcall AIScore_DeChaos_Conditions
    ld a, c
    and a
    ret z
    ld bc, $002a
    call AddAIWeight
    call WeighLinkRules1RuleBit4
    ret

; NumbOff's AI score: needs AIScore_NumbOff_Conditions; then always weight row $2A to wAISkillScore;
; WeighLinkRules1RuleBit4. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 35 NumbOff. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_NumbOff::
    farcall AIScore_NumbOff_Conditions
    ld a, c
    and a
    ret z
    ld bc, $002a
    call AddAIWeight
    call WeighLinkRules1RuleBit4
    ret

; CurseOff's AI score: needs AIScore_CurseOff_Conditions; then always weight row $2A to
; wAISkillScore; WeighLinkRules1RuleBit4. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 36 CurseOff. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_CurseOff::
    farcall AIScore_CurseOff_Conditions
    ld a, c
    and a
    ret z
    ld bc, $002a
    call AddAIWeight
    call WeighLinkRules1RuleBit4
    ret

; Upper's AI score: needs AIScore_Upper_Conditions; then weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; WeighLinkRules1RuleBit5;
; AIScore_Upper_WeighFoeATKVsAllyDEF; always weight row $C1 to wAISkillScore2. (C1, E-0357)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 37 Upper, 38 Increase. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_Upper::
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

; Sap's AI score: needs AIScore_Sap_Conditions; then weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row $2C to wAISkillScore when
; PassIfFoeAverageDEFAtMostTwiceAllyATK gives 0; weight row $2C to wAISkillScore when
; PassIfTwiceATKAboveHighestFoeDEF gives 0; always weight row $CC to wAISkillScore and weight row
; $D1 to wAISkillScore2; WeighLinkRules1RuleBit5; weight row $12 to wAISkillScore2 when
; FailIfSkillHasResistanceClass gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForAISide gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForFoeAIMode3 gives 0. (C1, E-0357)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 39 Sap, 40 Defense. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_Sap::
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

; Speed's AI score: needs AIScore_Speed_Conditions; then weight row $2D to wAISkillScore2 when
; FastestFoeAGLAbove31PercentOfActor gives 0; weight row $2C to wAISkillScore when
; AllyAverageAGLAtLeastFoes gives 0; WeighLinkRules1RuleBit5. (C1, E-0357)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 41 Speed, 42 SpeedUp. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_Speed::
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

; Slow's AI score: needs AIScore_Slow_Conditions; then weight row $04 to wAISkillScore2 when
; AIGateFoeStatus2Mask22 gives 0; weight row $2D to wAISkillScore2 when
; FastestFoeAGLAbove31PercentOfActor gives 0; weight row $2C to wAISkillScore when
; AllyAverageAGLAtLeastFoes gives 0; always weight row $CC to wAISkillScore and weight row $D1 to
; wAISkillScore2; WeighLinkRules1RuleBit5; weight row $12 to wAISkillScore2 when
; FailIfSkillHasResistanceClass gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForAISide gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForFoeAIMode3 gives 0. (C1, E-0357)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 43 Slow, 44 SlowAll. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_Slow::
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

; table-B AI score: AIScore_TwinHits, then adds a penalty word when the follow-up check fails
; (E-0122)
AIScoreB_TwinHits::
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

; TwinHits' AI score: needs AIScore_TwinHits_Conditions; then weight row $2F to wAISkillScore when
; AIScore_TwinHits_CompareATKWithFoeDEF gives 0; weight row $30 to wAISkillScore when
; AIScore_TwinHits_CheckAllyATK gives 0; always weight row $BA to wAISkillScore;
; WeighLinkRules1RuleBit5; weight row $B3 to wAISkillScore when FailIfAllyCanUseSkill63Or64 gives 0.
; (C1, E-0357)
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

; Surround's AI score: needs AIScore_Surround_Conditions; then weight row $04 to wAISkillScore2 when
; AIGateFoeStatus2Mask22 gives 0; weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row $31 to wAISkillScore when
; PassIfFoeAverageATKAtMostTwiceAllyDEF gives 0; always weight row $BA to wAISkillScore2 and weight
; row $CC to wAISkillScore and weight row $D1 to wAISkillScore2; WeighLinkRules1RuleBit5; weight row
; $32 to wAISkillScore when CompareFoeAverageATKWithAllyDEF gives 0; weight row $12 to
; wAISkillScore2 when FailIfSkillHasResistanceClass gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForAISide gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForFoeAIMode3 gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 46 Surround. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Surround::
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

; Sleep's AI score: needs AIScore_Sleep_Conditions; then weight row $04 to wAISkillScore2 when
; AIGateFoeStatus2Mask22 gives 0; weight row $2C to wAISkillScore when AllyAverageAGLAtLeastFoes
; gives 0; always weight row $BC to wAISkillScore2; WeighLinkRules1RuleBit5; weight row $09 to
; wAISkillScore when ResistanceAverageGateForAISide gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForFoeAIMode3 gives 0. (C1, E-0357)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 47 Sleep, 48 SleepAll. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_Sleep::
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

; TakeMagic's AI score: needs AIScore_TakeMagic_Conditions; then weight row $34 to wAISkillScore2
; when ActorMPBelowThreeQuarters gives 0; WeighLinkRules1RuleBit5. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 49 TakeMagic. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_TakeMagic::
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

; RobMagic's AI score: needs AIScore_RobMagic_Conditions; then always weight row $35 to
; wAISkillScore; weight row $09 to wAISkillScore when PassIfFoesAverageResistanceAtLeast2 gives 0;
; WeighLinkRules1RuleBit5. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 50 RobMagic. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_RobMagic::
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

; StopSpell's AI score: needs AIScore_StopSpell_Conditions; then weight row $04 to wAISkillScore2
; when AIGateFoeStatus2Mask22 gives 0; WeighLinkRules1RuleBit5; always weight row $CC to
; wAISkillScore and weight row $D1 to wAISkillScore2; weight row $36 to wAISkillScore when
; FailIfFoeKnowsSkillList gives 0; weight row $12 to wAISkillScore2 when
; FailIfSkillHasResistanceClass gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForAISide gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForFoeAIMode3 gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 51 StopSpell. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_StopSpell::
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

; PanicAll's AI score: needs AIPanicAllUsable; then always weight row $CA to wAISkillScore;
; WeighLinkRules1RuleBit5; weight row $12 to wAISkillScore2 when FailIfSkillHasResistanceClass gives
; 0; weight row $09 to wAISkillScore when ResistanceAverageGateForAISide gives 0; weight row $09 to
; wAISkillScore when ResistanceAverageGateForFoeAIMode3 gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 52 PanicAll. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_PanicAll::
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

; Ironize's AI score: needs AIIronizeUsable and AIScoreGuardSkill; then always weight row $D0 to
; wAISkillScore; WeighLinkRules1RuleBit5. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 53 Ironize. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Ironize::
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

; MagicBack's AI score: needs AIScore_MagicBack_Conditions; then always weight row $C0 to
; wAISkillScore2; weight row $36 to wAISkillScore when FailIfFoeKnowsSkillList gives 0. (C1, E-0357)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 54 MagicBack, 55 Bounce. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_MagicBack::
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

; Barrier's AI score: needs AIScore_Barrier_Conditions; then weight row $3A to wAISkillScore when
; FailIfFoeKnowsSkills42To47 gives 0; WeighLinkRules1RuleBit5. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 56 Barrier. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Barrier::
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

; MagicWall's AI score: needs AIScore_MagicWall_Conditions; then WeighLinkRules1RuleBit5; weight row
; $36 to wAISkillScore when FailIfFoeKnowsSkillList gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 57 MagicWall. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_MagicWall::
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

; Transform's AI score: needs AIUsableAndActorLacksStatus4Bits67; then weight row $3B to
; wAISkillScore when PassIfTwiceATKAboveHighestFoeDEF gives 0; weight row $3C to wAISkillScore when
; AIScore_Transform_NoWeakerFoe gives 0; always weight row $CE to wAISkillScore;
; WeighLinkRules1RuleBit5. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 58 Transform. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Transform::
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

; BeDragon's AI score: needs AIUsableAndActorLacksStatus4Bits67; then weight row $3A to
; wAISkillScore when FailIfFoeKnowsSkills42To47 gives 0; WeighLinkRules1RuleBit5; weight row $3D to
; wAISkillScore when AIScore_BeDragon_CountHighStats gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 59 BeDragon. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_BeDragon::
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

; Chance's AI score: needs CheckSkillUsableStatusElseResetAISkillScore; then weight row $3F to
; wAISkillScore when AllOtherAlliesHaveStatus0Bit6 gives 0; weight row $40 to wAISkillScore when
; ActorHPIsNotOne gives 0; always weight row $BF to wAISkillScore and weight row $C5 to
; wAISkillScore2; WeighLinkRules1RuleBit5; weight row $42 to wAISkillScore when
; AllySlotsCheckThenFewerThanTwoFoes gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 60 Chance. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Chance::
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

; MegaMagic's AI score: needs AIScore_MegaMagic_Conditions; then weight row $43 to wAISkillScore
; when AllOtherAlliesHaveStatus0Bit6 gives 0; weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row $44 to wAISkillScore2 when
; AnyAllyLacksStatus1Bits23And4Bits01 gives 0; weight row $09 to wAISkillScore when
; PassIfFoesAverageResistanceAtLeast2 gives 0; always weight row $45 to wAISkillScore; weight row
; $0E to wAISkillScore2 when AIScore_MegaMagic_LinkRule gives 0; weight row $46 to wAISkillScore
; when LinkRuleCheckLinkRuleTurnLimitTurnLimit gives 0; weight row $47 to wAISkillScore when
; AllySlotsCheckThenFewerThanTwoFoes gives 0; weight row $48 to wAISkillScore when
; AIScore_MegaMagic_LinkModeAllows gives 0; weight row $3E to wAISkillScore2 when
; AIScore_MegaMagic_FoeHPPlusDEFHigh gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 61 MegaMagic. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_MegaMagic::
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

; BigBang's AI score: needs AIAttackSkillUsable; then weight row $49 to wAISkillScore when
; ActorLacksStatus4Bits67 gives 0; weight row $0A to wAISkillScore2 when
; FailIfFoeAIDamageEstimatesAtLeastEstimate gives 0; weight row $09 to wAISkillScore when
; PassIfFoesAverageResistanceAtLeast2 gives 0; weight row $0D to wAISkillScore when
; PassIfFoeAIDamageEstimatesAtLeastEstimate gives 0; WeighLinkRules1RuleBit1; weight row $46 to
; wAISkillScore when LinkRuleCheckLinkRuleTurnLimitTurnLimit gives 0; weight row $47 to
; wAISkillScore when AllySlotsCheckThenFewerThanTwoFoes gives 0; weight row $15 to wAISkillScore
; when FewerThanTwoFoesPresent gives 0; weight row $4A to wAISkillScore2 when CheckFoeStatus6Bit3
; gives 0; weight row $4B to wAISkillScore when CheckBattleKindNot2Or3 gives 0; weight row $12 to
; wAISkillScore2 when FailIfSkillHasResistanceClass gives 0. (C1, E-0357)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 62 BigBang, 63 Hellblast. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_BigBang::
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
; FailIfSkillHasResistanceClass gives 0. (C1, E-0357)
; AI scoring routine for 8 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 64 FireAir, 65 BlazeAir, 66 Scorching, 67
; WhiteFire, 68 FrigidAir, 69 IceAir, 70 IceStorm, 71 WhiteAir. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_FireAir::
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

; WindBeast's AI score: needs AIAttackSkillUsable; then weight row $10 to wAISkillScore2 when
; FewerThanTwoFoesPresent gives 0; then goes on at AIScore_Vacuum_DamageAndResistWeights. (C1,
; E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 72 WindBeast. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_WindBeast::
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

; Vacuum scoring, the rest: $07 against when the lone foe's HP is not below the damage estimate, $0A
; against when a foe's estimate reaches the limit, $09 for when the foes resist on average, $0D for
; when no estimate reaches the limit; link rule bit 1; $4F for when a foe has 1.5 times the actor's
; HP or more (AI mode 3 and up). (C1, E-0357)
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

; Vacuum's AI score: needs AIAttackSkillUsable; then AIScore_Vacuum_DamageAndResistWeights; weight
; row $15 to wAISkillScore when FewerThanTwoFoesPresent gives 0; weight row $4A to wAISkillScore2
; when CheckFoeStatus6Bit3 gives 0; weight row $12 to wAISkillScore2 when
; FailIfSkillHasResistanceClass gives 0. (C1, E-0357)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 73 Vacuum, 74 Lightning. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_Vacuum::
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

; RockThrow's AI score: needs AIAndFoeLacksStatus3And4; then weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row $0A to wAISkillScore2 when
; FailIfFoeAIDamageEstimatesAtLeastEstimate gives 0; weight row $09 to wAISkillScore when
; PassIfFoesAverageResistanceAtLeast2 gives 0; weight row $0D to wAISkillScore when
; PassIfFoeAIDamageEstimatesAtLeastEstimate gives 0; WeighLinkRules1RuleBit1; weight row $15 to
; wAISkillScore when FewerThanTwoFoesPresent gives 0; weight row $4A to wAISkillScore2 when
; CheckFoeStatus6Bit3 gives 0; weight row $6B to wAISkillScore2 when CheckActorSlot0To3OrLinkModeSet
; gives 0; weight row $12 to wAISkillScore2 when FailIfSkillHasResistanceClass gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 75 RockThrow. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_RockThrow::
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

; Watershot's AI score: needs AIAndFoeLacksStatus3And4; then weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row $0D to wAISkillScore2 when
; FailIfFoeAIDamageEstimatesAtLeastEstimate gives 0; weight row $09 to wAISkillScore when
; PassIfFoesAverageResistanceAtLeast2 gives 0; weight row $0D to wAISkillScore when
; PassIfFoeAIDamageEstimatesAtLeastEstimate gives 0; WeighLinkRules1RuleBit1; weight row $10 to
; wAISkillScore2 when FewerThanTwoFoesPresent gives 0; weight row $4A to wAISkillScore2 when
; CheckFoeStatus6Bit3 gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 76 Watershot. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Watershot::
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

; Tidalwave's AI score: needs AIAndFoeLacksStatus3And4; then weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row $0A to wAISkillScore2 when
; FailIfFoeAIDamageEstimatesAtLeastEstimate gives 0; weight row $09 to wAISkillScore when
; PassIfFoesAverageResistanceAtLeast2 gives 0; weight row $0D to wAISkillScore when
; PassIfFoeAIDamageEstimatesAtLeastEstimate gives 0; WeighLinkRules1RuleBit1; weight row $15 to
; wAISkillScore when FewerThanTwoFoesPresent gives 0; weight row $4A to wAISkillScore2 when
; CheckFoeStatus6Bit3 gives 0; weight row $12 to wAISkillScore2 when FailIfSkillHasResistanceClass
; gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 77 Tidalwave. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Tidalwave::
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
; FailIfSkillHasResistanceClass gives 0. (C1, E-0357)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 78 CallHelp, 79 YellHelp. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_CallHelp::
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
; ActorLacksStatus2Bit1And5Bits01 gives 0. (C1, E-0357)
; AI scoring routine for 4 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 80 FireSlash, 81 VacuSlash, 82 BoltSlash, 83
; IceSlash. It runs checks and adds weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70)
; (E-0083)
AIScore_FireSlash::
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

; SlimeBlow's AI score: needs AIScore_SlimeBlow_Conditions; then always weight row $52 to
; wAISkillScore. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 84 SlimeBlow. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_SlimeBlow::
    farcall AIScore_SlimeBlow_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AddAIWeight

; SlimeBlow scoring, the rest: $07 against for the lone foe, $03 against when a foe has status 7 bit
; 2 (AI mode 3 and up), $53 for when the actor has status 1 bits 2-3 or status 4 bits 0-1; link rule
; bit 1; $66 for outside link battles of kind 0-1; $67 for from the foe-HP check that reads the
; wrong slot, and then $05 for from the status-4 check that reads an address, and $33 against when
; the actor has status 2 bit 1 or status 4 bits 0-1. (C1, E-0357)
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

; DrakSlash's AI score: needs AIScore_DrakSlash_Conditions; then always weight row $52 to
; wAISkillScore; then goes on at AIScore_SlimeBlow_CommonWeights. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 85 DrakSlash. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_DrakSlash::
    farcall AIScore_DrakSlash_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AddAIWeight
    jp AIScore_SlimeBlow_CommonWeights

; BeastCut's AI score: needs AIScore_BeastCut_Conditions; then always weight row $52 to
; wAISkillScore; then goes on at AIScore_SlimeBlow_CommonWeights. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 86 BeastCut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_BeastCut::
    farcall AIScore_BeastCut_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AddAIWeight
    jp AIScore_SlimeBlow_CommonWeights

; BirdBlow's AI score: needs AIScore_BirdBlow_Conditions; then always weight row $52 to
; wAISkillScore; then goes on at AIScore_SlimeBlow_CommonWeights. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 87 BirdBlow. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_BirdBlow::
    farcall AIScore_BirdBlow_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AddAIWeight
    jp AIScore_SlimeBlow_CommonWeights

; BugBlow's AI score: needs AIScore_BugBlow_Conditions; then always weight row $52 to wAISkillScore;
; then goes on at AIScore_SlimeBlow_CommonWeights. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 88 BugBlow. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_BugBlow::
    farcall AIScore_BugBlow_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AddAIWeight
    jp AIScore_SlimeBlow_CommonWeights

; Shears' AI score: needs AIScore_Shears_Conditions; then always weight row $52 to wAISkillScore;
; then goes on at AIScore_SlimeBlow_CommonWeights. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 89 Shears. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Shears::
    farcall AIScore_Shears_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AddAIWeight
    jp AIScore_SlimeBlow_CommonWeights

; DevilCut's AI score: needs AIScore_DevilCut_Conditions; then always weight row $52 to
; wAISkillScore; then goes on at AIScore_SlimeBlow_CommonWeights. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 90 DevilCut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_DevilCut::
    farcall AIScore_DevilCut_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AddAIWeight
    jp AIScore_SlimeBlow_CommonWeights

; ZombieCut's AI score: needs AIScore_ZombieCut_Conditions; then always weight row $52 to
; wAISkillScore; then goes on at AIScore_SlimeBlow_CommonWeights. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 91 ZombieCut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_ZombieCut::
    farcall AIScore_ZombieCut_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AddAIWeight
    jp AIScore_SlimeBlow_CommonWeights

; CleanCut's AI score: needs AIScore_CleanCut_Conditions; then always weight row $52 to
; wAISkillScore; then goes on at AIScore_SlimeBlow_CommonWeights. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 92 CleanCut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_CleanCut::
    farcall AIScore_CleanCut_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AddAIWeight
    jp AIScore_SlimeBlow_CommonWeights

; AquaCut's AI score: needs AIScore_AquaCut_Conditions; then always weight row $52 to wAISkillScore;
; then goes on at AIScore_SlimeBlow_CommonWeights. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 93 AquaCut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_AquaCut::
    farcall AIScore_AquaCut_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AddAIWeight
    jp AIScore_SlimeBlow_CommonWeights

; MetalCut's AI score: needs AIScore_MetalCut_Conditions; then always weight row $53 to
; wAISkillScore; then goes on at AIScore_SlimeBlow_CommonWeights. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 94 MetalCut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_MetalCut::
    farcall AIScore_MetalCut_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0053
    call AddAIWeight
    jp AIScore_SlimeBlow_CommonWeights

; PoisonHit's AI score: needs AIScore_PoisonHit_Conditions; then always weight row $54 to
; wAISkillScore. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 95 PoisonHit. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_PoisonHit::
    farcall AIScore_PoisonHit_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0054
    call AddAIWeight

; PoisonHit scoring, the rest: $55 for when the actor has status 1 bits 2-3 or status 4 bits 0-1;
; link rule bit 1; $66 for outside link battles of kind 0-1; $67 for from the foe-HP check; $39
; against for a foe-side actor outside link battles; $05 for from the status-4 check; $33 against
; for status 2 bit 1 or status 4 bits 0-1; $09 for from each of the two resistance gates. (C1,
; E-0357)
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

; Paralyze's AI score: needs AIScore_Paralyze_Conditions; then always weight row $54 to
; wAISkillScore; then goes on at AIScore_PoisonHit_StatusAndResistWeights. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 96 Paralyze. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Paralyze::
    farcall AIScore_Paralyze_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0054
    call AddAIWeight
    jp AIScore_PoisonHit_StatusAndResistWeights

; NapAttack's AI score: needs AIScore_NapAttack_Conditions; then always weight row $54 to
; wAISkillScore; then goes on at AIScore_PoisonHit_StatusAndResistWeights. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 97 NapAttack. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_NapAttack::
    farcall AIScore_NapAttack_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0054
    call AddAIWeight
    jp AIScore_PoisonHit_StatusAndResistWeights

; table-B AI score: AIScore_SquallHit, then adds a penalty word when the follow-up check fails
; (E-0122)
AIScoreB_SquallHit::
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

; SquallHit's AI score: needs AIScore_SquallHit_Conditions and MaxNegativeScoreWhenAIFlagBit0; then
; weight row $07 to wAISkillScore2 when CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; always
; weight row $C8 to wAISkillScore2; WeighLinkRules1RuleBit1; weight row $56 to wAISkillScore when
; FailIfFoeHPAtMostFourFifthsAIDamageEstimates gives 0; weight row $B4 to wAISkillScore when
; FailIfFoeHurtAndHealerCanCast gives 0; weight row $05 to wAISkillScore when
; ActorStatus4CheckReadsAddress gives 0; weight row $33 to wAISkillScore2 when
; ActorLacksStatus2Bit1And5Bits01 gives 0. (C1, E-0357)
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

; BiAttack's AI score: needs AIScore_BiAttack_Conditions; then weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row $05 to wAISkillScore when
; ActorLacksStatus1Bits23And4Bits01 gives 0; always weight row $C8 to wAISkillScore2;
; WeighLinkRules1RuleBit1; weight row $15 to wAISkillScore when FewerThanTwoFoesPresent gives 0;
; weight row $4A to wAISkillScore2 when CheckFoeStatus6Bit3 gives 0; weight row $56 to wAISkillScore
; when FailIfFoeHPAtMostFourFifthsAIDamageEstimates gives 0; weight row $56 to wAISkillScore when
; AIScore_BiAttack_FoeHPCheck gives 0; weight row $05 to wAISkillScore when
; ActorStatus4CheckReadsAddress gives 0; weight row $33 to wAISkillScore2 when
; ActorLacksStatus2Bit1And5Bits01 gives 0. (C1, E-0357)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 99 BiAttack, 100 QuadHits. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_BiAttack::
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

; RainSlash's AI score: needs AIScore_RainSlash_Conditions; then weight row $05 to wAISkillScore
; when ActorLacksStatus1Bits23And4Bits01 gives 0; always weight row $C3 to wAISkillScore and weight
; row $CB to wAISkillScore2; WeighLinkRules1RuleBit1; weight row $15 to wAISkillScore when
; FewerThanTwoFoesPresent gives 0; weight row $4A to wAISkillScore2 when CheckFoeStatus6Bit3 gives
; 0; weight row $05 to wAISkillScore when ActorStatus4CheckReadsAddress gives 0; weight row $33 to
; wAISkillScore2 when ActorLacksStatus2Bit1And5Bits01 gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 101 RainSlash. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_RainSlash::
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

; MultiCut's AI score: needs AIScore_MultiCut_Conditions; then weight row $12 to wAISkillScore2 when
; FailIfSkillHasResistanceClass gives 0; then goes on at AIScore_MultiCut_DamageAndFoeWeights. (C1,
; E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 102 MultiCut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_MultiCut::
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

; MultiCut scoring, the rest: the lone-foe, estimate and resistance weights ($07, $0A against; $09,
; $0D for); link rule bit 1; $57 for with two or more foes; $4A against when a foe has status 6 bit
; 3 (AI mode 3 and up). (C1, E-0357)
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

; GigaSlash's AI score: needs AIAndFoeLacksStatus3And4; then weight row $33 to wAISkillScore2 when
; ActorLacksStatus2Bit1And5Bits01 gives 0; then goes on at AIScore_MultiCut_DamageAndFoeWeights.
; (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 103 GigaSlash. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_GigaSlash::
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

; ChargeUp's AI score: needs AIScore_ChargeUp_Conditions; then weight row $58 to wAISkillScore when
; PassIfFoeAverageDEFAtMostTwiceAllyATK gives 0; always weight row $BA to wAISkillScore and weight
; row $BF to wAISkillScore2; WeighLinkRules1RuleBit1. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 104 ChargeUp. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_ChargeUp::
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

; PsycheUp's AI score: needs AIScore_PsycheUp_Conditions; then weight row $2D to wAISkillScore2 when
; FastestFoeAGLAbove31PercentOfActor gives 0; weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row $2C to wAISkillScore when
; AllyAverageAGLAtLeastFoes gives 0; weight row $0A to wAISkillScore2 when
; ActorLacksStatus1Bits23And4Bits01 gives 0; always weight row $BA to wAISkillScore and weight row
; $BF to wAISkillScore2; WeighLinkRules1RuleBit1. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 105 PsycheUp. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_PsycheUp::
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

; HighJump's AI score: needs AIScore_HighJump_Conditions; then weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row $58 to wAISkillScore2 when
; PassIfFoeAverageDEFAtMostTwiceAllyATK gives 0; weight row $59 to wAISkillScore2 when
; PassIfTwiceATKAboveHighestFoeDEF gives 0; weight row $0A to wAISkillScore2 when
; ActorLacksStatus1Bits23And4Bits01 gives 0; WeighLinkRules1RuleBit1; weight row $33 to
; wAISkillScore2 when ActorLacksStatus2Bit1And5Bits01 gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 106 HighJump. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_HighJump::
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

; EvilSlash's AI score: needs CheckSkillUsableElseResetAISkillScore; then weight row $5A to
; wAISkillScore when AnyFoeNotBlocked gives 0; weight row $5B to wAISkillScore when
; AnyFoeHasClearStatus3 gives 0; weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row $58 to wAISkillScore when
; PassIfFoeAverageDEFAtMostTwiceAllyATK gives 0; weight row $59 to wAISkillScore when
; PassIfTwiceATKAboveHighestFoeDEF gives 0; weight row $5C to wAISkillScore2 when
; ActorLacksStatus1Bits23And4Bits01 gives 0; always weight row $BD to wAISkillScore;
; WeighLinkRules1RuleBit1; weight row $B0 to wAISkillScore when AIScore_EvilSlash_CheckFoes gives 0;
; weight row $33 to wAISkillScore2 when ActorLacksStatus2Bit1And5Bits01 gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 107 EvilSlash. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_EvilSlash::
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

; Massacre's AI score: needs CheckSkillUsableElseResetAISkillScore; then weight row $11 to
; wAISkillScore2 when AtLeastTwoFoesPresent gives 0; weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; always weight row $C4 to wAISkillScore;
; WeighLinkRules1RuleBit1; weight row $33 to wAISkillScore2 when ActorLacksStatus2Bit1And5Bits01
; gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 108 Massacre. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Massacre::
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

; TwinSlash's AI score: needs AIScore_TwinSlash_Conditions; then weight row $5E to wAISkillScore2
; when AnyFoeLacksStatus0Bit6 gives 0; weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row $5F to wAISkillScore2 when
; PassIfFoeAverageDEFAtMostTwiceAllyATK gives 0; weight row $5F to wAISkillScore2 when
; PassIfTwiceATKAboveHighestFoeDEF gives 0; weight row $60 to wAISkillScore2 when ActorHPIsNotOne
; gives 0; weight row $5C to wAISkillScore2 when ActorLacksStatus1Bits23And4Bits01 gives 0; always
; weight row $C7 to wAISkillScore and weight row $D0 to wAISkillScore2; WeighLinkRules1RuleBit1;
; weight row $62 to wAISkillScore2 when AllyCheckSide0FlagAndOtherSlots gives 0; weight row $33 to
; wAISkillScore2 when ActorLacksStatus2Bit1And5Bits01 gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 109 TwinSlash. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_TwinSlash::
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
; ActorLacksStatus2Bit1And5Bits01 gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 110 Berserker. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Berserker::
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

; Ramming's AI score: needs AIAndAnyFoeNotFullyResistantAndActorHPNotOne; then weight row $5E to
; wAISkillScore2 when AnyFoeLacksStatus0Bit6 gives 0; weight row $17 to wAISkillScore2 when
; AllOtherAlliesHaveStatus0Bit6 gives 0; weight row $64 to wAISkillScore when
; AIScore_Ramming_LastFoeHPAndResist gives 0; then goes on at AIScore_Ramming_HPAndStatusWeights.
; (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 111 Ramming. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Ramming::
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

; Ramming scoring, the rest: $07 against for the lone foe, $09 for from the resistance average; by
; the actor's HP band (AIScore_Ramming_WeighHPBand); $5C against for status 1 bits 2-3 or status 4
; bits 0-1; always $C7 for and $D0 against (SetCToZero); link rule bit 1; $5F against when the side
; flag is set or no other ally is present; $33 against for status 2 bit 1 or status 4 bits 0-1. (C1,
; E-0357)
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

; Kamikaze's AI score: needs AIScore_Kamikaze_Conditions; then weight row $64 to wAISkillScore when
; AIScore_Kamikaze_HealerAllyAndFoeHP gives 0; then goes on at AIScore_Ramming_HPAndStatusWeights.
; (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 112 Kamikaze. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Kamikaze::
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

; SleepAir's AI score: needs AIScore_SleepAir_Conditions; then always weight row $BC to
; wAISkillScore2; then goes on at AIScore_SleepAir_CommonWeights. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 113 SleepAir. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_SleepAir::
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
; AIScore_SleepAir_FoeCountAndResistWeights for the foe-count and resistance weights. (C1, E-0371)
AIScore_SleepAir_CommonWeights::
    call WeighLinkRules1RuleBit3

; SleepAir scoring, the rest: $15 for with two or more foes, $12 against when a foe fully resists
; (AI mode 2 and up), $09 for from each resistance gate. (C1, E-0357)
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

; PalsyAir's AI score: needs AIScore_PalsyAir_Conditions; then goes on at
; AIScore_SleepAir_CommonWeights. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 114 PalsyAir. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_PalsyAir::
    farcall AIScore_PalsyAir_Conditions
    ld a, c
    and a
    ret z
    jr AIScore_SleepAir_CommonWeights

; PoisonGas' AI score: needs AIScore_PoisonGas_Conditions; then goes on at
; AIScore_SleepAir_CommonWeights. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 115 PoisonGas. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_PoisonGas::
    farcall AIScore_PoisonGas_Conditions
    ld a, c
    and a
    ret z
    jr AIScore_SleepAir_CommonWeights

; PoisonAir's AI score: needs AIScore_PoisonAir_Conditions; then goes on at
; AIScore_SleepAir_CommonWeights. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 116 PoisonAir. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_PoisonAir::
    farcall AIScore_PoisonAir_Conditions
    ld a, c
    and a
    ret z
    jr AIScore_SleepAir_CommonWeights

; Curse's AI score: needs AIScore_Curse_Conditions; then always weight row $BD to wAISkillScore2;
; WeighLinkRules1RuleBit5; then goes on at AIScore_SleepAir_FoeCountAndResistWeights. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 117 Curse. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Curse::
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

; OddDance's AI score: needs AIScore_OddDance_Conditions; then always weight row $09 to
; wAISkillScore; always weight row $C2 to wAISkillScore2 and weight row $D2 to wAISkillScore;
; WeighLinkRules1RuleBit2; weight row $09 to wAISkillScore when ResistanceAverageGateForAISide gives
; 0; weight row $09 to wAISkillScore when ResistanceAverageGateForFoeAIMode3 gives 0. (C1, E-0357)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 118 OddDance, 119 RobDance. It runs checks and
; adds weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_OddDance::
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

; PaniDance's AI score: needs AIScore_PaniDance_Conditions; then always weight row $C2 to
; wAISkillScore2 and weight row $CA to wAISkillScore and weight row $D2 to wAISkillScore;
; WeighLinkRules1RuleBit2; weight row $15 to wAISkillScore when FewerThanTwoFoesPresent gives 0;
; weight row $12 to wAISkillScore2 when FailIfSkillHasResistanceClass gives 0; weight row $09 to
; wAISkillScore when ResistanceAverageGateForAISide gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForFoeAIMode3 gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 120 PaniDance. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_PaniDance::
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

; KODance's AI score: needs AIScore_KODance_Conditions; then always weight row $CD to wAISkillScore
; and weight row $CF to wAISkillScore2; WeighLinkRules1RuleBit2; weight row $15 to wAISkillScore
; when FewerThanTwoFoesPresent gives 0; weight row $B5 to wAISkillScore when
; AIGateFoeSlotResistances2Bits45 gives 0; weight row $12 to wAISkillScore2 when
; FailIfSkillHasResistanceClass gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForAISide gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForFoeAIMode3 gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 121 K.O.Dance. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_KODance::
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

; table-B AI score: AIScore_LureDance, then AIAddScoresForTwoLists when usable (E-0122)
AIScoreB_LureDance::
    call AIScore_LureDance
    ld a, c
    and a
    ret z
    call AIAddScoresForTwoLists
    ret

; LureDance's AI score: needs AIScore_LureDance_Conditions; then always weight row $C2 to
; wAISkillScore2 and weight row $D2 to wAISkillScore; WeighLinkRules1RuleBit2; weight row $15 to
; wAISkillScore when FewerThanTwoFoesPresent gives 0; weight row $12 to wAISkillScore2 when
; FailIfSkillHasResistanceClass gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForAISide gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForFoeAIMode3 gives 0; AIAddScoresForTwoLists. (C1, E-0357)
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

; LifeDance's AI score: needs AIScore_LifeDance_Conditions; then always weight row $BC to
; wAISkillScore and weight row $C4 to wAISkillScore2; WeighLinkRules1RuleBit2; weight row $29 to
; wAISkillScore when AllySlotsCheckThenFewerThanTwoFoes gives 0; weight row $29 to wAISkillScore
; when PassIfSideFlagOrOtherAllyPresent gives 0; weight row $2E to wAISkillScore2 when
; AIGateCompareAllyStatAverages gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 123 LifeDance. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_LifeDance::
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

; Hustle's AI score: needs AIScore_Hustle_Conditions; then ForEachPresentSlotOfSideRun; weight row
; $1A to wAISkillScore when AnyFoeLacksStatus0MaskCC gives 0; weight row $1A to wAISkillScore when
; AnyFoeHasClearStatus3 gives 0; weight row $1B to wAISkillScore2 when AnyAllyHPAtMostThreeQuarters
; gives 0; weight row $23 to wAISkillScore when ActorHPIsNotOne gives 0; weight row $23 to
; wAISkillScore when FewerThanTwoAlliesAtHP1 gives 0; always weight row $24 to wAISkillScore;
; WeighLinkRules1RuleBit2; weight row $69 to wAISkillScore when FailIfTwoAlliesBelowHalfHP gives 0.
; (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 124 Hustle. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Hustle::
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

; SideStep's AI score: needs AIScore_SideStep_Conditions; then weight row $6C to wAISkillScore2 when
; AnyFoeLacksStatus5Bits01And1Bit1 gives 0; weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row $6D to wAISkillScore when
; PassIfFoeAverageATKAtMostTwiceAllyDEF gives 0; always weight row $BE to wAISkillScore;
; WeighLinkRules1RuleBit2; weight row $32 to wAISkillScore when CompareFoeAverageATKWithAllyDEF
; gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 125 SideStep. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_SideStep::
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

; SandStorm's AI score: needs AIScore_SandStorm_Conditions. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 126 SandStorm. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_SandStorm::
    farcall AIScore_SandStorm_Conditions
    ld a, c
    and a
    ret z

; SandStorm scoring, the rest: $07 against for the lone foe, $6D for when the foes' average ATK is
; more than twice the allies' DEF (AI mode 2 and up), always $BA against (SetCToZero); link rule bit
; 5; $15 for with two or more foes, $32 for from the ATK/DEF comparison, $12 against for a fully
; resistant foe, $09 for from each resistance gate. (C1, E-0357)
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

; Radiant's AI score: needs AIScore_Radiant_Conditions; then goes on at
; AIScore_SandStorm_DamageAndATKWeights. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 127 Radiant. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Radiant::
    farcall AIScore_Radiant_Conditions
    ld a, c
    and a
    ret z
    jp AIScore_SandStorm_DamageAndATKWeights

; EerieLite's AI score: needs AIScore_EerieLite_Conditions; then always weight row $CC to
; wAISkillScore and weight row $D1 to wAISkillScore2; WeighLinkRules1RuleBit5; weight row $15 to
; wAISkillScore when FewerThanTwoFoesPresent gives 0; weight row $12 to wAISkillScore2 when
; FailIfSkillHasResistanceClass gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForAISide gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForFoeAIMode3 gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 128 EerieLite. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_EerieLite::
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

; Surge's AI score: needs AIScore_Surge_Conditions; then always weight row $6F to wAISkillScore;
; always weight row $CA to wAISkillScore2; WeighLinkRules1RuleBit4. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 129 Surge. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Surge::
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

; UltraDown's AI score: needs AIScore_UltraDown_Conditions; then always weight row $6F to
; wAISkillScore; always weight row $CC to wAISkillScore; WeighLinkRules1RuleBit5. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 130 UltraDown. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_UltraDown::
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

; DeMagic's AI score: needs AIScore_DeMagic_Conditions; then always weight row $71 to wAISkillScore;
; weight row $70 to wAISkillScore when AnyFoeLacksStatus5Bits67 gives 0; always weight row $C9 to
; wAISkillScore2 and weight row $CB to wAISkillScore; WeighLinkRules1RuleBit5. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 131 DeMagic. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_DeMagic::
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

; ThickFog's AI score: needs AIScore_ThickFog_Conditions; then always weight row $C9 to
; wAISkillScore; WeighLinkRules1RuleBit5; weight row $72 to wAISkillScore when
; FailIfFoeKnowsSkillList gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 132 ThickFog. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_ThickFog::
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

; TatsuCall's AI score: needs AIScore_TatsuCall_Conditions; then weight row $73 to wAISkillScore
; when AllOtherAlliesHaveStatus0Bit6 gives 0; weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; always weight row $74 to wAISkillScore and weight
; row $BB to wAISkillScore and weight row $C7 to wAISkillScore2; WeighLinkRules1RuleBit5; weight row
; $75 to wAISkillScore when AllySlotsCheckThenFewerThanTwoFoes gives 0. (C1, E-0357)
; AI scoring routine for 4 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 133 TatsuCall, 134 DiagoCall, 135 SamsiCall, 136
; BazooCall. It runs checks and adds weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70)
; (E-0083)
AIScore_TatsuCall::
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

; SuckAir's AI score: needs AIScore_SuckAir_Conditions; then weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; always weight row $76 to wAISkillScore;
; WeighLinkRules1RuleBit3; weight row $77 to wAISkillScore2 when AnyAllyLacksStatus2Bit2_2 gives 0.
; (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 137 SuckAir. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_SuckAir::
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

; Focus' AI score: needs AIScore_Focus_Conditions; then weight row $07 to wAISkillScore2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; always weight row $C2 to wAISkillScore and weight
; row $D2 to wAISkillScore2; WeighLinkRules1RuleBit5. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 138 Focus. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Focus::
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

; table-B AI score: AIScore_LushLicks, then AIAddScoresForTwoLists when usable (E-0122)
AIScoreB_LushLicks::
    call AIScore_LushLicks
    ld a, c
    and a
    ret z
    call AIAddScoresForTwoLists
    ret

; LushLicks' AI score: needs AILickSkillUsable; then always weight row $78 to wAISkillScore;
; WeighLinkRules1RuleBit5; weight row $09 to wAISkillScore when ResistanceAverageGateForAISide gives
; 0; weight row $09 to wAISkillScore when ResistanceAverageGateForFoeAIMode3 gives 0;
; AIAddScoresForTwoLists. (C1, E-0357)
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

; SickLick's AI score: needs AIStatusLickUsable; then weight row $79 to wAISkillScore2 when
; AnyFoeHasDEFAtLeast2 gives 0; weight row $2C to wAISkillScore when
; PassIfFoeAverageDEFAtMostTwiceAllyATK gives 0; weight row $2C to wAISkillScore when
; PassIfTwiceATKAboveHighestFoeDEF gives 0; always weight row $78 to wAISkillScore;
; WeighLinkRules1RuleBit5; weight row $09 to wAISkillScore when ResistanceAverageGateForAISide gives
; 0; weight row $09 to wAISkillScore when ResistanceAverageGateForFoeAIMode3 gives 0;
; AIAddScoresForTwoLists. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 140 SickLick. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_SickLick::
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

; table-B AI score: AIScore_LegSweep, then AIAddScoresForTwoLists when usable (E-0122)
AIScoreB_LegSweep::
    call AIScore_LegSweep
    ld a, c
    and a
    ret z
    call AIAddScoresForTwoLists
    ret

; LegSweep's AI score: needs AIScore_LegSweep_Conditions; then always weight row $7B to
; wAISkillScore; WeighLinkRules1RuleBit5; weight row $09 to wAISkillScore when
; ResistanceAverageGateForAISide gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForFoeAIMode3 gives 0; AIAddScoresForTwoLists; returns C = 1. (C1, E-0357)
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

; table-B AI score: AIScore_Ahhh, then AIAddScoresForTwoLists when usable (E-0122)
AIScoreB_Ahhh::
    call AIScore_Ahhh
    ld a, c
    and a
    ret z
    call AIAddScoresForTwoLists
    ret

; Ahhh's AI score: needs AILickSkillUsable; then always weight row $C0 to wAISkillScore and weight
; row $C3 to wAISkillScore2 and weight row $CE to wAISkillScore2 and weight row $D3 to
; wAISkillScore; WeighLinkRules1RuleBit5; weight row $09 to wAISkillScore when
; ResistanceAverageGateForAISide gives 0; weight row $09 to wAISkillScore when
; ResistanceAverageGateForFoeAIMode3 gives 0; AIAddScoresForTwoLists; returns C = 1. (C1, E-0357)
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

; Geyser's AI score: needs AIScore_Geyser_Conditions; then always weight row $7D to wAISkillScore;
; WeighLinkRules1RuleBit5; weight row $09 to wAISkillScore when ResistanceAverageGateForAISide gives
; 0; weight row $09 to wAISkillScore when ResistanceAverageGateForFoeAIMode3 gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 145 Geyser. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Geyser::
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

; DanceShut's AI score: needs AIScore_DanceShut_Conditions; then always weight row $7E to
; wAISkillScore; WeighLinkRules1RuleBit2. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 146 DanceShut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_DanceShut::
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

; MouthShut's AI score: needs AIScore_MouthShut_Conditions; then weight row $7F to wAISkillScore
; when FailIfFoeKnowsSkills42To47 gives 0; always weight row $80 to wAISkillScore;
; WeighLinkRules1RuleBit3. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 147 MouthShut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_MouthShut::
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

; StrongD's AI score: needs AIScore_StrongD_Conditions and AIScoreGuardSkill; then
; AIScore_StrongD_WeighHPBand; always weight row $C1 to wAISkillScore2; weight row $00 to
; wAISkillScore when FailIfFoeSkill3DThreatensActorHP gives 0; WeighLinkRules1RuleBit4. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 148 StrongD. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_StrongD::
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

; Dodge's AI score: needs AIScore_Dodge_Conditions and AIScoreGuardSkill; then always weight row $88
; to wAISkillScore and weight row $C1 to wAISkillScore2; WeighLinkRules1RuleBit5. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 149 Dodge. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Dodge::
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

; BladeD's AI score: needs AIGuardSkillUsable and AIScoreGuardSkill; then always weight row $8A to
; wAISkillScore and weight row $C1 to wAISkillScore2; WeighLinkRules1RuleBit4. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 150 BladeD. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_BladeD::
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

; Cover's AI score: needs AIScore_Cover_Conditions; then AIScoreGuardSkill (returning when it gives
; 0); AIScore_Cover_ScoreHPBands; always weight row $CD to wAISkillScore2 and weight row $D1 to
; wAISkillScore; WeighLinkRules1RuleBit5. (C1, E-0357)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 151 Cover, 152 Guardian. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_Cover::
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

; TailWind's AI score: needs AIScore_TailWind_Conditions and AIScore_TailWind_WeighFirstTurn. (C1,
; E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 153 TailWind. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_TailWind::
    farcall AIScore_TailWind_Conditions
    ld a, c
    and a
    ret z
    call AIScore_TailWind_WeighFirstTurn
    ret z

; TailWind scoring, the rest: $3A for and then $8C for when a foe knows skills $42-$47 (AI mode 2
; and up; mode below 2 still adds $8C); link rule bit 5. (C1, E-0357)
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

; StormWind's AI score: needs AIScore_StormWind_Conditions; then goes on at
; AIScore_TailWind_FoeSkillWeights. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 154 StormWind. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_StormWind::
    farcall AIScore_StormWind_Conditions
    ld a, c
    and a
    ret z
    jr AIScore_TailWind_FoeSkillWeights

; AquaWall's AI score: needs AIScore_AquaWall_Conditions; then AIScore_AquaWall_WeighHPBand;
; WeighLinkRules1RuleBit5. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 155 AquaWall. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_AquaWall::
    farcall AIScore_AquaWall_Conditions
    ld a, c
    and a
    ret z
    ld a, [wBattleActor]
    call AIScore_AquaWall_WeighHPBand
    call WeighLinkRules1RuleBit5
    ret

; SealPray's AI score: needs AIScore_SealPray_Conditions; then weight row $8D to wAISkillScore2 when
; AIScore_SealPray_QueuedSkillInList gives 0; weight row $8E to wAISkillScore when
; FailIfFoeKnowsSkills42To47 gives 0; always weight row $CB to wAISkillScore; weight row $8F to
; wAISkillScore when FailIfFoeSkill3DThreatensActorHP gives 0; WeighLinkRules1RuleBit5; weight row
; $90 to wAISkillScore when FailIfFoeKnowsSkillList gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 156 SealPray. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_SealPray::
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

; SuckAll's AI score: needs AIScore_SuckAll_Conditions and AIScoreGuardSkill; then weight row $91 to
; wAISkillScore when AllOtherAlliesHaveStatus0Bit6 gives 0; weight row $92 to wAISkillScore2 when
; AnyAllyHPAtMostThreeQuarters gives 0; AIScore_SuckAll_ScoreHPBands; weight row $8E to
; wAISkillScore when FailIfFoeKnowsSkills42To47 gives 0; WeighLinkRules1RuleBit3; weight row $97 to
; wAISkillScore2 when AnyAllyLacksStatus2Bit2 gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 157 SuckAll. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_SuckAll::
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

; Imitate's AI score: needs AIScore_Imitate_Conditions and AIScoreGuardSkill; then weight row $07 to
; wAISkillScore2 when CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; weight row $98 to
; wAISkillScore when FailIfFoeKnowsSkills42To47 gives 0; always weight row $BB to wAISkillScore2 and
; weight row $C6 to wAISkillScore; WeighLinkRules1RuleBit5; weight row $9A to wAISkillScore when
; FailIfFoeKnowsSkillList gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 158 Imitate. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Imitate::
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

; Meditate's AI score: needs AIScore_Meditate_Conditions; then AIScore_Meditate_WeighHPBand; weight
; row $A1 to wAISkillScore when ActorHPIsNotOne gives 0; always weight row $C2 to wAISkillScore and
; weight row $D2 to wAISkillScore2; WeighLinkRules1RuleBit4; weight row $69 to wAISkillScore2 when
; FailIfTwoAlliesBelowHalfHP gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 159 Meditate. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Meditate::
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

; LifeSong's AI score: needs AIScore_LifeSong_Conditions; then always weight row $CC to
; wAISkillScore2 and weight row $D3 to wAISkillScore2; WeighLinkRules1RuleBit4; weight row $2E to
; wAISkillScore2 when AIGateCompareAllyStatAverages gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 160 LifeSong. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_LifeSong::
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

; LoveRain's AI score: needs AIScore_LoveRain_Conditions; then weight row $1B to wAISkillScore2 when
; AnyAllyHPAtMostThreeQuarters gives 0; ForEachPresentSlotOfSideRun; weight row $A3 to wAISkillScore
; when ActorHPIsNotOne gives 0; weight row $A4 to wAISkillScore when FewerThanTwoAlliesAtHP1 gives
; 0; always weight row $CC to wAISkillScore2 and weight row $CF to wAISkillScore and weight row $D3
; to wAISkillScore2; WeighLinkRules1RuleBit4; weight row $69 to wAISkillScore when
; FailIfTwoAlliesBelowHalfHP gives 0. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 161 LoveRain. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_LoveRain::
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

; Whistle's AI score: never usable (AINeverUsableResetAISkillScore). (C1, E-0357)
; AI scoring routine for 8 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 162 Whistle, 163 Pheromone, 164 StepGuard, 165
; Outside, 166 Informer, 167 Errand, 168 EagleEye, 169 MapMagic. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Whistle::
    farcall AINeverUsableResetAISkillScore
    ret

; Ahhh's second AI score: needs AIStatusLickUsable; then always weight row $A5 to wAISkillScore;
; WeighLinkRules1RuleBit1. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 170 Ahhh. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083) (E-0344: the address in its name dropped or read as the label there; was AIScore_Ahhh_2)
AIScore_Ahhh_2::
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

; ZoneOut's AI score: never usable (AINeverUsableResetAISkillScore). (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 171 ZoneOut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_ZoneOut::
    farcall AINeverUsableResetAISkillScore
    ret

; Guard's AI score: needs MaxNegativeScoreWhenAIFlagBit0 and AIScore_Guard_Conditions; then weight
; row $A6 to wAISkillScore2 when AnyFoeLacksStatus5Bits01And1Bit1 gives 0; weight row $A7 to
; wAISkillScore2 when AllOtherAlliesHaveStatus0Bit6 gives 0; weight row $A8 to wAISkillScore2 when
; ActorHPIsNotOne gives 0; always weight row $A9 to wAISkillScore. (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 172 Guard. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
AIScore_Guard::
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

; PanicAll's second AI score: needs AIPanicAllUsable; then always weight row $37 to wAISkillScore.
; (C1, E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 173 PanicAll. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083) (E-0344: the address in its name dropped or read as the label there; was
; AIScore_PanicAll_2)
AIScore_PanicAll_2::
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

; Ironize's second AI score: needs AIIronizeUsable and AIScoreGuardSkill; then always weight row $38
; to wAISkillScore; weight row $39 to wAISkillScore when FailIfFoeKnowsSkillList gives 0. (C1,
; E-0357)
; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 174 Ironize. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083) (E-0344: the address in its name dropped or read as the label there; was
; AIScore_Ironize_2)
AIScore_Ironize_2::
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

; AI scoring routine (a lone ret: leaves the score unchanged) for skill numbers 175-191 of the
; per-skill far tables (AIScoreRoutineTableA/B, 201 entries); the skill-name table gives these
; numbers the placeholder name 'HighJump' (E-0316)
AIScore_NoWeightA:: ; configured code entry (E-0316); C0
    ret

; AI scoring routine (a lone ret) for skill numbers 192-199 of the per-skill far tables (E-0316)
AIScore_NoWeightB:: ; configured code entry (E-0316); C0
    ret

; AI scoring routine for skill number 200: advances the random value and, when wRandomLo bit 7 is
; clear, sets wAISkillScore to $0000 and the next word to $FFFF (ResetAISkillScoreE2) (E-0316)
AIScore_Skill200:: ; configured code entry (E-0316); C0
    call AdvanceRandom
    ld a, [wRandomLo]
    bit 7, a
    call z, ResetAISkillScoreE2
    ret
    db $c9

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

; the 16-bit word at [HL] += BC; HL is unchanged (E-0353)
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
    db $e5, $2a, $66, $6f, $7d, $91, $6f, $7c, $98, $67, $cb, $7c, $28, $03, $21, $00
    db $00, $44, $4d, $e1, $71, $23, $70, $c9

; wAISkillScore = $0000 and the next word = $FFFF (E-0316)
ResetAISkillScoreE2::
    xor a
    ld hl, wAISkillScore
    ld [hli], a
    ld [hli], a
    ld a, $ff
    ld [hli], a
    ld [hli], a
    ret

; BC = the 16-bit word at ROM bank 6, $4001 + $36 * BC + 2 * wPersonalityIndex (rows of 27 words); A
; = its low byte; clobbers HL, E (E-0353)
ReadBank6TableWord::
    ld a, $36
    call Multiply8By16
    ld a, l
    add $01
    ld l, a
    ld a, h
    adc $40
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

; StrongD scoring by HP band of slot A: bands 0-3 (HP at least a quarter) $83 against; band 4 $84
; for; lower $85 for. (C1, E-0357)
AIScore_StrongD_WeighHPBand::
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

; AquaWall scoring by HP band of slot A: band 0 $81 for, band 1 $82 for, band 2 $83 against, band 3
; $84 against, band 4 $85 against, lower $86 against. (C1, E-0357)
AIScore_AquaWall_WeighHPBand::
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

; For each present slot on side A, scores its HP band for SuckAll
; (AIScore_SuckAll_ScoreHPBands_WeighSlot). (C1, E-0357)
AIScore_SuckAll_ScoreHPBands::
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

; SuckAll by HP band: at least half HP (bands 0-1) $93 for, lower $94 against. (C1, E-0357)
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

; Meditate scoring by HP band of slot A: bands 0-2 $9B, $9C, $9D against; band 3 $9E for, band 4 $9F
; for, lower $A0 for. (C1, E-0357)
AIScore_Meditate_WeighHPBand::
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

; For each present slot on side A, scores its HP band for HealUs
; (AIScore_HealUs_ScoreHPBands_WeighSlot). (C1, E-0357)
AIScore_HealUs_ScoreHPBands::
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

; hTemp0 = C = a present slot (from AIScore_HealUs_ScoreHPBands): adds to wAISkillScore the weight
; row for the slot's HP band (HPBandOfSlotTemp0, 0-5) from the 6-byte table after it ($1E-$22, used
; when C is wBattleActor) or the next one ($AB-$AF, for the other slots). (C1, E-0371)
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

; hTemp0 = C = a present slot (from ForEachPresentSlotOfSideRun, used by AIScore_Hustle and
; AIScore_LoveRain): adds to wAISkillScore the weight row for the slot's HP band (HPBandOfSlotTemp0,
; 0-5) from the 6-byte table after it ($1D-$22, used when C is wBattleActor) or the next one
; ($AA-$AF, for the other slots). (C1, E-0371)
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

; A = slot (the actor): sets hTemp0 = A and adds to wAISkillScore the weight row for the slot's HP
; band (HPBandOfSlotTemp0, 0-5) from the 6-byte table after it ($1D-$22). BC is kept. Called by the
; Ramming and Kamikaze shared weights. (C1, E-0371)
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

; Six weight row ids, $1D to $22 in order, indexed by the HP band 0-5 (HPBandOfSlotTemp0) of the
; slot passed in A. AIScore_Ramming_WeighHPBand adds that row with AddAIWeight with no own-slot or
; other-slot split. The entry is the weight row id given to AddAIWeight in C (B = 0), which reads
; the word of that row for the actor personality (ReadBank6TableWord). (C1, E-0381)
AIScore_Ramming_WeighHPBand_Data::
    db $1d, $1e, $1f, $20, $21, $22

; For each present slot on side A, scores its HP band for Cover
; (AIScore_Cover_ScoreHPBands_WeighSlot). (C1, E-0357)
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

; hTemp0 = C = a present slot (from AIScore_Cover_ScoreHPBands): adds to wAISkillScore the weight
; row for the slot's HP band (HPBandOfSlotTemp0, 0-5) from the 6-byte table after it ($21 down to
; $1D, used when C is wBattleActor) or the next one ($AA-$AE, for the other slots). (C1, E-0371)
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

; Upper: $2B for when the foes' average ATK is more than twice the allies' DEF (C = 0), otherwise
; $13 against. (C1, E-0357)
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

; Sap: $13 against when the allies' ATK check fails (C = 0), otherwise $2B for. (C1, E-0357)
AIScore_Sap_WeighATKVsDEF::
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

; C = (wAIFlag & 1) ^ 1 and returns when non-zero; when bit 0 is set: wAISkillScore = 0,
; wAISkillScore2/wAISkillScore2 + $1 = $FFFF, C = 0 (E-0118)
MaxNegativeScoreWhenAIFlagBit0::
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

; On the first turn (wBattleTurn 0) adds weight row $B6 to wAISkillScore2 and returns C = $FF; on
; later turns returns at once with C = wBattleTurn (non-zero). Called by AIScore_TailWind and
; reached from AIScoreGuardSkill. (C1, E-0371)
AIScore_TailWind_WeighFirstTurn::
    ld a, [wBattleTurn]
    ld c, a
    or a
    ret nz
    ld bc, $00b6
    call AddAIWeightToScore2
    ld c, $ff
    ret

; returns when MaxNegativeScoreWhenAIFlagBit0 applies; otherwise continues with
; AIScore_TailWind_Sub02 (E-0122) (E-0344: the address in its name dropped or read as the label
; there; was AIScoreGuardSkill)
AIScoreGuardSkill::
    call MaxNegativeScoreWhenAIFlagBit0
    ret z
    jr AIScore_TailWind_WeighFirstTurn

; WeighLinkRules1RuleBit4, then adds score word $29 to wAISkillScore when
; AllySlotsCheckThenFewerThanTwoFoes fails and again when PassIfSideFlagOrOtherAllyPresent fails
; (E-0122) (E-0344: the address in its name dropped or read as the label there; was
; AIAddPenaltyForAllySlotsCheckThenFewerThanTwoFoes)
AIAddPenaltyForAllySlotsCheckThenFewerThanTwoFoes::
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

; adds score word $B1 when AIAddScoresForTwoLists_SealingFoes fails and $B2 when
; AIAddScoresForTwoLists_OtherAllies fails (results of 1 count as passing) (E-0124) (E-0344: the
; address in its name dropped or read as the label there; was AIAddScoresForTwoLists; a trailing
; preposition left by the dropped address removed)
AIAddScoresForTwoLists::
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

; adds score word $0E to wAISkillScore2 when LinkRuleCheckLinkRules1Bit6 fails and $0F to
; wAISkillScore when LinkRuleCheckLinkRuleTurnLimitTurnLimit fails (E-0122) (E-0344: the address in
; its name dropped or read as the label there; was AIAddScoresForLinkRuleCheckLinkRules1Bit6)
AIAddScoresForLinkRuleCheckLinkRules1Bit6::
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

; Sacrifice: $0E against when link rule bit 6 forbids it (C = 0). (C1, E-0357)
AIScore_Sacrifice_WeighLinkRule::
    farcall LinkRuleCheckLinkRules1Bit6
    ld a, c
    and a
    jr nz, .return
    ld bc, $000e
    call AddAIWeightToScore2

.return:
    ret

; far-calls CheckLinkRules1RuleBit5; when it fails (C = 0) adds weight-table entry $0E to
; wAISkillScore2 (AddAIWeightToScore2); used by the AI scoring routines (E-0091) (E-0340: the
; address in its name read as its RAM name; was WeighLinkRules1RuleBit5)
WeighLinkRules1RuleBit5::
    farcall CheckLinkRules1RuleBit5
    ld a, c
    and a
    jr nz, .return
    ld bc, $000e
    call AddAIWeightToScore2

.return:
    ret

; far-calls CheckLinkRules1RuleBit4; when it fails (C = 0) adds weight-table entry $0E to
; wAISkillScore2 (AddAIWeightToScore2); used by the AI scoring routines (E-0091) (E-0340: the
; address in its name read as its RAM name; was WeighLinkRules1RuleBit4)
WeighLinkRules1RuleBit4::
    farcall CheckLinkRules1RuleBit4
    ld a, c
    and a
    jr nz, .return
    ld bc, $000e
    call AddAIWeightToScore2

.return:
    ret

; far-calls CheckLinkRules1RuleBit3; when it fails (C = 0) adds weight-table entry $0E to
; wAISkillScore2 (AddAIWeightToScore2); used by the AI scoring routines (E-0091) (E-0340: the
; address in its name read as its RAM name; was WeighLinkRules1RuleBit3)
WeighLinkRules1RuleBit3::
    farcall CheckLinkRules1RuleBit3
    ld a, c
    and a
    jr nz, .return
    ld bc, $000e
    call AddAIWeightToScore2

.return:
    ret

; far-calls CheckLinkRules1RuleBit2; when it fails (C = 0) adds weight-table entry $0E to
; wAISkillScore2 (AddAIWeightToScore2); used by the AI scoring routines (E-0091) (E-0340: the
; address in its name read as its RAM name; was WeighLinkRules1RuleBit2)
WeighLinkRules1RuleBit2::
    farcall CheckLinkRules1RuleBit2
    ld a, c
    and a
    jr nz, .return
    ld bc, $000e
    call AddAIWeightToScore2

.return:
    ret

; far-calls CheckLinkRules1RuleBit1; when it fails (C = 0) adds weight-table entry $0E to
; wAISkillScore2 (AddAIWeightToScore2); used by the AI scoring routines (E-0091) (E-0340: the
; address in its name read as its RAM name; was WeighLinkRules1RuleBit1)
WeighLinkRules1RuleBit1::
    farcall CheckLinkRules1RuleBit1
    ld a, c
    and a
    jr nz, .return
    ld bc, $000e
    call AddAIWeightToScore2

.return:
    ret

; A = battle slot: HL = the word for that slot at wBattleATK; A = its low byte (E-0064)
GetBattleATK_BankE2::
    ld hl, wBattleATK
    jr GetBattleStatWord_BankE2

; HL = wBattleDEF, then the slot's word (GetBattleStatWord_BankE2). (C1, E-0357)
GetBattleDEF_BankE2::
    ld hl, wBattleDEF
    jr GetBattleStatWord_BankE2

; HL = wBattleMaxHP, then the slot's word (GetBattleStatWord_BankE2). (C1, E-0357)
GetBattleMaxHP_BankE2::
    ld hl, wBattleMaxHP
    jr GetBattleStatWord_BankE2

; HL = wBattleMaxMP, then the slot's word (GetBattleStatWord_BankE2). (C1, E-0357)
GetBattleMaxMP_BankE2::
    ld hl, wBattleMaxMP
    jr GetBattleStatWord_BankE2

; HL = wBattleHP, then the slot's word (GetBattleStatWord_BankE2). (C1, E-0357)
GetBattleHP_BankE2::
    ld hl, wBattleHP
    jr GetBattleStatWord_BankE2

; HL = wBattleMP, then the slot's word (GetBattleStatWord_BankE2). (C1, E-0357)
GetBattleMP_BankE2::
    ld hl, wBattleMP
    jr GetBattleStatWord_BankE2
    db $21, $1f, $d9, $18, $0a, $21, $53, $da, $85, $6f, $30, $01, $24, $7e, $c9

; HL = array base, A = battle slot: HL = the 16-bit word at HL + 2 * A (the value, not a pointer); A
; = its low byte. The shared tail of GetBattleATK_BankE2 through GetBattleMP_BankE2, the same bytes
; as ReadBattleWordFromArray in bank $36. (C1, E-0371)
GetBattleStatWord_BankE2::
    add a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes
; appear in 12 banks) (E-0353)
AddDoubleAToHL_BankE2::
    add a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wLinkMode = 1 and wLinkRole bit 1 is set the
; test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the
; reversal, not checked (E-0064) (the same 27 bytes appear in 12 banks)
ActorOnLocalSide_BankE2::
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
TargetOnLocalSide_BankE2::
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

; Status byte 0 of slot E &= the mask for D (ClearBattleStatusBitsWithMaskD_BankE2_Data); a copy of
; the bank $05 routine. (C1, E-0357)
ClearBattleStatusBitsWithMaskD_BankE2::
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

; Seven AND masks indexed by D: $DF (clears bit 5), $FE (bit 0), $00 (all bits), $FD (bit 1), $73
; (bits 7, 3 and 2), $EF (bit 4) and $BF (bit 6). ClearBattleStatusBitsWithMaskD_BankE2 ANDs the
; chosen mask into the first byte of the 9-byte status record of slot E (wBattleStatus + 9 * E), the
; byte that holds the bits BSTAT0_POISONED to BSTAT0_ASLEEP. (C1, E-0381)
ClearBattleStatusBitsWithMaskD_BankE2_Data::
    db $df, $fe, $00, $fd, $73, $ef, $bf

; Sets bit 0 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks) (E-0353)
SetBit0OfLevelUpGainsIndexed_BankE2::
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; Sets bit 1 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks) (E-0353)
SetBit1OfLevelUpGainsIndexed_BankE2::
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; Sets bit 2 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks) (E-0353)
SetBit2OfLevelUpGainsIndexed_BankE2::
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
PersonalityIndexOfSlot_BankE2::
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
CheckSlotStatusBlockWide_BankE2::
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
SlotHasStatus3Or4Bits_BankE2::
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
