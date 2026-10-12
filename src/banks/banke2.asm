SECTION "Bank E2", ROMX[$4000], BANK[$E2]
    db $E2

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 0 (no name). It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Skill00:: ; heuristic: follows a terminator; C0
Func_0E2_4001:: ; address name
    farcall AIScore_Skill00_Conditions
    ld a, c
    and a, a
    ret z
    farcall AnyFoeHasDEFAtLeast2
    ld a, c
    and a, a
    jr nz, .call_at_least_two_foes_present
    ld bc, $0000
    call AccumulateBank6WordToDA6E

.call_at_least_two_foes_present:
    farcall AtLeastTwoFoesPresent
    ld a, c
    and a, a
    jr nz, .call_check_lone_foe_hp_not_below_ai_damage
    ld bc, $0001
    call AccumulateBank6WordToDA6E

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_check_foe_status7_bit2
    ld bc, $0002
    call AccumulateBank6WordToDA6E

.call_check_foe_status7_bit2:
    farcall CheckFoeStatus7Bit2
    ld a, c
    cp a, $01
    jr z, .call_actor_lacks_status1_bits23_and4_bits01
    and a, a
    jr nz, .call_actor_lacks_status1_bits23_and4_bits01
    ld bc, $0003
    call AccumulateBank6WordToDA70

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $0005
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_check_battle_kind_at_least2_or_link_mode
    ld bc, $0006
    call AccumulateBank6WordToDA6E

.call_check_battle_kind_at_least2_or_link_mode:
    farcall CheckBattleKindAtLeast2OrLinkModeSet
    ld a, c
    and a, a
    jr nz, .call_foe_hp_check_reads_wrong_slot
    ld bc, $0066
    call AccumulateBank6WordToDA6E

.call_foe_hp_check_reads_wrong_slot:
    farcall FoeHPCheckReadsWrongSlot
    ld a, c
    and a, a
    jr nz, .call_check_actor_slot0_to3_or_link_mode_set
    ld bc, $0067
    call AccumulateBank6WordToDA6E

.call_check_actor_slot0_to3_or_link_mode_set:
    farcall CheckActorSlot0To3OrLinkModeSet
    ld a, c
    and a, a
    jr nz, .call_actor_status4_check_reads_address
    ld bc, $0068
    call AccumulateBank6WordToDA6E

.call_actor_status4_check_reads_address:
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a, a
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $0005
    call AccumulateBank6WordToDA6E

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $0033
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 3 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 1 Blaze, 2 Blazemore, 3 Blazemost. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Blaze:: ; heuristic: follows a terminator; C0
Func_0E2_40BF:: ; address name
    farcall AIFireSkillUsable
    ld a, c
    and a, a
    ret z
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a, a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $0008
    call AccumulateBank6WordToDA70

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $000B
    call AccumulateBank6WordToDA6E

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a, a
    jr nz, .call_ai_add_scores_for55_be_and5731
    ld bc, $000C
    call AccumulateBank6WordToDA6E

.call_ai_add_scores_for55_be_and5731:
    call AIAddScoresFor55BEAnd5731
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $0010
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 15 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 4 Firebal, 5 Firebane, 6 Firebolt, 7 Bang, 8 Boom, 9 Explodet, 10 Infernos, 11 Infermore, 12 Infermost, 13 Bolt .... It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Firebal:: ; heuristic: follows a terminator; C0
Func_0E2_411C:: ; address name
    farcall AIFireSkillUsable
    ld a, c
    and a, a
    ret z
    farcall AIGateFoeStatus1Mask22
    ld a, c
    cp a, $01
    jr z, .call_fail_if_foe_ai_damage_estimates_at_least
    and a, a
    jr nz, .call_fail_if_foe_ai_damage_estimates_at_least
    ld bc, $0004
    call AccumulateBank6WordToDA70

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a, a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $000A
    call AccumulateBank6WordToDA70

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $000B
    call AccumulateBank6WordToDA6E

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a, a
    jr nz, .call_ai_add_scores_for55_be_and5731
    ld bc, $000D
    call AccumulateBank6WordToDA6E

.call_ai_add_scores_for55_be_and5731:
    call AIAddScoresFor55BEAnd5731
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a, a
    jr nz, .call_fewer_than_two_foes_present
    ld bc, $0014
    call AccumulateBank6WordToDA6E

.call_fewer_than_two_foes_present:
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp a, $01
    jr z, .call_fail_if_any_foe_fully_resistant
    and a, a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $004A
    call AccumulateBank6WordToDA70

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0012
    call AccumulateBank6WordToDA70

.return:
    ret

; table-B AI score: AIScore_Beat, then adds a penalty word when the follow-up check fails (E-0122)
; no direct call (reached through a table, a jump or a vector)
AIScoreB_Beat:: ; heuristic: follows a terminator; C0
Func_0E2_41C5:: ; address name
    call AIScore_Beat
    ld a, c
    and a, a
    ret z
    farcall AIGateFoeWDA74Bits45
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $00B5
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 19 Beat, 20 Defeat. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; 1 call site from 1 routine (e.g. AIScoreB_Beat)
AIScore_Beat::
Func_0E2_41E0:: ; address name
    farcall AIScore_Beat_Conditions
    ld a, c
    and a, a
    ret z
    farcall AIGateFoeStatus1Mask22
    ld a, c
    cp a, $01
    jr z, .call_set_c_to_zero
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $0004
    call AccumulateBank6WordToDA70

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_ai_add_scores_for55_be_and5731
    ld bc, $00CD
    call AccumulateBank6WordToDA6E
    ld bc, $00CF
    call AccumulateBank6WordToDA70

.call_ai_add_scores_for55_be_and5731:
    call AIAddScoresFor55BEAnd5731
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, .call_ai_gate_foe_wda74_bits45
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_ai_gate_foe_wda74_bits45:
    farcall AIGateFoeWDA74Bits45
    ld a, c
    cp a, $01
    jr z, .call_fail_if_any_foe_fully_resistant
    and a, a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $00B5
    call AccumulateBank6WordToDA6E

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a, a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AccumulateBank6WordToDA70

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a, a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp a, $01
    jr z, .done
    and a, a
    jr nz, .done
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.done:
    ld c, $01
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 21 Sacrifice. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Sacrifice:: ; heuristic: follows a terminator; C0
Func_0E2_4279:: ; address name
    farcall AIScore_Sacrifice_ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    ret z
    farcall ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr nz, .call_all_other_allies_have_status0_bit6
    ld bc, $0017
    call AccumulateBank6WordToDA70

.call_all_other_allies_have_status0_bit6:
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a, a
    jr nz, .call_at_least_two_foes_present
    ld bc, $0017
    call AccumulateBank6WordToDA70

.call_at_least_two_foes_present:
    farcall AtLeastTwoFoesPresent
    ld a, c
    and a, a
    jr nz, .call_any_ally_hp_at_most_three_quarters
    ld bc, $0011
    call AccumulateBank6WordToDA70

.call_any_ally_hp_at_most_three_quarters:
    farcall AnyAllyHPAtMostThreeQuarters
    ld a, c
    and a, a
    jr nz, .call_check_lone_foe_hp_not_below_ai_damage
    ld bc, $001B
    call AccumulateBank6WordToDA70

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_ai_score_sacrifice_link_rule_check_wd044
    ld bc, $00CD
    call AccumulateBank6WordToDA6E
    ld bc, $00CF
    call AccumulateBank6WordToDA70

.call_ai_score_sacrifice_link_rule_check_wd044:
    call AIScore_Sacrifice_LinkRuleCheckWD044Bit6
    farcall AIScore_Sacrifice_GetBattleMaxHP_Bank05
    ld a, c
    and a, a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $0019
    call AccumulateBank6WordToDA6E

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0012
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 3 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 22 Heal, 23 HealMore, 24 HealAll. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
AIScore_Heal:: ; heuristic: follows a terminator; C0
Func_0E2_4310:: ; address name
    farcall AIHealUsable
    ld a, c
    and a, a
    ret z
    farcall FailIfTwoAlliesBelowHalfHP
    ld a, c
    cp a, $01
    jr z, AIScore_HealUs_AnyFoeLacksStatus0MaskCC
    and a, a
    jr nz, AIScore_HealUs_AnyFoeLacksStatus0MaskCC
    ld bc, $0069
    call AccumulateBank6WordToDA70

; only called from AIScore_HealUs (E-0047)
; 1 call site from 1 routine (e.g. AIScore_HealUs)
; reads: wBattleActor
AIScore_HealUs_AnyFoeLacksStatus0MaskCC::
Func_0E2_432D:: ; address name
    farcall AnyFoeLacksStatus0MaskCC
    ld a, c
    and a, a
    jr nz, .call_any_foe_has_clear_status3
    ld bc, $001A
    call AccumulateBank6WordToDA6E

.call_any_foe_has_clear_status3:
    farcall AnyFoeHasClearStatus3
    ld a, c
    and a, a
    jr nz, .call_any_ally_hp_at_most_three_quarters
    ld bc, $001A
    call AccumulateBank6WordToDA6E

.call_any_ally_hp_at_most_three_quarters:
    farcall AnyAllyHPAtMostThreeQuarters
    ld a, c
    and a, a
    jr nz, .read_battle_actor
    ld bc, $001B
    call AccumulateBank6WordToDA70

.read_battle_actor:
    ld a, [wBattleActor]
    call AIScore_HealUs_Sub01_CarryUnlessBattleSlotOutSlotEmpty
    farcall ActorHPIsNotOne
    ld a, c
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $0023
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit4
    ld bc, $0024
    call AccumulateBank6WordToDA6E
    ld bc, $00C8
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit4:
    call WeighWD044RuleBit4
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 25 HealUs, 26 HealUsAll. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_HealUs:: ; heuristic: follows a terminator; C0
Func_0E2_438D:: ; address name
    farcall AIHealUsable
    ld a, c
    and a, a
    ret z
    call AIScore_HealUs_AnyFoeLacksStatus0MaskCC
    farcall FewerThanTwoAlliesAtHP1
    ld a, c
    and a, a
    jr nz, .call_fail_if_two_allies_below_half_hp
    ld bc, $0023
    call AccumulateBank6WordToDA6E

.call_fail_if_two_allies_below_half_hp:
    farcall FailIfTwoAlliesBelowHalfHP
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0069
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 3 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 27 MPass, 28 MPassmore, 29 MPassmost. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_MPass:: ; heuristic: follows a terminator; C0
Func_0E2_43BE:: ; address name
    farcall AIScore_MPass_ActorLacksStatus4Bits67
    ld a, c
    and a, a
    ret z
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 30 Vivify, 31 Revive. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Vivify:: ; heuristic: follows a terminator; C0
Func_0E2_43C8:: ; address name
    farcall AIScore_Vivify_Conditions
    ld a, c
    and a, a
    ret z
    call AIAddPenaltyFor5758And5CF1
    farcall AIGateCompareAllyStatAverages
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $002E
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 32 Farewell. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Farewell:: ; heuristic: follows a terminator; C0
Func_0E2_43E9:: ; address name
    farcall AIScore_Farewell_Conditions
    ld a, c
    and a, a
    ret z
    call AIAddPenaltyFor5758And5CF1
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_ai_gate_compare_ally_stat_averages
    ld bc, $00BC
    call AccumulateBank6WordToDA6E
    ld bc, $00C4
    call AccumulateBank6WordToDA70

.call_ai_gate_compare_ally_stat_averages:
    farcall AIGateCompareAllyStatAverages
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $002E
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 33 Antidote. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Antidote:: ; heuristic: follows a terminator; C0
Func_0E2_4420:: ; address name
    farcall AIScore_Antidote_Conditions
    ld a, c
    and a, a
    ret z
    ld bc, $002A
    call AccumulateBank6WordToDA6E
    call WeighWD044RuleBit4
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 34 DeChaos. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_DeChaos:: ; heuristic: follows a terminator; C0
Func_0E2_4433:: ; address name
    farcall AIScore_DeChaos_Conditions
    ld a, c
    and a, a
    ret z
    ld bc, $002A
    call AccumulateBank6WordToDA6E
    call WeighWD044RuleBit4
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 35 NumbOff. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_NumbOff:: ; heuristic: follows a terminator; C0
Func_0E2_4446:: ; address name
    farcall AIScore_NumbOff_Conditions
    ld a, c
    and a, a
    ret z
    ld bc, $002A
    call AccumulateBank6WordToDA6E
    call WeighWD044RuleBit4
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 36 CurseOff. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_CurseOff:: ; heuristic: follows a terminator; C0
Func_0E2_4459:: ; address name
    farcall AIScore_CurseOff_Conditions
    ld a, c
    and a, a
    ret z
    ld bc, $002A
    call AccumulateBank6WordToDA6E
    call WeighWD044RuleBit4
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 37 Upper, 38 Increase. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Upper:: ; heuristic: follows a terminator; C0
Func_0E2_446C:: ; address name
    farcall AIScore_Upper_Conditions
    ld a, c
    and a, a
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    call AIScore_Upper_CompareFoeAverageATKWithAllyDEF
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $00C1
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 39 Sap, 40 Defense. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Sap:: ; heuristic: follows a terminator; C0
Func_0E2_449C:: ; address name
    farcall AIScore_Sap_Conditions
    ld a, c
    and a, a
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_pass_if_foe_average_def_at_most_twice
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_pass_if_foe_average_def_at_most_twice:
    farcall PassIfFoeAverageDEFAtMostTwiceAllyATK
    ld a, c
    cp a, $01
    jr z, .call_pass_if_twice_atk_above_lowest_foe_def
    and a, a
    jr nz, .call_pass_if_twice_atk_above_lowest_foe_def
    ld bc, $002C
    call AccumulateBank6WordToDA6E

.call_pass_if_twice_atk_above_lowest_foe_def:
    farcall PassIfTwiceATKAboveLowestFoeDEF
    ld a, c
    cp a, $01
    jr z, .call_set_c_to_zero
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $002C
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00CC
    call AccumulateBank6WordToDA6E
    ld bc, $00D1
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp a, $01
    jr z, .call_ai_score_sap_sub01_carry_unless_battle
    and a, a
    jr nz, .call_ai_score_sap_sub01_carry_unless_battle
    ld bc, $0012
    call AccumulateBank6WordToDA70

.call_ai_score_sap_sub01_carry_unless_battle:
    call AIScore_Sap_Sub01_CarryUnlessBattleSlotOutSlotEmpty_Sub01
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a, a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 41 Speed, 42 SpeedUp. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Speed:: ; heuristic: follows a terminator; C0
Func_0E2_4536:: ; address name
    farcall AIScore_Speed_Conditions
    ld a, c
    and a, a
    ret z
    farcall FastestFoeAGLAbove31PercentOfActor
    ld a, c
    and a, a
    jr nz, .call_ally_average_agl_at_least_foes
    ld bc, $002D
    call AccumulateBank6WordToDA70

.call_ally_average_agl_at_least_foes:
    farcall AllyAverageAGLAtLeastFoes
    ld a, c
    cp a, $01
    jr z, .call_weigh_wd044_rule_bit5
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $002C
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 43 Slow, 44 SlowAll. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Slow:: ; heuristic: follows a terminator; C0
Func_0E2_4567:: ; address name
    farcall AIScore_Slow_Conditions
    ld a, c
    and a, a
    ret z
    farcall AIGateFoeStatus1Mask22
    ld a, c
    cp a, $01
    jr z, .call_fastest_foe_agl_above31_percent_of_actor
    and a, a
    jr nz, .call_fastest_foe_agl_above31_percent_of_actor
    ld bc, $0004
    call AccumulateBank6WordToDA70

.call_fastest_foe_agl_above31_percent_of_actor:
    farcall FastestFoeAGLAbove31PercentOfActor
    ld a, c
    and a, a
    jr nz, .call_ally_average_agl_at_least_foes
    ld bc, $002D
    call AccumulateBank6WordToDA70

.call_ally_average_agl_at_least_foes:
    farcall AllyAverageAGLAtLeastFoes
    ld a, c
    cp a, $01
    jr z, .call_set_c_to_zero
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $002C
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00CC
    call AccumulateBank6WordToDA6E
    ld bc, $00D1
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a, a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AccumulateBank6WordToDA70

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a, a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.return:
    ret

; table-B AI score: AIScore_TwinHits, then adds a penalty word when the follow-up check fails (E-0122)
; no direct call (reached through a table, a jump or a vector)
AIScoreB_TwinHits:: ; heuristic: follows a terminator; C0
Func_0E2_45FE:: ; address name
    call AIScore_TwinHits
    ld a, c
    and a, a
    ret z
    farcall FailIfAllyCanUseSkill63Or64
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $00B3
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 45 TwinHits. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; 1 call site from 1 routine (e.g. AIScoreB_TwinHits)
AIScore_TwinHits::
Func_0E2_4619:: ; address name
    farcall AIScore_TwinHits_CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    farcall AIScore_TwinHits_ReadSlotAIModeIndexed_Bank05
    ld a, c
    cp a, $01
    jr z, .call_ai_score_twin_hits_read_slot_ai_mode
    and a, a
    jr nz, .call_ai_score_twin_hits_read_slot_ai_mode
    ld bc, $002F
    call AccumulateBank6WordToDA6E

.call_ai_score_twin_hits_read_slot_ai_mode:
    farcall AIScore_TwinHits_ReadSlotAIModeIndexed_Bank05_Sub02
    ld a, c
    cp a, $01
    jr z, .call_set_c_to_zero
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $0030
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00BA
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall FailIfAllyCanUseSkill63Or64
    ld a, c
    cp a, $01
    jr z, .done
    and a, a
    jr nz, .done
    ld bc, $00B3
    call AccumulateBank6WordToDA6E

.done:
    ld c, $01
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 46 Surround. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Surround:: ; heuristic: follows a terminator; C0
Func_0E2_4674:: ; address name
    farcall AIScore_Surround_Conditions
    ld a, c
    and a, a
    ret z
    farcall AIGateFoeStatus1Mask22
    ld a, c
    cp a, $01
    jr z, .call_check_lone_foe_hp_not_below_ai_damage
    and a, a
    jr nz, .call_check_lone_foe_hp_not_below_ai_damage
    ld bc, $0004
    call AccumulateBank6WordToDA70

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_pass_if_foe_average_atk_at_most_twice
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_pass_if_foe_average_atk_at_most_twice:
    farcall PassIfFoeAverageATKAtMostTwiceAllyDEF
    ld a, c
    cp a, $01
    jr z, .call_set_c_to_zero
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $0031
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00BA
    call AccumulateBank6WordToDA70
    ld bc, $00CC
    call AccumulateBank6WordToDA6E
    ld bc, $00D1
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall CompareFoeAverageATKWithAllyDEF
    ld a, c
    and a, a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $0032
    call AccumulateBank6WordToDA6E

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a, a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AccumulateBank6WordToDA70

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a, a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 47 Sleep, 48 SleepAll. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Sleep:: ; heuristic: follows a terminator; C0
Func_0E2_4721:: ; address name
    farcall AIScore_Sleep_Conditions
    ld a, c
    and a, a
    ret z
    farcall AIGateFoeStatus1Mask22
    ld a, c
    cp a, $01
    jr z, .call_ally_average_agl_at_least_foes
    and a, a
    jr nz, .call_ally_average_agl_at_least_foes
    ld bc, $0004
    call AccumulateBank6WordToDA70

.call_ally_average_agl_at_least_foes:
    farcall AllyAverageAGLAtLeastFoes
    ld a, c
    cp a, $01
    jr z, .call_set_c_to_zero
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $002C
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00BC
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a, a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 49 TakeMagic. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_TakeMagic:: ; heuristic: follows a terminator; C0
Func_0E2_478E:: ; address name
    farcall AIScore_TakeMagic_Conditions
    ld a, c
    and a, a
    ret z
    farcall ActorMPBelowThreeQuarters
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $0034
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 50 RobMagic. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_RobMagic:: ; heuristic: follows a terminator; C0
Func_0E2_47AB:: ; address name
    farcall AIScore_RobMagic_Conditions
    ld a, c
    and a, a
    ret z
    ld bc, $0035
    call AccumulateBank6WordToDA6E
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 51 StopSpell. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_StopSpell:: ; heuristic: follows a terminator; C0
Func_0E2_47CE:: ; address name
    farcall AIScore_StopSpell_Conditions
    ld a, c
    and a, a
    ret z
    farcall AIGateFoeStatus1Mask22
    ld a, c
    cp a, $01
    jr z, .call_weigh_wd044_rule_bit5
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $0004
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_ai_mode_at_least2_and_foe_lacks6_d1_a
    ld bc, $00CC
    call AccumulateBank6WordToDA6E
    ld bc, $00D1
    call AccumulateBank6WordToDA70

.call_ai_mode_at_least2_and_foe_lacks6_d1_a:
    farcall AIModeAtLeast2AndFoeLacks6D1A
    ld a, c
    cp a, $01
    jr z, .call_fail_if_any_foe_fully_resistant
    and a, a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $0036
    call AccumulateBank6WordToDA6E

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a, a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AccumulateBank6WordToDA70

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a, a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 52 PanicAll. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_PanicAll:: ; heuristic: follows a terminator; C0
Func_0E2_4855:: ; address name
    farcall AIPanicAllUsable
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00CA
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a, a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AccumulateBank6WordToDA70

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a, a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 53 Ironize. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Ironize:: ; heuristic: follows a terminator; C0
Func_0E2_48AE:: ; address name
    farcall AIIronizeUsable
    ld a, c
    and a, a
    ret z
    call AIScoreGuardSkill_67CF
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00D0
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 54 MagicBack, 55 Bounce. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_MagicBack:: ; heuristic: follows a terminator; C0
Func_0E2_48CF:: ; address name
    farcall AIScore_MagicBack_Conditions
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_ai_mode_at_least2_and_foe_lacks6_d1_a
    ld bc, $00C0
    call AccumulateBank6WordToDA70

.call_ai_mode_at_least2_and_foe_lacks6_d1_a:
    farcall AIModeAtLeast2AndFoeLacks6D1A
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0036
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 56 Barrier. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Barrier:: ; heuristic: follows a terminator; C0
Func_0E2_48FD:: ; address name
    farcall AIScore_Barrier_Conditions
    ld a, c
    and a, a
    ret z
    farcall FailIfFoeKnowsSkills42To47
    ld a, c
    cp a, $01
    jr z, .call_weigh_wd044_rule_bit5
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $003A
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 57 MagicWall. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_MagicWall:: ; heuristic: follows a terminator; C0
Func_0E2_491E:: ; address name
    farcall AIScore_MagicWall_Conditions
    ld a, c
    and a, a
    ret z
    call WeighWD044RuleBit5
    farcall AIModeAtLeast2AndFoeLacks6D1A
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0036
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 58 Transform. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Transform:: ; heuristic: follows a terminator; C0
Func_0E2_493F:: ; address name
    farcall AIUsableAndActorLacksStatus4Bits67
    ld a, c
    and a, a
    ret z
    farcall PassIfTwiceATKAboveLowestFoeDEF
    ld a, c
    cp a, $01
    jr z, .call_ai_score_transform_read_slot_ai_mode
    and a, a
    jr nz, .call_ai_score_transform_read_slot_ai_mode
    ld bc, $003B
    call AccumulateBank6WordToDA6E

.call_ai_score_transform_read_slot_ai_mode:
    farcall AIScore_Transform_ReadSlotAIModeIndexed_Bank05
    ld a, c
    cp a, $01
    jr z, .call_set_c_to_zero
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $003C
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00CE
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 59 BeDragon. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_BeDragon:: ; heuristic: follows a terminator; C0
Func_0E2_4984:: ; address name
    farcall AIUsableAndActorLacksStatus4Bits67
    ld a, c
    and a, a
    ret z
    farcall FailIfFoeKnowsSkills42To47
    ld a, c
    cp a, $01
    jr z, .call_weigh_wd044_rule_bit5
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $003A
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall AIScore_BeDragon_GetBattleMaxHP_Bank05
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $003D
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 60 Chance. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Chance:: ; heuristic: follows a terminator; C0
Func_0E2_49B5:: ; address name
    farcall CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a, a
    jr nz, .call_actor_hp_is_not_one
    ld bc, $003F
    call AccumulateBank6WordToDA6E

.call_actor_hp_is_not_one:
    farcall ActorHPIsNotOne
    ld a, c
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $0040
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00BF
    call AccumulateBank6WordToDA6E
    ld bc, $00C5
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $0042
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 61 MegaMagic. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_MegaMagic:: ; heuristic: follows a terminator; C0
Func_0E2_4A08:: ; address name
    farcall AIScore_MegaMagic_AIAttackSkillUsable_74D1
    ld a, c
    and a, a
    ret z
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a, a
    jr nz, .call_check_lone_foe_hp_not_below_ai_damage
    ld bc, $0043
    call AccumulateBank6WordToDA6E

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_any_ally_lacks_status1_bits23_and4
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_any_ally_lacks_status1_bits23_and4:
    farcall AnyAllyLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $0044
    call AccumulateBank6WordToDA70

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_ai_score_mega_magic_read_link_mode_and
    ld bc, $0045
    call AccumulateBank6WordToDA6E

.call_ai_score_mega_magic_read_link_mode_and:
    farcall AIScore_MegaMagic_ReadLinkModeAndBattleActor
    ld a, c
    and a, a
    jr nz, .call_link_rule_check_link_rule_turn_limit
    ld bc, $000E
    call AccumulateBank6WordToDA70

.call_link_rule_check_link_rule_turn_limit:
    farcall LinkRuleCheckLinkRuleTurnLimitTurnLimit
    ld a, c
    and a, a
    jr nz, .call_ally_slots_check_then_fewer_than_two
    ld bc, $0046
    call AccumulateBank6WordToDA6E

.call_ally_slots_check_then_fewer_than_two:
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a, a
    jr nz, .call_ai_score_mega_magic_read_link_mode
    ld bc, $0047
    call AccumulateBank6WordToDA6E

.call_ai_score_mega_magic_read_link_mode:
    farcall AIScore_MegaMagic_ReadLinkMode
    ld a, c
    and a, a
    jr nz, .call_ai_score_mega_magic_read_slot_ai_mode
    ld bc, $0048
    call AccumulateBank6WordToDA6E

.call_ai_score_mega_magic_read_slot_ai_mode:
    farcall AIScore_MegaMagic_ReadSlotAIModeIndexed_Bank05
    ld a, c
    cp a, $01
    jr z, .return
    or a, a
    jr nz, .return
    ld bc, $003E
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 62 BigBang, 63 Hellblast. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_BigBang:: ; heuristic: follows a terminator; C0
Func_0E2_4AB6:: ; address name
    farcall AIAttackSkillUsable_74D1
    ld a, c
    and a, a
    ret z
    farcall ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr nz, .call_fail_if_foe_ai_damage_estimates_at_least
    ld bc, $0049
    call AccumulateBank6WordToDA6E

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a, a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $000A
    call AccumulateBank6WordToDA70

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a, a
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $000D
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall LinkRuleCheckLinkRuleTurnLimitTurnLimit
    ld a, c
    and a, a
    jr nz, .call_ally_slots_check_then_fewer_than_two
    ld bc, $0046
    call AccumulateBank6WordToDA6E

.call_ally_slots_check_then_fewer_than_two:
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a, a
    jr nz, .call_fewer_than_two_foes_present
    ld bc, $0047
    call AccumulateBank6WordToDA6E

.call_fewer_than_two_foes_present:
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp a, $01
    jr z, .call_check_battle_kind_not2_or3
    and a, a
    jr nz, .call_check_battle_kind_not2_or3
    ld bc, $004A
    call AccumulateBank6WordToDA70

.call_check_battle_kind_not2_or3:
    farcall CheckBattleKindNot2Or3
    ld a, c
    and a, a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $004B
    call AccumulateBank6WordToDA6E

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0012
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 8 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 64 FireAir, 65 BlazeAir, 66 Scorching, 67 WhiteFire, 68 FrigidAir, 69 IceAir, 70 IceStorm, 71 WhiteAir. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_FireAir:: ; heuristic: follows a terminator; C0
Func_0E2_4B6B:: ; address name
    farcall AIScore_FireAir_AIAttackSkillUsable_74D1
    ld a, c
    and a, a
    ret z
    farcall AIScore_FireAir_ReadSlotAIModeIndexed_Bank05
    ld a, c
    and a, a
    jr nz, .call_at_least_two_foes_present
    ld bc, $004C
    call AccumulateBank6WordToDA70

.call_at_least_two_foes_present:
    farcall AtLeastTwoFoesPresent
    ld a, c
    and a, a
    jr nz, .call_fail_if_foe_ai_damage_estimates_at_least
    ld bc, $0011
    call AccumulateBank6WordToDA70

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a, a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $000A
    call AccumulateBank6WordToDA70

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a, a
    jr nz, .call_actor_lacks_status4_bits45
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_actor_lacks_status4_bits45:
    farcall ActorLacksStatus4Bits45
    ld a, c
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $004D
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $006A
    call AccumulateBank6WordToDA6E

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit3
    ld bc, $000D
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit3:
    call WeighWD044RuleBit3
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp a, $01
    jr z, .call_any_ally_lacks_status2_bit2_5_d31
    and a, a
    jr nz, .call_any_ally_lacks_status2_bit2_5_d31
    ld bc, $004A
    call AccumulateBank6WordToDA70

.call_any_ally_lacks_status2_bit2_5_d31:
    farcall AnyAllyLacksStatus2Bit2_5D31
    ld a, c
    and a, a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $004E
    call AccumulateBank6WordToDA70

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0012
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 72 WindBeast. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_WindBeast:: ; heuristic: follows a terminator; C0
Func_0E2_4C30:: ; address name
    farcall AIAttackSkillUsable_74D1
    ld a, c
    and a, a
    ret z
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, AIScore_Vacuum_CheckLoneFoeHPNotBelowAIDamageEstimates
    ld bc, $0010
    call AccumulateBank6WordToDA70

; only called from AIScore_Vacuum (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Vacuum)
AIScore_Vacuum_CheckLoneFoeHPNotBelowAIDamageEstimates::
Func_0E2_4C49:: ; address name
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_fail_if_foe_ai_damage_estimates_at_least
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a, a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $000A
    call AccumulateBank6WordToDA70

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a, a
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $000D
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall FailIfFoeHPAtLeast150PercentOfActor
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $004F
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 73 Vacuum, 74 Lightning. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Vacuum:: ; heuristic: follows a terminator; C0
Func_0E2_4CA1:: ; address name
    farcall AIAttackSkillUsable_74D1
    ld a, c
    and a, a
    ret z
    call AIScore_Vacuum_CheckLoneFoeHPNotBelowAIDamageEstimates
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp a, $01
    jr z, .call_fail_if_any_foe_fully_resistant
    and a, a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $004A
    call AccumulateBank6WordToDA70

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0012
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 75 RockThrow. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_RockThrow:: ; heuristic: follows a terminator; C0
Func_0E2_4CE6:: ; address name
    farcall AIFunc74D1AndFoeLacksStatus3And4
    ld a, c
    and a, a
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_fail_if_foe_ai_damage_estimates_at_least
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a, a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $000A
    call AccumulateBank6WordToDA70

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a, a
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $000D
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp a, $01
    jr z, .call_check_actor_slot0_to3_or_link_mode_set
    and a, a
    jr nz, .call_check_actor_slot0_to3_or_link_mode_set
    ld bc, $004A
    call AccumulateBank6WordToDA70

.call_check_actor_slot0_to3_or_link_mode_set:
    farcall CheckActorSlot0To3OrLinkModeSet
    ld a, c
    and a, a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $006B
    call AccumulateBank6WordToDA70

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0012
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 76 Watershot. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Watershot:: ; heuristic: follows a terminator; C0
Func_0E2_4D7B:: ; address name
    farcall AIFunc74D1AndFoeLacksStatus3And4
    ld a, c
    and a, a
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_fail_if_foe_ai_damage_estimates_at_least
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a, a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $000D
    call AccumulateBank6WordToDA70

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a, a
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $000D
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0010
    call AccumulateBank6WordToDA70

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $004A
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 77 Tidalwave. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Tidalwave:: ; heuristic: follows a terminator; C0
Func_0E2_4DEC:: ; address name
    farcall AIFunc74D1AndFoeLacksStatus3And4
    ld a, c
    and a, a
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_fail_if_foe_ai_damage_estimates_at_least
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a, a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $000A
    call AccumulateBank6WordToDA70

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a, a
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $000D
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp a, $01
    jr z, .call_fail_if_any_foe_fully_resistant
    and a, a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $004A
    call AccumulateBank6WordToDA70

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0012
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 78 CallHelp, 79 YellHelp. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_CallHelp:: ; heuristic: follows a terminator; C0
Func_0E2_4E71:: ; address name
    farcall AIFunc74D1AndFoeLacksStatus3And4
    ld a, c
    and a, a
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_fail_if_foe_ai_damage_estimates_at_least
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a, a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $0008
    call AccumulateBank6WordToDA70

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a, a
    jr nz, .call_actor_lacks_status1_bits23_and4_bits01
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $000A
    call AccumulateBank6WordToDA70

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $00BE
    call AccumulateBank6WordToDA70
    ld bc, $00C5
    call AccumulateBank6WordToDA6E

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $000D
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp a, $01
    jr z, .call_fail_if_foe_hp_at_least150_percent_of
    and a, a
    jr nz, .call_fail_if_foe_hp_at_least150_percent_of
    ld bc, $004A
    call AccumulateBank6WordToDA70

.call_fail_if_foe_hp_at_least150_percent_of:
    farcall FailIfFoeHPAtLeast150PercentOfActor
    ld a, c
    cp a, $01
    jr z, .call_fail_if_any_foe_fully_resistant
    and a, a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $004F
    call AccumulateBank6WordToDA6E

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0012
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 4 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 80 FireSlash, 81 VacuSlash, 82 BoltSlash, 83 IceSlash. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_FireSlash:: ; heuristic: follows a terminator; C0
Func_0E2_4F30:: ; address name
    farcall AIFunc74D1AndFoeLacksStatus3And4
    ld a, c
    and a, a
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_check_foe_status7_bit2
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_check_foe_status7_bit2:
    farcall CheckFoeStatus7Bit2
    ld a, c
    cp a, $01
    jr z, .call_fail_if_foe_ai_damage_estimates_at_least
    and a, a
    jr nz, .call_fail_if_foe_ai_damage_estimates_at_least
    ld bc, $0003
    call AccumulateBank6WordToDA70

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a, a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $0008
    call AccumulateBank6WordToDA70

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a, a
    jr nz, .call_actor_lacks_status1_bits23_and4_bits01
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $0055
    call AccumulateBank6WordToDA6E

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $000D
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall CheckBattleKindAtLeast2OrLinkModeSet
    ld a, c
    and a, a
    jr nz, .call_foe_hp_check_reads_wrong_slot
    ld bc, $0066
    call AccumulateBank6WordToDA6E

.call_foe_hp_check_reads_wrong_slot:
    farcall FoeHPCheckReadsWrongSlot
    ld a, c
    and a, a
    jr nz, .call_actor_status4_check_reads_address
    ld bc, $0067
    call AccumulateBank6WordToDA6E

.call_actor_status4_check_reads_address:
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a, a
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $0005
    call AccumulateBank6WordToDA6E

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $0033
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 84 SlimeBlow. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_SlimeBlow:: ; heuristic: follows a terminator; C0
Func_0E2_4FE1:: ; address name
    farcall AIScore_SlimeBlow_Conditions
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E

AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates::
Jump_0E2_4FF0:: ; address name
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_check_foe_status7_bit2
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_check_foe_status7_bit2:
    farcall CheckFoeStatus7Bit2
    ld a, c
    cp a, $01
    jr z, .call_actor_lacks_status1_bits23_and4_bits01
    and a, a
    jr nz, .call_actor_lacks_status1_bits23_and4_bits01
    ld bc, $0003
    call AccumulateBank6WordToDA70

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $0053
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall CheckBattleKindAtLeast2OrLinkModeSet
    ld a, c
    and a, a
    jr nz, .call_foe_hp_check_reads_wrong_slot
    ld bc, $0066
    call AccumulateBank6WordToDA6E

.call_foe_hp_check_reads_wrong_slot:
    farcall FoeHPCheckReadsWrongSlot
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $0067
    call AccumulateBank6WordToDA6E
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a, a
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $0005
    call AccumulateBank6WordToDA6E

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $0033
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 85 DrakSlash. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_DrakSlash:: ; heuristic: follows a terminator; C0
Func_0E2_5068:: ; address name
    farcall AIScore_DrakSlash_Conditions
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 86 BeastCut. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_BeastCut:: ; heuristic: follows a terminator; C0
Func_0E2_507A:: ; address name
    farcall AIScore_BeastCut_Conditions
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 87 BirdBlow. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_BirdBlow:: ; heuristic: follows a terminator; C0
Func_0E2_508C:: ; address name
    farcall AIScore_BirdBlow_Conditions
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 88 BugBlow. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_BugBlow:: ; heuristic: follows a terminator; C0
Func_0E2_509E:: ; address name
    farcall AIScore_BugBlow_Conditions
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 89 Shears. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Shears:: ; heuristic: follows a terminator; C0
Func_0E2_50B0:: ; address name
    farcall AIScore_Shears_Conditions
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 90 DevilCut. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_DevilCut:: ; heuristic: follows a terminator; C0
Func_0E2_50C2:: ; address name
    farcall AIScore_DevilCut_Conditions
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 91 ZombieCut. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_ZombieCut:: ; heuristic: follows a terminator; C0
Func_0E2_50D4:: ; address name
    farcall AIScore_ZombieCut_Conditions
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 92 CleanCut. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_CleanCut:: ; heuristic: follows a terminator; C0
Func_0E2_50E6:: ; address name
    farcall AIScore_CleanCut_Conditions
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 93 AquaCut. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_AquaCut:: ; heuristic: follows a terminator; C0
Func_0E2_50F8:: ; address name
    farcall AIScore_AquaCut_Conditions
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 94 MetalCut. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_MetalCut:: ; heuristic: follows a terminator; C0
Func_0E2_510A:: ; address name
    farcall AIScore_MetalCut_Conditions
    ld a, c
    and a, a
    ret z
    ld bc, $0053
    call AccumulateBank6WordToDA6E
    jp AIScore_SlimeBlow_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 95 PoisonHit. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_PoisonHit:: ; heuristic: follows a terminator; C0
Func_0E2_511C:: ; address name
    farcall AIScore_PoisonHit_Conditions
    ld a, c
    and a, a
    ret z
    ld bc, $0054
    call AccumulateBank6WordToDA6E

AIScore_PoisonHit_CallActorLacksStatus1Bits23And4Bits01::
Jump_0E2_512B:: ; address name
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $0055
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall CheckBattleKindAtLeast2OrLinkModeSet
    ld a, c
    and a, a
    jr nz, .call_foe_hp_check_reads_wrong_slot
    ld bc, $0066
    call AccumulateBank6WordToDA6E

.call_foe_hp_check_reads_wrong_slot:
    farcall FoeHPCheckReadsWrongSlot
    ld a, c
    and a, a
    jr nz, .call_check_actor_slot0_to3_or_link_mode_set
    ld bc, $0067
    call AccumulateBank6WordToDA6E

.call_check_actor_slot0_to3_or_link_mode_set:
    farcall CheckActorSlot0To3OrLinkModeSet
    ld a, c
    and a, a
    jr nz, .call_actor_status4_check_reads_address
    ld bc, $0039
    call AccumulateBank6WordToDA70

.call_actor_status4_check_reads_address:
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a, a
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $0005
    call AccumulateBank6WordToDA6E

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0033
    call AccumulateBank6WordToDA70

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a, a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 96 Paralyze. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Paralyze:: ; heuristic: follows a terminator; C0
Func_0E2_51B7:: ; address name
    farcall AIScore_Paralyze_Conditions
    ld a, c
    and a, a
    ret z
    ld bc, $0054
    call AccumulateBank6WordToDA6E
    jp AIScore_PoisonHit_CallActorLacksStatus1Bits23And4Bits01

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 97 NapAttack. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_NapAttack:: ; heuristic: follows a terminator; C0
Func_0E2_51C9:: ; address name
    farcall AIScore_NapAttack_Conditions
    ld a, c
    and a, a
    ret z
    ld bc, $0054
    call AccumulateBank6WordToDA6E
    jp AIScore_PoisonHit_CallActorLacksStatus1Bits23And4Bits01

; table-B AI score: AIScore_SquallHit, then adds a penalty word when the follow-up check fails (E-0122)
; no direct call (reached through a table, a jump or a vector)
AIScoreB_SquallHit:: ; heuristic: follows a terminator; C0
Func_0E2_51DB:: ; address name
    call AIScore_SquallHit
    ld a, c
    and a, a
    ret z
    farcall FailIfFoeHurtAndHealerCanCast
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $00B4
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 98 SquallHit. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; 1 call site from 1 routine (e.g. AIScoreB_SquallHit)
AIScore_SquallHit::
Func_0E2_51F6:: ; address name
    farcall AIScore_SquallHit_Conditions
    ld a, c
    and a, a
    ret z
    call MaxNegativeScoreWhenAIFlagBit0
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $00C8
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall FailIfFoeHPAtMostFourFifthsAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_fail_if_foe_hurt_and_healer_can_cast
    ld bc, $0056
    call AccumulateBank6WordToDA6E

.call_fail_if_foe_hurt_and_healer_can_cast:
    farcall FailIfFoeHurtAndHealerCanCast
    ld a, c
    cp a, $01
    jr z, .call_actor_status4_check_reads_address
    and a, a
    jr nz, .call_actor_status4_check_reads_address
    ld bc, $00B4
    call AccumulateBank6WordToDA6E

.call_actor_status4_check_reads_address:
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a, a
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $0005
    call AccumulateBank6WordToDA6E

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, .done
    ld bc, $0033
    call AccumulateBank6WordToDA70

.done:
    ld c, $01
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 99 BiAttack, 100 QuadHits. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_BiAttack:: ; heuristic: follows a terminator; C0
Func_0E2_526D:: ; address name
    farcall AIScore_BiAttack_CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_actor_lacks_status1_bits23_and4_bits01
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $0005
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $00C8
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp a, $01
    jr z, .call_fail_if_foe_hp_at_most_four_fifths_ai
    and a, a
    jr nz, .call_fail_if_foe_hp_at_most_four_fifths_ai
    ld bc, $004A
    call AccumulateBank6WordToDA70

.call_fail_if_foe_hp_at_most_four_fifths_ai:
    farcall FailIfFoeHPAtMostFourFifthsAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_ai_score_bi_attack_carry_unless_battle
    ld bc, $0056
    call AccumulateBank6WordToDA6E

.call_ai_score_bi_attack_carry_unless_battle:
    farcall AIScore_BiAttack_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a, a
    jr nz, .call_actor_status4_check_reads_address
    ld bc, $0056
    call AccumulateBank6WordToDA6E

.call_actor_status4_check_reads_address:
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a, a
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $0005
    call AccumulateBank6WordToDA6E

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $0033
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 101 RainSlash. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_RainSlash:: ; heuristic: follows a terminator; C0
Func_0E2_530E:: ; address name
    farcall AIScore_RainSlash_Conditions
    ld a, c
    and a, a
    ret z
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $0005
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $00C3
    call AccumulateBank6WordToDA6E
    ld bc, $00CB
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp a, $01
    jr z, .call_actor_status4_check_reads_address
    and a, a
    jr nz, .call_actor_status4_check_reads_address
    ld bc, $004A
    call AccumulateBank6WordToDA70

.call_actor_status4_check_reads_address:
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a, a
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $0005
    call AccumulateBank6WordToDA6E

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $0033
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 102 MultiCut. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_MultiCut:: ; heuristic: follows a terminator; C0
Func_0E2_5385:: ; address name
    farcall AIScore_MultiCut_Conditions
    ld a, c
    and a, a
    ret z
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp a, $01
    jr z, AIScore_MultiCut_CallCheckLoneFoeHPNotBelowAIDamageEstimates
    and a, a
    jr nz, AIScore_MultiCut_CallCheckLoneFoeHPNotBelowAIDamageEstimates
    ld bc, $0012
    call AccumulateBank6WordToDA70

AIScore_MultiCut_CallCheckLoneFoeHPNotBelowAIDamageEstimates::
Jump_0E2_53A2:: ; address name
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_fail_if_foe_ai_damage_estimates_at_least
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_fail_if_foe_ai_damage_estimates_at_least:
    farcall FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a, a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $000A
    call AccumulateBank6WordToDA70

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a, a
    jr nz, .call_inverted_result_of_fail_if_foe_ai_damage
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_inverted_result_of_fail_if_foe_ai_damage:
    farcall InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $000D
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, .call_check_foe_status6_bit3
    ld bc, $0057
    call AccumulateBank6WordToDA6E

.call_check_foe_status6_bit3:
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $004A
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 103 GigaSlash. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_GigaSlash:: ; heuristic: follows a terminator; C0
Func_0E2_540A:: ; address name
    farcall AIFunc74D1AndFoeLacksStatus3And4
    ld a, c
    and a, a
    ret z
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, .skip
    ld bc, $0033
    call AccumulateBank6WordToDA70

.skip:
    jp AIScore_MultiCut_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 104 ChargeUp. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_ChargeUp:: ; heuristic: follows a terminator; C0
Func_0E2_5426:: ; address name
    farcall AIScore_ChargeUp_Conditions
    ld a, c
    and a, a
    ret z
    farcall PassIfFoeAverageDEFAtMostTwiceAllyATK
    ld a, c
    cp a, $01
    jr z, .call_set_c_to_zero
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $0058
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $00BA
    call AccumulateBank6WordToDA6E
    ld bc, $00BF
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 105 PsycheUp. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_PsycheUp:: ; heuristic: follows a terminator; C0
Func_0E2_545D:: ; address name
    farcall AIScore_PsycheUp_Conditions
    ld a, c
    and a, a
    ret z
    farcall FastestFoeAGLAbove31PercentOfActor
    ld a, c
    and a, a
    jr nz, .call_check_lone_foe_hp_not_below_ai_damage
    ld bc, $002D
    call AccumulateBank6WordToDA70

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_ally_average_agl_at_least_foes
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_ally_average_agl_at_least_foes:
    farcall AllyAverageAGLAtLeastFoes
    ld a, c
    cp a, $01
    jr z, .call_actor_lacks_status1_bits23_and4_bits01
    and a, a
    jr nz, .call_actor_lacks_status1_bits23_and4_bits01
    ld bc, $002C
    call AccumulateBank6WordToDA6E

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $000A
    call AccumulateBank6WordToDA70

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $00BA
    call AccumulateBank6WordToDA6E
    ld bc, $00BF
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 106 HighJump. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_HighJump:: ; heuristic: follows a terminator; C0
Func_0E2_54C4:: ; address name
    farcall AIScore_HighJump_Conditions
    ld a, c
    and a, a
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_pass_if_foe_average_def_at_most_twice
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_pass_if_foe_average_def_at_most_twice:
    farcall PassIfFoeAverageDEFAtMostTwiceAllyATK
    ld a, c
    cp a, $01
    jr z, .call_pass_if_twice_atk_above_lowest_foe_def
    and a, a
    jr nz, .call_pass_if_twice_atk_above_lowest_foe_def
    ld bc, $0058
    call AccumulateBank6WordToDA70

.call_pass_if_twice_atk_above_lowest_foe_def:
    farcall PassIfTwiceATKAboveLowestFoeDEF
    ld a, c
    cp a, $01
    jr z, .call_actor_lacks_status1_bits23_and4_bits01
    and a, a
    jr nz, .call_actor_lacks_status1_bits23_and4_bits01
    ld bc, $0059
    call AccumulateBank6WordToDA70

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $000A
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $0033
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 107 EvilSlash. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_EvilSlash:: ; heuristic: follows a terminator; C0
Func_0E2_5529:: ; address name
    farcall CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    farcall AnyFoeNotBlocked
    ld a, c
    and a, a
    jr nz, .call_any_foe_has_clear_status3
    ld bc, $005A
    call AccumulateBank6WordToDA6E

.call_any_foe_has_clear_status3:
    farcall AnyFoeHasClearStatus3
    ld a, c
    and a, a
    jr nz, .call_check_lone_foe_hp_not_below_ai_damage
    ld bc, $005B
    call AccumulateBank6WordToDA6E

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_pass_if_foe_average_def_at_most_twice
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_pass_if_foe_average_def_at_most_twice:
    farcall PassIfFoeAverageDEFAtMostTwiceAllyATK
    ld a, c
    cp a, $01
    jr z, .call_pass_if_twice_atk_above_lowest_foe_def
    and a, a
    jr nz, .call_pass_if_twice_atk_above_lowest_foe_def
    ld bc, $0058
    call AccumulateBank6WordToDA6E

.call_pass_if_twice_atk_above_lowest_foe_def:
    farcall PassIfTwiceATKAboveLowestFoeDEF
    ld a, c
    cp a, $01
    jr z, .call_actor_lacks_status1_bits23_and4_bits01
    and a, a
    jr nz, .call_actor_lacks_status1_bits23_and4_bits01
    ld bc, $0059
    call AccumulateBank6WordToDA6E

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $005C
    call AccumulateBank6WordToDA70

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $00BD
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall AIScore_EvilSlash_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a, a
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $00B0
    call AccumulateBank6WordToDA6E

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $0033
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 108 Massacre. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Massacre:: ; heuristic: follows a terminator; C0
Func_0E2_55CE:: ; address name
    farcall CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    farcall AtLeastTwoFoesPresent
    ld a, c
    and a, a
    jr nz, .call_check_lone_foe_hp_not_below_ai_damage
    ld bc, $0011
    call AccumulateBank6WordToDA70

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $00C4
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $0033
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 109 TwinSlash. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_TwinSlash:: ; heuristic: follows a terminator; C0
Func_0E2_561B:: ; address name
    farcall AIScore_TwinSlash_Conditions
    ld a, c
    and a, a
    ret z
    farcall AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr nz, .call_check_lone_foe_hp_not_below_ai_damage
    ld bc, $005E
    call AccumulateBank6WordToDA70

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_pass_if_foe_average_def_at_most_twice
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_pass_if_foe_average_def_at_most_twice:
    farcall PassIfFoeAverageDEFAtMostTwiceAllyATK
    ld a, c
    cp a, $01
    jr z, .call_pass_if_twice_atk_above_lowest_foe_def
    and a, a
    jr nz, .call_pass_if_twice_atk_above_lowest_foe_def
    ld bc, $005F
    call AccumulateBank6WordToDA70

.call_pass_if_twice_atk_above_lowest_foe_def:
    farcall PassIfTwiceATKAboveLowestFoeDEF
    ld a, c
    cp a, $01
    jr z, .call_actor_hp_is_not_one
    and a, a
    jr nz, .call_actor_hp_is_not_one
    ld bc, $005F
    call AccumulateBank6WordToDA70

.call_actor_hp_is_not_one:
    farcall ActorHPIsNotOne
    ld a, c
    and a, a
    jr nz, .call_actor_lacks_status1_bits23_and4_bits01
    ld bc, $0060
    call AccumulateBank6WordToDA70

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $005C
    call AccumulateBank6WordToDA70

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $00C7
    call AccumulateBank6WordToDA6E
    ld bc, $00D0
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall AllyCheckSide0FlagAndOtherSlots
    ld a, c
    and a, a
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $0062
    call AccumulateBank6WordToDA70

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $0033
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 110 Berserker. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Berserker:: ; heuristic: follows a terminator; C0
Func_0E2_56C6:: ; address name
    farcall AIAttackSkillUsable_779F
    ld a, c
    and a, a
    ret z
    call MaxNegativeScoreWhenAIFlagBit0
    ret z
    farcall AnyFoeNotBlocked
    ld a, c
    and a, a
    jr nz, .call_all_other_allies_have_status0_bit6
    ld bc, $005A
    call AccumulateBank6WordToDA6E

.call_all_other_allies_have_status0_bit6:
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a, a
    jr nz, .call_check_lone_foe_hp_not_below_ai_damage
    ld bc, $0017
    call AccumulateBank6WordToDA70

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_pass_if_foe_average_def_at_most_twice
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_pass_if_foe_average_def_at_most_twice:
    farcall PassIfFoeAverageDEFAtMostTwiceAllyATK
    ld a, c
    cp a, $01
    jr z, .call_pass_if_twice_atk_above_lowest_foe_def
    and a, a
    jr nz, .call_pass_if_twice_atk_above_lowest_foe_def
    ld bc, $005F
    call AccumulateBank6WordToDA70

.call_pass_if_twice_atk_above_lowest_foe_def:
    farcall PassIfTwiceATKAboveLowestFoeDEF
    ld a, c
    cp a, $01
    jr z, .call_actor_hp_is_not_one
    and a, a
    jr nz, .call_actor_hp_is_not_one
    ld bc, $005F
    call AccumulateBank6WordToDA70

.call_actor_hp_is_not_one:
    farcall ActorHPIsNotOne
    ld a, c
    and a, a
    jr nz, .call_actor_lacks_status1_bits23_and4_bits01
    ld bc, $0060
    call AccumulateBank6WordToDA70

.call_actor_lacks_status1_bits23_and4_bits01:
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $005C
    call AccumulateBank6WordToDA70

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $00C7
    call AccumulateBank6WordToDA6E
    ld bc, $00D0
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a, a
    jr nz, .call_ally_check_side0_flag_and_other_slots
    ld bc, $0063
    call AccumulateBank6WordToDA70

.call_ally_check_side0_flag_and_other_slots:
    farcall AllyCheckSide0FlagAndOtherSlots
    ld a, c
    and a, a
    jr nz, .call_ai_score_berserker_read_slot_ai_mode
    ld bc, $005F
    call AccumulateBank6WordToDA70

.call_ai_score_berserker_read_slot_ai_mode:
    farcall AIScore_Berserker_ReadSlotAIModeIndexed_Bank05_4024
    ld a, c
    cp a, $01
    jr z, .call_actor_lacks_status2_bit1_and4_bits01
    and a, a
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $0064
    call AccumulateBank6WordToDA6E

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $0033
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 111 Ramming. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
AIScore_Ramming:: ; heuristic: follows a terminator; C0
Func_0E2_57A9:: ; address name
    farcall AIFunc779FAnd43F2AndActorHPNotOne
    ld a, c
    and a, a
    ret z
    farcall AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr nz, .call_all_other_allies_have_status0_bit6
    ld bc, $005E
    call AccumulateBank6WordToDA70

.call_all_other_allies_have_status0_bit6:
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a, a
    jr nz, .call_ai_score_ramming_read_slot_ai_mode
    ld bc, $0017
    call AccumulateBank6WordToDA70

.call_ai_score_ramming_read_slot_ai_mode:
    farcall AIScore_Ramming_ReadSlotAIModeIndexed_Bank05_4024
    ld a, c
    cp a, $01
    jr z, AIScore_Ramming_CallCheckLoneFoeHPNotBelowAIDamageEstimates
    and a, a
    jr nz, AIScore_Ramming_CallCheckLoneFoeHPNotBelowAIDamageEstimates
    ld bc, $0064
    call AccumulateBank6WordToDA6E

AIScore_Ramming_CallCheckLoneFoeHPNotBelowAIDamageEstimates::
Jump_0E2_57E6:: ; address name
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_pass_if_foes_average_resistance_at
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_pass_if_foes_average_resistance_at:
    farcall PassIfFoesAverageResistanceAtLeast2
    ld a, c
    and a, a
    jr nz, .read_battle_actor
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.read_battle_actor:
    ld a, [wBattleActor]
    call AIScore_Ramming_HPBandOfSlotTemp0
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $005C
    call AccumulateBank6WordToDA70

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $00C7
    call AccumulateBank6WordToDA6E
    ld bc, $00D0
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    farcall AllyCheckSide0FlagAndOtherSlots
    ld a, c
    and a, a
    jr nz, .call_actor_lacks_status2_bit1_and4_bits01
    ld bc, $005F
    call AccumulateBank6WordToDA70

.call_actor_lacks_status2_bit1_and4_bits01:
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $0033
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 112 Kamikaze. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
AIScore_Kamikaze:: ; heuristic: follows a terminator; C0
Func_0E2_5856:: ; address name
    farcall AIScore_Kamikaze_AIFunc779FAnd43F2AndActorHPNotOne
    ld a, c
    and a, a
    ret z
    farcall AIScore_Kamikaze_ReadSlotAIModeIndexed_Bank05_4024
    ld a, c
    cp a, $01
    jr z, .skip
    and a, a
    jr nz, .skip
    ld bc, $0064
    call AccumulateBank6WordToDA6E

.skip:
    jp AIScore_Ramming_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 113 SleepAir. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_SleepAir:: ; heuristic: follows a terminator; C0
Func_0E2_5876:: ; address name
    farcall AIScore_SleepAir_Conditions
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, AIScore_SleepAir_CallWeighWD044RuleBit3
    ld bc, $00BC
    call AccumulateBank6WordToDA70

AIScore_SleepAir_CallWeighWD044RuleBit3::
Jump_0E2_588F:: ; address name
    call WeighWD044RuleBit3

AIScore_SleepAir_CallFewerThanTwoFoesPresent::
Jump_0E2_5892:: ; address name
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a, a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AccumulateBank6WordToDA70

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a, a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 114 PalsyAir. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_PalsyAir:: ; heuristic: follows a terminator; C0
Func_0E2_58DF:: ; address name
    farcall AIScore_PalsyAir_Conditions
    ld a, c
    and a, a
    ret z
    jr AIScore_SleepAir_CallWeighWD044RuleBit3

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 115 PoisonGas. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_PoisonGas:: ; heuristic: follows a terminator; C0
Func_0E2_58EA:: ; address name
    farcall AIScore_PoisonGas_Conditions
    ld a, c
    and a, a
    ret z
    jr AIScore_SleepAir_CallWeighWD044RuleBit3

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 116 PoisonAir. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_PoisonAir:: ; heuristic: follows a terminator; C0
Func_0E2_58F5:: ; address name
    farcall AIScore_PoisonAir_Conditions
    ld a, c
    and a, a
    ret z
    jr AIScore_SleepAir_CallWeighWD044RuleBit3

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 117 Curse. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Curse:: ; heuristic: follows a terminator; C0
Func_0E2_5900:: ; address name
    farcall AIScore_Curse_Conditions
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00BD
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    jp AIScore_SleepAir_CallFewerThanTwoFoesPresent

; AI scoring routine for 2 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 118 OddDance, 119 RobDance. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_OddDance:: ; heuristic: follows a terminator; C0
Func_0E2_591F:: ; address name
    farcall AIScore_OddDance_Conditions
    ld a, c
    and a, a
    ret z
    ld bc, $0009
    call AccumulateBank6WordToDA6E
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit2
    ld bc, $00C2
    call AccumulateBank6WordToDA70
    ld bc, $00D2
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit2:
    call WeighWD044RuleBit2
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a, a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 120 PaniDance. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_PaniDance:: ; heuristic: follows a terminator; C0
Func_0E2_5970:: ; address name
    farcall AIScore_PaniDance_Conditions
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit2
    ld bc, $00C2
    call AccumulateBank6WordToDA70
    ld bc, $00CA
    call AccumulateBank6WordToDA6E
    ld bc, $00D2
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit2:
    call WeighWD044RuleBit2
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a, a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AccumulateBank6WordToDA70

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a, a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 121 K.O.Dance. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_KODance:: ; heuristic: follows a terminator; C0
Func_0E2_59E5:: ; address name
    farcall AIScore_KODance_Conditions
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit2
    ld bc, $00CD
    call AccumulateBank6WordToDA6E
    ld bc, $00CF
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit2:
    call WeighWD044RuleBit2
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, .call_ai_gate_foe_wda74_bits45
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_ai_gate_foe_wda74_bits45:
    farcall AIGateFoeWDA74Bits45
    ld a, c
    cp a, $01
    jr z, .call_fail_if_any_foe_fully_resistant
    and a, a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $00B5
    call AccumulateBank6WordToDA6E

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a, a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AccumulateBank6WordToDA70

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a, a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.return:
    ret

; table-B AI score: AIScore_LureDance, then Func_0E2_67F9 when usable (E-0122)
; no direct call (reached through a table, a jump or a vector)
AIScoreB_LureDance:: ; heuristic: follows a terminator; C0
Func_0E2_5A68:: ; address name
    call AIScore_LureDance
    ld a, c
    and a, a
    ret z
    call AIAddScoresFor5ECEAnd5FC7
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 122 LureDance. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; 1 call site from 1 routine (e.g. AIScoreB_LureDance)
AIScore_LureDance::
Func_0E2_5A72:: ; address name
    farcall AIScore_LureDance_Conditions
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit2
    ld bc, $00C2
    call AccumulateBank6WordToDA70
    ld bc, $00D2
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit2:
    call WeighWD044RuleBit2
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a, a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AccumulateBank6WordToDA70

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a, a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp a, $01
    jr z, .call_ai_add_scores_for5_ece_and5_fc7
    and a, a
    jr nz, .call_ai_add_scores_for5_ece_and5_fc7
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_ai_add_scores_for5_ece_and5_fc7:
    call AIAddScoresFor5ECEAnd5FC7
    ld c, $01
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 123 LifeDance. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_LifeDance:: ; heuristic: follows a terminator; C0
Func_0E2_5AE6:: ; address name
    farcall AIScore_LifeDance_Conditions
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit2
    ld bc, $00BC
    call AccumulateBank6WordToDA6E
    ld bc, $00C4
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit2:
    call WeighWD044RuleBit2
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a, a
    jr nz, .call_pass_if_side0_flag_or_ally_slot_empty
    ld bc, $0029
    call AccumulateBank6WordToDA6E

.call_pass_if_side0_flag_or_ally_slot_empty:
    farcall PassIfSide0FlagOrAllySlotEmpty
    ld a, c
    and a, a
    jr nz, .call_ai_gate_compare_ally_stat_averages
    ld bc, $0029
    call AccumulateBank6WordToDA6E

.call_ai_gate_compare_ally_stat_averages:
    farcall AIGateCompareAllyStatAverages
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $002E
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 124 Hustle. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
AIScore_Hustle:: ; heuristic: follows a terminator; C0
Func_0E2_5B3D:: ; address name
    farcall AIScore_Hustle_Conditions
    ld a, c
    and a, a
    ret z
    ld a, [wBattleActor]
    call ForEachPresentSlotOfSideRun66DC
    farcall AnyFoeLacksStatus0MaskCC
    ld a, c
    and a, a
    jr nz, .call_any_foe_has_clear_status3
    ld bc, $001A
    call AccumulateBank6WordToDA6E

.call_any_foe_has_clear_status3:
    farcall AnyFoeHasClearStatus3
    ld a, c
    and a, a
    jr nz, .call_any_ally_hp_at_most_three_quarters
    ld bc, $001A
    call AccumulateBank6WordToDA6E

.call_any_ally_hp_at_most_three_quarters:
    farcall AnyAllyHPAtMostThreeQuarters
    ld a, c
    and a, a
    jr nz, .call_actor_hp_is_not_one
    ld bc, $001B
    call AccumulateBank6WordToDA70

.call_actor_hp_is_not_one:
    farcall ActorHPIsNotOne
    ld a, c
    and a, a
    jr nz, .call_fewer_than_two_allies_at_hp1
    ld bc, $0023
    call AccumulateBank6WordToDA6E

.call_fewer_than_two_allies_at_hp1:
    farcall FewerThanTwoAlliesAtHP1
    ld a, c
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $0023
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit2
    ld bc, $0024
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit2:
    call WeighWD044RuleBit2
    farcall FailIfTwoAlliesBelowHalfHP
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0069
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 125 SideStep. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_SideStep:: ; heuristic: follows a terminator; C0
Func_0E2_5BC4:: ; address name
    farcall AIScore_SideStep_Conditions
    ld a, c
    and a, a
    ret z
    farcall AnyFoeLacksStatus5Bits01And1Bit1
    ld a, c
    and a, a
    jr nz, .call_check_lone_foe_hp_not_below_ai_damage
    ld bc, $006C
    call AccumulateBank6WordToDA70

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_pass_if_foe_average_atk_at_most_twice
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_pass_if_foe_average_atk_at_most_twice:
    farcall PassIfFoeAverageATKAtMostTwiceAllyDEF
    ld a, c
    cp a, $01
    jr z, .call_set_c_to_zero
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $006D
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit2
    ld bc, $00BE
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit2:
    call WeighWD044RuleBit2
    farcall CompareFoeAverageATKWithAllyDEF
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $0032
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 126 SandStorm. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_SandStorm:: ; heuristic: follows a terminator; C0
Func_0E2_5C25:: ; address name
    farcall AIScore_SandStorm_Conditions
    ld a, c
    and a, a
    ret z

AIScore_SandStorm_CallCheckLoneFoeHPNotBelowAIDamageEstimates::
Jump_0E2_5C2E:: ; address name
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_pass_if_foe_average_atk_at_most_twice
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_pass_if_foe_average_atk_at_most_twice:
    farcall PassIfFoeAverageATKAtMostTwiceAllyDEF
    ld a, c
    cp a, $01
    jr z, .call_set_c_to_zero
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $006D
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00BA
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, .call_compare_foe_average_atk_with_ally_def
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_compare_foe_average_atk_with_ally_def:
    farcall CompareFoeAverageATKWithAllyDEF
    ld a, c
    and a, a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $0032
    call AccumulateBank6WordToDA6E

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a, a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AccumulateBank6WordToDA70

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a, a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 127 Radiant. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Radiant:: ; heuristic: follows a terminator; C0
Func_0E2_5CC2:: ; address name
    farcall AIScore_Radiant_Conditions
    ld a, c
    and a, a
    ret z
    jp AIScore_SandStorm_CallCheckLoneFoeHPNotBelowAIDamageEstimates

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 128 EerieLite. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_EerieLite:: ; heuristic: follows a terminator; C0
Func_0E2_5CCE:: ; address name
    farcall AIScore_EerieLite_Conditions
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00CC
    call AccumulateBank6WordToDA6E
    ld bc, $00D1
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, .call_fail_if_any_foe_fully_resistant
    ld bc, $0015
    call AccumulateBank6WordToDA6E

.call_fail_if_any_foe_fully_resistant:
    farcall FailIfAnyFoeFullyResistant
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_ai_side
    and a, a
    jr nz, .call_resistance_average_gate_for_ai_side
    ld bc, $0012
    call AccumulateBank6WordToDA70

.call_resistance_average_gate_for_ai_side:
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a, a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 129 Surge. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Surge:: ; heuristic: follows a terminator; C0
Func_0E2_5D3D:: ; address name
    farcall AIScore_Surge_Conditions
    ld a, c
    and a, a
    ret z
    ld bc, $006F
    call AccumulateBank6WordToDA6E
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit4
    ld bc, $00CA
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit4:
    call WeighWD044RuleBit4
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 130 UltraDown. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_UltraDown:: ; heuristic: follows a terminator; C0
Func_0E2_5D60:: ; address name
    farcall AIScore_UltraDown_Conditions
    ld a, c
    and a, a
    ret z
    ld bc, $006F
    call AccumulateBank6WordToDA6E
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00CC
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 131 DeMagic. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_DeMagic:: ; heuristic: follows a terminator; C0
Func_0E2_5D83:: ; address name
    farcall AIScore_DeMagic_Conditions
    ld a, c
    and a, a
    ret z
    ld bc, $0071
    call AccumulateBank6WordToDA6E
    farcall AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $0070
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00C9
    call AccumulateBank6WordToDA70
    ld bc, $00CB
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 132 ThickFog. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_ThickFog:: ; heuristic: follows a terminator; C0
Func_0E2_5DBC:: ; address name
    farcall AIScore_ThickFog_Conditions
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00C9
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall AIModeAtLeast2AndFoeLacks6D1A
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0072
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 4 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 133 TatsuCall, 134 DiagoCall, 135 SamsiCall, 136 BazooCall. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_TatsuCall:: ; heuristic: follows a terminator; C0
Func_0E2_5DED:: ; address name
    farcall AIScore_TatsuCall_Conditions
    ld a, c
    and a, a
    ret z
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a, a
    jr nz, .call_check_lone_foe_hp_not_below_ai_damage
    ld bc, $0073
    call AccumulateBank6WordToDA6E

.call_check_lone_foe_hp_not_below_ai_damage:
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $0074
    call AccumulateBank6WordToDA6E
    ld bc, $00BB
    call AccumulateBank6WordToDA6E
    ld bc, $00C7
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $0075
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 137 SuckAir. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_SuckAir:: ; heuristic: follows a terminator; C0
Func_0E2_5E46:: ; address name
    farcall AIScore_SuckAir_Conditions
    ld a, c
    and a, a
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit3
    ld bc, $0076
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit3:
    call WeighWD044RuleBit3
    farcall AnyAllyLacksStatus2Bit2_5D31
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $0077
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 138 Focus. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Focus:: ; heuristic: follows a terminator; C0
Func_0E2_5E83:: ; address name
    farcall AIScore_Focus_Conditions
    ld a, c
    and a, a
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00C2
    call AccumulateBank6WordToDA6E
    ld bc, $00D2
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    ret

; table-B AI score: AIScore_LushLicks, then Func_0E2_67F9 when usable (E-0122)
; no direct call (reached through a table, a jump or a vector)
AIScoreB_LushLicks:: ; heuristic: follows a terminator; C0
Func_0E2_5EB6:: ; address name
    call AIScore_LushLicks
    ld a, c
    and a, a
    ret z
    call AIAddScoresFor5ECEAnd5FC7
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 139 LushLicks. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; 1 call site from 1 routine (e.g. AIScoreB_LushLicks)
AIScore_LushLicks::
Func_0E2_5EC0:: ; address name
    farcall AILickSkillUsable_7AD8
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $0078
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a, a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp a, $01
    jr z, .call_ai_add_scores_for5_ece_and5_fc7
    and a, a
    jr nz, .call_ai_add_scores_for5_ece_and5_fc7
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_ai_add_scores_for5_ece_and5_fc7:
    call AIAddScoresFor5ECEAnd5FC7
    ld c, $01
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 140 SickLick. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_SickLick:: ; heuristic: follows a terminator; C0
Func_0E2_5F0A:: ; address name
    farcall AIStatusLickUsable
    ld a, c
    and a, a
    ret z
    farcall AnyFoeHasDEFAtLeast2
    ld a, c
    and a, a
    jr nz, .call_pass_if_foe_average_def_at_most_twice
    ld bc, $0079
    call AccumulateBank6WordToDA70

.call_pass_if_foe_average_def_at_most_twice:
    farcall PassIfFoeAverageDEFAtMostTwiceAllyATK
    ld a, c
    cp a, $01
    jr z, .call_pass_if_twice_atk_above_lowest_foe_def
    and a, a
    jr nz, .call_pass_if_twice_atk_above_lowest_foe_def
    ld bc, $002C
    call AccumulateBank6WordToDA6E

.call_pass_if_twice_atk_above_lowest_foe_def:
    farcall PassIfTwiceATKAboveLowestFoeDEF
    ld a, c
    cp a, $01
    jr z, .call_set_c_to_zero
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $002C
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $0078
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a, a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp a, $01
    jr z, .call_ai_add_scores_for5_ece_and5_fc7
    and a, a
    jr nz, .call_ai_add_scores_for5_ece_and5_fc7
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_ai_add_scores_for5_ece_and5_fc7:
    call AIAddScoresFor5ECEAnd5FC7
    ret

; table-B AI score: AIScore_LegSweep, then Func_0E2_67F9 when usable (E-0122)
; no direct call (reached through a table, a jump or a vector)
AIScoreB_LegSweep:: ; heuristic: follows a terminator; C0
Func_0E2_5F8A:: ; address name
    call AIScore_LegSweep
    ld a, c
    and a, a
    ret z
    call AIAddScoresFor5ECEAnd5FC7
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 141 LegSweep, 142 BigTrip. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; 1 call site from 1 routine (e.g. AIScoreB_LegSweep)
AIScore_LegSweep::
Func_0E2_5F94:: ; address name
    farcall AIScore_LegSweep_Conditions
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $007B
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a, a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp a, $01
    jr z, .call_ai_add_scores_for5_ece_and5_fc7
    and a, a
    jr nz, .call_ai_add_scores_for5_ece_and5_fc7
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_ai_add_scores_for5_ece_and5_fc7:
    call AIAddScoresFor5ECEAnd5FC7
    ld c, $01
    ret

; table-B AI score: AIScore_Ahhh, then Func_0E2_67F9 when usable (E-0122)
; no direct call (reached through a table, a jump or a vector)
AIScoreB_Ahhh:: ; heuristic: follows a terminator; C0
Func_0E2_5FDE:: ; address name
    call AIScore_Ahhh
    ld a, c
    and a, a
    ret z
    call AIAddScoresFor5ECEAnd5FC7
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 143 Ahhh, 144 WarCry. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; 1 call site from 1 routine (e.g. AIScoreB_Ahhh)
AIScore_Ahhh::
Func_0E2_5FE8:: ; address name
    farcall AILickSkillUsable_7AD8
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00C0
    call AccumulateBank6WordToDA6E
    ld bc, $00C3
    call AccumulateBank6WordToDA70
    ld bc, $00CE
    call AccumulateBank6WordToDA70
    ld bc, $00D3
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a, a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp a, $01
    jr z, .call_ai_add_scores_for5_ece_and5_fc7
    and a, a
    jr nz, .call_ai_add_scores_for5_ece_and5_fc7
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_ai_add_scores_for5_ece_and5_fc7:
    call AIAddScoresFor5ECEAnd5FC7
    ld c, $01
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 145 Geyser. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Geyser:: ; heuristic: follows a terminator; C0
Func_0E2_6044:: ; address name
    farcall AIScore_Geyser_Conditions
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $007D
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall ResistanceAverageGateForAISide
    ld a, c
    cp a, $01
    jr z, .call_resistance_average_gate_for_foe_ai_mode3
    and a, a
    jr nz, .call_resistance_average_gate_for_foe_ai_mode3
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.call_resistance_average_gate_for_foe_ai_mode3:
    farcall ResistanceAverageGateForFoeAIMode3
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0009
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 146 DanceShut. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_DanceShut:: ; heuristic: follows a terminator; C0
Func_0E2_6089:: ; address name
    farcall AIScore_DanceShut_Conditions
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit2
    ld bc, $007E
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit2:
    call WeighWD044RuleBit2
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 147 MouthShut. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_MouthShut:: ; heuristic: follows a terminator; C0
Func_0E2_60A6:: ; address name
    farcall AIScore_MouthShut_Conditions
    ld a, c
    and a, a
    ret z
    farcall FailIfFoeKnowsSkills42To47
    ld a, c
    cp a, $01
    jr z, .call_set_c_to_zero
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $007F
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit3
    ld bc, $0080
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit3:
    call WeighWD044RuleBit3
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 148 StrongD. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
AIScore_StrongD:: ; heuristic: follows a terminator; C0
Func_0E2_60D7:: ; address name
    farcall AIScore_StrongD_Conditions
    ld a, c
    and a, a
    ret z
    call AIScoreGuardSkill_67CF
    ret z
    ld a, [wBattleActor]
    call AIScore_StrongD_HPBandOfSlotTemp0
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_fail_if_foe_skill3_d_threatens_actor_hp
    ld bc, $00C1
    call AccumulateBank6WordToDA70

.call_fail_if_foe_skill3_d_threatens_actor_hp:
    farcall FailIfFoeSkill3DThreatensActorHP
    ld a, c
    cp a, $01
    jr z, .call_weigh_wd044_rule_bit4
    and a, a
    jr nz, .call_weigh_wd044_rule_bit4
    ld bc, $0000
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit4:
    call WeighWD044RuleBit4
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 149 Dodge. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Dodge:: ; heuristic: follows a terminator; C0
Func_0E2_6112:: ; address name
    farcall AIScore_Dodge_Conditions
    ld a, c
    and a, a
    ret z
    call AIScoreGuardSkill_67CF
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $0088
    call AccumulateBank6WordToDA6E
    ld bc, $00C1
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 150 BladeD. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_BladeD:: ; heuristic: follows a terminator; C0
Func_0E2_6139:: ; address name
    farcall AIGuardSkillUsable_7C45
    ld a, c
    and a, a
    ret z
    call AIScoreGuardSkill_67CF
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit4
    ld bc, $008A
    call AccumulateBank6WordToDA6E
    ld bc, $00C1
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit4:
    call WeighWD044RuleBit4
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 151 Cover, 152 Guardian. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
AIScore_Cover:: ; heuristic: follows a terminator; C0
Func_0E2_6160:: ; address name
    farcall AIScore_Cover_Conditions
    ld a, c
    and a, a
    ret z
    call AIScoreGuardSkill_67CF
    ret z
    ld a, [wBattleActor]
    call AIScore_Cover_CarryUnlessBattleSlotOutSlotEmpty
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00CD
    call AccumulateBank6WordToDA70
    ld bc, $00D1
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 153 TailWind. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_TailWind:: ; heuristic: follows a terminator; C0
Func_0E2_618D:: ; address name
    farcall AIScore_TailWind_Conditions
    ld a, c
    and a, a
    ret z
    call AIScore_TailWind_AccumulateBank6WordToDA70
    ret z

AIScore_TailWind_CallFailIfFoeKnowsSkills42To47::
Jump_0E2_619A:: ; address name
    farcall FailIfFoeKnowsSkills42To47
    ld a, c
    cp a, $01
    jr z, .call_set_c_to_zero
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $003A
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $008C
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 154 StormWind. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_StormWind:: ; heuristic: follows a terminator; C0
Func_0E2_61C2:: ; address name
    farcall AIScore_StormWind_Conditions
    ld a, c
    and a, a
    ret z
    jr AIScore_TailWind_CallFailIfFoeKnowsSkills42To47

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 155 AquaWall. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
AIScore_AquaWall:: ; heuristic: follows a terminator; C0
Func_0E2_61CD:: ; address name
    farcall AIScore_AquaWall_Conditions
    ld a, c
    and a, a
    ret z
    ld a, [wBattleActor]
    call AIScore_AquaWall_HPBandOfSlotTemp0
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 156 SealPray. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_SealPray:: ; heuristic: follows a terminator; C0
Func_0E2_61E0:: ; address name
    farcall AIScore_SealPray_ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    ret z
    farcall AIScore_SealPray_ReadQueuedActionId
    ld a, c
    and a, a
    jr nz, .call_fail_if_foe_knows_skills42_to47
    ld bc, $008D
    call AccumulateBank6WordToDA70

.call_fail_if_foe_knows_skills42_to47:
    farcall FailIfFoeKnowsSkills42To47
    ld a, c
    cp a, $01
    jr z, .call_set_c_to_zero
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $008E
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_fail_if_foe_skill3_d_threatens_actor_hp
    ld bc, $00CB
    call AccumulateBank6WordToDA6E

.call_fail_if_foe_skill3_d_threatens_actor_hp:
    farcall FailIfFoeSkill3DThreatensActorHP
    ld a, c
    cp a, $01
    jr z, .call_weigh_wd044_rule_bit5
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $008F
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall AIModeAtLeast2AndFoeLacks6D1A
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0090
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 157 SuckAll. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
AIScore_SuckAll:: ; heuristic: follows a terminator; C0
Func_0E2_6249:: ; address name
    farcall AIScore_SuckAll_Conditions
    ld a, c
    and a, a
    ret z
    call AIScoreGuardSkill_67CF
    ret z
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a, a
    jr nz, .call_any_ally_hp_at_most_three_quarters
    ld bc, $0091
    call AccumulateBank6WordToDA6E

.call_any_ally_hp_at_most_three_quarters:
    farcall AnyAllyHPAtMostThreeQuarters
    ld a, c
    and a, a
    jr nz, .read_battle_actor
    ld bc, $0092
    call AccumulateBank6WordToDA70

.read_battle_actor:
    ld a, [wBattleActor]
    call AIScore_SuckAll_CarryUnlessBattleSlotOutSlotEmpty
    farcall FailIfFoeKnowsSkills42To47
    ld a, c
    cp a, $01
    jr z, .call_weigh_wd044_rule_bit3
    and a, a
    jr nz, .call_weigh_wd044_rule_bit3
    ld bc, $008E
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit3:
    call WeighWD044RuleBit3
    farcall AnyAllyLacksStatus2Bit2
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $0097
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 158 Imitate. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Imitate:: ; heuristic: follows a terminator; C0
Func_0E2_62A4:: ; address name
    farcall AIScore_Imitate_Conditions
    ld a, c
    and a, a
    ret z
    call AIScoreGuardSkill_67CF
    ret z
    farcall CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr nz, .call_fail_if_foe_knows_skills42_to47
    ld bc, $0007
    call AccumulateBank6WordToDA70

.call_fail_if_foe_knows_skills42_to47:
    farcall FailIfFoeKnowsSkills42To47
    ld a, c
    cp a, $01
    jr z, .call_set_c_to_zero
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $0098
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit5
    ld bc, $00BB
    call AccumulateBank6WordToDA70
    ld bc, $00C6
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit5:
    call WeighWD044RuleBit5
    farcall AIModeAtLeast2AndFoeLacks6D1A
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $009A
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 159 Meditate. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
AIScore_Meditate:: ; heuristic: follows a terminator; C0
Func_0E2_6303:: ; address name
    farcall AIScore_Meditate_Conditions
    ld a, c
    and a, a
    ret z
    ld a, [wBattleActor]
    call AIScore_Meditate_HPBandOfSlotTemp0
    farcall ActorHPIsNotOne
    ld a, c
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $00A1
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit4
    ld bc, $00C2
    call AccumulateBank6WordToDA6E
    ld bc, $00D2
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit4:
    call WeighWD044RuleBit4
    farcall FailIfTwoAlliesBelowHalfHP
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0069
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 160 LifeSong. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_LifeSong:: ; heuristic: follows a terminator; C0
Func_0E2_6350:: ; address name
    farcall AIScore_LifeSong_Conditions
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit4
    ld bc, $00CC
    call AccumulateBank6WordToDA70
    ld bc, $00D3
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit4:
    call WeighWD044RuleBit4
    farcall AIGateCompareAllyStatAverages
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $002E
    call AccumulateBank6WordToDA70

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 161 LoveRain. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
AIScore_LoveRain:: ; heuristic: follows a terminator; C0
Func_0E2_6387:: ; address name
    farcall AIScore_LoveRain_Conditions
    ld a, c
    and a, a
    ret z
    farcall AnyAllyHPAtMostThreeQuarters
    ld a, c
    and a, a
    jr nz, .read_battle_actor
    ld bc, $001B
    call AccumulateBank6WordToDA70

.read_battle_actor:
    ld a, [wBattleActor]
    call ForEachPresentSlotOfSideRun66DC
    farcall ActorHPIsNotOne
    ld a, c
    and a, a
    jr nz, .call_fewer_than_two_allies_at_hp1
    ld bc, $00A3
    call AccumulateBank6WordToDA6E

.call_fewer_than_two_allies_at_hp1:
    farcall FewerThanTwoAlliesAtHP1
    ld a, c
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $00A4
    call AccumulateBank6WordToDA6E

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit4
    ld bc, $00CC
    call AccumulateBank6WordToDA70
    ld bc, $00CF
    call AccumulateBank6WordToDA6E
    ld bc, $00D3
    call AccumulateBank6WordToDA70

.call_weigh_wd044_rule_bit4:
    call WeighWD044RuleBit4
    farcall FailIfTwoAlliesBelowHalfHP
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0069
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 8 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 162 Whistle, 163 Pheromone, 164 StepGuard, 165 Outside, 166 Informer, 167 Errand, 168 EagleEye, 169 MapMagic. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Whistle:: ; heuristic: follows a terminator; C0
Func_0E2_63FA:: ; address name
    farcall AINeverUsableResetAISkillScore
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 170 Ahhh. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Ahhh_6401:: ; heuristic: follows a terminator; C0
Func_0E2_6401:: ; address name
    farcall AIStatusLickUsable
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_weigh_wd044_rule_bit1
    ld bc, $00A5
    call AccumulateBank6WordToDA6E

.call_weigh_wd044_rule_bit1:
    call WeighWD044RuleBit1
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 171 ZoneOut. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_ZoneOut:: ; heuristic: follows a terminator; C0
Func_0E2_641E:: ; address name
    farcall AINeverUsableResetAISkillScore
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 172 Guard. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Guard:: ; heuristic: follows a terminator; C0
Func_0E2_6425:: ; address name
    call MaxNegativeScoreWhenAIFlagBit0
    ret z
    farcall AIScore_Guard_Conditions
    ld a, c
    and a, a
    ret z
    farcall AnyFoeLacksStatus5Bits01And1Bit1
    ld a, c
    and a, a
    jr nz, .call_all_other_allies_have_status0_bit6
    ld bc, $00A6
    call AccumulateBank6WordToDA70

.call_all_other_allies_have_status0_bit6:
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a, a
    jr nz, .call_actor_hp_is_not_one
    ld bc, $00A7
    call AccumulateBank6WordToDA70

.call_actor_hp_is_not_one:
    farcall ActorHPIsNotOne
    ld a, c
    and a, a
    jr nz, .call_set_c_to_zero
    ld bc, $00A8
    call AccumulateBank6WordToDA70

.call_set_c_to_zero:
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $00A9
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 173 PanicAll. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_PanicAll_6473:: ; heuristic: follows a terminator; C0
Func_0E2_6473:: ; address name
    farcall AIPanicAllUsable
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $0037
    call AccumulateBank6WordToDA6E

.return:
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 174 Ironize. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Ironize_648D:: ; heuristic: follows a terminator; C0
Func_0E2_648D:: ; address name
    farcall AIIronizeUsable
    ld a, c
    and a, a
    ret z
    call AIScoreGuardSkill_67CF
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, .call_ai_mode_at_least2_and_foe_lacks6_d1_a
    ld bc, $0038
    call AccumulateBank6WordToDA6E

.call_ai_mode_at_least2_and_foe_lacks6_d1_a:
    farcall AIModeAtLeast2AndFoeLacks6D1A
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $0039
    call AccumulateBank6WordToDA6E

.return:
    ret
    db $C9, $C9, $CD, $D4, $3E, $FA, $E7, $C5, $CB, $7F, $CC, $40, $65, $C9, $C9

; word = ReadBank6TableWord; if its low byte is $FF the value is 5000, which is added to wDA6E; a positive word is added to wDA6E; a negative word's magnitude is added to wDA70
; 304 call sites from 118 routines (e.g. AIScore_Skill00, AIScore_StrongD_HPBandOfSlotTemp0, AIScore_Blaze, AIAddScoresFor55BEAnd5731, ...)
; points at: wAISkillScore, wAISkillScore2
AccumulateBank6WordToDA6E::
Func_0E2_64CE:: ; address name
    call ReadBank6TableWord
    cp a, $FF
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

; the mirror of AccumulateBank6WordToDA6E: $FF (5000) and positive words go to wDA70, negative words' magnitude goes to wDA6E
; 223 call sites from 89 routines (e.g. AIScore_Skill00, AIScore_StrongD_HPBandOfSlotTemp0, AIScore_Blaze, AIAddScoresFor55BEAnd5731, ...)
; points at: wAISkillScore2, wAISkillScore
AccumulateBank6WordToDA70::
Func_0E2_64F5:: ; address name
    call ReadBank6TableWord
    cp a, $FF
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
; 4 call sites from 2 routines (e.g. AccumulateBank6WordToDA70, AccumulateBank6WordToDA6E)
AddBCToWordAtHL::
Func_0E2_651C:: ; address name
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
    db $E5, $2A, $66, $6F, $7D, $91, $6F, $7C, $98, $67, $CB, $7C, $28, $03, $21, $00
    db $00, $44, $4D, $E1, $71, $23, $70, $C9, $AF, $21, $6E, $DA, $22, $22, $3E, $FF
    db $22, $22, $C9

; BC = the 16-bit word at ROM bank 6, $4001 + $36 * BC + 2 * wD2C7 (rows of 27 words); A = its low byte; clobbers HL, E
; 2 call sites from 2 routines (e.g. AccumulateBank6WordToDA70, AccumulateBank6WordToDA6E)
; reads: wPersonalityIndex
; writes: wDataBank
ReadBank6TableWord::
Func_0E2_654B:: ; address name
    ld a, $36
    call Multiply8By16
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $40
    ld h, a
    ld a, [wPersonalityIndex]
    add a, a
    add_a_to_hl
    ld a, $06
    ld [wDataBank], a
    call ReadWordFromDataBank
    ld a, b
    ld b, c
    ld c, a
    ret

; only called from AIScore_StrongD (E-0047)
; 1 call site from 1 routine (e.g. AIScore_StrongD)
; writes: hTemp0
AIScore_StrongD_HPBandOfSlotTemp0:: ; heuristic: follows a terminator; C0
Func_0E2_656D:: ; address name
    ldh [hTemp0], a
    farcall HPBandOfSlotTemp0
    ld a, c
    and a, a
    jr z, .call_accumulate_bank6_word_to_da70
    cp a, $01
    jr z, .call_accumulate_bank6_word_to_da702
    cp a, $02
    jr z, .call_accumulate_bank6_word_to_da703
    cp a, $03
    jr z, .call_accumulate_bank6_word_to_da704
    cp a, $04
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

; only called from AIScore_AquaWall (E-0047)
; 1 call site from 1 routine (e.g. AIScore_AquaWall)
; writes: hTemp0
AIScore_AquaWall_HPBandOfSlotTemp0:: ; heuristic: follows a terminator; C0
Func_0E2_65B8:: ; address name
    ldh [hTemp0], a
    farcall HPBandOfSlotTemp0
    ld a, c
    and a, a
    jr z, .call_accumulate_bank6_word_to_da6_e
    cp a, $01
    jr z, .call_accumulate_bank6_word_to_da6_e2
    cp a, $02
    jr z, .call_accumulate_bank6_word_to_da70
    cp a, $03
    jr z, .call_accumulate_bank6_word_to_da702
    cp a, $04
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

; only called from AIScore_SuckAll (E-0047)
; 1 call site from 1 routine (e.g. AIScore_SuckAll)
; writes: hTemp0
AIScore_SuckAll_CarryUnlessBattleSlotOutSlotEmpty:: ; heuristic: follows a terminator; C0
Func_0E2_6603:: ; address name
    and a, $04
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

; only called from AIScore_SuckAll_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. AIScore_SuckAll_CarryUnlessBattleSlotOutSlotEmpty)
AIScore_SuckAll_Sub01_HPBandOfSlotTemp0::
Func_0E2_661A:: ; address name
    farcall HPBandOfSlotTemp0
    ld a, c
    cp a, $02
    jr nc, .call_accumulate_bank6_word_to_da70
    ld bc, $0093
    call AccumulateBank6WordToDA6E
    jr .return

.call_accumulate_bank6_word_to_da70:
    ld bc, $0094
    call AccumulateBank6WordToDA70

.return:
    ret

; only called from AIScore_Meditate (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Meditate)
; writes: hTemp0
AIScore_Meditate_HPBandOfSlotTemp0:: ; heuristic: follows a terminator; C0
Func_0E2_6634:: ; address name
    ldh [hTemp0], a
    farcall HPBandOfSlotTemp0
    ld a, c
    and a, a
    jr z, .call_accumulate_bank6_word_to_da70
    cp a, $01
    jr z, .call_accumulate_bank6_word_to_da702
    cp a, $02
    jr z, .call_accumulate_bank6_word_to_da703
    cp a, $03
    jr z, .call_accumulate_bank6_word_to_da6_e
    cp a, $04
    jr z, .call_accumulate_bank6_word_to_da6_e2
    ld bc, $00A0
    call AccumulateBank6WordToDA6E
    jr .return

.call_accumulate_bank6_word_to_da70:
    ld bc, $009B
    call AccumulateBank6WordToDA70
    jr .return

.call_accumulate_bank6_word_to_da702:
    ld bc, $009C
    call AccumulateBank6WordToDA70
    jr .return

.call_accumulate_bank6_word_to_da703:
    ld bc, $009D
    call AccumulateBank6WordToDA70
    jr .return

.call_accumulate_bank6_word_to_da6_e:
    ld bc, $009E
    call AccumulateBank6WordToDA6E
    jr .return

.call_accumulate_bank6_word_to_da6_e2:
    ld bc, $009F
    call AccumulateBank6WordToDA6E

.return:
    ret

; only called from AIScore_HealUs_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. AIScore_HealUs_AnyFoeLacksStatus0MaskCC)
; writes: hTemp0
AIScore_HealUs_Sub01_CarryUnlessBattleSlotOutSlotEmpty:: ; heuristic: follows a terminator; C0
Func_0E2_667F:: ; address name
    and a, $04
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

; only called from AIScore_HealUs_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. AIScore_HealUs_Sub01_CarryUnlessBattleSlotOutSlotEmpty)
; reads: wBattleActor
AIScore_HealUs_Sub01_Sub01_HPBandOfSlotTemp0::
Func_0E2_6696:: ; address name
    push bc
    farcall HPBandOfSlotTemp0
    ld a, c
    pop bc
    ld b, a
    ld a, [wBattleActor]
    cp a, c
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

; address loaded by AIScore_HealUs_Sub01_Sub01_HPBandOfSlotTemp0
AIScore_HealUs_Sub01_Sub01_HPBandOfSlotTemp0_Data_66B9:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0E2_66B9:: ; address name
    db $1E, $1F, $20, $21, $22, $22

; address loaded by AIScore_HealUs_Sub01_Sub01_HPBandOfSlotTemp0
AIScore_HealUs_Sub01_Sub01_HPBandOfSlotTemp0_Data_66BF:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0E2_66BF:: ; address name
    db $AB, $AC, $AD, $AE, $AF, $AF

; for the three slots of the side in A (bit 2), runs Func_0E2_66DC with hFFC6 = slot for each occupied one (E-0122)
; 2 call sites from 2 routines (e.g. AIScore_Hustle, AIScore_LoveRain)
; writes: hTemp0
ForEachPresentSlotOfSideRun66DC::
Func_0E2_66C5:: ; address name
    and a, $04
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

; only called from ForEachPresentSlotOfSideRun66DC (E-0047)
; 1 call site from 1 routine (e.g. ForEachPresentSlotOfSideRun66DC)
; reads: wBattleActor
ForEachPresentSlotOfSideRun66DC_HPBandOfSlotTemp0::
Func_0E2_66DC:: ; address name
    push bc
    farcall HPBandOfSlotTemp0
    ld a, c
    pop bc
    ld b, a
    ld a, [wBattleActor]
    cp a, c
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

; address loaded by ForEachPresentSlotOfSideRun66DC_HPBandOfSlotTemp0
ForEachPresentSlotOfSideRun66DC_HPBandOfSlotTemp0_Data_66FF:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0E2_66FF:: ; address name
    db $1D, $1E, $1F, $20, $21, $22

; address loaded by ForEachPresentSlotOfSideRun66DC_HPBandOfSlotTemp0
ForEachPresentSlotOfSideRun66DC_HPBandOfSlotTemp0_Data_6705:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0E2_6705:: ; address name
    db $AA, $AB, $AC, $AD, $AE, $AF

; only called from AIScore_Ramming (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Ramming)
; writes: hTemp0
AIScore_Ramming_HPBandOfSlotTemp0::
Func_0E2_670B:: ; address name
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

; address loaded by AIScore_Ramming_HPBandOfSlotTemp0
AIScore_Ramming_HPBandOfSlotTemp0_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0E2_6727:: ; address name
    db $1D, $1E, $1F, $20, $21, $22

; only called from AIScore_Cover (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Cover)
; writes: hTemp0
AIScore_Cover_CarryUnlessBattleSlotOutSlotEmpty::
Func_0E2_672D:: ; address name
    and a, $04
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

; only called from AIScore_Cover_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Cover_CarryUnlessBattleSlotOutSlotEmpty)
; reads: wBattleActor
AIScore_Cover_Sub01_HPBandOfSlotTemp0::
Func_0E2_6744:: ; address name
    push bc
    farcall HPBandOfSlotTemp0
    ld a, c
    pop bc
    ld b, a
    ld a, [wBattleActor]
    cp a, c
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

; address loaded by AIScore_Cover_Sub01_HPBandOfSlotTemp0
AIScore_Cover_Sub01_HPBandOfSlotTemp0_Data_6767:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0E2_6767:: ; address name
    db $21, $20, $1F, $1E, $1D, $1D

; address loaded by AIScore_Cover_Sub01_HPBandOfSlotTemp0
AIScore_Cover_Sub01_HPBandOfSlotTemp0_Data_676D:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0E2_676D:: ; address name
    db $AA, $AA, $AB, $AC, $AD, $AE

; only called from AIScore_Upper (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Upper)
AIScore_Upper_CompareFoeAverageATKWithAllyDEF::
Func_0E2_6773:: ; address name
    farcall CompareFoeAverageATKWithAllyDEF
    ld a, c
    and a, a
    jr nz, .call_accumulate_bank6_word_to_da70
    ld bc, $002B
    call AccumulateBank6WordToDA6E
    jr .return

.call_accumulate_bank6_word_to_da70:
    ld bc, $0013
    call AccumulateBank6WordToDA70

.return:
    ret

; only called from AIScore_Sap (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Sap)
AIScore_Sap_Sub01_CarryUnlessBattleSlotOutSlotEmpty_Sub01:: ; heuristic: follows a terminator; C0
Func_0E2_678C:: ; address name
    farcall AIScore_Sap_Sub01_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a, a
    jr nz, .call_accumulate_bank6_word_to_da6_e
    ld bc, $0013
    call AccumulateBank6WordToDA70
    jr .return

.call_accumulate_bank6_word_to_da6_e:
    ld bc, $002B
    call AccumulateBank6WordToDA6E

.return:
    ret

; C = (wD2CC & 1) ^ 1 and returns when non-zero; when bit 0 is set: wDA6E = 0, wDA70/wDA71 = $FFFF, C = 0 (E-0118)
; 4 call sites from 4 routines (e.g. AIScoreGuardSkill_67CF, AIScore_SquallHit, AIScore_Berserker, AIScore_Guard)
; reads: wAIFlag
; writes: wAISkillScore, wAISkillScore2
MaxNegativeScoreWhenAIFlagBit0:: ; heuristic: follows a terminator; C0
Func_0E2_67A5:: ; address name
    ld a, [wAIFlag]
    and a, $01
    xor a, $01
    ld c, a
    ret nz
    xor a, a
    ld [wAISkillScore], a
    ld [wAISkillScore + $1], a
    ld a, $FF
    ld [wAISkillScore2], a
    ld [wAISkillScore2 + $1], a
    xor a, a
    ld c, a
    ret

; only called from AIScore_TailWind (E-0047)
; 1 call site from 1 routine (e.g. AIScore_TailWind)
; reads: wBattleTurn
AIScore_TailWind_AccumulateBank6WordToDA70:: ; heuristic: follows a terminator; C0
Func_0E2_67C0:: ; address name
    ld a, [wBattleTurn]
    ld c, a
    or a, a
    ret nz
    ld bc, $00B6
    call AccumulateBank6WordToDA70
    ld c, $FF
    ret

; returns when MaxNegativeScoreWhenAIFlagBit0 applies; otherwise continues with AIScore_TailWind_Sub02 (E-0122)
; 8 call sites from 8 routines (e.g. AIScore_Ironize, AIScore_StrongD, AIScore_Dodge, AIScore_BladeD, ...)
; reads: wBattleTurn
AIScoreGuardSkill_67CF::
Func_0E2_67CF:: ; address name
    call MaxNegativeScoreWhenAIFlagBit0
    ret z
    jr AIScore_TailWind_AccumulateBank6WordToDA70

; WeighWD044RuleBit4, then adds score word $29 to wDA6E when Func_005_5758 fails and again when Func_005_5CF1 fails (E-0122)
; 2 call sites from 2 routines (e.g. AIScore_Vivify, AIScore_Farewell)
AIAddPenaltyFor5758And5CF1::
Func_0E2_67D5:: ; address name
    call WeighWD044RuleBit4
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a, a
    jr nz, .call_pass_if_side0_flag_or_ally_slot_empty
    ld bc, $0029
    call AccumulateBank6WordToDA6E

.call_pass_if_side0_flag_or_ally_slot_empty:
    farcall PassIfSide0FlagOrAllySlotEmpty
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $0029
    call AccumulateBank6WordToDA6E

.return:
    ret

; adds score word $B1 when Func_005_5ECE fails and $B2 when Func_005_5FC7 fails (results of 1 count as passing) (E-0124)
; 9 call sites from 9 routines (e.g. AIScoreB_LureDance, AIScore_LureDance, AIScoreB_LushLicks, AIScore_LushLicks, ...)
AIAddScoresFor5ECEAnd5FC7:: ; heuristic: follows a terminator; C0
Func_0E2_67F9:: ; address name
    farcall AIAddScoresFor5ECEAnd5FC7_ReadSlotAIModeIndexed_Bank05
    ld a, c
    cp a, $01
    jr z, .call_ai_add_scores_for5_ece_and5_fc7_read
    and a, a
    jr nz, .call_ai_add_scores_for5_ece_and5_fc7_read
    ld bc, $00B1
    call AccumulateBank6WordToDA6E

.call_ai_add_scores_for5_ece_and5_fc7_read:
    farcall AIAddScoresFor5ECEAnd5FC7_ReadSlotAIModeIndexed_Bank05_Sub02
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr nz, .return
    ld bc, $00B2
    call AccumulateBank6WordToDA6E

.return:
    ret

; adds score word $0E to wDA70 when Func_005_55BE fails and $0F to wDA6E when Func_005_5731 fails (E-0122)
; 3 call sites from 3 routines (e.g. AIScore_Blaze, AIScore_Firebal, AIScore_Beat)
AIAddScoresFor55BEAnd5731::
Func_0E2_6822:: ; address name
    farcall LinkRuleCheckWD044Bit6
    ld a, c
    and a, a
    jr nz, .call_link_rule_check_link_rule_turn_limit
    ld bc, $000E
    call AccumulateBank6WordToDA70

.call_link_rule_check_link_rule_turn_limit:
    farcall LinkRuleCheckLinkRuleTurnLimitTurnLimit
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $000F
    call AccumulateBank6WordToDA6E

.return:
    ret

; only called from AIScore_Sacrifice (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Sacrifice)
AIScore_Sacrifice_LinkRuleCheckWD044Bit6:: ; heuristic: follows a terminator; C0
Func_0E2_6843:: ; address name
    farcall LinkRuleCheckWD044Bit6
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $000E
    call AccumulateBank6WordToDA70

.return:
    ret

; far-calls CheckWD044RuleBit5; when it fails (C = 0) adds weight-table entry $0E to wDA70 (AccumulateBank6WordToDA70); used by the AI scoring routines (E-0091)
; 36 call sites from 36 routines (e.g. AIScore_Upper, AIScore_Sap, AIScore_Speed, AIScore_Slow, ...)
WeighWD044RuleBit5:: ; heuristic: follows a terminator; C0
Func_0E2_6854:: ; address name
    farcall CheckWD044RuleBit5
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $000E
    call AccumulateBank6WordToDA70

.return:
    ret

; far-calls CheckWD044RuleBit4; when it fails (C = 0) adds weight-table entry $0E to wDA70 (AccumulateBank6WordToDA70); used by the AI scoring routines (E-0091)
; 12 call sites from 12 routines (e.g. AIScore_HealUs_AnyFoeLacksStatus0MaskCC, AIAddPenaltyFor5758And5CF1, AIScore_Antidote, AIScore_DeChaos, ...)
WeighWD044RuleBit4:: ; heuristic: follows a terminator; C0
Func_0E2_6865:: ; address name
    farcall CheckWD044RuleBit4
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $000E
    call AccumulateBank6WordToDA70

.return:
    ret

; far-calls CheckWD044RuleBit3; when it fails (C = 0) adds weight-table entry $0E to wDA70 (AccumulateBank6WordToDA70); used by the AI scoring routines (E-0091)
; 5 call sites from 5 routines (e.g. AIScore_FireAir, AIScore_SleepAir, AIScore_SuckAir, AIScore_MouthShut, ...)
WeighWD044RuleBit3:: ; heuristic: follows a terminator; C0
Func_0E2_6876:: ; address name
    farcall CheckWD044RuleBit3
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $000E
    call AccumulateBank6WordToDA70

.return:
    ret

; far-calls CheckWD044RuleBit2; when it fails (C = 0) adds weight-table entry $0E to wDA70 (AccumulateBank6WordToDA70); used by the AI scoring routines (E-0091)
; 8 call sites from 8 routines (e.g. AIScore_OddDance, AIScore_PaniDance, AIScore_KODance, AIScore_LureDance, ...)
WeighWD044RuleBit2:: ; heuristic: follows a terminator; C0
Func_0E2_6887:: ; address name
    farcall CheckWD044RuleBit2
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $000E
    call AccumulateBank6WordToDA70

.return:
    ret

; far-calls CheckWD044RuleBit1; when it fails (C = 0) adds weight-table entry $0E to wDA70 (AccumulateBank6WordToDA70); used by the AI scoring routines (E-0091)
; 22 call sites from 22 routines (e.g. AIScore_BigBang, AIScore_Vacuum_CheckLoneFoeHPNotBelowAIDamageEstimates, AIScore_RockThrow, AIScore_Watershot, ...)
WeighWD044RuleBit1:: ; heuristic: follows a terminator; C0
Func_0E2_6898:: ; address name
    farcall CheckWD044RuleBit1
    ld a, c
    and a, a
    jr nz, .return
    ld bc, $000E
    call AccumulateBank6WordToDA70

.return:
    ret

; A = battle slot: HL = the word for that slot at wBattleATK; A = its low byte (E-0064)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleATK
GetBattleATK_BankE2:: ; heuristic: follows a terminator; C0
Func_0E2_68A9:: ; address name
    ld hl, wBattleATK
    jr GetBattleMP_BankE2_Skip

; no direct call (reached through a table, a jump or a vector)
; points at: wBattleDEF
GetBattleDEF_BankE2:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:4006; C0
Func_0E2_68AE:: ; address name
    ld hl, wBattleDEF
    jr GetBattleMP_BankE2_Skip

; no direct call (reached through a table, a jump or a vector)
; points at: wBattleMaxHP
GetBattleMaxHP_BankE2:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:400B; C0
Func_0E2_68B3:: ; address name
    ld hl, wBattleMaxHP
    jr GetBattleMP_BankE2_Skip

; no direct call (reached through a table, a jump or a vector)
; points at: wBattleMaxMP
GetBattleMaxMP_BankE2:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:4010; C0
Func_0E2_68B8:: ; address name
    ld hl, wBattleMaxMP
    jr GetBattleMP_BankE2_Skip

; no direct call (reached through a table, a jump or a vector)
; points at: wBattleHP
GetBattleHP_BankE2:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:4015; C0
Func_0E2_68BD:: ; address name
    ld hl, wBattleHP
    jr GetBattleMP_BankE2_Skip

; no direct call (reached through a table, a jump or a vector)
; points at: wBattleMP
GetBattleMP_BankE2:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:401A; C0
Func_0E2_68C2:: ; address name
    ld hl, wBattleMP
    jr GetBattleMP_BankE2_Skip
    db $21, $1F, $D9, $18, $0A, $21, $53, $DA, $85, $6F, $30, $01, $24, $7E, $C9

GetBattleMP_BankE2_Skip::
Jump_0E2_68D6:: ; address name
    add a, a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
AddDoubleAToHL_BankE2:: ; heuristic: follows a terminator; C0
Func_0E2_68E0:: ; address name
    add a, a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the reversal, not checked (E-0064) (the same 27 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole, wBattleActor
ActorOnLocalSide_BankE2:: ; heuristic: follows a terminator; C0
Func_0E2_68E7:: ; address name
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
TargetOnLocalSide_BankE2:: ; heuristic: follows a terminator; C0
Func_0E2_6902:: ; address name
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
ClearBattleStatusBitsWithMaskD_BankE2:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:4075; C0
Func_0E2_691D:: ; address name
    ld a, d
    ld hl, ClearBattleStatusBitsWithMaskD_BankE2_Data
    add_a_to_hl
    ld d, [hl]
    ld a, e
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, d
    and a, [hl]
    ld [hl], a
    ret

; address loaded by ClearBattleStatusBitsWithMaskD_BankE2
ClearBattleStatusBitsWithMaskD_BankE2_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0E2_6932:: ; address name
    db $DF, $FE, $00, $FD, $73, $EF, $BF

; Sets bit 0 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wLevelUpGains
SetBit0OfLevelUpGainsIndexed_BankE2:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:4091; C0
Func_0E2_6939:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; Sets bit 1 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wLevelUpGains
SetBit1OfLevelUpGainsIndexed_BankE2:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:409E; C0
Func_0E2_6946:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; Sets bit 2 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wLevelUpGains
SetBit2OfLevelUpGainsIndexed_BankE2:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:40AB; C0
Func_0E2_6953:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 2, [hl]
    pop hl
    ret

; A = slot 0-7: returns A = 9 * g(wD968[A]) + 3 * g(wD970[A]) + g(wD978[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes appear in 13 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo
PersonalityIndexOfSlot_BankE2:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:40B8; C0
Func_0E2_6960:: ; address name
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
CheckSlotStatusBlockWide_BankE2:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:410F; C0
Func_0E2_69B7:: ; address name
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
SlotHasStatus3Or4Bits_BankE2:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:412E; C0
Func_0E2_69D6:: ; address name
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
    ds $1619, $00
