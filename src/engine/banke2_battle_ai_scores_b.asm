; ROM bank $E2: battle AI: the second set of scoring routines
; The annotated listing of this bank is build/listing/banke2.asm.

SECTION "Bank E2", ROMX[$4000], BANK[$E2]
    db $e2

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 0 (no name). It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083) (E-0332: skill 0 is Fight, the plain attack: with Guard (skill $AC) it is scored on every
; monster's turn whether or not any record holds it, as the Command menu offers Fight / Skill /
; Guard; C2) (was AIScore_Fight)
; code: calls AIScore_Fight_Conditions; returns if C is 0; calls AnyFoeHasDEFAtLeast2; branches on
; C; calls AddAIWeight; calls AtLeastTwoFoesPresent; branches on C; calls AddAIWeight; calls
; CheckLoneFoeHPNotBelowAIDamageEstimates; branches on C; calls AddAIWeight; calls
; CheckFoeStatus7Bit2; then 23 more steps (see the code) (E-0347)
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
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $0005
    call AddAIWeight

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AddAIWeightToScore2

.return:
    ret

; Blaze's AI score (rows of the personality weight table, ReadBank6TableWord, added to wAISkillScore
; 'score' or wAISkillScore2 'score 2'): needs AIFireSkillUsable; then row $08 to score 2 when
; FailIfFoeAIDamageEstimatesAtLeastEstimate gives 0; row $09 to score when
; PassIfFoesAverageResistanceAtLeast2 gives 0; always row $0B to score; row $0C to score when
; InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate gives 0;
; AIAddScoresForLinkRuleCheckLinkRules1Bit6; row $10 to score 2 when FewerThanTwoFoesPresent gives
; 0. (C1, E-0357)
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
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $000b
    call AddAIWeight

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
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

; Firebal's AI score (rows of the personality weight table, ReadBank6TableWord, added to
; wAISkillScore 'score' or wAISkillScore2 'score 2'): needs AIFireSkillUsable; then row $04 to score
; 2 when AIGateFoeStatus1Mask22 gives 0; row $0A to score 2 when
; FailIfFoeAIDamageEstimatesAtLeastEstimate gives 0; row $09 to score when
; PassIfFoesAverageResistanceAtLeast2 gives 0; always row $0B to score; row $0D to score when
; InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate gives 0;
; AIAddScoresForLinkRuleCheckLinkRules1Bit6; row $14 to score when
; AllySlotsCheckThenFewerThanTwoFoes gives 0; row $15 to score when FewerThanTwoFoesPresent gives 0;
; row $4A to score 2 when CheckFoeStatus6Bit3 gives 0; row $12 to score 2 when
; FailIfAnyFoeFullyResistant gives 0. (C1, E-0357)
; AI scoring routine for 15 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 4 Firebal, 5 Firebane, 6 Firebolt, 7 Bang, 8 Boom,
; 9 Explodet, 10 Infernos, 11 Infermore, 12 Infermost, 13 Bolt .... It runs checks and adds weights
; to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_Firebal::
    farcall AIFireSkillUsable
    ld a, c
    and a
    ret z
    farcall AIGateFoeStatus1Mask22
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
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $000b
    call AddAIWeight

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
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
    jr z, .call_fail_if_any_foe_fully_resistant
    and a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $004a
    call AddAIWeightToScore2

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
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

; Beat's AI score (rows of the personality weight table, ReadBank6TableWord, added to wAISkillScore
; 'score' or wAISkillScore2 'score 2'): needs AIScore_Beat_Conditions; then row $04 to score 2 when
; AIGateFoeStatus1Mask22 gives 0; always row $CD to score and row $CF to score 2;
; AIAddScoresForLinkRuleCheckLinkRules1Bit6; row $15 to score when FewerThanTwoFoesPresent gives 0;
; row $B5 to score when AIGateFoeSlotResistances2Bits45 gives 0; row $12 to score 2 when
; FailIfAnyFoeFullyResistant gives 0; row $09 to score when ResistanceAverageGateForAISide gives 0;
; row $09 to score when ResistanceAverageGateForFoeAIMode3 gives 0; returns C = 1. (C1, E-0357)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 19 Beat, 20 Defeat. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_Beat::
    farcall AIScore_Beat_Conditions
    ld a, c
    and a
    ret z
    farcall AIGateFoeStatus1Mask22
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
    jr z, .call_fail_if_any_foe_fully_resistant
    and a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $00b5
    call AddAIWeight

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 21 Sacrifice. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_Sacrifice_ActorCanPayMPCost_Bank05; returns if C is 0; calls
; ActorLacksStatus4Bits67; branches on C; calls AddAIWeightToScore2; calls
; AllOtherAlliesHaveStatus0Bit6; branches on C; calls AddAIWeightToScore2; calls
; AtLeastTwoFoesPresent; branches on C; calls AddAIWeightToScore2; calls
; AnyAllyHPAtMostThreeQuarters; then 16 more steps (see the code) (E-0347)
AIScore_Sacrifice::
    farcall AIScore_Sacrifice_ActorCanPayMPCost_Bank05
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
    jr nz, .call_ai_score_sacrifice_link_rule_check_link
    ld bc, $00cd
    call AddAIWeight
    ld bc, $00cf
    call AddAIWeightToScore2

.call_ai_score_sacrifice_link_rule_check_link:
    call AIScore_Sacrifice_LinkRuleCheckLinkRules1Bit6
    farcall AIScore_Sacrifice_GetBattleMaxHP_Bank05
    ld a, c
    and a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $0019
    call AddAIWeight

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0012
    call AddAIWeightToScore2

.return:
    ret

; Heal's AI score (rows of the personality weight table, ReadBank6TableWord, added to wAISkillScore
; 'score' or wAISkillScore2 'score 2'): needs AIHealUsable; then row $69 to score 2 when
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
    jr z, AIScore_HealUs_AnyFoeLacksStatus0MaskCC
    and a
    jr nz, AIScore_HealUs_AnyFoeLacksStatus0MaskCC
    ld bc, $0069
    call AddAIWeightToScore2

; HealUs scoring, the rest: adds weight $1A to wAISkillScore when every present foe has one of
; status 0 bits $CC (AnyFoeLacksStatus0MaskCC gives 0), $1A again when every present foe has some
; status 3 bit, $1B to wAISkillScore2 when no ally is at three quarters of its HP or less; adds by
; each ally's HP band (AIScore_HealUs_CarryUnlessBattleSlotOutSlotEmpty); $23 when the actor's HP is
; 1; always $24 and $C8 (the SetCToZero test cannot pass); then link rule bit 4. (C1, E-0357)
AIScore_HealUs_AnyFoeLacksStatus0MaskCC::
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
    call AIScore_HealUs_CarryUnlessBattleSlotOutSlotEmpty
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

; HealUs's AI score (rows of the personality weight table, ReadBank6TableWord, added to
; wAISkillScore 'score' or wAISkillScore2 'score 2'): needs AIHealUsable; then
; AIScore_HealUs_AnyFoeLacksStatus0MaskCC; row $23 to score when FewerThanTwoAlliesAtHP1 gives 0;
; row $69 to score when FailIfTwoAlliesBelowHalfHP gives 0. (C1, E-0357)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 25 HealUs, 26 HealUsAll. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_HealUs::
    farcall AIHealUsable
    ld a, c
    and a
    ret z
    call AIScore_HealUs_AnyFoeLacksStatus0MaskCC
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

; MPass' AI score: needs AIScore_MPass_ActorLacksStatus4Bits67 and adds nothing. (C1, E-0357)
; AI scoring routine for 3 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 27 MPass, 28 MPassmore, 29 MPassmost. It runs
; checks and adds weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_MPass::
    farcall AIScore_MPass_ActorLacksStatus4Bits67
    ld a, c
    and a
    ret z
    ret

; Vivify's AI score (rows of the personality weight table, ReadBank6TableWord, added to
; wAISkillScore 'score' or wAISkillScore2 'score 2'): needs AIScore_Vivify_Conditions; then
; AIAddPenaltyForAllySlotsCheckThenFewerThanTwoFoes; row $2E to score 2 when
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 32 Farewell. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_Farewell_Conditions; returns if C is 0; calls
; AIAddPenaltyForAllySlotsCheckThenFewerThanTwoFoes; calls SetCToZero; branches on C; calls
; AddAIWeight; calls AddAIWeightToScore2; calls AIGateCompareAllyStatAverages; branches on C; calls
; AddAIWeightToScore2 (E-0347)
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 33 Antidote. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_Antidote_Conditions; returns if C is 0; calls AddAIWeight; calls
; WeighLinkRules1RuleBit4 (E-0347)
AIScore_Antidote::
    farcall AIScore_Antidote_Conditions
    ld a, c
    and a
    ret z
    ld bc, $002a
    call AddAIWeight
    call WeighLinkRules1RuleBit4
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 34 DeChaos. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_DeChaos_Conditions; returns if C is 0; calls AddAIWeight; calls
; WeighLinkRules1RuleBit4 (E-0347)
AIScore_DeChaos::
    farcall AIScore_DeChaos_Conditions
    ld a, c
    and a
    ret z
    ld bc, $002a
    call AddAIWeight
    call WeighLinkRules1RuleBit4
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 35 NumbOff. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_NumbOff_Conditions; returns if C is 0; calls AddAIWeight; calls
; WeighLinkRules1RuleBit4 (E-0347)
AIScore_NumbOff::
    farcall AIScore_NumbOff_Conditions
    ld a, c
    and a
    ret z
    ld bc, $002a
    call AddAIWeight
    call WeighLinkRules1RuleBit4
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 36 CurseOff. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_CurseOff_Conditions; returns if C is 0; calls AddAIWeight; calls
; WeighLinkRules1RuleBit4 (E-0347)
AIScore_CurseOff::
    farcall AIScore_CurseOff_Conditions
    ld a, c
    and a
    ret z
    ld bc, $002a
    call AddAIWeight
    call WeighLinkRules1RuleBit4
    ret

; Upper's AI score (rows of the personality weight table, ReadBank6TableWord, added to wAISkillScore
; 'score' or wAISkillScore2 'score 2'): needs AIScore_Upper_Conditions; then row $07 to score 2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; WeighLinkRules1RuleBit5;
; AIScore_Upper_CompareFoeAverageATKWithAllyDEF; always row $C1 to score 2. (C1, E-0357)
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
    call AIScore_Upper_CompareFoeAverageATKWithAllyDEF
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .return
    ld bc, $00c1
    call AddAIWeightToScore2

.return:
    ret

; Sap's AI score (rows of the personality weight table, ReadBank6TableWord, added to wAISkillScore
; 'score' or wAISkillScore2 'score 2'): needs AIScore_Sap_Conditions; then row $07 to score 2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; row $2C to score when
; PassIfFoeAverageDEFAtMostTwiceAllyATK gives 0; row $2C to score when
; PassIfTwiceATKAboveLowestFoeDEF gives 0; always row $CC to score and row $D1 to score 2;
; WeighLinkRules1RuleBit5; row $12 to score 2 when FailIfAnyFoeFullyResistant gives 0; row $09 to
; score when ResistanceAverageGateForAISide gives 0; row $09 to score when
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
    jr z, .call_pass_if_twice_atk_above_lowest_foe_def
    and a
    jr nz, .call_pass_if_twice_atk_above_lowest_foe_def
    ld bc, $002c
    call AddAIWeight

.call_pass_if_twice_atk_above_lowest_foe_def:
    farcall PassIfTwiceATKAboveLowestFoeDEF
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
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp $01
    jr z, .call_ai_score_sap_add_ai_weight_to_score2
    and a
    jr nz, .call_ai_score_sap_add_ai_weight_to_score2
    ld bc, $0012
    call AddAIWeightToScore2

.call_ai_score_sap_add_ai_weight_to_score2:
    call AIScore_Sap_AddAIWeightToScore2
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

; Speed's AI score (rows of the personality weight table, ReadBank6TableWord, added to wAISkillScore
; 'score' or wAISkillScore2 'score 2'): needs AIScore_Speed_Conditions; then row $2D to score 2 when
; FastestFoeAGLAbove31PercentOfActor gives 0; row $2C to score when AllyAverageAGLAtLeastFoes gives
; 0; WeighLinkRules1RuleBit5. (C1, E-0357)
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

; Slow's AI score (rows of the personality weight table, ReadBank6TableWord, added to wAISkillScore
; 'score' or wAISkillScore2 'score 2'): needs AIScore_Slow_Conditions; then row $04 to score 2 when
; AIGateFoeStatus1Mask22 gives 0; row $2D to score 2 when FastestFoeAGLAbove31PercentOfActor gives
; 0; row $2C to score when AllyAverageAGLAtLeastFoes gives 0; always row $CC to score and row $D1 to
; score 2; WeighLinkRules1RuleBit5; row $12 to score 2 when FailIfAnyFoeFullyResistant gives 0; row
; $09 to score when ResistanceAverageGateForAISide gives 0; row $09 to score when
; ResistanceAverageGateForFoeAIMode3 gives 0. (C1, E-0357)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 43 Slow, 44 SlowAll. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_Slow::
    farcall AIScore_Slow_Conditions
    ld a, c
    and a
    ret z
    farcall AIGateFoeStatus1Mask22
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
    farcall FailIfAnyFoeFullyResistant
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 45 TwinHits. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_TwinHits_CheckSkillUsableStatusElseResetAISkillScore; returns if C is 0; calls
; AIScore_TwinHits_ReadSlotAIModeIndexed_Bank05; branches on C; calls AddAIWeight; calls
; AIScore_TwinHits_ReadSlotAIModeIndexed_Bank05_AIScore_TwinHits_CarryUnlessBattleSlotOutSlotEmpty;
; branches on C; calls AddAIWeight; calls SetCToZero; branches on C; calls AddAIWeight; calls
; WeighLinkRules1RuleBit5; then 3 more steps (see the code) (E-0347)
AIScore_TwinHits::
    farcall AIScore_TwinHits_CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a
    ret z
    farcall AIScore_TwinHits_ReadSlotAIModeIndexed_Bank05
    ld a, c
    cp $01
    jr z, .call_ai_score_twin_hits_read_slot_ai_mode
    and a
    jr nz, .call_ai_score_twin_hits_read_slot_ai_mode
    ld bc, $002f
    call AddAIWeight

.call_ai_score_twin_hits_read_slot_ai_mode:
    farcall AIScore_TwinHits_ReadSlotAIModeIndexed_Bank05_AIScore_TwinHits_CarryUnlessBattleSlotOutSlotEmpty
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 46 Surround. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_Surround_Conditions; returns if C is 0; calls AIGateFoeStatus1Mask22; branches
; on C; calls AddAIWeightToScore2; calls CheckLoneFoeHPNotBelowAIDamageEstimates; branches on C;
; calls AddAIWeightToScore2; calls PassIfFoeAverageATKAtMostTwiceAllyDEF; branches on C; calls
; AddAIWeight; calls SetCToZero; then 17 more steps (see the code) (E-0347)
AIScore_Surround::
    farcall AIScore_Surround_Conditions
    ld a, c
    and a
    ret z
    farcall AIGateFoeStatus1Mask22
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
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $0032
    call AddAIWeight

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
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

; Sleep's AI score (rows of the personality weight table, ReadBank6TableWord, added to wAISkillScore
; 'score' or wAISkillScore2 'score 2'): needs AIScore_Sleep_Conditions; then row $04 to score 2 when
; AIGateFoeStatus1Mask22 gives 0; row $2C to score when AllyAverageAGLAtLeastFoes gives 0; always
; row $BC to score 2; WeighLinkRules1RuleBit5; row $09 to score when ResistanceAverageGateForAISide
; gives 0; row $09 to score when ResistanceAverageGateForFoeAIMode3 gives 0. (C1, E-0357)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 47 Sleep, 48 SleepAll. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_Sleep::
    farcall AIScore_Sleep_Conditions
    ld a, c
    and a
    ret z
    farcall AIGateFoeStatus1Mask22
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 49 TakeMagic. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_TakeMagic_Conditions; returns if C is 0; calls ActorMPBelowThreeQuarters;
; branches on C; calls AddAIWeightToScore2; calls WeighLinkRules1RuleBit5 (E-0347)
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 50 RobMagic. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_RobMagic_Conditions; returns if C is 0; calls AddAIWeight; calls
; PassIfFoesAverageResistanceAtLeast2; branches on C; calls AddAIWeight; calls
; WeighLinkRules1RuleBit5 (E-0347)
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 51 StopSpell. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_StopSpell_Conditions; returns if C is 0; calls AIGateFoeStatus1Mask22;
; branches on C; calls AddAIWeightToScore2; calls WeighLinkRules1RuleBit5; calls SetCToZero;
; branches on C; calls AddAIWeight; calls AddAIWeightToScore2; calls AIModeAtLeast2AndFoeLacks;
; branches on C; then 10 more steps (see the code) (E-0347)
AIScore_StopSpell::
    farcall AIScore_StopSpell_Conditions
    ld a, c
    and a
    ret z
    farcall AIGateFoeStatus1Mask22
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
    jr nz, .call_ai_mode_at_least2_and_foe_lacks
    ld bc, $00cc
    call AddAIWeight
    ld bc, $00d1
    call AddAIWeightToScore2

.call_ai_mode_at_least2_and_foe_lacks:
    farcall AIModeAtLeast2AndFoeLacks
    ld a, c
    cp $01
    jr z, .call_fail_if_any_foe_fully_resistant
    and a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $0036
    call AddAIWeight

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 52 PanicAll. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIPanicAllUsable; returns if C is 0; calls SetCToZero; branches on C; calls
; AddAIWeight; calls WeighLinkRules1RuleBit5; calls FailIfAnyFoeFullyResistant; branches on C; calls
; AddAIWeightToScore2; calls ResistanceAverageGateForAISide; branches on C; calls AddAIWeight; then
; 3 more steps (see the code) (E-0347)
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
    farcall FailIfAnyFoeFullyResistant
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 53 Ironize. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIIronizeUsable; returns if C is 0; calls AIScoreGuardSkill; may return early; calls
; SetCToZero; branches on C; calls AddAIWeight; calls WeighLinkRules1RuleBit5 (E-0347)
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

; MagicBack's AI score (rows of the personality weight table, ReadBank6TableWord, added to
; wAISkillScore 'score' or wAISkillScore2 'score 2'): needs AIScore_MagicBack_Conditions; then
; always row $C0 to score 2; row $36 to score when AIModeAtLeast2AndFoeLacks gives 0. (C1, E-0357)
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
    jr nz, .call_ai_mode_at_least2_and_foe_lacks
    ld bc, $00c0
    call AddAIWeightToScore2

.call_ai_mode_at_least2_and_foe_lacks:
    farcall AIModeAtLeast2AndFoeLacks
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0036
    call AddAIWeight

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 56 Barrier. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_Barrier_Conditions; returns if C is 0; calls FailIfFoeKnowsSkills42To47;
; branches on C; calls AddAIWeight; calls WeighLinkRules1RuleBit5 (E-0347)
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 57 MagicWall. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_MagicWall_Conditions; returns if C is 0; calls WeighLinkRules1RuleBit5; calls
; AIModeAtLeast2AndFoeLacks; branches on C; calls AddAIWeight (E-0347)
AIScore_MagicWall::
    farcall AIScore_MagicWall_Conditions
    ld a, c
    and a
    ret z
    call WeighLinkRules1RuleBit5
    farcall AIModeAtLeast2AndFoeLacks
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0036
    call AddAIWeight

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 58 Transform. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIUsableAndActorLacksStatus4Bits67; returns if C is 0; calls
; PassIfTwiceATKAboveLowestFoeDEF; branches on C; calls AddAIWeight; calls
; AIScore_Transform_ReadSlotAIModeIndexed_Bank05; branches on C; calls AddAIWeight; calls
; SetCToZero; branches on C; calls AddAIWeight; calls WeighLinkRules1RuleBit5 (E-0347)
AIScore_Transform::
    farcall AIUsableAndActorLacksStatus4Bits67
    ld a, c
    and a
    ret z
    farcall PassIfTwiceATKAboveLowestFoeDEF
    ld a, c
    cp $01
    jr z, .call_ai_score_transform_read_slot_ai_mode
    and a
    jr nz, .call_ai_score_transform_read_slot_ai_mode
    ld bc, $003b
    call AddAIWeight

.call_ai_score_transform_read_slot_ai_mode:
    farcall AIScore_Transform_ReadSlotAIModeIndexed_Bank05
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 59 BeDragon. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIUsableAndActorLacksStatus4Bits67; returns if C is 0; calls
; FailIfFoeKnowsSkills42To47; branches on C; calls AddAIWeight; calls WeighLinkRules1RuleBit5; calls
; AIScore_BeDragon_GetBattleMaxHP_Bank05; branches on C; calls AddAIWeight (E-0347)
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
    farcall AIScore_BeDragon_GetBattleMaxHP_Bank05
    ld a, c
    and a
    jr nz, .return
    ld bc, $003d
    call AddAIWeight

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 60 Chance. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls CheckSkillUsableStatusElseResetAISkillScore; returns if C is 0; calls
; AllOtherAlliesHaveStatus0Bit6; branches on C; calls AddAIWeight; calls ActorHPIsNotOne; branches
; on C; calls AddAIWeight; calls SetCToZero; branches on C; calls AddAIWeight; calls
; AddAIWeightToScore2; then 4 more steps (see the code) (E-0347)
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 61 MegaMagic. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_MegaMagic_AIAttackSkillUsable; returns if C is 0; calls
; AllOtherAlliesHaveStatus0Bit6; branches on C; calls AddAIWeight; calls
; CheckLoneFoeHPNotBelowAIDamageEstimates; branches on C; calls AddAIWeightToScore2; calls
; AnyAllyLacksStatus1Bits23And4Bits01; branches on C; calls AddAIWeightToScore2; calls
; PassIfFoesAverageResistanceAtLeast2; then 20 more steps (see the code) (E-0347)
AIScore_MegaMagic::
    farcall AIScore_MegaMagic_AIAttackSkillUsable
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
    jr nz, .call_ai_score_mega_magic_read_link_mode_and
    ld bc, $0045
    call AddAIWeight

.call_ai_score_mega_magic_read_link_mode_and:
    farcall AIScore_MegaMagic_ReadLinkModeAndBattleActor
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
    jr nz, .call_ai_score_mega_magic_read_link_mode
    ld bc, $0047
    call AddAIWeight

.call_ai_score_mega_magic_read_link_mode:
    farcall AIScore_MegaMagic_ReadLinkMode
    ld a, c
    and a
    jr nz, .call_ai_score_mega_magic_read_slot_ai_mode
    ld bc, $0048
    call AddAIWeight

.call_ai_score_mega_magic_read_slot_ai_mode:
    farcall AIScore_MegaMagic_ReadSlotAIModeIndexed_Bank05
    ld a, c
    cp $01
    jr z, .return
    or a
    jr nz, .return
    ld bc, $003e
    call AddAIWeightToScore2

.return:
    ret

; BigBang's AI score (rows of the personality weight table, ReadBank6TableWord, added to
; wAISkillScore 'score' or wAISkillScore2 'score 2'): needs AIAttackSkillUsable; then row $49 to
; score when ActorLacksStatus4Bits67 gives 0; row $0A to score 2 when
; FailIfFoeAIDamageEstimatesAtLeastEstimate gives 0; row $09 to score when
; PassIfFoesAverageResistanceAtLeast2 gives 0; row $0D to score when
; InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate gives 0; WeighLinkRules1RuleBit1; row
; $46 to score when LinkRuleCheckLinkRuleTurnLimitTurnLimit gives 0; row $47 to score when
; AllySlotsCheckThenFewerThanTwoFoes gives 0; row $15 to score when FewerThanTwoFoesPresent gives 0;
; row $4A to score 2 when CheckFoeStatus6Bit3 gives 0; row $4B to score when CheckBattleKindNot2Or3
; gives 0; row $12 to score 2 when FailIfAnyFoeFullyResistant gives 0. (C1, E-0357)
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
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $0009
    call AddAIWeight

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
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
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $004b
    call AddAIWeight

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0012
    call AddAIWeightToScore2

.return:
    ret

; AI scoring routine for 8 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 64 FireAir, 65 BlazeAir, 66 Scorching, 67
; WhiteFire, 68 FrigidAir, 69 IceAir, 70 IceStorm, 71 WhiteAir. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_FireAir_AIAttackSkillUsable; returns if C is 0; calls
; AIScore_FireAir_ReadSlotAIModeIndexed_Bank05; branches on C; calls AddAIWeightToScore2; calls
; AtLeastTwoFoesPresent; branches on C; calls AddAIWeightToScore2; calls
; FailIfFoeAIDamageEstimatesAtLeastEstimate; branches on C; calls AddAIWeightToScore2; calls
; PassIfFoesAverageResistanceAtLeast2; then 24 more steps (see the code) (E-0347)
AIScore_FireAir::
    farcall AIScore_FireAir_AIAttackSkillUsable
    ld a, c
    and a
    ret z
    farcall AIScore_FireAir_ReadSlotAIModeIndexed_Bank05
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
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $006a
    call AddAIWeight

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
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
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $004e
    call AddAIWeightToScore2

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0012
    call AddAIWeightToScore2

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 72 WindBeast. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIAttackSkillUsable; returns if C is 0; calls FewerThanTwoFoesPresent; may continue in
; AIScore_Vacuum_CheckLoneFoeHPNotBelowAIDamageEstimates; calls AddAIWeightToScore2 (E-0347)
AIScore_WindBeast::
    farcall AIAttackSkillUsable
    ld a, c
    and a
    ret z
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, AIScore_Vacuum_CheckLoneFoeHPNotBelowAIDamageEstimates
    ld bc, $0010
    call AddAIWeightToScore2

; Vacuum scoring, the rest: $07 against when the lone foe's HP is not below the damage estimate, $0A
; against when a foe's estimate reaches the limit, $09 for when the foes resist on average, $0D for
; when no estimate reaches the limit; link rule bit 1; $4F for when a foe has 1.5 times the actor's
; HP or more (AI mode 3 and up). (C1, E-0357)
AIScore_Vacuum_CheckLoneFoeHPNotBelowAIDamageEstimates::
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
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $0009
    call AddAIWeight

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
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

; Vacuum's AI score (rows of the personality weight table, ReadBank6TableWord, added to
; wAISkillScore 'score' or wAISkillScore2 'score 2'): needs AIAttackSkillUsable; then
; AIScore_Vacuum_CheckLoneFoeHPNotBelowAIDamageEstimates; row $15 to score when
; FewerThanTwoFoesPresent gives 0; row $4A to score 2 when CheckFoeStatus6Bit3 gives 0; row $12 to
; score 2 when FailIfAnyFoeFullyResistant gives 0. (C1, E-0357)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 73 Vacuum, 74 Lightning. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_Vacuum::
    farcall AIAttackSkillUsable
    ld a, c
    and a
    ret z
    call AIScore_Vacuum_CheckLoneFoeHPNotBelowAIDamageEstimates
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
    jr z, .call_fail_if_any_foe_fully_resistant
    and a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $004a
    call AddAIWeightToScore2

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0012
    call AddAIWeightToScore2

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 75 RockThrow. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIAndFoeLacksStatus3And4; returns if C is 0; calls
; CheckLoneFoeHPNotBelowAIDamageEstimates; branches on C; calls AddAIWeightToScore2; calls
; FailIfFoeAIDamageEstimatesAtLeastEstimate; branches on C; calls AddAIWeightToScore2; calls
; PassIfFoesAverageResistanceAtLeast2; branches on C; calls AddAIWeight; calls
; InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate; then 15 more steps (see the code)
; (E-0347)
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
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $0009
    call AddAIWeight

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
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
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $006b
    call AddAIWeightToScore2

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0012
    call AddAIWeightToScore2

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 76 Watershot. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIAndFoeLacksStatus3And4; returns if C is 0; calls
; CheckLoneFoeHPNotBelowAIDamageEstimates; branches on C; calls AddAIWeightToScore2; calls
; FailIfFoeAIDamageEstimatesAtLeastEstimate; branches on C; calls AddAIWeightToScore2; calls
; PassIfFoesAverageResistanceAtLeast2; branches on C; calls AddAIWeight; calls
; InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate; then 9 more steps (see the code)
; (E-0347)
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
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $0009
    call AddAIWeight

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 77 Tidalwave. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIAndFoeLacksStatus3And4; returns if C is 0; calls
; CheckLoneFoeHPNotBelowAIDamageEstimates; branches on C; calls AddAIWeightToScore2; calls
; FailIfFoeAIDamageEstimatesAtLeastEstimate; branches on C; calls AddAIWeightToScore2; calls
; PassIfFoesAverageResistanceAtLeast2; branches on C; calls AddAIWeight; calls
; InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate; then 12 more steps (see the code)
; (E-0347)
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
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $0009
    call AddAIWeight

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
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
    jr z, .call_fail_if_any_foe_fully_resistant
    and a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $004a
    call AddAIWeightToScore2

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0012
    call AddAIWeightToScore2

.return:
    ret

; CallHelp's AI score (rows of the personality weight table, ReadBank6TableWord, added to
; wAISkillScore 'score' or wAISkillScore2 'score 2'): needs AIAndFoeLacksStatus3And4; then row $07
; to score 2 when CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; row $08 to score 2 when
; FailIfFoeAIDamageEstimatesAtLeastEstimate gives 0; row $09 to score when
; PassIfFoesAverageResistanceAtLeast2 gives 0; row $0A to score 2 when
; ActorLacksStatus1Bits23And4Bits01 gives 0; always row $BE to score 2 and row $C5 to score; row $0D
; to score when InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate gives 0;
; WeighLinkRules1RuleBit1; row $15 to score when FewerThanTwoFoesPresent gives 0; row $4A to score 2
; when CheckFoeStatus6Bit3 gives 0; row $4F to score when FailIfFoeHPAtLeast150PercentOfActor gives
; 0; row $12 to score 2 when FailIfAnyFoeFullyResistant gives 0. (C1, E-0357)
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
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $00be
    call AddAIWeightToScore2
    ld bc, $00c5
    call AddAIWeight

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
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
    jr z, .call_fail_if_any_foe_fully_resistant
    and a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $004f
    call AddAIWeight

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0012
    call AddAIWeightToScore2

.return:
    ret

; FireSlash's AI score (rows of the personality weight table, ReadBank6TableWord, added to
; wAISkillScore 'score' or wAISkillScore2 'score 2'): needs AIAndFoeLacksStatus3And4; then row $07
; to score 2 when CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; row $03 to score 2 when
; CheckFoeStatus7Bit2 gives 0; row $08 to score 2 when FailIfFoeAIDamageEstimatesAtLeastEstimate
; gives 0; row $09 to score when PassIfFoesAverageResistanceAtLeast2 gives 0; row $55 to score when
; ActorLacksStatus1Bits23And4Bits01 gives 0; row $0D to score when
; InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate gives 0; WeighLinkRules1RuleBit1; row
; $66 to score when CheckBattleKindAtLeast2OrLinkModeSet gives 0; row $67 to score when
; FoeHPCheckReadsWrongSlot gives 0; row $05 to score when ActorStatus4CheckReadsAddress gives 0; row
; $33 to score 2 when ActorLacksStatus2Bit1And4Bits01 gives 0. (C1, E-0357)
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
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $0055
    call AddAIWeight

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
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
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $0005
    call AddAIWeight

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AddAIWeightToScore2

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 84 SlimeBlow. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_SlimeBlow_Conditions; returns if C is 0; calls AddAIWeight (E-0347)
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
AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates::
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
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $0005
    call AddAIWeight

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AddAIWeightToScore2

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 85 DrakSlash. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_DrakSlash_Conditions; returns if C is 0; calls AddAIWeight; continues in
; AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates (E-0347)
AIScore_DrakSlash::
    farcall AIScore_DrakSlash_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AddAIWeight
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 86 BeastCut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_BeastCut_Conditions; returns if C is 0; calls AddAIWeight; continues in
; AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates (E-0347)
AIScore_BeastCut::
    farcall AIScore_BeastCut_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AddAIWeight
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 87 BirdBlow. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_BirdBlow_Conditions; returns if C is 0; calls AddAIWeight; continues in
; AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates (E-0347)
AIScore_BirdBlow::
    farcall AIScore_BirdBlow_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AddAIWeight
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 88 BugBlow. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_BugBlow_Conditions; returns if C is 0; calls AddAIWeight; continues in
; AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates (E-0347)
AIScore_BugBlow::
    farcall AIScore_BugBlow_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AddAIWeight
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 89 Shears. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_Shears_Conditions; returns if C is 0; calls AddAIWeight; continues in
; AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates (E-0347)
AIScore_Shears::
    farcall AIScore_Shears_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AddAIWeight
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 90 DevilCut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_DevilCut_Conditions; returns if C is 0; calls AddAIWeight; continues in
; AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates (E-0347)
AIScore_DevilCut::
    farcall AIScore_DevilCut_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AddAIWeight
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 91 ZombieCut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_ZombieCut_Conditions; returns if C is 0; calls AddAIWeight; continues in
; AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates (E-0347)
AIScore_ZombieCut::
    farcall AIScore_ZombieCut_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AddAIWeight
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 92 CleanCut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_CleanCut_Conditions; returns if C is 0; calls AddAIWeight; continues in
; AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates (E-0347)
AIScore_CleanCut::
    farcall AIScore_CleanCut_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AddAIWeight
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 93 AquaCut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_AquaCut_Conditions; returns if C is 0; calls AddAIWeight; continues in
; AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates (E-0347)
AIScore_AquaCut::
    farcall AIScore_AquaCut_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AddAIWeight
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 94 MetalCut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_MetalCut_Conditions; returns if C is 0; calls AddAIWeight; continues in
; AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates (E-0347)
AIScore_MetalCut::
    farcall AIScore_MetalCut_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0053
    call AddAIWeight
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 95 PoisonHit. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_PoisonHit_Conditions; returns if C is 0; calls AddAIWeight (E-0347)
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
AIScore_PoisonHit_CallActorLacksStatus1Bits23And4Bits01::
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
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $0005
    call AddAIWeight

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 96 Paralyze. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_Paralyze_Conditions; returns if C is 0; calls AddAIWeight; continues in
; AIScore_PoisonHit_CallActorLacksStatus1Bits23And4Bits01 (E-0347)
AIScore_Paralyze::
    farcall AIScore_Paralyze_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0054
    call AddAIWeight
    jp AIScore_PoisonHit_CallActorLacksStatus1Bits23And4Bits01

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 97 NapAttack. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_NapAttack_Conditions; returns if C is 0; calls AddAIWeight; continues in
; AIScore_PoisonHit_CallActorLacksStatus1Bits23And4Bits01 (E-0347)
AIScore_NapAttack::
    farcall AIScore_NapAttack_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0054
    call AddAIWeight
    jp AIScore_PoisonHit_CallActorLacksStatus1Bits23And4Bits01

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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 98 SquallHit. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_SquallHit_Conditions; returns if C is 0; calls MaxNegativeScoreWhenAIFlagBit0;
; may return early; calls CheckLoneFoeHPNotBelowAIDamageEstimates; branches on C; calls
; AddAIWeightToScore2; calls SetCToZero; branches on C; calls AddAIWeightToScore2; calls
; WeighLinkRules1RuleBit1; calls FailIfFoeHPAtMostFourFifthsAIDamageEstimates; then 11 more steps
; (see the code) (E-0347)
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
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $0005
    call AddAIWeight

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a
    jr nz, .done
    ld bc, $0033
    call AddAIWeightToScore2

.done:
    ld c, $01
    ret

; BiAttack's AI score (rows of the personality weight table, ReadBank6TableWord, added to
; wAISkillScore 'score' or wAISkillScore2 'score 2'): needs
; AIScore_BiAttack_CheckSkillUsableElseResetAISkillScore; then row $07 to score 2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; row $05 to score when
; ActorLacksStatus1Bits23And4Bits01 gives 0; always row $C8 to score 2; WeighLinkRules1RuleBit1; row
; $15 to score when FewerThanTwoFoesPresent gives 0; row $4A to score 2 when CheckFoeStatus6Bit3
; gives 0; row $56 to score when FailIfFoeHPAtMostFourFifthsAIDamageEstimates gives 0; row $56 to
; score when AIScore_BiAttack_CarryUnlessBattleSlotOutSlotEmpty gives 0; row $05 to score when
; ActorStatus4CheckReadsAddress gives 0; row $33 to score 2 when ActorLacksStatus2Bit1And4Bits01
; gives 0. (C1, E-0357)
; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 99 BiAttack, 100 QuadHits. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70) (E-0083)
AIScore_BiAttack::
    farcall AIScore_BiAttack_CheckSkillUsableElseResetAISkillScore
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
    jr nz, .call_ai_score_bi_attack_carry_unless_battle
    ld bc, $0056
    call AddAIWeight

.call_ai_score_bi_attack_carry_unless_battle:
    farcall AIScore_BiAttack_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a
    jr nz, .call_actor_status4_check_reads_address
    ld bc, $0056
    call AddAIWeight

.call_actor_status4_check_reads_address:
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $0005
    call AddAIWeight

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AddAIWeightToScore2

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 101 RainSlash. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_RainSlash_Conditions; returns if C is 0; calls
; ActorLacksStatus1Bits23And4Bits01; branches on C; calls AddAIWeight; calls SetCToZero; branches on
; C; calls AddAIWeight; calls AddAIWeightToScore2; calls WeighLinkRules1RuleBit1; calls
; FewerThanTwoFoesPresent; branches on C; then 10 more steps (see the code) (E-0347)
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
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $0005
    call AddAIWeight

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AddAIWeightToScore2

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 102 MultiCut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_MultiCut_Conditions; returns if C is 0; calls FailIfAnyFoeFullyResistant; may
; continue in AIScore_MultiCut_CallCheckLoneFoeHPNotBelowAIDamageEstimates; calls
; AddAIWeightToScore2 (E-0347)
AIScore_MultiCut::
    farcall AIScore_MultiCut_Conditions
    ld a, c
    and a
    ret z
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp $01
    jr z, AIScore_MultiCut_CallCheckLoneFoeHPNotBelowAIDamageEstimates
    and a
    jr nz, AIScore_MultiCut_CallCheckLoneFoeHPNotBelowAIDamageEstimates
    ld bc, $0012
    call AddAIWeightToScore2

; MultiCut scoring, the rest: the lone-foe, estimate and resistance weights ($07, $0A against; $09,
; $0D for); link rule bit 1; $57 for with two or more foes; $4A against when a foe has status 6 bit
; 3 (AI mode 3 and up). (C1, E-0357)
AIScore_MultiCut_CallCheckLoneFoeHPNotBelowAIDamageEstimates::
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
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $0009
    call AddAIWeight

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 103 GigaSlash. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIAndFoeLacksStatus3And4; returns if C is 0; calls ActorLacksStatus2Bit1And4Bits01;
; branches on C; calls AddAIWeightToScore2; continues in
; AIScore_MultiCut_CallCheckLoneFoeHPNotBelowAIDamageEstimates (E-0347)
AIScore_GigaSlash::
    farcall AIAndFoeLacksStatus3And4
    ld a, c
    and a
    ret z
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a
    jr nz, .skip
    ld bc, $0033
    call AddAIWeightToScore2

.skip:
    jp AIScore_MultiCut_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 104 ChargeUp. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_ChargeUp_Conditions; returns if C is 0; calls
; PassIfFoeAverageDEFAtMostTwiceAllyATK; branches on C; calls AddAIWeight; calls SetCToZero;
; branches on C; calls AddAIWeight; calls AddAIWeightToScore2; calls WeighLinkRules1RuleBit1
; (E-0347)
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 105 PsycheUp. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_PsycheUp_Conditions; returns if C is 0; calls
; FastestFoeAGLAbove31PercentOfActor; branches on C; calls AddAIWeightToScore2; calls
; CheckLoneFoeHPNotBelowAIDamageEstimates; branches on C; calls AddAIWeightToScore2; calls
; AllyAverageAGLAtLeastFoes; branches on C; calls AddAIWeight; calls
; ActorLacksStatus1Bits23And4Bits01; then 7 more steps (see the code) (E-0347)
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 106 HighJump. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_HighJump_Conditions; returns if C is 0; calls
; CheckLoneFoeHPNotBelowAIDamageEstimates; branches on C; calls AddAIWeightToScore2; calls
; PassIfFoeAverageDEFAtMostTwiceAllyATK; branches on C; calls AddAIWeightToScore2; calls
; PassIfTwiceATKAboveLowestFoeDEF; branches on C; calls AddAIWeightToScore2; calls
; ActorLacksStatus1Bits23And4Bits01; then 6 more steps (see the code) (E-0347)
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
    jr z, .call_pass_if_twice_atk_above_lowest_foe_def
    and a
    jr nz, .call_pass_if_twice_atk_above_lowest_foe_def
    ld bc, $0058
    call AddAIWeightToScore2

.call_pass_if_twice_atk_above_lowest_foe_def:
    farcall PassIfTwiceATKAboveLowestFoeDEF
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
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AddAIWeightToScore2

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 107 EvilSlash. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls CheckSkillUsableElseResetAISkillScore; returns if C is 0; calls AnyFoeNotBlocked;
; branches on C; calls AddAIWeight; calls AnyFoeHasClearStatus3; branches on C; calls AddAIWeight;
; calls CheckLoneFoeHPNotBelowAIDamageEstimates; branches on C; calls AddAIWeightToScore2; calls
; PassIfFoeAverageDEFAtMostTwiceAllyATK; then 18 more steps (see the code) (E-0347)
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
    jr z, .call_pass_if_twice_atk_above_lowest_foe_def
    and a
    jr nz, .call_pass_if_twice_atk_above_lowest_foe_def
    ld bc, $0058
    call AddAIWeight

.call_pass_if_twice_atk_above_lowest_foe_def:
    farcall PassIfTwiceATKAboveLowestFoeDEF
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
    farcall AIScore_EvilSlash_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $00b0
    call AddAIWeight

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AddAIWeightToScore2

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 108 Massacre. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls CheckSkillUsableElseResetAISkillScore; returns if C is 0; calls AtLeastTwoFoesPresent;
; branches on C; calls AddAIWeightToScore2; calls CheckLoneFoeHPNotBelowAIDamageEstimates; branches
; on C; calls AddAIWeightToScore2; calls SetCToZero; branches on C; calls AddAIWeight; calls
; WeighLinkRules1RuleBit1; then 3 more steps (see the code) (E-0347)
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
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AddAIWeightToScore2

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 109 TwinSlash. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_TwinSlash_Conditions; returns if C is 0; calls AnyFoeLacksStatus0Bit6;
; branches on C; calls AddAIWeightToScore2; calls CheckLoneFoeHPNotBelowAIDamageEstimates; branches
; on C; calls AddAIWeightToScore2; calls PassIfFoeAverageDEFAtMostTwiceAllyATK; branches on C; calls
; AddAIWeightToScore2; calls PassIfTwiceATKAboveLowestFoeDEF; then 19 more steps (see the code)
; (E-0347)
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
    jr z, .call_pass_if_twice_atk_above_lowest_foe_def
    and a
    jr nz, .call_pass_if_twice_atk_above_lowest_foe_def
    ld bc, $005f
    call AddAIWeightToScore2

.call_pass_if_twice_atk_above_lowest_foe_def:
    farcall PassIfTwiceATKAboveLowestFoeDEF
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
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $0062
    call AddAIWeightToScore2

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AddAIWeightToScore2

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 110 Berserker. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIAttackSkillUsable_3; returns if C is 0; calls MaxNegativeScoreWhenAIFlagBit0; may
; return early; calls AnyFoeNotBlocked; branches on C; calls AddAIWeight; calls
; AllOtherAlliesHaveStatus0Bit6; branches on C; calls AddAIWeightToScore2; calls
; CheckLoneFoeHPNotBelowAIDamageEstimates; branches on C; then 30 more steps (see the code) (E-0347)
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
    jr z, .call_pass_if_twice_atk_above_lowest_foe_def
    and a
    jr nz, .call_pass_if_twice_atk_above_lowest_foe_def
    ld bc, $005f
    call AddAIWeightToScore2

.call_pass_if_twice_atk_above_lowest_foe_def:
    farcall PassIfTwiceATKAboveLowestFoeDEF
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
    jr nz, .call_ai_score_berserker_read_slot_ai_mode
    ld bc, $005f
    call AddAIWeightToScore2

.call_ai_score_berserker_read_slot_ai_mode:
    farcall AIScore_Berserker_ReadSlotAIModeIndexed_Bank05_2
    ld a, c
    cp $01
    jr z, .call_actor_lacks_status2_bit1_and4_bits01
    and a
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $0064
    call AddAIWeight

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AddAIWeightToScore2

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 111 Ramming. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIAndAnyFoeNotFullyResistantAndActorHPNotOne; returns if C is 0; calls
; AnyFoeLacksStatus0Bit6; branches on C; calls AddAIWeightToScore2; calls
; AllOtherAlliesHaveStatus0Bit6; branches on C; calls AddAIWeightToScore2; calls
; AIScore_Ramming_ReadSlotAIModeIndexed_Bank05_2; may continue in
; AIScore_Ramming_CallCheckLoneFoeHPNotBelowAIDamageEstimates; calls AddAIWeight (E-0347)
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
    jr nz, .call_ai_score_ramming_read_slot_ai_mode
    ld bc, $0017
    call AddAIWeightToScore2

.call_ai_score_ramming_read_slot_ai_mode:
    farcall AIScore_Ramming_ReadSlotAIModeIndexed_Bank05_2
    ld a, c
    cp $01
    jr z, AIScore_Ramming_CallCheckLoneFoeHPNotBelowAIDamageEstimates
    and a
    jr nz, AIScore_Ramming_CallCheckLoneFoeHPNotBelowAIDamageEstimates
    ld bc, $0064
    call AddAIWeight

; Ramming scoring, the rest: $07 against for the lone foe, $09 for from the resistance average; by
; the actor's HP band (AIScore_Ramming_HPBandOfSlotTemp0); $5C against for status 1 bits 2-3 or
; status 4 bits 0-1; always $C7 for and $D0 against (SetCToZero); link rule bit 1; $5F against when
; the side flag is set or no other ally is present; $33 against for status 2 bit 1 or status 4 bits
; 0-1. (C1, E-0357)
AIScore_Ramming_CallCheckLoneFoeHPNotBelowAIDamageEstimates::
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
    call AIScore_Ramming_HPBandOfSlotTemp0
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
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $005f
    call AddAIWeightToScore2

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AddAIWeightToScore2

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 112 Kamikaze. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_Kamikaze_AIAndAnyFoeNotFullyResistantAndActorHPNotOne; returns if C is 0;
; calls AIScore_Kamikaze_ReadSlotAIModeIndexed_Bank05_2; branches on C; calls AddAIWeight; continues
; in AIScore_Ramming_CallCheckLoneFoeHPNotBelowAIDamageEstimates (E-0347)
AIScore_Kamikaze::
    farcall AIScore_Kamikaze_AIAndAnyFoeNotFullyResistantAndActorHPNotOne
    ld a, c
    and a
    ret z
    farcall AIScore_Kamikaze_ReadSlotAIModeIndexed_Bank05_2
    ld a, c
    cp $01
    jr z, .skip
    and a
    jr nz, .skip
    ld bc, $0064
    call AddAIWeight

.skip:
    jp AIScore_Ramming_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 113 SleepAir. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_SleepAir_Conditions; returns if C is 0; calls SetCToZero; may continue in
; AIScore_SleepAir_CallWeighLinkRules1RuleBit3; calls AddAIWeightToScore2 (E-0347)
AIScore_SleepAir::
    farcall AIScore_SleepAir_Conditions
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, AIScore_SleepAir_CallWeighLinkRules1RuleBit3
    ld bc, $00bc
    call AddAIWeightToScore2

; SleepAir scoring: link rule bit 3, then the rest (AIScore_SleepAir_CallFewerThanTwoFoesPresent).
; (C1, E-0357)
AIScore_SleepAir_CallWeighLinkRules1RuleBit3::
    call WeighLinkRules1RuleBit3

; SleepAir scoring, the rest: $15 for with two or more foes, $12 against when a foe fully resists
; (AI mode 2 and up), $09 for from each resistance gate. (C1, E-0357)
AIScore_SleepAir_CallFewerThanTwoFoesPresent::
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $0015
    call AddAIWeight

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 114 PalsyAir. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_PalsyAir_Conditions; returns if C is 0; continues in
; AIScore_SleepAir_CallWeighLinkRules1RuleBit3 (E-0347)
AIScore_PalsyAir::
    farcall AIScore_PalsyAir_Conditions
    ld a, c
    and a
    ret z
    jr AIScore_SleepAir_CallWeighLinkRules1RuleBit3

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 115 PoisonGas. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_PoisonGas_Conditions; returns if C is 0; continues in
; AIScore_SleepAir_CallWeighLinkRules1RuleBit3 (E-0347)
AIScore_PoisonGas::
    farcall AIScore_PoisonGas_Conditions
    ld a, c
    and a
    ret z
    jr AIScore_SleepAir_CallWeighLinkRules1RuleBit3

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 116 PoisonAir. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_PoisonAir_Conditions; returns if C is 0; continues in
; AIScore_SleepAir_CallWeighLinkRules1RuleBit3 (E-0347)
AIScore_PoisonAir::
    farcall AIScore_PoisonAir_Conditions
    ld a, c
    and a
    ret z
    jr AIScore_SleepAir_CallWeighLinkRules1RuleBit3

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 117 Curse. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_Curse_Conditions; returns if C is 0; calls SetCToZero; branches on C; calls
; AddAIWeightToScore2; calls WeighLinkRules1RuleBit5; continues in
; AIScore_SleepAir_CallFewerThanTwoFoesPresent (E-0347)
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
    jp AIScore_SleepAir_CallFewerThanTwoFoesPresent

; OddDance's AI score (rows of the personality weight table, ReadBank6TableWord, added to
; wAISkillScore 'score' or wAISkillScore2 'score 2'): needs AIScore_OddDance_Conditions; then always
; row $09 to score; always row $C2 to score 2 and row $D2 to score; WeighLinkRules1RuleBit2; row $09
; to score when ResistanceAverageGateForAISide gives 0; row $09 to score when
; ResistanceAverageGateForFoeAIMode3 gives 0. (C1, E-0357)
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 120 PaniDance. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_PaniDance_Conditions; returns if C is 0; calls SetCToZero; branches on C;
; calls AddAIWeightToScore2; calls AddAIWeight; calls WeighLinkRules1RuleBit2; calls
; FewerThanTwoFoesPresent; branches on C; calls AddAIWeight; calls FailIfAnyFoeFullyResistant;
; branches on C; then 7 more steps (see the code) (E-0347)
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
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $0015
    call AddAIWeight

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 121 K.O.Dance. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_KODance_Conditions; returns if C is 0; calls SetCToZero; branches on C; calls
; AddAIWeight; calls AddAIWeightToScore2; calls WeighLinkRules1RuleBit2; calls
; FewerThanTwoFoesPresent; branches on C; calls AddAIWeight; calls AIGateFoeSlotResistances2Bits45;
; branches on C; then 10 more steps (see the code) (E-0347)
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
    jr z, .call_fail_if_any_foe_fully_resistant
    and a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $00b5
    call AddAIWeight

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 122 LureDance. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_LureDance_Conditions; returns if C is 0; calls SetCToZero; branches on C;
; calls AddAIWeightToScore2; calls AddAIWeight; calls WeighLinkRules1RuleBit2; calls
; FewerThanTwoFoesPresent; branches on C; calls AddAIWeight; calls FailIfAnyFoeFullyResistant;
; branches on C; then 8 more steps (see the code) (E-0347)
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
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $0015
    call AddAIWeight

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 123 LifeDance. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_LifeDance_Conditions; returns if C is 0; calls SetCToZero; branches on C;
; calls AddAIWeight; calls AddAIWeightToScore2; calls WeighLinkRules1RuleBit2; calls
; AllySlotsCheckThenFewerThanTwoFoes; branches on C; calls AddAIWeight; calls
; PassIfSide0FlagOrAllySlotEmpty; branches on C; then 4 more steps (see the code) (E-0347)
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
    jr nz, .call_pass_if_side0_flag_or_ally_slot_empty
    ld bc, $0029
    call AddAIWeight

.call_pass_if_side0_flag_or_ally_slot_empty:
    farcall PassIfSide0FlagOrAllySlotEmpty
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 124 Hustle. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_Hustle_Conditions; returns if C is 0; calls ForEachPresentSlotOfSideRun; calls
; AnyFoeLacksStatus0MaskCC; branches on C; calls AddAIWeight; calls AnyFoeHasClearStatus3; branches
; on C; calls AddAIWeight; calls AnyAllyHPAtMostThreeQuarters; branches on C; calls
; AddAIWeightToScore2; then 13 more steps (see the code) (E-0347)
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 125 SideStep. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_SideStep_Conditions; returns if C is 0; calls
; AnyFoeLacksStatus5Bits01And1Bit1; branches on C; calls AddAIWeightToScore2; calls
; CheckLoneFoeHPNotBelowAIDamageEstimates; branches on C; calls AddAIWeightToScore2; calls
; PassIfFoeAverageATKAtMostTwiceAllyDEF; branches on C; calls AddAIWeight; calls SetCToZero; then 6
; more steps (see the code) (E-0347)
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 126 SandStorm. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_SandStorm_Conditions; returns if C is 0 (E-0347)
AIScore_SandStorm::
    farcall AIScore_SandStorm_Conditions
    ld a, c
    and a
    ret z

; SandStorm scoring, the rest: $07 against for the lone foe, $6D for when the foes' average ATK is
; more than twice the allies' DEF (AI mode 2 and up), always $BA against (SetCToZero); link rule bit
; 5; $15 for with two or more foes, $32 for from the ATK/DEF comparison, $12 against for a fully
; resistant foe, $09 for from each resistance gate. (C1, E-0357)
AIScore_SandStorm_CallCheckLoneFoeHPNotBelowAIDamageEstimates::
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
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $0032
    call AddAIWeight

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 127 Radiant. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_Radiant_Conditions; returns if C is 0; continues in
; AIScore_SandStorm_CallCheckLoneFoeHPNotBelowAIDamageEstimates (E-0347)
AIScore_Radiant::
    farcall AIScore_Radiant_Conditions
    ld a, c
    and a
    ret z
    jp AIScore_SandStorm_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 128 EerieLite. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_EerieLite_Conditions; returns if C is 0; calls SetCToZero; branches on C;
; calls AddAIWeight; calls AddAIWeightToScore2; calls WeighLinkRules1RuleBit5; calls
; FewerThanTwoFoesPresent; branches on C; calls AddAIWeight; calls FailIfAnyFoeFullyResistant;
; branches on C; then 7 more steps (see the code) (E-0347)
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
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $0015
    call AddAIWeight

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 129 Surge. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_Surge_Conditions; returns if C is 0; calls AddAIWeight; calls SetCToZero;
; branches on C; calls AddAIWeightToScore2; calls WeighLinkRules1RuleBit4 (E-0347)
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 130 UltraDown. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_UltraDown_Conditions; returns if C is 0; calls AddAIWeight; calls SetCToZero;
; branches on C; calls AddAIWeight; calls WeighLinkRules1RuleBit5 (E-0347)
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 131 DeMagic. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_DeMagic_Conditions; returns if C is 0; calls AddAIWeight; calls
; AnyFoeLacksStatus5Bits67; branches on C; calls AddAIWeight; calls SetCToZero; branches on C; calls
; AddAIWeightToScore2; calls AddAIWeight; calls WeighLinkRules1RuleBit5 (E-0347)
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 132 ThickFog. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_ThickFog_Conditions; returns if C is 0; calls SetCToZero; branches on C; calls
; AddAIWeight; calls WeighLinkRules1RuleBit5; calls AIModeAtLeast2AndFoeLacks; branches on C; calls
; AddAIWeight (E-0347)
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
    farcall AIModeAtLeast2AndFoeLacks
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0072
    call AddAIWeight

.return:
    ret

; TatsuCall's AI score (rows of the personality weight table, ReadBank6TableWord, added to
; wAISkillScore 'score' or wAISkillScore2 'score 2'): needs AIScore_TatsuCall_Conditions; then row
; $73 to score when AllOtherAlliesHaveStatus0Bit6 gives 0; row $07 to score 2 when
; CheckLoneFoeHPNotBelowAIDamageEstimates gives 0; always row $74 to score and row $BB to score and
; row $C7 to score 2; WeighLinkRules1RuleBit5; row $75 to score when
; AllySlotsCheckThenFewerThanTwoFoes gives 0. (C1, E-0357)
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 137 SuckAir. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_SuckAir_Conditions; returns if C is 0; calls
; CheckLoneFoeHPNotBelowAIDamageEstimates; branches on C; calls AddAIWeightToScore2; calls
; SetCToZero; branches on C; calls AddAIWeight; calls WeighLinkRules1RuleBit3; calls
; AnyAllyLacksStatus2Bit2_2; branches on C; calls AddAIWeightToScore2 (E-0347)
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 138 Focus. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_Focus_Conditions; returns if C is 0; calls
; CheckLoneFoeHPNotBelowAIDamageEstimates; branches on C; calls AddAIWeightToScore2; calls
; SetCToZero; branches on C; calls AddAIWeight; calls AddAIWeightToScore2; calls
; WeighLinkRules1RuleBit5 (E-0347)
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 139 LushLicks. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AILickSkillUsable; returns if C is 0; calls SetCToZero; branches on C; calls
; AddAIWeight; calls WeighLinkRules1RuleBit5; calls ResistanceAverageGateForAISide; branches on C;
; calls AddAIWeight; calls ResistanceAverageGateForFoeAIMode3; branches on C; calls AddAIWeight;
; then 1 more step (see the code) (E-0347)
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 140 SickLick. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIStatusLickUsable; returns if C is 0; calls AnyFoeHasDEFAtLeast2; branches on C;
; calls AddAIWeightToScore2; calls PassIfFoeAverageDEFAtMostTwiceAllyATK; branches on C; calls
; AddAIWeight; calls PassIfTwiceATKAboveLowestFoeDEF; branches on C; calls AddAIWeight; calls
; SetCToZero; then 10 more steps (see the code) (E-0347)
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
    jr z, .call_pass_if_twice_atk_above_lowest_foe_def
    and a
    jr nz, .call_pass_if_twice_atk_above_lowest_foe_def
    ld bc, $002c
    call AddAIWeight

.call_pass_if_twice_atk_above_lowest_foe_def:
    farcall PassIfTwiceATKAboveLowestFoeDEF
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

; LegSweep's AI score (rows of the personality weight table, ReadBank6TableWord, added to
; wAISkillScore 'score' or wAISkillScore2 'score 2'): needs AIScore_LegSweep_Conditions; then always
; row $7B to score; WeighLinkRules1RuleBit5; row $09 to score when ResistanceAverageGateForAISide
; gives 0; row $09 to score when ResistanceAverageGateForFoeAIMode3 gives 0; AIAddScoresForTwoLists;
; returns C = 1. (C1, E-0357)
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

; Ahhh's AI score (rows of the personality weight table, ReadBank6TableWord, added to wAISkillScore
; 'score' or wAISkillScore2 'score 2'): needs AILickSkillUsable; then always row $C0 to score and
; row $C3 to score 2 and row $CE to score 2 and row $D3 to score; WeighLinkRules1RuleBit5; row $09
; to score when ResistanceAverageGateForAISide gives 0; row $09 to score when
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 145 Geyser. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_Geyser_Conditions; returns if C is 0; calls SetCToZero; branches on C; calls
; AddAIWeight; calls WeighLinkRules1RuleBit5; calls ResistanceAverageGateForAISide; branches on C;
; calls AddAIWeight; calls ResistanceAverageGateForFoeAIMode3; branches on C; calls AddAIWeight
; (E-0347)
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 146 DanceShut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_DanceShut_Conditions; returns if C is 0; calls SetCToZero; branches on C;
; calls AddAIWeight; calls WeighLinkRules1RuleBit2 (E-0347)
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 147 MouthShut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_MouthShut_Conditions; returns if C is 0; calls FailIfFoeKnowsSkills42To47;
; branches on C; calls AddAIWeight; calls SetCToZero; branches on C; calls AddAIWeight; calls
; WeighLinkRules1RuleBit3 (E-0347)
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 148 StrongD. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_StrongD_Conditions; returns if C is 0; calls AIScoreGuardSkill; may return
; early; calls AIScore_StrongD_HPBandOfSlotTemp0; calls SetCToZero; branches on C; calls
; AddAIWeightToScore2; calls FailIfFoeSkill3DThreatensActorHP; branches on C; calls AddAIWeight;
; calls WeighLinkRules1RuleBit4 (E-0347)
AIScore_StrongD::
    farcall AIScore_StrongD_Conditions
    ld a, c
    and a
    ret z
    call AIScoreGuardSkill
    ret z
    ld a, [wBattleActor]
    call AIScore_StrongD_HPBandOfSlotTemp0
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 149 Dodge. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_Dodge_Conditions; returns if C is 0; calls AIScoreGuardSkill; may return
; early; calls SetCToZero; branches on C; calls AddAIWeight; calls AddAIWeightToScore2; calls
; WeighLinkRules1RuleBit5 (E-0347)
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 150 BladeD. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIGuardSkillUsable; returns if C is 0; calls AIScoreGuardSkill; may return early;
; calls SetCToZero; branches on C; calls AddAIWeight; calls AddAIWeightToScore2; calls
; WeighLinkRules1RuleBit4 (E-0347)
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

; Cover's AI score (rows of the personality weight table, ReadBank6TableWord, added to wAISkillScore
; 'score' or wAISkillScore2 'score 2'): needs AIScore_Cover_Conditions; then AIScoreGuardSkill
; (returning when it gives 0); AIScore_Cover_CarryUnlessBattleSlotOutSlotEmpty; always row $CD to
; score 2 and row $D1 to score; WeighLinkRules1RuleBit5. (C1, E-0357)
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
    call AIScore_Cover_CarryUnlessBattleSlotOutSlotEmpty
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 153 TailWind. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_TailWind_Conditions; returns if C is 0; calls
; AIScore_TailWind_AddAIWeightToScore2; may return early (E-0347)
AIScore_TailWind::
    farcall AIScore_TailWind_Conditions
    ld a, c
    and a
    ret z
    call AIScore_TailWind_AddAIWeightToScore2
    ret z

; TailWind scoring, the rest: $3A for and then $8C for when a foe knows skills $42-$47 (AI mode 2
; and up; mode below 2 still adds $8C); link rule bit 5. (C1, E-0357)
AIScore_TailWind_CallFailIfFoeKnowsSkills42To47::
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 154 StormWind. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_StormWind_Conditions; returns if C is 0; continues in
; AIScore_TailWind_CallFailIfFoeKnowsSkills42To47 (E-0347)
AIScore_StormWind::
    farcall AIScore_StormWind_Conditions
    ld a, c
    and a
    ret z
    jr AIScore_TailWind_CallFailIfFoeKnowsSkills42To47

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 155 AquaWall. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_AquaWall_Conditions; returns if C is 0; calls
; AIScore_AquaWall_HPBandOfSlotTemp0; calls WeighLinkRules1RuleBit5 (E-0347)
AIScore_AquaWall::
    farcall AIScore_AquaWall_Conditions
    ld a, c
    and a
    ret z
    ld a, [wBattleActor]
    call AIScore_AquaWall_HPBandOfSlotTemp0
    call WeighLinkRules1RuleBit5
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 156 SealPray. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_SealPray_ActorCanPayMPCost_Bank05; returns if C is 0; calls
; AIScore_SealPray_ReadQueuedActionId; branches on C; calls AddAIWeightToScore2; calls
; FailIfFoeKnowsSkills42To47; branches on C; calls AddAIWeight; calls SetCToZero; branches on C;
; calls AddAIWeight; calls FailIfFoeSkill3DThreatensActorHP; then 6 more steps (see the code)
; (E-0347)
AIScore_SealPray::
    farcall AIScore_SealPray_ActorCanPayMPCost_Bank05
    ld a, c
    and a
    ret z
    farcall AIScore_SealPray_ReadQueuedActionId
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
    farcall AIModeAtLeast2AndFoeLacks
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0090
    call AddAIWeight

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 157 SuckAll. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_SuckAll_Conditions; returns if C is 0; calls AIScoreGuardSkill; may return
; early; calls AllOtherAlliesHaveStatus0Bit6; branches on C; calls AddAIWeight; calls
; AnyAllyHPAtMostThreeQuarters; branches on C; calls AddAIWeightToScore2; calls
; AIScore_SuckAll_CarryUnlessBattleSlotOutSlotEmpty; calls FailIfFoeKnowsSkills42To47; then 6 more
; steps (see the code) (E-0347)
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
    call AIScore_SuckAll_CarryUnlessBattleSlotOutSlotEmpty
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 158 Imitate. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_Imitate_Conditions; returns if C is 0; calls AIScoreGuardSkill; may return
; early; calls CheckLoneFoeHPNotBelowAIDamageEstimates; branches on C; calls AddAIWeightToScore2;
; calls FailIfFoeKnowsSkills42To47; branches on C; calls AddAIWeight; calls SetCToZero; branches on
; C; then 6 more steps (see the code) (E-0347)
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
    farcall AIModeAtLeast2AndFoeLacks
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $009a
    call AddAIWeight

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 159 Meditate. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_Meditate_Conditions; returns if C is 0; calls
; AIScore_Meditate_HPBandOfSlotTemp0; calls ActorHPIsNotOne; branches on C; calls AddAIWeight; calls
; SetCToZero; branches on C; calls AddAIWeight; calls AddAIWeightToScore2; calls
; WeighLinkRules1RuleBit4; calls FailIfTwoAlliesBelowHalfHP; then 2 more steps (see the code)
; (E-0347)
AIScore_Meditate::
    farcall AIScore_Meditate_Conditions
    ld a, c
    and a
    ret z
    ld a, [wBattleActor]
    call AIScore_Meditate_HPBandOfSlotTemp0
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 160 LifeSong. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_LifeSong_Conditions; returns if C is 0; calls SetCToZero; branches on C; calls
; AddAIWeightToScore2; calls WeighLinkRules1RuleBit4; calls AIGateCompareAllyStatAverages; branches
; on C; calls AddAIWeightToScore2 (E-0347)
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 161 LoveRain. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AIScore_LoveRain_Conditions; returns if C is 0; calls AnyAllyHPAtMostThreeQuarters;
; branches on C; calls AddAIWeightToScore2; calls ForEachPresentSlotOfSideRun; calls
; ActorHPIsNotOne; branches on C; calls AddAIWeight; calls FewerThanTwoAlliesAtHP1; branches on C;
; calls AddAIWeight; then 9 more steps (see the code) (E-0347)
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

; AI scoring routine for 8 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 162 Whistle, 163 Pheromone, 164 StepGuard, 165
; Outside, 166 Informer, 167 Errand, 168 EagleEye, 169 MapMagic. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AINeverUsableResetAISkillScore (E-0347)
AIScore_Whistle::
    farcall AINeverUsableResetAISkillScore
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 170 Ahhh. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083) (E-0344: the address in its name dropped or read as the label there; was AIScore_Ahhh_2)
; code: calls AIStatusLickUsable; returns if C is 0; calls SetCToZero; branches on C; calls
; AddAIWeight; calls WeighLinkRules1RuleBit1 (E-0347)
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 171 ZoneOut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls AINeverUsableResetAISkillScore (E-0347)
AIScore_ZoneOut::
    farcall AINeverUsableResetAISkillScore
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 172 Guard. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083)
; code: calls MaxNegativeScoreWhenAIFlagBit0; may return early; calls AIScore_Guard_Conditions;
; returns if C is 0; calls AnyFoeLacksStatus5Bits01And1Bit1; branches on C; calls
; AddAIWeightToScore2; calls AllOtherAlliesHaveStatus0Bit6; branches on C; calls
; AddAIWeightToScore2; calls ActorHPIsNotOne; branches on C; then 4 more steps (see the code)
; (E-0347)
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 173 PanicAll. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083) (E-0344: the address in its name dropped or read as the label there; was
; AIScore_PanicAll_2)
; code: calls AIPanicAllUsable; returns if C is 0; calls SetCToZero; branches on C; calls
; AddAIWeight (E-0347)
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

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 174 Ironize. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AddAIWeight/DA70); the individual checks are not interpreted
; (E-0083) (E-0344: the address in its name dropped or read as the label there; was
; AIScore_Ironize_2)
; code: calls AIIronizeUsable; returns if C is 0; calls AIScoreGuardSkill; may return early; calls
; SetCToZero; branches on C; calls AddAIWeight; calls AIModeAtLeast2AndFoeLacks; branches on C;
; calls AddAIWeight (E-0347)
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
    jr nz, .call_ai_mode_at_least2_and_foe_lacks
    ld bc, $0038
    call AddAIWeight

.call_ai_mode_at_least2_and_foe_lacks:
    farcall AIModeAtLeast2AndFoeLacks
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
AIScore_StrongD_HPBandOfSlotTemp0::
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
AIScore_AquaWall_HPBandOfSlotTemp0::
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
; (AIScore_SuckAll_HPBandOfSlotTemp0). (C1, E-0357)
AIScore_SuckAll_CarryUnlessBattleSlotOutSlotEmpty::
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp0], a
    push bc
    call AIScore_SuckAll_HPBandOfSlotTemp0
    pop bc

.next:
    inc c
    dec b
    jr nz, .loop
    ret

; SuckAll by HP band: at least half HP (bands 0-1) $93 for, lower $94 against. (C1, E-0357)
AIScore_SuckAll_HPBandOfSlotTemp0::
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
AIScore_Meditate_HPBandOfSlotTemp0::
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

; For each present slot on side A, scores its HP band for HealUs (AIScore_HealUs_HPBandOfSlotTemp0).
; (C1, E-0357)
AIScore_HealUs_CarryUnlessBattleSlotOutSlotEmpty::
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp0], a
    push bc
    call AIScore_HealUs_HPBandOfSlotTemp0
    pop bc

.next:
    inc c
    dec b
    jr nz, .loop
    ret

; Adds the weight for the slot's HP band from HealUs's first table when C equals the actor,
; otherwise from its second table, to wAISkillScore. (C1, E-0357)
AIScore_HealUs_HPBandOfSlotTemp0::
    push bc
    farcall HPBandOfSlotTemp0
    ld a, c
    pop bc
    ld b, a
    ld a, [wBattleActor]
    cp c
    ld hl, AIScore_HealUs_HPBandOfSlotTemp0_Data1
    jr z, .skip
    ld hl, AIScore_HealUs_HPBandOfSlotTemp0_Data2

.skip:
    ld a, b
    add_a_to_hl
    ld c, [hl]
    ld b, $00
    call AddAIWeight
    ret

; data read by AIScore_HealUs_HPBandOfSlotTemp0 (6 bytes) (E-0347)
AIScore_HealUs_HPBandOfSlotTemp0_Data1::
    db $1e, $1f, $20, $21, $22, $22

AIScore_HealUs_HPBandOfSlotTemp0_Data2::
    db $ab, $ac, $ad, $ae, $af, $af

; for the three slots of the side in A (bit 2), runs ForEachPresentSlotOfSideRun_HPBandOfSlotTemp0
; with hTemp0 = slot for each occupied one (E-0122) (E-0344: the address in its name dropped or read
; as the label there; was ForEachPresentSlotOfSideRun)
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
    call ForEachPresentSlotOfSideRun_HPBandOfSlotTemp0
    pop bc

.next:
    inc c
    dec b
    jr nz, .loop
    ret

; Adds the weight for the slot's HP band from the first table when C equals the actor, otherwise
; from the second, to wAISkillScore. (C1, E-0357)
ForEachPresentSlotOfSideRun_HPBandOfSlotTemp0::
    push bc
    farcall HPBandOfSlotTemp0
    ld a, c
    pop bc
    ld b, a
    ld a, [wBattleActor]
    cp c
    ld hl, ForEachPresentSlotOfSideRun_HPBandOfSlotTemp0_Data1
    jr z, .skip
    ld hl, ForEachPresentSlotOfSideRun_HPBandOfSlotTemp0_Data2

.skip:
    ld a, b
    add_a_to_hl
    ld c, [hl]
    ld b, $00
    call AddAIWeight
    ret

; data read by ForEachPresentSlotOfSideRun_HPBandOfSlotTemp0 (6 bytes) (E-0347)
ForEachPresentSlotOfSideRun_HPBandOfSlotTemp0_Data1::
    db $1d, $1e, $1f, $20, $21, $22

ForEachPresentSlotOfSideRun_HPBandOfSlotTemp0_Data2::
    db $aa, $ab, $ac, $ad, $ae, $af

; Adds the weight for slot A's HP band from Ramming's table to wAISkillScore. (C1, E-0357)
AIScore_Ramming_HPBandOfSlotTemp0::
    ldh [hTemp0], a
    push bc
    farcall HPBandOfSlotTemp0
    ld a, c
    pop bc
    ld b, a
    ld hl, AIScore_Ramming_HPBandOfSlotTemp0_Data
    ld a, b
    add_a_to_hl
    ld c, [hl]
    ld b, $00
    call AddAIWeight
    ret

; data read by AIScore_Ramming_HPBandOfSlotTemp0 (6 bytes) (E-0347)
AIScore_Ramming_HPBandOfSlotTemp0_Data::
    db $1d, $1e, $1f, $20, $21, $22

; For each present slot on side A, scores its HP band for Cover (AIScore_Cover_HPBandOfSlotTemp0).
; (C1, E-0357)
AIScore_Cover_CarryUnlessBattleSlotOutSlotEmpty::
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp0], a
    push bc
    call AIScore_Cover_HPBandOfSlotTemp0
    pop bc

.next:
    inc c
    dec b
    jr nz, .loop
    ret

; Adds the weight for the slot's HP band from Cover's first table when C equals the actor, otherwise
; from its second, to wAISkillScore. (C1, E-0357)
AIScore_Cover_HPBandOfSlotTemp0::
    push bc
    farcall HPBandOfSlotTemp0
    ld a, c
    pop bc
    ld b, a
    ld a, [wBattleActor]
    cp c
    ld hl, AIScore_Cover_HPBandOfSlotTemp0_Data1
    jr z, .skip
    ld hl, AIScore_Cover_HPBandOfSlotTemp0_Data2

.skip:
    ld a, b
    add_a_to_hl
    ld c, [hl]
    ld b, $00
    call AddAIWeight
    ret

; data read by AIScore_Cover_HPBandOfSlotTemp0 (6 bytes) (E-0347)
AIScore_Cover_HPBandOfSlotTemp0_Data1::
    db $21, $20, $1f, $1e, $1d, $1d

AIScore_Cover_HPBandOfSlotTemp0_Data2::
    db $aa, $aa, $ab, $ac, $ad, $ae

; Upper: $2B for when the foes' average ATK is more than twice the allies' DEF (C = 0), otherwise
; $13 against. (C1, E-0357)
AIScore_Upper_CompareFoeAverageATKWithAllyDEF::
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
AIScore_Sap_AddAIWeightToScore2::
    farcall AIScore_Sap_CarryUnlessBattleSlotOutSlotEmpty
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

; TailWind on the first turn (wBattleTurn 0): $B6 against and C = $FF; later turns return C = the
; turn. (C1, E-0357)
AIScore_TailWind_AddAIWeightToScore2::
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
    jr AIScore_TailWind_AddAIWeightToScore2

; WeighLinkRules1RuleBit4, then adds score word $29 to wAISkillScore when
; AllySlotsCheckThenFewerThanTwoFoes fails and again when PassIfSide0FlagOrAllySlotEmpty fails
; (E-0122) (E-0344: the address in its name dropped or read as the label there; was
; AIAddPenaltyForAllySlotsCheckThenFewerThanTwoFoes)
AIAddPenaltyForAllySlotsCheckThenFewerThanTwoFoes::
    call WeighLinkRules1RuleBit4
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a
    jr nz, .call_pass_if_side0_flag_or_ally_slot_empty
    ld bc, $0029
    call AddAIWeight

.call_pass_if_side0_flag_or_ally_slot_empty:
    farcall PassIfSide0FlagOrAllySlotEmpty
    ld a, c
    and a
    jr nz, .return
    ld bc, $0029
    call AddAIWeight

.return:
    ret

; adds score word $B1 when AIAddScoresForTwoLists_ReadSlotAIModeIndexed_Bank05 fails and $B2 when
; AIAddScoresForTwoLists_ReadSlotAIModeIndexed_Bank05_2 fails (results of 1 count as passing)
; (E-0124) (E-0344: the address in its name dropped or read as the label there; was
; AIAddScoresForTwoLists; a trailing preposition left by the dropped address removed)
AIAddScoresForTwoLists::
    farcall AIAddScoresForTwoLists_ReadSlotAIModeIndexed_Bank05
    ld a, c
    cp $01
    jr z, .call_ai_add_scores_for_two_lists_read_slot_ai
    and a
    jr nz, .call_ai_add_scores_for_two_lists_read_slot_ai
    ld bc, $00b1
    call AddAIWeight

.call_ai_add_scores_for_two_lists_read_slot_ai:
    farcall AIAddScoresForTwoLists_ReadSlotAIModeIndexed_Bank05_2
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
AIScore_Sacrifice_LinkRuleCheckLinkRules1Bit6::
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
    jr GetBattleMP_BankE2_Skip

; HL = wBattleDEF, then the slot's word (GetBattleMP_BankE2_Skip). (C1, E-0357)
GetBattleDEF_BankE2::
    ld hl, wBattleDEF
    jr GetBattleMP_BankE2_Skip

; HL = wBattleMaxHP, then the slot's word (GetBattleMP_BankE2_Skip). (C1, E-0357)
GetBattleMaxHP_BankE2::
    ld hl, wBattleMaxHP
    jr GetBattleMP_BankE2_Skip

; HL = wBattleMaxMP, then the slot's word (GetBattleMP_BankE2_Skip). (C1, E-0357)
GetBattleMaxMP_BankE2::
    ld hl, wBattleMaxMP
    jr GetBattleMP_BankE2_Skip

; HL = wBattleHP, then the slot's word (GetBattleMP_BankE2_Skip). (C1, E-0357)
GetBattleHP_BankE2::
    ld hl, wBattleHP
    jr GetBattleMP_BankE2_Skip

; HL = wBattleMP, then the slot's word (GetBattleMP_BankE2_Skip). (C1, E-0357)
GetBattleMP_BankE2::
    ld hl, wBattleMP
    jr GetBattleMP_BankE2_Skip
    db $21, $1f, $d9, $18, $0a, $21, $53, $da, $85, $6f, $30, $01, $24, $7e, $c9

; HL = the word at HL + 2 x slot A (the value, not a pointer). (C1, E-0357)
GetBattleMP_BankE2_Skip::
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

; data read by ClearBattleStatusBitsWithMaskD_BankE2 (7 bytes) (E-0347)
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
