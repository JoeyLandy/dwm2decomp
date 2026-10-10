SECTION "Bank E2", ROMX[$4000], BANK[$E2]
    db $E2

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 0 (no name). It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Skill00:: ; heuristic: follows a terminator; C0
Func_0E2_4001:: ; address name
    farcall AIScore_Skill00_Sub01
    ld a, c
    and a, a
    ret z
    farcall AnyFoeHasDEFAtLeast2
    ld a, c
    and a, a
    jr nz, Jump_0E2_401A
    ld bc, $0000
    call AccumulateBank6WordToDA6E

Jump_0E2_401A::
    farcall AtLeastTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_402A
    ld bc, $0001
    call AccumulateBank6WordToDA6E

Jump_0E2_402A::
    farcall CheckLoneFoeHPNotBelowWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_403A
    ld bc, $0002
    call AccumulateBank6WordToDA6E

Jump_0E2_403A::
    farcall CheckFoeStatus7Bit2
    ld a, c
    cp a, $01
    jr z, Jump_0E2_404E
    and a, a
    jr nz, Jump_0E2_404E
    ld bc, $0003
    call AccumulateBank6WordToDA70

Jump_0E2_404E::
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_405E
    ld bc, $0005
    call AccumulateBank6WordToDA6E

Jump_0E2_405E::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_406E
    ld bc, $0006
    call AccumulateBank6WordToDA6E

Jump_0E2_406E::
    farcall CheckWCFC5AtLeast2OrWC58ASet
    ld a, c
    and a, a
    jr nz, Jump_0E2_407E
    ld bc, $0066
    call AccumulateBank6WordToDA6E

Jump_0E2_407E::
    farcall FailIfFoeHPBelowFourTimesWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_408E
    ld bc, $0067
    call AccumulateBank6WordToDA6E

Jump_0E2_408E::
    farcall CheckActorSlot0To3OrWC58ASet
    ld a, c
    and a, a
    jr nz, Jump_0E2_409E
    ld bc, $0068
    call AccumulateBank6WordToDA6E

Jump_0E2_409E::
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a, a
    jr nz, Jump_0E2_40AE
    ld bc, $0005
    call AccumulateBank6WordToDA6E

Jump_0E2_40AE::
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_40BE
    ld bc, $0033
    call AccumulateBank6WordToDA70

Jump_0E2_40BE::
    ret

; AI scoring routine for 3 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 1 Blaze, 2 Blazemore, 3 Blazemost. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Blaze:: ; heuristic: follows a terminator; C0
Func_0E2_40BF:: ; address name
    farcall AIFireSkillUsable
    ld a, c
    and a, a
    ret z
    farcall FailIfFoeWD2C1AtLeastEstimate
    ld a, c
    and a, a
    jr nz, Jump_0E2_40D8
    ld bc, $0008
    call AccumulateBank6WordToDA70

Jump_0E2_40D8::
    farcall Func_005_5052
    ld a, c
    and a, a
    jr nz, Jump_0E2_40E8
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_40E8::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_40F8
    ld bc, $000B
    call AccumulateBank6WordToDA6E

Jump_0E2_40F8::
    farcall InvertedResultOfFunc4E48
    ld a, c
    and a, a
    jr nz, Jump_0E2_4108
    ld bc, $000C
    call AccumulateBank6WordToDA6E

Jump_0E2_4108::
    call AIAddScoresFor55BEAnd5731
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_411B
    ld bc, $0010
    call AccumulateBank6WordToDA70

Jump_0E2_411B::
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
    jr z, Jump_0E2_4139
    and a, a
    jr nz, Jump_0E2_4139
    ld bc, $0004
    call AccumulateBank6WordToDA70

Jump_0E2_4139::
    farcall FailIfFoeWD2C1AtLeastEstimate
    ld a, c
    and a, a
    jr nz, Jump_0E2_4149
    ld bc, $000A
    call AccumulateBank6WordToDA70

Jump_0E2_4149::
    farcall Func_005_5052
    ld a, c
    and a, a
    jr nz, Jump_0E2_4159
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4159::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_4169
    ld bc, $000B
    call AccumulateBank6WordToDA6E

Jump_0E2_4169::
    farcall InvertedResultOfFunc4E48
    ld a, c
    and a, a
    jr nz, Jump_0E2_4179
    ld bc, $000D
    call AccumulateBank6WordToDA6E

Jump_0E2_4179::
    call AIAddScoresFor55BEAnd5731
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a, a
    jr nz, Jump_0E2_418C
    ld bc, $0014
    call AccumulateBank6WordToDA6E

Jump_0E2_418C::
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_419C
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_419C::
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp a, $01
    jr z, Jump_0E2_41B0
    and a, a
    jr nz, Jump_0E2_41B0
    ld bc, $004A
    call AccumulateBank6WordToDA70

Jump_0E2_41B0::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_41C4
    and a, a
    jr nz, Jump_0E2_41C4
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_41C4::
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
    jr z, Jump_0E2_41DF
    and a, a
    jr nz, Jump_0E2_41DF
    ld bc, $00B5
    call AccumulateBank6WordToDA6E

Jump_0E2_41DF::
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 19 Beat, 20 Defeat. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; 1 call site from 1 routine (e.g. AIScoreB_Beat)
AIScore_Beat::
Func_0E2_41E0:: ; address name
    farcall AIScore_Beat_Sub01
    ld a, c
    and a, a
    ret z
    farcall AIGateFoeStatus1Mask22
    ld a, c
    cp a, $01
    jr z, Jump_0E2_41FD
    and a, a
    jr nz, Jump_0E2_41FD
    ld bc, $0004
    call AccumulateBank6WordToDA70

Jump_0E2_41FD::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_4213
    ld bc, $00CD
    call AccumulateBank6WordToDA6E
    ld bc, $00CF
    call AccumulateBank6WordToDA70

Jump_0E2_4213::
    call AIAddScoresFor55BEAnd5731
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_4226
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_4226::
    farcall AIGateFoeWDA74Bits45
    ld a, c
    cp a, $01
    jr z, Jump_0E2_423A
    and a, a
    jr nz, Jump_0E2_423A
    ld bc, $00B5
    call AccumulateBank6WordToDA6E

Jump_0E2_423A::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_424E
    and a, a
    jr nz, Jump_0E2_424E
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_424E::
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4262
    and a, a
    jr nz, Jump_0E2_4262
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4262::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4276
    and a, a
    jr nz, Jump_0E2_4276
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4276::
    ld c, $01
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 21 Sacrifice. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Sacrifice:: ; heuristic: follows a terminator; C0
Func_0E2_4279:: ; address name
    farcall AIScore_Sacrifice_Sub02
    ld a, c
    and a, a
    ret z
    farcall ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr nz, Jump_0E2_4292
    ld bc, $0017
    call AccumulateBank6WordToDA70

Jump_0E2_4292::
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a, a
    jr nz, Jump_0E2_42A2
    ld bc, $0017
    call AccumulateBank6WordToDA70

Jump_0E2_42A2::
    farcall AtLeastTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_42B2
    ld bc, $0011
    call AccumulateBank6WordToDA70

Jump_0E2_42B2::
    farcall AnyAllyHPAtMostThreeQuarters
    ld a, c
    and a, a
    jr nz, Jump_0E2_42C2
    ld bc, $001B
    call AccumulateBank6WordToDA70

Jump_0E2_42C2::
    farcall CheckLoneFoeHPNotBelowWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_42D2
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_42D2::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_42E8
    ld bc, $00CD
    call AccumulateBank6WordToDA6E
    ld bc, $00CF
    call AccumulateBank6WordToDA70

Jump_0E2_42E8::
    call AIScore_Sacrifice_Sub03
    farcall AIScore_Sacrifice_Sub01
    ld a, c
    and a, a
    jr nz, Jump_0E2_42FB
    ld bc, $0019
    call AccumulateBank6WordToDA6E

Jump_0E2_42FB::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_430F
    and a, a
    jr nz, Jump_0E2_430F
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_430F::
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
    farcall Func_005_6556
    ld a, c
    cp a, $01
    jr z, AIScore_HealUs_Sub01
    and a, a
    jr nz, AIScore_HealUs_Sub01
    ld bc, $0069
    call AccumulateBank6WordToDA70

; only called from AIScore_HealUs (E-0047)
; 1 call site from 1 routine (e.g. AIScore_HealUs)
; reads: wBattleActor
AIScore_HealUs_Sub01::
Func_0E2_432D:: ; address name
    farcall AnyFoeLacksStatus0MaskCC
    ld a, c
    and a, a
    jr nz, Jump_0E2_433D
    ld bc, $001A
    call AccumulateBank6WordToDA6E

Jump_0E2_433D::
    farcall AnyFoeHasClearStatus3
    ld a, c
    and a, a
    jr nz, Jump_0E2_434D
    ld bc, $001A
    call AccumulateBank6WordToDA6E

Jump_0E2_434D::
    farcall AnyAllyHPAtMostThreeQuarters
    ld a, c
    and a, a
    jr nz, Jump_0E2_435D
    ld bc, $001B
    call AccumulateBank6WordToDA70

Jump_0E2_435D::
    ld a, [wBattleActor]
    call AIScore_HealUs_Sub01_Sub01
    farcall ActorHPIsNotOne
    ld a, c
    and a, a
    jr nz, Jump_0E2_4373
    ld bc, $0023
    call AccumulateBank6WordToDA6E

Jump_0E2_4373::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_4389
    ld bc, $0024
    call AccumulateBank6WordToDA6E
    ld bc, $00C8
    call AccumulateBank6WordToDA6E

Jump_0E2_4389::
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
    call AIScore_HealUs_Sub01
    farcall FewerThanTwoAlliesAtHP1
    ld a, c
    and a, a
    jr nz, Jump_0E2_43A9
    ld bc, $0023
    call AccumulateBank6WordToDA6E

Jump_0E2_43A9::
    farcall Func_005_6556
    ld a, c
    cp a, $01
    jr z, Jump_0E2_43BD
    and a, a
    jr nz, Jump_0E2_43BD
    ld bc, $0069
    call AccumulateBank6WordToDA6E

Jump_0E2_43BD::
    ret

; AI scoring routine for 3 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 27 MPass, 28 MPassmore, 29 MPassmost. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_MPass:: ; heuristic: follows a terminator; C0
Func_0E2_43BE:: ; address name
    farcall AIScore_MPass_Sub01
    ld a, c
    and a, a
    ret z
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 30 Vivify, 31 Revive. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Vivify:: ; heuristic: follows a terminator; C0
Func_0E2_43C8:: ; address name
    farcall AIScore_Vivify_Sub01
    ld a, c
    and a, a
    ret z
    call AIAddPenaltyFor5758And5CF1
    farcall Func_005_667F
    ld a, c
    cp a, $01
    jr z, Jump_0E2_43E8
    and a, a
    jr nz, Jump_0E2_43E8
    ld bc, $002E
    call AccumulateBank6WordToDA70

Jump_0E2_43E8::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 32 Farewell. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Farewell:: ; heuristic: follows a terminator; C0
Func_0E2_43E9:: ; address name
    farcall AIScore_Farewell_Sub01
    ld a, c
    and a, a
    ret z
    call AIAddPenaltyFor5758And5CF1
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_440B
    ld bc, $00BC
    call AccumulateBank6WordToDA6E
    ld bc, $00C4
    call AccumulateBank6WordToDA70

Jump_0E2_440B::
    farcall Func_005_667F
    ld a, c
    cp a, $01
    jr z, Jump_0E2_441F
    and a, a
    jr nz, Jump_0E2_441F
    ld bc, $002E
    call AccumulateBank6WordToDA70

Jump_0E2_441F::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 33 Antidote. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Antidote:: ; heuristic: follows a terminator; C0
Func_0E2_4420:: ; address name
    farcall AIScore_Antidote_Sub01
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
    farcall AIScore_DeChaos_Sub01
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
    farcall AIScore_NumbOff_Sub01
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
    farcall AIScore_CurseOff_Sub01
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
    farcall AIScore_Upper_Sub01
    ld a, c
    and a, a
    ret z
    farcall CheckLoneFoeHPNotBelowWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_4485
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_4485::
    call WeighWD044RuleBit5
    call AIScore_Upper_Sub02
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_449B
    ld bc, $00C1
    call AccumulateBank6WordToDA70

Jump_0E2_449B::
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 39 Sap, 40 Defense. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Sap:: ; heuristic: follows a terminator; C0
Func_0E2_449C:: ; address name
    farcall AIScore_Sap_Sub01
    ld a, c
    and a, a
    ret z
    farcall CheckLoneFoeHPNotBelowWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_44B5
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_44B5::
    farcall Func_005_50E3
    ld a, c
    cp a, $01
    jr z, Jump_0E2_44C9
    and a, a
    jr nz, Jump_0E2_44C9
    ld bc, $002C
    call AccumulateBank6WordToDA6E

Jump_0E2_44C9::
    farcall Func_005_517D
    ld a, c
    cp a, $01
    jr z, Jump_0E2_44DD
    and a, a
    jr nz, Jump_0E2_44DD
    ld bc, $002C
    call AccumulateBank6WordToDA6E

Jump_0E2_44DD::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_44F3
    ld bc, $00CC
    call AccumulateBank6WordToDA6E
    ld bc, $00D1
    call AccumulateBank6WordToDA70

Jump_0E2_44F3::
    call WeighWD044RuleBit5
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_450A
    and a, a
    jr nz, Jump_0E2_450A
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_450A::
    call AIScore_Sap_Sub02
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4521
    and a, a
    jr nz, Jump_0E2_4521
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4521::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4535
    and a, a
    jr nz, Jump_0E2_4535
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4535::
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 41 Speed, 42 SpeedUp. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Speed:: ; heuristic: follows a terminator; C0
Func_0E2_4536:: ; address name
    farcall AIScore_Speed_Sub01
    ld a, c
    and a, a
    ret z
    farcall Func_005_4B97
    ld a, c
    and a, a
    jr nz, Jump_0E2_454F
    ld bc, $002D
    call AccumulateBank6WordToDA70

Jump_0E2_454F::
    farcall AllyAverageAGLAtLeastFoes
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4563
    and a, a
    jr nz, Jump_0E2_4563
    ld bc, $002C
    call AccumulateBank6WordToDA6E

Jump_0E2_4563::
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 43 Slow, 44 SlowAll. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Slow:: ; heuristic: follows a terminator; C0
Func_0E2_4567:: ; address name
    farcall AIScore_Slow_Sub01
    ld a, c
    and a, a
    ret z
    farcall AIGateFoeStatus1Mask22
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4584
    and a, a
    jr nz, Jump_0E2_4584
    ld bc, $0004
    call AccumulateBank6WordToDA70

Jump_0E2_4584::
    farcall Func_005_4B97
    ld a, c
    and a, a
    jr nz, Jump_0E2_4594
    ld bc, $002D
    call AccumulateBank6WordToDA70

Jump_0E2_4594::
    farcall AllyAverageAGLAtLeastFoes
    ld a, c
    cp a, $01
    jr z, Jump_0E2_45A8
    and a, a
    jr nz, Jump_0E2_45A8
    ld bc, $002C
    call AccumulateBank6WordToDA6E

Jump_0E2_45A8::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_45BE
    ld bc, $00CC
    call AccumulateBank6WordToDA6E
    ld bc, $00D1
    call AccumulateBank6WordToDA70

Jump_0E2_45BE::
    call WeighWD044RuleBit5
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_45D5
    and a, a
    jr nz, Jump_0E2_45D5
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_45D5::
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_45E9
    and a, a
    jr nz, Jump_0E2_45E9
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_45E9::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_45FD
    and a, a
    jr nz, Jump_0E2_45FD
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_45FD::
    ret

; table-B AI score: AIScore_TwinHits, then adds a penalty word when the follow-up check fails (E-0122)
; no direct call (reached through a table, a jump or a vector)
AIScoreB_TwinHits:: ; heuristic: follows a terminator; C0
Func_0E2_45FE:: ; address name
    call AIScore_TwinHits
    ld a, c
    and a, a
    ret z
    farcall Func_005_5F3D
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4618
    and a, a
    jr nz, Jump_0E2_4618
    ld bc, $00B3
    call AccumulateBank6WordToDA6E

Jump_0E2_4618::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 45 TwinHits. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; 1 call site from 1 routine (e.g. AIScoreB_TwinHits)
AIScore_TwinHits::
Func_0E2_4619:: ; address name
    farcall AIScore_TwinHits_Sub03
    ld a, c
    and a, a
    ret z
    farcall AIScore_TwinHits_Sub01
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4636
    and a, a
    jr nz, Jump_0E2_4636
    ld bc, $002F
    call AccumulateBank6WordToDA6E

Jump_0E2_4636::
    farcall AIScore_TwinHits_Sub02
    ld a, c
    cp a, $01
    jr z, Jump_0E2_464A
    and a, a
    jr nz, Jump_0E2_464A
    ld bc, $0030
    call AccumulateBank6WordToDA6E

Jump_0E2_464A::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_465A
    ld bc, $00BA
    call AccumulateBank6WordToDA6E

Jump_0E2_465A::
    call WeighWD044RuleBit5
    farcall Func_005_5F3D
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4671
    and a, a
    jr nz, Jump_0E2_4671
    ld bc, $00B3
    call AccumulateBank6WordToDA6E

Jump_0E2_4671::
    ld c, $01
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 46 Surround. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Surround:: ; heuristic: follows a terminator; C0
Func_0E2_4674:: ; address name
    farcall AIScore_Surround_Sub01
    ld a, c
    and a, a
    ret z
    farcall AIGateFoeStatus1Mask22
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4691
    and a, a
    jr nz, Jump_0E2_4691
    ld bc, $0004
    call AccumulateBank6WordToDA70

Jump_0E2_4691::
    farcall CheckLoneFoeHPNotBelowWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_46A1
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_46A1::
    farcall Func_005_5275
    ld a, c
    cp a, $01
    jr z, Jump_0E2_46B5
    and a, a
    jr nz, Jump_0E2_46B5
    ld bc, $0031
    call AccumulateBank6WordToDA6E

Jump_0E2_46B5::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_46D1
    ld bc, $00BA
    call AccumulateBank6WordToDA70
    ld bc, $00CC
    call AccumulateBank6WordToDA6E
    ld bc, $00D1
    call AccumulateBank6WordToDA70

Jump_0E2_46D1::
    call WeighWD044RuleBit5
    farcall Func_005_585D
    ld a, c
    and a, a
    jr nz, Jump_0E2_46E4
    ld bc, $0032
    call AccumulateBank6WordToDA6E

Jump_0E2_46E4::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_46F8
    and a, a
    jr nz, Jump_0E2_46F8
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_46F8::
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_470C
    and a, a
    jr nz, Jump_0E2_470C
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_470C::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4720
    and a, a
    jr nz, Jump_0E2_4720
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4720::
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 47 Sleep, 48 SleepAll. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Sleep:: ; heuristic: follows a terminator; C0
Func_0E2_4721:: ; address name
    farcall AIScore_Sleep_Sub01
    ld a, c
    and a, a
    ret z
    farcall AIGateFoeStatus1Mask22
    ld a, c
    cp a, $01
    jr z, Jump_0E2_473E
    and a, a
    jr nz, Jump_0E2_473E
    ld bc, $0004
    call AccumulateBank6WordToDA70

Jump_0E2_473E::
    farcall AllyAverageAGLAtLeastFoes
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4752
    and a, a
    jr nz, Jump_0E2_4752
    ld bc, $002C
    call AccumulateBank6WordToDA6E

Jump_0E2_4752::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_4762
    ld bc, $00BC
    call AccumulateBank6WordToDA70

Jump_0E2_4762::
    call WeighWD044RuleBit5
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4779
    and a, a
    jr nz, Jump_0E2_4779
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4779::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_478D
    and a, a
    jr nz, Jump_0E2_478D
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_478D::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 49 TakeMagic. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_TakeMagic:: ; heuristic: follows a terminator; C0
Func_0E2_478E:: ; address name
    farcall AIScore_TakeMagic_Sub01
    ld a, c
    and a, a
    ret z
    farcall ActorMPBelowThreeQuarters
    ld a, c
    and a, a
    jr nz, Jump_0E2_47A7
    ld bc, $0034
    call AccumulateBank6WordToDA70

Jump_0E2_47A7::
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 50 RobMagic. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_RobMagic:: ; heuristic: follows a terminator; C0
Func_0E2_47AB:: ; address name
    farcall AIScore_RobMagic_Sub01
    ld a, c
    and a, a
    ret z
    ld bc, $0035
    call AccumulateBank6WordToDA6E
    farcall Func_005_5052
    ld a, c
    and a, a
    jr nz, Jump_0E2_47CA
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_47CA::
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 51 StopSpell. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_StopSpell:: ; heuristic: follows a terminator; C0
Func_0E2_47CE:: ; address name
    farcall AIScore_StopSpell_Sub01
    ld a, c
    and a, a
    ret z
    farcall AIGateFoeStatus1Mask22
    ld a, c
    cp a, $01
    jr z, Jump_0E2_47EB
    and a, a
    jr nz, Jump_0E2_47EB
    ld bc, $0004
    call AccumulateBank6WordToDA70

Jump_0E2_47EB::
    call WeighWD044RuleBit5
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_4804
    ld bc, $00CC
    call AccumulateBank6WordToDA6E
    ld bc, $00D1
    call AccumulateBank6WordToDA70

Jump_0E2_4804::
    farcall AIModeAtLeast2AndFoeLacks6D1A
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4818
    and a, a
    jr nz, Jump_0E2_4818
    ld bc, $0036
    call AccumulateBank6WordToDA6E

Jump_0E2_4818::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_482C
    and a, a
    jr nz, Jump_0E2_482C
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_482C::
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4840
    and a, a
    jr nz, Jump_0E2_4840
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4840::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4854
    and a, a
    jr nz, Jump_0E2_4854
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4854::
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
    jr nz, Jump_0E2_486E
    ld bc, $00CA
    call AccumulateBank6WordToDA6E

Jump_0E2_486E::
    call WeighWD044RuleBit5
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4885
    and a, a
    jr nz, Jump_0E2_4885
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_4885::
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4899
    and a, a
    jr nz, Jump_0E2_4899
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4899::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_48AD
    and a, a
    jr nz, Jump_0E2_48AD
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_48AD::
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
    jr nz, Jump_0E2_48CB
    ld bc, $00D0
    call AccumulateBank6WordToDA6E

Jump_0E2_48CB::
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 54 MagicBack, 55 Bounce. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_MagicBack:: ; heuristic: follows a terminator; C0
Func_0E2_48CF:: ; address name
    farcall AIScore_MagicBack_Sub01
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_48E8
    ld bc, $00C0
    call AccumulateBank6WordToDA70

Jump_0E2_48E8::
    farcall AIModeAtLeast2AndFoeLacks6D1A
    ld a, c
    cp a, $01
    jr z, Jump_0E2_48FC
    and a, a
    jr nz, Jump_0E2_48FC
    ld bc, $0036
    call AccumulateBank6WordToDA6E

Jump_0E2_48FC::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 56 Barrier. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Barrier:: ; heuristic: follows a terminator; C0
Func_0E2_48FD:: ; address name
    farcall AIScore_Barrier_Sub01
    ld a, c
    and a, a
    ret z
    farcall Func_005_53FA
    ld a, c
    cp a, $01
    jr z, Jump_0E2_491A
    and a, a
    jr nz, Jump_0E2_491A
    ld bc, $003A
    call AccumulateBank6WordToDA6E

Jump_0E2_491A::
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 57 MagicWall. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_MagicWall:: ; heuristic: follows a terminator; C0
Func_0E2_491E:: ; address name
    farcall AIScore_MagicWall_Sub01
    ld a, c
    and a, a
    ret z
    call WeighWD044RuleBit5
    farcall AIModeAtLeast2AndFoeLacks6D1A
    ld a, c
    cp a, $01
    jr z, Jump_0E2_493E
    and a, a
    jr nz, Jump_0E2_493E
    ld bc, $0036
    call AccumulateBank6WordToDA6E

Jump_0E2_493E::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 58 Transform. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Transform:: ; heuristic: follows a terminator; C0
Func_0E2_493F:: ; address name
    farcall AIUsableAndActorLacksStatus4Bits67
    ld a, c
    and a, a
    ret z
    farcall Func_005_517D
    ld a, c
    cp a, $01
    jr z, Jump_0E2_495C
    and a, a
    jr nz, Jump_0E2_495C
    ld bc, $003B
    call AccumulateBank6WordToDA6E

Jump_0E2_495C::
    farcall AIScore_Transform_Sub01
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4970
    and a, a
    jr nz, Jump_0E2_4970
    ld bc, $003C
    call AccumulateBank6WordToDA6E

Jump_0E2_4970::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_4980
    ld bc, $00CE
    call AccumulateBank6WordToDA6E

Jump_0E2_4980::
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
    farcall Func_005_53FA
    ld a, c
    cp a, $01
    jr z, Jump_0E2_49A1
    and a, a
    jr nz, Jump_0E2_49A1
    ld bc, $003A
    call AccumulateBank6WordToDA6E

Jump_0E2_49A1::
    call WeighWD044RuleBit5
    farcall AIScore_BeDragon_Sub01
    ld a, c
    and a, a
    jr nz, Jump_0E2_49B4
    ld bc, $003D
    call AccumulateBank6WordToDA6E

Jump_0E2_49B4::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 60 Chance. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Chance:: ; heuristic: follows a terminator; C0
Func_0E2_49B5:: ; address name
    farcall CheckSkillUsableStatusElseResetWDA6E
    ld a, c
    and a, a
    ret z
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a, a
    jr nz, Jump_0E2_49CE
    ld bc, $003F
    call AccumulateBank6WordToDA6E

Jump_0E2_49CE::
    farcall ActorHPIsNotOne
    ld a, c
    and a, a
    jr nz, Jump_0E2_49DE
    ld bc, $0040
    call AccumulateBank6WordToDA6E

Jump_0E2_49DE::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_49F4
    ld bc, $00BF
    call AccumulateBank6WordToDA6E
    ld bc, $00C5
    call AccumulateBank6WordToDA70

Jump_0E2_49F4::
    call WeighWD044RuleBit5
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a, a
    jr nz, Jump_0E2_4A07
    ld bc, $0042
    call AccumulateBank6WordToDA6E

Jump_0E2_4A07::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 61 MegaMagic. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_MegaMagic:: ; heuristic: follows a terminator; C0
Func_0E2_4A08:: ; address name
    farcall AIScore_MegaMagic_Sub04
    ld a, c
    and a, a
    ret z
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a, a
    jr nz, Jump_0E2_4A21
    ld bc, $0043
    call AccumulateBank6WordToDA6E

Jump_0E2_4A21::
    farcall CheckLoneFoeHPNotBelowWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_4A31
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_4A31::
    farcall AnyAllyLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_4A41
    ld bc, $0044
    call AccumulateBank6WordToDA70

Jump_0E2_4A41::
    farcall Func_005_5052
    ld a, c
    and a, a
    jr nz, Jump_0E2_4A51
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4A51::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_4A61
    ld bc, $0045
    call AccumulateBank6WordToDA6E

Jump_0E2_4A61::
    farcall AIScore_MegaMagic_Sub01
    ld a, c
    and a, a
    jr nz, Jump_0E2_4A71
    ld bc, $000E
    call AccumulateBank6WordToDA70

Jump_0E2_4A71::
    farcall LinkRuleCheckWD04BTurnLimit
    ld a, c
    and a, a
    jr nz, Jump_0E2_4A81
    ld bc, $0046
    call AccumulateBank6WordToDA6E

Jump_0E2_4A81::
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a, a
    jr nz, Jump_0E2_4A91
    ld bc, $0047
    call AccumulateBank6WordToDA6E

Jump_0E2_4A91::
    farcall AIScore_MegaMagic_Sub02
    ld a, c
    and a, a
    jr nz, Jump_0E2_4AA1
    ld bc, $0048
    call AccumulateBank6WordToDA6E

Jump_0E2_4AA1::
    farcall AIScore_MegaMagic_Sub03
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4AB5
    or a, a
    jr nz, Jump_0E2_4AB5
    ld bc, $003E
    call AccumulateBank6WordToDA70

Jump_0E2_4AB5::
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
    jr nz, Jump_0E2_4ACF
    ld bc, $0049
    call AccumulateBank6WordToDA6E

Jump_0E2_4ACF::
    farcall FailIfFoeWD2C1AtLeastEstimate
    ld a, c
    and a, a
    jr nz, Jump_0E2_4ADF
    ld bc, $000A
    call AccumulateBank6WordToDA70

Jump_0E2_4ADF::
    farcall Func_005_5052
    ld a, c
    and a, a
    jr nz, Jump_0E2_4AEF
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4AEF::
    farcall InvertedResultOfFunc4E48
    ld a, c
    and a, a
    jr nz, Jump_0E2_4AFF
    ld bc, $000D
    call AccumulateBank6WordToDA6E

Jump_0E2_4AFF::
    call WeighWD044RuleBit1
    farcall LinkRuleCheckWD04BTurnLimit
    ld a, c
    and a, a
    jr nz, Jump_0E2_4B12
    ld bc, $0046
    call AccumulateBank6WordToDA6E

Jump_0E2_4B12::
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a, a
    jr nz, Jump_0E2_4B22
    ld bc, $0047
    call AccumulateBank6WordToDA6E

Jump_0E2_4B22::
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_4B32
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_4B32::
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4B46
    and a, a
    jr nz, Jump_0E2_4B46
    ld bc, $004A
    call AccumulateBank6WordToDA70

Jump_0E2_4B46::
    farcall CheckWCFC5Not2Or3
    ld a, c
    and a, a
    jr nz, Jump_0E2_4B56
    ld bc, $004B
    call AccumulateBank6WordToDA6E

Jump_0E2_4B56::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4B6A
    and a, a
    jr nz, Jump_0E2_4B6A
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_4B6A::
    ret

; AI scoring routine for 8 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 64 FireAir, 65 BlazeAir, 66 Scorching, 67 WhiteFire, 68 FrigidAir, 69 IceAir, 70 IceStorm, 71 WhiteAir. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_FireAir:: ; heuristic: follows a terminator; C0
Func_0E2_4B6B:: ; address name
    farcall AIScore_FireAir_Sub02
    ld a, c
    and a, a
    ret z
    farcall AIScore_FireAir_Sub01
    ld a, c
    and a, a
    jr nz, Jump_0E2_4B84
    ld bc, $004C
    call AccumulateBank6WordToDA70

Jump_0E2_4B84::
    farcall AtLeastTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_4B94
    ld bc, $0011
    call AccumulateBank6WordToDA70

Jump_0E2_4B94::
    farcall FailIfFoeWD2C1AtLeastEstimate
    ld a, c
    and a, a
    jr nz, Jump_0E2_4BA4
    ld bc, $000A
    call AccumulateBank6WordToDA70

Jump_0E2_4BA4::
    farcall Func_005_5052
    ld a, c
    and a, a
    jr nz, Jump_0E2_4BB4
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4BB4::
    farcall ActorLacksStatus4Bits45
    ld a, c
    and a, a
    jr nz, Jump_0E2_4BC4
    ld bc, $004D
    call AccumulateBank6WordToDA6E

Jump_0E2_4BC4::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_4BD4
    ld bc, $006A
    call AccumulateBank6WordToDA6E

Jump_0E2_4BD4::
    farcall InvertedResultOfFunc4E48
    ld a, c
    and a, a
    jr nz, Jump_0E2_4BE4
    ld bc, $000D
    call AccumulateBank6WordToDA6E

Jump_0E2_4BE4::
    call WeighWD044RuleBit3
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_4BF7
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_4BF7::
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4C0B
    and a, a
    jr nz, Jump_0E2_4C0B
    ld bc, $004A
    call AccumulateBank6WordToDA70

Jump_0E2_4C0B::
    farcall AnyAllyLacksStatus2Bit2_5D31
    ld a, c
    and a, a
    jr nz, Jump_0E2_4C1B
    ld bc, $004E
    call AccumulateBank6WordToDA70

Jump_0E2_4C1B::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4C2F
    and a, a
    jr nz, Jump_0E2_4C2F
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_4C2F::
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
    jr nz, AIScore_Vacuum_Sub01
    ld bc, $0010
    call AccumulateBank6WordToDA70

; only called from AIScore_Vacuum (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Vacuum)
AIScore_Vacuum_Sub01::
Func_0E2_4C49:: ; address name
    farcall CheckLoneFoeHPNotBelowWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_4C59
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_4C59::
    farcall FailIfFoeWD2C1AtLeastEstimate
    ld a, c
    and a, a
    jr nz, Jump_0E2_4C69
    ld bc, $000A
    call AccumulateBank6WordToDA70

Jump_0E2_4C69::
    farcall Func_005_5052
    ld a, c
    and a, a
    jr nz, Jump_0E2_4C79
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4C79::
    farcall InvertedResultOfFunc4E48
    ld a, c
    and a, a
    jr nz, Jump_0E2_4C89
    ld bc, $000D
    call AccumulateBank6WordToDA6E

Jump_0E2_4C89::
    call WeighWD044RuleBit1
    farcall FailIfFoeHPAtLeast150PercentOfActor
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4CA0
    and a, a
    jr nz, Jump_0E2_4CA0
    ld bc, $004F
    call AccumulateBank6WordToDA6E

Jump_0E2_4CA0::
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 73 Vacuum, 74 Lightning. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Vacuum:: ; heuristic: follows a terminator; C0
Func_0E2_4CA1:: ; address name
    farcall AIAttackSkillUsable_74D1
    ld a, c
    and a, a
    ret z
    call AIScore_Vacuum_Sub01
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_4CBD
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_4CBD::
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4CD1
    and a, a
    jr nz, Jump_0E2_4CD1
    ld bc, $004A
    call AccumulateBank6WordToDA70

Jump_0E2_4CD1::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4CE5
    and a, a
    jr nz, Jump_0E2_4CE5
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_4CE5::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 75 RockThrow. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_RockThrow:: ; heuristic: follows a terminator; C0
Func_0E2_4CE6:: ; address name
    farcall AIFunc74D1AndFoeLacksStatus3And4
    ld a, c
    and a, a
    ret z
    farcall CheckLoneFoeHPNotBelowWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_4CFF
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_4CFF::
    farcall FailIfFoeWD2C1AtLeastEstimate
    ld a, c
    and a, a
    jr nz, Jump_0E2_4D0F
    ld bc, $000A
    call AccumulateBank6WordToDA70

Jump_0E2_4D0F::
    farcall Func_005_5052
    ld a, c
    and a, a
    jr nz, Jump_0E2_4D1F
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4D1F::
    farcall InvertedResultOfFunc4E48
    ld a, c
    and a, a
    jr nz, Jump_0E2_4D2F
    ld bc, $000D
    call AccumulateBank6WordToDA6E

Jump_0E2_4D2F::
    call WeighWD044RuleBit1
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_4D42
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_4D42::
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4D56
    and a, a
    jr nz, Jump_0E2_4D56
    ld bc, $004A
    call AccumulateBank6WordToDA70

Jump_0E2_4D56::
    farcall CheckActorSlot0To3OrWC58ASet
    ld a, c
    and a, a
    jr nz, Jump_0E2_4D66
    ld bc, $006B
    call AccumulateBank6WordToDA70

Jump_0E2_4D66::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4D7A
    and a, a
    jr nz, Jump_0E2_4D7A
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_4D7A::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 76 Watershot. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Watershot:: ; heuristic: follows a terminator; C0
Func_0E2_4D7B:: ; address name
    farcall AIFunc74D1AndFoeLacksStatus3And4
    ld a, c
    and a, a
    ret z
    farcall CheckLoneFoeHPNotBelowWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_4D94
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_4D94::
    farcall FailIfFoeWD2C1AtLeastEstimate
    ld a, c
    and a, a
    jr nz, Jump_0E2_4DA4
    ld bc, $000D
    call AccumulateBank6WordToDA70

Jump_0E2_4DA4::
    farcall Func_005_5052
    ld a, c
    and a, a
    jr nz, Jump_0E2_4DB4
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4DB4::
    farcall InvertedResultOfFunc4E48
    ld a, c
    and a, a
    jr nz, Jump_0E2_4DC4
    ld bc, $000D
    call AccumulateBank6WordToDA6E

Jump_0E2_4DC4::
    call WeighWD044RuleBit1
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_4DD7
    ld bc, $0010
    call AccumulateBank6WordToDA70

Jump_0E2_4DD7::
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4DEB
    and a, a
    jr nz, Jump_0E2_4DEB
    ld bc, $004A
    call AccumulateBank6WordToDA70

Jump_0E2_4DEB::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 77 Tidalwave. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Tidalwave:: ; heuristic: follows a terminator; C0
Func_0E2_4DEC:: ; address name
    farcall AIFunc74D1AndFoeLacksStatus3And4
    ld a, c
    and a, a
    ret z
    farcall CheckLoneFoeHPNotBelowWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_4E05
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_4E05::
    farcall FailIfFoeWD2C1AtLeastEstimate
    ld a, c
    and a, a
    jr nz, Jump_0E2_4E15
    ld bc, $000A
    call AccumulateBank6WordToDA70

Jump_0E2_4E15::
    farcall Func_005_5052
    ld a, c
    and a, a
    jr nz, Jump_0E2_4E25
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4E25::
    farcall InvertedResultOfFunc4E48
    ld a, c
    and a, a
    jr nz, Jump_0E2_4E35
    ld bc, $000D
    call AccumulateBank6WordToDA6E

Jump_0E2_4E35::
    call WeighWD044RuleBit1
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_4E48
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_4E48::
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4E5C
    and a, a
    jr nz, Jump_0E2_4E5C
    ld bc, $004A
    call AccumulateBank6WordToDA70

Jump_0E2_4E5C::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4E70
    and a, a
    jr nz, Jump_0E2_4E70
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_4E70::
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 78 CallHelp, 79 YellHelp. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_CallHelp:: ; heuristic: follows a terminator; C0
Func_0E2_4E71:: ; address name
    farcall AIFunc74D1AndFoeLacksStatus3And4
    ld a, c
    and a, a
    ret z
    farcall CheckLoneFoeHPNotBelowWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_4E8A
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_4E8A::
    farcall FailIfFoeWD2C1AtLeastEstimate
    ld a, c
    and a, a
    jr nz, Jump_0E2_4E9A
    ld bc, $0008
    call AccumulateBank6WordToDA70

Jump_0E2_4E9A::
    farcall Func_005_5052
    ld a, c
    and a, a
    jr nz, Jump_0E2_4EAA
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4EAA::
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_4EBA
    ld bc, $000A
    call AccumulateBank6WordToDA70

Jump_0E2_4EBA::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_4ED0
    ld bc, $00BE
    call AccumulateBank6WordToDA70
    ld bc, $00C5
    call AccumulateBank6WordToDA6E

Jump_0E2_4ED0::
    farcall InvertedResultOfFunc4E48
    ld a, c
    and a, a
    jr nz, Jump_0E2_4EE0
    ld bc, $000D
    call AccumulateBank6WordToDA6E

Jump_0E2_4EE0::
    call WeighWD044RuleBit1
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_4EF3
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_4EF3::
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4F07
    and a, a
    jr nz, Jump_0E2_4F07
    ld bc, $004A
    call AccumulateBank6WordToDA70

Jump_0E2_4F07::
    farcall FailIfFoeHPAtLeast150PercentOfActor
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4F1B
    and a, a
    jr nz, Jump_0E2_4F1B
    ld bc, $004F
    call AccumulateBank6WordToDA6E

Jump_0E2_4F1B::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4F2F
    and a, a
    jr nz, Jump_0E2_4F2F
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_4F2F::
    ret

; AI scoring routine for 4 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 80 FireSlash, 81 VacuSlash, 82 BoltSlash, 83 IceSlash. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_FireSlash:: ; heuristic: follows a terminator; C0
Func_0E2_4F30:: ; address name
    farcall AIFunc74D1AndFoeLacksStatus3And4
    ld a, c
    and a, a
    ret z
    farcall CheckLoneFoeHPNotBelowWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_4F49
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_4F49::
    farcall CheckFoeStatus7Bit2
    ld a, c
    cp a, $01
    jr z, Jump_0E2_4F5D
    and a, a
    jr nz, Jump_0E2_4F5D
    ld bc, $0003
    call AccumulateBank6WordToDA70

Jump_0E2_4F5D::
    farcall FailIfFoeWD2C1AtLeastEstimate
    ld a, c
    and a, a
    jr nz, Jump_0E2_4F6D
    ld bc, $0008
    call AccumulateBank6WordToDA70

Jump_0E2_4F6D::
    farcall Func_005_5052
    ld a, c
    and a, a
    jr nz, Jump_0E2_4F7D
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_4F7D::
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_4F8D
    ld bc, $0055
    call AccumulateBank6WordToDA6E

Jump_0E2_4F8D::
    farcall InvertedResultOfFunc4E48
    ld a, c
    and a, a
    jr nz, Jump_0E2_4F9D
    ld bc, $000D
    call AccumulateBank6WordToDA6E

Jump_0E2_4F9D::
    call WeighWD044RuleBit1
    farcall CheckWCFC5AtLeast2OrWC58ASet
    ld a, c
    and a, a
    jr nz, Jump_0E2_4FB0
    ld bc, $0066
    call AccumulateBank6WordToDA6E

Jump_0E2_4FB0::
    farcall FailIfFoeHPBelowFourTimesWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_4FC0
    ld bc, $0067
    call AccumulateBank6WordToDA6E

Jump_0E2_4FC0::
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a, a
    jr nz, Jump_0E2_4FD0
    ld bc, $0005
    call AccumulateBank6WordToDA6E

Jump_0E2_4FD0::
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_4FE0
    ld bc, $0033
    call AccumulateBank6WordToDA70

Jump_0E2_4FE0::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 84 SlimeBlow. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_SlimeBlow:: ; heuristic: follows a terminator; C0
Func_0E2_4FE1:: ; address name
    farcall AIScore_SlimeBlow_Sub01
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E

Jump_0E2_4FF0::
    farcall CheckLoneFoeHPNotBelowWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_5000
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_5000::
    farcall CheckFoeStatus7Bit2
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5014
    and a, a
    jr nz, Jump_0E2_5014
    ld bc, $0003
    call AccumulateBank6WordToDA70

Jump_0E2_5014::
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_5024
    ld bc, $0053
    call AccumulateBank6WordToDA6E

Jump_0E2_5024::
    call WeighWD044RuleBit1
    farcall CheckWCFC5AtLeast2OrWC58ASet
    ld a, c
    and a, a
    jr nz, Jump_0E2_5037
    ld bc, $0066
    call AccumulateBank6WordToDA6E

Jump_0E2_5037::
    farcall FailIfFoeHPBelowFourTimesWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_5067
    ld bc, $0067
    call AccumulateBank6WordToDA6E
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a, a
    jr nz, Jump_0E2_5057
    ld bc, $0005
    call AccumulateBank6WordToDA6E

Jump_0E2_5057::
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_5067
    ld bc, $0033
    call AccumulateBank6WordToDA70

Jump_0E2_5067::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 85 DrakSlash. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_DrakSlash:: ; heuristic: follows a terminator; C0
Func_0E2_5068:: ; address name
    farcall AIScore_DrakSlash_Sub01
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp Jump_0E2_4FF0

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 86 BeastCut. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_BeastCut:: ; heuristic: follows a terminator; C0
Func_0E2_507A:: ; address name
    farcall AIScore_BeastCut_Sub01
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp Jump_0E2_4FF0

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 87 BirdBlow. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_BirdBlow:: ; heuristic: follows a terminator; C0
Func_0E2_508C:: ; address name
    farcall AIScore_BirdBlow_Sub01
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp Jump_0E2_4FF0

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 88 BugBlow. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_BugBlow:: ; heuristic: follows a terminator; C0
Func_0E2_509E:: ; address name
    farcall AIScore_BugBlow_Sub01
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp Jump_0E2_4FF0

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 89 Shears. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Shears:: ; heuristic: follows a terminator; C0
Func_0E2_50B0:: ; address name
    farcall AIScore_Shears_Sub01
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp Jump_0E2_4FF0

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 90 DevilCut. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_DevilCut:: ; heuristic: follows a terminator; C0
Func_0E2_50C2:: ; address name
    farcall AIScore_DevilCut_Sub01
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp Jump_0E2_4FF0

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 91 ZombieCut. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_ZombieCut:: ; heuristic: follows a terminator; C0
Func_0E2_50D4:: ; address name
    farcall AIScore_ZombieCut_Sub01
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp Jump_0E2_4FF0

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 92 CleanCut. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_CleanCut:: ; heuristic: follows a terminator; C0
Func_0E2_50E6:: ; address name
    farcall AIScore_CleanCut_Sub01
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp Jump_0E2_4FF0

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 93 AquaCut. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_AquaCut:: ; heuristic: follows a terminator; C0
Func_0E2_50F8:: ; address name
    farcall AIScore_AquaCut_Sub01
    ld a, c
    and a, a
    ret z
    ld bc, $0052
    call AccumulateBank6WordToDA6E
    jp Jump_0E2_4FF0

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 94 MetalCut. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_MetalCut:: ; heuristic: follows a terminator; C0
Func_0E2_510A:: ; address name
    farcall AIScore_MetalCut_Sub01
    ld a, c
    and a, a
    ret z
    ld bc, $0053
    call AccumulateBank6WordToDA6E
    jp Jump_0E2_4FF0

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 95 PoisonHit. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_PoisonHit:: ; heuristic: follows a terminator; C0
Func_0E2_511C:: ; address name
    farcall AIScore_PoisonHit_Sub01
    ld a, c
    and a, a
    ret z
    ld bc, $0054
    call AccumulateBank6WordToDA6E

Jump_0E2_512B::
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_513B
    ld bc, $0055
    call AccumulateBank6WordToDA6E

Jump_0E2_513B::
    call WeighWD044RuleBit1
    farcall CheckWCFC5AtLeast2OrWC58ASet
    ld a, c
    and a, a
    jr nz, Jump_0E2_514E
    ld bc, $0066
    call AccumulateBank6WordToDA6E

Jump_0E2_514E::
    farcall FailIfFoeHPBelowFourTimesWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_515E
    ld bc, $0067
    call AccumulateBank6WordToDA6E

Jump_0E2_515E::
    farcall CheckActorSlot0To3OrWC58ASet
    ld a, c
    and a, a
    jr nz, Jump_0E2_516E
    ld bc, $0039
    call AccumulateBank6WordToDA70

Jump_0E2_516E::
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a, a
    jr nz, Jump_0E2_517E
    ld bc, $0005
    call AccumulateBank6WordToDA6E

Jump_0E2_517E::
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_518E
    ld bc, $0033
    call AccumulateBank6WordToDA70

Jump_0E2_518E::
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_51A2
    and a, a
    jr nz, Jump_0E2_51A2
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_51A2::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_51B6
    and a, a
    jr nz, Jump_0E2_51B6
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_51B6::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 96 Paralyze. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Paralyze:: ; heuristic: follows a terminator; C0
Func_0E2_51B7:: ; address name
    farcall AIScore_Paralyze_Sub01
    ld a, c
    and a, a
    ret z
    ld bc, $0054
    call AccumulateBank6WordToDA6E
    jp Jump_0E2_512B

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 97 NapAttack. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_NapAttack:: ; heuristic: follows a terminator; C0
Func_0E2_51C9:: ; address name
    farcall AIScore_NapAttack_Sub01
    ld a, c
    and a, a
    ret z
    ld bc, $0054
    call AccumulateBank6WordToDA6E
    jp Jump_0E2_512B

; table-B AI score: AIScore_SquallHit, then adds a penalty word when the follow-up check fails (E-0122)
; no direct call (reached through a table, a jump or a vector)
AIScoreB_SquallHit:: ; heuristic: follows a terminator; C0
Func_0E2_51DB:: ; address name
    call AIScore_SquallHit
    ld a, c
    and a, a
    ret z
    farcall Func_005_604C
    ld a, c
    cp a, $01
    jr z, Jump_0E2_51F5
    and a, a
    jr nz, Jump_0E2_51F5
    ld bc, $00B4
    call AccumulateBank6WordToDA6E

Jump_0E2_51F5::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 98 SquallHit. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; 1 call site from 1 routine (e.g. AIScoreB_SquallHit)
AIScore_SquallHit::
Func_0E2_51F6:: ; address name
    farcall AIScore_SquallHit_Sub01
    ld a, c
    and a, a
    ret z
    call MaxNegativeScoreWhenWD2CCBit0
    ret z
    farcall CheckLoneFoeHPNotBelowWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_5213
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_5213::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5223
    ld bc, $00C8
    call AccumulateBank6WordToDA70

Jump_0E2_5223::
    call WeighWD044RuleBit1
    farcall FailIfFoeHPAtMostFourFifthsWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_5236
    ld bc, $0056
    call AccumulateBank6WordToDA6E

Jump_0E2_5236::
    farcall Func_005_604C
    ld a, c
    cp a, $01
    jr z, Jump_0E2_524A
    and a, a
    jr nz, Jump_0E2_524A
    ld bc, $00B4
    call AccumulateBank6WordToDA6E

Jump_0E2_524A::
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a, a
    jr nz, Jump_0E2_525A
    ld bc, $0005
    call AccumulateBank6WordToDA6E

Jump_0E2_525A::
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_526A
    ld bc, $0033
    call AccumulateBank6WordToDA70

Jump_0E2_526A::
    ld c, $01
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 99 BiAttack, 100 QuadHits. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_BiAttack:: ; heuristic: follows a terminator; C0
Func_0E2_526D:: ; address name
    farcall AIScore_BiAttack_Sub02
    ld a, c
    and a, a
    ret z
    farcall CheckLoneFoeHPNotBelowWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_5286
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_5286::
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_5296
    ld bc, $0005
    call AccumulateBank6WordToDA6E

Jump_0E2_5296::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_52A6
    ld bc, $00C8
    call AccumulateBank6WordToDA70

Jump_0E2_52A6::
    call WeighWD044RuleBit1
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_52B9
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_52B9::
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp a, $01
    jr z, Jump_0E2_52CD
    and a, a
    jr nz, Jump_0E2_52CD
    ld bc, $004A
    call AccumulateBank6WordToDA70

Jump_0E2_52CD::
    farcall FailIfFoeHPAtMostFourFifthsWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_52DD
    ld bc, $0056
    call AccumulateBank6WordToDA6E

Jump_0E2_52DD::
    farcall AIScore_BiAttack_Sub01
    ld a, c
    and a, a
    jr nz, Jump_0E2_52ED
    ld bc, $0056
    call AccumulateBank6WordToDA6E

Jump_0E2_52ED::
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a, a
    jr nz, Jump_0E2_52FD
    ld bc, $0005
    call AccumulateBank6WordToDA6E

Jump_0E2_52FD::
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_530D
    ld bc, $0033
    call AccumulateBank6WordToDA70

Jump_0E2_530D::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 101 RainSlash. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_RainSlash:: ; heuristic: follows a terminator; C0
Func_0E2_530E:: ; address name
    farcall AIScore_RainSlash_Sub01
    ld a, c
    and a, a
    ret z
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_5327
    ld bc, $0005
    call AccumulateBank6WordToDA6E

Jump_0E2_5327::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_533D
    ld bc, $00C3
    call AccumulateBank6WordToDA6E
    ld bc, $00CB
    call AccumulateBank6WordToDA70

Jump_0E2_533D::
    call WeighWD044RuleBit1
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_5350
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_5350::
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5364
    and a, a
    jr nz, Jump_0E2_5364
    ld bc, $004A
    call AccumulateBank6WordToDA70

Jump_0E2_5364::
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a, a
    jr nz, Jump_0E2_5374
    ld bc, $0005
    call AccumulateBank6WordToDA6E

Jump_0E2_5374::
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_5384
    ld bc, $0033
    call AccumulateBank6WordToDA70

Jump_0E2_5384::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 102 MultiCut. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_MultiCut:: ; heuristic: follows a terminator; C0
Func_0E2_5385:: ; address name
    farcall AIScore_MultiCut_Sub01
    ld a, c
    and a, a
    ret z
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_53A2
    and a, a
    jr nz, Jump_0E2_53A2
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_53A2::
    farcall CheckLoneFoeHPNotBelowWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_53B2
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_53B2::
    farcall FailIfFoeWD2C1AtLeastEstimate
    ld a, c
    and a, a
    jr nz, Jump_0E2_53C2
    ld bc, $000A
    call AccumulateBank6WordToDA70

Jump_0E2_53C2::
    farcall Func_005_5052
    ld a, c
    and a, a
    jr nz, Jump_0E2_53D2
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_53D2::
    farcall InvertedResultOfFunc4E48
    ld a, c
    and a, a
    jr nz, Jump_0E2_53E2
    ld bc, $000D
    call AccumulateBank6WordToDA6E

Jump_0E2_53E2::
    call WeighWD044RuleBit1
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_53F5
    ld bc, $0057
    call AccumulateBank6WordToDA6E

Jump_0E2_53F5::
    farcall CheckFoeStatus6Bit3
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5409
    and a, a
    jr nz, Jump_0E2_5409
    ld bc, $004A
    call AccumulateBank6WordToDA70

Jump_0E2_5409::
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
    jr nz, Jump_0E2_5423
    ld bc, $0033
    call AccumulateBank6WordToDA70

Jump_0E2_5423::
    jp Jump_0E2_53A2

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 104 ChargeUp. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_ChargeUp:: ; heuristic: follows a terminator; C0
Func_0E2_5426:: ; address name
    farcall AIScore_ChargeUp_Sub01
    ld a, c
    and a, a
    ret z
    farcall Func_005_50E3
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5443
    and a, a
    jr nz, Jump_0E2_5443
    ld bc, $0058
    call AccumulateBank6WordToDA6E

Jump_0E2_5443::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5459
    ld bc, $00BA
    call AccumulateBank6WordToDA6E
    ld bc, $00BF
    call AccumulateBank6WordToDA70

Jump_0E2_5459::
    call WeighWD044RuleBit1
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 105 PsycheUp. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_PsycheUp:: ; heuristic: follows a terminator; C0
Func_0E2_545D:: ; address name
    farcall AIScore_PsycheUp_Sub01
    ld a, c
    and a, a
    ret z
    farcall Func_005_4B97
    ld a, c
    and a, a
    jr nz, Jump_0E2_5476
    ld bc, $002D
    call AccumulateBank6WordToDA70

Jump_0E2_5476::
    farcall CheckLoneFoeHPNotBelowWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_5486
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_5486::
    farcall AllyAverageAGLAtLeastFoes
    ld a, c
    cp a, $01
    jr z, Jump_0E2_549A
    and a, a
    jr nz, Jump_0E2_549A
    ld bc, $002C
    call AccumulateBank6WordToDA6E

Jump_0E2_549A::
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_54AA
    ld bc, $000A
    call AccumulateBank6WordToDA70

Jump_0E2_54AA::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_54C0
    ld bc, $00BA
    call AccumulateBank6WordToDA6E
    ld bc, $00BF
    call AccumulateBank6WordToDA70

Jump_0E2_54C0::
    call WeighWD044RuleBit1
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 106 HighJump. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_HighJump:: ; heuristic: follows a terminator; C0
Func_0E2_54C4:: ; address name
    farcall AIScore_HighJump_Sub01
    ld a, c
    and a, a
    ret z
    farcall CheckLoneFoeHPNotBelowWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_54DD
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_54DD::
    farcall Func_005_50E3
    ld a, c
    cp a, $01
    jr z, Jump_0E2_54F1
    and a, a
    jr nz, Jump_0E2_54F1
    ld bc, $0058
    call AccumulateBank6WordToDA70

Jump_0E2_54F1::
    farcall Func_005_517D
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5505
    and a, a
    jr nz, Jump_0E2_5505
    ld bc, $0059
    call AccumulateBank6WordToDA70

Jump_0E2_5505::
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_5515
    ld bc, $000A
    call AccumulateBank6WordToDA70

Jump_0E2_5515::
    call WeighWD044RuleBit1
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_5528
    ld bc, $0033
    call AccumulateBank6WordToDA70

Jump_0E2_5528::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 107 EvilSlash. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_EvilSlash:: ; heuristic: follows a terminator; C0
Func_0E2_5529:: ; address name
    farcall CheckSkillUsableElseResetWDA6E
    ld a, c
    and a, a
    ret z
    farcall AnyFoeNotBlocked
    ld a, c
    and a, a
    jr nz, Jump_0E2_5542
    ld bc, $005A
    call AccumulateBank6WordToDA6E

Jump_0E2_5542::
    farcall AnyFoeHasClearStatus3
    ld a, c
    and a, a
    jr nz, Jump_0E2_5552
    ld bc, $005B
    call AccumulateBank6WordToDA6E

Jump_0E2_5552::
    farcall CheckLoneFoeHPNotBelowWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_5562
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_5562::
    farcall Func_005_50E3
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5576
    and a, a
    jr nz, Jump_0E2_5576
    ld bc, $0058
    call AccumulateBank6WordToDA6E

Jump_0E2_5576::
    farcall Func_005_517D
    ld a, c
    cp a, $01
    jr z, Jump_0E2_558A
    and a, a
    jr nz, Jump_0E2_558A
    ld bc, $0059
    call AccumulateBank6WordToDA6E

Jump_0E2_558A::
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_559A
    ld bc, $005C
    call AccumulateBank6WordToDA70

Jump_0E2_559A::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_55AA
    ld bc, $00BD
    call AccumulateBank6WordToDA6E

Jump_0E2_55AA::
    call WeighWD044RuleBit1
    farcall AIScore_EvilSlash_Sub01
    ld a, c
    and a, a
    jr nz, Jump_0E2_55BD
    ld bc, $00B0
    call AccumulateBank6WordToDA6E

Jump_0E2_55BD::
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_55CD
    ld bc, $0033
    call AccumulateBank6WordToDA70

Jump_0E2_55CD::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 108 Massacre. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Massacre:: ; heuristic: follows a terminator; C0
Func_0E2_55CE:: ; address name
    farcall CheckSkillUsableElseResetWDA6E
    ld a, c
    and a, a
    ret z
    farcall AtLeastTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_55E7
    ld bc, $0011
    call AccumulateBank6WordToDA70

Jump_0E2_55E7::
    farcall CheckLoneFoeHPNotBelowWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_55F7
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_55F7::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5607
    ld bc, $00C4
    call AccumulateBank6WordToDA6E

Jump_0E2_5607::
    call WeighWD044RuleBit1
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_561A
    ld bc, $0033
    call AccumulateBank6WordToDA70

Jump_0E2_561A::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 109 TwinSlash. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_TwinSlash:: ; heuristic: follows a terminator; C0
Func_0E2_561B:: ; address name
    farcall AIScore_TwinSlash_Sub01
    ld a, c
    and a, a
    ret z
    farcall AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr nz, Jump_0E2_5634
    ld bc, $005E
    call AccumulateBank6WordToDA70

Jump_0E2_5634::
    farcall CheckLoneFoeHPNotBelowWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_5644
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_5644::
    farcall Func_005_50E3
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5658
    and a, a
    jr nz, Jump_0E2_5658
    ld bc, $005F
    call AccumulateBank6WordToDA70

Jump_0E2_5658::
    farcall Func_005_517D
    ld a, c
    cp a, $01
    jr z, Jump_0E2_566C
    and a, a
    jr nz, Jump_0E2_566C
    ld bc, $005F
    call AccumulateBank6WordToDA70

Jump_0E2_566C::
    farcall ActorHPIsNotOne
    ld a, c
    and a, a
    jr nz, Jump_0E2_567C
    ld bc, $0060
    call AccumulateBank6WordToDA70

Jump_0E2_567C::
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_568C
    ld bc, $005C
    call AccumulateBank6WordToDA70

Jump_0E2_568C::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_56A2
    ld bc, $00C7
    call AccumulateBank6WordToDA6E
    ld bc, $00D0
    call AccumulateBank6WordToDA70

Jump_0E2_56A2::
    call WeighWD044RuleBit1
    farcall AllyCheckWC984AndOtherSlots
    ld a, c
    and a, a
    jr nz, Jump_0E2_56B5
    ld bc, $0062
    call AccumulateBank6WordToDA70

Jump_0E2_56B5::
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_56C5
    ld bc, $0033
    call AccumulateBank6WordToDA70

Jump_0E2_56C5::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 110 Berserker. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Berserker:: ; heuristic: follows a terminator; C0
Func_0E2_56C6:: ; address name
    farcall AIAttackSkillUsable_779F
    ld a, c
    and a, a
    ret z
    call MaxNegativeScoreWhenWD2CCBit0
    ret z
    farcall AnyFoeNotBlocked
    ld a, c
    and a, a
    jr nz, Jump_0E2_56E3
    ld bc, $005A
    call AccumulateBank6WordToDA6E

Jump_0E2_56E3::
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a, a
    jr nz, Jump_0E2_56F3
    ld bc, $0017
    call AccumulateBank6WordToDA70

Jump_0E2_56F3::
    farcall CheckLoneFoeHPNotBelowWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_5703
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_5703::
    farcall Func_005_50E3
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5717
    and a, a
    jr nz, Jump_0E2_5717
    ld bc, $005F
    call AccumulateBank6WordToDA70

Jump_0E2_5717::
    farcall Func_005_517D
    ld a, c
    cp a, $01
    jr z, Jump_0E2_572B
    and a, a
    jr nz, Jump_0E2_572B
    ld bc, $005F
    call AccumulateBank6WordToDA70

Jump_0E2_572B::
    farcall ActorHPIsNotOne
    ld a, c
    and a, a
    jr nz, Jump_0E2_573B
    ld bc, $0060
    call AccumulateBank6WordToDA70

Jump_0E2_573B::
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_574B
    ld bc, $005C
    call AccumulateBank6WordToDA70

Jump_0E2_574B::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5761
    ld bc, $00C7
    call AccumulateBank6WordToDA6E
    ld bc, $00D0
    call AccumulateBank6WordToDA70

Jump_0E2_5761::
    call WeighWD044RuleBit1
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a, a
    jr nz, Jump_0E2_5774
    ld bc, $0063
    call AccumulateBank6WordToDA70

Jump_0E2_5774::
    farcall AllyCheckWC984AndOtherSlots
    ld a, c
    and a, a
    jr nz, Jump_0E2_5784
    ld bc, $005F
    call AccumulateBank6WordToDA70

Jump_0E2_5784::
    farcall AIScore_Berserker_Sub01
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5798
    and a, a
    jr nz, Jump_0E2_5798
    ld bc, $0064
    call AccumulateBank6WordToDA6E

Jump_0E2_5798::
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_57A8
    ld bc, $0033
    call AccumulateBank6WordToDA70

Jump_0E2_57A8::
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
    jr nz, Jump_0E2_57C2
    ld bc, $005E
    call AccumulateBank6WordToDA70

Jump_0E2_57C2::
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a, a
    jr nz, Jump_0E2_57D2
    ld bc, $0017
    call AccumulateBank6WordToDA70

Jump_0E2_57D2::
    farcall AIScore_Ramming_Sub01
    ld a, c
    cp a, $01
    jr z, Jump_0E2_57E6
    and a, a
    jr nz, Jump_0E2_57E6
    ld bc, $0064
    call AccumulateBank6WordToDA6E

Jump_0E2_57E6::
    farcall CheckLoneFoeHPNotBelowWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_57F6
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_57F6::
    farcall Func_005_5052
    ld a, c
    and a, a
    jr nz, Jump_0E2_5806
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5806::
    ld a, [wBattleActor]
    call AIScore_Ramming_Sub02
    farcall ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_581C
    ld bc, $005C
    call AccumulateBank6WordToDA70

Jump_0E2_581C::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5832
    ld bc, $00C7
    call AccumulateBank6WordToDA6E
    ld bc, $00D0
    call AccumulateBank6WordToDA70

Jump_0E2_5832::
    call WeighWD044RuleBit1
    farcall AllyCheckWC984AndOtherSlots
    ld a, c
    and a, a
    jr nz, Jump_0E2_5845
    ld bc, $005F
    call AccumulateBank6WordToDA70

Jump_0E2_5845::
    farcall ActorLacksStatus2Bit1And4Bits01
    ld a, c
    and a, a
    jr nz, Jump_0E2_5855
    ld bc, $0033
    call AccumulateBank6WordToDA70

Jump_0E2_5855::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 112 Kamikaze. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
AIScore_Kamikaze:: ; heuristic: follows a terminator; C0
Func_0E2_5856:: ; address name
    farcall AIScore_Kamikaze_Sub02
    ld a, c
    and a, a
    ret z
    farcall AIScore_Kamikaze_Sub01
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5873
    and a, a
    jr nz, Jump_0E2_5873
    ld bc, $0064
    call AccumulateBank6WordToDA6E

Jump_0E2_5873::
    jp Jump_0E2_57E6

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 113 SleepAir. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_SleepAir:: ; heuristic: follows a terminator; C0
Func_0E2_5876:: ; address name
    farcall AIScore_SleepAir_Sub01
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_588F
    ld bc, $00BC
    call AccumulateBank6WordToDA70

Jump_0E2_588F::
    call WeighWD044RuleBit3

Jump_0E2_5892::
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_58A2
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_58A2::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_58B6
    and a, a
    jr nz, Jump_0E2_58B6
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_58B6::
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_58CA
    and a, a
    jr nz, Jump_0E2_58CA
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_58CA::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_58DE
    and a, a
    jr nz, Jump_0E2_58DE
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_58DE::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 114 PalsyAir. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_PalsyAir:: ; heuristic: follows a terminator; C0
Func_0E2_58DF:: ; address name
    farcall AIScore_PalsyAir_Sub01
    ld a, c
    and a, a
    ret z
    jr Jump_0E2_588F

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 115 PoisonGas. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_PoisonGas:: ; heuristic: follows a terminator; C0
Func_0E2_58EA:: ; address name
    farcall AIScore_PoisonGas_Sub01
    ld a, c
    and a, a
    ret z
    jr Jump_0E2_588F

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 116 PoisonAir. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_PoisonAir:: ; heuristic: follows a terminator; C0
Func_0E2_58F5:: ; address name
    farcall AIScore_PoisonAir_Sub01
    ld a, c
    and a, a
    ret z
    jr Jump_0E2_588F

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 117 Curse. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Curse:: ; heuristic: follows a terminator; C0
Func_0E2_5900:: ; address name
    farcall AIScore_Curse_Sub01
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5919
    ld bc, $00BD
    call AccumulateBank6WordToDA70

Jump_0E2_5919::
    call WeighWD044RuleBit5
    jp Jump_0E2_5892

; AI scoring routine for 2 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 118 OddDance, 119 RobDance. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_OddDance:: ; heuristic: follows a terminator; C0
Func_0E2_591F:: ; address name
    farcall AIScore_OddDance_Sub01
    ld a, c
    and a, a
    ret z
    ld bc, $0009
    call AccumulateBank6WordToDA6E
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5944
    ld bc, $00C2
    call AccumulateBank6WordToDA70
    ld bc, $00D2
    call AccumulateBank6WordToDA6E

Jump_0E2_5944::
    call WeighWD044RuleBit2
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_595B
    and a, a
    jr nz, Jump_0E2_595B
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_595B::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_596F
    and a, a
    jr nz, Jump_0E2_596F
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_596F::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 120 PaniDance. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_PaniDance:: ; heuristic: follows a terminator; C0
Func_0E2_5970:: ; address name
    farcall AIScore_PaniDance_Sub01
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5995
    ld bc, $00C2
    call AccumulateBank6WordToDA70
    ld bc, $00CA
    call AccumulateBank6WordToDA6E
    ld bc, $00D2
    call AccumulateBank6WordToDA6E

Jump_0E2_5995::
    call WeighWD044RuleBit2
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_59A8
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_59A8::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_59BC
    and a, a
    jr nz, Jump_0E2_59BC
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_59BC::
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_59D0
    and a, a
    jr nz, Jump_0E2_59D0
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_59D0::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_59E4
    and a, a
    jr nz, Jump_0E2_59E4
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_59E4::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 121 K.O.Dance. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_KODance:: ; heuristic: follows a terminator; C0
Func_0E2_59E5:: ; address name
    farcall AIScore_KODance_Sub01
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5A04
    ld bc, $00CD
    call AccumulateBank6WordToDA6E
    ld bc, $00CF
    call AccumulateBank6WordToDA70

Jump_0E2_5A04::
    call WeighWD044RuleBit2
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_5A17
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_5A17::
    farcall AIGateFoeWDA74Bits45
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5A2B
    and a, a
    jr nz, Jump_0E2_5A2B
    ld bc, $00B5
    call AccumulateBank6WordToDA6E

Jump_0E2_5A2B::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5A3F
    and a, a
    jr nz, Jump_0E2_5A3F
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_5A3F::
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5A53
    and a, a
    jr nz, Jump_0E2_5A53
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5A53::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5A67
    and a, a
    jr nz, Jump_0E2_5A67
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5A67::
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
    farcall AIScore_LureDance_Sub01
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5A91
    ld bc, $00C2
    call AccumulateBank6WordToDA70
    ld bc, $00D2
    call AccumulateBank6WordToDA6E

Jump_0E2_5A91::
    call WeighWD044RuleBit2
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_5AA4
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_5AA4::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5AB8
    and a, a
    jr nz, Jump_0E2_5AB8
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_5AB8::
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5ACC
    and a, a
    jr nz, Jump_0E2_5ACC
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5ACC::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5AE0
    and a, a
    jr nz, Jump_0E2_5AE0
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5AE0::
    call AIAddScoresFor5ECEAnd5FC7
    ld c, $01
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 123 LifeDance. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_LifeDance:: ; heuristic: follows a terminator; C0
Func_0E2_5AE6:: ; address name
    farcall AIScore_LifeDance_Sub01
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5B05
    ld bc, $00BC
    call AccumulateBank6WordToDA6E
    ld bc, $00C4
    call AccumulateBank6WordToDA70

Jump_0E2_5B05::
    call WeighWD044RuleBit2
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a, a
    jr nz, Jump_0E2_5B18
    ld bc, $0029
    call AccumulateBank6WordToDA6E

Jump_0E2_5B18::
    farcall PassIfWC984OrAllySlotEmpty
    ld a, c
    and a, a
    jr nz, Jump_0E2_5B28
    ld bc, $0029
    call AccumulateBank6WordToDA6E

Jump_0E2_5B28::
    farcall Func_005_667F
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5B3C
    and a, a
    jr nz, Jump_0E2_5B3C
    ld bc, $002E
    call AccumulateBank6WordToDA70

Jump_0E2_5B3C::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 124 Hustle. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
AIScore_Hustle:: ; heuristic: follows a terminator; C0
Func_0E2_5B3D:: ; address name
    farcall AIScore_Hustle_Sub01
    ld a, c
    and a, a
    ret z
    ld a, [wBattleActor]
    call ForEachPresentSlotOfSideRun66DC
    farcall AnyFoeLacksStatus0MaskCC
    ld a, c
    and a, a
    jr nz, Jump_0E2_5B5C
    ld bc, $001A
    call AccumulateBank6WordToDA6E

Jump_0E2_5B5C::
    farcall AnyFoeHasClearStatus3
    ld a, c
    and a, a
    jr nz, Jump_0E2_5B6C
    ld bc, $001A
    call AccumulateBank6WordToDA6E

Jump_0E2_5B6C::
    farcall AnyAllyHPAtMostThreeQuarters
    ld a, c
    and a, a
    jr nz, Jump_0E2_5B7C
    ld bc, $001B
    call AccumulateBank6WordToDA70

Jump_0E2_5B7C::
    farcall ActorHPIsNotOne
    ld a, c
    and a, a
    jr nz, Jump_0E2_5B8C
    ld bc, $0023
    call AccumulateBank6WordToDA6E

Jump_0E2_5B8C::
    farcall FewerThanTwoAlliesAtHP1
    ld a, c
    and a, a
    jr nz, Jump_0E2_5B9C
    ld bc, $0023
    call AccumulateBank6WordToDA6E

Jump_0E2_5B9C::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5BAC
    ld bc, $0024
    call AccumulateBank6WordToDA6E

Jump_0E2_5BAC::
    call WeighWD044RuleBit2
    farcall Func_005_6556
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5BC3
    and a, a
    jr nz, Jump_0E2_5BC3
    ld bc, $0069
    call AccumulateBank6WordToDA6E

Jump_0E2_5BC3::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 125 SideStep. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_SideStep:: ; heuristic: follows a terminator; C0
Func_0E2_5BC4:: ; address name
    farcall AIScore_SideStep_Sub01
    ld a, c
    and a, a
    ret z
    farcall AnyFoeLacksStatus5Bits01And1Bit1
    ld a, c
    and a, a
    jr nz, Jump_0E2_5BDD
    ld bc, $006C
    call AccumulateBank6WordToDA70

Jump_0E2_5BDD::
    farcall CheckLoneFoeHPNotBelowWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_5BED
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_5BED::
    farcall Func_005_5275
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5C01
    and a, a
    jr nz, Jump_0E2_5C01
    ld bc, $006D
    call AccumulateBank6WordToDA6E

Jump_0E2_5C01::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5C11
    ld bc, $00BE
    call AccumulateBank6WordToDA6E

Jump_0E2_5C11::
    call WeighWD044RuleBit2
    farcall Func_005_585D
    ld a, c
    and a, a
    jr nz, Jump_0E2_5C24
    ld bc, $0032
    call AccumulateBank6WordToDA6E

Jump_0E2_5C24::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 126 SandStorm. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_SandStorm:: ; heuristic: follows a terminator; C0
Func_0E2_5C25:: ; address name
    farcall AIScore_SandStorm_Sub01
    ld a, c
    and a, a
    ret z

Jump_0E2_5C2E::
    farcall CheckLoneFoeHPNotBelowWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_5C3E
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_5C3E::
    farcall Func_005_5275
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5C52
    and a, a
    jr nz, Jump_0E2_5C52
    ld bc, $006D
    call AccumulateBank6WordToDA6E

Jump_0E2_5C52::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5C62
    ld bc, $00BA
    call AccumulateBank6WordToDA70

Jump_0E2_5C62::
    call WeighWD044RuleBit5
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_5C75
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_5C75::
    farcall Func_005_585D
    ld a, c
    and a, a
    jr nz, Jump_0E2_5C85
    ld bc, $0032
    call AccumulateBank6WordToDA6E

Jump_0E2_5C85::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5C99
    and a, a
    jr nz, Jump_0E2_5C99
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_5C99::
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5CAD
    and a, a
    jr nz, Jump_0E2_5CAD
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5CAD::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5CC1
    and a, a
    jr nz, Jump_0E2_5CC1
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5CC1::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 127 Radiant. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Radiant:: ; heuristic: follows a terminator; C0
Func_0E2_5CC2:: ; address name
    farcall AIScore_Radiant_Sub01
    ld a, c
    and a, a
    ret z
    jp Jump_0E2_5C2E

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 128 EerieLite. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_EerieLite:: ; heuristic: follows a terminator; C0
Func_0E2_5CCE:: ; address name
    farcall AIScore_EerieLite_Sub01
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5CED
    ld bc, $00CC
    call AccumulateBank6WordToDA6E
    ld bc, $00D1
    call AccumulateBank6WordToDA70

Jump_0E2_5CED::
    call WeighWD044RuleBit5
    farcall FewerThanTwoFoesPresent
    ld a, c
    and a, a
    jr nz, Jump_0E2_5D00
    ld bc, $0015
    call AccumulateBank6WordToDA6E

Jump_0E2_5D00::
    farcall Func_005_64FE
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5D14
    and a, a
    jr nz, Jump_0E2_5D14
    ld bc, $0012
    call AccumulateBank6WordToDA70

Jump_0E2_5D14::
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5D28
    and a, a
    jr nz, Jump_0E2_5D28
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5D28::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5D3C
    and a, a
    jr nz, Jump_0E2_5D3C
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5D3C::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 129 Surge. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Surge:: ; heuristic: follows a terminator; C0
Func_0E2_5D3D:: ; address name
    farcall AIScore_Surge_Sub01
    ld a, c
    and a, a
    ret z
    ld bc, $006F
    call AccumulateBank6WordToDA6E
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5D5C
    ld bc, $00CA
    call AccumulateBank6WordToDA70

Jump_0E2_5D5C::
    call WeighWD044RuleBit4
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 130 UltraDown. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_UltraDown:: ; heuristic: follows a terminator; C0
Func_0E2_5D60:: ; address name
    farcall AIScore_UltraDown_Sub01
    ld a, c
    and a, a
    ret z
    ld bc, $006F
    call AccumulateBank6WordToDA6E
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5D7F
    ld bc, $00CC
    call AccumulateBank6WordToDA6E

Jump_0E2_5D7F::
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 131 DeMagic. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_DeMagic:: ; heuristic: follows a terminator; C0
Func_0E2_5D83:: ; address name
    farcall AIScore_DeMagic_Sub01
    ld a, c
    and a, a
    ret z
    ld bc, $0071
    call AccumulateBank6WordToDA6E
    farcall AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr nz, Jump_0E2_5DA2
    ld bc, $0070
    call AccumulateBank6WordToDA6E

Jump_0E2_5DA2::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5DB8
    ld bc, $00C9
    call AccumulateBank6WordToDA70
    ld bc, $00CB
    call AccumulateBank6WordToDA6E

Jump_0E2_5DB8::
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 132 ThickFog. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_ThickFog:: ; heuristic: follows a terminator; C0
Func_0E2_5DBC:: ; address name
    farcall AIScore_ThickFog_Sub01
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5DD5
    ld bc, $00C9
    call AccumulateBank6WordToDA6E

Jump_0E2_5DD5::
    call WeighWD044RuleBit5
    farcall AIModeAtLeast2AndFoeLacks6D1A
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5DEC
    and a, a
    jr nz, Jump_0E2_5DEC
    ld bc, $0072
    call AccumulateBank6WordToDA6E

Jump_0E2_5DEC::
    ret

; AI scoring routine for 4 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 133 TatsuCall, 134 DiagoCall, 135 SamsiCall, 136 BazooCall. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_TatsuCall:: ; heuristic: follows a terminator; C0
Func_0E2_5DED:: ; address name
    farcall AIScore_TatsuCall_Sub01
    ld a, c
    and a, a
    ret z
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a, a
    jr nz, Jump_0E2_5E06
    ld bc, $0073
    call AccumulateBank6WordToDA6E

Jump_0E2_5E06::
    farcall CheckLoneFoeHPNotBelowWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_5E16
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_5E16::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5E32
    ld bc, $0074
    call AccumulateBank6WordToDA6E
    ld bc, $00BB
    call AccumulateBank6WordToDA6E
    ld bc, $00C7
    call AccumulateBank6WordToDA70

Jump_0E2_5E32::
    call WeighWD044RuleBit5
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a, a
    jr nz, Jump_0E2_5E45
    ld bc, $0075
    call AccumulateBank6WordToDA6E

Jump_0E2_5E45::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 137 SuckAir. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_SuckAir:: ; heuristic: follows a terminator; C0
Func_0E2_5E46:: ; address name
    farcall AIScore_SuckAir_Sub01
    ld a, c
    and a, a
    ret z
    farcall CheckLoneFoeHPNotBelowWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_5E5F
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_5E5F::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5E6F
    ld bc, $0076
    call AccumulateBank6WordToDA6E

Jump_0E2_5E6F::
    call WeighWD044RuleBit3
    farcall AnyAllyLacksStatus2Bit2_5D31
    ld a, c
    and a, a
    jr nz, Jump_0E2_5E82
    ld bc, $0077
    call AccumulateBank6WordToDA70

Jump_0E2_5E82::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 138 Focus. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Focus:: ; heuristic: follows a terminator; C0
Func_0E2_5E83:: ; address name
    farcall AIScore_Focus_Sub01
    ld a, c
    and a, a
    ret z
    farcall CheckLoneFoeHPNotBelowWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_5E9C
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_5E9C::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5EB2
    ld bc, $00C2
    call AccumulateBank6WordToDA6E
    ld bc, $00D2
    call AccumulateBank6WordToDA70

Jump_0E2_5EB2::
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
    jr nz, Jump_0E2_5ED9
    ld bc, $0078
    call AccumulateBank6WordToDA6E

Jump_0E2_5ED9::
    call WeighWD044RuleBit5
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5EF0
    and a, a
    jr nz, Jump_0E2_5EF0
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5EF0::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5F04
    and a, a
    jr nz, Jump_0E2_5F04
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5F04::
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
    jr nz, Jump_0E2_5F23
    ld bc, $0079
    call AccumulateBank6WordToDA70

Jump_0E2_5F23::
    farcall Func_005_50E3
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5F37
    and a, a
    jr nz, Jump_0E2_5F37
    ld bc, $002C
    call AccumulateBank6WordToDA6E

Jump_0E2_5F37::
    farcall Func_005_517D
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5F4B
    and a, a
    jr nz, Jump_0E2_5F4B
    ld bc, $002C
    call AccumulateBank6WordToDA6E

Jump_0E2_5F4B::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5F5B
    ld bc, $0078
    call AccumulateBank6WordToDA6E

Jump_0E2_5F5B::
    call WeighWD044RuleBit5
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5F72
    and a, a
    jr nz, Jump_0E2_5F72
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5F72::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5F86
    and a, a
    jr nz, Jump_0E2_5F86
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5F86::
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
    farcall AIScore_LegSweep_Sub01
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_5FAD
    ld bc, $007B
    call AccumulateBank6WordToDA6E

Jump_0E2_5FAD::
    call WeighWD044RuleBit5
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5FC4
    and a, a
    jr nz, Jump_0E2_5FC4
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5FC4::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_5FD8
    and a, a
    jr nz, Jump_0E2_5FD8
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_5FD8::
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
    jr nz, Jump_0E2_6013
    ld bc, $00C0
    call AccumulateBank6WordToDA6E
    ld bc, $00C3
    call AccumulateBank6WordToDA70
    ld bc, $00CE
    call AccumulateBank6WordToDA70
    ld bc, $00D3
    call AccumulateBank6WordToDA6E

Jump_0E2_6013::
    call WeighWD044RuleBit5
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_602A
    and a, a
    jr nz, Jump_0E2_602A
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_602A::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_603E
    and a, a
    jr nz, Jump_0E2_603E
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_603E::
    call AIAddScoresFor5ECEAnd5FC7
    ld c, $01
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 145 Geyser. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Geyser:: ; heuristic: follows a terminator; C0
Func_0E2_6044:: ; address name
    farcall AIScore_Geyser_Sub01
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_605D
    ld bc, $007D
    call AccumulateBank6WordToDA6E

Jump_0E2_605D::
    call WeighWD044RuleBit5
    farcall Func_005_69F5
    ld a, c
    cp a, $01
    jr z, Jump_0E2_6074
    and a, a
    jr nz, Jump_0E2_6074
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_6074::
    farcall Func_005_6A6B
    ld a, c
    cp a, $01
    jr z, Jump_0E2_6088
    and a, a
    jr nz, Jump_0E2_6088
    ld bc, $0009
    call AccumulateBank6WordToDA6E

Jump_0E2_6088::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 146 DanceShut. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_DanceShut:: ; heuristic: follows a terminator; C0
Func_0E2_6089:: ; address name
    farcall AIScore_DanceShut_Sub01
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_60A2
    ld bc, $007E
    call AccumulateBank6WordToDA6E

Jump_0E2_60A2::
    call WeighWD044RuleBit2
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 147 MouthShut. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_MouthShut:: ; heuristic: follows a terminator; C0
Func_0E2_60A6:: ; address name
    farcall AIScore_MouthShut_Sub01
    ld a, c
    and a, a
    ret z
    farcall Func_005_53FA
    ld a, c
    cp a, $01
    jr z, Jump_0E2_60C3
    and a, a
    jr nz, Jump_0E2_60C3
    ld bc, $007F
    call AccumulateBank6WordToDA6E

Jump_0E2_60C3::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_60D3
    ld bc, $0080
    call AccumulateBank6WordToDA6E

Jump_0E2_60D3::
    call WeighWD044RuleBit3
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 148 StrongD. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
AIScore_StrongD:: ; heuristic: follows a terminator; C0
Func_0E2_60D7:: ; address name
    farcall AIScore_StrongD_Sub01
    ld a, c
    and a, a
    ret z
    call AIScoreGuardSkill_67CF
    ret z
    ld a, [wBattleActor]
    call AIScore_StrongD_Sub02
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_60FA
    ld bc, $00C1
    call AccumulateBank6WordToDA70

Jump_0E2_60FA::
    farcall Func_005_5500
    ld a, c
    cp a, $01
    jr z, Jump_0E2_610E
    and a, a
    jr nz, Jump_0E2_610E
    ld bc, $0000
    call AccumulateBank6WordToDA6E

Jump_0E2_610E::
    call WeighWD044RuleBit4
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 149 Dodge. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Dodge:: ; heuristic: follows a terminator; C0
Func_0E2_6112:: ; address name
    farcall AIScore_Dodge_Sub01
    ld a, c
    and a, a
    ret z
    call AIScoreGuardSkill_67CF
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_6135
    ld bc, $0088
    call AccumulateBank6WordToDA6E
    ld bc, $00C1
    call AccumulateBank6WordToDA70

Jump_0E2_6135::
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
    jr nz, Jump_0E2_615C
    ld bc, $008A
    call AccumulateBank6WordToDA6E
    ld bc, $00C1
    call AccumulateBank6WordToDA70

Jump_0E2_615C::
    call WeighWD044RuleBit4
    ret

; AI scoring routine for 2 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 151 Cover, 152 Guardian. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
AIScore_Cover:: ; heuristic: follows a terminator; C0
Func_0E2_6160:: ; address name
    farcall AIScore_Cover_Sub01
    ld a, c
    and a, a
    ret z
    call AIScoreGuardSkill_67CF
    ret z
    ld a, [wBattleActor]
    call AIScore_Cover_Sub02
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_6189
    ld bc, $00CD
    call AccumulateBank6WordToDA70
    ld bc, $00D1
    call AccumulateBank6WordToDA6E

Jump_0E2_6189::
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 153 TailWind. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_TailWind:: ; heuristic: follows a terminator; C0
Func_0E2_618D:: ; address name
    farcall AIScore_TailWind_Sub01
    ld a, c
    and a, a
    ret z
    call AIScore_TailWind_Sub02
    ret z

Jump_0E2_619A::
    farcall Func_005_53FA
    ld a, c
    cp a, $01
    jr z, Jump_0E2_61AE
    and a, a
    jr nz, Jump_0E2_61BE
    ld bc, $003A
    call AccumulateBank6WordToDA6E

Jump_0E2_61AE::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_61BE
    ld bc, $008C
    call AccumulateBank6WordToDA6E

Jump_0E2_61BE::
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 154 StormWind. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_StormWind:: ; heuristic: follows a terminator; C0
Func_0E2_61C2:: ; address name
    farcall AIScore_StormWind_Sub01
    ld a, c
    and a, a
    ret z
    jr Jump_0E2_619A

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 155 AquaWall. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
AIScore_AquaWall:: ; heuristic: follows a terminator; C0
Func_0E2_61CD:: ; address name
    farcall AIScore_AquaWall_Sub01
    ld a, c
    and a, a
    ret z
    ld a, [wBattleActor]
    call AIScore_AquaWall_Sub02
    call WeighWD044RuleBit5
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 156 SealPray. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_SealPray:: ; heuristic: follows a terminator; C0
Func_0E2_61E0:: ; address name
    farcall AIScore_SealPray_Sub02
    ld a, c
    and a, a
    ret z
    farcall AIScore_SealPray_Sub01
    ld a, c
    and a, a
    jr nz, Jump_0E2_61F9
    ld bc, $008D
    call AccumulateBank6WordToDA70

Jump_0E2_61F9::
    farcall Func_005_53FA
    ld a, c
    cp a, $01
    jr z, Jump_0E2_620D
    and a, a
    jr nz, Jump_0E2_620D
    ld bc, $008E
    call AccumulateBank6WordToDA6E

Jump_0E2_620D::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_621D
    ld bc, $00CB
    call AccumulateBank6WordToDA6E

Jump_0E2_621D::
    farcall Func_005_5500
    ld a, c
    cp a, $01
    jr z, Jump_0E2_6231
    and a, a
    jr nz, Jump_0E2_6231
    ld bc, $008F
    call AccumulateBank6WordToDA6E

Jump_0E2_6231::
    call WeighWD044RuleBit5
    farcall AIModeAtLeast2AndFoeLacks6D1A
    ld a, c
    cp a, $01
    jr z, Jump_0E2_6248
    and a, a
    jr nz, Jump_0E2_6248
    ld bc, $0090
    call AccumulateBank6WordToDA6E

Jump_0E2_6248::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 157 SuckAll. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
AIScore_SuckAll:: ; heuristic: follows a terminator; C0
Func_0E2_6249:: ; address name
    farcall AIScore_SuckAll_Sub01
    ld a, c
    and a, a
    ret z
    call AIScoreGuardSkill_67CF
    ret z
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a, a
    jr nz, Jump_0E2_6266
    ld bc, $0091
    call AccumulateBank6WordToDA6E

Jump_0E2_6266::
    farcall AnyAllyHPAtMostThreeQuarters
    ld a, c
    and a, a
    jr nz, Jump_0E2_6276
    ld bc, $0092
    call AccumulateBank6WordToDA70

Jump_0E2_6276::
    ld a, [wBattleActor]
    call AIScore_SuckAll_Sub02
    farcall Func_005_53FA
    ld a, c
    cp a, $01
    jr z, Jump_0E2_6290
    and a, a
    jr nz, Jump_0E2_6290
    ld bc, $008E
    call AccumulateBank6WordToDA6E

Jump_0E2_6290::
    call WeighWD044RuleBit3
    farcall AnyAllyLacksStatus2Bit2
    ld a, c
    and a, a
    jr nz, Jump_0E2_62A3
    ld bc, $0097
    call AccumulateBank6WordToDA70

Jump_0E2_62A3::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 158 Imitate. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Imitate:: ; heuristic: follows a terminator; C0
Func_0E2_62A4:: ; address name
    farcall AIScore_Imitate_Sub01
    ld a, c
    and a, a
    ret z
    call AIScoreGuardSkill_67CF
    ret z
    farcall CheckLoneFoeHPNotBelowWD2C1
    ld a, c
    and a, a
    jr nz, Jump_0E2_62C1
    ld bc, $0007
    call AccumulateBank6WordToDA70

Jump_0E2_62C1::
    farcall Func_005_53FA
    ld a, c
    cp a, $01
    jr z, Jump_0E2_62D5
    and a, a
    jr nz, Jump_0E2_62D5
    ld bc, $0098
    call AccumulateBank6WordToDA6E

Jump_0E2_62D5::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_62EB
    ld bc, $00BB
    call AccumulateBank6WordToDA70
    ld bc, $00C6
    call AccumulateBank6WordToDA6E

Jump_0E2_62EB::
    call WeighWD044RuleBit5
    farcall AIModeAtLeast2AndFoeLacks6D1A
    ld a, c
    cp a, $01
    jr z, Jump_0E2_6302
    and a, a
    jr nz, Jump_0E2_6302
    ld bc, $009A
    call AccumulateBank6WordToDA6E

Jump_0E2_6302::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 159 Meditate. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
AIScore_Meditate:: ; heuristic: follows a terminator; C0
Func_0E2_6303:: ; address name
    farcall AIScore_Meditate_Sub01
    ld a, c
    and a, a
    ret z
    ld a, [wBattleActor]
    call AIScore_Meditate_Sub02
    farcall ActorHPIsNotOne
    ld a, c
    and a, a
    jr nz, Jump_0E2_6322
    ld bc, $00A1
    call AccumulateBank6WordToDA6E

Jump_0E2_6322::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_6338
    ld bc, $00C2
    call AccumulateBank6WordToDA6E
    ld bc, $00D2
    call AccumulateBank6WordToDA70

Jump_0E2_6338::
    call WeighWD044RuleBit4
    farcall Func_005_6556
    ld a, c
    cp a, $01
    jr z, Jump_0E2_634F
    and a, a
    jr nz, Jump_0E2_634F
    ld bc, $0069
    call AccumulateBank6WordToDA70

Jump_0E2_634F::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 160 LifeSong. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_LifeSong:: ; heuristic: follows a terminator; C0
Func_0E2_6350:: ; address name
    farcall AIScore_LifeSong_Sub01
    ld a, c
    and a, a
    ret z
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_636F
    ld bc, $00CC
    call AccumulateBank6WordToDA70
    ld bc, $00D3
    call AccumulateBank6WordToDA70

Jump_0E2_636F::
    call WeighWD044RuleBit4
    farcall Func_005_667F
    ld a, c
    cp a, $01
    jr z, Jump_0E2_6386
    and a, a
    jr nz, Jump_0E2_6386
    ld bc, $002E
    call AccumulateBank6WordToDA70

Jump_0E2_6386::
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 161 LoveRain. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
AIScore_LoveRain:: ; heuristic: follows a terminator; C0
Func_0E2_6387:: ; address name
    farcall AIScore_LoveRain_Sub01
    ld a, c
    and a, a
    ret z
    farcall AnyAllyHPAtMostThreeQuarters
    ld a, c
    and a, a
    jr nz, Jump_0E2_63A0
    ld bc, $001B
    call AccumulateBank6WordToDA70

Jump_0E2_63A0::
    ld a, [wBattleActor]
    call ForEachPresentSlotOfSideRun66DC
    farcall ActorHPIsNotOne
    ld a, c
    and a, a
    jr nz, Jump_0E2_63B6
    ld bc, $00A3
    call AccumulateBank6WordToDA6E

Jump_0E2_63B6::
    farcall FewerThanTwoAlliesAtHP1
    ld a, c
    and a, a
    jr nz, Jump_0E2_63C6
    ld bc, $00A4
    call AccumulateBank6WordToDA6E

Jump_0E2_63C6::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_63E2
    ld bc, $00CC
    call AccumulateBank6WordToDA70
    ld bc, $00CF
    call AccumulateBank6WordToDA6E
    ld bc, $00D3
    call AccumulateBank6WordToDA70

Jump_0E2_63E2::
    call WeighWD044RuleBit4
    farcall Func_005_6556
    ld a, c
    cp a, $01
    jr z, Jump_0E2_63F9
    and a, a
    jr nz, Jump_0E2_63F9
    ld bc, $0069
    call AccumulateBank6WordToDA6E

Jump_0E2_63F9::
    ret

; AI scoring routine for 8 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 162 Whistle, 163 Pheromone, 164 StepGuard, 165 Outside, 166 Informer, 167 Errand, 168 EagleEye, 169 MapMagic. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Whistle:: ; heuristic: follows a terminator; C0
Func_0E2_63FA:: ; address name
    farcall AINeverUsableResetWDA6E
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
    jr nz, Jump_0E2_641A
    ld bc, $00A5
    call AccumulateBank6WordToDA6E

Jump_0E2_641A::
    call WeighWD044RuleBit1
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 171 ZoneOut. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_ZoneOut:: ; heuristic: follows a terminator; C0
Func_0E2_641E:: ; address name
    farcall AINeverUsableResetWDA6E
    ret

; AI scoring routine for 1 skill(s) of the per-skill far table (Data_030_5785 and Data_030_59E0, indexed by skill number): 172 Guard. It runs checks and adds weights to wDA6E-wDA71 (AccumulateBank6WordToDA6E/DA70); the individual checks are not interpreted (E-0083)
; no direct call (reached through a table, a jump or a vector)
AIScore_Guard:: ; heuristic: follows a terminator; C0
Func_0E2_6425:: ; address name
    call MaxNegativeScoreWhenWD2CCBit0
    ret z
    farcall AIScore_Guard_Sub01
    ld a, c
    and a, a
    ret z
    farcall AnyFoeLacksStatus5Bits01And1Bit1
    ld a, c
    and a, a
    jr nz, Jump_0E2_6442
    ld bc, $00A6
    call AccumulateBank6WordToDA70

Jump_0E2_6442::
    farcall AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a, a
    jr nz, Jump_0E2_6452
    ld bc, $00A7
    call AccumulateBank6WordToDA70

Jump_0E2_6452::
    farcall ActorHPIsNotOne
    ld a, c
    and a, a
    jr nz, Jump_0E2_6462
    ld bc, $00A8
    call AccumulateBank6WordToDA70

Jump_0E2_6462::
    farcall SetCToZero
    ld a, c
    and a, a
    jr nz, Jump_0E2_6472
    ld bc, $00A9
    call AccumulateBank6WordToDA6E

Jump_0E2_6472::
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
    jr nz, Jump_0E2_648C
    ld bc, $0037
    call AccumulateBank6WordToDA6E

Jump_0E2_648C::
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
    jr nz, Jump_0E2_64AA
    ld bc, $0038
    call AccumulateBank6WordToDA6E

Jump_0E2_64AA::
    farcall AIModeAtLeast2AndFoeLacks6D1A
    ld a, c
    cp a, $01
    jr z, Jump_0E2_64BE
    and a, a
    jr nz, Jump_0E2_64BE
    ld bc, $0039
    call AccumulateBank6WordToDA6E

Jump_0E2_64BE::
    ret
    db $C9, $C9, $CD, $D4, $3E, $FA, $E7, $C5, $CB, $7F, $CC, $40, $65, $C9, $C9

; word = ReadBank6TableWord; if its low byte is $FF the value is 5000, which is added to wDA6E; a positive word is added to wDA6E; a negative word's magnitude is added to wDA70
; 304 call sites from 118 routines (e.g. AIScore_Skill00, AIScore_StrongD_Sub02, AIScore_Blaze, AIAddScoresFor55BEAnd5731, ...)
; points at: wDA6E, wDA70
AccumulateBank6WordToDA6E::
Func_0E2_64CE:: ; address name
    call ReadBank6TableWord
    cp a, $FF
    jr nz, Jump_0E2_64DA
    ld bc, $1388
    jr Jump_0E2_64EE

Jump_0E2_64DA::
    bit 7, b
    jr nz, Jump_0E2_64E0
    jr Jump_0E2_64EE

Jump_0E2_64E0::
    cpl
    ld c, a
    ld a, b
    cpl
    ld b, a
    inc bc
    ld hl, wDA70
    call AddBCToWordAtHL
    jr Jump_0E2_64F4

Jump_0E2_64EE::
    ld hl, wDA6E
    call AddBCToWordAtHL

Jump_0E2_64F4::
    ret

; the mirror of AccumulateBank6WordToDA6E: $FF (5000) and positive words go to wDA70, negative words' magnitude goes to wDA6E
; 223 call sites from 89 routines (e.g. AIScore_Skill00, AIScore_StrongD_Sub02, AIScore_Blaze, AIAddScoresFor55BEAnd5731, ...)
; points at: wDA70, wDA6E
AccumulateBank6WordToDA70::
Func_0E2_64F5:: ; address name
    call ReadBank6TableWord
    cp a, $FF
    jr nz, Jump_0E2_6501
    ld bc, $1388
    jr Jump_0E2_6515

Jump_0E2_6501::
    bit 7, b
    jr nz, Jump_0E2_6507
    jr Jump_0E2_6515

Jump_0E2_6507::
    cpl
    ld c, a
    ld a, b
    cpl
    ld b, a
    inc bc
    ld hl, wDA6E
    call AddBCToWordAtHL
    jr Jump_0E2_651B

Jump_0E2_6515::
    ld hl, wDA70
    call AddBCToWordAtHL

Jump_0E2_651B::
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
; writes: hFFC6
AIScore_StrongD_Sub02:: ; heuristic: follows a terminator; C0
Func_0E2_656D:: ; address name
    ldh [hFFC6], a
    farcall HPBandOfSlotHFFC6
    ld a, c
    and a, a
    jr z, Jump_0E2_6591
    cp a, $01
    jr z, Jump_0E2_6599
    cp a, $02
    jr z, Jump_0E2_65A1
    cp a, $03
    jr z, Jump_0E2_65A9
    cp a, $04
    jr z, Jump_0E2_65B1
    ld bc, $0085
    call AccumulateBank6WordToDA6E
    jr Jump_0E2_65B7

Jump_0E2_6591::
    ld bc, $0083
    call AccumulateBank6WordToDA70
    jr Jump_0E2_65B7

Jump_0E2_6599::
    ld bc, $0083
    call AccumulateBank6WordToDA70
    jr Jump_0E2_65B7

Jump_0E2_65A1::
    ld bc, $0083
    call AccumulateBank6WordToDA70
    jr Jump_0E2_65B7

Jump_0E2_65A9::
    ld bc, $0083
    call AccumulateBank6WordToDA70
    jr Jump_0E2_65B7

Jump_0E2_65B1::
    ld bc, $0084
    call AccumulateBank6WordToDA6E

Jump_0E2_65B7::
    ret

; only called from AIScore_AquaWall (E-0047)
; 1 call site from 1 routine (e.g. AIScore_AquaWall)
; writes: hFFC6
AIScore_AquaWall_Sub02:: ; heuristic: follows a terminator; C0
Func_0E2_65B8:: ; address name
    ldh [hFFC6], a
    farcall HPBandOfSlotHFFC6
    ld a, c
    and a, a
    jr z, Jump_0E2_65DC
    cp a, $01
    jr z, Jump_0E2_65E4
    cp a, $02
    jr z, Jump_0E2_65EC
    cp a, $03
    jr z, Jump_0E2_65F4
    cp a, $04
    jr z, Jump_0E2_65FC
    ld bc, $0086
    call AccumulateBank6WordToDA70
    jr Jump_0E2_6602

Jump_0E2_65DC::
    ld bc, $0081
    call AccumulateBank6WordToDA6E
    jr Jump_0E2_6602

Jump_0E2_65E4::
    ld bc, $0082
    call AccumulateBank6WordToDA6E
    jr Jump_0E2_6602

Jump_0E2_65EC::
    ld bc, $0083
    call AccumulateBank6WordToDA70
    jr Jump_0E2_6602

Jump_0E2_65F4::
    ld bc, $0084
    call AccumulateBank6WordToDA70
    jr Jump_0E2_6602

Jump_0E2_65FC::
    ld bc, $0085
    call AccumulateBank6WordToDA70

Jump_0E2_6602::
    ret

; only called from AIScore_SuckAll (E-0047)
; 1 call site from 1 routine (e.g. AIScore_SuckAll)
; writes: hFFC6
AIScore_SuckAll_Sub02:: ; heuristic: follows a terminator; C0
Func_0E2_6603:: ; address name
    and a, $04
    ld c, a
    ld b, $03

Jump_0E2_6608::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_0E2_6615
    ldh [hFFC6], a
    push bc
    call AIScore_SuckAll_Sub02_Sub01
    pop bc

Jump_0E2_6615::
    inc c
    dec b
    jr nz, Jump_0E2_6608
    ret

; only called from AIScore_SuckAll_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. AIScore_SuckAll_Sub02)
AIScore_SuckAll_Sub02_Sub01::
Func_0E2_661A:: ; address name
    farcall HPBandOfSlotHFFC6
    ld a, c
    cp a, $02
    jr nc, Jump_0E2_662D
    ld bc, $0093
    call AccumulateBank6WordToDA6E
    jr Jump_0E2_6633

Jump_0E2_662D::
    ld bc, $0094
    call AccumulateBank6WordToDA70

Jump_0E2_6633::
    ret

; only called from AIScore_Meditate (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Meditate)
; writes: hFFC6
AIScore_Meditate_Sub02:: ; heuristic: follows a terminator; C0
Func_0E2_6634:: ; address name
    ldh [hFFC6], a
    farcall HPBandOfSlotHFFC6
    ld a, c
    and a, a
    jr z, Jump_0E2_6658
    cp a, $01
    jr z, Jump_0E2_6660
    cp a, $02
    jr z, Jump_0E2_6668
    cp a, $03
    jr z, Jump_0E2_6670
    cp a, $04
    jr z, Jump_0E2_6678
    ld bc, $00A0
    call AccumulateBank6WordToDA6E
    jr Jump_0E2_667E

Jump_0E2_6658::
    ld bc, $009B
    call AccumulateBank6WordToDA70
    jr Jump_0E2_667E

Jump_0E2_6660::
    ld bc, $009C
    call AccumulateBank6WordToDA70
    jr Jump_0E2_667E

Jump_0E2_6668::
    ld bc, $009D
    call AccumulateBank6WordToDA70
    jr Jump_0E2_667E

Jump_0E2_6670::
    ld bc, $009E
    call AccumulateBank6WordToDA6E
    jr Jump_0E2_667E

Jump_0E2_6678::
    ld bc, $009F
    call AccumulateBank6WordToDA6E

Jump_0E2_667E::
    ret

; only called from AIScore_HealUs_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. AIScore_HealUs_Sub01)
; writes: hFFC6
AIScore_HealUs_Sub01_Sub01:: ; heuristic: follows a terminator; C0
Func_0E2_667F:: ; address name
    and a, $04
    ld c, a
    ld b, $03

Jump_0E2_6684::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_0E2_6691
    ldh [hFFC6], a
    push bc
    call AIScore_HealUs_Sub01_Sub01_Sub01
    pop bc

Jump_0E2_6691::
    inc c
    dec b
    jr nz, Jump_0E2_6684
    ret

; only called from AIScore_HealUs_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. AIScore_HealUs_Sub01_Sub01)
; reads: wBattleActor
AIScore_HealUs_Sub01_Sub01_Sub01::
Func_0E2_6696:: ; address name
    push bc
    farcall HPBandOfSlotHFFC6
    ld a, c
    pop bc
    ld b, a
    ld a, [wBattleActor]
    cp a, c
    ld hl, Data_0E2_66B9
    jr z, Jump_0E2_66AC
    ld hl, Data_0E2_66BF

Jump_0E2_66AC::
    ld a, b
    add_a_to_hl
    ld c, [hl]
    ld b, $00
    call AccumulateBank6WordToDA6E
    ret

Data_0E2_66B9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1E, $1F, $20, $21, $22, $22

Data_0E2_66BF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $AB, $AC, $AD, $AE, $AF, $AF

; for the three slots of the side in A (bit 2), runs Func_0E2_66DC with hFFC6 = slot for each occupied one (E-0122)
; 2 call sites from 2 routines (e.g. AIScore_Hustle, AIScore_LoveRain)
; writes: hFFC6
ForEachPresentSlotOfSideRun66DC::
Func_0E2_66C5:: ; address name
    and a, $04
    ld c, a
    ld b, $03

Jump_0E2_66CA::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_0E2_66D7
    ldh [hFFC6], a
    push bc
    call ForEachPresentSlotOfSideRun66DC_Sub01
    pop bc

Jump_0E2_66D7::
    inc c
    dec b
    jr nz, Jump_0E2_66CA
    ret

; only called from ForEachPresentSlotOfSideRun66DC (E-0047)
; 1 call site from 1 routine (e.g. ForEachPresentSlotOfSideRun66DC)
; reads: wBattleActor
ForEachPresentSlotOfSideRun66DC_Sub01::
Func_0E2_66DC:: ; address name
    push bc
    farcall HPBandOfSlotHFFC6
    ld a, c
    pop bc
    ld b, a
    ld a, [wBattleActor]
    cp a, c
    ld hl, Data_0E2_66FF
    jr z, Jump_0E2_66F2
    ld hl, Data_0E2_6705

Jump_0E2_66F2::
    ld a, b
    add_a_to_hl
    ld c, [hl]
    ld b, $00
    call AccumulateBank6WordToDA6E
    ret

Data_0E2_66FF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1D, $1E, $1F, $20, $21, $22

Data_0E2_6705:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $AA, $AB, $AC, $AD, $AE, $AF

; only called from AIScore_Ramming (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Ramming)
; writes: hFFC6
AIScore_Ramming_Sub02::
Func_0E2_670B:: ; address name
    ldh [hFFC6], a
    push bc
    farcall HPBandOfSlotHFFC6
    ld a, c
    pop bc
    ld b, a
    ld hl, Data_0E2_6727
    ld a, b
    add_a_to_hl
    ld c, [hl]
    ld b, $00
    call AccumulateBank6WordToDA6E
    ret

Data_0E2_6727:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1D, $1E, $1F, $20, $21, $22

; only called from AIScore_Cover (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Cover)
; writes: hFFC6
AIScore_Cover_Sub02::
Func_0E2_672D:: ; address name
    and a, $04
    ld c, a
    ld b, $03

Jump_0E2_6732::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_0E2_673F
    ldh [hFFC6], a
    push bc
    call AIScore_Cover_Sub02_Sub01
    pop bc

Jump_0E2_673F::
    inc c
    dec b
    jr nz, Jump_0E2_6732
    ret

; only called from AIScore_Cover_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Cover_Sub02)
; reads: wBattleActor
AIScore_Cover_Sub02_Sub01::
Func_0E2_6744:: ; address name
    push bc
    farcall HPBandOfSlotHFFC6
    ld a, c
    pop bc
    ld b, a
    ld a, [wBattleActor]
    cp a, c
    ld hl, Data_0E2_6767
    jr z, Jump_0E2_675A
    ld hl, Data_0E2_676D

Jump_0E2_675A::
    ld a, b
    add_a_to_hl
    ld c, [hl]
    ld b, $00
    call AccumulateBank6WordToDA6E
    ret

Data_0E2_6767:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $20, $1F, $1E, $1D, $1D

Data_0E2_676D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $AA, $AA, $AB, $AC, $AD, $AE

; only called from AIScore_Upper (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Upper)
AIScore_Upper_Sub02::
Func_0E2_6773:: ; address name
    farcall Func_005_585D
    ld a, c
    and a, a
    jr nz, Jump_0E2_6785
    ld bc, $002B
    call AccumulateBank6WordToDA6E
    jr Jump_0E2_678B

Jump_0E2_6785::
    ld bc, $0013
    call AccumulateBank6WordToDA70

Jump_0E2_678B::
    ret

; only called from AIScore_Sap (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Sap)
AIScore_Sap_Sub02:: ; heuristic: follows a terminator; C0
Func_0E2_678C:: ; address name
    farcall AIScore_Sap_Sub02_Sub01
    ld a, c
    and a, a
    jr nz, Jump_0E2_679E
    ld bc, $0013
    call AccumulateBank6WordToDA70
    jr Jump_0E2_67A4

Jump_0E2_679E::
    ld bc, $002B
    call AccumulateBank6WordToDA6E

Jump_0E2_67A4::
    ret

; C = (wD2CC & 1) ^ 1 and returns when non-zero; when bit 0 is set: wDA6E = 0, wDA70/wDA71 = $FFFF, C = 0 (E-0118)
; 4 call sites from 4 routines (e.g. AIScoreGuardSkill_67CF, AIScore_SquallHit, AIScore_Berserker, AIScore_Guard)
; reads: wD2CC
; writes: wDA6E, wDA6F, wDA70, wDA71
MaxNegativeScoreWhenWD2CCBit0:: ; heuristic: follows a terminator; C0
Func_0E2_67A5:: ; address name
    ld a, [wD2CC]
    and a, $01
    xor a, $01
    ld c, a
    ret nz
    xor a, a
    ld [wDA6E], a
    ld [wDA6F], a
    ld a, $FF
    ld [wDA70], a
    ld [wDA71], a
    xor a, a
    ld c, a
    ret

; only called from AIScore_TailWind (E-0047)
; 1 call site from 1 routine (e.g. AIScore_TailWind)
; reads: wD891
AIScore_TailWind_Sub02:: ; heuristic: follows a terminator; C0
Func_0E2_67C0:: ; address name
    ld a, [wD891]
    ld c, a
    or a, a
    ret nz
    ld bc, $00B6
    call AccumulateBank6WordToDA70
    ld c, $FF
    ret

; returns when MaxNegativeScoreWhenWD2CCBit0 applies; otherwise continues with AIScore_TailWind_Sub02 (E-0122)
; 8 call sites from 8 routines (e.g. AIScore_Ironize, AIScore_StrongD, AIScore_Dodge, AIScore_BladeD, ...)
; reads: wD891
AIScoreGuardSkill_67CF::
Func_0E2_67CF:: ; address name
    call MaxNegativeScoreWhenWD2CCBit0
    ret z
    jr AIScore_TailWind_Sub02

; WeighWD044RuleBit4, then adds score word $29 to wDA6E when Func_005_5758 fails and again when Func_005_5CF1 fails (E-0122)
; 2 call sites from 2 routines (e.g. AIScore_Vivify, AIScore_Farewell)
AIAddPenaltyFor5758And5CF1::
Func_0E2_67D5:: ; address name
    call WeighWD044RuleBit4
    farcall AllySlotsCheckThenFewerThanTwoFoes
    ld a, c
    and a, a
    jr nz, Jump_0E2_67E8
    ld bc, $0029
    call AccumulateBank6WordToDA6E

Jump_0E2_67E8::
    farcall PassIfWC984OrAllySlotEmpty
    ld a, c
    and a, a
    jr nz, Jump_0E2_67F8
    ld bc, $0029
    call AccumulateBank6WordToDA6E

Jump_0E2_67F8::
    ret

; adds score word $B1 when Func_005_5ECE fails and $B2 when Func_005_5FC7 fails (results of 1 count as passing) (E-0124)
; 9 call sites from 9 routines (e.g. AIScoreB_LureDance, AIScore_LureDance, AIScoreB_LushLicks, AIScore_LushLicks, ...)
AIAddScoresFor5ECEAnd5FC7:: ; heuristic: follows a terminator; C0
Func_0E2_67F9:: ; address name
    farcall AIAddScoresFor5ECEAnd5FC7_Sub01
    ld a, c
    cp a, $01
    jr z, Jump_0E2_680D
    and a, a
    jr nz, Jump_0E2_680D
    ld bc, $00B1
    call AccumulateBank6WordToDA6E

Jump_0E2_680D::
    farcall AIAddScoresFor5ECEAnd5FC7_Sub02
    ld a, c
    cp a, $01
    jr z, Jump_0E2_6821
    and a, a
    jr nz, Jump_0E2_6821
    ld bc, $00B2
    call AccumulateBank6WordToDA6E

Jump_0E2_6821::
    ret

; adds score word $0E to wDA70 when Func_005_55BE fails and $0F to wDA6E when Func_005_5731 fails (E-0122)
; 3 call sites from 3 routines (e.g. AIScore_Blaze, AIScore_Firebal, AIScore_Beat)
AIAddScoresFor55BEAnd5731::
Func_0E2_6822:: ; address name
    farcall LinkRuleCheckWD044Bit6
    ld a, c
    and a, a
    jr nz, Jump_0E2_6832
    ld bc, $000E
    call AccumulateBank6WordToDA70

Jump_0E2_6832::
    farcall LinkRuleCheckWD04BTurnLimit
    ld a, c
    and a, a
    jr nz, Jump_0E2_6842
    ld bc, $000F
    call AccumulateBank6WordToDA6E

Jump_0E2_6842::
    ret

; only called from AIScore_Sacrifice (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Sacrifice)
AIScore_Sacrifice_Sub03:: ; heuristic: follows a terminator; C0
Func_0E2_6843:: ; address name
    farcall LinkRuleCheckWD044Bit6
    ld a, c
    and a, a
    jr nz, Jump_0E2_6853
    ld bc, $000E
    call AccumulateBank6WordToDA70

Jump_0E2_6853::
    ret

; far-calls CheckWD044RuleBit5; when it fails (C = 0) adds weight-table entry $0E to wDA70 (AccumulateBank6WordToDA70); used by the AI scoring routines (E-0091)
; 36 call sites from 36 routines (e.g. AIScore_Upper, AIScore_Sap, AIScore_Speed, AIScore_Slow, ...)
WeighWD044RuleBit5:: ; heuristic: follows a terminator; C0
Func_0E2_6854:: ; address name
    farcall CheckWD044RuleBit5
    ld a, c
    and a, a
    jr nz, Jump_0E2_6864
    ld bc, $000E
    call AccumulateBank6WordToDA70

Jump_0E2_6864::
    ret

; far-calls CheckWD044RuleBit4; when it fails (C = 0) adds weight-table entry $0E to wDA70 (AccumulateBank6WordToDA70); used by the AI scoring routines (E-0091)
; 12 call sites from 12 routines (e.g. AIScore_HealUs_Sub01, AIAddPenaltyFor5758And5CF1, AIScore_Antidote, AIScore_DeChaos, ...)
WeighWD044RuleBit4:: ; heuristic: follows a terminator; C0
Func_0E2_6865:: ; address name
    farcall CheckWD044RuleBit4
    ld a, c
    and a, a
    jr nz, Jump_0E2_6875
    ld bc, $000E
    call AccumulateBank6WordToDA70

Jump_0E2_6875::
    ret

; far-calls CheckWD044RuleBit3; when it fails (C = 0) adds weight-table entry $0E to wDA70 (AccumulateBank6WordToDA70); used by the AI scoring routines (E-0091)
; 5 call sites from 5 routines (e.g. AIScore_FireAir, AIScore_SleepAir, AIScore_SuckAir, AIScore_MouthShut, ...)
WeighWD044RuleBit3:: ; heuristic: follows a terminator; C0
Func_0E2_6876:: ; address name
    farcall CheckWD044RuleBit3
    ld a, c
    and a, a
    jr nz, Jump_0E2_6886
    ld bc, $000E
    call AccumulateBank6WordToDA70

Jump_0E2_6886::
    ret

; far-calls CheckWD044RuleBit2; when it fails (C = 0) adds weight-table entry $0E to wDA70 (AccumulateBank6WordToDA70); used by the AI scoring routines (E-0091)
; 8 call sites from 8 routines (e.g. AIScore_OddDance, AIScore_PaniDance, AIScore_KODance, AIScore_LureDance, ...)
WeighWD044RuleBit2:: ; heuristic: follows a terminator; C0
Func_0E2_6887:: ; address name
    farcall CheckWD044RuleBit2
    ld a, c
    and a, a
    jr nz, Jump_0E2_6897
    ld bc, $000E
    call AccumulateBank6WordToDA70

Jump_0E2_6897::
    ret

; far-calls CheckWD044RuleBit1; when it fails (C = 0) adds weight-table entry $0E to wDA70 (AccumulateBank6WordToDA70); used by the AI scoring routines (E-0091)
; 22 call sites from 22 routines (e.g. AIScore_BigBang, AIScore_Vacuum_Sub01, AIScore_RockThrow, AIScore_Watershot, ...)
WeighWD044RuleBit1:: ; heuristic: follows a terminator; C0
Func_0E2_6898:: ; address name
    farcall CheckWD044RuleBit1
    ld a, c
    and a, a
    jr nz, Jump_0E2_68A8
    ld bc, $000E
    call AccumulateBank6WordToDA70

Jump_0E2_68A8::
    ret

; A = battle slot: HL = the word for that slot at wBattleATK; A = its low byte (E-0064)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleATK
GetBattleATK_BankE2:: ; heuristic: follows a terminator; C0
Func_0E2_68A9:: ; address name
    ld hl, wBattleATK
    jr Jump_0E2_68D6
    db $21, $0F, $D9, $18, $23, $21, $CF, $D8, $18, $1E, $21, $EF, $D8, $18, $19, $21
    db $BF, $D8, $18, $14, $21, $DF, $D8, $18, $0F, $21, $1F, $D9, $18, $0A, $21, $53
    db $DA, $85, $6F, $30, $01, $24, $7E, $C9

Jump_0E2_68D6::
    add a, a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes appear in 10 banks)
; no direct call (reached through a table, a jump or a vector)
AddDoubleAToHL_BankE2:: ; heuristic: follows a terminator; C0
Func_0E2_68E0:: ; address name
    add a, a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the reversal, not checked (E-0064) (the same 27 bytes appear in 10 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wC57F, wBattleActor
ActorOnLocalSide_BankE2:: ; heuristic: follows a terminator; C0
Func_0E2_68E7:: ; address name
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_0E2_68FC
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_0E2_68FC
    ld a, [wBattleActor]
    cp a, $04
    ccf
    ret

Jump_0E2_68FC::
    ld a, [wBattleActor]
    cp a, $04
    ret

; carry set when wBattleTarget < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleTarget >= 4) (E-0064) (the same 27 bytes appear in 10 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wC57F, wBattleTarget
TargetOnLocalSide_BankE2:: ; heuristic: follows a terminator; C0
Func_0E2_6902:: ; address name
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_0E2_6917
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_0E2_6917
    ld a, [wBattleTarget]
    cp a, $04
    ccf
    ret

Jump_0E2_6917::
    ld a, [wBattleTarget]
    cp a, $04
    ret
    INCBIN "dwm2-cobi-us.gbc", $38A91D, $CA
    ds $1619, $00
