; ROM bank $05: battle AI: per-skill scoring routines (AIScore_*) and their conditions
; The annotated listing of this bank is build/listing/bank05.asm.

SECTION "Bank 05", ROMX
    db $05

; A = battle slot: returns HL = the ATK word of the slot from wBattleATK (wBattleATK + 2 * A, A
; doubled in 8 bits) and A = its low byte, through GetBattleStatWord_Bank05. The AI condition and
; scoring routines of this bank call it. (C2, E-0375)
; A = battle slot: HL = the word for that slot at wBattleATK; A = its low byte (E-0064)
GetBattleATK_Bank05::
    ld hl, wBattleATK
    jr GetBattleStatWord_Bank05

SECTION "Bank 05 GetBattleDEF_Bank05", ROMX

; A = battle slot: returns HL = the DEF word of the slot from wBattleDEF (wBattleDEF + 2 * A, A
; doubled in 8 bits) and A = its low byte, through GetBattleStatWord_Bank05. The AI condition and
; scoring routines of this bank call it. (C2, E-0375)
; A = battle slot: HL = the word for that slot at wBattleDEF; A = its low byte (E-0064)
GetBattleDEF_Bank05::
    ld hl, wBattleDEF
    jr GetBattleStatWord_Bank05

SECTION "Bank 05 GetBattleMaxHP_Bank05", ROMX

; A = battle slot: returns HL = the max HP word of the slot from wBattleMaxHP (wBattleMaxHP + 2 * A,
; A doubled in 8 bits) and A = its low byte, through GetBattleStatWord_Bank05. The AI condition and
; scoring routines of this bank call it. (C2, E-0375)
; A = battle slot: HL = the word for that slot at wBattleMaxHP; A = its low byte (E-0064)
GetBattleMaxHP_Bank05::
    ld hl, wBattleMaxHP
    jr GetBattleStatWord_Bank05

SECTION "Bank 05 GetBattleMaxMP_Bank05", ROMX

; A = battle slot: returns HL = the max MP word of the slot from wBattleMaxMP (wBattleMaxMP + 2 * A,
; A doubled in 8 bits) and A = its low byte, through GetBattleStatWord_Bank05. The AI condition and
; scoring routines of this bank call it. (C2, E-0375)
; A = battle slot: HL = the word for that slot at wBattleMaxMP; A = its low byte (E-0064)
GetBattleMaxMP_Bank05::
    ld hl, wBattleMaxMP
    jr GetBattleStatWord_Bank05

SECTION "Bank 05 GetBattleHP_Bank05", ROMX

; A = battle slot: returns HL = the HP word of the slot from wBattleHP (wBattleHP + 2 * A, A doubled
; in 8 bits) and A = its low byte, through GetBattleStatWord_Bank05. The AI condition and scoring
; routines of this bank call it. (C2, E-0375)
; A = battle slot: HL = the word for that slot at wBattleHP; A = its low byte (E-0064)
GetBattleHP_Bank05::
    ld hl, wBattleHP
    jr GetBattleStatWord_Bank05

SECTION "Bank 05 GetBattleMP_Bank05", ROMX

; A = battle slot: returns HL = the MP word of the slot from wBattleMP (wBattleMP + 2 * A, A doubled
; in 8 bits) and A = its low byte, through GetBattleStatWord_Bank05. The AI condition and scoring
; routines of this bank call it. (C2, E-0375)
; A = battle slot: HL = the word for that slot at wBattleMP; A = its low byte (E-0064)
GetBattleMP_Bank05::
    ld hl, wBattleMP
    jr GetBattleStatWord_Bank05

SECTION "Bank 05 GetBattleAGL_Bank05", ROMX

; A = battle slot: returns HL = the AGL word of the slot from wBattleAGL (wBattleAGL + 2 * A, A
; doubled in 8 bits) and A = its low byte, through GetBattleStatWord_Bank05. The AI condition and
; scoring routines of this bank call it. (C2, E-0375)
; A = battle slot: HL = the word for that slot at wBattleAGL; A = its low byte (E-0064)
GetBattleAGL_Bank05::
    ld hl, wBattleAGL
    jr GetBattleStatWord_Bank05

SECTION "Bank 05 ReadSlotAIModeIndexed_Bank05", ROMX

; A = battle slot: returns A = wSlotAIMode[slot] (the byte at wSlotAIMode + A); clobbers HL. The
; same code appears again in this bank as ReadSlotAIModeIndexed_Bank05_2; this copy is called by
; FailIfTwoAlliesBelowHalfHP, AIGateCompareAllyStatAverages, AIScore_Berserker_SpeedAndHPCheck,
; AIScore_Ramming_LastFoeHPAndResist and AIScore_Kamikaze_HealerAllyAndFoeHP. (C2, E-0369; probed
; E-0375)
; A = the byte at wSlotAIMode + A; clobbers HL (the same 10 bytes appear in 13 banks)
ReadSlotAIModeIndexed_Bank05:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld hl, wSlotAIMode
    add_a_to_hl
    ld a, [hl]
    ret

SECTION "Bank 05 GetBattleStatWord_Bank05", ROMX

; The shared tail of GetBattleATK_Bank05 ... GetBattleAGL_Bank05: HL = a per-slot word table, A =
; slot: returns HL = the word at HL + 2 * A (A doubled in 8 bits) and A = its low byte (deref_hl).
; (C2, E-0369; probed E-0375)
GetBattleStatWord_Bank05::
    add a
    add_a_to_hl
    deref_hl
    ret

SECTION "Bank 05 AddDoubleAToHL_Bank05", ROMX

; HL += 2 * A, with A doubled in 8 bits first (so A = $80 or more wraps: $81 adds 2); A ends as the
; new L. No caller in src reaches this copy; the same 7 bytes appear in 12 banks. (C2, E-0375)
; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes
; appear in 12 banks)
AddDoubleAToHL_Bank05:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    add a
    add_a_to_hl
    ret

SECTION "Bank 05 ActorOnLocalSide_Bank05", ROMX

; Carry set when wBattleActor is below 4 (slots 0-3), with A = wBattleActor; in a link battle
; (wLinkMode = 1) with wLinkRole bit 1 set the test is reversed: carry set when it is 4 or more.
; Which side is local is inferred from the reversal, not checked. No caller in src reaches this
; copy; the same 27 bytes appear in 12 banks. (C2, E-0375)
; carry set when wBattleActor < 4 (slots 0-3); when wLinkMode = 1 and wLinkRole bit 1 is set the
; test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the
; reversal, not checked (E-0064) (the same 27 bytes appear in 12 banks)
ActorOnLocalSide_Bank05:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
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

SECTION "Bank 05 TargetOnLocalSide_Bank05", ROMX

; Carry set when wBattleTarget is below 4 (slots 0-3), with A = wBattleTarget; in a link battle
; (wLinkMode = 1) with wLinkRole bit 1 set the test is reversed: carry set when it is 4 or more.
; Which side is local is inferred from the reversal, not checked. No caller in src reaches this
; copy; the same 27 bytes appear in 12 banks. (C2, E-0375)
; carry set when wBattleTarget < 4 (slots 0-3); when wLinkMode = 1 and wLinkRole bit 1 is set the
; test is reversed (carry set when wBattleTarget >= 4) (E-0064) (the same 27 bytes appear in 12
; banks)
TargetOnLocalSide_Bank05:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
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

SECTION "Bank 05 ClearBattleStatusBitsWithMaskD_Bank05", ROMX

; D = mask number 0-6, E = slot: ANDs ClearBitMaskTable_Bank05[D] ($DF, $FE, $00, $FD, $73, $EF,
; $BF) into status byte 0 of the slot (wBattleStatus + 9 * E), clearing BSTAT0_CURSED,
; BSTAT0_POISONED, the whole byte, BSTAT0_BADLY_POISONED, the sleep bits (BSTAT0_ASLEEP and both
; turn bits), BSTAT0_CONFUSED or BSTAT0_PARALYZED. Returns D = the mask and A = the new byte. No
; caller in src reaches this copy (the same block sits in banks $A1 and $A3). (C2, E-0375)
; wBattleStatus + 9 * E &= ClearBitMaskTable_Bank05[D] (AddAx9ToHL); not reached from traced code
; (E-0205)
ClearBattleStatusBitsWithMaskD_Bank05:: ; configured code entry (E-0205); C0
    ld a, d
    ld hl, ClearBitMaskTable_Bank05
    add_a_to_hl
    ld d, [hl]
    ld a, e
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, d
    and [hl]
    ld [hl], a
    ret

SECTION "Bank 05 ClearBitMaskTable_Bank05", ROMX

; the routine at $4075 reads the byte at $408A + D and ANDs it into the byte at wBattleStatus + 9 *
; E (AddAx9ToHL); the same 202-byte block of routines and this table sit at $4075-$413F in banks
; $05, $A1 and $A3 (E-0205, C1)
; record: AND mask
ClearBitMaskTable_Bank05::
    db $df ; id 0
    db $fe ; id 1
    db $00 ; id 2
    db $fd ; id 3
    db $73 ; id 4
    db $ef ; id 5
    db $bf ; id 6

; Sets bit 0 of the byte at wLevelUpGains + A (other bits kept); HL is kept and A ends as the low
; byte of that address. No caller in src reaches this copy; the same 13 bytes appear in 12 banks.
; (C2, E-0375)
; Sets bit 0 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit0OfLevelUpGainsIndexed_Bank05:: ; configured code entry (E-0205); C0
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

SECTION "Bank 05 SetBit1OfLevelUpGainsIndexed_Bank05", ROMX

; Sets bit 1 of the byte at wLevelUpGains + A (other bits kept); HL is kept and A ends as the low
; byte of that address. No caller in src reaches this copy; the same 13 bytes appear in 12 banks.
; (C2, E-0375)
; Sets bit 1 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit1OfLevelUpGainsIndexed_Bank05:: ; configured code entry (E-0205); C0
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

SECTION "Bank 05 SetBit2OfLevelUpGainsIndexed_Bank05", ROMX

; Sets bit 2 of the byte at wLevelUpGains + A (other bits kept); HL is kept and A ends as the low
; byte of that address. No caller in src reaches this copy; the same 13 bytes appear in 12 banks.
; (C2, E-0375)
; Sets bit 2 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit2OfLevelUpGainsIndexed_Bank05:: ; configured code entry (E-0205); C0
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 2, [hl]
    pop hl
    ret

SECTION "Bank 05 PersonalityIndexOfSlot_Bank05", ROMX

; A = slot 0-7: returns A = 9 * g(wSlotPersonalityHi[A]) + 3 * g(wSlotPersonalityMid[A]) +
; g(wSlotPersonalityLo[A]), where g(v) = 0 for v >= $C0, 1 for $40-$BF and 2 below $40: an index
; 0-26, the same one PersonalityIndexOfRecord builds from a save record. HL and BC are kept. No
; caller in src reaches this copy; the same 87 bytes appear in 13 banks. (C2, E-0375)
; A = slot 0-7: returns A = 9 * g(wSlotPersonalityHi[A]) + 3 * g(wSlotPersonalityMid[A]) +
; g(wSlotPersonalityLo[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index
; PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes
; appear in 13 banks)
PersonalityIndexOfSlot_Bank05:: ; configured code entry (E-0205); C0
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

SECTION "Bank 05 CheckSlotStatusBlockWide_Bank05", ROMX

; A = slot: carry set when CheckSlotStatusBlock sets it (the slot is out, or asleep, paralysed,
; confused, frozen ... vacant, ironized or byte 8 bit 3), or when status byte 3 & $C0
; (BSTAT3_AIRBORNE, BSTAT3_AIRBORNE_HI) or byte 4 & $0C (BSTAT4_HIGH_JUMP, BSTAT4_HIGH_JUMP_HI) is
; set; otherwise carry clear. A, BC and HL are kept. No caller in src reaches this copy; the same 31
; bytes appear in 12 banks. (C2, E-0375)
; A = slot: carry set when CheckSlotStatusBlock sets it, or when status byte 3 & $C0 or byte 4 & $0C
; is set (wBattleStatus3 + 9 * A); otherwise carry clear; A, BC, HL kept (E-0067) (the same 31 bytes
; appear in 12 banks)
CheckSlotStatusBlockWide_Bank05:: ; configured code entry (E-0205); C0
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

SECTION "Bank 05 SlotHasStatus3Or4Bits_Bank05", ROMX

; A = slot: returns A = status byte 3 & $C0 (BSTAT3_AIRBORNE, BSTAT3_AIRBORNE_HI), or when that is 0
; status byte 4 & $0C (BSTAT4_HIGH_JUMP, BSTAT4_HIGH_JUMP_HI), with Z set when both are clear; HL is
; kept. No caller in src reaches this copy; the same 17 bytes appear in 13 banks. (C2, E-0375)
; A = slot: with HL = wBattleStatus3 + 9 * A (status byte 3 of wBattleStatus), A = byte 3 & $C0, or
; byte 4 & $0C when that is zero; Z set when both are clear; HL kept (E-0067) (the same 17 bytes
; appear in 13 banks)
SlotHasStatus3Or4Bits_Bank05:: ; configured code entry (E-0205); C0
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

SECTION "Bank 05 ActorCanPayMPCost_Bank05", ROMX

; Cost = wRecordBufferData (byte 0 of the loaded skill record): returns C = $FF (can pay) when the
; cost is 0, when the cost is $FF and the MP word of the actor (wBattleMP + 2 * wBattleActor) is not
; 0, or when MP >= cost; C = 0 otherwise. It agrees with CheckSkillMPCost that MP equal to the cost
; is enough. CheckSkillUsableElseResetAISkillScore runs it first of the checks every scored skill
; goes through. (C2, E-0375)
; cost = wRecordBufferData (byte 0 of the skill record): C = $FF (can pay) when the cost is 0, when
; the cost is $FF and the actor's MP (wBattleMP word) is non-zero, or when MP >= cost; C = 0
; otherwise. Agrees with CheckSkillMPCost that equal MP and cost is enough (E-0063)
ActorCanPayMPCost_Bank05:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    ld hl, wBattleMP
    add a
    add_a_to_hl
    ld a, [wRecordBufferData]
    or a
    jr z, .done2
    cp $ff
    jr nz, .skip
    ld a, [hli]
    or [hl]
    jr nz, .done2
    jr .done

.skip:
    ld c, a
    ld a, [hli]
    sub c
    ld a, [hl]
    sbc $00
    jr nc, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $ff
    ret

SECTION "Bank 05 SkillPassesStatus1Bit0Check", ROMX

; C = 0 (fail) when the loaded skill record has bit 6 of wRecordBufferData + 5 set (the flag $40
; that AIScore_StopSpell_Conditions_AnyFoeSealable takes as a spell) and the actor has
; BSTAT1_SPELLS_SEALED; C = $FF otherwise. Compare refusal code 3 of CheckSkillMPCost. (C2, E-0375)
; C = 0 when bit 6 of wRecordBufferData + $5 (skill record buffer) is set and the actor's status
; byte 1 (wBattleStatus1) bit 0 is set, else $FF (compare refusal code 3 of CheckSkillMPCost)
; (E-0071)
SkillPassesStatus1Bit0Check:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wRecordBufferData + $5]
    bit 6, a
    jr z, .done
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_SPELLS_SEALED, [hl]
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 SkillPassesStatus1Bit7Check", ROMX

; C = 0 (fail) when the loaded skill record has bit 4 of wRecordBufferData + 5 set (the flag $10
; that AnyFoeWithSkillFlag10VulnerableSlotResistances6 pairs with BSTAT1_BREATH_SEALED) and the
; actor has BSTAT1_BREATH_SEALED (status byte 1 bit 7, wBattleStatus1); C = $FF otherwise. (C2,
; E-0375)
; C = $00 when bit 4 of wRecordBufferData + $5 and bit 7 of the actor's status byte 0 are both set,
; else $FF (E-0122) (E-0340: the address in its name read as its RAM name; was
; SkillPassesStatus1Bit7Check)
SkillPassesStatus1Bit7Check:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wRecordBufferData + $5]
    bit 4, a
    jr z, .done
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_BREATH_SEALED, [hl]
    jp z, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 SkillPassesStatus1Bit6Check", ROMX

; C = 0 (fail) when the loaded skill record has bit 5 of wRecordBufferData + 5 set (the flag $20
; that AIScore_DanceShut_Conditions_AnyFoeSealable takes as a dance) and the actor has
; BSTAT1_DANCE_SEALED (status byte 1 bit 6, wBattleStatus1); C = $FF otherwise. (C2, E-0375)
; C = $00 when bit 5 of wRecordBufferData + $5 and bit 6 of the actor's status byte 0 are both set,
; else $FF (E-0122) (E-0340: the address in its name read as its RAM name; was
; SkillPassesStatus1Bit6Check)
SkillPassesStatus1Bit6Check:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wRecordBufferData + $5]
    bit 5, a
    jr z, .done
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_DANCE_SEALED, [hl]
    jp z, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 SkillPassesSideFlagBit3Check", ROMX

; When bit 3 is set in wSideFlags0 or wSideFlags1 (either side), C = 0 (fail) if the skill number in
; wRecordBuffer is SKILL_THICKFOG ($84) or the loaded skill record has bit 6 of wRecordBufferData +
; 5 (a spell); in every other case C = $FF. Compare refusal code 4 of CheckSkillMPCost, which tests
; only the side of the actor. (C2, E-0375)
; when bit 3 is set in wSideFlags0 or wSideFlags1 (either side), C = 0 if the skill wRecordBuffer is
; $84 or wRecordBufferData + $5 bit 6 is set; otherwise C = $FF (compare refusal code 4 of
; CheckSkillMPCost, which tests only the actor's side) (E-0071)
SkillPassesSideFlagBit3Check::
    ld hl, wSideFlags0
    ld a, [hli]
    or [hl]
    and $08
    jr z, .done2
    ld a, [wRecordBuffer]
    cp $84
    jr z, .done
    ld a, [wRecordBufferData + $5]
    bit 6, a
    jr z, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $ff
    ret

SECTION "Bank 05 SkillPassesRepeatCheck", ROMX

; C = 0 (fail) when bit 7 of wRecordBufferData + 8 of the loaded skill record is set and the skill
; number in wRecordBuffer is the queued action (QueuedActionMatches: wQueuedActionId, or the other
; id of one of its pairs); C = $FF otherwise. CheckSkillUsableElseResetAISkillScore runs it second,
; after ActorCanPayMPCost_Bank05. (C2, E-0375)
; when bit 7 of wRecordBufferData + $8 (in the skill record buffer) is set and the skill
; wRecordBuffer is the queued action (QueuedActionMatches), C = 0; otherwise C = $FF (E-0071)
SkillPassesRepeatCheck::
    ld a, [wRecordBufferData + $8]
    bit 7, a
    jr z, .done
    ld a, [wRecordBuffer]
    call QueuedActionMatches
    jr nz, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AnyFoeLacksStatus2Mask22", ROMX

; C = $FF when one of the three slots of the other side (wBattleActor & 4, xor 4) is present
; (CarryUnlessBattleSlotOutSlotEmpty) with neither BSTAT2_BOUNCE nor BSTAT2_MAGIC_BACK (status byte
; 2 & $22 clear); C = 0 when every present foe has one of those bits, or none is present
; (AnySlotLacksStatusMask). (C2, E-0375)
; C = $FF when one of the actor's three opposite slots is present with status byte 2
; (wBattleStatus2) & $22 clear (AnySlotLacksStatusMask), else 0 (E-0114)
AnyFoeLacksStatus2Mask22::
    ld a, [wBattleActor]
    and $04
    xor $04
    ld b, $03
    ld hl, wBattleStatus2
    ld e, $22
    call AnySlotLacksStatusMask
    ret

SECTION "Bank 05 AnyFoeLacksStatus5Bits67", ROMX

; C = $FF when one of the three slots of the other side (wBattleActor & 4, xor 4) is present
; (CarryUnlessBattleSlotOutSlotEmpty) with neither BSTAT5_IRONIZED nor BSTAT5_IRONIZE_TURNS_HI
; (status byte 5 & $C0 clear), so not a hunk of iron; CheckSkillUsableElseResetAISkillScore runs it
; third of the checks every scored skill goes through; C = 0 when every present foe has one of those
; bits, or none is present (AnySlotLacksStatusMask). (C2, E-0375)
; C = $FF when one of the actor's three opposite slots is present with status byte 5
; (wBattleStatus5) & $C0 clear (AnySlotLacksStatusMask), else 0 (E-0071)
AnyFoeLacksStatus5Bits67::
    ld a, [wBattleActor]
    and $04
    xor $04
    ld b, $03
    ld hl, wBattleStatus5
    ld e, $c0
    call AnySlotLacksStatusMask
    ret

SECTION "Bank 05 AnyFoeLacksStatus2Bit3", ROMX

; C = $FF when one of the three slots of the other side (wBattleActor & 4, xor 4) is present
; (CarryUnlessBattleSlotOutSlotEmpty) with BSTAT2_AQUA_WALL clear;
; CheckSkillUsableElseResetAISkillScore runs it fourth of the checks every scored skill goes
; through; C = 0 when every present foe has one of those bits, or none is present
; (AnySlotLacksStatusMask). (C2, E-0375)
; C = $FF when one of the actor's three opposite slots is present with status byte 2
; (wBattleStatus2) bit 3 clear (AnySlotLacksStatusMask), else 0 (E-0071)
AnyFoeLacksStatus2Bit3::
    ld hl, wBattleStatus2
    ld a, [wBattleActor]
    and $04
    xor $04
    ld b, $03
    ld e, $08
    call AnySlotLacksStatusMask
    ret

SECTION "Bank 05 AnyFoeLacksStatus3And4Bits", ROMX

; C = $FF when one of the three slots of the other side (wBattleActor & 4, xor 4) is present with
; status byte 3 & $C0 (BSTAT3_AIRBORNE, BSTAT3_AIRBORNE_HI) and status byte 4 & $0C
; (BSTAT4_HIGH_JUMP, BSTAT4_HIGH_JUMP_HI) both clear, that is, a foe neither airborne nor in a high
; jump; else C = 0. CheckSkillUsableElseResetAISkillScore runs it last of the checks every scored
; skill goes through. (C2, E-0375)
; C = $FF when one of the actor's three opposite slots is present with status byte 3
; (wBattleStatus3) & $C0 and byte 4 (wBattleStatus4) & $0C both clear, else 0 (E-0071)
AnyFoeLacksStatus3And4Bits::
    ld a, [wBattleActor]
    and $04
    xor $04
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
    and $c0
    and a
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
    and $0c
    and a
    jr z, .done2
    jr .next

.done:
    ld c, $00
    ret

.done2:
    ld c, $ff
    ret

SECTION "Bank 05 AnyFoeHasMPReadsWrongOffset", ROMX

; Meant to pass (C = $FF) when a present foe has MP, but it reads the word at wBattleMP + 16 * slot
; (swap a) instead of 2 * slot: for foes in slots 4, 5 and 6 that is the first word of wBattleAGL,
; wBattleINT and wBattleExtraStat (slot 0 values), and for slots 0-2 the slot-0 words of wBattleMP,
; wBattleMaxMP and wBattleATK. C = $FF when the word read for some present foe is not 0, else C = 0.
; (C2, E-0375)
; meant to return C = $FF when one of the actor's three opposite slots is present with non-zero MP
; and 0 otherwise, but it addresses the MP word at wBattleMP + 16 * slot (swap a) instead of 2 *
; slot, so for foes in slots 4-6 it reads 64-96 bytes past the array (a likely bug; executed, test
; FoeMPCheckOffset) (E-0099)
AnyFoeHasMPReadsWrongOffset:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
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
    ld a, [hli]
    and a
    jr nz, .done
    ld a, [hli]
    and a
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AIScore_TakeMagic_Conditions_FoeHasTakeableSkill", ROMX

; C = 1 when the AI mode of the actor is below 2 (the check is skipped). Otherwise, for each present
; foe of the three slots of the other side (wBattleActor & 4, xor 4), it reads the eight bytes at
; wBattleSkillsPrefix + 16 * foe + 2k (k = 0-7), the bytes before the skill numbers, which
; LoadSlotSkillsFromBattlerRecord fills with a nibble of each skill record (0 for an empty entry),
; not the skill numbers at wBattleSkills; a byte $FF ends that foe. Each byte is taken as a skill
; number with high byte 0, and C = $FF when byte 7 of that record (LoadSkillRecordPart, wBattleArg0
; = 7) has bit 0 set, else C = 0 after all foes. Skill 0 lacks that bit and skills 1-15 have it, so
; in effect it passes when one of those bytes is not 0. wRecordBuffer (both bytes) is restored. (C2,
; E-0375)
AIScore_TakeMagic_Conditions_FoeHasTakeableSkill:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $02
    jp c, .done
    ld a, [wRecordBuffer]
    ld l, a
    ld a, [wRecordBuffer + $1]
    ld h, a
    push hl
    ld b, $03
    ld a, [wBattleActor]
    and $04
    xor $04
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
    cp $ff
    jr z, .skip
    ld [wRecordBuffer], a
    xor a
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
    cp $08
    jr c, .loop2
    jr .next

.skip:
    ld a, $08
    sub c
    add a
    add l
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
    ld c, $ff
    ret

.done:
    ld c, $01
    ret

SECTION "Bank 05 AnyFoeLacksStatus0Bit6", ROMX

; C = $FF when one of the three slots of the other side (wBattleActor & 4, xor 4) is present
; (CarryUnlessBattleSlotOutSlotEmpty) with BSTAT0_PARALYZED clear; C = 0 when every present foe has
; one of those bits, or none is present (AnySlotLacksStatusMask). (C2, E-0375)
; C = $FF when one of the actor's three opposite slots is present with status byte 0 (wBattleStatus)
; bit 6 clear (AnySlotLacksStatusMask), else 0 (E-0071)
AnyFoeLacksStatus0Bit6:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld hl, wBattleStatus
    ld a, [wBattleActor]
    and $04
    xor $04
    ld b, $03
    ld e, $40
    call AnySlotLacksStatusMask
    ret

SECTION "Bank 05 AnyActiveFoeHasSkillFlag40", ROMX

; C = 1 when the AI mode of the actor (wSlotAIMode) is below 2 (the check is skipped); otherwise C =
; $FF when one of the three slots of the other side (wBattleActor & 4, xor 4) is present, lacks
; BSTAT1_SPELLS_SEALED and has a skill whose record byte 5 has bit 6 ($40, a spell) set
; (SlotHasSkillWithFlagD), else C = 0. The low byte of wRecordBuffer is saved and restored;
; SlotHasSkillWithFlagD changes wBattleArg0-3 and hTemp0. (C2, E-0375)
; C = 1 when wSlotAIMode[actor] (the AI mode) is below 2; otherwise C = $FF when one of the actor's
; three opposite slots is present with status byte 1 (wBattleStatus1) bit 0 clear and a skill whose
; record part has bit 6 set (SlotHasSkillWithFlagD, D = $40), else 0; wRecordBuffer kept (E-0099)
AnyActiveFoeHasSkillFlag40:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $02
    jr c, .done
    ld a, [wRecordBuffer]
    push af
    ld a, [wBattleActor]
    and $04
    xor $04
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
    bit BSTAT1_SPELLS_SEALED, [hl]
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
    ld c, $ff
    ret

.done:
    ld c, $01
    ret

SECTION "Bank 05 AnyFoeHasSkillFlag10", ROMX

; C = 1 when the AI mode of the actor is below 2 (the check is skipped); otherwise C = $FF when one
; of the three slots of the other side (wBattleActor & 4, xor 4) is present and has a skill whose
; record byte 5 has bit 4 ($10) set (SlotHasSkillWithFlagD), else C = 0. No seal status is tested.
; The low byte of wRecordBuffer is saved and restored. (C2, E-0375)
; C = 1 when the AI mode is below 2; otherwise C = $FF when one of the actor's three opposite slots
; is present with a skill whose record part has bit 4 set (SlotHasSkillWithFlagD, D = $10), else 0;
; wRecordBuffer kept (E-0099)
AnyFoeHasSkillFlag10:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $02
    jr c, .done
    ld a, [wRecordBuffer]
    push af
    ld a, [wBattleActor]
    and $04
    xor $04
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
    ld c, $ff
    ret

.done:
    ld c, $01
    ret

SECTION "Bank 05 AIScore_DanceShut_Conditions_UnsealedDancer", ROMX

; DanceShut AI condition: passes when some present foe is not yet dance-sealed (BSTAT1_DANCE_SEALED)
; and knows a skill with flag $20 (a dance); C = 1 below AI mode 2. (C2, E-0357; probed E-0375)
AIScore_DanceShut_Conditions_UnsealedDancer:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $02
    jr c, .done
    ld a, [wRecordBuffer]
    push af
    ld a, [wBattleActor]
    and $04
    xor $04
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
    bit BSTAT1_DANCE_SEALED, [hl]
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
    ld c, $ff
    ret

.done:
    ld c, $01
    ret

SECTION "Bank 05 AnyFoeNotFullyResistant", ROMX

; Resistance gate for the skill being scored: wRecordBufferData + 1 is its resistance class (0 none,
; otherwise RESIST_* + 1, the order of AnyFoeNotFullyResistant_Data, which gives the
; wSlotResistances byte and 2-bit field of each). C = $FF when the class is 0 or one of the three
; slots of the other side (wBattleActor & 4, xor 4) is present with a level below 3 for it
; (Get2BitFieldEOfHL); C = 0 when every present foe is at level 3. (C2, E-0375)
; C = $FF when wRecordBufferData + $1 is 0 or an occupied foe's resistance field for skill
; wRecordBufferData + $1 is below 3, else $00 (E-0127)
AnyFoeNotFullyResistant::
    ld a, [wRecordBufferData + $1]
    or a
    jr z, .done
    dec a
    ld hl, AnyFoeNotFullyResistant_Data
    add a
    add_a_to_hl
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03
    ld hl, wSlotResistances
    add a
    add c
    add a
    add c
    add d
    add l
    ld l, a
    jr nc, .loop
    inc h

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    call Get2BitFieldEOfHL
    cp $03
    jr nz, .done

.skip:
    ld a, l
    add $07
    ld l, a
    ld a, h
    adc $00
    ld h, a
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AnyFoeHasDEFAtLeast2", ROMX

; C = $FF when one of the three slots of the other side (wBattleActor & 4, xor 4) is present with a
; DEF word (GetBattleDEF_Bank05) of 2 or more, else C = 0. (C2, E-0375)
; C = $FF when one of the actor's three opposite slots is present with DEF (GetBattleDEF_Bank05) of
; 2 or more, else 0 (E-0099)
AnyFoeHasDEFAtLeast2::
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call GetBattleDEF_Bank05
    ld a, h
    or a
    jr nz, .done
    ld a, l
    cp $02
    jr nc, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AIScore_SquallHit_Conditions_AnyFoeAGL2", ROMX

; SquallHit AI condition: passes when some present foe has an AGL of 2 or more. (C2, E-0357; probed
; E-0375)
AIScore_SquallHit_Conditions_AnyFoeAGL2:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call GetBattleAGL_Bank05
    ld a, h
    or a
    jr nz, .done
    ld a, l
    cp $02
    jr nc, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AIScore_FireAir_Conditions_FoeLacksWindGuard", ROMX

; Condition of AIScore_FireAir_Conditions: C = $FF when some present foe lacks BSTAT2_WIND_GUARD
; (status 2 bit 6), else C = 0 (AnySlotLacksStatusMask). (C2, E-0369; probed E-0375)
AIScore_FireAir_Conditions_FoeLacksWindGuard:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
    ld hl, wBattleStatus2
    ld e, $40
    ld b, $03
    call AnySlotLacksStatusMask
    ret

SECTION "Bank 05 AnyFoeLacksStatus0Bit4", ROMX

; C = $FF when one of the three slots of the other side (wBattleActor & 4, xor 4) is present
; (CarryUnlessBattleSlotOutSlotEmpty) with BSTAT0_CONFUSED clear; C = 0 when every present foe has
; one of those bits, or none is present (AnySlotLacksStatusMask). (C2, E-0375)
; C = $FF when one of the actor's three opposite slots is present with status byte 0 bit 4 clear
; (AnySlotLacksStatusMask), else 0 (E-0114)
AnyFoeLacksStatus0Bit4:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
    ld b, $03
    ld hl, wBattleStatus
    ld e, $10
    call AnySlotLacksStatusMask
    ret

SECTION "Bank 05 AIScore_PoisonAir_Conditions_FoeNotBadlyPoisoned", ROMX

; Condition of AIScore_PoisonAir_Conditions: C = $FF when some present foe lacks
; BSTAT0_BADLY_POISONED (status 0 bit 1), else C = 0 (AnySlotLacksStatusMask); BSTAT0_POISONED is
; not tested. (C2, E-0369; probed E-0375)
AIScore_PoisonAir_Conditions_FoeNotBadlyPoisoned:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
    ld hl, wBattleStatus
    ld e, $02
    ld b, $03
    call AnySlotLacksStatusMask
    ret

SECTION "Bank 05 AnyFoeLacksStatus0Bits01", ROMX

; C = $FF when one of the three slots of the other side (wBattleActor & 4, xor 4) is present
; (CarryUnlessBattleSlotOutSlotEmpty) with neither BSTAT0_POISONED nor BSTAT0_BADLY_POISONED (status
; byte 0 & $03 clear); C = 0 when every present foe has one of those bits, or none is present
; (AnySlotLacksStatusMask). (C2, E-0375)
; C = $FF when one of the actor's three opposite slots is present with status byte 0 (wBattleStatus)
; & $03 clear (AnySlotLacksStatusMask), else 0 (E-0099)
AnyFoeLacksStatus0Bits01:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
    ld b, $03
    ld hl, wBattleStatus
    ld e, $03
    call AnySlotLacksStatusMask
    ret

SECTION "Bank 05 AnyFoeLacksStatus0MaskCC", ROMX

; C = $FF when one of the three slots of the other side (wBattleActor & 4, xor 4) is present
; (CarryUnlessBattleSlotOutSlotEmpty) with none of BSTAT0_ASLEEP, BSTAT0_PARALYZED and the two sleep
; turn bits (status byte 0 & $CC clear); C = 0 when every present foe has one of those bits, or none
; is present (AnySlotLacksStatusMask). (C2, E-0375)
; C = $FF when one of the actor's three opposite slots is present with status byte 0 (wBattleStatus)
; & $CC clear (AnySlotLacksStatusMask), else 0 (E-0077)
AnyFoeLacksStatus0MaskCC::
    ld a, [wBattleActor]
    and $04
    xor $04
    ld b, $03
    ld e, $cc
    ld hl, wBattleStatus
    call AnySlotLacksStatusMask
    ret

SECTION "Bank 05 AIScore_AquaWall_Conditions_UnsealedFoeSkill", ROMX

; Condition of AIScore_AquaWall_Conditions: C = $FF when some present foe with none of
; BSTAT1_SPELLS_SEALED, BSTAT1_DANCE_SEALED and BSTAT1_BREATH_SEALED (status 1 & $C1) knows a skill
; with flag $08 (SlotHasSkillWithFlagD); C = 0 when none does; C = 1 when the actor's AI mode is
; below 2. Keeps wRecordBuffer. (C2, E-0369; probed E-0375)
AIScore_AquaWall_Conditions_UnsealedFoeSkill:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $02
    jr c, .done
    ld a, [wRecordBuffer]
    push af
    ld a, [wBattleActor]
    and $04
    xor $04
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
    and $c1
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
    ld c, $ff
    ret

.done:
    ld c, $01
    ret

SECTION "Bank 05 AnyFoeLacksStatus5Bits01", ROMX

; C = $FF when one of the three slots of the other side (wBattleActor & 4, xor 4) is present
; (CarryUnlessBattleSlotOutSlotEmpty) with neither BSTAT5_RADIANT_BLIND nor BSTAT5_SANDSTORM_BLIND
; (status byte 5 & $03 clear); no caller in src reaches it; C = 0 when every present foe has one of
; those bits, or none is present (AnySlotLacksStatusMask). (C2, E-0375)
; C = $FF when one of the actor's three opposite slots is present with status byte 5
; (wBattleStatus5) & $03 clear (AnySlotLacksStatusMask), else 0 (E-0094)
AnyFoeLacksStatus5Bits01:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
    ld b, $03
    ld hl, wBattleStatus5
    ld e, $03
    call AnySlotLacksStatusMask
    ret

SECTION "Bank 05 AnyFoeLacksStatus5Bit0And1Bit1", ROMX

; C = $FF when one of the three slots of the other side (wBattleActor & 4, xor 4) is present with
; BSTAT5_RADIANT_BLIND (status byte 5 bit 0) clear and BSTAT1_BLINDED (status byte 1 bit 1) clear; C
; = 0 when no present foe has both clear. No caller in src reaches it. (C2, E-0375)
; C = $FF when one of the actor's three opposite slots is present with status byte 5
; (wBattleStatus5) bit 0 clear and status byte 1 (wBattleStatus1) bit 1 clear, else 0 (E-0094)
AnyFoeLacksStatus5Bit0And1Bit1:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
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
    and $01
    jr nz, .next
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    ld a, [hl]
    and $02
    jr z, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AnyFoeLacksStatus5Bit1And1Bit1", ROMX

; C = $FF when one of the three slots of the other side (wBattleActor & 4, xor 4) is present with
; BSTAT5_SANDSTORM_BLIND (status byte 5 bit 1) clear and BSTAT1_BLINDED (status byte 1 bit 1) clear;
; C = 0 when no present foe has both clear. No caller in src reaches it. (C2, E-0375)
; C = $FF when one of the actor's three opposite slots is present with status byte 5
; (wBattleStatus5) bit 1 clear and status byte 1 (wBattleStatus1) bit 1 clear, else 0 (E-0094)
AnyFoeLacksStatus5Bit1And1Bit1:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
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
    and $02
    jr nz, .next
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    ld a, [hl]
    and $02
    jr z, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AnyFoeLacksStatus5Bits01And1Bit1", ROMX

; C = $FF when one of the three slots of the other side (wBattleActor & 4, xor 4) is present with
; both BSTAT5_RADIANT_BLIND and BSTAT5_SANDSTORM_BLIND (status byte 5 & $03) clear and
; BSTAT1_BLINDED (status byte 1 bit 1) clear; C = 0 when no present foe has both clear. (C2, E-0375)
; C = $FF when one of the actor's three opposite slots is present with status byte 5
; (wBattleStatus5) & $03 clear and status byte 1 (wBattleStatus1) bit 1 clear, else 0 (E-0100)
AnyFoeLacksStatus5Bits01And1Bit1:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
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
    and $03
    jr nz, .next
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    ld a, [hl]
    and $02
    jr z, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AnyFoeLacksStatus1Bit0", ROMX

; C = $FF when one of the three slots of the other side (wBattleActor & 4, xor 4) is present
; (CarryUnlessBattleSlotOutSlotEmpty) with BSTAT1_SPELLS_SEALED clear; C = 0 when every present foe
; has one of those bits, or none is present (AnySlotLacksStatusMask). (C2, E-0375)
; C = $FF when one of the actor's three opposite slots is present with status byte 1
; (wBattleStatus1) bit 0 clear, else 0 (E-0099)
AnyFoeLacksStatus1Bit0:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
    ld hl, wBattleStatus1
    ld b, $03
    ld e, $01
    call AnySlotLacksStatusMask
    ret

SECTION "Bank 05 AnyFoeLacksStatus1Bit7", ROMX

; C = $FF when one of the three slots of the other side (wBattleActor & 4, xor 4) is present
; (CarryUnlessBattleSlotOutSlotEmpty) with BSTAT1_BREATH_SEALED clear; C = 0 when every present foe
; has one of those bits, or none is present (AnySlotLacksStatusMask). (C2, E-0375)
; C = $FF when one of the actor's three opposite slots is present with status byte 1
; (wBattleStatus1) bit 7 clear, else 0 (E-0099)
AnyFoeLacksStatus1Bit7:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
    ld hl, wBattleStatus1
    ld b, $03
    ld e, $80
    call AnySlotLacksStatusMask
    ret

SECTION "Bank 05 AIScore_DanceShut_Conditions_FoeNotDanceSealed", ROMX

; DanceShut AI condition: passes when some present foe lacks status 1 bit 6. (C2, E-0357; probed
; E-0375)
AIScore_DanceShut_Conditions_FoeNotDanceSealed:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
    ld hl, wBattleStatus1
    ld b, $03
    ld e, $40
    call AnySlotLacksStatusMask
    ret

SECTION "Bank 05 AnyFoeNotBlocked", ROMX

; C = $FF when one of the three slots of the other side (wBattleActor & 4, xor 4) passes
; CheckSlotStatusBlock (present and none of: asleep, paralysed, confused, BSTAT3_FROZEN ...
; BSTAT3_VACANT, ironized, byte 8 bit 3); C = 0 when all three are absent or blocked. (C2, E-0375)
; C = $FF when at least one of the actor's three opposite slots passes CheckSlotStatusBlock (present
; and none of its blocking status bits set); C = 0 when all three are absent or blocked (E-0066)
AnyFoeNotBlocked::
    ld a, [wBattleActor]
    and $04
    xor $04
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
    ld c, $ff
    ret

SECTION "Bank 05 AIScore_LegSweep_Conditions_AnyFoeTrippable", ROMX

; LegSweep AI condition: passes when some present foe can be tripped: not marked in wSlotBodyFlags
; bit 4, no status 3 bits 6-7, and status 3 bits 2-3 clear. (C2, E-0357; probed E-0375)
AIScore_LegSweep_Conditions_AnyFoeTrippable:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03
    ld hl, wSlotBodyFlags
    add l
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
    and $c0
    and a
    jr nz, .next
    push hl
    ld a, c
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl]
    pop hl
    and $0c
    and a
    jr z, .done

.next:
    inc hl
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AnyFoeHasClearStatus3", ROMX

; C = $FF when one of the three slots of the other side (wBattleActor & 4, xor 4) is present
; (CarryUnlessBattleSlotOutSlotEmpty) with status byte 3 entirely clear (none of BSTAT3_FROZEN ...
; BSTAT3_AIRBORNE_HI); C = 0 when every present foe has one of those bits, or none is present
; (AnySlotLacksStatusMask). (C2, E-0375)
; C = $FF when one of the actor's three opposite slots is present with status byte 3
; (wBattleStatus3) entirely clear (AnySlotLacksStatusMask with mask $FF), else 0 (E-0078)
AnyFoeHasClearStatus3::
    ld a, [wBattleActor]
    and $04
    xor $04
    ld b, $03
    ld hl, wBattleStatus3
    ld e, $ff
    call AnySlotLacksStatusMask
    ret

SECTION "Bank 05 AIGateFoeStatus2Mask22", ROMX

; C = 1 when the AI mode of the actor is below 2. Otherwise, only when the resistance class of the
; loaded skill (wRecordBufferData + 1, TestRecordBufferData1) is 3 (RESIST_BANG + 1): C = 0 when one
; of the three slots of the other side (wBattleActor & 4, xor 4) is present with BSTAT2_BOUNCE or
; BSTAT2_MAGIC_BACK (status byte 2 & $22, wBattleStatus2), else C = $FF. Any other class, 0
; included, gives C = $FF. (C2, E-0375)
; C = 1 when the AI mode is below 2; in mode 3 with wRecordBufferData + $1 set, $00 when a foe has
; status 1 mask $22; otherwise $FF (E-0125)
AIGateFoeStatus2Mask22::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $02
    jr c, .done3
    call TestRecordBufferData1
    jr z, .done2
    cp $03
    jr nz, .done2
    ld a, [wBattleActor]
    and $04
    xor $04
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
    and $22
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
    ld c, $ff
    ret

.done3:
    ld c, $01
    ret

SECTION "Bank 05 AIScore_FireAir_WindGuardCheck", ROMX

; FireAir AI condition: for an elemental skill with resistance class 3 (wRecordBufferData + 1),
; fails when a present foe has status 2 bit 6 set; passes otherwise; C = 1 below AI mode 2. (C2,
; E-0357; probed E-0375)
AIScore_FireAir_WindGuardCheck:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $02
    jr c, .done3
    call TestRecordBufferData1
    jr z, .done2
    cp $03
    jr nz, .done2
    ld a, [wBattleActor]
    and $04
    xor $04
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
    and $40
    and a
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
    ld c, $ff
    ret

.done3:
    ld c, $01
    ret

SECTION "Bank 05 ActorLacksStatus4Bits01", ROMX

; C = 0 (fail) when the actor (wBattleActor) has BSTAT4_CHARGE_UP or BSTAT4_CHARGE_UP_HI (status
; byte 4 & $03), else C = $FF. No caller in src reaches it. (C2, E-0375)
; C = 0 when the actor's status byte 4 (wBattleStatus4) & $03 is set, else C = $FF (the correct form
; of the test ActorStatus4CheckReadsAddress gets wrong) (E-0094)
ActorLacksStatus4Bits01:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    ld a, [hl]
    and $03
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 ActorLacksStatus4Bits67", ROMX

; C = 0 (fail) when the actor (wBattleActor) has BSTAT4_FOCUS_LO or BSTAT4_FOCUS (status byte 4 &
; $C0), else C = $FF. (C2, E-0375)
; C = 0 when the actor's status byte 4 (wBattleStatus4 + 9 * actor) & $C0 is set, else C = $FF
; (E-0071)
ActorLacksStatus4Bits67::
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    ld a, [hl]
    and $c0
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 ActorLacksStatus1Bit2", ROMX

; C = 0 (fail) when the actor (wBattleActor) has BSTAT1_ATK_DOUBLED, else C = $FF. No caller in src
; reaches it. (C2, E-0375)
; C = 0 when the actor's status byte 1 (wBattleStatus1) bit 2 is set, else C = $FF (E-0094)
ActorLacksStatus1Bit2:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_ATK_DOUBLED, [hl]
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 ActorLacksStatus1Bit3", ROMX

; C = 0 (fail) when the actor (wBattleActor) has BSTAT1_CRITICAL, else C = $FF. No caller in src
; reaches it. (C2, E-0375)
; C = 0 when the actor's status byte 1 (wBattleStatus1) bit 3 is set, else C = $FF (E-0094)
ActorLacksStatus1Bit3:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_CRITICAL, [hl]
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AIScore_TakeMagic_Conditions_NotYetSet", ROMX

; TakeMagic AI condition: fails when the actor already has BSTAT2_TAKE_MAGIC. (C2, E-0357; probed
; E-0375)
AIScore_TakeMagic_Conditions_NotYetSet:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit BSTAT2_TAKE_MAGIC, [hl]
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AIScore_TailWind_Conditions_NotYetSet", ROMX

; TailWind AI condition: fails when the actor already has BSTAT2_WIND_GUARD. (C2, E-0357; probed
; E-0375)
AIScore_TailWind_Conditions_NotYetSet:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit BSTAT2_WIND_GUARD, [hl]
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AnyAllyLacksStatus2Bit6", ROMX

; C = $FF when one of the three slots of the side of the actor (wBattleActor & 4 and the next two,
; the actor included) is present with BSTAT2_WIND_GUARD (status byte 2 bit 6) clear, else C = 0
; (AnySlotLacksStatusMask). (C2, E-0375)
; C = $FF when one of the actor's own three slots (the actor included) is present with status byte 2
; (wBattleStatus2) bit 6 clear, else 0 (E-0099)
AnyAllyLacksStatus2Bit6:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    ld b, $03
    ld e, $40
    ld hl, wBattleStatus2
    call AnySlotLacksStatusMask
    ret

SECTION "Bank 05 AllOtherAlliesHaveStatus0Bit6", ROMX

; Looks at the actor's own three slots other than the actor: C = $FF when one of them is present
; with status byte 0 (wBattleStatus) bit 6 (BSTAT0_PARALYZED) clear, or when none of them is
; present; C = 0 when every present one has the bit (probes AllOtherAlliesHaveStatus0Bit6#1-3). (C2,
; E-0375)
; looks at the actor's own three slots other than the actor: C = $FF when one of them is present
; with status byte 0 (wBattleStatus) bit 6 clear, or when none of them is present; otherwise (every
; present ally has bit 6) C = 0 (E-0092)
AllOtherAlliesHaveStatus0Bit6::
    ld a, [wBattleActor]
    ld e, a
    and $04
    ld c, a
    ld b, $03
    ld d, $00

.loop:
    ld a, c
    cp e
    jr z, .next
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    inc d
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit BSTAT0_PARALYZED, [hl]
    jr z, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld a, d
    or a
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AIScore_Antidote_Conditions_AllyPoisoned", ROMX

; Antidote AI condition: passes when some present ally is poisoned (status 0 bits 0-1). (C2, E-0357;
; probed E-0375)
AIScore_Antidote_Conditions_AllyPoisoned:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    ld b, $03
    ld hl, wBattleStatus
    ld e, $03
    call AnySlotHasStatusMask
    ret

SECTION "Bank 05 AIScore_NumbOff_Conditions_AllyParalyzedOrAsleep", ROMX

; NumbOff AI condition: passes when some present ally is paralysed or asleep (status 0 & $CC). (C2,
; E-0357; probed E-0375)
AIScore_NumbOff_Conditions_AllyParalyzedOrAsleep:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    ld b, $03
    ld hl, wBattleStatus
    ld e, $cc
    call AnySlotHasStatusMask
    ret

SECTION "Bank 05 AIScore_DeChaos_Conditions_AllyConfused", ROMX

; DeChaos AI condition: passes when some present ally is confused (status 0 bit 4). (C2, E-0357;
; probed E-0375)
AIScore_DeChaos_Conditions_AllyConfused:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    ld b, $03
    ld hl, wBattleStatus
    ld e, $10
    call AnySlotHasStatusMask
    ret

SECTION "Bank 05 AIScore_CurseOff_Conditions_AllyCursed", ROMX

; CurseOff AI condition: passes when some present ally is cursed (status 0 bit 5). (C2, E-0357;
; probed E-0375)
AIScore_CurseOff_Conditions_AllyCursed:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    ld b, $03
    ld hl, wBattleStatus
    ld e, $20
    call AnySlotHasStatusMask
    ret

SECTION "Bank 05 AnyAllySlotResistances4Bits2To5NotAllSet", ROMX

; Sets A = wBattleActor & 4 (the side of the actor) and falls into
; AnySideSlotLacksMaxAirResistances: C = $FF when a present slot of that side is not at level 3 in
; both RESIST_FRIGIDAIR and RESIST_FIREAIR (wSlotResistances byte 4 & $3C not $3C), else C = 0. No
; caller in src reaches it. (C2, E-0375)
; walks the actor's own three slots through their 7-byte wSlotResistances + $4 entries: C = $FF when
; a present slot's entry & $3C is not $3C, else 0 (E-0094) (E-0340: the address in its name read as
; its RAM name; was AnyAllySlotResistances4Bits2To5NotAllSet)
AnyAllySlotResistances4Bits2To5NotAllSet:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04

; A = first slot of a side (0 or 4): C = $FF when some present slot of that side has
; wSlotResistances byte 4 & $3C not $3C, that is, is not at level 3 in both its RESIST_FRIGIDAIR
; (bits 3-2) and RESIST_FIREAIR (bits 5-4) fields; C = 0 otherwise.
; AnyAllySlotResistances4Bits2To5NotAllSet falls into it for the actor's side and
; AIScore_SuckAir_Conditions_FoeNotAirResistant jumps to it for the foes. (C2, E-0369; probed
; E-0375)
AnySideSlotLacksMaxAirResistances::
    ld c, a
    ld b, $03
    ld hl, wSlotResistances + $4
    call ReadByteAtHLPlus4APlus3C_Bank05

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    ld a, [hl]
    and $3c
    cp $3c
    jr nz, .done

.skip:
    ld a, l
    add $07
    ld l, a
    ld a, h
    adc $00
    ld h, a
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AIScore_SuckAir_Conditions_FoeNotAirResistant", ROMX

; SuckAir AI condition: the resistance test of AnyAllySlotResistances4Bits2To5NotAllSet applied to
; the foes. (C2, E-0357; probed E-0375)
AIScore_SuckAir_Conditions_FoeNotAirResistant:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
    jp AnySideSlotLacksMaxAirResistances

SECTION "Bank 05 AIScore_SlimeBlow_Conditions_SlimeFoePresent", ROMX

; SlimeBlow AI condition: a foe of family 0 (slimes) is present (FoeOfFamilyEPresent). (C2, E-0357;
; probed E-0375)
AIScore_SlimeBlow_Conditions_SlimeFoePresent::
    ld e, $00
    call FoeOfFamilyEPresent
    ret

SECTION "Bank 05 AIScore_DrakSlash_Conditions_DragonFoePresent", ROMX

; DrakSlash AI condition: a foe of family 1 (dragons) is present. (C2, E-0357; probed E-0375)
AIScore_DrakSlash_Conditions_DragonFoePresent::
    ld e, $01
    call FoeOfFamilyEPresent
    ret

SECTION "Bank 05 AIScore_BeastCut_Conditions_BeastFoePresent", ROMX

; BeastCut AI condition: a foe of family 2 (beasts) is present. (C2, E-0357; probed E-0375)
AIScore_BeastCut_Conditions_BeastFoePresent::
    ld e, $02
    call FoeOfFamilyEPresent
    ret

SECTION "Bank 05 AIScore_BirdBlow_Conditions_BirdFoePresent", ROMX

; BirdBlow AI condition: a foe of family 3 (birds) is present. (C2, E-0357; probed E-0375)
AIScore_BirdBlow_Conditions_BirdFoePresent::
    ld e, $03
    call FoeOfFamilyEPresent
    ret

SECTION "Bank 05 AIScore_BugBlow_Conditions_BugFoePresent", ROMX

; BugBlow AI condition: a foe of family 5 (bugs) is present. (C2, E-0357; probed E-0375)
AIScore_BugBlow_Conditions_BugFoePresent::
    ld e, $05
    call FoeOfFamilyEPresent
    ret

SECTION "Bank 05 AIScore_Shears_Conditions_PlantFoePresent", ROMX

; Shears AI condition: a foe of family 4 (plants) is present. (C2, E-0357; probed E-0375)
AIScore_Shears_Conditions_PlantFoePresent::
    ld e, $04
    call FoeOfFamilyEPresent
    ret

SECTION "Bank 05 AIScore_DevilCut_Conditions_DevilFoePresent", ROMX

; DevilCut AI condition: a foe of family 6 (devils) is present. (C2, E-0357; probed E-0375)
AIScore_DevilCut_Conditions_DevilFoePresent::
    ld e, $06
    call FoeOfFamilyEPresent
    ret

SECTION "Bank 05 AIScore_ZombieCut_Conditions_ZombieFoePresent", ROMX

; ZombieCut AI condition: a foe of family 7 (zombies) is present. (C2, E-0357; probed E-0375)
AIScore_ZombieCut_Conditions_ZombieFoePresent::
    ld e, $07
    call FoeOfFamilyEPresent
    ret

SECTION "Bank 05 AIScore_CleanCut_Conditions_MaterialFoePresent", ROMX

; CleanCut AI condition: a foe of family 8 (materials) is present. (C2, E-0357; probed E-0375)
AIScore_CleanCut_Conditions_MaterialFoePresent::
    ld e, $08
    call FoeOfFamilyEPresent
    ret

SECTION "Bank 05 AIScore_AquaCut_Conditions_WaterFoePresent", ROMX

; AquaCut AI condition: a foe of family 9 (water) is present. (C2, E-0357; probed E-0375)
AIScore_AquaCut_Conditions_WaterFoePresent::
    ld e, $09
    call FoeOfFamilyEPresent
    ret

SECTION "Bank 05 AIScore_MetalCut_Conditions_MetalFoePresent", ROMX

; C = 0 when one of the three slots of the other side (wBattleActor & 4, xor 4) is present and
; marked metal (wSlotBodyFlags bit 0), else C = $FF. AIScore_MetalCut_Conditions resets the score
; unless C = 0, so SKILL_METALCUT is scored only when a metal foe is present. (C2, E-0375)
AIScore_MetalCut_Conditions_MetalFoePresent:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
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
    ld c, $ff
    ret

SECTION "Bank 05 AIScore_UltraDown_Conditions_AnyFoeLowerable", ROMX

; C = $FF when one of the three slots of the other side (wBattleActor & 4, xor 4) is present and not
; at level 3 in wSlotResistances byte 2 bits 5-4 (RESIST_BEAT; & $30 not $30); else C = 0. The DEF,
; AGL and BSTAT1_BLINDED tests after it never run: the jr nz that follows ld a, h tests the Z flag
; left by GetBattleDEF_Bank05 (its address addition, never zero here), so the first present foe
; without that resistance level always passes. (C2, E-0375)
AIScore_UltraDown_Conditions_AnyFoeLowerable:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld hl, wSlotResistances + $2
    call ReadByteAtHLPlus4APlus3C_Bank05
    and $30
    cp $30
    jr z, .next
    ld a, c
    call GetBattleDEF_Bank05
    ld a, h
    jr nz, .done
    ld a, l
    cp $02
    jr nc, .done
    ld a, c
    call GetBattleAGL_Bank05
    ld a, h
    jr nz, .done
    ld a, l
    cp $02
    jr nc, .done
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_BLINDED, [hl]
    jr z, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AnyFoeOpenToSlotResistances1Field0", ROMX

; C = $FF when one of the three slots of the other side (wBattleActor & 4, xor 4) is present without
; BSTAT1_BLINDED, with status byte 5 & $03 clear (neither BSTAT5_RADIANT_BLIND nor
; BSTAT5_SANDSTORM_BLIND) and below level 3 in wSlotResistances byte 1 bits 1-0 (RESIST_RADIANT);
; else C = 0. (C2, E-0375)
; C = $FF when one of the actor's three opposite slots is present with status byte 1 bit 1 clear,
; status byte 5 & $03 clear and the low 2 bits of its wSlotResistances + $1 entry not 3, else 0
; (E-0099) (E-0340: the address in its name read as its RAM name; was
; AnyFoeOpenToSlotResistances1Field0)
AnyFoeOpenToSlotResistances1Field0::
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_BLINDED, [hl]
    jr nz, .next
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and $03
    jr nz, .next
    ld a, c
    ld hl, wSlotResistances + $1
    call ReadByteAtHLPlus4APlus3C_Bank05
    and $03
    cp $03
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AIScore_StopSpell_Conditions_AnyFoeSealable", ROMX

; StopSpell AI condition: passes when some present foe is not spell-sealed, knows a spell (skill
; flag $40) and is not fully resistant (resistance byte 2 & $03 not $03). (C2, E-0357; probed
; E-0375)
AIScore_StopSpell_Conditions_AnyFoeSealable:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wRecordBuffer]
    push af
    ld a, [wBattleActor]
    and $04
    xor $04
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
    bit BSTAT1_SPELLS_SEALED, [hl]
    jr nz, .next
    call SlotHasSkillWithFlagD
    jr z, .next
    ld a, c
    ld hl, wSlotResistances + $2
    call ReadByteAtHLPlus4APlus3C_Bank05
    and $03
    cp $03
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
    ld c, $ff
    ret

SECTION "Bank 05 AnyFoeWithMPOpenToSlotResistances2Field1", ROMX

; C = $FF when one of the three slots of the other side (wBattleActor & 4, xor 4) is present with an
; MP word (GetBattleMP_Bank05) that is not 0 and below level 3 in wSlotResistances byte 2 bits 3-2
; (RESIST_ROBMAGIC); else C = 0. (C2, E-0375)
; C = $FF when one of the actor's three opposite slots is present with non-zero MP
; (GetBattleMP_Bank05) and bits 3-2 of its wSlotResistances + $2 entry not both set, else 0 (E-0100)
; (E-0340: the address in its name read as its RAM name; was
; AnyFoeWithMPOpenToSlotResistances2Field1)
AnyFoeWithMPOpenToSlotResistances2Field1:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call GetBattleMP_Bank05
    ld a, h
    or l
    jr z, .next
    ld a, c
    ld hl, wSlotResistances + $2
    call ReadByteAtHLPlus4APlus3C_Bank05
    and $0c
    cp $0c
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AIScore_Sap_Conditions_AnyFoeSappable", ROMX

; Sap AI condition: passes when some present foe with DEF of 2 or more is not fully resistant to it
; (resistance byte 3 & $30 not $30). (C2, E-0357; probed E-0375)
AIScore_Sap_Conditions_AnyFoeSappable::
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call GetBattleDEF_Bank05
    ld a, h
    or a
    jr nz, .call_read_byte_at_hl_plus4_a_plus3_c_bank05
    ld a, l
    cp $02
    jr c, .next

.call_read_byte_at_hl_plus4_a_plus3_c_bank05:
    ld a, c
    ld hl, wSlotResistances + $3
    call ReadByteAtHLPlus4APlus3C_Bank05
    and $30
    cp $30
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AIScore_Slow_Conditions_AnyFoeSlowable", ROMX

; Slow AI condition: passes when some present foe with AGL of 2 or more is not fully resistant to it
; (resistance byte 3 & $0C not $0C). (C2, E-0357; probed E-0375)
AIScore_Slow_Conditions_AnyFoeSlowable:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call GetBattleAGL_Bank05
    ld a, h
    or a
    jr nz, .call_read_byte_at_hl_plus4_a_plus3_c_bank05
    ld a, l
    cp $02
    jr c, .next

.call_read_byte_at_hl_plus4_a_plus3_c_bank05:
    ld a, c
    ld hl, wSlotResistances + $3
    call ReadByteAtHLPlus4APlus3C_Bank05
    and $0c
    cp $0c
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AnyFoeOpenToSlotResistances4Field0", ROMX

; C = $FF when one of the three slots of the other side (wBattleActor & 4, xor 4) is present with
; neither BSTAT0_POISONED nor BSTAT0_BADLY_POISONED and below level 3 in wSlotResistances byte 4
; bits 1-0 (RESIST_POISONGAS); else C = 0. (C2, E-0375)
; C = $FF when one of the actor's three opposite slots is present with status byte 0 & $03 clear and
; the low 2 bits of its wSlotResistances + $4 entry not 3, else 0 (E-0099) (E-0340: the address in
; its name read as its RAM name; was AnyFoeOpenToSlotResistances4Field0)
AnyFoeOpenToSlotResistances4Field0::
    ld a, [wBattleActor]
    and $04
    xor $04
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
    and $03
    jr nz, .next
    ld a, c
    ld hl, wSlotResistances + $4
    call ReadByteAtHLPlus4APlus3C_Bank05
    and $03
    cp $03
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AnyFoeOpenToSlotResistances5Field3", ROMX

; C = $FF when one of the three slots of the other side (wBattleActor & 4, xor 4) is present without
; BSTAT0_PARALYZED and below level 3 in wSlotResistances byte 5 bits 7-6 (RESIST_PALSYAIR); else C =
; 0. (C2, E-0375)
; C = $FF when one of the actor's three opposite slots is present with status byte 0 bit 6 clear and
; bits 7-6 of its wSlotResistances + $5 entry not both set, else 0 (E-0099) (E-0340: the address in
; its name read as its RAM name; was AnyFoeOpenToSlotResistances5Field3)
AnyFoeOpenToSlotResistances5Field3:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
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
    and $40
    jr nz, .next
    ld a, c
    ld hl, wSlotResistances + $5
    call ReadByteAtHLPlus4APlus3C_Bank05
    and $c0
    cp $c0
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AIScore_Curse_Conditions_AnyFoeCursable", ROMX

; Curse AI condition: passes when some present foe that is not cursed (status 0 bit 5) is not fully
; resistant (resistance byte 5 & $30 not $30). (C2, E-0357; probed E-0375)
AIScore_Curse_Conditions_AnyFoeCursable:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
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
    and $20
    jr nz, .next
    ld a, c
    ld hl, wSlotResistances + $5
    call ReadByteAtHLPlus4APlus3C_Bank05
    and $30
    cp $30
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AIScore_DanceShut_Conditions_AnyFoeSealable", ROMX

; DanceShut AI condition: passes when some present foe that is not dance-sealed knows a dance (flag
; $20) and is not fully resistant (resistance byte 5 & $03 not $03). (C2, E-0357; probed E-0375)
AIScore_DanceShut_Conditions_AnyFoeSealable:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wRecordBuffer]
    push af
    ld a, [wBattleActor]
    and $04
    xor $04
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
    bit BSTAT1_DANCE_SEALED, [hl]
    jr nz, .next
    call SlotHasSkillWithFlagD
    jr z, .next
    ld a, c
    ld hl, wSlotResistances + $5
    call ReadByteAtHLPlus4APlus3C_Bank05
    and $03
    cp $03
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
    ld c, $ff
    ret

SECTION "Bank 05 AnyFoeWithSkillFlag10VulnerableSlotResistances6", ROMX

; C = $FF when one of the three slots of the other side (wBattleActor & 4, xor 4) is present without
; BSTAT1_BREATH_SEALED, has a skill whose record byte 5 has bit 4 ($10) set (SlotHasSkillWithFlagD)
; and is below level 3 in wSlotResistances byte 6 bits 7-6 (RESIST_MOUTHSHUT); else C = 0. The low
; byte of wRecordBuffer is saved and restored. No caller in src reaches it. (C2, E-0375)
; C = $FF when an occupied foe without status bit 7 has a skill with flag $10 and bits 6-7 of its
; wSlotResistances + $6 field below 3, else $00 (wRecordBuffer preserved) (E-0125) (E-0340: the
; address in its name read as its RAM name; was AnyFoeWithSkillFlag10VulnerableSlotResistances6)
AnyFoeWithSkillFlag10VulnerableSlotResistances6:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wRecordBuffer]
    push af
    ld a, [wBattleActor]
    and $04
    xor $04
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
    bit BSTAT1_BREATH_SEALED, [hl]
    jr nz, .next
    call SlotHasSkillWithFlagD
    jr z, .next
    ld a, c
    ld hl, wSlotResistances + $6
    call ReadByteAtHLPlus4APlus3C_Bank05
    and $c0
    cp $c0
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
    ld c, $ff
    ret

SECTION "Bank 05 AnyAllyOutOrHPBelowQuarter", ROMX

; C = $FF when one of the three wBattleSlotOut bytes of the side of the actor (from wBattleActor &
; 4) is exactly 1 (a defeated or absent battler), or when a present slot of that side has HP times 4
; (16-bit, wrapping) below its max HP (GetBattleMaxHP_Bank05, CompareHLToBC); else C = 0. No caller
; in src reaches it. (C2, E-0375)
; C = $FF when an ally slot is marked out (wBattleSlotOut = 1) or an occupied ally has HP below a
; quarter of its max, else $00 (E-0125)
AnyAllyOutOrHPBelowQuarter:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    ld c, a
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld b, $03

.loop:
    ld a, [hli]
    cp $01
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
    ld c, $ff
    ret

SECTION "Bank 05 AtLeastTwoFoesPresent", ROMX

; C = $FF when at least two of the three slots of the other side (wBattleActor & 4, xor 4) are
; present (CarryUnlessBattleSlotOutSlotEmpty), else C = 0; the opposite of FewerThanTwoFoesPresent.
; (C2, E-0375)
; C = $FF when at least two of the actor's three opposite slots are present, else 0 (the opposite of
; FewerThanTwoFoesPresent) (E-0100)
AtLeastTwoFoesPresent::
    ld a, [wBattleActor]
    and $04
    xor $04
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
    cp $02
    jr nc, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AIScore_TatsuCall_Conditions_FourthSlotFree", ROMX

; TatsuCall AI condition: passes only when the actor's side has its fourth slot free (wBattleSlotOut
; of slot 3 of the side is set), so a called monster has a place. (C2, E-0357; probed E-0375)
AIScore_TatsuCall_Conditions_FourthSlotFree:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    or $03
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    or a
    jr z, .done
    jr .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $ff
    ret

SECTION "Bank 05 AnyOwnSideSlotOutIs1", ROMX

; C = $FF when one of the three wBattleSlotOut bytes of the side of the actor (from wBattleActor &
; 4) is exactly 1 (a defeated or absent battler), else C = 0 ($FF and other values do not count).
; (C2, E-0375)
; C = $FF when one of the actor's side's three wBattleSlotOut bytes is 1, else 0 (E-0099)
AnyOwnSideSlotOutIs1:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld b, $03

.loop:
    ld a, [hli]
    cp $01
    jr z, .done
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 FastestFoeAGLAbove31PercentOfActor", ROMX

; Threshold = the AGL of the actor (GetBattleAGL_Bank05) times 31 divided by 100, rounded down
; (Multiply8By16, Divide24ByA; the low 16 bits are kept). C = $FF when the highest AGL among the
; present foes of the three slots of the other side (wBattleActor & 4, xor 4) is above the
; threshold, else C = 0 (also when no foe is present). (C2, E-0375)
; C = $FF when the fastest occupied foe's AGL exceeds 31 percent of the actor's AGL, else $00
; (E-0127)
FastestFoeAGLAbove31PercentOfActor:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call GetBattleAGL_Bank05
    ld b, h
    ld c, l
    ld a, $1f
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    push hl
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03
    ld de, $0000

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call GetBattleAGL_Bank05
    ld a, h
    cp d
    jr z, .skip
    jr c, .next
    jr .skip2

.skip:
    ld a, l
    cp e
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
    ld c, $ff
    ret

SECTION "Bank 05 AnyAllyHPAtMostThreeQuarters", ROMX

; C = $FF when a present slot of the side of the actor (three slots from wBattleActor & 4) has HP at
; most three quarters of its max HP (CompareHPWithThreeQuartersMax: 3 * max HP, 16-bit, shifted
; right twice arithmetically), else C = 0. (C2, E-0375)
; C = $FF when an occupied ally slot has HP at most three quarters of its max, else $00 (E-0124)
AnyAllyHPAtMostThreeQuarters:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
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
    ld c, $ff
    ret

SECTION "Bank 05 AnyAllyMPAtMostThreeQuarters", ROMX

; C = $FF when a present slot of the side of the actor has MP at most three quarters of its max MP
; (CompareMPWithThreeQuartersMax), else C = 0. No caller in src reaches it. (C2, E-0375)
; C = $FF when an occupied ally slot has MP at most three quarters of its max, else $00 (E-0124)
AnyAllyMPAtMostThreeQuarters:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
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
    ld c, $ff
    ret

SECTION "Bank 05 AIScore_Upper_Conditions_AnyAllyRaisable", ROMX

; Upper AI condition: passes when some present ally's DEF can still be raised
; (AIScore_Upper_Conditions_AnyAllyRaisable_CanRaise). (C2, E-0357; probed E-0375)
AIScore_Upper_Conditions_AnyAllyRaisable:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call AIScore_Upper_Conditions_AnyAllyRaisable_CanRaise
    jr c, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AIScore_Speed_Conditions_AnyAllyRaisable", ROMX

; Speed AI condition: passes when some present ally's AGL can still be raised
; (AIScore_Speed_Conditions_AnyAllyRaisable_CanRaise). (C2, E-0357; probed E-0375)
AIScore_Speed_Conditions_AnyAllyRaisable:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call AIScore_Speed_Conditions_AnyAllyRaisable_CanRaise
    jr c, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 CheckLoneFoeHPNotBelowAIDamageEstimates", ROMX

; Counts the present slots among the three slots opposite the actor (D = the last one found). With
; two or three present, C = $FF. With one, C = 0 when the HP of that foe (GetBattleHP_Bank05) is
; below the word wAIDamageEstimates + 2 * (slot & 3), else C = $FF; with none, D is not set here and
; the HP of slot D as passed in is compared. Callers add a weight row (AddAIWeight or
; AddAIWeightToScore2) when it gives 0, and condition routines in bank $05 reset the score with
; ResetAISkillScore instead. (C2, E-0375)
; counts the present slots among the actor's three opposite slots (D = the last one found); when
; fewer than two are present and that foe's HP (GetBattleHP_Bank05) is below the word
; wAIDamageEstimates[2 * (slot & 3)], C = 0; otherwise C = $FF. With no foe present D is not set by
; this routine (E-0091)
CheckLoneFoeHPNotBelowAIDamageEstimates::
    ld a, [wBattleActor]
    and $04
    xor $04
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
    cp $02
    jr nc, .done
    ld a, d
    call GetBattleHP_Bank05
    push hl
    ld hl, wAIDamageEstimates
    ld a, d
    and $03
    sla a
    add_a_to_hl
    ld a, [hli]
    ld c, a
    ld a, [hl]
    ld b, a
    pop hl
    call CompareHLToBC
    jr nc, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 NoUnflaggedFoeSpeciesOrLink", ROMX

; C = $FF in link battles (wLinkMode non-zero). Otherwise it counts in hTemp0 the present foes (the
; three slots opposite the actor) whose monster id (wBattleMonsterId) has its wSpeciesFlags bit
; clear (TestSpeciesFlag): C = 0 when there is one or more, C = $FF when every present foe is
; flagged or none is present. No caller was found in src/. (C2, E-0375)
; C = $FF in link battles or when every occupied foe's species is already flagged (TestSpeciesFlag),
; else $00 (E-0125)
NoUnflaggedFoeSpeciesOrLink:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wLinkMode]
    or a
    jr nz, .done
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03
    xor a
    ldh [hTemp0], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld hl, wBattleMonsterId
    add a
    add_a_to_hl
    ld a, [hli]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    push bc
    farcall TestSpeciesFlag
    ld a, c
    pop bc
    or a
    jr nz, .next
    ld hl, hTemp0
    inc [hl]

.next:
    inc c
    dec b
    jr nz, .loop
    ldh a, [hTemp0]
    or a
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 CheckFoeStatus7Bit2", ROMX

; C = 1 when the AI mode of the actor (wSlotAIMode) is below 3. Otherwise C = 0 when one of the
; three slots opposite the actor is present with BSTAT7_COUNTER (status byte 7 bit 2) set, else C =
; $FF. AIScore_Fight adds weight row $03 to wAISkillScore2 when it gives 0. (C2, E-0375)
; C = 1 when the AI mode (wSlotAIMode[actor]) is below 3; otherwise C = 0 when one of the actor's
; three opposite slots is present with status byte 7 (wBattleStatus7) bit 2 set, else $FF (E-0099)
CheckFoeStatus7Bit2::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $03
    jr c, .done3
    ld a, [wBattleActor]
    and $04
    xor $04
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
    ld c, $ff
    ret

.done3:
    ld c, $01
    ret

SECTION "Bank 05 AnyAllyLacksStatus1Bits23And4Bits01", ROMX

; C = $FF when one of the three slots on the actor side (the actor included) is present with status
; byte 1 & $0C (BSTAT1_ATK_DOUBLED, BSTAT1_CRITICAL) clear and status byte 4 & $03 (BSTAT4_CHARGE_UP
; and its high bit) clear; C = 0 when every present ally has one of them or none is present. (C2,
; E-0375)
; C = $FF when one of the actor's own three slots is present (the actor included) with status byte 1
; (wBattleStatus1) & $0C clear and status byte 4 & $03 clear, else 0 (E-0099)
AnyAllyLacksStatus1Bits23And4Bits01:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
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
    ld a, [hl]
    and $0c
    jr nz, .next
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and $03
    jr z, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AIScore_MagicWall_Conditions_AllyLacksMagicWall", ROMX

; MagicWall AI condition: passes when some present ally lacks status 8 bit 6. (C2, E-0357; probed
; E-0375)
AIScore_MagicWall_Conditions_AllyLacksMagicWall:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    ld b, $03
    ld e, $40
    ld hl, wBattleStatus8
    call AnySlotLacksStatusMask
    ret

SECTION "Bank 05 AIScore_SideStep_Conditions_NotYetSet", ROMX

; SideStep AI condition: fails when the actor already has status 5 bits 2-3 set. (C2, E-0357; probed
; E-0375)
AIScore_SideStep_Conditions_NotYetSet:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hl]
    and $0c
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AIScore_Surge_Conditions_AnyAllyToCure", ROMX

; Surge AI condition: passes when some present ally has a status to cure: any bit of status 0,
; status 1 & $C3, status 5 & $03, status 6 bit 7 or status 8 bit 7. (C2, E-0357; probed E-0375)
AIScore_Surge_Conditions_AnyAllyToCure:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hli]
    or a
    jr nz, .done
    ld a, [hli]
    and $c3
    jr nz, .done
    inc hl
    inc hl
    inc hl
    ld a, [hli]
    and $03
    jr nz, .done
    ld a, [hli]
    and $80
    jr nz, .done
    inc hl
    ld a, [hl]
    and $80
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AIScore_DeMagic_Conditions_AnyFoeToClear", ROMX

; DeMagic AI condition: C = $FF when some present foe carries an effect it removes (status 1 & $3C,
; status 2 & $6F, status 5 & $CC, status 6 bit 6 or status 8 bit 6), or when slot 3 of the actor
; side (slot 3 for slots 0-3, slot 7 for 4-7) is present (wBattleSlotOut byte 0); C = 0 otherwise.
; (C2, E-0375)
AIScore_DeMagic_Conditions_AnyFoeToClear:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    ld a, [hli]
    and $3c
    jr nz, .done
    ld a, [hli]
    and $6f
    jr nz, .done
    inc hl
    inc hl
    ld a, [hli]
    and $cc
    jr nz, .done
    ld a, [hli]
    and $40
    jr nz, .done
    inc hl
    ld a, [hl]
    and $40
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld a, [wBattleActor]
    and $04
    or $03
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    or a
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 CheckSide0FlagNot1", ROMX

; C = 0 when the actor side byte (wSide0Flag for slots 0-3, wSide1Flag for 4-7) is 1, else C = $FF.
; Condition routines in bank $05 reset the score with ResetAISkillScore when it gives 0. (C2,
; E-0375)
; C = 0 when the actor's side byte (wSide0Flag for slots 0-3, wSide1Flag for 4-7) is 1, else C = $FF
; (E-0099)
CheckSide0FlagNot1::
    ld a, [wBattleActor]
    rrca
    rrca
    and $01
    ld hl, wSide0Flag
    add_a_to_hl
    ld a, [hl]
    cp $01
    jr nz, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 CheckBattleKindNot4Or5", ROMX

; C = 0 when wBattleKind is 4 or 5, else C = $FF. No caller was found in src/. (C2, E-0375)
; C = 0 when wBattleKind is 4 or 5, else C = $FF (E-0094)
CheckBattleKindNot4Or5:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleKind]
    cp $04
    jr z, .done
    cp $05
    jr nz, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $ff
    ret

SECTION "Bank 05 AIScore_SealPray_QueuedSkillInList", ROMX

; Check of AIScore_SealPray: C = 0 when wQueuedActionId is SKILL_MEGAMAGIC, SKILL_BIGBANG,
; SKILL_HELLBLAST, SKILL_WHITEFIRE, SKILL_WHITEAIR, SKILL_MULTICUT or SKILL_GIGASLASH; C = $FF
; otherwise (also when it is 0). AIScore_SealPray adds weight row $8D to wAISkillScore2 when it
; gives 0. (C2, E-0369; probed E-0375)
AIScore_SealPray_QueuedSkillInList:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wQueuedActionId]
    and a
    jr z, .done2
    cp $3d
    jr z, .done
    cp $3e
    jr z, .done
    cp $3f
    jr z, .done
    cp $43
    jr z, .done
    cp $47
    jr z, .done
    cp $66
    jr z, .done
    cp $67
    jr nz, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $ff
    ret

SECTION "Bank 05 FailIfFoeAIDamageEstimatesAtLeastEstimate", ROMX

; For each present foe among the three slots opposite the actor, compares a wAIDamageEstimates word
; with EstimateSkillDamage (C = that foe slot) byte by byte: C = 0 as soon as the high byte of the
; word is at least that of the estimate and its low byte at least that of the estimate, else C =
; $FF. The pointer moves one byte per present foe, so the k-th present foe reads the word at
; wAIDamageEstimates + k, not + 2 * k. AIScore_Blaze and other score routines add a weight row to
; wAISkillScore2 when it gives 0. (C2, E-0375)
; C = $00 when an occupied foe's wAIDamageEstimates word is at least EstimateSkillDamage for it,
; else $FF (E-0125)
FailIfFoeAIDamageEstimatesAtLeastEstimate::
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03
    ld hl, wAIDamageEstimates

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    push hl
    push bc
    call EstimateSkillDamage
    pop bc
    ld d, h
    ld e, l
    pop hl
    inc hl
    ld a, [hl]
    cp d
    jr c, .next
    dec hl
    ld a, [hli]
    cp e
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
    ld c, $ff
    ret

SECTION "Bank 05 EstimateSkillDamage", ROMX

; Estimated damage of skill wRecordBuffer in HL, C = a slot (the foe being checked). By default HL =
; the words at wRecordBufferData + $9 and + $B added, with no scaling. Skills $48-$4A start from the
; actor level L (wBattleLevel): 3L + 10, 2L + 30 or 2L + 20 when wLinkMode is 1 or the actor is in
; slots 0-3, else L + L / 2; then 115% (capped at 180), 110% (capped at 150) or 110% (capped at 180,
; or 220 when slot C is of the Water family, SlotFamilyBelowWater). Skills $4E and $4F use 2L + A (A
; = 1 in link mode 1, else the actor slot 0-3) or L + L / 2, times 2 or 4. These results are then
; scaled by C: 0% for C = 3, 50% for 2, 85% for 1, else 100%; for $48 and $49 C has already been
; overwritten by MultiplyHLByAPercent (0 when the value is below 256, so 100%). Skills $50-$53
; instead take the word at HL as passed in and scale it 30%, 75%, 115% or 130% the same way. (C2,
; E-0375)
EstimateSkillDamage::
    ld a, [wRecordBuffer]
    cp $48
    jr z, .read_battle_actor
    cp $49
    jr z, .read_battle_actor2
    cp $4a
    jp z, .read_battle_actor3
    cp $4e
    jp z, .read_battle_actor4
    cp $4f
    jp z, .read_battle_actor5
    cp $50
    jp z, .skip19
    cp $51
    jp z, .skip19
    cp $52
    jp z, .skip19
    cp $53
    jp z, .skip19
    ld a, [wRecordBufferData + $9]
    ld l, a
    ld a, [wRecordBufferData + $b]
    add l
    ld l, a
    ld a, [wRecordBufferData + $a]
    ld h, a
    ld a, [wRecordBufferData + $c]
    adc h
    ld h, a
    ret

.read_battle_actor:
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
    jr nc, .skip2

.skip:
    ld a, l
    add $0a
    add hl, hl
    add_a_to_hl
    jr .call_multiply_hl_by_a_percent

.skip2:
    ld a, l
    srl a
    add l
    ld l, a
    jr nc, .call_multiply_hl_by_a_percent
    inc h

.call_multiply_hl_by_a_percent:
    ld a, $73
    call MultiplyHLByAPercent
    ld a, h
    or a
    jr nz, .skip3
    ld a, l
    cp $b4
    jp c, .skip18

.skip3:
    ld hl, $00b4
    jp .skip18

.read_battle_actor2:
    ld a, [wBattleActor]
    ld hl, wBattleLevel
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    ld a, [wLinkMode]
    cp $01
    jr z, .skip4
    ld a, [wBattleActor]
    cp $04
    jr nc, .skip5

.skip4:
    ld a, $1e
    add hl, hl
    add_a_to_hl
    jr .call_multiply_hl_by_a_percent2

.skip5:
    ld a, l
    srl a
    add l
    ld l, a
    jr nc, .call_multiply_hl_by_a_percent2
    inc h

.call_multiply_hl_by_a_percent2:
    ld a, $6e
    call MultiplyHLByAPercent
    ld a, h
    or a
    jr nz, .skip6
    ld a, l
    cp $96
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
    cp $01
    jr z, .skip7
    ld a, [wBattleActor]
    cp $04
    jr nc, .skip8

.skip7:
    ld a, $14
    add hl, hl
    add_a_to_hl
    jr .call_multiply_hl_by_a_percent3

.skip8:
    ld a, l
    srl a
    add l
    ld l, a
    jr nc, .call_multiply_hl_by_a_percent3
    inc h

.call_multiply_hl_by_a_percent3:
    ld a, $6e
    push bc
    call MultiplyHLByAPercent
    pop bc
    push hl
    call SlotFamilyBelowWater
    pop hl
    jr z, .skip10
    ld a, h
    or a
    jr nz, .skip9
    ld a, l
    cp $b4
    jr c, .skip18

.skip9:
    ld hl, $00b4
    jr .skip18

.skip10:
    ld a, h
    or a
    jr nz, .skip11
    ld a, l
    cp $dc
    jr c, .skip18

.skip11:
    ld hl, $00dc
    jr .skip18

.read_battle_actor4:
    ld a, [wBattleActor]
    ld hl, wBattleLevel
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    ld a, [wLinkMode]
    cp $01
    jr z, .skip12
    ld a, [wBattleActor]
    cp $04
    jr nc, .skip13

.skip12:
    add hl, hl
    add_a_to_hl
    jr .skip14

.skip13:
    ld a, l
    srl a
    add l
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
    cp $01
    jr z, .skip15
    ld a, [wBattleActor]
    cp $04
    jr nc, .skip16

.skip15:
    add hl, hl
    add_a_to_hl
    jr .skip17

.skip16:
    ld a, l
    srl a
    add l
    ld l, a
    jr nc, .skip17
    inc h

.skip17:
    add hl, hl
    add hl, hl

.skip18:
    ld a, c
    cp $03
    ld c, $00
    jr z, .skip20
    cp $02
    ld c, $32
    jr z, .skip20
    cp $01
    ld c, $55
    jr z, .skip20
    ld c, $64
    jr .skip20

.skip19:
    deref_hl
    ld a, c
    cp $03
    ld c, $1e
    jr z, .skip20
    cp $02
    ld c, $4b
    jr z, .skip20
    cp $01
    ld c, $73
    jr z, .skip20
    ld c, $82

.skip20:
    ld a, c

; HL = HL * A / 100, from the 24-bit product A * HL (Multiply8By16) divided by 100 (Divide24ByA): HL
; is the low 16 bits of the quotient, E its high byte and A the remainder; B = 100 and C = the low
; byte of A * the old H on return. EstimateSkillDamage calls it and also runs into it after picking
; a percentage. (C2, E-0375)
; HL = HL * A / 100 (24-bit intermediate: Multiply8By16 then Divide24ByA), A = the remainder
; (E-0114)
MultiplyHLByAPercent::
    ld b, h
    ld c, l
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    ret

SECTION "Bank 05 SlotFamilyBelowWater", ROMX

; C = battle slot: loads the species record of its monster id (wBattleMonsterId; LoadSpeciesRecord
; into wSpeciesRecord) and returns A = the family; carry set when the family is below 9 (Slime to
; Material), Z when it is 9 (Water). EstimateSkillDamage uses Z to cap skill $4A at 220 instead of
; 180. (C2, E-0375)
; C = battle slot: loads the slot's species record (LoadSpeciesRecord); A = its family; carry set
; when the family is below 9 (Slime to Material), clear for Water (9) and Boss (10) (E-0069)
SlotFamilyBelowWater::
    ld a, c
    add a
    ld hl, wBattleMonsterId
    add_a_to_hl
    ld a, [hli]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesRecord]
    cp $09
    ret

SECTION "Bank 05 PassIfFoesAverageResistanceAtLeast2", ROMX

; Resistance class wRecordBufferData + $1 of the skill being scored (0 = none): C = $FF when it is
; 0. Otherwise it finds the byte and 2-bit field (AnyFoeNotFullyResistant_Data) in the 7-byte
; wSlotResistances record of each foe and, over the present foes among the three slots opposite the
; actor, counts them in hTemp0 and sums their levels in hTemp1 (Get2BitFieldEOfHL): C = 0 when the
; sum is 0 (no foe present included), else C = $FF when sum / count (DivideBByA) is 2 or more and 0
; when it is below. AIScore_Blaze and other score routines add a weight row when it gives 0. (C2,
; E-0375)
; C = $FF when wRecordBufferData + $1 is 0 or the occupied foes' average resistance level for skill
; wRecordBufferData + $1 is at least 2, else $00 (E-0128)
PassIfFoesAverageResistanceAtLeast2::
    ld a, [wRecordBufferData + $1]
    or a
    jr z, .done2
    dec a
    ld hl, AnyFoeNotFullyResistant_Data
    add a
    add_a_to_hl
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03
    ld hl, wSlotResistances
    add a
    add c
    add a
    add c
    add d
    add_a_to_hl
    xor a
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
    add d
    ldh [hTemp1], a

.skip:
    ld a, l
    add $07
    ld l, a
    ld a, h
    adc $00
    ld h, a
    inc c
    dec b
    jr nz, .loop
    ldh a, [hTemp1]
    or a
    jr z, .done
    ld b, a
    ldh a, [hTemp0]
    call DivideBByA
    ld a, b
    cp $02
    jr nc, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $ff
    ret

SECTION "Bank 05 AllyAverageAGLAtLeastFoes", ROMX

; C = 1 when the AI mode of the actor (wSlotAIMode) is below 2. Otherwise compares the average AGL
; of the present slots on the actor side (the actor included) with that of the present foes
; (AverageAGLOfSideA, which uses hTemp0-hTemp2): C = $FF when the ally average is at least the foe
; average, else C = 0. (C2, E-0375)
; C = 1 when the actor's AI mode is below 2; otherwise $FF when the allies' average AGL is at least
; the foes', else $00 (E-0124)
AllyAverageAGLAtLeastFoes:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $02
    jr c, .done2
    ld a, [wBattleActor]
    and $04
    xor $04
    call AverageAGLOfSideA
    push hl
    ld a, [wBattleActor]
    and $04
    call AverageAGLOfSideA
    pop bc
    call CompareHLToBC
    jr nc, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

.done2:
    ld c, $01
    ret

SECTION "Bank 05 PassIfFoeAverageDEFAtMostTwiceAllyATK", ROMX

; C = 1 when the AI mode of the actor is below 2. Otherwise C = $FF when the average DEF of the
; present foes is at most twice the average ATK of the present slots on the actor side (the actor
; included), else C = 0. Uses hTemp0-hTemp5; with no foe present it divides by 0. (C2, E-0375)
; C = 1 when the AI mode is below 2; otherwise $FF when the foes' average DEF is at most twice the
; allies' average ATK, else $00 (E-0129)
PassIfFoeAverageDEFAtMostTwiceAllyATK:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $02
    jp c, .done2
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03
    xor a
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
    add l
    ldh [hTemp1], a
    ldh a, [hTemp2]
    adc h
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
    and $04
    ld c, a
    ld b, $03
    xor a
    ldh [hTemp3], a
    ldh [hTemp4], a
    ldh [hTemp5], a

.loop2:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next2
    call GetBattleATK_Bank05
    ldh a, [hTemp4]
    add l
    ldh [hTemp4], a
    ldh a, [hTemp5]
    adc h
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
    ld c, $ff
    ret

.done2:
    ld c, $01
    ret

SECTION "Bank 05 PassIfTwiceATKAboveHighestFoeDEF", ROMX

; C = 1 when the AI mode of the actor is below 2. Otherwise it keeps the HIGHEST DEF among the
; present foes in hTemp0/hTemp1 (it replaces the kept value only when the new DEF is larger, the
; opposite of FindLowestFoeDEF): C = $FF when that DEF is below twice the ATK of the actor; C = 0
; when it is not, or when no foe is present. (C2, E-0375)
; C = 1 when the AI mode is below 2; otherwise $FF when the lowest DEF among occupied foes is below
; twice the actor's ATK, else $00 (E-0128)
PassIfTwiceATKAboveHighestFoeDEF:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $02
    jr c, .done4
    ld a, [wBattleActor]
    call GetBattleATK_Bank05
    add hl, hl
    push hl
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03
    xor a
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
    sub l
    ldh a, [hTemp1]
    sbc h
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
    ld c, $ff
    ret

.done4:
    ld c, $01
    ret

SECTION "Bank 05 AIScore_TwinHits_CompareATKWithFoeDEF", ROMX

; TwinHits AI check: passes when the actor's ATK is more than twice, or less than half, the lowest
; foe DEF found by FindLowestFoeDEF; fails when it lies between; C = 1 below AI mode 2. (C2, E-0357;
; probed E-0375)
AIScore_TwinHits_CompareATKWithFoeDEF:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $02
    jr c, .done3
    call FindLowestFoeDEF
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
    ld c, $ff
    ret

.done3:
    ld c, $01
    ret

SECTION "Bank 05 AIScore_TwinHits_CheckAllyATK", ROMX

; TwinHits AI check for the allies: passes unless some present ally's ATK lies between half and
; twice the lowest foe DEF; C = 1 below AI mode 2. (C2, E-0357; probed E-0375)
AIScore_TwinHits_CheckAllyATK:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $02
    jr c, .done3
    call FindLowestFoeDEF
    ld a, [wBattleActor]
    and $04
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
    ld c, $ff
    ret

.done3:
    ld c, $01
    ret

SECTION "Bank 05 PassIfFoeAverageATKAtMostTwiceAllyDEF", ROMX

; C = 1 when the AI mode of the actor is below 2. Otherwise averages the ATK of the present foes for
; which SlotIsBlinded gives Z (BSTAT1_BLINDED clear and status byte 5 & $03 clear): C = $FF when no
; foe qualifies or that average is at most twice the average DEF of the present slots on the actor
; side, else C = 0. Uses hTemp0-hTemp5. (C2, E-0375)
; C = 1 when the AI mode is below 2; otherwise $FF when the able foes' average ATK is at most twice
; the allies' average DEF, else $00 (E-0129)
PassIfFoeAverageATKAtMostTwiceAllyDEF:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $02
    jp c, .done2
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03
    xor a
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call SlotIsBlinded
    jr nz, .next
    ld hl, hTemp0
    inc [hl]
    ld a, c
    call GetBattleATK_Bank05
    ldh a, [hTemp1]
    add l
    ldh [hTemp1], a
    ldh a, [hTemp2]
    adc h
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
    or a
    jr z, .done
    call DivideHLByA
    ld a, l
    ldh [hTemp1], a
    ld a, h
    ldh [hTemp2], a
    ld a, [wBattleActor]
    and $04
    ld c, a
    ld b, $03
    xor a
    ldh [hTemp3], a
    ldh [hTemp4], a
    ldh [hTemp5], a

.loop2:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next2
    call GetBattleDEF_Bank05
    ldh a, [hTemp4]
    add l
    ldh [hTemp4], a
    ldh a, [hTemp5]
    adc h
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
    ld c, $ff
    ret

.done2:
    ld c, $01
    ret

SECTION "Bank 05 HPBandOfSlotTemp0", ROMX

; hTemp0 = battle slot: C = 0 when its HP is at least 2/3 of its max HP, 1 when at least 1/2, 2 when
; at least 1/3, 3 when at least 1/4, 4 when at least 1/10, else 5 (each threshold rounded down;
; GetBattleHP_Bank05, GetBattleMaxHP_Bank05). HL = the HP on return. AIScore_Meditate_WeighHPBand
; and other weighing routines in bank $E2 add a weight row by band. (C2, E-0375)
; hTemp0 = battle slot: C = 0 when its HP >= 2/3 of its max HP, 1 when >= 1/2, 2 when >= 1/3, 3 when
; >= 1/4, 4 when >= 1/10, else 5 (GetBattleHP_Bank05, GetBattleMaxHP_Bank05, divisions rounded down)
; (E-0092)
HPBandOfSlotTemp0::
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
    ld a, $0a
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

SECTION "Bank 05 ActorHPIsNotOne", ROMX

; C = 0 when the HP word of the actor is exactly 1 (CompareSlotHPWith1), else C = $FF. Callers add a
; weight row (AddAIWeight or AddAIWeightToScore2) when it gives 0, and condition routines in bank
; $05 reset the score with ResetAISkillScore instead. (C2, E-0375)
; C = $00 when the actor's HP is exactly 1 (CompareSlotHPWith1), else $FF (E-0122)
ActorHPIsNotOne:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call CompareSlotHPWith1
    jr nz, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 FewerThanTwoAlliesAtHP1", ROMX

; Counts the present slots on the actor side (the actor included) whose HP word is exactly 1
; (CompareSlotHPWith1): C = $FF when fewer than two, else C = 0. (C2, E-0375)
; C = $FF when fewer than two occupied ally slots have exactly 1 HP, else $00 (E-0124)
FewerThanTwoAlliesAtHP1:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
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
    cp $02
    jr c, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 ActorLacksStatus1Bits23And4Bits01", ROMX

; C = 0 when the actor status byte 1 & $0C (BSTAT1_ATK_DOUBLED, BSTAT1_CRITICAL) or status byte 4 &
; $03 (BSTAT4_CHARGE_UP and its high bit) is set, else C = $FF. Callers add a weight row
; (AddAIWeight or AddAIWeightToScore2) when it gives 0, and condition routines in bank $05 reset the
; score with ResetAISkillScore instead. (C2, E-0375)
; C = 0 when the actor's status byte 1 (wBattleStatus1) & $0C or byte 4 & $03 is set, else C = $FF
; (E-0072)
ActorLacksStatus1Bits23And4Bits01::
    ld a, [wBattleActor]
    ld hl, wBattleStatus1
    call AddAx9ToHL
    ld a, [hl]
    and $0c
    jr nz, .done
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and $03
    jr z, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $ff
    ret

SECTION "Bank 05 ActorLacksStatus4Bits45", ROMX

; C = 0 when the actor status byte 4 & $30 (BSTAT4_SUCK_AIR and its high bit) is set, else C = $FF.
; (C2, E-0375)
; C = 0 when the actor's status byte 4 (wBattleStatus4) & $30 is set, else C = $FF (E-0100)
ActorLacksStatus4Bits45:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    ld a, [hl]
    and $30
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 FailIfFoeKnowsSkills42To47", ROMX

; C = 1 when the AI mode of the actor is below 2. Otherwise, for each present foe without
; BSTAT1_BREATH_SEALED, it scans eight entries (every other byte) for SKILL_SCORCHING,
; SKILL_WHITEFIRE, SKILL_ICESTORM or SKILL_WHITEAIR and gives C = 0 on a match, else C = $FF. The
; list address is wrong: it swaps the A that AddAx9ToHL left (the low byte of wBattleStatus1 + 9 *
; slot) instead of the slot, so it reads wBattleSkills + swap of that byte ($DA2C for slot 5, not
; the list of slot 5 at $D9D9). (C2, E-0375)
; C = 1 when the AI mode is below 2; otherwise $00 when an occupied foe without status bit 7 knows
; skill $42, $43, $46 or $47, else $FF (E-0127)
FailIfFoeKnowsSkills42To47:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $02
    jr c, .done3
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_BREATH_SEALED, [hl]
    jr nz, .next
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld d, $08

.loop2:
    ld a, [hli]
    cp $42
    jr z, .done
    cp $43
    jr z, .done
    cp $46
    jr z, .done
    cp $47
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
    ld c, $ff
    ret

.done3:
    ld c, $01
    ret

SECTION "Bank 05 AIScore_Transform_NoWeakerFoe", ROMX

; Check of AIScore_Transform: for each present foe counts how many of max HP, max MP, ATK and DEF
; are below the actor's (in hTemp8); C = 0 when some foe is below the actor in at least three of
; them, C = $FF otherwise; C = 1 when the actor's AI mode is below 2. Uses hTemp0-hTemp8. (C2,
; E-0369; probed E-0375)
AIScore_Transform_NoWeakerFoe:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $02
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
    and $04
    xor $04
    ld e, a
    ld d, $03

.loop:
    xor a
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
    cp $03
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
    ld c, $ff
    ret

.done3:
    ld c, $01
    ret

SECTION "Bank 05 SetCToZero", ROMX

; Sets C = 0 and returns; nothing else changes. Score routines call it in place of a check, so the
; weight row or score reset that follows a 0 always happens. (C2, E-0375)
; C = 0
SetCToZero::
    ld c, $00
    ret

SECTION "Bank 05 FailIfFoeSkill3DThreatensActorHP", ROMX

; C = 1 when the AI mode of the actor is below 2. Otherwise it scans the skill lists of the three
; slots opposite the actor (present or not) for SKILL_MEGAMAGIC: on a match it compares 2 * MP + 2 *
; level (wBattleMP, wBattleLevel) of that slot with the HP of the actor and gives C = 0 when it is
; at least the HP. Otherwise C = $FF once the three lists are done. After a match that does not
; threaten, it restarts at wBattleSkills + 2 * (slot + 1) instead of the list of the next slot, so
; the later slots read the wrong bytes. (C2, E-0375)
; C = 1 when the AI mode is below 2; otherwise $00 when a foe knowing skill $3D has 2 * MP + 2 *
; wBattleLevel at least the actor's HP, else $FF (E-0128)
FailIfFoeSkill3DThreatensActorHP:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $02
    jr c, .done3
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03
    ld a, c
    swap a
    ld hl, wBattleSkills
    add l
    ld l, a
    jr nc, .loop
    inc h

.loop:
    ld d, $08

.loop2:
    ld a, [hli]
    cp $3d
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
    ld a, [hli]
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
    ld c, $ff
    ret

.done3:
    ld c, $01
    ret

SECTION "Bank 05 PassIfFoeAIDamageEstimatesAtLeastEstimate", ROMX

; Inverts FailIfFoeAIDamageEstimatesAtLeastEstimate: C = $FF when that routine gives C = 0, else C =
; 0 (see its note for the byte-wise compare and the one-byte stride through wAIDamageEstimates). AI
; score routines add a weight row when it gives 0. (C2, E-0375)
; C = $FF when FailIfFoeAIDamageEstimatesAtLeastEstimate returns C = 0, else $00 (E-0122)
PassIfFoeAIDamageEstimatesAtLeastEstimate::
    call FailIfFoeAIDamageEstimatesAtLeastEstimate
    ld a, c
    and a
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 ActorMPBelowThreeQuarters", ROMX

; C = $FF when 4 * the MP of the actor is below 3 * its max MP (MP under three quarters of max;
; 16-bit words wBattleMP and wBattleMaxMP), else C = 0. (C2, E-0375)
; C = $FF when 4 x the actor's MP is below 3 x its max MP (MP under three quarters of max), else 0
; (E-0100)
ActorMPBelowThreeQuarters:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
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
    ld c, $ff
    ret

SECTION "Bank 05 AIScore_MagicBack_Conditions_NotYetSet", ROMX

; MagicBack AI condition: fails when the actor already has status 2 bits 1 or 5. (C2, E-0357; probed
; E-0375)
AIScore_MagicBack_Conditions_NotYetSet:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    ld a, [hl]
    and $22
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 LinkRuleCheckLinkRules1Bit6", ROMX

; Link-rule check for action category bit 6. C = $FF unless wLinkMode is neither 0 nor 2 and
; wLinkRules + $1 has bit 7 (rules on) and bit 6 set. Then C = 0 when wLinkRules + $2 bit 6 is clear
; (no use allowed) or bit 6 is set in wLinkRuleFlags + actor / 4, the byte of the actor side
; (wLinkRuleState for slots 4-7), the bit CheckLinkRuleViolation sets on the one allowed use;
; otherwise C = $FF. WeighLinkRuleBit6AndTurnLimit and AIScore_Sacrifice_WeighLinkRule add weight
; row $0E to wAISkillScore2 when it gives 0. (C2, E-0375)
; link battles only: C = $00 when rule bits 7 and 6 of wLinkRules + $1 are set and the side's
; wLinkRuleFlags flag (or wLinkRules + $2 bit 6) allows it; otherwise $FF (E-0124) (E-0340: the
; address in its name read as its RAM name; was LinkRuleCheckLinkRules1Bit6)
LinkRuleCheckLinkRules1Bit6::
    ld a, [wLinkMode]
    and a
    jr z, .done2
    cp $02
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
    ld hl, wLinkRuleFlags
    and $04
    srl a
    srl a
    add_a_to_hl
    bit 6, [hl]
    jr z, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $ff
    ret

SECTION "Bank 05 CheckLinkRules1RuleBit5", ROMX

; Link-rule check for action category bit 5. C = $FF unless wLinkMode is neither 0 nor 2 and
; wLinkRules + $1 has bit 7 (rules on) and bit 5 set. Then C = 0 when wLinkRules + $2 bit 5 is clear
; (no use allowed) or bit 5 is set in wLinkRuleFlags + actor / 4, the byte of the actor side
; (wLinkRuleState for slots 4-7), the bit CheckLinkRuleViolation sets on the one allowed use;
; otherwise C = $FF. WeighLinkRules1RuleBit5 adds weight row $0E to wAISkillScore2 when it gives 0.
; (C2, E-0375)
; C = 0 (fail) when wLinkMode is neither 0 nor 2, wLinkRules + $1 bits 7 and 5 are set, and either
; wLinkRules + $2 bit 5 is clear or bit 5 is set in the actor side's byte wLinkRuleFlags[actor / 4];
; otherwise C = $FF (E-0091) (E-0340: the address in its name read as its RAM name; was
; CheckLinkRules1RuleBit5)
CheckLinkRules1RuleBit5:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wLinkMode]
    and a
    jr z, .done2
    cp $02
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
    ld hl, wLinkRuleFlags
    and $04
    srl a
    srl a
    add_a_to_hl
    bit 5, [hl]
    jr z, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $ff
    ret

SECTION "Bank 05 CheckLinkRules1RuleBit4", ROMX

; Link-rule check for action category bit 4. C = $FF unless wLinkMode is neither 0 nor 2 and
; wLinkRules + $1 has bit 7 (rules on) and bit 4 set. Then C = 0 when wLinkRules + $2 bit 4 is clear
; (no use allowed) or bit 4 is set in wLinkRuleFlags + actor / 4, the byte of the actor side
; (wLinkRuleState for slots 4-7), the bit CheckLinkRuleViolation sets on the one allowed use;
; otherwise C = $FF. WeighLinkRules1RuleBit4 adds weight row $0E to wAISkillScore2 when it gives 0.
; (C2, E-0375)
; C = 0 (fail) when wLinkMode is neither 0 nor 2, wLinkRules + $1 bits 7 and 4 are set, and either
; wLinkRules + $2 bit 4 is clear or bit 4 is set in the actor side's byte wLinkRuleFlags[actor / 4];
; otherwise C = $FF (E-0091) (E-0340: the address in its name read as its RAM name; was
; CheckLinkRules1RuleBit4)
CheckLinkRules1RuleBit4:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wLinkMode]
    and a
    jr z, .done2
    cp $02
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
    ld hl, wLinkRuleFlags
    and $04
    srl a
    srl a
    add_a_to_hl
    bit 4, [hl]
    jr z, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $ff
    ret

SECTION "Bank 05 CheckLinkRules1RuleBit3", ROMX

; Link-rule check for action category bit 3. C = $FF unless wLinkMode is neither 0 nor 2 and
; wLinkRules + $1 has bit 7 (rules on) and bit 3 set. Then C = 0 when wLinkRules + $2 bit 3 is clear
; (no use allowed) or bit 3 is set in wLinkRuleFlags + actor / 4, the byte of the actor side
; (wLinkRuleState for slots 4-7), the bit CheckLinkRuleViolation sets on the one allowed use;
; otherwise C = $FF. WeighLinkRules1RuleBit3 adds weight row $0E to wAISkillScore2 when it gives 0.
; (C2, E-0375)
; C = 0 (fail) when wLinkMode is neither 0 nor 2, wLinkRules + $1 bits 7 and 3 are set, and either
; wLinkRules + $2 bit 3 is clear or bit 3 is set in the actor side's byte wLinkRuleFlags[actor / 4];
; otherwise C = $FF (E-0091) (E-0340: the address in its name read as its RAM name; was
; CheckLinkRules1RuleBit3)
CheckLinkRules1RuleBit3:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wLinkMode]
    and a
    jr z, .done2
    cp $02
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
    ld hl, wLinkRuleFlags
    and $04
    srl a
    srl a
    add_a_to_hl
    bit 3, [hl]
    jr z, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $ff
    ret

SECTION "Bank 05 CheckLinkRules1RuleBit2", ROMX

; Link-rule check for action category bit 2. C = $FF unless wLinkMode is neither 0 nor 2 and
; wLinkRules + $1 has bit 7 (rules on) and bit 2 set. Then C = 0 when wLinkRules + $2 bit 2 is clear
; (no use allowed) or bit 2 is set in wLinkRuleFlags + actor / 4, the byte of the actor side
; (wLinkRuleState for slots 4-7), the bit CheckLinkRuleViolation sets on the one allowed use;
; otherwise C = $FF. WeighLinkRules1RuleBit2 adds weight row $0E to wAISkillScore2 when it gives 0.
; (C2, E-0375)
; C = 0 (fail) when wLinkMode is neither 0 nor 2, wLinkRules + $1 bits 7 and 2 are set, and either
; wLinkRules + $2 bit 2 is clear or bit 2 is set in the actor side's byte wLinkRuleFlags[actor / 4];
; otherwise C = $FF (E-0091) (E-0340: the address in its name read as its RAM name; was
; CheckLinkRules1RuleBit2)
CheckLinkRules1RuleBit2:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wLinkMode]
    and a
    jr z, .done2
    cp $02
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
    ld hl, wLinkRuleFlags
    and $04
    srl a
    srl a
    add_a_to_hl
    bit 2, [hl]
    jr z, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $ff
    ret

SECTION "Bank 05 CheckLinkRules1RuleBit1", ROMX

; Link-rule check for action category bit 1. C = $FF unless wLinkMode is neither 0 nor 2 and
; wLinkRules + $1 has bit 7 (rules on) and bit 1 set. Then C = 0 when wLinkRules + $2 bit 1 is clear
; (no use allowed) or bit 1 is set in wLinkRuleFlags + actor / 4, the byte of the actor side
; (wLinkRuleState for slots 4-7), the bit CheckLinkRuleViolation sets on the one allowed use;
; otherwise C = $FF. WeighLinkRules1RuleBit1 adds weight row $0E to wAISkillScore2 when it gives 0.
; (C2, E-0375)
; C = 0 (fail) when wLinkMode is neither 0 nor 2, wLinkRules + $1 bits 7 and 1 are set, and either
; wLinkRules + $2 bit 1 is clear or bit 1 is set in the actor side's byte wLinkRuleFlags[actor / 4];
; otherwise C = $FF (E-0091) (E-0340: the address in its name read as its RAM name; was
; CheckLinkRules1RuleBit1)
CheckLinkRules1RuleBit1:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wLinkMode]
    and a
    jr z, .done2
    cp $02
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
    ld hl, wLinkRuleFlags
    and $04
    srl a
    srl a
    add_a_to_hl
    bit 1, [hl]
    jr z, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $ff
    ret

SECTION "Bank 05 AIScore_MegaMagic_LinkRule", ROMX

; MegaMagic link rule: in a link battle whose rules (wLinkRules + 1 bit 7 and bit 0) restrict it,
; fails when the next rule byte forbids it outright or the side's rule flag (wLinkRuleFlags) is set;
; passes otherwise and in normal battles. (C2, E-0357; probed E-0375)
AIScore_MegaMagic_LinkRule:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wLinkMode]
    and a
    jr z, .done2
    cp $02
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
    ld hl, wLinkRuleFlags
    and $04
    srl a
    srl a
    add_a_to_hl
    bit 0, [hl]
    jr z, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $ff
    ret

SECTION "Bank 05 LinkRuleCheckLinkRuleTurnLimitTurnLimit", ROMX

; C = $FF unless wLinkMode is neither 0 nor 2 and wLinkRuleTurnLimit bit 7 is set (a turn limit is
; on). Then, with T = its bits 0-6, C = 0 when wBattleTurn - T (8-bit) is negative ($80-$FF) or
; below 4, and C = $FF from four turns past the limit on. WeighLinkRuleBit6AndTurnLimit adds weight
; row $0F when it gives 0. (C2, E-0375)
; link battles only: C = $00 when the wLinkRuleTurnLimit rule is on and wBattleTurn is less than 4
; past its limit; otherwise $FF (E-0124)
LinkRuleCheckLinkRuleTurnLimitTurnLimit::
    ld a, [wLinkMode]
    and a
    jr z, .done2
    cp $02
    jr z, .done2
    ld hl, wLinkRuleTurnLimit
    bit 7, [hl]
    jr z, .done2
    ld a, [hl]
    and $7f
    ld b, a
    ld a, [wBattleTurn]
    sub b
    bit 7, a
    jr nz, .done
    cp $04
    jr nc, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $ff
    ret

SECTION "Bank 05 AllySlotsCheckThenFewerThanTwoFoes", ROMX

; Over the three slots on the actor side: C = $FF when the actor slot itself is not present or
; another slot of its side is present; when the actor is alone on its side it returns
; FewerThanTwoFoesPresent (C = $FF with fewer than two foes present, else 0; E = the foe count). The
; three bytes after its ret (ld c, $00 / ret) are never reached. (C2, E-0375)
; C = $FF when another ally slot is occupied or the actor's own slot is empty; otherwise
; FewerThanTwoFoesPresent (E-0124)
AllySlotsCheckThenFewerThanTwoFoes:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    ld e, a
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .skip
    ld a, c
    cp e
    jr z, .done
    jr .next

.skip:
    ld a, c
    cp e
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    call FewerThanTwoFoesPresent
    ret
    db $0e, $00, $c9

.done:
    ld c, $ff
    ret

SECTION "Bank 05 FewerThanTwoFoesPresent", ROMX

; Counts the present slots among the three slots opposite the actor in E: C = $FF when fewer than
; two are present, C = 0 for two or three. Score routines in banks $05 and $E2 add a weight row when
; it gives 0. (C2, E-0375)
; counts the present slots among the actor's three opposite slots: C = $FF when fewer than two are
; present, C = 0 for two or three; E = the count (E-0066)
FewerThanTwoFoesPresent::
    ld a, [wBattleActor]
    and $04
    xor $04
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
    cp $02
    jr c, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 FailIfFoeKnowsSkillList", ROMX

; C = 1 when the AI mode of the actor is below 2. Otherwise C = 0 when a present foe knows a skill
; CountSkillsInList counts (SKILL_BLAZEMOST, SKILL_FIREBOLT, SKILL_EXPLODET, SKILL_INFERMOST,
; SKILL_THORDAIN, SKILL_BLIZZARD, SKILL_BEAT or SKILL_DEFEAT), else C = $FF. (C2, E-0375)
; C = 1 when the AI mode is below 2; otherwise $00 when some occupied foe has CountSkillsInList
; non-zero, else $FF (E-0124) (E-0344: the address in its name dropped or read as the label there;
; was FailIfFoeKnowsSkillList)
FailIfFoeKnowsSkillList:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $02
    jr c, .done3
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call CountSkillsInList
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
    ld c, $ff
    ret

.done3:
    ld c, $01
    ret

SECTION "Bank 05 CheckFoeStatus6Bit3", ROMX

; C = 1 when the AI mode of the actor is below 3. Otherwise C = 0 when one of the three slots
; opposite the actor is present with BSTAT6_IMITATE (status byte 6 bit 3) set, else C = $FF. (C2,
; E-0375)
; C = 1 when wSlotAIMode[actor] (the AI mode) is below 3; otherwise C = 0 when one of the actor's
; three opposite slots is present with status byte 6 (wBattleStatus6) bit 3 set, else C = $FF
; (E-0092)
CheckFoeStatus6Bit3::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $03
    jr c, .done3
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus6
    call AddAx9ToHL
    bit BSTAT6_IMITATE, [hl]
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
    ld c, $ff
    ret

.done3:
    ld c, $01
    ret

SECTION "Bank 05 AIScore_Sacrifice_LowHPAndFoesVulnerable", ROMX

; Check of AIScore_Sacrifice: C = 0 only when the actor's HP is below a tenth of its max HP, another
; ally on its side is present, and no present foe has its RESIST_SACRIFICE field (wSlotResistances
; byte 3 bits 1-0) at 2 or more; C = $FF otherwise. AIScore_Sacrifice adds weight row $19 to
; wAISkillScore when it gives 0. (C2, E-0369; probed E-0375)
AIScore_Sacrifice_LowHPAndFoesVulnerable:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call GetBattleMaxHP_Bank05
    ld a, $0a
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
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    cp e
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
    and $04
    xor $04
    ld c, a
    ld b, $03

.loop2:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next2
    ld a, c
    ld hl, wSlotResistances + $3
    call ReadByteAtHLPlus4APlus3C_Bank05
    and $03
    cp $02
    jr nc, .done

.next2:
    inc c
    dec b
    jr nz, .loop2
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 CompareFoeAverageATKWithAllyDEF", ROMX

; Takes X = twice the average ATK of the present foes and Y = the average DEF of the present slots
; on the actor side (the actor included): C = $FF when X is at most Y. Otherwise C = $FF when X - Y
; is at most half the ally average max HP (the max HP sum halved, then divided by their count), else
; C = 0. Uses hTemp0/hTemp1; a side with no present slot divides by 0. (C2, E-0375)
; compares twice the occupied foes' average ATK with the allies' average DEF; returns $00 or $FF in
; C (E-0130)
CompareFoeAverageATKWithAllyDEF:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03
    ld e, $00
    xor a
    ldh [hTemp0], a
    ldh [hTemp1], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call GetBattleATK_Bank05
    ldh a, [hTemp0]
    add l
    ldh [hTemp0], a
    ldh a, [hTemp1]
    adc h
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
    and $04
    ld c, a
    ld b, $03
    ld e, $00
    xor a
    ldh [hTemp0], a
    ldh [hTemp1], a

.loop2:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next2
    call GetBattleDEF_Bank05
    ldh a, [hTemp0]
    add l
    ldh [hTemp0], a
    ldh a, [hTemp1]
    adc h
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
    sub c
    ld l, a
    ld a, h
    sbc b
    ld h, a
    push hl
    ld a, [wBattleActor]
    and $04
    ld c, a
    ld b, $03
    ld e, $00
    xor a
    ldh [hTemp0], a
    ldh [hTemp1], a

.loop3:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next3
    call GetBattleMaxHP_Bank05
    ldh a, [hTemp0]
    add l
    ldh [hTemp0], a
    ldh a, [hTemp1]
    adc h
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
    ld c, $ff
    ret

SECTION "Bank 05 AIGateLoneAllyMPAndSkills", ROMX

; C = 1 when the AI mode of the actor is below 3. Otherwise it looks for exactly one other present
; ally: when that ally has at most 20 MP and knows SKILL_LIFESONG, C = 0; else when it is not
; BSTAT1_SPELLS_SEALED and knows SKILL_VIVIFY or SKILL_REVIVE, C = 0; any other case C = $FF. The
; count is mis-built: the first loop counts absent slots (wBattleSlotOut not 0 or $FF) until it
; meets the actor, a present slot or a $FF slot, then jumps into the second loop past that slot, so
; an ally in a slot before the actor is missed. No caller was found in src/. (C2, E-0375)
; C = 1 when the AI mode is below 3; with exactly one other occupied ally that has at most 20 MP,
; checks its skills ($A0, $1E/$1F) and status; returns $00 or $FF (E-0129)
AIGateLoneAllyMPAndSkills:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $03
    jp c, .done3
    ld a, [wBattleActor]
    ld e, a
    and $04
    ld c, a
    ld b, $03
    ld d, $00

.loop:
    ld a, c
    cp e
    jr z, .next
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .next
    jr z, .next
    inc d
    inc c
    dec b
    jr nz, .loop
    ld a, d
    cp $01
    jr nz, .done2
    ld a, [wBattleActor]
    ld e, a
    and $04
    ld c, a
    ld b, $03
    ld d, $00
    ld l, $00

.loop2:
    ld a, c
    cp e
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
    cp $01
    jr nz, .done2
    ld e, l
    ld a, l
    call GetBattleMP_Bank05
    ld a, h
    and a
    jr nz, .done2
    ld a, l
    cp $14
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
    ld a, [hli]
    cp $a0
    jr z, .done
    inc hl
    dec b
    jr nz, .loop3
    ld a, e
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_SPELLS_SEALED, [hl]
    jr nz, .done2
    ld a, e
    swap a
    ld hl, wBattleSkills
    add_a_to_hl
    ld b, $08

.loop4:
    ld a, [hli]
    cp $1e
    jr z, .done
    cp $1f
    jr z, .done
    inc hl
    dec b
    jr nz, .loop4
    jr .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $ff
    ret

.done3:
    ld c, $01
    ret

SECTION "Bank 05 FailIfAllyLacksMPForHealSkill", ROMX

; C = 1 when the AI mode of the actor is below 3. Otherwise it walks the other slots of the actor
; side, skipping ones CheckSlotStatusBlock rejects and ones with BSTAT1_DANCE_SEALED. For the first
; such ally it takes the first of SKILL_HEAL ... SKILL_HEALUSALL in its list: C = 0 when its MP is
; below the HealSkillMPCosts byte of that skill; with enough MP it moves to the next ally. An ally
; without any of those skills ends the walk with C = $FF, as does running out of slots. No caller
; was found in src/. (C2, E-0375)
; C = 1 when the AI mode is below 3; otherwise $00 when another able ally knows a skill $16-$1A but
; has less MP than its cost (HealSkillMPCosts), else $FF (E-0128)
FailIfAllyLacksMPForHealSkill:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $03
    jr c, .done2
    ld a, [wBattleActor]
    ld e, a
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    cp e
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
    bit BSTAT1_DANCE_SEALED, [hl]
    jr nz, .loop2
    ld a, c
    swap a
    ld hl, wBattleSkills
    add_a_to_hl
    ld d, $08

.loop3:
    ld a, [hli]
    cp $16
    jr z, .skip
    cp $17
    jr z, .skip
    cp $18
    jr z, .skip
    cp $19
    jr z, .skip
    cp $1a
    jr z, .skip
    inc hl
    dec d
    jr nz, .loop3
    jr .done

.skip:
    ld hl, HealSkillMPCosts
    sub $16
    add_a_to_hl
    ld a, [hl]
    ld d, a
    ld a, c
    call GetBattleMP_Bank05
    ld a, h
    and a
    jr nz, .loop2
    ld a, l
    cp d
    jr nc, .loop2
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

.done2:
    ld c, $01
    ret

SECTION "Bank 05 HealSkillMPCosts", ROMX

; FailIfAllyLacksMPForHealSkill reads the byte $5A33 + (skill - $16) for skills $16-$1A an ally
; knows and compares it with that ally's MP; the bytes after these five decode as an untraced
; routine (ld a, [wBattleActor] ...) and stay data (E-0174, C1)
; record: MP the AI assumes this skill costs
HealSkillMPCosts::
    db $02 ; id 22
    db $05 ; id 23
    db $07 ; id 24
    db $12 ; id 25
    db $24 ; id 26

; C = 1 when the AI mode of the actor is below 3. Otherwise, for each other slot of the actor side
; that CheckSlotStatusBlock accepts and that lacks BSTAT1_DANCE_SEALED, it calls CountSkillsInList
; and gives C = 0 when the count is non-zero, else C = $FF at the end. CountSkillsInList gets the A
; that AddAx9ToHL left (the low byte of wBattleStatus1 + 9 * slot), not the slot, so it counts the
; list at wBattleSkills + that byte with its nibbles swapped ($D9EA for slot 1) instead of the list
; of the ally. No caller was found in src/. (C2, E-0375)
; C = 1 when the actor's AI mode is below 3; otherwise C = $00 when another slot of the actor's side
; can act, has status byte 1 bit 6 clear and knows a skill CountSkillsInList counts, else $FF
; (E-0175) (E-0344: the address in its name dropped or read as the label there; was
; FailIfAbleAllyKnowsSkillList)
FailIfAbleAllyKnowsSkillList:: ; configured code entry (E-0175); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $03
    jr c, .done2
    ld a, [wBattleActor]
    ld e, a
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    cp e
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
    bit BSTAT1_DANCE_SEALED, [hl]
    jr nz, .loop2
    call CountSkillsInList
    jr z, .loop2
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

.done2:
    ld c, $01
    ret

SECTION "Bank 05 FailIfAllyLacksMPForSkillList", ROMX

; C = 1 when the AI mode of the actor is below 3. Otherwise it takes the first other slot of the
; actor side that CheckSlotStatusBlock accepts and scans its eight skills for SKILL_TIDALWAVE,
; SKILL_MEGAMAGIC, SKILL_BIGBANG, SKILL_HELLBLAST, SKILL_MULTICUT and SKILL_GIGASLASH: C = 0 at the
; first of them whose cost in FailIfAllyLacksMPForSkillList_AllySkillMPCosts (15, 1, 30, 25, 20, 20)
; is above the ally MP, else C = $FF. Only that first accepted ally is checked. No caller was found
; in src/. (C2, E-0375)
; C = 1 when the actor's AI mode is below 3; otherwise C = $00 when another able slot of the actor's
; side knows skill $4D, $3D, $3E, $3F, $66, $67 ... and has less MP than its cost in
; FailIfAllyLacksMPForSkillList_AllySkillMPCosts, else $FF (the pattern of
; FailIfAllyLacksMPForHealSkill) (E-0175) (E-0344: the address in its name dropped or read as the
; label there; was FailIfAllyLacksMPForSkillList)
FailIfAllyLacksMPForSkillList:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $03
    jr c, .done3
    ld a, [wBattleActor]
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, [wBattleActor]
    ld e, a
    ld a, c
    cp e
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
    ld a, [hli]
    ld e, $00
    cp $4d
    jr z, .skip2
    inc e
    cp $3d
    jr z, .skip2
    inc e
    cp $3e
    jr z, .skip2
    inc e
    cp $3f
    jr z, .skip2
    inc e
    cp $66
    jr z, .skip2
    inc e
    cp $67
    jr z, .skip2

.next2:
    inc hl
    dec d
    jr nz, .loop2
    jr .done2

.skip2:
    push hl
    push bc
    ld hl, FailIfAllyLacksMPForSkillList_AllySkillMPCosts
    ld a, e
    add_a_to_hl
    ld a, [hl]
    push de
    ld d, a
    ld a, c
    call GetBattleMP_Bank05
    ld a, h
    and a
    jr nz, .restore
    ld a, l
    cp d
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
    ld c, $ff
    ret

.done3:
    ld c, $01
    ret

SECTION "Bank 05 FailIfAllyLacksMPForSkillList_AllySkillMPCosts", ROMX

; FailIfAllyLacksMPForSkillList compares an ally's MP (GetBattleMP_Bank05) with the byte at $5AF8 +
; E for the skill it found (E = position in its skill list $4D, $3D, $3E, $3F, $66, $67); 6 bytes,
; then code (E-0228, C1)
; record: MP cost
FailIfAllyLacksMPForSkillList_AllySkillMPCosts::
    db $0f ; id 0
    db $01 ; id 1
    db $1e ; id 2
    db $19 ; id 3
    db $14 ; id 4
    db $14 ; id 5

; C = 1 when the AI mode of the actor is below 3. Otherwise, for each other slot of the actor side
; that CheckSlotStatusBlock accepts and that lacks BSTAT1_BREATH_SEALED, it scans eight entries for
; SKILL_SCORCHING, SKILL_WHITEFIRE, SKILL_ICESTORM or SKILL_WHITEAIR: C = 0 on a match, else C = $FF
; at the end. Like FailIfFoeKnowsSkills42To47 it reads the list at wBattleSkills + swap of the A
; left by AddAx9ToHL ($D9EA for slot 1), not the list of the ally. No caller was found in src/. (C2,
; E-0375)
; C = 1 when the actor's AI mode is below 3; otherwise C = $00 when another able slot of the actor's
; side has status byte 1 bit 7 clear and knows skill $42, $43, $46 or $47, else $FF; no traced
; caller (E-0228)
FailIfAbleAllyKnowsSkill42To47:: ; configured code entry (E-0228); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $03
    jr c, .done3
    ld a, [wBattleActor]
    ld e, a
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    cp e
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
    bit BSTAT1_BREATH_SEALED, [hl]
    jr nz, .loop2
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld d, $08

.loop3:
    ld a, [hli]
    cp $42
    jr z, .done
    cp $43
    jr z, .done
    cp $46
    jr z, .done
    cp $47
    jr z, .done
    inc hl
    dec d
    jr nz, .loop3
    jr .loop2

.done:
    ld c, $00
    ret

.done2:
    ld c, $ff
    ret

.done3:
    ld c, $01
    ret

SECTION "Bank 05 FailIfAbleAllyWithStatus6KnowsSkill78To92", ROMX

; C = 1 when the AI mode of the actor is below 3. Otherwise, for each other slot of the actor side
; that CheckSlotStatusBlock accepts and that HAS BSTAT1_DANCE_SEALED, it scans eight entries for
; SKILL_PANIDANCE, SKILL_KODANCE, SKILL_LUREDANCE, SKILL_LIFEDANCE, SKILL_HUSTLE, SKILL_SIDESTEP or
; SKILL_DANCESHUT: C = 0 on a match, else C = $FF at the end. Like FailIfFoeKnowsSkills42To47 it
; reads the list at wBattleSkills + swap of the A left by AddAx9ToHL, not the list of the ally. No
; caller was found in src/. (C2, E-0375)
; C = 1 when the actor's AI mode is below 3; otherwise C = $00 when another able slot of the actor's
; side has status byte 1 bit 6 set and knows skill $78-$7D or $92, else $FF; no traced caller
; (E-0228)
FailIfAbleAllyWithStatus6KnowsSkill78To92:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $03
    jr c, .done3
    ld a, [wBattleActor]
    ld e, a
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    cp e
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
    bit BSTAT1_DANCE_SEALED, [hl]
    jr z, .loop2
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld d, $08

.loop3:
    ld a, [hli]
    cp $78
    jr z, .done
    cp $79
    jr z, .done
    cp $7a
    jr z, .done
    cp $7b
    jr z, .done
    cp $7c
    jr z, .done
    cp $7d
    jr z, .done
    cp $92
    jr z, .done
    inc hl
    dec d
    jr nz, .loop3
    jr .loop2

.done:
    ld c, $00
    ret

.done2:
    ld c, $ff
    ret

.done3:
    ld c, $01
    ret

SECTION "Bank 05 AIScore_BeDragon_CountHighStats", ROMX

; BeDragon AI check: counts how many of the actor's stats are already high (max HP 999, max MP 300,
; ATK 300, DEF 200, AGL 286 or more); fails with three or more, passes otherwise. (C2, E-0357;
; probed E-0375)
AIScore_BeDragon_CountHighStats:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
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
    ld bc, $03e7
    call CompareHLToBC
    jr c, .read_temp2
    inc e

.read_temp2:
    ldh a, [hTemp2]
    ld l, a
    ldh a, [hTemp3]
    ld h, a
    ld bc, $012c
    call CompareHLToBC
    jr c, .read_temp4
    inc e

.read_temp4:
    ldh a, [hTemp4]
    ld l, a
    ldh a, [hTemp5]
    ld h, a
    ld bc, $012c
    call CompareHLToBC
    jr c, .read_temp6
    inc e

.read_temp6:
    ldh a, [hTemp6]
    ld l, a
    ldh a, [hTemp7]
    ld h, a
    ld bc, $00c8
    call CompareHLToBC
    jr c, .read_temp8
    inc e

.read_temp8:
    ldh a, [hTemp8]
    ld l, a
    ldh a, [hTemp9]
    ld h, a
    ld bc, $011e
    call CompareHLToBC
    jr c, .skip
    inc e

.skip:
    ld a, e
    cp $03
    jr c, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 PassIfSkill83OrNoAllyHasStatus", ROMX

; C = $FF when SKILL_DEMAGIC is among the eight skills of the actor. Otherwise C = 0 when a present
; slot on the actor side (the actor included) has one or more effects
; CountActiveStatusEffectsOfSlotC counts (status byte 1 bits 2-5, byte 2 bits 0-3, 5 and 6, byte 5 &
; $0C or & $C0, byte 6 bit 6, byte 8 bit 6), else C = $FF. No caller was found in src/. (C2, E-0375)
; C = $FF when the actor knows skill $83 or no occupied ally has an active status effect, else $00
; (E-0125)
PassIfSkill83OrNoAllyHasStatus:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    swap a
    ld hl, wBattleSkills
    add_a_to_hl
    ld b, $08

.loop:
    ld a, [hli]
    cp $83
    jr z, .done2
    inc hl
    dec b
    jr nz, .loop
    ld a, [wBattleActor]
    and $04
    and $04
    ld c, a
    ld b, $03

.loop2:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call CountActiveStatusEffectsOfSlotC
    ld a, d
    cp $01
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
    ld c, $ff
    ret

SECTION "Bank 05 FailIfFoeHPAtMostFourFifthsAIDamageEstimates", ROMX

; C = 0 when the HP of a present foe is at most (E / 5) * 4, E being its word at wAIDamageEstimates
; + 2 * (slot & 3) (ScaleHLToFourFifths, rounded down before the multiply), else C = $FF. (C2,
; E-0375)
; C = $00 when an occupied foe's HP is at most four fifths of its wAIDamageEstimates word, else $FF
; (E-0125)
FailIfFoeHPAtMostFourFifthsAIDamageEstimates:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    and $03
    ld hl, wAIDamageEstimates
    sla a
    add_a_to_hl
    push bc
    ld a, [hli]
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
    ld c, $ff
    ret

SECTION "Bank 05 CheckBattleKindNot2Or3", ROMX

; C = 0 when wBattleKind is 2 or 3, else C = $FF. (C2, E-0375)
; C = 0 when wBattleKind is 2 or 3, else C = $FF (E-0100)
CheckBattleKindNot2Or3::
    ld a, [wBattleKind]
    cp $02
    jr z, .done
    cp $03
    jr z, .done
    jr .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $ff
    ret

SECTION "Bank 05 AIScore_MegaMagic_LinkModeAllows", ROMX

; Passes in normal and type-2 link battles, fails in other link modes. (C2, E-0357; probed E-0375)
AIScore_MegaMagic_LinkModeAllows:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wLinkMode]
    and a
    jr z, .done
    cp $02
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 PassIfSideFlagOrOtherAllyPresent", ROMX

; C = $FF when the actor side byte (wSide0Flag for slots 0-3, wSide1Flag for 4-7) is 1, or when
; another slot of the actor side is present; C = 0 when every other slot of its side is empty. (C2,
; E-0375)
; C = $FF when the side's wSide0Flag/wSide1Flag flag is 1 or another ally slot is empty, else $00
; (E-0124)
PassIfSideFlagOrOtherAllyPresent:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    cp $04
    jr nc, .check_side1_flag
    ld a, [wSide0Flag]
    jr .cp_01

.check_side1_flag:
    ld a, [wSide1Flag]

.cp_01:
    cp $01
    jr z, .done
    ld a, [wBattleActor]
    ld e, a
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    cp e
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
    ld c, $ff
    ret

SECTION "Bank 05 AnyAllyLacksStatus2Bit2", ROMX

; C = $FF when one of the three slots on the actor side (the actor included) is present with
; BSTAT2_DAMAGE_HALVED (status byte 2 bit 2) clear, else C = 0 (AnySlotLacksStatusMask). (C2,
; E-0375)
; C = $FF when one of the actor's own three slots (the actor included) is present with status byte 2
; (wBattleStatus2) bit 2 clear (AnySlotLacksStatusMask), else 0 (E-0100)
AnyAllyLacksStatus2Bit2:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    ld c, a
    ld b, $03
    ld hl, wBattleStatus2
    ld e, $04
    call AnySlotLacksStatusMask
    ret

SECTION "Bank 05 AnyAllyLacksStatus2Bit2_2", ROMX

; The same test as AnyAllyLacksStatus2Bit2: C = $FF when one of the three slots on the actor side
; (the actor included) is present with BSTAT2_DAMAGE_HALVED clear, else C = 0. It computes the side
; with and $04 twice where the foe checks use and $04 / xor $04, so it may have been meant for the
; foes. Score routines in bank $E2 call it. (C2, E-0375)
; the same test as AnyAllyLacksStatus2Bit2: C = $FF when one of the actor's own three slots (the
; actor included) is present with status byte 2 bit 2 clear. It computes the side with `and a, $04`
; twice where the opposite-side predicates use `and a, $04 / xor a, $04`, so it probably meant the
; foes (a possible slip; not executed) (E-0100) (E-0344: the address in its name dropped or read as
; the label there; was AnyAllyLacksStatus2Bit2_2)
AnyAllyLacksStatus2Bit2_2:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    and $04
    ld c, a
    ld b, $03
    ld hl, wBattleStatus2
    ld e, $04
    call AnySlotLacksStatusMask
    ret

SECTION "Bank 05 FailIfFoeHPAtLeast150PercentOfActor", ROMX

; C = 1 when the AI mode of the actor is below 3. Otherwise, with T = the HP of the actor plus half
; of it (sra, so a signed halving), C = 0 when the HP of a present foe minus T (16-bit) has bit 15
; clear, i.e. the HP of the foe is at least 1.5 times that of the actor for ordinary values; else C
; = $FF. (C2, E-0375)
; C = 1 when the AI mode is below 3; otherwise $00 when an occupied foe has HP at least 1.5 times
; the actor's, else $FF (E-0125)
FailIfFoeHPAtLeast150PercentOfActor:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $03
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
    and $04
    xor $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call GetBattleHP_Bank05
    ld a, l
    sub e
    ld l, a
    ld a, h
    sbc d
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
    ld c, $ff
    ret

.done3:
    ld c, $01
    ret

SECTION "Bank 05 FailIfLinkModeZeroAndPlayerStateFlagsBit3", ROMX

; C = 0 when wLinkMode is 0 and bit 3 of hPlayerStateFlags (one of its field-state flags) is set,
; else C = $FF. No caller was found in src/. (C2, E-0375)
; C = $00 when wLinkMode is 0 and bit 3 of hPlayerStateFlags is set, else $FF (E-0122)
FailIfLinkModeZeroAndPlayerStateFlagsBit3:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wLinkMode]
    or a
    jr nz, .done
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AnyFoeOpenToSlotResistances2Field3", ROMX

; C = $FF when one of the three slots opposite the actor is present without BSTAT0_ASLEEP and with
; its RESIST_SLEEP field (wSlotResistances byte 2 bits 7-6) below 3; else C = 0. (C2, E-0375)
; C = $FF when one of the actor's three opposite slots is present with status byte 0 bit 7 clear and
; bits 7-6 of its wSlotResistances + $2 entry not both set, else 0 (E-0100) (E-0340: the address in
; its name read as its RAM name; was AnyFoeOpenToSlotResistances2Field3)
AnyFoeOpenToSlotResistances2Field3:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit BSTAT0_ASLEEP, [hl]
    jr nz, .next
    ld a, c
    ld hl, wSlotResistances + $2
    call ReadByteAtHLPlus4APlus3C_Bank05
    and $c0
    cp $c0
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AnyFoeVulnerableBySlotResistances5Bits23", ROMX

; C = $FF when one of the three slots opposite the actor is present with its status byte 3 zero and
; its RESIST_LEGSWEEP field (wSlotResistances byte 5 bits 3-2) below 3; else C = 0. (C2, E-0375)
; C = $FF when an occupied foe has a zero wBattleStatus3 byte and bits 2-3 of its wSlotResistances +
; $5 field below 3, else $00 (E-0124) (E-0340: the address in its name read as its RAM name; was
; AnyFoeVulnerableBySlotResistances5Bits23)
AnyFoeVulnerableBySlotResistances5Bits23:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
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
    and a
    jr nz, .next
    ld a, c
    ld hl, wSlotResistances + $5
    call ReadByteAtHLPlus4APlus3C_Bank05
    and $0c
    cp $0c
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AIScore_EerieLite_Conditions_AnyFoeAffectable", ROMX

; EerieLite AI condition: passes when some present foe is not under BSTAT8_EERIE_LITE and is not
; fully resistant (resistance byte 2 & $30 not $30). (C2, E-0357; probed E-0375)
AIScore_EerieLite_Conditions_AnyFoeAffectable:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03
    ld de, wSlotResistances + $2
    add a
    add c
    add a
    add c
    add e
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
    bit BSTAT8_EERIE_LITE, [hl]
    jr nz, .skip
    ld a, [de]
    and $30
    cp $30
    jr nz, .done

.skip:
    ld a, e
    add $07
    ld e, a
    ld a, d
    adc $00
    ld d, a
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 PassIfBattleTurnNonZero", ROMX

; C = $FF when wBattleTurn is non-zero, else C = 0. Condition routines in bank $05 reset the score
; with ResetAISkillScore when it gives 0. (C2, E-0375)
; C = $FF when wBattleTurn is non-zero, else $00 (E-0122)
PassIfBattleTurnNonZero:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleTurn]
    and a
    jr nz, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AnyFoeLacksStatus4Bits23ThenStatus3Bits67", ROMX

; Runs AnySlotLacksStatusMask over the side opposite the actor for status byte 4 & $0C
; (BSTAT4_HIGH_JUMP field) and returns its C = 0; when it gives $FF it returns the same test for
; status byte 3 & $C0 (the airborne field). It never sets B: the slot count is the B of the caller
; for the first test and whatever the first test left in B for the second. No caller was found in
; src/. (C2, E-0375)
; C = the result for foes with status byte 4 & $0C clear; when that is non-zero, C = the result for
; foes with status byte 3 & $C0 clear (both through AnySlotLacksStatusMask) (E-0120)
AnyFoeLacksStatus4Bits23ThenStatus3Bits67:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld hl, wBattleStatus4
    ld e, $0c
    call AnySlotLacksStatusMask
    ld a, c
    or a
    ret z
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld hl, wBattleStatus3
    ld e, $c0
    call AnySlotLacksStatusMask
    ret

SECTION "Bank 05 AnyFoeVulnerableBySlotResistances3Bits67", ROMX

; C = $FF when one of the three slots opposite the actor is present without BSTAT0_CONFUSED and with
; its RESIST_PANICALL field (wSlotResistances byte 3 bits 7-6) below 3; else C = 0. (C2, E-0375)
; C = $FF when an occupied foe lacks status bit 4 and has bits 6-7 of its wSlotResistances + $3
; field below 3, else $00 (E-0124) (E-0340: the address in its name read as its RAM name; was
; AnyFoeVulnerableBySlotResistances3Bits67)
AnyFoeVulnerableBySlotResistances3Bits67:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit BSTAT0_CONFUSED, [hl]
    jr nz, .next
    ld a, c
    ld hl, wSlotResistances + $3
    call ReadByteAtHLPlus4APlus3C_Bank05
    and $c0
    cp $c0
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AIScore_EvilSlash_CheckFoes", ROMX

; EvilSlash AI condition: C = 0 when a present foe has status byte 0 & $C0 (BSTAT0_PARALYZED,
; BSTAT0_ASLEEP) or status byte 3 & $3F (frozen, dancing, tripped, shivering, cowering or vacant)
; set; C = $FF otherwise. The byte-3 read comes after ld a, [hli] and two inc hl. (C2, E-0375)
AIScore_EvilSlash_CheckFoes:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hli]
    and $c0
    jr nz, .done
    inc hl
    inc hl
    ld a, [hl]
    and $3f
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $ff
    ret

.done:
    ld c, $00
    ret

SECTION "Bank 05 AIAddScoresForTwoLists_SealingFoes", ROMX

; First check of AIAddScoresForTwoLists: C = 1 when the AI mode of the actor is below 4; otherwise C
; = $FF. With wAIFlag 0 it returns $FF at once; with it set the foe loop never tests a foe, because
; its slot counter C is loaded with the low byte of wSlotMarks + side ($5F for the foes of slots
; 0-3, $5B for 4-7) instead of the first slot of the side, so CheckSlotStatusBlock rejects all three
; (slot 8 or more) and the wSlotMarks, SlotActionIs9C33Or92Or93 and
; SlotResistances5EntryHasBits2And3_Bank05_2 tests that could give C = 0 are never reached. (C2,
; E-0375)
AIAddScoresForTwoLists_SealingFoes::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $04
    jr c, .done3
    ld a, [wAIFlag]
    or a
    jr z, .done
    ld a, [wBattleActor]
    and $04
    xor $04
    ld de, wSlotMarks
    add e
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
    cp $02
    jr nz, .next
    call SlotActionIs9C33Or92Or93
    jr nz, .next
    call SlotResistances5EntryHasBits2And3_Bank05_2
    jr nz, .done2

.next:
    inc de
    inc c
    dec b
    jr nz, .loop

.done:
    ld c, $ff
    ret

.done2:
    ld c, $00
    ret

.done3:
    ld c, $01
    ret

SECTION "Bank 05 SlotActionIs9C33Or92Or93", ROMX

; C = slot: Z set when the action id byte of its wBattleActionChoice word is SKILL_SEALPRAY,
; SKILL_STOPSPELL, SKILL_DANCESHUT or SKILL_MOUTHSHUT; A = that id and HL points at it.
; AIAddScoresForTwoLists_SealingFoes uses it. (C2, E-0375)
; C = slot: Z set when the slot's chosen action (wBattleActionChoice) is $9C, $33, $92 or $93
; (E-0117)
SlotActionIs9C33Or92Or93::
    ld a, c
    ld hl, wBattleActionChoice
    add a
    add_a_to_hl
    ld a, [hl]
    cp $9c
    ret z
    cp $33
    ret z
    cp $92
    ret z
    cp $93
    ret

SECTION "Bank 05 SlotResistances5EntryHasBits2And3_Bank05_2", ROMX

; C = slot: Z set when the slot's RESIST_LEGSWEEP field (bits 3-2 of wSlotResistances byte 5, 7-byte
; entries) is 3, the strongest level; returns A = that byte & $0C and HL pointing at it. The same
; code is SlotResistances5EntryHasBits2And3_Bank05 later in this bank; this copy is used only by
; AIAddScoresForTwoLists_SealingFoes. (C2, E-0369; probed E-0375)
; C = index: Z set when bits 2 and 3 are both set in the byte at wSlotResistances + $5 + 7 * C
; (7-byte entries); A = that byte & $0C; HL points at it (E-0065) (the same 19 bytes appear in 2
; banks)
SlotResistances5EntryHasBits2And3_Bank05_2::
    ld a, c
    ld hl, wSlotResistances + $5
    add a
    add c
    add a
    add c
    add_a_to_hl
    ld a, [hl]
    and $0c
    cp $0c
    ret

SECTION "Bank 05 FailIfAllyCanUseSkill63Or64", ROMX

; C = 1 when the AI mode of the actor is below 4, C = $FF when wAIFlag is 0. Otherwise C = 0 when
; another slot of the actor side passes CheckSlotStatusBlock, lacks BSTAT1_ATK_DOUBLED, has a
; wSlotMarks value below 3 and can use SKILL_BIATTACK with 3 MP or SKILL_QUADHITS with 6 MP
; (SlotCLacksSkill63Or64WithMP gives no carry); else C = $FF. (C2, E-0375)
; C = 1 when the AI mode is below 4; with wAIFlag set, $00 when another ally that can act knows
; skill $63 or $64 with enough MP; otherwise $FF (E-0127)
FailIfAllyCanUseSkill63Or64:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $04
    jr c, .done3
    ld a, [wAIFlag]
    or a
    jr z, .done
    ld a, [wBattleActor]
    ld d, a
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    cp d
    jr z, .next
    ld a, c
    call CheckSlotStatusBlock
    jr c, .next
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_ATK_DOUBLED, [hl]
    jr nz, .next
    ld a, c
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    cp $03
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
    ld c, $ff
    ret

.done2:
    ld c, $00
    ret

.done3:
    ld c, $01
    ret

SECTION "Bank 05 SlotCLacksSkill63Or64WithMP", ROMX

; C = slot: walks its eight wBattleSkills entries (every other byte, stopping at $FF) and returns no
; carry at the first SKILL_BIATTACK when its MP word is at least 3 or SKILL_QUADHITS when it is at
; least 6; carry when there is none. D = the last cost tested, E counts down. (C2, E-0375)
; carry unless slot C knows skill $63 with at least 3 MP or $64 with at least 6 MP (E-0125)
SlotCLacksSkill63Or64WithMP::
    ld a, c
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld e, $08

.loop:
    ld a, [hli]
    cp $ff
    jr z, .return_carry
    cp $63
    jr z, .skip
    cp $64
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
    add a
    add_a_to_hl
    ld a, [hli]
    sub d
    ld a, [hl]
    sbc $00
    pop hl
    jr c, .loop2
    ret

SECTION "Bank 05 AIAddScoresForTwoLists_OtherAllies", ROMX

; Second check of AIAddScoresForTwoLists: C = 1 when the AI mode of the actor is below 4; C = $FF
; when wAIFlag is 0; otherwise C = 0 when some ally other than the actor that is not blocked
; (CheckSlotStatusBlock), is marked below 3 in wSlotMarks and gets no carry from
; SlotCHasMP3AndSkill6B does not have its RESIST_LEGSWEEP field (wSlotResistances byte 5 bits 3-2)
; at level 3 (SlotResistances5EntryHasBits2And3_Bank05); C = $FF otherwise. SlotCHasMP3AndSkill6B
; gives carry for under 3 MP and also when SKILL_EVILSLASH is missing and its eighth entry is below
; $6B, so the skill list does matter. (C2, E-0375)
AIAddScoresForTwoLists_OtherAllies::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $04
    jr c, .done3
    ld a, [wAIFlag]
    or a
    jr z, .done
    ld a, [wBattleActor]
    ld d, a
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    cp d
    jr z, .next
    call CheckSlotStatusBlock
    jr c, .next
    ld a, c
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    cp $03
    jr nc, .next
    call SlotCHasMP3AndSkill6B
    jr c, .next
    call SlotResistances5EntryHasBits2And3_Bank05
    jr nz, .done2

.next:
    inc c
    dec b
    jr nz, .loop

.done:
    ld c, $ff
    ret

.done2:
    ld c, $00
    ret

.done3:
    ld c, $01
    ret

SECTION "Bank 05 SlotCHasMP3AndSkill6B", ROMX

; C = slot: carry when its MP word is below 3. Otherwise it scans its eight wBattleSkills entries
; (every other byte): Z, no carry and A = 0 when SKILL_EVILSLASH is among them; when it is not, NZ
; with the carry of the last compare (set when the eighth id is below $6B).
; AIAddScoresForTwoLists_OtherAllies skips allies on carry. (C2, E-0375)
; carry when slot C has under 3 MP; otherwise Z when skill $6B is among its eight skills (E-0124)
SlotCHasMP3AndSkill6B::
    ld a, c
    ld hl, wBattleMP
    add a
    add_a_to_hl
    ld a, [hli]
    sub $03
    ld a, [hl]
    sbc $00
    ret c
    ld a, c
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld e, $08

.loop:
    ld a, [hli]
    cp $6b
    jr z, .return_0
    inc hl
    dec e
    jr nz, .loop
    dec e
    ret

.return_0:
    xor a
    ret

SECTION "Bank 05 SlotResistances5EntryHasBits2And3_Bank05", ROMX

; C = slot: Z set when its RESIST_LEGSWEEP field (wSlotResistances byte 5 bits 3-2, 7-byte records)
; is 3; A = that byte & $0C and HL points at it. The same code as
; SlotResistances5EntryHasBits2And3_Bank05_2; AIAddScoresForTwoLists_OtherAllies uses this copy.
; (C2, E-0375)
; C = index: Z set when bits 2 and 3 are both set in the byte at wSlotResistances + $5 + 7 * C
; (7-byte entries); A = that byte & $0C; HL points at it (E-0065) (the same 19 bytes appear in 2
; banks)
SlotResistances5EntryHasBits2And3_Bank05::
    ld a, c
    ld hl, wSlotResistances + $5
    add a
    add c
    add a
    add c
    add_a_to_hl
    ld a, [hl]
    and $0c
    cp $0c
    ret

SECTION "Bank 05 FailIfFoeHurtAndHealerCanCast", ROMX

; C = 1 when the AI mode of the actor is below 4. Otherwise, at the first present foe whose HP is at
; most half its max HP (2 * HP <= max), it checks every slot of that side: C = 0 when one passes
; CheckSlotStatusBlock, has wSlotPersonalityLo at least $C0 and SlotCHasCastableHealSkill gives no
; carry; C = $FF otherwise, and when no foe is that hurt. (C2, E-0375)
; C = 1 when the AI mode is below 4; otherwise $00 when an occupied foe has HP at most half and a
; foe with personality Lo >= $C0 can cast a heal (SlotCHasCastableHealSkill), else $FF (E-0128)
FailIfFoeHurtAndHealerCanCast:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $04
    jr c, .done3
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wBattleHP
    add a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    sla e
    rl d
    ld a, c
    ld hl, wBattleMaxHP
    add a
    add_a_to_hl
    ld a, [hli]
    sub e
    ld a, [hl]
    sbc d
    jr nc, .skip

.next:
    inc c
    dec b
    jr nz, .loop
    jr .done

.skip:
    ld a, c
    and $04
    ld c, a
    ld b, $03

.loop2:
    ld a, c
    call CheckSlotStatusBlock
    jr c, .next2
    ld hl, wSlotPersonalityLo
    add_a_to_hl
    ld a, [hl]
    cp $c0
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
    ld c, $ff
    ret

.done2:
    ld c, $00
    ret

.done3:
    ld c, $01
    ret

SECTION "Bank 05 SlotCHasCastableHealSkill", ROMX

; C = slot: walks eight entries, every other byte and stopping at $FF, from wBattleTargetChoice + 16
; * C (not the wBattleSkills list), and returns no carry at the first heal the slot could use:
; SKILL_HEAL ... SKILL_HEALUSALL when TestSlotStatus1Bit0OrSideFlagBit3 gives Z, SKILL_LIFEDANCE or
; SKILL_HUSTLE when TestSlotStatus1Bit6 gives Z, or SKILL_LOVERAIN; the id must not equal
; wQueuedActionId and the MP word must reach the cost SlotCHasCastableHealSkill_Data[index]. The
; index is 5, 6 or 7 for the last three, but id - $1B for $16-$1A, which wraps to $FB-$FF and reads
; bytes after the table (costs 1, 36, 6, 8, 250) instead of 2, 5, 7, 18, 36. Carry when nothing
; qualifies. (C2, E-0375)
; carry unless slot C has a heal skill ($16-$1A, $7B, $7C or $A1) that its status allows, is not the
; queued action, and whose MP cost (SlotCHasCastableHealSkill_Data) it can pay (E-0128)
SlotCHasCastableHealSkill::
    ld a, c
    ld hl, wBattleTargetChoice
    swap a
    add_a_to_hl
    ld b, $08

.loop:
    ld a, [hli]
    cp $ff
    jr z, .return_carry
    ld e, a
    cp $16
    jr c, .loop2
    ld d, $1b
    cp $1b
    jr c, .call_test_slot_status1_bit0_or_side_flag_bit3
    ld d, $05
    cp $7b
    jr z, .call_test_slot_status1_bit6
    ld d, $06
    cp $7c
    jr z, .call_test_slot_status1_bit6
    ld d, $07
    cp $a1
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
    sub d
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
    cp e
    jr z, .loop2
    ld a, d
    push hl
    ld hl, SlotCHasCastableHealSkill_Data
    add_a_to_hl
    ld d, [hl]
    ld a, c
    ld hl, wBattleMP
    add a
    add_a_to_hl
    ld a, [hli]
    sub d
    ld a, [hl]
    sbc $00
    pop hl
    jr c, .loop2
    ret

SECTION "Bank 05 TestSlotStatus1Bit0OrSideFlagBit3", ROMX

; C = slot: NZ when it has BSTAT1_SPELLS_SEALED; otherwise the flags of testing bit 3 of its side
; byte (wSideFlags0 for slots 0-3, wSideFlags1 for 4-7): NZ when set, Z when clear. HL points at the
; byte tested. SlotCHasCastableHealSkill uses it for the Heal skills. (C2, E-0375)
; C = slot: NZ when its status byte 1 bit 0 is set; otherwise the result of testing bit 3 of its
; side flag (wSideFlags0 for slots 0-3, wSideFlags1 for 4-7) (E-0117)
TestSlotStatus1Bit0OrSideFlagBit3::
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_SPELLS_SEALED, [hl]
    ret nz
    ld a, c
    rrca
    rrca
    and $01
    ld hl, wSideFlags0
    add_a_to_hl
    bit 3, [hl]
    ret

SECTION "Bank 05 TestSlotStatus1Bit6", ROMX

; C = slot: Z clear when it has BSTAT1_DANCE_SEALED (status byte 1 bit 6); HL points at that byte.
; SlotCHasCastableHealSkill uses it for SKILL_LIFEDANCE and SKILL_HUSTLE. (C2, E-0375)
; C = slot: Z clear when bit 6 of its status byte 1 (wBattleStatus1) is set; HL points at the byte
; (E-0114)
TestSlotStatus1Bit6::
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_DANCE_SEALED, [hl]
    ret

SECTION "Bank 05 SlotCHasCastableHealSkill_Data", ROMX

; Eight bytes, $02, $05, $07, $12, $24, $01, $0C, $1C, read as MP costs. SlotCHasCastableHealSkill
; takes the cost at index 5, 6 or 7 for SKILL_LIFEDANCE, SKILL_HUSTLE and SKILL_LOVERAIN ($01, $0C,
; $1C), but for the five heal skills $16-$1A it computes id - $1B, which wraps to $FB-$FF and reads
; bytes after the table, so entries 0-4 are never indexed by this reader; they look like the costs
; of the five heal skills ($02, $05, $07, $12, $24). (C1, E-0381)
SlotCHasCastableHealSkill_Data::
    db $02, $05, $07, $12, $24, $01, $0c, $1c

; C = 1 when the AI mode of the actor is below 4. Otherwise C = 0 when a present foe has status byte
; 2 & $2A clear (BSTAT2_BOUNCE, BSTAT2_AQUA_WALL, BSTAT2_MAGIC_BACK) and its RESIST_BEAT field
; (wSlotResistances byte 2 bits 5-4) at 0; else C = $FF. (C2, E-0375)
; C = 1 when the AI mode is below 4; otherwise $00 when an occupied foe without status 1 mask $2A
; has bits 4-5 of its wSlotResistances + $2 byte clear, else $FF (E-0125) (E-0340: the address in
; its name read as its RAM name; was AIGateFoeSlotResistances2Bits45)
AIGateFoeSlotResistances2Bits45::
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $04
    jr c, .done2
    ld a, [wBattleActor]
    and $04
    xor $04
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
    and $2a
    jr nz, .next
    ld a, c
    ld hl, wSlotResistances + $2
    add a
    add c
    add a
    add c
    add_a_to_hl
    ld a, [hl]
    and $30
    jr z, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $ff
    ret

.done:
    ld c, $00
    ret

.done2:
    ld c, $01
    ret

SECTION "Bank 05 CheckAIFlagSetModeGated", ROMX

; C = 1 when the AI mode of the actor is below 3; otherwise C = 0 when wAIFlag is non-zero and C =
; $FF when it is zero. (C2, E-0375)
; C = 1 when wSlotAIMode[actor] (the AI mode) is below 3; otherwise C = 0 when wAIFlag is non-zero,
; $FF when it is zero (E-0092)
CheckAIFlagSetModeGated:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $03
    jr c, .done2
    ld a, [wAIFlag]
    or a
    jr nz, .done
    ld c, $ff
    ret

.done:
    ld c, $00
    ret

.done2:
    ld c, $01
    ret

SECTION "Bank 05 AIScore_AquaWall_Conditions_NotYetSet", ROMX

; AquaWall AI condition: fails when the actor already has BSTAT2_AQUA_WALL. (C2, E-0357; probed
; E-0375)
AIScore_AquaWall_Conditions_NotYetSet:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit BSTAT2_AQUA_WALL, [hl]
    jr nz, .done
    ld c, $ff
    ret

.done:
    ld c, $00
    ret

SECTION "Bank 05 UnreferencedEstimateWeakestFoeHit", ROMX

; C = 1 (through UnreferencedResultC1) when the AI mode of the actor is below 2. Otherwise it keeps
; in DE the LOWEST ATK of the opposite slots that CheckSlotStatusBlock accepts (DE starts at $FFFF
; and takes smaller values), subtracts half the DEF of the actor (at least 1 is kept) and subtracts
; that from the HP of the actor into HL; every path returns C = $FF. No caller was found in src/.
; (C2, E-0375)
; C = 1 when the actor's AI mode is below 2; otherwise takes the highest ATK of the three opposing
; slots without a status block, subtracts half the actor's DEF (at least 1) and subtracts that from
; the actor's HP, but both outcomes return C = $FF; no caller found (E-0237)
UnreferencedEstimateWeakestFoeHit:: ; configured code entry (E-0237); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $02
    jr c, UnreferencedResultC1
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03
    ld de, -1

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
    and e
    cp $ff
    jr z, .done
    ld a, [wBattleActor]
    call GetBattleDEF_Bank05
    srl h
    rr l
    ld a, e
    sub l
    ld e, a
    ld a, d
    sbc h
    ld d, a
    bit 7, a
    jr z, .read_battle_actor
    ld de, $0001

.read_battle_actor:
    ld a, [wBattleActor]
    call GetBattleHP_Bank05
    ld a, l
    sub e
    ld l, a
    ld a, h
    sbc d
    ld h, a
    bit 7, a
    jr nz, .done

.done:
    ld c, $ff
    ret

SECTION "Bank 05 UnreferencedReturnC0", ROMX

; Sets C = 0 and returns. It sits after the last ret of UnreferencedEstimateWeakestFoeHit; no jump
; or call to it was found. (C2, E-0375)
; ld c, $00 / ret after UnreferencedEstimateWeakestFoeHit's ret; nothing reaches it (E-0237)
; (E-0344: the address in its name dropped or read as the label there; was UnreferencedReturnC0)
UnreferencedReturnC0:: ; configured code entry (E-0237); C0
    ld c, $00
    ret

SECTION "Bank 05 UnreferencedResultC1", ROMX

; Sets C = 1 and returns. UnreferencedEstimateWeakestFoeHit jumps here when the AI mode of the actor
; is below 2 (jr c), so it is reached from that unreferenced routine. (C2, E-0375)
UnreferencedResultC1::
    ld c, $01
    ret

SECTION "Bank 05 AIScore_Curse_Conditions_FoeNotCursed", ROMX

; Curse AI condition: passes when some present foe is not yet cursed (status 0 bit 5). (C2, E-0357;
; probed E-0375)
AIScore_Curse_Conditions_FoeNotCursed:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
    ld hl, wBattleStatus
    ld e, $20
    ld b, $03
    call AnySlotLacksStatusMask
    ret

SECTION "Bank 05 AIScore_SuckAir_Conditions_SkillFlagCheck", ROMX

; Condition of AIScore_SuckAir_Conditions, as written: steps through the actor's eight skill ids at
; wBattleSkillsPrefix + 16 * actor, storing each in wRecordBuffer, and each time calls
; SlotHasSkillWithFlagD with D = $02; but that routine reads slot C's list itself (overwriting
; wRecordBuffer), and C here is the $FF left by ActorLacksStatus4Bits45, so every pass tests the
; same eight bytes from wBattleSkills + $FF. C = $FF when that finds flag $02, else C = 0;
; wRecordBuffer is restored. (C2, E-0369; probed E-0375)
AIScore_SuckAir_Conditions_SkillFlagCheck:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
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
    ld a, [hli]
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
    ld c, $ff
    ret

SECTION "Bank 05 AnyAllyHPBelow", ROMX

; C = $FF when a present slot on the actor side (the actor included) has HP below the threshold
; AnyAllyHPBelow_HealThreshold gives for the skill in wRecordBuffer, else C = 0. Condition routines
; in bank $05 reset the score with ResetAISkillScore when it gives 0. (C2, E-0375)
; C = $FF when an occupied ally's HP is below AnyAllyHPBelow_HealThreshold for it, else $00 (E-0125)
; (E-0344: the address in its name dropped or read as the label there; was AnyAllyHPBelow)
AnyAllyHPBelow:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .call_any_ally_hp_below_heal_threshold

.next:
    inc c
    dec b
    jr nz, .loop
    jr .done

.call_any_ally_hp_below_heal_threshold:
    push bc
    ld a, c
    call AnyAllyHPBelow_HealThreshold
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
    ld c, $ff
    ret

SECTION "Bank 05 AnyAllyHPBelow_HealThreshold", ROMX

; A = slot: returns HL = the HP threshold AnyAllyHPBelow compares that slot's HP with, by the skill
; id in wRecordBuffer: three quarters of max HP (max / 2 + max / 4) for SKILL_HEALMORE,
; SKILL_HEALUS, SKILL_HUSTLE and SKILL_LOVERAIN; two thirds (max / 3 * 2) for SKILL_HEALALL and
; SKILL_HEALUSALL; max HP minus a tenth for SKILL_HEAL and every other skill. BC kept. (C2, E-0369;
; probed E-0375)
AnyAllyHPBelow_HealThreshold::
    push bc
    call GetBattleMaxHP_Bank05
    ld a, [wRecordBuffer]
    cp $16
    jr z, .call_divide_hl_by_a
    cp $17
    jr z, .skip
    cp $18
    jr z, .call_divide_hl_by_a2
    cp $19
    jr z, .skip
    cp $1a
    jr z, .call_divide_hl_by_a2
    cp $7c
    jr z, .skip
    cp $a1
    jr z, .skip

.call_divide_hl_by_a:
    push hl
    ld a, $0a
    call DivideHLByA
    ld b, h
    ld c, l
    pop hl
    ld a, l
    sub c
    ld l, a
    ld a, h
    sbc b
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

SECTION "Bank 05 AIScore_MPass_AnyAllyMPAboveMax", ROMX

; MPass AI condition: C = $FF when some present ally other than the actor has MP ABOVE its max MP,
; else C = 0. It compares max MP (HL) with MP (BC) and takes the carry, so the test is reversed from
; what the name says. (C2, E-0375)
AIScore_MPass_AnyAllyMPAboveMax:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    ld e, a
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    cp e
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
    ld c, $ff
    ret

SECTION "Bank 05 MPBandOfSlotTemp0", ROMX

; hTemp0 = battle slot: the MP version of HPBandOfSlotTemp0. C = 0 when its MP is at least 2/3 of
; its max MP, 1 when at least 1/2, 2 when at least 1/3, 3 when at least 1/4, 4 when at least 1/10,
; else 5 (thresholds rounded down; GetBattleMP_Bank05, GetBattleMaxMP_Bank05); HL = the MP on
; return. No caller was found in src/. (C2, E-0375)
; the same instruction sequence as HPBandOfSlotTemp0 (bank $05) apart from label operands, which
; refer to this bank's own routines and tables; the twin's note describes the shape (E-0107)
; (E-0344: the address in its name dropped or read as the label there; was MPBandOfSlotTemp0)
MPBandOfSlotTemp0:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
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
    ld a, $0a
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

SECTION "Bank 05 AIScore_MegaMagic_FoeHPPlusDEFHigh", ROMX

; MegaMagic AI condition: passes when some present foe has HP + DEF of at least $578 (1,400); C = 1
; below AI mode 3. (C2, E-0357; probed E-0375)
AIScore_MegaMagic_FoeHPPlusDEFHigh:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $03
    jr c, .done3
    ld a, [wBattleActor]
    and $04
    xor $04
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
    ld c, $ff
    ret

.done3:
    ld c, $01
    ret

SECTION "Bank 05 AnyFoeHasSkillWithFlagD", ROMX

; C = $FF when a present foe without BSTAT1_BREATH_SEALED has a skill whose record byte 5 has bit 4
; set (SlotCSkillFlagMatchD with D = $10, which skips SKILL_SUCKAIR and SKILL_SUCKALL), else C = 0.
; wRecordBuffer is saved and restored. In the skill records in the ROM that bit is set for $40-$47
; and $71-$74 besides the two skipped skills. (C2, E-0375)
; C = $FF when an occupied foe without status bit 7 has a skill matching flag D = $10
; (SlotCSkillFlagMatchD), else $00 (wRecordBuffer preserved) (E-0125)
AnyFoeHasSkillWithFlagD:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wRecordBuffer]
    push af
    ld a, [wBattleActor]
    and $04
    xor $04
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
    bit BSTAT1_BREATH_SEALED, [hl]
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
    ld c, $ff
    ret

SECTION "Bank 05 SlotCSkillFlagMatchD", ROMX

; C = slot, D = mask: loads record byte 5 of each of the eight skills of the slot (every other byte
; of wBattleSkills + 16 * C, skipping SKILL_SUCKAIR and SKILL_SUCKALL) into hTemp0 with
; LoadSkillRecordPart (wBattleArg0 = 5, wBattleArg1 = 1, wBattleArg2/3 = hTemp0, wRecordBuffer = the
; skill) and returns NZ with A = hTemp0 & D at the first non-zero match, else A = 0 and Z. BC and D
; are kept. (C2, E-0375)
; NZ when one of slot C's skills (other than $89 and $9D) has record byte 5 matching mask D (E-0125)
SlotCSkillFlagMatchD::
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
    cp $89
    jr z, .next
    cp $9d
    jr z, .next
    push bc
    push hl
    ld [wRecordBuffer], a
    farcall LoadSkillRecordPart
    pop hl
    pop bc
    ldh a, [hTemp0]
    and c
    jr nz, .done

.next:
    inc hl
    inc hl
    dec b
    jr nz, .loop
    xor a

.done:
    ld d, c
    pop bc
    ret

SECTION "Bank 05 AllyCheckSide0FlagAndOtherSlots", ROMX

; C = 0 when the actor side byte (wSide0Flag for slots 0-3, wSide1Flag for 4-7) is 1 or when no
; other slot of the actor side is present; C = $FF when another ally is present and the side byte is
; not 1. Callers add a weight row (AddAIWeight or AddAIWeightToScore2) when it gives 0, and
; condition routines in bank $05 reset the score with ResetAISkillScore instead. (C2, E-0375)
; C = $00 when the side's wSide0Flag/wSide1Flag flag is 1 or no other ally slot is occupied, else
; $FF (E-0125)
AllyCheckSide0FlagAndOtherSlots:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    cp $04
    jr nc, .check_side1_flag
    ld a, [wSide0Flag]
    jr .cp_01

.check_side1_flag:
    ld a, [wSide1Flag]

.cp_01:
    cp $01
    jr z, .done
    ld a, [wBattleActor]
    ld e, a
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    cp e
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
    ld c, $ff
    ret

SECTION "Bank 05 CheckBattleKindAtLeast2OrLinkModeSet", ROMX

; C = 0 when wLinkMode is 0 and wBattleKind is below 2, else C = $FF. AIScore_Fight adds weight row
; $66 when it gives 0; condition routines in bank $05 reset the score with ResetAISkillScore
; instead. (C2, E-0375)
; C = 0 when wLinkMode is 0 and wBattleKind is below 2, else C = $FF (E-0100)
CheckBattleKindAtLeast2OrLinkModeSet::
    ld a, [wLinkMode]
    or a
    jr nz, .done
    ld a, [wBattleKind]
    cp $02
    jr nc, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 FoeHPCheckReadsWrongSlot", ROMX

; Meant to give C = 0 when the HP of a foe is below 4 times its wAIDamageEstimates word. It never
; advances C, so it tests the first slot opposite the actor three times; when that slot is present
; it takes the word E at wAIDamageEstimates + 2 * (slot & 3), and deref_hl leaves the low byte of E
; in A, so GetBattleHP_Bank05 reads the HP of slot E & $FF: C = 0 when that HP is below 4 * E, else
; C = $FF. AIScore_Fight adds weight row $67 when it gives 0. (C2, E-0375)
; meant to give C = $00 when a foe's HP is below 4 * its wAIDamageEstimates word; it never advances
; C (first foe only, three times) and deref_hl leaves the estimate's low byte in A, so
; GetBattleHP_Bank05 reads the HP of that slot number: C = $00 when HP[estimate & $FF] < 4 *
; estimate, else $FF (a likely game bug; executed, test FoeHPCheckReadsWrongSlot) (E-0125, E-0154)
FoeHPCheckReadsWrongSlot::
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    push bc
    ld a, c
    and $03
    ld hl, wAIDamageEstimates
    add a
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
    ld c, $ff
    ret

SECTION "Bank 05 CheckActorSlot0To3OrLinkModeSet", ROMX

; C = 0 when wLinkMode is 0 and the actor is in slots 4-7, else C = $FF. AIScore_Fight adds weight
; row $68 when it gives 0. (C2, E-0375)
; C = 0 when wLinkMode is 0 and the actor is in slots 4-7, else C = $FF (E-0100)
CheckActorSlot0To3OrLinkModeSet::
    ld a, [wLinkMode]
    or a
    jr nz, .done
    ld a, [wBattleActor]
    cp $04
    jr c, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AIScore_Meditate_Conditions_HPBelowTwoThirds", ROMX

; Meditate AI condition: passes when the actor's HP is below two thirds of its max. (C2, E-0357;
; probed E-0375)
AIScore_Meditate_Conditions_HPBelowTwoThirds:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
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
    ld c, $ff
    ret

SECTION "Bank 05 FailIfSkillHasResistanceClass", ROMX

; C = 1 when the AI mode of the actor is below 2 and C = $FF when the skill has no resistance class
; (wRecordBufferData + $1 = 0). Otherwise it walks the resistance level of the present foes for that
; class (AnyFoeNotFullyResistant_Data, Get2BitFieldEOfHL, counting them in hTemp0) and jumps to C =
; 0 on a level of 3, but the end of the loop falls into the same C = 0, so with a class it always
; gives C = 0. The pointer is not advanced between foes, so every pass reads the record of the first
; foe. (C2, E-0375)
; C = 1 when the AI mode is below 2; otherwise $00 when an occupied foe's resistance field for skill
; wRecordBufferData + $1 is 3; $FF when wRecordBufferData + $1 is 0 or none is (E-0127)
FailIfSkillHasResistanceClass:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05_2
    cp $02
    jr c, .done3
    ld a, [wRecordBufferData + $1]
    or a
    jr z, .done2
    dec a
    ld hl, AnyFoeNotFullyResistant_Data
    add a
    add_a_to_hl
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03
    ld hl, wSlotResistances
    add a
    add c
    add a
    add c
    add d
    add_a_to_hl
    xor a
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
    cp $03
    jr z, .done

.next:
    inc c
    dec b
    jr nz, .loop

.done:
    ld c, $00
    ret

.done2:
    ld c, $ff
    ret

.done3:
    ld c, $01
    ret

SECTION "Bank 05 FailIfTwoAlliesBelowHalfHP", ROMX

; C = 1 when the AI mode of the actor is below 3 or when the actor does NOT know SKILL_HEALUS,
; SKILL_HEALUSALL, SKILL_HUSTLE or SKILL_LOVERAIN (SkillListHas19Or1AOr7COrA1 gives NZ). Otherwise C
; = 0 when two or more present slots on its side have HP below half their max HP (max halved,
; rounded down), else C = $FF. (C2, E-0375)
; C = 1 when the AI mode is below 3 or the actor knows a heal-all skill; otherwise $00 when two or
; more allies have HP below half, else $FF (E-0127)
FailIfTwoAlliesBelowHalfHP:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp $03
    jr c, .done2
    ld a, [wBattleActor]
    ld hl, wBattleSkillsPrefix
    swap a
    add_a_to_hl
    ld b, $08
    call SkillListHas19Or1AOr7COrA1
    jr nz, .done2
    ld a, [wBattleActor]
    and $04
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
    cp $02
    jr c, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

.done2:
    ld c, $01
    ret

SECTION "Bank 05 SkillListHas19Or1AOr7COrA1", ROMX

; HL = the byte before a skill list, B = how many entries: walks every other byte from HL + 1 and
; returns Z as soon as one is SKILL_HEALUS, SKILL_HEALUSALL, SKILL_HUSTLE or SKILL_LOVERAIN;
; otherwise A = 1 and Z clear. HL ends one byte past the last id read. (C2, E-0375)
; walks B skill numbers at every other byte from HL + 1: Z set as soon as one is $19, $1A, $7C or
; $A1; otherwise A = 1 and Z clear (E-0117)
SkillListHas19Or1AOr7COrA1::
    inc hl
    ld a, [hli]
    cp $19
    ret z
    cp $1a
    ret z
    cp $7c
    ret z
    cp $a1
    ret z
    dec b
    jr nz, SkillListHas19Or1AOr7COrA1
    ld a, $01
    or a
    ret

SECTION "Bank 05 AIScore_Sap_CompareATKWithDEF", ROMX

; Sap AI check: X = twice the average ATK of the present slots on the actor side, Y = the average
; DEF of the present foes. C = $FF when X is at most Y, or when X - Y is at most half the foe
; average HP (their HP sum halved, then divided by their count); C = 0 otherwise. Uses
; hTemp0/hTemp1. (C2, E-0375)
AIScore_Sap_CompareATKWithDEF:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    ld c, a
    ld b, $03
    ld e, $00
    xor a
    ldh [hTemp0], a
    ldh [hTemp1], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call GetBattleATK_Bank05
    ldh a, [hTemp0]
    add l
    ldh [hTemp0], a
    ldh a, [hTemp1]
    adc h
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
    and $04
    xor $04
    ld c, a
    ld b, $03
    ld e, $00
    xor a
    ldh [hTemp0], a
    ldh [hTemp1], a

.loop2:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next2
    call GetBattleDEF_Bank05
    ldh a, [hTemp0]
    add l
    ldh [hTemp0], a
    ldh a, [hTemp1]
    adc h
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
    sub c
    ld l, a
    ld a, h
    sbc b
    ld h, a
    push hl
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03
    ld e, $00
    xor a
    ldh [hTemp0], a
    ldh [hTemp1], a

.loop3:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next3
    call GetBattleHP_Bank05
    ldh a, [hTemp0]
    add l
    ldh [hTemp0], a
    ldh a, [hTemp1]
    adc h
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
    ld c, $ff
    ret

SECTION "Bank 05 AIGateCompareAllyStatAverages", ROMX

; C = 1 when the AI mode of the actor is below 4 or when the actor does NOT know SKILL_HEAL ...
; SKILL_HEALUSALL, SKILL_HUSTLE, SKILL_MEDITATE or SKILL_LOVERAIN (SkillListHasAnyOf16To1AA1 gives
; NZ). Otherwise it averages max HP + max MP + ATK + DEF (AddSlotStatSumToTemp0, 24-bit) over the
; slots of the actor side that are absent with a wBattleSlotOut byte other than $FF (C = 0 when
; there is none), then over the present slots: C = $FF when a quarter of the present average is
; below the absent average (CompareHLToBCFastZero), else C = 0. Uses hTemp0-hTemp4. (C2, E-0375)
; C = 1 when the AI mode is below 4 or the actor knows a heal skill; otherwise compares the stat
; sums of the empty and occupied ally slots and returns $00 or $FF (E-0129)
AIGateCompareAllyStatAverages:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp $04
    jp c, .done3
    ld a, [wBattleActor]
    ld hl, wBattleSkillsPrefix
    swap a
    add_a_to_hl
    ld b, $08
    call SkillListHasAnyOf16To1AA1
    jr nz, .done3
    ld a, [wBattleActor]
    and $04
    ld c, a
    ld b, $03
    ld d, $00
    xor a
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
    or a
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
    and $04
    ld c, a
    ld b, $03
    ld d, $00
    xor a
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
    ld c, $ff
    ret

.done3:
    ld c, $01
    ret

SECTION "Bank 05 SkillListHasAnyOf16To1AA1", ROMX

; HL = the byte before a skill list, B = how many entries: walks every other byte from HL + 1 and
; returns Z as soon as one is SKILL_HEAL ... SKILL_HEALUSALL, SKILL_HUSTLE, SKILL_MEDITATE or
; SKILL_LOVERAIN; otherwise A = 1 and Z clear. (C2, E-0375)
; walks B skill numbers at every other byte from HL + 1: Z as soon as one is $16-$1A, $7C, $9F or
; $A1; otherwise A = 1 and Z clear (E-0120) (E-0344: the address in its name dropped or read as the
; label there; was SkillListHasAnyOf16To1AA1)
SkillListHasAnyOf16To1AA1::
    inc hl
    ld a, [hli]
    cp $16
    ret z
    cp $17
    ret z
    cp $18
    ret z
    cp $19
    ret z
    cp $1a
    ret z
    cp $7c
    ret z
    cp $9f
    ret z
    cp $a1
    ret z
    dec b
    jr nz, SkillListHasAnyOf16To1AA1
    ld a, $01
    or a
    ret

SECTION "Bank 05 AddSlotStatSumToTemp0", ROMX

; C = slot: adds its max HP + max MP + ATK + DEF (summed in 16 bits) to the 24-bit total in
; hTemp0-hTemp2 (low byte first) and increments D; E and BC are kept. AIGateCompareAllyStatAverages
; uses it. (C2, E-0375)
; adds MaxHP + MaxMP + ATK + DEF of slot C to the 24-bit total at hTemp0-hTemp2; D += 1 (E-0121)
AddSlotStatSumToTemp0::
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
    add l
    ldh [hTemp0], a
    ldh a, [hTemp1]
    adc h
    ldh [hTemp1], a
    ldh a, [hTemp2]
    adc $00
    ldh [hTemp2], a
    inc d
    ret

SECTION "Bank 05 AIScore_BiAttack_FoeHPCheck", ROMX

; BiAttack AI check: fails when a present foe's HP is below 120% of its damage estimate
; (wAIDamageEstimates), i.e. a normal attack would already finish it. (C2, E-0357; probed E-0375)
AIScore_BiAttack_FoeHPCheck:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    push bc
    ld a, c
    and $03
    add a
    ld hl, wAIDamageEstimates
    add_a_to_hl
    ld a, [hli]
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
    ld c, $ff
    ret

SECTION "Bank 05 AIScore_Berserker_SpeedAndHPCheck", ROMX

; Check of AIScore_Berserker: C = 1 when the actor's AI mode is below 2; C = $FF when fewer than two
; foes are present or when the actor's AGL is at most 120% of the AGL of the last present foe;
; otherwise C = 0 when that foe's HP is at most twice its wAIDamageEstimates entry, C = $FF when it
; is more. (C2, E-0369; probed E-0375)
AIScore_Berserker_SpeedAndHPCheck:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp $02
    jr c, .done3
    ld a, [wBattleActor]
    and $04
    xor $04
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
    cp $02
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
    and $03
    add a
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
    ld c, $ff
    ret

.done3:
    ld c, $01
    ret

SECTION "Bank 05 AIScore_Ramming_LastFoeHPAndResist", ROMX

; Check of AIScore_Ramming: C = 1 when the actor's AI mode is below 2; C = $FF when fewer than two
; foes are present, when the skill has no resistance class (wRecordBufferData + 1 = 0), or when the
; last present foe's resistance field for that class (AnyFoeNotFullyResistant_Data,
; Get2BitFieldEOfHL) is 2 or more; otherwise C = 0 when that foe's HP is above 60% of the actor's
; HP, C = $FF when it is at most that. (C2, E-0369; probed E-0375)
AIScore_Ramming_LastFoeHPAndResist:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp $02
    jr c, .done2
    ld a, [wBattleActor]
    and $04
    xor $04
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
    cp $02
    jr c, .done
    ld c, e
    ld a, [wRecordBufferData + $1]
    or a
    jr z, .done
    push de
    dec a
    ld hl, AnyFoeNotFullyResistant_Data
    add a
    add_a_to_hl
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, c
    ld b, $03
    ld hl, wSlotResistances
    add a
    add c
    add a
    add c
    add d
    add_a_to_hl
    call Get2BitFieldEOfHL
    cp $02
    pop de
    jr nc, .done
    ld a, e
    call GetBattleHP_Bank05
    push hl
    ld a, [wBattleActor]
    call GetBattleHP_Bank05
    ld a, $3c
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
    ld c, $ff
    ret

.done2:
    ld c, $01
    ret

SECTION "Bank 05 AIScore_Kamikaze_HealerAllyAndFoeHP", ROMX

; Check of AIScore_Kamikaze: C = 1 when the actor's AI mode is below 3; C = $FF in link battles
; (wLinkMode), battle kind 2 or more, with wAIFlag 0, or when no other ally is present with AI mode
; 3 or more, a healing skill id found by AIScore_Kamikaze_CheckSkills (Z), no status block and a
; wSlotMarks value below 3. Otherwise it compares the actor's HP with half of the actor's own HP,
; which never gives carry, so it always returns C = $FF; the foe checks after it (a foe with HP at
; least the actor's HP + 100 whose resistance field is below 2 gives C = 0) are never reached,
; likely a bug where another slot's HP was meant. (C2, E-0369; probed E-0375)
AIScore_Kamikaze_HealerAllyAndFoeHP:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    call ReadSlotAIModeIndexed_Bank05
    cp $03
    jp c, .done3
    ld a, [wLinkMode]
    or a
    jp nz, .done2
    ld a, [wBattleKind]
    cp $02
    jp nc, .done2
    ld a, [wAIFlag]
    or a
    jp z, .done2
    ld a, [wBattleActor]
    ld e, a
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    cp e
    jr z, .next
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    call ReadSlotAIModeIndexed_Bank05
    cp $03
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
    cp $03
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
    and $04
    xor $04
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
    or a
    jr z, .done2
    push bc
    push hl
    dec a
    ld hl, AnyFoeNotFullyResistant_Data
    add a
    add_a_to_hl
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, c
    ld hl, wSlotResistances
    add a
    add c
    add a
    add c
    add d
    add_a_to_hl
    call Get2BitFieldEOfHL
    pop hl
    pop bc
    cp $02
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
    ld c, $ff
    ret

.done3:
    ld c, $01
    ret

SECTION "Bank 05 ActorStatus4CheckReadsAddress", ROMX

; Apparently meant to test the actor status byte 4 & $03 like its neighbours, but it never loads the
; byte: it tests A & 3 where A is the low byte of wBattleStatus4 + 9 * actor that AddAx9ToHL leaves.
; So C = $FF for actor slots 0 and 4 and C = 0 for slots 1, 2, 3, 5, 6 and 7, whatever the status.
; AIScore_Fight adds weight row $05 when it gives 0; condition routines in bank $05 reset the score
; with ResetAISkillScore instead. (C2, E-0375)
; apparently meant to test the actor's status byte 4 (wBattleStatus4 + 9 * actor) & $03 like the
; neighbouring checks, but it never loads the byte: it tests A & 3 where A is the low byte of that
; address left by AddAx9ToHL. So C = $FF for slots 0 and 4 and C = 0 for slots 1, 2, 5 and 6
; whatever the status (a likely bug; executed, test Status4CheckReadsAddress) (E-0075)
ActorStatus4CheckReadsAddress::
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    and $03
    jr z, .done
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AIScore_BiAttack_ATKCheck", ROMX

; BiAttack AI check: passes when 5/4 of the actor's ATK is at least the foes' average DEF, fails
; otherwise. (C2, E-0357; probed E-0375)
AIScore_BiAttack_ATKCheck:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03
    xor a
    ldh [hTemp3], a
    ldh [hTemp4], a
    ldh [hTemp5], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call GetBattleDEF_Bank05
    ldh a, [hTemp4]
    add l
    ldh [hTemp4], a
    ldh a, [hTemp5]
    adc h
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
    ld c, $ff
    ret

SECTION "Bank 05 ActorLacksStatus2Bit1And5Bits01", ROMX

; C = 0 when the actor has BSTAT2_BOUNCE (status byte 2 bit 1) or status byte 5 & $03
; (BSTAT5_RADIANT_BLIND, BSTAT5_SANDSTORM_BLIND) set, else C = $FF. After reading byte 2 with ld a,
; [hli] it steps twice more, so the second byte is 5, not 4 as the name says. AIScore_Fight adds
; weight row $33 to wAISkillScore2 when it gives 0. (C2, E-0375)
; C = 0 when the actor's status byte 2 (wBattleStatus2) bit 1 or byte 4 & $03 is set, else C = $FF
; (E-0072)
ActorLacksStatus2Bit1And5Bits01::
    ld a, [wBattleActor]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    ld a, [hli]
    and $02
    jr nz, .done
    inc hl
    inc hl
    ld a, [hl]
    and $03
    jr z, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $ff
    ret

SECTION "Bank 05 ResistanceAverageGateForAISide", ROMX

; C = 1 when wLinkMode is not 1 and the actor is in slots 4-7. Otherwise as
; PassIfFoesAverageResistanceAtLeast2: C = $FF when the skill has no resistance class
; (wRecordBufferData + $1 = 0); else C = 0 when the present foe levels for that class sum to 0, and
; otherwise C = $FF when their average (DivideBByA) is 2 or more, 0 below. Uses hTemp0/hTemp1. (C2,
; E-0375)
; C = 1 for the player side outside link battles; otherwise like PassIfFoesAverageResistanceAtLeast2
; (E-0128)
ResistanceAverageGateForAISide:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wLinkMode]
    cp $01
    jr z, .check_record_buffer_data
    ld a, [wBattleActor]
    cp $04
    jr nc, .done3

.check_record_buffer_data:
    ld a, [wRecordBufferData + $1]
    or a
    jr z, .done2
    dec a
    ld hl, AnyFoeNotFullyResistant_Data
    add a
    add_a_to_hl
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03
    ld hl, wSlotResistances
    add a
    add c
    add a
    add c
    add d
    add_a_to_hl
    xor a
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
    add d
    ldh [hTemp1], a

.skip:
    ld a, l
    add $07
    ld l, a
    ld a, h
    adc $00
    ld h, a
    inc c
    dec b
    jr nz, .loop
    ldh a, [hTemp1]
    or a
    jr z, .done
    ld b, a
    ldh a, [hTemp0]
    call DivideBByA
    ld a, b
    cp $02
    jr nc, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $ff
    ret

.done3:
    ld c, $01
    ret

SECTION "Bank 05 ResistanceAverageGateForFoeAIMode3", ROMX

; C = 1 when wLinkMode is 1, when the actor is in slots 0-3, or when its AI mode is below 3.
; Otherwise as PassIfFoesAverageResistanceAtLeast2: C = $FF when the skill has no resistance class
; (wRecordBufferData + $1 = 0); else C = 0 when the present foe levels for that class sum to 0, and
; otherwise C = $FF when their average (DivideBByA) is 2 or more, 0 below. Uses hTemp0/hTemp1. (C2,
; E-0375)
; C = 1 in link battles, for the player side, or when the AI mode is below 3; otherwise like
; PassIfFoesAverageResistanceAtLeast2 (E-0128)
ResistanceAverageGateForFoeAIMode3:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wLinkMode]
    cp $01
    jr z, .done3
    ld a, [wBattleActor]
    cp $04
    jr c, .done3
    call ReadSlotAIModeIndexed_Bank05_2
    cp $03
    jr c, .done3
    ld a, [wRecordBufferData + $1]
    or a
    jr z, .done2
    dec a
    ld hl, AnyFoeNotFullyResistant_Data
    add a
    add_a_to_hl
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03
    ld hl, wSlotResistances
    add a
    add c
    add a
    add c
    add d
    add_a_to_hl
    xor a
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
    add d
    ldh [hTemp1], a

.skip:
    ld a, l
    add $07
    ld l, a
    ld a, h
    adc $00
    ld h, a
    inc c
    dec b
    jr nz, .loop
    ldh a, [hTemp1]
    or a
    jr z, .done
    ld b, a
    ldh a, [hTemp0]
    call DivideBByA
    ld a, b
    cp $02
    jr nc, .done2

.done:
    ld c, $00
    ret

.done2:
    ld c, $ff
    ret

.done3:
    ld c, $01
    ret

SECTION "Bank 05 ResetAISkillScore", ROMX

; Starts the AI score of a skill: the word wAISkillScore = 0 and the word wAISkillScore2 = $FFFF.
; Condition routines (AIFireSkillUsable, AIHealUsable, AIScore_Beat_Conditions and others) call it
; on their failing branch. (C2, E-0375)
; wAISkillScore = wAISkillScore + $1 = 0 and wAISkillScore2 = wAISkillScore2 + $1 = $FF
ResetAISkillScore::
    xor a
    ld [wAISkillScore], a
    ld [wAISkillScore + $1], a
    ld a, $ff
    ld [wAISkillScore2], a
    ld [wAISkillScore2 + $1], a
    ret

SECTION "Bank 05 AddBCToAISkillScore", ROMX

; The word wAISkillScore += BC (16-bit, the carry out of the high byte is lost). No caller was found
; in src/. (C2, E-0375)
; the word wAISkillScore/wAISkillScore + $1 += BC (E-0094)
AddBCToAISkillScore:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wAISkillScore]
    add c
    ld [wAISkillScore], a
    ld a, [wAISkillScore + $1]
    adc b
    ld [wAISkillScore + $1], a
    ret

SECTION "Bank 05 AddBCToAISkillScore2", ROMX

; The word wAISkillScore2 += BC (16-bit, the carry out is lost). No caller was found in src/. (C2,
; E-0375)
; the word wAISkillScore2/wAISkillScore2 + $1 += BC (E-0094)
AddBCToAISkillScore2:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wAISkillScore2]
    add c
    ld [wAISkillScore2], a
    ld a, [wAISkillScore2 + $1]
    adc b
    ld [wAISkillScore2 + $1], a
    ret

SECTION "Bank 05 ReadSlotAIModeIndexed_Bank05_2", ROMX

; A = battle slot: returns A = its AI mode, the byte at wSlotAIMode + A; HL points at it. Many AI
; checks in this bank gate on it (C = 1 below a set mode). The same code is
; ReadSlotAIModeIndexed_Bank05. (C2, E-0375)
; A = the byte at wSlotAIMode + A; clobbers HL (the same 10 bytes appear in 13 banks)
ReadSlotAIModeIndexed_Bank05_2::
    ld hl, wSlotAIMode
    add_a_to_hl
    ld a, [hl]
    ret

SECTION "Bank 05 AIScore_Upper_Conditions_AnyAllyRaisable_CanRaise", ROMX

; A = C = slot: whether that slot's DEF can still be raised: A = 0 and no carry when its DEF is 999
; or more; otherwise carry while DEF is below its base DEF (GetBaseDEF, in wBattleStatResultLo and
; wBattleStatResultHi) times 4, or times 2 for slots 4-7 when wLinkMode is 0 or 2; no carry
; otherwise. (C2, E-0369; probed E-0375)
AIScore_Upper_Conditions_AnyAllyRaisable_CanRaise:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call GetBattleDEF_Bank05
    ld a, l
    sub $e7
    ld a, h
    sbc $03
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
    or a
    jr z, .skip
    cp $02
    jr nz, .skip2

.skip:
    ld a, c
    cp $04
    jr nc, .skip3

.skip2:
    sla e
    rl d

.skip3:
    ld a, e
    sub l
    ld a, d
    sbc h
    jr nc, .return_carry

.return_0:
    xor a
    ret

.return_carry:
    scf
    ret

SECTION "Bank 05 AIScore_Speed_Conditions_AnyAllyRaisable_CanRaise", ROMX

; A = C = slot: whether that slot's AGL can still be raised: A = 0 and no carry when its AGL is 999
; or more; otherwise carry while AGL is below its base AGL (GetBaseAGL, in wBattleStatResultLo and
; wBattleStatResultHi) times 4, or times 2 for slots 4-7 when wLinkMode is 0 or 2; no carry
; otherwise. (C2, E-0369; probed E-0375)
AIScore_Speed_Conditions_AnyAllyRaisable_CanRaise:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call GetBattleAGL_Bank05
    ld a, l
    sub $e7
    ld a, h
    sbc $03
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
    or a
    jr z, .skip
    cp $02
    jr nz, .skip2

.skip:
    ld a, c
    cp $04
    jr nc, .skip3

.skip2:
    sla e
    rl d

.skip3:
    ld a, e
    sub l
    ld a, d
    sbc h
    jr nc, .return_carry

.return_0:
    xor a
    ret

.return_carry:
    scf
    ret

SECTION "Bank 05 CompareHPWithThreeQuartersMax", ROMX

; C = slot: compares its HP with (3 * max HP) / 4 (the halvings use sra, a signed shift): carry when
; the HP is below, Z when equal (CompareHLToBC); BC kept. (C2, E-0375)
; C = slot: compares its HP with 3/4 of its max HP (CompareHLToBC): carry when below; BC kept
; (E-0120)
CompareHPWithThreeQuartersMax:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
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

SECTION "Bank 05 CompareHPWithHalfMax", ROMX

; A = the slot whose max HP is used, C = the slot whose HP is used (callers would pass the same
; slot): compares 2 * HP with the max HP (CompareHLToBC): carry when the HP is below 1/2 of max, Z
; when exactly 1/2; BC kept. No caller was found in src/. (C2, E-0375)
; A = slot whose max HP is used, C = slot whose HP is used (callers normally pass the same slot):
; compares 2 x HP with the max HP (CompareHLToBC): carry set when HP is below 1/2 of max, Z when
; exactly 1/2; BC kept (E-0094)
CompareHPWithHalfMax:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
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

SECTION "Bank 05 CompareHPWithQuarterMax", ROMX

; A = the slot whose max HP is used, C = the slot whose HP is used (callers would pass the same
; slot): compares 4 * HP with the max HP (CompareHLToBC): carry when the HP is below 1/4 of max, Z
; when exactly 1/4; BC kept. No caller was found in src/. (C2, E-0375)
; A = slot whose max HP is used, C = slot whose HP is used (callers normally pass the same slot):
; compares 4 x HP with the max HP (CompareHLToBC): carry set when HP is below 1/4 of max, Z when
; exactly 1/4; BC kept (E-0094)
CompareHPWithQuarterMax:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
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

SECTION "Bank 05 CompareHPWithTenthMax", ROMX

; A = the slot whose max HP is used, C = the slot whose HP is used (callers would pass the same
; slot): compares 10 * HP with the max HP (CompareHLToBC): carry when the HP is below 1/10 of max, Z
; when exactly 1/10; BC kept. No caller was found in src/. (C2, E-0375)
; A = slot whose max HP is used, C = slot whose HP is used (callers normally pass the same slot):
; compares 10 x HP with the max HP (CompareHLToBC): carry set when HP is below 1/10 of max, Z when
; exactly 1/10; BC kept (E-0094)
CompareHPWithTenthMax:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
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

SECTION "Bank 05 CompareSlotHPWith1", ROMX

; A = slot: NZ (A = the high byte) when its HP word is 256 or more; otherwise compares the low byte
; with 1: Z when the HP is 1, carry when it is 0. HL = the HP. (C2, E-0375)
; A = slot: returns NZ when its HP (GetBattleHP_Bank05) is 256 or more; otherwise compares the low
; byte with 1: Z when HP = 1, carry when HP = 0 (E-0114)
CompareSlotHPWith1::
    call GetBattleHP_Bank05
    ld a, h
    or a
    ret nz
    ld a, l
    cp $01
    ret

SECTION "Bank 05 SlotHasSkillWithFlagD", ROMX

; C = slot, D = mask: for each of the eight skills of the slot (every other byte of wBattleSkills +
; 16 * C, none skipped, no $FF stop) it loads record byte 5 into hTemp0 (LoadSkillRecordPart with
; wBattleArg0 = 5, wBattleArg1 = 1, wRecordBuffer = the skill) and returns A = hTemp0 & D, NZ, at
; the first non-zero result; else A = 0 and Z. BC and D are kept; wRecordBuffer is left at the last
; skill tested. (C2, E-0375)
; C = slot, D = mask: walks the slot's 8 skill numbers (every other byte of the 16 bytes at
; wBattleSkills + 16 * C), loading part of each skill record into hTemp0 (LoadSkillRecordPart with
; wBattleArg0 = 5, wBattleArg1 = 1); returns A = hTemp0 & D for the first skill with a masked bit
; set, else A = 0; BC kept (E-0092)
SlotHasSkillWithFlagD::
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
    and c
    jr nz, .done
    inc hl
    inc hl
    dec b
    jr nz, .loop
    xor a

.done:
    ld d, c
    pop bc
    ret

SECTION "Bank 05 CountSkillsWithZeroRecordByte1", ROMX

; C = slot: walks eight CONSECUTIVE bytes from wBattleSkills + 16 * C (it steps HL once per pass, so
; it reads the first four skill ids and the bytes after them), skips $FF, and counts the ids whose
; skill record byte 1 is 0 (LoadSkillRecordPart with wBattleArg0 = 1, wBattleArg1 = 1 into hTemp0).
; Returns A = the count, Z when 0; BC kept. No caller was found in src/. (C2, E-0375)
; A = how many of slot C's skills have record byte 1 = 0 (flags from A) (E-0125)
CountSkillsWithZeroRecordByte1:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
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
    cp $ff
    jr z, .next
    push bc
    push hl
    ld [wRecordBuffer], a
    farcall LoadSkillRecordPart
    pop hl
    pop bc
    ldh a, [hTemp0]
    or a
    jr nz, .next
    inc c

.next:
    inc hl
    dec b
    jr nz, .loop
    ld a, c
    or a
    pop bc
    ret

SECTION "Bank 05 Get2BitFieldEOfHL", ROMX

; E = field number: A = bits 1-0 of [HL] for field 0, bits 3-2 for 1, bits 5-4 for 2 and bits 7-6
; for 3 or any other E, moved down to bits 1-0; HL and E kept. The resistance checks use it on
; wSlotResistances bytes (AnyFoeNotFullyResistant_Data gives the field). (C2, E-0375)
; E = field number: A = bits 1-0 of [HL] for field 0, bits 3-2 for 1, bits 5-4 for 2, bits 7-6 for 3
; (moved down to bits 1-0) (E-0092)
Get2BitFieldEOfHL::
    ld a, e
    or a
    jr z, .skip
    cp $01
    jr z, .skip2
    cp $02
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
    and $03
    ret

SECTION "Bank 05 GetSlotSpeciesFamily", ROMX

; A = battle slot: copies its monster id (wBattleMonsterId) to wSpeciesIdLo/Hi and returns A = the
; family, byte 0 of wSpeciesRecord after LoadSpeciesFamily; BC kept. FoeOfFamilyEPresent uses it.
; (C2, E-0375)
; A = battle slot: A = the family (byte 0 of the species record) of the monster id in
; wBattleMonsterId[slot] (LoadSpeciesFamily); BC kept (E-0069)
GetSlotSpeciesFamily:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld hl, wBattleMonsterId
    add a
    add_a_to_hl
    ld a, [hli]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    push bc
    farcall LoadSpeciesFamily
    pop bc
    ld a, [wSpeciesRecord]
    ret

SECTION "Bank 05 FindLowestFoeDEF", ROMX

; Finds the lowest DEF among the present foes, in hTemp0/hTemp1. (C2, E-0357; probed E-0375)
FindLowestFoeDEF:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03
    xor a
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
    sub l
    ldh a, [hTemp1]
    sbc h
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

SECTION "Bank 05 SlotIsBlinded", ROMX

; C = slot: Z clear when the slot is blinded: when BSTAT1_BLINDED is set in its wBattleStatus1 byte
; (A is then not meaningful), otherwise A = its wBattleStatus5 byte & 3 (BSTAT5_RADIANT_BLIND,
; BSTAT5_SANDSTORM_BLIND) with Z set only when both are clear. HL is left at the byte read; BC and
; DE are kept. PassIfFoeAverageATKAtMostTwiceAllyDEF leaves the foes that give NZ out of its ATK
; average. The old note named the bytes status 0 and status 4; they are status bytes 1 and 5. (C2,
; E-0375)
; slot C: returns NZ when bit 1 of status byte 0 is set, otherwise A = status byte 4 & 3 with flags
; from it (E-0122)
SlotIsBlinded:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, c
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_BLINDED, [hl]
    jr nz, .return
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and $03

.return:
    ret

SECTION "Bank 05 CountSkillsInList", ROMX

; A = slot: A = how many of its 8 skills (the even bytes of wBattleSkills + 16 * slot) are
; SKILL_BLAZEMOST, SKILL_FIREBOLT, SKILL_EXPLODET, SKILL_INFERMOST, SKILL_THORDAIN, SKILL_BLIZZARD,
; SKILL_BEAT or SKILL_DEFEAT ($03, $06, $09, $0C, $0F, $12, $13, $14), with Z set when there are
; none; BC kept, HL past the list. FailIfFoeKnowsSkillList and a second check in this bank use it to
; ask whether a foe knows one of these skills. (C2, E-0375)
; A = how many of slot A's eight skills are $03, $06, $09, $0C, $0F, $12, $13 or $14 (Z set when
; none); BC kept (E-0175) (E-0344: the address in its name dropped or read as the label there; was
; CountSkillsInList)
CountSkillsInList::
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    push bc
    ld bc, $0800

.loop:
    ld a, [hli]
    cp $03
    jr z, .next
    cp $06
    jr z, .next
    cp $09
    jr z, .next
    cp $0c
    jr z, .next
    cp $0f
    jr z, .next
    cp $12
    jr z, .next
    cp $13
    jr z, .next
    cp $14
    jr z, .next
    jr .next2

.next:
    inc c

.next2:
    inc hl
    dec b
    jr nz, .loop
    ld a, c
    or a
    pop bc
    ret

SECTION "Bank 05 CountSkillsInList_2", ROMX

; A = slot: A = how many of its 8 skills (even bytes of wBattleSkills + 16 * slot) are the ids
; CountSkillsInList counts or SKILL_SACRIFICE, SKILL_MEGAMAGIC, SKILL_BIGBANG or SKILL_HELLBLAST
; ($15, $3D-$3F), with Z set when there are none; BC kept. No caller names it in src/ (the listing
; places it after a terminator), so whether it runs is not known. (C2, E-0375)
; A = how many of slot A's skills are $03, $06, $09, $0C, $0F, $12-$15 or $3D-$3F (E-0125) (E-0344:
; the address in its name dropped or read as the label there; was CountSkillsInList_2)
CountSkillsInList_2:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    push bc
    ld bc, $0800

.loop:
    ld a, [hli]
    cp $03
    jr z, .next
    cp $06
    jr z, .next
    cp $09
    jr z, .next
    cp $0c
    jr z, .next
    cp $0f
    jr z, .next
    cp $12
    jr z, .next
    cp $13
    jr z, .next
    cp $14
    jr z, .next
    cp $15
    jr z, .next
    cp $3d
    jr z, .next
    cp $3e
    jr z, .next
    cp $3f
    jr z, .next
    jr .next2

.next:
    inc c

.next2:
    inc hl
    dec b
    jr nz, .loop
    ld a, c
    or a
    pop bc
    ret

SECTION "Bank 05 CountSkillsInRanges", ROMX

; A = slot: A = how many of its 8 skills (even bytes of wBattleSkills + 16 * slot) are SKILL_HEAL to
; SKILL_CURSEOFF ($16-$24), SKILL_LIFEDANCE, SKILL_HUSTLE, SKILL_SURGE, SKILL_MEDITATE or
; SKILL_LIFESONG, with Z set when there are none; 0 and $FF entries are skipped; BC kept. No caller
; names it in src/, so whether it runs is not known. (C2, E-0375)
; A = how many of slot A's skills are $16-$24, $7B-$7C, $81 or $9F-$A0 (E-0125) (E-0344: the address
; in its name dropped or read as the label there; was CountSkillsInRanges)
CountSkillsInRanges:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    push bc
    ld bc, $0800

.loop:
    ld a, [hli]
    or a
    jr z, .next2
    cp $ff
    jr z, .next2
    cp $16
    jr c, .next2
    cp $25
    jr c, .next
    cp $7b
    jr c, .next2
    cp $7d
    jr c, .next
    cp $81
    jr z, .next
    cp $9f
    jr c, .next2
    cp $a1
    jr nc, .next2

.next:
    inc c

.next2:
    inc hl
    dec b
    jr nz, .loop
    ld a, c
    pop bc
    or a
    ret

SECTION "Bank 05 CountSkills16To1AOr1ETo20", ROMX

; A = slot: A = how many of the first 8 bytes at wBattleSkills + 16 * slot are $16-$1A (SKILL_HEAL
; to SKILL_HEALUSALL) or $1E-$20 (SKILL_VIVIFY, SKILL_REVIVE, SKILL_FAREWELL); BC kept, flags not
; set from the count. Unlike its neighbours it does not skip the odd bytes, so it reads skills 0-3
; and the byte after each, and never skills 4-7 (a likely slip). No caller names it in src/, so
; whether it runs is not known. (C2, E-0375)
; A = how many of slot A's eight skills are $16-$1A or $1E-$20 (E-0124)
CountSkills16To1AOr1ETo20:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    push bc
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld bc, $0800

.loop:
    ld a, [hli]
    cp $16
    jr c, .next2
    cp $1b
    jr c, .next
    cp $1e
    jr c, .next2
    cp $21
    jr nc, .next2

.next:
    inc c

.next2:
    dec b
    jr nz, .loop
    ld a, c
    pop bc
    ret

SECTION "Bank 05 AverageAGLOfSideA", ROMX

; A = first slot of a side (0 or 4): HL = the sum of the AGL words (wBattleAGL) of the present slots
; among A, A + 1 and A + 2, divided by how many are present (DivideHLByA, A = the remainder). The
; 16-bit sum is kept in hTemp1-hTemp2 and the count in hTemp0. With no slot present it divides by 0,
; which gives HL = $FFFF. AllyAverageAGLAtLeastFoes compares the two sides with it. (C2, E-0375)
; HL = the average AGL of the occupied slots A, A + 1, A + 2 (E-0124)
AverageAGLOfSideA::
    ld c, a
    ld b, $03
    xor a
    ldh [hTemp0], a
    ldh [hTemp1], a
    ldh [hTemp2], a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    call GetBattleAGL_Bank05
    ldh a, [hTemp1]
    add l
    ldh [hTemp1], a
    ldh a, [hTemp2]
    adc h
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

SECTION "Bank 05 CountActiveStatusEffectsOfSlotC", ROMX

; C = slot: D = how many of these are set in its 9-byte status record (wBattleStatus + 9 * slot),
; counted with IncrementD: status byte 1 bits 2-5 (BSTAT1_ATK_DOUBLED, CRITICAL, DRAGON_FORM,
; TRANSFORMED); byte 2 bits 0-3, 5 and 6 (TAKE_MAGIC, BOUNCE, DAMAGE_HALVED, AQUA_WALL, MAGIC_BACK,
; WIND_GUARD); the byte 5 SideStep field ($0C) and Ironize field ($C0), one each; byte 6
; BSTAT6_STATS_RAISED; byte 8 BSTAT8_MAGIC_WALL. At most 14. HL ends at byte 8; BC kept.
; PassIfSkill83OrNoAllyHasStatus fails when an ally has any of them. The old note named bytes 0, 1,
; 4, 5 and 7 and 16 flags; the bytes are 1, 2, 5, 6 and 8 and the count is 14. (C2, E-0375)
; D = the number of set status bits and fields in slot C's 9-byte wBattleStatus1 record (checks 16
; flags across bytes 0, 1, 4, 5 and 7) (E-0121)
CountActiveStatusEffectsOfSlotC::
    ld a, c
    ld d, $00
    ld hl, wBattleStatus1
    call AddAx9ToHL
    bit BSTAT1_ATK_DOUBLED, [hl]
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
    and $0c
    call nz, IncrementD
    ld a, [hl]
    and $c0
    call nz, IncrementD
    inc hl
    bit 6, [hl]
    call nz, IncrementD
    inc hl
    inc hl
    bit 6, [hl]
    call nz, IncrementD
    ret

SECTION "Bank 05 IncrementD", ROMX

; D += 1 (8 bits: Z set when it wraps to 0; carry kept). CountActiveStatusEffectsOfSlotC calls it
; with call nz for each status bit it counts. (C2, E-0375)
; D += 1 (E-0072)
IncrementD::
    inc d
    ret

SECTION "Bank 05 CountSkillsWithFlag6", ROMX

; A = slot: walks its 8 skill entries (byte pairs at wBattleSkills + 16 * slot) and, for each skill
; number other than $FF, loads byte 5 of its skill record into hTemp2 (LoadSkillRecordPart with
; wBattleArg0-3 = 5, 1, hTemp2) and adds 1 to D. E counts the skills whose second byte (the odd byte
; after the skill number) has bit 6 set: it tests bit 6 of [HL], not of the record byte it loaded.
; Returns D = the count of non-$FF entries, E = that count; wRecordBuffer = the last entry read; BC
; kept. No caller names it in src/. (C2, E-0375)
; D = how many of slot A's skills were read, E = how many have bit 6 set in record byte 5 (E-0125)
CountSkillsWithFlag6:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    push bc
    ld de, $0000
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld a, $05
    ld [wBattleArg0], a
    ld a, $01
    ld [wBattleArg1], a
    ld a, $c8
    ld [wBattleArg2], a
    ld a, $ff
    ld [wBattleArg3], a
    ld b, $08

.loop:
    push bc
    ld a, [hli]
    ld [wRecordBuffer], a
    cp $ff
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

SECTION "Bank 05 CountSkillsBelow16Or2ETo34Except31", ROMX

; C = slot: A = how many of its 8 skills (even bytes of wBattleSkills + 16 * slot) are $01-$15
; (SKILL_BLAZE to SKILL_SACRIFICE) or $2E-$34 except $31 (SKILL_SURROUND, SKILL_SLEEP,
; SKILL_SLEEPALL, SKILL_ROBMAGIC, SKILL_STOPSPELL, SKILL_PANICALL; not SKILL_TAKEMAGIC), with Z set
; when there are none; 0 and $FF are skipped; BC kept. No caller names it in src/. (C2, E-0375)
; A = how many of slot C's skills are $01-$15 or $2E-$34 except $31 (flags set from A) (E-0124)
CountSkillsBelow16Or2ETo34Except31:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    push bc
    ld a, c
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld bc, $0800

.loop:
    ld a, [hli]
    cp $ff
    jr z, .next2
    or a
    jr z, .next2
    cp $16
    jr c, .next
    cp $2e
    jr c, .next2
    cp $31
    jr z, .next2
    cp $35
    jr nc, .next2

.next:
    inc c

.next2:
    inc hl
    dec b
    jr nz, .loop
    ld a, c
    pop bc
    or a
    ret

SECTION "Bank 05 CountSlotSkills40To47", ROMX

; A = slot: A = how many of its 8 skills (every other byte of wBattleSkills + 16 * slot) are $40-$47
; (SKILL_FIREAIR to SKILL_WHITEAIR), with Z set when there are none; BC kept. No caller names it in
; src/. (C2, E-0375)
; A = battle slot: counts the skills numbered $40-$47 among the slot's 8 skills (every other byte of
; wBattleSkills + 16 * slot): A = the count, Z set when there are none; BC kept (E-0094)
CountSlotSkills40To47:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    push bc
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld bc, $0800

.loop:
    ld a, [hli]
    cp $40
    jr c, .next
    cp $48
    jr nc, .next
    inc c

.next:
    inc hl
    dec b
    jr nz, .loop
    ld a, c
    or a
    pop bc
    ret

SECTION "Bank 05 CountSkillsInRanges_2", ROMX

; A = slot: A = how many of its 8 skills (even bytes of wBattleSkills + 16 * slot) are $01-$15
; (SKILL_BLAZE to SKILL_SACRIFICE), $40-$67 (SKILL_FIREAIR to SKILL_GIGASLASH), $6A-$70
; (SKILL_HIGHJUMP to SKILL_KAMIKAZE), $8B-$93 (SKILL_LUSHLICKS to SKILL_MOUTHSHUT) or $AA
; (SKILL_AHHH_AA), with Z set when there are none; 0 and $FF skipped; BC kept. No caller names it in
; src/. (C2, E-0375)
; A = how many of slot A's skills are $01-$15, $40-$67, $6A-$70, $8B-$93 or $AA (E-0125) (E-0344:
; the address in its name dropped or read as the label there; was CountSkillsInRanges_2)
CountSkillsInRanges_2:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    push bc
    ld hl, wBattleSkills
    swap a
    add_a_to_hl
    ld bc, $0800

.loop:
    ld a, [hli]
    or a
    jr z, .next2
    cp $ff
    jr z, .next2
    cp $16
    jr c, .next
    cp $40
    jr c, .next2
    cp $68
    jr c, .next
    cp $6a
    jr c, .next2
    cp $71
    jr c, .next
    cp $8b
    jr c, .next2
    cp $94
    jr c, .next
    cp $aa
    jr nz, .next2

.next:
    inc c

.next2:
    inc hl
    dec b
    jr nz, .loop
    ld a, c
    or a
    pop bc
    ret

SECTION "Bank 05 ReadByteAtHLPlus4APlus3C_Bank05", ROMX

; A = [HL + 4 * A + 3 * C], the offset computed in 8 bits (it wraps above $FF) and then added to HL
; with carry; HL is left at the byte read; BC and DE kept. The bank $05 callers pass A = C = slot,
; so it reads byte n of the 7-byte wSlotResistances record of that slot (HL = wSlotResistances + n).
; The same 11 bytes appear in 2 banks. (C2, E-0375)
; A = [HL + 4 * A + 3 * C], the offset computed in 8 bits; clobbers HL (the same 11 bytes appear in
; 2 banks)
ReadByteAtHLPlus4APlus3C_Bank05::
    add a
    add c
    add a
    add c
    add_a_to_hl
    ld a, [hl]
    ret

SECTION "Bank 05 AnyFoeNotFullyResistant_Data", ROMX

; Twenty-seven (byte offset, field) pairs, indexed by the resistance number RESIST_* (the resistance
; class minus 1): the byte offset 0-6 inside the seven-byte record of a battle slot in
; wSlotResistances and the 2-bit field 0-3 in it (field 0 is bits 1-0 ... field 3 is bits 7-6). For
; example RESIST_BLAZE gives (0, 2), RESIST_VACUUM gives (1, 3) and RESIST_WATERSHOT gives (0, 3).
; AnyFoeNotFullyResistant, PassIfFoesAverageResistanceAtLeast2, FailIfSkillHasResistanceClass and
; AIScore_Ramming_LastFoeHPAndResist read the pair and then the field with Get2BitFieldEOfHL. (C1,
; E-0381)
AnyFoeNotFullyResistant_Data::
    db $00, $02, $00, $01, $00, $00, $01, $03, $01, $02, $01, $01, $01, $00, $02, $03
    db $02, $02, $02, $01, $02, $00, $03, $03, $03, $02, $03, $01, $03, $00, $04, $03
    db $04, $02, $04, $01, $04, $00, $05, $03, $05, $02, $05, $01, $05, $00, $06, $03
    db $06, $02, $06, $01, $00, $03

; A = first slot, B = slot count, HL = one status byte of slot 0 (wBattleStatus + n), E = mask: C =
; $FF at the first present slot (CarryUnlessBattleSlotOutSlotEmpty) whose byte HL + 9 * slot has no
; bit of E set; C = 0 when every present slot has one, or none is present. HL and DE kept; B counts
; down. The AI checks for a foe or an ally that lacks a status bit call it. (C2, E-0375)
; A = first slot, B = slot count, HL = a status field (wBattleStatus + n), E = mask: C = $FF when
; some present slot in the range has (HL + 9 * slot) & E clear; C = 0 when every slot is absent or
; has a masked bit set (E-0071)
AnySlotLacksStatusMask::
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
    and e
    and a
    jr z, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 AnySlotHasStatusMask", ROMX

; A = first slot, B = slot count, HL = one status byte of slot 0, E = mask: C = $FF at the first
; present slot whose byte HL + 9 * slot has a bit of E set; C = 0 when none does (the opposite test
; to AnySlotLacksStatusMask). HL and DE kept. Used by the Antidote, DeChaos, NumbOff and CurseOff
; conditions on the actor side. (C2, E-0375)
; A = first slot, B = slot count, HL = a status field (wBattleStatus + n), E = mask: C = $FF when
; some present slot in the range has (HL + 9 * slot) & E non-zero, else C = 0 (the opposite test to
; AnySlotLacksStatusMask) (E-0100)
AnySlotHasStatusMask:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
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
    and e
    and a
    jr nz, .done

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $00
    ret

.done:
    ld c, $ff
    ret

SECTION "Bank 05 FoeOfFamilyEPresent", ROMX

; E = family (0 Slime, 1 Dragon, 2 Beast, 3 Bird, 4 Plant, 5 Bug, 6 Devil, 7 Zombie, 8 Material, 9
; Water, as LoadSpeciesFamily reads them): C = 0 when one of the three present slots opposite
; wBattleActor has a monster of that family (GetSlotSpeciesFamily), else C = $FF. The SlimeBlow to
; AquaCut conditions use it through their *FoePresent helpers. (C2, E-0375)
; E = family: C = 0 when one of the actor's three opposite slots is present and its species family
; (GetSlotSpeciesFamily) equals E; otherwise C = $FF (E-0092)
FoeOfFamilyEPresent:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, [wBattleActor]
    and $04
    xor $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    push de
    call GetSlotSpeciesFamily
    pop de
    cp e
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
    ld c, $ff
    ret

SECTION "Bank 05 CompareMPWithThreeQuartersMax", ROMX

; C = slot: compares its MP (wBattleMP) with (3 * max MP) / 4 (wBattleMaxMP, shifted right twice
; with sra, so a product of $8000 or more would go negative): carry when MP is below it, Z when
; equal. BC kept; HL = MP. AnyAllyMPAtMostThreeQuarters passes on carry or Z. (C2, E-0375)
; C = slot: compares its MP with 3/4 of its max MP: carry when below; BC kept (E-0120)
CompareMPWithThreeQuartersMax:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
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

SECTION "Bank 05 ScaleHLToFourFifths", ROMX

; HL = (HL / 5) * 4, the quotient rounded down before the multiply (DivideHLByA; A = the remainder);
; BC and DE kept. FailIfFoeHPAtMostFourFifthsAIDamageEstimates scales each present foe word in
; wAIDamageEstimates with it before comparing it with that foe HP. (C2, E-0375)
; HL = (HL / 5) * 4; BC and DE kept (E-0117)
ScaleHLToFourFifths::
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

SECTION "Bank 05 TestRecordBufferData1", ROMX

; A = wRecordBufferData + $1, byte 1 of the loaded skill record (the resistance index
; AnyFoeNotFullyResistant reads), with Z set when it is 0. AIGateFoeStatus2Mask22 and
; AIScore_FireAir_WindGuardCheck then compare it with 3. (C2, E-0375)
; A = wRecordBufferData + $1, Z set when it is zero (E-0114) (E-0340: the address in its name read
; as its RAM name; was TestRecordBufferData1)
TestRecordBufferData1::
    ld a, [wRecordBufferData + $1]
    or a
    ret

SECTION "Bank 05 ReadActorResistanceFieldForSkillA", ROMX

; A = resistance index (1-27), C = slot: looks up the pair at AnyFoeNotFullyResistant_Data + 2 * (A
; - 1) (D = byte in the record, E = 2-bit field), then returns A = that field (Get2BitFieldEOfHL) of
; the byte at wSlotResistances + 4 * wBattleActor + 3 * C + D (8-bit sum), always with Z clear. With
; C = the actor this is the actor own resistance. No caller names it in src/. (C2, E-0375)
; reads the 2-bit field selected by AnyFoeNotFullyResistant_Data[A - 1] from the actor's
; wSlotResistances record into A, with NZ (E-0124)
ReadActorResistanceFieldForSkillA:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    dec a
    ld hl, AnyFoeNotFullyResistant_Data
    add a
    add_a_to_hl
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, [wBattleActor]
    ld hl, wSlotResistances
    add a
    add c
    add a
    add c
    add d
    add_a_to_hl
    call Get2BitFieldEOfHL
    ld e, a
    ld a, $01
    or a
    ld a, e
    ret

SECTION "Bank 05 AIScore_Kamikaze_CheckSkills", ROMX

; C = slot, B = how many skill entries to read: scans skill numbers at every other byte from
; wBattleSkills + 256 * C (it loads D = C, E = 0 and adds DE, where 16 * C was likely meant) and
; returns A = 0 with Z when one is $16-$1A (SKILL_HEAL to SKILL_HEALUSALL), SKILL_HUSTLE or
; SKILL_LOVERAIN; A = 1 with NZ at an $FF entry or after B entries. It counts down B (E = 8 is
; loaded but unused), which is the slot counter of its caller AIScore_Kamikaze_HealerAllyAndFoeHP,
; and leaves B changed. (C2, E-0375)
; scans the slot's eight wBattleSkills entries: 0 when one is $16-$1A, $7C or $A1
AIScore_Kamikaze_CheckSkills:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld e, $00
    ld d, c
    ld hl, wBattleSkills
    add hl, de
    ld e, $08

.loop:
    ld a, [hli]
    cp $ff
    jr z, .done
    cp $16
    jr c, .next
    cp $1b
    jr c, .return_0
    cp $7c
    jr z, .return_0
    cp $a1
    jr z, .return_0

.next:
    inc hl
    dec b
    jr nz, .loop

.done:
    ld a, $01
    or a
    ret

.return_0:
    xor a
    ret

SECTION "Bank 05 AIScore_Fight_Conditions", ROMX

; The conditions of AIScore_Fight (which returns at once when C = 0): runs
; AnyFoeLacksStatus3And4Bits; when it gives C = 0 it resets the skill score (ResetAISkillScore:
; wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned. Otherwise it returns the C of
; AnyFoeLacksStatus3And4Bits, with the score unchanged. So Fight is scored only while some present
; foe has neither status 3 & $C0 (BSTAT3_AIRBORNE field) nor status 4 & $0C (BSTAT4_HIGH_JUMP field)
; set. There is no MP or usability check. (C2, E-0375)
; the conditions of AIScore_Fight: calls AnyFoeLacksStatus3And4Bits, ResetAISkillScore in turn and
; tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore)
; (E-0279)
AIScore_Fight_Conditions::
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIFireSkillUsable", ROMX

; Usability check of AIScore_Blaze and AIScore_Firebal (both return at once when C = 0): runs
; ActorCanPayMPCost_Bank05, SkillPassesStatus1Bit0Check, SkillPassesSideFlagBit3Check,
; SkillPassesRepeatCheck, AnyFoeLacksStatus2Mask22, AnyFoeLacksStatus5Bits67, AnyFoeLacksStatus2Bit3
; and AnyFoeNotFullyResistant in turn; the first that gives C = 0 resets the skill score
; (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned. When all
; pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; usable when the MP, status-1, side-flag and repeat checks pass, a foe lacks status 2 mask $22,
; status 5 bits 6-7 and status 2 bit 3, and AnyFoeNotFullyResistant passes; otherwise resets
; wAISkillScore (E-0125)
AIFireSkillUsable:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesStatus1Bit0Check
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesSideFlagBit3Check
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus2Mask22
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus2Bit3
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotFullyResistant
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_Beat_Conditions", ROMX

; The conditions of AIScore_Beat (which returns at once when C = 0): runs ActorCanPayMPCost_Bank05,
; SkillPassesStatus1Bit0Check, SkillPassesSideFlagBit3Check, SkillPassesRepeatCheck,
; AnyFoeLacksStatus2Mask22, AnyFoeLacksStatus5Bits67, AnyFoeNotFullyResistant and
; CheckBattleKindNot2Or3 in turn; the first that gives C = 0 resets the skill score
; (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned. When all
; pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; the conditions of AIScore_Beat: calls ActorCanPayMPCost_Bank05, SkillPassesStatus1Bit0Check,
; SkillPassesSideFlagBit3Check in turn and tests C after each (zero: stop; the failing branch resets
; the score with ResetAISkillScore) (E-0279)
AIScore_Beat_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesStatus1Bit0Check
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesSideFlagBit3Check
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus2Mask22
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotFullyResistant
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    farcall CheckBattleKindNot2Or3
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_Sacrifice_Conditions", ROMX

; The conditions of AIScore_Sacrifice: calls ActorCanPayMPCost_Bank05, SkillPassesStatus1Bit0Check,
; SkillPassesSideFlagBit3Check, SkillPassesRepeatCheck, AnyFoeLacksStatus2Mask22,
; AnyFoeLacksStatus5Bits67, AnyFoeLacksStatus0Bit6, AnyFoeNotFullyResistant, AIGateFoeStatus2Mask22
; (a result of 1 also passes), CheckSide0FlagNot1 and CheckBattleKindNot2Or3 in turn; the first that
; gives C = 0 resets the skill's score (ResetAISkillScore). AIScore_Sacrifice returns at once when
; it gives 0. (C2, E-0369; probed E-0375)
AIScore_Sacrifice_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesStatus1Bit0Check
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesSideFlagBit3Check
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus2Mask22
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotFullyResistant
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIGateFoeStatus2Mask22
    ld a, c
    cp $01
    jr z, .call_check_side0_flag_not1
    and a
    jr z, .call_reset_ai_skill_score

.call_check_side0_flag_not1:
    call CheckSide0FlagNot1
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call CheckBattleKindNot2Or3
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIHealUsable", ROMX

; Usability check of AIScore_Heal and AIScore_HealUs (both return at once when C = 0): runs
; ActorCanPayMPCost_Bank05, SkillPassesStatus1Bit0Check, SkillPassesSideFlagBit3Check,
; SkillPassesRepeatCheck and AnyAllyHPBelow in turn; the first that gives C = 0 resets the skill
; score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned. When
; all pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; usable when the actor can pay the MP cost and the status-1, side-flag, repeat and AnyAllyHPBelow
; checks pass; otherwise resets wAISkillScore (E-0124)
AIHealUsable:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesStatus1Bit0Check
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesSideFlagBit3Check
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyAllyHPBelow
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_MPass_Conditions", ROMX

; The conditions of AIScore_MPass: resets the skill's score (ResetAISkillScore) when C is already 0
; on entry, then when ActorLacksStatus4Bits67 or AllOtherAlliesHaveStatus0Bit6 gives 0; the next
; step, SetCToZero, always gives 0, so every path resets the score and
; AIScore_MPass_AnyAllyMPAboveMax is never reached. (C2, E-0369; probed E-0375)
AIScore_MPass_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call ActorLacksStatus4Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SetCToZero
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_MPass_AnyAllyMPAboveMax
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_Vivify_Conditions", ROMX

; The conditions of AIScore_Vivify (which returns at once when C = 0): runs
; CheckSkillUsableStatusElseResetAISkillScore and AnyOwnSideSlotOutIs1 in turn; the first that gives
; C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C
; = 0 is returned (CheckSkillUsableStatusElseResetAISkillScore resets the score itself and the
; routine then returns at once). When all pass it returns the C of the last check, with the score
; unchanged. So it passes only when an ally slot of the actor side is out (wBattleSlotOut = 1), a
; monster to revive. (C2, E-0375)
; the conditions of AIScore_Vivify: calls CheckSkillUsableStatusElseResetAISkillScore,
; AnyOwnSideSlotOutIs1 in turn and tests C after each (zero: stop; the failing branch resets the
; score with ResetAISkillScore) (E-0279)
AIScore_Vivify_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AnyOwnSideSlotOutIs1
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_Farewell_Conditions", ROMX

; The conditions of AIScore_Farewell (which returns at once when C = 0): runs
; CheckSkillUsableStatusElseResetAISkillScore, AnyFoeLacksStatus0Bit6, AnyOwnSideSlotOutIs1 and
; CheckSide0FlagNot1 in turn; the first that gives C = 0 resets the skill score (ResetAISkillScore:
; wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned
; (CheckSkillUsableStatusElseResetAISkillScore resets the score itself and the routine then returns
; at once). When all pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; the conditions of AIScore_Farewell: calls CheckSkillUsableStatusElseResetAISkillScore,
; AnyFoeLacksStatus0Bit6, AnyOwnSideSlotOutIs1 in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_Farewell_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyOwnSideSlotOutIs1
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call CheckSide0FlagNot1
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_Antidote_Conditions", ROMX

; The conditions of AIScore_Antidote (which returns at once when C = 0): runs
; CheckSkillUsableStatusElseResetAISkillScore and AIScore_Antidote_Conditions_AllyPoisoned in turn;
; the first that gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0,
; wAISkillScore2 = $FFFF) and C = 0 is returned (CheckSkillUsableStatusElseResetAISkillScore resets
; the score itself and the routine then returns at once). When all pass it returns C = $FF. So it
; passes only when a present slot of the actor side (the actor included) is poisoned (status 0 &
; $03, BSTAT0_POISONED or BADLY_POISONED); the reset path returns C = 0 explicitly. (C2, E-0375)
; the conditions of AIScore_Antidote: calls CheckSkillUsableStatusElseResetAISkillScore,
; AIScore_Antidote_Sub01_AnySlotHasStatusMask in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_Antidote_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_Antidote_Conditions_AllyPoisoned
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

SECTION "Bank 05 AIScore_DeChaos_Conditions", ROMX

; The conditions of AIScore_DeChaos (which returns at once when C = 0): runs
; CheckSkillUsableStatusElseResetAISkillScore and AIScore_DeChaos_Conditions_AllyConfused in turn;
; the first that gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0,
; wAISkillScore2 = $FFFF) and C = 0 is returned (CheckSkillUsableStatusElseResetAISkillScore resets
; the score itself and the routine then returns at once). When all pass it returns C = $FF. So it
; passes only when a present slot of the actor side (the actor included) is confused
; (BSTAT0_CONFUSED); the reset path returns C = 0 explicitly. (C2, E-0375)
; the conditions of AIScore_DeChaos: calls CheckSkillUsableStatusElseResetAISkillScore,
; AIScore_DeChaos_Sub01_AnySlotHasStatusMask in turn and tests C after each (zero: stop; the failing
; branch resets the score with ResetAISkillScore) (E-0279)
AIScore_DeChaos_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_DeChaos_Conditions_AllyConfused
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

SECTION "Bank 05 AIScore_NumbOff_Conditions", ROMX

; The conditions of AIScore_NumbOff (which returns at once when C = 0): runs
; CheckSkillUsableStatusElseResetAISkillScore and AIScore_NumbOff_Conditions_AllyParalyzedOrAsleep
; in turn; the first that gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0,
; wAISkillScore2 = $FFFF) and C = 0 is returned (CheckSkillUsableStatusElseResetAISkillScore resets
; the score itself and the routine then returns at once). When all pass it returns C = $FF. So it
; passes only when a present slot of the actor side (the actor included) has status 0 & $CC
; (BSTAT0_PARALYZED, BSTAT0_ASLEEP or the sleep counter); the reset path returns C = 0 explicitly.
; (C2, E-0375)
; the conditions of AIScore_NumbOff: calls CheckSkillUsableStatusElseResetAISkillScore,
; AIScore_NumbOff_Sub01_AnySlotHasStatusMask in turn and tests C after each (zero: stop; the failing
; branch resets the score with ResetAISkillScore) (E-0279)
AIScore_NumbOff_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_NumbOff_Conditions_AllyParalyzedOrAsleep
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

SECTION "Bank 05 AIScore_CurseOff_Conditions", ROMX

; The conditions of AIScore_CurseOff (which returns at once when C = 0): runs
; CheckSkillUsableStatusElseResetAISkillScore and AIScore_CurseOff_Conditions_AllyCursed in turn;
; the first that gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0,
; wAISkillScore2 = $FFFF) and C = 0 is returned (CheckSkillUsableStatusElseResetAISkillScore resets
; the score itself and the routine then returns at once). When all pass it returns C = $FF. So it
; passes only when a present slot of the actor side (the actor included) is cursed (BSTAT0_CURSED);
; the reset path returns C = 0 explicitly. (C2, E-0375)
; the conditions of AIScore_CurseOff: calls CheckSkillUsableStatusElseResetAISkillScore,
; AIScore_CurseOff_Sub01_AnySlotHasStatusMask in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_CurseOff_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_CurseOff_Conditions_AllyCursed
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

SECTION "Bank 05 AIScore_Upper_Conditions", ROMX

; The conditions of AIScore_Upper (which returns at once when C = 0): runs
; CheckSkillUsableStatusElseResetAISkillScore, AnyFoeNotBlocked and
; AIScore_Upper_Conditions_AnyAllyRaisable in turn; the first that gives C = 0 resets the skill
; score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned
; (CheckSkillUsableStatusElseResetAISkillScore resets the score itself and the routine then returns
; at once). When all pass it returns the C of the last check, with the score unchanged. The last
; check passes when a present ally DEF can still be raised (below 999 and below a multiple of its
; base DEF). (C2, E-0375)
; the conditions of AIScore_Upper: calls CheckSkillUsableStatusElseResetAISkillScore,
; AnyFoeNotBlocked, AIScore_Upper_Sub01_Sub01 in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_Upper_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AnyFoeNotBlocked
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_Upper_Conditions_AnyAllyRaisable
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_Sap_Conditions", ROMX

; The conditions of AIScore_Sap (which returns at once when C = 0): runs
; AIUsableAndFoeLacksStatus2And5 and AIScore_Sap_Conditions_AnyFoeSappable in turn; the first that
; gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF)
; and C = 0 is returned (AIUsableAndFoeLacksStatus2And5 resets the score itself and the routine then
; returns at once). When all pass it returns the C of the last check, with the score unchanged. (C2,
; E-0375)
; the conditions of AIScore_Sap: calls AIUsableAndFoeLacksStatus2And5, AIScore_Sap_Sub01_Sub01 in
; turn and tests C after each (zero: stop; the failing branch resets the score with
; ResetAISkillScore) (E-0279)
AIScore_Sap_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AIUsableAndFoeLacksStatus2And5
    ld a, c
    and a
    ret z
    call AIScore_Sap_Conditions_AnyFoeSappable
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIUsableAndFoeLacksStatus2And5", ROMX

; Usability check of the Sap, Slow, Surround, Sleep and StopSpell conditions and AIPanicAllUsable:
; runs CheckSkillUsableStatusElseResetAISkillScore, AnyFoeLacksStatus2Mask22 and
; AnyFoeLacksStatus5Bits67 in turn; the first that gives C = 0 resets the skill score
; (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned
; (CheckSkillUsableStatusElseResetAISkillScore resets the score itself and the routine then returns
; at once). When all pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; usable only when the skill is usable and a foe lacks status 2 mask $22 and a foe lacks status 5
; bits 6-7; otherwise resets wAISkillScore (E-0122)
AIUsableAndFoeLacksStatus2And5::
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AnyFoeLacksStatus2Mask22
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_Speed_Conditions", ROMX

; The conditions of AIScore_Speed (which returns at once when C = 0): runs
; CheckSkillUsableStatusElseResetAISkillScore, AnyFoeNotBlocked and
; AIScore_Speed_Conditions_AnyAllyRaisable in turn; the first that gives C = 0 resets the skill
; score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned
; (CheckSkillUsableStatusElseResetAISkillScore resets the score itself and the routine then returns
; at once). When all pass it returns the C of the last check, with the score unchanged. The last
; check passes when a present ally AGL can still be raised (below 999 and below a multiple of its
; base AGL). (C2, E-0375)
; the conditions of AIScore_Speed: calls CheckSkillUsableStatusElseResetAISkillScore,
; AnyFoeNotBlocked, AIScore_Speed_Sub01_Sub01 in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_Speed_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AnyFoeNotBlocked
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_Speed_Conditions_AnyAllyRaisable
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_Slow_Conditions", ROMX

; The conditions of AIScore_Slow (which returns at once when C = 0): runs
; AIUsableAndFoeLacksStatus2And5, AnyFoeNotBlocked and AIScore_Slow_Conditions_AnyFoeSlowable in
; turn; the first that gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0,
; wAISkillScore2 = $FFFF) and C = 0 is returned (AIUsableAndFoeLacksStatus2And5 resets the score
; itself and the routine then returns at once). When all pass it returns the C of the last check,
; with the score unchanged. (C2, E-0375)
; the conditions of AIScore_Slow: calls AIUsableAndFoeLacksStatus2And5, AnyFoeNotBlocked,
; AIScore_Slow_Sub01_Sub01 in turn and tests C after each (zero: stop; the failing branch resets the
; score with ResetAISkillScore) (E-0279)
AIScore_Slow_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AIUsableAndFoeLacksStatus2And5
    ld a, c
    and a
    ret z
    call AnyFoeNotBlocked
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_Slow_Conditions_AnyFoeSlowable
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_TwinHits_Conditions", ROMX

; TwinHits AI conditions: the usual usability checks, then an ally lacking status 1 bits 2-3 and
; status 4 bits 0-1; otherwise the score is reset. (C2, E-0357; probed E-0375)
AIScore_TwinHits_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AnyAllyLacksStatus1Bits23And4Bits01
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_Surround_Conditions", ROMX

; The conditions of AIScore_Surround (which returns at once when C = 0): runs
; AIUsableAndFoeLacksStatus2And5, AnyFoeLacksStatus5Bits01And1Bit1, AnyFoeNotBlocked and
; AnyFoeOpenToSlotResistances1Field0 in turn; the first that gives C = 0 resets the skill score
; (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned
; (AIUsableAndFoeLacksStatus2And5 resets the score itself and the routine then returns at once).
; When all pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; the conditions of AIScore_Surround: calls AIUsableAndFoeLacksStatus2And5,
; AnyFoeLacksStatus5Bits01And1Bit1, AnyFoeNotBlocked in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_Surround_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AIUsableAndFoeLacksStatus2And5
    ld a, c
    and a
    ret z
    call AnyFoeLacksStatus5Bits01And1Bit1
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotBlocked
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeOpenToSlotResistances1Field0
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_Sleep_Conditions", ROMX

; The conditions of AIScore_Sleep (which returns at once when C = 0): runs
; AIUsableAndFoeLacksStatus2And5, AnyFoeLacksStatus0MaskCC and AnyFoeOpenToSlotResistances2Field3 in
; turn; the first that gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0,
; wAISkillScore2 = $FFFF) and C = 0 is returned (AIUsableAndFoeLacksStatus2And5 resets the score
; itself and the routine then returns at once). When all pass it returns the C of the last check,
; with the score unchanged. (C2, E-0375)
; the conditions of AIScore_Sleep: calls AIUsableAndFoeLacksStatus2And5, AnyFoeLacksStatus0MaskCC,
; AnyFoeOpenToSlotResistances2Field3 in turn and tests C after each (zero: stop; the failing branch
; resets the score with ResetAISkillScore) (E-0279)
AIScore_Sleep_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AIUsableAndFoeLacksStatus2And5
    ld a, c
    and a
    ret z
    call AnyFoeLacksStatus0MaskCC
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeOpenToSlotResistances2Field3
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_TakeMagic_Conditions", ROMX

; The conditions of AIScore_TakeMagic (which returns at once when C = 0): runs
; CheckSkillUsableStatusElseResetAISkillScore, AIScore_TakeMagic_Conditions_FoeHasTakeableSkill,
; AnyFoeLacksStatus0Bit6, ActorLacksStatus4Bits67 and AIScore_TakeMagic_Conditions_NotYetSet in
; turn; the first that gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0,
; wAISkillScore2 = $FFFF) and C = 0 is returned (CheckSkillUsableStatusElseResetAISkillScore resets
; the score itself and the routine then returns at once). C = 1 from
; AIScore_TakeMagic_Conditions_FoeHasTakeableSkill (an AI mode that skips the check) also passes.
; When all pass it returns the C of the last check, with the score unchanged. The last check fails
; when the actor already has BSTAT2_TAKE_MAGIC. (C2, E-0375)
; the conditions of AIScore_TakeMagic: calls CheckSkillUsableStatusElseResetAISkillScore,
; AIScore_TakeMagic_Sub01_Sub01 in turn and tests C after each (zero: stop; the failing branch
; resets the score with ResetAISkillScore) (E-0279)
AIScore_TakeMagic_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_TakeMagic_Conditions_FoeHasTakeableSkill
    ld a, c
    cp $01
    jr z, .call_any_foe_lacks_status0_bit6
    and a
    jr z, .call_reset_ai_skill_score

.call_any_foe_lacks_status0_bit6:
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call ActorLacksStatus4Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_TakeMagic_Conditions_NotYetSet
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_RobMagic_Conditions", ROMX

; The conditions of AIScore_RobMagic (which returns at once when C = 0): runs
; CheckSkillUsableStatusElseResetAISkillScore, AnyFoeHasMPReadsWrongOffset,
; AnyFoeWithMPOpenToSlotResistances2Field1 and ActorMPBelowThreeQuarters in turn; the first that
; gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF)
; and C = 0 is returned (CheckSkillUsableStatusElseResetAISkillScore resets the score itself and the
; routine then returns at once). When all pass it returns the C of the last check, with the score
; unchanged. ActorMPBelowThreeQuarters is reached with farcall although it is in this bank. (C2,
; E-0375)
; the conditions of AIScore_RobMagic: calls CheckSkillUsableStatusElseResetAISkillScore,
; AnyFoeHasMPReadsWrongOffset, AnyFoeWithMPOpenToSlotResistances2Field1 in turn and tests C after
; each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_RobMagic_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AnyFoeHasMPReadsWrongOffset
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeWithMPOpenToSlotResistances2Field1
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    farcall ActorMPBelowThreeQuarters
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_StopSpell_Conditions", ROMX

; The conditions of AIScore_StopSpell (which returns at once when C = 0): runs
; AIUsableAndFoeLacksStatus2And5, AnyFoeLacksStatus0Bit6, AnyActiveFoeHasSkillFlag40,
; AnyFoeLacksStatus1Bit0 and AIScore_StopSpell_Conditions_AnyFoeSealable in turn; the first that
; gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF)
; and C = 0 is returned (AIUsableAndFoeLacksStatus2And5 resets the score itself and the routine then
; returns at once). C = 1 from AnyActiveFoeHasSkillFlag40 (an AI mode that skips the check) also
; passes. When all pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; the conditions of AIScore_StopSpell: calls AIUsableAndFoeLacksStatus2And5, AnyFoeLacksStatus0Bit6,
; AnyActiveFoeHasSkillFlag40 in turn and tests C after each (zero: stop; the failing branch resets
; the score with ResetAISkillScore) (E-0279)
AIScore_StopSpell_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AIUsableAndFoeLacksStatus2And5
    ld a, c
    and a
    ret z
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyActiveFoeHasSkillFlag40
    ld a, c
    cp $01
    jr z, .call_any_foe_lacks_status1_bit0
    and a
    jr z, .call_reset_ai_skill_score

.call_any_foe_lacks_status1_bit0:
    call AnyFoeLacksStatus1Bit0
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_StopSpell_Conditions_AnyFoeSealable
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIPanicAllUsable", ROMX

; Usability check of AIScore_PanicAll and AIScore_PanicAll_2 (both return at once when C = 0): runs
; AIUsableAndFoeLacksStatus2And5, AnyFoeLacksStatus0Bit6, AnyFoeNotFullyResistant,
; AnyFoeLacksStatus0Bit4 and AnyFoeVulnerableBySlotResistances3Bits67 in turn; the first that gives
; C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C
; = 0 is returned (AIUsableAndFoeLacksStatus2And5 resets the score itself and the routine then
; returns at once). When all pass it returns the C of the last check, with the score unchanged. (C2,
; E-0375)
; usable when AIUsableAndFoeLacksStatus2And5, a foe lacks status 0 bit 6, AnyFoeNotFullyResistant, a
; foe lacks status 0 bit 4 and AnyFoeVulnerableBySlotResistances3Bits67 pass; otherwise resets
; wAISkillScore (E-0124)
AIPanicAllUsable:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AIUsableAndFoeLacksStatus2And5
    ld a, c
    and a
    ret z
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotFullyResistant
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus0Bit4
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeVulnerableBySlotResistances3Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIIronizeUsable", ROMX

; Usability check of AIScore_Ironize and AIScore_Ironize_2 (both return at once when C = 0): runs
; CheckSkillUsableStatusElseResetAISkillScore, AnyFoeLacksStatus5Bits67, AnyFoeLacksStatus0Bit6,
; AnyFoeNotBlocked, ActorLacksStatus4Bits67, CheckLoneFoeHPNotBelowAIDamageEstimates,
; CheckAIFlagSetModeGated and AllyCheckSide0FlagAndOtherSlots in turn; the first that gives C = 0
; resets the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is
; returned (CheckSkillUsableStatusElseResetAISkillScore resets the score itself and the routine then
; returns at once). C = 1 from CheckAIFlagSetModeGated (an AI mode that skips the check) also
; passes. When all pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; usable when the skill is usable and the foe, block, actor-status, lone-foe HP, wAIFlag and ally
; checks pass; otherwise resets wAISkillScore (E-0125)
AIIronizeUsable:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotBlocked
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call ActorLacksStatus4Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call CheckAIFlagSetModeGated
    ld a, c
    cp $01
    jr z, .call_ally_check_side0_flag_and_other_slots
    and a
    jr z, .call_reset_ai_skill_score

.call_ally_check_side0_flag_and_other_slots:
    call AllyCheckSide0FlagAndOtherSlots
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_MagicBack_Conditions", ROMX

; The conditions of AIScore_MagicBack (which returns at once when C = 0): runs
; CheckSkillUsableStatusElseResetAISkillScore, AnyFoeLacksStatus0Bit6, AnyActiveFoeHasSkillFlag40,
; AnyFoeNotBlocked, ActorLacksStatus4Bits67, AIScore_MagicBack_Conditions_NotYetSet and
; CheckLinkRules1RuleBit5 in turn; the first that gives C = 0 resets the skill score
; (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned
; (CheckSkillUsableStatusElseResetAISkillScore resets the score itself and the routine then returns
; at once). C = 1 from AnyActiveFoeHasSkillFlag40 (an AI mode that skips the check) also passes.
; When all pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; the conditions of AIScore_MagicBack: calls CheckSkillUsableStatusElseResetAISkillScore,
; AnyFoeLacksStatus0Bit6, AnyActiveFoeHasSkillFlag40 in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_MagicBack_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyActiveFoeHasSkillFlag40
    ld a, c
    cp $01
    jr z, .call_any_foe_not_blocked
    and a
    jr z, .call_reset_ai_skill_score

.call_any_foe_not_blocked:
    call AnyFoeNotBlocked
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call ActorLacksStatus4Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_MagicBack_Conditions_NotYetSet
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call CheckLinkRules1RuleBit5
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_Barrier_Conditions", ROMX

; The conditions of AIScore_Barrier (which returns at once when C = 0): runs
; CheckSkillUsableStatusElseResetAISkillScore, AnyFoeLacksStatus0Bit6, AnyFoeHasSkillFlag10,
; AnyFoeLacksStatus1Bit7, AnyFoeNotBlocked, ActorLacksStatus4Bits67 and AnyAllyLacksStatus2Bit2 in
; turn; the first that gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0,
; wAISkillScore2 = $FFFF) and C = 0 is returned (CheckSkillUsableStatusElseResetAISkillScore resets
; the score itself and the routine then returns at once). C = 1 from AnyFoeHasSkillFlag10 (an AI
; mode that skips the check) also passes. When all pass it returns the C of the last check, with the
; score unchanged. (C2, E-0375)
; the conditions of AIScore_Barrier: calls CheckSkillUsableStatusElseResetAISkillScore,
; AnyFoeLacksStatus0Bit6, AnyFoeHasSkillFlag10 in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_Barrier_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeHasSkillFlag10
    ld a, c
    cp $01
    jr z, .call_any_foe_lacks_status1_bit7
    and a
    jr z, .call_reset_ai_skill_score

.call_any_foe_lacks_status1_bit7:
    call AnyFoeLacksStatus1Bit7
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotBlocked
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call ActorLacksStatus4Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyAllyLacksStatus2Bit2
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_MagicWall_Conditions", ROMX

; The conditions of AIScore_MagicWall (which returns at once when C = 0): runs
; CheckSkillUsableStatusElseResetAISkillScore, AnyFoeLacksStatus0Bit6, AnyActiveFoeHasSkillFlag40,
; AnyFoeLacksStatus1Bit0, AnyFoeNotBlocked, ActorLacksStatus4Bits67 and
; AIScore_MagicWall_Conditions_AllyLacksMagicWall in turn; the first that gives C = 0 resets the
; skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned
; (CheckSkillUsableStatusElseResetAISkillScore resets the score itself and the routine then returns
; at once). C = 1 from AnyActiveFoeHasSkillFlag40 (an AI mode that skips the check) also passes.
; When all pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; the conditions of AIScore_MagicWall: calls CheckSkillUsableStatusElseResetAISkillScore,
; AnyFoeLacksStatus0Bit6, AnyActiveFoeHasSkillFlag40 in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_MagicWall_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyActiveFoeHasSkillFlag40
    ld a, c
    cp $01
    jr z, .call_any_foe_lacks_status1_bit0
    and a
    jr z, .call_reset_ai_skill_score

.call_any_foe_lacks_status1_bit0:
    call AnyFoeLacksStatus1Bit0
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotBlocked
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call ActorLacksStatus4Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_MagicWall_Conditions_AllyLacksMagicWall
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIUsableAndActorLacksStatus4Bits67", ROMX

; Usability check of AIScore_Transform and AIScore_BeDragon (both return at once when C = 0): runs
; CheckSkillUsableStatusElseResetAISkillScore and ActorLacksStatus4Bits67 in turn; the first that
; gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF)
; and C = 0 is returned (CheckSkillUsableStatusElseResetAISkillScore resets the score itself and the
; routine then returns at once). When all pass it returns the C of the last check, with the score
; unchanged. (C2, E-0375)
; usable only when the skill is usable and the actor lacks status 4 bits 6-7; otherwise resets
; wAISkillScore (E-0122)
AIUsableAndActorLacksStatus4Bits67:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableStatusElseResetAISkillScore
    ld a, c
    and a
    ret z
    call ActorLacksStatus4Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 CheckSkillUsableStatusElseResetAISkillScore", ROMX

; The usability check that 17 bank $05 condition routines (Vivify to MagicWall, AIIronizeUsable and
; the other AIUsable* checks) and AIScore_Chance start with: runs ActorCanPayMPCost_Bank05,
; SkillPassesStatus1Bit0Check, SkillPassesSideFlagBit3Check and SkillPassesRepeatCheck in turn; the
; first that gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0,
; wAISkillScore2 = $FFFF) and C = 0 is returned. When all pass it returns the C of the last check,
; with the score unchanged. The four checks: the actor can pay the MP cost; not a spell (record byte
; 5 bit 6) while the actor has BSTAT1_SPELLS_SEALED; not ThickFog or a spell while either side has
; wSideFlags bit 3; not a skill with record byte 8 bit 7 that is already the queued action
; (QueuedActionMatches). (C2, E-0375)
; runs ActorCanPayMPCost_Bank05, SkillPassesStatus1Bit0Check, SkillPassesSideFlagBit3Check and
; SkillPassesRepeatCheck in turn; at the first that returns C = 0 it calls ResetAISkillScore
; (E-0071)
CheckSkillUsableStatusElseResetAISkillScore::
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesStatus1Bit0Check
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesSideFlagBit3Check
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_MegaMagic_Conditions", ROMX

; MegaMagic AI conditions: an attack skill usable, the actor lacks status 4 bits 6-7, and the battle
; is a link battle or of kind 2 or more; otherwise the score is reset. (C2, E-0357; probed E-0375)
AIScore_MegaMagic_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AIAttackSkillUsable
    ld a, c
    and a
    ret z
    call ActorLacksStatus4Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    farcall CheckBattleKindAtLeast2OrLinkModeSet
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIAttackSkillUsable", ROMX

; Usability check of the BigBang, WindBeast and Vacuum scores, the MegaMagic and FireAir conditions
; and AIAndFoeLacksStatus3And4: runs ActorCanPayMPCost_Bank05, SkillPassesRepeatCheck,
; AnyFoeLacksStatus5Bits67, AnyFoeLacksStatus2Bit3 and AnyFoeNotFullyResistant in turn; the first
; that gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 =
; $FFFF) and C = 0 is returned. When all pass it returns the C of the last check, with the score
; unchanged. (C2, E-0375)
; usable when the actor can pay the MP cost, the repeat check passes, a foe lacks status 5 bits 6-7
; and status 2 bit 3, and AnyFoeNotFullyResistant passes; otherwise resets wAISkillScore (E-0124)
; (E-0344: the address in its name dropped or read as the label there; was AIAttackSkillUsable)
AIAttackSkillUsable::
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus2Bit3
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotFullyResistant
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_FireAir_Conditions", ROMX

; The conditions of AIScore_FireAir (which returns at once when C = 0): runs AIAttackSkillUsable,
; SkillPassesStatus1Bit7Check and AIScore_FireAir_Conditions_FoeLacksWindGuard in turn; the first
; that gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 =
; $FFFF) and C = 0 is returned (AIAttackSkillUsable resets the score itself and the routine then
; returns at once). When all pass it returns the C of the last check, with the score unchanged. The
; second check fails when the skill has the breath flag (record byte 5 bit 4) and the actor has
; BSTAT1_BREATH_SEALED; the last passes when a present foe lacks BSTAT2_WIND_GUARD. The earlier note
; called the second a status-0 check; it reads status byte 1. (C2, E-0375)
AIScore_FireAir_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AIAttackSkillUsable
    ld a, c
    and a
    ret z
    call SkillPassesStatus1Bit7Check
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_FireAir_Conditions_FoeLacksWindGuard
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIAndFoeLacksStatus3And4", ROMX

; Usability check of the RockThrow, Watershot, Tidalwave, CallHelp, FireSlash and GigaSlash scores:
; runs AIAttackSkillUsable and AnyFoeLacksStatus3And4Bits in turn; the first that gives C = 0 resets
; the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is
; returned (AIAttackSkillUsable resets the score itself and the routine then returns at once). When
; all pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; usable only when AIAttackSkillUsable passes and a foe lacks the status 3 and 4 bits; otherwise
; resets wAISkillScore (E-0122) (E-0344: the address in its name dropped or read as the label there;
; was AIAndFoeLacksStatus3And4)
AIAndFoeLacksStatus3And4:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AIAttackSkillUsable
    ld a, c
    and a
    ret z
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_SlimeBlow_Conditions", ROMX

; The conditions of AIScore_SlimeBlow (which returns at once when C = 0): runs
; CheckSkillUsableElseResetAISkillScore (which resets the skill score itself; the routine then
; returns at once with C = 0), then AIScore_SlimeBlow_Conditions_SlimeFoePresent, which gives C = 0
; when a present foe is of the Slime family (0, FoeOfFamilyEPresent). The test is inverted: it
; returns C = $FF with the score unchanged when such a foe is present, and otherwise resets the
; skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and returns C = 0. (C2,
; E-0375)
; the conditions of AIScore_SlimeBlow: calls CheckSkillUsableElseResetAISkillScore,
; AIScore_SlimeBlow_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_SlimeBlow_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_SlimeBlow_Conditions_SlimeFoePresent
    ld a, c
    and a
    jr nz, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

SECTION "Bank 05 AIScore_DrakSlash_Conditions", ROMX

; The conditions of AIScore_DrakSlash (which returns at once when C = 0): runs
; CheckSkillUsableElseResetAISkillScore (which resets the skill score itself; the routine then
; returns at once with C = 0), then AIScore_DrakSlash_Conditions_DragonFoePresent, which gives C = 0
; when a present foe is of the Dragon family (1, FoeOfFamilyEPresent). The test is inverted: it
; returns C = $FF with the score unchanged when such a foe is present, and otherwise resets the
; skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and returns C = 0. (C2,
; E-0375)
; the conditions of AIScore_DrakSlash: calls CheckSkillUsableElseResetAISkillScore,
; AIScore_DrakSlash_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_DrakSlash_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_DrakSlash_Conditions_DragonFoePresent
    ld a, c
    and a
    jr nz, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

SECTION "Bank 05 AIScore_BeastCut_Conditions", ROMX

; The conditions of AIScore_BeastCut (which returns at once when C = 0): runs
; CheckSkillUsableElseResetAISkillScore (which resets the skill score itself; the routine then
; returns at once with C = 0), then AIScore_BeastCut_Conditions_BeastFoePresent, which gives C = 0
; when a present foe is of the Beast family (2, FoeOfFamilyEPresent). The test is inverted: it
; returns C = $FF with the score unchanged when such a foe is present, and otherwise resets the
; skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and returns C = 0. (C2,
; E-0375)
; the conditions of AIScore_BeastCut: calls CheckSkillUsableElseResetAISkillScore,
; AIScore_BeastCut_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_BeastCut_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_BeastCut_Conditions_BeastFoePresent
    ld a, c
    and a
    jr nz, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

SECTION "Bank 05 AIScore_BirdBlow_Conditions", ROMX

; The conditions of AIScore_BirdBlow (which returns at once when C = 0): runs
; CheckSkillUsableElseResetAISkillScore (which resets the skill score itself; the routine then
; returns at once with C = 0), then AIScore_BirdBlow_Conditions_BirdFoePresent, which gives C = 0
; when a present foe is of the Bird family (3, FoeOfFamilyEPresent). The test is inverted: it
; returns C = $FF with the score unchanged when such a foe is present, and otherwise resets the
; skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and returns C = 0. (C2,
; E-0375)
; the conditions of AIScore_BirdBlow: calls CheckSkillUsableElseResetAISkillScore,
; AIScore_BirdBlow_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_BirdBlow_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_BirdBlow_Conditions_BirdFoePresent
    ld a, c
    and a
    jr nz, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

SECTION "Bank 05 AIScore_BugBlow_Conditions", ROMX

; The conditions of AIScore_BugBlow (which returns at once when C = 0): runs
; CheckSkillUsableElseResetAISkillScore (which resets the skill score itself; the routine then
; returns at once with C = 0), then AIScore_BugBlow_Conditions_BugFoePresent, which gives C = 0 when
; a present foe is of the Bug family (5, FoeOfFamilyEPresent). The test is inverted: it returns C =
; $FF with the score unchanged when such a foe is present, and otherwise resets the skill score
; (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and returns C = 0. (C2, E-0375)
; the conditions of AIScore_BugBlow: calls CheckSkillUsableElseResetAISkillScore,
; AIScore_BugBlow_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_BugBlow_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_BugBlow_Conditions_BugFoePresent
    ld a, c
    and a
    jr nz, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

SECTION "Bank 05 AIScore_Shears_Conditions", ROMX

; The conditions of AIScore_Shears (which returns at once when C = 0): runs
; CheckSkillUsableElseResetAISkillScore (which resets the skill score itself; the routine then
; returns at once with C = 0), then AIScore_Shears_Conditions_PlantFoePresent, which gives C = 0
; when a present foe is of the Plant family (4, FoeOfFamilyEPresent). The test is inverted: it
; returns C = $FF with the score unchanged when such a foe is present, and otherwise resets the
; skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and returns C = 0. (C2,
; E-0375)
; the conditions of AIScore_Shears: calls CheckSkillUsableElseResetAISkillScore,
; AIScore_Shears_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the failing
; branch resets the score with ResetAISkillScore) (E-0279)
AIScore_Shears_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_Shears_Conditions_PlantFoePresent
    ld a, c
    and a
    jr nz, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

SECTION "Bank 05 AIScore_DevilCut_Conditions", ROMX

; The conditions of AIScore_DevilCut (which returns at once when C = 0): runs
; CheckSkillUsableElseResetAISkillScore (which resets the skill score itself; the routine then
; returns at once with C = 0), then AIScore_DevilCut_Conditions_DevilFoePresent, which gives C = 0
; when a present foe is of the Devil family (6, FoeOfFamilyEPresent). The test is inverted: it
; returns C = $FF with the score unchanged when such a foe is present, and otherwise resets the
; skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and returns C = 0. (C2,
; E-0375)
; the conditions of AIScore_DevilCut: calls CheckSkillUsableElseResetAISkillScore,
; AIScore_DevilCut_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_DevilCut_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_DevilCut_Conditions_DevilFoePresent
    ld a, c
    and a
    jr nz, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

SECTION "Bank 05 AIScore_ZombieCut_Conditions", ROMX

; The conditions of AIScore_ZombieCut (which returns at once when C = 0): runs
; CheckSkillUsableElseResetAISkillScore (which resets the skill score itself; the routine then
; returns at once with C = 0), then AIScore_ZombieCut_Conditions_ZombieFoePresent, which gives C = 0
; when a present foe is of the Zombie family (7, FoeOfFamilyEPresent). The test is inverted: it
; returns C = $FF with the score unchanged when such a foe is present, and otherwise resets the
; skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and returns C = 0. (C2,
; E-0375)
; the conditions of AIScore_ZombieCut: calls CheckSkillUsableElseResetAISkillScore,
; AIScore_ZombieCut_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_ZombieCut_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_ZombieCut_Conditions_ZombieFoePresent
    ld a, c
    and a
    jr nz, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

SECTION "Bank 05 AIScore_CleanCut_Conditions", ROMX

; The conditions of AIScore_CleanCut (which returns at once when C = 0): runs
; CheckSkillUsableElseResetAISkillScore (which resets the skill score itself; the routine then
; returns at once with C = 0), then AIScore_CleanCut_Conditions_MaterialFoePresent, which gives C =
; 0 when a present foe is of the Material family (8, FoeOfFamilyEPresent). The test is inverted: it
; returns C = $FF with the score unchanged when such a foe is present, and otherwise resets the
; skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and returns C = 0. (C2,
; E-0375)
; the conditions of AIScore_CleanCut: calls CheckSkillUsableElseResetAISkillScore,
; AIScore_CleanCut_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_CleanCut_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_CleanCut_Conditions_MaterialFoePresent
    ld a, c
    and a
    jr nz, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

SECTION "Bank 05 AIScore_AquaCut_Conditions", ROMX

; The conditions of AIScore_AquaCut (which returns at once when C = 0): runs
; CheckSkillUsableElseResetAISkillScore (which resets the skill score itself; the routine then
; returns at once with C = 0), then AIScore_AquaCut_Conditions_WaterFoePresent, which gives C = 0
; when a present foe is of the Water family (9, FoeOfFamilyEPresent). The test is inverted: it
; returns C = $FF with the score unchanged when such a foe is present, and otherwise resets the
; skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and returns C = 0. (C2,
; E-0375)
; the conditions of AIScore_AquaCut: calls CheckSkillUsableElseResetAISkillScore,
; AIScore_AquaCut_Sub01_ToFoeOfFamilyEPresent in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_AquaCut_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_AquaCut_Conditions_WaterFoePresent
    ld a, c
    and a
    jr nz, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

SECTION "Bank 05 AIScore_MetalCut_Conditions", ROMX

; The conditions of AIScore_MetalCut (which returns at once when C = 0): runs
; CheckSkillUsableElseResetAISkillScore (which resets the skill score itself; the routine then
; returns at once with C = 0), then AIScore_MetalCut_Conditions_MetalFoePresent, which gives C = 0
; when a present foe has wSlotBodyFlags bit 0 (metal). The test is inverted: it returns C = $FF with
; the score unchanged when a metal foe is present, and otherwise resets the skill score
; (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and returns C = 0. (C2, E-0375)
; the conditions of AIScore_MetalCut: calls CheckSkillUsableElseResetAISkillScore,
; AIScore_MetalCut_Sub01_Sub01 in turn and tests C after each (zero: stop; the failing branch resets
; the score with ResetAISkillScore) (E-0279)
AIScore_MetalCut_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_MetalCut_Conditions_MetalFoePresent
    ld a, c
    and a
    jr nz, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

SECTION "Bank 05 CheckSkillUsableElseResetAISkillScore", ROMX

; The usability check of the SlimeBlow to MetalCut, PoisonHit, SquallHit, BiAttack, RainSlash and
; SandStorm conditions, AIParalyzeUsable, AIScore_EvilSlash and AIScore_Massacre: runs
; ActorCanPayMPCost_Bank05, SkillPassesRepeatCheck, AnyFoeLacksStatus5Bits67, AnyFoeLacksStatus2Bit3
; and AnyFoeLacksStatus3And4Bits in turn; the first that gives C = 0 resets the skill score
; (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned. When all
; pass it returns the C of the last check, with the score unchanged. Unlike
; CheckSkillUsableStatusElseResetAISkillScore it has no spell-seal or side-flag check. (C2, E-0375)
; runs ActorCanPayMPCost_Bank05, SkillPassesRepeatCheck, AnyFoeLacksStatus5Bits67,
; AnyFoeLacksStatus2Bit3 and AnyFoeLacksStatus3And4Bits in turn; at the first that returns C = 0 it
; calls ResetAISkillScore; returns with nothing changed when all pass (E-0071)
CheckSkillUsableElseResetAISkillScore::
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus2Bit3
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_PoisonHit_Conditions", ROMX

; The conditions of AIScore_PoisonHit (which returns at once when C = 0): runs
; CheckSkillUsableElseResetAISkillScore, AnyFoeLacksStatus0Bits01 and
; AnyFoeOpenToSlotResistances4Field0 in turn; the first that gives C = 0 resets the skill score
; (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned
; (CheckSkillUsableElseResetAISkillScore resets the score itself and the routine then returns at
; once). When all pass it returns C = $FF. (C2, E-0375)
; the conditions of AIScore_PoisonHit: calls CheckSkillUsableElseResetAISkillScore,
; AnyFoeLacksStatus0Bits01, AnyFoeOpenToSlotResistances4Field0 in turn and tests C after each (zero:
; stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_PoisonHit_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AnyFoeLacksStatus0Bits01
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeOpenToSlotResistances4Field0
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

SECTION "Bank 05 AIScore_Paralyze_Conditions", ROMX

; The conditions of AIScore_Paralyze (which returns at once when C = 0): runs AIParalyzeUsable and
; AnyFoeOpenToSlotResistances5Field3 in turn; the first that gives C = 0 resets the skill score
; (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned
; (AIParalyzeUsable resets the score itself and the routine then returns at once). When all pass it
; returns C = $FF. (C2, E-0375)
; the conditions of AIScore_Paralyze: calls AIParalyzeUsable, AnyFoeOpenToSlotResistances5Field3 in
; turn and tests C after each (zero: stop; the failing branch resets the score with
; ResetAISkillScore) (E-0279)
AIScore_Paralyze_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AIParalyzeUsable
    ld a, c
    and a
    ret z
    call AnyFoeOpenToSlotResistances5Field3
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

SECTION "Bank 05 AIScore_NapAttack_Conditions", ROMX

; The conditions of AIScore_NapAttack (which returns at once when C = 0): runs AIParalyzeUsable and
; AnyFoeOpenToSlotResistances2Field3 in turn; the first that gives C = 0 resets the skill score
; (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned
; (AIParalyzeUsable resets the score itself and the routine then returns at once). When all pass it
; returns C = $FF. After the second check it tests the flags that check leaves (there is no and a
; after ld a, c); they agree with C, as it returns C = 0 only after its counter reaches 0 (Z) and C
; = $FF only after a jr nz. (C2, E-0375)
; the conditions of AIScore_NapAttack: calls AIParalyzeUsable, AnyFoeOpenToSlotResistances2Field3 in
; turn and tests C after each (zero: stop; the failing branch resets the score with
; ResetAISkillScore) (E-0279)
AIScore_NapAttack_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AIParalyzeUsable
    ld a, c
    and a
    ret z
    call AnyFoeOpenToSlotResistances2Field3
    ld a, c
    jr z, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

SECTION "Bank 05 AIParalyzeUsable", ROMX

; Usability check of the Paralyze and NapAttack conditions: runs
; CheckSkillUsableElseResetAISkillScore, AnyFoeLacksStatus0MaskCC and AnyFoeNotBlocked in turn; the
; first that gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0,
; wAISkillScore2 = $FFFF) and C = 0 is returned (CheckSkillUsableElseResetAISkillScore resets the
; score itself and the routine then returns at once). When all pass it returns C = $FF. (C2, E-0375)
; C = $FF when the skill is usable, a foe lacks status 0 mask $CC and a foe is not blocked;
; otherwise resets wAISkillScore and C = $00 (E-0124)
AIParalyzeUsable::
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AnyFoeLacksStatus0MaskCC
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotBlocked
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

SECTION "Bank 05 AIScore_SquallHit_Conditions", ROMX

; The conditions of AIScore_SquallHit (which returns at once when C = 0): runs
; CheckSkillUsableElseResetAISkillScore, AIScore_SquallHit_Conditions_AnyFoeAGL2,
; FastestFoeAGLAbove31PercentOfActor, PassIfBattleTurnNonZero and CheckAIFlagSetModeGated in turn;
; the first that gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0,
; wAISkillScore2 = $FFFF) and C = 0 is returned (CheckSkillUsableElseResetAISkillScore resets the
; score itself and the routine then returns at once). C = 1 from CheckAIFlagSetModeGated (an AI mode
; that skips the check) also passes. When all pass it returns the C of the last check, with the
; score unchanged. (C2, E-0375)
; the conditions of AIScore_SquallHit: calls CheckSkillUsableElseResetAISkillScore,
; AIScore_SquallHit_Sub01_Sub01, FastestFoeAGLAbove31PercentOfActor in turn and tests C after each
; (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_SquallHit_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_SquallHit_Conditions_AnyFoeAGL2
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call FastestFoeAGLAbove31PercentOfActor
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call PassIfBattleTurnNonZero
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call CheckAIFlagSetModeGated
    ld a, c
    cp $01
    jr z, .return
    and a
    jr z, .call_reset_ai_skill_score

.return:
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_BiAttack_Conditions", ROMX

; BiAttack AI conditions: usable, and the DEF check (AIScore_BiAttack_ATKCheck); otherwise the score
; is reset and C = 0. (C2, E-0357; probed E-0375)
AIScore_BiAttack_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AIScore_BiAttack_ATKCheck
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

SECTION "Bank 05 AIScore_RainSlash_Conditions", ROMX

; The conditions of AIScore_RainSlash (which returns at once when C = 0): runs
; CheckSkillUsableElseResetAISkillScore and AtLeastTwoFoesPresent in turn; the first that gives C =
; 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0
; is returned (CheckSkillUsableElseResetAISkillScore resets the score itself and the routine then
; returns at once). When all pass it returns C = $FF. (C2, E-0375)
; the conditions of AIScore_RainSlash: calls CheckSkillUsableElseResetAISkillScore,
; AtLeastTwoFoesPresent in turn and tests C after each (zero: stop; the failing branch resets the
; score with ResetAISkillScore) (E-0279)
AIScore_RainSlash_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AtLeastTwoFoesPresent
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

SECTION "Bank 05 AIScore_MultiCut_Conditions", ROMX

; The conditions of AIScore_MultiCut (which returns at once when C = 0): runs AIAttackSkillUsable_2
; and AnyFoeNotFullyResistant in turn; the first that gives C = 0 resets the skill score
; (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned
; (AIAttackSkillUsable_2 resets the score itself and the routine then returns at once). When all
; pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; the conditions of AIScore_MultiCut: calls AIAttackSkillUsable_2, AnyFoeNotFullyResistant in turn
; and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore)
; (E-0279)
AIScore_MultiCut_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AIAttackSkillUsable_2
    ld a, c
    and a
    ret z
    call AnyFoeNotFullyResistant
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIAttackSkillUsable_2", ROMX

; Usability check of the MultiCut and HighJump conditions and AIAndPassUnlessRecordBufferData5Bit4:
; runs ActorCanPayMPCost_Bank05, SkillPassesRepeatCheck, AnyFoeLacksStatus5Bits67 and
; AnyFoeLacksStatus2Bit3 in turn; the first that gives C = 0 resets the skill score
; (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned. When all
; pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; usable when the actor can pay the MP cost, the repeat check passes and a foe lacks status 5 bits
; 6-7 and status 2 bit 3; otherwise resets wAISkillScore (E-0124) (E-0344: the address in its name
; dropped or read as the label there; was AIAttackSkillUsable_2)
AIAttackSkillUsable_2::
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus2Bit3
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_ChargeUp_Conditions", ROMX

; The conditions of AIScore_ChargeUp (which returns at once when C = 0): runs
; ActorLacksStatus4Bits67, CheckLoneFoeHPNotBelowAIDamageEstimates,
; ActorLacksStatus1Bits23And4Bits01 and ActorStatus4CheckReadsAddress in turn; the first that gives
; C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C
; = 0 is returned. When all pass it returns the C of the last check, with the score unchanged. There
; is no MP check. The last check (farcall) reads no status byte and passes only for actors in slots
; 0 and 4, so ChargeUp is never scored for an actor in any other slot. (C2, E-0375)
; the conditions of AIScore_ChargeUp: calls ActorLacksStatus4Bits67,
; CheckLoneFoeHPNotBelowAIDamageEstimates, ActorLacksStatus1Bits23And4Bits01 in turn and tests C
; after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_ChargeUp_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorLacksStatus4Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call ActorLacksStatus1Bits23And4Bits01
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    farcall ActorStatus4CheckReadsAddress
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_PsycheUp_Conditions", ROMX

; The conditions of AIScore_PsycheUp (which returns at once when C = 0): runs
; ActorCanPayMPCost_Bank05, AnyFoeLacksStatus5Bits67, AnyFoeLacksStatus2Bit3,
; AnyFoeLacksStatus3And4Bits and ActorLacksStatus4Bits67 in turn; the first that gives C = 0 resets
; the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is
; returned. When all pass it returns the C of the last check, with the score unchanged. There is no
; repeat or spell-seal check. (C2, E-0375)
; the conditions of AIScore_PsycheUp: calls ActorCanPayMPCost_Bank05, AnyFoeLacksStatus5Bits67,
; AnyFoeLacksStatus2Bit3 in turn and tests C after each (zero: stop; the failing branch resets the
; score with ResetAISkillScore) (E-0279)
AIScore_PsycheUp_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus2Bit3
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call ActorLacksStatus4Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_HighJump_Conditions", ROMX

; The conditions of AIScore_HighJump (which returns at once when C = 0): calls
; AIAttackSkillUsable_2, which resets the skill score (ResetAISkillScore: wAISkillScore = 0,
; wAISkillScore2 = $FFFF) when it fails, but its C is not tested; then ActorLacksStatus4Bits67
; decides: C = 0 (and the score reset) when the actor has status 4 & $C0, else C = $FF. So when
; AIAttackSkillUsable_2 fails (for example the MP cost cannot be paid) the score is reset but C =
; $FF still lets AIScore_HighJump go on adding weights (a likely missing ld a, c / and a / ret z).
; (C2, E-0375)
; the conditions of AIScore_HighJump: calls AIAttackSkillUsable_2, ActorLacksStatus4Bits67,
; ResetAISkillScore in turn and tests C after each (zero: stop; the failing branch resets the score
; with ResetAISkillScore) (E-0279)
AIScore_HighJump_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AIAttackSkillUsable_2
    call ActorLacksStatus4Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_TwinSlash_Conditions", ROMX

; The conditions of AIScore_TwinSlash (which returns at once when C = 0): runs
; AIAttackSkillUsable_3, AnyFoeHasDEFAtLeast2 and AllOtherAlliesHaveStatus0Bit6 in turn; the first
; that gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 =
; $FFFF) and C = 0 is returned (AIAttackSkillUsable_3 resets the score itself and the routine then
; returns at once). When all pass it returns the C of the last check, with the score unchanged. (C2,
; E-0375)
; the conditions of AIScore_TwinSlash: calls AIAttackSkillUsable_3, AnyFoeHasDEFAtLeast2,
; AllOtherAlliesHaveStatus0Bit6 in turn and tests C after each (zero: stop; the failing branch
; resets the score with ResetAISkillScore) (E-0279)
AIScore_TwinSlash_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AIAttackSkillUsable_3
    ld a, c
    and a
    ret z
    call AnyFoeHasDEFAtLeast2
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIAttackSkillUsable_3", ROMX

; Usability check of AIScore_Berserker, the TwinSlash conditions and
; AIAndAnyFoeNotFullyResistantAndActorHPNotOne: runs ActorCanPayMPCost_Bank05,
; SkillPassesRepeatCheck, AnyFoeLacksStatus5Bits67, AnyFoeLacksStatus3And4Bits and
; ActorLacksStatus4Bits67 in turn; the first that gives C = 0 resets the skill score
; (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned. When all
; pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; usable when the actor can pay the MP cost, the repeat check passes, a foe lacks status 5 bits 6-7
; and the status 3/4 bits, and the actor lacks status 4 bits 6-7; otherwise resets wAISkillScore
; (E-0124) (E-0344: the address in its name dropped or read as the label there; was
; AIAttackSkillUsable_3)
AIAttackSkillUsable_3::
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call ActorLacksStatus4Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIAndAnyFoeNotFullyResistantAndActorHPNotOne", ROMX

; Usability check of AIScore_Ramming and the Kamikaze conditions: runs AIAttackSkillUsable_3,
; AnyFoeNotFullyResistant and ActorHPIsNotOne in turn; the first that gives C = 0 resets the skill
; score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned
; (AIAttackSkillUsable_3 resets the score itself and the routine then returns at once). When all
; pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; usable only when AIAttackSkillUsable_3 and AnyFoeNotFullyResistant pass and the actor's HP is not
; 1; otherwise resets wAISkillScore (E-0122) (E-0344: the address in its name dropped or read as the
; label there; was AIAndAnyFoeNotFullyResistantAndActorHPNotOne)
AIAndAnyFoeNotFullyResistantAndActorHPNotOne:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AIAttackSkillUsable_3
    ld a, c
    and a
    ret z
    call AnyFoeNotFullyResistant
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call ActorHPIsNotOne
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_Kamikaze_Conditions", ROMX

; The conditions of AIScore_Kamikaze: returns when AIAndAnyFoeNotFullyResistantAndActorHPNotOne
; gives C = 0; then resets the skill's score (ResetAISkillScore) when AnyFoeNotBlocked or
; AllOtherAlliesHaveStatus0Bit6 gives 0 (the latter passes when some other present ally lacks
; BSTAT0_PARALYZED, or none is present). (C2, E-0369; probed E-0375)
AIScore_Kamikaze_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AIAndAnyFoeNotFullyResistantAndActorHPNotOne
    ld a, c
    and a
    ret z
    call AnyFoeNotBlocked
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AllOtherAlliesHaveStatus0Bit6
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_SleepAir_Conditions", ROMX

; The conditions of AIScore_SleepAir (which returns at once when C = 0): runs
; AIAndPassUnlessRecordBufferData5Bit4, AnyFoeLacksStatus0MaskCC and
; AnyFoeOpenToSlotResistances2Field3 in turn; the first that gives C = 0 resets the skill score
; (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned
; (AIAndPassUnlessRecordBufferData5Bit4 resets the score itself and the routine then returns at
; once). When all pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; the conditions of AIScore_SleepAir: calls AIAndPassUnlessRecordBufferData5Bit4,
; AnyFoeLacksStatus0MaskCC, AnyFoeOpenToSlotResistances2Field3 in turn and tests C after each (zero:
; stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_SleepAir_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AIAndPassUnlessRecordBufferData5Bit4
    ld a, c
    and a
    ret z
    call AnyFoeLacksStatus0MaskCC
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeOpenToSlotResistances2Field3
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIAndPassUnlessRecordBufferData5Bit4", ROMX

; Usability check of the SleepAir, PalsyAir, PoisonGas and PoisonAir conditions: runs
; AIAttackSkillUsable_2 and SkillPassesStatus1Bit7Check in turn; the first that gives C = 0 resets
; the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is
; returned (AIAttackSkillUsable_2 resets the score itself and the routine then returns at once).
; When all pass it returns the C of the last check, with the score unchanged. The second check fails
; when the skill has the breath flag (record byte 5 bit 4) and the actor has BSTAT1_BREATH_SEALED.
; (C2, E-0375)
; usable only when AIAttackSkillUsable_2 and SkillPassesStatus1Bit7Check pass; otherwise resets
; wAISkillScore (E-0122) (E-0340: the address in its name read as its RAM name; was
; AIAndPassUnlessRecordBufferData5Bit4) (E-0344: the address in its name dropped or read as the
; label there; was AIAndPassUnlessRecordBufferData5Bit4)
AIAndPassUnlessRecordBufferData5Bit4::
    call AIAttackSkillUsable_2
    ld a, c
    and a
    ret z
    call SkillPassesStatus1Bit7Check
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_PalsyAir_Conditions", ROMX

; The conditions of AIScore_PalsyAir (which returns at once when C = 0): runs
; AIAndPassUnlessRecordBufferData5Bit4, AnyFoeLacksStatus0Bit6, AnyFoeOpenToSlotResistances5Field3
; and CheckBattleKindNot2Or3 in turn; the first that gives C = 0 resets the skill score
; (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned
; (AIAndPassUnlessRecordBufferData5Bit4 resets the score itself and the routine then returns at
; once). When all pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; the conditions of AIScore_PalsyAir: calls AIAndPassUnlessRecordBufferData5Bit4,
; AnyFoeLacksStatus0Bit6, AnyFoeOpenToSlotResistances5Field3 in turn and tests C after each (zero:
; stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_PalsyAir_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AIAndPassUnlessRecordBufferData5Bit4
    ld a, c
    and a
    ret z
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeOpenToSlotResistances5Field3
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    farcall CheckBattleKindNot2Or3
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_PoisonGas_Conditions", ROMX

; The conditions of AIScore_PoisonGas (which returns at once when C = 0): runs
; AIAndPassUnlessRecordBufferData5Bit4, AnyFoeLacksStatus0Bits01 and
; AnyFoeOpenToSlotResistances4Field0 in turn; the first that gives C = 0 resets the skill score
; (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned
; (AIAndPassUnlessRecordBufferData5Bit4 resets the score itself and the routine then returns at
; once). When all pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; the conditions of AIScore_PoisonGas: calls AIAndPassUnlessRecordBufferData5Bit4,
; AnyFoeLacksStatus0Bits01, AnyFoeOpenToSlotResistances4Field0 in turn and tests C after each (zero:
; stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_PoisonGas_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AIAndPassUnlessRecordBufferData5Bit4
    ld a, c
    and a
    ret z
    call AnyFoeLacksStatus0Bits01
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeOpenToSlotResistances4Field0
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_PoisonAir_Conditions", ROMX

; The conditions of AIScore_PoisonAir (which returns at once when C = 0): runs
; AIAndPassUnlessRecordBufferData5Bit4, AIScore_PoisonAir_Conditions_FoeNotBadlyPoisoned and
; AnyFoeOpenToSlotResistances4Field0 in turn; the first that gives C = 0 resets the skill score
; (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned
; (AIAndPassUnlessRecordBufferData5Bit4 resets the score itself and the routine then returns at
; once). When all pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; the conditions of AIScore_PoisonAir: calls AIAndPassUnlessRecordBufferData5Bit4,
; AIScore_PoisonAir_Sub01_AnySlotLacksStatusMask, AnyFoeOpenToSlotResistances4Field0 in turn and
; tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore)
; (E-0279)
AIScore_PoisonAir_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AIAndPassUnlessRecordBufferData5Bit4
    ld a, c
    and a
    ret z
    call AIScore_PoisonAir_Conditions_FoeNotBadlyPoisoned
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeOpenToSlotResistances4Field0
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_Curse_Conditions", ROMX

; The conditions of AIScore_Curse (which returns at once when C = 0): runs ActorCanPayMPCost_Bank05,
; SkillPassesStatus1Bit7Check, SkillPassesRepeatCheck, AnyFoeLacksStatus5Bits67,
; AIScore_Curse_Conditions_AnyFoeCursable and AIScore_Curse_Conditions_FoeNotCursed in turn; the
; first that gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0,
; wAISkillScore2 = $FFFF) and C = 0 is returned. When all pass it returns the C of the last check,
; with the score unchanged. (C2, E-0375)
; the conditions of AIScore_Curse: calls ActorCanPayMPCost_Bank05, SkillPassesStatus1Bit7Check,
; SkillPassesRepeatCheck in turn and tests C after each (zero: stop; the failing branch resets the
; score with ResetAISkillScore) (E-0279)
AIScore_Curse_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesStatus1Bit7Check
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_Curse_Conditions_AnyFoeCursable
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_Curse_Conditions_FoeNotCursed
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_OddDance_Conditions", ROMX

; The conditions of AIScore_OddDance (which returns at once when C = 0): runs AIDanceUsable,
; AnyFoeHasMPReadsWrongOffset, AnyFoeWithMPOpenToSlotResistances2Field1 and
; ActorMPBelowThreeQuarters in turn; the first that gives C = 0 resets the skill score
; (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned
; (AIDanceUsable resets the score itself and the routine then returns at once). When all pass it
; returns C = $FF. (C2, E-0375)
; the conditions of AIScore_OddDance: calls AIDanceUsable, AnyFoeHasMPReadsWrongOffset,
; AnyFoeWithMPOpenToSlotResistances2Field1 in turn and tests C after each (zero: stop; the failing
; branch resets the score with ResetAISkillScore) (E-0279)
AIScore_OddDance_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AIDanceUsable
    ld a, c
    and a
    ret z
    call AnyFoeHasMPReadsWrongOffset
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeWithMPOpenToSlotResistances2Field1
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call ActorMPBelowThreeQuarters
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

SECTION "Bank 05 AIScore_PaniDance_Conditions", ROMX

; The conditions of AIScore_PaniDance (which returns at once when C = 0): runs AIDanceUsable,
; AnyFoeNotFullyResistant, AnyFoeLacksStatus0Bit4 and AnyFoeNotBlocked in turn; the first that gives
; C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C
; = 0 is returned (AIDanceUsable resets the score itself and the routine then returns at once). When
; all pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; the conditions of AIScore_PaniDance: calls AIDanceUsable, AnyFoeNotFullyResistant,
; AnyFoeLacksStatus0Bit4 in turn and tests C after each (zero: stop; the failing branch resets the
; score with ResetAISkillScore) (E-0279)
AIScore_PaniDance_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AIDanceUsable
    ld a, c
    and a
    ret z
    call AnyFoeNotFullyResistant
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus0Bit4
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotBlocked
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIDanceUsable", ROMX

; Usability check of the OddDance, PaniDance, KODance and LureDance conditions: runs
; ActorCanPayMPCost_Bank05, SkillPassesStatus1Bit6Check, SkillPassesRepeatCheck and
; AnyFoeLacksStatus5Bits67 in turn; the first that gives C = 0 resets the skill score
; (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned. When all
; pass it returns the C of the last check, with the score unchanged. The second check fails when the
; skill has the dance flag (record byte 5 bit 5) and the actor has BSTAT1_DANCE_SEALED. (C2, E-0375)
; usable when the actor can pay the MP cost, SkillPassesStatus1Bit6Check and the repeat check pass
; and a foe lacks status 5 bits 6-7; otherwise resets wAISkillScore (E-0124)
AIDanceUsable::
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesStatus1Bit6Check
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_KODance_Conditions", ROMX

; The conditions of AIScore_KODance (which returns at once when C = 0): runs AIDanceUsable and
; AnyFoeNotFullyResistant in turn; the first that gives C = 0 resets the skill score
; (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned
; (AIDanceUsable resets the score itself and the routine then returns at once). When all pass it
; returns the C of the last check, with the score unchanged. (C2, E-0375)
; the conditions of AIScore_KODance: calls AIDanceUsable, AnyFoeNotFullyResistant in turn and tests
; C after each (zero: stop; the failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_KODance_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AIDanceUsable
    ld a, c
    and a
    ret z
    call AnyFoeNotFullyResistant
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_LureDance_Conditions", ROMX

; The conditions of AIScore_LureDance (which returns at once when C = 0): runs AIDanceUsable,
; AnyFoeLacksStatus3And4Bits, AnyFoeNotBlocked, AnyFoeVulnerableBySlotResistances5Bits23 and
; AllyCheckSide0FlagAndOtherSlots in turn; the first that gives C = 0 resets the skill score
; (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned
; (AIDanceUsable resets the score itself and the routine then returns at once). When all pass it
; returns the C of the last check, with the score unchanged. (C2, E-0375)
; the conditions of AIScore_LureDance: calls AIDanceUsable, AnyFoeLacksStatus3And4Bits,
; AnyFoeNotBlocked in turn and tests C after each (zero: stop; the failing branch resets the score
; with ResetAISkillScore) (E-0279)
AIScore_LureDance_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AIDanceUsable
    ld a, c
    and a
    ret z
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotBlocked
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeVulnerableBySlotResistances5Bits23
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AllyCheckSide0FlagAndOtherSlots
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_LifeDance_Conditions", ROMX

; The conditions of AIScore_LifeDance (which returns at once when C = 0): runs
; ActorCanPayMPCost_Bank05, SkillPassesStatus1Bit6Check, SkillPassesRepeatCheck,
; AnyFoeLacksStatus0Bit6, AnyOwnSideSlotOutIs1 and CheckSide0FlagNot1 in turn; the first that gives
; C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C
; = 0 is returned. When all pass it returns the C of the last check, with the score unchanged. (C2,
; E-0375)
; the conditions of AIScore_LifeDance: calls ActorCanPayMPCost_Bank05, SkillPassesStatus1Bit6Check,
; SkillPassesRepeatCheck in turn and tests C after each (zero: stop; the failing branch resets the
; score with ResetAISkillScore) (E-0279)
AIScore_LifeDance_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesStatus1Bit6Check
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyOwnSideSlotOutIs1
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call CheckSide0FlagNot1
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_Hustle_Conditions", ROMX

; The conditions of AIScore_Hustle (which returns at once when C = 0): runs
; ActorCanPayMPCost_Bank05, SkillPassesStatus1Bit6Check, SkillPassesRepeatCheck and AnyAllyHPBelow
; in turn; the first that gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0,
; wAISkillScore2 = $FFFF) and C = 0 is returned. When all pass it returns the C of the last check,
; with the score unchanged. (C2, E-0375)
; the conditions of AIScore_Hustle: calls ActorCanPayMPCost_Bank05, SkillPassesStatus1Bit6Check,
; SkillPassesRepeatCheck in turn and tests C after each (zero: stop; the failing branch resets the
; score with ResetAISkillScore) (E-0279)
AIScore_Hustle_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesStatus1Bit6Check
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyAllyHPBelow
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_SideStep_Conditions", ROMX

; The conditions of AIScore_SideStep (which returns at once when C = 0): runs
; ActorCanPayMPCost_Bank05, SkillPassesStatus1Bit6Check, SkillPassesRepeatCheck, AnyFoeNotBlocked,
; ActorLacksStatus4Bits67 and AIScore_SideStep_Conditions_NotYetSet in turn; the first that gives C
; = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C =
; 0 is returned. When all pass it returns the C of the last check, with the score unchanged. (C2,
; E-0375)
; the conditions of AIScore_SideStep: calls ActorCanPayMPCost_Bank05, SkillPassesStatus1Bit6Check,
; SkillPassesRepeatCheck in turn and tests C after each (zero: stop; the failing branch resets the
; score with ResetAISkillScore) (E-0279)
AIScore_SideStep_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesStatus1Bit6Check
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotBlocked
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call ActorLacksStatus4Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_SideStep_Conditions_NotYetSet
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_SandStorm_Conditions", ROMX

; The conditions of AIScore_SandStorm (which returns at once when C = 0): runs
; CheckSkillUsableElseResetAISkillScore, AnyFoeLacksStatus5Bits01And1Bit1, AnyFoeNotBlocked and
; AnyFoeOpenToSlotResistances1Field0 in turn; the first that gives C = 0 resets the skill score
; (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned
; (CheckSkillUsableElseResetAISkillScore resets the score itself and the routine then returns at
; once). When all pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; the conditions of AIScore_SandStorm: calls CheckSkillUsableElseResetAISkillScore,
; AnyFoeLacksStatus5Bits01And1Bit1, AnyFoeNotBlocked in turn and tests C after each (zero: stop; the
; failing branch resets the score with ResetAISkillScore) (E-0279)
AIScore_SandStorm_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call CheckSkillUsableElseResetAISkillScore
    ld a, c
    and a
    ret z
    call AnyFoeLacksStatus5Bits01And1Bit1
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotBlocked
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeOpenToSlotResistances1Field0
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_Radiant_Conditions", ROMX

; The conditions of AIScore_Radiant (which returns at once when C = 0): runs
; ActorCanPayMPCost_Bank05, AnyFoeLacksStatus5Bits67, AnyFoeLacksStatus5Bits01And1Bit1,
; AnyFoeNotBlocked and AnyFoeOpenToSlotResistances1Field0 in turn; the first that gives C = 0 resets
; the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is
; returned. When all pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; the conditions of AIScore_Radiant: calls ActorCanPayMPCost_Bank05, AnyFoeLacksStatus5Bits67,
; AnyFoeLacksStatus5Bits01And1Bit1 in turn and tests C after each (zero: stop; the failing branch
; resets the score with ResetAISkillScore) (E-0279)
AIScore_Radiant_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits01And1Bit1
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotBlocked
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeOpenToSlotResistances1Field0
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_EerieLite_Conditions", ROMX

; The conditions of AIScore_EerieLite (which returns at once when C = 0): runs
; ActorCanPayMPCost_Bank05, AnyFoeNotFullyResistant and
; AIScore_EerieLite_Conditions_AnyFoeAffectable in turn; the first that gives C = 0 resets the skill
; score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned. When
; all pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; the conditions of AIScore_EerieLite: calls ActorCanPayMPCost_Bank05, AnyFoeNotFullyResistant,
; AIScore_EerieLite_Sub01_Sub01 in turn and tests C after each (zero: stop; the failing branch
; resets the score with ResetAISkillScore) (E-0279)
AIScore_EerieLite_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotFullyResistant
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_EerieLite_Conditions_AnyFoeAffectable
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_Surge_Conditions", ROMX

; The conditions of AIScore_Surge (which returns at once when C = 0): runs ActorCanPayMPCost_Bank05
; and AIScore_Surge_Conditions_AnyAllyToCure in turn; the first that gives C = 0 resets the skill
; score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned. When
; all pass it returns C = $FF. (C2, E-0375)
; the conditions of AIScore_Surge: calls ActorCanPayMPCost_Bank05, AIScore_Surge_Sub01_Sub01 in turn
; and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore)
; (E-0279)
AIScore_Surge_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_Surge_Conditions_AnyAllyToCure
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

SECTION "Bank 05 AIScore_UltraDown_Conditions", ROMX

; The conditions of AIScore_UltraDown (which returns at once when C = 0): runs
; ActorCanPayMPCost_Bank05 and AIScore_UltraDown_Conditions_AnyFoeLowerable in turn; the first that
; gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF)
; and C = 0 is returned. When all pass it returns C = $FF. (C2, E-0375)
; the conditions of AIScore_UltraDown: calls ActorCanPayMPCost_Bank05, AIScore_UltraDown_Sub01_Sub01
; in turn and tests C after each (zero: stop; the failing branch resets the score with
; ResetAISkillScore) (E-0279)
AIScore_UltraDown_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_UltraDown_Conditions_AnyFoeLowerable
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

SECTION "Bank 05 AIScore_DeMagic_Conditions", ROMX

; The conditions of AIScore_DeMagic (which returns at once when C = 0): runs
; ActorCanPayMPCost_Bank05 and AIScore_DeMagic_Conditions_AnyFoeToClear in turn; the first that
; gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF)
; and C = 0 is returned. When all pass it returns C = $FF. AIScore_DeMagic_Conditions_AnyFoeToClear
; passes when a present foe has one of the status bits it tests (status byte 1 & $3C, 2 & $6F, 5 &
; $CC, 6 bit 6 or 8 bit 6), and also when the fourth slot of the actor own side (slot 3 or 7) is in
; play. (C2, E-0375)
; the conditions of AIScore_DeMagic: calls ActorCanPayMPCost_Bank05, AIScore_DeMagic_Sub01_Sub01 in
; turn and tests C after each (zero: stop; the failing branch resets the score with
; ResetAISkillScore) (E-0279)
AIScore_DeMagic_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_DeMagic_Conditions_AnyFoeToClear
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ld c, $ff
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ld c, $00
    ret

SECTION "Bank 05 AIScore_ThickFog_Conditions", ROMX

; The conditions of AIScore_ThickFog (which returns at once when C = 0): runs
; ActorCanPayMPCost_Bank05, SkillPassesSideFlagBit3Check, AnyActiveFoeHasSkillFlag40 and
; AnyFoeHasMPReadsWrongOffset in turn; the first that gives C = 0 resets the skill score
; (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned. C = 1 from
; AnyActiveFoeHasSkillFlag40 (an AI mode that skips the check) also passes. When all pass it returns
; the C of the last check, with the score unchanged. (C2, E-0375)
; the conditions of AIScore_ThickFog: calls ActorCanPayMPCost_Bank05, SkillPassesSideFlagBit3Check,
; AnyActiveFoeHasSkillFlag40 in turn and tests C after each (zero: stop; the failing branch resets
; the score with ResetAISkillScore) (E-0279)
AIScore_ThickFog_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesSideFlagBit3Check
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyActiveFoeHasSkillFlag40
    ld a, c
    cp $01
    jr z, .call_any_foe_has_mp_reads_wrong_offset
    and a
    jr z, .call_reset_ai_skill_score

.call_any_foe_has_mp_reads_wrong_offset:
    call AnyFoeHasMPReadsWrongOffset
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_TatsuCall_Conditions", ROMX

; The conditions of AIScore_TatsuCall (which returns at once when C = 0): runs
; ActorCanPayMPCost_Bank05 and AIScore_TatsuCall_Conditions_FourthSlotFree in turn; the first that
; gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF)
; and C = 0 is returned. When all pass it returns the C of the last check, with the score unchanged.
; (C2, E-0375)
; the conditions of AIScore_TatsuCall: calls ActorCanPayMPCost_Bank05, AIScore_TatsuCall_Sub01_Sub01
; in turn and tests C after each (zero: stop; the failing branch resets the score with
; ResetAISkillScore) (E-0279)
AIScore_TatsuCall_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_TatsuCall_Conditions_FourthSlotFree
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_SuckAir_Conditions", ROMX

; The conditions of AIScore_SuckAir (which returns at once when C = 0): runs
; SkillPassesStatus1Bit7Check, ActorLacksStatus4Bits67,
; AIScore_SuckAir_Conditions_FoeNotAirResistant, ActorLacksStatus4Bits45 and
; AIScore_SuckAir_Conditions_SkillFlagCheck in turn; the first that gives C = 0 resets the skill
; score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned. When
; all pass it returns the C of the last check, with the score unchanged. There is no MP check. (C2,
; E-0375)
; the conditions of AIScore_SuckAir: calls SkillPassesStatus1Bit7Check, ActorLacksStatus4Bits67,
; AIScore_SuckAir_Sub01_Sub01 in turn and tests C after each (zero: stop; the failing branch resets
; the score with ResetAISkillScore) (E-0279)
AIScore_SuckAir_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call SkillPassesStatus1Bit7Check
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call ActorLacksStatus4Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_SuckAir_Conditions_FoeNotAirResistant
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call ActorLacksStatus4Bits45
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_SuckAir_Conditions_SkillFlagCheck
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_Focus_Conditions", ROMX

; The conditions of AIScore_Focus (which returns at once when C = 0): runs ActorLacksStatus4Bits67;
; when it gives C = 0 it resets the skill score (ResetAISkillScore: wAISkillScore = 0,
; wAISkillScore2 = $FFFF) and C = 0 is returned. Otherwise it returns the C of
; ActorLacksStatus4Bits67, with the score unchanged. So Focus is scored only while the actor has no
; status 4 & $C0 (the Focus field); there is no MP check. (C2, E-0375)
; the conditions of AIScore_Focus: calls ActorLacksStatus4Bits67, ResetAISkillScore in turn and
; tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore)
; (E-0279)
AIScore_Focus_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorLacksStatus4Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AILickSkillUsable", ROMX

; Usability check of AIScore_LushLicks, AIScore_Ahhh and the LegSweep conditions: runs
; ActorCanPayMPCost_Bank05, SkillPassesRepeatCheck, AnyFoeLacksStatus5Bits67,
; AnyFoeLacksStatus3And4Bits, AnyFoeHasClearStatus3, AnyFoeVulnerableBySlotResistances5Bits23 and
; AllyCheckSide0FlagAndOtherSlots in turn; the first that gives C = 0 resets the skill score
; (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned. When all
; pass it returns the C of the last check, with the score unchanged. The last check is reached with
; farcall although it is in this bank. (C2, E-0375)
; usable when the MP and repeat checks pass, a foe lacks status 5 bits 6-7 and the 3/4 bits, has
; clear status 3, is vulnerable by wSlotResistances + $5 bits 2-3, and
; AllyCheckSide0FlagAndOtherSlots passes; otherwise resets wAISkillScore (E-0125) (E-0344: the
; address in its name dropped or read as the label there; was AILickSkillUsable)
AILickSkillUsable:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeHasClearStatus3
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeVulnerableBySlotResistances5Bits23
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    farcall AllyCheckSide0FlagAndOtherSlots
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIStatusLickUsable", ROMX

; Usability check of AIScore_SickLick and AIScore_AhhhStatusLick: runs ActorCanPayMPCost_Bank05,
; SkillPassesRepeatCheck, AnyFoeLacksStatus5Bits67, AnyFoeLacksStatus3And4Bits,
; AnyFoeHasClearStatus3 and AnyFoeVulnerableBySlotResistances5Bits23 in turn; the first that gives C
; = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C =
; 0 is returned. When all pass it returns the C of the last check, with the score unchanged. (C2,
; E-0375)
; usable when the actor can pay the MP cost, the repeat check passes, a foe lacks status 5 bits 6-7
; and the status 3/4 bits, a foe has clear status 3, and AnyFoeVulnerableBySlotResistances5Bits23
; passes; otherwise resets wAISkillScore (E-0124)
AIStatusLickUsable:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeHasClearStatus3
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeVulnerableBySlotResistances5Bits23
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_LegSweep_Conditions", ROMX

; The conditions of AIScore_LegSweep (which returns at once when C = 0): runs AILickSkillUsable,
; AIScore_LegSweep_Conditions_AnyFoeTrippable and AllyCheckSide0FlagAndOtherSlots in turn; the first
; that gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 =
; $FFFF) and C = 0 is returned (AILickSkillUsable resets the score itself and the routine then
; returns at once). When all pass it returns the C of the last check, with the score unchanged. (C2,
; E-0375)
; the conditions of AIScore_LegSweep: calls AILickSkillUsable, AIScore_LegSweep_Sub01_Sub01 in turn
; and tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore)
; (E-0279)
AIScore_LegSweep_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AILickSkillUsable
    ld a, c
    and a
    ret z
    call AIScore_LegSweep_Conditions_AnyFoeTrippable
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    farcall AllyCheckSide0FlagAndOtherSlots
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_Geyser_Conditions", ROMX

; The conditions of AIScore_Geyser (which returns at once when C = 0): runs
; ActorCanPayMPCost_Bank05, AnyFoeLacksStatus5Bits67, AnyFoeLacksStatus3And4Bits,
; AnyFoeNotFullyResistant and AnyFoeHasClearStatus3 in turn; the first that gives C = 0 resets the
; skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned.
; When all pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; the conditions of AIScore_Geyser: calls ActorCanPayMPCost_Bank05, AnyFoeLacksStatus5Bits67,
; AnyFoeLacksStatus3And4Bits in turn and tests C after each (zero: stop; the failing branch resets
; the score with ResetAISkillScore) (E-0279)
AIScore_Geyser_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotFullyResistant
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeHasClearStatus3
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_DanceShut_Conditions", ROMX

; The conditions of AIScore_DanceShut (which returns at once when C = 0): runs
; ActorCanPayMPCost_Bank05, SkillPassesStatus1Bit6Check, AnyFoeLacksStatus5Bits67,
; AnyFoeLacksStatus3And4Bits, AIScore_DanceShut_Conditions_UnsealedDancer,
; AIScore_DanceShut_Conditions_FoeNotDanceSealed and AIScore_DanceShut_Conditions_AnyFoeSealable in
; turn; the first that gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0,
; wAISkillScore2 = $FFFF) and C = 0 is returned. C = 1 from
; AIScore_DanceShut_Conditions_UnsealedDancer (an AI mode that skips the check) also passes. When
; all pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; the conditions of AIScore_DanceShut: calls ActorCanPayMPCost_Bank05, SkillPassesStatus1Bit6Check,
; AnyFoeLacksStatus5Bits67 in turn and tests C after each (zero: stop; the failing branch resets the
; score with ResetAISkillScore) (E-0279)
AIScore_DanceShut_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesStatus1Bit6Check
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_DanceShut_Conditions_UnsealedDancer
    ld a, c
    cp $01
    jr z, .call_ai_score_dance_shut_conditions_foe_not
    and a
    jr z, .call_reset_ai_skill_score

.call_ai_score_dance_shut_conditions_foe_not:
    call AIScore_DanceShut_Conditions_FoeNotDanceSealed
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_DanceShut_Conditions_AnyFoeSealable
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_MouthShut_Conditions", ROMX

; The conditions of AIScore_MouthShut (which returns at once when C = 0): runs
; ActorCanPayMPCost_Bank05, SkillPassesRepeatCheck, AnyFoeLacksStatus5Bits67, AnyFoeLacksStatus1Bit7
; and AnyFoeHasSkillWithFlagD in turn; the first that gives C = 0 resets the skill score
; (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned. When all
; pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; the conditions of AIScore_MouthShut: calls ActorCanPayMPCost_Bank05, SkillPassesRepeatCheck,
; AnyFoeLacksStatus5Bits67 in turn and tests C after each (zero: stop; the failing branch resets the
; score with ResetAISkillScore) (E-0279)
AIScore_MouthShut_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus1Bit7
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeHasSkillWithFlagD
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_StrongD_Conditions", ROMX

; The conditions of AIScore_StrongD (which returns at once when C = 0): when
; AllyCheckSide0FlagAndOtherSlots gives C = 0 it jumps to ResetAISkillScore (score reset:
; wAISkillScore = 0, wAISkillScore2 = $FFFF) and returns C = 0; otherwise it falls through into
; AIScore_DodgeAlternative_Conditions (AIBuffSkillUsable, CheckLoneFoeHPNotBelowAIDamageEstimates,
; CheckAIFlagSetModeGated, PassIfBattleTurnNonZero) and returns its C. (C2, E-0375)
; the conditions of AIScore_StrongD: calls AllyCheckSide0FlagAndOtherSlots, AIBuffSkillUsable in
; turn and tests C after each (zero: stop; the failing branch resets the score with
; ResetAISkillScore) (E-0279)
AIScore_StrongD_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AllyCheckSide0FlagAndOtherSlots
    ld a, c
    and a
    jp z, ResetAISkillScore

; The conditions shared by AIScore_StrongD (it falls through here) and AIScore_Dodge_Conditions
; (which calls it first): runs AIBuffSkillUsable, CheckLoneFoeHPNotBelowAIDamageEstimates,
; CheckAIFlagSetModeGated and PassIfBattleTurnNonZero in turn; the first that gives C = 0 resets the
; skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned
; (AIBuffSkillUsable resets the score itself and the routine then returns at once). C = 1 from
; CheckAIFlagSetModeGated (an AI mode that skips the check) also passes. When all pass it returns
; the C of the last check, with the score unchanged. (C2, E-0375)
; (E-0345: was AIScore_DodgeAlternative_Conditions) the conditions of AIScore_Dodge_Sub01: calls
; AIBuffSkillUsable, CheckLoneFoeHPNotBelowAIDamageEstimates, CheckAIFlagSetModeGated in turn and
; tests C after each (zero: stop; the failing branch resets the score with ResetAISkillScore)
; (E-0279)
AIScore_DodgeAlternative_Conditions::
    call AIBuffSkillUsable
    ld a, c
    and a
    ret z
    call CheckLoneFoeHPNotBelowAIDamageEstimates
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call CheckAIFlagSetModeGated
    ld a, c
    cp $01
    jr z, .call_pass_if_battle_turn_non_zero
    and a
    jr z, .call_reset_ai_skill_score

.call_pass_if_battle_turn_non_zero:
    call PassIfBattleTurnNonZero
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_Dodge_Conditions", ROMX

; The conditions of AIScore_Dodge (which returns at once when C = 0): runs
; AIScore_DodgeAlternative_Conditions and AnyFoeLacksStatus5Bits01And1Bit1 in turn; the first that
; gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF)
; and C = 0 is returned (AIScore_DodgeAlternative_Conditions resets the score itself and the routine
; then returns at once). When all pass it returns the C of the last check, with the score unchanged.
; (C2, E-0375)
; the conditions of AIScore_Dodge: calls AIScore_Dodge_Sub01_Sub01, AnyFoeLacksStatus5Bits01And1Bit1
; in turn and tests C after each (zero: stop; the failing branch resets the score with
; ResetAISkillScore) (E-0279)
AIScore_Dodge_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AIScore_DodgeAlternative_Conditions
    ld a, c
    and a
    ret z
    call AnyFoeLacksStatus5Bits01And1Bit1
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIBuffSkillUsable", ROMX

; Usability check of the TailWind and StormWind conditions, AIGuardSkillUsable and
; AIScore_DodgeAlternative_Conditions: runs ActorCanPayMPCost_Bank05, SkillPassesRepeatCheck,
; AnyFoeLacksStatus5Bits67 and AnyFoeLacksStatus0Bit6 in turn; the first that gives C = 0 resets the
; skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned.
; When all pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; usable when the actor can pay the MP cost, the repeat check passes and a foe lacks status 5 bits
; 6-7 and status 0 bit 6; otherwise resets wAISkillScore (E-0124) (E-0344: the address in its name
; dropped or read as the label there; was AIBuffSkillUsable)
AIBuffSkillUsable::
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIGuardSkillUsable", ROMX

; Usability check of AIScore_BladeD and the Cover conditions: runs AIBuffSkillUsable,
; AnyFoeNotBlocked, CheckAIFlagSetModeGated and PassIfBattleTurnNonZero in turn; the first that
; gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF)
; and C = 0 is returned (AIBuffSkillUsable resets the score itself and the routine then returns at
; once). C = 1 from CheckAIFlagSetModeGated (an AI mode that skips the check) also passes. When all
; pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; AIBuffSkillUsable, a foe not blocked, the gated wAIFlag check and PassIfBattleTurnNonZero;
; otherwise resets wAISkillScore (E-0124) (E-0344: the address in its name dropped or read as the
; label there; was AIGuardSkillUsable)
AIGuardSkillUsable:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AIBuffSkillUsable
    ld a, c
    and a
    ret z
    call AnyFoeNotBlocked
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call CheckAIFlagSetModeGated
    ld a, c
    cp $01
    jr z, .call_pass_if_battle_turn_non_zero
    and a
    jr z, .call_reset_ai_skill_score

.call_pass_if_battle_turn_non_zero:
    call PassIfBattleTurnNonZero
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_Cover_Conditions", ROMX

; The conditions of AIScore_Cover (which returns at once when C = 0): runs AIGuardSkillUsable,
; AllyCheckSide0FlagAndOtherSlots and ActorHPIsNotOne in turn; the first that gives C = 0 resets the
; skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned
; (AIGuardSkillUsable resets the score itself and the routine then returns at once). When all pass
; it returns the C of the last check, with the score unchanged. (C2, E-0375)
; the conditions of AIScore_Cover: calls AIGuardSkillUsable, AllyCheckSide0FlagAndOtherSlots,
; ActorHPIsNotOne in turn and tests C after each (zero: stop; the failing branch resets the score
; with ResetAISkillScore) (E-0279)
AIScore_Cover_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AIGuardSkillUsable
    ld a, c
    and a
    ret z
    call AllyCheckSide0FlagAndOtherSlots
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call ActorHPIsNotOne
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_TailWind_Conditions", ROMX

; The conditions of AIScore_TailWind (which returns at once when C = 0): runs AIBuffSkillUsable,
; AnyFoeNotBlocked, AIScore_TailWind_Conditions_NotYetSet and AnyFoeHasSkillWithFlagD in turn; the
; first that gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0,
; wAISkillScore2 = $FFFF) and C = 0 is returned (AIBuffSkillUsable resets the score itself and the
; routine then returns at once). When all pass it returns the C of the last check, with the score
; unchanged. The third check fails when the actor already has BSTAT2_WIND_GUARD; the last passes
; when a present foe that is not breath-sealed knows a skill with record byte 5 bit 4 (breath). (C2,
; E-0375)
; the conditions of AIScore_TailWind: calls AIBuffSkillUsable, AnyFoeNotBlocked,
; AIScore_TailWind_Sub01_Sub01 in turn and tests C after each (zero: stop; the failing branch resets
; the score with ResetAISkillScore) (E-0279)
AIScore_TailWind_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AIBuffSkillUsable
    ld a, c
    and a
    ret z
    call AnyFoeNotBlocked
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_TailWind_Conditions_NotYetSet
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeHasSkillWithFlagD
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_StormWind_Conditions", ROMX

; The conditions of AIScore_StormWind (which returns at once when C = 0): runs AIBuffSkillUsable,
; AnyFoeNotBlocked, AnyAllyLacksStatus2Bit6 and AnyFoeHasSkillWithFlagD in turn; the first that
; gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF)
; and C = 0 is returned (AIBuffSkillUsable resets the score itself and the routine then returns at
; once). When all pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; the conditions of AIScore_StormWind: calls AIBuffSkillUsable, AnyFoeNotBlocked,
; AnyAllyLacksStatus2Bit6 in turn and tests C after each (zero: stop; the failing branch resets the
; score with ResetAISkillScore) (E-0279)
AIScore_StormWind_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AIBuffSkillUsable
    ld a, c
    and a
    ret z
    call AnyFoeNotBlocked
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyAllyLacksStatus2Bit6
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeHasSkillWithFlagD
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_AquaWall_Conditions", ROMX

; The conditions of AIScore_AquaWall (which returns at once when C = 0): runs
; ActorCanPayMPCost_Bank05, AnyFoeLacksStatus0Bit6, AIScore_AquaWall_Conditions_UnsealedFoeSkill and
; AIScore_AquaWall_Conditions_NotYetSet in turn; the first that gives C = 0 resets the skill score
; (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is returned. C = 1 from
; AIScore_AquaWall_Conditions_UnsealedFoeSkill (an AI mode that skips the check) also passes. When
; all pass it returns the C of the last check, with the score unchanged. (C2, E-0375)
; the conditions of AIScore_AquaWall: calls ActorCanPayMPCost_Bank05, AnyFoeLacksStatus0Bit6,
; AIScore_AquaWall_Sub01_Sub01 in turn and tests C after each (zero: stop; the failing branch resets
; the score with ResetAISkillScore) (E-0279)
AIScore_AquaWall_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_AquaWall_Conditions_UnsealedFoeSkill
    ld a, c
    cp $01
    jr z, .call_ai_score_aqua_wall_conditions_not_yet
    and a
    jr z, .call_reset_ai_skill_score

.call_ai_score_aqua_wall_conditions_not_yet:
    call AIScore_AquaWall_Conditions_NotYetSet
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_SealPray_Conditions", ROMX

; SealPray AI condition: the actor can pay the MP cost; otherwise the score is reset. (C2, E-0357;
; probed E-0375)
AIScore_SealPray_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_SuckAll_Conditions", ROMX

; The conditions of AIScore_SuckAll (which returns at once when C = 0): runs
; ActorCanPayMPCost_Bank05, AnyFoeLacksStatus5Bits67, AnyFoeLacksStatus3And4Bits,
; AnyFoeHasMPReadsWrongOffset, AnyFoeLacksStatus0Bit6, AnyFoeHasSkillFlag10, AnyFoeLacksStatus0Bit4,
; AnyFoeLacksStatus1Bit7, AnyAllyLacksStatus2Bit6, ActorHPIsNotOne, CheckAIFlagSetModeGated,
; ActorLacksStatus4Bits45 and AllyCheckSide0FlagAndOtherSlots in turn; the first that gives C = 0
; resets the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C = 0 is
; returned. C = 1 from AnyFoeHasSkillFlag10 or CheckAIFlagSetModeGated (an AI mode that skips the
; check) also passes. When all pass it returns the C of the last check, with the score unchanged.
; (C2, E-0375)
; the conditions of AIScore_SuckAll: calls ActorCanPayMPCost_Bank05, AnyFoeLacksStatus5Bits67,
; AnyFoeLacksStatus3And4Bits in turn and tests C after each (zero: stop; the failing branch resets
; the score with ResetAISkillScore) (E-0279)
AIScore_SuckAll_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus3And4Bits
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeHasMPReadsWrongOffset
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus0Bit6
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeHasSkillFlag10
    ld a, c
    cp $01
    jr z, .call_any_foe_lacks_status0_bit4
    and a
    jr z, .call_reset_ai_skill_score

.call_any_foe_lacks_status0_bit4:
    call AnyFoeLacksStatus0Bit4
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus1Bit7
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyAllyLacksStatus2Bit6
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call ActorHPIsNotOne
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call CheckAIFlagSetModeGated
    ld a, c
    cp $01
    jr z, .call_actor_lacks_status4_bits45
    and a
    jr z, .call_reset_ai_skill_score

.call_actor_lacks_status4_bits45:
    call ActorLacksStatus4Bits45
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AllyCheckSide0FlagAndOtherSlots
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_Imitate_Conditions", ROMX

; The conditions of AIScore_Imitate (which returns at once when C = 0): runs
; ActorCanPayMPCost_Bank05, SkillPassesRepeatCheck, AnyFoeLacksStatus5Bits67,
; AnyFoeLacksStatus0MaskCC, AnyFoeNotBlocked, CheckAIFlagSetModeGated and PassIfBattleTurnNonZero in
; turn; the first that gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0,
; wAISkillScore2 = $FFFF) and C = 0 is returned. C = 1 from CheckAIFlagSetModeGated (an AI mode that
; skips the check) also passes. When all pass it returns the C of the last check, with the score
; unchanged. (C2, E-0375)
; the conditions of AIScore_Imitate: calls ActorCanPayMPCost_Bank05, SkillPassesRepeatCheck,
; AnyFoeLacksStatus5Bits67 in turn and tests C after each (zero: stop; the failing branch resets the
; score with ResetAISkillScore) (E-0279)
AIScore_Imitate_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus0MaskCC
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotBlocked
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call CheckAIFlagSetModeGated
    ld a, c
    cp $01
    jr z, .call_pass_if_battle_turn_non_zero
    and a
    jr z, .call_reset_ai_skill_score

.call_pass_if_battle_turn_non_zero:
    call PassIfBattleTurnNonZero
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_Meditate_Conditions", ROMX

; The conditions of AIScore_Meditate (which returns at once when C = 0): runs
; ActorCanPayMPCost_Bank05 and AIScore_Meditate_Conditions_HPBelowTwoThirds in turn; the first that
; gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF)
; and C = 0 is returned. When all pass it returns the C of the last check, with the score unchanged.
; (C2, E-0375)
; the conditions of AIScore_Meditate: calls ActorCanPayMPCost_Bank05, AIScore_Meditate_Sub01_Sub01
; in turn and tests C after each (zero: stop; the failing branch resets the score with
; ResetAISkillScore) (E-0279)
AIScore_Meditate_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AIScore_Meditate_Conditions_HPBelowTwoThirds
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_LifeSong_Conditions", ROMX

; The conditions of AIScore_LifeSong (which returns at once when C = 0): runs
; ActorCanPayMPCost_Bank05, AnyOwnSideSlotOutIs1 and CheckSide0FlagNot1 in turn; the first that
; gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF)
; and C = 0 is returned. When all pass it returns the C of the last check, with the score unchanged.
; (C2, E-0375)
; the conditions of AIScore_LifeSong: calls ActorCanPayMPCost_Bank05, AnyOwnSideSlotOutIs1,
; CheckSide0FlagNot1 in turn and tests C after each (zero: stop; the failing branch resets the score
; with ResetAISkillScore) (E-0279)
AIScore_LifeSong_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyOwnSideSlotOutIs1
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call CheckSide0FlagNot1
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_LoveRain_Conditions", ROMX

; The conditions of AIScore_LoveRain (which returns at once when C = 0): runs
; ActorCanPayMPCost_Bank05, SkillPassesRepeatCheck and AnyAllyHPBelow in turn; the first that gives
; C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0, wAISkillScore2 = $FFFF) and C
; = 0 is returned. When all pass it returns the C of the last check, with the score unchanged. (C2,
; E-0375)
; the conditions of AIScore_LoveRain: calls ActorCanPayMPCost_Bank05, SkillPassesRepeatCheck,
; AnyAllyHPBelow in turn and tests C after each (zero: stop; the failing branch resets the score
; with ResetAISkillScore) (E-0279)
AIScore_LoveRain_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call ActorCanPayMPCost_Bank05
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call SkillPassesRepeatCheck
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyAllyHPBelow
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AINeverUsableResetAISkillScore", ROMX

; Usability check of AIScore_Whistle and AIScore_ZoneOut (both return at once when C = 0):
; SetCToZero gives C = 0, so it always resets the skill score (ResetAISkillScore: wAISkillScore = 0,
; wAISkillScore2 = $FFFF) and returns C = 0; the AI never scores these skills. (C2, E-0375)
; C = 0 (SetCToZero) and resets wAISkillScore: the skill is never chosen by the AI (E-0122)
AINeverUsableResetAISkillScore:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call SetCToZero
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret

SECTION "Bank 05 AIScore_Guard_Conditions", ROMX

; The conditions of AIScore_Guard (which returns at once when C = 0): runs AnyFoeLacksStatus5Bits67,
; AnyFoeLacksStatus0MaskCC, AnyFoeNotBlocked, CheckAIFlagSetModeGated and PassIfBattleTurnNonZero in
; turn; the first that gives C = 0 resets the skill score (ResetAISkillScore: wAISkillScore = 0,
; wAISkillScore2 = $FFFF) and C = 0 is returned. C = 1 from CheckAIFlagSetModeGated (an AI mode that
; skips the check) also passes. When all pass it returns the C of the last check, with the score
; unchanged. There is no MP or usability check (Guard is offered on every turn). (C2, E-0375)
; the conditions of AIScore_Guard: calls AnyFoeLacksStatus5Bits67, AnyFoeLacksStatus0MaskCC,
; AnyFoeNotBlocked in turn and tests C after each (zero: stop; the failing branch resets the score
; with ResetAISkillScore) (E-0279)
AIScore_Guard_Conditions:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    call AnyFoeLacksStatus5Bits67
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeLacksStatus0MaskCC
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call AnyFoeNotBlocked
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    call CheckAIFlagSetModeGated
    ld a, c
    cp $01
    jr z, .call_pass_if_battle_turn_non_zero
    and a
    jr z, .call_reset_ai_skill_score

.call_pass_if_battle_turn_non_zero:
    call PassIfBattleTurnNonZero
    ld a, c
    and a
    jr z, .call_reset_ai_skill_score
    ret

.call_reset_ai_skill_score:
    call ResetAISkillScore
    ret
    ds $1ec, $00
