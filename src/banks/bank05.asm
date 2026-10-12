SECTION "Bank 05", ROMX[$4000], BANK[$05]
    db $05

; A = battle slot: HL = the word for that slot at wBattleATK; A = its low byte (E-0064)
; 13 call sites from 12 routines (e.g. UnreferencedEstimateStrongestFoeHit, AIScore_BiAttack_Sub02_CarryUnlessBattleSlotOutSlotEmpty, AIScore_BeDragon_GetBattleMaxHP_Bank05, AIScore_Transform_ReadSlotAIModeIndexed_Bank05, ...)
; points at: wBattleATK
GetBattleATK_Bank05::
Func_005_4001:: ; address name
    ld hl, wBattleATK
    jr ReadSlotAIModeIndexed_Bank05_4024_Skip

; A = battle slot: HL = the word for that slot at wBattleDEF; A = its low byte (E-0064)
; 19 call sites from 16 routines (e.g. UnreferencedEstimateStrongestFoeHit, AIScore_Upper_Conditions_Sub01_GetBattleDEF_Bank05, AnyFoeHasDEFAtLeast2, AIScore_BiAttack_Sub02_CarryUnlessBattleSlotOutSlotEmpty, ...)
; points at: wBattleDEF
GetBattleDEF_Bank05::
Func_005_4006:: ; address name
    ld hl, wBattleDEF
    jr ReadSlotAIModeIndexed_Bank05_4024_Skip

; A = battle slot: HL = the word for that slot at wBattleMaxHP; A = its low byte (E-0064)
; 19 call sites from 14 routines (e.g. AIScore_Meditate_Conditions_GetBattleMaxHP_Bank05, AIScore_BeDragon_GetBattleMaxHP_Bank05, HPBandOfSlotTemp0, CompareHPWithThreeQuartersMax, ...)
; points at: wBattleMaxHP
GetBattleMaxHP_Bank05::
Func_005_400B:: ; address name
    ld hl, wBattleMaxHP
    jr ReadSlotAIModeIndexed_Bank05_4024_Skip

; A = battle slot: HL = the word for that slot at wBattleMaxMP; A = its low byte (E-0064)
; 12 call sites from 7 routines (e.g. AIScore_BeDragon_GetBattleMaxHP_Bank05, ActorMPBelowThreeQuarters, CompareMPWithThreeQuartersMax, AIScore_MPass_Sub01_CarryUnlessBattleSlotOutSlotEmpty, ...)
; points at: wBattleMaxMP
GetBattleMaxMP_Bank05::
Func_005_4010:: ; address name
    ld hl, wBattleMaxMP
    jr ReadSlotAIModeIndexed_Bank05_4024_Skip

; A = battle slot: HL = the word for that slot at wBattleHP; A = its low byte (E-0064)
; 26 call sites from 22 routines (e.g. UnreferencedEstimateStrongestFoeHit, FoeHPCheckReadsWrongSlot, CheckLoneFoeHPNotBelowAIDamageEstimates, AIScore_Meditate_Conditions_GetBattleMaxHP_Bank05, ...)
; points at: wBattleHP
GetBattleHP_Bank05::
Func_005_4015:: ; address name
    ld hl, wBattleHP
    jr ReadSlotAIModeIndexed_Bank05_4024_Skip

; A = battle slot: HL = the word for that slot at wBattleMP; A = its low byte (E-0064)
; 9 call sites from 9 routines (e.g. FailIfAllyLacksMPForSkillList5AF8, FailIfFoeSkill3DThreatensActorHP, ActorMPBelowThreeQuarters, CompareMPWithThreeQuartersMax, ...)
; points at: wBattleMP
GetBattleMP_Bank05::
Func_005_401A:: ; address name
    ld hl, wBattleMP
    jr ReadSlotAIModeIndexed_Bank05_4024_Skip

; A = battle slot: HL = the word for that slot at wBattleAGL; A = its low byte (E-0064)
; 10 call sites from 8 routines (e.g. AIScore_Speed_Conditions_Sub01_GetBattleAGL_Bank05, AIScore_BeDragon_GetBattleMaxHP_Bank05, AIScore_SquallHit_Conditions_CarryUnlessBattleSlotOutSlotEmpty, AverageAGLOfSideA, ...)
; points at: wBattleAGL
GetBattleAGL_Bank05::
Func_005_401F:: ; address name
    ld hl, wBattleAGL
    jr ReadSlotAIModeIndexed_Bank05_4024_Skip

; A = the byte at wDA53 + A; clobbers HL (the same 10 bytes appear in 5 banks)
; 6 call sites from 5 routines (e.g. FailIfTwoAlliesBelowHalfHP, AIGateCompareAllyStatAverages, AIScore_Berserker_ReadSlotAIModeIndexed_Bank05_4024, AIScore_Ramming_ReadSlotAIModeIndexed_Bank05_4024, ...)
; points at: wSlotAIMode
ReadSlotAIModeIndexed_Bank05_4024:: ; heuristic: follows a terminator; C0
Func_005_4024:: ; address name
    ld hl, wSlotAIMode
    add_a_to_hl
    ld a, [hl]
    ret

ReadSlotAIModeIndexed_Bank05_4024_Skip::
Jump_005_402E:: ; address name
    add a, a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
AddDoubleAToHL_Bank05:: ; heuristic: follows a terminator; C0
Func_005_4038:: ; address name
    add a, a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the reversal, not checked (E-0064) (the same 27 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole, wBattleActor
ActorOnLocalSide_Bank05:: ; heuristic: follows a terminator; C0
Func_005_403F:: ; address name
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
TargetOnLocalSide_Bank05:: ; heuristic: follows a terminator; C0
Func_005_405A:: ; address name
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

; wBattleStatus + 9 * E &= ClearBitMaskTable_Bank05[D] (AddAx9ToHL); not reached from traced code (E-0205)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleStatus
ClearBattleStatusBitsWithMaskD_Bank05:: ; configured code entry (E-0205); C0
Func_005_4075:: ; address name
    ld a, d
    ld hl, ClearBitMaskTable_Bank05
    add_a_to_hl
    ld d, [hl]
    ld a, e
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, d
    and a, [hl]
    ld [hl], a
    ret

; E-0205 (C1: the routine at $4075 reads the byte at $408A + D and ANDs it into the byte at wBattleStatus + 9 * E (AddAx9ToHL); the same 202-byte block of routines and this table sit at $4075-$413F in banks $05, $A1 and $A3).
; record: AND mask
ClearBitMaskTable_Bank05::
Data_005_408A:: ; address name
    db $DF ; id 0
    db $FE ; id 1
    db $00 ; id 2
    db $FD ; id 3
    db $73 ; id 4
    db $EF ; id 5
    db $BF ; id 6

; Sets bit 0 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wLevelUpGains
SetBit0OfLevelUpGainsIndexed_Bank05:: ; configured code entry (E-0205); C0
Func_005_4091:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; Sets bit 1 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wLevelUpGains
SetBit1OfLevelUpGainsIndexed_Bank05:: ; configured code entry (E-0205); C0
Func_005_409E:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; Sets bit 2 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wLevelUpGains
SetBit2OfLevelUpGainsIndexed_Bank05:: ; configured code entry (E-0205); C0
Func_005_40AB:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 2, [hl]
    pop hl
    ret

; A = slot 0-7: returns A = 9 * g(wD968[A]) + 3 * g(wD970[A]) + g(wD978[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes appear in 13 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo
PersonalityIndexOfSlot_Bank05:: ; configured code entry (E-0205); C0
Func_005_40B8:: ; address name
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
CheckSlotStatusBlockWide_Bank05:: ; configured code entry (E-0205); C0
Func_005_410F:: ; address name
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
SlotHasStatus3Or4Bits_Bank05:: ; configured code entry (E-0205); C0
Func_005_412E:: ; address name
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

; cost = wRecordBufferData (byte 0 of the skill record): C = $FF (can pay) when the cost is 0, when the cost is $FF and the actor's MP (wBattleMP word) is non-zero, or when MP >= cost; C = 0 otherwise. Agrees with CheckSkillMPCost that equal MP and cost is enough (E-0063)
; 35 call sites from 35 routines (e.g. AIFireSkillUsable, AIScore_Beat_Conditions, AIScore_Sacrifice_ActorCanPayMPCost_Bank05, AIHealUsable, ...)
; reads: wBattleActor, wRecordBufferData
; points at: wBattleMP
ActorCanPayMPCost_Bank05:: ; heuristic: follows a terminator; C0
Func_005_413F:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleMP
    add a, a
    add_a_to_hl
    ld a, [wRecordBufferData]
    or a, a
    jr z, .done2
    cp a, $FF
    jr nz, .skip
    ld a, [hl+]
    or a, [hl]
    jr nz, .done2
    jr .done

.skip:
    ld c, a
    ld a, [hl+]
    sub a, c
    ld a, [hl]
    sbc a, $00
    jr nc, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

; C = 0 when bit 6 of wCFF3 (skill record buffer) is set and the actor's status byte 1 (wD80D) bit 0 is set, else $FF (compare refusal code 3 of CheckSkillMPCost) (E-0071)
; 5 call sites from 5 routines (e.g. AIFireSkillUsable, AIScore_Beat_Conditions, AIScore_Sacrifice_ActorCanPayMPCost_Bank05, AIHealUsable, ...)
; reads: wRecordBufferData, wBattleActor
; points at: wBattleStatus1
SkillPassesStatus1Bit0Check:: ; heuristic: follows a terminator; C0
Func_005_4169:: ; address name
    ld a, [wRecordBufferData + $5]
    bit 6, a
    jr z, .done
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 0, [hl]
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = $00 when bit 4 of wCFF3 and bit 7 of the actor's status byte 0 are both set, else $FF (E-0122)
; 4 call sites from 4 routines (e.g. AIScore_FireAir_AIAttackSkillUsable_74D1, AIFunc770AAndPassUnlessWCFF3Bit4, AIScore_Curse_Conditions, AIScore_SuckAir_Conditions)
; reads: wRecordBufferData, wBattleActor
; points at: wBattleStatus1
PassUnlessWCFF3Bit4AndActorStatusBit7:: ; heuristic: follows a terminator; C0
Func_005_4183:: ; address name
    ld a, [wRecordBufferData + $5]
    bit 4, a
    jr z, .done
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 7, [hl]
    jp z, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = $00 when bit 5 of wCFF3 and bit 6 of the actor's status byte 0 are both set, else $FF (E-0122)
; 5 call sites from 5 routines (e.g. AIDanceUsable, AIScore_LifeDance_Conditions, AIScore_Hustle_Conditions, AIScore_SideStep_Conditions, ...)
; reads: wRecordBufferData, wBattleActor
; points at: wBattleStatus1
PassUnlessWCFF3Bit5AndActorStatusBit6:: ; heuristic: follows a terminator; C0
Func_005_419E:: ; address name
    ld a, [wRecordBufferData + $5]
    bit 5, a
    jr z, .done
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 6, [hl]
    jp z, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; when bit 3 is set in wD80A or wD80B (either side), C = 0 if the skill wRecordBuffer is $84 or wCFF3 bit 6 is set; otherwise C = $FF (compare refusal code 4 of CheckSkillMPCost, which tests only the actor's side) (E-0071)
; 6 call sites from 6 routines (e.g. AIFireSkillUsable, AIScore_Beat_Conditions, AIScore_Sacrifice_ActorCanPayMPCost_Bank05, AIHealUsable, ...)
; reads: wRecordBuffer, wRecordBufferData
; points at: wSideFlags0
SkillPassesSideFlagBit3Check::
Func_005_41B9:: ; address name
    ld hl, wSideFlags0
    ld a, [hl+]
    or a, [hl]
    and a, $08
    jr z, .done2
    ld a, [wRecordBuffer]
    cp a, $84
    jr z, .done
    ld a, [wRecordBufferData + $5]
    bit 6, a
    jr z, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

; when bit 7 of wCFF6 (in the skill record buffer) is set and the skill wRecordBuffer is the queued action (QueuedActionMatches), C = 0; otherwise C = $FF (E-0071)
; 20 call sites from 20 routines (e.g. AIFireSkillUsable, AIScore_Beat_Conditions, AIScore_Sacrifice_ActorCanPayMPCost_Bank05, AIHealUsable, ...)
; reads: wRecordBufferData, wRecordBuffer
SkillPassesRepeatCheck::
Func_005_41D6:: ; address name
    ld a, [wRecordBufferData + $8]
    bit 7, a
    jr z, .done
    ld a, [wRecordBuffer]
    call QueuedActionMatches
    jr nz, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = $FF when one of the actor's three opposite slots is present with status byte 2 (wD80E) & $22 clear (AnySlotLacksStatusMask), else 0 (E-0114)
; 4 call sites from 4 routines (e.g. AIFireSkillUsable, AIScore_Beat_Conditions, AIScore_Sacrifice_ActorCanPayMPCost_Bank05, AIUsableAndFoeLacksStatus2And5)
; reads: wBattleActor
; points at: wBattleStatus2
AnyFoeLacksStatus2Mask22::
Func_005_41EB:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld b, $03
    ld hl, wBattleStatus2
    ld e, $22
    call AnySlotLacksStatusMask
    ret

; C = $FF when one of the actor's three opposite slots is present with status byte 5 (wD811) & $C0 clear (AnySlotLacksStatusMask), else 0 (E-0071)
; 23 call sites from 23 routines (e.g. AIFireSkillUsable, AIScore_Beat_Conditions, AIScore_Sacrifice_ActorCanPayMPCost_Bank05, AIAttackSkillUsable_74D1, ...)
; reads: wBattleActor
; points at: wBattleStatus5
AnyFoeLacksStatus5Bits67::
Func_005_41FD:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld b, $03
    ld hl, wBattleStatus5
    ld e, $C0
    call AnySlotLacksStatusMask
    ret

; C = $FF when one of the actor's three opposite slots is present with status byte 2 (wD80E) bit 3 clear (AnySlotLacksStatusMask), else 0 (E-0071)
; 5 call sites from 5 routines (e.g. AIFireSkillUsable, AIAttackSkillUsable_74D1, CheckSkillUsableElseResetAISkillScore, AIAttackSkillUsable_770A, ...)
; reads: wBattleActor
; points at: wBattleStatus2
AnyFoeLacksStatus2Bit3::
Func_005_420F:: ; address name
    ld hl, wBattleStatus2
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld b, $03
    ld e, $08
    call AnySlotLacksStatusMask
    ret

; C = $FF when one of the actor's three opposite slots is present with status byte 3 (wD80F) & $C0 and byte 4 (wD810) & $0C both clear, else 0 (E-0071)
; 11 call sites from 11 routines (e.g. AIScore_Skill00_Conditions, AIFunc74D1AndFoeLacksStatus3And4, CheckSkillUsableElseResetAISkillScore, AIScore_PsycheUp_Conditions, ...)
; reads: wBattleActor
; points at: wBattleStatus3, wBattleStatus4
AnyFoeLacksStatus3And4Bits::
Func_005_4221:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl]
    and a, $C0
    and a, a
    jr z, .call_add_ax9_to_hl

.next:
    inc c
    dec b
    jr nz, .loop
    jr .done

.call_add_ax9_to_hl:
    ld a, c
    ld hl, wBattleStatus4
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    and a, a
    jr z, .done2
    jr .next

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

; meant to return C = $FF when one of the actor's three opposite slots is present with non-zero MP and 0 otherwise, but it addresses the MP word at wBattleMP + 16 * slot (swap a) instead of 2 * slot, so for foes in slots 4-6 it reads 64-96 bytes past the array (a likely bug; executed, test FoeMPCheckOffset) (E-0099)
; 4 call sites from 4 routines (e.g. AIScore_RobMagic_Conditions, AIScore_OddDance_Conditions, AIScore_ThickFog_Conditions, AIScore_SuckAll_Conditions)
; reads: wBattleActor
; points at: wBattleMP
AnyFoeHasMPReadsWrongOffset:: ; heuristic: follows a terminator; C0
Func_005_4259:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld hl, wBattleMP
    ld a, c
    swap a
    add_a_to_hl
    ld a, [hl+]
    and a, a
    jr nz, .done
    ld a, [hl+]
    and a, a
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; only called from AIScore_TakeMagic_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_TakeMagic_Conditions)
; reads: wBattleActor, wRecordBuffer, hTemp0
; writes: wRecordBuffer, wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3
; points at: wBattleSkillsPrefix, hTemp0
AIScore_TakeMagic_Conditions_ReadSlotAIModeIndexed_Bank05:: ; heuristic: follows a terminator; C0
Func_005_4286:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $02
    jp c, .done
    ld a, [wRecordBuffer]
    ld l, a
    ld a, [wRecordBuffer + $1]
    ld h, a
    push hl
    ld b, $03
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld e, a

.loop:
    ld a, e
    ld hl, wBattleSkillsPrefix
    swap a
    add_a_to_hl
    ld a, e
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    ld c, $00

.loop2:
    ld a, [hl]
    cp a, $FF
    jr z, .skip
    ld [wRecordBuffer], a
    xor a, a
    ld [wRecordBuffer + $1], a
    ld a, $07
    ld [wBattleArg0], a
    ld a, $01
    ld [wBattleArg1], a
    push hl
    push bc
    push de
    ld hl, hTemp0
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    farcall LoadSkillRecordPart
    pop de
    pop bc
    pop hl
    ldh a, [hTemp0]
    bit 0, a
    jr nz, .set_record_buffer
    inc c
    inc hl
    inc hl
    ld a, c
    cp a, $08
    jr c, .loop2
    jr .next

.skip:
    ld a, $08
    sub a, c
    add a, a
    add a, l
    ld l, a
    jr nc, .next
    inc h

.next:
    inc e
    dec b
    jr nz, .loop
    pop hl
    ld a, l
    ld [wRecordBuffer], a
    ld a, h
    ld [wRecordBuffer + $1], a
    ld c, $00
    ret

.set_record_buffer:
    pop hl
    ld a, l
    ld [wRecordBuffer], a
    ld a, h
    ld [wRecordBuffer + $1], a
    ld c, $FF
    ret

.done:
    ld c, $01
    ret

; C = $FF when one of the actor's three opposite slots is present with status byte 0 (wBattleStatus) bit 6 clear (AnySlotLacksStatusMask), else 0 (E-0071)
; 16 call sites from 16 routines (e.g. AIScore_Sacrifice_ActorCanPayMPCost_Bank05, AIScore_Farewell_Conditions, AIScore_TakeMagic_Conditions, AIScore_StopSpell_Conditions, ...)
; reads: wBattleActor
; points at: wBattleStatus
AnyFoeLacksStatus0Bit6:: ; heuristic: follows a terminator; C0
Func_005_431C:: ; address name
    ld hl, wBattleStatus
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld b, $03
    ld e, $40
    call AnySlotLacksStatusMask
    ret

; C = 1 when wDA53[actor] (the AI mode) is below 2; otherwise C = $FF when one of the actor's three opposite slots is present with status byte 1 (wD80D) bit 0 clear and a skill whose record part has bit 6 set (SlotHasSkillWithFlagD, D = $40), else 0; wRecordBuffer kept (E-0099)
; 4 call sites from 4 routines (e.g. AIScore_StopSpell_Conditions, AIScore_MagicBack_Conditions, AIScore_MagicWall_Conditions, AIScore_ThickFog_Conditions)
; reads: wBattleActor, wRecordBuffer
; writes: wRecordBuffer
; points at: wBattleStatus1
AnyActiveFoeHasSkillFlag40:: ; heuristic: follows a terminator; C0
Func_005_432E:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $02
    jr c, .done
    ld a, [wRecordBuffer]
    push af
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld d, $40

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 0, [hl]
    jr nz, .next
    call SlotHasSkillWithFlagD
    jr nz, .set_record_buffer

.next:
    inc c
    dec b
    jr nz, .loop
    pop af
    ld [wRecordBuffer], a
    ld c, $00
    ret

.set_record_buffer:
    pop af
    ld [wRecordBuffer], a
    ld c, $FF
    ret

.done:
    ld c, $01
    ret

; C = 1 when the AI mode is below 2; otherwise C = $FF when one of the actor's three opposite slots is present with a skill whose record part has bit 4 set (SlotHasSkillWithFlagD, D = $10), else 0; wRecordBuffer kept (E-0099)
; 2 call sites from 2 routines (e.g. AIScore_Barrier_Conditions, AIScore_SuckAll_Conditions)
; reads: wBattleActor, wRecordBuffer
; writes: wRecordBuffer
AnyFoeHasSkillFlag10:: ; heuristic: follows a terminator; C0
Func_005_4373:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $02
    jr c, .done
    ld a, [wRecordBuffer]
    push af
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld d, $10

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call SlotHasSkillWithFlagD
    jr nz, .set_record_buffer

.next:
    inc c
    dec b
    jr nz, .loop
    pop af
    ld [wRecordBuffer], a
    ld c, $00
    ret

.set_record_buffer:
    pop af
    ld [wRecordBuffer], a
    ld c, $FF
    ret

.done:
    ld c, $01
    ret

; only called from AIScore_DanceShut_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_DanceShut_Conditions)
; reads: wBattleActor, wRecordBuffer
; writes: wRecordBuffer
; points at: wBattleStatus1
AIScore_DanceShut_Conditions_ReadSlotAIModeIndexed_Bank05:: ; heuristic: follows a terminator; C0
Func_005_43AD:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $02
    jr c, .done
    ld a, [wRecordBuffer]
    push af
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld d, $20

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 6, [hl]
    jr nz, .next
    call SlotHasSkillWithFlagD
    jr nz, .set_record_buffer

.next:
    inc c
    dec b
    jr nz, .loop
    pop af
    ld [wRecordBuffer], a
    ld c, $00
    ret

.set_record_buffer:
    pop af
    ld [wRecordBuffer], a
    ld c, $FF
    ret

.done:
    ld c, $01
    ret

; C = $FF when wCFEF is 0 or an occupied foe's resistance field for skill wCFEF is below 3, else $00 (E-0127)
; 11 call sites from 11 routines (e.g. AIFireSkillUsable, AIScore_Beat_Conditions, AIScore_Sacrifice_ActorCanPayMPCost_Bank05, AIAttackSkillUsable_74D1, ...)
; reads: wRecordBufferData, wBattleActor
; points at: wSlotResistances
AnyFoeNotFullyResistant::
Func_005_43F2:: ; address name
    ld a, [wRecordBufferData + $1]
    or a, a
    jr z, .done
    dec a
    ld hl, AnyFoeNotFullyResistant_Data
    add a, a
    add_a_to_hl
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, wSlotResistances
    add a, a
    add a, c
    add a, a
    add a, c
    add a, d
    add a, l
    ld l, a
    jr nc, .loop
    inc h

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    call Get2BitFieldEOfHL
    cp a, $03
    jr nz, .done

.skip:
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = $FF when one of the actor's three opposite slots is present with DEF (GetBattleDEF_Bank05) of 2 or more, else 0 (E-0099)
; 3 call sites from 3 routines (e.g. AIScore_TwinSlash_Conditions, AIScore_Skill00, AIScore_SickLick)
; reads: wBattleActor
AnyFoeHasDEFAtLeast2::
Func_005_443B:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call GetBattleDEF_Bank05
    ld a, h
    or a, a
    jr nz, .done
    ld a, l
    cp a, $02
    jr nc, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; only called from AIScore_SquallHit_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_SquallHit_Conditions)
; reads: wBattleActor
AIScore_SquallHit_Conditions_CarryUnlessBattleSlotOutSlotEmpty:: ; heuristic: follows a terminator; C0
Func_005_4461:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call GetBattleAGL_Bank05
    ld a, h
    or a, a
    jr nz, .done
    ld a, l
    cp a, $02
    jr nc, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; only called from AIScore_FireAir_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. AIScore_FireAir_AIAttackSkillUsable_74D1)
; reads: wBattleActor
; points at: wBattleStatus2
AIScore_FireAir_Sub02_AnySlotLacksStatusMask:: ; heuristic: follows a terminator; C0
Func_005_4487:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld hl, wBattleStatus2
    ld e, $40
    ld b, $03
    call AnySlotLacksStatusMask
    ret

; C = $FF when one of the actor's three opposite slots is present with status byte 0 bit 4 clear (AnySlotLacksStatusMask), else 0 (E-0114)
; 3 call sites from 3 routines (e.g. AIPanicAllUsable, AIScore_PaniDance_Conditions, AIScore_SuckAll_Conditions)
; reads: wBattleActor
; points at: wBattleStatus
AnyFoeLacksStatus0Bit4:: ; heuristic: follows a terminator; C0
Func_005_4499:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld b, $03
    ld hl, wBattleStatus
    ld e, $10
    call AnySlotLacksStatusMask
    ret

; only called from AIScore_PoisonAir_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_PoisonAir_Conditions)
; reads: wBattleActor
; points at: wBattleStatus
AIScore_PoisonAir_Conditions_AnySlotLacksStatusMask:: ; heuristic: follows a terminator; C0
Func_005_44AB:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld hl, wBattleStatus
    ld e, $02
    ld b, $03
    call AnySlotLacksStatusMask
    ret

; C = $FF when one of the actor's three opposite slots is present with status byte 0 (wBattleStatus) & $03 clear (AnySlotLacksStatusMask), else 0 (E-0099)
; 2 call sites from 2 routines (e.g. AIScore_PoisonHit_Conditions, AIScore_PoisonGas_Conditions)
; reads: wBattleActor
; points at: wBattleStatus
AnyFoeLacksStatus0Bits01:: ; heuristic: follows a terminator; C0
Func_005_44BD:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld b, $03
    ld hl, wBattleStatus
    ld e, $03
    call AnySlotLacksStatusMask
    ret

; C = $FF when one of the actor's three opposite slots is present with status byte 0 (wBattleStatus) & $CC clear (AnySlotLacksStatusMask), else 0 (E-0077)
; 7 call sites from 7 routines (e.g. AIParalyzeUsable, AIScore_Sleep_Conditions, AIScore_SleepAir_Conditions, AIScore_Imitate_Conditions, ...)
; reads: wBattleActor
; points at: wBattleStatus
AnyFoeLacksStatus0MaskCC::
Func_005_44CF:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld b, $03
    ld e, $CC
    ld hl, wBattleStatus
    call AnySlotLacksStatusMask
    ret

; only called from AIScore_AquaWall_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_AquaWall_Conditions)
; reads: wBattleActor, wRecordBuffer
; writes: wRecordBuffer
; points at: wBattleStatus1
AIScore_AquaWall_Conditions_ReadSlotAIModeIndexed_Bank05:: ; heuristic: follows a terminator; C0
Func_005_44E1:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $02
    jr c, .done
    ld a, [wRecordBuffer]
    push af
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld d, $08

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    ld a, [hl]
    and a, $C1
    jr nz, .next
    call SlotHasSkillWithFlagD
    jr nz, .set_record_buffer

.next:
    inc c
    dec b
    jr nz, .loop
    pop af
    ld [wRecordBuffer], a
    ld c, $00
    ret

.set_record_buffer:
    pop af
    ld [wRecordBuffer], a
    ld c, $FF
    ret

.done:
    ld c, $01
    ret

; C = $FF when one of the actor's three opposite slots is present with status byte 5 (wD811) & $03 clear (AnySlotLacksStatusMask), else 0 (E-0094)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wBattleStatus5
AnyFoeLacksStatus5Bits01:: ; heuristic: follows a terminator; C0
Func_005_4527:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld b, $03
    ld hl, wBattleStatus5
    ld e, $03
    call AnySlotLacksStatusMask
    ret

; C = $FF when one of the actor's three opposite slots is present with status byte 5 (wD811) bit 0 clear and status byte 1 (wD80D) bit 1 clear, else 0 (E-0094)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wBattleStatus5, wBattleStatus1
AnyFoeLacksStatus5Bit0And1Bit1:: ; heuristic: follows a terminator; C0
Func_005_4539:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hl]
    and a, $01
    jr nz, .next
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    ld a, [hl]
    and a, $02
    jr z, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = $FF when one of the actor's three opposite slots is present with status byte 5 (wD811) bit 1 clear and status byte 1 (wD80D) bit 1 clear, else 0 (E-0094)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wBattleStatus5, wBattleStatus1
AnyFoeLacksStatus5Bit1And1Bit1:: ; heuristic: follows a terminator; C0
Func_005_456B:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hl]
    and a, $02
    jr nz, .next
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    ld a, [hl]
    and a, $02
    jr z, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = $FF when one of the actor's three opposite slots is present with status byte 5 (wD811) & $03 clear and status byte 1 (wD80D) bit 1 clear, else 0 (E-0100)
; 6 call sites from 6 routines (e.g. AIScore_Surround_Conditions, AIScore_SandStorm_Conditions, AIScore_Radiant_Conditions, AIScore_Dodge_Conditions, ...)
; reads: wBattleActor
; points at: wBattleStatus5, wBattleStatus1
AnyFoeLacksStatus5Bits01And1Bit1:: ; heuristic: follows a terminator; C0
Func_005_459D:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hl]
    and a, $03
    jr nz, .next
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    ld a, [hl]
    and a, $02
    jr z, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = $FF when one of the actor's three opposite slots is present with status byte 1 (wD80D) bit 0 clear, else 0 (E-0099)
; 2 call sites from 2 routines (e.g. AIScore_StopSpell_Conditions, AIScore_MagicWall_Conditions)
; reads: wBattleActor
; points at: wBattleStatus1
AnyFoeLacksStatus1Bit0:: ; heuristic: follows a terminator; C0
Func_005_45CF:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld hl, wBattleStatus1
    ld b, $03
    ld e, $01
    call AnySlotLacksStatusMask
    ret

; C = $FF when one of the actor's three opposite slots is present with status byte 1 (wD80D) bit 7 clear, else 0 (E-0099)
; 3 call sites from 3 routines (e.g. AIScore_Barrier_Conditions, AIScore_MouthShut_Conditions, AIScore_SuckAll_Conditions)
; reads: wBattleActor
; points at: wBattleStatus1
AnyFoeLacksStatus1Bit7:: ; heuristic: follows a terminator; C0
Func_005_45E1:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld hl, wBattleStatus1
    ld b, $03
    ld e, $80
    call AnySlotLacksStatusMask
    ret

; only called from AIScore_DanceShut_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_DanceShut_Conditions)
; reads: wBattleActor
; points at: wBattleStatus1
AIScore_DanceShut_Conditions_AnySlotLacksStatusMask:: ; heuristic: follows a terminator; C0
Func_005_45F3:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld hl, wBattleStatus1
    ld b, $03
    ld e, $40
    call AnySlotLacksStatusMask
    ret

; C = $FF when at least one of the actor's three opposite slots passes CheckSlotStatusBlock (present and none of its blocking status bits set); C = 0 when all three are absent or blocked (E-0066)
; 22 call sites from 22 routines (e.g. AIParalyzeUsable, AIScore_Upper_Conditions, AIScore_Speed_Conditions, AIScore_Slow_Conditions, ...)
; reads: wBattleActor
AnyFoeNotBlocked::
Func_005_4605:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CheckSlotStatusBlock
    jr nc, .done
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; only called from AIScore_LegSweep_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_LegSweep_Conditions)
; reads: wBattleActor
; points at: wSlotBodyFlags, wBattleStatus3
AIScore_LegSweep_Conditions_CarryUnlessBattleSlotOutSlotEmpty:: ; heuristic: follows a terminator; C0
Func_005_461F:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, wSlotBodyFlags
    add a, l
    ld l, a
    jr nc, .loop
    inc h

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    bit 4, [hl]
    jr nz, .next
    push hl
    ld a, c
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl]
    pop hl
    and a, $C0
    and a, a
    jr nz, .next
    push hl
    ld a, c
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl]
    pop hl
    and a, $0C
    and a, a
    jr z, .done

.next:
    inc hl
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = $FF when one of the actor's three opposite slots is present with status byte 3 (wD80F) entirely clear (AnySlotLacksStatusMask with mask $FF), else 0 (E-0078)
; 6 call sites from 6 routines (e.g. AILickSkillUsable_7AD8, AIStatusLickUsable, AIScore_Geyser_Conditions, AIScore_HealUs_AnyFoeLacksStatus0MaskCC, ...)
; reads: wBattleActor
; points at: wBattleStatus3
AnyFoeHasClearStatus3::
Func_005_4664:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld b, $03
    ld hl, wBattleStatus3
    ld e, $FF
    call AnySlotLacksStatusMask
    ret

; C = 1 when the AI mode is below 2; in mode 3 with wCFEF set, $00 when a foe has status 1 mask $22; otherwise $FF (E-0125)
; 7 call sites from 7 routines (e.g. AIScore_Sacrifice_ActorCanPayMPCost_Bank05, AIScore_Firebal, AIScore_Beat, AIScore_Slow, ...)
; reads: wBattleActor
; points at: wBattleStatus2
AIGateFoeStatus1Mask22::
Func_005_4676:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $02
    jr c, .done3
    call TestWCFEF
    jr z, .done2
    cp a, $03
    jr nz, .done2
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus2
    call AddAx9ToHL
    ld a, [hl]
    and a, $22
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    jr .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

.done3:
    ld c, $01
    ret

; only called from AIScore_FireAir (E-0047)
; 1 call site from 1 routine (e.g. AIScore_FireAir)
; reads: wBattleActor
; points at: wBattleStatus2
AIScore_FireAir_ReadSlotAIModeIndexed_Bank05:: ; heuristic: follows a terminator; C0
Func_005_46B4:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $02
    jr c, .done3
    call TestWCFEF
    jr z, .done2
    cp a, $03
    jr nz, .done2
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus2
    call AddAx9ToHL
    ld a, [hl]
    and a, $40
    and a, a
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    jr .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

.done3:
    ld c, $01
    ret

; C = 0 when the actor's status byte 4 (wD810) & $03 is set, else C = $FF (the correct form of the test ActorStatus4CheckReadsAddress gets wrong) (E-0094)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wBattleStatus4
ActorLacksStatus4Bits01:: ; heuristic: follows a terminator; C0
Func_005_46F3:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    ld a, [hl]
    and a, $03
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = 0 when the actor's status byte 4 (wD810 + 9 * actor) & $C0 is set, else C = $FF (E-0071)
; 17 call sites from 17 routines (e.g. AIScore_MPass_ActorLacksStatus4Bits67, AIScore_MegaMagic_AIAttackSkillUsable_74D1, AIScore_ChargeUp_Conditions, AIScore_PsycheUp_Conditions, ...)
; reads: wBattleActor
; points at: wBattleStatus4
ActorLacksStatus4Bits67::
Func_005_4707:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    ld a, [hl]
    and a, $C0
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = 0 when the actor's status byte 1 (wD80D) bit 2 is set, else C = $FF (E-0094)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wBattleStatus1
ActorLacksStatus1Bit2:: ; heuristic: follows a terminator; C0
Func_005_471B:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 2, [hl]
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = 0 when the actor's status byte 1 (wD80D) bit 3 is set, else C = $FF (E-0094)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wBattleStatus1
ActorLacksStatus1Bit3:: ; heuristic: follows a terminator; C0
Func_005_472E:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 3, [hl]
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; only called from AIScore_TakeMagic_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_TakeMagic_Conditions)
; reads: wBattleActor
; points at: wBattleStatus2
AIScore_TakeMagic_Conditions_AddAx9ToHL:: ; heuristic: follows a terminator; C0
Func_005_4741:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit 0, [hl]
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; only called from AIScore_TailWind_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_TailWind_Conditions)
; reads: wBattleActor
; points at: wBattleStatus2
AIScore_TailWind_Conditions_AddAx9ToHL:: ; heuristic: follows a terminator; C0
Func_005_4754:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit 6, [hl]
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = $FF when one of the actor's own three slots (the actor included) is present with status byte 2 (wD80E) bit 6 clear, else 0 (E-0099)
; 2 call sites from 2 routines (e.g. AIScore_StormWind_Conditions, AIScore_SuckAll_Conditions)
; reads: wBattleActor
; points at: wBattleStatus2
AnyAllyLacksStatus2Bit6:: ; heuristic: follows a terminator; C0
Func_005_4767:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld b, $03
    ld e, $40
    ld hl, wBattleStatus2
    call AnySlotLacksStatusMask
    ret

; looks at the actor's own three slots other than the actor: C = $FF when one of them is present with status byte 0 (wBattleStatus) bit 6 clear, or when none of them is present; otherwise (every present ally has bit 6) C = 0 (E-0092)
; 11 call sites from 11 routines (e.g. AIScore_MPass_ActorLacksStatus4Bits67, AIScore_TwinSlash_Conditions, AIScore_Kamikaze_AIFunc779FAnd43F2AndActorHPNotOne, AIScore_Sacrifice, ...)
; reads: wBattleActor
; points at: wBattleStatus
AllOtherAlliesHaveStatus0Bit6::
Func_005_4777:: ; address name
    ld a, [wBattleActor]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03
    ld d, $00

.loop:
    ld a, c
    cp a, e
    jr z, .next
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    inc d
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 6, [hl]
    jr z, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld a, d
    or a, a
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; only called from AIScore_Antidote_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Antidote_Conditions)
; reads: wBattleActor
; points at: wBattleStatus
AIScore_Antidote_Conditions_AnySlotHasStatusMask:: ; heuristic: follows a terminator; C0
Func_005_47A5:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld b, $03
    ld hl, wBattleStatus
    ld e, $03
    call AnySlotHasStatusMask
    ret

; only called from AIScore_NumbOff_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_NumbOff_Conditions)
; reads: wBattleActor
; points at: wBattleStatus
AIScore_NumbOff_Conditions_AnySlotHasStatusMask:: ; heuristic: follows a terminator; C0
Func_005_47B5:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld b, $03
    ld hl, wBattleStatus
    ld e, $CC
    call AnySlotHasStatusMask
    ret

; only called from AIScore_DeChaos_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_DeChaos_Conditions)
; reads: wBattleActor
; points at: wBattleStatus
AIScore_DeChaos_Conditions_AnySlotHasStatusMask:: ; heuristic: follows a terminator; C0
Func_005_47C5:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld b, $03
    ld hl, wBattleStatus
    ld e, $10
    call AnySlotHasStatusMask
    ret

; only called from AIScore_CurseOff_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_CurseOff_Conditions)
; reads: wBattleActor
; points at: wBattleStatus
AIScore_CurseOff_Conditions_AnySlotHasStatusMask:: ; heuristic: follows a terminator; C0
Func_005_47D5:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld b, $03
    ld hl, wBattleStatus
    ld e, $20
    call AnySlotHasStatusMask
    ret

; walks the actor's own three slots through their 7-byte wDA76 entries: C = $FF when a present slot's entry & $3C is not $3C, else 0 (E-0094)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
AnyAllyWDA76Bits2To5NotAllSet:: ; heuristic: follows a terminator; C0
Func_005_47E5:: ; address name
    ld a, [wBattleActor]
    and a, $04

AnyAllyWDA76Bits2To5NotAllSet_Skip::
Jump_005_47EA:: ; address name
    ld c, a
    ld b, $03
    ld hl, wSlotResistances + $4
    call ReadByteAtHLPlus4APlus3C_Bank05

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    ld a, [hl]
    and a, $3C
    cp a, $3C
    jr nz, .done

.skip:
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; only called from AIScore_SuckAir_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_SuckAir_Conditions)
; reads: wBattleActor
AIScore_SuckAir_Conditions_ReadBattleActor:: ; heuristic: follows a terminator; C0
Func_005_4812:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    jp AnyAllyWDA76Bits2To5NotAllSet_Skip

; only called from AIScore_SlimeBlow_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_SlimeBlow_Conditions)
AIScore_SlimeBlow_Conditions_ToFoeOfFamilyEPresent::
Func_005_481C:: ; address name
    ld e, $00
    call FoeOfFamilyEPresent
    ret

; only called from AIScore_DrakSlash_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_DrakSlash_Conditions)
AIScore_DrakSlash_Conditions_ToFoeOfFamilyEPresent::
Func_005_4822:: ; address name
    ld e, $01
    call FoeOfFamilyEPresent
    ret

; only called from AIScore_BeastCut_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_BeastCut_Conditions)
AIScore_BeastCut_Conditions_ToFoeOfFamilyEPresent::
Func_005_4828:: ; address name
    ld e, $02
    call FoeOfFamilyEPresent
    ret

; only called from AIScore_BirdBlow_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_BirdBlow_Conditions)
AIScore_BirdBlow_Conditions_ToFoeOfFamilyEPresent::
Func_005_482E:: ; address name
    ld e, $03
    call FoeOfFamilyEPresent
    ret

; only called from AIScore_BugBlow_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_BugBlow_Conditions)
AIScore_BugBlow_Conditions_ToFoeOfFamilyEPresent::
Func_005_4834:: ; address name
    ld e, $05
    call FoeOfFamilyEPresent
    ret

; only called from AIScore_Shears_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Shears_Conditions)
AIScore_Shears_Conditions_ToFoeOfFamilyEPresent::
Func_005_483A:: ; address name
    ld e, $04
    call FoeOfFamilyEPresent
    ret

; only called from AIScore_DevilCut_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_DevilCut_Conditions)
AIScore_DevilCut_Conditions_ToFoeOfFamilyEPresent::
Func_005_4840:: ; address name
    ld e, $06
    call FoeOfFamilyEPresent
    ret

; only called from AIScore_ZombieCut_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_ZombieCut_Conditions)
AIScore_ZombieCut_Conditions_ToFoeOfFamilyEPresent::
Func_005_4846:: ; address name
    ld e, $07
    call FoeOfFamilyEPresent
    ret

; only called from AIScore_CleanCut_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_CleanCut_Conditions)
AIScore_CleanCut_Conditions_ToFoeOfFamilyEPresent::
Func_005_484C:: ; address name
    ld e, $08
    call FoeOfFamilyEPresent
    ret

; only called from AIScore_AquaCut_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_AquaCut_Conditions)
AIScore_AquaCut_Conditions_ToFoeOfFamilyEPresent::
Func_005_4852:: ; address name
    ld e, $09
    call FoeOfFamilyEPresent
    ret

; only called from AIScore_MetalCut_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_MetalCut_Conditions)
; reads: wBattleActor
; points at: wSlotBodyFlags
AIScore_MetalCut_Conditions_CarryUnlessBattleSlotOutSlotEmpty:: ; heuristic: follows a terminator; C0
Func_005_4858:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld hl, wSlotBodyFlags
    add_a_to_hl
    bit 0, [hl]
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    jr .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

; only called from AIScore_UltraDown_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_UltraDown_Conditions)
; reads: wBattleActor
; points at: wBattleStatus1
AIScore_UltraDown_Conditions_CarryUnlessBattleSlotOutSlotEmpty:: ; heuristic: follows a terminator; C0
Func_005_4880:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld hl, wSlotResistances + $2
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $30
    cp a, $30
    jr z, .next
    ld a, c
    call GetBattleDEF_Bank05
    ld a, h
    jr nz, .done
    ld a, l
    cp a, $02
    jr nc, .done
    ld a, c
    call GetBattleAGL_Bank05
    ld a, h
    jr nz, .done
    ld a, l
    cp a, $02
    jr nc, .done
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 1, [hl]
    jr z, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = $FF when one of the actor's three opposite slots is present with status byte 1 bit 1 clear, status byte 5 & $03 clear and the low 2 bits of its wDA73 entry not 3, else 0 (E-0099)
; 3 call sites from 3 routines (e.g. AIScore_Surround_Conditions, AIScore_SandStorm_Conditions, AIScore_Radiant_Conditions)
; reads: wBattleActor
; points at: wBattleStatus1
AnyFoeOpenToWDA73Field0::
Func_005_48C9:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 1, [hl]
    jr nz, .next
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $03
    jr nz, .next
    ld a, c
    ld hl, wSlotResistances + $1
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $03
    cp a, $03
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; only called from AIScore_StopSpell_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_StopSpell_Conditions)
; reads: wRecordBuffer, wBattleActor
; writes: wRecordBuffer
; points at: wBattleStatus1
AIScore_StopSpell_Conditions_CarryUnlessBattleSlotOutSlotEmpty:: ; heuristic: follows a terminator; C0
Func_005_4904:: ; address name
    ld a, [wRecordBuffer]
    push af
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld d, $40

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 0, [hl]
    jr nz, .next
    call SlotHasSkillWithFlagD
    jr z, .next
    ld a, c
    ld hl, wSlotResistances + $2
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $03
    cp a, $03
    jr nz, .set_record_buffer

.next:
    inc c
    dec b
    jr nz, .loop
    pop af
    ld [wRecordBuffer], a
    ld c, $00
    ret

.set_record_buffer:
    pop af
    ld [wRecordBuffer], a
    ld c, $FF
    ret

; C = $FF when one of the actor's three opposite slots is present with non-zero MP (GetBattleMP_Bank05) and bits 3-2 of its wDA74 entry not both set, else 0 (E-0100)
; 2 call sites from 2 routines (e.g. AIScore_RobMagic_Conditions, AIScore_OddDance_Conditions)
; reads: wBattleActor
AnyFoeWithMPOpenToWDA74Field1:: ; heuristic: follows a terminator; C0
Func_005_4949:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call GetBattleMP_Bank05
    ld a, h
    or a, l
    jr z, .next
    ld a, c
    ld hl, wSlotResistances + $2
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $0C
    cp a, $0C
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; only called from AIScore_Sap_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Sap_Conditions)
; reads: wBattleActor
AIScore_Sap_Conditions_CarryUnlessBattleSlotOutSlotEmpty::
Func_005_4977:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call GetBattleDEF_Bank05
    ld a, h
    or a, a
    jr nz, .call_read_byte_at_hl_plus4_a_plus3_c_bank05
    ld a, l
    cp a, $02
    jr c, .next

.call_read_byte_at_hl_plus4_a_plus3_c_bank05:
    ld a, c
    ld hl, wSlotResistances + $3
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $30
    cp a, $30
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; only called from AIScore_Slow_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Slow_Conditions)
; reads: wBattleActor
AIScore_Slow_Conditions_CarryUnlessBattleSlotOutSlotEmpty:: ; heuristic: follows a terminator; C0
Func_005_49AA:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call GetBattleAGL_Bank05
    ld a, h
    or a, a
    jr nz, .call_read_byte_at_hl_plus4_a_plus3_c_bank05
    ld a, l
    cp a, $02
    jr c, .next

.call_read_byte_at_hl_plus4_a_plus3_c_bank05:
    ld a, c
    ld hl, wSlotResistances + $3
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $0C
    cp a, $0C
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = $FF when one of the actor's three opposite slots is present with status byte 0 & $03 clear and the low 2 bits of its wDA76 entry not 3, else 0 (E-0099)
; 3 call sites from 3 routines (e.g. AIScore_PoisonHit_Conditions, AIScore_PoisonGas_Conditions, AIScore_PoisonAir_Conditions)
; reads: wBattleActor
; points at: wBattleStatus
AnyFoeOpenToWDA76Field0::
Func_005_49DD:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $03
    jr nz, .next
    ld a, c
    ld hl, wSlotResistances + $4
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $03
    cp a, $03
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = $FF when one of the actor's three opposite slots is present with status byte 0 bit 6 clear and bits 7-6 of its wDA77 entry not both set, else 0 (E-0099)
; 2 call sites from 2 routines (e.g. AIScore_Paralyze_Conditions, AIScore_PalsyAir_Conditions)
; reads: wBattleActor
; points at: wBattleStatus
AnyFoeOpenToWDA77Field3:: ; heuristic: follows a terminator; C0
Func_005_4A10:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $40
    jr nz, .next
    ld a, c
    ld hl, wSlotResistances + $5
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $C0
    cp a, $C0
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; only called from AIScore_Curse_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Curse_Conditions)
; reads: wBattleActor
; points at: wBattleStatus
AIScore_Curse_Conditions_CarryUnlessBattleSlotOutSlotEmpty:: ; heuristic: follows a terminator; C0
Func_005_4A43:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $20
    jr nz, .next
    ld a, c
    ld hl, wSlotResistances + $5
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $30
    cp a, $30
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; only called from AIScore_DanceShut_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_DanceShut_Conditions)
; reads: wRecordBuffer, wBattleActor
; writes: wRecordBuffer
; points at: wBattleStatus1
AIScore_DanceShut_Conditions_CarryUnlessBattleSlotOutSlotEmpty:: ; heuristic: follows a terminator; C0
Func_005_4A76:: ; address name
    ld a, [wRecordBuffer]
    push af
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld d, $20

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 6, [hl]
    jr nz, .next
    call SlotHasSkillWithFlagD
    jr z, .next
    ld a, c
    ld hl, wSlotResistances + $5
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $03
    cp a, $03
    jr nz, .set_record_buffer

.next:
    inc c
    dec b
    jr nz, .loop
    pop af
    ld [wRecordBuffer], a
    ld c, $00
    ret

.set_record_buffer:
    pop af
    ld [wRecordBuffer], a
    ld c, $FF
    ret

; C = $FF when an occupied foe without status bit 7 has a skill with flag $10 and bits 6-7 of its wDA78 field below 3, else $00 (wRecordBuffer preserved) (E-0125)
; no direct call (reached through a table, a jump or a vector)
; reads: wRecordBuffer, wBattleActor
; writes: wRecordBuffer
; points at: wBattleStatus1
AnyFoeWithSkillFlag10VulnerableWDA78:: ; heuristic: follows a terminator; C0
Func_005_4ABB:: ; address name
    ld a, [wRecordBuffer]
    push af
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld d, $10

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 7, [hl]
    jr nz, .next
    call SlotHasSkillWithFlagD
    jr z, .next
    ld a, c
    ld hl, wSlotResistances + $6
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $C0
    cp a, $C0
    jr nz, .set_record_buffer

.next:
    inc c
    dec b
    jr nz, .loop
    pop af
    ld [wRecordBuffer], a
    ld c, $00
    ret

.set_record_buffer:
    pop af
    ld [wRecordBuffer], a
    ld c, $FF
    ret

; C = $FF when an ally slot is marked out (wBattleSlotOut = 1) or an occupied ally has HP below a quarter of its max, else $00 (E-0125)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wBattleSlotOut
AnyAllyOutOrHPBelowQuarter:: ; heuristic: follows a terminator; C0
Func_005_4B00:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld b, $03

.loop:
    ld a, [hl+]
    cp a, $01
    jr z, .done2
    dec b
    jr nz, .loop
    ld b, $03

.loop2:
    push bc
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .restore
    call GetBattleMaxHP_Bank05
    push hl
    ld a, c
    call GetBattleHP_Bank05
    add hl, hl
    add hl, hl
    pop bc
    call CompareHLToBC
    jr c, .done

.restore:
    pop bc
    inc c
    dec b
    jr nz, .loop2
    ld c, $00
    ret

.done:
    pop bc

.done2:
    ld c, $FF
    ret

; C = $FF when at least two of the actor's three opposite slots are present, else 0 (the opposite of FewerThanTwoFoesPresent) (E-0100)
; 5 call sites from 5 routines (e.g. AIScore_RainSlash_Conditions, AIScore_Skill00, AIScore_Sacrifice, AIScore_FireAir, ...)
; reads: wBattleActor
AtLeastTwoFoesPresent::
Func_005_4B3D:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    inc e

.next:
    inc c
    dec b
    jr nz, .loop
    ld a, e
    cp a, $02
    jr nc, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; only called from AIScore_TatsuCall_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_TatsuCall_Conditions)
; reads: wBattleActor
; points at: wBattleSlotOut
AIScore_TatsuCall_Conditions_ReadBattleActor:: ; heuristic: follows a terminator; C0
Func_005_4B5F:: ; address name
    ld a, [wBattleActor]
    and a, $04
    or a, $03
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    or a, a
    jr z, .done
    jr .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

; C = $FF when one of the actor's side's three wBattleSlotOut bytes is 1, else 0 (E-0099)
; 4 call sites from 4 routines (e.g. AIScore_Vivify_Conditions, AIScore_Farewell_Conditions, AIScore_LifeDance_Conditions, AIScore_LifeSong_Conditions)
; reads: wBattleActor
; points at: wBattleSlotOut
AnyOwnSideSlotOutIs1:: ; heuristic: follows a terminator; C0
Func_005_4B7A:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld b, $03

.loop:
    ld a, [hl+]
    cp a, $01
    jr z, .done
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = $FF when the fastest occupied foe's AGL exceeds 31 percent of the actor's AGL, else $00 (E-0127)
; 4 call sites from 4 routines (e.g. AIScore_SquallHit_Conditions, AIScore_Speed, AIScore_Slow, AIScore_PsycheUp)
; reads: wBattleActor
FastestFoeAGLAbove31PercentOfActor:: ; heuristic: follows a terminator; C0
Func_005_4B97:: ; address name
    ld a, [wBattleActor]
    call GetBattleAGL_Bank05
    ld b, h
    ld c, l
    ld a, $1F
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    push hl
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld de, $0000

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call GetBattleAGL_Bank05
    ld a, h
    cp a, d
    jr z, .skip
    jr c, .next
    jr .skip2

.skip:
    ld a, l
    cp a, e
    jr c, .next

.skip2:
    ld d, h
    ld e, l

.next:
    inc c
    dec b
    jr nz, .loop
    pop hl
    ld b, d
    ld c, e
    call CompareHLToBC
    jp c, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = $FF when an occupied ally slot has HP at most three quarters of its max, else $00 (E-0124)
; 5 call sites from 5 routines (e.g. AIScore_Sacrifice, AIScore_HealUs_AnyFoeLacksStatus0MaskCC, AIScore_Hustle, AIScore_SuckAll, ...)
; reads: wBattleActor
AnyAllyHPAtMostThreeQuarters:: ; heuristic: follows a terminator; C0
Func_005_4BE1:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld d, $00

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call CompareHPWithThreeQuartersMax
    jr c, .done
    jr z, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = $FF when an occupied ally slot has MP at most three quarters of its max, else $00 (E-0124)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
AnyAllyMPAtMostThreeQuarters:: ; heuristic: follows a terminator; C0
Func_005_4C02:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld d, $00

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call CompareMPWithThreeQuartersMax
    jr c, .done
    jr z, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; only called from AIScore_Upper_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Upper_Conditions)
; reads: wBattleActor
AIScore_Upper_Conditions_CarryUnlessBattleSlotOutSlotEmpty:: ; heuristic: follows a terminator; C0
Func_005_4C23:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call AIScore_Upper_Conditions_Sub01_GetBattleDEF_Bank05
    jr c, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; only called from AIScore_Speed_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Speed_Conditions)
; reads: wBattleActor
AIScore_Speed_Conditions_CarryUnlessBattleSlotOutSlotEmpty:: ; heuristic: follows a terminator; C0
Func_005_4C40:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call AIScore_Speed_Conditions_Sub01_GetBattleAGL_Bank05
    jr c, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; counts the present slots among the actor's three opposite slots (D = the last one found); when fewer than two are present and that foe's HP (GetBattleHP_Bank05) is below the word wD2C1[2 * (slot & 3)], C = 0; otherwise C = $FF. With no foe present D is not set by this routine (E-0091)
; 32 call sites from 32 routines (e.g. AIScore_ChargeUp_Conditions, AIIronizeUsable, AIScore_Dodge_Sub01_Conditions, AIScore_Skill00, ...)
; reads: wBattleActor
; points at: wAIDamageEstimates
CheckLoneFoeHPNotBelowAIDamageEstimates::
Func_005_4C5D:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    inc e
    ld d, c

.next:
    inc c
    dec b
    jr nz, .loop
    ld a, e
    cp a, $02
    jr nc, .done
    ld a, d
    call GetBattleHP_Bank05
    push hl
    ld hl, wAIDamageEstimates
    ld a, d
    and a, $03
    sla a
    add_a_to_hl
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld b, a
    pop hl
    call CompareHLToBC
    jr nc, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = $FF in link battles or when every occupied foe's species is already flagged (TestSpeciesFlag), else $00 (E-0125)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wBattleActor, hTemp0
; writes: hTemp0, wSpeciesIdLo, wSpeciesIdHi
; points at: wBattleMonsterId, hTemp0
NoUnflaggedFoeSpeciesOrLink:: ; heuristic: follows a terminator; C0
Func_005_4C9C:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr nz, .done
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hTemp0], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld hl, wBattleMonsterId
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    push bc
    farcall TestSpeciesFlag
    ld a, c
    pop bc
    or a, a
    jr nz, .next
    ld hl, hTemp0
    inc [hl]

.next:
    inc c
    dec b
    jr nz, .loop
    ldh a, [hTemp0]
    or a, a
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = 1 when the AI mode (wDA53[actor]) is below 3; otherwise C = 0 when one of the actor's three opposite slots is present with status byte 7 (wD813) bit 2 set, else $FF (E-0099)
; 3 call sites from 3 routines (e.g. AIScore_Skill00, AIScore_FireSlash, AIScore_SlimeBlow)
; reads: wBattleActor
; points at: wBattleStatus6
CheckFoeStatus7Bit2::
Func_005_4CE5:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $03
    jr c, .done3
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus6
    call AddAx9ToHL
    inc hl
    bit 2, [hl]
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    jr .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

.done3:
    ld c, $01
    ret

; C = $FF when one of the actor's own three slots is present (the actor included) with status byte 1 (wD80D) & $0C clear and status byte 4 & $03 clear, else 0 (E-0099)
; 2 call sites from 2 routines (e.g. AIScore_TwinHits_CheckSkillUsableStatusElseResetAISkillScore, AIScore_MegaMagic)
; reads: wBattleActor
; points at: wBattleStatus1
AnyAllyLacksStatus1Bits23And4Bits01:: ; heuristic: follows a terminator; C0
Func_005_4D1A:: ; address name
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
    ld a, [hl]
    and a, $0C
    jr nz, .next
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $03
    jr z, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; only called from AIScore_MagicWall_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_MagicWall_Conditions)
; reads: wBattleActor
; points at: wBattleStatus8
AIScore_MagicWall_Conditions_AnySlotLacksStatusMask:: ; heuristic: follows a terminator; C0
Func_005_4D46:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld b, $03
    ld e, $40
    ld hl, wBattleStatus8
    call AnySlotLacksStatusMask
    ret

; only called from AIScore_SideStep_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_SideStep_Conditions)
; reads: wBattleActor
; points at: wBattleStatus5
AIScore_SideStep_Conditions_AddAx9ToHL:: ; heuristic: follows a terminator; C0
Func_005_4D56:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; only called from AIScore_Surge_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Surge_Conditions)
; reads: wBattleActor
; points at: wBattleStatus
AIScore_Surge_Conditions_CarryUnlessBattleSlotOutSlotEmpty:: ; heuristic: follows a terminator; C0
Func_005_4D6A:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl+]
    or a, a
    jr nz, .done
    ld a, [hl+]
    and a, $C3
    jr nz, .done
    inc hl
    inc hl
    inc hl
    ld a, [hl+]
    and a, $03
    jr nz, .done
    ld a, [hl+]
    and a, $80
    jr nz, .done
    inc hl
    ld a, [hl]
    and a, $80
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; only called from AIScore_DeMagic_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_DeMagic_Conditions)
; reads: wBattleActor
; points at: wBattleStatus1, wBattleSlotOut
AIScore_DeMagic_Conditions_CarryUnlessBattleSlotOutSlotEmpty:: ; heuristic: follows a terminator; C0
Func_005_4DA5:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    ld a, [hl+]
    and a, $3C
    jr nz, .done
    ld a, [hl+]
    and a, $6F
    jr nz, .done
    inc hl
    inc hl
    ld a, [hl+]
    and a, $CC
    jr nz, .done
    ld a, [hl+]
    and a, $40
    jr nz, .done
    inc hl
    ld a, [hl]
    and a, $40
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld a, [wBattleActor]
    and a, $04
    or a, $03
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    or a, a
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = 0 when the actor's side byte (wC984 for slots 0-3, wC985 for 4-7) is 1, else C = $FF (E-0099)
; 4 call sites from 4 routines (e.g. AIScore_Sacrifice_ActorCanPayMPCost_Bank05, AIScore_Farewell_Conditions, AIScore_LifeDance_Conditions, AIScore_LifeSong_Conditions)
; reads: wBattleActor
; points at: wSide0Flag
CheckSide0FlagNot1::
Func_005_4DF5:: ; address name
    ld a, [wBattleActor]
    rrca
    rrca
    and a, $01
    ld hl, wSide0Flag
    add_a_to_hl
    ld a, [hl]
    cp a, $01
    jr nz, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = 0 when wCFC5 is 4 or 5, else C = $FF (E-0094)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleKind
CheckBattleKindNot4Or5:: ; heuristic: follows a terminator; C0
Func_005_4E0F:: ; address name
    ld a, [wBattleKind]
    cp a, $04
    jr z, .done
    cp a, $05
    jr nz, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

; only called from AIScore_SealPray (E-0047)
; 1 call site from 1 routine (e.g. AIScore_SealPray)
; reads: wQueuedActionId
AIScore_SealPray_ReadQueuedActionId:: ; heuristic: follows a terminator; C0
Func_005_4E20:: ; address name
    ld a, [wQueuedActionId]
    and a, a
    jr z, .done2
    cp a, $3D
    jr z, .done
    cp a, $3E
    jr z, .done
    cp a, $3F
    jr z, .done
    cp a, $43
    jr z, .done
    cp a, $47
    jr z, .done
    cp a, $66
    jr z, .done
    cp a, $67
    jr nz, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

; C = $00 when an occupied foe's wD2C1 word is at least Func_005_4E7C for it, else $FF (E-0125)
; 12 call sites from 12 routines (e.g. InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate, AIScore_Blaze, AIScore_Firebal, AIScore_BigBang, ...)
; reads: wBattleActor
; points at: wAIDamageEstimates
FailIfFoeAIDamageEstimatesAtLeastEstimate::
Func_005_4E48:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, wAIDamageEstimates

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    push hl
    push bc
    call FailIfFoeAIDamageEstimatesAtLeastEstimate_ReadRecordBufferAndRecordBufferDataEtc
    pop bc
    ld d, h
    ld e, l
    pop hl
    inc hl
    ld a, [hl]
    cp a, d
    jr c, .next
    dec hl
    ld a, [hl+]
    cp a, e
    jr c, .next
    jr .done

.next:
    inc c
    dec b
    jr nz, .loop
    jr .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

; only called from FailIfFoeAIDamageEstimatesAtLeastEstimate (E-0047)
; 1 call site from 1 routine (e.g. FailIfFoeAIDamageEstimatesAtLeastEstimate)
; reads: wRecordBuffer, wRecordBufferData, wBattleActor, wLinkMode
; points at: wBattleLevel
FailIfFoeAIDamageEstimatesAtLeastEstimate_ReadRecordBufferAndRecordBufferDataEtc::
Func_005_4E7C:: ; address name
    ld a, [wRecordBuffer]
    cp a, $48
    jr z, .read_battle_actor
    cp a, $49
    jr z, .read_battle_actor2
    cp a, $4A
    jp z, .read_battle_actor3
    cp a, $4E
    jp z, .read_battle_actor4
    cp a, $4F
    jp z, .read_battle_actor5
    cp a, $50
    jp z, .skip19
    cp a, $51
    jp z, .skip19
    cp a, $52
    jp z, .skip19
    cp a, $53
    jp z, .skip19
    ld a, [wRecordBufferData + $9]
    ld l, a
    ld a, [wRecordBufferData + $B]
    add a, l
    ld l, a
    ld a, [wRecordBufferData + $A]
    ld h, a
    ld a, [wRecordBufferData + $C]
    adc a, h
    ld h, a
    ret

.read_battle_actor:
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
    jr nc, .skip2

.skip:
    ld a, l
    add a, $0A
    add hl, hl
    add_a_to_hl
    jr .call_multiply_hl_by_a_percent

.skip2:
    ld a, l
    srl a
    add a, l
    ld l, a
    jr nc, .call_multiply_hl_by_a_percent
    inc h

.call_multiply_hl_by_a_percent:
    ld a, $73
    call MultiplyHLByAPercent
    ld a, h
    or a, a
    jr nz, .skip3
    ld a, l
    cp a, $B4
    jp c, .skip18

.skip3:
    ld hl, $00B4
    jp .skip18

.read_battle_actor2:
    ld a, [wBattleActor]
    ld hl, wBattleLevel
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    ld a, [wLinkMode]
    cp a, $01
    jr z, .skip4
    ld a, [wBattleActor]
    cp a, $04
    jr nc, .skip5

.skip4:
    ld a, $1E
    add hl, hl
    add_a_to_hl
    jr .call_multiply_hl_by_a_percent2

.skip5:
    ld a, l
    srl a
    add a, l
    ld l, a
    jr nc, .call_multiply_hl_by_a_percent2
    inc h

.call_multiply_hl_by_a_percent2:
    ld a, $6E
    call MultiplyHLByAPercent
    ld a, h
    or a, a
    jr nz, .skip6
    ld a, l
    cp a, $96
    jp c, .skip18

.skip6:
    ld hl, $0096
    jp .skip18

.read_battle_actor3:
    ld a, [wBattleActor]
    ld hl, wBattleLevel
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    ld a, [wLinkMode]
    cp a, $01
    jr z, .skip7
    ld a, [wBattleActor]
    cp a, $04
    jr nc, .skip8

.skip7:
    ld a, $14
    add hl, hl
    add_a_to_hl
    jr .call_multiply_hl_by_a_percent3

.skip8:
    ld a, l
    srl a
    add a, l
    ld l, a
    jr nc, .call_multiply_hl_by_a_percent3
    inc h

.call_multiply_hl_by_a_percent3:
    ld a, $6E
    push bc
    call MultiplyHLByAPercent
    pop bc
    push hl
    call SlotFamilyBelowWater
    pop hl
    jr z, .skip10
    ld a, h
    or a, a
    jr nz, .skip9
    ld a, l
    cp a, $B4
    jr c, .skip18

.skip9:
    ld hl, $00B4
    jr .skip18

.skip10:
    ld a, h
    or a, a
    jr nz, .skip11
    ld a, l
    cp a, $DC
    jr c, .skip18

.skip11:
    ld hl, $00DC
    jr .skip18

.read_battle_actor4:
    ld a, [wBattleActor]
    ld hl, wBattleLevel
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    ld a, [wLinkMode]
    cp a, $01
    jr z, .skip12
    ld a, [wBattleActor]
    cp a, $04
    jr nc, .skip13

.skip12:
    add hl, hl
    add_a_to_hl
    jr .skip14

.skip13:
    ld a, l
    srl a
    add a, l
    ld l, a
    jr nc, .skip14
    inc h

.skip14:
    add hl, hl
    jr .skip18

.read_battle_actor5:
    ld a, [wBattleActor]
    ld hl, wBattleLevel
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    ld a, [wLinkMode]
    cp a, $01
    jr z, .skip15
    ld a, [wBattleActor]
    cp a, $04
    jr nc, .skip16

.skip15:
    add hl, hl
    add_a_to_hl
    jr .skip17

.skip16:
    ld a, l
    srl a
    add a, l
    ld l, a
    jr nc, .skip17
    inc h

.skip17:
    add hl, hl
    add hl, hl

.skip18:
    ld a, c
    cp a, $03
    ld c, $00
    jr z, .skip20
    cp a, $02
    ld c, $32
    jr z, .skip20
    cp a, $01
    ld c, $55
    jr z, .skip20
    ld c, $64
    jr .skip20

.skip19:
    deref_hl
    ld a, c
    cp a, $03
    ld c, $1E
    jr z, .skip20
    cp a, $02
    ld c, $4B
    jr z, .skip20
    cp a, $01
    ld c, $73
    jr z, .skip20
    ld c, $82

.skip20:
    ld a, c

; HL = HL * A / 100 (24-bit intermediate: Multiply8By16 then Divide24ByA), A = the remainder (E-0114)
; 3 call sites from 1 routine (e.g. FailIfFoeAIDamageEstimatesAtLeastEstimate_ReadRecordBufferAndRecordBufferDataEtc)
MultiplyHLByAPercent::
Func_005_5029:: ; address name
    ld b, h
    ld c, l
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    ret

; C = battle slot: loads the slot's species record (LoadSpeciesRecord); A = its family; carry set when the family is below 9 (Slime to Material), clear for Water (9) and Boss (10) (E-0069)
; 1 call site from 1 routine (e.g. FailIfFoeAIDamageEstimatesAtLeastEstimate_ReadRecordBufferAndRecordBufferDataEtc)
; reads: wSpeciesRecord
; writes: wSpeciesIdLo, wSpeciesIdHi
; points at: wBattleMonsterId
SlotFamilyBelowWater::
Func_005_5034:: ; address name
    ld a, c
    add a, a
    ld hl, wBattleMonsterId
    add_a_to_hl
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesRecord]
    cp a, $09
    ret

; C = $FF when wCFEF is 0 or the occupied foes' average resistance level for skill wCFEF is at least 2, else $00 (E-0128)
; 14 call sites from 14 routines (e.g. AIScore_Blaze, AIScore_Firebal, AIScore_RobMagic, AIScore_MegaMagic, ...)
; reads: wRecordBufferData, wBattleActor, hTemp0, hTemp1
; writes: hTemp0, hTemp1
; points at: wSlotResistances
PassIfFoesAverageResistanceAtLeast2::
Func_005_5052:: ; address name
    ld a, [wRecordBufferData + $1]
    or a, a
    jr z, .done2
    dec a
    ld hl, AnyFoeNotFullyResistant_Data
    add a, a
    add_a_to_hl
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, wSlotResistances
    add a, a
    add a, c
    add a, a
    add a, c
    add a, d
    add_a_to_hl
    xor a, a
    ldh [hTemp0], a
    ldh [hTemp1], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    ldh a, [hTemp0]
    inc a
    ldh [hTemp0], a
    call Get2BitFieldEOfHL
    ld d, a
    ldh a, [hTemp1]
    add a, d
    ldh [hTemp1], a

.skip:
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, .loop
    ldh a, [hTemp1]
    or a, a
    jr z, .done
    ld b, a
    ldh a, [hTemp0]
    call DivideBByA
    ld a, b
    cp a, $02
    jr nc, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

; C = 1 when the actor's AI mode is below 2; otherwise $FF when the allies' average AGL is at least the foes', else $00 (E-0124)
; 4 call sites from 4 routines (e.g. AIScore_Speed, AIScore_Slow, AIScore_Sleep, AIScore_PsycheUp)
; reads: wBattleActor
AllyAverageAGLAtLeastFoes:: ; heuristic: follows a terminator; C0
Func_005_50B7:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $02
    jr c, .done2
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    call AverageAGLOfSideA
    push hl
    ld a, [wBattleActor]
    and a, $04
    call AverageAGLOfSideA
    pop bc
    call CompareHLToBC
    jr nc, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

.done2:
    ld c, $01
    ret

; C = 1 when the AI mode is below 2; otherwise $FF when the foes' average DEF is at most twice the allies' average ATK, else $00 (E-0129)
; 7 call sites from 7 routines (e.g. AIScore_Sap, AIScore_ChargeUp, AIScore_HighJump, AIScore_EvilSlash, ...)
; reads: wBattleActor, hTemp1, hTemp2, hTemp0, hTemp4, hTemp5, hTemp3
; writes: hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, hTemp5
; points at: hTemp0, hTemp3
PassIfFoeAverageDEFAtMostTwiceAllyATK:: ; heuristic: follows a terminator; C0
Func_005_50E3:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $02
    jp c, .done2
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld hl, hTemp0
    inc [hl]
    ld a, c
    call GetBattleDEF_Bank05
    ldh a, [hTemp1]
    add a, l
    ldh [hTemp1], a
    ldh a, [hTemp2]
    adc a, h
    ldh [hTemp2], a

.next:
    inc c
    dec b
    jr nz, .loop
    ldh a, [hTemp1]
    ld l, a
    ldh a, [hTemp2]
    ld h, a
    ldh a, [hTemp0]
    call DivideHLByA
    ld a, l
    ldh [hTemp1], a
    ld a, h
    ldh [hTemp2], a
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hTemp3], a
    ldh [hTemp4], a
    ldh [hTemp5], a

.loop2:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next2
    call GetBattleATK_Bank05
    ldh a, [hTemp4]
    add a, l
    ldh [hTemp4], a
    ldh a, [hTemp5]
    adc a, h
    ldh [hTemp5], a
    ld hl, hTemp3
    inc [hl]

.next2:
    inc c
    dec b
    jr nz, .loop2
    ldh a, [hTemp4]
    ld l, a
    ldh a, [hTemp5]
    ld h, a
    ldh a, [hTemp3]
    call DivideHLByA
    sla l
    rl h
    push hl
    ldh a, [hTemp1]
    ld l, a
    ldh a, [hTemp2]
    ld h, a
    pop bc
    call CompareHLToBC
    jr c, .done
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

.done2:
    ld c, $01
    ret

; C = 1 when the AI mode is below 2; otherwise $FF when the lowest DEF among occupied foes is below twice the actor's ATK, else $00 (E-0128)
; 7 call sites from 7 routines (e.g. AIScore_Sap, AIScore_Transform, AIScore_HighJump, AIScore_EvilSlash, ...)
; reads: wBattleActor, hTemp0, hTemp1
; writes: hTemp0, hTemp1
PassIfTwiceATKAboveLowestFoeDEF:: ; heuristic: follows a terminator; C0
Func_005_517D:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $02
    jr c, .done4
    ld a, [wBattleActor]
    call GetBattleATK_Bank05
    add hl, hl
    push hl
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hTemp0], a
    ldh [hTemp1], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .call_get_battle_def_bank05
    inc c
    dec b
    jr nz, .loop
    jr .done

.call_get_battle_def_bank05:
    call GetBattleDEF_Bank05
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    inc c
    dec b
    jr z, .read_temp0

.loop2:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call GetBattleDEF_Bank05
    ldh a, [hTemp0]
    sub a, l
    ldh a, [hTemp1]
    sbc a, h
    jr nc, .next
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a

.next:
    inc c
    dec b
    jr nz, .loop2

.read_temp0:
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    pop bc
    call CompareHLToBC
    jr c, .done3
    jr .done2

.done:
    pop bc

.done2:
    ld c, $00
    ret

.done3:
    ld c, $FF
    ret

.done4:
    ld c, $01
    ret

; only called from AIScore_TwinHits (E-0047)
; 1 call site from 1 routine (e.g. AIScore_TwinHits)
; reads: wBattleActor, hTemp0, hTemp1
AIScore_TwinHits_ReadSlotAIModeIndexed_Bank05:: ; heuristic: follows a terminator; C0
Func_005_51EA:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $02
    jr c, .done3
    call AIScore_TwinHits_CarryUnlessBattleSlotOutSlotEmpty
    ld a, [wBattleActor]
    call GetBattleATK_Bank05
    ldh a, [hTemp0]
    ld c, a
    ldh a, [hTemp1]
    ld b, a
    sla c
    rl b
    call CompareHLToBC
    jr c, .skip
    jr z, .skip
    jr .done2

.skip:
    sra b
    rr c
    sra b
    rr c
    call CompareHLToBC
    jr nc, .done
    jr .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

.done3:
    ld c, $01
    ret

; only called from AIScore_TwinHits (E-0047)
; 1 call site from 1 routine (e.g. AIScore_TwinHits)
; reads: wBattleActor, hTemp0, hTemp1
AIScore_TwinHits_ReadSlotAIModeIndexed_Bank05_Sub02:: ; heuristic: follows a terminator; C0
Func_005_5228:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $02
    jr c, .done3
    call AIScore_TwinHits_CarryUnlessBattleSlotOutSlotEmpty
    ld a, [wBattleActor]
    and a, $04
    ld e, a
    ld d, $03

.loop:
    ld a, e
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call GetBattleATK_Bank05
    ldh a, [hTemp0]
    ld c, a
    ldh a, [hTemp1]
    ld b, a
    sla c
    rl b
    call CompareHLToBC
    jr c, .skip
    jr z, .skip
    jr .next

.skip:
    sra b
    rr c
    sra b
    rr c
    call CompareHLToBC
    jr nc, .done

.next:
    inc e
    dec d
    jr nz, .loop
    jr .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

.done3:
    ld c, $01
    ret

; C = 1 when the AI mode is below 2; otherwise $FF when the able foes' average ATK is at most twice the allies' average DEF, else $00 (E-0129)
; 3 call sites from 3 routines (e.g. AIScore_Surround, AIScore_SideStep, AIScore_SandStorm)
; reads: wBattleActor, hTemp1, hTemp2, hTemp0, hTemp4, hTemp5, hTemp3
; writes: hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, hTemp5
; points at: hTemp0, hTemp3
PassIfFoeAverageATKAtMostTwiceAllyDEF:: ; heuristic: follows a terminator; C0
Func_005_5275:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $02
    jp c, .done2
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call SlotStatus0Bit1OrStatus4Bits01
    jr nz, .next
    ld hl, hTemp0
    inc [hl]
    ld a, c
    call GetBattleATK_Bank05
    ldh a, [hTemp1]
    add a, l
    ldh [hTemp1], a
    ldh a, [hTemp2]
    adc a, h
    ldh [hTemp2], a

.next:
    inc c
    dec b
    jr nz, .loop
    ldh a, [hTemp1]
    ld l, a
    ldh a, [hTemp2]
    ld h, a
    ldh a, [hTemp0]
    or a, a
    jr z, .done
    call DivideHLByA
    ld a, l
    ldh [hTemp1], a
    ld a, h
    ldh [hTemp2], a
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hTemp3], a
    ldh [hTemp4], a
    ldh [hTemp5], a

.loop2:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next2
    call GetBattleDEF_Bank05
    ldh a, [hTemp4]
    add a, l
    ldh [hTemp4], a
    ldh a, [hTemp5]
    adc a, h
    ldh [hTemp5], a
    ld hl, hTemp3
    inc [hl]

.next2:
    inc c
    dec b
    jr nz, .loop2
    ldh a, [hTemp4]
    ld l, a
    ldh a, [hTemp5]
    ld h, a
    ldh a, [hTemp3]
    call DivideHLByA
    sla l
    rl h
    push hl
    ldh a, [hTemp1]
    ld l, a
    ldh a, [hTemp2]
    ld h, a
    pop bc
    call CompareHLToBC
    jr c, .done
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

.done2:
    ld c, $01
    ret

; hFFC6 = battle slot: C = 0 when its HP >= 2/3 of its max HP, 1 when >= 1/2, 2 when >= 1/3, 3 when >= 1/4, 4 when >= 1/10, else 5 (GetBattleHP_Bank05, GetBattleMaxHP_Bank05, divisions rounded down) (E-0092)
; 8 call sites from 8 routines (e.g. AIScore_StrongD_HPBandOfSlotTemp0, AIScore_AquaWall_HPBandOfSlotTemp0, AIScore_SuckAll_Sub01_HPBandOfSlotTemp0, AIScore_Meditate_HPBandOfSlotTemp0, ...)
; reads: hTemp0
HPBandOfSlotTemp0::
Func_005_5317:: ; address name
    ldh a, [hTemp0]
    call GetBattleMaxHP_Bank05
    add hl, hl
    ld a, $03
    call DivideHLByA
    push hl
    ldh a, [hTemp0]
    call GetBattleHP_Bank05
    pop bc
    push hl
    call CompareHLToBC
    jr nc, .done
    ldh a, [hTemp0]
    call GetBattleMaxHP_Bank05
    srl h
    rr l
    push hl
    pop bc
    pop hl
    push hl
    call CompareHLToBC
    jr nc, .done2
    ldh a, [hTemp0]
    call GetBattleMaxHP_Bank05
    ld a, $03
    call DivideHLByA
    push hl
    pop bc
    pop hl
    push hl
    call CompareHLToBC
    jr nc, .done3
    ldh a, [hTemp0]
    call GetBattleMaxHP_Bank05
    srl h
    rr l
    srl h
    rr l
    push hl
    pop bc
    pop hl
    push hl
    call CompareHLToBC
    jr nc, .done4
    ldh a, [hTemp0]
    call GetBattleMaxHP_Bank05
    ld a, $0A
    call DivideHLByA
    push hl
    pop bc
    pop hl
    push hl
    call CompareHLToBC
    jr nc, .done5
    jr .done6

.done:
    pop hl
    ld c, $00
    ret

.done2:
    pop hl
    ld c, $01
    ret

.done3:
    pop hl
    ld c, $02
    ret

.done4:
    pop hl
    ld c, $03
    ret

.done5:
    pop hl
    ld c, $04
    ret

.done6:
    pop hl
    ld c, $05
    ret

; C = $00 when the actor's HP is exactly 1 (CompareSlotHPWith1), else $FF (E-0122)
; 11 call sites from 11 routines (e.g. AIFunc779FAnd43F2AndActorHPNotOne, AIScore_Cover_Conditions, AIScore_SuckAll_Conditions, AIScore_HealUs_AnyFoeLacksStatus0MaskCC, ...)
; reads: wBattleActor
ActorHPIsNotOne:: ; heuristic: follows a terminator; C0
Func_005_5397:: ; address name
    ld a, [wBattleActor]
    call CompareSlotHPWith1
    jr nz, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = $FF when fewer than two occupied ally slots have exactly 1 HP, else $00 (E-0124)
; 3 call sites from 3 routines (e.g. AIScore_HealUs, AIScore_Hustle, AIScore_LoveRain)
; reads: wBattleActor
FewerThanTwoAlliesAtHP1:: ; heuristic: follows a terminator; C0
Func_005_53A5:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld d, $00

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call CompareSlotHPWith1
    jr nz, .next
    inc d

.next:
    inc c
    dec b
    jr nz, .loop
    ld a, d
    cp a, $02
    jr c, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = 0 when the actor's status byte 1 (wD80D) & $0C or byte 4 & $03 is set, else C = $FF (E-0072)
; 14 call sites from 14 routines (e.g. AIScore_ChargeUp_Conditions, AIScore_Skill00, AIScore_CallHelp, AIScore_FireSlash, ...)
; reads: wBattleActor
; points at: wBattleStatus1
ActorLacksStatus1Bits23And4Bits01::
Func_005_53CA:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    jr nz, .done
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $03
    jr z, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

; C = 0 when the actor's status byte 4 (wD810) & $30 is set, else C = $FF (E-0100)
; 3 call sites from 3 routines (e.g. AIScore_SuckAir_Conditions, AIScore_SuckAll_Conditions, AIScore_FireAir)
; reads: wBattleActor
; points at: wBattleStatus4
ActorLacksStatus4Bits45:: ; heuristic: follows a terminator; C0
Func_005_53E6:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    ld a, [hl]
    and a, $30
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = 1 when the AI mode is below 2; otherwise $00 when an occupied foe without status bit 7 knows skill $42, $43, $46 or $47, else $FF (E-0127)
; 7 call sites from 7 routines (e.g. AIScore_Barrier, AIScore_BeDragon, AIScore_MouthShut, AIScore_TailWind, ...)
; reads: wBattleActor
; points at: wBattleStatus1, wBattleSkills
FailIfFoeKnowsSkills42To47:: ; heuristic: follows a terminator; C0
Func_005_53FA:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $02
    jr c, .done3
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 7, [hl]
    jr nz, .next
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld d, $08

.loop2:
    ld a, [hl+]
    cp a, $42
    jr z, .done
    cp a, $43
    jr z, .done
    cp a, $46
    jr z, .done
    cp a, $47
    jr z, .done
    inc hl
    dec d
    jr nz, .loop2

.next:
    inc c
    dec b
    jr nz, .loop
    jr .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

.done3:
    ld c, $01
    ret

; only called from AIScore_Transform (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Transform)
; reads: wBattleActor, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, hTemp5, hTemp6, ...
; writes: hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, hTemp5, hTemp6, hTemp7, ...
; points at: hTemp8
AIScore_Transform_ReadSlotAIModeIndexed_Bank05:: ; heuristic: follows a terminator; C0
Func_005_544F:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $02
    jp c, .done3
    ld a, [wBattleActor]
    call GetBattleMaxHP_Bank05
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ld a, [wBattleActor]
    call GetBattleMaxMP_Bank05
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    ld a, [wBattleActor]
    call GetBattleATK_Bank05
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    ld a, [wBattleActor]
    call GetBattleDEF_Bank05
    ld a, l
    ldh [hTemp6], a
    ld a, h
    ldh [hTemp7], a
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld e, a
    ld d, $03

.loop:
    xor a, a
    ldh [hTemp8], a
    ld a, e
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call GetBattleMaxHP_Bank05
    ldh a, [hTemp0]
    ld c, a
    ldh a, [hTemp1]
    ld b, a
    call CompareHLToBC
    jr nc, .call_get_battle_max_mp_bank05
    ld hl, hTemp8
    inc [hl]

.call_get_battle_max_mp_bank05:
    ld a, e
    call GetBattleMaxMP_Bank05
    ldh a, [hTemp2]
    ld c, a
    ldh a, [hTemp3]
    ld b, a
    call CompareHLToBC
    jr nc, .call_get_battle_atk_bank05
    ld hl, hTemp8
    inc [hl]

.call_get_battle_atk_bank05:
    ld a, e
    call GetBattleATK_Bank05
    ldh a, [hTemp4]
    ld c, a
    ldh a, [hTemp5]
    ld b, a
    call CompareHLToBC
    jr nc, .call_get_battle_def_bank05
    ld hl, hTemp8
    inc [hl]

.call_get_battle_def_bank05:
    ld a, e
    call GetBattleDEF_Bank05
    ldh a, [hTemp6]
    ld c, a
    ldh a, [hTemp7]
    ld b, a
    call CompareHLToBC
    jr nc, .check_temp8
    ld hl, hTemp8
    inc [hl]

.check_temp8:
    ldh a, [hTemp8]
    cp a, $03
    jr nc, .done

.next:
    inc e
    dec d
    jr nz, .loop
    jr .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

.done3:
    ld c, $01
    ret

; C = 0
; 73 call sites from 73 routines (e.g. AIScore_MPass_ActorLacksStatus4Bits67, AINeverUsableResetAISkillScore, AIScore_Skill00, AIScore_Blaze, ...)
SetCToZero::
Func_005_54FD:: ; address name
    ld c, $00
    ret

; C = 1 when the AI mode is below 2; otherwise $00 when a foe knowing skill $3D has 2 * MP + 2 * wD8B7 at least the actor's HP, else $FF (E-0128)
; 2 call sites from 2 routines (e.g. AIScore_StrongD, AIScore_SealPray)
; reads: wBattleActor
; points at: wBattleSkills, wBattleMP, wBattleLevel, wBattleHP
FailIfFoeSkill3DThreatensActorHP:: ; heuristic: follows a terminator; C0
Func_005_5500:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $02
    jr c, .done3
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld a, c
    swap a
    ld hl, wBattleSkills
    add a, l
    ld l, a
    jr nc, .loop
    inc h

.loop:
    ld d, $08

.loop2:
    ld a, [hl+]
    cp a, $3D
    jr z, .call_get_battle_mp_bank05
    inc hl
    dec d
    jr nz, .loop2

.next:
    inc c
    dec b
    jr nz, .loop
    jr .done2

.call_get_battle_mp_bank05:
    ld a, c
    ld hl, wBattleMP
    call GetBattleMP_Bank05
    add hl, hl
    push hl
    ld a, c
    ld hl, wBattleLevel
    add_a_to_hl
    ld a, [hl]
    ld e, a
    ld d, $00
    sla e
    rl d
    pop hl
    add hl, de
    push bc
    push hl
    ld a, [wBattleActor]
    sla a
    ld hl, wBattleHP
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld b, [hl]
    ld c, e
    pop hl
    call CompareHLToBC
    jr nc, .done
    pop bc
    ld a, c
    inc a
    sla a
    ld hl, wBattleSkills
    add_a_to_hl
    jr .next

.done:
    pop bc
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

.done3:
    ld c, $01
    ret

; C = $FF when Func_005_4E48 returns C = 0, else $00 (E-0122)
; 11 call sites from 11 routines (e.g. AIScore_Blaze, AIScore_Firebal, AIScore_BigBang, AIScore_FireAir, ...)
InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate::
Func_005_557E:: ; address name
    call FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a, a
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = $FF when 4 x the actor's MP is below 3 x its max MP (MP under three quarters of max), else 0 (E-0100)
; 3 call sites from 3 routines (e.g. AIScore_OddDance_Conditions, AIScore_RobMagic_Conditions, AIScore_TakeMagic)
; reads: wBattleActor
ActorMPBelowThreeQuarters:: ; heuristic: follows a terminator; C0
Func_005_558B:: ; address name
    ld a, [wBattleActor]
    call GetBattleMaxMP_Bank05
    ld b, h
    ld c, l
    add hl, hl
    add hl, bc
    push hl
    ld a, [wBattleActor]
    call GetBattleMP_Bank05
    add hl, hl
    add hl, hl
    pop bc
    call CompareHLToBC
    jr c, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; only called from AIScore_MagicBack_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_MagicBack_Conditions)
; reads: wBattleActor
; points at: wBattleStatus2
AIScore_MagicBack_Conditions_AddAx9ToHL:: ; heuristic: follows a terminator; C0
Func_005_55AA:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    ld a, [hl]
    and a, $22
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; link battles only: C = $00 when rule bits 7 and 6 of wD044 are set and the side's wD057 flag (or wD045 bit 6) allows it; otherwise $FF (E-0124)
; 2 call sites from 2 routines (e.g. AIAddScoresFor55BEAnd5731, AIScore_Sacrifice_LinkRuleCheckWD044Bit6)
; reads: wLinkMode, wBattleActor
; points at: wLinkRuleWork57
LinkRuleCheckWD044Bit6::
Func_005_55BE:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr z, .done2
    cp a, $02
    jr z, .done2
    ld hl, wLinkRules + $1
    bit 7, [hl]
    jr z, .done2
    bit 6, [hl]
    jr z, .done2
    inc hl
    bit 6, [hl]
    jr z, .done
    ld a, [wBattleActor]
    ld hl, wLinkRuleWork57
    and a, $04
    srl a
    srl a
    add_a_to_hl
    bit 6, [hl]
    jr z, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

; C = 0 (fail) when wC58A is neither 0 nor 2, wD044 bits 7 and 5 are set, and either wD045 bit 5 is clear or bit 5 is set in the actor side's byte wD057[actor / 4]; otherwise C = $FF (E-0091)
; 2 call sites from 2 routines (e.g. AIScore_MagicBack_Conditions, WeighWD044RuleBit5)
; reads: wLinkMode, wBattleActor
; points at: wLinkRuleWork57
CheckWD044RuleBit5:: ; heuristic: follows a terminator; C0
Func_005_55F3:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr z, .done2
    cp a, $02
    jr z, .done2
    ld hl, wLinkRules + $1
    bit 7, [hl]
    jr z, .done2
    bit 5, [hl]
    jr z, .done2
    inc hl
    bit 5, [hl]
    jr z, .done
    ld a, [wBattleActor]
    ld hl, wLinkRuleWork57
    and a, $04
    srl a
    srl a
    add_a_to_hl
    bit 5, [hl]
    jr z, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

; C = 0 (fail) when wC58A is neither 0 nor 2, wD044 bits 7 and 4 are set, and either wD045 bit 4 is clear or bit 4 is set in the actor side's byte wD057[actor / 4]; otherwise C = $FF (E-0091)
; 1 call site from 1 routine (e.g. WeighWD044RuleBit4)
; reads: wLinkMode, wBattleActor
; points at: wLinkRuleWork57
CheckWD044RuleBit4:: ; heuristic: follows a terminator; C0
Func_005_5628:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr z, .done2
    cp a, $02
    jr z, .done2
    ld hl, wLinkRules + $1
    bit 7, [hl]
    jr z, .done2
    bit 4, [hl]
    jr z, .done2
    inc hl
    bit 4, [hl]
    jr z, .done
    ld a, [wBattleActor]
    ld hl, wLinkRuleWork57
    and a, $04
    srl a
    srl a
    add_a_to_hl
    bit 4, [hl]
    jr z, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

; C = 0 (fail) when wC58A is neither 0 nor 2, wD044 bits 7 and 3 are set, and either wD045 bit 3 is clear or bit 3 is set in the actor side's byte wD057[actor / 4]; otherwise C = $FF (E-0091)
; 1 call site from 1 routine (e.g. WeighWD044RuleBit3)
; reads: wLinkMode, wBattleActor
; points at: wLinkRuleWork57
CheckWD044RuleBit3:: ; heuristic: follows a terminator; C0
Func_005_565D:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr z, .done2
    cp a, $02
    jr z, .done2
    ld hl, wLinkRules + $1
    bit 7, [hl]
    jr z, .done2
    bit 3, [hl]
    jr z, .done2
    inc hl
    bit 3, [hl]
    jr z, .done
    ld a, [wBattleActor]
    ld hl, wLinkRuleWork57
    and a, $04
    srl a
    srl a
    add_a_to_hl
    bit 3, [hl]
    jr z, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

; C = 0 (fail) when wC58A is neither 0 nor 2, wD044 bits 7 and 2 are set, and either wD045 bit 2 is clear or bit 2 is set in the actor side's byte wD057[actor / 4]; otherwise C = $FF (E-0091)
; 1 call site from 1 routine (e.g. WeighWD044RuleBit2)
; reads: wLinkMode, wBattleActor
; points at: wLinkRuleWork57
CheckWD044RuleBit2:: ; heuristic: follows a terminator; C0
Func_005_5692:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr z, .done2
    cp a, $02
    jr z, .done2
    ld hl, wLinkRules + $1
    bit 7, [hl]
    jr z, .done2
    bit 2, [hl]
    jr z, .done2
    inc hl
    bit 2, [hl]
    jr z, .done
    ld a, [wBattleActor]
    ld hl, wLinkRuleWork57
    and a, $04
    srl a
    srl a
    add_a_to_hl
    bit 2, [hl]
    jr z, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

; C = 0 (fail) when wC58A is neither 0 nor 2, wD044 bits 7 and 1 are set, and either wD045 bit 1 is clear or bit 1 is set in the actor side's byte wD057[actor / 4]; otherwise C = $FF (E-0091)
; 1 call site from 1 routine (e.g. WeighWD044RuleBit1)
; reads: wLinkMode, wBattleActor
; points at: wLinkRuleWork57
CheckWD044RuleBit1:: ; heuristic: follows a terminator; C0
Func_005_56C7:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr z, .done2
    cp a, $02
    jr z, .done2
    ld hl, wLinkRules + $1
    bit 7, [hl]
    jr z, .done2
    bit 1, [hl]
    jr z, .done2
    inc hl
    bit 1, [hl]
    jr z, .done
    ld a, [wBattleActor]
    ld hl, wLinkRuleWork57
    and a, $04
    srl a
    srl a
    add_a_to_hl
    bit 1, [hl]
    jr z, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

; only called from AIScore_MegaMagic (E-0047)
; 1 call site from 1 routine (e.g. AIScore_MegaMagic)
; reads: wLinkMode, wBattleActor
; points at: wLinkRuleWork57
AIScore_MegaMagic_ReadLinkModeAndBattleActor:: ; heuristic: follows a terminator; C0
Func_005_56FC:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr z, .done2
    cp a, $02
    jr z, .done2
    ld hl, wLinkRules + $1
    bit 7, [hl]
    jr z, .done2
    bit 0, [hl]
    jr z, .done2
    inc hl
    bit 0, [hl]
    jr z, .done
    ld a, [wBattleActor]
    ld hl, wLinkRuleWork57
    and a, $04
    srl a
    srl a
    add_a_to_hl
    bit 0, [hl]
    jr z, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

; link battles only: C = $00 when the wD04B rule is on and wD891 is less than 4 past its limit; otherwise $FF (E-0124)
; 3 call sites from 3 routines (e.g. AIScore_MegaMagic, AIScore_BigBang, AIAddScoresFor55BEAnd5731)
; reads: wLinkMode, wBattleTurn
; points at: wLinkRuleTurnLimit
LinkRuleCheckLinkRuleTurnLimitTurnLimit::
Func_005_5731:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr z, .done2
    cp a, $02
    jr z, .done2
    ld hl, wLinkRuleTurnLimit
    bit 7, [hl]
    jr z, .done2
    ld a, [hl]
    and a, $7F
    ld b, a
    ld a, [wBattleTurn]
    sub a, b
    bit 7, a
    jr nz, .done
    cp a, $04
    jr nc, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

; C = $FF when another ally slot is occupied or the actor's own slot is empty; otherwise FewerThanTwoFoesPresent (E-0124)
; 8 call sites from 8 routines (e.g. AIScore_Firebal, AIScore_Chance, AIScore_MegaMagic, AIScore_BigBang, ...)
; reads: wBattleActor
AllySlotsCheckThenFewerThanTwoFoes:: ; heuristic: follows a terminator; C0
Func_005_5758:: ; address name
    ld a, [wBattleActor]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .skip
    ld a, c
    cp a, e
    jr z, .done
    jr .next

.skip:
    ld a, c
    cp a, e
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    call FewerThanTwoFoesPresent
    ret
    db $0E, $00, $C9

.done:
    ld c, $FF
    ret

; counts the present slots among the actor's three opposite slots: C = $FF when fewer than two are present, C = 0 for two or three; E = the count (E-0066)
; 21 call sites from 21 routines (e.g. AllySlotsCheckThenFewerThanTwoFoes, AIScore_Blaze, AIScore_Firebal, AIScore_Beat, ...)
; reads: wBattleActor
FewerThanTwoFoesPresent::
Func_005_577F:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    inc e

.next:
    inc c
    dec b
    jr nz, .loop
    ld a, e
    cp a, $02
    jr c, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = 1 when the AI mode is below 2; otherwise $00 when some occupied foe has Func_005_6D1A non-zero, else $FF (E-0124)
; 7 call sites from 7 routines (e.g. AIScore_StopSpell, AIScore_MagicBack, AIScore_MagicWall, AIScore_ThickFog, ...)
; reads: wBattleActor
AIModeAtLeast2AndFoeLacks6D1A:: ; heuristic: follows a terminator; C0
Func_005_57A1:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $02
    jr c, .done3
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call CountSkillsInList6D1A
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    jr .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

.done3:
    ld c, $01
    ret

; C = 1 when wDA53[actor] (the AI mode) is below 3; otherwise C = 0 when one of the actor's three opposite slots is present with status byte 6 (wD812) bit 3 set, else C = $FF (E-0092)
; 11 call sites from 11 routines (e.g. AIScore_Firebal, AIScore_BigBang, AIScore_FireAir, AIScore_Vacuum, ...)
; reads: wBattleActor
; points at: wBattleStatus6
CheckFoeStatus6Bit3::
Func_005_57CF:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $03
    jr c, .done3
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus6
    call AddAx9ToHL
    bit 3, [hl]
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    jr .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

.done3:
    ld c, $01
    ret

; only called from AIScore_Sacrifice (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Sacrifice)
; reads: wBattleActor
AIScore_Sacrifice_GetBattleMaxHP_Bank05:: ; heuristic: follows a terminator; C0
Func_005_5803:: ; address name
    ld a, [wBattleActor]
    call GetBattleMaxHP_Bank05
    ld a, $0A
    call DivideHLByA
    push hl
    ld a, [wBattleActor]
    call GetBattleHP_Bank05
    pop bc
    call CompareHLToBC
    jr c, .read_battle_actor
    jr .done

.read_battle_actor:
    ld a, [wBattleActor]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    cp a, e
    jr z, .next
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .check_battle_actor

.next:
    inc c
    dec b
    jr nz, .loop
    jr .done

.check_battle_actor:
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop2:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next2
    ld a, c
    ld hl, wSlotResistances + $3
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $03
    cp a, $02
    jr nc, .done

.next2:
    inc c
    dec b
    jr nz, .loop2
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; compares twice the occupied foes' average ATK with the allies' average DEF; returns $00 or $FF in C (E-0130)
; 4 call sites from 4 routines (e.g. AIScore_Surround, AIScore_SideStep, AIScore_SandStorm, AIScore_Upper_CompareFoeAverageATKWithAllyDEF)
; reads: wBattleActor, hTemp0, hTemp1
; writes: hTemp0, hTemp1
CompareFoeAverageATKWithAllyDEF:: ; heuristic: follows a terminator; C0
Func_005_585D:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00
    xor a, a
    ldh [hTemp0], a
    ldh [hTemp1], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call GetBattleATK_Bank05
    ldh a, [hTemp0]
    add a, l
    ldh [hTemp0], a
    ldh a, [hTemp1]
    adc a, h
    ldh [hTemp1], a
    inc e

.next:
    inc c
    dec b
    jr nz, .loop
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, e
    call DivideHLByA
    add hl, hl
    push hl
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld e, $00
    xor a, a
    ldh [hTemp0], a
    ldh [hTemp1], a

.loop2:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next2
    call GetBattleDEF_Bank05
    ldh a, [hTemp0]
    add a, l
    ldh [hTemp0], a
    ldh a, [hTemp1]
    adc a, h
    ldh [hTemp1], a
    inc e

.next2:
    inc c
    dec b
    jr nz, .loop2
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, e
    call DivideHLByA
    ld c, l
    ld b, h
    pop hl
    call CompareHLToBC
    jr c, .done
    jr z, .done
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    push hl
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld e, $00
    xor a, a
    ldh [hTemp0], a
    ldh [hTemp1], a

.loop3:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next3
    call GetBattleMaxHP_Bank05
    ldh a, [hTemp0]
    add a, l
    ldh [hTemp0], a
    ldh a, [hTemp1]
    adc a, h
    ldh [hTemp1], a
    inc e

.next3:
    inc c
    dec b
    jr nz, .loop3
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, e
    srl h
    rr l
    call DivideHLByA
    ld c, l
    ld b, h
    pop hl
    call CompareHLToBC
    jr c, .done
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = 1 when the AI mode is below 3; with exactly one other occupied ally that has at most 20 MP, checks its skills ($A0, $1E/$1F) and status; returns $00 or $FF (E-0129)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wBattleSkills, wBattleStatus1
AIGateLoneAllyMPAndSkills:: ; heuristic: follows a terminator; C0
Func_005_5919:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $03
    jp c, .done3
    ld a, [wBattleActor]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03
    ld d, $00

.loop:
    ld a, c
    cp a, e
    jr z, .next
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .next
    jr z, .next
    inc d
    inc c
    dec b
    jr nz, .loop
    ld a, d
    cp a, $01
    jr nz, .done2
    ld a, [wBattleActor]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03
    ld d, $00
    ld l, $00

.loop2:
    ld a, c
    cp a, e
    jr z, .next
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    inc d
    ld l, c

.next:
    inc c
    dec b
    jr nz, .loop2
    ld a, d
    cp a, $01
    jr nz, .done2
    ld e, l
    ld a, l
    call GetBattleMP_Bank05
    ld a, h
    and a, a
    jr nz, .done2
    ld a, l
    cp a, $14
    jr c, .skip
    jr z, .skip
    jr .done2

.skip:
    ld a, e
    swap a
    ld hl, wBattleSkills
    add_a_to_hl
    ld b, $08

.loop3:
    ld a, [hl+]
    cp a, $A0
    jr z, .done
    inc hl
    dec b
    jr nz, .loop3
    ld a, e
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 0, [hl]
    jr nz, .done2
    ld a, e
    swap a
    ld hl, wBattleSkills
    add_a_to_hl
    ld b, $08

.loop4:
    ld a, [hl+]
    cp a, $1E
    jr z, .done
    cp a, $1F
    jr z, .done
    inc hl
    dec b
    jr nz, .loop4
    jr .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

.done3:
    ld c, $01
    ret

; C = 1 when the AI mode is below 3; otherwise $00 when another able ally knows a skill $16-$1A but has less MP than its cost (Data_005_5A33), else $FF (E-0128)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wBattleStatus1, wBattleSkills
FailIfAllyLacksMPForHealSkill:: ; heuristic: follows a terminator; C0
Func_005_59BD:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $03
    jr c, .done2
    ld a, [wBattleActor]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    cp a, e
    jr z, .loop2
    call CheckSlotStatusBlock
    jr nc, .call_add_ax9_to_hl

.loop2:
    inc c
    dec b
    jr nz, .loop
    jr .done

.call_add_ax9_to_hl:
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 6, [hl]
    jr nz, .loop2
    ld a, c
    swap a
    ld hl, wBattleSkills
    add_a_to_hl
    ld d, $08

.loop3:
    ld a, [hl+]
    cp a, $16
    jr z, .skip
    cp a, $17
    jr z, .skip
    cp a, $18
    jr z, .skip
    cp a, $19
    jr z, .skip
    cp a, $1A
    jr z, .skip
    inc hl
    dec d
    jr nz, .loop3
    jr .done

.skip:
    ld hl, HealSkillMPCosts
    sub a, $16
    add_a_to_hl
    ld a, [hl]
    ld d, a
    ld a, c
    call GetBattleMP_Bank05
    ld a, h
    and a, a
    jr nz, .loop2
    ld a, l
    cp a, d
    jr nc, .loop2
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

.done2:
    ld c, $01
    ret

; E-0174 (C1: FailIfAllyLacksMPForHealSkill reads the byte $5A33 + (skill - $16) for skills $16-$1A an ally knows and compares it with that ally's MP; the bytes after these five decode as an untraced routine (ld a, [wBattleActor] ...) and stay data).
; record: MP the AI assumes this skill costs
HealSkillMPCosts::
Data_005_5A33:: ; address name
    db $02 ; id 22
    db $05 ; id 23
    db $07 ; id 24
    db $12 ; id 25
    db $24 ; id 26

; C = 1 when the actor's AI mode is below 3; otherwise C = $00 when another slot of the actor's side can act, has status byte 1 bit 6 clear and knows a skill CountSkillsInList6D1A counts, else $FF (E-0175)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wBattleStatus1
FailIfAbleAllyKnowsSkillList6D1A:: ; configured code entry (E-0175); C0
Func_005_5A38:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $03
    jr c, .done2
    ld a, [wBattleActor]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    cp a, e
    jr z, .loop2
    call CheckSlotStatusBlock
    jr nc, .call_add_ax9_to_hl

.loop2:
    inc c
    dec b
    jr nz, .loop
    jr .done

.call_add_ax9_to_hl:
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 6, [hl]
    jr nz, .loop2
    call CountSkillsInList6D1A
    jr z, .loop2
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

.done2:
    ld c, $01
    ret

; C = 1 when the actor's AI mode is below 3; otherwise C = $00 when another able slot of the actor's side knows skill $4D, $3D, $3E, $3F, $66, $67 ... and has less MP than its cost in Data_005_5AF8, else $FF (the pattern of FailIfAllyLacksMPForHealSkill) (E-0175)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wBattleSkills
FailIfAllyLacksMPForSkillList5AF8:: ; heuristic: follows a terminator; C0
Func_005_5A73:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $03
    jr c, .done3
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, [wBattleActor]
    ld e, a
    ld a, c
    cp a, e
    jr z, .next
    call CheckSlotStatusBlock
    jr nc, .skip

.next:
    inc c
    dec b
    jr nz, .loop
    jr .done2

.skip:
    ld a, c
    swap a
    ld hl, wBattleSkills
    add_a_to_hl
    ld d, $08

.loop2:
    ld a, [hl+]
    ld e, $00
    cp a, $4D
    jr z, .skip2
    inc e
    cp a, $3D
    jr z, .skip2
    inc e
    cp a, $3E
    jr z, .skip2
    inc e
    cp a, $3F
    jr z, .skip2
    inc e
    cp a, $66
    jr z, .skip2
    inc e
    cp a, $67
    jr z, .skip2

.next2:
    inc hl
    dec d
    jr nz, .loop2
    jr .done2

.skip2:
    push hl
    push bc
    ld hl, AllySkillMPCosts_5AF8
    ld a, e
    add_a_to_hl
    ld a, [hl]
    push de
    ld d, a
    ld a, c
    call GetBattleMP_Bank05
    ld a, h
    and a, a
    jr nz, .restore
    ld a, l
    cp a, d
    jr nc, .restore
    pop de
    pop bc
    pop hl
    jr .done

.restore:
    pop de
    pop bc
    pop hl
    jr .next2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

.done3:
    ld c, $01
    ret

; E-0228 (C1: FailIfAllyLacksMPForSkillList5AF8 compares an ally's MP (GetBattleMP_Bank05) with the byte at $5AF8 + E for the skill it found (E = position in its skill list $4D, $3D, $3E, $3F, $66, $67); 6 bytes, then code).
; record: MP cost
AllySkillMPCosts_5AF8::
Data_005_5AF8:: ; address name
    db $0F ; id 0
    db $01 ; id 1
    db $1E ; id 2
    db $19 ; id 3
    db $14 ; id 4
    db $14 ; id 5

; C = 1 when the actor's AI mode is below 3; otherwise C = $00 when another able slot of the actor's side has status byte 1 bit 7 clear and knows skill $42, $43, $46 or $47, else $FF; no traced caller (E-0228)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wBattleStatus1, wBattleSkills
FailIfAbleAllyKnowsSkill42To47:: ; configured code entry (E-0228); C0
Func_005_5AFE:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $03
    jr c, .done3
    ld a, [wBattleActor]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    cp a, e
    jr z, .loop2
    call CheckSlotStatusBlock
    jr nc, .call_add_ax9_to_hl

.loop2:
    inc c
    dec b
    jr nz, .loop
    jr .done2

.call_add_ax9_to_hl:
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 7, [hl]
    jr nz, .loop2
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld d, $08

.loop3:
    ld a, [hl+]
    cp a, $42
    jr z, .done
    cp a, $43
    jr z, .done
    cp a, $46
    jr z, .done
    cp a, $47
    jr z, .done
    inc hl
    dec d
    jr nz, .loop3
    jr .loop2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

.done3:
    ld c, $01
    ret

; C = 1 when the actor's AI mode is below 3; otherwise C = $00 when another able slot of the actor's side has status byte 1 bit 6 set and knows skill $78-$7D or $92, else $FF; no traced caller (E-0228)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wBattleStatus1, wBattleSkills
FailIfAbleAllyWithStatus6KnowsSkill78To92:: ; heuristic: follows a terminator; C0
Func_005_5B57:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $03
    jr c, .done3
    ld a, [wBattleActor]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    cp a, e
    jr z, .loop2
    call CheckSlotStatusBlock
    jr nc, .call_add_ax9_to_hl

.loop2:
    inc c
    dec b
    jr nz, .loop
    jr .done2

.call_add_ax9_to_hl:
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 6, [hl]
    jr z, .loop2
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld d, $08

.loop3:
    ld a, [hl+]
    cp a, $78
    jr z, .done
    cp a, $79
    jr z, .done
    cp a, $7A
    jr z, .done
    cp a, $7B
    jr z, .done
    cp a, $7C
    jr z, .done
    cp a, $7D
    jr z, .done
    cp a, $92
    jr z, .done
    inc hl
    dec d
    jr nz, .loop3
    jr .loop2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

.done3:
    ld c, $01
    ret

; only called from AIScore_BeDragon (E-0047)
; 1 call site from 1 routine (e.g. AIScore_BeDragon)
; reads: wBattleActor, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, hTemp5, hTemp6, ...
; writes: hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, hTemp5, hTemp6, hTemp7, ...
AIScore_BeDragon_GetBattleMaxHP_Bank05:: ; heuristic: follows a terminator; C0
Func_005_5BBC:: ; address name
    ld a, [wBattleActor]
    call GetBattleMaxHP_Bank05
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ld a, [wBattleActor]
    call GetBattleMaxMP_Bank05
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    ld a, [wBattleActor]
    call GetBattleATK_Bank05
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    ld a, [wBattleActor]
    call GetBattleDEF_Bank05
    ld a, l
    ldh [hTemp6], a
    ld a, h
    ldh [hTemp7], a
    ld a, [wBattleActor]
    call GetBattleAGL_Bank05
    ld a, l
    ldh [hTemp8], a
    ld a, h
    ldh [hTemp9], a
    ld e, $00
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld bc, $03E7
    call CompareHLToBC
    jr c, .read_temp2
    inc e

.read_temp2:
    ldh a, [hTemp2]
    ld l, a
    ldh a, [hTemp3]
    ld h, a
    ld bc, $012C
    call CompareHLToBC
    jr c, .read_temp4
    inc e

.read_temp4:
    ldh a, [hTemp4]
    ld l, a
    ldh a, [hTemp5]
    ld h, a
    ld bc, $012C
    call CompareHLToBC
    jr c, .read_temp6
    inc e

.read_temp6:
    ldh a, [hTemp6]
    ld l, a
    ldh a, [hTemp7]
    ld h, a
    ld bc, $00C8
    call CompareHLToBC
    jr c, .read_temp8
    inc e

.read_temp8:
    ldh a, [hTemp8]
    ld l, a
    ldh a, [hTemp9]
    ld h, a
    ld bc, $011E
    call CompareHLToBC
    jr c, .skip
    inc e

.skip:
    ld a, e
    cp a, $03
    jr c, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = $FF when the actor knows skill $83 or no occupied ally has an active status effect, else $00 (E-0125)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wBattleSkills
PassIfSkill83OrNoAllyHasStatus:: ; heuristic: follows a terminator; C0
Func_005_5C50:: ; address name
    ld a, [wBattleActor]
    swap a
    ld hl, wBattleSkills
    add_a_to_hl
    ld b, $08

.loop:
    ld a, [hl+]
    cp a, $83
    jr z, .done2
    inc hl
    dec b
    jr nz, .loop
    ld a, [wBattleActor]
    and a, $04
    and a, $04
    ld c, a
    ld b, $03

.loop2:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call CountActiveStatusEffectsOfSlotC
    ld a, d
    cp a, $01
    jr nc, .done

.next:
    inc c
    dec b
    jr nz, .loop2
    jr .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

; C = $00 when an occupied foe's HP is at most four fifths of its wD2C1 word, else $FF (E-0125)
; 2 call sites from 2 routines (e.g. AIScore_SquallHit, AIScore_BiAttack)
; reads: wBattleActor
; points at: wAIDamageEstimates
FailIfFoeHPAtMostFourFifthsAIDamageEstimates:: ; heuristic: follows a terminator; C0
Func_005_5C8C:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    and a, $03
    ld hl, wAIDamageEstimates
    sla a
    add_a_to_hl
    push bc
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld h, a
    ld l, c
    call ScaleHLToFourFifths
    pop bc
    push bc
    push hl
    ld a, c
    call GetBattleHP_Bank05
    ld c, l
    ld b, h
    pop hl
    call CompareHLToBC
    jr nc, .done
    pop bc

.next:
    inc c
    dec b
    jr nz, .loop
    jr .done2

.done:
    pop bc
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

; C = 0 when wCFC5 is 2 or 3, else C = $FF (E-0100)
; 4 call sites from 4 routines (e.g. AIScore_Sacrifice_ActorCanPayMPCost_Bank05, AIScore_Beat_Conditions, AIScore_PalsyAir_Conditions, AIScore_BigBang)
; reads: wBattleKind
CheckBattleKindNot2Or3::
Func_005_5CCE:: ; address name
    ld a, [wBattleKind]
    cp a, $02
    jr z, .done
    cp a, $03
    jr z, .done
    jr .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

; only called from AIScore_MegaMagic (E-0047)
; 1 call site from 1 routine (e.g. AIScore_MegaMagic)
; reads: wLinkMode
AIScore_MegaMagic_ReadLinkMode:: ; heuristic: follows a terminator; C0
Func_005_5CE1:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr z, .done
    cp a, $02
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = $FF when the side's wC984/wC985 flag is 1 or another ally slot is empty, else $00 (E-0124)
; 2 call sites from 2 routines (e.g. AIScore_LifeDance, AIAddPenaltyFor5758And5CF1)
; reads: wBattleActor, wSide0Flag, wSide1Flag
PassIfSide0FlagOrAllySlotEmpty:: ; heuristic: follows a terminator; C0
Func_005_5CF1:: ; address name
    ld a, [wBattleActor]
    cp a, $04
    jr nc, .check_side1_flag
    ld a, [wSide0Flag]
    jr .cp_01

.check_side1_flag:
    ld a, [wSide1Flag]

.cp_01:
    cp a, $01
    jr z, .done
    ld a, [wBattleActor]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    cp a, e
    jr z, .next
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = $FF when one of the actor's own three slots (the actor included) is present with status byte 2 (wD80E) bit 2 clear (AnySlotLacksStatusMask), else 0 (E-0100)
; 2 call sites from 2 routines (e.g. AIScore_Barrier_Conditions, AIScore_SuckAll)
; reads: wBattleActor
; points at: wBattleStatus2
AnyAllyLacksStatus2Bit2:: ; heuristic: follows a terminator; C0
Func_005_5D20:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld hl, wBattleStatus2
    ld e, $04
    call AnySlotLacksStatusMask
    ret

; the same test as AnyAllyLacksStatus2Bit2: C = $FF when one of the actor's own three slots (the actor included) is present with status byte 2 bit 2 clear. It computes the side with `and a, $04` twice where the opposite-side predicates use `and a, $04 / xor a, $04`, so it probably meant the foes (a possible slip; not executed) (E-0100)
; 2 call sites from 2 routines (e.g. AIScore_FireAir, AIScore_SuckAir)
; reads: wBattleActor
; points at: wBattleStatus2
AnyAllyLacksStatus2Bit2_5D31:: ; heuristic: follows a terminator; C0
Func_005_5D31:: ; address name
    ld a, [wBattleActor]
    and a, $04
    and a, $04
    ld c, a
    ld b, $03
    ld hl, wBattleStatus2
    ld e, $04
    call AnySlotLacksStatusMask
    ret

; C = 1 when the AI mode is below 3; otherwise $00 when an occupied foe has HP at least 1.5 times the actor's, else $FF (E-0125)
; 2 call sites from 2 routines (e.g. AIScore_Vacuum_CheckLoneFoeHPNotBelowAIDamageEstimates, AIScore_CallHelp)
; reads: wBattleActor
FailIfFoeHPAtLeast150PercentOfActor:: ; heuristic: follows a terminator; C0
Func_005_5D44:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $03
    jr c, .done3
    ld a, [wBattleActor]
    call GetBattleHP_Bank05
    ld c, l
    ld b, h
    sra h
    rr l
    add hl, bc
    ld d, h
    ld e, l
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call GetBattleHP_Bank05
    ld a, l
    sub a, e
    ld l, a
    ld a, h
    sbc a, d
    ld h, a
    bit 7, h
    jr z, .done

.next:
    inc c
    dec b
    jr nz, .loop
    jr .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

.done3:
    ld c, $01
    ret

; C = $00 when wC58A is 0 and bit 3 of hFF8C is set, else $FF (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, hPlayerStateFlags
FailIfLinkModeZeroAndPlayerStateFlagsBit3:: ; heuristic: follows a terminator; C0
Func_005_5D89:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr nz, .done
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = $FF when one of the actor's three opposite slots is present with status byte 0 bit 7 clear and bits 7-6 of its wDA74 entry not both set, else 0 (E-0100)
; 3 call sites from 3 routines (e.g. AIScore_NapAttack_Conditions, AIScore_Sleep_Conditions, AIScore_SleepAir_Conditions)
; reads: wBattleActor
; points at: wBattleStatus
AnyFoeOpenToWDA74Field3:: ; heuristic: follows a terminator; C0
Func_005_5D9B:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 7, [hl]
    jr nz, .next
    ld a, c
    ld hl, wSlotResistances + $2
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $C0
    cp a, $C0
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = $FF when an occupied foe has a zero wD80F byte and bits 2-3 of its wDA77 field below 3, else $00 (E-0124)
; 3 call sites from 3 routines (e.g. AIScore_LureDance_Conditions, AILickSkillUsable_7AD8, AIStatusLickUsable)
; reads: wBattleActor
; points at: wBattleStatus3
AnyFoeVulnerableByWDA77Bits23:: ; heuristic: follows a terminator; C0
Func_005_5DCD:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl]
    and a, a
    jr nz, .next
    ld a, c
    ld hl, wSlotResistances + $5
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $0C
    cp a, $0C
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; only called from AIScore_EerieLite_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_EerieLite_Conditions)
; reads: wBattleActor
; points at: wBattleStatus8
AIScore_EerieLite_Conditions_CarryUnlessBattleSlotOutSlotEmpty:: ; heuristic: follows a terminator; C0
Func_005_5DFF:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld de, wSlotResistances + $2
    add a, a
    add a, c
    add a, a
    add a, c
    add a, e
    ld e, a
    jr nc, .loop
    inc d

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    ld a, c
    ld hl, wBattleStatus8
    call AddAx9ToHL
    bit 7, [hl]
    jr nz, .skip
    ld a, [de]
    and a, $30
    cp a, $30
    jr nz, .done

.skip:
    ld a, e
    add a, $07
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = $FF when wD891 is non-zero, else $00 (E-0122)
; 5 call sites from 5 routines (e.g. AIScore_SquallHit_Conditions, AIScore_Dodge_Sub01_Conditions, AIGuardSkillUsable_7C45, AIScore_Imitate_Conditions, ...)
; reads: wBattleTurn
PassIfBattleTurnNonZero:: ; heuristic: follows a terminator; C0
Func_005_5E3F:: ; address name
    ld a, [wBattleTurn]
    and a, a
    jr nz, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = the result for foes with status byte 4 & $0C clear; when that is non-zero, C = the result for foes with status byte 3 & $C0 clear (both through AnySlotLacksStatusMask) (E-0120)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wBattleStatus4, wBattleStatus3
AnyFoeLacksStatus4Bits23ThenStatus3Bits67:: ; heuristic: follows a terminator; C0
Func_005_5E4B:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld hl, wBattleStatus4
    ld e, $0C
    call AnySlotLacksStatusMask
    ld a, c
    or a, a
    ret z
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld hl, wBattleStatus3
    ld e, $C0
    call AnySlotLacksStatusMask
    ret

; C = $FF when an occupied foe lacks status bit 4 and has bits 6-7 of its wDA75 field below 3, else $00 (E-0124)
; 1 call site from 1 routine (e.g. AIPanicAllUsable)
; reads: wBattleActor
; points at: wBattleStatus
AnyFoeVulnerableByWDA75Bits67:: ; heuristic: follows a terminator; C0
Func_005_5E6F:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 4, [hl]
    jr nz, .next
    ld a, c
    ld hl, wSlotResistances + $3
    call ReadByteAtHLPlus4APlus3C_Bank05
    and a, $C0
    cp a, $C0
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; only called from AIScore_EvilSlash (E-0047)
; 1 call site from 1 routine (e.g. AIScore_EvilSlash)
; reads: wBattleActor
; points at: wBattleStatus
AIScore_EvilSlash_CarryUnlessBattleSlotOutSlotEmpty:: ; heuristic: follows a terminator; C0
Func_005_5EA1:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, .done
    inc hl
    inc hl
    ld a, [hl]
    and a, $3F
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $FF
    ret

.done:
    ld c, $00
    ret

; only called from AIAddScoresFor5ECEAnd5FC7 (E-0047)
; 1 call site from 1 routine (e.g. AIAddScoresFor5ECEAnd5FC7)
; reads: wBattleActor, wAIFlag
; points at: wSlotMarks
AIAddScoresFor5ECEAnd5FC7_ReadSlotAIModeIndexed_Bank05::
Func_005_5ECE:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $04
    jr c, .done3
    ld a, [wAIFlag]
    or a, a
    jr z, .done
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld de, wSlotMarks
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CheckSlotStatusBlock
    jr c, .next
    ld a, [de]
    cp a, $02
    jr nz, .next
    call SlotActionIs9C33Or92Or93
    jr nz, .next
    call WDA77EntryHasBits2And3_Bank05_5F2A
    jr nz, .done2

.next:
    inc de
    inc c
    dec b
    jr nz, .loop

.done:
    ld c, $FF
    ret

.done2:
    ld c, $00
    ret

.done3:
    ld c, $01
    ret

; C = slot: Z set when the slot's chosen action (wBattleActionChoice) is $9C, $33, $92 or $93 (E-0117)
; 1 call site from 1 routine (e.g. AIAddScoresFor5ECEAnd5FC7_ReadSlotAIModeIndexed_Bank05)
; points at: wBattleActionChoice
SlotActionIs9C33Or92Or93::
Func_005_5F13:: ; address name
    ld a, c
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $9C
    ret z
    cp a, $33
    ret z
    cp a, $92
    ret z
    cp a, $93
    ret

; C = index: Z set when bits 2 and 3 are both set in the byte at wDA77 + 7 * C (7-byte entries); A = that byte & $0C; HL points at it (E-0065) (the same 19 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. AIAddScoresFor5ECEAnd5FC7_ReadSlotAIModeIndexed_Bank05)
WDA77EntryHasBits2And3_Bank05_5F2A::
Func_005_5F2A:: ; address name
    ld a, c
    ld hl, wSlotResistances + $5
    add a, a
    add a, c
    add a, a
    add a, c
    add_a_to_hl
    ld a, [hl]
    and a, $0C
    cp a, $0C
    ret

; C = 1 when the AI mode is below 4; with wD2CC set, $00 when another ally that can act knows skill $63 or $64 with enough MP; otherwise $FF (E-0127)
; 2 call sites from 2 routines (e.g. AIScoreB_TwinHits, AIScore_TwinHits)
; reads: wBattleActor, wAIFlag
; points at: wBattleStatus1, wSlotMarks
FailIfAllyCanUseSkill63Or64:: ; heuristic: follows a terminator; C0
Func_005_5F3D:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $04
    jr c, .done3
    ld a, [wAIFlag]
    or a, a
    jr z, .done
    ld a, [wBattleActor]
    ld d, a
    and a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    cp a, d
    jr z, .next
    ld a, c
    call CheckSlotStatusBlock
    jr c, .next
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 2, [hl]
    jr nz, .next
    ld a, c
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    cp a, $03
    jr nc, .next
    push de
    call SlotCLacksSkill63Or64WithMP
    pop de
    jr nc, .done2

.next:
    inc c
    dec b
    jr nz, .loop

.done:
    ld c, $FF
    ret

.done2:
    ld c, $00
    ret

.done3:
    ld c, $01
    ret

; carry unless slot C knows skill $63 with at least 3 MP or $64 with at least 6 MP (E-0125)
; 1 call site from 1 routine (e.g. FailIfAllyCanUseSkill63Or64)
; points at: wBattleSkills, wBattleMP
SlotCLacksSkill63Or64WithMP::
Func_005_5F8D:: ; address name
    ld a, c
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld e, $08

.loop:
    ld a, [hl+]
    cp a, $FF
    jr z, .return_carry
    cp a, $63
    jr z, .skip
    cp a, $64
    jr z, .skip2

.loop2:
    inc hl
    dec e
    jr nz, .loop

.return_carry:
    scf
    ret

.skip:
    ld d, $03
    jr .skip3

.skip2:
    ld d, $06

.skip3:
    push hl
    ld a, c
    ld hl, wBattleMP
    add a, a
    add_a_to_hl
    ld a, [hl+]
    sub a, d
    ld a, [hl]
    sbc a, $00
    pop hl
    jr c, .loop2
    ret

; only called from AIAddScoresFor5ECEAnd5FC7 (E-0047)
; 1 call site from 1 routine (e.g. AIAddScoresFor5ECEAnd5FC7)
; reads: wBattleActor, wAIFlag
; points at: wSlotMarks
AIAddScoresFor5ECEAnd5FC7_ReadSlotAIModeIndexed_Bank05_Sub02::
Func_005_5FC7:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $04
    jr c, .done3
    ld a, [wAIFlag]
    or a, a
    jr z, .done
    ld a, [wBattleActor]
    ld d, a
    and a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    cp a, d
    jr z, .next
    call CheckSlotStatusBlock
    jr c, .next
    ld a, c
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    cp a, $03
    jr nc, .next
    call SlotCHasMP3AndSkill6B
    jr c, .next
    call WDA77EntryHasBits2And3_Bank05
    jr nz, .done2

.next:
    inc c
    dec b
    jr nz, .loop

.done:
    ld c, $FF
    ret

.done2:
    ld c, $00
    ret

.done3:
    ld c, $01
    ret

; carry when slot C has under 3 MP; otherwise Z when skill $6B is among its eight skills (E-0124)
; 1 call site from 1 routine (e.g. AIAddScoresFor5ECEAnd5FC7_ReadSlotAIModeIndexed_Bank05_Sub02)
; points at: wBattleMP, wBattleSkills
SlotCHasMP3AndSkill6B::
Func_005_600E:: ; address name
    ld a, c
    ld hl, wBattleMP
    add a, a
    add_a_to_hl
    ld a, [hl+]
    sub a, $03
    ld a, [hl]
    sbc a, $00
    ret c
    ld a, c
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld e, $08

.loop:
    ld a, [hl+]
    cp a, $6B
    jr z, .return_0
    inc hl
    dec e
    jr nz, .loop
    dec e
    ret

.return_0:
    xor a, a
    ret

; C = index: Z set when bits 2 and 3 are both set in the byte at wDA77 + 7 * C (7-byte entries); A = that byte & $0C; HL points at it (E-0065) (the same 19 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. AIAddScoresFor5ECEAnd5FC7_ReadSlotAIModeIndexed_Bank05_Sub02)
WDA77EntryHasBits2And3_Bank05::
Func_005_6039:: ; address name
    ld a, c
    ld hl, wSlotResistances + $5
    add a, a
    add a, c
    add a, a
    add a, c
    add_a_to_hl
    ld a, [hl]
    and a, $0C
    cp a, $0C
    ret

; C = 1 when the AI mode is below 4; otherwise $00 when an occupied foe has HP at most half and a foe with personality Lo >= $C0 can cast a heal (Func_005_60BA), else $FF (E-0128)
; 2 call sites from 2 routines (e.g. AIScoreB_SquallHit, AIScore_SquallHit)
; reads: wBattleActor
; points at: wBattleHP, wBattleMaxHP, wSlotPersonalityLo
FailIfFoeHurtAndHealerCanCast:: ; heuristic: follows a terminator; C0
Func_005_604C:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $04
    jr c, .done3
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleHP
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    sla e
    rl d
    ld a, c
    ld hl, wBattleMaxHP
    add a, a
    add_a_to_hl
    ld a, [hl+]
    sub a, e
    ld a, [hl]
    sbc a, d
    jr nc, .skip

.next:
    inc c
    dec b
    jr nz, .loop
    jr .done

.skip:
    ld a, c
    and a, $04
    ld c, a
    ld b, $03

.loop2:
    ld a, c
    call CheckSlotStatusBlock
    jr c, .next2
    ld hl, wSlotPersonalityLo
    add_a_to_hl
    ld a, [hl]
    cp a, $C0
    jr c, .next2
    push bc
    call SlotCHasCastableHealSkill
    pop bc
    jr nc, .done2

.next2:
    inc c
    dec b
    jr nz, .loop2

.done:
    ld c, $FF
    ret

.done2:
    ld c, $00
    ret

.done3:
    ld c, $01
    ret

; carry unless slot C has a heal skill ($16-$1A, $7B, $7C or $A1) that its status allows, is not the queued action, and whose MP cost (Data_005_614B) it can pay (E-0128)
; 1 call site from 1 routine (e.g. FailIfFoeHurtAndHealerCanCast)
; reads: wQueuedActionId
; points at: wBattleTargetChoice, wBattleMP
SlotCHasCastableHealSkill::
Func_005_60BA:: ; address name
    ld a, c
    ld hl, wBattleTargetChoice
    swap a
    add_a_to_hl
    ld b, $08

.loop:
    ld a, [hl+]
    cp a, $FF
    jr z, .return_carry
    ld e, a
    cp a, $16
    jr c, .loop2
    ld d, $1B
    cp a, $1B
    jr c, .call_test_slot_status1_bit0_or_side_flag_bit3
    ld d, $05
    cp a, $7B
    jr z, .call_test_slot_status1_bit6
    ld d, $06
    cp a, $7C
    jr z, .call_test_slot_status1_bit6
    ld d, $07
    cp a, $A1
    jr z, .check_queued_action_id

.loop2:
    inc hl
    dec b
    jr nz, .loop

.return_carry:
    scf
    ret

.call_test_slot_status1_bit0_or_side_flag_bit3:
    push hl
    call TestSlotStatus1Bit0OrSideFlagBit3
    pop hl
    jr nz, .loop2
    ld a, e
    sub a, d
    jr .check_queued_action_id2

.call_test_slot_status1_bit6:
    push hl
    call TestSlotStatus1Bit6
    pop hl
    jr nz, .loop2

.check_queued_action_id:
    ld a, d

.check_queued_action_id2:
    ld d, a
    ld a, [wQueuedActionId]
    cp a, e
    jr z, .loop2
    ld a, d
    push hl
    ld hl, SlotCHasCastableHealSkill_Data
    add_a_to_hl
    ld d, [hl]
    ld a, c
    ld hl, wBattleMP
    add a, a
    add_a_to_hl
    ld a, [hl+]
    sub a, d
    ld a, [hl]
    sbc a, $00
    pop hl
    jr c, .loop2
    ret

; C = slot: NZ when its status byte 1 bit 0 is set; otherwise the result of testing bit 3 of its side flag (wD80A for slots 0-3, wD80B for 4-7) (E-0117)
; 1 call site from 1 routine (e.g. SlotCHasCastableHealSkill)
; points at: wBattleStatus1, wSideFlags0
TestSlotStatus1Bit0OrSideFlagBit3::
Func_005_6127:: ; address name
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 0, [hl]
    ret nz
    ld a, c
    rrca
    rrca
    and a, $01
    ld hl, wSideFlags0
    add_a_to_hl
    bit 3, [hl]
    ret

; C = slot: Z clear when bit 6 of its status byte 1 (wD80D) is set; HL points at the byte (E-0114)
; 1 call site from 1 routine (e.g. SlotCHasCastableHealSkill)
; points at: wBattleStatus1
TestSlotStatus1Bit6::
Func_005_6141:: ; address name
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 6, [hl]
    ret

; address loaded by SlotCHasCastableHealSkill
SlotCHasCastableHealSkill_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_005_614B:: ; address name
    db $02, $05, $07, $12, $24, $01, $0C, $1C

; C = 1 when the AI mode is below 4; otherwise $00 when an occupied foe without status 1 mask $2A has bits 4-5 of its wDA74 byte clear, else $FF (E-0125)
; 3 call sites from 3 routines (e.g. AIScoreB_Beat, AIScore_Beat, AIScore_KODance)
; reads: wBattleActor
; points at: wBattleStatus2
AIGateFoeWDA74Bits45::
Func_005_6153:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $04
    jr c, .done2
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus2
    call AddAx9ToHL
    ld a, [hl]
    and a, $2A
    jr nz, .next
    ld a, c
    ld hl, wSlotResistances + $2
    add a, a
    add a, c
    add a, a
    add a, c
    add_a_to_hl
    ld a, [hl]
    and a, $30
    jr z, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $FF
    ret

.done:
    ld c, $00
    ret

.done2:
    ld c, $01
    ret

; C = 1 when wDA53[actor] (the AI mode) is below 3; otherwise C = 0 when wD2CC is non-zero, $FF when it is zero (E-0092)
; 7 call sites from 7 routines (e.g. AIScore_SquallHit_Conditions, AIIronizeUsable, AIScore_Dodge_Sub01_Conditions, AIGuardSkillUsable_7C45, ...)
; reads: wBattleActor, wAIFlag
CheckAIFlagSetModeGated:: ; heuristic: follows a terminator; C0
Func_005_6198:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $03
    jr c, .done2
    ld a, [wAIFlag]
    or a, a
    jr nz, .done
    ld c, $FF
    ret

.done:
    ld c, $00
    ret

.done2:
    ld c, $01
    ret

; only called from AIScore_AquaWall_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_AquaWall_Conditions)
; reads: wBattleActor
; points at: wBattleStatus2
AIScore_AquaWall_Conditions_AddAx9ToHL:: ; heuristic: follows a terminator; C0
Func_005_61B1:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit 3, [hl]
    jr nz, .done
    ld c, $FF
    ret

.done:
    ld c, $00
    ret

; C = 1 when the actor's AI mode is below 2; otherwise takes the highest ATK of the three opposing slots without a status block, subtracts half the actor's DEF (at least 1) and subtracts that from the actor's HP, but both outcomes return C = $FF; no caller found (E-0237)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
UnreferencedEstimateStrongestFoeHit:: ; configured code entry (E-0237); C0
Func_005_61C4:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $02
    jr c, UnreferencedReturnC0_05_6223_Done
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld de, $FFFF

.loop:
    ld a, c
    call CheckSlotStatusBlock
    jr c, .next
    call GetBattleATK_Bank05
    push bc
    ld b, d
    ld c, e
    call CompareHLToBC
    pop bc
    jr nc, .next
    ld d, h
    ld e, l

.next:
    inc c
    dec b
    jr nz, .loop
    ld a, d
    and a, e
    cp a, $FF
    jr z, .done
    ld a, [wBattleActor]
    call GetBattleDEF_Bank05
    srl h
    rr l
    ld a, e
    sub a, l
    ld e, a
    ld a, d
    sbc a, h
    ld d, a
    bit 7, a
    jr z, .read_battle_actor
    ld de, $0001

.read_battle_actor:
    ld a, [wBattleActor]
    call GetBattleHP_Bank05
    ld a, l
    sub a, e
    ld l, a
    ld a, h
    sbc a, d
    ld h, a
    bit 7, a
    jr nz, .done

.done:
    ld c, $FF
    ret

; ld c, $00 / ret after UnreferencedEstimateStrongestFoeHit's ret; nothing reaches it (E-0237)
; no direct call (reached through a table, a jump or a vector)
UnreferencedReturnC0_05_6223:: ; configured code entry (E-0237); C0
Func_005_6223:: ; address name
    ld c, $00
    ret

UnreferencedReturnC0_05_6223_Done::
Jump_005_6226:: ; address name
    ld c, $01
    ret

; only called from AIScore_Curse_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Curse_Conditions)
; reads: wBattleActor
; points at: wBattleStatus
AIScore_Curse_Conditions_AnySlotLacksStatusMask:: ; heuristic: follows a terminator; C0
Func_005_6229:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld hl, wBattleStatus
    ld e, $20
    ld b, $03
    call AnySlotLacksStatusMask
    ret

; only called from AIScore_SuckAir_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_SuckAir_Conditions)
; reads: wBattleActor, wRecordBuffer
; writes: wRecordBuffer
; points at: wBattleSkillsPrefix
AIScore_SuckAir_Conditions_SlotHasSkillWithFlagD:: ; heuristic: follows a terminator; C0
Func_005_623B:: ; address name
    ld a, [wBattleActor]
    swap a
    ld hl, wBattleSkillsPrefix
    add_a_to_hl
    ld b, $08
    ld a, [wRecordBuffer]
    push af
    ld d, $02

.loop:
    inc hl
    ld a, [hl+]
    ld [wRecordBuffer], a
    call SlotHasSkillWithFlagD
    jr nz, .set_record_buffer
    dec b
    jr nz, .loop
    pop af
    ld [wRecordBuffer], a
    ld c, $00
    ret

.set_record_buffer:
    pop af
    ld [wRecordBuffer], a
    ld c, $FF
    ret

; C = $FF when an occupied ally's HP is below Func_005_6298 for it, else $00 (E-0125)
; 3 call sites from 3 routines (e.g. AIHealUsable, AIScore_Hustle_Conditions, AIScore_LoveRain_Conditions)
; reads: wBattleActor
AnyAllyHPBelow6298:: ; heuristic: follows a terminator; C0
Func_005_626B:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .call_any_ally_hp_below6298_get_battle_max_hp

.next:
    inc c
    dec b
    jr nz, .loop
    jr .done

.call_any_ally_hp_below6298_get_battle_max_hp:
    push bc
    ld a, c
    call AnyAllyHPBelow6298_GetBattleMaxHP_Bank05
    push hl
    ld a, c
    call GetBattleHP_Bank05
    pop bc
    call CompareHLToBC
    pop bc
    jr c, .done2
    jr .next

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

; only called from AnyAllyHPBelow6298 (E-0047)
; 1 call site from 1 routine (e.g. AnyAllyHPBelow6298)
; reads: wRecordBuffer
AnyAllyHPBelow6298_GetBattleMaxHP_Bank05::
Func_005_6298:: ; address name
    push bc
    call GetBattleMaxHP_Bank05
    ld a, [wRecordBuffer]
    cp a, $16
    jr z, .call_divide_hl_by_a
    cp a, $17
    jr z, .skip
    cp a, $18
    jr z, .call_divide_hl_by_a2
    cp a, $19
    jr z, .skip
    cp a, $1A
    jr z, .call_divide_hl_by_a2
    cp a, $7C
    jr z, .skip
    cp a, $A1
    jr z, .skip

.call_divide_hl_by_a:
    push hl
    ld a, $0A
    call DivideHLByA
    ld b, h
    ld c, l
    pop hl
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    pop bc
    ret

.skip:
    srl h
    rr l
    ld b, h
    ld c, l
    srl h
    rr l
    add hl, bc
    pop bc
    ret

.call_divide_hl_by_a2:
    ld a, $03
    call DivideHLByA
    add hl, hl
    pop bc
    ret

; only called from AIScore_MPass_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. AIScore_MPass_ActorLacksStatus4Bits67)
; reads: wBattleActor
AIScore_MPass_Sub01_CarryUnlessBattleSlotOutSlotEmpty:: ; heuristic: follows a terminator; C0
Func_005_62E1:: ; address name
    ld a, [wBattleActor]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    cp a, e
    jr z, .next
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .call_get_battle_mp_bank05

.next:
    inc c
    dec b
    jr nz, .loop
    jr .done

.call_get_battle_mp_bank05:
    push bc
    ld a, c
    call GetBattleMP_Bank05
    push hl
    ld a, c
    call GetBattleMaxMP_Bank05
    pop bc
    call CompareHLToBC
    pop bc
    jr c, .done2
    jr .next

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

; the same instruction sequence as HPBandOfSlotTemp0 (bank $05) apart from label operands, which refer to this bank's own routines and tables; the twin's note describes the shape (E-0107)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
HPBandOfSlotTemp0_6312:: ; heuristic: follows a terminator; C0
Func_005_6312:: ; address name
    ldh a, [hTemp0]
    call GetBattleMaxMP_Bank05
    add hl, hl
    ld a, $03
    call DivideHLByA
    push hl
    ldh a, [hTemp0]
    call GetBattleMP_Bank05
    pop bc
    push hl
    call CompareHLToBC
    jr nc, .done
    ldh a, [hTemp0]
    call GetBattleMaxMP_Bank05
    srl h
    rr l
    push hl
    pop bc
    pop hl
    push hl
    call CompareHLToBC
    jr nc, .done2
    ldh a, [hTemp0]
    call GetBattleMaxMP_Bank05
    ld a, $03
    call DivideHLByA
    push hl
    pop bc
    pop hl
    push hl
    call CompareHLToBC
    jr nc, .done3
    ldh a, [hTemp0]
    call GetBattleMaxMP_Bank05
    srl h
    rr l
    srl h
    rr l
    push hl
    pop bc
    pop hl
    push hl
    call CompareHLToBC
    jr nc, .done4
    ldh a, [hTemp0]
    call GetBattleMaxMP_Bank05
    ld a, $0A
    call DivideHLByA
    push hl
    pop bc
    pop hl
    push hl
    call CompareHLToBC
    jr nc, .done5
    jr .done6

.done:
    pop hl
    ld c, $00
    ret

.done2:
    pop hl
    ld c, $01
    ret

.done3:
    pop hl
    ld c, $02
    ret

.done4:
    pop hl
    ld c, $03
    ret

.done5:
    pop hl
    ld c, $04
    ret

.done6:
    pop hl
    ld c, $05
    ret

; only called from AIScore_MegaMagic (E-0047)
; 1 call site from 1 routine (e.g. AIScore_MegaMagic)
; reads: wBattleActor
AIScore_MegaMagic_ReadSlotAIModeIndexed_Bank05:: ; heuristic: follows a terminator; C0
Func_005_6392:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $03
    jr c, .done3
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .call_get_battle_hp_bank05

.next:
    inc c
    dec b
    jr nz, .loop
    jr .done

.call_get_battle_hp_bank05:
    push bc
    ld a, c
    call GetBattleHP_Bank05
    push hl
    ld a, c
    call GetBattleDEF_Bank05
    pop bc
    add hl, bc
    ld bc, $0578
    call CompareHLToBC
    pop bc
    jr nc, .done2
    jr .next

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

.done3:
    ld c, $01
    ret

; C = $FF when an occupied foe without status bit 7 has a skill matching flag D = $10 (Func_005_640A), else $00 (wRecordBuffer preserved) (E-0125)
; 3 call sites from 3 routines (e.g. AIScore_MouthShut_Conditions, AIScore_TailWind_Conditions, AIScore_StormWind_Conditions)
; reads: wRecordBuffer, wBattleActor
; writes: wRecordBuffer
; points at: wBattleStatus1
AnyFoeHasSkillWithFlagD:: ; heuristic: follows a terminator; C0
Func_005_63D2:: ; address name
    ld a, [wRecordBuffer]
    push af
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld d, $10

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 7, [hl]
    jr nz, .next
    call SlotCSkillFlagMatchD
    jr nz, .set_record_buffer

.next:
    inc c
    dec b
    jr nz, .loop
    pop af
    ld [wRecordBuffer], a
    ld c, $00
    ret

.set_record_buffer:
    pop af
    ld [wRecordBuffer], a
    ld c, $FF
    ret

; NZ when one of slot C's skills (other than $89 and $9D) has record byte 5 matching mask D (E-0125)
; 1 call site from 1 routine (e.g. AnyFoeHasSkillWithFlagD)
; reads: hTemp0
; writes: wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3, wRecordBuffer
; points at: hTemp0, wBattleSkills
SlotCSkillFlagMatchD::
Func_005_640A:: ; address name
    push bc
    ld a, $05
    ld [wBattleArg0], a
    ld a, $01
    ld [wBattleArg1], a
    ld hl, hTemp0
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    ld a, c
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld b, $08
    ld c, d

.loop:
    ld a, [hl]
    cp a, $89
    jr z, .next
    cp a, $9D
    jr z, .next
    push bc
    push hl
    ld [wRecordBuffer], a
    farcall LoadSkillRecordPart
    pop hl
    pop bc
    ldh a, [hTemp0]
    and a, c
    jr nz, .done

.next:
    inc hl
    inc hl
    dec b
    jr nz, .loop
    xor a, a

.done:
    ld d, c
    pop bc
    ret

; C = $00 when the side's wC984/wC985 flag is 1 or no other ally slot is occupied, else $FF (E-0125)
; 10 call sites from 10 routines (e.g. AIIronizeUsable, AIScore_LureDance_Conditions, AIScore_StrongD_Conditions, AIScore_Cover_Conditions, ...)
; reads: wBattleActor, wSide0Flag, wSide1Flag
AllyCheckSide0FlagAndOtherSlots:: ; heuristic: follows a terminator; C0
Func_005_6452:: ; address name
    ld a, [wBattleActor]
    cp a, $04
    jr nc, .check_side1_flag
    ld a, [wSide0Flag]
    jr .cp_01

.check_side1_flag:
    ld a, [wSide1Flag]

.cp_01:
    cp a, $01
    jr z, .done
    ld a, [wBattleActor]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    cp a, e
    jr z, .next
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .done2

.next:
    inc c
    dec b
    jr nz, .loop

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

; C = 0 when wC58A is 0 and wCFC5 is below 2, else C = $FF (E-0100)
; 5 call sites from 5 routines (e.g. AIScore_MegaMagic_AIAttackSkillUsable_74D1, AIScore_Skill00, AIScore_FireSlash, AIScore_SlimeBlow, ...)
; reads: wLinkMode, wBattleKind
CheckBattleKindAtLeast2OrLinkModeSet::
Func_005_6481:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr nz, .done
    ld a, [wBattleKind]
    cp a, $02
    jr nc, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; meant to give C = $00 when a foe's HP is below 4 * its wAIDamageEstimates word; it never advances C (first foe only, three times) and deref_hl leaves the estimate's low byte in A, so GetBattleHP_Bank05 reads the HP of that slot number: C = $00 when HP[estimate & $FF] < 4 * estimate, else $FF (a likely game bug; executed, test FoeHPCheckReadsWrongSlot) (E-0125, E-0154)
; 4 call sites from 4 routines (e.g. AIScore_Skill00, AIScore_FireSlash, AIScore_SlimeBlow, AIScore_PoisonHit)
; reads: wBattleActor
; points at: wAIDamageEstimates
FoeHPCheckReadsWrongSlot::
Func_005_6494:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    push bc
    ld a, c
    and a, $03
    ld hl, wAIDamageEstimates
    add a, a
    add_a_to_hl
    deref_hl
    add hl, hl
    add hl, hl
    push hl
    call GetBattleHP_Bank05
    pop bc
    call CompareHLToBC
    pop bc
    jr c, .done

.next:
    dec b
    jr nz, .loop
    jr .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

; C = 0 when wC58A is 0 and the actor is in slots 4-7, else C = $FF (E-0100)
; 3 call sites from 3 routines (e.g. AIScore_Skill00, AIScore_RockThrow, AIScore_PoisonHit)
; reads: wLinkMode, wBattleActor
CheckActorSlot0To3OrLinkModeSet::
Func_005_64CC:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr nz, .done
    ld a, [wBattleActor]
    cp a, $04
    jr c, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; only called from AIScore_Meditate_Conditions (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Meditate_Conditions)
; reads: wBattleActor
AIScore_Meditate_Conditions_GetBattleMaxHP_Bank05:: ; heuristic: follows a terminator; C0
Func_005_64DF:: ; address name
    ld a, [wBattleActor]
    call GetBattleMaxHP_Bank05
    ld a, $03
    call DivideHLByA
    add hl, hl
    push hl
    ld a, [wBattleActor]
    call GetBattleHP_Bank05
    pop bc
    call CompareHLToBC
    jr c, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = 1 when the AI mode is below 2; otherwise $00 when an occupied foe's resistance field for skill wCFEF is 3; $FF when wCFEF is 0 or none is (E-0127)
; 21 call sites from 21 routines (e.g. AIScore_Firebal, AIScore_Beat, AIScore_Sacrifice, AIScore_Sap, ...)
; reads: wBattleActor, wRecordBufferData, hTemp0
; writes: hTemp0, hTemp1
; points at: wSlotResistances
FailIfAnyFoeFullyResistant:: ; heuristic: follows a terminator; C0
Func_005_64FE:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp a, $02
    jr c, .done3
    ld a, [wRecordBufferData + $1]
    or a, a
    jr z, .done2
    dec a
    ld hl, AnyFoeNotFullyResistant_Data
    add a, a
    add_a_to_hl
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, wSlotResistances
    add a, a
    add a, c
    add a, a
    add a, c
    add a, d
    add_a_to_hl
    xor a, a
    ldh [hTemp0], a
    ldh [hTemp1], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ldh a, [hTemp0]
    inc a
    ldh [hTemp0], a
    call Get2BitFieldEOfHL
    cp a, $03
    jr z, .done

.next:
    inc c
    dec b
    jr nz, .loop

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

.done3:
    ld c, $01
    ret

; C = 1 when the AI mode is below 3 or the actor knows a heal-all skill; otherwise $00 when two or more allies have HP below half, else $FF (E-0127)
; 5 call sites from 5 routines (e.g. AIScore_Heal, AIScore_HealUs, AIScore_Hustle, AIScore_Meditate, ...)
; reads: wBattleActor
; points at: wBattleSkillsPrefix
FailIfTwoAlliesBelowHalfHP:: ; heuristic: follows a terminator; C0
Func_005_6556:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_4024
    cp a, $03
    jr c, .done2
    ld a, [wBattleActor]
    ld hl, wBattleSkillsPrefix
    swap a
    add_a_to_hl
    ld b, $08
    call SkillListHas19Or1AOr7COrA1
    jr nz, .done2
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld e, $00

.loop:
    push bc
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .restore
    ld a, c
    call GetBattleMaxHP_Bank05
    srl h
    rr l
    push hl
    ld a, c
    call GetBattleHP_Bank05
    pop bc
    call CompareHLToBC
    jr nc, .restore
    inc e

.restore:
    pop bc
    inc c
    dec b
    jr nz, .loop
    ld a, e
    cp a, $02
    jr c, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

.done2:
    ld c, $01
    ret

; walks B skill numbers at every other byte from HL + 1: Z set as soon as one is $19, $1A, $7C or $A1; otherwise A = 1 and Z clear (E-0117)
; 1 call site from 1 routine (e.g. FailIfTwoAlliesBelowHalfHP)
SkillListHas19Or1AOr7COrA1::
Func_005_65AC:: ; address name
    inc hl
    ld a, [hl+]
    cp a, $19
    ret z
    cp a, $1A
    ret z
    cp a, $7C
    ret z
    cp a, $A1
    ret z
    dec b
    jr nz, SkillListHas19Or1AOr7COrA1
    ld a, $01
    or a, a
    ret

; only called from AIScore_Sap_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Sap_Sub01_CarryUnlessBattleSlotOutSlotEmpty_Sub01)
; reads: wBattleActor, hTemp0, hTemp1
; writes: hTemp0, hTemp1
AIScore_Sap_Sub01_CarryUnlessBattleSlotOutSlotEmpty:: ; heuristic: follows a terminator; C0
Func_005_65C1:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld e, $00
    xor a, a
    ldh [hTemp0], a
    ldh [hTemp1], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call GetBattleATK_Bank05
    ldh a, [hTemp0]
    add a, l
    ldh [hTemp0], a
    ldh a, [hTemp1]
    adc a, h
    ldh [hTemp1], a
    inc e

.next:
    inc c
    dec b
    jr nz, .loop
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, e
    call DivideHLByA
    add hl, hl
    push hl
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00
    xor a, a
    ldh [hTemp0], a
    ldh [hTemp1], a

.loop2:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next2
    call GetBattleDEF_Bank05
    ldh a, [hTemp0]
    add a, l
    ldh [hTemp0], a
    ldh a, [hTemp1]
    adc a, h
    ldh [hTemp1], a
    inc e

.next2:
    inc c
    dec b
    jr nz, .loop2
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, e
    call DivideHLByA
    ld c, l
    ld b, h
    pop hl
    call CompareHLToBC
    jr c, .done
    jr z, .done
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    push hl
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00
    xor a, a
    ldh [hTemp0], a
    ldh [hTemp1], a

.loop3:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next3
    call GetBattleHP_Bank05
    ldh a, [hTemp0]
    add a, l
    ldh [hTemp0], a
    ldh a, [hTemp1]
    adc a, h
    ldh [hTemp1], a
    inc e

.next3:
    inc c
    dec b
    jr nz, .loop3
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, e
    srl h
    rr l
    call DivideHLByA
    ld c, l
    ld b, h
    pop hl
    call CompareHLToBC
    jr c, .done
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = 1 when the AI mode is below 4 or the actor knows a heal skill; otherwise compares the stat sums of the empty and occupied ally slots and returns $00 or $FF (E-0129)
; 4 call sites from 4 routines (e.g. AIScore_Vivify, AIScore_Farewell, AIScore_LifeDance, AIScore_LifeSong)
; reads: wBattleActor, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4
; writes: hTemp0, hTemp1, hTemp2, hTemp3, hTemp4
; points at: wBattleSkillsPrefix
AIGateCompareAllyStatAverages:: ; heuristic: follows a terminator; C0
Func_005_667F:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_4024
    cp a, $04
    jp c, .done3
    ld a, [wBattleActor]
    ld hl, wBattleSkillsPrefix
    swap a
    add_a_to_hl
    ld b, $08
    call SkillListHasAnyOf16To1A7C9FA1
    jr nz, .done3
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld d, $00
    xor a, a
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a

.loop:
    push bc
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .restore
    jr z, .restore
    call AddSlotStatSumToTemp0

.restore:
    pop bc
    inc c
    dec b
    jr nz, .loop
    ld a, d
    or a, a
    jr z, .done
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ldh a, [hTemp2]
    ld e, a
    ld a, d
    call Divide24ByA
    ld a, l
    ldh [hTemp3], a
    ld a, h
    ldh [hTemp4], a
    ld a, [wBattleActor]
    and a, $04
    ld c, a
    ld b, $03
    ld d, $00
    xor a, a
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a

.loop2:
    push bc
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .restore2
    call AddSlotStatSumToTemp0

.restore2:
    pop bc
    inc c
    dec b
    jr nz, .loop2
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ldh a, [hTemp2]
    ld e, a
    ld a, d
    call Divide24ByA
    srl h
    rr l
    srl h
    rr l
    ldh a, [hTemp3]
    ld c, a
    ldh a, [hTemp4]
    ld b, a
    call CompareHLToBCFastZero
    jr c, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

.done3:
    ld c, $01
    ret

; walks B skill numbers at every other byte from HL + 1: Z as soon as one is $16-$1A, $7C, $9F or $A1; otherwise A = 1 and Z clear (E-0120)
; 1 call site from 1 routine (e.g. AIGateCompareAllyStatAverages)
SkillListHasAnyOf16To1A7C9FA1::
Func_005_6720:: ; address name
    inc hl
    ld a, [hl+]
    cp a, $16
    ret z
    cp a, $17
    ret z
    cp a, $18
    ret z
    cp a, $19
    ret z
    cp a, $1A
    ret z
    cp a, $7C
    ret z
    cp a, $9F
    ret z
    cp a, $A1
    ret z
    dec b
    jr nz, SkillListHasAnyOf16To1A7C9FA1
    ld a, $01
    or a, a
    ret

; adds MaxHP + MaxMP + ATK + DEF of slot C to the 24-bit total at hFFC6-hFFC8; D += 1 (E-0121)
; 2 call sites from 1 routine (e.g. AIGateCompareAllyStatAverages)
; reads: hTemp0, hTemp1, hTemp2
; writes: hTemp0, hTemp1, hTemp2
AddSlotStatSumToTemp0::
Func_005_6741:: ; address name
    push de
    ld a, c
    call GetBattleMaxHP_Bank05
    push hl
    ld a, c
    call GetBattleMaxMP_Bank05
    pop de
    add hl, de
    push hl
    ld a, c
    call GetBattleATK_Bank05
    pop de
    add hl, de
    push hl
    ld a, c
    call GetBattleDEF_Bank05
    pop de
    add hl, de
    pop de
    ldh a, [hTemp0]
    add a, l
    ldh [hTemp0], a
    ldh a, [hTemp1]
    adc a, h
    ldh [hTemp1], a
    ldh a, [hTemp2]
    adc a, $00
    ldh [hTemp2], a
    inc d
    ret

; only called from AIScore_BiAttack (E-0047)
; 1 call site from 1 routine (e.g. AIScore_BiAttack)
; reads: wBattleActor
; points at: wAIDamageEstimates
AIScore_BiAttack_CarryUnlessBattleSlotOutSlotEmpty:: ; heuristic: follows a terminator; C0
Func_005_676E:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    push bc
    ld a, c
    and a, $03
    add a, a
    ld hl, wAIDamageEstimates
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, $78
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    pop bc
    push bc
    push hl
    ld a, c
    call GetBattleHP_Bank05
    pop bc
    call CompareHLToBC
    pop bc
    jr c, .done

.next:
    inc c
    dec b
    jr nz, .loop
    jr .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

; only called from AIScore_Berserker (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Berserker)
; reads: wBattleActor
; points at: wAIDamageEstimates
AIScore_Berserker_ReadSlotAIModeIndexed_Bank05_4024:: ; heuristic: follows a terminator; C0
Func_005_67B2:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_4024
    cp a, $02
    jr c, .done3
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00
    ld d, $00

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld e, c
    inc d

.next:
    inc c
    dec b
    jr nz, .loop
    ld a, d
    cp a, $02
    jr c, .done2
    ld a, [wBattleActor]
    call GetBattleAGL_Bank05
    ld a, e
    push de
    push hl
    call GetBattleAGL_Bank05
    ld a, $78
    ld b, h
    ld c, l
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    pop bc
    call CompareHLToBC
    pop de
    jr nc, .done2
    ld a, e
    and a, $03
    add a, a
    ld hl, wAIDamageEstimates
    add_a_to_hl
    deref_hl
    add hl, hl
    push hl
    ld a, e
    call GetBattleHP_Bank05
    pop bc
    call CompareHLToBC
    jr c, .done
    jr nz, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

.done3:
    ld c, $01
    ret

; only called from AIScore_Ramming (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Ramming)
; reads: wBattleActor, wRecordBufferData
; points at: wSlotResistances
AIScore_Ramming_ReadSlotAIModeIndexed_Bank05_4024:: ; heuristic: follows a terminator; C0
Func_005_6820:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_4024
    cp a, $02
    jr c, .done2
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00
    ld d, $00

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld e, c
    inc d

.next:
    inc c
    dec b
    jr nz, .loop
    ld a, d
    cp a, $02
    jr c, .done
    ld c, e
    ld a, [wRecordBufferData + $1]
    or a, a
    jr z, .done
    push de
    dec a
    ld hl, AnyFoeNotFullyResistant_Data
    add a, a
    add_a_to_hl
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, c
    ld b, $03
    ld hl, wSlotResistances
    add a, a
    add a, c
    add a, a
    add a, c
    add a, d
    add_a_to_hl
    call Get2BitFieldEOfHL
    cp a, $02
    pop de
    jr nc, .done
    ld a, e
    call GetBattleHP_Bank05
    push hl
    ld a, [wBattleActor]
    call GetBattleHP_Bank05
    ld a, $3C
    ld b, h
    ld c, l
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    pop bc
    call CompareHLToBC
    jr nc, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

.done2:
    ld c, $01
    ret

; only called from AIScore_Kamikaze (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Kamikaze)
; reads: wBattleActor, wLinkMode, wBattleKind, wAIFlag, wRecordBufferData
; points at: wSlotMarks, wSlotResistances
AIScore_Kamikaze_ReadSlotAIModeIndexed_Bank05_4024:: ; heuristic: follows a terminator; C0
Func_005_689C:: ; address name
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_4024
    cp a, $03
    jp c, .done3
    ld a, [wLinkMode]
    or a, a
    jp nz, .done2
    ld a, [wBattleKind]
    cp a, $02
    jp nc, .done2
    ld a, [wAIFlag]
    or a, a
    jp z, .done2
    ld a, [wBattleActor]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    cp a, e
    jr z, .next
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    call ReadSlotAIModeIndexed_Bank05_4024
    cp a, $03
    jr c, .next
    push de
    call AIScore_Kamikaze_CheckSkills
    pop de
    jr nz, .next
    ld a, c
    push de
    call CheckSlotStatusBlock
    pop de
    jr c, .next
    ld a, c
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    cp a, $03
    jr c, .read_battle_actor

.next:
    inc c
    dec b
    jr nz, .loop
    jr .done2

.read_battle_actor:
    ld a, [wBattleActor]
    call GetBattleHP_Bank05
    srl h
    rr l
    push hl
    ld a, [wBattleActor]
    call GetBattleHP_Bank05
    pop bc
    call CompareHLToBC
    jr nc, .done2
    ld de, $0064
    add hl, de
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop2:
    push hl
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    pop hl
    jr c, .next2
    push bc
    push hl
    push hl
    ld a, c
    call GetBattleHP_Bank05
    pop bc
    call CompareHLToBC
    pop hl
    pop bc
    jr c, .next2
    ld a, [wRecordBufferData + $1]
    or a, a
    jr z, .done2
    push bc
    push hl
    dec a
    ld hl, AnyFoeNotFullyResistant_Data
    add a, a
    add_a_to_hl
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, c
    ld hl, wSlotResistances
    add a, a
    add a, c
    add a, a
    add a, c
    add a, d
    add_a_to_hl
    call Get2BitFieldEOfHL
    pop hl
    pop bc
    cp a, $02
    jr c, .done

.next2:
    inc c
    dec b
    jr nz, .loop2
    jr .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

.done3:
    ld c, $01
    ret

; apparently meant to test the actor's status byte 4 (wD810 + 9 * actor) & $03 like the neighbouring checks, but it never loads the byte: it tests A & 3 where A is the low byte of that address left by AddAx9ToHL. So C = $FF for slots 0 and 4 and C = 0 for slots 1, 2, 5 and 6 whatever the status (a likely bug; executed, test Status4CheckReadsAddress) (E-0075)
; 8 call sites from 8 routines (e.g. AIScore_ChargeUp_Conditions, AIScore_Skill00, AIScore_FireSlash, AIScore_SlimeBlow, ...)
; reads: wBattleActor
; points at: wBattleStatus4
ActorStatus4CheckReadsAddress::
Func_005_6972:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    and a, $03
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; only called from AIScore_BiAttack_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. AIScore_BiAttack_CheckSkillUsableElseResetAISkillScore)
; reads: wBattleActor, hTemp4, hTemp5, hTemp3
; writes: hTemp3, hTemp4, hTemp5
; points at: hTemp3
AIScore_BiAttack_Sub02_CarryUnlessBattleSlotOutSlotEmpty:: ; heuristic: follows a terminator; C0
Func_005_6985:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hTemp3], a
    ldh [hTemp4], a
    ldh [hTemp5], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call GetBattleDEF_Bank05
    ldh a, [hTemp4]
    add a, l
    ldh [hTemp4], a
    ldh a, [hTemp5]
    adc a, h
    ldh [hTemp5], a
    ld hl, hTemp3
    inc [hl]

.next:
    inc c
    dec b
    jr nz, .loop
    ldh a, [hTemp4]
    ld l, a
    ldh a, [hTemp5]
    ld h, a
    ldh a, [hTemp3]
    call DivideHLByA
    push hl
    ld a, [wBattleActor]
    call GetBattleATK_Bank05
    ld d, h
    ld e, l
    srl d
    rr e
    srl d
    rr e
    add hl, de
    pop bc
    call CompareHLToBC
    jr nc, .done
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; C = 0 when the actor's status byte 2 (wD80E) bit 1 or byte 4 & $03 is set, else C = $FF (E-0072)
; 14 call sites from 14 routines (e.g. AIScore_Skill00, AIScore_FireSlash, AIScore_SlimeBlow, AIScore_PoisonHit, ...)
; reads: wBattleActor
; points at: wBattleStatus2
ActorLacksStatus2Bit1And4Bits01::
Func_005_69DA:: ; address name
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    ld a, [hl+]
    and a, $02
    jr nz, .done
    inc hl
    inc hl
    ld a, [hl]
    and a, $03
    jr z, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

; C = 1 for the player side outside link battles; otherwise like PassIfFoesAverageResistanceAtLeast2 (E-0128)
; 20 call sites from 20 routines (e.g. AIScore_Beat, AIScore_Sap, AIScore_Slow, AIScore_Surround, ...)
; reads: wLinkMode, wBattleActor, wRecordBufferData, hTemp0, hTemp1
; writes: hTemp0, hTemp1
; points at: wSlotResistances
ResistanceAverageGateForAISide:: ; heuristic: follows a terminator; C0
Func_005_69F5:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr z, .check_record_buffer_data
    ld a, [wBattleActor]
    cp a, $04
    jr nc, .done3

.check_record_buffer_data:
    ld a, [wRecordBufferData + $1]
    or a, a
    jr z, .done2
    dec a
    ld hl, AnyFoeNotFullyResistant_Data
    add a, a
    add_a_to_hl
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, wSlotResistances
    add a, a
    add a, c
    add a, a
    add a, c
    add a, d
    add_a_to_hl
    xor a, a
    ldh [hTemp0], a
    ldh [hTemp1], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    ldh a, [hTemp0]
    inc a
    ldh [hTemp0], a
    call Get2BitFieldEOfHL
    ld d, a
    ldh a, [hTemp1]
    add a, d
    ldh [hTemp1], a

.skip:
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, .loop
    ldh a, [hTemp1]
    or a, a
    jr z, .done
    ld b, a
    ldh a, [hTemp0]
    call DivideBByA
    ld a, b
    cp a, $02
    jr nc, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

.done3:
    ld c, $01
    ret

; C = 1 in link battles, for the player side, or when the AI mode is below 3; otherwise like PassIfFoesAverageResistanceAtLeast2 (E-0128)
; 20 call sites from 20 routines (e.g. AIScore_Beat, AIScore_Sap, AIScore_Slow, AIScore_Surround, ...)
; reads: wLinkMode, wBattleActor, wRecordBufferData, hTemp0, hTemp1
; writes: hTemp0, hTemp1
; points at: wSlotResistances
ResistanceAverageGateForFoeAIMode3:: ; heuristic: follows a terminator; C0
Func_005_6A6B:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr z, .done3
    ld a, [wBattleActor]
    cp a, $04
    jr c, .done3
    call ReadSlotAIModeIndexed_Bank05
    cp a, $03
    jr c, .done3
    ld a, [wRecordBufferData + $1]
    or a, a
    jr z, .done2
    dec a
    ld hl, AnyFoeNotFullyResistant_Data
    add a, a
    add_a_to_hl
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, wSlotResistances
    add a, a
    add a, c
    add a, a
    add a, c
    add a, d
    add_a_to_hl
    xor a, a
    ldh [hTemp0], a
    ldh [hTemp1], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    ldh a, [hTemp0]
    inc a
    ldh [hTemp0], a
    call Get2BitFieldEOfHL
    ld d, a
    ldh a, [hTemp1]
    add a, d
    ldh [hTemp1], a

.skip:
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, .loop
    ldh a, [hTemp1]
    or a, a
    jr z, .done
    ld b, a
    ldh a, [hTemp0]
    call DivideBByA
    ld a, b
    cp a, $02
    jr nc, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

.done3:
    ld c, $01
    ret

; wDA6E = wDA6F = 0 and wDA70 = wDA71 = $FF
; 108 call sites from 108 routines (e.g. AIScore_Skill00_Conditions, AIFireSkillUsable, AIScore_Beat_Conditions, AIScore_Sacrifice_ActorCanPayMPCost_Bank05, ...)
; writes: wAISkillScore, wAISkillScore2
ResetAISkillScore::
Func_005_6AE8:: ; address name
    xor a, a
    ld [wAISkillScore], a
    ld [wAISkillScore + $1], a
    ld a, $FF
    ld [wAISkillScore2], a
    ld [wAISkillScore2 + $1], a
    ret

; the word wDA6E/wDA6F += BC (E-0094)
; no direct call (reached through a table, a jump or a vector)
; reads: wAISkillScore
; writes: wAISkillScore
AddBCToAISkillScore:: ; heuristic: follows a terminator; C0
Func_005_6AF8:: ; address name
    ld a, [wAISkillScore]
    add a, c
    ld [wAISkillScore], a
    ld a, [wAISkillScore + $1]
    adc a, b
    ld [wAISkillScore + $1], a
    ret

; the word wDA70/wDA71 += BC (E-0094)
; no direct call (reached through a table, a jump or a vector)
; reads: wAISkillScore2
; writes: wAISkillScore2
AddBCToAISkillScore2:: ; heuristic: follows a terminator; C0
Func_005_6B07:: ; address name
    ld a, [wAISkillScore2]
    add a, c
    ld [wAISkillScore2], a
    ld a, [wAISkillScore2 + $1]
    adc a, b
    ld [wAISkillScore2 + $1], a
    ret

; A = the byte at wDA53 + A; clobbers HL (the same 10 bytes appear in 5 banks)
; 36 call sites from 36 routines (e.g. UnreferencedEstimateStrongestFoeHit, FailIfAbleAllyKnowsSkill42To47, FailIfAbleAllyKnowsSkillList6D1A, FailIfAbleAllyWithStatus6KnowsSkill78To92, ...)
; points at: wSlotAIMode
ReadSlotAIModeIndexed_Bank05::
Func_005_6B16:: ; address name
    ld hl, wSlotAIMode
    add_a_to_hl
    ld a, [hl]
    ret

; only called from AIScore_Upper_Conditions_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Upper_Conditions_CarryUnlessBattleSlotOutSlotEmpty)
; reads: wBattleStatResultLo, wBattleStatResultHi, wLinkMode
AIScore_Upper_Conditions_Sub01_GetBattleDEF_Bank05:: ; heuristic: follows a terminator; C0
Func_005_6B20:: ; address name
    call GetBattleDEF_Bank05
    ld a, l
    sub a, $E7
    ld a, h
    sbc a, $03
    jr nc, .return_0
    push hl
    push bc
    farcall GetBaseDEF
    pop bc
    pop hl
    inc hl
    ld a, [wBattleStatResultLo]
    ld e, a
    ld a, [wBattleStatResultHi]
    ld d, a
    sla e
    rl d
    ld a, [wLinkMode]
    or a, a
    jr z, .skip
    cp a, $02
    jr nz, .skip2

.skip:
    ld a, c
    cp a, $04
    jr nc, .skip3

.skip2:
    sla e
    rl d

.skip3:
    ld a, e
    sub a, l
    ld a, d
    sbc a, h
    jr nc, .return_carry

.return_0:
    xor a, a
    ret

.return_carry:
    scf
    ret

; only called from AIScore_Speed_Conditions_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Speed_Conditions_CarryUnlessBattleSlotOutSlotEmpty)
; reads: wBattleStatResultLo, wBattleStatResultHi, wLinkMode
AIScore_Speed_Conditions_Sub01_GetBattleAGL_Bank05:: ; heuristic: follows a terminator; C0
Func_005_6B5F:: ; address name
    call GetBattleAGL_Bank05
    ld a, l
    sub a, $E7
    ld a, h
    sbc a, $03
    jr nc, .return_0
    push hl
    push bc
    farcall GetBaseAGL
    pop bc
    pop hl
    inc hl
    ld a, [wBattleStatResultLo]
    ld e, a
    ld a, [wBattleStatResultHi]
    ld d, a
    sla e
    rl d
    ld a, [wLinkMode]
    or a, a
    jr z, .skip
    cp a, $02
    jr nz, .skip2

.skip:
    ld a, c
    cp a, $04
    jr nc, .skip3

.skip2:
    sla e
    rl d

.skip3:
    ld a, e
    sub a, l
    ld a, d
    sbc a, h
    jr nc, .return_carry

.return_0:
    xor a, a
    ret

.return_carry:
    scf
    ret

; C = slot: compares its HP with 3/4 of its max HP (CompareHLToBC): carry when below; BC kept (E-0120)
; 1 call site from 1 routine (e.g. AnyAllyHPAtMostThreeQuarters)
CompareHPWithThreeQuartersMax:: ; heuristic: follows a terminator; C0
Func_005_6B9E:: ; address name
    push bc
    ld a, c
    call GetBattleMaxHP_Bank05
    ld c, l
    ld b, h
    add hl, hl
    add hl, bc
    sra h
    rr l
    sra h
    rr l
    pop bc
    push bc
    push hl
    ld a, c
    call GetBattleHP_Bank05
    pop bc
    call CompareHLToBC
    pop bc
    ret

; A = slot whose max HP is used, C = slot whose HP is used (callers normally pass the same slot): compares 2 x HP with the max HP (CompareHLToBC): carry set when HP is below 1/2 of max, Z when exactly 1/2; BC kept (E-0094)
; no direct call (reached through a table, a jump or a vector)
CompareHPWithHalfMax:: ; heuristic: follows a terminator; C0
Func_005_6BBC:: ; address name
    push bc
    push af
    call GetBattleMaxHP_Bank05
    pop af
    push hl
    ld a, c
    call GetBattleHP_Bank05
    add hl, hl
    pop bc
    call CompareHLToBC
    pop bc
    ret

; A = slot whose max HP is used, C = slot whose HP is used (callers normally pass the same slot): compares 4 x HP with the max HP (CompareHLToBC): carry set when HP is below 1/4 of max, Z when exactly 1/4; BC kept (E-0094)
; no direct call (reached through a table, a jump or a vector)
CompareHPWithQuarterMax:: ; heuristic: follows a terminator; C0
Func_005_6BCE:: ; address name
    push bc
    push af
    call GetBattleMaxHP_Bank05
    pop af
    push hl
    ld a, c
    call GetBattleHP_Bank05
    add hl, hl
    add hl, hl
    pop bc
    call CompareHLToBC
    pop bc
    ret

; A = slot whose max HP is used, C = slot whose HP is used (callers normally pass the same slot): compares 10 x HP with the max HP (CompareHLToBC): carry set when HP is below 1/10 of max, Z when exactly 1/10; BC kept (E-0094)
; no direct call (reached through a table, a jump or a vector)
CompareHPWithTenthMax:: ; heuristic: follows a terminator; C0
Func_005_6BE1:: ; address name
    push bc
    push af
    call GetBattleMaxHP_Bank05
    pop af
    push hl
    ld a, c
    call GetBattleHP_Bank05
    add hl, hl
    ld b, h
    ld c, l
    add hl, hl
    add hl, hl
    add hl, bc
    pop bc
    call CompareHLToBC
    pop bc
    ret

; A = slot: returns NZ when its HP (GetBattleHP_Bank05) is 256 or more; otherwise compares the low byte with 1: Z when HP = 1, carry when HP = 0 (E-0114)
; 2 call sites from 2 routines (e.g. ActorHPIsNotOne, FewerThanTwoAlliesAtHP1)
CompareSlotHPWith1::
Func_005_6BF8:: ; address name
    call GetBattleHP_Bank05
    ld a, h
    or a, a
    ret nz
    ld a, l
    cp a, $01
    ret

; C = slot, D = mask: walks the slot's 8 skill numbers (every other byte of the 16 bytes at wD989 + 16 * C), loading part of each skill record into hFFC6 (LoadSkillRecordPart with wD868 = 5, wD869 = 1); returns A = hFFC6 & D for the first skill with a masked bit set, else A = 0; BC kept (E-0092)
; 8 call sites from 8 routines (e.g. AIScore_SuckAir_Conditions_SlotHasSkillWithFlagD, AnyActiveFoeHasSkillFlag40, AnyFoeHasSkillFlag10, AIScore_AquaWall_Conditions_ReadSlotAIModeIndexed_Bank05, ...)
; reads: hTemp0
; writes: wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3, wRecordBuffer
; points at: hTemp0, wBattleSkills
SlotHasSkillWithFlagD::
Func_005_6C02:: ; address name
    push bc
    ld a, $05
    ld [wBattleArg0], a
    ld a, $01
    ld [wBattleArg1], a
    ld hl, hTemp0
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    ld a, c
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld b, $08
    ld c, d

.loop:
    push bc
    push hl
    ld a, [hl]
    ld [wRecordBuffer], a
    farcall LoadSkillRecordPart
    pop hl
    pop bc
    ldh a, [hTemp0]
    and a, c
    jr nz, .done
    inc hl
    inc hl
    dec b
    jr nz, .loop
    xor a, a

.done:
    ld d, c
    pop bc
    ret

; A = how many of slot C's skills have record byte 1 = 0 (flags from A) (E-0125)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3, wRecordBuffer
; points at: hTemp0, wBattleSkills
CountSkillsWithZeroRecordByte1:: ; heuristic: follows a terminator; C0
Func_005_6C42:: ; address name
    push bc
    ld a, $01
    ld [wBattleArg0], a
    ld a, $01
    ld [wBattleArg1], a
    ld hl, hTemp0
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    ld a, c
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld bc, $0800

.loop:
    ld a, [hl]
    cp a, $FF
    jr z, .next
    push bc
    push hl
    ld [wRecordBuffer], a
    farcall LoadSkillRecordPart
    pop hl
    pop bc
    ldh a, [hTemp0]
    or a, a
    jr nz, .next
    inc c

.next:
    inc hl
    dec b
    jr nz, .loop
    ld a, c
    or a, a
    pop bc
    ret

; E = field number: A = bits 1-0 of [HL] for field 0, bits 3-2 for 1, bits 5-4 for 2, bits 7-6 for 3 (moved down to bits 1-0) (E-0092)
; 8 call sites from 8 routines (e.g. AnyFoeNotFullyResistant, ResistanceAverageGateForAISide, PassIfFoesAverageResistanceAtLeast2, ResistanceAverageGateForFoeAIMode3, ...)
Get2BitFieldEOfHL::
Func_005_6C86:: ; address name
    ld a, e
    or a, a
    jr z, .skip
    cp a, $01
    jr z, .skip2
    cp a, $02
    jr z, .skip3
    ld a, [hl]
    rlca
    rlca
    jr .done

.skip:
    ld a, [hl]
    jr .done

.skip2:
    ld a, [hl]
    rrca
    rrca
    jr .done

.skip3:
    ld a, [hl]
    swap a

.done:
    and a, $03
    ret

; A = battle slot: A = the family (byte 0 of the species record) of the monster id in wBattleMonsterId[slot] (LoadSpeciesFamily); BC kept (E-0069)
; 1 call site from 1 routine (e.g. FoeOfFamilyEPresent)
; reads: wSpeciesRecord
; writes: wSpeciesIdLo, wSpeciesIdHi
; points at: wBattleMonsterId
GetSlotSpeciesFamily:: ; heuristic: follows a terminator; C0
Func_005_6CA5:: ; address name
    ld hl, wBattleMonsterId
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    push bc
    farcall LoadSpeciesFamily
    pop bc
    ld a, [wSpeciesRecord]
    ret

; only called from routines of AIScore_TwinHits (E-0098)
; 2 call sites from 2 routines (e.g. AIScore_TwinHits_ReadSlotAIModeIndexed_Bank05, AIScore_TwinHits_ReadSlotAIModeIndexed_Bank05_Sub02)
; reads: wBattleActor, hTemp0, hTemp1
; writes: hTemp0, hTemp1
AIScore_TwinHits_CarryUnlessBattleSlotOutSlotEmpty:: ; heuristic: follows a terminator; C0
Func_005_6CC2:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hTemp0], a
    ldh [hTemp1], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .call_get_battle_def_bank05
    inc c
    dec b
    jr nz, .loop
    jr .return

.call_get_battle_def_bank05:
    ld a, c
    call GetBattleDEF_Bank05
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    inc c
    dec b
    jr z, .return

.loop2:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call GetBattleDEF_Bank05
    ldh a, [hTemp0]
    sub a, l
    ldh a, [hTemp1]
    sbc a, h
    jr c, .next
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a

.next:
    inc c
    dec b
    jr nz, .loop2

.return:
    ret

; slot C: returns NZ when bit 1 of status byte 0 is set, otherwise A = status byte 4 & 3 with flags from it (E-0122)
; 1 call site from 1 routine (e.g. PassIfFoeAverageATKAtMostTwiceAllyDEF)
; points at: wBattleStatus1
SlotStatus0Bit1OrStatus4Bits01:: ; heuristic: follows a terminator; C0
Func_005_6D07:: ; address name
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 1, [hl]
    jr nz, .return
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $03

.return:
    ret

; A = how many of slot A's eight skills are $03, $06, $09, $0C, $0F, $12, $13 or $14 (Z set when none); BC kept (E-0175)
; 2 call sites from 2 routines (e.g. FailIfAbleAllyKnowsSkillList6D1A, AIModeAtLeast2AndFoeLacks6D1A)
; points at: wBattleSkills
CountSkillsInList6D1A::
Func_005_6D1A:: ; address name
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    push bc
    ld bc, $0800

.loop:
    ld a, [hl+]
    cp a, $03
    jr z, .next
    cp a, $06
    jr z, .next
    cp a, $09
    jr z, .next
    cp a, $0C
    jr z, .next
    cp a, $0F
    jr z, .next
    cp a, $12
    jr z, .next
    cp a, $13
    jr z, .next
    cp a, $14
    jr z, .next
    jr .next2

.next:
    inc c

.next2:
    inc hl
    dec b
    jr nz, .loop
    ld a, c
    or a, a
    pop bc
    ret

; A = how many of slot A's skills are $03, $06, $09, $0C, $0F, $12-$15 or $3D-$3F (E-0125)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleSkills
CountSkillsInList6D54:: ; heuristic: follows a terminator; C0
Func_005_6D54:: ; address name
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    push bc
    ld bc, $0800

.loop:
    ld a, [hl+]
    cp a, $03
    jr z, .next
    cp a, $06
    jr z, .next
    cp a, $09
    jr z, .next
    cp a, $0C
    jr z, .next
    cp a, $0F
    jr z, .next
    cp a, $12
    jr z, .next
    cp a, $13
    jr z, .next
    cp a, $14
    jr z, .next
    cp a, $15
    jr z, .next
    cp a, $3D
    jr z, .next
    cp a, $3E
    jr z, .next
    cp a, $3F
    jr z, .next
    jr .next2

.next:
    inc c

.next2:
    inc hl
    dec b
    jr nz, .loop
    ld a, c
    or a, a
    pop bc
    ret

; A = how many of slot A's skills are $16-$24, $7B-$7C, $81 or $9F-$A0 (E-0125)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleSkills
CountSkillsInRanges6D9E:: ; heuristic: follows a terminator; C0
Func_005_6D9E:: ; address name
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    push bc
    ld bc, $0800

.loop:
    ld a, [hl+]
    or a, a
    jr z, .next2
    cp a, $FF
    jr z, .next2
    cp a, $16
    jr c, .next2
    cp a, $25
    jr c, .next
    cp a, $7B
    jr c, .next2
    cp a, $7D
    jr c, .next
    cp a, $81
    jr z, .next
    cp a, $9F
    jr c, .next2
    cp a, $A1
    jr nc, .next2

.next:
    inc c

.next2:
    inc hl
    dec b
    jr nz, .loop
    ld a, c
    pop bc
    or a, a
    ret

; A = how many of slot A's eight skills are $16-$1A or $1E-$20 (E-0124)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleSkills
CountSkills16To1AOr1ETo20:: ; heuristic: follows a terminator; C0
Func_005_6DD9:: ; address name
    push bc
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld bc, $0800

.loop:
    ld a, [hl+]
    cp a, $16
    jr c, .next2
    cp a, $1B
    jr c, .next
    cp a, $1E
    jr c, .next2
    cp a, $21
    jr nc, .next2

.next:
    inc c

.next2:
    dec b
    jr nz, .loop
    ld a, c
    pop bc
    ret

; HL = the average AGL of the occupied slots A, A + 1, A + 2 (E-0124)
; 2 call sites from 1 routine (e.g. AllyAverageAGLAtLeastFoes)
; reads: hTemp1, hTemp2, hTemp0
; writes: hTemp0, hTemp1, hTemp2
; points at: hTemp0
AverageAGLOfSideA::
Func_005_6DFF:: ; address name
    ld c, a
    ld b, $03
    xor a, a
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call GetBattleAGL_Bank05
    ldh a, [hTemp1]
    add a, l
    ldh [hTemp1], a
    ldh a, [hTemp2]
    adc a, h
    ldh [hTemp2], a
    ld hl, hTemp0
    inc [hl]

.next:
    inc c
    dec b
    jr nz, .loop
    ldh a, [hTemp1]
    ld l, a
    ldh a, [hTemp2]
    ld h, a
    ldh a, [hTemp0]
    call DivideHLByA
    ret

; D = the number of set status bits and fields in slot C's 9-byte wD80D record (checks 16 flags across bytes 0, 1, 4, 5 and 7) (E-0121)
; 1 call site from 1 routine (e.g. PassIfSkill83OrNoAllyHasStatus)
; points at: wBattleStatus1
CountActiveStatusEffectsOfSlotC::
Func_005_6E30:: ; address name
    ld a, c
    ld d, $00
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit 2, [hl]
    call nz, IncrementD
    bit 3, [hl]
    call nz, IncrementD
    bit 4, [hl]
    call nz, IncrementD
    bit 5, [hl]
    call nz, IncrementD
    inc hl
    bit 0, [hl]
    call nz, IncrementD
    bit 1, [hl]
    call nz, IncrementD
    bit 2, [hl]
    call nz, IncrementD
    bit 3, [hl]
    call nz, IncrementD
    bit 5, [hl]
    call nz, IncrementD
    bit 6, [hl]
    call nz, IncrementD
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $0C
    call nz, IncrementD
    ld a, [hl]
    and a, $C0
    call nz, IncrementD
    inc hl
    bit 6, [hl]
    call nz, IncrementD
    inc hl
    inc hl
    bit 6, [hl]
    call nz, IncrementD
    ret

; D += 1 (E-0072)
; 14 call sites from 1 routine (e.g. CountActiveStatusEffectsOfSlotC)
IncrementD::
Func_005_6E89:: ; address name
    inc d
    ret

; D = how many of slot A's skills were read, E = how many have bit 6 set in record byte 5 (E-0125)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp2
; writes: wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3, wRecordBuffer
; points at: wBattleSkills
CountSkillsWithFlag6:: ; heuristic: follows a terminator; C0
Func_005_6E8B:: ; address name
    push bc
    ld de, $0000
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld a, $05
    ld [wBattleArg0], a
    ld a, $01
    ld [wBattleArg1], a
    ld a, $C8
    ld [wBattleArg2], a
    ld a, $FF
    ld [wBattleArg3], a
    ld b, $08

.loop:
    push bc
    ld a, [hl+]
    ld [wRecordBuffer], a
    cp a, $FF
    jr z, .restore
    push de
    push hl
    farcall LoadSkillRecordPart
    pop hl
    pop de
    inc d
    ldh a, [hTemp2]
    bit 6, [hl]
    jr z, .restore
    inc e

.restore:
    pop bc
    inc hl
    dec b
    jr nz, .loop
    pop bc
    ret

; A = how many of slot C's skills are $01-$15 or $2E-$34 except $31 (flags set from A) (E-0124)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleSkills
CountSkillsBelow16Or2ETo34Except31:: ; heuristic: follows a terminator; C0
Func_005_6ED1:: ; address name
    push bc
    ld a, c
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld bc, $0800

.loop:
    ld a, [hl+]
    cp a, $FF
    jr z, .next2
    or a, a
    jr z, .next2
    cp a, $16
    jr c, .next
    cp a, $2E
    jr c, .next2
    cp a, $31
    jr z, .next2
    cp a, $35
    jr nc, .next2

.next:
    inc c

.next2:
    inc hl
    dec b
    jr nz, .loop
    ld a, c
    pop bc
    or a, a
    ret

; A = battle slot: counts the skills numbered $40-$47 among the slot's 8 skills (every other byte of wD989 + 16 * slot): A = the count, Z set when there are none; BC kept (E-0094)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleSkills
CountSlotSkills40To47:: ; heuristic: follows a terminator; C0
Func_005_6F01:: ; address name
    push bc
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld bc, $0800

.loop:
    ld a, [hl+]
    cp a, $40
    jr c, .next
    cp a, $48
    jr nc, .next
    inc c

.next:
    inc hl
    dec b
    jr nz, .loop
    ld a, c
    or a, a
    pop bc
    ret

; A = how many of slot A's skills are $01-$15, $40-$67, $6A-$70, $8B-$93 or $AA (E-0125)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleSkills
CountSkillsInRanges6F21:: ; heuristic: follows a terminator; C0
Func_005_6F21:: ; address name
    push bc
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld bc, $0800

.loop:
    ld a, [hl+]
    or a, a
    jr z, .next2
    cp a, $FF
    jr z, .next2
    cp a, $16
    jr c, .next
    cp a, $40
    jr c, .next2
    cp a, $68
    jr c, .next
    cp a, $6A
    jr c, .next2
    cp a, $71
    jr c, .next
    cp a, $8B
    jr c, .next2
    cp a, $94
    jr c, .next
    cp a, $AA
    jr nz, .next2

.next:
    inc c

.next2:
    inc hl
    dec b
    jr nz, .loop
    ld a, c
    or a, a
    pop bc
    ret

; A = [HL + 4 * A + 3 * C], the offset computed in 8 bits; clobbers HL (the same 11 bytes appear in 2 banks)
; 16 call sites from 16 routines (e.g. AIScore_Sacrifice_GetBattleMaxHP_Bank05, AnyFoeOpenToWDA74Field3, AnyAllyWDA76Bits2To5NotAllSet, AnyFoeVulnerableByWDA77Bits23, ...)
ReadByteAtHLPlus4APlus3C_Bank05::
Func_005_6F60:: ; address name
    add a, a
    add a, c
    add a, a
    add a, c
    add_a_to_hl
    ld a, [hl]
    ret

; address loaded by AnyFoeNotFullyResistant, PassIfFoesAverageResistanceAtLeast2, FailIfAnyFoeFullyResistant, AIScore_Ramming_ReadSlotAIModeIndexed_Bank05_4024 and 4 more
AnyFoeNotFullyResistant_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_005_6F6B:: ; address name
    db $00, $02, $00, $01, $00, $00, $01, $03, $01, $02, $01, $01, $01, $00, $02, $03
    db $02, $02, $02, $01, $02, $00, $03, $03, $03, $02, $03, $01, $03, $00, $04, $03
    db $04, $02, $04, $01, $04, $00, $05, $03, $05, $02, $05, $01, $05, $00, $06, $03
    db $06, $02, $06, $01, $00, $03

; A = first slot, B = slot count, HL = a status field (wBattleStatus + n), E = mask: C = $FF when some present slot in the range has (HL + 9 * slot) & E clear; C = 0 when every slot is absent or has a masked bit set (E-0071)
; 21 call sites from 20 routines (e.g. AIScore_Curse_Conditions_AnySlotLacksStatusMask, AnyFoeLacksStatus2Bit3, AnyFoeLacksStatus5Bits67, AnyFoeLacksStatus2Mask22, ...)
AnySlotLacksStatusMask::
Func_005_6FA1:: ; address name
    ld c, a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    push hl
    ld a, c
    call AddAx9ToHL
    ld a, [hl]
    pop hl
    and a, e
    and a, a
    jr z, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; A = first slot, B = slot count, HL = a status field (wBattleStatus + n), E = mask: C = $FF when some present slot in the range has (HL + 9 * slot) & E non-zero, else C = 0 (the opposite test to AnySlotLacksStatusMask) (E-0100)
; 4 call sites from 4 routines (e.g. AIScore_Antidote_Conditions_AnySlotHasStatusMask, AIScore_NumbOff_Conditions_AnySlotHasStatusMask, AIScore_DeChaos_Conditions_AnySlotHasStatusMask, AIScore_CurseOff_Conditions_AnySlotHasStatusMask)
AnySlotHasStatusMask:: ; heuristic: follows a terminator; C0
Func_005_6FBD:: ; address name
    ld c, a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    push hl
    ld a, c
    call AddAx9ToHL
    ld a, [hl]
    pop hl
    and a, e
    and a, a
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

; E = family: C = 0 when one of the actor's three opposite slots is present and its species family (GetSlotSpeciesFamily) equals E; otherwise C = $FF (E-0092)
; 10 call sites from 10 routines (e.g. AIScore_SlimeBlow_Conditions_ToFoeOfFamilyEPresent, AIScore_DrakSlash_Conditions_ToFoeOfFamilyEPresent, AIScore_BeastCut_Conditions_ToFoeOfFamilyEPresent, AIScore_BirdBlow_Conditions_ToFoeOfFamilyEPresent, ...)
; reads: wBattleActor
FoeOfFamilyEPresent:: ; heuristic: follows a terminator; C0
Func_005_6FD9:: ; address name
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    push de
    call GetSlotSpeciesFamily
    pop de
    cp a, e
    jr z, .done

.next:
    inc c
    dec b
    jr nz, .loop
    jr .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $FF
    ret

; C = slot: compares its MP with 3/4 of its max MP: carry when below; BC kept (E-0120)
; 1 call site from 1 routine (e.g. AnyAllyMPAtMostThreeQuarters)
CompareMPWithThreeQuartersMax:: ; heuristic: follows a terminator; C0
Func_005_6FFD:: ; address name
    push bc
    ld a, c
    call GetBattleMaxMP_Bank05
    ld c, l
    ld b, h
    add hl, hl
    add hl, bc
    sra h
    rr l
    sra h
    rr l
    pop bc
    push bc
    push hl
    ld a, c
    call GetBattleMP_Bank05
    pop bc
    call CompareHLToBC
    pop bc
    ret

; HL = (HL / 5) * 4; BC and DE kept (E-0117)
; 1 call site from 1 routine (e.g. FailIfFoeHPAtMostFourFifthsAIDamageEstimates)
ScaleHLToFourFifths::
Func_005_701B:: ; address name
    push de
    push bc
    ld a, $05
    call DivideHLByA
    sla l
    rl h
    sla l
    rl h
    pop bc
    pop de
    ret

; A = wCFEF, Z set when it is zero (E-0114)
; 2 call sites from 2 routines (e.g. AIGateFoeStatus1Mask22, AIScore_FireAir_ReadSlotAIModeIndexed_Bank05)
; reads: wRecordBufferData
TestWCFEF::
Func_005_702D:: ; address name
    ld a, [wRecordBufferData + $1]
    or a, a
    ret

; reads the 2-bit field selected by Data_005_6F6B[A - 1] from the actor's wDA72 record into A, with NZ (E-0124)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wSlotResistances
ReadActorResistanceFieldForSkillA:: ; heuristic: follows a terminator; C0
Func_005_7032:: ; address name
    dec a
    ld hl, AnyFoeNotFullyResistant_Data
    add a, a
    add_a_to_hl
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, [wBattleActor]
    ld hl, wSlotResistances
    add a, a
    add a, c
    add a, a
    add a, c
    add a, d
    add_a_to_hl
    call Get2BitFieldEOfHL
    ld e, a
    ld a, $01
    or a, a
    ld a, e
    ret

; scans the slot's eight wBattleSkills entries: 0 when one is $16-$1A, $7C or $A1
; 1 call site from 1 routine (e.g. AIScore_Kamikaze_ReadSlotAIModeIndexed_Bank05_4024)
; points at: wBattleSkills
AIScore_Kamikaze_CheckSkills:: ; heuristic: follows a terminator; C0
Func_005_7058:: ; address name
    ld e, $00
    ld d, c
    ld hl, wBattleSkills
    add hl, de
    ld e, $08

.loop:
    ld a, [hl+]
    cp a, $FF
    jr z, .done
    cp a, $16
    jr c, .next
    cp a, $1B
    jr c, .return_0
    cp a, $7C
    jr z, .return_0
    cp a, $A1
    jr z, .return_0

.next:
    inc hl
    dec b
    jr nz, .loop

.done:
    ld a, $01
    or a, a
    ret

.return_0:
    xor a, a
    ret

; the conditions of AIScore_Skill00: calls AnyFoeLacksStatus3And4Bits, ResetAISkillScore in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_Skill00)
AIScore_Skill00_Conditions::
Func_005_7080:: ; address name
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; usable when the MP, status-1, side-flag and repeat checks pass, a foe lacks status 2 mask $22, status 5 bits 6-7 and status 2 bit 3, and Func_005_43F2 passes; otherwise resets wDA6E (E-0125)
; 2 call sites from 2 routines (e.g. AIScore_Blaze, AIScore_Firebal)
AIFireSkillUsable:: ; heuristic: follows a terminator; C0
Func_005_708C:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesStatus1Bit0Check
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesSideFlagBit3Check
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus2Mask22
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus2Bit3
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotFullyResistant
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Beat: calls ActorCanPayMPCost_Bank05, SkillPassesStatus1Bit0Check, SkillPassesSideFlagBit3Check in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_Beat)
AIScore_Beat_Conditions:: ; heuristic: follows a terminator; C0
Func_005_70C9:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesStatus1Bit0Check
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesSideFlagBit3Check
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus2Mask22
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotFullyResistant
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    farcall CheckBattleKindNot2Or3
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; only called from AIScore_Sacrifice (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Sacrifice)
AIScore_Sacrifice_ActorCanPayMPCost_Bank05:: ; heuristic: follows a terminator; C0
Func_005_7109:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesStatus1Bit0Check
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesSideFlagBit3Check
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus2Mask22
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotFullyResistant
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AIGateFoeStatus1Mask22
    ld a, c
    cp a, $01
    jr z, .call_check_side0_flag_not1
    and a, a
    jr z, .call_reset_ai_skill_score

.call_check_side0_flag_not1:
    call CheckSide0FlagNot1
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call CheckBattleKindNot2Or3
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; usable when the actor can pay the MP cost and the status-1, side-flag, repeat and Func_005_626B checks pass; otherwise resets wDA6E (E-0124)
; 2 call sites from 2 routines (e.g. AIScore_Heal, AIScore_HealUs)
AIHealUsable:: ; heuristic: follows a terminator; C0
Func_005_715F:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesStatus1Bit0Check
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesSideFlagBit3Check
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyAllyHPBelow6298
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; only called from AIScore_MPass (E-0047)
; 1 call site from 1 routine (e.g. AIScore_MPass)
AIScore_MPass_ActorLacksStatus4Bits67:: ; heuristic: follows a terminator; C0
Func_005_7187:: ; address name
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SetCToZero
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AIScore_MPass_Sub01_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Vivify: calls CheckSkillUsableStatusElseResetAISkillScore, AnyOwnSideSlotOutIs1 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_Vivify)
AIScore_Vivify_Conditions:: ; heuristic: follows a terminator; C0
Func_005_71AC:: ; address name
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AnyOwnSideSlotOutIs1
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Farewell: calls CheckSkillUsableStatusElseResetAISkillScore, AnyFoeLacksStatus0Bit6, AnyOwnSideSlotOutIs1 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_Farewell)
AIScore_Farewell_Conditions:: ; heuristic: follows a terminator; C0
Func_005_71BE:: ; address name
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyOwnSideSlotOutIs1
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call CheckSide0FlagNot1
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Antidote: calls CheckSkillUsableStatusElseResetAISkillScore, AIScore_Antidote_Sub01_AnySlotHasStatusMask in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_Antidote)
AIScore_Antidote_Conditions:: ; heuristic: follows a terminator; C0
Func_005_71DE:: ; address name
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AIScore_Antidote_Conditions_AnySlotHasStatusMask
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ld c, $FF
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_DeChaos: calls CheckSkillUsableStatusElseResetAISkillScore, AIScore_DeChaos_Sub01_AnySlotHasStatusMask in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_DeChaos)
AIScore_DeChaos_Conditions:: ; heuristic: follows a terminator; C0
Func_005_71F4:: ; address name
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AIScore_DeChaos_Conditions_AnySlotHasStatusMask
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ld c, $FF
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_NumbOff: calls CheckSkillUsableStatusElseResetAISkillScore, AIScore_NumbOff_Sub01_AnySlotHasStatusMask in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_NumbOff)
AIScore_NumbOff_Conditions:: ; heuristic: follows a terminator; C0
Func_005_720A:: ; address name
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AIScore_NumbOff_Conditions_AnySlotHasStatusMask
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ld c, $FF
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_CurseOff: calls CheckSkillUsableStatusElseResetAISkillScore, AIScore_CurseOff_Sub01_AnySlotHasStatusMask in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_CurseOff)
AIScore_CurseOff_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7220:: ; address name
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AIScore_CurseOff_Conditions_AnySlotHasStatusMask
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ld c, $FF
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_Upper: calls CheckSkillUsableStatusElseResetAISkillScore, AnyFoeNotBlocked, AIScore_Upper_Sub01_Sub01 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_Upper)
AIScore_Upper_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7236:: ; address name
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AIScore_Upper_Conditions_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Sap: calls AIUsableAndFoeLacksStatus2And5, AIScore_Sap_Sub01_Sub01 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_Sap)
AIScore_Sap_Conditions:: ; heuristic: follows a terminator; C0
Func_005_724F:: ; address name
    call AIUsableAndFoeLacksStatus2And5
    ld a, c
    and a, a
    ret z
    call AIScore_Sap_Conditions_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; usable only when the skill is usable and a foe lacks status 2 mask $22 and a foe lacks status 5 bits 6-7; otherwise resets wDA6E (E-0122)
; 6 call sites from 6 routines (e.g. AIScore_Sap_Conditions, AIScore_Slow_Conditions, AIScore_Surround_Conditions, AIScore_Sleep_Conditions, ...)
AIUsableAndFoeLacksStatus2And5::
Func_005_7261:: ; address name
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AnyFoeLacksStatus2Mask22
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Speed: calls CheckSkillUsableStatusElseResetAISkillScore, AnyFoeNotBlocked, AIScore_Speed_Sub01_Sub01 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_Speed)
AIScore_Speed_Conditions:: ; heuristic: follows a terminator; C0
Func_005_727A:: ; address name
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AIScore_Speed_Conditions_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Slow: calls AIUsableAndFoeLacksStatus2And5, AnyFoeNotBlocked, AIScore_Slow_Sub01_Sub01 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_Slow)
AIScore_Slow_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7293:: ; address name
    call AIUsableAndFoeLacksStatus2And5
    ld a, c
    and a, a
    ret z
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AIScore_Slow_Conditions_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; only called from AIScore_TwinHits (E-0047)
; 1 call site from 1 routine (e.g. AIScore_TwinHits)
AIScore_TwinHits_CheckSkillUsableStatusElseResetAISkillScore:: ; heuristic: follows a terminator; C0
Func_005_72AC:: ; address name
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AnyAllyLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Surround: calls AIUsableAndFoeLacksStatus2And5, AnyFoeLacksStatus5Bits01And1Bit1, AnyFoeNotBlocked in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_Surround)
AIScore_Surround_Conditions:: ; heuristic: follows a terminator; C0
Func_005_72BE:: ; address name
    call AIUsableAndFoeLacksStatus2And5
    ld a, c
    and a, a
    ret z
    call AnyFoeLacksStatus5Bits01And1Bit1
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeOpenToWDA73Field0
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Sleep: calls AIUsableAndFoeLacksStatus2And5, AnyFoeLacksStatus0MaskCC, AnyFoeOpenToWDA74Field3 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_Sleep)
AIScore_Sleep_Conditions:: ; heuristic: follows a terminator; C0
Func_005_72DE:: ; address name
    call AIUsableAndFoeLacksStatus2And5
    ld a, c
    and a, a
    ret z
    call AnyFoeLacksStatus0MaskCC
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeOpenToWDA74Field3
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_TakeMagic: calls CheckSkillUsableStatusElseResetAISkillScore, AIScore_TakeMagic_Sub01_Sub01 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_TakeMagic)
AIScore_TakeMagic_Conditions:: ; heuristic: follows a terminator; C0
Func_005_72F7:: ; address name
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AIScore_TakeMagic_Conditions_ReadSlotAIModeIndexed_Bank05
    ld a, c
    cp a, $01
    jr z, .call_any_foe_lacks_status0_bit6
    and a, a
    jr z, .call_reset_ai_skill_score

.call_any_foe_lacks_status0_bit6:
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AIScore_TakeMagic_Conditions_AddAx9ToHL
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_RobMagic: calls CheckSkillUsableStatusElseResetAISkillScore, AnyFoeHasMPReadsWrongOffset, AnyFoeWithMPOpenToWDA74Field1 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_RobMagic)
AIScore_RobMagic_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7322:: ; address name
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AnyFoeHasMPReadsWrongOffset
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeWithMPOpenToWDA74Field1
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    farcall ActorMPBelowThreeQuarters
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_StopSpell: calls AIUsableAndFoeLacksStatus2And5, AnyFoeLacksStatus0Bit6, AnyActiveFoeHasSkillFlag40 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_StopSpell)
AIScore_StopSpell_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7345:: ; address name
    call AIUsableAndFoeLacksStatus2And5
    ld a, c
    and a, a
    ret z
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyActiveFoeHasSkillFlag40
    ld a, c
    cp a, $01
    jr z, .call_any_foe_lacks_status1_bit0
    and a, a
    jr z, .call_reset_ai_skill_score

.call_any_foe_lacks_status1_bit0:
    call AnyFoeLacksStatus1Bit0
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AIScore_StopSpell_Conditions_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; usable when AIUsableAndFoeLacksStatus2And5, a foe lacks status 0 bit 6, Func_005_43F2, a foe lacks status 0 bit 4 and AnyFoeVulnerableByWDA75Bits67 pass; otherwise resets wDA6E (E-0124)
; 2 call sites from 2 routines (e.g. AIScore_PanicAll, AIScore_PanicAll_6473)
AIPanicAllUsable:: ; heuristic: follows a terminator; C0
Func_005_7370:: ; address name
    call AIUsableAndFoeLacksStatus2And5
    ld a, c
    and a, a
    ret z
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotFullyResistant
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus0Bit4
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeVulnerableByWDA75Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; usable when the skill is usable and the foe, block, actor-status, lone-foe HP, wD2CC and ally checks pass; otherwise resets wDA6E (E-0125)
; 2 call sites from 2 routines (e.g. AIScore_Ironize, AIScore_Ironize_648D)
AIIronizeUsable:: ; heuristic: follows a terminator; C0
Func_005_7397:: ; address name
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call CheckAIFlagSetModeGated
    ld a, c
    cp a, $01
    jr z, .call_ally_check_side0_flag_and_other_slots
    and a, a
    jr z, .call_reset_ai_skill_score

.call_ally_check_side0_flag_and_other_slots:
    call AllyCheckSide0FlagAndOtherSlots
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_MagicBack: calls CheckSkillUsableStatusElseResetAISkillScore, AnyFoeLacksStatus0Bit6, AnyActiveFoeHasSkillFlag40 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_MagicBack)
AIScore_MagicBack_Conditions:: ; heuristic: follows a terminator; C0
Func_005_73D7:: ; address name
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyActiveFoeHasSkillFlag40
    ld a, c
    cp a, $01
    jr z, .call_any_foe_not_blocked
    and a, a
    jr z, .call_reset_ai_skill_score

.call_any_foe_not_blocked:
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AIScore_MagicBack_Conditions_AddAx9ToHL
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call CheckWD044RuleBit5
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Barrier: calls CheckSkillUsableStatusElseResetAISkillScore, AnyFoeLacksStatus0Bit6, AnyFoeHasSkillFlag10 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_Barrier)
AIScore_Barrier_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7410:: ; address name
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeHasSkillFlag10
    ld a, c
    cp a, $01
    jr z, .call_any_foe_lacks_status1_bit7
    and a, a
    jr z, .call_reset_ai_skill_score

.call_any_foe_lacks_status1_bit7:
    call AnyFoeLacksStatus1Bit7
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyAllyLacksStatus2Bit2
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_MagicWall: calls CheckSkillUsableStatusElseResetAISkillScore, AnyFoeLacksStatus0Bit6, AnyActiveFoeHasSkillFlag40 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_MagicWall)
AIScore_MagicWall_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7449:: ; address name
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyActiveFoeHasSkillFlag40
    ld a, c
    cp a, $01
    jr z, .call_any_foe_lacks_status1_bit0
    and a, a
    jr z, .call_reset_ai_skill_score

.call_any_foe_lacks_status1_bit0:
    call AnyFoeLacksStatus1Bit0
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AIScore_MagicWall_Conditions_AnySlotLacksStatusMask
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; usable only when the skill is usable and the actor lacks status 4 bits 6-7; otherwise resets wDA6E (E-0122)
; 2 call sites from 2 routines (e.g. AIScore_Transform, AIScore_BeDragon)
AIUsableAndActorLacksStatus4Bits67:: ; heuristic: follows a terminator; C0
Func_005_7482:: ; address name
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; runs ActorCanPayMPCost_Bank05, SkillPassesStatus1Bit0Check, SkillPassesSideFlagBit3Check and SkillPassesRepeatCheck in turn; at the first that returns C = 0 it calls ResetAISkillScore (E-0071)
; 18 call sites from 18 routines (e.g. AIScore_Vivify_Conditions, AIScore_Farewell_Conditions, AIScore_Antidote_Conditions, AIScore_DeChaos_Conditions, ...)
CheckSkillUsableStatusElseResetAISkillScore::
Func_005_7494:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesStatus1Bit0Check
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesSideFlagBit3Check
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; only called from AIScore_MegaMagic (E-0047)
; 1 call site from 1 routine (e.g. AIScore_MegaMagic)
AIScore_MegaMagic_AIAttackSkillUsable_74D1:: ; heuristic: follows a terminator; C0
Func_005_74B5:: ; address name
    call AIAttackSkillUsable_74D1
    ld a, c
    and a, a
    ret z
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    farcall CheckBattleKindAtLeast2OrLinkModeSet
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; usable when the actor can pay the MP cost, the repeat check passes, a foe lacks status 5 bits 6-7 and status 2 bit 3, and Func_005_43F2 passes; otherwise resets wDA6E (E-0124)
; 6 call sites from 6 routines (e.g. AIScore_MegaMagic_AIAttackSkillUsable_74D1, AIScore_FireAir_AIAttackSkillUsable_74D1, AIFunc74D1AndFoeLacksStatus3And4, AIScore_BigBang, ...)
AIAttackSkillUsable_74D1::
Func_005_74D1:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus2Bit3
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotFullyResistant
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; only called from AIScore_FireAir (E-0047)
; 1 call site from 1 routine (e.g. AIScore_FireAir)
AIScore_FireAir_AIAttackSkillUsable_74D1:: ; heuristic: follows a terminator; C0
Func_005_74F9:: ; address name
    call AIAttackSkillUsable_74D1
    ld a, c
    and a, a
    ret z
    call PassUnlessWCFF3Bit4AndActorStatusBit7
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AIScore_FireAir_Sub02_AnySlotLacksStatusMask
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; usable only when Func_005_74D1 passes and a foe lacks the status 3 and 4 bits; otherwise resets wDA6E (E-0122)
; 6 call sites from 6 routines (e.g. AIScore_RockThrow, AIScore_Watershot, AIScore_Tidalwave, AIScore_CallHelp, ...)
AIFunc74D1AndFoeLacksStatus3And4:: ; heuristic: follows a terminator; C0
Func_005_7512:: ; address name
    call AIAttackSkillUsable_74D1
    ld a, c
    and a, a
    ret z
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_SlimeBlow: calls CheckSkillUsableElseResetAISkillScore, AIScore_SlimeBlow_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_SlimeBlow)
AIScore_SlimeBlow_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7524:: ; address name
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AIScore_SlimeBlow_Conditions_ToFoeOfFamilyEPresent
    ld a, c
    and a, a
    jr nz, .call_reset_ai_skill_score
    ld c, $FF
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_DrakSlash: calls CheckSkillUsableElseResetAISkillScore, AIScore_DrakSlash_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_DrakSlash)
AIScore_DrakSlash_Conditions:: ; heuristic: follows a terminator; C0
Func_005_753A:: ; address name
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AIScore_DrakSlash_Conditions_ToFoeOfFamilyEPresent
    ld a, c
    and a, a
    jr nz, .call_reset_ai_skill_score
    ld c, $FF
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_BeastCut: calls CheckSkillUsableElseResetAISkillScore, AIScore_BeastCut_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_BeastCut)
AIScore_BeastCut_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7550:: ; address name
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AIScore_BeastCut_Conditions_ToFoeOfFamilyEPresent
    ld a, c
    and a, a
    jr nz, .call_reset_ai_skill_score
    ld c, $FF
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_BirdBlow: calls CheckSkillUsableElseResetAISkillScore, AIScore_BirdBlow_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_BirdBlow)
AIScore_BirdBlow_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7566:: ; address name
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AIScore_BirdBlow_Conditions_ToFoeOfFamilyEPresent
    ld a, c
    and a, a
    jr nz, .call_reset_ai_skill_score
    ld c, $FF
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_BugBlow: calls CheckSkillUsableElseResetAISkillScore, AIScore_BugBlow_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_BugBlow)
AIScore_BugBlow_Conditions:: ; heuristic: follows a terminator; C0
Func_005_757C:: ; address name
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AIScore_BugBlow_Conditions_ToFoeOfFamilyEPresent
    ld a, c
    and a, a
    jr nz, .call_reset_ai_skill_score
    ld c, $FF
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_Shears: calls CheckSkillUsableElseResetAISkillScore, AIScore_Shears_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_Shears)
AIScore_Shears_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7592:: ; address name
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AIScore_Shears_Conditions_ToFoeOfFamilyEPresent
    ld a, c
    and a, a
    jr nz, .call_reset_ai_skill_score
    ld c, $FF
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_DevilCut: calls CheckSkillUsableElseResetAISkillScore, AIScore_DevilCut_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_DevilCut)
AIScore_DevilCut_Conditions:: ; heuristic: follows a terminator; C0
Func_005_75A8:: ; address name
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AIScore_DevilCut_Conditions_ToFoeOfFamilyEPresent
    ld a, c
    and a, a
    jr nz, .call_reset_ai_skill_score
    ld c, $FF
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_ZombieCut: calls CheckSkillUsableElseResetAISkillScore, AIScore_ZombieCut_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_ZombieCut)
AIScore_ZombieCut_Conditions:: ; heuristic: follows a terminator; C0
Func_005_75BE:: ; address name
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AIScore_ZombieCut_Conditions_ToFoeOfFamilyEPresent
    ld a, c
    and a, a
    jr nz, .call_reset_ai_skill_score
    ld c, $FF
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_CleanCut: calls CheckSkillUsableElseResetAISkillScore, AIScore_CleanCut_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_CleanCut)
AIScore_CleanCut_Conditions:: ; heuristic: follows a terminator; C0
Func_005_75D4:: ; address name
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AIScore_CleanCut_Conditions_ToFoeOfFamilyEPresent
    ld a, c
    and a, a
    jr nz, .call_reset_ai_skill_score
    ld c, $FF
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_AquaCut: calls CheckSkillUsableElseResetAISkillScore, AIScore_AquaCut_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_AquaCut)
AIScore_AquaCut_Conditions:: ; heuristic: follows a terminator; C0
Func_005_75EA:: ; address name
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AIScore_AquaCut_Conditions_ToFoeOfFamilyEPresent
    ld a, c
    and a, a
    jr nz, .call_reset_ai_skill_score
    ld c, $FF
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_MetalCut: calls CheckSkillUsableElseResetAISkillScore, AIScore_MetalCut_Sub01_Sub01 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_MetalCut)
AIScore_MetalCut_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7600:: ; address name
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AIScore_MetalCut_Conditions_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a, a
    jr nz, .call_reset_ai_skill_score
    ld c, $FF
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; runs ActorCanPayMPCost_Bank05, SkillPassesRepeatCheck, AnyFoeLacksStatus5Bits67, AnyFoeLacksStatus2Bit3 and AnyFoeLacksStatus3And4Bits in turn; at the first that returns C = 0 it calls ResetAISkillScore; returns with nothing changed when all pass (E-0071)
; 19 call sites from 19 routines (e.g. AIScore_SlimeBlow_Conditions, AIScore_PoisonHit_Conditions, AIScore_DrakSlash_Conditions, AIParalyzeUsable, ...)
CheckSkillUsableElseResetAISkillScore::
Func_005_7616:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus2Bit3
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_PoisonHit: calls CheckSkillUsableElseResetAISkillScore, AnyFoeLacksStatus0Bits01, AnyFoeOpenToWDA76Field0 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_PoisonHit)
AIScore_PoisonHit_Conditions:: ; heuristic: follows a terminator; C0
Func_005_763E:: ; address name
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AnyFoeLacksStatus0Bits01
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeOpenToWDA76Field0
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ld c, $FF
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_Paralyze: calls AIParalyzeUsable, AnyFoeOpenToWDA77Field3 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_Paralyze)
AIScore_Paralyze_Conditions:: ; heuristic: follows a terminator; C0
Func_005_765B:: ; address name
    call AIParalyzeUsable
    ld a, c
    and a, a
    ret z
    call AnyFoeOpenToWDA77Field3
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ld c, $FF
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_NapAttack: calls AIParalyzeUsable, AnyFoeOpenToWDA74Field3 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_NapAttack)
AIScore_NapAttack_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7671:: ; address name
    call AIParalyzeUsable
    ld a, c
    and a, a
    ret z
    call AnyFoeOpenToWDA74Field3
    ld a, c
    jr z, .call_reset_ai_skill_score
    ld c, $FF
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; C = $FF when the skill is usable, a foe lacks status 0 mask $CC and a foe is not blocked; otherwise resets wDA6E and C = $00 (E-0124)
; 2 call sites from 2 routines (e.g. AIScore_Paralyze_Conditions, AIScore_NapAttack_Conditions)
AIParalyzeUsable::
Func_005_7686:: ; address name
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AnyFoeLacksStatus0MaskCC
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ld c, $FF
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_SquallHit: calls CheckSkillUsableElseResetAISkillScore, AIScore_SquallHit_Sub01_Sub01, FastestFoeAGLAbove31PercentOfActor in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_SquallHit)
AIScore_SquallHit_Conditions:: ; heuristic: follows a terminator; C0
Func_005_76A3:: ; address name
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AIScore_SquallHit_Conditions_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call FastestFoeAGLAbove31PercentOfActor
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call PassIfBattleTurnNonZero
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call CheckAIFlagSetModeGated
    ld a, c
    cp a, $01
    jr z, .return
    and a, a
    jr z, .call_reset_ai_skill_score

.return:
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; only called from AIScore_BiAttack (E-0047)
; 1 call site from 1 routine (e.g. AIScore_BiAttack)
AIScore_BiAttack_CheckSkillUsableElseResetAISkillScore:: ; heuristic: follows a terminator; C0
Func_005_76CE:: ; address name
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AIScore_BiAttack_Sub02_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_RainSlash: calls CheckSkillUsableElseResetAISkillScore, AtLeastTwoFoesPresent in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_RainSlash)
AIScore_RainSlash_Conditions:: ; heuristic: follows a terminator; C0
Func_005_76E2:: ; address name
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AtLeastTwoFoesPresent
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ld c, $FF
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_MultiCut: calls AIAttackSkillUsable_770A, AnyFoeNotFullyResistant in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_MultiCut)
AIScore_MultiCut_Conditions:: ; heuristic: follows a terminator; C0
Func_005_76F8:: ; address name
    call AIAttackSkillUsable_770A
    ld a, c
    and a, a
    ret z
    call AnyFoeNotFullyResistant
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; usable when the actor can pay the MP cost, the repeat check passes and a foe lacks status 5 bits 6-7 and status 2 bit 3; otherwise resets wDA6E (E-0124)
; 3 call sites from 3 routines (e.g. AIScore_MultiCut_Conditions, AIScore_HighJump_Conditions, AIFunc770AAndPassUnlessWCFF3Bit4)
AIAttackSkillUsable_770A::
Func_005_770A:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus2Bit3
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_ChargeUp: calls ActorLacksStatus4Bits67, CheckLoneFoeHPNotBelowAIDamageEstimates, ActorLacksStatus1Bits23And4Bits01 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_ChargeUp)
AIScore_ChargeUp_Conditions:: ; heuristic: follows a terminator; C0
Func_005_772B:: ; address name
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_PsycheUp: calls ActorCanPayMPCost_Bank05, AnyFoeLacksStatus5Bits67, AnyFoeLacksStatus2Bit3 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_PsycheUp)
AIScore_PsycheUp_Conditions:: ; heuristic: follows a terminator; C0
Func_005_774F:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus2Bit3
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_HighJump: calls AIAttackSkillUsable_770A, ActorLacksStatus4Bits67, ResetAISkillScore in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_HighJump)
AIScore_HighJump_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7777:: ; address name
    call AIAttackSkillUsable_770A
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_TwinSlash: calls AIAttackSkillUsable_779F, AnyFoeHasDEFAtLeast2, AllOtherAlliesHaveStatus0Bit6 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_TwinSlash)
AIScore_TwinSlash_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7786:: ; address name
    call AIAttackSkillUsable_779F
    ld a, c
    and a, a
    ret z
    call AnyFoeHasDEFAtLeast2
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; usable when the actor can pay the MP cost, the repeat check passes, a foe lacks status 5 bits 6-7 and the status 3/4 bits, and the actor lacks status 4 bits 6-7; otherwise resets wDA6E (E-0124)
; 3 call sites from 3 routines (e.g. AIScore_TwinSlash_Conditions, AIFunc779FAnd43F2AndActorHPNotOne, AIScore_Berserker)
AIAttackSkillUsable_779F::
Func_005_779F:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; usable only when Func_005_779F and Func_005_43F2 pass and the actor's HP is not 1; otherwise resets wDA6E (E-0122)
; 2 call sites from 2 routines (e.g. AIScore_Kamikaze_AIFunc779FAnd43F2AndActorHPNotOne, AIScore_Ramming)
AIFunc779FAnd43F2AndActorHPNotOne:: ; heuristic: follows a terminator; C0
Func_005_77C7:: ; address name
    call AIAttackSkillUsable_779F
    ld a, c
    and a, a
    ret z
    call AnyFoeNotFullyResistant
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call ActorHPIsNotOne
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; only called from AIScore_Kamikaze (E-0047)
; 1 call site from 1 routine (e.g. AIScore_Kamikaze)
AIScore_Kamikaze_AIFunc779FAnd43F2AndActorHPNotOne:: ; heuristic: follows a terminator; C0
Func_005_77E0:: ; address name
    call AIFunc779FAnd43F2AndActorHPNotOne
    ld a, c
    and a, a
    ret z
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_SleepAir: calls AIFunc770AAndPassUnlessWCFF3Bit4, AnyFoeLacksStatus0MaskCC, AnyFoeOpenToWDA74Field3 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_SleepAir)
AIScore_SleepAir_Conditions:: ; heuristic: follows a terminator; C0
Func_005_77F9:: ; address name
    call AIFunc770AAndPassUnlessWCFF3Bit4
    ld a, c
    and a, a
    ret z
    call AnyFoeLacksStatus0MaskCC
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeOpenToWDA74Field3
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; usable only when Func_005_770A and PassUnlessWCFF3Bit4AndActorStatusBit7 pass; otherwise resets wDA6E (E-0122)
; 4 call sites from 4 routines (e.g. AIScore_SleepAir_Conditions, AIScore_PalsyAir_Conditions, AIScore_PoisonGas_Conditions, AIScore_PoisonAir_Conditions)
AIFunc770AAndPassUnlessWCFF3Bit4::
Func_005_7812:: ; address name
    call AIAttackSkillUsable_770A
    ld a, c
    and a, a
    ret z
    call PassUnlessWCFF3Bit4AndActorStatusBit7
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_PalsyAir: calls AIFunc770AAndPassUnlessWCFF3Bit4, AnyFoeLacksStatus0Bit6, AnyFoeOpenToWDA77Field3 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_PalsyAir)
AIScore_PalsyAir_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7824:: ; address name
    call AIFunc770AAndPassUnlessWCFF3Bit4
    ld a, c
    and a, a
    ret z
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeOpenToWDA77Field3
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    farcall CheckBattleKindNot2Or3
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_PoisonGas: calls AIFunc770AAndPassUnlessWCFF3Bit4, AnyFoeLacksStatus0Bits01, AnyFoeOpenToWDA76Field0 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_PoisonGas)
AIScore_PoisonGas_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7847:: ; address name
    call AIFunc770AAndPassUnlessWCFF3Bit4
    ld a, c
    and a, a
    ret z
    call AnyFoeLacksStatus0Bits01
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeOpenToWDA76Field0
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_PoisonAir: calls AIFunc770AAndPassUnlessWCFF3Bit4, AIScore_PoisonAir_Sub01_AnySlotLacksStatusMask, AnyFoeOpenToWDA76Field0 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_PoisonAir)
AIScore_PoisonAir_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7860:: ; address name
    call AIFunc770AAndPassUnlessWCFF3Bit4
    ld a, c
    and a, a
    ret z
    call AIScore_PoisonAir_Conditions_AnySlotLacksStatusMask
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeOpenToWDA76Field0
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Curse: calls ActorCanPayMPCost_Bank05, PassUnlessWCFF3Bit4AndActorStatusBit7, SkillPassesRepeatCheck in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_Curse)
AIScore_Curse_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7879:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call PassUnlessWCFF3Bit4AndActorStatusBit7
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AIScore_Curse_Conditions_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AIScore_Curse_Conditions_AnySlotLacksStatusMask
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_OddDance: calls AIDanceUsable, AnyFoeHasMPReadsWrongOffset, AnyFoeWithMPOpenToWDA74Field1 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_OddDance)
AIScore_OddDance_Conditions:: ; heuristic: follows a terminator; C0
Func_005_78A8:: ; address name
    call AIDanceUsable
    ld a, c
    and a, a
    ret z
    call AnyFoeHasMPReadsWrongOffset
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeWithMPOpenToWDA74Field1
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call ActorMPBelowThreeQuarters
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ld c, $FF
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_PaniDance: calls AIDanceUsable, AnyFoeNotFullyResistant, AnyFoeLacksStatus0Bit4 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_PaniDance)
AIScore_PaniDance_Conditions:: ; heuristic: follows a terminator; C0
Func_005_78CC:: ; address name
    call AIDanceUsable
    ld a, c
    and a, a
    ret z
    call AnyFoeNotFullyResistant
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus0Bit4
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; usable when the actor can pay the MP cost, PassUnlessWCFF3Bit5AndActorStatusBit6 and the repeat check pass and a foe lacks status 5 bits 6-7; otherwise resets wDA6E (E-0124)
; 4 call sites from 4 routines (e.g. AIScore_OddDance_Conditions, AIScore_KODance_Conditions, AIScore_PaniDance_Conditions, AIScore_LureDance_Conditions)
AIDanceUsable::
Func_005_78EC:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call PassUnlessWCFF3Bit5AndActorStatusBit6
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_KODance: calls AIDanceUsable, AnyFoeNotFullyResistant in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_KODance)
AIScore_KODance_Conditions:: ; heuristic: follows a terminator; C0
Func_005_790D:: ; address name
    call AIDanceUsable
    ld a, c
    and a, a
    ret z
    call AnyFoeNotFullyResistant
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_LureDance: calls AIDanceUsable, AnyFoeLacksStatus3And4Bits, AnyFoeNotBlocked in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_LureDance)
AIScore_LureDance_Conditions:: ; heuristic: follows a terminator; C0
Func_005_791F:: ; address name
    call AIDanceUsable
    ld a, c
    and a, a
    ret z
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeVulnerableByWDA77Bits23
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AllyCheckSide0FlagAndOtherSlots
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_LifeDance: calls ActorCanPayMPCost_Bank05, PassUnlessWCFF3Bit5AndActorStatusBit6, SkillPassesRepeatCheck in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_LifeDance)
AIScore_LifeDance_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7946:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call PassUnlessWCFF3Bit5AndActorStatusBit6
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyOwnSideSlotOutIs1
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call CheckSide0FlagNot1
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Hustle: calls ActorCanPayMPCost_Bank05, PassUnlessWCFF3Bit5AndActorStatusBit6, SkillPassesRepeatCheck in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_Hustle)
AIScore_Hustle_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7975:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call PassUnlessWCFF3Bit5AndActorStatusBit6
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyAllyHPBelow6298
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_SideStep: calls ActorCanPayMPCost_Bank05, PassUnlessWCFF3Bit5AndActorStatusBit6, SkillPassesRepeatCheck in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_SideStep)
AIScore_SideStep_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7996:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call PassUnlessWCFF3Bit5AndActorStatusBit6
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AIScore_SideStep_Conditions_AddAx9ToHL
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_SandStorm: calls CheckSkillUsableElseResetAISkillScore, AnyFoeLacksStatus5Bits01And1Bit1, AnyFoeNotBlocked in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_SandStorm)
AIScore_SandStorm_Conditions:: ; heuristic: follows a terminator; C0
Func_005_79C5:: ; address name
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a, a
    ret z
    call AnyFoeLacksStatus5Bits01And1Bit1
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeOpenToWDA73Field0
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Radiant: calls ActorCanPayMPCost_Bank05, AnyFoeLacksStatus5Bits67, AnyFoeLacksStatus5Bits01And1Bit1 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_Radiant)
AIScore_Radiant_Conditions:: ; heuristic: follows a terminator; C0
Func_005_79E5:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits01And1Bit1
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeOpenToWDA73Field0
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_EerieLite: calls ActorCanPayMPCost_Bank05, AnyFoeNotFullyResistant, AIScore_EerieLite_Sub01_Sub01 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_EerieLite)
AIScore_EerieLite_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7A0D:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotFullyResistant
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AIScore_EerieLite_Conditions_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Surge: calls ActorCanPayMPCost_Bank05, AIScore_Surge_Sub01_Sub01 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_Surge)
AIScore_Surge_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7A27:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AIScore_Surge_Conditions_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ld c, $FF
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_UltraDown: calls ActorCanPayMPCost_Bank05, AIScore_UltraDown_Sub01_Sub01 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_UltraDown)
AIScore_UltraDown_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7A3E:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AIScore_UltraDown_Conditions_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ld c, $FF
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_DeMagic: calls ActorCanPayMPCost_Bank05, AIScore_DeMagic_Sub01_Sub01 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_DeMagic)
AIScore_DeMagic_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7A55:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AIScore_DeMagic_Conditions_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ld c, $FF
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

; the conditions of AIScore_ThickFog: calls ActorCanPayMPCost_Bank05, SkillPassesSideFlagBit3Check, AnyActiveFoeHasSkillFlag40 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_ThickFog)
AIScore_ThickFog_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7A6C:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesSideFlagBit3Check
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyActiveFoeHasSkillFlag40
    ld a, c
    cp a, $01
    jr z, .call_any_foe_has_mp_reads_wrong_offset
    and a, a
    jr z, .call_reset_ai_skill_score

.call_any_foe_has_mp_reads_wrong_offset:
    call AnyFoeHasMPReadsWrongOffset
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_TatsuCall: calls ActorCanPayMPCost_Bank05, AIScore_TatsuCall_Sub01_Sub01 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_TatsuCall)
AIScore_TatsuCall_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7A91:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AIScore_TatsuCall_Conditions_ReadBattleActor
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_SuckAir: calls PassUnlessWCFF3Bit4AndActorStatusBit7, ActorLacksStatus4Bits67, AIScore_SuckAir_Sub01_Sub01 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_SuckAir)
AIScore_SuckAir_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7AA4:: ; address name
    call PassUnlessWCFF3Bit4AndActorStatusBit7
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AIScore_SuckAir_Conditions_ReadBattleActor
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call ActorLacksStatus4Bits45
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AIScore_SuckAir_Conditions_SlotHasSkillWithFlagD
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Focus: calls ActorLacksStatus4Bits67, ResetAISkillScore in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_Focus)
AIScore_Focus_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7ACC:: ; address name
    call ActorLacksStatus4Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; usable when the MP and repeat checks pass, a foe lacks status 5 bits 6-7 and the 3/4 bits, has clear status 3, is vulnerable by wDA77 bits 2-3, and AllyCheckSide0FlagAndOtherSlots passes; otherwise resets wDA6E (E-0125)
; 3 call sites from 3 routines (e.g. AIScore_LegSweep_Conditions, AIScore_LushLicks, AIScore_Ahhh)
AILickSkillUsable_7AD8:: ; heuristic: follows a terminator; C0
Func_005_7AD8:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeHasClearStatus3
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeVulnerableByWDA77Bits23
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    farcall AllyCheckSide0FlagAndOtherSlots
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; usable when the actor can pay the MP cost, the repeat check passes, a foe lacks status 5 bits 6-7 and the status 3/4 bits, a foe has clear status 3, and AnyFoeVulnerableByWDA77Bits23 passes; otherwise resets wDA6E (E-0124)
; 2 call sites from 2 routines (e.g. AIScore_SickLick, AIScore_Ahhh_6401)
AIStatusLickUsable:: ; heuristic: follows a terminator; C0
Func_005_7B11:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeHasClearStatus3
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeVulnerableByWDA77Bits23
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_LegSweep: calls AILickSkillUsable_7AD8, AIScore_LegSweep_Sub01_Sub01 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_LegSweep)
AIScore_LegSweep_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7B40:: ; address name
    call AILickSkillUsable_7AD8
    ld a, c
    and a, a
    ret z
    call AIScore_LegSweep_Conditions_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    farcall AllyCheckSide0FlagAndOtherSlots
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Geyser: calls ActorCanPayMPCost_Bank05, AnyFoeLacksStatus5Bits67, AnyFoeLacksStatus3And4Bits in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_Geyser)
AIScore_Geyser_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7B5C:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotFullyResistant
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeHasClearStatus3
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_DanceShut: calls ActorCanPayMPCost_Bank05, PassUnlessWCFF3Bit5AndActorStatusBit6, AnyFoeLacksStatus5Bits67 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_DanceShut)
AIScore_DanceShut_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7B84:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call PassUnlessWCFF3Bit5AndActorStatusBit6
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AIScore_DanceShut_Conditions_ReadSlotAIModeIndexed_Bank05
    ld a, c
    cp a, $01
    jr z, .call_ai_score_dance_shut_conditions_any_slot
    and a, a
    jr z, .call_reset_ai_skill_score

.call_ai_score_dance_shut_conditions_any_slot:
    call AIScore_DanceShut_Conditions_AnySlotLacksStatusMask
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AIScore_DanceShut_Conditions_CarryUnlessBattleSlotOutSlotEmpty
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_MouthShut: calls ActorCanPayMPCost_Bank05, SkillPassesRepeatCheck, AnyFoeLacksStatus5Bits67 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_MouthShut)
AIScore_MouthShut_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7BBE:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus1Bit7
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeHasSkillWithFlagD
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_StrongD: calls AllyCheckSide0FlagAndOtherSlots, AIBuffSkillUsable_7C24 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_StrongD)
; writes: wAISkillScore, wAISkillScore2
AIScore_StrongD_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7BE6:: ; address name
    call AllyCheckSide0FlagAndOtherSlots
    ld a, c
    and a, a
    jp z, ResetAISkillScore

; the conditions of AIScore_Dodge_Sub01: calls AIBuffSkillUsable_7C24, CheckLoneFoeHPNotBelowAIDamageEstimates, CheckAIFlagSetModeGated in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_Dodge_Conditions)
AIScore_Dodge_Sub01_Conditions::
Func_005_7BEE:: ; address name
    call AIBuffSkillUsable_7C24
    ld a, c
    and a, a
    ret z
    call CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call CheckAIFlagSetModeGated
    ld a, c
    cp a, $01
    jr z, .call_pass_if_battle_turn_non_zero
    and a, a
    jr z, .call_reset_ai_skill_score

.call_pass_if_battle_turn_non_zero:
    call PassIfBattleTurnNonZero
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Dodge: calls AIScore_Dodge_Sub01_Sub01, AnyFoeLacksStatus5Bits01And1Bit1 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_Dodge)
AIScore_Dodge_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7C12:: ; address name
    call AIScore_Dodge_Sub01_Conditions
    ld a, c
    and a, a
    ret z
    call AnyFoeLacksStatus5Bits01And1Bit1
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; usable when the actor can pay the MP cost, the repeat check passes and a foe lacks status 5 bits 6-7 and status 0 bit 6; otherwise resets wDA6E (E-0124)
; 4 call sites from 4 routines (e.g. AIScore_Dodge_Sub01_Conditions, AIGuardSkillUsable_7C45, AIScore_TailWind_Conditions, AIScore_StormWind_Conditions)
AIBuffSkillUsable_7C24::
Func_005_7C24:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; AIBuffSkillUsable_7C24, a foe not blocked, the gated wD2CC check and PassIfBattleTurnNonZero; otherwise resets wDA6E (E-0124)
; 2 call sites from 2 routines (e.g. AIScore_Cover_Conditions, AIScore_BladeD)
AIGuardSkillUsable_7C45:: ; heuristic: follows a terminator; C0
Func_005_7C45:: ; address name
    call AIBuffSkillUsable_7C24
    ld a, c
    and a, a
    ret z
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call CheckAIFlagSetModeGated
    ld a, c
    cp a, $01
    jr z, .call_pass_if_battle_turn_non_zero
    and a, a
    jr z, .call_reset_ai_skill_score

.call_pass_if_battle_turn_non_zero:
    call PassIfBattleTurnNonZero
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Cover: calls AIGuardSkillUsable_7C45, AllyCheckSide0FlagAndOtherSlots, ActorHPIsNotOne in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_Cover)
AIScore_Cover_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7C69:: ; address name
    call AIGuardSkillUsable_7C45
    ld a, c
    and a, a
    ret z
    call AllyCheckSide0FlagAndOtherSlots
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call ActorHPIsNotOne
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_TailWind: calls AIBuffSkillUsable_7C24, AnyFoeNotBlocked, AIScore_TailWind_Sub01_Sub01 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_TailWind)
AIScore_TailWind_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7C82:: ; address name
    call AIBuffSkillUsable_7C24
    ld a, c
    and a, a
    ret z
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AIScore_TailWind_Conditions_AddAx9ToHL
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeHasSkillWithFlagD
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_StormWind: calls AIBuffSkillUsable_7C24, AnyFoeNotBlocked, AnyAllyLacksStatus2Bit6 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_StormWind)
AIScore_StormWind_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7CA2:: ; address name
    call AIBuffSkillUsable_7C24
    ld a, c
    and a, a
    ret z
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyAllyLacksStatus2Bit6
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeHasSkillWithFlagD
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_AquaWall: calls ActorCanPayMPCost_Bank05, AnyFoeLacksStatus0Bit6, AIScore_AquaWall_Sub01_Sub01 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_AquaWall)
AIScore_AquaWall_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7CC2:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AIScore_AquaWall_Conditions_ReadSlotAIModeIndexed_Bank05
    ld a, c
    cp a, $01
    jr z, .call_ai_score_aqua_wall_conditions_add_ax9_to
    and a, a
    jr z, .call_reset_ai_skill_score

.call_ai_score_aqua_wall_conditions_add_ax9_to:
    call AIScore_AquaWall_Conditions_AddAx9ToHL
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; only called from AIScore_SealPray (E-0047)
; 1 call site from 1 routine (e.g. AIScore_SealPray)
AIScore_SealPray_ActorCanPayMPCost_Bank05:: ; heuristic: follows a terminator; C0
Func_005_7CE7:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_SuckAll: calls ActorCanPayMPCost_Bank05, AnyFoeLacksStatus5Bits67, AnyFoeLacksStatus3And4Bits in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_SuckAll)
AIScore_SuckAll_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7CF3:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeHasMPReadsWrongOffset
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeHasSkillFlag10
    ld a, c
    cp a, $01
    jr z, .call_any_foe_lacks_status0_bit4
    and a, a
    jr z, .call_reset_ai_skill_score

.call_any_foe_lacks_status0_bit4:
    call AnyFoeLacksStatus0Bit4
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus1Bit7
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyAllyLacksStatus2Bit6
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call ActorHPIsNotOne
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call CheckAIFlagSetModeGated
    ld a, c
    cp a, $01
    jr z, .call_actor_lacks_status4_bits45
    and a, a
    jr z, .call_reset_ai_skill_score

.call_actor_lacks_status4_bits45:
    call ActorLacksStatus4Bits45
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AllyCheckSide0FlagAndOtherSlots
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Imitate: calls ActorCanPayMPCost_Bank05, SkillPassesRepeatCheck, AnyFoeLacksStatus5Bits67 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_Imitate)
AIScore_Imitate_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7D5B:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus0MaskCC
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call CheckAIFlagSetModeGated
    ld a, c
    cp a, $01
    jr z, .call_pass_if_battle_turn_non_zero
    and a, a
    jr z, .call_reset_ai_skill_score

.call_pass_if_battle_turn_non_zero:
    call PassIfBattleTurnNonZero
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Meditate: calls ActorCanPayMPCost_Bank05, AIScore_Meditate_Sub01_Sub01 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_Meditate)
AIScore_Meditate_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7D95:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AIScore_Meditate_Conditions_GetBattleMaxHP_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_LifeSong: calls ActorCanPayMPCost_Bank05, AnyOwnSideSlotOutIs1, CheckSide0FlagNot1 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_LifeSong)
AIScore_LifeSong_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7DA8:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyOwnSideSlotOutIs1
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call CheckSide0FlagNot1
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_LoveRain: calls ActorCanPayMPCost_Bank05, SkillPassesRepeatCheck, AnyAllyHPBelow6298 in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_LoveRain)
AIScore_LoveRain_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7DC2:: ; address name
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyAllyHPBelow6298
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; C = 0 (SetCToZero) and resets wDA6E: the skill is never chosen by the AI (E-0122)
; 2 call sites from 2 routines (e.g. AIScore_Whistle, AIScore_ZoneOut)
AINeverUsableResetAISkillScore:: ; heuristic: follows a terminator; C0
Func_005_7DDC:: ; address name
    call SetCToZero
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

; the conditions of AIScore_Guard: calls AnyFoeLacksStatus5Bits67, AnyFoeLacksStatus0MaskCC, AnyFoeNotBlocked in turn and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
; 1 call site from 1 routine (e.g. AIScore_Guard)
AIScore_Guard_Conditions:: ; heuristic: follows a terminator; C0
Func_005_7DE8:: ; address name
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus0MaskCC
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotBlocked
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    call CheckAIFlagSetModeGated
    ld a, c
    cp a, $01
    jr z, .call_pass_if_battle_turn_non_zero
    and a, a
    jr z, .call_reset_ai_skill_score

.call_pass_if_battle_turn_non_zero:
    call PassIfBattleTurnNonZero
    ld a, c
    and a, a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret
    ds $1EC, $00
