SECTION "Bank E2", ROMX[$4000], BANK[$E2]
    db $e2

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 0 (no name). It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083) (E-0332: skill 0 is Fight, the plain attack: with Guard (skill $AC) it is
; scored on every monster's turn whether or not any record holds it, as the Command menu offers
; Fight / Skill / Guard; C2) (was AIScore_Skill00)
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
    call AccumulateBank6WordToDA6E

.call_at_least_two_foes_present:
    farcall AtLeastTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_check_lone_foe_hp_not_below_ai_damage
    ld bc, $0001
    call AccumulateBank6WordToDA6E

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_check_foe_status7_bit2
    ld bc, $0002
    call AccumulateBank6WordToDA6E

.call_check_foe_status7_bit2:
    farcall CheckFoeStatus7Bit2
    ld a, c
    cp $01
    jr z, .call_actor_lacks_status1_bits23_and4_bits01
    and a
    jr nz, .call_actor_lacks_status1_bits23_and4_bits01
    ld bc, $0003
    call AccumulateBank6WordToDA70

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0005
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_check_battle_kind_at_least2_or_link_mode
    ld bc, $0006
    call AccumulateBank6WordToDA6E

.call_check_battle_kind_at_least2_or_link_mode:
    farcall CheckBattleKindAtLeast2OrLinkModeSet
    ld a, c
    and a
    jr nz, .call_foe_hp_check_reads_wrong_slot
    ld bc, $0066
    call AccumulateBank6WordToDA6E

.call_foe_hp_check_reads_wrong_slot:
    farcall FoeHPCheckReadsWrongSlot
    ld a, c
    and a
    jr nz, .call_check_actor_slot0_to3_or_link_mode_set
    ld bc, $0067
    call AccumulateBank6WordToDA6E

.call_check_actor_slot0_to3_or_link_mode_set:
    farcall CheckActorSlot0To3OrLinkModeSet
    ld a, c
    and a
    jr nz, .call_actor_status4_check_reads_address
    ld bc, $0068
    call AccumulateBank6WordToDA6E

.call_actor_status4_check_reads_address:
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $0005
    call AccumulateBank6WordToDA6E

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 3 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 1 Blaze, 2 Blazemore, 3 Blazemost. It runs checks
; and adds weights to wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the
; individual checks are not interpreted (E-0083)
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
    call AccumulateBank6WordToDA70

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $000b
    call AccumulateBank6WordToDA6E

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_ai_add_scores_for55_be_and5731
    ld bc, $000c
    call AccumulateBank6WordToDA6E

.call_ai_add_scores_for55_be_and5731:
    call AIAddScoresFor55BEAnd5731
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .return
    ld bc, $0010
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 15 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 4 Firebal, 5 Firebane, 6 Firebolt, 7 Bang, 8 Boom,
; 9 Explodet, 10 Infernos, 11 Infermore, 12 Infermost, 13 Bolt .... It runs checks and adds weights
; to wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are
; not interpreted (E-0083)
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
    call AccumulateBank6WordToDA70

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $000a
    call AccumulateBank6WordToDA70

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $000b
    call AccumulateBank6WordToDA6E

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_ai_add_scores_for55_be_and5731
    ld bc, $000d
    call AccumulateBank6WordToDA6E

.call_ai_add_scores_for55_be_and5731:
    call AIAddScoresFor55BEAnd5731
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a
    jr nz, .call_fewer_than_two_foes_present
    ld bc, $0014
    call AccumulateBank6WordToDA6E

.call_fewer_than_two_foes_present:
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp $01
    jr z, .call_fail_if_any_foe_fully_resistant
    and a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $004a
    call AccumulateBank6WordToDA70

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0012
    call AccumulateBank6WordToDA70

.return:
    ret

; table-B AI score: AIScore_Beat, then adds a penalty word when the follow-up check fails (E-0122)
AIScoreB_Beat::
    call AIScore_Beat
    ld a, c
    and a
    ret z
    farcall AIGateFoeWDA74Bits45
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $00b5
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 19 Beat, 20 Defeat. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual
; checks are not interpreted (E-0083)
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
    call AccumulateBank6WordToDA70

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_ai_add_scores_for55_be_and5731
    ld bc, $00cd
    call AccumulateBank6WordToDA6E
    ld bc, $00cf
    call AccumulateBank6WordToDA70

.call_ai_add_scores_for55_be_and5731:
    call AIAddScoresFor55BEAnd5731
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_ai_gate_foe_wda74_bits45
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_ai_gate_foe_wda74_bits45:
    farcall AIGateFoeWDA74Bits45
    ld a, c
    cp $01
    jr z, .call_fail_if_any_foe_fully_resistant
    and a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $00b5
    call AccumulateBank6WordToDA6E

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AccumulateBank6WordToDA70

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .done
    and a
    jr nz, .done
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.done:
    ld c, $01
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 21 Sacrifice. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
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
    call AccumulateBank6WordToDA70

.call_all_other_allies_have_status0_bit6:
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a
    jr nz, .call_at_least_two_foes_present
    ld bc, $0017
    call AccumulateBank6WordToDA70

.call_at_least_two_foes_present:
    farcall AtLeastTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_any_ally_hp_at_most_three_quarters
    ld bc, $0011
    call AccumulateBank6WordToDA70

.call_any_ally_hp_at_most_three_quarters:
    farcall AnyAllyHPAtMostThreeQuarters
    ld a, c
    and a
    jr nz, .call_check_lone_foe_hp_not_below_ai_damage
    ld bc, $001b
    call AccumulateBank6WordToDA70

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_ai_score_sacrifice_link_rule_check_wd044
    ld bc, $00cd
    call AccumulateBank6WordToDA6E
    ld bc, $00cf
    call AccumulateBank6WordToDA70

.call_ai_score_sacrifice_link_rule_check_wd044:
    call AIScore_Sacrifice_LinkRuleCheckWD044Bit6
    farcall AIScore_Sacrifice_GetBattleMaxHP_Bank05
    ld a, c
    and a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $0019
    call AccumulateBank6WordToDA6E

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0012
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 3 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 22 Heal, 23 HealMore, 24 HealAll. It runs checks
; and adds weights to wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the
; individual checks are not interpreted (E-0083)
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
    call AccumulateBank6WordToDA70

AIScore_HealUs_AnyFoeLacksStatus0MaskCC::
    farcall AnyFoeLacksStatus0MaskCC
    ld a, c
    and a
    jr nz, .call_any_foe_has_clear_status3
    ld bc, $001a
    call AccumulateBank6WordToDA6E

.call_any_foe_has_clear_status3:
    farcall AnyFoeHasClearStatus3
    ld a, c
    and a
    jr nz, .call_any_ally_hp_at_most_three_quarters
    ld bc, $001a
    call AccumulateBank6WordToDA6E

.call_any_ally_hp_at_most_three_quarters:
    farcall AnyAllyHPAtMostThreeQuarters
    ld a, c
    and a
    jr nz, .read_battle_actor
    ld bc, $001b
    call AccumulateBank6WordToDA70

.read_battle_actor:
    ld a, [wBattleActor]
    call AIScore_HealUs_Sub01_CarryUnlessBattleSlotOutSlotEmpty
    farcall ActorHPIsNotOne
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0023
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit4
    ld bc, $0024
    call AccumulateBank6WordToDA6E
    ld bc, $00c8
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit4:
    call WeighWD044RuleBit4
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 25 HealUs, 26 HealUsAll. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual
; checks are not interpreted (E-0083)
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
    call AccumulateBank6WordToDA6E

.call_fail_if_two_allies_below_half_hp:
    farcall FailIfTwoAlliesBelowHalfHP
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0069
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 3 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 27 MPass, 28 MPassmore, 29 MPassmost. It runs
; checks and adds weights to wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the
; individual checks are not interpreted (E-0083)
AIScore_MPass::
    farcall AIScore_MPass_ActorLacksStatus4Bits67
    ld a, c
    and a
    ret z
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 30 Vivify, 31 Revive. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual
; checks are not interpreted (E-0083)
AIScore_Vivify::
    farcall AIScore_Vivify_Conditions
    ld a, c
    and a
    ret z
    call AIAddPenaltyFor5758And5CF1
    farcall AIGateCompareAllyStatAverages
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $002e
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 32 Farewell. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_Farewell::
    farcall AIScore_Farewell_Conditions
    ld a, c
    and a
    ret z
    call AIAddPenaltyFor5758And5CF1
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_ai_gate_compare_ally_stat_averages
    ld bc, $00bc
    call AccumulateBank6WordToDA6E
    ld bc, $00c4
    call AccumulateBank6WordToDA70

.call_ai_gate_compare_ally_stat_averages:
    farcall AIGateCompareAllyStatAverages
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $002e
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 33 Antidote. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_Antidote::
    farcall AIScore_Antidote_Conditions
    ld a, c
    and a
    ret z
    ld bc, $002a
    call AccumulateBank6WordToDA6E
    call WeighWD044RuleBit4
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 34 DeChaos. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_DeChaos::
    farcall AIScore_DeChaos_Conditions
    ld a, c
    and a
    ret z
    ld bc, $002a
    call AccumulateBank6WordToDA6E
    call WeighWD044RuleBit4
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 35 NumbOff. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_NumbOff::
    farcall AIScore_NumbOff_Conditions
    ld a, c
    and a
    ret z
    ld bc, $002a
    call AccumulateBank6WordToDA6E
    call WeighWD044RuleBit4
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 36 CurseOff. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_CurseOff::
    farcall AIScore_CurseOff_Conditions
    ld a, c
    and a
    ret z
    ld bc, $002a
    call AccumulateBank6WordToDA6E
    call WeighWD044RuleBit4
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 37 Upper, 38 Increase. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual
; checks are not interpreted (E-0083)
AIScore_Upper::
    farcall AIScore_Upper_Conditions
    ld a, c
    and a
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    call AIScore_Upper_CompareFoeAverageATKWithAllyDEF
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .return
    ld bc, $00c1
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 39 Sap, 40 Defense. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual
; checks are not interpreted (E-0083)
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
    call AccumulateBank6WordToDA70

.call_pass_if_foe_average_def_at_most_twice:
    farcall PassIfFoeAverageDEFAtMostTwiceAllyATK
    ld a, c
    cp $01
    jr z, .call_pass_if_twice_atk_above_lowest_foe_def
    and a
    jr nz, .call_pass_if_twice_atk_above_lowest_foe_def
    ld bc, $002c
    call AccumulateBank6WordToDA6E

.call_pass_if_twice_atk_above_lowest_foe_def:
    farcall PassIfTwiceATKAboveLowestFoeDEF
    ld a, c
    cp $01
    jr z, .call_set_c_to_zero
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $002c
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00cc
    call AccumulateBank6WordToDA6E
    ld bc, $00d1
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp $01
    jr z, .call_ai_score_sap_sub01_carry_unless_battle
    and a
    jr nz, .call_ai_score_sap_sub01_carry_unless_battle
    ld bc, $0012
    call AccumulateBank6WordToDA70

.call_ai_score_sap_sub01_carry_unless_battle:
    call AIScore_Sap_Sub01_CarryUnlessBattleSlotOutSlotEmpty_Sub01
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 41 Speed, 42 SpeedUp. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual
; checks are not interpreted (E-0083)
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
    call AccumulateBank6WordToDA70

.call_ally_average_agl_at_least_foes:
    farcall AllyAverageAGLAtLeastFoes
    ld a, c
    cp $01
    jr z, .call_weigh_wd044_rule_bit5
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $002c
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 43 Slow, 44 SlowAll. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual
; checks are not interpreted (E-0083)
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
    call AccumulateBank6WordToDA70

.call_fastest_foe_agl_above31_percent_of_actor:
    farcall FastestFoeAGLAbove31PercentOfActor
    ld a, c
    and a
    jr nz, .call_ally_average_agl_at_least_foes
    ld bc, $002d
    call AccumulateBank6WordToDA70

.call_ally_average_agl_at_least_foes:
    farcall AllyAverageAGLAtLeastFoes
    ld a, c
    cp $01
    jr z, .call_set_c_to_zero
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $002c
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00cc
    call AccumulateBank6WordToDA6E
    ld bc, $00d1
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AccumulateBank6WordToDA70

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0009
    call AccumulateBank6WordToDA6E

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
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 45 TwinHits. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
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
    call AccumulateBank6WordToDA6E

.call_ai_score_twin_hits_read_slot_ai_mode:
    farcall AIScore_TwinHits_ReadSlotAIModeIndexed_Bank05_Sub02
    ld a, c
    cp $01
    jr z, .call_set_c_to_zero
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0030
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00ba
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall FailIfAllyCanUseSkill63Or64
    ld a, c
    cp $01
    jr z, .done
    and a
    jr nz, .done
    ld bc, $00b3
    call AccumulateBank6WordToDA6E

.done:
    ld c, $01
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 46 Surround. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
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
    call AccumulateBank6WordToDA70

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_pass_if_foe_average_atk_at_most_twice
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_pass_if_foe_average_atk_at_most_twice:
    farcall PassIfFoeAverageATKAtMostTwiceAllyDEF
    ld a, c
    cp $01
    jr z, .call_set_c_to_zero
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0031
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00ba
    call AccumulateBank6WordToDA70
    ld bc, $00cc
    call AccumulateBank6WordToDA6E
    ld bc, $00d1
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall CompareFoeAverageATKWithAllyDEF
    ld a, c
    and a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $0032
    call AccumulateBank6WordToDA6E

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AccumulateBank6WordToDA70

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 47 Sleep, 48 SleepAll. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual
; checks are not interpreted (E-0083)
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
    call AccumulateBank6WordToDA70

.call_ally_average_agl_at_least_foes:
    farcall AllyAverageAGLAtLeastFoes
    ld a, c
    cp $01
    jr z, .call_set_c_to_zero
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $002c
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00bc
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 49 TakeMagic. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_TakeMagic::
    farcall AIScore_TakeMagic_Conditions
    ld a, c
    and a
    ret z
    farcall ActorMPBelowThreeQuarters
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $0034
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 50 RobMagic. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_RobMagic::
    farcall AIScore_RobMagic_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0035
    call AccumulateBank6WordToDA6E
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 51 StopSpell. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_StopSpell::
    farcall AIScore_StopSpell_Conditions
    ld a, c
    and a
    ret z
    farcall AIGateFoeStatus1Mask22
    ld a, c
    cp $01
    jr z, .call_weigh_wd044_rule_bit5
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $0004
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_ai_mode_at_least2_and_foe_lacks6_d1_a
    ld bc, $00cc
    call AccumulateBank6WordToDA6E
    ld bc, $00d1
    call AccumulateBank6WordToDA70

.call_ai_mode_at_least2_and_foe_lacks6_d1_a:
    farcall AIModeAtLeast2AndFoeLacks6D1A
    ld a, c
    cp $01
    jr z, .call_fail_if_any_foe_fully_resistant
    and a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $0036
    call AccumulateBank6WordToDA6E

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AccumulateBank6WordToDA70

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 52 PanicAll. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_PanicAll::
    farcall AIPanicAllUsable
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00ca
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AccumulateBank6WordToDA70

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 53 Ironize. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_Ironize::
    farcall AIIronizeUsable
    ld a, c
    and a
    ret z
    call AIScoreGuardSkill_67CF
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00d0
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 54 MagicBack, 55 Bounce. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual
; checks are not interpreted (E-0083)
AIScore_MagicBack::
    farcall AIScore_MagicBack_Conditions
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_ai_mode_at_least2_and_foe_lacks6_d1_a
    ld bc, $00c0
    call AccumulateBank6WordToDA70

.call_ai_mode_at_least2_and_foe_lacks6_d1_a:
    farcall AIModeAtLeast2AndFoeLacks6D1A
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0036
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 56 Barrier. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_Barrier::
    farcall AIScore_Barrier_Conditions
    ld a, c
    and a
    ret z
    farcall FailIfFoeKnowsSkills42To47
    ld a, c
    cp $01
    jr z, .call_weigh_wd044_rule_bit5
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $003a
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 57 MagicWall. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_MagicWall::
    farcall AIScore_MagicWall_Conditions
    ld a, c
    and a
    ret z
    call WeighWD044RuleBit5
    farcall AIModeAtLeast2AndFoeLacks6D1A
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0036
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 58 Transform. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
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
    call AccumulateBank6WordToDA6E

.call_ai_score_transform_read_slot_ai_mode:
    farcall AIScore_Transform_ReadSlotAIModeIndexed_Bank05
    ld a, c
    cp $01
    jr z, .call_set_c_to_zero
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $003c
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00ce
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 59 BeDragon. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_BeDragon::
    farcall AIUsableAndActorLacksStatus4Bits67
    ld a, c
    and a
    ret z
    farcall FailIfFoeKnowsSkills42To47
    ld a, c
    cp $01
    jr z, .call_weigh_wd044_rule_bit5
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $003a
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall AIScore_BeDragon_GetBattleMaxHP_Bank05
    ld a, c
    and a
    jr nz, .return
    ld bc, $003d
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 60 Chance. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
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
    call AccumulateBank6WordToDA6E

.call_actor_hp_is_not_one:
    farcall ActorHPIsNotOne
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0040
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00bf
    call AccumulateBank6WordToDA6E
    ld bc, $00c5
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a
    jr nz, .return
    ld bc, $0042
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 61 MegaMagic. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_MegaMagic::
    farcall AIScore_MegaMagic_AIAttackSkillUsable_74D1
    ld a, c
    and a
    ret z
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a
    jr nz, .call_check_lone_foe_hp_not_below_ai_damage
    ld bc, $0043
    call AccumulateBank6WordToDA6E

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_any_ally_lacks_status1_bits23_and4
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_any_ally_lacks_status1_bits23_and4:
    farcall AnyAllyLacksStatus1Bits23And4Bits01
    ld a, c
    and a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $0044
    call AccumulateBank6WordToDA70

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_ai_score_mega_magic_read_link_mode_and
    ld bc, $0045
    call AccumulateBank6WordToDA6E

.call_ai_score_mega_magic_read_link_mode_and:
    farcall AIScore_MegaMagic_ReadLinkModeAndBattleActor
    ld a, c
    and a
    jr nz, .call_link_rule_check_link_rule_turn_limit
    ld bc, $000e
    call AccumulateBank6WordToDA70

.call_link_rule_check_link_rule_turn_limit:
    farcall LinkRuleCheckLinkRuleTurnLimitTurnLimit
    ld a, c
    and a
    jr nz, .call_ally_slots_check_then_fewer_than_two
    ld bc, $0046
    call AccumulateBank6WordToDA6E

.call_ally_slots_check_then_fewer_than_two:
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a
    jr nz, .call_ai_score_mega_magic_read_link_mode
    ld bc, $0047
    call AccumulateBank6WordToDA6E

.call_ai_score_mega_magic_read_link_mode:
    farcall AIScore_MegaMagic_ReadLinkMode
    ld a, c
    and a
    jr nz, .call_ai_score_mega_magic_read_slot_ai_mode
    ld bc, $0048
    call AccumulateBank6WordToDA6E

.call_ai_score_mega_magic_read_slot_ai_mode:
    farcall AIScore_MegaMagic_ReadSlotAIModeIndexed_Bank05
    ld a, c
    cp $01
    jr z, .return
    or a
    jr nz, .return
    ld bc, $003e
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 62 BigBang, 63 Hellblast. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual
; checks are not interpreted (E-0083)
AIScore_BigBang::
    farcall AIAttackSkillUsable_74D1
    ld a, c
    and a
    ret z
    farcall ActorLacksStatus4Bits67
    ld a, c
    and a
    jr nz, .call_fail_if_foe_ai_damage_estimates_at_least
    ld bc, $0049
    call AccumulateBank6WordToDA6E

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $000a
    call AccumulateBank6WordToDA70

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $000d
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall LinkRuleCheckLinkRuleTurnLimitTurnLimit
    ld a, c
    and a
    jr nz, .call_ally_slots_check_then_fewer_than_two
    ld bc, $0046
    call AccumulateBank6WordToDA6E

.call_ally_slots_check_then_fewer_than_two:
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a
    jr nz, .call_fewer_than_two_foes_present
    ld bc, $0047
    call AccumulateBank6WordToDA6E

.call_fewer_than_two_foes_present:
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp $01
    jr z, .call_check_battle_kind_not2_or3
    and a
    jr nz, .call_check_battle_kind_not2_or3
    ld bc, $004a
    call AccumulateBank6WordToDA70

.call_check_battle_kind_not2_or3:
    farcall CheckBattleKindNot2Or3
    ld a, c
    and a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $004b
    call AccumulateBank6WordToDA6E

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0012
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 8 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 64 FireAir, 65 BlazeAir, 66 Scorching, 67
; WhiteFire, 68 FrigidAir, 69 IceAir, 70 IceStorm, 71 WhiteAir. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_FireAir::
    farcall AIScore_FireAir_AIAttackSkillUsable_74D1
    ld a, c
    and a
    ret z
    farcall AIScore_FireAir_ReadSlotAIModeIndexed_Bank05
    ld a, c
    and a
    jr nz, .call_at_least_two_foes_present
    ld bc, $004c
    call AccumulateBank6WordToDA70

.call_at_least_two_foes_present:
    farcall AtLeastTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_fail_if_foe_ai_damage_estimates_at_least
    ld bc, $0011
    call AccumulateBank6WordToDA70

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $000a
    call AccumulateBank6WordToDA70

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a
    jr nz, .call_actor_lacks_status4_bits45
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_actor_lacks_status4_bits45:
    farcall ActorLacksStatus4Bits45
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $004d
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $006a
    call AccumulateBank6WordToDA6E

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit3
    ld bc, $000d
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit3:
    call WeighWD044RuleBit3
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp $01
    jr z, .call_any_ally_lacks_status2_bit2_5_d31
    and a
    jr nz, .call_any_ally_lacks_status2_bit2_5_d31
    ld bc, $004a
    call AccumulateBank6WordToDA70

.call_any_ally_lacks_status2_bit2_5_d31:
    farcall AnyAllyLacksStatus2Bit2_5D31
    ld a, c
    and a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $004e
    call AccumulateBank6WordToDA70

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0012
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 72 WindBeast. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_WindBeast::
    farcall AIAttackSkillUsable_74D1
    ld a, c
    and a
    ret z
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, AIScore_Vacuum_CheckLoneFoeHPNotBelowAIDamageEstimates
    ld bc, $0010
    call AccumulateBank6WordToDA70

AIScore_Vacuum_CheckLoneFoeHPNotBelowAIDamageEstimates::
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_fail_if_foe_ai_damage_estimates_at_least
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $000a
    call AccumulateBank6WordToDA70

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $000d
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall FailIfFoeHPAtLeast150PercentOfActor
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $004f
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 73 Vacuum, 74 Lightning. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual
; checks are not interpreted (E-0083)
AIScore_Vacuum::
    farcall AIAttackSkillUsable_74D1
    ld a, c
    and a
    ret z
    call AIScore_Vacuum_CheckLoneFoeHPNotBelowAIDamageEstimates
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp $01
    jr z, .call_fail_if_any_foe_fully_resistant
    and a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $004a
    call AccumulateBank6WordToDA70

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0012
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 75 RockThrow. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_RockThrow::
    farcall AIFunc74D1AndFoeLacksStatus3And4
    ld a, c
    and a
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_fail_if_foe_ai_damage_estimates_at_least
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $000a
    call AccumulateBank6WordToDA70

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $000d
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp $01
    jr z, .call_check_actor_slot0_to3_or_link_mode_set
    and a
    jr nz, .call_check_actor_slot0_to3_or_link_mode_set
    ld bc, $004a
    call AccumulateBank6WordToDA70

.call_check_actor_slot0_to3_or_link_mode_set:
    farcall CheckActorSlot0To3OrLinkModeSet
    ld a, c
    and a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $006b
    call AccumulateBank6WordToDA70

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0012
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 76 Watershot. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_Watershot::
    farcall AIFunc74D1AndFoeLacksStatus3And4
    ld a, c
    and a
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_fail_if_foe_ai_damage_estimates_at_least
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $000d
    call AccumulateBank6WordToDA70

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $000d
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0010
    call AccumulateBank6WordToDA70

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $004a
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 77 Tidalwave. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_Tidalwave::
    farcall AIFunc74D1AndFoeLacksStatus3And4
    ld a, c
    and a
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_fail_if_foe_ai_damage_estimates_at_least
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $000a
    call AccumulateBank6WordToDA70

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $000d
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp $01
    jr z, .call_fail_if_any_foe_fully_resistant
    and a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $004a
    call AccumulateBank6WordToDA70

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0012
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 78 CallHelp, 79 YellHelp. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual
; checks are not interpreted (E-0083)
AIScore_CallHelp::
    farcall AIFunc74D1AndFoeLacksStatus3And4
    ld a, c
    and a
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_fail_if_foe_ai_damage_estimates_at_least
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $0008
    call AccumulateBank6WordToDA70

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a
    jr nz, .call_actor_lacks_status1_bits23_and4_bits01
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $000a
    call AccumulateBank6WordToDA70

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $00be
    call AccumulateBank6WordToDA70
    ld bc, $00c5
    call AccumulateBank6WordToDA6E

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $000d
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp $01
    jr z, .call_fail_if_foe_hp_at_least150_percent_of
    and a
    jr nz, .call_fail_if_foe_hp_at_least150_percent_of
    ld bc, $004a
    call AccumulateBank6WordToDA70

.call_fail_if_foe_hp_at_least150_percent_of:
    farcall FailIfFoeHPAtLeast150PercentOfActor
    ld a, c
    cp $01
    jr z, .call_fail_if_any_foe_fully_resistant
    and a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $004f
    call AccumulateBank6WordToDA6E

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0012
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 4 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 80 FireSlash, 81 VacuSlash, 82 BoltSlash, 83
; IceSlash. It runs checks and adds weights to wAISkillScore-wAISkillScore2 + $1
; (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
AIScore_FireSlash::
    farcall AIFunc74D1AndFoeLacksStatus3And4
    ld a, c
    and a
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_check_foe_status7_bit2
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_check_foe_status7_bit2:
    farcall CheckFoeStatus7Bit2
    ld a, c
    cp $01
    jr z, .call_fail_if_foe_ai_damage_estimates_at_least
    and a
    jr nz, .call_fail_if_foe_ai_damage_estimates_at_least
    ld bc, $0003
    call AccumulateBank6WordToDA70

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $0008
    call AccumulateBank6WordToDA70

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a
    jr nz, .call_actor_lacks_status1_bits23_and4_bits01
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $0055
    call AccumulateBank6WordToDA6E

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $000d
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall CheckBattleKindAtLeast2OrLinkModeSet
    ld a, c
    and a
    jr nz, .call_foe_hp_check_reads_wrong_slot
    ld bc, $0066
    call AccumulateBank6WordToDA6E

.call_foe_hp_check_reads_wrong_slot:
    farcall FoeHPCheckReadsWrongSlot
    ld a, c
    and a
    jr nz, .call_actor_status4_check_reads_address
    ld bc, $0067
    call AccumulateBank6WordToDA6E

.call_actor_status4_check_reads_address:
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $0005
    call AccumulateBank6WordToDA6E

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 84 SlimeBlow. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_SlimeBlow::
    farcall AIScore_SlimeBlow_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E

AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates::
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_check_foe_status7_bit2
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_check_foe_status7_bit2:
    farcall CheckFoeStatus7Bit2
    ld a, c
    cp $01
    jr z, .call_actor_lacks_status1_bits23_and4_bits01
    and a
    jr nz, .call_actor_lacks_status1_bits23_and4_bits01
    ld bc, $0003
    call AccumulateBank6WordToDA70

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $0053
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall CheckBattleKindAtLeast2OrLinkModeSet
    ld a, c
    and a
    jr nz, .call_foe_hp_check_reads_wrong_slot
    ld bc, $0066
    call AccumulateBank6WordToDA6E

.call_foe_hp_check_reads_wrong_slot:
    farcall FoeHPCheckReadsWrongSlot
    ld a, c
    and a
    jr nz, .return
    ld bc, $0067
    call AccumulateBank6WordToDA6E
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $0005
    call AccumulateBank6WordToDA6E

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 85 DrakSlash. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_DrakSlash::
    farcall AIScore_DrakSlash_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 86 BeastCut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_BeastCut::
    farcall AIScore_BeastCut_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 87 BirdBlow. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_BirdBlow::
    farcall AIScore_BirdBlow_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 88 BugBlow. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_BugBlow::
    farcall AIScore_BugBlow_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 89 Shears. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_Shears::
    farcall AIScore_Shears_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 90 DevilCut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_DevilCut::
    farcall AIScore_DevilCut_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 91 ZombieCut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_ZombieCut::
    farcall AIScore_ZombieCut_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 92 CleanCut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_CleanCut::
    farcall AIScore_CleanCut_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 93 AquaCut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_AquaCut::
    farcall AIScore_AquaCut_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 94 MetalCut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_MetalCut::
    farcall AIScore_MetalCut_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0053
    call AccumulateBank6WordToDA6E
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 95 PoisonHit. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_PoisonHit::
    farcall AIScore_PoisonHit_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0054
    call AccumulateBank6WordToDA6E

AIScore_PoisonHit_CallActorLacksStatus1Bits23And4Bits01::
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $0055
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall CheckBattleKindAtLeast2OrLinkModeSet
    ld a, c
    and a
    jr nz, .call_foe_hp_check_reads_wrong_slot
    ld bc, $0066
    call AccumulateBank6WordToDA6E

.call_foe_hp_check_reads_wrong_slot:
    farcall FoeHPCheckReadsWrongSlot
    ld a, c
    and a
    jr nz, .call_check_actor_slot0_to3_or_link_mode_set
    ld bc, $0067
    call AccumulateBank6WordToDA6E

.call_check_actor_slot0_to3_or_link_mode_set:
    farcall CheckActorSlot0To3OrLinkModeSet
    ld a, c
    and a
    jr nz, .call_actor_status4_check_reads_address
    ld bc, $0039
    call AccumulateBank6WordToDA70

.call_actor_status4_check_reads_address:
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $0005
    call AccumulateBank6WordToDA6E

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0033
    call AccumulateBank6WordToDA70

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 96 Paralyze. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_Paralyze::
    farcall AIScore_Paralyze_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0054
    call AccumulateBank6WordToDA6E
    jp AIScore_PoisonHit_CallActorLacksStatus1Bits23And4Bits01

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 97 NapAttack. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_NapAttack::
    farcall AIScore_NapAttack_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0054
    call AccumulateBank6WordToDA6E
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
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 98 SquallHit. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
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
    call AccumulateBank6WordToDA70

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $00c8
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall FailIfFoeHPAtMostFourFifthsAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_fail_if_foe_hurt_and_healer_can_cast
    ld bc, $0056
    call AccumulateBank6WordToDA6E

.call_fail_if_foe_hurt_and_healer_can_cast:
    farcall FailIfFoeHurtAndHealerCanCast
    ld a, c
    cp $01
    jr z, .call_actor_status4_check_reads_address
    and a
    jr nz, .call_actor_status4_check_reads_address
    ld bc, $00b4
    call AccumulateBank6WordToDA6E

.call_actor_status4_check_reads_address:
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $0005
    call AccumulateBank6WordToDA6E

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a
    jr nz, .done
    ld bc, $0033
    call AccumulateBank6WordToDA70

.done:
    ld c, $01
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 99 BiAttack, 100 QuadHits. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual
; checks are not interpreted (E-0083)
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
    call AccumulateBank6WordToDA70

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0005
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $00c8
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp $01
    jr z, .call_fail_if_foe_hp_at_most_four_fifths_ai
    and a
    jr nz, .call_fail_if_foe_hp_at_most_four_fifths_ai
    ld bc, $004a
    call AccumulateBank6WordToDA70

.call_fail_if_foe_hp_at_most_four_fifths_ai:
    farcall FailIfFoeHPAtMostFourFifthsAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_ai_score_bi_attack_carry_unless_battle
    ld bc, $0056
    call AccumulateBank6WordToDA6E

.call_ai_score_bi_attack_carry_unless_battle:
    farcall AIScore_BiAttack_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a
    jr nz, .call_actor_status4_check_reads_address
    ld bc, $0056
    call AccumulateBank6WordToDA6E

.call_actor_status4_check_reads_address:
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $0005
    call AccumulateBank6WordToDA6E

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 101 RainSlash. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
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
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $00c3
    call AccumulateBank6WordToDA6E
    ld bc, $00cb
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp $01
    jr z, .call_actor_status4_check_reads_address
    and a
    jr nz, .call_actor_status4_check_reads_address
    ld bc, $004a
    call AccumulateBank6WordToDA70

.call_actor_status4_check_reads_address:
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $0005
    call AccumulateBank6WordToDA6E

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 102 MultiCut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
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
    call AccumulateBank6WordToDA70

AIScore_MultiCut_CallCheckLoneFoeHPNotBelowAIDamageEstimates::
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_fail_if_foe_ai_damage_estimates_at_least
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $000a
    call AccumulateBank6WordToDA70

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $000d
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0057
    call AccumulateBank6WordToDA6E

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $004a
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 103 GigaSlash. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_GigaSlash::
    farcall AIFunc74D1AndFoeLacksStatus3And4
    ld a, c
    and a
    ret z
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a
    jr nz, .skip
    ld bc, $0033
    call AccumulateBank6WordToDA70

.skip:
    jp AIScore_MultiCut_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 104 ChargeUp. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
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
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $00ba
    call AccumulateBank6WordToDA6E
    ld bc, $00bf
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 105 PsycheUp. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
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
    call AccumulateBank6WordToDA70

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_ally_average_agl_at_least_foes
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_ally_average_agl_at_least_foes:
    farcall AllyAverageAGLAtLeastFoes
    ld a, c
    cp $01
    jr z, .call_actor_lacks_status1_bits23_and4_bits01
    and a
    jr nz, .call_actor_lacks_status1_bits23_and4_bits01
    ld bc, $002c
    call AccumulateBank6WordToDA6E

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $000a
    call AccumulateBank6WordToDA70

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $00ba
    call AccumulateBank6WordToDA6E
    ld bc, $00bf
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 106 HighJump. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
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
    call AccumulateBank6WordToDA70

.call_pass_if_foe_average_def_at_most_twice:
    farcall PassIfFoeAverageDEFAtMostTwiceAllyATK
    ld a, c
    cp $01
    jr z, .call_pass_if_twice_atk_above_lowest_foe_def
    and a
    jr nz, .call_pass_if_twice_atk_above_lowest_foe_def
    ld bc, $0058
    call AccumulateBank6WordToDA70

.call_pass_if_twice_atk_above_lowest_foe_def:
    farcall PassIfTwiceATKAboveLowestFoeDEF
    ld a, c
    cp $01
    jr z, .call_actor_lacks_status1_bits23_and4_bits01
    and a
    jr nz, .call_actor_lacks_status1_bits23_and4_bits01
    ld bc, $0059
    call AccumulateBank6WordToDA70

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $000a
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 107 EvilSlash. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
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
    call AccumulateBank6WordToDA6E

.call_any_foe_has_clear_status3:
    farcall AnyFoeHasClearStatus3
    ld a, c
    and a
    jr nz, .call_check_lone_foe_hp_not_below_ai_damage
    ld bc, $005b
    call AccumulateBank6WordToDA6E

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_pass_if_foe_average_def_at_most_twice
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_pass_if_foe_average_def_at_most_twice:
    farcall PassIfFoeAverageDEFAtMostTwiceAllyATK
    ld a, c
    cp $01
    jr z, .call_pass_if_twice_atk_above_lowest_foe_def
    and a
    jr nz, .call_pass_if_twice_atk_above_lowest_foe_def
    ld bc, $0058
    call AccumulateBank6WordToDA6E

.call_pass_if_twice_atk_above_lowest_foe_def:
    farcall PassIfTwiceATKAboveLowestFoeDEF
    ld a, c
    cp $01
    jr z, .call_actor_lacks_status1_bits23_and4_bits01
    and a
    jr nz, .call_actor_lacks_status1_bits23_and4_bits01
    ld bc, $0059
    call AccumulateBank6WordToDA6E

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $005c
    call AccumulateBank6WordToDA70

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $00bd
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall AIScore_EvilSlash_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $00b0
    call AccumulateBank6WordToDA6E

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 108 Massacre. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
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
    call AccumulateBank6WordToDA70

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $00c4
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 109 TwinSlash. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
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
    call AccumulateBank6WordToDA70

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_pass_if_foe_average_def_at_most_twice
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_pass_if_foe_average_def_at_most_twice:
    farcall PassIfFoeAverageDEFAtMostTwiceAllyATK
    ld a, c
    cp $01
    jr z, .call_pass_if_twice_atk_above_lowest_foe_def
    and a
    jr nz, .call_pass_if_twice_atk_above_lowest_foe_def
    ld bc, $005f
    call AccumulateBank6WordToDA70

.call_pass_if_twice_atk_above_lowest_foe_def:
    farcall PassIfTwiceATKAboveLowestFoeDEF
    ld a, c
    cp $01
    jr z, .call_actor_hp_is_not_one
    and a
    jr nz, .call_actor_hp_is_not_one
    ld bc, $005f
    call AccumulateBank6WordToDA70

.call_actor_hp_is_not_one:
    farcall ActorHPIsNotOne
    ld a, c
    and a
    jr nz, .call_actor_lacks_status1_bits23_and4_bits01
    ld bc, $0060
    call AccumulateBank6WordToDA70

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $005c
    call AccumulateBank6WordToDA70

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $00c7
    call AccumulateBank6WordToDA6E
    ld bc, $00d0
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall AllyCheckSide0FlagAndOtherSlots
    ld a, c
    and a
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $0062
    call AccumulateBank6WordToDA70

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 110 Berserker. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_Berserker::
    farcall AIAttackSkillUsable_779F
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
    call AccumulateBank6WordToDA6E

.call_all_other_allies_have_status0_bit6:
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a
    jr nz, .call_check_lone_foe_hp_not_below_ai_damage
    ld bc, $0017
    call AccumulateBank6WordToDA70

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_pass_if_foe_average_def_at_most_twice
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_pass_if_foe_average_def_at_most_twice:
    farcall PassIfFoeAverageDEFAtMostTwiceAllyATK
    ld a, c
    cp $01
    jr z, .call_pass_if_twice_atk_above_lowest_foe_def
    and a
    jr nz, .call_pass_if_twice_atk_above_lowest_foe_def
    ld bc, $005f
    call AccumulateBank6WordToDA70

.call_pass_if_twice_atk_above_lowest_foe_def:
    farcall PassIfTwiceATKAboveLowestFoeDEF
    ld a, c
    cp $01
    jr z, .call_actor_hp_is_not_one
    and a
    jr nz, .call_actor_hp_is_not_one
    ld bc, $005f
    call AccumulateBank6WordToDA70

.call_actor_hp_is_not_one:
    farcall ActorHPIsNotOne
    ld a, c
    and a
    jr nz, .call_actor_lacks_status1_bits23_and4_bits01
    ld bc, $0060
    call AccumulateBank6WordToDA70

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $005c
    call AccumulateBank6WordToDA70

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $00c7
    call AccumulateBank6WordToDA6E
    ld bc, $00d0
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a
    jr nz, .call_ally_check_side0_flag_and_other_slots
    ld bc, $0063
    call AccumulateBank6WordToDA70

.call_ally_check_side0_flag_and_other_slots:
    farcall AllyCheckSide0FlagAndOtherSlots
    ld a, c
    and a
    jr nz, .call_ai_score_berserker_read_slot_ai_mode
    ld bc, $005f
    call AccumulateBank6WordToDA70

.call_ai_score_berserker_read_slot_ai_mode:
    farcall AIScore_Berserker_ReadSlotAIModeIndexed_Bank05_4024
    ld a, c
    cp $01
    jr z, .call_actor_lacks_status2_bit1_and4_bits01
    and a
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $0064
    call AccumulateBank6WordToDA6E

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 111 Ramming. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_Ramming::
    farcall AIFunc779FAnd43F2AndActorHPNotOne
    ld a, c
    and a
    ret z
    farcall AnyFoeLacksStatus0Bit6
    ld a, c
    and a
    jr nz, .call_all_other_allies_have_status0_bit6
    ld bc, $005e
    call AccumulateBank6WordToDA70

.call_all_other_allies_have_status0_bit6:
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a
    jr nz, .call_ai_score_ramming_read_slot_ai_mode
    ld bc, $0017
    call AccumulateBank6WordToDA70

.call_ai_score_ramming_read_slot_ai_mode:
    farcall AIScore_Ramming_ReadSlotAIModeIndexed_Bank05_4024
    ld a, c
    cp $01
    jr z, AIScore_Ramming_CallCheckLoneFoeHPNotBelowAIDamageEstimates
    and a
    jr nz, AIScore_Ramming_CallCheckLoneFoeHPNotBelowAIDamageEstimates
    ld bc, $0064
    call AccumulateBank6WordToDA6E

AIScore_Ramming_CallCheckLoneFoeHPNotBelowAIDamageEstimates::
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a
    jr nz, .read_battle_actor
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.read_battle_actor:
    ld a, [wBattleActor]
    call AIScore_Ramming_HPBandOfSlotTemp0
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $005c
    call AccumulateBank6WordToDA70

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $00c7
    call AccumulateBank6WordToDA6E
    ld bc, $00d0
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall AllyCheckSide0FlagAndOtherSlots
    ld a, c
    and a
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $005f
    call AccumulateBank6WordToDA70

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a
    jr nz, .return
    ld bc, $0033
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 112 Kamikaze. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_Kamikaze::
    farcall AIScore_Kamikaze_AIFunc779FAnd43F2AndActorHPNotOne
    ld a, c
    and a
    ret z
    farcall AIScore_Kamikaze_ReadSlotAIModeIndexed_Bank05_4024
    ld a, c
    cp $01
    jr z, .skip
    and a
    jr nz, .skip
    ld bc, $0064
    call AccumulateBank6WordToDA6E

.skip:
    jp AIScore_Ramming_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 113 SleepAir. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_SleepAir::
    farcall AIScore_SleepAir_Conditions
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, AIScore_SleepAir_CallWeighWD044RuleBit3
    ld bc, $00bc
    call AccumulateBank6WordToDA70

AIScore_SleepAir_CallWeighWD044RuleBit3::
    call WeighWD044RuleBit3

AIScore_SleepAir_CallFewerThanTwoFoesPresent::
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AccumulateBank6WordToDA70

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 114 PalsyAir. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_PalsyAir::
    farcall AIScore_PalsyAir_Conditions
    ld a, c
    and a
    ret z
    jr AIScore_SleepAir_CallWeighWD044RuleBit3

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 115 PoisonGas. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_PoisonGas::
    farcall AIScore_PoisonGas_Conditions
    ld a, c
    and a
    ret z
    jr AIScore_SleepAir_CallWeighWD044RuleBit3

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 116 PoisonAir. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_PoisonAir::
    farcall AIScore_PoisonAir_Conditions
    ld a, c
    and a
    ret z
    jr AIScore_SleepAir_CallWeighWD044RuleBit3

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 117 Curse. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_Curse::
    farcall AIScore_Curse_Conditions
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00bd
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    jp AIScore_SleepAir_CallFewerThanTwoFoesPresent

; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 118 OddDance, 119 RobDance. It runs checks and
; adds weights to wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual
; checks are not interpreted (E-0083)
AIScore_OddDance::
    farcall AIScore_OddDance_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0009
    call AccumulateBank6WordToDA6E
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit2
    ld bc, $00c2
    call AccumulateBank6WordToDA70
    ld bc, $00d2
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit2:
    call WeighWD044RuleBit2
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 120 PaniDance. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_PaniDance::
    farcall AIScore_PaniDance_Conditions
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit2
    ld bc, $00c2
    call AccumulateBank6WordToDA70
    ld bc, $00ca
    call AccumulateBank6WordToDA6E
    ld bc, $00d2
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit2:
    call WeighWD044RuleBit2
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AccumulateBank6WordToDA70

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 121 K.O.Dance. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_KODance::
    farcall AIScore_KODance_Conditions
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit2
    ld bc, $00cd
    call AccumulateBank6WordToDA6E
    ld bc, $00cf
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit2:
    call WeighWD044RuleBit2
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_ai_gate_foe_wda74_bits45
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_ai_gate_foe_wda74_bits45:
    farcall AIGateFoeWDA74Bits45
    ld a, c
    cp $01
    jr z, .call_fail_if_any_foe_fully_resistant
    and a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $00b5
    call AccumulateBank6WordToDA6E

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AccumulateBank6WordToDA70

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.return:
    ret

; table-B AI score: AIScore_LureDance, then AIAddScoresFor5ECEAnd5FC7 when usable (E-0122)
AIScoreB_LureDance::
    call AIScore_LureDance
    ld a, c
    and a
    ret z
    call AIAddScoresFor5ECEAnd5FC7
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 122 LureDance. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_LureDance::
    farcall AIScore_LureDance_Conditions
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit2
    ld bc, $00c2
    call AccumulateBank6WordToDA70
    ld bc, $00d2
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit2:
    call WeighWD044RuleBit2
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AccumulateBank6WordToDA70

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .call_ai_add_scores_for5_ece_and5_fc7
    and a
    jr nz, .call_ai_add_scores_for5_ece_and5_fc7
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_ai_add_scores_for5_ece_and5_fc7:
    call AIAddScoresFor5ECEAnd5FC7
    ld c, $01
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 123 LifeDance. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_LifeDance::
    farcall AIScore_LifeDance_Conditions
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit2
    ld bc, $00bc
    call AccumulateBank6WordToDA6E
    ld bc, $00c4
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit2:
    call WeighWD044RuleBit2
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a
    jr nz, .call_pass_if_side0_flag_or_ally_slot_empty
    ld bc, $0029
    call AccumulateBank6WordToDA6E

.call_pass_if_side0_flag_or_ally_slot_empty:
    farcall PassIfSide0FlagOrAllySlotEmpty
    ld a, c
    and a
    jr nz, .call_ai_gate_compare_ally_stat_averages
    ld bc, $0029
    call AccumulateBank6WordToDA6E

.call_ai_gate_compare_ally_stat_averages:
    farcall AIGateCompareAllyStatAverages
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $002e
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 124 Hustle. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_Hustle::
    farcall AIScore_Hustle_Conditions
    ld a, c
    and a
    ret z
    ld a, [wBattleActor]
    call ForEachPresentSlotOfSideRun66DC
    farcall AnyFoeLacksStatus0MaskCC
    ld a, c
    and a
    jr nz, .call_any_foe_has_clear_status3
    ld bc, $001a
    call AccumulateBank6WordToDA6E

.call_any_foe_has_clear_status3:
    farcall AnyFoeHasClearStatus3
    ld a, c
    and a
    jr nz, .call_any_ally_hp_at_most_three_quarters
    ld bc, $001a
    call AccumulateBank6WordToDA6E

.call_any_ally_hp_at_most_three_quarters:
    farcall AnyAllyHPAtMostThreeQuarters
    ld a, c
    and a
    jr nz, .call_actor_hp_is_not_one
    ld bc, $001b
    call AccumulateBank6WordToDA70

.call_actor_hp_is_not_one:
    farcall ActorHPIsNotOne
    ld a, c
    and a
    jr nz, .call_fewer_than_two_allies_at_hp1
    ld bc, $0023
    call AccumulateBank6WordToDA6E

.call_fewer_than_two_allies_at_hp1:
    farcall FewerThanTwoAlliesAtHP1
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0023
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit2
    ld bc, $0024
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit2:
    call WeighWD044RuleBit2
    farcall FailIfTwoAlliesBelowHalfHP
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0069
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 125 SideStep. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
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
    call AccumulateBank6WordToDA70

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_pass_if_foe_average_atk_at_most_twice
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_pass_if_foe_average_atk_at_most_twice:
    farcall PassIfFoeAverageATKAtMostTwiceAllyDEF
    ld a, c
    cp $01
    jr z, .call_set_c_to_zero
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $006d
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit2
    ld bc, $00be
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit2:
    call WeighWD044RuleBit2
    farcall CompareFoeAverageATKWithAllyDEF
    ld a, c
    and a
    jr nz, .return
    ld bc, $0032
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 126 SandStorm. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_SandStorm::
    farcall AIScore_SandStorm_Conditions
    ld a, c
    and a
    ret z

AIScore_SandStorm_CallCheckLoneFoeHPNotBelowAIDamageEstimates::
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_pass_if_foe_average_atk_at_most_twice
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_pass_if_foe_average_atk_at_most_twice:
    farcall PassIfFoeAverageATKAtMostTwiceAllyDEF
    ld a, c
    cp $01
    jr z, .call_set_c_to_zero
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $006d
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00ba
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_compare_foe_average_atk_with_ally_def
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_compare_foe_average_atk_with_ally_def:
    farcall CompareFoeAverageATKWithAllyDEF
    ld a, c
    and a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $0032
    call AccumulateBank6WordToDA6E

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AccumulateBank6WordToDA70

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 127 Radiant. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_Radiant::
    farcall AIScore_Radiant_Conditions
    ld a, c
    and a
    ret z
    jp AIScore_SandStorm_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 128 EerieLite. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_EerieLite::
    farcall AIScore_EerieLite_Conditions
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00cc
    call AccumulateBank6WordToDA6E
    ld bc, $00d1
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AccumulateBank6WordToDA70

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 129 Surge. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_Surge::
    farcall AIScore_Surge_Conditions
    ld a, c
    and a
    ret z
    ld bc, $006f
    call AccumulateBank6WordToDA6E
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit4
    ld bc, $00ca
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit4:
    call WeighWD044RuleBit4
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 130 UltraDown. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_UltraDown::
    farcall AIScore_UltraDown_Conditions
    ld a, c
    and a
    ret z
    ld bc, $006f
    call AccumulateBank6WordToDA6E
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00cc
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 131 DeMagic. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_DeMagic::
    farcall AIScore_DeMagic_Conditions
    ld a, c
    and a
    ret z
    ld bc, $0071
    call AccumulateBank6WordToDA6E
    farcall AnyFoeLacksStatus5Bits67
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0070
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00c9
    call AccumulateBank6WordToDA70
    ld bc, $00cb
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 132 ThickFog. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_ThickFog::
    farcall AIScore_ThickFog_Conditions
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00c9
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall AIModeAtLeast2AndFoeLacks6D1A
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0072
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 4 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 133 TatsuCall, 134 DiagoCall, 135 SamsiCall, 136
; BazooCall. It runs checks and adds weights to wAISkillScore-wAISkillScore2 + $1
; (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
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
    call AccumulateBank6WordToDA6E

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $0074
    call AccumulateBank6WordToDA6E
    ld bc, $00bb
    call AccumulateBank6WordToDA6E
    ld bc, $00c7
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a
    jr nz, .return
    ld bc, $0075
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 137 SuckAir. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
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
    call AccumulateBank6WordToDA70

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit3
    ld bc, $0076
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit3:
    call WeighWD044RuleBit3
    farcall AnyAllyLacksStatus2Bit2_5D31
    ld a, c
    and a
    jr nz, .return
    ld bc, $0077
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 138 Focus. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
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
    call AccumulateBank6WordToDA70

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00c2
    call AccumulateBank6WordToDA6E
    ld bc, $00d2
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    ret

; table-B AI score: AIScore_LushLicks, then AIAddScoresFor5ECEAnd5FC7 when usable (E-0122)
AIScoreB_LushLicks::
    call AIScore_LushLicks
    ld a, c
    and a
    ret z
    call AIAddScoresFor5ECEAnd5FC7
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 139 LushLicks. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_LushLicks::
    farcall AILickSkillUsable_7AD8
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $0078
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .call_ai_add_scores_for5_ece_and5_fc7
    and a
    jr nz, .call_ai_add_scores_for5_ece_and5_fc7
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_ai_add_scores_for5_ece_and5_fc7:
    call AIAddScoresFor5ECEAnd5FC7
    ld c, $01
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 140 SickLick. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
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
    call AccumulateBank6WordToDA70

.call_pass_if_foe_average_def_at_most_twice:
    farcall PassIfFoeAverageDEFAtMostTwiceAllyATK
    ld a, c
    cp $01
    jr z, .call_pass_if_twice_atk_above_lowest_foe_def
    and a
    jr nz, .call_pass_if_twice_atk_above_lowest_foe_def
    ld bc, $002c
    call AccumulateBank6WordToDA6E

.call_pass_if_twice_atk_above_lowest_foe_def:
    farcall PassIfTwiceATKAboveLowestFoeDEF
    ld a, c
    cp $01
    jr z, .call_set_c_to_zero
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $002c
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $0078
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .call_ai_add_scores_for5_ece_and5_fc7
    and a
    jr nz, .call_ai_add_scores_for5_ece_and5_fc7
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_ai_add_scores_for5_ece_and5_fc7:
    call AIAddScoresFor5ECEAnd5FC7
    ret

; table-B AI score: AIScore_LegSweep, then AIAddScoresFor5ECEAnd5FC7 when usable (E-0122)
AIScoreB_LegSweep::
    call AIScore_LegSweep
    ld a, c
    and a
    ret z
    call AIAddScoresFor5ECEAnd5FC7
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 141 LegSweep, 142 BigTrip. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual
; checks are not interpreted (E-0083)
AIScore_LegSweep::
    farcall AIScore_LegSweep_Conditions
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $007b
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .call_ai_add_scores_for5_ece_and5_fc7
    and a
    jr nz, .call_ai_add_scores_for5_ece_and5_fc7
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_ai_add_scores_for5_ece_and5_fc7:
    call AIAddScoresFor5ECEAnd5FC7
    ld c, $01
    ret

; table-B AI score: AIScore_Ahhh, then AIAddScoresFor5ECEAnd5FC7 when usable (E-0122)
AIScoreB_Ahhh::
    call AIScore_Ahhh
    ld a, c
    and a
    ret z
    call AIAddScoresFor5ECEAnd5FC7
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 143 Ahhh, 144 WarCry. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual
; checks are not interpreted (E-0083)
AIScore_Ahhh::
    farcall AILickSkillUsable_7AD8
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00c0
    call AccumulateBank6WordToDA6E
    ld bc, $00c3
    call AccumulateBank6WordToDA70
    ld bc, $00ce
    call AccumulateBank6WordToDA70
    ld bc, $00d3
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .call_ai_add_scores_for5_ece_and5_fc7
    and a
    jr nz, .call_ai_add_scores_for5_ece_and5_fc7
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_ai_add_scores_for5_ece_and5_fc7:
    call AIAddScoresFor5ECEAnd5FC7
    ld c, $01
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 145 Geyser. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_Geyser::
    farcall AIScore_Geyser_Conditions
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $007d
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 146 DanceShut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_DanceShut::
    farcall AIScore_DanceShut_Conditions
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit2
    ld bc, $007e
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit2:
    call WeighWD044RuleBit2
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 147 MouthShut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
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
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit3
    ld bc, $0080
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit3:
    call WeighWD044RuleBit3
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 148 StrongD. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_StrongD::
    farcall AIScore_StrongD_Conditions
    ld a, c
    and a
    ret z
    call AIScoreGuardSkill_67CF
    ret z
    ld a, [wBattleActor]
    call AIScore_StrongD_HPBandOfSlotTemp0
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_fail_if_foe_skill3_d_threatens_actor_hp
    ld bc, $00c1
    call AccumulateBank6WordToDA70

.call_fail_if_foe_skill3_d_threatens_actor_hp:
    farcall FailIfFoeSkill3DThreatensActorHP
    ld a, c
    cp $01
    jr z, .call_weigh_wd044_rule_bit4
    and a
    jr nz, .call_weigh_wd044_rule_bit4
    ld bc, $0000
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit4:
    call WeighWD044RuleBit4
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 149 Dodge. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_Dodge::
    farcall AIScore_Dodge_Conditions
    ld a, c
    and a
    ret z
    call AIScoreGuardSkill_67CF
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $0088
    call AccumulateBank6WordToDA6E
    ld bc, $00c1
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 150 BladeD. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_BladeD::
    farcall AIGuardSkillUsable_7C45
    ld a, c
    and a
    ret z
    call AIScoreGuardSkill_67CF
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit4
    ld bc, $008a
    call AccumulateBank6WordToDA6E
    ld bc, $00c1
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit4:
    call WeighWD044RuleBit4
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 151 Cover, 152 Guardian. It runs checks and adds
; weights to wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual
; checks are not interpreted (E-0083)
AIScore_Cover::
    farcall AIScore_Cover_Conditions
    ld a, c
    and a
    ret z
    call AIScoreGuardSkill_67CF
    ret z
    ld a, [wBattleActor]
    call AIScore_Cover_CarryUnlessBattleSlotOutSlotEmpty
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00cd
    call AccumulateBank6WordToDA70
    ld bc, $00d1
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 153 TailWind. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_TailWind::
    farcall AIScore_TailWind_Conditions
    ld a, c
    and a
    ret z
    call AIScore_TailWind_AccumulateBank6WordToDA70
    ret z

AIScore_TailWind_CallFailIfFoeKnowsSkills42To47::
    farcall FailIfFoeKnowsSkills42To47
    ld a, c
    cp $01
    jr z, .call_set_c_to_zero
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $003a
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $008c
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 154 StormWind. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_StormWind::
    farcall AIScore_StormWind_Conditions
    ld a, c
    and a
    ret z
    jr AIScore_TailWind_CallFailIfFoeKnowsSkills42To47

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 155 AquaWall. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_AquaWall::
    farcall AIScore_AquaWall_Conditions
    ld a, c
    and a
    ret z
    ld a, [wBattleActor]
    call AIScore_AquaWall_HPBandOfSlotTemp0
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 156 SealPray. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
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
    call AccumulateBank6WordToDA70

.call_fail_if_foe_knows_skills42_to47:
    farcall FailIfFoeKnowsSkills42To47
    ld a, c
    cp $01
    jr z, .call_set_c_to_zero
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $008e
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_fail_if_foe_skill3_d_threatens_actor_hp
    ld bc, $00cb
    call AccumulateBank6WordToDA6E

.call_fail_if_foe_skill3_d_threatens_actor_hp:
    farcall FailIfFoeSkill3DThreatensActorHP
    ld a, c
    cp $01
    jr z, .call_weigh_wd044_rule_bit5
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $008f
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall AIModeAtLeast2AndFoeLacks6D1A
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0090
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 157 SuckAll. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_SuckAll::
    farcall AIScore_SuckAll_Conditions
    ld a, c
    and a
    ret z
    call AIScoreGuardSkill_67CF
    ret z
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a
    jr nz, .call_any_ally_hp_at_most_three_quarters
    ld bc, $0091
    call AccumulateBank6WordToDA6E

.call_any_ally_hp_at_most_three_quarters:
    farcall AnyAllyHPAtMostThreeQuarters
    ld a, c
    and a
    jr nz, .read_battle_actor
    ld bc, $0092
    call AccumulateBank6WordToDA70

.read_battle_actor:
    ld a, [wBattleActor]
    call AIScore_SuckAll_CarryUnlessBattleSlotOutSlotEmpty
    farcall FailIfFoeKnowsSkills42To47
    ld a, c
    cp $01
    jr z, .call_weigh_wd044_rule_bit3
    and a
    jr nz, .call_weigh_wd044_rule_bit3
    ld bc, $008e
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit3:
    call WeighWD044RuleBit3
    farcall AnyAllyLacksStatus2Bit2
    ld a, c
    and a
    jr nz, .return
    ld bc, $0097
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 158 Imitate. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_Imitate::
    farcall AIScore_Imitate_Conditions
    ld a, c
    and a
    ret z
    call AIScoreGuardSkill_67CF
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr nz, .call_fail_if_foe_knows_skills42_to47
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_fail_if_foe_knows_skills42_to47:
    farcall FailIfFoeKnowsSkills42To47
    ld a, c
    cp $01
    jr z, .call_set_c_to_zero
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $0098
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00bb
    call AccumulateBank6WordToDA70
    ld bc, $00c6
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall AIModeAtLeast2AndFoeLacks6D1A
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $009a
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 159 Meditate. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
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
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit4
    ld bc, $00c2
    call AccumulateBank6WordToDA6E
    ld bc, $00d2
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit4:
    call WeighWD044RuleBit4
    farcall FailIfTwoAlliesBelowHalfHP
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0069
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 160 LifeSong. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_LifeSong::
    farcall AIScore_LifeSong_Conditions
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit4
    ld bc, $00cc
    call AccumulateBank6WordToDA70
    ld bc, $00d3
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit4:
    call WeighWD044RuleBit4
    farcall AIGateCompareAllyStatAverages
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $002e
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 161 LoveRain. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
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
    call AccumulateBank6WordToDA70

.read_battle_actor:
    ld a, [wBattleActor]
    call ForEachPresentSlotOfSideRun66DC
    farcall ActorHPIsNotOne
    ld a, c
    and a
    jr nz, .call_fewer_than_two_allies_at_hp1
    ld bc, $00a3
    call AccumulateBank6WordToDA6E

.call_fewer_than_two_allies_at_hp1:
    farcall FewerThanTwoAlliesAtHP1
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $00a4
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit4
    ld bc, $00cc
    call AccumulateBank6WordToDA70
    ld bc, $00cf
    call AccumulateBank6WordToDA6E
    ld bc, $00d3
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit4:
    call WeighWD044RuleBit4
    farcall FailIfTwoAlliesBelowHalfHP
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0069
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 8 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 162 Whistle, 163 Pheromone, 164 StepGuard, 165
; Outside, 166 Informer, 167 Errand, 168 EagleEye, 169 MapMagic. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_Whistle::
    farcall AINeverUsableResetAISkillScore
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 170 Ahhh. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_Ahhh_6401::
    farcall AIStatusLickUsable
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $00a5
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 171 ZoneOut. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_ZoneOut::
    farcall AINeverUsableResetAISkillScore
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 172 Guard. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
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
    call AccumulateBank6WordToDA70

.call_all_other_allies_have_status0_bit6:
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a
    jr nz, .call_actor_hp_is_not_one
    ld bc, $00a7
    call AccumulateBank6WordToDA70

.call_actor_hp_is_not_one:
    farcall ActorHPIsNotOne
    ld a, c
    and a
    jr nz, .call_set_c_to_zero
    ld bc, $00a8
    call AccumulateBank6WordToDA70

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .return
    ld bc, $00a9
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 173 PanicAll. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_PanicAll_6473::
    farcall AIPanicAllUsable
    ld a, c
    and a
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .return
    ld bc, $0037
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (AIScoreRoutineTableA and
; AIScoreRoutineTableB, indexed by skill number): 174 Ironize. It runs checks and adds weights to
; wAISkillScore-wAISkillScore2 + $1 (AccumulateBank6WordToDA6E/DA70); the individual checks are not
; interpreted (E-0083)
AIScore_Ironize_648D::
    farcall AIIronizeUsable
    ld a, c
    and a
    ret z
    call AIScoreGuardSkill_67CF
    ret z
    farcall SetCToZero
    ld a, c
    and a
    jr nz, .call_ai_mode_at_least2_and_foe_lacks6_d1_a
    ld bc, $0038
    call AccumulateBank6WordToDA6E

.call_ai_mode_at_least2_and_foe_lacks6_d1_a:
    farcall AIModeAtLeast2AndFoeLacks6D1A
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $0039
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine (a lone ret: leaves the score unchanged) for skill numbers 175-191 of the
; per-skill far tables (AIScoreRoutineTableA/B, 201 entries); the skill-name table gives these
; numbers the placeholder name 'HighJump'
AIScore_NoWeightA:: ; configured code entry (E-0316); C0
    ret

; AI scoring routine (a lone ret) for skill numbers 192-199 of the per-skill far tables
AIScore_NoWeightB:: ; configured code entry (E-0316); C0
    ret

; AI scoring routine for skill number 200: advances the random value and, when wRandomLo bit 7 is
; clear, sets wAISkillScore to $0000 and the next word to $FFFF (ResetAISkillScoreE2)
AIScore_Skill200:: ; configured code entry (E-0316); C0
    call AdvanceRandom
    ld a, [wRandomLo]
    bit 7, a
    call z, ResetAISkillScoreE2
    ret
    db $c9

; word = ReadBank6TableWord; if its low byte is $FF the value is 5000, which is added to
; wAISkillScore; a positive word is added to wAISkillScore; a negative word's magnitude is added to
; wAISkillScore2
AccumulateBank6WordToDA6E::
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

; the mirror of AccumulateBank6WordToDA6E: $FF (5000) and positive words go to wAISkillScore2,
; negative words' magnitude goes to wAISkillScore
AccumulateBank6WordToDA70::
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
    db $e5, $2a, $66, $6f, $7d, $91, $6f, $7c, $98, $67, $cb, $7c, $28, $03, $21, $00
    db $00, $44, $4d, $e1, $71, $23, $70, $c9

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

; BC = the 16-bit word at ROM bank 6, $4001 + $36 * BC + 2 * wPersonalityIndex (rows of 27 words); A
; = its low byte; clobbers HL, E
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

AIScore_StrongD_HPBandOfSlotTemp0::
    ldh [hTemp0], a
    farcall HPBandOfSlotTemp0
    ld a, c
    and a
    jr z, .call_accumulate_bank6_word_to_da70
    cp $01
    jr z, .call_accumulate_bank6_word_to_da702
    cp $02
    jr z, .call_accumulate_bank6_word_to_da703
    cp $03
    jr z, .call_accumulate_bank6_word_to_da704
    cp $04
    jr z, .call_accumulate_bank6_word_to_da6_e
    ld bc, $0085
    call AccumulateBank6WordToDA6E
    jr .return

.call_accumulate_bank6_word_to_da70:
    ld bc, $0083
    call AccumulateBank6WordToDA70
    jr .return

.call_accumulate_bank6_word_to_da702:
    ld bc, $0083
    call AccumulateBank6WordToDA70
    jr .return

.call_accumulate_bank6_word_to_da703:
    ld bc, $0083
    call AccumulateBank6WordToDA70
    jr .return

.call_accumulate_bank6_word_to_da704:
    ld bc, $0083
    call AccumulateBank6WordToDA70
    jr .return

.call_accumulate_bank6_word_to_da6_e:
    ld bc, $0084
    call AccumulateBank6WordToDA6E

.return:
    ret

AIScore_AquaWall_HPBandOfSlotTemp0::
    ldh [hTemp0], a
    farcall HPBandOfSlotTemp0
    ld a, c
    and a
    jr z, .call_accumulate_bank6_word_to_da6_e
    cp $01
    jr z, .call_accumulate_bank6_word_to_da6_e2
    cp $02
    jr z, .call_accumulate_bank6_word_to_da70
    cp $03
    jr z, .call_accumulate_bank6_word_to_da702
    cp $04
    jr z, .call_accumulate_bank6_word_to_da703
    ld bc, $0086
    call AccumulateBank6WordToDA70
    jr .return

.call_accumulate_bank6_word_to_da6_e:
    ld bc, $0081
    call AccumulateBank6WordToDA6E
    jr .return

.call_accumulate_bank6_word_to_da6_e2:
    ld bc, $0082
    call AccumulateBank6WordToDA6E
    jr .return

.call_accumulate_bank6_word_to_da70:
    ld bc, $0083
    call AccumulateBank6WordToDA70
    jr .return

.call_accumulate_bank6_word_to_da702:
    ld bc, $0084
    call AccumulateBank6WordToDA70
    jr .return

.call_accumulate_bank6_word_to_da703:
    ld bc, $0085
    call AccumulateBank6WordToDA70

.return:
    ret

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
    call AIScore_SuckAll_Sub01_HPBandOfSlotTemp0
    pop bc

.next:
    inc c
    dec b
    jr nz, .loop
    ret

AIScore_SuckAll_Sub01_HPBandOfSlotTemp0::
    farcall HPBandOfSlotTemp0
    ld a, c
    cp $02
    jr nc, .call_accumulate_bank6_word_to_da70
    ld bc, $0093
    call AccumulateBank6WordToDA6E
    jr .return

.call_accumulate_bank6_word_to_da70:
    ld bc, $0094
    call AccumulateBank6WordToDA70

.return:
    ret

AIScore_Meditate_HPBandOfSlotTemp0::
    ldh [hTemp0], a
    farcall HPBandOfSlotTemp0
    ld a, c
    and a
    jr z, .call_accumulate_bank6_word_to_da70
    cp $01
    jr z, .call_accumulate_bank6_word_to_da702
    cp $02
    jr z, .call_accumulate_bank6_word_to_da703
    cp $03
    jr z, .call_accumulate_bank6_word_to_da6_e
    cp $04
    jr z, .call_accumulate_bank6_word_to_da6_e2
    ld bc, $00a0
    call AccumulateBank6WordToDA6E
    jr .return

.call_accumulate_bank6_word_to_da70:
    ld bc, $009b
    call AccumulateBank6WordToDA70
    jr .return

.call_accumulate_bank6_word_to_da702:
    ld bc, $009c
    call AccumulateBank6WordToDA70
    jr .return

.call_accumulate_bank6_word_to_da703:
    ld bc, $009d
    call AccumulateBank6WordToDA70
    jr .return

.call_accumulate_bank6_word_to_da6_e:
    ld bc, $009e
    call AccumulateBank6WordToDA6E
    jr .return

.call_accumulate_bank6_word_to_da6_e2:
    ld bc, $009f
    call AccumulateBank6WordToDA6E

.return:
    ret

AIScore_HealUs_Sub01_CarryUnlessBattleSlotOutSlotEmpty::
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp0], a
    push bc
    call AIScore_HealUs_Sub01_Sub01_HPBandOfSlotTemp0
    pop bc

.next:
    inc c
    dec b
    jr nz, .loop
    ret

AIScore_HealUs_Sub01_Sub01_HPBandOfSlotTemp0::
    push bc
    farcall HPBandOfSlotTemp0
    ld a, c
    pop bc
    ld b, a
    ld a, [wBattleActor]
    cp c
    ld hl, AIScore_HealUs_Sub01_Sub01_HPBandOfSlotTemp0_Data_66B9
    jr z, .skip
    ld hl, AIScore_HealUs_Sub01_Sub01_HPBandOfSlotTemp0_Data_66BF

.skip:
    ld a, b
    add_a_to_hl
    ld c, [hl]
    ld b, $00
    call AccumulateBank6WordToDA6E
    ret

AIScore_HealUs_Sub01_Sub01_HPBandOfSlotTemp0_Data_66B9::
    db $1e, $1f, $20, $21, $22, $22

AIScore_HealUs_Sub01_Sub01_HPBandOfSlotTemp0_Data_66BF::
    db $ab, $ac, $ad, $ae, $af, $af

; for the three slots of the side in A (bit 2), runs
; ForEachPresentSlotOfSideRun66DC_HPBandOfSlotTemp0 with hTemp0 = slot for each occupied one
; (E-0122)
ForEachPresentSlotOfSideRun66DC::
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh [hTemp0], a
    push bc
    call ForEachPresentSlotOfSideRun66DC_HPBandOfSlotTemp0
    pop bc

.next:
    inc c
    dec b
    jr nz, .loop
    ret

ForEachPresentSlotOfSideRun66DC_HPBandOfSlotTemp0::
    push bc
    farcall HPBandOfSlotTemp0
    ld a, c
    pop bc
    ld b, a
    ld a, [wBattleActor]
    cp c
    ld hl, ForEachPresentSlotOfSideRun66DC_HPBandOfSlotTemp0_Data_66FF
    jr z, .skip
    ld hl, ForEachPresentSlotOfSideRun66DC_HPBandOfSlotTemp0_Data_6705

.skip:
    ld a, b
    add_a_to_hl
    ld c, [hl]
    ld b, $00
    call AccumulateBank6WordToDA6E
    ret

ForEachPresentSlotOfSideRun66DC_HPBandOfSlotTemp0_Data_66FF::
    db $1d, $1e, $1f, $20, $21, $22

ForEachPresentSlotOfSideRun66DC_HPBandOfSlotTemp0_Data_6705::
    db $aa, $ab, $ac, $ad, $ae, $af

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
    call AccumulateBank6WordToDA6E
    ret

AIScore_Ramming_HPBandOfSlotTemp0_Data::
    db $1d, $1e, $1f, $20, $21, $22

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
    call AIScore_Cover_Sub01_HPBandOfSlotTemp0
    pop bc

.next:
    inc c
    dec b
    jr nz, .loop
    ret

AIScore_Cover_Sub01_HPBandOfSlotTemp0::
    push bc
    farcall HPBandOfSlotTemp0
    ld a, c
    pop bc
    ld b, a
    ld a, [wBattleActor]
    cp c
    ld hl, AIScore_Cover_Sub01_HPBandOfSlotTemp0_Data_6767
    jr z, .skip
    ld hl, AIScore_Cover_Sub01_HPBandOfSlotTemp0_Data_676D

.skip:
    ld a, b
    add_a_to_hl
    ld c, [hl]
    ld b, $00
    call AccumulateBank6WordToDA6E
    ret

AIScore_Cover_Sub01_HPBandOfSlotTemp0_Data_6767::
    db $21, $20, $1f, $1e, $1d, $1d

AIScore_Cover_Sub01_HPBandOfSlotTemp0_Data_676D::
    db $aa, $aa, $ab, $ac, $ad, $ae

AIScore_Upper_CompareFoeAverageATKWithAllyDEF::
    farcall CompareFoeAverageATKWithAllyDEF
    ld a, c
    and a
    jr nz, .call_accumulate_bank6_word_to_da70
    ld bc, $002b
    call AccumulateBank6WordToDA6E
    jr .return

.call_accumulate_bank6_word_to_da70:
    ld bc, $0013
    call AccumulateBank6WordToDA70

.return:
    ret

AIScore_Sap_Sub01_CarryUnlessBattleSlotOutSlotEmpty_Sub01::
    farcall AIScore_Sap_Sub01_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a
    jr nz, .call_accumulate_bank6_word_to_da6_e
    ld bc, $0013
    call AccumulateBank6WordToDA70
    jr .return

.call_accumulate_bank6_word_to_da6_e:
    ld bc, $002b
    call AccumulateBank6WordToDA6E

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

AIScore_TailWind_AccumulateBank6WordToDA70::
    ld a, [wBattleTurn]
    ld c, a
    or a
    ret nz
    ld bc, $00b6
    call AccumulateBank6WordToDA70
    ld c, $ff
    ret

; returns when MaxNegativeScoreWhenAIFlagBit0 applies; otherwise continues with
; AIScore_TailWind_Sub02 (E-0122)
AIScoreGuardSkill_67CF::
    call MaxNegativeScoreWhenAIFlagBit0
    ret z
    jr AIScore_TailWind_AccumulateBank6WordToDA70

; WeighWD044RuleBit4, then adds score word $29 to wAISkillScore when
; AllySlotsCheckThenFewerThanTwoFoes fails and again when PassIfSide0FlagOrAllySlotEmpty fails
; (E-0122)
AIAddPenaltyFor5758And5CF1::
    call WeighWD044RuleBit4
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a
    jr nz, .call_pass_if_side0_flag_or_ally_slot_empty
    ld bc, $0029
    call AccumulateBank6WordToDA6E

.call_pass_if_side0_flag_or_ally_slot_empty:
    farcall PassIfSide0FlagOrAllySlotEmpty
    ld a, c
    and a
    jr nz, .return
    ld bc, $0029
    call AccumulateBank6WordToDA6E

.return:
    ret

; adds score word $B1 when AIAddScoresFor5ECEAnd5FC7_ReadSlotAIModeIndexed_Bank05 fails and $B2 when
; AIAddScoresFor5ECEAnd5FC7_ReadSlotAIModeIndexed_Bank05_Sub02 fails (results of 1 count as passing)
; (E-0124)
AIAddScoresFor5ECEAnd5FC7::
    farcall AIAddScoresFor5ECEAnd5FC7_ReadSlotAIModeIndexed_Bank05
    ld a, c
    cp $01
    jr z, .call_ai_add_scores_for5_ece_and5_fc7_read
    and a
    jr nz, .call_ai_add_scores_for5_ece_and5_fc7_read
    ld bc, $00b1
    call AccumulateBank6WordToDA6E

.call_ai_add_scores_for5_ece_and5_fc7_read:
    farcall AIAddScoresFor5ECEAnd5FC7_ReadSlotAIModeIndexed_Bank05_Sub02
    ld a, c
    cp $01
    jr z, .return
    and a
    jr nz, .return
    ld bc, $00b2
    call AccumulateBank6WordToDA6E

.return:
    ret

; adds score word $0E to wAISkillScore2 when LinkRuleCheckWD044Bit6 fails and $0F to wAISkillScore
; when LinkRuleCheckLinkRuleTurnLimitTurnLimit fails (E-0122)
AIAddScoresFor55BEAnd5731::
    farcall LinkRuleCheckWD044Bit6
    ld a, c
    and a
    jr nz, .call_link_rule_check_link_rule_turn_limit
    ld bc, $000e
    call AccumulateBank6WordToDA70

.call_link_rule_check_link_rule_turn_limit:
    farcall LinkRuleCheckLinkRuleTurnLimitTurnLimit
    ld a, c
    and a
    jr nz, .return
    ld bc, $000f
    call AccumulateBank6WordToDA6E

.return:
    ret

AIScore_Sacrifice_LinkRuleCheckWD044Bit6::
    farcall LinkRuleCheckWD044Bit6
    ld a, c
    and a
    jr nz, .return
    ld bc, $000e
    call AccumulateBank6WordToDA70

.return:
    ret

; far-calls CheckWD044RuleBit5; when it fails (C = 0) adds weight-table entry $0E to wAISkillScore2
; (AccumulateBank6WordToDA70); used by the AI scoring routines (E-0091)
WeighWD044RuleBit5::
    farcall CheckWD044RuleBit5
    ld a, c
    and a
    jr nz, .return
    ld bc, $000e
    call AccumulateBank6WordToDA70

.return:
    ret

; far-calls CheckWD044RuleBit4; when it fails (C = 0) adds weight-table entry $0E to wAISkillScore2
; (AccumulateBank6WordToDA70); used by the AI scoring routines (E-0091)
WeighWD044RuleBit4::
    farcall CheckWD044RuleBit4
    ld a, c
    and a
    jr nz, .return
    ld bc, $000e
    call AccumulateBank6WordToDA70

.return:
    ret

; far-calls CheckWD044RuleBit3; when it fails (C = 0) adds weight-table entry $0E to wAISkillScore2
; (AccumulateBank6WordToDA70); used by the AI scoring routines (E-0091)
WeighWD044RuleBit3::
    farcall CheckWD044RuleBit3
    ld a, c
    and a
    jr nz, .return
    ld bc, $000e
    call AccumulateBank6WordToDA70

.return:
    ret

; far-calls CheckWD044RuleBit2; when it fails (C = 0) adds weight-table entry $0E to wAISkillScore2
; (AccumulateBank6WordToDA70); used by the AI scoring routines (E-0091)
WeighWD044RuleBit2::
    farcall CheckWD044RuleBit2
    ld a, c
    and a
    jr nz, .return
    ld bc, $000e
    call AccumulateBank6WordToDA70

.return:
    ret

; far-calls CheckWD044RuleBit1; when it fails (C = 0) adds weight-table entry $0E to wAISkillScore2
; (AccumulateBank6WordToDA70); used by the AI scoring routines (E-0091)
WeighWD044RuleBit1::
    farcall CheckWD044RuleBit1
    ld a, c
    and a
    jr nz, .return
    ld bc, $000e
    call AccumulateBank6WordToDA70

.return:
    ret

; A = battle slot: HL = the word for that slot at wBattleATK; A = its low byte (E-0064)
GetBattleATK_BankE2::
    ld hl, wBattleATK
    jr GetBattleMP_BankE2_Skip

GetBattleDEF_BankE2::
    ld hl, wBattleDEF
    jr GetBattleMP_BankE2_Skip

GetBattleMaxHP_BankE2::
    ld hl, wBattleMaxHP
    jr GetBattleMP_BankE2_Skip

GetBattleMaxMP_BankE2::
    ld hl, wBattleMaxMP
    jr GetBattleMP_BankE2_Skip

GetBattleHP_BankE2::
    ld hl, wBattleHP
    jr GetBattleMP_BankE2_Skip

GetBattleMP_BankE2::
    ld hl, wBattleMP
    jr GetBattleMP_BankE2_Skip
    db $21, $1f, $d9, $18, $0a, $21, $53, $da, $85, $6f, $30, $01, $24, $7e, $c9

GetBattleMP_BankE2_Skip::
    add a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes
; appear in 12 banks)
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

ClearBattleStatusBitsWithMaskD_BankE2_Data::
    db $df, $fe, $00, $fd, $73, $ef, $bf

; Sets bit 0 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit0OfLevelUpGainsIndexed_BankE2::
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; Sets bit 1 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit1OfLevelUpGainsIndexed_BankE2::
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; Sets bit 2 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
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
